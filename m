Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBEC82B8F
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Aug 2019 08:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731766AbfHFGXQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Aug 2019 02:23:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:40366 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726076AbfHFGXP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 6 Aug 2019 02:23:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CB9F6B035
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Aug 2019 06:23:14 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: print-tree: Use BFS as default traversal method
Date:   Tue,  6 Aug 2019 14:23:11 +0800
Message-Id: <20190806062311.16194-1-wqu@suse.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When debugging tree nodes with higher level, default DFS is not that
reader friendly:

  file tree key (262 ROOT_ITEM 16)
  node 33800192 level 2 items 4 free 117 generation 16 owner 262
  fs uuid 2d66d111-6850-4ca1-ae73-03f50adde41c
  chunk uuid 11141e63-2534-4d04-a0bd-c0531a8f5b88
  	key (256 INODE_ITEM 0) block 33771520 gen 15
  	key (330 EXTENT_DATA 0) block 33325056 gen 11
  	key (438 EXTENT_DATA 0) block 33652736 gen 15
  	key (654 EXTENT_DATA 0) block 33644544 gen 15
  node 33771520 level 1 items 59 free 62 generation 15 owner 256
  fs uuid 2d66d111-6850-4ca1-ae73-03f50adde41c
  chunk uuid 11141e63-2534-4d04-a0bd-c0531a8f5b88
  	key (256 INODE_ITEM 0) block 33787904 gen 15
  	key (256 DIR_ITEM 273597024) block 33124352 gen 9
  	[...]
  leaf 33787904 items 30 free space 1868 generation 15 owner 256
  fs uuid 2d66d111-6850-4ca1-ae73-03f50adde41c
  chunk uuid 11141e63-2534-4d04-a0bd-c0531a8f5b88
  	item 0 key (256 INODE_ITEM 0) itemoff 3835 itemsize 160
  		generation 6 transid 15 size 12954 nbytes 0
  		block group 0 mode 40755 links 1 uid 0 gid 0 rdev 0
  		sequence 528 flags 0x0(none)
  		atime 1565071339.446118888 (2019-08-06 14:02:19)
  		ctime 1565071339.449452222 (2019-08-06 14:02:19)
  		mtime 1565071339.449452222 (2019-08-06 14:02:19)
  		otime 1565071338.89452221 (2019-08-06 14:02:18)
  	item 1 key (256 INODE_REF 256) itemoff 3823 itemsize 12
  		index 0 namelen 2 name: ..
  	item 2 key (256 DIR_ITEM 2487323) itemoff 3781 itemsize 42
  		location key (487 INODE_ITEM 0) type FILE
  		transid 7 data_len 0 name_len 12
  		name: file_reg_115
  	[...]
  leaf 33124352 items 31 free space 1873 generation 9 owner 256
  	[...]

However such DFS will show the leaves before nodes. If tracing things
like drop_progress, we want to see nodes first then leaves.

So change default behavior to BFS to life of developers easier.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 print-tree.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/print-tree.h b/print-tree.h
index d4721b60647f..92ed5fb7c270 100644
--- a/print-tree.h
+++ b/print-tree.h
@@ -31,7 +31,7 @@ void btrfs_print_leaf(struct extent_buffer *l);
  */
 #define BTRFS_PRINT_TREE_DFS		0
 #define BTRFS_PRINT_TREE_BFS		1
-#define BTRFS_PRINT_TREE_DEFAULT	BTRFS_PRINT_TREE_DFS
+#define BTRFS_PRINT_TREE_DEFAULT	BTRFS_PRINT_TREE_BFS
 void btrfs_print_tree(struct extent_buffer *eb, bool follow, int traverse);
 
 void btrfs_print_key(struct btrfs_disk_key *disk_key);
-- 
2.22.0

