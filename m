Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D629D6264
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2019 14:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731944AbfJNMWU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Oct 2019 08:22:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:37362 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731938AbfJNMWU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Oct 2019 08:22:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A9F8EBE59;
        Mon, 14 Oct 2019 12:22:18 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5183EDA7E3; Mon, 14 Oct 2019 14:22:31 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 04/15] btrfs: compression: let workspace manager init take only the type
Date:   Mon, 14 Oct 2019 14:22:31 +0200
Message-Id: <7096eaf28c495b2edbfc2cc4f57980ab7aee6643.1571054758.git.dsterba@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1571054758.git.dsterba@suse.com>
References: <cover.1571054758.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

With the access to the workspace structures, we can look it up together
with the compression ops inside the workspace manager init helper.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/compression.c | 7 ++++---
 fs/btrfs/compression.h | 3 +--
 fs/btrfs/lzo.c         | 2 +-
 fs/btrfs/zlib.c        | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index e650125b1d2b..6adc7f6857d7 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -862,7 +862,7 @@ static struct workspace_manager heuristic_wsm;
 
 static void heuristic_init_workspace_manager(void)
 {
-	btrfs_init_workspace_manager(&heuristic_wsm, &btrfs_heuristic_compress);
+	btrfs_init_workspace_manager(BTRFS_COMPRESS_NONE);
 }
 
 static void heuristic_cleanup_workspace_manager(void)
@@ -937,9 +937,10 @@ static const struct btrfs_compress_op * const btrfs_compress_op[] = {
 	&btrfs_zstd_compress,
 };
 
-void btrfs_init_workspace_manager(struct workspace_manager *wsm,
-				  const struct btrfs_compress_op *ops)
+void btrfs_init_workspace_manager(int type)
 {
+	const struct btrfs_compress_op *ops = btrfs_compress_op[type];
+	struct workspace_manager *wsm = ops->workspace_manager;
 	struct list_head *workspace;
 
 	wsm->ops = ops;
diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index 7091eae063e5..10f82e791769 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -120,8 +120,7 @@ struct workspace_manager {
 	wait_queue_head_t ws_wait;
 };
 
-void btrfs_init_workspace_manager(struct workspace_manager *wsm,
-				  const struct btrfs_compress_op *ops);
+void btrfs_init_workspace_manager(int type);
 struct list_head *btrfs_get_workspace(struct workspace_manager *wsm,
 				      unsigned int level);
 void btrfs_put_workspace(struct workspace_manager *wsm, struct list_head *ws);
diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
index aff105cc80e7..5b8470041bf6 100644
--- a/fs/btrfs/lzo.c
+++ b/fs/btrfs/lzo.c
@@ -65,7 +65,7 @@ static struct workspace_manager wsm;
 
 static void lzo_init_workspace_manager(void)
 {
-	btrfs_init_workspace_manager(&wsm, &btrfs_lzo_compress);
+	btrfs_init_workspace_manager(BTRFS_COMPRESS_LZO);
 }
 
 static void lzo_cleanup_workspace_manager(void)
diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
index a5e8f0207473..be964128dba3 100644
--- a/fs/btrfs/zlib.c
+++ b/fs/btrfs/zlib.c
@@ -31,7 +31,7 @@ static struct workspace_manager wsm;
 
 static void zlib_init_workspace_manager(void)
 {
-	btrfs_init_workspace_manager(&wsm, &btrfs_zlib_compress);
+	btrfs_init_workspace_manager(BTRFS_COMPRESS_ZLIB);
 }
 
 static void zlib_cleanup_workspace_manager(void)
-- 
2.23.0

