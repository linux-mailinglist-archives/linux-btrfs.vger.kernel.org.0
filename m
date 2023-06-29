Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0A8742DF4
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jun 2023 22:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbjF2T6i (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Jun 2023 15:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjF2T62 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Jun 2023 15:58:28 -0400
Received: from box.fidei.email (box.fidei.email [IPv6:2605:2700:0:2:a800:ff:feba:dc44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170F81FC0
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Jun 2023 12:58:26 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 6D84880AE0;
        Thu, 29 Jun 2023 15:58:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1688068706; bh=UDARkU4OJmJgupwWCeVV25TAENWyUquPRTK6aoAJWS0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M/gBQRXA1F8Wa4X71a0EQNaOUCumC8jCzQ/4ApQThk9sM6t57TKffRo++yQNAm7sB
         5WLBlLnCmB8xJzUEwiUhxMpx1iwz+GXGrJX5qdsGCsLQXvwe9ecbFzJZL3djyIMyNC
         Dm+fToBjxw0yTyIDASRzhwYgBtz9cPcJEJ9CZolBtnivHc6b56VslN2o6g7LJoSk67
         1efiCcp1df4CQmzXNpFwL54K7OL6o9rlizxrTeP1Ba4EnJ4XhEXx3qA6QGmHPaX2wq
         aUtamcUb9KuLX8mFBKCawcScTFXCgnuBa5+k6bwmEzo2G7pluwXb3KO/DEDNy+xV3z
         t7/8KI+s0pkZg==
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     linux-btrfs@vger.kernel.org, kernel-team@meta.com
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH 2/8] progs: start tracking extent encryption context info
Date:   Thu, 29 Jun 2023 15:58:02 -0400
Message-Id: <7622bb496363cb8e882b8516b0e89288bb3bdbc6.1688068150.git.sweettea-kernel@dorminy.me>
In-Reply-To: <cover.1688068150.git.sweettea-kernel@dorminy.me>
References: <cover.1688068150.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SBL_CSS,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This recapitulates the kernel change named 'btrfs: start tracking extent
encryption context info".

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 kernel-shared/accessors.h    | 31 ++++++++++++++++++++++++++++++
 kernel-shared/fscrypt.h      | 30 +++++++++++++++++++++++++++++
 kernel-shared/tree-checker.c | 37 ++++++++++++++++++++++++++++--------
 3 files changed, 90 insertions(+), 8 deletions(-)
 create mode 100644 kernel-shared/fscrypt.h

diff --git a/kernel-shared/accessors.h b/kernel-shared/accessors.h
index 539c20d0..62e9282d 100644
--- a/kernel-shared/accessors.h
+++ b/kernel-shared/accessors.h
@@ -3,6 +3,8 @@
 #ifndef BTRFS_ACCESSORS_H
 #define BTRFS_ACCESSORS_H
 
+#include "fscrypt.h"
+
 #include "kerncompat.h"
 
 #ifndef _static_assert
@@ -949,6 +951,16 @@ BTRFS_SETGET_STACK_FUNCS(stack_file_extent_disk_num_bytes,
 			 struct btrfs_file_extent_item, disk_num_bytes, 64);
 BTRFS_SETGET_STACK_FUNCS(stack_file_extent_compression,
 			 struct btrfs_file_extent_item, compression, 8);
+BTRFS_SETGET_STACK_FUNCS(stack_file_extent_encryption,
+			 struct btrfs_file_extent_item, encryption, 8);
+static inline u8 btrfs_stack_file_extent_encryption_ctxsize(
+	struct btrfs_file_extent_item *e)
+{
+	u8 ctxsize;
+
+	btrfs_unpack_encryption(e->encryption, NULL, &ctxsize);
+	return ctxsize;
+}
 
 BTRFS_SETGET_FUNCS(file_extent_type, struct btrfs_file_extent_item, type, 8);
 BTRFS_SETGET_FUNCS(file_extent_disk_bytenr, struct btrfs_file_extent_item,
@@ -970,6 +982,25 @@ BTRFS_SETGET_FUNCS(file_extent_encryption, struct btrfs_file_extent_item,
 BTRFS_SETGET_FUNCS(file_extent_other_encoding, struct btrfs_file_extent_item,
 		   other_encoding, 16);
 
+static inline u8
+btrfs_file_extent_encryption_ctxsize(const struct extent_buffer *eb,
+				     struct btrfs_file_extent_item *e)
+{
+	u8 ctxsize;
+
+	btrfs_unpack_encryption(btrfs_file_extent_encryption(eb, e),
+				NULL, &ctxsize);
+	return ctxsize;
+}
+
+static inline u8
+btrfs_file_extent_ctxsize_from_item(const struct extent_buffer *leaf,
+				    int nr)
+{
+	return (btrfs_item_size(leaf, nr) -
+		sizeof(struct btrfs_file_extent_item));
+}
+
 /* btrfs_qgroup_status_item */
 BTRFS_SETGET_FUNCS(qgroup_status_generation, struct btrfs_qgroup_status_item,
 		   generation, 64);
diff --git a/kernel-shared/fscrypt.h b/kernel-shared/fscrypt.h
new file mode 100644
index 00000000..de32593e
--- /dev/null
+++ b/kernel-shared/fscrypt.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef BTRFS_FSCRYPT_H
+#define BTRFS_FSCRYPT_H
+
+#define BTRFS_ENCRYPTION_POLICY_BITS 2
+#define BTRFS_ENCRYPTION_CTXSIZE_BITS 6
+
+#define BTRFS_ENCRYPTION_POLICY_MASK ((1 << BTRFS_ENCRYPTION_POLICY_BITS) - 1)
+#define BTRFS_ENCRYPTION_CTXSIZE_MASK \
+       (((1 << BTRFS_ENCRYPTION_CTXSIZE_BITS) - 1) << \
+               BTRFS_ENCRYPTION_POLICY_BITS)
+
+static inline void btrfs_unpack_encryption(u8 encryption,
+                                          u8 *policy,
+                                          u8 *ctxsize)
+{
+       if (policy)
+               *policy = encryption & BTRFS_ENCRYPTION_POLICY_MASK;
+       if (ctxsize)
+               *ctxsize = ((encryption & BTRFS_ENCRYPTION_CTXSIZE_MASK) >>
+                           BTRFS_ENCRYPTION_POLICY_BITS);
+}
+
+static inline u8 btrfs_pack_encryption(u8 policy, u8 ctxsize)
+{
+       return policy | (ctxsize << BTRFS_ENCRYPTION_POLICY_BITS);
+}
+
+#endif
diff --git a/kernel-shared/tree-checker.c b/kernel-shared/tree-checker.c
index 10797589..0412e97d 100644
--- a/kernel-shared/tree-checker.c
+++ b/kernel-shared/tree-checker.c
@@ -229,6 +229,7 @@ static int check_extent_data_item(struct extent_buffer *leaf,
 	u32 sectorsize = fs_info->sectorsize;
 	u32 item_size = btrfs_item_size(leaf, slot);
 	u64 extent_end;
+	u8 policy;
 
 	if (unlikely(!IS_ALIGNED(key->offset, sectorsize))) {
 		file_extent_err(leaf, slot,
@@ -280,10 +281,12 @@ static int check_extent_data_item(struct extent_buffer *leaf,
 			BTRFS_NR_COMPRESS_TYPES - 1);
 		return -EUCLEAN;
 	}
-	if (unlikely(btrfs_file_extent_encryption(leaf, fi))) {
+	btrfs_unpack_encryption(btrfs_file_extent_encryption(leaf, fi),
+				&policy, NULL);
+	if (unlikely(policy >= BTRFS_NR_ENCRYPTION_TYPES)) {
 		file_extent_err(leaf, slot,
-			"invalid encryption for file extent, have %u expect 0",
-			btrfs_file_extent_encryption(leaf, fi));
+			"invalid encryption for file extent, have %u expect range [0, %u]",
+			policy, BTRFS_NR_ENCRYPTION_TYPES - 1);
 		return -EUCLEAN;
 	}
 	if (btrfs_file_extent_type(leaf, fi) == BTRFS_FILE_EXTENT_INLINE) {
@@ -312,12 +315,30 @@ static int check_extent_data_item(struct extent_buffer *leaf,
 		return 0;
 	}
 
-	/* Regular or preallocated extent has fixed item size */
-	if (unlikely(item_size != sizeof(*fi))) {
-		file_extent_err(leaf, slot,
+	if (policy == BTRFS_ENCRYPTION_FSCRYPT) {
+		u8 ctxsize = btrfs_file_extent_encryption_ctxsize(leaf, fi);
+
+		if (unlikely(item_size != sizeof(*fi) + ctxsize)) {
+			file_extent_err(leaf, slot,
+	"invalid item size for encrypted file extent, have %u expect = %zu + context of size %u",
+					item_size, sizeof(*fi), ctxsize);
+			return -EUCLEAN;
+		}
+		/* Only regular extents should be encrypted. */
+		if (btrfs_file_extent_type(leaf, fi) != BTRFS_FILE_EXTENT_REG) {
+			file_extent_err(leaf, slot,
+		"invalid type for encrypted file extent, have %u expect %u",
+					btrfs_file_extent_type(leaf, fi),
+					BTRFS_FILE_EXTENT_REG);
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
-- 
2.40.1

