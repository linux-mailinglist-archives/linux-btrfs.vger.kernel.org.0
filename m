Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F1865E5EE
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jan 2023 08:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjAEHSl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Jan 2023 02:18:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjAEHSk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Jan 2023 02:18:40 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45E02003;
        Wed,  4 Jan 2023 23:18:38 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6098D6B4CC;
        Thu,  5 Jan 2023 07:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1672903117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=vDaeroessdr9azGpDl4avENGziEkQvuyVBjk1ecc3dE=;
        b=aRYm7OxdCBm+xVEqrPlh2gnIsbjw4URPpuljwytYxWj7iUR6qTbWR1kMlusDRx0Eczwib1
        L3yFm6yPnq04uRPx0UxIqb8LX63ETgXIXMSjjgL7fhy/DrON10nwKefx+CairicoLZGzIb
        d4nVJIQYw9t2cdCDvExUocbLhhhDGT0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8A11313273;
        Thu,  5 Jan 2023 07:18:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id En+YFcx5tmN2ewAAMHmgww
        (envelope-from <wqu@suse.com>); Thu, 05 Jan 2023 07:18:36 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: [PATCH] btrfs: add a test case to verify scrub speed throttle works
Date:   Thu,  5 Jan 2023 15:18:19 +0800
Message-Id: <20230105071819.44226-1-wqu@suse.com>
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
- Scrub without any throttle to grab the initial speed
- Set the throttle to half of the initial speed
- Scrub again and check the speed against the throttle

The test case has an assumption that we can exclusively use all the
performance of the underlying disk.
But for cloud environment it's not ensured 100%, thus the test case is
not included in auto group to avoid false alerts.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Instead of a hardcoded speed, run scrub to grab the performance and
  set the throttle to half of the original speed
  This reduced the test runtime from 60s to 30s on a SATA SSD.

- Use "btrfs scrub status" to grab raw scrub speed
  The output of "btrfs scrub start -B" can not be switched to raw mode,
  which makes later parsing harder.
---
 tests/btrfs/282     | 92 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/282.out |  3 ++
 2 files changed, 95 insertions(+)
 create mode 100755 tests/btrfs/282
 create mode 100644 tests/btrfs/282.out

diff --git a/tests/btrfs/282 b/tests/btrfs/282
new file mode 100755
index 00000000..78b56528
--- /dev/null
+++ b/tests/btrfs/282
@@ -0,0 +1,92 @@
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
+# The first scrub, mostly to grab the speed of the scrub.
+$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >> $seqres.full
+
+# We grab the rate from "scrub status" which supports raw bytes reporting
+#
+# The output looks like this:
+# UUID:             62eaabc5-93e8-445f-b8a7-6f027934aea7
+# Scrub started:    Thu Jan  5 14:59:12 2023
+# Status:           finished
+# Duration:         0:00:02
+# Total to scrub:   1076166656
+# Rate:             538083328/s
+# Error summary:    no errors found
+#
+# What we care is that Rate line.
+init_speed=$($BTRFS_UTIL_PROG scrub status --raw $SCRATCH_MNT | grep "Rate:" |\
+	     $AWK_PROG '{print $2}' | cut -f1 -d\/)
+
+# This can happen for older progs
+if [ -z "$init_speed" ]; then
+	_notrun "btrfs-progs doesn't support scrub rate reporting"
+fi
+
+# Cycle mount to drop any possible cache.
+_scratch_cycle_mount
+
+target_speed=$(( $init_speed / 2 ))
+echo "$target_speed" > "${devinfo_dir}/scrub_speed_max"
+
+# The second scrub, to check the throttled speed.
+$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >> $seqres.full
+speed=$($BTRFS_UTIL_PROG scrub status --raw $SCRATCH_MNT | grep "Rate:" |\
+	     $AWK_PROG '{print $2}' | cut -f1 -d\/)
+
+# We gave a +- 10% tolerance for the throttle
+if [ "$speed" -gt "$(( $target_speed * 11 / 10 ))" -o \
+     "$speed" -lt "$(( $target_speed * 9 / 10))" ]; then
+	echo "scrub speed $speed Bytes/s is not properly throttled, target is $target_speed Bytes/s"
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

