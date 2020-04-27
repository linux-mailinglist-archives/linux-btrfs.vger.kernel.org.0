Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77F951B97D1
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Apr 2020 08:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgD0G6U (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Apr 2020 02:58:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:36708 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726539AbgD0G6U (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Apr 2020 02:58:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C3AC7ABD7
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Apr 2020 06:58:17 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC] btrfs: relocation: Exit balance explicitly if there is no more extents to relocate
Date:   Mon, 27 Apr 2020 14:58:14 +0800
Message-Id: <20200427065814.46952-1-wqu@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There are several reported runaway balance, some of them are even unable
to be canceled with latest kernel.

Current balance only exit if rc::found_extents is 0, but there is a more
obvious condition to terminate relocation: is there any new extents to
relocate.

This patch will make balance to check such condition, as an final safe
net to catch the runaway balance.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
This is definitely not the right solution, as we should find the root
cause, e.g. where we missed a rc->found_extents--;, but this would provide
a quick test to determine if it's rc::found_extents get un-synced from the
real situation.

And an extra safenet is never a bad thing.
---

 fs/btrfs/relocation.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 03bc7134e8cb..fb59eda27930 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3978,6 +3978,14 @@ int prepare_to_relocate(struct reloc_control *rc)
 	return 0;
 }
 
+/*
+ * Return 0 if current balance stage is finished without problem.
+ * For MOVE_DATA_EXTENTS stage, we need to progress to UPDATE_DATA_PTRS stage.
+ *
+ * Return >0 if there is no extents to relocate anymore.
+ *
+ * Return <0 for fatal error.
+ */
 static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 {
 	struct btrfs_fs_info *fs_info = rc->extent_root->fs_info;
@@ -3988,6 +3996,7 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 	struct btrfs_extent_item *ei;
 	u64 flags;
 	u32 item_size;
+	bool no_more_extent = true;
 	int ret;
 	int err = 0;
 	int progress = 0;
@@ -4033,6 +4042,7 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 			break;
 
 		rc->extents_found++;
+		no_more_extent = false;
 
 		ei = btrfs_item_ptr(path->nodes[0], path->slots[0],
 				    struct btrfs_extent_item);
@@ -4154,7 +4164,9 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 		err = ret;
 	btrfs_free_block_rsv(fs_info, rc->block_rsv);
 	btrfs_free_path(path);
-	return err;
+	if (err)
+		return err;
+	return no_more_extent;
 }
 
 static int __insert_orphan_inode(struct btrfs_trans_handle *trans,
@@ -4374,6 +4386,8 @@ int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start)
 		if (ret < 0)
 			err = ret;
 
+		if (ret > 0)
+			break;
 		finishes_stage = rc->stage;
 		/*
 		 * We may have gotten ENOSPC after we already dirtied some
-- 
2.23.0

