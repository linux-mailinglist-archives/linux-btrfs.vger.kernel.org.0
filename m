Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22DEB74074E
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jun 2023 02:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjF1Axh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jun 2023 20:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjF1Axg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jun 2023 20:53:36 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8254296E
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jun 2023 17:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1687913615; x=1719449615;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QICBN8pJqYcRAInbSPRkY++AbMkGbBwHsmqmzQojpeM=;
  b=VTVfDajqTSs7xwwgPYzf6yT1963nDt1cukJqIfBNFuHtCETg8ofPqIZo
   aMYYihcBKwGu+41XPSmevKUeifUpJHwGHSPZvCdCKdnjD1q04MEkVMOdO
   SUmIEejitW6v7c8Qb0gqaFJpJMZlSKKOtU6Jg5CppiYdFZf+r6Y8E8UK8
   XDgVP1cTu3qWQ7JOi3SorB+19lpjwq/oV5h38w92QO8FsGBS4if4ArI+J
   TL+5sMyQ5Gp/1Fsen7nC+i2SS7c0j5qMk5NtsL7J1slIEafXuhMXqns7s
   5eXUkNrLStIRjOlz/+RTV9GuJkWGIpzyhNTJgjvaxmStJFl545BXCpGlY
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,163,1684771200"; 
   d="scan'208";a="341751121"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jun 2023 08:53:35 +0800
IronPort-SDR: OHbSpXhr3zhznjRiyynFLVhROHATUk7H97UCGNEy1fubJpxHAjaMt6/e5tMp+Av1b3ZAaV2U71
 9vq2vSI+6UXV2H/E7SHKxbZ8S5egcvmIZD0jRNEdPkQRhfp4YOIWwI2adGvXzo8W24ISTSrZID
 tyhmRFa2Ac1GmTLKOA3jHGBThbb2Pxvll3ThNKdoz492mgBJZFPtYigNTIkkFhHksGyqFCBj2R
 8dZW9vDRW5hV3nJ5Hj8meNCrFQbzYOONFTQyVbVlM1QVO1mkyR8pGwxYbwgAfbat44OhIAJvYn
 /m4=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jun 2023 17:02:12 -0700
IronPort-SDR: xcWOdl4xFMty+fc9B4ZmdBbMROx2v0fomaUjgmd6415j6EwzF5PBk6ws8QvWQPvkRhDI9Aj/Tn
 WHj0C0aX9rStESgSypphqbziqDSdTc5Rpjc8KQ1sKRx73M3dVpavRXJ+hqXrf1IZlHhZNrwZiG
 9Ym2guDQYeuRwqidqTOZ838REhBMqrYCrLb7CtgyaV65+dfqJ+Scb9EhuubN/ppU2it9EPAEVH
 /CUTWfdA/QpNonPcSF9jatUkRK7TwBdeYUXqseuPmTaAOilewVTyTvTKMaA+E8cgFUQwWQVYvy
 OGQ=
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.46])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Jun 2023 17:53:35 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] btrfs: zoned: do not enable async discard
Date:   Wed, 28 Jun 2023 09:53:25 +0900
Message-ID: <87c887259bfb49878be9990f4dd559ee90d273ec.1687913519.git.naohiro.aota@wdc.com>
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

The zoned mode need to reset a zone before using it. We rely on btrfs's
original discard functionality (discarding unused block group range) to do
the resetting.

While the commit 63a7cb130718 ("btrfs: auto enable discard=async when
possible") made the discard done in an async manner, a zoned reset do not
need to be async, as it is fast enough.

Even worth, delaying zone rests prevents using those zones again. So, let's
disable async discard on the zoned mode.

Fixes: 63a7cb130718 ("btrfs: auto enable discard=async when possible")
CC: stable@vger.kernel.org # 6.3+
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/disk-io.c | 7 ++++++-
 fs/btrfs/zoned.c   | 5 +++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 7513388b0567..9b9914e5f03d 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3438,11 +3438,16 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	 * For devices supporting discard turn on discard=async automatically,
 	 * unless it's already set or disabled. This could be turned off by
 	 * nodiscard for the same mount.
+	 *
+	 * The zoned mode piggy backs on the discard functionality for
+	 * resetting a zone. There is no reason to delay the zone reset as it is
+	 * fast enough. So, do not enable async discard for zoned mode.
 	 */
 	if (!(btrfs_test_opt(fs_info, DISCARD_SYNC) ||
 	      btrfs_test_opt(fs_info, DISCARD_ASYNC) ||
 	      btrfs_test_opt(fs_info, NODISCARD)) &&
-	    fs_info->fs_devices->discardable) {
+	    fs_info->fs_devices->discardable &&
+	    !btrfs_is_zoned(fs_info)) {
 		btrfs_set_and_info(fs_info, DISCARD_ASYNC,
 				   "auto enabling async discard");
 	}
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 85b8b332add9..56baac950f11 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -805,6 +805,11 @@ int btrfs_check_mountopts_zoned(struct btrfs_fs_info *info)
 		return -EINVAL;
 	}
 
+	if (btrfs_test_opt(info, DISCARD_ASYNC)) {
+		btrfs_err(info, "zoned: async discard not supported");
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
-- 
2.41.0

