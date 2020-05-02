import pickle
import json
import os
import numpy as np
from sklearn.svm import LinearSVC
from .models import MLModelExamples
from django.shortcuts import get_object_or_404

dir_path = os.path.dirname(os.path.realpath(__file__))

def load_linear_svc(example_id, data):
    linear_svc = LinearSVC()
    data = np.expand_dims(data, axis=0)
    example = get_object_or_404(MLModelExamples, pk=example_id)
    linear_svc = pickle.load(open(dir_path+example.path, 'rb'))
    prediction = linear_svc.predict(data)
    return example.fields['classes'][prediction[0]]
