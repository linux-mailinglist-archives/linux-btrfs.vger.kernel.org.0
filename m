Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7881597194
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Aug 2022 16:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240336AbiHQOny (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Aug 2022 10:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240300AbiHQOnq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Aug 2022 10:43:46 -0400
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEFA25B7B9
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Aug 2022 07:43:40 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 6A73480B43;
        Wed, 17 Aug 2022 10:43:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1660747419; bh=N9rhdA2rpJe9TW33+TBs+cTLCT061KlQddnPpMcqi3w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s/LFJyu3/W1SfoIJc/E/0BdkA6ygOJt9F3j1RlufhpkfWg80AS83GpQFPUSVOWHTF
         1ckj7DFwZ6fXi0eThAq+LKLlAS2GFXmTyr88+TWEtsh+3BRERdi+Knx+JinRgaQ9T2
         6yuNXKRIDtg0ETDmCaF+9fqKaNs60M9EViGAmkO3r7q7hz79Fge3UFS0l7sZ/X8pEn
         UplwOrEBtSW67z3uc67mo0jrifgDPVfciYbhzRFhMkSBNoAPYfrsrdq+j+2Omn4hZ8
         6/lHkuGIIZylxEg//jSjw5LX8ph2z2b4Mwb2Yh+ixWf7p3/LBm+6SKKKavYgBPG+1M
         9SxKntMdkuoZA==
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH 5/6] btrfs-progs: escape unprintable characters in names
Date:   Wed, 17 Aug 2022 10:42:58 -0400
Message-Id: <443a1d4e8b3428d69e746793d4494304e42dab94.1660729916.git.sweettea-kernel@dorminy.me>
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
index fce1be7e..0e892c81 100644
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

