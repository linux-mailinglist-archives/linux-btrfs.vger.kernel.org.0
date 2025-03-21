Return-Path: <linux-btrfs+bounces-12482-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7473A6B994
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Mar 2025 12:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4514318967D7
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Mar 2025 11:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9151522173E;
	Fri, 21 Mar 2025 11:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FrT/QsPB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07B41F17EB;
	Fri, 21 Mar 2025 11:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742555403; cv=none; b=e4YD8/lMDLqI6l8D+PU1FN7kYiw6N4753cyAGhU6oLm0iHE36DmIJvWKZLEb1ZH5pq8oxrA2q6pYeul2Bbv2YUrTgEiu7qAHiMfsTWzO+g6G3rLNtq2HemjEYyVgPWZTMMoPHIXWDi8xjq6ECtnXXqxhp3WskmCVajBDz+wDsKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742555403; c=relaxed/simple;
	bh=6k6lsCNecjGpeis8m8LNOHmXmgFXIFNQu8X5IgTE9qA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lD3bhzv+46iWD3eH/4lFSytS2k0CI1Nc+1sb+8DeGGKyVz/dV3Xyg/rtnpHaW9mq8eAzrr+NJv0yma/cowqHQa1rvBizI0xSWRPFdrCc8qxYU0AuPbYUYIK7TXj5lCU1dcGcBrAEqZtQoPiM0KVPJYbNFeSagYlPBYE+2tdmEkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FrT/QsPB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8805C4CEE3;
	Fri, 21 Mar 2025 11:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742555403;
	bh=6k6lsCNecjGpeis8m8LNOHmXmgFXIFNQu8X5IgTE9qA=;
	h=From:To:Cc:Subject:Date:From;
	b=FrT/QsPBydfeqs9AZaGzpX5v2326xHqMEt0EH4EuSA9LvEI3T8ASMxOaJhERVzcse
	 deXXvWnEAlQuEDclovY3vFuzLx3Onp0479/hy9zOlehGBqX3JmSJzqyNDsdEV50lta
	 6vynsK4Eh6YMLEMybgSHHF0XTuaFpesBuZG+DqX78eQBUm4y3QWtCUicBFB7sz/4SN
	 gHrx1dROIhOEILVZfy9nKoNbL4sKCkB3XrJISCvJvpXX/oV1r6nNSvm7wHwOSstklG
	 TAH6OufCenEcHpsj/C69fEU0HmsmZZTXEKx5WYEWwyMKnOlH+dK1bFj+xkqZIn39SF
	 GBLx/BGX8e93Q==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] generic: test fsync of file with no more hard links
Date: Fri, 21 Mar 2025 11:09:58 +0000
Message-ID: <3476019b76d6df3ce6eb364aeb1a2725b8fb4846.1742555101.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Test that if we fsync a file that has no more hard links, power fail and
then mount the filesystem, after the journal/log is replayed, the file
doesn't exists anymore.

This exercises a bug recently found and fixed by the following patch for
the linux kernel:

   btrfs: fix fsync of files with no hard links not persisting deletion

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/generic/764     | 78 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/764.out |  2 ++
 2 files changed, 80 insertions(+)
 create mode 100755 tests/generic/764
 create mode 100644 tests/generic/764.out

diff --git a/tests/generic/764 b/tests/generic/764
new file mode 100755
index 00000000..57d21095
--- /dev/null
+++ b/tests/generic/764
@@ -0,0 +1,78 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 SUSE Linux Products GmbH.  All Rights Reserved.
+#
+# FS QA Test 764
+#
+# Test that if we fsync a file that has no more hard links, power fail and then
+# mount the filesystem, after the journal/log is replayed, the file doesn't
+# exists anymore.
+#
+. ./common/preamble
+_begin_fstest auto quick log
+
+_cleanup()
+{
+	if [ ! -z $XFS_IO_PID ]; then
+		kill $XFS_IO_PID > /dev/null 2>&1
+		wait $XFS_IO_PID > /dev/null 2>&1
+	fi
+	_cleanup_flakey
+	cd /
+	rm -r -f $tmp.*
+}
+
+. ./common/dmflakey
+
+[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit xxxxxxxxxxxx \
+	"btrfs: fix fsync of files with no hard links not persisting deletion"
+
+_require_scratch
+_require_dm_target flakey
+_require_mknod
+
+_scratch_mkfs >>$seqres.full 2>&1 || _fail "mkfs failed"
+_require_metadata_journaling $SCRATCH_DEV
+_init_flakey
+_mount_flakey
+
+touch $SCRATCH_MNT/foo
+
+# Commit the current transaction and persist the file.
+_scratch_sync
+
+# A fifo to communicate with a background xfs_io process that will fsync the
+# file after we deleted its hard link while it's open by xfs_io.
+mkfifo $SCRATCH_MNT/fifo
+
+tail -f $SCRATCH_MNT/fifo | $XFS_IO_PROG $SCRATCH_MNT/foo >>$seqres.full &
+XFS_IO_PID=$!
+
+# Give some time for the xfs_io process to open a file descriptor for the file.
+sleep 1
+
+# Now while the file is open by the xfs_io process, delete its only hard link.
+rm -f $SCRATCH_MNT/foo
+
+# Now that it has no more hard links, make the xfs_io process fsync it.
+echo "fsync" > $SCRATCH_MNT/fifo
+
+# Terminate the xfs_io process so that we can unmount.
+echo "quit" > $SCRATCH_MNT/fifo
+wait $XFS_IO_PID
+unset XFS_IO_PID
+
+# Simulate a power failure and then mount again the filesystem to replay the
+# journal/log.
+_flakey_drop_and_remount
+
+# We don't expect the file to exist anymore, since it was fsynced when it had no
+# more hard links.
+[ -f $SCRATCH_MNT/foo ] && echo "file foo still exists"
+
+_unmount_flakey
+
+# success, all done
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/generic/764.out b/tests/generic/764.out
new file mode 100644
index 00000000..bb58e5b8
--- /dev/null
+++ b/tests/generic/764.out
@@ -0,0 +1,2 @@
+QA output created by 764
+Silence is golden
-- 
2.45.2


