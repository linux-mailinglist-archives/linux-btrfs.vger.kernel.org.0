Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D796140A25
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 13:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgAQMvM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 07:51:12 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:51277 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbgAQMvM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 07:51:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1579265472; x=1610801472;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OhMw4LY1G6uS8EAgIEblclvhtEtzYdK67n7w4ZlDcKA=;
  b=ilGB7SRx8Yx2idNfnuHE+2YXnA4pqYC6VahOgnuvjrzYq6CA/7gDQZBG
   cOJrUuWQhofN7tkQBNJbLOg+uZ81J9MbZs1oBtFimPLPcOAwQcSURYwKp
   Yg/M1f99R5QYSrJ2lYI+QhDt9xxLowydGPhXKf21pQmEWdP3h8lr2o/j9
   9Mcsn2T9EUFo9Fl3ywIOWufLmA4pFe3YP/LSecR1/cmE1QY32uMTdigNO
   VERPq1wdWBtWpxiR33LlimoY2263rO52mTRtKdX6ipCNLzly8cX6pdTv/
   h0OAFLgFR+V7hihTKlxrm3oMaCn09YfL9NtZXPXOTiCuqftqzjKbCshPM
   Q==;
IronPort-SDR: Eqx82xe25k5Go7zrK7oojPkVKIX+GM9A7wqsQ5qhGaQ4NtwbZlWHPTIJhX55dGaICdvT/0gNJs
 JjLHU/xJhy8q0FN/N22Udlsfs0XdNIl82EbtK9enGxlNnHtAzxZ3ubzL/Y3oyfk7uMDBnhrUyA
 5NxBdDOAzkTEleOJrgPrEYNnluxDQxza3z12MOuMMXTZR3hJMlS36m65FMbjT8wXyaSpkF2P03
 R8uuvFlXvouvOCBaXQ4EFTWHT7ZjwTNGaPaUnbjQsHFZrbZ0p9FJjIfMV4XZ58I5hu+oigQZ/j
 mO8=
X-IronPort-AV: E=Sophos;i="5.70,330,1574092800"; 
   d="scan'208";a="235550979"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jan 2020 20:51:11 +0800
IronPort-SDR: iXw8Ss6m+fLj1k3E6Fqgh+8KAoMFjP0HagKHm/RNstR3uhalDKR+xborKxJOSMrsptQmhER87M
 Hin8GPGDx1W4vDnnpHGL3zmkPmzEtfaRGsRF+V/M1FSe6JBN0USsItNxGYz1npcVRwnqGZ3sNk
 52sWRgPntvX3QcGV9XoLYVpPbHBtLCX2Q09a+L0Is9XAhpjeuAXUZlM3eI1PzvkuFSUbrkbRYx
 gJWJkHF6sbuTjjZQNoc7y1VNZ3f88u6eepa29CdekSbSBnaWjJ8Y9M07CIS0hHr0Y2bEgDxCIc
 Vh7Hhgm3mzuI7ucMxlnpWRIc
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2020 04:44:45 -0800
IronPort-SDR: HZfHXIUquzaYOwy4LW5sEJ3bymGB/6EJLpK2wLwl9DUdf+4EnO4sEYW14YjxcwckUsGqbkDCyd
 ZJDow7dcCHbKMxtAMiIf5doci9QqYHJeaJjrcC7hOJeFYj1ptD8epjkedL6O+OkOsEe45Xbou5
 D0v79RzFsbkR0DuvHR6zEJuH1MXHvZkEnuVczhrwKWWX1BLv9GQCarle23XomTqBeIfJrZEo2n
 bh4KygHpIkhXwWKx3RoudyeNqAnhLmPsVhm4NHz7FvXvX04qWsm3N8ngl0kTwlZcmfTMe+4uA7
 pTg=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 17 Jan 2020 04:51:11 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 1/5] btrfs: remove buffer heads from super block reading
Date:   Fri, 17 Jan 2020 21:51:01 +0900
Message-Id: <20200117125105.20989-2-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117125105.20989-1-johannes.thumshirn@wdc.com>
References: <20200117125105.20989-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Super-block reading in BTRFS is done using buffer_heads. Buffer_heads have
some drawbacks, like not being able to propagate errors from the lower
layers.

Change the buffer_heads to BIOs.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/disk-io.c | 80 +++++++++++++++++++++++++++-------------------
 fs/btrfs/disk-io.h |  4 +--
 fs/btrfs/volumes.c | 64 ++++++++++++++++++++++---------------
 fs/btrfs/volumes.h |  2 --
 4 files changed, 88 insertions(+), 62 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 5ce2801f8388..50c93ffe8d03 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2635,11 +2635,11 @@ int __cold open_ctree(struct super_block *sb,
 	u64 features;
 	u16 csum_type;
 	struct btrfs_key location;
-	struct buffer_head *bh;
 	struct btrfs_super_block *disk_super;
 	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
 	struct btrfs_root *tree_root;
 	struct btrfs_root *chunk_root;
+	struct page *super_page;
 	int ret;
 	int err = -EINVAL;
 	int clear_free_space_tree = 0;
@@ -2832,39 +2832,37 @@ int __cold open_ctree(struct super_block *sb,
 	/*
 	 * Read super block and check the signature bytes only
 	 */
-	bh = btrfs_read_dev_super(fs_devices->latest_bdev);
-	if (IS_ERR(bh)) {
-		err = PTR_ERR(bh);
-		goto fail_alloc;
+	ret = btrfs_read_dev_super(fs_devices->latest_bdev, &super_page);
+	if (ret) {
+		err = ret;
+		goto fail_page_alloc;
 	}
 
 	/*
 	 * Verify the type first, if that or the the checksum value are
 	 * corrupted, we'll find out
 	 */
-	csum_type = btrfs_super_csum_type((struct btrfs_super_block *)bh->b_data);
+	csum_type = btrfs_super_csum_type(page_address(super_page));
 	if (!btrfs_supported_super_csum(csum_type)) {
 		btrfs_err(fs_info, "unsupported checksum algorithm: %u",
 			  csum_type);
 		err = -EINVAL;
-		brelse(bh);
-		goto fail_alloc;
+		goto fail_page_alloc;
 	}
 
 	ret = btrfs_init_csum_hash(fs_info, csum_type);
 	if (ret) {
 		err = ret;
-		goto fail_alloc;
+		goto fail_page_alloc;
 	}
 
 	/*
 	 * We want to check superblock checksum, the type is stored inside.
 	 * Pass the whole disk block of size BTRFS_SUPER_INFO_SIZE (4k).
 	 */
-	if (btrfs_check_super_csum(fs_info, bh->b_data)) {
+	if (btrfs_check_super_csum(fs_info, page_address(super_page))) {
 		btrfs_err(fs_info, "superblock checksum mismatch");
 		err = -EINVAL;
-		brelse(bh);
 		goto fail_csum;
 	}
 
@@ -2873,8 +2871,9 @@ int __cold open_ctree(struct super_block *sb,
 	 * following bytes up to INFO_SIZE, the checksum is calculated from
 	 * the whole block of INFO_SIZE
 	 */
-	memcpy(fs_info->super_copy, bh->b_data, sizeof(*fs_info->super_copy));
-	brelse(bh);
+	memcpy(fs_info->super_copy, page_address(super_page),
+	       sizeof(*fs_info->super_copy));
+	__free_page(super_page);
 
 	disk_super = fs_info->super_copy;
 
@@ -3330,6 +3329,8 @@ int __cold open_ctree(struct super_block *sb,
 	btrfs_free_block_groups(fs_info);
 fail_csum:
 	btrfs_free_csum_hash(fs_info);
+fail_page_alloc:
+	__free_page(super_page);
 fail_alloc:
 fail_iput:
 	btrfs_mapping_tree_free(&fs_info->mapping_tree);
@@ -3374,40 +3375,52 @@ static void btrfs_end_buffer_write_sync(struct buffer_head *bh, int uptodate)
 }
 
 int btrfs_read_dev_one_super(struct block_device *bdev, int copy_num,
-			struct buffer_head **bh_ret)
+			struct page **super_page)
 {
-	struct buffer_head *bh;
 	struct btrfs_super_block *super;
+	struct bio_vec bio_vec;
+	struct bio bio;
+	struct page *page;
 	u64 bytenr;
+	gfp_t gfp_mask = mapping_gfp_constraint(bdev->bd_inode->i_mapping,
+						~__GFP_FS) | __GFP_NOFAIL;
+	int ret;
 
 	bytenr = btrfs_sb_offset(copy_num);
 	if (bytenr + BTRFS_SUPER_INFO_SIZE >= i_size_read(bdev->bd_inode))
 		return -EINVAL;
 
-	bh = __bread(bdev, bytenr / BTRFS_BDEV_BLOCKSIZE, BTRFS_SUPER_INFO_SIZE);
+	page = alloc_page(gfp_mask);
+	if (!page)
+		return -ENOMEM;
+
+	bio_init(&bio, &bio_vec, 1);
+	bio.bi_iter.bi_sector = bytenr >> SECTOR_SHIFT;
+	bio_set_dev(&bio, bdev);
+	bio_set_op_attrs(&bio, REQ_OP_READ, 0);
+	bio_add_page(&bio, page, BTRFS_SUPER_INFO_SIZE, 0);
+
+	ret = submit_bio_wait(&bio);
 	/*
 	 * If we fail to read from the underlying devices, as of now
 	 * the best option we have is to mark it EIO.
 	 */
-	if (!bh)
+	if (ret)
 		return -EIO;
 
-	super = (struct btrfs_super_block *)bh->b_data;
+	super = page_address(page);
 	if (btrfs_super_bytenr(super) != bytenr ||
-		    btrfs_super_magic(super) != BTRFS_MAGIC) {
-		brelse(bh);
+		    btrfs_super_magic(super) != BTRFS_MAGIC)
 		return -EINVAL;
-	}
 
-	*bh_ret = bh;
+	*super_page = page;
 	return 0;
 }
 
 
-struct buffer_head *btrfs_read_dev_super(struct block_device *bdev)
+int btrfs_read_dev_super(struct block_device *bdev, struct page **page)
 {
-	struct buffer_head *bh;
-	struct buffer_head *latest = NULL;
+	struct page *latest = NULL;
 	struct btrfs_super_block *super;
 	int i;
 	u64 transid = 0;
@@ -3419,25 +3432,26 @@ struct buffer_head *btrfs_read_dev_super(struct block_device *bdev)
 	 * later supers, using BTRFS_SUPER_MIRROR_MAX instead
 	 */
 	for (i = 0; i < 1; i++) {
-		ret = btrfs_read_dev_one_super(bdev, i, &bh);
+		ret = btrfs_read_dev_one_super(bdev, i, page);
 		if (ret)
 			continue;
 
-		super = (struct btrfs_super_block *)bh->b_data;
+		super = page_address(*page);
 
 		if (!latest || btrfs_super_generation(super) > transid) {
-			brelse(latest);
-			latest = bh;
+			if (latest)
+				__free_page(latest);
+			latest = *page;
 			transid = btrfs_super_generation(super);
 		} else {
-			brelse(bh);
+			__free_page(*page);
 		}
 	}
 
-	if (!latest)
-		return ERR_PTR(ret);
+	if (ret)
+		return ret;
 
-	return latest;
+	return 0;
 }
 
 /*
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 8c2d6cf1ce59..e04b233c436a 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -54,9 +54,9 @@ int __cold open_ctree(struct super_block *sb,
 	       char *options);
 void __cold close_ctree(struct btrfs_fs_info *fs_info);
 int write_all_supers(struct btrfs_fs_info *fs_info, int max_mirrors);
-struct buffer_head *btrfs_read_dev_super(struct block_device *bdev);
+int btrfs_read_dev_super(struct block_device *bdev, struct page **super_page);
 int btrfs_read_dev_one_super(struct block_device *bdev, int copy_num,
-			struct buffer_head **bh_ret);
+			     struct page **super_page);
 int btrfs_commit_super(struct btrfs_fs_info *fs_info);
 struct btrfs_root *btrfs_read_fs_root(struct btrfs_root *tree_root,
 				      struct btrfs_key *location);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 3d5714bf2e32..4aded417a7d1 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6,7 +6,6 @@
 #include <linux/sched.h>
 #include <linux/bio.h>
 #include <linux/slab.h>
-#include <linux/buffer_head.h>
 #include <linux/blkdev.h>
 #include <linux/ratelimit.h>
 #include <linux/kthread.h>
@@ -492,7 +491,7 @@ static noinline struct btrfs_fs_devices *find_fsid(
 static int
 btrfs_get_bdev_and_sb(const char *device_path, fmode_t flags, void *holder,
 		      int flush, struct block_device **bdev,
-		      struct buffer_head **bh)
+		      struct page **super_page)
 {
 	int ret;
 
@@ -511,9 +510,8 @@ btrfs_get_bdev_and_sb(const char *device_path, fmode_t flags, void *holder,
 		goto error;
 	}
 	invalidate_bdev(*bdev);
-	*bh = btrfs_read_dev_super(*bdev);
-	if (IS_ERR(*bh)) {
-		ret = PTR_ERR(*bh);
+	ret = btrfs_read_dev_super(*bdev, super_page);
+	if (ret) {
 		blkdev_put(*bdev, flags);
 		goto error;
 	}
@@ -522,7 +520,6 @@ btrfs_get_bdev_and_sb(const char *device_path, fmode_t flags, void *holder,
 
 error:
 	*bdev = NULL;
-	*bh = NULL;
 	return ret;
 }
 
@@ -603,7 +600,7 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
 {
 	struct request_queue *q;
 	struct block_device *bdev;
-	struct buffer_head *bh;
+	struct page *super_page;
 	struct btrfs_super_block *disk_super;
 	u64 devid;
 	int ret;
@@ -614,17 +611,17 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
 		return -EINVAL;
 
 	ret = btrfs_get_bdev_and_sb(device->name->str, flags, holder, 1,
-				    &bdev, &bh);
+				    &bdev, &super_page);
 	if (ret)
 		return ret;
 
-	disk_super = (struct btrfs_super_block *)bh->b_data;
+	disk_super = page_address(super_page);
 	devid = btrfs_stack_device_id(&disk_super->dev_item);
 	if (devid != device->devid)
-		goto error_brelse;
+		goto error_free_page;
 
 	if (memcmp(device->uuid, disk_super->dev_item.uuid, BTRFS_UUID_SIZE))
-		goto error_brelse;
+		goto error_free_page;
 
 	device->generation = btrfs_super_generation(disk_super);
 
@@ -633,7 +630,7 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
 		    BTRFS_FEATURE_INCOMPAT_METADATA_UUID) {
 			pr_err(
 		"BTRFS: Invalid seeding and uuid-changed device detected\n");
-			goto error_brelse;
+			goto error_free_page;
 		}
 
 		clear_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state);
@@ -659,12 +656,12 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
 		fs_devices->rw_devices++;
 		list_add_tail(&device->dev_alloc_list, &fs_devices->alloc_list);
 	}
-	brelse(bh);
+	__free_page(super_page);
 
 	return 0;
 
-error_brelse:
-	brelse(bh);
+error_free_page:
+	__free_page(super_page);
 	blkdev_put(bdev, flags);
 
 	return -EINVAL;
@@ -2164,14 +2161,15 @@ static struct btrfs_device *btrfs_find_device_by_path(
 	u64 devid;
 	u8 *dev_uuid;
 	struct block_device *bdev;
-	struct buffer_head *bh;
+	struct page *super_page;
 	struct btrfs_device *device;
 
 	ret = btrfs_get_bdev_and_sb(device_path, FMODE_READ,
-				    fs_info->bdev_holder, 0, &bdev, &bh);
+				    fs_info->bdev_holder, 0, &bdev,
+				    &super_page);
 	if (ret)
 		return ERR_PTR(ret);
-	disk_super = (struct btrfs_super_block *)bh->b_data;
+	disk_super = page_address(super_page);
 	devid = btrfs_stack_device_id(&disk_super->dev_item);
 	dev_uuid = disk_super->dev_item.uuid;
 	if (btrfs_fs_incompat(fs_info, METADATA_UUID))
@@ -2181,7 +2179,7 @@ static struct btrfs_device *btrfs_find_device_by_path(
 		device = btrfs_find_device(fs_info->fs_devices, devid, dev_uuid,
 					   disk_super->fsid, true);
 
-	brelse(bh);
+	__free_page(super_page);
 	if (!device)
 		device = ERR_PTR(-ENOENT);
 	blkdev_put(bdev, FMODE_READ);
@@ -7270,25 +7268,41 @@ int btrfs_get_dev_stats(struct btrfs_fs_info *fs_info,
 
 void btrfs_scratch_superblocks(struct block_device *bdev, const char *device_path)
 {
-	struct buffer_head *bh;
+	struct page *super_page;
+	struct bio_vec bio_vec;
+	struct bio bio;
 	struct btrfs_super_block *disk_super;
 	int copy_num;
+	int ret;
 
 	if (!bdev)
 		return;
 
+	bio_init(&bio, &bio_vec, 1);
 	for (copy_num = 0; copy_num < BTRFS_SUPER_MIRROR_MAX;
 		copy_num++) {
+		u64 bytenr;
 
-		if (btrfs_read_dev_one_super(bdev, copy_num, &bh))
+		if (btrfs_read_dev_one_super(bdev, copy_num, &super_page))
 			continue;
 
-		disk_super = (struct btrfs_super_block *)bh->b_data;
+		disk_super = page_address(super_page);
 
 		memset(&disk_super->magic, 0, sizeof(disk_super->magic));
-		set_buffer_dirty(bh);
-		sync_dirty_buffer(bh);
-		brelse(bh);
+
+		bytenr = btrfs_sb_offset(copy_num);
+
+		bio.bi_iter.bi_sector = bytenr >> SECTOR_SHIFT;
+		bio_set_dev(&bio, bdev);
+		bio_set_op_attrs(&bio, REQ_OP_WRITE, 0);
+		bio_add_page(&bio, super_page, PAGE_SIZE, 0);
+
+		ret = submit_bio_wait(&bio);
+		WARN_ON(ret);
+
+		__free_page(super_page);
+		bio_reset(&bio);
+
 	}
 
 	/* Notify udev that device has changed */
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 9c7d4fe5c39a..46a65b15eb93 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -17,8 +17,6 @@ extern struct mutex uuid_mutex;
 
 #define BTRFS_STRIPE_LEN	SZ_64K
 
-struct buffer_head;
-
 struct btrfs_io_geometry {
 	/* remaining bytes before crossing a stripe */
 	u64 len;
-- 
2.24.1

