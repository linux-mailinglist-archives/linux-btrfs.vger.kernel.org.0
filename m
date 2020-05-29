Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C007A1E7B84
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 May 2020 13:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbgE2LSm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 May 2020 07:18:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:51654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726310AbgE2LSm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 May 2020 07:18:42 -0400
Received: from debian6.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68475207D4
        for <linux-btrfs@vger.kernel.org>; Fri, 29 May 2020 11:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590751121;
        bh=XZm5tz6Bf2XIOJ4KOdKZecKuonFzWbdPmLvgoYZQB7Q=;
        h=From:To:Subject:Date:From;
        b=gejKj1nW0fxBDDdJ8sp/YH4NBQEHIl8zTuOBdPpDaqgci6ubqKEw6nby4Y8nn+9u5
         voQ34ON0Mi0O2/N0/413tm1qdu+7rM0rs5bym/4Wh8sCquYbp4+Mu2eFBLqufzXNeS
         /PM3TJyKxAjkopyFbxRivxneEkCT++SHRZ6TxG7Y=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] Btrfs: remove no longer necessary chunk mutex locking cases
Date:   Fri, 29 May 2020 12:18:39 +0100
Message-Id: <20200529111839.16296-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Initially when the 'removed' flag was added to a block group to avoid
races between block group removal and fitrim, by commit 04216820fe83d5
("Btrfs: fix race between fs trimming and block group remove/allocation"),
we had to lock the chunks mutex because we could be moving the block
group from its current list, the pending chunks list, into the pinned
chunks list, or we could just be adding it to the pinned chunks if it was
not in the pending chunks list. Both lists were protected by the chunk
mutex.

However we no longer have those lists since commit 1c11b63eff2a67
("btrfs: replace pending/pinned chunks lists with io tree"), and locking
the chunk mutex is no longer necessary because of that. The same happens
at btrfs_unfreeze_block_group(), we lock the chunk mutex because the block
group's extent map could be part of the pinned chunks list and the call
to remove_extent_mapping() could be deleting it from that list, which
used to be protected by that mutex.

So just remove those lock and unlock calls as they are not needed anymore.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-group.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 5e0e994c87bb..d3e28eeae221 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1094,7 +1094,6 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 	if (ret)
 		goto out;
 
-	mutex_lock(&fs_info->chunk_mutex);
 	spin_lock(&block_group->lock);
 	block_group->removed = 1;
 	/*
@@ -1126,8 +1125,6 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 	remove_em = (atomic_read(&block_group->frozen) == 0);
 	spin_unlock(&block_group->lock);
 
-	mutex_unlock(&fs_info->chunk_mutex);
-
 	/* Once for the block groups rbtree */
 	btrfs_put_block_group(block_group);
 
@@ -3411,7 +3408,6 @@ void btrfs_unfreeze_block_group(struct btrfs_block_group *block_group)
 	spin_unlock(&block_group->lock);
 
 	if (cleanup) {
-		mutex_lock(&fs_info->chunk_mutex);
 		em_tree = &fs_info->mapping_tree;
 		write_lock(&em_tree->lock);
 		em = lookup_extent_mapping(em_tree, block_group->start,
@@ -3419,7 +3415,6 @@ void btrfs_unfreeze_block_group(struct btrfs_block_group *block_group)
 		BUG_ON(!em); /* logic error, can't happen */
 		remove_extent_mapping(em_tree, em);
 		write_unlock(&em_tree->lock);
-		mutex_unlock(&fs_info->chunk_mutex);
 
 		/* once for us and once for the tree */
 		free_extent_map(em);
-- 
2.11.0

