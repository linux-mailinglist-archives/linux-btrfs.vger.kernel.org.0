Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A77D742E0D
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jun 2023 22:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbjF2T6p (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Jun 2023 15:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbjF2T6e (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Jun 2023 15:58:34 -0400
Received: from box.fidei.email (box.fidei.email [IPv6:2605:2700:0:2:a800:ff:feba:dc44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52C62D5B
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Jun 2023 12:58:33 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 2DE8080AE0;
        Thu, 29 Jun 2023 15:58:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1688068713; bh=NgXXFOl6a0/2PDL9/z/npYv+hjP2oswD7MP8NJsvONA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bj1BoHgSdQHAALTTevh7ZAjN1q5U4QRLhePp59YFyOwBtPDhUnznTNqGPVHvj3FLX
         YCrFvcddOGGKj6tEwAYUn6oc95DHmk+svOfxwRIJ8F7XSPyTBhKceLaCIJ+pUncVQR
         eM166Nm3XEIMgeMz6sNeDDgkZynfKYBqrkEQ1qQyi0qHiVF/4GvoDYLAFw47YUpKjk
         7RdjshECPWMueO4lMvY/rC0PGzj5kY9k6Y8OIifEcWpT07H6V/kLB8aZW79V6GL3sD
         v/spNL2DUu0fV7vo9MHyB49XTgoNMsmKSWsXvxherS2sHsi2UgALeQFHVJbWHAXC/n
         PCpovk4Do8crA==
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     linux-btrfs@vger.kernel.org, kernel-team@meta.com
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH 5/8] btrfs-progs: interpret encrypted file extents.
Date:   Thu, 29 Jun 2023 15:58:07 -0400
Message-Id: <adc97fa988761bb0b80038a71293c86f25401bdb.1688068420.git.sweettea-kernel@dorminy.me>
In-Reply-To: <cover.1688068420.git.sweettea-kernel@dorminy.me>
References: <cover.1688068420.git.sweettea-kernel@dorminy.me>
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

Encrypted file extents now have the 'encryption' field set to a
encryption type plus a context length, and have an extent context
appended to the item.  This necessitates adjusting the struct to have a
variable-length fscrypt_context member at the end, and printing contexts
if one is provided.

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 check/main.c               |  4 +++-
 kernel-shared/print-tree.c | 27 +++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/check/main.c b/check/main.c
index 77bb50a0..ce64f762 100644
--- a/check/main.c
+++ b/check/main.c
@@ -6345,6 +6345,7 @@ static int run_next_block(struct btrfs_root *root,
 		for (i = 0; i < nritems; i++) {
 			struct btrfs_file_extent_item *fi;
 			unsigned long inline_offset;
+			u8 ctxsize;
 
 			inline_offset = offsetof(struct btrfs_file_extent_item,
 						 disk_bytenr);
@@ -6480,8 +6481,9 @@ static int run_next_block(struct btrfs_root *root,
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
index 0f7f7b72..688e4c1a 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -356,6 +356,28 @@ static void compress_type_to_str(u8 compress_type, char *ret)
 	}
 }
 
+static void generate_encryption_string(struct extent_buffer *leaf,
+				       struct btrfs_file_extent_item *fi,
+				       char *ret)
+{
+	u8 encryption = btrfs_file_extent_encryption(leaf, fi);
+	u8 policy, ctxsize;
+	unsigned long offset = (unsigned long) fi;
+	const struct btrfs_file_extent_item *fi2 = (struct btrfs_file_extent_item *)(leaf->data + offset);
+	const __u8 *ctx = fi2->fscrypt_context;
+
+	btrfs_unpack_encryption(encryption, &policy, &ctxsize);
+	ret += sprintf(ret, "(%hhu, %hhu", policy, ctxsize);
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
2.40.1

