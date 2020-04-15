Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 039AA1AA25A
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Apr 2020 14:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S370596AbgDOMxx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Apr 2020 08:53:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:35164 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S370591AbgDOMxu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Apr 2020 08:53:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4612BAC44;
        Wed, 15 Apr 2020 12:53:48 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs: Make btrfs_read_disk_super return struct btrfs_disk_super
Date:   Wed, 15 Apr 2020 15:53:46 +0300
Message-Id: <20200415125346.468-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Instead of returning both the page and the super block structure, make
btrfs_read_disk_super just return a pointer to struct btrfs_disk_super.
As a result the function signature is simplified. Also,
read_cache_page_gfp can never return NULL so check its return value only
for IS_ERR.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/volumes.c | 46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index c1909e5f4506..044a8d02423a 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1251,49 +1251,49 @@ void btrfs_release_disk_super(struct btrfs_super_block *super)
 	put_page(page);
 }
 
-static int btrfs_read_disk_super(struct block_device *bdev, u64 bytenr,
-				 struct page **page,
-				 struct btrfs_super_block **disk_super)
+static struct btrfs_super_block *btrfs_read_disk_super(struct block_device *bdev,
+						       u64 bytenr)
 {
+	struct btrfs_super_block *disk_super;
+	struct page *page;
 	void *p;
 	pgoff_t index;
 
 	/* make sure our super fits in the device */
 	if (bytenr + PAGE_SIZE >= i_size_read(bdev->bd_inode))
-		return 1;
+		return ERR_PTR(-EINVAL);
 
 	/* make sure our super fits in the page */
-	if (sizeof(**disk_super) > PAGE_SIZE)
-		return 1;
+	if (sizeof(*disk_super) > PAGE_SIZE)
+		return ERR_PTR(-EINVAL);
 
 	/* make sure our super doesn't straddle pages on disk */
 	index = bytenr >> PAGE_SHIFT;
-	if ((bytenr + sizeof(**disk_super) - 1) >> PAGE_SHIFT != index)
-		return 1;
+	if ((bytenr + sizeof(*disk_super) - 1) >> PAGE_SHIFT != index)
+		return ERR_PTR(-EINVAL);
 
 	/* pull in the page with our super */
-	*page = read_cache_page_gfp(bdev->bd_inode->i_mapping,
-				   index, GFP_KERNEL);
+	page = read_cache_page_gfp(bdev->bd_inode->i_mapping, index,
+				   GFP_KERNEL);
 
-	if (IS_ERR(*page))
-		return 1;
+	if (IS_ERR(page))
+		return ERR_CAST(page);
 
-	p = page_address(*page);
+	p = page_address(page);
 
 	/* align our pointer to the offset of the super block */
-	*disk_super = p + offset_in_page(bytenr);
+	disk_super = p + offset_in_page(bytenr);
 
-	if (btrfs_super_bytenr(*disk_super) != bytenr ||
-	    btrfs_super_magic(*disk_super) != BTRFS_MAGIC) {
+	if (btrfs_super_bytenr(disk_super) != bytenr ||
+	    btrfs_super_magic(disk_super) != BTRFS_MAGIC) {
 		btrfs_release_disk_super(p);
-		return 1;
+		return ERR_PTR(-EUCLEAN);
 	}
 
-	if ((*disk_super)->label[0] &&
-		(*disk_super)->label[BTRFS_LABEL_SIZE - 1])
-		(*disk_super)->label[BTRFS_LABEL_SIZE - 1] = '\0';
+	if (disk_super->label[0] && disk_super->label[BTRFS_LABEL_SIZE - 1])
+		disk_super->label[BTRFS_LABEL_SIZE - 1] = '\0';
 
-	return 0;
+	return disk_super;
 }
 
 int btrfs_forget_devices(const char *path)
@@ -1319,7 +1319,6 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, fmode_t flags,
 	bool new_device_added = false;
 	struct btrfs_device *device = NULL;
 	struct block_device *bdev;
-	struct page *page;
 	u64 bytenr;
 
 	lockdep_assert_held(&uuid_mutex);
@@ -1337,7 +1336,8 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, fmode_t flags,
 	if (IS_ERR(bdev))
 		return ERR_CAST(bdev);
 
-	if (btrfs_read_disk_super(bdev, bytenr, &page, &disk_super)) {
+	disk_super = btrfs_read_disk_super(bdev, bytenr);
+	if (IS_ERR(disk_super)) {
 		device = ERR_PTR(-EINVAL);
 		goto error_bdev_put;
 	}
-- 
2.17.1

