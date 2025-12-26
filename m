Return-Path: <linux-btrfs+bounces-20014-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F04DCDE573
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Dec 2025 06:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA1E13014A31
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Dec 2025 05:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FAA0245020;
	Fri, 26 Dec 2025 05:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="iRAc1Vrk";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="eOnpFiyQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13D623D7E6
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Dec 2025 05:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766726009; cv=none; b=C9z4tEJXSjP8Z9PPuYEyXc74wq6vytdWNbdLzUEU4rVk0G9HU2D211CoH5aT7xBBYXVACfDvtQv9FyNYKXb/lRRbmNRYC6s09hMhlaN+uKy0WSY5nyn88YUqZ9ZdzOPoPUUfkO/ZwNIrJmyuWS5d3Wx48kkWWPDAn+ZFsbbaNdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766726009; c=relaxed/simple;
	bh=t1AVY7LfNQSYT89HFQZL0cNg3grVyBSKdaGgERRj5pU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yhtud4jdp9TgVVbjQVAtU1ziZW/tvBzeOzE0c57lh4mqoFjgGaZc6ZKFmuAkCRuNtudKJA+e1pf64LWgaoIjM9deRyuG33JJSlH00HdgaIckqaA/3vdcxHjoPfJjsg9nKpyglZuNHvnnO+jvGMSXlDILUtRjLudGf061uF+QPrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=iRAc1Vrk; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=eOnpFiyQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E89AA5BD12
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Dec 2025 05:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1766726000; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mi/xAbvz61GXAkYVmrxS46i93rNhcXxDaXhy9djvZhk=;
	b=iRAc1VrkmvVjtAULyk/90mA0yPI81w0VT7XRJsKjzqYdafm6EweYyE56RKDuLUA7ZYrmBQ
	MoMAk5rONEXNC8IjYPFO7rH717r6WM1qjl6d/BpbFDB8N8fBHJMgHZs4QYEuhFdLooElfN
	ZWm3aXls+8Fz+4UTiBIp0xza+9TEo7E=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=eOnpFiyQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1766725999; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mi/xAbvz61GXAkYVmrxS46i93rNhcXxDaXhy9djvZhk=;
	b=eOnpFiyQUAI0mpwSIDciNNKQedVty1Godd/mP1Qi2CqMO1h9w94pMDJHf7LZq3AXNgU7IS
	JCA64LqF29MHLt/8iWG1QewC/thegW6C9GPKmoT6Dm3EkbdOoDmwuRApWSSq0yLatCS7sk
	zPs6cVppXj3TPDTTFFevysIQFrH7Sz8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 307A83EA63
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Dec 2025 05:13:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aJf+OG4ZTmn1DQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Dec 2025 05:13:18 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/7] btrfs: use btrfs_file_header structure for trace events
Date: Fri, 26 Dec 2025 15:42:49 +1030
Message-ID: <e44669eb99c0df2b1ee1f218c3df44bb0bfffd27.1766725912.git.wqu@suse.com>
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
X-Spam-Score: -3.01
X-Rspamd-Queue-Id: E89AA5BD12
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-0.994];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	URIBL_BLOCKED(0.00)[suse.com:mid,suse.com:dkim,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Level: 

The trace event class btrfs__file_extent_item_* can benefit from
the extra strict checks from btrfs_file_header structure.

This change involves the following call sites:

- defrag_get_extent()
  Move the btrfs_file_header pointer to the nearest scope of usage.
  This reduces the lifespan of such variable.

- Rename btrfs_extent_item_to_extent_map()
  To btrfs_file_header_to_extent_map(), and accept a btrfs_file_header
  pointer instead.

- Make btrfs_trace_truncate() to accept a btrfs_file_header pointer
  And do the proper type casting for non-inline extents.

- btrfs_truncate_inode_items()
  This is a little tricky related to scope change of btrfs_file_header.

  The original loop always initialize @fi to NULL for each loop, and
  assign it when hitting a BTRFS_EXTENT_DATA_KEY.

  But if we didn't hit an BTRFS_EXTENT_DATA_KEY then we exit the loop.
  So we do not need to define @fi inside the function, can move it into
  the while (1) loop, and only initialize it after we hitting an
  BTRFS_EXTENT_DATA_KEY.

- btrfs_get_extent()
  Pretty straightforward.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/defrag.c            |  8 ++---
 fs/btrfs/file-item.c         | 18 +++++------
 fs/btrfs/file-item.h         |  4 +--
 fs/btrfs/inode-item.c        | 45 +++++++++++++---------------
 fs/btrfs/inode.c             | 13 ++++----
 include/trace/events/btrfs.h | 58 ++++++++++++++++++------------------
 6 files changed, 71 insertions(+), 75 deletions(-)

diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index bcc6656ad034..37516d2937fa 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -608,7 +608,7 @@ static struct extent_map *defrag_get_extent(struct btrfs_inode *inode,
 					    u64 start, u64 newer_than)
 {
 	struct btrfs_root *root = inode->root;
-	struct btrfs_file_extent_item *fi;
+	struct btrfs_file_header *fh;
 	BTRFS_PATH_AUTO_RELEASE(path);
 	struct extent_map *em;
 	struct btrfs_key key;
@@ -697,8 +697,8 @@ static struct extent_map *defrag_get_extent(struct btrfs_inode *inode,
 			break;
 		}
 
-		fi = btrfs_item_ptr(path.nodes[0], path.slots[0],
-				    struct btrfs_file_extent_item);
+		fh = btrfs_item_ptr(path.nodes[0], path.slots[0],
+				    struct btrfs_file_header);
 		extent_end = btrfs_file_extent_end(&path);
 
 		/*
@@ -711,7 +711,7 @@ static struct extent_map *defrag_get_extent(struct btrfs_inode *inode,
 			goto next;
 
 		/* Now this extent covers @start, convert it to em */
-		btrfs_extent_item_to_extent_map(inode, &path, fi, em);
+		btrfs_file_header_to_extent_map(inode, &path, fh, em);
 		break;
 next:
 		ret = btrfs_next_item(root, &path);
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 568f0e0ebdf6..843fbf245ae8 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -1311,9 +1311,9 @@ int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
-void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
+void btrfs_file_header_to_extent_map(struct btrfs_inode *inode,
 				     const struct btrfs_path *path,
-				     const struct btrfs_file_extent_item *fi,
+				     const struct btrfs_file_header *fh,
 				     struct extent_map *em)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
@@ -1322,16 +1322,16 @@ void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
 	const int slot = path->slots[0];
 	struct btrfs_key key;
 	u64 extent_start;
-	u8 type = btrfs_file_extent_type(leaf, fi);
-	int compress_type = btrfs_file_extent_compression(leaf, fi);
+	u8 type = btrfs_file_header_type(leaf, fh);
+	int compress_type = btrfs_file_header_compression(leaf, fh);
 
 	btrfs_item_key_to_cpu(leaf, &key, slot);
 	extent_start = key.offset;
-	em->ram_bytes = btrfs_file_extent_ram_bytes(leaf, fi);
-	em->generation = btrfs_file_extent_generation(leaf, fi);
+	em->ram_bytes = btrfs_file_header_ram_bytes(leaf, fh);
+	em->generation = btrfs_file_header_generation(leaf, fh);
 	if (type == BTRFS_FILE_EXTENT_REG ||
 	    type == BTRFS_FILE_EXTENT_PREALLOC) {
-		const u64 disk_bytenr = btrfs_file_extent_disk_bytenr(leaf, fi);
+		const u64 disk_bytenr = btrfs_file_header_disk_bytenr(leaf, fh);
 
 		em->start = extent_start;
 		em->len = btrfs_file_extent_end(path) - extent_start;
@@ -1342,8 +1342,8 @@ void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
 			return;
 		}
 		em->disk_bytenr = disk_bytenr;
-		em->disk_num_bytes = btrfs_file_extent_disk_num_bytes(leaf, fi);
-		em->offset = btrfs_file_extent_offset(leaf, fi);
+		em->disk_num_bytes = btrfs_file_header_disk_num_bytes(leaf, fh);
+		em->offset = btrfs_file_header_offset(leaf, fh);
 		if (compress_type != BTRFS_COMPRESS_NONE) {
 			btrfs_extent_map_set_compression(em, compress_type);
 		} else {
diff --git a/fs/btrfs/file-item.h b/fs/btrfs/file-item.h
index 1394ae33fc6d..548d02595a6c 100644
--- a/fs/btrfs/file-item.h
+++ b/fs/btrfs/file-item.h
@@ -71,9 +71,9 @@ int btrfs_lookup_csums_list(struct btrfs_root *root, u64 start, u64 end,
 int btrfs_lookup_csums_bitmap(struct btrfs_root *root, struct btrfs_path *path,
 			      u64 start, u64 end, u8 *csum_buf,
 			      unsigned long *csum_bitmap);
-void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
+void btrfs_file_header_to_extent_map(struct btrfs_inode *inode,
 				     const struct btrfs_path *path,
-				     const struct btrfs_file_extent_item *fi,
+				     const struct btrfs_file_header *fh,
 				     struct extent_map *em);
 int btrfs_inode_clear_file_extent_range(struct btrfs_inode *inode, u64 start,
 					u64 len);
diff --git a/fs/btrfs/inode-item.c b/fs/btrfs/inode-item.c
index a864f8c99729..19a00104dc6f 100644
--- a/fs/btrfs/inode-item.c
+++ b/fs/btrfs/inode-item.c
@@ -408,16 +408,16 @@ int btrfs_lookup_inode(struct btrfs_trans_handle *trans, struct btrfs_root
 
 static inline void btrfs_trace_truncate(const struct btrfs_inode *inode,
 					const struct extent_buffer *leaf,
-					const struct btrfs_file_extent_item *fi,
+					const struct btrfs_file_header *fh,
 					u64 offset, int extent_type, int slot)
 {
 	if (!inode)
 		return;
 	if (extent_type == BTRFS_FILE_EXTENT_INLINE)
-		trace_btrfs_truncate_show_fi_inline(inode, leaf, fi, slot,
+		trace_btrfs_truncate_show_fi_inline(inode, leaf, fh, slot,
 						    offset);
 	else
-		trace_btrfs_truncate_show_fi_regular(inode, leaf, fi, offset);
+		trace_btrfs_truncate_show_fi_regular(inode, leaf, fh, offset);
 }
 
 /*
@@ -445,7 +445,6 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	BTRFS_PATH_AUTO_FREE(path);
 	struct extent_buffer *leaf;
-	struct btrfs_file_extent_item *fi;
 	struct btrfs_key key;
 	struct btrfs_key found_key;
 	u64 new_size = control->new_size;
@@ -508,10 +507,10 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 	}
 
 	while (1) {
+		struct btrfs_file_header *fh;
 		u64 clear_start = 0, clear_len = 0, extent_start = 0;
 		bool refill_delayed_refs_rsv = false;
 
-		fi = NULL;
 		leaf = path->nodes[0];
 		btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
 		found_type = found_key.type;
@@ -524,16 +523,15 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 
 		item_end = found_key.offset;
 		if (found_type == BTRFS_EXTENT_DATA_KEY) {
-			fi = btrfs_item_ptr(leaf, path->slots[0],
-					    struct btrfs_file_extent_item);
-			extent_type = btrfs_file_extent_type(leaf, fi);
+			fh = btrfs_item_ptr(leaf, path->slots[0],
+					    struct btrfs_file_header);
+			extent_type = btrfs_file_header_type(leaf, fh);
 			if (extent_type != BTRFS_FILE_EXTENT_INLINE)
-				item_end +=
-				    btrfs_file_extent_num_bytes(leaf, fi);
+				item_end += btrfs_file_header_num_bytes(leaf, fh);
 			else if (extent_type == BTRFS_FILE_EXTENT_INLINE)
-				item_end += btrfs_file_extent_ram_bytes(leaf, fi);
+				item_end += btrfs_file_header_ram_bytes(leaf, fh);
 
-			btrfs_trace_truncate(control->inode, leaf, fi,
+			btrfs_trace_truncate(control->inode, leaf, fh,
 					     found_key.offset, extent_type,
 					     path->slots[0]);
 			item_end--;
@@ -559,28 +557,27 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 			u64 num_dec;
 
 			clear_start = found_key.offset;
-			extent_start = btrfs_file_extent_disk_bytenr(leaf, fi);
+			extent_start = btrfs_file_header_disk_bytenr(leaf, fh);
 			if (!del_item) {
 				u64 orig_num_bytes =
-					btrfs_file_extent_num_bytes(leaf, fi);
+					btrfs_file_header_num_bytes(leaf, fh);
 				extent_num_bytes = ALIGN(new_size -
 						found_key.offset,
 						fs_info->sectorsize);
 				clear_start = ALIGN(new_size, fs_info->sectorsize);
 
-				btrfs_set_file_extent_num_bytes(leaf, fi,
-							 extent_num_bytes);
+				btrfs_set_file_header_num_bytes(leaf, fh,
+								extent_num_bytes);
 				num_dec = (orig_num_bytes - extent_num_bytes);
 				if (extent_start != 0)
 					control->sub_bytes += num_dec;
 			} else {
 				extent_num_bytes =
-					btrfs_file_extent_disk_num_bytes(leaf, fi);
+					btrfs_file_header_disk_num_bytes(leaf, fh);
 				extent_offset = found_key.offset -
-					btrfs_file_extent_offset(leaf, fi);
+					btrfs_file_header_offset(leaf, fh);
 
-				/* FIXME blocksize != 4096 */
-				num_dec = btrfs_file_extent_num_bytes(leaf, fi);
+				num_dec = btrfs_file_header_num_bytes(leaf, fh);
 				if (extent_start != 0)
 					control->sub_bytes += num_dec;
 			}
@@ -591,12 +588,12 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 			 * special encodings
 			 */
 			if (!del_item &&
-			    btrfs_file_extent_encryption(leaf, fi) == 0 &&
-			    btrfs_file_extent_other_encoding(leaf, fi) == 0 &&
-			    btrfs_file_extent_compression(leaf, fi) == 0) {
+			    btrfs_file_header_encryption(leaf, fh) == 0 &&
+			    btrfs_file_header_other_encoding(leaf, fh) == 0 &&
+			    btrfs_file_header_compression(leaf, fh) == 0) {
 				u32 size = (u32)(new_size - found_key.offset);
 
-				btrfs_set_file_extent_ram_bytes(leaf, fi, size);
+				btrfs_set_file_header_ram_bytes(leaf, fh, size);
 				size = btrfs_file_extent_calc_inline_size(size);
 				btrfs_truncate_item(trans, path, size, 1);
 			} else if (!del_item) {
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index e12a1daf3474..127f9e7ef453 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7147,7 +7147,7 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 	int extent_type = -1;
 	struct btrfs_path *path = NULL;
 	struct btrfs_root *root = inode->root;
-	struct btrfs_file_extent_item *item;
+	struct btrfs_file_header *header;
 	struct extent_buffer *leaf;
 	struct btrfs_key found_key;
 	struct extent_map *em = NULL;
@@ -7204,8 +7204,7 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 	}
 
 	leaf = path->nodes[0];
-	item = btrfs_item_ptr(leaf, path->slots[0],
-			      struct btrfs_file_extent_item);
+	header = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_file_header);
 	btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
 	if (found_key.objectid != objectid ||
 	    found_key.type != BTRFS_EXTENT_DATA_KEY) {
@@ -7219,7 +7218,7 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 		goto next;
 	}
 
-	extent_type = btrfs_file_extent_type(leaf, item);
+	extent_type = btrfs_file_header_type(leaf, header);
 	extent_start = found_key.offset;
 	extent_end = btrfs_file_extent_end(path);
 	if (extent_type == BTRFS_FILE_EXTENT_REG ||
@@ -7232,10 +7231,10 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 				   btrfs_ino(inode));
 			goto out;
 		}
-		trace_btrfs_get_extent_show_fi_regular(inode, leaf, item,
+		trace_btrfs_get_extent_show_fi_regular(inode, leaf, header,
 						       extent_start);
 	} else if (extent_type == BTRFS_FILE_EXTENT_INLINE) {
-		trace_btrfs_get_extent_show_fi_inline(inode, leaf, item,
+		trace_btrfs_get_extent_show_fi_inline(inode, leaf, header,
 						      path->slots[0],
 						      extent_start);
 	}
@@ -7267,7 +7266,7 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 		goto insert;
 	}
 
-	btrfs_extent_item_to_extent_map(inode, path, item, em);
+	btrfs_file_header_to_extent_map(inode, path, header, em);
 
 	if (extent_type == BTRFS_FILE_EXTENT_REG ||
 	    extent_type == BTRFS_FILE_EXTENT_PREALLOC) {
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index 125bdc166bfe..75166fb6738b 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -13,7 +13,7 @@ struct btrfs_root;
 struct btrfs_fs_info;
 struct btrfs_inode;
 struct extent_map;
-struct btrfs_file_extent_item;
+struct btrfs_file_header;
 struct btrfs_ordered_extent;
 struct btrfs_delayed_ref_node;
 struct btrfs_delayed_ref_head;
@@ -352,12 +352,12 @@ TRACE_EVENT(btrfs_handle_em_exist,
 );
 
 /* file extent item */
-DECLARE_EVENT_CLASS(btrfs__file_extent_item_regular,
+DECLARE_EVENT_CLASS(btrfs__file_header_regular,
 
 	TP_PROTO(const struct btrfs_inode *bi, const struct extent_buffer *l,
-		 const struct btrfs_file_extent_item *fi, u64 start),
+		 const struct btrfs_file_header *fh, u64 start),
 
-	TP_ARGS(bi, l, fi, start),
+	TP_ARGS(bi, l, fh, start),
 
 	TP_STRUCT__entry_btrfs(
 		__field(	u64,	root_obj	)
@@ -380,13 +380,13 @@ DECLARE_EVENT_CLASS(btrfs__file_extent_item_regular,
 		__entry->ino		= btrfs_ino(bi);
 		__entry->isize		= bi->vfs_inode.i_size;
 		__entry->disk_isize	= bi->disk_i_size;
-		__entry->num_bytes	= btrfs_file_extent_num_bytes(l, fi);
-		__entry->ram_bytes	= btrfs_file_extent_ram_bytes(l, fi);
-		__entry->disk_bytenr	= btrfs_file_extent_disk_bytenr(l, fi);
-		__entry->disk_num_bytes	= btrfs_file_extent_disk_num_bytes(l, fi);
-		__entry->extent_offset	= btrfs_file_extent_offset(l, fi);
-		__entry->extent_type	= btrfs_file_extent_type(l, fi);
-		__entry->compression	= btrfs_file_extent_compression(l, fi);
+		__entry->num_bytes	= btrfs_file_header_num_bytes(l, fh);
+		__entry->ram_bytes	= btrfs_file_header_ram_bytes(l, fh);
+		__entry->disk_bytenr	= btrfs_file_header_disk_bytenr(l, fh);
+		__entry->disk_num_bytes	= btrfs_file_header_disk_num_bytes(l, fh);
+		__entry->extent_offset	= btrfs_file_header_offset(l, fh);
+		__entry->extent_type	= btrfs_file_header_type(l, fh);
+		__entry->compression	= btrfs_file_header_compression(l, fh);
 		__entry->extent_start	= start;
 		__entry->extent_end	= (start + __entry->num_bytes);
 	),
@@ -407,12 +407,12 @@ DECLARE_EVENT_CLASS(btrfs__file_extent_item_regular,
 );
 
 DECLARE_EVENT_CLASS(
-	btrfs__file_extent_item_inline,
+	btrfs__file_header_inline,
 
 	TP_PROTO(const struct btrfs_inode *bi, const struct extent_buffer *l,
-		 const struct btrfs_file_extent_item *fi, int slot, u64 start),
+		 const struct btrfs_file_header *fh, int slot, u64 start),
 
-	TP_ARGS(bi, l, fi, slot,  start),
+	TP_ARGS(bi, l, fh, slot,  start),
 
 	TP_STRUCT__entry_btrfs(
 		__field(	u64,	root_obj	)
@@ -431,10 +431,10 @@ DECLARE_EVENT_CLASS(
 		__entry->ino		= btrfs_ino(bi);
 		__entry->isize		= bi->vfs_inode.i_size;
 		__entry->disk_isize	= bi->disk_i_size;
-		__entry->extent_type	= btrfs_file_extent_type(l, fi);
-		__entry->compression	= btrfs_file_extent_compression(l, fi);
+		__entry->extent_type	= btrfs_file_header_type(l, fh);
+		__entry->compression	= btrfs_file_header_compression(l, fh);
 		__entry->extent_start	= start;
-		__entry->extent_end	= (start + btrfs_file_extent_ram_bytes(l, fi));
+		__entry->extent_end	= (start + btrfs_file_header_ram_bytes(l, fh));
 	),
 
 	TP_printk_btrfs(
@@ -448,39 +448,39 @@ DECLARE_EVENT_CLASS(
 );
 
 DEFINE_EVENT(
-	btrfs__file_extent_item_regular, btrfs_get_extent_show_fi_regular,
+	btrfs__file_header_regular, btrfs_get_extent_show_fi_regular,
 
 	TP_PROTO(const struct btrfs_inode *bi, const struct extent_buffer *l,
-		 const struct btrfs_file_extent_item *fi, u64 start),
+		 const struct btrfs_file_header *fh, u64 start),
 
-	TP_ARGS(bi, l, fi, start)
+	TP_ARGS(bi, l, fh, start)
 );
 
 DEFINE_EVENT(
-	btrfs__file_extent_item_regular, btrfs_truncate_show_fi_regular,
+	btrfs__file_header_regular, btrfs_truncate_show_fi_regular,
 
 	TP_PROTO(const struct btrfs_inode *bi, const struct extent_buffer *l,
-		 const struct btrfs_file_extent_item *fi, u64 start),
+		 const struct btrfs_file_header *fh, u64 start),
 
-	TP_ARGS(bi, l, fi, start)
+	TP_ARGS(bi, l, fh, start)
 );
 
 DEFINE_EVENT(
-	btrfs__file_extent_item_inline, btrfs_get_extent_show_fi_inline,
+	btrfs__file_header_inline, btrfs_get_extent_show_fi_inline,
 
 	TP_PROTO(const struct btrfs_inode *bi, const struct extent_buffer *l,
-		 const struct btrfs_file_extent_item *fi, int slot, u64 start),
+		 const struct btrfs_file_header *fh, int slot, u64 start),
 
-	TP_ARGS(bi, l, fi, slot, start)
+	TP_ARGS(bi, l, fh, slot, start)
 );
 
 DEFINE_EVENT(
-	btrfs__file_extent_item_inline, btrfs_truncate_show_fi_inline,
+	btrfs__file_header_inline, btrfs_truncate_show_fi_inline,
 
 	TP_PROTO(const struct btrfs_inode *bi, const struct extent_buffer *l,
-		 const struct btrfs_file_extent_item *fi, int slot, u64 start),
+		 const struct btrfs_file_header *fh, int slot, u64 start),
 
-	TP_ARGS(bi, l, fi, slot, start)
+	TP_ARGS(bi, l, fh, slot, start)
 );
 
 #define show_ordered_flags(flags)					   \
-- 
2.52.0


