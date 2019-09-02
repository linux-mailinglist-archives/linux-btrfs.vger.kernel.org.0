Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3D8A51CF
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Sep 2019 10:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730221AbfIBIe0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Sep 2019 04:34:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:60612 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729722AbfIBIe0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 2 Sep 2019 04:34:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E7610AF0D;
        Mon,  2 Sep 2019 08:34:24 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, guaneryu@gmail.com,
        Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] generic/25[02]: Increase fs size to 196 mb
Date:   Mon,  2 Sep 2019 11:34:18 +0300
Message-Id: <20190902083418.23741-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Those 2 tests fail on btrfs on a ppc64 system with 64k pages. This is
caused by the improved minimum device size calculation in upstream
btrfs-progs (commit: 31d228a2eb98 ("btrfs-progs: mkfs: Enhance minimal
device size calculation to fix mkfs failure on small file")).i

Xfstests implicitly uses '--mixed' options for filesystems smaller than
256mb thus the minimum filesystem size require is derived from the
following equation: 2 * (4mb + nodesize << 10). On a 64k page system
this evaluates to 2 * (4m + 64m) = 136m. This resuts in failures such:
mkfs.btrfs  -b $((100 * 1048576)) btrfs-test.img

    ERROR: size 104857600 is too small to make a usable filesystem
    ERROR: minimum size for btrfs filesystem is 114294784

when running _scratch_mkfs_sized $((100 * 1048576)).

Fix this by increasing the minimum filesystem size to 196 megabytes
which makes mkfs.btrfs happy again and allows the test to proceed.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 tests/generic/250 | 2 +-
 tests/generic/252 | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/generic/250 b/tests/generic/250
index 74854c155799..8ec65d4ca39e 100755
--- a/tests/generic/250
+++ b/tests/generic/250
@@ -40,7 +40,7 @@ _require_no_rtinherit
 
 rm -f $seqres.full
 
-fssize=$((100 * 1048576))
+fssize=$((196 * 1048576))
 echo "Format and mount"
 $XFS_IO_PROG -d -c "pwrite -S 0x69 -b 1048576 0 $fssize" $SCRATCH_DEV >> $seqres.full
 _scratch_mkfs_sized $fssize > $seqres.full 2>&1
diff --git a/tests/generic/252 b/tests/generic/252
index 991bbe3e0645..2e86c81936af 100755
--- a/tests/generic/252
+++ b/tests/generic/252
@@ -42,7 +42,7 @@ AIO_TEST="src/aio-dio-regress/aiocp"
 rm -f $seqres.full
 
 
-fssize=$((100 * 1048576))
+fssize=$((196 * 1048576))
 echo "Format and mount"
 $XFS_IO_PROG -d -c "pwrite -S 0x69 -b 1048576 0 $fssize" $SCRATCH_DEV >> $seqres.full
 _scratch_mkfs_sized $fssize > $seqres.full 2>&1
-- 
2.7.4

