num_clusters = 8;
[idx, centers] = kmeans(X, num_clusters);

% ����Davies-Bouldinָ��
db_score = davies_bouldin_score(X, idx);
disp(['Davies-Bouldinָ��: ', num2str(db_score)]);