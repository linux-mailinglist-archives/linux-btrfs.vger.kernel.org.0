Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0DEF1A0813
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Apr 2020 09:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbgDGHS7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Apr 2020 03:18:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:47136 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726591AbgDGHS7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 7 Apr 2020 03:18:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8C1EFAD39
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Apr 2020 07:18:55 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 1/2] btrfs-progs: tests: Filter output for run_check_stdout
Date:   Tue,  7 Apr 2020 15:18:44 +0800
Message-Id: <20200407071845.29428-2-wqu@suse.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200407071845.29428-1-wqu@suse.com>
References: <20200407071845.29428-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since run_check_stdout() can insert INSTRUMENT for all btrfs related
programs, which could easily pollute the stdout, any caller of
run_check_stdout() should do proper filter.

The following callers are affected:
- misc/004
  Filter the output of "btrfs ins min-dev-size"

- misc/009
- misc/013
- misc/024
  They are all calling "btrfs ins rootid", so introduce get_subvolid()
  function to grab the subvolid properly.

- misc/031
  Loose the filter for "btrfs qgroup show". No need for "tail -n 1".

So we still have the same coverage, but now these tests won't cause
false alert if we insert INSTRUMENT for all btrfs commands.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/common                                  | 13 ++++++++++++
 tests/misc-tests/004-shrink-fs/test.sh        | 11 ++++++++--
 .../009-subvolume-sync-must-wait/test.sh      |  2 +-
 .../013-subvolume-sync-crash/test.sh          |  2 +-
 .../024-inspect-internal-rootid/test.sh       | 21 +++++++------------
 .../031-qgroup-parent-child-relation/test.sh  |  4 ++--
 6 files changed, 33 insertions(+), 20 deletions(-)

diff --git a/tests/common b/tests/common
index 71661e950db0..f8fc3cfd8b4f 100644
--- a/tests/common
+++ b/tests/common
@@ -169,6 +169,9 @@ run_check()
 
 # same as run_check but the stderr+stdout output is duplicated on stdout and
 # can be processed further
+#
+# NOTE: If this function is called on btrfs related command, caller should
+#	filter the output, as INSTRUMENT can easily pollute the output.
 run_check_stdout()
 {
 	local spec
@@ -636,6 +639,16 @@ check_min_kernel_version()
 	return 0
 }
 
+# Get subvolume id for specified path
+get_subvolid()
+{
+	# run_check_stdout may have INSTRUMENT pollating the output,
+	# need to filter the output.
+	run_check_stdout "$TOP/btrfs" inspect-internal rootid "$1" | \
+		grep -e "^[[:digit:]]\+$"
+
+}
+
 # compare running kernel version to the given parameter, return success
 # if running is newer than requested (let caller decide if to fail or skip)
 # $1: minimum version of running kernel in major.minor format (eg. 4.19)
diff --git a/tests/misc-tests/004-shrink-fs/test.sh b/tests/misc-tests/004-shrink-fs/test.sh
index 741500634edb..7410f847a43e 100755
--- a/tests/misc-tests/004-shrink-fs/test.sh
+++ b/tests/misc-tests/004-shrink-fs/test.sh
@@ -11,11 +11,18 @@ check_prereq btrfs
 
 setup_root_helper
 
+get_min_dev_size()
+{
+	size=$(run_check_stdout $SUDO_HELPER "$TOP/btrfs" inspect-internal \
+		min-dev-size ${1:+--id "$1"} "$TEST_MNT" | \
+		grep -e "^[[:digit:]]\+.*)$" | cut -d ' ' -f 1)
+	echo "$size"
+}
+
 # Optionally take id of the device to shrink
 shrink_test()
 {
-	min_size=$(run_check_stdout $SUDO_HELPER "$TOP/btrfs" inspect-internal min-dev-size ${1:+--id "$1"}  "$TEST_MNT")
-	min_size=$(echo "$min_size" | cut -d ' ' -f 1)
+	min_size=$(get_min_dev_size $1)
 	_log "min size = ${min_size}"
 	if [ -z "$min_size" ]; then
 		_fail "Failed to parse minimum size"
diff --git a/tests/misc-tests/009-subvolume-sync-must-wait/test.sh b/tests/misc-tests/009-subvolume-sync-must-wait/test.sh
index 91dcebbbebf9..9f4b49a92080 100755
--- a/tests/misc-tests/009-subvolume-sync-must-wait/test.sh
+++ b/tests/misc-tests/009-subvolume-sync-must-wait/test.sh
@@ -31,7 +31,7 @@ done
 run_check $SUDO_HELPER "$TOP/btrfs" subvolume list .
 run_check $SUDO_HELPER "$TOP/btrfs" subvolume list -d .
 
-idtodel=`run_check_stdout $SUDO_HELPER "$TOP/btrfs" inspect-internal rootid snap3`
+idtodel=$(get_subvolid snap3)
 
 # delete, sync after some time
 run_check $SUDO_HELPER "$TOP/btrfs" subvolume delete -c snap3
diff --git a/tests/misc-tests/013-subvolume-sync-crash/test.sh b/tests/misc-tests/013-subvolume-sync-crash/test.sh
index 64ba99598462..8d4e76032db5 100755
--- a/tests/misc-tests/013-subvolume-sync-crash/test.sh
+++ b/tests/misc-tests/013-subvolume-sync-crash/test.sh
@@ -32,7 +32,7 @@ done
 run_check $SUDO_HELPER "$TOP/btrfs" subvolume list .
 run_check $SUDO_HELPER "$TOP/btrfs" subvolume list -d .
 
-idtodel=`run_check_stdout $SUDO_HELPER "$TOP/btrfs" inspect-internal rootid snap3`
+idtodel=`$SUDO_HELPER "$TOP/btrfs" inspect-internal rootid snap3`
 
 # delete, sync after some time
 run_check $SUDO_HELPER "$TOP/btrfs" subvolume delete -c snap*
diff --git a/tests/misc-tests/024-inspect-internal-rootid/test.sh b/tests/misc-tests/024-inspect-internal-rootid/test.sh
index b1c804d9aedd..cb3fbc6db02c 100755
--- a/tests/misc-tests/024-inspect-internal-rootid/test.sh
+++ b/tests/misc-tests/024-inspect-internal-rootid/test.sh
@@ -21,20 +21,13 @@ run_check touch file1
 run_check touch dir/file2
 run_check touch sub/file3
 
-id1=$(run_check_stdout "$TOP/btrfs" inspect-internal rootid .) \
-	|| { echo $id1; exit 1; }
-id2=$(run_check_stdout "$TOP/btrfs" inspect-internal rootid sub) \
-	|| { echo $id2; exit 1; }
-id3=$(run_check_stdout "$TOP/btrfs" inspect-internal rootid sub/subsub) \
-	|| { echo $id3; exit 1; }
-id4=$(run_check_stdout "$TOP/btrfs" inspect-internal rootid dir) \
-	|| { echo $id4; exit 1; }
-id5=$(run_check_stdout "$TOP/btrfs" inspect-internal rootid file1) \
-	|| { echo $id5; exit 1; }
-id6=$(run_check_stdout "$TOP/btrfs" inspect-internal rootid dir/file2) \
-	|| { echo $id6; exit 1; }
-id7=$(run_check_stdout "$TOP/btrfs" inspect-internal rootid sub/file3) \
-	|| { echo $id7; exit 1; }
+id1=$(get_subvolid .) || { echo $id1; exit 1; }
+id2=$(get_subvolid sub) || { echo $id2; exit 1; }
+id3=$(get_subvolid sub/subsub) || { echo $id3; exit 1; }
+id4=$(get_subvolid dir) || { echo $id4; exit 1; }
+id5=$(get_subvolid file1) || { echo $id5; exit 1; }
+id6=$(get_subvolid dir/file2) || { echo $id6; exit 1; }
+id7=$(get_subvolid sub/file3) || { echo $id7; exit 1; }
 
 if ! ([ "$id1" -ne "$id2" ] && [ "$id1" -ne "$id3" ] && [ "$id2" -ne "$id3" ]); then
 	_fail "inspect-internal rootid: each subvolume must have different id"
diff --git a/tests/misc-tests/031-qgroup-parent-child-relation/test.sh b/tests/misc-tests/031-qgroup-parent-child-relation/test.sh
index f85290584742..53bc953e21d6 100755
--- a/tests/misc-tests/031-qgroup-parent-child-relation/test.sh
+++ b/tests/misc-tests/031-qgroup-parent-child-relation/test.sh
@@ -18,10 +18,10 @@ run_check $SUDO_HELPER "$TOP/btrfs" qgroup assign 0/5 1/0 "$TEST_MNT"
 run_check $SUDO_HELPER "$TOP/btrfs" quota rescan -w "$TEST_MNT"
 
 run_check_stdout $SUDO_HELPER "$TOP/btrfs" qgroup show --sort=-qgroupid \
-	-p "$TEST_MNT" | tail -n 1 | grep -q "1/0" \
+	-p "$TEST_MNT" | grep -q "1/0" \
 	|| _fail "parent qgroup check failed, please check the log"
 run_check_stdout $SUDO_HELPER "$TOP/btrfs" qgroup show --sort=qgroupid \
-	-c "$TEST_MNT" | tail -n 1 | grep -q "0/5" \
+	-c "$TEST_MNT" | grep -q "0/5" \
 	|| _fail "child qgroup check failed, please check the log"
 
 run_check_umount_test_dev "$TEST_MNT"
-- 
2.26.0

