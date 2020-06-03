Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 354B61EC91B
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jun 2020 07:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbgFCF4L (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Jun 2020 01:56:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:42550 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726084AbgFCF4C (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 3 Jun 2020 01:56:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id F1602B011;
        Wed,  3 Jun 2020 05:56:03 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 42/46] btrfs: Make btrfs_delalloc_reserve_space take btrfs_inode
Date:   Wed,  3 Jun 2020 08:55:42 +0300
Message-Id: <20200603055546.3889-43-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200603055546.3889-1-nborisov@suse.com>
References: <20200603055546.3889-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

All of its children take btrfs_inode so bubble up this requirement to
btrfs_delalloc_reserve_space's interface and stop calling BTRFS_I internally.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/delalloc-space.c |  8 ++++----
 fs/btrfs/delalloc-space.h |  2 +-
 fs/btrfs/inode-map.c      |  3 ++-
 fs/btrfs/inode.c          | 12 ++++++------
 fs/btrfs/ioctl.c          |  2 +-
 fs/btrfs/reflink.c        |  4 ++--
 6 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
index e5580262e4dd..d3bc86a7ad6d 100644
--- a/fs/btrfs/delalloc-space.c
+++ b/fs/btrfs/delalloc-space.c
@@ -556,17 +556,17 @@ void btrfs_delalloc_release_extents(struct btrfs_inode *inode, u64 num_bytes)
  * Return 0 for success
  * Return <0 for error(-ENOSPC or -EQUOT)
  */
-int btrfs_delalloc_reserve_space(struct inode *inode,
+int btrfs_delalloc_reserve_space(struct btrfs_inode *inode,
 			struct extent_changeset **reserved, u64 start, u64 len)
 {
 	int ret;

-	ret = btrfs_check_data_free_space(BTRFS_I(inode), reserved, start, len);
+	ret = btrfs_check_data_free_space(inode, reserved, start, len);
 	if (ret < 0)
 		return ret;
-	ret = btrfs_delalloc_reserve_metadata(BTRFS_I(inode), len);
+	ret = btrfs_delalloc_reserve_metadata(inode, len);
 	if (ret < 0)
-		btrfs_free_reserved_data_space(BTRFS_I(inode), *reserved, start, len);
+		btrfs_free_reserved_data_space(inode, *reserved, start, len);
 	return ret;
 }

diff --git a/fs/btrfs/delalloc-space.h b/fs/btrfs/delalloc-space.h
index 2722fb6d2e5b..47c5dcdc5402 100644
--- a/fs/btrfs/delalloc-space.h
+++ b/fs/btrfs/delalloc-space.h
@@ -17,7 +17,7 @@ void btrfs_free_reserved_data_space_noquota(struct btrfs_fs_info *fs_info,
 					    u64 start, u64 len);
 void btrfs_delalloc_release_metadata(struct btrfs_inode *inode, u64 num_bytes,
 				     bool qgroup_free);
-int btrfs_delalloc_reserve_space(struct inode *inode,
+int btrfs_delalloc_reserve_space(struct btrfs_inode *inode,
 			struct extent_changeset **reserved, u64 start, u64 len);

 #endif /* BTRFS_DELALLOC_SPACE_H */
diff --git a/fs/btrfs/inode-map.c b/fs/btrfs/inode-map.c
index 6009e0e939b5..76d2e43817ea 100644
--- a/fs/btrfs/inode-map.c
+++ b/fs/btrfs/inode-map.c
@@ -495,7 +495,8 @@ int btrfs_save_ino_cache(struct btrfs_root *root,
 	/* Just to make sure we have enough space */
 	prealloc += 8 * PAGE_SIZE;

-	ret = btrfs_delalloc_reserve_space(inode, &data_reserved, 0, prealloc);
+	ret = btrfs_delalloc_reserve_space(BTRFS_I(inode), &data_reserved, 0,
+					   prealloc);
 	if (ret)
 		goto out_put;

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 687b06458f1a..bad40b41f329 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2281,8 +2281,8 @@ static void btrfs_writepage_fixup_worker(struct btrfs_work *work)
 	 * This is similar to page_mkwrite, we need to reserve the space before
 	 * we take the page lock.
 	 */
-	ret = btrfs_delalloc_reserve_space(inode, &data_reserved, page_start,
-					   PAGE_SIZE);
+	ret = btrfs_delalloc_reserve_space(BTRFS_I(inode), &data_reserved,
+					   page_start, PAGE_SIZE);
 again:
 	lock_page(page);

@@ -4503,7 +4503,7 @@ int btrfs_truncate_block(struct inode *inode, loff_t from, loff_t len,
 	block_start = round_down(from, blocksize);
 	block_end = block_start + blocksize - 1;

-	ret = btrfs_delalloc_reserve_space(inode, &data_reserved,
+	ret = btrfs_delalloc_reserve_space(BTRFS_I(inode), &data_reserved,
 					   block_start, blocksize);
 	if (ret)
 		goto out;
@@ -7295,7 +7295,7 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 	dio_data->length = length;
 	if (write) {
 		dio_data->reserve = round_up(length, fs_info->sectorsize);
-		ret = btrfs_delalloc_reserve_space(inode,
+		ret = btrfs_delalloc_reserve_space(BTRFS_I(inode),
 				&dio_data->data_reserved,
 				start, dio_data->reserve);
 		if (ret) {
@@ -8098,8 +8098,8 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 	 * end up waiting indefinitely to get a lock on the page currently
 	 * being processed by btrfs_page_mkwrite() function.
 	 */
-	ret2 = btrfs_delalloc_reserve_space(inode, &data_reserved, page_start,
-					   reserved_space);
+	ret2 = btrfs_delalloc_reserve_space(BTRFS_I(inode), &data_reserved,
+					    page_start, reserved_space);
 	if (!ret2) {
 		ret2 = file_update_time(vmf->vma->vm_file);
 		reserved = 1;
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 37072628149d..dff1a9957a12 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1243,7 +1243,7 @@ static int cluster_pages_for_defrag(struct inode *inode,

 	page_cnt = min_t(u64, (u64)num_pages, (u64)file_end - start_index + 1);

-	ret = btrfs_delalloc_reserve_space(inode, &data_reserved,
+	ret = btrfs_delalloc_reserve_space(BTRFS_I(inode), &data_reserved,
 			start_index << PAGE_SHIFT,
 			page_cnt << PAGE_SHIFT);
 	if (ret)
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index 9da0f101548f..834eb6d98caa 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -68,8 +68,8 @@ static int copy_inline_to_page(struct inode *inode,
 	 * reservation here. Also we must not do the reservation while holding
 	 * a transaction open, otherwise we would deadlock.
 	 */
-	ret = btrfs_delalloc_reserve_space(inode, &data_reserved, file_offset,
-					   block_size);
+	ret = btrfs_delalloc_reserve_space(BTRFS_I(inode), &data_reserved,
+					   file_offset, block_size);
 	if (ret)
 		goto out;

--
2.17.1

