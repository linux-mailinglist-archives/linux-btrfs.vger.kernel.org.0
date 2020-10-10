Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9323328A368
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Oct 2020 01:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390433AbgJJW5M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 10 Oct 2020 18:57:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:57038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732260AbgJJTyP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 10 Oct 2020 15:54:15 -0400
Received: from debian8.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FF722224A;
        Sat, 10 Oct 2020 12:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602334658;
        bh=MaLISDCB2RSLpt/pf91quIbg1sZCW3stizpbbmihe2g=;
        h=From:To:Cc:Subject:Date:From;
        b=1q8otWNEdDAZWT/7SfQE8Zrg+m4RHbDDigwyUuZeVMhweIi3JR8RuOT48d50i7JN/
         CFO02sFE44QXwmPBBl+GXiFq13Ju6AH+vxzK5uavz1juucHXW2YlNYTM2xCVR+ue65
         sqFtlcXWrEYcBr9SdHNMHKErB+2BZmrG50VKI6NM=
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] fstests: add a filter for the new getcap output
Date:   Sat, 10 Oct 2020 13:57:31 +0100
Message-Id: <f2980ed83a5268a96b3ff9da15c58477ff24d7a4.1602334589.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Starting with version 2.41 of libcap, the output of the getcap program
changed and therefore some existing tests fail when the installed version
of libcap is >= 2.41 (the latest version available at the moment is 2.44).

The change was made by the following commit of libcap:

  commit 177cd418031b1acfcf73fe3b1af9f3279828681c
  Author: Andrew G. Morgan <morgan@kernel.org>
  Date:   Tue Jul 21 22:58:05 2020 -0700

      A more compact form for the text representation of capabilities.

      While this does not change anything about the supported range of
      equivalent text specifications for capabilities, as accepted by
      cap_from_text(), this does alter the preferred output format of
      cap_to_text() to be two characters shorter in most cases. That is,
      what used to be summarized as:

         "= cap_foo+..."

      is now converted to the equivalent text:

         "cap_foo=..."

      which is also more intuitive.

So add a filter to change the old format to the new one and adapt existing
tests to use it and expect the new format in the golden output.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 common/filter         | 28 ++++++++++++++++++++++++++++
 tests/btrfs/214       | 14 +++++++-------
 tests/generic/093     |  2 +-
 tests/generic/093.out |  2 +-
 tests/overlay/064     |  4 ++--
 tests/overlay/064.out |  4 ++--
 tests/xfs/296         |  2 +-
 tests/xfs/296.out     |  4 ++--
 8 files changed, 44 insertions(+), 16 deletions(-)

diff --git a/common/filter b/common/filter
index 2477f386..64844c98 100644
--- a/common/filter
+++ b/common/filter
@@ -603,5 +603,33 @@ _filter_assert_dmesg()
 	    -e "s#$warn2#Intentional warnings in assfail#"
 }
 
+# With version 2.41 of libcap, the output format of getcap changed.
+# More specifically such change was added by the following commit:
+#
+# commit 177cd418031b1acfcf73fe3b1af9f3279828681c
+# Author: Andrew G. Morgan <morgan@kernel.org>
+# Date:   Tue Jul 21 22:58:05 2020 -0700
+#
+#     A more compact form for the text representation of capabilities.
+#
+#     While this does not change anything about the supported range of
+#     equivalent text specifications for capabilities, as accepted by
+#     cap_from_text(), this does alter the preferred output format of
+#     cap_to_text() to be two characters shorter in most cases. That is,
+#     what used to be summarized as:
+#
+#        "= cap_foo+..."
+#
+#     is now converted to the equivalent text:
+#
+#        "cap_foo=..."
+#
+#     which is also more intuitive.
+#
+_filter_getcap()
+{
+        sed -e "s/ = / /" -e "s/\+/=/"
+}
+
 # make sure this script returns success
 /bin/true
diff --git a/tests/btrfs/214 b/tests/btrfs/214
index 35c4656c..6d08b991 100755
--- a/tests/btrfs/214
+++ b/tests/btrfs/214
@@ -43,7 +43,7 @@ check_capabilities()
 	local ret
 	file="$1"
 	cap="$2"
-	ret=$($GETCAP_PROG "$file")
+	ret=$($GETCAP_PROG "$file" | _filter_getcap)
 	if [ -z "$ret" ]; then
 		echo "$ret"
 		echo "missing capability in file $file"
@@ -84,7 +84,7 @@ full_nocap_inc_withcap_send()
 	$BTRFS_UTIL_PROG subvolume snapshot -r "$FS1" "$FS1/snap_inc" >/dev/null
 	$BTRFS_UTIL_PROG send -p "$FS1/snap_init" "$FS1/snap_inc" -q | \
 					$BTRFS_UTIL_PROG receive "$FS2" -q
-	check_capabilities "$FS2/snap_inc/foo.bar" "cap_sys_ptrace,cap_sys_nice+ep"
+	check_capabilities "$FS2/snap_inc/foo.bar" "cap_sys_ptrace,cap_sys_nice=ep"
 
 	_scratch_unmount
 }
@@ -107,25 +107,25 @@ roundtrip_send()
 	$SETCAP_PROG "cap_sys_ptrace+ep cap_sys_nice+ep" "$FS1/foo.bar"
 	$BTRFS_UTIL_PROG subvolume snapshot -r "$FS1" "$FS1/snap_init" >/dev/null
 	$BTRFS_UTIL_PROG send "$FS1/snap_init" -q | $BTRFS_UTIL_PROG receive "$FS2" -q
-	check_capabilities "$FS2/snap_init/foo.bar" "cap_sys_ptrace,cap_sys_nice+ep"
+	check_capabilities "$FS2/snap_init/foo.bar" "cap_sys_ptrace,cap_sys_nice=ep"
 
 	# Test incremental send with different owner/group but same capabilities
 	chgrp 100 "$FS1/foo.bar"
 	$SETCAP_PROG "cap_sys_ptrace+ep cap_sys_nice+ep" "$FS1/foo.bar"
 	$BTRFS_UTIL_PROG subvolume snapshot -r "$FS1" "$FS1/snap_inc" >/dev/null
-	check_capabilities "$FS1/snap_inc/foo.bar" "cap_sys_ptrace,cap_sys_nice+ep"
+	check_capabilities "$FS1/snap_inc/foo.bar" "cap_sys_ptrace,cap_sys_nice=ep"
 	$BTRFS_UTIL_PROG send -p "$FS1/snap_init" "$FS1/snap_inc" -q | \
 				$BTRFS_UTIL_PROG receive "$FS2" -q
-	check_capabilities "$FS2/snap_inc/foo.bar" "cap_sys_ptrace,cap_sys_nice+ep"
+	check_capabilities "$FS2/snap_inc/foo.bar" "cap_sys_ptrace,cap_sys_nice=ep"
 
 	# Test capabilities after incremental send with different group and capabilities
 	chgrp 0 "$FS1/foo.bar"
 	$SETCAP_PROG "cap_sys_time+ep cap_syslog+ep" "$FS1/foo.bar"
 	$BTRFS_UTIL_PROG subvolume snapshot -r "$FS1" "$FS1/snap_inc2" >/dev/null
-	check_capabilities "$FS1/snap_inc2/foo.bar" "cap_sys_time,cap_syslog+ep"
+	check_capabilities "$FS1/snap_inc2/foo.bar" "cap_sys_time,cap_syslog=ep"
 	$BTRFS_UTIL_PROG send -p "$FS1/snap_inc" "$FS1/snap_inc2" -q | \
 				$BTRFS_UTIL_PROG receive "$FS2"  -q
-	check_capabilities "$FS2/snap_inc2/foo.bar" "cap_sys_time,cap_syslog+ep"
+	check_capabilities "$FS2/snap_inc2/foo.bar" "cap_sys_time,cap_syslog=ep"
 
 	_scratch_unmount
 }
diff --git a/tests/generic/093 b/tests/generic/093
index 0f835e7e..ed5f6f50 100755
--- a/tests/generic/093
+++ b/tests/generic/093
@@ -51,7 +51,7 @@ touch $file
 
 echo "**** Verifying that appending to file clears capabilities ****"
 $SETCAP_PROG cap_chown+ep $file
-$GETCAP_PROG $file | filefilter
+$GETCAP_PROG $file | filefilter | _filter_getcap
 echo data1 >> $file
 cat $file
 $GETCAP_PROG $file | filefilter
diff --git a/tests/generic/093.out b/tests/generic/093.out
index cb29153e..fe6dfe5c 100644
--- a/tests/generic/093.out
+++ b/tests/generic/093.out
@@ -1,7 +1,7 @@
 QA output created by 093
 
 **** Verifying that appending to file clears capabilities ****
-file = cap_chown+ep
+file cap_chown=ep
 data1
 
 **** Verifying that appending to file doesn't clear other xattrs ****
diff --git a/tests/overlay/064 b/tests/overlay/064
index f5d5df1b..7ec3e420 100755
--- a/tests/overlay/064
+++ b/tests/overlay/064
@@ -55,7 +55,7 @@ _scratch_mount "-o metacopy=on"
 $XFS_IO_PROG -c "stat" ${SCRATCH_MNT}/file1 >>$seqres.full
 
 # Make sure cap_setuid is still there
-$GETCAP_PROG ${SCRATCH_MNT}/file1 | _filter_scratch
+$GETCAP_PROG ${SCRATCH_MNT}/file1 | _filter_scratch | _filter_getcap
 
 # Trigger metadata only copy-up
 chmod 000 ${SCRATCH_MNT}/file2
@@ -64,7 +64,7 @@ chmod 000 ${SCRATCH_MNT}/file2
 $XFS_IO_PROG -c "stat" ${SCRATCH_MNT}/file2 >>$seqres.full
 
 # Make sure cap_setuid is still there
-$GETCAP_PROG ${SCRATCH_MNT}/file2 | _filter_scratch
+$GETCAP_PROG ${SCRATCH_MNT}/file2 | _filter_scratch | _filter_getcap
 
 # success, all done
 status=0
diff --git a/tests/overlay/064.out b/tests/overlay/064.out
index cdd3064d..07f89fbd 100644
--- a/tests/overlay/064.out
+++ b/tests/overlay/064.out
@@ -1,3 +1,3 @@
 QA output created by 064
-SCRATCH_MNT/file1 = cap_setuid+ep
-SCRATCH_MNT/file2 = cap_setuid+ep
+SCRATCH_MNT/file1 cap_setuid=ep
+SCRATCH_MNT/file2 cap_setuid=ep
diff --git a/tests/xfs/296 b/tests/xfs/296
index 915ffa0c..f67b8386 100755
--- a/tests/xfs/296
+++ b/tests/xfs/296
@@ -49,7 +49,7 @@ $SETCAP_PROG cap_setgid,cap_setuid+ep $dump_dir/testfile
 echo "Checking for xattr on source file"
 getfattr --absolute-names -m user.name $dump_dir/testfile | _dir_filter
 echo "Checking for capability on source file"
-$GETCAP_PROG $dump_dir/testfile | _dir_filter
+$GETCAP_PROG $dump_dir/testfile | _dir_filter | _filter_getcap
 getfattr --absolute-names -m security.capability $dump_dir/testfile | _dir_filter
 
 _do_dump_file -f $tmp.df.0
diff --git a/tests/xfs/296.out b/tests/xfs/296.out
index c279465c..f5cc624e 100644
--- a/tests/xfs/296.out
+++ b/tests/xfs/296.out
@@ -4,7 +4,7 @@ Checking for xattr on source file
 user.name
 
 Checking for capability on source file
-DUMP_DIR/testfile = cap_setgid,cap_setuid+ep
+DUMP_DIR/testfile cap_setgid,cap_setuid=ep
 # file: DUMP_DIR/testfile
 security.capability
 
@@ -50,7 +50,7 @@ Checking for xattr on restored file
 user.name
 
 Checking for capability on restored file
-RESTORE_DIR/DUMP_SUBDIR/testfile = cap_setgid,cap_setuid+ep
+RESTORE_DIR/DUMP_SUBDIR/testfile cap_setgid,cap_setuid=ep
 # file: RESTORE_DIR/DUMP_SUBDIR/testfile
 security.capability
 
-- 
2.28.0

