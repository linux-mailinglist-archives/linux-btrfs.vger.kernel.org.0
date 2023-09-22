Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 359037AAFC0
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Sep 2023 12:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233403AbjIVKjd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Sep 2023 06:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233386AbjIVKj0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Sep 2023 06:39:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2948A99
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 03:39:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4902EC433C7
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 10:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695379159;
        bh=t+4l4VYPDQPCkXT9AyDHXwkMg0t3dQTXAgbiBuxQtVw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=gUFLNN+fuZ5aqseRuX6rpVFBBhl4z0/9gfpHgnUcPewTFmeXWoDRcHOH7NtXAby3s
         z8xVOLLOQ6iwzIR9I/kWouq4zADkdnGb+guA9q8SK5gKBL5kggOVI6joG3lNsx/3aA
         TGWBcKq/g8LN18r8AZ8nc2OwYkVOOEs7eoMQALI1yOJwmPZ0z6wgUnumuMYrPq7nXt
         XuqzYgL1qPLAkfj0AiC5vt9Sl/hfUSI4qb6u+Hjl9zpUZwSiPkqdhAxngpQNO53myM
         3q0h0shEAohCY3fQaqQitsaFMTJWyqwtviV2LyjDl/C/ScN6PlM5IxGpgupLdnptQ/
         JAn/jCPo/GxYg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 6/8] btrfs: make extent_io_tree_release() more efficient
Date:   Fri, 22 Sep 2023 11:39:07 +0100
Message-Id: <b8db1acd6c29941e4fffe3cfe604cb2dbb94f847.1695333278.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1695333278.git.fdmanana@suse.com>
References: <cover.1695333278.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Currently extent_io_tree_release() is a loop that keeps getting the first
node in the io tree, using rb_first() which is a loop that gets to the
leftmost node of the rbtree, and then for each node it calls rb_erase(),
which often requires rebalancing the rbtree.

We can make this more efficient by using
rbtree_postorder_for_each_entry_safe() to free each node without having
to delete it from the rbtree and without looping to get the first node.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-io-tree.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 700b84fc1588..f2372d6cd304 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -114,14 +114,12 @@ void extent_io_tree_init(struct btrfs_fs_info *fs_info,
  */
 void extent_io_tree_release(struct extent_io_tree *tree)
 {
-	spin_lock(&tree->lock);
-	while (!RB_EMPTY_ROOT(&tree->state)) {
-		struct rb_node *node;
-		struct extent_state *state;
+	struct extent_state *state;
+	struct extent_state *tmp;
 
-		node = rb_first(&tree->state);
-		state = rb_entry(node, struct extent_state, rb_node);
-		rb_erase(&state->rb_node, &tree->state);
+	spin_lock(&tree->lock);
+	rbtree_postorder_for_each_entry_safe(state, tmp, &tree->state, rb_node) {
+		/* Clear node to keep free_extent_state() happy. */
 		RB_CLEAR_NODE(&state->rb_node);
 		ASSERT(!(state->state & EXTENT_LOCKED));
 		/*
@@ -131,9 +129,9 @@ void extent_io_tree_release(struct extent_io_tree *tree)
 		 */
 		ASSERT(!waitqueue_active(&state->wq));
 		free_extent_state(state);
-
-		cond_resched_lock(&tree->lock);
+		cond_resched();
 	}
+	tree->state = RB_ROOT;
 	spin_unlock(&tree->lock);
 }
 
-- 
2.40.1

