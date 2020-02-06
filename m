Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE1E153E49
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Feb 2020 06:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbgBFFcn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Feb 2020 00:32:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:51586 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbgBFFcn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 6 Feb 2020 00:32:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B12C4ACD0;
        Thu,  6 Feb 2020 05:32:41 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: [PATCH] fstests: btrfs/022: Disable snapshot ioctl in fsstress
Date:   Thu,  6 Feb 2020 13:32:26 +0800
Message-Id: <20200206053226.23624-1-wqu@suse.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since commit fd0830929573 ("fsstress: add the ability to create
snapshots") adds the ability for fsstress to create/delete snapshot and
subvolume, test case btrfs/022 fails as _btrfs_get_subvolid can't
handle multiple subvolumes under the same path.

So manually disable snapshot/subvolume creation and deletion ioctl in this
test case. Other qgroup test cases aren't affected.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/022 | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/btrfs/022 b/tests/btrfs/022
index 5348d3ed..d0ae6b01 100755
--- a/tests/btrfs/022
+++ b/tests/btrfs/022
@@ -43,6 +43,7 @@ _basic_test()
 		$seqres.full 2>&1
 	[ $? -eq 0 ] || _fail "couldn't find our subvols quota group"
 	run_check $FSSTRESS_PROG -d $SCRATCH_MNT/a -w -p 1 -n 2000 \
+		-f snapshot=0 -f subvol_create=0 -f subvol_delete=0 \
 		$FSSTRESS_AVOID
 	_run_btrfs_util_prog subvolume snapshot $SCRATCH_MNT/a \
 		$SCRATCH_MNT/b
@@ -66,6 +67,7 @@ _rescan_test()
 	_run_btrfs_util_prog quota enable $SCRATCH_MNT/a
 	subvolid=$(_btrfs_get_subvolid $SCRATCH_MNT a)
 	run_check $FSSTRESS_PROG -d $SCRATCH_MNT/a -w -p 1 -n 2000 \
+		-f snapshot=0 -f subvol_create=0 -f subvol_delete=0 \
 		$FSSTRESS_AVOID
 	sync
 	output=$($BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | grep $subvolid)
-- 
2.23.0

