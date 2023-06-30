Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6233743E37
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Jun 2023 17:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232907AbjF3PEH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Jun 2023 11:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232917AbjF3PED (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Jun 2023 11:04:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431F830C5
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Jun 2023 08:04:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24D3E6174C
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Jun 2023 15:04:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FC4CC433C0
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Jun 2023 15:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688137441;
        bh=hFIne4jrtLUSHgUbIFyb+z7jQjoS6wygOArzYFqg5TY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=fhZqrzAgreQrMymGbpr5EosjJvrjWPnQiIdYhcg3BAMcjgsP6yCmmuzZy/qW9hsE3
         ZjwfP/A9BB02wAFFdz9b7ym3Q4AizmsnPpCmyA3etbTimy7TTcjwUUD1bVVvyiXCCu
         BeIYLJyyF3K9vP79ufm0WJQ9DPuH3F+6Mx6hN6pD6+qq4pZDvWMrOxUhMgh5/wlP4M
         rUMafGv6IWyVGnUHovnx2R3VNbxpDX4CpLJ2VetS2o9yBBv3SqfCRLaDf6MitsaZeQ
         +nAh5fYzT7tA6kMYplrjVIJ9X2luT7IOFPdwpLBZStNg19+ATXatjLzK1UJEpCVMGL
         8pGbjOGEOf2kw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 7/8] btrfs: open code trivial btrfs_add_excluded_extent()
Date:   Fri, 30 Jun 2023 16:03:50 +0100
Message-Id: <9e6a6a43c05367be9df0f251cfbdccf656d2ca7f.1688137156.git.fdmanana@suse.com>
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

The code for btrfs_add_excluded_extent() is trivial, it's just a
set_extent_bit() call. However it's defined in extent-tree.c but it is
only used (twice) in block-group.c. So open code it in block-group.c,
reducing the need to export a trivial function.

Also since the only caller btrfs_add_excluded_extent() is prepared to
deal with errors, stop ignoring errors from the set_extent_bit() call.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-group.c | 10 ++++++----
 fs/btrfs/extent-tree.c |  9 ---------
 fs/btrfs/extent-tree.h |  2 --
 3 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index ba4e66de3372..7485660a1529 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2091,8 +2091,9 @@ static int exclude_super_stripes(struct btrfs_block_group *cache)
 	if (cache->start < BTRFS_SUPER_INFO_OFFSET) {
 		stripe_len = BTRFS_SUPER_INFO_OFFSET - cache->start;
 		cache->bytes_super += stripe_len;
-		ret = btrfs_add_excluded_extent(fs_info, cache->start,
-						stripe_len);
+		ret = set_extent_bit(&fs_info->excluded_extents, cache->start,
+				     cache->start + stripe_len - 1,
+				     EXTENT_UPTODATE, NULL);
 		if (ret)
 			return ret;
 	}
@@ -2117,8 +2118,9 @@ static int exclude_super_stripes(struct btrfs_block_group *cache)
 				cache->start + cache->length - logical[nr]);
 
 			cache->bytes_super += len;
-			ret = btrfs_add_excluded_extent(fs_info, logical[nr],
-							len);
+			ret = set_extent_bit(&fs_info->excluded_extents, logical[nr],
+					     logical[nr] + len - 1,
+					     EXTENT_UPTODATE, NULL);
 			if (ret) {
 				kfree(logical);
 				return ret;
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 4c140636b456..701fa08cffb6 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -69,15 +69,6 @@ static int block_group_bits(struct btrfs_block_group *cache, u64 bits)
 	return (cache->flags & bits) == bits;
 }
 
-int btrfs_add_excluded_extent(struct btrfs_fs_info *fs_info,
-			      u64 start, u64 num_bytes)
-{
-	u64 end = start + num_bytes - 1;
-	set_extent_bit(&fs_info->excluded_extents, start, end,
-		       EXTENT_UPTODATE, NULL);
-	return 0;
-}
-
 void btrfs_free_excluded_extents(struct btrfs_block_group *cache)
 {
 	struct btrfs_fs_info *fs_info = cache->fs_info;
diff --git a/fs/btrfs/extent-tree.h b/fs/btrfs/extent-tree.h
index 429d5c570061..3b2f265f4653 100644
--- a/fs/btrfs/extent-tree.h
+++ b/fs/btrfs/extent-tree.h
@@ -96,8 +96,6 @@ int btrfs_get_extent_inline_ref_type(const struct extent_buffer *eb,
 				     enum btrfs_inline_ref_type is_data);
 u64 hash_extent_data_ref(u64 root_objectid, u64 owner, u64 offset);
 
-int btrfs_add_excluded_extent(struct btrfs_fs_info *fs_info,
-			      u64 start, u64 num_bytes);
 void btrfs_free_excluded_extents(struct btrfs_block_group *cache);
 int btrfs_run_delayed_refs(struct btrfs_trans_handle *trans, unsigned long count);
 void btrfs_cleanup_ref_head_accounting(struct btrfs_fs_info *fs_info,
-- 
2.34.1

