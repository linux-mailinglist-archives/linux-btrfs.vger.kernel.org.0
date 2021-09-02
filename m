Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A06843FEE66
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Sep 2021 15:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344991AbhIBNJs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Sep 2021 09:09:48 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:33932 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344953AbhIBNJr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Sep 2021 09:09:47 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C646F1FF97
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Sep 2021 13:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1630588128; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zvpYMLfR+8rvryL2utT0fkwZoYbd0AIxJ7HAjCZOiOI=;
        b=q6qv6kjysebW41Fwn8D7KsX2PmkM+51qWlC3F99ROE9NUG4353sYPLkco7yXrNwpoHlNkb
        XbNmLq7GNVGZGv/yatMQ5w4PDVhlYaw35kFe89uSMcznMZiCmVGKEr9orcynO49c34JSry
        q5UGtEDmEZN4BkbBP7A3CYfPtPFdg+I=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 0822513712
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Sep 2021 13:08:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id EO+VLt/MMGEsEAAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Sep 2021 13:08:47 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs-progs: use btrfs_key for btrfs_check_node() and btrfs_check_leaf()
Date:   Thu,  2 Sep 2021 21:08:41 +0800
Message-Id: <20210902130843.120176-2-wqu@suse.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210902130843.120176-1-wqu@suse.com>
References: <20210902130843.120176-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In kernel space we hardly use btrfs_disk_key, unless for very lowlevel
code.

There is no need to intentionally use btrfs_disk_key in btrfs-progs
either.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/main.c          |  9 +++---
 check/mode-original.h |  2 +-
 kernel-shared/ctree.c | 64 +++++++++++++++++++++++--------------------
 kernel-shared/ctree.h |  4 +--
 4 files changed, 42 insertions(+), 37 deletions(-)

diff --git a/check/main.c b/check/main.c
index a27efe56eec6..ff1ccade3967 100644
--- a/check/main.c
+++ b/check/main.c
@@ -4162,7 +4162,6 @@ static int record_bad_block_io(struct cache_tree *extent_cache,
 {
 	struct extent_record *rec;
 	struct cache_extent *cache;
-	struct btrfs_key key;
 
 	cache = lookup_cache_extent(extent_cache, start, len);
 	if (!cache)
@@ -4172,8 +4171,8 @@ static int record_bad_block_io(struct cache_tree *extent_cache,
 	if (!is_extent_tree_record(rec))
 		return 0;
 
-	btrfs_disk_key_to_cpu(&key, &rec->parent_key);
-	return btrfs_add_corrupt_extent_record(gfs_info, &key, start, len, 0);
+	return btrfs_add_corrupt_extent_record(gfs_info, &rec->parent_key,
+					       start, len, 0);
 }
 
 static int swap_values(struct btrfs_root *root, struct btrfs_path *path,
@@ -6567,7 +6566,9 @@ static int run_next_block(struct btrfs_root *root,
 			}
 
 			memset(&tmpl, 0, sizeof(tmpl));
-			btrfs_cpu_key_to_disk(&tmpl.parent_key, &key);
+			tmpl.parent_key.objectid = key.objectid;
+			tmpl.parent_key.type = key.type;
+			tmpl.parent_key.offset = key.offset;
 			tmpl.parent_generation =
 				btrfs_node_ptr_generation(buf, i);
 			tmpl.start = ptr;
diff --git a/check/mode-original.h b/check/mode-original.h
index eed16d92d0db..cf06917c47dc 100644
--- a/check/mode-original.h
+++ b/check/mode-original.h
@@ -79,7 +79,7 @@ struct extent_record {
 	struct rb_root backref_tree;
 	struct list_head list;
 	struct cache_extent cache;
-	struct btrfs_disk_key parent_key;
+	struct btrfs_key parent_key;
 	u64 start;
 	u64 max_size;
 	u64 nr;
diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
index 0845cc6091d4..c015c4f879c1 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -568,11 +568,10 @@ static inline unsigned int leaf_data_end(const struct btrfs_fs_info *fs_info,
 
 enum btrfs_tree_block_status
 btrfs_check_node(struct btrfs_fs_info *fs_info,
-		 struct btrfs_disk_key *parent_key, struct extent_buffer *buf)
+		 struct btrfs_key *parent_key, struct extent_buffer *buf)
 {
 	int i;
-	struct btrfs_key cpukey;
-	struct btrfs_disk_key key;
+	struct btrfs_key key;
 	u32 nritems = btrfs_header_nritems(buf);
 	enum btrfs_tree_block_status ret = BTRFS_TREE_BLOCK_INVALID_NRITEMS;
 
@@ -581,25 +580,27 @@ btrfs_check_node(struct btrfs_fs_info *fs_info,
 
 	ret = BTRFS_TREE_BLOCK_INVALID_PARENT_KEY;
 	if (parent_key && parent_key->type) {
-		btrfs_node_key(buf, &key, 0);
+		btrfs_node_key_to_cpu(buf, &key, 0);
 		if (memcmp(parent_key, &key, sizeof(key)))
 			goto fail;
 	}
 	ret = BTRFS_TREE_BLOCK_BAD_KEY_ORDER;
 	for (i = 0; nritems > 1 && i < nritems - 2; i++) {
-		btrfs_node_key(buf, &key, i);
-		btrfs_node_key_to_cpu(buf, &cpukey, i + 1);
-		if (btrfs_comp_keys(&key, &cpukey) >= 0)
+		struct btrfs_key next_key;
+
+		btrfs_node_key_to_cpu(buf, &key, i);
+		btrfs_node_key_to_cpu(buf, &next_key, i + 1);
+		if (btrfs_comp_cpu_keys(&key, &next_key) >= 0)
 			goto fail;
 	}
 	return BTRFS_TREE_BLOCK_CLEAN;
 fail:
 	if (btrfs_header_owner(buf) == BTRFS_EXTENT_TREE_OBJECTID) {
 		if (parent_key)
-			btrfs_disk_key_to_cpu(&cpukey, parent_key);
+			memcpy(&key, parent_key, sizeof(struct btrfs_key));
 		else
-			btrfs_node_key_to_cpu(buf, &cpukey, 0);
-		btrfs_add_corrupt_extent_record(fs_info, &cpukey,
+			btrfs_node_key_to_cpu(buf, &key, 0);
+		btrfs_add_corrupt_extent_record(fs_info, &key,
 						buf->start, buf->len,
 						btrfs_header_level(buf));
 	}
@@ -608,11 +609,10 @@ fail:
 
 enum btrfs_tree_block_status
 btrfs_check_leaf(struct btrfs_fs_info *fs_info,
-		 struct btrfs_disk_key *parent_key, struct extent_buffer *buf)
+		 struct btrfs_key *parent_key, struct extent_buffer *buf)
 {
 	int i;
-	struct btrfs_key cpukey;
-	struct btrfs_disk_key key;
+	struct btrfs_key key;
 	u32 nritems = btrfs_header_nritems(buf);
 	enum btrfs_tree_block_status ret = BTRFS_TREE_BLOCK_INVALID_NRITEMS;
 
@@ -639,7 +639,7 @@ btrfs_check_leaf(struct btrfs_fs_info *fs_info,
 	if (nritems == 0)
 		return BTRFS_TREE_BLOCK_CLEAN;
 
-	btrfs_item_key(buf, &key, 0);
+	btrfs_item_key_to_cpu(buf, &key, 0);
 	if (parent_key && parent_key->type &&
 	    memcmp(parent_key, &key, sizeof(key))) {
 		ret = BTRFS_TREE_BLOCK_INVALID_PARENT_KEY;
@@ -648,9 +648,12 @@ btrfs_check_leaf(struct btrfs_fs_info *fs_info,
 		goto fail;
 	}
 	for (i = 0; nritems > 1 && i < nritems - 1; i++) {
-		btrfs_item_key(buf, &key, i);
-		btrfs_item_key_to_cpu(buf, &cpukey, i + 1);
-		if (btrfs_comp_keys(&key, &cpukey) >= 0) {
+		struct btrfs_key next_key;
+
+		btrfs_item_key_to_cpu(buf, &key, i);
+		btrfs_item_key_to_cpu(buf, &next_key, i + 1);
+
+		if (btrfs_comp_cpu_keys(&key, &next_key) >= 0) {
 			ret = BTRFS_TREE_BLOCK_BAD_KEY_ORDER;
 			fprintf(stderr, "bad key ordering %d %d\n", i, i+1);
 			goto fail;
@@ -676,8 +679,10 @@ btrfs_check_leaf(struct btrfs_fs_info *fs_info,
 	for (i = 0; i < nritems; i++) {
 		if (btrfs_item_end_nr(buf, i) >
 				BTRFS_LEAF_DATA_SIZE(fs_info)) {
-			btrfs_item_key(buf, &key, 0);
-			btrfs_print_key(&key);
+			struct btrfs_disk_key disk_key;
+
+			btrfs_item_key(buf, &disk_key, 0);
+			btrfs_print_key(&disk_key);
 			fflush(stdout);
 			ret = BTRFS_TREE_BLOCK_INVALID_OFFSETS;
 			fprintf(stderr, "slot end outside of leaf %llu > %llu\n",
@@ -692,11 +697,11 @@ btrfs_check_leaf(struct btrfs_fs_info *fs_info,
 fail:
 	if (btrfs_header_owner(buf) == BTRFS_EXTENT_TREE_OBJECTID) {
 		if (parent_key)
-			btrfs_disk_key_to_cpu(&cpukey, parent_key);
+			memcpy(&key, parent_key, sizeof(struct btrfs_key));
 		else
-			btrfs_item_key_to_cpu(buf, &cpukey, 0);
+			btrfs_item_key_to_cpu(buf, &key, 0);
 
-		btrfs_add_corrupt_extent_record(fs_info, &cpukey,
+		btrfs_add_corrupt_extent_record(fs_info, &key,
 						buf->start, buf->len, 0);
 	}
 	return ret;
@@ -705,22 +710,21 @@ fail:
 static int noinline check_block(struct btrfs_fs_info *fs_info,
 				struct btrfs_path *path, int level)
 {
-	struct btrfs_disk_key key;
-	struct btrfs_disk_key *key_ptr = NULL;
-	struct extent_buffer *parent;
+	struct btrfs_key key;
+	struct btrfs_key *parent_key_ptr;
 	enum btrfs_tree_block_status ret;
 
 	if (path->skip_check_block)
 		return 0;
 	if (path->nodes[level + 1]) {
-		parent = path->nodes[level + 1];
-		btrfs_node_key(parent, &key, path->slots[level + 1]);
-		key_ptr = &key;
+		btrfs_node_key_to_cpu(path->nodes[level + 1], &key,
+				     path->slots[level + 1]);
+		parent_key_ptr = &key;
 	}
 	if (level == 0)
-		ret = btrfs_check_leaf(fs_info, key_ptr, path->nodes[0]);
+		ret = btrfs_check_leaf(fs_info, parent_key_ptr, path->nodes[0]);
 	else
-		ret = btrfs_check_node(fs_info, key_ptr, path->nodes[level]);
+		ret = btrfs_check_node(fs_info, parent_key_ptr, path->nodes[level]);
 	if (ret == BTRFS_TREE_BLOCK_CLEAN)
 		return 0;
 	return -EIO;
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 3cca60323e3d..5ed8e3e373fa 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -2637,10 +2637,10 @@ int btrfs_del_ptr(struct btrfs_root *root, struct btrfs_path *path,
 		int level, int slot);
 enum btrfs_tree_block_status
 btrfs_check_node(struct btrfs_fs_info *fs_info,
-		 struct btrfs_disk_key *parent_key, struct extent_buffer *buf);
+		 struct btrfs_key *parent_key, struct extent_buffer *buf);
 enum btrfs_tree_block_status
 btrfs_check_leaf(struct btrfs_fs_info *fs_info,
-		 struct btrfs_disk_key *parent_key, struct extent_buffer *buf);
+		 struct btrfs_key *parent_key, struct extent_buffer *buf);
 void reada_for_search(struct btrfs_fs_info *fs_info, struct btrfs_path *path,
 		      int level, int slot, u64 objectid);
 struct extent_buffer *read_node_slot(struct btrfs_fs_info *fs_info,
-- 
2.33.0

