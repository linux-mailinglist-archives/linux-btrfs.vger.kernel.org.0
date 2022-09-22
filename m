Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 913325E56EE
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Sep 2022 02:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiIVAHN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Sep 2022 20:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiIVAHM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Sep 2022 20:07:12 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5D09C2D6
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Sep 2022 17:07:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2E78F21AB5
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Sep 2022 00:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1663805229; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LxiH1WcVOEgwsBRdYEU+FiDcWu/Wg2wb87uYxPGNZLQ=;
        b=gQPuW7ME+PUz4ftQ+Tm3FgcW7/lFBHctAJVRT8wrBE1C8NBQgUGHDiRq3LIdvqRoepeMML
        vZQEh7bthqLmdqeWWVuiIcBTSSaBov24VA8VI3vzozc22P3y3rcOOhb5lK+LpRRNYYIDnu
        3+50LY/88qFm/WXc6vzjLSNVLiYIuR8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E84C6139EF
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Sep 2022 00:07:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SHuXLCunK2O1LwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Sep 2022 00:07:07 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 05/16] btrfs: extract super block read code into its own init helper
Date:   Thu, 22 Sep 2022 08:06:22 +0800
Message-Id: <7f52ddc1dad8ccaaf9378a87b143e10f33398297.1663804335.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1663804335.git.wqu@suse.com>
References: <cover.1663804335.git.wqu@suse.com>
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

This patch will extract the super block read and cached members
(sectorsize/nodesize/etc) initialization into a helper,
open_ctree_super_init().

This extraction also did the following non-functional change:

- Add an error message for super_root == 0 case
  Previously we just goto fail_alloc, with ret == 0.
  This can be very confusing and would cause problems since we didn't
  finish the mount at all.

- Move sb->s_blocksize and sb->s_bdi initialization into the new helper
  Since at this stage we already have valid super block and its
  sectorsize, we can directly initialize them here.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 203 +++++++++++++++++++++++----------------------
 1 file changed, 102 insertions(+), 101 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 79507c384146..f4c04cb1c0d6 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3340,56 +3340,18 @@ static void open_ctree_btree_inode_exit(struct btrfs_fs_info *fs_info)
 	fs_info->chunk_root = NULL;
 }
 
-struct init_sequence {
-	int (*init_func)(struct btrfs_fs_info *fs_info);
-	void (*exit_func)(struct btrfs_fs_info *fs_info);
-};
-
-static const struct init_sequence open_ctree_seq[] = {
-	{
-		.init_func = open_ctree_btree_inode_init,
-		.exit_func = open_ctree_btree_inode_exit,
-	}
-};
-
-
-int __cold open_ctree(struct super_block *sb, char *options)
+static int open_ctree_super_init(struct btrfs_fs_info *fs_info)
 {
-	u32 sectorsize;
+	struct btrfs_super_block *disk_super;
 	u32 nodesize;
-	u32 stripesize;
-	u64 generation;
-	u64 features;
+	u32 sectorsize;
 	u16 csum_type;
-	bool open_ctree_res[ARRAY_SIZE(open_ctree_seq)] = {0};
-	struct btrfs_super_block *disk_super;
-	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
-	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
 	int ret;
-	int err = -EINVAL;
-	int level;
-	int i;
-
-	fs_info->sb = sb;
-
-	/* Caller should have already initialized fs_info->fs_devices. */
-	ASSERT(fs_info->fs_devices);
-
-	for (i = 0; i < ARRAY_SIZE(open_ctree_seq); i++) {
-		ret = open_ctree_seq[i].init_func(fs_info);
-		if (ret < 0)
-			goto fail;
-		open_ctree_res[i] = true;
-	}
 
-	/*
-	 * Read super block and check the signature bytes only
-	 */
-	disk_super = btrfs_read_dev_super(fs_devices->latest_dev->bdev);
-	if (IS_ERR(disk_super)) {
-		err = PTR_ERR(disk_super);
-		goto fail_alloc;
-	}
+	/* Read super block and check the signature bytes only */
+	disk_super = btrfs_read_dev_super(fs_info->fs_devices->latest_dev->bdev);
+	if (IS_ERR(disk_super))
+		return PTR_ERR(disk_super);
 
 	/*
 	 * Verify the type first, if that or the checksum value are
@@ -3399,19 +3361,15 @@ int __cold open_ctree(struct super_block *sb, char *options)
 	if (!btrfs_supported_super_csum(csum_type)) {
 		btrfs_err(fs_info, "unsupported checksum algorithm: %u",
 			  csum_type);
-		err = -EINVAL;
-		btrfs_release_disk_super(disk_super);
-		goto fail_alloc;
+		ret = -EINVAL;
+		goto error;
 	}
 
 	fs_info->csum_size = btrfs_super_csum_size(disk_super);
 
 	ret = btrfs_init_csum_hash(fs_info, csum_type);
-	if (ret) {
-		err = ret;
-		btrfs_release_disk_super(disk_super);
-		goto fail_alloc;
-	}
+	if (ret)
+		goto error;
 
 	/*
 	 * We want to check superblock checksum, the type is stored inside.
@@ -3419,9 +3377,8 @@ int __cold open_ctree(struct super_block *sb, char *options)
 	 */
 	if (btrfs_check_super_csum(fs_info, (u8 *)disk_super)) {
 		btrfs_err(fs_info, "superblock checksum mismatch");
-		err = -EINVAL;
-		btrfs_release_disk_super(disk_super);
-		goto fail_alloc;
+		ret = -EINVAL;
+		goto error;
 	}
 
 	/*
@@ -3429,33 +3386,30 @@ int __cold open_ctree(struct super_block *sb, char *options)
 	 * following bytes up to INFO_SIZE, the checksum is calculated from
 	 * the whole block of INFO_SIZE
 	 */
-	memcpy(fs_info->super_copy, disk_super, sizeof(*fs_info->super_copy));
+	memcpy(fs_info->super_copy, disk_super, BTRFS_SUPER_INFO_SIZE);
 	btrfs_release_disk_super(disk_super);
 
-	disk_super = fs_info->super_copy;
-
-
-	features = btrfs_super_flags(disk_super);
-	if (features & BTRFS_SUPER_FLAG_CHANGING_FSID_V2) {
-		features &= ~BTRFS_SUPER_FLAG_CHANGING_FSID_V2;
-		btrfs_set_super_flags(disk_super, features);
+	if (btrfs_super_flags(fs_info->super_copy) &
+	    BTRFS_SUPER_FLAG_CHANGING_FSID_V2) {
+		btrfs_set_super_flags(fs_info->super_copy,
+				btrfs_super_flags(fs_info->super_copy) &
+				~BTRFS_SUPER_FLAG_CHANGING_FSID_V2);
 		btrfs_info(fs_info,
 			"found metadata UUID change in progress flag, clearing");
 	}
-
 	memcpy(fs_info->super_for_commit, fs_info->super_copy,
-	       sizeof(*fs_info->super_for_commit));
-
+	       BTRFS_SUPER_INFO_SIZE);
 	ret = btrfs_validate_mount_super(fs_info);
-	if (ret) {
+	if (ret < 0) {
 		btrfs_err(fs_info, "superblock contains fatal errors");
-		err = -EINVAL;
-		goto fail_alloc;
+		return -EINVAL;
 	}
 
-	if (!btrfs_super_root(disk_super))
-		goto fail_alloc;
-
+	if (!btrfs_super_root(fs_info->super_copy)) {
+		btrfs_err(fs_info,
+		"invalid super root bytenr, should have non-zero bytenr");
+		return -EINVAL;
+	}
 	/* check FS state, whether FS is broken. */
 	if (btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_ERROR)
 		set_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state);
@@ -3466,11 +3420,9 @@ int __cold open_ctree(struct super_block *sb, char *options)
 	 */
 	fs_info->compress_type = BTRFS_COMPRESS_ZLIB;
 
-
 	/* Set up fs_info before parsing mount options */
 	nodesize = btrfs_super_nodesize(disk_super);
 	sectorsize = btrfs_super_sectorsize(disk_super);
-	stripesize = sectorsize;
 	fs_info->dirty_metadata_batch = nodesize * (1 + ilog2(nr_cpu_ids));
 	fs_info->delalloc_batch = sectorsize * 512 * (1 + ilog2(nr_cpu_ids));
 
@@ -3478,7 +3430,61 @@ int __cold open_ctree(struct super_block *sb, char *options)
 	fs_info->sectorsize = sectorsize;
 	fs_info->sectorsize_bits = ilog2(sectorsize);
 	fs_info->csums_per_leaf = BTRFS_MAX_ITEM_SIZE(fs_info) / fs_info->csum_size;
-	fs_info->stripesize = stripesize;
+	fs_info->stripesize = sectorsize;
+
+	fs_info->sb->s_bdi->ra_pages *= btrfs_super_num_devices(fs_info->super_copy);
+	fs_info->sb->s_bdi->ra_pages = max(fs_info->sb->s_bdi->ra_pages, SZ_4M / PAGE_SIZE);
+
+	fs_info->sb->s_blocksize = sectorsize;
+	fs_info->sb->s_blocksize_bits = blksize_bits(sectorsize);
+	memcpy(&fs_info->sb->s_uuid, fs_info->fs_devices->fsid, BTRFS_FSID_SIZE);
+
+	return 0;
+
+error:
+	btrfs_release_disk_super(disk_super);
+	return ret;
+}
+
+struct init_sequence {
+	int (*init_func)(struct btrfs_fs_info *fs_info);
+	void (*exit_func)(struct btrfs_fs_info *fs_info);
+};
+
+static const struct init_sequence open_ctree_seq[] = {
+	{
+		.init_func = open_ctree_btree_inode_init,
+		.exit_func = open_ctree_btree_inode_exit,
+	}, {
+		.init_func = open_ctree_super_init,
+		.exit_func = NULL,
+	}
+};
+
+
+int __cold open_ctree(struct super_block *sb, char *options)
+{
+	u64 generation;
+	u64 features;
+	bool open_ctree_res[ARRAY_SIZE(open_ctree_seq)] = {0};
+	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
+	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
+	int ret;
+	int err = -EINVAL;
+	int level;
+	int i;
+
+	fs_info->sb = sb;
+
+	/* Caller should have already initialized fs_info->fs_devices. */
+	ASSERT(fs_info->fs_devices);
+
+	for (i = 0; i < ARRAY_SIZE(open_ctree_seq); i++) {
+		ret = open_ctree_seq[i].init_func(fs_info);
+		if (ret < 0)
+			goto fail;
+		open_ctree_res[i] = true;
+	}
 
 	ret = btrfs_parse_options(fs_info, options, fs_info->sb->s_flags);
 	if (ret) {
@@ -3486,7 +3492,7 @@ int __cold open_ctree(struct super_block *sb, char *options)
 		goto fail_alloc;
 	}
 
-	features = btrfs_super_incompat_flags(disk_super) &
+	features = btrfs_super_incompat_flags(fs_info->super_copy) &
 		~BTRFS_FEATURE_INCOMPAT_SUPP;
 	if (features) {
 		btrfs_err(fs_info,
@@ -3496,7 +3502,7 @@ int __cold open_ctree(struct super_block *sb, char *options)
 		goto fail_alloc;
 	}
 
-	features = btrfs_super_incompat_flags(disk_super);
+	features = btrfs_super_incompat_flags(fs_info->super_copy);
 	features |= BTRFS_FEATURE_INCOMPAT_MIXED_BACKREF;
 	if (fs_info->compress_type == BTRFS_COMPRESS_LZO)
 		features |= BTRFS_FEATURE_INCOMPAT_COMPRESS_LZO;
@@ -3507,7 +3513,7 @@ int __cold open_ctree(struct super_block *sb, char *options)
 	 * Flag our filesystem as having big metadata blocks if they are bigger
 	 * than the page size.
 	 */
-	if (btrfs_super_nodesize(disk_super) > PAGE_SIZE)
+	if (btrfs_super_nodesize(fs_info->super_copy) > PAGE_SIZE)
 		features |= BTRFS_FEATURE_INCOMPAT_BIG_METADATA;
 
 	/*
@@ -3515,10 +3521,10 @@ int __cold open_ctree(struct super_block *sb, char *options)
 	 * extent buffers for the same range.  It leads to corruptions
 	 */
 	if ((features & BTRFS_FEATURE_INCOMPAT_MIXED_GROUPS) &&
-	    (sectorsize != nodesize)) {
+	    (fs_info->sectorsize != fs_info->nodesize)) {
 		btrfs_err(fs_info,
 "unequal nodesize/sectorsize (%u != %u) are not allowed for mixed block groups",
-			nodesize, sectorsize);
+			fs_info->nodesize, fs_info->sectorsize);
 		goto fail_alloc;
 	}
 
@@ -3526,9 +3532,9 @@ int __cold open_ctree(struct super_block *sb, char *options)
 	 * Needn't use the lock because there is no other task which will
 	 * update the flag.
 	 */
-	btrfs_set_super_incompat_flags(disk_super, features);
+	btrfs_set_super_incompat_flags(fs_info->super_copy, features);
 
-	features = btrfs_super_compat_ro_flags(disk_super) &
+	features = btrfs_super_compat_ro_flags(fs_info->super_copy) &
 		~BTRFS_FEATURE_COMPAT_RO_SUPP;
 	if (!sb_rdonly(fs_info->sb) && features) {
 		btrfs_err(fs_info,
@@ -3542,7 +3548,7 @@ int __cold open_ctree(struct super_block *sb, char *options)
 	 * should not cause any metadata write, including log replay.
 	 * Or we could screw up whatever the new feature requires.
 	 */
-	if (unlikely(features && btrfs_super_log_root(disk_super) &&
+	if (unlikely(features && btrfs_super_log_root(fs_info->super_copy) &&
 		     !btrfs_test_opt(fs_info, NOLOGREPLAY))) {
 		btrfs_err(fs_info,
 "cannot replay dirty log with unsupported compat_ro features (0x%llx), try rescue=nologreplay",
@@ -3552,7 +3558,7 @@ int __cold open_ctree(struct super_block *sb, char *options)
 	}
 
 
-	if (sectorsize < PAGE_SIZE) {
+	if (fs_info->sectorsize < PAGE_SIZE) {
 		struct btrfs_subpage_info *subpage_info;
 
 		/*
@@ -3564,15 +3570,15 @@ int __cold open_ctree(struct super_block *sb, char *options)
 		btrfs_clear_opt(fs_info->mount_opt, SPACE_CACHE);
 		btrfs_set_and_info(fs_info, FREE_SPACE_TREE,
 			"forcing free space tree for sector size %u with page size %lu",
-			sectorsize, PAGE_SIZE);
+			fs_info->sectorsize, PAGE_SIZE);
 
 		btrfs_warn(fs_info,
 		"read-write for sector size %u with page size %lu is experimental",
-			   sectorsize, PAGE_SIZE);
+			   fs_info->sectorsize, PAGE_SIZE);
 		subpage_info = kzalloc(sizeof(*subpage_info), GFP_KERNEL);
 		if (!subpage_info)
 			goto fail_alloc;
-		btrfs_init_subpage_info(subpage_info, sectorsize);
+		btrfs_init_subpage_info(subpage_info, fs_info->sectorsize);
 		fs_info->subpage_info = subpage_info;
 	}
 
@@ -3582,13 +3588,6 @@ int __cold open_ctree(struct super_block *sb, char *options)
 		goto fail_sb_buffer;
 	}
 
-	fs_info->sb->s_bdi->ra_pages *= btrfs_super_num_devices(disk_super);
-	fs_info->sb->s_bdi->ra_pages = max(fs_info->sb->s_bdi->ra_pages, SZ_4M / PAGE_SIZE);
-
-	fs_info->sb->s_blocksize = sectorsize;
-	fs_info->sb->s_blocksize_bits = blksize_bits(sectorsize);
-	memcpy(&fs_info->sb->s_uuid, fs_info->fs_devices->fsid, BTRFS_FSID_SIZE);
-
 	mutex_lock(&fs_info->chunk_mutex);
 	ret = btrfs_read_sys_array(fs_info);
 	mutex_unlock(&fs_info->chunk_mutex);
@@ -3597,10 +3596,10 @@ int __cold open_ctree(struct super_block *sb, char *options)
 		goto fail_sb_buffer;
 	}
 
-	generation = btrfs_super_chunk_root_generation(disk_super);
-	level = btrfs_super_chunk_root_level(disk_super);
+	generation = btrfs_super_chunk_root_generation(fs_info->super_copy);
+	level = btrfs_super_chunk_root_level(fs_info->super_copy);
 	ret = load_super_root(fs_info->chunk_root,
-			      btrfs_super_chunk_root(disk_super),
+			      btrfs_super_chunk_root(fs_info->super_copy),
 			      generation, level);
 	if (ret) {
 		btrfs_err(fs_info, "failed to read chunk root");
@@ -3656,7 +3655,8 @@ int __cold open_ctree(struct super_block *sb, char *options)
 	 * even though it was perfectly fine.
 	 */
 	if (fs_info->uuid_root && !btrfs_test_opt(fs_info, RESCAN_UUID_TREE) &&
-	    fs_info->generation == btrfs_super_uuid_tree_generation(disk_super))
+	    fs_info->generation ==
+	    btrfs_super_uuid_tree_generation(fs_info->super_copy))
 		set_bit(BTRFS_FS_UPDATE_UUID_TREE_GEN, &fs_info->flags);
 
 	ret = btrfs_verify_dev_extents(fs_info);
@@ -3767,7 +3767,7 @@ int __cold open_ctree(struct super_block *sb, char *options)
 		btrfs_err(fs_info, "couldn't build ref tree");
 
 	/* do not make disk changes in broken FS or nologreplay is given */
-	if (btrfs_super_log_root(disk_super) != 0 &&
+	if (btrfs_super_log_root(fs_info->super_copy) != 0 &&
 	    !btrfs_test_opt(fs_info, NOLOGREPLAY)) {
 		btrfs_info(fs_info, "start tree-log replay");
 		ret = btrfs_replay_log(fs_info, fs_devices);
@@ -3797,7 +3797,8 @@ int __cold open_ctree(struct super_block *sb, char *options)
 
 	if (fs_info->uuid_root &&
 	    (btrfs_test_opt(fs_info, RESCAN_UUID_TREE) ||
-	     fs_info->generation != btrfs_super_uuid_tree_generation(disk_super))) {
+	     fs_info->generation !=
+	     btrfs_super_uuid_tree_generation(fs_info->super_copy))) {
 		btrfs_info(fs_info, "checking UUID tree");
 		ret = btrfs_check_uuid_tree(fs_info);
 		if (ret) {
-- 
2.37.3

