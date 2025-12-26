Return-Path: <linux-btrfs+bounces-20013-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AC093CDE570
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Dec 2025 06:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 480F53013ED1
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Dec 2025 05:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C4124677D;
	Fri, 26 Dec 2025 05:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uvu3Lb1H";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uvu3Lb1H"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40BB23FC41
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Dec 2025 05:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766726009; cv=none; b=LqDWXMxzMWJvS4P+74seS+bSJOCR2R5Z2q6NrOpWLkJPeusga+qAlXV1aB93YGC+Yj4OqH8u+YZxKKNh3sLlTusjLMOLiLEBIA2gizavYJuv++jn6DagvxTsjSrguuujlXIXYrDbE46y+f11txwSVVtGjqgdiavCHUFwYCCDYXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766726009; c=relaxed/simple;
	bh=hPC4lbNF9UAq58vmr7pV3D+ZDfoc5g0ncKrK6KGKpL0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WnKIuHKD1AeWOd/eEoWt7SdXKdBz7x9xLVjNIZpLaAEG4mIqe77Jw/nSjlW3OT9z04DfKZsGPgnr7qzbo5Gr/fIjydL86SMpfkWMuHnynyXRxRIEJ6biLHmkbvfKoHgxll/x6RVscgFcHT321VQcQRYjRS2091sGqmLPbvSWX9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=uvu3Lb1H; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=uvu3Lb1H; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B1F8A33688
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Dec 2025 05:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1766725998; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=31PHn0Y9lAu17hJuUD9WPSOeSfQlX1kHQ5QIS4nju6Y=;
	b=uvu3Lb1HUAC0xv+iWnVl+zvCTn6UUo5fhWJ8fU/UPpAWNIHFsncFKeaEDwRa9WymFHtH0X
	3CTBXGY4zCOth6KA0gFOKTglE+NAy1zTgtdCJ2lYqDYB8GFvfarCS+vOdoxFF9Ca3pE4OS
	s1r/SV1n946TVTuCyKZQVMG1U9fmQqc=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1766725998; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=31PHn0Y9lAu17hJuUD9WPSOeSfQlX1kHQ5QIS4nju6Y=;
	b=uvu3Lb1HUAC0xv+iWnVl+zvCTn6UUo5fhWJ8fU/UPpAWNIHFsncFKeaEDwRa9WymFHtH0X
	3CTBXGY4zCOth6KA0gFOKTglE+NAy1zTgtdCJ2lYqDYB8GFvfarCS+vOdoxFF9Ca3pE4OS
	s1r/SV1n946TVTuCyKZQVMG1U9fmQqc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F04BA3EA63
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Dec 2025 05:13:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aLtGLG0ZTmn1DQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Dec 2025 05:13:17 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/7] btrfs: use btrfs_file_header structure for tree-checker
Date: Fri, 26 Dec 2025 15:42:48 +1030
Message-ID: <54875d2d06c7695488d37dc6080454819b6a3ea6.1766725912.git.wqu@suse.com>
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
X-Spamd-Result: default: False [-2.68 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	NEURAL_HAM_SHORT(-0.08)[-0.400];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	URIBL_BLOCKED(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.68

This introduces the following accessors:

- btrfs_file_header members accessors
  The usual eb and on-stack versions.

- btrfs_file_extent_item exclusive members accessors through
  btrfs_file_header
  This will do the extra type casting with proper type checks to make
  sure (by ASSERT()) that the type is not BTRFS_FILE_EXTENT_INLINE.

  This should help us to catch unsafe file extent item access.

In short, there should only be two ways to access btrfs_file_extent_item
exclusive members:

- Use btrfs_file_header_*() helpers
  This should be the most common ones.

- Use btrfs_file_header_to_item() helper, then the usual
  btrfs_file_extent_*() helpers
  This is less recommended.

Tree-checker is the first one to migrate to the btrfs_file_header
structure, and most call sites are migrated to use btrfs_file_header_*()
helpers.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/accessors.h    | 75 +++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/tree-checker.c | 74 ++++++++++++++++++++--------------------
 2 files changed, 113 insertions(+), 36 deletions(-)

diff --git a/fs/btrfs/accessors.h b/fs/btrfs/accessors.h
index 1568fd00e7d4..672425e3f10a 100644
--- a/fs/btrfs/accessors.h
+++ b/fs/btrfs/accessors.h
@@ -864,6 +864,81 @@ BTRFS_SETGET_STACK_FUNCS(super_uuid_tree_generation, struct btrfs_super_block,
 BTRFS_SETGET_STACK_FUNCS(super_nr_global_roots, struct btrfs_super_block,
 			 nr_global_roots, 64);
 
+/* struct btrfs_file_header */
+BTRFS_SETGET_STACK_FUNCS(stack_file_header_generation,
+			 struct btrfs_file_header, generation, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_file_header_ram_bytes,
+			 struct btrfs_file_header, ram_bytes, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_file_header_compression,
+			 struct btrfs_file_header, compression, 8);
+BTRFS_SETGET_STACK_FUNCS(stack_file_header_encryption,
+			 struct btrfs_file_header, encryption, 8);
+BTRFS_SETGET_STACK_FUNCS(stack_file_header_other_encoding,
+			 struct btrfs_file_header, other_encoding, 16);
+BTRFS_SETGET_STACK_FUNCS(stack_file_header_type,
+			 struct btrfs_file_header, type, 8);
+BTRFS_SETGET_FUNCS(file_header_generation, struct btrfs_file_header,
+		   generation, 64);
+BTRFS_SETGET_FUNCS(file_header_ram_bytes, struct btrfs_file_header,
+		   ram_bytes, 64);
+BTRFS_SETGET_FUNCS(file_header_compression, struct btrfs_file_header,
+		   compression, 8);
+BTRFS_SETGET_FUNCS(file_header_encryption, struct btrfs_file_header,
+		   encryption, 8);
+BTRFS_SETGET_FUNCS(file_header_other_encoding, struct btrfs_file_header,
+		   other_encoding, 16);
+BTRFS_SETGET_FUNCS(file_header_type, struct btrfs_file_header,
+		   type, 8);
+
+/*
+ * Safely convert a file_header pointer to a file_extent_item one, with
+ * extra type checks.
+ */
+static inline struct btrfs_file_extent_item*
+btrfs_file_header_to_item(const struct extent_buffer *leaf,
+			  const struct btrfs_file_header *header)
+{
+	ASSERT(btrfs_file_header_type(leaf, header) != BTRFS_FILE_EXTENT_INLINE);
+	return (struct btrfs_file_extent_item *)header;
+}
+
+/*
+ * The extra ones are to access btrfs_file_extent_item exclusive members, which
+ * needs to check btrfs_file_header::type first to make sure it's not an
+ * inlined one.
+ * Or such access can lead to out-of-boundary access.
+ *
+ * The input pointer should always be a btrfs_file_header pointer, and the type
+ * casting is done internally with proper type ASSERT().
+ */
+#define BTRFS_SETGET_FILE_ITEM_FUNCS(name, member, bits)		\
+static inline u##bits btrfs_##name(const struct extent_buffer *eb,	\
+				const struct btrfs_file_header *header) \
+{									\
+	struct btrfs_file_extent_item *item =				\
+		btrfs_file_header_to_item(eb, header);			\
+									\
+	return btrfs_get_##bits(eb, item,				\
+				offsetof(struct btrfs_file_extent_item, \
+					member));			\
+}									\
+static inline void btrfs_set_##name(const struct extent_buffer *eb,	\
+				const struct btrfs_file_header *header,	\
+				u##bits val)				\
+{									\
+	struct btrfs_file_extent_item *item =				\
+		btrfs_file_header_to_item(eb, header);			\
+									\
+	return btrfs_set_##bits(eb, item,				\
+				offsetof(struct btrfs_file_extent_item, \
+					member), val);			\
+}
+
+BTRFS_SETGET_FILE_ITEM_FUNCS(file_header_disk_bytenr, disk_bytenr, 64);
+BTRFS_SETGET_FILE_ITEM_FUNCS(file_header_disk_num_bytes, disk_num_bytes, 64);
+BTRFS_SETGET_FILE_ITEM_FUNCS(file_header_offset, offset, 64);
+BTRFS_SETGET_FILE_ITEM_FUNCS(file_header_num_bytes, num_bytes, 64);
+
 /* struct btrfs_file_extent_item */
 BTRFS_SETGET_STACK_FUNCS(stack_file_extent_type, struct btrfs_file_extent_item,
 			 type, 8);
diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 7bd2f543fec9..2d8c7587623c 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -106,8 +106,10 @@ static void file_extent_err(const struct extent_buffer *eb, int slot,
  * Return 0 if the btrfs_file_extent_##name is aligned to @alignment
  * Else return 1
  */
-#define CHECK_FE_ALIGNED(leaf, slot, fi, name, alignment)		      \
+#define CHECK_FE_ALIGNED(leaf, slot, fh, name, alignment)		      \
 ({									      \
+	struct btrfs_file_extent_item *fi = btrfs_file_header_to_item(leaf, fh); \
+									      \
 	if (unlikely(!IS_ALIGNED(btrfs_file_extent_##name((leaf), (fi)),      \
 				 (alignment))))				      \
 		file_extent_err((leaf), (slot),				      \
@@ -119,16 +121,16 @@ static void file_extent_err(const struct extent_buffer *eb, int slot,
 
 static u64 file_extent_end(struct extent_buffer *leaf,
 			   struct btrfs_key *key,
-			   struct btrfs_file_extent_item *extent)
+			   struct btrfs_file_header *header)
 {
 	u64 end;
 	u64 len;
 
-	if (btrfs_file_extent_type(leaf, extent) == BTRFS_FILE_EXTENT_INLINE) {
-		len = btrfs_file_extent_ram_bytes(leaf, extent);
+	if (btrfs_file_header_type(leaf, header) == BTRFS_FILE_EXTENT_INLINE) {
+		len = btrfs_file_header_ram_bytes(leaf, header);
 		end = ALIGN(key->offset + len, leaf->fs_info->sectorsize);
 	} else {
-		len = btrfs_file_extent_num_bytes(leaf, extent);
+		len = btrfs_file_header_num_bytes(leaf, header);
 		end = key->offset + len;
 	}
 	return end;
@@ -209,7 +211,7 @@ static int check_extent_data_item(struct extent_buffer *leaf,
 				  struct btrfs_key *prev_key)
 {
 	struct btrfs_fs_info *fs_info = leaf->fs_info;
-	struct btrfs_file_extent_item *fi;
+	struct btrfs_file_header *fh;
 	u32 sectorsize = fs_info->sectorsize;
 	u32 item_size = btrfs_item_size(leaf, slot);
 	u64 extent_end;
@@ -230,7 +232,7 @@ static int check_extent_data_item(struct extent_buffer *leaf,
 	if (unlikely(!check_prev_ino(leaf, key, slot, prev_key)))
 		return -EUCLEAN;
 
-	fi = btrfs_item_ptr(leaf, slot, struct btrfs_file_extent_item);
+	fh = btrfs_item_ptr(leaf, slot, struct btrfs_file_header);
 
 	/*
 	 * Make sure the item contains at least inline header, so the file
@@ -243,11 +245,11 @@ static int check_extent_data_item(struct extent_buffer *leaf,
 				SZ_4K);
 		return -EUCLEAN;
 	}
-	if (unlikely(btrfs_file_extent_type(leaf, fi) >=
+	if (unlikely(btrfs_file_header_type(leaf, fh) >=
 		     BTRFS_NR_FILE_EXTENT_TYPES)) {
 		file_extent_err(leaf, slot,
 		"invalid type for file extent, have %u expect range [0, %u]",
-			btrfs_file_extent_type(leaf, fi),
+			btrfs_file_header_type(leaf, fh),
 			BTRFS_NR_FILE_EXTENT_TYPES - 1);
 		return -EUCLEAN;
 	}
@@ -256,21 +258,21 @@ static int check_extent_data_item(struct extent_buffer *leaf,
 	 * Support for new compression/encryption must introduce incompat flag,
 	 * and must be caught in open_ctree().
 	 */
-	if (unlikely(btrfs_file_extent_compression(leaf, fi) >=
+	if (unlikely(btrfs_file_header_compression(leaf, fh) >=
 		     BTRFS_NR_COMPRESS_TYPES)) {
 		file_extent_err(leaf, slot,
 	"invalid compression for file extent, have %u expect range [0, %u]",
-			btrfs_file_extent_compression(leaf, fi),
+			btrfs_file_header_compression(leaf, fh),
 			BTRFS_NR_COMPRESS_TYPES - 1);
 		return -EUCLEAN;
 	}
-	if (unlikely(btrfs_file_extent_encryption(leaf, fi))) {
+	if (unlikely(btrfs_file_header_encryption(leaf, fh))) {
 		file_extent_err(leaf, slot,
 			"invalid encryption for file extent, have %u expect 0",
-			btrfs_file_extent_encryption(leaf, fi));
+			btrfs_file_header_encryption(leaf, fh));
 		return -EUCLEAN;
 	}
-	if (btrfs_file_extent_type(leaf, fi) == BTRFS_FILE_EXTENT_INLINE) {
+	if (btrfs_file_header_type(leaf, fh) == BTRFS_FILE_EXTENT_INLINE) {
 		/* Inline extent must have 0 as key offset */
 		if (unlikely(key->offset)) {
 			file_extent_err(leaf, slot,
@@ -280,43 +282,43 @@ static int check_extent_data_item(struct extent_buffer *leaf,
 		}
 
 		/* Compressed inline extent has no on-disk size, skip it */
-		if (btrfs_file_extent_compression(leaf, fi) !=
+		if (btrfs_file_header_compression(leaf, fh) !=
 		    BTRFS_COMPRESS_NONE)
 			return 0;
 
 		/* Uncompressed inline extent size must match item size */
 		if (unlikely(item_size != sizeof(struct btrfs_file_header) +
-					  btrfs_file_extent_ram_bytes(leaf, fi))) {
+					  btrfs_file_header_ram_bytes(leaf, fh))) {
 			file_extent_err(leaf, slot,
 	"invalid ram_bytes for uncompressed inline extent, have %u expect %llu",
 				item_size, sizeof(struct btrfs_file_header) +
-				btrfs_file_extent_ram_bytes(leaf, fi));
+				btrfs_file_header_ram_bytes(leaf, fh));
 			return -EUCLEAN;
 		}
 		return 0;
 	}
 
 	/* Regular or preallocated extent has fixed item size */
-	if (unlikely(item_size != sizeof(*fi))) {
+	if (unlikely(item_size != sizeof(struct btrfs_file_extent_item))) {
 		file_extent_err(leaf, slot,
 	"invalid item size for reg/prealloc file extent, have %u expect %zu",
-			item_size, sizeof(*fi));
+			item_size, sizeof(struct btrfs_file_extent_item));
 		return -EUCLEAN;
 	}
-	if (unlikely(CHECK_FE_ALIGNED(leaf, slot, fi, ram_bytes, sectorsize) ||
-		     CHECK_FE_ALIGNED(leaf, slot, fi, disk_bytenr, sectorsize) ||
-		     CHECK_FE_ALIGNED(leaf, slot, fi, disk_num_bytes, sectorsize) ||
-		     CHECK_FE_ALIGNED(leaf, slot, fi, offset, sectorsize) ||
-		     CHECK_FE_ALIGNED(leaf, slot, fi, num_bytes, sectorsize)))
+	if (unlikely(CHECK_FE_ALIGNED(leaf, slot, fh, ram_bytes, sectorsize) ||
+		     CHECK_FE_ALIGNED(leaf, slot, fh, disk_bytenr, sectorsize) ||
+		     CHECK_FE_ALIGNED(leaf, slot, fh, disk_num_bytes, sectorsize) ||
+		     CHECK_FE_ALIGNED(leaf, slot, fh, offset, sectorsize) ||
+		     CHECK_FE_ALIGNED(leaf, slot, fh, num_bytes, sectorsize)))
 		return -EUCLEAN;
 
 	/* Catch extent end overflow */
-	if (unlikely(check_add_overflow(btrfs_file_extent_num_bytes(leaf, fi),
+	if (unlikely(check_add_overflow(btrfs_file_header_num_bytes(leaf, fh),
 					key->offset, &extent_end))) {
 		file_extent_err(leaf, slot,
 	"extent end overflow, have file offset %llu extent num bytes %llu",
 				key->offset,
-				btrfs_file_extent_num_bytes(leaf, fi));
+				btrfs_file_header_num_bytes(leaf, fh));
 		return -EUCLEAN;
 	}
 
@@ -327,12 +329,12 @@ static int check_extent_data_item(struct extent_buffer *leaf,
 	if (slot > 0 &&
 	    prev_key->objectid == key->objectid &&
 	    prev_key->type == BTRFS_EXTENT_DATA_KEY) {
-		struct btrfs_file_extent_item *prev_fi;
+		struct btrfs_file_header *prev_fh;
 		u64 prev_end;
 
-		prev_fi = btrfs_item_ptr(leaf, slot - 1,
-					 struct btrfs_file_extent_item);
-		prev_end = file_extent_end(leaf, prev_key, prev_fi);
+		prev_fh = btrfs_item_ptr(leaf, slot - 1,
+					 struct btrfs_file_header);
+		prev_end = file_extent_end(leaf, prev_key, prev_fh);
 		if (unlikely(prev_end > key->offset)) {
 			file_extent_err(leaf, slot - 1,
 "file extent end range (%llu) goes beyond start offset (%llu) of the next file extent",
@@ -349,14 +351,14 @@ static int check_extent_data_item(struct extent_buffer *leaf,
 	 * unexpected behaviors.
 	 */
 	if (IS_ENABLED(CONFIG_BTRFS_DEBUG) &&
-	    btrfs_file_extent_compression(leaf, fi) == BTRFS_COMPRESS_NONE &&
-	    btrfs_file_extent_disk_bytenr(leaf, fi)) {
-		if (WARN_ON(btrfs_file_extent_ram_bytes(leaf, fi) !=
-			    btrfs_file_extent_disk_num_bytes(leaf, fi)))
+	    btrfs_file_header_compression(leaf, fh) == BTRFS_COMPRESS_NONE &&
+	    btrfs_file_header_disk_bytenr(leaf, fh)) {
+		if (WARN_ON(btrfs_file_header_ram_bytes(leaf, fh) !=
+			    btrfs_file_header_disk_num_bytes(leaf, fh)))
 			file_extent_err(leaf, slot,
 "mismatch ram_bytes (%llu) and disk_num_bytes (%llu) for non-compressed extent",
-					btrfs_file_extent_ram_bytes(leaf, fi),
-					btrfs_file_extent_disk_num_bytes(leaf, fi));
+					btrfs_file_header_ram_bytes(leaf, fh),
+					btrfs_file_header_disk_num_bytes(leaf, fh));
 	}
 
 	return 0;
-- 
2.52.0


