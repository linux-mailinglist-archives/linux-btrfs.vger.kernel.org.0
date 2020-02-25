Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A79F16B855
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2020 04:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728997AbgBYD5Y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Feb 2020 22:57:24 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:34241 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728988AbgBYD5W (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Feb 2020 22:57:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582603042; x=1614139042;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D/o4C3jAvJlpnMDRfZCjJPHU27WatnH5haOBXeabW0s=;
  b=VtXvjIwsHxPczzpSOne34AWAbl6cQk9eJ1tOEHoSABRQtlR5zKKzGTgJ
   rdBtGYEiNvtGxyPHqhsfoqHe2zxEOCihfTt0qruldTVPLASBcTU3zbq5x
   QcjVqjFtKtMuDj8hveKVJfVyAxgbh+YFTl1kvp3QcUIPp+DZ/DSblykHB
   asT+OFdW2WPahxSKfzzTjV5XbFXw+8ECEfgF+3BAm29LxkphDzqfcWclH
   aSHLW329jkbBqdtra3Gt1tUWX7n7zOLkYsEndHhIiD4fZ7K6bT6uXQY9C
   t3OugJA+lVb9/gLWTKrb7wWpash1RB8GsozMWMFqhtOkZTHuJ34rZN3py
   g==;
IronPort-SDR: /f1drOPCf0gh+1eCfHK2pYk21die39adGsIo/qVQz/dRbPUGSx32MGAsongHT+C1MI5KwTBjgl
 OqxYaKUbhMxCPZAE19fmpl6GtaXqm96IatOH2MPX2puVooywDGjEZ404wk/tIZyB5WHZ1qloaq
 IoYQcUgUXU74/XDpIxOMmYrLai2JfZcdLMvanI6jmxyA50hrlnOQvwNnw3lpKwg7j4IDc2qNPy
 5X5wvFZKvIOOig9q+mXXOPZC21RfY21j47hZpaHsLBd4+CL5nTe6ZpaSJXVfHl1jSlmjQdjczw
 OB8=
X-IronPort-AV: E=Sophos;i="5.70,482,1574092800"; 
   d="scan'208";a="131168315"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2020 11:57:22 +0800
IronPort-SDR: C5vn9e8GFqmuKJF4x7o0E/JLtvhcZ/Uax4yoXf1AGASmQRSufS0T1azmDYoZwMVr+VduzDBtw3
 tVNTn57x/pmK0V3cnoGZozHG4Zu88Fa7KhzwsDJQwJK4yZjXVNgaK+C3j/wgw35RQCcWNAT1xr
 mwmxXEqK7DNO37yfTwndaBwzI92McT/zJ7LaSsBzBYtedZgyzQ/UlpX+TinoFXwsXQydSM+t5a
 ms20LpZ2qaRUrEDO6bCRNCgcSzl+8wScmLeQKbIelpN6PzqzqhBaMqPtH3pBntWrBnAWxk65mR
 CuJt69nhy/KxJundFyTxoI9C
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2020 19:49:50 -0800
IronPort-SDR: AvEXL6ulo6szn/RhkHuGEOyeZuzdJGy8h7iHHGWdvZES1O+t0FgD00K3kWGGVwEQZeDGnMnCKR
 vfM/EGzp//Xm5IxkIoKmsVp1DaVZ0TqBoDJv996DTbdg30NeaRkTLNbRHcTWJYvgLaC8ze+x6t
 2pfjSJZB7Qik0ojdY7S5FDRDXks/T0Zao3q/Eme9U0bISAxoxyuFtT6Q7v0T2lKAqjoCPhouLR
 LYYXgu3rK0D7PY+08k8cKMynRBvtYbY4jAed7PCTCrevinVJHLeNNbI7mrVtAkf5ElRjvS9KwA
 rpc=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Feb 2020 19:57:22 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 21/21] btrfs: factor out prepare_allocation()
Date:   Tue, 25 Feb 2020 12:56:26 +0900
Message-Id: <20200225035626.1049501-22-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200225035626.1049501-1-naohiro.aota@wdc.com>
References: <20200225035626.1049501-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This function finally factor out prepare_allocation() form
find_free_extent(). This function is called before the allocation loop and
a specific allocator function like prepare_allocation_clustered() should
initialize their private information and can set proper hint_byte to
indicate where to start the allocation with.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 110 +++++++++++++++++++++++++----------------
 1 file changed, 68 insertions(+), 42 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 055097bff12b..1340485b392b 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3866,6 +3866,71 @@ static int find_free_extent_update_loop(struct btrfs_fs_info *fs_info,
 	return -ENOSPC;
 }
 
+static int prepare_allocation_clustered(struct btrfs_fs_info *fs_info,
+					struct find_free_extent_ctl *ffe_ctl,
+					struct btrfs_space_info *space_info,
+					struct btrfs_key *ins)
+{
+	/*
+	 * If our free space is heavily fragmented we may not be able to make
+	 * big contiguous allocations, so instead of doing the expensive search
+	 * for free space, simply return ENOSPC with our max_extent_size so we
+	 * can go ahead and search for a more manageable chunk.
+	 *
+	 * If our max_extent_size is large enough for our allocation simply
+	 * disable clustering since we will likely not be able to find enough
+	 * space to create a cluster and induce latency trying.
+	 */
+	if (unlikely(space_info->max_extent_size)) {
+		spin_lock(&space_info->lock);
+		if (space_info->max_extent_size &&
+		    ffe_ctl->num_bytes > space_info->max_extent_size) {
+			ins->offset = space_info->max_extent_size;
+			spin_unlock(&space_info->lock);
+			return -ENOSPC;
+		} else if (space_info->max_extent_size) {
+			ffe_ctl->use_cluster = false;
+		}
+		spin_unlock(&space_info->lock);
+	}
+
+	ffe_ctl->last_ptr = fetch_cluster_info(fs_info, space_info,
+					       &ffe_ctl->empty_cluster);
+	if (ffe_ctl->last_ptr) {
+		struct btrfs_free_cluster *last_ptr = ffe_ctl->last_ptr;
+
+		spin_lock(&last_ptr->lock);
+		if (last_ptr->block_group)
+			ffe_ctl->hint_byte = last_ptr->window_start;
+		if (last_ptr->fragmented) {
+			/*
+			 * We still set window_start so we can keep track of the
+			 * last place we found an allocation to try and save
+			 * some time.
+			 */
+			ffe_ctl->hint_byte = last_ptr->window_start;
+			ffe_ctl->use_cluster = false;
+		}
+		spin_unlock(&last_ptr->lock);
+	}
+
+	return 0;
+}
+
+static int prepare_allocation(struct btrfs_fs_info *fs_info,
+			      struct find_free_extent_ctl *ffe_ctl,
+			      struct btrfs_space_info *space_info,
+			      struct btrfs_key *ins)
+{
+	switch (ffe_ctl->policy) {
+	case BTRFS_EXTENT_ALLOC_CLUSTERED:
+		return prepare_allocation_clustered(fs_info, ffe_ctl,
+						    space_info, ins);
+	default:
+		BUG();
+	}
+}
+
 /*
  * walks the btree of allocated extents and find a hole of a given size.
  * The key ins is changed to record the hole:
@@ -3935,48 +4000,9 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
 		return -ENOSPC;
 	}
 
-	/*
-	 * If our free space is heavily fragmented we may not be able to make
-	 * big contiguous allocations, so instead of doing the expensive search
-	 * for free space, simply return ENOSPC with our max_extent_size so we
-	 * can go ahead and search for a more manageable chunk.
-	 *
-	 * If our max_extent_size is large enough for our allocation simply
-	 * disable clustering since we will likely not be able to find enough
-	 * space to create a cluster and induce latency trying.
-	 */
-	if (unlikely(space_info->max_extent_size)) {
-		spin_lock(&space_info->lock);
-		if (space_info->max_extent_size &&
-		    num_bytes > space_info->max_extent_size) {
-			ins->offset = space_info->max_extent_size;
-			spin_unlock(&space_info->lock);
-			return -ENOSPC;
-		} else if (space_info->max_extent_size) {
-			ffe_ctl.use_cluster = false;
-		}
-		spin_unlock(&space_info->lock);
-	}
-
-	ffe_ctl.last_ptr = fetch_cluster_info(fs_info, space_info,
-					      &ffe_ctl.empty_cluster);
-	if (ffe_ctl.last_ptr) {
-		struct btrfs_free_cluster *last_ptr = ffe_ctl.last_ptr;
-
-		spin_lock(&last_ptr->lock);
-		if (last_ptr->block_group)
-			ffe_ctl.hint_byte = last_ptr->window_start;
-		if (last_ptr->fragmented) {
-			/*
-			 * We still set window_start so we can keep track of the
-			 * last place we found an allocation to try and save
-			 * some time.
-			 */
-			ffe_ctl.hint_byte = last_ptr->window_start;
-			ffe_ctl.use_cluster = false;
-		}
-		spin_unlock(&last_ptr->lock);
-	}
+	ret = prepare_allocation(fs_info, &ffe_ctl, space_info, ins);
+	if (ret < 0)
+		return ret;
 
 	ffe_ctl.search_start = max(ffe_ctl.search_start,
 				   first_logical_byte(fs_info, 0));
-- 
2.25.1

