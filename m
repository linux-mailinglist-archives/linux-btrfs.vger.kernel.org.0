Return-Path: <linux-btrfs+bounces-1710-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4755B83B011
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 18:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6E35B2B96B
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 17:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C688B7E781;
	Wed, 24 Jan 2024 17:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="xqs2prVe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786E88003B
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 17:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706116792; cv=none; b=Fcd9PHg/aQ20GAuaSg8OkXECjA4fKbPy/qaBB4Mu9Xk0ivoeSwW2ltSQJujLKY731hpLWmwFQ4fIh3AnCWvxObbtjkKIvYK+aNLcQUjajvm0rKFsT4AeOfZqrTbfRwujWWHP5kvV1aqcvb5NcgTSeq67tec6vQLE0Qwn9rkeUww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706116792; c=relaxed/simple;
	bh=61biOJzKFrRIG7hKBHQoERfUEuYuk5TQNt1GnagdIek=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iZgc3mvrKN2EqkxiphnBnuq/1JOkbkRO+BzVv+XUBEvT02tIhQyX0hS1Xp3po/dI6hQRqiOwY6YCGZb0EE7I3G/u1JVY13oE1pRtefhGH42kVCN8+cZuBOjyXvs8sYud5367OHfytS6PL/uloj9mDm3Rw53ENEm+pKsa21BNe2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=xqs2prVe; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dc21d7a7042so5011349276.2
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 09:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706116789; x=1706721589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uWpCqua75ld3SCIeVUgY30PkhqvyQ34+YzyIxStNa7w=;
        b=xqs2prVeI/gN7xGJbwSleGysEzPPz+ea4eFZHuqM4ghvQNPXSPbPzAuZJIST/52prW
         XCq8oau4vpijMhlj9Zab9Z0njdSECP6cxkMsJguCQC+NFEXR2IJ+TYORuy/xssSAL7PV
         WehAhqWK+FQSvYSCi8QGk2um4sWqxyyQqthN5x+SIRvtyUj8QOXMfCr8ZOPWtjrUpOGk
         kfEbFdJtz4FNrLKZGCKIZA6nKrFFuJJKr5CKnkLSZPd5sFt4zC9amQnRbyDUgBXEHWoN
         NC9Ke+LVeXFbSU5J97ZqaHCUPWdOZ/8ixYTL42BFSRv+BeDYSfim38DRKiABNIp1FFYo
         ErYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706116789; x=1706721589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uWpCqua75ld3SCIeVUgY30PkhqvyQ34+YzyIxStNa7w=;
        b=ZEoUGlqdNBCRdibOPFIWinsohYe0mSZmsc7Wlep43Z8IYdX42IAft3MGJY0Hm/Wf1K
         F5ISKnxysSwKC9lN7pvmrl1OpHH2qt8OvNi8Jb93sNpmoVyWu60ArtS5ICRy6AEkegGR
         URY+18J+HncnHHuLVoCCx/E1hnPalXxABu9f2m6SUVG2xx/zcM0E54kAoexxkgHdj1HP
         4EfsTGpPymTBfQ1qF53G9ItFrSgmlcTdfGkaE+oNZuxUiqGCvyRfr0TEXoF05Dcfsbgr
         6sAyA4uOMedB5+rnNSTQ1Cph9AnPUkxCg18q7NFQGl69NKEcys8HHV+CU856sAZm38SZ
         Belw==
X-Gm-Message-State: AOJu0YwpOwsE0JPANM5Yv+aNx20Kkj/GmsbUiD7cnj+zfkgMObLPvfyj
	pg+egbwvs6hA2hN+9VYkYNWgdseYWyV/2kVFuDOf4f5h3Rgi0NkAKchcu0/bX9HiHG7DRZ+t4DI
	G
X-Google-Smtp-Source: AGHT+IFyBZ5Rvvkgygg4ovLWUD5Qxn/emhsRqsFV57uVrjCzZwuZ98xf3nG0QGsuZRmVBkLSmBTBeQ==
X-Received: by 2002:a05:6902:1c5:b0:dc3:72ca:8985 with SMTP id u5-20020a05690201c500b00dc372ca8985mr890143ybh.115.1706116789384;
        Wed, 24 Jan 2024 09:19:49 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id h20-20020a25b194000000b00dc22fa579c5sm2948628ybj.45.2024.01.24.09.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 09:19:49 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v5 28/52] btrfs: add an optional encryption context to the end of file extents
Date: Wed, 24 Jan 2024 12:18:50 -0500
Message-ID: <7ee9171262857336011bf0e121846617c5181fa4.1706116485.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706116485.git.josef@toxicpanda.com>
References: <cover.1706116485.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The fscrypt encryption context can be extended to include different
things in the future.  To facilitate future expansion add an optional
btrfs_encryption_info to the end of the file extent.  This will hold the
size of the context and then will have the binary context tacked onto
the end of the extent item.

Add the appropriate accessors to make it easy to read this information
if we have encryption set, and then update the tree-checker to validate
that if this is indeed set properly that the size matches properly.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/accessors.h            | 48 +++++++++++++++++++++++++++
 fs/btrfs/tree-checker.c         | 58 ++++++++++++++++++++++++++++-----
 include/uapi/linux/btrfs_tree.h | 17 +++++++++-
 3 files changed, 113 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/accessors.h b/fs/btrfs/accessors.h
index cbc176d1dac1..a858f556cf05 100644
--- a/fs/btrfs/accessors.h
+++ b/fs/btrfs/accessors.h
@@ -932,6 +932,10 @@ BTRFS_SETGET_STACK_FUNCS(super_uuid_tree_generation, struct btrfs_super_block,
 BTRFS_SETGET_STACK_FUNCS(super_nr_global_roots, struct btrfs_super_block,
 			 nr_global_roots, 64);
 
+/* struct btrfs_file_extent_encryption_info */
+BTRFS_SETGET_FUNCS(encryption_info_size, struct btrfs_encryption_info, size,
+		   32);
+
 /* struct btrfs_file_extent_item */
 BTRFS_SETGET_STACK_FUNCS(stack_file_extent_type, struct btrfs_file_extent_item,
 			 type, 8);
@@ -973,6 +977,50 @@ BTRFS_SETGET_FUNCS(file_extent_encryption, struct btrfs_file_extent_item,
 BTRFS_SETGET_FUNCS(file_extent_other_encoding, struct btrfs_file_extent_item,
 		   other_encoding, 16);
 
+static inline struct btrfs_encryption_info *btrfs_file_extent_encryption_info(
+					const struct btrfs_file_extent_item *ei)
+{
+	unsigned long offset = (unsigned long)ei;
+
+	offset += offsetof(struct btrfs_file_extent_item, encryption_info);
+	return (struct btrfs_encryption_info *)offset;
+}
+
+static inline unsigned long btrfs_file_extent_encryption_ctx_offset(
+					const struct btrfs_file_extent_item *ei)
+{
+	unsigned long offset = (unsigned long)ei;
+
+	offset += offsetof(struct btrfs_file_extent_item, encryption_info);
+	return offset + offsetof(struct btrfs_encryption_info, context);
+}
+
+static inline u32 btrfs_file_extent_encryption_ctx_size(
+					const struct extent_buffer *eb,
+					const struct btrfs_file_extent_item *ei)
+{
+	return btrfs_encryption_info_size(eb,
+					  btrfs_file_extent_encryption_info(ei));
+}
+
+static inline void btrfs_set_file_extent_encryption_ctx_size(
+						const struct extent_buffer *eb,
+						struct btrfs_file_extent_item *ei,
+						u32 val)
+{
+	btrfs_set_encryption_info_size(eb,
+				       btrfs_file_extent_encryption_info(ei),
+				       val);
+}
+
+static inline u32 btrfs_file_extent_encryption_info_size(
+					const struct extent_buffer *eb,
+					const struct btrfs_file_extent_item *ei)
+{
+	return btrfs_encryption_info_size(eb,
+					  btrfs_file_extent_encryption_info(ei));
+}
+
 /* btrfs_qgroup_status_item */
 BTRFS_SETGET_FUNCS(qgroup_status_generation, struct btrfs_qgroup_status_item,
 		   generation, 64);
diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 1141b5d92ac9..5e11132d49d6 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -212,6 +212,7 @@ static int check_extent_data_item(struct extent_buffer *leaf,
 	u32 item_size = btrfs_item_size(leaf, slot);
 	u64 extent_end;
 	u8 policy;
+	u8 fe_type;
 
 	if (unlikely(!IS_ALIGNED(key->offset, sectorsize))) {
 		file_extent_err(leaf, slot,
@@ -242,12 +243,12 @@ static int check_extent_data_item(struct extent_buffer *leaf,
 				SZ_4K);
 		return -EUCLEAN;
 	}
-	if (unlikely(btrfs_file_extent_type(leaf, fi) >=
-		     BTRFS_NR_FILE_EXTENT_TYPES)) {
+
+	fe_type = btrfs_file_extent_type(leaf, fi);
+	if (unlikely(fe_type >= BTRFS_NR_FILE_EXTENT_TYPES)) {
 		file_extent_err(leaf, slot,
 		"invalid type for file extent, have %u expect range [0, %u]",
-			btrfs_file_extent_type(leaf, fi),
-			BTRFS_NR_FILE_EXTENT_TYPES - 1);
+			fe_type, BTRFS_NR_FILE_EXTENT_TYPES - 1);
 		return -EUCLEAN;
 	}
 
@@ -296,12 +297,51 @@ static int check_extent_data_item(struct extent_buffer *leaf,
 		return 0;
 	}
 
-	/* Regular or preallocated extent has fixed item size */
-	if (unlikely(item_size != sizeof(*fi))) {
-		file_extent_err(leaf, slot,
+	if (policy == BTRFS_ENCRYPTION_FSCRYPT) {
+		size_t fe_size = sizeof(*fi) +
+			sizeof(struct btrfs_encryption_info);
+		u32 ctxsize;
+
+		if (unlikely(item_size < fe_size)) {
+			file_extent_err(leaf, slot,
+	"invalid item size for encrypted file extent, have %u expect = %zu + size of u32",
+					item_size, sizeof(*fi));
+			return -EUCLEAN;
+		}
+
+		ctxsize = btrfs_file_extent_encryption_info_size(leaf, fi);
+		if (unlikely(item_size != (fe_size + ctxsize))) {
+			file_extent_err(leaf, slot,
+	"invalid item size for encrypted file extent, have %u expect = %zu + context of size %u",
+					item_size, fe_size, ctxsize);
+			return -EUCLEAN;
+		}
+
+		if (unlikely(ctxsize > BTRFS_MAX_EXTENT_CTX_SIZE)) {
+			file_extent_err(leaf, slot,
+	"invalid file extent context size, have %u expect a maximum of %u",
+					ctxsize, BTRFS_MAX_EXTENT_CTX_SIZE);
+			return -EUCLEAN;
+		}
+
+		/*
+		 * Only regular and prealloc extents should have an encryption
+		 * context.
+		 */
+		if (unlikely(fe_type != BTRFS_FILE_EXTENT_REG &&
+			     fe_type != BTRFS_FILE_EXTENT_PREALLOC)) {
+			file_extent_err(leaf, slot,
+		"invalid type for encrypted file extent, have %u",
+					btrfs_file_extent_type(leaf, fi));
+			return -EUCLEAN;
+		}
+	} else {
+		if (unlikely(item_size != sizeof(*fi))) {
+			file_extent_err(leaf, slot,
 	"invalid item size for reg/prealloc file extent, have %u expect %zu",
-			item_size, sizeof(*fi));
-		return -EUCLEAN;
+					item_size, sizeof(*fi));
+			return -EUCLEAN;
+		}
 	}
 	if (unlikely(CHECK_FE_ALIGNED(leaf, slot, fi, ram_bytes, sectorsize) ||
 		     CHECK_FE_ALIGNED(leaf, slot, fi, disk_bytenr, sectorsize) ||
diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index effa93df6b90..86362b7f8d25 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -1073,12 +1073,24 @@ enum {
 	BTRFS_NR_FILE_EXTENT_TYPES = 3,
 };
 
+/*
+ * Currently just the FSCRYPT_SET_CONTEXT_MAX_SIZE, which is larger than the
+ * current extent context size from fscrypt, so this should give us plenty of
+ * breathing room for expansion later.
+ */
+#define BTRFS_MAX_EXTENT_CTX_SIZE 40
+
 enum btrfs_encryption_type {
 	BTRFS_ENCRYPTION_NONE,
 	BTRFS_ENCRYPTION_FSCRYPT,
 	BTRFS_NR_ENCRYPTION_TYPES,
 };
 
+struct btrfs_encryption_info {
+	__le32 size;
+	__u8 context[0];
+};
+
 struct btrfs_file_extent_item {
 	/*
 	 * transaction id that created this extent
@@ -1134,7 +1146,10 @@ struct btrfs_file_extent_item {
 	 * always reflects the size uncompressed and without encoding.
 	 */
 	__le64 num_bytes;
-
+	/*
+	 * the encryption info, if any
+	 */
+	struct btrfs_encryption_info encryption_info[0];
 } __attribute__ ((__packed__));
 
 struct btrfs_csum_item {
-- 
2.43.0


