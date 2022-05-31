Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D6953939B
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 May 2022 17:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345515AbiEaPHA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 May 2022 11:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345507AbiEaPG5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 May 2022 11:06:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3AAEA3
        for <linux-btrfs@vger.kernel.org>; Tue, 31 May 2022 08:06:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6971EB81168
        for <linux-btrfs@vger.kernel.org>; Tue, 31 May 2022 15:06:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97102C385A9
        for <linux-btrfs@vger.kernel.org>; Tue, 31 May 2022 15:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654009613;
        bh=89hXQ/tqVwYMckqPTTQg2JZuSI5Z6UIxNB+9y6uWB7w=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Jrh/7akX87oDrAPZyl9ID2oc3HmI3uJsejpsyFqIU2dXacfw0UdWmctFM/tXZH0zW
         0SHxA4Zfsab10g7Shz3C17S3w0zNVD6KN7SPRevOyIFUuR5daXyHtuB1D/3ahb3eIQ
         LuSeJ5eQkBE9paKhNg69BSU6yQCqZrtlQd157seBwNwyKm6zptmAbfUXbNyLoOJYia
         s5x+PboSpspPmYUPOjtAOb26lEFt7jJTOVRYp3Att4vwVgGcK0zIYUeKKV14dAjlgA
         Ao470hC8oQfhUSBKT0f6l5uHTBYveodR4tVJ81zAItkZEN/GmyF6uA9rodhydXQN5P
         O0SzJw1bktKYA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 06/12] btrfs: refactor the delayed item deletion entry point
Date:   Tue, 31 May 2022 16:06:37 +0100
Message-Id: <abca6c38b62815d6cde425fc089e7b78bbdc8981.1654009356.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1654009356.git.fdmanana@suse.com>
References: <cover.1654009356.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The delayed item deletion entry point, btrfs_delete_delayed_items(), is a
bit convoluted for a few reasons:

1) It's really a loop disguised with labels and goto statements;

2) There's a 'delete_fail' label which isn't only for error cases, we can
   jump to that label even if no error happened, if we simply don't have
   more delayed items to delete;

3) Unnecessarily keeps track of the current and previous items for no
   good reason, as after getting the next item and releasing the current
   one, it just jumps to the 'again' label just to look again for the
   first delayed item;

4) When a delayed item is not in the tree (because it was already deleted
   before), it releases the item while holding a path locked, which is
   not necessary and adds more contention to the tree, specially taking
   into account that the path came from a deletion search, meaning we have
   write locks for nodes at levels 2, 1 and 0. And releasing the item is
   not computationally trivial (rb tree deletion, a kfree() and some
   trivial things).

So refactor it to use a while loop and add some comments to make it more
obvious why we can have delayed items without a matching item in the tree
as well as why not keep the delayed node locked all the time when running
all its deletion items. This is also a preparation for some upcoming work
involving delayed items.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/delayed-inode.c | 71 ++++++++++++++++++++++------------------
 1 file changed, 39 insertions(+), 32 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 3c6368c29bb9..0125586fd565 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -860,45 +860,52 @@ static int btrfs_delete_delayed_items(struct btrfs_trans_handle *trans,
 				      struct btrfs_root *root,
 				      struct btrfs_delayed_node *node)
 {
-	struct btrfs_delayed_item *curr, *prev;
 	int ret = 0;
 
-do_again:
-	mutex_lock(&node->mutex);
-	curr = __btrfs_first_delayed_deletion_item(node);
-	if (!curr)
-		goto delete_fail;
+	while (ret == 0) {
+		struct btrfs_delayed_item *item;
+
+		mutex_lock(&node->mutex);
+		item = __btrfs_first_delayed_deletion_item(node);
+		if (!item) {
+			mutex_unlock(&node->mutex);
+			break;
+		}
+
+		ret = btrfs_search_slot(trans, root, &item->key, path, -1, 1);
+		if (ret > 0) {
+			/*
+			 * There's no matching item in the leaf. This means we
+			 * have already deleted this item in a past run of the
+			 * delayed items. We ignore errors when running delayed
+			 * items from an async context, through a work queue job
+			 * running btrfs_async_run_delayed_root(), and don't
+			 * release delayed items that failed to complete. This
+			 * is because we will retry later, and at transaction
+			 * commit time we always run delayed items and will
+			 * then deal with errors if they fail to run again.
+			 *
+			 * So just release delayed items for which we can't find
+			 * an item in the tree, and move to the next item.
+			 */
+			btrfs_release_path(path);
+			btrfs_release_delayed_item(item);
+			ret = 0;
+		} else if (ret == 0) {
+			ret = btrfs_batch_delete_items(trans, root, path, item);
+			btrfs_release_path(path);
+		}
 
-	ret = btrfs_search_slot(trans, root, &curr->key, path, -1, 1);
-	if (ret < 0)
-		goto delete_fail;
-	else if (ret > 0) {
 		/*
-		 * can't find the item which the node points to, so this node
-		 * is invalid, just drop it.
+		 * We unlock and relock on each iteration, this is to prevent
+		 * blocking other tasks for too long while we are being run from
+		 * the async context (work queue job). Those tasks are typically
+		 * running system calls like creat/mkdir/rename/unlink/etc which
+		 * need to add delayed items to this delayed node.
 		 */
-		prev = curr;
-		curr = __btrfs_next_delayed_item(prev);
-		btrfs_release_delayed_item(prev);
-		ret = 0;
-		btrfs_release_path(path);
-		if (curr) {
-			mutex_unlock(&node->mutex);
-			goto do_again;
-		} else
-			goto delete_fail;
+		mutex_unlock(&node->mutex);
 	}
 
-	ret = btrfs_batch_delete_items(trans, root, path, curr);
-	if (ret)
-		goto delete_fail;
-	btrfs_release_path(path);
-	mutex_unlock(&node->mutex);
-	goto do_again;
-
-delete_fail:
-	btrfs_release_path(path);
-	mutex_unlock(&node->mutex);
 	return ret;
 }
 
-- 
2.35.1

