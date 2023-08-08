Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE492774457
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Aug 2023 20:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233702AbjHHSR0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Aug 2023 14:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235465AbjHHSQZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Aug 2023 14:16:25 -0400
Received: from box.fidei.email (box.fidei.email [IPv6:2605:2700:0:2:a800:ff:feba:dc44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4245435A7
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Aug 2023 10:23:08 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id B829483558;
        Tue,  8 Aug 2023 13:23:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1691515388; bh=gz1cvWz9XNld8XbPoojYUET63mYXtw2HSMkgQlZxueg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uMi9UXSZzjtvIhaZZto9+6EX4eS7TbRye/mf4P6gjHWpcbN/8NF+9NQp2+YL0miX8
         F0KzjVb3nE/Vp48K/xPsX76n0jRxPrXYtF1LOQlkhwK4Luui+tEqaFiF8onBmtAX3w
         SvZeNLo8a4md7SKL5Pmupsoi9xiXTIOVFdUjcol8dqavv2jUO9XmpfnXUq6w6vwuRC
         tFuvlIT9HQUfjcd788+LUwVCyTOWXrEUzQY1WyOVyMLIkoNJSlkHcP5L3rVNiTPZ0m
         d+Z9jOoxDeX+eG/rcxbCi5h1GqCZJdEaZdJWBA5Y0BDg/BRMKDgdihDTPAmpiCkX/w
         5ELTqNsNIjFpQ==
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     linux-btrfs@vger.kernel.org, ebiggers@google.com,
        kernel-team@meta.com
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH v2 6/8] btrfs-progs: handle fscrypt context items
Date:   Tue,  8 Aug 2023 13:22:25 -0400
Message-ID: <0d7c3a8f8584b9f5609da43abb20c434c390b85e.1691520000.git.sweettea-kernel@dorminy.me>
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

Encrypted inodes have a new associated item, the fscrypt context, which
can be printed as a pure hex string in dump-tree.

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 kernel-shared/print-tree.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index 9f332f811..19a0e8ac8 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -100,6 +100,20 @@ static void print_dir_item(struct extent_buffer *eb, u32 size,
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
@@ -675,6 +689,7 @@ void print_key_type(FILE *stream, u64 objectid, u8 type)
 		[BTRFS_DIR_LOG_ITEM_KEY]	= "DIR_LOG_ITEM",
 		[BTRFS_DIR_LOG_INDEX_KEY]	= "DIR_LOG_INDEX",
 		[BTRFS_XATTR_ITEM_KEY]		= "XATTR_ITEM",
+		[BTRFS_FSCRYPT_CTXT_ITEM_KEY]   = "FSCRYPT_CTXT_ITEM",
 		[BTRFS_VERITY_DESC_ITEM_KEY]	= "VERITY_DESC_ITEM",
 		[BTRFS_VERITY_MERKLE_ITEM_KEY]	= "VERITY_MERKLE_ITEM",
 		[BTRFS_ORPHAN_ITEM_KEY]		= "ORPHAN_ITEM",
@@ -1395,6 +1410,9 @@ void btrfs_print_leaf(struct extent_buffer *eb, unsigned int mode)
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
2.41.0

