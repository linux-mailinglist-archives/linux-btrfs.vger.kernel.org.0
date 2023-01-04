Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6832465CE2F
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Jan 2023 09:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233520AbjADIVp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Jan 2023 03:21:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjADIVo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Jan 2023 03:21:44 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BEE1789C;
        Wed,  4 Jan 2023 00:21:42 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9CCD075EBC;
        Wed,  4 Jan 2023 08:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1672820501; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=hf/LkE/eE8c/67vUaqWw0iGLJLW3GxSjPDpBh6psW14=;
        b=LYuBfbholqFCTfeH29SA7ir7YEvP/Sx4OOE9YGYh9b2Wgl+TBO9otA4j010JPMWQNmj/YK
        jyw9A29WO/z1dZEody6ye/HXQIyM+959Vy6MaHu5LbHZgNPhXkeenpll9jAlo5Ohlk7RpI
        TYZQ1/EUy2vCK3BN8FjspWQhC3md37Y=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 560FF1342C;
        Wed,  4 Jan 2023 08:21:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id A8kWCRQ3tWPaFgAAMHmgww
        (envelope-from <wqu@suse.com>); Wed, 04 Jan 2023 08:21:40 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: [PATCH] btrfs: add a test case to verify scrub speed throttle works
Date:   Wed,  4 Jan 2023 16:21:23 +0800
Message-Id: <20230104082123.56800-1-wqu@suse.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We introduced scrub speed throttle in commit eb3b50536642 ("btrfs: scrub:
per-device bandwidth control"),  but it is not that well documented
(e.g. what's the unit of the sysfs interface), nor tested by any test
case.

This patch will add a test case for this functionality.

The test case itself is pretty straightforward:

- Fill the fs with 2G file as scrub workload
- Set scrub speed limit to 50MiB/s
- Scrub and compare the reported rate against above 50MiB/s throttle

However the test case has an assumption that the underlying disk must be
faster than our 50MiB/s, which should be pretty common in
baremetal/exclusive VMs.
But for cloud environment it's not ensured 100%, thus the test case is
not included in auto group to avoid false alerts.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/282     | 83 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/282.out |  3 ++
 2 files changed, 86 insertions(+)
 create mode 100755 tests/btrfs/282
 create mode 100644 tests/btrfs/282.out

diff --git a/tests/btrfs/282 b/tests/btrfs/282
new file mode 100755
index 00000000..9a6677ec
--- /dev/null
+++ b/tests/btrfs/282
@@ -0,0 +1,83 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2023 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test 282
+#
+# Make sure scrub speed limitation works as expected.
+#
+. ./common/preamble
+_begin_fstest scrub
+
+# Override the default cleanup function.
+# _cleanup()
+# {
+# 	cd /
+# 	rm -r -f $tmp.*
+# }
+
+. ./common/filter
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs btrfs
+_wants_kernel_commit eb3b50536642 \
+	"btrfs: scrub: per-device bandwidth control"
+
+# We want at least 5G for the scratch device.
+_require_scratch_size $(( 5 * 1024 * 1024))
+
+_scratch_mkfs >> $seqres.full 2>&1
+_scratch_mount
+
+uuid=$(findmnt -n -o UUID $SCRATCH_MNT)
+
+devinfo_dir="/sys/fs/btrfs/${uuid}/devinfo/1"
+
+# Check if we have the sysfs interface first.
+if [ ! -f "${devinfo_dir}/scrub_speed_max" ]; then
+	_notrun "No sysfs interface for scrub speed throttle"
+fi
+
+# Create a 2G file for later scrub workload.
+# The 2G size is chosen to fit even DUP on a 5G disk.
+$XFS_IO_PROG -f -c "pwrite -i /dev/urandom 0 2G" $SCRATCH_MNT/file | _filter_xfs_io
+
+# Writeback above data, as scrub only verify the committed data.
+sync
+
+throttle_mb=50
+# Those are floor and ceiling for us to compare the result, give it a
+# generous +- 10% tolerance.
+throttle_mb_ceiling=55
+throttle_mb_floor=45
+
+# Set the speed limit to 50MiB/s, which should be slower than almost all
+# modern HDD.
+# This would take around 40 sec to scrub above data for SINGLE, double for DUP.
+# With extra time spent on writing the data.
+echo $(($throttle_mb * 1024 * 1024)) > "${devinfo_dir}/scrub_speed_max"
+
+$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT > $tmp.scrub_result
+cat $tmp.scrub_result >> $seqres.full
+
+# The output looks like this:
+# Scrub done for 42d25bc2-e8b7-432e-9850-f3314aefffc6
+# Scrub started:    Wed Jan  4 13:12:00 2023
+# Status:           finished
+# Duration:         0:00:30
+# Total to scrub:   7.52GiB
+# Rate:             205.22MiB/s
+# Error summary:    no errors found
+#
+# What we care is that Rate line, and only the int part.
+speed=$(grep "Rate:" $tmp.scrub_result | $AWK_PROG '{print $2}' | cut -f1 -d.)
+
+if [ "$speed" -gt "$throttle_mb_ceiling" -o "$speed" -lt "$throttle_mb_floor" ]; then
+	echo "scrub speed $speed is not properly throttled"
+fi
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/282.out b/tests/btrfs/282.out
new file mode 100644
index 00000000..8d53e7eb
--- /dev/null
+++ b/tests/btrfs/282.out
@@ -0,0 +1,3 @@
+QA output created by 282
+wrote 2147483648/2147483648 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-- 
2.39.0

