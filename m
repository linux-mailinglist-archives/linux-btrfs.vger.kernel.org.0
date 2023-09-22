Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6417AB9EB
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Sep 2023 21:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233498AbjIVTRJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Sep 2023 15:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233435AbjIVTRI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Sep 2023 15:17:08 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DB3A3
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 12:17:02 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0EDCE1FE32;
        Fri, 22 Sep 2023 19:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1695410221; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CDKXQYhUFrKT4JamsqM+T05+FNHofA1GimhAld15Nts=;
        b=L9P0Udse+IQABlUWePB8rb9Q7Eoe+cG+POykbVOmnU60ZSSwO6gWT2S2xp9/U/NqN9KLKq
        +NlhC7xeEB5UtfIt6NQd7v3xwNWe/Ep4BYJXilK/dkFdaCFvOOWYQda5aN9JbzSWUgbE/a
        vZgS4k5feA2iWOijdRNRfTWoOW2IOAc=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id E968B2C142;
        Fri, 22 Sep 2023 19:17:00 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E02E4DA832; Fri, 22 Sep 2023 21:10:26 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 2/5] btrfs: use on-stack variable for block reserve in btrfs_truncate
Date:   Fri, 22 Sep 2023 21:10:26 +0200
Message-ID: <e8450ead2688bb60026c15144b3fc5134a9e8631.1695408280.git.dsterba@suse.com>
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

We can avoid potential memory allocation failure in btrfs_truncate as
the block reserve lifetime is limited to the scope of the function. This
requires +48 bytes on stack.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/inode.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index e1cb7583016d..780537abeba7 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8246,7 +8246,7 @@ static int btrfs_truncate(struct btrfs_inode *inode, bool skip_writeback)
 	};
 	struct btrfs_root *root = inode->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
-	struct btrfs_block_rsv *rsv;
+	struct btrfs_block_rsv rsv;
 	int ret;
 	struct btrfs_trans_handle *trans;
 	u64 mask = fs_info->sectorsize - 1;
@@ -8288,11 +8288,9 @@ static int btrfs_truncate(struct btrfs_inode *inode, bool skip_writeback)
 	 * 2) fs_info->trans_block_rsv - this will have 1 items worth left for
 	 * updating the inode.
 	 */
-	rsv = btrfs_alloc_block_rsv(fs_info, BTRFS_BLOCK_RSV_TEMP);
-	if (!rsv)
-		return -ENOMEM;
-	rsv->size = min_size;
-	rsv->failfast = true;
+	btrfs_init_metadata_block_rsv(fs_info, &rsv, BTRFS_BLOCK_RSV_TEMP);
+	rsv.size = min_size;
+	rsv.failfast = true;
 
 	/*
 	 * 1 for the truncate slack space
@@ -8305,7 +8303,7 @@ static int btrfs_truncate(struct btrfs_inode *inode, bool skip_writeback)
 	}
 
 	/* Migrate the slack space for the truncate to our reserve */
-	ret = btrfs_block_rsv_migrate(&fs_info->trans_block_rsv, rsv,
+	ret = btrfs_block_rsv_migrate(&fs_info->trans_block_rsv, &rsv,
 				      min_size, false);
 	/*
 	 * We have reserved 2 metadata units when we started the transaction and
@@ -8317,7 +8315,7 @@ static int btrfs_truncate(struct btrfs_inode *inode, bool skip_writeback)
 		goto out;
 	}
 
-	trans->block_rsv = rsv;
+	trans->block_rsv = &rsv;
 
 	while (1) {
 		struct extent_state *cached_state = NULL;
@@ -8360,9 +8358,9 @@ static int btrfs_truncate(struct btrfs_inode *inode, bool skip_writeback)
 			break;
 		}
 
-		btrfs_block_rsv_release(fs_info, rsv, -1, NULL);
+		btrfs_block_rsv_release(fs_info, &rsv, -1, NULL);
 		ret = btrfs_block_rsv_migrate(&fs_info->trans_block_rsv,
-					      rsv, min_size, false);
+					      &rsv, min_size, false);
 		/*
 		 * We have reserved 2 metadata units when we started the
 		 * transaction and min_size matches 1 unit, so this should never
@@ -8371,7 +8369,7 @@ static int btrfs_truncate(struct btrfs_inode *inode, bool skip_writeback)
 		if (WARN_ON(ret))
 			break;
 
-		trans->block_rsv = rsv;
+		trans->block_rsv = &rsv;
 	}
 
 	/*
@@ -8409,7 +8407,7 @@ static int btrfs_truncate(struct btrfs_inode *inode, bool skip_writeback)
 		btrfs_btree_balance_dirty(fs_info);
 	}
 out:
-	btrfs_free_block_rsv(fs_info, rsv);
+	btrfs_block_rsv_release(fs_info, &rsv, (u64)-1, NULL);
 	/*
 	 * So if we truncate and then write and fsync we normally would just
 	 * write the extents that changed, which is a problem if we need to
-- 
2.41.0

