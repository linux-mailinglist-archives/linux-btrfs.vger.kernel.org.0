Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5221A3058A7
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jan 2021 11:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235098AbhA0Kks (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Jan 2021 05:40:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:53076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236008AbhA0KiZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Jan 2021 05:38:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AE15920773
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jan 2021 10:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611743708;
        bh=IgAegIguo12oSqOVBxDaVBbCr4bKsxSGPcOcMxGYwBs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=fQCRVbFSmRnawGoIDkX+JjI2EblwH2scq2JlrkVGUM0jI4ZznJadLPHchsZW4Sikl
         znfB+hR9gR6xMzGVRrDLc8lFp2la3THSJfB+JdPgfYL1f7u8/uTQtiELztj3bxz2tv
         ml/e/7ysMJksbRzNl4hQOxm98IUORoH48QB0sEO2C9fXPOfizwePDxzU7y/wexHXiO
         bpmuX2qvitmBBexr6eX5FAmNQK5nok4O7gxB9P6sh4PbGzhoHKmis8Hht4k3v7KG23
         zxYpXeOHMgvx/7LoqjVwKnbci22YXWPN3n0mPwyuBO1Q9dI8hHQ+ZgWZ/56us9fIH7
         +3afD8pnVxiUA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 5/7] btrfs: skip logging inodes already logged when logging new entries
Date:   Wed, 27 Jan 2021 10:34:58 +0000
Message-Id: <ec2887f0b8ac633a377496206c4124154700eb3b.1611742865.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1611742865.git.fdmanana@suse.com>
References: <cover.1611742865.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When logging new directory entries of a directory, we log the inodes of
new dentries and the inodes of dentries pointing to directories that
may have been created in past transactions. For the case of directories
we log in full mode, which can be particularly expensive for large
directories.

We do use btrfs_inode_in_log() to skip already logged inodes, however for
that helper to return true, it requires that the log transaction used to
log the inode to be already committed. This means that when we have more
than one task using the same log transaction we can end up logging an
inode multiple times, which is a waste of time and not necessary since
the log will be committed by one of the tasks and the others will wait for
the log transaction to be committed before returning to user space.

So simply replace the use of btrfs_inode_in_log() with the new helper
function need_log_inode(), introduced in a previous commit.

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
 fs/btrfs/tree-log.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index c0dce99c2c14..6dc376a16cf2 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -5676,7 +5676,7 @@ static int log_new_dir_dentries(struct btrfs_trans_handle *trans,
 				goto next_dir_inode;
 			}
 
-			if (btrfs_inode_in_log(BTRFS_I(di_inode), trans->transid)) {
+			if (!need_log_inode(trans, BTRFS_I(di_inode))) {
 				btrfs_add_delayed_iput(di_inode);
 				break;
 			}
-- 
2.28.0

