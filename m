Return-Path: <linux-btrfs+bounces-17868-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D0DBE1ACB
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Oct 2025 08:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F85519C7847
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Oct 2025 06:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E2E256C71;
	Thu, 16 Oct 2025 06:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cqsoftware.com.cn header.i=@cqsoftware.com.cn header.b="BgYWF9k/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-m1973178.qiye.163.com (mail-m1973178.qiye.163.com [220.197.31.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B3B25524C;
	Thu, 16 Oct 2025 06:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760595051; cv=none; b=blssGFotkNTXuEuBU2LoIlK4rqQ3jOHtKqa83QJ0I3sIj+FEtQpQ9Eyt9InNXtQi0UmUmek4Go5iBxZ8mtm4BOT4X0JpKov8VI+q+QR4bowPFGHvtcRSo5I09pnZUaeb2Ikl49uQAvtpnr4p4gYwv0Fz3NO4lZBXuf+4POldQ24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760595051; c=relaxed/simple;
	bh=oCw789xmCGRjiexvmqDKIjY5sP+ymSwLge1g9i9Ykt8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fSZutVFSUr+4kT2L/hJaitOJCMe3VuQlZ+op547jSt6tQrymt+nz/mdi2pcea31jP8J03Nchr/gzr3wehmE8KCxBfWm0e1wAOoK9r3hw6Wen40mf/HXzHHaD9tDcLsgK+IegD9uAV7h30+/o+1/Bq0KXsgjCuXenyE6XsIjvWb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cqsoftware.com.cn; spf=pass smtp.mailfrom=cqsoftware.com.cn; dkim=pass (1024-bit key) header.d=cqsoftware.com.cn header.i=@cqsoftware.com.cn header.b=BgYWF9k/; arc=none smtp.client-ip=220.197.31.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cqsoftware.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cqsoftware.com.cn
Received: from localhost.lan (unknown [1.193.59.83])
	by smtp.qiye.163.com (Hmail) with ESMTP id 261a0f673;
	Thu, 16 Oct 2025 14:10:37 +0800 (GMT+08:00)
From: Dewei Meng <mengdewei@cqsoftware.com.cn>
To: clm@fb.com,
	dsterba@suse.com,
	quwenruo.btrfs@gmx.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dewei Meng <mengdewei@cqsoftware.com.cn>,
	Daniel Vacek <neelx@suse.com>
Subject: [PATCH v2] btrfs: Fix NULL pointer access in btrfs_check_leaked_roots()
Date: Thu, 16 Oct 2025 14:10:11 +0800
Message-ID: <20251016061011.22946-1-mengdewei@cqsoftware.com.cn>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a99eba44df703abkunm99c4ff8f44f937
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCH0lMVkhCSE1JSEtLTk5JT1YVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKVUpCSFVOQlVDSFlXWRYaDxIVHRRZQVlPS0hVSktJT09PSFVKS0tVSk
	JLS1kG
DKIM-Signature: a=rsa-sha256;
	b=BgYWF9k/MggL+NVTWlEQIl2Sd2zMjPknFLfvTLKQviehFK1ROIQGNXYzkxpIoDAFXC5BSYAcWUDuXUMXs6DU9M23YaJ8kz19uYFqSm5zjvkjPnxaQmn6dgupebdg5QV93t+SGJd5iAGsmV/RcfY4COJ89GfqKLUxcs3gLSnTWTw=; s=default; c=relaxed/relaxed; d=cqsoftware.com.cn; v=1;
	bh=OUxMx3bMWLOXcjTSF9y3dYvaaaxjFJZL9tcr3oOVZbs=;
	h=date:mime-version:subject:message-id:from;

If fs_info->super_copy or fs_info->super_for_commit allocated failed in
btrfs_get_tree_subvol(), then no need to call btrfs_free_fs_info().
Otherwise btrfs_check_leaked_roots() would access NULL pointer because
fs_info->allocated_roots had not been initialised.

syzkaller reported the following information:
  ------------[ cut here ]------------
  BUG: unable to handle page fault for address: fffffffffffffbb0
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  PGD 64c9067 P4D 64c9067 PUD 64cb067 PMD 0
  Oops: Oops: 0000 [#1] SMP KASAN PTI
  CPU: 0 UID: 0 PID: 1402 Comm: syz.1.35 Not tainted 6.15.8 #4 PREEMPT(lazy)
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), (...)
  RIP: 0010:arch_atomic_read arch/x86/include/asm/atomic.h:23 [inline]
  RIP: 0010:raw_atomic_read include/linux/atomic/atomic-arch-fallback.h:457 [inline]
  RIP: 0010:atomic_read include/linux/atomic/atomic-instrumented.h:33 [inline]
  RIP: 0010:refcount_read include/linux/refcount.h:170 [inline]
  RIP: 0010:btrfs_check_leaked_roots+0x18f/0x2c0 fs/btrfs/disk-io.c:1230
  [...]
  Call Trace:
   <TASK>
   btrfs_free_fs_info+0x310/0x410 fs/btrfs/disk-io.c:1280
   btrfs_get_tree_subvol+0x592/0x6b0 fs/btrfs/super.c:2029
   btrfs_get_tree+0x63/0x80 fs/btrfs/super.c:2097
   vfs_get_tree+0x98/0x320 fs/super.c:1759
   do_new_mount+0x357/0x660 fs/namespace.c:3899
   path_mount+0x716/0x19c0 fs/namespace.c:4226
   do_mount fs/namespace.c:4239 [inline]
   __do_sys_mount fs/namespace.c:4450 [inline]
   __se_sys_mount fs/namespace.c:4427 [inline]
   __x64_sys_mount+0x28c/0x310 fs/namespace.c:4427
   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
   do_syscall_64+0x92/0x180 arch/x86/entry/syscall_64.c:94
   entry_SYSCALL_64_after_hwframe+0x76/0x7e
  RIP: 0033:0x7f032eaffa8d
  [...]

Fixes: 3bb17a25bcb0 ("btrfs: add get_tree callback for new mount API")
Signed-off-by: Dewei Meng <mengdewei@cqsoftware.com.cn>
Reviewed-by: Daniel Vacek <neelx@suse.com>
---
V1 -> V2:
- Revise the patch description to make it easier to read
- Delete btrfs_free_fs_info() when super_copy/super_for_commit allocated
  failed, instead of NULL pointer check in btrfs_check_leaked_roots()

 fs/btrfs/super.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index d6e496436539..dc95e697b22b 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2069,7 +2069,9 @@ static int btrfs_get_tree_subvol(struct fs_context *fc)
 	fs_info->super_copy = kzalloc(BTRFS_SUPER_INFO_SIZE, GFP_KERNEL);
 	fs_info->super_for_commit = kzalloc(BTRFS_SUPER_INFO_SIZE, GFP_KERNEL);
 	if (!fs_info->super_copy || !fs_info->super_for_commit) {
-		btrfs_free_fs_info(fs_info);
+		kfree(fs_info->super_copy);
+		kfree(fs_info->super_for_commit);
+		kvfree(fs_info);
 		return -ENOMEM;
 	}
 	btrfs_init_fs_info(fs_info);
-- 
2.43.5


