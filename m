Return-Path: <linux-btrfs+bounces-509-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB74801604
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Dec 2023 23:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 823091C20FFE
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Dec 2023 22:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE43359E29;
	Fri,  1 Dec 2023 22:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="NKx4qtXj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D1310EA
	for <linux-btrfs@vger.kernel.org>; Fri,  1 Dec 2023 14:12:33 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5d34d85e610so25972227b3.3
        for <linux-btrfs@vger.kernel.org>; Fri, 01 Dec 2023 14:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1701468752; x=1702073552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b9RfA7n1NXi8m/qaMDWuy5KBTwX4TEpS23gnV0lnWV4=;
        b=NKx4qtXjLjSB5aBO9Bwa6rO8ZnxWfBBcXEVJhYtwlSpnyLLOngUP9Xg0Z+VTiuDyIW
         4kInL3dW+yfg3W6amJBun9BKzX7a28OIF0WkErKyXu93PBb2O3vmeUo2sWqZutVAjypo
         cEc8m1OLzEFC4IJrnksyv6OCCyoFko5SIcO82wT4pox7+t/xv+SKngd0NcI02b4f/ELN
         uImqEiCDXrpeFhjLEdsd3H6OiVf78uK4RlZjHl1pCPfNoS8X0F4FRg2UfT/tHypo/pDq
         3gOUPYu3o7SeBaiNxAb6Wi0CzuLMweJY01M/iJOrtjUPOjOYPC5WNzkvw0+TZEjslA6s
         bVAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701468752; x=1702073552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b9RfA7n1NXi8m/qaMDWuy5KBTwX4TEpS23gnV0lnWV4=;
        b=QT6HhA3ESfPpL2znq1uNo+rDulABmui0+A6u0UOpOJM2IDrcVrctptOar89mwACHA4
         fvM3rMKXWNkJWHjVou7D8+gEh3rBCOW040qI+iVHMNFkLQtRW1DzgCh2ftUjdvEyYu/W
         idmouqUv5jRzdfUr77f8JaPbsEnQLDeAoCcyHw8eB/fyiDzfnMKTgnOKz29S32Pmy/73
         5sudn+HgwmHOrBLMpjOTMUwfgxJY2RC2qHLGOPXs/4MYU2WwYIQPYscJL+F2SBkIRCT9
         t43aSBm5DMUT2y7AgQ9T9C4AfIR1sYjW50P+/GyKx4gBm4StX7p1oA98SIj9R6mduUdo
         p8kA==
X-Gm-Message-State: AOJu0Yy+X5JOOyM1uCeJXr9MT+BFEOMTBIzM7HtYNTIrK1MqqPyp0cNd
	RkqumuIcj7DlMY4QvaGvAyW9SsbbVah9pwRwSMgEzg==
X-Google-Smtp-Source: AGHT+IHqbgggU/vawI/jybppcyduEYAhOOVPOFkmFa78aSx7RFWPDkf+/WsDgsI+VThZcRo1G2yC9Q==
X-Received: by 2002:a0d:ca46:0:b0:5d7:1940:7d72 with SMTP id m67-20020a0dca46000000b005d719407d72mr210426ywd.73.1701468752718;
        Fri, 01 Dec 2023 14:12:32 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id m184-20020a0dcac1000000b005c862c66ffasm1395957ywd.16.2023.12.01.14.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 14:12:27 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 27/46] btrfs: add an optional encryption context to the end of file extents
Date: Fri,  1 Dec 2023 17:11:24 -0500
Message-ID: <1babac314ded699b29801993cc1c752ebcca127d.1701468306.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1701468305.git.josef@toxicpanda.com>
References: <cover.1701468305.git.josef@toxicpanda.com>
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
index 5aaf204fa55f..a54a4671bd15 100644
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
index 1af2c967436b..ccf1bf59d7e0 100644
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
index af56a5eb3a00..4d352666b393 100644
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
 enum {
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
2.41.0


