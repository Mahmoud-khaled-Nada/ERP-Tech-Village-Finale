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
//
/** Functions */

const fetchDataFromApi = async () => {
  try {
    return await api.post("get-time-absence", data.value);
  } catch (error) {
    console.error(error.message);
    return error;
  }
};

async function getCallTimeAttendanceDeparture() {
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
    logOvertimeCreatedDates(getAttendanceDeparture.value);
    alertColor.value = "success";
    message.value = "Data loaded successfully";
  }
}

const logOvertimeCreatedDates = (data) => {
  for (const entry of data) {
    const created_at = moment(entry.created_at);
    entry.created_at = created_at.format("YYYY-MM-DD");
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
      <thead class="bg-var-theme-background">
        <tr>
          <th class="text-right">#</th>
          <th class="text-right">Name</th>
          <th class="text-right">Date</th>
          <th>Absence</th>
        </tr>
      </thead>
      <tbody>
        <Loading v-if="isLoading" />
        <tr v-for="(item, index) in getAttendanceDeparture" :key="index">
          <td>{{ index + 1 }}</td>
          <td>{{ item.name }}</td>
          <td>
            <VChip label color="primary" size="small">
              <v-icon start icon="mdi-event"></v-icon>
              {{ item.created_at }}
            </VChip>
          </td>
          <td>
            <VChip label color="success" size="small">
              <v-icon start icon="mdi-clock-time-eight"></v-icon>
              {{ item.absence }}
            </VChip>
          </td>
        </tr>
      </tbody>
    </VTable>
  </VContainer>
</template>
