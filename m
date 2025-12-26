Return-Path: <linux-btrfs+bounces-20015-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF9BCDE576
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Dec 2025 06:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 910893019BFD
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Dec 2025 05:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7325E246335;
	Fri, 26 Dec 2025 05:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="NixYJgdT";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="NixYJgdT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6A723D7E6
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Dec 2025 05:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766726016; cv=none; b=LHTF74D8XEUEBCxHlUWURinJamaJGO/UERQmIUeALWPUjngIdg6lhmyh8pgm+Ua/7WY7Eb4uyiaDvWkQCQ6A3IYJXzciL20axAXqewjnuDRr5zkKC8C7bWmzM78uBo5kOI7BJECTicjlVW9uSuggkxnFemnT4aP2ys9w9URWS3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766726016; c=relaxed/simple;
	bh=vVAbaxv5vZZ7fEOBWrYXySbcI9rcPTBd79GJ33HjjzQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b4W2ix0eXPje+ImSrO9J7JIc70+N5UZYM3qxcsD7CfWTfbbA8TIoBEYCGUWrYzg8oFRLwtq+/SgaKmfRUANvq7oksR57GL+sv5+l2q7I0yO0I8o2gcbZ51vnHV/SfjyWwSvt4vDAEXBs49p/c4RaPJGmO9StE6KEADCeTzuUQKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=NixYJgdT; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=NixYJgdT; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CC5B25BCCB
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Dec 2025 05:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1766726003; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ccr6cMVPPQLuOp8jJgZM/oc6nu1kFAO++oB1X1M6yy4=;
	b=NixYJgdTpPag7V5SQgrLhN2gkexd7JYhNRXKVNsUX43LoJ95r+59Wem+XekS4MErhuNRTf
	15Vk9H2DNbLykgRnGNhdWNWPilc1JxKV5bBHydJrFzTT7nuDVgdPrgw0a9RudkE16QlGx3
	+4amw9WPdxMGWApcBDXtKo44zo9CIEk=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=NixYJgdT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1766726003; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ccr6cMVPPQLuOp8jJgZM/oc6nu1kFAO++oB1X1M6yy4=;
	b=NixYJgdTpPag7V5SQgrLhN2gkexd7JYhNRXKVNsUX43LoJ95r+59Wem+XekS4MErhuNRTf
	15Vk9H2DNbLykgRnGNhdWNWPilc1JxKV5bBHydJrFzTT7nuDVgdPrgw0a9RudkE16QlGx3
	+4amw9WPdxMGWApcBDXtKo44zo9CIEk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 154BB3EA63
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Dec 2025 05:13:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4J5iMnIZTmn1DQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Dec 2025 05:13:22 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 6/7] btrfs: use btrfs_file_header structure for file.c
Date: Fri, 26 Dec 2025 15:42:52 +1030
Message-ID: <cc59706217359af6748538c7f9542d88199ab91b.1766725912.git.wqu@suse.com>
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
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	DWL_DNSWL_LOW(-1.00)[suse.com:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-0.994];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:dkim,suse.com:mid];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Queue-Id: CC5B25BCCB
X-Spam-Flag: NO
X-Spam-Score: -4.01

That file is a heavy user of btrfs_file_extent_item structure.

Most call sites are straightforward, some can benefit from a reduced
lifespan, e.g. the btrfs_file_extent_item variable inside
btrfs_drop_extents() is defined at the function level, but inside the
while (1) loop, every time we hit a BTRFS_EXTENT_DATA key the pointer is
updated to the corresponding item.

Thus it's safe to move the new btrfs_file_header pointer definition
inside the while loop.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/file.c | 204 ++++++++++++++++++++++++------------------------
 1 file changed, 101 insertions(+), 103 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 69edf5f44bda..a9ac9ae6532d 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -140,7 +140,6 @@ int btrfs_drop_extents(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct extent_buffer *leaf;
-	struct btrfs_file_extent_item *fi;
 	struct btrfs_key key;
 	struct btrfs_key new_key;
 	u64 ino = btrfs_ino(inode);
@@ -182,6 +181,8 @@ int btrfs_drop_extents(struct btrfs_trans_handle *trans,
 
 	update_refs = (btrfs_root_id(root) != BTRFS_TREE_LOG_OBJECTID);
 	while (1) {
+		struct btrfs_file_header *fh;
+
 		recow = 0;
 		ret = btrfs_lookup_file_extent(trans, root, path, ino,
 					       search_start, modify_tree);
@@ -227,20 +228,20 @@ int btrfs_drop_extents(struct btrfs_trans_handle *trans,
 		if (key.type > BTRFS_EXTENT_DATA_KEY || key.offset >= args->end)
 			break;
 
-		fi = btrfs_item_ptr(leaf, path->slots[0],
-				    struct btrfs_file_extent_item);
-		extent_type = btrfs_file_extent_type(leaf, fi);
+		fh = btrfs_item_ptr(leaf, path->slots[0],
+				    struct btrfs_file_header);
+		extent_type = btrfs_file_header_type(leaf, fh);
 
 		if (extent_type == BTRFS_FILE_EXTENT_REG ||
 		    extent_type == BTRFS_FILE_EXTENT_PREALLOC) {
-			disk_bytenr = btrfs_file_extent_disk_bytenr(leaf, fi);
-			num_bytes = btrfs_file_extent_disk_num_bytes(leaf, fi);
-			extent_offset = btrfs_file_extent_offset(leaf, fi);
+			disk_bytenr = btrfs_file_header_disk_bytenr(leaf, fh);
+			num_bytes = btrfs_file_header_disk_num_bytes(leaf, fh);
+			extent_offset = btrfs_file_header_offset(leaf, fh);
 			extent_end = key.offset +
-				btrfs_file_extent_num_bytes(leaf, fi);
+				btrfs_file_header_num_bytes(leaf, fh);
 		} else if (extent_type == BTRFS_FILE_EXTENT_INLINE) {
 			extent_end = key.offset +
-				btrfs_file_extent_ram_bytes(leaf, fi);
+				btrfs_file_header_ram_bytes(leaf, fh);
 		} else {
 			/* can't happen */
 			BUG();
@@ -300,17 +301,17 @@ int btrfs_drop_extents(struct btrfs_trans_handle *trans,
 				break;
 
 			leaf = path->nodes[0];
-			fi = btrfs_item_ptr(leaf, path->slots[0] - 1,
-					    struct btrfs_file_extent_item);
-			btrfs_set_file_extent_num_bytes(leaf, fi,
+			fh = btrfs_item_ptr(leaf, path->slots[0] - 1,
+					    struct btrfs_file_header);
+			btrfs_set_file_header_num_bytes(leaf, fh,
 							args->start - key.offset);
 
-			fi = btrfs_item_ptr(leaf, path->slots[0],
-					    struct btrfs_file_extent_item);
+			fh = btrfs_item_ptr(leaf, path->slots[0],
+					    struct btrfs_file_header);
 
 			extent_offset += args->start - key.offset;
-			btrfs_set_file_extent_offset(leaf, fi, extent_offset);
-			btrfs_set_file_extent_num_bytes(leaf, fi,
+			btrfs_set_file_header_offset(leaf, fh, extent_offset);
+			btrfs_set_file_header_num_bytes(leaf, fh,
 							extent_end - args->start);
 
 			if (update_refs && disk_bytenr > 0) {
@@ -354,8 +355,8 @@ int btrfs_drop_extents(struct btrfs_trans_handle *trans,
 			btrfs_set_item_key_safe(trans, path, &new_key);
 
 			extent_offset += args->end - key.offset;
-			btrfs_set_file_extent_offset(leaf, fi, extent_offset);
-			btrfs_set_file_extent_num_bytes(leaf, fi,
+			btrfs_set_file_header_offset(leaf, fh, extent_offset);
+			btrfs_set_file_header_num_bytes(leaf, fh,
 							extent_end - args->end);
 			if (update_refs && disk_bytenr > 0)
 				args->bytes_found += args->end - key.offset;
@@ -378,7 +379,7 @@ int btrfs_drop_extents(struct btrfs_trans_handle *trans,
 				break;
 			}
 
-			btrfs_set_file_extent_num_bytes(leaf, fi,
+			btrfs_set_file_header_num_bytes(leaf, fh,
 							args->start - key.offset);
 			if (update_refs && disk_bytenr > 0)
 				args->bytes_found += extent_end - args->start;
@@ -509,7 +510,7 @@ int btrfs_drop_extents(struct btrfs_trans_handle *trans,
 static bool extent_mergeable(struct extent_buffer *leaf, int slot, u64 objectid,
 			     u64 bytenr, u64 orig_offset, u64 *start, u64 *end)
 {
-	struct btrfs_file_extent_item *fi;
+	struct btrfs_file_header *fh;
 	struct btrfs_key key;
 	u64 extent_end;
 
@@ -520,16 +521,16 @@ static bool extent_mergeable(struct extent_buffer *leaf, int slot, u64 objectid,
 	if (key.objectid != objectid || key.type != BTRFS_EXTENT_DATA_KEY)
 		return false;
 
-	fi = btrfs_item_ptr(leaf, slot, struct btrfs_file_extent_item);
-	if (btrfs_file_extent_type(leaf, fi) != BTRFS_FILE_EXTENT_REG ||
-	    btrfs_file_extent_disk_bytenr(leaf, fi) != bytenr ||
-	    btrfs_file_extent_offset(leaf, fi) != key.offset - orig_offset ||
-	    btrfs_file_extent_compression(leaf, fi) ||
-	    btrfs_file_extent_encryption(leaf, fi) ||
-	    btrfs_file_extent_other_encoding(leaf, fi))
+	fh = btrfs_item_ptr(leaf, slot, struct btrfs_file_header);
+	if (btrfs_file_header_type(leaf, fh) != BTRFS_FILE_EXTENT_REG ||
+	    btrfs_file_header_disk_bytenr(leaf, fh) != bytenr ||
+	    btrfs_file_header_offset(leaf, fh) != key.offset - orig_offset ||
+	    btrfs_file_header_compression(leaf, fh) ||
+	    btrfs_file_header_encryption(leaf, fh) ||
+	    btrfs_file_header_other_encoding(leaf, fh))
 		return false;
 
-	extent_end = key.offset + btrfs_file_extent_num_bytes(leaf, fi);
+	extent_end = key.offset + btrfs_file_header_num_bytes(leaf, fh);
 	if ((*start && *start != key.offset) || (*end && *end != extent_end))
 		return false;
 
@@ -551,7 +552,7 @@ int btrfs_mark_extent_written(struct btrfs_trans_handle *trans,
 	struct btrfs_root *root = inode->root;
 	struct extent_buffer *leaf;
 	BTRFS_PATH_AUTO_FREE(path);
-	struct btrfs_file_extent_item *fi;
+	struct btrfs_file_header *fh;
 	struct btrfs_ref ref = { 0 };
 	struct btrfs_key key;
 	struct btrfs_key new_key;
@@ -591,23 +592,23 @@ int btrfs_mark_extent_written(struct btrfs_trans_handle *trans,
 		btrfs_abort_transaction(trans, ret);
 		goto out;
 	}
-	fi = btrfs_item_ptr(leaf, path->slots[0],
-			    struct btrfs_file_extent_item);
-	if (unlikely(btrfs_file_extent_type(leaf, fi) != BTRFS_FILE_EXTENT_PREALLOC)) {
+	fh = btrfs_item_ptr(leaf, path->slots[0],
+			    struct btrfs_file_header);
+	if (unlikely(btrfs_file_header_type(leaf, fh) != BTRFS_FILE_EXTENT_PREALLOC)) {
 		ret = -EINVAL;
 		btrfs_abort_transaction(trans, ret);
 		goto out;
 	}
-	extent_end = key.offset + btrfs_file_extent_num_bytes(leaf, fi);
+	extent_end = key.offset + btrfs_file_header_num_bytes(leaf, fh);
 	if (unlikely(key.offset > start || extent_end < end)) {
 		ret = -EINVAL;
 		btrfs_abort_transaction(trans, ret);
 		goto out;
 	}
 
-	bytenr = btrfs_file_extent_disk_bytenr(leaf, fi);
-	num_bytes = btrfs_file_extent_disk_num_bytes(leaf, fi);
-	orig_offset = key.offset - btrfs_file_extent_offset(leaf, fi);
+	bytenr = btrfs_file_header_disk_bytenr(leaf, fh);
+	num_bytes = btrfs_file_header_disk_num_bytes(leaf, fh);
+	orig_offset = key.offset - btrfs_file_header_offset(leaf, fh);
 	memcpy(&new_key, &key, sizeof(new_key));
 
 	if (start == key.offset && end < extent_end) {
@@ -618,19 +619,19 @@ int btrfs_mark_extent_written(struct btrfs_trans_handle *trans,
 				     &other_start, &other_end)) {
 			new_key.offset = end;
 			btrfs_set_item_key_safe(trans, path, &new_key);
-			fi = btrfs_item_ptr(leaf, path->slots[0],
-					    struct btrfs_file_extent_item);
-			btrfs_set_file_extent_generation(leaf, fi,
+			fh = btrfs_item_ptr(leaf, path->slots[0],
+					    struct btrfs_file_header);
+			btrfs_set_file_header_generation(leaf, fh,
 							 trans->transid);
-			btrfs_set_file_extent_num_bytes(leaf, fi,
+			btrfs_set_file_header_num_bytes(leaf, fh,
 							extent_end - end);
-			btrfs_set_file_extent_offset(leaf, fi,
+			btrfs_set_file_header_offset(leaf, fh,
 						     end - orig_offset);
-			fi = btrfs_item_ptr(leaf, path->slots[0] - 1,
-					    struct btrfs_file_extent_item);
-			btrfs_set_file_extent_generation(leaf, fi,
+			fh = btrfs_item_ptr(leaf, path->slots[0] - 1,
+					    struct btrfs_file_header);
+			btrfs_set_file_header_generation(leaf, fh,
 							 trans->transid);
-			btrfs_set_file_extent_num_bytes(leaf, fi,
+			btrfs_set_file_header_num_bytes(leaf, fh,
 							end - other_start);
 			goto out;
 		}
@@ -642,23 +643,23 @@ int btrfs_mark_extent_written(struct btrfs_trans_handle *trans,
 		if (extent_mergeable(leaf, path->slots[0] + 1,
 				     ino, bytenr, orig_offset,
 				     &other_start, &other_end)) {
-			fi = btrfs_item_ptr(leaf, path->slots[0],
-					    struct btrfs_file_extent_item);
-			btrfs_set_file_extent_num_bytes(leaf, fi,
+			fh = btrfs_item_ptr(leaf, path->slots[0],
+					    struct btrfs_file_header);
+			btrfs_set_file_header_num_bytes(leaf, fh,
 							start - key.offset);
-			btrfs_set_file_extent_generation(leaf, fi,
+			btrfs_set_file_header_generation(leaf, fh,
 							 trans->transid);
 			path->slots[0]++;
 			new_key.offset = start;
 			btrfs_set_item_key_safe(trans, path, &new_key);
 
-			fi = btrfs_item_ptr(leaf, path->slots[0],
-					    struct btrfs_file_extent_item);
-			btrfs_set_file_extent_generation(leaf, fi,
+			fh = btrfs_item_ptr(leaf, path->slots[0],
+					    struct btrfs_file_header);
+			btrfs_set_file_header_generation(leaf, fh,
 							 trans->transid);
-			btrfs_set_file_extent_num_bytes(leaf, fi,
+			btrfs_set_file_header_num_bytes(leaf, fh,
 							other_end - start);
-			btrfs_set_file_extent_offset(leaf, fi,
+			btrfs_set_file_header_offset(leaf, fh,
 						     start - orig_offset);
 			goto out;
 		}
@@ -680,18 +681,16 @@ int btrfs_mark_extent_written(struct btrfs_trans_handle *trans,
 		}
 
 		leaf = path->nodes[0];
-		fi = btrfs_item_ptr(leaf, path->slots[0] - 1,
-				    struct btrfs_file_extent_item);
-		btrfs_set_file_extent_generation(leaf, fi, trans->transid);
-		btrfs_set_file_extent_num_bytes(leaf, fi,
+		fh = btrfs_item_ptr(leaf, path->slots[0] - 1, struct btrfs_file_header);
+		btrfs_set_file_header_generation(leaf, fh, trans->transid);
+		btrfs_set_file_header_num_bytes(leaf, fh,
 						split - key.offset);
 
-		fi = btrfs_item_ptr(leaf, path->slots[0],
-				    struct btrfs_file_extent_item);
+		fh = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_file_header);
 
-		btrfs_set_file_extent_generation(leaf, fi, trans->transid);
-		btrfs_set_file_extent_offset(leaf, fi, split - orig_offset);
-		btrfs_set_file_extent_num_bytes(leaf, fi,
+		btrfs_set_file_header_generation(leaf, fh, trans->transid);
+		btrfs_set_file_header_offset(leaf, fh, split - orig_offset);
+		btrfs_set_file_header_num_bytes(leaf, fh,
 						extent_end - split);
 
 		ref.action = BTRFS_ADD_DELAYED_REF;
@@ -766,18 +765,16 @@ int btrfs_mark_extent_written(struct btrfs_trans_handle *trans,
 		}
 	}
 	if (del_nr == 0) {
-		fi = btrfs_item_ptr(leaf, path->slots[0],
-			   struct btrfs_file_extent_item);
-		btrfs_set_file_extent_type(leaf, fi,
+		fh = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_file_header);
+		btrfs_set_file_header_type(leaf, fh,
 					   BTRFS_FILE_EXTENT_REG);
-		btrfs_set_file_extent_generation(leaf, fi, trans->transid);
+		btrfs_set_file_header_generation(leaf, fh, trans->transid);
 	} else {
-		fi = btrfs_item_ptr(leaf, del_slot - 1,
-			   struct btrfs_file_extent_item);
-		btrfs_set_file_extent_type(leaf, fi,
+		fh = btrfs_item_ptr(leaf, del_slot - 1, struct btrfs_file_header);
+		btrfs_set_file_header_type(leaf, fh,
 					   BTRFS_FILE_EXTENT_REG);
-		btrfs_set_file_extent_generation(leaf, fi, trans->transid);
-		btrfs_set_file_extent_num_bytes(leaf, fi,
+		btrfs_set_file_header_generation(leaf, fh, trans->transid);
+		btrfs_set_file_header_num_bytes(leaf, fh,
 						extent_end - key.offset);
 
 		ret = btrfs_del_items(trans, root, path, del_slot, del_nr);
@@ -2056,7 +2053,7 @@ static int btrfs_file_mmap_prepare(struct vm_area_desc *desc)
 static bool hole_mergeable(struct btrfs_inode *inode, struct extent_buffer *leaf,
 			   int slot, u64 start, u64 end)
 {
-	struct btrfs_file_extent_item *fi;
+	struct btrfs_file_header *fh;
 	struct btrfs_key key;
 
 	if (slot < 0 || slot >= btrfs_header_nritems(leaf))
@@ -2067,17 +2064,17 @@ static bool hole_mergeable(struct btrfs_inode *inode, struct extent_buffer *leaf
 	    key.type != BTRFS_EXTENT_DATA_KEY)
 		return false;
 
-	fi = btrfs_item_ptr(leaf, slot, struct btrfs_file_extent_item);
+	fh = btrfs_item_ptr(leaf, slot, struct btrfs_file_header);
 
-	if (btrfs_file_extent_type(leaf, fi) != BTRFS_FILE_EXTENT_REG)
+	if (btrfs_file_header_type(leaf, fh) != BTRFS_FILE_EXTENT_REG)
 		return false;
 
-	if (btrfs_file_extent_disk_bytenr(leaf, fi))
+	if (btrfs_file_header_disk_bytenr(leaf, fh))
 		return false;
 
 	if (key.offset == end)
 		return true;
-	if (key.offset + btrfs_file_extent_num_bytes(leaf, fi) == start)
+	if (key.offset + btrfs_file_header_num_bytes(leaf, fh) == start)
 		return true;
 	return false;
 }
@@ -2089,7 +2086,6 @@ static int fill_holes(struct btrfs_trans_handle *trans,
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_root *root = inode->root;
 	struct extent_buffer *leaf;
-	struct btrfs_file_extent_item *fi;
 	struct extent_map *hole_em;
 	struct btrfs_key key;
 	int ret;
@@ -2114,33 +2110,35 @@ static int fill_holes(struct btrfs_trans_handle *trans,
 
 	leaf = path->nodes[0];
 	if (hole_mergeable(inode, leaf, path->slots[0] - 1, offset, end)) {
+		struct btrfs_file_header *fh;
 		u64 num_bytes;
 
 		path->slots[0]--;
-		fi = btrfs_item_ptr(leaf, path->slots[0],
-				    struct btrfs_file_extent_item);
-		num_bytes = btrfs_file_extent_num_bytes(leaf, fi) +
+		fh = btrfs_item_ptr(leaf, path->slots[0],
+				    struct btrfs_file_header);
+		num_bytes = btrfs_file_header_num_bytes(leaf, fh) +
 			end - offset;
-		btrfs_set_file_extent_num_bytes(leaf, fi, num_bytes);
-		btrfs_set_file_extent_ram_bytes(leaf, fi, num_bytes);
-		btrfs_set_file_extent_offset(leaf, fi, 0);
-		btrfs_set_file_extent_generation(leaf, fi, trans->transid);
+		btrfs_set_file_header_num_bytes(leaf, fh, num_bytes);
+		btrfs_set_file_header_ram_bytes(leaf, fh, num_bytes);
+		btrfs_set_file_header_offset(leaf, fh, 0);
+		btrfs_set_file_header_generation(leaf, fh, trans->transid);
 		goto out;
 	}
 
 	if (hole_mergeable(inode, leaf, path->slots[0], offset, end)) {
+		struct btrfs_file_header *fh;
 		u64 num_bytes;
 
 		key.offset = offset;
 		btrfs_set_item_key_safe(trans, path, &key);
-		fi = btrfs_item_ptr(leaf, path->slots[0],
-				    struct btrfs_file_extent_item);
-		num_bytes = btrfs_file_extent_num_bytes(leaf, fi) + end -
+		fh = btrfs_item_ptr(leaf, path->slots[0],
+				    struct btrfs_file_header);
+		num_bytes = btrfs_file_header_num_bytes(leaf, fh) + end -
 			offset;
-		btrfs_set_file_extent_num_bytes(leaf, fi, num_bytes);
-		btrfs_set_file_extent_ram_bytes(leaf, fi, num_bytes);
-		btrfs_set_file_extent_offset(leaf, fi, 0);
-		btrfs_set_file_extent_generation(leaf, fi, trans->transid);
+		btrfs_set_file_header_num_bytes(leaf, fh, num_bytes);
+		btrfs_set_file_header_ram_bytes(leaf, fh, num_bytes);
+		btrfs_set_file_header_offset(leaf, fh, 0);
+		btrfs_set_file_header_generation(leaf, fh, trans->transid);
 		goto out;
 	}
 	btrfs_release_path(path);
@@ -2305,7 +2303,7 @@ static int btrfs_insert_replace_extent(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_root *root = inode->root;
-	struct btrfs_file_extent_item *extent;
+	struct btrfs_file_header *header;
 	struct extent_buffer *leaf;
 	struct btrfs_key key;
 	int slot;
@@ -2332,12 +2330,12 @@ static int btrfs_insert_replace_extent(struct btrfs_trans_handle *trans,
 	write_extent_buffer(leaf, extent_info->extent_buf,
 			    btrfs_item_ptr_offset(leaf, slot),
 			    sizeof(struct btrfs_file_extent_item));
-	extent = btrfs_item_ptr(leaf, slot, struct btrfs_file_extent_item);
-	ASSERT(btrfs_file_extent_type(leaf, extent) != BTRFS_FILE_EXTENT_INLINE);
-	btrfs_set_file_extent_offset(leaf, extent, extent_info->data_offset);
-	btrfs_set_file_extent_num_bytes(leaf, extent, replace_len);
+	header = btrfs_item_ptr(leaf, slot, struct btrfs_file_header);
+	ASSERT(btrfs_file_header_type(leaf, header) != BTRFS_FILE_EXTENT_INLINE);
+	btrfs_set_file_header_offset(leaf, header, extent_info->data_offset);
+	btrfs_set_file_header_num_bytes(leaf, header, replace_len);
 	if (extent_info->is_new_extent)
-		btrfs_set_file_extent_generation(leaf, extent, trans->transid);
+		btrfs_set_file_header_generation(leaf, header, trans->transid);
 	btrfs_release_path(path);
 
 	ret = btrfs_inode_set_file_extent_range(inode, extent_info->file_offset,
@@ -3637,7 +3635,7 @@ static loff_t find_desired_extent(struct file *file, loff_t offset, int whence)
 
 	while (start < i_size) {
 		struct extent_buffer *leaf = path->nodes[0];
-		struct btrfs_file_extent_item *extent;
+		struct btrfs_file_header *header;
 		u64 extent_end;
 		u8 type;
 
@@ -3693,9 +3691,9 @@ static loff_t find_desired_extent(struct file *file, loff_t offset, int whence)
 			 */
 		}
 
-		extent = btrfs_item_ptr(leaf, path->slots[0],
-					struct btrfs_file_extent_item);
-		type = btrfs_file_extent_type(leaf, extent);
+		header = btrfs_item_ptr(leaf, path->slots[0],
+					struct btrfs_file_header);
+		type = btrfs_file_header_type(leaf, header);
 
 		/*
 		 * Can't access the extent's disk_bytenr field if this is an
@@ -3704,7 +3702,7 @@ static loff_t find_desired_extent(struct file *file, loff_t offset, int whence)
 		 */
 		if (type == BTRFS_FILE_EXTENT_PREALLOC ||
 		    (type == BTRFS_FILE_EXTENT_REG &&
-		     btrfs_file_extent_disk_bytenr(leaf, extent) == 0)) {
+		     btrfs_file_header_disk_bytenr(leaf, header) == 0)) {
 			/*
 			 * Explicit hole or prealloc extent, search for delalloc.
 			 * A prealloc extent is treated like a hole.
-- 
2.52.0


