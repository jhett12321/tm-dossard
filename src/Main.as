#if TMNEXT
Dossard@ dossard = null;
GUI@ gui = null;

void Main()
{
  @gui = GUI();
  @dossard = Dossard(gui);
}

void Update(float deltaTime)
{
  dossard.Tick(deltaTime);
}

void Render()
{
  if(dossard !is null && gui !is null)
  {
    gui.Render();
  }
}

void RenderMenu()
{
  if (UI::MenuItem("\\$f00" + Icons::ExclamationTriangle + "\\$z Dossard Overlay", "", gui.pluginEnabled))
  {
    gui.pluginEnabled = !gui.pluginEnabled;
  }
}

#else
void Main() 
{
	print("This plugin is only compatible with TM 2020!");
}
#endif