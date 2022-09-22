Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1E675E56F0
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Sep 2022 02:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiIVAHO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Sep 2022 20:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbiIVAHN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Sep 2022 20:07:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1299A61F7
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Sep 2022 17:07:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 664A921A78
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Sep 2022 00:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1663805230; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i+pY2oG8qv2JaVz7yP+NkBZuHdzFdGV0dW3ZEi0WVmo=;
        b=Dej+GDm5suIbvK5ptsX7OTGAy8pLPpQHY8UXEcdbJqYsBKPiWWR2xBGryjc55GDWth+dFU
        XyETxbZYlTFWIkHnTuouEBRLG3OaN/gmknbJoAkZP/W6gFhHYfyd0eHRdAT3+wlJprdOY1
        a2GOKq/OHz6+aDWVOG8QcGoOb7kj844=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8D9C6139EF
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Sep 2022 00:07:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QIxPFi2nK2O1LwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Sep 2022 00:07:09 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 06/16] btrfs: extract mount options and features init code into its own init helper
Date:   Thu, 22 Sep 2022 08:06:23 +0800
Message-Id: <fb43f9f53955660e0d930828ca2a46db2acf935f.1663804335.git.wqu@suse.com>
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

This patch will extract the mount option parsing and features checking
code into a new helper, open_ctree_features_init().

This extraction also did the following non-functional change:

- Add btrfs_fs_info::__options member
  Currently the open_ctree_* helpers can only accept a single @fs_info
  parameter, to parse the mount options we have to use a temporary
  pointer for this purpose.

  Thankfully we don't need to do anything like freeing it.

- Move ssd optimization check into open_ctree_features_init()

- Move check_int related code into open_ctree_features_init()
  The mount time integrity check doesn't rely on any tree blocks, thus
  is safe to be called at feature init time.

- Separate @features variable into @incompat and @compat_ro
  So there will be no confusion, and compiler should be clever enough
  to optimize them out anyway.

- Properly return error for subpage initialization failure
  Preivously we just goto fail_alloc label, relying on the default
  -EINVAL error.
  Now we can return a proper -ENOMEM error instead.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ctree.h   |   6 ++
 fs/btrfs/disk-io.c | 176 +++++++++++++++++++++++----------------------
 2 files changed, 96 insertions(+), 86 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 8b7b7a212da0..88dc3b2896d7 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1106,6 +1106,12 @@ struct btrfs_fs_info {
 	struct lockdep_map btrfs_trans_pending_ordered_map;
 	struct lockdep_map btrfs_ordered_extent_map;
 
+	/*
+	 * Temporary pointer to the mount option string.
+	 * This is to workaround the fact that all open_ctree() init
+	 * functions can only accept a single @fs_info pointer.
+	 */
+	char *__options;
 #ifdef CONFIG_BTRFS_FS_REF_VERIFY
 	spinlock_t ref_verify_lock;
 	struct rb_root block_tree;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index f4c04cb1c0d6..ec9038eeaa0f 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3446,118 +3446,78 @@ static int open_ctree_super_init(struct btrfs_fs_info *fs_info)
 	return ret;
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
-	}, {
-		.init_func = open_ctree_super_init,
-		.exit_func = NULL,
-	}
-};
-
-
-int __cold open_ctree(struct super_block *sb, char *options)
+static int open_ctree_features_init(struct btrfs_fs_info *fs_info)
 {
-	u64 generation;
-	u64 features;
-	bool open_ctree_res[ARRAY_SIZE(open_ctree_seq)] = {0};
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
+	u64 incompat;
+	u64 compat_ro;
 
-	ret = btrfs_parse_options(fs_info, options, fs_info->sb->s_flags);
-	if (ret) {
-		err = ret;
-		goto fail_alloc;
-	}
+	ret = btrfs_parse_options(fs_info, fs_info->__options,
+				  fs_info->sb->s_flags);
+	if (ret)
+		return ret;
 
-	features = btrfs_super_incompat_flags(fs_info->super_copy) &
-		~BTRFS_FEATURE_INCOMPAT_SUPP;
-	if (features) {
+	incompat = btrfs_super_incompat_flags(fs_info->super_copy);
+	if (incompat & ~BTRFS_FEATURE_INCOMPAT_SUPP) {
 		btrfs_err(fs_info,
 		    "cannot mount because of unsupported optional features (0x%llx)",
-		    features);
-		err = -EINVAL;
-		goto fail_alloc;
+		    incompat & ~BTRFS_FEATURE_INCOMPAT_SUPP);
+		return -EINVAL;
 	}
 
-	features = btrfs_super_incompat_flags(fs_info->super_copy);
-	features |= BTRFS_FEATURE_INCOMPAT_MIXED_BACKREF;
+	incompat |= BTRFS_FEATURE_INCOMPAT_MIXED_BACKREF;
 	if (fs_info->compress_type == BTRFS_COMPRESS_LZO)
-		features |= BTRFS_FEATURE_INCOMPAT_COMPRESS_LZO;
+		incompat |= BTRFS_FEATURE_INCOMPAT_COMPRESS_LZO;
 	else if (fs_info->compress_type == BTRFS_COMPRESS_ZSTD)
-		features |= BTRFS_FEATURE_INCOMPAT_COMPRESS_ZSTD;
+		incompat |= BTRFS_FEATURE_INCOMPAT_COMPRESS_ZSTD;
 
 	/*
 	 * Flag our filesystem as having big metadata blocks if they are bigger
 	 * than the page size.
 	 */
 	if (btrfs_super_nodesize(fs_info->super_copy) > PAGE_SIZE)
-		features |= BTRFS_FEATURE_INCOMPAT_BIG_METADATA;
+		incompat |= BTRFS_FEATURE_INCOMPAT_BIG_METADATA;
 
 	/*
 	 * mixed block groups end up with duplicate but slightly offset
 	 * extent buffers for the same range.  It leads to corruptions
 	 */
-	if ((features & BTRFS_FEATURE_INCOMPAT_MIXED_GROUPS) &&
+	if ((incompat & BTRFS_FEATURE_INCOMPAT_MIXED_GROUPS) &&
 	    (fs_info->sectorsize != fs_info->nodesize)) {
 		btrfs_err(fs_info,
 "unequal nodesize/sectorsize (%u != %u) are not allowed for mixed block groups",
 			fs_info->nodesize, fs_info->sectorsize);
-		goto fail_alloc;
+		return -EINVAL;
 	}
 
 	/*
 	 * Needn't use the lock because there is no other task which will
 	 * update the flag.
 	 */
-	btrfs_set_super_incompat_flags(fs_info->super_copy, features);
+	btrfs_set_super_incompat_flags(fs_info->super_copy, incompat);
 
-	features = btrfs_super_compat_ro_flags(fs_info->super_copy) &
-		~BTRFS_FEATURE_COMPAT_RO_SUPP;
-	if (!sb_rdonly(fs_info->sb) && features) {
+	compat_ro = btrfs_super_compat_ro_flags(fs_info->super_copy);
+	if (!sb_rdonly(fs_info->sb) &&
+	    (compat_ro & ~BTRFS_FEATURE_COMPAT_RO_SUPP)) {
 		btrfs_err(fs_info,
 	"cannot mount read-write because of unsupported optional features (0x%llx)",
-		       features);
-		err = -EINVAL;
-		goto fail_alloc;
+		       compat_ro & ~BTRFS_FEATURE_COMPAT_RO_SUPP);
+		return -EINVAL;
 	}
 	/*
 	 * We have unsupported RO compat features, although RO mounted, we
 	 * should not cause any metadata write, including log replay.
 	 * Or we could screw up whatever the new feature requires.
 	 */
-	if (unlikely(features && btrfs_super_log_root(fs_info->super_copy) &&
+	if (unlikely((compat_ro & ~BTRFS_FEATURE_COMPAT_RO_SUPP)
+		     && btrfs_super_log_root(fs_info->super_copy) &&
 		     !btrfs_test_opt(fs_info, NOLOGREPLAY))) {
 		btrfs_err(fs_info,
 "cannot replay dirty log with unsupported compat_ro features (0x%llx), try rescue=nologreplay",
-			  features);
-		err = -EINVAL;
-		goto fail_alloc;
+			  compat_ro & ~BTRFS_FEATURE_COMPAT_RO_SUPP);
+		return -EINVAL;
 	}
 
-
 	if (fs_info->sectorsize < PAGE_SIZE) {
 		struct btrfs_subpage_info *subpage_info;
 
@@ -3577,11 +3537,73 @@ int __cold open_ctree(struct super_block *sb, char *options)
 			   fs_info->sectorsize, PAGE_SIZE);
 		subpage_info = kzalloc(sizeof(*subpage_info), GFP_KERNEL);
 		if (!subpage_info)
-			goto fail_alloc;
+			return -ENOMEM;
 		btrfs_init_subpage_info(subpage_info, fs_info->sectorsize);
 		fs_info->subpage_info = subpage_info;
 	}
 
+	if (!btrfs_test_opt(fs_info, NOSSD) &&
+	    !fs_info->fs_devices->rotating)
+		btrfs_set_and_info(fs_info, SSD, "enabling ssd optimizations");
+
+#ifdef CONFIG_BTRFS_FS_CHECK_INTEGRITY
+	if (btrfs_test_opt(fs_info, CHECK_INTEGRITY)) {
+		ret = btrfsic_mount(fs_info, fs_info->fs_devices,
+				    btrfs_test_opt(fs_info,
+					CHECK_INTEGRITY_DATA) ? 1 : 0,
+				    fs_info->check_integrity_print_mask);
+		if (ret)
+			btrfs_warn(fs_info,
+				"failed to initialize integrity check module: %d",
+				ret);
+	}
+#endif
+
+	return 0;
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
+	}, {
+		.init_func = open_ctree_features_init,
+		.exit_func = NULL,
+	}
+};
+
+int __cold open_ctree(struct super_block *sb, char *options)
+{
+	u64 generation;
+	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
+	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
+	bool open_ctree_res[ARRAY_SIZE(open_ctree_seq)] = {0};
+	int ret;
+	int err = -EINVAL;
+	int level;
+	int i;
+
+	fs_info->sb = sb;
+	fs_info->__options = options;
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
+
 	ret = btrfs_init_workqueues(fs_info);
 	if (ret) {
 		err = ret;
@@ -3736,29 +3758,12 @@ int __cold open_ctree(struct super_block *sb, char *options)
 	if (IS_ERR(fs_info->transaction_kthread))
 		goto fail_cleaner;
 
-	if (!btrfs_test_opt(fs_info, NOSSD) &&
-	    !fs_info->fs_devices->rotating) {
-		btrfs_set_and_info(fs_info, SSD, "enabling ssd optimizations");
-	}
-
 	/*
 	 * Mount does not set all options immediately, we can do it now and do
 	 * not have to wait for transaction commit
 	 */
 	btrfs_apply_pending_changes(fs_info);
 
-#ifdef CONFIG_BTRFS_FS_CHECK_INTEGRITY
-	if (btrfs_test_opt(fs_info, CHECK_INTEGRITY)) {
-		ret = btrfsic_mount(fs_info, fs_devices,
-				    btrfs_test_opt(fs_info,
-					CHECK_INTEGRITY_DATA) ? 1 : 0,
-				    fs_info->check_integrity_print_mask);
-		if (ret)
-			btrfs_warn(fs_info,
-				"failed to initialize integrity check module: %d",
-				ret);
-	}
-#endif
 	ret = btrfs_read_qgroup_config(fs_info);
 	if (ret)
 		goto fail_trans_kthread;
@@ -3851,7 +3856,6 @@ int __cold open_ctree(struct super_block *sb, char *options)
 fail_sb_buffer:
 	btrfs_stop_all_workers(fs_info);
 	btrfs_free_block_groups(fs_info);
-fail_alloc:
 	btrfs_mapping_tree_free(&fs_info->mapping_tree);
 fail:
 	for (i = ARRAY_SIZE(open_ctree_seq) - 1; i >= 0; i--) {
-- 
2.37.3

