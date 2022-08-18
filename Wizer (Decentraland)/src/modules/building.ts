import { pivotScene } from "./pivot"

export function addBuilding() {
    const building = new Entity()
    building.addComponent(new GLTFShape("models/store/WoodStore.glb"))
    building.setParent(pivotScene)


    let photoMachine = new Entity()
    photoMachine.addComponent(new GLTFShape("models/store/photo_machine.glb"))
    photoMachine.setParent(pivotScene)

    //PHOTO MACHINE ANIMATION
    photoMachine.addComponent(new Animator())
    let photoAnim1 = new AnimationState("pmPlay_1")
    let photoAnim2 = new AnimationState("pmPlay_2")

    photoMachine.getComponent(Animator).addClip(photoAnim1)
    photoMachine.getComponent(Animator).addClip(photoAnim2)

    photoAnim1.playing = true
    photoAnim2.playing = true
}