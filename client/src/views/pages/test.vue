<script setup>
import { useStore } from "vuex";
import { useRouter } from "vue-router";
import { ref } from "vue";
const router = useRouter();
const store = useStore();
const messages = ref([]);
const form = ref({
  email: "",
  password: "",
  remember: false,
});
const isPasswordVisible = ref(false);
const snackbar = ref(false);
async function Login() {
const snackbar = ref(false);
async function Login() {
  try {
    const data = await store.dispatch("login", form.value);
    if (data.access_token) {
      router.push({ path: "dashboard" });
    } else {
      for (const field in data) {
        if (data.hasOwnProperty(field)) {
          const errorMessages = data[field];
          errorMessages.forEach((message) => {
            messages.value.push({ text: message, color: "error" });
            snackbar.value = true;
          });
        }
      }
    }
  } catch (error) {
    console.log("Error message:", error.message);
  }
}
}
</script>
<template>
    <div class="text-center">
      <v-snackbar
        v-model="snackbar"
        multi-line
        v-for="(msg, index) in messages"
        :key="index"
      >
        {{ msg.text }}

        <template v-slot:actions>
          <v-btn :color="msg.color" variant="text" @click="snackbar = false">
            Close
          </v-btn>
        </template>
      </v-snackbar>
    </div>
</template>

