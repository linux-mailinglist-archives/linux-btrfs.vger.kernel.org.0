Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA2443E48B
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Oct 2021 17:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbhJ1PHY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Oct 2021 11:07:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:33548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230406AbhJ1PHX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Oct 2021 11:07:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D301F60C51;
        Thu, 28 Oct 2021 15:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635433496;
        bh=xgRQHkU1FZq417TPUbX+pNTNoWsYhTW44LhIhUfRsZE=;
        h=From:To:Cc:Subject:Date:From;
        b=frWgzlm0PIHcL+kqPsPibDXLbHbVCnM0kzJvhDyQRPupCa8sBGSJgyPffcoeADHkt
         RyD/pTrQUp67BFAstyNWuGkNLZuvp1PMqiB19LB2afkOs9eMFfx/vCO7A+DzYaiwey
         zx81/nPZP4F4StY931EyQ4vYbNRGr+1Cp52Mhc8oXPbMlo7YiwORKZ+FHWqaaCRANZ
         1PUapGfwuIUzb2mH7doAJKwzcHae+KW8mKhjSRMJybEnZon4UpXeaHS9NxugKRttkl
         l9Hz7NBeyMnGtOOkboaa/aKdnGHXu8Xcoov1XEd79At/qDDRY41bOoDt2W+165y3d+
         aVcDg2VbNgYIQ==
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs: test direct IO write on NOCOW file when low on unallocated space
Date:   Thu, 28 Oct 2021 16:04:33 +0100
Message-Id: <c55a58aaab2ad3192166d334b7d72638b642713b.1635432856.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Test that if we write to a range of a NOCOW file that has allocated
extents and there is not enough available free space for allocating new
data extents, the write succeeds. Test for direct IO and buffered IO
writes.

This currently fails on btrfs for the direct IO write scenario, only, but
while at it also test a buffered IO write, to help prevent regressions in
the future.

The patch that fixes the direct IO case has the following subject:

 "btrfs: fix ENOSPC failure when attempting direct IO write into NOCOW range"

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/250     | 73 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/250.out | 18 +++++++++++
 2 files changed, 91 insertions(+)
 create mode 100755 tests/btrfs/250
 create mode 100644 tests/btrfs/250.out

diff --git a/tests/btrfs/250 b/tests/btrfs/250
new file mode 100755
index 00000000..fdfbafad
--- /dev/null
+++ b/tests/btrfs/250
@@ -0,0 +1,73 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2021 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test No. 250
+#
+# Test that if we write to a range of a NOCOW file that has allocated extents
+# and there is not enough available free space for allocating new data extents,
+# the write succeeds. Test for direct IO and buffered IO writes.
+#
+. ./common/preamble
+_begin_fstest auto quick enospc
+
+_cleanup()
+{
+	cd /
+	rm -r -f $tmp.*
+}
+
+# Import common functions.
+. ./common/filter
+
+# real QA test starts here
+
+_supported_fs btrfs
+_require_scratch
+_require_chattr C
+_require_odirect
+
+# Use a small fixed size filesystem so that it's quick to fill it up.
+# Make sure the fs size is > 256M, so that the mixed block groups feature is
+# not enabled by _scatch_mkfs_sized(), because we later want to not have more
+# space available for allocating data extents but still have enough metadata
+# space free for the file writes.
+fs_size=$((1024 * 1024 * 1024)) # 1G
+_scratch_mkfs_sized $fs_size >>$seqres.full 2>&1
+_scratch_mount
+
+# Create our test file with the NOCOW attribute set.
+touch $SCRATCH_MNT/foobar
+$CHATTR_PROG +C $SCRATCH_MNT/foobar
+
+# Now fill in all unallocated space with data for our test file.
+# This will allocate a data block group that will be full and leave no (or a
+# very small amount of) unallocated space in the device, so that it will not be
+# possible to allocate a new block group later.
+echo "Creating test file with initial data..."
+$XFS_IO_PROG -c "pwrite -S 0xab -b 1M 0 900M" $SCRATCH_MNT/foobar | _filter_xfs_io
+
+# Now try a direct IO write against file range [0, 10M[.
+# This should succeed since this is a NOCOW file and an extent for the range was
+# previously allocated.
+echo "Trying direct IO write over allocated space..."
+$XFS_IO_PROG -d -c "pwrite -S 0xcd -b 10M 0 10M" $SCRATCH_MNT/foobar | _filter_xfs_io
+
+# Now try a buffered IO write against file range [10M, 20M[.
+# This should also succeed since this is a NOCOW file and an extent for the range
+# was previously allocated.
+echo "Trying buffered IO write over allocated space..."
+$XFS_IO_PROG -c "pwrite -S 0xef -b 10M 10M 10M" $SCRATCH_MNT/foobar | _filter_xfs_io
+
+# Unmount and mount again the filesystem to clear any data from our file from the
+# page cache.
+_scratch_cycle_mount
+
+# Now read the file and verify that all the writes we did before were durably
+# persisted.
+echo "File data after mounting again the filesystem:"
+od -A d -t x1 $SCRATCH_MNT/foobar
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/250.out b/tests/btrfs/250.out
new file mode 100644
index 00000000..3912b70b
--- /dev/null
+++ b/tests/btrfs/250.out
@@ -0,0 +1,18 @@
+QA output created by 250
+Creating test file with initial data...
+wrote 943718400/943718400 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Trying direct IO write over allocated space...
+wrote 10485760/10485760 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Trying buffered IO write over allocated space...
+wrote 10485760/10485760 bytes at offset 10485760
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+File data after mounting again the filesystem:
+0000000 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd
+*
+10485760 ef ef ef ef ef ef ef ef ef ef ef ef ef ef ef ef
+*
+20971520 ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab
+*
+943718400
-- 
2.33.0

