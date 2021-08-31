Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C50C3FC9BF
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Aug 2021 16:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237431AbhHaObm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Aug 2021 10:31:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:58308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237372AbhHaObl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Aug 2021 10:31:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AF21060FD8
        for <linux-btrfs@vger.kernel.org>; Tue, 31 Aug 2021 14:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630420246;
        bh=zhJoux6G6Uhlwb1H6cNVTg3y5KjmNCP/qyJEb9HgUDY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=vPu6w/KRMMCY8omTXa66cAW9pMorMuHvbqNs7F6xDP2bFgnr4fm0ApN/oxV9HJiXf
         WP1svry+V4u0BqDck3o1IY46pLL+o9KJktlqUwGrJdTqf156jl33oUATpfdyMg0OqD
         7+YtuFcgxkLXxMu5TTNWqbiZOVK2U/4cuLzmo9+iuB5kREHDG7ZR2iS4xwr4x495/0
         RxYmZ0FNkeCNIOmB98vY7GXWTm2MMIg7RIXEe8gRLrjJJ6qS0vYv00SO8xgzbr/nsU
         QGs25hdKU5DlslLiyvUrOh0aOQpp9u4gdsCCS3lJ1IoTD0HGSuw7CRKwYDKz0BDUvb
         kYuPIHCN+hXKQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 03/10] btrfs: do not log new dentries when logging that a new name exists
Date:   Tue, 31 Aug 2021 15:30:33 +0100
Message-Id: <337655916e1c56779148d3b4fa275139a993e004.1630419897.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1630419897.git.fdmanana@suse.com>
References: <cover.1630419897.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When logging a new name for an inode, due to a link or rename operation,
we don't need to log all new dentries of the parent directories and their
subdirectories. We only want to log the names of the inode and that any
new parent directories exist. So in this case don't trigger logging of
the new dentries, that is only need when doing an explicit fsync on a
directory or on a file which requires logging its parent directories.

This avoids unnecessary work and reduces contention on the extent buffers
of a log tree.

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

This is patch 3/10 and test results are listed in the change log of the
last patch in the set.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 7f5c586efe3c..27b0c908b10c 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -5695,6 +5695,14 @@ static int log_new_dir_dentries(struct btrfs_trans_handle *trans,
 	struct btrfs_dir_list *dir_elem;
 	int ret = 0;
 
+	/*
+	 * If we are logging a new name, as part of a link or rename operation,
+	 * don't bother logging new dentries, as we just want to log the names
+	 * of an inode and that any new parents exist.
+	 */
+	if (ctx->logging_new_name)
+		return 0;
+
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
-- 
2.28.0

