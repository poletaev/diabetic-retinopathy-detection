#!/usr/bin/env python
import numpy as np
import caffe
import os
import pandas as pd
import time

def main():
    caffe.set_mode_gpu()
    caffe.set_device(1)
    test_data_folder = '../data/testdata'
    submission = pd.read_csv('../submissions/sampleSubmission.csv')

    print 'loading data'
    paths = map(lambda x: os.path.join(test_data_folder, x + '.jpeg'), submission['image'])

    print 'loading model'
    clf = caffe.Classifier('/mnt/caffe/models/bvlc_googlenet/deploy.prototxt',
                           '/mnt/caffe/models/bvlc_googlenet/bvlc_googlenet_kaggle_iter_9000.caffemodel')

    print 'classifying test set'
    start = time.time()
    predictions = []
    batch_size = 64
    for i in range(0, len(paths), batch_size):
        batch_start = time.time()
        print 'processing {} batch of {}'.format(i/batch_size + 1, len(paths)/batch_size + 1)
        inputs = [caffe.io.load_image(im_f) for im_f in paths[i:i + batch_size]]
        predictions.append(clf.predict(inputs))
        print 'done in %.2f s.' % (time.time() - batch_start)
    predictions = np.vstack(predictions)
    print 'overall processing took %.2f s.' % (time.time() - start)

    print 'saving result'
    new_submission = pd.DataFrame(data={'image': submission['image'],
                                        'level': predictions.argmax(axis=1)})
    new_submission.to_csv('../submissions/fine-tuned-bvlc-googlenet-submission.csv', index=False)

if __name__ == '__main__':
    main()
