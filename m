Return-Path: <linux-btrfs+bounces-4305-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D74A8A6BDD
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Apr 2024 15:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18338285210
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Apr 2024 13:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA97B12C520;
	Tue, 16 Apr 2024 13:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQo1RdLN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FF312C466
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Apr 2024 13:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713272900; cv=none; b=VIV9b+qkURiRXjb3s2XFIq9s3Y9FA/LO4uKWHhZK82kUzEsx1pZNumUOspUmPk7tVtXmglX+IOODuwXN6lhzMqDoL3rvPLJQWSVw59iuXEuUnBW1VPabrdfMYqxhc0RGWQa3vn9aSVt81oKY6eojcH+ZQWKpiRnMYME4CJ8TvIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713272900; c=relaxed/simple;
	bh=6XW7G0jQgKqKLZTumOVLMYJVfCa/j+SxU7WxYvkBKj8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EI2qiOr/+9aBzewMZBKcHJZTl5ZegpYbYJB0jSrQ2fPzsRsTwLf2iWL9iC9pnUwuFiDWRxmTOoFSxckrVc/Ei41mHTLkti4MQmBEQPiKwpwqYTqbf27FrcRW6e47e/U1G+YwS1facsef3Sg4QwWePxQoDOwvAYUeS3l1YlelER4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQo1RdLN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD95BC32783
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Apr 2024 13:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713272900;
	bh=6XW7G0jQgKqKLZTumOVLMYJVfCa/j+SxU7WxYvkBKj8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=VQo1RdLNvGQ32od0rPs58QxdMMrUSo7j3He5wVsZ/Y1UCeV8hQr6daEF5bx1pZo1m
	 JUCwzqBDkKk8PK3prJwVG2zNAyeLl5KcwF/nI23DxRz0v1+ebkIpXE6gNEbPjxCf9G
	 w4OwnA2Uat/pXL3Qy9ktfHgDl7nZ8JATt/u7PmlvB5NmGUBReglJLpm3SHqMeSx18n
	 qcs1tc2Qzb1qapU9vZapB77Zz9xO3El3/EIcji2djg3eHCG+XaA0W9YycVs4Ni4+zU
	 dqEqyA7Qtocz+tynZ09FnBCSLGzWKKJYL79ywe2eGinAOdP5XlP1buRhukqWUpvptt
	 YKKTmfE0qQEyg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v3 05/10] btrfs: pass the extent map tree's inode to setup_extent_mapping()
Date: Tue, 16 Apr 2024 14:08:07 +0100
Message-Id: <29e0cd5f1077fc214aabb5ba1f404d993a670d4d.1713267925.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1713267925.git.fdmanana@suse.com>
References: <cover.1713267925.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Extent maps are always associated to an inode's extent map tree, so
there's no need to pass the extent map tree explicitly to
setup_extent_mapping().

In order to facilitate an upcoming change that adds a shrinker for extent
maps, change setup_extent_mapping() to receive the inode instead of its
extent map tree.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_map.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 15817b842c24..2753bf2964cb 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -342,7 +342,7 @@ void clear_em_logging(struct btrfs_inode *inode, struct extent_map *em)
 		try_merge_map(tree, em);
 }
 
-static inline void setup_extent_mapping(struct extent_map_tree *tree,
+static inline void setup_extent_mapping(struct btrfs_inode *inode,
 					struct extent_map *em,
 					int modified)
 {
@@ -351,9 +351,9 @@ static inline void setup_extent_mapping(struct extent_map_tree *tree,
 	ASSERT(list_empty(&em->list));
 
 	if (modified)
-		list_add(&em->list, &tree->modified_extents);
+		list_add(&em->list, &inode->extent_tree.modified_extents);
 	else
-		try_merge_map(tree, em);
+		try_merge_map(&inode->extent_tree, em);
 }
 
 /*
@@ -381,7 +381,7 @@ static int add_extent_mapping(struct btrfs_inode *inode,
 	if (ret)
 		return ret;
 
-	setup_extent_mapping(tree, em, modified);
+	setup_extent_mapping(inode, em, modified);
 
 	return 0;
 }
@@ -486,7 +486,7 @@ static void replace_extent_mapping(struct btrfs_inode *inode,
 	rb_replace_node_cached(&cur->rb_node, &new->rb_node, &tree->map);
 	RB_CLEAR_NODE(&cur->rb_node);
 
-	setup_extent_mapping(tree, new, modified);
+	setup_extent_mapping(inode, new, modified);
 }
 
 static struct extent_map *next_extent_map(const struct extent_map *em)
-- 
2.43.0


