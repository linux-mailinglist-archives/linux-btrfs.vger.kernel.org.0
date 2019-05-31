Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 750B23133C
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 May 2019 19:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbfEaRAd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 May 2019 13:00:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:60006 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726037AbfEaRAd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 May 2019 13:00:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 22497AD6F
        for <linux-btrfs@vger.kernel.org>; Fri, 31 May 2019 17:00:32 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C8774DA85E; Fri, 31 May 2019 19:01:25 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 3/5] btrfs: assert tree mod log lock in __tree_mod_log_insert
Date:   Fri, 31 May 2019 19:01:25 +0200
Message-Id: <b5d0e50544f219a444aafc3284fa899f875fab84.1559321947.git.dsterba@suse.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1559321947.git.dsterba@suse.com>
References: <cover.1559321947.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The tree is going to be modified so it must be the exclusive lock.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ctree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 5df76c17775a..99a585ede79d 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -376,8 +376,6 @@ void btrfs_put_tree_mod_seq(struct btrfs_fs_info *fs_info,
  * The 'start address' is the logical address of the *new* root node
  * for root replace operations, or the logical address of the affected
  * block for all other operations.
- *
- * Note: must be called with write lock for fs_info::tree_mod_log_lock.
  */
 static noinline int
 __tree_mod_log_insert(struct btrfs_fs_info *fs_info, struct tree_mod_elem *tm)
@@ -387,6 +385,8 @@ __tree_mod_log_insert(struct btrfs_fs_info *fs_info, struct tree_mod_elem *tm)
 	struct rb_node *parent = NULL;
 	struct tree_mod_elem *cur;
 
+	lockdep_assert_held_exclusive(&fs_info->tree_mod_log_lock);
+
 	tm->seq = btrfs_inc_tree_mod_seq(fs_info);
 
 	tm_root = &fs_info->tree_mod_log;
-- 
2.21.0

