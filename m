Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058B77B7D64
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Oct 2023 12:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242194AbjJDKjN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Oct 2023 06:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242151AbjJDKjF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Oct 2023 06:39:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E95B0
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Oct 2023 03:39:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16492C433C9
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Oct 2023 10:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696415941;
        bh=SxTagRU+N0LdKkxGyXvivIdXGe0ejMA71/KTArUrXZM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=nt57JxKupwOcPEAp0S60RT4EbgpSxiaz21FatcLwP2LlDDj4MoCbysSHFcC+xwqqh
         1VOpRJA5C8fSGuWIYLDJij6iy2YxijUPmt3efAwH1pwJgm0yrpr3Z2untRRjLsRJxW
         yV/T8lv/JeHzGR8t+F0npC79d3qAST44FN7oDWhXYVpHtYxvDeBQZg5FD27Wl1fpyJ
         OfnKlT2Vwx/tuRNFOohuAeQIQGGranzwIKpTWW3UTdNkj6LeDxLwPXGMR7gOIUgDHY
         6Bxy8E43OToTetVrzJhTY2GITbwqQdm+7uFGh/Vo5/eXl1nIfj6II4f1GZt8U7dM1v
         LkMA3cCM5y0RQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 5/6] btrfs: remove pointless barrier from btrfs_sync_file()
Date:   Wed,  4 Oct 2023 11:38:52 +0100
Message-Id: <ba7f7646404185a0713f55c50be90e659d29a566.1696415673.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1696415673.git.fdmanana@suse.com>
References: <cover.1696415673.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The memory barrier (smp_mb()) at btrfs_sync_file() is completely redundant
now that fs_info->last_trans_committed is read using READ_ONCE(), with the
helper btrfs_get_last_trans_committed(), and written using WRITE_ONCE()
with the helper btrfs_set_last_trans_committed().

This barrier was introduced in 2011, by commit a4abeea41adf ("Btrfs: kill
trans_mutex"), but even back then it was not correct since the writer side
(in btrfs_commit_transaction()), did not issue a pairing memory barrier
after it updated fs_info->last_trans_committed.

So remove this barrier.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/file.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 92e6f224bff9..92419cb8508a 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1889,7 +1889,6 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 
 	atomic_inc(&root->log_batch);
 
-	smp_mb();
 	if (skip_inode_logging(&ctx)) {
 		/*
 		 * We've had everything committed since the last time we were
-- 
2.40.1

