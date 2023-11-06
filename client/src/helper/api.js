/* eslint-disable import/no-unresolved */
import axios from "axios";
import store from "../store";
import router from "../router";
const api = axios.create({
  baseURL: import.meta.env.VITE_API_BASE_URL,
});


api.interceptors.request.use((config) => {
  config.headers.Authorization = `Bearer ${store.state.auth.user.token}`;
  return config;
});

api.interceptors.response.use(
  (response) => {
    return response;
  },
  (error) => {
    console.log(error);
    if (error.response.status === 401) {
      sessionStorage.removeItem("access_token");
      router.push({ path: "login" });
    } else if (error.response.status === 404) {
      router.push({ path: "error" });
    }
    return error;
  }
);

export { api };
