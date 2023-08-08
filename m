Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B4377442C
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Aug 2023 20:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbjHHSQI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Aug 2023 14:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235476AbjHHSPp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Aug 2023 14:15:45 -0400
Received: from box.fidei.email (box.fidei.email [IPv6:2605:2700:0:2:a800:ff:feba:dc44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB147C724
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Aug 2023 10:23:06 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 4B67B83548;
        Tue,  8 Aug 2023 13:23:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1691515386; bh=l9QXXmgyFNfLH+hXZhKDQCPb6+7NWcCsmgzzedPc+oE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c3uq40gqg0J96fjnalFqvf2N7TLHCm/ayNtjKSRZHVV6Wc94HWq/6xlfUy8y6w0tD
         D6/BM39lPft0lZyqsivEtYU6A9BoOVRd0YqkczEeMgluPTj/VLdhkcwck9pzJdZ8SM
         ecO5doq5/jCdNb0sm8FiBXaVMNPOsFpPsLRuJKmnX2GtuXQi6S8OJptsU0XOtebHAD
         36CkuSAsWm9b1VvOrPvVI8pNBCiDJYKBwxWBRc2EQaO/aRAM9T91Vwl8eLMiySzf/C
         VUc2mmmR9e5pVsr6AczAXNJgTEBfZaMrWSI72aNYDi8XQPtM1m0Z8JxjYBBXudfgwV
         dTZNgSt34bsKw==
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     linux-btrfs@vger.kernel.org, ebiggers@google.com,
        kernel-team@meta.com
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH v2 5/8] btrfs-progs: interpret encrypted file extents.
Date:   Tue,  8 Aug 2023 13:22:24 -0400
Message-ID: <a61ea8e362247fbf58a9d45539144f98c6754baa.1691520000.git.sweettea-kernel@dorminy.me>
In-Reply-To: <cover.1691520000.git.sweettea-kernel@dorminy.me>
References: <cover.1691520000.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
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
 check/main.c               |  5 ++++-
 kernel-shared/print-tree.c | 27 +++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/check/main.c b/check/main.c
index d66e10e8f..00f73c43e 100644
--- a/check/main.c
+++ b/check/main.c
@@ -37,6 +37,7 @@
 #include "kernel-shared/ctree.h"
 #include "kernel-shared/volumes.h"
 #include "kernel-shared/disk-io.h"
+#include "kernel-shared/fscrypt.h"
 #include "kernel-shared/print-tree.h"
 #include "kernel-shared/transaction.h"
 #include "kernel-shared/free-space-cache.h"
@@ -6345,6 +6346,7 @@ static int run_next_block(struct btrfs_root *root,
 		for (i = 0; i < nritems; i++) {
 			struct btrfs_file_extent_item *fi;
 			unsigned long inline_offset;
+			u8 ctxsize;
 
 			inline_offset = offsetof(struct btrfs_file_extent_item,
 						 disk_bytenr);
@@ -6480,8 +6482,9 @@ static int run_next_block(struct btrfs_root *root,
 				continue;
 
 			/* Prealloc/regular extent must have fixed item size */
+			ctxsize = btrfs_file_extent_encryption_ctxsize(buf, fi);
 			if (btrfs_item_size(buf, i) !=
-			    sizeof(struct btrfs_file_extent_item)) {
+			    sizeof(struct btrfs_file_extent_item) + ctxsize) {
 				ret = -EUCLEAN;
 				error(
 			"invalid file extent item size, have %u expect %zu",
diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index 0f7f7b72f..9f332f811 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -23,6 +23,7 @@
 #include "kerncompat.h"
 #include "kernel-shared/ctree.h"
 #include "kernel-shared/disk-io.h"
+#include "kernel-shared/fscrypt.h"
 #include "kernel-shared/print-tree.h"
 #include "kernel-shared/volumes.h"
 #include "kernel-shared/compression.h"
@@ -356,6 +357,27 @@ static void compress_type_to_str(u8 compress_type, char *ret)
 	}
 }
 
+static void generate_encryption_string(struct extent_buffer *leaf,
+				       struct btrfs_file_extent_item *fi,
+				       char *ret)
+{
+	u8 policy = btrfs_file_extent_encryption(leaf, fi);
+	u32 ctxsize = btrfs_file_extent_encryption_ctxsize(leaf, fi);
+	unsigned long offset = (unsigned long) fi;
+	const struct btrfs_file_extent_item *fi2 = (struct btrfs_file_extent_item *)(leaf->data + offset);
+	const __u8 *ctx = fi2->encryption_context;
+
+	ret += sprintf(ret, "(%hhu, %u", policy, ctxsize);
+
+	if (ctxsize) {
+		int i;
+		ret += sprintf(ret, ": context ");
+		for (i = 0; i < ctxsize; i++)
+			ret += sprintf(ret, "%02hhx", ctx[i]);
+	}
+	sprintf(ret, ")");
+}
+
 static const char* file_extent_type_to_str(u8 type)
 {
 	switch (type) {
@@ -372,9 +394,11 @@ static void print_file_extent_item(struct extent_buffer *eb,
 {
 	unsigned char extent_type = btrfs_file_extent_type(eb, fi);
 	char compress_str[16];
+	char encrypt_str[16];
 
 	compress_type_to_str(btrfs_file_extent_compression(eb, fi),
 			     compress_str);
+	generate_encryption_string(eb, fi, encrypt_str);
 
 	printf("\t\tgeneration %llu type %hhu (%s)\n",
 			btrfs_file_extent_generation(eb, fi),
@@ -407,6 +431,9 @@ static void print_file_extent_item(struct extent_buffer *eb,
 	printf("\t\textent compression %hhu (%s)\n",
 			btrfs_file_extent_compression(eb, fi),
 			compress_str);
+	printf("\t\textent encryption %hhu (%s)\n",
+			btrfs_file_extent_encryption(eb, fi),
+			encrypt_str);
 }
 
 /* Caller should ensure sizeof(*ret) >= 16("DATA|TREE_BLOCK") */
-- 
2.41.0

