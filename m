Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3703743E3A
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Jun 2023 17:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232912AbjF3PEJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Jun 2023 11:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232902AbjF3PEE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Jun 2023 11:04:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E3C213D
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Jun 2023 08:04:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1671E6172A
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Jun 2023 15:04:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04FADC433C9
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Jun 2023 15:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688137442;
        bh=rYDqvoxq/lC5UfrKWYxAHulQE7l952cQeINGhzYMeXo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=jQo1F0B1AlvSzh79r61z6yfNqQm8Shj6K0+WH7Fq5E2+F0LvtraSR5aqHlz7WN4Dn
         3ajpl/pMf4eUpGuqYgvLo65LhUuYWIft+9VyNKEteGnd+qA+XjVNeNyIXngeTP29P9
         V/Dir3G2CTheOMoxp6lwF7wwh7wL9eStQsJNyzsJp2S40ofttiRzECKAOAdU2PNHVB
         yuaIM/9iWyHszy9jwUexjoxTXRuzhhBPb5Elo6AbZTS0yFN6LU8JR2VZbWdmUj5lCk
         KRamz/G4HOqL3iQUd8ty+1TlyiCuwtBQKXTEVoId5bHrTQFT/3NEX7lrIZwnuT/OpH
         CsbSqg8cocP0w==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 8/8] btrfs: move btrfs_free_excluded_extents() into block-group.c
Date:   Fri, 30 Jun 2023 16:03:51 +0100
Message-Id: <cb507b1dbff5ee7f776d98a9ea1da0d40ddeacfc.1688137156.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1688137155.git.fdmanana@suse.com>
References: <cover.1688137155.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The function btrfs_free_excluded_extents() is only used by block-group.c,
so move it into block-group.c and make it static. Also removed unnecessary
variables that are used only once.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-group.c |  6 ++++++
 fs/btrfs/extent-tree.c | 12 ------------
 fs/btrfs/extent-tree.h |  1 -
 3 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 7485660a1529..796e4be167a0 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -823,6 +823,12 @@ static int load_extent_tree_free(struct btrfs_caching_control *caching_ctl)
 	return ret;
 }
 
+static inline void btrfs_free_excluded_extents(const struct btrfs_block_group *bg)
+{
+	clear_extent_bits(&bg->fs_info->excluded_extents, bg->start,
+			  bg->start + bg->length - 1, EXTENT_UPTODATE);
+}
+
 static noinline void caching_thread(struct btrfs_work *work)
 {
 	struct btrfs_block_group *block_group;
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 701fa08cffb6..b0fcc2a042ad 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -69,18 +69,6 @@ static int block_group_bits(struct btrfs_block_group *cache, u64 bits)
 	return (cache->flags & bits) == bits;
 }
 
-void btrfs_free_excluded_extents(struct btrfs_block_group *cache)
-{
-	struct btrfs_fs_info *fs_info = cache->fs_info;
-	u64 start, end;
-
-	start = cache->start;
-	end = start + cache->length - 1;
-
-	clear_extent_bits(&fs_info->excluded_extents, start, end,
-			  EXTENT_UPTODATE);
-}
-
 /* simple helper to search for an existing data extent at a given offset */
 int btrfs_lookup_data_extent(struct btrfs_fs_info *fs_info, u64 start, u64 len)
 {
diff --git a/fs/btrfs/extent-tree.h b/fs/btrfs/extent-tree.h
index 3b2f265f4653..b9e148adcd28 100644
--- a/fs/btrfs/extent-tree.h
+++ b/fs/btrfs/extent-tree.h
@@ -96,7 +96,6 @@ int btrfs_get_extent_inline_ref_type(const struct extent_buffer *eb,
 				     enum btrfs_inline_ref_type is_data);
 u64 hash_extent_data_ref(u64 root_objectid, u64 owner, u64 offset);
 
-void btrfs_free_excluded_extents(struct btrfs_block_group *cache);
 int btrfs_run_delayed_refs(struct btrfs_trans_handle *trans, unsigned long count);
 void btrfs_cleanup_ref_head_accounting(struct btrfs_fs_info *fs_info,
 				  struct btrfs_delayed_ref_root *delayed_refs,
-- 
2.34.1

