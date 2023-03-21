Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7356C3003
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 12:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbjCULO6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Mar 2023 07:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjCULOu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Mar 2023 07:14:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A61B35273
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 04:14:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BDCCE61B1D
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 11:14:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B769BC433EF
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 11:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679397265;
        bh=T82ZI3qW9gZbESYZpnuSXwp+ZGMRGzRo3xpk6bCmppk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=p7MTf7d8GsLxaXwXp+GPy3nUHi7Oi5kujjMK/1PwX5pFtk9VQwYtyWghd8VQok6K1
         ELBG0FjTdnwF/wNXQFK5xaH/6fdCqe0OYklORPDUa5lV4XgcH3Jci1LxqE1YeKhvWu
         fEFEdzQZHP6ylt/Ydw4YZqsNjKjFikA8/9JMEdEBtapRCtIeUVgfoQRKzFwvPf71SF
         fuOMS6RElY9uQtT91JQ8ZLRss5mm4nmTTJ77bU2krvR1Ov4d//+uJ470PInzsPKIIp
         OO4mB1bLliPP8MEe+0E2xC6ZLQQDpcXyRvXhqQOT0S6/puV7pKtbOIJheBIhhOnDJ9
         08ZfTcqBgmBsg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 23/24] btrfs: calculate the right space for delayed refs when updating global reserve
Date:   Tue, 21 Mar 2023 11:13:59 +0000
Message-Id: <910e0c266d33d7d7f05b2a3237d34b23ad12dde5.1679326435.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1679326426.git.fdmanana@suse.com>
References: <cover.1679326426.git.fdmanana@suse.com>
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

When updating the global block reserve, we account for the 6 items needed
by an unlink operation and the 6 delayed references for each one of those
items. However the calculation for the delayed references is not correct
in case we have the free space tree enabled, as in that case we need to
touch the free space tree as well and therefore need twice the number of
bytes. So use the btrfs_calc_delayed_ref_bytes() helper to calculate the
number of bytes need for the delayed references at
btrfs_update_global_block_rsv().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-rsv.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
index b4a1f1bc340f..3ab707e26fa2 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -354,14 +354,15 @@ void btrfs_update_global_block_rsv(struct btrfs_fs_info *fs_info)
 	 * BTRFS_UNLINK_METADATA_UNITS items.
 	 *
 	 * But we also need space for the delayed ref updates from the unlink,
-	 * so it's BTRFS_UNLINK_METADATA_UNITS * 2, BTRFS_UNLINK_METADATA_UNITS
-	 * for the actual operation, and BTRFS_UNLINK_METADATA_UNITS more for
-	 * the delayed ref updates.
+	 * so add BTRFS_UNLINK_METADATA_UNITS units for delayed refs, one for
+	 * each unlink metadata item.
 	 */
-	min_items += BTRFS_UNLINK_METADATA_UNITS * 2;
+	min_items += BTRFS_UNLINK_METADATA_UNITS;
 
 	num_bytes = max_t(u64, num_bytes,
-			  btrfs_calc_insert_metadata_size(fs_info, min_items));
+			  btrfs_calc_insert_metadata_size(fs_info, min_items) +
+			  btrfs_calc_delayed_ref_bytes(fs_info,
+					       BTRFS_UNLINK_METADATA_UNITS));
 
 	spin_lock(&sinfo->lock);
 	spin_lock(&block_rsv->lock);
-- 
2.34.1

