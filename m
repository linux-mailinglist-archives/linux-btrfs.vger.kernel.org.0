Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 538C34D9E98
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Mar 2022 16:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349576AbiCOPYH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Mar 2022 11:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343675AbiCOPYD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Mar 2022 11:24:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6170C60F5
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Mar 2022 08:22:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EDAF261215
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Mar 2022 15:22:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAA25C340EE
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Mar 2022 15:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647357769;
        bh=fwYOgMbEI82P26VWNA6F749MKstboGRzfVlUg4hstg4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=GyUE7SxzBPtWZaMplSYnV5MSLbkdjp0bTjdQtn4+gLCLMXPvVWtXnwG3tWQFg1LWz
         N//LgbEqe5gGZojmjbupPO15pjCfruFirsmGivlN6DcO9HOVYmQh4/g8JAwLhawstA
         6h2xQ32kr8cKiWWSf9vRu8k3NfgibC79HK6zp1wMaDPbaVRsTCfL16EQ2rwZyYmNEf
         1qNqVe4XiChftHmFG8CnuPbc4zPumgzYH25t0ti2GBs5/aB61a6HG8T94xcz6ijQrC
         sI5FWp1kTwnqWV4sz5lbWF7QH9Emj/JgzwWm+9BhMZY/eJbmR/m1ENGKjBylIlkHPz
         AIZvV/9Ldd30Q==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 5/7] btrfs: lock the inode first before flushing range when punching hole
Date:   Tue, 15 Mar 2022 15:22:39 +0000
Message-Id: <56653224f4bb1b3771169abfe8db18b67625efdc.1647357395.git.fdmanana@suse.com>
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

When doing hole punching we are flushing delalloc and waiting for ordered
extents to complete before locking the inode (VFS lock and the btrfs
specific i_mmap_lock). This is fine because even if a write happens after
we call btrfs_wait_ordered_range() and before we lock the inode (call
btrfs_inode_lock()), we will notice the write at
btrfs_punch_hole_lock_range() and flush delalloc and wait for its ordered
extent.

We can however make this simpler by locking first the inode an then call
btrfs_wait_ordered_range(), which will allow us to remove the ordered
extent lookup logic from btrfs_punch_hole_lock_range() in the next patch.
It also makes the behaviour the same as plain fallocate, hole punching
and reflinks.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/file.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index a7fd05c1d52f..56c7961d165b 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2976,11 +2976,12 @@ static int btrfs_punch_hole(struct file *file, loff_t offset, loff_t len)
 	bool truncated_block = false;
 	bool updated_inode = false;
 
+	btrfs_inode_lock(inode, BTRFS_ILOCK_MMAP);
+
 	ret = btrfs_wait_ordered_range(inode, offset, len);
 	if (ret)
-		return ret;
+		goto out_only_mutex;
 
-	btrfs_inode_lock(inode, BTRFS_ILOCK_MMAP);
 	ino_size = round_up(inode->i_size, fs_info->sectorsize);
 	ret = find_first_non_hole(BTRFS_I(inode), &offset, &len);
 	if (ret < 0)
-- 
2.33.0

