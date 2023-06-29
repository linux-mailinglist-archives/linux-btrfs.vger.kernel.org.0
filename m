Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF330742DFB
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jun 2023 22:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbjF2T6q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Jun 2023 15:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbjF2T6h (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Jun 2023 15:58:37 -0400
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802D42D60
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Jun 2023 12:58:36 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id E965080AE0;
        Thu, 29 Jun 2023 15:58:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1688068716; bh=i64gJVxvY5Ht/txyZeejco2uaF2Z0SxWoUdP4xMQqzA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mZ6Pxav+rLQFB0UmDjvCzItJ38iH+p1/wM1H+RgSox8sCvOLFGSqXxBNk8RMj9Dm9
         TFSPKhG0n4cqmd/4zpDKRHCiHzBhlJKYH1By2TWEaL7t88kqyswyU+7e0jGRL68bQX
         cx2r86IDtGKbVs9Xu/G7B3qKyMcA4P6nQMcBNvlVQ3uqdJv5iTauwpUxcDfd+tlyMF
         QBAm7YOxA5EY9J4JNNdi5XXLk5NGOeQmCaHei3AG7uAF6ZHIccvnFiokbke2CWTVqX
         f2xBg8GsCtiFfH+++lbFJZyGCYJemB2MmpHS9uT90C4R8wTnAmBbPaHPhV5dCcsvOa
         Q7KiTBPzPaUzg==
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     linux-btrfs@vger.kernel.org, kernel-team@meta.com
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH 7/8] btrfs-progs: escape unprintable characters in names
Date:   Thu, 29 Jun 2023 15:58:09 -0400
Message-Id: <57fd51e1bb53568633b6c92ac12f6dfbce7be404.1688068420.git.sweettea-kernel@dorminy.me>
In-Reply-To: <cover.1688068420.git.sweettea-kernel@dorminy.me>
References: <cover.1688068420.git.sweettea-kernel@dorminy.me>
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

There are several item types which have an associated name: inode refs
and dir items. While they could always be unprintable, the advent of
encryption makes it much more likely that the names contain characters
outside the normal ASCII range. As such, it's useful to print the
characters outside normal ASCII in hex format.

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 kernel-shared/print-tree.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index fa32b586..c02c00d7 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -30,6 +30,19 @@
 #include "kernel-shared/file-item.h"
 #include "common/utils.h"
 
+static void print_name(const char *buf, size_t len)
+{
+	size_t i;
+	printf("name: ");
+	for(i = 0; i < len; i++) {
+		if (buf[i] >= ' ' && buf[i] <= '~')
+			printf("%c", buf[i]);
+		else
+			printf("\\x%02hhx", buf[i]);
+	}
+	printf("\n");
+}
+
 static void print_dir_item_type(struct extent_buffer *eb,
                                 struct btrfs_dir_item *di)
 {
@@ -79,7 +92,7 @@ static void print_dir_item(struct extent_buffer *eb, u32 size,
 		} else {
 			read_extent_buffer(eb, namebuf,
 					(unsigned long)(di + 1), len);
-			printf("\t\tname: %.*s\n", len, namebuf);
+			print_name(namebuf, len);
 		}
 
 		if (data_len) {
@@ -137,7 +150,7 @@ static void print_inode_extref_item(struct extent_buffer *eb, u32 size,
 		} else {
 			read_extent_buffer(eb, namebuf,
 					(unsigned long)extref->name, len);
-			printf("name: %.*s\n", len, namebuf);
+			print_name(namebuf, len);
 		}
 
 		len = sizeof(*extref) + name_len;
@@ -167,7 +180,7 @@ static void print_inode_ref_item(struct extent_buffer *eb, u32 size,
 		} else {
 			read_extent_buffer(eb, namebuf,
 					(unsigned long)(ref + 1), len);
-			printf("name: %.*s\n", len, namebuf);
+			print_name(namebuf, len);
 		}
 		len = sizeof(*ref) + name_len;
 		ref = (struct btrfs_inode_ref *)((char *)ref + len);
-- 
2.40.1

