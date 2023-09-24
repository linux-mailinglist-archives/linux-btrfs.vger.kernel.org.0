Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D897AC974
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Sep 2023 15:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbjIXNbt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 24 Sep 2023 09:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjIXNb3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 24 Sep 2023 09:31:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D612722;
        Sun, 24 Sep 2023 06:18:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84B13C433D9;
        Sun, 24 Sep 2023 13:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695561497;
        bh=qi5/mwH2HAKmqTTdE46upKbXGCSprpRBjoezJq7LS/Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vPlJKHpAQvtZURp8MPLoPrdyN6xirKtDjOfV2BPnNbAErhQM2yUMu1NNrUrxj89UO
         RU3y6xveS9J9teLtrSijIRoHy+m7SuSUS0gmOFjDRug6lK1vbI8ldMmmgL+WHEVL+c
         seJaUfcdVLIq8BUlMI+0Q/iA3D1Gs2TAEZrkZkIvjBIbgrO6bH9I965QevnSDTxsP/
         5HNKweLxQLSqyVaMTNSnKDBuwgScXlbZJFdPDwqrnAPZRfvMmiLEeyO9VFsGnj07C/
         WCwu6UQ0laYpRx8CuRc8PpnrHpCvlKXkTVKt++fqUYjyRZcdlncZsQPWFpVniSuVVz
         KzY4qRjvxyD5w==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Filipe Manana <fdmanana@suse.com>, Qu Wenruo <wqu@suse.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>, clm@fb.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 12/28] btrfs: assert delayed node locked when removing delayed item
Date:   Sun, 24 Sep 2023 09:17:29 -0400
Message-Id: <20230924131745.1275960-12-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230924131745.1275960-1-sashal@kernel.org>
References: <20230924131745.1275960-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.55
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

[ Upstream commit a57c2d4e46f519b24558ae0752c17eec416ac72a ]

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

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/delayed-inode.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 221d34f2ddf9a..bd701c249b21e 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -407,6 +407,7 @@ static void finish_one_item(struct btrfs_delayed_root *delayed_root)
 
 static void __btrfs_remove_delayed_item(struct btrfs_delayed_item *delayed_item)
 {
+	struct btrfs_delayed_node *delayed_node = delayed_item->delayed_node;
 	struct rb_root_cached *root;
 	struct btrfs_delayed_root *delayed_root;
 
@@ -414,18 +415,21 @@ static void __btrfs_remove_delayed_item(struct btrfs_delayed_item *delayed_item)
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

