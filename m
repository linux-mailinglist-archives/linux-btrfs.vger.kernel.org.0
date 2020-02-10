Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2FE815825F
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Feb 2020 19:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbgBJScg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Feb 2020 13:32:36 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:25711 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbgBJScf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Feb 2020 13:32:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581359555; x=1612895555;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D47LXCA8t39xx5Hzc5XN65jU2t+Yt2tDcZkQmt56CMM=;
  b=cpfH+v12k8kUaXJJqodqxjCloXDrc1zYenXd88jaODH2XIsIjo7YPM85
   M9FP0n+usYBuFKSwOkZbb2Evp5DLV2QKlhSwdEfrZdsuPvBc+DafEQH8z
   0lLRVvAcUp6wTcEdxfMcoaHQfDtPmjt+j21B5kj8U9Vw8mSN6ZftkK1px
   uxt/ubpr8H0j2MApp09QbaTk2X6fbvIJ9YFX4HCq1J6uMPl5FfF9U1GVs
   5hdVQ8jjdwDpkTBcpewuCwfJK5XkDyTlIGVa2XcG1un1MQHBpQEL1LdXD
   6kEvbd5pVrS69tYUWgrY4vTAMOJyys+d8rzARepheGuc/F8iBV7BgkHkJ
   g==;
IronPort-SDR: QPsM0MnyGd2pYSpm9Dyeqe9FPqGID0ggFKl89Blp9fTWiH+fwwDN4BO1fpSyWORl9UjaTIzq/x
 LjO23lGbvQcsjwITARfMqWe6KmLl5nba2rL+rW7LESw4VWsxPCEWvCY1a6BKCGsJrsRK3F+Mpv
 ub75QzgcurlAWKl2JrGzZtJ45cvkpSsoaCawkPXMLx4olf5UM7t2cxHi6xYPfXx+oWad9e8h6g
 Q2e20IyNhStAi5EPhxv/GoJs5IfWbQleN1bcgYYDZewcSA1Uix93v1vBcVFCM8+hu1pLVifeKh
 siQ=
X-IronPort-AV: E=Sophos;i="5.70,425,1574092800"; 
   d="scan'208";a="237529184"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Feb 2020 02:32:34 +0800
IronPort-SDR: SqomkfQAmjEglYQkutuAoDN5cN8dQ/wk+uHVmPHfH3DZ7hPAO7pXlQuqS87TWJFYVmSqHq2kDQ
 xHBxm23+ruAJbpysKFp9GiYf+EJvGXz2TcFAIKXk34DmTN1mGszrvRaVnTvrfXaQp9/g4yi511
 7Eb1/AJMPx0xMWnZyoV6qK9zrhLnJ7W9Y4zGWvBSWstwtuaAeEecKrMCy1leaLvQL+eTpyIlYY
 EpAlUcUSX1uSSi3tjVB05ytX3ApvmauSBi1sOwdo87rUnpcvAlKVidA3c23ZXvgEt4z+5Hlazl
 UQi2LeT7WtuF754Wi7QiRQHp
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2020 10:25:27 -0800
IronPort-SDR: 8Q1vrceP9jTOAPxi1sW7QhdC2dCtljPOq3Q8/PSq1HgeTzPO/d+jEI4tQqr0zcdX2vaIQDq2os
 3NBv34J3Aj5x8wBes9zuljN0Fz/J3w/Jd3EFpy1CtA7sImIU4+1OVrpCvJ11mVXcZlL4VmkxCB
 NcUeD46UncVR7MXNo4Vqg+WRRKvGMNv6j3jKyrgDjy2oPJqQBCxZV97pntNMbmsmXyvz4dtcs6
 pS+so8t0ByEtYBEZmx909GFStFm9JSYBSnuK7em3i4NivIUruYNzR0F9twHT4xRojNcsYuERTo
 l30=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 10 Feb 2020 10:32:33 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v6 3/7] btrfs: use the page-cache for super block reading
Date:   Tue, 11 Feb 2020 03:32:21 +0900
Message-Id: <20200210183225.10137-4-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200210183225.10137-1-johannes.thumshirn@wdc.com>
References: <20200210183225.10137-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Super-block reading in BTRFS is done using buffer_heads. Buffer_heads have
some drawbacks, like not being able to propagate errors from the lower
layers.

Directly use the page cache for reading the super-blocks from disk or
invalidating an on-disk super-block. We have to use the page-cache so to
avoid races between mkfs and udev. See also 6f60cbd3ae44 ("btrfs: access
superblock via pagecache in scan_one_device").

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

---
Changes to v5:
- Removed kmap()/kunmap() calls (hch/David)

Changes to v4:
- Remove mapping_gfp_constraint() and GFP_NOFAIL (hch)

Changes to v3:
- Use read_cache_pages() and write_one_page() for IO (hch)
- Changed subject (David)
- Dropped Josef's R-b due to change

Changes to v2:
- open-code kunmap() + put_page() (David)
- fix double kunmap() (David)
- don't use bi_set_op_attrs() (David)

Changes to v1:
- move 'super_page' into for-loop in btrfs_scratch_superblocks() (Nikolay)
- switch to using pagecahce instead of alloc_pages() (Nikolay, David)
---
 fs/btrfs/disk-io.c | 74 +++++++++++++++++++---------------------------
 fs/btrfs/disk-io.h |  6 ++--
 fs/btrfs/volumes.c | 59 ++++++++++++++++++------------------
 fs/btrfs/volumes.h |  4 +--
 4 files changed, 65 insertions(+), 78 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 018681ec159b..9f422edd6cce 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2850,7 +2850,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	u64 features;
 	u16 csum_type;
 	struct btrfs_key location;
-	struct buffer_head *bh;
 	struct btrfs_super_block *disk_super;
 	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
 	struct btrfs_root *tree_root;
@@ -2891,9 +2890,9 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	/*
 	 * Read super block and check the signature bytes only
 	 */
-	bh = btrfs_read_dev_super(fs_devices->latest_bdev);
-	if (IS_ERR(bh)) {
-		err = PTR_ERR(bh);
+	disk_super = btrfs_read_dev_super(fs_devices->latest_bdev);
+	if (IS_ERR(disk_super)) {
+		err = PTR_ERR(disk_super);
 		goto fail_alloc;
 	}
 
@@ -2901,18 +2900,19 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	 * Verify the type first, if that or the the checksum value are
 	 * corrupted, we'll find out
 	 */
-	csum_type = btrfs_super_csum_type((struct btrfs_super_block *)bh->b_data);
+	csum_type = btrfs_super_csum_type(disk_super);
 	if (!btrfs_supported_super_csum(csum_type)) {
 		btrfs_err(fs_info, "unsupported checksum algorithm: %u",
 			  csum_type);
 		err = -EINVAL;
-		brelse(bh);
+		btrfs_release_disk_super(disk_super);
 		goto fail_alloc;
 	}
 
 	ret = btrfs_init_csum_hash(fs_info, csum_type);
 	if (ret) {
 		err = ret;
+		btrfs_release_disk_super(disk_super);
 		goto fail_alloc;
 	}
 
@@ -2920,10 +2920,10 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	 * We want to check superblock checksum, the type is stored inside.
 	 * Pass the whole disk block of size BTRFS_SUPER_INFO_SIZE (4k).
 	 */
-	if (btrfs_check_super_csum(fs_info, bh->b_data)) {
+	if (btrfs_check_super_csum(fs_info, (u8 *) disk_super)) {
 		btrfs_err(fs_info, "superblock checksum mismatch");
 		err = -EINVAL;
-		brelse(bh);
+		btrfs_release_disk_super(disk_super);
 		goto fail_alloc;
 	}
 
@@ -2932,8 +2932,8 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	 * following bytes up to INFO_SIZE, the checksum is calculated from
 	 * the whole block of INFO_SIZE
 	 */
-	memcpy(fs_info->super_copy, bh->b_data, sizeof(*fs_info->super_copy));
-	brelse(bh);
+	memcpy(fs_info->super_copy, disk_super, sizeof(*fs_info->super_copy));
+	btrfs_release_disk_super(disk_super);
 
 	disk_super = fs_info->super_copy;
 
@@ -3419,45 +3419,38 @@ static void btrfs_end_buffer_write_sync(struct buffer_head *bh, int uptodate)
 	put_bh(bh);
 }
 
-int btrfs_read_dev_one_super(struct block_device *bdev, int copy_num,
-			struct buffer_head **bh_ret)
+struct btrfs_super_block *btrfs_read_dev_one_super(struct block_device *bdev,
+						   int copy_num)
 {
-	struct buffer_head *bh;
 	struct btrfs_super_block *super;
+	struct page *page;
 	u64 bytenr;
+	struct address_space *mapping = bdev->bd_inode->i_mapping;
 
 	bytenr = btrfs_sb_offset(copy_num);
 	if (bytenr + BTRFS_SUPER_INFO_SIZE >= i_size_read(bdev->bd_inode))
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
 
-	bh = __bread(bdev, bytenr / BTRFS_BDEV_BLOCKSIZE, BTRFS_SUPER_INFO_SIZE);
-	/*
-	 * If we fail to read from the underlying devices, as of now
-	 * the best option we have is to mark it EIO.
-	 */
-	if (!bh)
-		return -EIO;
+	page = read_cache_page_gfp(mapping, bytenr >> PAGE_SHIFT, GFP_NOFS);
+	if (IS_ERR(page))
+		return ERR_PTR(-ENOMEM);
 
-	super = (struct btrfs_super_block *)bh->b_data;
+	super = page_address(page);
 	if (btrfs_super_bytenr(super) != bytenr ||
 		    btrfs_super_magic(super) != BTRFS_MAGIC) {
-		brelse(bh);
-		return -EINVAL;
+		btrfs_release_disk_super(super);
+		return ERR_PTR(-EINVAL);
 	}
 
-	*bh_ret = bh;
-	return 0;
+	return super;
 }
 
 
-struct buffer_head *btrfs_read_dev_super(struct block_device *bdev)
+struct btrfs_super_block *btrfs_read_dev_super(struct block_device *bdev)
 {
-	struct buffer_head *bh;
-	struct buffer_head *latest = NULL;
-	struct btrfs_super_block *super;
+	struct btrfs_super_block *super, *latest = NULL;
 	int i;
 	u64 transid = 0;
-	int ret = -EINVAL;
 
 	/* we would like to check all the supers, but that would make
 	 * a btrfs mount succeed after a mkfs from a different FS.
@@ -3465,25 +3458,20 @@ struct buffer_head *btrfs_read_dev_super(struct block_device *bdev)
 	 * later supers, using BTRFS_SUPER_MIRROR_MAX instead
 	 */
 	for (i = 0; i < 1; i++) {
-		ret = btrfs_read_dev_one_super(bdev, i, &bh);
-		if (ret)
+		super = btrfs_read_dev_one_super(bdev, i);
+		if (IS_ERR(super))
 			continue;
 
-		super = (struct btrfs_super_block *)bh->b_data;
-
 		if (!latest || btrfs_super_generation(super) > transid) {
-			brelse(latest);
-			latest = bh;
+			if (latest)
+				btrfs_release_disk_super(super);
+
+			latest = super;
 			transid = btrfs_super_generation(super);
-		} else {
-			brelse(bh);
 		}
 	}
 
-	if (!latest)
-		return ERR_PTR(ret);
-
-	return latest;
+	return super;
 }
 
 /*
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index db21ab614357..59c885860bf8 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -56,9 +56,9 @@ int __cold open_ctree(struct super_block *sb,
 	       char *options);
 void __cold close_ctree(struct btrfs_fs_info *fs_info);
 int write_all_supers(struct btrfs_fs_info *fs_info, int max_mirrors);
-struct buffer_head *btrfs_read_dev_super(struct block_device *bdev);
-int btrfs_read_dev_one_super(struct block_device *bdev, int copy_num,
-			struct buffer_head **bh_ret);
+struct btrfs_super_block *btrfs_read_dev_super(struct block_device *bdev);
+struct btrfs_super_block *btrfs_read_dev_one_super(struct block_device *bdev,
+						   int copy_num);
 int btrfs_commit_super(struct btrfs_fs_info *fs_info);
 struct btrfs_root *btrfs_read_tree_root(struct btrfs_root *tree_root,
 					struct btrfs_key *key);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 620794f1ea64..d338dd0921d1 100644
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
@@ -500,7 +499,7 @@ static struct btrfs_fs_devices *find_fsid_with_metadata_uuid(
 static int
 btrfs_get_bdev_and_sb(const char *device_path, fmode_t flags, void *holder,
 		      int flush, struct block_device **bdev,
-		      struct buffer_head **bh)
+		      struct btrfs_super_block **disk_super)
 {
 	int ret;
 
@@ -519,9 +518,9 @@ btrfs_get_bdev_and_sb(const char *device_path, fmode_t flags, void *holder,
 		goto error;
 	}
 	invalidate_bdev(*bdev);
-	*bh = btrfs_read_dev_super(*bdev);
-	if (IS_ERR(*bh)) {
-		ret = PTR_ERR(*bh);
+	*disk_super = btrfs_read_dev_super(*bdev);
+	if (IS_ERR(*disk_super)) {
+		ret = PTR_ERR(*disk_super);
 		blkdev_put(*bdev, flags);
 		goto error;
 	}
@@ -530,7 +529,6 @@ btrfs_get_bdev_and_sb(const char *device_path, fmode_t flags, void *holder,
 
 error:
 	*bdev = NULL;
-	*bh = NULL;
 	return ret;
 }
 
@@ -611,7 +609,6 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
 {
 	struct request_queue *q;
 	struct block_device *bdev;
-	struct buffer_head *bh;
 	struct btrfs_super_block *disk_super;
 	u64 devid;
 	int ret;
@@ -622,17 +619,16 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
 		return -EINVAL;
 
 	ret = btrfs_get_bdev_and_sb(device->name->str, flags, holder, 1,
-				    &bdev, &bh);
+				    &bdev, &disk_super);
 	if (ret)
 		return ret;
 
-	disk_super = (struct btrfs_super_block *)bh->b_data;
 	devid = btrfs_stack_device_id(&disk_super->dev_item);
 	if (devid != device->devid)
-		goto error_brelse;
+		goto error_free_page;
 
 	if (memcmp(device->uuid, disk_super->dev_item.uuid, BTRFS_UUID_SIZE))
-		goto error_brelse;
+		goto error_free_page;
 
 	device->generation = btrfs_super_generation(disk_super);
 
@@ -641,7 +637,7 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
 		    BTRFS_FEATURE_INCOMPAT_METADATA_UUID) {
 			pr_err(
 		"BTRFS: Invalid seeding and uuid-changed device detected\n");
-			goto error_brelse;
+			goto error_free_page;
 		}
 
 		clear_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state);
@@ -667,12 +663,12 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
 		fs_devices->rw_devices++;
 		list_add_tail(&device->dev_alloc_list, &fs_devices->alloc_list);
 	}
-	brelse(bh);
+	btrfs_release_disk_super(disk_super);
 
 	return 0;
 
-error_brelse:
-	brelse(bh);
+error_free_page:
+	btrfs_release_disk_super(disk_super);
 	blkdev_put(bdev, flags);
 
 	return -EINVAL;
@@ -1247,8 +1243,10 @@ int btrfs_open_devices(struct btrfs_fs_devices *fs_devices,
 	return ret;
 }
 
-void btrfs_release_disk_super(struct page *page)
+void btrfs_release_disk_super(struct btrfs_super_block *super)
 {
+	struct page *page = virt_to_page(super);
+
 	put_page(page);
 }
 
@@ -1286,7 +1284,7 @@ static int btrfs_read_disk_super(struct block_device *bdev, u64 bytenr,
 
 	if (btrfs_super_bytenr(*disk_super) != bytenr ||
 	    btrfs_super_magic(*disk_super) != BTRFS_MAGIC) {
-		btrfs_release_disk_super(*page);
+		btrfs_release_disk_super(p);
 		return 1;
 	}
 
@@ -1349,7 +1347,7 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, fmode_t flags,
 			btrfs_free_stale_devices(path, device);
 	}
 
-	btrfs_release_disk_super(page);
+	btrfs_release_disk_super(disk_super);
 
 error_bdev_put:
 	blkdev_put(bdev, flags);
@@ -2208,14 +2206,14 @@ static struct btrfs_device *btrfs_find_device_by_path(
 	u64 devid;
 	u8 *dev_uuid;
 	struct block_device *bdev;
-	struct buffer_head *bh;
 	struct btrfs_device *device;
 
 	ret = btrfs_get_bdev_and_sb(device_path, FMODE_READ,
-				    fs_info->bdev_holder, 0, &bdev, &bh);
+				    fs_info->bdev_holder, 0, &bdev,
+				    &disk_super);
 	if (ret)
 		return ERR_PTR(ret);
-	disk_super = (struct btrfs_super_block *)bh->b_data;
+
 	devid = btrfs_stack_device_id(&disk_super->dev_item);
 	dev_uuid = disk_super->dev_item.uuid;
 	if (btrfs_fs_incompat(fs_info, METADATA_UUID))
@@ -2225,7 +2223,7 @@ static struct btrfs_device *btrfs_find_device_by_path(
 		device = btrfs_find_device(fs_info->fs_devices, devid, dev_uuid,
 					   disk_super->fsid, true);
 
-	brelse(bh);
+	btrfs_release_disk_super(disk_super);
 	if (!device)
 		device = ERR_PTR(-ENOENT);
 	blkdev_put(bdev, FMODE_READ);
@@ -7318,7 +7316,6 @@ int btrfs_get_dev_stats(struct btrfs_fs_info *fs_info,
 
 void btrfs_scratch_superblocks(struct block_device *bdev, const char *device_path)
 {
-	struct buffer_head *bh;
 	struct btrfs_super_block *disk_super;
 	int copy_num;
 
@@ -7327,16 +7324,20 @@ void btrfs_scratch_superblocks(struct block_device *bdev, const char *device_pat
 
 	for (copy_num = 0; copy_num < BTRFS_SUPER_MIRROR_MAX;
 		copy_num++) {
+		struct page *page;
 
-		if (btrfs_read_dev_one_super(bdev, copy_num, &bh))
+		disk_super = btrfs_read_dev_one_super(bdev, copy_num);
+		if (IS_ERR(disk_super))
 			continue;
 
-		disk_super = (struct btrfs_super_block *)bh->b_data;
-
 		memset(&disk_super->magic, 0, sizeof(disk_super->magic));
-		set_buffer_dirty(bh);
-		sync_dirty_buffer(bh);
-		brelse(bh);
+
+		page = virt_to_page(disk_super);
+		set_page_dirty(page);
+		lock_page(page); /* write_on_page() unlocks the page */
+		write_one_page(page);
+		btrfs_release_disk_super(disk_super);
+
 	}
 
 	/* Notify udev that device has changed */
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index b7f2edbc6581..ed44c45ef199 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -17,8 +17,6 @@ extern struct mutex uuid_mutex;
 
 #define BTRFS_STRIPE_LEN	SZ_64K
 
-struct buffer_head;
-
 struct btrfs_io_geometry {
 	/* remaining bytes before crossing a stripe */
 	u64 len;
@@ -483,7 +481,7 @@ int btrfs_finish_chunk_alloc(struct btrfs_trans_handle *trans,
 int btrfs_remove_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset);
 struct extent_map *btrfs_get_chunk_map(struct btrfs_fs_info *fs_info,
 				       u64 logical, u64 length);
-void btrfs_release_disk_super(struct page *page);
+void btrfs_release_disk_super(struct btrfs_super_block *super);
 
 static inline void btrfs_dev_stat_inc(struct btrfs_device *dev,
 				      int index)
-- 
2.24.1

