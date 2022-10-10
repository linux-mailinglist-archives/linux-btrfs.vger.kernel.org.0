Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E17D65F9CA3
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Oct 2022 12:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbiJJKWi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Oct 2022 06:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbiJJKWe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Oct 2022 06:22:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD0CA6B15D
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Oct 2022 03:22:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFF4860ED7
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Oct 2022 10:22:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2E43C433D7
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Oct 2022 10:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665397347;
        bh=vcWQDX1BRTC9RFf4yU2jDuyPIPNMF0Kc/dx+1tTHMpQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=e8qtv4ZJ4RpIJ4gjar2Qo95IPMhcRt4lD/IwF7d95O41uzX5ClDITMj7gcBXXFfH7
         iIMGqYbX9UAxbAipV3gnicecc1GpiydMCON3MDIDvxCDy7CRH4PsDjU6c8ZIF7jD5g
         prVdUV7iTT18aB7nZYEy8OtFXLoDQiFu6/3eCM8003A07uvlIXS4GyUYPeP2aw6gyS
         QHoMHyQc23yK2On/HwTJWkk0f1YDvgnBiB7Rctkp5hY/dToLcyqQZ2S/L985qkpdg4
         +3tjB0/Q+OCI7/JVE31VLTtBVKg+5cLCAKV3i6BtNlXFT7FrvEpOGTq7/8Ya/+OYIe
         689qeGojfG+Ow==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 04/18] btrfs: skip unnecessary extent map searches during fiemap and lseek
Date:   Mon, 10 Oct 2022 11:22:06 +0100
Message-Id: <767d0afc7bd89abcd067112b1f371ce650dc3059.1665396437.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1665396437.git.fdmanana@suse.com>
References: <cover.1665396437.git.fdmanana@suse.com>
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

