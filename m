Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57E997DBE8
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Aug 2019 14:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731470AbfHAMt6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Aug 2019 08:49:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:34450 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731420AbfHAMt5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 1 Aug 2019 08:49:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E3861ADF1
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Aug 2019 12:49:56 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 18B83DA7D9; Thu,  1 Aug 2019 14:50:30 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 1/3] btrfs: tree-log: convert defines to enums
Date:   Thu,  1 Aug 2019 14:50:30 +0200
Message-Id: <95ac11cd7b04e4ea49cbdc53c6541a5de3539746.1564663765.git.dsterba@suse.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1564663765.git.dsterba@suse.com>
References: <cover.1564663765.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Used only for in-memory state tracking.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/tree-log.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 6c8297bcfeb7..5513e76cc336 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -24,10 +24,12 @@
  * LOG_INODE_EXISTS means to log just enough to recreate the inode
  * during log replay
  */
-#define LOG_INODE_ALL 0
-#define LOG_INODE_EXISTS 1
-#define LOG_OTHER_INODE 2
-#define LOG_OTHER_INODE_ALL 3
+enum {
+	LOG_INODE_ALL,
+	LOG_INODE_EXISTS,
+	LOG_OTHER_INODE,
+	LOG_OTHER_INODE_ALL,
+};
 
 /*
  * directory trouble cases
@@ -81,10 +83,12 @@
  * The last stage is to deal with directories and links and extents
  * and all the other fun semantics
  */
-#define LOG_WALK_PIN_ONLY 0
-#define LOG_WALK_REPLAY_INODES 1
-#define LOG_WALK_REPLAY_DIR_INDEX 2
-#define LOG_WALK_REPLAY_ALL 3
+enum {
+	LOG_WALK_PIN_ONLY,
+	LOG_WALK_REPLAY_INODES,
+	LOG_WALK_REPLAY_DIR_INDEX,
+	LOG_WALK_REPLAY_ALL,
+};
 
 static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 			   struct btrfs_root *root, struct btrfs_inode *inode,
-- 
2.22.0

