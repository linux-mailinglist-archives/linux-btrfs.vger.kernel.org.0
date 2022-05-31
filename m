Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACA253939A
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 May 2022 17:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241907AbiEaPGx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 May 2022 11:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345431AbiEaPGv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 May 2022 11:06:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1049EA3
        for <linux-btrfs@vger.kernel.org>; Tue, 31 May 2022 08:06:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 885C0B80FB3
        for <linux-btrfs@vger.kernel.org>; Tue, 31 May 2022 15:06:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0F65C3411D
        for <linux-btrfs@vger.kernel.org>; Tue, 31 May 2022 15:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654009608;
        bh=V9s216kD7I1lYMt7pYe5HLjLOzxgYleVWW6rvXXX+tU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=dsPyXvGpB++1IfFS6CYu9J+vqzI+as7wtTGfDoucT19kd7nrJ6fQTNaU5fRXOtKo6
         +GkWhWYSMmHijODKY46tG5z2Bs5saO8VuuZZcJbHmpSROis4R2SHCi4CkFPEP/7MLx
         8YM2s/tS7DFzHGGO9DJYnTkE/8dBjgqUe4Cump8gHqTcGaYSAwVIM1i1dpCAMNosUC
         ThbkRqtHJii207x6Nxw0Ai0IbqQ6fFxHdWBoepiOadHmov+8o7948yJVAdvUqC0+fJ
         RU7O4KPySWsrFib5EAbdZgbsRbMZtnbo6G2GgHZAWw/BafDxcf34qcqFO+J1d83Gse
         0HsHNwi4ZbBPQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 01/12] btrfs: balance btree dirty pages and delayed items after a rename
Date:   Tue, 31 May 2022 16:06:32 +0100
Message-Id: <06a51882e0ce06794248a10f5c1c70b987dab62f.1654009356.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1654009356.git.fdmanana@suse.com>
References: <cover.1654009356.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

A rename operation modifies a subvolume's btree, to remove the old dir
item, add the new dir item, remove an inode ref and add a new inode ref.
It can also create the delayed inode for the inodes involved in the
operation, and it creates two delayed dir index items, one to delete
the old name and another one to add the new name.

However we are neither balancing the btree dirty pages nor the delayed
items after a rename, which can result in accumulation of too many
btree dirty pages and delayed items, specially if a task is doing a
series of rename operations (for example it can happen for package
installations/upgrades through the zypper tool).

So just call btrfs_btree_balance_dirty() after a rename, just like we
do for every other system call that results on modifying a btree and
adding delayed items.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index ba913ea6f4d1..06d5bfa84d38 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9546,15 +9546,21 @@ static int btrfs_rename2(struct user_namespace *mnt_userns, struct inode *old_di
 			 struct dentry *old_dentry, struct inode *new_dir,
 			 struct dentry *new_dentry, unsigned int flags)
 {
+	int ret;
+
 	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE | RENAME_WHITEOUT))
 		return -EINVAL;
 
 	if (flags & RENAME_EXCHANGE)
-		return btrfs_rename_exchange(old_dir, old_dentry, new_dir,
-					  new_dentry);
+		ret = btrfs_rename_exchange(old_dir, old_dentry, new_dir,
+					    new_dentry);
+	else
+		ret = btrfs_rename(mnt_userns, old_dir, old_dentry, new_dir,
+				   new_dentry, flags);
 
-	return btrfs_rename(mnt_userns, old_dir, old_dentry, new_dir,
-			    new_dentry, flags);
+	btrfs_btree_balance_dirty(BTRFS_I(new_dir)->root->fs_info);
+
+	return ret;
 }
 
 struct btrfs_delalloc_work {
-- 
2.35.1

