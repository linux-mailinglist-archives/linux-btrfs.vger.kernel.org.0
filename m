Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8068D260FE8
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Sep 2020 12:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729775AbgIHKcZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Sep 2020 06:32:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:40022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729767AbgIHKcM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 8 Sep 2020 06:32:12 -0400
Received: from debian8.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EADD9206DB;
        Tue,  8 Sep 2020 10:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599561129;
        bh=rAjNo2Ow6A7FccLur3eqVizb+qWyU/wl7RM1COPNrOA=;
        h=From:To:Cc:Subject:Date:From;
        b=yBN2DEeDhX7j8nVVWr6P5BQYarg2Ms0KI3m9m5QUJ8dFVGayzNUJMqyF2R0ZrOW+o
         yyhwSQKpTS1JrwuAJTDZWvkuAYE1O+T21o2JDZY8kKZPhO9tZ+IjNESeAr5VBc9i8f
         knDiO7B41lNfaK1BlEJS4ADzKoHt5fPMffLFXBf4=
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] generic: add test for zero range over a file range with many small extents
Date:   Tue,  8 Sep 2020 11:32:02 +0100
Message-Id: <e038bd2419f60f0b4c5ac13da78bfba345f4dba7.1599560067.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Test a fallocate() zero range operation against a large file range for which
there are many small extents allocated. Verify the operation does not fail
and the respective range return zeroes on subsequent reads.

This test is motivated by a bug found on btrfs. The patch that fixes the
bug on btrfs has the following subject:

 "btrfs: fix metadata reservation for fallocate that leads to transaction aborts"

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/generic/609     | 61 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/609.out |  5 ++++
 tests/generic/group   |  1 +
 3 files changed, 67 insertions(+)
 create mode 100755 tests/generic/609
 create mode 100644 tests/generic/609.out

diff --git a/tests/generic/609 b/tests/generic/609
new file mode 100755
index 00000000..cda2b3dc
--- /dev/null
+++ b/tests/generic/609
@@ -0,0 +1,61 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2020 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test No. 609
+#
+# Test a fallocate() zero range operation against a large file range for which
+# there are many small extents allocated. Verify the operation does not fail
+# and the respective range return zeroes on subsequent reads.
+#
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+tmp=/tmp/$$
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+_require_scratch
+_require_xfs_io_command "fzero"
+_require_xfs_io_command "fpunch"
+_require_test_program "punch-alternating"
+
+rm -f $seqres.full
+
+_scratch_mkfs >>$seqres.full 2>&1
+_scratch_mount
+
+# Create a file with many small extents. To speed up file creation, do
+# buffered writes and then punch a hole on every other block.
+$XFS_IO_PROG -f -c "pwrite -S 0xab -b 10M 0 100M" \
+	$SCRATCH_MNT/foobar >>$seqres.full
+$here/src/punch-alternating $SCRATCH_MNT/foobar >>$seqres.full
+
+# For btrfs, trigger a transaction commit to force metadata COW for the
+# following fallocate zero range operation.
+sync
+
+$XFS_IO_PROG -c "fzero 0 100M" $SCRATCH_MNT/foobar
+
+# Check the file content after umounting and mounting again the fs, to verify
+# everything was persisted.
+_scratch_cycle_mount
+
+echo "File content after zero range operation:"
+od -A d -t x1 $SCRATCH_MNT/foobar
+
+status=0
+exit
diff --git a/tests/generic/609.out b/tests/generic/609.out
new file mode 100644
index 00000000..feb8c211
--- /dev/null
+++ b/tests/generic/609.out
@@ -0,0 +1,5 @@
+QA output created by 609
+File content after zero range operation:
+0000000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+*
+104857600
diff --git a/tests/generic/group b/tests/generic/group
index aa969bcb..f8eabc0a 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -611,3 +611,4 @@
 606 auto attr quick dax
 607 auto attr quick dax
 608 auto attr quick dax
+609 auto quick prealloc zero
-- 
2.26.2

