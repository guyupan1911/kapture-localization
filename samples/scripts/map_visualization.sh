cd /kapture-localization/samples/virtual_gallery_tutorial
colmap gui \
    --database_path ./colmap-sfm/r2d2_500/AP-GeM-LM18_top5/colmap.db \
    --image_path ./mapping/sensors/records_data \
    --import_path ./colmap-sfm/r2d2_500/AP-GeM-LM18_top5/reconstruction/ # only available in colmap 3.6