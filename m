Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C56D99657
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2019 16:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387937AbfHVOYZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Aug 2019 10:24:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:49520 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728042AbfHVOYZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Aug 2019 10:24:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E8F6EAC32
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Aug 2019 14:24:23 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     dsterb@suse.cz
Cc:     linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2] btrfs: Remove BUG_ON from run_delalloc_nocow
Date:   Thu, 22 Aug 2019 17:24:20 +0300
Message-Id: <20190822142420.1126-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190821155517.GB2752@twin.jikos.cz>
References: <20190821155517.GB2752@twin.jikos.cz>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Correctly handle failure cases when adding an ordered extents in case
of REGULAR or PREALLOC extents.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/inode.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 161439122a29..c8fe17cd8cb6 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1314,6 +1314,8 @@ static noinline int run_delalloc_nocow(struct inode *inode,
 	bool check_prev = true;
 	const bool freespace_inode = btrfs_is_free_space_inode(BTRFS_I(inode));
 	u64 ino = btrfs_ino(BTRFS_I(inode));
+	bool nocow = false;
+	u64 disk_bytenr = 0;
 
 	path = btrfs_alloc_path();
 	if (!path) {
@@ -1333,12 +1335,12 @@ static noinline int run_delalloc_nocow(struct inode *inode,
 		struct extent_buffer *leaf;
 		u64 extent_end;
 		u64 extent_offset;
-		u64 disk_bytenr = 0;
 		u64 num_bytes = 0;
 		u64 disk_num_bytes;
 		u64 ram_bytes;
 		int extent_type;
-		bool nocow = false;
+
+		nocow = false;
 
 		ret = btrfs_lookup_file_extent(NULL, root, path, ino,
 					       cur_offset, 0);
@@ -1572,16 +1574,25 @@ static noinline int run_delalloc_nocow(struct inode *inode,
 						       disk_bytenr, num_bytes,
 						       num_bytes,
 						       BTRFS_ORDERED_PREALLOC);
+			if (ret) {
+				btrfs_drop_extent_cache(BTRFS_I(inode),
+							cur_offset,
+							cur_offset + num_bytes - 1,
+							0);
+				goto error;
+			}
 		} else {
 			ret = btrfs_add_ordered_extent(inode, cur_offset,
 						       disk_bytenr, num_bytes,
 						       num_bytes,
 						       BTRFS_ORDERED_NOCOW);
+			if (ret)
+				goto error;
 		}
 
 		if (nocow)
 			btrfs_dec_nocow_writers(fs_info, disk_bytenr);
-		BUG_ON(ret); /* -ENOMEM */
+		nocow = false;
 
 		if (root->root_key.objectid ==
 		    BTRFS_DATA_RELOC_TREE_OBJECTID)
@@ -1626,6 +1637,9 @@ static noinline int run_delalloc_nocow(struct inode *inode,
 	}
 
 error:
+	if (nocow)
+		btrfs_dec_nocow_writers(fs_info, disk_bytenr);
+
 	if (ret && cur_offset < end)
 		extent_clear_unlock_delalloc(inode, cur_offset, end,
 					     locked_page, EXTENT_LOCKED |
-- 
2.17.1

