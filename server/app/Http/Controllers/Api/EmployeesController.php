<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Carbon;
class EmployeesController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function getAllEmployees()
    {
        $getAllUser = User::all();
        return response()->json($getAllUser);
    }

    public function getAllEmployeesName()
    {
        $data = User::select('name')->get();
        return response()->json($data);
    }
    /**
     * Store a newly created resource in storage.
     */
    public function editInfoEmployee($id)
{
    $user = User::find($id);

    if (!$user) {
        return response()->json(['message' => 'User not found'], 404);
    }

    return response()->json($user, 201);
}

public function updateInfoEmployee(Request $request, string $id)
{
    $data = $request->all();
    $data['password'] = bcrypt($request->input('password'));

    $employee = User::findOrFail($id);
    $employee->update($data);

    return response()->json([
        "success" => true,
        "data" => $employee,
        "message" => "Employee updated successfully"
    ]);
}

public function deleteInfoEmployee(string $id)
{

    $user = User::findOrFail($id);

    // Check if the user is authorized to delete the user.

    // if (!auth()->user()->can('delete users')) {
    //     abort(403, 'Unauthorized');
    // }

    $user->delete();

    return response()->json([
        "success" => true,
        'message' => 'User successfully deleted.',
    ]);
}

}
