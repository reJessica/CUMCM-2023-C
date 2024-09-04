num_clusters = 8;
[idx, centers] = kmeans(X, num_clusters);

% 计算Davies-Bouldin指数
db_score = davies_bouldin_score(X, idx);
disp(['Davies-Bouldin指数: ', num2str(db_score)]);