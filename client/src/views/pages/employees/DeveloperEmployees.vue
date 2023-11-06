<!-- eslint-disable import/no-unresolved -->
<script setup>
import AllEmployees from "@/views/pages/employees/AllEmployees.vue";
// import AddNewEmployees from "@/views/pages/employees/add-employees.vue";
</script>

<template>
  <VRow>
    <VCol cols="12">
      <VCard title="Add a new employee">
        <VCardText>
          <div class="add-empl-btn">
            <span>
              This page allows you to <code>view, add, modify, and delete</code> employees.</span>
            <!-- <AddNewEmployees /> -->
          </div>
        </VCardText>
        <AllEmployees />
      </VCard>
    </VCol>
  </VRow>
</template>
<style scoped>
.add-empl-btn {
  display: flex;
  justify-content: space-between;
  align-items: center;
}
</style>
