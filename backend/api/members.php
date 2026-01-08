<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE');
header('Access-Control-Allow-Headers: Content-Type');

require_once '../config/config.php';
require_once '../classes/Member.php';

$method = $_SERVER['REQUEST_METHOD'];
$action = isset($_GET['action']) ? $_GET['action'] : '';

$member = new Member($conn);
$response = [];

try {
    switch ($action) {
        case 'getAll':
            if ($method == 'GET') {
                $result = $member->getAll();
                if ($result) {
                    $response['success'] = true;
                    $response['data'] = $result;
                } else {
                    $response['success'] = false;
                    $response['message'] = 'Error retrieving members';
                }
            }
            break;

        case 'getById':
            if ($method == 'GET' && isset($_GET['id'])) {
                $result = $member->getById($_GET['id']);
                if ($result) {
                    $response['success'] = true;
                    $response['data'] = $result;
                } else {
                    $response['success'] = false;
                    $response['message'] = 'Member not found';
                }
            }
            break;

        case 'search':
            if ($method == 'GET' && isset($_GET['keyword'])) {
                $result = $member->search($_GET['keyword']);
                if ($result) {
                    $response['success'] = true;
                    $response['data'] = $result;
                } else {
                    $response['success'] = false;
                    $response['message'] = 'No members found';
                }
            }
            break;

        case 'add':
            if ($method == 'POST') {
                $data = json_decode(file_get_contents("php://input"), true);
                
                if (isset($data['name'], $data['email'], $data['phone'], $data['address'])) {
                    if ($member->add($data['name'], $data['email'], $data['phone'], $data['address'])) {
                        $response['success'] = true;
                        $response['message'] = 'Member added successfully';
                    } else {
                        $response['success'] = false;
                        $response['message'] = 'Error adding member (email may already exist)';
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
                
                if (isset($data['name'], $data['email'], $data['phone'], $data['address'], $data['status'])) {
                    if ($member->update($_GET['id'], $data['name'], $data['email'], $data['phone'], $data['address'], $data['status'])) {
                        $response['success'] = true;
                        $response['message'] = 'Member updated successfully';
                    } else {
                        $response['success'] = false;
                        $response['message'] = 'Error updating member';
                    }
                } else {
                    $response['success'] = false;
                    $response['message'] = 'Missing required fields';
                }
            }
            break;

        case 'delete':
            if ($method == 'DELETE' && isset($_GET['id'])) {
                if ($member->delete($_GET['id'])) {
                    $response['success'] = true;
                    $response['message'] = 'Member deleted successfully';
                } else {
                    $response['success'] = false;
                    $response['message'] = 'Error deleting member';
                }
            }
            break;

        case 'stats':
            if ($method == 'GET') {
                $stats = [
                    'total_members' => $member->getTotalCount(),
                    'active_members' => $member->getActiveCount()
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
