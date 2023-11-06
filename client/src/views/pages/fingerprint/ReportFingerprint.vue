<!-- eslint-disable import/no-unresolved -->
<script setup>
/** Imports */
import moment from "moment";
import { ref } from "vue";
import { api } from "@/helper/api";
import Loading from "@/components/Loading.vue";
import GetAllEmployeesName from "@/views/pages/components/GetAllEmployeesName.vue";
import { useStore } from "vuex";
const store = useStore();
/** Variable */
const data = ref({
  name: "",
  from: "",
  to: "",
});
const message = ref("");
const alertColor = ref("");
const isLoading = ref(false);
const getAttendanceDeparture = ref([]);
const userInfo = ref(store.state.auth.user.data);
//this.$store.state.auth.user.data.type
/** Functions */

const fetchDataFromApi = async () => {
  try {
    return await api.post("call-time-attendance-departure", data.value);
  } catch (error) {
    console.error(error.message);
    return error;
  }
};

async function getCallTimeAttendanceDeparture() {
  console.log(data.value);
  try {
    isLoading.value = true;
    const response = await fetchDataFromApi();
    if (response instanceof Error) {
      alertColor.value = "error";
      message.value = response.response.data.error;
    }
    handleApiResponse(response);
    isLoading.value = false;
  } catch (error) {
    console.error(error.message);
  }
}

function handleApiResponse(response) {
  if (response.statusText === "OK") {
    getAttendanceDeparture.value = response.data.result;
    logOvertimeCreatedDates(getAttendanceDeparture.value.data);
    alertColor.value = "success";
    message.value = "Data loaded successfully";
  }
}

const logOvertimeCreatedDates = (data) => {
  for (const entry of data) {
    for (const overtime of entry.overtime) {
      const created_at = moment(overtime.created_at);
      overtime.created_at = created_at.format("YYYY-MM-DD");
    }
  }
};
</script>
<template>
  <VContainer fluid>
    <v-alert
      v-if="message"
      closable="closable"
      close-label="closeLabel"
      :color="alertColor"
      :title="message"
    />
    <VCard class="mb-4">
      <VCardText>
        <!-- 👉 Querys -->
        <VForm @submit.prevent="getCallTimeAttendanceDeparture">
          <VRow>
            <VCol cols="12" md="3">
              <GetAllEmployeesName
                v-if="userInfo.type === 'suppe_admin' || userType === 'admin'"
                v-model="data.name"
              />
              <VTextField
                v-else
                v-model="data.name"
                :value="userInfo.name ? (data.name = userInfo.name) : ''"
                label="Name"
                readonly
              />
            </VCol>
            <VCol cols="12" md="3">
              <VTextField v-model="data.from" type="date" label="From" />
            </VCol>
            <VCol cols="12" md="3">
              <VTextField v-model="data.to" type="date" label="To" />
            </VCol>
            <VCol cols="12" md="3" class="mt-2">
              <VBtn class="mx-4" type="submit"> Submit </VBtn>
              <VBtn type="reset" color="secondary" variant="tonal">
                Reset
              </VBtn>
            </VCol>
          </VRow>
        </VForm>
      </VCardText>
    </VCard>

    <VTable>
      <thead>
        <tr>
          <th class="text-uppercase">#</th>
          <th>Name</th>
          <th>Date</th>
          <th>Attendance</th>
          <th>Departure</th>
          <th>Time</th>
          <th>Status</th>
          <th>Total</th>
          <th v-if="userInfo.type === 'suppe_admin'">Edit</th>
          <th v-if="userInfo.type === 'suppe_admin'">Delete</th>
        </tr>
      </thead>
      <tbody>
        <Loading v-if="isLoading" />
        <tr v-for="(item, index) in getAttendanceDeparture.data" :key="index">
          <td>{{ index + 1 }}</td>
          <td>{{ item.overtime[0].name }}</td>
          <td>{{ item.overtime[0].created_at }}</td>
          <td>{{ item.overtime[0].time_attendance }}</td>
          <td>{{ item.overtime[0].time_departure }}</td>
          <td>{{ item.overtime[0].time }}</td>
          <td>
            <VChip
              label
              :color="[
                item.overtime[0].status == 'decrease' ? 'error' : 'success',
              ]"
              size="small"
            >
              {{ item.overtime[0].status }}
            </VChip>
          </td>
          <td
            :style="[
              item.overtime[0].status === 'decrease'
                ? 'color: red'
                : 'color: green',
            ]"
          >
            {{ item.overtime[0].difference }}
          </td>

          <td class="text-center" v-if="userInfo.type === 'suppe_admin'">
            <VBtn
              color="info"
              variant="tonal"
              class="mt-4"
              size="small"
              @click="setEditEmployee(item.id)"
            >
              <VIcon icon="bx-edit" />
            </VBtn>
          </td>
          <td class="text-center" v-if="userInfo.type === 'suppe_admin'">
            <VBtn
              color="error"
              variant="tonal"
              class="mt-4"
              size="small"
              @click="setDeleteEmployee(item.id)"
            >
              <VIcon icon="bxs-comment-x" />
            </VBtn>
          </td>
        </tr>
      </tbody>
    </VTable>
  </VContainer>
</template>
