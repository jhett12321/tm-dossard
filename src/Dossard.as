class Dossard
{
  GUI@ gui;

  Dossard(GUI@ gui)
  {
    @this.gui = gui;
  }

  void Tick(float deltaTime)
  {
    auto app = GetApp();
    auto isEditor = app.Editor !is null;
    auto isOnline = app.PlaygroundScript is null;
    auto playground = cast<CSmArenaClient>(app.CurrentPlayground);

    gui.guiHidden = playground is null || playground.Interface is null || Dev::GetOffsetUint32(playground.Interface, 0x1C) == 0;
    gui.visible = false;

    if (playground is null || playground.Arena is null || playground.Map is null || playground.GameTerminals.Length <= 0)
    {
      return;
    }

    auto player = GetViewingPlayer(playground);
    if (player is null)
    {
      return;
    }
    
    if (player.ScriptAPI is null)
    {
      return;
    }

    gui.UpdateData(player.ScriptAPI.Dossard, player.ScriptAPI.Dossard_Color);
    gui.visible = true;
  }

  CSmPlayer@ GetViewingPlayer(CSmArenaClient@ playground)
  {
    if (playground is null || playground.GameTerminals.Length != 1)
    {
      return null;
    }

    return cast<CSmPlayer>(playground.GameTerminals[0].GUIPlayer);
  }
}