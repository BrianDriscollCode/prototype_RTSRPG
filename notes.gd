extends Node
 
# Notes:

#1. Need to create state for each character 
# - Contains current selected skill
# - Future: Contains health
# - Future: Contains status effects

#2. Using a skillFactory to generate skills is bad
# - Need to generate spell from within the character to the tilemap
# - After the progressbar fills, the tween emits signal, then the skill shoots
# - Need to store the position of the skill and what skill somewhere.


#3. Figuring out how to add arrows to a tile position
