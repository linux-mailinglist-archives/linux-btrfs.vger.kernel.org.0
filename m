Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76CB5ADC22
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Sep 2022 02:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbiIFABg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Sep 2022 20:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232606AbiIFABe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Sep 2022 20:01:34 -0400
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C54D52E47
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Sep 2022 17:01:32 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id DAA3F80C62;
        Mon,  5 Sep 2022 20:01:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1662422492; bh=oD4DapS1KZRP9/Db6zooV26L1WOCdxIdtO+uiwaRRok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UX+Xh8YdXwXM6yHhMRCJ+XgnFSjSLzTy43oba2tcwb6f+AMXvwKNHOB0PdzsdE7NZ
         ndNF+Lufv1prBEv/aoQzTq5iWC8KE0w3LCtKNFGB8juFMy2J7KWouCCOv+fiYLBQ/T
         lGXQhwEzb9dgGYuYJTLUChjoa7G0jyYSIxLLvApjCgHsRgeYID8pvk/0rjVy1R8gl8
         AjaCXE8uFUFbLSci18WQbFa5JPkgtWAVz1BQ1o7BajSzJU2WyNZ7mEUUf+DoiK/F+q
         0f0POEyAXHS+FnWhvbwKxTUSaj7MyboVAkX0rnNXDtsgKmJgBQEi7m7nUE8Fyp3HWt
         IIvodZ+iZOiDA==
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH 6/6] btrfs-progs: check: update inline extent length checking
Date:   Mon,  5 Sep 2022 20:01:07 -0400
Message-Id: <4ec822ef3b3a6be3cbf07a878d475b273094795c.1662417859.git.sweettea-kernel@dorminy.me>
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
index be9b0134..5466f45d 100644
--- a/check/main.c
+++ b/check/main.c
@@ -1626,7 +1626,7 @@ static int process_file_extent(struct btrfs_root *root,
 	u64 mask = gfs_info->sectorsize - 1;
 	u32 max_inline_size = min_t(u32, mask,
 				BTRFS_MAX_INLINE_DATA_SIZE(gfs_info));
-	u8 compression;
+	u8 compression, encryption;
 	int extent_type;
 	int ret;
 
@@ -1651,25 +1651,25 @@ static int process_file_extent(struct btrfs_root *root,
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
2.35.1

