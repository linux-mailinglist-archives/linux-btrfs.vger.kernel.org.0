Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C585ADC20
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Sep 2022 02:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbiIFABb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Sep 2022 20:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbiIFAB2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Sep 2022 20:01:28 -0400
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3739F6715C
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Sep 2022 17:01:26 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 7A71180E05;
        Mon,  5 Sep 2022 20:01:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1662422486; bh=BhHU9vZWm1tTEBPFb9W/L3DJ7IxuSdGT3ZArT1QJ7pg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qnl5KBtdyOxqeRfFH//DrVKYBwj/M6FDLWPmsB/x0NiKB68EDlq8JR93T0C+K+KeH
         T5+BacxbCeJIZg2aIgcOggz0v1HdTA576l9DiIU8f7uSiUxOb/mWPzisMHFz60s5eB
         uSVztBLZ4Ctk9FwEbXYZL3tiFcVR4UA8lkYZz+rJP1gtH+Q5LdFIU6gnlUcV3An+nv
         dqsNkV/kha9q0ijC8bgSvQ8fy2HQxYev6A8ODJxNVdK5uVem1Av7Pxn8qVr26etRbo
         jJGqK9szWPlAu6L2p1J+GLJ2E0rL4aZ4twCVImEvB0N8EpvEHfDN0Ao49PfZsMRmiq
         kwZWEEH4XwysQ==
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH 3/6] btrfs-progs: interpret encrypted file extents.
Date:   Mon,  5 Sep 2022 20:01:04 -0400
Message-Id: <c8ab87232868695aa4e9947c7cea20feea1463c3.1662417859.git.sweettea-kernel@dorminy.me>
In-Reply-To: <cover.1662417859.git.sweettea-kernel@dorminy.me>
References: <cover.1662417859.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Encrypted file extents now have the 'encryption' field set to a
encryption type plus a context length, and have an extent context
appended to the item.  This necessitates adjusting the struct to have a
variable-length fscrypt_context member at the end, and printing contexts
if one is provided.

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 check/main.c               |  4 +++-
 kernel-shared/ctree.h      | 24 +++++++++++++++++++++++-
 kernel-shared/fscrypt.h    | 27 +++++++++++++++++++++++++++
 kernel-shared/print-tree.c | 25 +++++++++++++++++++++++++
 4 files changed, 78 insertions(+), 2 deletions(-)
 create mode 100644 kernel-shared/fscrypt.h

diff --git a/check/main.c b/check/main.c
index 3b133105..be9b0134 100644
--- a/check/main.c
+++ b/check/main.c
@@ -6565,6 +6565,7 @@ static int run_next_block(struct btrfs_root *root,
 		for (i = 0; i < nritems; i++) {
 			struct btrfs_file_extent_item *fi;
 			unsigned long inline_offset;
+			u8 ctxsize;
 
 			inline_offset = offsetof(struct btrfs_file_extent_item,
 						 disk_bytenr);
@@ -6700,8 +6701,9 @@ static int run_next_block(struct btrfs_root *root,
 				continue;
 
 			/* Prealloc/regular extent must have fixed item size */
+			ctxsize = btrfs_file_extent_encryption_ctxsize(buf, fi);
 			if (btrfs_item_size(buf, i) !=
-			    sizeof(struct btrfs_file_extent_item)) {
+			    sizeof(struct btrfs_file_extent_item) + ctxsize) {
 				ret = -EUCLEAN;
 				error(
 			"invalid file extent item size, have %u expect %zu",
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index d8f81610..4392393d 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -25,6 +25,7 @@
 #include "kerncompat.h"
 #include "common/extent-cache.h"
 #include "kernel-shared/extent_io.h"
+#include "kernel-shared/fscrypt.h"
 #include "ioctl.h"
 
 struct btrfs_root;
@@ -998,7 +999,11 @@ struct btrfs_file_extent_item {
 	 * uncompressed and without encoding.
 	 */
 	__le64 num_bytes;
-
+	/*
+	 * Fscrypt extent encryption context. Only present if extent is
+	 * encrypted (stored in the encryption field).
+	 */
+	__u8 fscrypt_context[0];
 } __attribute__ ((__packed__));
 
 struct btrfs_dev_stats_item {
@@ -2449,6 +2454,23 @@ BTRFS_SETGET_FUNCS(file_extent_encryption, struct btrfs_file_extent_item,
 		   encryption, 8);
 BTRFS_SETGET_FUNCS(file_extent_other_encoding, struct btrfs_file_extent_item,
 		   other_encoding, 16);
+static inline u8
+btrfs_file_extent_encryption_ctxsize(const struct extent_buffer *eb,
+				     struct btrfs_file_extent_item *e)
+{
+	u8 ctxsize;
+	btrfs_unpack_encryption(btrfs_file_extent_encryption(eb, e),
+				NULL, &ctxsize);
+	return ctxsize;
+}
+
+static inline u8
+btrfs_file_extent_ctxsize_from_item(const struct extent_buffer *leaf,
+				    const struct btrfs_path *path)
+{
+	return (btrfs_item_size(leaf, path->slots[0]) -
+		sizeof(struct btrfs_file_extent_item));
+}
 
 /* btrfs_qgroup_status_item */
 BTRFS_SETGET_FUNCS(qgroup_status_version, struct btrfs_qgroup_status_item,
diff --git a/kernel-shared/fscrypt.h b/kernel-shared/fscrypt.h
new file mode 100644
index 00000000..015c2d41
--- /dev/null
+++ b/kernel-shared/fscrypt.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef BTRFS_FSCRYPT_H
+#define BTRFS_FSCRYPT_H
+
+#define BTRFS_ENCRYPTION_POLICY_MASK 0x03
+#define BTRFS_ENCRYPTION_CTXSIZE_MASK 0xfc
+
+/* Actually from include/linux/fscrypt.h */
+#define FSCRYPT_EXTENT_CONTEXT_MAX_SIZE 33
+
+static inline void btrfs_unpack_encryption(u8 encryption,
+					   u8 *policy,
+					   u8 *ctxsize)
+{
+	if (policy)
+		*policy = encryption & BTRFS_ENCRYPTION_POLICY_MASK;
+	if (ctxsize)
+		*ctxsize = (encryption & BTRFS_ENCRYPTION_CTXSIZE_MASK) >> 2;
+}
+
+static inline u8 btrfs_pack_encryption(u8 policy, u8 ctxsize)
+{
+	return policy | (ctxsize << 2);
+}
+
+#endif // BTRFS_FSCRYPT_H
diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index 48028299..bb8db45c 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -354,6 +354,26 @@ static void compress_type_to_str(u8 compress_type, char *ret)
 	}
 }
 
+static void generate_encryption_string(struct extent_buffer *leaf,
+				       struct btrfs_file_extent_item *fi,
+				       char *ret)
+{
+	u8 encryption = btrfs_file_extent_encryption(leaf, fi);
+	u8 policy, ctxsize;
+	u8 ctx[FSCRYPT_EXTENT_CONTEXT_MAX_SIZE];
+	btrfs_unpack_encryption(encryption, &policy, &ctxsize);
+	if (ctxsize)
+		read_extent_buffer(leaf, ctx,
+				   (unsigned long)fi->fscrypt_context, ctxsize);
+	ret += sprintf(ret, "%hhu, %hhu", policy, ctxsize);
+	if (ctxsize) {
+		int i;
+		ret += sprintf(ret, ": context ");
+		for (i = 0; i < ctxsize; i++)
+			ret += sprintf(ret, "%02hhx", ctx[i]);
+	}
+}
+
 static const char* file_extent_type_to_str(u8 type)
 {
 	switch (type) {
@@ -370,9 +390,11 @@ static void print_file_extent_item(struct extent_buffer *eb,
 {
 	unsigned char extent_type = btrfs_file_extent_type(eb, fi);
 	char compress_str[16];
+	char encrypt_str[16];
 
 	compress_type_to_str(btrfs_file_extent_compression(eb, fi),
 			     compress_str);
+	generate_encryption_string(eb, fi, encrypt_str);
 
 	printf("\t\tgeneration %llu type %hhu (%s)\n",
 			btrfs_file_extent_generation(eb, fi),
@@ -405,6 +427,9 @@ static void print_file_extent_item(struct extent_buffer *eb,
 	printf("\t\textent compression %hhu (%s)\n",
 			btrfs_file_extent_compression(eb, fi),
 			compress_str);
+	printf("\t\textent encryption %hhu (%s)\n",
+			btrfs_file_extent_encryption(eb, fi),
+			encrypt_str);
 }
 
 /* Caller should ensure sizeof(*ret) >= 16("DATA|TREE_BLOCK") */
-- 
2.35.1

