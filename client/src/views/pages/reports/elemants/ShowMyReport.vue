<!-- eslint-disable import/no-unresolved -->
<script setup>
/** Imports */
import { ref } from "vue";
import { api } from "@/helper/api";
import Loading from "@/components/Loading.vue";
import { useStore } from "vuex";
const store = useStore();
/** Variable */
const data = ref({
  name: "",
  from: "",
  to: "",
});
const messages = ref([]);
const alertColor = ref("");
const isLoading = ref(false);
const openCards = ref([]);
const getDataRow = ref([]);
const userInfo = ref(store.state.auth.user.data);
/** Functions */
const fetchDataFromApi = async () => {
  try {
    return await api.post("get-report-by-name", data.value);
  } catch (error) {
    console.error(error.message);
    return error;
  }
};
async function getReportByName() {
  try {
    isLoading.value = true;
    const response = await fetchDataFromApi();
    if (response.status == 200 || response.statusText == "OK") {
      getDataRow.value = await response.data.result;
      alertColor.value = "success";
      const message = response.data.message;
      messages.value.push({ text: message, color: "success" });
    }
    if (response instanceof Error) {
      alertColor.value = "error";
      const message = response.data.message;
      messages.value.push({ text: message, color: "error" });
    }
    isLoading.value = false;
  } catch (error) {
    console.error(error.message);
  }
}
async function deleteMyReport(id) {
  try {
    isLoading.value = true;
    const response = await api.delete(`delete-my-report-by/${id}`);
    var element = document.querySelector(".rep-btn");
    element.click();
    const message = response.data.message;
    messages.value.push({ text: message, color: "success" });
    isLoading.value = false;
  } catch (error) {
    console.log(error);
  }
}

const toggleCard = (id) => {
  const index = openCards.value.indexOf(id);
  if (index === -1) {
    openCards.value.push(id);
  } else {
    openCards.value.splice(index, 1);
  }
};
const isCardOpen = (id) => {
  return openCards.value.includes(id);
};
</script>
<template>
  <VContainer fluid>
    <v-alert
      v-for="(msg, index) in messages"
      :key="index"
      closable="closable"
      close-label="closeLabel"
      :color="msg.color"
      :title="msg.text"
    />
    <VCard class="mb-4">
      <VCardText>
        <!-- 👉 Querys -->
        <VForm @submit.prevent="getReportByName">
          <VRow>
            <VCol cols="12"
                  md="3"
            >
              <VTextField
                v-model="data.name"
                :value="userInfo.name ? (data.name = userInfo.name) : ''"
                label="Name"
                readonly
              />
            </VCol>
            <VCol cols="12"
                  md="3"
            >
              <VTextField v-model="data.from"
                          type="date"
                          label="From"
              />
            </VCol>
            <VCol cols="12"
                  md="3"
            >
              <VTextField v-model="data.to"
                          type="date"
                          label="To"
              />
            </VCol>
            <VCol cols="12"
                  md="3"
                  class="mt-2"
            >
              <VBtn class="mx-4 rep-btn"
                    type="submit"
              >
                Submit
              </VBtn>
              <VBtn type="reset"
                    color="secondary"
                    variant="tonal"
              >
                Reset
              </VBtn>
            </VCol>
          </VRow>
        </VForm>
      </VCardText>
    </VCard>
    <Loading v-if="isLoading" />  
    <VRow no-gutters>
      <VCol
        v-for="(item, index) in getDataRow"
        :key="index"
        cols="12"
        sm="12"
        md="6"
        lg="6"
        order="12"
        order-lg="1"
      >
        <VCard class="mb-2 mr-2">
          <div class="card-header">
            <VBtn color="success"
                  variant="tonal"
            >
              {{ index + 1 }}
            </VBtn>
            <VBtn
              color="error"
              variant="text"
              icon="bxs-x-circle"
              @click="deleteMyReport(item.id)"
            />
          </div>
          <VCardText class="d-flex justify-center">
            <div class="me-auto">
              <p class="d-flex align-center mb-2">
                <VIcon color="primary"
                       icon="bx-user"
                />
                <span class="ms-3">Name: {{ item.employees_name }}</span>
              </p>
              <p class="d-flex align-center">
                <VIcon color="primary"
                       icon="bx-building-house"
                />
                <span class="ms-3">Project: {{ item.project_name }}</span>
              </p>
            </div>
            <VDivider v-if="$vuetify.display.smAndUp"
                      vertical
                      inset
            />
            <div class="ms-auto ps-4">
              <p class="d-flex align-center mb-2">
                <VIcon color="primary"
                       icon="bxs-calendar"
                />
                <span class="ms-3">Date: {{ item.report_date }}</span>
              </p>
              <p class="d-flex align-center">
                <VIcon color="primary"
                       icon="bxs-hourglass"
                />
                <span class="ms-3">Hours: {{ item.numbers_hours }}</span>
              </p>
            </div>
          </VCardText>
          <VCardText>
            <VDivider />
          </VCardText>
          <v-card-actions>
            <v-btn
              color="orange-lighten-2"
              variant="text"
              @click="toggleCard(item.id)"
            >
              explore more
            </v-btn>
            <v-spacer />

            <v-btn
              :icon="
                isCardOpen(item.id) ? 'mdi-chevron-up' : 'mdi-chevron-down'
              "
              @click="toggleCard(item.id)"
            />
          </v-card-actions>
          <v-expand-transition>
            <div v-show="isCardOpen(item.id)">
              <v-divider />
              <v-card-text v-html="item.report_data" />
            </div>
          </v-expand-transition>
        </VCard>
      </VCol>
    </VRow>
  </VContainer>
</template>

<style scoped>
.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: -20px;
  margin-top: -5px;
}
</style>
