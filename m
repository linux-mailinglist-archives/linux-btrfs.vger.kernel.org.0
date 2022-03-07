Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F283A4CF91A
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 11:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239671AbiCGKDf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 05:03:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240634AbiCGKBK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 05:01:10 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76E445AFF
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 01:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646646635; x=1678182635;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ypD+j6Cmo6mkpJTarsYyH2i5J8diq8WwgIvmdRTjxy8=;
  b=OH5TCin/VzMJzHkpYR4Zyeo9wBWLKMXuMm51gVxGOgAwmZIYOdrfGYOX
   /ZHhJUm0ak5KBCVU8emBVEOcEKqTNANZVszWHSN1aJ5/BKARONZezKU1J
   L4ZvyS/GkOzWs+HnzVqwTfiLlAsaTvHaK36BL6sHwD8TMcARgq+zwTg3K
   k8kxC6GhdTbjX/8hXaNpuokr3LWtrf8AIOPhaGD3X5i0hN4JvDQ00sdjT
   8kdLQJwF43QC0sFYJvJqBBg+hir+uTuoEMLyDteUk+yW1ytuVtS0QbQt+
   xBf3WGFmViT+DNhvArz8hnA1jUeRG64BNKWHI+4XX6I2UBx6BAKnWf6qa
   g==;
X-IronPort-AV: E=Sophos;i="5.90,161,1643644800"; 
   d="scan'208";a="195612175"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Mar 2022 17:50:32 +0800
IronPort-SDR: TorB5DNRRUKAOW/Qg2ili+AoxB4M/YAhx8HvaBiWAeEKRcW3FJe2Do2VE/lH5ZgfTzcgSoiKf+
 Bp50dBSg3yjoPWJQBVcC7VIyKqQGzOFYXT3PBSvOWMIdK6gHMBmaMWinbd6sXMIwOzjcZ9uG+z
 2kkW3MJf45H5J2fAIFtbWpPB5MGOW+X0VuWBguszgq59XTMA6Kq7sNz7ytIQAFBHLv615SeTMR
 LP/oJ5Pe2oaU+r/51MExkvLv5CFoeOUGblIROfYnfoUc/OYQbPBAMfDTLBHbHt0yxiAbM7inox
 RZFQfkFv8SXIrJcAhmtPp+sl
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 01:21:50 -0800
IronPort-SDR: X7YJhNaKzYoSRBPjg+7xjNDqQAa3cVU9Ffb4UDFqIz2ep7Esu9yt13Jr5O2PvB4JLpY6hE/pHC
 56NpTfdTjkeguygUyHLnJ6L9qTSpyiQ7HHa/Ulxohut+/oTwKgUSxWqdqY0i3St1fggsZsZ2K1
 9sbTm50z5MvJq7uUOtCk4VsdOrVUxMNnxZ0lbyGSFbL9L/Sr5QGilf0gzJ2wsQ42bELkoRp6Yz
 i2wrE38rgsWPGAZ/IHPzzNLKZ1s5rydYyNDQLJBRMAO8ax3ceIG5sYNQ2skJuKBUp7FZSjFq1Y
 /w8=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Mar 2022 01:50:32 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: zoned: remove left over ASSERT()
Date:   Mon,  7 Mar 2022 01:50:25 -0800
Message-Id: <b92ca351a2b2467de3d1f31f7b42630d88c67ab4.1646646324.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1646646324.git.johannes.thumshirn@wdc.com>
References: <cover.1646646324.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

With commit dcf5652291f6 ("btrfs: zoned: allow DUP on meta-data block
groups") we started allowing DUP on meta-data block-groups, so the
ASSERT()s in btrfs_can_activate_zone() and btrfs_zoned_get_device() are
no longer valid and in fact even harmful.

Fixes: dcf5652291f6 ("btrfs: zoned: allow DUP on meta-data block groups")
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/zoned.c | 36 ++++++++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index cf6341d45689..e50fe388ccae 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1801,7 +1801,6 @@ struct btrfs_device *btrfs_zoned_get_device(struct btrfs_fs_info *fs_info,
 
 	map = em->map_lookup;
 	/* We only support single profile for now */
-	ASSERT(map->num_stripes == 1);
 	device = map->stripes[0].dev;
 
 	free_extent_map(em);
@@ -1982,9 +1981,6 @@ bool btrfs_can_activate_zone(struct btrfs_fs_devices *fs_devices, u64 flags)
 	if (!btrfs_is_zoned(fs_devices->fs_info))
 		return true;
 
-	/* Non-single profiles are not supported yet */
-	ASSERT((flags & BTRFS_BLOCK_GROUP_PROFILE_MASK) == 0);
-
 	/* Check if there is a device with active zones left */
 	rcu_read_lock();
 	list_for_each_entry_rcu(device, &fs_devices->devices, dev_list) {
@@ -2055,6 +2051,38 @@ void btrfs_zone_finish_endio(struct btrfs_fs_info *fs_info, u64 logical, u64 len
 	btrfs_put_block_group(block_group);
 }
 
+static void btrfs_zone_finish_endio_workfn(struct work_struct *work)
+{
+	struct btrfs_block_group *bg =
+		container_of(work, struct btrfs_block_group, zone_finish_work);
+
+	wait_on_extent_buffer_writeback(bg->last_eb);
+	free_extent_buffer(bg->last_eb);
+	btrfs_zone_finish_endio(bg->fs_info, bg->start, bg->length);
+	btrfs_put_block_group(bg);
+}
+
+void btrfs_schedule_zone_finish_bg(struct btrfs_block_group *bg,
+				   struct extent_buffer *eb)
+{
+	if (!bg->seq_zone ||
+	    eb->start + eb->len * 2 <= bg->start + bg->zone_capacity)
+		return;
+
+	if (WARN_ON(bg->zone_finish_work.func ==
+		    btrfs_zone_finish_endio_workfn)) {
+		pr_info("double scheduling BG %llu\n", bg->start);
+		return;
+	}
+
+	/* For the work */
+	btrfs_get_block_group(bg);
+	atomic_inc(&eb->refs);
+	bg->last_eb = eb;
+	INIT_WORK(&bg->zone_finish_work, btrfs_zone_finish_endio_workfn);
+	queue_work(system_unbound_wq, &bg->zone_finish_work);
+}
+
 void btrfs_clear_data_reloc_bg(struct btrfs_block_group *bg)
 {
 	struct btrfs_fs_info *fs_info = bg->fs_info;
-- 
2.35.1

