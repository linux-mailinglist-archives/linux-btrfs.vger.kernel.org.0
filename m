Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57C335FC2BF
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Oct 2022 11:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbiJLJNm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Oct 2022 05:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiJLJNf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Oct 2022 05:13:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA538140F0
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Oct 2022 02:13:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 247401F390
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Oct 2022 09:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1665566010; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I2HkRHnsc8UxmPegAEMhiH2+BQ1A0HCEWMASipvQYVo=;
        b=DMBff6cPu8R2c552V2y2Xm7mMkQD3MFGD55gZf+hanB1mFPNH3Bt0268+QQFoggrUUmnO9
        NoUHCsJNT6zlFCe0p5IlS3R4LCoBvSZfvxm2b6Q/mZbw4+zAval6YmVtg1Tflf0XN28ktC
        Kbhoapjcd6CRRt3V0jpOPy/WO2zeokk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6C98A13A5C
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Oct 2022 09:13:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QFlJDjmFRmPKcQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Oct 2022 09:13:29 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 01/15] btrfs: initialize fs_info->sb at the very beginning of open_ctree()
Date:   Wed, 12 Oct 2022 17:12:57 +0800
Message-Id: <fa90b8e10aa079580f5263f8f1e11263e8be5219.1665565866.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1665565866.git.wqu@suse.com>
References: <cover.1665565866.git.wqu@suse.com>
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

Currently at open_ctree(), sb->s_fs_info is already initialized to the
fs_info we want.

On the other hand, fs_info->sb is not initialized until
init_mount_fs_info().

This patch will initialize fs_info->sb at the very beginning of
open_ctree(), so later code can use fs_info->sb to grab the super block.

This does not only remove the @sb parameter for init_mount_fs_info(),
but also provides the basis for later open_ctree() refactor which
requires everything to be accessible from a single @fs_info pointer.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 9f526841c68b..c00999212c91 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3102,13 +3102,12 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 	INIT_WORK(&fs_info->reclaim_bgs_work, btrfs_reclaim_bgs_work);
 }
 
-static int init_mount_fs_info(struct btrfs_fs_info *fs_info, struct super_block *sb)
+static int init_mount_fs_info(struct btrfs_fs_info *fs_info)
 {
 	int ret;
 
-	fs_info->sb = sb;
-	sb->s_blocksize = BTRFS_BDEV_BLOCKSIZE;
-	sb->s_blocksize_bits = blksize_bits(BTRFS_BDEV_BLOCKSIZE);
+	fs_info->sb->s_blocksize = BTRFS_BDEV_BLOCKSIZE;
+	fs_info->sb->s_blocksize_bits = blksize_bits(BTRFS_BDEV_BLOCKSIZE);
 
 	ret = percpu_counter_init(&fs_info->ordered_bytes, 0, GFP_KERNEL);
 	if (ret)
@@ -3136,7 +3135,7 @@ static int init_mount_fs_info(struct btrfs_fs_info *fs_info, struct super_block
 		return -ENOMEM;
 	btrfs_init_delayed_root(fs_info->delayed_root);
 
-	if (sb_rdonly(sb))
+	if (sb_rdonly(fs_info->sb))
 		set_bit(BTRFS_FS_STATE_RO, &fs_info->fs_state);
 
 	return btrfs_alloc_stripe_hash_table(fs_info);
@@ -3420,7 +3419,9 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	int err = -EINVAL;
 	int level;
 
-	ret = init_mount_fs_info(fs_info, sb);
+	fs_info->sb = sb;
+
+	ret = init_mount_fs_info(fs_info);
 	if (ret) {
 		err = ret;
 		goto fail;
@@ -3438,7 +3439,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 		goto fail;
 	}
 
-	fs_info->btree_inode = new_inode(sb);
+	fs_info->btree_inode = new_inode(fs_info->sb);
 	if (!fs_info->btree_inode) {
 		err = -ENOMEM;
 		goto fail;
@@ -3546,13 +3547,13 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	fs_info->csums_per_leaf = BTRFS_MAX_ITEM_SIZE(fs_info) / fs_info->csum_size;
 	fs_info->stripesize = stripesize;
 
-	ret = btrfs_parse_options(fs_info, options, sb->s_flags);
+	ret = btrfs_parse_options(fs_info, options, fs_info->sb->s_flags);
 	if (ret) {
 		err = ret;
 		goto fail_alloc;
 	}
 
-	ret = btrfs_check_features(fs_info, sb);
+	ret = btrfs_check_features(fs_info, fs_info->sb);
 	if (ret < 0) {
 		err = ret;
 		goto fail_alloc;
@@ -3588,12 +3589,12 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 		goto fail_sb_buffer;
 	}
 
-	sb->s_bdi->ra_pages *= btrfs_super_num_devices(disk_super);
-	sb->s_bdi->ra_pages = max(sb->s_bdi->ra_pages, SZ_4M / PAGE_SIZE);
+	fs_info->sb->s_bdi->ra_pages *= btrfs_super_num_devices(disk_super);
+	fs_info->sb->s_bdi->ra_pages = max(fs_info->sb->s_bdi->ra_pages, SZ_4M / PAGE_SIZE);
 
-	sb->s_blocksize = sectorsize;
-	sb->s_blocksize_bits = blksize_bits(sectorsize);
-	memcpy(&sb->s_uuid, fs_info->fs_devices->fsid, BTRFS_FSID_SIZE);
+	fs_info->sb->s_blocksize = sectorsize;
+	fs_info->sb->s_blocksize_bits = blksize_bits(sectorsize);
+	memcpy(&fs_info->sb->s_uuid, fs_info->fs_devices->fsid, BTRFS_FSID_SIZE);
 
 	mutex_lock(&fs_info->chunk_mutex);
 	ret = btrfs_read_sys_array(fs_info);
@@ -3790,7 +3791,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 		goto fail_qgroup;
 	}
 
-	if (sb_rdonly(sb))
+	if (sb_rdonly(fs_info->sb))
 		goto clear_oneshot;
 
 	ret = btrfs_start_pre_rw_mount(fs_info);
-- 
2.37.3

