Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5661228A75D
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Oct 2020 14:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730042AbgJKMjA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 11 Oct 2020 08:39:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:55138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729954AbgJKMi7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 11 Oct 2020 08:38:59 -0400
Received: from debian8.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 283B4207E8;
        Sun, 11 Oct 2020 12:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602419938;
        bh=yCTXbQ6tzPZwjjwZsz3Y21eD4yXv9/9T/SWpvj87iz4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Oe/66wTOrcColSzovqIir+TogiNBDTs+NO+dk2XjbeVs0rVaPvQ9Iu1R2P5BKBXrU
         Uhxq8M5ltJLxH+00XUr2vE5MDH7Ntr9HlMpmI1pNnKM07J/lBV1FKzkYqlQVNRbQGH
         B5UMy40EGidS7G/HDHISC11ZY6iMApeQsVrqw9LU=
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, guan@eryu.me,
        Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v2] fstests: add a filter for the new getcap output
Date:   Sun, 11 Oct 2020 13:38:52 +0100
Message-Id: <76fff10e7f920de923010b00d0b68bc2edc5448e.1602419494.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <f2980ed83a5268a96b3ff9da15c58477ff24d7a4.1602334589.git.fdmanana@suse.com>
References: <f2980ed83a5268a96b3ff9da15c58477ff24d7a4.1602334589.git.fdmanana@suse.com>
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

So add a filter to change the old format to the new one, an helper that
calls getcap with that filter, make existing tests use the new helper and
update their golden output to match the new output format of getcap.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---

V2: Added _getcap() helper that makes use of the filter, make tests use it.

 common/filter         | 28 ++++++++++++++++++++++++++++
 common/rc             |  6 ++++++
 tests/btrfs/214       | 16 ++++++++--------
 tests/generic/093     |  4 ++--
 tests/generic/093.out |  2 +-
 tests/generic/513     |  4 ++--
 tests/overlay/064     |  4 ++--
 tests/overlay/064.out |  4 ++--
 tests/xfs/296         |  4 ++--
 tests/xfs/296.out     |  4 ++--
 10 files changed, 55 insertions(+), 21 deletions(-)

diff --git a/common/filter b/common/filter
index 2477f386..a8b3882f 100644
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
+        sed -e "s/= //" -e "s/\+/=/g"
+}
+
 # make sure this script returns success
 /bin/true
diff --git a/common/rc b/common/rc
index 23095d4f..27a27ea3 100644
--- a/common/rc
+++ b/common/rc
@@ -4315,6 +4315,12 @@ _require_mknod()
 	rm -f $TEST_DIR/$seq.null
 }
 
+_getcap()
+{
+	$GETCAP_PROG "$@" | _filter_getcap
+	return ${PIPESTATUS[0]}
+}
+
 init_rc
 
 ################################################################################
diff --git a/tests/btrfs/214 b/tests/btrfs/214
index 35c4656c..123c4cbf 100755
--- a/tests/btrfs/214
+++ b/tests/btrfs/214
@@ -43,7 +43,7 @@ check_capabilities()
 	local ret
 	file="$1"
 	cap="$2"
-	ret=$($GETCAP_PROG "$file")
+	ret=$(_getcap "$file")
 	if [ -z "$ret" ]; then
 		echo "$ret"
 		echo "missing capability in file $file"
@@ -74,7 +74,7 @@ full_nocap_inc_withcap_send()
 	$BTRFS_UTIL_PROG subvolume snapshot -r "$FS1" "$FS1/snap_init" >/dev/null
 	$BTRFS_UTIL_PROG send "$FS1/snap_init" -q | $BTRFS_UTIL_PROG receive "$FS2" -q
 	# ensure that we don't have capabilities set
-	ret=$($GETCAP_PROG "$FS2/snap_init/foo.bar")
+	ret=$(_getcap "$FS2/snap_init/foo.bar")
 	if [ -n "$ret" ]; then
 		echo "File contains capabilities when it shouldn't"
 	fi
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
index 0f835e7e..48ffec5c 100755
--- a/tests/generic/093
+++ b/tests/generic/093
@@ -51,10 +51,10 @@ touch $file
 
 echo "**** Verifying that appending to file clears capabilities ****"
 $SETCAP_PROG cap_chown+ep $file
-$GETCAP_PROG $file | filefilter
+_getcap $file | filefilter
 echo data1 >> $file
 cat $file
-$GETCAP_PROG $file | filefilter
+_getcap $file | filefilter
 echo
 
 echo "**** Verifying that appending to file doesn't clear other xattrs ****"
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
diff --git a/tests/generic/513 b/tests/generic/513
index 15b4aded..70687877 100755
--- a/tests/generic/513
+++ b/tests/generic/513
@@ -40,14 +40,14 @@ $XFS_IO_PROG -f -c "pwrite -S 0x20 0 1m" $SCRATCH_MNT/bar >>$seqres.full
 
 $SETCAP_PROG cap_setgid,cap_setuid+ep $SCRATCH_MNT/bar
 
-before_cap="$($GETCAP_PROG -v $SCRATCH_MNT/bar)"
+before_cap="$(_getcap -v $SCRATCH_MNT/bar)"
 before_ctime="$(stat -c '%z' $SCRATCH_MNT/bar)"
 
 sleep 1
 
 $XFS_IO_PROG -c "reflink $SCRATCH_MNT/foo" $SCRATCH_MNT/bar >> $seqres.full 2>&1
 
-after_cap="$($GETCAP_PROG -v $SCRATCH_MNT/bar)"
+after_cap="$(_getcap -v $SCRATCH_MNT/bar)"
 after_ctime="$(stat -c '%z' $SCRATCH_MNT/bar)"
 
 echo "$before_cap $before_ctime" >> $seqres.full
diff --git a/tests/overlay/064 b/tests/overlay/064
index f5d5df1b..8d3d1e4c 100755
--- a/tests/overlay/064
+++ b/tests/overlay/064
@@ -55,7 +55,7 @@ _scratch_mount "-o metacopy=on"
 $XFS_IO_PROG -c "stat" ${SCRATCH_MNT}/file1 >>$seqres.full
 
 # Make sure cap_setuid is still there
-$GETCAP_PROG ${SCRATCH_MNT}/file1 | _filter_scratch
+_getcap ${SCRATCH_MNT}/file1 | _filter_scratch
 
 # Trigger metadata only copy-up
 chmod 000 ${SCRATCH_MNT}/file2
@@ -64,7 +64,7 @@ chmod 000 ${SCRATCH_MNT}/file2
 $XFS_IO_PROG -c "stat" ${SCRATCH_MNT}/file2 >>$seqres.full
 
 # Make sure cap_setuid is still there
-$GETCAP_PROG ${SCRATCH_MNT}/file2 | _filter_scratch
+_getcap ${SCRATCH_MNT}/file2 | _filter_scratch
 
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
index 915ffa0c..77726e54 100755
--- a/tests/xfs/296
+++ b/tests/xfs/296
@@ -49,7 +49,7 @@ $SETCAP_PROG cap_setgid,cap_setuid+ep $dump_dir/testfile
 echo "Checking for xattr on source file"
 getfattr --absolute-names -m user.name $dump_dir/testfile | _dir_filter
 echo "Checking for capability on source file"
-$GETCAP_PROG $dump_dir/testfile | _dir_filter
+_getcap $dump_dir/testfile | _dir_filter
 getfattr --absolute-names -m security.capability $dump_dir/testfile | _dir_filter
 
 _do_dump_file -f $tmp.df.0
@@ -62,7 +62,7 @@ _diff_compare
 echo "Checking for xattr on restored file"
 getfattr --absolute-names -m user.name $restore_dir/$dump_sdir/testfile | _dir_filter
 echo "Checking for capability on restored file"
-$GETCAP_PROG $restore_dir/$dump_sdir/testfile | _dir_filter
+_getcap $restore_dir/$dump_sdir/testfile | _dir_filter
 getfattr --absolute-names -m security.capability $restore_dir/$dump_sdir/testfile | _dir_filter
 
 status=0
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

