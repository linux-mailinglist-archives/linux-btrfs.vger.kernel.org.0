Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCE973F4033
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Aug 2021 17:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233987AbhHVPCl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 22 Aug 2021 11:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233549AbhHVPCk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 22 Aug 2021 11:02:40 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B0BC061575
        for <linux-btrfs@vger.kernel.org>; Sun, 22 Aug 2021 08:01:59 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id a21so13109582pfh.5
        for <linux-btrfs@vger.kernel.org>; Sun, 22 Aug 2021 08:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/hHQlvCD4tlmsz4u8LFymAhoPacC3jHv2ra01z7ta9U=;
        b=AqEGAYr98caXYNm0e143aZMN2ecn8UGBnjR/QcoTTHJTS0waFboi3abV4m5VsfxVxa
         3ZH/YkM6ey845TBkOivLVbh6azDR+PKG0+djTydLDjTzZ6VV0ZrPM31KyTte7flECvy2
         vFi83vBPwA28Wl23MK89p8I6bHxbL8W+wHlJ/7QEIZhRxZFmZalCfqJ0g3Kwjv8gwBNC
         rGvb2AXlwFaWLzinHwE8CqrUOjkWNf0Do6TDdLH+/yAB8U/XECiP0qNX68TWgMrmifur
         Sv6i/GRSwZc+NAm29X3PciPHBr7LStIQJzJ3WrgkJi9v2k5gB2xumD+LGdrO6R2vbTBu
         B7AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/hHQlvCD4tlmsz4u8LFymAhoPacC3jHv2ra01z7ta9U=;
        b=a61BftLwwt3MJZzoWPGwm+AkAziUGAuDIhBGbc5DI4iA2JfuSLwVPoNmGgtrmbom07
         qFFLnx8s3/I2Y8MDhvX6aJQMN2JVOWun9j6OpZBKE1ZbBy+wKmXB6tp7xr34Hbc4MmPo
         0p5rgKeidbLV9ov9sAyr8py16E1WVUIIF/D5JGGLD4hUouJU2q2lTmEmAIYuYXHb2WJY
         hwZDuJiTSIKRxq3wrIrrcjRJnHUMcGVXwv+iHvem+3x+9YDZHTS8/kY/59Kfr0Q0eem1
         6J1Z7hqKJ6P8rqF4mifv5lC5OnYHVRWeFSB2XkTn/ZBi0pucSE73DFXbbIXsHM6XjsfB
         ReCQ==
X-Gm-Message-State: AOAM531xN82ZIoAhPLNhNRXED0wsXHMHe9oY579OYD2C8A2FFK8vha6d
        7QndzyRuXwc5NlVmj5ehtM4KUAvSo8h2tg==
X-Google-Smtp-Source: ABdhPJyP4SYYzkUZFOF+KgefhjKWaox5xREjOpBsVnDDIPDAsJmfbqZWVY9/PbZJDPDEqe6RMVSo+w==
X-Received: by 2002:a05:6a00:b86:b0:3e2:33d2:d15c with SMTP id g6-20020a056a000b8600b003e233d2d15cmr30178695pfj.10.1629644519076;
        Sun, 22 Aug 2021 08:01:59 -0700 (PDT)
Received: from localhost.localdomain ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id n185sm13992266pfn.171.2021.08.22.08.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 08:01:58 -0700 (PDT)
From:   Sidong Yang <realwakka@gmail.com>
To:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.cz>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Sidong Yang <realwakka@gmail.com>
Subject: [PATCH v5 1/2] btrfs-progs: export util functions about file extent items
Date:   Sun, 22 Aug 2021 15:01:39 +0000
Message-Id: <20210822150140.44152-2-realwakka@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210822150140.44152-1-realwakka@gmail.com>
References: <20210822150140.44152-1-realwakka@gmail.com>
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

