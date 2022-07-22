Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B29C657DB3F
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Jul 2022 09:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234505AbiGVH06 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Jul 2022 03:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbiGVH04 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Jul 2022 03:26:56 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89A393C39
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Jul 2022 00:26:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7F4B91F939
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Jul 2022 07:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1658474813; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=wqoSytCR8uIQYhqrHYcyGe6MlWjf8RMdOYFsGcQa7K0=;
        b=XPA8Ju/DMizS8I5k5P/K98GcLFmv81YAMHPcTbIwwXxBOJsjMPAM0dnDkPeCfrEy+BtzSn
        g9TTwY59uy80IontFSemKrKWAvetolVKbLj/iR84ZiZbEYO/VhkReT8erIQ21HoqDwLE+r
        iERbjHPFKeeKYRWNCHXdC16vyHmI3V8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C5278134A9
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Jul 2022 07:26:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id N6JmIjxR2mI8LgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Jul 2022 07:26:52 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: cleanup the error handling labels for open_ctree()
Date:   Fri, 22 Jul 2022 15:26:34 +0800
Message-Id: <4836d9630867bd65390ce92fc9242df9e3af0faa.1658474716.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It's a disaster in open_ctree() for its error handling, it has TEN
labels, and under a lot of cases, those labels don't help much to
understand the correct timing to call them.

Furthermore, there are a lof of cleanup functions can be called with
internal NULL pointer checks, thus there is not much need to use so many
labels.

This patch will reduce the number of error handling labels from 10 to 2:

- fail:
  Before successful btrfs_sysfs_add_mounted() call

- fail_sysfs:
  After successful btrfs_sysfs_add_mounted() call

Then the complete lists of manual inspection on the functions called in
old labels:

- btrfs_free_qgroup_config()
  Freeing rbtree entries in fs_info->qgroup_tree, initialized by
  btrfs_init_fs_info(), thus safer to call at anytime.

- kthread_stop() for transaction_kthread and cleaner_kthread
  Just add extra NULL pointer checks before calling kthread_stop().

- btrfs_cleanup_transaction()
  It cleans up entries in:
  * fs_info->trans_list list
  * fs_info->ordered_roots list
  * fs_info->delayed_root structure
  * fs_info->delalloc_roots list
  * fs_info->fs_roots_radix radix tree
  Those members are all initialized in btrfs_init_fs_info() (except
  delalloc_roots which is initialized in init_mount_fs_info()), and
  eventually will be freed by btrfs_free_fs_info().
  Thus they are all safe to call at any timing of error path.

- btrfs_free_fs_roots()
  It cleans up fs_info->dead_roots list and fs_roots_radix tree,
  both are already properly initialized in btrfs_init_fs_info(), thus
  safe to call at any timing of error path.

- fiemap_write_and_wait() for btree_inode
  This must be called after we have initialized btree_inode, although at
  the timing at btrfs_sysfs_add_mounted() we should already have a valid
  btree_inode. Just add an ASSERT() in case.

- btrfs_sysfs_remove_mounted()
  This requires a successful call on btrfs_sysfs_add_mounted()

- btrfs_sysfs_remove_fsid()
  It has extra NULL pointer check on
  fs_devices->devinfo_kobj/devices_kobj. Thus can be called at any
  timing of error path.

- btrfs_put_block_group_cache()
  It cleans up the block group cache in fs_info->block_group_cache_tree,
  which is initialized in btrfs_init_fs_info() already.
  Thus can be called at any timing of error path.

- btrfs_drop_and_free_fs_root() on data_reloc_root
  It already has a NULL pointer check.

- free_root_pointers()
  It calls free_root_extent_buffers() on each root, which has NULL
  pointer check on the passed root.

  Furthermore, in free_root_extent_buffers() it calls
  free_extent_buffer() which also has NULL pointer check on the extent
  buffer.
  Thus it's completely safe to call on half-initialized root or NULL
  root.

- btrfs_stop_all_workers()
  It calls btrfs_destroy_workqueue() on btrfs workqueues, which already
  has NULL pointer check.
  For regular workqueues, it has manual NULL pointer check.

- btrfs_mapping_tree_free()
  It cleans up the extent mapping in fs_info->mapping_tree, which can
  handle empty rb tree all by itself.

- btrfs_close_devices()
  It's called for all error path anyway.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 88 +++++++++++++++++++++++-----------------------
 1 file changed, 44 insertions(+), 44 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 3fac429cf8a4..e310bad688a2 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3415,7 +3415,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	disk_super = btrfs_read_dev_super(fs_devices->latest_dev->bdev);
 	if (IS_ERR(disk_super)) {
 		err = PTR_ERR(disk_super);
-		goto fail_alloc;
+		goto fail;
 	}
 
 	/*
@@ -3428,7 +3428,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 			  csum_type);
 		err = -EINVAL;
 		btrfs_release_disk_super(disk_super);
-		goto fail_alloc;
+		goto fail;
 	}
 
 	fs_info->csum_size = btrfs_super_csum_size(disk_super);
@@ -3437,7 +3437,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	if (ret) {
 		err = ret;
 		btrfs_release_disk_super(disk_super);
-		goto fail_alloc;
+		goto fail;
 	}
 
 	/*
@@ -3448,7 +3448,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 		btrfs_err(fs_info, "superblock checksum mismatch");
 		err = -EINVAL;
 		btrfs_release_disk_super(disk_super);
-		goto fail_alloc;
+		goto fail;
 	}
 
 	/*
@@ -3477,11 +3477,11 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	if (ret) {
 		btrfs_err(fs_info, "superblock contains fatal errors");
 		err = -EINVAL;
-		goto fail_alloc;
+		goto fail;
 	}
 
 	if (!btrfs_super_root(disk_super))
-		goto fail_alloc;
+		goto fail;
 
 	/* check FS state, whether FS is broken. */
 	if (btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_ERROR)
@@ -3510,7 +3510,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	ret = btrfs_parse_options(fs_info, options, sb->s_flags);
 	if (ret) {
 		err = ret;
-		goto fail_alloc;
+		goto fail;
 	}
 
 	features = btrfs_super_incompat_flags(disk_super) &
@@ -3520,7 +3520,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 		    "cannot mount because of unsupported optional features (0x%llx)",
 		    features);
 		err = -EINVAL;
-		goto fail_alloc;
+		goto fail;
 	}
 
 	features = btrfs_super_incompat_flags(disk_super);
@@ -3546,7 +3546,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 		btrfs_err(fs_info,
 "unequal nodesize/sectorsize (%u != %u) are not allowed for mixed block groups",
 			nodesize, sectorsize);
-		goto fail_alloc;
+		goto fail;
 	}
 
 	/*
@@ -3562,7 +3562,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	"cannot mount read-write because of unsupported optional features (0x%llx)",
 		       features);
 		err = -EINVAL;
-		goto fail_alloc;
+		goto fail;
 	}
 	/*
 	 * We have unsupported RO compat features, although RO mounted, we
@@ -3575,7 +3575,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 "cannot replay dirty log with unsupported compat_ro features (0x%llx), try rescue=nologreplay",
 			  features);
 		err = -EINVAL;
-		goto fail_alloc;
+		goto fail;
 	}
 
 
@@ -3598,7 +3598,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 			   sectorsize, PAGE_SIZE);
 		subpage_info = kzalloc(sizeof(*subpage_info), GFP_KERNEL);
 		if (!subpage_info)
-			goto fail_alloc;
+			goto fail;
 		btrfs_init_subpage_info(subpage_info, sectorsize);
 		fs_info->subpage_info = subpage_info;
 	}
@@ -3606,7 +3606,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	ret = btrfs_init_workqueues(fs_info);
 	if (ret) {
 		err = ret;
-		goto fail_sb_buffer;
+		goto fail;
 	}
 
 	sb->s_bdi->ra_pages *= btrfs_super_num_devices(disk_super);
@@ -3621,7 +3621,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	mutex_unlock(&fs_info->chunk_mutex);
 	if (ret) {
 		btrfs_err(fs_info, "failed to read the system array: %d", ret);
-		goto fail_sb_buffer;
+		goto fail;
 	}
 
 	generation = btrfs_super_chunk_root_generation(disk_super);
@@ -3630,7 +3630,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 			      generation, level);
 	if (ret) {
 		btrfs_err(fs_info, "failed to read chunk root");
-		goto fail_tree_roots;
+		goto fail;
 	}
 
 	read_extent_buffer(chunk_root->node, fs_info->chunk_tree_uuid,
@@ -3640,7 +3640,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	ret = btrfs_read_chunk_tree(fs_info);
 	if (ret) {
 		btrfs_err(fs_info, "failed to read chunk tree: %d", ret);
-		goto fail_tree_roots;
+		goto fail;
 	}
 
 	/*
@@ -3653,12 +3653,12 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	btrfs_free_extra_devids(fs_devices);
 	if (!fs_devices->latest_dev->bdev) {
 		btrfs_err(fs_info, "failed to read devices");
-		goto fail_tree_roots;
+		goto fail;
 	}
 
 	ret = init_tree_roots(fs_info);
 	if (ret)
-		goto fail_tree_roots;
+		goto fail;
 
 	/*
 	 * Get zone type information of zoned block devices. This will also
@@ -3670,7 +3670,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 		btrfs_err(fs_info,
 			  "zoned: failed to read device zone info: %d",
 			  ret);
-		goto fail_block_groups;
+		goto fail;
 	}
 
 	/*
@@ -3690,44 +3690,44 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 		btrfs_err(fs_info,
 			  "failed to verify dev extents against chunks: %d",
 			  ret);
-		goto fail_block_groups;
+		goto fail;
 	}
 	ret = btrfs_recover_balance(fs_info);
 	if (ret) {
 		btrfs_err(fs_info, "failed to recover balance: %d", ret);
-		goto fail_block_groups;
+		goto fail;
 	}
 
 	ret = btrfs_init_dev_stats(fs_info);
 	if (ret) {
 		btrfs_err(fs_info, "failed to init dev_stats: %d", ret);
-		goto fail_block_groups;
+		goto fail;
 	}
 
 	ret = btrfs_init_dev_replace(fs_info);
 	if (ret) {
 		btrfs_err(fs_info, "failed to init dev_replace: %d", ret);
-		goto fail_block_groups;
+		goto fail;
 	}
 
 	ret = btrfs_check_zoned_mode(fs_info);
 	if (ret) {
 		btrfs_err(fs_info, "failed to initialize zoned mode: %d",
 			  ret);
-		goto fail_block_groups;
+		goto fail;
 	}
 
 	ret = btrfs_sysfs_add_fsid(fs_devices);
 	if (ret) {
 		btrfs_err(fs_info, "failed to init sysfs fsid interface: %d",
 				ret);
-		goto fail_block_groups;
+		goto fail;
 	}
 
 	ret = btrfs_sysfs_add_mounted(fs_info);
 	if (ret) {
 		btrfs_err(fs_info, "failed to init sysfs interface: %d", ret);
-		goto fail_fsdev_sysfs;
+		goto fail;
 	}
 
 	ret = btrfs_init_space_info(fs_info);
@@ -3760,7 +3760,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 						   tree_root,
 						   "btrfs-transaction");
 	if (IS_ERR(fs_info->transaction_kthread))
-		goto fail_cleaner;
+		goto fail_sysfs;
 
 	if (!btrfs_test_opt(fs_info, NOSSD) &&
 	    !fs_info->fs_devices->rotating) {
@@ -3787,7 +3787,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 #endif
 	ret = btrfs_read_qgroup_config(fs_info);
 	if (ret)
-		goto fail_trans_kthread;
+		goto fail_sysfs;
 
 	if (btrfs_build_ref_tree(fs_info))
 		btrfs_err(fs_info, "couldn't build ref tree");
@@ -3799,7 +3799,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 		ret = btrfs_replay_log(fs_info, fs_devices);
 		if (ret) {
 			err = ret;
-			goto fail_qgroup;
+			goto fail_sysfs;
 		}
 	}
 
@@ -3808,7 +3808,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 		err = PTR_ERR(fs_info->fs_root);
 		btrfs_warn(fs_info, "failed to read fs tree: %d", err);
 		fs_info->fs_root = NULL;
-		goto fail_qgroup;
+		goto fail_sysfs;
 	}
 
 	if (sb_rdonly(sb))
@@ -3844,44 +3844,44 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	btrfs_clear_oneshot_options(fs_info);
 	return 0;
 
-fail_qgroup:
+fail_sysfs:
 	btrfs_free_qgroup_config(fs_info);
-fail_trans_kthread:
-	kthread_stop(fs_info->transaction_kthread);
+
+	if (fs_info->transaction_kthread)
+		kthread_stop(fs_info->transaction_kthread);
 	btrfs_cleanup_transaction(fs_info);
 	btrfs_free_fs_roots(fs_info);
-fail_cleaner:
-	kthread_stop(fs_info->cleaner_kthread);
+
+	if (fs_info->cleaner_kthread)
+		kthread_stop(fs_info->cleaner_kthread);
 
 	/*
 	 * make sure we're done with the btree inode before we stop our
 	 * kthreads
 	 */
+	ASSERT(fs_info->btree_inode);
 	filemap_write_and_wait(fs_info->btree_inode->i_mapping);
 
-fail_sysfs:
 	btrfs_sysfs_remove_mounted(fs_info);
 
-fail_fsdev_sysfs:
+fail:
 	btrfs_sysfs_remove_fsid(fs_info->fs_devices);
 
-fail_block_groups:
 	btrfs_put_block_group_cache(fs_info);
 
-fail_tree_roots:
 	if (fs_info->data_reloc_root)
 		btrfs_drop_and_free_fs_root(fs_info, fs_info->data_reloc_root);
 	free_root_pointers(fs_info, true);
-	invalidate_inode_pages2(fs_info->btree_inode->i_mapping);
 
-fail_sb_buffer:
+	if (fs_info->btree_inode)
+		invalidate_inode_pages2(fs_info->btree_inode->i_mapping);
 	btrfs_stop_all_workers(fs_info);
 	btrfs_free_block_groups(fs_info);
-fail_alloc:
+
 	btrfs_mapping_tree_free(&fs_info->mapping_tree);
 
-	iput(fs_info->btree_inode);
-fail:
+	if (fs_info->btree_inode)
+		iput(fs_info->btree_inode);
 	btrfs_close_devices(fs_info->fs_devices);
 	return err;
 }
-- 
2.37.0

