<template>
  <v-container fluid>
    <v-row>
      <v-alert
        v-if="message"
        :closable="true"
        close-label="Close"
        :color="color"
        :title="message"
      />
      <v-col cols="12" md="12">
        <v-card title="Add New Report">
          <v-card-text>
            <v-form @submit.prevent="addNewReport">
              <v-row>
                <v-col cols="12" md="3">
                  <VTextField
                    v-model="data.employees_name"
                    :value="
                      this.$store.state.auth.user.data.name
                        ? (data.employees_name =
                            this.$store.state.auth.user.data.name)
                        : ''
                    "
                    label="Empolyee Name"
                    placeholder="John-xxx"
                    readonly
                  />
                </v-col>
                <v-col cols="12" md="3">
                  <v-text-field
                    v-model="data.project_name"
                    label="Project Name"
                    placeholder="John"
                  />
                </v-col>
                <v-col cols="12" md="3">
                  <v-text-field
                    v-model="data.numbers_hours"
                    label="Number Hours"
                    placeholder="5 Hours"
                  />
                </v-col>
                <v-col cols="12" md="3">
                  <v-text-field
                    v-model="data.report_date"
                    type="date"
                    label="Date"
                  />
                </v-col>
                <v-col cols="12">
                  <!-- CKEditor Component -->
                  <ckeditor
                    v-model="data.report_data"
                    :editor="editor"
                    :config="editorConfig"
                    style="height: 500px"
                  />
                </v-col>
                <v-col cols="12" class="d-flex gap-4">
                  <v-btn type="submit"> Submit </v-btn>
                  <v-btn type="reset" color="secondary" variant="tonal">
                    Reset
                  </v-btn>
                </v-col>
              </v-row>
            </v-form>
          </v-card-text>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import ClassicEditor from "@ckeditor/ckeditor5-build-classic";
// eslint-disable-next-line import/no-unresolved
import { api } from "@/helper/api";
export default {
  name: "App",
  data() {
    return {
      editor: ClassicEditor,
      editorConfig: {},
      data: {
        report_data: "",
        employees_name: "",
        project_name: "",
        numbers_hours: "",
        report_date: "",
      },
      message: null,
      color: "",
    };
  },

  methods: {
    async addNewReport() {
      try {
        const req = await api.post("/add-new-report", this.data);
        if (req.statusText === "OK") {
          this.color = "success";
          this.message = req.data.message;
          console.log(this.message);
        } else {
          this.color = "error";
          this.message = "Please enter a report again";
        }
      } catch (error) {
        console.log(error);
      }
    },
  },
};
</script>
