export function base(){

const base = new Entity()
engine.addEntity(base)
base.addComponent(new GLTFShape('models/sandbase.glb'))
base.addComponent(
  new Transform({
    position: new Vector3(45,0.21,50),
    
  })
)
}
