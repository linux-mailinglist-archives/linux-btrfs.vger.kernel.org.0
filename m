Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 938B774613F
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jul 2023 19:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbjGCRPu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jul 2023 13:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbjGCRPs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Jul 2023 13:15:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302C8E4C
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jul 2023 10:15:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1E7B60FD6
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jul 2023 17:15:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DF45C433C9
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jul 2023 17:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688404536;
        bh=vjz+ExGsPR7PWZe80AUws7WBxS1ydcPZlqHwIdQZNzw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=p3P34J2ksBCY8QIhEOxCAssjwIzeUW6eqji8/leTvzflX5mZ/p+XP9JAo833xjaXW
         ylhgPHYIHaUhfXxXBZ/BpV5VuXyspwyNbsS51TqQbqXxXUUthPdAjbWH1xSdU7Guza
         PE7OhBXXa0FuJve+BzP4cXKQaYiEDsFBcxlirS1nlkzMDV38b8NvHsTcITgzXZZK/H
         DpJPeVILIHd3+dTfJPxnN4pFVlKsbNUgfG2/1X8fyEFbDKeC0liBxyH6H3pmaDcx6S
         k/oHEZpkRVdMp+WIhbrWSrgt5/gvp7wUJ3tBF3qcQGLPuvdYqm73O0MjoUYmYO1e/d
         9L8lLqkbNsAYQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: fix double iput() on inode after an error during orphan cleanup
Date:   Mon,  3 Jul 2023 18:15:30 +0100
Message-Id: <e20676cb8b120f12892f1e6ed80d91ec551ed533.1688403622.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1688403622.git.fdmanana@suse.com>
References: <cover.1688403622.git.fdmanana@suse.com>
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

At btrfs_orphan_cleanup(), if we were able to find the inode, we do an
iput() on the inode, then if btrfs_drop_verity_items() succeeds and then
either btrfs_start_transaction() or btrfs_del_orphan_item() fail, we do
another iput() in the respective error paths, resulting in an extra iput()
on the inode.

Fix this by setting inode to NULL after the first iput(), as iput()
ignores a NULL inode pointer argument.

Fixes: a13bb2c03848 ("btrfs: add missing iputs on orphan cleanup failure")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index dbbb67293e34..d919318d2498 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3728,6 +3728,7 @@ int btrfs_orphan_cleanup(struct btrfs_root *root)
 			if (!ret) {
 				ret = btrfs_drop_verity_items(BTRFS_I(inode));
 				iput(inode);
+				inode = NULL;
 				if (ret)
 					goto out;
 			}
-- 
2.34.1

