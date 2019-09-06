Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0231FABE81
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Sep 2019 19:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404388AbfIFRQH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Sep 2019 13:16:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:36564 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404350AbfIFRQH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 6 Sep 2019 13:16:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 59BBFADDA
        for <linux-btrfs@vger.kernel.org>; Fri,  6 Sep 2019 17:16:05 +0000 (UTC)
From:   Mark Fasheh <mfasheh@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Mark Fasheh <mfasheh@suse.de>
Subject: [PATCH 2/3] btrfs: move ref finding machinery out of build_backref_tree()
Date:   Fri,  6 Sep 2019 10:15:32 -0700
Message-Id: <20190906171533.618-3-mfasheh@suse.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20190906171533.618-1-mfasheh@suse.com>
References: <20190906171533.618-1-mfasheh@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Mark Fasheh <mfasheh@suse.de>

build_backref_tree() is walking extent refs in what is an otherwise self
contained chunk of code.  We can shrink the total number of lines in
build_backref_tree() *and* make it more readable by moving that walk into
its own subroutine.

Signed-off-by: Mark Fasheh <mfasheh@suse.de>
---
 fs/btrfs/backref-cache.c | 110 +++++++++++++++++++++++----------------
 1 file changed, 65 insertions(+), 45 deletions(-)

diff --git a/fs/btrfs/backref-cache.c b/fs/btrfs/backref-cache.c
index d0f6530f23b8..ff0d49ca6e26 100644
--- a/fs/btrfs/backref-cache.c
+++ b/fs/btrfs/backref-cache.c
@@ -336,6 +336,61 @@ int find_inline_backref(struct extent_buffer *leaf, int slot,
 	return 0;
 }
 
+#define SEARCH_COMPLETE	1
+#define SEARCH_NEXT	2
+static int find_next_ref(struct btrfs_root *extent_root, u64 cur_bytenr,
+			 struct btrfs_path *path, unsigned long *ptr,
+			 unsigned long *end, struct btrfs_key *key, bool exist)
+{
+	struct extent_buffer *eb = path->nodes[0];
+	int ret;
+
+	if (*ptr >= *end) {
+		if (path->slots[0] >= btrfs_header_nritems(eb)) {
+			ret = btrfs_next_leaf(extent_root, path);
+			if (ret < 0)
+				goto out;
+			if (ret > 0)
+				return SEARCH_COMPLETE;
+			eb = path->nodes[0];
+		}
+
+		btrfs_item_key_to_cpu(eb, key, path->slots[0]);
+		if (key->objectid != cur_bytenr) {
+			WARN_ON(exist);
+			return SEARCH_COMPLETE;
+		}
+
+		if (key->type == BTRFS_EXTENT_ITEM_KEY ||
+		    key->type == BTRFS_METADATA_ITEM_KEY) {
+			ret = find_inline_backref(eb, path->slots[0],
+						  ptr, end);
+			if (ret)
+				return SEARCH_NEXT;
+		}
+	}
+
+	if (*ptr < *end) {
+		/* update key for inline back ref */
+		struct btrfs_extent_inline_ref *iref;
+		int type;
+		iref = (struct btrfs_extent_inline_ref *)(*ptr);
+		type = btrfs_get_extent_inline_ref_type(eb, iref,
+							BTRFS_REF_TYPE_BLOCK);
+		if (type == BTRFS_REF_TYPE_INVALID) {
+			ret = -EUCLEAN;
+			goto out;
+		}
+		key->type = type;
+		key->offset = btrfs_extent_inline_ref_offset(eb, iref);
+
+		WARN_ON(key->type != BTRFS_TREE_BLOCK_REF_KEY &&
+			key->type != BTRFS_SHARED_BLOCK_REF_KEY);
+	}
+	ret = 0;
+out:
+	return ret;
+}
 
 /*
  * build backref tree for a given tree block. root of the backref tree
@@ -439,52 +494,17 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 
 	while (1) {
 		cond_resched();
-		eb = path1->nodes[0];
-
-		if (ptr >= end) {
-			if (path1->slots[0] >= btrfs_header_nritems(eb)) {
-				ret = btrfs_next_leaf(rc->extent_root, path1);
-				if (ret < 0) {
-					err = ret;
-					goto out;
-				}
-				if (ret > 0)
-					break;
-				eb = path1->nodes[0];
-			}
-
-			btrfs_item_key_to_cpu(eb, &key, path1->slots[0]);
-			if (key.objectid != cur->bytenr) {
-				WARN_ON(exist);
-				break;
-			}
-
-			if (key.type == BTRFS_EXTENT_ITEM_KEY ||
-			    key.type == BTRFS_METADATA_ITEM_KEY) {
-				ret = find_inline_backref(eb, path1->slots[0],
-							  &ptr, &end);
-				if (ret)
-					goto next;
-			}
-		}
-
-		if (ptr < end) {
-			/* update key for inline back ref */
-			struct btrfs_extent_inline_ref *iref;
-			int type;
-			iref = (struct btrfs_extent_inline_ref *)ptr;
-			type = btrfs_get_extent_inline_ref_type(eb, iref,
-							BTRFS_REF_TYPE_BLOCK);
-			if (type == BTRFS_REF_TYPE_INVALID) {
-				err = -EUCLEAN;
-				goto out;
-			}
-			key.type = type;
-			key.offset = btrfs_extent_inline_ref_offset(eb, iref);
-
-			WARN_ON(key.type != BTRFS_TREE_BLOCK_REF_KEY &&
-				key.type != BTRFS_SHARED_BLOCK_REF_KEY);
+		ret = find_next_ref(rc->extent_root, cur->bytenr, path1, &ptr,
+				    &end, &key, exist != NULL);
+		if (ret < 0) {
+			err = ret;
+			goto out;
 		}
+		eb = path1->nodes[0];
+		if (ret == SEARCH_COMPLETE)
+			break;
+		else if (ret == SEARCH_NEXT)
+			goto next;
 
 		/*
 		 * Parent node found and matches current inline ref, no need to
-- 
2.22.1

