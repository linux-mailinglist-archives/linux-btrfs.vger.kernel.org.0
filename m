Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628266C3009
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 12:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjCULPH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Mar 2023 07:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbjCULOz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Mar 2023 07:14:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505482CC66
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 04:14:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C28961B04
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 11:14:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2690C433D2
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 11:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679397263;
        bh=fgYWrVixBIstXE1DwaAX2tdD7DI2fyiLH37lLmoykHM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=dscPSf4NKz3fHVVGJQKvUx1O2xiagy140RqM/r7i80kg7yuSk7cBRAduQZvkIkUYW
         hLWILiFFp1siFkEvZP0mFlTQIR8y0GYsAondXReAlJ1rxw9yGH/qdbrsklNxI/Fxxi
         W8Rn/vXf0DLr7yLxtRpfBlzEpGeh5NZsZnxeEHhHpduXcGAelF2Fi6n4b6zWuJip+L
         dDZCww4/vjr4Gz28ZG9V7SZd8yIW4ht3eSCdH3vnjMoMevtxFHbbvHyWBjOlNdalpu
         ikd8Zr5RfZ+1oRaOpHV9svsIqUS1wOGYyKnX5/eh9f55pAyqi/oIKBgYvy9sF9DgxU
         YVILeWjAHldHw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 21/24] btrfs: fix calculation of the global block reserve's size
Date:   Tue, 21 Mar 2023 11:13:57 +0000
Message-Id: <30080cbfbfcb835e8c1cbd6762afa464a7b6454c.1679326434.git.fdmanana@suse.com>
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

At btrfs_update_global_block_rsv(), we are assuming an unlink operation
uses 5 metadata units, but that's not true anymore, it uses 6 since the
commit bca4ad7c0b54 ("btrfs: reserve correct number of items for unlink
and rmdir"). So update the code and comments to consider 6 units.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-rsv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
index 90b8088e8fac..6edcb32ed4c9 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -350,14 +350,14 @@ void btrfs_update_global_block_rsv(struct btrfs_fs_info *fs_info)
 
 	/*
 	 * But we also want to reserve enough space so we can do the fallback
-	 * global reserve for an unlink, which is an additional 5 items (see the
+	 * global reserve for an unlink, which is an additional 6 items (see the
 	 * comment in __unlink_start_trans for what we're modifying.)
 	 *
 	 * But we also need space for the delayed ref updates from the unlink,
-	 * so its 10, 5 for the actual operation, and 5 for the delayed ref
+	 * so its 12, 6 for the actual operation, and 6 for the delayed ref
 	 * updates.
 	 */
-	min_items += 10;
+	min_items += 12;
 
 	num_bytes = max_t(u64, num_bytes,
 			  btrfs_calc_insert_metadata_size(fs_info, min_items));
-- 
2.34.1

