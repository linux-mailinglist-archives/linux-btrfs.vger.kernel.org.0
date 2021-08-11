Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4583E9452
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Aug 2021 17:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbhHKPNZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Aug 2021 11:13:25 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:39981 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232921AbhHKPNV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Aug 2021 11:13:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628694776; x=1660230776;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TfvYiMrnoZ579dEjGtscwbhq2lVPTyI4PUfkdTSCiZs=;
  b=aNIIDaeiNcnEmHPBHWVDYELCK6z6wQQCfPmB7udcqrPFb1+EepbcFVlc
   K9J3rvbKOxR5V4M0Iy9Pd7Iwjm7yu4PQQtxT9votUU6Vum70FyEydDLWO
   QxI+CgaBJ04w20zLN3IOnEN/47AoK4dX2pXzBBC0q42qQHMD30O6f3iG0
   wO65vj1ysuV4Zc1tqJl0APADFceio974eJqDn+OBaX7uEigbzicELD7Ud
   XkQadDtXFoyu06Et/tn73yKjW+BxgV8YU0maIsBdPbMHFUIf1STxUWf/O
   QEf2xpJXSEwUa2B4xNN4Zm+y/Vrb4D8i6fFSDxk14lP1flmGqV7PBzHyg
   w==;
X-IronPort-AV: E=Sophos;i="5.84,313,1620662400"; 
   d="scan'208";a="176942560"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2021 23:12:56 +0800
IronPort-SDR: xcC1hnV5lr3Pbqap7CBxoU2dyMMixg9QqToGTeyAxd38s0hB1fhjwPBmNw/FrN0NNpKSD7LflK
 2IS3X1+BfVM2eGGJc4vbN2J0UpSa8QlZVlUb+bOBcguzmpK5Lp6Nxbfv9+lsHd3WOxzOce4CLj
 rbclT8l5AIMVERysBzCXqtvEJfdIcinm3/8elNlRUN49t/chfElTMVbhDclCbxVzx//nViecOM
 UkPR6yklWAL+j5hRf9FQ1pS1uJ7orX2q8CG0f23PfGf8sLhzlRtvP1hpO3dgRo+YDq5LzKDaqa
 AHmakmog09oUk6TottGk7XCR
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2021 07:48:27 -0700
IronPort-SDR: s6mPkrgmK5eb0l2mZ/MDZtFM7A1xjY/14X0My/tGhE4GcFewNEhkRqfDKPKeLfO0ZV4s2XU0D5
 t7Uhp7+E3LdQkD4795J1DEqbrI2Dy6kN/QrI9Nr46BdBtmg4GpHFkgWxdk/7urAwvobNxrvcdT
 E+42eydgw5UF5UAT9xBqqM99mHwH3C4kRqb0twpbUCXv8IZqhLZ2qE7JAnjngDd1pYQyR3zh05
 XS7ldyl8pCDnqIdms/Awy64jew9WcSsiG9mssLNdw2TtNkyPXKADKDlwLFlb0zU9Og+FTds1SB
 fwM=
WDCIronportException: Internal
Received: from ffs5zf2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.58.251])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Aug 2021 08:12:57 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 2/8] common/rc: fix blocksize detection for btrfs
Date:   Thu, 12 Aug 2021 00:12:26 +0900
Message-Id: <20210811151232.3713733-3-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210811151232.3713733-1-naohiro.aota@wdc.com>
References: <20210811151232.3713733-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Mkfs.btrfs's "-b" does not specify the block size but the file system size.
Use "-s" to detect it instead.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 common/rc | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 4cb062e2fd3f..7b80820ff680 100644
--- a/common/rc
+++ b/common/rc
@@ -978,7 +978,10 @@ _scratch_mkfs_sized()
 	xfs)
 		def_blksz=`echo $MKFS_OPTIONS | sed -rn 's/.*-b ?size= ?+([0-9]+).*/\1/p'`
 		;;
-	ext2|ext3|ext4|ext4dev|udf|btrfs|reiser4|ocfs2|reiserfs)
+	btrfs)
+		def_blksz=`echo $MKFS_OPTIONS | sed -rn 's/.*-s ?+([0-9]+).*/\1/p'`
+		;;
+	ext2|ext3|ext4|ext4dev|udf|reiser4|ocfs2|reiserfs)
 		def_blksz=`echo $MKFS_OPTIONS | sed -rn 's/.*-b ?+([0-9]+).*/\1/p'`
 		;;
 	jfs)
-- 
2.32.0

