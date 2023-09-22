Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3957F7AB9EA
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Sep 2023 21:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233427AbjIVTRG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Sep 2023 15:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbjIVTRG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Sep 2023 15:17:06 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C50A3
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 12:17:00 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D763F21878;
        Fri, 22 Sep 2023 19:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1695410218; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ryUa50DxN/TbWvWFs/y5mjXbkOJKwbmKSdhz3KC1qlE=;
        b=pdzjcyW5Sc4cQv7w5MLk/kWYF1ZczFa+v0ymOpemlSKwd1Npb9hehwtVE+SJVI7MGJstdi
        FE1UyO7RNANPEbK45Zbl7tz3Xn0yDtIP4ITWqGOpi4qqt0uGrQAP44D3FhkCWpEWiZEC2J
        bGIzHuJADlGM1njOfSuLyichpBLN6fo=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id BB6622C142;
        Fri, 22 Sep 2023 19:16:58 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B9CD2DA832; Fri, 22 Sep 2023 21:10:24 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 1/5] btrfs: use on-stack variable for block reserve in btrfs_evict_inode
Date:   Fri, 22 Sep 2023 21:10:24 +0200
Message-ID: <207744286f55daefc0a55f383224632d3e8b57fc.1695408280.git.dsterba@suse.com>
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

We can avoid potential memory allocation failure in btrfs_evict_inode as
the block reserve lifetime is limited to the scope of the function. This
requires +48 bytes on stack.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/inode.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 52576deda654..e1cb7583016d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5202,7 +5202,7 @@ void btrfs_evict_inode(struct inode *inode)
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct btrfs_trans_handle *trans;
 	struct btrfs_root *root = BTRFS_I(inode)->root;
-	struct btrfs_block_rsv *rsv = NULL;
+	struct btrfs_block_rsv rsv;
 	int ret;
 
 	trace_btrfs_inode_evict(inode);
@@ -5249,11 +5249,9 @@ void btrfs_evict_inode(struct inode *inode)
 	 */
 	btrfs_kill_delayed_inode_items(BTRFS_I(inode));
 
-	rsv = btrfs_alloc_block_rsv(fs_info, BTRFS_BLOCK_RSV_TEMP);
-	if (!rsv)
-		goto out;
-	rsv->size = btrfs_calc_metadata_size(fs_info, 1);
-	rsv->failfast = true;
+	btrfs_init_metadata_block_rsv(fs_info, &rsv, BTRFS_BLOCK_RSV_TEMP);
+	rsv.size = btrfs_calc_metadata_size(fs_info, 1);
+	rsv.failfast = true;
 
 	btrfs_i_size_write(BTRFS_I(inode), 0);
 
@@ -5265,11 +5263,11 @@ void btrfs_evict_inode(struct inode *inode)
 			.min_type = 0,
 		};
 
-		trans = evict_refill_and_join(root, rsv);
+		trans = evict_refill_and_join(root, &rsv);
 		if (IS_ERR(trans))
-			goto out;
+			goto out_release;
 
-		trans->block_rsv = rsv;
+		trans->block_rsv = &rsv;
 
 		ret = btrfs_truncate_inode_items(trans, root, &control);
 		trans->block_rsv = &fs_info->trans_block_rsv;
@@ -5281,7 +5279,7 @@ void btrfs_evict_inode(struct inode *inode)
 		 */
 		btrfs_btree_balance_dirty_nodelay(fs_info);
 		if (ret && ret != -ENOSPC && ret != -EAGAIN)
-			goto out;
+			goto out_release;
 		else if (!ret)
 			break;
 	}
@@ -5295,16 +5293,17 @@ void btrfs_evict_inode(struct inode *inode)
 	 * If it turns out that we are dropping too many of these, we might want
 	 * to add a mechanism for retrying these after a commit.
 	 */
-	trans = evict_refill_and_join(root, rsv);
+	trans = evict_refill_and_join(root, &rsv);
 	if (!IS_ERR(trans)) {
-		trans->block_rsv = rsv;
+		trans->block_rsv = &rsv;
 		btrfs_orphan_del(trans, BTRFS_I(inode));
 		trans->block_rsv = &fs_info->trans_block_rsv;
 		btrfs_end_transaction(trans);
 	}
 
+out_release:
+	btrfs_block_rsv_release(fs_info, &rsv, (u64)-1, NULL);
 out:
-	btrfs_free_block_rsv(fs_info, rsv);
 	/*
 	 * If we didn't successfully delete, the orphan item will still be in
 	 * the tree and we'll retry on the next mount. Again, we might also want
-- 
2.41.0

