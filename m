Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6F63477224
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Dec 2021 13:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236940AbhLPMsP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Dec 2021 07:48:15 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:35658 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236919AbhLPMsO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Dec 2021 07:48:14 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 97F321F3A9
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Dec 2021 12:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1639658893; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=PCk6PS4Qlskp0oXr706S2DdNQwcLJ1fVqDVuAQy8DHQ=;
        b=O8L7yZxfH4TMPdWCHX5ZDdVDszwqtVQwTTbfaZvVsNE7XGBSVuDFBmUQ7q9rv8U4UZUNpM
        MRMM337y1Gnwc5ERrPzEfn5gzFbhmCoObRQzzaAVfZ9XvOfTRdGSpoZWf5EevMnBMnIi+Q
        nZ+exdIyh6/YkQor93ZhqUUlCtG0M1U=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ED77213E3B
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Dec 2021 12:48:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id D85+LYw1u2FiXgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Dec 2021 12:48:12 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: add test case for read-only scrub on read-only mount
Date:   Thu, 16 Dec 2021 20:47:55 +0800
Message-Id: <20211216124755.74341-1-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is a long existing bug that read-only scrub on read-only mounted
btrfs can lead to a uncommitted and empty transaction.

Such problem is not detected until v5.11 which new ASSERT() is added.

The purposed fix is titled "btrfs: don't start transaction for scrub if
the fs is mounted read-only".

The test case is here to make sure a read-only scrub on read-only
mounted btrfs won't crash/trigger ASSERT() at unmount time.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/254     | 48 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/254.out |  3 +++
 2 files changed, 51 insertions(+)
 create mode 100755 tests/btrfs/254
 create mode 100644 tests/btrfs/254.out

diff --git a/tests/btrfs/254 b/tests/btrfs/254
new file mode 100755
index 00000000..0e001cd9
--- /dev/null
+++ b/tests/btrfs/254
@@ -0,0 +1,48 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2021 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test 254
+#
+# Make sure running read-only scrub on read-only mounted btrfs won't crash
+# the kernel at unmount time
+#
+. ./common/preamble
+_begin_fstest auto quick scrub
+
+# Override the default cleanup function.
+# _cleanup()
+# {
+# 	cd /
+# 	rm -r -f $tmp.*
+# }
+
+# Import common functions.
+. ./common/filter
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs btrfs
+_require_scratch
+
+_scratch_mkfs >> $seqres.full
+_scratch_mount
+
+# Fill the fs with some content for later scrub
+_pwrite_byte 0xff 0 64k "$SCRATCH_MNT/foobar" | _filter_xfs_io
+
+# Cycle mount to read-only
+_scratch_cycle_mount ro
+
+# Do the read-only scrub.
+# For unpatched kernel, this would lead to a new transaction
+# on read-only fs, which will not be committed
+$BTRFS_UTIL_PROG scrub start -Br "$SCRATCH_MNT"  >> $seqres.full
+
+# At unmount time, if kernel has CONFIG_BTRFS_ASSERT, then it would
+# crash at one ASSERT(), cause by above uncommitted transaction.
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/254.out b/tests/btrfs/254.out
new file mode 100644
index 00000000..58fd5a0f
--- /dev/null
+++ b/tests/btrfs/254.out
@@ -0,0 +1,3 @@
+QA output created by 254
+wrote 65536/65536 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-- 
2.34.1

