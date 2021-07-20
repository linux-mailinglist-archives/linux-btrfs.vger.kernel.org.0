Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC5F43CFDBB
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jul 2021 17:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241991AbhGTO6u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Jul 2021 10:58:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:60294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239993AbhGTOXI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Jul 2021 10:23:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 15EEF610FB
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jul 2021 15:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626793426;
        bh=9N4WjH7sXRNmBL9Ta+r4pzi3PyRLH07eyPU17lh4Uhw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=eeSjbdvVJyndcORzrdGB4EbD0DGqIi1JSlH2WNM9GbDN3yPw4fU5bCpLSPn+mPldo
         CklDyum0UBo19DU/EFRAIRgHrkxEPfDklB3+5hHzSdVR6PPr2f7oSv7BXXK8X5DZjQ
         QcDNISL4XeaQacjilURB5WnXcNvq2RmrQYNZvKMSAYdtSJeF67zfrDSR0M26Jjunq1
         ER60zUiRytj6mNe0BGSPrkCrGo6oJ1TkTJXpsqOuyraI9HtIFTagGKYx5VxUiVqjw2
         C5dRZMfHHI+hdQkrqQkmqWA/jGkrT3Epum+1/dQU3Vjtl8C8g5IitQe5+0kKWq47RO
         UMVoE/QPOz9+Q==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/4] btrfs: remove racy and unnecessary inode transaction update when using no-holes
Date:   Tue, 20 Jul 2021 16:03:40 +0100
Message-Id: <e38de96eb87e6de46d13e9dc23e2d29151b8a002.1626791500.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1626791500.git.fdmanana@suse.com>
References: <cover.1626791500.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When using the NO_HOLES feature and expanding the size of an inode, we
update the inode's last_trans, last_sub_trans and last_log_commit fields
at maybe_insert_hole() so that a fsync does know that the inode needs to
be logged (by making sure that btrfs_inode_in_log() returns false). This
happens for expanding truncate operations, buffered writes, direct IO
writes and when cloning extents to an offset greater than the inode's
i_size.

However the way we do it is racy, because in between setting the inode's
last_sub_trans and last_log_commit fields, the log transaction ID that was
assigned to last_sub_trans might be committed before we read the root's
last_log_commit and assign that value to last_log_commit. If that happens
it would make a future call to btrfs_inode_in_log() return true. This is
a race that should be extremely unlikely to be hit in practice, and it is
the same that was described by commit bc0939fcfab0d7 ("btrfs: fix race
between marking inode needs to be logged and log syncing").

The fix would simply be to set last_log_commit to the value we assigned
to last_sub_trans minus 1, like it was done in that commit. However
updating these two fields plus the last_trans field is pointless here
because all the callers of btrfs_cont_expand() (which is the only
caller of maybe_insert_hole()) always call btrfs_set_inode_last_trans()
or btrfs_update_inode() after calling btrfs_cont_expand(). Calling either
btrfs_set_inode_last_trans() or btrfs_update_inode() guarantees that the
next fsync will log the inode, as it makes btrfs_inode_in_log() return
false.

So just remove the code that explicitly sets the inode's last_trans,
last_sub_trans and last_log_commit fields.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index e6eb20987351..5798c6191908 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4999,15 +4999,13 @@ static int maybe_insert_hole(struct btrfs_root *root, struct btrfs_inode *inode,
 	int ret;
 
 	/*
-	 * Still need to make sure the inode looks like it's been updated so
-	 * that any holes get logged if we fsync.
+	 * If NO_HOLES is enabled, we don't need to do anything.
+	 * Later, up in the call chain, either btrfs_set_inode_last_sub_trans()
+	 * or btrfs_update_inode() will be called, which guarantee that the next
+	 * fsync will know this inode was changed and needs to be logged.
 	 */
-	if (btrfs_fs_incompat(fs_info, NO_HOLES)) {
-		inode->last_trans = fs_info->generation;
-		inode->last_sub_trans = root->log_transid;
-		inode->last_log_commit = root->last_log_commit;
+	if (btrfs_fs_incompat(fs_info, NO_HOLES))
 		return 0;
-	}
 
 	/*
 	 * 1 - for the one we're dropping
-- 
2.30.2

