Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 030F64DA5F
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jun 2019 21:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfFTTim (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jun 2019 15:38:42 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:44634 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbfFTTil (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jun 2019 15:38:41 -0400
Received: by mail-yw1-f67.google.com with SMTP id l79so1659734ywe.11
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jun 2019 12:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=PYgEqAHVO1Pln5bSjMFoVQWXIjH/pX5KgXisdH1nKOw=;
        b=e3dSRunEku7z7yrplvwfuCwITh1VNjrwWJpFg0ng73XR0BQO39Vc079fcntIHVYd8j
         L5n7rDz3111e5pw+DklrgUTkfwGahHu1UMkbqAMmxnuatnxcQcdNjw9oEAXzrBW8C5a3
         IHFdwWQbxY4g6R6KaMvKR2GKG3XqK9gIVu0FX+lhmUmtM6BGKlZ2tzuw3DCbZLsvTIa1
         u89gUEUERJrXiqwoJOYZPHtphesYWmaQVnvyHDvIxnkgPes2iBLTZSN9UWnxLV3fagFg
         lp/fgqr7MTva2jEwSQI+afA5FAQFknO5sWbfZJIW483Oufh5Hl3B2qhwyAbj/elakGfV
         RJFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=PYgEqAHVO1Pln5bSjMFoVQWXIjH/pX5KgXisdH1nKOw=;
        b=Jj4N5aWE0KjjKMdE3TaT+/fD4Z2dM3iFSHk1qEWiTh92XgWz4e82kj/GHRFEr0FoLI
         TLJKieyZM4dKMqnUU5Hy8R2K8Wx6XaRILUgd0MnRYlZOk41/0z+/dQVgXFyjvfvtLktl
         KQUcABrgaLZf0nqGsvGOsEsJGUq5WF97/KHC76J7Rre2+Xghm6VY5oV1+1H9iWGWCdWz
         +ZEpAJpa30CipIsmGG+mzUu6m4TKvshnBWd4v4bDIMHSBrKZswhHOS0viD4TvuUeLIWN
         L1PPLCYPerWEDas5xcYh2x1W9hE52/gYgt2ozRAVGnRp9JgPhos3bHsyjc5Xb00YzAkp
         mVhw==
X-Gm-Message-State: APjAAAWzdseS2Tr/8K67Wxpt/QIVWwpEJSVmYl/b5P/TuaUH2U4inmbe
        tutd0Lj+7psbdPQFExflAREUY2/sdQn35w==
X-Google-Smtp-Source: APXvYqwjVbzjD/TY+MFuNi5NPiZxTU6NNTMIlrDzCKnYjomt6Wost+Y0hEuyJc4I44HRfFR+7zgyRQ==
X-Received: by 2002:a81:3bd4:: with SMTP id i203mr2920819ywa.116.1561059520533;
        Thu, 20 Jun 2019 12:38:40 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id d194sm160572ywh.5.2019.06.20.12.38.39
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Jun 2019 12:38:39 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 19/25] btrfs: export block group accounting helpers
Date:   Thu, 20 Jun 2019 15:38:01 -0400
Message-Id: <20190620193807.29311-20-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20190620193807.29311-1-josef@toxicpanda.com>
References: <20190620193807.29311-1-josef@toxicpanda.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Want to move these functions into block-group.c, so export them.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.h |  6 ++++++
 fs/btrfs/extent-tree.c | 21 ++++++++++-----------
 2 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index b093b19696aa..3b7516836849 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -196,6 +196,12 @@ void btrfs_dec_block_group_ro(struct btrfs_block_group_cache *cache);
 int btrfs_start_dirty_block_groups(struct btrfs_trans_handle *trans);
 int btrfs_write_dirty_block_groups(struct btrfs_trans_handle *trans);
 int btrfs_setup_space_cache(struct btrfs_trans_handle *trans);
+int btrfs_update_block_group(struct btrfs_trans_handle *trans,
+			     u64 bytenr, u64 num_bytes, int alloc);
+int btrfs_add_reserved_bytes(struct btrfs_block_group_cache *cache,
+			     u64 ram_bytes, u64 num_bytes, int delalloc);
+void btrfs_free_reserved_bytes(struct btrfs_block_group_cache *cache,
+			       u64 num_bytes, int delalloc);
 
 static inline int
 btrfs_block_group_cache_done(struct btrfs_block_group_cache *cache)
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index b895380e60b2..e44a6c3d7a9a 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2895,8 +2895,8 @@ int btrfs_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags,
 	return ret;
 }
 
-static int update_block_group(struct btrfs_trans_handle *trans,
-			      u64 bytenr, u64 num_bytes, int alloc)
+int btrfs_update_block_group(struct btrfs_trans_handle *trans,
+			     u64 bytenr, u64 num_bytes, int alloc)
 {
 	struct btrfs_fs_info *info = trans->fs_info;
 	struct btrfs_block_group_cache *cache = NULL;
@@ -3197,8 +3197,8 @@ btrfs_inc_block_group_reservations(struct btrfs_block_group_cache *bg)
  * reservation and the block group has become read only we cannot make the
  * reservation and return -EAGAIN, otherwise this function always succeeds.
  */
-static int btrfs_add_reserved_bytes(struct btrfs_block_group_cache *cache,
-				    u64 ram_bytes, u64 num_bytes, int delalloc)
+int btrfs_add_reserved_bytes(struct btrfs_block_group_cache *cache,
+			     u64 ram_bytes, u64 num_bytes, int delalloc)
 {
 	struct btrfs_space_info *space_info = cache->space_info;
 	int ret = 0;
@@ -3231,9 +3231,8 @@ static int btrfs_add_reserved_bytes(struct btrfs_block_group_cache *cache,
  * A and before transaction A commits you free that leaf, you call this with
  * reserve set to 0 in order to clear the reservation.
  */
-
-static void btrfs_free_reserved_bytes(struct btrfs_block_group_cache *cache,
-				      u64 num_bytes, int delalloc)
+void btrfs_free_reserved_bytes(struct btrfs_block_group_cache *cache,
+			       u64 num_bytes, int delalloc)
 {
 	struct btrfs_space_info *space_info = cache->space_info;
 
@@ -3706,7 +3705,7 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 			goto out;
 		}
 
-		ret = update_block_group(trans, bytenr, num_bytes, 0);
+		ret = btrfs_update_block_group(trans, bytenr, num_bytes, 0);
 		if (ret) {
 			btrfs_abort_transaction(trans, ret);
 			goto out;
@@ -4765,7 +4764,7 @@ static int alloc_reserved_file_extent(struct btrfs_trans_handle *trans,
 	if (ret)
 		return ret;
 
-	ret = update_block_group(trans, ins->objectid, ins->offset, 1);
+	ret = btrfs_update_block_group(trans, ins->objectid, ins->offset, 1);
 	if (ret) { /* -ENOENT, logic error */
 		btrfs_err(fs_info, "update block group failed for %llu %llu",
 			ins->objectid, ins->offset);
@@ -4855,8 +4854,8 @@ static int alloc_reserved_tree_block(struct btrfs_trans_handle *trans,
 	if (ret)
 		return ret;
 
-	ret = update_block_group(trans, extent_key.objectid,
-				 fs_info->nodesize, 1);
+	ret = btrfs_update_block_group(trans, extent_key.objectid,
+				       fs_info->nodesize, 1);
 	if (ret) { /* -ENOENT, logic error */
 		btrfs_err(fs_info, "update block group failed for %llu %llu",
 			extent_key.objectid, extent_key.offset);
-- 
2.14.3

