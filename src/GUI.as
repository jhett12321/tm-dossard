[Setting name="Font size" min=8 max=72 category="General"]
int fontSize = 42;

[Setting name="X position" min=0 max=1 category="General"]
float anchorX = 0.584f;

[Setting name="Y position" min=0 max=1 category="General"]
float anchorY = 0.949f;

[Setting name="Width" min=0.01 max=.3 category="General"]
float scaleX = 0.031f;

[Setting name="Height" min=0.01 max=.3 category="General"]
float scaleY = 0.045f;

[Setting name="Show when GUI is hidden" category="General"]
bool showWhenGuiHidden = true;

[Setting color name="Box colour" category="General"]
vec4 boxColour = vec4(0, 0, 0, 0.55f);

int shadowX = 1;
int shadowY = 1;

class GUI
{
    string dossard;
    vec3 dossardColor;
    bool pluginEnabled = true;
    bool visible = true;
    bool guiHidden = false;

    void UpdateData(string dossard, vec3 dossardColor)
    {
        this.dossard = dossard;
        this.dossardColor = dossardColor;
    }

    void Render()
    {
        if(!pluginEnabled) return;

        if((guiHidden && !showWhenGuiHidden) || !visible)
            return;
        nvg::FontSize(fontSize);

        float screenScaleX = float(Draw::GetWidth()) / 2560;
        float screenScaleY = float(Draw::GetHeight()) / 1440;

        nvg::Save();
        nvg::Scale(screenScaleX, screenScaleY);
        RenderDefaultUI();
        nvg::Restore();
    }

    void RenderDefaultUI()
    {
        uint boxWidth = uint(scaleX * 2560);
        uint boxHeight = uint(scaleY * 1440);
        uint x = uint(anchorX * 2560 - boxWidth / 2);
        uint y = uint(anchorY * 1440 - boxHeight / 2);

        nvg::BeginPath();
        nvg::RoundedRect(x, y, boxWidth, boxHeight, 10);
        nvg::FillColor(boxColour);
        nvg::Fill();
        nvg::ClosePath();

        nvg::TextAlign(nvg::Align::Center | nvg::Align::Middle);

        int textX = x;
        int textY = y + boxHeight / 2 + 2;
        
        // Shadow
        nvg::FillColor(vec4(0, 0, 0, 1));
        nvg::TextBox(textX + 1, textY + 1, boxWidth, dossard);

        // Text
        nvg::FillColor(vec4(dossardColor.x, dossardColor.y, dossardColor.z, 1));
        nvg::TextBox(textX, textY, boxWidth, dossard);
    }
}