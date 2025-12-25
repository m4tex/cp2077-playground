// NOTE: If you remove this file and scripts folder is empty, your plugin won't start
// Edit main.cpp where aSdk->scripts->Add() is called (return false is what prevents startup)

class HelloWorldService extends ScriptableService {
    private cb func OnLoad() {
        // This one you can see in CyberEngineTweaks Game Log window (you might have to install this mod)
        Log("Hello, World!");
    }
}