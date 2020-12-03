Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 036D52CD53E
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 13:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388034AbgLCMM2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 07:12:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:38302 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387902AbgLCMM1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 3 Dec 2020 07:12:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1606997500; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=KijhJFnaJxlywHD7iGARW5yW57oVj1YmtlgcIagDiGE=;
        b=LjbVSH7IxPJdIGCrfQsDhz6wgts5qJdF/qmRSJO+QR+zF9kCI6NJqahqqI6UM9zdF8q17k
        FmKCSsMR/iSmuo9ScSfU3I/JY6smFWAljDX1ZGwgYr98CsTAaJx030cldmgiIn1zS7ddOj
        OJnHhdKSw/9eD1V4GYy0coZAs1PIt2g=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A4A66AC6A;
        Thu,  3 Dec 2020 12:11:40 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs: Update btrfs/215
Date:   Thu,  3 Dec 2020 14:11:39 +0200
Message-Id: <20201203121139.754305-1-nborisov@suse.com>
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
 tests/btrfs/215 | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tests/btrfs/215 b/tests/btrfs/215
index 4acc288a9f60..2647fa41ef86 100755
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
@@ -74,15 +74,15 @@ echo 0 > /sys/fs/btrfs/$uuid/bdi/read_ahead_kb
 # page by page
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

