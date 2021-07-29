Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0313DA66E
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jul 2021 16:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234361AbhG2Oa1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Jul 2021 10:30:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:40688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234206AbhG2Oa1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Jul 2021 10:30:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F329D60F4A
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Jul 2021 14:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627569024;
        bh=hoVsXImXD3/DVOvDiutb/wAxY8xoqa/hZFh13qgok1g=;
        h=From:To:Subject:Date:From;
        b=eMPEQYa9vFimcPxH9lot8g5fmNoiSraV2XYtNH3WAN2eC0obMWWLxDLV6Cnxis7ul
         tQYYYmIJqcYZYXYgERbztQiMZmvovDwEgXYSTJziYxXQtlL99RRjWJQs8O3VSmp6QD
         Hw+wGORvQeqJSKR34yOGgrbyFy81Ktb9pOoRImqcAihXvjAxXFP+LenlUUqjgT86Sq
         c77g2KBlREZmbp3bl4cKzUkYbsUzpLA9NlrSp1nziUII1ebtN2iaZzQWZslBdDafEB
         w1TWgUtxayxxNC80QLmCLjD+iZrOJRZq6yLAj2mVnFkNVRYreh0z4WYs7hdnpJf4wf
         LJXxiBgpyXjVg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: update comment at log_conflicting_inodes()
Date:   Thu, 29 Jul 2021 15:30:21 +0100
Message-Id: <26f8585750e2eb8fc1f0bbaf975681277e93a1a8.1627568981.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

A comment at log_conflicting_inodes() mentions that we check the inode's
logged_trans field instead of using btrfs_inode_in_log() because the field
last_log_commit is not updated when we log that an inode exists and the
inode has the full sync flag (BTRFS_INODE_NEEDS_FULL_SYNC) set. The part
about the full sync flag is not true anymore since commit 9acc8103ab594f
("btrfs: fix unpersisted i_size on fsync after expanding truncate"), so
update the comment to not mention that part anymore.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index fc98b7a7a8e6..4de3f78c579b 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -5091,8 +5091,8 @@ static int log_conflicting_inodes(struct btrfs_trans_handle *trans,
 		/*
 		 * Check the inode's logged_trans only instead of
 		 * btrfs_inode_in_log(). This is because the last_log_commit of
-		 * the inode is not updated when we only log that it exists and
-		 * it has the full sync bit set (see btrfs_log_inode()).
+		 * the inode is not updated when we only log that it exists (see
+		 * btrfs_log_inode()).
 		 */
 		if (BTRFS_I(inode)->logged_trans == trans->transid) {
 			spin_unlock(&BTRFS_I(inode)->lock);
-- 
2.28.0

