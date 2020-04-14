Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 985821A8495
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Apr 2020 18:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391415AbgDNQXb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Apr 2020 12:23:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:33332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391397AbgDNQWh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Apr 2020 12:22:37 -0400
Received: from debian7.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 812682076B;
        Tue, 14 Apr 2020 16:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586881356;
        bh=Jrxe5Ju5EM6611mYFGycw0G1t6aEjxxaaAUNSk9UV/c=;
        h=From:To:Cc:Subject:Date:From;
        b=EuQoDj2DD0aVFHVwqJlabkdHr4rtJlEl7YP7GrSxWItIlhr2AFSiens6HA2xRGA6m
         RVX231ZVTjhU7T8RW5p67qoAUfUmi91NEHCzKhBwC4oaKXnvSG+eXLCvXzbPu1nMuH
         TJa9NtOQsA96DKIDMj/HY3xgr2qL1b7+3EQhRNcg=
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 2/3] fstests: stop using run_check in _run_btrfs_balance_start
Date:   Tue, 14 Apr 2020 17:22:32 +0100
Message-Id: <20200414162232.24407-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The use of run_check() immediately stops a test because it calls the
_fail() function when execution of its argument fails. This is generally
not encouraged in fstests as it prevents a test from detecting further
problems after that failure. Since the next patch in this series updates
other tests to use _run_btrfs_balance_start() for which a failure to
run balance can be expected (btrfs/187 for example), remove the use of
run_check() from _run_btrfs_balance_start(). Existing tests that use
_run_btrfs_balance_start() now redirect standard output to the test's
.full file for debugging purposes. In case balance fails the tests will
fail due to unexpected output from the standard error.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 common/btrfs    | 2 +-
 tests/btrfs/124 | 2 +-
 tests/btrfs/177 | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/common/btrfs b/common/btrfs
index 7971c046..b43932df 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -382,7 +382,7 @@ _run_btrfs_balance_start()
 	$BTRFS_UTIL_PROG balance start --help | grep -q "full-balance"
 	(( $? == 0 )) && bal_opt="--full-balance"
 
-	run_check $BTRFS_UTIL_PROG balance start $bal_opt $*
+	$BTRFS_UTIL_PROG balance start $bal_opt $*
 }
 
 #return the sector size of the btrfs scratch fs
diff --git a/tests/btrfs/124 b/tests/btrfs/124
index 0686a3b5..0600ae50 100755
--- a/tests/btrfs/124
+++ b/tests/btrfs/124
@@ -114,7 +114,7 @@ _run_btrfs_util_prog device scan
 _scratch_mount >> $seqres.full 2>&1
 _run_btrfs_util_prog filesystem show
 echo >> $seqres.full
-_run_btrfs_balance_start ${SCRATCH_MNT}
+_run_btrfs_balance_start ${SCRATCH_MNT} >>$seqres.full
 
 checkpoint2=`md5sum $SCRATCH_MNT/tf2`
 echo $checkpoint2 >> $seqres.full 2>&1
diff --git a/tests/btrfs/177 b/tests/btrfs/177
index 69b9a539..ec715c21 100755
--- a/tests/btrfs/177
+++ b/tests/btrfs/177
@@ -44,7 +44,7 @@ _scratch_mount
 # Create a small file and run balance so we shall deal with the chunk
 # size as allocated by the kernel, mkfs allocated chunks are smaller.
 dd if=/dev/zero of="$SCRATCH_MNT/fill" bs=4096 count=1 >> $seqres.full 2>&1
-_run_btrfs_balance_start "$SCRATCH_MNT"
+_run_btrfs_balance_start "$SCRATCH_MNT" >>$seqres.full
 
 # Now fill it up.
 dd if=/dev/zero of="$SCRATCH_MNT/refill" bs=4096 >> $seqres.full 2>&1
@@ -63,7 +63,7 @@ rm -f "$SCRATCH_MNT/refill"
 
 # Get rid of empty block groups and also make sure that balance skips block
 # groups containing active swap files.
-_run_btrfs_balance_start "$SCRATCH_MNT"
+_run_btrfs_balance_start "$SCRATCH_MNT" >>$seqres.full
 
 # Try to shrink away the area occupied by the swap file, which should fail.
 $BTRFS_UTIL_PROG filesystem resize 1G "$SCRATCH_MNT" 2>&1 | grep -o "Text file busy"
-- 
2.11.0

