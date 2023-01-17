Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5E666DC3E
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Jan 2023 12:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236685AbjAQLWi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Jan 2023 06:22:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236181AbjAQLWH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Jan 2023 06:22:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CDB30EA9
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Jan 2023 03:21:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B928D61180
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Jan 2023 11:21:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B07EEC433D2
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Jan 2023 11:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673954504;
        bh=MLnbmnJwF3ABtqrJbAS2/uzw305+Bvv9whn1o8v3Oe0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=n/hauMrri07AuyiW/od2jGhFRm9d/nigqJgAzZV0Df1MtoiNJy3vNIL7BT3Gekp/d
         WUJR1HQAtZ5sInatZy39VyVCgbIbme6htTQBRl9pXt95Alhuubfix6f8iOrH+6VAgV
         XF4nBulQQTbr91wHQXstXhzxFZ6+Jh9/CjFyVVdVm7M7eNvvLpDfgz4ZHNZ0KAyQJ2
         Khep1ojGHiwSrE0qPrqfKJmDhslREBKcvJkfy2IViAarT1etWCdxBIws5kkRKmlL65
         4XqAVDC5qtFkAOC1zmlBEzPOfqzYZuWZ0HFaaWW2SviGf5s1Z8X/YJnsMu5D6y02mL
         dDhphVyjYC46Q==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: assert commit root semaphore is held when accessing backref cache
Date:   Tue, 17 Jan 2023 11:21:38 +0000
Message-Id: <c34488ec6ff0a402978fc1ceb0f8bf923835deb1.1673954069.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1673954069.git.fdmanana@suse.com>
References: <cover.1673954069.git.fdmanana@suse.com>
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

During fiemap, when accessing the cache that stores the sharedness of an
extent, we need to either be holding a transaction handle or the commit
root semaphore. I left comments about this in the comment that precedes
store_backref_shared_cache() and lookup_backref_shared_cache(), but have
actually not enforced it through assertions. So assert that the commit
root semaphore is held if we are not holding a transaction handle.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/backref.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 46851511b661..f846fec08c86 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -1252,8 +1252,12 @@ static bool lookup_backref_shared_cache(struct btrfs_backref_share_check_ctx *ct
 					struct btrfs_root *root,
 					u64 bytenr, int level, bool *is_shared)
 {
+	const struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_backref_shared_cache_entry *entry;
 
+	if (!current->journal_info)
+		lockdep_assert_held(&fs_info->commit_root_sem);
+
 	if (!ctx->use_path_cache)
 		return false;
 
@@ -1288,7 +1292,7 @@ static bool lookup_backref_shared_cache(struct btrfs_backref_share_check_ctx *ct
 	 * could be a snapshot sharing this extent buffer.
 	 */
 	if (entry->is_shared &&
-	    entry->gen != btrfs_get_last_root_drop_gen(root->fs_info))
+	    entry->gen != btrfs_get_last_root_drop_gen(fs_info))
 		return false;
 
 	*is_shared = entry->is_shared;
@@ -1318,9 +1322,13 @@ static void store_backref_shared_cache(struct btrfs_backref_share_check_ctx *ctx
 				       struct btrfs_root *root,
 				       u64 bytenr, int level, bool is_shared)
 {
+	const struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_backref_shared_cache_entry *entry;
 	u64 gen;
 
+	if (!current->journal_info)
+		lockdep_assert_held(&fs_info->commit_root_sem);
+
 	if (!ctx->use_path_cache)
 		return;
 
@@ -1336,7 +1344,7 @@ static void store_backref_shared_cache(struct btrfs_backref_share_check_ctx *ctx
 	ASSERT(level >= 0);
 
 	if (is_shared)
-		gen = btrfs_get_last_root_drop_gen(root->fs_info);
+		gen = btrfs_get_last_root_drop_gen(fs_info);
 	else
 		gen = btrfs_root_last_snapshot(&root->root_item);
 
-- 
2.35.1

