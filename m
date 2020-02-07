Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5D5155048
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Feb 2020 03:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgBGB74 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Feb 2020 20:59:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:35074 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727600AbgBGB74 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 6 Feb 2020 20:59:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 04690AEA2;
        Fri,  7 Feb 2020 01:59:53 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 2/3] fstests: btrfs/022: Match qgroup id more correctly
Date:   Fri,  7 Feb 2020 09:59:41 +0800
Message-Id: <20200207015942.9079-3-wqu@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200207015942.9079-1-wqu@suse.com>
References: <20200207015942.9079-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
Btrfs/022 sometimes fails with snapshot's reference mismatch with its
source.

[CAUSE]
Since commit fd0830929573 ("fsstress: add the ability to create
snapshots") adds the ability for fsstress to create/delete snapshot and
subvolumes, fsstress will create new subvolumes under test dir.

For example, we could have the following subvolumes created by fsstress:
subvol a id=256
subvol b id=306
qgroupid         rfer         excl
--------         ----         ----
0/5             16384        16384
0/256        13914112        16384
...
0/263         3080192      2306048 		<< 2 *306* 048
...
0/306        13914112        16384 		<< 0/ *306

So when we're greping for subvolid 306, it matches qgroup 0/263 first,
which has difference size, and caused false alert.

[FIX]
Instead of greping "$subvolid" blindly, now grep "0/$subvolid" to catch
qgroupid correctly, without hitting rfer/excl values.

Suggested-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/022 | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/btrfs/022 b/tests/btrfs/022
index 5348d3ed..3e729852 100755
--- a/tests/btrfs/022
+++ b/tests/btrfs/022
@@ -49,10 +49,10 @@ _basic_test()
 
 	# the shared values of both the original subvol and snapshot should
 	# match
-	a_shared=$($BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | grep $subvolid)
+	a_shared=$($BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | grep "0/$subvolid")
 	a_shared=$(echo $a_shared | awk '{ print $2 }')
 	subvolid=$(_btrfs_get_subvolid $SCRATCH_MNT b)
-	b_shared=$($BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | grep $subvolid)
+	b_shared=$($BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | grep "0/$subvolid")
 	b_shared=$(echo $b_shared | awk '{ print $2 }')
 	[ $b_shared -eq $a_shared ] || _fail "shared values don't match"
 }
@@ -68,12 +68,12 @@ _rescan_test()
 	run_check $FSSTRESS_PROG -d $SCRATCH_MNT/a -w -p 1 -n 2000 \
 		$FSSTRESS_AVOID
 	sync
-	output=$($BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | grep $subvolid)
+	output=$($BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | grep "0/$subvolid")
 	echo $output >> $seqres.full
 	refer=$(echo $output | awk '{ print $2 }')
 	excl=$(echo $output | awk '{ print $3 }')
 	_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
-	output=$($BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | grep $subvolid)
+	output=$($BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | grep "0/$subvolid")
 	echo $output >> $seqres.full
 	[ $refer -eq $(echo $output | awk '{ print $2 }') ] || \
 		_fail "reference values don't match after rescan"
-- 
2.23.0

