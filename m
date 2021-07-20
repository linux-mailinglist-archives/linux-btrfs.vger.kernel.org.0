Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 926F73CFDC2
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jul 2021 17:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242156AbhGTO7h (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Jul 2021 10:59:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:34740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240271AbhGTOYt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Jul 2021 10:24:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 050F461221
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jul 2021 15:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626793527;
        bh=I5Xow7BTADsKyYvX7t1/vErMeHW8CIheIVL1pIfIImA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=sSET+3xA9+ZdSbhqoNAitNyxJBbh/2nvNji+2D/3ebR+sOmnfwXUZLa9T+sYzgpJP
         K/Z7e8zV680cP1Br8I0BM1R2NW22QMNkdIZ8Ii47SkzARTfVjkO56lpSUU/TqMkh+D
         nG/6ypQ6mGK46MVQq/IbtpqlI2opc1UqTp6dpN5C41XbJ3+9MACs3tlK1/8ssmsBfN
         HoqDWaDrlWemyOy4HzBq9IbP4eD0US57jgNSuK1mO7FAcc0ekRPNeCE6m+sGWlmMUW
         IJQzz3kiNV8L8rpnqHzx51Ym5iypmValR9c2k4N5SrYKU8t8tPfjno4GaV9gdYUFqI
         ZFM05uSScLKxg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: stop doing GFP_KERNEL memory allocations in the ref verify tool
Date:   Tue, 20 Jul 2021 16:05:23 +0100
Message-Id: <a3c49375c499e32d265feea5895d59da78db1c89.1626791739.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1626791739.git.fdmanana@suse.com>
References: <cover.1626791739.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

In commit 351cbf6e4410e7 ("btrfs: use nofs allocations for running delayed
items") we wrapped all btree updates when running delayed items with
memalloc_nofs_save() and memalloc_nofs_restore(), due to a lock inversion
detected by lockdep involving reclaim and the mutex of delayed nodes.

The problem is because the ref verify tool does some memory allocations
with GFP_KERNEL, which can trigger reclaim and reclaim can trigger inode
eviction, which requires locking the mutex of an inode's delayed node.
On the other hand the ref verify tool is called when allocating metadata
extents as part of operations that modify a btree, which is a problem when
running delayed nodes, where we do btree updates while holding the mutex
of a delayed node. This is what caused the lockdep warning.

Instead of wrapping every btree update when running delayed nodes, change
the ref verify tool to never do GFP_KERNEL allocations, because:

1) We get less repeated code, which at the moment does not even have a
   comment mentioning why we need to setup the NOFS context, which is a
   recommended good practice as mentioned at
   Documentation/core-api/gfp_mask-from-fs-io.rst

2) The ref verify tool is something meant only for debugging and not
   something that should be enabled on non-debug / non-development
   kernels;

3) We may have yet more places outside delayed-inode.c where we have
   similar problem: doing btree updates while holding some lock and
   then having the GFP_KERNEL memory allocations, from the ref verify
   tool, trigger reclaim and trying again to acquire the same lock
   through the reclaim path.
   Or we could get more such cases in the future, therefore this change
   prevents getting into similar cases when using the ref verify tool.

Curiously most of the memory allocations done by the ref verify tool
were already using GFP_NOFS, except a few ones for no apparent reason.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/delayed-inode.c | 12 ------------
 fs/btrfs/ref-verify.c    | 10 +++++-----
 2 files changed, 5 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 7deb26604a56..7a9070a80fe2 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -6,7 +6,6 @@
 
 #include <linux/slab.h>
 #include <linux/iversion.h>
-#include <linux/sched/mm.h>
 #include "misc.h"
 #include "delayed-inode.h"
 #include "disk-io.h"
@@ -686,7 +685,6 @@ static int btrfs_insert_delayed_item(struct btrfs_trans_handle *trans,
 	const int max_size = BTRFS_LEAF_DATA_SIZE(root->fs_info);
 	int total_size;
 	int nitems;
-	unsigned int nofs_flag;
 	char *ins_data = NULL;
 	struct btrfs_key *ins_keys;
 	u32 *ins_sizes;
@@ -735,10 +733,8 @@ static int btrfs_insert_delayed_item(struct btrfs_trans_handle *trans,
 		}
 	}
 
-	nofs_flag = memalloc_nofs_save();
 	ret = btrfs_insert_empty_items(trans, root, path, ins_keys, ins_sizes,
 				       nitems);
-	memalloc_nofs_restore(nofs_flag);
 	if (ret)
 		goto out;
 
@@ -860,7 +856,6 @@ static int btrfs_delete_delayed_items(struct btrfs_trans_handle *trans,
 				      struct btrfs_delayed_node *node)
 {
 	struct btrfs_delayed_item *curr, *prev;
-	unsigned int nofs_flag;
 	int ret = 0;
 
 do_again:
@@ -869,9 +864,7 @@ static int btrfs_delete_delayed_items(struct btrfs_trans_handle *trans,
 	if (!curr)
 		goto delete_fail;
 
-	nofs_flag = memalloc_nofs_save();
 	ret = btrfs_search_slot(trans, root, &curr->key, path, -1, 1);
-	memalloc_nofs_restore(nofs_flag);
 	if (ret < 0)
 		goto delete_fail;
 	else if (ret > 0) {
@@ -940,7 +933,6 @@ static int __btrfs_update_delayed_inode(struct btrfs_trans_handle *trans,
 	struct btrfs_key key;
 	struct btrfs_inode_item *inode_item;
 	struct extent_buffer *leaf;
-	unsigned int nofs_flag;
 	int mod;
 	int ret;
 
@@ -953,9 +945,7 @@ static int __btrfs_update_delayed_inode(struct btrfs_trans_handle *trans,
 	else
 		mod = 1;
 
-	nofs_flag = memalloc_nofs_save();
 	ret = btrfs_lookup_inode(trans, root, path, &key, mod);
-	memalloc_nofs_restore(nofs_flag);
 	if (ret > 0)
 		ret = -ENOENT;
 	if (ret < 0)
@@ -1012,9 +1002,7 @@ static int __btrfs_update_delayed_inode(struct btrfs_trans_handle *trans,
 	key.type = BTRFS_INODE_EXTREF_KEY;
 	key.offset = -1;
 
-	nofs_flag = memalloc_nofs_save();
 	ret = btrfs_search_slot(trans, root, &key, path, -1, 1);
-	memalloc_nofs_restore(nofs_flag);
 	if (ret < 0)
 		goto err_out;
 	ASSERT(ret);
diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
index 8e026de74c44..d2062d5f71dd 100644
--- a/fs/btrfs/ref-verify.c
+++ b/fs/btrfs/ref-verify.c
@@ -264,8 +264,8 @@ static struct block_entry *add_block_entry(struct btrfs_fs_info *fs_info,
 	struct block_entry *be = NULL, *exist;
 	struct root_entry *re = NULL;
 
-	re = kzalloc(sizeof(struct root_entry), GFP_KERNEL);
-	be = kzalloc(sizeof(struct block_entry), GFP_KERNEL);
+	re = kzalloc(sizeof(struct root_entry), GFP_NOFS);
+	be = kzalloc(sizeof(struct block_entry), GFP_NOFS);
 	if (!be || !re) {
 		kfree(re);
 		kfree(be);
@@ -313,7 +313,7 @@ static int add_tree_block(struct btrfs_fs_info *fs_info, u64 ref_root,
 	struct root_entry *re;
 	struct ref_entry *ref = NULL, *exist;
 
-	ref = kmalloc(sizeof(struct ref_entry), GFP_KERNEL);
+	ref = kmalloc(sizeof(struct ref_entry), GFP_NOFS);
 	if (!ref)
 		return -ENOMEM;
 
@@ -358,7 +358,7 @@ static int add_shared_data_ref(struct btrfs_fs_info *fs_info,
 	struct block_entry *be;
 	struct ref_entry *ref;
 
-	ref = kzalloc(sizeof(struct ref_entry), GFP_KERNEL);
+	ref = kzalloc(sizeof(struct ref_entry), GFP_NOFS);
 	if (!ref)
 		return -ENOMEM;
 	be = add_block_entry(fs_info, bytenr, num_bytes, 0);
@@ -393,7 +393,7 @@ static int add_extent_data_ref(struct btrfs_fs_info *fs_info,
 	u64 offset = btrfs_extent_data_ref_offset(leaf, dref);
 	u32 num_refs = btrfs_extent_data_ref_count(leaf, dref);
 
-	ref = kzalloc(sizeof(struct ref_entry), GFP_KERNEL);
+	ref = kzalloc(sizeof(struct ref_entry), GFP_NOFS);
 	if (!ref)
 		return -ENOMEM;
 	be = add_block_entry(fs_info, bytenr, num_bytes, ref_root);
-- 
2.30.2

