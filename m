Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A066F4F7E
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 May 2023 06:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjECEk0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 May 2023 00:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjECEkY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 May 2023 00:40:24 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0651FF9
        for <linux-btrfs@vger.kernel.org>; Tue,  2 May 2023 21:40:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D919522174
        for <linux-btrfs@vger.kernel.org>; Wed,  3 May 2023 04:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1683088819; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=G3PFKq53T1GzeDMINyVouqBTqPhw/12EPqrRt42XYvo=;
        b=anaJQEyctbociNw5jbevVoGwxp0mpVz1VnrHw3keZvo+wwLr0g0J6hiB/bcy6JaLJTU1Rt
        OXVnDe1iQhyjoOQXeiBOa3c5JDLO1SiMZM5IS3yHHLm08Lwf5udSLGn3r2pU4dMHCf7I2H
        NRs+45aHnsYOuMY9F3+w7i7O783TX6M=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 29B00138FE
        for <linux-btrfs@vger.kernel.org>; Wed,  3 May 2023 04:40:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9o4BOLLlUWS2fQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 03 May 2023 04:40:18 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs: output affected files when relocation failed
Date:   Wed,  3 May 2023 12:40:01 +0800
Message-Id: <ad4e1c92f8d623557458d1968d76f755264e050e.1683088762.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[PROBLEM]
When relocation failed (mostly due to checksum mismatch), we only got
very cryptic error messages like

  BTRFS info (device dm-4): relocating block group 13631488 flags data
  BTRFS warning (device dm-4): csum failed root -9 ino 257 off 0 csum 0x373e1ae3 expected csum 0x98757625 mirror 1
  BTRFS error (device dm-4): bdev /dev/mapper/test-scratch1 errs: wr 0, rd 0, flush 0, corrupt 1, gen 0
  BTRFS info (device dm-4): balance: ended with status: -5

The end user has to decrypt the above messages and use various tools to
locate the affected files and find a way to fix the problem (mostly
deleting the file).

This is not an easy work even for experienced developer, not to mention
the end users.

[SCRUB IS DOING BETTER]
By contrast, scrub is providing much better error messages:

 BTRFS error (device dm-4): unable to fixup (regular) error at logical 13631488 on dev /dev/mapper/test-scratch1 physical 13631488
 BTRFS warning (device dm-4): checksum error at logical 13631488 on dev /dev/mapper/test-scratch1, physical 13631488, root 5, inode 257, offset 0, length 4096, links 1 (path: file)
 BTRFS info (device dm-4): scrub: finished on devid 1 with status: 0

Which provides the affected files directly to the end user.

[IMPROVEMENT]
Instead of the generic data checksum error messages, which is not doing
a good job for data reloc inodes, this patch introduce a scrub like
backref walking based solution.

When a sector failed its checksum for data reloc inode, we go the
following workflow:

- Get the real logical bytenr
  For data reloc inode, the file offset is the offset inside the block
  group.
  Thus the real logical bytenr is @file_off + @block_group->start.

- Do an extent type check
  If it's tree blocks it's much easier to handle, just go through
  all the tree block backref.

- Do a backref walk and inode path resolution for data extents
  This is mostly the same as scrub.
  But unfortunately we can not reuse the same function as the output
  format is different.

Now the new output would be more user friendly:

 BTRFS info (device dm-4): relocating block group 13631488 flags data
 BTRFS warning (device dm-4): csum failed root -9 ino 257 off 0 logical 13631488 csum 0x373e1ae3 expected csum 0x98757625 mirror 1
 BTRFS warning (device dm-4): checksum error at logical 13631488 mirror 1 root 5 inode 257 offset 0 length 4096 links 1 (path: file)
 BTRFS error (device dm-4): bdev /dev/mapper/test-scratch1 errs: wr 0, rd 0, flush 0, corrupt 2, gen 0
 BTRFS info (device dm-4): balance: ended with status: -5

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Output the ino number using %llu
- Add a description for the new data_reloc_warn structure
- Use new comment format for the copied comments
- Use a less serious output message if we failed to resolve filename due
  to -ENOMEM
- Replace btrfs_warn_in_rcu() with btrfs_warn()
  As that RCU usage is from scrub output which grabs the device, but
  for balance we don't need that RCU usage at all.
---
 fs/btrfs/inode.c      | 193 +++++++++++++++++++++++++++++++++++++++++-
 fs/btrfs/relocation.c |  16 ++++
 fs/btrfs/relocation.h |   1 +
 3 files changed, 209 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 57d070025c7a..66a0f8b2ae64 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -70,6 +70,7 @@
 #include "verity.h"
 #include "super.h"
 #include "orphan.h"
+#include "backref.h"
 
 struct btrfs_iget_args {
 	u64 ino;
@@ -100,6 +101,18 @@ struct btrfs_rename_ctx {
 	u64 index;
 };
 
+/*
+ * Used by data_reloc_print_warning_inode() to pass needed info for filename
+ * resolution and output error message.
+ */
+struct data_reloc_warn {
+	struct btrfs_path path;
+	struct btrfs_fs_info *fs_info;
+	u64 extent_item_size;
+	u64 logical;
+	int mirror_num;
+};
+
 static const struct inode_operations btrfs_dir_inode_operations;
 static const struct inode_operations btrfs_symlink_inode_operations;
 static const struct inode_operations btrfs_special_inode_operations;
@@ -122,14 +135,192 @@ static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
 				       u64 ram_bytes, int compress_type,
 				       int type);
 
+static int data_reloc_print_warning_inode(u64 inum, u64 offset, u64 num_bytes,
+					  u64 root, void *warn_ctx)
+{
+	struct data_reloc_warn *warn = warn_ctx;
+	struct btrfs_fs_info *fs_info = warn->fs_info;
+	struct extent_buffer *eb;
+	struct btrfs_inode_item *inode_item;
+	struct inode_fs_paths *ipath = NULL;
+	struct btrfs_root *local_root;
+	struct btrfs_key key;
+	unsigned int nofs_flag;
+	u32 nlink;
+	int ret;
+
+	local_root = btrfs_get_fs_root(fs_info, root, true);
+	if (IS_ERR(local_root)) {
+		ret = PTR_ERR(local_root);
+		goto err;
+	}
+
+	/* This makes the path point to (inum INODE_ITEM ioff). */
+	key.objectid = inum;
+	key.type = BTRFS_INODE_ITEM_KEY;
+	key.offset = 0;
+
+	ret = btrfs_search_slot(NULL, local_root, &key, &warn->path, 0, 0);
+	if (ret) {
+		btrfs_put_root(local_root);
+		btrfs_release_path(&warn->path);
+		goto err;
+	}
+
+	eb = warn->path.nodes[0];
+	inode_item = btrfs_item_ptr(eb, warn->path.slots[0],
+				    struct btrfs_inode_item);
+	nlink = btrfs_inode_nlink(eb, inode_item);
+	btrfs_release_path(&warn->path);
+
+	nofs_flag = memalloc_nofs_save();
+	ipath = init_ipath(4096, local_root, &warn->path);
+	memalloc_nofs_restore(nofs_flag);
+	if (IS_ERR(ipath)) {
+		btrfs_put_root(local_root);
+		ret = PTR_ERR(ipath);
+		ipath = NULL;
+		/*
+		 * -ENOMEM, not a critical error, just output an generic error
+		 * without filename.
+		 */
+		btrfs_warn(fs_info,
+"checksum error at logical %llu mirror %u root %llu, inode %llu offset %llu",
+			   warn->logical, warn->mirror_num, root, inum, offset);
+		return ret;
+	}
+	ret = paths_from_inode(inum, ipath);
+	if (ret < 0)
+		goto err;
+
+	/*
+	 * We deliberately ignore the bit ipath might have been too small to
+	 * hold all of the paths here
+	 */
+	for (int i = 0; i < ipath->fspath->elem_cnt; i++)
+		btrfs_warn(fs_info,
+"checksum error at logical %llu mirror %u root %llu inode %llu offset %llu length %u links %u (path: %s)",
+			   warn->logical, warn->mirror_num, root, inum, offset,
+			   fs_info->sectorsize, nlink,
+			   (char *)(unsigned long)ipath->fspath->val[i]);
+
+	btrfs_put_root(local_root);
+	free_ipath(ipath);
+	return 0;
+
+err:
+	btrfs_warn(fs_info,
+"checksum error at logical %llu mirror %u root %llu inode %llu offset %llu, path resolving failed with ret=%d",
+		   warn->logical, warn->mirror_num, root, inum, offset, ret);
+
+	free_ipath(ipath);
+	return ret;
+
+}
+
+/*
+ * Do extra user-friendly error output (e.g. lookup all the affected files).
+ *
+ * Return true if we succeeded doing the backref lookup.
+ * Return false if such lookup failed, and has to fallback to the old error message.
+ */
+static void print_data_reloc_error(struct btrfs_inode *inode, u64 file_off,
+				   u8 *csum, u8 *csum_expected, int mirror_num)
+{
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+	struct btrfs_path path = { 0 };
+	struct btrfs_key found_key = { 0 };
+	struct extent_buffer *eb;
+	struct btrfs_extent_item *ei;
+	const u32 csum_size = fs_info->csum_size;
+	u64 logical;
+	u64 flags;
+	u32 item_size;
+	int ret;
+
+	mutex_lock(&fs_info->reloc_mutex);
+	logical = btrfs_get_reloc_bg_bytenr(fs_info);
+	mutex_unlock(&fs_info->reloc_mutex);
+
+	if (logical == U64_MAX) {
+		btrfs_warn_rl(fs_info, "has data reloc tree but no running relocation");
+		btrfs_warn_rl(fs_info,
+"csum failed root %lld ino %llu off %llu csum " CSUM_FMT " expected csum " CSUM_FMT " mirror %d",
+			inode->root->root_key.objectid, btrfs_ino(inode), file_off,
+			CSUM_FMT_VALUE(csum_size, csum),
+			CSUM_FMT_VALUE(csum_size, csum_expected),
+			mirror_num);
+		return;
+	}
+
+	logical += file_off;
+	btrfs_warn_rl(fs_info,
+"csum failed root %lld ino %llu off %llu logical %llu csum " CSUM_FMT " expected csum " CSUM_FMT " mirror %d",
+			inode->root->root_key.objectid,
+			btrfs_ino(inode), file_off, logical,
+			CSUM_FMT_VALUE(csum_size, csum),
+			CSUM_FMT_VALUE(csum_size, csum_expected),
+			mirror_num);
+
+	ret = extent_from_logical(fs_info, logical, &path, &found_key, &flags);
+	if (ret < 0) {
+		btrfs_err_rl(fs_info, "failed to lookup extent item for logical %llu: %d",
+			     logical, ret);
+		return;
+	}
+	eb = path.nodes[0];
+	ei = btrfs_item_ptr(eb, path.slots[0], struct btrfs_extent_item);
+	item_size = btrfs_item_size(eb, path.slots[0]);
+	if (flags & BTRFS_EXTENT_FLAG_TREE_BLOCK) {
+		unsigned long ptr = 0;
+		u64 ref_root;
+		u8 ref_level;
+
+		do {
+			ret = tree_backref_for_extent(&ptr, eb, &found_key, ei,
+						      item_size, &ref_root,
+						      &ref_level);
+			btrfs_warn_in_rcu(fs_info,
+"csum error at logical %llu mirror %u: metadata %s (level %d) in tree %llu",
+				logical, mirror_num,
+				ref_level ? "node" : "leaf",
+				ret < 0 ? -1 : ref_level,
+				ret < 0 ? -1 : ref_root);
+		} while (ret != 1);
+		btrfs_release_path(&path);
+	} else {
+		struct btrfs_backref_walk_ctx ctx = { 0 };
+		struct data_reloc_warn reloc_warn = { 0 };
+
+		btrfs_release_path(&path);
+
+		ctx.bytenr = found_key.objectid;
+		ctx.extent_item_pos = logical - found_key.objectid;
+		ctx.fs_info = fs_info;
+
+		reloc_warn.logical = logical;
+		reloc_warn.extent_item_size = found_key.offset;
+		reloc_warn.mirror_num = mirror_num;
+		reloc_warn.fs_info = fs_info;
+
+		iterate_extent_inodes(&ctx, true,
+				      data_reloc_print_warning_inode, &reloc_warn);
+	}
+}
+
 static void __cold btrfs_print_data_csum_error(struct btrfs_inode *inode,
 		u64 logical_start, u8 *csum, u8 *csum_expected, int mirror_num)
 {
 	struct btrfs_root *root = inode->root;
 	const u32 csum_size = root->fs_info->csum_size;
 
-	/* Output without objectid, which is more meaningful */
+	/* For data reloc tree, it's better doing a backref lookup instead. */
+	if (root->root_key.objectid == BTRFS_DATA_RELOC_TREE_OBJECTID)
+		return print_data_reloc_error(inode, logical_start, csum,
+					      csum_expected, mirror_num);
+
 	if (root->root_key.objectid >= BTRFS_LAST_FREE_OBJECTID) {
+	/* Output without objectid, which is more meaningful */
 		btrfs_warn_rl(root->fs_info,
 "csum failed root %lld ino %lld off %llu csum " CSUM_FMT " expected csum " CSUM_FMT " mirror %d",
 			root->root_key.objectid, btrfs_ino(inode),
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 09b1988d1791..1c74cbe2fc57 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4523,3 +4523,19 @@ int btrfs_reloc_post_snapshot(struct btrfs_trans_handle *trans,
 		ret = clone_backref_node(trans, rc, root, reloc_root);
 	return ret;
 }
+
+/*
+ * Get the current bytenr for the block group which is being relocated.
+ *
+ * Return U64_MAX if no running relocation.
+ */
+u64 btrfs_get_reloc_bg_bytenr(struct btrfs_fs_info *fs_info)
+{
+	u64 logical = U64_MAX;
+
+	lockdep_assert_held(&fs_info->reloc_mutex);
+
+	if (fs_info->reloc_ctl && fs_info->reloc_ctl->block_group)
+		logical = fs_info->reloc_ctl->block_group->start;
+	return logical;
+}
diff --git a/fs/btrfs/relocation.h b/fs/btrfs/relocation.h
index 2041a86186de..57cbac5c8ddd 100644
--- a/fs/btrfs/relocation.h
+++ b/fs/btrfs/relocation.h
@@ -19,5 +19,6 @@ int btrfs_reloc_post_snapshot(struct btrfs_trans_handle *trans,
 int btrfs_should_cancel_balance(struct btrfs_fs_info *fs_info);
 struct btrfs_root *find_reloc_root(struct btrfs_fs_info *fs_info, u64 bytenr);
 int btrfs_should_ignore_reloc_root(struct btrfs_root *root);
+u64 btrfs_get_reloc_bg_bytenr(struct btrfs_fs_info *fs_info);
 
 #endif
-- 
2.39.2

