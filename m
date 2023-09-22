Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 525B47AAFA2
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Sep 2023 12:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233367AbjIVKhn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Sep 2023 06:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233386AbjIVKhi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Sep 2023 06:37:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B711BAC
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 03:37:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0A79C433CC
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 10:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695379051;
        bh=2mgkuHC6nbX2N7ujQgJtLXW/glxXe8o4C6CbkpHTuhM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ucVgmhFVxnRJ9I1texObxeCYMsQT67alxudMaLJ87+5gt0M+wHxpVbZbj5xLRgpKF
         RzJyGaKp03Vn0r5gGs92xgRb/kuHiDhxH2EAQHXMBQZTl8Wn6W06RdkLcnkHICbvGk
         Ysl8QQwyzzomFjhcB3OpxqfVWrbRqv+skbbVj+oD2cAHQfTmYmbAQVm9/Fuls8Bn69
         UrLnp4tDOgKHOeJLHCFzSe0y0nnUNZEII8+KtFMW+dvEaMjCYcxtP2zQV5+bWuQ8rz
         sZcNW6kY8Phbcp9DKkTv5Gv1urVUrw+rWYrBTDk6UybHyugfE8lUurfsffOax20LlY
         V51ZbsHvOgjdg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/8] btrfs: simplify error check condition at btrfs_dirty_inode()
Date:   Fri, 22 Sep 2023 11:37:19 +0100
Message-Id: <5d46b47eaa1ab5c82ad17cb4e3d59ddf9857ff4e.1695333082.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1695333082.git.fdmanana@suse.com>
References: <cover.1695333082.git.fdmanana@suse.com>
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

The following condition at btrfs_dirty_inode() is redundant:

  if (ret && (ret == -ENOSPC || ret == -EDQUOT))

The first check for a non-zero 'ret' value is pointless, we can simplify
this to simply:

  if (ret == -ENOSPC || ret == -EDQUOT)

Not only this makes it easier to read, it also slightly reduces the text
size of the btrfs kernel module:

  $ size fs/btrfs/btrfs.ko.before
     text	   data	    bss	    dec	    hex	filename
  1641400	 168265	  16864	1826529	 1bdee1	fs/btrfs/btrfs.ko.before

  $ size fs/btrfs/btrfs.ko.after
     text	   data	    bss	    dec	    hex	filename
  1641224	 168181	  16864	1826269	 1bdddd	fs/btrfs/btrfs.ko.after

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 514d2e8a4f52..f16dfeabeaf0 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6011,7 +6011,7 @@ static int btrfs_dirty_inode(struct btrfs_inode *inode)
 		return PTR_ERR(trans);
 
 	ret = btrfs_update_inode(trans, root, inode);
-	if (ret && (ret == -ENOSPC || ret == -EDQUOT)) {
+	if (ret == -ENOSPC || ret == -EDQUOT) {
 		/* whoops, lets try again with the full transaction */
 		btrfs_end_transaction(trans);
 		trans = btrfs_start_transaction(root, 1);
-- 
2.40.1

