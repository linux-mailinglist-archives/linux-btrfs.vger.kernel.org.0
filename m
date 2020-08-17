Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2A7B246615
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Aug 2020 14:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbgHQMMm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Aug 2020 08:12:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:57104 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728000AbgHQMMm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Aug 2020 08:12:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1C359AEDA;
        Mon, 17 Aug 2020 12:13:06 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D97D3DA6EF; Mon, 17 Aug 2020 14:11:36 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 3/5] btrfs: remove unnecessarily shadowed variables
Date:   Mon, 17 Aug 2020 14:11:36 +0200
Message-Id: <f90a594dd5d9bf67e2160209d9e0e4bbd76fdfea.1597666167.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1597666167.git.dsterba@suse.com>
References: <cover.1597666167.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In btrfs_orphan_cleanup, there's another instance of fs_info, but it's
the same as the one we already have.

In btrfs_backref_finish_upper_links, rb_node is same type and used
as temporary cursor to the tree.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/backref.c | 1 -
 fs/btrfs/inode.c   | 1 -
 2 files changed, 2 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index ea1c28ccb44f..b3268f4ea5f3 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -2997,7 +2997,6 @@ int btrfs_backref_finish_upper_links(struct btrfs_backref_cache *cache,
 	while (!list_empty(&pending_edge)) {
 		struct btrfs_backref_node *upper;
 		struct btrfs_backref_node *lower;
-		struct rb_node *rb_node;
 
 		edge = list_first_entry(&pending_edge,
 				struct btrfs_backref_edge, list[UPPER]);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index dd84c4d58a56..ced88a830253 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3055,7 +3055,6 @@ int btrfs_orphan_cleanup(struct btrfs_root *root)
 
 		if (ret == -ENOENT && root == fs_info->tree_root) {
 			struct btrfs_root *dead_root;
-			struct btrfs_fs_info *fs_info = root->fs_info;
 			int is_dead_root = 0;
 
 			/*
-- 
2.25.0

