// Borrowing Management JavaScript

let borrowData = null;

async function loadMembers() {
    try {
        const response = await apiCall('members', 'getAll');
        
        if (response.success) {
            const select = document.getElementById('member_id');
            select.innerHTML = '<option value="">-- Select Member --</option>';
            
            response.data.forEach(member => {
                const option = document.createElement('option');
                option.value = member.id;
                option.textContent = `${member.name} (${member.email})`;
                select.appendChild(option);
            });
        }
    } catch (error) {
        console.error('Error loading members:', error);
    }
}

async function loadBooks() {
    try {
        const response = await apiCall('books', 'getAll');
        
        if (response.success) {
            const select = document.getElementById('book_id');
            select.innerHTML = '<option value="">-- Select Book --</option>';
            
            response.data.forEach(book => {
                if (book.available_copies > 0) {
                    const option = document.createElement('option');
                    option.value = book.id;
                    option.textContent = `${book.title} by ${book.author} (${book.available_copies} available)`;
                    select.appendChild(option);
                }
            });
        }
    } catch (error) {
        console.error('Error loading books:', error);
    }
}

async function loadBorrowRecords() {
    try {
        const response = await apiCall('borrowlogs', 'getCurrentBorrows');
        
        if (response.success && response.data.length > 0) {
            let html = '<table>';
            html += '<thead><tr>';
            html += '<th>Member</th><th>Book</th><th>Borrow Date</th><th>Due Date</th><th>Status</th><th>Action</th>';
            html += '</tr></thead><tbody>';

            response.data.forEach(log => {
                const daysLeft = daysBetween(new Date(), log.due_date);
                const statusColor = daysLeft <= 0 ? '#e74c3c' : daysLeft <= 3 ? '#f39c12' : '#27ae60';
                const statusText = daysLeft <= 0 ? 'OVERDUE' : `${daysLeft} days left`;
                
                html += '<tr>';
                html += `<td><strong>${log.member_name}</strong></td>`;
                html += `<td>${log.book_title}</td>`;
                html += `<td>${formatDateDisplay(log.borrow_date)}</td>`;
                html += `<td>${formatDateDisplay(log.due_date)}</td>`;
                html += `<td><span style="color: ${statusColor}; font-weight: bold;">${statusText}</span></td>`;
                html += `<td><button class="btn btn-success btn-small" onclick="openReturnModal(${log.id}, '${log.due_date}')">Return</button></td>`;
                html += '</tr>';
            });

            html += '</tbody></table>';
            document.getElementById('borrowsContainer').innerHTML = html;
        } else {
            document.getElementById('borrowsContainer').innerHTML = '<p style="text-align: center; color: #7f8c8d;">No active borrowing records</p>';
        }
    } catch (error) {
        console.error('Error loading borrow records:', error);
    }
}

async function loadOverdueBooks() {
    try {
        const response = await apiCall('borrowlogs', 'getOverdue');
        
        if (response.success && response.data.length > 0) {
            let html = '<table>';
            html += '<thead><tr>';
            html += '<th style="color: #e74c3c;">Member</th><th>Book</th><th>Due Date</th><th>Days Overdue</th><th>Fine</th><th>Action</th>';
            html += '</tr></thead><tbody>';

            response.data.forEach(log => {
                const daysOverdue = daysBetween(log.due_date, new Date());
                const fine = daysOverdue * 10;
                
                html += `<tr style="background: rgba(231, 76, 60, 0.1);">`;
                html += `<td><strong>${log.member_name}</strong></td>`;
                html += `<td>${log.book_title}</td>`;
                html += `<td>${formatDateDisplay(log.due_date)}</td>`;
                html += `<td><strong style="color: #e74c3c;">${daysOverdue} days</strong></td>`;
                html += `<td><strong>${formatCurrency(fine)}</strong></td>`;
                html += `<td><button class="btn btn-danger btn-small" onclick="openReturnModal(${log.id}, '${log.due_date}')">Return Now</button></td>`;
                html += '</tr>';
            });

            html += '</tbody></table>';
            document.getElementById('overdueContainer').innerHTML = html;
        } else {
            document.getElementById('overdueContainer').innerHTML = '<p style="text-align: center; color: #27ae60;">✓ No overdue books! Great job!</p>';
        }
    } catch (error) {
        console.error('Error loading overdue books:', error);
    }
}

function setDefaultDates() {
    const today = new Date();
    document.getElementById('borrow_date').valueAsDate = today;
    
    // Due date = 14 days from today
    const dueDate = new Date(today);
    dueDate.setDate(dueDate.getDate() + 14);
    document.getElementById('due_date').valueAsDate = dueDate;
}

async function recordBorrow(event) {
    event.preventDefault();

    const memberId = document.getElementById('member_id').value;
    const bookId = document.getElementById('book_id').value;
    const borrowDate = document.getElementById('borrow_date').value;
    const dueDate = document.getElementById('due_date').value;

    if (!memberId || !bookId) {
        showAlert('Please select both a member and a book', 'warning');
        return;
    }

    // Validate dates
    if (new Date(borrowDate) > new Date(dueDate)) {
        showAlert('Due date must be after borrow date', 'warning');
        return;
    }

    try {
        const formData = {
            member_id: parseInt(memberId),
            book_id: parseInt(bookId),
            borrow_date: borrowDate,
            due_date: dueDate
        };

        const response = await apiCall('borrowlogs', 'borrow', 'POST', formData);

        if (response.success) {
            showAlert(response.message, 'success');
            document.getElementById('borrowForm').reset();
            setDefaultDates();
            loadBorrowRecords();
            loadBooks(); // Reload books to update availability
        } else {
            showAlert(response.message || 'Error recording borrow', 'danger');
        }
    } catch (error) {
        console.error('Error recording borrow:', error);
        showAlert('Error recording borrow', 'danger');
    }
}

function openReturnModal(borrowId, dueDate) {
    document.getElementById('returnBorrowId').value = borrowId;
    
    // Set return date to today
    const today = new Date();
    document.getElementById('return_date').valueAsDate = today;
    
    // Calculate fine
    const daysOverdue = Math.max(0, daysBetween(dueDate, today));
    const fine = daysOverdue * 10;
    document.getElementById('fineAmount').value = fine > 0 ? formatCurrency(fine) : 'No fine';
    
    openModal('returnModal');
}

async function submitReturn(event) {
    event.preventDefault();

    const borrowId = document.getElementById('returnBorrowId').value;
    const returnDate = document.getElementById('return_date').value;

    try {
        const url = new URL(`${API_BASE_URL}/borrowlogs.php`);
        url.searchParams.append('action', 'returnBook');
        url.searchParams.append('id', borrowId);

        const response = await fetch(url, {
            method: 'PUT',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ return_date: returnDate })
        });
        const result = await response.json();

        if (result.success) {
            showAlert(result.message, 'success');
            closeModal('returnModal');
            loadBorrowRecords();
            loadOverdueBooks();
            loadBooks(); // Reload books to update availability
        } else {
            showAlert(result.message || 'Error returning book', 'danger');
        }
    } catch (error) {
        console.error('Error returning book:', error);
        showAlert('Error returning book', 'danger');
    }
}

async function loadMemberBorrowHistory() {
    const memberId = document.getElementById('member_id').value;
    if (!memberId) return;

    try {
        const url = new URL(`${API_BASE_URL}/borrowlogs.php`);
        url.searchParams.append('action', 'getByMemberId');
        url.searchParams.append('member_id', memberId);

        const response = await fetch(url);
        const result = await response.json();

        if (result.success && result.data.length > 0) {
            const activeBooks = result.data.filter(log => log.status === 'borrowed');
            console.log(`Member has ${activeBooks.length} active borrows`);
        }
    } catch (error) {
        console.error('Error loading member history:', error);
    }
}

function loadStats() {
    showAlert('Detailed statistics coming soon!', 'info');
}

// Initialize on page load
document.addEventListener('DOMContentLoaded', () => {
    setDefaultDates();
    loadMembers();
    loadBooks();
    loadBorrowRecords();
    loadOverdueBooks();
});
