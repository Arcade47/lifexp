#include <gb/gb.h>
#include <stdio.h>
#include <stdint.h>
#include <rand.h>
#include <stdlib.h>
#include <string.h>
#include "GOL_4by4.c"

// #include <time.h>
// #include "GOL_4by4_tilemap_test1.c"

#define ARRAY_SIZE 360
#define GOL_tiles_testWidth 20
#define GOL_tiles_testHeight 18
#define GOL_tiles_testBank 0

void main(){

    // Initialize random number generator
    initrand(123);

    set_bkg_data(0, 14, GOL_4by4);

    unsigned char GOL_tiles_test[ARRAY_SIZE]; // =
    // {
    //     0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
    //     0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
    //     0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
    //     0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
    //     0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
    //     0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
    //     0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
    //     0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
    //     0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
    //     0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
    //     0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
    //     0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
    //     0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
    //     0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
    //     0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
    //     0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
    //     0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
    //     0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
    // };
    unsigned char GOL_tiles_test_copy[ARRAY_SIZE];

    // random setting of tiles
    for (int i = 0; i < ARRAY_SIZE; i++) {
        // unsigned int r = rand() % 13; // TODO check if this is a fair distribution across 13 options
        unsigned int r = (rand() % 2) * 13;
        GOL_tiles_test[i] = r;
        // printf("%u", r);
        // delay(100);
    }

    set_bkg_tiles(0, 0, 20, 18, GOL_tiles_test);

    SHOW_BKG;
    DISPLAY_ON;
    
    while(1){

        // make a copy that the state can be updated offline
        memcpy(GOL_tiles_test_copy, GOL_tiles_test, sizeof(GOL_tiles_test));

        // for each tile: check neighbours and identify new state
        // make a boundary layer to make things easier for the beginning (no wrap around)
        for (int i = 1; i < GOL_tiles_testWidth - 1; i++) {
            for (int j = 1; j < GOL_tiles_testHeight - 1; j++) {
                // count the neighbours
                int neighbours = 0;
                // TODO the function get_bkg_tile_xy not needed and too slow probably
                if (get_bkg_tile_xy(i-1, j-1) == 13) {neighbours += 1;}
                if (get_bkg_tile_xy(i+0, j-1) == 13) {neighbours += 1;}
                if (get_bkg_tile_xy(i+1, j-1) == 13) {neighbours += 1;}
                if (get_bkg_tile_xy(i-1, j+0) == 13) {neighbours += 1;}
                // if (get_bkg_tile_xy(i+0, j+0) == 13) {neighbours += 1;} // not itself
                if (get_bkg_tile_xy(i+1, j+0) == 13) {neighbours += 1;}
                if (get_bkg_tile_xy(i-1, j+1) == 13) {neighbours += 1;}
                if (get_bkg_tile_xy(i+0, j+1) == 13) {neighbours += 1;}
                if (get_bkg_tile_xy(i+1, j+1) == 13) {neighbours += 1;}
                
                // apply GOL rules:
                if (get_bkg_tile_xy(i+0, j+0) == 13) {
                    // Any live cell with fewer than two live neighbors dies, as if by underpopulation.
                    if (neighbours < 2) {GOL_tiles_test_copy[i+GOL_tiles_testWidth*j] = 0;}
                    // Any live cell with two or three live neighbors lives on to the next generation.
                        // no changes needed here
                    // Any live cell with more than three live neighbors dies, as if by overpopulation.
                    if (neighbours > 3) {GOL_tiles_test_copy[i+GOL_tiles_testWidth*j] = 0;}
                }
                if (get_bkg_tile_xy(i+0, j+0) == 0) {
                    // Any dead cell with exactly three live neighbors becomes a live cell, as if by reproduction.
                    if (neighbours == 3) {GOL_tiles_test_copy[i+GOL_tiles_testWidth*j] = 13;}
                }
            }
        }
        // copy back
        memcpy(GOL_tiles_test, GOL_tiles_test_copy, sizeof(GOL_tiles_test_copy));

        set_bkg_tiles(0, 0, 20, 18, GOL_tiles_test);

        // printf("%u", get_bkg_tile_xy(0, 2));
        
        // delay(20);
    }

    

    // // put tiles in random positions
    // set_bkg_data(0, 13, GOL_4by4);

    // unsigned char GOL_tiles_test[ARRAY_SIZE];

    // // Fill the array in a loop using values predefined or computed

    // set_bkg_tiles(0, 0, 20, 18, GOL_tiles_test);






    // minimal test

    // unsigned char r;

    // for (int i = 0; i < 8; i++) {
    //     r = i; // directly assign i to r
    //     printf("0x%02X\n", r);
    //     delay(100);
    // }
}