Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 182AA34A7E7
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Mar 2021 14:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbhCZNPN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Mar 2021 09:15:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:33678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230196AbhCZNOp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Mar 2021 09:14:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7834E619FB
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Mar 2021 13:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616764484;
        bh=gXkWABGyjdr4u4xNHqVfU2p46wI1+XvDH1GINPahrws=;
        h=From:To:Subject:Date:From;
        b=VBsrUhdHthGaP/Y5WzNTnhTNLAfPfoAaMnb9mVfWJSSwAe32e/1lgwqYi5M5WoVzc
         NHdBSA5OarhFuA7h0iIgiY7wN0+/RuHhMSjR/qmQUPgAh4eI4dKUifEbSd3SQtE3FT
         NkzoC/9O/2yXAfhGyMzYbw7R55pgC9GT7tN7VDIaHeW0Pm3yv3idpbwalGVEJjSyhE
         DcZ6mwCNTYvt2i1E7e5Vk1yGpWP5yX8jRo7HTjQuG+foJHybIElzkeBJm/gteJuQOh
         vaXN0mXaGDRgT74rR+Ix+bsEIZWdr8WwkCbK7ETB9hE2T18dFPnZkI1JMfY2p79bOO
         FC6iyDsmyq3IQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: update outdated comment at btrfs_replace_file_extents()
Date:   Fri, 26 Mar 2021 13:14:41 +0000
Message-Id: <32f9e43d999fcfaa2927513d7563790a5292fd7b.1616764397.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

There is a comment at btrfs_replace_file_extents() that mentions that we
set the full sync flag on an inode when cloning into a file with a size
greater than or equals to 16MiB, through try_release_extent_mapping() when
we truncate the page cache after replacing file extents during a clone
operation.

That is not true anymore since commit 5e548b32018d96 ("btrfs: do not set
the full sync flag on the inode during page release"), so update the
comment to remove that part and rephrase it slightly to make it more
clear why the full sync flag is set at btrfs_replace_file_extents().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/file.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index c666d20370c1..42634658815f 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2765,10 +2765,8 @@ int btrfs_replace_file_extents(struct btrfs_inode *inode,
 	/*
 	 * If we were cloning, force the next fsync to be a full one since we
 	 * we replaced (or just dropped in the case of cloning holes when
-	 * NO_HOLES is enabled) extents and extent maps.
-	 * This is for the sake of simplicity, and cloning into files larger
-	 * than 16Mb would force the full fsync any way (when
-	 * try_release_extent_mapping() is invoked during page cache truncation.
+	 * NO_HOLES is enabled) file extent items and did not setup new extent
+	 * maps for the replacement extents (or holes).
 	 */
 	if (extent_info && !extent_info->is_new_extent)
 		set_bit(BTRFS_INODE_NEEDS_FULL_SYNC, &inode->runtime_flags);
-- 
2.28.0

