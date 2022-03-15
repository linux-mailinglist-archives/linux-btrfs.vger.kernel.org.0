Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCE84D9AFA
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Mar 2022 13:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348195AbiCOMUT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Mar 2022 08:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242292AbiCOMUP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Mar 2022 08:20:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9328E522CF
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Mar 2022 05:19:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3003A61521
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Mar 2022 12:19:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AA99C340EE
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Mar 2022 12:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647346742;
        bh=OV7MMr8xlvIszUCCs20HP4DRP/uFvVzJziiLDdXa2qM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=FgK9YAiRTIf7zuPpRmkoUMMT04h6LUlgYud+jKSlBaTfQkjZIzhwuEKGNSHH/rkj6
         yEl5ISDcZjTNlKqffg6tqjD9dawLAkLFv8sbPn7Zm6uz4NLNslDEWcoSekG4oYy+os
         CSsnpnBN1u0cC5IW0seEDNN5rnJ5l1xSKgZ+FDIZpihO2n9hE3vOWj4MlV2+jxbjLX
         /6ZfgTavzc41CRCLy94fSRLaSXtnaZHlpjdfFAuzmxS037pVEMZ7GrsCWtxYq7ym2z
         PdFN7GVJP2UrGOhgD/rKop+K9JKQWObTBDNHxE+9JHeWjThrxKUXAgzDUQ8nk7wEgV
         V5SP2k5KEXJ7w==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 5/7] btrfs: lock the inode first before flushing range when punching hole
Date:   Tue, 15 Mar 2022 12:18:52 +0000
Message-Id: <97119c63d65974be1d8d728b616c9c9637e96f02.1647346287.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1647346287.git.fdmanana@suse.com>
References: <cover.1647346287.git.fdmanana@suse.com>
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
It will makes the behaviour the same as plain fallocate, reflinks, and
other places.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index a7fd05c1d52f..a78a90cfc082 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2976,11 +2976,12 @@ static int btrfs_punch_hole(struct file *file, loff_t offset, loff_t len)
 	bool truncated_block = false;
 	bool updated_inode = false;
 
+	btrfs_inode_lock(inode, BTRFS_ILOCK_MMAP);
+
 	ret = btrfs_wait_ordered_range(inode, offset, len);
 	if (ret)
 		return ret;
 
-	btrfs_inode_lock(inode, BTRFS_ILOCK_MMAP);
 	ino_size = round_up(inode->i_size, fs_info->sectorsize);
 	ret = find_first_non_hole(BTRFS_I(inode), &offset, &len);
 	if (ret < 0)
-- 
2.33.0

