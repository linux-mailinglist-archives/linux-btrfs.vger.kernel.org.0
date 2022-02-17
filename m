Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603AE4B9FDC
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Feb 2022 13:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240305AbiBQMMe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Feb 2022 07:12:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240300AbiBQMMe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Feb 2022 07:12:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE77210FD5
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Feb 2022 04:12:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 68F5FB820E3
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Feb 2022 12:12:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9C21C340E8
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Feb 2022 12:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645099937;
        bh=ggSE2Y5/fDAcz1xnNDJZ+je9aKELLeaQ292XWRi9RSg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=bzgwqd1imxh9Vm4P3rKO0JcEAR9U1LGPz5EztSuRPQTCyWVXgHj77Fkk1+5emhruv
         /RS2Zl5+x1PlMI3tGVa5wvduVTptiDqPbzzAPv0w+DAk78YfeA4Ui67WvAu11mGj8j
         EVou1rANPhZKPMDohEXHeViKKvRK0tjw6Tipuml0gYAR4MThtM5uX/GlDeDBmd4lcH
         tSe0MYhFuB90f6mGl6bdlkQUDyuAbAUnnefF8414sIzzz6DrxBq7xdqd4x87/9ZK1Z
         z09j77nFUHBM0KIMh8j4rrX4E1OLfcMHLNfwY0TWCSJGl6NLZxpZ6xSTUmG1sirKPc
         WXjxsAYfHwZfw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 6/7] btrfs: fix unexpected error path when reflinking an inline extent
Date:   Thu, 17 Feb 2022 12:12:07 +0000
Message-Id: <4a322b829083a9ec4433621af1a5dcd6a584f92a.1645098951.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1645098951.git.fdmanana@suse.com>
References: <cover.1645098951.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When reflinking an inline extent, we assert that its file offset is 0 and
that its uncompressed length is not greater than the sector size. We then
return an error if one of those conditions is not satisfied. However we
use a return statement, which results in returning from btrfs_clone()
without freeing the path and buffer that were allocated before, as well as
not clearing the flag BTRFS_INODE_NO_DELALLOC_FLUSH for the destination
inode.

Fix that by jumping to the 'out' label instead, and also add a WARN_ON()
for each condition so that in case assertions are disabled, we get to
known which of the unexpected conditions triggered the error.

Fixes: a61e1e0df9f321 ("Btrfs: simplify inline extent handling when doing reflinks")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/reflink.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index cdcfeab82e12..07e19e069c84 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -505,8 +505,11 @@ static int btrfs_clone(struct inode *src, struct inode *inode,
 			 */
 			ASSERT(key.offset == 0);
 			ASSERT(datal <= fs_info->sectorsize);
-			if (key.offset != 0 || datal > fs_info->sectorsize)
-				return -EUCLEAN;
+			if (WARN_ON(key.offset != 0) ||
+			    WARN_ON(datal > fs_info->sectorsize)) {
+				ret = -EUCLEAN;
+				goto out;
+			}
 
 			ret = clone_copy_inline_extent(inode, path, &new_key,
 						       drop_start, datal, size,
-- 
2.33.0

