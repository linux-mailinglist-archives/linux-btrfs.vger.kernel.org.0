Return-Path: <linux-btrfs+bounces-4145-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FB68A1C59
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Apr 2024 19:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B8CF2835B1
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Apr 2024 17:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABDF17A932;
	Thu, 11 Apr 2024 16:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hli1Oxg4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2706317BB2C
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Apr 2024 16:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712852358; cv=none; b=cdATf+vY3DZY+i97QttgO5MwkhJvgTl6IJpVxvTFqZrK/aavdM8ys+F2LHkcF8Su21pETE73PWbPRkJszlFNwNzGFHRE6/9JS9gqJA6lwA3cmMQeD7G65dYiAg3uWCEhiAJ8LctgwoLQF1vU5IFAReGvQnT4T1HeTSZPJIpJ4I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712852358; c=relaxed/simple;
	bh=ElXTtYwr0evUF7MEkZ4QqAbDqJ+GbVZQhjOcpVi3h3A=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q34PNh6I6h/ub1g3gBIO0pF2tKWavQ0/sBDNfS3QPusYtBinNgZZ5YdUKviPKVca91Caz4JyTYpuYqQJgqHmcMn3apnQnh6D27ncAPMWf2/qMyKi/OlGq56JMDCdOu4dTO9hKm8pPzC+1q1Q9PUYOzn/6cV5Fcic54Pi9jtgEws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hli1Oxg4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 191B1C072AA
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Apr 2024 16:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712852357;
	bh=ElXTtYwr0evUF7MEkZ4QqAbDqJ+GbVZQhjOcpVi3h3A=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=hli1Oxg4a0H4ZZTUL9D5CAy/s0g70VddUGC3REtZybdYw0F+7/67hxErw3D0/jitN
	 8mOFZL0LyWuwe62gqGjAsQY67Wm8mG4GjXJafeOtgem9Cf6EUSopKI2m/3yqaBR7OW
	 8DDZ52dhUZzQB96zbKDIAPKOiqgEcZvE3ZSKsSiWlyC/32d3Nzt4wNCChfpCiV/6Ni
	 x+D1Oa9PUcZf3kJarrKiqCYv8Y/4l1HaWUl0gh4otxnwSFGHDyluZmAAITafyukK7H
	 u/hggojpVh0U1vlJY5nQCN6YO7jpOl9SW4BNqhOK2Kgj6/2TBOxVy5TjMHSWzjwWHn
	 Uhn9vj6jIavWA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 02/15] btrfs: tests: error out on unexpected extent map reference count
Date: Thu, 11 Apr 2024 17:18:56 +0100
Message-Id: <a466886977ca166d7ec6b42b5b7d1b497cd9b84a.1712837044.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1712837044.git.fdmanana@suse.com>
References: <cover.1712837044.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

In the extent map self tests, when freeing all extent maps from a test
extent map tree we are not expecting to find any extent map with a
reference count different from 1 (the tree reference). If we find any,
we just log a message but we don't fail the test, which makes it very easy
to miss any bug/regression - no one reads the test messages unless a test
fails. So change the behaviour to make a test fail if we find an extent
map in the tree with a reference count different from 1. Make the failure
happen only after removing all extent maps, so that we don't leak memory.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tests/extent-map-tests.c | 43 +++++++++++++++++++++++++------
 1 file changed, 35 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/tests/extent-map-tests.c b/fs/btrfs/tests/extent-map-tests.c
index 96089c4c38a5..9e9cb591c0f1 100644
--- a/fs/btrfs/tests/extent-map-tests.c
+++ b/fs/btrfs/tests/extent-map-tests.c
@@ -11,10 +11,11 @@
 #include "../disk-io.h"
 #include "../block-group.h"
 
-static void free_extent_map_tree(struct extent_map_tree *em_tree)
+static int free_extent_map_tree(struct extent_map_tree *em_tree)
 {
 	struct extent_map *em;
 	struct rb_node *node;
+	int ret = 0;
 
 	write_lock(&em_tree->lock);
 	while (!RB_EMPTY_ROOT(&em_tree->map.rb_root)) {
@@ -24,6 +25,7 @@ static void free_extent_map_tree(struct extent_map_tree *em_tree)
 
 #ifdef CONFIG_BTRFS_DEBUG
 		if (refcount_read(&em->refs) != 1) {
+			ret = -EINVAL;
 			test_err(
 "em leak: em (start %llu len %llu block_start %llu block_len %llu) refs %d",
 				 em->start, em->len, em->block_start,
@@ -35,6 +37,8 @@ static void free_extent_map_tree(struct extent_map_tree *em_tree)
 		free_extent_map(em);
 	}
 	write_unlock(&em_tree->lock);
+
+	return ret;
 }
 
 /*
@@ -60,6 +64,7 @@ static int test_case_1(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 	u64 start = 0;
 	u64 len = SZ_8K;
 	int ret;
+	int ret2;
 
 	em = alloc_extent_map();
 	if (!em) {
@@ -137,7 +142,9 @@ static int test_case_1(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 	}
 	free_extent_map(em);
 out:
-	free_extent_map_tree(em_tree);
+	ret2 = free_extent_map_tree(em_tree);
+	if (ret == 0)
+		ret = ret2;
 
 	return ret;
 }
@@ -153,6 +160,7 @@ static int test_case_2(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 	struct extent_map_tree *em_tree = &inode->extent_tree;
 	struct extent_map *em;
 	int ret;
+	int ret2;
 
 	em = alloc_extent_map();
 	if (!em) {
@@ -229,7 +237,9 @@ static int test_case_2(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 	}
 	free_extent_map(em);
 out:
-	free_extent_map_tree(em_tree);
+	ret2 = free_extent_map_tree(em_tree);
+	if (ret == 0)
+		ret = ret2;
 
 	return ret;
 }
@@ -241,6 +251,7 @@ static int __test_case_3(struct btrfs_fs_info *fs_info,
 	struct extent_map *em;
 	u64 len = SZ_4K;
 	int ret;
+	int ret2;
 
 	em = alloc_extent_map();
 	if (!em) {
@@ -302,7 +313,9 @@ static int __test_case_3(struct btrfs_fs_info *fs_info,
 	}
 	free_extent_map(em);
 out:
-	free_extent_map_tree(em_tree);
+	ret2 = free_extent_map_tree(em_tree);
+	if (ret == 0)
+		ret = ret2;
 
 	return ret;
 }
@@ -345,6 +358,7 @@ static int __test_case_4(struct btrfs_fs_info *fs_info,
 	struct extent_map *em;
 	u64 len = SZ_4K;
 	int ret;
+	int ret2;
 
 	em = alloc_extent_map();
 	if (!em) {
@@ -421,7 +435,9 @@ static int __test_case_4(struct btrfs_fs_info *fs_info,
 	}
 	free_extent_map(em);
 out:
-	free_extent_map_tree(em_tree);
+	ret2 = free_extent_map_tree(em_tree);
+	if (ret == 0)
+		ret = ret2;
 
 	return ret;
 }
@@ -592,6 +608,7 @@ static int test_case_5(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 {
 	u64 start, end;
 	int ret;
+	int ret2;
 
 	test_msg("Running btrfs_drop_extent_map_range tests");
 
@@ -662,7 +679,10 @@ static int test_case_5(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 	if (ret)
 		goto out;
 out:
-	free_extent_map_tree(&inode->extent_tree);
+	ret2 = free_extent_map_tree(&inode->extent_tree);
+	if (ret == 0)
+		ret = ret2;
+
 	return ret;
 }
 
@@ -676,6 +696,7 @@ static int test_case_6(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 	struct extent_map_tree *em_tree = &inode->extent_tree;
 	struct extent_map *em = NULL;
 	int ret;
+	int ret2;
 
 	ret = add_compressed_extent(inode, 0, SZ_4K, 0);
 	if (ret)
@@ -717,7 +738,10 @@ static int test_case_6(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 	ret = 0;
 out:
 	free_extent_map(em);
-	free_extent_map_tree(em_tree);
+	ret2 = free_extent_map_tree(em_tree);
+	if (ret == 0)
+		ret = ret2;
+
 	return ret;
 }
 
@@ -847,7 +871,10 @@ static int test_case_7(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 	ret2 = unpin_extent_cache(inode, 0, SZ_16K, 0);
 	if (ret == 0)
 		ret = ret2;
-	free_extent_map_tree(em_tree);
+	ret2 = free_extent_map_tree(em_tree);
+	if (ret == 0)
+		ret = ret2;
+
 	return ret;
 }
 
-- 
2.43.0


