Return-Path: <linux-btrfs+bounces-4099-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0154D89F0D9
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Apr 2024 13:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B38E1F220E3
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Apr 2024 11:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3837715CD4B;
	Wed, 10 Apr 2024 11:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oT8eLDad"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6211F15E1E5
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Apr 2024 11:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712748529; cv=none; b=JEWGqy9qPRsmt8EWVcMWtMINeIzmZTWGmKFcW0ozIU2obYBMiMFeVZvq7ew/lhgKiEfBK0NSFGGgFnoBXpzJBDMX24IVHObJcNw3Zy9Kp3pGPPyDPaKsgOE1MLgc1Ulk9DA7g9ifn58l61PcgKxWKysxa/lzVWgM9Cq5Psvvq+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712748529; c=relaxed/simple;
	bh=m8Fty1BCbSqigGihUAVl5sa3UZzEfTB8HUbiUvwNZ74=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c6ICbK9exAqJvuZ5JoQZD3Jvxo58mRdRrWHkOSPZ/J0uPrUY9M5vIrumgIwJlWA8F0t7QKfuhHitq2FxZ+2BPVoD8NJsgJU7kLcyor+MMpGiS2BW34M3xUutTirLsUnzkpTsE/2SHrPgT6X2B5HuRFIQcNK8fIyrE6z3qtm5zWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oT8eLDad; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AE93C433F1
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Apr 2024 11:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712748528;
	bh=m8Fty1BCbSqigGihUAVl5sa3UZzEfTB8HUbiUvwNZ74=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=oT8eLDad7E7Tjq6XanLHcUfrl9yIqkvUkbCZ85wPKCXFYLsPdISY18khi/vCUHAVp
	 IuL0l+0x3jnXEJxgnxVLjpyrtofwP/A3dR/FUpxVG12aKOeizYtAV7im7lvpXFJDn+
	 MoZ9N9hkpPzUbj79+sS5BLsaiyFbCH3Ya7nxXM/kQUMFwLRVaJtoOjHzq57eD5OHsN
	 VfhefZ+uOuDQYgug0gAfocfgxT4rN/QnmUjZnfDFqkGLTJccLw1//Cejp7iXuysWh4
	 +nT98JClYPp0nGgTYQg1VN34Nz+ygBnE3lyegJuK24AYss9MNsmHWCeW+vMtegBZ+V
	 blXfV6DuxOjUg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 01/11] btrfs: pass an inode to btrfs_add_extent_mapping()
Date: Wed, 10 Apr 2024 12:28:33 +0100
Message-Id: <de90932baca0c92338992774b78bc2a2422bebab.1712748143.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1712748143.git.fdmanana@suse.com>
References: <cover.1712748143.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Instead of passing fs_info and extent map tree arguments to
btrfs_add_extent_mapping(), we can pass an inode instead, as extent maps
are always inserted in the extent map tree of an inode, and the fs_info
can be extracted from the inode (inode->root->fs_info). The only exception
is in the self tests where we allocate an extent map tree and then use it
to insert/update/remove extent maps. However the tests can be changed to
use a test inode and then use the inode's extent map tree.

So change btrfs_add_extent_mapping() to have an inode as an argument
instead of a fs_info and an extent map tree. This reduces the number of
parameters and will also be needed for an upcoming change.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_map.c             |  14 +--
 fs/btrfs/extent_map.h             |   3 +-
 fs/btrfs/inode.c                  |   2 +-
 fs/btrfs/tests/extent-map-tests.c | 174 +++++++++++++++---------------
 4 files changed, 95 insertions(+), 98 deletions(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 471654cb65b0..840be23d2c0a 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -546,10 +546,9 @@ static noinline int merge_extent_mapping(struct extent_map_tree *em_tree,
 }
 
 /*
- * Add extent mapping into em_tree.
+ * Add extent mapping into an inode's extent map tree.
  *
- * @fs_info:  the filesystem
- * @em_tree:  extent tree into which we want to insert the extent mapping
+ * @inode:    target inode
  * @em_in:    extent we are inserting
  * @start:    start of the logical range btrfs_get_extent() is requesting
  * @len:      length of the logical range btrfs_get_extent() is requesting
@@ -557,8 +556,8 @@ static noinline int merge_extent_mapping(struct extent_map_tree *em_tree,
  * Note that @em_in's range may be different from [start, start+len),
  * but they must be overlapped.
  *
- * Insert @em_in into @em_tree. In case there is an overlapping range, handle
- * the -EEXIST by either:
+ * Insert @em_in into the inode's extent map tree. In case there is an
+ * overlapping range, handle the -EEXIST by either:
  * a) Returning the existing extent in @em_in if @start is within the
  *    existing em.
  * b) Merge the existing extent with @em_in passed in.
@@ -566,12 +565,13 @@ static noinline int merge_extent_mapping(struct extent_map_tree *em_tree,
  * Return 0 on success, otherwise -EEXIST.
  *
  */
-int btrfs_add_extent_mapping(struct btrfs_fs_info *fs_info,
-			     struct extent_map_tree *em_tree,
+int btrfs_add_extent_mapping(struct btrfs_inode *inode,
 			     struct extent_map **em_in, u64 start, u64 len)
 {
 	int ret;
 	struct extent_map *em = *em_in;
+	struct extent_map_tree *em_tree = &inode->extent_tree;
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 
 	/*
 	 * Tree-checker should have rejected any inline extent with non-zero
diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
index 10e9491865c9..f287ab46e368 100644
--- a/fs/btrfs/extent_map.h
+++ b/fs/btrfs/extent_map.h
@@ -132,8 +132,7 @@ int unpin_extent_cache(struct btrfs_inode *inode, u64 start, u64 len, u64 gen);
 void clear_em_logging(struct extent_map_tree *tree, struct extent_map *em);
 struct extent_map *search_extent_mapping(struct extent_map_tree *tree,
 					 u64 start, u64 len);
-int btrfs_add_extent_mapping(struct btrfs_fs_info *fs_info,
-			     struct extent_map_tree *em_tree,
+int btrfs_add_extent_mapping(struct btrfs_inode *inode,
 			     struct extent_map **em_in, u64 start, u64 len);
 void btrfs_drop_extent_map_range(struct btrfs_inode *inode,
 				 u64 start, u64 end,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 94ac20e62e13..27888810e6ac 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6992,7 +6992,7 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 	}
 
 	write_lock(&em_tree->lock);
-	ret = btrfs_add_extent_mapping(fs_info, em_tree, &em, start, len);
+	ret = btrfs_add_extent_mapping(inode, &em, start, len);
 	write_unlock(&em_tree->lock);
 out:
 	btrfs_free_path(path);
diff --git a/fs/btrfs/tests/extent-map-tests.c b/fs/btrfs/tests/extent-map-tests.c
index 253cce7ffecf..96089c4c38a5 100644
--- a/fs/btrfs/tests/extent-map-tests.c
+++ b/fs/btrfs/tests/extent-map-tests.c
@@ -53,9 +53,9 @@ static void free_extent_map_tree(struct extent_map_tree *em_tree)
  *                                    ->add_extent_mapping(0, 16K)
  *                                    -> #handle -EEXIST
  */
-static int test_case_1(struct btrfs_fs_info *fs_info,
-		struct extent_map_tree *em_tree)
+static int test_case_1(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 {
+	struct extent_map_tree *em_tree = &inode->extent_tree;
 	struct extent_map *em;
 	u64 start = 0;
 	u64 len = SZ_8K;
@@ -73,7 +73,7 @@ static int test_case_1(struct btrfs_fs_info *fs_info,
 	em->block_start = 0;
 	em->block_len = SZ_16K;
 	write_lock(&em_tree->lock);
-	ret = btrfs_add_extent_mapping(fs_info, em_tree, &em, em->start, em->len);
+	ret = btrfs_add_extent_mapping(inode, &em, em->start, em->len);
 	write_unlock(&em_tree->lock);
 	if (ret < 0) {
 		test_err("cannot add extent range [0, 16K)");
@@ -94,7 +94,7 @@ static int test_case_1(struct btrfs_fs_info *fs_info,
 	em->block_start = SZ_32K; /* avoid merging */
 	em->block_len = SZ_4K;
 	write_lock(&em_tree->lock);
-	ret = btrfs_add_extent_mapping(fs_info, em_tree, &em, em->start, em->len);
+	ret = btrfs_add_extent_mapping(inode, &em, em->start, em->len);
 	write_unlock(&em_tree->lock);
 	if (ret < 0) {
 		test_err("cannot add extent range [16K, 20K)");
@@ -115,7 +115,7 @@ static int test_case_1(struct btrfs_fs_info *fs_info,
 	em->block_start = start;
 	em->block_len = len;
 	write_lock(&em_tree->lock);
-	ret = btrfs_add_extent_mapping(fs_info, em_tree, &em, em->start, em->len);
+	ret = btrfs_add_extent_mapping(inode, &em, em->start, em->len);
 	write_unlock(&em_tree->lock);
 	if (ret) {
 		test_err("case1 [%llu %llu]: ret %d", start, start + len, ret);
@@ -148,9 +148,9 @@ static int test_case_1(struct btrfs_fs_info *fs_info,
  * Reading the inline ending up with EEXIST, ie. read an inline
  * extent and discard page cache and read it again.
  */
-static int test_case_2(struct btrfs_fs_info *fs_info,
-		struct extent_map_tree *em_tree)
+static int test_case_2(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 {
+	struct extent_map_tree *em_tree = &inode->extent_tree;
 	struct extent_map *em;
 	int ret;
 
@@ -166,7 +166,7 @@ static int test_case_2(struct btrfs_fs_info *fs_info,
 	em->block_start = EXTENT_MAP_INLINE;
 	em->block_len = (u64)-1;
 	write_lock(&em_tree->lock);
-	ret = btrfs_add_extent_mapping(fs_info, em_tree, &em, em->start, em->len);
+	ret = btrfs_add_extent_mapping(inode, &em, em->start, em->len);
 	write_unlock(&em_tree->lock);
 	if (ret < 0) {
 		test_err("cannot add extent range [0, 1K)");
@@ -187,7 +187,7 @@ static int test_case_2(struct btrfs_fs_info *fs_info,
 	em->block_start = SZ_4K;
 	em->block_len = SZ_4K;
 	write_lock(&em_tree->lock);
-	ret = btrfs_add_extent_mapping(fs_info, em_tree, &em, em->start, em->len);
+	ret = btrfs_add_extent_mapping(inode, &em, em->start, em->len);
 	write_unlock(&em_tree->lock);
 	if (ret < 0) {
 		test_err("cannot add extent range [4K, 8K)");
@@ -208,7 +208,7 @@ static int test_case_2(struct btrfs_fs_info *fs_info,
 	em->block_start = EXTENT_MAP_INLINE;
 	em->block_len = (u64)-1;
 	write_lock(&em_tree->lock);
-	ret = btrfs_add_extent_mapping(fs_info, em_tree, &em, em->start, em->len);
+	ret = btrfs_add_extent_mapping(inode, &em, em->start, em->len);
 	write_unlock(&em_tree->lock);
 	if (ret) {
 		test_err("case2 [0 1K]: ret %d", ret);
@@ -235,8 +235,9 @@ static int test_case_2(struct btrfs_fs_info *fs_info,
 }
 
 static int __test_case_3(struct btrfs_fs_info *fs_info,
-		struct extent_map_tree *em_tree, u64 start)
+			 struct btrfs_inode *inode, u64 start)
 {
+	struct extent_map_tree *em_tree = &inode->extent_tree;
 	struct extent_map *em;
 	u64 len = SZ_4K;
 	int ret;
@@ -253,7 +254,7 @@ static int __test_case_3(struct btrfs_fs_info *fs_info,
 	em->block_start = SZ_4K;
 	em->block_len = SZ_4K;
 	write_lock(&em_tree->lock);
-	ret = btrfs_add_extent_mapping(fs_info, em_tree, &em, em->start, em->len);
+	ret = btrfs_add_extent_mapping(inode, &em, em->start, em->len);
 	write_unlock(&em_tree->lock);
 	if (ret < 0) {
 		test_err("cannot add extent range [4K, 8K)");
@@ -274,7 +275,7 @@ static int __test_case_3(struct btrfs_fs_info *fs_info,
 	em->block_start = 0;
 	em->block_len = SZ_16K;
 	write_lock(&em_tree->lock);
-	ret = btrfs_add_extent_mapping(fs_info, em_tree, &em, start, len);
+	ret = btrfs_add_extent_mapping(inode, &em, start, len);
 	write_unlock(&em_tree->lock);
 	if (ret) {
 		test_err("case3 [%llu %llu): ret %d",
@@ -322,25 +323,25 @@ static int __test_case_3(struct btrfs_fs_info *fs_info,
  *   -> add_extent_mapping()
  *                            -> add_extent_mapping()
  */
-static int test_case_3(struct btrfs_fs_info *fs_info,
-		struct extent_map_tree *em_tree)
+static int test_case_3(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 {
 	int ret;
 
-	ret = __test_case_3(fs_info, em_tree, 0);
+	ret = __test_case_3(fs_info, inode, 0);
 	if (ret)
 		return ret;
-	ret = __test_case_3(fs_info, em_tree, SZ_8K);
+	ret = __test_case_3(fs_info, inode, SZ_8K);
 	if (ret)
 		return ret;
-	ret = __test_case_3(fs_info, em_tree, (12 * SZ_1K));
+	ret = __test_case_3(fs_info, inode, (12 * SZ_1K));
 
 	return ret;
 }
 
 static int __test_case_4(struct btrfs_fs_info *fs_info,
-		struct extent_map_tree *em_tree, u64 start)
+			 struct btrfs_inode *inode, u64 start)
 {
+	struct extent_map_tree *em_tree = &inode->extent_tree;
 	struct extent_map *em;
 	u64 len = SZ_4K;
 	int ret;
@@ -357,7 +358,7 @@ static int __test_case_4(struct btrfs_fs_info *fs_info,
 	em->block_start = 0;
 	em->block_len = SZ_8K;
 	write_lock(&em_tree->lock);
-	ret = btrfs_add_extent_mapping(fs_info, em_tree, &em, em->start, em->len);
+	ret = btrfs_add_extent_mapping(inode, &em, em->start, em->len);
 	write_unlock(&em_tree->lock);
 	if (ret < 0) {
 		test_err("cannot add extent range [0, 8K)");
@@ -378,7 +379,7 @@ static int __test_case_4(struct btrfs_fs_info *fs_info,
 	em->block_start = SZ_16K; /* avoid merging */
 	em->block_len = 24 * SZ_1K;
 	write_lock(&em_tree->lock);
-	ret = btrfs_add_extent_mapping(fs_info, em_tree, &em, em->start, em->len);
+	ret = btrfs_add_extent_mapping(inode, &em, em->start, em->len);
 	write_unlock(&em_tree->lock);
 	if (ret < 0) {
 		test_err("cannot add extent range [8K, 32K)");
@@ -398,7 +399,7 @@ static int __test_case_4(struct btrfs_fs_info *fs_info,
 	em->block_start = 0;
 	em->block_len = SZ_32K;
 	write_lock(&em_tree->lock);
-	ret = btrfs_add_extent_mapping(fs_info, em_tree, &em, start, len);
+	ret = btrfs_add_extent_mapping(inode, &em, start, len);
 	write_unlock(&em_tree->lock);
 	if (ret) {
 		test_err("case4 [%llu %llu): ret %d",
@@ -450,23 +451,22 @@ static int __test_case_4(struct btrfs_fs_info *fs_info,
  *                                             # handle -EEXIST when adding
  *                                             # [0, 32K)
  */
-static int test_case_4(struct btrfs_fs_info *fs_info,
-		struct extent_map_tree *em_tree)
+static int test_case_4(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 {
 	int ret;
 
-	ret = __test_case_4(fs_info, em_tree, 0);
+	ret = __test_case_4(fs_info, inode, 0);
 	if (ret)
 		return ret;
-	ret = __test_case_4(fs_info, em_tree, SZ_4K);
+	ret = __test_case_4(fs_info, inode, SZ_4K);
 
 	return ret;
 }
 
-static int add_compressed_extent(struct btrfs_fs_info *fs_info,
-				 struct extent_map_tree *em_tree,
+static int add_compressed_extent(struct btrfs_inode *inode,
 				 u64 start, u64 len, u64 block_start)
 {
+	struct extent_map_tree *em_tree = &inode->extent_tree;
 	struct extent_map *em;
 	int ret;
 
@@ -482,7 +482,7 @@ static int add_compressed_extent(struct btrfs_fs_info *fs_info,
 	em->block_len = SZ_4K;
 	em->flags |= EXTENT_FLAG_COMPRESS_ZLIB;
 	write_lock(&em_tree->lock);
-	ret = btrfs_add_extent_mapping(fs_info, em_tree, &em, em->start, em->len);
+	ret = btrfs_add_extent_mapping(inode, &em, em->start, em->len);
 	write_unlock(&em_tree->lock);
 	free_extent_map(em);
 	if (ret < 0) {
@@ -588,53 +588,43 @@ static int validate_range(struct extent_map_tree *em_tree, int index)
  * They'll have the EXTENT_FLAG_COMPRESSED flag set to keep the em tree from
  * merging the em's.
  */
-static int test_case_5(struct btrfs_fs_info *fs_info)
+static int test_case_5(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 {
-	struct extent_map_tree *em_tree;
-	struct inode *inode;
 	u64 start, end;
 	int ret;
 
 	test_msg("Running btrfs_drop_extent_map_range tests");
 
-	inode = btrfs_new_test_inode();
-	if (!inode) {
-		test_std_err(TEST_ALLOC_INODE);
-		return -ENOMEM;
-	}
-
-	em_tree = &BTRFS_I(inode)->extent_tree;
-
 	/* [0, 12k) */
-	ret = add_compressed_extent(fs_info, em_tree, 0, SZ_4K * 3, 0);
+	ret = add_compressed_extent(inode, 0, SZ_4K * 3, 0);
 	if (ret) {
 		test_err("cannot add extent range [0, 12K)");
 		goto out;
 	}
 
 	/* [12k, 24k) */
-	ret = add_compressed_extent(fs_info, em_tree, SZ_4K * 3, SZ_4K * 3, SZ_4K);
+	ret = add_compressed_extent(inode, SZ_4K * 3, SZ_4K * 3, SZ_4K);
 	if (ret) {
 		test_err("cannot add extent range [12k, 24k)");
 		goto out;
 	}
 
 	/* [24k, 36k) */
-	ret = add_compressed_extent(fs_info, em_tree, SZ_4K * 6, SZ_4K * 3, SZ_8K);
+	ret = add_compressed_extent(inode, SZ_4K * 6, SZ_4K * 3, SZ_8K);
 	if (ret) {
 		test_err("cannot add extent range [12k, 24k)");
 		goto out;
 	}
 
 	/* [36k, 40k) */
-	ret = add_compressed_extent(fs_info, em_tree, SZ_32K + SZ_4K, SZ_4K, SZ_4K * 3);
+	ret = add_compressed_extent(inode, SZ_32K + SZ_4K, SZ_4K, SZ_4K * 3);
 	if (ret) {
 		test_err("cannot add extent range [12k, 24k)");
 		goto out;
 	}
 
 	/* [40k, 64k) */
-	ret = add_compressed_extent(fs_info, em_tree, SZ_4K * 10, SZ_4K * 6, SZ_16K);
+	ret = add_compressed_extent(inode, SZ_4K * 10, SZ_4K * 6, SZ_16K);
 	if (ret) {
 		test_err("cannot add extent range [12k, 24k)");
 		goto out;
@@ -643,36 +633,36 @@ static int test_case_5(struct btrfs_fs_info *fs_info)
 	/* Drop [8k, 12k) */
 	start = SZ_8K;
 	end = (3 * SZ_4K) - 1;
-	btrfs_drop_extent_map_range(BTRFS_I(inode), start, end, false);
-	ret = validate_range(&BTRFS_I(inode)->extent_tree, 0);
+	btrfs_drop_extent_map_range(inode, start, end, false);
+	ret = validate_range(&inode->extent_tree, 0);
 	if (ret)
 		goto out;
 
 	/* Drop [12k, 20k) */
 	start = SZ_4K * 3;
 	end = SZ_16K + SZ_4K - 1;
-	btrfs_drop_extent_map_range(BTRFS_I(inode), start, end, false);
-	ret = validate_range(&BTRFS_I(inode)->extent_tree, 1);
+	btrfs_drop_extent_map_range(inode, start, end, false);
+	ret = validate_range(&inode->extent_tree, 1);
 	if (ret)
 		goto out;
 
 	/* Drop [28k, 32k) */
 	start = SZ_32K - SZ_4K;
 	end = SZ_32K - 1;
-	btrfs_drop_extent_map_range(BTRFS_I(inode), start, end, false);
-	ret = validate_range(&BTRFS_I(inode)->extent_tree, 2);
+	btrfs_drop_extent_map_range(inode, start, end, false);
+	ret = validate_range(&inode->extent_tree, 2);
 	if (ret)
 		goto out;
 
 	/* Drop [32k, 64k) */
 	start = SZ_32K;
 	end = SZ_64K - 1;
-	btrfs_drop_extent_map_range(BTRFS_I(inode), start, end, false);
-	ret = validate_range(&BTRFS_I(inode)->extent_tree, 3);
+	btrfs_drop_extent_map_range(inode, start, end, false);
+	ret = validate_range(&inode->extent_tree, 3);
 	if (ret)
 		goto out;
 out:
-	iput(inode);
+	free_extent_map_tree(&inode->extent_tree);
 	return ret;
 }
 
@@ -681,23 +671,25 @@ static int test_case_5(struct btrfs_fs_info *fs_info)
  * for areas between two existing ems.  Validate it doesn't do this when there
  * are two unmerged em's side by side.
  */
-static int test_case_6(struct btrfs_fs_info *fs_info, struct extent_map_tree *em_tree)
+static int test_case_6(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 {
+	struct extent_map_tree *em_tree = &inode->extent_tree;
 	struct extent_map *em = NULL;
 	int ret;
 
-	ret = add_compressed_extent(fs_info, em_tree, 0, SZ_4K, 0);
+	ret = add_compressed_extent(inode, 0, SZ_4K, 0);
 	if (ret)
 		goto out;
 
-	ret = add_compressed_extent(fs_info, em_tree, SZ_4K, SZ_4K, 0);
+	ret = add_compressed_extent(inode, SZ_4K, SZ_4K, 0);
 	if (ret)
 		goto out;
 
 	em = alloc_extent_map();
 	if (!em) {
 		test_std_err(TEST_ALLOC_EXTENT_MAP);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto out;
 	}
 
 	em->start = SZ_4K;
@@ -705,7 +697,7 @@ static int test_case_6(struct btrfs_fs_info *fs_info, struct extent_map_tree *em
 	em->block_start = SZ_16K;
 	em->block_len = SZ_16K;
 	write_lock(&em_tree->lock);
-	ret = btrfs_add_extent_mapping(fs_info, em_tree, &em, 0, SZ_8K);
+	ret = btrfs_add_extent_mapping(inode, &em, 0, SZ_8K);
 	write_unlock(&em_tree->lock);
 
 	if (ret != 0) {
@@ -734,28 +726,19 @@ static int test_case_6(struct btrfs_fs_info *fs_info, struct extent_map_tree *em
  * true would mess up the start/end calculations and subsequent splits would be
  * incorrect.
  */
-static int test_case_7(struct btrfs_fs_info *fs_info)
+static int test_case_7(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 {
-	struct extent_map_tree *em_tree;
+	struct extent_map_tree *em_tree = &inode->extent_tree;
 	struct extent_map *em;
-	struct inode *inode;
 	int ret;
+	int ret2;
 
 	test_msg("Running btrfs_drop_extent_cache with pinned");
 
-	inode = btrfs_new_test_inode();
-	if (!inode) {
-		test_std_err(TEST_ALLOC_INODE);
-		return -ENOMEM;
-	}
-
-	em_tree = &BTRFS_I(inode)->extent_tree;
-
 	em = alloc_extent_map();
 	if (!em) {
 		test_std_err(TEST_ALLOC_EXTENT_MAP);
-		ret = -ENOMEM;
-		goto out;
+		return -ENOMEM;
 	}
 
 	/* [0, 16K), pinned */
@@ -765,7 +748,7 @@ static int test_case_7(struct btrfs_fs_info *fs_info)
 	em->block_len = SZ_4K;
 	em->flags |= EXTENT_FLAG_PINNED;
 	write_lock(&em_tree->lock);
-	ret = btrfs_add_extent_mapping(fs_info, em_tree, &em, em->start, em->len);
+	ret = btrfs_add_extent_mapping(inode, &em, em->start, em->len);
 	write_unlock(&em_tree->lock);
 	if (ret < 0) {
 		test_err("couldn't add extent map");
@@ -786,7 +769,7 @@ static int test_case_7(struct btrfs_fs_info *fs_info)
 	em->block_start = SZ_32K;
 	em->block_len = SZ_16K;
 	write_lock(&em_tree->lock);
-	ret = btrfs_add_extent_mapping(fs_info, em_tree, &em, em->start, em->len);
+	ret = btrfs_add_extent_mapping(inode, &em, em->start, em->len);
 	write_unlock(&em_tree->lock);
 	if (ret < 0) {
 		test_err("couldn't add extent map");
@@ -798,7 +781,7 @@ static int test_case_7(struct btrfs_fs_info *fs_info)
 	 * Drop [0, 36K) This should skip the [0, 4K) extent and then split the
 	 * [32K, 48K) extent.
 	 */
-	btrfs_drop_extent_map_range(BTRFS_I(inode), 0, (36 * SZ_1K) - 1, true);
+	btrfs_drop_extent_map_range(inode, 0, (36 * SZ_1K) - 1, true);
 
 	/* Make sure our extent maps look sane. */
 	ret = -EINVAL;
@@ -860,7 +843,11 @@ static int test_case_7(struct btrfs_fs_info *fs_info)
 	ret = 0;
 out:
 	free_extent_map(em);
-	iput(inode);
+	/* Unpin our extent to prevent warning when removing it below. */
+	ret2 = unpin_extent_cache(inode, 0, SZ_16K, 0);
+	if (ret == 0)
+		ret = ret2;
+	free_extent_map_tree(em_tree);
 	return ret;
 }
 
@@ -954,7 +941,8 @@ static int test_rmap_block(struct btrfs_fs_info *fs_info,
 int btrfs_test_extent_map(void)
 {
 	struct btrfs_fs_info *fs_info = NULL;
-	struct extent_map_tree *em_tree;
+	struct inode *inode;
+	struct btrfs_root *root = NULL;
 	int ret = 0, i;
 	struct rmap_test_vector rmap_tests[] = {
 		{
@@ -1003,33 +991,42 @@ int btrfs_test_extent_map(void)
 		return -ENOMEM;
 	}
 
-	em_tree = kzalloc(sizeof(*em_tree), GFP_KERNEL);
-	if (!em_tree) {
+	inode = btrfs_new_test_inode();
+	if (!inode) {
+		test_std_err(TEST_ALLOC_INODE);
 		ret = -ENOMEM;
 		goto out;
 	}
 
-	extent_map_tree_init(em_tree);
+	root = btrfs_alloc_dummy_root(fs_info);
+	if (IS_ERR(root)) {
+		test_std_err(TEST_ALLOC_ROOT);
+		ret = PTR_ERR(root);
+		root = NULL;
+		goto out;
+	}
 
-	ret = test_case_1(fs_info, em_tree);
+	BTRFS_I(inode)->root = root;
+
+	ret = test_case_1(fs_info, BTRFS_I(inode));
 	if (ret)
 		goto out;
-	ret = test_case_2(fs_info, em_tree);
+	ret = test_case_2(fs_info, BTRFS_I(inode));
 	if (ret)
 		goto out;
-	ret = test_case_3(fs_info, em_tree);
+	ret = test_case_3(fs_info, BTRFS_I(inode));
 	if (ret)
 		goto out;
-	ret = test_case_4(fs_info, em_tree);
+	ret = test_case_4(fs_info, BTRFS_I(inode));
 	if (ret)
 		goto out;
-	ret = test_case_5(fs_info);
+	ret = test_case_5(fs_info, BTRFS_I(inode));
 	if (ret)
 		goto out;
-	ret = test_case_6(fs_info, em_tree);
+	ret = test_case_6(fs_info, BTRFS_I(inode));
 	if (ret)
 		goto out;
-	ret = test_case_7(fs_info);
+	ret = test_case_7(fs_info, BTRFS_I(inode));
 	if (ret)
 		goto out;
 
@@ -1041,7 +1038,8 @@ int btrfs_test_extent_map(void)
 	}
 
 out:
-	kfree(em_tree);
+	iput(inode);
+	btrfs_free_dummy_root(root);
 	btrfs_free_dummy_fs_info(fs_info);
 
 	return ret;
-- 
2.43.0


