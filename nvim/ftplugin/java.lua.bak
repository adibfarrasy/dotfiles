local extendedClientCapabilities = require('jdtls').extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

local root_markers = { '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle', 'settings.gradle' }
local root_dir = require('jdtls.setup').find_root(root_markers)
if root_dir == '' then
  return
end
local workspace_folder = os.getenv 'HOME' .. '/.local/share/eclipse/' .. vim.fn.fnamemodify(root_dir, ':p:h:t')

local config = {
  cmd = {
    os.getenv 'HOME' .. '/.sdkman/candidates/java/17.0.13-librca/bin/java',
    '-javaagent:' .. os.getenv 'HOME' .. '/.local/share/eclipse/lombok.jar',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '--add-modules=ALL-SYSTEM',
    '--add-opens',
    'java.base/java.util=ALL-UNNAMED',
    '--add-opens',
    'java.base/java.lang=ALL-UNNAMED',
    '-Xmx1g',
    '-jar',
    os.getenv 'HOME' .. '/.local/share/jdtls/plugins/org.eclipse.equinox.launcher_1.6.900.v20240613-2009.jar',
    '-configuration',
    os.getenv 'HOME' .. '/.local/share/jdtls/config_mac_arm',
    '-data',
    workspace_folder,
  },
  root_dir = root_dir,
  on_attach = function(client)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end,
  settings = {
    java = {
      format = {
        enabled = false,
      },
      signatureHelp = { enabled = true },
      contentProvider = { preferred = 'fernflower' },
      completion = {
        favoriteStaticMembers = {
          'org.hamcrest.MatcherAssert.assertThat',
          'org.hamcrest.Matchers.*',
          'org.hamcrest.CoreMatchers.*',
          'org.junit.jupiter.api.Assertions.*',
          'java.util.Objects.requireNonNull',
          'java.util.Objects.requireNonNullElse',
          'org.mockito.Mockito.*',
        },
        importOrder = {
          'java',
          'javax',
          'com',
          'org',
          'ai',
        },
      },
      configuration = {
        -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
        -- And search for `interface RuntimeOption`
        -- The `name` is NOT arbitrary, but must match one of the elements from `enum ExecutionEnvironment` in the link above
        runtimes = {
          {
            name = 'JavaSE-21',
            path = os.getenv 'HOME' .. '/.sdkman/candidates/java/21.0.5-jbr',
          },
          {
            name = 'JavaSE-17',
            path = os.getenv 'HOME' .. '/.sdkman/candidates/java/17.0.13-librca',
          },
          {
            name = 'JavaSE-1.8',
            path = os.getenv 'HOME' .. '/.sdkman/candidates/java/8.0.432-librca',
          },
        },
      },
    },
  },
  init_options = {
    bundles = {},
    extendedClientCapabilities = extendedClientCapabilities,
  },
}

require('jdtls').start_or_attach(config)
