Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C312E7CE519
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Oct 2023 19:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbjJRRmb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Oct 2023 13:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbjJRRmC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Oct 2023 13:42:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5378F137;
        Wed, 18 Oct 2023 10:41:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 438D3C433D9;
        Wed, 18 Oct 2023 17:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697650911;
        bh=08peVOKZI4MR32wuXNO48w8LFAelNL7UOowvOcywmvk=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=W/ufbXG6bJI9e49CMjNUjxnvN8rpYE07kV1Uv10lbs/C8hNuvNOyNt34VfqYnC9DS
         I49zl61Mm94s/lF9vju5dzbq67/qC6Ar9L8q60dVvEDaVDtocmAwykqrLymr+qZux/
         lVbBynbEAYYfrdp3mlaPnhPGOSlk/bLGkiSCd3V/9bKS5BgA9OPrfvjMa7CO0JzooF
         M9MdsOlxGkVapwTxlcbX6mNMMUoJtnBk5eL19Gf1y3rjt63K4Q+9v6Pai1IDz/fGIO
         pb4hveW0yjsp2pnmsVFm6s91KvwIgLFKzm8zK2eCovTbh6AP1vv+TXLbdyc/5r18WG
         RuObwSWU6PuEA==
From:   Jeff Layton <jlayton@kernel.org>
Date:   Wed, 18 Oct 2023 13:41:15 -0400
Subject: [PATCH RFC 8/9] btrfs: convert to multigrain timestamps
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231018-mgtime-v1-8-4a7a97b1f482@kernel.org>
References: <20231018-mgtime-v1-0-4a7a97b1f482@kernel.org>
In-Reply-To: <20231018-mgtime-v1-0-4a7a97b1f482@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.de>,
        David Howells <dhowells@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2744; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=08peVOKZI4MR32wuXNO48w8LFAelNL7UOowvOcywmvk=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlMBjJZH0sHfYjXHZeCrVOFs/hUFjZBM0oBFoPW
 KoouqyR/TCJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZTAYyQAKCRAADmhBGVaC
 FSbeEACAUjZExA/YblPlgkxwqx2TRI6TFuS5NFnYMhcyki2B2XIkJnpD00JJl8GKM2MskyOvrQ8
 Yd7Q8MzEyeQXxkNNt0V+DWuQYMst+8EKu9X5/T7v/1Anjkaz3ZzdirOXSZR6N53cMMLFGgSpJSv
 mUGs7YUWvT8XrGon0xoQ1CIuie6MmZkT5AQfZEc/0tTcmqk9uNg2/4VypX+oQeNMSyMf+xzO7Ss
 iQMxMetZB5ZQB1goTm4qxKjeOI3+mzLV977iDUyM96oHtAhYzUukSms5Hw6dNZDMRFkzOweotXZ
 IXY180/C7BmfVwV7MGwpqfVBRWiVNZEJDRERUQGB3cXYfYlETLz0enJOQvdvw697641AptAD0RD
 9sqdT2M5ue6hTbEBj0y/DtlwhFPMeKr2KSDih9MgJZiqUPD89I/hx5RtNbvWcy8QM7ZH/+HVbVq
 RPl5tV9C0deifptk08XdKAgSnFPEg6Tm5ahINqN5V+lYnhd/b9CjY1kShQfBjex8bwxaUXnXMAq
 VZamJx2U4u1P3bNGzCpoON3dNyRXvIx3l3Kyc2E4+la0DaCeknTxoXrKWabtu31CEFLEsNN6QGj
 bC+V3q+EAl3kxNPQV7gpgEJKVOTyWeBu30B76+qZgKOQk4JrNb2ZVmXK2Kj3VHs7OONPBZShAfo
 fyUe5HZ/2zFbI5A==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Enable multigrain timestamps, which should ensure that there is an
apparent change to the timestamp whenever it has been written after
being actively observed via getattr.

Beyond enabling the FS_MGTIME flag, this patch eliminates
update_time_for_write, which goes to great pains to avoid in-memory
stores. Just have it overwrite the timestamps unconditionally.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/btrfs/file.c  | 25 ++++---------------------
 fs/btrfs/super.c |  5 +++--
 2 files changed, 7 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 278a4ea651e1..321405bf788c 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1106,26 +1106,6 @@ void btrfs_check_nocow_unlock(struct btrfs_inode *inode)
 	btrfs_drew_write_unlock(&inode->root->snapshot_lock);
 }
 
-static void update_time_for_write(struct inode *inode)
-{
-	struct timespec64 now, ts;
-
-	if (IS_NOCMTIME(inode))
-		return;
-
-	now = current_time(inode);
-	ts = inode_get_mtime(inode);
-	if (!timespec64_equal(&ts, &now))
-		inode_set_mtime_to_ts(inode, now);
-
-	ts = inode_get_ctime(inode);
-	if (!timespec64_equal(&ts, &now))
-		inode_set_ctime_to_ts(inode, now);
-
-	if (IS_I_VERSION(inode))
-		inode_inc_iversion(inode);
-}
-
 static int btrfs_write_check(struct kiocb *iocb, struct iov_iter *from,
 			     size_t count)
 {
@@ -1157,7 +1137,10 @@ static int btrfs_write_check(struct kiocb *iocb, struct iov_iter *from,
 	 * need to start yet another transaction to update the inode as we will
 	 * update the inode when we finish writing whatever data we write.
 	 */
-	update_time_for_write(inode);
+	if (!IS_NOCMTIME(inode)) {
+		inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
+		inode_inc_iversion(inode);
+	}
 
 	start_pos = round_down(pos, fs_info->sectorsize);
 	oldsize = i_size_read(inode);
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index f49e597e197f..570613bfd25f 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2154,7 +2154,7 @@ static struct file_system_type btrfs_fs_type = {
 	.name		= "btrfs",
 	.mount		= btrfs_mount,
 	.kill_sb	= btrfs_kill_super,
-	.fs_flags	= FS_REQUIRES_DEV | FS_BINARY_MOUNTDATA,
+	.fs_flags	= FS_REQUIRES_DEV | FS_BINARY_MOUNTDATA | FS_MGTIME,
 };
 
 static struct file_system_type btrfs_root_fs_type = {
@@ -2162,7 +2162,8 @@ static struct file_system_type btrfs_root_fs_type = {
 	.name		= "btrfs",
 	.mount		= btrfs_mount_root,
 	.kill_sb	= btrfs_kill_super,
-	.fs_flags	= FS_REQUIRES_DEV | FS_BINARY_MOUNTDATA | FS_ALLOW_IDMAP,
+	.fs_flags	= FS_REQUIRES_DEV | FS_BINARY_MOUNTDATA |
+			  FS_ALLOW_IDMAP | FS_MGTIME,
 };
 
 MODULE_ALIAS_FS("btrfs");

-- 
2.41.0

