Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 213D71EA723
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jun 2020 17:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbgFAPiX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Jun 2020 11:38:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:34082 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727879AbgFAPhv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Jun 2020 11:37:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5DEDAB21C;
        Mon,  1 Jun 2020 15:37:51 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 13/46] btrfs: Make btrfs_add_ordered_extent take btrfs_inode
Date:   Mon,  1 Jun 2020 18:37:11 +0300
Message-Id: <20200601153744.31891-14-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200601153744.31891-1-nborisov@suse.com>
References: <20200601153744.31891-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Preparation to converting its callers to taking btrfs_inode.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/inode.c        | 9 +++++----
 fs/btrfs/ordered-data.c | 4 ++--
 fs/btrfs/ordered-data.h | 2 +-
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index a05ffc129967..b04e27306058 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1063,8 +1063,9 @@ static noinline int cow_file_range(struct inode *inode,
 		}
 		free_extent_map(em);

-		ret = btrfs_add_ordered_extent(inode, start, ins.objectid,
-					       ram_size, cur_alloc_size, 0);
+		ret = btrfs_add_ordered_extent(BTRFS_I(inode), start,
+					       ins.objectid, ram_size,
+					       cur_alloc_size, 0);
 		if (ret)
 			goto out_drop_extent_cache;

@@ -1698,7 +1699,7 @@ static noinline int run_delalloc_nocow(struct inode *inode,
 				goto error;
 			}
 			free_extent_map(em);
-			ret = btrfs_add_ordered_extent(inode, cur_offset,
+			ret = btrfs_add_ordered_extent(BTRFS_I(inode), cur_offset,
 						       disk_bytenr, num_bytes,
 						       num_bytes,
 						       BTRFS_ORDERED_PREALLOC);
@@ -1710,7 +1711,7 @@ static noinline int run_delalloc_nocow(struct inode *inode,
 				goto error;
 			}
 		} else {
-			ret = btrfs_add_ordered_extent(inode, cur_offset,
+			ret = btrfs_add_ordered_extent(BTRFS_I(inode), cur_offset,
 						       disk_bytenr, num_bytes,
 						       num_bytes,
 						       BTRFS_ORDERED_NOCOW);
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 4139de966c74..146fdf16010e 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -234,11 +234,11 @@ static int __btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset
 	return 0;
 }

-int btrfs_add_ordered_extent(struct inode *inode, u64 file_offset,
+int btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset,
 			     u64 disk_bytenr, u64 num_bytes, u64 disk_num_bytes,
 			     int type)
 {
-	return __btrfs_add_ordered_extent(BTRFS_I(inode), file_offset, disk_bytenr,
+	return __btrfs_add_ordered_extent(inode, file_offset, disk_bytenr,
 					  num_bytes, disk_num_bytes, type, 0,
 					  BTRFS_COMPRESS_NONE);
 }
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index 6afa9d98e84e..ae6c4eaf975b 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -154,7 +154,7 @@ int btrfs_dec_test_first_ordered_pending(struct inode *inode,
 				   struct btrfs_ordered_extent **cached,
 				   u64 *file_offset, u64 io_size,
 				   int uptodate);
-int btrfs_add_ordered_extent(struct inode *inode, u64 file_offset,
+int btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset,
 			     u64 disk_bytenr, u64 num_bytes, u64 disk_num_bytes,
 			     int type);
 int btrfs_add_ordered_extent_dio(struct inode *inode, u64 file_offset,
--
2.17.1

