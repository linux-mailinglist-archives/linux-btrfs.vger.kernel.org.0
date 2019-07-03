Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA765E40A
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jul 2019 14:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfGCMdC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Jul 2019 08:33:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:57778 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725847AbfGCMdB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 3 Jul 2019 08:33:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BBBABAC94;
        Wed,  3 Jul 2019 12:33:00 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs: Refactor btrfs_calc_avail_data_space
Date:   Wed,  3 Jul 2019 15:32:59 +0300
Message-Id: <20190703123259.22489-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Simplify the code by removing variables that don't bring any real value
as well as simplifying the checks when buidling the candidate list of
devices. No functional changes.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/super.c | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 78de9d5d80c6..c4bb3977bd8e 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1899,11 +1899,10 @@ static inline int btrfs_calc_avail_data_space(struct btrfs_fs_info *fs_info,
 	struct btrfs_device_info *devices_info;
 	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
 	struct btrfs_device *device;
-	u64 skip_space;
 	u64 type;
 	u64 avail_space;
 	u64 min_stripe_size;
-	int min_stripes, num_stripes = 1;
+	int num_stripes = 1;
 	int i = 0, nr_devices;
 	const struct btrfs_raid_attr *rattr;
 
@@ -1930,7 +1929,6 @@ static inline int btrfs_calc_avail_data_space(struct btrfs_fs_info *fs_info,
 	/* calc min stripe number for data space allocation */
 	type = btrfs_data_alloc_profile(fs_info);
 	rattr = &btrfs_raid_array[btrfs_bg_flags_to_raid_index(type)];
-	min_stripes = rattr->devs_min;
 
 	if (type & BTRFS_BLOCK_GROUP_RAID0)
 		num_stripes = nr_devices;
@@ -1956,28 +1954,21 @@ static inline int btrfs_calc_avail_data_space(struct btrfs_fs_info *fs_info,
 		avail_space = device->total_bytes - device->bytes_used;
 
 		/* align with stripe_len */
-		avail_space = div_u64(avail_space, BTRFS_STRIPE_LEN);
-		avail_space *= BTRFS_STRIPE_LEN;
+		avail_space = rounddown(avail_space, BTRFS_STRIPE_LEN);
 
 		/*
 		 * In order to avoid overwriting the superblock on the drive,
 		 * btrfs starts at an offset of at least 1MB when doing chunk
 		 * allocation.
+		 *
+		 * This ensures we have at least min_stripe_size free space
+		 * after excluding 1mb.
 		 */
-		skip_space = SZ_1M;
-
-		/*
-		 * we can use the free space in [0, skip_space - 1], subtract
-		 * it from the total.
-		 */
-		if (avail_space && avail_space >= skip_space)
-			avail_space -= skip_space;
-		else
-			avail_space = 0;
-
-		if (avail_space < min_stripe_size)
+		if (avail_space <= SZ_1M + min_stripe_size)
 			continue;
 
+		avail_space -= SZ_1M;
+
 		devices_info[i].dev = device;
 		devices_info[i].max_avail = avail_space;
 
@@ -1991,9 +1982,8 @@ static inline int btrfs_calc_avail_data_space(struct btrfs_fs_info *fs_info,
 
 	i = nr_devices - 1;
 	avail_space = 0;
-	while (nr_devices >= min_stripes) {
-		if (num_stripes > nr_devices)
-			num_stripes = nr_devices;
+	while (nr_devices >= rattr->devs_min) {
+		num_stripes = min(num_stripes, nr_devices);
 
 		if (devices_info[i].max_avail >= min_stripe_size) {
 			int j;
-- 
2.17.1

