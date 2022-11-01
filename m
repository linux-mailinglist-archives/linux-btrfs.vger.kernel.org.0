Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1444D614EFE
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 17:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbiKAQQI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Nov 2022 12:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbiKAQQF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Nov 2022 12:16:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E9F1C431
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 09:16:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3100FB81E25
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 16:16:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D55EC433C1
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 16:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667319358;
        bh=tDAA8mxKthMiBQmk7+y+rLW7gD/lsOxJMvLAyvkrj9s=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=mlJNDStjU0X9QVcPG6q9E6P6Sz4ZDElUwuLw1cHkBj9bLXHhJg3N/cZBlCIqI+aKJ
         gBTxRDOhR5gRo/nZYsZQ6kj0fJauVPajn4+YvIlAThHpIdI534KXqiR8mPb8AMW78L
         bPdtmDDuRdLHi6NGzyzVojK2KC8DwloChAs1jic6Dg5rK4ru3cGjm3OiHrLWsDNLPS
         QpIFnHdhkE4SLjC/IPA8d5Amrd8bC5uZbljvBPB6Upx+GGkPCq6UMwBJhJ/ydmb3du
         ypB+qTaJJ+6bWcHFxSklSUt3VxszkUip+VPi9UFzCWulF407VnF+6A6Ebusd0k+8Ym
         teLOv8nR0Ae5w==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 01/18] btrfs: fix inode list leak during backref walking at resolve_indirect_refs()
Date:   Tue,  1 Nov 2022 16:15:37 +0000
Message-Id: <87e27f27fb2ebf760e574f97fd2d2f7d37f50350.1667315100.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1667315100.git.fdmanana@suse.com>
References: <cover.1667315100.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

During backref walking, at resolve_indirect_refs(), if we get an error
we jump to the 'out' label and call ulist_free() on the 'parents' ulist,
which frees all the elements in the ulist - however that does not free
any inode lists that may be attached to elements, through the 'aux' field
of a ulist node, so we end up leaking lists if we have any attached to
the unodes.

Fix this by calling free_leaf_list() instead of ulist_free() when we exit
from resolve_indirect_refs(). The static function free_leaf_list() is
moved up for this to be possible and it's slightly simplified by removing
unnecessary code.

Fixes: 3301958b7c1d ("Btrfs: add inodes before dropping the extent lock in find_all_leafs")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/backref.c | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 013c2c085229..82c4cad0ca00 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -678,6 +678,18 @@ unode_aux_to_inode_list(struct ulist_node *node)
 	return (struct extent_inode_elem *)(uintptr_t)node->aux;
 }
 
+static void free_leaf_list(struct ulist *ulist)
+{
+	struct ulist_node *node;
+	struct ulist_iterator uiter;
+
+	ULIST_ITER_INIT(&uiter);
+	while ((node = ulist_next(ulist, &uiter)))
+		free_inode_elem_list(unode_aux_to_inode_list(node));
+
+	ulist_free(ulist);
+}
+
 /*
  * We maintain three separate rbtrees: one for direct refs, one for
  * indirect refs which have a key, and one for indirect refs which do not
@@ -791,7 +803,11 @@ static int resolve_indirect_refs(struct btrfs_fs_info *fs_info,
 		cond_resched();
 	}
 out:
-	ulist_free(parents);
+	/*
+	 * We may have inode lists attached to refs in the parents ulist, so we
+	 * must free them before freeing the ulist and its refs.
+	 */
+	free_leaf_list(parents);
 	return ret;
 }
 
@@ -1621,24 +1637,6 @@ static int find_parent_nodes(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
-static void free_leaf_list(struct ulist *blocks)
-{
-	struct ulist_node *node = NULL;
-	struct extent_inode_elem *eie;
-	struct ulist_iterator uiter;
-
-	ULIST_ITER_INIT(&uiter);
-	while ((node = ulist_next(blocks, &uiter))) {
-		if (!node->aux)
-			continue;
-		eie = unode_aux_to_inode_list(node);
-		free_inode_elem_list(eie);
-		node->aux = 0;
-	}
-
-	ulist_free(blocks);
-}
-
 /*
  * Finds all leafs with a reference to the specified combination of bytenr and
  * offset. key_list_head will point to a list of corresponding keys (caller must
-- 
2.35.1

