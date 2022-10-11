Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70E2B5FB233
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Oct 2022 14:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiJKMRV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Oct 2022 08:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiJKMRT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Oct 2022 08:17:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35BE753D3A
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 05:17:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C275460AF5
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 12:17:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB12CC433C1
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 12:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665490637;
        bh=vcWQDX1BRTC9RFf4yU2jDuyPIPNMF0Kc/dx+1tTHMpQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=hE0HHPUBd4uByGasE8OQzhljyjP43uw/FEPwjDBL9mZG4pS8dcVc2LzKwJxAneUUx
         OEzdTEIRWXxR2YkfjGfvd2DDTd7X7B1vh8OoSjWLb695Z6acOJzVH+bUEPrJqzyej6
         AEwkxN2hazXiZZOyuRNTSrEr8HUIccs77Zl3XROrklepWhetz4yso63etSMP8mczlG
         f/8kx0bQq3vFmvtm0n1zvTV8/8ON7QasraZNwdCRiEecPXsskh4lSceguIYc1gjf9n
         05enUtOtXu70E4sYiE/SyUcXnq+42a9x/So5GpB0/mDMgr3zrh+fe7qfTmEYPXH5Lr
         lIwQ3mm7N2Ulg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 05/19] btrfs: skip unnecessary extent map searches during fiemap and lseek
Date:   Tue, 11 Oct 2022 13:16:55 +0100
Message-Id: <b8bac9802fe36db318dcbc49f7155e123108e0b5.1665490018.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1665490018.git.fdmanana@suse.com>
References: <cover.1665490018.git.fdmanana@suse.com>
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

If we have no outstanding extents it means we don't have any extent maps
corresponding to delalloc that is flushing, as when an ordered extent is
created we increment the number of outstanding extents to 1 and when we
remove the ordered extent we decrement them by 1. So skip extent map tree
searches if the number of outstanding ordered extents is 0, saving time as
the tree is not empty if we have previously made some reads or flushed
delalloc, as in those cases it can have a very large number of extent maps
for files with many extents.

This helps save time when processing a file range corresponding to a hole
or prealloc (unwritten) extent.

The next patch in the series has a performance test in its changelog and
its subject is:

    "btrfs: skip unnecessary delalloc search during fiemap and lseek"

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/file.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 4a9a2e660b42..36618ddadc5f 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3534,6 +3534,18 @@ static bool find_delalloc_subrange(struct btrfs_inode *inode, u64 start, u64 end
 	if (delalloc_len > 0)
 		*delalloc_end_ret = *delalloc_start_ret + delalloc_len - 1;
 
+	spin_lock(&inode->lock);
+	if (inode->outstanding_extents == 0) {
+		/*
+		 * No outstanding extents means we don't have any delalloc that
+		 * is flushing, so return the unflushed range found in the io
+		 * tree (if any).
+		 */
+		spin_unlock(&inode->lock);
+		return (delalloc_len > 0);
+	}
+	spin_unlock(&inode->lock);
+
 	/*
 	 * Now also check if there's any extent map in the range that does not
 	 * map to a hole or prealloc extent. We do this because:
-- 
2.35.1

