<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Auth\AuthController;
use App\Http\Controllers\Api\EmployeesController;
use App\Http\Controllers\Api\FingerprintController;
use App\Http\Controllers\Api\ReportController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

// POST	/api/auth/register
// POST	/api/auth/login
// GET	/api/auth/user-profile
// POST	/api/auth/refresh
// POST	/api/auth/logout
Route::group(['middleware' => 'api', 'prefix' => 'auth'], function () {
    Route::post('/login', [AuthController::class, 'login']);
    Route::post('/register', [AuthController::class, 'register']);
    Route::post('/logout', [AuthController::class, 'logout']);
    Route::post('/refresh', [AuthController::class, 'refresh']);
    Route::get('/user-profile', [AuthController::class, 'userProfile']);
});





Route::group(['middleware' => 'auth'], function () {
    Route::get('/get-all-employees', [EmployeesController::class, 'getAllEmployees']);
    Route::get('/get-all-employees-name', [EmployeesController::class, 'getAllEmployeesName']);
    Route::post('/edit-employee/{id}', [EmployeesController::class, 'editInfoEmployee']);
    Route::put('/update-employee/{id}', [EmployeesController::class, 'updateInfoEmployee']);
    Route::delete('/delete-employee/{id}', [EmployeesController::class, 'deleteInfoEmployee']);
});

// Route::group(['middleware' => 'auth'], function () {
// });'

Route::post('/add-time-attendance', [FingerprintController::class, 'addTimeAttendance']);
Route::post('/add-time-departure/{id}', [FingerprintController::class, 'addTimeDeparture']);
Route::post('/add-time-absence', [FingerprintController::class, 'addTimeAbsence']);
Route::post('/get-time-absence', [FingerprintController::class, 'getTimeAbsence']);
Route::get('/get-time-attendance-departure', [FingerprintController::class, 'getTimeAttendanceDeparture']);
Route::post('/call-time-attendance-departure', [FingerprintController::class, 'callTimeAttendanceDeparture']);

// Route of Reports
Route::group(['middleware' => 'auth'], function () {
    Route::post('/add-new-report', [ReportController::class, 'addNewReport']);
    Route::post('/get-report-by-name', [ReportController::class, 'getReportByName']);
    Route::delete('/delete-my-report-by/{id}', [ReportController::class, 'deleteMyReportById']);
});
