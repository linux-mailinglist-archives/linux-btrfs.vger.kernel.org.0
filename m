Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 116574CED31
	for <lists+linux-btrfs@lfdr.de>; Sun,  6 Mar 2022 19:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232846AbiCFSXy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 6 Mar 2022 13:23:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiCFSXx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 6 Mar 2022 13:23:53 -0500
Received: from smtp.tiscali.it (michael.mail.tiscali.it [213.205.33.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 67380E0A9
        for <linux-btrfs@vger.kernel.org>; Sun,  6 Mar 2022 10:22:56 -0800 (PST)
Received: from venice.bhome ([78.12.27.75])
        by michael.mail.tiscali.it with 
        id 36Nv2700b1dDdji016Nv61; Sun, 06 Mar 2022 18:22:56 +0000
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
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH][REPOST][V12] xfstest: add tests for allocation_hint
Date:   Sun,  6 Mar 2022 19:22:53 +0100
Message-Id: <2ba77fb2dad1732e20d03ce5009f37af557dc4c8.1646590740.git.kreijack@inwind.it>
X-Mailer: git-send-email 2.35.1
Reply-To: Goffredo Baroncelli <kreijack@libero.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tiscali.it; s=smtp;
        t=1646590976; bh=OfOqmQysFliGDfW8aAdkJloG32+UsnLEN7ROW2hP4Nc=;
        h=From:To:Cc:Subject:Date:Reply-To;
        b=maH6vsU7fJvIVPSWofEk8No9WgPTH/RjGB2pkyE0GN62bAGO9exzGmKvozmuN74Of
         wV6yuwHvdm4Chsbo22+OI92wy8GXOE8AnPdrsXs1473Cr80HgJTvtF/9NTRmcKolnB
         lYfzyPthcMjymGO742kghBBQFrBWDHBIaGH6ZcDI=
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goffredo Baroncelli <kreijack@inwind.it>

[I repost this patch because in the previous attempt I forgot
the comment]

Hi All,

the enclosed patch adds tests to the xfstest suite to check the
btrfs allocation_hint property.

Each test creates file and fills the different disks, up to
trigger a new BG data (or metadata) allocation. Then the
test checks if the allocation if the new BG is perfomed
in the new disk.

Because we need to fill an entire disk, the tests are performed
on some device-mapper slices of $SCRATCH_DEV. The slices have
a length of 1GB (512MB for test 269/270)

This is my first xfstest patches, so I expected to do a lot
of error :-); a deeply review is appreciated.

Test 269 and 270 are quite long (about 5-8 minutes on my virtual
machine with sync disabled). This because I need to fill a 512MB
disk of metadata. The only way to do that is to fill the disk with
a lot of 2k size files. This is very slow. If someone has a better
way to do that, it is very appreciated.

I added a V12 tag because the allocation_hint patch set is in
the 12th revision.

Changelog:
- V12:
Rebase to the latest version of xfstest suite (renamed the tests from
255...264 to 262..271)
- V10:
First issue

BR
G.Baroncelli

---
 common/btrfs        |  87 ++++++++++++++++++++++++
 doc/group-names.txt |   1 +
 tests/btrfs/262     | 120 +++++++++++++++++++++++++++++++++
 tests/btrfs/262.out |   3 +
 tests/btrfs/263     | 123 ++++++++++++++++++++++++++++++++++
 tests/btrfs/263.out |   3 +
 tests/btrfs/264     | 123 ++++++++++++++++++++++++++++++++++
 tests/btrfs/264.out |   3 +
 tests/btrfs/265     | 126 +++++++++++++++++++++++++++++++++++
 tests/btrfs/265.out |   3 +
 tests/btrfs/266     | 139 ++++++++++++++++++++++++++++++++++++++
 tests/btrfs/266.out |   5 ++
 tests/btrfs/267     | 158 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/267.out |   3 +
 tests/btrfs/268     | 144 ++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/268.out |   3 +
 tests/btrfs/269     | 121 +++++++++++++++++++++++++++++++++
 tests/btrfs/269.out |   3 +
 tests/btrfs/270     | 123 ++++++++++++++++++++++++++++++++++
 tests/btrfs/270.out |   3 +
 tests/btrfs/271     | 121 +++++++++++++++++++++++++++++++++
 tests/btrfs/271.out |   3 +
 22 files changed, 1418 insertions(+)
 create mode 100755 tests/btrfs/262
 create mode 100644 tests/btrfs/262.out
 create mode 100755 tests/btrfs/263
 create mode 100644 tests/btrfs/263.out
 create mode 100755 tests/btrfs/264
 create mode 100644 tests/btrfs/264.out
 create mode 100755 tests/btrfs/265
 create mode 100644 tests/btrfs/265.out
 create mode 100755 tests/btrfs/266
 create mode 100644 tests/btrfs/266.out
 create mode 100755 tests/btrfs/267
 create mode 100644 tests/btrfs/267.out
 create mode 100755 tests/btrfs/268
 create mode 100755 tests/btrfs/268.out
 create mode 100755 tests/btrfs/269
 create mode 100644 tests/btrfs/269.out
 create mode 100755 tests/btrfs/270
 create mode 100644 tests/btrfs/270.out
 create mode 100755 tests/btrfs/271
 create mode 100644 tests/btrfs/271.out

diff --git a/common/btrfs b/common/btrfs
index 670d9d1f..e6e7073f 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -511,3 +511,90 @@ _btrfs_metadump()
 	$BTRFS_IMAGE_PROG "$device" "$dumpfile"
 	[ -n "$DUMP_COMPRESSOR" ] && $DUMP_COMPRESSOR -f "$dumpfile" &> /dev/null
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
diff --git a/tests/btrfs/262 b/tests/btrfs/262
new file mode 100755
index 00000000..d67145e4
--- /dev/null
+++ b/tests/btrfs/262
@@ -0,0 +1,120 @@
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
index 00000000..742f497b
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
index 00000000..fe2c9145
--- /dev/null
+++ b/tests/btrfs/264
@@ -0,0 +1,123 @@
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
diff --git a/tests/btrfs/264.out b/tests/btrfs/264.out
new file mode 100644
index 00000000..1611be72
--- /dev/null
+++ b/tests/btrfs/264.out
@@ -0,0 +1,3 @@
+QA output created by 264
+Done, had to relocate 3 out of 3 chunks
+Silence is golden
diff --git a/tests/btrfs/265 b/tests/btrfs/265
new file mode 100755
index 00000000..2955f62c
--- /dev/null
+++ b/tests/btrfs/265
@@ -0,0 +1,126 @@
+##! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# FS QA Test No. 265
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
diff --git a/tests/btrfs/265.out b/tests/btrfs/265.out
new file mode 100644
index 00000000..a31698f1
--- /dev/null
+++ b/tests/btrfs/265.out
@@ -0,0 +1,3 @@
+QA output created by 265
+Done, had to relocate 3 out of 3 chunks
+Silence is golden
diff --git a/tests/btrfs/266 b/tests/btrfs/266
new file mode 100755
index 00000000..f0df10a2
--- /dev/null
+++ b/tests/btrfs/266
@@ -0,0 +1,139 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# FS QA Test No. 266
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
diff --git a/tests/btrfs/266.out b/tests/btrfs/266.out
new file mode 100644
index 00000000..4ebfdea2
--- /dev/null
+++ b/tests/btrfs/266.out
@@ -0,0 +1,5 @@
+QA output created by 266
+Done, had to relocate 3 out of 3 chunks
+Done, had to relocate 5 out of 5 chunks
+Done, had to relocate 5 out of 5 chunks
+Silence is golden
diff --git a/tests/btrfs/267 b/tests/btrfs/267
new file mode 100755
index 00000000..209d3dcf
--- /dev/null
+++ b/tests/btrfs/267
@@ -0,0 +1,158 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# FS QA Test No. 267
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
diff --git a/tests/btrfs/267.out b/tests/btrfs/267.out
new file mode 100644
index 00000000..15eb5ea7
--- /dev/null
+++ b/tests/btrfs/267.out
@@ -0,0 +1,3 @@
+QA output created by 267
+Done, had to relocate 3 out of 3 chunks
+Silence is golden
diff --git a/tests/btrfs/268 b/tests/btrfs/268
new file mode 100755
index 00000000..a4a0ed0e
--- /dev/null
+++ b/tests/btrfs/268
@@ -0,0 +1,144 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# FS QA Test No. 268
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
diff --git a/tests/btrfs/268.out b/tests/btrfs/268.out
new file mode 100755
index 00000000..c21cddb8
--- /dev/null
+++ b/tests/btrfs/268.out
@@ -0,0 +1,3 @@
+QA output created by 268
+Done, had to relocate 3 out of 3 chunks
+Silence is golden
diff --git a/tests/btrfs/269 b/tests/btrfs/269
new file mode 100755
index 00000000..d04a90ea
--- /dev/null
+++ b/tests/btrfs/269
@@ -0,0 +1,121 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# FS QA Test No. 269
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
diff --git a/tests/btrfs/269.out b/tests/btrfs/269.out
new file mode 100644
index 00000000..4f7f75f4
--- /dev/null
+++ b/tests/btrfs/269.out
@@ -0,0 +1,3 @@
+QA output created by 269
+Done, had to relocate 3 out of 3 chunks
+Silence is golden
diff --git a/tests/btrfs/270 b/tests/btrfs/270
new file mode 100755
index 00000000..04adb853
--- /dev/null
+++ b/tests/btrfs/270
@@ -0,0 +1,123 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# FS QA Test No. 270
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
diff --git a/tests/btrfs/270.out b/tests/btrfs/270.out
new file mode 100644
index 00000000..689f87c5
--- /dev/null
+++ b/tests/btrfs/270.out
@@ -0,0 +1,3 @@
+QA output created by 270
+Done, had to relocate 3 out of 3 chunks
+Silence is golden
diff --git a/tests/btrfs/271 b/tests/btrfs/271
new file mode 100755
index 00000000..bad36bdb
--- /dev/null
+++ b/tests/btrfs/271
@@ -0,0 +1,121 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# FS QA Test No. 271
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
diff --git a/tests/btrfs/271.out b/tests/btrfs/271.out
new file mode 100644
index 00000000..b696e42a
--- /dev/null
+++ b/tests/btrfs/271.out
@@ -0,0 +1,3 @@
+QA output created by 271
+Done, had to relocate 3 out of 3 chunks
+Silence is golden
-- 
2.35.1

