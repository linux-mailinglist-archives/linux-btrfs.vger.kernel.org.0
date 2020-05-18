Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B62DD1D7E99
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 May 2020 18:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbgERQe1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 May 2020 12:34:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:33438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727020AbgERQe0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 May 2020 12:34:26 -0400
Received: from debian6.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E968207E8
        for <linux-btrfs@vger.kernel.org>; Mon, 18 May 2020 16:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589819666;
        bh=drSKq916KhCBtagyLgFuyThUKR0x50Aq1MYUK6FldRA=;
        h=From:To:Subject:Date:From;
        b=GdNkPP/sUM7+UzEaWwcFF4kYvrKy31ITiRlWVmWcNCrd2PojkZCtgTXuJjHAbpFZg
         GAZiXLRsM4nb4yJK6t+UozJWX/U4luyR/GB22B0y1sAD4v+ndrVswdaT7yXdCWXhTM
         u4xo9w9JTXj+z0DPmp/nzL5Z1lkAfJGwgaopT/1c=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] Btrfs: turn space cache writeout failure messages into debug messages
Date:   Mon, 18 May 2020 17:34:23 +0100
Message-Id: <20200518163423.18710-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Since commit 1afb648e945428 ("btrfs: use standard debug config option to
enable free-space-cache debug prints"), we started to log error messages
that were never logged before since there was no DEBUG macro defined
anywhere. This started to make test case btrfs/187 to fail very often,
as it greps for any btrfs error messages in dmesg/syslog and fails if
any is found:

(...)
btrfs/186 1s ...  2s
btrfs/187       - output mismatch (see .../results//btrfs/187.out.bad)
    \--- tests/btrfs/187.out     2019-05-17 12:48:32.537340749 +0100
    \+++ /home/fdmanana/git/hub/xfstests/results//btrfs/187.out.bad ...
    \@@ -1,3 +1,8 @@
     QA output created by 187
     Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap1'
     Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap2'
    +[268364.139958] BTRFS error (device sdc): failed to write free space cache for block group 30408704
    +[268380.156503] BTRFS error (device sdc): failed to write free space cache for block group 30408704
    +[268380.161703] BTRFS error (device sdc): failed to write free space cache for block group 30408704
    +[268380.253180] BTRFS error (device sdc): failed to write free space cache for block group 30408704
    ...
    (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/187.out ...
btrfs/188 4s ...  2s
(...)

The space cache write failures happen due to ENOSPC when attempting to
update the free space cache items in the root tree. This happens because
when starting or joining a transaction we don't know how many block
groups we will end up changing (due to extent allocation or release) and
therefore never reserve space for updating free space cache items.
More often than not, the free space cache writeout succeeds since the
metadata space info is not yet full nor very close to being full, but
when it is, the space cache writeout fails with ENOSPC.

Occasional failures to write space caches are not considered critical
since they can be rebuilt when mounting the filesystem or the next
attempt to write a free space cache in the next transaction commit might
succeed, so we used to hide those error messages with a preprocessor
check for the existence of the DEBUG macro that was never enabled
anywhere.

A few other generic test cases also trigger the error messages due to
ENOSPC failure when writing free space caches as well, however they don't
fail since they don't grep dmesg/syslog for any btrfs specific error
messages.

So change the messages from 'error' level to 'debug' level, as it doesn't
make much sense to have error messages triggered only if the debug macro
is enabled plus, more importantly, the error is not serious nor highly
unexpected.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/free-space-cache.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 3f63deb9f188..fb06cb3d3b3d 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -1190,13 +1190,10 @@ static int __btrfs_wait_cache_io(struct btrfs_root *root,
 	if (ret) {
 		invalidate_inode_pages2(inode->i_mapping);
 		BTRFS_I(inode)->generation = 0;
-		if (block_group) {
-#ifdef CONFIG_BTRFS_DEBUG
-			btrfs_err(root->fs_info,
+		if (block_group)
+			btrfs_debug(root->fs_info,
 	  "failed to write free space cache for block group %llu error %d",
 				  block_group->start, ret);
-#endif
-		}
 	}
 	btrfs_update_inode(trans, root, inode);
 
@@ -1415,11 +1412,9 @@ int btrfs_write_out_cache(struct btrfs_trans_handle *trans,
 	ret = __btrfs_write_out_cache(fs_info->tree_root, inode, ctl,
 				block_group, &block_group->io_ctl, trans);
 	if (ret) {
-#ifdef CONFIG_BTRFS_DEBUG
-		btrfs_err(fs_info,
+		btrfs_debug(fs_info,
 	  "failed to write free space cache for block group %llu error %d",
 			  block_group->start, ret);
-#endif
 		spin_lock(&block_group->lock);
 		block_group->disk_cache_state = BTRFS_DC_ERROR;
 		spin_unlock(&block_group->lock);
@@ -3995,11 +3990,9 @@ int btrfs_write_out_ino_cache(struct btrfs_root *root,
 		if (release_metadata)
 			btrfs_delalloc_release_metadata(BTRFS_I(inode),
 					inode->i_size, true);
-#ifdef CONFIG_BTRFS_DEBUG
-		btrfs_err(fs_info,
+		btrfs_debug(fs_info,
 			  "failed to write free ino cache for root %llu error %d",
 			  root->root_key.objectid, ret);
-#endif
 	}
 
 	return ret;
-- 
2.11.0

