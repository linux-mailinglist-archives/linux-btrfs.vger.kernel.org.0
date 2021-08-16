Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2F93ED323
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Aug 2021 13:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236288AbhHPLfz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Aug 2021 07:35:55 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:26137 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236335AbhHPLfu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Aug 2021 07:35:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1629113718; x=1660649718;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=giFnkQaAZJNHSN1G1pQwiVdSSRXV0OXE7MAL279oS30=;
  b=belABxnbPZgQ/EIo/iZyc/chkrtr5gGf8vW5pUg+io/5FsXmeF10qcs9
   85s/E5Wbzr98Xf4Xnr0DNvbDZBQ/J2ke1aP5UxiZGQzpPGvx2GzUrZ9f3
   tNMfgrJXu/9VmVZ2qb4ZiIGNDhYEK/JOqceXZ0UOQHtiSXXEc0HBQoXkZ
   veSsuWT9MKl74H7n1pBo/aZvEaX4YmSJD+Vkoy0LkDDPBqpk5//Djo2VB
   PauFVAEZxK9LsA5NIQ/AXe3If6qvzmS6MUGRN9ZLuptGtd6Xuq5glzaYI
   bME0VSs35Wk8gBX0HybJKfGyfHHTz699elKy4wp/CaOV54XM/VeuS9apd
   g==;
X-IronPort-AV: E=Sophos;i="5.84,324,1620662400"; 
   d="scan'208";a="182172011"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Aug 2021 19:35:17 +0800
IronPort-SDR: UftbSsV78vq9e6EM2yvjm8Z8gxQOxQN7y3kU/l7Qz4/4KOsWXXkrLbmSpj6I1zKMVM7XAbo7Oo
 dCKXzbtba5MTX1zeCfqigJOz39mzvKj7JGVq9bOWT5CkFa+M4t4LkjfBhl8pbRg2Ehlq8IKFQS
 /TOXNUl4X+O9HK0mNzSc4MIvx0lAi6JCwAtopIFccg27hQMLQXEA+Vu3E1sfRuaf6YXeviK9qV
 h/GabvGxDEUI5Td6XII5fQV37kJp1hcoGJAHfPJXhBSPveEwD6K1LRtK7ghyA9DMlLGwB1Kf/R
 Cm2O3HS4+oFjJDXk9zgNdW9r
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2021 04:10:42 -0700
IronPort-SDR: cSJe5c1UW+erMjIPx5vcJsuQp2blaSaLQzD8it3WUKSAIwLY9jWJit0laGMOeBphnqeuMDu0G3
 hPC2d+6Rs+u8l4Wt12hNYFKRHyAbUznIH3iB4055xtEAQFxAOeLrV9sdu+1stpjzB38WokGldr
 jidZMYIRIyB5iYzM/EJJ/HvWbAQcP9hFcs3Rp9KH+xsbGT0dgWdKJY6z0FJqnYjelmux+z2gbP
 QK9NUjwfIQAYDNdOa0Z/P9frPOe4hLwC0qHJPMsXX3te1DSWUYzeTHk4jJgqz7im7PsAqa2ze3
 Zj8=
WDCIronportException: Internal
Received: from ind008647.ad.shared (HELO naota-xeon.wdc.com) ([10.225.48.46])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 Aug 2021 04:35:17 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 3/3] fstests: generic: add checks for zoned block device
Date:   Mon, 16 Aug 2021 20:35:10 +0900
Message-Id: <20210816113510.911606-4-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210816113510.911606-1-naohiro.aota@wdc.com>
References: <20210816113510.911606-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Modify generic tests to require non-zoned block device

generic/108 is disabled on zoned block device because the LVM device not
always aligned to the zone boundary.

generic/471 is disabled because we cannot enable NoCoW on zoned btrfs.

generic/570 is disabled because swap file which require nocow is not usable
on zoned btrfs.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 tests/generic/108 | 2 ++
 tests/generic/471 | 2 ++
 tests/generic/570 | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/tests/generic/108 b/tests/generic/108
index b7797e8fac2b..6e1ea5b9d20a 100755
--- a/tests/generic/108
+++ b/tests/generic/108
@@ -36,6 +36,8 @@ _require_scratch_nocheck
 _require_block_device $SCRATCH_DEV
 _require_scsi_debug
 _require_command "$LVM_PROG" lvm
+# We cannot ensure the Logical Volume is aligned to the zone boundary
+_require_non_zoned_device $SCRATCH_DEV
 
 lvname=lv_$seq
 vgname=vg_$seq
diff --git a/tests/generic/471 b/tests/generic/471
index dab06f3a315c..fbd0b12a9e3a 100755
--- a/tests/generic/471
+++ b/tests/generic/471
@@ -37,6 +37,8 @@ mkdir $testdir
 # all filesystems, use a NOCOW file on btrfs.
 if [ $FSTYP == "btrfs" ]; then
 	_require_chattr C
+	# Zoned btrfs does not support NOCOW
+	_require_non_zoned_device $TEST_DEV
 	touch $testdir/f1
 	$CHATTR_PROG +C $testdir/f1
 fi
diff --git a/tests/generic/570 b/tests/generic/570
index 7d03acfe3c44..126b222d10d2 100755
--- a/tests/generic/570
+++ b/tests/generic/570
@@ -25,6 +25,8 @@ _supported_fs generic
 _require_test_program swapon
 _require_scratch_nocheck
 _require_block_device $SCRATCH_DEV
+# We cannot create swap on a zoned device because it can cause random write IOs
+_require_non_zoned_device "$SCRATCH_DEV"
 test -e /dev/snapshot && _notrun "userspace hibernation to swap is enabled"
 
 $MKSWAP_PROG "$SCRATCH_DEV" >> $seqres.full
-- 
2.32.0

