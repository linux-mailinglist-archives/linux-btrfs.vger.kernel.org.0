Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 407B87A1748
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Sep 2023 09:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232791AbjIOHZc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Sep 2023 03:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232732AbjIOHZb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Sep 2023 03:25:31 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AB3A1;
        Fri, 15 Sep 2023 00:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1694762718; x=1726298718;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1NnFxVRWyVipOsV3iuPJj3WrrjtkkgKBmB4BROD3awg=;
  b=Cow86i7yWuLZfItWIYhC0qQnns75XZOGEyxeNUZX3LIKilD4g8LMYeZf
   mhSBnA57FyEcm742FSfy8NRt8z2Uol4LnbT7iLU7qatDJmny0H9axX12t
   llhIhe7WkFNEOM7m1o6tB9uC4am06pjv3kbZ/TuCyURXfb+kovqdkoJrL
   yvqaoSqBPmMRBFEpaMUVFvGG9hR65c4EzxYKVQjCxh6SmCJnlzcNcBT/v
   PS852DlY1u+x2d2DiXvLt6mxFhEzKuQUkWVNHoSiMCSkMnqIyVBOp6tVq
   BC2fNTsXJ9q2KzZNVOeeiwU/Qc2/M7g1QCrUkA7s5mihdVG+e9gdTSuA6
   Q==;
X-CSE-ConnectionGUID: 6nZVOcmMQuiq8qSYaa0XMg==
X-CSE-MsgGUID: YpY/dzW3R4GSXQFxMum+kw==
X-IronPort-AV: E=Sophos;i="6.02,148,1688400000"; 
   d="scan'208";a="242254964"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2023 15:25:16 +0800
IronPort-SDR: C2G5w7SbaC+Md9HLy2vuRZU61VNpJUIrjf/uqHZ3vXiDTU7NMZ2q3cC8SFx+uF/6zsDU4ALpGi
 AfHigSQgCYC4E3/GAHAqw4s16Re0dIm79KtI4PwV0OgnelXBglMa1/Jm/HSUaIwhaopW1moiO9
 NT5+lKsCPfl6ZWEZqF+qlE2MFVqFYH0cWSXNyxw4LCbMpcQVpDOSDaOfpanGU0epNpQfXr0pip
 oZ5wLUTNY/Bxgygfj8alswTBAIZEpUgOB5Wb1X9MXvMfdXbvD7UjMifOi7kG8eVYDJgke0RDls
 AZc=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Sep 2023 23:32:17 -0700
IronPort-SDR: 352WC9FS5RFa1violLBUS/7+7U492PtskIAsObFVrrIMVeHlaA820IMsSfUNtClJwUT05hEYI0
 vh7S7cA8GZeLPME7cTpLVso5zjQre10rJcq2LXe9aV45C8BY6QVIAw6pyic0vo129/39wsXp90
 Cd223wz/dYzCWIBvz1NQluDUHSV2SBTEQfit98sKdMHs8o++8cG0rmaJG7ISKru8In1lxGQPIv
 a7NqZ8mCEDEetE0LApQXZYUQV4MEGliTg0ape4wbV5RIxcKqNMsXxoCpVrsGRZGlqWww2jjp0d
 s2I=
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.78])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Sep 2023 00:25:16 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 1/2] btrfs/076: support smaller extent size limit
Date:   Fri, 15 Sep 2023 16:25:10 +0900
Message-ID: <f03093d83baa5bcd4229a0dc9a473add534ee016.1694762532.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1694762532.git.naohiro.aota@wdc.com>
References: <cover.1694762532.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Running btrfs/076 on a zoned null_blk device will fail with the following error.

  - output mismatch (see /host/results/btrfs/076.out.bad)
      --- tests/btrfs/076.out     2021-02-05 01:44:20.000000000 +0000
      +++ /host/results/btrfs/076.out.bad 2023-09-15 01:49:36.000000000 +0000
      @@ -1,3 +1,3 @@
       QA output created by 076
      -80
      -80
      +83
      +83
      ...

This is because the default value of zone_append_max_bytes is 127.5 KB
which is smaller than BTRFS_MAX_UNCOMPRESSED (128K). So, the extent size is
limited to 126976 (= ROUND_DOWN(127.5K, 4096)), which makes the number of
extents larger, and fails the test.

Instead of hard-coding the number of extents, we can calculate it using the
max extent size of an extent. It is limited by either
BTRFS_MAX_UNCOMPRESSED or zone_append_max_bytes.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 tests/btrfs/076     | 23 +++++++++++++++++++++--
 tests/btrfs/076.out |  3 +--
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/tests/btrfs/076 b/tests/btrfs/076
index 89e9672d09e2..a5cc3eb96b2f 100755
--- a/tests/btrfs/076
+++ b/tests/btrfs/076
@@ -28,13 +28,28 @@ _supported_fs btrfs
 _require_test
 _require_scratch
 
+# An extent size can be up to BTRFS_MAX_UNCOMPRESSED
+max_extent_size=$(( 128 << 10 ))
+if _scratch_btrfs_is_zoned; then
+	zone_append_max=$(cat "/sys/block/$(_short_dev $SCRATCH_DEV)/queue/zone_append_max_bytes")
+	if [[ $zone_append_max -gt 0 && $zone_append_max -lt $max_extent_size ]]; then
+		# Round down to PAGE_SIZE
+		max_extent_size=$(( $zone_append_max / 4096 * 4096 ))
+	fi
+fi
+file_size=$(( 10 << 20 ))
+expect=$(( (file_size + max_extent_size - 1) / max_extent_size ))
+
 _scratch_mkfs >> $seqres.full 2>&1
 _scratch_mount "-o compress=lzo"
 
 $XFS_IO_PROG -f -c "pwrite 0 10M" -c "fsync" \
 	$SCRATCH_MNT/data >> $seqres.full 2>&1
 
-_extent_count $SCRATCH_MNT/data
+res=$(_extent_count $SCRATCH_MNT/data)
+if [[ $res -ne $expect ]]; then
+	_fail "Expected $expect extents, got $res"
+fi
 
 $XFS_IO_PROG -f -c "pwrite 0 $((4096*33))" -c "fsync" \
 	$SCRATCH_MNT/data >> $seqres.full 2>&1
@@ -42,7 +57,11 @@ $XFS_IO_PROG -f -c "pwrite 0 $((4096*33))" -c "fsync" \
 $XFS_IO_PROG -f -c "pwrite 0 10M" -c "fsync" \
 	$SCRATCH_MNT/data >> $seqres.full 2>&1
 
-_extent_count $SCRATCH_MNT/data
+res=$(_extent_count $SCRATCH_MNT/data)
+if [[ $res -ne $expect ]]; then
+	_fail "Expected $expect extents, got $res"
+fi
 
+echo "Silence is golden"
 status=0
 exit
diff --git a/tests/btrfs/076.out b/tests/btrfs/076.out
index b99f7eb10a16..248e095d91af 100644
--- a/tests/btrfs/076.out
+++ b/tests/btrfs/076.out
@@ -1,3 +1,2 @@
 QA output created by 076
-80
-80
+Silence is golden
-- 
2.42.0

