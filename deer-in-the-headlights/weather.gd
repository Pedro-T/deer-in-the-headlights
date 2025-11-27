extends Node

func start() -> void:
    $RainSound.play()
    $RainParticles.emitting = true
    $LightingDelayTimer.connect("timeout", func() -> void: $LightningAnimation.play("flash"))
    $LightingDelayTimer.start()

func stop() -> void:
    $RainSound.stop()
    $RainParticles.emitting = false
    $LightingDelayTimer.stop()
