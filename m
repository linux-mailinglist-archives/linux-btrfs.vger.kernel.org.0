Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCA756A4210
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Feb 2023 13:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjB0MyD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Feb 2023 07:54:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjB0MyD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Feb 2023 07:54:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFEF5B8E
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Feb 2023 04:54:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2093260DD4
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Feb 2023 12:54:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FF6EC4339B
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Feb 2023 12:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677502439;
        bh=g715SXzFk2vvCv+Ku3OK4iRFZXkaaxOltLN0NKzjS4s=;
        h=From:To:Subject:Date:From;
        b=JhYcFX790V7vz4owVmg+RLw5B6HApc1jW1VNUQ1I54xIh8+gS9vIletWbMl3UYyY5
         Z7B8IXrLJksyzHbVlVTyXxokorQCPocuqpCZRgX7EPY2zt8epPKEBAqrHflvl5A85G
         e3LTWGlrE4+6ihB580JATekHAqHbCs23gN7/2E89oOFPe0d1AZbrAM8KoHIaoyBl7s
         sPI5Oy2obWP1W45hNMRnDhzf6Kwwmlx27mDVeuhTaiJxh6U91T6hzlFaNaqrKqmPTH
         wVxV9rsuDKH+RU9uws3M4ZUCMNFtdTl1TXTu6G5iGSkVsRPNpGTDPl6lWPNQI0D3BO
         CUCxPuYKWY63Q==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix extent map logging bit not cleared for split maps after dropping range
Date:   Mon, 27 Feb 2023 12:53:56 +0000
Message-Id: <252e68aaa353859c8041305443a988866350cb3c.1677502380.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
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

At btrfs_drop_extent_map_range() we are clearing the EXTENT_FLAG_LOGGING
bit on a 'flags' variable that was not initialized. This makes static
checkers complain about it, so initialize the 'flags' variable before
clearing the bit.

In practice this has no consequences, because EXTENT_FLAG_LOGGING should
not be set when btrfs_drop_extent_map_range() is called, as an fsync locks
the inode in exclusive mode, locks the inode's mmap semaphore in exclusive
mode too and it always flushes all delalloc.

Also add a comment about why we clear EXTENT_FLAG_LOGGING on a copy of the
flags of the split extent map.

Reported-by: Dan Carpenter <error27@gmail.com>
Link: https://lore.kernel.org/linux-btrfs/Y%2FyipSVozUDEZKow@kili/
Fixes: db21370bffbc ("btrfs: drop extent map range more efficiently")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_map.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index be94030e1dfb..138afa955370 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -763,7 +763,13 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
 			goto next;
 		}
 
+		flags = em->flags;
 		clear_bit(EXTENT_FLAG_PINNED, &em->flags);
+		/*
+		 * In case we split the extent map, we want to preserve the
+		 * EXTENT_FLAG_LOGGING flag on our extent map, but we don't want
+		 * it on the new extent maps.
+		 */
 		clear_bit(EXTENT_FLAG_LOGGING, &flags);
 		modified = !list_empty(&em->list);
 
@@ -774,7 +780,6 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
 		if (em->start >= start && em_end <= end)
 			goto remove_em;
 
-		flags = em->flags;
 		gen = em->generation;
 		compressed = test_bit(EXTENT_FLAG_COMPRESSED, &em->flags);
 
-- 
2.34.1

