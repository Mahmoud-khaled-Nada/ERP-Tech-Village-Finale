<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\StoreFingerprintDeviceRequest;
use App\Models\Fingerprint;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\Auth;


class FingerprintController extends Controller
{
    public function addTimeAttendance(StoreFingerprintDeviceRequest $request)
    {
        try {
            $data = $request->validated();
            Fingerprint::create([
                'user_id' => $request->user()->id,
                'time_attendance' => $data['time_attendance'],
            ]);
            return response()->json(['success' => true], 201);
        } catch (\Exception $e) {
            return response($e);
        }
    }

    public function addTimeDeparture(StoreFingerprintDeviceRequest $request, $id)
    {
        try {
            $data = $request->validated();
            $updateTimeDeparture = Fingerprint::findOrFail($id);
            $updateTimeDeparture->update([
                'time_departure' => $data['time_departure'],
            ]);
            return response()->json(['success' => true], 201);
        } catch (\Exception $e) {
            return response($e);
        }
    }

    public function addTimeAbsence(Request $request)
    {
        try {
            $query = $request->validate([
                'absence' => 'required|string|max:100',
            ]);

            Fingerprint::create([
                'user_id' => $request->user()->id,
                'absence' => $query['absence'],
            ]);
            return response()->json(['success' => true], 201);
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }

    public function getTimeAbsence(Request $request)
    {
        try {
            $query = $request->validate([
                'name' => 'required|string|exists:users,name',
                'from' => 'required|date',
                'to' => 'required|date',
            ]);
    
            // Ensure 'from' date is not greater than 'to' date
            if ($query['from'] > $query['to']) {
                return response()->json(['error' => 'Invalid date range'], 400);
            }
    
            // Retrieve the user based on the provided 'name'
            $user = User::where('name', $query['name'])->first();
    
            if (!$user) {
                return response()->json(['error' => 'User not found'], 404);
            }
    
            $result = Fingerprint::where('user_id', $user->id)
                ->whereNotNull('absence')
                ->whereBetween('created_at', [$query['from'], $query['to']])
                ->get();
    
            // Iterate through the result and add the user's name to each object
            $result = $result->map(function ($item) use ($user) {
                $item['name'] = $user->name;
                return $item;
            });
    
            return response()->json(['message' => 'Successfully', 'result' => $result]);
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }
    


    public function getTimeAttendanceDeparture()
    {
        try {
            $user = Auth::user();
            $today = Carbon::now()->toDateString();
            $data = Fingerprint::whereDate('created_at', $today)
                ->where('user_id', $user->id)
                ->whereNotNull('time_attendance')
                ->get();

            return response()->json([
                'status' => true,
                'data' => $data
            ]);
        } catch (\Exception $e) {
            // You should return a response with the error message
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }



    public function callTimeAttendanceDeparture(Request $request)
    {
        try {
            $query = $request->validate([
                'name' => 'required|string|exists:users,name', // Ensure you have 'name' in the query parameters
                'from' => 'required|string|max:100',
                'to' => 'required|string|max:100',
            ]);

            // Retrieve the user based on the provided 'name'
            $user = User::where('name', $query['name'])->first();

            if (!$user) {
                // Handle the case when the user is not found
                return response()->json(['error' => 'User not found'], 404);
            }

            $rows = Fingerprint::where('user_id', $user->id)
                ->whereBetween('created_at', [$query['from'], $query['to']])
                ->whereNotNull('time_attendance')
                ->get();

            $result = ['data' => []];
            foreach ($rows as $row) {
                $overtimeData = $this->calculateAttendance($row, $row->time_attendance, $row->time_departure);

                // Add the user's name to the "overtime" data
                $overtimeData['overtime'][0]['name'] = $user->name;

                $result['data'][] = $overtimeData;
            }

            return response()->json(['message' => 'Successfully', 'result' => $result]);
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }



    private function calculateAttendance($row, $startTime, $endTime)
    {
        $totalTime = $this->subtractTime($startTime, $endTime);
        $overtime = $this->subtractTime_two($totalTime, '08:00:00', $totalTime, $row);

        return ['overtime' => [$overtime]];
    }

    private function subtractTime($initialHour, $finalHour)
    {
        return Carbon::createFromFormat('g:i:s a', $finalHour)
            ->diff(Carbon::createFromFormat('g:i:s a', $initialHour))
            ->format('%H:%I:%S');
    }

    private function subtractTime_two($initialHour, $finalHour, $totalTime, $row)
    {
        $initialTime = Carbon::parse($initialHour);
        $finalTime = Carbon::parse($finalHour);

        if ($initialTime > $finalTime) {
            $initialTime->addDay();
            $status = 'increased';
        } else {
            $status = 'decrease';
        }

        $diff = $initialTime->diff($finalTime)->format('%H:%I:%S');

        // Add the calculated difference to the $row object
        $row['difference'] = $diff;
        $row['status'] = $status;
        $row['time'] = $totalTime;
        return $row;
    }
}
