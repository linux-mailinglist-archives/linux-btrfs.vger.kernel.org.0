Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418074AB447
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Feb 2022 07:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237058AbiBGFuv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Feb 2022 00:50:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350030AbiBGDLK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 6 Feb 2022 22:11:10 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A75C061A73;
        Sun,  6 Feb 2022 19:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644203469; x=1675739469;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=78Zs28KpKxQ8bPUPZ5jK1PRmnWo6oej03te2uWqoGL8=;
  b=PZF7QaA30zZQyfJW87dihb28uHEKpHwzuvhbjxTqI5PibiuV2vb3awYR
   cLrQWDKo5MiaRx0yNky3fPtiVjAHkpcuASBU/FZdV5nUVlw26xL+S5uNN
   uvAU0b6rGGd6pnDi4/wljNaK9IX1W0g6uhzLD062CaJyp3030gxpOW3bY
   g/f2eRX+R7Sr2a2BZJPyRDNer2jrdUDeXh5227FZRo0VNaQTQurxd6MGY
   j8pCqVZc5XrSymlUMUxgtlPjn0fJ9H1d5HLGWtTjyNUVxsOgHGT4/+Oij
   576/OOjpwx0wPKbr7eAm6toYFQoFQu+nfSB9uw3FFSkQEnnkS4CiW/iAr
   g==;
X-IronPort-AV: E=Sophos;i="5.88,348,1635177600"; 
   d="scan'208";a="304196008"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Feb 2022 11:10:07 +0800
IronPort-SDR: 7iDGEH0L929p0tZV/jztdzJE9bGKXzLcz2gZ2B6Sl23BJJeHEiLXjxN/ZA4WfMe36hAGXI4LhK
 pYhvmPvjkkDd6YXtrCDaNS49bedWUw0z6tWwoqJQoHARrF5U10Bt1oMkrWml/fYSC5lSnMgFxQ
 zmQbksiDIr40VN3cx278BPQTBKFPMRR7XhVXoCJupUP+Tf3N22xijC1ZGQXkLJlPay6nzFZ10D
 MGT1bWU3fH79Kes3IHxesvDvdMAfpbVft7/VhXJRnqji29Za73m9il0PbfxFPJY2PyNSdLR2ia
 Y3+yHlKDS6bAu5Yjr8/ehhYA
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2022 18:41:58 -0800
IronPort-SDR: sfiKrR+rVbdQfys4Bir2TjDK7Yea21y0Qclmn1kaarOfo6+/pwgc1U2K4DmzeTxexTXueRU1UI
 IXBuBf6RulRY7HiDEb3MRzzhyI93VA+vynCnftlDW0ddkPi90ki7kg29lnVFsv6Ydck1H18FQi
 VKApRk/uqmDS8D1ohuj9n59oLtwNbcoBu7zaP81RAm+5wwp3pPrt3EWoN8QJqFhS87+t66TIw3
 r57NHP35BFODmDxQ8HfEjLFWYbura8VHn+n+mGEw6YckVPupYcOPrxTNsAo6r+UKGc88vitERK
 sD4=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.173])
  by uls-op-cesaip01.wdc.com with ESMTP; 06 Feb 2022 19:10:06 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH 7/7] generic/204: do xfs unique preparation only for xfs
Date:   Mon,  7 Feb 2022 12:09:58 +0900
Message-Id: <20220207030958.230618-8-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220207030958.230618-1-shinichiro.kawasaki@wdc.com>
References: <20220207030958.230618-1-shinichiro.kawasaki@wdc.com>
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

The test case generic/204 formats the scratch device to get block size
as a part of preparation. However, this preparation is required only for
xfs. To simplify preparation for other filesystems, do the preparation
only for xfs.

Suggested-by: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/generic/204 | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/tests/generic/204 b/tests/generic/204
index 40d524d1..ea267760 100755
--- a/tests/generic/204
+++ b/tests/generic/204
@@ -16,17 +16,18 @@ _cleanup()
 	sync
 }
 
-# Import common functions.
-. ./common/filter
-
 # real QA test starts here
 _supported_fs generic
 
 _require_scratch
 
-# get the block size first
-_scratch_mkfs 2> /dev/null | _xfs_filter_mkfs 2> $tmp.mkfs > /dev/null
-. $tmp.mkfs
+dbsize=4096
+isize=256
+if [ $FSTYP = "xfs" ]; then
+	# get the block size first
+	_scratch_mkfs 2> /dev/null | _xfs_filter_mkfs 2> $tmp.mkfs > /dev/null
+	. $tmp.mkfs
+fi
 
 # For xfs, we need to handle the different default log sizes that different
 # versions of mkfs create. All should be valid with a 16MB log, so use that.
@@ -37,11 +38,15 @@ _scratch_mkfs 2> /dev/null | _xfs_filter_mkfs 2> $tmp.mkfs > /dev/null
 SIZE=`expr 115 \* 1024 \* 1024`
 _scratch_mkfs_sized $SIZE $dbsize 2> /dev/null > $tmp.mkfs.raw \
 	|| _fail "mkfs failed"
-cat $tmp.mkfs.raw | _xfs_filter_mkfs 2> $tmp.mkfs > /dev/null
+
+if [ $FSTYP = "xfs" ]; then
+	cat $tmp.mkfs.raw | _xfs_filter_mkfs 2> $tmp.mkfs > /dev/null
+	# Source $tmp.mkfs to get geometry
+	. $tmp.mkfs
+fi
+
 _scratch_mount
 
-# Source $tmp.mkfs to get geometry
-. $tmp.mkfs
 
 # fix the reserve block pool to a known size so that the enospc calculations
 # work out correctly. Space usages is based 22500 files and 1024 reserved blocks
-- 
2.34.1

