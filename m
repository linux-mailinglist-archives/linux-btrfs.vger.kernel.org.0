Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45EFF1552CE
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Feb 2020 08:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgBGHU6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Feb 2020 02:20:58 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:26076 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgBGHU6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Feb 2020 02:20:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581060063; x=1612596063;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4OVYyJfg3MwODi8iXrzAuGITcDlWHrC+gcANr6zBqn0=;
  b=rYKVM+M128A2sgP3PJMQpJWwvwOeg/nRdZ3rGbOEBRuGVI+ZYpkn6bl/
   tjwXxX35FeSreIgVN/eErL1G8ajdZatMcGEwBK0CWK8g7g7/VR5MaTnYT
   hFputfjlHbzbFRhtJNm1ejsvDOL27YcUD8sr1fZqhiOyH+2UK0IfO6JEZ
   bEX8hmf6caaXmznVpf1ZbWXC7rqtsBIe+eqjzE18xy0MB8OnwjgNAXhln
   Vn1ibIZ6dfejCnbeND8mOxx0gvCXkHvRYR00QFAvSD1258hQZniAEzC5x
   4x3M0WNsAd14xz1ERoHDtgxtA0FsBqk+eV+AJsn2JLTLO/Mqlkk71BbOp
   A==;
IronPort-SDR: u/75n5/q4UlLdij6jYdrrYWA1jPfYD9vbpGP61S9kG1WDrID51CAis/pRgiPD43rFWcwFaarFD
 /iUPgyyFcpEuDadtq+ehqU0A5Ww0ZALn+r73yTeLjTjH4H0K+4dtA02kBeYHxR/Hm3xQtJ3qA/
 7Y1aYKYanzMvKpHAkAm+4EJO+K3wSbHZAe9tSvueeDvQ4i4N8lyvWR72elfI37O/IU0+AGM9WI
 5Xd/5CSF1+jeEE3AD3QRcgeGSvgtzBPPSve9k6X+WxUl3CKN8DrPgPZPc0peAUi9CVre1GjWe0
 yv8=
X-IronPort-AV: E=Sophos;i="5.70,412,1574092800"; 
   d="scan'208";a="231092226"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Feb 2020 15:20:19 +0800
IronPort-SDR: jsdJNwV51gJEuaxtpZXOyuqGKWRYILv8KuO2ADpRwQy5dw0mNSxg09/IvTgdHfI0LdKesJPmMz
 Fi+6VueGuOAM+6pO0TVgeg7fYOK5jk7koIbiOHdXNz/4+ebksMdaCD95WesU4M3w5sprdIvc9h
 v7gBojRAPIEoRprKZPLFhbtS4qXWkgwQYmF/eyIYC9YJlHiAy63l6cTHaR4pscu5GuRxuMdMj0
 4dk/sPzUq8RTcjukbswREeH8seSShMZiISvmAayIjiX2iu7Q12AVfE3fwx6JgG3li7Fks8AYQy
 26So2JtBgh3le8iEK0YV2z/o
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2020 23:13:11 -0800
IronPort-SDR: FAh4ivH43biBJcFyZvXUtfu9VBSYvTz98/bGzIywH/xsbFa8Hrs35VjT5SPkp55AjKCIqTjj8k
 DzeaDTPOKRUpkbPFRmazpaj5n0MUIT/wQfXlfV99KpIKNHweCLIOyX85lr5rOoWoBcr/n4gKx4
 WxoNrhPEjzCX1NTZHDFSXsXUT2zuVQbzAeRD3OnmHQpy+Gk6fYRPowXkioprGGtn5zJ+ecKlUT
 /W1T8YNnCRYBZRkoZ0eB6frz8z44RUQfUNjO8ZKbBgCXZT1gMGWvoxByrAPfYiAoY0N0ng5Uq+
 Ox8=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 06 Feb 2020 23:20:13 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v5 2/7] btrfs: use the page-cache for super block reading
Date:   Fri,  7 Feb 2020 16:20:00 +0900
Message-Id: <20200207072005.22867-3-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200207072005.22867-1-johannes.thumshirn@wdc.com>
References: <20200207072005.22867-1-johannes.thumshirn@wdc.com>
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
 fs/btrfs/disk-io.c | 76 +++++++++++++++++++++++++---------------------
 fs/btrfs/disk-io.h |  4 +--
 fs/btrfs/volumes.c | 57 ++++++++++++++++++----------------
 fs/btrfs/volumes.h |  2 --
 4 files changed, 74 insertions(+), 65 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 28622de9e642..42cd267ff978 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2617,11 +2617,12 @@ int __cold open_ctree(struct super_block *sb,
 	u64 features;
 	u16 csum_type;
 	struct btrfs_key location;
-	struct buffer_head *bh;
 	struct btrfs_super_block *disk_super;
 	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
 	struct btrfs_root *tree_root;
 	struct btrfs_root *chunk_root;
+	struct page *super_page;
+	u8 *superblock;
 	int ret;
 	int err = -EINVAL;
 	int clear_free_space_tree = 0;
@@ -2815,28 +2816,33 @@ int __cold open_ctree(struct super_block *sb,
 	/*
 	 * Read super block and check the signature bytes only
 	 */
-	bh = btrfs_read_dev_super(fs_devices->latest_bdev);
-	if (IS_ERR(bh)) {
-		err = PTR_ERR(bh);
+	ret = btrfs_read_dev_super(fs_devices->latest_bdev, &super_page);
+	if (ret) {
+		err = ret;
 		goto fail_alloc;
 	}
 
+	superblock = kmap(super_page);
 	/*
 	 * Verify the type first, if that or the the checksum value are
 	 * corrupted, we'll find out
 	 */
-	csum_type = btrfs_super_csum_type((struct btrfs_super_block *)bh->b_data);
+	csum_type = btrfs_super_csum_type((struct btrfs_super_block *)
+					  superblock);
 	if (!btrfs_supported_super_csum(csum_type)) {
 		btrfs_err(fs_info, "unsupported checksum algorithm: %u",
 			  csum_type);
 		err = -EINVAL;
-		brelse(bh);
+		kunmap(super_page);
+		put_page(super_page);
 		goto fail_alloc;
 	}
 
 	ret = btrfs_init_csum_hash(fs_info, csum_type);
 	if (ret) {
 		err = ret;
+		kunmap(super_page);
+		put_page(super_page);
 		goto fail_alloc;
 	}
 
@@ -2844,10 +2850,11 @@ int __cold open_ctree(struct super_block *sb,
 	 * We want to check superblock checksum, the type is stored inside.
 	 * Pass the whole disk block of size BTRFS_SUPER_INFO_SIZE (4k).
 	 */
-	if (btrfs_check_super_csum(fs_info, bh->b_data)) {
+	if (btrfs_check_super_csum(fs_info, superblock)) {
 		btrfs_err(fs_info, "superblock checksum mismatch");
 		err = -EINVAL;
-		brelse(bh);
+		kunmap(super_page);
+		put_page(super_page);
 		goto fail_csum;
 	}
 
@@ -2856,8 +2863,9 @@ int __cold open_ctree(struct super_block *sb,
 	 * following bytes up to INFO_SIZE, the checksum is calculated from
 	 * the whole block of INFO_SIZE
 	 */
-	memcpy(fs_info->super_copy, bh->b_data, sizeof(*fs_info->super_copy));
-	brelse(bh);
+	memcpy(fs_info->super_copy, superblock, sizeof(*fs_info->super_copy));
+	kunmap(super_page);
+	put_page(super_page);
 
 	disk_super = fs_info->super_copy;
 
@@ -3355,40 +3363,38 @@ static void btrfs_end_buffer_write_sync(struct buffer_head *bh, int uptodate)
 }
 
 int btrfs_read_dev_one_super(struct block_device *bdev, int copy_num,
-			struct buffer_head **bh_ret)
+			struct page **super_page)
 {
-	struct buffer_head *bh;
 	struct btrfs_super_block *super;
+	struct page *page;
 	u64 bytenr;
+	struct address_space *mapping = bdev->bd_inode->i_mapping;
 
 	bytenr = btrfs_sb_offset(copy_num);
 	if (bytenr + BTRFS_SUPER_INFO_SIZE >= i_size_read(bdev->bd_inode))
 		return -EINVAL;
 
-	bh = __bread(bdev, bytenr / BTRFS_BDEV_BLOCKSIZE, BTRFS_SUPER_INFO_SIZE);
-	/*
-	 * If we fail to read from the underlying devices, as of now
-	 * the best option we have is to mark it EIO.
-	 */
-	if (!bh)
-		return -EIO;
+	page = read_cache_page_gfp(mapping, bytenr >> PAGE_SHIFT, GFP_NOFS);
+	if (IS_ERR_OR_NULL(page))
+		return -ENOMEM;
 
-	super = (struct btrfs_super_block *)bh->b_data;
+	super = kmap(page);
 	if (btrfs_super_bytenr(super) != bytenr ||
 		    btrfs_super_magic(super) != BTRFS_MAGIC) {
-		brelse(bh);
+		kunmap(page);
+		put_page(page);
 		return -EINVAL;
 	}
+	kunmap(page);
 
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
@@ -3400,25 +3406,25 @@ struct buffer_head *btrfs_read_dev_super(struct block_device *bdev)
 	 * later supers, using BTRFS_SUPER_MIRROR_MAX instead
 	 */
 	for (i = 0; i < 1; i++) {
-		ret = btrfs_read_dev_one_super(bdev, i, &bh);
+		ret = btrfs_read_dev_one_super(bdev, i, page);
 		if (ret)
 			continue;
 
-		super = (struct btrfs_super_block *)bh->b_data;
+		super = kmap(*page);
 
 		if (!latest || btrfs_super_generation(super) > transid) {
-			brelse(latest);
-			latest = bh;
+			if (latest) {
+				kunmap(latest);
+				put_page(latest);
+			}
+			latest = *page;
 			transid = btrfs_super_generation(super);
-		} else {
-			brelse(bh);
 		}
-	}
 
-	if (!latest)
-		return ERR_PTR(ret);
+		kunmap(*page);
+	}
 
-	return latest;
+	return ret;
 }
 
 /*
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 8add2e14aab1..a89283ce8ca2 100644
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
 struct btrfs_root *btrfs_read_tree_root(struct btrfs_root *tree_root,
 					struct btrfs_key *key);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index c312de1a55a6..5b19e5077633 100644
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
+		      struct page **super_page)
 {
 	int ret;
 
@@ -519,9 +518,8 @@ btrfs_get_bdev_and_sb(const char *device_path, fmode_t flags, void *holder,
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
@@ -530,7 +528,6 @@ btrfs_get_bdev_and_sb(const char *device_path, fmode_t flags, void *holder,
 
 error:
 	*bdev = NULL;
-	*bh = NULL;
 	return ret;
 }
 
@@ -611,7 +608,7 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
 {
 	struct request_queue *q;
 	struct block_device *bdev;
-	struct buffer_head *bh;
+	struct page *super_page;
 	struct btrfs_super_block *disk_super;
 	u64 devid;
 	int ret;
@@ -622,17 +619,17 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
 		return -EINVAL;
 
 	ret = btrfs_get_bdev_and_sb(device->name->str, flags, holder, 1,
-				    &bdev, &bh);
+				    &bdev, &super_page);
 	if (ret)
 		return ret;
 
-	disk_super = (struct btrfs_super_block *)bh->b_data;
+	disk_super = kmap(super_page);
 	devid = btrfs_stack_device_id(&disk_super->dev_item);
 	if (devid != device->devid)
-		goto error_brelse;
+		goto error_free_page;
 
 	if (memcmp(device->uuid, disk_super->dev_item.uuid, BTRFS_UUID_SIZE))
-		goto error_brelse;
+		goto error_free_page;
 
 	device->generation = btrfs_super_generation(disk_super);
 
@@ -641,7 +638,7 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
 		    BTRFS_FEATURE_INCOMPAT_METADATA_UUID) {
 			pr_err(
 		"BTRFS: Invalid seeding and uuid-changed device detected\n");
-			goto error_brelse;
+			goto error_free_page;
 		}
 
 		clear_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state);
@@ -667,12 +664,14 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
 		fs_devices->rw_devices++;
 		list_add_tail(&device->dev_alloc_list, &fs_devices->alloc_list);
 	}
-	brelse(bh);
+	kunmap(super_page);
+	put_page(super_page);
 
 	return 0;
 
-error_brelse:
-	brelse(bh);
+error_free_page:
+	kunmap(super_page);
+	put_page(super_page);
 	blkdev_put(bdev, flags);
 
 	return -EINVAL;
@@ -2209,14 +2208,15 @@ static struct btrfs_device *btrfs_find_device_by_path(
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
+	disk_super = kmap(super_page);
 	devid = btrfs_stack_device_id(&disk_super->dev_item);
 	dev_uuid = disk_super->dev_item.uuid;
 	if (btrfs_fs_incompat(fs_info, METADATA_UUID))
@@ -2226,7 +2226,8 @@ static struct btrfs_device *btrfs_find_device_by_path(
 		device = btrfs_find_device(fs_info->fs_devices, devid, dev_uuid,
 					   disk_super->fsid, true);
 
-	brelse(bh);
+	kunmap(super_page);
+	put_page(super_page);
 	if (!device)
 		device = ERR_PTR(-ENOENT);
 	blkdev_put(bdev, FMODE_READ);
@@ -7319,7 +7320,6 @@ int btrfs_get_dev_stats(struct btrfs_fs_info *fs_info,
 
 void btrfs_scratch_superblocks(struct block_device *bdev, const char *device_path)
 {
-	struct buffer_head *bh;
 	struct btrfs_super_block *disk_super;
 	int copy_num;
 
@@ -7328,16 +7328,21 @@ void btrfs_scratch_superblocks(struct block_device *bdev, const char *device_pat
 
 	for (copy_num = 0; copy_num < BTRFS_SUPER_MIRROR_MAX;
 		copy_num++) {
+		u64 bytenr = btrfs_sb_offset(copy_num);
+		struct page *page;
 
-		if (btrfs_read_dev_one_super(bdev, copy_num, &bh))
+		if (btrfs_read_dev_one_super(bdev, copy_num, &page))
 			continue;
 
-		disk_super = (struct btrfs_super_block *)bh->b_data;
-
+		disk_super = kmap(page) + offset_in_page(bytenr);
 		memset(&disk_super->magic, 0, sizeof(disk_super->magic));
-		set_buffer_dirty(bh);
-		sync_dirty_buffer(bh);
-		brelse(bh);
+		kunmap(page);
+
+		set_page_dirty(page);
+		lock_page(page); /* write_on_page() unlocks the page */
+		write_one_page(page);
+		put_page(page);
+
 	}
 
 	/* Notify udev that device has changed */
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index b7f2edbc6581..1e4ebe6d6368 100644
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

