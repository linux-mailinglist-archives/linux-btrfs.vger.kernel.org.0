Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F386CF6F39
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2019 08:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfKKHvG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Nov 2019 02:51:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:38704 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726360AbfKKHvG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Nov 2019 02:51:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AAE73B184;
        Mon, 11 Nov 2019 07:51:04 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Christian Pernegger <pernegger@gmail.com>
Subject: [PATCH 2/2] btrfs: rescue/zero-log: Manually write all supers to handle extent tree error more gracefully
Date:   Mon, 11 Nov 2019 15:50:59 +0800
Message-Id: <20191111075059.30352-2-wqu@suse.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191111075059.30352-1-wqu@suse.com>
References: <20191111075059.30352-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
Even "btrfs rescue zero-log" only reset btrfs_super_block::log_root and
btrfs_super_block::log_root_level, we still use trasction to write all
super blocks for all devices.

This means we can't handle things like corrupted extent tree:

  checksum verify failed on 2172747776 found 000000B6 wanted 00000000
  checksum verify failed on 2172747776 found 000000B6 wanted 00000000
  bad tree block 2172747776, bytenr mismatch, want=2172747776, have=0
  WARNING: could not setup extent tree, skipping it
  Clearing log on /dev/nvme/btrfs, previous log_root 0, level 0
  ERROR: Corrupted fs, no valid METADATA block group found
  ERROR: attempt to start transaction over already running one

[CAUSE]
Because we have extra check in transaction code to ensure we have valid
METADATA block groups.

In fact we don't really need transaction at all.

[FIX]
Instead of commit transaction, we can just call write_all_supers()
manually, so we can still handle multi-device fs while avoid above
error.

Also, add OPEN_CTREE_NO_BLOCK_GROUPS open ctree flag to make it more
robust.

Reported-by: Christian Pernegger <pernegger@gmail.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 cmds/rescue.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/cmds/rescue.c b/cmds/rescue.c
index e8eab6808bc3..087c33befeff 100644
--- a/cmds/rescue.c
+++ b/cmds/rescue.c
@@ -165,7 +165,6 @@ static int cmd_rescue_zero_log(const struct cmd_struct *cmd,
 			       int argc, char **argv)
 {
 	struct btrfs_root *root;
-	struct btrfs_trans_handle *trans;
 	struct btrfs_super_block *sb;
 	char *devname;
 	int ret;
@@ -187,7 +186,8 @@ static int cmd_rescue_zero_log(const struct cmd_struct *cmd,
 		goto out;
 	}
 
-	root = open_ctree(devname, 0, OPEN_CTREE_WRITES | OPEN_CTREE_PARTIAL);
+	root = open_ctree(devname, 0, OPEN_CTREE_WRITES | OPEN_CTREE_PARTIAL |
+			  OPEN_CTREE_NO_BLOCK_GROUPS);
 	if (!root) {
 		error("could not open ctree");
 		return 1;
@@ -198,13 +198,14 @@ static int cmd_rescue_zero_log(const struct cmd_struct *cmd,
 			devname,
 			(unsigned long long)btrfs_super_log_root(sb),
 			(unsigned)btrfs_super_log_root_level(sb));
-	trans = btrfs_start_transaction(root, 1);
-	BUG_ON(IS_ERR(trans));
 	btrfs_set_super_log_root(sb, 0);
 	btrfs_set_super_log_root_level(sb, 0);
-	btrfs_commit_transaction(trans, root);
+	ret = write_all_supers(root->fs_info);
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to write dev supers: %m");
+	}
 	close_ctree(root);
-
 out:
 	return !!ret;
 }
-- 
2.24.0

