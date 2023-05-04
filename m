Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB4746F6975
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 May 2023 13:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjEDLEp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 May 2023 07:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjEDLEg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 May 2023 07:04:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701E2212B
        for <linux-btrfs@vger.kernel.org>; Thu,  4 May 2023 04:04:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C3016176C
        for <linux-btrfs@vger.kernel.org>; Thu,  4 May 2023 11:04:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3F6AC433D2
        for <linux-btrfs@vger.kernel.org>; Thu,  4 May 2023 11:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683198273;
        bh=8GYL/l6+msrX/iONuyy4y/X13M4oVcbKSlSZPhhWmL8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=hA88ebBIA8UYhTTaFbC4xLXEknlXYFvesISajh8zv478TzCHjDce7XiLFoxSmh5G6
         TmUtNpf1czRiSWn9nLKULVUykf7aFP0IzaUOq2fbS8q+yFJoifuTWj+xF/myZhk0ES
         s/DMx6nk/7QOqCUqKt6TV04b+AL8Pd8tcx/4ffjHcOml4TBdkCAzf3XBVfS+TPbAge
         Tby3PWXoMuNVUrV6e9iY6nkur3zf7jAKplD4LgbHnS+qwP940WqGMxzV3eC8tMKnv/
         YEa17wwNd9IlfIblMqE8gQkU/cwJOJmRA/br4+vmysVaaDd/EQvcMnqW6V94Ty0BGk
         JxoN0G/UTKfNw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/9] btrfs: avoid extra memory allocation when copying free space cache
Date:   Thu,  4 May 2023 12:04:19 +0100
Message-Id: <f4cb3735fa8b97e14f71ac89cce3c938f84023f6.1683196407.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1683196407.git.fdmanana@suse.com>
References: <cover.1683196407.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

At copy_free_space_cache(), we add a new entry to the block group's ctl
before we free the entry from the temporary ctl. Adding a new entry
requires the allocation of a new struct btrfs_free_space, so we can
avoid a temporary extra allocation by freeing the entry from the
temporary ctl before we add a new entry to the main ctl, which possibly
also reduces the chances for a memory allocation failure in case of very
high memory pressure. So just do that.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/free-space-cache.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index cf98a3c05480..ec53119d4cfb 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -923,10 +923,12 @@ static int copy_free_space_cache(struct btrfs_block_group *block_group,
 	while (!ret && (n = rb_first(&ctl->free_space_offset)) != NULL) {
 		info = rb_entry(n, struct btrfs_free_space, offset_index);
 		if (!info->bitmap) {
+			const u64 offset = info->offset;
+			const u64 bytes = info->bytes;
+
 			unlink_free_space(ctl, info, true);
-			ret = btrfs_add_free_space(block_group, info->offset,
-						   info->bytes);
 			kmem_cache_free(btrfs_free_space_cachep, info);
+			ret = btrfs_add_free_space(block_group, offset, bytes);
 		} else {
 			u64 offset = info->offset;
 			u64 bytes = ctl->unit;
-- 
2.35.1

