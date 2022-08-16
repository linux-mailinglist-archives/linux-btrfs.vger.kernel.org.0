Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A8C5954CA
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Aug 2022 10:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbiHPIPI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Aug 2022 04:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbiHPIOi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Aug 2022 04:14:38 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDC3A00FE;
        Mon, 15 Aug 2022 23:21:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 53DBC5BD0F;
        Tue, 16 Aug 2022 06:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1660630880; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=5aVGzAWQvMfe6IW//9T7qw8GP0WcddjvAVIo+6BJdNc=;
        b=M2wyF9GdD4LkBZEp2K7FUceawIUQT8sFVEBQQng+n73JmuCmR8wy6fKCaCGsWYfZDoWrWJ
        QxxNmRz5jTnJT3xWoMIMiE0vWyu11ngBtG6FF++fT54kImi9RQG5A9eO7HWxFJsovNd2Li
        zLZnxbLRjWH0uugMX3rFzXaJY94AqH0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6BB541345B;
        Tue, 16 Aug 2022 06:21:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hcAWDV83+2IvLAAAMHmgww
        (envelope-from <wqu@suse.com>); Tue, 16 Aug 2022 06:21:19 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: [PATCH] btrfs: add test case to check if btrfs RAID5 can detect corrupted data stripe
Date:   Tue, 16 Aug 2022 14:21:01 +0800
Message-Id: <20220816062101.36119-1-wqu@suse.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This test case is not intended to pass with current btrfs code.

The problem of "destructive RMW" is affecting btrfs from the very
beginning of btrfs RAID56.

The "destructive RMW" happens by:

- Do some sub-stripe writes into data stripe 1

- Corrupt above written data stripe 1

- Do some sub-stripe writes into data stripe 2 of the same full stripe
  We need to do RMW to calculate a new P/Q stripe.
  However btrfs RAID56 code has no way to determine on-disk data stripes
  are correct or not. It just read the corrupted data stripe 1, and
  use them to calculate new P stripe.

  Since data stripe 1 is already corrupted, the new P stripe (with
  correct data stripe 2) can not recover the original data stripe 1,
  making data stripe 1 unable to recover.

The test case itself will intentionally create such "destructive RMW" to
check if btrfs can handle it.

Unfortunately current btrfs code can not handle it at all, thus the test
case is going to always fail.

Thus the test case is here mostly to leave a warning sign for now, and
that's why it's only in "raid" and "repair" groups.

It will only moved to "auto" and "quick" groups after upstream kernel
has a way to solve it.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/272     | 62 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/272.out |  5 ++++
 2 files changed, 67 insertions(+)
 create mode 100755 tests/btrfs/272
 create mode 100644 tests/btrfs/272.out

diff --git a/tests/btrfs/272 b/tests/btrfs/272
new file mode 100755
index 00000000..d4aa7737
--- /dev/null
+++ b/tests/btrfs/272
@@ -0,0 +1,62 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test 272
+#
+# Test if btrfs RAID5 can detects corrupted data stripes before doing RMW.
+#
+# If not properly detected, this can make btrfs RAID56 to use corrupted data
+# stripes to calculate new P/Q stripes, and result unrecoverable corruption.
+#
+# Unfortunately such error detection is not implemented in btrfs RAID56 yet.
+#
+. ./common/preamble
+_begin_fstest quick raid repair
+
+# Import common functions.
+. ./common/btrfs
+. ./common/filter
+
+# real QA test starts here
+_supported_fs btrfs
+_require_scratch_dev_pool 3
+_scratch_dev_pool_get 3
+
+# mkfs using RAID5 will cause WARNING message, needs to redirect it.
+_scratch_pool_mkfs "-d raid5 -m raid5" >> $seqres.full 2>&1
+
+_scratch_mount
+
+# Btrfs RAID all uses 64K as stripe length, so this should
+# fill data stripe 1.
+$XFS_IO_PROG -f -c "pwrite -S 0x11 0 64K" $SCRATCH_MNT/file1 -c sync > /dev/null
+
+echo "=== MD5 before corruption ==="
+_md5_checksum $SCRATCH_MNT/file1
+
+logical=$(_btrfs_get_first_logical $SCRATCH_MNT/file1)
+physical=$(_btrfs_get_physical $logical 1)
+dev=$(_btrfs_get_device_path $logical 1)
+
+echo "=== Data stripe 1, logical=$logical dev=$dev physical=$physical ===" >> $seqres.full
+_scratch_unmount
+
+# Corrupt data stripe 1
+$XFS_IO_PROG -c "pwrite -S 0xff $physical 64K" $dev > /dev/null
+
+_scratch_mount
+
+# Do a new write into data stripe 2, this write will trigger RMW, which will
+# read data stripe 1 (already corrupted) to calculate P stripe.
+$XFS_IO_PROG -f -c "pwrite -S 0x22 0 64K" $SCRATCH_MNT/file2 -c sync > /dev/null
+
+# Check if file1 (aka, data stripe 1) can still be recovered
+echo "=== MD5 after corruption and RMW ==="
+_md5_checksum $SCRATCH_MNT/file1
+
+_scratch_unmount
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/272.out b/tests/btrfs/272.out
new file mode 100644
index 00000000..b7bb02f4
--- /dev/null
+++ b/tests/btrfs/272.out
@@ -0,0 +1,5 @@
+QA output created by 272
+=== MD5 before corruption ===
+876f4f724f70c185824f120574658786
+=== MD5 after corruption and RMW ===
+876f4f724f70c185824f120574658786
-- 
2.37.2

