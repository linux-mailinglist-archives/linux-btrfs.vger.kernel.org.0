Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 911EB22976A
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jul 2020 13:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbgGVL24 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jul 2020 07:28:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:40918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726146AbgGVL2y (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jul 2020 07:28:54 -0400
Received: from debian8.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D137120771
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Jul 2020 11:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595417334;
        bh=w+/XP08RA+J67clxberE4KIPBxSyU83pjlUZ0uxAJpE=;
        h=From:To:Subject:Date:From;
        b=tEhmTEBbokbwHDMoT8Iq9b3bqAfg0lBQKpgP5fo5t0JqEwyW4mm7S5yVyb0eFZEQH
         v7XGnhg77escsmJcY2GouL564xNZe9TgBUfpbGNixDfo+fTzoiUdFnb6HxfPqUsYXr
         lowMHQ983fx3CKoc3r/0Tn0L2/8EqZOO7z0Hf2mE=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs: release old extent maps during page release
Date:   Wed, 22 Jul 2020 12:28:52 +0100
Message-Id: <20200722112852.15571-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When removing an extent map at try_release_extent_mapping(), called through
the page release callback (btrfs_releasepage()), we never release an extent
map that is in the list of modified extents. This is to prevent races with
a concurrent fsync using the fast path, which could lead to not logging an
extent created in the current transaction.

However we can safely remove an extent map created in a past transaction
that is still in the list of modified extents (because no one fsynced yet
the inode after that transaction got commited), because such extents are
skipped during an fsync as it is pointless to log them. This change does
that.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_io.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 57f85d451695..5eab129e6eb0 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4487,6 +4487,9 @@ int try_release_extent_mapping(struct page *page, gfp_t mask)
 	    page->mapping->host->i_size > SZ_16M) {
 		u64 len;
 		while (start <= end) {
+			struct btrfs_fs_info *fs_info;
+			u64 cur_gen;
+
 			len = end - start + 1;
 			write_lock(&map->lock);
 			em = lookup_extent_mapping(map, start, len);
@@ -4511,13 +4514,27 @@ int try_release_extent_mapping(struct page *page, gfp_t mask)
 			 * extra reference on the em.
 			 */
 			if (list_empty(&em->list) ||
-			    test_bit(EXTENT_FLAG_LOGGING, &em->flags)) {
-				set_bit(BTRFS_INODE_NEEDS_FULL_SYNC,
-					&btrfs_inode->runtime_flags);
-				remove_extent_mapping(map, em);
-				/* once for the rb tree */
-				free_extent_map(em);
-			}
+			    test_bit(EXTENT_FLAG_LOGGING, &em->flags))
+				goto remove_em;
+			/*
+			 * If it's in the list of modified extents, remove it
+			 * only if its generation is older then the current one,
+			 * in which case we don't need it for a fast fsync.
+			 * Otherwise don't remove it, we could be racing with an
+			 * ongoing fast fsync that could miss the new extent.
+			 */
+			fs_info = btrfs_inode->root->fs_info;
+			spin_lock(&fs_info->trans_lock);
+			cur_gen = fs_info->generation;
+			spin_unlock(&fs_info->trans_lock);
+			if (em->generation >= cur_gen)
+				goto next;
+remove_em:
+			set_bit(BTRFS_INODE_NEEDS_FULL_SYNC,
+				&btrfs_inode->runtime_flags);
+			remove_extent_mapping(map, em);
+			/* once for the rb tree */
+			free_extent_map(em);
 next:
 			start = extent_map_end(em);
 			write_unlock(&map->lock);
-- 
2.26.2

