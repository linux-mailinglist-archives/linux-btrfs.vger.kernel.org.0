Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 407E4439B8E
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Oct 2021 18:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233984AbhJYQe3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Oct 2021 12:34:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:44224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232742AbhJYQe2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Oct 2021 12:34:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 742D060E74;
        Mon, 25 Oct 2021 16:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635179526;
        bh=Cy9HLxJ6sDxyaRtLJpn9QhbXae0IZPvyg8U2sebMz2c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oniFFWHwbQoAFj6901rZI0o655CQdedpV/rwpR9bDwXc1xcm/2q9wdC+DXwvh5RZD
         Aa/jJYp9xpbZvrB4bSzf6HkNyCA3T0eDGBAjZ/dlUSzm9LBUDiGUA8xYiej2C/zh6F
         k7nZ52u5I1rs5OCzF1uA5uuoAdERjVMtFe6ZhgPo73sLGv6ghMsNSq/edFj/NWPzRT
         TUpk8L/t+rwTrt+K5FM3kt9t4kiuZJFU8nh+zyt09buq6rQRkmCS75M1CYTeMF58CR
         ReCF/byQovwcRlcmYrvs1zv/g9Ye4pj+rvhbVS/kRbSOvwxe1b5QwdhKXfGqLuLg1O
         kKSsKMaTVCgAg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v2 3/6] btrfs: remove root argument from add_link()
Date:   Mon, 25 Oct 2021 17:31:51 +0100
Message-Id: <0de517089fcedd5bf8999cff85c223ce66c1dd95.1635178668.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1635178668.git.fdmanana@suse.com>
References: <cover.1635178668.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The root argument for tree-log.c:add_link() always matches the root of the
given directory and the given inode, so it can eliminated.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 568509371b68..b753b3c87e14 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -1413,10 +1413,11 @@ static int btrfs_inode_ref_exists(struct inode *inode, struct inode *dir,
 	return ret;
 }
 
-static int add_link(struct btrfs_trans_handle *trans, struct btrfs_root *root,
+static int add_link(struct btrfs_trans_handle *trans,
 		    struct inode *dir, struct inode *inode, const char *name,
 		    int namelen, u64 ref_index)
 {
+	struct btrfs_root *root = BTRFS_I(dir)->root;
 	struct btrfs_dir_item *dir_item;
 	struct btrfs_key key;
 	struct btrfs_path *path;
@@ -1612,7 +1613,7 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
 				goto out;
 
 			/* insert our name */
-			ret = add_link(trans, root, dir, inode, name, namelen,
+			ret = add_link(trans, dir, inode, name, namelen,
 				       ref_index);
 			if (ret)
 				goto out;
-- 
2.33.0

