Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5587AAFBF
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Sep 2023 12:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbjIVKjX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Sep 2023 06:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233340AbjIVKjW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Sep 2023 06:39:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A61F99
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 03:39:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47939C433C7
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 10:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695379155;
        bh=IHOYhhBVsoalHWaYkdE7cuCqFUUGSU3xPr9eqrwHQLU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=kqyufN6oDodaeSt5nti08yGwhPJtmzDtNaNsrmDo3sqZ4/AyzBkdDhBc6DmNkX53x
         FVnvbpgf94boIVNzZ6uBIniM7Eksa/GM7Hdol9ga15BqhVNn6tE8SE5uNpOLsaFXBv
         wFWo16YM10nXrX3YS/iubQ3RXfOeVEKmfZ//M/BeWliUxzhmBwP54R9EZDuvjSbyzP
         FcRByU35mNR1GApIbavZN9YNNSN1idzfo9jUCMZqYy+LPI9gcqpCda1QkzXoAN22lV
         kCycZOHCs6rA3qXy5wXgIxCWI+2jWCl3w5rk0f4gbYeuvxxS2/6Z9ajMJrR8HU9IbA
         cpQk3kqaHVUig==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/8] btrfs: update stale comment at extent_io_tree_release()
Date:   Fri, 22 Sep 2023 11:39:03 +0100
Message-Id: <1ef2084700a7940676927a5f2b0d8c58515678df.1695333278.git.fdmanana@suse.com>
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

There's this comment at extent_io_tree_release() when mentions io btrees,
but this function is no longer used only for io btrees. Originally it was
added as a static function named clear_btree_io_tree() at transaction.c,
in commit 663dfbb07774 ("Btrfs: deal with convert_extent_bit errors to
avoid fs corruption"), as it was used only for cleaning one of the io
trees that track dirty extent buffers, the dirty_log_pages io tree of a
a root and the dirty_pages io tree of a transaction. Later it was renamed
and exported and now it's used to cleanup other io trees such as the
allocation state io tree of a device or the cums range io tree of a log
root.

So remove that comment and replace it with one at the top of the function
that is more complete, mentioning what the function does and that it's
expected to be called only when a task is sure no one else will need to
use the tree anymore, as well as there should be no locked ranges in the
tree and therefore no waiters on its extent state records. Also add an
assertion to check that there are no locked extent state records in the
tree.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-io-tree.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index dd9dd473654d..1ca0827493a6 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -105,6 +105,13 @@ void extent_io_tree_init(struct btrfs_fs_info *fs_info,
 		lockdep_set_class(&tree->lock, &file_extent_tree_class);
 }
 
+/*
+ * Empty an io tree, removing and freeing every extent state record from the
+ * tree. This should be called once we are sure no other task can access the
+ * tree anymore, so no tree updates happen after we empty the tree and there
+ * aren't any waiters on any extent state record (EXTENT_LOCKED bit is never
+ * set on any extent state when calling this function).
+ */
 void extent_io_tree_release(struct extent_io_tree *tree)
 {
 	spin_lock(&tree->lock);
@@ -122,10 +129,7 @@ void extent_io_tree_release(struct extent_io_tree *tree)
 		state = rb_entry(node, struct extent_state, rb_node);
 		rb_erase(&state->rb_node, &tree->state);
 		RB_CLEAR_NODE(&state->rb_node);
-		/*
-		 * btree io trees aren't supposed to have tasks waiting for
-		 * changes in the flags of extent states ever.
-		 */
+		ASSERT(!(state->state & EXTENT_LOCKED));
 		ASSERT(!waitqueue_active(&state->wq));
 		free_extent_state(state);
 
-- 
2.40.1

