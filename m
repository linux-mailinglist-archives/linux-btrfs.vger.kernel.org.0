Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE8F17B7D63
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Oct 2023 12:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242163AbjJDKjF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Oct 2023 06:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242200AbjJDKjE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Oct 2023 06:39:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18514A6
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Oct 2023 03:39:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30CF9C433CC
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Oct 2023 10:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696415939;
        bh=KK0k/f0UYxxWCfuuBXQ9MHfd3RhScqt7GzV5w4GLiaw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=SO4xtp9wI97R55hbQCjMBSToBqxrV5EB3nAxIFm73lJeWaLsWGah39gCAisDftuDe
         Nhy+/6+hpOZwQxcpZimAiNI334+jFwVCHFxkyfvMEGvhomhjKwHDqwRIVAXExt0LVc
         uVC6OdVRjXCbZmTtMKAeWjklzkinl3p01FDWNOCCuxAMYnUNVqOKz7/34Lib+O3L7g
         h6zOx3uoR4t0KhNCIjb5fR89ekPNJ4BO0jUFPJ2YLk7rEoXL7BWw/L6VWrMgowMbXG
         565MDRN2gfIf/7yfMj+LXQESF0YybidypfGRqFQDE9s8bkzjCtAPy+9sWaX61YIrRx
         QHQS+9YRf69SA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/6] btrfs: add and use helpers for reading and writing fs_info->generation
Date:   Wed,  4 Oct 2023 11:38:50 +0100
Message-Id: <2d4e16f4c5ad1f0e6274b4f577b0944546b81517.1696415673.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1696415673.git.fdmanana@suse.com>
References: <cover.1696415673.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Currently the generation field of struct btrfs_fs_info is always modified
while holding fs_info->trans_lock locked. Most readers will access this
field without taking that lock but while holding a transaction handle,
which is safe to do due to the transaction life cycle.

However there are other readers that are neither holding the lock nor
holding a transaction handle open:

1) When reading an inode from disk, at btrfs_read_locked_inode();

2) When reading the generation to expose it to sysfs, at
   btrfs_generation_show();

3) Early in the fsync path, at skip_inode_logging();

4) When creating a hole at btrfs_cont_expand(), during write paths,
   truncate and reflinking;

5) In the fs_info ioctl (btrfs_ioctl_fs_info());

6) While mounting the filesystem, in the open_ctree() path. In these
   cases it's safe to directly read fs_info->generation as no one
   can concurrently start a transaction and update fs_info->generation.

In case of the fsync path, races here should be harmless, and in the worst
case they may cause a fsync to log an inode when it's not really needed,
so nothing bad from a functional perspective. In the other cases it's not
so clear if functional problems may arise, though in case 1 rare things
like a load/store tearing [1] may cause the BTRFS_INODE_NEEDS_FULL_SYNC
flag not being set on an inode and therefore result in incorrect logging
later on in case a fsync call is made.

To avoid data race warnings from tools like KCSAN and other issues such
as load and store tearing (amongst others, see [1]), create helpers to
access the generation field of struct btrfs_fs_info using READ_ONCE() and
WRITE_ONCE(), and use these helpers where needed.

[1] https://lwn.net/Articles/793253/

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/file.c        |  2 +-
 fs/btrfs/fs.h          | 16 ++++++++++++++++
 fs/btrfs/inode.c       |  4 ++--
 fs/btrfs/ioctl.c       |  2 +-
 fs/btrfs/sysfs.c       |  2 +-
 fs/btrfs/transaction.c |  2 +-
 6 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 004c53482f05..723f0c70452e 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1749,7 +1749,7 @@ static inline bool skip_inode_logging(const struct btrfs_log_ctx *ctx)
 	struct btrfs_inode *inode = BTRFS_I(ctx->inode);
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 
-	if (btrfs_inode_in_log(inode, fs_info->generation) &&
+	if (btrfs_inode_in_log(inode, btrfs_get_fs_generation(fs_info)) &&
 	    list_empty(&ctx->ordered_extents))
 		return true;
 
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 2bd9bedc7095..d04b729cbdf3 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -416,6 +416,12 @@ struct btrfs_fs_info {
 
 	struct btrfs_block_rsv empty_block_rsv;
 
+	/*
+	 * Updated while holding the lock 'trans_lock'. Due to the life cycle of
+	 * a transaction, it can be directly read while holding a transaction
+	 * handle, everywhere else must be read with btrfs_get_fs_generation().
+	 * Should always be updated using btrfs_set_fs_generation().
+	 */
 	u64 generation;
 	u64 last_trans_committed;
 	/*
@@ -817,6 +823,16 @@ struct btrfs_fs_info {
 #endif
 };
 
+static inline u64 btrfs_get_fs_generation(const struct btrfs_fs_info *fs_info)
+{
+	return READ_ONCE(fs_info->generation);
+}
+
+static inline void btrfs_set_fs_generation(struct btrfs_fs_info *fs_info, u64 gen)
+{
+	WRITE_ONCE(fs_info->generation, gen);
+}
+
 static inline void btrfs_set_last_root_drop_gen(struct btrfs_fs_info *fs_info,
 						u64 gen)
 {
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 3b3aec302c33..c9317c047587 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3800,7 +3800,7 @@ static int btrfs_read_locked_inode(struct inode *inode,
 	 * This is required for both inode re-read from disk and delayed inode
 	 * in delayed_nodes_tree.
 	 */
-	if (BTRFS_I(inode)->last_trans == fs_info->generation)
+	if (BTRFS_I(inode)->last_trans == btrfs_get_fs_generation(fs_info))
 		set_bit(BTRFS_INODE_NEEDS_FULL_SYNC,
 			&BTRFS_I(inode)->runtime_flags);
 
@@ -4923,7 +4923,7 @@ int btrfs_cont_expand(struct btrfs_inode *inode, loff_t oldsize, loff_t size)
 			hole_em->orig_block_len = 0;
 			hole_em->ram_bytes = hole_size;
 			hole_em->compress_type = BTRFS_COMPRESS_NONE;
-			hole_em->generation = fs_info->generation;
+			hole_em->generation = btrfs_get_fs_generation(fs_info);
 
 			err = btrfs_replace_extent_map_range(inode, hole_em, true);
 			free_extent_map(hole_em);
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 848b7e6f6421..7ab21283fae8 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2822,7 +2822,7 @@ static long btrfs_ioctl_fs_info(struct btrfs_fs_info *fs_info,
 	}
 
 	if (flags_in & BTRFS_FS_INFO_FLAG_GENERATION) {
-		fi_args->generation = fs_info->generation;
+		fi_args->generation = btrfs_get_fs_generation(fs_info);
 		fi_args->flags |= BTRFS_FS_INFO_FLAG_GENERATION;
 	}
 
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index e07be193323a..21ab8b9b62ce 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1201,7 +1201,7 @@ static ssize_t btrfs_generation_show(struct kobject *kobj,
 {
 	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
 
-	return sysfs_emit(buf, "%llu\n", fs_info->generation);
+	return sysfs_emit(buf, "%llu\n", btrfs_get_fs_generation(fs_info));
 }
 BTRFS_ATTR(, generation, btrfs_generation_show);
 
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 3aa59cfa4ab0..f5db3a483f40 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -386,7 +386,7 @@ static noinline int join_transaction(struct btrfs_fs_info *fs_info,
 			IO_TREE_TRANS_DIRTY_PAGES);
 	extent_io_tree_init(fs_info, &cur_trans->pinned_extents,
 			IO_TREE_FS_PINNED_EXTENTS);
-	fs_info->generation++;
+	btrfs_set_fs_generation(fs_info, fs_info->generation + 1);
 	cur_trans->transid = fs_info->generation;
 	fs_info->running_transaction = cur_trans;
 	cur_trans->aborted = 0;
-- 
2.40.1

