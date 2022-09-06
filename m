Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC1F5ADC21
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Sep 2022 02:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232634AbiIFABf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Sep 2022 20:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbiIFABb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Sep 2022 20:01:31 -0400
Received: from box.fidei.email (box.fidei.email [IPv6:2605:2700:0:2:a800:ff:feba:dc44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D51B52E47
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Sep 2022 17:01:30 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id E55FE80E05;
        Mon,  5 Sep 2022 20:01:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1662422490; bh=IttONbvphVIkopPhjOSpLTVvRVbkNnzCrnnJ1Poj8ns=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V1zEMh8pG0YYa2n9tOuaaI+o8u4n4q8YVhK0Djksd0W0aYRAA7aLEBq/ni1U8HEdS
         W5iO4X3KCPkR1FiZbJWTIY5S5xGuoh26cB5DHPw30Fc9qoEQYuLxqTr17msQqY6aM+
         R3t99uW0lvbGYt0737Kwm2uyTFY1LuEE6kz6U7vg1wNmG1r3Rs8BOufmy4VsqN2E0s
         zzx4zAJOk9hC2/emZj7esgrBb9cipBzQ1EbpyEndEwIcQX7QeYCc0WKammTvG12AhD
         g9r3/JqZC6lrukz8TdNiUnzrrcE9CwJ/uhDbDq3fy4j1qU5I1fRls2X6lutVx7ixih
         AWaEU2gmEdcFA==
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH 5/6] btrfs-progs: escape unprintable characters in names
Date:   Mon,  5 Sep 2022 20:01:06 -0400
Message-Id: <95f07a265f40797ba81d3125364492f17e3b8780.1662417859.git.sweettea-kernel@dorminy.me>
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
index 2163f833..6365d961 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -28,6 +28,19 @@
 #include "kernel-shared/volumes.h"
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
@@ -77,7 +90,7 @@ static void print_dir_item(struct extent_buffer *eb, u32 size,
 		} else {
 			read_extent_buffer(eb, namebuf,
 					(unsigned long)(di + 1), len);
-			printf("\t\tname: %.*s\n", len, namebuf);
+			print_name(namebuf, len);
 		}
 
 		if (data_len) {
@@ -135,7 +148,7 @@ static void print_inode_extref_item(struct extent_buffer *eb, u32 size,
 		} else {
 			read_extent_buffer(eb, namebuf,
 					(unsigned long)extref->name, len);
-			printf("name: %.*s\n", len, namebuf);
+			print_name(namebuf, len);
 		}
 
 		len = sizeof(*extref) + name_len;
@@ -165,7 +178,7 @@ static void print_inode_ref_item(struct extent_buffer *eb, u32 size,
 		} else {
 			read_extent_buffer(eb, namebuf,
 					(unsigned long)(ref + 1), len);
-			printf("name: %.*s\n", len, namebuf);
+			print_name(namebuf, len);
 		}
 		len = sizeof(*ref) + name_len;
 		ref = (struct btrfs_inode_ref *)((char *)ref + len);
-- 
2.35.1

