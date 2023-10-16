Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87C377CB253
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Oct 2023 20:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234269AbjJPSWk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Oct 2023 14:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234206AbjJPSWa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Oct 2023 14:22:30 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B638121
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Oct 2023 11:22:23 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-4196ae80fc3so31360371cf.0
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Oct 2023 11:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1697480542; x=1698085342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sdhOZSbLFAWHbBthhX//NAxRHhPvITLPW+kiDV9DiQg=;
        b=ZsAqfcis1JpGq0CJASRXw+X4fkKAvn6YPrTCcOe4JgiA/92AWuGeQbysgTBHWtJzAA
         s9hSxu3LptUEWP7sTFRGGFof91vGMmAxvhWaEN4xnDhB7VnxyTcBneSKeuBeW0AMPBjq
         +W1nUWLkoVqZQuoIdEgCYKpp74HmP36Py6EtUTndUmBT1k0nsmWzQx/lXU1ptpyg8OLP
         FSgT1L7dKaoRNHe15rqYPC9IbDdljcUr1i39a+3Ad+IO05TjJPAtl9k/YXoUNJEgImka
         KnCqxZCa4eCBWfgdthQ6aNHTEUuZhqcMIeCyA5HV/JcYPDjNfkyDvIAv6RODDUUiL7qj
         DFSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697480542; x=1698085342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sdhOZSbLFAWHbBthhX//NAxRHhPvITLPW+kiDV9DiQg=;
        b=F5UiDCbrzG0i4oloSimxwBB1FTLXxqVJ408oVL8NurZZpHM+x9StZlGU/pKzuMNnO3
         eV+R45dZ0TPpQnG/5SDZm2pB4RFcDOgGEaRF0CyfrVUBM0n8M/s42mnQasZEy8hm58Ig
         wpXc/RBLSicHEaHQS56lY5IkHzfdwUqZNhfhTiuw3f2YIiKp+6Z5+MxATdOWtLzIA0vN
         mR4nNNbdNh0hY97Cjxbb5nL7HWzgyPcp7T2JDHsbi2bt0Gu6qO8idnmAfs1HpPfI5xLw
         aHKKXOf1oWNvfetmHs3fhaTcrWVyr0KbnWh2yyRWutwgMmhUZbcmb6Xyk+yEvxUYbFuj
         ROiw==
X-Gm-Message-State: AOJu0YxKwPHX6HRuZlrEvFF6JzSWTljoZHy1L/ajdkrBdzPo3MIfxtZo
        rzeaZKpGAzDS4AzlLVmozZ4BwRd+n9YFkADRdmDUMg==
X-Google-Smtp-Source: AGHT+IHEnttUR2BzuCXdNC+fS+GRZqIr3DtOslzjTpzGknIwu41/NeTP3Mco88gSaHjwtrIQWtvLiA==
X-Received: by 2002:ac8:7d0d:0:b0:417:f5ff:c14a with SMTP id g13-20020ac87d0d000000b00417f5ffc14amr112674qtb.43.1697480542625;
        Mon, 16 Oct 2023 11:22:22 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id k2-20020ac81402000000b004198f248e8dsm3208932qtj.76.2023.10.16.11.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 11:22:22 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 22/34] btrfs: populate the ordered_extent with the fscrypt context
Date:   Mon, 16 Oct 2023 14:21:29 -0400
Message-ID: <69aad726c4f6ba459b92c36eaff5fe6cab841bee.1697480198.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1697480198.git.josef@toxicpanda.com>
References: <cover.1697480198.git.josef@toxicpanda.com>
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

The fscrypt_extent_info will be tied to the extent_map lifetime, so it
will be created when we create the IO em, or it'll already exist in the
NOCOW case.  Use this fscrypt_info when creating the ordered extent to
make sure everything is passed through properly.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 62 +++++++++++++++++++++++++++++++++---------------
 1 file changed, 43 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index a1fa5b6f3790..7d859e327485 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1160,9 +1160,8 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 		ret = PTR_ERR(em);
 		goto out_free_reserve;
 	}
-	free_extent_map(em);
 
-	ordered = btrfs_alloc_ordered_extent(inode, NULL,
+	ordered = btrfs_alloc_ordered_extent(inode, em->fscrypt_info,
 				       start,			/* file_offset */
 				       async_extent->ram_size,	/* num_bytes */
 				       async_extent->ram_size,	/* ram_bytes */
@@ -1171,6 +1170,7 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 				       0,			/* offset */
 				       1 << BTRFS_ORDERED_COMPRESSED,
 				       async_extent->compress_type);
+	free_extent_map(em);
 	if (IS_ERR(ordered)) {
 		btrfs_drop_extent_map_range(inode, start, end, false);
 		ret = PTR_ERR(ordered);
@@ -1424,13 +1424,13 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 			ret = PTR_ERR(em);
 			goto out_reserve;
 		}
-		free_extent_map(em);
 
-		ordered = btrfs_alloc_ordered_extent(inode, NULL,
+		ordered = btrfs_alloc_ordered_extent(inode, em->fscrypt_info,
 					start, ram_size, ram_size, ins.objectid,
 					cur_alloc_size, 0,
 					1 << BTRFS_ORDERED_REGULAR,
 					BTRFS_COMPRESS_NONE);
+		free_extent_map(em);
 		if (IS_ERR(ordered)) {
 			ret = PTR_ERR(ordered);
 			goto out_drop_extent_cache;
@@ -2003,6 +2003,8 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 		struct btrfs_key found_key;
 		struct btrfs_file_extent_item *fi;
 		struct extent_buffer *leaf;
+		struct extent_map *em = NULL;
+		struct fscrypt_extent_info *fscrypt_info = NULL;
 		u64 extent_end;
 		u64 ram_bytes;
 		u64 nocow_end;
@@ -2143,7 +2145,6 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 		is_prealloc = extent_type == BTRFS_FILE_EXTENT_PREALLOC;
 		if (is_prealloc) {
 			u64 orig_start = found_key.offset - nocow_args.extent_offset;
-			struct extent_map *em;
 
 			em = create_io_em(inode, cur_offset, nocow_args.num_bytes,
 					  orig_start,
@@ -2157,16 +2158,32 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 				ret = PTR_ERR(em);
 				goto error;
 			}
-			free_extent_map(em);
+			fscrypt_info = em->fscrypt_info;
+		} else if (IS_ENCRYPTED(&inode->vfs_inode)) {
+			/*
+			 * We only want to do this lookup if we're encrypted,
+			 * otherwise fsrypt_info will be null and we can avoid
+			 * this lookup.
+			 */
+			em = btrfs_get_extent(inode, NULL, 0, cur_offset,
+					      nocow_args.num_bytes);
+			if (IS_ERR(em)) {
+				btrfs_dec_nocow_writers(nocow_bg);
+				ret = PTR_ERR(em);
+				goto error;
+			}
+			fscrypt_info = em->fscrypt_info;
 		}
 
-		ordered = btrfs_alloc_ordered_extent(inode, NULL, cur_offset,
-				nocow_args.num_bytes, nocow_args.num_bytes,
-				nocow_args.disk_bytenr, nocow_args.num_bytes, 0,
+		ordered = btrfs_alloc_ordered_extent(inode, fscrypt_info,
+				cur_offset, nocow_args.num_bytes,
+				nocow_args.num_bytes, nocow_args.disk_bytenr,
+				nocow_args.num_bytes, 0,
 				is_prealloc
 				? (1 << BTRFS_ORDERED_PREALLOC)
 				: (1 << BTRFS_ORDERED_NOCOW),
 				BTRFS_COMPRESS_NONE);
+		free_extent_map(em);
 		btrfs_dec_nocow_writers(nocow_bg);
 		if (IS_ERR(ordered)) {
 			if (is_prealloc) {
@@ -7022,6 +7039,7 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 
 static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
 						  struct btrfs_dio_data *dio_data,
+						  struct extent_map *orig_em,
 						  const u64 start,
 						  const u64 len,
 						  const u64 orig_start,
@@ -7033,6 +7051,7 @@ static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
 {
 	struct extent_map *em = NULL;
 	struct btrfs_ordered_extent *ordered;
+	struct fscrypt_extent_info *fscrypt_info = NULL;
 
 	if (type != BTRFS_ORDERED_NOCOW) {
 		em = create_io_em(inode, start, len, orig_start, block_start,
@@ -7041,9 +7060,13 @@ static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
 				  type);
 		if (IS_ERR(em))
 			goto out;
+		fscrypt_info = em->fscrypt_info;
+	} else {
+		fscrypt_info = orig_em->fscrypt_info;
 	}
-	ordered = btrfs_alloc_ordered_extent(inode, NULL, start, len, len,
-					     block_start, block_len, 0,
+
+	ordered = btrfs_alloc_ordered_extent(inode, fscrypt_info, start, len,
+					     len, block_start, block_len, 0,
 					     (1 << type) |
 					     (1 << BTRFS_ORDERED_DIRECT),
 					     BTRFS_COMPRESS_NONE);
@@ -7080,9 +7103,10 @@ static struct extent_map *btrfs_new_extent_direct(struct btrfs_inode *inode,
 	if (ret)
 		return ERR_PTR(ret);
 
-	em = btrfs_create_dio_extent(inode, dio_data, start, ins.offset, start,
-				     ins.objectid, ins.offset, ins.offset,
-				     ins.offset, BTRFS_ORDERED_REGULAR);
+	em = btrfs_create_dio_extent(inode, dio_data, NULL, start, ins.offset,
+				     start, ins.objectid, ins.offset,
+				     ins.offset, ins.offset,
+				     BTRFS_ORDERED_REGULAR);
 	btrfs_dec_block_group_reservations(fs_info, ins.objectid);
 	if (IS_ERR(em))
 		btrfs_free_reserved_extent(fs_info, ins.objectid, ins.offset,
@@ -7426,9 +7450,9 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 		}
 		space_reserved = true;
 
-		em2 = btrfs_create_dio_extent(BTRFS_I(inode), dio_data, start, len,
-					      orig_start, block_start,
-					      len, orig_block_len,
+		em2 = btrfs_create_dio_extent(BTRFS_I(inode), dio_data, em,
+					      start, len, orig_start,
+					      block_start, len, orig_block_len,
 					      ram_bytes, type);
 		btrfs_dec_nocow_writers(bg);
 		if (type == BTRFS_ORDERED_PREALLOC) {
@@ -10512,14 +10536,14 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 		ret = PTR_ERR(em);
 		goto out_free_reserved;
 	}
-	free_extent_map(em);
 
-	ordered = btrfs_alloc_ordered_extent(inode, NULL, start,
+	ordered = btrfs_alloc_ordered_extent(inode, em->fscrypt_info, start,
 				       num_bytes, ram_bytes, ins.objectid,
 				       ins.offset, encoded->unencoded_offset,
 				       (1 << BTRFS_ORDERED_ENCODED) |
 				       (1 << BTRFS_ORDERED_COMPRESSED),
 				       compression);
+	free_extent_map(em);
 	if (IS_ERR(ordered)) {
 		btrfs_drop_extent_map_range(inode, start, end, false);
 		ret = PTR_ERR(ordered);
-- 
2.41.0

