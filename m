Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543DB614F02
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 17:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbiKAQQD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Nov 2022 12:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbiKAQQB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Nov 2022 12:16:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98F11C903
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 09:16:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 560BE6118E
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 16:16:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43080C433B5
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 16:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667319359;
        bh=5ww87WV0U+VPLGbOTyOPqfdHGHsocTgBs4KfbOxmIFQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=eNsBEDjprZIbTexgk1sny0COSKoxO9zCGSootJ8kXya5n4+yYW+gzR4lbkB+czrL4
         421ZVE1+MTeirMC3lyML3FB9TwSdV3qmCd/ZCmCMLuNUapBcTCKucDz4lEH0Sv9rTd
         kphWAKrmEQcKqnJvip7ubTMHLS0/O3cDGChyfLLVcCNaXAirqAHFiDKBVega6wwEeb
         X4Fsr+mUrEq1twjssANcV0TMT0sX00gtQk8QHjhl6encJn5X0IH1+M33jezVoIZY+E
         97eqw6KyaPuEM6BEqqn7YkFM7MFn3n5I5UXjv6CVNFulsF4IbYrM7xPsf+hk2aedzL
         7pBiYeNXNuQbA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 02/18] btrfs: fix inode list leak during backref walking at find_parent_nodes()
Date:   Tue,  1 Nov 2022 16:15:38 +0000
Message-Id: <ac9eff8f6c52fdc8b723a3faee23525e93a456c8.1667315100.git.fdmanana@suse.com>
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

During backref walking, at find_parent_nodes(), if we are dealing with a
data extent and we get an error while resolving the indirect backrefs, at
resolve_indirect_refs(), or in the while loop that iterates over the refs
in the direct refs rbtree, we end up leaking the inode lists attached to
the direct refs we have in the direct refs rbtree that were not yet added
to the refs ulist passed as argument to find_parent_nodes(). Since they
were not yet added to the refs ulist and prelim_release() does not free
the lists, on error the caller can only free the lists attached to the
refs that were added to the refs ulist, all the remaining refs get their
inode lists never freed, therefore leaking their memory.

Fix this by having prelim_release() always free any attached inode list
to each ref found in the rbtree, and have find_parent_nodes() set the
ref's inode list to NULL once it transfers ownership of the inode list
to a ref added to the refs ulist passed to find_parent_nodes().

Fixes: 86d5f9944252 ("btrfs: convert prelimary reference tracking to use rbtrees")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/backref.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 82c4cad0ca00..04cb608e7cfb 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -319,8 +319,10 @@ static void prelim_release(struct preftree *preftree)
 	struct prelim_ref *ref, *next_ref;
 
 	rbtree_postorder_for_each_entry_safe(ref, next_ref,
-					     &preftree->root.rb_root, rbnode)
+					     &preftree->root.rb_root, rbnode) {
+		free_inode_elem_list(ref->inode_list);
 		free_pref(ref);
+	}
 
 	preftree->root = RB_ROOT_CACHED;
 	preftree->count = 0;
@@ -1596,6 +1598,12 @@ static int find_parent_nodes(struct btrfs_trans_handle *trans,
 				if (ret < 0)
 					goto out;
 				ref->inode_list = eie;
+				/*
+				 * We transferred the list ownership to the ref,
+				 * so set to NULL to avoid a double free in case
+				 * an error happens after this.
+				 */
+				eie = NULL;
 			}
 			ret = ulist_add_merge_ptr(refs, ref->parent,
 						  ref->inode_list,
@@ -1621,6 +1629,14 @@ static int find_parent_nodes(struct btrfs_trans_handle *trans,
 				eie->next = ref->inode_list;
 			}
 			eie = NULL;
+			/*
+			 * We have transferred the inode list ownership from
+			 * this ref to the ref we added to the 'refs' ulist.
+			 * So set this ref's inode list to NULL to avoid
+			 * use-after-free when our caller uses it or double
+			 * frees in case an error happens before we return.
+			 */
+			ref->inode_list = NULL;
 		}
 		cond_resched();
 	}
-- 
2.35.1

