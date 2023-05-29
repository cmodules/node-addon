## node-addon

<section id="vcpkg_reference">
  <table>
    <colgroup>
      <col />
      <col />
      <col />
      <col />
    </colgroup>
    <thead>
      <tr>
        <th><p>Name</p></th>
        <th><p>Type</p></th>
        <th><p>Default</p></th>
        <th><p>Info</p></th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <th><p>VCPKG_ROOT</p></th>
        <td><p>PATH</p></td>
        <td>
          <p><code>${CMAKE_CURRENT_LIST_DIR}</code></p>
          <p>Git repo root folder - <i><u>must</u></i> contain an empty file named <code>.vcpkg-root</code>!</p>
        </td>
        <td>
          <p>This environment variable can be set to a directory to use as the root of the vcpkg instance. This will only be used if the vcpkg executable is not located within a valid root and the command line switch <code>--vcpkg-root</code> is unused.</p>
        </td>
      </tr>
      <tr>
        <th><p>VCPKG_BINARY_SOURCES</p></th>
        <td><p>STRING</p></td>
        <td><p><code>clear;default,readwrite</code></p></td>
        <td><p>This environment variable adds or removes binary sources. See <a href="https://learn.microsoft.com/en-us/vcpkg/users/binarycaching">Binary Caching</a> for more details.</p></td>
      </tr>
      <tr>
        <th><p>VCPKG_DEFAULT_BINARY_CACHE</p></th>
        <td><p>PATH</p></td>
        <td><p><code>${VCPKG_ROOT}/archives</code></p></td>
        <td><p>This environment variable redirects the default location to store binary packages.</p></td>
      </tr>
      <tr>
        <th><p>VCPKG_DOWNLOADS</p></th>
        <td><p>PATH</p></td>
        <td><p><code>${VCPKG_ROOT}/downloads</code></p></td>
        <td><p>This environment variable can be set to an existing directory to use for storing downloads instead of the internal <code>downloads/</code> directory. It should always be an absolute path.</p></td>
      </tr>
      <tr>
        <th><p>VCPKG_INSTALLED_DIR</p></th>
        <td><p>PATH</p></td>
        <td><p><code>${VCPKG_ROOT}/installed</code></p></td>
        <td><p>The directory which contains the installed libraries for each triplet.</p></td>
      </tr>
      <tr>
        <th><p>VCPKG_OVERLAY_PORTS</p></th>
        <td><p>PATH</p></td>
        <td><p><code>${VCPKG_ROOT}/ports</code></p></td>
        <td><p>Overlay ports to use for vcpkg install in manifest mode.</p></td>
      </tr>
      <tr>
        <th><p>VCPKG_OVERLAY_TRIPLETS</p></th>
        <td><p>PATH</p></td>
        <td><p><code>${VCPKG_ROOT}/triplets</code></p></td>
        <td><p>Overlay triplets to use for vcpkg install in manifest mode.</p></td>
      </tr>
      <tr>
        <th><p>VCPKG_VERBOSE</p></th>
        <td><p>BOOL</p></td>
        <td><p><code>ON</code></p></td>
        <td><p>Enables messages from the VCPKG toolchain for debugging purposes.</p></td>
      </tr>
      <tr>
        <th><p>VCPKG_USE_HOST_TOOLS</p></th>
        <td><p>BOOL</p></td>
        <td><p><code>OFF</code></p></td>
        <td><p>Setup <code>CMAKE_PROGRAM_PATH</code> to use host tools.</p></td>
      </tr>
      <tr>
        <th><p>VCPKG_SETUP_CMAKE_PROGRAM_PATH</p></th>
        <td><p>BOOL</p></td>
        <td><p><code>ON</code></p></td>
        <td><p>Enable the setup of <code>CMAKE_PROGRAM_PATH</code> to vcpkg paths</p></td>
      </tr>
      <tr>
        <th><p>VCPKG_PREFER_SYSTEM_LIBS</p></th>
        <td><p>BOOL</p></td>
        <td><p><code>OFF</code></p></td>
        <td>
          <p>Appends the vcpkg paths to <code>CMAKE_PREFIX_PATH</code>, <code>CMAKE_LIBRARY_PATH</code> and <code>CMAKE_FIND_ROOT_PATH</code> so that vcpkg libraries/packages are found after toolchain/system libraries/packages.</p>
          <p><i>Deprecated!! Use empty overlay ports instead...</i></p>
        </td>
      </tr>
      <tr>
        <th><p>VCPKG_FORCE_SYSTEM_BINARIES</p></th>
        <td><p>BOOL</p></td>
        <td><p><code></code></p></td>
        <td><p>This environment variable, if set, suppresses the downloading of CMake and Ninja and forces the use of the system binaries.</p></td>
      </tr>
      <tr>
        <th><p>VCPKG_FORCE_DOWNLOADED_BINARIES</p></th>
        <td><p>BOOL</p></td>
        <td><p><code></code></p></td>
        <td><p>This environment variable, if set, ignores the use of the system binaries and will always download and use the version defined by vcpkg.</p></td>
      </tr>
      <tr>
        <th><p>VCPKG_LIBRARY_LINKAGE</p></th>
        <td><p>STRING</p></td>
        <td><p><code>dynamic</code></p></td>
        <td><p>Specifies the preferred library linkage. Valid options are <code>dynamic</code> and <code>static</code>. Libraries can ignore this setting if they do not support the preferred linkage type.</p></td>
      </tr>
      <tr>
        <th><p>VCPKG_CRT_LINKAGE</p></th>
        <td><p>STRING</p></td>
        <td><p><code>${VCPKG_LIBRARY_LINKAGE}</code></p></td>
        <td><p>Specifies the desired CRT linkage (for MSVC). Valid options are <code>dynamic</code> and <code>static</code>.</p></td>
      </tr>
      <tr>
        <th><p>VCPKG_BUILD_TYPE</p></th>
        <td><p>STRING</p></td>
        <td><p><code>${CMAKE_BUILD_TYPE}</code></p></td>
        <td><p>You can set this value to <code>Release</code> to only build release versions of the ports. By default this value is empty and release and debug versions of a port are built.</p></td>
      </tr>
      <tr>
        <th><p>VCPKG_CMAKE_SYSTEM_NAME</p></th>
        <td><p>STRING</p></td>
        <td><p><code>${CMAKE_HOST_SYSTEM_NAME}</code></p></td>
        <td>
          <p>Specifies the target platform. Valid options include any CMake system name, such as:</p>
          <p><code>Empty</code> - Windows Desktop for legacy reasons</p>
          <p><code>WindowsStore</code> - Universal Windows Platform</p>
          <p><code>MinGW</code> - Minimalist GNU for Windows</p>
          <p><code>Darwin</code> - Mac OSX</p>
          <p><code>iOS</code> - iOS</p>
          <p><code>Linux</code> - Linux</p>
          <p><code>Emscripten</code> - WebAssembly</p>
        </td>
      </tr>
      <tr>
        <th><p>VCPKG_CMAKE_SYSTEM_VERSION</p></th>
        <td><p>STRING</p></td>
        <td><p><code>${CMAKE_HOST_SYSTEM_VERSION}</code></p></td>
        <td>
          <p>Specifies the target platform system version. This field is optional and, if present, will be passed in as <code>CMAKE_SYSTEM_VERSION</code>.</p>
        </td>
      </tr>
      <tr>
        <th><p></p></th>
        <td><p></p></td>
        <td><p><code></code></p></td>
        <td><p></p></td>
      </tr>
      <tr>
        <th><p></p></th>
        <td><p></p></td>
        <td><p><code></code></p></td>
        <td><p></p></td>
      </tr>
      <tr id="vcpkg_host_triplet">
        <th><p>VCPKG_HOST_TRIPLET</p></th>
        <td><p>STRING</p></td>
        <td><p></p></td>
        <td>
          <p>This variable controls which <a href="https://learn.microsoft.com/en-us/vcpkg/users/triplets">triplet</a> host dependencies will be installed for.</p>
          <p>If unset, vcpkg will automatically detect an appropriate native triplet (<code>x64-windows</code>, <code>x64-osx</code>, <code>x64-linux</code>).</p>
          <p>See also <a href="https://learn.microsoft.com/en-us/vcpkg/users/host-dependencies">Host dependencies</a>.</p>
        </td>
      </tr>
      <tr id="vcpkg_target_triplet">
        <th><p>VCPKG_TARGET_TRIPLET</p></th>
        <td><p>STRING</p></td>
        <td><p><code></code></p></td>
        <td>
          <p>This setting controls the <a href="https://learn.microsoft.com/en-us/vcpkg/users/triplets">triplet</a> vcpkg will install and consume libraries from.</p>
          <p>If unset, vcpkg will automatically detect an appropriate default triplet given the current compiler settings. If you change this CMake variable, you must delete your cache and reconfigure.</p>
        </td>
      </tr>
      <tr id="vcpkg_target_architecture">
        <th><p>VCPKG_TARGET_ARCHITECTURE</p></th>
        <td><p>STRING</p></td>
        <td><p><code></code></p></td>
        <td>
          <p>Specifies the target machine architecture.</p>
          <p>Valid options are <code>x86</code>, <code>x64</code>, <code>arm</code>, <code>arm64</code> and <code>wasm32</code>.</p>
        </td>
      </tr>
      <tr>
        <th><p></p></th>
        <td><p></p></td>
        <td><p><code></code></p></td>
        <td><p></p></td>
      </tr>
      <tr>
        <th><p></p></th>
        <td><p></p></td>
        <td><p><code></code></p></td>
        <td><p></p></td>
      </tr>
      <tr id="port">
        <th><p>PORT</p></th>
        <td><p>STRING</p></td>
        <td><p><code></code></p></td>
        <td><p>The name of the port that is currently being built.</p></td>
      </tr>
      <tr id="version">
        <th><p>VERSION</p></th>
        <td><p>STRING</p></td>
        <td><p><code></code></p></td>
        <td><p>The version of the port that is currently being built.</p></td>
      </tr>
      <tr id="host_triplet">
        <th><p>HOST_TRIPLET</p></th>
        <td><p>STRING</p></td>
        <td><p><code></code></p></td>
        <td><p>The name of the <a href="https://learn.microsoft.com/en-us/vcpkg/users/triplets">triplet</a> that matches the building system.</p></td>
      </tr>
      <tr id="target_triplet">
        <th><p>TARGET_TRIPLET</p></th>
        <td><p>STRING</p></td>
        <td><p><code></code></p></td>
        <td><p>The name of the <a href="https://learn.microsoft.com/en-us/vcpkg/users/triplets">triplet</a> being built for.</p></td>
      </tr>
      <tr id="current_host_installed_dir">
        <th><p>CURRENT_HOST_INSTALLED_DIR</p></th>
        <td><p>STRING</p></td>
        <td><p><code></code></p></td>
        <td><p>The absolute path to the installed files for the <a href="#host_triplet">host triplet.</a></p></td>
      </tr>
      <tr id="current_installed_dir">
        <th><p>CURRENT_INSTALLED_DIR</p></th>
        <td><p>STRING</p></td>
        <td><p><code></code></p></td>
        <td><p>The absolute path to the installed files for the <a href="#target_triplet">target triplet.</a></p></td>
      </tr>
      <tr id="editor">
        <th><p>EDITOR</p></th>
        <td><p>ENV</p></td>
        <td><p><code></code></p></td>
        <td><p>This environment variable can be set to the full path of an executable to be used for <code>vcpkg edit</code>. Please see <code>vcpkg help edit</code> for command-specific help.</p></td>
      </tr>
      <tr id="ar">
        <th><p>AR</p></th>
        <td><p>ENV</p></td>
        <td><p><code>$ENV{PATH}/ar</code></p></td>
        <td><p>Default archive compiler filepath and flags.</p></td>
      </tr>
      <tr id="cc">
        <th><p>CC</p></th>
        <td><p>ENV</p></td>
        <td><p><code>$ENV{PATH}/c</code></p></td>
        <td><p>Default C compiler filepath and flags.</p></td>
      </tr>
      <tr id="cxx">
        <th><p>CXX</p></th>
        <td><p>ENV</p></td>
        <td><p><code>$ENV{PATH}/c++</code></p></td>
        <td><p>Default C++ compiler filepath and flags.</p></td>
      </tr>
      <tr id="ld">
        <th><p>LD</p></th>
        <td><p>ENV</p></td>
        <td><p><code>$ENV{PATH}/ld</code></p></td>
        <td><p>Default object linker filepath and flags.</p></td>
      </tr>
      <tr id="rc">
        <th><p>RC</p></th>
        <td><p>ENV</p></td>
        <td><p><code>$ENV{PATH}/rc</code></p></td>
        <td><p>Default resource compiler filepath and flags.</p></td>
      </tr>
      <tr id=cflags>
        <th><p>CFLAGS</p></th>
        <td><p>ENV</p></td>
        <td><p><code></code></p></td>
        <td><p></p></td>
      </tr>
      <tr id=cxxflags>
        <th><p>CXXFLAGS</p></th>
        <td><p>ENV</p></td>
        <td><p><code></code></p></td>
        <td><p></p></td>
      </tr>
      <tr id="ldflags">
        <th><p>LDFLAGS</p></th>
        <td><p>ENV</p></td>
        <td><p><code></code></p></td>
        <td><p></p></td>
      </tr>
      <tr>
        <th><p>PKG_CONFIG_PATH</p></th>
        <td><p></p></td>
        <td><p><code></code></p></td>
        <td><p></p></td>
      </tr>
      <tr id="vslang">
        <th><p>VSLANG</p></th>
        <td><p></p></td>
        <td><p><code></code></p></td>
        <td><p>This environment variable sets the language vcpkg uses to display messages. It should be set to one of the 14 supported LCIDs (locale identifier, 4-byte value corresponding to a language).</p>
        <p>For example: 1033 corresponds to the English (US) language. For a full list of supported LCIDs see <a href="https://github.com/microsoft/vcpkg-tool/blob/main/docs/localization.md">Localization</a>.</p></td>
      </tr>
      <tr>
        <th><p></p></th>
        <td><p></p></td>
        <td><p><code></code></p></td>
        <td><p></p></td>
      </tr>
      <tr>
        <th><p></p></th>
        <td><p></p></td>
        <td><p><code></code></p></td>
        <td><p></p></td>
      </tr>
      <tr>
        <th><p>BUILD_BENCHMARKING</p></th>
        <td><p></p></td>
        <td><p><code></code></p></td>
        <td><p></p></td>
      </tr>
      <tr>
        <th><p>BUILD_FUZZING_TESTS</p></th>
        <td><p></p></td>
        <td><p><code></code></p></td>
        <td><p></p></td>
      </tr>
      <tr>
        <th><p>BUILD_SHARED_LIBS</p></th>
        <td><p></p></td>
        <td><p><code></code></p></td>
        <td><p></p></td>
      </tr>
      <tr>
        <th><p>BUILD_TESTS</p></th>
        <td><p></p></td>
        <td><p><code></code></p></td>
        <td><p></p></td>
      </tr>
      <tr>
        <th><p>PEDANTIC</p></th>
        <td><p></p></td>
        <td><p><code></code></p></td>
        <td><p>Enable extra warnings and expensive tests.</p></td>
      </tr>
      <tr>
        <th><p>VERBOSE</p></th>
        <td><p></p></td>
        <td><p><code></code></p></td>
        <td><p></p></td>
      </tr>
      <tr>
        <th><p>WERROR</p></th>
        <td><p></p></td>
        <td><p><code></code></p></td>
        <td><p>Halt the compilation with an error on compiler warnings.</p></td>
      </tr>
      <tr>
        <th><p>USE_FOLDERS</p></th>
        <td><p></p></td>
        <td><p><code></code></p></td>
        <td><p></p></td>
      </tr>
      <tr>
        <th><p>USE_X64</p></th>
        <td><p></p></td>
        <td><p><code></code></p></td>
        <td><p></p></td>
      </tr>
      <tr>
        <th><p></p></th>
        <td><p></p></td>
        <td><p><code></code></p></td>
        <td><p></p></td>
      </tr>
      <tr>
        <th><p></p></th>
        <td><p></p></td>
        <td><p><code></code></p></td>
        <td><p></p></td>
      </tr>
      <tr>
        <th><p>CMAKE_TOOLCHAIN_FILE</p></th>
        <td><p>FILEPATH</p></td>
        <td>
          <p>When vcpkg executable <i>is not</i> found in 'VCPKG_ROOT' -<br /><code>scripts/toolchains/${CMAKE_HOST_SYSTEM_NAME}.cmake</code></p>
          <p>When vcpkg executable <i>is</i> found in 'VCPKG_ROOT' -<br /><code>scripts/buildsystems/vcpkg.cmake</code></p>
        </td>
        <td><p>The CMake toolchain file.</p></td>
      </tr>
      <tr>
        <th><p>VCPKG_CHAINLOAD_TOOLCHAIN_FILE</p></th>
        <td><p>FILEPATH</p></td>
        <td><p><code>scripts/toolchains/${CMAKE_HOST_SYSTEM_NAME}.cmake</code></p></td>
        <td><p>Specifies an alternate CMake Toolchain file to use. This (if set) will override all other compiler detection logic. By default, a toolchain file is selected from <code>scripts/toolchains/</code> appropriate to the platform.</p></td>
      </tr>
      <tr>
        <th><p>VCPKG_INSTALL_OPTIONS</p></th>
        <td><p></p></td>
        <td>
          <p>Clean buildtrees, packages and downloads after building each package:<br />
            <code>--clean-after-build</code>
          </p>
          <p>Clean buildtrees after building each package:<br />
            <code>--clean-buildtrees-after-build</code>
          </p>
          <p>Clean downloads after building each package:<br />
            <code>--clean-downloads-after-build</code>
          </p>
            <p>Clean packages after building each package:<br />
            <code>--clean-packages-after-build</code></p>
        </td>
        <td><p>This variable can be set to a list of additional command line parameters to pass to the vcpkg tool during automatic installation.</p></td>
      </tr>
      <tr>
        <th><p>VCPKG_FEATURE_FLAGS</p></th>
        <td><p></p></td>
        <td>
          <p>Specifies the vcpkg root folder:<br />
            <code>--vcpkg-root=${VCPKG_ROOT}</code>
          </p>
          <p></p>
          <p></p>
          <p></p>
          <p></p>
          <p></p>
          <p></p>
        </td>
        <td><p>This variable can be set to a list of additional command line parameters to pass to the vcpkg tool during automatic installation to opt in to experimental behaviour.</p></td>
      </tr>
      <tr>
        <th><p></p></th>
        <td><p></p></td>
        <td><p><code></code></p></td>
        <td><p></p></td>
      </tr>
      <tr>
        <th><p></p></th>
        <td><p></p></td>
        <td><p><code></code></p></td>
        <td><p></p></td>
      </tr>
      <tr>
        <th><p></p></th>
        <td><p></p></td>
        <td><p><code></code></p></td>
        <td><p></p></td>
      </tr>
      <tr>
        <th><p></p></th>
        <td><p></p></td>
        <td><p><code></code></p></td>
        <td><p></p></td>
      </tr>
      <tr>
        <th><p></p></th>
        <td><p></p></td>
        <td><p><code></code></p></td>
        <td><p></p></td>
      </tr>
      <tr>
        <th><p></p></th>
        <td><p></p></td>
        <td><p><code></code></p></td>
        <td><p></p></td>
      </tr>
    </tbody>
    <!-- <tfoot>
      <tr>
        <td><p>See more at <a href="https://learn.microsoft.com/en-us/vcpkg/">https://learn.microsoft.com/en-us/vcpkg/</a></p></td>
      </tr>
    </tfoot> -->
  </table>
</section>
