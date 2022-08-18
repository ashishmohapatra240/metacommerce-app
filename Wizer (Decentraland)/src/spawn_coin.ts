import * as utils from '@dcl/ecs-scene-utils'
import { ColorString } from '@decentraland/Identity';

export function SpawnItem(
  model: GLTFShape,
  transform: Transform,
  sound: AudioClip,
  CountNumber: Number,

) {
  // let counter = 0;
  let entity = new Entity()
  engine.addEntity(entity)
  entity.addComponent(model)
  entity.addComponent(transform)

  let soundEntity = new Entity()
  soundEntity.addComponent(new AudioSource(sound))
  soundEntity.addComponent(new Transform())

  engine.addEntity(soundEntity)
  soundEntity.setParent(Attachable.AVATAR)

  /**
   * This trigger allows the player to stand on the same spot and continually
   * pick up an item without having to exit and re-enter the trigger themselves
   */
  entity.addComponent(
    new utils.TriggerComponent(
      new utils.TriggerBoxShape(new Vector3(1.5, 3, 1.5)), // We need a separate trigger instance for each item as we'll be modifying it
      {
        onCameraEnter: () => {
          
          log("count is ",CountNumber)
          log("count is ",CountNumber)
          soundEntity.getComponent(AudioSource).playOnce()
          entity.getComponent(Transform).scale.setAll(0)
          entity.getComponent(utils.TriggerComponent).shape.position.y = -100 // Move the trigger so that the player exits and re-enters the trigger

        },
      }
    )
  )

  return entity
}
