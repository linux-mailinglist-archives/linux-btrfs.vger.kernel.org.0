Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3217BDA68A
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Oct 2019 09:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438275AbfJQHhJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Oct 2019 03:37:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:43562 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727257AbfJQHhJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Oct 2019 03:37:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 18B1DADCC
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Oct 2019 07:37:08 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: qgroup: Automatically remove qgroup item when dropping a subvolume
Date:   Thu, 17 Oct 2019 15:36:59 +0800
Message-Id: <20191017073659.37687-1-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
When a subvolume is created, we automatically create a level 0 qgroup
for it, but don't remove it when the subvolume is dropped.

Although it's not a big deal, it can easily pollute the output of
"btrfs qgroup show" and make it pretty annoying.

[FIX]
For btrfs_drop_snapshot(), if it's a valid subvolume (not a reloc tree)
and qgroup is enabled, we do the following work to remove the qgroup:
- Commit transaction
  This is to ensure that the qgroup numbers of that subvolume is updated
  properly (all number of that subvolume should be 0).

- Start a new transaction for later operation

- Call btrfs_remove_qgroup()

So that qgroup can be automatically removed when the subvolume get fully
dropped.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent-tree.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 49cb26fa7c63..5e8569cad16d 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5182,6 +5182,7 @@ int btrfs_drop_snapshot(struct btrfs_root *root,
 	struct btrfs_root_item *root_item = &root->root_item;
 	struct walk_control *wc;
 	struct btrfs_key key;
+	u64 rootid = root->root_key.objectid;
 	int err = 0;
 	int ret;
 	int level;
@@ -5384,6 +5385,30 @@ int btrfs_drop_snapshot(struct btrfs_root *root,
 	}
 	root_dropped = true;
 out_end_trans:
+	/* If qgroup is enabled, also try to remove the qgroup */
+	if (test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags) && root_dropped &&
+	    is_fstree(rootid) && !for_reloc) {
+		/* Commit transaction so qgroup numbers get updated to all 0 */
+		ret = btrfs_commit_transaction(trans);
+		if (ret < 0) {
+			btrfs_end_transaction_throttle(trans);
+			err = ret;
+			goto out_free;
+		}
+		trans = btrfs_start_transaction(fs_info->quota_root, 1);
+		if (IS_ERR(trans)) {
+			err = PTR_ERR(trans);
+			goto out_free;
+		}
+
+		/*
+		 * Here we ignore the return value of btrfs_remove_qgroup(),
+		 * as there is no critical error could happen.
+		 * Error like EINVAL (quota disabled) or ENOENT (no such qgroup)
+		 * are all safe to ignore.
+		 */
+		btrfs_remove_qgroup(trans, rootid);
+	}
 	btrfs_end_transaction_throttle(trans);
 out_free:
 	kfree(wc);
-- 
2.23.0

