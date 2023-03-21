Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38AF26C2FFC
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 12:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjCULOu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Mar 2023 07:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjCULOq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Mar 2023 07:14:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E9528E98
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 04:14:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E2E761B11
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 11:14:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52587C433D2
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 11:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679397253;
        bh=iY2GJZUSbtMJJX5yM6Ehw66XVEcLIM5bmyMASSpLRpY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Rr7H8EAa5zux+DX38ss4qWXBAh7n+xjZZWqKr+3g1/dEi2462adNcIqSFkXCUcxR+
         qxxvWQCbcGRHnZjyNjv+7WdDx2yaShluuylgWhJ2M6U63/LhME78aj1NfgucmIH2CE
         +/5GUq+C9b2XwcrJ/hWvIorYQU+nXiRlct2AEuFR7PP2iFXP+GdpE/2blv/uGD1nNV
         Gs5yhPuyffnAwIgQ0Klk7hs8v15mAS7UZFfc8osVQ7mTTrUvK8F75zKW+6Rt7fD5wc
         TwpD3/M0+YBWZUl63hHf6qsalF8NMed8ZDodDyjX06VOlbWWD/gO40dFs/TWJ6v0H/
         JuPGDHoDmnsQA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 10/24] btrfs: count extents before taking inode's spinlock when reserving metadata
Date:   Tue, 21 Mar 2023 11:13:46 +0000
Message-Id: <bcdf4e4856f633dfbcc3525630063e204ae710dc.1679326432.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1679326426.git.fdmanana@suse.com>
References: <cover.1679326426.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When reserving metadata space for delalloc (and direct IO too), at
btrfs_delalloc_reserve_metadata(), there's no need to count the number of
extents while holding the inode's spinlock, since that does not require
access to any field of the inode.

This section of code can be called concurrently, when we have direct IO
writes against different file ranges that don't increase the inode's
i_size, so it's beneficial to shorten the critical section by counting
the number of extents before taking the inode's spinlock.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/delalloc-space.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
index 7ddb1d104e8e..427abaf608b8 100644
--- a/fs/btrfs/delalloc-space.c
+++ b/fs/btrfs/delalloc-space.c
@@ -358,8 +358,8 @@ int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes,
 	 * racing with an ordered completion or some such that would think it
 	 * needs to free the reservation we just made.
 	 */
-	spin_lock(&inode->lock);
 	nr_extents = count_max_extents(fs_info, num_bytes);
+	spin_lock(&inode->lock);
 	btrfs_mod_outstanding_extents(inode, nr_extents);
 	inode->csum_bytes += disk_num_bytes;
 	btrfs_calculate_inode_block_rsv_size(fs_info, inode);
-- 
2.34.1

