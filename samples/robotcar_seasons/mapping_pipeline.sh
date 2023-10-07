# 0) Define paths and params
LOCAL_FEAT_DESC=r2d2_WASF_N8_big
LOCAL_FEAT_KPTS=20000 # number of local features to extract
GLOBAL_FEAT_DESC=Resnet101-AP-GeM-LM18
GLOBAL_FEAT_TOPK=20  # number of retrieved images for mapping and localization

DATASETS_PATH=/kapture-localization/data/RobotCar_Seasons-v2
MODEL_PATH=/kapture-localization/data
PYTHONBIN=python3

pip3 install scikit-learn==0.22 torchvision==0.5.0 gdown tqdm

# Extract global features (we will use AP-GeM here)
# Deep Image retrieval - AP-GeM
if [ ! -d ${MODEL_PATH}/deep-image-retrieval ]; then
  cd ${MODEL_PATH}
  git clone https://github.com/naver/deep-image-retrieval.git
fi

# downloads a pre-trained model of AP-GeM
if [ ! -f ${MODEL_PATH}/deep-image-retrieval/dirtorch/data/${GLOBAL_FEAT_DESC}.pt ]; then
  mkdir -p ${MODEL_PATH}/deep-image-retrieval/dirtorch/data/
  cd ${MODEL_PATH}/deep-image-retrieval/dirtorch/data/
  gdown --id 1r76NLHtJsH-Ybfda4aLkUIoW3EEsi25I
  unzip ${GLOBAL_FEAT_DESC}.pt.zip
  rm -f ${GLOBAL_FEAT_DESC}.pt.zip
fi

cd ${MODEL_PATH}/deep-image-retrieval
${PYTHONBIN} -m dirtorch.extract_kapture --kapture-root /kapture-localization/data/datasets/4seasons/places/neighborhood/mapping \
--checkpoint ${MODEL_PATH}/deep-image-retrieval/dirtorch/data/${GLOBAL_FEAT_DESC}.pt --gpu 0

# move global features to right location
# see https://github.com/naver/kapture-localization/blob/main/doc/tutorial.adoc#recommended-dataset-structure
mkdir -p ${DATASETS_PATH}/places/global_features/${GLOBAL_FEAT_DESC}/global_features
mv ${DATASETS_PATH}/places/mapping_query/reconstruction/global_features/${GLOBAL_FEAT_DESC}/* \
    ${DATASETS_PATH}/places/global_features/${GLOBAL_FEAT_DESC}/global_features
rm -rf ${DATASETS_PATH}/mapping_query/reconstruction/global_features/${GLOBAL_FEAT_DESC}
