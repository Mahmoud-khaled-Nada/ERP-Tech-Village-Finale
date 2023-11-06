<!-- eslint-disable import/no-unresolved -->
<script setup>
import { useTheme } from 'vuetify'
import UpgradeToPro from '@/components/UpgradeToPro.vue'
import { hexToRgb } from '@layouts/utils'
import { onMounted } from 'vue'
import { useStore } from "vuex";
import { useRouter } from "vue-router";
const store = useStore();
const router = useRouter();
const { global } = useTheme()



// onMounted(() =>{
//   expireToken() 
// })
// function expireToken() {
//   setTimeout(async () => {
//     await store.dispatch("logout");
//     router.push({ path: "/login" }); 
//   }, 3600000);
// }

</script>

<template>
  <VApp :style="`--v-global-theme-primary: ${hexToRgb(global.current.value.colors.primary)}`">
    <RouterView />
    <UpgradeToPro />
  </VApp>
</template>
