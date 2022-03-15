Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1644D9E96
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Mar 2022 16:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243034AbiCOPYG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Mar 2022 11:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243857AbiCOPYC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Mar 2022 11:24:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E162F3
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Mar 2022 08:22:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B3B36B81161
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Mar 2022 15:22:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01A42C340ED
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Mar 2022 15:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647357767;
        bh=N1uGgZ7jpmB97xU/FjNjDPP7MCBs2/e+l7l5TUpFegg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=XAWp/Pyd4nIftdTgYrxlPkP5I4G7I/jnGBdv9S6mkA9iD59cifv7kTO7QE0/ikNEa
         RYPMa6AYAzwgwDClxtpEUj0sNUJLw3Ef51FQtUCDN7cIlER6lJBI2tLA9pny7r6BdJ
         W7SINtfsgwJRGdvywbVfXqL61GpeokW3c/ObmAXZlLAW9LCfXRc4pXMZagiLeDj1pU
         ae8exwyIH83Dg5mDL7O6B1hsZaD3/Lij9JHej2TchQ6uvRduh1HgIYEmn7S/b+tRK5
         TTNhuJiXBn3wBmBA+ch7OzkQcPRDIYBjuLyWJPX5syMFx+RfIOgzDkWMCgob/ZpwYF
         azCqV67g3DG+g==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 3/7] btrfs: remove inode_dio_wait() calls when starting reflink operations
Date:   Tue, 15 Mar 2022 15:22:37 +0000
Message-Id: <8f6e560d92bdc804d3ede2d8e1d34f1a806107e0.1647357395.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1647357395.git.fdmanana@suse.com>
References: <cover.1647357395.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When starting a reflink operation we have these calls to inode_dio_wait()
which used to be needed because direct IO writes that don't cross the
i_size boundary did not take the inode's VFS lock, so we could race with
them and end up with ordered extents in target range after calling
btrfs_wait_ordered_range().

However that is not the case anymore, because the inode's VFS lock was
changed from a mutex to a rw semaphore, by commit 9902af79c01a8e
("parallel lookups: actual switch to rwsem"), and several years later we
started to lock the inode's VFS lock in shared mode for direct IO writes
that don't cross the i_size boundary (commit e9adabb9712ef9 ("btrfs: use
shared lock for direct writes within EOF")).

So remove those inode_dio_wait() calls.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/reflink.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index 04a88bfe4fcf..bbd5da25c475 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -771,7 +771,6 @@ static int btrfs_remap_file_range_prep(struct file *file_in, loff_t pos_in,
 	struct inode *inode_in = file_inode(file_in);
 	struct inode *inode_out = file_inode(file_out);
 	u64 bs = BTRFS_I(inode_out)->root->fs_info->sb->s_blocksize;
-	bool same_inode = inode_out == inode_in;
 	u64 wb_len;
 	int ret;
 
@@ -809,15 +808,6 @@ static int btrfs_remap_file_range_prep(struct file *file_in, loff_t pos_in,
 	else
 		wb_len = ALIGN(*len, bs);
 
-	/*
-	 * Since we don't lock ranges, wait for ongoing lockless dio writes (as
-	 * any in progress could create its ordered extents after we wait for
-	 * existing ordered extents below).
-	 */
-	inode_dio_wait(inode_in);
-	if (!same_inode)
-		inode_dio_wait(inode_out);
-
 	/*
 	 * Workaround to make sure NOCOW buffered write reach disk as NOCOW.
 	 *
-- 
2.33.0

