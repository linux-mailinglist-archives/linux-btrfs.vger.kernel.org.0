Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4D3B14EED
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 May 2019 17:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbfEFPGY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 May 2019 11:06:24 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39998 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727477AbfEFOhy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 May 2019 10:37:54 -0400
Received: by mail-lf1-f67.google.com with SMTP id o16so9319066lfl.7
        for <linux-btrfs@vger.kernel.org>; Mon, 06 May 2019 07:37:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2S6fgj69R/VRdSnhnFwRYzzmd1Z2WC7mAYC1WQ9OsT0=;
        b=XkAQfEPMWZjt29g5J3MZtUE+cxDyc9CZSKfYj6OvWw8uV+NQRmmNLslQ8SsAwvy6XQ
         5ygHoCU7UMe7RYf/04hk9/9U4IamhC28qi+uQ7ZsP8hhwLrScOjCICThJQXR30LnXi9f
         PtE7jSLTBhcIUmKyXRWkZgmfKh9e2/rxZQ6AilS0MKag0q30swu3QslE0vk96331Ww9w
         kUMGFS+4G6jfpvvTVbxhMlj6Oop14bhokITtSiETphbZJBDZWmcxy2TmL/slhRw9wZOc
         +R1jZLQ7aqI57BGkrPqxSXw0T/Rw6QG6CVbYWszk+EysS8Gh3RiJJ2WvCg3JFewq2Nnv
         t0yA==
X-Gm-Message-State: APjAAAWcr3uPMwXLGn/5iIYULh5uA5dE7R9LtKBiyjUamjKuSCAlWyME
        Wlo7WnBgM3mywDGgERUin76Cn+ajV+g=
X-Google-Smtp-Source: APXvYqxQoD+9MfAnoeD9Gevig6dOlyuOwz8gNgi5V+y/s78oZ6dHUzBjQ4/puoSb15Azis8f4+jUxQ==
X-Received: by 2002:ac2:533c:: with SMTP id f28mr3090747lfh.81.1557153471180;
        Mon, 06 May 2019 07:37:51 -0700 (PDT)
Received: from TitovetsT.synesis.local (mm-200-90-122-178.mgts.dynamic.pppoe.byfly.by. [178.122.90.200])
        by smtp.gmail.com with ESMTPSA id r136sm2456384lff.50.2019.05.06.07.37.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 07:37:49 -0700 (PDT)
From:   Timofey Titovets <timofey.titovets@synesis.ru>
To:     linux-btrfs@vger.kernel.org
Cc:     Timofey Titovets <nefelim4ag@gmail.com>,
        Dmitrii Tcvetkov <demfloro@demfloro.ru>
Subject: [PATCH V9] Btrfs: enhance raid1/10 balance heuristic
Date:   Mon,  6 May 2019 17:37:40 +0300
Message-Id: <20190506143740.26614-1-timofey.titovets@synesis.ru>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Timofey Titovets <nefelim4ag@gmail.com>

Currently btrfs raid1/10 bаlance requests to mirrors,
based on pid % num of mirrors.

Add logic to consider:
 - If one of devices are non rotational
 - Queue length to devices

By default pid % num_mirrors guessing will be used, but:
 - If one of mirrors are non rotational,
   reroute requests to non rotational
 - If other mirror have less queue length then optimal,
   repick to that mirror

For avoid round-robin request balancing,
lets use abs diff of queue length,
and only if diff greater then threshold try rebalance:
 - threshold 8 for rotational devs
 - threshold 2 for all non rotational devs

Some bench results from mail list
(Dmitrii Tcvetkov <demfloro@demfloro.ru>):
Benchmark summary (arithmetic mean of 3 runs):
         Mainline     Patch
------------------------------------
RAID1  | 18.9 MiB/s | 26.5 MiB/s
RAID10 | 30.7 MiB/s | 30.7 MiB/s
------------------------------------------------------------------------
mainline, fio got lucky to read from first HDD (quite slow HDD):
Jobs: 1 (f=1): [r(1)][100.0%][r=8456KiB/s,w=0KiB/s][r=264,w=0 IOPS]
  read: IOPS=265, BW=8508KiB/s (8712kB/s)(499MiB/60070msec)
  lat (msec): min=2, max=825, avg=60.17, stdev=65.06
------------------------------------------------------------------------
mainline, fio got lucky to read from second HDD (much more modern):
Jobs: 1 (f=1): [r(1)][8.7%][r=11.9MiB/s,w=0KiB/s][r=380,w=0 IOPS]
  read: IOPS=378, BW=11.8MiB/s (12.4MB/s)(710MiB/60051msec)
  lat (usec): min=416, max=644286, avg=42312.74, stdev=48518.56
------------------------------------------------------------------------
mainline, fio got lucky to read from an SSD:
Jobs: 1 (f=1): [r(1)][100.0%][r=436MiB/s,w=0KiB/s][r=13.9k,w=0 IOPS]
  read: IOPS=13.9k, BW=433MiB/s (454MB/s)(25.4GiB/60002msec)
  lat (usec): min=343, max=16319, avg=1152.52, stdev=245.36
------------------------------------------------------------------------
With the patch, 2 HDDs:
Jobs: 1 (f=1): [r(1)][100.0%][r=17.5MiB/s,w=0KiB/s][r=560,w=0 IOPS]
  read: IOPS=560, BW=17.5MiB/s (18.4MB/s)(1053MiB/60052msec)
  lat (usec): min=435, max=341037, avg=28511.64, stdev=30000.14
------------------------------------------------------------------------
With the patch, HDD(old one)+SSD:
Jobs: 1 (f=1): [r(1)][100.0%][r=371MiB/s,w=0KiB/s][r=11.9k,w=0 IOPS]
  read: IOPS=11.6k, BW=361MiB/s (379MB/s)(21.2GiB/60084msec)
  lat  (usec): min=363, max=346752, avg=1381.73, stdev=6948.32

Changes:
  v1 -> v2:
    - Use helper part_in_flight() from genhd.c
      to get queue length
    - Move guess code to guess_optimal()
    - Change balancer logic, try use pid % mirror by default
      Make balancing on spinning rust if one of underline devices
      are overloaded
  v2 -> v3:
    - Fix arg for RAID10 - use sub_stripes, instead of num_stripes
  v3 -> v4:
    - Rebase on latest misc-next
  v4 -> v5:
    - Rebase on latest misc-next
  v5 -> v6:
    - Fix spelling
    - Include bench results
  v6 -> v7:
    - Fixes based on Nikolay Borisov review:
      * Assume num == 2
      * Remove "for" loop based on that assumption, where possible
  v7 -> v8:
    - Add comment about magic '2' num in guess function
  v8 -> v9:
    - Rebase on latest misc-next
    - Simplify code
    - Use abs instead of round_down for approximation
      Abs are more fair

Signed-off-by: Timofey Titovets <nefelim4ag@gmail.com>
Tested-by: Dmitrii Tcvetkov <demfloro@demfloro.ru>
---
 block/genhd.c      |  1 +
 fs/btrfs/volumes.c | 88 +++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 88 insertions(+), 1 deletion(-)

diff --git a/block/genhd.c b/block/genhd.c
index 703267865f14..fb35c85a7f42 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -84,6 +84,7 @@ unsigned int part_in_flight(struct request_queue *q, struct hd_struct *part)
 
 	return inflight;
 }
+EXPORT_SYMBOL_GPL(part_in_flight);
 
 void part_in_flight_rw(struct request_queue *q, struct hd_struct *part,
 		       unsigned int inflight[2])
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 1c2a6e4b39da..8671c2bdced6 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -13,6 +13,7 @@
 #include <linux/raid/pq.h>
 #include <linux/semaphore.h>
 #include <linux/uuid.h>
+#include <linux/genhd.h>
 #include <linux/list_sort.h>
 #include "ctree.h"
 #include "extent_map.h"
@@ -29,6 +30,8 @@
 #include "sysfs.h"
 #include "tree-checker.h"
 
+#define BTRFS_RAID_1_10_MAX_MIRRORS 2
+
 const struct btrfs_raid_attr btrfs_raid_array[BTRFS_NR_RAID_TYPES] = {
 	[BTRFS_RAID_RAID10] = {
 		.sub_stripes	= 2,
@@ -5482,6 +5485,88 @@ int btrfs_is_parity_mirror(struct btrfs_fs_info *fs_info, u64 logical, u64 len)
 	return ret;
 }
 
+/**
+ * bdev_get_queue_len - return rounded down in flight queue length of bdev
+ *
+ * @bdev: target bdev
+ */
+static uint32_t bdev_get_queue_len(struct block_device *bdev)
+{
+	struct hd_struct *bd_part = bdev->bd_part;
+	struct request_queue *rq = bdev_get_queue(bdev);
+
+	return part_in_flight(rq, bd_part);
+}
+
+/**
+ * guess_optimal - return guessed optimal mirror
+ *
+ * Optimal expected to be pid % num_stripes
+ *
+ * That's generally fine for spread load
+ * That are balancer based on queue length to device
+ *
+ * Basic ideas:
+ *  - Sequential read generate low amount of request
+ *    so if load of drives are equal, use pid % num_stripes balancing
+ *  - For mixed rotate/non-rotate mirrors, pick non-rotate as optimal
+ *    and repick if other dev have "significant" less queue length
+ *  - Repick optimal if queue length of other mirror are significantly less
+ */
+static int guess_optimal(struct map_lookup *map, int num, int optimal)
+{
+	int i;
+	/*
+	 * Spinning rust not like random request
+	 * Because of that rebalance are less aggressive
+	 */
+	uint32_t rq_len_overload = 8;
+	uint32_t qlen[2];
+	bool is_nonrot[2];
+	struct block_device *bdev;
+
+	/* That function supposed to work with up to 2 mirrors */
+	ASSERT(BTRFS_RAID_1_10_MAX_MIRRORS == 2);
+	ASSERT(BTRFS_RAID_1_10_MAX_MIRRORS == num);
+
+	/* Check accessible bdevs */
+	for (i = 0; i < 2; i++) {
+		bdev = map->stripes[i].dev->bdev;
+		/*
+		 * Don't bother with further computation
+		 * if only one of two bdevs are accessible
+		 */
+		if (!bdev)
+			return (i + 1) % 2;
+
+		qlen[i] = bdev_get_queue_len(bdev);
+		is_nonrot[i] = blk_queue_nonrot(bdev_get_queue(bdev));
+	}
+
+	/* For mixed case, pick non rotational dev as optimal */
+	if (is_nonrot[0] != is_nonrot[1]) {
+		if (is_nonrot[0])
+			optimal = 0;
+		else
+			optimal = 1;
+	} else {
+		/* For nonrot devices balancing can be aggressive */
+		if (is_nonrot[0])
+			rq_len_overload = 2;
+	}
+
+	/* Devices load at same level */
+	if (abs(qlen[0] - qlen[1]) <= rq_len_overload)
+		return optimal;
+
+	if (qlen[0] > qlen[1])
+		optimal = 1;
+	else
+		optimal = 0;
+
+	return optimal;
+}
+
 static int find_live_mirror(struct btrfs_fs_info *fs_info,
 			    struct map_lookup *map, int first,
 			    int dev_replace_is_ongoing)
@@ -5500,7 +5585,8 @@ static int find_live_mirror(struct btrfs_fs_info *fs_info,
 	else
 		num_stripes = map->num_stripes;
 
-	preferred_mirror = first + current->pid % num_stripes;
+	preferred_mirror = first + guess_optimal(map, num_stripes,
+						 current->pid % num_stripes);
 
 	if (dev_replace_is_ongoing &&
 	    fs_info->dev_replace.cont_reading_from_srcdev_mode ==
-- 
2.21.0
