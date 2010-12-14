#include <set>
#include <string>
#include <iostream>
#include <windows.h>

const unsigned char PF_Proportional = 0x01;

using namespace std;

int CALLBACK EnumFontFamExProc(
    ENUMLOGFONTEXW *lpelfe,
    NEWTEXTMETRICEXW *lpntme,
    int fonttype,
    set<string> *fonts
) {
  if (lpntme->ntmTm.tmPitchAndFamily & PF_Proportional)
    return TRUE;

  char name[1000];
  int nLen = WideCharToMultiByte(
      CP_UTF8, 0,
      lpelfe->elfLogFont.lfFaceName, -1,
      name, sizeof(name) - 1,
      NULL,
      NULL
  );

  if (!nLen)
    return TRUE;

  if (name[0] == '@')
    return TRUE;

  set<string>::iterator it = fonts->find(name);

  if (it != fonts->end())
    return TRUE;

  cout << name << std::endl;
  fonts->insert(name);

  return TRUE;
}

int main (int argc, char **argv) {
  set<string> fonts;
  LOGFONTW lfFont;
  lfFont.lfCharSet = DEFAULT_CHARSET;
  lfFont.lfFaceName[0] = 0;
  lfFont.lfPitchAndFamily = 0;
  HDC hdc = GetDC(0);
  EnumFontFamiliesExW(
    hdc,
    &lfFont,
    reinterpret_cast<FONTENUMPROCW>(EnumFontFamExProc),
    reinterpret_cast<LPARAM>(&fonts),
    0
  );
  ReleaseDC(0, hdc);
  return 0;
}



