Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6BFFBC3E9
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2019 10:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394727AbfIXILb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Sep 2019 04:11:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:38894 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2392102AbfIXILa (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Sep 2019 04:11:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 954E5B618;
        Tue, 24 Sep 2019 08:11:28 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Charles Wright <charles.v.wright@gmail.com>
Subject: [PATCH 2/3] btrfs-progs: check/original: Add check and repair for invalid inode generation
Date:   Tue, 24 Sep 2019 16:11:19 +0800
Message-Id: <20190924081120.6283-3-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190924081120.6283-1-wqu@suse.com>
References: <20190924081120.6283-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There are at least two bug reports of kernel tree-checker complaining
about invalid inode generation.

All offending inodes seem to be caused by old kernel around 2014, with
inode generation overflow.

So add such check and repair ability to lowmem mode check first.

This involves:
- Calculate the inode generation upper limit
  Unlike the original mode context, we don't have anyway to determine if
  this inode belongs to log tree.
  So we use super_generation + 1 as upper limit, just like what we did
  in kernel tree checker.

- Check if the inode generation is larger than the upper limit

- Repair by resetting inode generation to current transaction
  generation
  The difference is, in original mode, we have a common trans handle for
  all repair and reset path for each repair.

Reported-by: Charles Wright <charles.v.wright@gmail.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/main.c          | 50 ++++++++++++++++++++++++++++++++++++++++++-
 check/mode-original.h |  1 +
 2 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/check/main.c b/check/main.c
index c2d0f394..018707c8 100644
--- a/check/main.c
+++ b/check/main.c
@@ -604,6 +604,8 @@ static void print_inode_error(struct btrfs_root *root, struct inode_record *rec)
 	if (errors & I_ERR_INVALID_IMODE)
 		fprintf(stderr, ", invalid inode mode bit 0%o",
 			rec->imode & ~07777);
+	if (errors & I_ERR_INVALID_GEN)
+		fprintf(stderr, ", invalid inode generation");
 	fprintf(stderr, "\n");
 
 	/* Print the holes if needed */
@@ -857,6 +859,7 @@ static int process_inode_item(struct extent_buffer *eb,
 {
 	struct inode_record *rec;
 	struct btrfs_inode_item *item;
+	u64 gen_uplimit;
 	u64 flags;
 
 	rec = active_node->current;
@@ -879,6 +882,13 @@ static int process_inode_item(struct extent_buffer *eb,
 	if (S_ISLNK(rec->imode) &&
 	    flags & (BTRFS_INODE_IMMUTABLE | BTRFS_INODE_APPEND))
 		rec->errors |= I_ERR_ODD_INODE_FLAGS;
+	/*
+	 * We don't have accurate root info to determine the correct
+	 * inode generation uplimit, use super_generation + 1 anyway
+	 */
+	gen_uplimit = btrfs_super_generation(global_info->super_copy) + 1;
+	if (btrfs_inode_generation(eb, item) > gen_uplimit)
+		rec->errors |= I_ERR_INVALID_GEN;
 	maybe_free_inode_rec(&active_node->inode_cache, rec);
 	return 0;
 }
@@ -2774,6 +2784,41 @@ static int repair_imode_original(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
+static int repair_inode_gen_original(struct btrfs_trans_handle *trans,
+				     struct btrfs_root *root,
+				     struct btrfs_path *path,
+				     struct inode_record *rec)
+{
+	struct btrfs_inode_item *ii;
+	struct btrfs_key key;
+	int ret;
+
+	key.objectid = rec->ino;
+	key.offset = 0;
+	key.type = BTRFS_INODE_ITEM_KEY;
+
+	ret = btrfs_search_slot(trans, root, &key, path, 0, 1);
+	if (ret > 0) {
+		ret = -ENOENT;
+		error("no inode item found for ino %llu", rec->ino);
+		return ret;
+	}
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to search inode item for ino %llu: %m", rec->ino);
+		return ret;
+	}
+	ii = btrfs_item_ptr(path->nodes[0], path->slots[0],
+			    struct btrfs_inode_item);
+	btrfs_set_inode_generation(path->nodes[0], ii, trans->transid);
+	btrfs_mark_buffer_dirty(path->nodes[0]);
+	btrfs_release_path(path);
+	printf("resetting inode generation to %llu for ino %llu\n",
+		trans->transid, rec->ino);
+	rec->errors &= ~I_ERR_INVALID_GEN;
+	return 0;
+}
+
 static int try_repair_inode(struct btrfs_root *root, struct inode_record *rec)
 {
 	struct btrfs_trans_handle *trans;
@@ -2794,7 +2839,8 @@ static int try_repair_inode(struct btrfs_root *root, struct inode_record *rec)
 			     I_ERR_FILE_NBYTES_WRONG |
 			     I_ERR_INLINE_RAM_BYTES_WRONG |
 			     I_ERR_MISMATCH_DIR_HASH |
-			     I_ERR_UNALIGNED_EXTENT_REC)))
+			     I_ERR_UNALIGNED_EXTENT_REC |
+			     I_ERR_INVALID_GEN)))
 		return rec->errors;
 
 	/*
@@ -2829,6 +2875,8 @@ static int try_repair_inode(struct btrfs_root *root, struct inode_record *rec)
 		ret = repair_unaligned_extent_recs(trans, root, &path, rec);
 	if (!ret && rec->errors & I_ERR_INVALID_IMODE)
 		ret = repair_imode_original(trans, root, &path, rec);
+	if (!ret && rec->errors & I_ERR_INVALID_GEN)
+		ret = repair_inode_gen_original(trans, root, &path, rec);
 	btrfs_commit_transaction(trans, root);
 	btrfs_release_path(&path);
 	return ret;
diff --git a/check/mode-original.h b/check/mode-original.h
index 78d6bb30..b075a95c 100644
--- a/check/mode-original.h
+++ b/check/mode-original.h
@@ -185,6 +185,7 @@ struct unaligned_extent_rec_t {
 #define I_ERR_INLINE_RAM_BYTES_WRONG	(1 << 17)
 #define I_ERR_MISMATCH_DIR_HASH		(1 << 18)
 #define I_ERR_INVALID_IMODE		(1 << 19)
+#define I_ERR_INVALID_GEN		(1 << 20)
 
 struct inode_record {
 	struct list_head backrefs;
-- 
2.23.0

