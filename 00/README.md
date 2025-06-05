### 📁 00 – Template 🌍

This folder is a simple starting point for new projects.  
When you run the `clone-template.ps1` script, everything in here gets copied into your new project folder — super handy for keeping things consistent.

#### 🔄 How It's Used

The script `clone-template.ps1` will use this folder by default if you don’t tell it where to grab a template from (using `-TemplateTarget`).

#### 📦 What's Inside

- A clean HTML5 file with a linked CSS stylesheet
- Basic CSS using Google Fonts (`Sen`) and a simple layout reset
- A centered `.container` class to get you started
- Empty `assets/fonts` and `assets/images` folders ready for your stuff
- An `.editorconfig` file to help keep code style consistent
- Just enough to give you a solid, no-frills starting point

#### 🚀 How to Use

To clone this template into a new project:

```powershell
.\clone-template.ps1 -Destination "MyProject"
```
