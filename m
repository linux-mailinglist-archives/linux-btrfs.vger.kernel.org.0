Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEF8416B841
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2020 04:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbgBYD45 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Feb 2020 22:56:57 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:34216 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728869AbgBYD44 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Feb 2020 22:56:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582603016; x=1614139016;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tNwvHai4fsiAk8JlvX2+ZibtWTJAuRpY2joJ7KuILW4=;
  b=Vs/b5fqOOMi3rp85JAM1xtlkBZozqsSDNoXFVcbogE1HQNsrqHpU/4eS
   zxMfLfbIXYMrbzPJ/ElbEZdVOsbyAhH4N3smWeqhwwEEOJo/86Z9JByPM
   egsNTh0MGsYYZkk9GSGsoHXVTQSxJ1aaXv7or/+4ZAqlhhibmfXEMp1rj
   1QEuVREzDEddCUhOy0uG/K+bSvPKwBbVSfg84wB4nBe3OYSxvBWy9HbN6
   +l1f9NS/TDltONPG57n0P6JjJwjn+IxkUfSG/cob+E8aWL8EW5yWd7kTF
   mH9L2hSBHpXhPvFd/mVyEpbV5Q6/Yy9pF/G2hu9MJhm7Kl35tEu8zKAJ8
   g==;
IronPort-SDR: Kpr64vxqqZxbgM8hZrDhvpDEpcEHy9yulp8P+EMfOiWpR6F6+oRZR2qEq96lNclULsOHbgaC5j
 zsIkfHUBOoopj1e5NYn/UzgbaU89geG32L9lRMMbVBwWG2bNAMgYz98e7WbFyPfbF/Nq/tKrun
 vRWCkdwc5FWoA6DLrzRooQ6u6yGqrMep9nkDS75WJ12FHu3S3/O12FCjvcPcU5o1Y/xeo6pbKo
 qL/reD1nJ4jYDctJcCCN85gyR+gxG8URGE7M5rSd/Uk8dOCQ4/y7Y28xlp/PK58vTtOxx0SCCe
 o6A=
X-IronPort-AV: E=Sophos;i="5.70,482,1574092800"; 
   d="scan'208";a="131168259"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2020 11:56:56 +0800
IronPort-SDR: F41V5dl82bm+oeGSh6KNdNTaRIOKcuINR7zy/2LJpIca690+DYWay09T6RA8+g5ruRMoYskcgh
 30BfKokjetPqBOmEkcnAbsB1EK3qvVIo9IryKW86QZP9pPycLnwaNcKb7tD1YdFBfRaDLjLNXU
 C1GJ1xr+wjlksozMmYdTG7FBy0gLTXsbGUcQ8VFwR88KZRFMc9vQqNTad9Veqi3i+///YCk7YL
 ByQCs6dH/2FzhLV7hPQ8bMk65PM7BlhiriTJAh9/Et2I6UjCl12NkJu1XYBqjH0wRaaKr9UMav
 5eR9MwE4tUXzFOAqcMRdHegF
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2020 19:49:24 -0800
IronPort-SDR: XZxoQOoFcLIc3CRw4SpqoBsRdof1+2QP8uG1Evt5LY3knLxfKUWItEM8wN7yOQp6zsWRrRccKW
 lNuYZDGkbevCYSkfNvIjtnTD27m+C6EE3V9oD+2aE4qsUt+BTXjm+GYcdIXjNXkeArDhWSKBXh
 h0GwiEfVWxH3EyLwzdEz8hPm7hBtKR/Q4vmK/ukaZktGAVmcLlj5IOHTH4PCyMxJwirmNG3/zB
 sjmqc7uisTBonUGprfDQ/O+Lu8mSnI5CIg8hZKvzAljx9HJLbhknYYRFH8Ud7hRortSbqd/GuQ
 N4w=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Feb 2020 19:56:56 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 01/21] btrfs: change type of full_search to bool
Date:   Tue, 25 Feb 2020 12:56:06 +0900
Message-Id: <20200225035626.1049501-2-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200225035626.1049501-1-naohiro.aota@wdc.com>
References: <20200225035626.1049501-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

While the "full_search" variable defined in find_free_extent() is bool, but
the full_search argument of find_free_extent_update_loop() is defined as
int. Let's trivially fix the argument type.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index a7bc66121330..ed646a13956d 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3672,7 +3672,7 @@ static int find_free_extent_update_loop(struct btrfs_fs_info *fs_info,
 					struct btrfs_free_cluster *last_ptr,
 					struct btrfs_key *ins,
 					struct find_free_extent_ctl *ffe_ctl,
-					int full_search, bool use_cluster)
+					bool full_search, bool use_cluster)
 {
 	struct btrfs_root *root = fs_info->extent_root;
 	int ret;
-- 
2.25.1

