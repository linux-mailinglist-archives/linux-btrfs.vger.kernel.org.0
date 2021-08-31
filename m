Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC6393FC9BD
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Aug 2021 16:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237258AbhHaObk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Aug 2021 10:31:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:58284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237090AbhHaObj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Aug 2021 10:31:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1ADFD600AA
        for <linux-btrfs@vger.kernel.org>; Tue, 31 Aug 2021 14:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630420244;
        bh=3BeRmkv6P3cbmG067wTUoKLRXf2KsuOgyt07YUW3nWE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=OsJKaGnVLqvtjx9aqp8Ep1ayXV5p4bvO3RhD2WPapZPeieF0b1xPwrqua3SId1+m/
         7YAJgAaY1B1W5KIYDRpeiYWnTCoxzkgytXABcjJsxaByRUeWzC2uy1qs21WkLyEMBN
         8hVPlUN7cXceuw892cBWEemxlZumJLuEySVw7Gx7t/bjM11vGGwlP1PHMQCjur8Eex
         vkob/A+fbSVJsr/42S3yooQJS2GmpgxylNTMr7ws3JlfXS0hKWECSc2WE48uYffWVU
         dqUCTwXye9snzX323O35SNTdm+kzxzndtOc8/K/pF5iTuS3nr9PiskbLDtebqknMK2
         6VZqdVPzsoQrw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 01/10] btrfs: check if a log tree exists at inode_logged()
Date:   Tue, 31 Aug 2021 15:30:31 +0100
Message-Id: <b12fe76b6f4272d17f01b628915089136ccbbe1a.1630419897.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1630419897.git.fdmanana@suse.com>
References: <cover.1630419897.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

In case an inode was never logged since it was loaded from disk and was
modified in the current transaction (its ->last_trans matches the ID of
the current transaction), inode_logged() returns true even if there's no
existing log tree. In this case we can simply check if a log tree exists
and return false if it does not. This avoids a caller of inode_logged()
doing some unnecessary, but harmless, work.

For btrfs_log_new_name() it avoids it logging an inode in case it was
never logged since it was loaded from disk and there is currently no log
tree for the inode's root. For the remaining callers of inode_logged(),
btrfs_del_dir_entries_in_log() and btrfs_del_inode_ref_in_log(), it has
no effect since they already check if a log tree exists through their
calls to join_running_log_trans().

So just add a check to inode_logged() to verify if a log tree exists, and
return false if it does not.

This patch is part of a patch set comprised of the following patches:

  btrfs: check if a log tree exists at inode_logged()
  btrfs: remove no longer needed checks for NULL log context
  btrfs: do not log new dentries when logging that a new name exists
  btrfs: always update the logged transaction when logging new names
  btrfs: avoid expensive search when dropping inode items from log
  btrfs: add helper to truncate inode items when logging inode
  btrfs: avoid expensive search when truncating inode items from the log
  btrfs: avoid search for logged i_size when logging inode if possible
  btrfs: avoid attempt to drop extents when logging inode for the first time
  btrfs: do not commit delayed inode when logging a file in full sync mode

This is patch 1/10 and test results are listed in the change log of the
last patch in the set.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index f7efc26aa82a..0342b1614978 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3434,6 +3434,9 @@ static bool inode_logged(struct btrfs_trans_handle *trans,
 	if (inode->logged_trans == trans->transid)
 		return true;
 
+	if (!test_bit(BTRFS_ROOT_HAS_LOG_TREE, &inode->root->state))
+		return false;
+
 	/*
 	 * The inode's logged_trans is always 0 when we load it (because it is
 	 * not persisted in the inode item or elsewhere). So if it is 0, the
-- 
2.28.0

