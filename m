Return-Path: <linux-btrfs+bounces-20017-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A5DCDE56B
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Dec 2025 06:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B95FD3007187
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Dec 2025 05:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8762417F2;
	Fri, 26 Dec 2025 05:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ZAz8roG4";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ZAz8roG4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EDA23D7E6
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Dec 2025 05:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766726025; cv=none; b=D6el4EjMCoN+8luH2SUc/L1PgwVf2elsnY981O442KD2mOGIFoxu2yVo657sIAyOB1hlD8t6GrpsqI+F6Dwuk8BXhmJSueLARWkcasFcqykPLArckMyLb1NrYQQ8zaqimWaOo9RpOTD4W8iMUHOkkRsfgTb8deDmwjo+u/ugkZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766726025; c=relaxed/simple;
	bh=gXhPi/9iwALiF5mB562p6yHR2n1wuTI4EV2qtYMfTP0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IKEuRskSEEgdGhq8dcskC2KpsF4HXQ2iKlnRvM3yePtQvIMLfp2zNYylfkZDVRo9N7DvcDel6/olCcuLNwrZtuWIPXgS//IriZbXb6L30X4j5ISbA9nctqjf0UjiM3Od7WyfA+bwHyyo8ULtOpVafrPiDOlnlLjPF3/rBn4FwLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ZAz8roG4; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ZAz8roG4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A2333336FB
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Dec 2025 05:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1766726002; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=byUG7jy6ORjFJ/dHOG9HLcGUwwxTf2BJkeUdNo2hAJg=;
	b=ZAz8roG4gP1Lyt7pZINeUz5feyhPaTHCgnMBkSlDruieOTrZOlGo+1P71Ugca9HeDJ9bcw
	vwMCb3qVnKHKRhxBSci3j15GhpnnRZCzxje8uO74zT1tvDBxyRCxB3cih48yh4gfXjYDNv
	ZhDH/06fl+QWZXWv/JvE/4Fcskt3rxw=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1766726002; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=byUG7jy6ORjFJ/dHOG9HLcGUwwxTf2BJkeUdNo2hAJg=;
	b=ZAz8roG4gP1Lyt7pZINeUz5feyhPaTHCgnMBkSlDruieOTrZOlGo+1P71Ugca9HeDJ9bcw
	vwMCb3qVnKHKRhxBSci3j15GhpnnRZCzxje8uO74zT1tvDBxyRCxB3cih48yh4gfXjYDNv
	ZhDH/06fl+QWZXWv/JvE/4Fcskt3rxw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D4FC43EA63
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Dec 2025 05:13:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eJmRJXEZTmn1DQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Dec 2025 05:13:21 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 5/7] btrfs: use btrfs_file_header structure for simple usages
Date: Fri, 26 Dec 2025 15:42:51 +1030
Message-ID: <a2ae57d308cdfd4643962f650aee568dd25d7927.1766725912.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1766725912.git.wqu@suse.com>
References: <cover.1766725912.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.68
X-Spam-Level: 
X-Spamd-Result: default: False [-2.68 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	NEURAL_HAM_SHORT(-0.08)[-0.421];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]

Those usage are pretty straightforward, they are checking the type
first, then grabbing values according to the types.

There are only minor changes to btrfs_file_header pointer lifespan, now
they are only defined at the minimal scope when possible.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/backref.c     | 36 +++++++++++++++++++-----------------
 fs/btrfs/ctree.c       | 31 +++++++++++++++++--------------
 fs/btrfs/extent-tree.c | 26 +++++++++++++-------------
 fs/btrfs/fiemap.c      | 30 +++++++++++++++---------------
 fs/btrfs/file-item.c   |  8 ++++----
 fs/btrfs/qgroup.c      | 11 ++++++-----
 fs/btrfs/reflink.c     | 30 +++++++++++++++---------------
 fs/btrfs/relocation.c  | 42 +++++++++++++++++++++---------------------
 8 files changed, 110 insertions(+), 104 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 78da47a3d00e..068e0c8b8663 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -35,10 +35,10 @@ struct extent_inode_elem {
 static int check_extent_in_eb(struct btrfs_backref_walk_ctx *ctx,
 			      const struct btrfs_key *key,
 			      const struct extent_buffer *eb,
-			      const struct btrfs_file_extent_item *fi,
+			      const struct btrfs_file_header *fh,
 			      struct extent_inode_elem **eie)
 {
-	const u64 data_len = btrfs_file_extent_num_bytes(eb, fi);
+	const u64 data_len = btrfs_file_header_num_bytes(eb, fh);
 	u64 offset = key->offset;
 	struct extent_inode_elem *e;
 	const u64 *root_ids;
@@ -46,12 +46,12 @@ static int check_extent_in_eb(struct btrfs_backref_walk_ctx *ctx,
 	bool cached;
 
 	if (!ctx->ignore_extent_item_pos &&
-	    !btrfs_file_extent_compression(eb, fi) &&
-	    !btrfs_file_extent_encryption(eb, fi) &&
-	    !btrfs_file_extent_other_encoding(eb, fi)) {
+	    !btrfs_file_header_compression(eb, fh) &&
+	    !btrfs_file_header_encryption(eb, fh) &&
+	    !btrfs_file_header_other_encoding(eb, fh)) {
 		u64 data_offset;
 
-		data_offset = btrfs_file_extent_offset(eb, fi);
+		data_offset = btrfs_file_header_offset(eb, fh);
 
 		if (ctx->extent_item_pos < data_offset ||
 		    ctx->extent_item_pos >= data_offset + data_len)
@@ -107,7 +107,6 @@ static int find_extent_in_eb(struct btrfs_backref_walk_ctx *ctx,
 {
 	u64 disk_byte;
 	struct btrfs_key key;
-	struct btrfs_file_extent_item *fi;
 	int slot;
 	int nritems;
 	int extent_type;
@@ -120,19 +119,21 @@ static int find_extent_in_eb(struct btrfs_backref_walk_ctx *ctx,
 	 */
 	nritems = btrfs_header_nritems(eb);
 	for (slot = 0; slot < nritems; ++slot) {
+		struct btrfs_file_header *fh;
+
 		btrfs_item_key_to_cpu(eb, &key, slot);
 		if (key.type != BTRFS_EXTENT_DATA_KEY)
 			continue;
-		fi = btrfs_item_ptr(eb, slot, struct btrfs_file_extent_item);
-		extent_type = btrfs_file_extent_type(eb, fi);
+		fh = btrfs_item_ptr(eb, slot, struct btrfs_file_header);
+		extent_type = btrfs_file_header_type(eb, fh);
 		if (extent_type == BTRFS_FILE_EXTENT_INLINE)
 			continue;
 		/* don't skip BTRFS_FILE_EXTENT_PREALLOC, we can handle that */
-		disk_byte = btrfs_file_extent_disk_bytenr(eb, fi);
+		disk_byte = btrfs_file_header_disk_bytenr(eb, fh);
 		if (disk_byte != ctx->bytenr)
 			continue;
 
-		ret = check_extent_in_eb(ctx, &key, eb, fi, eie);
+		ret = check_extent_in_eb(ctx, &key, eb, fh, eie);
 		if (ret == BTRFS_ITERATE_EXTENT_INODES_STOP || ret < 0)
 			return ret;
 	}
@@ -475,7 +476,6 @@ static int add_all_parents(struct btrfs_backref_walk_ctx *ctx,
 	struct extent_buffer *eb;
 	struct btrfs_key key;
 	struct btrfs_key *key_for_search = &ref->key_for_search;
-	struct btrfs_file_extent_item *fi;
 	struct extent_inode_elem *eie = NULL, *old = NULL;
 	u64 disk_byte;
 	u64 wanted_disk_byte = ref->wanted_disk_byte;
@@ -512,6 +512,8 @@ static int add_all_parents(struct btrfs_backref_walk_ctx *ctx,
 	}
 
 	while (!ret && count < ref->count) {
+		struct btrfs_file_header *fh;
+
 		eb = path->nodes[0];
 		slot = path->slots[0];
 
@@ -535,12 +537,12 @@ static int add_all_parents(struct btrfs_backref_walk_ctx *ctx,
 				ret = btrfs_next_old_leaf(root, path, ctx->time_seq);
 			continue;
 		}
-		fi = btrfs_item_ptr(eb, slot, struct btrfs_file_extent_item);
-		type = btrfs_file_extent_type(eb, fi);
+		fh = btrfs_item_ptr(eb, slot, struct btrfs_file_header);
+		type = btrfs_file_header_type(eb, fh);
 		if (type == BTRFS_FILE_EXTENT_INLINE)
 			goto next;
-		disk_byte = btrfs_file_extent_disk_bytenr(eb, fi);
-		data_offset = btrfs_file_extent_offset(eb, fi);
+		disk_byte = btrfs_file_header_disk_bytenr(eb, fh);
+		data_offset = btrfs_file_header_offset(eb, fh);
 
 		if (disk_byte == wanted_disk_byte) {
 			eie = NULL;
@@ -550,7 +552,7 @@ static int add_all_parents(struct btrfs_backref_walk_ctx *ctx,
 			else
 				goto next;
 			if (!ctx->skip_inode_ref_list) {
-				ret = check_extent_in_eb(ctx, &key, eb, fi, &eie);
+				ret = check_extent_in_eb(ctx, &key, eb, fh, &eie);
 				if (ret == BTRFS_ITERATE_EXTENT_INODES_STOP ||
 				    ret < 0)
 					break;
diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index e859c4355f92..bd65f12b3766 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -3847,7 +3847,6 @@ static noinline int setup_leaf_for_split(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_key key;
 	struct extent_buffer *leaf;
-	struct btrfs_file_extent_item *fi;
 	u64 extent_len = 0;
 	u32 item_size;
 	int ret;
@@ -3864,9 +3863,11 @@ static noinline int setup_leaf_for_split(struct btrfs_trans_handle *trans,
 
 	item_size = btrfs_item_size(leaf, path->slots[0]);
 	if (key.type == BTRFS_EXTENT_DATA_KEY) {
-		fi = btrfs_item_ptr(leaf, path->slots[0],
-				    struct btrfs_file_extent_item);
-		extent_len = btrfs_file_extent_num_bytes(leaf, fi);
+		struct btrfs_file_header *fh;
+
+		fh = btrfs_item_ptr(leaf, path->slots[0],
+				    struct btrfs_file_header);
+		extent_len = btrfs_file_header_num_bytes(leaf, fh);
 	}
 	btrfs_release_path(path);
 
@@ -3890,9 +3891,11 @@ static noinline int setup_leaf_for_split(struct btrfs_trans_handle *trans,
 		goto err;
 
 	if (key.type == BTRFS_EXTENT_DATA_KEY) {
-		fi = btrfs_item_ptr(leaf, path->slots[0],
-				    struct btrfs_file_extent_item);
-		if (extent_len != btrfs_file_extent_num_bytes(leaf, fi))
+		struct btrfs_file_header *fh;
+
+		fh = btrfs_item_ptr(leaf, path->slots[0],
+				    struct btrfs_file_header);
+		if (extent_len != btrfs_file_header_num_bytes(leaf, fh))
 			goto err;
 	}
 
@@ -4063,18 +4066,18 @@ void btrfs_truncate_item(struct btrfs_trans_handle *trans,
 
 		if (btrfs_disk_key_type(&disk_key) == BTRFS_EXTENT_DATA_KEY) {
 			unsigned long ptr;
-			struct btrfs_file_extent_item *fi;
+			struct btrfs_file_header *fh;
 
-			fi = btrfs_item_ptr(leaf, slot,
-					    struct btrfs_file_extent_item);
-			fi = (struct btrfs_file_extent_item *)(
-			     (unsigned long)fi - size_diff);
+			fh = btrfs_item_ptr(leaf, slot,
+					    struct btrfs_file_header);
+			fh = (struct btrfs_file_header *)(
+			     (unsigned long)fh - size_diff);
 
-			if (btrfs_file_extent_type(leaf, fi) ==
+			if (btrfs_file_header_type(leaf, fh) ==
 			    BTRFS_FILE_EXTENT_INLINE) {
 				ptr = btrfs_item_ptr_offset(leaf, slot);
 				memmove_extent_buffer(leaf, ptr,
-				      (unsigned long)fi,
+				      (unsigned long)fh,
 				      sizeof(struct btrfs_file_header));
 			}
 		}
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 1dcd69fe97ed..fbb98f5e48a6 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2465,7 +2465,7 @@ static int __btrfs_mod_ref(struct btrfs_trans_handle *trans,
 	u64 ref_root;
 	u32 nritems;
 	struct btrfs_key key;
-	struct btrfs_file_extent_item *fi;
+	struct btrfs_file_header *fh;
 	bool for_reloc = btrfs_header_flag(buf, BTRFS_HEADER_FLAG_RELOC);
 	int i;
 	int action;
@@ -2502,19 +2502,19 @@ static int __btrfs_mod_ref(struct btrfs_trans_handle *trans,
 			btrfs_item_key_to_cpu(buf, &key, i);
 			if (key.type != BTRFS_EXTENT_DATA_KEY)
 				continue;
-			fi = btrfs_item_ptr(buf, i,
-					    struct btrfs_file_extent_item);
-			if (btrfs_file_extent_type(buf, fi) ==
+			fh = btrfs_item_ptr(buf, i,
+					    struct btrfs_file_header);
+			if (btrfs_file_header_type(buf, fh) ==
 			    BTRFS_FILE_EXTENT_INLINE)
 				continue;
-			ref.bytenr = btrfs_file_extent_disk_bytenr(buf, fi);
+			ref.bytenr = btrfs_file_header_disk_bytenr(buf, fh);
 			if (ref.bytenr == 0)
 				continue;
 
-			ref.num_bytes = btrfs_file_extent_disk_num_bytes(buf, fi);
+			ref.num_bytes = btrfs_file_header_disk_num_bytes(buf, fh);
 			ref.owning_root = ref_root;
 
-			key.offset -= btrfs_file_extent_offset(buf, fi);
+			key.offset -= btrfs_file_header_offset(buf, fh);
 			btrfs_init_data_ref(&ref, key.objectid, key.offset,
 					    btrfs_root_id(root), for_reloc);
 			if (inc)
@@ -2673,7 +2673,7 @@ static int __exclude_logged_extent(struct btrfs_fs_info *fs_info,
 int btrfs_exclude_logged_extents(struct extent_buffer *eb)
 {
 	struct btrfs_fs_info *fs_info = eb->fs_info;
-	struct btrfs_file_extent_item *item;
+	struct btrfs_file_header *header;
 	struct btrfs_key key;
 	int found_type;
 	int i;
@@ -2686,14 +2686,14 @@ int btrfs_exclude_logged_extents(struct extent_buffer *eb)
 		btrfs_item_key_to_cpu(eb, &key, i);
 		if (key.type != BTRFS_EXTENT_DATA_KEY)
 			continue;
-		item = btrfs_item_ptr(eb, i, struct btrfs_file_extent_item);
-		found_type = btrfs_file_extent_type(eb, item);
+		header = btrfs_item_ptr(eb, i, struct btrfs_file_header);
+		found_type = btrfs_file_header_type(eb, header);
 		if (found_type == BTRFS_FILE_EXTENT_INLINE)
 			continue;
-		if (btrfs_file_extent_disk_bytenr(eb, item) == 0)
+		if (btrfs_file_header_disk_bytenr(eb, header) == 0)
 			continue;
-		key.objectid = btrfs_file_extent_disk_bytenr(eb, item);
-		key.offset = btrfs_file_extent_disk_num_bytes(eb, item);
+		key.objectid = btrfs_file_header_disk_bytenr(eb, header);
+		key.offset = btrfs_file_header_disk_num_bytes(eb, header);
 		ret = __exclude_logged_extent(fs_info, key.objectid, key.offset);
 		if (ret)
 			break;
diff --git a/fs/btrfs/fiemap.c b/fs/btrfs/fiemap.c
index f2eaaef8422b..973ee6a89940 100644
--- a/fs/btrfs/fiemap.c
+++ b/fs/btrfs/fiemap.c
@@ -558,7 +558,7 @@ static int fiemap_find_last_extent_offset(struct btrfs_inode *inode,
 	const u64 ino = btrfs_ino(inode);
 	struct btrfs_root *root = inode->root;
 	struct extent_buffer *leaf;
-	struct btrfs_file_extent_item *ei;
+	struct btrfs_file_header *fh;
 	struct btrfs_key key;
 	u64 disk_bytenr;
 	int ret;
@@ -594,8 +594,8 @@ static int fiemap_find_last_extent_offset(struct btrfs_inode *inode,
 	 * so first check if we have an inline extent item before checking if we
 	 * have an implicit hole (disk_bytenr == 0).
 	 */
-	ei = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_file_extent_item);
-	if (btrfs_file_extent_type(leaf, ei) == BTRFS_FILE_EXTENT_INLINE) {
+	fh = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_file_header);
+	if (btrfs_file_header_type(leaf, fh) == BTRFS_FILE_EXTENT_INLINE) {
 		*last_extent_end_ret = btrfs_file_extent_end(path);
 		return 0;
 	}
@@ -607,7 +607,7 @@ static int fiemap_find_last_extent_offset(struct btrfs_inode *inode,
 	 * another hole file extent item as the last item in the previous leaf.
 	 * This is because we merge file extent items that represent holes.
 	 */
-	disk_bytenr = btrfs_file_extent_disk_bytenr(leaf, ei);
+	disk_bytenr = btrfs_file_header_disk_bytenr(leaf, fh);
 	while (disk_bytenr == 0) {
 		ret = btrfs_previous_item(root, path, ino, BTRFS_EXTENT_DATA_KEY);
 		if (ret < 0) {
@@ -618,9 +618,9 @@ static int fiemap_find_last_extent_offset(struct btrfs_inode *inode,
 			return 0;
 		}
 		leaf = path->nodes[0];
-		ei = btrfs_item_ptr(leaf, path->slots[0],
-				    struct btrfs_file_extent_item);
-		disk_bytenr = btrfs_file_extent_disk_bytenr(leaf, ei);
+		fh = btrfs_item_ptr(leaf, path->slots[0],
+				    struct btrfs_file_header);
+		disk_bytenr = btrfs_file_header_disk_bytenr(leaf, fh);
 	}
 
 	*last_extent_end_ret = btrfs_file_extent_end(path);
@@ -683,7 +683,7 @@ static int extent_fiemap(struct btrfs_inode *inode,
 
 	while (prev_extent_end < range_end) {
 		struct extent_buffer *leaf = path->nodes[0];
-		struct btrfs_file_extent_item *ei;
+		struct btrfs_file_header *fh;
 		struct btrfs_key key;
 		u64 extent_end;
 		u64 extent_len;
@@ -733,16 +733,16 @@ static int extent_fiemap(struct btrfs_inode *inode,
 		}
 
 		extent_len = extent_end - key.offset;
-		ei = btrfs_item_ptr(leaf, path->slots[0],
-				    struct btrfs_file_extent_item);
-		compression = btrfs_file_extent_compression(leaf, ei);
-		extent_type = btrfs_file_extent_type(leaf, ei);
-		extent_gen = btrfs_file_extent_generation(leaf, ei);
+		fh = btrfs_item_ptr(leaf, path->slots[0],
+				    struct btrfs_file_header);
+		compression = btrfs_file_header_compression(leaf, fh);
+		extent_type = btrfs_file_header_type(leaf, fh);
+		extent_gen = btrfs_file_header_generation(leaf, fh);
 
 		if (extent_type != BTRFS_FILE_EXTENT_INLINE) {
-			disk_bytenr = btrfs_file_extent_disk_bytenr(leaf, ei);
+			disk_bytenr = btrfs_file_header_disk_bytenr(leaf, fh);
 			if (compression == BTRFS_COMPRESS_NONE)
-				extent_offset = btrfs_file_extent_offset(leaf, ei);
+				extent_offset = btrfs_file_header_offset(leaf, fh);
 		}
 
 		if (compression != BTRFS_COMPRESS_NONE)
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 843fbf245ae8..7c5eb59b1e2e 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -1383,18 +1383,18 @@ u64 btrfs_file_extent_end(const struct btrfs_path *path)
 {
 	const struct extent_buffer *leaf = path->nodes[0];
 	const int slot = path->slots[0];
-	struct btrfs_file_extent_item *fi;
+	struct btrfs_file_header *fh;
 	struct btrfs_key key;
 	u64 end;
 
 	btrfs_item_key_to_cpu(leaf, &key, slot);
 	ASSERT(key.type == BTRFS_EXTENT_DATA_KEY);
-	fi = btrfs_item_ptr(leaf, slot, struct btrfs_file_extent_item);
+	fh = btrfs_item_ptr(leaf, slot, struct btrfs_file_header);
 
-	if (btrfs_file_extent_type(leaf, fi) == BTRFS_FILE_EXTENT_INLINE)
+	if (btrfs_file_header_type(leaf, fh) == BTRFS_FILE_EXTENT_INLINE)
 		end = leaf->fs_info->sectorsize;
 	else
-		end = key.offset + btrfs_file_extent_num_bytes(leaf, fi);
+		end = key.offset + btrfs_file_header_num_bytes(leaf, fh);
 
 	return end;
 }
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 14d393a5853d..57bbe2f67916 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -2180,7 +2180,6 @@ int btrfs_qgroup_trace_leaf_items(struct btrfs_trans_handle *trans,
 	int nr = btrfs_header_nritems(eb);
 	int i, extent_type, ret;
 	struct btrfs_key key;
-	struct btrfs_file_extent_item *fi;
 	u64 bytenr, num_bytes;
 
 	/* We can be called directly from walk_up_proc() */
@@ -2188,23 +2187,25 @@ int btrfs_qgroup_trace_leaf_items(struct btrfs_trans_handle *trans,
 		return 0;
 
 	for (i = 0; i < nr; i++) {
+		struct btrfs_file_header *fh;
+
 		btrfs_item_key_to_cpu(eb, &key, i);
 
 		if (key.type != BTRFS_EXTENT_DATA_KEY)
 			continue;
 
-		fi = btrfs_item_ptr(eb, i, struct btrfs_file_extent_item);
+		fh = btrfs_item_ptr(eb, i, struct btrfs_file_header);
 		/* filter out non qgroup-accountable extents  */
-		extent_type = btrfs_file_extent_type(eb, fi);
+		extent_type = btrfs_file_header_type(eb, fh);
 
 		if (extent_type == BTRFS_FILE_EXTENT_INLINE)
 			continue;
 
-		bytenr = btrfs_file_extent_disk_bytenr(eb, fi);
+		bytenr = btrfs_file_header_disk_bytenr(eb, fh);
 		if (!bytenr)
 			continue;
 
-		num_bytes = btrfs_file_extent_disk_num_bytes(eb, fi);
+		num_bytes = btrfs_file_header_disk_num_bytes(eb, fh);
 
 		ret = btrfs_qgroup_trace_extent(trans, bytenr, num_bytes);
 		if (ret)
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index 9f74d4ac920b..c755671b25c7 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -213,16 +213,16 @@ static int clone_copy_inline_extent(struct btrfs_inode *inode,
 			goto copy_to_page;
 		}
 	} else if (i_size_read(&inode->vfs_inode) <= datal) {
-		struct btrfs_file_extent_item *ei;
+		struct btrfs_file_header *fh;
 
-		ei = btrfs_item_ptr(path->nodes[0], path->slots[0],
-				    struct btrfs_file_extent_item);
+		fh = btrfs_item_ptr(path->nodes[0], path->slots[0],
+				    struct btrfs_file_header);
 		/*
 		 * If it's an inline extent replace it with the source inline
 		 * extent, otherwise copy the source inline extent data into
 		 * the respective page at the destination inode.
 		 */
-		if (btrfs_file_extent_type(path->nodes[0], ei) ==
+		if (btrfs_file_header_type(path->nodes[0], fh) ==
 		    BTRFS_FILE_EXTENT_INLINE)
 			goto copy_inline_extent;
 
@@ -369,7 +369,7 @@ static int btrfs_clone(struct inode *src, struct inode *inode,
 	key.offset = off;
 
 	while (1) {
-		struct btrfs_file_extent_item *extent;
+		struct btrfs_file_header *header;
 		u64 extent_gen;
 		int type;
 		u32 size;
@@ -416,20 +416,20 @@ static int btrfs_clone(struct inode *src, struct inode *inode,
 
 		ASSERT(key.type == BTRFS_EXTENT_DATA_KEY);
 
-		extent = btrfs_item_ptr(leaf, slot,
-					struct btrfs_file_extent_item);
-		extent_gen = btrfs_file_extent_generation(leaf, extent);
-		comp = btrfs_file_extent_compression(leaf, extent);
-		type = btrfs_file_extent_type(leaf, extent);
+		header = btrfs_item_ptr(leaf, slot,
+					struct btrfs_file_header);
+		extent_gen = btrfs_file_header_generation(leaf, header);
+		comp = btrfs_file_header_compression(leaf, header);
+		type = btrfs_file_header_type(leaf, header);
 		if (type == BTRFS_FILE_EXTENT_REG ||
 		    type == BTRFS_FILE_EXTENT_PREALLOC) {
-			disko = btrfs_file_extent_disk_bytenr(leaf, extent);
-			diskl = btrfs_file_extent_disk_num_bytes(leaf, extent);
-			datao = btrfs_file_extent_offset(leaf, extent);
-			datal = btrfs_file_extent_num_bytes(leaf, extent);
+			disko = btrfs_file_header_disk_bytenr(leaf, header);
+			diskl = btrfs_file_header_disk_num_bytes(leaf, header);
+			datao = btrfs_file_header_offset(leaf, header);
+			datal = btrfs_file_header_num_bytes(leaf, header);
 		} else if (type == BTRFS_FILE_EXTENT_INLINE) {
 			/* Take upper bound, may be compressed */
-			datal = btrfs_file_extent_ram_bytes(leaf, extent);
+			datal = btrfs_file_header_ram_bytes(leaf, header);
 		}
 
 		/*
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 310b7d817a27..46c6d74e2e2a 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -814,7 +814,7 @@ static int get_new_location(struct inode *reloc_inode, u64 *new_bytenr,
 {
 	struct btrfs_root *root = BTRFS_I(reloc_inode)->root;
 	BTRFS_PATH_AUTO_FREE(path);
-	struct btrfs_file_extent_item *fi;
+	struct btrfs_file_header *fh;
 	struct extent_buffer *leaf;
 	int ret;
 
@@ -831,18 +831,18 @@ static int get_new_location(struct inode *reloc_inode, u64 *new_bytenr,
 		return -ENOENT;
 
 	leaf = path->nodes[0];
-	fi = btrfs_item_ptr(leaf, path->slots[0],
-			    struct btrfs_file_extent_item);
+	fh = btrfs_item_ptr(leaf, path->slots[0],
+			    struct btrfs_file_header);
 
-	BUG_ON(btrfs_file_extent_offset(leaf, fi) ||
-	       btrfs_file_extent_compression(leaf, fi) ||
-	       btrfs_file_extent_encryption(leaf, fi) ||
-	       btrfs_file_extent_other_encoding(leaf, fi));
+	BUG_ON(btrfs_file_header_offset(leaf, fh) ||
+	       btrfs_file_header_compression(leaf, fh) ||
+	       btrfs_file_header_encryption(leaf, fh) ||
+	       btrfs_file_header_other_encoding(leaf, fh));
 
-	if (num_bytes != btrfs_file_extent_disk_num_bytes(leaf, fi))
+	if (num_bytes != btrfs_file_header_disk_num_bytes(leaf, fh))
 		return -EINVAL;
 
-	*new_bytenr = btrfs_file_extent_disk_bytenr(leaf, fi);
+	*new_bytenr = btrfs_file_header_disk_bytenr(leaf, fh);
 	return 0;
 }
 
@@ -858,7 +858,6 @@ int replace_file_extents(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_key key;
-	struct btrfs_file_extent_item *fi;
 	struct btrfs_inode *inode = NULL;
 	u64 parent;
 	u64 bytenr;
@@ -881,18 +880,19 @@ int replace_file_extents(struct btrfs_trans_handle *trans,
 
 	nritems = btrfs_header_nritems(leaf);
 	for (i = 0; i < nritems; i++) {
+		struct btrfs_file_header *fh;
 		struct btrfs_ref ref = { 0 };
 
 		cond_resched();
 		btrfs_item_key_to_cpu(leaf, &key, i);
 		if (key.type != BTRFS_EXTENT_DATA_KEY)
 			continue;
-		fi = btrfs_item_ptr(leaf, i, struct btrfs_file_extent_item);
-		if (btrfs_file_extent_type(leaf, fi) ==
+		fh = btrfs_item_ptr(leaf, i, struct btrfs_file_header);
+		if (btrfs_file_header_type(leaf, fh) ==
 		    BTRFS_FILE_EXTENT_INLINE)
 			continue;
-		bytenr = btrfs_file_extent_disk_bytenr(leaf, fi);
-		num_bytes = btrfs_file_extent_disk_num_bytes(leaf, fi);
+		bytenr = btrfs_file_header_disk_bytenr(leaf, fh);
+		num_bytes = btrfs_file_header_disk_num_bytes(leaf, fh);
 		if (bytenr == 0)
 			continue;
 		if (!in_range(bytenr, rc->block_group->start,
@@ -915,7 +915,7 @@ int replace_file_extents(struct btrfs_trans_handle *trans,
 				struct extent_state *cached_state = NULL;
 
 				end = key.offset +
-				      btrfs_file_extent_num_bytes(leaf, fi);
+				      btrfs_file_header_num_bytes(leaf, fh);
 				WARN_ON(!IS_ALIGNED(key.offset,
 						    fs_info->sectorsize));
 				WARN_ON(!IS_ALIGNED(end, fs_info->sectorsize));
@@ -947,9 +947,9 @@ int replace_file_extents(struct btrfs_trans_handle *trans,
 			break;
 		}
 
-		btrfs_set_file_extent_disk_bytenr(leaf, fi, new_bytenr);
+		btrfs_set_file_header_disk_bytenr(leaf, fh, new_bytenr);
 
-		key.offset -= btrfs_file_extent_offset(leaf, fi);
+		key.offset -= btrfs_file_header_offset(leaf, fh);
 		ref.action = BTRFS_ADD_DELAYED_REF;
 		ref.bytenr = new_bytenr;
 		ref.num_bytes = num_bytes;
@@ -3250,7 +3250,6 @@ static int delete_v1_space_cache(struct extent_buffer *leaf,
 				 u64 data_bytenr)
 {
 	u64 space_cache_ino;
-	struct btrfs_file_extent_item *ei;
 	struct btrfs_key key;
 	bool found = false;
 	int i;
@@ -3259,17 +3258,18 @@ static int delete_v1_space_cache(struct extent_buffer *leaf,
 		return 0;
 
 	for (i = 0; i < btrfs_header_nritems(leaf); i++) {
+		struct btrfs_file_header *fh;
 		u8 type;
 
 		btrfs_item_key_to_cpu(leaf, &key, i);
 		if (key.type != BTRFS_EXTENT_DATA_KEY)
 			continue;
-		ei = btrfs_item_ptr(leaf, i, struct btrfs_file_extent_item);
-		type = btrfs_file_extent_type(leaf, ei);
+		fh = btrfs_item_ptr(leaf, i, struct btrfs_file_header);
+		type = btrfs_file_header_type(leaf, fh);
 
 		if ((type == BTRFS_FILE_EXTENT_REG ||
 		     type == BTRFS_FILE_EXTENT_PREALLOC) &&
-		    btrfs_file_extent_disk_bytenr(leaf, ei) == data_bytenr) {
+		    btrfs_file_header_disk_bytenr(leaf, fh) == data_bytenr) {
 			found = true;
 			space_cache_ino = key.objectid;
 			break;
-- 
2.52.0


