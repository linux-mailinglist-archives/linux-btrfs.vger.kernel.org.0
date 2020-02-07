Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E25371552CF
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Feb 2020 08:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgBGHU7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Feb 2020 02:20:59 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:26076 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgBGHU7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Feb 2020 02:20:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581060064; x=1612596064;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HrA6DYZ65JG0L8uN7RRDpq6uL0bckMJxFyFPS+bXBEA=;
  b=GLLqikBUlQPuzjpg4vKXoMOw67Ytig/cIeojO6Twrkh7LW8lFveA5C6e
   HAMopFkgaxUP28I1ISiAGymx82mIeLVI/kQDnEBSDxPvJkq8iAjhF27h7
   IcVQOGCQP/JSGp39dXBHwvHJPSgKIv6Q8R9/rAHZn51nUgdkw7IXlydQ/
   vYSdbZBsDlBwvmiIXAP79zdvX04eCi6w/jckQHw0hyL7E86ihAN2Bf7nM
   M38CVm4t870yhyjZN26cDyCAQ7qgeSC0D7U7nFL5xpghG1NKiO3+wXCKh
   jU0ggXxZ17YXqDQqLC5CCIRANA8N3CvQtRMY3qM0pr6NZvfv2a+35nBnX
   g==;
IronPort-SDR: gZ0/8oKsMHI0xpjqstM+Ay9gIcC5Bxb+oM8dvJkN0b3inXOa5154jPtZpvc6AME4BHZD55/WWI
 hVrS4Klx0MELi6g0JTGsFyM3hclZyPfQbC00F/YUQrkej0aIyvEo14W21CVeAbKzAn9uLQPYeL
 Rr+acAORGDETzaCYDJ8du1q5dSiRlH6SeIHAwdXmN6bhQb3tNfTA8TjOtmhsi9GB+AeqMxUVhT
 9k8Mi29k67NofnSve2vrsyQ1icOa8VnpG2DSOj3Fl++cSzdJ9tnfTwWXes3NLIeMBsC7w4JZPJ
 fAU=
X-IronPort-AV: E=Sophos;i="5.70,412,1574092800"; 
   d="scan'208";a="231092228"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Feb 2020 15:20:21 +0800
IronPort-SDR: Q59OJX70b2UsuVtHIbrPVBKI5C+yDq4uGhPVBMVb8nty+s+0O699jiLW2ITW68+IRR7DCCU5Ya
 Ls5spme0G+ZGTbTxAXfF0ZH1y6u+Y2S4kGAppQt8JI0W/jRP0riY9KGj0vWzUfPSWH83zGCXCo
 Iau++MzkazMWZgOIehN2W3Iiiw78a99HHZ5jA+no3y/ayHcczDdQYi+1+/mxXpXCP1+92hPI8c
 tELCiqkCiEHFqy+pEn71OOL58jPBNRlaA6d3oqr6AT9N3t9A12Qk87DWe9Nye9lB+YVLxMKxIy
 mcOmhgFfbkrbiKj85+bYDIHb
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2020 23:13:12 -0800
IronPort-SDR: 0lRXhWo7sJzTLNkmcBvqSpZOnHDmJ79JDMggz6cx6q4mqI/w2Wi17oPxc6kGoiCKcBA7KdH6qC
 GYcO/o4cLxv6aog2a/92nxTZUfKc9P0hmhuf2DVu/IsmSgsMphb/sb/QM56LN+et1VHn/2sp1E
 IRE2L1gPnSAS63eTwR2nsoaDYqKxYsBAqa/3dlFauT7nhaq09lLmTse9hk0CqdPr5q/bOcMxd+
 6E7YJKqLr6FCKBV2Zku894Rs9Y5oZ7fGqC284YU2V78P3mzYm6/wHgtUfcB+LbGq7cExNqpusM
 9Eo=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 06 Feb 2020 23:20:14 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v5 3/7] btrfs: let btrfs_read_dev_super() return a btrfs_super_block
Date:   Fri,  7 Feb 2020 16:20:01 +0900
Message-Id: <20200207072005.22867-4-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200207072005.22867-1-johannes.thumshirn@wdc.com>
References: <20200207072005.22867-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Let btrfs_read_dev_super() return a 'struct btrfs_super_block' and
btrfs_release_disk_super() take a 'struct btrfs_disk_super' as well.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/disk-io.c | 72 +++++++++++++++++-----------------------------
 fs/btrfs/disk-io.h |  6 ++--
 fs/btrfs/volumes.c | 42 ++++++++++++---------------
 fs/btrfs/volumes.h |  2 +-
 4 files changed, 50 insertions(+), 72 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 42cd267ff978..988df20baefd 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2621,8 +2621,6 @@ int __cold open_ctree(struct super_block *sb,
 	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
 	struct btrfs_root *tree_root;
 	struct btrfs_root *chunk_root;
-	struct page *super_page;
-	u8 *superblock;
 	int ret;
 	int err = -EINVAL;
 	int clear_free_space_tree = 0;
@@ -2816,33 +2814,29 @@ int __cold open_ctree(struct super_block *sb,
 	/*
 	 * Read super block and check the signature bytes only
 	 */
-	ret = btrfs_read_dev_super(fs_devices->latest_bdev, &super_page);
-	if (ret) {
-		err = ret;
+	disk_super = btrfs_read_dev_super(fs_devices->latest_bdev);
+	if (IS_ERR(disk_super)) {
+		err = PTR_ERR(disk_super);
 		goto fail_alloc;
 	}
 
-	superblock = kmap(super_page);
 	/*
 	 * Verify the type first, if that or the the checksum value are
 	 * corrupted, we'll find out
 	 */
-	csum_type = btrfs_super_csum_type((struct btrfs_super_block *)
-					  superblock);
+	csum_type = btrfs_super_csum_type(disk_super);
 	if (!btrfs_supported_super_csum(csum_type)) {
 		btrfs_err(fs_info, "unsupported checksum algorithm: %u",
 			  csum_type);
 		err = -EINVAL;
-		kunmap(super_page);
-		put_page(super_page);
+		btrfs_release_disk_super(disk_super);
 		goto fail_alloc;
 	}
 
 	ret = btrfs_init_csum_hash(fs_info, csum_type);
 	if (ret) {
 		err = ret;
-		kunmap(super_page);
-		put_page(super_page);
+		btrfs_release_disk_super(disk_super);
 		goto fail_alloc;
 	}
 
@@ -2850,11 +2844,10 @@ int __cold open_ctree(struct super_block *sb,
 	 * We want to check superblock checksum, the type is stored inside.
 	 * Pass the whole disk block of size BTRFS_SUPER_INFO_SIZE (4k).
 	 */
-	if (btrfs_check_super_csum(fs_info, superblock)) {
+	if (btrfs_check_super_csum(fs_info, (u8 *) disk_super)) {
 		btrfs_err(fs_info, "superblock checksum mismatch");
 		err = -EINVAL;
-		kunmap(super_page);
-		put_page(super_page);
+		btrfs_release_disk_super(disk_super);
 		goto fail_csum;
 	}
 
@@ -2863,9 +2856,8 @@ int __cold open_ctree(struct super_block *sb,
 	 * following bytes up to INFO_SIZE, the checksum is calculated from
 	 * the whole block of INFO_SIZE
 	 */
-	memcpy(fs_info->super_copy, superblock, sizeof(*fs_info->super_copy));
-	kunmap(super_page);
-	put_page(super_page);
+	memcpy(fs_info->super_copy, disk_super, sizeof(*fs_info->super_copy));
+	btrfs_release_disk_super(disk_super);
 
 	disk_super = fs_info->super_copy;
 
@@ -3362,8 +3354,8 @@ static void btrfs_end_buffer_write_sync(struct buffer_head *bh, int uptodate)
 	put_bh(bh);
 }
 
-int btrfs_read_dev_one_super(struct block_device *bdev, int copy_num,
-			struct page **super_page)
+struct btrfs_super_block *btrfs_read_dev_one_super(struct block_device *bdev,
+						   int copy_num)
 {
 	struct btrfs_super_block *super;
 	struct page *page;
@@ -3372,33 +3364,28 @@ int btrfs_read_dev_one_super(struct block_device *bdev, int copy_num,
 
 	bytenr = btrfs_sb_offset(copy_num);
 	if (bytenr + BTRFS_SUPER_INFO_SIZE >= i_size_read(bdev->bd_inode))
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
 
 	page = read_cache_page_gfp(mapping, bytenr >> PAGE_SHIFT, GFP_NOFS);
 	if (IS_ERR_OR_NULL(page))
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
-	super = kmap(page);
+	super = kmap(page) + offset_in_page(bytenr);
 	if (btrfs_super_bytenr(super) != bytenr ||
 		    btrfs_super_magic(super) != BTRFS_MAGIC) {
-		kunmap(page);
-		put_page(page);
-		return -EINVAL;
+		btrfs_release_disk_super(super);
+		return ERR_PTR(-EINVAL);
 	}
-	kunmap(page);
 
-	*super_page = page;
-	return 0;
+	return super;
 }
 
 
-int btrfs_read_dev_super(struct block_device *bdev, struct page **page)
+struct btrfs_super_block *btrfs_read_dev_super(struct block_device *bdev)
 {
-	struct page *latest = NULL;
-	struct btrfs_super_block *super;
+	struct btrfs_super_block *super, *latest = NULL;
 	int i;
 	u64 transid = 0;
-	int ret = -EINVAL;
 
 	/* we would like to check all the supers, but that would make
 	 * a btrfs mount succeed after a mkfs from a different FS.
@@ -3406,25 +3393,20 @@ int btrfs_read_dev_super(struct block_device *bdev, struct page **page)
 	 * later supers, using BTRFS_SUPER_MIRROR_MAX instead
 	 */
 	for (i = 0; i < 1; i++) {
-		ret = btrfs_read_dev_one_super(bdev, i, page);
-		if (ret)
+		super = btrfs_read_dev_one_super(bdev, i);
+		if (IS_ERR(super))
 			continue;
 
-		super = kmap(*page);
-
 		if (!latest || btrfs_super_generation(super) > transid) {
-			if (latest) {
-				kunmap(latest);
-				put_page(latest);
-			}
-			latest = *page;
+			if (latest)
+				btrfs_release_disk_super(super);
+
+			latest = super;
 			transid = btrfs_super_generation(super);
 		}
-
-		kunmap(*page);
 	}
 
-	return ret;
+	return super;
 }
 
 /*
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index a89283ce8ca2..e6f41871b837 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -54,9 +54,9 @@ int __cold open_ctree(struct super_block *sb,
 	       char *options);
 void __cold close_ctree(struct btrfs_fs_info *fs_info);
 int write_all_supers(struct btrfs_fs_info *fs_info, int max_mirrors);
-int btrfs_read_dev_super(struct block_device *bdev, struct page **super_page);
-int btrfs_read_dev_one_super(struct block_device *bdev, int copy_num,
-			     struct page **super_page);
+struct btrfs_super_block *btrfs_read_dev_super(struct block_device *bdev);
+struct btrfs_super_block *btrfs_read_dev_one_super(struct block_device *bdev,
+						   int copy_num);
 int btrfs_commit_super(struct btrfs_fs_info *fs_info);
 struct btrfs_root *btrfs_read_tree_root(struct btrfs_root *tree_root,
 					struct btrfs_key *key);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 5b19e5077633..212b9170ce0e 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -499,7 +499,7 @@ static struct btrfs_fs_devices *find_fsid_with_metadata_uuid(
 static int
 btrfs_get_bdev_and_sb(const char *device_path, fmode_t flags, void *holder,
 		      int flush, struct block_device **bdev,
-		      struct page **super_page)
+		      struct btrfs_super_block **disk_super)
 {
 	int ret;
 
@@ -518,8 +518,9 @@ btrfs_get_bdev_and_sb(const char *device_path, fmode_t flags, void *holder,
 		goto error;
 	}
 	invalidate_bdev(*bdev);
-	ret = btrfs_read_dev_super(*bdev, super_page);
-	if (ret) {
+	*disk_super = btrfs_read_dev_super(*bdev);
+	if (IS_ERR(*disk_super)) {
+		ret = PTR_ERR(*disk_super);
 		blkdev_put(*bdev, flags);
 		goto error;
 	}
@@ -608,7 +609,6 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
 {
 	struct request_queue *q;
 	struct block_device *bdev;
-	struct page *super_page;
 	struct btrfs_super_block *disk_super;
 	u64 devid;
 	int ret;
@@ -619,11 +619,10 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
 		return -EINVAL;
 
 	ret = btrfs_get_bdev_and_sb(device->name->str, flags, holder, 1,
-				    &bdev, &super_page);
+				    &bdev, &disk_super);
 	if (ret)
 		return ret;
 
-	disk_super = kmap(super_page);
 	devid = btrfs_stack_device_id(&disk_super->dev_item);
 	if (devid != device->devid)
 		goto error_free_page;
@@ -664,14 +663,12 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
 		fs_devices->rw_devices++;
 		list_add_tail(&device->dev_alloc_list, &fs_devices->alloc_list);
 	}
-	kunmap(super_page);
-	put_page(super_page);
+	btrfs_release_disk_super(disk_super);
 
 	return 0;
 
 error_free_page:
-	kunmap(super_page);
-	put_page(super_page);
+	btrfs_release_disk_super(disk_super);
 	blkdev_put(bdev, flags);
 
 	return -EINVAL;
@@ -1246,8 +1243,10 @@ int btrfs_open_devices(struct btrfs_fs_devices *fs_devices,
 	return ret;
 }
 
-void btrfs_release_disk_super(struct page *page)
+void btrfs_release_disk_super(struct btrfs_super_block *super)
 {
+	struct page *page = kmap_to_page(super);
+
 	kunmap(page);
 	put_page(page);
 }
@@ -1286,7 +1285,7 @@ static int btrfs_read_disk_super(struct block_device *bdev, u64 bytenr,
 
 	if (btrfs_super_bytenr(*disk_super) != bytenr ||
 	    btrfs_super_magic(*disk_super) != BTRFS_MAGIC) {
-		btrfs_release_disk_super(*page);
+		btrfs_release_disk_super(p);
 		return 1;
 	}
 
@@ -1349,7 +1348,7 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, fmode_t flags,
 			btrfs_free_stale_devices(path, device);
 	}
 
-	btrfs_release_disk_super(page);
+	btrfs_release_disk_super(disk_super);
 
 error_bdev_put:
 	blkdev_put(bdev, flags);
@@ -2208,15 +2207,14 @@ static struct btrfs_device *btrfs_find_device_by_path(
 	u64 devid;
 	u8 *dev_uuid;
 	struct block_device *bdev;
-	struct page *super_page;
 	struct btrfs_device *device;
 
 	ret = btrfs_get_bdev_and_sb(device_path, FMODE_READ,
 				    fs_info->bdev_holder, 0, &bdev,
-				    &super_page);
+				    &disk_super);
 	if (ret)
 		return ERR_PTR(ret);
-	disk_super = kmap(super_page);
+
 	devid = btrfs_stack_device_id(&disk_super->dev_item);
 	dev_uuid = disk_super->dev_item.uuid;
 	if (btrfs_fs_incompat(fs_info, METADATA_UUID))
@@ -2226,8 +2224,7 @@ static struct btrfs_device *btrfs_find_device_by_path(
 		device = btrfs_find_device(fs_info->fs_devices, devid, dev_uuid,
 					   disk_super->fsid, true);
 
-	kunmap(super_page);
-	put_page(super_page);
+	btrfs_release_disk_super(disk_super);
 	if (!device)
 		device = ERR_PTR(-ENOENT);
 	blkdev_put(bdev, FMODE_READ);
@@ -7328,20 +7325,19 @@ void btrfs_scratch_superblocks(struct block_device *bdev, const char *device_pat
 
 	for (copy_num = 0; copy_num < BTRFS_SUPER_MIRROR_MAX;
 		copy_num++) {
-		u64 bytenr = btrfs_sb_offset(copy_num);
 		struct page *page;
 
-		if (btrfs_read_dev_one_super(bdev, copy_num, &page))
+		disk_super = btrfs_read_dev_one_super(bdev, copy_num);
+		if (IS_ERR(disk_super))
 			continue;
 
-		disk_super = kmap(page) + offset_in_page(bytenr);
 		memset(&disk_super->magic, 0, sizeof(disk_super->magic));
-		kunmap(page);
 
+		page = kmap_to_page(disk_super);
 		set_page_dirty(page);
 		lock_page(page); /* write_on_page() unlocks the page */
 		write_one_page(page);
-		put_page(page);
+		btrfs_release_disk_super(disk_super);
 
 	}
 
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 1e4ebe6d6368..ed44c45ef199 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -481,7 +481,7 @@ int btrfs_finish_chunk_alloc(struct btrfs_trans_handle *trans,
 int btrfs_remove_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset);
 struct extent_map *btrfs_get_chunk_map(struct btrfs_fs_info *fs_info,
 				       u64 logical, u64 length);
-void btrfs_release_disk_super(struct page *page);
+void btrfs_release_disk_super(struct btrfs_super_block *super);
 
 static inline void btrfs_dev_stat_inc(struct btrfs_device *dev,
 				      int index)
-- 
2.24.1

