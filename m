Return-Path: <linux-btrfs+bounces-1909-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 285C8840EC5
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jan 2024 18:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F2861F28837
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jan 2024 17:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9225B16089A;
	Mon, 29 Jan 2024 17:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V8Ci4/q5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B509315703F;
	Mon, 29 Jan 2024 17:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706548341; cv=none; b=MWJlcxsxxg+sbTPqyZZixwXUxoOkEwPcLQ31P39RO74tt6bw2F8inok7AwAqvRY2xWOXK4k9SkQjslR3dR4zupAmvicw129of3eUV01MYDXAlc+gmEJ3EnK4zoRQwIAJzBalTaQIr+S53lorkjMpin5mnmo7QkdqgJFTn+IjPio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706548341; c=relaxed/simple;
	bh=AIXRYUCkjN8XiFq0KaewGS4fcVjikZBcdcrIUTwyY4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jGLKGdDd/XT1+xpW4mYBMJw0NXF5Q2JRm9cNG1CmAbeDHGByLEZbHD2qMdmxSRrXp1mHnb5IFI+2YoOKj8MJzyYVFcOxc+01IAheFvtGq7+eT3uwk8HQTSIEO44MJ7p7UwcIolfv8CAC0bFzuPIFq1OupezVgyzC0NoqY6+PQH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V8Ci4/q5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ED28C433C7;
	Mon, 29 Jan 2024 17:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706548341;
	bh=AIXRYUCkjN8XiFq0KaewGS4fcVjikZBcdcrIUTwyY4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V8Ci4/q5NzDLCK60OkZ6DP+WTwqIulhI/gvHlqfrdDNpawm8PBQSdJsZ1ETJwhN5Y
	 7cO/3lsM7EY7pfubD+Gl1PhEHNyC2N5zSiCaJ0ff3Jk+UUb+Vw0KKmV1rQJ6NWhL8V
	 HaFxgHnbeH+x4Bp2XzIBcSu5pp2bdvHHVVz5fXT8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org,
	linux-btrfs@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	ken <ken@bllue.org>,
	syzbot+d13490c82ad5353c779d@syzkaller.appspotmail.com,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 6.1 106/185] btrfs: fix race between reading a directory and adding entries to it
Date: Mon, 29 Jan 2024 09:05:06 -0800
Message-ID: <20240129170001.999207601@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129165958.589924174@linuxfoundation.org>
References: <20240129165958.589924174@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/inode.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6000,21 +6000,24 @@ out:
 
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



