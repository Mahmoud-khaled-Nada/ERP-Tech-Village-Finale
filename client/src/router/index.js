/* eslint-disable import/no-unresolved */
import { createRouter, createWebHistory } from "vue-router"
import store from "@/store"
const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    { path: "/", redirect: "/dashboard" },
    {
      path: "/",
      component: () => import("../layouts/default.vue"),
      meta: { requiresAuth: true },
      children: [
        {
          path: "dashboard",
          component: () => import("../pages/dashboard.vue"),
        },
        {
          path: "employees",
          component: () => import("../pages/employees.vue"),
        },
        {
          path: "fingerprint",
          component: () => import("../pages/fingerprint.vue"),
        },
        {
          path: "reports",
          component: () => import("../pages/reports.vue"),
        },
        {
          path: "test",
          component: () => import("../views/pages/test.vue"),
        },
      ],
    },
    {
      path: "/",
      component: () => import("../layouts/blank.vue"),
      meta: { isGuest: true },
      children: [
        {
          path: "login",
          component: () => import("../pages/login.vue"),
        },
        // {
        //   path: "register",
        //   component: () => import("../pages/register.vue"),
        // },
        {
          path: "/:pathMatch(.*)*",
          component: () => import("../pages/[...all].vue"),
        },
      ],
    },
  ],
});

router.beforeEach((to, from, next) => {
  if (to.meta.requiresAuth && !store.state.auth.user.token) {
    next({ path: "login" });
  } else if (store.state.auth.user.token && to.meta.isGuest) {
    next({ path: "dashboard" });
  } else {
    next();
  }
});

export default router;
