Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078E9509D0F
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Apr 2022 12:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388045AbiDUKGE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Apr 2022 06:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377263AbiDUKGC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Apr 2022 06:06:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A2125C47
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Apr 2022 03:03:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B589617F5
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Apr 2022 10:03:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7362EC385A1
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Apr 2022 10:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650535393;
        bh=J8n+ykGD1JFP5Db9OLXmpca+Uz6RKF8wo7UAvKP4I9k=;
        h=From:To:Subject:Date:From;
        b=TdU/3+MAU4JUHlJnBikY2xNw9E4/ST199JampLzVHwFOTtAENP+EvNwjlHyHoVZZM
         qAO6QkqwHm/XbmAeafg80Thd6sdBslgqrmNQS2Xtq/tcqpxLETIOf8SA2Qm7DjPyOQ
         BpcfZfOkoANKCjfRZHzvEk58yjh48UV5H5T3+LJ4TzP1C/oGb/XWw7CY4+F4TmN6fc
         ALusN3GV2hLe6qBu/7685EnUg5O+uGo/n0920j+htYF11xAN85SpbK/P8ZNAECRgQz
         8tX9jNQqwG1ci5TMw1xqLNlPvuVAuUtdZRFJcslWcnXYz53JFBReqjT/922XLemlYB
         iMLL+p9Pbpv+A==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: do not BUG_ON() on failure to update inode when setting xattr
Date:   Thu, 21 Apr 2022 11:03:09 +0100
Message-Id: <bf2fb575bc7b960b925693b9d64a802f4c477fc3.1650535321.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

We are doing a BUG_ON() if we fail to update an inode after setting (or
clearing) a xattr, but there's really no reason to not instead simply
abort the transaction and return the error to the caller. This should be
a rare error because we have previously reserved enough metadata space to
update the inode and the delayed inode should have already been setup, so
an -ENOSPC or -ENOMEM, which are the possible errors, are very unlikely to
happen.

So replace the BUG_ON()s with a transaction abort.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/xattr.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/xattr.c b/fs/btrfs/xattr.c
index f9d22ff3567f..4a2a5cb1c202 100644
--- a/fs/btrfs/xattr.c
+++ b/fs/btrfs/xattr.c
@@ -262,7 +262,8 @@ int btrfs_setxattr_trans(struct inode *inode, const char *name,
 	inode_inc_iversion(inode);
 	inode->i_ctime = current_time(inode);
 	ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
-	BUG_ON(ret);
+	if (ret)
+		btrfs_abort_transaction(trans, ret);
 out:
 	if (start_trans)
 		btrfs_end_transaction(trans);
@@ -401,7 +402,8 @@ static int btrfs_xattr_handler_set_prop(const struct xattr_handler *handler,
 		inode_inc_iversion(inode);
 		inode->i_ctime = current_time(inode);
 		ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
-		BUG_ON(ret);
+		if (ret)
+			btrfs_abort_transaction(trans, ret);
 	}
 
 	btrfs_end_transaction(trans);
-- 
2.35.1

