Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A23016B847
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2020 04:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbgBYD5M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Feb 2020 22:57:12 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:34216 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728866AbgBYD5M (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Feb 2020 22:57:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582603031; x=1614139031;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PRhYCqlHGa1Ffrr0vuTgOoIhkWEOWH9/AqOyghGgX5w=;
  b=EQaIsfhbDtzdrbaxmms7dLDsBdlgo6aZMMg/16+QWXfP7Wh/HTKZH9Zm
   46lmKkf6f+NGqhuMhNcm15LjpxtH+M1/XFv+P/MwvqjAiq83FSWGco/Z1
   dARz/XUEVPuuxPz2cthaQBJyH0ljRkkc62ew7uXtMKkxtPBcW4NpyMpPp
   sgqg0kj2zFE3l/1TBb5ic6dQiRg0NBKZrjZYbG3WW4W3CP6FwqQ/xIcmH
   Dn+1fKT7XPi0lp5FEfLuBh22SaeTGPKy9DMSgt3zyY0K6YhQMW/0E9fkP
   Uu0M0bvyPOOw08mc+F9/RAd3At1H0p6HgWsR6+Q4LB9gXuyeRhfXtX0co
   g==;
IronPort-SDR: 1PqLTxwRFgMN/ky2xKdK34coMWwCGS0Qv3w/QUFamsQSzFaYQmNyOoYuZ9QrcMGpRaC7GX1kwJ
 BzUfIBAAtZfvbEZ7HAgnOI9w1rD+WSEmkgaZOh3mS1Rp0fPEJldGHstxjRrRdO/YR8+MAz3Krb
 BKbR+myhh29/zQ5QqoXk1NyNACzg4npJMj5oWd89YFS0R6ojbPz179Uu/8zpLfBsLUK/TbF8Gu
 rsTvtQ4oZ5of+2LBJ2KCv9Ibw9gP+zgGIgXiIzOqnPxIGE1+LKPCeDTONgrrV1iRwuIkZYyZr1
 7kw=
X-IronPort-AV: E=Sophos;i="5.70,482,1574092800"; 
   d="scan'208";a="131168281"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2020 11:57:03 +0800
IronPort-SDR: Zmow8N0wJC2Hb9HwSYxembgmCr0iBT0N4W1iZAjAzm3eGoOdH1h+K2uyAFF3C9FBumRRN13ZAo
 OiGwEJIrER0EEJJZOxOX2RfhZKOIAdaXUx/m0LS1wEicGqVfFjTKmq8r/ZUpPYLkFnBmFFagH1
 IwHtTyskD0XCc31YevZTyPOMDOlKxRugpjs9gOfVoFs0lXP15g+XDEnGpsSoP0OhLpc/FH6hgX
 glOXJtWL4OtzErVcyvMKDcWPt5a5mEDJ+cjrutuygUILwRLhHBtLKHPbOIBWf/djT0289RyEaQ
 cyKgJnppmxJsCVG1dPPS6dWA
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2020 19:49:31 -0800
IronPort-SDR: UqPuoLznLTU6UIAcY3Kg9wTz25xAnNO2+UnfXTT+Q3dmJzKfBiAujhnIFUHwWfjgVgdV0tOTV7
 0Et6yBy5CbaqMss5m79+8oXnhQPxrVH4PUnKSKzC5mua2dIvPz/HXr1yaMw88QTrJFMUuKB+rB
 edpH44rYG6YiNh1yoqtQQ1tZUdDzvVCyqXFdt8Dg/C1qCeLPVKtDJ2QZqZG9kNOhcEdqCbRYDs
 CpuNFlQTyXmUKzbVPsmUNGm7wL/4+g2ltmUA4mpwjrlKUXvaYi5LWdB+fl7EWY2XHrvM2vx8XC
 aRU=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Feb 2020 19:57:02 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 06/21] btrfs: factor out init_alloc_chunk_ctl
Date:   Tue, 25 Feb 2020 12:56:11 +0900
Message-Id: <20200225035626.1049501-7-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200225035626.1049501-1-naohiro.aota@wdc.com>
References: <20200225035626.1049501-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Factor out init_alloc_chunk_ctl() from __btrfs_alloc_chunk(). This function
initialises parameters of "struct alloc_chunk_ctl" for allocation.
init_alloc_chunk_ctl() handles a common part of the initialisation to load
the RAID parameters from btrfs_raid_array.
init_alloc_chunk_ctl_policy_regular() decides some parameters for its
allocation.

The last "else" case in the original code is moved to __btrfs_alloc_chunk()
to handle the error case in the common code. Replace the BUG_ON with
ASSERT() and error return at the same time.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/volumes.c | 100 ++++++++++++++++++++++++++++-----------------
 1 file changed, 62 insertions(+), 38 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index ed90e9d2bd9b..b15c2bb6f913 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4841,6 +4841,61 @@ struct alloc_chunk_ctl {
 	int ndevs;
 };
 
+static void
+init_alloc_chunk_ctl_policy_regular(struct btrfs_fs_devices *fs_devices,
+				    struct alloc_chunk_ctl *ctl)
+{
+	u64 type = ctl->type;
+
+	if (type & BTRFS_BLOCK_GROUP_DATA) {
+		ctl->max_stripe_size = SZ_1G;
+		ctl->max_chunk_size = BTRFS_MAX_DATA_CHUNK_SIZE;
+	} else if (type & BTRFS_BLOCK_GROUP_METADATA) {
+		/* for larger filesystems, use larger metadata chunks */
+		if (fs_devices->total_rw_bytes > 50ULL * SZ_1G)
+			ctl->max_stripe_size = SZ_1G;
+		else
+			ctl->max_stripe_size = SZ_256M;
+		ctl->max_chunk_size = ctl->max_stripe_size;
+	} else if (type & BTRFS_BLOCK_GROUP_SYSTEM) {
+		ctl->max_stripe_size = SZ_32M;
+		ctl->max_chunk_size = 2 * ctl->max_stripe_size;
+		ctl->devs_max = min_t(int, ctl->devs_max,
+				      BTRFS_MAX_DEVS_SYS_CHUNK);
+	} else {
+		BUG();
+	}
+
+	/* We don't want a chunk larger than 10% of writable space */
+	ctl->max_chunk_size = min(div_factor(fs_devices->total_rw_bytes, 1),
+				  ctl->max_chunk_size);
+}
+
+static void init_alloc_chunk_ctl(struct btrfs_fs_devices *fs_devices,
+				 struct alloc_chunk_ctl *ctl)
+{
+	int index = btrfs_bg_flags_to_raid_index(ctl->type);
+
+	ctl->sub_stripes = btrfs_raid_array[index].sub_stripes;
+	ctl->dev_stripes = btrfs_raid_array[index].dev_stripes;
+	ctl->devs_max = btrfs_raid_array[index].devs_max;
+	if (!ctl->devs_max)
+		ctl->devs_max = BTRFS_MAX_DEVS(fs_devices->fs_info);
+	ctl->devs_min = btrfs_raid_array[index].devs_min;
+	ctl->devs_increment = btrfs_raid_array[index].devs_increment;
+	ctl->ncopies = btrfs_raid_array[index].ncopies;
+	ctl->nparity = btrfs_raid_array[index].nparity;
+	ctl->ndevs = 0;
+
+	switch (fs_devices->chunk_alloc_policy) {
+	case BTRFS_CHUNK_ALLOC_REGULAR:
+		init_alloc_chunk_ctl_policy_regular(fs_devices, ctl);
+		break;
+	default:
+		BUG();
+	}
+}
+
 static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 			       u64 start, u64 type)
 {
@@ -4859,7 +4914,6 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	int ndevs;
 	int i;
 	int j;
-	int index;
 
 	if (!alloc_profile_is_valid(type, 0)) {
 		ASSERT(0);
@@ -4872,45 +4926,15 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 		return -ENOSPC;
 	}
 
-	ctl.start = start;
-	ctl.type = type;
-
-	index = btrfs_bg_flags_to_raid_index(type);
-
-	ctl.sub_stripes = btrfs_raid_array[index].sub_stripes;
-	ctl.dev_stripes = btrfs_raid_array[index].dev_stripes;
-	ctl.devs_max = btrfs_raid_array[index].devs_max;
-	if (!ctl.devs_max)
-		ctl.devs_max = BTRFS_MAX_DEVS(info);
-	ctl.devs_min = btrfs_raid_array[index].devs_min;
-	ctl.devs_increment = btrfs_raid_array[index].devs_increment;
-	ctl.ncopies = btrfs_raid_array[index].ncopies;
-	ctl.nparity = btrfs_raid_array[index].nparity;
-
-	if (type & BTRFS_BLOCK_GROUP_DATA) {
-		ctl.max_stripe_size = SZ_1G;
-		ctl.max_chunk_size = BTRFS_MAX_DATA_CHUNK_SIZE;
-	} else if (type & BTRFS_BLOCK_GROUP_METADATA) {
-		/* for larger filesystems, use larger metadata chunks */
-		if (fs_devices->total_rw_bytes > 50ULL * SZ_1G)
-			ctl.max_stripe_size = SZ_1G;
-		else
-			ctl.max_stripe_size = SZ_256M;
-		ctl.max_chunk_size = ctl.max_stripe_size;
-	} else if (type & BTRFS_BLOCK_GROUP_SYSTEM) {
-		ctl.max_stripe_size = SZ_32M;
-		ctl.max_chunk_size = 2 * ctl.max_stripe_size;
-		ctl.devs_max = min_t(int, ctl.devs_max,
-				      BTRFS_MAX_DEVS_SYS_CHUNK);
-	} else {
-		btrfs_err(info, "invalid chunk type 0x%llx requested",
-		       type);
-		BUG();
+	if (!(type & BTRFS_BLOCK_GROUP_TYPE_MASK)) {
+		btrfs_err(info, "invalid chunk type 0x%llx requested", type);
+		ASSERT(0);
+		return -EINVAL;
 	}
 
-	/* We don't want a chunk larger than 10% of writable space */
-	ctl.max_chunk_size = min(div_factor(fs_devices->total_rw_bytes, 1),
-				  ctl.max_chunk_size);
+	ctl.start = start;
+	ctl.type = type;
+	init_alloc_chunk_ctl(fs_devices, &ctl);
 
 	devices_info = kcalloc(fs_devices->rw_devices, sizeof(*devices_info),
 			       GFP_NOFS);
-- 
2.25.1

