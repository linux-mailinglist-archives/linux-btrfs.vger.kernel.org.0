Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 375453CC7FF
	for <lists+linux-btrfs@lfdr.de>; Sun, 18 Jul 2021 08:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbhGRGtY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 18 Jul 2021 02:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhGRGtJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 18 Jul 2021 02:49:09 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F2DC061762
        for <linux-btrfs@vger.kernel.org>; Sat, 17 Jul 2021 23:46:12 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id j3so7808897plx.7
        for <linux-btrfs@vger.kernel.org>; Sat, 17 Jul 2021 23:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/hHQlvCD4tlmsz4u8LFymAhoPacC3jHv2ra01z7ta9U=;
        b=LCAEU1nwDMck+5JHLisi0HdZNUu2+QuC8dXRLtuCpIaamE55nBP19SyvuFG0NDs29p
         +Rhvb0bjbWzrWprhGv9X4fym4Wa2+ZesrzlLiq54HSOr9H9+nXmt2E0Gd0ImgEgv4/Kw
         irbamxGInmtFIBNoNnBC2NNRdvI0txQYCAHWzMZZFKNG/wmU+IIZGgcnJVjEBlVAm0gD
         dWH9iLAu/24z18nQd+fOwAnkqBkwBZzZharwrmrK5WuBDwfrMXONFpWrgxLEd5PVNc3v
         dmKJywyw/8RebnmdHuk8YanqQjKU5a+aY0pzVRcwS/g80FizbqPb+IlTflndl9GNBe7L
         5uiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/hHQlvCD4tlmsz4u8LFymAhoPacC3jHv2ra01z7ta9U=;
        b=PG355iBkWLEQm3bEz9dGW86FCFpOUVvjilwKeOCdavirrhd02tA8Y2DfLpNz6cu4MU
         ug4ss5/nNQjfzDykFEB/I+++Q6zaQzulypj8NrYaZeo7xsHIpwHVTZnq4VKNCcN7uUwx
         B5BFO48ydxXYrS6r41dcKLZzLBWm+zvzAKnstcvAI0TZSQL0xh0KQza73amA1ch09xhQ
         mRGhj9qPaDiHBR90nVwd6U/Y5pSyOAoFfUufIChDZQK++2IBwdcXPSXV/sRD7SrVtjn8
         QxXept9UTsqS0qb87vH00W+F91wzlEjJmXGJ/Muo9JiguFSueDcf/oNJkdtZtp7ANcAm
         XjjA==
X-Gm-Message-State: AOAM5332DlhWwBBC2SxjoI/rqniZskydxCciHreZ0W3r9Tkx5SOXNNdU
        xXg++fPwmL8+Rnc/14vPivnX21bvnH4=
X-Google-Smtp-Source: ABdhPJx4i0vus2xWfZ5Be0G+xirgWCoIcvZ50ROitD44LMY4XWFhtqHnCzlxeksugvGU9EpfIT+LDw==
X-Received: by 2002:a17:902:bd07:b029:121:9fa2:96a0 with SMTP id p7-20020a170902bd07b02901219fa296a0mr14511860pls.75.1626590771009;
        Sat, 17 Jul 2021 23:46:11 -0700 (PDT)
Received: from localhost.localdomain ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id w23sm1302741pfc.60.2021.07.17.23.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 23:46:10 -0700 (PDT)
From:   Sidong Yang <realwakka@gmail.com>
To:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Sidong Yang <realwakka@gmail.com>
Subject: [PATCH v4 1/2] btrfs-progs: export util functions about file extent items
Date:   Sun, 18 Jul 2021 06:46:00 +0000
Message-Id: <20210718064601.3435-2-realwakka@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210718064601.3435-1-realwakka@gmail.com>
References: <20210718064601.3435-1-realwakka@gmail.com>
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
 kernel-shared/print-tree.c | 18 +++++++++---------
 kernel-shared/print-tree.h |  5 +++++
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index e5d4b453..ce1c0ed3 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -338,27 +338,27 @@ static void print_uuids(struct extent_buffer *eb)
 	printf("fs uuid %s\nchunk uuid %s\n", fs_uuid, chunk_uuid);
 }
 
-static void compress_type_to_str(u8 compress_type, char *ret)
+void btrfs_compress_type_to_str(u8 compress_type, char *ret)
 {
 	switch (compress_type) {
 	case BTRFS_COMPRESS_NONE:
-		strcpy(ret, "none");
+		strncpy(ret, "none", BTRFS_COMPRESS_STR_LEN);
 		break;
 	case BTRFS_COMPRESS_ZLIB:
-		strcpy(ret, "zlib");
+		strncpy(ret, "zlib", BTRFS_COMPRESS_STR_LEN);
 		break;
 	case BTRFS_COMPRESS_LZO:
-		strcpy(ret, "lzo");
+		strncpy(ret, "lzo", BTRFS_COMPRESS_STR_LEN);
 		break;
 	case BTRFS_COMPRESS_ZSTD:
-		strcpy(ret, "zstd");
+		strncpy(ret, "zstd", BTRFS_COMPRESS_STR_LEN);
 		break;
 	default:
-		sprintf(ret, "UNKNOWN.%d", compress_type);
+		snprintf(ret, BTRFS_COMPRESS_STR_LEN, "UNKNOWN.%d", compress_type);
 	}
 }
 
-static const char* file_extent_type_to_str(u8 type)
+const char* btrfs_file_extent_type_to_str(u8 type)
 {
 	switch (type) {
 	case BTRFS_FILE_EXTENT_INLINE: return "inline";
@@ -376,12 +376,12 @@ static void print_file_extent_item(struct extent_buffer *eb,
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
index 80fb6ef7..3b96e89d 100644
--- a/kernel-shared/print-tree.h
+++ b/kernel-shared/print-tree.h
@@ -33,6 +33,8 @@ enum {
 	BTRFS_PRINT_TREE_DEFAULT = BTRFS_PRINT_TREE_BFS,
 };
 
+#define BTRFS_COMPRESS_STR_LEN 12
+
 void btrfs_print_tree(struct extent_buffer *eb, unsigned int mode);
 void btrfs_print_leaf(struct extent_buffer *eb, unsigned int mode);
 
@@ -43,4 +45,7 @@ void print_objectid(FILE *stream, u64 objectid, u8 type);
 void print_key_type(FILE *stream, u64 objectid, u8 type);
 void btrfs_print_superblock(struct btrfs_super_block *sb, int full);
 
+void btrfs_compress_type_to_str(u8 compress_type, char *ret);
+const char* btrfs_file_extent_type_to_str(u8 type);
+
 #endif
-- 
2.25.1

