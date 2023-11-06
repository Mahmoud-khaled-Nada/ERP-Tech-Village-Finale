<template>
  <v-alert
    v-if="showAlert"
    class="main"
    :closable="closable"
    :close-label="closeLabel"
    :color="color"
    :title="title"
  >
    {{ text }}
  </v-alert>
</template>

<script>
export default {
  props: {
    closable: {
      type: Boolean,
      default: true,
    },
    closeLabel: {
      type: String,
      default: "Close Alert",
    },
    color: {
      type: String,
      default: "success",
    },
    title: {
      type: String,
      default: "Closable Alert",
    },
    text: {
      type: String,
      default: "",
    },
  },
  data() {
    return {
      showAlert: false,
    };
  },
  mounted() {
    this.showAlert = true;
    setTimeout(() => {
      this.showAlert = false;
    }, 5000); // 5 seconds
  },
};
</script>

<style scoped>
.main {
  position: absolute;
  top: 10px;
  right: 26%;
}
</style>
