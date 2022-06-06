Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2F553EA35
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jun 2022 19:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233135AbiFFJl3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jun 2022 05:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233125AbiFFJl0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Jun 2022 05:41:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ABD01CE7A7
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Jun 2022 02:41:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D1DA6135D
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Jun 2022 09:41:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2A4DC385A9
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Jun 2022 09:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654508484;
        bh=/HTEoX48r3A6kCdnlPrzX4g89UWxQ6y+vQDVWyWePlk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=UtpgjLSC2cZFSyO4Hh1RZcDD4Mqwg86ckKUj/u7DHihowG59bw60F0W1JUD6WWkva
         rxgG78CUz51w4OxGpnKy6DDiIfdeye5sUK2xqXHJi7A5sCKUUynvDArJc0SpUJsO5n
         sy5+cMWHqrbHgtMAfw+g6SQ7UT38673qyrpoEYDd8uf4KIWNCkV+eJdQAGz/h3ZKSm
         mG4ZVq5Ray0tGxYDSKGOf5/HWKO4o1QDgMqxl5F8WhtkBDWN+pgYOzCJFbu5iwtryq
         hDyoviZTgG77+YauqI+Mk2o4pZ02qHNz2QX9ZD0Vbc7btUzA+zyxO+Y3oV6N5xNRK7
         vT5DVXXtcA+ug==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs: add missing inode updates on each iteration when replacing extents
Date:   Mon,  6 Jun 2022 10:41:18 +0100
Message-Id: <980e6be197825045a08ad6d463456bc73521e4d4.1654508104.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1654508104.git.fdmanana@suse.com>
References: <cover.1654508104.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When replacing file extents, called during fallocate, hole punching,
clone and deduplication, we may not be able to replace/drop all the
target file extent items with a single transaction handle. We may get
-ENOSPC while doing it, in which case we release the transaction handle,
balance the dirty pages of the btree inode, flush delayed items and get
a new transaction handle to operate on what's left of the target range.

By dropping and replacing file extent items we have effectively modified
the inode, so we should bump its iversion and update its mtime/ctime
before we update the inode item. This is because if the transaction
we used for partially modifying the inode gets committed by someone after
we release it and before we finish the rest of the range, a power failure
happens, then after mounting the filesystem our inode has an outdated
iversion and mtime/ctime, corresponding to the values it had before we
changed it.

So add the missing iversion and mtime/ctime updates.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.h   |  2 ++
 fs/btrfs/file.c    | 19 +++++++++++++++++++
 fs/btrfs/inode.c   |  1 +
 fs/btrfs/reflink.c |  1 +
 4 files changed, 23 insertions(+)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 55dee1564e90..737cd59d16b6 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1330,6 +1330,8 @@ struct btrfs_replace_extent_info {
 	 * existing extent into a file range.
 	 */
 	bool is_new_extent;
+	/* Indicate if we should update the inode's mtime and ctime. */
+	bool update_times;
 	/* Meaningful only if is_new_extent is true. */
 	int qgroup_reserved;
 	/*
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 1fd827b99c1b..29de433b7804 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2803,6 +2803,25 @@ int btrfs_replace_file_extents(struct btrfs_inode *inode,
 			extent_info->file_offset += replace_len;
 		}
 
+		/*
+		 * We are releasing our handle on the transaction, balance the
+		 * dirty pages of the btree inode and flush delayed items, and
+		 * then get a new transaction handle, which may now point to a
+		 * new transaction in case someone else may have committed the
+		 * transaction we used to replace/drop file extent items. So
+		 * bump the inode's iversion and update mtime and ctime except
+		 * if we are called from a dedupe context. This is because a
+		 * power failure/crash may happen after the transaction is
+		 * committed and before we finish replacing/dropping all the
+		 * file extent items we need.
+		 */
+		inode_inc_iversion(&inode->vfs_inode);
+
+		if (!extent_info || extent_info->update_times) {
+			inode->vfs_inode.i_mtime = current_time(&inode->vfs_inode);
+			inode->vfs_inode.i_ctime = inode->vfs_inode.i_mtime;
+		}
+
 		ret = btrfs_update_inode(trans, root, inode);
 		if (ret)
 			break;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 3ede3e873c2a..ab4ebcb7878c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9907,6 +9907,7 @@ static struct btrfs_trans_handle *insert_prealloc_file_extent(
 	extent_info.file_offset = file_offset;
 	extent_info.extent_buf = (char *)&stack_fi;
 	extent_info.is_new_extent = true;
+	extent_info.update_times = true;
 	extent_info.qgroup_reserved = qgroup_released;
 	extent_info.insertions = 0;
 
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index 7e3b0aa318c1..977e0d218d79 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -497,6 +497,7 @@ static int btrfs_clone(struct inode *src, struct inode *inode,
 			clone_info.file_offset = new_key.offset;
 			clone_info.extent_buf = buf;
 			clone_info.is_new_extent = false;
+			clone_info.update_times = !no_time_update;
 			ret = btrfs_replace_file_extents(BTRFS_I(inode), path,
 					drop_start, new_key.offset + datal - 1,
 					&clone_info, &trans);
-- 
2.35.1

