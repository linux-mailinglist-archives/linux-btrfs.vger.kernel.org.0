Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35192212399
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 14:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbgGBMoG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jul 2020 08:44:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:54956 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728931AbgGBMoF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Jul 2020 08:44:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AFDBFC924;
        Thu,  2 Jul 2020 12:44:03 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 7/8] btrfs: Increment corrupt device counter during compressed read
Date:   Thu,  2 Jul 2020 15:23:34 +0300
Message-Id: <20200702122335.9117-8-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200702122335.9117-1-nborisov@suse.com>
References: <20200702122335.9117-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If a compressed read fails due to csum error only a line is printed to
dmesg, device corrupt counter is not modified.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/compression.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index db80c3fa6c08..2f30bf4127f8 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -172,8 +172,7 @@ static inline int compressed_bio_size(struct btrfs_fs_info *fs_info,
 		(DIV_ROUND_UP(disk_size, fs_info->sectorsize)) * csum_size;
 }
 
-static int check_compressed_csum(struct btrfs_inode *inode,
-				 struct compressed_bio *cb,
+static int check_compressed_csum(struct btrfs_inode *inode, struct bio *bio,
 				 u64 disk_start)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
@@ -184,6 +183,7 @@ static int check_compressed_csum(struct btrfs_inode *inode,
 	unsigned long i;
 	char *kaddr;
 	u8 csum[BTRFS_CSUM_SIZE];
+	struct compressed_bio *cb = bio->bi_private;
 	u8 *cb_sum = cb->sums;
 
 	if (inode->flags & BTRFS_INODE_NODATASUM)
@@ -201,6 +201,9 @@ static int check_compressed_csum(struct btrfs_inode *inode,
 		if (memcmp(&csum, cb_sum, csum_size)) {
 			btrfs_print_data_csum_error(inode, disk_start,
 					csum, cb_sum, cb->mirror_num);
+			if (btrfs_io_bio(bio)->dev)
+				btrfs_dev_stat_inc_and_print(btrfs_io_bio(bio)->dev,
+					BTRFS_DEV_STAT_CORRUPTION_ERRS);
 			ret = -EIO;
 			goto fail;
 		}
@@ -255,7 +258,7 @@ static void end_compressed_bio_read(struct bio *bio)
 		goto csum_failed;
 
 	inode = cb->inode;
-	ret = check_compressed_csum(BTRFS_I(inode), cb,
+	ret = check_compressed_csum(BTRFS_I(inode), bio,
 				    (u64)bio->bi_iter.bi_sector << 9);
 	if (ret)
 		goto csum_failed;
-- 
2.17.1

