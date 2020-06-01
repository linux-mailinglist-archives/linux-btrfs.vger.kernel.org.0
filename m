Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB781EA71B
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jun 2020 17:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbgFAPiO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Jun 2020 11:38:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:34073 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728056AbgFAPhy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Jun 2020 11:37:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 169BFB210;
        Mon,  1 Jun 2020 15:37:55 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 30/46] btrfs: Make btrfs_add_ordered_extent_dio take btrfs_inode
Date:   Mon,  1 Jun 2020 18:37:28 +0300
Message-Id: <20200601153744.31891-31-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200601153744.31891-1-nborisov@suse.com>
References: <20200601153744.31891-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Simply forwards its argument so let's get rid of one extra BTRFS_I by taking
btrfs_inode directly.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/inode.c        | 2 +-
 fs/btrfs/ordered-data.c | 4 ++--
 fs/btrfs/ordered-data.h | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 54e291c94214..96cb7cc42930 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6845,7 +6845,7 @@ static struct extent_map *btrfs_create_dio_extent(struct inode *inode,
 		if (IS_ERR(em))
 			goto out;
 	}
-	ret = btrfs_add_ordered_extent_dio(inode, start, block_start,
+	ret = btrfs_add_ordered_extent_dio(BTRFS_I(inode), start, block_start,
 					   len, block_len, type);
 	if (ret) {
 		if (em) {
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 4d32876649a5..648c3f06c463 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -243,11 +243,11 @@ int btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset,
 					  BTRFS_COMPRESS_NONE);
 }

-int btrfs_add_ordered_extent_dio(struct inode *inode, u64 file_offset,
+int btrfs_add_ordered_extent_dio(struct btrfs_inode *inode, u64 file_offset,
 				 u64 disk_bytenr, u64 num_bytes,
 				 u64 disk_num_bytes, int type)
 {
-	return __btrfs_add_ordered_extent(BTRFS_I(inode), file_offset, disk_bytenr,
+	return __btrfs_add_ordered_extent(inode, file_offset, disk_bytenr,
 					  num_bytes, disk_num_bytes, type, 1,
 					  BTRFS_COMPRESS_NONE);
 }
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index d9819bfcd3ec..708603a0f708 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -157,7 +157,7 @@ int btrfs_dec_test_first_ordered_pending(struct btrfs_inode *inode,
 int btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset,
 			     u64 disk_bytenr, u64 num_bytes, u64 disk_num_bytes,
 			     int type);
-int btrfs_add_ordered_extent_dio(struct inode *inode, u64 file_offset,
+int btrfs_add_ordered_extent_dio(struct btrfs_inode *inode, u64 file_offset,
 				 u64 disk_bytenr, u64 num_bytes,
 				 u64 disk_num_bytes, int type);
 int btrfs_add_ordered_extent_compress(struct btrfs_inode *inode, u64 file_offset,
--
2.17.1

