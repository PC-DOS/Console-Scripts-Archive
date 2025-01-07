bcdedit /store BCD /set {bootmgr} displaybootmenu on
bcdedit /store BCD /set {bootmgr} timeout 25
bcdedit /store BCD /deletevalue {bootmgr} customactions
bcdedit /store BCD /deletevalue {bootmgr} custom:54000001
bcdedit /store BCD /deletevalue {bootmgr} custom:54000002
bcdedit /store BCD /displayorder {default} {0ff5f24a-3785-4aeb-b8fe-4226215b88c4} {bd8951c4-eabd-4c6f-aafb-4ddb4eb0469b}