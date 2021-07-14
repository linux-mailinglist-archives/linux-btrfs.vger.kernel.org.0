Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73E5E3C866A
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jul 2021 16:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239472AbhGNO5u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Jul 2021 10:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbhGNO5t (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Jul 2021 10:57:49 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C461C06175F
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Jul 2021 07:54:58 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id j199so2256132pfd.7
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Jul 2021 07:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pMRZQbe402/6+IXB0r8Rpt3PaQF7ASyraMuwzoJket8=;
        b=U+nP6TsMTOS/ZQz3dhtNl+B1R1GRAiiimpjdkZ6kAePnWlDwGQVhxd9qBiPr5MCXK/
         cT/tgj9Kcl+wqh0MeazWOJsZiNGGi794Kx+3DjeUXb5Ly0rUNEoaWg/EKlU+4klcofr0
         4Lrd08Tu3KZXT+MqFMBLlfCJaYaDyXokiqfVx64UwbXkZYhwHJfY8SWzqH0dH/LdB3xa
         oHftNBthsri4N/nRUyyAbpcOm0KQiiVqMO/0Hf6IKp2fDyY10CjBVS9LavunrSIexT6V
         evz3q33OGNGK1pFXGExq6SfDXVsyrvHP3cOjDlDHd5H2TdXWPNqQKsvvoo2UJa2FRps2
         g5gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pMRZQbe402/6+IXB0r8Rpt3PaQF7ASyraMuwzoJket8=;
        b=fYp2qb7yElImQa79m7YkHnEShmeghRqTVqzsee2L/mP4v792cA0pSMNGRVC4JVjOvV
         PQ/1L9dN3J5Z12fBV2T9vMrya9RXAoEYSdrgRD8M3Bfc6wzM7voXQ06ae7DAm49ZO/GZ
         q6JnW6TjMMWbhX0I0kyDrBHzQJE5YMJU2jtqMgnt4TUWB3QcS0BbL94DzPgrY91Fokuf
         AUogbRTcfl3oTZ6QrcEu+vz0vMkyZ+CX4Aq3Z4GvEIqtBuMMEdRbJuTZ2gPO2g8l2Spt
         9h3v8ORXO/RjJeWlearCmp5XlCGtQAfgnOaVMis8BroAjBe1JdXSKTke1PCpxUQOTNi2
         PrnQ==
X-Gm-Message-State: AOAM5333HJjL9JvLFEAMS29Mjzxsli4lzuzZ1dQT7IeHGdRXVScgPinS
        eMg2qtEPxh2ZE1pk7X25EMbZ9qUhDPvZyA==
X-Google-Smtp-Source: ABdhPJyG6rZOJAbUaVLk/y8n35ibRGBrK1gc90TbZGgD9AfoEff2RObwA431v2e/q7XzCfuCzexEVw==
X-Received: by 2002:a63:5e41:: with SMTP id s62mr10189302pgb.288.1626274497884;
        Wed, 14 Jul 2021 07:54:57 -0700 (PDT)
Received: from localhost.localdomain ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id u24sm3353639pfm.141.2021.07.14.07.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 07:54:57 -0700 (PDT)
From:   Sidong Yang <realwakka@gmail.com>
To:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Sidong Yang <realwakka@gmail.com>
Subject: [PATCH v3 1/2] btrfs-progs: export util functions about file extent items
Date:   Wed, 14 Jul 2021 14:54:36 +0000
Message-Id: <20210714145437.75710-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch export two functions that convert enum about file extents to
string. It can be used in other code like inspect-internal command. And
this patch also make compress_type_to_str() function more safe by using
strncpy() than strcpy().

Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
v2:
 - Prints type and compression
 - Use the terms from file_extents_item like disk_bytenr not like
   "physical"
v3:
 - export util functions for removing duplication
 - change the way to loop with search ioctl
---
 kernel-shared/print-tree.c | 18 ++++++++++--------
 kernel-shared/print-tree.h |  3 +++
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index e5d4b453..bfef7d26 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -27,6 +27,8 @@
 #include "kernel-shared/print-tree.h"
 #include "common/utils.h"
 
+#define COMPRESS_STR_LEN 5
+
 static void print_dir_item_type(struct extent_buffer *eb,
                                 struct btrfs_dir_item *di)
 {
@@ -338,27 +340,27 @@ static void print_uuids(struct extent_buffer *eb)
 	printf("fs uuid %s\nchunk uuid %s\n", fs_uuid, chunk_uuid);
 }
 
-static void compress_type_to_str(u8 compress_type, char *ret)
+void btrfs_compress_type_to_str(u8 compress_type, char *ret)
 {
 	switch (compress_type) {
 	case BTRFS_COMPRESS_NONE:
-		strcpy(ret, "none");
+		strncpy(ret, "none", COMPRESS_STR_LEN);
 		break;
 	case BTRFS_COMPRESS_ZLIB:
-		strcpy(ret, "zlib");
+		strncpy(ret, "zlib", COMPRESS_STR_LEN);
 		break;
 	case BTRFS_COMPRESS_LZO:
-		strcpy(ret, "lzo");
+		strncpy(ret, "lzo", COMPRESS_STR_LEN);
 		break;
 	case BTRFS_COMPRESS_ZSTD:
-		strcpy(ret, "zstd");
+		strncpy(ret, "zstd", COMPRESS_STR_LEN);
 		break;
 	default:
 		sprintf(ret, "UNKNOWN.%d", compress_type);
 	}
 }
 
-static const char* file_extent_type_to_str(u8 type)
+const char* btrfs_file_extent_type_to_str(u8 type)
 {
 	switch (type) {
 	case BTRFS_FILE_EXTENT_INLINE: return "inline";
@@ -376,12 +378,12 @@ static void print_file_extent_item(struct extent_buffer *eb,
 	unsigned char extent_type = btrfs_file_extent_type(eb, fi);
 	char compress_str[16];
 
-	compress_type_to_str(btrfs_file_extent_compression(eb, fi),
+	btrfs_compress_type_to_str(btrfs_file_extent_compression(eb, fi),
 			     compress_str);
 
 	printf("\t\tgeneration %llu type %hhu (%s)\n",
 			btrfs_file_extent_generation(eb, fi),
-			extent_type, file_extent_type_to_str(extent_type));
+			extent_type, btrfs_file_extent_type_to_str(extent_type));
 
 	if (extent_type == BTRFS_FILE_EXTENT_INLINE) {
 		printf("\t\tinline extent data size %u ram_bytes %llu compression %hhu (%s)\n",
diff --git a/kernel-shared/print-tree.h b/kernel-shared/print-tree.h
index 80fb6ef7..dbb2f183 100644
--- a/kernel-shared/print-tree.h
+++ b/kernel-shared/print-tree.h
@@ -43,4 +43,7 @@ void print_objectid(FILE *stream, u64 objectid, u8 type);
 void print_key_type(FILE *stream, u64 objectid, u8 type);
 void btrfs_print_superblock(struct btrfs_super_block *sb, int full);
 
+void btrfs_compress_type_to_str(u8 compress_type, char *ret);
+const char* btrfs_file_extent_type_to_str(u8 type);
+
 #endif
-- 
2.25.1

