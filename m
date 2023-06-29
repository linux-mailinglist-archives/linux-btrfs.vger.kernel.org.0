Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 238AA742264
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jun 2023 10:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbjF2ImR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Jun 2023 04:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjF2IlL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Jun 2023 04:41:11 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581903C35
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Jun 2023 01:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1688027856; x=1719563856;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ERheDmQIoQ5vF30e9LQtT+LH7vzvx+K4bcT+Gf7QptM=;
  b=Pw82o7bSuW76KsPjzJQLo9bH5hYdUNmRZqA/5v5RS9wFKEd1mNw6aU2V
   ewQCyLvjg5qVRr/e2eJtM+ZYQ+YVZWCjOM7X2EyEFnqs+NRtcMcUkdYaK
   8Wf+wcqESf+m9sxze+gsd2INI6ALkwy6ilTGJ+efLhihgoLnTaxK4HZfG
   7xCNMpS+a3LWDVJTu1Aeb9WZx8RIsUtAOh6vAtQ+j8T5PzCdYDBgDlFua
   vpul7nrM914tbsk/y8rfMCzRP8VJ/1DTxUqcRxoSSGyuy7f58hxqn3Ptn
   3CkZoq0rTV6i81scehn+XdeqqDWS/KflNQacfLAFOh8VLXk8WuuimS25V
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,168,1684771200"; 
   d="scan'208";a="237147808"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jun 2023 16:37:35 +0800
IronPort-SDR: xOHDqIrvlATEgWr3XUmzwSaq1LDuIT7LsluJSs2KAkqL1GinBxzsuqPxz+6pgmKY1qcEF0OHzK
 /dUXzGO9EVJ4GfJU8keVwXZChN6dx3HFxB81R33w/DtouuxQKfcmEEx7PhHaSoj5dqqKItBrXQ
 GhO42+zKWICs+Lt7RMfCRcr8U6aan6jXaDRkOCPGn+jfe1fXgqpHo3FdHpUQ9Q1uZyUelheGIY
 UIJF3s1+ApnMwG4NDanqSWFXIW8bKW3NM7CvnESE95Yqgp2egOMz55QJcTmoXyuwN3LoapmclG
 K6s=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jun 2023 00:51:52 -0700
IronPort-SDR: S87lsBbYsf+9Gt9CkcbcgZEWoEyapMhcq56p8kY519F1Dq9RoK+jLRPHmKXPHyj6sp+RKT+07u
 EQZuJiahyzASxJEnwD/I9loOTKntnQYp9JTswS8RRFF7kBnWIzkiSpvTZd9ybWd0nZdJsfcTEO
 10/kRoeVgW/ilYs6B543D09zJwVgBDZ/rB+IIaFNjPpSgTHiW/tktdsEVYTOFItW3Ez/Oti5TF
 nFkBLtRT5ScMSFkjEuBeobVwacxCRbuKazZB+WWh8nRsCIcUEeh/xpzKyKCyM2n7OEOwUeBScN
 lAg=
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.52])
  by uls-op-cesaip02.wdc.com with ESMTP; 29 Jun 2023 01:37:35 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2] btrfs: zoned: do not enable async discard
Date:   Thu, 29 Jun 2023 17:37:31 +0900
Message-ID: <e22f5f69d881de1ec0e381f1be6bfe61b822c064.1688027756.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.41.0
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
index 85b8b332add9..65d17306c2d4 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -805,6 +805,11 @@ int btrfs_check_mountopts_zoned(struct btrfs_fs_info *info)
 		return -EINVAL;
 	}
 
+	if (btrfs_test_opt(info, DISCARD_ASYNC)) {
+		btrfs_warn(info, "zoned: disabling async discard as it is not supported");
+		btrfs_clear_opt(info->mount_opt, DISCARD_ASYNC);
+	}
+
 	return 0;
 }
 
-- 
2.41.0

