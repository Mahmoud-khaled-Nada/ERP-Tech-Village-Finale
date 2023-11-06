<!-- eslint-disable import/no-unresolved -->
<script setup>
import moment from "moment";
import { ref } from "vue";
import { api } from "@/helper/api";

// Data properties
// const message = ref("");
const timeAttendanceDeparture = ref([]);
// Function to get current time
function getCurrentTime() {
  const now = new Date();
  let hours = now.getHours();
  const ampm = hours >= 12 ? "pm" : "am";
  hours = hours % 12 || 12; // Convert 0 to 12 for 12-hour format
  const minutes = now.getMinutes().toString().padStart(2, "0");
  const seconds = now.getSeconds().toString().padStart(2, "0");
  return `${hours}:${minutes}:${seconds} ${ampm}`;
}

// Function to handle attendance
async function attendance() {
  try {
    const currentTime = getCurrentTime();
    console.log(currentTime);
    const request = await api.post("/add-time-attendance", {
      time_attendance: currentTime,
    });
    getTimeAttendanceDeparture()
  } catch (error) {
    console.log(error);
  }
}

// Function to handle departure
async function departure(id) {
  try {
    const currentTime = getCurrentTime();
    const request = await api.post(`/add-time-departure/${id}`, {
      time_departure: currentTime,
    });
    getTimeAttendanceDeparture()
  } catch (error) {
    console.log(error);
  }
}

// Function to fetch and format time attendance departure data
async function getTimeAttendanceDeparture() {
  try {
    const response = await api.get("/get-time-attendance-departure");
    const data = response.data.data;

    formatDateTimeInArray(data);

    timeAttendanceDeparture.value = data;
  } catch (error) {
    console.error("Error fetching time attendance departure data:", error);
  }
}

// Function to format date and time in an array of objects
function formatDateTimeInArray(data) {
  for (const entry of data) {
    entry.created_at = formatDate(entry.created_at);
  }

  function formatDate(dateTime) {
    const dt = moment(dateTime);
    return dt.format("YYYY-MM-DD");
  }
}

onMounted(() => {
  getTimeAttendanceDeparture();
});
</script>

<template>
  <div>
    <v-alert
      v-if="Message"
      closable="closable"
      close-label="closeLabel"
      color="success"
      :title="Message"
    />


    <VTable class="mb-5">
      <thead>
        <tr>
          <th class="text-uppercase">Name</th>
          <th>Attendance</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>{{ this.$store.state.auth.user.data.name }}</td>
          <td class="text-center">
            <VBtn @click="attendance">
              <VIcon icon="bx-fingerprint" size="35" color="success" />
            </VBtn>
          </td>
        </tr>
      </tbody>
    </VTable>

   
    <VTable>
      <thead>
        <tr>
          <th v-if="timeAttendanceDeparture">Date</th>
          <th v-if="timeAttendanceDeparture">Attendance At</th>
          <th v-if="timeAttendanceDeparture">Departure At</th>
        </tr>
      </thead>
      <tbody>
        <tr
          v-for="(ele, index) in timeAttendanceDeparture"
          :key="index"
        >
          <td v-if="timeAttendanceDeparture">
            <VChip label color="primary" size="small">{{
              ele.created_at
            }}</VChip>
          </td>
          <td class="text-center" v-if="timeAttendanceDeparture">
            <VChip label color="success" size="small">{{
              ele.time_attendance
            }}</VChip>
          </td>
          <td class="text-center" v-if="timeAttendanceDeparture">
            <VBtn @click="departure(ele.id)" v-if="!ele.time_departure">
              <VIcon icon="bx-fingerprint" size="35" color="success" />
            </VBtn>
            <VChip label color="success" size="small" v-if="ele.time_departure">
              {{ele.time_departure}}
            </VChip>
          </td>
        </tr>
      </tbody>
    </VTable>
  </div>
</template>
