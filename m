Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D73978A72D
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Aug 2023 10:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjH1IH4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Aug 2023 04:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjH1IHU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Aug 2023 04:07:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB3410F7
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Aug 2023 01:06:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2B6863347
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Aug 2023 08:06:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1550C433C8
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Aug 2023 08:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693210010;
        bh=tl/QPXMsaSl+EGTyp6P2fwVUW/Eta4I93fqizwRbtIY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=klJpRULqSR76QF2s6mUIMqEo83jHcCjl/MmqVgnqI3DkEmRKGv9UiIeQxAOiGBr43
         fIP4gtZKva8P/asj20+xQE2AQQuooCrWRtsFLL6BgexCXfK4qEeSQoL1vfK1qe2b6n
         q/96uNj5DhvKbJ4PDQ53oYgi0JthNkp6/CA73QQNEoTV0DIqYaOick5YHyNhfrdV7A
         C+N/ky/Q02GHgWvxSYet80H8vbBVTFa5mPQCyD63B3arLCMotKdvzh/lVsslQE7rmD
         EyIff2a9539XFTRRAMX1FiNxe1bqBKgbeZwJdDIyyvwjDNvwGuL7DCSAzt/32p8Fmr
         6U8eITT+ifLBQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 3/3] btrfs: assert delayed node locked when removing delayed item
Date:   Mon, 28 Aug 2023 09:06:44 +0100
Message-Id: <29dfd7c6aebbfbd0638a2e34ae34aa1d4f550389.1693209858.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1693209858.git.fdmanana@suse.com>
References: <cover.1693209858.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When removing a delayed item, or releasing which will remove it as well,
we will modify one of the delayed node's rbtrees and item counter if the
delayed item is in one of the rbtrees. This require having the delayed
node's mutex locked, otherwise we will race with other tasks modifying
the rbtrees and the counter.

This is motivated by a previous version of another patch actually calling
btrfs_release_delayed_item() after unlocking the delayed node's mutex and
against a delayed item that is in a rbtree.

So assert at __btrfs_remove_delayed_item() that the delayed node's mutex
is locked.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/delayed-inode.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index eb175ae52245..8534285f760d 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -412,6 +412,7 @@ static void finish_one_item(struct btrfs_delayed_root *delayed_root)
 
 static void __btrfs_remove_delayed_item(struct btrfs_delayed_item *delayed_item)
 {
+	struct btrfs_delayed_node *delayed_node = delayed_item->delayed_node;
 	struct rb_root_cached *root;
 	struct btrfs_delayed_root *delayed_root;
 
@@ -419,18 +420,21 @@ static void __btrfs_remove_delayed_item(struct btrfs_delayed_item *delayed_item)
 	if (RB_EMPTY_NODE(&delayed_item->rb_node))
 		return;
 
-	delayed_root = delayed_item->delayed_node->root->fs_info->delayed_root;
+	/* If it's in a rbtree, then we need to have delayed node locked. */
+	lockdep_assert_held(&delayed_node->mutex);
+
+	delayed_root = delayed_node->root->fs_info->delayed_root;
 
 	BUG_ON(!delayed_root);
 
 	if (delayed_item->type == BTRFS_DELAYED_INSERTION_ITEM)
-		root = &delayed_item->delayed_node->ins_root;
+		root = &delayed_node->ins_root;
 	else
-		root = &delayed_item->delayed_node->del_root;
+		root = &delayed_node->del_root;
 
 	rb_erase_cached(&delayed_item->rb_node, root);
 	RB_CLEAR_NODE(&delayed_item->rb_node);
-	delayed_item->delayed_node->count--;
+	delayed_node->count--;
 
 	finish_one_item(delayed_root);
 }
-- 
2.40.1

