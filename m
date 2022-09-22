Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22BC55E56F1
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Sep 2022 02:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiIVAHR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Sep 2022 20:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbiIVAHO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Sep 2022 20:07:14 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B33A0604
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Sep 2022 17:07:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 710001F8F6
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Sep 2022 00:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1663805232; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JkNpZ0RdNFJgpYxmNVAzvgHthVpZBxKLxPQpFe/WqX0=;
        b=Jf8ZLWg2YUGjON/lBmGos5XOcne0riZSMfXbPc1Dn304JjFBzIoffSpTghPhwYvFIGSswr
        Z80j3TeiIrGYFa99zLTc69wuaWMNvLGHFiGy/5pSgHQxuWB820ZtHHuL8I59mXkPVKXLj8
        IzcVs+j4bAWdyeMRW8x7TgY0HXVmmok=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C9EB4139EF
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Sep 2022 00:07:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WPchJS+nK2O1LwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Sep 2022 00:07:11 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 08/16] btrfs: extract chunk tree read code into its own init/exit helpers
Date:   Thu, 22 Sep 2022 08:06:25 +0800
Message-Id: <74c19deb09e96de1dd30492172785f4116c0c780.1663804335.git.wqu@suse.com>
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

Involved functional changes:

- Properly free the chunk map and chunk root ebs at error handling
  Previously we rely the final close_ctree() to properly free the chunk
  root extent buffers.

  With the more strict open_ctree_seq[] requirement, since we're the
  first one to fully populate chunk root extent buffers, at error
  we should also free the extent buffers.

  Note, the tree root and chunk root themselves are first allocated by
  open_ctree_btree_inode_init(), thus we should not free the chunk_root
  pointer, but just the extent buffers.

- Do degradable check immediately after loading chunk tree
  The degradable check only requires the full chunk mapping, can be done
  immediately after btrfs_read_chunk_tree().

This also exposed one exiting label mismatch, at chunk tree read, we
didn't create block group items at all, but at the old fail_sb_buffer:
label we call btrfs_free_block_groups().

It doesn't hurt but just shows how bad the original code labels are
managed.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 127 ++++++++++++++++++++++++++-------------------
 1 file changed, 74 insertions(+), 53 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 0e1fe12c1c99..4fcdd15697d0 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3563,6 +3563,77 @@ static int open_ctree_features_init(struct btrfs_fs_info *fs_info)
 	return 0;
 }
 
+static int open_ctree_chunk_tree_init(struct btrfs_fs_info *fs_info)
+{
+	u64 generation;
+	int level;
+	int ret;
+
+	mutex_lock(&fs_info->chunk_mutex);
+	ret = btrfs_read_sys_array(fs_info);
+	mutex_unlock(&fs_info->chunk_mutex);
+	if (ret) {
+		btrfs_err(fs_info, "failed to read the system array: %d", ret);
+		goto free_mapping;
+	}
+
+	generation = btrfs_super_chunk_root_generation(fs_info->super_copy);
+	level = btrfs_super_chunk_root_level(fs_info->super_copy);
+	ret = load_super_root(fs_info->chunk_root,
+			      btrfs_super_chunk_root(fs_info->super_copy),
+			      generation, level);
+	if (ret) {
+		btrfs_err(fs_info, "failed to read chunk root");
+		goto free_root;
+	}
+
+	read_extent_buffer(fs_info->chunk_root->node, fs_info->chunk_tree_uuid,
+			   offsetof(struct btrfs_header, chunk_tree_uuid),
+			   BTRFS_UUID_SIZE);
+
+	ret = btrfs_read_chunk_tree(fs_info);
+	if (ret) {
+		btrfs_err(fs_info, "failed to read chunk tree: %d", ret);
+		goto free_root;
+	}
+
+	/*
+	 * At this point we know all the devices that make this filesystem,
+	 * including the seed devices but we don't know yet if the replace
+	 * target is required. So free devices that are not part of this
+	 * filesystem but skip the replace target device which is checked
+	 * below in btrfs_init_dev_replace().
+	 */
+	btrfs_free_extra_devids(fs_info->fs_devices);
+	if (!fs_info->fs_devices->latest_dev->bdev) {
+		btrfs_err(fs_info, "failed to read devices");
+		goto free_root;
+	}
+
+	/* We have full chunk tree loaded, can do degradable check now. */
+	if (!sb_rdonly(fs_info->sb) && fs_info->fs_devices->missing_devices &&
+	    !btrfs_check_rw_degradable(fs_info, NULL)) {
+		btrfs_warn(fs_info,
+		"writable mount is not allowed due to too many missing devices");
+		ret = -EIO;
+		goto free_root;
+	}
+
+	return 0;
+
+free_root:
+	free_root_extent_buffers(fs_info->chunk_root);
+free_mapping:
+	btrfs_mapping_tree_free(&fs_info->mapping_tree);
+	return ret;
+}
+
+static void open_ctree_chunk_tree_exit(struct btrfs_fs_info *fs_info)
+{
+	free_root_extent_buffers(fs_info->chunk_root);
+	btrfs_mapping_tree_free(&fs_info->mapping_tree);
+}
+
 struct init_sequence {
 	int (*init_func)(struct btrfs_fs_info *fs_info);
 	void (*exit_func)(struct btrfs_fs_info *fs_info);
@@ -3581,18 +3652,19 @@ static const struct init_sequence open_ctree_seq[] = {
 	}, {
 		.init_func = btrfs_init_workqueues,
 		.exit_func = btrfs_stop_all_workers,
+	}, {
+		.init_func = open_ctree_chunk_tree_init,
+		.exit_func = open_ctree_chunk_tree_exit,
 	}
 };
 
 int __cold open_ctree(struct super_block *sb, char *options)
 {
-	u64 generation;
 	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
 	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
 	bool open_ctree_res[ARRAY_SIZE(open_ctree_seq)] = {0};
 	int ret;
 	int err = -EINVAL;
-	int level;
 	int i;
 
 	fs_info->sb = sb;
@@ -3608,47 +3680,6 @@ int __cold open_ctree(struct super_block *sb, char *options)
 		open_ctree_res[i] = true;
 	}
 
-	mutex_lock(&fs_info->chunk_mutex);
-	ret = btrfs_read_sys_array(fs_info);
-	mutex_unlock(&fs_info->chunk_mutex);
-	if (ret) {
-		btrfs_err(fs_info, "failed to read the system array: %d", ret);
-		goto fail_sb_buffer;
-	}
-
-	generation = btrfs_super_chunk_root_generation(fs_info->super_copy);
-	level = btrfs_super_chunk_root_level(fs_info->super_copy);
-	ret = load_super_root(fs_info->chunk_root,
-			      btrfs_super_chunk_root(fs_info->super_copy),
-			      generation, level);
-	if (ret) {
-		btrfs_err(fs_info, "failed to read chunk root");
-		goto fail_tree_roots;
-	}
-
-	read_extent_buffer(fs_info->chunk_root->node, fs_info->chunk_tree_uuid,
-			   offsetof(struct btrfs_header, chunk_tree_uuid),
-			   BTRFS_UUID_SIZE);
-
-	ret = btrfs_read_chunk_tree(fs_info);
-	if (ret) {
-		btrfs_err(fs_info, "failed to read chunk tree: %d", ret);
-		goto fail_tree_roots;
-	}
-
-	/*
-	 * At this point we know all the devices that make this filesystem,
-	 * including the seed devices but we don't know yet if the replace
-	 * target is required. So free devices that are not part of this
-	 * filesystem but skip the replace target device which is checked
-	 * below in btrfs_init_dev_replace().
-	 */
-	btrfs_free_extra_devids(fs_devices);
-	if (!fs_devices->latest_dev->bdev) {
-		btrfs_err(fs_info, "failed to read devices");
-		goto fail_tree_roots;
-	}
-
 	ret = init_tree_roots(fs_info);
 	if (ret)
 		goto fail_tree_roots;
@@ -3738,13 +3769,6 @@ int __cold open_ctree(struct super_block *sb, char *options)
 
 	btrfs_free_zone_cache(fs_info);
 
-	if (!sb_rdonly(sb) && fs_info->fs_devices->missing_devices &&
-	    !btrfs_check_rw_degradable(fs_info, NULL)) {
-		btrfs_warn(fs_info,
-		"writable mount is not allowed due to too many missing devices");
-		goto fail_sysfs;
-	}
-
 	fs_info->cleaner_kthread = kthread_run(cleaner_kthread, fs_info,
 					       "btrfs-cleaner");
 	if (IS_ERR(fs_info->cleaner_kthread))
@@ -3850,10 +3874,7 @@ int __cold open_ctree(struct super_block *sb, char *options)
 	if (fs_info->data_reloc_root)
 		btrfs_drop_and_free_fs_root(fs_info, fs_info->data_reloc_root);
 	free_root_pointers(fs_info, true);
-
-fail_sb_buffer:
 	btrfs_free_block_groups(fs_info);
-	btrfs_mapping_tree_free(&fs_info->mapping_tree);
 fail:
 	for (i = ARRAY_SIZE(open_ctree_seq) - 1; i >= 0; i--) {
 		if (!open_ctree_res[i] || !open_ctree_seq[i].exit_func)
-- 
2.37.3

