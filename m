Return-Path: <linux-btrfs+bounces-7681-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 749D9965349
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Aug 2024 01:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E87B21F23D08
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Aug 2024 23:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A06156F41;
	Thu, 29 Aug 2024 23:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dxd8y0DU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262FF1BA889
	for <linux-btrfs@vger.kernel.org>; Thu, 29 Aug 2024 23:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724972982; cv=none; b=T0vBYNLe18GyyZr2BKwkFkozhyac64lG5x59gYUN19ersYxwQ0rf8cXHNPKlL7Vhp6I4OkYRf2C3BuVlVmUR10oV5h20NPvEXDheSHeGHknCCepvwtEwyTAfoCfMGpNxovmh7m0OhI/RLjw/GLwwixAShVzO7UQC3pmHw1wKeyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724972982; c=relaxed/simple;
	bh=84PDY27S+nKjmwsFWjg/FATJGNnFDPKDu+7tk61/ivk=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ACnOFJvnF7PrueUHgiiN1WwiCTuaKt1JcnxXo0eNK4zakTyuJjUFGAjIhguy/BJHuWfhTP7yIxR2KpVPqvyjKPawQFxSTmwSBkRDjLwgUxEjogMSJSLdHQMhnbVE63XhkbYjmquVlUyCSeugvg7/GsZRNrG+K1xzbp3FYWkjMQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dxd8y0DU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BC75C4CEC2
	for <linux-btrfs@vger.kernel.org>; Thu, 29 Aug 2024 23:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724972981;
	bh=84PDY27S+nKjmwsFWjg/FATJGNnFDPKDu+7tk61/ivk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=dxd8y0DUV8TgvJVEwVKfrthQor9+zv9Zb2D+5Vl5Qw3JlIjDobG0UfYc2U1sxJhGV
	 ENPuNT5abUd6EgRThlxW3Z9BKzI/WidTIIR332U1gpQkfEjNGgLUvOKue775C9y9MX
	 4l8IMnXVWdqUMJcKeUTeQ4Xd03ukr9JV6FXwI930NKvYplB7zjaNffvsNBZB3IRkoR
	 nZfNGx+HOJuCi697vJ5O8rNwmjy7/Jmx2DCNOpcvQov5svW6ZeAMeBixg+clprd9BT
	 /40+IM3ChWrhANhK8muBuLHHLHDD9Tl+mSF1v3MWZhPjzq6TfI01aOes6eHwbd8jJ1
	 JEMkbrQ/uvrTQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: fix race between direct IO write and fsync when using same fd
Date: Fri, 30 Aug 2024 00:09:36 +0100
Message-Id: <717029440fe379747b9548a9c91eb7801bc5a813.1724972507.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1724972506.git.fdmanana@suse.com>
References: <cover.1724972506.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

If we have 2 threads that are using the same file descriptor and one of
them is doing direct IO writes while the other is doing fsync, we have a
race where we can end up either:

1) Attempt a fsync without holding the inode's lock, triggering an
   assertion failures when assertions are enabled;

2) Do an invalid memory access from the fsync task because the file private
   points to memory allocated on stack by the direct IO task.

The race happens like this:

1) A user space program opens a file descriptor with O_DIRECT;

2) The program spawns 2 threads using libpthread for example;

3) One of the threads uses the file descriptor to do direct IO writes,
   while the other calls fsync using the same file descriptor.

4) Call task A the thread doing direct IO writes and task B the thread
   doing fsyncs;

5) Task A does a direct IO write, and at btrfs_direct_write() sets the
   file's private to an on stack allocated private with the member
   'fsync_skip_inode_lock' set to true;

6) Task B enters btrfs_sync_file() and sees that there's a private
   structure associated to the file which has 'fsync_skip_inode_lock' set
   to true, so it skips locking the inode's vfs lock;

7) Task completes the direct IO write, and resets the file's private to
   NULL since it had prior private and our private was stack allocated.
   Then it unlocks the inode's vfs lock;

8) Task B enters btrfs_get_ordered_extents_for_logging(), then the
   assertion that checks the inode's vfs lock is held fails, since task B
   never locked it and task A has already unlocked it.

The stack trace produced is the following:

   Aug 21 11:46:43 kerberos kernel: assertion failed: inode_is_locked(&inode->vfs_inode), in fs/btrfs/ordered-data.c:983
   Aug 21 11:46:43 kerberos kernel: ------------[ cut here ]------------
   Aug 21 11:46:43 kerberos kernel: kernel BUG at fs/btrfs/ordered-data.c:983!
   Aug 21 11:46:43 kerberos kernel: Oops: invalid opcode: 0000 [#1] PREEMPT SMP PTI
   Aug 21 11:46:43 kerberos kernel: CPU: 9 PID: 5072 Comm: worker Tainted: G     U     OE      6.10.5-1-default #1 openSUSE Tumbleweed 69f48d427608e1c09e60ea24c6c55e2ca1b049e8
   Aug 21 11:46:43 kerberos kernel: Hardware name: Acer Predator PH315-52/Covini_CFS, BIOS V1.12 07/28/2020
   Aug 21 11:46:43 kerberos kernel: RIP: 0010:btrfs_get_ordered_extents_for_logging.cold+0x1f/0x42 [btrfs]
   Aug 21 11:46:43 kerberos kernel: Code: 50 d6 86 c0 e8 (...)
   Aug 21 11:46:43 kerberos kernel: RSP: 0018:ffff9e4a03dcfc78 EFLAGS: 00010246
   Aug 21 11:46:43 kerberos kernel: RAX: 0000000000000054 RBX: ffff9078a9868e98 RCX: 0000000000000000
   Aug 21 11:46:43 kerberos kernel: RDX: 0000000000000000 RSI: ffff907dce4a7800 RDI: ffff907dce4a7800
   Aug 21 11:46:43 kerberos kernel: RBP: ffff907805518800 R08: 0000000000000000 R09: ffff9e4a03dcfb38
   Aug 21 11:46:43 kerberos kernel: R10: ffff9e4a03dcfb30 R11: 0000000000000003 R12: ffff907684ae7800
   Aug 21 11:46:43 kerberos kernel: R13: 0000000000000001 R14: ffff90774646b600 R15: 0000000000000000
   Aug 21 11:46:43 kerberos kernel: FS:  00007f04b96006c0(0000) GS:ffff907dce480000(0000) knlGS:0000000000000000
   Aug 21 11:46:43 kerberos kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
   Aug 21 11:46:43 kerberos kernel: CR2: 00007f32acbfc000 CR3: 00000001fd4fa005 CR4: 00000000003726f0
   Aug 21 11:46:43 kerberos kernel: Call Trace:
   Aug 21 11:46:43 kerberos kernel:  <TASK>
   Aug 21 11:46:43 kerberos kernel:  ? __die_body.cold+0x14/0x24
   Aug 21 11:46:43 kerberos kernel:  ? die+0x2e/0x50
   Aug 21 11:46:43 kerberos kernel:  ? do_trap+0xca/0x110
   Aug 21 11:46:43 kerberos kernel:  ? do_error_trap+0x6a/0x90
   Aug 21 11:46:43 kerberos kernel:  ? btrfs_get_ordered_extents_for_logging.cold+0x1f/0x42 [btrfs bb26272d49b4cdc847cf3f7faadd459b62caee9a]
   Aug 21 11:46:43 kerberos kernel:  ? exc_invalid_op+0x50/0x70
   Aug 21 11:46:43 kerberos kernel:  ? btrfs_get_ordered_extents_for_logging.cold+0x1f/0x42 [btrfs bb26272d49b4cdc847cf3f7faadd459b62caee9a]
   Aug 21 11:46:43 kerberos kernel:  ? asm_exc_invalid_op+0x1a/0x20
   Aug 21 11:46:43 kerberos kernel:  ? btrfs_get_ordered_extents_for_logging.cold+0x1f/0x42 [btrfs bb26272d49b4cdc847cf3f7faadd459b62caee9a]
   Aug 21 11:46:43 kerberos kernel:  ? btrfs_get_ordered_extents_for_logging.cold+0x1f/0x42 [btrfs bb26272d49b4cdc847cf3f7faadd459b62caee9a]
   Aug 21 11:46:43 kerberos kernel:  btrfs_sync_file+0x21a/0x4d0 [btrfs bb26272d49b4cdc847cf3f7faadd459b62caee9a]
   Aug 21 11:46:43 kerberos kernel:  ? __seccomp_filter+0x31d/0x4f0
   Aug 21 11:46:43 kerberos kernel:  __x64_sys_fdatasync+0x4f/0x90
   Aug 21 11:46:43 kerberos kernel:  do_syscall_64+0x82/0x160
   Aug 21 11:46:43 kerberos kernel:  ? do_futex+0xcb/0x190
   Aug 21 11:46:43 kerberos kernel:  ? __x64_sys_futex+0x10e/0x1d0
   Aug 21 11:46:43 kerberos kernel:  ? switch_fpu_return+0x4f/0xd0
   Aug 21 11:46:43 kerberos kernel:  ? syscall_exit_to_user_mode+0x72/0x220
   Aug 21 11:46:43 kerberos kernel:  ? do_syscall_64+0x8e/0x160
   Aug 21 11:46:43 kerberos kernel:  ? syscall_exit_to_user_mode+0x72/0x220
   Aug 21 11:46:43 kerberos kernel:  ? do_syscall_64+0x8e/0x160
   Aug 21 11:46:43 kerberos kernel:  ? syscall_exit_to_user_mode+0x72/0x220
   Aug 21 11:46:43 kerberos kernel:  ? do_syscall_64+0x8e/0x160
   Aug 21 11:46:43 kerberos kernel:  ? syscall_exit_to_user_mode+0x72/0x220
   Aug 21 11:46:43 kerberos kernel:  ? do_syscall_64+0x8e/0x160
   Aug 21 11:46:43 kerberos kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e

Another problem here is if task B grabs the private pointer and then uses
it after task A has finished, since the private was allocated in the stack
of trask A, resulting in some invalid memory access with a hard to predict
result.

This issue, triggering the assertion, was observed with QEMU workloads by
two users in the Link tags below.

Fix this by not relying on a file's private to pass information to fsync
that it should skip locking the inode and instead pass this information
through a special value stored in current->journal_info. This is safe
because in the relevant section of the direct IO write path we are not
holding a transaction handle, so current->journal_info is NULL.

The following C program triggers the issue:

   $ cat repro.c
   /* Get the O_DIRECT definition. */
   #ifndef _GNU_SOURCE
   #define _GNU_SOURCE
   #endif

   #include <stdio.h>
   #include <stdlib.h>
   #include <unistd.h>
   #include <stdint.h>
   #include <fcntl.h>
   #include <errno.h>
   #include <string.h>
   #include <pthread.h>

   static int fd;

   static ssize_t do_write(int fd, const void *buf, size_t count, off_t offset)
   {
       while (count > 0) {
           ssize_t ret;

           ret = pwrite(fd, buf, count, offset);
           if (ret < 0) {
               if (errno == EINTR)
                   continue;
               return ret;
           }
           count -= ret;
           buf += ret;
       }
       return 0;
   }

   static void *fsync_loop(void *arg)
   {
       while (1) {
           int ret;

           ret = fsync(fd);
           if (ret != 0) {
               perror("Fsync failed");
               exit(6);
           }
       }
   }

   int main(int argc, char *argv[])
   {
       long pagesize;
       void *write_buf;
       pthread_t fsyncer;
       int ret;

       if (argc != 2) {
           fprintf(stderr, "Use: %s <file path>\n", argv[0]);
           return 1;
       }

       fd = open(argv[1], O_WRONLY | O_CREAT | O_TRUNC | O_DIRECT, 0666);
       if (fd == -1) {
           perror("Failed to open/create file");
           return 1;
       }

       pagesize = sysconf(_SC_PAGE_SIZE);
       if (pagesize == -1) {
           perror("Failed to get page size");
           return 2;
       }

       ret = posix_memalign(&write_buf, pagesize, pagesize);
       if (ret) {
           perror("Failed to allocate buffer");
           return 3;
       }

       ret = pthread_create(&fsyncer, NULL, fsync_loop, NULL);
       if (ret != 0) {
           fprintf(stderr, "Failed to create writer thread: %d\n", ret);
           return 4;
       }

       while (1) {
           ret = do_write(fd, write_buf, pagesize, 0);
           if (ret != 0) {
               perror("Write failed");
               exit(5);
           }
       }

       return 0;
   }

   $ mkfs.btrfs -f /dev/sdi
   $ mount /dev/sdi /mnt/sdi
   $ timeout 10 ./repro /mnt/sdi/foo

Usually the race is triggered within less than 1 second. A test case for
fstests will follow soon.

Reported-by: Paulo Dias <paulo.miguel.dias@gmail.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=219187
Reported-by: Andreas Jahn <jahn-andi@web.de>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=219199
Reported-by: syzbot+4704b3cc972bd76024f1@syzkaller.appspotmail.com
Link: https://lore.kernel.org/linux-btrfs/00000000000044ff540620d7dee2@google.com/
Fixes: 939b656bc8ab ("btrfs: fix corruption after buffer fault in during direct IO append write")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.h       |  1 -
 fs/btrfs/direct-io.c   | 16 +++-------------
 fs/btrfs/file.c        |  9 +++++++--
 fs/btrfs/transaction.h |  6 ++++++
 4 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 75fa563e4cac..c8568b1a61c4 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -459,7 +459,6 @@ struct btrfs_file_private {
 	void *filldir_buf;
 	u64 last_index;
 	struct extent_state *llseek_cached_state;
-	bool fsync_skip_inode_lock;
 };
 
 static inline u32 BTRFS_LEAF_DATA_SIZE(const struct btrfs_fs_info *info)
diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
index 67adbe9d294a..364bce34f034 100644
--- a/fs/btrfs/direct-io.c
+++ b/fs/btrfs/direct-io.c
@@ -864,13 +864,6 @@ ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	if (IS_ERR_OR_NULL(dio)) {
 		ret = PTR_ERR_OR_ZERO(dio);
 	} else {
-		struct btrfs_file_private stack_private = { 0 };
-		struct btrfs_file_private *private;
-		const bool have_private = (file->private_data != NULL);
-
-		if (!have_private)
-			file->private_data = &stack_private;
-
 		/*
 		 * If we have a synchronous write, we must make sure the fsync
 		 * triggered by the iomap_dio_complete() call below doesn't
@@ -879,13 +872,10 @@ ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 		 * partial writes due to the input buffer (or parts of it) not
 		 * being already faulted in.
 		 */
-		private = file->private_data;
-		private->fsync_skip_inode_lock = true;
+		ASSERT(current->journal_info == NULL);
+		current->journal_info = BTRFS_TRANS_DIO_WRITE_STUB;
 		ret = iomap_dio_complete(dio);
-		private->fsync_skip_inode_lock = false;
-
-		if (!have_private)
-			file->private_data = NULL;
+		current->journal_info = NULL;
 	}
 
 	/* No increment (+=) because iomap returns a cumulative value. */
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 76f4cc686af9..c7a7234998aa 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1603,7 +1603,6 @@ static inline bool skip_inode_logging(const struct btrfs_log_ctx *ctx)
  */
 int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 {
-	struct btrfs_file_private *private = file->private_data;
 	struct dentry *dentry = file_dentry(file);
 	struct btrfs_inode *inode = BTRFS_I(d_inode(dentry));
 	struct btrfs_root *root = inode->root;
@@ -1613,7 +1612,13 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	int ret = 0, err;
 	u64 len;
 	bool full_sync;
-	const bool skip_ilock = (private ? private->fsync_skip_inode_lock : false);
+	bool skip_ilock = false;
+
+	if (current->journal_info == BTRFS_TRANS_DIO_WRITE_STUB) {
+		skip_ilock = true;
+		current->journal_info = NULL;
+		lockdep_assert_held(&inode->vfs_inode.i_rwsem);
+	}
 
 	trace_btrfs_sync_file(file, datasync);
 
diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
index 98c03ddc760b..dd9ce9b9f69e 100644
--- a/fs/btrfs/transaction.h
+++ b/fs/btrfs/transaction.h
@@ -27,6 +27,12 @@ struct btrfs_root_item;
 struct btrfs_root;
 struct btrfs_path;
 
+/*
+ * Signal that a direct IO write is in progress, to avoid deadlock for sync
+ * direct IO writes when fsync is called during the direct IO write path.
+ */
+#define BTRFS_TRANS_DIO_WRITE_STUB	((void *) 1)
+
 /* Radix-tree tag for roots that are part of the trasaction. */
 #define BTRFS_ROOT_TRANS_TAG			0
 
-- 
2.43.0


