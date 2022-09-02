Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2405AB956
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Sep 2022 22:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbiIBUR3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Sep 2022 16:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbiIBURW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Sep 2022 16:17:22 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB95C889B
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Sep 2022 13:17:21 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id h22so2370036qtu.2
        for <linux-btrfs@vger.kernel.org>; Fri, 02 Sep 2022 13:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=7C/sUqpz+4843Z2ZLxKhlnRqp1+eNYnlR5Hpb3YilQQ=;
        b=daELAF4KWM6snfoPMC1tIe2PuQbv2tjMwECkrSQjAkW8xEZGv0izIvgbBfLPYTHNSv
         pM/C+FwXyEEDKSiJku/mix6FQBs7OaGP72eaaRtN9d0nlE32PK2viCEoaBZvBo0f5Sdb
         Jz5sB4fcBYqSBjhfetGYvkRyhK2ET3KQMOQgpe+iD9V+9QoFRpKKsIkTaqQ4Fz9Vj4v9
         ZTmJoAH6z063s5jA3vNO3eW0kgbIc2TkPrV335lONXHed9qUD7AOe3AXDiJUgRTO6dhW
         AkNwcH2rWXfqun+BkIYn5IZxPTy2NrBnSBlcgWIZEHFUYLiwHpSa7AIRVnxlJ5p+8CIf
         OrZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=7C/sUqpz+4843Z2ZLxKhlnRqp1+eNYnlR5Hpb3YilQQ=;
        b=Y8gDxpxB2AUdi5U7v4IwHM+b12cxaIdgv9u+ExcFIDRxtzIzHFn6KMyL5WIwHOUNlH
         c5JOy+6ediu+2PaUqLdeoZAVsmi3dA2DAgUY6RplWjMuSPhbFAuULFwGfAVJJY2IButr
         Cco9sysy9JFTDKiouddGM+m9eXhIjjkxywJiv823t6Pwww54a//TXbhkXUCtEhSqaCuf
         FTH2DnKf5yEMLDGGdU6yAjATBu/EyhaBjaoZ5xl1ZpNjnPfIni4qSGIJyfZxJONqhgNa
         vJc/we89HhqvDuGFvnI9VCdbvugQppkMF8FeNMPP8ItHzDU7cEd0rjZEvdLOR81HkbTd
         xDng==
X-Gm-Message-State: ACgBeo2aFcwHyz7MSCaHc5TLcyyXVXLhxI3Uu52jjpVcsrTPesZQonUC
        Z2XLDLW3HIx1YJ4wOA03c9J3BbuPIY4Vhg==
X-Google-Smtp-Source: AA6agR6vKAzPPJSUrLaYeK/lH0e+FOT39G/VbKL41e150XgHjNK08jA41qAQF+A/39tsjzVe7+80eQ==
X-Received: by 2002:a05:622a:15c3:b0:344:7c48:bfb2 with SMTP id d3-20020a05622a15c300b003447c48bfb2mr29883697qty.370.1662149840200;
        Fri, 02 Sep 2022 13:17:20 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id b22-20020ac86bd6000000b003447c4f5aa5sm1564947qtt.24.2022.09.02.13.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 13:17:19 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 24/31] btrfs: drop extent_changeset from set_extent_bit
Date:   Fri,  2 Sep 2022 16:16:29 -0400
Message-Id: <c8809a81b10a040a12fb8c6a096f300707b688a0.1662149276.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1662149276.git.josef@toxicpanda.com>
References: <cover.1662149276.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The only places that set extent_changeset is set_record_extent_bits,
everywhere else sets it to NULL.  Drop this argument from
set_extent_bit.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-io-tree.c |  5 ++---
 fs/btrfs/extent-io-tree.h | 18 ++++++++----------
 fs/btrfs/inode.c          |  4 ++--
 3 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 9440879862c8..7786f603d097 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -1011,11 +1011,10 @@ static int __set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 }
 
 int set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
-		   u32 bits, struct extent_state **cached_state, gfp_t mask,
-		   struct extent_changeset *changeset)
+		   u32 bits, struct extent_state **cached_state, gfp_t mask)
 {
 	return __set_extent_bit(tree, start, end, bits, NULL, cached_state,
-				changeset, mask);
+				NULL, mask);
 }
 
 /**
diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index 991bfa3a8391..113727a1c8d1 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -160,19 +160,18 @@ static inline int clear_extent_bits(struct extent_io_tree *tree, u64 start,
 int set_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
 			   u32 bits, struct extent_changeset *changeset);
 int set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
-		   u32 bits, struct extent_state **cached_state, gfp_t mask,
-		   struct extent_changeset *changeset);
+		   u32 bits, struct extent_state **cached_state, gfp_t mask);
 
 static inline int set_extent_bits_nowait(struct extent_io_tree *tree, u64 start,
 					 u64 end, u32 bits)
 {
-	return set_extent_bit(tree, start, end, bits, NULL, GFP_NOWAIT, NULL);
+	return set_extent_bit(tree, start, end, bits, NULL, GFP_NOWAIT);
 }
 
 static inline int set_extent_bits(struct extent_io_tree *tree, u64 start,
 		u64 end, u32 bits)
 {
-	return set_extent_bit(tree, start, end, bits, NULL, GFP_NOFS, NULL);
+	return set_extent_bit(tree, start, end, bits, NULL, GFP_NOFS);
 }
 
 static inline int clear_extent_uptodate(struct extent_io_tree *tree, u64 start,
@@ -185,7 +184,7 @@ static inline int clear_extent_uptodate(struct extent_io_tree *tree, u64 start,
 static inline int set_extent_dirty(struct extent_io_tree *tree, u64 start,
 		u64 end, gfp_t mask)
 {
-	return set_extent_bit(tree, start, end, EXTENT_DIRTY, NULL, mask, NULL);
+	return set_extent_bit(tree, start, end, EXTENT_DIRTY, NULL, mask);
 }
 
 static inline int clear_extent_dirty(struct extent_io_tree *tree, u64 start,
@@ -206,7 +205,7 @@ static inline int set_extent_delalloc(struct extent_io_tree *tree, u64 start,
 {
 	return set_extent_bit(tree, start, end,
 			      EXTENT_DELALLOC | extra_bits,
-			      cached_state, GFP_NOFS, NULL);
+			      cached_state, GFP_NOFS);
 }
 
 static inline int set_extent_defrag(struct extent_io_tree *tree, u64 start,
@@ -214,21 +213,20 @@ static inline int set_extent_defrag(struct extent_io_tree *tree, u64 start,
 {
 	return set_extent_bit(tree, start, end,
 			      EXTENT_DELALLOC | EXTENT_DEFRAG,
-			      cached_state, GFP_NOFS, NULL);
+			      cached_state, GFP_NOFS);
 }
 
 static inline int set_extent_new(struct extent_io_tree *tree, u64 start,
 		u64 end)
 {
-	return set_extent_bit(tree, start, end, EXTENT_NEW, NULL, GFP_NOFS,
-			      NULL);
+	return set_extent_bit(tree, start, end, EXTENT_NEW, NULL, GFP_NOFS);
 }
 
 static inline int set_extent_uptodate(struct extent_io_tree *tree, u64 start,
 		u64 end, struct extent_state **cached_state, gfp_t mask)
 {
 	return set_extent_bit(tree, start, end, EXTENT_UPTODATE,
-			      cached_state, mask, NULL);
+			      cached_state, mask);
 }
 
 int find_first_extent_bit(struct extent_io_tree *tree, u64 start,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b82d220e9342..e0c0923e5956 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2817,7 +2817,7 @@ static int btrfs_find_new_delalloc_bytes(struct btrfs_inode *inode,
 		ret = set_extent_bit(&inode->io_tree, search_start,
 				     search_start + em_len - 1,
 				     EXTENT_DELALLOC_NEW, cached_state,
-				     GFP_NOFS, NULL);
+				     GFP_NOFS);
 next:
 		search_start = extent_map_end(em);
 		free_extent_map(em);
@@ -4963,7 +4963,7 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
 
 	if (only_release_metadata)
 		set_extent_bit(&inode->io_tree, block_start, block_end,
-			       EXTENT_NORESERVE, NULL, GFP_NOFS, NULL);
+			       EXTENT_NORESERVE, NULL, GFP_NOFS);
 
 out_unlock:
 	if (ret) {
-- 
2.26.3

