Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F0F7C413C
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Oct 2023 22:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234466AbjJJU2m (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Oct 2023 16:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjJJU2k (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Oct 2023 16:28:40 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41006AF
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Oct 2023 13:28:39 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d81d09d883dso6680555276.0
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Oct 2023 13:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1696969718; x=1697574518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4LzDGmpMBZ38H2nIF78o0VPhtObXIvEqVfGZY9bSPdI=;
        b=OYYPG6dBiQmDEuqQWn6UZJ53aIrk0+dkAVMK8aHV6UmD3sA6/Z/4DkCGidiVYLqNXk
         A9Lte02U0rwCq7ZMbqAhSoL6Za8qI8NjxDEP+5T1CL6RRFYjW8PNavv3wKLbyxv22YVS
         iHc2C1hRTu8HKRtT2fa88Iy34BC6ZE8gJh6pRrvXbeEl6fxiBNcemkW6cFjmgdI4rN1L
         3vdjlVIzFCaJst+s12cOTW9xGuPxTBcNyLx5ykWuP45TCHffyoKPv2P0lAAC4U3Msan6
         Cn5z7hF1e2YqJKHbwi5BcrD/X8a5BiPYrUwjCchpRDO49blhVDB3Pb0cROo9gNjtC5rC
         Hc3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696969718; x=1697574518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4LzDGmpMBZ38H2nIF78o0VPhtObXIvEqVfGZY9bSPdI=;
        b=hPV4gmp+gOWDF0X31Dlox2nr4yev2XL3GJqcRh2otgQsPGXuuOd7aa61OkgkxuNN9R
         UoebuMYc2jmESFul9eHu8Xss5ZSTxI//KViJVFVabYdpzrLHyz+FgBhIKNNeR954/mGv
         R4ANyfRFvW68ASjBSgSXNGTjZDX4nY9kRmqo5obGF2ttOndA3fYawpPTRqNHWZcVRQLS
         oSJzlj7Gozm5JY6uxqbUN53+GzZ5YTZBdHdpe3P4KfhywOgmve1Z7xzcNjqrWAb4hWGR
         HYuA0laN034SlyxhUJ3b9iuk93Kv0AB8E5SyEaSxye5M7c3znQ5AkSfAxwc3GyrMKSI5
         FPUQ==
X-Gm-Message-State: AOJu0YwY+2Pj2Q4UIKrHWBuahnF41pzdKzyNxHB/sGe5OOayQs5YZole
        zWI5iyC7jJyuXaGY0/vKAlegy1WpdHJ4gh5Hkp0HXA==
X-Google-Smtp-Source: AGHT+IGgQJwBQyhuK7PXD6nKqfhqsJT5koHkeOnNj7pV5vmE40+FTvdpJIQtWQVF3UyV6aSoN02fLA==
X-Received: by 2002:a25:a029:0:b0:d74:62df:e802 with SMTP id x38-20020a25a029000000b00d7462dfe802mr16776448ybh.0.1696969718361;
        Tue, 10 Oct 2023 13:28:38 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id t29-20020a252d1d000000b00d746487d6f7sm615737ybt.35.2023.10.10.13.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 13:28:38 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH 8/8] btrfs-progs: check: update inline extent length checking
Date:   Tue, 10 Oct 2023 16:28:25 -0400
Message-ID: <5741808b5b32ad9d7671f59fbfc8524867407c3d.1696969632.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1696969632.git.josef@toxicpanda.com>
References: <cover.1696969632.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>

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
index e841ae9c..a8c4c7cf 100644
--- a/check/main.c
+++ b/check/main.c
@@ -1642,7 +1642,7 @@ static int process_file_extent(struct btrfs_root *root,
 	u64 mask = gfs_info->sectorsize - 1;
 	u32 max_inline_size = min_t(u32, gfs_info->sectorsize,
 				BTRFS_MAX_INLINE_DATA_SIZE(gfs_info));
-	u8 compression;
+	u8 compression, encryption;
 	int extent_type;
 	int ret;
 
@@ -1667,25 +1667,25 @@ static int process_file_extent(struct btrfs_root *root,
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

