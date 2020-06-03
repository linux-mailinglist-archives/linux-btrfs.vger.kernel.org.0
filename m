Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5A201EC902
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jun 2020 07:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725855AbgFCFzx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Jun 2020 01:55:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:42396 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbgFCFzx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 3 Jun 2020 01:55:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2D281AFC3;
        Wed,  3 Jun 2020 05:55:55 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 02/46] btrfs: Make get_extent_allocation_hint take btrfs_inode
Date:   Wed,  3 Jun 2020 08:55:02 +0300
Message-Id: <20200603055546.3889-3-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200603055546.3889-1-nborisov@suse.com>
References: <20200603055546.3889-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It doesn't use the vfs inode for anything, can just as easily take btrfs_inode.
Follow up patches will convert callers as well.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/inode.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 1242d0aa108d..bc94051e3b4a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -928,10 +928,10 @@ static noinline void submit_compressed_extents(struct async_chunk *async_chunk)
 	goto again;
 }

-static u64 get_extent_allocation_hint(struct inode *inode, u64 start,
+static u64 get_extent_allocation_hint(struct btrfs_inode *inode, u64 start,
 				      u64 num_bytes)
 {
-	struct extent_map_tree *em_tree = &BTRFS_I(inode)->extent_tree;
+	struct extent_map_tree *em_tree = &inode->extent_tree;
 	struct extent_map *em;
 	u64 alloc_hint = 0;

@@ -1030,7 +1030,8 @@ static noinline int cow_file_range(struct inode *inode,
 		}
 	}

-	alloc_hint = get_extent_allocation_hint(inode, start, num_bytes);
+	alloc_hint = get_extent_allocation_hint(BTRFS_I(inode), start,
+						num_bytes);
 	btrfs_drop_extent_cache(BTRFS_I(inode), start,
 			start + num_bytes - 1, 0);

@@ -6875,7 +6876,7 @@ static struct extent_map *btrfs_new_extent_direct(struct inode *inode,
 	u64 alloc_hint;
 	int ret;

-	alloc_hint = get_extent_allocation_hint(inode, start, len);
+	alloc_hint = get_extent_allocation_hint(BTRFS_I(inode), start, len);
 	ret = btrfs_reserve_extent(root, len, len, fs_info->sectorsize,
 				   0, alloc_hint, &ins, 1, 1);
 	if (ret)
--
2.17.1

