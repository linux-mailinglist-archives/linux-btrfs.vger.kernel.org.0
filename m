Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B65B93BE706
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jul 2021 13:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbhGGL02 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Jul 2021 07:26:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:39258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231321AbhGGL02 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 7 Jul 2021 07:26:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3E54C61CB9
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jul 2021 11:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625657028;
        bh=yROqguvdq2XhUicDJnUi96fz+tHVZGYTgdDPcoYV0i4=;
        h=From:To:Subject:Date:From;
        b=e9tMhk9CFp6FX2u65XvMglzAVGQ7vFe+6onjaPW/dxFyjTGNTc9WlwcNhv8h4Upo7
         0Pi8+YtB64CctKXATvZHBoOYqAn6/T0uMsuc8rOZh5mafqG/saUnb/rmtrKVxY4TcI
         RYl5Tj6vGcHdS7vnp6oUw9YNPHMzFgKyP2KZJNGmDvDTBdKHiPRmoWgIWSPk92xcD+
         JgE1ny4NQ3FbVf8iC8ww6RBeEptLZwdgGozV/K6BajzCSILRd2hQTjO6kavflrLvlI
         CNRXpmXIRT6PXbNkvIL78rJZpCUgGkfDVnOesNUkTodu1ljI+iC0pxcUNc2FzGRaxK
         q+NZ18xtzueBQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: zoned: fix wrong mutex unlock on failure to allocate log root tree
Date:   Wed,  7 Jul 2021 12:23:45 +0100
Message-Id: <11314a6ca7a70deee42785d3ee79c97813b528ab.1625656963.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When syncing the log, if we fail to allocate the root node for the log
root tree:

1) We are unlocking fs_info->tree_log_mutex, but at this point we have
   not yet locked this mutex;

2) We have locked fs_info->tree_root->log_mutex, but we end up not
   unlocking it;

So fix this by unlocking fs_info->tree_root->log_mutex instead of
fs_info->tree_log_mutex.

Fixes: e75f9fd194090e ("btrfs: zoned: move log tree node allocation out of log_root_tree->log_mutex")
CC: stable@vger.kernel.org # 5.13+
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 8471837e7eb9..9fd0348be7f5 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3173,7 +3173,7 @@ int btrfs_sync_log(struct btrfs_trans_handle *trans,
 		if (!log_root_tree->node) {
 			ret = btrfs_alloc_log_tree_node(trans, log_root_tree);
 			if (ret) {
-				mutex_unlock(&fs_info->tree_log_mutex);
+				mutex_unlock(&fs_info->tree_root->log_mutex);
 				goto out;
 			}
 		}
-- 
2.30.2

