Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D791629EAA
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 17:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238531AbiKOQQo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 11:16:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238456AbiKOQQh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 11:16:37 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33262AC55
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 08:16:36 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id jr19so8992040qtb.7
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 08:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UX1EYB41D8APecB/waBAKXx+tKOcjtQ0ZJkcg8QM5l4=;
        b=e+VGk/0NaKfnjZbeTN306vJmmO+MynOqUCUBz3gYr0kkECAYn+2tYpQFbD+qRKrs9F
         2QNKmygaany8pC2Kst/Cp+N4PagmxKLHj0TmDuK0YAXEW2CRZ4Jc7THZFf4IuisfMVsD
         RcarAd8+Y1RT+KTqsdqX27jdIrIk/xd0l2qJsRVIOoLamVjQJj8iPPjqOusTsJpltr2j
         S7ZPmexH5jw6JfzXOeuSY0SuQEPQ/YQy4bulMsIvGYu+PMGKILq3ai/9EJ6QlPpzJlYa
         QirisbnPZUSvE+fZE1uFISKI5ztUFEeESrSiWZSvpJ0fQJsEYD5G93EkRGTz3SLRKiBq
         lPMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UX1EYB41D8APecB/waBAKXx+tKOcjtQ0ZJkcg8QM5l4=;
        b=VaSUGuhWC/dVqAIq2IBf1nJuzxv0BH4bQp1kG3CS0yJDAb+ICJgMhJYXsNqIl97eKb
         p0nEZBInPVfxqlntT3FWKR/lWQ6heJndw1wg+3Zhz8dFWmc7JzSaXxs3bC8Jg9m36Qc3
         pBcMWsxDImBYJiNGKi9MqiK8aPMmF63h6FuUt61sCLmu5uQYSbPMvZN4nwJno60xEsY5
         11/Ipm1DKzeqZxcnW5CQ9MBkASwtYkOxYk1JWlIYjrSO+iumEH2lWDbaAD3h9sRfd3Dy
         aGB3DtI/PAbeKyyC907VNUzWV27rigefTjDK5Z7ssIJYMnwp5XoMZ+90xrmmZE7L5Lsg
         2F/A==
X-Gm-Message-State: ANoB5plK73fM0L+GHD6LAohD7g/5N08vXPIdQMq2ImKz7Mu2o0CGSj3R
        zULuin0WVlCG0ZgYZRdfW1f6JUEgjGX9mQ==
X-Google-Smtp-Source: AA0mqf7Cj8FkT9pF7ReAKdJrLu9ZZbFEg++MTCjMtLtyspae8sDNTISvs45kXe2vHOENvuc/lIHWag==
X-Received: by 2002:ac8:5a42:0:b0:399:83a8:c28b with SMTP id o2-20020ac85a42000000b0039983a8c28bmr16674724qta.447.1668528995575;
        Tue, 15 Nov 2022 08:16:35 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id f2-20020ac87f02000000b003a4c3c4d2d4sm7450506qtk.49.2022.11.15.08.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 08:16:35 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 09/11] btrfs: remove BTRFS_LEAF_DATA_OFFSET
Date:   Tue, 15 Nov 2022 11:16:18 -0500
Message-Id: <fd379376c26b49b6d36826cfd60bcc8909d767da.1668526429.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1668526429.git.josef@toxicpanda.com>
References: <cover.1668526429.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is simply the same thing as btrfs_item_nr_offset(leaf, 0), so
remove this helper and replace it's usage with the above statement.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/accessors.h | 6 ++----
 fs/btrfs/ctree.c     | 8 ++++----
 fs/btrfs/extent_io.c | 2 +-
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/accessors.h b/fs/btrfs/accessors.h
index 88eea44fdd7f..e6228ff73c81 100644
--- a/fs/btrfs/accessors.h
+++ b/fs/btrfs/accessors.h
@@ -9,8 +9,6 @@ struct btrfs_map_token {
 	unsigned long offset;
 };
 
-#define BTRFS_LEAF_DATA_OFFSET		offsetof(struct btrfs_leaf, items)
-
 void btrfs_init_map_token(struct btrfs_map_token *token, struct extent_buffer *eb);
 
 /*
@@ -1028,9 +1026,9 @@ BTRFS_SETGET_STACK_FUNCS(stack_verity_descriptor_size,
 
 /* Cast into the data area of the leaf. */
 #define btrfs_item_ptr(leaf, slot, type)				\
-	((type *)(BTRFS_LEAF_DATA_OFFSET + btrfs_item_offset(leaf, slot)))
+	((type *)(btrfs_item_nr_offset(leaf, 0) + btrfs_item_offset(leaf, slot)))
 
 #define btrfs_item_ptr_offset(leaf, slot)				\
-	((unsigned long)(BTRFS_LEAF_DATA_OFFSET + btrfs_item_offset(leaf, slot)))
+	((unsigned long)(btrfs_item_nr_offset(leaf, 0) + btrfs_item_offset(leaf, slot)))
 
 #endif
diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index ac8b76e90b1c..7e756b44771b 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -82,8 +82,8 @@ static inline void memmove_leaf_data(const struct extent_buffer *leaf,
 				     unsigned long src_offset,
 				     unsigned long len)
 {
-	memmove_extent_buffer(leaf, BTRFS_LEAF_DATA_OFFSET + dst_offset,
-			      BTRFS_LEAF_DATA_OFFSET + src_offset, len);
+	memmove_extent_buffer(leaf, btrfs_item_nr_offset(leaf, 0) + dst_offset,
+			      btrfs_item_nr_offset(leaf, 0) + src_offset, len);
 }
 
 /*
@@ -104,8 +104,8 @@ static inline void copy_leaf_data(const struct extent_buffer *dst,
 				  unsigned long dst_offset,
 				  unsigned long src_offset, unsigned long len)
 {
-	copy_extent_buffer(dst, src, BTRFS_LEAF_DATA_OFFSET + dst_offset,
-			   BTRFS_LEAF_DATA_OFFSET + src_offset, len);
+	copy_extent_buffer(dst, src, btrfs_item_nr_offset(dst, 0) + dst_offset,
+			   btrfs_item_nr_offset(src, 0) + src_offset, len);
 }
 
 /*
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 56dbe58818e1..c87be46e0663 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2664,7 +2664,7 @@ static void prepare_eb_write(struct extent_buffer *eb)
 		 * header 0 1 2 .. N ... data_N .. data_2 data_1 data_0
 		 */
 		start = btrfs_item_nr_offset(eb, nritems);
-		end = BTRFS_LEAF_DATA_OFFSET;
+		end = btrfs_item_nr_offset(eb, 0);
 		if (nritems == 0)
 			end += BTRFS_LEAF_DATA_SIZE(eb->fs_info);
 		else
-- 
2.26.3

