function feature = norm_feat(feature)
c = max(max(feature));
feature = feature/c;