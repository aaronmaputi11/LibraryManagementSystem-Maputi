<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE');
header('Access-Control-Allow-Headers: Content-Type');

require_once '../config/config.php';
require_once '../classes/BorrowLog.php';
require_once '../classes/Book.php';

$method = $_SERVER['REQUEST_METHOD'];
$action = isset($_GET['action']) ? $_GET['action'] : '';

$borrowLog = new BorrowLog($conn);
$book = new Book($conn);
$response = [];

try {
    switch ($action) {
        case 'getAll':
            if ($method == 'GET') {
                $result = $borrowLog->getAll();
                if ($result) {
                    $response['success'] = true;
                    $response['data'] = $result;
                } else {
                    $response['success'] = false;
                    $response['message'] = 'Error retrieving borrow logs';
                }
            }
            break;

        case 'getByMemberId':
            if ($method == 'GET' && isset($_GET['member_id'])) {
                $result = $borrowLog->getByMemberId($_GET['member_id']);
                if ($result) {
                    $response['success'] = true;
                    $response['data'] = $result;
                } else {
                    $response['success'] = false;
                    $response['message'] = 'No borrow history found';
                }
            }
            break;

        case 'getCurrentBorrows':
            if ($method == 'GET') {
                $result = $borrowLog->getCurrentBorrows();
                $response['success'] = true;
                $response['data'] = $result;
            }
            break;

        case 'getOverdue':
            if ($method == 'GET') {
                $result = $borrowLog->getOverdueBooks();
                $response['success'] = true;
                $response['data'] = $result;
            }
            break;

        case 'borrow':
            if ($method == 'POST') {
                $data = json_decode(file_get_contents("php://input"), true);
                
                if (isset($data['member_id'], $data['book_id'], $data['borrow_date'], $data['due_date'])) {
                    // Check if book is available
                    $bookData = $book->getById($data['book_id']);
                    if ($bookData && $bookData['available_copies'] > 0) {
                        if ($borrowLog->borrow($data['member_id'], $data['book_id'], $data['borrow_date'], $data['due_date'])) {
                            // Update available copies
                            $new_copies = $bookData['available_copies'] - 1;
                            $book->updateAvailableCopies($data['book_id'], $new_copies);
                            
                            $response['success'] = true;
                            $response['message'] = 'Book borrowed successfully';
                        } else {
                            $response['success'] = false;
                            $response['message'] = 'Error recording borrow';
                        }
                    } else {
                        $response['success'] = false;
                        $response['message'] = 'Book not available';
                    }
                } else {
                    $response['success'] = false;
                    $response['message'] = 'Missing required fields';
                }
            }
            break;

        case 'returnBook':
            if ($method == 'PUT' && isset($_GET['id'])) {
                $data = json_decode(file_get_contents("php://input"), true);
                
                if (isset($data['return_date'])) {
                    // Get the borrow log to find the book
                    $query = "SELECT * FROM borrow_logs WHERE id = ?";
                    $stmt = $conn->prepare($query);
                    $stmt->bind_param("i", $_GET['id']);
                    $stmt->execute();
                    $result = $stmt->get_result();
                    $borrowData = $result->fetch_assoc();

                    if ($borrowData) {
                        if ($borrowLog->returnBook($_GET['id'], $data['return_date'])) {
                            // Update available copies
                            $bookData = $book->getById($borrowData['book_id']);
                            $new_copies = $bookData['available_copies'] + 1;
                            $book->updateAvailableCopies($borrowData['book_id'], $new_copies);

                            // Calculate fine if overdue
                            $due_date = new DateTime($borrowData['due_date']);
                            $return_date = new DateTime($data['return_date']);
                            $interval = $due_date->diff($return_date);
                            $days_overdue = $interval->days;

                            if ($days_overdue > 0) {
                                $fine = $days_overdue * 10; // 10 per day
                                $borrowLog->addFine($_GET['id'], $fine);
                            }

                            $response['success'] = true;
                            $response['message'] = 'Book returned successfully';
                        } else {
                            $response['success'] = false;
                            $response['message'] = 'Error recording return';
                        }
                    } else {
                        $response['success'] = false;
                        $response['message'] = 'Borrow record not found';
                    }
                } else {
                    $response['success'] = false;
                    $response['message'] = 'Missing return date';
                }
            }
            break;

        case 'stats':
            if ($method == 'GET') {
                $stats = $borrowLog->getStatistics();
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
