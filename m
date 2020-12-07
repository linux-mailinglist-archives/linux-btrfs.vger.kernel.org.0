Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 096F62D0CF4
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Dec 2020 10:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725822AbgLGJYH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Dec 2020 04:24:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:59334 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725550AbgLGJYG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 7 Dec 2020 04:24:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1607332999; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=EnGQN8Iyp0xc43NKGY1+51ALiduJ+Muvt0s6vL1u/u8=;
        b=C2yq3lfOy40KSNoTXHEA/yqAXMzk00KErDtjMUHVKbJiOzoIoUdkqQmMybFioipFJK4Mhw
        pIpXMnx/1gfG1cWWxpkVLTSwtS6PmCxKKRF3uMJsLfyfq9xuddvkTKNhOuoQJXlNMn0EuG
        WmST/PtTsdU+wApOK5sAVkQfypVcLjc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B9985AD79;
        Mon,  7 Dec 2020 09:23:19 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2] btrfs: Update btrfs/215
Date:   Mon,  7 Dec 2020 11:23:18 +0200
Message-Id: <20201207092318.950548-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch updates btrfs/215 to work with latest upstream kernel. That's
required since commit 324bcf54c449 ("mm: use limited read-ahead to satisfy read")
changed readahead logic to always issue a read even if the RA pages are
set to 0. This results in 1 extra io being issued so the counts in the
test should be incremented by 1. Also use the opportunity to update the
commit reference since it's been merged in the upstream kernel.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
V2:
 * Updated comment above buffered read issue command to better describe why 2
 failures are expected.

 tests/btrfs/215 | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tests/btrfs/215 b/tests/btrfs/215
index 4acc288a9f60..748287e74cdf 100755
--- a/tests/btrfs/215
+++ b/tests/btrfs/215
@@ -6,7 +6,7 @@
 #
 # Test that reading corrupted files would correctly increment device status
 # counters. This is fixed by the following linux kernel commit:
-# btrfs: Increment device corruption error in case of checksum error
+# 814723e0a55a ("btrfs: increment device corruption error in case of checksum error")
 #
 seq=`basename $0`
 seqres=$RESULT_DIR/$seq
@@ -70,19 +70,19 @@ _scratch_mount
 # disable readahead to avoid skewing the counter
 echo 0 > /sys/fs/btrfs/$uuid/bdi/read_ahead_kb

-# buffered reads whould result in a single error since the read is done
-# page by page
+# buffered reads whould result in 2 errors since readahead code always submits
+# at least 1 page worth of IO and it will be counted as an error as well
 $XFS_IO_PROG -c "pread -b $filesize 0 $filesize" "$SCRATCH_MNT/foobar" > /dev/null 2>&1
 errs=$($BTRFS_UTIL_PROG device stats $SCRATCH_DEV | awk '/corruption_errs/ { print $2 }')
-if [ $errs -ne 1 ]; then
-	_fail "Errors: $errs expected: 1"
+if [ $errs -ne 2 ]; then
+	_fail "Errors: $errs expected: 2"
 fi

 # DIO does check every sector
 $XFS_IO_PROG -d -c "pread -b $filesize 0 $filesize" "$SCRATCH_MNT/foobar" > /dev/null 2>&1
 errs=$($BTRFS_UTIL_PROG device stats $SCRATCH_DEV | awk '/corruption_errs/ { print $2 }')
-if [ $errs -ne 5 ]; then
-	_fail "Errors: $errs expected: 1"
+if [ $errs -ne 6 ]; then
+	_fail "Errors: $errs expected: 6"
 fi

 # success, all done
--
2.17.1

