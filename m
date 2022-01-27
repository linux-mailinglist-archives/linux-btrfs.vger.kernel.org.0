Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDEC49EAED
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jan 2022 20:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245466AbiA0TO5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Jan 2022 14:14:57 -0500
Received: from michael.mail.tiscali.it ([213.205.33.246]:57340 "EHLO
        smtp.tiscali.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S245463AbiA0TO4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Jan 2022 14:14:56 -0500
Received: from venice.bhome ([78.14.151.50])
        by michael.mail.tiscali.it with 
        id nvEr2601e15VSme01vEsf9; Thu, 27 Jan 2022 19:14:54 +0000
X-Spam-Final-Verdict: clean
X-Spam-State: 0
X-Spam-Score: -100
X-Spam-Verdict: clean
x-auth-user: kreijack@tiscali.it
From:   Goffredo Baroncelli <kreijack@tiscali.it>
To:     linux-btrfs@vger.kernel.org
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>,
        Paul Jones <paul@pauljones.id.au>, Boris Burkov <boris@bur.io>,
        Goffredo Baroncelli <kreijack@tiscali.it>
Subject: [PATCH][V10][Repost] Add tests for allocation_hint
Date:   Thu, 27 Jan 2022 20:14:45 +0100
Message-Id: <1f47c7fa7b1256ed33718bc646596d259b05f5a2.1643310829.git.kreijack@inwind.it>
X-Mailer: git-send-email 2.34.1
Reply-To: Goffredo Baroncelli <kreijack@libero.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tiscali.it; s=smtp;
        t=1643310894; bh=CaPe1fqkEwJqBdOuYTHExog3MR6pAg550RKIR2RWisc=;
        h=From:To:Cc:Subject:Date:Reply-To;
        b=mUi/aVSZW2sZRsnCp9w7qTu8Io+I/NKcFYLVis42HytOpeJvnQgu13YXWUBGNk8Gy
         Xyj7rYOPmEXncz9WfbIFcXnxIevdRGAz1v+hfty1KIlTvAcaKgDBm6vCJ9vjAkKgSh
         x4JK+JxIPUYG9FZDRE0EB3LdJqy7rG2sjC4RDadI=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a repost of a patch to xfstest to test the allocation_hint mode

---
 common/btrfs        |  87 ++++++++++++++++++++++++
 doc/group-names.txt |   1 +
 tests/btrfs/255     | 120 +++++++++++++++++++++++++++++++++
 tests/btrfs/255.out |   3 +
 tests/btrfs/256     | 123 ++++++++++++++++++++++++++++++++++
 tests/btrfs/256.out |   3 +
 tests/btrfs/257     | 123 ++++++++++++++++++++++++++++++++++
 tests/btrfs/257.out |   3 +
 tests/btrfs/258     | 126 +++++++++++++++++++++++++++++++++++
 tests/btrfs/258.out |   3 +
 tests/btrfs/259     | 139 ++++++++++++++++++++++++++++++++++++++
 tests/btrfs/259.out |   5 ++
 tests/btrfs/260     | 158 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/260.out |   3 +
 tests/btrfs/261     | 144 ++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/261.out |   3 +
 tests/btrfs/262     | 121 +++++++++++++++++++++++++++++++++
 tests/btrfs/262.out |   3 +
 tests/btrfs/263     | 123 ++++++++++++++++++++++++++++++++++
 tests/btrfs/263.out |   3 +
 tests/btrfs/264     | 121 +++++++++++++++++++++++++++++++++
 tests/btrfs/264.out |   3 +
 22 files changed, 1418 insertions(+)
 create mode 100755 tests/btrfs/255
 create mode 100644 tests/btrfs/255.out
 create mode 100755 tests/btrfs/256
 create mode 100644 tests/btrfs/256.out
 create mode 100755 tests/btrfs/257
 create mode 100644 tests/btrfs/257.out
 create mode 100755 tests/btrfs/258
 create mode 100644 tests/btrfs/258.out
 create mode 100755 tests/btrfs/259
 create mode 100644 tests/btrfs/259.out
 create mode 100755 tests/btrfs/260
 create mode 100644 tests/btrfs/260.out
 create mode 100755 tests/btrfs/261
 create mode 100755 tests/btrfs/261.out
 create mode 100755 tests/btrfs/262
 create mode 100644 tests/btrfs/262.out
 create mode 100755 tests/btrfs/263
 create mode 100644 tests/btrfs/263.out
 create mode 100755 tests/btrfs/264
 create mode 100644 tests/btrfs/264.out

diff --git a/common/btrfs b/common/btrfs
index 4afe81eb..a4f1947a 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -480,3 +480,90 @@ _btrfs_no_v1_cache_opt()
 	fi
 	echo -n "-onospace_cache"
 }
+
+# Test if a property is available
+_require_btrfs_property_get()
+{
+	local propname
+
+	[ $# -eq 1 ] || _fail "_require_btrfs_get_property: expected property name as param"
+
+	propname="$1"
+	$BTRFS_UTIL_PROG property get $SCRATCH_DEV "$propname" |
+		grep -q "ERROR: unknown property" &&
+		_notrun "Need btrfs property '$propname' support"
+}
+
+__dump_bg_data_info() {
+	local dir=$1
+	$BTRFS_UTIL_PROG fi us -b $dir | awk '
+		/^$/    { flag=0 }
+		        { if(flag) print $0 }
+		/^Data/ { flag=1 }
+	'
+}
+
+__dump_bg_metadata_info() {
+	local dir=$1
+	$BTRFS_UTIL_PROG fi us -b $dir | awk '
+		/^$/        { flag=0 }
+		            { if(flag) print $0 }
+		/^Metadata/ { flag=1 }
+	'
+}
+
+# check if a disk not contains data bg
+btrfs_check_data_bg_in_disk() {
+	local mnt=$1
+	shift
+	local res="$(__dump_bg_data_info $mnt)"
+	while [ -n "$1" ]; do
+		if ! echo $res | egrep -q $1 ; then
+			[ -n "$DEBUG" ] && $BTRFS_UTIL_PROG fil us $SCRATCH_MNT
+			_fail "Disk '$1' should contain a DATA BG"
+		fi
+		shift
+	done
+}
+
+# check if a disk not contains data bg
+btrfs_check_data_bg_not_in_disk() {
+	local mnt=$1
+	shift
+	local res="$(__dump_bg_data_info $mnt)"
+	while [ -n "$1" ]; do
+		if echo $res | egrep -q $1 ; then
+			[ -n "$DEBUG" ] && $BTRFS_UTIL_PROG fil us $SCRATCH_MNT
+			_fail "Disk '$1' should not contain a DATA BG"
+		fi
+		shift
+	done
+}
+
+# check if a disk contains metadata bg
+btrfs_check_metadata_bg_in_disk() {
+	local mnt=$1
+	shift
+	local res="$(__dump_bg_metadata_info $mnt)"
+	while [ -n "$1" ]; do
+		if ! echo $res | egrep -q $1 ; then
+			[ -n "$DEBUG" ] && $BTRFS_UTIL_PROG fil us $SCRATCH_MNT
+			_fail "Disk '$1' should contain a METADATA BG"
+		fi
+		shift
+	done
+}
+
+# check if a disk not contains metadata bg
+btrfs_check_metadata_bg_not_in_disk() {
+	local mnt=$1
+	shift
+	local res="$(__dump_bg_metadata_info $mnt)"
+	while [ -n "$1" ]; do
+		if echo $res | egrep -q $1 ; then
+			[ -n "$DEBUG" ] && $BTRFS_UTIL_PROG fil us $SCRATCH_MNT
+			_fail "Disk '$1' should not contain a METADATA BG"
+		fi
+		shift
+	done
+}
diff --git a/doc/group-names.txt b/doc/group-names.txt
index e8e3477e..bbb83046 100644
--- a/doc/group-names.txt
+++ b/doc/group-names.txt
@@ -132,4 +132,5 @@ whiteout		overlayfs whiteout functionality
 xino			overlayfs xino feature
 zero			fallocate FALLOC_FL_ZERO_RANGE
 zone			zoned (SMR) device support
+allocation_hint		allocation_hint property (BTRFS only)
 ======================= =======================================================
diff --git a/tests/btrfs/255 b/tests/btrfs/255
new file mode 100755
index 00000000..5efa961c
--- /dev/null
+++ b/tests/btrfs/255
@@ -0,0 +1,120 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# FS QA Test No. 255
+#
+# Test the allocation_hint property of a btrfs filesystem
+#
+
+
+# size of the disk used; default 1GB
+MAXSIZE=$((1*1024*1024*1024))
+NDEVS=2
+DEBUG=
+
+. ./common/preamble
+_begin_fstest auto quick allocation_hint
+
+seq=`basename $0`
+seqres="${RESULT_DIR}/${seq}"
+
+disks=""
+nodes=""
+
+# Override the default cleanup function.
+_cleanup()
+{
+	umount $SCRATCH_MNT &>/dev/null || true
+	for disk in $disks; do
+		_dmsetup_remove $disk
+	done
+}
+
+# Import common functions.
+. ./common/filter
+. ./common/filter.btrfs
+
+# real QA test starts here
+_supported_fs btrfs
+_require_block_device $SCRATCH_DEV
+_require_dm_target linear
+_require_scratch_nocheck
+_require_command "$WIPEFS_PROG" wipefs
+_try_wipe_scratch_devs
+
+_require_btrfs_property_get "allocation_hint"
+
+# dont' use _require_scratch_size because it pretend that the filesystem is
+# scratch_dev is consistent
+devsize=`_get_device_size $SCRATCH_DEV`
+[ $devsize -lt $((($MAXSIZE * $NDEVS + 100*1024*1024) / 1024)) ] &&
+		_notrun "scratch dev too small"
+
+setup_dmdev()
+{
+	# create some small size disks
+
+	size_in_sector=$(($MAXSIZE / 512))
+
+	off=0
+	for i in $(seq $NDEVS); do
+		node=dev${seq}test${i}
+		disk="/dev/mapper/$node"
+		disks="$disks $disk"
+		nodes="$nodes $node"
+		table="0 $size_in_sector linear $SCRATCH_DEV $off"
+		_dmsetup_create $node --table "$table" || \
+			_fail "setup dm device failed"
+		off=$(($off + $size_in_sector))
+		$WIPEFS_PROG -a $disk &>/dev/null
+	done
+}
+
+create_file() {
+	local fn=$SCRATCH_MNT/giant-file-$1
+	local size
+	if [ -n "$2" ]; then
+		size=count=$(($2 / 16 / 1024 / 1024 ))
+	else
+		size=
+	fi
+	dd if=/dev/zero of=$fn bs=16M oflag=direct $size &>/dev/null
+	ls -l $fn | awk '{ print $5 }'
+}
+
+#
+# create a file and check that the Data BG is in the correct disk
+#
+test_single_preferred_data() {
+
+	local blkdev0 blkdev1
+	blkdev0=$(echo $disks | awk '{ print $1 }')
+	blkdev1=$(echo $disks | awk '{ print $2 }')
+	$BTRFS_UTIL_PROG dev scan -u
+	_mkfs_dev  -dsingle -msingle $blkdev0 $blkdev1
+	_mount $blkdev0 $SCRATCH_MNT
+
+	[ $(ls /sys/fs/btrfs/*/devinfo/*/allocation_hint | wc -l) -gt 0 ] ||
+		_notrun "Kernel with allocation_hint support required"
+
+	# use realpath because a link may confuse "btrfs prop get/set"
+	$BTRFS_UTIL_PROG prop set $(realpath $blkdev0) allocation_hint METADATA_PREFERRED
+	$BTRFS_UTIL_PROG prop set $(realpath $blkdev1) allocation_hint DATA_PREFERRED
+
+	$BTRFS_UTIL_PROG balance start --full-balance $SCRATCH_MNT
+
+	size=$(create_file x $(($MAXSIZE / 2)) )
+
+	btrfs_check_data_bg_in_disk $SCRATCH_MNT $blkdev1
+	btrfs_check_data_bg_not_in_disk $SCRATCH_MNT $blkdev0
+
+	umount $SCRATCH_MNT
+}
+
+setup_dmdev
+test_single_preferred_data
+
+echo "Silence is golden"
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/255.out b/tests/btrfs/255.out
new file mode 100644
index 00000000..62800619
--- /dev/null
+++ b/tests/btrfs/255.out
@@ -0,0 +1,3 @@
+QA output created by 255
+Done, had to relocate 3 out of 3 chunks
+Silence is golden
diff --git a/tests/btrfs/256 b/tests/btrfs/256
new file mode 100755
index 00000000..262b497b
--- /dev/null
+++ b/tests/btrfs/256
@@ -0,0 +1,123 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# FS QA Test No. 256
+#
+# Test the allocation_hint property of a btrfs filesystem
+#
+
+
+# size of the disk used; default 1GB
+MAXSIZE=$((1*1024*1024*1024))
+UUID=292afefb-6e8c-4fb3-9d12-8c4ecb1f238c
+NDEVS=4
+DEBUG=
+
+. ./common/preamble
+_begin_fstest auto quick allocation_hint
+
+seq=`basename $0`
+seqres="${RESULT_DIR}/${seq}"
+
+disks=""
+nodes=""
+
+# Override the default cleanup function.
+_cleanup()
+{
+	umount $SCRATCH_MNT &>/dev/null || true
+	for disk in $disks; do
+		_dmsetup_remove $disk
+	done
+}
+
+# Import common functions.
+. ./common/filter
+. ./common/filter.btrfs
+
+# real QA test starts here
+_supported_fs btrfs
+_require_block_device $SCRATCH_DEV
+_require_dm_target linear
+_require_scratch_nocheck
+_require_command "$WIPEFS_PROG" wipefs
+_try_wipe_scratch_devs
+
+_require_btrfs_property_get "allocation_hint"
+
+# dont' use _require_scratch_size because it pretend that the filesystem is
+# scratch_dev is consistent
+devsize=`_get_device_size $SCRATCH_DEV`
+[ $devsize -lt $((($MAXSIZE * $NDEVS + 100*1024*1024) / 1024)) ] &&
+		_notrun "scratch dev too small"
+
+setup_dmdev()
+{
+	# create some small size disks
+
+	size_in_sector=$(($MAXSIZE / 512))
+
+	off=0
+	for i in $(seq $NDEVS); do
+		node=dev${seq}test${i}
+		disk="/dev/mapper/$node"
+		disks="$disks $disk"
+		nodes="$nodes $node"
+		table="0 $size_in_sector linear $SCRATCH_DEV $off"
+		_dmsetup_create $node --table "$table" || \
+			_fail "setup dm device failed"
+		off=$(($off + $size_in_sector))
+		$WIPEFS_PROG -a $disk &>/dev/null
+	done
+}
+
+create_file() {
+	local fn=$SCRATCH_MNT/giant-file-$1
+	local size
+	if [ -n "$2" ]; then
+		size=count=$(($2 / 16 / 1024 / 1024 ))
+	else
+		size=
+	fi
+	dd if=/dev/zero of=$fn bs=16M oflag=direct $size &>/dev/null
+	ls -l $fn | awk '{ print $5 }'
+}
+
+#
+# mark some disks as DATA_PREFERRED and check that these are the only one used
+#
+test_raid1_preferred_data() {
+	local blkdev0 blkdev1 blkdev2 blkdev3
+	blkdev0=$(echo $disks | awk '{ print $1 }')
+	blkdev1=$(echo $disks | awk '{ print $2 }')
+	blkdev2=$(echo $disks | awk '{ print $3 }')
+	blkdev3=$(echo $disks | awk '{ print $4 }')
+	$BTRFS_UTIL_PROG  dev scan -u
+	_mkfs_dev  -U $UUID -draid1 -mraid1 $blkdev0 $blkdev1 $blkdev2 $blkdev3
+	_mount $blkdev0 $SCRATCH_MNT
+
+	[ $(ls /sys/fs/btrfs/*/devinfo/*/allocation_hint | wc -l) -gt 0 ] ||
+		_notrun "Kernel with allocation_hint support required"
+
+	$BTRFS_UTIL_PROG prop set $(realpath $blkdev0)  allocation_hint METADATA_PREFERRED
+	$BTRFS_UTIL_PROG prop set $(realpath $blkdev1)  allocation_hint METADATA_PREFERRED
+	$BTRFS_UTIL_PROG prop set $(realpath $blkdev2)  allocation_hint DATA_PREFERRED
+	$BTRFS_UTIL_PROG prop set $(realpath $blkdev3)  allocation_hint DATA_PREFERRED
+
+	$BTRFS_UTIL_PROG balance start --full-balance $SCRATCH_MNT
+
+	size=$(create_file x $(($MAXSIZE / 2)) )
+
+	btrfs_check_data_bg_in_disk $SCRATCH_MNT $blkdev2 $blkdev3
+	btrfs_check_data_bg_not_in_disk $SCRATCH_MNT $blkdev0 $blkdev1
+
+	umount $SCRATCH_MNT
+}
+
+setup_dmdev
+test_raid1_preferred_data
+
+echo "Silence is golden"
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/256.out b/tests/btrfs/256.out
new file mode 100644
index 00000000..85efa3dd
--- /dev/null
+++ b/tests/btrfs/256.out
@@ -0,0 +1,3 @@
+QA output created by 256
+Done, had to relocate 3 out of 3 chunks
+Silence is golden
diff --git a/tests/btrfs/257 b/tests/btrfs/257
new file mode 100755
index 00000000..c349fb68
--- /dev/null
+++ b/tests/btrfs/257
@@ -0,0 +1,123 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# FS QA Test No. 257
+#
+# Test the allocation_hint property of a btrfs filesystem
+#
+
+
+# size of the disk used; default 1GB
+MAXSIZE=$((1*1024*1024*1024))
+NDEVS=2
+DEBUG=
+
+. ./common/preamble
+_begin_fstest auto quick allocation_hint
+
+seq=`basename $0`
+seqres="${RESULT_DIR}/${seq}"
+
+disks=""
+nodes=""
+
+# Override the default cleanup function.
+_cleanup()
+{
+	umount $SCRATCH_MNT &>/dev/null || true
+	for disk in $disks; do
+		_dmsetup_remove $disk
+	done
+}
+
+# Import common functions.
+. ./common/filter
+. ./common/filter.btrfs
+
+# real QA test starts here
+_supported_fs btrfs
+_require_block_device $SCRATCH_DEV
+_require_dm_target linear
+_require_scratch_nocheck
+_require_command "$WIPEFS_PROG" wipefs
+_try_wipe_scratch_devs
+
+_require_btrfs_property_get "allocation_hint"
+
+# dont' use _require_scratch_size because it pretend that the filesystem is
+# scratch_dev is consistent
+devsize=`_get_device_size $SCRATCH_DEV`
+[ $devsize -lt $((($MAXSIZE * $NDEVS + 100*1024*1024) / 1024)) ] &&
+		_notrun "scratch dev too small"
+
+setup_dmdev()
+{
+	# create some small size disks
+
+	size_in_sector=$(($MAXSIZE / 512))
+
+	off=0
+	for i in $(seq $NDEVS); do
+		node=dev${seq}test${i}
+		disk="/dev/mapper/$node"
+		disks="$disks $disk"
+		nodes="$nodes $node"
+		table="0 $size_in_sector linear $SCRATCH_DEV $off"
+		_dmsetup_create $node --table "$table" || \
+			_fail "setup dm device failed"
+		off=$(($off + $size_in_sector))
+		$WIPEFS_PROG -a $disk &>/dev/null
+	done
+}
+
+create_file() {
+	local fn=$SCRATCH_MNT/giant-file-$1
+	local size
+	if [ -n "$2" ]; then
+		size=count=$(($2 / 16 / 1024 / 1024 ))
+	else
+		size=
+	fi
+	dd if=/dev/zero of=$fn bs=16M oflag=direct $size &>/dev/null
+	ls -l $fn | awk '{ print $5 }'
+}
+
+#
+# create a file and check that the Data BG is in the correct disk
+#
+test_single_data_only() {
+
+	local blkdev0 blkdev1
+	blkdev0=$(echo $disks | awk '{ print $1 }')
+	blkdev1=$(echo $disks | awk '{ print $2 }')
+	$BTRFS_UTIL_PROG dev scan -u
+	_mkfs_dev  -dsingle -msingle $blkdev0 $blkdev1
+	_mount $blkdev0 $SCRATCH_MNT
+
+	[ $(ls /sys/fs/btrfs/*/devinfo/*/allocation_hint | wc -l) -gt 0 ] ||
+		_notrun "Kernel with allocation_hint support required"
+
+	# use realpath because a link may confuse "btrfs prop get/set"
+	$BTRFS_UTIL_PROG prop set $(realpath $blkdev0) allocation_hint METADATA_ONLY
+	$BTRFS_UTIL_PROG prop set $(realpath $blkdev1) allocation_hint DATA_ONLY
+
+	$BTRFS_UTIL_PROG balance start --full-balance $SCRATCH_MNT
+
+	size=$(create_file)
+
+	[ $size -gt $(($MAXSIZE * 2 * 2 / 3 )) ] && _fail "File too big: check mnt/"
+	[ $size -lt $(($MAXSIZE * 2 / 3 )) ] && _fail "File too small: check mnt/"
+
+	btrfs_check_data_bg_in_disk $SCRATCH_MNT $blkdev1
+	btrfs_check_data_bg_not_in_disk $SCRATCH_MNT $blkdev0
+
+	umount $SCRATCH_MNT
+}
+
+setup_dmdev
+test_single_data_only
+
+echo "Silence is golden"
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/257.out b/tests/btrfs/257.out
new file mode 100644
index 00000000..0fc19614
--- /dev/null
+++ b/tests/btrfs/257.out
@@ -0,0 +1,3 @@
+QA output created by 257
+Done, had to relocate 3 out of 3 chunks
+Silence is golden
diff --git a/tests/btrfs/258 b/tests/btrfs/258
new file mode 100755
index 00000000..dd5aa663
--- /dev/null
+++ b/tests/btrfs/258
@@ -0,0 +1,126 @@
+##! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# FS QA Test No. 258
+#
+# Test the allocation_hint property of a btrfs filesystem
+#
+
+
+# size of the disk used; default 1GB
+MAXSIZE=$((1*1024*1024*1024))
+NDEVS=4
+DEBUG=
+
+. ./common/preamble
+_begin_fstest auto quick allocation_hint
+
+seq=`basename $0`
+seqres="${RESULT_DIR}/${seq}"
+
+disks=""
+nodes=""
+
+# Override the default cleanup function.
+_cleanup()
+{
+	umount $SCRATCH_MNT &>/dev/null || true
+	for disk in $disks; do
+		_dmsetup_remove $disk
+	done
+}
+
+# Import common functions.
+. ./common/filter
+. ./common/filter.btrfs
+
+# real QA test starts here
+_supported_fs btrfs
+_require_block_device $SCRATCH_DEV
+_require_dm_target linear
+_require_scratch_nocheck
+_require_command "$WIPEFS_PROG" wipefs
+_try_wipe_scratch_devs
+
+_require_btrfs_property_get "allocation_hint"
+
+# dont' use _require_scratch_size because it pretend that the filesystem is
+# scratch_dev is consistent
+devsize=`_get_device_size $SCRATCH_DEV`
+[ $devsize -lt $((($MAXSIZE * $NDEVS + 100*1024*1024) / 1024)) ] &&
+		_notrun "scratch dev too small"
+
+setup_dmdev()
+{
+	# create some small size disks
+
+	size_in_sector=$(($MAXSIZE / 512))
+
+	off=0
+	for i in $(seq $NDEVS); do
+		node=dev${seq}test${i}
+		disk="/dev/mapper/$node"
+		disks="$disks $disk"
+		nodes="$nodes $node"
+		table="0 $size_in_sector linear $SCRATCH_DEV $off"
+		_dmsetup_create $node --table "$table" || \
+			_fail "setup dm device failed"
+		off=$(($off + $size_in_sector))
+		$WIPEFS_PROG -a $disk &>/dev/null
+	done
+}
+
+create_file() {
+	local fn=$SCRATCH_MNT/giant-file-$1
+	local size
+	if [ -n "$2" ]; then
+		size=count=$(($2 / 16 / 1024 / 1024 ))
+	else
+		size=
+	fi
+	dd if=/dev/zero of=$fn bs=16M oflag=direct $size &>/dev/null
+	ls -l $fn | awk '{ print $5 }'
+}
+
+#
+#	fill a filesystem with disks tagged METADATA/DATA ONLY and check that only the
+#	latter are used
+#
+test_raid1_data_only() {
+	local blkdev0 blkdev1 blkdev2 blkdev3
+	blkdev0=$(echo $disks | awk '{ print $1 }')
+	blkdev1=$(echo $disks | awk '{ print $2 }')
+	blkdev2=$(echo $disks | awk '{ print $3 }')
+	blkdev3=$(echo $disks | awk '{ print $4 }')
+	$BTRFS_UTIL_PROG  dev scan -u
+	_mkfs_dev -draid1 -mraid1 $blkdev0 $blkdev1 $blkdev2 $blkdev3
+	_mount $blkdev0 $SCRATCH_MNT
+
+	[ $(ls /sys/fs/btrfs/*/devinfo/*/allocation_hint | wc -l) -gt 0 ] ||
+		_notrun "Kernel with allocation_hint support required"
+
+	$BTRFS_UTIL_PROG prop set $(realpath $blkdev0)  allocation_hint METADATA_ONLY
+	$BTRFS_UTIL_PROG prop set $(realpath $blkdev1)  allocation_hint METADATA_ONLY
+	$BTRFS_UTIL_PROG prop set $(realpath $blkdev2)  allocation_hint DATA_ONLY
+	$BTRFS_UTIL_PROG prop set $(realpath $blkdev3)  allocation_hint DATA_ONLY
+
+	$BTRFS_UTIL_PROG balance start --full-balance $SCRATCH_MNT
+
+	size=$(create_file x )
+
+	[ $size -gt $(($MAXSIZE * 2 * 2 / 3 )) ] && _fail "File too big: check mnt/"
+	[ $size -lt $(($MAXSIZE * 2 / 3 )) ] && _fail "File too small: check mnt/"
+
+	btrfs_check_data_bg_in_disk $SCRATCH_MNT $blkdev2 $blkdev3
+	btrfs_check_data_bg_not_in_disk $SCRATCH_MNT $blkdev0 $blkdev1
+
+	umount $SCRATCH_MNT
+}
+
+setup_dmdev
+test_raid1_data_only
+
+echo "Silence is golden"
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/258.out b/tests/btrfs/258.out
new file mode 100644
index 00000000..36c5288a
--- /dev/null
+++ b/tests/btrfs/258.out
@@ -0,0 +1,3 @@
+QA output created by 258
+Done, had to relocate 3 out of 3 chunks
+Silence is golden
diff --git a/tests/btrfs/259 b/tests/btrfs/259
new file mode 100755
index 00000000..a2f3ce18
--- /dev/null
+++ b/tests/btrfs/259
@@ -0,0 +1,139 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# FS QA Test No. 259
+#
+# Test the allocation_hint property of a btrfs filesystem
+#
+
+
+# size of the disk used; default 1GB
+MAXSIZE=$((1*1024*1024*1024))
+NDEVS=2
+DEBUG=
+
+. ./common/preamble
+_begin_fstest auto quick allocation_hint
+
+seq=`basename $0`
+seqres="${RESULT_DIR}/${seq}"
+
+disks=""
+nodes=""
+
+# Override the default cleanup function.
+_cleanup()
+{
+	umount $SCRATCH_MNT &>/dev/null || true
+	for disk in $disks; do
+		_dmsetup_remove $disk
+	done
+}
+
+# Import common functions.
+. ./common/filter
+. ./common/filter.btrfs
+
+# real QA test starts here
+_supported_fs btrfs
+_require_block_device $SCRATCH_DEV
+_require_dm_target linear
+_require_scratch_nocheck
+_require_command "$WIPEFS_PROG" wipefs
+_try_wipe_scratch_devs
+
+_require_btrfs_property_get "allocation_hint"
+
+# dont' use _require_scratch_size because it pretend that the filesystem is
+# scratch_dev is consistent
+devsize=`_get_device_size $SCRATCH_DEV`
+[ $devsize -lt $((($MAXSIZE * $NDEVS + 100*1024*1024) / 1024)) ] &&
+		_notrun "scratch dev too small"
+
+setup_dmdev()
+{
+	# create some small size disks
+
+	size_in_sector=$(($MAXSIZE / 512))
+
+	off=2048
+	$WIPEFS_PROG -a $SCRATCH_DEV
+	for i in $(seq $NDEVS); do
+		node=dev${seq}test${i}
+		disk="/dev/mapper/$node"
+		disks="$disks $disk"
+		nodes="$nodes $node"
+		table="0 $size_in_sector linear $SCRATCH_DEV $off"
+		_dmsetup_create $node --table "$table" || \
+			_fail "setup dm device failed"
+		off=$(($off + $size_in_sector))
+		$WIPEFS_PROG -a $disk &>/dev/null
+	done
+}
+
+create_file() {
+	local fn=$SCRATCH_MNT/giant-file-$1
+	local size
+	if [ -n "$2" ]; then
+		size=count=$(($2 / 16 / 1024 / 1024 ))
+	else
+		size=
+	fi
+	dd if=/dev/zero of=$fn bs=16M oflag=direct $size &>/dev/null
+	ls -l $fn | awk '{ print $5 }'
+}
+
+#
+# create a file , switch the METADATA_ONLY <-> DATA_ONLY disk and check
+# that the data-bg are stored in the data disk
+#
+test_single_data_bouncing() {
+
+	local blkdev0 blkdev1
+	blkdev0=$(echo $disks | awk '{ print $1 }')
+	blkdev1=$(echo $disks | awk '{ print $2 }')
+	$BTRFS_UTIL_PROG dev scan -u
+	_mkfs_dev  -dsingle -msingle $blkdev0 $blkdev1
+	_mount $blkdev0 $SCRATCH_MNT
+
+	[ $(ls /sys/fs/btrfs/*/devinfo/*/allocation_hint | wc -l) -gt 0 ] ||
+		_notrun "Kernel with allocation_hint support required"
+
+	# use realpath because a link may confuse "btrfs prop get/set"
+	$BTRFS_UTIL_PROG prop set $(realpath $blkdev0) allocation_hint METADATA_ONLY
+	$BTRFS_UTIL_PROG prop set $(realpath $blkdev1) allocation_hint DATA_ONLY
+
+	$BTRFS_UTIL_PROG balance start --full-balance $SCRATCH_MNT
+
+	size=$(create_file x  $(($MAXSIZE * 2 / 4 )))
+
+	[ $size -gt $(($MAXSIZE * 2 / 3 )) ] && _fail "File too big: check mnt/"
+	[ $size -lt $(($MAXSIZE * 1 / 3 )) ] && _fail "File too small: check mnt/"
+
+	btrfs_check_data_bg_in_disk $SCRATCH_MNT $blkdev1
+	btrfs_check_data_bg_not_in_disk $SCRATCH_MNT $blkdev0
+
+	$BTRFS_UTIL_PROG balance start --full-balance $SCRATCH_MNT
+
+	btrfs_check_data_bg_in_disk $SCRATCH_MNT $blkdev1
+	btrfs_check_data_bg_not_in_disk $SCRATCH_MNT $blkdev0
+
+	# use realpath because a link may confuse "btrfs prop get/set"
+	$BTRFS_UTIL_PROG prop set $(realpath $blkdev1) allocation_hint METADATA_ONLY
+	$BTRFS_UTIL_PROG prop set $(realpath $blkdev0) allocation_hint DATA_ONLY
+
+	$BTRFS_UTIL_PROG balance start --full-balance $SCRATCH_MNT
+
+	btrfs_check_data_bg_in_disk $SCRATCH_MNT $blkdev0
+	btrfs_check_data_bg_not_in_disk $SCRATCH_MNT $blkdev1
+
+	umount $SCRATCH_MNT
+}
+
+setup_dmdev
+test_single_data_bouncing
+
+echo "Silence is golden"
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/259.out b/tests/btrfs/259.out
new file mode 100644
index 00000000..c3547c6a
--- /dev/null
+++ b/tests/btrfs/259.out
@@ -0,0 +1,5 @@
+QA output created by 259
+Done, had to relocate 3 out of 3 chunks
+Done, had to relocate 5 out of 5 chunks
+Done, had to relocate 5 out of 5 chunks
+Silence is golden
diff --git a/tests/btrfs/260 b/tests/btrfs/260
new file mode 100755
index 00000000..949d7abc
--- /dev/null
+++ b/tests/btrfs/260
@@ -0,0 +1,158 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# FS QA Test No. 260
+#
+# Test the allocation_hint property of a btrfs filesystem
+#
+
+
+# size of the disk used; default 1GB
+MAXSIZE=$((1*1024*1024*1024))
+NDEVS=4
+DEBUG=
+
+. ./common/preamble
+_begin_fstest auto quick allocation_hint
+
+seq=`basename $0`
+seqres="${RESULT_DIR}/${seq}"
+
+disks=""
+nodes=""
+
+# Override the default cleanup function.
+_cleanup()
+{
+	umount $SCRATCH_MNT &>/dev/null || true
+	for disk in $disks; do
+		_dmsetup_remove $disk
+	done
+}
+
+# Import common functions.
+. ./common/filter
+. ./common/filter.btrfs
+
+# real QA test starts here
+_supported_fs btrfs
+_require_block_device $SCRATCH_DEV
+_require_dm_target linear
+_require_scratch_nocheck
+_require_command "$WIPEFS_PROG" wipefs
+_try_wipe_scratch_devs
+
+_require_btrfs_property_get "allocation_hint"
+
+# dont' use _require_scratch_size because it pretend that the filesystem is
+# scratch_dev is consistent
+devsize=`_get_device_size $SCRATCH_DEV`
+[ $devsize -lt $((($MAXSIZE * $NDEVS + 100*1024*1024) / 1024)) ] &&
+		_notrun "scratch dev too small"
+
+setup_dmdev()
+{
+	# create some small size disks
+
+	size_in_sector=$(($MAXSIZE / 512))
+
+	off=2048
+	$WIPEFS_PROG -a $SCRATCH_DEV
+	for i in $(seq $NDEVS); do
+		node=dev${seq}test${i}
+		disk="/dev/mapper/$node"
+		disks="$disks $disk"
+		nodes="$nodes $node"
+		table="0 $size_in_sector linear $SCRATCH_DEV $off"
+		_dmsetup_create $node --table "$table" || \
+			_fail "setup dm device failed"
+		off=$(($off + $size_in_sector))
+		$WIPEFS_PROG -a $disk &>/dev/null
+	done
+}
+
+create_file() {
+	local fn=$SCRATCH_MNT/giant-file-$1
+	local size
+	if [ -n "$2" ]; then
+		size=count=$(($2 / 16 / 1024 / 1024 ))
+	else
+		size=
+	fi
+	dd if=/dev/zero of=$fn bs=16M oflag=direct $size &>/dev/null
+	ls -l $fn | awk '{ print $5 }'
+}
+
+#
+# create files that consume the space avaiable on the disks, and check
+# that the order of allocation is maintained
+#
+test_single_progressive_fill_data() {
+
+	local blkdev0 blkdev1 blkdev2 blkdev3
+	blkdev0=$(echo $disks | awk '{ print $1 }')
+	blkdev1=$(echo $disks | awk '{ print $2 }')
+	blkdev2=$(echo $disks | awk '{ print $3 }')
+	blkdev3=$(echo $disks | awk '{ print $4 }')
+	$BTRFS_UTIL_PROG  dev scan -u
+	_mkfs_dev -dsingle -msingle $blkdev0 $blkdev1 $blkdev2 $blkdev3
+	_mount $blkdev0 $SCRATCH_MNT
+
+	[ $(ls /sys/fs/btrfs/*/devinfo/*/allocation_hint | wc -l) -gt 0 ] ||
+		_notrun "Kernel with allocation_hint support required"
+
+	# use realpath because a link may confuse "btrfs prop get/set"
+	$BTRFS_UTIL_PROG prop set $(realpath $blkdev0) allocation_hint METADATA_ONLY
+	$BTRFS_UTIL_PROG prop set $(realpath $blkdev1) allocation_hint METADATA_PREFERRED
+	$BTRFS_UTIL_PROG prop set $(realpath $blkdev2) allocation_hint DATA_PREFERRED
+	$BTRFS_UTIL_PROG prop set $(realpath $blkdev3) allocation_hint DATA_ONLY
+
+	$BTRFS_UTIL_PROG balance start --full-balance $SCRATCH_MNT
+
+	size=$(create_file x  $(( $MAXSIZE / 3 )))
+
+	for i in 1 2 3; do
+		btrfs_check_data_bg_in_disk $SCRATCH_MNT  $blkdev3
+		btrfs_check_data_bg_not_in_disk $SCRATCH_MNT  $blkdev1 $blkdev2 $blkdev0
+		$BTRFS_UTIL_PROG balance start --full-balance $SCRATCH_MNT &>/dev/null
+	done
+
+	# fill $blkdev3 then $blkdev2
+
+    size=$(create_file y  $(( $MAXSIZE )))
+
+	for i in 1 2 3; do
+		btrfs_check_data_bg_in_disk $SCRATCH_MNT  $blkdev3 $blkdev2
+		btrfs_check_data_bg_not_in_disk $SCRATCH_MNT  $blkdev1 $blkdev0
+		$BTRFS_UTIL_PROG balance start --full-balance $SCRATCH_MNT &>/dev/null
+	done
+
+	# fill $blkdev3 then $blkdev2, then $blkdev1
+
+    size=$(create_file z  $(( $MAXSIZE )))
+
+	for i in 1 2 3; do
+		btrfs_check_data_bg_in_disk $SCRATCH_MNT  $blkdev3 $blkdev2 $blkdev1
+		btrfs_check_data_bg_not_in_disk $SCRATCH_MNT  $blkdev0
+		$BTRFS_UTIL_PROG balance start --full-balance $SCRATCH_MNT &>/dev/null
+	done
+
+	# fill the disk
+
+    size=$(create_file w  )
+
+	# when the disk is filled not balance is possible
+	btrfs_check_data_bg_in_disk $SCRATCH_MNT  $blkdev3 $blkdev2 $blkdev1
+	btrfs_check_data_bg_not_in_disk $SCRATCH_MNT  $blkdev0
+
+
+	umount $SCRATCH_MNT
+}
+
+setup_dmdev
+test_single_progressive_fill_data
+
+echo "Silence is golden"
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/260.out b/tests/btrfs/260.out
new file mode 100644
index 00000000..1476ce8f
--- /dev/null
+++ b/tests/btrfs/260.out
@@ -0,0 +1,3 @@
+QA output created by 260
+Done, had to relocate 3 out of 3 chunks
+Silence is golden
diff --git a/tests/btrfs/261 b/tests/btrfs/261
new file mode 100755
index 00000000..080f8b4d
--- /dev/null
+++ b/tests/btrfs/261
@@ -0,0 +1,144 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# FS QA Test No. 261
+#
+# Test the allocation_hint property of a btrfs filesystem
+#
+
+
+# size of the disk used; default 1GB
+MAXSIZE=$((1*1024*1024*1024))
+NDEVS=5
+DEBUG=
+
+. ./common/preamble
+_begin_fstest auto quick allocation_hint
+
+seq=`basename $0`
+seqres="${RESULT_DIR}/${seq}"
+
+disks=""
+nodes=""
+
+# Override the default cleanup function.
+_cleanup()
+{
+	umount $SCRATCH_MNT &>/dev/null || true
+	for disk in $disks; do
+		_dmsetup_remove $disk
+	done
+}
+
+# Import common functions.
+. ./common/filter
+. ./common/filter.btrfs
+
+# real QA test starts here
+_supported_fs btrfs
+_require_block_device $SCRATCH_DEV
+_require_dm_target linear
+_require_scratch_nocheck
+_require_command "$WIPEFS_PROG" wipefs
+_try_wipe_scratch_devs
+
+_require_btrfs_property_get "allocation_hint"
+
+# dont' use _require_scratch_size because it pretend that the filesystem is
+# scratch_dev is consistent
+devsize=`_get_device_size $SCRATCH_DEV`
+[ $devsize -lt $((($MAXSIZE * $NDEVS + 100*1024*1024) / 1024)) ] &&
+		_notrun "scratch dev too small"
+
+setup_dmdev()
+{
+	# create some small size disks
+
+	size_in_sector=$(($MAXSIZE / 512))
+
+	off=2048
+	$WIPEFS_PROG -a $SCRATCH_DEV
+	for i in $(seq $NDEVS); do
+		node=dev${seq}test${i}
+		disk="/dev/mapper/$node"
+		disks="$disks $disk"
+		nodes="$nodes $node"
+		table="0 $size_in_sector linear $SCRATCH_DEV $off"
+		_dmsetup_create $node --table "$table" || \
+			_fail "setup dm device failed"
+		off=$(($off + $size_in_sector))
+		$WIPEFS_PROG -a $disk &>/dev/null
+	done
+}
+
+create_file() {
+	local fn=$SCRATCH_MNT/giant-file-$1
+	local size
+	if [ -n "$2" ]; then
+		size=count=$(($2 / 16 / 1024 / 1024 ))
+	else
+		size=
+	fi
+	dd if=/dev/zero of=$fn bs=16M oflag=direct $size &>/dev/null
+	ls -l $fn | awk '{ print $5 }'
+}
+
+#
+# create files that consume the space avaiable on the disks, and check
+# that the order of allocation is maintained
+#
+test_raid1_progressive_fill_data() {
+
+	local blkdev0 blkdev1 blkdev2 blkdev3
+	blkdev0=$(echo $disks | awk '{ print $1 }')
+	blkdev1=$(echo $disks | awk '{ print $2 }')
+	blkdev2=$(echo $disks | awk '{ print $3 }')
+	blkdev3=$(echo $disks | awk '{ print $4 }')
+	blkdev4=$(echo $disks | awk '{ print $5 }')
+	$BTRFS_UTIL_PROG  dev scan -u
+	_mkfs_dev -dRAID1 -msingle $blkdev0 $blkdev1 $blkdev2 $blkdev3 $blkdev4
+	_mount $blkdev0 $SCRATCH_MNT
+
+	[ $(ls /sys/fs/btrfs/*/devinfo/*/allocation_hint | wc -l) -gt 0 ] ||
+		_notrun "Kernel with allocation_hint support required"
+
+	# use realpath because a link may confuse "btrfs prop get/set"
+	$BTRFS_UTIL_PROG prop set $(realpath $blkdev0) allocation_hint METADATA_ONLY
+	$BTRFS_UTIL_PROG prop set $(realpath $blkdev1) allocation_hint METADATA_PREFERRED
+	$BTRFS_UTIL_PROG prop set $(realpath $blkdev2) allocation_hint DATA_PREFERRED
+	$BTRFS_UTIL_PROG prop set $(realpath $blkdev3) allocation_hint DATA_ONLY
+	$BTRFS_UTIL_PROG prop set $(realpath $blkdev4) allocation_hint DATA_ONLY
+
+	$BTRFS_UTIL_PROG balance start --full-balance $SCRATCH_MNT
+
+	size=$(create_file x  $(( $MAXSIZE / 5 )))
+
+	# fill $blkdev3 $blkdev4
+	for i in 1 2 3; do
+		btrfs_check_data_bg_in_disk $SCRATCH_MNT  $blkdev3 $blkdev4
+		btrfs_check_data_bg_not_in_disk $SCRATCH_MNT  $blkdev1 $blkdev2 $blkdev0
+
+		$BTRFS_UTIL_PROG balance start --full-balance $SCRATCH_MNT &>/dev/null
+	done
+
+	# fill $blkdev3 $blkdev4, then $blkdev1 and $blkdev2
+    size=$(create_file y  $(( $MAXSIZE )))
+
+	for i in 1 2 3; do
+		btrfs_check_data_bg_in_disk $SCRATCH_MNT  $blkdev3 $blkdev2 $blkdev4 $blkdev1
+		btrfs_check_data_bg_not_in_disk $SCRATCH_MNT  $blkdev0
+
+		$BTRFS_UTIL_PROG balance start --full-balance $SCRATCH_MNT &>/dev/null
+	done
+
+
+	umount $SCRATCH_MNT
+}
+
+setup_dmdev
+test_raid1_progressive_fill_data
+
+echo "Silence is golden"
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/261.out b/tests/btrfs/261.out
new file mode 100755
index 00000000..eadc8a4e
--- /dev/null
+++ b/tests/btrfs/261.out
@@ -0,0 +1,3 @@
+QA output created by 261
+Done, had to relocate 3 out of 3 chunks
+Silence is golden
diff --git a/tests/btrfs/262 b/tests/btrfs/262
new file mode 100755
index 00000000..82d2b5a9
--- /dev/null
+++ b/tests/btrfs/262
@@ -0,0 +1,121 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# FS QA Test No. 262
+#
+# Test the allocation_hint property of a btrfs filesystem
+#
+
+
+# size of the disk used; default 1GB
+MAXSIZE=$((512*1024*1024))
+NDEVS=2
+DEBUG=
+
+. ./common/preamble
+_begin_fstest auto allocation_hint
+
+seq=`basename $0`
+seqres="${RESULT_DIR}/${seq}"
+
+disks=""
+nodes=""
+
+# Override the default cleanup function.
+_cleanup()
+{
+	umount $SCRATCH_MNT &>/dev/null || true
+	for disk in $disks; do
+		_dmsetup_remove $disk
+	done
+}
+
+# Import common functions.
+. ./common/filter
+. ./common/filter.btrfs
+
+# real QA test starts here
+_supported_fs btrfs
+_require_block_device $SCRATCH_DEV
+_require_dm_target linear
+_require_scratch_nocheck
+_require_command "$WIPEFS_PROG" wipefs
+_try_wipe_scratch_devs
+
+_require_btrfs_property_get "allocation_hint"
+
+# dont' use _require_scratch_size because it pretend that the filesystem is
+# scratch_dev is consistent
+devsize=`_get_device_size $SCRATCH_DEV`
+[ $devsize -lt $((($MAXSIZE * $NDEVS + 100*1024*1024) / 1024)) ] &&
+		_notrun "scratch dev too small"
+
+setup_dmdev()
+{
+	# create some small size disks
+
+	size_in_sector=$(($MAXSIZE / 512))
+
+	off=0
+	for i in $(seq $NDEVS); do
+		node=dev${seq}test${i}
+		disk="/dev/mapper/$node"
+		disks="$disks $disk"
+		nodes="$nodes $node"
+		table="0 $size_in_sector linear $SCRATCH_DEV $off"
+		_dmsetup_create $node --table "$table" || \
+			_fail "setup dm device failed"
+		off=$(($off + $size_in_sector))
+		$WIPEFS_PROG -a $disk &>/dev/null
+	done
+}
+
+create_small_file() {
+	local fn=$SCRATCH_MNT/small-file-$1
+	local size=$2
+	dd if=/dev/zero of=$fn bs=$size oflag=direct count=1 &>/dev/null
+	ls -l $fn | awk '{ print $5 }'
+}
+
+#
+# near fill all the metadata dedicated disk, and check that the data dedicated
+# is unused
+#
+test_single_preferred_metadata_slow() {
+
+	local blkdev0 blkdev1
+	blkdev0=$(echo $disks | awk '{ print $1 }')
+	blkdev1=$(echo $disks | awk '{ print $2 }')
+	$BTRFS_UTIL_PROG dev scan -u
+	_mkfs_dev  -dsingle -msingle $blkdev0 $blkdev1
+	_mount $blkdev0 $SCRATCH_MNT
+
+	[ $(ls /sys/fs/btrfs/*/devinfo/*/allocation_hint | wc -l) -gt 0 ] ||
+		_notrun "Kernel with allocation_hint support required"
+
+	# use realpath because a link may confuse "btrfs prop get/set"
+	$BTRFS_UTIL_PROG prop set $(realpath $blkdev0) allocation_hint METADATA_PREFERRED
+	$BTRFS_UTIL_PROG prop set $(realpath $blkdev1) allocation_hint DATA_PREFERRED
+
+	$BTRFS_UTIL_PROG balance start --full-balance $SCRATCH_MNT
+
+	# create files that fit in the metadata node (i.e. size <= 2048 bytes)
+	# fill up to 7/10 of a disk
+	fnsize=2048
+	for i in $(seq $(( $MAXSIZE / $fnsize * 700 / 1000))); do
+		create_small_file $i $fnsize &>/dev/null
+	done
+
+	btrfs_check_metadata_bg_in_disk $SCRATCH_MNT $blkdev0
+	btrfs_check_metadata_bg_not_in_disk $SCRATCH_MNT $blkdev1
+
+	umount $SCRATCH_MNT
+}
+
+setup_dmdev
+test_single_preferred_metadata_slow
+
+echo "Silence is golden"
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/262.out b/tests/btrfs/262.out
new file mode 100644
index 00000000..a23bf303
--- /dev/null
+++ b/tests/btrfs/262.out
@@ -0,0 +1,3 @@
+QA output created by 262
+Done, had to relocate 3 out of 3 chunks
+Silence is golden
diff --git a/tests/btrfs/263 b/tests/btrfs/263
new file mode 100755
index 00000000..bb876620
--- /dev/null
+++ b/tests/btrfs/263
@@ -0,0 +1,123 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# FS QA Test No. 263
+#
+# Test the allocation_hint property of a btrfs filesystem
+#
+
+
+# size of the disk used; default 1GB
+MAXSIZE=$((512*1024*1024))
+NDEVS=4
+DEBUG=
+
+. ./common/preamble
+_begin_fstest auto allocation_hint
+
+seq=`basename $0`
+seqres="${RESULT_DIR}/${seq}"
+
+disks=""
+nodes=""
+
+# Override the default cleanup function.
+_cleanup()
+{
+	umount $SCRATCH_MNT &>/dev/null || true
+	for disk in $disks; do
+		_dmsetup_remove $disk
+	done
+}
+
+# Import common functions.
+. ./common/filter
+. ./common/filter.btrfs
+
+# real QA test starts here
+_supported_fs btrfs
+_require_block_device $SCRATCH_DEV
+_require_dm_target linear
+_require_scratch_nocheck
+_require_command "$WIPEFS_PROG" wipefs
+_try_wipe_scratch_devs
+
+_require_btrfs_property_get "allocation_hint"
+
+# dont' use _require_scratch_size because it pretend that the filesystem is
+# scratch_dev is consistent
+devsize=`_get_device_size $SCRATCH_DEV`
+[ $devsize -lt $((($MAXSIZE * $NDEVS + 100*1024*1024) / 1024)) ] &&
+		_notrun "scratch dev too small"
+
+setup_dmdev()
+{
+	# create some small size disks
+
+	size_in_sector=$(($MAXSIZE / 512))
+
+	off=0
+	for i in $(seq $NDEVS); do
+		node=dev${seq}test${i}
+		disk="/dev/mapper/$node"
+		disks="$disks $disk"
+		nodes="$nodes $node"
+		table="0 $size_in_sector linear $SCRATCH_DEV $off"
+		_dmsetup_create $node --table "$table" || \
+			_fail "setup dm device failed"
+		off=$(($off + $size_in_sector))
+		$WIPEFS_PROG -a $disk &>/dev/null
+	done
+}
+
+create_small_file() {
+	local fn=$SCRATCH_MNT/small-file-$1
+	local size=$2
+	dd if=/dev/zero of=$fn bs=$size oflag=direct count=1 &>/dev/null
+	ls -l $fn | awk '{ print $5 }'
+}
+
+#
+# near fill all the metadata dedicated disks, and check that the data dedicated
+# are unused
+#
+test_raid1_preferred_metadata_slow() {
+	local blkdev0 blkdev1 blkdev2 blkdev3
+	blkdev0=$(echo $disks | awk '{ print $1 }')
+	blkdev1=$(echo $disks | awk '{ print $2 }')
+	blkdev2=$(echo $disks | awk '{ print $3 }')
+	blkdev3=$(echo $disks | awk '{ print $4 }')
+	$BTRFS_UTIL_PROG  dev scan -u
+	_mkfs_dev -draid1 -mraid1 $blkdev0 $blkdev1 $blkdev2 $blkdev3
+	_mount $blkdev0 $SCRATCH_MNT
+
+	[ $(ls /sys/fs/btrfs/*/devinfo/*/allocation_hint | wc -l) -gt 0 ] ||
+		_notrun "Kernel with allocation_hint support required"
+
+	$BTRFS_UTIL_PROG prop set $(realpath $blkdev0)  allocation_hint METADATA_PREFERRED
+	$BTRFS_UTIL_PROG prop set $(realpath $blkdev1)  allocation_hint METADATA_PREFERRED
+	$BTRFS_UTIL_PROG prop set $(realpath $blkdev2)  allocation_hint DATA_PREFERRED
+	$BTRFS_UTIL_PROG prop set $(realpath $blkdev3)  allocation_hint DATA_PREFERRED
+
+	$BTRFS_UTIL_PROG balance start --full-balance $SCRATCH_MNT
+
+	# create files that fit in the metadata node (i.e. size <= 2048 bytes)
+	# fill up to 6/10 of a disk
+	fnsize=2048
+	for i in $(seq $(( $MAXSIZE / $fnsize * 600 / 1000))); do
+		create_small_file $i $fnsize &>/dev/null
+	done
+
+	btrfs_check_metadata_bg_in_disk $SCRATCH_MNT $blkdev0 $blkdev1
+	btrfs_check_metadata_bg_not_in_disk $SCRATCH_MNT $blkdev2 $blkdev3
+
+	umount $SCRATCH_MNT
+}
+
+setup_dmdev
+test_raid1_preferred_metadata_slow
+
+echo "Silence is golden"
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/263.out b/tests/btrfs/263.out
new file mode 100644
index 00000000..f7fc66ec
--- /dev/null
+++ b/tests/btrfs/263.out
@@ -0,0 +1,3 @@
+QA output created by 263
+Done, had to relocate 3 out of 3 chunks
+Silence is golden
diff --git a/tests/btrfs/264 b/tests/btrfs/264
new file mode 100755
index 00000000..b00a35a7
--- /dev/null
+++ b/tests/btrfs/264
@@ -0,0 +1,121 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# FS QA Test No. 264
+#
+# Test the allocation_hint property of a btrfs filesystem
+#
+
+
+# size of the disk used; default 1GB
+MAXSIZE=$((1*1024*1024*1024))
+NDEVS=2
+DEBUG=
+
+. ./common/preamble
+_begin_fstest auto quick allocation_hint
+
+seq=`basename $0`
+seqres="${RESULT_DIR}/${seq}"
+
+# Override the default cleanup function.
+disks=""
+nodes=""
+
+_cleanup()
+{
+	umount $SCRATCH_MNT &>/dev/null || true
+	for disk in $disks; do
+		_dmsetup_remove $disk
+	done
+}
+
+# Import common functions.
+. ./common/filter
+. ./common/filter.btrfs
+
+# real QA test starts here
+_supported_fs btrfs
+_require_block_device $SCRATCH_DEV
+_require_dm_target linear
+_require_scratch_nocheck
+_require_command "$WIPEFS_PROG" wipefs
+_try_wipe_scratch_devs
+
+_require_btrfs_property_get "allocation_hint"
+
+# dont' use _require_scratch_size because it pretend that the filesystem is
+# scratch_dev is consistent
+devsize=`_get_device_size $SCRATCH_DEV`
+[ $devsize -lt $((($MAXSIZE * $NDEVS + 100*1024*1024) / 1024)) ] &&
+		_notrun "scratch dev too small"
+
+setup_dmdev()
+{
+	# create some small size disks
+
+	size_in_sector=$(($MAXSIZE / 512))
+
+	off=0
+	for i in $(seq $NDEVS); do
+		node=dev${seq}test${i}
+		disk="/dev/mapper/$node"
+		disks="$disks $disk"
+		nodes="$nodes $node"
+		table="0 $size_in_sector linear $SCRATCH_DEV $off"
+		_dmsetup_create $node --table "$table" || \
+			_fail "setup dm device failed"
+		off=$(($off + $size_in_sector))
+		$WIPEFS_PROG -a $disk &>/dev/null
+	done
+}
+
+create_file() {
+	local fn=$SCRATCH_MNT/giant-file-$1
+	local size
+	if [ -n "$2" ]; then
+		size=count=$(($2 / 16 / 1024 / 1024 ))
+	else
+		size=
+	fi
+	dd if=/dev/zero of=$fn bs=16M oflag=direct $size &>/dev/null
+	ls -l $fn | awk '{ print $5 }'
+}
+
+#
+# create a file and check that the Data BG is in the correct disk
+# force the compression flag
+#
+test_single_preferred_data_compression() {
+
+	local blkdev0 blkdev1
+	blkdev0=$(echo $disks | awk '{ print $1 }')
+	blkdev1=$(echo $disks | awk '{ print $2 }')
+	$BTRFS_UTIL_PROG dev scan -u
+	_mkfs_dev  -dsingle -msingle $blkdev0 $blkdev1
+	_mount -o compress $blkdev0 $SCRATCH_MNT
+
+	[ $(ls /sys/fs/btrfs/*/devinfo/*/allocation_hint | wc -l) -gt 0 ] ||
+		_notrun "Kernel with allocation_hint support required"
+
+	# use realpath because a link may confuse "btrfs prop get/set"
+	$BTRFS_UTIL_PROG prop set $(realpath $blkdev0) allocation_hint METADATA_PREFERRED
+	$BTRFS_UTIL_PROG prop set $(realpath $blkdev1) allocation_hint DATA_PREFERRED
+
+	$BTRFS_UTIL_PROG balance start --full-balance $SCRATCH_MNT
+
+	size=$(create_file x $(($MAXSIZE / 2)) )
+
+	btrfs_check_data_bg_in_disk $SCRATCH_MNT $blkdev1
+	btrfs_check_data_bg_not_in_disk $SCRATCH_MNT $blkdev0
+
+	umount $SCRATCH_MNT
+}
+
+setup_dmdev
+test_single_preferred_data_compression
+
+echo "Silence is golden"
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/264.out b/tests/btrfs/264.out
new file mode 100644
index 00000000..1611be72
--- /dev/null
+++ b/tests/btrfs/264.out
@@ -0,0 +1,3 @@
+QA output created by 264
+Done, had to relocate 3 out of 3 chunks
+Silence is golden
-- 
2.34.1

