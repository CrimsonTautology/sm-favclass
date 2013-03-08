sm_favclass
===============

TF2 Plugin to automatically assign a player to a team by forcing a player to a
random class.  Includes a way for the player to configure what their "favorite"
class is so that they will default to that class everytime they join the
server.

Installation
---------------
Assuming you already have Sourcemod installed on your server, compile this script with

> `spcomp favclass.sp`

and put the compiled .smx file in your `"tf/addons/sourcemod/plugins"`
directory.

Usage
---------------
When on a server with favclass enabled simply type into chat:

> `!favclass [classname]`

Where `[classname]` is an optional class name.  If you don't specify a class a popup menu will be presented to you.
