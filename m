Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 119613B6492
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Jun 2021 17:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235889AbhF1PKi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Jun 2021 11:10:38 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:59206 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233865AbhF1PIh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Jun 2021 11:08:37 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D1FB8202BF;
        Mon, 28 Jun 2021 15:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624892770; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=oVBNUUaTet/CIP/PpTsn2kQyFw+S0dHcLkR9SsyV9rA=;
        b=swILRnGaDY9XU5+ppsDF8HM3LJG5bcySd1bAwp0ZtZR9I8YTa+sgpHVc1Kns8z0wMwd8D2
        P2c7zlhMddu87BtKhVHInibnRQ5NOo7J1LVZ1CKFg3U3v8MlYcINd2m758ldeT9e5Gel1C
        cllGvmkperdij3qOJFG4JmTolRBWxqg=
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 92C5511906;
        Mon, 28 Jun 2021 15:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624892770; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=oVBNUUaTet/CIP/PpTsn2kQyFw+S0dHcLkR9SsyV9rA=;
        b=swILRnGaDY9XU5+ppsDF8HM3LJG5bcySd1bAwp0ZtZR9I8YTa+sgpHVc1Kns8z0wMwd8D2
        P2c7zlhMddu87BtKhVHInibnRQ5NOo7J1LVZ1CKFg3U3v8MlYcINd2m758ldeT9e5Gel1C
        cllGvmkperdij3qOJFG4JmTolRBWxqg=
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id NbXlIGLl2WCLIQAALh3uQQ
        (envelope-from <nborisov@suse.com>); Mon, 28 Jun 2021 15:06:10 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs: Stop kmalloc'ing btrfs_path in btrfs_lookup_bio_sums
Date:   Mon, 28 Jun 2021 18:06:09 +0300
Message-Id: <20210628150609.2833435-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

While doing some performance characterization of a workoad reading ~80g
split among 4mb files via DIO I observed that btrfs_lookup_bio_sums was
using rather excessive cpu cycles:

95.97%--ksys_pread64
95.96%--new_sync_read
95.95%--iomap_dio_rw
95.89%--iomap_apply
72.25%--iomap_dio_bio_actor
55.19%--iomap_dio_submit_bio
55.13%--btrfs_submit_direct
20.72%--btrfs_lookup_bio_sums
7.44%-- kmem_cache_alloc

Timing the workload yielded:
real 4m41.825s
user 0m14.321s
sys 10m38.419s

Turns out this kmem_cache_alloc corresponds to the btrfs_path allocation
that happens in btrfs_lookup_bio_sums. Nothing in btrfs_lookup_bio_sums
warrants having the path be heap allocated. Just turn this allocation
into a stack based one. After the change performance changes
accordingly:

real 4m21.742s
user 0m13.679s
sys 9m8.889s

All in all there's a 20 seconds (~7%) reductino in real run time as well
as the time spent in the kernel is reduced by 1:30 minutes (~14%). And
btrfs_lookup_bio_sums ends up accounting for only 7.91% of cycles rather
than 20% before.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/file-item.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index df6631eefc65..0358ca0a69c8 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -367,7 +367,7 @@ blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio, u8 *dst
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
-	struct btrfs_path *path;
+	struct btrfs_path path = {};
 	const u32 sectorsize = fs_info->sectorsize;
 	const u32 csum_size = fs_info->csum_size;
 	u32 orig_len = bio->bi_iter.bi_size;
@@ -393,9 +393,6 @@ blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio, u8 *dst
 	 *   directly.
 	 */
 	ASSERT(bio_op(bio) == REQ_OP_READ);
-	path = btrfs_alloc_path();
-	if (!path)
-		return BLK_STS_RESOURCE;

 	if (!dst) {
 		struct btrfs_io_bio *btrfs_bio = btrfs_io_bio(bio);
@@ -403,10 +400,8 @@ blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio, u8 *dst
 		if (nblocks * csum_size > BTRFS_BIO_INLINE_CSUM_SIZE) {
 			btrfs_bio->csum = kmalloc_array(nblocks, csum_size,
 							GFP_NOFS);
-			if (!btrfs_bio->csum) {
-				btrfs_free_path(path);
+			if (!btrfs_bio->csum)
 				return BLK_STS_RESOURCE;
-			}
 		} else {
 			btrfs_bio->csum = btrfs_bio->csum_inline;
 		}
@@ -420,7 +415,7 @@ blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio, u8 *dst
 	 * kick the readahead for csum tree.
 	 */
 	if (nblocks > fs_info->csums_per_leaf)
-		path->reada = READA_FORWARD;
+		path.reada = READA_FORWARD;

 	/*
 	 * the free space stuff is only read when it hasn't been
@@ -429,8 +424,8 @@ blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio, u8 *dst
 	 * between reading the free space cache and updating the csum tree.
 	 */
 	if (btrfs_is_free_space_inode(BTRFS_I(inode))) {
-		path->search_commit_root = 1;
-		path->skip_locking = 1;
+		path.search_commit_root = 1;
+		path.skip_locking = 1;
 	}

 	for (cur_disk_bytenr = orig_disk_bytenr;
@@ -453,7 +448,7 @@ blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio, u8 *dst
 				fs_info->sectorsize_bits;
 		csum_dst = csum + sector_offset * csum_size;

-		count = search_csum_tree(fs_info, path, cur_disk_bytenr,
+		count = search_csum_tree(fs_info, &path, cur_disk_bytenr,
 					 search_len, csum_dst);
 		if (count <= 0) {
 			/*
@@ -489,7 +484,7 @@ blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio, u8 *dst
 		}
 	}

-	btrfs_free_path(path);
+	btrfs_release_path(&path);
 	return BLK_STS_OK;
 }

--
2.25.1

