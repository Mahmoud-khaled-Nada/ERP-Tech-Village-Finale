<!-- eslint-disable import/no-unresolved -->
<script setup>
import { ref, defineProps, onUpdated } from "vue";
import { api } from "@/helper/api";
const dialog = ref(false);

const props = defineProps({
  getAllEmployees: {
    type: Function,
    required: true,
  },
});
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

async function addNewEmployee() {
  try {
    dialog.value = true;
    await api.post("/auth/register", data.value);
    dialog.value = false;
    await props.getAllEmployees();
  } catch (error) {
    console.error(error);
  }
}
</script>

<template>
  <VDialog v-model="dialog" persistent width="1024">
    <template #activator="{ props }">
      <VBtn color="primary" v-bind="props"> Add new employees </VBtn>
    </template>
    <VCard>
      <VForm @submit.prevent="addNewEmployee">
        <VCard-title>
          <span class="text-h5">Add New Employee</span>
        </VCard-title>
        <VCard-text>
          <VContainer>
            <VRow>
              <VCol cols="12" sm="6">
                <VText-field v-model="data.name" label="Name*" />
              </VCol>
              <VCol cols="12" sm="6">
                <VText-field v-model="data.title_job" label="Title-job*" />
              </VCol>
              <VCol cols="12" sm="6">
                <VText-field v-model="data.email" label="Email*" />
              </VCol>
              <VCol cols="12" sm="6">
                <VText-field
                  v-model="data.password"
                  label="Password*"
                  type="password"
                />
              </VCol>
              <VCol cols="12" sm="6">
                <VText-field
                  type="date"
                  v-model="data.date_contract"
                  label="Date-Contract*"
                />
              </VCol>
              <VCol cols="12" sm="6">
                <VText-field v-model="data.section" label="Section" />
              </VCol>
              <VCol cols="12" sm="6">
                <VText-field v-model="data.image" label="URL-Image*" />
              </VCol>
              <VCol cols="12" sm="6">
                <VSelect
                  v-model="data.type"
                  :items="['suppe_admin' ,'admin', 'user']"
                  label="Type*"
                />
              </VCol>
            </VRow>
          </VContainer>
        </VCard-text>
        <VCardActions>
          <VCpacer />
          <VBtn color="blue-darken-1" variant="text" @click="dialog = false">
            Close
          </VBtn>
          <VBtn type="submit" color="blue-darken-1" variant="text"> Save </VBtn>
        </VCardActions>
      </VForm>
    </VCard>
  </VDialog>
</template>
<style scoped>
.add-empl-btn {
  display: flex;
  justify-content: space-between;
  align-items: center;
}
</style>
