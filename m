Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDFD343CB55
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Oct 2021 15:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242322AbhJ0OAZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Oct 2021 10:00:25 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:35774 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242311AbhJ0OAX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Oct 2021 10:00:23 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 72F7621964;
        Wed, 27 Oct 2021 13:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1635343077; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc;
        bh=Negq1y60OXhWSJHHp4IsOvUqswvpt5r2o2hYmIP6mAQ=;
        b=fusdgvtQEtSA6rKPGmaahA1AgT4ilxLQG79exlDN0miFXpaWpWhuRqpbXsBlOkZXMBHXNW
        jUq9TFvNuxpJZXm1wrpiLQQinPm+sQHzGjUhTTeuAfNh8C6DIKzyPj/RMkevFi6+oon++q
        UrakWHBY8CYzuUchhXE/bOV8iY/eX5U=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3528313DBD;
        Wed, 27 Oct 2021 13:57:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CiZFCuVaeWG9OQAAMHmgww
        (envelope-from <nborisov@suse.com>); Wed, 27 Oct 2021 13:57:57 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs: Test proper interaction between skip_balance and paused balance
Date:   Wed, 27 Oct 2021 16:57:54 +0300
Message-Id: <20211027135754.20101-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Ensure a device can be added to a filesystem that has a paused balance
operation and has been mounted with the 'skip_balance' mount option

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 tests/btrfs/049     | 47 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/049.out |  1 +
 2 files changed, 48 insertions(+)
 create mode 100755 tests/btrfs/049

diff --git a/tests/btrfs/049 b/tests/btrfs/049
new file mode 100755
index 000000000000..7f566ee112f1
--- /dev/null
+++ b/tests/btrfs/049
@@ -0,0 +1,47 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2021 SUSE Linux Products GmbH.  All Rights Reserved.
+#
+# FS QA Test 049
+#
+# Ensure that it's possible to add a device when we have a paused balance 
+# and the filesystem is mounted with skip_balance. 
+#
+. ./common/preamble
+_begin_fstest quick balance auto
+
+# real QA test starts here
+
+_supported_fs btrfs
+_require_scratch_dev_pool
+
+_scratch_mkfs >/dev/null
+_scratch_mount
+
+uuid=$(findmnt -n -o UUID $SCRATCH_MNT)
+
+if [[ ! -e /sys/fs/btrfs/$uuid/exclusive_operation ]]; then
+	_notrun "Requires btrfs exclusive operation support"
+fi
+
+dev1="`echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $2}'`"
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
+_run_btrfs_balance_start --full-balance --bg "$SCRATCH_MNT"
+$BTRFS_UTIL_PROG balance pause "$SCRATCH_MNT"
+
+_scratch_cycle_mount "skip_balance"
+
+$BTRFS_UTIL_PROG device add -K -f $dev1 "$SCRATCH_MNT"
+
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

