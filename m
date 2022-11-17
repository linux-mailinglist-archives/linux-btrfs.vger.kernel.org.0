Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B172362D642
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Nov 2022 10:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234664AbiKQJR7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Nov 2022 04:17:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiKQJR6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Nov 2022 04:17:58 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F665DB84;
        Thu, 17 Nov 2022 01:17:57 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E677B1F8AF;
        Thu, 17 Nov 2022 09:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1668676675; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=hHWJB6UwBbzJXcnSDqMyNFK9UeRc3ZkpNKxmctSQLXo=;
        b=nP3gd/HcRWIsp7N/DpqsnLRMRCvLPt9z5oWf4ZPH69AFiV0dv7yyYtDsVcbseSB34PKptu
        43/hwDkSs1Ia0rlLCrm57LLSQPh0oAx44Z0+BzhYO+jmxxKAWrKnPQLW214+jqqDH3uw/1
        2yuDO7MDq/5iBnpozchwT4nAtNjEq7g=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 00F9D13A12;
        Thu, 17 Nov 2022 09:17:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NgonLkL8dWMmWwAAMHmgww
        (envelope-from <wqu@suse.com>); Thu, 17 Nov 2022 09:17:54 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: [PATCH v2] fstests: shared: generic: check if one fs can detect damage at fs thaw
Date:   Thu, 17 Nov 2022 17:17:37 +0800
Message-Id: <20221117091737.65822-1-wqu@suse.com>
X-Mailer: git-send-email 2.38.1
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

[BACKGROUND]
There is bug report from btrfs mailing list that, hibernation can allow
one to modify the frozen filesystem unexpectedly (using another OS).
(https://lore.kernel.org/linux-btrfs/83bf3b4b-7f4c-387a-b286-9251e3991e34@bluemole.com/)

Later btrfs adds the check to make sure the fs is not changed
unexpectedly, to prevent corruption from happening.

[TESTCASE]
The test case will test the following three cases:

- Completely corrupted super block
  Fill the superblock range (the first 1M) with garbage.

- Superblock is valid, but has different fsid
  We save a binary dump of a newly created fs, then create
  another fs on the scratch device.
  After the fs got frozen, write the saved binary dump back.

- Superblock is valid, but has different generation.
  We save a binary dump of a newly created fs.

  Then modify the created fs, then freeze it.
  After the fs got frozen, write the saved binary dump back.

And since we're using "$tmp.binary_dump" to save the whole 512M fs,
systems with small memory and using tmpfs as /tmp may fail to save the
image.
Thus before the run, the test case will do a dry run to make sure we can
save the image into "$tmp.binary_dump" first.

Currently only btrfs does such explicit check at thaw time, thus it will
mark the fs RO immediately.

Other common fses like XFS/EXT4 can detect the problem at read or write
time, but no explicit check at thaw time yet.
Feel free to opt-in the new test case if the early check sounds valid.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Move the test case to shared group
  This allow each fs to opt-in.

- Add two new types of super block modification
  Other than pure garbage, also introduce:
  * Valid superblock but different fsid
  * valid superblock and same fsid, but different generation

- Remove cache drop
  To make the explicit thaw time check more obvious.
---
 tests/shared/001     | 116 +++++++++++++++++++++++++++++++++++++++++++
 tests/shared/001.out |  10 ++++
 2 files changed, 126 insertions(+)
 create mode 100755 tests/shared/001
 create mode 100644 tests/shared/001.out

diff --git a/tests/shared/001 b/tests/shared/001
new file mode 100755
index 00000000..a160cd06
--- /dev/null
+++ b/tests/shared/001
@@ -0,0 +1,116 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test 001
+#
+# Test if a filesystem can detect unexpected changes at thaw time.
+#
+
+. ./common/preamble
+_begin_fstest auto freeze
+
+# For now, only btrfs explicitly checks the superblock at thaw time.
+_supported_fs btrfs
+_require_freeze
+_require_scratch
+
+if [ "x$FSTYP" == "xbtrfs" ]; then
+	_fixed_by_kernel_commit a05d3c915314 \
+		"btrfs: check superblock to ensure the fs was not modified at thaw time"
+fi
+
+# Make sure we can save the whole binary dump of the fs into $tmp, which
+# is normally backed up by tmpfs, thus may have very limited size.
+dd if=/dev/zero of=$tmp.binary_dump bs=1M count=512 >> $seqres.full 2>&1
+if [ $? -ne 0 ]; then
+	_notrun "Failed to save 512M sized image into $tmp.binary, maybe /tmp is too small?"
+fi
+rm -f $tmp.binary_dump
+
+prepare_and_freeze()
+{
+	_scratch_mount
+
+	$FSSTRESS_PROG -d $SCRATCH_MNT -n 100 -w >> $seqres.full
+	sync
+
+	$XFS_IO_PROG -x -c "freeze" $SCRATCH_MNT >> $seqres.full
+}
+
+thaw_and_verify()
+{
+	# We can not rely on the return value from thaw operation,
+	# as even some checks failed, we have to return 0 to allow
+	# the fs exit frezon status. Thus we do the check later.
+	$XFS_IO_PROG -x -c "thaw" $SCRATCH_MNT >> $seqres.full 2>&1
+
+	touch $SCRATCH_MNT/should_fail &> $seqres.full
+	if [ $? -eq 0 ]; then
+		echo "Failed to detect corrupted super block"
+	else
+		echo "Detected corrupted super block and fs fell RO"
+	fi
+	echo
+	_scratch_unmount
+}
+
+save_scratch_dev()
+{
+	dd if=$SCRATCH_DEV of=$tmp.binary_dump bs=1M count=512 >> $seqres.full 2>&1
+	if [ $? -ne 0 ]; then
+		_fail "Unable to save the full fs binary dump"
+	fi
+}
+
+restore_scratch_dev()
+{
+	dd if=$tmp.binary_dump of=$SCRATCH_DEV bs=1M >> $seqres.full 2>&1
+	if [ $? -ne 0 ]; then
+		_fail "Unable to restore the full fs binary dump"
+	fi
+	rm -f $tmp.binary_dump
+}
+
+test_corrupted_super()
+{
+	echo "Corrupted super block at thaw time:"
+	_scratch_mkfs_sized $((512 * 1024 * 1024)) >> $seqres.full
+	prepare_and_freeze
+	# Corrupt the first 1M to cover the superblock.
+	dd if=/dev/zero of=$SCRATCH_DEV bs=1M count=1 >> $seqres.full 2>&1
+	thaw_and_verify
+}
+
+test_different_fs()
+{
+	echo "Different fs at thaw time:"
+	_scratch_mkfs_sized $((512 * 1024 * 1024)) >> $seqres.full
+	save_scratch_dev
+
+	# Now go a new fs to start the test.
+	_scratch_mkfs_sized $((512 * 1024 * 1024)) >> $seqres.full
+
+	prepare_and_freeze
+	restore_scratch_dev
+	thaw_and_verify
+}
+
+test_different_generation()
+{
+	echo "Same fs but different generation:"
+
+	_scratch_mkfs_sized $((512 * 1024 * 1024)) >> $seqres.full
+	save_scratch_dev
+	prepare_and_freeze
+	restore_scratch_dev
+	thaw_and_verify
+}
+
+test_corrupted_super
+test_different_fs
+test_different_generation
+
+# success, all done
+status=0
+exit
diff --git a/tests/shared/001.out b/tests/shared/001.out
new file mode 100644
index 00000000..2aa0e02a
--- /dev/null
+++ b/tests/shared/001.out
@@ -0,0 +1,10 @@
+QA output created by 001
+Corrupted super block at thaw time:
+Detected corrupted super block and fs fell RO
+
+Different fs at thaw time:
+Detected corrupted super block and fs fell RO
+
+Same fs but different generation:
+Detected corrupted super block and fs fell RO
+
-- 
2.38.0

