Return-Path: <linux-btrfs+bounces-20012-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED61CDE56A
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Dec 2025 06:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34455300F8AC
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Dec 2025 05:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E7F241663;
	Fri, 26 Dec 2025 05:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="pQ6xKiPW";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="pQ6xKiPW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84BA23D29F
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Dec 2025 05:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766726002; cv=none; b=WnLGzJasPdJW4GB47bG095ygZ812GfUS9WxIAq494jR4ryjSt0SXLTxU5Ls921MmVRB1YPim45Rhy51dOkeCJEqozF2EnMpRxhoUJIpbC/JLwNHneW7WcYSFweD1y8oLAzLVUVhsXwsMbVxzcQgnop59cVYPofQrBWvP8oNHmt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766726002; c=relaxed/simple;
	bh=7vJMmQO/vwvTaclVnCK05fPrZKsSdq8mQ/8CYnd8UJM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rttN4ZjTUpXMuJtPoSwvbkkcpQ5JSiMqr4SEsRY8Bu7Mq9KDHEvtw4jG/PdfDVbeAxp7GVNFE+PXZfTqYVNfbINRPnCstLM4GGiJ0UW5XzLLZZiZCU5dNvG7JM1VBz3aJSEvMZfl/cgRXm/NS8O8zxMRrcVn76qXTPGw2ETS/Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=pQ6xKiPW; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=pQ6xKiPW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 89F5E336FB
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Dec 2025 05:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1766725997; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XP1JJfC45QmGGxl0z3rkeM/tDM11SxNLbv6Xjmw3tNo=;
	b=pQ6xKiPWpiFTQz1k3LQKbek3LuAfhsylmlYCg0FQmsUw/tRBKGcsIrGMFaYExAuQ8bkz1c
	sCNLn37hTlGJIAiioXYzEKT3xuZJqrJ35HiAUernVQOLyfDdhiO/mzuB9URFXy0NHZNWpT
	/WcSNdsJZ/PwYSYvU06eqz2RiaAU3CY=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=pQ6xKiPW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1766725997; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XP1JJfC45QmGGxl0z3rkeM/tDM11SxNLbv6Xjmw3tNo=;
	b=pQ6xKiPWpiFTQz1k3LQKbek3LuAfhsylmlYCg0FQmsUw/tRBKGcsIrGMFaYExAuQ8bkz1c
	sCNLn37hTlGJIAiioXYzEKT3xuZJqrJ35HiAUernVQOLyfDdhiO/mzuB9URFXy0NHZNWpT
	/WcSNdsJZ/PwYSYvU06eqz2RiaAU3CY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BC9363EA63
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Dec 2025 05:13:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uOOZH2wZTmn1DQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Dec 2025 05:13:16 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/7] btrfs: introduce btrfs_file_header structure
Date: Fri, 26 Dec 2025 15:42:47 +1030
Message-ID: <b13c09fff7fc9bbf5083b41bc3caea2c57953bf2.1766725912.git.wqu@suse.com>
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
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:dkim,suse.com:mid];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
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
X-Rspamd-Queue-Id: 89F5E336FB
X-Spam-Flag: NO
X-Spam-Score: -4.01

Currently we have two major types of btrfs_file_extent_item:

- Inline ones
  btrfs_file_extent_item::type is BTRFS_FILE_EXTENT_INLINE, and
  the inline data starts at btrfs_file_extent_item::disk_bytenr.

- Regular ones
  Utilize the full btrfs_file_extent_item structure.

This means we need to use things like
"offsetof(struct btrfs_file_extent_item, disk_bytenr)" to calculate the
size of the header part, and always need to check
btrfs_file_extent_item::type before utilizing the remaining members.

This increases the possibility of accessing member beyond the item
boundary for inlined file extents.

Here introduce a new btrfs_file_header structure to cover the shared
part. Originally I'm planning to utilize ms-extension to define an
unnamed structure inside btrfs_file_extent_item, but unfortunately that
only compiles on x86_64, not on arm64.

Thus this patch goes the safer way by manually define a structure with
duplicated members.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/accessors.h            |  4 +++
 fs/btrfs/ctree.c                |  2 +-
 fs/btrfs/file-item.h            | 11 +++---
 fs/btrfs/tree-checker.c         |  8 ++---
 include/uapi/linux/btrfs_tree.h | 61 +++++++++++++++++++++------------
 5 files changed, 52 insertions(+), 34 deletions(-)

diff --git a/fs/btrfs/accessors.h b/fs/btrfs/accessors.h
index 78721412951c..1568fd00e7d4 100644
--- a/fs/btrfs/accessors.h
+++ b/fs/btrfs/accessors.h
@@ -903,6 +903,10 @@ BTRFS_SETGET_FUNCS(file_extent_encryption, struct btrfs_file_extent_item,
 BTRFS_SETGET_FUNCS(file_extent_other_encoding, struct btrfs_file_extent_item,
 		   other_encoding, 16);
 
+/* Members before @disk_bytenr must match btrfs_file_header. */
+static_assert(sizeof(struct btrfs_file_header) ==
+	      offsetof(struct btrfs_file_extent_item, disk_bytenr));
+
 /* btrfs_qgroup_status_item */
 BTRFS_SETGET_FUNCS(qgroup_status_generation, struct btrfs_qgroup_status_item,
 		   generation, 64);
diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 7267b2502665..e859c4355f92 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -4075,7 +4075,7 @@ void btrfs_truncate_item(struct btrfs_trans_handle *trans,
 				ptr = btrfs_item_ptr_offset(leaf, slot);
 				memmove_extent_buffer(leaf, ptr,
 				      (unsigned long)fi,
-				      BTRFS_FILE_EXTENT_INLINE_DATA_START);
+				      sizeof(struct btrfs_file_header));
 			}
 		}
 
diff --git a/fs/btrfs/file-item.h b/fs/btrfs/file-item.h
index 5645c5e3abdb..1394ae33fc6d 100644
--- a/fs/btrfs/file-item.h
+++ b/fs/btrfs/file-item.h
@@ -20,12 +20,9 @@ struct btrfs_ordered_sum;
 struct btrfs_path;
 struct btrfs_inode;
 
-#define BTRFS_FILE_EXTENT_INLINE_DATA_START		\
-		(offsetof(struct btrfs_file_extent_item, disk_bytenr))
-
 static inline u32 BTRFS_MAX_INLINE_DATA_SIZE(const struct btrfs_fs_info *info)
 {
-	return BTRFS_MAX_ITEM_SIZE(info) - BTRFS_FILE_EXTENT_INLINE_DATA_START;
+	return BTRFS_MAX_ITEM_SIZE(info) - sizeof(struct btrfs_file_header);
 }
 
 /*
@@ -37,18 +34,18 @@ static inline u32 btrfs_file_extent_inline_item_len(
 						const struct extent_buffer *eb,
 						int nr)
 {
-	return btrfs_item_size(eb, nr) - BTRFS_FILE_EXTENT_INLINE_DATA_START;
+	return btrfs_item_size(eb, nr) - sizeof(struct btrfs_file_header);
 }
 
 static inline unsigned long btrfs_file_extent_inline_start(
 				const struct btrfs_file_extent_item *e)
 {
-	return (unsigned long)e + BTRFS_FILE_EXTENT_INLINE_DATA_START;
+	return (unsigned long)e + sizeof(struct btrfs_file_header);
 }
 
 static inline u32 btrfs_file_extent_calc_inline_size(u32 datasize)
 {
-	return BTRFS_FILE_EXTENT_INLINE_DATA_START + datasize;
+	return sizeof(struct btrfs_file_header) + datasize;
 }
 
 int btrfs_del_csums(struct btrfs_trans_handle *trans,
diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index c21c21adf61e..7bd2f543fec9 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -236,10 +236,10 @@ static int check_extent_data_item(struct extent_buffer *leaf,
 	 * Make sure the item contains at least inline header, so the file
 	 * extent type is not some garbage.
 	 */
-	if (unlikely(item_size < BTRFS_FILE_EXTENT_INLINE_DATA_START)) {
+	if (unlikely(item_size < sizeof(struct btrfs_file_header))) {
 		file_extent_err(leaf, slot,
 				"invalid item size, have %u expect [%zu, %u)",
-				item_size, BTRFS_FILE_EXTENT_INLINE_DATA_START,
+				item_size, sizeof(struct btrfs_file_header),
 				SZ_4K);
 		return -EUCLEAN;
 	}
@@ -285,11 +285,11 @@ static int check_extent_data_item(struct extent_buffer *leaf,
 			return 0;
 
 		/* Uncompressed inline extent size must match item size */
-		if (unlikely(item_size != BTRFS_FILE_EXTENT_INLINE_DATA_START +
+		if (unlikely(item_size != sizeof(struct btrfs_file_header) +
 					  btrfs_file_extent_ram_bytes(leaf, fi))) {
 			file_extent_err(leaf, slot,
 	"invalid ram_bytes for uncompressed inline extent, have %u expect %llu",
-				item_size, BTRFS_FILE_EXTENT_INLINE_DATA_START +
+				item_size, sizeof(struct btrfs_file_header) +
 				btrfs_file_extent_ram_bytes(leaf, fi));
 			return -EUCLEAN;
 		}
diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index fc29d273845d..4363b55293eb 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -1065,17 +1065,19 @@ enum {
 	BTRFS_NR_FILE_EXTENT_TYPES = 3,
 };
 
-struct btrfs_file_extent_item {
-	/*
-	 * transaction id that created this extent
-	 */
+/*
+ * This is the header part of btrfs_file_extent_item.
+ *
+ * The members are shared by this and btrfs_file_extent_item structure.
+ * @type determines which structure to be utilized.
+ */
+struct btrfs_file_header {
+	/* Transaction id that created this extent. */
 	__le64 generation;
+
 	/*
-	 * max number of bytes to hold this extent in ram
-	 * when we split a compressed extent we can't know how big
-	 * each of the resulting pieces will be.  So, this is
-	 * an upper limit on the size of the extent in ram instead of
-	 * an exact limit.
+	 * Number of bytes of the final content (after decompress/
+	 * decrypt/decoded).
 	 */
 	__le64 ram_bytes;
 
@@ -1090,29 +1092,44 @@ struct btrfs_file_extent_item {
 	__u8 encryption;
 	__le16 other_encoding; /* spare for later use */
 
-	/* are we inline data or a real extent? */
+	/*
+	 * Type of the above BTRFS_FILE_EXTENT_* value.
+	 *
+	 * For INLINE type, the data starts immediately after this structure.
+	 */
+	__u8 type;
+
+} __attribute__ ((__packed__));
+
+struct btrfs_file_extent_item {
+	/* The following ones must match btrfs_file_header. */
+	__le64 generation;
+	__le64 ram_bytes;
+	__u8 compression;
+	__u8 encryption;
+	__le16 other_encoding;
 	__u8 type;
 
 	/*
-	 * disk space consumed by the extent, checksum blocks are included
-	 * in these numbers
+	 * The logical address and length of the file extent, are in byte unit.
+	 * Which is after compression/encryption/encoding.
 	 *
-	 * At this offset in the structure, the inline extent data start.
+	 * Doesn't include any checksum (which is stored separately inside csum
+	 * tree).
 	 */
 	__le64 disk_bytenr;
 	__le64 disk_num_bytes;
+
 	/*
-	 * the logical offset in file blocks (no csums)
-	 * this extent record is for.  This allows a file extent to point
-	 * into the middle of an existing extent on disk, sharing it
-	 * between two snapshots (useful if some bytes in the middle of the
-	 * extent have changed
+	 * @offset and @num_bytes are the range inside the final content
+	 * (after decompress/decrypt/decoded), and are in byte unit.
+	 * This range must be inside btrfs_file_extent_header::ram_bytes.
+	 *
+	 * This allows a file extent to point into the middle of an existing
+	 * extent on disk, sharing it between two snapshots (useful if some
+	 * bytes in the middle of the extent have changed).
 	 */
 	__le64 offset;
-	/*
-	 * the logical number of file blocks (no csums included).  This
-	 * always reflects the size uncompressed and without encoding.
-	 */
 	__le64 num_bytes;
 
 } __attribute__ ((__packed__));
-- 
2.52.0


