from classes import *

batch = pyglet.graphics.Batch()
window = Gamewindow()
fps_display = pyglet.window.FPSDisplay(window=window)

playfield = Playfield(batch)

def update(dt):
    playfield.update()

@window.event
def on_draw():
    window.clear()

    # draws
    batch.draw()
    fps_display.draw()

pyglet.clock.schedule_interval(update, update_speed)

pyglet.app.run()