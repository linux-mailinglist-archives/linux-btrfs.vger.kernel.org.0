Return-Path: <linux-btrfs+bounces-1791-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C2F83C18A
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jan 2024 13:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 594CC1C24855
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jan 2024 12:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8908145C0B;
	Thu, 25 Jan 2024 12:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQ7HxieH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A6845029;
	Thu, 25 Jan 2024 12:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184017; cv=none; b=ZZM5jwD6swOnq/RlYBGqDUlVif/WmTV+uZeXv9yktQLQIrz4gfqGtL7ICv9xAXrOfSVg/T9FGjmnrz+iNglSVcEXzLXF3J6kNkx2f+FkGuLRixlGixD/mtmA99qpwIG15haS+8NwSCR2OWd1eu8HVAbsWgv6ANK7Iq2JHhqsw8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184017; c=relaxed/simple;
	bh=QwzdgFQFrKE1jcc2JKCcRC7MZc8sgQAzFKggHD+i3J4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rHHIFrd/udqb3W44jUS/jjMxsYZnC1gyX8Jl+2GBCb2GXJsNorRBm1hTBVXMXogVyod7K2YNxWcLpJ7LVhDvG9KocZlqbGziWwoKxi48PaSgMpvKIA5xeFIjvjLCnjIxmLQpMr0tdUh+wR0rIn5cIAJ8slsSKbzIrlNk2RyehqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lQ7HxieH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC1B1C433C7;
	Thu, 25 Jan 2024 12:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706184017;
	bh=QwzdgFQFrKE1jcc2JKCcRC7MZc8sgQAzFKggHD+i3J4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lQ7HxieH65KOtaDVC/s/vIwi2gvs+JXbo6IQe24MUOgU6FKrvU/cTiRZILuqzRylz
	 ehucjAZ3x43EFZuNPyNXqekJ2PXHinBsWm+kZZ5LQK8XAAULefT1K/KayFvTZNNu1/
	 R2f3JizQZvIMHe+nASAmIwjIPrFVVYpeqVo+Ee9pOZ6Xn7UaHZnA1EJt6FuIudUwal
	 218cvabnKpcSDl3Kj4mzFLQzIV6fFrObdCSHCSPpt9zGoiiGzv+HNcCweavrrdTTEl
	 BS+4EqpapRpGymO7mLXDaTQwfJUfJccK8TXt5UABv7Zg2ZowhN0xM93HRhqPJigJyB
	 zz7JSXrYoNpAQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Cc: erosca@de.adit-jv.com,
	Maksim.Paimushkin@se.bosch.com,
	Matthias.Thomae@de.bosch.com,
	Sebastian.Unger@bosch.com,
	Dirk.Behme@de.bosch.com,
	Eugeniu.Rosca@bosch.com,
	wqu@suse.com,
	dsterba@suse.com,
	stable@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>,
	ken <ken@bllue.org>,
	syzbot+d13490c82ad5353c779d@syzkaller.appspotmail.com
Subject: [PATCH 4/4 for 5.15 stable] btrfs: fix race between reading a directory and adding entries to it
Date: Thu, 25 Jan 2024 11:59:38 +0000
Message-Id: <1fd8f27289a8608c77f66c065d6fda87a7d89628.1706183427.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1706183427.git.fdmanana@suse.com>
References: <cover.1706183427.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

commit 8e7f82deb0c0386a03b62e30082574347f8b57d5 upstream.

When opening a directory (opendir(3)) or rewinding it (rewinddir(3)), we
are not holding the directory's inode locked, and this can result in later
attempting to add two entries to the directory with the same index number,
resulting in a transaction abort, with -EEXIST (-17), when inserting the
second delayed dir index. This results in a trace like the following:

  Sep 11 22:34:59 myhostname kernel: BTRFS error (device dm-3): err add delayed dir index item(name: cockroach-stderr.log) into the insertion tree of the delayed node(root id: 5, inode id: 4539217, errno: -17)
  Sep 11 22:34:59 myhostname kernel: ------------[ cut here ]------------
  Sep 11 22:34:59 myhostname kernel: kernel BUG at fs/btrfs/delayed-inode.c:1504!
  Sep 11 22:34:59 myhostname kernel: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
  Sep 11 22:34:59 myhostname kernel: CPU: 0 PID: 7159 Comm: cockroach Not tainted 6.4.15-200.fc38.x86_64 #1
  Sep 11 22:34:59 myhostname kernel: Hardware name: ASUS ESC500 G3/P9D WS, BIOS 2402 06/27/2018
  Sep 11 22:34:59 myhostname kernel: RIP: 0010:btrfs_insert_delayed_dir_index+0x1da/0x260
  Sep 11 22:34:59 myhostname kernel: Code: eb dd 48 (...)
  Sep 11 22:34:59 myhostname kernel: RSP: 0000:ffffa9980e0fbb28 EFLAGS: 00010282
  Sep 11 22:34:59 myhostname kernel: RAX: 0000000000000000 RBX: ffff8b10b8f4a3c0 RCX: 0000000000000000
  Sep 11 22:34:59 myhostname kernel: RDX: 0000000000000000 RSI: ffff8b177ec21540 RDI: ffff8b177ec21540
  Sep 11 22:34:59 myhostname kernel: RBP: ffff8b110cf80888 R08: 0000000000000000 R09: ffffa9980e0fb938
  Sep 11 22:34:59 myhostname kernel: R10: 0000000000000003 R11: ffffffff86146508 R12: 0000000000000014
  Sep 11 22:34:59 myhostname kernel: R13: ffff8b1131ae5b40 R14: ffff8b10b8f4a418 R15: 00000000ffffffef
  Sep 11 22:34:59 myhostname kernel: FS:  00007fb14a7fe6c0(0000) GS:ffff8b177ec00000(0000) knlGS:0000000000000000
  Sep 11 22:34:59 myhostname kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  Sep 11 22:34:59 myhostname kernel: CR2: 000000c00143d000 CR3: 00000001b3b4e002 CR4: 00000000001706f0
  Sep 11 22:34:59 myhostname kernel: Call Trace:
  Sep 11 22:34:59 myhostname kernel:  <TASK>
  Sep 11 22:34:59 myhostname kernel:  ? die+0x36/0x90
  Sep 11 22:34:59 myhostname kernel:  ? do_trap+0xda/0x100
  Sep 11 22:34:59 myhostname kernel:  ? btrfs_insert_delayed_dir_index+0x1da/0x260
  Sep 11 22:34:59 myhostname kernel:  ? do_error_trap+0x6a/0x90
  Sep 11 22:34:59 myhostname kernel:  ? btrfs_insert_delayed_dir_index+0x1da/0x260
  Sep 11 22:34:59 myhostname kernel:  ? exc_invalid_op+0x50/0x70
  Sep 11 22:34:59 myhostname kernel:  ? btrfs_insert_delayed_dir_index+0x1da/0x260
  Sep 11 22:34:59 myhostname kernel:  ? asm_exc_invalid_op+0x1a/0x20
  Sep 11 22:34:59 myhostname kernel:  ? btrfs_insert_delayed_dir_index+0x1da/0x260
  Sep 11 22:34:59 myhostname kernel:  ? btrfs_insert_delayed_dir_index+0x1da/0x260
  Sep 11 22:34:59 myhostname kernel:  btrfs_insert_dir_item+0x200/0x280
  Sep 11 22:34:59 myhostname kernel:  btrfs_add_link+0xab/0x4f0
  Sep 11 22:34:59 myhostname kernel:  ? ktime_get_real_ts64+0x47/0xe0
  Sep 11 22:34:59 myhostname kernel:  btrfs_create_new_inode+0x7cd/0xa80
  Sep 11 22:34:59 myhostname kernel:  btrfs_symlink+0x190/0x4d0
  Sep 11 22:34:59 myhostname kernel:  ? schedule+0x5e/0xd0
  Sep 11 22:34:59 myhostname kernel:  ? __d_lookup+0x7e/0xc0
  Sep 11 22:34:59 myhostname kernel:  vfs_symlink+0x148/0x1e0
  Sep 11 22:34:59 myhostname kernel:  do_symlinkat+0x130/0x140
  Sep 11 22:34:59 myhostname kernel:  __x64_sys_symlinkat+0x3d/0x50
  Sep 11 22:34:59 myhostname kernel:  do_syscall_64+0x5d/0x90
  Sep 11 22:34:59 myhostname kernel:  ? syscall_exit_to_user_mode+0x2b/0x40
  Sep 11 22:34:59 myhostname kernel:  ? do_syscall_64+0x6c/0x90
  Sep 11 22:34:59 myhostname kernel:  entry_SYSCALL_64_after_hwframe+0x72/0xdc

The race leading to the problem happens like this:

1) Directory inode X is loaded into memory, its ->index_cnt field is
   initialized to (u64)-1 (at btrfs_alloc_inode());

2) Task A is adding a new file to directory X, holding its vfs inode lock,
   and calls btrfs_set_inode_index() to get an index number for the entry.

   Because the inode's index_cnt field is set to (u64)-1 it calls
   btrfs_inode_delayed_dir_index_count() which fails because no dir index
   entries were added yet to the delayed inode and then it calls
   btrfs_set_inode_index_count(). This functions finds the last dir index
   key and then sets index_cnt to that index value + 1. It found that the
   last index key has an offset of 100. However before it assigns a value
   of 101 to index_cnt...

3) Task B calls opendir(3), ending up at btrfs_opendir(), where the VFS
   lock for inode X is not taken, so it calls btrfs_get_dir_last_index()
   and sees index_cnt still with a value of (u64)-1. Because of that it
   calls btrfs_inode_delayed_dir_index_count() which fails since no dir
   index entries were added to the delayed inode yet, and then it also
   calls btrfs_set_inode_index_count(). This also finds that the last
   index key has an offset of 100, and before it assigns the value 101
   to the index_cnt field of inode X...

4) Task A assigns a value of 101 to index_cnt. And then the code flow
   goes to btrfs_set_inode_index() where it increments index_cnt from
   101 to 102. Task A then creates a delayed dir index entry with a
   sequence number of 101 and adds it to the delayed inode;

5) Task B assigns 101 to the index_cnt field of inode X;

6) At some later point when someone tries to add a new entry to the
   directory, btrfs_set_inode_index() will return 101 again and shortly
   after an attempt to add another delayed dir index key with index
   number 101 will fail with -EEXIST resulting in a transaction abort.

Fix this by locking the inode at btrfs_get_dir_last_index(), which is only
only used when opening a directory or attempting to lseek on it.

Reported-by: ken <ken@bllue.org>
Link: https://lore.kernel.org/linux-btrfs/CAE6xmH+Lp=Q=E61bU+v9eWX8gYfLvu6jLYxjxjFpo3zHVPR0EQ@mail.gmail.com/
Reported-by: syzbot+d13490c82ad5353c779d@syzkaller.appspotmail.com
Link: https://lore.kernel.org/linux-btrfs/00000000000036e1290603e097e0@google.com/
Fixes: 9b378f6ad48c ("btrfs: fix infinite directory reads")
CC: stable@vger.kernel.org # 6.5+
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/inode.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b7047604d255..2d2caa978d80 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6173,21 +6173,24 @@ static int btrfs_set_inode_index_count(struct btrfs_inode *inode)
 
 static int btrfs_get_dir_last_index(struct btrfs_inode *dir, u64 *index)
 {
-	if (dir->index_cnt == (u64)-1) {
-		int ret;
+	int ret = 0;
 
+	btrfs_inode_lock(&dir->vfs_inode, 0);
+	if (dir->index_cnt == (u64)-1) {
 		ret = btrfs_inode_delayed_dir_index_count(dir);
 		if (ret) {
 			ret = btrfs_set_inode_index_count(dir);
 			if (ret)
-				return ret;
+				goto out;
 		}
 	}
 
 	/* index_cnt is the index number of next new entry, so decrement it. */
 	*index = dir->index_cnt - 1;
+out:
+	btrfs_inode_unlock(&dir->vfs_inode, 0);
 
-	return 0;
+	return ret;
 }
 
 /*
-- 
2.40.1


