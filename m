Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8558579785F
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Sep 2023 18:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243680AbjIGQqg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Sep 2023 12:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242946AbjIGQqV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Sep 2023 12:46:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F713AA6;
        Thu,  7 Sep 2023 09:21:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A29C3C4E684;
        Thu,  7 Sep 2023 15:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694101483;
        bh=mV70Cn1O6GxelLkejgcT/F5+bEGe4b38w9qaFFojAYU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fm9WQSH4yha+y0taIU4Rw5bFMV+FSsGUDuwG5vfiFSIel98GS5LXaDgqm/jQ/Rx8m
         2xj5GmTHRvhq3k0goMOZVLwdQ31D/ImGk+SK3D2EHFID+RaizPY9QZ4JGveeDgBks7
         peuC+HOPC7ZRFBvzuJ9Wi4zxM6vL5f6VriBrDyTIkeO4GxjBL0th+MIuQP5k0Fd+Nj
         lak9BUs8nzQ/JsSEgbC96adroMBUiYFeOUumhcc2AFIBmC2Qhr47PbugcHh8iFGk5g
         IxCJXp+W2jV8Ic1CpBhLfmJgbagZXy1nKJYwEho/M0HDTszEs6YaB5msb+h7yZB8EQ
         J79UtDpx67DVw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Qu Wenruo <wqu@suse.com>, David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>, clm@fb.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 2/2] btrfs: output extra debug info if we failed to find an inline backref
Date:   Thu,  7 Sep 2023 11:44:36 -0400
Message-Id: <20230907154438.3422099-2-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230907154438.3422099-1-sashal@kernel.org>
References: <20230907154438.3422099-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.14.325
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
index e59987385673f..deb01e59da027 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1703,6 +1703,11 @@ int lookup_inline_extent_backref(struct btrfs_trans_handle *trans,
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

