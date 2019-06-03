Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED1AB32D82
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jun 2019 12:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbfFCKGG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jun 2019 06:06:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:53976 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726949AbfFCKGG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 3 Jun 2019 06:06:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 33EFCAD89
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jun 2019 10:06:05 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 2/4] btrfs: Always trim all unallocated space in btrfs_trim_free_extents
Date:   Mon,  3 Jun 2019 13:06:00 +0300
Message-Id: <20190603100602.19362-3-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190603100602.19362-1-nborisov@suse.com>
References: <20190603100602.19362-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch removes support for range parameters of FITRIM ioctl when
trimming unallocated space on devices. This is necessary since ranges
passed from user space are generally interpreted as logical addresses,
whereas btrfs_trim_free_extents used to interpret them as device
physical extents. This could result in counter-intuitive behavior for
users so it's best to remove that support altogether.

Additionally, the existing range support had a bug where if an offset
was passed to FITRIM which overflows u64 e.g. -1 (parsed as u64
18446744073709551615) then wrong data was fed into btrfs_issue_discard,
which in turn leads to wrap-around when aligning the passed range and
results in wrong regions being discarded which leads to data corruption.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/extent-tree.c | 28 +++-------------------------
 1 file changed, 3 insertions(+), 25 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 96628eb4b389..d8c5febf7636 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -11145,13 +11145,11 @@ int btrfs_error_unpin_extent_range(struct btrfs_fs_info *fs_info,
  * it while performing the free space search since we have already
  * held back allocations.
  */
-static int btrfs_trim_free_extents(struct btrfs_device *device,
-				   struct fstrim_range *range, u64 *trimmed)
+static int btrfs_trim_free_extents(struct btrfs_device *device, u64 *trimmed)
 {
-	u64 start, len = 0, end = 0;
+	u64 start = SZ_1M, len = 0, end = 0;
 	int ret;
 
-	start = max_t(u64, range->start, SZ_1M);
 	*trimmed = 0;
 
 	/* Discard not supported = nothing to do. */
@@ -11194,22 +11192,6 @@ static int btrfs_trim_free_extents(struct btrfs_device *device,
 			break;
 		}
 
-		/* Keep going until we satisfy minlen or reach end of space */
-		if (len < range->minlen) {
-			mutex_unlock(&fs_info->chunk_mutex);
-			start += len;
-			continue;
-		}
-
-		/* If we are out of the passed range break */
-		if (start > range->start + range->len - 1) {
-			mutex_unlock(&fs_info->chunk_mutex);
-			break;
-		}
-
-		start = max(range->start, start);
-		len = min(range->len, len);
-
 		ret = btrfs_issue_discard(device->bdev, start, len,
 					  &bytes);
 		if (!ret)
@@ -11224,10 +11206,6 @@ static int btrfs_trim_free_extents(struct btrfs_device *device,
 		start += len;
 		*trimmed += bytes;
 
-		/* We've trimmed enough */
-		if (*trimmed >= range->len)
-			break;
-
 		if (fatal_signal_pending(current)) {
 			ret = -ERESTARTSYS;
 			break;
@@ -11311,7 +11289,7 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
 	mutex_lock(&fs_info->fs_devices->device_list_mutex);
 	devices = &fs_info->fs_devices->devices;
 	list_for_each_entry(device, devices, dev_list) {
-		ret = btrfs_trim_free_extents(device, range, &group_trimmed);
+		ret = btrfs_trim_free_extents(device, &group_trimmed);
 		if (ret) {
 			dev_failed++;
 			dev_ret = ret;
-- 
2.17.1

