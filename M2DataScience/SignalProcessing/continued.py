# Split the data into training and testing sets
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2)

# Train the perceptron with different feature sets
feature_sets = [
    extract_target_word_features,
    extract_neighbour_features,
    extract_sentence_level_features,
    extract_simple_target_word_based_features,
    extract_word_dimension_reduction_pca
]

for feature_set in feature_sets:
    pipeline = Pipeline([
        ('extract_features', FunctionTransformer(feature_set)),
        ('classifier', Perceptron())
    ])

    pipeline.fit(X_train, y_train)
    y_pred = pipeline.predict(X_test)

    # Evaluate the accuracy of the model
    accuracy = accuracy_score(y_test, y_pred)
    print(f"Accuracy with {feature_set.__name__} feature set: {accuracy:.3f}")
