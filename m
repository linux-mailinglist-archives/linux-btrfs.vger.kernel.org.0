Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 583A15FACF
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jul 2019 17:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbfGDPZD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Jul 2019 11:25:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:38718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727066AbfGDPZD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 4 Jul 2019 11:25:03 -0400
Received: from localhost.localdomain (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BC142083B
        for <linux-btrfs@vger.kernel.org>; Thu,  4 Jul 2019 15:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562253902;
        bh=R9nVqB1bdQxPXtJfpG9PJxEbTg07CFFbcoQhu4MMgh4=;
        h=From:To:Subject:Date:From;
        b=x1K2iDm8isg0cWlY+RkANQ2nLkE10nAVDzwTwnPrBXzJlS4F6r2GumPYSWSo1iDYx
         vMntRK2GZF9Pya1Q4/Ta0c+XMVlwZbRSHtH4aUYp3MX6TP8tbN1PZNpaSrLkNITPSU
         PXB1ilnJ+9t0XFTOygCQTQs+SKtSI+WH2owFc72k=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 5/5] Btrfs: wake up inode cache waiters sooner to reduce waiting time
Date:   Thu,  4 Jul 2019 16:25:00 +0100
Message-Id: <20190704152500.20865-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

If we need to start an inode caching thread, because none currently exists
on disk, we can wake up all waiters as soon as we mark the range starting
at root's highest objectid + 1 and ending at BTRFS_LAST_FREE_OBJECTID as
free, so that they don't need to wait for the caching thread to start and
do some progress. We follow the same approach within the caching thread,
since as soon as it finds a free range and marks it as free space in the
cache, it wakes up all waiters. So improve this by adding such a wakeup
call after marking that initial range as free space.

Fixes: a47d6b70e28040 ("Btrfs: setup free ino caching in a more asynchronous way")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode-map.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/inode-map.c b/fs/btrfs/inode-map.c
index 4820e05ea6bd..cb107d168019 100644
--- a/fs/btrfs/inode-map.c
+++ b/fs/btrfs/inode-map.c
@@ -175,6 +175,7 @@ static void start_caching(struct btrfs_root *root)
 	if (!ret && objectid <= BTRFS_LAST_FREE_OBJECTID) {
 		__btrfs_add_free_space(fs_info, ctl, objectid,
 				       BTRFS_LAST_FREE_OBJECTID - objectid + 1);
+		wake_up(&root->ino_cache_wait);
 	}
 
 	tsk = kthread_run(caching_kthread, root, "btrfs-ino-cache-%llu",
-- 
2.11.0

