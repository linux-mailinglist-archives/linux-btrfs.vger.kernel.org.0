Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8EF06A503B
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Feb 2023 01:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjB1Aox (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Feb 2023 19:44:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjB1Aow (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Feb 2023 19:44:52 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D62206A7
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Feb 2023 16:44:49 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 683D61FDAA
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Feb 2023 00:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1677545088; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=UniKRzbEDU6xmjtU/qxqaMushr7jkwc2hhSTFWBPpwM=;
        b=db0Fw4iZuERHeufn66ugg+B/sgm4UZEysf+iWJzYoyHvEnyJHJhw8Via1OtEgftpgKYsV1
        2E3dIkTEuS3prMZEoXlJ1WRWxdO34mwX1tNsCZL/IoTe3Dumf3VpkRA6mDBxQduqojedxQ
        8cw4FjlDNRv8LAsqTS4ZQOKRm4n1PQc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ACE5E13582
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Feb 2023 00:44:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fl1DHH9O/WO8fwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Feb 2023 00:44:47 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: open_ctree() error handling cleanup
Date:   Tue, 28 Feb 2023 08:44:30 +0800
Message-Id: <3a0a3e3ff11bf19afdf600b4ae42f49acd71c9e3.1677545065.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently open_ctree() uses two variables for error handling, @err and
@ret.

This is already causing problems in the latest misc-next once, and it is
already causing more hidden problems.

This patch will fix the problems by:

- Use only @ret for error handling

- Add proper @ret assigning
  Originally we rely on the default value (-EINVAL) of @err to handle
  errors, but that doesn't really reflects the error.
  This will change it use the correct error number for the following
  call sites:
  * subpage_info allocation
  * btrfs_free_extra_devids()
  * btrfs_check_rw_degradable()
  * cleaner_kthread allocation
  * transaction_kthread allocation

- Add an extra ASSERT()
  To make sure we error out instead of returning 0.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 65 ++++++++++++++++++++++------------------------
 1 file changed, 31 insertions(+), 34 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 0e0c30fe6df6..5d86daa5d685 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3339,14 +3339,11 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	struct btrfs_root *tree_root;
 	struct btrfs_root *chunk_root;
 	int ret;
-	int err = -EINVAL;
 	int level;
 
 	ret = init_mount_fs_info(fs_info, sb);
-	if (ret) {
-		err = ret;
+	if (ret)
 		goto fail;
-	}
 
 	/* These need to be init'ed before we start creating inodes and such. */
 	tree_root = btrfs_alloc_root(fs_info, BTRFS_ROOT_TREE_OBJECTID,
@@ -3356,15 +3353,13 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 				      GFP_KERNEL);
 	fs_info->chunk_root = chunk_root;
 	if (!tree_root || !chunk_root) {
-		err = -ENOMEM;
+		ret = -ENOMEM;
 		goto fail;
 	}
 
 	ret = btrfs_init_btree_inode(sb);
-	if (ret) {
-		err = ret;
+	if (ret)
 		goto fail;
-	}
 
 	invalidate_bdev(fs_devices->latest_dev->bdev);
 
@@ -3373,7 +3368,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	 */
 	disk_super = btrfs_read_dev_super(fs_devices->latest_dev->bdev);
 	if (IS_ERR(disk_super)) {
-		err = PTR_ERR(disk_super);
+		ret = PTR_ERR(disk_super);
 		goto fail_alloc;
 	}
 
@@ -3385,7 +3380,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	if (!btrfs_supported_super_csum(csum_type)) {
 		btrfs_err(fs_info, "unsupported checksum algorithm: %u",
 			  csum_type);
-		err = -EINVAL;
+		ret = -EINVAL;
 		btrfs_release_disk_super(disk_super);
 		goto fail_alloc;
 	}
@@ -3394,7 +3389,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 
 	ret = btrfs_init_csum_hash(fs_info, csum_type);
 	if (ret) {
-		err = ret;
 		btrfs_release_disk_super(disk_super);
 		goto fail_alloc;
 	}
@@ -3405,7 +3399,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	 */
 	if (btrfs_check_super_csum(fs_info, disk_super)) {
 		btrfs_err(fs_info, "superblock checksum mismatch");
-		err = -EINVAL;
+		ret = -EINVAL;
 		btrfs_release_disk_super(disk_super);
 		goto fail_alloc;
 	}
@@ -3435,12 +3429,15 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	ret = btrfs_validate_mount_super(fs_info);
 	if (ret) {
 		btrfs_err(fs_info, "superblock contains fatal errors");
-		err = -EINVAL;
+		ret = -EINVAL;
 		goto fail_alloc;
 	}
 
-	if (!btrfs_super_root(disk_super))
+	if (!btrfs_super_root(disk_super)) {
+		btrfs_err(fs_info, "invalid superblock tree root bytenr");
+		ret = -EINVAL;
 		goto fail_alloc;
+	}
 
 	/* check FS state, whether FS is broken. */
 	if (btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_ERROR)
@@ -3467,16 +3464,12 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	fs_info->stripesize = stripesize;
 
 	ret = btrfs_parse_options(fs_info, options, sb->s_flags);
-	if (ret) {
-		err = ret;
+	if (ret)
 		goto fail_alloc;
-	}
 
 	ret = btrfs_check_features(fs_info, !sb_rdonly(sb));
-	if (ret < 0) {
-		err = ret;
+	if (ret < 0)
 		goto fail_alloc;
-	}
 
 	if (sectorsize < PAGE_SIZE) {
 		struct btrfs_subpage_info *subpage_info;
@@ -3496,17 +3489,17 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 		"read-write for sector size %u with page size %lu is experimental",
 			   sectorsize, PAGE_SIZE);
 		subpage_info = kzalloc(sizeof(*subpage_info), GFP_KERNEL);
-		if (!subpage_info)
+		if (!subpage_info) {
+			ret = -ENOMEM;
 			goto fail_alloc;
+		}
 		btrfs_init_subpage_info(subpage_info, sectorsize);
 		fs_info->subpage_info = subpage_info;
 	}
 
 	ret = btrfs_init_workqueues(fs_info);
-	if (ret) {
-		err = ret;
+	if (ret)
 		goto fail_sb_buffer;
-	}
 
 	sb->s_bdi->ra_pages *= btrfs_super_num_devices(disk_super);
 	sb->s_bdi->ra_pages = max(sb->s_bdi->ra_pages, SZ_4M / PAGE_SIZE);
@@ -3552,6 +3545,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	btrfs_free_extra_devids(fs_devices);
 	if (!fs_devices->latest_dev->bdev) {
 		btrfs_err(fs_info, "failed to read devices");
+		ret = -EIO;
 		goto fail_tree_roots;
 	}
 
@@ -3567,8 +3561,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	ret = btrfs_get_dev_zone_info_all_devices(fs_info);
 	if (ret) {
 		btrfs_err(fs_info,
-			  "zoned: failed to read device zone info: %d",
-			  ret);
+			  "zoned: failed to read device zone info: %d", ret);
 		goto fail_block_groups;
 	}
 
@@ -3647,19 +3640,24 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	    !btrfs_check_rw_degradable(fs_info, NULL)) {
 		btrfs_warn(fs_info,
 		"writable mount is not allowed due to too many missing devices");
+		ret = -EINVAL;
 		goto fail_sysfs;
 	}
 
 	fs_info->cleaner_kthread = kthread_run(cleaner_kthread, fs_info,
 					       "btrfs-cleaner");
-	if (IS_ERR(fs_info->cleaner_kthread))
+	if (IS_ERR(fs_info->cleaner_kthread)) {
+		ret = PTR_ERR(fs_info->cleaner_kthread);
 		goto fail_sysfs;
+	}
 
 	fs_info->transaction_kthread = kthread_run(transaction_kthread,
 						   tree_root,
 						   "btrfs-transaction");
-	if (IS_ERR(fs_info->transaction_kthread))
+	if (IS_ERR(fs_info->transaction_kthread)) {
+		ret = PTR_ERR(fs_info->transaction_kthread);
 		goto fail_cleaner;
+	}
 
 	if (!btrfs_test_opt(fs_info, NOSSD) &&
 	    !fs_info->fs_devices->rotating) {
@@ -3704,16 +3702,14 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	    !btrfs_test_opt(fs_info, NOLOGREPLAY)) {
 		btrfs_info(fs_info, "start tree-log replay");
 		ret = btrfs_replay_log(fs_info, fs_devices);
-		if (ret) {
-			err = ret;
+		if (ret)
 			goto fail_qgroup;
-		}
 	}
 
 	fs_info->fs_root = btrfs_get_fs_root(fs_info, BTRFS_FS_TREE_OBJECTID, true);
 	if (IS_ERR(fs_info->fs_root)) {
-		err = PTR_ERR(fs_info->fs_root);
-		btrfs_warn(fs_info, "failed to read fs tree: %d", err);
+		ret = PTR_ERR(fs_info->fs_root);
+		btrfs_warn(fs_info, "failed to read fs tree: %d", ret);
 		fs_info->fs_root = NULL;
 		goto fail_qgroup;
 	}
@@ -3790,7 +3786,8 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	iput(fs_info->btree_inode);
 fail:
 	btrfs_close_devices(fs_info->fs_devices);
-	return err;
+	ASSERT(ret < 0);
+	return ret;
 }
 ALLOW_ERROR_INJECTION(open_ctree, ERRNO);
 
-- 
2.39.1

