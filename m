Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6414E2DA5
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Mar 2022 17:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350830AbiCUQQJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Mar 2022 12:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351080AbiCUQQC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Mar 2022 12:16:02 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1DDB7C7
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Mar 2022 09:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647879272; x=1679415272;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NI+8tL9wkfU4pm1qOj1P3D/xCQVsf5kJ/T73v6NG014=;
  b=TCgzzFme/9eU2JHHkDt72ZsmOZVZowEnbWx3mTFY6BNagaJibHoWl8Gj
   v9lyoCSc2pB+RshBTz0gUMz+tm4TvcXwwVppVmGF6h2RjN91aH1Zmfg4N
   poGh9fIgdgeRZ8b3Px66UdQAQY3gy9z8HZOLdg2p8XSwflX87MufhlkQF
   cnNnzTyTgXHcoTeQXDdc8eXtx2vNckBdE2qzX3v6A7SWylq3+QabwLUYR
   x6hHw9Gim5Ld9eIDP9mk6MOZdDdqZaY0IveOWUDadESGtP06BtC0ZLpNc
   wgVBH230yw14jw+5avIZ+9DzsyP+aNocJ8psmpljqSilclrI4xrfcjoB7
   w==;
X-IronPort-AV: E=Sophos;i="5.90,199,1643644800"; 
   d="scan'208";a="307836358"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Mar 2022 00:14:32 +0800
IronPort-SDR: ug1lvgC+tuCuMjpomI8QOfMSFZdEQxJ82DkZRy87hb2hLWamdjLWfUQ2rGRLMu016OJs0UWiYE
 N3ma4lgSFCwL67bm4ZFH89GwnTal5gVUapSJZTuZl1boM2O4LyJ0RiwUaqDQ1ZpXDlQgqF52tG
 suueJe5MUUKjBaX1Nf8V7pdPmEbUEfHLbqNRwMKq1GoILXR6TOCqEVFbIkhYZUirgyw6uG7/cL
 kPleZNyXWstEw30vv0oKNfW29tYGEvNYBjAFPMoT4evuRNC+YZMUD9DPJlm9GWuM3CFBNjcXww
 iuXIv6FzD+NiP4mi2RALFWWE
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 08:45:32 -0700
IronPort-SDR: fMXBXthTNN+FrC+x+uAJb2BhEHnnojt/gPpKt5WEWp7hs5cHIUhHV9SQizPJbS7DL3/3ikBTHi
 zP33kfJkeSKGd1vrekJOyNipD7sUhUo1p/WQL1q63dzUM88TRuVCv7ibYa7NFuMtLIlCZZqIaA
 CSn98zp7JDUniZzL9DnvSS6UblAO9iri18XpOAN7JhDm1x+xWrGF6c2xeF6twzj7wBFkzRGjPk
 i74K4Agr6P0BP3iqypPYCpFRfjB1LV1Pii8ISHU5vS+CYHZxOCx2r79gjRvOmu784CA/IgKBT8
 uIU=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 21 Mar 2022 09:14:31 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH 5/5] btrfs: zoned: make auto-reclaim less aggressive
Date:   Mon, 21 Mar 2022 09:14:14 -0700
Message-Id: <89824f8b4ba1ac8f05f74c047333c970049e2815.1647878642.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1647878642.git.johannes.thumshirn@wdc.com>
References: <cover.1647878642.git.johannes.thumshirn@wdc.com>
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

The current auto-reclaim algorithm starts reclaiming all block-group's
with a zone_unusable value above a configured threshold. This is causing a
lot of reclaim IO even if there would be enough free zones on the device.

Instead of only accounting a block-group's zone_unusable value, also take
the number of empty zones into account.

Cc: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

---
Changes since v3:
* remove unusedd include (Filipe)
* Only call btrfs_zoned_should_reclaim() for zoned FSes (Josef)
* Use btrfs_calc_available_free_space() (Josef)

Changes since v2:
* Use div_u64()

Changes since RFC:
* Fix logic error
* Skip unavailable devices
* Use different metric working for non-zoned devices as well
---
 fs/btrfs/block-group.c | 10 ++++++++++
 fs/btrfs/zoned.c       | 23 +++++++++++++++++++++++
 fs/btrfs/zoned.h       |  6 ++++++
 3 files changed, 39 insertions(+)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 628741ecb97b..12454304bb85 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1512,6 +1512,13 @@ static int reclaim_bgs_cmp(void *unused, const struct list_head *a,
 	return bg1->used > bg2->used;
 }
 
+static inline bool btrfs_should_reclaim(struct btrfs_fs_info *fs_info)
+{
+	if (btrfs_is_zoned(fs_info))
+		return btrfs_zoned_should_reclaim(fs_info);
+	return true;
+}
+
 void btrfs_reclaim_bgs_work(struct work_struct *work)
 {
 	struct btrfs_fs_info *fs_info =
@@ -1522,6 +1529,9 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 	if (!test_bit(BTRFS_FS_OPEN, &fs_info->flags))
 		return;
 
+	if (!btrfs_should_reclaim(fs_info))
+		return;
+
 	sb_start_write(fs_info->sb);
 
 	if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_BALANCE)) {
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 1b1b310c3c51..f2a412427921 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2079,3 +2079,26 @@ void btrfs_free_zone_cache(struct btrfs_fs_info *fs_info)
 	}
 	mutex_unlock(&fs_devices->device_list_mutex);
 }
+
+bool btrfs_zoned_should_reclaim(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_space_info *sinfo;
+	u64 used = 0;
+	u64 total = 0;
+	u64 factor;
+
+	if (!btrfs_is_zoned(fs_info))
+		return false;
+
+	if (!fs_info->bg_reclaim_threshold)
+		return false;
+
+	list_for_each_entry(sinfo, &fs_info->space_info, list) {
+		total += sinfo->total_bytes;
+		used += btrfs_calc_available_free_space(fs_info, sinfo,
+							BTRFS_RESERVE_NO_FLUSH);
+	}
+
+	factor = div_u64(used * 100, total);
+	return factor >= fs_info->bg_reclaim_threshold;
+}
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index c489c08d7fd5..f2d16395087f 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -74,6 +74,7 @@ void btrfs_zone_finish_endio(struct btrfs_fs_info *fs_info, u64 logical,
 			     u64 length);
 void btrfs_clear_data_reloc_bg(struct btrfs_block_group *bg);
 void btrfs_free_zone_cache(struct btrfs_fs_info *fs_info);
+bool btrfs_zoned_should_reclaim(struct btrfs_fs_info *fs_info);
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 				     struct blk_zone *zone)
@@ -232,6 +233,11 @@ static inline void btrfs_zone_finish_endio(struct btrfs_fs_info *fs_info,
 static inline void btrfs_clear_data_reloc_bg(struct btrfs_block_group *bg) { }
 
 static inline void btrfs_free_zone_cache(struct btrfs_fs_info *fs_info) { }
+
+static inline bool btrfs_zoned_should_reclaim(struct btrfs_fs_info *fs_info)
+{
+	return false;
+}
 #endif
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
-- 
2.35.1

