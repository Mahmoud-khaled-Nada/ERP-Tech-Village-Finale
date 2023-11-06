<!-- eslint-disable import/no-unresolved -->
<script setup>
import { useRoute } from "vue-router";
import AttendanceAndDeparture from "./AttendanceAndDeparture.vue";
import ReportFingerprint from "./ReportFingerprint.vue";
import Absence from "./Absence.vue";
import ReportAbsence from "./ReportAbsence.vue";

const route = useRoute();
const activeTab = ref(route.params.tab);

// tabs
const tabs = [
  {
    title: "Fingerprint",
    icon: "bx-fingerprint",
    tab: "fingerprint",
  },
  {
    title: "Report Fingerprint",
    icon: "bx-report",
    tab: "report-fingerprint",
  },
  {
    title: "Absence",
    icon: "bx-fingerprint",
    tab: "absence",
  },
  {
    title: "Report Absence",
    icon: "bx-report",
    tab: "report-absence",
  },
];
</script>

<template>
  <div>
    <VTabs v-model="activeTab" show-arrows>
      <VTab v-for="item in tabs" :key="item.icon" :value="item.tab">
        <VIcon size="20" start :icon="item.icon" />
        {{ item.title }}
      </VTab>
    </VTabs>
    <VDivider />

    <VWindow v-model="activeTab" class="mt-5 disable-tab-transition">
      <!-- fingerprint -->
      <VWindowItem value="fingerprint">
        <VRow>
          <VCol md="12" cols="12">
            <AttendanceAndDeparture />
          </VCol>
        </VRow>
      </VWindowItem>
      <!-- report-fingerprint -->
      <VWindowItem value="report-fingerprint">
        <VRow>
          <VCol md="12" cols="12">
            <ReportFingerprint />
          </VCol>
        </VRow>
      </VWindowItem>
      <VWindowItem value="absence">
        <VRow>
          <VCol md="12" cols="12">
            <Absence />
          </VCol>
        </VRow>
      </VWindowItem>
      <VWindowItem value="report-absence">
        <VRow>
          <VCol md="12" cols="12">
            <ReportAbsence />
          </VCol>
        </VRow>
      </VWindowItem>
    </VWindow>
  </div>
</template>
