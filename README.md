# 📚 Library Management System

A complete web-based library management system built with PHP, MySQL, HTML, CSS, and JavaScript. Track books, members, and borrowing history efficiently.

## Features

✅ **Book Inventory Management**
- Add, edit, and delete books
- Track available and total copies
- Search books by title, author, or category
- Categorize and organize books

✅ **Member Management**
- Register and manage library members
- Track membership status (active, inactive, suspended)
- Search members by name or email
- Store member contact information

✅ **Borrowing & Return Tracking**
- Record book borrowing with automatic dates
- Track return status
- Calculate fines for overdue books
- Monitor overdue books in real-time

✅ **Due Date Monitoring**
- Visual alerts for overdue books
- Automatic fine calculation (₹10 per day)
- Due date reminders on dashboard

✅ **Dashboard & Reports**
- Real-time statistics
- Overview of all operations
- Quick access to overdue books
- Active borrowing summary

## Tech Stack

- **Frontend**: HTML5, CSS3, JavaScript (Vanilla)
- **Backend**: PHP 7.0+
- **Database**: MySQL/MariaDB
- **Server**: XAMPP (Apache + MySQL)

## Project Structure

```
library-management-system/
│
├── backend/
│   ├── api/
│   │   ├── books.php           # Books API endpoints
│   │   ├── members.php         # Members API endpoints
│   │   └── borrowlogs.php      # Borrowing API endpoints
│   │
│   ├── classes/
│   │   ├── Book.php            # Book class for DB operations
│   │   ├── Member.php          # Member class for DB operations
│   │   └── BorrowLog.php       # BorrowLog class for DB operations
│   │
│   └── config/
│       └── config.php          # Database configuration
│
├── frontend/
│   ├── index.html              # Dashboard
│   ├── books.html              # Books management
│   ├── members.html            # Members management
│   ├── borrowing.html          # Borrowing management
│   │
│   ├── css/
│   │   └── style.css           # Main stylesheet
│   │
│   └── js/
│       ├── utils.js            # Utility functions & API calls
│       ├── dashboard.js        # Dashboard logic
│       ├── books.js            # Books page logic
│       ├── members.js          # Members page logic
│       └── borrowing.js        # Borrowing page logic
│
└── database/
    └── library_schema.sql      # Database schema
```

## Installation & Setup

### 1. **Prerequisites**
- XAMPP installed and running
- MySQL Workbench (optional, for database management)
- Modern web browser

### 2. **Database Setup**

1. Open **phpMyAdmin** (http://localhost/phpmyadmin)
2. Go to SQL tab and execute the script from `database/library_schema.sql`
   - Or import the SQL file directly
3. Verify tables are created:
   - `members`
   - `books`
   - `borrow_logs`

### 3. **Project Setup**

1. Copy the entire `library-management-system` folder to:
   ```
   C:\xampp\htdocs\
   ```

2. **Verify folder structure** in `C:\xampp\htdocs\library-management-system\`

3. **Update Database Credentials** (if needed):
   - Edit `backend/config/config.php`
   - Update database connection details if using different credentials

### 4. **Access the Application**

1. Start XAMPP (Apache & MySQL)
2. Open browser and go to:
   ```
   http://localhost/library-management-system/frontend/index.html
   ```

## API Endpoints

### Books API (`/backend/api/books.php`)
- `?action=getAll` - Get all books
- `?action=getById&id=1` - Get specific book
- `?action=search&keyword=term` - Search books
- `?action=add` (POST) - Add new book
- `?action=update&id=1` (PUT) - Update book
- `?action=delete&id=1` (DELETE) - Delete book
- `?action=stats` - Get book statistics

### Members API (`/backend/api/members.php`)
- `?action=getAll` - Get all members
- `?action=getById&id=1` - Get specific member
- `?action=search&keyword=term` - Search members
- `?action=add` (POST) - Add new member
- `?action=update&id=1` (PUT) - Update member
- `?action=delete&id=1` (DELETE) - Delete member
- `?action=stats` - Get member statistics

### Borrowing API (`/backend/api/borrowlogs.php`)
- `?action=getAll` - Get all borrow logs
- `?action=getByMemberId&member_id=1` - Get member's history
- `?action=getCurrentBorrows` - Get active borrows
- `?action=getOverdue` - Get overdue books
- `?action=borrow` (POST) - Record borrow
- `?action=returnBook&id=1` (PUT) - Return book
- `?action=stats` - Get borrowing statistics

## Usage Guide

### Adding a Book
1. Go to **Books** page
2. Click **"+ Add Book"** button
3. Fill in book details (ISBN, Title, Author, etc.)
4. Click **"Save Book"**

### Registering a Member
1. Go to **Members** page
2. Click **"+ Add Member"** button
3. Enter member details (Name, Email, Phone, Address)
4. Click **"Save Member"**

### Recording a Borrow
1. Go to **Borrowing** page
2. Select member and book from dropdowns
3. Confirm borrow and due dates
4. Click **"Record Borrow"**

### Returning a Book
1. Go to **Borrowing** page
2. Find the book in "Active Borrowing Records"
3. Click **"Return"** button
4. Enter return date (fine auto-calculated)
5. Click **"Confirm Return"**

## Fine Calculation

- **Default**: ₹10 per day overdue
- **Auto-calculated**: When returning overdue books
- **Display**: Shown in borrowing logs

## Database Schema

### Members Table
```
id, name, email, phone, address, membership_date, status, created_at, updated_at
```

### Books Table
```
id, isbn, title, author, publisher, publication_year, category, description, 
total_copies, available_copies, location_shelf, status, created_at, updated_at
```

### Borrow Logs Table
```
id, member_id, book_id, borrow_date, due_date, return_date, status, 
fine_amount, notes, created_at, updated_at
```

## Features in Detail

### Dashboard
- Quick statistics overview
- Currently borrowed books list
- Overdue books alert
- Visual status indicators

### Book Management
- Full CRUD operations
- Availability tracking
- Advanced search functionality
- Category organization
- Location tracking

### Member Management
- Member registration
- Status management
- Contact information
- Search capabilities
- Membership tracking

### Borrowing System
- 14-day default loan period
- Automatic date management
- Overdue tracking
- Fine calculation
- Return processing
- Availability updates

## Troubleshooting

### Issue: Database Connection Error
**Solution**: 
- Verify MySQL is running
- Check database name and credentials in `config.php`
- Ensure schema is imported

### Issue: API Returns 404
**Solution**:
- Check URL structure
- Verify files are in correct folders
- Check file permissions

### Issue: Form Not Submitting
**Solution**:
- Check browser console for errors
- Verify API base URL in `utils.js`
- Check XAMPP server status

### Issue: Books Not Showing
**Solution**:
- Verify database tables exist
- Check API response in Network tab
- Ensure sample data is added

## Future Enhancements

- [ ] User authentication & login
- [ ] Admin panel with reports
- [ ] Email notifications for overdue books
- [ ] Book reservations
- [ ] Member subscription plans
- [ ] Advanced filtering & sorting
- [ ] PDF report generation
- [ ] Mobile app
- [ ] Barcode scanning
- [ ] Multi-language support

## Security Notes

- Use prepared statements (already implemented)
- Validate all inputs
- Add authentication before deployment
- Use HTTPS in production
- Implement proper access control
- Regular database backups

## Performance Tips

- Add database indexes (already added)
- Implement pagination for large datasets
- Cache frequently accessed data
- Optimize image uploads
- Use CDN for static assets

## Contributing

Feel free to fork and improve this system!

## License

This project is open source and available for personal and educational use.

## Support

For issues or questions, please refer to the API documentation or check the browser console for error messages.

---

**Version**: 1.0.0  
**Last Updated**: January 2026  
**Built with ❤️ using PHP & MySQL**
