# RealAir Turbine Duke V2 LINDA Module

This repository is made to publish and document the lua-Script for LINDA made for the _RealAir Turbine Duke V2. 
At the moment the focus is still on publishing the [actions.lua](Modules/linda/aircrafts/RealAir%20Duke%20Turbine%20V2/actions.lua) not on implementing the complete module.

![ScreenShot](/img/Title.png)

## Table of contents
* [Quick start](#quick-start)
* [Documentation](#documentation)
* [Contributing](#contributing)
* [Bugs and feature requests](#bugs-and-feature-requests)
* [Copyright and license](#Copyright-and-license)

## Quick start
### Prerequesities
You can use this Module only as long as you have running
* a Flight-Simulator (eg. Prepar3D / FSX) 
* [FSUIPC](http://www.schiratti.com/dowson.html) 
* [LINDA](http://www.fs-linda.com/)
* a device to use with LINDA 

### Installation
Several quick start options are available:
* [Download the latest LINDA Module](https://github.com/joeherwig/RealAir-Turbine-Duke-V2-LUA/archive/master.zip) and copy the folder "Modules" from the zip to your Flight-Simulators root-folder eg. 
  * `C:\Program Files (x86)\Lockheed Martin\Prepar3D v2\` or 
  * `C:\Program Files (x86)\C:\Program Files (x86)\Microsoft Games\Microsoft Flight Simulator X\`
* Clone the repo: `git clone https://github.com/joeherwig/RealAir-Turbine-Duke-V2.git` and move the complete subfolder "Modules" to your FS-Root.

## Documentation
I tried to name all functions in a way that directly tells you what it does.
In some special cases it might be neccesary to explain you something more detailed. Then i make some additional remarks in this section. So this section is not intended to repeat everything i allreade "said" while giving the function names. So ... It will not be complete and hopefully not bother you with its length.

### Avionics
Switching on the avionics is useally not done all at the same time. The listed function to switch the avionics, contains some *delays* to reflect this.

### Electrics
Turbine Ignition

![Turbine Ignition](/img/TurbineIgnition.png)

The "Ignition_..._toggle_OffAuto"-functions only toggle between "Off" and "Auto" and vice versa. The third state of this button "on" isn't reflected in this function, because i have only a simple pushbutton and it seems, "Auto" is enough for my needs, so that explicit "on" can be skipped.

### Init
On Loading the vehicle i only hide the yokes to enable a better view to the buttons hidden behind the yokes. If you prefer not to hide the yokes, feel free to remove the line Yoke_Hide() from the init.
### Other

## Contributing

Probably you want push this script a small step or a big leap forward. You're welcome to do so. Just fork this repo, check-in your changes and send me a pull-request.
If you're not familiar with using Github you can also send me a Email to inform me about the changes and additions you made, and i'll probably embed them into my repo.

## Bugs and feature requests

Have a bug or a feature request? Please check first whether your problem or idea is addressed already. If not, please feel free to open a new [issue](https://github.com/joeherwig/RealAir-Turbine-Duke-V2-LUA/issues).

## Copyright and license

Code and documentation copyright 2015 JoeHerwig released under [the MIT license](LICENSE). Docs released under Creative Commons.