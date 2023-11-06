<!-- eslint-disable import/no-unresolved -->
<script setup>
import ShowMyReport from "@/views/pages/reports/elemants/ShowMyReport.vue";
import EmployeesReports from "@/views/pages/reports/elemants/EmployeesReports.vue";
import AddReport from "@/views/pages/reports/elemants/AddReport.vue";
import { useRoute } from "vue-router";
const route = useRoute();
import { useStore } from "vuex";
const store = useStore();
const activeTab = ref(route.params.tab);
const Tabs = [
  {
    title: "add my report",
    icon: "bx-lock-open",
    tab: "add-report",
  },
  {
    title: "show my report",
    icon: "bx-lock-open",
    tab: "show-my-report",
  },
  {
    title: "employees reports",
    icon: "bx-lock-open",
    tab: "employees-reports",
  },
];
</script>

<template>
  <div>
    <VTabs v-model="activeTab" show-arrows>
      <VTab v-for="item in Tabs" :key="item.icon" :value="item.tab">
        <VIcon size="20" start :icon="item.icon" />
        {{ item.title }}
      </VTab>
    </VTabs>
    <VDivider />
    <VWindow v-model="activeTab" class="mt-5 disable-tab-transition">
      <!-- employees-reports -->
      <VWindowItem
        value="employees-reports"
        v-if="store.state.auth.user.data.type === 'suppe_admin'"
      >
        <EmployeesReports />
      </VWindowItem>
      <!-- add-report -->
      <VWindowItem value="add-report">
        <AddReport />
      </VWindowItem>
      <!-- show-my-report -->
      <VWindowItem value="show-my-report">
        <ShowMyReport />
      </VWindowItem>
    </VWindow>
  </div>
</template>
