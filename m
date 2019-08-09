Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C854087271
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Aug 2019 08:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405637AbfHIGxf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Aug 2019 02:53:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:38122 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728823AbfHIGxf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 9 Aug 2019 02:53:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0F7CDB03B
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Aug 2019 06:53:33 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs-progs: check/lowmem: Check and repair root generation
Date:   Fri,  9 Aug 2019 14:53:18 +0800
Message-Id: <20190809065320.22702-2-wqu@suse.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190809065320.22702-1-wqu@suse.com>
References: <20190809065320.22702-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since kernel is going to reject any root item which is newer than super
block generation, we need to provide a way to fix such problem in
btrfs-check.

This patch addes the ability to report and repair root generation in
lowmem mode.

This is done by cowing the root node, so we will update the root
generation along with the root node generation at commit transaction
time.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/mode-common.c | 29 +++++++++++++++++++++++++++++
 check/mode-common.h |  1 +
 check/mode-lowmem.c | 16 ++++++++++++++++
 check/mode-lowmem.h |  1 +
 4 files changed, 47 insertions(+)

diff --git a/check/mode-common.c b/check/mode-common.c
index d5f6c8ef97b1..a5b86a0ac32a 100644
--- a/check/mode-common.c
+++ b/check/mode-common.c
@@ -924,3 +924,32 @@ int check_repair_free_space_inode(struct btrfs_fs_info *fs_info,
 	}
 	return ret;
 }
+
+int repair_root_generation(struct btrfs_root *root)
+{
+	struct btrfs_trans_handle *trans;
+	struct btrfs_path path;
+	struct btrfs_key key;
+	int ret;
+
+	trans = btrfs_start_transaction(root, 1);
+	if (IS_ERR(trans))
+		return PTR_ERR(trans);
+
+	key.objectid = 0;
+	key.type = 0;
+	key.offset = 0;
+	btrfs_init_path(&path);
+
+	/* Here we only CoW the tree root to update the geneartion */
+	path.lowest_level = btrfs_header_level(root->node);
+	root->node->flags |= EXTENT_BAD_TRANSID;
+
+	ret = btrfs_search_slot(trans, root, &key, &path, 0, 1);
+	if (ret < 0)
+		return ret;
+
+	btrfs_release_path(&path);
+	ret = btrfs_commit_transaction(trans, root);
+	return ret;
+}
diff --git a/check/mode-common.h b/check/mode-common.h
index 4c169c6e3b29..4a3abeb02c81 100644
--- a/check/mode-common.h
+++ b/check/mode-common.h
@@ -155,4 +155,5 @@ static inline bool is_valid_imode(u32 imode)
 	return true;
 }
 
+int repair_root_generation(struct btrfs_root *root);
 #endif
diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index a2be0e6d7034..bf3b57f5ad2d 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -4957,6 +4957,7 @@ static int check_btrfs_root(struct btrfs_root *root, int check_all)
 	struct btrfs_path path;
 	struct node_refs nrefs;
 	struct btrfs_root_item *root_item = &root->root_item;
+	u64 super_generation = btrfs_super_generation(root->fs_info->super_copy);
 	int ret;
 	int level;
 	int err = 0;
@@ -4978,6 +4979,21 @@ static int check_btrfs_root(struct btrfs_root *root, int check_all)
 	level = btrfs_header_level(root->node);
 	btrfs_init_path(&path);
 
+	if (btrfs_root_generation(root_item) > super_generation + 1) {
+		error(
+	"invalid root generation for root %llu, have %llu expect (0, %llu)",
+		      root->root_key.objectid, btrfs_root_generation(root_item),
+		      super_generation + 1);
+		err |= INVALID_GENERATION;
+		if (repair) {
+			ret = repair_root_generation(root);
+			if (!ret) {
+				err &= ~INVALID_GENERATION;
+				printf("Reset generation for root %llu\n",
+					root->root_key.objectid);
+			}
+		}
+	}
 	if (btrfs_root_refs(root_item) > 0 ||
 	    btrfs_disk_key_objectid(&root_item->drop_progress) == 0) {
 		path.nodes[level] = root->node;
diff --git a/check/mode-lowmem.h b/check/mode-lowmem.h
index d2983fd12eb4..0361fb3382b1 100644
--- a/check/mode-lowmem.h
+++ b/check/mode-lowmem.h
@@ -47,6 +47,7 @@
 #define INODE_FLAGS_ERROR	(1<<23) /* Invalid inode flags */
 #define DIR_ITEM_HASH_MISMATCH	(1<<24) /* Dir item hash mismatch */
 #define INODE_MODE_ERROR	(1<<25) /* Bad inode mode */
+#define INVALID_GENERATION	(1<<26)	/* Generation is too new */
 
 /*
  * Error bit for low memory mode check.
-- 
2.22.0

