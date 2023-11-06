<!-- eslint-disable import/no-unresolved -->
<script setup>
import { useTheme } from "vuetify";
import illustrationJohnDark from "@images/cards/illustration-john-dark.png";
import illustrationJohnLight from "@images/cards/illustration-john-light.png";

const { global } = useTheme();
const illustrationJohn = computed(() =>
  global.name.value === "dark" ? illustrationJohnDark : illustrationJohnLight
);
</script>

<template>
  <VCard class="text-center text-sm-start">
    <VRow no-gutters>
      <VCol cols="12"
            sm="8"
            order="2"
            order-sm="1"
      >
        <VCardItem>
          <VCardTitle class="text-md-h5 text-primary">
            Welcome to <b>Tech Village </b>Company
          </VCardTitle>
        </VCardItem>

        <VCardText>
          <span>Tech Village is one of the leading companies in designing
            digital solutions and online business marketing, including website,<br>
            mobile application, and social media, to build and develop online
            brands. For over 10 years 🤩 <br> Tech Village has been consistently
            providing the best digital marketing solutions for business and
            industrial sectors with the highest<br> quality and professional
            approach at competitive prices through a skilled team capable of
            innovating marketing solutions to build and develop online
            businesses.
          </span>
          <br>
          <!-- <VBtn variant="tonal" class="mt-4" size="small"> View Badges </VBtn> -->
        </VCardText>
      </VCol>

      <VCol cols="12"
            sm="4"
            order="1"
            order-sm="2"
            class="text-center"
      >
        <img
          :src="illustrationJohn"
          :height="$vuetify.display.xs ? '150' : '175'"
          :class="$vuetify.display.xs ? 'mt-6 mb-n2' : 'position-absolute'"
          class="john-illustration flip-in-rtl"
        >
      </VCol>
    </VRow>
  </VCard>
</template>

<style lang="scss" scoped>
.john-illustration {
  inset-block-end: -0.0625rem;
  inset-inline-end: 3rem;
}
</style>
