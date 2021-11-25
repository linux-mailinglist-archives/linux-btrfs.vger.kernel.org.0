Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB8D45D79B
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Nov 2021 10:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354330AbhKYJxX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Nov 2021 04:53:23 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:44986 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348499AbhKYJvX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Nov 2021 04:51:23 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 018BB21954;
        Thu, 25 Nov 2021 09:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637833691; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=8FD041QCw1V4laqSSeqkl7fLQ0waYbGBjG+MXZKCI2Q=;
        b=oW5D0Zhq7hpNeyS3eoLQ0dxSVQnmDjiPOU58E/9sdjKRjqMoECB9yI+W77bGmNtvAyASW7
        z2XpqZv74YrjfuGE4xPILc6pyM7bh0oTK5twVRuP7fc5wZNnzACt94R4OhA2XOJ5ES+dkv
        ffTRKXWGMJxK1i5U34118vyU7yTT5Fs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B871713F80;
        Thu, 25 Nov 2021 09:48:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 96mAKtpbn2HfLQAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 25 Nov 2021 09:48:10 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     fstests@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v4] btrfs: Test proper interaction between skip_balance and paused balance
Date:   Thu, 25 Nov 2021 11:48:09 +0200
Message-Id: <20211125094809.813275-1-nborisov@suse.com>
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

V4:
 * No longer use mount uuid
 * Some typos fixes

 tests/btrfs/049     | 90 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/049.out |  1 +
 2 files changed, 91 insertions(+)
 create mode 100755 tests/btrfs/049

diff --git a/tests/btrfs/049 b/tests/btrfs/049
new file mode 100755
index 000000000000..765b1de36699
--- /dev/null
+++ b/tests/btrfs/049
@@ -0,0 +1,90 @@
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

