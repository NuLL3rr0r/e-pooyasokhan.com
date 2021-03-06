#if !defined ( _WIN32 )
#include <iostream>
#endif  // !defined ( _WIN32 )

#include <memory>
#include <boost/algorithm/string.hpp>
#include <boost/filesystem.hpp>
#include <QApplication>
#include <MyLib/ipcprotocol.hpp>
#include <MyLib/log.hpp>
#include <MyLib/make_unique.hpp>
#include <MyLib/mylib.hpp>
#include <MyLib/system.hpp>
#include "application.hpp"
#include "versioninfo.hpp"

int main(int argc, char **argv)
{
    boost::filesystem::path path(boost::filesystem::initial_path<boost::filesystem::path>());
    if (argc > 0 && argv[0] != NULL)
        path = boost::filesystem::system_complete(boost::filesystem::path(argv[0]));
    std::string appId(path.filename().string());
    std::string appPath(boost::algorithm::replace_last_copy(path.string(), appId, ""));
    boost::filesystem::current_path(appPath);
    MyLib::MyLibInitialize(argc, argv);

    MyLib::Log::Initialize(std::cout,
                           (boost::filesystem::path(appPath) / boost::filesystem::path("logs")).string(),
                           "EPSDesktop");

    LOG_INFO("Version Information", "", "IPC_PROTOCOL_NAME          " + MyLib::IPCProtocol::Name(), "IPC_PROTOCOL_VERSION       " + MyLib::IPCProtocol::Version(), "BUILD_COMPILER             " VERSION_INFO_BUILD_COMPILER, "BUILD_DATE                 " VERSION_INFO_BUILD_DATE, "BUILD_HOST                 " VERSION_INFO_BUILD_HOST, "BUILD_PROCESSOR            " VERSION_INFO_BUILD_PROCESSOR, "BUILD_SYSTEM               " VERSION_INFO_BUILD_SYSTEM, "PRODUCT_COMPANY_NAME       " VERSION_INFO_PRODUCT_COMPANY_NAME, "PRODUCT_COPYRIGHT          " VERSION_INFO_PRODUCT_COPYRIGHT, "PRODUCT_DEVELOPER          " VERSION_INFO_PRODUCT_DEVELOPER, "PRODUCT_INTERNAL_NAME      " VERSION_INFO_PRODUCT_INTERNAL_NAME, "PRODUCT_NAME               " VERSION_INFO_PRODUCT_NAME, "PRODUCT_VERSION            " VERSION_INFO_PRODUCT_VERSION, "PRODUCT_DESCRIPTION        " VERSION_INFO_PRODUCT_DESCRIPTION);

#if !defined ( DEBUG_BUILD )
#if defined ( __unix__ )
    int lock;
#elif defined ( _WIN32 )
    HANDLE lock;
#endif  // defined ( __unix__ )

    if(!MyLib::System::GetLock(appId, lock)) {
        LOG_FATAL("Process is already running!");
#if defined ( _WIN32 )
        MessageBox(NULL, L"نسخه دیگری از برنامه در حال اجراست!", L"خطا",
                   MB_OK | MB_ICONERROR | MB_RTLREADING | MB_TOPMOST);
#endif  // defined ( _WIN32 )
        return EXIT_FAILURE;
    }
    LOG_INFO("Got the process lock!");
#else   // !defined ( DEBUG_BUILD )
    LOG_WARNING("Ignoring process memory-residency check!");
#endif  // !defined ( DEBUG_BUILD )

    std::unique_ptr<QApplication> app =
            std::make_unique<QApplication>(argc, argv);

    std::unique_ptr<EPSDesktop::Application> application =
            std::make_unique<EPSDesktop::Application>();
    application->Start();

    return app->exec();
}

