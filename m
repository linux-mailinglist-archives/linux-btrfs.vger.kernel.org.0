Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51CA94C71B6
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Feb 2022 17:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237910AbiB1QaR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Feb 2022 11:30:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiB1QaQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Feb 2022 11:30:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1359517F5
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Feb 2022 08:29:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 90669B80FEA
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Feb 2022 16:29:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6A78C340F0
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Feb 2022 16:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646065774;
        bh=NWPA5wPrzJI938aO+LuHb8tPBLqBzNL60w/FsSE2tUE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=cfUe7X8K5AxHiV6aBCPT1MkYdz4jorPGbBcWDKgJqGd7EZQyHPbI1Y+ePXieUne++
         gXW/TQtV2wi0AOwTOBpQVVYIdqwNrfYLmPobrFDbhRX/nQ8uOchNQI5XiXXSrzqDAS
         dh/stQkB6M1+JjLdocO3t4ZoIQr5TZsvlqSA55newcLyARv1bOm8QozmDUabbfpthI
         9S8gvpZzo8P4lqOg+KE31kRS2Y/Jx0kErJl3+ZPMJjpptk4TATyIByHTajJkA37ugz
         echO1zT3NgsI/3JPNZp9kc0qDjt3nKbYuV0AMEE64ULNFjg4XYhSytz7GJTktcB7pd
         zaejICZKuwfVg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: add missing run of delayed items after unlink during log replay
Date:   Mon, 28 Feb 2022 16:29:28 +0000
Message-Id: <168fc1cc179d960ed47173cf47e8274e37611f96.1646064823.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1646064823.git.fdmanana@suse.com>
References: <cover.1646064823.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

During log replay, whenever we need to check if a name (dentry) exists in
a directory we do searches on the subvolume tree for inode references or
or directory entries (BTRFS_DIR_INDEX_KEY keys, and BTRFS_DIR_ITEM_KEY
keys as well, before kernel 5.17). However when during log replay we
unlink a name, through btrfs_unlink_inode(), we may not delete inode
references and dir index keys from a subvolume tree and instead just add
the deletions to the delayed inode's delayed items, which will only be
run when we commit the transaction used for log replay. This means that
after an unlink operation during log replay, if we attempt to search for
the same name during log replay, we will not see that the name was already
deleted, since the deletion is recorded only on the delayed items.

We run delayed items after every unlink operation during log replay,
except at unlink_old_inode_refs() and at add_inode_ref(). This was due
to an overlook, as delayed items should be run after evert unlink, for
the reasons stated above.

So fix those two cases.

Fixes: 0d836392cadd5 ("Btrfs: fix mount failure after fsync due to hard link recreation")
Fixes: 1f250e929a9c9 ("Btrfs: fix log replay failure after unlink and link combination")
CC: stable@vger.kernel.org # 4.19+
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 73ecc4f67a23..ad2da46bca0d 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -1344,6 +1344,15 @@ static int unlink_old_inode_refs(struct btrfs_trans_handle *trans,
 						 inode, name, namelen);
 			kfree(name);
 			iput(dir);
+			/*
+			 * Whenever we need to check if a name exists or not, we
+			 * check the subvolume tree. So after an unlink we must
+			 * run delayed items, so that future checks for a name
+			 * during log replay see that the name does not exists
+			 * anymore.
+			 */
+			if (!ret)
+				ret = btrfs_run_delayed_items(trans);
 			if (ret)
 				goto out;
 			goto again;
@@ -1596,6 +1605,15 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
 				 */
 				if (!ret && inode->i_nlink == 0)
 					inc_nlink(inode);
+				/*
+				 * Whenever we need to check if a name exists or
+				 * not, we check the subvolume tree. So after an
+				 * unlink we must run delayed items, so that future
+				 * checks for a name during log replay see that the
+				 * name does not exists anymore.
+				 */
+				if (!ret)
+					ret = btrfs_run_delayed_items(trans);
 			}
 			if (ret < 0)
 				goto out;
-- 
2.33.0

