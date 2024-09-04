function db_score = davies_bouldin_score(X, labels)
    num_clusters = length(unique(labels));
    cluster_centers = zeros(num_clusters, size(X, 2));
    cluster_distances = zeros(num_clusters, 1);
    cluster_indices = cell(num_clusters, 1);

    % 计算每个簇的中心点和样本索引
    for i = 1:num_clusters
        cluster_indices{i} = find(labels == i);
        cluster_centers(i, :) = mean(X(cluster_indices{i}, :));
    end

    % 计算每个簇内的平均距离
    for i = 1:num_clusters
        distances = pdist2(X(cluster_indices{i}, :), cluster_centers(i, :));
        cluster_distances(i) = mean(distances);
    end

    % 计算簇间的分离度
    separation_matrix = pdist2(cluster_centers, cluster_centers);
    separation_matrix(logical(eye(num_clusters))) = inf;
    cluster_separations = min(separation_matrix, [], 2);

    % 计算Davies-Bouldin指数
    db_score = mean(cluster_distances ./ cluster_separations);
end