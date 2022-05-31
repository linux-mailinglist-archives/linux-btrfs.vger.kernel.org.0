Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D33553939C
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 May 2022 17:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345493AbiEaPGw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 May 2022 11:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241907AbiEaPGv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 May 2022 11:06:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A441DBD
        for <linux-btrfs@vger.kernel.org>; Tue, 31 May 2022 08:06:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB0996132A
        for <linux-btrfs@vger.kernel.org>; Tue, 31 May 2022 15:06:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C570CC3411E
        for <linux-btrfs@vger.kernel.org>; Tue, 31 May 2022 15:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654009609;
        bh=zyWZWw0u5c8OJRwjsYKuTxT+ypJfPgNGLyxJ94G3hE4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ONWwp3bqgx/njdrcb7Hy86cYEZUk3aCg0M2UaFI605FVki/F2pn9+JQKnGSQuW38U
         0WQ6pQd6RpNA8ZskTnR9/cyKetZxtlWM2y7zvBKLWjJKhSMZnmYgKoD1QTctJP8EkF
         xhmONKSpEp/IKn2L1k67vXoO5NSgIkl/ETU6KaIqirmosnPsLwoz1Bh2TPW1MJjmbG
         7OShM56EVk91zEWO5z6G2jwA2qyrOGyNaRu/AMFlxWe3C2CtvjWJa8t/yppH4RLtiy
         Q+7o2YS6WST4K0BECiOVqgCYLTI80d1Jm+kfWedttXHi+XgUF0slvIbyUdzZzpXK5R
         owRObwF7zNcYQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 02/12] btrfs: free the path earlier when creating a new inode
Date:   Tue, 31 May 2022 16:06:33 +0100
Message-Id: <b3c7ae5b6d09c442fc7546660dd5535302d11a7e.1654009356.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1654009356.git.fdmanana@suse.com>
References: <cover.1654009356.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When creating an inode, through btrfs_create_new_inode(), we release the
path we allocated before once we don't need it anymore. But we keep it
allocated until we return from that function, which is wasteful because
after we release the path we do several things that can allocate yet
another path: inheriting properties, setting the xattrs used by ACLs and
secutiry modules, adding an orphan item (O_TMPFILE case) or adding a
dir item (for the non-O_TMPFILE case).

So instead of releasing the path once we don't need it anymore, free it
instead. This way we avoid having two paths allocated until we return
from btrfs_create_new_inode().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 06d5bfa84d38..3ede3e873c2a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6380,7 +6380,13 @@ int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
 	}
 
 	btrfs_mark_buffer_dirty(path->nodes[0]);
-	btrfs_release_path(path);
+	/*
+	 * We don't need the path anymore, plus inheriting properties, adding
+	 * ACLs, security xattrs, orphan item or adding the link, will result in
+	 * allocating yet another path. So just free our path.
+	 */
+	btrfs_free_path(path);
+	path = NULL;
 
 	if (args->subvol) {
 		struct inode *parent;
@@ -6437,8 +6443,7 @@ int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
 		goto discard;
 	}
 
-	ret = 0;
-	goto out;
+	return 0;
 
 discard:
 	/*
-- 
2.35.1

