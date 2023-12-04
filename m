Return-Path: <linux-btrfs+bounces-581-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2099803A0C
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Dec 2023 17:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F18D1C20975
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Dec 2023 16:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105392E82F;
	Mon,  4 Dec 2023 16:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Za2cKmQj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8622E823
	for <linux-btrfs@vger.kernel.org>; Mon,  4 Dec 2023 16:20:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7090C433C8
	for <linux-btrfs@vger.kernel.org>; Mon,  4 Dec 2023 16:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701706844;
	bh=Pj8EKQvBsiwwpEf+X2qJqI4htrsXG7HNK+52N83HWxk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Za2cKmQj/VTf9LyjrKEjD0g0WRi1ZVeo0ETpQTjOca3SPZxz4Xfz4kV7q1zHUtGKw
	 mOr8+I+Ve51n747C1bMulmFB2yUnLiaj0x2OGm5/4LDOpUnfUrZPgkllJv/FVqHWDC
	 K35Pj2s1u66jxd6hRfrSNVMJzwe98p4N/t4j2Ea0CDaLZLax/E8em84hOJ/ZSFizQn
	 zwqIu1yLsZTtdXtiO7c2QZPX5kycT0s7J3pqIMq8hoUR6hehETtqaXnCWZjZS2Q9lS
	 x8958IjXpeWvOUgi/3SRBlc8o4ErkfPVclB05UCEiGJ3TCfDktoROa3X3IVI2MT4TW
	 q2Xs7g1kv/fPQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 07/11] btrfs: log messages at unpin_extent_range() during unexpected cases
Date: Mon,  4 Dec 2023 16:20:29 +0000
Message-Id: <f987c309f96b544baa731aa09f423dd9691a15dd.1701706418.git.fdmanana@suse.com>
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

At unpin_extent_range() we trigger a WARN_ON() when we don't find an
extent map or we find one with a start offset not matching the start
offset of the target range. This however isn't very useful for debugging
because:

1) We don't know which condition was triggered, as they are both in the
   same WARN_ON() call;

2) We don't know which inode was affected, from which root, for which
   range, what's the start offset of the extent map, and so on.

So trigger a separate warning for each case and log a message for each
case providing information about the inode, its root, the target range,
the generation and the start offset of the extent map we found.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_map.c | 22 ++++++++++++++++------
 fs/btrfs/extent_map.h |  2 +-
 fs/btrfs/inode.c      |  2 +-
 3 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index a3d69c943eec..48230a1179b0 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -280,7 +280,7 @@ static void try_merge_map(struct extent_map_tree *tree, struct extent_map *em)
 /*
  * Unpin an extent from the cache.
  *
- * @tree:	tree to unpin the extent in
+ * @inode:	the inode from which we are unpinning an extent range
  * @start:	logical offset in the file
  * @len:	length of the extent
  * @gen:	generation that this extent has been modified in
@@ -289,9 +289,10 @@ static void try_merge_map(struct extent_map_tree *tree, struct extent_map *em)
  * to the generation that actually added the file item to the inode so we know
  * we need to sync this extent when we call fsync().
  */
-int unpin_extent_cache(struct extent_map_tree *tree, u64 start, u64 len,
-		       u64 gen)
+int unpin_extent_cache(struct btrfs_inode *inode, u64 start, u64 len, u64 gen)
 {
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+	struct extent_map_tree *tree = &inode->extent_tree;
 	int ret = 0;
 	struct extent_map *em;
 	bool prealloc = false;
@@ -299,10 +300,19 @@ int unpin_extent_cache(struct extent_map_tree *tree, u64 start, u64 len,
 	write_lock(&tree->lock);
 	em = lookup_extent_mapping(tree, start, len);
 
-	WARN_ON(!em || em->start != start);
-
-	if (!em)
+	if (WARN_ON(!em)) {
+		btrfs_warn(fs_info,
+"no extent map found for inode %llu (root %lld) when unpinning extent range [%llu, %llu), generation %llu",
+			   btrfs_ino(inode), btrfs_root_id(inode->root),
+			   start, len, gen);
 		goto out;
+	}
+
+	if (WARN_ON(em->start != start))
+		btrfs_warn(fs_info,
+"found extent map for inode %llu (root %lld) with unexpected start offset %llu when unpinning extent range [%llu, %llu), generation %llu",
+			   btrfs_ino(inode), btrfs_root_id(inode->root),
+			   em->start, start, len, gen);
 
 	em->generation = gen;
 	clear_bit(EXTENT_FLAG_PINNED, &em->flags);
diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
index 5663137471fe..cd1a9115908d 100644
--- a/fs/btrfs/extent_map.h
+++ b/fs/btrfs/extent_map.h
@@ -82,7 +82,7 @@ struct extent_map *alloc_extent_map(void);
 void free_extent_map(struct extent_map *em);
 int __init extent_map_init(void);
 void __cold extent_map_exit(void);
-int unpin_extent_cache(struct extent_map_tree *tree, u64 start, u64 len, u64 gen);
+int unpin_extent_cache(struct btrfs_inode *inode, u64 start, u64 len, u64 gen);
 void clear_em_logging(struct extent_map_tree *tree, struct extent_map *em);
 struct extent_map *search_extent_mapping(struct extent_map_tree *tree,
 					 u64 start, u64 len);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index f8647d8271b7..f7f48c2f0276 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3127,7 +3127,7 @@ int btrfs_finish_one_ordered(struct btrfs_ordered_extent *ordered_extent)
 						ordered_extent->disk_num_bytes);
 		}
 	}
-	unpin_extent_cache(&inode->extent_tree, ordered_extent->file_offset,
+	unpin_extent_cache(inode, ordered_extent->file_offset,
 			   ordered_extent->num_bytes, trans->transid);
 	if (ret < 0) {
 		btrfs_abort_transaction(trans, ret);
-- 
2.40.1


