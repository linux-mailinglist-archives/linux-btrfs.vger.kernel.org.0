Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0697239BA
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jun 2023 09:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236463AbjFFHmO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Jun 2023 03:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236562AbjFFHlN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Jun 2023 03:41:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116081707;
        Tue,  6 Jun 2023 00:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Ol0fxj1SoRu64llcsuF5jrp946SnGnr76OCp1cdl0mI=; b=hsCBH8X1jZqzmAtwOi8uP4BAJe
        EkPMDupK6Wkzt9EvOV2l5MpVaaJz/IwNbJTOwkxqfU9BHVRp5rw0OSb+VTrwLznGz6CVxaoHa0Eu8
        +Bn0RUh14TAceqokjq7tP5NR1r7mT3NrKNbyYDSsNqZ5pL3/SQZlDe6kLM8LENSpGAxfIQ1deLrnp
        kdvyAXnn4wHByR2acIhgGzJBTzYPQ6gviYhYNkdCOxexwVl/14w/pFu2givJDqO6XS0R8srirC6IV
        NdixYH+RIlX9TIlA8scqxY1AaxF5heFKZVxnAvExIlXDOuCIxuWb783Y617cWa7ojgRTpQjRaXzc8
        IwE6/P3g==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q6RIq-000Z4I-0d;
        Tue, 06 Jun 2023 07:40:28 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Richard Weinberger <richard@nod.at>,
        Josef Bacik <josef@toxicpanda.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        Coly Li <colyli@suse.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-um@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
        linux-btrfs@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH 10/31] block: remove the unused mode argument to ->release
Date:   Tue,  6 Jun 2023 09:39:29 +0200
Message-Id: <20230606073950.225178-11-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230606073950.225178-1-hch@lst.de>
References: <20230606073950.225178-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The mode argument to the ->release block_device_operation is never used,
so remove it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/um/drivers/ubd_kern.c          |  4 ++--
 arch/xtensa/platforms/iss/simdisk.c |  2 +-
 block/bdev.c                        | 14 +++++++-------
 drivers/block/amiflop.c             |  2 +-
 drivers/block/aoe/aoeblk.c          |  2 +-
 drivers/block/ataflop.c             |  4 ++--
 drivers/block/drbd/drbd_main.c      |  4 ++--
 drivers/block/floppy.c              |  2 +-
 drivers/block/loop.c                |  2 +-
 drivers/block/nbd.c                 |  2 +-
 drivers/block/pktcdvd.c             |  4 ++--
 drivers/block/rbd.c                 |  2 +-
 drivers/block/rnbd/rnbd-clt.c       |  2 +-
 drivers/block/swim.c                |  2 +-
 drivers/block/swim3.c               |  3 +--
 drivers/block/z2ram.c               |  2 +-
 drivers/cdrom/gdrom.c               |  2 +-
 drivers/md/bcache/super.c           |  2 +-
 drivers/md/dm.c                     |  2 +-
 drivers/md/md.c                     |  2 +-
 drivers/mmc/core/block.c            |  2 +-
 drivers/mtd/mtd_blkdevs.c           |  2 +-
 drivers/mtd/ubi/block.c             |  2 +-
 drivers/nvme/host/core.c            |  2 +-
 drivers/nvme/host/multipath.c       |  2 +-
 drivers/s390/block/dasd.c           |  2 +-
 drivers/s390/block/dcssblk.c        |  4 ++--
 drivers/scsi/sd.c                   |  3 +--
 drivers/scsi/sr.c                   |  2 +-
 include/linux/blkdev.h              |  2 +-
 30 files changed, 41 insertions(+), 43 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 6b831f82881bc4..8b79554968addb 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -109,7 +109,7 @@ static DEFINE_MUTEX(ubd_lock);
 static DEFINE_MUTEX(ubd_mutex); /* replaces BKL, might not be needed */
 
 static int ubd_open(struct gendisk *disk, fmode_t mode);
-static void ubd_release(struct gendisk *disk, fmode_t mode);
+static void ubd_release(struct gendisk *disk);
 static int ubd_ioctl(struct block_device *bdev, fmode_t mode,
 		     unsigned int cmd, unsigned long arg);
 static int ubd_getgeo(struct block_device *bdev, struct hd_geometry *geo);
@@ -1182,7 +1182,7 @@ static int ubd_open(struct gendisk *disk, fmode_t mode)
 	return err;
 }
 
-static void ubd_release(struct gendisk *disk, fmode_t mode)
+static void ubd_release(struct gendisk *disk)
 {
 	struct ubd *ubd_dev = disk->private_data;
 
diff --git a/arch/xtensa/platforms/iss/simdisk.c b/arch/xtensa/platforms/iss/simdisk.c
index 38f95f79a1270c..2ad9da3de0d90f 100644
--- a/arch/xtensa/platforms/iss/simdisk.c
+++ b/arch/xtensa/platforms/iss/simdisk.c
@@ -130,7 +130,7 @@ static int simdisk_open(struct gendisk *disk, fmode_t mode)
 	return 0;
 }
 
-static void simdisk_release(struct gendisk *disk, fmode_t mode)
+static void simdisk_release(struct gendisk *disk)
 {
 	struct simdisk *dev = disk->private_data;
 	spin_lock(&dev->lock);
diff --git a/block/bdev.c b/block/bdev.c
index 8a5fded303d4ed..2c6888ceb3784a 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -670,12 +670,12 @@ static int blkdev_get_whole(struct block_device *bdev, fmode_t mode)
 	return 0;
 }
 
-static void blkdev_put_whole(struct block_device *bdev, fmode_t mode)
+static void blkdev_put_whole(struct block_device *bdev)
 {
 	if (atomic_dec_and_test(&bdev->bd_openers))
 		blkdev_flush_mapping(bdev);
 	if (bdev->bd_disk->fops->release)
-		bdev->bd_disk->fops->release(bdev->bd_disk, mode);
+		bdev->bd_disk->fops->release(bdev->bd_disk);
 }
 
 static int blkdev_get_part(struct block_device *part, fmode_t mode)
@@ -699,11 +699,11 @@ static int blkdev_get_part(struct block_device *part, fmode_t mode)
 	return 0;
 
 out_blkdev_put:
-	blkdev_put_whole(bdev_whole(part), mode);
+	blkdev_put_whole(bdev_whole(part));
 	return ret;
 }
 
-static void blkdev_put_part(struct block_device *part, fmode_t mode)
+static void blkdev_put_part(struct block_device *part)
 {
 	struct block_device *whole = bdev_whole(part);
 
@@ -711,7 +711,7 @@ static void blkdev_put_part(struct block_device *part, fmode_t mode)
 		blkdev_flush_mapping(part);
 		whole->bd_disk->open_partitions--;
 	}
-	blkdev_put_whole(whole, mode);
+	blkdev_put_whole(whole);
 }
 
 struct block_device *blkdev_get_no_open(dev_t dev)
@@ -903,9 +903,9 @@ void blkdev_put(struct block_device *bdev, fmode_t mode)
 	disk_flush_events(disk, DISK_EVENT_MEDIA_CHANGE);
 
 	if (bdev_is_partition(bdev))
-		blkdev_put_part(bdev, mode);
+		blkdev_put_part(bdev);
 	else
-		blkdev_put_whole(bdev, mode);
+		blkdev_put_whole(bdev);
 	mutex_unlock(&disk->open_mutex);
 
 	module_put(disk->fops->owner);
diff --git a/drivers/block/amiflop.c b/drivers/block/amiflop.c
index 0cf2e58294be68..9a0e9dc74a8c57 100644
--- a/drivers/block/amiflop.c
+++ b/drivers/block/amiflop.c
@@ -1709,7 +1709,7 @@ static int floppy_open(struct gendisk *disk, fmode_t mode)
 	return 0;
 }
 
-static void floppy_release(struct gendisk *disk, fmode_t mode)
+static void floppy_release(struct gendisk *disk)
 {
 	struct amiga_floppy_struct *p = disk->private_data;
 	int drive = p - unit;
diff --git a/drivers/block/aoe/aoeblk.c b/drivers/block/aoe/aoeblk.c
index 4ca6bbb326d5de..c3a39e02ab9571 100644
--- a/drivers/block/aoe/aoeblk.c
+++ b/drivers/block/aoe/aoeblk.c
@@ -232,7 +232,7 @@ aoeblk_open(struct gendisk *disk, fmode_t mode)
 }
 
 static void
-aoeblk_release(struct gendisk *disk, fmode_t mode)
+aoeblk_release(struct gendisk *disk)
 {
 	struct aoedev *d = disk->private_data;
 	ulong flags;
diff --git a/drivers/block/ataflop.c b/drivers/block/ataflop.c
index 4febd52be78cfc..66a3242bb062c3 100644
--- a/drivers/block/ataflop.c
+++ b/drivers/block/ataflop.c
@@ -448,7 +448,7 @@ static void fd_probe( int drive );
 static int fd_test_drive_present( int drive );
 static void config_types( void );
 static int floppy_open(struct gendisk *disk, fmode_t mode);
-static void floppy_release(struct gendisk *disk, fmode_t mode);
+static void floppy_release(struct gendisk *disk);
 
 /************************* End of Prototypes **************************/
 
@@ -1964,7 +1964,7 @@ static int floppy_unlocked_open(struct gendisk *disk, fmode_t mode)
 	return ret;
 }
 
-static void floppy_release(struct gendisk *disk, fmode_t mode)
+static void floppy_release(struct gendisk *disk)
 {
 	struct atari_floppy_struct *p = disk->private_data;
 	mutex_lock(&ataflop_mutex);
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 8b6c19460f3425..7f3d7ca6ce6bcf 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -50,7 +50,7 @@
 
 static DEFINE_MUTEX(drbd_main_mutex);
 static int drbd_open(struct gendisk *disk, fmode_t mode);
-static void drbd_release(struct gendisk *gd, fmode_t mode);
+static void drbd_release(struct gendisk *gd);
 static void md_sync_timer_fn(struct timer_list *t);
 static int w_bitmap_io(struct drbd_work *w, int unused);
 
@@ -1908,7 +1908,7 @@ static int drbd_open(struct gendisk *disk, fmode_t mode)
 	return rv;
 }
 
-static void drbd_release(struct gendisk *gd, fmode_t mode)
+static void drbd_release(struct gendisk *gd)
 {
 	struct drbd_device *device = gd->private_data;
 	mutex_lock(&drbd_main_mutex);
diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index ef3bbb7c185b56..d79fac288a73dc 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -3963,7 +3963,7 @@ static void __init config_types(void)
 		pr_cont("\n");
 }
 
-static void floppy_release(struct gendisk *disk, fmode_t mode)
+static void floppy_release(struct gendisk *disk)
 {
 	int drive = (long)disk->private_data;
 
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index a73c857f5bfed0..ca40d24572aea6 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1727,7 +1727,7 @@ static int lo_compat_ioctl(struct block_device *bdev, fmode_t mode,
 }
 #endif
 
-static void lo_release(struct gendisk *disk, fmode_t mode)
+static void lo_release(struct gendisk *disk)
 {
 	struct loop_device *lo = disk->private_data;
 
diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 7b4ee6ebaae2e6..5a02fd6b3e7e95 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1597,7 +1597,7 @@ static int nbd_open(struct gendisk *disk, fmode_t mode)
 	return ret;
 }
 
-static void nbd_release(struct gendisk *disk, fmode_t mode)
+static void nbd_release(struct gendisk *disk)
 {
 	struct nbd_device *nbd = disk->private_data;
 
diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 8f02a1c2ede56d..fe0084bbb11f7c 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -2248,7 +2248,7 @@ static int pkt_open(struct gendisk *disk, fmode_t mode)
 	return ret;
 }
 
-static void pkt_close(struct gendisk *disk, fmode_t mode)
+static void pkt_release(struct gendisk *disk)
 {
 	struct pktcdvd_device *pd = disk->private_data;
 
@@ -2632,7 +2632,7 @@ static const struct block_device_operations pktcdvd_ops = {
 	.owner =		THIS_MODULE,
 	.submit_bio =		pkt_submit_bio,
 	.open =			pkt_open,
-	.release =		pkt_close,
+	.release =		pkt_release,
 	.ioctl =		pkt_ioctl,
 	.compat_ioctl =		blkdev_compat_ptr_ioctl,
 	.check_events =		pkt_check_events,
diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 93231061db2f2b..5215eff94fe94f 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -679,7 +679,7 @@ static int rbd_open(struct gendisk *disk, fmode_t mode)
 	return 0;
 }
 
-static void rbd_release(struct gendisk *disk, fmode_t mode)
+static void rbd_release(struct gendisk *disk)
 {
 	struct rbd_device *rbd_dev = disk->private_data;
 	unsigned long open_count_before;
diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index 8ec00f4caf6b4c..d5261d36d78630 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -935,7 +935,7 @@ static int rnbd_client_open(struct gendisk *disk, fmode_t mode)
 	return 0;
 }
 
-static void rnbd_client_release(struct gendisk *gen, fmode_t mode)
+static void rnbd_client_release(struct gendisk *gen)
 {
 	struct rnbd_clt_dev *dev = gen->private_data;
 
diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index 7ec8554187f7d7..a629b38dec660a 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -670,7 +670,7 @@ static int floppy_unlocked_open(struct gendisk *disk, fmode_t mode)
 	return ret;
 }
 
-static void floppy_release(struct gendisk *disk, fmode_t mode)
+static void floppy_release(struct gendisk *disk)
 {
 	struct floppy_state *fs = disk->private_data;
 	struct swim __iomem *base = fs->swd->base;
diff --git a/drivers/block/swim3.c b/drivers/block/swim3.c
index c05a4e110d5275..b696deff3d8ba1 100644
--- a/drivers/block/swim3.c
+++ b/drivers/block/swim3.c
@@ -249,7 +249,6 @@ static int fd_eject(struct floppy_state *fs);
 static int floppy_ioctl(struct block_device *bdev, fmode_t mode,
 			unsigned int cmd, unsigned long param);
 static int floppy_open(struct gendisk *disk, fmode_t mode);
-static void floppy_release(struct gendisk *disk, fmode_t mode);
 static unsigned int floppy_check_events(struct gendisk *disk,
 					unsigned int clearing);
 static int floppy_revalidate(struct gendisk *disk);
@@ -1004,7 +1003,7 @@ static int floppy_unlocked_open(struct block_device *bdev, fmode_t mode)
 	return ret;
 }
 
-static void floppy_release(struct gendisk *disk, fmode_t mode)
+static void floppy_release(struct gendisk *disk)
 {
 	struct floppy_state *fs = disk->private_data;
 	struct swim3 __iomem *sw = fs->swim3;
diff --git a/drivers/block/z2ram.c b/drivers/block/z2ram.c
index a5575e012e291e..a2e41cc084ca3a 100644
--- a/drivers/block/z2ram.c
+++ b/drivers/block/z2ram.c
@@ -288,7 +288,7 @@ static int z2_open(struct gendisk *disk, fmode_t mode)
 	return rc;
 }
 
-static void z2_release(struct gendisk *disk, fmode_t mode)
+static void z2_release(struct gendisk *disk)
 {
 	mutex_lock(&z2ram_mutex);
 	if (current_device == -1) {
diff --git a/drivers/cdrom/gdrom.c b/drivers/cdrom/gdrom.c
index d35dd717e9fca9..dac148d4d1feda 100644
--- a/drivers/cdrom/gdrom.c
+++ b/drivers/cdrom/gdrom.c
@@ -486,7 +486,7 @@ static int gdrom_bdops_open(struct gendisk *disk, fmode_t mode)
 	return ret;
 }
 
-static void gdrom_bdops_release(struct gendisk *disk, fmode_t mode)
+static void gdrom_bdops_release(struct gendisk *disk)
 {
 	mutex_lock(&gdrom_mutex);
 	cdrom_release(gd.cd_info, mode);
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 6683f66e701136..94b91c45c9e2a9 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -743,7 +743,7 @@ static int open_dev(struct gendisk *disk, fmode_t mode)
 	return 0;
 }
 
-static void release_dev(struct gendisk *b, fmode_t mode)
+static void release_dev(struct gendisk *b)
 {
 	struct bcache_device *d = b->private_data;
 
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 06047a0ca4b315..246b8f028a98f4 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -334,7 +334,7 @@ static int dm_blk_open(struct gendisk *disk, fmode_t mode)
 	return md ? 0 : -ENXIO;
 }
 
-static void dm_blk_close(struct gendisk *disk, fmode_t mode)
+static void dm_blk_close(struct gendisk *disk)
 {
 	struct mapped_device *md;
 
diff --git a/drivers/md/md.c b/drivers/md/md.c
index aba13830bdb556..159197dd7b6de1 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -7799,7 +7799,7 @@ static int md_open(struct gendisk *disk, fmode_t mode)
 	return err;
 }
 
-static void md_release(struct gendisk *disk, fmode_t mode)
+static void md_release(struct gendisk *disk)
 {
 	struct mddev *mddev = disk->private_data;
 
diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index fe217658705d1f..b16eedf22d4e26 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -375,7 +375,7 @@ static int mmc_blk_open(struct gendisk *disk, fmode_t mode)
 	return ret;
 }
 
-static void mmc_blk_release(struct gendisk *disk, fmode_t mode)
+static void mmc_blk_release(struct gendisk *disk)
 {
 	struct mmc_blk_data *md = disk->private_data;
 
diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
index 95f3ee6bde8440..f0bb09fde95e3a 100644
--- a/drivers/mtd/mtd_blkdevs.c
+++ b/drivers/mtd/mtd_blkdevs.c
@@ -225,7 +225,7 @@ static int blktrans_open(struct gendisk *disk, fmode_t mode)
 	return ret;
 }
 
-static void blktrans_release(struct gendisk *disk, fmode_t mode)
+static void blktrans_release(struct gendisk *disk)
 {
 	struct mtd_blktrans_dev *dev = disk->private_data;
 
diff --git a/drivers/mtd/ubi/block.c b/drivers/mtd/ubi/block.c
index 2f3442963919fc..e85fb9de0b7004 100644
--- a/drivers/mtd/ubi/block.c
+++ b/drivers/mtd/ubi/block.c
@@ -270,7 +270,7 @@ static int ubiblock_open(struct gendisk *disk, fmode_t mode)
 	return ret;
 }
 
-static void ubiblock_release(struct gendisk *gd, fmode_t mode)
+static void ubiblock_release(struct gendisk *gd)
 {
 	struct ubiblock *dev = gd->private_data;
 
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b1c8af5d9376ad..fd7f8e6d66fda6 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1596,7 +1596,7 @@ static int nvme_open(struct gendisk *disk, fmode_t mode)
 	return nvme_ns_open(disk->private_data);
 }
 
-static void nvme_release(struct gendisk *disk, fmode_t mode)
+static void nvme_release(struct gendisk *disk)
 {
 	nvme_ns_release(disk->private_data);
 }
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index e8d5d62efa6d7c..698c0e70bcfa5b 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -409,7 +409,7 @@ static int nvme_ns_head_open(struct gendisk *disk, fmode_t mode)
 	return 0;
 }
 
-static void nvme_ns_head_release(struct gendisk *disk, fmode_t mode)
+static void nvme_ns_head_release(struct gendisk *disk)
 {
 	nvme_put_ns_head(disk->private_data);
 }
diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index e445b5fbd7fd27..19295b2df470c8 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -3287,7 +3287,7 @@ static int dasd_open(struct gendisk *disk, fmode_t mode)
 	return rc;
 }
 
-static void dasd_release(struct gendisk *disk, fmode_t mode)
+static void dasd_release(struct gendisk *disk)
 {
 	struct dasd_device *base = dasd_device_from_gendisk(disk);
 	if (base) {
diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
index 6150d20b584300..5aee3106bfda84 100644
--- a/drivers/s390/block/dcssblk.c
+++ b/drivers/s390/block/dcssblk.c
@@ -29,7 +29,7 @@
 #define DCSS_BUS_ID_SIZE 20
 
 static int dcssblk_open(struct gendisk *disk, fmode_t mode);
-static void dcssblk_release(struct gendisk *disk, fmode_t mode);
+static void dcssblk_release(struct gendisk *disk);
 static void dcssblk_submit_bio(struct bio *bio);
 static long dcssblk_dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
 		long nr_pages, enum dax_access_mode mode, void **kaddr,
@@ -825,7 +825,7 @@ dcssblk_open(struct gendisk *disk, fmode_t mode)
 }
 
 static void
-dcssblk_release(struct gendisk *disk, fmode_t mode)
+dcssblk_release(struct gendisk *disk)
 {
 	struct dcssblk_dev_info *dev_info = disk->private_data;
 	struct segment_info *entry;
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index c31a675db015e8..c67c84f6ba6178 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -1373,7 +1373,6 @@ static int sd_open(struct gendisk *disk, fmode_t mode)
  *	sd_release - invoked when the (last) close(2) is called on this
  *	scsi disk.
  *	@disk: disk to release
- *	@mode: FMODE_* mask
  *
  *	Returns 0. 
  *
@@ -1382,7 +1381,7 @@ static int sd_open(struct gendisk *disk, fmode_t mode)
  *
  *	Locking: called with bdev->bd_disk->open_mutex held.
  **/
-static void sd_release(struct gendisk *disk, fmode_t mode)
+static void sd_release(struct gendisk *disk)
 {
 	struct scsi_disk *sdkp = scsi_disk(disk);
 	struct scsi_device *sdev = sdkp->device;
diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
index 3ff3a2f9604774..55082acb59bcaa 100644
--- a/drivers/scsi/sr.c
+++ b/drivers/scsi/sr.c
@@ -507,7 +507,7 @@ static int sr_block_open(struct gendisk *disk, fmode_t mode)
 	return ret;
 }
 
-static void sr_block_release(struct gendisk *disk, fmode_t mode)
+static void sr_block_release(struct gendisk *disk)
 {
 	struct scsi_cd *cd = scsi_cd(disk);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 1366eea881860e..25bdd0cc74dce4 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1387,7 +1387,7 @@ struct block_device_operations {
 	int (*poll_bio)(struct bio *bio, struct io_comp_batch *iob,
 			unsigned int flags);
 	int (*open)(struct gendisk *disk, fmode_t mode);
-	void (*release) (struct gendisk *, fmode_t);
+	void (*release)(struct gendisk *disk);
 	int (*ioctl) (struct block_device *, fmode_t, unsigned, unsigned long);
 	int (*compat_ioctl) (struct block_device *, fmode_t, unsigned, unsigned long);
 	unsigned int (*check_events) (struct gendisk *disk,
-- 
2.39.2

