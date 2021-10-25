Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A23F439B8F
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Oct 2021 18:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233986AbhJYQea (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Oct 2021 12:34:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:44250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232742AbhJYQe3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Oct 2021 12:34:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8847D60EB9;
        Mon, 25 Oct 2021 16:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635179527;
        bh=rJGi0RCirY7h5dTAqGrMXWtjtu3iwdwwuPlIkgfiKOI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dthAmDIFc79bOaVC69PgZ6H10REFAuKUu74NftwCyFNYWtUGcsP2kK0RVtNYpT+9x
         hS7kmfxNPEBs2f16lBSYD8qw7FoB0y9dpkk9kJcRMWoyhTH2HIcc+8yyKMp4GCSLvP
         FLtavZYah3M8dcZidlsgiYpcugpLer0xwjszfYe4hHzS0DRul3pN8L97zwrJcdp+5F
         Kts/63QxtGg3N3Ib2sf6xHevyn3z6x9ZCb5ajiXS1xFA7alwZ/9dxY8cTjRf8uvpTt
         2IY00gTHSby4AlpctqZ9XnHQ7OIKT3sHupyIse6tQ0iRTQ3j3Q+UwFN/K7wfBwPtyx
         vrC44AaRjmb4w==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v2 4/6] btrfs: remove root argument from check_item_in_log()
Date:   Mon, 25 Oct 2021 17:31:52 +0100
Message-Id: <6909d087a2a4f371d9c9303c933d8a8d93c80270.1635178668.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1635178668.git.fdmanana@suse.com>
References: <cover.1635178668.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The root argument passed to check_item_in_log() always matches the root
of the given directory, so it can be eliminated.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index b753b3c87e14..8ab33caf016f 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -2280,13 +2280,13 @@ static noinline int find_dir_range(struct btrfs_root *root,
  * to is unlinked
  */
 static noinline int check_item_in_log(struct btrfs_trans_handle *trans,
-				      struct btrfs_root *root,
 				      struct btrfs_root *log,
 				      struct btrfs_path *path,
 				      struct btrfs_path *log_path,
 				      struct inode *dir,
 				      struct btrfs_key *dir_key)
 {
+	struct btrfs_root *root = BTRFS_I(dir)->root;
 	int ret;
 	struct extent_buffer *eb;
 	int slot;
@@ -2560,7 +2560,7 @@ static noinline int replay_dir_deletes(struct btrfs_trans_handle *trans,
 			if (found_key.offset > range_end)
 				break;
 
-			ret = check_item_in_log(trans, root, log, path,
+			ret = check_item_in_log(trans, log, path,
 						log_path, dir,
 						&found_key);
 			if (ret)
-- 
2.33.0

