Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D975971A4
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Aug 2022 16:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240288AbiHQOnw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Aug 2022 10:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240298AbiHQOnm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Aug 2022 10:43:42 -0400
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7D04E844
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Aug 2022 07:43:38 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 41D4B80AA3;
        Wed, 17 Aug 2022 10:43:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1660747417; bh=FY1D9X/4xL8y+zwLjidWzJDC0QLE8J9BRww3tw2Rk7U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uB73FC+XixbPOhSz67HwbQzYAztLOpb306xoGQKrYY51BKfeqWEPdu35zHGiAG8u8
         JJybaXgUTLvzPk8eYWMqwIjX5WeP8d7L2fT8xmQVqcAm9HiTHH/ZrOlc/iYoVmOZxy
         Xs3gQ0LLKpifvORtoCCCeHEo6NhQ5Pvlob0nkbF5tl95Q6EmUenR4Om/1PIOYhrgPv
         Xg8+33GrSd5dcjKSlEhrTfn4NOp85nERZ67HwBc3OzCMV1FD8J/Vhk6ECU6l07e+lX
         A4044epZomUDZ7tFog6fCrhaEUZz3xSGxVvE7rLDHLdbCF/ZZsQH8YZD9pluPc//Cs
         o0UmN6UAeJsLw==
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH 4/6] btrfs-progs: handle fscrypt context items
Date:   Wed, 17 Aug 2022 10:42:57 -0400
Message-Id: <25a60facebe4e79e5bbe5cc0c355270c2c219d83.1660729916.git.sweettea-kernel@dorminy.me>
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

Encrypted inodes have a new associated item, the fscrypt context, which
can be printed as a pure hex string in dump-tree.

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 kernel-shared/ctree.h      |  2 ++
 kernel-shared/print-tree.c | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index e3ffdf8d..5a600aa0 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -1375,6 +1375,8 @@ static inline u32 BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
 #define BTRFS_VERITY_DESC_ITEM_KEY	36
 #define BTRFS_VERITY_MERKLE_ITEM_KEY	37
 
+#define BTRFS_FSCRYPT_CTXT_ITEM_KEY	41
+
 #define BTRFS_ORPHAN_ITEM_KEY		48
 
 #define BTRFS_DIR_LOG_ITEM_KEY  60
diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index 215cbb11..fce1be7e 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -97,6 +97,20 @@ static void print_dir_item(struct extent_buffer *eb, u32 size,
 	}
 }
 
+static void print_fscrypt_context(struct extent_buffer *eb, int slot)
+{
+	int i;
+	unsigned long ptr = btrfs_item_ptr_offset(eb, slot);
+	u32 item_size = btrfs_item_size(eb, slot);
+	u8 ctx_buf[item_size];
+
+	read_extent_buffer(eb, ctx_buf, ptr, item_size);
+	printf("\t\tvalue: ");
+	for(i = 0; i < item_size; i++)
+		printf("%02x", ctx_buf[i]);
+	printf("\n");
+}
+
 static void print_inode_extref_item(struct extent_buffer *eb, u32 size,
 		struct btrfs_inode_extref *extref)
 {
@@ -671,6 +685,7 @@ void print_key_type(FILE *stream, u64 objectid, u8 type)
 		[BTRFS_DIR_LOG_ITEM_KEY]	= "DIR_LOG_ITEM",
 		[BTRFS_DIR_LOG_INDEX_KEY]	= "DIR_LOG_INDEX",
 		[BTRFS_XATTR_ITEM_KEY]		= "XATTR_ITEM",
+		[BTRFS_FSCRYPT_CTXT_ITEM_KEY]   = "FSCRYPT_CTXT_ITEM",
 		[BTRFS_VERITY_DESC_ITEM_KEY]	= "VERITY_DESC_ITEM",
 		[BTRFS_VERITY_MERKLE_ITEM_KEY]	= "VERITY_MERKLE_ITEM",
 		[BTRFS_ORPHAN_ITEM_KEY]		= "ORPHAN_ITEM",
@@ -1378,6 +1393,9 @@ void btrfs_print_leaf(struct extent_buffer *eb, unsigned int mode)
 		case BTRFS_XATTR_ITEM_KEY:
 			print_dir_item(eb, item_size, ptr);
 			break;
+		case BTRFS_FSCRYPT_CTXT_ITEM_KEY:
+			print_fscrypt_context(eb, i);
+			break;
 		case BTRFS_DIR_LOG_INDEX_KEY:
 		case BTRFS_DIR_LOG_ITEM_KEY: {
 			struct btrfs_dir_log_item *dlog;
-- 
2.35.1

