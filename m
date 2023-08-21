Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 390D37823CA
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Aug 2023 08:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233469AbjHUGhO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Aug 2023 02:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233456AbjHUGhN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Aug 2023 02:37:13 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176C3AC;
        Sun, 20 Aug 2023 23:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1692599831; x=1724135831;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DIRbr2XPDPI1DdxdkY2jF6TmEaYD7n7iiQAKN2jCW1U=;
  b=V4+IH7A4I/Hsq4zyvgvz6okxzEfAezP6ut0RH7/1y7T+dkeunyS8Wpuq
   tOAzGiJsZ0w1aRqwyHK68UZDVN17J5vDmaWygIFIecnmMcquujT4sYipW
   +/TgYzgbPNeZQOlxjXxB3IBRRcMdGhe2z7I/pAgt6bX4M+9OmErLfdy6T
   Wt9jTfoTZyIqeIAQRTNttmFsj8DajuXTRTY9DngihU5VOVFHFh4bwrd5U
   8kbcfg2tPrrzdXwgwYlxdLDOlp4llHgY7oq+JZT5GZbfibIR4gWvswwks
   3S4VBsIM/s6r/xZri7uAiwTEYswLxh60UADOJFnjktXsrN/iQEyEIs+s8
   A==;
X-IronPort-AV: E=Sophos;i="6.01,189,1684771200"; 
   d="scan'208";a="241991952"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Aug 2023 14:37:11 +0800
IronPort-SDR: lat7GHsd8FzLd7NbIqd3CzD57RaAns45q4N4IQDDdPUuWa6nVxkb6BfWOOmrXslvkEjpR5l7Nn
 2tvlVJgR/fxAr29qzr0rYhawdeL+JaDDnmGrhiM8gyzBBae9/xYI7xy/PFsc6fTxE0dJvzX4RM
 r6GZgzc2VDvPXknGO/YsaKDp0dqCIG3Fc3PbGz4byv8U2qE1SwhYMBQKBg4YEDKsq0b00QP4Xz
 SWhBQNDTbq8r7spIHWpxHSFwI+k7ov6F3sw/loc44DvcsEwhcVPckogT6JZ/4co6V5ozj6JWoa
 6VM=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Aug 2023 22:44:42 -0700
IronPort-SDR: rS9+34tp6t84Nz4FcCTp0AY8Uml3dJFKSnGuDnlicX1T7N1YSxsV4UWFbgKT1pQ8fsLkfbNkri
 m+bRu0gT0p2ntcxB2jcBvCgDL8bdlyBA08WLp5E7bnGb5NEJGvc/0hHxaTU2SINK/9Zm+YIY2S
 kWq0yO8zEjqcQcae9WKWO+5lGk558z2SBsmZEHw1XMYsb4Y1Ri3az6wTUIJJMCVPO6FDDkHLjg
 5RzsPXBGTKWUz2AlvDa4cfwOgBnDVlgC7p/vyKzhjvkCi0X6NVuofG2FlBhRdA/9gDQZPjEG7b
 MW0=
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.96])
  by uls-op-cesaip02.wdc.com with ESMTP; 20 Aug 2023 23:37:12 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 2/3] fstests/btrfs: use _random_file() helper
Date:   Mon, 21 Aug 2023 15:37:03 +0900
Message-ID: <9c0f4efcabbd3c4cfcd726910f7295d98115d66c.1692599767.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692599767.git.naohiro.aota@wdc.com>
References: <cover.1692599767.git.naohiro.aota@wdc.com>
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

Use _random_file() helper to choose a random file in a directory.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 tests/btrfs/179 |  4 ++--
 tests/btrfs/192 | 14 ++++----------
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/tests/btrfs/179 b/tests/btrfs/179
index 2f17c9f9fb4a..33a854d70401 100755
--- a/tests/btrfs/179
+++ b/tests/btrfs/179
@@ -45,7 +45,7 @@ fill_workload()
 
 		# Randomly remove some files for every 5 loop
 		if [ $(( $i % 5 )) -eq 0 ]; then
-			victim=$(ls "$SCRATCH_MNT/src" | sort -R | head -n1)
+			victim=$(_random_file "$SCRATCH_MNT/src")
 			rm "$SCRATCH_MNT/src/$victim"
 		fi
 		i=$((i + 1))
@@ -69,7 +69,7 @@ delete_workload()
 	trap "wait; exit" SIGTERM
 	while true; do
 		sleep $((sleep_time * 2))
-		victim=$(ls "$SCRATCH_MNT/snapshots" | sort -R | head -n1)
+		victim=$(_random_file "$SCRATCH_MNT/snapshots")
 		if [ -z "$victim" ]; then
 			# No snapshots available, sleep and retry later.
 			continue
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

