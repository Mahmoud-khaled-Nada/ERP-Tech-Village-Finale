<!-- eslint-disable import/no-unresolved -->
<script setup>
/** Imports */
import Loading from "@/components/Loading.vue";
import AddNewEmployees from "@/views/pages/employees/AddEmployees.vue";
import { api } from "@/helper/api";
import { onMounted, ref } from "vue";

/** Variable */
const AllEmployees = ref(null);
const dialog = ref(false);
const isLoading = ref(false);
const snackbar = ref(false);
const messages = ref([]);
const getEditId = ref("");
const data = ref({
  name: "",
  email: "",
  title_job: "",
  image: "",
  password: "",
  date_contract: "",
  section: "",
  type: "",
});

/** Functions */
async function getAllEmployees() {
  try {
    isLoading.value = true;
    const data = await api.get("/get-all-employees");
    isLoading.value = false;
    AllEmployees.value = data.data;
  } catch (error) {
    alert(error.message);
  }
}

async function setEditEmployee(id) {
  try {
    getEditId.value = id;
    dialog.value = true;
    const response = await api.post(`/edit-employee/${id}`);
    const responseData = await response.data;
    data.value.name = await responseData.name;
    data.value.email = await responseData.email;
    data.value.title_job = await responseData.title_job;
    data.value.image = await responseData.image;
    data.value.date_contract = await responseData.date_contract;
    data.value.section = await responseData.section;
    data.value.type = await responseData.type;
  } catch (error) {
    alert(error.message);
  }
}

async function setUpdateEmployee() {
  try {
    messages.value = [];
    const inputValue = data.value;
    const id = getEditId.value;
    const response = await api.put(`/update-employee/${id}`, inputValue);
    const message = response.data.message;
    messages.value.push({ text: message, color: "success" });
    snackbar.value = true;
    dialog.value = false;
    await getAllEmployees();
  } catch (error) {
    console.log(error);
  }
}

async function setDeleteEmployee(id) {
  try {
    messages.value = [];
    const response = await api.delete(`/delete-employee/${id}`);
    dialog.value = false;
    const message = response.data.message;
    messages.value.push({ text: message, color: "success" });
    snackbar.value = true;
    await getAllEmployees();
  } catch (error) {
    console.log(error);
  }
}

onMounted(async () => {
  await getAllEmployees();
});
</script>

<template>
  <div>
    <div class="text-center">
      <v-snackbar v-model="snackbar" multi-line>
        <template v-for="(msg, index) in messages" :key="index">
          <div>{{ msg.text }}</div>
        </template>
        <template #actions>
          <v-btn
            :color="messages[0].color"
            variant="text"
            @click="snackbar = false"
          >
            Close
          </v-btn>
        </template>
      </v-snackbar>
    </div>
    <Loading v-if="isLoading" />
    <div class="add-new-employees">
      <AddNewEmployees :get-all-employees="getAllEmployees" />
    </div>
    <VTable density="compact">
      <thead>
        <tr>
          <th class="text-uppercase">
            #
          </th>
          <th>Image</th>
          <th>Name</th>
          <th>Email</th>
          <th>Job Title</th>
          <th>Section</th>
          <th>Type</th>
          <th>Date Contract</th>
          <th>Edit</th>
          <th>Delete</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="(item, index) in AllEmployees"
            :key="index"
            height="60px"
        >
          <td>{{ index + 1 }}</td>
          <td class="text-center">
            <VAvatar color="primary"
                     variant="tonal"
            >
              <VImg :src="item.image"
              />
            </VAvatar>
          </td>
          <td class="text-center">
            <VChip label
                   color="primary"
                   size="small"
            >
              <v-icon start
                      icon="mdi-account-tie"
              />
              {{ item.name }}
            </VChip>
          </td>
          <td class="text-center">
            <v-icon start
                      icon="mdi-email"
              />
            {{ item.email }}
          </td>
          <td class="text-center">
            {{ item.title_job }}
          </td>
          <td class="text-center">
            {{ item.section }}
          </td>
          <td class="text-center">
            {{ item.type }}
          </td>
          <td class="text-center">
            {{ item.date_contract }}
          </td>
          <td class="text-center">
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
          <td class="text-center">
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

    <VDialog v-model="dialog"
             persistent
             width="1024"
    >
      <VCard>
        <VForm @submit.prevent="setUpdateEmployee()">
          <VCard-title>
            <span class="text-h5">Edit Employee</span>
          </VCard-title>
          <VCard-text>
            <VContainer>
              <VRow>
                <VCol cols="12"
                      sm="6"
                >
                  <VText-field v-model="data.name"
                               label="Name*"
                  />
                </VCol>
                <VCol cols="12"
                      sm="6"
                >
                  <VText-field v-model="data.title_job"
                               label="Title-job*"
                  />
                </VCol>
                <VCol cols="12"
                      sm="6"
                >
                  <VText-field v-model="data.email"
                               label="Email*"
                  />
                </VCol>
                <VCol cols="12"
                      sm="6"
                >
                  <VText-field
                    v-model="data.password"
                    label="Password*"
                    type="password"
                  />
                </VCol>
                <VCol cols="12"
                      sm="6"
                >
                  <VText-field
                    v-model="data.date_contract"
                    label="Date-Contract*"
                  />
                </VCol>
                <VCol cols="12"
                      sm="6"
                >
                  <VText-field v-model="data.section"
                               label="Section"
                  />
                </VCol>
                <VCol cols="12"
                      sm="6"
                >
                  <VText-field v-model="data.image"
                               label="URL-Image*"
                  />
                </VCol>
                <VCol cols="12"
                      sm="6"
                >
                  <VSelect
                    v-model="data.type"
                    :items="['admin', 'supperAdmin', 'normal']"
                    label="Type*"
                  />
                </VCol>
              </VRow>
            </VContainer>
          </VCard-text>
          <VCardActions>
            <VCpacer />
            <VBtn color="blue-darken-1"
                  variant="text"
                  @click="dialog = false"
            >
              Close
            </VBtn>
            <VBtn type="submit"
                  color="blue-darken-1"
                  variant="text"
            >
              Save
            </VBtn>
          </VCardActions>
        </VForm>
      </VCard>
    </VDialog>
  </div>
</template>

<style scoped>
.add-new-employees {
  position: absolute;
  top: 9%;
  left: 73rem;
}
</style>
