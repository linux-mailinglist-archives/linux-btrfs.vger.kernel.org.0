Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 368CA4289E1
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Oct 2021 11:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235605AbhJKJpI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Oct 2021 05:45:08 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:51750 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235573AbhJKJpH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Oct 2021 05:45:07 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2558E22077;
        Mon, 11 Oct 2021 09:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1633945387; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2urgIGCLsdxqT2bjEpMEwxdaCS/hpRcMi72EEVjHWNo=;
        b=TJ3awHmHzUtUxBCfgEFjs6/Yp+3N5/SKsPeDB3r5K+n/9c0LQECtkumDBxQp0L9b8hxb6b
        xbQI60J+jFK0Dwln7uCuPEv2aV2Em4siekUA1a7n/eAx6uohDoc19t2pNaUcyWzN3h47uM
        89ngSZWJLYxBFf6PKLefc7XBCCiRXFk=
Received: from adam-pc.lan (unknown [10.163.34.62])
        by relay2.suse.de (Postfix) with ESMTP id EA4EFA3C41;
        Mon, 11 Oct 2021 09:43:05 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     FireFish5000 <firefish5000@gmail.com>
Subject: [PATCH 2/3] btrfs-progs: mkfs: recow all tree blocks properly
Date:   Mon, 11 Oct 2021 17:42:59 +0800
Message-Id: <20211011094300.97504-3-wqu@suse.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211011094300.97504-1-wqu@suse.com>
References: <20211011094300.97504-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
Since btrfs-progs v5.14, mkfs.btrfs no longer cleans up the temporary
SINGLE metadata chunks if "-R free-space-tree" is specified:

 $ mkfs.btrfs  -f -R free-space-tree -m dup -d dup /dev/test/test
 $ btrfs ins dump-tree -t chunk /dev/test/test | grep "type METADATA"
		length 8388608 owner 2 stripe_len 65536 type METADATA
		length 268435456 owner 2 stripe_len 65536 type METADATA|DUP

[CAUSE]
Since commit 4b6cf2a3eb78 ("btrfs-progs: mkfs: generate free space tree
at make_btrfs() time"), free space tree is created when the temporary
btrfs image is created.

This behavior itself has no problem at all.

The problem happens when "-m DUP -d DUP" (or other profiles) is
specified.

This makes btrfs to create extra chunks, enlarging free space tree so
that it can be as high as level 1.

During mkfs, we rely on recow_roots() to re-CoW all tree blocks to the
newly allocated chunks.

But __recow_root() can only handle tree root at level 0, as it forces
root node to be CoWed, not bothering the children leaves/nodes.

This makes part of the free space cache tree still live on the old
temporary chunks, leaving later cleanup_temp_chunks() unable to delete
temporary SINGLE chunks.

[FIX]
Rework __recow_root() to do a proper CoW of the whole tree.

But above rework is not enough, as if a free space tree block is
allocated during current transaction, but before new chunks added.
Then the reworked __recow_root() can't CoW it, as btrfs_search_slot()
won't CoW a tree block allocated in current transaction.

So this patch will also commit current transaction before calling
recow_roots(), to force us to re-cow all tree blocks.

This shouldn't be a problem, as at the time of calling, we should have
less than a dozen tree blocks, thus there won't be a performance impact.

Reported-by: FireFish5000 <firefish5000@gmail.com>
Fixes: 4b6cf2a3eb78 ("btrfs-progs: mkfs: generate free space tree at make_btrfs() time")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 mkfs/main.c | 87 ++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 76 insertions(+), 11 deletions(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index 4d50bd25c440..f8a1becce9bf 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -209,21 +209,59 @@ err:
 }
 
 static int __recow_root(struct btrfs_trans_handle *trans,
-			 struct btrfs_root *root)
+			struct btrfs_root *root)
 {
-	struct extent_buffer *tmp;
+	struct btrfs_path path;
+	struct btrfs_key key;
 	int ret;
 
-	if (trans->transid != btrfs_root_generation(&root->root_item)) {
-		extent_buffer_get(root->node);
-		ret = __btrfs_cow_block(trans, root, root->node,
-					NULL, 0, &tmp, 0, 0);
-		if (ret)
-			return ret;
-		free_extent_buffer(tmp);
-	}
+	btrfs_init_path(&path);
+	key.objectid = 0;
+	key.type = 0;
+	key.offset = 0;
 
-	return 0;
+	/* Get a path to the most-left leaves */
+	ret = btrfs_search_slot(NULL, root, &key, &path, 0, 0);
+	if (ret < 0)
+		return ret;
+
+	while (true) {
+		struct btrfs_key found_key;
+
+		/*
+		 * Our parent nodes must be no newer than the leaf, thus
+		 * if the leaf is as new as the trans, no need to re-cow.
+		 */
+		if (btrfs_header_generation(path.nodes[0]) == trans->transid)
+			goto next;
+
+		/*
+		 * Grab the key of current tree block and do a CoW search to
+		 * the current tree block.
+		 */
+		btrfs_item_key_to_cpu(path.nodes[0], &key, 0);
+		btrfs_release_path(&path);
+
+		/* This will ensure this leaf and all its parent get CoWed */
+		ret = btrfs_search_slot(trans, root, &key, &path, 0, 1);
+		if (ret < 0)
+			goto out;
+		ret = 0;
+		btrfs_item_key_to_cpu(path.nodes[0], &found_key, 0);
+		ASSERT(btrfs_comp_cpu_keys(&key, &found_key) == 0);
+
+next:
+		ret = btrfs_next_sibling_tree_block(trans->fs_info, &path);
+		if (ret < 0)
+			goto out;
+		if (ret > 0) {
+			ret = 0;
+			goto out;
+		}
+	}
+out:
+	btrfs_release_path(&path);
+	return ret;
 }
 
 static int recow_roots(struct btrfs_trans_handle *trans,
@@ -1472,6 +1510,33 @@ raid_groups:
 		goto out;
 	}
 
+	/*
+	 * Commit current trans so we can cow all existing tree blocks
+	 * to newly created raid groups.
+	 * As currently we use btrfs_search_slot() to CoW tree blocks in
+	 * recow_roots(), if a tree block is already modified in current trans,
+	 * it won't be re-CoWed, thus it will stay in temporary chunks.
+	 */
+	ret = btrfs_commit_transaction(trans, root);
+	if (ret) {
+		errno = -ret;
+		error("unable to commit transaction before recowing trees: %m");
+		goto out;
+	}
+	trans = btrfs_start_transaction(root, 1);
+	if (IS_ERR(trans)) {
+		errno = -PTR_ERR(trans);
+		error("failed to start transaction: %m");
+		goto error;
+	}
+	/* CoW all tree blocks to newly created chunks */
+	ret = recow_roots(trans, root);
+	if (ret) {
+		errno = -ret;
+		error("unable to CoW tree blocks to new profiles: %m");
+		goto out;
+	}
+
 	ret = create_data_reloc_tree(trans);
 	if (ret) {
 		error("unable to create data reloc tree: %d", ret);
-- 
2.33.0

