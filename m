Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 629B8187B00
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Mar 2020 09:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgCQINO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Mar 2020 04:13:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:43260 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbgCQINO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Mar 2020 04:13:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9D708AE46
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Mar 2020 08:13:12 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 36/39] btrfs: qgroup: Introduce helpers to get needed tree block info
Date:   Tue, 17 Mar 2020 16:11:22 +0800
Message-Id: <20200317081125.36289-37-wqu@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317081125.36289-1-wqu@suse.com>
References: <20200317081125.36289-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Introduce two helpers, get_tree_key() and get_tree_info(), to
grab needed tree block info (level, first key and owner) for qgroup
backref cache.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/qgroup.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 28fb11db9f4a..52c491d0d3b1 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1760,6 +1760,72 @@ static struct backref_node *qgroup_backref_cache_build(
 	return node;
 }
 
+static int get_tree_key(struct btrfs_fs_info *fs_info, u64 bytenr, int level,
+			struct btrfs_key *node_key, u64 *owner)
+{
+	struct extent_buffer *eb;
+
+	eb = read_tree_block(fs_info, bytenr, 0, level, NULL);
+	if (IS_ERR(eb))
+		return PTR_ERR(eb);
+	if (btrfs_header_level(eb))
+		btrfs_node_key_to_cpu(eb, node_key, 0);
+	else
+		btrfs_item_key_to_cpu(eb, node_key, 0);
+	*owner = btrfs_header_owner(eb);
+	free_extent_buffer(eb);
+	return 0;
+}
+
+/*
+ * Helper to get tree level, first key and the first owner for
+ * qgroup_backref_cache_build().
+ *
+ * Caller should have done one extent_from_logical() call to ensure the
+ * extent exists and it's a tree block.
+ */
+static int get_tree_info(struct btrfs_fs_info *fs_info,
+			 struct btrfs_path *path, u64 bytenr,
+			 struct btrfs_key *node_key, u64 *owner, u8 *level)
+{
+	struct btrfs_extent_item *ei;
+	struct btrfs_key key;
+	unsigned long ptr = 0;
+	u64 extent_flag;
+	u64 tmp;
+	u32 item_size;
+	int ret;
+
+	path->search_commit_root = 1;
+	path->skip_locking = 1;
+
+	ret = extent_from_logical(fs_info, bytenr, path, &key, &extent_flag);
+	if (ret < 0)
+		goto out;
+	ASSERT(extent_flag & BTRFS_EXTENT_FLAG_TREE_BLOCK);
+
+	ei = btrfs_item_ptr(path->nodes[0], path->slots[0],
+			    struct btrfs_extent_item);
+	item_size = btrfs_item_size_nr(path->nodes[0], path->slots[0]);
+
+	/*
+	 * Don't trust the owner get from tree_backref_for_extent(), as for
+	 * SHARED_BLOCK type, the return owner is just the parent tree block.
+	 */
+	ret = tree_backref_for_extent(&ptr, path->nodes[0], &key,
+			ei, item_size, &tmp, level);
+	if (ret < 0)
+		goto out;
+
+	/* Instead, get the owner from btrfs header */
+	ret = get_tree_key(fs_info, bytenr, *level, node_key, owner);
+	if (ret < 0)
+		goto out;
+out:
+	btrfs_release_path(path);
+	return ret;
+}
+
 /* Iterate all roots in the backref_cache, and add root objectid into @roots */
 static int iterate_all_roots(struct backref_node *node, struct ulist *roots)
 {
-- 
2.25.1

