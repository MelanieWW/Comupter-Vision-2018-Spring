import time
script_start_time = time.time()

import pandas as pd
import numpy as np
import json

pd.set_option('display.max_rows', 600)
pd.set_option('display.max_columns', 50)
import warnings
warnings.filterwarnings('ignore')

data_path = "../input"


# 1. Load data =================================================================
print('%0.2f min: Start loading data'%((time.time() - script_start_time)/60))

train={}
test={}
validation={}
with open('C:/Users/Meixin/train.json') as json_data:
    train= json.load(json_data)
with open('C:/Users/Meixin/test.json') as json_data:
    test= json.load(json_data)
with open('C:/Users/Meixin/validation.json') as json_data:
    validation = json.load(json_data)

print('Train No. of images: %d'%(len(train['images'])))
print('Test No. of images: %d'%(len(test['images'])))
print('Validation No. of images: %d'%(len(validation['images'])))

# JSON TO PANDAS DATAFRAME
# train data
train_img_url=train['images']
train_img_url=pd.DataFrame(train_img_url)
train_ann=train['annotations']
train_ann=pd.DataFrame(train_ann)
train=pd.merge(train_img_url, train_ann, on='imageId', how='inner')

# test data
test=pd.DataFrame(test['images'])
test_img_url=pd.DataFrame(test_img_url)
test_ann=train['annotations']
train_ann=pd.DataFrame(train_ann)
train=pd.merge(train_img_url, train_ann, on='imageId', how='inner')

# Validation Data
val_img_url=validation['images']
val_img_url=pd.DataFrame(val_img_url)
val_ann=validation['annotations']
val_ann=pd.DataFrame(val_ann)
validation=pd.merge(val_img_url, val_ann, on='imageId', how='inner')

datas = {'Train': train, 'Test': test, 'Validation': validation}
for data in datas.values():
    data['imageId'] = data['imageId'].astype(np.uint32)

print('%0.2f min: Finish loading data'%((time.time() - script_start_time)/60))
print('='*50)