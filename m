Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6784EBC3E8
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2019 10:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393046AbfIXIL3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Sep 2019 04:11:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:38880 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390364AbfIXIL3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Sep 2019 04:11:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CEBEEB617;
        Tue, 24 Sep 2019 08:11:26 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Charles Wright <charles.v.wright@gmail.com>
Subject: [PATCH 1/3] btrfs-progs: check/lowmem: Add check and repair for invalid inode generation
Date:   Tue, 24 Sep 2019 16:11:18 +0800
Message-Id: <20190924081120.6283-2-wqu@suse.com>
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
  If it's an inode from log tree, then the upper limit is
  super_generation + 1, otherwise it's super_generation.

- Check if the inode generation is larger than the upper limit

- Repair by resetting inode generation to current transaction
  generation

Reported-by: Charles Wright <charles.v.wright@gmail.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/mode-lowmem.c | 76 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index 5f7f101d..7af29ba9 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -2472,6 +2472,59 @@ static bool has_orphan_item(struct btrfs_root *root, u64 ino)
 	return false;
 }
 
+static int repair_inode_gen_lowmem(struct btrfs_root *root,
+				   struct btrfs_path *path)
+{
+	struct btrfs_trans_handle *trans;
+	struct btrfs_inode_item *ii;
+	struct btrfs_key key;
+	u64 transid;
+	int ret;
+
+	trans = btrfs_start_transaction(root, 1);
+	if (IS_ERR(trans)) {
+		ret = PTR_ERR(trans);
+		errno = -ret;
+		error("failed to start transaction for inode gen repair: %m");
+		return ret;
+	}
+	transid = trans->transid;
+	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
+	ASSERT(key.type == BTRFS_INODE_ITEM_KEY);
+
+	btrfs_release_path(path);
+
+	ret = btrfs_search_slot(trans, root, &key, path, 0, 1);
+	if (ret > 0) {
+		ret = -ENOENT;
+		error("no inode item found for ino %llu", key.objectid);
+		goto error;
+	}
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to find inode item for ino %llu: %m",
+		      key.objectid);
+		goto error;
+	}
+	ii = btrfs_item_ptr(path->nodes[0], path->slots[0],
+			    struct btrfs_inode_item);
+	btrfs_set_inode_generation(path->nodes[0], ii, trans->transid);
+	btrfs_mark_buffer_dirty(path->nodes[0]);
+	ret = btrfs_commit_transaction(trans, root);
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to commit transaction: %m");
+		goto error;
+	}
+	printf("reseting inode generation to %llu for ino %llu\n",
+		transid, key.objectid);
+	return ret;
+
+error:
+	btrfs_abort_transaction(trans, ret);
+	return ret;
+}
+
 /*
  * Check INODE_ITEM and related ITEMs (the same inode number)
  * 1. check link count
@@ -2487,6 +2540,7 @@ static int check_inode_item(struct btrfs_root *root, struct btrfs_path *path)
 	struct btrfs_inode_item *ii;
 	struct btrfs_key key;
 	struct btrfs_key last_key;
+	struct btrfs_super_block *super = root->fs_info->super_copy;
 	u64 inode_id;
 	u32 mode;
 	u64 flags;
@@ -2497,6 +2551,8 @@ static int check_inode_item(struct btrfs_root *root, struct btrfs_path *path)
 	u64 refs = 0;
 	u64 extent_end = 0;
 	u64 extent_size = 0;
+	u64 generation;
+	u64 gen_uplimit;
 	unsigned int dir;
 	unsigned int nodatasum;
 	bool is_orphan = false;
@@ -2527,6 +2583,7 @@ static int check_inode_item(struct btrfs_root *root, struct btrfs_path *path)
 	flags = btrfs_inode_flags(node, ii);
 	dir = imode_to_type(mode) == BTRFS_FT_DIR;
 	nlink = btrfs_inode_nlink(node, ii);
+	generation = btrfs_inode_generation(node, ii);
 	nodatasum = btrfs_inode_flags(node, ii) & BTRFS_INODE_NODATASUM;
 
 	if (!is_valid_imode(mode)) {
@@ -2540,6 +2597,25 @@ static int check_inode_item(struct btrfs_root *root, struct btrfs_path *path)
 		}
 	}
 
+	if (btrfs_super_log_root(super) != 0 &&
+	    root->objectid == BTRFS_TREE_LOG_OBJECTID)
+		gen_uplimit = btrfs_super_generation(super) + 1;
+	else
+		gen_uplimit = btrfs_super_generation(super);
+
+	if (generation > gen_uplimit) {
+		error(
+	"invalid inode generation for ino %llu, have %llu expect [0, %llu)",
+		      inode_id, generation, gen_uplimit);
+		if (repair) {
+			ret = repair_inode_gen_lowmem(root, path);
+			if (ret < 0)
+				err |= INVALID_GENERATION;
+		} else {
+			err |= INVALID_GENERATION;
+		}
+
+	}
 	if (S_ISLNK(mode) &&
 	    flags & (BTRFS_INODE_IMMUTABLE | BTRFS_INODE_APPEND)) {
 		err |= INODE_FLAGS_ERROR;
-- 
2.23.0

