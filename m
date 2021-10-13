Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4BCE42B1DA
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Oct 2021 03:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234325AbhJMBOq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Oct 2021 21:14:46 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:41690 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233371AbhJMBOq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Oct 2021 21:14:46 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2A5892223A
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Oct 2021 01:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634087563; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=emx4/oxqSidqtRjRpc6KbnI7wtprkOz3MRozUjle8cE=;
        b=Lpcu8zusJFRwZpNLDxtKcPJS5MLm/tLhu0gVEFxYZmt3gp0joKVRTAh/O8Evx3qBoQURyy
        xUtl6Y6RsuSjL5rfHw0o8EqQLS+vA3oNwkOyNWj/UMEuUICpg8ROA2PqDtCBDXtSNOA8cr
        YLO1FzrTJCyjBHVhaAOoFIIvcNO2LG4=
Received: from adam-pc.lan (unknown [10.163.34.62])
        by relay2.suse.de (Postfix) with ESMTP id DD836A3B83
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Oct 2021 01:12:41 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs-progs: test-misc: search the backup slot to use at runtime
Date:   Wed, 13 Oct 2021 09:12:33 +0800
Message-Id: <20211013011233.9254-1-wqu@suse.com>
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
Changelog:
v2:
- Use run_check() instead of manually redirect output to "$RESULT"
- Quote "$main_root_ptr"
---
 .../038-backup-root-corruption/test.sh        | 47 ++++++++++++-------
 1 file changed, 29 insertions(+), 18 deletions(-)

diff --git a/tests/misc-tests/038-backup-root-corruption/test.sh b/tests/misc-tests/038-backup-root-corruption/test.sh
index b6c3671f2c3a..bf41f1e0952b 100755
--- a/tests/misc-tests/038-backup-root-corruption/test.sh
+++ b/tests/misc-tests/038-backup-root-corruption/test.sh
@@ -17,25 +17,35 @@ run_check $SUDO_HELPER touch "$TEST_MNT/file"
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
 
-run_check "$INTERNAL_BIN/btrfs-corrupt-block" -m $main_root_ptr -f generation "$TEST_DEV"
+slot_num=$(echo $found | cut -f1 -d:)
+# To follow the dump-super output, where backup slot starts at 0.
+slot_num=$(($slot_num - 1))
+
+# Save the backup slot info into the log
+_log "Backup slot $slot_num will be utilized"
+dump_super | run_check grep -A9 "backup $slot_num:"
+
+run_check "$INTERNAL_BIN/btrfs-corrupt-block" -m "$main_root_ptr" -f generation "$TEST_DEV"
 
 # Should fail because the root is corrupted
 run_mustfail "Unexpected successful mount" \
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

