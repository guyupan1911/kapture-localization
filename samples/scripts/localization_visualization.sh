cd /kapture-localization/samples/virtual_gallery_tutorial
colmap gui \
    --database_path ./colmap-localization/r2d2_500/AP-GeM-LM18_top5/AP-GeM-LM18_top5/colmap_localized/colmap.db \
    --image_path query/sensors/records_data \
    --import_path ./colmap-localization/r2d2_500/AP-GeM-LM18_top5/AP-GeM-LM18_top5/colmap_localized/reconstruction/ # only available in colmap 3.6