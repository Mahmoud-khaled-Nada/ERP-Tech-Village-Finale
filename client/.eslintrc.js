module.exports = {
  env: {
    browser: true,
    es2021: true,
  },
  extends: [
    '.eslintrc-auto-import.json',
    'plugin:vue/vue3-recommended',
    'plugin:import/recommended',
    'plugin:promise/recommended',
    'plugin:sonarjs/recommended',

    // 'plugin:unicorn/recommended',
  ],
  parser: 'vue-eslint-parser',
  parserOptions: {
    ecmaVersion: 13,
    sourceType: 'module',
  },
  plugins: [
    'vue',
    'regex',
  ],
  ignorePatterns: ['src/@iconify/*.js', 'node_modules', 'dist'],
  rules: {
    'no-console': process.env.NODE_ENV === 'production' ? 'warn' : 'off',
    'no-debugger': process.env.NODE_ENV === 'production' ? 'warn' : 'off',

    // indentation (Already present in TypeScript)
    // 'comma-spacing': ['off', { before: false, after: true }],
    // 'key-spacing': ['off', { afterColon: true }],

    'vue/first-attribute-linebreak': ['off', {
      singleline: 'beside',
      multiline: 'below',
    }],


    // indentation (Already present in TypeScript)
    'indent': ['off', 2],

    // Enforce trailing comma (Already present in TypeScript)
    'comma-dangle': ['off', 'always-multiline'],

    // Enforce consistent spacing inside braces of object (Already present in TypeScript)
    'object-curly-spacing': ['off', 'always'],

    // Disable max-len
    'max-len': 'off',

    // we don't want it
    'semi': ['off', 'never'],

    // add parens ony when required in arrow function
    'arrow-parens': ['off', 'as-needed'],

    // add new line above comment
    'newline-before-return': 'off',

    // add new line above comment
    'lines-around-comment': [
      'off',
      {
        beforeBlockComment: true,
        beforeLineComment: true,
        allowBlockStart: true,
        allowClassStart: true,
        allowObjectStart: true,
        allowArrayStart: true,
      },
    ],

    // Ignore _ as unused variable

    'array-element-newline': ['off', 'consistent'],
    'array-bracket-newline': ['off', 'consistent'],

    'vue/multi-word-component-names': 'off',

    'padding-line-between-statements': [
      'off',
      { blankLine: 'always', prev: 'expression', next: 'const' },
      { blankLine: 'always', prev: 'const', next: 'expression' },
      { blankLine: 'always', prev: 'multiline-const', next: '*' },
      { blankLine: 'always', prev: '*', next: 'multiline-const' },
    ],

    // Plugin: eslint-plugin-import
    'import/prefer-default-export': 'off',
    'import/newline-after-import': ['off', { count: 1 }],
    'no-restricted-imports': ['off', 'vuetify/components'],

    // For omitting extension for ts files
    'import/extensions': ['off',
      'ignorePackages',
      {
        js: 'never',
        jsx: 'never',
        ts: 'never',
        tsx: 'never',
      },
    ],

    // ignore virtual files
    'import/no-unresolved': [2, {
      ignore: [
        '~pages$',
        'virtual:generated-layouts',

        // Ignore vite's ?raw imports
        '.*\?raw',
      ],
    }],

    // Thanks: https://stackoverflow.com/a/63961972/10796681
    'no-shadow': 'off',

    // Plugin: eslint-plugin-promise
    'promise/always-return': 'off',
    'promise/catch-or-return': 'off',

    // ESLint plugin vue
    'vue/block-tag-newline': 'off',
    'vue/component-api-style': 'off',
    'vue/component-name-in-template-casing': ['off', 'PascalCase', { registeredComponentsOnly: false }],
    'vue/custom-event-name-casing': ['off', 'camelCase', {
      ignores: [
        '/^(click):[a-z]+((\d)|([A-Z0-9][a-z0-9]+))*([A-Z])?/',
      ],
    }],
    'vue/define-macros-order': 'off',
    'vue/html-comment-content-newline': 'off',
    'vue/html-comment-content-spacing': 'off',
    'vue/html-comment-indent': 'off',
    'vue/match-component-file-name': 'off',
    'vue/no-child-content': 'off',
    'vue/require-default-prop': 'off',

    // NOTE this rule only supported in SFC,  Users of the unplugin-vue-define-options should disable that rule: https://github.com/vuejs/eslint-plugin-vue/issues/1886
    // 'vue/no-duplicate-attr-inheritance': 'off',
    'vue/no-empty-component-block': 'off',
    'vue/no-multiple-objects-in-class': 'off',
    'vue/no-reserved-component-names': 'off',
    'vue/no-template-target-blank': 'off',
    'vue/no-useless-mustaches': 'off',
    'vue/no-useless-v-bind': 'off',
    'vue/padding-line-between-blocks': 'off',
    'vue/prefer-separate-static-class': 'off',
    'vue/prefer-true-attribute-shorthand': 'off',
    'vue/v-on-function-call': 'off',
    'vue/no-restricted-class': ['off', '/^(p|m)(l|r)-/'],
    'vue/valid-v-slot': ['off', {
      allowModifiers: true,
    }],

    // -- Extension Rules
    'vue/no-irregular-whitespace': 'off',
    'vue/template-curly-spacing': 'off',

    // -- Sonarlint
    'sonarjs/no-duplicate-string': 'off',
    'sonarjs/no-nested-template-literals': 'off',

    // -- Unicorn
    // 'unicorn/filename-case': 'off',
    // 'unicorn/prevent-abbreviations': ['off', {
    //   replacements: {
    //     props: false,
    //   },
    // }],

    // https://github.com/gmullerb/eslint-plugin-regex
    'regex/invalid': [
      'off',
      [
        {
          regex: '@/assets/images',
          replacement: '@images',
          message: 'Use \'@images\' path alias for image imports',
        },
        {
          regex: '@/styles',
          replacement: '@styles',
          message: 'Use \'@styles\' path alias for importing styles from \'src/styles\'',
        },

        // {
        //   id: 'Disallow icon of icon library',
        //   regex: 'tabler-\\w',
        //   message: 'Only \'mdi\' icons are allowed',
        // },

        {
          regex: '@core/\\w',
          message: 'You can\'t use @core when you are in @layouts module',
          files: {
            inspect: '@layouts/.*',
          },
        },
        {
          regex: 'useLayouts\\(',
          message: '`useLayouts` composable is only allowed in @layouts & @core directory. Please use `useThemeConfig` composable instead.',
          files: {
            inspect: '^(?!.*(@core|@layouts)).*',
          },
        },
        {
          regex: 'import axios from \'axios\'',
          replacement: 'import axios from \'@axios\'',
          message: 'Use axios instances created in \'src/plugin/axios.js\' instead of unconfigured axios',
          files: {
            ignore: '^.*plugins/axios.js.*',
          },
        },
      ],

      // Ignore files
      '\.eslintrc\.js',
    ],
  },
  settings: {
    'import/resolver': {
      node: {
        extensions: ['.js', '.js', '.jsx', '.jsx', '.mjs', '.png', '.jpg'],
      }, alias: { 'extensions': ['.ts', '.js', '.tsx', '.jsx', '.mjs'], 'map': [["@", "./src"], ["@core", "./src/@core"], ["@layouts", "./src/@layouts"], ["@images", "./src/assets/images/"], ["@styles", "./src/styles/"], ["@configured-variables", "./src/styles/variables/_template.scss"], ["@axios", "./src/plugins/axios"], ["apexcharts", "node_modules/apexcharts-clevision"]] },
    },
  },
}
