 /* eslint-disable import/no-unresolved */
import '@/@iconify/icons-bundle'
import App from '@/App.vue'
import vuetify from '@/plugins/vuetify'
import { loadFonts } from '@/plugins/webfontloader'
import router from '@/router'
import store from '@/store'
import '@core/scss/template/index.scss'
import '@layouts/styles/index.scss'
import '@styles/styles.scss'

/** start quill */
import CKEditor from '@ckeditor/ckeditor5-vue';

/** end  quill */ 

import { createPinia } from 'pinia'
import { createApp } from 'vue'

loadFonts()


// Create vue app
const app = createApp(App)
app.use(vuetify)
app.use(createPinia())
app.use(router)
app.use(store)
app.use(CKEditor)

// Mount vue app
app.mount('#app')


