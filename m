Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 035053BB3BC
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Jul 2021 01:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233588AbhGDXSw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 4 Jul 2021 19:18:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:50794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234123AbhGDXOy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 4 Jul 2021 19:14:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3932F619B2;
        Sun,  4 Jul 2021 23:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625440276;
        bh=49DCbnA0cnfQ0y/NVqb4dio+tUOrIVniIoqo9KXsdK8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FF4hNDl083boPyvEB65F1sn/pVufCYvvvAn7qF5XdP8NfZdD4IMVfP5itOZacevKp
         doT/tAdHrjQenADhOqkjmSsSodldbFCjUobfIEy8B7WbrGEQe559LGN8KMdgnjHix/
         wjmWASTMLHK6BI/CkJcHYg8Jnl8YoDR9H/fyY6tjH9/tFNVoybp79z5yqNuPwpCjQ2
         24Qcr/xE4YX7WRZab6hEy5cEy3ZMYpcyBIQaUYJu8hWzyd9G9GnetsFCYdDQhHIZ2N
         fgeH3kxhkIbokfqF25XffMuswgRMf2iOdnarfiVxEVFbDe5uFEA5qd4HuUic7kPDfT
         6p8JHsi8uNnWg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>, linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 26/31] btrfs: fix error handling in __btrfs_update_delayed_inode
Date:   Sun,  4 Jul 2021 19:10:38 -0400
Message-Id: <20210704231043.1491209-26-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210704231043.1491209-1-sashal@kernel.org>
References: <20210704231043.1491209-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Josef Bacik <josef@toxicpanda.com>

[ Upstream commit bb385bedded3ccbd794559600de4a09448810f4a ]

If we get an error while looking up the inode item we'll simply bail
without cleaning up the delayed node.  This results in this style of
warning happening on commit:

  WARNING: CPU: 0 PID: 76403 at fs/btrfs/delayed-inode.c:1365 btrfs_assert_delayed_root_empty+0x5b/0x90
  CPU: 0 PID: 76403 Comm: fsstress Tainted: G        W         5.13.0-rc1+ #373
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-2.fc32 04/01/2014
  RIP: 0010:btrfs_assert_delayed_root_empty+0x5b/0x90
  RSP: 0018:ffffb8bb815a7e50 EFLAGS: 00010286
  RAX: 0000000000000000 RBX: ffff95d6d07e1888 RCX: ffff95d6c0fa3000
  RDX: 0000000000000002 RSI: 000000000029e91c RDI: ffff95d6c0fc8060
  RBP: ffff95d6c0fc8060 R08: 00008d6d701a2c1d R09: 0000000000000000
  R10: ffff95d6d1760ea0 R11: 0000000000000001 R12: ffff95d6c15a4d00
  R13: ffff95d6c0fa3000 R14: 0000000000000000 R15: ffffb8bb815a7e90
  FS:  00007f490e8dbb80(0000) GS:ffff95d73bc00000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 00007f6e75555cb0 CR3: 00000001101ce001 CR4: 0000000000370ef0
  Call Trace:
   btrfs_commit_transaction+0x43c/0xb00
   ? finish_wait+0x80/0x80
   ? vfs_fsync_range+0x90/0x90
   iterate_supers+0x8c/0x100
   ksys_sync+0x50/0x90
   __do_sys_sync+0xa/0x10
   do_syscall_64+0x3d/0x80
   entry_SYSCALL_64_after_hwframe+0x44/0xae

Because the iref isn't dropped and this leaves an elevated node->count,
so any release just re-queues it onto the delayed inodes list.  Fix this
by going to the out label to handle the proper cleanup of the delayed
node.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/delayed-inode.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index fea5ccfade5c..f3994ee1a6e6 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -1030,12 +1030,10 @@ static int __btrfs_update_delayed_inode(struct btrfs_trans_handle *trans,
 	nofs_flag = memalloc_nofs_save();
 	ret = btrfs_lookup_inode(trans, root, path, &key, mod);
 	memalloc_nofs_restore(nofs_flag);
-	if (ret > 0) {
-		btrfs_release_path(path);
-		return -ENOENT;
-	} else if (ret < 0) {
-		return ret;
-	}
+	if (ret > 0)
+		ret = -ENOENT;
+	if (ret < 0)
+		goto out;
 
 	leaf = path->nodes[0];
 	inode_item = btrfs_item_ptr(leaf, path->slots[0],
-- 
2.30.2

