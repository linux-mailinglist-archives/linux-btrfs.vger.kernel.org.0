Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9011EA724
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jun 2020 17:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbgFAPiX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Jun 2020 11:38:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:34042 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727921AbgFAPhv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Jun 2020 11:37:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C957FB21E;
        Mon,  1 Jun 2020 15:37:51 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 15/46] btrfs: Make btrfs_add_ordered_extent_compress take btrfs_inode
Date:   Mon,  1 Jun 2020 18:37:13 +0300
Message-Id: <20200601153744.31891-16-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200601153744.31891-1-nborisov@suse.com>
References: <20200601153744.31891-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It simpy forwards its inode argument to __btrfs_add_ordered_extent which
already takes btrfs_inode.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/inode.c        | 2 +-
 fs/btrfs/ordered-data.c | 4 ++--
 fs/btrfs/ordered-data.h | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 2ec372c4499c..a106c9857315 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -861,7 +861,7 @@ static noinline void submit_compressed_extents(struct async_chunk *async_chunk)
 			goto out_free_reserve;
 		free_extent_map(em);

-		ret = btrfs_add_ordered_extent_compress(inode,
+		ret = btrfs_add_ordered_extent_compress(BTRFS_I(inode),
 						async_extent->start,
 						ins.objectid,
 						async_extent->ram_size,
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 146fdf16010e..b3e3ab28dd78 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -252,12 +252,12 @@ int btrfs_add_ordered_extent_dio(struct inode *inode, u64 file_offset,
 					  BTRFS_COMPRESS_NONE);
 }

-int btrfs_add_ordered_extent_compress(struct inode *inode, u64 file_offset,
+int btrfs_add_ordered_extent_compress(struct btrfs_inode *inode, u64 file_offset,
 				      u64 disk_bytenr, u64 num_bytes,
 				      u64 disk_num_bytes, int type,
 				      int compress_type)
 {
-	return __btrfs_add_ordered_extent(BTRFS_I(inode), file_offset, disk_bytenr,
+	return __btrfs_add_ordered_extent(inode, file_offset, disk_bytenr,
 					  num_bytes, disk_num_bytes, type, 0,
 					  compress_type);
 }
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index ae6c4eaf975b..a0c6c31fc79b 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -160,7 +160,7 @@ int btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset,
 int btrfs_add_ordered_extent_dio(struct inode *inode, u64 file_offset,
 				 u64 disk_bytenr, u64 num_bytes,
 				 u64 disk_num_bytes, int type);
-int btrfs_add_ordered_extent_compress(struct inode *inode, u64 file_offset,
+int btrfs_add_ordered_extent_compress(struct btrfs_inode *inode, u64 file_offset,
 				      u64 disk_bytenr, u64 num_bytes,
 				      u64 disk_num_bytes, int type,
 				      int compress_type);
--
2.17.1

