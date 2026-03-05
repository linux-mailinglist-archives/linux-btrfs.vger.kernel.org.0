Return-Path: <linux-btrfs+bounces-22260-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFV5BnbkqWl1HAEAu9opvQ
	(envelope-from <linux-btrfs+bounces-22260-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 05 Mar 2026 21:15:50 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E13D421812A
	for <lists+linux-btrfs@lfdr.de>; Thu, 05 Mar 2026 21:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6512B308EF6F
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Mar 2026 20:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141C03EDAD5;
	Thu,  5 Mar 2026 20:02:28 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132B23D1CC5
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Mar 2026 20:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772740947; cv=none; b=KtiQxnqlS/iT3BS99cEOg6QqVnG1un64UqDuraTuYtsk8sOMIt7ueYTpBAgoIidlJdJ8EiGoXQMeiC8tq2CCxuQ4OtAvZfsIkwCN2sHjD4zH2FKNYLrtmZPqDSyhLNmQBsaMhLIbA4k/FJexijuYdh6GSWyPEVVElkAPkTPc2yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772740947; c=relaxed/simple;
	bh=82LI6am3IpEjqPysmd+0CBKDp5U4OF7zln8rPn6wElI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=coE7p5SvID1zZZwmI0wGwU4SUBBxSyp8FgJP/UEvHdGq/5fYGei4zpGncAvK00JijBE7WP4RO8PovXPDB7vE1Uo7u9wAWEqHISqQK4uqk8tw+99NpJ8u1SqGjKl7w1XHTmTuU8CPHQJr3pTOX+afTDLLpKuu9dstMOWmSNogWKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7d4bd29099eso89022267a34.2
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Mar 2026 12:02:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772740945; x=1773345745;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aJA5z2DMlBTZZFhkD5HKCaDZZHdzxE7yZ04nSOqhFKE=;
        b=JV3MGm1Gs9rCgdf4HX7XBVZ0ODDmrUYrNWMT6N+NV/gJN4mhjvBkKOr4C6Ov80rLPs
         I0kbZL0E+W2jQO4JYJxooqxmyPjv2JpBdQLDFXtOK1eOg/6X4GwkoZfHXili+JFCS9hG
         zRh0JukF/BgmUI+KsX8nHaoKhSUrai7xtATx2U5YC36+Ae9pjAOI/Rk81RQsWD1tl/o5
         AfOCNyjGoyV9T1tna8DVV+zlv4ELG0qf1OYLZor8wpQkT7B9tkFiKEAVBsCTc0mprgjP
         2YVJNHv0ev5GK62HQsuC2MOxHpYfm+JknUCJCllalYVq1+0A7W8wtQC/hTpNeNIPGMb9
         sp7A==
X-Forwarded-Encrypted: i=1; AJvYcCUsE8hx0a351034CsW3kLfPxEqMy1lN8V8FRIQmKEhfAtKf3kGX3vXADNfIKSTzggVZqv15ZnKZl0cOzg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzH6OOs4t/RuwVw1ROLzvzS6ISBFP2xxn0D2bJTMxapwtZwFw7C
	B6XwYg8abUua4YBcygluY/rQgLlJiCDYUuP/NzTUqJafJh17Vxt4RliUrD2SyglzSDPu4K9Be6A
	HLPTSPtEd++8tyRzz+TYmFRb7ecg53IO6Ox5c4scNqb32F8oSlI4CM5Jqd+Y=
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:4f08:b0:45c:8526:b56a with SMTP id
 5614622812f47-4651ab3956amr3635006b6e.3.1772740945117; Thu, 05 Mar 2026
 12:02:25 -0800 (PST)
Date: Thu, 05 Mar 2026 12:02:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69a9e151.050a0220.13f275.0000.GAE@google.com>
Subject: [syzbot] [btrfs?] kernel BUG in mapping_try_invalidate (2)
From: syzbot <syzbot+bdad05f2e28a336132a6@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: E13D421812A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=70fe0401f305d8d4];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22260-lists,linux-btrfs=lfdr.de,bdad05f2e28a336132a6];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,appspotmail.com:email,googlegroups.com:email,goo.gl:url,storage.googleapis.com:url]
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    eb71ab2bf722 Merge tag 'bpf-fixes' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1749a202580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=70fe0401f305d8d4
dashboard link: https://syzkaller.appspot.com/bug?extid=bdad05f2e28a336132a6
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/222ddc146de5/disk-eb71ab2b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a5d8a5d85aad/vmlinux-eb71ab2b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1bac21c0baa2/bzImage-eb71ab2b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bdad05f2e28a336132a6@syzkaller.appspotmail.com

 blkdev_read_iter+0x311/0x440 block/fops.c:855
 new_sync_read fs/read_write.c:493 [inline]
 vfs_read+0x58b/0xa80 fs/read_write.c:574
 ksys_read+0x156/0x270 fs/read_write.c:717
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 28 tgid 28 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1433 [inline]
 __free_frozen_pages+0xfe3/0x1170 mm/page_alloc.c:2978
 __tlb_remove_table_free mm/mmu_gather.c:228 [inline]
 tlb_remove_table_rcu+0x85/0x100 mm/mmu_gather.c:291
 rcu_do_batch kernel/rcu/tree.c:2617 [inline]
 rcu_core kernel/rcu/tree.c:2869 [inline]
 rcu_cpu_kthread+0x99e/0x1470 kernel/rcu/tree.c:2957
 smpboot_thread_fn+0x541/0xa50 kernel/smpboot.c:160
 kthread+0x388/0x470 kernel/kthread.c:467
 ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
------------[ cut here ]------------
kernel BUG at mm/filemap.c:2185!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 1 UID: 0 PID: 8836 Comm: syz.0.423 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
RIP: 0010:find_lock_entries+0xa8a/0xa90 mm/filemap.c:2184
Code: 8b 7c 24 18 48 c7 c6 a0 bd 57 8b e8 70 38 28 ff 90 0f 0b e8 58 cb c4 ff 48 8b 7c 24 18 48 c7 c6 40 b6 57 8b e8 57 38 28 ff 90 <0f> 0b 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90006de75c0 EFLAGS: 00010246
RAX: b8fe3e8dac16f000 RBX: ffffc90006de7a00 RCX: 0000000000000046
RDX: 0000000000000003 RSI: ffffffff8d7b842e RDI: ffff888024b95ac0
RBP: ffffc90006de7710 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: ffffed1017124923 R12: ffffea00016a8000
R13: 0000000000000fce R14: 0000000000000000 R15: 0000000000000001
FS:  00007f85361366c0(0000) GS:ffff888126440000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f43dc4b7000 CR3: 0000000038050000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 mapping_try_invalidate+0x1ae/0x4c0 mm/truncate.c:545
 btrfs_get_bdev_and_sb+0x114/0x340 fs/btrfs/volumes.c:501
 btrfs_open_one_device fs/btrfs/volumes.c:666 [inline]
 open_fs_devices+0x1d6/0x1440 fs/btrfs/volumes.c:1248
 btrfs_get_tree_super fs/btrfs/super.c:1928 [inline]
 btrfs_get_tree_subvol fs/btrfs/super.c:2087 [inline]
 btrfs_get_tree+0xbe8/0x1930 fs/btrfs/super.c:2121
 vfs_get_tree+0x92/0x2a0 fs/super.c:1754
 fc_mount fs/namespace.c:1193 [inline]
 do_new_mount_fc fs/namespace.c:3763 [inline]
 do_new_mount+0x341/0xd30 fs/namespace.c:3839
 do_mount fs/namespace.c:4172 [inline]
 __do_sys_mount fs/namespace.c:4361 [inline]
 __se_sys_mount+0x31d/0x420 fs/namespace.c:4338
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8537edda0a
Code: 48 c7 c2 e8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8536135e58 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f8536135ee0 RCX: 00007f8537edda0a
RDX: 0000200000005100 RSI: 0000200000000300 RDI: 00007f8536135ea0
RBP: 0000200000005100 R08: 00007f8536135ee0 R09: 0000000000000016
R10: 0000000000000016 R11: 0000000000000246 R12: 0000200000000300
R13: 00007f8536135ea0 R14: 0000000000005102 R15: 0000200000000380
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:find_lock_entries+0xa8a/0xa90 mm/filemap.c:2184
Code: 8b 7c 24 18 48 c7 c6 a0 bd 57 8b e8 70 38 28 ff 90 0f 0b e8 58 cb c4 ff 48 8b 7c 24 18 48 c7 c6 40 b6 57 8b e8 57 38 28 ff 90 <0f> 0b 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90006de75c0 EFLAGS: 00010246
RAX: b8fe3e8dac16f000 RBX: ffffc90006de7a00 RCX: 0000000000000046
RDX: 0000000000000003 RSI: ffffffff8d7b842e RDI: ffff888024b95ac0
RBP: ffffc90006de7710 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: ffffed1017124923 R12: ffffea00016a8000
R13: 0000000000000fce R14: 0000000000000000 R15: 0000000000000001
FS:  00007f85361366c0(0000) GS:ffff888126440000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f43dc4b7000 CR3: 0000000038050000 CR4: 00000000003526f0


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

