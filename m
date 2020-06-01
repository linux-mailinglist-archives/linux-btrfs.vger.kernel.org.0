Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D398D1EAD03
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jun 2020 20:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731244AbgFASMc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Jun 2020 14:12:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:59866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731231AbgFASMa (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Jun 2020 14:12:30 -0400
Received: from debian8.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55290207DA
        for <linux-btrfs@vger.kernel.org>; Mon,  1 Jun 2020 18:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591035149;
        bh=dbUsFkd2HGrlTiS1vhTVeLHiWKyeg7shVh8FtkwYelk=;
        h=From:To:Subject:Date:From;
        b=h+Jm4stjsKtuq5NF4bBnbu4IRqEDy21WqqOZGtD1QB1m/kzdnqAj1+xAcZoGjknUn
         O+n92CoKuADlKd3vwqlQsDHZCNr7YeVSfiv48SzktB8Fq8GpbIg/05/m6shlSXoiKk
         HUmbgDO7p1Ni7QhebMXF2k3JN+2km4EZP6BcqniA=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 3/3] Btrfs: remove no longer necessary chunk mutex locking cases
Date:   Mon,  1 Jun 2020 19:12:27 +0100
Message-Id: <20200601181227.28585-1-fdmanana@kernel.org>
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

V2: Rebased on 5.8 changes, since the previous patch had to be rebased too.

 fs/btrfs/block-group.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index be73055ee3a6..a10834b837a5 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1111,7 +1111,6 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 	if (ret < 0)
 		goto out;
 
-	mutex_lock(&fs_info->chunk_mutex);
 	spin_lock(&block_group->lock);
 	block_group->removed = 1;
 	/*
@@ -1143,8 +1142,6 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 	remove_em = (atomic_read(&block_group->frozen) == 0);
 	spin_unlock(&block_group->lock);
 
-	mutex_unlock(&fs_info->chunk_mutex);
-
 	if (remove_em) {
 		struct extent_map_tree *em_tree;
 
@@ -3447,7 +3444,6 @@ void btrfs_unfreeze_block_group(struct btrfs_block_group *block_group)
 	spin_unlock(&block_group->lock);
 
 	if (cleanup) {
-		mutex_lock(&fs_info->chunk_mutex);
 		em_tree = &fs_info->mapping_tree;
 		write_lock(&em_tree->lock);
 		em = lookup_extent_mapping(em_tree, block_group->start,
@@ -3455,7 +3451,6 @@ void btrfs_unfreeze_block_group(struct btrfs_block_group *block_group)
 		BUG_ON(!em); /* logic error, can't happen */
 		remove_extent_mapping(em_tree, em);
 		write_unlock(&em_tree->lock);
-		mutex_unlock(&fs_info->chunk_mutex);
 
 		/* once for us and once for the tree */
 		free_extent_map(em);
-- 
2.11.0

