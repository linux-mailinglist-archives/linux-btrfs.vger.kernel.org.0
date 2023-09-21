Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58607A9A02
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Sep 2023 20:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjIUSff (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Sep 2023 14:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjIUSfX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Sep 2023 14:35:23 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0983CA75F1;
        Thu, 21 Sep 2023 11:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1695319277; x=1726855277;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=//jgfayI2gxFATylMTHPKR4nhlup1IvXvdrWp+Uwio0=;
  b=ADsvVq35r8BFXsd9kUQzrlY6YXDAfeV0YqX2DkJ4YW9xPaV93ib8QQex
   Q1+cYRXVtu6q7FrtfKUjwP2odkY3hrPaZSmqbe8APigCfc6vjIaDF0JU0
   fe1pVdYfFdAEbzlRT5elEpq3NyEsJttl9BSWo4I/4Wysq39K89iSy1mXr
   xnlqx133Wq9KezksBcZCkEYQ5TXhPlUR3twZDMzIPBLIZ23Ik7gPGnEo3
   aPlvqDve1DmZwaKT1LtExyrD1xh8xSVW7yrinpn5MmBXyDPicwiaDbctF
   e2LMjcmpwAjCHVKg9u4YQ3XtQItjy6TxieMHENCnZkiBeyqHtVxN784xw
   w==;
X-CSE-ConnectionGUID: 6L1tk2izRUOyYq4Jed+pEg==
X-CSE-MsgGUID: 2s3G45f5ScmVl2tHhPm6HA==
X-IronPort-AV: E=Sophos;i="6.03,164,1694707200"; 
   d="scan'208";a="349818426"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Sep 2023 15:44:26 +0800
IronPort-SDR: IrhpCBDdBTVOU2Ck4ATeUMRN6AKUl7gF8kEroNGq6w7lWRONoGkucdaePRU8ozJZqQ2SESIxQs
 Ysx4QNqXnarPAr+SvepcocUigTy7A2A8Hvsewedcx4oowBgkrdPJD9rkpc398AeSzwJuq1N1qv
 d15k5W8P7PO6rsFKEFEWCuZAMVXjPtYxLGzR9fohcsM2Im1fpNQl5PO0zS2vqD/qA/iQ5rh6fm
 8fIzvtjIqUrQllFqaMzBa+vidPvihynI31sqGElE2SB1sqSFT6Vd2AC79caOj2mhI1Fz61Y1IL
 XTA=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Sep 2023 23:57:00 -0700
IronPort-SDR: eqOXOmvFIOlPWL/bj9AwcCpxqzkST0fz2jjI1FCfKOs7HR47zVrnteMiczJUc0yFI/FrF4I5Tu
 0le9t/oWTpoGKcUUHEiAyJlH3DB+eBCovTpLEHauQhM9PX1Bk5ecV8aihUw254fTx8Z+MUARz/
 k8pBX78nrEbgwaFaJnzaBSkIF9u+43fINukTm6irWX77qRxvJM0BoMdJXuUVKSinu6V6ob0G+V
 67cRSpf+0vJ1Kgd8oqA3akOb4pmpfguOZstoavpBANIEAtiHPUuurRLa1iHZM6TK+YZyndK7Ro
 Fhs=
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.94])
  by uls-op-cesaip01.wdc.com with ESMTP; 21 Sep 2023 00:44:22 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>,
        Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v3 1/2] btrfs/076: support smaller extent size limit
Date:   Thu, 21 Sep 2023 16:44:07 +0900
Message-ID: <1e344c6d594254f68430580019b6b76d5651428c.1695282094.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1695282094.git.naohiro.aota@wdc.com>
References: <cover.1695282094.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 tests/btrfs/076     | 23 +++++++++++++++++++++--
 tests/btrfs/076.out |  3 +--
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/tests/btrfs/076 b/tests/btrfs/076
index 89e9672d09e2..43dbff538278 100755
--- a/tests/btrfs/076
+++ b/tests/btrfs/076
@@ -28,13 +28,28 @@ _supported_fs btrfs
 _require_test
 _require_scratch
 
+# An extent size can be up to BTRFS_MAX_UNCOMPRESSED
+max_extent_size=$(( 128 * 1024 ))
+if _scratch_btrfs_is_zoned; then
+	zone_append_max=$(cat "/sys/block/$(_short_dev $SCRATCH_DEV)/queue/zone_append_max_bytes")
+	if [[ $zone_append_max -gt 0 && $zone_append_max -lt $max_extent_size ]]; then
+		# Round down to PAGE_SIZE
+		max_extent_size=$(( $zone_append_max / 4096 * 4096 ))
+	fi
+fi
+file_size=$(( 10 * 1024 * 1024 ))
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

