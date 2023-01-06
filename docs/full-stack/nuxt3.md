# Nuxt 3 - Vue based Web Framework

<!--- cSpell:ignore Nuxt pinia vuetify nuxi sass vueuse -->

[Nuxt](https://nuxt.com){: target=_blank} is a web framework build on Vue.js.  It provides a number of features which speeds up development over standard [Vue.js](https://vuejs.org){: target=blank}.

Technology used for full stack development

## Front end technology stack

| Technology | Purpose |
|------------|---------|
| [nuxt 3](https://nuxt.com){: target=_blank} | Vue.js based framework |
| [vite](https://vitejs.dev){: target=_blank} | Frontend tooling |
| [vitest](https://vitest.dev){: target=_blank} | Test framework (jest compatible) |
| [pinia](https://pinia.vuejs.org){: target=_blank} | Vue store for state management |
| [vuetify](https://next.vuetifyjs.com/en/){: target=_blank} | Vue component framework |
| [VueUse](https://vueuse.org){: target=_blank} | Collection of Vue Composition utilities |

## Front end project start and config

1. `npx nuxi init test-project`
2. `cd test-project`
3. `npm install`

### Integrate Vuetify in the project

1. `npm install vuetify@next @mdi/font sass`
2. start code editor (`code ,`)
3. create a folder in the project root named **plugins**
4. create a file in the plugins folder named **vuetify.ts** with the following content:

    ```ts
    // plugins/vuetify.ts
    import { createVuetify } from 'vuetify'
    import * as components from 'vuetify/components'
    import * as directives from 'vuetify/directives'

    export default defineNuxtPlugin(nuxtApp => {
    const vuetify = createVuetify({
        components,
        directives,
    })

    nuxtApp.vueApp.use(vuetify)
    })
    ```
5. modify the **nuxi.config.ts** file to integrated Vuetify into the Nuxt build process, update the **defineNuxtConfig** object definition so it looks like:

    ```ts
    export default defineNuxtConfig({
        css: [
                'vuetify/lib/styles/main.sass',
                '@mdi/font/css/materialdesignicons.min.css'
            ],
        build: {
        transpile: ['vuetify'],
        },
        vite: {
        define: {
            'process.env.DEBUG': false,
        },
        },
    })
    ```

## Add VueUse utilities

1. `npm i -D @vueuse/nuxt`
2. Edit the **nuxt.config.ts** file and add the @vueuse/nuxt module:

    ```ts
    export default defineNuxtConfig({
        modules: [
            '@vueuse/nuxt'
        ],
        ...
    })
    ```

## Add test tooling

1. `npm i -D vitest @vue/test-utils@next @vitest/coverage-c8 @vitest/ui`
2. Update **package.json** to add test runner commands.  In the scripts section add the following lines:

    ```json
    ...
    "scripts": {
        "test": "vitest",
        "coverage": "vitest run --coverage",
        "test-watch": "vitest -w --ui --open --coverage",
        ...
    },
    ...    
    }
    ```
