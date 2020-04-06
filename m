Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 997A219F045
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Apr 2020 08:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgDFGLO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Apr 2020 02:11:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:42774 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725884AbgDFGLO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 6 Apr 2020 02:11:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A7BB8ABF5
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Apr 2020 06:11:11 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/2] btrfs-progs: tests: Don't use run_check_stdout without filtering
Date:   Mon,  6 Apr 2020 14:11:05 +0800
Message-Id: <20200406061106.596190-2-wqu@suse.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200406061106.596190-1-wqu@suse.com>
References: <20200406061106.596190-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since run_check_stdout() can insert INSTRUMENT, which could easily
pollute the stdout, any caller of run_check_stdout() should filter its
output before using it.

There are some callers which just grab the output without filtering it,
most of them are simple inspect-dump commands.

To avoid false alert with INSTRUMENT set, just don't utilize
run_check_stdout() for those call sites.
Since those call sites are pretty simple, shouldn't cause too many holes
in the coverage.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/common                                       |  3 +++
 tests/misc-tests/004-shrink-fs/test.sh             |  2 +-
 .../009-subvolume-sync-must-wait/test.sh           |  2 +-
 tests/misc-tests/013-subvolume-sync-crash/test.sh  |  2 +-
 .../misc-tests/024-inspect-internal-rootid/test.sh | 14 +++++++-------
 .../031-qgroup-parent-child-relation/test.sh       |  4 ++--
 6 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/tests/common b/tests/common
index 71661e950db0..a040a1b803c4 100644
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
diff --git a/tests/misc-tests/004-shrink-fs/test.sh b/tests/misc-tests/004-shrink-fs/test.sh
index 741500634edb..8ae6f8a50cb2 100755
--- a/tests/misc-tests/004-shrink-fs/test.sh
+++ b/tests/misc-tests/004-shrink-fs/test.sh
@@ -14,7 +14,7 @@ setup_root_helper
 # Optionally take id of the device to shrink
 shrink_test()
 {
-	min_size=$(run_check_stdout $SUDO_HELPER "$TOP/btrfs" inspect-internal min-dev-size ${1:+--id "$1"}  "$TEST_MNT")
+	min_size=$($SUDO_HELPER "$TOP/btrfs" inspect-internal min-dev-size ${1:+--id "$1"}  "$TEST_MNT")
 	min_size=$(echo "$min_size" | cut -d ' ' -f 1)
 	_log "min size = ${min_size}"
 	if [ -z "$min_size" ]; then
diff --git a/tests/misc-tests/009-subvolume-sync-must-wait/test.sh b/tests/misc-tests/009-subvolume-sync-must-wait/test.sh
index 91dcebbbebf9..5c8eb03d91a2 100755
--- a/tests/misc-tests/009-subvolume-sync-must-wait/test.sh
+++ b/tests/misc-tests/009-subvolume-sync-must-wait/test.sh
@@ -31,7 +31,7 @@ done
 run_check $SUDO_HELPER "$TOP/btrfs" subvolume list .
 run_check $SUDO_HELPER "$TOP/btrfs" subvolume list -d .
 
-idtodel=`run_check_stdout $SUDO_HELPER "$TOP/btrfs" inspect-internal rootid snap3`
+idtodel=`$SUDO_HELPER "$TOP/btrfs" inspect-internal rootid snap3`
 
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
index b1c804d9aedd..be457773a899 100755
--- a/tests/misc-tests/024-inspect-internal-rootid/test.sh
+++ b/tests/misc-tests/024-inspect-internal-rootid/test.sh
@@ -21,19 +21,19 @@ run_check touch file1
 run_check touch dir/file2
 run_check touch sub/file3
 
-id1=$(run_check_stdout "$TOP/btrfs" inspect-internal rootid .) \
+id1=$("$TOP/btrfs" inspect-internal rootid .) \
 	|| { echo $id1; exit 1; }
-id2=$(run_check_stdout "$TOP/btrfs" inspect-internal rootid sub) \
+id2=$("$TOP/btrfs" inspect-internal rootid sub) \
 	|| { echo $id2; exit 1; }
-id3=$(run_check_stdout "$TOP/btrfs" inspect-internal rootid sub/subsub) \
+id3=$("$TOP/btrfs" inspect-internal rootid sub/subsub) \
 	|| { echo $id3; exit 1; }
-id4=$(run_check_stdout "$TOP/btrfs" inspect-internal rootid dir) \
+id4=$("$TOP/btrfs" inspect-internal rootid dir) \
 	|| { echo $id4; exit 1; }
-id5=$(run_check_stdout "$TOP/btrfs" inspect-internal rootid file1) \
+id5=$("$TOP/btrfs" inspect-internal rootid file1) \
 	|| { echo $id5; exit 1; }
-id6=$(run_check_stdout "$TOP/btrfs" inspect-internal rootid dir/file2) \
+id6=$("$TOP/btrfs" inspect-internal rootid dir/file2) \
 	|| { echo $id6; exit 1; }
-id7=$(run_check_stdout "$TOP/btrfs" inspect-internal rootid sub/file3) \
+id7=$("$TOP/btrfs" inspect-internal rootid sub/file3) \
 	|| { echo $id7; exit 1; }
 
 if ! ([ "$id1" -ne "$id2" ] && [ "$id1" -ne "$id3" ] && [ "$id2" -ne "$id3" ]); then
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

