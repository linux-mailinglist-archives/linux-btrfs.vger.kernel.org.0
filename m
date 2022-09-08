Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF6AD5B1B7C
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Sep 2022 13:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbiIHLcE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Sep 2022 07:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbiIHLcA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Sep 2022 07:32:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB569C7BBC
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Sep 2022 04:31:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A66B9B81FA2
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Sep 2022 11:31:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00E1DC433B5
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Sep 2022 11:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662636716;
        bh=N87z/fgisLJZaMoPSAhDq91sovrsC1NRYqkznip8MA4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=eklh/wI97WxoZc6DgAh4dHHHy8YB+bFXLe4pauORj9HSgTz9y5JfUzjZllVb+u0aT
         mPlRUymeGXY2+DGW5suUIMmTdSIOgYOowTnLaI272MLDsllZjtGhiVcisR9MoAwkhm
         8pkkpmNvDzzIDKafED5PNoIu1pSqaIPrH8G+ndAY/Xz9nJrCZIKdXoLgEKuhUxF7mB
         st4ObE21p/Rrw3yPPRJbNvbErRf0vpyC3NuXa367g8iTT+dNZ5QPp/1khd0oYgXBv7
         N6AHbl5Km6pBGkASNjpgUzM/gI/YMKz6r9oAYlT6ev011Z6xLfjbf6R5YkHCKd+Ovt
         HFJwThWoD59kA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs: fix hang during unmount when stopping block group reclaim worker
Date:   Thu,  8 Sep 2022 12:31:50 +0100
Message-Id: <8e5ab315057d29bbfc4f7f9f0361f9b3451500e3.1662636489.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1662636489.git.fdmanana@suse.com>
References: <cover.1662636489.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

During early unmount, at close_ctree(), we try to stop the block group
reclaim task with cancel_work_sync(), but that may hang if the block group
reclaim task is currently at btrfs_relocate_block_group() waiting for the
flag BTRFS_FS_UNFINISHED_DROPS to be cleared from fs_info->flags. During
unmount we only clear that flag later, after trying to stop the block
group reclaim task.

Fix that by clearing BTRFS_FS_UNFINISHED_DROPS before trying to stop the
block group reclaim task and after setting BTRFS_FS_CLOSING_START, so that
if the reclaim task is waiting on that bit, it will stop immediately after
being woken, because it sees the filesystem is closing (with a call to
btrfs_fs_closing()), and then returns immediately with -EINTR.

Fixes: 31e70e527806c5 ("btrfs: fix hang during unmount when block group reclaim task is running")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/disk-io.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index e67614afcf4f..928adde1963d 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4488,6 +4488,17 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 
 	set_bit(BTRFS_FS_CLOSING_START, &fs_info->flags);
 
+	/*
+	 * If we had UNFINISHED_DROPS we could still be processing them, so
+	 * clear that bit and wake up relocation so it can stop.
+	 * We must do this before stopping the block group reclaim task, because
+	 * at btrfs_relocate_block_group() we wait for this bit, and after the
+	 * wait we stop with -EINTR if btrfs_fs_closing() returns non-zero - we
+	 * have just set BTRFS_FS_CLOSING_START, so btrfs_fs_closing() will
+	 * return 1.
+	 */
+	btrfs_wake_unfinished_drop(fs_info);
+
 	/*
 	 * We may have the reclaim task running and relocating a data block group,
 	 * in which case it may create delayed iputs. So stop it before we park
@@ -4506,12 +4517,6 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 	 */
 	kthread_park(fs_info->cleaner_kthread);
 
-	/*
-	 * If we had UNFINISHED_DROPS we could still be processing them, so
-	 * clear that bit and wake up relocation so it can stop.
-	 */
-	btrfs_wake_unfinished_drop(fs_info);
-
 	/* wait for the qgroup rescan worker to stop */
 	btrfs_qgroup_wait_for_completion(fs_info, false);
 
-- 
2.35.1

