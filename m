Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C962B65BA2B
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jan 2023 06:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbjACFMG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Jan 2023 00:12:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbjACFME (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Jan 2023 00:12:04 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104A26153;
        Mon,  2 Jan 2023 21:12:03 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id c9so14915937pfj.5;
        Mon, 02 Jan 2023 21:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MrLsJYJCl0GUbw8xUXHKhur/cDclpdHM4gEbb6ape38=;
        b=YUblAfcbYUoZigy84PUKdmiHPpqHvCoXUyrg0oPdFr3yQLVHRXnROC8VgTpBX8ad9v
         3BEfyiugMfrj2gQiEUWISwiivScsLFANErQvNRBofAsmEQbpAe+/BY1XiZ6kw9YvbXFn
         K+QWti4Yh5DvR15vH2+zdfPYpQPujqAXyQcFXgbLE8Fo1jwreU/2EFCsbbZRQ9E5sUkS
         /Odu5p3Wl7EuXXmqxWxkW+AlxQbSZ58LlXejYgezACteoAOnoBUyViBseqIoiKRL9R6g
         k9yXRk4lzfTj2UESAUZl6mjmYylSAlKmHQ6uqu0dVSF/Ajq6AvAOYD73Fu9wYkmoTqS+
         nDag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MrLsJYJCl0GUbw8xUXHKhur/cDclpdHM4gEbb6ape38=;
        b=hjv3VweJ2qZN7Uu7Xo46I7UglaRRGDzgBdljKVf3ONO/FURwl+SknmGsje7AmwpJu3
         kwgEmyCkDcsHZELrkr43m9qMoUGUgE2W5ufQHq2d5jlaIhETs0/nYDDJ8eYRanfOxS/x
         9ow2iy4bMCeuBOT9C7YBnUCt2lIzhVZvNGtxTX1//jU9owg7lQt+KvhfYfWV8orVkxc2
         XWR3HQhRXfbPqQsbWmbxhgv45PzsW1/NVtCyXbYxFA2MvrxSQSJT+qRtQUS1TfakjK1G
         1CkcP+rFbTiR5sluXXuaLSXRsNgcLNXtWbS6CEDIIkoaTjYAa1VaIa/SDYWufqMSkSch
         zvDA==
X-Gm-Message-State: AFqh2krzNIlBMroNrMzV3c5MINXDdpk+c+mqCneDBO0Ijkpl3TpZ1qkE
        JN3FkTxcgLuuLMsq6VQSMCI=
X-Google-Smtp-Source: AMrXdXtv8kuS6DHOgo+p/LCWdI+rS7JAQJJcyMBeAh/i2Pxs1lTwoAEPG7RehHhZIW9rekFROjBXVQ==
X-Received: by 2002:a05:6a00:1346:b0:581:c216:1390 with SMTP id k6-20020a056a00134600b00581c2161390mr23389911pfu.34.1672722722555;
        Mon, 02 Jan 2023 21:12:02 -0800 (PST)
Received: from localhost.localdomain ([43.132.141.3])
        by smtp.gmail.com with ESMTPSA id e185-20020a621ec2000000b00571cdbd0771sm3270695pfe.102.2023.01.02.21.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 21:12:02 -0800 (PST)
From:   zys.zljxml@gmail.com
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yushan Zhou <katrinzhou@tencent.com>
Subject: [PATCH v3] btrfs: use PAGE_{ALIGN, ALIGNED, ALIGN_DOWN} macro
Date:   Tue,  3 Jan 2023 13:11:37 +0800
Message-Id: <20230103051137.4085572-1-zys.zljxml@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Yushan Zhou <katrinzhou@tencent.com>

The header file linux/mm.h provides PAGE_ALIGN, PAGE_ALIGNED,
PAGE_ALIGN_DOWN macros. Use these macros to make code more
concise.

Signed-off-by: Yushan Zhou <katrinzhou@tencent.com>
---
 fs/btrfs/compression.c | 2 +-
 fs/btrfs/defrag.c      | 2 +-
 fs/btrfs/inode.c       | 5 ++---
 fs/btrfs/lzo.c         | 2 +-
 fs/btrfs/relocation.c  | 2 +-
 fs/btrfs/send.c        | 4 ++--
 6 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 5122ca79f7ea..4a5aeb8dd479 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -1609,7 +1609,7 @@ static void heuristic_collect_sample(struct inode *inode, u64 start, u64 end,
 	index_end = end >> PAGE_SHIFT;
 
 	/* Don't miss unaligned end */
-	if (!IS_ALIGNED(end, PAGE_SIZE))
+	if (!PAGE_ALIGNED(end))
 		index_end++;
 
 	curr_sample_pos = 0;
diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index 0a3c261b69c9..130de66839c1 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -997,7 +997,7 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
 }
 
 #define CLUSTER_SIZE	(SZ_256K)
-static_assert(IS_ALIGNED(CLUSTER_SIZE, PAGE_SIZE));
+static_assert(PAGE_ALIGNED(CLUSTER_SIZE));
 
 /*
  * Defrag one contiguous target range.
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 8bcad9940154..ff3b1ab6a696 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -10993,9 +10993,8 @@ static int btrfs_add_swap_extent(struct swap_info_struct *sis,
 		return 0;
 
 	max_pages = sis->max - bsi->nr_pages;
-	first_ppage = ALIGN(bsi->block_start, PAGE_SIZE) >> PAGE_SHIFT;
-	next_ppage = ALIGN_DOWN(bsi->block_start + bsi->block_len,
-				PAGE_SIZE) >> PAGE_SHIFT;
+	first_ppage = PAGE_ALIGN(bsi->block_start) >> PAGE_SHIFT;
+	next_ppage = PAGE_ALIGN_DOWN(bsi->block_start + bsi->block_len) >> PAGE_SHIFT;
 
 	if (first_ppage >= next_ppage)
 		return 0;
diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
index d5e78cbc8fbc..71f6d8302d50 100644
--- a/fs/btrfs/lzo.c
+++ b/fs/btrfs/lzo.c
@@ -280,7 +280,7 @@ int lzo_compress_pages(struct list_head *ws, struct address_space *mapping,
 		}
 
 		/* Check if we have reached page boundary */
-		if (IS_ALIGNED(cur_in, PAGE_SIZE)) {
+		if (PAGE_ALIGNED(cur_in)) {
 			put_page(page_in);
 			page_in = NULL;
 		}
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 31ec4a7658ce..ef13a9d4e370 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2825,7 +2825,7 @@ static noinline_for_stack int prealloc_file_extent_cluster(
 	 *
 	 * Here we have to manually invalidate the range (i_size, PAGE_END + 1).
 	 */
-	if (!IS_ALIGNED(i_size, PAGE_SIZE)) {
+	if (!PAGE_ALIGNED(i_size)) {
 		struct address_space *mapping = inode->vfs_inode.i_mapping;
 		struct btrfs_fs_info *fs_info = inode->root->fs_info;
 		const u32 sectorsize = fs_info->sectorsize;
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index e65e6b6600a7..b4cbd74fefce 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -5635,7 +5635,7 @@ static int send_encoded_extent(struct send_ctx *sctx, struct btrfs_path *path,
 	 * boundary in the send buffer. This means that there may be a gap
 	 * between the beginning of the command and the file data.
 	 */
-	data_offset = ALIGN(sctx->send_size, PAGE_SIZE);
+	data_offset = PAGE_ALIGN(sctx->send_size);
 	if (data_offset > sctx->send_max_size ||
 	    sctx->send_max_size - data_offset < disk_num_bytes) {
 		ret = -EOVERFLOW;
@@ -5759,7 +5759,7 @@ static int send_extent_data(struct send_ctx *sctx, struct btrfs_path *path,
 		sent += size;
 	}
 
-	if (sctx->clean_page_cache && IS_ALIGNED(end, PAGE_SIZE)) {
+	if (sctx->clean_page_cache && PAGE_ALIGNED(end)) {
 		/*
 		 * Always operate only on ranges that are a multiple of the page
 		 * size. This is not only to prevent zeroing parts of a page in
-- 
2.27.0

