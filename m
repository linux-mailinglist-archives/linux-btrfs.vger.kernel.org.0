Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E14F04481C5
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Nov 2021 15:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240472AbhKHObt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Nov 2021 09:31:49 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:52430 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239496AbhKHObs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Nov 2021 09:31:48 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 654DC218E0;
        Mon,  8 Nov 2021 14:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1636381743; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=t/XNogeHhg7CLaeOwLlJhLXTQWzeodDuZScgLI/OWjs=;
        b=G5VuPytTismwYtYgbRypuV8tUXN39a5b0AkATN03LX1pBOz++YbfdctHlwEqUo5K2/uCRa
        4PUuOrb1bApypz9AIlkwjOCyCebjCfbfu0ZJ/kOpHBIr3amo4JV5AVOmevcCIaXZXYSxKb
        HfSJ+wCdQmSSxlcvoxm/LtDV+zvzgmk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 21F1213BA0;
        Mon,  8 Nov 2021 14:29:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GwW5BS80iWHmJgAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 08 Nov 2021 14:29:03 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v3] btrfs: Test proper interaction between skip_balance and paused balance
Date:   Mon,  8 Nov 2021 16:29:01 +0200
Message-Id: <20211108142901.1003352-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Ensure a device can be added to a filesystem that has a paused balance
operation and has been mounted with the 'skip_balance' mount option

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---

V3:
 * Added swapon to the list of exclusive ops
 * Use _spare_dev_get
 * Test balance resume via progs while balance is paused. I hit an assertion failure
 outside of xfstest while doing this sequence of steps so let's add it to
 ensure that's not regressed.

 tests/btrfs/049     | 92 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/049.out |  1 +
 2 files changed, 93 insertions(+)
 create mode 100755 tests/btrfs/049

diff --git a/tests/btrfs/049 b/tests/btrfs/049
new file mode 100755
index 000000000000..d01ef05e5ead
--- /dev/null
+++ b/tests/btrfs/049
@@ -0,0 +1,92 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2021 SUSE Linux Products GmbH.  All Rights Reserved.
+#
+# FS QA Test 049
+#
+# Ensure that it's possible to add a device when we have a paused balance
+# and the filesystem is mounted with skip_balance. The issue is fixed by a patch
+# titled "btrfs: allow device add if balance is paused"
+#
+. ./common/preamble
+_begin_fstest quick balance auto
+
+# real QA test starts here
+
+_supported_fs btrfs
+_require_scratch_swapfile
+_require_scratch_dev_pool 3
+
+_scratch_dev_pool_get 2
+_spare_dev_get
+
+swapfile="$SCRATCH_MNT/swap"
+_scratch_pool_mkfs >/dev/null
+_scratch_mount
+_format_swapfile "$swapfile" $(($(get_page_size) * 10))
+
+check_exclusive_ops()
+{
+	$BTRFS_UTIL_PROG device remove 2 $SCRATCH_MNT &>/dev/null
+	[ $? -ne 0 ] || _fail "Successfully removed device"
+	$BTRFS_UTIL_PROG filesystem resize -5m $SCRATCH_MNT &> /dev/null
+	[ $? -ne 0 ] || _fail "Successfully resized filesystem"
+	$BTRFS_UTIL_PROG replace start -B 2 $SPARE_DEV $SCRATCH_MNT &> /dev/null
+	[ $? -ne 0 ] || _fail "Successfully replaced device"
+	swapon "$swapfile" &> /dev/null
+	[ $? -ne 0 ] || _fail "Successfully enabled a swap file"
+}
+
+uuid=$(findmnt -n -o UUID $SCRATCH_MNT)
+
+# Create some files on the so that balance doesn't complete instantly
+args=`_scale_fsstress_args -z \
+	-f write=10 -f creat=10 \
+	-n 1000 -p 2 -d $SCRATCH_MNT/stress_dir`
+echo "Run fsstress $args" >>$seqres.full
+$FSSTRESS_PROG $args >/dev/null 2>&1
+
+# Start and pause balance to ensure it will be restored on remount
+echo "Start balance" >>$seqres.full
+_run_btrfs_balance_start --bg "$SCRATCH_MNT"
+$BTRFS_UTIL_PROG balance pause "$SCRATCH_MNT"
+$BTRFS_UTIL_PROG balance status "$SCRATCH_MNT" | grep -q paused
+[ $? -eq 0 ] || _fail "Balance not paused"
+
+# Exclusive ops should be blocked on manual pause of balance
+check_exclusive_ops
+
+# Balance is now placed in paused state during mount
+_scratch_cycle_mount "skip_balance"
+
+# Exclusive ops should be blocked on balance pause due to 'skip_balance'
+check_exclusive_ops
+
+# Device add is the only allowed operation
+$BTRFS_UTIL_PROG device add -K -f $SPARE_DEV "$SCRATCH_MNT"
+
+# Exclusive ops should still be blocked on account that balance is still paused
+check_exclusive_ops
+
+# Should be possible to resume balance after device add
+$BTRFS_UTIL_PROG balance resume "$SCRATCH_MNT" &>/dev/null
+[ $? -eq 0 ] || _fail "Couldn't resume balance after device add"
+
+# Add more files so that new balance won't fish immediately
+$FSSTRESS_PROG $args >/dev/null 2>&1
+
+# Now pause->resume balance. This ensures balance paused is properly set in
+# the kernel and won't trigger an assertion failure.
+echo "Start balance" >>$seqres.full
+_run_btrfs_balance_start --bg "$SCRATCH_MNT"
+$BTRFS_UTIL_PROG balance pause "$SCRATCH_MNT"
+$BTRFS_UTIL_PROG balance status "$SCRATCH_MNT" | grep -q paused
+[ $? -eq 0 ] || _fail "Balance not paused"
+$BTRFS_UTIL_PROG balance resume "$SCRATCH_MNT" &>/dev/null
+[ $? -eq 0 ] || _fail "Balance can't be resumed via IOCTL"
+
+_spare_dev_put
+_scratch_dev_pool_put
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/btrfs/049.out b/tests/btrfs/049.out
index cb0061b33ff0..c69568ad9323 100644
--- a/tests/btrfs/049.out
+++ b/tests/btrfs/049.out
@@ -1 +1,2 @@
 QA output created by 049
+Silence is golden
--
2.17.1

