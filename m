Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7C660393D
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Oct 2022 07:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiJSFaE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Oct 2022 01:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiJSFaD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Oct 2022 01:30:03 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C76140E23;
        Tue, 18 Oct 2022 22:30:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5AD2033872;
        Wed, 19 Oct 2022 05:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666157399; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=YjAslUF5MUs7WNiZuNiHgSlcETcvP+nt0+mVaySQbDo=;
        b=rEho6/Wo/1GdQ1wauL7sA6sdiFIoOhRPD6uwf78yGtdtO8cFd+EsajOXYTZr04zZ5eKRsv
        pDg6VFifrnchd0Cjxzt+WL1YG/YaAmcduib30/kHiPMkZGY2ac+J7dJKJdc+1u9QgTo4jg
        khkJHG4BY7vZXvW437FXm/qXRbpoDU0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7364713A36;
        Wed, 19 Oct 2022 05:29:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GS3yDlaLT2PsCwAAMHmgww
        (envelope-from <wqu@suse.com>); Wed, 19 Oct 2022 05:29:58 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: [PATCH] generic: check if one fs can detect damage at/after fs thaw
Date:   Wed, 19 Oct 2022 13:29:55 +0800
Message-Id: <20221019052955.30484-1-wqu@suse.com>
X-Mailer: git-send-email 2.38.0
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
There is bug report from btrfs mailing list that, hiberation can allow
one to modify the frozen filesystem unexpectedly (using another OS).
(https://lore.kernel.org/linux-btrfs/83bf3b4b-7f4c-387a-b286-9251e3991e34@bluemole.com/)

Later btrfs adds the check to make sure the fs is not changed
unexpectedly, to prevent corruption from happening.

[TESTCASE]
Here the new test case will create a basic filesystem, fill it with
something by using fsstress, then sync the fs, and finally freeze the fs.

Then corrupt the whole fs by overwriting the block device with 0xcd
(default seed from xfs_io pwrite command).

Finally we thaw the fs, and try if we can create a new file.

for EXT4, it will detect the corruption at touch time, causing -EUCLEAN.

For Btrfs, it will detect the corruption at thaw time, marking the
fs RO immediately, and later touch will return -EROFS.

For XFS, it will detect the corruption at touch time, return -EUCLEAN.
(Without the cache drop, XFS seems to be very happy using the cache info
to do the work without any error though.)

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/generic/702     | 61 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/702.out |  2 ++
 2 files changed, 63 insertions(+)
 create mode 100755 tests/generic/702
 create mode 100644 tests/generic/702.out

diff --git a/tests/generic/702 b/tests/generic/702
new file mode 100755
index 00000000..fc3624e1
--- /dev/null
+++ b/tests/generic/702
@@ -0,0 +1,61 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test 702
+#
+# Test if the filesystem can detect the underlying disk has changed at
+# thaw time.
+#
+. ./common/preamble
+. ./common/filter
+_begin_fstest freeze quick
+
+# real QA test starts here
+
+_supported_fs generic
+_fixed_by_kernel_commit a05d3c915314 \
+	"btrfs: check superblock to ensure the fs was not modified at thaw time"
+
+# We will corrupt the device completely, thus should not check it after the test.
+_require_scratch_nocheck
+_require_freeze
+
+# Limit the fs to 512M so we won't waste too much time screwing it up later.
+_scratch_mkfs_sized $((512 * 1024 * 1024)) >> $seqres.full 2>&1
+_scratch_mount
+
+# Populate the fs with something.
+$FSSTRESS_PROG -n 500 -d $SCRATCH_MNT >> $seqres.full
+
+# Sync to make sure no dirty journal
+sync
+
+# Drop all cache, so later write will need to read from disk, increasing
+# the chance of detecting the corruption.
+echo 3 > /proc/sys/vm/drop_caches
+
+$XFS_IO_PROG -x -c "freeze" $SCRATCH_MNT
+
+# Now screw up the block device
+$XFS_IO_PROG -f -c "pwrite 0 512M" -c sync $SCRATCH_DEV >> $seqres.full
+
+# Thaw the fs, it may or may not report error, we will check it manually later.
+$XFS_IO_PROG -x -c "thaw" $SCRATCH_MNT
+
+# If the fs detects something wrong, it should trigger error now.
+# We don't use the error message as golden output, as btrfs and ext4 use
+# different error number for different reasons.
+# (btrfs detects the change immediately at thaw time and mark the fs RO, thus
+#  touch returns -EROFS, while ext4 detects the change at journal write time,
+#  returning -EUCLEAN).
+touch $SCRATCH_MNT/foobar >>$seqres.full 2>&1
+if [ $? -eq 0 ]; then
+	echo "Failed to detect corrupted fs"
+else
+	echo "Detected corrupted fs (expected)"
+fi
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/702.out b/tests/generic/702.out
new file mode 100644
index 00000000..c29311ff
--- /dev/null
+++ b/tests/generic/702.out
@@ -0,0 +1,2 @@
+QA output created by 702
+Detected corrupted fs (expected)
-- 
2.38.0

