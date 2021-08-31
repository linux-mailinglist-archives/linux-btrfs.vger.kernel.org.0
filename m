Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4913FC9C4
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Aug 2021 16:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237918AbhHaObr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Aug 2021 10:31:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:58398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237632AbhHaObp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Aug 2021 10:31:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A64E961059
        for <linux-btrfs@vger.kernel.org>; Tue, 31 Aug 2021 14:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630420250;
        bh=dbdnbw3WXX9MMObUGdj2wJmI7Al2Y2QJqYtxoLRWHI8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=puhm597qrGFe8syOJADXSJOC3E7Jl9YJc9sEuHjM/mCqAbAopPQjTSjYbGm4wCjF4
         DToi1d8YNef/xnGB00VFceNWTSB1+d/yhkcXc2bS0cPMkMaJpPPDzNxOWBO8iiji0v
         qrpYpjmv4Q9zV7D8truHJZ7X+xM5TR/WqlPASmsgJeyNo39MQzDHt8snl7yUNKXPcd
         BSs8XDE/Cb14aUpLeUqVh+PL1Q6e/S1CPLtZWJruo5TShg+XcWJIjgA6pSPYVnDRrq
         8yLii59wXUsijstdBW6Eh26z4DMKGG+hE9jpot3Ll+/jTOuUaiEFbpu0yIo6JdfCYb
         o0DRVifxvOTeg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 08/10] btrfs: avoid search for logged i_size when logging inode if possible
Date:   Tue, 31 Aug 2021 15:30:38 +0100
Message-Id: <0be2c59c9010242e2b6a86d4ecf430355d98bb4e.1630419897.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1630419897.git.fdmanana@suse.com>
References: <cover.1630419897.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

If we are logging that an inode exists and the inode was not logged
before, we can avoid searching in the log tree for the inode item since we
know it does not exists. That wastes time and adds more lock contention on
the extent buffers of the log tree when there are other tasks that are
logging other inodes.

This patch is part of a patch set comprised of the following patches:

  btrfs: check if a log tree exists at inode_logged()
  btrfs: remove no longer needed checks for NULL log context
  btrfs: do not log new dentries when logging that a new name exists
  btrfs: always update the logged transaction when logging new names
  btrfs: avoid expensive search when dropping inode items from log
  btrfs: add helper to truncate inode items when logging inode
  btrfs: avoid expensive search when truncating inode items from the log
  btrfs: avoid search for logged i_size when logging inode if possible
  btrfs: avoid attempt to drop extents when logging inode for the first time
  btrfs: do not commit delayed inode when logging a file in full sync mode

This is patch 8/10 and test results are listed in the change log of the
last patch in the set.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index e07f0ac1627a..206268aa42a4 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -5442,7 +5442,7 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 			max_key_type = BTRFS_XATTR_ITEM_KEY;
 		ret = drop_inode_items(trans, log, path, inode, max_key_type);
 	} else {
-		if (inode_only == LOG_INODE_EXISTS) {
+		if (inode_only == LOG_INODE_EXISTS && inode_logged(trans, inode)) {
 			/*
 			 * Make sure the new inode item we write to the log has
 			 * the same isize as the current one (if it exists).
-- 
2.28.0

