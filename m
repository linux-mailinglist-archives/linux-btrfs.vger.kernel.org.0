Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9D91EA708
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jun 2020 17:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbgFAPh4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Jun 2020 11:37:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:34068 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728059AbgFAPhz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Jun 2020 11:37:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 531A6B20E;
        Mon,  1 Jun 2020 15:37:55 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 31/46] btrfs: Make btrfs_create_dio_extent take btrfs_inode
Date:   Mon,  1 Jun 2020 18:37:29 +0300
Message-Id: <20200601153744.31891-32-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200601153744.31891-1-nborisov@suse.com>
References: <20200601153744.31891-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Take btrfs_inode directly and stop using superfulous BTRFS_I calls.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/inode.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 96cb7cc42930..ac330d6c7c3d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6823,7 +6823,7 @@ struct extent_map *btrfs_get_extent_fiemap(struct btrfs_inode *inode,
 	return em;
 }

-static struct extent_map *btrfs_create_dio_extent(struct inode *inode,
+static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
 						  const u64 start,
 						  const u64 len,
 						  const u64 orig_start,
@@ -6837,21 +6837,20 @@ static struct extent_map *btrfs_create_dio_extent(struct inode *inode,
 	int ret;

 	if (type != BTRFS_ORDERED_NOCOW) {
-		em = create_io_em(BTRFS_I(inode), start, len, orig_start,
-				  block_start, block_len, orig_block_len,
-				  ram_bytes,
+		em = create_io_em(inode, start, len, orig_start, block_start,
+				  block_len, orig_block_len, ram_bytes,
 				  BTRFS_COMPRESS_NONE, /* compress_type */
 				  type);
 		if (IS_ERR(em))
 			goto out;
 	}
-	ret = btrfs_add_ordered_extent_dio(BTRFS_I(inode), start, block_start,
-					   len, block_len, type);
+	ret = btrfs_add_ordered_extent_dio(inode, start, block_start, len,
+					   block_len, type);
 	if (ret) {
 		if (em) {
 			free_extent_map(em);
-			btrfs_drop_extent_cache(BTRFS_I(inode), start,
-						start + len - 1, 0);
+			btrfs_drop_extent_cache(inode, start, start + len - 1,
+						0);
 		}
 		em = ERR_PTR(ret);
 	}
@@ -6876,7 +6875,7 @@ static struct extent_map *btrfs_new_extent_direct(struct inode *inode,
 	if (ret)
 		return ERR_PTR(ret);

-	em = btrfs_create_dio_extent(inode, start, ins.offset, start,
+	em = btrfs_create_dio_extent(BTRFS_I(inode), start, ins.offset, start,
 				     ins.objectid, ins.offset, ins.offset,
 				     ins.offset, BTRFS_ORDERED_REGULAR);
 	btrfs_dec_block_group_reservations(fs_info, ins.objectid);
@@ -7210,7 +7209,7 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 		    btrfs_inc_nocow_writers(fs_info, block_start)) {
 			struct extent_map *em2;

-			em2 = btrfs_create_dio_extent(inode, start, len,
+			em2 = btrfs_create_dio_extent(BTRFS_I(inode), start, len,
 						      orig_start, block_start,
 						      len, orig_block_len,
 						      ram_bytes, type);
--
2.17.1

