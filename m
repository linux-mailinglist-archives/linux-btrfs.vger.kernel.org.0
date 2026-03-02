Return-Path: <linux-btrfs+bounces-22154-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id xRz1J+XapWkvHgAAu9opvQ
	(envelope-from <linux-btrfs+bounces-22154-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 02 Mar 2026 19:45:57 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4981DE72B
	for <lists+linux-btrfs@lfdr.de>; Mon, 02 Mar 2026 19:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9F0C3051D29
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Mar 2026 18:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2F03431E6;
	Mon,  2 Mar 2026 18:45:43 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B83C430BAA
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Mar 2026 18:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772477143; cv=none; b=SDPkItYSMmO2snhl7mvWGs+WzFmruDAiHQST09Ja3gOEatEpNSlMNTWCQlgH1RlbhQrZOv4t/2BzvETGKrE2cORcjp8NU/ljMcp6MAZgYXZZ6f2ZzNR/uiBBjPXB4UM5oINQ8N2bd8315EhODnv1q9pTrsvv6H7OOvZbD9iL0rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772477143; c=relaxed/simple;
	bh=BNQWtdRHuO3S+gGOscSXOqbfLFQhgJQr/6SBZrjZhek=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=D0DZx0kknIJsYfVR/kGCu+BaN3FYKG0SbKeCGVDJDAGaoKQX8HNbcmz7L6DKrq/lkd1tJoygJLRG5zHwxI+VPmdFW8ER6eATAJ/s8RgdbJhyaf1Fpfv3OuORdMmA9oIB3tSo/HxbU48CUe/mSaep4m1rawQSZO7nl0eXC7/JLP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-679dda090fbso97352362eaf.2
        for <linux-btrfs@vger.kernel.org>; Mon, 02 Mar 2026 10:45:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772477141; x=1773081941;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KKp7i17aMM9L6WuRWWndlSaZEHbB7jCUXWvpqpj5i2M=;
        b=bjI1jExgWBswQHmn63pmIMQ93+EVTqQCDDcrsjzsJyAYwQbsHGxhRqk+XXgUSHawzM
         BKxjDZN40Fe4ALQ+KlGjcdMHRqmolThQs7IRoENphkGJMWI9jOld7HneNEZXcbX8POvQ
         0spXTtuUuy/TnWe9d5eyDdwd6DRRjpwKldvPb2ZYFcE3GEBTlaeeMMK7tqEBlALga4/S
         WHowJl1lTVTIueAuDW9Cs+QoT8KZvcJkbCm8dMlhAcVO89nKBHXF0F/1YS6LhbcBLDv5
         O/gO9yZXDziXHaC8PXnBLud4dpdXKQ4DS5hJkVYgx8VeiQYZYsjfUsHJK/KFpIGUmdQe
         AW0w==
X-Forwarded-Encrypted: i=1; AJvYcCX/oRo+YwGreULF3Rn8YexlVx+Y6Zg11/GlzF9vaPI0ybLlzLWtvrW5TiOD4PrKFMSZ1CPwBpjPGn6DZA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzoX3jCfziGSJQRIPpwTYlORkYm/79blMWAgGSS5BcjYLix2Zzf
	QOfEXDt755ALkXUnbdvbdjN4GC2BGRmzZ9jQWz/P4kp32iRtBsOPsczPHBoJWlhlkEXHEaBdphB
	4vbq0/5xwBfVGtfNk17yxGWODh98fbJ8BTuQlT/rKKlyDy2HUmDBYw+0JLZ0=
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:98e:b0:662:f91f:4a98 with SMTP id
 006d021491bc7-679faf3a953mr7150262eaf.41.1772477141288; Mon, 02 Mar 2026
 10:45:41 -0800 (PST)
Date: Mon, 02 Mar 2026 10:45:41 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69a5dad5.a70a0220.b118c.0001.GAE@google.com>
Subject: [syzbot] [btrfs?] WARNING: suspicious RCU usage in btrfs_device_init_dev_stats
From: syzbot <syzbot+d4957dbe80e471232035@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 3E4981DE72B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=98a1e192f758c1c1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22154-lists,linux-btrfs=lfdr.de,d4957dbe80e471232035];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.937];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[goo.gl:url,googlegroups.com:email,appspotmail.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,storage.googleapis.com:url,syzkaller.appspot.com:url]
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    7d6661873f6b Add linux-next specific files for 20260226
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=105ad1aa580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=98a1e192f758c1c1
dashboard link: https://syzkaller.appspot.com/bug?extid=d4957dbe80e471232035
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4cd2824adb8a/disk-7d666187.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bbdd4a130d86/vmlinux-7d666187.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6e3bea3e96f8/bzImage-7d666187.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d4957dbe80e471232035@syzkaller.appspotmail.com

=============================
WARNING: suspicious RCU usage
syzkaller #0 Not tainted
-----------------------------
fs/btrfs/volumes.h:872 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
3 locks held by syz.2.1057/8526:
 #0: ffff88807cc920e0 (&type->s_umount_key#58/1){+.+.}-{4:4}, at: alloc_super+0x28c/0xab0 fs/super.c:345
 #1: ffff888057f2e0d8 (&fs_devs->device_list_mutex){+.+.}-{4:4}, at: btrfs_init_dev_stats+0x5b/0x190 fs/btrfs/volumes.c:8157
 #2: ffff8880772940f8 (btrfs-dev-00){.+.+}-{4:4}, at: btrfs_tree_read_lock_nested+0x33/0x250 fs/btrfs/locking.c:146

stack backtrace:
CPU: 0 UID: 0 PID: 8526 Comm: syz.2.1057 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 lockdep_rcu_suspicious+0x13f/0x1d0 kernel/locking/lockdep.c:6876
 btrfs_dev_name fs/btrfs/volumes.h:872 [inline]
 btrfs_dev_stat_print_on_load fs/btrfs/volumes.c:8302 [inline]
 btrfs_device_init_dev_stats+0x971/0xb90 fs/btrfs/volumes.c:8140
 btrfs_init_dev_stats+0x8e/0x190 fs/btrfs/volumes.c:8159
 open_ctree+0x1be9/0x2e40 fs/btrfs/disk-io.c:3534
 btrfs_fill_super+0x187/0x2e0 fs/btrfs/super.c:981
 btrfs_get_tree_super fs/btrfs/super.c:1944 [inline]
 btrfs_get_tree_subvol fs/btrfs/super.c:2087 [inline]
 btrfs_get_tree+0xe77/0x1370 fs/btrfs/super.c:2121
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
RIP: 0033:0x7f197b19da0a
Code: 48 c7 c2 e8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f197bf8be58 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f197bf8bee0 RCX: 00007f197b19da0a
RDX: 0000200000005100 RSI: 0000200000000040 RDI: 00007f197bf8bea0
RBP: 0000200000005100 R08: 00007f197bf8bee0 R09: 0000000000a08811
R10: 0000000000a08811 R11: 0000000000000246 R12: 0000200000000040
R13: 00007f197bf8bea0 R14: 0000000000005163 R15: 0000200000000100
 </TASK>
BTRFS info (device loop2 state ECS): bdev /dev/loop2 errs: wr 150994944, rd 0, flush 0, corrupt 0, gen 0
BTRFS info (device loop2 state ECS): setting nodatasum
BTRFS info (device loop2 state ECS): disabling tree log
BTRFS info (device loop2 state ECS): enabling free space tree
BTRFS info (device loop2 state ECS): ignoring bad roots
BTRFS info (device loop2 state ECS): ignoring meta csums


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

