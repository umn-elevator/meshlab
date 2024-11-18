import pymeshlab
import sys
import os
ms = pymeshlab.MeshSet()
# get input and output arguments from the commandline
conversion_type = sys.argv[1]
input_file = sys.argv[2]
output_file = sys.argv[3]
ms.load_new_mesh(input_file)

# get parent folder of input file

# input_folder = os.path.dirname(input_file)
# copy our /root/dummy.png to the input folder
# os.system('cp /root/dummy.png ' + input_folder)

def dump(obj):
   for attr in dir(obj):
       if hasattr( obj, attr ):
           print( "obj.%s = %s" % (attr, getattr(obj, attr)))


if(conversion_type == 'obj_to_ply'):
    ms.apply_filter('compute_color_from_texture_per_vertex')

ms.save_current_mesh(output_file)