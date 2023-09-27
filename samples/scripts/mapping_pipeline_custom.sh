cd /kapture-localization/samples/virtual_gallery_tutorial
kapture_pipeline_mapping.py -v info \
    -i ./mapping \
    -kpt ./local_features/r2d2_500/keypoints \
    -desc ./local_features/r2d2_500/descriptors \
    -gfeat ./global_features/AP-GeM-LM18/global_features \
    -matches ./local_features/r2d2_500/NN_no_gv/matches \
    -matches-gv ./local_features/r2d2_500/NN_colmap_gv/matches \
    --colmap-map ./colmap-sfm/r2d2_500/AP-GeM-LM18_top5 \
    --topk 5

