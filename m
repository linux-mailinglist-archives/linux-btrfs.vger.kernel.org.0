Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BAF678242E
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Aug 2023 09:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233587AbjHUHM0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Aug 2023 03:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233581AbjHUHMZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Aug 2023 03:12:25 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2568A6;
        Mon, 21 Aug 2023 00:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1692601943; x=1724137943;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=41kPPZjjFolf8SA9/UNorN8o9mA62M/N2jXmO6IkmdI=;
  b=Q3C/x5Y2SRDGTwORpuETwOUl4zAHLLVy0cuSgR4asGGWNbwYIYlbX9sa
   hwkIB1samOgp8YJm4cHxeujkyXZxnjx6rDVcYDz8O6LSlVGzeznMpaU2e
   CjgNVVl4nzYvMH+N6UHxJ/puKGAGZ1G539exyvvFfiT40S5HbbchfqVJ8
   H/EPgVNC84Zvo9KDpd+LRpjNpN09TvCFdBBgFuVzxKMrChjc8p3h+oZZu
   qE0L6am6hUsof99CT2VDyCWRiO0T4KF4Vqd062lnNA275lzelq50VMPg6
   WME1wvJmRWcjimI2XXdMTxyKLS5cTZSEaLu8NhSrvnBABy5jesjwbFGBf
   A==;
X-IronPort-AV: E=Sophos;i="6.01,189,1684771200"; 
   d="scan'208";a="246252748"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Aug 2023 15:12:21 +0800
IronPort-SDR: k59LrgnCLCtU90jSykBA8ufVufio8p7xUwbg5eWPuA9Pg2N/HRMJxBL2l75clnsNg1lGHtzYAo
 7j82P/DILKP1kIWU0Tec/spKGDQbvnCr+ZAqaC+yfESyS0vAqoOxEqfWHeCkwYeOEzrmnojneL
 bVigSsWGViDTlHz7rzgV1C/A/zfS19unot7Z10thfT/W+pIx6Rg70E89t4Ojv1FEbqwhm+1Zwd
 ody4I0lKKNZT8uZzxWkH/CtVC7t0SyXqk2svGeEwgR2Nan9LC1HNCeU3R0oRbiSh0XvNzDYGIA
 kkI=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Aug 2023 23:25:33 -0700
IronPort-SDR: /OtakJ7Pg0u2Qqw48W4aXUkoAPAAcMcS4jGIUinkpi2Chp4bSsLI7g3yPWnX5DEOUPF2CoUc0A
 lZ2FZQOc9c7vgdiiC2iZnuHLUOlv5rvxHWSaUzozd7v1wxeiwome4XjiatyZQEpeyoqpCB3fg9
 kLa1+MVgvO8x5yJlzUFcvFN/WAn4FeM68jtu+09ufnQoDAEz/WXOr8bZPrxekmrpoeNerPUSf/
 7UE3lCXmEljryZCFFgR24LgM4Oy2BdtU2huNobIMRapC/QyRNCJIvPNTBsn/WAgThHFbIcG5qh
 L6s=
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.96])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Aug 2023 00:12:20 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 2/3] fstests/btrfs: use _random_file() helper
Date:   Mon, 21 Aug 2023 16:12:12 +0900
Message-ID: <e0a85c48d589623e04272804bd7c721c14722f73.1692600259.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692600259.git.naohiro.aota@wdc.com>
References: <cover.1692600259.git.naohiro.aota@wdc.com>
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

Use _random_file() helper to choose a random file in a directory.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 tests/btrfs/179 |  9 ++++-----
 tests/btrfs/192 | 14 ++++----------
 2 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/tests/btrfs/179 b/tests/btrfs/179
index 2f17c9f9fb4a..479667f05fd2 100755
--- a/tests/btrfs/179
+++ b/tests/btrfs/179
@@ -45,8 +45,8 @@ fill_workload()
 
 		# Randomly remove some files for every 5 loop
 		if [ $(( $i % 5 )) -eq 0 ]; then
-			victim=$(ls "$SCRATCH_MNT/src" | sort -R | head -n1)
-			rm "$SCRATCH_MNT/src/$victim"
+			victim=$(_random_file "$SCRATCH_MNT/src")
+			rm "$victim"
 		fi
 		i=$((i + 1))
 	done
@@ -69,13 +69,12 @@ delete_workload()
 	trap "wait; exit" SIGTERM
 	while true; do
 		sleep $((sleep_time * 2))
-		victim=$(ls "$SCRATCH_MNT/snapshots" | sort -R | head -n1)
+		victim=$(_random_file "$SCRATCH_MNT/snapshots")
 		if [ -z "$victim" ]; then
 			# No snapshots available, sleep and retry later.
 			continue
 		fi
-		$BTRFS_UTIL_PROG subvolume delete \
-			"$SCRATCH_MNT/snapshots/$victim" > /dev/null
+		$BTRFS_UTIL_PROG subvolume delete "$victim" > /dev/null
 	done
 }
 
diff --git a/tests/btrfs/192 b/tests/btrfs/192
index bcf14ebb8e3b..7324c9e39833 100755
--- a/tests/btrfs/192
+++ b/tests/btrfs/192
@@ -69,12 +69,6 @@ $BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/src > /dev/null
 mkdir -p $SCRATCH_MNT/snapshots
 mkdir -p $SCRATCH_MNT/src/padding
 
-random_file()
-{
-	local basedir=$1
-	echo "$basedir/$(ls $basedir | sort -R | tail -1)"
-}
-
 snapshot_workload()
 {
 	trap "wait; exit" SIGTERM
@@ -85,9 +79,9 @@ snapshot_workload()
 			$SCRATCH_MNT/src $SCRATCH_MNT/snapshots/$i \
 			> /dev/null
 		# Do something small to make snapshots different
-		rm -f "$(random_file $SCRATCH_MNT/src/padding)"
-		rm -f "$(random_file $SCRATCH_MNT/src/padding)"
-		touch "$(random_file $SCRATCH_MNT/src/padding)"
+		rm -f "$(_random_file $SCRATCH_MNT/src/padding)"
+		rm -f "$(_random_file $SCRATCH_MNT/src/padding)"
+		touch "$(_random_file $SCRATCH_MNT/src/padding)"
 		touch "$SCRATCH_MNT/src/padding/random_$RANDOM"
 
 		i=$(($i + 1))
@@ -102,7 +96,7 @@ delete_workload()
 	while true; do
 		sleep 2
 		$BTRFS_UTIL_PROG subvolume delete \
-			"$(random_file $SCRATCH_MNT/snapshots)" \
+			"$(_random_file $SCRATCH_MNT/snapshots)" \
 			> /dev/null 2>&1
 	done
 }
-- 
2.41.0

