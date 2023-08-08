Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF964774429
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Aug 2023 20:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235347AbjHHSQC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Aug 2023 14:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233924AbjHHSPh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Aug 2023 14:15:37 -0400
Received: from box.fidei.email (box.fidei.email [IPv6:2605:2700:0:2:a800:ff:feba:dc44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8B07C72E
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Aug 2023 10:23:09 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 18CD18354F;
        Tue,  8 Aug 2023 13:23:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1691515389; bh=adASWTEzcSz7k3WzA+htbmJYOY4lyeVsxyhJldDR4lk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vUYt458SQBsPMNMAf26EbCbfF03GfvLLWYM79JK3dAqbocKSBCnUtQ5wnokA49AM4
         4L3oMWSQ1tk/U+pUKP4jiDjiNqFF0wTbUKejmdgtZH9oArrgErLUa8r2v4uil7KugP
         SsZvFfbPdFh/SjyQIMqgEBEmzADrl8v/1NVe8yoOBb4sDSqmA0qPSU1BCr5bhv9sIk
         tOMRPLY7pLbJE/ZgaopbSKR+DdIeZkWMmUm05cr12148QYaqoYlw8RAzspBoZtr/Uv
         HcrQWNz+a83/KkKwOKS4au1Y9MNDXsWklEjiu40Y0W4wIDW/8rQ8PUj17Vz5z1sVIz
         8WmDQ67dznmRA==
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     linux-btrfs@vger.kernel.org, ebiggers@google.com,
        kernel-team@meta.com
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH v2 7/8] btrfs-progs: escape unprintable characters in names
Date:   Tue,  8 Aug 2023 13:22:26 -0400
Message-ID: <94539c5eb5b301399c87178d00de758eb6f60803.1691520000.git.sweettea-kernel@dorminy.me>
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
index 19a0e8ac8..fa9f73cba 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -31,6 +31,19 @@
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
@@ -80,7 +93,7 @@ static void print_dir_item(struct extent_buffer *eb, u32 size,
 		} else {
 			read_extent_buffer(eb, namebuf,
 					(unsigned long)(di + 1), len);
-			printf("\t\tname: %.*s\n", len, namebuf);
+			print_name(namebuf, len);
 		}
 
 		if (data_len) {
@@ -138,7 +151,7 @@ static void print_inode_extref_item(struct extent_buffer *eb, u32 size,
 		} else {
 			read_extent_buffer(eb, namebuf,
 					(unsigned long)extref->name, len);
-			printf("name: %.*s\n", len, namebuf);
+			print_name(namebuf, len);
 		}
 
 		len = sizeof(*extref) + name_len;
@@ -168,7 +181,7 @@ static void print_inode_ref_item(struct extent_buffer *eb, u32 size,
 		} else {
 			read_extent_buffer(eb, namebuf,
 					(unsigned long)(ref + 1), len);
-			printf("name: %.*s\n", len, namebuf);
+			print_name(namebuf, len);
 		}
 		len = sizeof(*ref) + name_len;
 		ref = (struct btrfs_inode_ref *)((char *)ref + len);
-- 
2.41.0

