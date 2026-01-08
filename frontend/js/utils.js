// API Base URL
const API_BASE_URL = 'http://localhost/library-management-system/backend/api';

/**
 * Fetch wrapper with error handling
 */
async function apiCall(endpoint, action, method = 'GET', data = null) {
    try {
        const url = new URL(`${API_BASE_URL}/${endpoint}.php`);
        url.searchParams.append('action', action);

        const options = {
            method: method,
            headers: {
                'Content-Type': 'application/json'
            }
        };

        if (method !== 'GET' && data) {
            options.body = JSON.stringify(data);
        }

        const response = await fetch(url, options);
        const result = await response.json();

        return result;
    } catch (error) {
        console.error('API Error:', error);
        return { success: false, message: 'Network error' };
    }
}

/**
 * Show alert message
 */
function showAlert(message, type = 'success') {
    const alertDiv = document.createElement('div');
    alertDiv.className = `alert alert-${type}`;
    alertDiv.textContent = message;
    
    const container = document.querySelector('.container') || document.body;
    container.insertBefore(alertDiv, container.firstChild);
    
    setTimeout(() => {
        alertDiv.remove();
    }, 4000);
}

/**
 * Format date to YYYY-MM-DD
 */
function formatDate(date) {
    if (!date) return '';
    const d = new Date(date);
    const month = String(d.getMonth() + 1).padStart(2, '0');
    const day = String(d.getDate()).padStart(2, '0');
    return `${d.getFullYear()}-${month}-${day}`;
}

/**
 * Format date for display
 */
function formatDateDisplay(date) {
    if (!date) return '';
    const d = new Date(date);
    return d.toLocaleDateString('en-US', { year: 'numeric', month: 'short', day: 'numeric' });
}

/**
 * Calculate days between two dates
 */
function daysBetween(date1, date2) {
    const d1 = new Date(date1);
    const d2 = new Date(date2);
    const diffTime = Math.abs(d2 - d1);
    const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
    return diffDays;
}

/**
 * Show/Hide Modal
 */
function openModal(modalId) {
    document.getElementById(modalId).classList.add('show');
}

function closeModal(modalId) {
    document.getElementById(modalId).classList.remove('show');
}

// Close modal when clicking outside
window.onclick = function(event) {
    if (event.target.classList.contains('modal')) {
        event.target.classList.remove('show');
    }
}

/**
 * Confirm deletion
 */
function confirmDelete(message = 'Are you sure you want to delete this item?') {
    return confirm(message);
}

/**
 * Format currency
 */
function formatCurrency(amount) {
    return '$' + parseFloat(amount).toFixed(2);
}

/**
 * Clear form
 */
function clearForm(formId) {
    const form = document.getElementById(formId);
    if (form) {
        form.reset();
    }
}

/**
 * Set form values
 */
function setFormValues(formId, data) {
    const form = document.getElementById(formId);
    if (!form) return;

    for (const [key, value] of Object.entries(data)) {
        const input = form.querySelector(`[name="${key}"]`);
        if (input) {
            input.value = value || '';
        }
    }
}

/**
 * Get form values
 */
function getFormValues(formId) {
    const form = document.getElementById(formId);
    const formData = new FormData(form);
    const data = {};

    for (const [key, value] of formData.entries()) {
        data[key] = value;
    }

    return data;
}

/**
 * Validate email
 */
function isValidEmail(email) {
    const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return re.test(email);
}

/**
 * Show loading spinner
 */
function showLoading() {
    const loader = document.createElement('div');
    loader.id = 'loader';
    loader.innerHTML = '<div class="spinner"></div>';
    document.body.appendChild(loader);
}

function hideLoading() {
    const loader = document.getElementById('loader');
    if (loader) {
        loader.remove();
    }
}
