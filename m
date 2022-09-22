Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBF55E56F2
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Sep 2022 02:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiIVAHQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Sep 2022 20:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiIVAHN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Sep 2022 20:07:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5650A00FF
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Sep 2022 17:07:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 89C6B21ABA
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Sep 2022 00:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1663805227; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z9aMp/2O2QHzHhxjf2DCny0B42nxWD/Ft8+DOm+qwic=;
        b=N7GJlqmXHXPSNCyDne/pLPIAdqv8xisZn2E2PfTfkylIaPHWeMXdH8LTr+nvP8WMQZF9iS
        BaNsyRAVXJ4O/gWBOXCiohuZlzm7PIDV9r5M9dL2/kFgtJ80eYjXQbuquhS08O5LMgUXnW
        i92pjXjd6fvDwKWIWuVGD4oKBbTFNCk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3E808139EF
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Sep 2022 00:07:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UOEQOymnK2O1LwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Sep 2022 00:07:05 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 04/16] btrfs: extract btree inode init code into its own init/exit helpers
Date:   Thu, 22 Sep 2022 08:06:21 +0800
Message-Id: <0e9f2fdef904a97e68eb2665e803abff03284b71.1663804335.git.wqu@suse.com>
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

Just like how we handle init_btrfs_fs(), here we also use an array to
handle the open_ctree() sequence.

This patch will do the first step by introducing the arrays, and put
btree_inode init/exit code into two helpers:

- open_ctree_btree_inode_init
- open_ctree_btree_inode_exit

[EXPOSED LABEL MISMATCH]
- Bad btrfs_mapping_tree_free() call
  Currently in fail_alloc tag, we call not only iput() on btree_inode, but
  also free the fs_info->mapping_tree, which is not correct.

  As the first time we touch mapping_tree is at btrfs_read_sys_array(),
  thus the btrfs_mapping_tree_free() call is already a label mismatch.

  This will be addressed when we refactor the chunk tree init code.

- Bad invalidate_inode_pages2() call
  After initiliazing the btree inode, we should invalidate all the page
  cache for metadata before we put the btree inode.

  But the old code is calling invalidate_inode_pages2() before stopping
  all workers.

  This is addressed by this patch as we're really the last exit function
  to be executed, thus we're safe to call invalidate_inode_pages2() then
  iput().

[SPECIAL HANDLING]
After init_mount_fs_info() if we hit some error, we don't need to undo
the work of init_mount_fs_info(), as caller will call btrfs_free_fs_info()
to free it anyway.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 116 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 82 insertions(+), 34 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 5fbf73daa388..79507c384146 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3290,6 +3290,69 @@ int btrfs_start_pre_rw_mount(struct btrfs_fs_info *fs_info)
 	return ret;
 }
 
+static int open_ctree_btree_inode_init(struct btrfs_fs_info *fs_info)
+{
+	int ret;
+
+	/*
+	 * The members initialized inside init_mount_fs_info() will be
+	 * handled in btrfs_free_fs_info() by the caller.
+	 * Thus we don't need to handle its error here.
+	 */
+	ret = init_mount_fs_info(fs_info);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * These need to be init'ed before we start creating inodes and such.
+	 *
+	 * And this 
+	 */
+	fs_info->tree_root = btrfs_alloc_root(fs_info, BTRFS_ROOT_TREE_OBJECTID,
+					      GFP_KERNEL);
+	fs_info->chunk_root = btrfs_alloc_root(fs_info, BTRFS_CHUNK_TREE_OBJECTID,
+					       GFP_KERNEL);
+	if (!fs_info->tree_root || !fs_info->chunk_root)
+		goto enomem;
+	fs_info->btree_inode = new_inode(fs_info->sb);
+	if (!fs_info->btree_inode)
+		goto enomem;
+
+	mapping_set_gfp_mask(fs_info->btree_inode->i_mapping, GFP_NOFS);
+	btrfs_init_btree_inode(fs_info);
+	invalidate_bdev(fs_info->fs_devices->latest_dev->bdev);
+	return 0;
+enomem:
+	btrfs_put_root(fs_info->tree_root);
+	btrfs_put_root(fs_info->chunk_root);
+	fs_info->tree_root = NULL;
+	fs_info->chunk_root = NULL;
+	return -ENOMEM;
+}
+
+static void open_ctree_btree_inode_exit(struct btrfs_fs_info *fs_info)
+{
+	invalidate_inode_pages2(fs_info->btree_inode->i_mapping);
+	iput(fs_info->btree_inode);
+	btrfs_put_root(fs_info->tree_root);
+	btrfs_put_root(fs_info->chunk_root);
+	fs_info->tree_root = NULL;
+	fs_info->chunk_root = NULL;
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
+	}
+};
+
+
 int __cold open_ctree(struct super_block *sb, char *options)
 {
 	u32 sectorsize;
@@ -3298,47 +3361,26 @@ int __cold open_ctree(struct super_block *sb, char *options)
 	u64 generation;
 	u64 features;
 	u16 csum_type;
+	bool open_ctree_res[ARRAY_SIZE(open_ctree_seq)] = {0};
 	struct btrfs_super_block *disk_super;
 	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
 	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
-	struct btrfs_root *tree_root;
-	struct btrfs_root *chunk_root;
 	int ret;
 	int err = -EINVAL;
 	int level;
+	int i;
 
 	fs_info->sb = sb;
 
 	/* Caller should have already initialized fs_info->fs_devices. */
 	ASSERT(fs_info->fs_devices);
 
-	ret = init_mount_fs_info(fs_info);
-	if (ret) {
-		err = ret;
-		goto fail;
-	}
-
-	/* These need to be init'ed before we start creating inodes and such. */
-	tree_root = btrfs_alloc_root(fs_info, BTRFS_ROOT_TREE_OBJECTID,
-				     GFP_KERNEL);
-	fs_info->tree_root = tree_root;
-	chunk_root = btrfs_alloc_root(fs_info, BTRFS_CHUNK_TREE_OBJECTID,
-				      GFP_KERNEL);
-	fs_info->chunk_root = chunk_root;
-	if (!tree_root || !chunk_root) {
-		err = -ENOMEM;
-		goto fail;
-	}
-
-	fs_info->btree_inode = new_inode(fs_info->sb);
-	if (!fs_info->btree_inode) {
-		err = -ENOMEM;
-		goto fail;
+	for (i = 0; i < ARRAY_SIZE(open_ctree_seq); i++) {
+		ret = open_ctree_seq[i].init_func(fs_info);
+		if (ret < 0)
+			goto fail;
+		open_ctree_res[i] = true;
 	}
-	mapping_set_gfp_mask(fs_info->btree_inode->i_mapping, GFP_NOFS);
-	btrfs_init_btree_inode(fs_info);
-
-	invalidate_bdev(fs_devices->latest_dev->bdev);
 
 	/*
 	 * Read super block and check the signature bytes only
@@ -3557,14 +3599,15 @@ int __cold open_ctree(struct super_block *sb, char *options)
 
 	generation = btrfs_super_chunk_root_generation(disk_super);
 	level = btrfs_super_chunk_root_level(disk_super);
-	ret = load_super_root(chunk_root, btrfs_super_chunk_root(disk_super),
+	ret = load_super_root(fs_info->chunk_root,
+			      btrfs_super_chunk_root(disk_super),
 			      generation, level);
 	if (ret) {
 		btrfs_err(fs_info, "failed to read chunk root");
 		goto fail_tree_roots;
 	}
 
-	read_extent_buffer(chunk_root->node, fs_info->chunk_tree_uuid,
+	read_extent_buffer(fs_info->chunk_root->node, fs_info->chunk_tree_uuid,
 			   offsetof(struct btrfs_header, chunk_tree_uuid),
 			   BTRFS_UUID_SIZE);
 
@@ -3688,7 +3731,7 @@ int __cold open_ctree(struct super_block *sb, char *options)
 		goto fail_sysfs;
 
 	fs_info->transaction_kthread = kthread_run(transaction_kthread,
-						   tree_root,
+						   fs_info->tree_root,
 						   "btrfs-transaction");
 	if (IS_ERR(fs_info->transaction_kthread))
 		goto fail_cleaner;
@@ -3803,17 +3846,22 @@ int __cold open_ctree(struct super_block *sb, char *options)
 	if (fs_info->data_reloc_root)
 		btrfs_drop_and_free_fs_root(fs_info, fs_info->data_reloc_root);
 	free_root_pointers(fs_info, true);
-	invalidate_inode_pages2(fs_info->btree_inode->i_mapping);
 
 fail_sb_buffer:
 	btrfs_stop_all_workers(fs_info);
 	btrfs_free_block_groups(fs_info);
 fail_alloc:
 	btrfs_mapping_tree_free(&fs_info->mapping_tree);
-
-	iput(fs_info->btree_inode);
 fail:
+	for (i = ARRAY_SIZE(open_ctree_seq) - 1; i >= 0; i--) {
+		if (!open_ctree_res[i] || !open_ctree_seq[i].exit_func)
+			continue;
+		open_ctree_seq[i].exit_func(fs_info);
+		open_ctree_res[i] = false;
+	}
 	btrfs_close_devices(fs_info->fs_devices);
+	if (ret < 0)
+		err = ret;
 	return err;
 }
 ALLOW_ERROR_INJECTION(open_ctree, ERRNO);
-- 
2.37.3

