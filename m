Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6A68D7A11
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2019 17:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbfJOPnA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Oct 2019 11:43:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:44504 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731230AbfJOPnA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Oct 2019 11:43:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9EF7BB551;
        Tue, 15 Oct 2019 15:42:52 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 2/2] btrfs-progs: tests: Test backup root retention logic
Date:   Tue, 15 Oct 2019 18:42:49 +0300
Message-Id: <20191015154249.21615-3-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191015154249.21615-1-nborisov@suse.com>
References: <20191015154249.21615-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This tests ensures that the kernel correctly persists backup roots in
case the filesystem has been mounted from a backup root.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 .../misc-tests/038-backup-root-corruption/test.sh  | 50 ++++++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100755 tests/misc-tests/038-backup-root-corruption/test.sh

diff --git a/tests/misc-tests/038-backup-root-corruption/test.sh b/tests/misc-tests/038-backup-root-corruption/test.sh
new file mode 100755
index 000000000000..2fb117b3a928
--- /dev/null
+++ b/tests/misc-tests/038-backup-root-corruption/test.sh
@@ -0,0 +1,50 @@
+#!/bin/bash
+# Test that a corrupted filesystem will correctly handle writing of 
+# backup root
+
+source "$TEST_TOP/common"
+
+check_prereq mkfs.btrfs
+check_prereq btrfs
+check_prereq btrfs-corrupt-block
+
+setup_loopdevs 1
+prepare_loopdevs
+dev=${loopdevs[1]}
+
+run_check $SUDO_HELPER "$TOP/mkfs.btrfs" -f "$dev"
+
+# Create a file and unmount to commit some backup roots
+run_check $SUDO_HELPER mount "$dev" "$TEST_MNT"
+run_check touch "$TEST_MNT/file" && sync
+run_check $SUDO_HELPER umount "$TEST_MNT"
+
+# Ensure currently active backup slot is the expected one (slot 3)
+backup2_root_ptr=$($SUDO_HELPER "$TOP/btrfs" inspect-internal dump-super -f "$dev" \
+	| grep -A1 "backup 2" | grep backup_tree_root | awk '{print $2}')
+
+main_root_ptr=$($SUDO_HELPER "$TOP/btrfs" inspect-internal dump-super -f "$dev" \
+	| grep root | head -n1 | awk '{print $2}')
+
+[[ "$backup2_root_ptr" -eq "$main_root_ptr" ]] || _fail "Backup slot 2 is not in use"
+
+run_check "$TOP/btrfs-corrupt-block" -m $main_root_ptr -f generation "$dev"
+
+## should fail because the root is corrupted
+run_mustfail "Unexpected successful mount" $SUDO_HELPER mount "$dev" "$TEST_MNT"
+
+# Cycle mount with the backup to force rewrite of slot 3 
+run_check $SUDO_HELPER mount -ousebackuproot "$dev" "$TEST_MNT"
+run_check $SUDO_HELPER umount "$TEST_MNT"
+
+
+# Since we've used backup 1 as the usable root, then backup 2 should have been 
+# overwritten 
+main_root_ptr=$($SUDO_HELPER "$TOP/btrfs" inspect-internal dump-super -f "$dev" \
+	| grep root | head -n1 | awk '{print $2}')
+backup2_new_root_ptr=$($SUDO_HELPER "$TOP/btrfs" inspect-internal dump-super -f "$dev" \
+	| grep -A1 "backup 2" | grep backup_tree_root | awk '{print $2}')
+
+[[ "$backup2_root_ptr" -ne "$backup2_new_root_ptr" ]] || _fail "Backup 2 not overwritten"
+
+cleanup_loopdevs
-- 
2.7.4

