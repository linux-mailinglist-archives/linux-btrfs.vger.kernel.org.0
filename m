Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E66B6268896
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Sep 2020 11:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgINJhV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Sep 2020 05:37:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:41196 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726278AbgINJhR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Sep 2020 05:37:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A450AAF0E;
        Mon, 14 Sep 2020 09:37:31 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2 3/9] btrfs: Remove btree_get_extent
Date:   Mon, 14 Sep 2020 12:37:05 +0300
Message-Id: <20200914093711.13523-4-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200914093711.13523-1-nborisov@suse.com>
References: <20200914093711.13523-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The sole purpose of this function was to satisfy the requirements of
__do_readpage. Since that function is no longer used to read metadata
pages the need to keep btree_get_extent around has also disappeared.
Simply remove it.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c | 47 ----------------------------------------------
 fs/btrfs/disk-io.h |  3 ---
 2 files changed, 50 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index d63498f3c75f..2a5aadcf6b54 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -204,53 +204,6 @@ void btrfs_set_buffer_lockdep_class(u64 objectid, struct extent_buffer *eb,

 #endif

-/*
- * extents on the btree inode are pretty simple, there's one extent
- * that covers the entire device
- */
-struct extent_map *btree_get_extent(struct btrfs_inode *inode,
-				    struct page *page, size_t pg_offset,
-				    u64 start, u64 len)
-{
-	struct extent_map_tree *em_tree = &inode->extent_tree;
-	struct extent_map *em;
-	int ret;
-
-	read_lock(&em_tree->lock);
-	em = lookup_extent_mapping(em_tree, start, len);
-	if (em) {
-		read_unlock(&em_tree->lock);
-		goto out;
-	}
-	read_unlock(&em_tree->lock);
-
-	em = alloc_extent_map();
-	if (!em) {
-		em = ERR_PTR(-ENOMEM);
-		goto out;
-	}
-	em->start = 0;
-	em->len = (u64)-1;
-	em->block_len = (u64)-1;
-	em->block_start = 0;
-
-	write_lock(&em_tree->lock);
-	ret = add_extent_mapping(em_tree, em, 0);
-	if (ret == -EEXIST) {
-		free_extent_map(em);
-		em = lookup_extent_mapping(em_tree, start, len);
-		if (!em)
-			em = ERR_PTR(-EIO);
-	} else if (ret) {
-		free_extent_map(em);
-		em = ERR_PTR(ret);
-	}
-	write_unlock(&em_tree->lock);
-
-out:
-	return em;
-}
-
 /*
  * Compute the csum of a btree block and store the result to provided buffer.
  */
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 00dc39d47ed3..89b6a709a184 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -123,9 +123,6 @@ struct btrfs_root *btrfs_create_tree(struct btrfs_trans_handle *trans,
 				     u64 objectid);
 int btree_lock_page_hook(struct page *page, void *data,
 				void (*flush_fn)(void *));
-struct extent_map *btree_get_extent(struct btrfs_inode *inode,
-				    struct page *page, size_t pg_offset,
-				    u64 start, u64 len);
 int btrfs_get_num_tolerated_disk_barrier_failures(u64 flags);
 int __init btrfs_end_io_wq_init(void);
 void __cold btrfs_end_io_wq_exit(void);
--
2.17.1

