<!-- eslint-disable import/no-unresolved -->
<script setup>
import { ref } from "vue";
import { api } from "@/helper/api";

const messages = ref([]);
// Data properties
function getCurrentTime() {
  const now = new Date();
  let hours = now.getHours();
  const ampm = hours >= 12 ? "pm" : "am";
  hours = hours % 12 || 12; // Convert 0 to 12 for 12-hour format
  const minutes = now.getMinutes().toString().padStart(2, "0");
  const seconds = now.getSeconds().toString().padStart(2, "0");
  return `${hours}:${minutes}:${seconds} ${ampm}`;
}

const setAbsence = async() => {
  try {
    const currentTime = getCurrentTime()
    const response = await api.post("add-time-absence" ,{
      absence: currentTime,
    } );
    // eslint-disable-next-line sonarjs/no-redundant-boolean
    if (response.status == 201 ||response.data.success == true){
      const message = "You are absent now";
      messages.value.push({ text: message, color: "success" });
    }
    console.log(response);
  } catch (error) {
    console.error(error);
  }
}

</script>

<template>
  <div>
    <v-alert
      v-for="(msg, index) in messages"
      :key="index"
      closable="closable"
      close-label="closeLabel"
      :color="msg.color"
      :title="msg.text"
    />


    <VTable class="mb-5">
      <thead>
        <tr>
          <th class="text-uppercase">Name</th>
          <th>Absence</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>{{ this.$store.state.auth.user.data.name }}</td>
          <td class="text-center">
            <VBtn @click="setAbsence">
              <VIcon icon="bx-fingerprint" size="35" color="success" />
            </VBtn>
          </td>
        </tr>
      </tbody>
    </VTable>
  </div>
</template>
