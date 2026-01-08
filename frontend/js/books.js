// Books Management JavaScript

let allBooks = [];

async function loadBooks() {
    try {
        const response = await apiCall('books', 'getAll');
        
        if (response.success) {
            allBooks = response.data;
            renderBooksTable(allBooks);
        } else {
            showAlert(response.message || 'Error loading books', 'danger');
        }
    } catch (error) {
        console.error('Error loading books:', error);
        showAlert('Error loading books', 'danger');
    }
}

function renderBooksTable(books) {
    if (!books || books.length === 0) {
        document.getElementById('booksContainer').innerHTML = '<p style="text-align: center; color: #7f8c8d;">No books found. <a href="#" onclick="openModal(\'bookModal\')">Add the first book</a></p>';
        return;
    }

    let html = '<table>';
    html += '<thead><tr>';
    html += '<th>ISBN</th><th>Title</th><th>Author</th><th>Category</th><th>Total</th><th>Available</th><th>Status</th><th>Actions</th>';
    html += '</tr></thead><tbody>';

    books.forEach(book => {
        const statusClass = book.status === 'available' ? 'success' : 'danger';
        html += '<tr>';
        html += `<td><small>${book.isbn}</small></td>`;
        html += `<td><strong>${book.title}</strong></td>`;
        html += `<td>${book.author}</td>`;
        html += `<td>${book.category || 'N/A'}</td>`;
        html += `<td>${book.total_copies}</td>`;
        html += `<td><strong style="color: ${book.available_copies > 0 ? '#27ae60' : '#e74c3c'};">${book.available_copies}</strong></td>`;
        html += `<td><span class="alert alert-${statusClass}" style="padding: 3px 8px; font-size: 12px;">${book.status}</span></td>`;
        html += '<td class="action-buttons">';
        html += `<button class="btn btn-primary btn-small" onclick="editBook(${book.id})">Edit</button>`;
        html += `<button class="btn btn-danger btn-small" onclick="deleteBook(${book.id})">Delete</button>`;
        html += '</td>';
        html += '</tr>';
    });

    html += '</tbody></table>';
    document.getElementById('booksContainer').innerHTML = html;
}

async function searchBooks() {
    const keyword = document.getElementById('searchBooks').value.trim();
    
    if (!keyword) {
        showAlert('Please enter a search term', 'warning');
        return;
    }

    try {
        const response = await apiCall('books', 'search', 'GET');
        
        // Manually add keyword to URL
        const url = new URL(`${API_BASE_URL}/books.php`);
        url.searchParams.append('action', 'search');
        url.searchParams.append('keyword', keyword);

        const fetchResponse = await fetch(url);
        const result = await fetchResponse.json();

        if (result.success) {
            renderBooksTable(result.data);
            showAlert(`Found ${result.data.length} book(s)`, 'info');
        } else {
            renderBooksTable([]);
            showAlert('No books found matching your search', 'warning');
        }
    } catch (error) {
        console.error('Error searching books:', error);
        showAlert('Error searching books', 'danger');
    }
}

async function editBook(id) {
    try {
        const response = await apiCall('books', 'getById', 'GET');
        
        // Manually construct URL
        const url = new URL(`${API_BASE_URL}/books.php`);
        url.searchParams.append('action', 'getById');
        url.searchParams.append('id', id);

        const fetchResponse = await fetch(url);
        const result = await fetchResponse.json();

        if (result.success) {
            const book = result.data;
            document.getElementById('bookId').value = book.id;
            document.getElementById('isbn').value = book.isbn;
            document.getElementById('title').value = book.title;
            document.getElementById('author').value = book.author;
            document.getElementById('publisher').value = book.publisher || '';
            document.getElementById('publication_year').value = book.publication_year || '';
            document.getElementById('category').value = book.category || '';
            document.getElementById('total_copies').value = book.total_copies;
            document.getElementById('location_shelf').value = book.location_shelf || '';
            document.getElementById('description').value = book.description || '';
            
            document.getElementById('bookModalTitle').textContent = 'Edit Book';
            openModal('bookModal');
        } else {
            showAlert('Error loading book details', 'danger');
        }
    } catch (error) {
        console.error('Error editing book:', error);
        showAlert('Error loading book details', 'danger');
    }
}

async function saveBook(event) {
    event.preventDefault();

    const bookId = document.getElementById('bookId').value;
    const formData = {
        isbn: document.getElementById('isbn').value,
        title: document.getElementById('title').value,
        author: document.getElementById('author').value,
        publisher: document.getElementById('publisher').value,
        publication_year: parseInt(document.getElementById('publication_year').value) || 0,
        category: document.getElementById('category').value,
        description: document.getElementById('description').value,
        total_copies: parseInt(document.getElementById('total_copies').value),
        location_shelf: document.getElementById('location_shelf').value,
        status: 'available'
    };

    try {
        let response;
        if (bookId) {
            // Update existing book
            const url = new URL(`${API_BASE_URL}/books.php`);
            url.searchParams.append('action', 'update');
            url.searchParams.append('id', bookId);

            const fetchResponse = await fetch(url, {
                method: 'PUT',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(formData)
            });
            response = await fetchResponse.json();
        } else {
            // Add new book
            response = await apiCall('books', 'add', 'POST', formData);
        }

        if (response.success) {
            showAlert(response.message, 'success');
            closeModal('bookModal');
            clearForm('bookForm');
            document.getElementById('bookId').value = '';
            document.getElementById('bookModalTitle').textContent = 'Add New Book';
            loadBooks();
        } else {
            showAlert(response.message || 'Error saving book', 'danger');
        }
    } catch (error) {
        console.error('Error saving book:', error);
        showAlert('Error saving book', 'danger');
    }
}

async function deleteBook(id) {
    if (!confirmDelete('Are you sure you want to delete this book?')) {
        return;
    }

    try {
        const url = new URL(`${API_BASE_URL}/books.php`);
        url.searchParams.append('action', 'delete');
        url.searchParams.append('id', id);

        const response = await fetch(url, {
            method: 'DELETE',
            headers: { 'Content-Type': 'application/json' }
        });
        const result = await response.json();

        if (result.success) {
            showAlert(result.message, 'success');
            loadBooks();
        } else {
            showAlert(result.message || 'Error deleting book', 'danger');
        }
    } catch (error) {
        console.error('Error deleting book:', error);
        showAlert('Error deleting book', 'danger');
    }
}

// Initialize on page load
document.addEventListener('DOMContentLoaded', () => {
    loadBooks();
});

// Reset form when opening modal for new book
document.getElementById('bookModal').addEventListener('show', function() {
    if (!document.getElementById('bookId').value) {
        clearForm('bookForm');
        document.getElementById('bookModalTitle').textContent = 'Add New Book';
    }
});
