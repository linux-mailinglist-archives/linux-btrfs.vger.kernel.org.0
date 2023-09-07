Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 968657976DA
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Sep 2023 18:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240130AbjIGQRe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Sep 2023 12:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240805AbjIGQRF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Sep 2023 12:17:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE09678AB;
        Thu,  7 Sep 2023 08:46:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31DBBC32798;
        Thu,  7 Sep 2023 15:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694101427;
        bh=Bvcu73pIxp2qFPTD0gge5LZ4cNXLO+7TlPXeCdfmmWI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D4Lcwl9cSexsDYdI3+hzKxn7XmjbajUAGqL22M3OB7/TaprjbMfGsDte2JHp6fqY8
         r1V/h911XY7DKEXIQ1bClAJKfvsg2bOvRsftWWmzKwiTry3kgF9HkzNzI1Bm/9KXnO
         y/TYU/Zjrvp4D34GsnaE48vpUsogtepSLRDSJLgoINyPngULF84Epr/GzWHCghhIA3
         laCyArlcuaFecupJJQJdOQJ/RZJpqQcFiMLWp6Ww8SUaalltw1tbd52IdA07rloUp1
         Z/P/xnvBw84dXS6bZMZKC8rV9wrZPQLWUNJTJXU1HE90lvzDEIRyt5wLCH551mgona
         HXk5mqkRPW8zw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Qu Wenruo <wqu@suse.com>, David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>, clm@fb.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 5/6] btrfs: output extra debug info if we failed to find an inline backref
Date:   Thu,  7 Sep 2023 11:43:36 -0400
Message-Id: <20230907154338.3421582-5-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230907154338.3421582-1-sashal@kernel.org>
References: <20230907154338.3421582-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.2
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit 7f72f50547b7af4ddf985b07fc56600a4deba281 ]

[BUG]
Syzbot reported several warning triggered inside
lookup_inline_extent_backref().

[CAUSE]
As usual, the reproducer doesn't reliably trigger locally here, but at
least we know the WARN_ON() is triggered when an inline backref can not
be found, and it can only be triggered when @insert is true. (I.e.
inserting a new inline backref, which means the backref should already
exist)

[ENHANCEMENT]
After the WARN_ON(), dump all the parameters and the extent tree
leaf to help debug.

Link: https://syzkaller.appspot.com/bug?extid=d6f9ff86c1d804ba2bc6
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/extent-tree.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 21e48c422bc50..79a53676a3881 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -869,6 +869,11 @@ int lookup_inline_extent_backref(struct btrfs_trans_handle *trans,
 		err = -ENOENT;
 		goto out;
 	} else if (WARN_ON(ret)) {
+		btrfs_print_leaf(path->nodes[0]);
+		btrfs_err(fs_info,
+"extent item not found for insert, bytenr %llu num_bytes %llu parent %llu root_objectid %llu owner %llu offset %llu",
+			  bytenr, num_bytes, parent, root_objectid, owner,
+			  offset);
 		err = -EIO;
 		goto out;
 	}
-- 
2.40.1

