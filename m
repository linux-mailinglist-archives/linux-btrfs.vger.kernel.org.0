Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB42710187
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 May 2023 01:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233308AbjEXXKb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 May 2023 19:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjEXXKa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 May 2023 19:10:30 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8874E99
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 16:10:29 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3C53721D38;
        Wed, 24 May 2023 23:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1684969828; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jJO5efxw+hE/fqVEXKHLqlGkYr1t3nFCEMIpDDxwOKs=;
        b=NxDsJrlntykwR9PweUjRbLbalKesp2MlhyIfkLQcPyh5ReZ6bnY2qVjVwuIec5wHan9JFc
        w58PbyrIMQ9HTGTHHImf63ALfUNVDMeScuXhuUVut0y3kXJMcs4i5eXhj3xUQMFAWpcfTd
        HhenM8Ggw/kXalstZVtqX4sSd79hXaE=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 2E4DC2C141;
        Wed, 24 May 2023 23:10:28 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CE243DA85B; Thu, 25 May 2023 01:04:21 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 1/9] btrfs: open code set_extent_defrag
Date:   Thu, 25 May 2023 01:04:21 +0200
Message-Id: <14705ec263c747043811d070f32c77a6ab838336.1684967923.git.dsterba@suse.com>
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

The helper is used only once.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/defrag.c         | 4 +++-
 fs/btrfs/extent-io-tree.h | 8 --------
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index 8065341d831a..4e7a1e0a0441 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -1040,7 +1040,9 @@ static int defrag_one_locked_target(struct btrfs_inode *inode,
 	clear_extent_bit(&inode->io_tree, start, start + len - 1,
 			 EXTENT_DELALLOC | EXTENT_DO_ACCOUNTING |
 			 EXTENT_DEFRAG, cached_state);
-	set_extent_defrag(&inode->io_tree, start, start + len - 1, cached_state);
+	set_extent_bit(&inode->io_tree, start, start + len - 1,
+		       EXTENT_DELALLOC | EXTENT_DEFRAG,
+		       cached_state, GFP_NOFS);
 
 	/* Update the page status */
 	for (i = start_index - first_index; i <= last_index - first_index; i++) {
diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index 21766e49ec02..ea344e5ca24f 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -202,14 +202,6 @@ static inline int set_extent_delalloc(struct extent_io_tree *tree, u64 start,
 			      cached_state, GFP_NOFS);
 }
 
-static inline int set_extent_defrag(struct extent_io_tree *tree, u64 start,
-		u64 end, struct extent_state **cached_state)
-{
-	return set_extent_bit(tree, start, end,
-			      EXTENT_DELALLOC | EXTENT_DEFRAG,
-			      cached_state, GFP_NOFS);
-}
-
 static inline int set_extent_new(struct extent_io_tree *tree, u64 start,
 		u64 end)
 {
-- 
2.40.0

