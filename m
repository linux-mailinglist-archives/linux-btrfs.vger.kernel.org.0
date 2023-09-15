Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D53F7A16AE
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Sep 2023 08:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbjIOG65 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Sep 2023 02:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232524AbjIOG64 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Sep 2023 02:58:56 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4DE2D42;
        Thu, 14 Sep 2023 23:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1694761095; x=1726297095;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZWpTcRObHJU/MCMhj1s0rD2EcCWWBEZU05JkSJewPdA=;
  b=Zy6eeff0zcLNbC8qUzpW+8m2CY5Fi8aWe9MtTsvlJ+4EIUezN246Ha8o
   4jSJ0ldxezfX+atBFnKfCuJnPBKPIG2bhhrNRcNlA4NSeZQ8B2BvZMC6Z
   8W8DZwwKey8bqLXolukWryt6ZfonVKUajdRlCf4Dr2lTfs9WUoScs6Bms
   WvpmIPB9+WSK9QBBwin9/Qw/DAh67ehPvj+g4X/E3ooOd2u0sqIbo8L+d
   J8iqgX4r5m1feeWyhgxwcxyCp10ukWne0M1NSD2wFJMTwCzSSyNB/x5bE
   5uBZqTl4rm4fdelNiy+BXHDQQDxP9uMck6YOuJQ29QTkQ3ylEnjfXyMYZ
   g==;
X-CSE-ConnectionGUID: 7f9KrLlFT8egiUP9ytuKIg==
X-CSE-MsgGUID: Oq7l2/ifQdmuScPE3asOIg==
X-IronPort-AV: E=Sophos;i="6.02,148,1688400000"; 
   d="scan'208";a="244368681"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2023 14:58:13 +0800
IronPort-SDR: X0w4tHx6FkrBocyPnCoRXM/8xcwaGTctk+mQN7KWyHTch5H+lNyn+jBFlXbVaIXRyeFPTddi7B
 +WDF0BkLm+W5k05rf8OS8v79AgMskWyt0C0iPmTjzeMvHFsE5VX4/d618fawe8E37qXTxXIiu+
 9C4B1DzXjSSIfChmGGv9mYOT52SqSbWMggzuriEXG5kfiFUBEdAH38mZzyYGvHyNCGfyERWJEy
 i4Ooq3FfcrJ0i92LCwvMLsUmI6mUkghRYRj0F6DnUwsZV75Ux3xe15WPgRj9EqGVb954zSFe/O
 LqU=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Sep 2023 23:10:55 -0700
IronPort-SDR: okim12+T0qbsTR6dp/r5UBYTq48Ho7eTzT62lij5LlEEA9/yKrmbN4cbfsIaKxlArEN/OrphXj
 Mk5zP3i4k4MtXfMcXwjATffPXQEQC25+458evVwtY4EXrNL5gQEqywMuNHvtAyEVunnVQQ7uQH
 wsaNUXBwaG4rNLG0ljYafz93v/6UwXPDNcT3E+PmdQI6yEBXXnSmwOfChT9DrBaVJ5SmatCyKC
 UiWm3Clyovdww7hRnWw3SjdftGCotSbYMH7jK1JUUY7TU66qJdbHfabzb9hYIc9j7SiHBTS5BU
 ndk=
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.78])
  by uls-op-cesaip01.wdc.com with ESMTP; 14 Sep 2023 23:58:13 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 1/2] btrfs/072: support smaller extent size limit
Date:   Fri, 15 Sep 2023 15:57:59 +0900
Message-ID: <ba2d196150127c37acb7d2af5e049e74385fb30b.1694760780.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1694760780.git.naohiro.aota@wdc.com>
References: <cover.1694760780.git.naohiro.aota@wdc.com>
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

Running btrfs/072 on a zoned null_blk device will fail with the following error.

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

