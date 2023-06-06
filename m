Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862BF7245DB
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jun 2023 16:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237347AbjFFO02 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Jun 2023 10:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236741AbjFFO0Z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Jun 2023 10:26:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D9E10DF
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Jun 2023 07:26:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5154461261
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Jun 2023 14:26:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29B59C433D2
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Jun 2023 14:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686061568;
        bh=k60bJz2VB6bYM/XJpRL+08e2f5aUrPlDxgrFFzPOqX8=;
        h=From:To:Subject:Date:From;
        b=pi2dhxjl6Cu4yJx+A+v5TOnbjMCH2t+UqxUb9OXXBAtX/VcYcY/ZeDJvl9wSQWZB9
         sMYNrcWX5cgp0XoSHd4o+8CB6JGmDNgPRjL22TxZlxShmIvNpHaR9rjuCZhCnpECFJ
         drFFEHNVi1BUXKOK5RpdqEzM7hVhaxxeVa4khflUCwRZSM+zJ1/9jbo6gkz64bDaOr
         l1Cf9HRT4Dr6PgmxrVNzXRWQgEpJxg/xD0HcmfIL5qgv8T8S2YwS1YYkOH827eRXJ2
         Ha2U7HK/kME/vse5WbNa7FL5m5pSiCVHma+bIgMv3rsovO2uPHOfpWcmH/IcKp4Jx3
         QSOBwu0uW3MEw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: update documentation for a block group's bg_list member
Date:   Tue,  6 Jun 2023 15:26:03 +0100
Message-Id: <148d635697bfb4ac3f9010526a6d79b8ee34316d.1686061295.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Currently we are only documentating two uses of the bg_list member of a
block group, but there two more:

1) To track deleted block groups for discard purposes, introduced in
   commit e33e17ee1098 ("btrfs: add missing discards when unpinning
   extents with -o discard");

2) To track block groups for automatic reclaim, introduced more recently
   by commit 18bb8bbf13c1 ("btrfs: zoned: automatically reclaim zones")

So document those two other use cases.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-group.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index cc0e4b37db2d..f204addc3fe8 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -162,7 +162,14 @@ struct btrfs_block_group {
 	 */
 	struct list_head cluster_list;
 
-	/* For delayed block group creation or deletion of empty block groups */
+	/*
+	 * Used for several lists:
+	 *
+	 * 1) struct btrfs_fs_info::unused_bgs
+	 * 2) struct btrfs_fs_info::reclaim_bgs
+	 * 3) struct btrfs_transaction::deleted_bgs
+	 * 4) struct btrfs_trans_handle::new_bgs
+	 */
 	struct list_head bg_list;
 
 	/* For read-only block groups */
-- 
2.34.1

