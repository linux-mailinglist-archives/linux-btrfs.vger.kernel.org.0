Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3120F6C3000
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 12:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbjCULOz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Mar 2023 07:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbjCULOu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Mar 2023 07:14:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C548D17CDB
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 04:14:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA01561B13
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 11:14:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF49FC433EF
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 11:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679397257;
        bh=uq4QFWAekvR44jIbqQLGG0s4VYEh3Ve6rrXqoYQW2iM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=GdA3RswWPIqnl5bG+SJqLpHBHihRCgrN1DGewkfVlY82JPNbVvOEHrsmHEg2uNPjZ
         KGI2fW1hikjjKLW1lGvjFm0AO7I4U4bPnJ2r8+xSWCWuSrrX3trMTyenXuO+TQYKxI
         S05StmPuGUa9Baq95C0KFVnQNH9O5i+H7NxtA7MMny5RbhNUh7vAdAel/L/nTA7Vtv
         OfPxYp1hKSsusE8qIi2P0nm06z0B/oOyRTcPyB6/amqpHSh/kufOsrTnY98dQG4Wug
         TAOCqbr446EZNUa63uckaKKJ3U32YqQSIQWBznOQbQ96DyStgDeYZsI043ngSh5maa
         HYNlHhQGE6Lbw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 14/24] btrfs: don't throttle on delayed items when evicting deleted inode
Date:   Tue, 21 Mar 2023 11:13:50 +0000
Message-Id: <b50414f1d881a402ce2e1f9c821c683a16fd5f1b.1679326433.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1679326426.git.fdmanana@suse.com>
References: <cover.1679326426.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

During inode eviction, if we are truncating a deleted inode, we don't add
delayed items for our inode, so there's no need to throttle on delayed
items on each iteration of the loop that truncates inode items from its
subvolume tree. But we dirty extent buffers from its subvolume tree, so
we only need to throttle on btree inode dirty pages.

So use btrfs_btree_balance_dirty_nodelay() in the loop that truncates
inode items.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 7bae75973a4d..912d5f4aafbc 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5350,7 +5350,12 @@ void btrfs_evict_inode(struct inode *inode)
 		ret = btrfs_truncate_inode_items(trans, root, &control);
 		trans->block_rsv = &fs_info->trans_block_rsv;
 		btrfs_end_transaction(trans);
-		btrfs_btree_balance_dirty(fs_info);
+		/*
+		 * We have not added new delayed items for our inode after we
+		 * have flushed its delayed items, so no need to throttle on
+		 * delayed items. However we have modified extent buffers.
+		 */
+		btrfs_btree_balance_dirty_nodelay(fs_info);
 		if (ret && ret != -ENOSPC && ret != -EAGAIN)
 			goto free_rsv;
 		else if (!ret)
-- 
2.34.1

