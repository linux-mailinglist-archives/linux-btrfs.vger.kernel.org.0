Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84BE17AB9ED
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Sep 2023 21:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233585AbjIVTRO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Sep 2023 15:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbjIVTRN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Sep 2023 15:17:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A72FC1
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 12:17:06 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 589F11FE32;
        Fri, 22 Sep 2023 19:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1695410225; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ADM/ydSkfSm8Xv1cpzSwsGG0sUrJmoe1KGb0LqME8u4=;
        b=ICpAFZpg08PmFsHpCPEdxk0XRRoBxmB/H1BR4GPL/xrhuQz2xzVl9cwrzVLvSMLC/n7E2G
        yxkIlFHwDCDw2nR86vbGahI9jgLzzS5MZgrq40djrRYlI4B4MTDVmdvAGH+0e/C+7cmd7D
        H7cOnhNYlrl8eUzjEsPRk2djYb66Qw4=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 3EC2E2C142;
        Fri, 22 Sep 2023 19:17:05 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 42CD4DA832; Fri, 22 Sep 2023 21:10:31 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 4/5] btrfs: relocation: embed block reserve to struct reloc_control
Date:   Fri, 22 Sep 2023 21:10:31 +0200
Message-ID: <895699ead9c00b11c15183f0c315fcb8e8a67d3c.1695408280.git.dsterba@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1695408280.git.dsterba@suse.com>
References: <cover.1695408280.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The size of reloc_control is over 1500 bytes, we don't need to allocate
the block reserve separately with potential memory allocation failure,
as this would use the space in the same 2K slab.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/relocation.c | 46 ++++++++++++++++++++-----------------------
 1 file changed, 21 insertions(+), 25 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 903621a65244..cdadb4af58ea 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -139,7 +139,7 @@ struct reloc_control {
 	/* inode for moving data */
 	struct inode *data_inode;
 
-	struct btrfs_block_rsv *block_rsv;
+	struct btrfs_block_rsv block_rsv;
 
 	struct btrfs_backref_cache backref_cache;
 
@@ -880,7 +880,7 @@ int btrfs_init_reloc_root(struct btrfs_trans_handle *trans,
 
 	if (!trans->reloc_reserved) {
 		rsv = trans->block_rsv;
-		trans->block_rsv = rc->block_rsv;
+		trans->block_rsv = &rc->block_rsv;
 		clear_rsv = 1;
 	}
 	reloc_root = create_reloc_root(trans, root, root->root_key.objectid);
@@ -1751,7 +1751,7 @@ static noinline_for_stack int merge_reloc_root(struct reloc_control *rc,
 	memset(&next_key, 0, sizeof(next_key));
 
 	while (1) {
-		ret = btrfs_block_rsv_refill(fs_info, rc->block_rsv,
+		ret = btrfs_block_rsv_refill(fs_info, &rc->block_rsv,
 					     min_reserved,
 					     BTRFS_RESERVE_FLUSH_LIMIT);
 		if (ret)
@@ -1774,7 +1774,7 @@ static noinline_for_stack int merge_reloc_root(struct reloc_control *rc,
 		 * appropriately.
 		 */
 		reloc_root->last_trans = trans->transid;
-		trans->block_rsv = rc->block_rsv;
+		trans->block_rsv = &rc->block_rsv;
 
 		replaced = 0;
 		max_level = level;
@@ -1871,7 +1871,7 @@ int prepare_to_merge(struct reloc_control *rc, int err)
 again:
 	if (!err) {
 		num_bytes = rc->merging_rsv_size;
-		ret = btrfs_block_rsv_add(fs_info, rc->block_rsv, num_bytes,
+		ret = btrfs_block_rsv_add(fs_info, &rc->block_rsv, num_bytes,
 					  BTRFS_RESERVE_FLUSH_ALL);
 		if (ret)
 			err = ret;
@@ -1880,7 +1880,7 @@ int prepare_to_merge(struct reloc_control *rc, int err)
 	trans = btrfs_join_transaction(rc->extent_root);
 	if (IS_ERR(trans)) {
 		if (!err)
-			btrfs_block_rsv_release(fs_info, rc->block_rsv,
+			btrfs_block_rsv_release(fs_info, &rc->block_rsv,
 						num_bytes, NULL);
 		return PTR_ERR(trans);
 	}
@@ -1888,7 +1888,7 @@ int prepare_to_merge(struct reloc_control *rc, int err)
 	if (!err) {
 		if (num_bytes != rc->merging_rsv_size) {
 			btrfs_end_transaction(trans);
-			btrfs_block_rsv_release(fs_info, rc->block_rsv,
+			btrfs_block_rsv_release(fs_info, &rc->block_rsv,
 						num_bytes, NULL);
 			goto again;
 		}
@@ -2360,7 +2360,7 @@ static int reserve_metadata_space(struct btrfs_trans_handle *trans,
 
 	num_bytes = calcu_metadata_size(rc, node, 1) * 2;
 
-	trans->block_rsv = rc->block_rsv;
+	trans->block_rsv = &rc->block_rsv;
 	rc->reserved_bytes += num_bytes;
 
 	/*
@@ -2368,7 +2368,7 @@ static int reserve_metadata_space(struct btrfs_trans_handle *trans,
 	 * If we get an enospc just kick back -EAGAIN so we know to drop the
 	 * transaction and try to refill when we can flush all the things.
 	 */
-	ret = btrfs_block_rsv_refill(fs_info, rc->block_rsv, num_bytes,
+	ret = btrfs_block_rsv_refill(fs_info, &rc->block_rsv, num_bytes,
 				     BTRFS_RESERVE_FLUSH_LIMIT);
 	if (ret) {
 		tmp = fs_info->nodesize * RELOCATION_RESERVED_NODES;
@@ -2381,8 +2381,7 @@ static int reserve_metadata_space(struct btrfs_trans_handle *trans,
 		 * space for relocation and we will return earlier in
 		 * enospc case.
 		 */
-		rc->block_rsv->size = tmp + fs_info->nodesize *
-				      RELOCATION_RESERVED_NODES;
+		rc->block_rsv.size = tmp + fs_info->nodesize * RELOCATION_RESERVED_NODES;
 		return -EAGAIN;
 	}
 
@@ -3631,21 +3630,18 @@ int prepare_to_relocate(struct reloc_control *rc)
 	struct btrfs_trans_handle *trans;
 	int ret;
 
-	rc->block_rsv = btrfs_alloc_block_rsv(rc->extent_root->fs_info,
-					      BTRFS_BLOCK_RSV_TEMP);
-	if (!rc->block_rsv)
-		return -ENOMEM;
-
+	btrfs_init_metadata_block_rsv(rc->extent_root->fs_info, &rc->block_rsv,
+				      BTRFS_BLOCK_RSV_TEMP);
 	memset(&rc->cluster, 0, sizeof(rc->cluster));
 	rc->search_start = rc->block_group->start;
 	rc->extents_found = 0;
 	rc->nodes_relocated = 0;
 	rc->merging_rsv_size = 0;
 	rc->reserved_bytes = 0;
-	rc->block_rsv->size = rc->extent_root->fs_info->nodesize *
-			      RELOCATION_RESERVED_NODES;
+	rc->block_rsv.size = rc->extent_root->fs_info->nodesize *
+			     RELOCATION_RESERVED_NODES;
 	ret = btrfs_block_rsv_refill(rc->extent_root->fs_info,
-				     rc->block_rsv, rc->block_rsv->size,
+				     &rc->block_rsv, rc->block_rsv.size,
 				     BTRFS_RESERVE_FLUSH_ALL);
 	if (ret)
 		return ret;
@@ -3697,8 +3693,8 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 
 	while (1) {
 		rc->reserved_bytes = 0;
-		ret = btrfs_block_rsv_refill(fs_info, rc->block_rsv,
-					     rc->block_rsv->size,
+		ret = btrfs_block_rsv_refill(fs_info, &rc->block_rsv,
+					     rc->block_rsv.size,
 					     BTRFS_RESERVE_FLUSH_ALL);
 		if (ret) {
 			err = ret;
@@ -3818,7 +3814,7 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 	set_reloc_control(rc);
 
 	btrfs_backref_release_cache(&rc->backref_cache);
-	btrfs_block_rsv_release(fs_info, rc->block_rsv, (u64)-1, NULL);
+	btrfs_block_rsv_release(fs_info, &rc->block_rsv, (u64)-1, NULL);
 
 	/*
 	 * Even in the case when the relocation is cancelled, we should all go
@@ -3834,7 +3830,7 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 
 	rc->merge_reloc_tree = false;
 	unset_reloc_control(rc);
-	btrfs_block_rsv_release(fs_info, rc->block_rsv, (u64)-1, NULL);
+	btrfs_block_rsv_release(fs_info, &rc->block_rsv, (u64)-1, NULL);
 
 	/* get rid of pinned extents */
 	trans = btrfs_join_transaction(rc->extent_root);
@@ -3849,7 +3845,7 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 	ret = clean_dirty_subvols(rc);
 	if (ret < 0 && !err)
 		err = ret;
-	btrfs_free_block_rsv(fs_info, rc->block_rsv);
+	btrfs_block_rsv_release(fs_info, &rc->block_rsv, (u64)-1, NULL);
 	btrfs_free_path(path);
 	return err;
 }
@@ -4575,7 +4571,7 @@ int btrfs_reloc_post_snapshot(struct btrfs_trans_handle *trans,
 
 	if (rc->merge_reloc_tree) {
 		ret = btrfs_block_rsv_migrate(&pending->block_rsv,
-					      rc->block_rsv,
+					      &rc->block_rsv,
 					      rc->nodes_relocated, true);
 		if (ret)
 			return ret;
-- 
2.41.0

