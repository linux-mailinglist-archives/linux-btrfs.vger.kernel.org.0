Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49AAB3E945A
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Aug 2021 17:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232949AbhHKPQv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Aug 2021 11:16:51 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:39986 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbhHKPNZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Aug 2021 11:13:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628694781; x=1660230781;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZeSNQoLQ9XCjDwURe1m9XjPKa7JljWXhZ6AkJgMEZkE=;
  b=JtwSUxZQSGa+OmAm5M2EzbH1urqbQ5+oIuP6XzdmEBdZPdOOI+2l9y0j
   o3z9Zd0xQ84dOoI7uY3+rdOhJU3xVFkz0RuhnSyo9E0mHqQburZnG1VJe
   7NXLAZISCVAkErzJsGSb7QzA9kHHsHIfskt9Jo9aZVr39x2SudwJoyycD
   BM0wHmnJc2U7L6eEgrg6WYZIlEh73ES9qbRgaRgCanMRUBCt7ndWcgafq
   AO+uFUfXtkpD7w1hoZVoHo2L3U65y9J+HBbthgYWe3lkItPSH6e9uZHrB
   OIVN3Af5AMM88UqNpVNHK43vWvk5uxmUzhJeyb4R7pdP5zfgyL/VTWrdC
   Q==;
X-IronPort-AV: E=Sophos;i="5.84,313,1620662400"; 
   d="scan'208";a="176942576"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2021 23:13:01 +0800
IronPort-SDR: 6ffKU53/nlC6yDcfkwjwxnLu9kbOy2dmfQqlfOcKVzcYupnwnA79IIxeRhCJ8u3PSV9QCvkNRX
 SZKVZaRJVNz1R2nUaQD8/C6ssc98wN/LIyaVLFg4xU0ThetSEez7UtciJFVMxHh3j8scvQDa6S
 vJ6be5qOCPowjrcquvn35KgVIe9tyXo+lLTQDw3gSKeCLSkYSRP0JNwI/vxiTRQIRe9VnIUXTH
 emuTdPIm/QQ3mnH8ziQRzQGk5sNp4ZkY/QOmewHtiKAknESSvE1VPNINdpw2cAI9S4mMUto2hu
 jAwSuFXzeT9fVWW2YCJw9fSD
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2021 07:48:32 -0700
IronPort-SDR: FW2A9nwsumXuB7d3+dsMhzbMUa3dVnRm/YhQq3H8QmwyKhnUwoIE+9mjJ90vUBmoi8M/GhIeOH
 LC4cTAMhlmE66f33DJ1iGeiyg+2YEeGv/Tlu15AdYOg+uw2wph+nC2sX7Ra8g3jrjx+0uuqJtF
 qjiWMwUs+NLkhjsKAY7bTmfmI1URKEUXtIacbhD3rjCIX0C2g/lP3gwyhLSsgpxSoevgVsc+/4
 Lu8njxZH54qlhgxjYDThxh5XmB6C3+vD0LTlYGSnpz0VNJSnkWEoITzA1J3GQ25ZpbS0DKqcdx
 Lc4=
WDCIronportException: Internal
Received: from ffs5zf2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.58.251])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Aug 2021 08:13:02 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 7/8] fstests: btrfs: add checks for zoned block device
Date:   Thu, 12 Aug 2021 00:12:31 +0900
Message-Id: <20210811151232.3713733-8-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210811151232.3713733-1-naohiro.aota@wdc.com>
References: <20210811151232.3713733-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Modify btrfs tests to require non-zoned block device or limit some part of
tests not to be run on zone block devices.

Modified tests by the reasons:

* Mixed BG
  - btrfs/011
* Non-single profile
  - btrfs/003
  - btrfs/011
  - btrfs/023
  - btrfs/124
  - btrfs/125
  - btrfs/148
  - btrfs/157
  - btrfs/158
  - btrfs/195
  - btrfs/197
  - btrfs/198
* Convert from ext4
  - btrfs/012
  - btrfs/136
* nodatacow
  - btrfs/236
* inode cache
  - btrfs/049
* space cache (v1)
  - btrfs/131
* write outside of FS code
  - btrfs/116
  - btrfs/140
  - btrfs/215
* verbose output
  - btrfs/194

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 common/btrfs    | 18 ++++++++++++++++++
 tests/btrfs/003 | 13 +++++++++----
 tests/btrfs/011 | 21 ++++++++++++---------
 tests/btrfs/012 |  2 ++
 tests/btrfs/023 |  2 ++
 tests/btrfs/049 |  2 ++
 tests/btrfs/116 |  2 ++
 tests/btrfs/124 |  4 ++++
 tests/btrfs/125 |  2 ++
 tests/btrfs/131 |  2 ++
 tests/btrfs/136 |  2 ++
 tests/btrfs/140 |  2 ++
 tests/btrfs/148 |  2 ++
 tests/btrfs/157 |  2 ++
 tests/btrfs/158 |  2 ++
 tests/btrfs/194 |  2 +-
 tests/btrfs/195 |  8 ++++++++
 tests/btrfs/197 |  1 +
 tests/btrfs/198 |  1 +
 tests/btrfs/215 |  1 +
 tests/btrfs/236 | 33 ++++++++++++++++++++-------------
 21 files changed, 97 insertions(+), 27 deletions(-)

diff --git a/common/btrfs b/common/btrfs
index ebe6ce269a6b..fb1a65842012 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -222,6 +222,18 @@ _btrfs_get_profile_configs()
 		else
 			local unsupported=()
 		fi
+
+		if [ `_zone_type $TEST_DEV` != "none" ]; then
+			unsupported+=(
+				"dup"
+				"raid0"
+				"raid1"
+				"raid10"
+				"raid5"
+				"raid6"
+			)
+		fi
+
 		for unsupp in "${unsupported[@]}"; do
 			if [ "${profiles[0]}" == "$unsupp" -o "${profiles[1]}" == "$unsupp" ]; then
 			     if [ -z "$BTRFS_PROFILE_CONFIGS" ]; then
@@ -419,3 +431,9 @@ _btrfs_rescan_devices()
 {
 	$BTRFS_UTIL_PROG device scan &> /dev/null
 }
+
+_scratch_btrfs_is_zoned()
+{
+	[ `_zone_type ${SCRATCH_DEV}` != "none" ] && return 0
+	return 1
+}
diff --git a/tests/btrfs/003 b/tests/btrfs/003
index d241ec6e9fdd..af0dc8a7e105 100755
--- a/tests/btrfs/003
+++ b/tests/btrfs/003
@@ -173,12 +173,17 @@ _test_remove()
 	_scratch_unmount
 }
 
-_test_raid0
-_test_raid1
-_test_raid10
+if ! _scratch_btrfs_is_zoned; then
+	_test_raid0
+	_test_raid1
+	_test_raid10
+fi
+
 _test_single
 _test_add
-_test_replace
+if ! _scratch_btrfs_is_zoned; then
+	_test_replace
+fi
 _test_remove
 
 echo "Silence is golden"
diff --git a/tests/btrfs/011 b/tests/btrfs/011
index f5d865ab3d21..b4673341c24b 100755
--- a/tests/btrfs/011
+++ b/tests/btrfs/011
@@ -226,15 +226,18 @@ btrfs_replace_test()
 }
 
 workout "-m single -d single" 1 no 64
-workout "-m single -d single -M" 1 no 64
-workout "-m dup -d single" 1 no 64
-workout "-m dup -d single" 1 cancel 1024
-workout "-m dup -d dup -M" 1 no 64
-workout "-m raid0 -d raid0" 2 no 64
-workout "-m raid1 -d raid1" 2 no 2048
-workout "-m raid5 -d raid5" 2 no 64
-workout "-m raid6 -d raid6" 3 no 64
-workout "-m raid10 -d raid10" 4 no 64
+# Mixed BG & RAID/DUP profiles are not supported on zoned btrfs
+if ! _scratch_btrfs_is_zoned; then
+	workout "-m dup -d single" 1 no 64
+	workout "-m dup -d single" 1 cancel 1024
+	workout "-m raid0 -d raid0" 2 no 64
+	workout "-m raid1 -d raid1" 2 no 2048
+	workout "-m raid10 -d raid10" 4 no 64
+	workout "-m single -d single -M" 1 no 64
+	workout "-m dup -d dup -M" 1 no 64
+	workout "-m raid5 -d raid5" 2 no 64
+	workout "-m raid6 -d raid6" 3 no 64
+fi
 
 echo "*** done"
 status=0
diff --git a/tests/btrfs/012 b/tests/btrfs/012
index 46341e984821..3040a655095c 100755
--- a/tests/btrfs/012
+++ b/tests/btrfs/012
@@ -28,6 +28,8 @@ _require_scratch_nocheck
 _require_command "$BTRFS_CONVERT_PROG" btrfs-convert
 _require_command "$MKFS_EXT4_PROG" mkfs.ext4
 _require_command "$E2FSCK_PROG" e2fsck
+# ext4 does not support zoned block device
+_require_non_zoned_device "${SCRATCH_DEV}"
 
 _require_fs_space $SCRATCH_MNT $(du -s /lib/modules/`uname -r` | ${AWK_PROG} '{print $1}')
 
diff --git a/tests/btrfs/023 b/tests/btrfs/023
index f6c05b121099..49ca95bc9efb 100755
--- a/tests/btrfs/023
+++ b/tests/btrfs/023
@@ -17,6 +17,8 @@ _begin_fstest auto
 # real QA test starts here
 _supported_fs btrfs
 _require_scratch_dev_pool 4
+# RAID profiles are not supported on zoned btrfs
+_require_non_zoned_device "${SCRATCH_DEV}"
 
 create_group_profile()
 {
diff --git a/tests/btrfs/049 b/tests/btrfs/049
index ad4ef122f3c9..a9cd5b2cf12b 100755
--- a/tests/btrfs/049
+++ b/tests/btrfs/049
@@ -27,6 +27,8 @@ _cleanup()
 _supported_fs btrfs
 _require_scratch
 _require_dm_target flakey
+# inode cache is not supported on zoned btrfs
+_require_non_zoned_device "$SCRATCH_DEV"
 
 _scratch_mkfs >> $seqres.full 2>&1
 
diff --git a/tests/btrfs/116 b/tests/btrfs/116
index 14182e9c0f49..2449e6e3a64d 100755
--- a/tests/btrfs/116
+++ b/tests/btrfs/116
@@ -18,6 +18,8 @@ _begin_fstest auto quick metadata
 # real QA test starts here
 _supported_fs btrfs
 _require_scratch
+# Writing non-contiguous data directly to the device
+_require_non_zoned_device $SCRATCH_DEV
 
 _scratch_mkfs >>$seqres.full 2>&1
 
diff --git a/tests/btrfs/124 b/tests/btrfs/124
index 3036cbf4a72c..5c05ffae1b8f 100755
--- a/tests/btrfs/124
+++ b/tests/btrfs/124
@@ -49,6 +49,10 @@ _scratch_dev_pool_get 2
 dev1=`echo $SCRATCH_DEV_POOL | awk '{print $1}'`
 dev2=`echo $SCRATCH_DEV_POOL | awk '{print $2}'`
 
+# RAID1 is not supported on zoned btrfs
+_require_non_zoned_device "$dev1"
+_require_non_zoned_device "$dev2"
+
 dev1_sz=`blockdev --getsize64 $dev1`
 dev2_sz=`blockdev --getsize64 $dev2`
 # get min of both
diff --git a/tests/btrfs/125 b/tests/btrfs/125
index e46b194d0139..de6651739f49 100755
--- a/tests/btrfs/125
+++ b/tests/btrfs/125
@@ -43,6 +43,8 @@ _require_scratch_dev_pool 3
 _test_unmount
 _require_btrfs_forget_or_module_loadable
 _require_btrfs_fs_feature raid56
+# raid56 is not supported on zoned btrfs
+_require_non_zoned_device "${SCRATCH_DEV}"
 
 _scratch_dev_pool_get 3
 
diff --git a/tests/btrfs/131 b/tests/btrfs/131
index 81e5d9bc90c7..f97e8f30666a 100755
--- a/tests/btrfs/131
+++ b/tests/btrfs/131
@@ -18,6 +18,8 @@ _supported_fs btrfs
 _require_scratch
 _require_btrfs_command inspect-internal dump-super
 _require_btrfs_fs_feature free_space_tree
+# space_cache(v1) is not supported on HMZONED
+_require_non_zoned_device "${SCRATCH_DEV}"
 
 mkfs_v1()
 {
diff --git a/tests/btrfs/136 b/tests/btrfs/136
index 896be18d84f8..b9ab8270f039 100755
--- a/tests/btrfs/136
+++ b/tests/btrfs/136
@@ -22,6 +22,8 @@ _begin_fstest auto convert
 # Modify as appropriate.
 _supported_fs btrfs
 _require_scratch_nocheck
+# ext4 does not support zoned block device
+_require_non_zoned_device "${SCRATCH_DEV}"
 
 _require_command "$BTRFS_CONVERT_PROG" btrfs-convert
 _require_command "$MKFS_EXT4_PROG" mkfs.ext4
diff --git a/tests/btrfs/140 b/tests/btrfs/140
index f3379cae75de..a1a465cc8e5d 100755
--- a/tests/btrfs/140
+++ b/tests/btrfs/140
@@ -26,6 +26,8 @@ _require_scratch_dev_pool 2
 _require_btrfs_command inspect-internal dump-tree
 _require_command "$FILEFRAG_PROG" filefrag
 _require_odirect
+# it overwrites data, which is forbidden on zoned block device
+_require_non_zoned_device "${SCRATCH_DEV}"
 
 get_physical()
 {
diff --git a/tests/btrfs/148 b/tests/btrfs/148
index 510e46dc0826..eb86df862d9b 100755
--- a/tests/btrfs/148
+++ b/tests/btrfs/148
@@ -18,6 +18,8 @@ _require_scratch
 _require_scratch_dev_pool 4
 _require_odirect
 _require_btrfs_fs_feature raid56
+# raid56 is not supported on zoned btrfs
+_require_non_zoned_device "${SCRATCH_DEV}"
 
 _scratch_dev_pool_get 4
 
diff --git a/tests/btrfs/157 b/tests/btrfs/157
index 0cfe3ce56548..d06acead25a1 100755
--- a/tests/btrfs/157
+++ b/tests/btrfs/157
@@ -33,6 +33,8 @@ _supported_fs btrfs
 _require_scratch_dev_pool 4
 _require_btrfs_command inspect-internal dump-tree
 _require_btrfs_fs_feature raid56
+# raid56 is not supported on zoned btrfs
+_require_non_zoned_device "${SCRATCH_DEV}"
 
 get_physical()
 {
diff --git a/tests/btrfs/158 b/tests/btrfs/158
index ad374eba8c7e..dbe1036ae320 100755
--- a/tests/btrfs/158
+++ b/tests/btrfs/158
@@ -25,6 +25,8 @@ _supported_fs btrfs
 _require_scratch_dev_pool 4
 _require_btrfs_command inspect-internal dump-tree
 _require_btrfs_fs_feature raid56
+# raid56 is not supported on zoned btrfs
+_require_non_zoned_device "${SCRATCH_DEV}"
 
 get_physical()
 {
diff --git a/tests/btrfs/194 b/tests/btrfs/194
index 9a67e572ef74..a994a429628b 100755
--- a/tests/btrfs/194
+++ b/tests/btrfs/194
@@ -59,7 +59,7 @@ for (( i = 0; i < 64; i++ )); do
 	$BTRFS_UTIL_PROG device del $device_1 $SCRATCH_MNT
 	$BTRFS_UTIL_PROG device add -f $device_1 $SCRATCH_MNT
 	$BTRFS_UTIL_PROG device del $device_2 $SCRATCH_MNT
-done
+done | grep -v 'Resetting device zone'
 _scratch_dev_pool_put
 
 echo "Silence is golden"
diff --git a/tests/btrfs/195 b/tests/btrfs/195
index 59b979704491..303f18b43281 100755
--- a/tests/btrfs/195
+++ b/tests/btrfs/195
@@ -36,6 +36,14 @@ run_testcase() {
 	src_type=${args[1]}
 	dst_type=${args[2]}
 
+	if [ `_zone_type ${SCRATCH_DEV}` != "none" -a \
+		\( ${src_type} = "raid5" -o \
+		   ${src_type} = "raid6" -o \
+		   ${dst_type} = "raid5" -o \
+		   ${dst_type} = "raid6" \) ]; then
+		return
+	fi
+
 	_scratch_dev_pool_get $num_disks
 
 	echo "=== Running test: $1 ===" >> $seqres.full
diff --git a/tests/btrfs/197 b/tests/btrfs/197
index f5baf5b6066b..5f38df401dea 100755
--- a/tests/btrfs/197
+++ b/tests/btrfs/197
@@ -30,6 +30,7 @@ _supported_fs btrfs
 _require_test
 _require_scratch
 _require_scratch_dev_pool 5
+_require_non_zoned_device ${SCRATCH_DEV}
 
 workout()
 {
diff --git a/tests/btrfs/198 b/tests/btrfs/198
index b3e175a25bf9..007445cb5cb4 100755
--- a/tests/btrfs/198
+++ b/tests/btrfs/198
@@ -20,6 +20,7 @@ _supported_fs btrfs
 _require_command "$WIPEFS_PROG" wipefs
 _require_scratch
 _require_scratch_dev_pool 4
+_require_non_zoned_device ${SCRATCH_DEV}
 
 workout()
 {
diff --git a/tests/btrfs/215 b/tests/btrfs/215
index b45bd520b8e6..4a2933df6cdf 100755
--- a/tests/btrfs/215
+++ b/tests/btrfs/215
@@ -24,6 +24,7 @@ get_physical()
 
 # Modify as appropriate.
 _supported_fs btrfs
+_require_non_zoned_device $SCRATCH_DEV
 
 _scratch_mkfs > /dev/null
 # disable freespace inode to ensure file is the first thing in the data
diff --git a/tests/btrfs/236 b/tests/btrfs/236
index a16a1ce62d3a..8481d8f380d2 100755
--- a/tests/btrfs/236
+++ b/tests/btrfs/236
@@ -173,21 +173,28 @@ for ((i = 1; i <= 3; i++)); do
 	test_fsync "link_cow_$i" "link"
 done
 
-# Now lets test with nodatacow.
 _unmount_flakey
-MOUNT_OPTIONS="-o nodatacow"
-_mount_flakey
 
-echo "Testing fsync after rename with NOCOW writes"
-for ((i = 1; i <= 3; i++)); do
-	test_fsync "rename_nocow_$i" "rename"
-done
-echo "Testing fsync after link with NOCOW writes"
-for ((i = 1; i <= 3; i++)); do
-	test_fsync "link_nocow_$i" "link"
-done
-
-_unmount_flakey
+# Now lets test with nodatacow.
+if ! _scratch_btrfs_is_zoned; then
+	MOUNT_OPTIONS="-o nodatacow"
+	_mount_flakey
+
+	echo "Testing fsync after rename with NOCOW writes"
+	for ((i = 1; i <= 3; i++)); do
+		test_fsync "rename_nocow_$i" "rename"
+	done
+	echo "Testing fsync after link with NOCOW writes"
+	for ((i = 1; i <= 3; i++)); do
+		test_fsync "link_nocow_$i" "link"
+	done
+
+	_unmount_flakey
+else
+	# Fake result. Zoned btrfs does not support NOCOW
+	echo "Testing fsync after rename with NOCOW writes"
+	echo "Testing fsync after link with NOCOW writes"
+fi
 
 status=0
 exit
-- 
2.32.0

