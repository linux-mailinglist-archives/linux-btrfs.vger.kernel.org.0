Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79F8530D85A
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Feb 2021 12:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234083AbhBCLSh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Feb 2021 06:18:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:56586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233983AbhBCLSe (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 3 Feb 2021 06:18:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 17A5864F74
        for <linux-btrfs@vger.kernel.org>; Wed,  3 Feb 2021 11:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612351073;
        bh=eqLKGlahv72gTBWCi8BJ/rDOzf8XUgsXJ3XVqRYA03o=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=AvDAm7v+KJuWaUX0Cgf8nVLLnsyJvHfUZVZn83njRCtrh51+T7pn2LJM13VxrC8gk
         Tyd8qJStTRmMgdsYfoWQZ6sgG8k+O3a2a3W411SCk0OmYKOl+phC0JWaGxI4lttsur
         s/wuOprOPAQAqFYNFaO2RSJOKMqbQDsBelEv9K9kLkN4pU/euGvq+xF2lkZnhiZfos
         O09UX/E/N6PM6tEVbDxapJ9SKmwdKCJvJhs9XaZuIlsl7pI0CXeHGZ4LHsqT365E3+
         w8ebmqJk8HPo22fgBu5pg2kNCZFRbc+ZT15t+pa9EgC9L+mX0/HBsy9Wjd8p0u+1Pd
         sVJgebOeAI3OQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/4] btrfs: remove no longer used function btrfs_extent_readonly()
Date:   Wed,  3 Feb 2021 11:17:46 +0000
Message-Id: <62b700e55d7b9cec8cf4d19e1adfcaa450d9cfed.1612350698.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1612350698.git.fdmanana@suse.com>
References: <cover.1612350698.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

After the two previous patches:

  btrfs: avoid checking for RO block group twice during nocow writeback
  btrfs: fix race between writes to swap files and scrub

it is no longer used, so just remove it.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.h       |  1 -
 fs/btrfs/extent-tree.c | 13 -------------
 2 files changed, 14 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 5269777a4fb4..65d158082b86 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2686,7 +2686,6 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans);
 int btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
 			 struct btrfs_ref *generic_ref);
 
-int btrfs_extent_readonly(struct btrfs_fs_info *fs_info, u64 bytenr);
 void btrfs_clear_space_info_full(struct btrfs_fs_info *info);
 
 /*
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 5476ab84e544..11ef4259cacb 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2455,19 +2455,6 @@ int btrfs_dec_ref(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 	return __btrfs_mod_ref(trans, root, buf, full_backref, 0);
 }
 
-int btrfs_extent_readonly(struct btrfs_fs_info *fs_info, u64 bytenr)
-{
-	struct btrfs_block_group *block_group;
-	int readonly = 0;
-
-	block_group = btrfs_lookup_block_group(fs_info, bytenr);
-	if (!block_group || block_group->ro)
-		readonly = 1;
-	if (block_group)
-		btrfs_put_block_group(block_group);
-	return readonly;
-}
-
 static u64 get_alloc_profile_by_root(struct btrfs_root *root, int data)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
-- 
2.28.0

