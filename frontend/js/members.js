// Members Management JavaScript

let allMembers = [];

async function loadMembers() {
    try {
        const response = await apiCall('members', 'getAll');
        
        if (response.success) {
            allMembers = response.data;
            renderMembersTable(allMembers);
        } else {
            showAlert(response.message || 'Error loading members', 'danger');
        }
    } catch (error) {
        console.error('Error loading members:', error);
        showAlert('Error loading members', 'danger');
    }
}

function renderMembersTable(members) {
    if (!members || members.length === 0) {
        document.getElementById('membersContainer').innerHTML = '<p style="text-align: center; color: #7f8c8d;">No members found. <a href="#" onclick="openModal(\'memberModal\')">Add the first member</a></p>';
        return;
    }

    let html = '<table>';
    html += '<thead><tr>';
    html += '<th>Name</th><th>Email</th><th>Phone</th><th>Membership Date</th><th>Status</th><th>Actions</th>';
    html += '</tr></thead><tbody>';

    members.forEach(member => {
        const statusClass = member.status === 'active' ? 'success' : 'warning';
        html += '<tr>';
        html += `<td><strong>${member.name}</strong></td>`;
        html += `<td><small>${member.email}</small></td>`;
        html += `<td>${member.phone || 'N/A'}</td>`;
        html += `<td>${formatDateDisplay(member.membership_date)}</td>`;
        html += `<td><span class="alert alert-${statusClass}" style="padding: 3px 8px; font-size: 12px;">${member.status}</span></td>`;
        html += '<td class="action-buttons">';
        html += `<button class="btn btn-primary btn-small" onclick="editMember(${member.id})">Edit</button>`;
        html += `<button class="btn btn-danger btn-small" onclick="deleteMember(${member.id})">Delete</button>`;
        html += '</td>';
        html += '</tr>';
    });

    html += '</tbody></table>';
    document.getElementById('membersContainer').innerHTML = html;
}

async function searchMembers() {
    const keyword = document.getElementById('searchMembers').value.trim();
    
    if (!keyword) {
        showAlert('Please enter a search term', 'warning');
        return;
    }

    try {
        const url = new URL(`${API_BASE_URL}/members.php`);
        url.searchParams.append('action', 'search');
        url.searchParams.append('keyword', keyword);

        const response = await fetch(url);
        const result = await response.json();

        if (result.success) {
            renderMembersTable(result.data);
            showAlert(`Found ${result.data.length} member(s)`, 'info');
        } else {
            renderMembersTable([]);
            showAlert('No members found matching your search', 'warning');
        }
    } catch (error) {
        console.error('Error searching members:', error);
        showAlert('Error searching members', 'danger');
    }
}

async function editMember(id) {
    try {
        const url = new URL(`${API_BASE_URL}/members.php`);
        url.searchParams.append('action', 'getById');
        url.searchParams.append('id', id);

        const response = await fetch(url);
        const result = await response.json();

        if (result.success) {
            const member = result.data;
            document.getElementById('memberId').value = member.id;
            document.getElementById('name').value = member.name;
            document.getElementById('email').value = member.email;
            document.getElementById('phone').value = member.phone || '';
            document.getElementById('address').value = member.address || '';
            document.getElementById('status').value = member.status;
            
            document.getElementById('memberModalTitle').textContent = 'Edit Member';
            openModal('memberModal');
        } else {
            showAlert('Error loading member details', 'danger');
        }
    } catch (error) {
        console.error('Error editing member:', error);
        showAlert('Error loading member details', 'danger');
    }
}

async function saveMember(event) {
    event.preventDefault();

    const memberId = document.getElementById('memberId').value;
    const formData = {
        name: document.getElementById('name').value,
        email: document.getElementById('email').value,
        phone: document.getElementById('phone').value,
        address: document.getElementById('address').value,
        status: document.getElementById('status').value
    };

    // Validate email
    if (!isValidEmail(formData.email)) {
        showAlert('Please enter a valid email address', 'warning');
        return;
    }

    try {
        let response;
        if (memberId) {
            // Update existing member
            const url = new URL(`${API_BASE_URL}/members.php`);
            url.searchParams.append('action', 'update');
            url.searchParams.append('id', memberId);

            const fetchResponse = await fetch(url, {
                method: 'PUT',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(formData)
            });
            response = await fetchResponse.json();
        } else {
            // Add new member
            response = await apiCall('members', 'add', 'POST', formData);
        }

        if (response.success) {
            showAlert(response.message, 'success');
            closeModal('memberModal');
            clearForm('memberForm');
            document.getElementById('memberId').value = '';
            document.getElementById('memberModalTitle').textContent = 'Add New Member';
            loadMembers();
        } else {
            showAlert(response.message || 'Error saving member', 'danger');
        }
    } catch (error) {
        console.error('Error saving member:', error);
        showAlert('Error saving member', 'danger');
    }
}

async function deleteMember(id) {
    if (!confirmDelete('Are you sure you want to delete this member? This will also delete all their borrowing records.')) {
        return;
    }

    try {
        const url = new URL(`${API_BASE_URL}/members.php`);
        url.searchParams.append('action', 'delete');
        url.searchParams.append('id', id);

        const response = await fetch(url, {
            method: 'DELETE',
            headers: { 'Content-Type': 'application/json' }
        });
        const result = await response.json();

        if (result.success) {
            showAlert(result.message, 'success');
            loadMembers();
        } else {
            showAlert(result.message || 'Error deleting member', 'danger');
        }
    } catch (error) {
        console.error('Error deleting member:', error);
        showAlert('Error deleting member', 'danger');
    }
}

// Initialize on page load
document.addEventListener('DOMContentLoaded', () => {
    loadMembers();
});
