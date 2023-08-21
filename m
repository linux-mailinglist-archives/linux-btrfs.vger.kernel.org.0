Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB3B7823C8
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Aug 2023 08:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233455AbjHUGhN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Aug 2023 02:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjHUGhN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Aug 2023 02:37:13 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1BCAB;
        Sun, 20 Aug 2023 23:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1692599831; x=1724135831;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rhV3HXwgsDIqHBdHBS2K2HmQpdMw41VPG9k19oglC8M=;
  b=fhr6hfb5KdMPnt3awZEXRfzLc6Be6CDTBaThBOWdF3XL3/ub7pBWfzS0
   gaPVloT0WpHnE0ndmkFMhOADu/Rc1PZ6lKZQmYn57kx2wdMgqGIE/rzjT
   OaZm0UyhFNICDlRp64kSsJ4vx2VW/sbWJZkK63xb0lG8UBPYGkXqXg2iG
   Et02LgLYfX97f8uDItq2ltCAfLVukpbmsJKmJvdsLDsZTUyIQzF5DPHiY
   OWeuuGnabWuveAb2W1kNOrsEllWPUymdQcn8bUaeORaZDvpk5SvNTnQbU
   bK55Jl7To1Cf92T+vLhe1Fg2yePzwVGNnZA43FkbwMoZFLKCKT160tTq8
   w==;
X-IronPort-AV: E=Sophos;i="6.01,189,1684771200"; 
   d="scan'208";a="241991951"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Aug 2023 14:37:10 +0800
IronPort-SDR: kKH9Tz2kdpgPxPBrgjY+0fwRBqSWLxHS6gZqQKBRey8XRax1jgu4QyNZhrv7aAgwBcLqONP55J
 PdbgyRmwTQr8kWt7ts2NUfa/dOXQrh1gnR+0WbmM2PLQWCaNt7SsyrHvB6OJaVCMuXMXC4Spfo
 509NrxetN6WGMWdOXm7V2dPeBNgfEY0evrR4cPyrPgsQ7rNKzYIn7UGicuGSzBqhhCcbDV8hqW
 kB16D0tsfOS+ALqjWiHhHdNFC3Gp+U0GSLVPEYPjgxtFfY0HYKFYnyjk9OnfTIjSWwR2XWZLyC
 66A=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Aug 2023 22:44:42 -0700
IronPort-SDR: 3UgSJsiqSUVUIIi54+djIIlXXN5uyQZypysH+PrUV/ye7dQXFxRQZO8HyMkCNGWr4l4uXqxTUx
 21T+LrOOznluzRtISlADbDoR6mIgwNw4hUkUkOrvJWiwYqRn4mpAmOj2fiA45fK5ctpURGIPd6
 InQoyQkXyz3Lp34xe+sXukdHdAeel1zOXpv/8SdwGD/3R8+jDmn8gBXgzWA/moIgC2KY+276rn
 LYm5YYniMGSXSWb231iIFf6YE/HDIlvg6sElSRV9VIFI+RkOa5vciqZTeVwu3r5+CzdCzpcXTY
 WYA=
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.96])
  by uls-op-cesaip02.wdc.com with ESMTP; 20 Aug 2023 23:37:11 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 1/3] common/rc: introduce _random_file() helper
Date:   Mon, 21 Aug 2023 15:37:02 +0900
Message-ID: <d09150926fa51618e7c75206c38809a1bc01b4b9.1692599767.git.naohiro.aota@wdc.com>
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

Currently, we use "ls ... | sort -R | head -n1" (or tail) to choose a
random file in a directory.It sorts the files with "ls", sort it randomly
and pick the first line, which wastes the "ls" sort.

Also, using "sort -R | head -n1" is inefficient. For example, in a
directory with 1000000 files, it takes more than 15 seconds to pick a file.

  $ time bash -c "ls -U | sort -R | head -n 1 >/dev/null"
  bash -c "ls -U | sort -R | head -n 1 >/dev/null"  15.38s user 0.14s system 99% cpu 15.536 total

  $ time bash -c "ls -U | shuf -n 1 >/dev/null"
  bash -c "ls -U | shuf -n 1 >/dev/null"  0.30s user 0.12s system 138% cpu 0.306 total

So, we should just use "ls -U" and "shuf -n 1" to choose a random file.
Introduce _random_file() helper to do it properly.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 common/rc | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/common/rc b/common/rc
index 5c4429ed0425..2bdda30f497a 100644
--- a/common/rc
+++ b/common/rc
@@ -5224,6 +5224,13 @@ _soak_loop_running() {
 	return 0
 }
 
+# Return a random file in a directory. A directory is *not* followed
+# recursively.
+_random_file() {
+	local basedir=$1
+	ls -U "${basedir}" | shuf -n 1
+}
+
 init_rc
 
 ################################################################################
-- 
2.41.0

