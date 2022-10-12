Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC6665FC2BD
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Oct 2022 11:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiJLJNp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Oct 2022 05:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiJLJNj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Oct 2022 05:13:39 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C2BBBE1D
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Oct 2022 02:13:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 48E241F461
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Oct 2022 09:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1665566014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SbCSSNIqhYewAwPh9mq2zNBCn7EnQuE8pqlinGknBag=;
        b=pCa87EjWYy3ko2c1Du3oT5+dnTiXoquoUgVIk0b28iV018MlLznDOabKLvw4ixSnhqymFP
        //OZ7VgZTpkaX2rshotXV83jEDJZwlDc+vySTIM/0K53W6izhgsm8nYZAxeL0giqsiNb32
        UGHzqDsFNqL20s8bgwUFaSfMd4zlVVY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 92E3913A5C
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Oct 2022 09:13:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uLPRFz2FRmPKcQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Oct 2022 09:13:33 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 05/15] btrfs: extract mount options and features init code into its own init helper
Date:   Wed, 12 Oct 2022 17:13:01 +0800
Message-Id: <1aff4b6129aa4fd977b1a7657bdd27e676e8dc28.1665565866.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1665565866.git.wqu@suse.com>
References: <cover.1665565866.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
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
 fs/btrfs/ctree.h   |  6 +++
 fs/btrfs/disk-io.c | 96 ++++++++++++++++++++++++----------------------
 2 files changed, 57 insertions(+), 45 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index a8b629a166be..a4557075b5c2 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -837,6 +837,12 @@ struct btrfs_fs_info {
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
index f8be0a74d07a..650eabb3d144 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3554,6 +3554,50 @@ static int open_ctree_super_init(struct btrfs_fs_info *fs_info)
 	return ret;
 }
 
+static int open_ctree_features_init(struct btrfs_fs_info *fs_info)
+{
+	int ret;
+
+	ret = btrfs_parse_options(fs_info, fs_info->__options,
+				  fs_info->sb->s_flags);
+	if (ret)
+		return ret;
+
+	ret = btrfs_check_features(fs_info, fs_info->sb);
+	if (ret < 0)
+		return ret;
+
+	if (fs_info->sectorsize < PAGE_SIZE) {
+		struct btrfs_subpage_info *subpage_info;
+
+		/*
+		 * V1 space cache has some hardcoded PAGE_SIZE usage, and is
+		 * going to be deprecated.
+		 *
+		 * Force to use v2 cache for subpage case.
+		 */
+		btrfs_clear_opt(fs_info->mount_opt, SPACE_CACHE);
+		btrfs_set_and_info(fs_info, FREE_SPACE_TREE,
+			"forcing free space tree for sector size %u with page size %lu",
+			fs_info->sectorsize, PAGE_SIZE);
+
+		btrfs_warn(fs_info,
+		"read-write for sector size %u with page size %lu is experimental",
+			   fs_info->sectorsize, PAGE_SIZE);
+		subpage_info = kzalloc(sizeof(*subpage_info), GFP_KERNEL);
+		if (!subpage_info)
+			return -ENOMEM;
+		btrfs_init_subpage_info(subpage_info, fs_info->sectorsize);
+		fs_info->subpage_info = subpage_info;
+	}
+
+	if (!btrfs_test_opt(fs_info, NOSSD) &&
+	    !fs_info->fs_devices->rotating)
+		btrfs_set_and_info(fs_info, SSD, "enabling ssd optimizations");
+
+	return 0;
+}
+
 struct init_sequence {
 	int (*init_func)(struct btrfs_fs_info *fs_info);
 	void (*exit_func)(struct btrfs_fs_info *fs_info);
@@ -3566,22 +3610,25 @@ static const struct init_sequence open_ctree_seq[] = {
 	}, {
 		.init_func = open_ctree_super_init,
 		.exit_func = NULL,
+	}, {
+		.init_func = open_ctree_features_init,
+		.exit_func = NULL,
 	}
 };
 
-
 int __cold open_ctree(struct super_block *sb, char *options)
 {
 	u64 generation;
-	bool open_ctree_res[ARRAY_SIZE(open_ctree_seq)] = {0};
 	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
 	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
+	bool open_ctree_res[ARRAY_SIZE(open_ctree_seq)] = {0};
 	int ret;
 	int err = -EINVAL;
 	int level;
 	int i;
 
 	fs_info->sb = sb;
+	fs_info->__options = options;
 
 	/* Caller should have already initialized fs_info->fs_devices. */
 	ASSERT(fs_info->fs_devices);
@@ -3593,42 +3640,6 @@ int __cold open_ctree(struct super_block *sb, char *options)
 		open_ctree_res[i] = true;
 	}
 
-	ret = btrfs_parse_options(fs_info, options, fs_info->sb->s_flags);
-	if (ret) {
-		err = ret;
-		goto fail_alloc;
-	}
-
-	ret = btrfs_check_features(fs_info, fs_info->sb);
-	if (ret < 0) {
-		err = ret;
-		goto fail_alloc;
-	}
-
-	if (fs_info->sectorsize < PAGE_SIZE) {
-		struct btrfs_subpage_info *subpage_info;
-
-		/*
-		 * V1 space cache has some hardcoded PAGE_SIZE usage, and is
-		 * going to be deprecated.
-		 *
-		 * Force to use v2 cache for subpage case.
-		 */
-		btrfs_clear_opt(fs_info->mount_opt, SPACE_CACHE);
-		btrfs_set_and_info(fs_info, FREE_SPACE_TREE,
-			"forcing free space tree for sector size %u with page size %lu",
-			fs_info->sectorsize, PAGE_SIZE);
-
-		btrfs_warn(fs_info,
-		"read-write for sector size %u with page size %lu is experimental",
-			   fs_info->sectorsize, PAGE_SIZE);
-		subpage_info = kzalloc(sizeof(*subpage_info), GFP_KERNEL);
-		if (!subpage_info)
-			goto fail_alloc;
-		btrfs_init_subpage_info(subpage_info, fs_info->sectorsize);
-		fs_info->subpage_info = subpage_info;
-	}
-
 	ret = btrfs_init_workqueues(fs_info);
 	if (ret) {
 		err = ret;
@@ -3783,11 +3794,6 @@ int __cold open_ctree(struct super_block *sb, char *options)
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
@@ -3796,7 +3802,7 @@ int __cold open_ctree(struct super_block *sb, char *options)
 
 #ifdef CONFIG_BTRFS_FS_CHECK_INTEGRITY
 	if (btrfs_test_opt(fs_info, CHECK_INTEGRITY)) {
-		ret = btrfsic_mount(fs_info, fs_devices,
+		ret = btrfsic_mount(fs_info, fs_info->fs_devices,
 				    btrfs_test_opt(fs_info,
 					CHECK_INTEGRITY_DATA) ? 1 : 0,
 				    fs_info->check_integrity_print_mask);
@@ -3806,6 +3812,7 @@ int __cold open_ctree(struct super_block *sb, char *options)
 				ret);
 	}
 #endif
+
 	ret = btrfs_read_qgroup_config(fs_info);
 	if (ret)
 		goto fail_trans_kthread;
@@ -3898,7 +3905,6 @@ int __cold open_ctree(struct super_block *sb, char *options)
 fail_sb_buffer:
 	btrfs_stop_all_workers(fs_info);
 	btrfs_free_block_groups(fs_info);
-fail_alloc:
 	btrfs_mapping_tree_free(&fs_info->mapping_tree);
 fail:
 	for (i = ARRAY_SIZE(open_ctree_seq) - 1; i >= 0; i--) {
-- 
2.37.3

