
<template>
  <VSelect
    v-if="employeeName.length > 0"
    :key="index"
    label="Name"
    placeholder="Select Employee"
    :items="employeeName"
  />
</template>
<!-- eslint-disable import/no-unresolved -->
<script setup>
import { api } from "@/helper/api";
import { ref, onMounted } from "vue";

const employeeName = ref([]);

const getEmployeeName = async () => {
  try {
    const response = await api.get("get-all-employees-name");
    employeeName.value = response.data.map(element => element.name);
  } catch (error) {
    console.error(error);
  }
};

onMounted(() => {
  getEmployeeName();
});
</script>
