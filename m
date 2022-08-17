Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEA315971AB
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Aug 2022 16:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240264AbiHQOnv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Aug 2022 10:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240278AbiHQOnj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Aug 2022 10:43:39 -0400
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1FF49B69
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Aug 2022 07:43:35 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id DF3CE80A9D;
        Wed, 17 Aug 2022 10:43:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1660747415; bh=wzmC/znpPDtjs5D9r4UF+Hm6fJ9W4WvD3sKfAqtfqUQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NEyCdHTIH03CDTkOKgFBxvUqVn0Lg402Zu/ZuwS/3Lm1YmgnPK76/UVKSH0z9ymxo
         Ena9VnjcWfTdSOQjn+jDkzbi3HZuM2l7SWyVxzXcxRMGUZcF3mqXJcvNJUhdWFwDpd
         mf6VYemQFKVH88RRJeD4lXjOfSNpRGFULJmgxjlBWLA1H4hZmLEc0KBiV5U4WtNSeZ
         iEoAWIGnsDg/F1aRAQAiwp9MmxSJ5xY0flFvxSsuWQrzmU99PWU7VxJfex8EqzzIIv
         R4gRtgbhKiYacnycLDIhFnVLIMVjZ4LHlHORwVsvC9Meun4G40o67R4q5izutlj/5x
         FL0pbAS1qhcnw==
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH 3/6] btrfs-progs: interpret encrypted file extents.
Date:   Wed, 17 Aug 2022 10:42:56 -0400
Message-Id: <264361a86fdb6e30b2361a1156aed52aba90a7fa.1660729916.git.sweettea-kernel@dorminy.me>
In-Reply-To: <cover.1660729916.git.sweettea-kernel@dorminy.me>
References: <cover.1660729916.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Encrypted file extents now have the 'encryption' field set to a
encryption type plus an IV length, and have an IV appended to the item.
This necessitates adjusting the struct to have a variable-length iv
member at the end, and printing IVs if one is provided.

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 check/main.c               |  4 +++-
 kernel-shared/ctree.h      | 24 +++++++++++++++++++++++-
 kernel-shared/fscrypt.h    | 32 ++++++++++++++++++++++++++++++++
 kernel-shared/print-tree.c | 25 +++++++++++++++++++++++++
 4 files changed, 83 insertions(+), 2 deletions(-)
 create mode 100644 kernel-shared/fscrypt.h

diff --git a/check/main.c b/check/main.c
index 790b091d..bfcd16fc 100644
--- a/check/main.c
+++ b/check/main.c
@@ -6538,6 +6538,7 @@ static int run_next_block(struct btrfs_root *root,
 		for (i = 0; i < nritems; i++) {
 			struct btrfs_file_extent_item *fi;
 			unsigned long inline_offset;
+			u8 ivsize;
 
 			inline_offset = offsetof(struct btrfs_file_extent_item,
 						 disk_bytenr);
@@ -6673,8 +6674,9 @@ static int run_next_block(struct btrfs_root *root,
 				continue;
 
 			/* Prealloc/regular extent must have fixed item size */
+			ivsize = btrfs_file_extent_encryption_ivsize(buf, fi);
 			if (btrfs_item_size(buf, i) !=
-			    sizeof(struct btrfs_file_extent_item)) {
+			    sizeof(struct btrfs_file_extent_item) + ivsize) {
 				ret = -EUCLEAN;
 				error(
 			"invalid file extent item size, have %u expect %zu",
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index bbb4b534..e3ffdf8d 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -25,6 +25,7 @@
 #include "kerncompat.h"
 #include "common/extent-cache.h"
 #include "kernel-shared/extent_io.h"
+#include "kernel-shared/fscrypt.h"
 #include "ioctl.h"
 
 struct btrfs_root;
@@ -989,7 +990,10 @@ struct btrfs_file_extent_item {
 	 * uncompressed and without encoding.
 	 */
 	__le64 num_bytes;
-
+	/*
+	 * The IV used to encrypt the data in this extent.
+	 */
+	u8 iv[0];
 } __attribute__ ((__packed__));
 
 struct btrfs_dev_stats_item {
@@ -2446,6 +2450,24 @@ BTRFS_SETGET_FUNCS(file_extent_encryption, struct btrfs_file_extent_item,
 		   encryption, 8);
 BTRFS_SETGET_FUNCS(file_extent_other_encoding, struct btrfs_file_extent_item,
 		   other_encoding, 16);
+static inline u8
+btrfs_file_extent_encryption_ivsize(const struct extent_buffer *eb,
+				    struct btrfs_file_extent_item *e)
+{
+	u8 ivsize;
+	btrfs_unpack_encryption(btrfs_file_extent_encryption(eb, e),
+				NULL, &ivsize);
+	return ivsize;
+}
+
+static inline u8
+btrfs_file_extent_ivsize_from_item(const struct extent_buffer *leaf,
+				   struct btrfs_path *path)
+{
+	return (btrfs_item_size(leaf, path->slots[0]) -
+		sizeof(struct btrfs_file_extent_item));
+}
+
 
 /* btrfs_qgroup_status_item */
 BTRFS_SETGET_FUNCS(qgroup_status_version, struct btrfs_qgroup_status_item,
diff --git a/kernel-shared/fscrypt.h b/kernel-shared/fscrypt.h
new file mode 100644
index 00000000..277b775f
--- /dev/null
+++ b/kernel-shared/fscrypt.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef BTRFS_FSCRYPT_H
+#define BTRFS_FSCRYPT_H
+
+#define BTRFS_ENCRYPTION_POLICY_MASK 0x0f
+#define BTRFS_ENCRYPTION_IVSIZE_MASK 0xf0
+
+/* Actually from include/linux/fscrypt.h */
+#define FSCRYPT_MAX_IV_SIZE 32
+
+static inline void btrfs_unpack_encryption(u8 encryption,
+					   u8 *policy,
+					   u8 *ivsize)
+{
+	if (policy)
+		*policy = encryption & BTRFS_ENCRYPTION_POLICY_MASK;
+	if (ivsize) {
+		u8 transformed_ivsize =
+			(encryption & BTRFS_ENCRYPTION_IVSIZE_MASK) >> 4;
+		*ivsize = (transformed_ivsize ?
+			   (1 << (transformed_ivsize - 1)) : 0);
+	}
+}
+
+static inline u8 btrfs_pack_encryption(u8 policy, u8 ivsize)
+{
+	u8 transformed_ivsize = ivsize ? ilog2(ivsize) + 1 : 0;
+	return policy | (transformed_ivsize << 4);
+}
+
+#endif // BTRFS_FSCRYPT_H
diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index 3b1c2d4d..215cbb11 100644
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
+	u8 policy, ivsize;
+	u8 iv[FSCRYPT_MAX_IV_SIZE];
+	btrfs_unpack_encryption(encryption, &policy, &ivsize);
+	if (ivsize)
+		read_extent_buffer(leaf, iv, (unsigned long)fi->iv, ivsize);
+	ret += sprintf(ret, "(%hhu, %hhu", policy, ivsize);
+	if (ivsize) {
+		int i;
+		ret += sprintf(ret, ": IV ");
+		for (i = 0; i < ivsize; i++)
+			ret += sprintf(ret, "%02hhx", iv[i]);
+	}
+	sprintf(ret, ")");
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

