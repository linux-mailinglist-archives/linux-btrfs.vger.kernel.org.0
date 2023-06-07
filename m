Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4897269B4
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jun 2023 21:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233184AbjFGTY6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Jun 2023 15:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232430AbjFGTYs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Jun 2023 15:24:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633081FD5
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jun 2023 12:24:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 434D9636CF
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jun 2023 19:24:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CAFFC433EF
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jun 2023 19:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686165886;
        bh=YDFZ3h3wrfBYXl8pD7AAaf2SYaAHJV+vJYQQodIkngs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=WxEQqs1j71QCCQt9BIposvR/NZUyHkFsOCFlmPN3rc4j3lYwNEhc4nuTpJE8hG7Aa
         xLayoRPzslI7T5rHeovbY840AuX40VEXTgZynkoIO+U6ZKFvtoX+/NFVo55vUg82Ap
         lV47UY9n9S0Y2mViXLOKzztU2N9FJ70JOqGCSsL7v5ELY2UnSlKtIKLFwxAn5xhYY0
         0JREWLnTYYbRvX9NvgznUmeWSzO4QMbrw0XHsIOS3dOxY3iUACaJtXB+zZ1VhZd0kf
         tCRvM39vJH7an/bjnyRZwvnR9yKg/7Bw6n7jjiK8jYZsdjSzCWRp+C1fPOQ4l6DWCP
         AAY022PM0Mz7g==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 06/13] btrfs: rename enospc label to out at balance_level()
Date:   Wed,  7 Jun 2023 20:24:30 +0100
Message-Id: <4da7393afeffff23420fb2eafa27db99f882c39c.1686164811.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1686164789.git.fdmanana@suse.com>
References: <cover.1686164789.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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

