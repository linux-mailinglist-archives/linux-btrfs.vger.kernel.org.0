Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C210456C55A
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Jul 2022 02:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238897AbiGHXTL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Jul 2022 19:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238853AbiGHXTK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Jul 2022 19:19:10 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45C14198F;
        Fri,  8 Jul 2022 16:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657322349; x=1688858349;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9+7G1x4we068kq8mY96PXl2+JAjJjjn2izwbzHLi14c=;
  b=IeqRXvad8iVSz2sVYT6bOtwQrWRekobi2QtGSrMPuQiAzbwnMWwV5I2/
   BwJus1YXiUaj1ZSABQmiXw0gv6WRelK507HK1EboVSwHDf9a8tTnWeU/D
   vmtMNVnPzrpaADdrA/b918MByYlQHQqdrT49PCZA3SQLA9doD3FB+eW0E
   TMgQvOfS2OxOXIsStXPxvghcBTHqK+uGF5hKCJDs03y9SgwemSNJCUdvS
   YQdcrs8F/DBf6tcuTiaDu3iQtAP/3czkRVXEA6U89Ylt4yiCamRgEF7VT
   XauEhWYpw2PWNwpSnGHdglVhZwdRRfblFiQWUG3gkgPkVPS5LBw2RwcDB
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,256,1650902400"; 
   d="scan'208";a="203871812"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jul 2022 07:19:07 +0800
IronPort-SDR: If0k3NmXCPOzuJ6HvZluX7vqpzFvAHbBEe4iw+ghZZ5mS6aQ2yE1qg6atINM8K6ETpV7Nj5huX
 ZMC4u1wwyc6sogOZQYjHFVihlcFWdgb/w/Lbr6vjk65TUw59/1FHdpXiI+pjdAabcV0ftPySmE
 KdnmxEQN9LjbDp777/ZPk72eXE/e4XCeV8l42GEN7arvM9OAIW6huAgAXYZNZ61SK4AuCgBHcC
 F+a3hMhZhLrgiGHFUTdbsqVWmZhdv9KM7LvCcseVrk6p4z21BNR1KR8S0Ymz4/39PyQt68puYF
 vQXDcnEOcMZasN14DfD0KU83
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Jul 2022 15:36:13 -0700
IronPort-SDR: US9+dHhFeROQyZEuvJbpQ9CmrcVrEGWOanTOD5sv6ccG+B9xtV2SuBW0+uUNuzFr8DBsd9z8k4
 EJ2IAXicPVhGsCihdDWlMq5cC8Ba0Ke8IeJprKx9q5CDHtlruIocqZbcgyP+OVtYIsQcjtUtWy
 XQbV26v8gZhzj9JwbYxMxFsuRQfQhCEWHL8JZNthEShcQcOo73TOoPQGRIVtLWuIQkkKVOWwy0
 hURmeHKsY9j9Dy4Fs17QuRzqM6BO6jszBLxPQ9Qr7mKi78Fu3PtjeGcn6KpSdRiskPHEdbRh1U
 T00=
WDCIronportException: Internal
Received: from phd010370.ad.shared (HELO naota-xeon.wdc.com) ([10.225.55.250])
  by uls-op-cesaip01.wdc.com with ESMTP; 08 Jul 2022 16:19:06 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 02/13] btrfs: zoned: revive max_zone_append_bytes
Date:   Sat,  9 Jul 2022 08:18:39 +0900
Message-Id: <edc9b4fc4e5bed2f442c6d581071f58727833f12.1657321126.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1657321126.git.naohiro.aota@wdc.com>
References: <cover.1657321126.git.naohiro.aota@wdc.com>
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

This patch is basically a revert of commit 5a80d1c6a270 ("btrfs: zoned:
remove max_zone_append_size logic"), but without unnecessary ASSERT and
check. The max_zone_append_size will be used as a hint to estimate the
number of extents to cover delalloc/writeback region in the later commits.

The size of a ZONE APPEND bio is also limited by queue_max_segments(), so
this commit considers it to calculate max_zone_append_size. Technically, a
bio can be larger than queue_max_segments() * PAGE_SIZE if the pages are
contiguous. But, it is safe to consider "queue_max_segments() * PAGE_SIZE"
as an upper limit of an extent size to calculate the number of extents
needed to write data.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/ctree.h |  2 ++
 fs/btrfs/zoned.c | 17 +++++++++++++++++
 fs/btrfs/zoned.h |  1 +
 3 files changed, 20 insertions(+)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 4e2569f84aab..e4879912c475 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1071,6 +1071,8 @@ struct btrfs_fs_info {
 	 */
 	u64 zone_size;
 
+	/* Max size to emit ZONE_APPEND write command */
+	u64 max_zone_append_size;
 	struct mutex zoned_meta_io_lock;
 	spinlock_t treelog_bg_lock;
 	u64 treelog_bg;
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 79a2d48a5251..bdc533fa80ae 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -415,6 +415,16 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
 	nr_sectors = bdev_nr_sectors(bdev);
 	zone_info->zone_size_shift = ilog2(zone_info->zone_size);
 	zone_info->nr_zones = nr_sectors >> ilog2(zone_sectors);
+	/*
+	 * We limit max_zone_append_size also by max_segments *
+	 * PAGE_SIZE. Technically, we can have multiple pages per segment. But,
+	 * since btrfs adds the pages one by one to a bio, and btrfs cannot
+	 * increase the metadata reservation even if it increases the number of
+	 * extents, it is safe to stick with the limit.
+	 */
+	zone_info->max_zone_append_size =
+		min_t(u64, (u64)bdev_max_zone_append_sectors(bdev) << SECTOR_SHIFT,
+		      (u64)bdev_max_segments(bdev) << PAGE_SHIFT);
 	if (!IS_ALIGNED(nr_sectors, zone_sectors))
 		zone_info->nr_zones++;
 
@@ -640,6 +650,7 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
 	u64 zoned_devices = 0;
 	u64 nr_devices = 0;
 	u64 zone_size = 0;
+	u64 max_zone_append_size = 0;
 	const bool incompat_zoned = btrfs_fs_incompat(fs_info, ZONED);
 	int ret = 0;
 
@@ -674,6 +685,11 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
 				ret = -EINVAL;
 				goto out;
 			}
+			if (!max_zone_append_size ||
+			    (zone_info->max_zone_append_size &&
+			     zone_info->max_zone_append_size < max_zone_append_size))
+				max_zone_append_size =
+					zone_info->max_zone_append_size;
 		}
 		nr_devices++;
 	}
@@ -723,6 +739,7 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
 	}
 
 	fs_info->zone_size = zone_size;
+	fs_info->max_zone_append_size = max_zone_append_size;
 	fs_info->fs_devices->chunk_alloc_policy = BTRFS_CHUNK_ALLOC_ZONED;
 
 	/*
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index 6b2eec99162b..9caeab07fd38 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -19,6 +19,7 @@ struct btrfs_zoned_device_info {
 	 */
 	u64 zone_size;
 	u8  zone_size_shift;
+	u64 max_zone_append_size;
 	u32 nr_zones;
 	unsigned int max_active_zones;
 	atomic_t active_zones_left;
-- 
2.35.1

