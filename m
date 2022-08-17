Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF43596D82
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Aug 2022 13:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234605AbiHQLXF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Aug 2022 07:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234158AbiHQLXE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Aug 2022 07:23:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D77606A4
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Aug 2022 04:23:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 405ACB81D4C
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Aug 2022 11:23:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60E75C43470
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Aug 2022 11:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660735381;
        bh=pNgAAd3xi+WHdWX50dK+xFFzmSMeosw8pDhhZlLwE7k=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=gY3xfVp5Wcx+2xQRTmhrp4W/N07PIHdFiI2gUd+bWOR+PORTRvqPSsIGiHNrFhJV6
         VkRXoce0mBf81KS1k8y+k3BPprbz2eQ2WzNzCPysJuzzBvPtxY81FFVhQDWZEm97CS
         saWWjsGcUrSmK4BT4j7t+tD7jJVISrODFq2cVzZuEr+6ziub8l5CO6UyxBOX07OizO
         tjZE56xLTCWCm/vrP6OP0jyDZZVt8x4chg6LkkNibr/BP/VpOSLzXly6tWOmHXKzpI
         lQSHqXw9Qj+wyhFxVxUAIQO9nb0HV691Hk27cvPsqqiHLLbvgecB0AufsQRc8OLsRs
         pKQRJvRIOzoMQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 08/15] btrfs: remove unused logic when looking up delayed items
Date:   Wed, 17 Aug 2022 12:22:41 +0100
Message-Id: <d57f2212b16eb83c13c5014ffeb80ac17ec6f92c.1660735025.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1660735024.git.fdmanana@suse.com>
References: <cover.1660735024.git.fdmanana@suse.com>
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

All callers pass NULL to the 'prev' and 'next' arguments of the function
__btrfs_lookup_delayed_item(), so remove these arguments. Also, remove
the unnecessary wrapper __btrfs_lookup_delayed_insertion_item(), making
btrfs_delete_delayed_insertion_item() directly call
__btrfs_lookup_delayed_item().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/delayed-inode.c | 45 +++-------------------------------------
 1 file changed, 3 insertions(+), 42 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index cd2f3a8c4dfd..a8947ac00681 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -322,28 +322,20 @@ static struct btrfs_delayed_item *btrfs_alloc_delayed_item(u32 data_len,
  * __btrfs_lookup_delayed_item - look up the delayed item by key
  * @delayed_node: pointer to the delayed node
  * @index:	  the dir index value to lookup (offset of a dir index key)
- * @prev:	  used to store the prev item if the right item isn't found
- * @next:	  used to store the next item if the right item isn't found
  *
  * Note: if we don't find the right item, we will return the prev item and
  * the next item.
  */
 static struct btrfs_delayed_item *__btrfs_lookup_delayed_item(
 				struct rb_root *root,
-				u64 index,
-				struct btrfs_delayed_item **prev,
-				struct btrfs_delayed_item **next)
+				u64 index)
 {
-	struct rb_node *node, *prev_node = NULL;
+	struct rb_node *node = root->rb_node;
 	struct btrfs_delayed_item *delayed_item = NULL;
-	int ret = 0;
-
-	node = root->rb_node;
 
 	while (node) {
 		delayed_item = rb_entry(node, struct btrfs_delayed_item,
 					rb_node);
-		prev_node = node;
 		if (delayed_item->index < index)
 			node = node->rb_right;
 		else if (delayed_item->index > index)
@@ -352,40 +344,9 @@ static struct btrfs_delayed_item *__btrfs_lookup_delayed_item(
 			return delayed_item;
 	}
 
-	if (prev) {
-		if (!prev_node)
-			*prev = NULL;
-		else if (ret < 0)
-			*prev = delayed_item;
-		else if ((node = rb_prev(prev_node)) != NULL) {
-			*prev = rb_entry(node, struct btrfs_delayed_item,
-					 rb_node);
-		} else
-			*prev = NULL;
-	}
-
-	if (next) {
-		if (!prev_node)
-			*next = NULL;
-		else if (ret > 0)
-			*next = delayed_item;
-		else if ((node = rb_next(prev_node)) != NULL) {
-			*next = rb_entry(node, struct btrfs_delayed_item,
-					 rb_node);
-		} else
-			*next = NULL;
-	}
 	return NULL;
 }
 
-static struct btrfs_delayed_item *__btrfs_lookup_delayed_insertion_item(
-					struct btrfs_delayed_node *delayed_node,
-					u64 index)
-{
-	return __btrfs_lookup_delayed_item(&delayed_node->ins_root.rb_root, index,
-					   NULL, NULL);
-}
-
 static int __btrfs_add_delayed_item(struct btrfs_delayed_node *delayed_node,
 				    struct btrfs_delayed_item *ins)
 {
@@ -1549,7 +1510,7 @@ static int btrfs_delete_delayed_insertion_item(struct btrfs_fs_info *fs_info,
 	struct btrfs_delayed_item *item;
 
 	mutex_lock(&node->mutex);
-	item = __btrfs_lookup_delayed_insertion_item(node, index);
+	item = __btrfs_lookup_delayed_item(&node->ins_root.rb_root, index);
 	if (!item) {
 		mutex_unlock(&node->mutex);
 		return 1;
-- 
2.35.1

