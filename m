Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D58743E36
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Jun 2023 17:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232692AbjF3PEG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Jun 2023 11:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbjF3PEB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Jun 2023 11:04:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3AD35BC
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Jun 2023 08:03:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 410616174C
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Jun 2023 15:03:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EBACC433C8
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Jun 2023 15:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688137438;
        bh=J81gEfnY4Uvmb8q487ovPK0oBCmU529ztpYwpuow32A=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=I0z4HkbYrdIB8F8VVCx4zyKV73kQBWANflgH2vp5cSpBk5HFrvu8PdtQjAlGso3q6
         MbVaXnfAiTfmDyf4U/0GiD6MQFrDzbtq35YtHqHQxegSDrCcFx6EyjM9Mcks2eVq1m
         woXNoDWs66k2cNsYdYZRabTMpwSacdCcte3rdzVA28XChp8CqXgfDFIyTNevxfNlJG
         /ZHQNqb8CYFWPHnx75wS3GMy8X6PJxMhsC60pM6rI9r3uQFIZfnD1x4FDpXWnV+Gen
         ATZxuW2F9772E9SoI+2J8YAIxQ5GPv1qBvSpas6E3TQgrv4oSAPefbcWqcqgr/+0Pi
         aL3Z4e9E1jVpg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 4/8] btrfs: make btrfs_destroy_marked_extents() return void
Date:   Fri, 30 Jun 2023 16:03:47 +0100
Message-Id: <0112ac1b52085a3123574624feeec5838dd619f7.1688137156.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1688137155.git.fdmanana@suse.com>
References: <cover.1688137155.git.fdmanana@suse.com>
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

Currently btrfs_destroy_marked_extents() is returning the value of the
last call to find_first_extent_bit(), which returns a value of 1 meaning
no more ranges found the dirty pages io tree. This value is useless to the
single caller of btrfs_destroy_marked_extents(), which ignores any return
value from btrfs_destroy_marked_extents(). This is because it's only used
in the transaction abort path, where we can't even deal with any errors
since we are in a critical situation already and cleanup of resources is
done in a best effort fashion.

So make btrfs_destroy_marked_extents() return void.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/disk-io.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 7513388b0567..cfff53cbb72a 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4700,21 +4700,16 @@ static void btrfs_destroy_all_delalloc_inodes(struct btrfs_fs_info *fs_info)
 	spin_unlock(&fs_info->delalloc_root_lock);
 }
 
-static int btrfs_destroy_marked_extents(struct btrfs_fs_info *fs_info,
-					struct extent_io_tree *dirty_pages,
-					int mark)
+static void btrfs_destroy_marked_extents(struct btrfs_fs_info *fs_info,
+					 struct extent_io_tree *dirty_pages,
+					 int mark)
 {
-	int ret;
 	struct extent_buffer *eb;
 	u64 start = 0;
 	u64 end;
 
-	while (1) {
-		ret = find_first_extent_bit(dirty_pages, start, &start, &end,
-					    mark, NULL);
-		if (ret)
-			break;
-
+	while (!find_first_extent_bit(dirty_pages, start, &start, &end,
+				      mark, NULL)) {
 		clear_extent_bits(dirty_pages, start, end, mark);
 		while (start <= end) {
 			eb = find_extent_buffer(fs_info, start);
@@ -4730,8 +4725,6 @@ static int btrfs_destroy_marked_extents(struct btrfs_fs_info *fs_info,
 			free_extent_buffer_stale(eb);
 		}
 	}
-
-	return ret;
 }
 
 static int btrfs_destroy_pinned_extent(struct btrfs_fs_info *fs_info,
-- 
2.34.1

