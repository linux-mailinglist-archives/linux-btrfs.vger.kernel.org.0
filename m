Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D92F520120
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 May 2022 17:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238318AbiEIPdN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 May 2022 11:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238213AbiEIPdM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 May 2022 11:33:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1101FA4A
        for <linux-btrfs@vger.kernel.org>; Mon,  9 May 2022 08:29:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 31B5E61180
        for <linux-btrfs@vger.kernel.org>; Mon,  9 May 2022 15:29:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 118C9C385AE
        for <linux-btrfs@vger.kernel.org>; Mon,  9 May 2022 15:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652110157;
        bh=Iu14NSTbNQEyoYLUOuKZHiO7vr/aMYiBjW2PBKI06GA=;
        h=From:To:Subject:Date:From;
        b=YhAhM+Sm60SDM0SpYqtPn5zEvOGwGwI8DRGhXRtOWvnt5NG4l5lyC/E/+Jvl4zO8g
         rpGjJeU/d0RFqtccC11dAsZDAQiFL42M7tHXftk39CaZV7mF9ZOdHbAydPOmNofTNA
         Uz3TN8cPI4aH+2bsGvJVyCEurekzI37VRPFs7u8Rc1jZCNM+IQ3qex+wsVuE8qYySM
         qgT565O0UNTx2Huw5OX13fcJVeJiFaLBp9b4iKbVRhV95AUxV/9843oQ2DJ6mYdUy4
         RkEk95x5xCDQ8km5icm2hmE35QPltowwDCKvkhXdPvx9kcDOaxBKia0lq6xztUWVJS
         K5duziNmZVS6Q==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: do not account twice for inode ref when reserving metadata units
Date:   Mon,  9 May 2022 16:29:14 +0100
Message-Id: <bf988d76ebcb9003a16c6b3cd5d25ca94872b93e.1652109795.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
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

When reserving metadata units for creating an inode, we don't need to
reserve one extra unit for the inode ref item because when creating the
inode, at btrfs_create_new_inode(), we always insert the inode item and
the inode ref item in a single batch (a single btree insert operation,
and both ending up in the same leaf).

As we have accounted already one unit for the inode item, the extra unit
for the inode ref item is superfluous, it only makes us reserve more
metadata than necessary and often adding more reclaim pressure if we are
low on available metadata space.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b42d6e7e4049..adc8b684fe31 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6138,12 +6138,15 @@ int btrfs_new_inode_prepare(struct btrfs_new_inode_args *args,
 		(*trans_num_items)++;
 	} else {
 		/*
-		 * 1 to add inode ref
 		 * 1 to add dir item
 		 * 1 to add dir index
 		 * 1 to update parent inode item
+		 *
+		 * No need for 1 unit for the inode ref item because it is
+		 * inserted in a batch together with the inode item at
+		 * btrfs_create_new_inode().
 		 */
-		*trans_num_items += 4;
+		*trans_num_items += 3;
 	}
 	return 0;
 }
-- 
2.35.1

