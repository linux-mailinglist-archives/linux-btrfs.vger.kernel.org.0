Return-Path: <linux-btrfs+bounces-12814-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C7CA7CB1C
	for <lists+linux-btrfs@lfdr.de>; Sat,  5 Apr 2025 19:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E8977A7FA2
	for <lists+linux-btrfs@lfdr.de>; Sat,  5 Apr 2025 17:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718EB18EFD1;
	Sat,  5 Apr 2025 17:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGTk4jze"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC67870838
	for <linux-btrfs@vger.kernel.org>; Sat,  5 Apr 2025 17:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743875503; cv=none; b=JLy3VqJrZlus6UqNsXDk0oyE90u8vwUf8rhcNis+dYkyEvSdf/kTfb3DErkEhpCLzg5S4eIHUTL4T5fpCvDb0ihXB4VjWQdNcH6NiwjywHDQBW8wq/n1Wu9CHZ8nzohWyizIUOmdc2la1zbpKjsMsBXoSvthMP0ex4BZZKcQ33o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743875503; c=relaxed/simple;
	bh=kRSeH9Y2v8DmCk1Sn/ZQjf1+oxxxdvKlo/TKF8rku24=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=a12Rz971/ShxzTHcu0vcZ/sjSJd8XKtZK97LKG/hYgu/bR0wlwl0xjAvJwO1RSB2xcnT7tGpQjTV6XSG1vdBWEsleblpQZ5uDDZcSwF3XXmoCXBehMja3l7fdm5g6T3mKXInSw097kznV6luCKXoflrcrZ70ySvD7fl2IbgKqDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZGTk4jze; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83915C4CEE4
	for <linux-btrfs@vger.kernel.org>; Sat,  5 Apr 2025 17:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743875503;
	bh=kRSeH9Y2v8DmCk1Sn/ZQjf1+oxxxdvKlo/TKF8rku24=;
	h=From:To:Subject:Date:From;
	b=ZGTk4jze3pQS0yxJLZ61+krYZIQSrXMSezAZj7DtNCqG+438u22EkbTWiE4QZ7ewi
	 HC3N9PArnQngzfANAPQqmdXZfNgsdIm4YzfNeINkGUK8pdlJOn1GMXojz9wQfOrQ7g
	 wNI2B/5Hci+Gx6uQv6wKs2kmcO/Qkcde5UyCwNPKgADZPHd1DV/vharlMNcdrZCzOD
	 cO9xm3I6CDT2LMNiG+IKp+XW9myhHdEXudTEkt9+TbGoWc94dF2HnFbI8VRJMDnv95
	 mqDblLGjdX7waUZm17xjwqn0/sfC7Kv28QaiYbIPV3IgDeC26SNJMGDsFzO00Qtd9u
	 K3DlQUpJnkyNg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix invalid inode pointer after failure to create reloc inode
Date: Sat,  5 Apr 2025 18:51:39 +0100
Message-Id: <9ac220a55a540ad22f7cb198856b689079f3e8c6.1743875430.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

If we have a failure at create_reloc_inode(), under the 'out' label we
assign an error pointer to the 'inode' variable and then return a weird
pointer because we return the expression "&inode->vfs_inode":

   static noinline_for_stack struct inode *create_reloc_inode(
                                    const struct btrfs_block_group *group)
   {
       (...)
   out:
       (...)
       if (ret) {
            if (inode)
                  iput(&inode->vfs_inode);
            inode = ERR_PTR(ret);
       }
       return &inode->vfs_inode;
}

This can make us return a pointer that is not an error pointer and make
the caller proceed as if an error didn't happen and later result in an
invalid memory access when dereferencing the inode pointer. The syzbot
reported such a case with the following stack trace:

   R10: 0000000000000002 R11: 0000000000000246 R12: 0000000000000000
   R13: 0000000000000000 R14: 431bde82d7b634db R15: 00007ffc55de5790
    </TASK>
   BTRFS info (device loop0): relocating block group 6881280 flags data|metadata
   Oops: general protection fault, probably for non-canonical address 0xdffffc0000000045: 0000 [#1] SMP KASAN NOPTI
   KASAN: null-ptr-deref in range [0x0000000000000228-0x000000000000022f]
   CPU: 0 UID: 0 PID: 5332 Comm: syz-executor215 Not tainted 6.14.0-syzkaller-13423-ga8662bcd2ff1 #0 PREEMPT(full)
   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
   RIP: 0010:relocate_file_extent_cluster+0xe7/0x1750 fs/btrfs/relocation.c:2971
   Code: 00 74 08 48 89 df e8 f8 36 24 fe 48 89 9c 24 30 01 00 00 4c 89 74 24 28 4d 8b 76 10 49 8d 9e 98 fe ff ff 48 89 d8 48 c1 e8 03 <42> 80 3c 20 00 74 08 48 89 df e8 ca 36 24 fe 4c 8b 3b 48 8b 44 24
   RSP: 0018:ffffc9000d3375e0 EFLAGS: 00010203
   RAX: 0000000000000045 RBX: 000000000000022c RCX: ffff888000562440
   RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8880452db000
   RBP: ffffc9000d337870 R08: ffffffff84089251 R09: 0000000000000000
   R10: 0000000000000000 R11: 0000000000000000 R12: dffffc0000000000
   R13: ffffffff9368a020 R14: 0000000000000394 R15: ffff8880452db000
   FS:  000055558bc7b380(0000) GS:ffff88808c596000(0000) knlGS:0000000000000000
   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
   CR2: 000055a7a192e740 CR3: 0000000036e2e000 CR4: 0000000000352ef0
   DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
   DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
   Call Trace:
    <TASK>
    relocate_block_group+0xa1e/0xd50 fs/btrfs/relocation.c:3657
    btrfs_relocate_block_group+0x777/0xd80 fs/btrfs/relocation.c:4011
    btrfs_relocate_chunk+0x12c/0x3b0 fs/btrfs/volumes.c:3511
    __btrfs_balance+0x1a93/0x25e0 fs/btrfs/volumes.c:4292
    btrfs_balance+0xbde/0x10c0 fs/btrfs/volumes.c:4669
    btrfs_ioctl_balance+0x3f5/0x660 fs/btrfs/ioctl.c:3586
    vfs_ioctl fs/ioctl.c:51 [inline]
    __do_sys_ioctl fs/ioctl.c:906 [inline]
    __se_sys_ioctl+0xf1/0x160 fs/ioctl.c:892
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xf3/0x230 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f
   RIP: 0033:0x7fb4ef537dd9
   Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 01 1b 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
   RSP: 002b:00007ffc55de5728 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
   RAX: ffffffffffffffda RBX: 00007ffc55de5750 RCX: 00007fb4ef537dd9
   RDX: 0000200000000440 RSI: 00000000c4009420 RDI: 0000000000000003
   RBP: 0000000000000002 R08: 00007ffc55de54c6 R09: 00007ffc55de5770
   R10: 0000000000000002 R11: 0000000000000246 R12: 0000000000000000
   R13: 0000000000000000 R14: 431bde82d7b634db R15: 00007ffc55de5790
    </TASK>
   Modules linked in:
   ---[ end trace 0000000000000000 ]---
   RIP: 0010:relocate_file_extent_cluster+0xe7/0x1750 fs/btrfs/relocation.c:2971
   Code: 00 74 08 48 89 df e8 f8 36 24 fe 48 89 9c 24 30 01 00 00 4c 89 74 24 28 4d 8b 76 10 49 8d 9e 98 fe ff ff 48 89 d8 48 c1 e8 03 <42> 80 3c 20 00 74 08 48 89 df e8 ca 36 24 fe 4c 8b 3b 48 8b 44 24
   RSP: 0018:ffffc9000d3375e0 EFLAGS: 00010203
   RAX: 0000000000000045 RBX: 000000000000022c RCX: ffff888000562440
   RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8880452db000
   RBP: ffffc9000d337870 R08: ffffffff84089251 R09: 0000000000000000
   R10: 0000000000000000 R11: 0000000000000000 R12: dffffc0000000000
   R13: ffffffff9368a020 R14: 0000000000000394 R15: ffff8880452db000
   FS:  000055558bc7b380(0000) GS:ffff88808c596000(0000) knlGS:0000000000000000
   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
   CR2: 000055a7a192e740 CR3: 0000000036e2e000 CR4: 0000000000352ef0
   DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
   DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
   ----------------
   Code disassembly (best guess):
      0:	00 74 08 48          	add    %dh,0x48(%rax,%rcx,1)
      4:	89 df                	mov    %ebx,%edi
      6:	e8 f8 36 24 fe       	call   0xfe243703
      b:	48 89 9c 24 30 01 00 	mov    %rbx,0x130(%rsp)
     12:	00
     13:	4c 89 74 24 28       	mov    %r14,0x28(%rsp)
     18:	4d 8b 76 10          	mov    0x10(%r14),%r14
     1c:	49 8d 9e 98 fe ff ff 	lea    -0x168(%r14),%rbx
     23:	48 89 d8             	mov    %rbx,%rax
     26:	48 c1 e8 03          	shr    $0x3,%rax
   * 2a:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1) <-- trapping instruction
     2f:	74 08                	je     0x39
     31:	48 89 df             	mov    %rbx,%rdi
     34:	e8 ca 36 24 fe       	call   0xfe243703
     39:	4c 8b 3b             	mov    (%rbx),%r15
     3c:	48                   	rex.W
     3d:	8b                   	.byte 0x8b
     3e:	44                   	rex.R
     3f:	24                   	.byte 0x24

So fix this by returning the error immediately.

Fixes: 00aad5080c51 ("btrfs: make btrfs_iget() return a btrfs inode instead")
Reported-by: syzbot+7481815bb47ef3e702e2@syzkaller.appspotmail.com
Link: https://lore.kernel.org/linux-btrfs/67f14ee9.050a0220.0a13.023e.GAE@google.com/
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/relocation.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 62b69274ec03..4bfc5403cf17 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3801,7 +3801,7 @@ static noinline_for_stack struct inode *create_reloc_inode(
 	if (ret) {
 		if (inode)
 			iput(&inode->vfs_inode);
-		inode = ERR_PTR(ret);
+		return ERR_PTR(ret);
 	}
 	return &inode->vfs_inode;
 }
-- 
2.45.2


