Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE1AC38E421
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 May 2021 12:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbhEXKhu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 May 2021 06:37:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:49564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232516AbhEXKho (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 May 2021 06:37:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0746360FE7
        for <linux-btrfs@vger.kernel.org>; Mon, 24 May 2021 10:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621852561;
        bh=b19Z5w6DtbTmkxnSbvLdZtRBnFA/XwXiutEZvJSczCA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ZhxWLD1Q7MeaYyh1utNCws5qStgEZfamgndD/iJBjCh9+sl02oePklWOhGkZ8wC4r
         1L75p5w1gGNzm82hAWsuZk6fAiBbUGXwthYMMwYsZryzeJLVZgtq16vUuS7RTTQ1JF
         y3YaC8tDYGUZlHpBnQQyjIxK/iCI3Yg6u0VrRnITyXYTnZB3bXUPtPOeaSTKHqBm7n
         77FDQ5tLTaD6rt0YFb8FWfNkW/JCK4el5APClJPm2f41UuFlDBp8XWWsCLDh0swIQZ
         d0o9b7ZOYS2+X03odlmw7D6DYLK5HVRKjhANMFr8FbtLD4jl0/EFmCGO81oa7p4z4i
         BRIw8wrCd8yLQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs: fix misleading and incomplete comment of btrfs_truncate()
Date:   Mon, 24 May 2021 11:35:54 +0100
Message-Id: <361f63991d09b69adec418326ce058b850648bd1.1621851896.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1621851896.git.fdmanana@suse.com>
References: <cover.1621851896.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The comment at the top of btrfs_truncate() mentions that csum items are
dropped or truncated to the new i_size, but this is wrong and non sense,
as they are unrelated to the i_size and are located in the csums tree and
not on a tree with inode items (fs/subvolume tree or a log tree). Instead
that claim applies to file extent items, so fix the comment to refer to
them instead.

While at it make the whole comment for the function more descriptive and
follow the kernel doc style.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 23854d180e94..64ddad66ded0 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4456,15 +4456,25 @@ static int btrfs_rmdir(struct inode *dir, struct dentry *dentry)
 #define NEED_TRUNCATE_BLOCK 1
 
 /*
- * this can truncate away extent items, csum items and directory items.
- * It starts at a high offset and removes keys until it can't find
- * any higher than new_size
+ * Remove inode items from a given root.
  *
- * csum items that cross the new i_size are truncated to the new size
- * as well.
+ * @trans:		A transaction handle.
+ * @root:		The root from which to remove items.
+ * @inode:		The inode whose items we want to remove.
+ * @new_size:		The new i_size for the inode. This is only applicable when
+ *			@min_type is BTRFS_EXTENT_DATA_KEY, must be 0 otherwise.
+ * @min_type:		The minimum key type to remove. All keys with a type
+ *			greater than this value are removed and all keys with
+ *			this type are removed only if their offset is >= @new_size.
  *
- * min_type is the minimum key type to truncate down to.  If set to 0, this
- * will kill all the items on this inode, including the INODE_ITEM_KEY.
+ * Remove all keys associated with the inode from the given root that have a key
+ * with a type greater than or equals to @min_type. When @min_type has a value of
+ * BTRFS_EXTENT_DATA_KEY, only remove file extent items that have an offset value
+ * greater than or equals to @new_size. If a file extent item that starts before
+ * @new_size and ends after it is found, its length is adjusted.
+ *
+ * Returns: 0 on success, < 0 on error and NEED_TRUNCATE_BLOCK when @min_type is
+ * BTRFS_EXTENT_DATA_KEY and the caller must truncate the last block.
  */
 int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 			       struct btrfs_root *root,
-- 
2.28.0

