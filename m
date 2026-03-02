Return-Path: <linux-btrfs+bounces-22156-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHFRKL3spWlLHwAAu9opvQ
	(envelope-from <linux-btrfs+bounces-22156-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 02 Mar 2026 21:02:05 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7871DF110
	for <lists+linux-btrfs@lfdr.de>; Mon, 02 Mar 2026 21:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E139A303E38D
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Mar 2026 20:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EDC47DD6C;
	Mon,  2 Mar 2026 20:01:50 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A9A383C64
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Mar 2026 20:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772481709; cv=none; b=RtZVj4MT/qO1fap+TdUlI9gFxIB28ZMklyqZvwJN+exINkkTmupxXbtgyAqhstzAFPHV5KUNX1+uzLNfUnpMhVvVuqSloFVw12LFZtb6K0mXa+3C5tntsdZ18KMon6gCMO/88Uy9kH359naNXRLq+ySw40ywF9VbJKj2VzWI/l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772481709; c=relaxed/simple;
	bh=gDW1mf/SM6xsStA7Z8vSo/fK5nl2CusOU94hPGW/VRo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=h8pKrdh2zC0mG7jKkD2+EUDpgVYHzDcqUEqUhr5QI+LRkbpzQhTywCKid7j4n+bFAB8z+930zVdniFFCh1yr4cMevclbTQ4e0RCbuX60I0PTfjKTIxZombDpVaGlNhIIU8jiClKWs9A4ya2mgReM6lRXl9FFGDp+5btkUyfyiDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-679c54e29f6so25628913eaf.1
        for <linux-btrfs@vger.kernel.org>; Mon, 02 Mar 2026 12:01:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772481703; x=1773086503;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mxlee0+VtCk5JxrX1yoCNhmITIf/9d+ushv4xvi0o0M=;
        b=Cu+kkfe/cTTCwiuiRsxigjIT0jCXOTu0bkNyrouvmdsRdPNASeyogsgghsvmnQplU5
         oQ4mxAXJZmXwTmh7UIQg9qVE4qFUkc/5osiw/P4/wTUGx+Wz7iL2AXhAdXFkmxAsDduf
         O37zxDMuiEAwm7HfOQcxqQcEwvdBo0m9XP8DXeLwGHJdieCOfofLJ/pkktY8i/Pw/P5T
         XxFbVbNTX29RO2WimWN/ramfGEvaRDphChAxvp7mf2whecLy0nUagVHZcBcmGkIgu9Ia
         4pP8kbjNvwIpFuYCx1SaJM672Tq3thTIz3pepwntwAlGu7LU8k5qd3Ybz7sEtNjV56T1
         5zjg==
X-Forwarded-Encrypted: i=1; AJvYcCXzxPDE0E0Zr5qoWZkQvQwIESZscJJL7BmHUEjcGEkbErrVxsE1PWml28sFwmAfavVrMKDvGq60Zj0mJQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyT4L8CbZqDQj/WRQZ4lIe13iGVsMQ7raqafFS99uagF0lANBRb
	POmRhej3kLl0DdU1C80KEZcVjtM9jGFifibtseRGSDy759iuBOXOCKHx6D5ZyYjeew0q9o5TYiO
	9yqbG4+Jw81Eq/Z49ytj2fnsj/EFpZ2UQsR4lz8MBIlGsDIHZODbcsJEp/Uc=
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4de4:b0:667:7e1a:204a with SMTP id
 006d021491bc7-679faf91292mr7462782eaf.71.1772481702945; Mon, 02 Mar 2026
 12:01:42 -0800 (PST)
Date: Mon, 02 Mar 2026 12:01:42 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69a5eca6.a70a0220.b118c.0003.GAE@google.com>
Subject: [syzbot] [btrfs?] WARNING: suspicious RCU usage in btrfs_dev_name
From: syzbot <syzbot+ba123cf1dd631315ffca@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 1A7871DF110
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=98a1e192f758c1c1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22156-lists,linux-btrfs=lfdr.de,ba123cf1dd631315ffca];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.943];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,googlegroups.com:email,storage.googleapis.com:url,goo.gl:url,appspotmail.com:email]
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    7d6661873f6b Add linux-next specific files for 20260226
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11591952580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=98a1e192f758c1c1
dashboard link: https://syzkaller.appspot.com/bug?extid=ba123cf1dd631315ffca
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4cd2824adb8a/disk-7d666187.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bbdd4a130d86/vmlinux-7d666187.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6e3bea3e96f8/bzImage-7d666187.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ba123cf1dd631315ffca@syzkaller.appspotmail.com

BTRFS info (device loop1): first mount of filesystem 7e32c2af-f87a-45a1-bcba-64dea7c56a53
BTRFS info (device loop1): using xxhash64 checksum algorithm
=============================
WARNING: suspicious RCU usage
syzkaller #0 Not tainted
-----------------------------
fs/btrfs/volumes.h:872 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
1 lock held by syz.1.21/6007:
 #0: ffff8880346a60e0 (&type->s_umount_key#58/1){+.+.}-{4:4}, at: alloc_super+0x28c/0xab0 fs/super.c:345

stack backtrace:
CPU: 0 UID: 0 PID: 6007 Comm: syz.1.21 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 lockdep_rcu_suspicious+0x13f/0x1d0 kernel/locking/lockdep.c:6876
 btrfs_dev_name+0x128/0x130 fs/btrfs/volumes.h:872
 btrfs_repair_io_failure+0x4f8/0x6a0 fs/btrfs/bio.c:989
 btrfs_repair_eb_io_failure fs/btrfs/disk-io.c:198 [inline]
 btrfs_read_extent_buffer+0xb84/0xcd0 fs/btrfs/disk-io.c:245
 read_tree_block fs/btrfs/disk-io.c:592 [inline]
 read_tree_root_path+0x29d/0x840 fs/btrfs/disk-io.c:988
 load_global_roots_objectid+0x431/0xa20 fs/btrfs/disk-io.c:2095
 load_global_roots fs/btrfs/disk-io.c:2135 [inline]
 btrfs_read_roots fs/btrfs/disk-io.c:2160 [inline]
 init_tree_roots+0xbe2/0x2240 fs/btrfs/disk-io.c:2712
 open_ctree+0x1960/0x2e40 fs/btrfs/disk-io.c:3489
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
RIP: 0033:0x7f30d979da0a
Code: 48 c7 c2 e8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f30da6dee58 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f30da6deee0 RCX: 00007f30d979da0a
RDX: 00002000000002c0 RSI: 0000200000000680 RDI: 00007f30da6deea0
RBP: 00002000000002c0 R08: 00007f30da6deee0 R09: 0000000001a001d8
R10: 0000000001a001d8 R11: 0000000000000246 R12: 0000200000000680
R13: 00007f30da6deea0 R14: 000000000002223e R15: 0000200000000000
 </TASK>
BTRFS info (device loop1): read error corrected: ino 0 off 30670848 (dev /dev/loop1 sector 76288)
BTRFS info (device loop1): read error corrected: ino 0 off 30687232 (dev /dev/loop1 sector 76320)
BTRFS info (device loop1): read error corrected: ino 0 off 30523392 (dev /dev/loop1 sector 76000)
BTRFS info (device loop1): read error corrected: ino 0 off 30457856 (dev /dev/loop1 sector 75872)
BTRFS info (device loop1): deleted orphan free space tree entries
BTRFS info (device loop1): checking UUID tree
BTRFS info (device loop1): turning on sync discard
BTRFS info (device loop1): enabling free space tree


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

