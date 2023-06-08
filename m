Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFE3B727E07
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jun 2023 13:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236407AbjFHLFV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jun 2023 07:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236321AbjFHLFD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jun 2023 07:05:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A028830FE;
        Thu,  8 Jun 2023 04:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=5yevpfvMJ5dm+9znguc7KMlYj9RhYIDPFtXBmeXjBIo=; b=bTkZOGrhSTtU+k4S86NESi0hNI
        O5rxFD7vJNtllPVQJtMkCHg2PaD9g+529f2jzURPUWuCq8uTAHDcE4wKsOTcuBpOaGcUsGKk7XSXH
        gzyEUJn3mCa6cPEiohCg4A5z5DzSLV4p6Oqt/JoGbXgbWpm/fqatRVRIQhpnyXZ56ib+aDpv7N+8V
        FZRZ0MROsj4+ttVmWJRXdq5109N2sa5SZ6+Escv1ndIs6XHYYBiMS3z77zgpRWecu27YyWGSDOlGO
        AkShaMIF28BSPn/TdFNJ7wicu0pzlH38QNnFb+7xqSZo5EqpOhL8KAraHYYi0mwnL0WN0P8Qo3xdq
        V3FggcPw==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q7DQb-0092FF-1e;
        Thu, 08 Jun 2023 11:03:42 +0000
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
        linux-pm@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 15/30] block: use the holder as indication for exclusive opens
Date:   Thu,  8 Jun 2023 13:02:43 +0200
Message-Id: <20230608110258.189493-16-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230608110258.189493-1-hch@lst.de>
References: <20230608110258.189493-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The current interface for exclusive opens is rather confusing as it
requires both the FMODE_EXCL flag and a holder.  Remove the need to pass
FMODE_EXCL and just key off the exclusive open off a non-NULL holder.

For blkdev_put this requires adding the holder argument, which provides
better debug checking that only the holder actually releases the hold,
but at the same time allows removing the now superfluous mode argument.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Acked-by: Christian Brauner <brauner@kernel.org>
Acked-by: David Sterba <dsterba@suse.com>		[btrfs]
Acked-by: Jack Wang <jinpu.wang@ionos.com>		[rnbd]
---
 block/bdev.c                        | 37 ++++++++++++++++------------
 block/fops.c                        |  6 +++--
 block/genhd.c                       |  5 ++--
 block/ioctl.c                       |  5 ++--
 drivers/block/drbd/drbd_nl.c        | 23 ++++++++++-------
 drivers/block/pktcdvd.c             | 13 +++++-----
 drivers/block/rnbd/rnbd-srv.c       |  4 +--
 drivers/block/xen-blkback/xenbus.c  |  2 +-
 drivers/block/zram/zram_drv.c       |  8 +++---
 drivers/md/bcache/super.c           | 15 ++++++------
 drivers/md/dm.c                     |  6 ++---
 drivers/md/md.c                     | 38 +++++++++++++++--------------
 drivers/mtd/devices/block2mtd.c     |  4 +--
 drivers/nvme/target/io-cmd-bdev.c   |  2 +-
 drivers/s390/block/dasd_genhd.c     |  2 +-
 drivers/target/target_core_iblock.c |  6 ++---
 drivers/target/target_core_pscsi.c  |  8 +++---
 fs/btrfs/dev-replace.c              |  6 ++---
 fs/btrfs/ioctl.c                    | 12 ++++-----
 fs/btrfs/volumes.c                  | 28 ++++++++++-----------
 fs/btrfs/volumes.h                  |  6 ++---
 fs/erofs/super.c                    |  7 +++---
 fs/ext4/super.c                     | 11 +++------
 fs/f2fs/super.c                     |  2 +-
 fs/jfs/jfs_logmgr.c                 |  6 ++---
 fs/nfs/blocklayout/dev.c            |  4 +--
 fs/nilfs2/super.c                   |  6 ++---
 fs/ocfs2/cluster/heartbeat.c        |  4 +--
 fs/reiserfs/journal.c               | 19 +++++++--------
 fs/reiserfs/reiserfs.h              |  1 -
 fs/super.c                          | 20 +++++++--------
 fs/xfs/xfs_super.c                  | 15 ++++++------
 include/linux/blkdev.h              |  2 +-
 kernel/power/hibernate.c            | 12 +++------
 kernel/power/power.h                |  2 +-
 kernel/power/swap.c                 | 21 +++++++---------
 mm/swapfile.c                       |  7 +++---
 37 files changed, 183 insertions(+), 192 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 2c6888ceb3784a..db63e5bcc46ffa 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -604,7 +604,7 @@ void bd_abort_claiming(struct block_device *bdev, void *holder)
 }
 EXPORT_SYMBOL(bd_abort_claiming);
 
-static void bd_end_claim(struct block_device *bdev)
+static void bd_end_claim(struct block_device *bdev, void *holder)
 {
 	struct block_device *whole = bdev_whole(bdev);
 	bool unblock = false;
@@ -614,6 +614,7 @@ static void bd_end_claim(struct block_device *bdev)
 	 * bdev_lock.  open_mutex is used to synchronize disk_holder unlinking.
 	 */
 	mutex_lock(&bdev_lock);
+	WARN_ON_ONCE(bdev->bd_holder != holder);
 	WARN_ON_ONCE(--bdev->bd_holders < 0);
 	WARN_ON_ONCE(--whole->bd_holders < 0);
 	if (!bdev->bd_holders) {
@@ -750,10 +751,9 @@ void blkdev_put_no_open(struct block_device *bdev)
  * @holder: exclusive holder identifier
  * @hops: holder operations
  *
- * Open the block device described by device number @dev. If @mode includes
- * %FMODE_EXCL, the block device is opened with exclusive access.  Specifying
- * %FMODE_EXCL with a %NULL @holder is invalid.  Exclusive opens may nest for
- * the same @holder.
+ * Open the block device described by device number @dev. If @holder is not
+ * %NULL, the block device is opened with exclusive access.  Exclusive opens may
+ * nest for the same @holder.
  *
  * Use this interface ONLY if you really do not have anything better - i.e. when
  * you are behind a truly sucky interface and all you are given is a device
@@ -785,10 +785,16 @@ struct block_device *blkdev_get_by_dev(dev_t dev, fmode_t mode, void *holder,
 		return ERR_PTR(-ENXIO);
 	disk = bdev->bd_disk;
 
-	if (mode & FMODE_EXCL) {
+	if (holder) {
+		mode |= FMODE_EXCL;
 		ret = bd_prepare_to_claim(bdev, holder, hops);
 		if (ret)
 			goto put_blkdev;
+	} else {
+		if (WARN_ON_ONCE(mode & FMODE_EXCL)) {
+			ret = -EIO;
+			goto put_blkdev;
+		}
 	}
 
 	disk_block_events(disk);
@@ -805,7 +811,7 @@ struct block_device *blkdev_get_by_dev(dev_t dev, fmode_t mode, void *holder,
 		ret = blkdev_get_whole(bdev, mode);
 	if (ret)
 		goto put_module;
-	if (mode & FMODE_EXCL) {
+	if (holder) {
 		bd_finish_claiming(bdev, holder, hops);
 
 		/*
@@ -829,7 +835,7 @@ struct block_device *blkdev_get_by_dev(dev_t dev, fmode_t mode, void *holder,
 put_module:
 	module_put(disk->fops->owner);
 abort_claiming:
-	if (mode & FMODE_EXCL)
+	if (holder)
 		bd_abort_claiming(bdev, holder);
 	mutex_unlock(&disk->open_mutex);
 	disk_unblock_events(disk);
@@ -845,10 +851,9 @@ EXPORT_SYMBOL(blkdev_get_by_dev);
  * @mode: FMODE_* mask
  * @holder: exclusive holder identifier
  *
- * Open the block device described by the device file at @path.  If @mode
- * includes %FMODE_EXCL, the block device is opened with exclusive access.
- * Specifying %FMODE_EXCL with a %NULL @holder is invalid.  Exclusive opens may
- * nest for the same @holder.
+ * Open the block device described by the device file at @path.  If @holder is
+ * not %NULL, the block device is opened with exclusive access.  Exclusive opens
+ * may nest for the same @holder.
  *
  * CONTEXT:
  * Might sleep.
@@ -869,7 +874,7 @@ struct block_device *blkdev_get_by_path(const char *path, fmode_t mode,
 
 	bdev = blkdev_get_by_dev(dev, mode, holder, hops);
 	if (!IS_ERR(bdev) && (mode & FMODE_WRITE) && bdev_read_only(bdev)) {
-		blkdev_put(bdev, mode);
+		blkdev_put(bdev, holder);
 		return ERR_PTR(-EACCES);
 	}
 
@@ -877,7 +882,7 @@ struct block_device *blkdev_get_by_path(const char *path, fmode_t mode,
 }
 EXPORT_SYMBOL(blkdev_get_by_path);
 
-void blkdev_put(struct block_device *bdev, fmode_t mode)
+void blkdev_put(struct block_device *bdev, void *holder)
 {
 	struct gendisk *disk = bdev->bd_disk;
 
@@ -892,8 +897,8 @@ void blkdev_put(struct block_device *bdev, fmode_t mode)
 		sync_blockdev(bdev);
 
 	mutex_lock(&disk->open_mutex);
-	if (mode & FMODE_EXCL)
-		bd_end_claim(bdev);
+	if (holder)
+		bd_end_claim(bdev, holder);
 
 	/*
 	 * Trigger event checking and tell drivers to flush MEDIA_CHANGE
diff --git a/block/fops.c b/block/fops.c
index 26af2b39c758e1..9f26e25bafa172 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -490,7 +490,9 @@ static int blkdev_open(struct inode *inode, struct file *filp)
 	if ((filp->f_flags & O_ACCMODE) == 3)
 		filp->f_mode |= FMODE_WRITE_IOCTL;
 
-	bdev = blkdev_get_by_dev(inode->i_rdev, filp->f_mode, filp, NULL);
+	bdev = blkdev_get_by_dev(inode->i_rdev, filp->f_mode,
+				 (filp->f_mode & FMODE_EXCL) ? filp : NULL,
+				 NULL);
 	if (IS_ERR(bdev))
 		return PTR_ERR(bdev);
 
@@ -504,7 +506,7 @@ static int blkdev_release(struct inode *inode, struct file *filp)
 {
 	struct block_device *bdev = filp->private_data;
 
-	blkdev_put(bdev, filp->f_mode);
+	blkdev_put(bdev, (filp->f_mode & FMODE_EXCL) ? filp : NULL);
 	return 0;
 }
 
diff --git a/block/genhd.c b/block/genhd.c
index 4e5fd6aaa883fd..b56f8b5c88b3e3 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -365,12 +365,11 @@ int disk_scan_partitions(struct gendisk *disk, fmode_t mode)
 	}
 
 	set_bit(GD_NEED_PART_SCAN, &disk->state);
-	bdev = blkdev_get_by_dev(disk_devt(disk), mode & ~FMODE_EXCL, NULL,
-				 NULL);
+	bdev = blkdev_get_by_dev(disk_devt(disk), mode, NULL, NULL);
 	if (IS_ERR(bdev))
 		ret =  PTR_ERR(bdev);
 	else
-		blkdev_put(bdev, mode & ~FMODE_EXCL);
+		blkdev_put(bdev, NULL);
 
 	/*
 	 * If blkdev_get_by_dev() failed early, GD_NEED_PART_SCAN is still set,
diff --git a/block/ioctl.c b/block/ioctl.c
index c7d7d4345edb4f..b39bd5b41ee492 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -454,11 +454,10 @@ static int blkdev_bszset(struct block_device *bdev, fmode_t mode,
 	if (mode & FMODE_EXCL)
 		return set_blocksize(bdev, n);
 
-	if (IS_ERR(blkdev_get_by_dev(bdev->bd_dev, mode | FMODE_EXCL, &bdev,
-			NULL)))
+	if (IS_ERR(blkdev_get_by_dev(bdev->bd_dev, mode, &bdev, NULL)))
 		return -EBUSY;
 	ret = set_blocksize(bdev, n);
-	blkdev_put(bdev, mode | FMODE_EXCL);
+	blkdev_put(bdev, &bdev);
 
 	return ret;
 }
diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index cab59dab3410aa..10b1e5171332f7 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -1640,8 +1640,7 @@ static struct block_device *open_backing_dev(struct drbd_device *device,
 	struct block_device *bdev;
 	int err = 0;
 
-	bdev = blkdev_get_by_path(bdev_path,
-				  FMODE_READ | FMODE_WRITE | FMODE_EXCL,
+	bdev = blkdev_get_by_path(bdev_path, FMODE_READ | FMODE_WRITE,
 				  claim_ptr, NULL);
 	if (IS_ERR(bdev)) {
 		drbd_err(device, "open(\"%s\") failed with %ld\n",
@@ -1654,7 +1653,7 @@ static struct block_device *open_backing_dev(struct drbd_device *device,
 
 	err = bd_link_disk_holder(bdev, device->vdisk);
 	if (err) {
-		blkdev_put(bdev, FMODE_READ | FMODE_WRITE | FMODE_EXCL);
+		blkdev_put(bdev, claim_ptr);
 		drbd_err(device, "bd_link_disk_holder(\"%s\", ...) failed with %d\n",
 				bdev_path, err);
 		bdev = ERR_PTR(err);
@@ -1696,13 +1695,13 @@ static int open_backing_devices(struct drbd_device *device,
 }
 
 static void close_backing_dev(struct drbd_device *device, struct block_device *bdev,
-	bool do_bd_unlink)
+		void *claim_ptr, bool do_bd_unlink)
 {
 	if (!bdev)
 		return;
 	if (do_bd_unlink)
 		bd_unlink_disk_holder(bdev, device->vdisk);
-	blkdev_put(bdev, FMODE_READ | FMODE_WRITE | FMODE_EXCL);
+	blkdev_put(bdev, claim_ptr);
 }
 
 void drbd_backing_dev_free(struct drbd_device *device, struct drbd_backing_dev *ldev)
@@ -1710,8 +1709,11 @@ void drbd_backing_dev_free(struct drbd_device *device, struct drbd_backing_dev *
 	if (ldev == NULL)
 		return;
 
-	close_backing_dev(device, ldev->md_bdev, ldev->md_bdev != ldev->backing_bdev);
-	close_backing_dev(device, ldev->backing_bdev, true);
+	close_backing_dev(device, ldev->md_bdev,
+			  ldev->md.meta_dev_idx < 0 ?
+				(void *)device : (void *)drbd_m_holder,
+			  ldev->md_bdev != ldev->backing_bdev);
+	close_backing_dev(device, ldev->backing_bdev, device, true);
 
 	kfree(ldev->disk_conf);
 	kfree(ldev);
@@ -2127,8 +2129,11 @@ int drbd_adm_attach(struct sk_buff *skb, struct genl_info *info)
  fail:
 	conn_reconfig_done(connection);
 	if (nbc) {
-		close_backing_dev(device, nbc->md_bdev, nbc->md_bdev != nbc->backing_bdev);
-		close_backing_dev(device, nbc->backing_bdev, true);
+		close_backing_dev(device, nbc->md_bdev,
+			  nbc->disk_conf->meta_dev_idx < 0 ?
+				(void *)device : (void *)drbd_m_holder,
+			  nbc->md_bdev != nbc->backing_bdev);
+		close_backing_dev(device, nbc->backing_bdev, device, true);
 		kfree(nbc);
 	}
 	kfree(new_disk_conf);
diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 7bfc058cb66504..c3299e49edd5ef 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -2167,8 +2167,7 @@ static int pkt_open_dev(struct pktcdvd_device *pd, fmode_t write)
 	 * to read/write from/to it. It is already opened in O_NONBLOCK mode
 	 * so open should not fail.
 	 */
-	bdev = blkdev_get_by_dev(pd->bdev->bd_dev, FMODE_READ | FMODE_EXCL, pd,
-				 NULL);
+	bdev = blkdev_get_by_dev(pd->bdev->bd_dev, FMODE_READ, pd, NULL);
 	if (IS_ERR(bdev)) {
 		ret = PTR_ERR(bdev);
 		goto out;
@@ -2215,7 +2214,7 @@ static int pkt_open_dev(struct pktcdvd_device *pd, fmode_t write)
 	return 0;
 
 out_putdev:
-	blkdev_put(bdev, FMODE_READ | FMODE_EXCL);
+	blkdev_put(bdev, pd);
 out:
 	return ret;
 }
@@ -2234,7 +2233,7 @@ static void pkt_release_dev(struct pktcdvd_device *pd, int flush)
 	pkt_lock_door(pd, 0);
 
 	pkt_set_speed(pd, MAX_SPEED, MAX_SPEED);
-	blkdev_put(pd->bdev, FMODE_READ | FMODE_EXCL);
+	blkdev_put(pd->bdev, pd);
 
 	pkt_shrink_pktlist(pd);
 }
@@ -2520,7 +2519,7 @@ static int pkt_new_dev(struct pktcdvd_device *pd, dev_t dev)
 		return PTR_ERR(bdev);
 	sdev = scsi_device_from_queue(bdev->bd_disk->queue);
 	if (!sdev) {
-		blkdev_put(bdev, FMODE_READ | FMODE_NDELAY);
+		blkdev_put(bdev, NULL);
 		return -EINVAL;
 	}
 	put_device(&sdev->sdev_gendev);
@@ -2545,7 +2544,7 @@ static int pkt_new_dev(struct pktcdvd_device *pd, dev_t dev)
 	return 0;
 
 out_mem:
-	blkdev_put(bdev, FMODE_READ | FMODE_NDELAY);
+	blkdev_put(bdev, NULL);
 	/* This is safe: open() is still holding a reference. */
 	module_put(THIS_MODULE);
 	return -ENOMEM;
@@ -2751,7 +2750,7 @@ static int pkt_remove_dev(dev_t pkt_dev)
 	pkt_debugfs_dev_remove(pd);
 	pkt_sysfs_dev_remove(pd);
 
-	blkdev_put(pd->bdev, FMODE_READ | FMODE_NDELAY);
+	blkdev_put(pd->bdev, NULL);
 
 	remove_proc_entry(pd->disk->disk_name, pkt_proc);
 	dev_notice(ddev, "writer unmapped\n");
diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index ce505e552f4d50..29d560472d05ba 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -219,7 +219,7 @@ void rnbd_destroy_sess_dev(struct rnbd_srv_sess_dev *sess_dev, bool keep_id)
 	rnbd_put_sess_dev(sess_dev);
 	wait_for_completion(&dc); /* wait for inflights to drop to zero */
 
-	blkdev_put(sess_dev->bdev, sess_dev->open_flags);
+	blkdev_put(sess_dev->bdev, NULL);
 	mutex_lock(&sess_dev->dev->lock);
 	list_del(&sess_dev->dev_list);
 	if (sess_dev->open_flags & FMODE_WRITE)
@@ -795,7 +795,7 @@ static int process_msg_open(struct rnbd_srv_session *srv_sess,
 	}
 	rnbd_put_srv_dev(srv_dev);
 blkdev_put:
-	blkdev_put(bdev, open_flags);
+	blkdev_put(bdev, NULL);
 free_path:
 	kfree(full_path);
 reject:
diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
index 43b36da9b3544d..141b60aad57038 100644
--- a/drivers/block/xen-blkback/xenbus.c
+++ b/drivers/block/xen-blkback/xenbus.c
@@ -473,7 +473,7 @@ static void xenvbd_sysfs_delif(struct xenbus_device *dev)
 static void xen_vbd_free(struct xen_vbd *vbd)
 {
 	if (vbd->bdev)
-		blkdev_put(vbd->bdev, vbd->readonly ? FMODE_READ : FMODE_WRITE);
+		blkdev_put(vbd->bdev, NULL);
 	vbd->bdev = NULL;
 }
 
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index f5644c60604070..21615d67a9bd66 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -420,7 +420,7 @@ static void reset_bdev(struct zram *zram)
 		return;
 
 	bdev = zram->bdev;
-	blkdev_put(bdev, FMODE_READ|FMODE_WRITE|FMODE_EXCL);
+	blkdev_put(bdev, zram);
 	/* hope filp_close flush all of IO */
 	filp_close(zram->backing_dev, NULL);
 	zram->backing_dev = NULL;
@@ -507,8 +507,8 @@ static ssize_t backing_dev_store(struct device *dev,
 		goto out;
 	}
 
-	bdev = blkdev_get_by_dev(inode->i_rdev,
-			FMODE_READ | FMODE_WRITE | FMODE_EXCL, zram, NULL);
+	bdev = blkdev_get_by_dev(inode->i_rdev, FMODE_READ | FMODE_WRITE, zram,
+				 NULL);
 	if (IS_ERR(bdev)) {
 		err = PTR_ERR(bdev);
 		bdev = NULL;
@@ -539,7 +539,7 @@ static ssize_t backing_dev_store(struct device *dev,
 	kvfree(bitmap);
 
 	if (bdev)
-		blkdev_put(bdev, FMODE_READ | FMODE_WRITE | FMODE_EXCL);
+		blkdev_put(bdev, zram);
 
 	if (backing_dev)
 		filp_close(backing_dev, NULL);
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 4a2aed047aec12..7022fea396f25e 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -1369,7 +1369,7 @@ static void cached_dev_free(struct closure *cl)
 		put_page(virt_to_page(dc->sb_disk));
 
 	if (!IS_ERR_OR_NULL(dc->bdev))
-		blkdev_put(dc->bdev, FMODE_READ|FMODE_WRITE|FMODE_EXCL);
+		blkdev_put(dc->bdev, bcache_kobj);
 
 	wake_up(&unregister_wait);
 
@@ -2218,7 +2218,7 @@ void bch_cache_release(struct kobject *kobj)
 		put_page(virt_to_page(ca->sb_disk));
 
 	if (!IS_ERR_OR_NULL(ca->bdev))
-		blkdev_put(ca->bdev, FMODE_READ|FMODE_WRITE|FMODE_EXCL);
+		blkdev_put(ca->bdev, bcache_kobj);
 
 	kfree(ca);
 	module_put(THIS_MODULE);
@@ -2359,7 +2359,7 @@ static int register_cache(struct cache_sb *sb, struct cache_sb_disk *sb_disk,
 		 * call blkdev_put() to bdev in bch_cache_release(). So we
 		 * explicitly call blkdev_put() here.
 		 */
-		blkdev_put(bdev, FMODE_READ|FMODE_WRITE|FMODE_EXCL);
+		blkdev_put(bdev, bcache_kobj);
 		if (ret == -ENOMEM)
 			err = "cache_alloc(): -ENOMEM";
 		else if (ret == -EPERM)
@@ -2461,7 +2461,7 @@ static void register_bdev_worker(struct work_struct *work)
 	if (!dc) {
 		fail = true;
 		put_page(virt_to_page(args->sb_disk));
-		blkdev_put(args->bdev, FMODE_READ | FMODE_WRITE | FMODE_EXCL);
+		blkdev_put(args->bdev, bcache_kobj);
 		goto out;
 	}
 
@@ -2491,7 +2491,7 @@ static void register_cache_worker(struct work_struct *work)
 	if (!ca) {
 		fail = true;
 		put_page(virt_to_page(args->sb_disk));
-		blkdev_put(args->bdev, FMODE_READ | FMODE_WRITE | FMODE_EXCL);
+		blkdev_put(args->bdev, bcache_kobj);
 		goto out;
 	}
 
@@ -2558,8 +2558,7 @@ static ssize_t register_bcache(struct kobject *k, struct kobj_attribute *attr,
 
 	ret = -EINVAL;
 	err = "failed to open device";
-	bdev = blkdev_get_by_path(strim(path),
-				  FMODE_READ|FMODE_WRITE|FMODE_EXCL,
+	bdev = blkdev_get_by_path(strim(path), FMODE_READ | FMODE_WRITE,
 				  bcache_kobj, NULL);
 	if (IS_ERR(bdev)) {
 		if (bdev == ERR_PTR(-EBUSY)) {
@@ -2648,7 +2647,7 @@ static ssize_t register_bcache(struct kobject *k, struct kobj_attribute *attr,
 out_put_sb_page:
 	put_page(virt_to_page(sb_disk));
 out_blkdev_put:
-	blkdev_put(bdev, FMODE_READ | FMODE_WRITE | FMODE_EXCL);
+	blkdev_put(bdev, register_bcache);
 out_free_sb:
 	kfree(sb);
 out_free_path:
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 246b8f028a98f4..b16e37362c5a01 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -746,7 +746,7 @@ static struct table_device *open_table_device(struct mapped_device *md,
 		return ERR_PTR(-ENOMEM);
 	refcount_set(&td->count, 1);
 
-	bdev = blkdev_get_by_dev(dev, mode | FMODE_EXCL, _dm_claim_ptr, NULL);
+	bdev = blkdev_get_by_dev(dev, mode, _dm_claim_ptr, NULL);
 	if (IS_ERR(bdev)) {
 		r = PTR_ERR(bdev);
 		goto out_free_td;
@@ -771,7 +771,7 @@ static struct table_device *open_table_device(struct mapped_device *md,
 	return td;
 
 out_blkdev_put:
-	blkdev_put(bdev, mode | FMODE_EXCL);
+	blkdev_put(bdev, _dm_claim_ptr);
 out_free_td:
 	kfree(td);
 	return ERR_PTR(r);
@@ -784,7 +784,7 @@ static void close_table_device(struct table_device *td, struct mapped_device *md
 {
 	if (md->disk->slave_dir)
 		bd_unlink_disk_holder(td->dm_dev.bdev, md->disk);
-	blkdev_put(td->dm_dev.bdev, td->dm_dev.mode | FMODE_EXCL);
+	blkdev_put(td->dm_dev.bdev, _dm_claim_ptr);
 	put_dax(td->dm_dev.dax_dev);
 	list_del(&td->list);
 	kfree(td);
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 159197dd7b6de1..dad4a5539f9f68 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -2449,7 +2449,10 @@ static void rdev_delayed_delete(struct work_struct *ws)
 
 void md_autodetect_dev(dev_t dev);
 
-static void export_rdev(struct md_rdev *rdev)
+/* just for claiming the bdev */
+static struct md_rdev claim_rdev;
+
+static void export_rdev(struct md_rdev *rdev, struct mddev *mddev)
 {
 	pr_debug("md: export_rdev(%pg)\n", rdev->bdev);
 	md_rdev_clear(rdev);
@@ -2457,7 +2460,7 @@ static void export_rdev(struct md_rdev *rdev)
 	if (test_bit(AutoDetected, &rdev->flags))
 		md_autodetect_dev(rdev->bdev->bd_dev);
 #endif
-	blkdev_put(rdev->bdev, FMODE_READ | FMODE_WRITE | FMODE_EXCL);
+	blkdev_put(rdev->bdev, mddev->major_version == -2 ? &claim_rdev : rdev);
 	rdev->bdev = NULL;
 	kobject_put(&rdev->kobj);
 }
@@ -2485,7 +2488,7 @@ static void md_kick_rdev_from_array(struct md_rdev *rdev)
 	INIT_WORK(&rdev->del_work, rdev_delayed_delete);
 	kobject_get(&rdev->kobj);
 	queue_work(md_rdev_misc_wq, &rdev->del_work);
-	export_rdev(rdev);
+	export_rdev(rdev, rdev->mddev);
 }
 
 static void export_array(struct mddev *mddev)
@@ -3612,6 +3615,7 @@ int md_rdev_init(struct md_rdev *rdev)
 	return badblocks_init(&rdev->badblocks, 0);
 }
 EXPORT_SYMBOL_GPL(md_rdev_init);
+
 /*
  * Import a device. If 'super_format' >= 0, then sanity check the superblock
  *
@@ -3624,7 +3628,6 @@ EXPORT_SYMBOL_GPL(md_rdev_init);
  */
 static struct md_rdev *md_import_device(dev_t newdev, int super_format, int super_minor)
 {
-	static struct md_rdev claim_rdev; /* just for claiming the bdev */
 	struct md_rdev *rdev;
 	sector_t size;
 	int err;
@@ -3640,8 +3643,7 @@ static struct md_rdev *md_import_device(dev_t newdev, int super_format, int supe
 	if (err)
 		goto out_clear_rdev;
 
-	rdev->bdev = blkdev_get_by_dev(newdev,
-			FMODE_READ | FMODE_WRITE | FMODE_EXCL,
+	rdev->bdev = blkdev_get_by_dev(newdev, FMODE_READ | FMODE_WRITE,
 			super_format == -2 ? &claim_rdev : rdev, NULL);
 	if (IS_ERR(rdev->bdev)) {
 		pr_warn("md: could not open device unknown-block(%u,%u).\n",
@@ -3679,7 +3681,7 @@ static struct md_rdev *md_import_device(dev_t newdev, int super_format, int supe
 	return rdev;
 
 out_blkdev_put:
-	blkdev_put(rdev->bdev, FMODE_READ | FMODE_WRITE | FMODE_EXCL);
+	blkdev_put(rdev->bdev, super_format == -2 ? &claim_rdev : rdev);
 out_clear_rdev:
 	md_rdev_clear(rdev);
 out_free_rdev:
@@ -4560,7 +4562,7 @@ new_dev_store(struct mddev *mddev, const char *buf, size_t len)
 	err = bind_rdev_to_array(rdev, mddev);
  out:
 	if (err)
-		export_rdev(rdev);
+		export_rdev(rdev, mddev);
 	mddev_unlock(mddev);
 	if (!err)
 		md_new_event();
@@ -6498,7 +6500,7 @@ static void autorun_devices(int part)
 			rdev_for_each_list(rdev, tmp, &candidates) {
 				list_del_init(&rdev->same_set);
 				if (bind_rdev_to_array(rdev, mddev))
-					export_rdev(rdev);
+					export_rdev(rdev, mddev);
 			}
 			autorun_array(mddev);
 			mddev_unlock(mddev);
@@ -6508,7 +6510,7 @@ static void autorun_devices(int part)
 		 */
 		rdev_for_each_list(rdev, tmp, &candidates) {
 			list_del_init(&rdev->same_set);
-			export_rdev(rdev);
+			export_rdev(rdev, mddev);
 		}
 		mddev_put(mddev);
 	}
@@ -6696,13 +6698,13 @@ int md_add_new_disk(struct mddev *mddev, struct mdu_disk_info_s *info)
 				pr_warn("md: %pg has different UUID to %pg\n",
 					rdev->bdev,
 					rdev0->bdev);
-				export_rdev(rdev);
+				export_rdev(rdev, mddev);
 				return -EINVAL;
 			}
 		}
 		err = bind_rdev_to_array(rdev, mddev);
 		if (err)
-			export_rdev(rdev);
+			export_rdev(rdev, mddev);
 		return err;
 	}
 
@@ -6746,7 +6748,7 @@ int md_add_new_disk(struct mddev *mddev, struct mdu_disk_info_s *info)
 			/* This was a hot-add request, but events doesn't
 			 * match, so reject it.
 			 */
-			export_rdev(rdev);
+			export_rdev(rdev, mddev);
 			return -EINVAL;
 		}
 
@@ -6772,7 +6774,7 @@ int md_add_new_disk(struct mddev *mddev, struct mdu_disk_info_s *info)
 				}
 			}
 			if (has_journal || mddev->bitmap) {
-				export_rdev(rdev);
+				export_rdev(rdev, mddev);
 				return -EBUSY;
 			}
 			set_bit(Journal, &rdev->flags);
@@ -6787,7 +6789,7 @@ int md_add_new_disk(struct mddev *mddev, struct mdu_disk_info_s *info)
 				/* --add initiated by this node */
 				err = md_cluster_ops->add_new_disk(mddev, rdev);
 				if (err) {
-					export_rdev(rdev);
+					export_rdev(rdev, mddev);
 					return err;
 				}
 			}
@@ -6797,7 +6799,7 @@ int md_add_new_disk(struct mddev *mddev, struct mdu_disk_info_s *info)
 		err = bind_rdev_to_array(rdev, mddev);
 
 		if (err)
-			export_rdev(rdev);
+			export_rdev(rdev, mddev);
 
 		if (mddev_is_clustered(mddev)) {
 			if (info->state & (1 << MD_DISK_CANDIDATE)) {
@@ -6860,7 +6862,7 @@ int md_add_new_disk(struct mddev *mddev, struct mdu_disk_info_s *info)
 
 		err = bind_rdev_to_array(rdev, mddev);
 		if (err) {
-			export_rdev(rdev);
+			export_rdev(rdev, mddev);
 			return err;
 		}
 	}
@@ -6985,7 +6987,7 @@ static int hot_add_disk(struct mddev *mddev, dev_t dev)
 	return 0;
 
 abort_export:
-	export_rdev(rdev);
+	export_rdev(rdev, mddev);
 	return err;
 }
 
diff --git a/drivers/mtd/devices/block2mtd.c b/drivers/mtd/devices/block2mtd.c
index 218eb2af564a81..44fc23af4c3f84 100644
--- a/drivers/mtd/devices/block2mtd.c
+++ b/drivers/mtd/devices/block2mtd.c
@@ -209,7 +209,7 @@ static void block2mtd_free_device(struct block2mtd_dev *dev)
 	if (dev->blkdev) {
 		invalidate_mapping_pages(dev->blkdev->bd_inode->i_mapping,
 					0, -1);
-		blkdev_put(dev->blkdev, FMODE_READ|FMODE_WRITE|FMODE_EXCL);
+		blkdev_put(dev->blkdev, NULL);
 	}
 
 	kfree(dev);
@@ -261,7 +261,7 @@ static struct block_device __ref *mdtblock_early_get_bdev(const char *devname,
 static struct block2mtd_dev *add_device(char *devname, int erase_size,
 		char *label, int timeout)
 {
-	const fmode_t mode = FMODE_READ | FMODE_WRITE | FMODE_EXCL;
+	const fmode_t mode = FMODE_READ | FMODE_WRITE;
 	struct block_device *bdev;
 	struct block2mtd_dev *dev;
 	char *name;
diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 9b6d6d85c72544..65ed2d478fac89 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -51,7 +51,7 @@ void nvmet_bdev_set_limits(struct block_device *bdev, struct nvme_id_ns *id)
 void nvmet_bdev_ns_disable(struct nvmet_ns *ns)
 {
 	if (ns->bdev) {
-		blkdev_put(ns->bdev, FMODE_WRITE | FMODE_READ);
+		blkdev_put(ns->bdev, NULL);
 		ns->bdev = NULL;
 	}
 }
diff --git a/drivers/s390/block/dasd_genhd.c b/drivers/s390/block/dasd_genhd.c
index f21198bc483e1a..d2b27b84f854cc 100644
--- a/drivers/s390/block/dasd_genhd.c
+++ b/drivers/s390/block/dasd_genhd.c
@@ -179,7 +179,7 @@ void dasd_destroy_partitions(struct dasd_block *block)
 	mutex_unlock(&bdev->bd_disk->open_mutex);
 
 	/* Matching blkdev_put to the blkdev_get in dasd_scan_partitions. */
-	blkdev_put(bdev, FMODE_READ);
+	blkdev_put(bdev, NULL);
 }
 
 int dasd_gendisk_init(void)
diff --git a/drivers/target/target_core_iblock.c b/drivers/target/target_core_iblock.c
index a5cbbefa78ee4e..c62f961f46e378 100644
--- a/drivers/target/target_core_iblock.c
+++ b/drivers/target/target_core_iblock.c
@@ -108,7 +108,7 @@ static int iblock_configure_device(struct se_device *dev)
 	pr_debug( "IBLOCK: Claiming struct block_device: %s\n",
 			ib_dev->ibd_udev_path);
 
-	mode = FMODE_READ|FMODE_EXCL;
+	mode = FMODE_READ;
 	if (!ib_dev->ibd_readonly)
 		mode |= FMODE_WRITE;
 	else
@@ -175,7 +175,7 @@ static int iblock_configure_device(struct se_device *dev)
 	return 0;
 
 out_blkdev_put:
-	blkdev_put(ib_dev->ibd_bd, FMODE_WRITE|FMODE_READ|FMODE_EXCL);
+	blkdev_put(ib_dev->ibd_bd, ib_dev);
 out_free_bioset:
 	bioset_exit(&ib_dev->ibd_bio_set);
 out:
@@ -201,7 +201,7 @@ static void iblock_destroy_device(struct se_device *dev)
 	struct iblock_dev *ib_dev = IBLOCK_DEV(dev);
 
 	if (ib_dev->ibd_bd != NULL)
-		blkdev_put(ib_dev->ibd_bd, FMODE_WRITE|FMODE_READ|FMODE_EXCL);
+		blkdev_put(ib_dev->ibd_bd, ib_dev);
 	bioset_exit(&ib_dev->ibd_bio_set);
 }
 
diff --git a/drivers/target/target_core_pscsi.c b/drivers/target/target_core_pscsi.c
index e3494e036c6c85..da3b5512d7ae32 100644
--- a/drivers/target/target_core_pscsi.c
+++ b/drivers/target/target_core_pscsi.c
@@ -366,8 +366,7 @@ static int pscsi_create_type_disk(struct se_device *dev, struct scsi_device *sd)
 	 * Claim exclusive struct block_device access to struct scsi_device
 	 * for TYPE_DISK and TYPE_ZBC using supplied udev_path
 	 */
-	bd = blkdev_get_by_path(dev->udev_path,
-				FMODE_WRITE|FMODE_READ|FMODE_EXCL, pdv,
+	bd = blkdev_get_by_path(dev->udev_path, FMODE_WRITE | FMODE_READ, pdv,
 				NULL);
 	if (IS_ERR(bd)) {
 		pr_err("pSCSI: blkdev_get_by_path() failed\n");
@@ -378,7 +377,7 @@ static int pscsi_create_type_disk(struct se_device *dev, struct scsi_device *sd)
 
 	ret = pscsi_add_device_to_list(dev, sd);
 	if (ret) {
-		blkdev_put(pdv->pdv_bd, FMODE_WRITE|FMODE_READ|FMODE_EXCL);
+		blkdev_put(pdv->pdv_bd, pdv);
 		scsi_device_put(sd);
 		return ret;
 	}
@@ -566,8 +565,7 @@ static void pscsi_destroy_device(struct se_device *dev)
 		 */
 		if ((sd->type == TYPE_DISK || sd->type == TYPE_ZBC) &&
 		    pdv->pdv_bd) {
-			blkdev_put(pdv->pdv_bd,
-				   FMODE_WRITE|FMODE_READ|FMODE_EXCL);
+			blkdev_put(pdv->pdv_bd, pdv);
 			pdv->pdv_bd = NULL;
 		}
 		/*
diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 4de4984fa99ba3..677e9d9e1527aa 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -257,7 +257,7 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
 		return -EINVAL;
 	}
 
-	bdev = blkdev_get_by_path(device_path, FMODE_WRITE | FMODE_EXCL,
+	bdev = blkdev_get_by_path(device_path, FMODE_WRITE,
 				  fs_info->bdev_holder, NULL);
 	if (IS_ERR(bdev)) {
 		btrfs_err(fs_info, "target device %s is invalid!", device_path);
@@ -315,7 +315,7 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
 	device->bdev = bdev;
 	set_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state);
 	set_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state);
-	device->mode = FMODE_EXCL;
+	device->holder = fs_info->bdev_holder;
 	device->dev_stats_valid = 1;
 	set_blocksize(device->bdev, BTRFS_BDEV_BLOCKSIZE);
 	device->fs_devices = fs_devices;
@@ -334,7 +334,7 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
 	return 0;
 
 error:
-	blkdev_put(bdev, FMODE_EXCL);
+	blkdev_put(bdev, fs_info->bdev_holder);
 	return ret;
 }
 
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 2fa36f694daa53..d99376a79ef43a 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2672,7 +2672,7 @@ static long btrfs_ioctl_rm_dev_v2(struct file *file, void __user *arg)
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct btrfs_ioctl_vol_args_v2 *vol_args;
 	struct block_device *bdev = NULL;
-	fmode_t mode;
+	void *holder;
 	int ret;
 	bool cancel = false;
 
@@ -2709,7 +2709,7 @@ static long btrfs_ioctl_rm_dev_v2(struct file *file, void __user *arg)
 		goto err_drop;
 
 	/* Exclusive operation is now claimed */
-	ret = btrfs_rm_device(fs_info, &args, &bdev, &mode);
+	ret = btrfs_rm_device(fs_info, &args, &bdev, &holder);
 
 	btrfs_exclop_finish(fs_info);
 
@@ -2724,7 +2724,7 @@ static long btrfs_ioctl_rm_dev_v2(struct file *file, void __user *arg)
 err_drop:
 	mnt_drop_write_file(file);
 	if (bdev)
-		blkdev_put(bdev, mode);
+		blkdev_put(bdev, holder);
 out:
 	btrfs_put_dev_args_from_path(&args);
 	kfree(vol_args);
@@ -2738,7 +2738,7 @@ static long btrfs_ioctl_rm_dev(struct file *file, void __user *arg)
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct btrfs_ioctl_vol_args *vol_args;
 	struct block_device *bdev = NULL;
-	fmode_t mode;
+	void *holder;
 	int ret;
 	bool cancel = false;
 
@@ -2765,7 +2765,7 @@ static long btrfs_ioctl_rm_dev(struct file *file, void __user *arg)
 	ret = exclop_start_or_cancel_reloc(fs_info, BTRFS_EXCLOP_DEV_REMOVE,
 					   cancel);
 	if (ret == 0) {
-		ret = btrfs_rm_device(fs_info, &args, &bdev, &mode);
+		ret = btrfs_rm_device(fs_info, &args, &bdev, &holder);
 		if (!ret)
 			btrfs_info(fs_info, "disk deleted %s", vol_args->name);
 		btrfs_exclop_finish(fs_info);
@@ -2773,7 +2773,7 @@ static long btrfs_ioctl_rm_dev(struct file *file, void __user *arg)
 
 	mnt_drop_write_file(file);
 	if (bdev)
-		blkdev_put(bdev, mode);
+		blkdev_put(bdev, holder);
 out:
 	btrfs_put_dev_args_from_path(&args);
 	kfree(vol_args);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 035868cee3ddc3..7b12e05cdbf00b 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -507,14 +507,14 @@ btrfs_get_bdev_and_sb(const char *device_path, fmode_t flags, void *holder,
 		sync_blockdev(*bdev);
 	ret = set_blocksize(*bdev, BTRFS_BDEV_BLOCKSIZE);
 	if (ret) {
-		blkdev_put(*bdev, flags);
+		blkdev_put(*bdev, holder);
 		goto error;
 	}
 	invalidate_bdev(*bdev);
 	*disk_super = btrfs_read_dev_super(*bdev);
 	if (IS_ERR(*disk_super)) {
 		ret = PTR_ERR(*disk_super);
-		blkdev_put(*bdev, flags);
+		blkdev_put(*bdev, holder);
 		goto error;
 	}
 
@@ -642,7 +642,7 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
 
 	device->bdev = bdev;
 	clear_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state);
-	device->mode = flags;
+	device->holder = holder;
 
 	fs_devices->open_devices++;
 	if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state) &&
@@ -656,7 +656,7 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
 
 error_free_page:
 	btrfs_release_disk_super(disk_super);
-	blkdev_put(bdev, flags);
+	blkdev_put(bdev, holder);
 
 	return -EINVAL;
 }
@@ -1057,7 +1057,7 @@ static void __btrfs_free_extra_devids(struct btrfs_fs_devices *fs_devices,
 			continue;
 
 		if (device->bdev) {
-			blkdev_put(device->bdev, device->mode);
+			blkdev_put(device->bdev, device->holder);
 			device->bdev = NULL;
 			fs_devices->open_devices--;
 		}
@@ -1103,7 +1103,7 @@ static void btrfs_close_bdev(struct btrfs_device *device)
 		invalidate_bdev(device->bdev);
 	}
 
-	blkdev_put(device->bdev, device->mode);
+	blkdev_put(device->bdev, device->holder);
 }
 
 static void btrfs_close_one_device(struct btrfs_device *device)
@@ -1213,8 +1213,6 @@ static int open_fs_devices(struct btrfs_fs_devices *fs_devices,
 	struct btrfs_device *latest_dev = NULL;
 	struct btrfs_device *tmp_device;
 
-	flags |= FMODE_EXCL;
-
 	list_for_each_entry_safe(device, tmp_device, &fs_devices->devices,
 				 dev_list) {
 		int ret;
@@ -1400,7 +1398,7 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, fmode_t flags)
 	btrfs_release_disk_super(disk_super);
 
 error_bdev_put:
-	blkdev_put(bdev, flags);
+	blkdev_put(bdev, NULL);
 
 	return device;
 }
@@ -2087,7 +2085,7 @@ void btrfs_scratch_superblocks(struct btrfs_fs_info *fs_info,
 
 int btrfs_rm_device(struct btrfs_fs_info *fs_info,
 		    struct btrfs_dev_lookup_args *args,
-		    struct block_device **bdev, fmode_t *mode)
+		    struct block_device **bdev, void **holder)
 {
 	struct btrfs_trans_handle *trans;
 	struct btrfs_device *device;
@@ -2226,7 +2224,7 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info,
 	}
 
 	*bdev = device->bdev;
-	*mode = device->mode;
+	*holder = device->holder;
 	synchronize_rcu();
 	btrfs_free_device(device);
 
@@ -2394,7 +2392,7 @@ int btrfs_get_dev_args_from_path(struct btrfs_fs_info *fs_info,
 	else
 		memcpy(args->fsid, disk_super->fsid, BTRFS_FSID_SIZE);
 	btrfs_release_disk_super(disk_super);
-	blkdev_put(bdev, FMODE_READ);
+	blkdev_put(bdev, NULL);
 	return 0;
 }
 
@@ -2627,7 +2625,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	if (sb_rdonly(sb) && !fs_devices->seeding)
 		return -EROFS;
 
-	bdev = blkdev_get_by_path(device_path, FMODE_WRITE | FMODE_EXCL,
+	bdev = blkdev_get_by_path(device_path, FMODE_WRITE,
 				  fs_info->bdev_holder, NULL);
 	if (IS_ERR(bdev))
 		return PTR_ERR(bdev);
@@ -2690,7 +2688,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	device->commit_total_bytes = device->total_bytes;
 	set_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state);
 	clear_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state);
-	device->mode = FMODE_EXCL;
+	device->holder = fs_info->bdev_holder;
 	device->dev_stats_valid = 1;
 	set_blocksize(device->bdev, BTRFS_BDEV_BLOCKSIZE);
 
@@ -2848,7 +2846,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 error_free_device:
 	btrfs_free_device(device);
 error:
-	blkdev_put(bdev, FMODE_EXCL);
+	blkdev_put(bdev, fs_info->bdev_holder);
 	if (locked) {
 		mutex_unlock(&uuid_mutex);
 		up_write(&sb->s_umount);
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index eb97a397b3c3fb..840a8df399072c 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -94,8 +94,8 @@ struct btrfs_device {
 
 	struct btrfs_zoned_device_info *zone_info;
 
-	/* the mode sent to blkdev_get */
-	fmode_t mode;
+	/* block device holder for blkdev_get/put */
+	void *holder;
 
 	/*
 	 * Device's major-minor number. Must be set even if the device is not
@@ -619,7 +619,7 @@ void btrfs_put_dev_args_from_path(struct btrfs_dev_lookup_args *args);
 void btrfs_free_device(struct btrfs_device *device);
 int btrfs_rm_device(struct btrfs_fs_info *fs_info,
 		    struct btrfs_dev_lookup_args *args,
-		    struct block_device **bdev, fmode_t *mode);
+		    struct block_device **bdev, void **holder);
 void __exit btrfs_cleanup_fs_uuids(void);
 int btrfs_num_copies(struct btrfs_fs_info *fs_info, u64 logical, u64 len);
 int btrfs_grow_device(struct btrfs_trans_handle *trans,
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 6c263e9cd38b2a..54dba967a2d445 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -19,6 +19,7 @@
 #include <trace/events/erofs.h>
 
 static struct kmem_cache *erofs_inode_cachep __read_mostly;
+struct file_system_type erofs_fs_type;
 
 void _erofs_err(struct super_block *sb, const char *function,
 		const char *fmt, ...)
@@ -253,8 +254,8 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
 			return PTR_ERR(fscache);
 		dif->fscache = fscache;
 	} else if (!sbi->devs->flatdev) {
-		bdev = blkdev_get_by_path(dif->path, FMODE_READ | FMODE_EXCL,
-					  sb->s_type, NULL);
+		bdev = blkdev_get_by_path(dif->path, FMODE_READ, sb->s_type,
+					  NULL);
 		if (IS_ERR(bdev))
 			return PTR_ERR(bdev);
 		dif->bdev = bdev;
@@ -877,7 +878,7 @@ static int erofs_release_device_info(int id, void *ptr, void *data)
 
 	fs_put_dax(dif->dax_dev, NULL);
 	if (dif->bdev)
-		blkdev_put(dif->bdev, FMODE_READ | FMODE_EXCL);
+		blkdev_put(dif->bdev, &erofs_fs_type);
 	erofs_fscache_unregister_cookie(dif->fscache);
 	dif->fscache = NULL;
 	kfree(dif->path);
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 9070ea9154d727..92dd699139a3f7 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1112,7 +1112,7 @@ static struct block_device *ext4_blkdev_get(dev_t dev, struct super_block *sb)
 {
 	struct block_device *bdev;
 
-	bdev = blkdev_get_by_dev(dev, FMODE_READ|FMODE_WRITE|FMODE_EXCL, sb,
+	bdev = blkdev_get_by_dev(dev, FMODE_READ | FMODE_WRITE, sb,
 				 &ext4_holder_ops);
 	if (IS_ERR(bdev))
 		goto fail;
@@ -1128,17 +1128,12 @@ static struct block_device *ext4_blkdev_get(dev_t dev, struct super_block *sb)
 /*
  * Release the journal device
  */
-static void ext4_blkdev_put(struct block_device *bdev)
-{
-	blkdev_put(bdev, FMODE_READ|FMODE_WRITE|FMODE_EXCL);
-}
-
 static void ext4_blkdev_remove(struct ext4_sb_info *sbi)
 {
 	struct block_device *bdev;
 	bdev = sbi->s_journal_bdev;
 	if (bdev) {
-		ext4_blkdev_put(bdev);
+		blkdev_put(bdev, sbi->s_es);
 		sbi->s_journal_bdev = NULL;
 	}
 }
@@ -5915,7 +5910,7 @@ static journal_t *ext4_get_dev_journal(struct super_block *sb,
 out_journal:
 	jbd2_journal_destroy(journal);
 out_bdev:
-	ext4_blkdev_put(bdev);
+	blkdev_put(bdev, sb);
 	return NULL;
 }
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 7c34ab082f1382..a5adb1d316e331 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1538,7 +1538,7 @@ static void destroy_device_list(struct f2fs_sb_info *sbi)
 	int i;
 
 	for (i = 0; i < sbi->s_ndevs; i++) {
-		blkdev_put(FDEV(i).bdev, FMODE_EXCL);
+		blkdev_put(FDEV(i).bdev, sbi->sb->s_type);
 #ifdef CONFIG_BLK_DEV_ZONED
 		kvfree(FDEV(i).blkz_seq);
 #endif
diff --git a/fs/jfs/jfs_logmgr.c b/fs/jfs/jfs_logmgr.c
index 46d393c8088a74..82f70d46f4e544 100644
--- a/fs/jfs/jfs_logmgr.c
+++ b/fs/jfs/jfs_logmgr.c
@@ -1100,7 +1100,7 @@ int lmLogOpen(struct super_block *sb)
 	 * file systems to log may have n-to-1 relationship;
 	 */
 
-	bdev = blkdev_get_by_dev(sbi->logdev, FMODE_READ|FMODE_WRITE|FMODE_EXCL,
+	bdev = blkdev_get_by_dev(sbi->logdev, FMODE_READ | FMODE_WRITE,
 				 log, NULL);
 	if (IS_ERR(bdev)) {
 		rc = PTR_ERR(bdev);
@@ -1141,7 +1141,7 @@ int lmLogOpen(struct super_block *sb)
 	lbmLogShutdown(log);
 
       close:		/* close external log device */
-	blkdev_put(bdev, FMODE_READ|FMODE_WRITE|FMODE_EXCL);
+	blkdev_put(bdev, log);
 
       free:		/* free log descriptor */
 	mutex_unlock(&jfs_log_mutex);
@@ -1485,7 +1485,7 @@ int lmLogClose(struct super_block *sb)
 	bdev = log->bdev;
 	rc = lmLogShutdown(log);
 
-	blkdev_put(bdev, FMODE_READ|FMODE_WRITE|FMODE_EXCL);
+	blkdev_put(bdev, log);
 
 	kfree(log);
 
diff --git a/fs/nfs/blocklayout/dev.c b/fs/nfs/blocklayout/dev.c
index 38b066ca699ed7..9be7f958f60e45 100644
--- a/fs/nfs/blocklayout/dev.c
+++ b/fs/nfs/blocklayout/dev.c
@@ -35,7 +35,7 @@ bl_free_device(struct pnfs_block_dev *dev)
 		}
 
 		if (dev->bdev)
-			blkdev_put(dev->bdev, FMODE_READ | FMODE_WRITE);
+			blkdev_put(dev->bdev, NULL);
 	}
 }
 
@@ -374,7 +374,7 @@ bl_parse_scsi(struct nfs_server *server, struct pnfs_block_dev *d,
 	return 0;
 
 out_blkdev_put:
-	blkdev_put(d->bdev, FMODE_READ | FMODE_WRITE);
+	blkdev_put(d->bdev, NULL);
 	return error;
 }
 
diff --git a/fs/nilfs2/super.c b/fs/nilfs2/super.c
index 91bfbd973d1d53..61d5e79a5e81df 100644
--- a/fs/nilfs2/super.c
+++ b/fs/nilfs2/super.c
@@ -1278,7 +1278,7 @@ nilfs_mount(struct file_system_type *fs_type, int flags,
 {
 	struct nilfs_super_data sd;
 	struct super_block *s;
-	fmode_t mode = FMODE_READ | FMODE_EXCL;
+	fmode_t mode = FMODE_READ;
 	struct dentry *root_dentry;
 	int err, s_new = false;
 
@@ -1357,7 +1357,7 @@ nilfs_mount(struct file_system_type *fs_type, int flags,
 	}
 
 	if (!s_new)
-		blkdev_put(sd.bdev, mode);
+		blkdev_put(sd.bdev, fs_type);
 
 	return root_dentry;
 
@@ -1366,7 +1366,7 @@ nilfs_mount(struct file_system_type *fs_type, int flags,
 
  failed:
 	if (!s_new)
-		blkdev_put(sd.bdev, mode);
+		blkdev_put(sd.bdev, fs_type);
 	return ERR_PTR(err);
 }
 
diff --git a/fs/ocfs2/cluster/heartbeat.c b/fs/ocfs2/cluster/heartbeat.c
index 6b13b8c3f2b8af..c6ae9aee01edb9 100644
--- a/fs/ocfs2/cluster/heartbeat.c
+++ b/fs/ocfs2/cluster/heartbeat.c
@@ -1503,7 +1503,7 @@ static void o2hb_region_release(struct config_item *item)
 	}
 
 	if (reg->hr_bdev)
-		blkdev_put(reg->hr_bdev, FMODE_READ|FMODE_WRITE);
+		blkdev_put(reg->hr_bdev, NULL);
 
 	kfree(reg->hr_slots);
 
@@ -1893,7 +1893,7 @@ static ssize_t o2hb_region_dev_store(struct config_item *item,
 
 out3:
 	if (ret < 0) {
-		blkdev_put(reg->hr_bdev, FMODE_READ | FMODE_WRITE);
+		blkdev_put(reg->hr_bdev, NULL);
 		reg->hr_bdev = NULL;
 	}
 out2:
diff --git a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
index 5e4db9a0c8e5a3..905297ea55458d 100644
--- a/fs/reiserfs/journal.c
+++ b/fs/reiserfs/journal.c
@@ -2589,7 +2589,7 @@ static void release_journal_dev(struct super_block *super,
 			       struct reiserfs_journal *journal)
 {
 	if (journal->j_dev_bd != NULL) {
-		blkdev_put(journal->j_dev_bd, journal->j_dev_mode);
+		blkdev_put(journal->j_dev_bd, journal);
 		journal->j_dev_bd = NULL;
 	}
 }
@@ -2598,9 +2598,10 @@ static int journal_init_dev(struct super_block *super,
 			    struct reiserfs_journal *journal,
 			    const char *jdev_name)
 {
+	fmode_t blkdev_mode = FMODE_READ;
+	void *holder = journal;
 	int result;
 	dev_t jdev;
-	fmode_t blkdev_mode = FMODE_READ | FMODE_WRITE | FMODE_EXCL;
 
 	result = 0;
 
@@ -2608,16 +2609,15 @@ static int journal_init_dev(struct super_block *super,
 	jdev = SB_ONDISK_JOURNAL_DEVICE(super) ?
 	    new_decode_dev(SB_ONDISK_JOURNAL_DEVICE(super)) : super->s_dev;
 
-	if (bdev_read_only(super->s_bdev))
-		blkdev_mode = FMODE_READ;
+	if (!bdev_read_only(super->s_bdev))
+		blkdev_mode |= FMODE_WRITE;
 
 	/* there is no "jdev" option and journal is on separate device */
 	if ((!jdev_name || !jdev_name[0])) {
 		if (jdev == super->s_dev)
-			blkdev_mode &= ~FMODE_EXCL;
-		journal->j_dev_bd = blkdev_get_by_dev(jdev, blkdev_mode,
-						      journal, NULL);
-		journal->j_dev_mode = blkdev_mode;
+			holder = NULL;
+		journal->j_dev_bd = blkdev_get_by_dev(jdev, blkdev_mode, holder,
+						      NULL);
 		if (IS_ERR(journal->j_dev_bd)) {
 			result = PTR_ERR(journal->j_dev_bd);
 			journal->j_dev_bd = NULL;
@@ -2631,8 +2631,7 @@ static int journal_init_dev(struct super_block *super,
 		return 0;
 	}
 
-	journal->j_dev_mode = blkdev_mode;
-	journal->j_dev_bd = blkdev_get_by_path(jdev_name, blkdev_mode, journal,
+	journal->j_dev_bd = blkdev_get_by_path(jdev_name, blkdev_mode, holder,
 					       NULL);
 	if (IS_ERR(journal->j_dev_bd)) {
 		result = PTR_ERR(journal->j_dev_bd);
diff --git a/fs/reiserfs/reiserfs.h b/fs/reiserfs/reiserfs.h
index 1bccf6a2e908fb..55e85256aae834 100644
--- a/fs/reiserfs/reiserfs.h
+++ b/fs/reiserfs/reiserfs.h
@@ -300,7 +300,6 @@ struct reiserfs_journal {
 	struct reiserfs_journal_cnode *j_first;
 
 	struct block_device *j_dev_bd;
-	fmode_t j_dev_mode;
 
 	/* first block on s_dev of reserved area journal */
 	int j_1st_reserved_block;
diff --git a/fs/super.c b/fs/super.c
index f127589700ab25..8563794a8bc462 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1255,7 +1255,7 @@ int get_tree_bdev(struct fs_context *fc,
 {
 	struct block_device *bdev;
 	struct super_block *s;
-	fmode_t mode = FMODE_READ | FMODE_EXCL;
+	fmode_t mode = FMODE_READ;
 	int error = 0;
 
 	if (!(fc->sb_flags & SB_RDONLY))
@@ -1279,7 +1279,7 @@ int get_tree_bdev(struct fs_context *fc,
 	if (bdev->bd_fsfreeze_count > 0) {
 		mutex_unlock(&bdev->bd_fsfreeze_mutex);
 		warnf(fc, "%pg: Can't mount, blockdev is frozen", bdev);
-		blkdev_put(bdev, mode);
+		blkdev_put(bdev, fc->fs_type);
 		return -EBUSY;
 	}
 
@@ -1288,7 +1288,7 @@ int get_tree_bdev(struct fs_context *fc,
 	s = sget_fc(fc, test_bdev_super_fc, set_bdev_super_fc);
 	mutex_unlock(&bdev->bd_fsfreeze_mutex);
 	if (IS_ERR(s)) {
-		blkdev_put(bdev, mode);
+		blkdev_put(bdev, fc->fs_type);
 		return PTR_ERR(s);
 	}
 
@@ -1297,7 +1297,7 @@ int get_tree_bdev(struct fs_context *fc,
 		if ((fc->sb_flags ^ s->s_flags) & SB_RDONLY) {
 			warnf(fc, "%pg: Can't mount, would change RO state", bdev);
 			deactivate_locked_super(s);
-			blkdev_put(bdev, mode);
+			blkdev_put(bdev, fc->fs_type);
 			return -EBUSY;
 		}
 
@@ -1309,7 +1309,7 @@ int get_tree_bdev(struct fs_context *fc,
 		 * holding an active reference.
 		 */
 		up_write(&s->s_umount);
-		blkdev_put(bdev, mode);
+		blkdev_put(bdev, fc->fs_type);
 		down_write(&s->s_umount);
 	} else {
 		s->s_mode = mode;
@@ -1344,7 +1344,7 @@ struct dentry *mount_bdev(struct file_system_type *fs_type,
 {
 	struct block_device *bdev;
 	struct super_block *s;
-	fmode_t mode = FMODE_READ | FMODE_EXCL;
+	fmode_t mode = FMODE_READ;
 	int error = 0;
 
 	if (!(flags & SB_RDONLY))
@@ -1386,7 +1386,7 @@ struct dentry *mount_bdev(struct file_system_type *fs_type,
 		 * holding an active reference.
 		 */
 		up_write(&s->s_umount);
-		blkdev_put(bdev, mode);
+		blkdev_put(bdev, fs_type);
 		down_write(&s->s_umount);
 	} else {
 		s->s_mode = mode;
@@ -1409,7 +1409,7 @@ struct dentry *mount_bdev(struct file_system_type *fs_type,
 error_s:
 	error = PTR_ERR(s);
 error_bdev:
-	blkdev_put(bdev, mode);
+	blkdev_put(bdev, fs_type);
 error:
 	return ERR_PTR(error);
 }
@@ -1418,13 +1418,11 @@ EXPORT_SYMBOL(mount_bdev);
 void kill_block_super(struct super_block *sb)
 {
 	struct block_device *bdev = sb->s_bdev;
-	fmode_t mode = sb->s_mode;
 
 	bdev->bd_super = NULL;
 	generic_shutdown_super(sb);
 	sync_blockdev(bdev);
-	WARN_ON_ONCE(!(mode & FMODE_EXCL));
-	blkdev_put(bdev, mode | FMODE_EXCL);
+	blkdev_put(bdev, sb->s_type);
 }
 
 EXPORT_SYMBOL(kill_block_super);
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 1b4bd5c88f4a11..3b7cf8268057fe 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -396,8 +396,8 @@ xfs_blkdev_get(
 {
 	int			error = 0;
 
-	*bdevp = blkdev_get_by_path(name, FMODE_READ|FMODE_WRITE|FMODE_EXCL,
-				    mp, &xfs_holder_ops);
+	*bdevp = blkdev_get_by_path(name, FMODE_READ | FMODE_WRITE, mp,
+				    &xfs_holder_ops);
 	if (IS_ERR(*bdevp)) {
 		error = PTR_ERR(*bdevp);
 		xfs_warn(mp, "Invalid device [%s], error=%d", name, error);
@@ -408,10 +408,11 @@ xfs_blkdev_get(
 
 STATIC void
 xfs_blkdev_put(
+	struct xfs_mount	*mp,
 	struct block_device	*bdev)
 {
 	if (bdev)
-		blkdev_put(bdev, FMODE_READ|FMODE_WRITE|FMODE_EXCL);
+		blkdev_put(bdev, mp);
 }
 
 STATIC void
@@ -422,13 +423,13 @@ xfs_close_devices(
 		struct block_device *logdev = mp->m_logdev_targp->bt_bdev;
 
 		xfs_free_buftarg(mp->m_logdev_targp);
-		xfs_blkdev_put(logdev);
+		xfs_blkdev_put(mp, logdev);
 	}
 	if (mp->m_rtdev_targp) {
 		struct block_device *rtdev = mp->m_rtdev_targp->bt_bdev;
 
 		xfs_free_buftarg(mp->m_rtdev_targp);
-		xfs_blkdev_put(rtdev);
+		xfs_blkdev_put(mp, rtdev);
 	}
 	xfs_free_buftarg(mp->m_ddev_targp);
 }
@@ -503,10 +504,10 @@ xfs_open_devices(
  out_free_ddev_targ:
 	xfs_free_buftarg(mp->m_ddev_targp);
  out_close_rtdev:
-	xfs_blkdev_put(rtdev);
+	xfs_blkdev_put(mp, rtdev);
  out_close_logdev:
 	if (logdev && logdev != ddev)
-		xfs_blkdev_put(logdev);
+		xfs_blkdev_put(mp, logdev);
 	return error;
 }
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 25bdd0cc74dce4..d5b99796f12c11 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1480,7 +1480,7 @@ struct block_device *blkdev_get_by_path(const char *path, fmode_t mode,
 int bd_prepare_to_claim(struct block_device *bdev, void *holder,
 		const struct blk_holder_ops *hops);
 void bd_abort_claiming(struct block_device *bdev, void *holder);
-void blkdev_put(struct block_device *bdev, fmode_t mode);
+void blkdev_put(struct block_device *bdev, void *holder);
 
 /* just for blk-cgroup, don't use elsewhere */
 struct block_device *blkdev_get_no_open(dev_t dev);
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 7ae95ec72f9902..f62e89d0d9068e 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -688,22 +688,18 @@ static int load_image_and_restore(bool snapshot_test)
 {
 	int error;
 	unsigned int flags;
-	fmode_t mode = FMODE_READ;
-
-	if (snapshot_test)
-		mode |= FMODE_EXCL;
 
 	pm_pr_dbg("Loading hibernation image.\n");
 
 	lock_device_hotplug();
 	error = create_basic_memory_bitmaps();
 	if (error) {
-		swsusp_close(mode);
+		swsusp_close(snapshot_test);
 		goto Unlock;
 	}
 
 	error = swsusp_read(&flags);
-	swsusp_close(mode);
+	swsusp_close(snapshot_test);
 	if (!error)
 		error = hibernation_restore(flags & SF_PLATFORM_MODE);
 
@@ -956,7 +952,7 @@ static int software_resume(void)
 	/* The snapshot device should not be opened while we're running */
 	if (!hibernate_acquire()) {
 		error = -EBUSY;
-		swsusp_close(FMODE_READ | FMODE_EXCL);
+		swsusp_close(false);
 		goto Unlock;
 	}
 
@@ -991,7 +987,7 @@ static int software_resume(void)
 	pm_pr_dbg("Hibernation image not present or could not be loaded.\n");
 	return error;
  Close_Finish:
-	swsusp_close(FMODE_READ | FMODE_EXCL);
+	swsusp_close(false);
 	goto Finish;
 }
 
diff --git a/kernel/power/power.h b/kernel/power/power.h
index 978189fcafd124..a8e0c44b804e6c 100644
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -177,7 +177,7 @@ int swsusp_check(bool snapshot_test);
 extern void swsusp_free(void);
 extern int swsusp_read(unsigned int *flags_p);
 extern int swsusp_write(unsigned int flags);
-extern void swsusp_close(fmode_t);
+void swsusp_close(bool snapshot_test);
 #ifdef CONFIG_SUSPEND
 extern int swsusp_unmark(void);
 #endif
diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index b03ff1a33c7f68..cc9259307c942a 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -363,7 +363,7 @@ static int swsusp_swap_check(void)
 
 	res = set_blocksize(hib_resume_bdev, PAGE_SIZE);
 	if (res < 0)
-		blkdev_put(hib_resume_bdev, FMODE_WRITE);
+		blkdev_put(hib_resume_bdev, NULL);
 
 	return res;
 }
@@ -443,7 +443,7 @@ static int get_swap_writer(struct swap_map_handle *handle)
 err_rel:
 	release_swap_writer(handle);
 err_close:
-	swsusp_close(FMODE_WRITE);
+	swsusp_close(false);
 	return ret;
 }
 
@@ -508,7 +508,7 @@ static int swap_writer_finish(struct swap_map_handle *handle,
 	if (error)
 		free_all_swap_pages(root_swap);
 	release_swap_writer(handle);
-	swsusp_close(FMODE_WRITE);
+	swsusp_close(false);
 
 	return error;
 }
@@ -1518,14 +1518,11 @@ static void *swsusp_holder;
 
 int swsusp_check(bool snapshot_test)
 {
+	void *holder = snapshot_test ? &swsusp_holder : NULL;
 	int error;
-	fmode_t mode = FMODE_READ;
 
-	if (snapshot_test)
-		mode |= FMODE_EXCL;
-
-	hib_resume_bdev = blkdev_get_by_dev(swsusp_resume_device,
-					    mode, &swsusp_holder, NULL);
+	hib_resume_bdev = blkdev_get_by_dev(swsusp_resume_device, FMODE_READ,
+					    holder, NULL);
 	if (!IS_ERR(hib_resume_bdev)) {
 		set_blocksize(hib_resume_bdev, PAGE_SIZE);
 		clear_page(swsusp_header);
@@ -1552,7 +1549,7 @@ int swsusp_check(bool snapshot_test)
 
 put:
 		if (error)
-			blkdev_put(hib_resume_bdev, mode);
+			blkdev_put(hib_resume_bdev, holder);
 		else
 			pr_debug("Image signature found, resuming\n");
 	} else {
@@ -1569,14 +1566,14 @@ int swsusp_check(bool snapshot_test)
  *	swsusp_close - close swap device.
  */
 
-void swsusp_close(fmode_t mode)
+void swsusp_close(bool snapshot_test)
 {
 	if (IS_ERR(hib_resume_bdev)) {
 		pr_debug("Image device not initialised\n");
 		return;
 	}
 
-	blkdev_put(hib_resume_bdev, mode);
+	blkdev_put(hib_resume_bdev, snapshot_test ? &swsusp_holder : NULL);
 }
 
 /**
diff --git a/mm/swapfile.c b/mm/swapfile.c
index cfbcf7d5705f5f..16554256be6554 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2539,7 +2539,7 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 		struct block_device *bdev = I_BDEV(inode);
 
 		set_blocksize(bdev, old_block_size);
-		blkdev_put(bdev, FMODE_READ | FMODE_WRITE | FMODE_EXCL);
+		blkdev_put(bdev, p);
 	}
 
 	inode_lock(inode);
@@ -2770,8 +2770,7 @@ static int claim_swapfile(struct swap_info_struct *p, struct inode *inode)
 
 	if (S_ISBLK(inode->i_mode)) {
 		p->bdev = blkdev_get_by_dev(inode->i_rdev,
-				   FMODE_READ | FMODE_WRITE | FMODE_EXCL, p,
-				   NULL);
+				   FMODE_READ | FMODE_WRITE, p, NULL);
 		if (IS_ERR(p->bdev)) {
 			error = PTR_ERR(p->bdev);
 			p->bdev = NULL;
@@ -3222,7 +3221,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	p->cluster_next_cpu = NULL;
 	if (inode && S_ISBLK(inode->i_mode) && p->bdev) {
 		set_blocksize(p->bdev, p->old_block_size);
-		blkdev_put(p->bdev, FMODE_READ | FMODE_WRITE | FMODE_EXCL);
+		blkdev_put(p->bdev, p);
 	}
 	inode = NULL;
 	destroy_swap_extents(p);
-- 
2.39.2

