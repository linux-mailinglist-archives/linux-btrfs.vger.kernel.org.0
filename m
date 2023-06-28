Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD6B74075A
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jun 2023 02:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjF1A5M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jun 2023 20:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjF1A5K (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jun 2023 20:57:10 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A582EE
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jun 2023 17:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1687913829; x=1719449829;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LQW9YqwfEprTzwmCdWaBmLIJYddna/LqVkA7GcuJfLs=;
  b=kxwsHxVkPk6v/iLcsu+6ABsM3ZZD7/D3APjKlCSSbZT5m6HawQKUi1Bk
   AwoWUfLbLKnB12mE7PpoXIFUh5QMJm6NQE6fRs5VIhbshSin86TUaLFeq
   TAs/cRmoSabYk+EuMqs2rNIUEruK4VD0Doql+JUI0frxRVnRj/dhlcXwD
   tKpxc9knPINDmLv7oV3v+hzMLYS3LXlC/1tVmuCgji4IfY48sqk/lnNNk
   gq+XzWXWvTfmPsHCTjRmAkGwMp7C/R4NpujkAlF52cIzx4nV/r7xZZmK+
   nDw09qTl9PjkQIBVeUsbAFseBCPIN9xPzZIXcLxGNvZtBvivTm+OXflHu
   A==;
X-IronPort-AV: E=Sophos;i="6.01,163,1684771200"; 
   d="scan'208";a="341751378"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jun 2023 08:57:09 +0800
IronPort-SDR: CJ4JUwwZ8xXo2ErAMiqG7pDdRJcT2DoVdnIXIelFVbyKXmM/JWUZI3mC4wpgaJSsZORbMg2d+M
 S44Ljkgu7zg8kcUGeWvR2C0Igym4M1tLjhUGKVu/tFGHrRAaaZ61gYaBn/Xs++a1vDrjnZh/AA
 epnQe0N6RKEhw+vmmZxUB+ODyN6grGQQ8tqgYw1FjH5Wj5SDCpTtpFT4wAcepTKr96A6FdE2y8
 yDoGlEns9RB3Skk8+M2AzAhJusEv919Rkyb/Q/Q1d2BoAnipAescIDj0vZktWX2M0/4u9iFlIG
 VnU=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jun 2023 17:05:46 -0700
IronPort-SDR: rlVm/n8mOozIlSBVO4u0sZByNWY1HbFL7HatplpiF7gOX8du6JX/7Gw7mPdyPzEfhdNRK+ky3e
 ZEqfiTVddxdZWpXAi+WlNW+XPQw/b5WVE1SZ0W2YT35WLNcKXLzQPNoKdCbG2gQ3L48Oaw8Uow
 ZYdO3fO4q02FmMVvNAECKTxcBU+0v6mHS8yo0SE+GmOC7ExEpbhnKOrit2X9+9unBn2QH0Zsv/
 Da4C3S9XnqP606zk/T2cu97RHZ5AO5X4ClyUCofDL0O4+5Vk2w3lwxhdYUGEzrrQGYZ+zRFk8W
 FaA=
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.46])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Jun 2023 17:57:09 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] btrfs: zoned: do not zone finish data relocation block group
Date:   Wed, 28 Jun 2023 09:57:00 +0900
Message-ID: <be28a2d61abdee6846100406b4398ee67c0d2e53.1687913786.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If a block group dedicated to the data relocation is zone finished, there
is a chance that finishing it before an ongoing write IO reaches the
device. As a result, the write IO fail.

We cannot simply use "fs_info->data_reloc_bg == block_group->start" to
avoid the zone finishing. Because, the data_reloc_bg may already switch to
a new block group, while there are still ongoing write IOs to the old
data_reloc_bg.

So, this patch reworks the BLOCK_GROUP_FLAG_ZONED_DATA_RELOC bit to
indicate there is a data relocation allocation and/or ongoing write to the
block group. The bit is set on allocation and cleared in end_io function of
the last IO for the currently allocated region.

To change the timing of the bit setting also solves the issue that the bit
being left even after there is no IO going on. With the current code, if
the data_reloc_bg switches after the last IO to the current data_reloc_bg,
the bit is set at this timing and there is no one clearing that bit. As a
result, that block group is kept unallocatable for anything.

Fixes: 343d8a30851c ("btrfs: zoned: prevent allocation from previous data relocation BG")
Fixes: 74e91b12b115 ("btrfs: zoned: zone finish unused block group")
CC: stable@vger.kernel.org # 6.1+
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/extent-tree.c | 44 +++++++++++++++++++++++-------------------
 fs/btrfs/zoned.c       | 18 ++++++++++++++---
 2 files changed, 39 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 911908ea5f6f..be59c76306e0 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3709,7 +3709,8 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 	       fs_info->data_reloc_bg == 0);
 
 	if (block_group->ro ||
-	    test_bit(BLOCK_GROUP_FLAG_ZONED_DATA_RELOC, &block_group->runtime_flags)) {
+	    (!ffe_ctl->for_data_reloc &&
+	     test_bit(BLOCK_GROUP_FLAG_ZONED_DATA_RELOC, &block_group->runtime_flags))) {
 		ret = 1;
 		goto out;
 	}
@@ -3752,8 +3753,27 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 	if (ffe_ctl->for_treelog && !fs_info->treelog_bg)
 		fs_info->treelog_bg = block_group->start;
 
-	if (ffe_ctl->for_data_reloc && !fs_info->data_reloc_bg)
-		fs_info->data_reloc_bg = block_group->start;
+	if (ffe_ctl->for_data_reloc) {
+		if (!fs_info->data_reloc_bg)
+			fs_info->data_reloc_bg = block_group->start;
+		/*
+		 * Do not allow allocations from this block group, unless it is
+		 * for data relocation. Compared to increasing the ->ro, setting
+		 * the ->zoned_data_reloc_ongoing flag still allows nocow
+		 * writers to come in. See btrfs_inc_nocow_writers().
+		 *
+		 * We need to disable an allocation to avoid an allocation of
+		 * regular (non-relocation data) extent. With mix of relocation
+		 * extents and regular extents, we can dispatch WRITE commands
+		 * (for relocation extents) and ZONE APPEND commands (for
+		 * regular extents) at the same time to the same zone, which
+		 * easily break the write pointer.
+		 *
+		 * Also, this flag avoids this block group to be zone finished.
+		 */
+		set_bit(BLOCK_GROUP_FLAG_ZONED_DATA_RELOC,
+			&block_group->runtime_flags);
+	}
 
 	ffe_ctl->found_offset = start + block_group->alloc_offset;
 	block_group->alloc_offset += num_bytes;
@@ -3771,24 +3791,8 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 out:
 	if (ret && ffe_ctl->for_treelog)
 		fs_info->treelog_bg = 0;
-	if (ret && ffe_ctl->for_data_reloc &&
-	    fs_info->data_reloc_bg == block_group->start) {
-		/*
-		 * Do not allow further allocations from this block group.
-		 * Compared to increasing the ->ro, setting the
-		 * ->zoned_data_reloc_ongoing flag still allows nocow
-		 *  writers to come in. See btrfs_inc_nocow_writers().
-		 *
-		 * We need to disable an allocation to avoid an allocation of
-		 * regular (non-relocation data) extent. With mix of relocation
-		 * extents and regular extents, we can dispatch WRITE commands
-		 * (for relocation extents) and ZONE APPEND commands (for
-		 * regular extents) at the same time to the same zone, which
-		 * easily break the write pointer.
-		 */
-		set_bit(BLOCK_GROUP_FLAG_ZONED_DATA_RELOC, &block_group->runtime_flags);
+	if (ret && ffe_ctl->for_data_reloc)
 		fs_info->data_reloc_bg = 0;
-	}
 	spin_unlock(&fs_info->relocation_bg_lock);
 	spin_unlock(&fs_info->treelog_bg_lock);
 	spin_unlock(&block_group->lock);
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 56baac950f11..b5c8db566c8e 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2008,6 +2008,11 @@ static int do_zone_finish(struct btrfs_block_group *block_group, bool fully_writ
 	 * and block_group->meta_write_pointer for metadata.
 	 */
 	if (!fully_written) {
+		if (test_bit(BLOCK_GROUP_FLAG_ZONED_DATA_RELOC,
+			     &block_group->runtime_flags)) {
+			spin_unlock(&block_group->lock);
+			return -EAGAIN;
+		}
 		spin_unlock(&block_group->lock);
 
 		ret = btrfs_inc_block_group_ro(block_group, false);
@@ -2036,7 +2041,9 @@ static int do_zone_finish(struct btrfs_block_group *block_group, bool fully_writ
 			return 0;
 		}
 
-		if (block_group->reserved) {
+		if (block_group->reserved ||
+		    test_bit(BLOCK_GROUP_FLAG_ZONED_DATA_RELOC,
+			     &block_group->runtime_flags)) {
 			spin_unlock(&block_group->lock);
 			btrfs_dec_block_group_ro(block_group);
 			return -EAGAIN;
@@ -2267,7 +2274,10 @@ void btrfs_zoned_release_data_reloc_bg(struct btrfs_fs_info *fs_info, u64 logica
 
 	/* All relocation extents are written. */
 	if (block_group->start + block_group->alloc_offset == logical + length) {
-		/* Now, release this block group for further allocations. */
+		/*
+		 * Now, release this block group for further allocations
+		 * and zone finish.
+		 */
 		clear_bit(BLOCK_GROUP_FLAG_ZONED_DATA_RELOC,
 			  &block_group->runtime_flags);
 	}
@@ -2291,7 +2301,9 @@ int btrfs_zone_finish_one_bg(struct btrfs_fs_info *fs_info)
 
 		spin_lock(&block_group->lock);
 		if (block_group->reserved || block_group->alloc_offset == 0 ||
-		    (block_group->flags & BTRFS_BLOCK_GROUP_SYSTEM)) {
+		    (block_group->flags & BTRFS_BLOCK_GROUP_SYSTEM) ||
+		    test_bit(BLOCK_GROUP_FLAG_ZONED_DATA_RELOC,
+			     &block_group->runtime_flags)) {
 			spin_unlock(&block_group->lock);
 			continue;
 		}
-- 
2.41.0

