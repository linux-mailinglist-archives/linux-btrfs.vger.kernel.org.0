Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B7C581F9B
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jul 2022 07:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiG0FmK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Jul 2022 01:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiG0FmK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Jul 2022 01:42:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6C93B95D;
        Tue, 26 Jul 2022 22:42:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3DFDB381D4;
        Wed, 27 Jul 2022 05:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1658900527; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=MyZs/QCP9urUgkfH3NWZAE7TKzCTdqGgvAD6LWgop7k=;
        b=Wh/WFd8ABHQ8AmvKXjGsRPEhvtCEsikSq3+4N0a3xy0NMxB2Kic5ir+qL/bpu3U14rmCuY
        eIbsx+bN0gvNSuSFNET3VtvvMi7DKHdaWckI4VId/Pau4edFdemd8gho16ZmjD0u040ZhZ
        PEhUtLAymLzcrRNbBk84Bziwvhx0Zb8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4E93913A7C;
        Wed, 27 Jul 2022 05:42:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5axaCC7Q4GIqagAAMHmgww
        (envelope-from <wqu@suse.com>); Wed, 27 Jul 2022 05:42:06 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Cc:     Boris Burkov <boris@bur.io>
Subject: [PATCH v2] fstests: add test case to make sure btrfs can handle one corrupted device
Date:   Wed, 27 Jul 2022 13:41:48 +0800
Message-Id: <20220727054148.73405-1-wqu@suse.com>
X-Mailer: git-send-email 2.37.0
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

The new test case will verify that btrfs can handle one corrupted device
without affecting the consistency of the filesystem.

Unlike a missing device, one corrupted device can return garbage to the fs,
thus btrfs has to utilize its data/metadata checksum to verify which
data is correct.

The test case will:

- Create a small fs
  Mostly to speedup the test

- Fill the fs with a regular file

- Use fsstress to create some contents

- Save the fssum for later verification

- Corrupt one device with garbage but keep the primary superblock
  untouched

- Run fssum verification

- Run scrub to fix the fs

- Run scrub again to make sure the fs is fine

Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Boris Burkov <boris@bur.io>
---
Changelog:
v2:
- Use _btrfs_get_profile_configs() helper to grab the mkfs options
- Use fixed number of devices 4 to co-operate with above change
- Remove a not-so-helpful debug output into $seqres.full
- Add to group auto and volume
- Use $SCRATCH_DEV as the first device and target to corrupt
---
 tests/btrfs/261     | 90 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/261.out |  2 +
 2 files changed, 92 insertions(+)
 create mode 100755 tests/btrfs/261
 create mode 100644 tests/btrfs/261.out

diff --git a/tests/btrfs/261 b/tests/btrfs/261
new file mode 100755
index 00000000..8861ae99
--- /dev/null
+++ b/tests/btrfs/261
@@ -0,0 +1,90 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test 261
+#
+# Make sure btrfs raid profiles can handling one corrupted device
+# without affecting the consistency of the fs.
+#
+. ./common/preamble
+_begin_fstest auto volume raid
+
+. ./common/filter
+. ./common/populate
+
+_supported_fs btrfs
+_require_scratch_dev_pool 4
+_btrfs_get_profile_configs replace-missing
+_require_fssum
+
+prepare_fs()
+{
+	local mkfs_opts=$1
+
+	# We don't want too large fs which can take too long to populate
+	# And the extra redirection of stderr is to avoid the RAID56 warning
+	# message to polluate the golden output
+	_scratch_pool_mkfs $mkfs_opts -b 1G >> $seqres.full 2>&1
+	if [ $? -ne 0 ]; then
+		_fail "mkfs $mkfs_opts failed"
+	fi
+
+	# Disable compression, as compressed read repair is known to have problems
+	_scratch_mount -o compress=no
+
+	# Fill some part of the fs first
+	$XFS_IO_PROG -f -c "pwrite -S 0xfe 0 400M" $SCRATCH_MNT/garbage > /dev/null 2>&1
+
+	# Then use fsstress to generate some extra contents.
+	# Disable setattr related operations, as it may set NODATACOW which will
+	# not allow us to use btrfs checksum to verify the content.
+	$FSSTRESS_PROG -f setattr=0 -d $SCRATCH_MNT -w -n 3000 > /dev/null 2>&1
+	sync
+
+	# Save the fssum of this fs
+	$FSSUM_PROG -A -f -w $tmp.saved_fssum $SCRATCH_MNT
+	_scratch_unmount
+}
+
+workload()
+{
+	local mkfs_opts=$1
+	local num_devs=$2
+
+	_scratch_dev_pool_get 4
+	echo "=== Testing profile $mkfs_opts ===" >> $seqres.full
+	rm -f -- $tmp.saved_fssum
+	prepare_fs "$mkfs_opts"
+
+	# $SCRATCH_DEV is always the first device of dev pool.
+	# Corrupt the disk but keep the primary superblock.
+	$XFS_IO_PROG -c "pwrite 1M 1023M" $SCRATCH_DEV > /dev/null 2>&1
+
+	_scratch_mount
+
+	# All content should be fine
+	$FSSUM_PROG -r $tmp.saved_fssum $SCRATCH_MNT > /dev/null
+
+	# Scrub to fix the fs, this is known to report various correctable
+	# errors
+	$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >> $seqres.full 2>&1
+
+	# Make sure above scrub fixed the fs
+	$BTRFS_UTIL_PROG scrub start -Br $SCRATCH_MNT >> $seqres.full
+	if [ $? -ne 0 ]; then
+		echo "scrub failed to fix the fs for profile $mkfs_opts"
+	fi
+	_scratch_unmount
+	_scratch_dev_pool_put
+}
+
+for t in "${_btrfs_profile_configs[@]}"; do
+	workload "$t"
+done
+
+echo "Silence is golden"
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/261.out b/tests/btrfs/261.out
new file mode 100644
index 00000000..679ddc0f
--- /dev/null
+++ b/tests/btrfs/261.out
@@ -0,0 +1,2 @@
+QA output created by 261
+Silence is golden
-- 
2.36.1

