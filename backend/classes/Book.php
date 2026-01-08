<?php
/**
 * Book Class - Handles all book-related database operations
 */

class Book {
    private $conn;
    private $table = 'books';

    public $id;
    public $isbn;
    public $title;
    public $author;
    public $publisher;
    public $publication_year;
    public $category;
    public $description;
    public $total_copies;
    public $available_copies;
    public $location_shelf;
    public $status;

    public function __construct($db) {
        $this->conn = $db;
    }

    // Get all books
    public function getAll() {
        $query = "SELECT * FROM " . $this->table . " ORDER BY title ASC";
        $result = $this->conn->query($query);
        
        if ($result === false) {
            return false;
        }

        $books = [];
        while ($row = $result->fetch_assoc()) {
            $books[] = $row;
        }
        return $books;
    }

    // Get book by ID
    public function getById($id) {
        $query = "SELECT * FROM " . $this->table . " WHERE id = ?";
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("i", $id);
        $stmt->execute();
        $result = $stmt->get_result();
        
        return $result->fetch_assoc();
    }

    // Search books by title, author, or category
    public function search($keyword) {
        $query = "SELECT * FROM " . $this->table . " WHERE title LIKE ? OR author LIKE ? OR category LIKE ? ORDER BY title ASC";
        $stmt = $this->conn->prepare($query);
        $keyword = "%{$keyword}%";
        $stmt->bind_param("sss", $keyword, $keyword, $keyword);
        $stmt->execute();
        $result = $stmt->get_result();

        $books = [];
        while ($row = $result->fetch_assoc()) {
            $books[] = $row;
        }
        return $books;
    }

    // Add new book
    public function add($isbn, $title, $author, $publisher, $publication_year, $category, $description, $total_copies, $location_shelf) {
        $query = "INSERT INTO " . $this->table . " (isbn, title, author, publisher, publication_year, category, description, total_copies, available_copies, location_shelf, status) 
                  VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 'available')";
        
        $stmt = $this->conn->prepare($query);
        if (!$stmt) {
            return false;
        }

        $stmt->bind_param("ssssissis", $isbn, $title, $author, $publisher, $publication_year, $category, $description, $total_copies, $total_copies, $location_shelf);
        
        return $stmt->execute();
    }

    // Update book
    public function update($id, $isbn, $title, $author, $publisher, $publication_year, $category, $description, $location_shelf, $status) {
        $query = "UPDATE " . $this->table . " SET isbn = ?, title = ?, author = ?, publisher = ?, publication_year = ?, category = ?, description = ?, location_shelf = ?, status = ? WHERE id = ?";
        
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("ssssisissi", $isbn, $title, $author, $publisher, $publication_year, $category, $description, $location_shelf, $status, $id);
        
        return $stmt->execute();
    }

    // Delete book
    public function delete($id) {
        $query = "DELETE FROM " . $this->table . " WHERE id = ?";
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("i", $id);
        
        return $stmt->execute();
    }

    // Update available copies
    public function updateAvailableCopies($id, $available_copies) {
        $query = "UPDATE " . $this->table . " SET available_copies = ? WHERE id = ?";
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("ii", $available_copies, $id);
        
        return $stmt->execute();
    }

    // Get available books count
    public function getAvailableCount() {
        $query = "SELECT COUNT(*) as count FROM " . $this->table . " WHERE status = 'available' AND available_copies > 0";
        $result = $this->conn->query($query);
        $row = $result->fetch_assoc();
        
        return $row['count'];
    }
}
?>
