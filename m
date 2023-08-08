Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939B6774920
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Aug 2023 21:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbjHHTsz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Aug 2023 15:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235329AbjHHSQW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Aug 2023 14:16:22 -0400
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65669768A
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Aug 2023 10:23:02 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 04AFE8354F;
        Tue,  8 Aug 2023 13:23:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1691515382; bh=hkyEGCML1GZoM8SkX38/nbSWGHcLrLq9/fryOwU2MeE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w+zsZ6TV6FM2xUBXRAFuAcF/M2EhFeQM7Ko9Tukl1K+bC9lTOJOdHjkC5vHUlHjVY
         8MQlSv+XxCAZJIeTuAdeRkuXM7dhu6/YxiUzTcOXlIyzNNuLgGFVxHSbWu0pYUlM+y
         AvzkISQky4e3vznBRbhE9uCV9+3H584FqdzbPxYzJaj41Ip1cpXeDxK2jt8eBgmJpU
         rF4Y7o3AS3HwwOnu+Vj5Pw//DxI3n/PfCZGz/Arxvme9iyZ3Yw6+u1Xk1+g5XrrRXJ
         i6lrFjW/EPzQZKmSWq2B4iKFSA8woAK6RURulbJFAYspCeSI9TL2M7HEY93QstYNES
         +fueGHH5/MN4g==
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     linux-btrfs@vger.kernel.org, ebiggers@google.com,
        kernel-team@meta.com
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH v2 2/8] btrfs-progs: start tracking extent encryption context info
Date:   Tue,  8 Aug 2023 13:22:21 -0400
Message-ID: <47f04d1db075b2dcc704a59353c64ab368cf9b69.1691520000.git.sweettea-kernel@dorminy.me>
In-Reply-To: <cover.1691520000.git.sweettea-kernel@dorminy.me>
References: <cover.1691520000.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This recapitulates the kernel change named 'btrfs: start tracking extent
encryption context info".

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 kernel-shared/accessors.h    |  2 ++
 kernel-shared/fscrypt.h      | 25 ++++++++++++++++++++++++
 kernel-shared/tree-checker.c | 37 ++++++++++++++++++++++++++++--------
 3 files changed, 56 insertions(+), 8 deletions(-)
 create mode 100644 kernel-shared/fscrypt.h

diff --git a/kernel-shared/accessors.h b/kernel-shared/accessors.h
index 539c20d09..1302ce5e6 100644
--- a/kernel-shared/accessors.h
+++ b/kernel-shared/accessors.h
@@ -949,6 +949,8 @@ BTRFS_SETGET_STACK_FUNCS(stack_file_extent_disk_num_bytes,
 			 struct btrfs_file_extent_item, disk_num_bytes, 64);
 BTRFS_SETGET_STACK_FUNCS(stack_file_extent_compression,
 			 struct btrfs_file_extent_item, compression, 8);
+BTRFS_SETGET_STACK_FUNCS(stack_file_extent_encryption,
+			 struct btrfs_file_extent_item, encryption, 8);
 
 BTRFS_SETGET_FUNCS(file_extent_type, struct btrfs_file_extent_item, type, 8);
 BTRFS_SETGET_FUNCS(file_extent_disk_bytenr, struct btrfs_file_extent_item,
diff --git a/kernel-shared/fscrypt.h b/kernel-shared/fscrypt.h
new file mode 100644
index 000000000..32fda99ca
--- /dev/null
+++ b/kernel-shared/fscrypt.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef BTRFS_FSCRYPT_H
+#define BTRFS_FSCRYPT_H
+
+static inline u32
+btrfs_file_extent_encryption_ctxsize(const struct extent_buffer *eb,
+                                     struct btrfs_file_extent_item *e)
+{
+        if (!btrfs_file_extent_encryption(eb, e))
+                return 0;
+
+        return btrfs_get_32(eb, e, offsetof(struct btrfs_file_extent_item,
+                                            encryption_context));
+}
+
+static inline u8
+btrfs_file_extent_ctxsize_from_item(const struct extent_buffer *leaf,
+				    int nr)
+{
+	return (btrfs_item_size(leaf, nr) -
+		sizeof(struct btrfs_file_extent_item));
+}
+
+#endif
diff --git a/kernel-shared/tree-checker.c b/kernel-shared/tree-checker.c
index 107975891..2665b2038 100644
--- a/kernel-shared/tree-checker.c
+++ b/kernel-shared/tree-checker.c
@@ -25,6 +25,7 @@
 #include "kernel-shared/ctree.h"
 #include "kernel-shared/tree-checker.h"
 #include "kernel-shared/disk-io.h"
+#include "kernel-shared/fscrypt.h"
 #include "kernel-shared/compression.h"
 #include "kernel-shared/volumes.h"
 #include "kernel-shared/misc.h"
@@ -229,6 +230,7 @@ static int check_extent_data_item(struct extent_buffer *leaf,
 	u32 sectorsize = fs_info->sectorsize;
 	u32 item_size = btrfs_item_size(leaf, slot);
 	u64 extent_end;
+	u8 policy;
 
 	if (unlikely(!IS_ALIGNED(key->offset, sectorsize))) {
 		file_extent_err(leaf, slot,
@@ -280,10 +282,11 @@ static int check_extent_data_item(struct extent_buffer *leaf,
 			BTRFS_NR_COMPRESS_TYPES - 1);
 		return -EUCLEAN;
 	}
-	if (unlikely(btrfs_file_extent_encryption(leaf, fi))) {
+	policy = btrfs_file_extent_encryption(leaf, fi);
+	if (unlikely(policy >= BTRFS_NR_ENCRYPTION_TYPES)) {
 		file_extent_err(leaf, slot,
-			"invalid encryption for file extent, have %u expect 0",
-			btrfs_file_extent_encryption(leaf, fi));
+			"invalid encryption for file extent, have %u expect range [0, %u]",
+			policy, BTRFS_NR_ENCRYPTION_TYPES - 1);
 		return -EUCLEAN;
 	}
 	if (btrfs_file_extent_type(leaf, fi) == BTRFS_FILE_EXTENT_INLINE) {
@@ -312,12 +315,30 @@ static int check_extent_data_item(struct extent_buffer *leaf,
 		return 0;
 	}
 
-	/* Regular or preallocated extent has fixed item size */
-	if (unlikely(item_size != sizeof(*fi))) {
-		file_extent_err(leaf, slot,
+	if (policy == BTRFS_ENCRYPTION_FSCRYPT) {
+		u8 ctxsize = btrfs_file_extent_encryption_ctxsize(leaf, fi);
+
+		if (unlikely(item_size != sizeof(*fi) + ctxsize)) {
+			file_extent_err(leaf, slot,
+	"invalid item size for encrypted file extent, have %u expect = %zu + context of size %u",
+					item_size, sizeof(*fi), ctxsize);
+			return -EUCLEAN;
+		}
+		/* Only regular extents should be encrypted. */
+		if (btrfs_file_extent_type(leaf, fi) != BTRFS_FILE_EXTENT_REG) {
+			file_extent_err(leaf, slot,
+		"invalid type for encrypted file extent, have %u expect %u",
+					btrfs_file_extent_type(leaf, fi),
+					BTRFS_FILE_EXTENT_REG);
+			return -EUCLEAN;
+		}
+	} else {
+		if (unlikely(item_size != sizeof(*fi))) {
+			file_extent_err(leaf, slot,
 	"invalid item size for reg/prealloc file extent, have %u expect %zu",
-			item_size, sizeof(*fi));
-		return -EUCLEAN;
+					item_size, sizeof(*fi));
+			return -EUCLEAN;
+		}
 	}
 	if (unlikely(CHECK_FE_ALIGNED(leaf, slot, fi, ram_bytes, sectorsize) ||
 		     CHECK_FE_ALIGNED(leaf, slot, fi, disk_bytenr, sectorsize) ||
-- 
2.41.0

