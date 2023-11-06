<!-- eslint-disable import/no-unresolved -->
<script setup>
import { useRoute } from "vue-router";
import DeveloperEmployees from "@/views/pages/employees/DeveloperEmployees.vue";

const route = useRoute();
const activeTab = ref(route.params.tab);

// tabs
const tabs = [
  {
    title: "Developer",
    icon: "bx-lock-open",
    tab: "developer",
  },
];
</script>

<template>
  <div>
    <!-- <VTabs v-model="activeTab" show-arrows>
      <VTab v-for="item in tabs" :key="item.icon" :value="item.tab">
        <VIcon size="20" start :icon="item.icon" />
        {{ item.title }}
      </VTab>
    </VTabs>
    <VDivider /> -->

    <VWindow v-model="activeTab" class="mt-5 disable-tab-transition">
      <!-- developer -->
      <VWindowItem value="developer">
        <DeveloperEmployees />
      </VWindowItem>
    </VWindow>
  </div>
</template>
