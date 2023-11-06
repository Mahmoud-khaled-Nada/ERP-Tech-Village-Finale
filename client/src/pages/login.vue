<!-- eslint-disable import/no-unresolved -->
<script setup>
import { useStore } from "vuex";
import { useRouter } from "vue-router";
import { ref } from "vue";
const router = useRouter();
const store = useStore();
// const messages = ref([]);
const form = ref({
  email: "",
  password: "",
  remember: false,
});
const isPasswordVisible = ref(false);
const snackbar = ref(false);
const messages = ref([]);
async function Login() {
  try {

    const data = await store.dispatch("login", form.value);
    messages.value = [];
    if (data.access_token) {
      router.push({ path: "dashboard" });
    } else if (data.status == 401) {
      snackbar.value = true;
      messages.value.push({ text: data.data.error, color: "error" });
    }else {
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

    <div class="auth-wrapper d-flex align-center justify-center">
      <VCard class="auth-card" max-width="448">
        <VCardItem class="justify-center">
          <template #prepend>
            <div class="d-flex">
              <img src="../assets/tecvillage.png" />
            </div>
          </template>
        </VCardItem>
        <VCardText class="pt-2">
          <h5 class="text-h5 mb-1">Welcome to Tech village! 👋🏻</h5>
          <p class="mb-0">
            Please sign-in to your account and start the adventure
          </p>
        </VCardText>

        <VCardText>
          <VForm @submit.prevent="Login">
            <VRow>
              <!-- email -->
              <VCol cols="12">
                <VTextField
                  v-model="form.email"
                  autofocus
                  placeholder="E-mail@email.com"
                  label="Email"
                  type="email"
                />
              </VCol>

              <!-- password -->
              <VCol cols="12">
                <VTextField
                  v-model="form.password"
                  label="Password"
                  placeholder="············"
                  :type="isPasswordVisible ? 'text' : 'password'"
                  :append-inner-icon="isPasswordVisible ? 'bx-hide' : 'bx-show'"
                  @click:append-inner="isPasswordVisible = !isPasswordVisible"
                />

                <!-- remember me checkbox -->
                <div
                  class="d-flex align-center justify-space-between flex-wrap mt-1 mb-4"
                >
                  <VCheckbox v-model="form.remember" label="Remember me" />

                  <RouterLink
                    class="text-primary ms-2 mb-1"
                    to="javascript:void(0)"
                  >
                    Forgot Password?
                  </RouterLink>
                </div>

                <!-- login button -->
                <VBtn block type="submit"> Login </VBtn>
              </VCol>

              <!-- create account -->
              <!-- <VCol cols="12" class="text-center text-base">
              <span>New on our platform?</span>
              <RouterLink class="text-primary ms-2" to="/register">
                Create an account
              </RouterLink>
            </VCol>

            <VCol cols="12" class="d-flex align-center">
              <VDivider />
              <span class="mx-4">or</span>
              <VDivider />
            </VCol> -->

              <!-- auth providers -->
              <!-- <VCol cols="12" class="text-center">
              <AuthProvider />
            </VCol> -->
            </VRow>
          </VForm>
        </VCardText>
      </VCard>
    </div>
  </div>
</template>

<style lang="scss">
@use "@core/scss/template/pages/page-auth.scss";
</style>
