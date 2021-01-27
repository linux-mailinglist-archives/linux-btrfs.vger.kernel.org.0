Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEE9E30589B
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jan 2021 11:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235996AbhA0KiF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Jan 2021 05:38:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:52534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235880AbhA0Kfr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Jan 2021 05:35:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CF78920771
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jan 2021 10:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611743707;
        bh=L1CIGZFWMrAsAG2iZW8rcHV6hjXKPtXEyWE6N3RdetM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=uudeliF/fdhYe2REqCbRmF0nHPqHJa+1fTTXyqk8aizlgTGyPDhOoffpxlhuhTemv
         oUpRVlqzOzHOwf4f9nOfACLi7wJqJ/dbg1jbWszctsrKLIqREQJS8FANH/6LRDR+/I
         RGfSDvLBktqd3v0xBUtELmpPuwEuTxCcnRkv/AvaaK/ASklE+ssLOo1oDtYZNYp7yE
         7Co/qR+0ZXActnVYIBJIPiP+Ex1cflNyofTIt49OU1PpPvsZ2G47uxkYmKFJpsDK2u
         BDiVw3B4LCyvqcD9rYgFyIkHTUotn6+GUZZq4qYqQ/Q1t1krAfR2CdEjq4mJyalMAU
         glQcQreA8z4BQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 4/7] btrfs: skip logging directories already logged when logging all parents
Date:   Wed, 27 Jan 2021 10:34:57 +0000
Message-Id: <d151ec9ab4938c75ba123322dc962e0f073d4218.1611742865.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1611742865.git.fdmanana@suse.com>
References: <cover.1611742865.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Some times when we fsync an inode we need to do a full log of all its
ancestors (due to unlink, link or rename operations), which can be an
expensive operation, specially if the directories are large.

However if we find an ancestor directory inode that is already logged in
the current transaction, and has no inserted/updated/deleted xattrs since
it was last logged, we can skip logging the directory again. We are safe
to skip that since we know that for logged directories, any link, unlink
or rename operations that implicate the directory will update the log as
necessary.

So use the helper need_log_dir(), introduced in a previous commit, to
detect already logged directories that can be skipped.

This patch is part of a patchset comprised of the following patches:

  btrfs: remove unnecessary directory inode item update when deleting dir entry
  btrfs: stop setting nbytes when filling inode item for logging
  btrfs: avoid logging new ancestor inodes when logging new inode
  btrfs: skip logging directories already logged when logging all parents
  btrfs: skip logging inodes already logged when logging new entries
  btrfs: remove unnecessary check_parent_dirs_for_sync()
  btrfs: make concurrent fsyncs wait less when waiting for a transaction commit

Performance results, after applying all patches, are mentioned in the
change log of the last patch.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 105cf316ee27..c0dce99c2c14 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -5826,6 +5826,11 @@ static int btrfs_log_all_parents(struct btrfs_trans_handle *trans,
 				goto out;
 			}
 
+			if (!need_log_inode(trans, BTRFS_I(dir_inode))) {
+				btrfs_add_delayed_iput(dir_inode);
+				continue;
+			}
+
 			if (ctx)
 				ctx->log_new_dentries = false;
 			ret = btrfs_log_inode(trans, root, BTRFS_I(dir_inode),
-- 
2.28.0

