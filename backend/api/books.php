<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE');
header('Access-Control-Allow-Headers: Content-Type');

require_once '../config/config.php';
require_once '../classes/Book.php';

$method = $_SERVER['REQUEST_METHOD'];
$action = isset($_GET['action']) ? $_GET['action'] : '';

$book = new Book($conn);
$response = [];

try {
    switch ($action) {
        case 'getAll':
            if ($method == 'GET') {
                $result = $book->getAll();
                if ($result) {
                    $response['success'] = true;
                    $response['data'] = $result;
                } else {
                    $response['success'] = false;
                    $response['message'] = 'Error retrieving books';
                }
            }
            break;

        case 'getById':
            if ($method == 'GET' && isset($_GET['id'])) {
                $result = $book->getById($_GET['id']);
                if ($result) {
                    $response['success'] = true;
                    $response['data'] = $result;
                } else {
                    $response['success'] = false;
                    $response['message'] = 'Book not found';
                }
            }
            break;

        case 'search':
            if ($method == 'GET' && isset($_GET['keyword'])) {
                $result = $book->search($_GET['keyword']);
                if ($result) {
                    $response['success'] = true;
                    $response['data'] = $result;
                } else {
                    $response['success'] = false;
                    $response['message'] = 'No books found';
                }
            }
            break;

        case 'add':
            if ($method == 'POST') {
                $data = json_decode(file_get_contents("php://input"), true);
                
                if (isset($data['isbn'], $data['title'], $data['author'], $data['publisher'], 
                          $data['publication_year'], $data['category'], $data['description'], 
                          $data['total_copies'], $data['location_shelf'])) {
                    
                    if ($book->add(
                        $data['isbn'], 
                        $data['title'], 
                        $data['author'], 
                        $data['publisher'], 
                        $data['publication_year'], 
                        $data['category'], 
                        $data['description'], 
                        $data['total_copies'],
                        $data['location_shelf']
                    )) {
                        $response['success'] = true;
                        $response['message'] = 'Book added successfully';
                    } else {
                        $response['success'] = false;
                        $response['message'] = 'Error adding book';
                    }
                } else {
                    $response['success'] = false;
                    $response['message'] = 'Missing required fields';
                }
            }
            break;

        case 'update':
            if ($method == 'PUT' && isset($_GET['id'])) {
                $data = json_decode(file_get_contents("php://input"), true);
                
                if (isset($data['isbn'], $data['title'], $data['author'], $data['publisher'], 
                          $data['publication_year'], $data['category'], $data['description'], 
                          $data['location_shelf'], $data['status'])) {
                    
                    if ($book->update(
                        $_GET['id'],
                        $data['isbn'], 
                        $data['title'], 
                        $data['author'], 
                        $data['publisher'], 
                        $data['publication_year'], 
                        $data['category'], 
                        $data['description'], 
                        $data['location_shelf'],
                        $data['status']
                    )) {
                        $response['success'] = true;
                        $response['message'] = 'Book updated successfully';
                    } else {
                        $response['success'] = false;
                        $response['message'] = 'Error updating book';
                    }
                } else {
                    $response['success'] = false;
                    $response['message'] = 'Missing required fields';
                }
            }
            break;

        case 'delete':
            if ($method == 'DELETE' && isset($_GET['id'])) {
                if ($book->delete($_GET['id'])) {
                    $response['success'] = true;
                    $response['message'] = 'Book deleted successfully';
                } else {
                    $response['success'] = false;
                    $response['message'] = 'Error deleting book';
                }
            }
            break;

        case 'stats':
            if ($method == 'GET') {
                $stats = [
                    'total_books' => $book->getAll() ? count($book->getAll()) : 0,
                    'available_books' => $book->getAvailableCount()
                ];
                $response['success'] = true;
                $response['data'] = $stats;
            }
            break;

        default:
            $response['success'] = false;
            $response['message'] = 'Invalid action';
    }
} catch (Exception $e) {
    $response['success'] = false;
    $response['message'] = 'Error: ' . $e->getMessage();
}

echo json_encode($response);
?>
