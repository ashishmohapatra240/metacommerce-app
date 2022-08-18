import * as utils from '@dcl/ecs-scene-utils'
import { addBuilding } from "./modules/building"
import { setSceneOrientation } from "./modules/pivot"
import { addSocialLink } from "./modules/socialLink"
import { addVideoScreen } from "./modules/videoScreen"
// import { createDispenser } from "./booth/dispenser"
import { addLogo } from "./modules/logo"
import { addWearable } from "./modules/wearable"
import { NewAv } from './NewAv'
import { base } from './base'
import { SpawnItem } from './spawncoin'
import { birdIdleShape, birdFlyShape,} from './modules/models'
import { realDistance } from './modules/utilities'
import { Gallery } from './video'



Gallery()
setSceneOrientation()
addBuilding()
addLogo()
addSocialLink()
addVideoScreen()
addWearable()
base()

let CountNumber = 0;

const coin = SpawnItem(
  new GLTFShape('models/coin.glb'),
  new Transform({
  position:new Vector3(5,1,6)
  }),
  new AudioClip('sounds/coinPickup.mp3'),
  Number(1)
  )

const coinOne = SpawnItem(
  new GLTFShape('models/coin.glb'),
  new Transform({
  position:new Vector3(9,1,1)
  }),
  new AudioClip('sounds/coinPickup.mp3'),
  Number(2)
  )
//new avatar
const arissa = new NewAv(
  new GLTFShape('models/AvatarOne.glb'),
  new Transform({
    position: new Vector3(0, -0.9, 0),
    scale: new Vector3(0, 0, 0)
  })
)
arissa.setParent(Attachable.AVATAR)


//avatar hide 
const hideAvatarsEntity = new Entity()
hideAvatarsEntity.addComponent(
new AvatarModifierArea({
  area: { box: new Vector3(4,2,4) },
  modifiers: [AvatarModifiers.HIDE_AVATARS]
})
)
hideAvatarsEntity.addComponent(
new Transform({ position: new Vector3(45,3, 65) })
)
engine.addEntity(hideAvatarsEntity)

//Create to show Arissa avatar
hideAvatarsEntity.addComponent(
new utils.TriggerComponent(
  new utils.TriggerBoxShape(new Vector3(4,2,5), Vector3.Zero()),
  {
    onCameraEnter: () => {
      
      arissa.getComponent(Transform).scale.setAll(1)
    },
    onCameraExit: () => {
    arissa.getComponent(Transform).scale.setAll(0)
    }
  }
)
)

// Check if player is moving
const currentPosition = new Vector3()

class CheckPlayerIsMovingSystem implements ISystem {
update() {
  if (currentPosition.equals(Camera.instance.position)) {
    arissa.playIdle()
  } else {
    currentPosition.copyFrom(Camera.instance.position)
    arissa.playRunning()
  }
}
}
engine.addSystem(new CheckPlayerIsMovingSystem())



// used for raycasting later on to generate bird positions along the terrain collider surface
let physicsCast = PhysicsCast.instance

// used to get player position, player distance to birds etc.
let player = Camera.instance

// a component to store each bird's default idle positions, animation state, and a timer with a random delay
@Component("DistanceBird")
export class DistanceBird {  
  originalPos:Vector3    
  flying:boolean = false
  elapsed:number = Math.random()

  constructor(pos:Vector3){
    this.originalPos = new Vector3(pos.x, pos.y, pos.z)           
  }
}

// System that checks distances to each bird
class ProximitySystem {
  radius:number = 8 // how close you can get to a bird before it reacts
  amplitude:number = 1    
  group = engine.getComponentGroup(Transform, DistanceBird)

  update(dt: number) {

    // iterate through all the birds that have the DistanceBird component
    for (let bird of this.group.entities){

      const transform = bird.getComponent(Transform)
      const birdInfo = bird.getComponent(DistanceBird)      

      // calculate the distance between the player and the birds original position
      let dist = realDistance(birdInfo.originalPos, player.position)

      
      // if the player is within a certain distance from the birds original perching position
      if( dist < this.radius ){     

        // calculate a ratio (0-1) based on how close the player is to the bird and multiply it with a constant to amplify the effect
        let multiplier = ( 1 - dist / this.radius) * this.amplitude

        // calculate the direction pointing from the player to the bird's default position
        let playerDir = birdInfo.originalPos.subtract(player.position)

        // if the bird was idle, change it to flying and replace the GLTF model with the flying one
        if(!birdInfo.flying){
          birdInfo.flying = true
          bird.addComponentOrReplace(birdFlyShape)
        }
        
        // move the bird away from the player on the X and Z axis based on the closeness multiplier
        transform.position = birdInfo.originalPos.add(playerDir.multiplyByFloats(multiplier, 0, multiplier))

        // always move the bird upwards on the Y axis (never downwards) regardless of player direction
        transform.position.y = birdInfo.originalPos.y + 6*multiplier

        // increment the timer stored for each bird and use the sine of this time to wiggle the bird around the actual position calculated above
        birdInfo.elapsed +=dt
        transform.position.x += Math.sin( birdInfo.elapsed * 10) * multiplier
        transform.position.y += Math.sin( birdInfo.elapsed * 8 ) * multiplier
        transform.position.z += Math.sin( birdInfo.elapsed * 11) * multiplier

        // make the flying bird always face the player
        transform.lookAt(player.position)
      }
      // in case the player is farther from the bird than the given radius
      else{

        // make the flying bird change GLTF shape to the idle one
        if(birdInfo.flying){
          birdInfo.flying = false
          bird.addComponentOrReplace(birdIdleShape)
        }

        //make the bird land on its original position
        transform.position.copyFrom(birdInfo.originalPos)
        
      }
    }
  }
}
engine.addSystem(new ProximitySystem())

// class that generates bird starting positions and spawns the birds themselves
class BirdController{
  
  center:Vector3
  sideLength:number = 20 // size of the area to spawn birds in
  rows:number = 3
  cols:number = 3 
  spacing:number = this.sideLength/this.rows
  base:Vector3 = new Vector3(14,0,14) 

  constructor(){      

    //set the center of the bird scattering area to the center of the scene
    this.center = new Vector3(24,2,24)    
    
    //set the starting positions of the bird spawn grid to the south-west corner of the spawn area
    this.base = new Vector3(this.center.x - this.sideLength/2, this.center.y, this.center.z - this.sideLength/2) 
  }

  spawnBirds(){

    for(let i=0; i< this.rows; i++){
      for(let j=0; j< this.cols; j++){     

        //generate positions iterating through all rows and columns  and add large random offsets along X an Z (Y will adapt to the terrain later)
        let newPos = new Vector3(
          this.base.x + i* this.spacing + Math.random()*2-1, 
          this.base.y , 
          this.base.z  + j * this.spacing + Math.random()*2-1
          ) 

          // create a ray at the X,Z coord of the generated position which starts high up and has a downward direction
          let rayDown: Ray = {
            origin: new Vector3(newPos.x, 20, newPos.z),
            direction: Vector3.Down(),
            distance: 22,
          }

          // cast the ray downward and try to intersect it with the terrain's collider
          physicsCast.hitFirst(
            rayDown,
            (e) => {
              if(e.didHit){          
                
                //if we hit the collider set the generated bird position's Y coord to the hitpoint's height
                newPos.y = e.hitPoint.y 
                
                //spawn a bird at the generated and terrain adapted position
                const bird = new Entity()      
                bird.addComponent(new Transform({ 
                  position: newPos,
                  rotation: Quaternion.Euler(0, Math.random()*360,0) 
                }))       
                
                // save the bird's original position to the DistanceBird component
                bird.addComponent(new DistanceBird( newPos ))          
                bird.addComponent(birdIdleShape)             
                engine.addEntity(bird)    
              }        
            }            
          )
      }
    }
  }  
}

let birdControl = new BirdController()

// delay bird spawning to only start casting rays on the terrain it's collider is fully loaded
onSceneReadyObservable.add(()=>{
  birdControl.spawnBirds()  
})




