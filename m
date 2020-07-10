Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1B521B62D
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jul 2020 15:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgGJNTv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Jul 2020 09:19:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:46026 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727092AbgGJNTu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Jul 2020 09:19:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3F0C4AC5E;
        Fri, 10 Jul 2020 13:19:49 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B9295DA842; Fri, 10 Jul 2020 15:19:28 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>, Robbie Ko <robbieko@synology.com>
Subject: [PATCH] btrfs: prefetch chunk tree leaves at mount
Date:   Fri, 10 Jul 2020 15:19:28 +0200
Message-Id: <20200710131928.7187-1-dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The whole chunk tree is read at mount time so we can utilize readahead
to get the tree blocks to memory before we read the items. The idea is
from Robbie, but instead of updating search slot readahead, this patch
implements the chunk tree readahead manually from nodes on level 1.

We've decided to do specific readahead optimizations and then unify them
under a common API so we don't break everything by changing the search
slot readahead logic.

Higher chunk trees grow on large filesystems (many terabytes), and
prefetching just level 1 seems to be sufficient. Provided example was
from a 200TiB filesystem with chunk tree level 2.

CC: Robbie Ko <robbieko@synology.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/volumes.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index c7a3d4d730a3..e19891243199 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7013,6 +7013,19 @@ bool btrfs_check_rw_degradable(struct btrfs_fs_info *fs_info,
 	return ret;
 }
 
+void readahead_tree_node_children(struct extent_buffer *node)
+{
+	int i;
+	const int nr_items = btrfs_header_nritems(node);
+
+	for (i = 0; i < nr_items; i++) {
+		u64 start;
+
+		start = btrfs_node_blockptr(node, i);
+		readahead_tree_block(node->fs_info, start);
+	}
+}
+
 int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_root *root = fs_info->chunk_root;
@@ -7023,6 +7036,7 @@ int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info)
 	int ret;
 	int slot;
 	u64 total_dev = 0;
+	u64 last_ra_node = 0;
 
 	path = btrfs_alloc_path();
 	if (!path)
@@ -7048,6 +7062,8 @@ int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info)
 	if (ret < 0)
 		goto error;
 	while (1) {
+		struct extent_buffer *node;
+
 		leaf = path->nodes[0];
 		slot = path->slots[0];
 		if (slot >= btrfs_header_nritems(leaf)) {
@@ -7058,6 +7074,13 @@ int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info)
 				goto error;
 			break;
 		}
+		node = path->nodes[1];
+		if (node) {
+			if (last_ra_node != node->start) {
+				readahead_tree_node_children(node);
+				last_ra_node = node->start;
+			}
+		}
 		btrfs_item_key_to_cpu(leaf, &found_key, slot);
 		if (found_key.type == BTRFS_DEV_ITEM_KEY) {
 			struct btrfs_dev_item *dev_item;
-- 
2.25.0

