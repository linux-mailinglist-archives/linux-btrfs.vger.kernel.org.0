Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89A007975FE
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Sep 2023 18:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235180AbjIGQA6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Sep 2023 12:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240597AbjIGP7E (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Sep 2023 11:59:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0854206;
        Thu,  7 Sep 2023 08:47:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2A51C4E666;
        Thu,  7 Sep 2023 15:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694101453;
        bh=+BEPD6u+gxhxVI13q7p6Rjsl5gPTFoVOpNbxuO4aMcI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R0JOBgZHIqlVKYbYg0i4ZxK3tLM1iY5IFNwvmodHRZ8frImIQWRvZIxy8wdwHkkCA
         fS8BoLsvCoQDkYBTaf09PcdEic6aJM5O0RzzsAXXhgCwsn3odlZNdDIL3aWU4uKzfP
         ARSricpsfV/o/Pca0QZhVJ4qzpkXH5rnCt+CIBFb4cBrI19m9f7C/rMCE/Pajknx+C
         Kg0Z8AClLBRStnHIrDtXZqkIAGOT3e3S70OijXwf4uMubSP7RmecJK6Yyh6keGyD5j
         NudTLK4KSVCjmV3PtzaVvMY8tgpKVaAcIwQ2rc6eYkcZzdxHyAREwryI/rZW1vmfmn
         9GjYaMDif4NcA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Qu Wenruo <wqu@suse.com>, David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>, clm@fb.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 2/3] btrfs: output extra debug info if we failed to find an inline backref
Date:   Thu,  7 Sep 2023 11:44:07 -0400
Message-Id: <20230907154408.3421918-2-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230907154408.3421918-1-sashal@kernel.org>
References: <20230907154408.3421918-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.131
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
index 597cc2607481c..48f2de789b755 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -860,6 +860,11 @@ int lookup_inline_extent_backref(struct btrfs_trans_handle *trans,
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

