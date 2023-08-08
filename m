Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCF8774458
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Aug 2023 20:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234955AbjHHSR1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Aug 2023 14:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235470AbjHHSQ1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Aug 2023 14:16:27 -0400
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C30D7D78A
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Aug 2023 10:23:11 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id A1B488354E;
        Tue,  8 Aug 2023 13:23:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1691515390; bh=AYeLeVX+Q+qjGl3yYMbZy3XbZSzv/n2t/sGbDIQd1dw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jrdRRxy48hM/W6Oi+y0RJYQezWw2peaYnaAt5Sap5JB5Uqn+HmeWawaJLD2KNFvFT
         SJdjWuwF3HJ4dGSGuJ6FMTmseVsho6yAAz0i3h2nsxOXxhbON5jSiDTSE4oNYMvXDT
         DClXYYN++UPV9dmUEh4K53fUV2TbvMSKPecjgn51UyXXyeRCErhD42+bXAcBwICVb/
         lPut608baiuibnVniRXcgza+XYLtpTykTcDdjkdW0WnSW7BiYSm2vfpOGBKVcXiPF+
         aiTsX+GRN3CXQooUAjKGRsDBTTXXtmHYty2m0Af32P9Ia/wJqeTuYnx8s4GXrdkgFf
         T7WyI9z8B/Fsg==
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     linux-btrfs@vger.kernel.org, ebiggers@google.com,
        kernel-team@meta.com
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH v2 8/8] btrfs-progs: check: update inline extent length checking
Date:   Tue,  8 Aug 2023 13:22:27 -0400
Message-ID: <494b5b5316096d24370be40344f43594d8498146.1691520000.git.sweettea-kernel@dorminy.me>
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

As part of the encryption changes, encrypted inline file extents record
their actual data length in ram_bytes, like compressed inline file
extents, while the item's length records the actual size. As such,
encrypted inline extents must be treated like compressed ones for
inode length consistency checking.

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 check/main.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/check/main.c b/check/main.c
index 00f73c43e..b78e8b55a 100644
--- a/check/main.c
+++ b/check/main.c
@@ -1643,7 +1643,7 @@ static int process_file_extent(struct btrfs_root *root,
 	u64 mask = gfs_info->sectorsize - 1;
 	u32 max_inline_size = min_t(u32, mask,
 				BTRFS_MAX_INLINE_DATA_SIZE(gfs_info));
-	u8 compression;
+	u8 compression, encryption;
 	int extent_type;
 	int ret;
 
@@ -1668,25 +1668,25 @@ static int process_file_extent(struct btrfs_root *root,
 	fi = btrfs_item_ptr(eb, slot, struct btrfs_file_extent_item);
 	extent_type = btrfs_file_extent_type(eb, fi);
 	compression = btrfs_file_extent_compression(eb, fi);
+	encryption = btrfs_file_extent_encryption(eb, fi);
 
 	if (extent_type == BTRFS_FILE_EXTENT_INLINE) {
-		num_bytes = btrfs_file_extent_ram_bytes(eb, fi);
-		if (num_bytes == 0)
+		u64 num_decoded_bytes = btrfs_file_extent_ram_bytes(eb, fi);
+		u64 num_disk_bytes =  btrfs_file_extent_inline_item_len(eb, slot);
+		if (num_decoded_bytes == 0)
 			rec->errors |= I_ERR_BAD_FILE_EXTENT;
-		if (compression) {
-			if (btrfs_file_extent_inline_item_len(eb, slot) >
-			    max_inline_size ||
-			    num_bytes > gfs_info->sectorsize)
+		if (compression || encryption) {
+			if (num_disk_bytes > max_inline_size ||
+			    num_decoded_bytes > gfs_info->sectorsize)
 				rec->errors |= I_ERR_FILE_EXTENT_TOO_LARGE;
 		} else {
-			if (num_bytes > max_inline_size)
+			if (num_decoded_bytes > max_inline_size)
 				rec->errors |= I_ERR_FILE_EXTENT_TOO_LARGE;
-			if (btrfs_file_extent_inline_item_len(eb, slot) !=
-			    num_bytes)
+			if (num_disk_bytes != num_decoded_bytes)
 				rec->errors |= I_ERR_INLINE_RAM_BYTES_WRONG;
 		}
-		rec->found_size += num_bytes;
-		num_bytes = (num_bytes + mask) & ~mask;
+		rec->found_size += num_decoded_bytes;
+		num_bytes = (num_decoded_bytes + mask) & ~mask;
 	} else if (extent_type == BTRFS_FILE_EXTENT_REG ||
 		   extent_type == BTRFS_FILE_EXTENT_PREALLOC) {
 		num_bytes = btrfs_file_extent_num_bytes(eb, fi);
-- 
2.41.0

