Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4DA72E7E3
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jun 2023 18:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241202AbjFMQIG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Jun 2023 12:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243014AbjFMQIF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Jun 2023 12:08:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A071981
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 09:08:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 284A361FBA
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 16:08:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 096B8C433F1
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 16:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686672482;
        bh=JIyMVTypB6bgC4xRMxzZRmjttP1sytMD3KBfp958j/I=;
        h=From:To:Subject:Date:From;
        b=MqYtZ4FEvdhKlXxUHxHZeS6RtK/ZyP62GiQIbYik3ycoWXB5XWWDTm2dR4tszEAKp
         /w9D6ma8Y7h/k4N31TgvuDzoerzH1Bo0gYJ1qEJajCjgezNcVuSJBC5S0G/GbuJ1a5
         Q2Ux6sO9p86uoPox1w25ig37wHSVKV9g24iMqNEDIO1Pv33MmR/+P2+bPov9LQQMzg
         y+sT/MZbUhp8R7Vgycyk3QDM7jIJHCeAUtJsidSveXtm0YAd5Eg9Z2xI2DcxdhI9ls
         Ux99ARGFfQxOdLJgNgpMDIhhvbrAsftg6UXSsnIJIo4LVBgpd3JApcoTWBN6O+q3yw
         WTlL4nMYfCZYw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: do not BUG_ON after failure to migrate space during truncation
Date:   Tue, 13 Jun 2023 17:07:54 +0100
Message-Id: <ef45ecc23ffac44258794dfebaedd30e2db27a45.1686672418.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
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

During truncation we reserve 2 metadata units when starting a transaction
(reserved space goes to fs_info->trans_block_rsv) and then attempt to
migrate 1 unit (min_size bytes) from fs_info->trans_block_rsv into the
local block reserve. If we ever fail we trigger a BUG_ON(), which should
never happen, because we reserved 2 units. However if we happen to fail
for some reason, we don't need to be so dire and hit a BUG_ON(), we can
just error out the truncation and, since this is highly unexpected,
surround the error check with WARN_ON(), to get an informative stack
trace and tag the branh as 'unlikely'. Also make the 'min_size' variable
const, since it's not supposed to ever change and any accidental change
could possibly make the space migration not so unlikely to fail.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 094664d9262b..c57623cb1a78 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8335,7 +8335,7 @@ static int btrfs_truncate(struct btrfs_inode *inode, bool skip_writeback)
 	int ret;
 	struct btrfs_trans_handle *trans;
 	u64 mask = fs_info->sectorsize - 1;
-	u64 min_size = btrfs_calc_metadata_size(fs_info, 1);
+	const u64 min_size = btrfs_calc_metadata_size(fs_info, 1);
 
 	if (!skip_writeback) {
 		ret = btrfs_wait_ordered_range(&inode->vfs_inode,
@@ -8392,7 +8392,15 @@ static int btrfs_truncate(struct btrfs_inode *inode, bool skip_writeback)
 	/* Migrate the slack space for the truncate to our reserve */
 	ret = btrfs_block_rsv_migrate(&fs_info->trans_block_rsv, rsv,
 				      min_size, false);
-	BUG_ON(ret);
+	/*
+	 * We have reserved 2 metadata units when we started the transaction and
+	 * min_size matches 1 unit, so this should never fail, but if it does,
+	 * it's not critical we just fail truncation.
+	 */
+	if (WARN_ON(ret)) {
+		btrfs_end_transaction(trans);
+		goto out;
+	}
 
 	trans->block_rsv = rsv;
 
@@ -8440,7 +8448,14 @@ static int btrfs_truncate(struct btrfs_inode *inode, bool skip_writeback)
 		btrfs_block_rsv_release(fs_info, rsv, -1, NULL);
 		ret = btrfs_block_rsv_migrate(&fs_info->trans_block_rsv,
 					      rsv, min_size, false);
-		BUG_ON(ret);	/* shouldn't happen */
+		/*
+		 * We have reserved 2 metadata units when we started the
+		 * transaction and min_size matches 1 unit, so this should never
+		 * fail, but if it does, it's not critical we just fail truncation.
+		 */
+		if (WARN_ON(ret))
+			break;
+
 		trans->block_rsv = rsv;
 	}
 
-- 
2.34.1

