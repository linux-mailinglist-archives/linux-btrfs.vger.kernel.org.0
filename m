Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E76B5140478
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 08:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbgAQHaI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 02:30:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:45074 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729121AbgAQHaI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 02:30:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2300FAC0C
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 07:30:07 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs-progs: check/original: Repair extent item generation
Date:   Fri, 17 Jan 2020 15:29:58 +0800
Message-Id: <20200117072959.27929-3-wqu@suse.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117072959.27929-1-wqu@suse.com>
References: <20200117072959.27929-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Just like lowmem mode, reset extent item generation using current
transid.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/main.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/check/main.c b/check/main.c
index 4115049a1529..74316eab85ec 100644
--- a/check/main.c
+++ b/check/main.c
@@ -7885,6 +7885,65 @@ static int record_unaligned_extent_rec(struct btrfs_fs_info *fs_info,
 	return ret;
 }
 
+static int reset_extent_item_gen(struct btrfs_fs_info *fs_info,
+				 struct extent_record *rec)
+{
+	struct btrfs_root *root = fs_info->extent_root;
+	struct btrfs_trans_handle *trans;
+	struct btrfs_extent_item *ei;
+	struct extent_buffer *leaf;
+	struct btrfs_path path;
+	struct btrfs_key key;
+	u64 transid;
+	int slot;
+	int ret;
+
+	key.objectid = rec->start;
+	if (rec->metadata && btrfs_fs_incompat(fs_info, SKINNY_METADATA)) {
+		key.type = BTRFS_METADATA_ITEM_KEY;
+		key.offset = rec->info_level;
+	} else {
+		key.type = BTRFS_EXTENT_ITEM_KEY;
+		key.offset = rec->max_size;
+	}
+	btrfs_init_path(&path);
+	trans = btrfs_start_transaction(root, 1);
+	if (IS_ERR(trans)) {
+		ret = PTR_ERR(trans);
+		errno = -ret;
+		error("failed to start transaction: %m");
+		return ret;
+	}
+	transid = trans->transid;
+
+	ret = btrfs_search_slot(trans, root, &key, &path, 0, 1);
+	if (ret < 0) {
+		errno = ret;
+		error("failed to search extent tree: %m");
+		goto abort;
+	}
+	if (ret > 0) {
+		ret = -ENOENT;
+		error("failed to find extent item for bytenr %llu",
+			rec->start);
+		goto abort;
+	}
+	slot = path.slots[0];
+	leaf = path.nodes[0];
+	ei = btrfs_item_ptr(leaf, slot, struct btrfs_extent_item);
+	btrfs_set_extent_generation(leaf, ei, transid);
+	ret = btrfs_commit_transaction(trans, root);
+	if (!ret)
+		printf("reset extent item generation to %llu for extent %llu\n",
+			transid, key.objectid);
+	btrfs_release_path(&path);
+	return ret;
+abort:
+	btrfs_abort_transaction(trans, ret);
+	btrfs_release_path(&path);
+	return ret;
+}
+
 static int check_extent_refs(struct btrfs_root *root,
 			     struct cache_tree *extent_cache)
 {
@@ -7962,6 +8021,7 @@ static int check_extent_refs(struct btrfs_root *root,
 	while (1) {
 		int cur_err = 0;
 		int fix = 0;
+		bool reset_gen = false;
 
 		cache = search_cache_extent(extent_cache, 0);
 		if (!cache)
@@ -7979,6 +8039,7 @@ static int check_extent_refs(struct btrfs_root *root,
 	"invalid generation for extent %llu, have %llu expect (0, %llu]",
 				rec->start, rec->generation,
 				super_gen + 1);
+			reset_gen = true;
 			cur_err = 1;
 		}
 		if (rec->refs != rec->extent_item_refs) {
@@ -8019,6 +8080,11 @@ static int check_extent_refs(struct btrfs_root *root,
 			cur_err = 1;
 		}
 
+		if (repair && reset_gen) {
+			ret = reset_extent_item_gen(root->fs_info, rec);
+			if (ret)
+				goto repair_abort;
+		}
 		if (repair && fix) {
 			ret = fixup_extent_refs(root->fs_info, extent_cache,
 						rec);
-- 
2.24.1

