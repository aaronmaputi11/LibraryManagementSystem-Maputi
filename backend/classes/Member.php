<?php
/**
 * Member Class - Handles all member-related database operations
 */

class Member {
    private $conn;
    private $table = 'members';

    public $id;
    public $name;
    public $email;
    public $phone;
    public $address;
    public $membership_date;
    public $status;

    public function __construct($db) {
        $this->conn = $db;
    }

    // Get all members
    public function getAll() {
        $query = "SELECT * FROM " . $this->table . " ORDER BY name ASC";
        $result = $this->conn->query($query);
        
        if ($result === false) {
            return false;
        }

        $members = [];
        while ($row = $result->fetch_assoc()) {
            $members[] = $row;
        }
        return $members;
    }

    // Get member by ID
    public function getById($id) {
        $query = "SELECT * FROM " . $this->table . " WHERE id = ?";
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("i", $id);
        $stmt->execute();
        $result = $stmt->get_result();
        
        return $result->fetch_assoc();
    }

    // Search members by name or email
    public function search($keyword) {
        $query = "SELECT * FROM " . $this->table . " WHERE name LIKE ? OR email LIKE ? ORDER BY name ASC";
        $stmt = $this->conn->prepare($query);
        $keyword = "%{$keyword}%";
        $stmt->bind_param("ss", $keyword, $keyword);
        $stmt->execute();
        $result = $stmt->get_result();

        $members = [];
        while ($row = $result->fetch_assoc()) {
            $members[] = $row;
        }
        return $members;
    }

    // Add new member
    public function add($name, $email, $phone, $address) {
        $query = "INSERT INTO " . $this->table . " (name, email, phone, address, membership_date, status) 
                  VALUES (?, ?, ?, ?, NOW(), 'active')";
        
        $stmt = $this->conn->prepare($query);
        if (!$stmt) {
            return false;
        }

        $stmt->bind_param("ssss", $name, $email, $phone, $address);
        
        return $stmt->execute();
    }

    // Update member
    public function update($id, $name, $email, $phone, $address, $status) {
        $query = "UPDATE " . $this->table . " SET name = ?, email = ?, phone = ?, address = ?, status = ? WHERE id = ?";
        
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("sssssi", $name, $email, $phone, $address, $status, $id);
        
        return $stmt->execute();
    }

    // Delete member
    public function delete($id) {
        $query = "DELETE FROM " . $this->table . " WHERE id = ?";
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("i", $id);
        
        return $stmt->execute();
    }

    // Get total members count
    public function getTotalCount() {
        $query = "SELECT COUNT(*) as count FROM " . $this->table;
        $result = $this->conn->query($query);
        $row = $result->fetch_assoc();
        
        return $row['count'];
    }

    // Get active members count
    public function getActiveCount() {
        $query = "SELECT COUNT(*) as count FROM " . $this->table . " WHERE status = 'active'";
        $result = $this->conn->query($query);
        $row = $result->fetch_assoc();
        
        return $row['count'];
    }
}
?>
