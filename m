Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D52453375CA
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Mar 2021 15:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233934AbhCKOcB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Mar 2021 09:32:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:57024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233925AbhCKObb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Mar 2021 09:31:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9B9F264FE8;
        Thu, 11 Mar 2021 14:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615473091;
        bh=xU6JgFTKD2WIWP3hEJz56Cszs6XlV1Zs6kx8WnSyN20=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hG7kGRqDR7HYQSkH16tpsXAouKD5jZXWD1y6ojcjlxfTRY+l2C7v6+HtjJsGt9Woi
         OGLhEg4m9WC9JcIuJeVIY5dLMUn0JeTNJJzWaUHAYlxjBOQSCDaGwE5iMy4iLg36UJ
         kNDGHHrc+3BFarRirxtd9fOieys24ZvDX9Q+ZEcNermE9oxsRHach4gx0MCRnIfx0O
         cIdt9e6SG5+ygRiYUcJb9dtJ62QUGvGg6Xp8aTl0SijHgBtrfGapR07xVBDAr5dPKo
         q/nohbsjM9kpSMP7c7ncFamhrv0zOFC9p9P5AKcACmHiGmNDGDS0uC4KBh81xKnd7i
         E4QIw+yP+IZIg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Cc:     ce3g8jdj@umail.furryterror.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 7/9] btrfs: remove unnecessary leaf check at btrfs_tree_mod_log_free_eb()
Date:   Thu, 11 Mar 2021 14:31:11 +0000
Message-Id: <c28a8b5717b2ac49382067a6f0170220cb8d022b.1615472583.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1615472583.git.fdmanana@suse.com>
References: <cover.1615472583.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

At btrfs_tree_mod_log_free_eb() we check if we are dealing with a leaf,
and if so, return immediately and do nothing. However this check can be
removed, because after it we call tree_mod_need_log(), which returns
false when given an extent buffer that corresponds to a leaf.

So just remove the leaf check and pass the extent buffer to
tree_mod_need_log().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-mod-log.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/btrfs/tree-mod-log.c b/fs/btrfs/tree-mod-log.c
index b912b82c36c9..c854cebf27f6 100644
--- a/fs/btrfs/tree-mod-log.c
+++ b/fs/btrfs/tree-mod-log.c
@@ -554,10 +554,7 @@ int btrfs_tree_mod_log_free_eb(struct extent_buffer *eb)
 	int i;
 	int ret = 0;
 
-	if (btrfs_header_level(eb) == 0)
-		return 0;
-
-	if (!tree_mod_need_log(eb->fs_info, NULL))
+	if (!tree_mod_need_log(eb->fs_info, eb))
 		return 0;
 
 	nritems = btrfs_header_nritems(eb);
-- 
2.28.0

