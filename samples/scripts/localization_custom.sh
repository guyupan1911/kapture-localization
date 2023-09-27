# If the COLMAP executable is not available from PATH, the parameter -colmap needs to be set
#   example: -colmap C:/Workspace/dev/colmap/colmap.bat
# For RobotCar or RobotCar_v2 --benchmark-style RobotCar_Seasons needs to be added.
# For Gangnam_Station --benchmark-style Gangnam_Station
# For Hyundai_Department_Store --benchmark-style Hyundai_Department_Store
# For RIO10 --benchmark-style RIO10
# For ETH-Microsoft --benchmark-style ETH_Microsoft
cd /kapture-localization/samples/virtual_gallery_tutorial
kapture_pipeline_localize.py -v info \
      -i ./mapping \
      --query ./query \
      -kpt ./local_features/r2d2_500/keypoints \
      -desc ./local_features/r2d2_500/descriptors \
      -gfeat ./global_features/AP-GeM-LM18/global_features \
      -matches ./local_features/r2d2_500/NN_no_gv/matches \
      -matches-gv ./local_features/r2d2_500/NN_colmap_gv/matches \
      --colmap-map ./colmap-sfm/r2d2_500/AP-GeM-LM18_top5 \
      -o ./colmap-localization/r2d2_500/AP-GeM-LM18_top5/AP-GeM-LM18_top5/ \
      --topk 5 \
      --config 2