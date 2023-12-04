Return-Path: <linux-btrfs+bounces-579-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D070B803A0A
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Dec 2023 17:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 859B2280F29
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Dec 2023 16:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DB62E655;
	Mon,  4 Dec 2023 16:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NO6NYRaN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F3C2E401
	for <linux-btrfs@vger.kernel.org>; Mon,  4 Dec 2023 16:20:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06648C433C9
	for <linux-btrfs@vger.kernel.org>; Mon,  4 Dec 2023 16:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701706842;
	bh=6DXjGziwWnFWUoj5MIrAuHwUila4TUVEdjHuZDuuG40=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=NO6NYRaN+bTtxWVJMxuSZ/dbGPVkuwgDupWnImrbr6JshR1wGEMeaeZaAeEtUXwkG
	 vJ5HTAe3kJW3IS4LpdnJExVKwDEF4/qS0OP9G/HcwoLGXIvV1K2Rod58pir9JxqgZ2
	 CEt+yGqNiGD2S3cXVe6No/hTJNxlq/3+9hxcl7OE4Xo2aDe4mZzMoIBJokSRKzA9ds
	 98Uo6HzlKu7te0POhi5Ky4htl+A1ggAtbSRuyq3x2S53DtZqhZLPHO79UZJLntmu8c
	 GvivBDNihEDGpj7E7MUntsJLKHmIruznFYYGyCjfnzbQr09l7kbOklRUmmZ6J/BEDZ
	 b5JTvDzPMZJJw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 05/11] btrfs: unexport add_extent_mapping()
Date: Mon,  4 Dec 2023 16:20:27 +0000
Message-Id: <11ec6ed422f75bb0fb43f6e73ff53959769efe30.1701706418.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1701706418.git.fdmanana@suse.com>
References: <cover.1701706418.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There's no need to export add_extent_mapping(), as it's only used inside
extent_map.c and in the self tests. For the tests we can use instead
btrfs_add_extent_mapping(), which will accomplish exactly the same as we
don't expect collisions in any of them. So unexport it and make the tests
use btrfs_add_extent_mapping() instead of add_extent_mapping().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_map.c             |  4 +--
 fs/btrfs/extent_map.h             |  2 --
 fs/btrfs/tests/extent-map-tests.c | 45 ++++++++++++++++---------------
 3 files changed, 25 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index d29097a8550a..18a5c4332ed6 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -366,8 +366,8 @@ static inline void setup_extent_mapping(struct extent_map_tree *tree,
  * into the tree directly, with an additional reference taken, or a
  * reference dropped if the merge attempt was successful.
  */
-int add_extent_mapping(struct extent_map_tree *tree,
-		       struct extent_map *em, int modified)
+static int add_extent_mapping(struct extent_map_tree *tree,
+			      struct extent_map *em, int modified)
 {
 	int ret = 0;
 
diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
index 66f8dd26487b..5663137471fe 100644
--- a/fs/btrfs/extent_map.h
+++ b/fs/btrfs/extent_map.h
@@ -74,8 +74,6 @@ static inline u64 extent_map_end(struct extent_map *em)
 void extent_map_tree_init(struct extent_map_tree *tree);
 struct extent_map *lookup_extent_mapping(struct extent_map_tree *tree,
 					 u64 start, u64 len);
-int add_extent_mapping(struct extent_map_tree *tree,
-		       struct extent_map *em, int modified);
 void remove_extent_mapping(struct extent_map_tree *tree, struct extent_map *em);
 int split_extent_map(struct btrfs_inode *inode, u64 start, u64 len, u64 pre,
 		     u64 new_logical);
diff --git a/fs/btrfs/tests/extent-map-tests.c b/fs/btrfs/tests/extent-map-tests.c
index 1eb442ea89a5..59bbf714225c 100644
--- a/fs/btrfs/tests/extent-map-tests.c
+++ b/fs/btrfs/tests/extent-map-tests.c
@@ -73,7 +73,7 @@ static int test_case_1(struct btrfs_fs_info *fs_info,
 	em->block_start = 0;
 	em->block_len = SZ_16K;
 	write_lock(&em_tree->lock);
-	ret = add_extent_mapping(em_tree, em, 0);
+	ret = btrfs_add_extent_mapping(fs_info, em_tree, &em, em->start, em->len);
 	write_unlock(&em_tree->lock);
 	if (ret < 0) {
 		test_err("cannot add extent range [0, 16K)");
@@ -94,7 +94,7 @@ static int test_case_1(struct btrfs_fs_info *fs_info,
 	em->block_start = SZ_32K; /* avoid merging */
 	em->block_len = SZ_4K;
 	write_lock(&em_tree->lock);
-	ret = add_extent_mapping(em_tree, em, 0);
+	ret = btrfs_add_extent_mapping(fs_info, em_tree, &em, em->start, em->len);
 	write_unlock(&em_tree->lock);
 	if (ret < 0) {
 		test_err("cannot add extent range [16K, 20K)");
@@ -166,7 +166,7 @@ static int test_case_2(struct btrfs_fs_info *fs_info,
 	em->block_start = EXTENT_MAP_INLINE;
 	em->block_len = (u64)-1;
 	write_lock(&em_tree->lock);
-	ret = add_extent_mapping(em_tree, em, 0);
+	ret = btrfs_add_extent_mapping(fs_info, em_tree, &em, em->start, em->len);
 	write_unlock(&em_tree->lock);
 	if (ret < 0) {
 		test_err("cannot add extent range [0, 1K)");
@@ -187,7 +187,7 @@ static int test_case_2(struct btrfs_fs_info *fs_info,
 	em->block_start = SZ_4K;
 	em->block_len = SZ_4K;
 	write_lock(&em_tree->lock);
-	ret = add_extent_mapping(em_tree, em, 0);
+	ret = btrfs_add_extent_mapping(fs_info, em_tree, &em, em->start, em->len);
 	write_unlock(&em_tree->lock);
 	if (ret < 0) {
 		test_err("cannot add extent range [4K, 8K)");
@@ -253,7 +253,7 @@ static int __test_case_3(struct btrfs_fs_info *fs_info,
 	em->block_start = SZ_4K;
 	em->block_len = SZ_4K;
 	write_lock(&em_tree->lock);
-	ret = add_extent_mapping(em_tree, em, 0);
+	ret = btrfs_add_extent_mapping(fs_info, em_tree, &em, em->start, em->len);
 	write_unlock(&em_tree->lock);
 	if (ret < 0) {
 		test_err("cannot add extent range [4K, 8K)");
@@ -357,7 +357,7 @@ static int __test_case_4(struct btrfs_fs_info *fs_info,
 	em->block_start = 0;
 	em->block_len = SZ_8K;
 	write_lock(&em_tree->lock);
-	ret = add_extent_mapping(em_tree, em, 0);
+	ret = btrfs_add_extent_mapping(fs_info, em_tree, &em, em->start, em->len);
 	write_unlock(&em_tree->lock);
 	if (ret < 0) {
 		test_err("cannot add extent range [0, 8K)");
@@ -378,7 +378,7 @@ static int __test_case_4(struct btrfs_fs_info *fs_info,
 	em->block_start = SZ_16K; /* avoid merging */
 	em->block_len = 24 * SZ_1K;
 	write_lock(&em_tree->lock);
-	ret = add_extent_mapping(em_tree, em, 0);
+	ret = btrfs_add_extent_mapping(fs_info, em_tree, &em, em->start, em->len);
 	write_unlock(&em_tree->lock);
 	if (ret < 0) {
 		test_err("cannot add extent range [8K, 32K)");
@@ -463,7 +463,8 @@ static int test_case_4(struct btrfs_fs_info *fs_info,
 	return ret;
 }
 
-static int add_compressed_extent(struct extent_map_tree *em_tree,
+static int add_compressed_extent(struct btrfs_fs_info *fs_info,
+				 struct extent_map_tree *em_tree,
 				 u64 start, u64 len, u64 block_start)
 {
 	struct extent_map *em;
@@ -481,7 +482,7 @@ static int add_compressed_extent(struct extent_map_tree *em_tree,
 	em->block_len = SZ_4K;
 	set_bit(EXTENT_FLAG_COMPRESSED, &em->flags);
 	write_lock(&em_tree->lock);
-	ret = add_extent_mapping(em_tree, em, 0);
+	ret = btrfs_add_extent_mapping(fs_info, em_tree, &em, em->start, em->len);
 	write_unlock(&em_tree->lock);
 	free_extent_map(em);
 	if (ret < 0) {
@@ -587,7 +588,7 @@ static int validate_range(struct extent_map_tree *em_tree, int index)
  * They'll have the EXTENT_FLAG_COMPRESSED flag set to keep the em tree from
  * merging the em's.
  */
-static int test_case_5(void)
+static int test_case_5(struct btrfs_fs_info *fs_info)
 {
 	struct extent_map_tree *em_tree;
 	struct inode *inode;
@@ -605,35 +606,35 @@ static int test_case_5(void)
 	em_tree = &BTRFS_I(inode)->extent_tree;
 
 	/* [0, 12k) */
-	ret = add_compressed_extent(em_tree, 0, SZ_4K * 3, 0);
+	ret = add_compressed_extent(fs_info, em_tree, 0, SZ_4K * 3, 0);
 	if (ret) {
 		test_err("cannot add extent range [0, 12K)");
 		goto out;
 	}
 
 	/* [12k, 24k) */
-	ret = add_compressed_extent(em_tree, SZ_4K * 3, SZ_4K * 3, SZ_4K);
+	ret = add_compressed_extent(fs_info, em_tree, SZ_4K * 3, SZ_4K * 3, SZ_4K);
 	if (ret) {
 		test_err("cannot add extent range [12k, 24k)");
 		goto out;
 	}
 
 	/* [24k, 36k) */
-	ret = add_compressed_extent(em_tree, SZ_4K * 6, SZ_4K * 3, SZ_8K);
+	ret = add_compressed_extent(fs_info, em_tree, SZ_4K * 6, SZ_4K * 3, SZ_8K);
 	if (ret) {
 		test_err("cannot add extent range [12k, 24k)");
 		goto out;
 	}
 
 	/* [36k, 40k) */
-	ret = add_compressed_extent(em_tree, SZ_32K + SZ_4K, SZ_4K, SZ_4K * 3);
+	ret = add_compressed_extent(fs_info, em_tree, SZ_32K + SZ_4K, SZ_4K, SZ_4K * 3);
 	if (ret) {
 		test_err("cannot add extent range [12k, 24k)");
 		goto out;
 	}
 
 	/* [40k, 64k) */
-	ret = add_compressed_extent(em_tree, SZ_4K * 10, SZ_4K * 6, SZ_16K);
+	ret = add_compressed_extent(fs_info, em_tree, SZ_4K * 10, SZ_4K * 6, SZ_16K);
 	if (ret) {
 		test_err("cannot add extent range [12k, 24k)");
 		goto out;
@@ -685,11 +686,11 @@ static int test_case_6(struct btrfs_fs_info *fs_info, struct extent_map_tree *em
 	struct extent_map *em = NULL;
 	int ret;
 
-	ret = add_compressed_extent(em_tree, 0, SZ_4K, 0);
+	ret = add_compressed_extent(fs_info, em_tree, 0, SZ_4K, 0);
 	if (ret)
 		goto out;
 
-	ret = add_compressed_extent(em_tree, SZ_4K, SZ_4K, 0);
+	ret = add_compressed_extent(fs_info, em_tree, SZ_4K, SZ_4K, 0);
 	if (ret)
 		goto out;
 
@@ -733,7 +734,7 @@ static int test_case_6(struct btrfs_fs_info *fs_info, struct extent_map_tree *em
  * true would mess up the start/end calculations and subsequent splits would be
  * incorrect.
  */
-static int test_case_7(void)
+static int test_case_7(struct btrfs_fs_info *fs_info)
 {
 	struct extent_map_tree *em_tree;
 	struct extent_map *em;
@@ -764,7 +765,7 @@ static int test_case_7(void)
 	em->block_len = SZ_4K;
 	set_bit(EXTENT_FLAG_PINNED, &em->flags);
 	write_lock(&em_tree->lock);
-	ret = add_extent_mapping(em_tree, em, 0);
+	ret = btrfs_add_extent_mapping(fs_info, em_tree, &em, em->start, em->len);
 	write_unlock(&em_tree->lock);
 	if (ret < 0) {
 		test_err("couldn't add extent map");
@@ -785,7 +786,7 @@ static int test_case_7(void)
 	em->block_start = SZ_32K;
 	em->block_len = SZ_16K;
 	write_lock(&em_tree->lock);
-	ret = add_extent_mapping(em_tree, em, 0);
+	ret = btrfs_add_extent_mapping(fs_info, em_tree, &em, em->start, em->len);
 	write_unlock(&em_tree->lock);
 	if (ret < 0) {
 		test_err("couldn't add extent map");
@@ -1022,13 +1023,13 @@ int btrfs_test_extent_map(void)
 	ret = test_case_4(fs_info, em_tree);
 	if (ret)
 		goto out;
-	ret = test_case_5();
+	ret = test_case_5(fs_info);
 	if (ret)
 		goto out;
 	ret = test_case_6(fs_info, em_tree);
 	if (ret)
 		goto out;
-	ret = test_case_7();
+	ret = test_case_7(fs_info);
 	if (ret)
 		goto out;
 
-- 
2.40.1


