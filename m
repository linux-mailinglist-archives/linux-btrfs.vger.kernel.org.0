Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0527714C65F
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2020 07:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbgA2GKo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jan 2020 01:10:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:50612 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbgA2GKo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jan 2020 01:10:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 94EDBAF9F;
        Wed, 29 Jan 2020 06:10:42 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: [PATCH] fstests: btrfs/182: Update the comment for the fix
Date:   Wed, 29 Jan 2020 14:10:36 +0800
Message-Id: <20200129061036.49327-1-wqu@suse.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The mentioned fix in btrfs-progs is just a dirty fix, and only works for
the test case, not a generic fix.

The proper kernel fix is submitted by Josef, and it's on the good track to be
merged upstream.
So update the comment to make it less confusing.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/182 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/btrfs/182 b/tests/btrfs/182
index 19b4ad8163e4..a9fbbd9b2f0d 100755
--- a/tests/btrfs/182
+++ b/tests/btrfs/182
@@ -9,8 +9,8 @@
 # This is a long existing bug, caused by over-estimated metadata
 # space_info::bytes_may_use.
 #
-# There is one proposed patch for btrfs-progs to fix it, titled:
-# "btrfs-progs: balance: Sync the fs before balancing metadata chunks"
+# The fix is submitted with title:
+# "btrfs: use btrfs_can_overcommit in inc_block_group_ro"
 #
 seq=`basename $0`
 seqres=$RESULT_DIR/$seq
-- 
2.25.0

