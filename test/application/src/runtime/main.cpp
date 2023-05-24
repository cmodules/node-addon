#include "../../../include/application/runtime/main.h"

int main()
{
    application::Configuration Configuration;

#ifndef APPLICATION_CONFIGURATION_H_INCLUDED

    std::cout << "cli configuration header not found!" << std::endl;
    std::cout << "Nothing to report." << "\n" << std::endl;

#else

    #ifndef PLATFORM_ID

        #ifndef ARCHITECTURE_ID

            std::cout << "Platform and architecture defintions not found!" << std::endl;
            std::cout << "Nothing to report." << "\n" << std::endl;

        #endif

    #else

        std::cout << Configuration.InfoPlatform << "\n" << std::endl;
        std::cout << Configuration.InfoArch << "\n" << std::endl;

        #ifdef COMPILER_VERSION

            std::cout << Configuration.InfoVersion  << "\n" << std::endl;

            #ifndef COMPILER_VERSION_MAJOR
            #endif

        #endif // COMPILER_VERSION

        #ifdef COMPILER_VERSION_INTERNAL

            std::cout << Configuration.InfoVersionInternal  << "\n" << std::endl;

        #endif // COMPILER_VERSION_INTERNAL

        #ifdef SIMULATE_VERSION_MAJOR

            std::cout << Configuration.InfoSimulateVersion  << "\n" << std::endl;

        #endif // SIMULATE_VERSION_MAJOR

    #endif // PLATFORM_ID || ARCHITECTURE_ID

#endif // APPLICATION_CONFIGURATION_H_INCLUDED

    std::cout << "Press 'enter' to exit the program." << "\n" << std::endl;
    std::cin.get();
    return 0;
};
