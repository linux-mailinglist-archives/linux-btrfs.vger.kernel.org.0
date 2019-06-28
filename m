Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE7D95A6B7
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Jun 2019 00:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfF1WJE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Jun 2019 18:09:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:32812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726563AbfF1WJD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Jun 2019 18:09:03 -0400
Received: from localhost.localdomain (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C448E2086D;
        Fri, 28 Jun 2019 22:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561759742;
        bh=5OkJLEMh5QP0Tl4EmnEkQ8aa8hg5SSu9jIV1dHBlGKY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WQtVVTZN2jYQPJM/GugSn2yrlEUDK44qSkrAcEYzOdu//1i8u5jS57zuK05eW6l38
         Vs3xBd9biLo913XLVV03hucf3+PfqAgFEd3AmxFgDfcjMwVDi1g/v9PreVe/zqClrd
         2MxpXDLgjpQ+JiUwnfu5BQ8e+HsHZqN1AMuNy6n8=
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v2] generic: test cloning large exents to a file with many small extents
Date:   Fri, 28 Jun 2019 23:08:36 +0100
Message-Id: <20190628220836.16096-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190627170030.6149-1-fdmanana@kernel.org>
References: <20190627170030.6149-1-fdmanana@kernel.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Test that if we clone a file with some large extents into a file that has
many small extents, when the fs is nearly full, the clone operation does
not fail and produces the correct result.

This is motivated by a bug found in btrfs wich is fixed by the following
patches for the linux kernel:

 [PATCH 1/2] Btrfs: factor out extent dropping code from hole punch handler
 [PATCH 2/2] Btrfs: fix ENOSPC errors, leading to transaction aborts, when
             cloning extents

The test currently passes on xfs.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---

V2: Use _scratch_cycle_mount instead of _scratch_remount, as we want to see
    if the operation was durably persisted (otherwise we are seeing content
    from the page cache).
    Use _reflink instead of calling xfs_io with the reflink command.
    Make the comment before filling the filesystem more clear about why it
    is done the way it is instead of using _fill_fs.

 tests/generic/558     | 80 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/558.out |  5 ++++
 tests/generic/group   |  1 +
 3 files changed, 86 insertions(+)
 create mode 100755 tests/generic/558
 create mode 100644 tests/generic/558.out

diff --git a/tests/generic/558 b/tests/generic/558
new file mode 100755
index 00000000..f982930d
--- /dev/null
+++ b/tests/generic/558
@@ -0,0 +1,80 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2019 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FSQA Test No. 558
+#
+# Test that if we clone a file with some large extents into a file that has
+# many small extents, when the fs is nearly full, the clone operation does
+# not fail and produces the correct result.
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
+. ./common/reflink
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+_require_scratch_reflink
+
+rm -f $seqres.full
+
+_scratch_mkfs_sized $((512 * 1024 * 1024)) >>$seqres.full 2>&1
+_scratch_mount
+
+file_size=$(( 128 * 1024 * 1024 )) # 128Mb
+extent_size=4096
+num_extents=$(( $file_size / $extent_size ))
+
+# Create a file with many small extents.
+for ((i = 0; i < $num_extents; i++)); do
+	offset=$(( $i * $extent_size ))
+	$XFS_IO_PROG -f -s -c "pwrite -S 0xe5 $offset $extent_size" \
+		$SCRATCH_MNT/foo >>/dev/null
+done
+
+# Create file bar with the same size that file foo has but with large extents.
+$XFS_IO_PROG -f -c "pwrite -S 0xc7 -b $file_size 0 $file_size" \
+	$SCRATCH_MNT/bar >>/dev/null
+
+# Fill the fs (For btrfs we are interested in filling all unallocated space
+# and most of the existing metadata block group(s), so that after this there
+# will be no unallocated space and metadata space will be mostly full but with
+# more than enough free space for the clone operation below to succeed, we
+# create files with 2Kb because that results in extents inlined in the metadata
+# (btree leafs) and it's the fastest way to fill metadata space on btrfs, by
+# default btrfs inlines up to 2Kb of data).
+i=1
+while true; do
+	$XFS_IO_PROG -f -c "pwrite 0 2K" $SCRATCH_MNT/filler_$i &> /dev/null
+	[ $? -ne 0 ] && break
+	i=$(( i + 1 ))
+done
+
+# Now clone file bar into file foo. This is supposed to succeed and not fail
+# with ENOSPC for example.
+_reflink $SCRATCH_MNT/bar $SCRATCH_MNT/foo >>$seqres.full
+
+# Unmount and mount the filesystem again to verify the operation was durably
+# persisted.
+_scratch_cycle_mount
+
+echo "File foo data after cloning and remount:"
+od -A d -t x1 $SCRATCH_MNT/foo
+
+status=0
+exit
diff --git a/tests/generic/558.out b/tests/generic/558.out
new file mode 100644
index 00000000..d1e8e70f
--- /dev/null
+++ b/tests/generic/558.out
@@ -0,0 +1,5 @@
+QA output created by 558
+File foo data after cloning and remount:
+0000000 c7 c7 c7 c7 c7 c7 c7 c7 c7 c7 c7 c7 c7 c7 c7 c7
+*
+134217728
diff --git a/tests/generic/group b/tests/generic/group
index 543c0627..c06c1cd1 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -560,3 +560,4 @@
 555 auto quick cap
 556 auto quick casefold
 557 auto quick log
+558 auto clone
-- 
2.11.0

