Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA279269DE3
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Sep 2020 07:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbgIOFgP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Sep 2020 01:36:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:43390 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726168AbgIOFgM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Sep 2020 01:36:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 33BEEAD52
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Sep 2020 05:36:27 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 14/19] btrfs: make btree inode io_tree has its special owner
Date:   Tue, 15 Sep 2020 13:35:27 +0800
Message-Id: <20200915053532.63279-15-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200915053532.63279-1-wqu@suse.com>
References: <20200915053532.63279-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Btree inode is pretty special compared to all other inode extent io
tree, although it has a btrfs inode, it doesn't have the track_uptodate
bit at all.

This means a lot of things like extent locking doesn't even need to be
applied to btree io tree.

Since it's so special, adds a new owner value for it to make debuging a
little easier.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c        | 2 +-
 fs/btrfs/extent-io-tree.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 1ba16951ccaa..82a841bd0702 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2126,7 +2126,7 @@ static void btrfs_init_btree_inode(struct btrfs_fs_info *fs_info)
 
 	RB_CLEAR_NODE(&BTRFS_I(inode)->rb_node);
 	extent_io_tree_init(fs_info, &BTRFS_I(inode)->io_tree,
-			    IO_TREE_INODE_IO, inode);
+			    IO_TREE_BTREE_IO, inode);
 	BTRFS_I(inode)->io_tree.track_uptodate = false;
 	extent_map_tree_init(&BTRFS_I(inode)->extent_tree);
 
diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index 219a09a2b734..21d128383bfd 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -40,6 +40,7 @@ struct io_failure_record;
 enum {
 	IO_TREE_FS_PINNED_EXTENTS,
 	IO_TREE_FS_EXCLUDED_EXTENTS,
+	IO_TREE_BTREE_IO,
 	IO_TREE_INODE_IO,
 	IO_TREE_INODE_IO_FAILURE,
 	IO_TREE_RELOC_BLOCKS,
-- 
2.28.0

