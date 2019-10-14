Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E681D6276
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2019 14:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731999AbfJNMWq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Oct 2019 08:22:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:37614 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730375AbfJNMWp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Oct 2019 08:22:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6A901BE8F;
        Mon, 14 Oct 2019 12:22:44 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 13D08DA7E3; Mon, 14 Oct 2019 14:22:57 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 15/15] btrfs: compression: remove ops pointer from workspace_manager
Date:   Mon, 14 Oct 2019 14:22:57 +0200
Message-Id: <7fe1018a3a18485a0d3eeab1be89fd84603e46ea.1571054758.git.dsterba@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1571054758.git.dsterba@suse.com>
References: <cover.1571054758.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We can infer the ops from the type that is now passed to all functions
that would need it, this makes workspace_manager::ops redundant and can
be removed.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/compression.c | 6 ++----
 fs/btrfs/compression.h | 1 -
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index b2342f99b093..53aee0db9d71 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -956,12 +956,10 @@ static void free_workspace(int type, struct list_head *ws)
 
 static void btrfs_init_workspace_manager(int type)
 {
-	const struct btrfs_compress_op *ops = btrfs_compress_op[type];
-	struct workspace_manager *wsm = ops->workspace_manager;
+	struct workspace_manager *wsm;
 	struct list_head *workspace;
 
-	wsm->ops = ops;
-
+	wsm = btrfs_compress_op[type]->workspace_manager;
 	INIT_LIST_HEAD(&wsm->idle_ws);
 	spin_lock_init(&wsm->ws_lock);
 	atomic_set(&wsm->total_ws, 0);
diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index 14057498dcbb..d253f7aa8ed5 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -109,7 +109,6 @@ enum btrfs_compression_type {
 };
 
 struct workspace_manager {
-	const struct btrfs_compress_op *ops;
 	struct list_head idle_ws;
 	spinlock_t ws_lock;
 	/* Number of free workspaces */
-- 
2.23.0

