Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D31595137A3
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Apr 2022 17:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348705AbiD1PFq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Apr 2022 11:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343735AbiD1PFl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Apr 2022 11:05:41 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B482B3C77
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Apr 2022 08:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1651158146; x=1682694146;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mlHprPGck7hGApTsz+DkoK6yVOaYvqafyDfjI+LeR7I=;
  b=c41Zoe1/HKSY1MHyh2j2voLToIJ7v8bjDKk7jJlfuJ+Gas2ixoG4AsRN
   JHqQpDoCHkbzrEsDLZSpr2S0XvAfCJY/hQGKgo+6RH1jmkwXrHKQC6KLx
   HsAW+SdsGCmGYzzTUU5EI6PHrpLaFiSHWrhSmBF7dH+3YOftTryPc7KQ6
   LQHQo0NUVumTo+kKkiN0j/Fpuez1EDj5YeVeY67rl2TleD3unYEHJA/hM
   5y7L7aFqj42HUFthVIrjtBQ4GvL71/f254kNQg9DRhLrpELWTFYkK4rfh
   qjdcGeDr9cnTApocNpfHPoWNRty2MXowrs0LvJaM6T1kbtNrhGeBxPW08
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,295,1647273600"; 
   d="scan'208";a="303279898"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Apr 2022 23:02:25 +0800
IronPort-SDR: UJd2QAXCweosIe4G05TSLm+Nocp4T+NbQ55fa4ZNZtV7Z1etRkhprttBya9dTlyG5HTwv7/521
 ysTxqlCSO4DcijrxRo1dFtLTJGTtd/ftDTemGUNGenfk/adiTZmDLp8ExtGTcd4FoU7nuR90Se
 7L2+5xZH2/qLKmrznfiLhcB6j/mZpcL0cenk8O8i9Vrz8lBLUtgHvX6pGCGWTKQIe+sSRdKn1U
 hvyPLxiK9UoRJSo6HEldj9t1a/1ZQ56y2F/X5J9+KtVOZr8PXiwgOUknIspbsH8jIe75v2EvJ+
 7rXaNgHbf5GVnQG2rUOOR79I
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Apr 2022 07:32:33 -0700
IronPort-SDR: xoGxCucOCgfBkEn3GxxVvB6WnIXuwNKUXYig/3l+MjlzeUzwAe5l8sVjgmoJIYSQX92s4pn9ir
 2d7fa03ASWTxsm04exBbPLdg887sXD18klpGFB1ypSmxZJgFhtSPUm9rMmIokYwWUwGm5hIXp5
 jmqE4kGyqQ53PZopTwYcqUW6AeyrUlySboy+HsYP24GzYxhyHHT+oSGhDhocUKzEL3MdbbR91C
 pXptAO34u1emS1ymX2FEj08DeijX2q5iYuCKNesMn2Nmoht2MZsXu3RCkM5oOSHRhTCw7VQTyu
 oyY=
WDCIronportException: Internal
Received: from fd6v5s2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.48.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 28 Apr 2022 08:02:25 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 3/4] btrfs: zoned: properly finish block group on metadata write
Date:   Fri, 29 Apr 2022 00:02:17 +0900
Message-Id: <e6d12366d9137cbccd4cac00a04e36f5b0ea8c68.1651157034.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1651157034.git.naohiro.aota@wdc.com>
References: <cover.1651157034.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Commit be1a1d7a5d24 ("btrfs: zoned: finish fully written block group")
introduced zone finishing code both for data and metadata end_io path.
However, the metadata side is not working as it should be. First, it
compares logical address (eb->start + eb->len) with offset within a block
group (cache->zone_capacity) in submit_eb_page(). That essentially disabled
zone finishing on metadata end_io path.

Furthermore, fixing the issue above revealed we cannot call
btrfs_zone_finish_endio() in end_extent_buffer_writeback(). We cannot call
btrfs_lookup_block_group() which require spin lock inside end_io context.

This commit introduces btrfs_schedule_zone_finish_bg() to wait for the
extent buffer writeback and do the zone finish IO in a workqueue.

Also, drop EXTENT_BUFFER_ZONE_FINISH as it is no longer used.

Cc: stable@vger.kernel.org # 5.16+
Fixes: be1a1d7a5d24 ("btrfs: zoned: finish fully written block group")
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.h |  2 ++
 fs/btrfs/extent_io.c   |  6 +-----
 fs/btrfs/extent_io.h   |  1 -
 fs/btrfs/zoned.c       | 34 ++++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.h       |  5 +++++
 5 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index c9bf01dd10e8..3ac668ace50a 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -212,6 +212,8 @@ struct btrfs_block_group {
 	u64 meta_write_pointer;
 	struct map_lookup *physical_map;
 	struct list_head active_bg_list;
+	struct work_struct zone_finish_work;
+	struct extent_buffer *last_eb;
 };
 
 static inline u64 btrfs_block_group_end(struct btrfs_block_group *block_group)
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index f9d6dd310c42..4778067bc0fa 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4259,9 +4259,6 @@ void wait_on_extent_buffer_writeback(struct extent_buffer *eb)
 
 static void end_extent_buffer_writeback(struct extent_buffer *eb)
 {
-	if (test_bit(EXTENT_BUFFER_ZONE_FINISH, &eb->bflags))
-		btrfs_zone_finish_endio(eb->fs_info, eb->start, eb->len);
-
 	clear_bit(EXTENT_BUFFER_WRITEBACK, &eb->bflags);
 	smp_mb__after_atomic();
 	wake_up_bit(&eb->bflags, EXTENT_BUFFER_WRITEBACK);
@@ -4851,8 +4848,7 @@ static int submit_eb_page(struct page *page, struct writeback_control *wbc,
 		/*
 		 * Implies write in zoned mode. Mark the last eb in a block group.
 		 */
-		if (cache->seq_zone && eb->start + eb->len == cache->zone_capacity)
-			set_bit(EXTENT_BUFFER_ZONE_FINISH, &eb->bflags);
+		btrfs_schedule_zone_finish_bg(cache, eb);
 		btrfs_put_block_group(cache);
 	}
 	ret = write_one_eb(eb, wbc, epd);
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index b390ec79f9a8..89ebb7338d6f 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -32,7 +32,6 @@ enum {
 	/* write IO error */
 	EXTENT_BUFFER_WRITE_ERR,
 	EXTENT_BUFFER_NO_CHECK,
-	EXTENT_BUFFER_ZONE_FINISH,
 };
 
 /* these are flags for __process_pages_contig */
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 0f6ca3587c3b..afad085a589a 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2041,6 +2041,40 @@ void btrfs_zone_finish_endio(struct btrfs_fs_info *fs_info, u64 logical, u64 len
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
+		btrfs_err(bg->fs_info,
+			  "double scheduling of BG %llu zone finishing",
+			  bg->start);
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
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index de923fc8449d..10f31d1c8b0c 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -72,6 +72,8 @@ int btrfs_zone_finish(struct btrfs_block_group *block_group);
 bool btrfs_can_activate_zone(struct btrfs_fs_devices *fs_devices, u64 flags);
 void btrfs_zone_finish_endio(struct btrfs_fs_info *fs_info, u64 logical,
 			     u64 length);
+void btrfs_schedule_zone_finish_bg(struct btrfs_block_group *bg,
+				   struct extent_buffer *eb);
 void btrfs_clear_data_reloc_bg(struct btrfs_block_group *bg);
 void btrfs_free_zone_cache(struct btrfs_fs_info *fs_info);
 bool btrfs_zoned_should_reclaim(struct btrfs_fs_info *fs_info);
@@ -230,6 +232,9 @@ static inline bool btrfs_can_activate_zone(struct btrfs_fs_devices *fs_devices,
 static inline void btrfs_zone_finish_endio(struct btrfs_fs_info *fs_info,
 					   u64 logical, u64 length) { }
 
+static inline void btrfs_schedule_zone_finish_bg(struct btrfs_block_group *bg,
+						 struct extent_buffer *eb) { }
+
 static inline void btrfs_clear_data_reloc_bg(struct btrfs_block_group *bg) { }
 
 static inline void btrfs_free_zone_cache(struct btrfs_fs_info *fs_info) { }
-- 
2.35.1

