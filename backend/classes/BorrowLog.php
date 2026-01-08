<?php
/**
 * BorrowLog Class - Handles all borrowing-related database operations
 */

class BorrowLog {
    private $conn;
    private $table = 'borrow_logs';

    public $id;
    public $member_id;
    public $book_id;
    public $borrow_date;
    public $due_date;
    public $return_date;
    public $status;
    public $fine_amount;
    public $notes;

    public function __construct($db) {
        $this->conn = $db;
    }

    // Get all borrow logs
    public function getAll() {
        $query = "SELECT bl.*, m.name as member_name, b.title as book_title FROM " . $this->table . " bl
                  JOIN members m ON bl.member_id = m.id
                  JOIN books b ON bl.book_id = b.id
                  ORDER BY bl.borrow_date DESC";
        $result = $this->conn->query($query);
        
        if ($result === false) {
            return false;
        }

        $logs = [];
        while ($row = $result->fetch_assoc()) {
            $logs[] = $row;
        }
        return $logs;
    }

    // Get logs by member ID
    public function getByMemberId($member_id) {
        $query = "SELECT bl.*, b.title as book_title FROM " . $this->table . " bl
                  JOIN books b ON bl.book_id = b.id
                  WHERE bl.member_id = ?
                  ORDER BY bl.borrow_date DESC";
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("i", $member_id);
        $stmt->execute();
        $result = $stmt->get_result();

        $logs = [];
        while ($row = $result->fetch_assoc()) {
            $logs[] = $row;
        }
        return $logs;
    }

    // Get current borrowed books
    public function getCurrentBorrows() {
        $query = "SELECT bl.*, m.name as member_name, b.title as book_title FROM " . $this->table . " bl
                  JOIN members m ON bl.member_id = m.id
                  JOIN books b ON bl.book_id = b.id
                  WHERE bl.status = 'borrowed'
                  ORDER BY bl.due_date ASC";
        $result = $this->conn->query($query);
        
        $logs = [];
        while ($row = $result->fetch_assoc()) {
            $logs[] = $row;
        }
        return $logs;
    }

    // Get overdue books
    public function getOverdueBooks() {
        $query = "SELECT bl.*, m.name as member_name, b.title as book_title FROM " . $this->table . " bl
                  JOIN members m ON bl.member_id = m.id
                  JOIN books b ON bl.book_id = b.id
                  WHERE bl.status = 'borrowed' AND bl.due_date < CURDATE()
                  ORDER BY bl.due_date ASC";
        $result = $this->conn->query($query);
        
        $logs = [];
        while ($row = $result->fetch_assoc()) {
            $logs[] = $row;
        }
        return $logs;
    }

    // Borrow book
    public function borrow($member_id, $book_id, $borrow_date, $due_date) {
        $query = "INSERT INTO " . $this->table . " (member_id, book_id, borrow_date, due_date, status) 
                  VALUES (?, ?, ?, ?, 'borrowed')";
        
        $stmt = $this->conn->prepare($query);
        if (!$stmt) {
            return false;
        }

        $stmt->bind_param("iiss", $member_id, $book_id, $borrow_date, $due_date);
        
        return $stmt->execute();
    }

    // Return book
    public function returnBook($id, $return_date) {
        $query = "UPDATE " . $this->table . " SET return_date = ?, status = 'returned' WHERE id = ?";
        
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("si", $return_date, $id);
        
        return $stmt->execute();
    }

    // Add fine
    public function addFine($id, $fine_amount) {
        $query = "UPDATE " . $this->table . " SET fine_amount = ? WHERE id = ?";
        
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("di", $fine_amount, $id);
        
        return $stmt->execute();
    }

    // Get statistics
    public function getStatistics() {
        $stats = [];

        // Total borrows
        $query = "SELECT COUNT(*) as count FROM " . $this->table;
        $result = $this->conn->query($query);
        $stats['total_borrows'] = $result->fetch_assoc()['count'];

        // Currently borrowed
        $query = "SELECT COUNT(*) as count FROM " . $this->table . " WHERE status = 'borrowed'";
        $result = $this->conn->query($query);
        $stats['current_borrows'] = $result->fetch_assoc()['count'];

        // Overdue count
        $query = "SELECT COUNT(*) as count FROM " . $this->table . " WHERE status = 'borrowed' AND due_date < CURDATE()";
        $result = $this->conn->query($query);
        $stats['overdue_count'] = $result->fetch_assoc()['count'];

        // Total fines
        $query = "SELECT SUM(fine_amount) as total FROM " . $this->table;
        $result = $this->conn->query($query);
        $stats['total_fines'] = $result->fetch_assoc()['total'] ?? 0;

        return $stats;
    }
}
?>
