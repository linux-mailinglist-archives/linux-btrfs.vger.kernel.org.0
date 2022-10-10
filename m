Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F1A5F9CAB
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Oct 2022 12:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbiJJKWw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Oct 2022 06:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231697AbiJJKWk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Oct 2022 06:22:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50236B8D2
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Oct 2022 03:22:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1DCC760EC9
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Oct 2022 10:22:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1223DC433D6
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Oct 2022 10:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665397352;
        bh=vjRmnwCztk2q7u258H0PxMtfwEjOM3poX9UPco3p+Hg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=RlmglKs6A/CAsTcfOAURujZ8EVoSbd1WueFnOd864gYLJv5nW+hoeOh4MdcklVMNc
         AFf6EYQ70tBzXt0fhNLx3C0vSx5tJG7+EYqTJBfKcElUMEua+2REDiu4fvbkXBFFNv
         h6hyxsXWQ8neQHEf46w0rvdsk3XZJl8sqy4b2gr33D1LrsKU7i0bscVSZi53z4rpGY
         XR6C5mzeGvQo98ZVpdyIUYUkxqIBTpPKlWQLpKAkLhdgBH4JbtuMvte4ZF3cf55LvO
         2EN2xc40r030Do0gP/dy09H3/R7Td5y3IS3CkmBGDzUXZrZPgWWBYuw1ml5WC9FBrb
         3iVGrQ2c7xQ4A==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 10/18] btrfs: directly pass the inode to btrfs_is_data_extent_shared()
Date:   Mon, 10 Oct 2022 11:22:12 +0100
Message-Id: <a026f395f46a1170a91bafa748a20c7e13cc5226.1665396437.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1665396437.git.fdmanana@suse.com>
References: <cover.1665396437.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Currently we pass a root and an inode number as arguments for
btrfs_is_data_extent_shared() and the inode number is always from an
inode that belongs to that root (it wouldn't make sense otherwise).
In every context that we call btrfs_is_data_extent_shared() (fiemap only),
we have an inode available, so directly pass the inode to the function
instead of a root and inode number. This reduces the number of parameters
and it makes the function's signature conform to most other functions we
have.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/backref.c   |  8 ++++----
 fs/btrfs/backref.h   |  2 +-
 fs/btrfs/extent_io.c | 16 +++++++---------
 3 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index bc3345dae381..8effe318cd0c 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -1631,8 +1631,7 @@ static void store_backref_shared_cache(struct btrfs_backref_shared_cache *cache,
 /*
  * Check if a data extent is shared or not.
  *
- * @root:        The root the inode belongs to.
- * @inum:        Number of the inode whose extent we are checking.
+ * @inode:       The inode whose extent we are checking.
  * @bytenr:      Logical bytenr of the extent we are checking.
  * @extent_gen:  Generation of the extent (file extent item) or 0 if it is
  *               not known.
@@ -1651,11 +1650,12 @@ static void store_backref_shared_cache(struct btrfs_backref_shared_cache *cache,
  *
  * Return: 0 if extent is not shared, 1 if it is shared, < 0 on error.
  */
-int btrfs_is_data_extent_shared(struct btrfs_root *root, u64 inum, u64 bytenr,
+int btrfs_is_data_extent_shared(struct btrfs_inode *inode, u64 bytenr,
 				u64 extent_gen,
 				struct ulist *roots, struct ulist *tmp,
 				struct btrfs_backref_shared_cache *cache)
 {
+	struct btrfs_root *root = inode->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_trans_handle *trans;
 	struct ulist_iterator uiter;
@@ -1664,7 +1664,7 @@ int btrfs_is_data_extent_shared(struct btrfs_root *root, u64 inum, u64 bytenr,
 	int ret = 0;
 	struct share_check shared = {
 		.root_objectid = root->root_key.objectid,
-		.inum = inum,
+		.inum = btrfs_ino(inode),
 		.share_count = 0,
 	};
 	int level;
diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index 8e69584d538d..c846fa2bdf93 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -77,7 +77,7 @@ int btrfs_find_one_extref(struct btrfs_root *root, u64 inode_objectid,
 			  u64 start_off, struct btrfs_path *path,
 			  struct btrfs_inode_extref **ret_extref,
 			  u64 *found_off);
-int btrfs_is_data_extent_shared(struct btrfs_root *root, u64 inum, u64 bytenr,
+int btrfs_is_data_extent_shared(struct btrfs_inode *inode, u64 bytenr,
 				u64 extent_gen,
 				struct ulist *roots, struct ulist *tmp,
 				struct btrfs_backref_shared_cache *cache);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index ca67f041e43e..01feeb215bd9 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3715,7 +3715,6 @@ static int fiemap_process_hole(struct btrfs_inode *inode,
 			       u64 start, u64 end)
 {
 	const u64 i_size = i_size_read(&inode->vfs_inode);
-	const u64 ino = btrfs_ino(inode);
 	u64 cur_offset = start;
 	u64 last_delalloc_end = 0;
 	u32 prealloc_flags = FIEMAP_EXTENT_UNWRITTEN;
@@ -3755,8 +3754,8 @@ static int fiemap_process_hole(struct btrfs_inode *inode,
 
 		if (prealloc_len > 0) {
 			if (!checked_extent_shared && fieinfo->fi_extents_max) {
-				ret = btrfs_is_data_extent_shared(inode->root,
-							  ino, disk_bytenr,
+				ret = btrfs_is_data_extent_shared(inode,
+							  disk_bytenr,
 							  extent_gen, roots,
 							  tmp_ulist,
 							  backref_cache);
@@ -3805,8 +3804,8 @@ static int fiemap_process_hole(struct btrfs_inode *inode,
 		}
 
 		if (!checked_extent_shared && fieinfo->fi_extents_max) {
-			ret = btrfs_is_data_extent_shared(inode->root,
-							  ino, disk_bytenr,
+			ret = btrfs_is_data_extent_shared(inode,
+							  disk_bytenr,
 							  extent_gen, roots,
 							  tmp_ulist,
 							  backref_cache);
@@ -3907,7 +3906,6 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 	const u64 ino = btrfs_ino(inode);
 	struct extent_state *cached_state = NULL;
 	struct btrfs_path *path;
-	struct btrfs_root *root = inode->root;
 	struct fiemap_cache cache = { 0 };
 	struct btrfs_backref_shared_cache *backref_cache;
 	struct ulist *roots;
@@ -3928,8 +3926,8 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 		goto out;
 	}
 
-	lockstart = round_down(start, root->fs_info->sectorsize);
-	lockend = round_up(start + len, root->fs_info->sectorsize);
+	lockstart = round_down(start, inode->root->fs_info->sectorsize);
+	lockend = round_up(start + len, inode->root->fs_info->sectorsize);
 	prev_extent_end = lockstart;
 
 	lock_extent(&inode->io_tree, lockstart, lockend, &cached_state);
@@ -4037,7 +4035,7 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 		} else {
 			/* We have a regular extent. */
 			if (fieinfo->fi_extents_max) {
-				ret = btrfs_is_data_extent_shared(root, ino,
+				ret = btrfs_is_data_extent_shared(inode,
 								  disk_bytenr,
 								  extent_gen,
 								  roots,
-- 
2.35.1

