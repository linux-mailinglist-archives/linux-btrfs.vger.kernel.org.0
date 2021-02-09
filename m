Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B11723158A7
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Feb 2021 22:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234182AbhBIV3J (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Feb 2021 16:29:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:51920 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234159AbhBIUyW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 9 Feb 2021 15:54:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BE040ADE1;
        Tue,  9 Feb 2021 20:31:19 +0000 (UTC)
From:   Michal Rostecki <mrostecki@suse.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org (open list:BTRFS FILE SYSTEM),
        linux-kernel@vger.kernel.org (open list)
Cc:     Michal Rostecki <mrostecki@suse.com>
Subject: [PATCH RFC 1/6] btrfs: Add inflight BIO request counter
Date:   Tue,  9 Feb 2021 21:30:35 +0100
Message-Id: <20210209203041.21493-2-mrostecki@suse.de>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210209203041.21493-1-mrostecki@suse.de>
References: <20210209203041.21493-1-mrostecki@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Michal Rostecki <mrostecki@suse.com>

Add a per-CPU inflight BIO counter to btrfs_device which stores the
number of requests currently processed by the device. This information
is going to be used in roundrobin raid1 read policy.

Signed-off-by: Michal Rostecki <mrostecki@suse.com>
---
 fs/btrfs/volumes.c | 11 +++++++++--
 fs/btrfs/volumes.h |  3 +++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 3948f5b50d11..d4f452dcce95 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -376,6 +376,7 @@ void btrfs_free_device(struct btrfs_device *device)
 	extent_io_tree_release(&device->alloc_state);
 	bio_put(device->flush_bio);
 	btrfs_destroy_dev_zone_info(device);
+	percpu_counter_destroy(&device->inflight);
 	kfree(device);
 }
 
@@ -439,6 +440,11 @@ static struct btrfs_device *__alloc_device(struct btrfs_fs_info *fs_info)
 	extent_io_tree_init(fs_info, &dev->alloc_state,
 			    IO_TREE_DEVICE_ALLOC_STATE, NULL);
 
+	if (percpu_counter_init(&dev->inflight, 0, GFP_KERNEL)) {
+		kfree(dev);
+		return ERR_PTR(-ENOMEM);
+	}
+
 	return dev;
 }
 
@@ -6305,6 +6311,7 @@ static inline void btrfs_end_bbio(struct btrfs_bio *bbio, struct bio *bio)
 
 static void btrfs_end_bio(struct bio *bio)
 {
+	struct btrfs_device *dev = btrfs_io_bio(bio)->device;
 	struct btrfs_bio *bbio = bio->bi_private;
 	int is_orig_bio = 0;
 
@@ -6312,8 +6319,6 @@ static void btrfs_end_bio(struct bio *bio)
 		atomic_inc(&bbio->error);
 		if (bio->bi_status == BLK_STS_IOERR ||
 		    bio->bi_status == BLK_STS_TARGET) {
-			struct btrfs_device *dev = btrfs_io_bio(bio)->device;
-
 			ASSERT(dev->bdev);
 			if (bio_op(bio) == REQ_OP_WRITE)
 				btrfs_dev_stat_inc_and_print(dev,
@@ -6331,6 +6336,7 @@ static void btrfs_end_bio(struct bio *bio)
 		is_orig_bio = 1;
 
 	btrfs_bio_counter_dec(bbio->fs_info);
+	percpu_counter_dec(&dev->inflight);
 
 	if (atomic_dec_and_test(&bbio->stripes_pending)) {
 		if (!is_orig_bio) {
@@ -6375,6 +6381,7 @@ static void submit_stripe_bio(struct btrfs_bio *bbio, struct bio *bio,
 	bio_set_dev(bio, dev->bdev);
 
 	btrfs_bio_counter_inc_noblocked(fs_info);
+	percpu_counter_inc(&dev->inflight);
 
 	btrfsic_submit_bio(bio);
 }
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 04e2b26823c2..938c5292250c 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -143,6 +143,9 @@ struct btrfs_device {
 	struct completion kobj_unregister;
 	/* For sysfs/FSID/devinfo/devid/ */
 	struct kobject devid_kobj;
+
+	/* I/O stats for raid1 mirror selection */
+	struct percpu_counter inflight;
 };
 
 /*
-- 
2.30.0

