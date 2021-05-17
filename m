Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 527C538284F
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 May 2021 11:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236017AbhEQJao (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 May 2021 05:30:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:34306 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235923AbhEQJan (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 May 2021 05:30:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1621243766; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=sGLrKExocux94J1SXPj1YujnprTdO+Kbrg6FzhxjLWc=;
        b=UCwVNUPoesrNGJX7ng9Dfn+XbBM7lSlRxccRFJLwTnwQVax8Z8JdCAY1MGLwVinZc+nOTw
        +fSKQtaasDxblZuBhEHuYPjaI1P6Cbu10lI9DDKMwUPVlEGyt9iY3raKDje2CIuEQOZM+f
        Rs9rjTaAK/0/V30RmuZkG90tGc6x62g=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6AE3AAFE6;
        Mon, 17 May 2021 09:29:26 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: [PATCH] fstests: btrfs/215: avoid false alert for subpage case
Date:   Mon, 17 May 2021 17:29:22 +0800
Message-Id: <20210517092922.119788-1-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
When running btrfs/215 with 64K page size, 4K sectorsize (subpage RW
support), it fails with the following error:
btrfs/215       [failed, exit status 1]- output mismatch (see ~/xfstests-dev/results//btrfs/215.out.bad)
    --- tests/btrfs/215.out     2021-03-19 16:34:26.069634953 +0800
    +++ ~/xfstests-dev/results//btrfs/215.out.bad      2021-05-17 16:52:34.743514224 +0800
    @@ -1,2 +1,3 @@
     QA output created by 215
    -Silence is golden
    +Errors: 8 expected: 2
    +(see ~/xfstests-dev/results//btrfs/215.full for details)
    ...
    (Run 'diff -u ~/xfstests-dev/tests/btrfs/215.out ~/xfstests-dev/results//btrfs/215.out.bad'  to see the entire diff)

[CAUSE]
For subpage case, btrfs still tries to read the full page, other than
read just one sector for PAGE_SIZE == sectorsize case.

This means for the 2 sectors corrupted case, since they are in the same
page, all the errors will be reported.

[FIX]
Change the following values:
- filesize
  Now it's 8 * pagesize.

- expected error number
  Now it's 2 * sectors_per_page or 6 * sectors_per_page.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Note: The btrfs subpage full data RW support is not yet merged into upstream,
but most of its preparation patches are already merged, and it can
already pass most fstests.

The out-of-tree branch can be fetched from my git repo:
https://github.com/adam900710/linux/tree/subpage

Some failures are just false alerts, like btrfs/215 which always
believes sectorsize == PAGE_SIZE for btrfs, thus it's worthy fixing before
bothering testers when the RW support get merged.
---
 tests/btrfs/215 | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/tests/btrfs/215 b/tests/btrfs/215
index 748287e7..c4959061 100755
--- a/tests/btrfs/215
+++ b/tests/btrfs/215
@@ -46,8 +46,21 @@ _scratch_mkfs > /dev/null
 # blobk group
 _scratch_mount -o nospace_cache
 
+pagesize=$(get_page_size)
 blocksize=$(_get_block_size $SCRATCH_MNT)
-filesize=$((8*$blocksize))
+
+# For subpage case, since we still do read in full page size, if have 8 corrupted
+# sectors in one page, then even we just try to read one sector of that page,
+# all 8 corruption will be reported.
+# So here we chose the filesize using page size.
+filesize=$((8*$pagesize))
+if [ $blocksize -le $pagesize ]; then
+	sectors_per_page=$(($pagesize / $blocksize))
+else
+	# We don't support multi-page sectorsize yet
+	_notrun "this test doesn't support sectorsize $blocksize with page size $pagesize yet"
+fi
+
 uuid=$(findmnt -n -o UUID "$SCRATCH_MNT")
 
 if [ ! -e /sys/fs/btrfs/$uuid/bdi ]; then
@@ -64,24 +77,24 @@ echo "logical = $logical_extent physical=$physical_extent" >> $seqres.full
 
 # corrupt first 4 blocks of file
 _scratch_unmount
-$XFS_IO_PROG -d -c "pwrite -S 0xaa -b $blocksize $physical_extent $((4*$blocksize))" $SCRATCH_DEV > /dev/null
+$XFS_IO_PROG -d -c "pwrite -S 0xaa -b $pagesize $physical_extent $((4 * $pagesize))" $SCRATCH_DEV > /dev/null
 _scratch_mount
 
 # disable readahead to avoid skewing the counter
 echo 0 > /sys/fs/btrfs/$uuid/bdi/read_ahead_kb
 
-# buffered reads whould result in 2 errors since readahead code always submits
-# at least 1 page worth of IO and it will be counted as an error as well
+# buffered reads whould result in 2 * sectors_per_page errors since readahead code always submits
+# at least 1 page worth of IO and it will be counted as error(s) as well
 $XFS_IO_PROG -c "pread -b $filesize 0 $filesize" "$SCRATCH_MNT/foobar" > /dev/null 2>&1
 errs=$($BTRFS_UTIL_PROG device stats $SCRATCH_DEV | awk '/corruption_errs/ { print $2 }')
-if [ $errs -ne 2 ]; then
+if [ $errs -ne $((2 * $sectors_per_page)) ]; then
 	_fail "Errors: $errs expected: 2"
 fi
 
 # DIO does check every sector
 $XFS_IO_PROG -d -c "pread -b $filesize 0 $filesize" "$SCRATCH_MNT/foobar" > /dev/null 2>&1
 errs=$($BTRFS_UTIL_PROG device stats $SCRATCH_DEV | awk '/corruption_errs/ { print $2 }')
-if [ $errs -ne 6 ]; then
+if [ $errs -ne $((6 * $sectors_per_page)) ]; then
 	_fail "Errors: $errs expected: 6"
 fi
 
-- 
2.31.1

