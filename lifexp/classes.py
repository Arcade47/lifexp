from globals import *
from utilities import *
import pyglet
from pyglet import shapes
import random

class Cell:
    def __init__(self, pos, batch, alive=True):
        self.pos = pos
        self.rect = shapes.Rectangle(
                pos[0]*cell_size_pix, 
                pos[1]*cell_size_pix, 
                cell_size_pix, 
                cell_size_pix, 
                color=(0, 0, 0), 
                batch=batch
                )
        if alive: self.emerge()
        else: self.die()

    def die(self):
        self.rect.color = (255, 255, 255)
        self.alive = False

    def emerge(self):
        self.rect.color = (0, 0, 0)
        self.alive = True

    def decide_fate(self, alive):
        if alive: self.emerge()
        else: self.die()

class DrawBatch(pyglet.graphics.Batch):
    def __init__(self):
        super().__init__()

class Gamewindow(pyglet.window.Window):
    def __init__(self, size=[800, 600]):
        super().__init__(size[0], size[1])

class GameObject:
    def __init__(self):
        self.rel_coords = []

    def apply_pos(self, pos):
        x, y = pos
        self.coords = [[x+rel_x, y+rel_y] for rel_x, rel_y in self.rel_coords]

    def rotate(self):
        pass # TODO

    def put_in_playfield(self, playfield):
        [playfield.cells[row_i][col_i].emerge() for row_i, col_i in self.coords]

class Glider(GameObject):
    def __init__(self):
        super().__init__()
        self.rel_coords = [
                    [-1, 0],
                            [ 0, 1],
            [ 1,-1],[ 1, 0],[ 1, 1]
        ]

class Playfield:
    """
    consists of Cells
    """

    def __init__(self, batch, size=[100,100]):
        self.width, self.height = size
        self.batch = batch
        self.center = [round(self.width/2), round(self.height/2)] # utility class var :)
        
        # first init all cells empty
        self.cells = [[Cell([x_i, y_i], batch, alive=False) for y_i in range(self.height)] for x_i in range(self.width)]

        # now place some objects
        self.add_object(Glider, self.center)

        self.buffer = [[False for _1 in range(self.height)] for _2 in range(self.width)]

    def add_object(self, obj_type, pos):
        obj = obj_type()
        obj.apply_pos(pos)
        [self.cells[row_i][col_i].emerge() for row_i, col_i in obj.coords]

    def update(self):

        # before updating the cells, obtain a buffer field
        self.buffer = [
                [right_amount(count_neighbours(cell, self), cell.alive) for cell in row] 
                for row in self.cells
                ]
        
        # apply the buffer field all at once
        [self.cells[row_ind][col_ind].decide_fate(alive) 
            for row_ind, row in enumerate(self.buffer) 
            for col_ind, alive in enumerate(row)]
        # for row_ind, row in enumerate(self.buffer):
        #     for col_ind, alive in enumerate(row):
        #         if alive: self.cells[row_ind][col_ind].emerge()
        #         else: self.cells[row_ind][col_ind].die()