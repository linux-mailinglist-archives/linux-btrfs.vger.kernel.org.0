Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E10251E3EFC
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 May 2020 12:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387996AbgE0K2f (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 May 2020 06:28:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:44656 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387985AbgE0K2f (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 May 2020 06:28:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B9699AC51
        for <linux-btrfs@vger.kernel.org>; Wed, 27 May 2020 10:28:36 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 6/6] btrfs-progs: image: Pin down log tree blocks before fixup
Date:   Wed, 27 May 2020 18:28:10 +0800
Message-Id: <20200527102810.147999-7-wqu@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200527102810.147999-1-wqu@suse.com>
References: <20200527102810.147999-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Although btrfs-image will dump log tree, we will modify the restored
image if it's not a multi-device restore.

In that case, since log tree blocks are not recorded in extent tree,
extent allocator will try to re-use the tree blocks belonging to log
trees, this would lead to transid mismatch if btrfs-restore chooses to
do device/chunk fixup.

This patch will fix such problem by pinning down all the log trees
blocks before fixing up the device and chunk trees.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 image/main.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/image/main.c b/image/main.c
index 48d8fcd5078c..71ea131c8c29 100644
--- a/image/main.c
+++ b/image/main.c
@@ -2500,6 +2500,66 @@ out:
 	return ret;
 }
 
+static int iter_tree_blocks(struct btrfs_fs_info *fs_info,
+			    struct extent_buffer *eb, bool pin)
+{
+	void (*func)(struct btrfs_fs_info *fs_info, u64 bytenr, u64 num_bytes);
+	int nritems;
+	int level;
+	int i;
+	int ret;
+
+	if (pin)
+		func = btrfs_pin_extent;
+	else
+		func = btrfs_unpin_extent;
+
+	func(fs_info, eb->start, eb->len);
+
+	level = btrfs_header_level(eb);
+	nritems = btrfs_header_nritems(eb);
+	if (level == 0)
+		return 0;
+
+	for (i = 0; i < nritems; i++) {
+		u64 bytenr;
+		struct extent_buffer *tmp;
+
+		if (level == 0) {
+			struct btrfs_root_item *ri;
+			struct btrfs_key key;
+
+			btrfs_item_key_to_cpu(eb, &key, i);
+			if (key.type != BTRFS_ROOT_ITEM_KEY)
+				continue;
+			ri = btrfs_item_ptr(eb, i, struct btrfs_root_item);
+			bytenr = btrfs_disk_root_bytenr(eb, ri);
+			tmp = read_tree_block(fs_info, bytenr, 0);
+			if (!extent_buffer_uptodate(tmp)) {
+				error("unable to read log root block");
+				return -EIO;
+			}
+			ret = iter_tree_blocks(fs_info, tmp, pin);
+			free_extent_buffer(tmp);
+			if (ret)
+				return ret;
+		} else {
+			bytenr = btrfs_node_blockptr(eb, i);
+			tmp = read_tree_block(fs_info, bytenr, 0);
+			if (!extent_buffer_uptodate(tmp)) {
+				error("unable to read log root block");
+				return -EIO;
+			}
+			ret = iter_tree_blocks(fs_info, tmp, pin);
+			free_extent_buffer(tmp);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
 static int fixup_chunks_and_devices(struct btrfs_fs_info *fs_info,
 			 struct mdrestore_struct *mdres, int out_fd)
 {
@@ -2516,6 +2576,9 @@ static int fixup_chunks_and_devices(struct btrfs_fs_info *fs_info,
 		return PTR_ERR(trans);
 	}
 
+	if (btrfs_super_log_root(fs_info->super_copy) &&
+	    fs_info->log_root_tree)
+		iter_tree_blocks(fs_info, fs_info->log_root_tree->node, true);
 	fixup_block_groups(trans);
 	ret = fixup_dev_extents(trans);
 	if (ret < 0)
@@ -2530,6 +2593,9 @@ static int fixup_chunks_and_devices(struct btrfs_fs_info *fs_info,
 		error("unable to commit transaction: %d", ret);
 		return ret;
 	}
+	if (btrfs_super_log_root(fs_info->super_copy) &&
+	    fs_info->log_root_tree)
+		iter_tree_blocks(fs_info, fs_info->log_root_tree->node, false);
 	return 0;
 error:
 	errno = -ret;
-- 
2.26.2

