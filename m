Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60E964AB44A
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Feb 2022 07:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238901AbiBGFuz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Feb 2022 00:50:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350017AbiBGDLF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 6 Feb 2022 22:11:05 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB39CC043182;
        Sun,  6 Feb 2022 19:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644203464; x=1675739464;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d4ENreMGrlKCk5cIjSx96VRXwooXyBj4UXgKGLLw7K0=;
  b=EqWQ53yvJfOAnBCqwOF7PKxbDSh01WdKIwiguaE4qDM/yHah+MSSyd+V
   5sRvC/fRl3L1QZgoj0Gxt0bRFkrDWIFMg/EBON+7GEnuFdO90yjfPaOyk
   STVVZ4/uIoyjwXfY1qeP5nWsElACRzyLqZiGKthslw9lIEvduVXIaDNXj
   qWJEDlG94d6kYxZeW+Euvj3r2ci/Vtb3yTcJcO38St+gGOSZey/Bt/uHZ
   H8org0MeoiQQjdJy3zhWWN2LjtogRmtwK0WFXIKyriYZAh0wxEIikKVb2
   82ld5mhfmWikD2DdQgUiuZcqoYiEkuWq2ne5EYzJpXSxpxvcsnVzf213R
   g==;
X-IronPort-AV: E=Sophos;i="5.88,348,1635177600"; 
   d="scan'208";a="304195994"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Feb 2022 11:10:01 +0800
IronPort-SDR: RL810I30BNe3WiresMEiSl33WzDL5gRdjuEXuL2kR7dJB+Mxkzs+FaIVNUl4K0pCpd4b4o+yo3
 6HjqQPiveJlF9M0BxanTB+2QA9o2zdRrDISO230YXq24gRvEM8NLAAa73MmlzDNOp/x7fluM5G
 o6Z8BwcKhfnc2VL2XuU/MkMPBooi1vY1X0iSuw5L9xVAwpZdeVFpt2h0loJTbXlMnedmwu1+2s
 AVGNx4YwwiaxpP8/L3xm8gkfd1Mwtdu2W7UKRSZ93i08tiykkYleqTosax3tBmjn1YaMw+N+qW
 UqRMvYgzanK/0ckPuooYZ/U0
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2022 18:41:52 -0800
IronPort-SDR: pbefs6HvWwLjbbNkxCYc26fmPzlaz5kZ6pE3RMjbiUypbErEzDlLiAbA1NSbQ4oEYhKS0UyXa0
 5V76FmWVC1o8LfamlQr/pblChQJuWfBK4n4SbVgKpYrOvJk+T2OahaX/LG/JWaOmn/F3qjxnom
 vx6+vDqNaEQ8uTjiqZ31XLQYK00JpQwa4q7VGzHlLdjbtqJZJnwixeBf3cf0tyaxDsqNPIMQz8
 FqEpmUzrmUDfYYk4apHmWr8Q5aD3vq/Y72HNo9GsBWGMeL/m9hdDb8oPjfYLjJx0w3qHIt6Vcd
 jZQ=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.173])
  by uls-op-cesaip01.wdc.com with ESMTP; 06 Feb 2022 19:10:00 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH 2/7] generic/{171,172,173,174,204}: check _scratch_mkfs_sized return code
Date:   Mon,  7 Feb 2022 12:09:53 +0900
Message-Id: <20220207030958.230618-3-shinichiro.kawasaki@wdc.com>
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

The test cases generic/{171,172,173,174,204} call _scratch_mkfs before
_scratch_mkfs_sized, and they do not check return code of
_scratch_mkfs_sized. Even if _scratch_mkfs_sized failed, _scratch_mount
after it cannot detect the sized mkfs failure because _scratch_mkfs
already created a file system on the device. This results in unexpected
test condition of the test cases.

To avoid the unexpected test condition, check return code of
_scratch_mkfs_sized in the test cases.

Suggested-by: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/generic/171 | 2 +-
 tests/generic/172 | 2 +-
 tests/generic/173 | 2 +-
 tests/generic/174 | 2 +-
 tests/generic/204 | 3 ++-
 5 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/tests/generic/171 b/tests/generic/171
index fb2a6f14..f823a454 100755
--- a/tests/generic/171
+++ b/tests/generic/171
@@ -42,7 +42,7 @@ sz_bytes=$((nr_blks * 8 * blksz))
 if [ $sz_bytes -lt $((32 * 1048576)) ]; then
 	sz_bytes=$((32 * 1048576))
 fi
-_scratch_mkfs_sized $sz_bytes >> $seqres.full 2>&1
+_scratch_mkfs_sized $sz_bytes >> $seqres.full 2>&1 || _fail "mkfs failed"
 _scratch_mount >> $seqres.full 2>&1
 rm -rf $testdir
 mkdir $testdir
diff --git a/tests/generic/172 b/tests/generic/172
index ab5122fa..383824b9 100755
--- a/tests/generic/172
+++ b/tests/generic/172
@@ -40,7 +40,7 @@ umount $SCRATCH_MNT
 
 file_size=$((768 * 1024 * 1024))
 fs_size=$((1024 * 1024 * 1024))
-_scratch_mkfs_sized $fs_size >> $seqres.full 2>&1
+_scratch_mkfs_sized $fs_size >> $seqres.full 2>&1 || _fail "mkfs failed"
 _scratch_mount >> $seqres.full 2>&1
 rm -rf $testdir
 mkdir $testdir
diff --git a/tests/generic/173 b/tests/generic/173
index 0eb313e2..e1493278 100755
--- a/tests/generic/173
+++ b/tests/generic/173
@@ -42,7 +42,7 @@ sz_bytes=$((nr_blks * 8 * blksz))
 if [ $sz_bytes -lt $((32 * 1048576)) ]; then
 	sz_bytes=$((32 * 1048576))
 fi
-_scratch_mkfs_sized $sz_bytes >> $seqres.full 2>&1
+_scratch_mkfs_sized $sz_bytes >> $seqres.full 2>&1 || _fail "mkfs failed"
 _scratch_mount >> $seqres.full 2>&1
 rm -rf $testdir
 mkdir $testdir
diff --git a/tests/generic/174 b/tests/generic/174
index 1505453e..c7a177b8 100755
--- a/tests/generic/174
+++ b/tests/generic/174
@@ -43,7 +43,7 @@ sz_bytes=$((nr_blks * 8 * blksz))
 if [ $sz_bytes -lt $((32 * 1048576)) ]; then
 	sz_bytes=$((32 * 1048576))
 fi
-_scratch_mkfs_sized $sz_bytes >> $seqres.full 2>&1
+_scratch_mkfs_sized $sz_bytes >> $seqres.full 2>&1 || _fail "mkfs failed"
 _scratch_mount >> $seqres.full 2>&1
 rm -rf $testdir
 mkdir $testdir
diff --git a/tests/generic/204 b/tests/generic/204
index a3dabb71..b5deb443 100755
--- a/tests/generic/204
+++ b/tests/generic/204
@@ -35,7 +35,8 @@ _scratch_mkfs 2> /dev/null | _filter_mkfs 2> $tmp.mkfs > /dev/null
 [ $FSTYP = "xfs" ] && MKFS_OPTIONS="$MKFS_OPTIONS -l size=16m -i maxpct=50"
 
 SIZE=`expr 115 \* 1024 \* 1024`
-_scratch_mkfs_sized $SIZE $dbsize 2> /dev/null > $tmp.mkfs.raw
+_scratch_mkfs_sized $SIZE $dbsize 2> /dev/null > $tmp.mkfs.raw \
+	|| _fail "mkfs failed"
 cat $tmp.mkfs.raw | _filter_mkfs 2> $tmp.mkfs > /dev/null
 _scratch_mount
 
-- 
2.34.1

