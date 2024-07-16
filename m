Return-Path: <linux-btrfs+bounces-6494-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C36BD9323B6
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jul 2024 12:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F762B24142
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jul 2024 10:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1301990D9;
	Tue, 16 Jul 2024 10:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SsMv/0nt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22D81953A8
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Jul 2024 10:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721124877; cv=none; b=CN2roMgAVZQxKUi8VmW1HH0DUcxXyQ53cQj1xuafpi1ExH56W+84vmL6sylwFXtuzcuMKohVeWj6Zu5Q2j/kZUzFKzMTpCwGDPEzTKebXr6qLqXYDAvlQZVgoPViRlnmNKlPDVMcnUsew5bQZdGDtiPHnmT5ieJ9F6UsY5f5MsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721124877; c=relaxed/simple;
	bh=7OUmXhRkbG9fVhEPtVbGe+C7Lunjc7GlB77Sdn7nrSA=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=A/fK3caCU4i0T6LOidCHV1u5HoitRsXK0BP4i+FrxWI9M58VBbO4GsmiXSVbwiFHbOQv1RJS3PKINuZMYTmTPeQkCo0lgiPq0vIythOkSktgFPHQWnA5+GJjAqT2a6ubIk5gE2T+b49yR5Rgpxn1PhYwydR3AevJxlma0d40rug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SsMv/0nt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA85AC116B1
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Jul 2024 10:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721124877;
	bh=7OUmXhRkbG9fVhEPtVbGe+C7Lunjc7GlB77Sdn7nrSA=;
	h=From:To:Subject:Date:From;
	b=SsMv/0ntZmBWkHU6VDSotd8daAG42Tji4T8YKPWZ3w+l/mg76em2PjOM0DsfPs14v
	 X/zlVpRV3Ls3oqFFtJ53vSZvGnY49BB1Hkc7KYelsWF97WjRBpdBFAHiTAXd4fc0e4
	 65TCvMZBCVJeogSzXY9HXaOMFw6zl9df15J4G7QTElq8PyU/86Cl0ar5uKxwT3ayFC
	 ZUWuGzlko5d1GI4MSCicp8n/Rzzs7Uo6HdoqCu4I8vX5R2c6o9neDkbr35U3y0xd4P
	 /pafx+CgPjJc/FQNKOUV0qkuNdu0EkbcVYTX+11Q4pK5HVEpRV7k5D70npmRMCCQXW
	 7bgwdPp9Bgz3g==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix corrupt read due to bad offset of a compressed extent map
Date: Tue, 16 Jul 2024 11:14:33 +0100
Message-Id: <7e186f2d4892bf5bfa1a66dd859a38c981acf8ab.1721124786.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

If we attempt to insert a compressed extent map that has a range that
overlaps another extent map we have in the inode's extent map tree, we
can end up with an incorrect offset after adjusting the new extent map at
merge_extent_mapping() because we don't update the extent map's offset.

For example consider the following scenario:

1) We have a file extent item for a compressed extent covering the file
   range [108K, 144K) and currently there's no corresponding extent map
   in the inode's extent map tree;

2) The inode's size is 141K;

3) We have an encoded write (compressed) into the file range [120K, 128K),
   which overlaps the existing file extent item. The encoded write creates
   a matching extent map, add's it to the inode's extent map tree and
   creates an ordered extent for it.

   Note that the corresponding file extent item is added to the subvolume
   tree only when the ordered extent completes (when executing
   btrfs_finish_one_ordered());

4) We have a write into the file range [160K, 164K[.

   This writes increases the i_size of the file, and there's a hole
   between the current i_size (141K) and the start offset of this write,
   and since the old i_size is in the middle of the block [140K, 144K),
   we have to write zeroes to the range [141K, 144K) (3072 bytes) and
   therefore dirty that page.

   We then call btrfs_set_extent_delalloc() with a start offset of 140K.
   We then end up at btrfs_find_new_delalloc_bytes() which will call
   btrfs_get_extent() for the range [140K, 144K);

5) The btrfs_get_extent() doesn't find any extent map in the inode's
   extent map tree covering the range [140K, 144K), so it searches the
   subvolume tree for any file extent items covering that range.

   There it finds the file extent item for the range [108K, 144K),
   creates a compressed extent map for that range and then calls
   btrfs_add_extent_mapping() with that extent map and passes the
   range [140K, 144K) via the "start" and "len" parameters;

6) The call to add_extent_mapping() done by btrfs_add_extent_mapping()
   fails with -EEXIST because there's an extent map, created at step 2
   for the [120K, 128K) range, that covers that overlaps with the range
   of the given extent map ([108K, 144K)).

   Then it does a lookup for extent map from step 2 add calls
   merge_extent_mapping() to adjust the input extent map ([108K, 144K)).
   That adjust the extent map to a start offset of 128K and a length
   of 16K (starting just after the extent map from step 2), but it does
   not update the offset field of the extent map, leaving it with a value
   of zero instead of updating to a value of 20K (128K - 108K = 20K).

   As a result any read for the range [128K, 144K) can return
   incorrect data since we read from a wrong section of the extent (unless
   both the correct and incorrect ranges happen to have the same data).

So fix this by changing merge_extent_mapping() to update the extent map's
offset even if it's compressed. Also add a test case to the self tests.

A test case for fstests that triggered this problem using send/receive
with compressed writes will be added soon.

Fixes: 3d2ac9922465 ("btrfs: introduce new members for extent_map")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_map.c             |  2 +-
 fs/btrfs/tests/extent-map-tests.c | 99 +++++++++++++++++++++++++++++++
 2 files changed, 100 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index bacb76952fc4..f85f0172b58b 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -664,7 +664,7 @@ static noinline int merge_extent_mapping(struct btrfs_inode *inode,
 	start_diff = start - em->start;
 	em->start = start;
 	em->len = end - start;
-	if (em->disk_bytenr < EXTENT_MAP_LAST_BYTE && !extent_map_is_compressed(em))
+	if (em->disk_bytenr < EXTENT_MAP_LAST_BYTE)
 		em->offset += start_diff;
 	return add_extent_mapping(inode, em, 0);
 }
diff --git a/fs/btrfs/tests/extent-map-tests.c b/fs/btrfs/tests/extent-map-tests.c
index ebec4ab361b8..e4d019c8e8b9 100644
--- a/fs/btrfs/tests/extent-map-tests.c
+++ b/fs/btrfs/tests/extent-map-tests.c
@@ -900,6 +900,102 @@ static int test_case_7(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 	return ret;
 }
 
+/*
+ * Test a regression for compressed extent map adjustment when we attempt to
+ * add an extent map that is partially ovarlapped by another existing extent
+ * map. The resulting extent map offset was left unchanged despite having
+ * incremented its start offset.
+ */
+static int test_case_8(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
+{
+	struct extent_map_tree *em_tree = &inode->extent_tree;
+	struct extent_map *em;
+	int ret;
+	int ret2;
+
+	em = alloc_extent_map();
+	if (!em) {
+		test_std_err(TEST_ALLOC_EXTENT_MAP);
+		return -ENOMEM;
+	}
+
+	/* Compressed extent for the file range [120K, 128K). */
+	em->start = SZ_1K * 120;
+	em->len = SZ_8K;
+	em->disk_num_bytes = SZ_4K;
+	em->ram_bytes = SZ_8K;
+	em->flags |= EXTENT_FLAG_COMPRESS_ZLIB;
+	write_lock(&em_tree->lock);
+	ret = btrfs_add_extent_mapping(inode, &em, em->start, em->len);
+	write_unlock(&em_tree->lock);
+	free_extent_map(em);
+	if (ret < 0) {
+		test_err("couldn't add extent map for range [120K, 128K)");
+		goto out;
+	}
+
+	em = alloc_extent_map();
+	if (!em) {
+		test_std_err(TEST_ALLOC_EXTENT_MAP);
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	/*
+	 * Compressed extent for the file range [108K, 144K), which overlaps
+	 * with the [120K, 128K) we previously inserted.
+	 */
+	em->start = SZ_1K * 108;
+	em->len = SZ_1K * 36;
+	em->disk_num_bytes = SZ_4K;
+	em->ram_bytes = SZ_1K * 36;
+	em->flags |= EXTENT_FLAG_COMPRESS_ZLIB;
+
+	/*
+	 * Try to add the extent map but with a search range of [140K, 144K),
+	 * this should succeed and adjust the extent map to the range
+	 * [128K, 144K), with a length of 16K and an offset of 20K.
+	 *
+	 * This simulates a scenario where in the subvolume tree of an inode we
+	 * have a compressed file extent item for the range [108K, 144K) and we
+	 * have an overlapping compressed extent map for the range [120K, 128K),
+	 * which was created by an encoded write, but its ordered extent was not
+	 * yet completed, so the subvolume tree doesn't have yet the file extent
+	 * item for that range - we only have the extent map in the inode's
+	 * extent map tree.
+	 */
+	write_lock(&em_tree->lock);
+	ret = btrfs_add_extent_mapping(inode, &em, SZ_1K * 140, SZ_4K);
+	write_unlock(&em_tree->lock);
+	free_extent_map(em);
+	if (ret < 0) {
+		test_err("couldn't add extent map for range [108K, 144K)");
+		goto out;
+	}
+
+	if (em->start != SZ_128K) {
+		test_err("unexpected extent map start %llu (should be 128K)", em->start);
+		ret = -EINVAL;
+		goto out;
+	}
+	if (em->len != SZ_16K) {
+		test_err("unexpected extent map length %llu (should be 16K)", em->len);
+		ret = -EINVAL;
+		goto out;
+	}
+	if (em->offset != SZ_1K * 20) {
+		test_err("unexpected extent map offset %llu (should be 20K)", em->offset);
+		ret = -EINVAL;
+		goto out;
+	}
+out:
+	ret2 = free_extent_map_tree(inode);
+	if (ret == 0)
+		ret = ret2;
+
+	return ret;
+}
+
 struct rmap_test_vector {
 	u64 raid_type;
 	u64 physical_start;
@@ -1076,6 +1172,9 @@ int btrfs_test_extent_map(void)
 	if (ret)
 		goto out;
 	ret = test_case_7(fs_info, BTRFS_I(inode));
+	if (ret)
+		goto out;
+	ret = test_case_8(fs_info, BTRFS_I(inode));
 	if (ret)
 		goto out;
 
-- 
2.43.0


