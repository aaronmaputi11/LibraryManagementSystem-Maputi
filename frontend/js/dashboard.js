// Dashboard JavaScript

async function loadDashboard() {
    try {
        // Load books stats
        const booksResponse = await apiCall('books', 'stats');
        if (booksResponse.success) {
            document.getElementById('totalBooks').textContent = booksResponse.data.total_books;
        }

        // Load members stats
        const membersResponse = await apiCall('members', 'stats');
        if (membersResponse.success) {
            document.getElementById('totalMembers').textContent = membersResponse.data.total_members;
        }

        // Load borrowing stats
        const borrowsResponse = await apiCall('borrowlogs', 'stats');
        if (borrowsResponse.success) {
            document.getElementById('currentBorrows').textContent = borrowsResponse.data.current_borrows;
            document.getElementById('overdueBooks').textContent = borrowsResponse.data.overdue_count;
        }

        // Load recent borrows
        loadRecentBorrows();
        loadOverdueBooks();
    } catch (error) {
        console.error('Error loading dashboard:', error);
        showAlert('Error loading dashboard data', 'danger');
    }
}

async function loadRecentBorrows() {
    try {
        const response = await apiCall('borrowlogs', 'getCurrentBorrows');
        
        if (response.success && response.data.length > 0) {
            let html = '<table>';
            html += '<thead><tr>';
            html += '<th>Member</th><th>Book</th><th>Borrow Date</th><th>Due Date</th><th>Days Left</th>';
            html += '</tr></thead><tbody>';

            response.data.slice(0, 5).forEach(log => {
                const daysLeft = daysBetween(new Date(), log.due_date);
                const daysColor = daysLeft <= 0 ? '#e74c3c' : daysLeft <= 3 ? '#f39c12' : '#27ae60';
                
                html += '<tr>';
                html += `<td>${log.member_name}</td>`;
                html += `<td>${log.book_title}</td>`;
                html += `<td>${formatDateDisplay(log.borrow_date)}</td>`;
                html += `<td>${formatDateDisplay(log.due_date)}</td>`;
                html += `<td><strong style="color: ${daysColor};">${Math.max(0, daysLeft)} days</strong></td>`;
                html += '</tr>';
            });

            html += '</tbody></table>';
            document.getElementById('recentBorrowsContainer').innerHTML = html;
        } else {
            document.getElementById('recentBorrowsContainer').innerHTML = '<p style="text-align: center; color: #7f8c8d;">No active borrows</p>';
        }
    } catch (error) {
        console.error('Error loading recent borrows:', error);
    }
}

async function loadOverdueBooks() {
    try {
        const response = await apiCall('borrowlogs', 'getOverdue');
        
        if (response.success && response.data.length > 0) {
            let html = '<table>';
            html += '<thead><tr>';
            html += '<th>Member</th><th>Book</th><th>Due Date</th><th>Days Overdue</th><th>Fine</th>';
            html += '</tr></thead><tbody>';

            response.data.forEach(log => {
                const daysOverdue = daysBetween(log.due_date, new Date());
                const fine = daysOverdue * 10; // Rs. 10 per day
                
                html += '<tr>';
                html += `<td><strong>${log.member_name}</strong></td>`;
                html += `<td>${log.book_title}</td>`;
                html += `<td>${formatDateDisplay(log.due_date)}</td>`;
                html += `<td><strong style="color: #e74c3c;">${daysOverdue} days</strong></td>`;
                html += `<td>${formatCurrency(fine)}</td>`;
                html += '</tr>';
            });

            html += '</tbody></table>';
            document.getElementById('overdueContainer').innerHTML = html;
        } else {
            document.getElementById('overdueContainer').innerHTML = '<p style="text-align: center; color: #27ae60;">No overdue books! 🎉</p>';
        }
    } catch (error) {
        console.error('Error loading overdue books:', error);
    }
}

async function loadStats() {
    showAlert('Detailed statistics page coming soon!', 'info');
}

// Initialize dashboard on page load
document.addEventListener('DOMContentLoaded', loadDashboard);
