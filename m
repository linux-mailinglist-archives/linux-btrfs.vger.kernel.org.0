Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 819EA727CC4
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jun 2023 12:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236134AbjFHK2F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jun 2023 06:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236135AbjFHK17 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jun 2023 06:27:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99BF72D40
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 03:27:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7912860A13
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 10:27:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65366C433D2
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 10:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686220077;
        bh=F6NCKbWTylZTBxvSV+7sfqnUNpGAk39rts4u9/rlljQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ow5iTGIeK32jH0r7FhyYoEuDJPqk+t97t0wvTfr28Kwlc2X9e3yx5TA2VK3vfGZjq
         npx04NcEZ9w1Fs4athvmhofA27r1gU6nTSnYLqKc4mscKFIMwm29VQd8HyNKc3OyQ7
         KPeSPEQi2sYFWHtk1lpJ0d71gi81Vyc8Kmwf+d6/7IgHd9E4L/TEviapdUc2P15S9M
         w79rFuWsLAvpWYEdbR8ZpsIhW6z1EczrQnUD3DNC3dk7P6r7JfpPsWQbux/J+flcod
         mjYJ1luufA8xDKFUv3LJKXnjAx2FjHhwDsbzJW8CshQYBSC1dVJStAvoLd92kMbkFQ
         C4q7AsKDE4r2Q==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 05/13] btrfs: do not BUG_ON() on tree mod log failure at balance_level()
Date:   Thu,  8 Jun 2023 11:27:41 +0100
Message-Id: <50c7ecdff6b635a89bfd2bf9a2ee9a252c7855bb.1686219923.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1686219923.git.fdmanana@suse.com>
References: <cover.1686219923.git.fdmanana@suse.com>
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

At balance_level(), instead of doing a BUG_ON() in case we fail to record
tree mod log operations, do a transaction abort and return the error to
the callers. There's really no need for the BUG_ON() as we can release
all resources in this context, and we have to abort because other future
tree searches that use the tree mod log (btrfs_search_old_slot()) may get
inconsistent results if other operations modify the tree after that
failure and before the tree mod log based search.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index d6c29564ce49..d60b28c6bd1b 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -1054,7 +1054,12 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 		}
 
 		ret = btrfs_tree_mod_log_insert_root(root->node, child, true);
-		BUG_ON(ret < 0);
+		if (ret < 0) {
+			btrfs_tree_unlock(child);
+			free_extent_buffer(child);
+			btrfs_abort_transaction(trans, ret);
+			goto enospc;
+		}
 		rcu_assign_pointer(root->node, child);
 
 		add_root_to_dirty_list(root);
@@ -1142,7 +1147,10 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 			btrfs_node_key(right, &right_key, 0);
 			ret = btrfs_tree_mod_log_insert_key(parent, pslot + 1,
 					BTRFS_MOD_LOG_KEY_REPLACE);
-			BUG_ON(ret < 0);
+			if (ret < 0) {
+				btrfs_abort_transaction(trans, ret);
+				goto enospc;
+			}
 			btrfs_set_node_key(parent, &right_key, pslot + 1);
 			btrfs_mark_buffer_dirty(parent);
 		}
@@ -1188,7 +1196,10 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 		btrfs_node_key(mid, &mid_key, 0);
 		ret = btrfs_tree_mod_log_insert_key(parent, pslot,
 						    BTRFS_MOD_LOG_KEY_REPLACE);
-		BUG_ON(ret < 0);
+		if (ret < 0) {
+			btrfs_abort_transaction(trans, ret);
+			goto enospc;
+		}
 		btrfs_set_node_key(parent, &mid_key, pslot);
 		btrfs_mark_buffer_dirty(parent);
 	}
-- 
2.34.1

