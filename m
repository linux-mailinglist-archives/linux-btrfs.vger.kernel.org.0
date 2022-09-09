Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 898F35B41E2
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Sep 2022 23:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbiIIVyn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Sep 2022 17:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbiIIVyh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Sep 2022 17:54:37 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2DFBE08
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Sep 2022 14:54:34 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id h21so2356946qta.3
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Sep 2022 14:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=DpiMVNvlYtLPNTjvXUge7d748tI5+GHZp/+OkrCZSy4=;
        b=faWZ6/Wfi9xRnxZIeHfY3Bs0Wus7fc+pzIuhMHgESUBXZsu1+jQkDDe4Y6y7ilFV0U
         6oYB3cjXbXaDiVVsv3UC3qxvAxrT31kF8NQd7x39mHyR7jDA0tHnaNF3SYJ6vODf0owA
         T2bNZXhni/AWGzvvFCsAIhwZQMFRqHcdh12QFNpqy6yNnH91NVXxHi1K3vEI1L68itzi
         vn4pAaNbYrUpkX5JaSVTl9kJ9RERR0Oaeaf4si1DnX3updV3N7mJ6Lfg6bEz4UPPmkwU
         kVqtM78vD93VY/QlPY1lM6pTObZBJHyd+54GWQR4CcWwFPiL3E8u3nZbDbsk9Ds+14i7
         wEdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=DpiMVNvlYtLPNTjvXUge7d748tI5+GHZp/+OkrCZSy4=;
        b=pQp4SGjVEy/4NAvasFL8h6vK/9Qd0V6R9n2oignKnrO74bq+H9qCgsSJWnlsRLIzqH
         f5ZmMq1Hey+N2//+CqLYwLrZa4EeTS6WZor1eah5pmI9F4VsmwKOgl8PthPeSw+Bc6vI
         WvbSBxU+EIsvFmS+CrFq5x3GqIiQEA89DhZeKOgkqzS+vma5m98xuI1/g4JzMLiUhqVW
         xWePcMKmkJ9NUmB/DHW0PUr6lrVmx9G4hlCZmw1//4UrwOqpanCTGuJU9Ei2j5nYaT4q
         nWeYJwhDNCoRETIUuM53YH+3uLHy26Tk/xZhunKLDAaLY3g4XRE1H4tYDDx5JhinZyGr
         yPNw==
X-Gm-Message-State: ACgBeo0rHGCLYu0PCuLAhX9sRZHpyHsZLLgCT3US6CZYj+uXuhesgIRO
        FnkTqYiFtPDfHQOiwMdoJ9eyzhyqi4Xirg==
X-Google-Smtp-Source: AA6agR4gNcitF1ijmtM50AfkpH65lqbEYWwV8l4eHGIQbSNVpCTLLckmmS6ZZrnfIMBllwWHBSz7DA==
X-Received: by 2002:a05:622a:5d4:b0:344:98a8:8dae with SMTP id d20-20020a05622a05d400b0034498a88daemr14590623qtb.164.1662760473284;
        Fri, 09 Sep 2022 14:54:33 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id bs19-20020a05620a471300b006ba9b2167a2sm93151qkb.16.2022.09.09.14.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 14:54:32 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 29/36] btrfs: drop extent_changeset from set_extent_bit
Date:   Fri,  9 Sep 2022 17:53:42 -0400
Message-Id: <afae2a3040bb21f3f76208f533eaf589314e1563.1662760286.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1662760286.git.josef@toxicpanda.com>
References: <cover.1662760286.git.josef@toxicpanda.com>
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
index 7d6e0e748238..10c8f40c35f6 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -1173,11 +1173,10 @@ static int __set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
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
index ff2eae4474e5..ee0901944cbe 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2816,7 +2816,7 @@ static int btrfs_find_new_delalloc_bytes(struct btrfs_inode *inode,
 		ret = set_extent_bit(&inode->io_tree, search_start,
 				     search_start + em_len - 1,
 				     EXTENT_DELALLOC_NEW, cached_state,
-				     GFP_NOFS, NULL);
+				     GFP_NOFS);
 next:
 		search_start = extent_map_end(em);
 		free_extent_map(em);
@@ -4962,7 +4962,7 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
 
 	if (only_release_metadata)
 		set_extent_bit(&inode->io_tree, block_start, block_end,
-			       EXTENT_NORESERVE, NULL, GFP_NOFS, NULL);
+			       EXTENT_NORESERVE, NULL, GFP_NOFS);
 
 out_unlock:
 	if (ret) {
-- 
2.26.3

