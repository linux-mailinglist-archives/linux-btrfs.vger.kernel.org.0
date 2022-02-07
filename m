Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4DB4AB453
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Feb 2022 07:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237533AbiBGFuv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Feb 2022 00:50:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350029AbiBGDLJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 6 Feb 2022 22:11:09 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A646BC061A73;
        Sun,  6 Feb 2022 19:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644203468; x=1675739468;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PmOAO/z/5SQRJrAaX0rjm1/SDaYQLCQkeqzLnW4Z6gk=;
  b=VnYCrlXHBj66mX6KLgmlIkWb5oiXbf/nz9JUSmtZ7lMSdsWKDAhTj7nH
   8c4yPvbI3cCh1amhjIXInc9qPeb+vESCNJbU++FXE6uAcIPysI51OQR1e
   d1Ve+YVq173dxM/di8qY+CaYW7wWmIA4Gwn+OiiD033qvGyO8fyArY275
   ahTVta9qgABDvE9S+WMWHyXS/12QvbHyxKaB+ljq17tekUbqhtscpYn/+
   hkk4Xh6gu0Wxu5LwW/nUMZVlXpe5ern7VRivHbOBKQtMyMS8anV6ELQEv
   Y2LSmUfF4UKUymWmlt53Vp9TRqDEO/XfI5h4C18xES/PXE+ake5Q5WGQR
   g==;
X-IronPort-AV: E=Sophos;i="5.88,348,1635177600"; 
   d="scan'208";a="304196004"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Feb 2022 11:10:05 +0800
IronPort-SDR: NOvly8AvOHwx0Lp4kDy7AFgREhST+tC/zzv3q7W2vit4qj+eh0xFDNDCV4GoJDrT+YG5fWtr4u
 aKBVyCe6V7jD4/qLPupjVYi+duYOzZCtnvUgQmtT4iylP8MTwJsJDsCrkmwV9f8At0DL4HUkYO
 MjBBTUu4nsGWVSAJdKHZM5LCh7d1/XSy6vGARpymD/macp7/5t3q23mRRG1lRA8u7+68PzpNt5
 URrrw+mcAeDHrW3u64NhoVy51553qPGGqpIG7ElCbvalxDr2foJpv7ZEjU5xOvofqjzRZ4bXZ4
 K2roiOI5CtB1PnUSPoNXA19Z
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2022 18:41:57 -0800
IronPort-SDR: y+FtjjJXOV8tZCikJPK5i2nH/1nKMjHT7ybJV+u3slTEU3e17ldTQDjwBM8cXLDCOn4HIV7dYs
 Y78DCMvPtVthMiAVNbVmMWuqdyRdIuva2kDIN3LDiqrS3bmAaVtqVZBZWGwnzgYlvVDb93ZHPq
 I8QeKy6zycHSp8wpNpFyi7lV9cH73RiiV3ZHrX6axpAgH7WgxN8wpg0Lrh6PnVzHQItaf6wVtp
 svUFCbv5uuUBzKIMiTWsKFHBkxjT8qq7PWONCrxUCQh6A0ueV02/8brxMn1uRp3WdINR/FPuTt
 IfM=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.173])
  by uls-op-cesaip01.wdc.com with ESMTP; 06 Feb 2022 19:10:05 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH 6/7] common: move _xfs_filter_mkfs from common/filter to common/xfs
Date:   Mon,  7 Feb 2022 12:09:57 +0900
Message-Id: <20220207030958.230618-7-shinichiro.kawasaki@wdc.com>
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

The helper function _xfs_filter_mkfs works only for xfs. Move it from
common/filter to common/xfs. Also remove useless lines for other
filesystems.

Suggested-by: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/filter | 53 ---------------------------------------------------
 common/xfs    | 43 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 53 deletions(-)

diff --git a/common/filter b/common/filter
index 24fd0650..7c71be4f 100644
--- a/common/filter
+++ b/common/filter
@@ -115,59 +115,6 @@ _filter_date()
 	-e 's/[A-Z][a-z][a-z] [A-z][a-z][a-z]  *[0-9][0-9]* [0-9][0-9]:[0-9][0-9]:[0-9][0-9] [0-9][0-9][0-9][0-9]$/DATE/'
 }
 
-# prints filtered output on stdout, values (use eval) on stderr
-# Non XFS filesystems always return a 4k block size and a 256 byte inode.
-_xfs_filter_mkfs()
-{
-    case $FSTYP in
-    xfs)
-	;;
-    *)
-	cat - >/dev/null
-	perl -e 'print STDERR "dbsize=4096\nisize=256\n"'
-	return ;;
-    esac
-
-    echo "_fs_has_crcs=0" >&2
-    set -
-    perl -ne '
-    if (/^meta-data=([\w,|\/.-]+)\s+isize=(\d+)\s+agcount=(\d+), agsize=(\d+) blks/) {
-	print STDERR "ddev=$1\nisize=$2\nagcount=$3\nagsize=$4\n";
-	print STDOUT "meta-data=DDEV isize=XXX agcount=N, agsize=XXX blks\n";
-    }
-    if (/^\s+=\s+sectsz=(\d+)\s+attr=(\d+)/) {
-        print STDERR "sectsz=$1\nattr=$2\n";
-    }
-    if (/^\s+=\s+crc=(\d)/) {
-        print STDERR "_fs_has_crcs=$1\n";
-    }
-    if (/^data\s+=\s+bsize=(\d+)\s+blocks=(\d+), imaxpct=(\d+)/) {
-	print STDERR "dbsize=$1\ndblocks=$2\nimaxpct=$3\n";
-	print STDOUT "data     = bsize=XXX blocks=XXX, imaxpct=PCT\n";
-    }
-    if (/^\s+=\s+sunit=(\d+)\s+swidth=(\d+) blks/) {
-        print STDERR "sunit=$1\nswidth=$2\nunwritten=1\n";
-	print STDOUT "         = sunit=XXX swidth=XXX, unwritten=X\n";
-    }
-    if (/^naming\s+=version\s+(\d+)\s+bsize=(\d+)/) {
-	print STDERR "dirversion=$1\ndirbsize=$2\n";
-	print STDOUT "naming   =VERN bsize=XXX\n";
-    }
-    if (/^log\s+=(internal log|[\w|\/.-]+)\s+bsize=(\d+)\s+blocks=(\d+),\s+version=(\d+)/ ||
-	/^log\s+=(internal log|[\w|\/.-]+)\s+bsize=(\d+)\s+blocks=(\d+)/) {
-	print STDERR "ldev=\"$1\"\nlbsize=$2\nlblocks=$3\nlversion=$4\n";
-	print STDOUT "log      =LDEV bsize=XXX blocks=XXX\n";
-    }
-    if (/^\s+=\s+sectsz=(\d+)\s+sunit=(\d+) blks/) {
-	print STDERR "logsectsz=$1\nlogsunit=$2\n\n";
-    }
-    if (/^realtime\s+=([\w|\/.-]+)\s+extsz=(\d+)\s+blocks=(\d+), rtextents=(\d+)/) {
-	print STDERR "rtdev=$1\nrtextsz=$2\nrtblocks=$3\nrtextents=$4\n";
-	print STDOUT "realtime =RDEV extsz=XXX blocks=XXX, rtextents=XXX\n";
-    }'
-}
-
-
 # prints the bits we care about in growfs
 # 
 _filter_growfs()
diff --git a/common/xfs b/common/xfs
index 3435c706..a3da25dd 100644
--- a/common/xfs
+++ b/common/xfs
@@ -1275,3 +1275,46 @@ _require_scratch_xfs_bigtime()
 		_notrun "bigtime feature not advertised on mount?"
 	_scratch_unmount
 }
+
+# prints filtered output on stdout, values (use eval) on stderr
+# Non XFS filesystems always return a 4k block size and a 256 byte inode.
+_xfs_filter_mkfs()
+{
+    echo "_fs_has_crcs=0" >&2
+    set -
+    perl -ne '
+    if (/^meta-data=([\w,|\/.-]+)\s+isize=(\d+)\s+agcount=(\d+), agsize=(\d+) blks/) {
+	print STDERR "ddev=$1\nisize=$2\nagcount=$3\nagsize=$4\n";
+	print STDOUT "meta-data=DDEV isize=XXX agcount=N, agsize=XXX blks\n";
+    }
+    if (/^\s+=\s+sectsz=(\d+)\s+attr=(\d+)/) {
+        print STDERR "sectsz=$1\nattr=$2\n";
+    }
+    if (/^\s+=\s+crc=(\d)/) {
+        print STDERR "_fs_has_crcs=$1\n";
+    }
+    if (/^data\s+=\s+bsize=(\d+)\s+blocks=(\d+), imaxpct=(\d+)/) {
+	print STDERR "dbsize=$1\ndblocks=$2\nimaxpct=$3\n";
+	print STDOUT "data     = bsize=XXX blocks=XXX, imaxpct=PCT\n";
+    }
+    if (/^\s+=\s+sunit=(\d+)\s+swidth=(\d+) blks/) {
+        print STDERR "sunit=$1\nswidth=$2\nunwritten=1\n";
+	print STDOUT "         = sunit=XXX swidth=XXX, unwritten=X\n";
+    }
+    if (/^naming\s+=version\s+(\d+)\s+bsize=(\d+)/) {
+	print STDERR "dirversion=$1\ndirbsize=$2\n";
+	print STDOUT "naming   =VERN bsize=XXX\n";
+    }
+    if (/^log\s+=(internal log|[\w|\/.-]+)\s+bsize=(\d+)\s+blocks=(\d+),\s+version=(\d+)/ ||
+	/^log\s+=(internal log|[\w|\/.-]+)\s+bsize=(\d+)\s+blocks=(\d+)/) {
+	print STDERR "ldev=\"$1\"\nlbsize=$2\nlblocks=$3\nlversion=$4\n";
+	print STDOUT "log      =LDEV bsize=XXX blocks=XXX\n";
+    }
+    if (/^\s+=\s+sectsz=(\d+)\s+sunit=(\d+) blks/) {
+	print STDERR "logsectsz=$1\nlogsunit=$2\n\n";
+    }
+    if (/^realtime\s+=([\w|\/.-]+)\s+extsz=(\d+)\s+blocks=(\d+), rtextents=(\d+)/) {
+	print STDERR "rtdev=$1\nrtextsz=$2\nrtblocks=$3\nrtextents=$4\n";
+	print STDOUT "realtime =RDEV extsz=XXX blocks=XXX, rtextents=XXX\n";
+    }'
+}
-- 
2.34.1

