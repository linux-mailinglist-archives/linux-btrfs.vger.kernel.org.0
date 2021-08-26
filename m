Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F13953F8218
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Aug 2021 07:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238228AbhHZFfZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Aug 2021 01:35:25 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:52454 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbhHZFfZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Aug 2021 01:35:25 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7E93222267;
        Thu, 26 Aug 2021 05:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629956076; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Zh5zTbYrACt4As5TBRGxFZInmHbq6wKinDyVRpBAOg0=;
        b=A63dc9yqkDzy13MfPOrrshk00vMLKllQ9eHZ6ooFeZ6xUrbXKHJ36XhMjb7E/wVXS6m+TC
        V6X8zA2vsjdigfEW5L22RPJkVd6dzMv7+9fWzzHjWDO0gkhSCgtqFbPxR9gcpoYGOtHiuz
        09tWyUIajCjWXSbwYFDyH1gLFBLslDo=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 7487E13895;
        Thu, 26 Aug 2021 05:34:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 2KTWDOsnJ2EJZwAAGKfGzw
        (envelope-from <wqu@suse.com>); Thu, 26 Aug 2021 05:34:35 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2] fstests: btrfs/246: add test case to make sure btrfs can create compressed inline extent
Date:   Thu, 26 Aug 2021 13:34:32 +0800
Message-Id: <20210826053432.13146-1-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Btrfs has the ability to inline small file extents into its metadata,
and such inlined extents can be further compressed if needed.

The new test case is for a regression caused by commit f2165627319f
("btrfs: compression: don't try to compress if we don't have enough
pages").

That commit prevents btrfs from creating compressed inline extents, even
"-o compress,max_inline=2048" is specified, only uncompressed inline
extents can be created.

The test case will make sure that the content of the small file is
consistent between cycle mount, then use "btrfs inspect dump-tree" to
verify the created extent is both inlined and compressed.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Also output the sha256sum to make sure the content is consistent
---
 tests/btrfs/246     | 53 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/246.out |  5 +++++
 2 files changed, 58 insertions(+)
 create mode 100755 tests/btrfs/246
 create mode 100644 tests/btrfs/246.out

diff --git a/tests/btrfs/246 b/tests/btrfs/246
new file mode 100755
index 00000000..e0d8016f
--- /dev/null
+++ b/tests/btrfs/246
@@ -0,0 +1,53 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2021 SUSE Linux Products GmbH.  All Rights Reserved.
+#
+# FS QA Test 246
+#
+# Make sure btrfs can create compressed inline extents
+#
+. ./common/preamble
+_begin_fstest auto quick compress
+
+# Override the default cleanup function.
+_cleanup()
+{
+	cd /
+	rm -r -f $tmp.*
+}
+
+# Import common functions.
+. ./common/filter
+# For __populate_find_inode()
+. ./common/populate
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs btrfs
+_require_scratch
+
+_scratch_mkfs > /dev/null
+_scratch_mount -o compress,max_inline=2048
+
+# This should create compressed inline extent
+$XFS_IO_PROG -f -c "pwrite 0 2048" $SCRATCH_MNT/foobar > /dev/null
+ino=$(__populate_find_inode $SCRATCH_MNT/foobar)
+echo "sha256sum before mount cycle"
+sha256sum $SCRATCH_MNT/foobar | _filter_scratch
+_scratch_cycle_mount
+echo "sha256sum after mount cycle"
+sha256sum $SCRATCH_MNT/foobar | _filter_scratch
+_scratch_unmount
+
+$BTRFS_UTIL_PROG inspect dump-tree -t 5 $SCRATCH_DEV | \
+	grep "($ino EXTENT_DATA 0" -A2 > $tmp.dump-tree
+echo "dump tree result for ino $ino:" >> $seqres.full
+cat $tmp.dump-tree >> $seqres.full
+
+grep -q "inline extent" $tmp.dump-tree || echo "no inline extent found"
+grep -q "compression 1" $tmp.dump-tree || echo "no compressed extent found"
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/246.out b/tests/btrfs/246.out
new file mode 100644
index 00000000..3908cc50
--- /dev/null
+++ b/tests/btrfs/246.out
@@ -0,0 +1,5 @@
+QA output created by 246
+sha256sum before mount cycle
+0ca3bfdeda1ef5036bfa5dad078a9f15724e79cf296bd4388cf786bfaf4195d0  SCRATCH_MNT/foobar
+sha256sum after mount cycle
+0ca3bfdeda1ef5036bfa5dad078a9f15724e79cf296bd4388cf786bfaf4195d0  SCRATCH_MNT/foobar
-- 
2.31.1

