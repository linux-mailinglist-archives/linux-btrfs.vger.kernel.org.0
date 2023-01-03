Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02F3F65B972
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jan 2023 03:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236578AbjACCm7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Jan 2023 21:42:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbjACCm5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Jan 2023 21:42:57 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FBFB10F2;
        Mon,  2 Jan 2023 18:42:57 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id n65-20020a17090a2cc700b0021bc5ef7a14so29792110pjd.0;
        Mon, 02 Jan 2023 18:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8fkzQhp1crKGSgSx8k6HIdZaU8pHi19M3YgxX2aKMxI=;
        b=DHIvJaCQ6maLM8lILPL4VWUiTAZi93wbNMKHYiEwkekbNhqv9N9TKGNuzqOVEobp5p
         Cn5e2RMnJBhgB0TJZfsNVjopF5E2XzjvbKbQ12nhcEatgOzQecR2Q9AdM4q6g3GlelZ0
         m17m/unDTqoWrq7+x637ovTcnzzqzawh/egzIyytfCt3Vr9nNmLfZa4PyGBREVU/rwJ8
         J/UhUacOZp1rdUOvWv8/41wJ5b/hCOhq+XolhnkXwrUXCVgSpYCau7Hy2KUGYd/3K4+g
         O1PcqPmSXas50/b8Bbf/xtNBX1cSj+dYv0iMeqK1ucnd6Z16S6+FtBsQyYnAQb2klRDY
         xcjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8fkzQhp1crKGSgSx8k6HIdZaU8pHi19M3YgxX2aKMxI=;
        b=jd9ekfHJlVcC6xhRBeNZi5B9EzU9ytxs3rW4EHI5drYLuC4p7gn6/6lyKjRR0U6fey
         OM94K23Oy+YbLZlIiJx7uhO9gyW2pMxMjpcE9P4GiEYoQy73WLaujqmyoxLSsAAOm5BF
         9q9CiFvVMxI/+2+4gRe6WaGuvhijxNFnjCnQYRSKiOt0Lumd39azu6SDvyhBr6ZpR/Gl
         X8Ad4caMqmqbfa3+JG6qHvMXJWxqsZZtb4uvX6EondG3yKReS3wYA7Htpt9rzmuDbbTb
         +tgi4Hwk51oSo4IF8dD8he3gXDL1x87npE0rhh9TGZ9a7Pxq5yvW+ATGEUIhQCALE3vh
         h2gA==
X-Gm-Message-State: AFqh2ko2T4jL7c9V+NwkXtNtj+1+P+YgBR5ntcM7plPrbaqDR1QaaPoK
        tBmFPSaR2pTkAknKzO7UyJU=
X-Google-Smtp-Source: AMrXdXsfFOGY10WSLhxjnxlmb7z/kOCWm37mZqCGCRQnyzppVr3ya1ZIuUw/y/fJh4ZT271hSWTm5g==
X-Received: by 2002:a17:902:a402:b0:191:7d3:7fe4 with SMTP id p2-20020a170902a40200b0019107d37fe4mr39660058plq.59.1672713776713;
        Mon, 02 Jan 2023 18:42:56 -0800 (PST)
Received: from localhost.localdomain ([43.132.141.4])
        by smtp.gmail.com with ESMTPSA id b8-20020a1709027e0800b001895d871c95sm20923561plm.70.2023.01.02.18.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 18:42:56 -0800 (PST)
From:   zys.zljxml@gmail.com
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yushan Zhou <katrinzhou@tencent.com>
Subject: [PATCH v2] brtfs: use PAGE_ALIGNED macro
Date:   Tue,  3 Jan 2023 10:36:26 +0800
Message-Id: <20230103023626.3072656-1-zys.zljxml@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230102150357.GF11562@twin.jikos.cz>
References: <20230102150357.GF11562@twin.jikos.cz>
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

The header file linux/mm.h provides the PAGE_ALIGNED macro to
test whether an address is aligned to PAGE_SIZE. Use it instead
of IS_ALIGNED.

Signed-off-by: Yushan Zhou <katrinzhou@tencent.com>
---
 fs/btrfs/compression.c | 2 +-
 fs/btrfs/defrag.c      | 2 +-
 fs/btrfs/lzo.c         | 2 +-
 fs/btrfs/relocation.c  | 2 +-
 fs/btrfs/send.c        | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

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
index e65e6b6600a7..bab0ba3e6542 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
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

