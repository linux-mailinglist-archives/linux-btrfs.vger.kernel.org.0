Return-Path: <linux-btrfs+bounces-20018-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 152D1CDE57C
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Dec 2025 06:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CFCD03011194
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Dec 2025 05:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098A92417F2;
	Fri, 26 Dec 2025 05:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fl5FJk9S";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fl5FJk9S"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE1523D7E6
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Dec 2025 05:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766726032; cv=none; b=np5gFba8z06uI3W2CUkxNE51Ko5hp/nzzprR1bnRkuKyGchdpPagXQsr3ECHHsSNVcUsyzNDg0x1SBsQfiKCzti514ojhXAiBxv8tLM+YXkDnS2fe7XfE8Y63KiE1Zlgw40RUimhmR4jAsYFK3OwP8KLt39uy+8lSmX9roEVmY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766726032; c=relaxed/simple;
	bh=DTJMqNiYojdGdMgPIYlT1nAcFEZcGtLnE2tRjG7owMw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ehg6rUP0Mr0D+eWxj9XK59+HOsFScwhgglrrZ3QbJi0jkxqRs1fvRgF7gxELDh+jv6Wy76oX8+CcL0Hcbt/T/ZJbrR4OErezzBqT+FuQAM7zyJPCqlBAsZR6HFRceRt5Bymohnt4OUHiHBliofTVzce71KhJefpvR7NhL04xu+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fl5FJk9S; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fl5FJk9S; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0AD8F3371F
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Dec 2025 05:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1766726005; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IY99QxZIYby0qYKDKvpmhzg39GlAuu3ktFyVK3S8Reo=;
	b=fl5FJk9STIm9GYyYOkhx0uU4CClISNE6JThAx6yfN9fgl/I53fq7mPSaJsb/ZP4Uh3T9P+
	U8WYG6OIAkXzHcqtjhpDTpLTxa2ThpEYkAnf2od+11lKzzJO414EBll4190tbKjWPxwm8g
	1A+S7kBg15ulZ3I3f0abB4PSVpJxZds=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1766726005; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IY99QxZIYby0qYKDKvpmhzg39GlAuu3ktFyVK3S8Reo=;
	b=fl5FJk9STIm9GYyYOkhx0uU4CClISNE6JThAx6yfN9fgl/I53fq7mPSaJsb/ZP4Uh3T9P+
	U8WYG6OIAkXzHcqtjhpDTpLTxa2ThpEYkAnf2od+11lKzzJO414EBll4190tbKjWPxwm8g
	1A+S7kBg15ulZ3I3f0abB4PSVpJxZds=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 494823EA63
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Dec 2025 05:13:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uOFxA3QZTmn1DQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Dec 2025 05:13:24 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 7/7] btrfs: use btrfs_file_header structure for send.c and tree-log.c
Date: Fri, 26 Dec 2025 15:42:53 +1030
Message-ID: <5080bd24c806cf25305d65b8eeee69dde890154c.1766725912.git.wqu@suse.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]

Mostly a straightforward conversion, some minor notes:

- Some hidden existing btrfs_file_extent_item::type checks
  There are some call sites that are grabbing @disk_bytenr without
  checking the @type.

  That's because it's already done by the caller.

- Some sizeof(*item) usage
  For those call sites inside replay_one_extent(), we have already
  checked the type is not INLINE, thus it's the full
  btrfs_file_extent_item structure.

  We must keep the old size, not using the sizeof(*header).

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/send.c     | 117 ++++++++++++++++++++++----------------------
 fs/btrfs/tree-log.c |  70 +++++++++++++-------------
 2 files changed, 93 insertions(+), 94 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 95b8722cb76e..4f8888cb4f35 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -1554,7 +1554,7 @@ static int find_extent_clone(struct send_ctx *sctx,
 	int extent_type;
 	u64 disk_byte;
 	u64 num_bytes;
-	struct btrfs_file_extent_item *fi;
+	struct btrfs_file_header *fh;
 	struct extent_buffer *eb = path->nodes[0];
 	struct backref_ctx backref_ctx = { 0 };
 	struct btrfs_backref_walk_ctx backref_walk_ctx = { 0 };
@@ -1571,17 +1571,17 @@ static int find_extent_clone(struct send_ctx *sctx,
 	if (data_offset >= ino_size)
 		return 0;
 
-	fi = btrfs_item_ptr(eb, path->slots[0], struct btrfs_file_extent_item);
-	extent_type = btrfs_file_extent_type(eb, fi);
+	fh = btrfs_item_ptr(eb, path->slots[0], struct btrfs_file_header);
+	extent_type = btrfs_file_header_type(eb, fh);
 	if (extent_type == BTRFS_FILE_EXTENT_INLINE)
 		return -ENOENT;
 
-	disk_byte = btrfs_file_extent_disk_bytenr(eb, fi);
+	disk_byte = btrfs_file_header_disk_bytenr(eb, fh);
 	if (disk_byte == 0)
 		return -ENOENT;
 
-	compressed = btrfs_file_extent_compression(eb, fi);
-	num_bytes = btrfs_file_extent_num_bytes(eb, fi);
+	compressed = btrfs_file_header_compression(eb, fh);
+	num_bytes = btrfs_file_header_num_bytes(eb, fh);
 
 	/*
 	 * Setup the clone roots.
@@ -1603,7 +1603,7 @@ static int find_extent_clone(struct send_ctx *sctx,
 	 * snapshot we can have shared subtrees.
 	 */
 	backref_ctx.backref_owner = btrfs_header_owner(eb);
-	backref_ctx.backref_offset = data_offset - btrfs_file_extent_offset(eb, fi);
+	backref_ctx.backref_offset = data_offset - btrfs_file_header_offset(eb, fh);
 
 	/*
 	 * The last extent of a file may be too large due to page alignment.
@@ -1620,7 +1620,7 @@ static int find_extent_clone(struct send_ctx *sctx,
 	 */
 	backref_walk_ctx.bytenr = disk_byte;
 	if (compressed == BTRFS_COMPRESS_NONE)
-		backref_walk_ctx.extent_item_pos = btrfs_file_extent_offset(eb, fi);
+		backref_walk_ctx.extent_item_pos = btrfs_file_header_offset(eb, fh);
 	backref_walk_ctx.fs_info = fs_info;
 	backref_walk_ctx.cache_lookup = lookup_backref_cache;
 	backref_walk_ctx.cache_store = store_backref_cache;
@@ -5533,7 +5533,7 @@ static int send_encoded_extent(struct send_ctx *sctx, struct btrfs_path *path,
 	struct fs_path *fspath;
 	struct extent_buffer *leaf = path->nodes[0];
 	struct btrfs_key key;
-	struct btrfs_file_extent_item *ei;
+	struct btrfs_file_header *fh;
 	u64 disk_bytenr, disk_num_bytes;
 	u32 data_offset;
 	struct btrfs_cmd_header *hdr;
@@ -5555,21 +5555,21 @@ static int send_encoded_extent(struct send_ctx *sctx, struct btrfs_path *path,
 		goto out;
 
 	btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
-	ei = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_file_extent_item);
-	disk_bytenr = btrfs_file_extent_disk_bytenr(leaf, ei);
-	disk_num_bytes = btrfs_file_extent_disk_num_bytes(leaf, ei);
+	fh = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_file_header);
+	disk_bytenr = btrfs_file_header_disk_bytenr(leaf, fh);
+	disk_num_bytes = btrfs_file_header_disk_num_bytes(leaf, fh);
 
 	TLV_PUT_PATH(sctx, BTRFS_SEND_A_PATH, fspath);
 	TLV_PUT_U64(sctx, BTRFS_SEND_A_FILE_OFFSET, offset);
 	TLV_PUT_U64(sctx, BTRFS_SEND_A_UNENCODED_FILE_LEN,
-		    min(key.offset + btrfs_file_extent_num_bytes(leaf, ei) - offset,
+		    min(key.offset + btrfs_file_header_num_bytes(leaf, fh) - offset,
 			len));
 	TLV_PUT_U64(sctx, BTRFS_SEND_A_UNENCODED_LEN,
-		    btrfs_file_extent_ram_bytes(leaf, ei));
+		    btrfs_file_header_ram_bytes(leaf, fh));
 	TLV_PUT_U64(sctx, BTRFS_SEND_A_UNENCODED_OFFSET,
-		    offset - key.offset + btrfs_file_extent_offset(leaf, ei));
+		    offset - key.offset + btrfs_file_header_offset(leaf, fh));
 	ret = btrfs_encoded_io_compression_from_extent(fs_info,
-				btrfs_file_extent_compression(leaf, ei));
+				btrfs_file_header_compression(leaf, fh));
 	if (ret < 0)
 		goto out;
 	TLV_PUT_U32(sctx, BTRFS_SEND_A_COMPRESSION, ret);
@@ -5630,18 +5630,18 @@ static int send_extent_data(struct send_ctx *sctx, struct btrfs_path *path,
 {
 	const u64 end = offset + len;
 	struct extent_buffer *leaf = path->nodes[0];
-	struct btrfs_file_extent_item *ei;
+	struct btrfs_file_header *fh;
 	u64 read_size = max_send_read_size(sctx);
 	u64 sent = 0;
 
 	if (sctx->flags & BTRFS_SEND_FLAG_NO_FILE_DATA)
 		return send_update_extent(sctx, offset, len);
 
-	ei = btrfs_item_ptr(leaf, path->slots[0],
-			    struct btrfs_file_extent_item);
+	fh = btrfs_item_ptr(leaf, path->slots[0],
+			    struct btrfs_file_header);
 	if ((sctx->flags & BTRFS_SEND_FLAG_COMPRESSED) &&
-	    btrfs_file_extent_compression(leaf, ei) != BTRFS_COMPRESS_NONE) {
-		bool is_inline = (btrfs_file_extent_type(leaf, ei) ==
+	    btrfs_file_header_compression(leaf, fh) != BTRFS_COMPRESS_NONE) {
+		bool is_inline = (btrfs_file_header_type(leaf, fh) ==
 				  BTRFS_FILE_EXTENT_INLINE);
 
 		/*
@@ -5657,7 +5657,7 @@ static int send_extent_data(struct send_ctx *sctx, struct btrfs_path *path,
 			return send_encoded_inline_extent(sctx, path, offset,
 							  len);
 		} else if (!is_inline &&
-			   btrfs_file_extent_disk_num_bytes(leaf, ei) <= len) {
+			   btrfs_file_header_disk_num_bytes(leaf, fh) <= len) {
 			return send_encoded_extent(sctx, path, offset, len);
 		}
 	}
@@ -5866,7 +5866,7 @@ static int clone_range(struct send_ctx *sctx, struct btrfs_path *dst_path,
 	while (true) {
 		struct extent_buffer *leaf = path->nodes[0];
 		int slot = path->slots[0];
-		struct btrfs_file_extent_item *ei;
+		struct btrfs_file_header *fh;
 		u8 type;
 		u64 ext_len;
 		u64 clone_len;
@@ -5892,13 +5892,13 @@ static int clone_range(struct send_ctx *sctx, struct btrfs_path *dst_path,
 		    key.type != BTRFS_EXTENT_DATA_KEY)
 			break;
 
-		ei = btrfs_item_ptr(leaf, slot, struct btrfs_file_extent_item);
-		type = btrfs_file_extent_type(leaf, ei);
+		fh = btrfs_item_ptr(leaf, slot, struct btrfs_file_header);
+		type = btrfs_file_header_type(leaf, fh);
 		if (type == BTRFS_FILE_EXTENT_INLINE) {
-			ext_len = btrfs_file_extent_ram_bytes(leaf, ei);
+			ext_len = btrfs_file_header_ram_bytes(leaf, fh);
 			ext_len = PAGE_ALIGN(ext_len);
 		} else {
-			ext_len = btrfs_file_extent_num_bytes(leaf, ei);
+			ext_len = btrfs_file_header_num_bytes(leaf, fh);
 		}
 
 		if (key.offset + ext_len <= clone_root->offset)
@@ -5934,8 +5934,8 @@ static int clone_range(struct send_ctx *sctx, struct btrfs_path *dst_path,
 			crossed_src_i_size = true;
 		}
 
-		clone_data_offset = btrfs_file_extent_offset(leaf, ei);
-		if (btrfs_file_extent_disk_bytenr(leaf, ei) == disk_byte) {
+		clone_data_offset = btrfs_file_header_offset(leaf, fh);
+		if (btrfs_file_header_disk_bytenr(leaf, fh) == disk_byte) {
 			clone_root->offset = key.offset;
 			if (clone_data_offset < data_offset &&
 				clone_data_offset + ext_len > data_offset) {
@@ -5950,7 +5950,7 @@ static int clone_range(struct send_ctx *sctx, struct btrfs_path *dst_path,
 
 		clone_len = min_t(u64, ext_len, len);
 
-		if (btrfs_file_extent_disk_bytenr(leaf, ei) == disk_byte &&
+		if (btrfs_file_header_disk_bytenr(leaf, fh) == disk_byte &&
 		    clone_data_offset == data_offset) {
 			const u64 src_end = clone_root->offset + clone_len;
 			const u64 sectorsize = SZ_64K;
@@ -6061,7 +6061,7 @@ static int send_write_or_clone(struct send_ctx *sctx,
 	u64 offset = key->offset;
 	u64 end;
 	u64 bs = sctx->send_root->fs_info->sectorsize;
-	struct btrfs_file_extent_item *ei;
+	struct btrfs_file_header *fh;
 	u64 disk_byte;
 	u64 data_offset;
 	u64 num_bytes;
@@ -6121,10 +6121,10 @@ static int send_write_or_clone(struct send_ctx *sctx,
 	return ret;
 
 clone_data:
-	ei = btrfs_item_ptr(path->nodes[0], path->slots[0],
-			    struct btrfs_file_extent_item);
-	disk_byte = btrfs_file_extent_disk_bytenr(path->nodes[0], ei);
-	data_offset = btrfs_file_extent_offset(path->nodes[0], ei);
+	fh = btrfs_item_ptr(path->nodes[0], path->slots[0],
+			    struct btrfs_file_header);
+	disk_byte = btrfs_file_header_disk_bytenr(path->nodes[0], fh);
+	data_offset = btrfs_file_header_offset(path->nodes[0], fh);
 	ret = clone_range(sctx, path, clone_root, disk_byte, data_offset, offset,
 			  num_bytes);
 	sctx->cur_inode_next_write_offset = end;
@@ -6141,7 +6141,7 @@ static int is_extent_unchanged(struct send_ctx *sctx,
 	struct extent_buffer *eb;
 	int slot;
 	struct btrfs_key found_key;
-	struct btrfs_file_extent_item *ei;
+	struct btrfs_file_header *fh;
 	u64 left_disknr;
 	u64 right_disknr;
 	u64 left_offset;
@@ -6160,16 +6160,15 @@ static int is_extent_unchanged(struct send_ctx *sctx,
 
 	eb = left_path->nodes[0];
 	slot = left_path->slots[0];
-	ei = btrfs_item_ptr(eb, slot, struct btrfs_file_extent_item);
-	left_type = btrfs_file_extent_type(eb, ei);
-
+	fh = btrfs_item_ptr(eb, slot, struct btrfs_file_header);
+	left_type = btrfs_file_header_type(eb, fh);
 	if (left_type != BTRFS_FILE_EXTENT_REG)
 		return 0;
 
-	left_disknr = btrfs_file_extent_disk_bytenr(eb, ei);
-	left_len = btrfs_file_extent_num_bytes(eb, ei);
-	left_offset = btrfs_file_extent_offset(eb, ei);
-	left_gen = btrfs_file_extent_generation(eb, ei);
+	left_disknr = btrfs_file_header_disk_bytenr(eb, fh);
+	left_len = btrfs_file_header_num_bytes(eb, fh);
+	left_offset = btrfs_file_header_offset(eb, fh);
+	left_gen = btrfs_file_header_generation(eb, fh);
 
 	/*
 	 * Following comments will refer to these graphics. L is the left
@@ -6217,17 +6216,17 @@ static int is_extent_unchanged(struct send_ctx *sctx,
 	 */
 	key = found_key;
 	while (key.offset < ekey->offset + left_len) {
-		ei = btrfs_item_ptr(eb, slot, struct btrfs_file_extent_item);
-		right_type = btrfs_file_extent_type(eb, ei);
+		fh = btrfs_item_ptr(eb, slot, struct btrfs_file_header);
+		right_type = btrfs_file_header_type(eb, fh);
 		if (right_type != BTRFS_FILE_EXTENT_REG &&
 		    right_type != BTRFS_FILE_EXTENT_INLINE)
 			return 0;
 
 		if (right_type == BTRFS_FILE_EXTENT_INLINE) {
-			right_len = btrfs_file_extent_ram_bytes(eb, ei);
+			right_len = btrfs_file_header_ram_bytes(eb, fh);
 			right_len = PAGE_ALIGN(right_len);
 		} else {
-			right_len = btrfs_file_extent_num_bytes(eb, ei);
+			right_len = btrfs_file_header_num_bytes(eb, fh);
 		}
 
 		/*
@@ -6249,9 +6248,9 @@ static int is_extent_unchanged(struct send_ctx *sctx,
 		if (right_type == BTRFS_FILE_EXTENT_INLINE)
 			return 0;
 
-		right_disknr = btrfs_file_extent_disk_bytenr(eb, ei);
-		right_offset = btrfs_file_extent_offset(eb, ei);
-		right_gen = btrfs_file_extent_generation(eb, ei);
+		right_disknr = btrfs_file_header_disk_bytenr(eb, fh);
+		right_offset = btrfs_file_header_offset(eb, fh);
+		right_gen = btrfs_file_header_generation(eb, fh);
 
 		left_offset_fixed = left_offset;
 		if (key.offset < ekey->offset) {
@@ -6358,7 +6357,7 @@ static int range_is_hole_in_parent(struct send_ctx *sctx,
 	while (search_start < end) {
 		struct extent_buffer *leaf = path->nodes[0];
 		int slot = path->slots[0];
-		struct btrfs_file_extent_item *fi;
+		struct btrfs_file_header *fh;
 		u64 extent_end;
 
 		if (slot >= btrfs_header_nritems(leaf)) {
@@ -6379,13 +6378,13 @@ static int range_is_hole_in_parent(struct send_ctx *sctx,
 		    key.offset >= end)
 			break;
 
-		fi = btrfs_item_ptr(leaf, slot, struct btrfs_file_extent_item);
+		fh = btrfs_item_ptr(leaf, slot, struct btrfs_file_header);
 		extent_end = btrfs_file_extent_end(path);
 		if (extent_end <= start)
 			goto next;
-		if (btrfs_file_extent_type(leaf, fi) == BTRFS_FILE_EXTENT_INLINE)
+		if (btrfs_file_header_type(leaf, fh) == BTRFS_FILE_EXTENT_INLINE)
 			return 0;
-		if (btrfs_file_extent_disk_bytenr(leaf, fi) == 0) {
+		if (btrfs_file_header_disk_bytenr(leaf, fh) == 0) {
 			search_start = extent_end;
 			goto next;
 		}
@@ -6455,12 +6454,12 @@ static int process_extent(struct send_ctx *sctx,
 			goto out_hole;
 		}
 	} else {
-		struct btrfs_file_extent_item *ei;
+		struct btrfs_file_header *fh;
 		u8 type;
 
-		ei = btrfs_item_ptr(path->nodes[0], path->slots[0],
-				    struct btrfs_file_extent_item);
-		type = btrfs_file_extent_type(path->nodes[0], ei);
+		fh = btrfs_item_ptr(path->nodes[0], path->slots[0],
+				    struct btrfs_file_header);
+		type = btrfs_file_header_type(path->nodes[0], fh);
 		if (type == BTRFS_FILE_EXTENT_PREALLOC ||
 		    type == BTRFS_FILE_EXTENT_REG) {
 			/*
@@ -6475,7 +6474,7 @@ static int process_extent(struct send_ctx *sctx,
 			}
 
 			/* Have a hole, just skip it. */
-			if (btrfs_file_extent_disk_bytenr(path->nodes[0], ei) == 0) {
+			if (btrfs_file_header_disk_bytenr(path->nodes[0], fh) == 0) {
 				ret = 0;
 				goto out;
 			}
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 5831754bb01c..f8e70cf94cd1 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -730,21 +730,21 @@ static noinline int replay_one_extent(struct walk_control *wc)
 	u64 offset;
 	unsigned long dest_offset;
 	struct btrfs_key ins;
-	struct btrfs_file_extent_item *item;
+	struct btrfs_file_header *header;
 	struct btrfs_inode *inode = NULL;
 	int ret = 0;
 
-	item = btrfs_item_ptr(wc->log_leaf, wc->log_slot, struct btrfs_file_extent_item);
-	found_type = btrfs_file_extent_type(wc->log_leaf, item);
+	header = btrfs_item_ptr(wc->log_leaf, wc->log_slot, struct btrfs_file_header);
+	found_type = btrfs_file_header_type(wc->log_leaf, header);
 
 	if (found_type == BTRFS_FILE_EXTENT_REG ||
 	    found_type == BTRFS_FILE_EXTENT_PREALLOC) {
-		extent_end = start + btrfs_file_extent_num_bytes(wc->log_leaf, item);
+		extent_end = start + btrfs_file_header_num_bytes(wc->log_leaf, header);
 		/* Holes don't take up space. */
-		if (btrfs_file_extent_disk_bytenr(wc->log_leaf, item) != 0)
-			nbytes = btrfs_file_extent_num_bytes(wc->log_leaf, item);
+		if (btrfs_file_header_disk_bytenr(wc->log_leaf, header) != 0)
+			nbytes = btrfs_file_header_num_bytes(wc->log_leaf, header);
 	} else if (found_type == BTRFS_FILE_EXTENT_INLINE) {
-		nbytes = btrfs_file_extent_ram_bytes(wc->log_leaf, item);
+		nbytes = btrfs_file_header_ram_bytes(wc->log_leaf, header);
 		extent_end = ALIGN(start + nbytes, fs_info->sectorsize);
 	} else {
 		btrfs_abort_log_replay(wc, -EUCLEAN,
@@ -785,7 +785,7 @@ static noinline int replay_one_extent(struct walk_control *wc)
 		 * we already have a pointer to this exact extent,
 		 * we don't have to do anything
 		 */
-		if (memcmp_extent_buffer(wc->log_leaf, &existing, (unsigned long)item,
+		if (memcmp_extent_buffer(wc->log_leaf, &existing, (unsigned long)header,
 					 sizeof(existing)) == 0) {
 			btrfs_release_path(wc->subvol_path);
 			goto out;
@@ -821,12 +821,12 @@ static noinline int replay_one_extent(struct walk_control *wc)
 	 */
 
 	/* A hole and NO_HOLES feature enabled, nothing else to do. */
-	if (btrfs_file_extent_disk_bytenr(wc->log_leaf, item) == 0 &&
+	if (btrfs_file_header_disk_bytenr(wc->log_leaf, header) == 0 &&
 	    btrfs_fs_incompat(fs_info, NO_HOLES))
 		goto update_inode;
 
 	ret = btrfs_insert_empty_item(trans, root, wc->subvol_path,
-				      &wc->log_key, sizeof(*item));
+				      &wc->log_key, sizeof(struct btrfs_file_extent_item));
 	if (ret) {
 		btrfs_abort_log_replay(wc, ret,
 		       "failed to insert item with key " BTRFS_KEY_FMT " root %llu",
@@ -837,7 +837,7 @@ static noinline int replay_one_extent(struct walk_control *wc)
 	dest_offset = btrfs_item_ptr_offset(wc->subvol_path->nodes[0],
 					    wc->subvol_path->slots[0]);
 	copy_extent_buffer(wc->subvol_path->nodes[0], wc->log_leaf, dest_offset,
-			   (unsigned long)item, sizeof(*item));
+			   (unsigned long)header, sizeof(struct btrfs_file_extent_item));
 
 	/*
 	 * We have an explicit hole and NO_HOLES is not enabled. We have added
@@ -845,15 +845,15 @@ static noinline int replay_one_extent(struct walk_control *wc)
 	 * anything else to do other than update the file extent item range and
 	 * update the inode item.
 	 */
-	if (btrfs_file_extent_disk_bytenr(wc->log_leaf, item) == 0) {
+	if (btrfs_file_header_disk_bytenr(wc->log_leaf, header) == 0) {
 		btrfs_release_path(wc->subvol_path);
 		goto update_inode;
 	}
 
-	ins.objectid = btrfs_file_extent_disk_bytenr(wc->log_leaf, item);
+	ins.objectid = btrfs_file_header_disk_bytenr(wc->log_leaf, header);
 	ins.type = BTRFS_EXTENT_ITEM_KEY;
-	ins.offset = btrfs_file_extent_disk_num_bytes(wc->log_leaf, item);
-	offset = wc->log_key.offset - btrfs_file_extent_offset(wc->log_leaf, item);
+	ins.offset = btrfs_file_header_disk_num_bytes(wc->log_leaf, header);
+	offset = wc->log_key.offset - btrfs_file_header_offset(wc->log_leaf, header);
 
 	/*
 	 * Manually record dirty extent, as here we did a shallow file extent
@@ -916,12 +916,12 @@ static noinline int replay_one_extent(struct walk_control *wc)
 
 	btrfs_release_path(wc->subvol_path);
 
-	if (btrfs_file_extent_compression(wc->log_leaf, item)) {
+	if (btrfs_file_header_compression(wc->log_leaf, header)) {
 		csum_start = ins.objectid;
 		csum_end = csum_start + ins.offset;
 	} else {
-		csum_start = ins.objectid + btrfs_file_extent_offset(wc->log_leaf, item);
-		csum_end = csum_start + btrfs_file_extent_num_bytes(wc->log_leaf, item);
+		csum_start = ins.objectid + btrfs_file_header_offset(wc->log_leaf, header);
+		csum_end = csum_start + btrfs_file_header_num_bytes(wc->log_leaf, header);
 	}
 
 	ret = btrfs_lookup_csums_list(root->log_root, csum_start, csum_end - 1,
@@ -4761,7 +4761,6 @@ static noinline int copy_items(struct btrfs_trans_handle *trans,
 			       u64 logged_isize, struct btrfs_log_ctx *ctx)
 {
 	struct btrfs_root *log = inode->root->log_root;
-	struct btrfs_file_extent_item *extent;
 	struct extent_buffer *src;
 	int ret;
 	struct btrfs_key *ins_keys;
@@ -4819,6 +4818,7 @@ static noinline int copy_items(struct btrfs_trans_handle *trans,
 
 	dst_index = 0;
 	for (int i = 0; i < nr; i++) {
+		struct btrfs_file_header *header;
 		const int src_slot = start_slot + i;
 		struct btrfs_root *csum_root;
 		struct btrfs_ordered_sum *sums;
@@ -4835,10 +4835,9 @@ static noinline int copy_items(struct btrfs_trans_handle *trans,
 		if (ins_keys[dst_index].type != BTRFS_EXTENT_DATA_KEY)
 			goto add_to_batch;
 
-		extent = btrfs_item_ptr(src, src_slot,
-					struct btrfs_file_extent_item);
+		header = btrfs_item_ptr(src, src_slot, struct btrfs_file_header);
 
-		is_old_extent = (btrfs_file_extent_generation(src, extent) <
+		is_old_extent = (btrfs_file_header_generation(src, header) <
 				 trans->transid);
 
 		/*
@@ -4863,7 +4862,7 @@ static noinline int copy_items(struct btrfs_trans_handle *trans,
 			goto add_to_batch;
 
 		/* Only regular extents have checksums. */
-		if (btrfs_file_extent_type(src, extent) != BTRFS_FILE_EXTENT_REG)
+		if (btrfs_file_header_type(src, header) != BTRFS_FILE_EXTENT_REG)
 			goto add_to_batch;
 
 		/*
@@ -4874,19 +4873,19 @@ static noinline int copy_items(struct btrfs_trans_handle *trans,
 		if (is_old_extent)
 			goto add_to_batch;
 
-		disk_bytenr = btrfs_file_extent_disk_bytenr(src, extent);
+		disk_bytenr = btrfs_file_header_disk_bytenr(src, header);
 		/* If it's an explicit hole, there are no checksums. */
 		if (disk_bytenr == 0)
 			goto add_to_batch;
 
-		disk_num_bytes = btrfs_file_extent_disk_num_bytes(src, extent);
+		disk_num_bytes = btrfs_file_header_disk_num_bytes(src, header);
 
-		if (btrfs_file_extent_compression(src, extent)) {
+		if (btrfs_file_header_compression(src, header)) {
 			extent_offset = 0;
 			extent_num_bytes = disk_num_bytes;
 		} else {
-			extent_offset = btrfs_file_extent_offset(src, extent);
-			extent_num_bytes = btrfs_file_extent_num_bytes(src, extent);
+			extent_offset = btrfs_file_header_offset(src, header);
+			extent_num_bytes = btrfs_file_header_num_bytes(src, header);
 		}
 
 		csum_root = btrfs_csum_root(trans->fs_info, disk_bytenr);
@@ -4927,6 +4926,7 @@ static noinline int copy_items(struct btrfs_trans_handle *trans,
 
 	dst_index = 0;
 	for (int i = 0; i < nr; i++) {
+		struct btrfs_file_header *header;
 		const int src_slot = start_slot + i;
 		const int dst_slot = dst_path->slots[0] + dst_index;
 		struct btrfs_key key;
@@ -4945,11 +4945,11 @@ static noinline int copy_items(struct btrfs_trans_handle *trans,
 		if (key.type != BTRFS_EXTENT_DATA_KEY)
 			goto copy_item;
 
-		extent = btrfs_item_ptr(src, src_slot,
-					struct btrfs_file_extent_item);
+		header = btrfs_item_ptr(src, src_slot,
+					struct btrfs_file_header);
 
 		/* See the comment in the previous loop, same logic. */
-		if (btrfs_file_extent_generation(src, extent) < trans->transid &&
+		if (btrfs_file_header_generation(src, header) < trans->transid &&
 		    key.offset < i_size &&
 		    inode->last_reflink_trans < trans->transid)
 			continue;
@@ -5237,19 +5237,19 @@ static int btrfs_log_prealloc_extents(struct btrfs_trans_handle *trans,
 		goto out;
 
 	if (ret == 0) {
-		struct btrfs_file_extent_item *ei;
+		struct btrfs_file_header *fh;
 
 		leaf = path->nodes[0];
 		slot = path->slots[0];
-		ei = btrfs_item_ptr(leaf, slot, struct btrfs_file_extent_item);
+		fh = btrfs_item_ptr(leaf, slot, struct btrfs_file_header);
 
-		if (btrfs_file_extent_type(leaf, ei) ==
+		if (btrfs_file_header_type(leaf, fh) ==
 		    BTRFS_FILE_EXTENT_PREALLOC) {
 			u64 extent_end;
 
 			btrfs_item_key_to_cpu(leaf, &key, slot);
 			extent_end = key.offset +
-				btrfs_file_extent_num_bytes(leaf, ei);
+				btrfs_file_header_num_bytes(leaf, fh);
 
 			if (extent_end > i_size)
 				truncate_offset = extent_end;
-- 
2.52.0


