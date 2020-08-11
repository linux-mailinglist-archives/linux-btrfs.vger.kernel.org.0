Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01963241A97
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Aug 2020 13:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbgHKLqR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Aug 2020 07:46:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:33380 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728326AbgHKLqQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Aug 2020 07:46:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 05B3AAEA8
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Aug 2020 11:46:36 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 3/4] btrfs-progs: check/original: add the ability to repair extent item generation
Date:   Tue, 11 Aug 2020 19:44:50 +0800
Message-Id: <20200811114451.28862-4-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200811114451.28862-1-wqu@suse.com>
References: <20200811114451.28862-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is pretty much the same as the lowmem mode, it will try to reset
the extent item generation using either the tree block generation or
current transid.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/main.c | 74 +++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 70 insertions(+), 4 deletions(-)

diff --git a/check/main.c b/check/main.c
index 72fa28ad216a..dc366b125ece 100644
--- a/check/main.c
+++ b/check/main.c
@@ -7914,6 +7914,63 @@ static int record_unaligned_extent_rec(struct btrfs_fs_info *fs_info,
 	return ret;
 }
 
+static int repair_extent_item_generation(struct btrfs_fs_info *fs_info,
+					 struct extent_record *rec)
+{
+	struct btrfs_trans_handle *trans;
+	struct btrfs_path path;
+	struct btrfs_key key;
+	struct btrfs_extent_item *ei;
+	struct btrfs_root *extent_root = fs_info->extent_root;
+	u64 new_gen = 0;;
+	int ret;
+
+	key.objectid = rec->start;
+	key.type = BTRFS_METADATA_ITEM_KEY;
+	key.offset = (u64)-1;
+
+	get_extent_item_generation(fs_info, rec->start, &new_gen);
+	trans = btrfs_start_transaction(extent_root, 1);
+	if (IS_ERR(trans)) {
+		ret = PTR_ERR(trans);
+		errno = -ret;
+		error("failed to start transaction: %m");
+		return ret;
+	}
+	btrfs_init_path(&path);
+	ret = btrfs_search_slot(trans, extent_root, &key, &path, 0, 1);
+	/* Not possible */
+	if (ret == 0)
+		ret = -EUCLEAN;
+	if (ret < 0)
+		goto out;
+	ret = btrfs_previous_extent_item(extent_root, &path, rec->start);
+	if (ret > 0)
+		ret = -ENOENT;
+	if (ret < 0)
+		goto out;
+	
+	if (!new_gen)
+		new_gen = trans->transid;
+	ei = btrfs_item_ptr(path.nodes[0], path.slots[0],
+			    struct btrfs_extent_item);
+	btrfs_set_extent_generation(path.nodes[0], ei, new_gen);
+	ret = btrfs_commit_transaction(trans, extent_root);
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to commit transaction: %m");
+		goto out;
+	}
+	printf("Reset extent item (%llu) generation to %llu\n",
+		key.objectid, new_gen);
+	rec->generation = new_gen;
+out:
+	btrfs_release_path(&path);
+	if (ret < 0)
+		btrfs_abort_transaction(trans, ret); 
+	return ret;
+}
+
 static int check_extent_refs(struct btrfs_root *root,
 			     struct cache_tree *extent_cache)
 {
@@ -8004,11 +8061,20 @@ static int check_extent_refs(struct btrfs_root *root,
 		}
 
 		if (rec->generation > super_gen + 1) {
-			error(
+			bool repaired = false;
+			if (repair) {
+				ret = repair_extent_item_generation(
+						root->fs_info, rec);
+				if (ret == 0)
+					repaired = true;
+			}
+			if (!repaired) {
+				error(
 	"invalid generation for extent %llu, have %llu expect (0, %llu]",
-				rec->start, rec->generation,
-				super_gen + 1);
-			cur_err = 1;
+					rec->start, rec->generation,
+					super_gen + 1);
+				cur_err = 1;
+			}
 		}
 		if (rec->refs != rec->extent_item_refs) {
 			fprintf(stderr, "ref mismatch on [%llu %llu] ",
-- 
2.28.0

