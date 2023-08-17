Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0381077F02A
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Aug 2023 07:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348015AbjHQFNv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Aug 2023 01:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347999AbjHQFNV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Aug 2023 01:13:21 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0AB2705;
        Wed, 16 Aug 2023 22:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1692249200; x=1723785200;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZjmAYFKU2zWauoj7RfkAmXDrFLV8bHJn6Qjr0Z1ghNA=;
  b=XTlX2fttiQ7HQ19f4F6AQ2gdfvPPMd6QCPt8H/xUbC2VXXaGW4YtdhUO
   pgP3mOkvq0pP5JKk5ooINAHz8L4oGGFHe97AEFcKpYhxU90IXg/0m7Pbp
   e7gSJ0h6amRkAuxE2ysOhdwaLX7pHVoHxHgWXrIMARCKgiiIpIWIl4Fbt
   sh3XsFo+pXEZJoVT+Bz/fwZnSqCbFBfjhH2TPncxyuzFeJWt0nx7tPngC
   zV+VlI83I1ajQU51mc/9M6RR+5BPYb8JSMLlZFANmJx6irlCupSfdxSM9
   xw75Qz+cactTzE8B0ImuIrNE6LFBOOxq47Gea9bG9z2qCdasAo8IEohYG
   w==;
X-IronPort-AV: E=Sophos;i="6.01,179,1684771200"; 
   d="scan'208";a="239607390"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 17 Aug 2023 13:13:19 +0800
IronPort-SDR: zmTc2l+YOcd/ls1r2ZXnADltVqLWieovgeoHhPnfHWIz9B/WiQnoLdCQhqLI0vpENXJd9Mk1Pt
 n/+rniUzkwWJKO134IeL7SFMmYUSo0pAAoSNQmF6pQlR9Q5mBlVlnQDNn+khDQImSXiZ9NsQr2
 LbKjEHHlEd7i7rf+jPyNmdj6uDHlMbBj/+tNndZXwiaW7QhnfBWX3gLjUZ9ZJ1BDKmdlgQsf4T
 w0c4rPExhi73tq7zKYYgUwYolmcNUmNpHwAXV+gntN3eWYVTIo/re6ozJW8vm6AsuBl6dSqS1J
 VwA=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Aug 2023 21:20:55 -0700
IronPort-SDR: JeERcgGQn+svmc1Zj1hNqVZjC9Af/gvkJznbyMFcD20QyW0UUhp/Q+n1huxA3Km5TO6Y8m9iEC
 yxa3cTyi8y16YFapHIncqR1OcSfoq62CztVQX8dsj8Pczo9ZFf98NyT5OYaZiTwIXwy2a180ae
 hii0yU/bZ9b1KZ0zTmqUBHWmHJpK/Bb/CCyXzSYcPDiXArgymBk5BtEZjRNjiCES8JyWqK2DzZ
 FFzodHew8RijOmvVYPweWX/UcT5C1rVfJ/QhD61KIuYaeXmQBYeICCBQtWqDcS63vx02pPKZNQ
 82U=
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.88])
  by uls-op-cesaip01.wdc.com with ESMTP; 16 Aug 2023 22:13:20 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] btrfs/179: optimize remove file selection
Date:   Thu, 17 Aug 2023 14:13:17 +0900
Message-ID: <20230817051317.3825299-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.41.0
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

Currently, we use "ls ... | sort -R | head -n1" to choose a removing
victim. It sorts the files with "ls", sort it randomly and pick the first
line, which wastes the "ls" sort.

Also, using "sort -R | head -n1" is inefficient. For example, in a
directory with 1000000 files, it takes more than 15 seconds to pick a file.

  $ time bash -c "ls -U | sort -R | head -n 1 >/dev/null"
  bash -c "ls -U | sort -R | head -n 1 >/dev/null"  15.38s user 0.14s system 99% cpu 15.536 total

  $ time bash -c "ls -U | shuf -n 1 >/dev/null"
  bash -c "ls -U | shuf -n 1 >/dev/null"  0.30s user 0.12s system 138% cpu 0.306 total

So, just use "ls -U" and "shuf -n 1" to choose a victim.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 tests/btrfs/179 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/btrfs/179 b/tests/btrfs/179
index 2f17c9f9fb4a..0fbd875cf01b 100755
--- a/tests/btrfs/179
+++ b/tests/btrfs/179
@@ -45,7 +45,7 @@ fill_workload()
 
 		# Randomly remove some files for every 5 loop
 		if [ $(( $i % 5 )) -eq 0 ]; then
-			victim=$(ls "$SCRATCH_MNT/src" | sort -R | head -n1)
+			victim=$(ls -U "$SCRATCH_MNT/src" | shuf -n 1)
 			rm "$SCRATCH_MNT/src/$victim"
 		fi
 		i=$((i + 1))
-- 
2.41.0

