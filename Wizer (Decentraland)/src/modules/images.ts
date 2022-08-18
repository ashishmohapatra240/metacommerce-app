import config from "../config"

export function image(){

        const canvas = new UICanvas()
        const atlas = new Texture("images/mjolnir_p.png")
        
        const uiContainer = new UIContainerRect(canvas)
        uiContainer.width = '100%'
        uiContainer.height = '100%'
        uiContainer.visible = true
        
        const bg = new UIImage(uiContainer, atlas)
        bg.sourceHeight = 130*4
        bg.sourceWidth = 165*4
        bg.sourceLeft = 0
        bg.sourceTop = 0
        bg.width = 500
        bg.height = 400

        const close = new UIImage(uiContainer, atlas)
close.sourceHeight = 540.6
close.sourceWidth = 256
close.sourceLeft = 0
close.sourceTop = 540.8
close.width = 200
close.height = 220
close.positionX=130
close.positionY=-200
close.onClick = new OnClick(() => {
  uiContainer.visible = false
  openExternalURL('https://docs.decentraland.org/development-guide/external-links/')
})
        
return uiContainer
}
