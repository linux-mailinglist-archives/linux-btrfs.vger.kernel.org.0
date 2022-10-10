Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A26DE5F9CAF
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Oct 2022 12:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbiJJKW7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Oct 2022 06:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbiJJKWp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Oct 2022 06:22:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D7C6B15D
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Oct 2022 03:22:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8668DB80E7B
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Oct 2022 10:22:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5325C433C1
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Oct 2022 10:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665397355;
        bh=7liV9PxLlVyzzPNBdy1UwWJdAfEaPqVXTawQCVGYsbw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=HdHfHwlJ7UeNdzd+wkmpMKdmay5GgmEJm55R5S4zs9UiynIYWtIl0uZUhIZIi05o1
         oTYkPDE9FlekoDv6JjARsSgCq/3EI13/iMA4pvpcT4Gm/ONqd2HmnhKXmN3H5tMBLp
         aH3DwLJPBPz4fabzbfkQURcqNNznT6nDCUO+WdoTvIKKcwO6AMyBnXGJCXQd2VuFuJ
         qPmJBf6SYqREREygawFErqZAcMSIRws7nmykvZ3hFuvqOOkicl3sFDZdreRwoE5qnK
         fTpo+EOOFEiXDl/rGvmsjKQOeS2Gbi4gUTo9PqrQqYNquF/bANtQ2giP7QwOFKl7xC
         kwFcwLoEM9G7A==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 13/18] btrfs: remove roots ulist when checking data extent sharedness
Date:   Mon, 10 Oct 2022 11:22:15 +0100
Message-Id: <3c22f241927dd971854881fb5827197ee544f88c.1665396437.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1665396437.git.fdmanana@suse.com>
References: <cover.1665396437.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Currently btrfs_is_data_extent_shared() is passing a ulist for the roots
argument of find_parent_nodes(), however it does not use that ulist for
anything and for this context that list always ends up with at most one
element.

Since find_parent_nodes() is able to deal with a NULL ulist for its roots
argument, make btrfs_is_data_extent_shared() pass it NULL and avoid the
burden of allocating memory for the unnused roots ulist, initializing it,
releasing it and allocating one struct ulist_node for it during the call
to find_parent_nodes().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/backref.c | 6 +-----
 fs/btrfs/backref.h | 1 -
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index e71e2f208cc5..c2ec132c2a9c 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -1637,7 +1637,6 @@ struct btrfs_backref_share_check_ctx *btrfs_alloc_backref_share_check_ctx(void)
 		return NULL;
 
 	ulist_init(&ctx->refs);
-	ulist_init(&ctx->roots);
 
 	return ctx;
 }
@@ -1648,7 +1647,6 @@ void btrfs_free_backref_share_ctx(struct btrfs_backref_share_check_ctx *ctx)
 		return;
 
 	ulist_release(&ctx->refs);
-	ulist_release(&ctx->roots);
 	kfree(ctx);
 }
 
@@ -1690,7 +1688,6 @@ int btrfs_is_data_extent_shared(struct btrfs_inode *inode, u64 bytenr,
 	};
 	int level;
 
-	ulist_init(&ctx->roots);
 	ulist_init(&ctx->refs);
 
 	trans = btrfs_join_transaction_nostart(root);
@@ -1714,7 +1711,7 @@ int btrfs_is_data_extent_shared(struct btrfs_inode *inode, u64 bytenr,
 		bool cached;
 
 		ret = find_parent_nodes(trans, fs_info, bytenr, elem.seq, &ctx->refs,
-					&ctx->roots, NULL, &shared, false);
+					NULL, NULL, &shared, false);
 		if (ret == BACKREF_FOUND_SHARED) {
 			/* this is the only condition under which we return 1 */
 			ret = 1;
@@ -1781,7 +1778,6 @@ int btrfs_is_data_extent_shared(struct btrfs_inode *inode, u64 bytenr,
 		up_read(&fs_info->commit_root_sem);
 	}
 out:
-	ulist_release(&ctx->roots);
 	ulist_release(&ctx->refs);
 	return ret;
 }
diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index 8da0ba6b94a4..5f468f0defda 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -26,7 +26,6 @@ struct btrfs_backref_shared_cache_entry {
 struct btrfs_backref_share_check_ctx {
 	/* Ulists used during backref walking. */
 	struct ulist refs;
-	struct ulist roots;
 	/*
 	 * A path from a root to a leaf that has a file extent item pointing to
 	 * a given data extent should never exceed the maximum b+tree height.
-- 
2.35.1

