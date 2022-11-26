rel_inds = [
    [-1,-1],
    [-1, 0],
    [-1, 1],
    [ 0,-1],
    # [ 0, 0], # not considering itself
    [ 0, 1],
    [ 1,-1],
    [ 1, 0],
    [ 1, 1],
]

def count_neighbours(cell, playfield):
    # with no conditionals while indexing, it should wrap around
    row_i, col_i = cell.pos
    return sum([
            int(playfield.cells[(row_i + rel_row_add)%playfield.width][(col_i + rel_col_add)%playfield.height].alive) 
            for rel_row_add, rel_col_add in rel_inds
            ])

def right_amount(amount, alive):
    assert amount >= 0 and amount <= 8, f"lifexp error: incorrect number of neighbours ({amount} is not between 0 and 8)"

    # TODO consider globally set rules
    return (alive and amount in [2, 3]) or (not alive and amount == 3)

def read_coords_from_bitmap(fname):
    return # TODO