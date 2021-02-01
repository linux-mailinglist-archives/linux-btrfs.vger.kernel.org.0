Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4624930B217
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Feb 2021 22:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbhBAV3P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Feb 2021 16:29:15 -0500
Received: from smtp-36-i2.italiaonline.it ([213.209.12.36]:48938 "EHLO
        libero.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231426AbhBAV3H (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Feb 2021 16:29:07 -0500
Received: from venice.bhome ([84.220.24.72])
        by smtp-36.iol.local with ESMTPA
        id 6gkAlJHqMi3tS6gkClGsxB; Mon, 01 Feb 2021 22:28:24 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1612214904; bh=ncWAEAMifVXLmJIv4yy/NJKZs8/oXW42ms01fKRoWRM=;
        h=From;
        b=em+nOQ7O2g6D52oFiNM6BgLXz4Sg8H94xK5z6Vr7bzwxD/Zr7khEWR5rUmRKhHTqM
         7r9EHmNBYiZ0hHZ7N46ZFhsX3xDFJv9BbZ6bmJlFcJVJUqGuaT4DOb+QqSrFGib6OA
         p23P0I75v9mBtcIYoUyxa1t1aMopDLrh32ZWwJh8JpqoDX3oE5pBE8JZ7MUywV6xUY
         iUXocsxtZBf+Hxgp7HOkEOEUrdgbRBgqMeBC1Ii1gfdnqFR29Q8Op1/1nFBSfbH8No
         M0IjuicFp3gZHT1QR4D4VVEnaeIXlMVjaEicmsRi0tjiOgX4+RzY8hqWUqA4HnrilB
         QDg4PH2Ru0XNQ==
X-CNFS-Analysis: v=2.4 cv=FqfAQ0nq c=1 sm=1 tr=0 ts=60187278 cx=a_exe
 a=tAq5w2qrEf5dL+VNPEPBHQ==:117 a=tAq5w2qrEf5dL+VNPEPBHQ==:17
 a=5fC9_dISOduuxPbwqfAA:9
From:   Goffredo Baroncelli <kreijack@libero.it>
To:     linux-btrfs@vger.kernel.org
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH 5/5] btrfs: add allocator_hint mode
Date:   Mon,  1 Feb 2021 22:28:20 +0100
Message-Id: <20210201212820.64381-6-kreijack@libero.it>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210201212820.64381-1-kreijack@libero.it>
References: <20210201212820.64381-1-kreijack@libero.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfD1wutszHKIlUZTwtbSYl9z/+e0rnW7j20qXXiecWT5AXhz1p+eoq7tfP/qkU18tBxI9hlc8b8fyHHAUb+UiBU9dxOKncAAE1Ax1BwTnR3D1zRLzikXh
 L+S6DNQY6KDcXRnYcJdQI2Bo7+IlDMykKZ6jEhGNNoB4oqwzsv+2kRnyr7C8B9E5yWP+X8UVILmdPSYpPNTAywRp04BU3U6AM2jF6VqBiFkf/cJZKfjVFhWW
 xPf6g9OdpZsmUnI/+mUGmXNUv30pNEKFUw1sSeRxD2gmi2RDNlpfYcVObDHregTq
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goffredo Baroncelli <kreijack@inwind.it>

When this mode is enabled, the chunk allocation policy is modified as follow.

Each disk may have a different tag:
- BTRFS_DEV_ALLOCATION_PREFERRED_METADATA
- BTRFS_DEV_ALLOCATION_METADATA_ONLY
- BTRFS_DEV_ALLOCATION_DATA_ONLY
- BTRFS_DEV_ALLOCATION_PREFERRED_DATA (default)

Where:
- ALLOCATION_PREFERRED_X means that it is preferred to use this disk for the
X chunk type (the other type may be allowed when the space is low)
- ALLOCATION_X_ONLY means that it is used *only* for the X chunk type. This
means also that it is a preferred choice.

Each time the allocator allocates a chunk of type X , first it takes the disks
tagged as ALLOCATION_X_ONLY or ALLOCATION_PREFERRED_X; if the space is not
enough, it uses also the disks tagged as ALLOCATION_METADATA_ONLY; if the space
is not enough, it uses also the other disks, with the exception of the one
marked as ALLOCATION_PREFERRED_Y, where Y the other type of chunk (i.e. not X).

Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
---
 fs/btrfs/volumes.c | 81 +++++++++++++++++++++++++++++++++++++++++++++-
 fs/btrfs/volumes.h |  1 +
 2 files changed, 81 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 68b346c5465d..57ee3e2fdac0 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4806,13 +4806,18 @@ static int btrfs_add_system_chunk(struct btrfs_fs_info *fs_info,
 }
 
 /*
- * sort the devices in descending order by max_avail, total_avail
+ * sort the devices in descending order by alloc_hint,
+ * max_avail, total_avail
  */
 static int btrfs_cmp_device_info(const void *a, const void *b)
 {
 	const struct btrfs_device_info *di_a = a;
 	const struct btrfs_device_info *di_b = b;
 
+	if (di_a->alloc_hint > di_b->alloc_hint)
+		return -1;
+	if (di_a->alloc_hint < di_b->alloc_hint)
+		return 1;
 	if (di_a->max_avail > di_b->max_avail)
 		return -1;
 	if (di_a->max_avail < di_b->max_avail)
@@ -4939,6 +4944,15 @@ static int gather_device_info(struct btrfs_fs_devices *fs_devices,
 	int ndevs = 0;
 	u64 max_avail;
 	u64 dev_offset;
+	int hint;
+
+	static const char alloc_hint_map[BTRFS_DEV_ALLOCATION_MASK_COUNT] = {
+		[BTRFS_DEV_ALLOCATION_DATA_ONLY] = -1,
+		[BTRFS_DEV_ALLOCATION_PREFERRED_DATA] = 0,
+		[BTRFS_DEV_ALLOCATION_METADATA_ONLY] = 1,
+		[BTRFS_DEV_ALLOCATION_PREFERRED_METADATA] = 2
+		/* the other values are set to 0 */
+	};
 
 	/*
 	 * in the first pass through the devices list, we gather information
@@ -4991,16 +5005,81 @@ static int gather_device_info(struct btrfs_fs_devices *fs_devices,
 		devices_info[ndevs].max_avail = max_avail;
 		devices_info[ndevs].total_avail = total_avail;
 		devices_info[ndevs].dev = device;
+
+		if (((ctl->type & BTRFS_BLOCK_GROUP_DATA) &&
+		     (ctl->type & BTRFS_BLOCK_GROUP_METADATA)) ||
+		    info->allocation_hint_mode == 
+		     BTRFS_ALLOCATION_HINT_DISABLED) {
+			/*
+			 * if mixed bg or the allocator hint is
+			 * disable, set all the alloc_hint
+			 * fields to the same value, so the sorting
+			 * is not affected
+			 */
+			devices_info[ndevs].alloc_hint = 0;
+		} else if(ctl->type & BTRFS_BLOCK_GROUP_DATA) {
+			hint = device->type & BTRFS_DEV_ALLOCATION_MASK;
+
+			/*
+			 * skip BTRFS_DEV_METADATA_ONLY disks
+			 */
+			if (hint == BTRFS_DEV_ALLOCATION_METADATA_ONLY)
+				continue;
+			/*
+			 * if a data chunk must be allocated,
+			 * sort also by hint (data disk
+			 * higher priority)
+			 */
+			devices_info[ndevs].alloc_hint = -alloc_hint_map[hint];
+		} else { /* BTRFS_BLOCK_GROUP_METADATA */
+			hint = device->type & BTRFS_DEV_ALLOCATION_MASK;
+
+			/*
+			 * skip BTRFS_DEV_DATA_ONLY disks
+			 */
+			if (hint == BTRFS_DEV_ALLOCATION_DATA_ONLY)
+				continue;
+			/*
+			 * if a data chunk must be allocated,
+			 * sort also by hint (metadata hint
+			 * higher priority)
+			 */
+			devices_info[ndevs].alloc_hint = alloc_hint_map[hint];
+		}
+
 		++ndevs;
 	}
 	ctl->ndevs = ndevs;
 
+	/*
+	 * no devices available
+	 */
+	if (!ndevs)
+		return 0;
+
 	/*
 	 * now sort the devices by hole size / available space
 	 */
 	sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
 	     btrfs_cmp_device_info, NULL);
 
+	/*
+	 * select the minimum set of disks grouped by hint that
+	 * can host the chunk
+	 */
+	ndevs = 0;
+	while (ndevs < ctl->ndevs) {
+		hint = devices_info[ndevs++].alloc_hint;
+		while (devices_info[ndevs].alloc_hint == hint &&
+		       ndevs < ctl->ndevs)
+				ndevs++;
+		if (ndevs >= ctl->devs_min)
+			break;
+	}
+
+	BUG_ON(ndevs > ctl->ndevs);
+	ctl->ndevs = ndevs;
+
 	return 0;
 }
 
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index d776b7f55d56..31a3e4cf93b5 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -364,6 +364,7 @@ struct btrfs_device_info {
 	u64 dev_offset;
 	u64 max_avail;
 	u64 total_avail;
+	int alloc_hint;
 };
 
 struct btrfs_raid_attr {
-- 
2.30.0

