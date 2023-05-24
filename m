Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7FE8710188
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 May 2023 01:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236573AbjEXXKg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 May 2023 19:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjEXXKf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 May 2023 19:10:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2AE99
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 16:10:33 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 8F9CC1FE36;
        Wed, 24 May 2023 23:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1684969832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BsTB7pRJ6EaLV3yLCBu65WRsOJxmC2JBrOMo+KiAEO4=;
        b=mvSNu0Z3iQh3XxUYldlqLxqMJpfT+DwzgfCEjaIpX3uU4r6P+NRFC1L3ouRS5s820x5fV/
        RSb3VDrun7s7SCNhswTYAu18vjVftnX6/QYd3+NDL+aP8bR0bjEem3TsF7mrRj3rzUqsc8
        Mu6tWn0Mkc3KXVs5h20o0yYIddATUag=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 7FFC02C141;
        Wed, 24 May 2023 23:10:32 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2B5E0DA85B; Thu, 25 May 2023 01:04:26 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 3/9] btrfs: open code set_extent_new
Date:   Thu, 25 May 2023 01:04:26 +0200
Message-Id: <34f3abd71b4da58527bfc16268a4d915f98e5305.1684967923.git.dsterba@suse.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1684967923.git.dsterba@suse.com>
References: <cover.1684967923.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The helper is used only once.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent-io-tree.h | 6 ------
 fs/btrfs/extent-tree.c    | 5 +++--
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index e5289d67b6b7..293e49377104 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -193,12 +193,6 @@ int convert_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 		       u32 bits, u32 clear_bits,
 		       struct extent_state **cached_state);
 
-static inline int set_extent_new(struct extent_io_tree *tree, u64 start,
-		u64 end)
-{
-	return set_extent_bit(tree, start, end, EXTENT_NEW, NULL, GFP_NOFS);
-}
-
 int find_first_extent_bit(struct extent_io_tree *tree, u64 start,
 			  u64 *start_ret, u64 *end_ret, u32 bits,
 			  struct extent_state **cached_state);
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 5de5b577e7fd..5c7c72042193 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4832,8 +4832,9 @@ btrfs_init_new_buffer(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 			set_extent_dirty(&root->dirty_log_pages, buf->start,
 					buf->start + buf->len - 1, GFP_NOFS);
 		else
-			set_extent_new(&root->dirty_log_pages, buf->start,
-					buf->start + buf->len - 1);
+			set_extent_bit(&root->dirty_log_pages, buf->start,
+				       buf->start + buf->len - 1,
+				       EXTENT_NEW, NULL, GFP_NOFS);
 	} else {
 		buf->log_index = -1;
 		set_extent_dirty(&trans->transaction->dirty_pages, buf->start,
-- 
2.40.0

