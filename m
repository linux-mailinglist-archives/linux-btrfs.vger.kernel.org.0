Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0B75E56EC
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Sep 2022 02:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiIVAHH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Sep 2022 20:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiIVAHG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Sep 2022 20:07:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719DE9E8B2
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Sep 2022 17:07:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 25B7C1F8F6
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Sep 2022 00:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1663805224; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6519V8MkZF/lQzAa9fG4uCE0DV/VyadgrV9Q9xOgRO8=;
        b=uSdhG8ExnyWqigHYqtT1bHYzvGQW/1p2nggbshA2gBhGPH3OtASzgqRO6zpVoCQtatLj8t
        crzPuwX0R79ky/qmqb/4tDF8sjbSzqIqDbGOLqgBLfWliCozL6USHzTOpISW8q2IUuAHXQ
        QUK4K5jhOYpH/zemtjr52xGfFSacUuA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6AFD2139EF
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Sep 2022 00:07:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aL5WCiWnK2O1LwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Sep 2022 00:07:01 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 02/16] btrfs: initialize fs_info->sb at the very beginning of open_ctree()
Date:   Thu, 22 Sep 2022 08:06:19 +0800
Message-Id: <45a33eb2400d94376840d8330f2492fb33f3800b.1663804335.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1663804335.git.wqu@suse.com>
References: <cover.1663804335.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index a887fe67a2a0..c4a8e684ee53 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3096,13 +3096,12 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
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
@@ -3130,7 +3129,7 @@ static int init_mount_fs_info(struct btrfs_fs_info *fs_info, struct super_block
 		return -ENOMEM;
 	btrfs_init_delayed_root(fs_info->delayed_root);
 
-	if (sb_rdonly(sb))
+	if (sb_rdonly(fs_info->sb))
 		set_bit(BTRFS_FS_STATE_RO, &fs_info->fs_state);
 
 	return btrfs_alloc_stripe_hash_table(fs_info);
@@ -3308,7 +3307,9 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	int err = -EINVAL;
 	int level;
 
-	ret = init_mount_fs_info(fs_info, sb);
+	fs_info->sb = sb;
+
+	ret = init_mount_fs_info(fs_info);
 	if (ret) {
 		err = ret;
 		goto fail;
@@ -3326,7 +3327,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 		goto fail;
 	}
 
-	fs_info->btree_inode = new_inode(sb);
+	fs_info->btree_inode = new_inode(fs_info->sb);
 	if (!fs_info->btree_inode) {
 		err = -ENOMEM;
 		goto fail;
@@ -3434,7 +3435,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	fs_info->csums_per_leaf = BTRFS_MAX_ITEM_SIZE(fs_info) / fs_info->csum_size;
 	fs_info->stripesize = stripesize;
 
-	ret = btrfs_parse_options(fs_info, options, sb->s_flags);
+	ret = btrfs_parse_options(fs_info, options, fs_info->sb->s_flags);
 	if (ret) {
 		err = ret;
 		goto fail_alloc;
@@ -3484,7 +3485,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 
 	features = btrfs_super_compat_ro_flags(disk_super) &
 		~BTRFS_FEATURE_COMPAT_RO_SUPP;
-	if (!sb_rdonly(sb) && features) {
+	if (!sb_rdonly(fs_info->sb) && features) {
 		btrfs_err(fs_info,
 	"cannot mount read-write because of unsupported optional features (0x%llx)",
 		       features);
@@ -3536,12 +3537,12 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
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
@@ -3738,7 +3739,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 		goto fail_qgroup;
 	}
 
-	if (sb_rdonly(sb))
+	if (sb_rdonly(fs_info->sb))
 		goto clear_oneshot;
 
 	ret = btrfs_start_pre_rw_mount(fs_info);
-- 
2.37.3

