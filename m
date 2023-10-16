Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A667CB254
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Oct 2023 20:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234317AbjJPSWq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Oct 2023 14:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234151AbjJPSWd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Oct 2023 14:22:33 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81B3182
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Oct 2023 11:22:26 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3af65455e7cso3238866b6e.1
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Oct 2023 11:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1697480546; x=1698085346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pxrkS5UiXrc0n0rxCHTTgd+SaI48QgT778UJ2JdcUoc=;
        b=kN6esBnoHWaV0mje4AWnQ+zf59T8EJKPJgUVsLk7jaXOI2hfWRBISSoOlDcU+/e8rm
         97MapkmvLxQJj8ACrsl06DZlnuz3gSGDN7kIvMTn90QRjHLhIO8iq2F+NIXn6/ARb3MT
         w4Qsf+gQFN/a468aMDFeLI2JRv2WY+odCDjWn/khAwvrhJ+6tH5JQIbCOHhCp75KONqi
         1EuAyJ07UHyPTIUZ3/6b1ywmMS1KoL8yGrZYt+sLOJ+pPoKodMSgB71iqTxvHpcw90Ax
         HW01u6JvqldyL7jGdULZT/HOybE5dPRrDJ490sf/YaI33Iuo81l4vOYlE4r92bwEqcCq
         g9pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697480546; x=1698085346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pxrkS5UiXrc0n0rxCHTTgd+SaI48QgT778UJ2JdcUoc=;
        b=haomSw9SJs18zg4bzo3ENK7PP5c4aVZkkgrA/PwPFRGX6hNph5FYQoLk+sbvb36PiQ
         pkaQ6bs5HPOnwBRIDlZu3bBHEoofkcIRYxDAvdQWIzQYuKZYH5XJ7ONt+r/KX4WMhHLI
         k8vFldX/tIR9GqWm21eQvJu3bca8mtIIcOugueRRP6t9TU+GhkBcRzFUIW0TtV5Plvn9
         pyieXSa6FciaXwCjgfRSpVgXAhBc9CjBEL/Cf5Gk75/9995rHG9mGAKjUbGqIqYkgRFS
         Dfr5f1lWLBKVKFHhpglpqhhIPdwqEEaeHODKM+1U3Iwpnh0ZqhyYU2iRN/+EktEYIeuV
         P/EQ==
X-Gm-Message-State: AOJu0YwIl6tSaRY30/23bYoJ+qFyKivgkmJ3/PR5M6q9y3QikWpmqUxU
        +4lHb1YXfKEBAXVaW8xyY7rlimk/bbebv5aYwOoNlA==
X-Google-Smtp-Source: AGHT+IEsiLZYZ2ZgK5GKHvS4I+p4SHccWHbRc3G2frrEJO3a5XSBxY2/6T7k5znZQtDEmBXgJUkd2g==
X-Received: by 2002:a05:6808:2197:b0:3ae:4cad:91a0 with SMTP id be23-20020a056808219700b003ae4cad91a0mr166452oib.6.1697480546044;
        Mon, 16 Oct 2023 11:22:26 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id j5-20020a0cc345000000b0064c1b27bf2dsm3580350qvi.140.2023.10.16.11.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 11:22:25 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH v3 25/34] btrfs: explicitly track file extent length for replace and drop
Date:   Mon, 16 Oct 2023 14:21:32 -0400
Message-ID: <0c31f8c616d631fc53fe67985f357266a94cb0bc.1697480198.git.josef@toxicpanda.com>
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

From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>

With the advent of storing fscrypt contexts with each encrypted extent,
extents will have a variable length depending on encryption status.
Make sure the replace and drop file extent item helpers encode this
information so that everything gets updated properly.

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h    | 2 ++
 fs/btrfs/file.c     | 4 ++--
 fs/btrfs/inode.c    | 7 +++++--
 fs/btrfs/reflink.c  | 1 +
 fs/btrfs/tree-log.c | 5 +++--
 5 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index c8f1d2d7c46c..e5879bd7f2f7 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -372,6 +372,8 @@ struct btrfs_replace_extent_info {
 	u64 file_offset;
 	/* Pointer to a file extent item of type regular or prealloc. */
 	char *extent_buf;
+	/* The length of @extent_buf */
+	u32 extent_buf_size;
 	/*
 	 * Set to true when attempting to replace a file range with a new extent
 	 * described by this structure, set to false when attempting to clone an
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 26905b77c7e8..a19ac854e07f 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2261,14 +2261,14 @@ static int btrfs_insert_replace_extent(struct btrfs_trans_handle *trans,
 	key.type = BTRFS_EXTENT_DATA_KEY;
 	key.offset = extent_info->file_offset;
 	ret = btrfs_insert_empty_item(trans, root, path, &key,
-				      sizeof(struct btrfs_file_extent_item));
+				      extent_info->extent_buf_size);
 	if (ret)
 		return ret;
 	leaf = path->nodes[0];
 	slot = path->slots[0];
 	write_extent_buffer(leaf, extent_info->extent_buf,
 			    btrfs_item_ptr_offset(leaf, slot),
-			    sizeof(struct btrfs_file_extent_item));
+			    extent_info->extent_buf_size);
 	extent = btrfs_item_ptr(leaf, slot, struct btrfs_file_extent_item);
 	ASSERT(btrfs_file_extent_type(leaf, extent) != BTRFS_FILE_EXTENT_INLINE);
 	btrfs_set_file_extent_offset(leaf, extent, extent_info->data_offset);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index d20ccfc5038f..03bc9f41bd33 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2898,6 +2898,7 @@ static int insert_reserved_file_extent(struct btrfs_trans_handle *trans,
 	u64 num_bytes = btrfs_stack_file_extent_num_bytes(stack_fi);
 	u64 ram_bytes = btrfs_stack_file_extent_ram_bytes(stack_fi);
 	struct btrfs_drop_extents_args drop_args = { 0 };
+	size_t fscrypt_context_size = 0;
 	int ret;
 
 	path = btrfs_alloc_path();
@@ -2917,7 +2918,7 @@ static int insert_reserved_file_extent(struct btrfs_trans_handle *trans,
 	drop_args.start = file_pos;
 	drop_args.end = file_pos + num_bytes;
 	drop_args.replace_extent = true;
-	drop_args.extent_item_size = sizeof(*stack_fi);
+	drop_args.extent_item_size = sizeof(*stack_fi) + fscrypt_context_size;
 	ret = btrfs_drop_extents(trans, root, inode, &drop_args);
 	if (ret)
 		goto out;
@@ -2928,7 +2929,7 @@ static int insert_reserved_file_extent(struct btrfs_trans_handle *trans,
 		ins.type = BTRFS_EXTENT_DATA_KEY;
 
 		ret = btrfs_insert_empty_item(trans, root, path, &ins,
-					      sizeof(*stack_fi));
+					      sizeof(*stack_fi) + fscrypt_context_size);
 		if (ret)
 			goto out;
 	}
@@ -9671,6 +9672,7 @@ static struct btrfs_trans_handle *insert_prealloc_file_extent(
 	u64 len = ins->offset;
 	int qgroup_released;
 	int ret;
+	size_t fscrypt_context_size = 0;
 
 	memset(&stack_fi, 0, sizeof(stack_fi));
 
@@ -9703,6 +9705,7 @@ static struct btrfs_trans_handle *insert_prealloc_file_extent(
 	extent_info.data_len = len;
 	extent_info.file_offset = file_offset;
 	extent_info.extent_buf = (char *)&stack_fi;
+	extent_info.extent_buf_size = sizeof(stack_fi) + fscrypt_context_size;
 	extent_info.is_new_extent = true;
 	extent_info.update_times = true;
 	extent_info.qgroup_reserved = qgroup_released;
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index 3c66630d87ee..f5440ae447a4 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -500,6 +500,7 @@ static int btrfs_clone(struct inode *src, struct inode *inode,
 			clone_info.data_len = datal;
 			clone_info.file_offset = new_key.offset;
 			clone_info.extent_buf = buf;
+			clone_info.extent_buf_size = size;
 			clone_info.is_new_extent = false;
 			clone_info.update_times = !no_time_update;
 			ret = btrfs_replace_file_extents(BTRFS_I(inode), path,
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 404577383513..6cdb924944d1 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4628,6 +4628,7 @@ static int log_one_extent(struct btrfs_trans_handle *trans,
 	u64 extent_offset = em->start - em->orig_start;
 	u64 block_len;
 	int ret;
+	size_t fscrypt_context_size = 0;
 	u8 encryption = BTRFS_ENCRYPTION_NONE;
 
 	btrfs_set_stack_file_extent_generation(&fi, trans->transid);
@@ -4670,7 +4671,7 @@ static int log_one_extent(struct btrfs_trans_handle *trans,
 		drop_args.start = em->start;
 		drop_args.end = em->start + em->len;
 		drop_args.replace_extent = true;
-		drop_args.extent_item_size = sizeof(fi);
+		drop_args.extent_item_size = sizeof(fi) + fscrypt_context_size;
 		ret = btrfs_drop_extents(trans, log, inode, &drop_args);
 		if (ret)
 			return ret;
@@ -4682,7 +4683,7 @@ static int log_one_extent(struct btrfs_trans_handle *trans,
 		key.offset = em->start;
 
 		ret = btrfs_insert_empty_item(trans, log, path, &key,
-					      sizeof(fi));
+					      sizeof(fi) + fscrypt_context_size);
 		if (ret)
 			return ret;
 	}
-- 
2.41.0

