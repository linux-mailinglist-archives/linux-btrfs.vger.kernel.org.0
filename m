Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D70911EC916
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jun 2020 07:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbgFCF4H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Jun 2020 01:56:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:42534 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbgFCF4A (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 3 Jun 2020 01:56:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B934EAF8D;
        Wed,  3 Jun 2020 05:56:01 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 32/46] btrfs: Make btrfs_new_extent_direct take btrfs_inode
Date:   Wed,  3 Jun 2020 08:55:32 +0300
Message-Id: <20200603055546.3889-33-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200603055546.3889-1-nborisov@suse.com>
References: <20200603055546.3889-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This function really needs a btrfs_inode and not a generic vfs one. Take it
as a parameter and get rid of superfluous BTRFS_I() calls.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/inode.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index ac330d6c7c3d..331a576170c0 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6859,29 +6859,29 @@ static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
 	return em;
 }

-static struct extent_map *btrfs_new_extent_direct(struct inode *inode,
+static struct extent_map *btrfs_new_extent_direct(struct btrfs_inode *inode,
 						  u64 start, u64 len)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	struct btrfs_root *root = BTRFS_I(inode)->root;
+	struct btrfs_root *root = inode->root;
+	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct extent_map *em;
 	struct btrfs_key ins;
 	u64 alloc_hint;
 	int ret;

-	alloc_hint = get_extent_allocation_hint(BTRFS_I(inode), start, len);
+	alloc_hint = get_extent_allocation_hint(inode, start, len);
 	ret = btrfs_reserve_extent(root, len, len, fs_info->sectorsize,
 				   0, alloc_hint, &ins, 1, 1);
 	if (ret)
 		return ERR_PTR(ret);

-	em = btrfs_create_dio_extent(BTRFS_I(inode), start, ins.offset, start,
+	em = btrfs_create_dio_extent(inode, start, ins.offset, start,
 				     ins.objectid, ins.offset, ins.offset,
 				     ins.offset, BTRFS_ORDERED_REGULAR);
 	btrfs_dec_block_group_reservations(fs_info, ins.objectid);
 	if (IS_ERR(em))
-		btrfs_free_reserved_extent(fs_info, ins.objectid,
-					   ins.offset, 1);
+		btrfs_free_reserved_extent(fs_info, ins.objectid, ins.offset,
+					   1);

 	return em;
 }
@@ -7236,7 +7236,7 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,

 	/* this will cow the extent */
 	free_extent_map(em);
-	*map = em = btrfs_new_extent_direct(inode, start, len);
+	*map = em = btrfs_new_extent_direct(BTRFS_I(inode), start, len);
 	if (IS_ERR(em)) {
 		ret = PTR_ERR(em);
 		goto out;
--
2.17.1

