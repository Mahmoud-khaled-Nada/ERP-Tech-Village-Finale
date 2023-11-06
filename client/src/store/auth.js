/* eslint-disable import/no-unresolved */
import { api } from "@/helper/api";
const authModule = {
  state: {
    user: {
      data: {},
      token: sessionStorage.getItem("ACCESS_TOKEN"),
    },
  },
  getters: {},
  actions: {
    async login({ commit }, user) {
      try {
        const response = await api.post("/auth/login", user); // Changed "data" to "response"
        if (response.status == 200 || response.statusText == "OK") {
          commit("setUser", response.data.user);
          commit("setToken", response.data.access_token);
          return response.data; // Return the data from the response
        } else if (response.response.status == 422) {
          return response.response.data;
        } else if (response.response.status == 401) {
          return response.response;
        }
      } catch (error) {
        console.error(error); // Use console.error to log errors
      }
    },
    async logout({ commit }) {
      try {
        const response = await api.post("/auth/logout");
        commit("logout");
        return response;
      } catch (error) {
        console.log(error);
      }
    },
    async getUser({ commit }) {
      try {
        const response = await api.get("/auth/user-profile");
        if (response.status == 200 || response.statusText == "OK") {
          commit("setUser", response.data);
          return response;
        } else {
          return response;
        }
      } catch (error) {
        console.log(error);
      }
    },
  },
  mutations: {
    logout: (state) => {
      state.user.token = null;
      state.user.data = {};
      sessionStorage.removeItem("ACCESS_TOKEN");
    },

    setUser: (state, user) => {
      state.user.data = user;
    },
    setToken: (state, token) => {
      state.user.token = token;
      sessionStorage.setItem("ACCESS_TOKEN", token)
    },
  },
};

export default authModule;
