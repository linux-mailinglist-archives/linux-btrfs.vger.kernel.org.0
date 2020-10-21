Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB86294822
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 08:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440716AbgJUG0O (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 02:26:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:42596 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440713AbgJUG0O (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 02:26:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603261572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WyxgVmfSnqy3nIsaxpTFC1EaBL9RBW0/X/z/r0RhDOE=;
        b=UQ5Ign3mpCFLA5TcCIhdSoxVdIfMgftanMVRZTNpB/XJjAD4TvkZnNp2JU/BA1ohEFzjB7
        7ip7sTe1bKo8nJcAHuawQXoenF3v6d+MKnwwU4iKKpR49PkJiERKyDJY0qNphGqV7dt5Sk
        1fiDjoj6lGRtQEaqLknZBrAjJRUACR4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D6D77AC8C
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020 06:26:12 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 06/68] btrfs: make btree inode io_tree has its special owner
Date:   Wed, 21 Oct 2020 14:24:52 +0800
Message-Id: <20201021062554.68132-7-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201021062554.68132-1-wqu@suse.com>
References: <20201021062554.68132-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Btree inode is pretty special compared to all other inode extent io
tree, although it has a btrfs inode, it doesn't have the track_uptodate
bit set to true, and never has ordered extent.

Since it's so special, adds a new owner value for it to make debuging a
little easier.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c           | 2 +-
 fs/btrfs/extent-io-tree.h    | 1 +
 include/trace/events/btrfs.h | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index f6bba7eb1fa1..be6edbd34934 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2116,7 +2116,7 @@ static void btrfs_init_btree_inode(struct btrfs_fs_info *fs_info)
 
 	RB_CLEAR_NODE(&BTRFS_I(inode)->rb_node);
 	extent_io_tree_init(fs_info, &BTRFS_I(inode)->io_tree,
-			    IO_TREE_INODE_IO, inode);
+			    IO_TREE_BTREE_INODE_IO, inode);
 	BTRFS_I(inode)->io_tree.track_uptodate = false;
 	extent_map_tree_init(&BTRFS_I(inode)->extent_tree);
 
diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index 9a60d8426796..92caa1190ca8 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -40,6 +40,7 @@ struct io_failure_record;
 enum {
 	IO_TREE_FS_PINNED_EXTENTS,
 	IO_TREE_FS_EXCLUDED_EXTENTS,
+	IO_TREE_BTREE_INODE_IO,
 	IO_TREE_INODE_IO,
 	IO_TREE_INODE_IO_FAILURE,
 	IO_TREE_RELOC_BLOCKS,
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index 863335ecb7e8..89397605e465 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -79,6 +79,7 @@ struct btrfs_space_info;
 #define IO_TREE_OWNER						    \
 	EM( IO_TREE_FS_PINNED_EXTENTS, 	  "PINNED_EXTENTS")	    \
 	EM( IO_TREE_FS_EXCLUDED_EXTENTS,  "EXCLUDED_EXTENTS")	    \
+	EM( IO_TREE_BTREE_INODE_IO,	  "BTRFS_INODE_IO")	    \
 	EM( IO_TREE_INODE_IO,		  "INODE_IO")		    \
 	EM( IO_TREE_INODE_IO_FAILURE,	  "INODE_IO_FAILURE")	    \
 	EM( IO_TREE_RELOC_BLOCKS,	  "RELOC_BLOCKS")	    \
-- 
2.28.0

