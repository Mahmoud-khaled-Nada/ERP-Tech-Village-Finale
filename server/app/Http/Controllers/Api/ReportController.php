<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Http\Requests\ReportRequest;
use App\Models\Report;
use App\Models\User;

class ReportController extends Controller
{
    public function addNewReport(ReportRequest $request)
    {
        $data = $request->validated();

        Report::create($data);

        return response()->json([
            "message" => "Report added successfully",
            "data" => $data
        ]);
    }

    public function getReportByName(Request $request)
    {
        $validatedData = $request->validate([
            'name' => 'required|string|exists:users,name',
            'from' => 'required|date_format:Y-m-d',
            'to' => 'required|date_format:Y-m-d',
        ]);

        $user = User::where('name', $validatedData['name'])->first();

        if (!$user) {
            return response()->json(['error' => 'User not found'], 404);
        }

        $result = Report::where('user_id', $user->id)
            ->whereBetween('created_at', [$validatedData['from'], $validatedData['to']])
            ->orderBy('created_at', 'desc')
            ->get();

        return response()->json(['message' => 'Successfully', 'result' => $result]);
    }

    public function deleteMyReportById($id)
    {
        $report = Report::findOrFail($id);
        if (!auth()->user()) {
            abort(403, 'Unauthorized');
        }

        $report->delete();

        return response()->json([
            "success" => true,
            'message' => 'Report successfully deleted.',
        ]);
    }
}
