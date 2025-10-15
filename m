Return-Path: <linux-btrfs+bounces-17818-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC21DBDD220
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 09:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 298751894371
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 07:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77417314D19;
	Wed, 15 Oct 2025 07:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cqsoftware.com.cn header.i=@cqsoftware.com.cn header.b="fEikvD+Z"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-m19731114.qiye.163.com (mail-m19731114.qiye.163.com [220.197.31.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE5531354D;
	Wed, 15 Oct 2025 07:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760513384; cv=none; b=pWrf86C+NZqfbbx1s0HuB1LGUhI04gFeotyza+Dg14an4a7xgJ6glplMssbEQ7hTpp/61PoeGcM/pzb2YNDYLTwRRgBmSjb30qPZvkUi+T47cM+rpgs9+bqnmVKNFCVF32xii+hjIO22ERqedeccslgXCv9Bbn31+n0JD0K+6tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760513384; c=relaxed/simple;
	bh=/263++/m7q9+2Q4gmmg4rihQBpm9tLducJOnOvMNLP8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cv7v01qkALPgDFF2idFpcA9R9PFbL0dfdbFB092+3v0DYkHTPXf8MDBA8RwaZ8/31FgWa2s4seGbt2vmM6FnvJkaR0xBXwHmU7Rsmg+54Kh74MbSV+5/EHWTgnP592vL9xo5gVnEw5fLc/NEAnq5e8ORgahD9Tv+BPl2aNLAuvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cqsoftware.com.cn; spf=pass smtp.mailfrom=cqsoftware.com.cn; dkim=pass (1024-bit key) header.d=cqsoftware.com.cn header.i=@cqsoftware.com.cn header.b=fEikvD+Z; arc=none smtp.client-ip=220.197.31.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cqsoftware.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cqsoftware.com.cn
Received: from localhost.lan (unknown [1.193.59.83])
	by smtp.qiye.163.com (Hmail) with ESMTP id 25f9932f6;
	Wed, 15 Oct 2025 15:24:23 +0800 (GMT+08:00)
From: Dewei Meng <mengdewei@cqsoftware.com.cn>
To: clm@fb.com,
	dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	josef@toxicpanda.com,
	Dewei Meng <mengdewei@cqsoftware.com.cn>
Subject: [PATCH] btrfs: Fix NULL pointer access in btrfs_check_leaked_roots()
Date: Wed, 15 Oct 2025 15:24:21 +0800
Message-ID: <20251015072421.4538-1-mengdewei@cqsoftware.com.cn>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a99e6c17a9703abkunm885e09de2db98f
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCTElJVhgeQ01DSx5ISR8dTVYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKVUpCSFVOQlVDSFlXWRYaDxIVHRRZQVlPS0hVSktJT09PSFVKS0tVSk
	JLS1kG
DKIM-Signature: a=rsa-sha256;
	b=fEikvD+ZUQeLO0+c5EpxJKy0kIqbPlUoKEIzCfA439e0NKsBEJ6na21npdR6Bulv0ajwgEy2v88z9FaIl60SLcPxD0XDbPTNo06+ZfJbmdZuyAUlE2o/nzczj9HEhO3B87eA8aQhPjoKToPqCmCbGKDiDPpLKj5zAWm3YgQCM54=; s=default; c=relaxed/relaxed; d=cqsoftware.com.cn; v=1;
	bh=ddstwpdehikxIME2JcPzaNnl8dY86rx7p4W6Psa9aeE=;
	h=date:mime-version:subject:message-id:from;

If fs_info->super_copy or fs_info->super_for_commit is NULL in
btrfs_get_tree_subvol(), the btrfs_check_leaked_roots() will get the
btrfs_root list entry using the fs_info->allocated_roots->next
which is NULL.

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

This should check if the fs_info->allocated_roots->next is NULL before
accessing it.

Fixes: 3bb17a25bcb0 ("btrfs: add get_tree callback for new mount API")
Signed-off-by: Dewei Meng <mengdewei@cqsoftware.com.cn>
---
 fs/btrfs/disk-io.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 0aa7e5d1b05f..76db7f98187a 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1213,6 +1213,9 @@ void btrfs_check_leaked_roots(const struct btrfs_fs_info *fs_info)
 #ifdef CONFIG_BTRFS_DEBUG
 	struct btrfs_root *root;
 
+	if (!fs_info->allocated_roots.next)
+		return;
+
 	while (!list_empty(&fs_info->allocated_roots)) {
 		char buf[BTRFS_ROOT_NAME_BUF_LEN];
 
-- 
2.43.5


