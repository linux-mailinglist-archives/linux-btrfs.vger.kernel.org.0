Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1F938BDAB
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 May 2021 06:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237416AbhEUFAF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 May 2021 01:00:05 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:33623 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232596AbhEUFAA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 May 2021 01:00:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621573116; x=1653109116;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MF2LJE+HSh/d2JlhawBe0V32G0zPYLXgSPA8047NK8g=;
  b=WzzYpinJHOCDcDlBHwGD5lMOq1HndEPTB2dEeIEuYyhzy63TahxHynF1
   jAaR5PoGcmoE8Jnay5ScTxghhEI4CqKjYm6zOwq/uJuIbL535Bn9yGBFY
   m5Ll/7fAqdFyg5vLmeJzc1Ukv1FLlpxoixrbUT88eJTpvP3w/LVwZ165b
   hPGN4anJgyIlbRfL/9EaWzaQQuMEfyoqJQy1ZFIRccJFxHWn1rqsiJjnu
   1hr2VRHBCvz9GNDrbfF+lvKFCnVJoGTS5YXqMDoKk/VCK/5bB5xODDWAM
   SR1eSjxI126ao1S6lg4j5O1iHi4mxbkv4i7Hke8lngV3hxjXdizb8+JJ9
   A==;
IronPort-SDR: pqKntqq8NbAGCKHCPnv5Ud2giX7gvEWewbHuIVIWptfLI7+FltVsvi/52j0obejXNviyPnG2+C
 dKfAHixqxXRlAKdQc2i+aGk8sM9eMMq9+42bJJWInUNS5fE/7cV9Uz53Tx9uWhR/BCE3NphigE
 igCMYoOH2ilILOGDnxItpzetE6CeLlo5IokiBlzSC7Xe7M0VbAAaJATeL6TqzRw4owI0X+ENBW
 pvV0XlnaaPZjwM1g79aBBzohIKDxksp24Gw84esDdlFM+ptoQ9kT/MQskQskZolm3WRuVpoDfB
 4r0=
X-IronPort-AV: E=Sophos;i="5.82,313,1613404800"; 
   d="scan'208";a="168955589"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 May 2021 12:58:36 +0800
IronPort-SDR: SeqF+LyqKL+fl0ODr/fvncYJZmaMBCAoiLrIXqvz9NKABiQtjNOt4QDo2g9bbwkBSVdy8mTFmr
 Vy/uCueSRkar0S1QX8h9Xww9A+TohtpYOqNLJwJ8Cx7cA+IZ1wdWE8VT6sSmAp/rqC8ZYJyJRx
 o0EaOqgGXiLB8R8D7wkxWPEAs+UsK6vlcmfQ2X2gkLNmkgoagFwM889C2ah+WZ0+GUkiD+GySv
 GDuWuetThCC0GWpvVpMySwcEKO7WZFI1Qm0uS4Rk83FkDpKMtXJjL6bhq8Seoel5msiMvjODfC
 1Tt6Hm2+L+C1yLHKAXBlrwFG
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 21:37:00 -0700
IronPort-SDR: QK6cN/jwHBWq2Z8904Zx+PSqmMnm9a53azs0R5NfedizsQ5OHP8lT/JIXIGHGGVG/ah2nm0cIO
 nUY8TpfQWZ3PrYPaOfo24swqMHRAjLKDUvExN9ELlHIADthtMLeGg/+ziX/RnM3L6amTnIxr6D
 eXxLdCRvvFbsTfHnBIrIG7drERXY07X+iYUKn6nycJ5kuMr1CS0P+q8le7o+SNZrSRAyiOLrYm
 64xdAgQ3NyxRJuWNfOsPx+hJ5wtLdDRSppCTgOCqkv8wnp5Kf4vxTuFrEzGpoEeqrluIiqEfD8
 T7U=
WDCIronportException: Internal
Received: from 9rp4l33.ad.shared (HELO naota-xeon.wdc.com) ([10.225.48.75])
  by uls-op-cesaip02.wdc.com with ESMTP; 20 May 2021 21:58:38 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 3/5] btrfs: add minimal file system size check
Date:   Fri, 21 May 2021 13:58:23 +0900
Message-Id: <20210521045825.1720305-4-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210521045825.1720305-1-naohiro.aota@wdc.com>
References: <20210521045825.1720305-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Some btrfs tests call _scratch_pool_mkfs or _scratch_mkfs by themselves to
specify file system size limit. It slips through the check in
_scratch_mkfs_sized(). Let's add size check call for each of them.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 tests/btrfs/141 | 1 +
 tests/btrfs/142 | 1 +
 tests/btrfs/143 | 1 +
 tests/btrfs/150 | 1 +
 tests/btrfs/151 | 1 +
 tests/btrfs/156 | 1 +
 tests/btrfs/157 | 1 +
 tests/btrfs/158 | 1 +
 tests/btrfs/175 | 1 +
 9 files changed, 9 insertions(+)

diff --git a/tests/btrfs/141 b/tests/btrfs/141
index bc4ba52d011d..409cb8ee4099 100755
--- a/tests/btrfs/141
+++ b/tests/btrfs/141
@@ -71,6 +71,7 @@ _scratch_dev_pool_get 2
 # step 1, create a raid1 btrfs which contains one 128k file.
 echo "step 1......mkfs.btrfs" >>$seqres.full
 
+_check_minimal_fs_size $(( 1024 * 1024 * 1024 ))
 mkfs_opts="-d raid1 -b 1G"
 _scratch_pool_mkfs $mkfs_opts >>$seqres.full 2>&1
 
diff --git a/tests/btrfs/142 b/tests/btrfs/142
index c8660fd60e5e..e7170cb4e20b 100755
--- a/tests/btrfs/142
+++ b/tests/btrfs/142
@@ -49,6 +49,7 @@ _scratch_dev_pool_get 2
 # step 1, create a raid1 btrfs which contains one 128k file.
 echo "step 1......mkfs.btrfs" >>$seqres.full
 
+_check_minimal_fs_size $(( 1024 * 1024 * 1024 ))
 mkfs_opts="-d raid1 -b 1G"
 _scratch_pool_mkfs $mkfs_opts >>$seqres.full 2>&1
 
diff --git a/tests/btrfs/143 b/tests/btrfs/143
index 88fdbe60c123..399146063c40 100755
--- a/tests/btrfs/143
+++ b/tests/btrfs/143
@@ -56,6 +56,7 @@ _scratch_dev_pool_get 2
 # step 1, create a raid1 btrfs which contains one 128k file.
 echo "step 1......mkfs.btrfs" >>$seqres.full
 
+_check_minimal_fs_size $(( 1024 * 1024 * 1024 ))
 mkfs_opts="-d raid1 -b 1G"
 _scratch_pool_mkfs $mkfs_opts >>$seqres.full 2>&1
 
diff --git a/tests/btrfs/150 b/tests/btrfs/150
index 0840e0a0cc7d..12826dc0469e 100755
--- a/tests/btrfs/150
+++ b/tests/btrfs/150
@@ -59,6 +59,7 @@ disable_io_failure()
 	echo 0 > $SYSFS_BDEV/make-it-fail
 }
 
+_check_minimal_fs_size $(( 1024 * 1024 * 1024 ))
 _scratch_pool_mkfs "-d raid1 -b 1G" >> $seqres.full 2>&1
 
 # It doesn't matter which compression algorithm we use.
diff --git a/tests/btrfs/151 b/tests/btrfs/151
index cd18f895fd69..d363874f491a 100755
--- a/tests/btrfs/151
+++ b/tests/btrfs/151
@@ -39,6 +39,7 @@ _supported_fs btrfs
 _require_scratch
 _require_scratch_dev_pool 3
 _require_btrfs_dev_del_by_devid
+_check_minimal_fs_size $(( 1024 * 1024 * 1024 ))
 
 # We need exactly 3 disks to form a fixed stripe layout for this test.
 _scratch_dev_pool_get 3
diff --git a/tests/btrfs/156 b/tests/btrfs/156
index 89c80e7161e2..9126dbab1dde 100755
--- a/tests/btrfs/156
+++ b/tests/btrfs/156
@@ -53,6 +53,7 @@ nr_files=$(( $fs_size / $file_size / 2))
 # Force to use single data and meta profile.
 # Since the test relies on fstrim output, which will differ for different
 # profiles
+_check_minimal_fs_size $fs_size
 _scratch_mkfs -b $fs_size -m single -d single > /dev/null
 _scratch_mount
 
diff --git a/tests/btrfs/157 b/tests/btrfs/157
index e7118dbcad0f..e90349b8ce16 100755
--- a/tests/btrfs/157
+++ b/tests/btrfs/157
@@ -76,6 +76,7 @@ _scratch_dev_pool_get 4
 # step 1: create a raid6 btrfs and create a 128K file
 echo "step 1......mkfs.btrfs" >>$seqres.full
 
+_check_minimal_fs_size $(( 1024 * 1024 * 1024 ))
 mkfs_opts="-d raid6 -b 1G"
 _scratch_pool_mkfs $mkfs_opts >>$seqres.full 2>&1
 
diff --git a/tests/btrfs/158 b/tests/btrfs/158
index 803d6b9ea37f..e5bf2f102e15 100755
--- a/tests/btrfs/158
+++ b/tests/btrfs/158
@@ -68,6 +68,7 @@ _scratch_dev_pool_get 4
 # step 1: create a raid6 btrfs and create a 128K file
 echo "step 1......mkfs.btrfs" >>$seqres.full
 
+_check_minimal_fs_size $(( 1024 * 1024 * 1024 ))
 mkfs_opts="-d raid6 -b 1G"
 _scratch_pool_mkfs $mkfs_opts >>$seqres.full 2>&1
 
diff --git a/tests/btrfs/175 b/tests/btrfs/175
index 94f56284a717..75704c43e27d 100755
--- a/tests/btrfs/175
+++ b/tests/btrfs/175
@@ -29,6 +29,7 @@ rm -f $seqres.full
 _supported_fs btrfs
 _require_scratch_dev_pool 2
 _require_scratch_swapfile
+_check_minimal_fs_size $((1024 * 1024 * 1024))
 
 cycle_swapfile() {
 	local sz=${1:-$(($(get_page_size) * 10))}
-- 
2.31.1

