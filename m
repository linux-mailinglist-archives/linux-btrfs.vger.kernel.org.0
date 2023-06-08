Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72DD2727CC5
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jun 2023 12:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236144AbjFHK2H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jun 2023 06:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236125AbjFHK2B (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jun 2023 06:28:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CFD7272A
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 03:27:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6CEC561245
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 10:27:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59EF4C433EF
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 10:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686220078;
        bh=1s/bKYSfW/LHRV9NZmgRiG/koi1SFLbh9cgOb+dK+UU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=eAdx8/TF1HjapufOnaxV0au6jl9FLoumBM3Lyjrro94iZLEvB+4Y/zWdq9iepDDq0
         Fnap8aXPh4Ls+Tm6rfrLPrcvB6Azsn/gCcfa+hOwxTb1UugAgFz5ekmaslok1WSYso
         6cjUQJqoYGSWS8xldRB0Va/UfB9Jw4MCasDm9fmnH3gW5fiugIcfk8nrBwQXuNABrJ
         DJIewyq8/Rorc/6BSDls6eGtdTrDZNNGsLfApIVbTr3VsKRaQd1Z032bhefQ2gemcy
         Kf5oM/L/8sSviIr8QPq5GlPNdIxMkxrXIGhOVcGD9Uv+nvT/MhYkOX55wwDEfuKcra
         fdoMdQ/BpE7yQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 06/13] btrfs: rename enospc label to out at balance_level()
Date:   Thu,  8 Jun 2023 11:27:42 +0100
Message-Id: <5606a37e42c46ecd751f9312862ff6a773e5f1ed.1686219923.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1686219923.git.fdmanana@suse.com>
References: <cover.1686219923.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

At balance_level() we have this 'enospc' label where we jump to in case
we get an error at several places. However that error is certainly not
-ENOSPC in call cases, it can be -EIO or -ENOMEM when reading a child
extent buffer for example, or -ENOMEM when trying to record tree mod log
operations. So to make this less confusing, rename the label to 'out'.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index d60b28c6bd1b..e98f9e205e25 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -1041,7 +1041,7 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 		if (IS_ERR(child)) {
 			ret = PTR_ERR(child);
 			btrfs_handle_fs_error(fs_info, ret, NULL);
-			goto enospc;
+			goto out;
 		}
 
 		btrfs_tree_lock(child);
@@ -1050,7 +1050,7 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 		if (ret) {
 			btrfs_tree_unlock(child);
 			free_extent_buffer(child);
-			goto enospc;
+			goto out;
 		}
 
 		ret = btrfs_tree_mod_log_insert_root(root->node, child, true);
@@ -1058,7 +1058,7 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 			btrfs_tree_unlock(child);
 			free_extent_buffer(child);
 			btrfs_abort_transaction(trans, ret);
-			goto enospc;
+			goto out;
 		}
 		rcu_assign_pointer(root->node, child);
 
@@ -1087,7 +1087,7 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 		if (IS_ERR(left)) {
 			ret = PTR_ERR(left);
 			left = NULL;
-			goto enospc;
+			goto out;
 		}
 
 		__btrfs_tree_lock(left, BTRFS_NESTING_LEFT);
@@ -1096,7 +1096,7 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 				       BTRFS_NESTING_LEFT_COW);
 		if (wret) {
 			ret = wret;
-			goto enospc;
+			goto out;
 		}
 	}
 
@@ -1105,7 +1105,7 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 		if (IS_ERR(right)) {
 			ret = PTR_ERR(right);
 			right = NULL;
-			goto enospc;
+			goto out;
 		}
 
 		__btrfs_tree_lock(right, BTRFS_NESTING_RIGHT);
@@ -1114,7 +1114,7 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 				       BTRFS_NESTING_RIGHT_COW);
 		if (wret) {
 			ret = wret;
-			goto enospc;
+			goto out;
 		}
 	}
 
@@ -1149,7 +1149,7 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 					BTRFS_MOD_LOG_KEY_REPLACE);
 			if (ret < 0) {
 				btrfs_abort_transaction(trans, ret);
-				goto enospc;
+				goto out;
 			}
 			btrfs_set_node_key(parent, &right_key, pslot + 1);
 			btrfs_mark_buffer_dirty(parent);
@@ -1168,12 +1168,12 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 		if (!left) {
 			ret = -EROFS;
 			btrfs_handle_fs_error(fs_info, ret, NULL);
-			goto enospc;
+			goto out;
 		}
 		wret = balance_node_right(trans, mid, left);
 		if (wret < 0) {
 			ret = wret;
-			goto enospc;
+			goto out;
 		}
 		if (wret == 1) {
 			wret = push_node_left(trans, left, mid, 1);
@@ -1198,7 +1198,7 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 						    BTRFS_MOD_LOG_KEY_REPLACE);
 		if (ret < 0) {
 			btrfs_abort_transaction(trans, ret);
-			goto enospc;
+			goto out;
 		}
 		btrfs_set_node_key(parent, &mid_key, pslot);
 		btrfs_mark_buffer_dirty(parent);
@@ -1225,7 +1225,7 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 	if (orig_ptr !=
 	    btrfs_node_blockptr(path->nodes[level], path->slots[level]))
 		BUG();
-enospc:
+out:
 	if (right) {
 		btrfs_tree_unlock(right);
 		free_extent_buffer(right);
-- 
2.34.1

