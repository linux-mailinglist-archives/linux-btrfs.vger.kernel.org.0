Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 514D9743E39
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Jun 2023 17:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232913AbjF3PEI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Jun 2023 11:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232912AbjF3PEB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Jun 2023 11:04:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D393A81
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Jun 2023 08:04:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 347FF6172A
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Jun 2023 15:04:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23BEBC433C0
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Jun 2023 15:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688137439;
        bh=ivHtQptqMfl+ndj+8oUdtx7QVtWyxt9fnx8gXfHGrrk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=tj3W38/kCLapH+nFwmgmXFSutMGhPblmWNjjvtySOh2ihPz2z3Snuf7fVcHZ4oqSW
         7PwaqRw9ierxPPXlo5HAkLQ7/2mvp4XY8srQliSRbu4O1C3W1v+71yttyXD+VM172M
         zQ9FA6uAFwjFC8JmwrL9SIjd1gC/JpCevBJl0S6HcIdhkZjkSj4kQI8HuX+d971nPv
         P4mZ2TbfiXt1X2iX7ZSRjc5vgpmaC4CNiEIQ0xPVzW93jRSnEz3ipATnknqzhe6UjH
         4Lzde6fL++NhYuJN6GwecjoJQVhZWxXji4YHVXW99ZRUdFKK2Iie8VdTD6Nol5HvwJ
         VfTk/+ksour9w==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 5/8] btrfs: make btrfs_destroy_pinned_extent() return void
Date:   Fri, 30 Jun 2023 16:03:48 +0100
Message-Id: <1ad2d3a2dbe9cc6d0bb7fabf3dde1b673b617314.1688137156.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1688137155.git.fdmanana@suse.com>
References: <cover.1688137155.git.fdmanana@suse.com>
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

Currently btrfs_destroy_pinned_extent() is always returning 0 no matter
what and its caller ignores its return value (as well everything up in
the call chain). This is because this is called in the transaction abort
path, where we can't even deal with any errors since we are in a critical
situation already and cleanup of resources is done in a best effort
fashion.

So make btrfs_destroy_pinned_extent() return void.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/disk-io.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index cfff53cbb72a..894096d42efc 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4727,12 +4727,11 @@ static void btrfs_destroy_marked_extents(struct btrfs_fs_info *fs_info,
 	}
 }
 
-static int btrfs_destroy_pinned_extent(struct btrfs_fs_info *fs_info,
-				       struct extent_io_tree *unpin)
+static void btrfs_destroy_pinned_extent(struct btrfs_fs_info *fs_info,
+					struct extent_io_tree *unpin)
 {
 	u64 start;
 	u64 end;
-	int ret;
 
 	while (1) {
 		struct extent_state *cached_state = NULL;
@@ -4744,9 +4743,8 @@ static int btrfs_destroy_pinned_extent(struct btrfs_fs_info *fs_info,
 		 * the same extent range.
 		 */
 		mutex_lock(&fs_info->unused_bg_unpin_mutex);
-		ret = find_first_extent_bit(unpin, 0, &start, &end,
-					    EXTENT_DIRTY, &cached_state);
-		if (ret) {
+		if (find_first_extent_bit(unpin, 0, &start, &end,
+					  EXTENT_DIRTY, &cached_state)) {
 			mutex_unlock(&fs_info->unused_bg_unpin_mutex);
 			break;
 		}
@@ -4757,8 +4755,6 @@ static int btrfs_destroy_pinned_extent(struct btrfs_fs_info *fs_info,
 		mutex_unlock(&fs_info->unused_bg_unpin_mutex);
 		cond_resched();
 	}
-
-	return 0;
 }
 
 static void btrfs_cleanup_bg_io(struct btrfs_block_group *cache)
-- 
2.34.1

