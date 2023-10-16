Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7150F7CB256
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Oct 2023 20:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234235AbjJPSWd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Oct 2023 14:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234050AbjJPSWX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Oct 2023 14:22:23 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BFD5A7
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Oct 2023 11:22:20 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-77410032cedso344635085a.1
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Oct 2023 11:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1697480539; x=1698085339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1EC2BrZuJgY6Pyv2LPz1FwiqkAGFlRQStgxYqSpmtjY=;
        b=fZ8pIv9Ef9nUupbOLpHDgyoW+lwq1NWK1+D5I/TGBgCR89pNJpvfz0Iq6Z74A+9k5L
         7hPAy9Lm8e9g7JCJwpJbd9VwKovEdRKUZ4HMK0jfo8ABht6etlQ5ulvgTEfvRftRSBEx
         lgisagbDqUQwq58RwqfOjfc9M3r31zb+GonlUj+fkUP2ahkZRZVcbEICCmp+QHwBFekL
         yqxgFe3Kno/x6HZLQNiQ21ySzDAVrxiMhMN9ycijRR7oOT5gx9Y2E8qj9TRfkK3UtQ7k
         ZXWopLTMbGoXmihEZccPausBFYp+PFiaTxvxkprS6MgaRkvsb2AmtweNd0NI3KH/qyAb
         6HIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697480539; x=1698085339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1EC2BrZuJgY6Pyv2LPz1FwiqkAGFlRQStgxYqSpmtjY=;
        b=BcyHAl0CZAfEI035xwVGuTNAt0pIg5/Mzzoa9IZyOiJ6GC51eh4FAnHbjiDDd1rXYy
         +k3GdBv+WQ1JSY/S/r3qikGWXmLygQkfMYJz98YyjarBMdVoixMEliV1oYRI+R/vXpBf
         Hb4tWIF1e3VrVifXBE5GCIrz10uNhgOSYQleXh4l2DrTRegeVZ7f+HdpK2YYBLSRZPJd
         BllWlNegAI33TNgLen1hHeykfNp56HKWn7ww7AdbxZUkDsZWJup1MptefN5wyYuMas2A
         JueZXMGdvU4/Mm0LnebsiQaa4ttAYV8YTYTJSGNDCz16U9g7pHqQhAh+120NvY9p2eM+
         GnnQ==
X-Gm-Message-State: AOJu0Yzev88yg8YHLqXoRFSv+Ohuct/+SrjdrGXLxsUAIsfPkrFBlyBo
        /Ez/57eKpjoMtlt2ykFBglBQGqlFxCpxG98kqXju1g==
X-Google-Smtp-Source: AGHT+IG8ew8pnwil665asxqNPp6eAIQFtOWbnucSxl4/raqg3pb7v2JrJfVda72pypdj9OWaIKqNaA==
X-Received: by 2002:a05:620a:3188:b0:76f:509:c78a with SMTP id bi8-20020a05620a318800b0076f0509c78amr41551740qkb.22.1697480539028;
        Mon, 16 Oct 2023 11:22:19 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id p13-20020a05620a132d00b00767b0c35c15sm3196859qkj.91.2023.10.16.11.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 11:22:18 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH v3 19/34] btrfs: add fscrypt_info and encryption_type to extent_map
Date:   Mon, 16 Oct 2023 14:21:26 -0400
Message-ID: <3db52022ad353dc0e7166e877d5785877a8eb7af.1697480198.git.josef@toxicpanda.com>
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

Each extent_map will end up with a pointer to its associated
fscrypt_info if any, which should have the same lifetime as the
extent_map. We are also going to need to track the encryption_type for
the file extent items.  Add the fscrypt_info to the extent_map, and the
subsequent code for transferring it in the split and merge cases, as
well as the code necessary to free them.  A future patch will add the
code to load them as appropriate.

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_map.c | 32 +++++++++++++++++++++++++++++---
 fs/btrfs/extent_map.h |  2 ++
 fs/btrfs/file-item.c  |  1 +
 fs/btrfs/inode.c      |  1 +
 4 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index af5ff6b10865..8c8023388758 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -61,6 +61,7 @@ struct extent_map *alloc_extent_map(void)
 
 static void __free_extent_map(struct extent_map *em)
 {
+	fscrypt_put_extent_info(em->fscrypt_info);
 	if (test_bit(EXTENT_FLAG_FS_MAPPING, &em->flags))
 		kfree(em->map_lookup);
 	kmem_cache_free(extent_map_cache, em);
@@ -103,12 +104,24 @@ void free_extent_map_safe(struct extent_map_tree *tree,
 	if (!em)
 		return;
 
-	if (refcount_dec_and_test(&em->refs)) {
-		WARN_ON(extent_map_in_tree(em));
-		WARN_ON(!list_empty(&em->list));
+	if (!refcount_dec_and_test(&em->refs))
+		return;
+
+	WARN_ON(extent_map_in_tree(em));
+	WARN_ON(!list_empty(&em->list));
+
+	/*
+	 * We could take a lock freeing the fscrypt_info, so add this to the
+	 * list of freed_extents to be freed later.
+	 */
+	if (em->fscrypt_info) {
 		list_add_tail(&em->free_list, &tree->freed_extents);
 		set_bit(EXTENT_MAP_TREE_PENDING_FREES, &tree->flags);
+		return;
 	}
+
+	/* Nothing scary here, just free the object. */
+	__free_extent_map(em);
 }
 
 /*
@@ -274,6 +287,12 @@ static int mergable_maps(struct extent_map *prev, struct extent_map *next)
 	if (!list_empty(&prev->list) || !list_empty(&next->list))
 		return 0;
 
+	/*
+	 * Don't merge adjacent encrypted maps.
+	 */
+	if (prev->fscrypt_info || next->fscrypt_info)
+		return 0;
+
 	ASSERT(next->block_start != EXTENT_MAP_DELALLOC &&
 	       prev->block_start != EXTENT_MAP_DELALLOC);
 
@@ -884,6 +903,8 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
 			split->generation = gen;
 			split->flags = flags;
 			split->compress_type = em->compress_type;
+			split->fscrypt_info =
+				fscrypt_get_extent_info(em->fscrypt_info);
 			replace_extent_mapping(em_tree, em, split, modified);
 			free_extent_map(split);
 			split = split2;
@@ -925,6 +946,8 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
 				split->orig_block_len = 0;
 			}
 
+			split->fscrypt_info =
+				fscrypt_get_extent_info(em->fscrypt_info);
 			if (extent_map_in_tree(em)) {
 				replace_extent_mapping(em_tree, em, split,
 						       modified);
@@ -1087,6 +1110,7 @@ int split_extent_map(struct btrfs_inode *inode, u64 start, u64 len, u64 pre,
 	split_pre->flags = flags;
 	split_pre->compress_type = em->compress_type;
 	split_pre->generation = em->generation;
+	split_pre->fscrypt_info = fscrypt_get_extent_info(em->fscrypt_info);
 
 	replace_extent_mapping(em_tree, em, split_pre, 1);
 
@@ -1106,6 +1130,8 @@ int split_extent_map(struct btrfs_inode *inode, u64 start, u64 len, u64 pre,
 	split_mid->flags = flags;
 	split_mid->compress_type = em->compress_type;
 	split_mid->generation = em->generation;
+	split_mid->fscrypt_info = fscrypt_get_extent_info(em->fscrypt_info);
+
 	add_extent_mapping(em_tree, split_mid, 1);
 
 	/* Once for us */
diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
index 2093720271ea..2d618e61ceb5 100644
--- a/fs/btrfs/extent_map.h
+++ b/fs/btrfs/extent_map.h
@@ -50,10 +50,12 @@ struct extent_map {
 	 */
 	u64 generation;
 	unsigned long flags;
+	struct fscrypt_extent_info *fscrypt_info;
 	/* Used for chunk mappings, flag EXTENT_FLAG_FS_MAPPING must be set */
 	struct map_lookup *map_lookup;
 	refcount_t refs;
 	unsigned int compress_type;
+	unsigned int encryption_type;
 	struct list_head list;
 	struct list_head free_list;
 };
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 45cae356e89b..26f35c1baedc 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -1305,6 +1305,7 @@ void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
 			if (type == BTRFS_FILE_EXTENT_PREALLOC)
 				set_bit(EXTENT_FLAG_PREALLOC, &em->flags);
 		}
+		em->encryption_type = btrfs_file_extent_encryption(leaf, fi);
 	} else if (type == BTRFS_FILE_EXTENT_INLINE) {
 		em->block_start = EXTENT_MAP_INLINE;
 		em->start = extent_start;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 9cb8b82ff8be..19087fd68cfe 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7348,6 +7348,7 @@ static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
 		set_bit(EXTENT_FLAG_COMPRESSED, &em->flags);
 		em->compress_type = compress_type;
 	}
+	em->encryption_type = BTRFS_ENCRYPTION_NONE;
 
 	ret = btrfs_replace_extent_map_range(inode, em, true);
 	if (ret) {
-- 
2.41.0

