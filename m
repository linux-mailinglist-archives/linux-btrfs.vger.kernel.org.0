Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9445F42A008
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Oct 2021 10:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234745AbhJLIjW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Oct 2021 04:39:22 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:49214 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234686AbhJLIjV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Oct 2021 04:39:21 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 92CA32018C
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Oct 2021 08:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634027839; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=71XjCaxjZmN1nvE3voQ0yOOmHGMzRNgc6OT6GH1BVzY=;
        b=gNvv1WTUsWVN7wi1wROzGUKFY/j37VlZ3tT4gBQG/wvXlyGe9Gqbc149n5bhq6vAg6D7Xc
        MV2JNgMWa7ybFkkymTffpqthss09ujHhGYAPZvciXhLCol9uXsBBt2GY3IQYVL68LWzWAn
        ZsoG4GY7jOs7yqnR6EuJUfF0vEHDVBA=
Received: from adam-pc.lan (unknown [10.163.34.62])
        by relay2.suse.de (Postfix) with ESMTP id 8D8BFA3B81
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Oct 2021 08:37:18 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: test-misc: search the backup slot to use at runtime
Date:   Tue, 12 Oct 2021 16:37:12 +0800
Message-Id: <20211012083712.31592-1-wqu@suse.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Test case misc/038 uses hardcoded backup slot number, this means if we
change how many transactions we commit during mkfs, it will immediately
break the tests.

Such hardcoded tests will be a big pain for later btrfs-progs updates.

Update it with runtime backup slot search.

Such search is done by using current filesystem generation as a search
target and grab the slot number.

By this, no matter how many transactions we commit during mkfs, the test
case should be able to handle it.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 .../038-backup-root-corruption/test.sh        | 45 ++++++++++++-------
 1 file changed, 28 insertions(+), 17 deletions(-)

diff --git a/tests/misc-tests/038-backup-root-corruption/test.sh b/tests/misc-tests/038-backup-root-corruption/test.sh
index b6c3671f2c3a..315eac9a2904 100755
--- a/tests/misc-tests/038-backup-root-corruption/test.sh
+++ b/tests/misc-tests/038-backup-root-corruption/test.sh
@@ -17,24 +17,34 @@ run_check $SUDO_HELPER touch "$TEST_MNT/file"
 run_check_umount_test_dev
 
 dump_super() {
-	run_check_stdout $SUDO_HELPER "$TOP/btrfs" inspect-internal dump-super -f "$TEST_DEV"
+	# In this test, we will dump super block multiple times, while the
+	# existing run_check*() helpers will always dump all the output into
+	# the log, flooding the log and hide real important info.
+	# Thus here we call "btrfs" directly.
+	$SUDO_HELPER "$TOP/btrfs" inspect-internal dump-super -f "$TEST_DEV"
 }
 
-# Ensure currently active backup slot is the expected one (slot 3)
-backup2_root_ptr=$(dump_super | grep -A1 "backup 2" | grep backup_tree_root | awk '{print $2}')
-
 main_root_ptr=$(dump_super | awk '/^root\t/{print $2}')
+# Grab current fs generation, and it will be used to determine which backup
+# slot to use
+cur_gen=$(dump_super | grep ^generation | awk '{print $2}')
+backup_gen=$(($cur_gen - 1))
+
+# Grab the slot which matches @backup_gen
+found=$(dump_super | grep backup_tree_root | grep -n "gen: $backup_gen")
 
-if [ "$backup2_root_ptr" -ne "$main_root_ptr" ]; then
-	_log "Backup slot 2 not in use, trying slot 3"
-	# Or use the next slot in case of free-space-tree
-	backup3_root_ptr=$(dump_super | grep -A1 "backup 3" | grep backup_tree_root | awk '{print $2}')
-	if [ "$backup3_root_ptr" -ne "$main_root_ptr" ]; then
-		_fail "Neither backup slot 2 nor slot 3 are in use"
-	fi
-	_log "Backup slot 3 in use"
+if [ -z "$found" ]; then
+	_fail "Unable to find a backup slot with generation $backup_gen"
 fi
 
+slot_num=$(echo $found | cut -f1 -d:)
+# To follow the dump-super output, where backup slot starts at 0.
+slot_num=$(($slot_num - 1))
+
+# Save the backup slot info into the log
+_log "Backup slot $slot_num will be utilized"
+dump_super | grep -A9 "backup $slot_num:" >> "$RESULTS"
+
 run_check "$INTERNAL_BIN/btrfs-corrupt-block" -m $main_root_ptr -f generation "$TEST_DEV"
 
 # Should fail because the root is corrupted
@@ -45,9 +55,10 @@ run_mustfail "Unexpected successful mount" \
 run_check_mount_test_dev -o usebackuproot
 run_check_umount_test_dev
 
-# Since we've used backup 1 as the usable root, then backup 2 should have been
-# overwritten
-main_root_ptr=$(dump_super | grep root | head -n1 | awk '{print $2}')
-backup2_new_root_ptr=$(dump_super | grep -A1 "backup 2" | grep backup_tree_root | awk '{print $2}')
+main_root_ptr=$(dump_super | awk '/^root\t/{print $2}')
+
+# The next slot should be overwritten
+slot_num=$(( ($slot_num + 1) % 4 ))
+backup_new_root_ptr=$(dump_super | grep -A1 "backup $slot_num" | grep backup_tree_root | awk '{print $2}')
 
-[ "$backup2_root_ptr" -ne "$backup2_new_root_ptr" ] || _fail "Backup 2 not overwritten"
+[ "$main_root_ptr" -ne "$backup_new_root_ptr" ] || _fail "Backup 2 not overwritten"
-- 
2.33.0

