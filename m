Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55DC131589F
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Feb 2021 22:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233723AbhBIV0B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Feb 2021 16:26:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:51924 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234161AbhBIUyV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 9 Feb 2021 15:54:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 98BBDB109;
        Tue,  9 Feb 2021 20:31:21 +0000 (UTC)
From:   Michal Rostecki <mrostecki@suse.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org (open list:BTRFS FILE SYSTEM),
        linux-kernel@vger.kernel.org (open list)
Cc:     Michal Rostecki <mrostecki@suse.com>
Subject: [PATCH RFC 2/6] btrfs: Store the last device I/O offset
Date:   Tue,  9 Feb 2021 21:30:36 +0100
Message-Id: <20210209203041.21493-3-mrostecki@suse.de>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210209203041.21493-1-mrostecki@suse.de>
References: <20210209203041.21493-1-mrostecki@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Michal Rostecki <mrostecki@suse.com>

Add an atomic field which stores the physical offset of the last I/O
operation  scheduled to the device. This information is going to be used
to measure the locality of I/O requests.

Signed-off-by: Michal Rostecki <mrostecki@suse.com>
---
 fs/btrfs/volumes.c | 4 ++++
 fs/btrfs/volumes.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index d4f452dcce95..292175206873 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -444,6 +444,7 @@ static struct btrfs_device *__alloc_device(struct btrfs_fs_info *fs_info)
 		kfree(dev);
 		return ERR_PTR(-ENOMEM);
 	}
+	atomic_set(&dev->last_offset, 0);
 
 	return dev;
 }
@@ -6368,11 +6369,13 @@ static void submit_stripe_bio(struct btrfs_bio *bbio, struct bio *bio,
 			      u64 physical, struct btrfs_device *dev)
 {
 	struct btrfs_fs_info *fs_info = bbio->fs_info;
+	u64 length;
 
 	bio->bi_private = bbio;
 	btrfs_io_bio(bio)->device = dev;
 	bio->bi_end_io = btrfs_end_bio;
 	bio->bi_iter.bi_sector = physical >> 9;
+	length = bio->bi_iter.bi_size;
 	btrfs_debug_in_rcu(fs_info,
 	"btrfs_map_bio: rw %d 0x%x, sector=%llu, dev=%lu (%s id %llu), size=%u",
 		bio_op(bio), bio->bi_opf, bio->bi_iter.bi_sector,
@@ -6382,6 +6385,7 @@ static void submit_stripe_bio(struct btrfs_bio *bbio, struct bio *bio,
 
 	btrfs_bio_counter_inc_noblocked(fs_info);
 	percpu_counter_inc(&dev->inflight);
+	atomic_set(&dev->last_offset, physical + length);
 
 	btrfsic_submit_bio(bio);
 }
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 938c5292250c..6e544317a377 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -146,6 +146,7 @@ struct btrfs_device {
 
 	/* I/O stats for raid1 mirror selection */
 	struct percpu_counter inflight;
+	atomic_t last_offset;
 };
 
 /*
-- 
2.30.0

