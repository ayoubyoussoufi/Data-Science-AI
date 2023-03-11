from sklearn.linear_model import Perceptron
from sklearn.pipeline import Pipeline
from sklearn.preprocessing import FunctionTransformer
from sklearn.decomposition import PCA

# Define a function to extract the target word-based features
def extract_target_word_features(X):
    return [[word] for word, tag in X]

# Define a function to extract the left and right neighbours
def extract_neighbour_features(X):
    neighbours = []
    for i in range(len(X)):
        word, tag = X[i]
        left_neighbour = X[i-1][0] if i > 0 else '<START>'
        right_neighbour = X[i+1][0] if i < len(X) - 1 else '<END>'
        neighbours.append([left_neighbour, right_neighbour])
    return neighbours

# Define a function to extract sentence level features
def extract_sentence_level_features(X):
    sentence_level_features = []
    for i in range(len(X)):
        word, tag = X[i]
        sentence_level_features.append([len(X)])
    return sentence_level_features

# Define a function to extract simple target word-based features, left and right neighbours 
def extract_simple_target_word_based_features(X):
    return [extract_target_word_features(X), extract_neighbour_features(X)]

# Define a function to extract word dimension reduction (PCA) 
def extract_word_dimension_reduction_pca(X):
    return PCA(n_components=3).fit_transform(X)

# Define a function to extract features
def extract_features(X):
    return [extract_simple_target_word_based_features(X), extract_sentence_level_features(X), extract_word_dimension_reduction_pca(X)]

# Define the pipeline
pipeline = Pipeline([
    ('extract_target_word_features', FunctionTransformer(extract_target_word_features)),
    ('extract_neighbour_features', FunctionTransformer(extract_neighbour_features)),
    ('extract_sentence_level_features', FunctionTransformer(extract_sentence_level_features)),
    ('extract_simple_target_word_based_features', FunctionTransformer(extract_simple_target_word_based_features)),
    ('extract_word_dimension_reduction_pca', FunctionTransformer(extract_word_dimension_reduction_pca)),
    ('
