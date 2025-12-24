#include <iostream>

#include "RED4ext/RED4ext.hpp"
#include "RedLib.hpp"

constexpr wchar_t mods_path[] = L"scripts";

RED4EXT_C_EXPORT bool RED4EXT_CALL Main(RED4ext::PluginHandle aHandle, RED4ext::EMainReason aReason, const RED4ext::Sdk* aSdk)
{
    switch (aReason)
    {
    case RED4ext::EMainReason::Load: {
        Red::TypeInfoRegistrar::RegisterDiscovered();

        if (!aSdk->scripts->Add(aHandle, mods_path)) {
            std::cerr << "Failed to add scripts" << std::endl;
            return false;
        }

        std::puts("Hello world!");

        break;
    }
    case RED4ext::EMainReason::Unload:
        break;
    }

    return true;
}

RED4EXT_C_EXPORT void RED4EXT_CALL Query(RED4ext::PluginInfo* aInfo)
{
    aInfo->name = L"playground";
    aInfo->author = L"m4tex";
    aInfo->version = RED4EXT_SEMVER(0, 0, 1);
    aInfo->runtime = RED4EXT_RUNTIME_LATEST;
    aInfo->sdk = RED4EXT_SDK_LATEST;
}

RED4EXT_C_EXPORT uint32_t RED4EXT_CALL Supports()
{
    return RED4EXT_API_VERSION_LATEST;
}