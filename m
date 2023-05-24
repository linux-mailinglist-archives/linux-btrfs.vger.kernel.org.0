Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D42710186
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 May 2023 01:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236812AbjEXXKi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 May 2023 19:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjEXXKh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 May 2023 19:10:37 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141E5A9
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 16:10:36 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C913221D38;
        Wed, 24 May 2023 23:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1684969834; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+122RPPYKlHjYOALUQ2HGl+inLpBBAV5stxesLQWasY=;
        b=okDA72i0hf3c9gDtPII7eWHFaNWW5/V5KmHb6al2fU/3/qICo2LE78JlL5I4F4a3rKBGrD
        qyGVs/b7d6a4S2GyxBRQcViVJIQyYg7BdN0VMQU0ywGsU1dS3FCm9x5vrMzxyYVlK2MMPM
        4z2OtDtjyB1ZS3KZL/QGuhm2SqNz/rg=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id BA4762C141;
        Wed, 24 May 2023 23:10:34 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5C7D1DA85B; Thu, 25 May 2023 01:04:28 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 4/9] btrfs: open code set_extent_dirty
Date:   Thu, 25 May 2023 01:04:28 +0200
Message-Id: <2d4be0b36bb199c70308f945320def249512b0d9.1684967923.git.dsterba@suse.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1684967923.git.dsterba@suse.com>
References: <cover.1684967923.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The helper is used a few times, that it's setting the DIRTY extent bit
is still clear.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/block-group.c    |  7 ++++---
 fs/btrfs/extent-io-tree.h |  6 ------
 fs/btrfs/extent-tree.c    | 15 +++++++++------
 3 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 590b03560265..ec463f8d83ec 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -3521,9 +3521,10 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
 			spin_unlock(&cache->lock);
 			spin_unlock(&space_info->lock);
 
-			set_extent_dirty(&trans->transaction->pinned_extents,
-					 bytenr, bytenr + num_bytes - 1,
-					 GFP_NOFS | __GFP_NOFAIL);
+			set_extent_bit(&trans->transaction->pinned_extents,
+				       bytenr, bytenr + num_bytes - 1,
+				       EXTENT_DIRTY, NULL,
+				       GFP_NOFS | __GFP_NOFAIL);
 		}
 
 		spin_lock(&trans->transaction->dirty_bgs_lock);
diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index 293e49377104..0fc54546a63d 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -175,12 +175,6 @@ static inline int clear_extent_uptodate(struct extent_io_tree *tree, u64 start,
 				  cached_state, GFP_NOFS, NULL);
 }
 
-static inline int set_extent_dirty(struct extent_io_tree *tree, u64 start,
-		u64 end, gfp_t mask)
-{
-	return set_extent_bit(tree, start, end, EXTENT_DIRTY, NULL, mask);
-}
-
 static inline int clear_extent_dirty(struct extent_io_tree *tree, u64 start,
 				     u64 end, struct extent_state **cached)
 {
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 5c7c72042193..47cfb694cdbf 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2507,8 +2507,9 @@ static int pin_down_extent(struct btrfs_trans_handle *trans,
 	spin_unlock(&cache->lock);
 	spin_unlock(&cache->space_info->lock);
 
-	set_extent_dirty(&trans->transaction->pinned_extents, bytenr,
-			 bytenr + num_bytes - 1, GFP_NOFS | __GFP_NOFAIL);
+	set_extent_bit(&trans->transaction->pinned_extents, bytenr,
+		       bytenr + num_bytes - 1, EXTENT_DIRTY, NULL,
+		       GFP_NOFS | __GFP_NOFAIL);
 	return 0;
 }
 
@@ -4829,16 +4830,18 @@ btrfs_init_new_buffer(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		 * EXTENT bit to differentiate dirty pages.
 		 */
 		if (buf->log_index == 0)
-			set_extent_dirty(&root->dirty_log_pages, buf->start,
-					buf->start + buf->len - 1, GFP_NOFS);
+			set_extent_bit(&root->dirty_log_pages, buf->start,
+				       buf->start + buf->len - 1,
+				       EXTENT_DIRTY, NULL, GFP_NOFS);
 		else
 			set_extent_bit(&root->dirty_log_pages, buf->start,
 				       buf->start + buf->len - 1,
 				       EXTENT_NEW, NULL, GFP_NOFS);
 	} else {
 		buf->log_index = -1;
-		set_extent_dirty(&trans->transaction->dirty_pages, buf->start,
-			 buf->start + buf->len - 1, GFP_NOFS);
+		set_extent_bit(&trans->transaction->dirty_pages, buf->start,
+			       buf->start + buf->len - 1, EXTENT_DIRTY, NULL,
+			       GFP_NOFS);
 	}
 	/* this returns a buffer locked for blocking */
 	return buf;
-- 
2.40.0

