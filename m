Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 518D236AC30
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Apr 2021 08:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbhDZG3M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Apr 2021 02:29:12 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:41951 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbhDZG3I (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Apr 2021 02:29:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1619418506; x=1650954506;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MuNYcdAPn6VD4bz8GMSau8kyyerND+W88ZSYtOfv7mA=;
  b=DRCR3ZSpBvAi/M58YYg3JLMZqugsQyVF/QVhiXGebUDChqMEiUa0mNbs
   wyG1wU41V1KDeMs1nTy7pn+C4NHSdYYLzd7hZFfwWQTUztNtotUYYvYrz
   mHDRAB/3P1AectacmS2ghsgNl0FGGePbSc+KpENl0w5DHu8uYVZKU9GRX
   +NSrDGixRbPK0my+rTu+PTKQ+ME7ndgWzahtD6QIDnCZnQNv+nnb/n/JK
   7XTdkjgn5FLmsgF6LkHtjr45X3D3y6Trjs10d+HSSmUpWHlbJhI8ZLpxU
   IWhXZAxEpQJPkIKRKZJ7RuaBecMtOomihp033plQ4Bw6UJtLxHWcc8OKY
   A==;
IronPort-SDR: PoU/yM7crHFH0n7pAo18/QAWf/uGYLtsgSQV9FgwXIexkPCNccYgkKN4AUkrt9bs7Al+3K+y/8
 c7VCE7noYIBjEOaQaRvstTIMM+JvJHoARUhsE6djVypzYQr02BGsm4P6/C1fprelEb2F+TCwhF
 lEOaVMIfvqYaGbivgQjd+aJIfKkWoRdYhXBDsLbjM1IItuNLjvGvO6OLrxuRm33D+w4J//abpM
 vKZGQTxzgWcll74fmYZV0fYx0uMITMfSHi6DnSvvbq7nh64UYXQreXBnmcUGpgw81vhnCSepAC
 fJo=
X-IronPort-AV: E=Sophos;i="5.82,251,1613404800"; 
   d="scan'208";a="170788131"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Apr 2021 14:28:26 +0800
IronPort-SDR: jpVDtJk9d9uEj4DYlxI9JFzRFF8TiTYGhrOnzytPpQPEiYrKKPC/j1raOUiaDwuHLZ5woqh3qX
 DUjLk1k9s8Hh26AtbgydZuxZm4augLAy5buQsS0oLinOnDA3kuMMt5GOIhx4u/zTjkxS8UjChn
 0FhUQNQ4Ot6SEDCupEfeHTL5BOSOZcoyVIICzvQcTZBjyE0n8OX7zhXcRZ9AlzniV1cvtgCDFH
 2irFZXRUXN4ACKfM7rfr6eHODfVZnVjrQASVmJfjm6Hs2En4/ryB1kAPYV2wQSAdeLjMGakC6q
 Qox04rUVx/3Pf8Tf3+CXmknr
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2021 23:08:50 -0700
IronPort-SDR: gvqVbTpjYDqTq3un4Juue8/gigouwYRKTS9jgt/gId/tA5nMOWf9dtMzGDSs3byvPQGIjz8rQG
 pCE66YdC6zvb+EkYoDsn7L2zAMehP7UZqPZWKSbHT64kEgcX/VN7KZVY1rhHzulzvYF8tyACCs
 vGbJ3cmJu8JP6pTdqY0G71Ln19RF/CttDlkL9O1BINBa26KH22GSZc1zy0nhe8OOPqPGs7lTWW
 mmZLIF/Wh8ytIwQz+URUVkdEbfUq1JoWbm34P3/5Fn2UE0i9dyD92aMtoHyiJ913KEtqIAKveu
 i8Y=
WDCIronportException: Internal
Received: from bgy2573.ad.shared (HELO naota-xeon.wdc.com) ([10.225.48.58])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Apr 2021 23:28:26 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 16/26] btrfs-progs: zoned: reset zone of freed block group
Date:   Mon, 26 Apr 2021 15:27:32 +0900
Message-Id: <501d22b99fbdf8439fd9726ead439d29b5de8363.1619416549.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1619416549.git.naohiro.aota@wdc.com>
References: <cover.1619416549.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When freeing a chunk, we can/should reset the underlying device zones for
the chunk. This commit introduces btrfs_reset_chunk_zones() and reset the
zones.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 kernel-shared/extent-tree.c | 10 ++++++++++
 kernel-shared/zoned.c       | 28 ++++++++++++++++++++++++++++
 kernel-shared/zoned.h       |  8 ++++++++
 3 files changed, 46 insertions(+)

diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
index 7453bf9f49b6..e3ffe146606f 100644
--- a/kernel-shared/extent-tree.c
+++ b/kernel-shared/extent-tree.c
@@ -21,6 +21,7 @@
 #include <stdint.h>
 #include <math.h>
 #include "kerncompat.h"
+#include "kernel-lib/list.h"
 #include "kernel-lib/radix-tree.h"
 #include "kernel-lib/rbtree.h"
 #include "kernel-shared/ctree.h"
@@ -3013,6 +3014,15 @@ static int free_chunk_dev_extent_items(struct btrfs_trans_handle *trans,
 			       struct btrfs_chunk);
 	num_stripes = btrfs_chunk_num_stripes(path->nodes[0], chunk);
 	for (i = 0; i < num_stripes; i++) {
+		u64 devid = btrfs_stripe_devid_nr(path->nodes[0], chunk, i);
+		u64 offset = btrfs_stripe_offset_nr(path->nodes[0], chunk, i);
+		u64 length = btrfs_stripe_length(fs_info, path->nodes[0],
+						 chunk);
+
+		ret = btrfs_reset_chunk_zones(fs_info, devid, offset, length);
+		if (ret < 0)
+			goto out;
+
 		ret = free_dev_extent_item(trans, fs_info,
 			btrfs_stripe_devid_nr(path->nodes[0], chunk, i),
 			btrfs_stripe_offset_nr(path->nodes[0], chunk, i));
diff --git a/kernel-shared/zoned.c b/kernel-shared/zoned.c
index 793c524ed66f..22e0245abaf6 100644
--- a/kernel-shared/zoned.c
+++ b/kernel-shared/zoned.c
@@ -886,6 +886,34 @@ bool btrfs_redirty_extent_buffer_for_zoned(struct btrfs_fs_info *fs_info,
 	return false;
 }
 
+int btrfs_reset_chunk_zones(struct btrfs_fs_info *fs_info, u64 devid,
+			    u64 offset, u64 length)
+{
+	struct btrfs_device *device;
+
+	list_for_each_entry(device, &fs_info->fs_devices->devices,
+			    dev_list) {
+		struct btrfs_zoned_device_info *zinfo;
+		struct blk_zone *reset;
+
+		if (device->devid != devid)
+			continue;
+
+		zinfo = device->zone_info;
+		if (!zone_is_sequential(zinfo, offset))
+			continue;
+
+		reset = &zinfo->zones[offset / zinfo->zone_size];
+		if (btrfs_reset_dev_zone(device->fd, reset)) {
+			error("zoned: failed to reset zone %llu: %m",
+			      offset / zinfo->zone_size);
+			return -EIO;
+		}
+	}
+
+	return 0;
+}
+
 #endif
 
 int btrfs_get_dev_zone_info_all_devices(struct btrfs_fs_info *fs_info)
diff --git a/kernel-shared/zoned.h b/kernel-shared/zoned.h
index 1ba5a9939a3c..70044acc4d94 100644
--- a/kernel-shared/zoned.h
+++ b/kernel-shared/zoned.h
@@ -89,6 +89,8 @@ int btrfs_load_block_group_zone_info(struct btrfs_fs_info *fs_info,
 				     struct btrfs_block_group *cache);
 bool btrfs_redirty_extent_buffer_for_zoned(struct btrfs_fs_info *fs_info,
 					   u64 start, u64 end);
+int btrfs_reset_chunk_zones(struct btrfs_fs_info *fs_info, u64 devid,
+			    u64 offset, u64 length);
 #else
 #define sbread(fd, buf, offset) \
 	pread64(fd, buf, BTRFS_SUPER_INFO_SIZE, offset)
@@ -130,6 +132,12 @@ static inline bool btrfs_redirty_extent_buffer_for_zoned(
 	return false;
 }
 
+static inline int btrfs_reset_chunk_zones(struct btrfs_fs_info *fs_info,
+					  u64 devid, u64 offset, u64 length)
+{
+	return 0;
+}
+
 #endif /* BTRFS_ZONED */
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
-- 
2.31.1

