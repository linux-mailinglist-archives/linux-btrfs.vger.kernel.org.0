Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9797AAFB7
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Sep 2023 12:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbjIVKj3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Sep 2023 06:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233378AbjIVKjY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Sep 2023 06:39:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E0CAC
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 03:39:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 478A8C433C7
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 10:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695379157;
        bh=ZKWdgYQcarznOQADSBDzP5RSVjSWOJeqquGTMO4djbk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Q0OI4jWls479xbH2EBO9PLrHxKohEZ8GHWMgK2Ufs6bqFJNw0q7FpZ0wkriXv7ELC
         cMmz8AnTJjpzNQdB3suIgNdY/I9a9wvio8gvDReQac2pH/7s0hR56ZAaFvgNXLWB+S
         nDUvch6oSWTok07IStBHkIquNDzcZEGwRYAEujCAZOtxy637DZ/zy2P405cLrzORvu
         VL95w+GzfUgH82BeyFiUkrUyPCSTjLZ4qeTvISKukvXUTxLkvhdFmHwP5e57qBKGMk
         HxTg0l6Sv/rBmlNe6E5d0z4u4D6ti0udVCf0VET4GjlJ/3k/Vc0fjfGEHbBCA8IYth
         gD16iuA2kquMQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 4/8] btrfs: remove pointless memory barrier from extent_io_tree_release()
Date:   Fri, 22 Sep 2023 11:39:05 +0100
Message-Id: <f7f89af6619fc4ba4f98c7654496c4a4c13445b9.1695333278.git.fdmanana@suse.com>
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

The memory barrier at extent_io_tree_release() is pointless because:

1) We have just called spin_lock() and that implies a memory barrier;

2) We only change the waitqueue of an extent state record while holding
   the tree lock - see wait_on_state()

So remove the memory barrier.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-io-tree.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 033544f79e2b..c939c2bc88e5 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -115,12 +115,6 @@ void extent_io_tree_init(struct btrfs_fs_info *fs_info,
 void extent_io_tree_release(struct extent_io_tree *tree)
 {
 	spin_lock(&tree->lock);
-	/*
-	 * Do a single barrier for the waitqueue_active check here, the state
-	 * of the waitqueue should not change once extent_io_tree_release is
-	 * called.
-	 */
-	smp_mb();
 	while (!RB_EMPTY_ROOT(&tree->state)) {
 		struct rb_node *node;
 		struct extent_state *state;
@@ -130,6 +124,11 @@ void extent_io_tree_release(struct extent_io_tree *tree)
 		rb_erase(&state->rb_node, &tree->state);
 		RB_CLEAR_NODE(&state->rb_node);
 		ASSERT(!(state->state & EXTENT_LOCKED));
+		/*
+		 * No need for a memory barrier here, as we are holding the tree
+		 * lock and we only change the waitqueue while holding that lock
+		 * (see wait_on_state()).
+		 */
 		ASSERT(!waitqueue_active(&state->wq));
 		free_extent_state(state);
 
-- 
2.40.1

