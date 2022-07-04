Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4519564CDE
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Jul 2022 06:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbiGDE6y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Jul 2022 00:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbiGDE6t (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Jul 2022 00:58:49 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D545FA4
        for <linux-btrfs@vger.kernel.org>; Sun,  3 Jul 2022 21:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656910728; x=1688446728;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8yCyf2FhjLaIcHMP4bgW6Bl5OA3CArHaLIB/b2LFXUQ=;
  b=l/27ZeenMzswxhPYbLNOaNOP4bV6J34PvqXcJaL9YaCWyaios6cpxCku
   oklf7zPxWfLGJFIBrv3aj+03NXzR6Ljive+FtzPumaCPNyclNnAq6r8D6
   cjP6V4MXWKIOBMGhNS/hqFSl7lbQJR4KjbrsowRtt1giC1MTvFFHO1HcS
   jF72w/TqtwU7Wr+iHHs4VLeYi26KOOIT9Mm7lbxvA0+kIqArN6kG4ktJX
   ag79yOjBvfMZax3HS1Trh1lDcMFJaRjMyG5EmBaUa0PTsUiuUoWNIxaAo
   845T8lRcR2OSWZPQYBhfRaqPCzbdGNMyGjev0dUA85KUrRvpkwFQWpbrG
   A==;
X-IronPort-AV: E=Sophos;i="5.92,243,1650902400"; 
   d="scan'208";a="204732399"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Jul 2022 12:58:47 +0800
IronPort-SDR: HMcnJIHSWaFxS5iBloyaZu+8iHGQmNSW15YPkdIaTwvA3AikaJHTo0BCyWwpfoWwjD76y6Ls2L
 Kq6n2IRk+b1RXzTyhPthNW66Z9bo+IpQM1ldoMovv7vi+/ff4/HoefjVCnhPnBPDHZ/jN76bei
 6t6S9+Lzhez3ZtYj9TFi4aWk4LQPFYXNG1H4mGXvb5L2KBDKBpK/T/fKTQJVb7OYvRjpxj20eG
 QkeJ7pTd/V3Zrrmvy5j8NX+uFkSATQL84Og+UhlCPl64g1d+kyRoHZr7jfrssPt4D//240HjRL
 66rkQi4QSfkZ0ZcPCXx6XVua
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Jul 2022 21:20:40 -0700
IronPort-SDR: aMwQ37GlTXMjVvLkTEOmpQ3f8JMVbu1Ua9g4+mb2KdiqbxMgRQQi1Lld6N4Kbk2xOfgcANqP8A
 mwze9zeMgd3p3H9HknJvZcguMzMOv9Yjm8KYqmXxtloLiu3CZ4xEAM6MV4RNbnzX9m7dzd45We
 jNeoaf6jgD8zl0S729UgPO9Xw4a5wuVLkaMQi6mMwUsJ1ytVNHYGXzv0Jfv1APkcVCnC1EX7sO
 o8+vIFg6XJeRlByCSbg3QCMh47IKUjJF9eiWRC3nXL/v3HNzaSUTRAJDHLdl7wZPGgqDLBfeWL
 IgE=
WDCIronportException: Internal
Received: from h5lk5s2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.53.119])
  by uls-op-cesaip02.wdc.com with ESMTP; 03 Jul 2022 21:58:48 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 02/13] btrfs: zoned: revive max_zone_append_bytes
Date:   Mon,  4 Jul 2022 13:58:06 +0900
Message-Id: <687ec8ab8c61a9972d6936cdf189dc5756299051.1656909695.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1656909695.git.naohiro.aota@wdc.com>
References: <cover.1656909695.git.naohiro.aota@wdc.com>
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
 fs/btrfs/zoned.c | 10 ++++++++++
 fs/btrfs/zoned.h |  1 +
 3 files changed, 13 insertions(+)

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
index 7a0f8fa44800..271b8b8fd4d0 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -415,6 +415,9 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
 	nr_sectors = bdev_nr_sectors(bdev);
 	zone_info->zone_size_shift = ilog2(zone_info->zone_size);
 	zone_info->nr_zones = nr_sectors >> ilog2(zone_sectors);
+	zone_info->max_zone_append_size =
+		min_t(u64, (u64)bdev_max_zone_append_sectors(bdev) << SECTOR_SHIFT,
+		      (u64)bdev_max_segments(bdev) << PAGE_SHIFT);
 	if (!IS_ALIGNED(nr_sectors, zone_sectors))
 		zone_info->nr_zones++;
 
@@ -640,6 +643,7 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
 	u64 zoned_devices = 0;
 	u64 nr_devices = 0;
 	u64 zone_size = 0;
+	u64 max_zone_append_size = 0;
 	const bool incompat_zoned = btrfs_fs_incompat(fs_info, ZONED);
 	int ret = 0;
 
@@ -674,6 +678,11 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
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
@@ -723,6 +732,7 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
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

