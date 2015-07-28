#!/usr/bin/env python
"""
classify.py is an out-of-the-box image classifer callable from the command line.

By default it configures and runs the Caffe reference ImageNet model.
"""
import numpy as np
import caffe
import os
import pandas as pd

def main():
    caffe.set_mode_cpu()
    net = caffe.Net('../data/deploy.prototxt',
                    '../data/bvlc_googlenet_kaggle_iter_11000.caffemodel',
                    caffe.TEST)
    test_data_folder = '../data/testdata'
    submission = pd.read_csv('../submissions/sampleSubmission.csv')

    transformer = caffe.io.Transformer({'data': net.blobs['data'].data.shape})
    transformer.set_transpose('data', (2, 0, 1))
    transformer.set_raw_scale('data', 255)
    transformer.set_channel_swap('data', (2, 1, 0))

    net.blobs['data'].reshape(1, 3, 224, 224)

    for f in os.listdir(test_data_folder):
        net.blobs['data'].data[...] = transformer.preprocess('data',
        caffe.io.load_image(os.path.join(test_data_folder, f)))
        out = net.forward()
        prediction = out['prob'].argmax()
        submission.loc[submission.image == f.rstrip('.jpeg'), 'level'] = \
            prediction
        print("Predicted class for {} is {}.".format(f, prediction))
    submission.to_csv('../data/submission.csv', index=False)

if __name__ == '__main__':
    main()
