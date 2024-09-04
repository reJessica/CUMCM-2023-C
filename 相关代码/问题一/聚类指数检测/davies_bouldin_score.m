function db_score = davies_bouldin_score(X, labels)
    num_clusters = length(unique(labels));
    cluster_centers = zeros(num_clusters, size(X, 2));
    cluster_distances = zeros(num_clusters, 1);
    cluster_indices = cell(num_clusters, 1);

    % ����ÿ���ص����ĵ����������
    for i = 1:num_clusters
        cluster_indices{i} = find(labels == i);
        cluster_centers(i, :) = mean(X(cluster_indices{i}, :));
    end

    % ����ÿ�����ڵ�ƽ������
    for i = 1:num_clusters
        distances = pdist2(X(cluster_indices{i}, :), cluster_centers(i, :));
        cluster_distances(i) = mean(distances);
    end

    % ����ؼ�ķ����
    separation_matrix = pdist2(cluster_centers, cluster_centers);
    separation_matrix(logical(eye(num_clusters))) = inf;
    cluster_separations = min(separation_matrix, [], 2);

    % ����Davies-Bouldinָ��
    db_score = mean(cluster_distances ./ cluster_separations);
end