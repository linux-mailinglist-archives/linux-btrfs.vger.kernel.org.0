Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 557C9439316
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Oct 2021 11:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbhJYJ7C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Oct 2021 05:59:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:37346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232638AbhJYJ6x (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Oct 2021 05:58:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 37F5F61029
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Oct 2021 09:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635155791;
        bh=Cy9HLxJ6sDxyaRtLJpn9QhbXae0IZPvyg8U2sebMz2c=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=u3F7xQ3axwjbHDm5q9Apf/sNYde2/Nwwrtg9o5gG+wZPbnP5hIo/C3ghU+pbZimvX
         OEgFPciWwuI+nk1MQQO39ZWospfdGTO4kyE5khsEu7sa98YPRGbxYsVsYJLfr6hE3D
         MEMTn0vmyiPNQOjCzEPNTWDGvemy8tAC2BHXTY1AuF9FEefCI9VIOO/K4DHHxWbh7i
         Bp+Sriql268AdhBZ6204170bkpIGmcSWuVuRMaAKy0De4LHJOME8ergFrMCvwPWu98
         VE1eFYsx29sva2KmugWV7I27xx/KMVYdMCSFIsuf0swDp0HXvctowCsDabbcTdygXX
         Ritz0yhBgIZow==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/6] btrfs: remove root argument from add_link()
Date:   Mon, 25 Oct 2021 10:56:23 +0100
Message-Id: <0de517089fcedd5bf8999cff85c223ce66c1dd95.1635155473.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1635155473.git.fdmanana@suse.com>
References: <cover.1635155473.git.fdmanana@suse.com>
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

