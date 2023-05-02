# Every update requires an update of these hashes and the version within the control file of each of the 32 ports.
# So it is probably better to have a central location for these hashes and let the ports update via a script
set(QT_MAJOR_MINOR_VER 5.15)
set(QT_PATCH_VER 9)
set(QT_UPDATE_VERSION 0) # Switch to update qt and not build qt. Creates a file cmake/qt_new_hashes.cmake in qt5-base with the new hashes.

set(QT_PORT_LIST base 3d activeqt charts connectivity datavis3d declarative gamepad graphicaleffects imageformats location macextras mqtt multimedia networkauth
                 purchasing quickcontrols quickcontrols2 remoteobjects script scxml sensors serialport speech svg tools virtualkeyboard webchannel websockets
                 webview winextras xmlpatterns doc x11extras androidextras translations serialbus webengine webglplugin wayland)

set(QT_HASH_qt5-3d               4c88af3855c22ab6dd17fca835eabc0facec446e254b329f76b7c61002bc4b47e7029aba6336e47b89c30c2dd50090e925042af8199f1fbb1f65558784cdc9ce)
set(QT_HASH_qt5-activeqt         b4d728bc1a28a15c3fc14d40a6dd2801c898d17a9c18c773b794abb629432efd6888cb56517a8fac0764eeacc436040d4406e05f322a43b84fafa036c2ba5d2c)
set(QT_HASH_qt5-androidextras    9ca134cafaa5fc84a15781bf85fa69aaa47ea4b21099c35da842743c9781417fc7cda06f0dd3f9f8d25ae710bcbe40917a4723428809c03054801dd932be7d31)
set(QT_HASH_qt5-base             2da78ea043c03fa4ff7c6a39c41a5d1b30af06248764e6f5eef3fe4aeb3f3d20e302fa7c5827112c89b6bc7c5c0c292454d127f9d7bb0d2031175f0f2c937ed3)
set(QT_HASH_qt5-charts           b8b4390121780c4a562eaa563920a38637930a473e5b8e10fbb485c80c9a049825c73ff1c1786a869bc9603bb03d74b6d666064e6f98006edc5dba366c25f316)
set(QT_HASH_qt5-connectivity     e47621e95aa4ca8438787c4333fdaec6aef828372eb73029836256c03eb6c0faed41f89ab928d28cf1113ca53c8a94d69d07bd1dc06fa90272f0286244b49fde)
set(QT_HASH_qt5-datavis3d        154d7253c69c32a76b12200b25d6edaa0c671d5293abdcf09972c1525f366279a02fec7f9b6e73fb98d0d9919b3635cb3e9c32b54c43f056ecf06ba27b44459d)
set(QT_HASH_qt5-declarative      ada3e32f42270899d92c46f0c0b8cd78028cf2e658ac60b3745c804ec494fb1fc6f31a670668074433b3e702f81524415ef132a757ca80151eb13d0a19352af7)
set(QT_HASH_qt5-doc              05bcfdb39bd55d5b9741413c3cef601743f7b2cbca716b87b2655cc5e60c273ad58831572c7215b2f41258d2c92ab07348d5adfb1b10b5720b917891bee7bcc1)
set(QT_HASH_qt5-gamepad          f6ee08fc3872b078fb64e63a074b0230674dd670cf087b864c16ec3ecdbf374374257eb18aeae1e8e2c16850fddb3f4fef99efc4ddd597ab66b2a9fc8158cb93)
set(QT_HASH_qt5-graphicaleffects ea9a9cf069ab5df82ac29842f093ef4b795ccd6a4bb7ca3c0ff538bfe2ed6473e24a7b8e7b9c28cf8ad7550b2314515567e5f53b7d913ae96593f0b2cdbad2b8)
set(QT_HASH_qt5-imageformats     9713c781200c8abb1a6f1a2dfb851fc38dcb2428ca3dbf29aa392d938671978804a67587bbbc5a5f75703cc754da4673dd9a4b567c9c03ed61d329889156c437)
set(QT_HASH_qt5-location         37517c304240921c600e2aad19baff0efbb5e01c5cc78e5370fb4b084f2a6ba4da94d39ddcbcd33a5f0af37f017d39bb775a40cda195e16697aa70c9d17b6bcf)
set(QT_HASH_qt5-macextras        14a42b108d2afa1d95fb42a2b87be3f25da0b2a3ac8b004eb31e2c634943b5ffb6db0de37d6df734080977ef80f3601e283dd5727ef7cc61f247714ac9095299)
set(QT_HASH_qt5-mqtt             9d77abfc15754f09d74c08f97e1b3eb43cce7bbb6b5da7e3c385741e62b93a8761b084d314edf332a18901b7ce312bd896428951191caf62208ba533adbca0af)
set(QT_HASH_qt5-multimedia       f167e7910c19a55858a4b8e53c293908ef50e8a299b5dc6a346c2c877b4f65aa6da17807ec3f297530515b4558c74e97d54d6013c27400c1c4964c7c4dbef6cd)
set(QT_HASH_qt5-networkauth      9857f0e368e0c2bb4dfa772653a17cd34754e95ae64414f70ca78c1ec3a38ac850c462db9aa5fee4ee9143cd2fe0a5485fc0948cc3459a4842e221ab08356356)
set(QT_HASH_qt5-purchasing       771a9e9100cd6b8bd872e05def2eefe942a5bcb3832e61e3251c38100fcbdaaa6aac543c5c70b82379bd4d888a71ae0feac22765245ca169ee34a41af4b05b84)
set(QT_HASH_qt5-quickcontrols    62c732414aa3660ae6c702a533e3ed090a293a6ecfc0bcc75b54d3dc9e0ecb657002e3f840107a07a1d749938148c0e63cd9f1021831f6c44ab133f9780b9c88)
set(QT_HASH_qt5-quickcontrols2   f77a59cb6704438bc7b81f816454dad56bebdf4ce7f015c21a05b09f0c508525750a0cf232da8d7428464aa68de9a2bcbd000906fa781aff1e60e8ee5d70802e)
set(QT_HASH_qt5-remoteobjects    1ab0bf1ec6d251f0b4b406380c2870c21c4fbd47868b212efc46546d7059831aebba32caf85de6a51c96edc6bb40c3fdc2b3b7b733f2501e1ccb4c04ab0197fc)
set(QT_HASH_qt5-script           83a69b3f428fe8322c4ff5bf96736f8e76c0825b06742ef000c22bd0c71598c648b03481f40d86d5233d74096b34c5158a576731a06f12e01b680fd42e31c602)
set(QT_HASH_qt5-scxml            f6c6bdcb651055fd3a9b18fae1860f0d72afe83a08b387cb1393d0b1966eaaf1d8ce4530e6faa3a4e4a18d97a8e36937303b99e29d7dba17b6bcda61a5eb9872)
set(QT_HASH_qt5-sensors          beba10a61e6d9f31dc9f24826b4a01b48fa656d424a97164c59d7be9a9e063f1b0820f95c157651ca0cac60d6f9aa188b90a122be565bcb488e7f0e42887140d)
set(QT_HASH_qt5-serialbus        f044929a2a4e8401fbd84a3e160f070c7af75bf6dd44e7353160ed30bb453853c0d8b421e03b73309d249dc149ef19192721f8152881ddc37f0be2e410884cfe)
set(QT_HASH_qt5-serialport       e22d20a0b20d0dc8c6bce3dcf1137b2cce28e370df9d0250f2a777dd73153d0156b0c6cfe88bc4257cdc209fbf640c8a06fada147d40ee638deb716148812da3)
set(QT_HASH_qt5-speech           c614798cca4485d9880fe8bc19df563b29673f8fc111ce8129e8e1a8f1c8f769f76c9a7754e8cde43e7223ef7fed899bff9e91bcebe113281eb44f39aa7bfe4a)
set(QT_HASH_qt5-svg              e091c059492662fad713d1f99bfa5e21a8f8e77e24b067d176a6e732b420a22e3777fa99a880c6f992a19b2e5b16c01f131da875d9e08e6a515108b468192fe5)
set(QT_HASH_qt5-tools            ddd2a47fe51e9a6e650123eda097ea037971f01f9210cea9c1d13c7a8e581e436a41c954f83def0a8ee35c30f388627809e3eb4bbf27b5e3ece6a55f7d777067)
set(QT_HASH_qt5-translations     58168e68529bd84f363d5c46182be45f5ef143e44c6878326a2d05ada7b70adc812c8d024ca8650ac52a1e2d6dc22788b57d4f5527de7d8619d34ebbba71165b)
set(QT_HASH_qt5-virtualkeyboard  d9169a5d5b09d8854ce6b402a7333e8a561272aeb05ffb3a8055ea6e9a18b2d79ac404c85d57e4b78db0c6ef61352e2d7fddd8c510ff1cdaaa6665a9a20fd96e)
set(QT_HASH_qt5-wayland          d108d63ceeb3b1a8905ad7f53a7271fca6a3506679d352b7290cdf8c00e1c180b6c561ee013a674002b89e23f58cfb7b909dfc5a8fdec6cece7e0a782be77978)
set(QT_HASH_qt5-webchannel       6b9c38c3d22708a14402282d4134475336cce2874887ece00316866cbc59714e395924cc9a449653ab050431c4ece5e0eb454ce2f4c13252bae7abd8fae93bb4)
set(QT_HASH_qt5-webengine        7142ac2e59e4aa2bedbe35e6242c1359fc9c51bd7db9f31d89f01dc2843f38bf7f80869e603a57190791a97aef9ba1064eb0f90cf09e5293f61f250c455cb07a)
set(QT_HASH_qt5-webglplugin      647832ee6351c0fec45eaf5b737aaac74f7c76bc72126faa49f67523b1e0ef965209842de5b4e3256f8df30999bb7d67160e5181d9f3df1d6d7dbb3ac8502dc7)
set(QT_HASH_qt5-websockets       3e9b63656c16893a67d62f452c70decfca160ab192b3da2f25f3f72e513a58e3ec678ad05e618d1e48c05708f55d38ca02d4b1f3efdbea5e544f5cec16f6a5ac)
set(QT_HASH_qt5-webview          15d9b7f446d5b579e596b8e7766fc24380d5f92547186a4de08708f40c1847e690c679312130518470a40a86baea686a38a2a0c237affd13bdc5302e3c313c6f)
set(QT_HASH_qt5-winextras        249fa333d2e0eb38417af40740bd7721aec9eb706e0c98ab43589ca892679689201e4ba9e89586b5c388126a57cb84965932cd113a6c4e638fe10a4f5ff9ddbb)
set(QT_HASH_qt5-x11extras        695e23626f1d3b51fa4d20d0845be749581b0cdf3633598f457cfac4d790e3d52881f5e51e35a95d42f481a73ddc7d50a22d562c65a0bca2a9e586615ab6ec7b)
set(QT_HASH_qt5-xmlpatterns      60cdee139c04dbd2c381f65fcd579af0b2b6f40234870a782c8b7342c8d0caf92fef94acb959260e4ef615b2c60b5527cd44b8efa85f04ceb4a3659a47a0ee89)

if(QT_UPDATE_VERSION)
    message(STATUS "Running Qt in automatic version port update mode!")
    set(_VCPKG_INTERNAL_NO_HASH_CHECK 1)
    if("${PORT}" MATCHES "qt5-base")
        function(update_qt_version_in_manifest _port_name)
            set(_current_control "${VCPKG_ROOT_DIR}/ports/${_port_name}/vcpkg.json")
            file(READ ${_current_control} _control_contents)
            #message(STATUS "Before: \n${_control_contents}")
            string(REGEX REPLACE "\"version.*\": \"[0-9]+\.[0-9]+\.[0-9]+\",\n" "\"version\": \"${QT_MAJOR_MINOR_VER}.${QT_PATCH_VER}\",\n" _control_contents "${_control_contents}")
            string(REGEX REPLACE "\n  \"port-version\": [0-9]+," "" _control_contents "${_control_contents}")
            #message(STATUS "After: \n${_control_contents}")
            file(WRITE ${_current_control} "${_control_contents}")
            configure_file("${_current_control}" "${_current_control}" @ONLY NEWLINE_STYLE LF)
        endfunction()

        update_qt_version_in_manifest("qt5")
        foreach(_current_qt_port_basename ${QT_PORT_LIST})
            update_qt_version_in_manifest("qt5-${_current_qt_port_basename}")
        endforeach()
    endif()
endif()
