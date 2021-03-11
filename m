Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9C53375C8
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Mar 2021 15:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233906AbhCKOcA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Mar 2021 09:32:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:57018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233825AbhCKOba (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Mar 2021 09:31:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6709264FEC;
        Thu, 11 Mar 2021 14:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615473090;
        bh=8CcoXdh4WpINBazOzmK5xDypaQ3NQpOm14zerdAGALg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eDXG/K29yXVY0u+JZd7CzXE+ncXTAWJcdSb6upaWMV8/qwwQ3NO9lo6HM3gdK3t0L
         N7qHOHv9QyIuT2aTNBUtWqv0asNgOlEV0brGt7Bmg4PUgF0t6AKHkww8pRCnSm49K/
         HEKosQk31TdYeqjJtTZpMzPSnZzwpY9oIABOcouyNkxLVb8iomu7deUH4ZGEFkQgm4
         9tpwxMV+DRWnXpoM8T946pfiB48i25AjBLO+qtiJgD8C76I70Twr2oXmOg/MFRFRTN
         gtDSV9OgiilcnYV1hsvo9DGon4SVlgCCKdVh4XLwLmEkk9JJSREJdJ9sHID2I9Ijnd
         3WF700EIs6nkA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Cc:     ce3g8jdj@umail.furryterror.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 6/9] btrfs: use the new bit BTRFS_FS_TREE_MOD_LOG_USERS at btrfs_free_tree_block()
Date:   Thu, 11 Mar 2021 14:31:10 +0000
Message-Id: <8b318da95fb03892feeaeebc94b6efa11515bb56.1615472583.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1615472583.git.fdmanana@suse.com>
References: <cover.1615472583.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Instead of exposing implementation details of the tree mod log to check
if there are active tree mod log users at btrfs_free_tree_block(), use
the new bit BTRFS_FS_TREE_MOD_LOG_USERS for fs_info->flags instead. This
way extent-tree.c does not need to known about any of the internals of
the tree mod log and avoids taking a lock unnecessarily as well.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-tree.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 2482b26b1971..7a28314189b4 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3342,11 +3342,9 @@ void btrfs_free_tree_block(struct btrfs_trans_handle *trans,
 		 * find a node pointing to this leaf and record operations that
 		 * point to this leaf.
 		 */
-		if (btrfs_header_level(buf) == 0) {
-			read_lock(&fs_info->tree_mod_log_lock);
-			must_pin = !list_empty(&fs_info->tree_mod_seq_list);
-			read_unlock(&fs_info->tree_mod_log_lock);
-		}
+		if (btrfs_header_level(buf) == 0 &&
+		    test_bit(BTRFS_FS_TREE_MOD_LOG_USERS, &fs_info->flags))
+			must_pin = true;
 
 		if (must_pin || btrfs_is_zoned(fs_info)) {
 			btrfs_redirty_list_add(trans->transaction, buf);
-- 
2.28.0

