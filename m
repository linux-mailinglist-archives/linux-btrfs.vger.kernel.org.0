Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C705684E7
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Jul 2022 12:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbiGFKO3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Jul 2022 06:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbiGFKO2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Jul 2022 06:14:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B0163EA
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Jul 2022 03:14:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B99A461DAF
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Jul 2022 10:14:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91D83C3411C
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Jul 2022 10:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657102467;
        bh=/s+9f65CS68u1kRUmU1x4aZqhfAp3e0QkUchqX7ivb4=;
        h=From:To:Subject:Date:From;
        b=tSC4WLnifP65iO4ct/8iCZ+uc4LHp8BX94f9PaMy+sR9P3t7DO5Jds1s3UhTN79Gn
         uFexk3DO7HAI0YcKw7jZdzdNmoJzSHfJLLloQUkK8qYVAd6cCkJc9W/uMglvdGYres
         vvd+H1AvoWNgWLN6HBR0ij31jghx/EkfddVa13cY2QTCqvkhRbfH5BZW+2Y8l3UtIq
         IKxXhhGZ0DeXovmPMubDeAfGCCdZ3P5rus3JZBQ1yBKpjIavpdD6sBbFkWX40Bri9W
         L+LTX7BbUkkXfIi9ay6WPpMJzzyl8UBXxHACARB0wxO+WkMWiGVeGg6tDjYa5chkJc
         b4H1YjRW76PDg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: remove the inode cache check at btrfs_is_free_space_inode()
Date:   Wed,  6 Jul 2022 11:14:23 +0100
Message-Id: <41a45a354624cbe3bc1ccfb100af7699e73090d3.1657102391.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The inode cache feature was removed in kernel 5.11, and we no longer have
any code that reads from or writes to inode caches. We may still mount a
filesystem that has inode caches, but they are ignored.

Remove the check for an inode cache from btrfs_is_free_space_inode(),
since we no longer have code to trigger reads from an inode cache or
writes to an inode cache. The check at send.c is still needed, because
in case we find a filesystem with an inode cache, we must ignore it.
Also leave the checks at tree-checker.c, as they are sanity checks.

This eliminates a dead branch and reduces the amount of code since it's
in an inline function.

Before:

$ size fs/btrfs/btrfs.ko
   text	   data	    bss	    dec	    hex	filename
1620662	 189240	  29032	1838934	 1c0f56	fs/btrfs/btrfs.ko

After:

$ size fs/btrfs/btrfs.ko
   text	   data	    bss	    dec	    hex	filename
1620502	 189240	  29032	1838774	 1c0eb6	fs/btrfs/btrfs.ko

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/btrfs_inode.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 33811e896623..b467264bd1bb 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -305,8 +305,7 @@ static inline bool btrfs_is_free_space_inode(struct btrfs_inode *inode)
 	if (root == root->fs_info->tree_root &&
 	    btrfs_ino(inode) != BTRFS_BTREE_INODE_OBJECTID)
 		return true;
-	if (inode->location.objectid == BTRFS_FREE_INO_OBJECTID)
-		return true;
+
 	return false;
 }
 
-- 
2.35.1

