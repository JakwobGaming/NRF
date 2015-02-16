#define FILTERSCRIPT
#include <a_samp>

public OnFilterScriptInit()
{
  print("Test Filterscript Loaded");
  return 1;
}

public OnFilterScriptExit()
{
  print("Test Filterscript unloaded");
  return 1;
}
