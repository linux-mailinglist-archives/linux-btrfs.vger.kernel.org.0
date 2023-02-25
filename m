Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 684EB6A27EE
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Feb 2023 09:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjBYIov (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 25 Feb 2023 03:44:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBYIou (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 25 Feb 2023 03:44:50 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A74DBEB
        for <linux-btrfs@vger.kernel.org>; Sat, 25 Feb 2023 00:44:48 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 499516731C
        for <linux-btrfs@vger.kernel.org>; Sat, 25 Feb 2023 08:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1677314687; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=xc9B9n2CmqQyZ1oYm0b09R1NqN7DnnvMEwPNs84ioE4=;
        b=s7ukDbpmCtIKTDwhE7sMeORLCBOalSYhBRFkT7QUWCrkas1IpmqKHvHMwmbSundjvkNIHA
        pdXThuYT0ME8Kl9t2GBpaAJPDbzNBIBba/o1b3BpDUek5/954WLlGunGw9t4EoTlqUIJy7
        aeg6CC0E998dm5N/+eX1imiWyIcPrtU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8D3C213A42
        for <linux-btrfs@vger.kernel.org>; Sat, 25 Feb 2023 08:44:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id D59/FH7K+WP+TAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sat, 25 Feb 2023 08:44:46 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix the mount crash caused by confusing return value
Date:   Sat, 25 Feb 2023 16:44:28 +0800
Message-Id: <2de92bdcebd36e4119467797dedae8a9d97a9df3.1677314616.git.wqu@suse.com>
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

[BUG]
Btrfs mount can lead to crash if the fs has critical trees corrupted:

 # mkfs.btrfs  -f /dev/test/scratch1
 # btrfs-map-logical -l 30588928 /dev/test/scratch1 # The bytenr is tree root
 mirror 1 logical 30588928 physical 38977536 device /dev/test/scratch1
 mirror 2 logical 30588928 physical 307412992 device /dev/test/scratch1
 # xfs_io -f -c "pwrite 38977536 4" -c "pwrite 307412992 4" /dev/test/scratch1
 # mount /dev/test/scratch1 /mnt/btrfs

And the above mount would crash with the following dmesg:

 BTRFS warning (device dm-4): checksum verify failed on logical 30588928 mirror 1 wanted 0xcdcdcdcd found 0x6ca45898 level 0
 BTRFS warning (device dm-4): checksum verify failed on logical 30588928 mirror 2 wanted 0xcdcdcdcd found 0x6ca45898 level 0
 BTRFS warning (device dm-4): couldn't read tree root
 ==================================================================
 BUG: KASAN: null-ptr-deref in btrfs_iget+0x74/0x160 [btrfs]
 Read of size 8 at addr 00000000000001f7 by task mount/4040

[CAUSE]
In open_ctree(), we have two variables to indicates errors: @ret and
@err.

Unfortunately such confusion leads to the above crash, as in the error
handling of load_super_root(), we just goto fail_tree_roots label, but
at the end of error handling, we return @err instead of @ret.

Thus even we failed to load tree root, we still return 0 for
open_ctree(), thus later btrfs_iget() would fail.

[FIX]
Instead of such dangerous mixing, remove @err variable completely, and
use @ret only.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Unfortunately I failed to pin down a single patch causing the problem.
Would craft a test case for it.
---
 fs/btrfs/disk-io.c | 42 +++++++++++++++---------------------------
 1 file changed, 15 insertions(+), 27 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 48368d4bc331..e11aca6353a5 100644
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
@@ -3356,12 +3353,12 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 				      GFP_KERNEL);
 	fs_info->chunk_root = chunk_root;
 	if (!tree_root || !chunk_root) {
-		err = -ENOMEM;
+		ret = -ENOMEM;
 		goto fail;
 	}
 
-	err = btrfs_init_btree_inode(sb);
-	if (err)
+	ret = btrfs_init_btree_inode(sb);
+	if (ret)
 		goto fail;
 
 	invalidate_bdev(fs_devices->latest_dev->bdev);
@@ -3371,7 +3368,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	 */
 	disk_super = btrfs_read_dev_super(fs_devices->latest_dev->bdev);
 	if (IS_ERR(disk_super)) {
-		err = PTR_ERR(disk_super);
+		ret = PTR_ERR(disk_super);
 		goto fail_alloc;
 	}
 
@@ -3383,7 +3380,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	if (!btrfs_supported_super_csum(csum_type)) {
 		btrfs_err(fs_info, "unsupported checksum algorithm: %u",
 			  csum_type);
-		err = -EINVAL;
+		ret = -EINVAL;
 		btrfs_release_disk_super(disk_super);
 		goto fail_alloc;
 	}
@@ -3392,7 +3389,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 
 	ret = btrfs_init_csum_hash(fs_info, csum_type);
 	if (ret) {
-		err = ret;
 		btrfs_release_disk_super(disk_super);
 		goto fail_alloc;
 	}
@@ -3403,7 +3399,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	 */
 	if (btrfs_check_super_csum(fs_info, disk_super)) {
 		btrfs_err(fs_info, "superblock checksum mismatch");
-		err = -EINVAL;
+		ret = -EINVAL;
 		btrfs_release_disk_super(disk_super);
 		goto fail_alloc;
 	}
@@ -3433,7 +3429,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	ret = btrfs_validate_mount_super(fs_info);
 	if (ret) {
 		btrfs_err(fs_info, "superblock contains fatal errors");
-		err = -EINVAL;
+		ret = -EINVAL;
 		goto fail_alloc;
 	}
 
@@ -3465,16 +3461,12 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
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
@@ -3501,10 +3493,8 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	}
 
 	ret = btrfs_init_workqueues(fs_info);
-	if (ret) {
-		err = ret;
+	if (ret)
 		goto fail_sb_buffer;
-	}
 
 	sb->s_bdi->ra_pages *= btrfs_super_num_devices(disk_super);
 	sb->s_bdi->ra_pages = max(sb->s_bdi->ra_pages, SZ_4M / PAGE_SIZE);
@@ -3702,16 +3692,14 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
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
@@ -3788,7 +3776,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	iput(fs_info->btree_inode);
 fail:
 	btrfs_close_devices(fs_info->fs_devices);
-	return err;
+	return ret;
 }
 ALLOW_ERROR_INJECTION(open_ctree, ERRNO);
 
-- 
2.39.1

