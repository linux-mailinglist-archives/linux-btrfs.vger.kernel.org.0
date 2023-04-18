Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A47FB6E5640
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Apr 2023 03:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjDRBQJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Apr 2023 21:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjDRBQI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Apr 2023 21:16:08 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17E43C0D
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Apr 2023 18:16:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D59591F8AF
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Apr 2023 01:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1681780564; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=RnWAYDe0CPdysihH8Obin3tMHse+eUJ3jzHf5FTmSKQ=;
        b=sPb6V3TGk70xLqG7pGw92TNkfGYKarobsFqvRzbXcTGwWUVlU9ENW/4koMUZnbOPA5osFW
        Cq+Oqc0pt1lNbbnBnW0Vv9tmUvwn5I6XrBvALll4G/+NWoeL9shC+3JWadzZxcyvxAfyVm
        Dq3vIkbSJ1RUrG1sNbKWOENHME0pqqA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 41B8413319
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Apr 2023 01:16:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uWhLBFTvPWQRQgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Apr 2023 01:16:04 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: output affected files when relocation failed
Date:   Tue, 18 Apr 2023 09:15:46 +0800
Message-Id: <aa446804b679949a1bd77e653a205408af43048e.1681780522.git.wqu@suse.com>
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
 BTRFS warning (device dm-4): checksum error at logical 13631488 mirror 1, root 5, inode 257, offset 0, length 4096, links 1 (path: file)
 BTRFS error (device dm-4): bdev /dev/mapper/test-scratch1 errs: wr 0, rd 0, flush 0, corrupt 2, gen 0
 BTRFS info (device dm-4): balance: ended with status: -5

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c      | 186 +++++++++++++++++++++++++++++++++++++++++-
 fs/btrfs/relocation.c |  16 ++++
 fs/btrfs/relocation.h |   1 +
 3 files changed, 202 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 57d070025c7a..feb57ac3da84 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -70,6 +70,7 @@
 #include "verity.h"
 #include "super.h"
 #include "orphan.h"
+#include "backref.h"
 
 struct btrfs_iget_args {
 	u64 ino;
@@ -100,6 +101,14 @@ struct btrfs_rename_ctx {
 	u64 index;
 };
 
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
@@ -122,14 +131,189 @@ static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
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
+	/*
+	 * this makes the path point to (inum INODE_ITEM ioff)
+	 */
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
+		goto err;
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
+		btrfs_warn_in_rcu(fs_info,
+"checksum error at logical %llu mirror %u, root %llu, inode %llu, offset %llu, length %u, links %u (path: %s)",
+				  warn->logical, warn->mirror_num,
+				  root, inum, offset,
+				  fs_info->sectorsize, nlink,
+				  (char *)(unsigned long)ipath->fspath->val[i]);
+
+	btrfs_put_root(local_root);
+	free_ipath(ipath);
+	return 0;
+
+err:
+	btrfs_warn_in_rcu(fs_info,
+			  "checksum error at logical %llu mirror %u, root %llu, inode %llu offset %llu: path resolving failed with ret=%d",
+			  warn->logical, warn->mirror_num,
+			  root, inum, offset, ret);
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
+"csum failed root %lld ino %lld off %llu csum " CSUM_FMT " expected csum " CSUM_FMT " mirror %d",
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

