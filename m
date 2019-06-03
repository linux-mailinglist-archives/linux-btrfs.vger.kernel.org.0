Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72BBD3289E
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jun 2019 08:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfFCGkS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jun 2019 02:40:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:58488 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726383AbfFCGkS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 3 Jun 2019 02:40:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7C8F0AF3E;
        Mon,  3 Jun 2019 06:40:15 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: [PATCH v2] fstests: generic/260: Make it handle btrfs more gracefully
Date:   Mon,  3 Jun 2019 14:40:09 +0800
Message-Id: <20190603064009.9891-1-wqu@suse.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If a filesystem doesn't map its logical address space (normally the
bytenr/blocknr returned by fiemap) directly to its devices(s), the
following assumptions used in the test case is no longer true:
- trim range start beyond the end of fs should fail
- trim range start beyond the end of fs with len set should fail

Under the following example, even with just one device, btrfs can still
trim the fs correctly while breaking above assumption:

0		1G		1.25G
|---------------|///////////////|-----------------| <- btrfs logical
		   |				       address space
        ------------  mapped as SINGLE
        |
0	V	256M
|///////////////|			<- device address space

Thus trim range start=1G len=256M will cause btrfs to trim the 256M
block group, thus return correct result.

Furthermore, there is no cleared defined behavior for whether a fs should
trim the unmapped space. (only for indirectly mapped fs)

Btrfs currently will always trim the unmapped space, but the behavior
can change as large trim can be very expensive.

Despite the change to skip certain tests for btrfs, still run the
following tests for btrfs:
- trim start=U64_MAX with lenght set
  This will expose a bug that btrfs doesn't check overflow of the range.
  This bug will be fixed soon.

- trim beyond the end of the fs
  This will expose a bug where btrfs could send trim command beyond the
  end of its device.
  This bug is a regression, can be fixed by reverting c2d1b3aae336 ("btrfs:
  Honour FITRIM range constraints during free space trim")

With proper fixes for btrfs, this test case should pass on btrfs, ext4,
xfs.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
changelog:
v2:
- Return 0/1 instead of echo "1"/"0" for _is_fs_directly_mapped
  Although it may be a little confusing, but make
  "if _is_fs_directly_mapped; then" much cleaner.
- Comment change.
---
 common/rc             | 15 ++++++++
 tests/generic/260     | 79 +++++++++++++++++++++++++++----------------
 tests/generic/260.out |  9 +----
 3 files changed, 66 insertions(+), 37 deletions(-)

diff --git a/common/rc b/common/rc
index 17b89d5d..117dcec2 100644
--- a/common/rc
+++ b/common/rc
@@ -4005,6 +4005,21 @@ _require_fibmap()
 	rm -f $file
 }
 
+# Check if the logical address (returned by fiemap) can be larger than the
+# block device.
+# Currently only btrfs has such behavior even for single device usage.
+# Return 0 if it's directly mapped, return 1 if not.
+# This return value looks confusing but allows us to use
+# "if _is_fs_direct_mapped; then" directly
+_is_fs_direct_mapped()
+{
+	if [ "$FSTYP" == "btrfs" ]; then
+		return 1
+	else
+		return 0
+	fi
+}
+
 _try_wipe_scratch_devs()
 {
 	test -x "$WIPEFS_PROG" || return 0
diff --git a/tests/generic/260 b/tests/generic/260
index 9e652dee..77ace622 100755
--- a/tests/generic/260
+++ b/tests/generic/260
@@ -27,40 +27,50 @@ _supported_fs generic
 _supported_os Linux
 _require_math
 
+rm -f $seqres.full
+
 _require_scratch
 _scratch_mkfs >/dev/null 2>&1
 _scratch_mount
 
 _require_batched_discard $SCRATCH_MNT
 
+
 fssize=$($DF_PROG -k | grep "$SCRATCH_MNT" | grep "$SCRATCH_DEV"  | awk '{print $3}')
 
 beyond_eofs=$(_math "$fssize*2048")
 max_64bit=$(_math "2^64 - 1")
 
-# All these tests should return EINVAL
-# since the start is beyond the end of
-# the file system
-
-echo "[+] Start beyond the end of fs (should fail)"
-out=$($FSTRIM_PROG -o $beyond_eofs $SCRATCH_MNT 2>&1)
-[ $? -eq 0 ] && status=1
-echo $out | _filter_scratch
-
-echo "[+] Start beyond the end of fs with len set (should fail)"
-out=$($FSTRIM_PROG -o $beyond_eofs -l1M $SCRATCH_MNT 2>&1)
-[ $? -eq 0 ] && status=1
-echo $out | _filter_scratch
-
-echo "[+] Start = 2^64-1 (should fail)"
-out=$($FSTRIM_PROG -o $max_64bit $SCRATCH_MNT 2>&1)
-[ $? -eq 0 ] && status=1
-echo $out | _filter_scratch
+# For filesystem with direct mapping, all these tests should return EINVAL
+# since the start is beyond the end of the file system
+#
+# Skip these tests if the filesystem has its own address space mapping,
+# as it's implementation dependent.
+# E.g btrfs can map its physical address of (devid=1, physical=1M, len=1M)
+# to its logical address (logical=1G, len=1M). Making trim beyond device
+# boundary to success.
+
+echo "[+] Optional trim range test (fs dependent)"
+if _is_fs_direct_mapped; then
+	echo "[+] Start beyond the end of fs (should fail)" >> $seqres.full
+	$FSTRIM_PROG -o $beyond_eofs $SCRATCH_MNT >> $seqres.full 2>&1
+	[ $? -eq 0 ] && status=1
+
+	echo "[+] Start beyond the end of fs with len set (should fail)" >> $seqres.full
+	$FSTRIM_PROG -o $beyond_eofs -l1M $SCRATCH_MNT >> $seqres.full 2>&1
+	[ $? -eq 0 ] && status=1
+
+	# indirectly mapped fs may use this special value to trim their
+	# unmapped space, so don't do this for indirectly mapped fs.
+	echo "[+] Start = 2^64-1 (should fail)" >> $seqres.full
+	$FSTRIM_PROG -o $max_64bit $SCRATCH_MNT 2>&1 >> $seqres.full 2>&1
+	[ $? -eq 0 ] && status=1
+fi
 
-echo "[+] Start = 2^64-1 and len is set (should fail)"
-out=$($FSTRIM_PROG -o $max_64bit -l1M $SCRATCH_MNT 2>&1)
+# This should fail due to overflow no matter how the fs is implemented
+echo "[+] Start = 2^64-1 and len is set (should fail)" >> $seqres.full
+$FSTRIM_PROG -o $max_64bit -l1M $SCRATCH_MNT >> $seqres.full 2>&1
 [ $? -eq 0 ] && status=1
-echo $out | _filter_scratch
 
 _scratch_unmount
 _scratch_mkfs >/dev/null 2>&1
@@ -86,10 +96,12 @@ _scratch_unmount
 _scratch_mkfs >/dev/null 2>&1
 _scratch_mount
 
+echo "[+] Trim an empty fs" >> $seqres.full
 # This is a bit fuzzy, but since the file system is fresh
 # there should be at least (fssize/2) free space to trim.
 # This is supposed to catch wrong FITRIM argument handling
 bytes=$($FSTRIM_PROG -v -o10M $SCRATCH_MNT | _filter_fstrim)
+echo "$bytes trimed" >> $seqres.full
 
 if [ $bytes -gt $(_math "$fssize*1024") ]; then
 	status=1
@@ -97,11 +109,9 @@ if [ $bytes -gt $(_math "$fssize*1024") ]; then
 	     "however the file system is $(_math "$fssize*1024") bytes long."
 fi
 
-# Btrfs is special and this test does not apply to it
-# It is because btrfs does not have not-yet-used parts of the device
-# mapped and since we got here right after the mkfs, there is not
-# enough free extents in the root tree.
-if [ $bytes -le $(_math "$fssize*512") ] && [ $FSTYP != "btrfs" ]; then
+# Indirect mapped fs can have their own decision on whether to trim
+# unmapped blocks.
+if [ $bytes -le $(_math "$fssize*512") ] && _is_fs_direct_mapped; then
 	status=1
 	echo "After the full fs discard $bytes bytes were discarded"\
 	     "however the file system is $(_math "$fssize*1024") bytes long."
@@ -141,14 +151,23 @@ esac
 _scratch_unmount
 _scratch_mkfs >/dev/null 2>&1
 _scratch_mount
+
+echo "[+] Try to trim beyond the end of the fs" >> $seqres.full
 # It should fail since $start is beyond the end of file system
-$FSTRIM_PROG -o$start -l10M $SCRATCH_MNT &> /dev/null
-if [ $? -eq 0 ]; then
+$FSTRIM_PROG -o$start -l10M $SCRATCH_MNT >> $seqres.full 2>&1
+ret=$?
+if [ $ret -eq 0 ] && _is_fs_direct_mapped; then
 	status=1
 	echo "It seems that fs logic handling start"\
 	     "argument overflows"
 fi
 
+# For indirectly mapped fs, it shouldn't fail.
+if [ $ret -ne 0 ] && ! _is_fs_direct_mapped; then
+	status=1
+	echo "Unexpected error happened during trim"
+fi
+
 _scratch_unmount
 _scratch_mkfs >/dev/null 2>&1
 _scratch_mount
@@ -160,8 +179,10 @@ _scratch_mount
 # It is because btrfs does not have not-yet-used parts of the device
 # mapped and since we got here right after the mkfs, there is not
 # enough free extents in the root tree.
+echo "[+] Try to trim the fs with large enough len" >> $seqres.full
 bytes=$($FSTRIM_PROG -v -l$len $SCRATCH_MNT | _filter_fstrim)
-if [ $bytes -le $(_math "$fssize*512") ] && [ $FSTYP != "btrfs" ]; then
+echo "$bytes trimed" >> $seqres.full
+if [ $bytes -le $(_math "$fssize*512") ] && _is_fs_direct_mapped; then
 	status=1
 	echo "It seems that fs logic handling len argument overflows"
 fi
diff --git a/tests/generic/260.out b/tests/generic/260.out
index a16c4f74..f4ee2f72 100644
--- a/tests/generic/260.out
+++ b/tests/generic/260.out
@@ -1,12 +1,5 @@
 QA output created by 260
-[+] Start beyond the end of fs (should fail)
-fstrim: SCRATCH_MNT: FITRIM ioctl failed: Invalid argument
-[+] Start beyond the end of fs with len set (should fail)
-fstrim: SCRATCH_MNT: FITRIM ioctl failed: Invalid argument
-[+] Start = 2^64-1 (should fail)
-fstrim: SCRATCH_MNT: FITRIM ioctl failed: Invalid argument
-[+] Start = 2^64-1 and len is set (should fail)
-fstrim: SCRATCH_MNT: FITRIM ioctl failed: Invalid argument
+[+] Optional trim range test (fs dependent)
 [+] Default length (should succeed)
 [+] Default length with start set (should succeed)
 [+] Length beyond the end of fs (should succeed)
-- 
2.21.0

