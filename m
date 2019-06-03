Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDD98332F1
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jun 2019 16:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729382AbfFCO7L (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jun 2019 10:59:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:32778 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729364AbfFCO7F (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 3 Jun 2019 10:59:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EF6FAAFDB;
        Mon,  3 Jun 2019 14:59:02 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Chris Mason <clm@fb.com>, Richard Weinberger <richard@nod.at>,
        David Gstir <david@sigma-star.at>,
        Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v4 12/13] btrfs: remove assumption about csum type form btrfs_print_data_csum_error()
Date:   Mon,  3 Jun 2019 16:58:58 +0200
Message-Id: <20190603145859.7176-13-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190603145859.7176-1-jthumshirn@suse.de>
References: <20190603145859.7176-1-jthumshirn@suse.de>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_print_data_csum_error() still assumed checksums to be 32 bit in size.

Make it size agnostic.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/btrfs_inode.h | 10 +++++-----
 fs/btrfs/compression.c |  2 +-
 fs/btrfs/inode.c       |  4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 4543f4864b2d..7a89f73b13e6 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -341,7 +341,7 @@ static inline void btrfs_inode_resume_unlocked_dio(struct btrfs_inode *inode)
 #define CSUM_FORMAT_VALUE(size, bytes)  size, bytes
 
 static inline void btrfs_print_data_csum_error(struct btrfs_inode *inode,
-		u64 logical_start, u32 csum, u32 csum_expected, int mirror_num)
+		u64 logical_start, u8 *csum, u8 *csum_expected, int mirror_num)
 {
 	struct btrfs_root *root = inode->root;
 	struct btrfs_super_block *sb = root->fs_info->super_copy;
@@ -352,15 +352,15 @@ static inline void btrfs_print_data_csum_error(struct btrfs_inode *inode,
 		btrfs_warn_rl(root->fs_info,
 	"csum failed root %lld ino %lld off %llu csum " CSUM_FORMAT " expected csum " CSUM_FORMAT " mirror %d",
 			root->root_key.objectid, btrfs_ino(inode),
-			logical_start, CSUM_FORMAT_VALUE(csum_size, &csum),
-			CSUM_FORMAT_VALUE(csum_size, &csum_expected),
+			logical_start, CSUM_FORMAT_VALUE(csum_size, csum),
+			CSUM_FORMAT_VALUE(csum_size, csum_expected),
 			mirror_num);
 	else
 		btrfs_warn_rl(root->fs_info,
 	"csum failed root %llu ino %llu off %llu csum " CSUM_FORMAT " expected csum " CSUM_FORMAT " mirror %d",
 			root->root_key.objectid, btrfs_ino(inode),
-			logical_start, CSUM_FORMAT_VALUE(csum_size, &csum),
-			CSUM_FORMAT_VALUE(csum_size, &csum_expected),
+			logical_start, CSUM_FORMAT_VALUE(csum_size, csum),
+			CSUM_FORMAT_VALUE(csum_size, csum_expected),
 			mirror_num);
 }
 
diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index e027e58358be..358a85d77108 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -86,7 +86,7 @@ static int check_compressed_csum(struct btrfs_inode *inode,
 
 		if (memcmp(&csum, cb_sum, csum_size)) {
 			btrfs_print_data_csum_error(inode, disk_start,
-						    *(u32 *)csum, *(u32 *)cb_sum,
+						    csum, cb_sum,
 						    cb->mirror_num);
 			ret = -EIO;
 			goto fail;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 402c9ea8239d..af27dddcb05f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3226,8 +3226,8 @@ static int __readpage_endio_check(struct inode *inode,
 	kunmap_atomic(kaddr);
 	return 0;
 zeroit:
-	btrfs_print_data_csum_error(BTRFS_I(inode), start, *(u32 *)csum,
-				    *(u32 *)csum_expected, io_bio->mirror_num);
+	btrfs_print_data_csum_error(BTRFS_I(inode), start, csum, csum_expected,
+				    io_bio->mirror_num);
 	memset(kaddr + pgoff, 1, len);
 	flush_dcache_page(page);
 	kunmap_atomic(kaddr);
-- 
2.16.4

