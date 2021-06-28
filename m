Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D90533B5C5B
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Jun 2021 12:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbhF1KTP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Jun 2021 06:19:15 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:35906 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232605AbhF1KTM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Jun 2021 06:19:12 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1E273223FC
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Jun 2021 10:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624875406; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QzDkYtdX82z2XHq8+BV0IyHXt/NwHxaEx1LvFR5qx2U=;
        b=henJGC4RoqsJmrvvzSvkGbpS85OBxRrEZSaxr9ua+g6ntuuFgTLmAH/R7MQf4WSnZND5KI
        CbRQi/DEO8wCtvt8nr/WSteadq80S2ZsZioi57cQEcFwdjoxo+wK032INQ7VX22zsuxPHb
        qlwMKI5OHRgtM71chyjl8GOa/ZnaScI=
Received: from adam-pc.lan (unknown [10.163.16.38])
        by relay2.suse.de (Postfix) with ESMTP id 2A797A3B8E
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Jun 2021 10:16:44 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs: allow BTRFS_IOC_SNAP_DESTROY_V2 to remove ghost subvolume
Date:   Mon, 28 Jun 2021 18:16:37 +0800
Message-Id: <20210628101637.349718-4-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210628101637.349718-1-wqu@suse.com>
References: <20210628101637.349718-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is a report from the mail list that some subvolumes don't have any
ROOT_REF/BACKREF and has 0 ref.
But without an ORPHAN item.

Such ghost subvolumes can't be deleted by any ioctl but only rely on
btrfs-progs to add ORPHAN item.

Normally kernel only needs to gracefully abort/reject such corrupted
structure, but in this case we have all the needed infrastructures and
interface to allow BTRFS_IOC_SNAP_DESTROY_V2 to delete it.

So add the ability to delete such ghost subvolumes to
BTRFS_IOC_SNAP_DESTROY_V2.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ioctl.c | 78 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 889e27c24e3a..06d3c293cffd 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2892,6 +2892,81 @@ static int btrfs_ioctl_get_subvol_rootref(struct file *file, void __user *argp)
 	return ret;
 }
 
+/*
+ * Special case that some subvolume has missing ORPHAN_ITEM, but its refs is
+ * already 0 (without any ROOT_REF/BACKREF).
+ * In that case such subvolume is only taking space while unable to be deleted.
+ *
+ * No reproducer to reproduce such corruption, but it won't hurt to cleanup them
+ * as we can reuse existing code since we only need to insert an orphan item and
+ * queue them to be deleted.
+ */
+static int __cold remove_ghost_subvol(struct btrfs_fs_info *fs_info,
+				      u64 rootid)
+{
+	struct btrfs_trans_handle *trans;
+	struct btrfs_root *root;
+	struct btrfs_path *path;
+	struct btrfs_key key;
+	int ret;
+
+	root = btrfs_get_fs_root(fs_info, rootid, false);
+	if (IS_ERR(root)) {
+		ret = PTR_ERR(root);
+		return ret;
+	}
+
+	/* A ghost subvolume is already a problem, better to output a warning */
+	btrfs_warn(fs_info, "root %llu has no refs nor orphan item", rootid); 
+	if (btrfs_root_refs(&root->root_item) != 0) {
+		/* We get some strange root */
+		btrfs_warn(fs_info,
+			"root %llu has %u refs, but no proper root backref",
+			rootid, btrfs_root_refs(&root->root_item));
+		ret = -EUCLEAN;
+		goto out;
+	}
+
+	/* Already has orphan inserted */
+	if (test_bit(BTRFS_ROOT_ORPHAN_ITEM_INSERTED, &root->state))
+		goto out;
+
+	path = btrfs_alloc_path();
+	if (!path) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	key.objectid = BTRFS_ORPHAN_OBJECTID;
+	key.type = BTRFS_ORPHAN_ITEM_KEY;
+	key.offset = rootid;
+
+	ret = btrfs_search_slot(NULL, fs_info->tree_root, &key, path, 0, 0);
+	btrfs_free_path(path);
+	/* Either error or there is already an orphan item */
+	if (ret <= 0)
+		goto out;
+
+	trans = btrfs_start_transaction(fs_info->tree_root, 1);
+	if (IS_ERR(trans)) {
+		ret = PTR_ERR(trans);
+		goto out;
+	}
+
+	ret = btrfs_insert_orphan_item(trans, fs_info->tree_root, rootid);
+	if (ret < 0 && ret != -EEXIST) {
+		btrfs_abort_transaction(trans, ret);
+		goto end_trans;
+	}
+	ret = 0;
+	btrfs_add_dead_root(root);
+
+end_trans:
+	btrfs_end_transaction(trans);
+out:
+	btrfs_put_root(root);
+	return ret;
+}
+
 static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 					     void __user *arg,
 					     bool destroy_v2)
@@ -2947,6 +3022,9 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 					vol_args2->subvolid, 0, 0);
 			if (IS_ERR(dentry)) {
 				err = PTR_ERR(dentry);
+				if (err == -ENOENT)
+					err = remove_ghost_subvol(fs_info,
+							vol_args2->subvolid);
 				goto out_drop_write;
 			}
 
-- 
2.32.0

