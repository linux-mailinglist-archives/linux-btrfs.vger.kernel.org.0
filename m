Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 456B43ED322
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Aug 2021 13:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236272AbhHPLfy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Aug 2021 07:35:54 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:26129 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236332AbhHPLfu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Aug 2021 07:35:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1629113718; x=1660649718;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3tQcoz+6eJch5T/0nW8LfqhY2MFvqeW7sjjwsZOPUUk=;
  b=bPhPsbaDO2U++jpsa9hiPexYSEAPfFrltGjES5WEBr+4a6MSpGOmtijM
   bvAysXVc928ClboG+8qKB2KW43xxpJhFtMGSl5Yt6013Zj6w2IuJ6I1g/
   vzdNPmM5A05xnYDiWgKNIxwTaUpcQmBSqu1GcZaURN98qtBeTzryDA9Is
   J2A3O/Ci6nWj87RCBkBjMNc4c2YTNDQkD9pqLrNnt35G9naHGGcUTm7WM
   De9FUrGOdQmsoIfHLPDj9ocGz0yrtM2b7neuLgf31kdYVoCAfIYTBJXqc
   8pegVx4jJFajwbzTSLcQOdP+RNn9QuHmfd6fv1nv1jjbl8yb86aEcrnrF
   g==;
X-IronPort-AV: E=Sophos;i="5.84,324,1620662400"; 
   d="scan'208";a="182172010"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Aug 2021 19:35:16 +0800
IronPort-SDR: p6DE0chYaJErqLQz2kHnhPAyPo1oSyi1EdrkagA/aBriQ1BP3M3+ZSuUaJnsSdX+yZOO3XP/Du
 nV0inqpZzvtmBy49OqfjSuzk4YNAUqeR9Y6Ni5Pz3TVYnZ1wEXsQWBZKQ0DnkSJzwGrbKjvBbM
 w0HMrl3ubXVOzw1JuAcMPYIslvNpytmkEer3aTFJf9jy7z0O4HP8+KREq/YRh/LXuZAs/0MiCd
 5tVphkNMYDRDmel9fg/bHWFZHxRSWpkHaoYjiZEdyt1wR/liC7yEIKVnF2tiMenogEEvMpVKua
 4J7rtFXZJ0mS9pW8/h69wo6I
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2021 04:10:41 -0700
IronPort-SDR: CHNLfFpQX6H6WfZ4j5n3PB6u0VuQTwvi73760pT9/M1cRwkL6P+oYagEv5jTXNZR6FaTpgjri0
 3+Aykkk+QzT97f2qUnNkEvLDEvuqxyIcMr2wHI5uqiUj/E48O7+YtxrRYHbNtXh8lsHnjmHqQs
 MMT5qi/xMjpeuc8sg8JQjPmaHmbuykmqUZbi/a3fKm7vI2qvEKGp2ynW7yC1dasfGuKkgrmNes
 xyeCqIYR3tiSuo42wLYUdlnEryYnflkk5heoIFR59QEms09l5iC+J0PznRcnhAw3YT2tFpyy8M
 85w=
WDCIronportException: Internal
Received: from ind008647.ad.shared (HELO naota-xeon.wdc.com) ([10.225.48.46])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 Aug 2021 04:35:16 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 2/3] fstests: btrfs: add checks for zoned block device
Date:   Mon, 16 Aug 2021 20:35:09 +0900
Message-Id: <20210816113510.911606-3-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210816113510.911606-1-naohiro.aota@wdc.com>
References: <20210816113510.911606-1-naohiro.aota@wdc.com>
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
  - btrfs/195
  - btrfs/197
  - btrfs/198
  - and these are restricted indirectly by "_require_btrfs_fs_feature raid56"
    - btrfs/125
    - btrfs/148
    - btrfs/157
    - btrfs/158
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
 common/btrfs    | 26 ++++++++++++++++++++++++++
 tests/btrfs/003 | 16 ++++++++++++----
 tests/btrfs/011 | 21 ++++++++++++---------
 tests/btrfs/012 |  2 ++
 tests/btrfs/023 |  2 ++
 tests/btrfs/049 |  2 ++
 tests/btrfs/116 |  2 ++
 tests/btrfs/124 |  4 ++++
 tests/btrfs/131 |  2 ++
 tests/btrfs/136 |  2 ++
 tests/btrfs/140 |  2 ++
 tests/btrfs/194 |  2 +-
 tests/btrfs/195 |  2 ++
 tests/btrfs/197 |  2 ++
 tests/btrfs/198 |  2 ++
 tests/btrfs/215 |  2 ++
 tests/btrfs/236 | 33 ++++++++++++++++++++-------------
 17 files changed, 97 insertions(+), 27 deletions(-)

diff --git a/common/btrfs b/common/btrfs
index ebe6ce269a6b..ac880bddf524 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -96,6 +96,11 @@ _require_btrfs_fs_feature()
 	modprobe btrfs > /dev/null 2>&1
 	[ -e /sys/fs/btrfs/features/$feat ] || \
 		_notrun "Feature $feat not supported by the available btrfs version"
+
+	if [ $feat = "raid56" ]; then
+		# Zoned btrfs only supports SINGLE profile
+		_require_non_zoned_device "${SCRATCH_DEV}"
+	fi
 }
 
 _require_btrfs_fs_sysfs()
@@ -222,6 +227,21 @@ _btrfs_get_profile_configs()
 		else
 			local unsupported=()
 		fi
+
+		if _scratch_btrfs_is_zoned; then
+			# Zoned btrfs only supports SINGLE profile
+			unsupported+=(
+				"dup"
+				"raid0"
+				"raid1"
+				"raid1c3"
+				"raid1c4"
+				"raid10"
+				"raid5"
+				"raid6"
+			)
+		fi
+
 		for unsupp in "${unsupported[@]}"; do
 			if [ "${profiles[0]}" == "$unsupp" -o "${profiles[1]}" == "$unsupp" ]; then
 			     if [ -z "$BTRFS_PROFILE_CONFIGS" ]; then
@@ -419,3 +439,9 @@ _btrfs_rescan_devices()
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
index d241ec6e9fdd..0aa4c99176b5 100755
--- a/tests/btrfs/003
+++ b/tests/btrfs/003
@@ -173,12 +173,20 @@ _test_remove()
 	_scratch_unmount
 }
 
-_test_raid0
-_test_raid1
-_test_raid10
+# Zoned btrfs only supports SINGLE profile
+if ! _scratch_btrfs_is_zoned; then
+	_test_raid0
+	_test_raid1
+	_test_raid10
+fi
+
 _test_single
 _test_add
-_test_replace
+# _test_replace() uses raid1, but zoned btrfs only supports SINGLE
+# profile
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
index f6c05b121099..9facf3e2092c 100755
--- a/tests/btrfs/023
+++ b/tests/btrfs/023
@@ -17,6 +17,8 @@ _begin_fstest auto
 # real QA test starts here
 _supported_fs btrfs
 _require_scratch_dev_pool 4
+# Zoned btrfs only supports SINGLE profile
+_require_non_zoned_device "${SCRATCH_DEV}"
 
 create_group_profile()
 {
diff --git a/tests/btrfs/049 b/tests/btrfs/049
index ad4ef122f3c9..87c205ca9650 100755
--- a/tests/btrfs/049
+++ b/tests/btrfs/049
@@ -27,6 +27,8 @@ _cleanup()
 _supported_fs btrfs
 _require_scratch
 _require_dm_target flakey
+# Zoned btrfs does not support inode cache
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
diff --git a/tests/btrfs/131 b/tests/btrfs/131
index 81e5d9bc90c7..1e072b285ecf 100755
--- a/tests/btrfs/131
+++ b/tests/btrfs/131
@@ -18,6 +18,8 @@ _supported_fs btrfs
 _require_scratch
 _require_btrfs_command inspect-internal dump-super
 _require_btrfs_fs_feature free_space_tree
+# Zoned btrfs does not support space_cache(v1)
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
index f3379cae75de..5a5f828ce0de 100755
--- a/tests/btrfs/140
+++ b/tests/btrfs/140
@@ -26,6 +26,8 @@ _require_scratch_dev_pool 2
 _require_btrfs_command inspect-internal dump-tree
 _require_command "$FILEFRAG_PROG" filefrag
 _require_odirect
+# Overwriting data is forbidden on a zoned block device
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
index 59b979704491..747345973244 100755
--- a/tests/btrfs/195
+++ b/tests/btrfs/195
@@ -18,6 +18,8 @@ _begin_fstest auto volume balance
 # Modify as appropriate.
 _supported_fs btrfs
 _require_scratch_dev_pool 4
+# Zoned btrfs only supports SINGLE profile
+_require_non_zoned_device "${SCRATCH_DEV}"
 
 declare -a TEST_VECTORS=(
 # $nr_dev_min:$data:$metadata:$data_convert:$metadata_convert
diff --git a/tests/btrfs/197 b/tests/btrfs/197
index f5baf5b6066b..597bc36f0fd7 100755
--- a/tests/btrfs/197
+++ b/tests/btrfs/197
@@ -30,6 +30,8 @@ _supported_fs btrfs
 _require_test
 _require_scratch
 _require_scratch_dev_pool 5
+# Zoned btrfs only supports SINGLE profile
+_require_non_zoned_device ${SCRATCH_DEV}
 
 workout()
 {
diff --git a/tests/btrfs/198 b/tests/btrfs/198
index b3e175a25bf9..035c63fdb5ec 100755
--- a/tests/btrfs/198
+++ b/tests/btrfs/198
@@ -20,6 +20,8 @@ _supported_fs btrfs
 _require_command "$WIPEFS_PROG" wipefs
 _require_scratch
 _require_scratch_dev_pool 4
+# Zoned btrfs only supports SINGLE profile
+_require_non_zoned_device ${SCRATCH_DEV}
 
 workout()
 {
diff --git a/tests/btrfs/215 b/tests/btrfs/215
index b45bd520b8e6..fa622568adfd 100755
--- a/tests/btrfs/215
+++ b/tests/btrfs/215
@@ -24,6 +24,8 @@ get_physical()
 
 # Modify as appropriate.
 _supported_fs btrfs
+# Overwriting data is forbidden on a zoned block device
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

