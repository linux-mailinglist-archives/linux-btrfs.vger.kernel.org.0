Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07FE916B856
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2020 04:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728999AbgBYD51 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Feb 2020 22:57:27 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:34231 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728958AbgBYD5M (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Feb 2020 22:57:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582603032; x=1614139032;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3UNk3JARnboYJecuheSmhGM6q4Yh6IyVDpJ+YcGbGUI=;
  b=l1d1dkz5I4WnBO0t9eI/b84Edx/HI3dd6Pnm2hHI1qGU5LUPK123+YU3
   EdXXtTix9+s9eELYCr+fCWOg/7ZZYSThGVCrSJsmQGsesYIhooeFEl9xx
   bG2phz4q3lAUWNKSi5OdVpmcjC4uBBgtEuuU6uAcA9ZUtbFzFSvLn3dff
   oivnxYii5tQ8D5IPbXPAvBLixfHVkag7JFNKJ2G1AakXYmGswJIxrxs3R
   Bo187Dn5p/4WdHysV9+NCMbx4EvgjfTF+f4gbqI9pKB63dgXzX8WuTF10
   n7rpHmOpqx+6HSm3AK+lGtIDCuxjOQ3al9975rF/J2sxJiP0jIImf863O
   g==;
IronPort-SDR: PYFTd090tJzFcdGk7VfMaSUZJjnEIQuunz19QID7m3E+oHM04LDMQLwCfRhaaVK6cRDx/5z2Ym
 2S93VSmKUwwfiHWXVRrZ1qeVvx3mch+tDqIo2wJZZjJjUUypNmJJVvIKEaxyb9ucOMIptuZEta
 aqokuL7ph9nH0TMttqStLFn1A61SjHz9pMeuRppztO3BnFpEVsS7AczhPXxkdfphWBXikPAe+q
 5VmjNJFy2NQJLuU0jC0WW0L+dI6pMxtxFg/rZj3FnkpC9nr+KrKsQAvuHpScVTLq2GfcNLglaY
 fp4=
X-IronPort-AV: E=Sophos;i="5.70,482,1574092800"; 
   d="scan'208";a="131168288"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2020 11:57:08 +0800
IronPort-SDR: RBj2EnjYOAXdxQNjvMbFdnfdLwFHNevM/cKdO53KRC84equo4vCHpAGyg42fDHYpp0SOEm51zL
 nrUs1smZWbKM67+SHsRGS6eTcKuju28WsBsTbiJ915dfqON7/H4VqfrBapclXiqiKogCt+TA/g
 nm0MDu9OSWybSQJT7jMEdForXR4790/sxCmLpQA8nl/XZtXN+kIwCp92Ig4H+WNFs1oUjqswO3
 KktKSuJWl2bU95WWGf6hWxzCAe9a129S9pq48VXA5iPGcLdVhe2VGjMSBZEbrXMZCr4Svx9rGi
 IXdcKYwhkUwSSIsVx1zJ3PVy
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2020 19:49:36 -0800
IronPort-SDR: oD8yRF73XrPO/ns/qdqOV4kELIoeLiQu2KPMJtgOa/DjvnNIoXa8LbwAotZLDwQDfJYGRojVFR
 EZYKFso09x1E3VjBVsSGNm5wtf/3kRM+zKdxfM/lDUFoD5+WCpcUK09m7R2gPcLY2iJ9mxVSu9
 2mDgwCmzEfUWKPpjxmb6YOXjmhPKG86g7HF9KRFxZ26gYaFZlDUWdTkO1DsiGUOCZq3wTuhJsr
 l/UcVgIhIxjkmyr5invsAkef9RM0H/rAibbo9z/LE+hUGrPfuoasfnEirNk+YUzQnLkDH7QAvL
 fTU=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Feb 2020 19:57:07 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 10/21] btrfs: parameterize dev_extent_min
Date:   Tue, 25 Feb 2020 12:56:15 +0900
Message-Id: <20200225035626.1049501-11-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200225035626.1049501-1-naohiro.aota@wdc.com>
References: <20200225035626.1049501-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently, we ignore a device whose available space is less than
"BTRFS_STRIPE_LEN * dev_stripes". This is a lower limit for current
allocation policy (to maximize the number of stripes). This commit
parameterizes dev_extent_min, so that other policies can set their own
lower limitation to ignore a device with an insufficient space.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/volumes.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index cd854d6b8208..c5c64252d1f3 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4836,6 +4836,7 @@ struct alloc_chunk_ctl {
 				   store parity information */
 	u64 max_stripe_size;
 	u64 max_chunk_size;
+	u64 dev_extent_min;
 	u64 stripe_size;
 	u64 chunk_size;
 	int ndevs;
@@ -4869,6 +4870,7 @@ init_alloc_chunk_ctl_policy_regular(struct btrfs_fs_devices *fs_devices,
 	/* We don't want a chunk larger than 10% of writable space */
 	ctl->max_chunk_size = min(div_factor(fs_devices->total_rw_bytes, 1),
 				  ctl->max_chunk_size);
+	ctl->dev_extent_min = BTRFS_STRIPE_LEN * ctl->dev_stripes;
 }
 
 static void init_alloc_chunk_ctl(struct btrfs_fs_devices *fs_devices,
@@ -4904,7 +4906,6 @@ static int gather_device_info(struct btrfs_fs_devices *fs_devices,
 	struct btrfs_device *device;
 	u64 total_avail;
 	u64 dev_extent_want = ctl->max_stripe_size * ctl->dev_stripes;
-	u64 dev_extent_min = BTRFS_STRIPE_LEN * ctl->dev_stripes;
 	int ret;
 	int ndevs = 0;
 	u64 max_avail;
@@ -4932,7 +4933,7 @@ static int gather_device_info(struct btrfs_fs_devices *fs_devices,
 			total_avail = 0;
 
 		/* If there is no space on this device, skip it. */
-		if (total_avail == 0)
+		if (total_avail < ctl->dev_extent_min)
 			continue;
 
 		ret = find_free_dev_extent(device, dev_extent_want, &dev_offset,
@@ -4943,12 +4944,12 @@ static int gather_device_info(struct btrfs_fs_devices *fs_devices,
 		if (ret == 0)
 			max_avail = dev_extent_want;
 
-		if (max_avail < dev_extent_min) {
+		if (max_avail < ctl->dev_extent_min) {
 			if (btrfs_test_opt(info, ENOSPC_DEBUG))
 				btrfs_debug(info,
 			"%s: devid %llu has no free space, have=%llu want=%llu",
 					    __func__, device->devid, max_avail,
-					    dev_extent_min);
+					    ctl->dev_extent_min);
 			continue;
 		}
 
-- 
2.25.1

