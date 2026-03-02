Return-Path: <linux-btrfs+bounces-22157-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PnnAS8LpmkJJgAAu9opvQ
	(envelope-from <linux-btrfs+bounces-22157-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 02 Mar 2026 23:11:59 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 723411E4F60
	for <lists+linux-btrfs@lfdr.de>; Mon, 02 Mar 2026 23:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 257853133383
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Mar 2026 21:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D955939A07C;
	Mon,  2 Mar 2026 20:56:35 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C987039150B
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Mar 2026 20:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772484995; cv=none; b=oh/kya0mLA2S1WPbNyHaU33B55ztzYJHpvDj84xg7oM5P1GZKfOwuO8pvpRBwRFHRuTrIFrvFXhe7G6YPe4K9qRhKIVgsDdgSaPHaJyhASciYchvyAiBwuRO7MRCjvjfM5zzoiRhUrXsQIL/XQB5ut43ZoGTBZKIbJ7Xms002Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772484995; c=relaxed/simple;
	bh=A6XT5fgeQ+H4C/SBbDw41iSARhcu700961Qjp3KTlNk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=rcIjsIlOESEvfNNSAhIbg3ZDlLv4yl5FjQde9V/i+AfM6ujAoc+QLsz0jwruRGYXflxewHAuC5uds6UVuNbKLT+n0fGBPImmoyhfKqm6ne+5Ucwc0Fk/05OzGLQ0cVGm+ZoaHU044WSXkpsByxNDKmNJkfX+NdczPotQbWJ9lHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-679caf7ec07so100037975eaf.1
        for <linux-btrfs@vger.kernel.org>; Mon, 02 Mar 2026 12:56:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772484993; x=1773089793;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oeJWXL/8B80nLFtn/+/euC6blDjZ5NumAyIyoN6ge8Q=;
        b=accEkvjFj58Gn/OTUehowu1qCqvDbTAwOp42Ag9/DHllT43qTi5dFfc8rXxc+/RPy3
         N2U6aS2GETuyxGs61UNwiW9t3QrKtmkjSEqsf5HlXmPF1CW6P2f/i9yo7ACovrRYtk2a
         aTRmuEGL4dTEFjqB9DDjBG+w35vLugQBnjzQcFPYaeb0qyP40Nf5pybIZKOTzSmW2Hud
         b0+wqpHyrHDGaRcHlZS9ilobvQ/42plaZRYcKvLUTMG5ODnCdmzyrmefKQ77xsRt6Bw2
         o4hgwKI+c7zm1uqux1on22UWhq7lMEhZnHDonqkDx35V09GGD2o+k7h1/kcC5g1XA7fL
         JPTw==
X-Forwarded-Encrypted: i=1; AJvYcCWw5ixDynuLY5ItZzSO6GnvGUkG/DJfnVUy6+qWBKA1YBeXmNdPc0noE8hv/TBgTsGlGmq6mJ2xyzoDNg==@vger.kernel.org
X-Gm-Message-State: AOJu0YweqaeTgm4RCfmtAet7Vu2OLv+JR3oLFM1GOplVmaPEN7FqXoxy
	4ceik1pnPRMoRA0K6MfQF+73unvvKG3TM2BBp0qiDjCbYsCOr6la3SlSHVVmXukWXxKCrjG4uLs
	WmguVhfMwcmS03zmzORPWFZ1SUG2pYcD6HFw+/GdNx8Q7YG4Wq4x1Sl8DBdE=
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:81c4:b0:66f:75e5:e886 with SMTP id
 006d021491bc7-679faf93119mr8109196eaf.66.1772484992883; Mon, 02 Mar 2026
 12:56:32 -0800 (PST)
Date: Mon, 02 Mar 2026 12:56:32 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69a5f980.a70a0220.b118c.0004.GAE@google.com>
Subject: [syzbot] [btrfs?] WARNING: suspicious RCU usage in btrfs_dev_stat_inc_and_print
From: syzbot <syzbot+2c45a55710ac9b888efc@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 723411E4F60
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=98a1e192f758c1c1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22157-lists,linux-btrfs=lfdr.de,2c45a55710ac9b888efc];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.945];
	TAGGED_RCPT(0.00)[linux-btrfs];
	R_DKIM_NA(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    7d6661873f6b Add linux-next specific files for 20260226
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1753c202580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=98a1e192f758c1c1
dashboard link: https://syzkaller.appspot.com/bug?extid=2c45a55710ac9b888efc
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4cd2824adb8a/disk-7d666187.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bbdd4a130d86/vmlinux-7d666187.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6e3bea3e96f8/bzImage-7d666187.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2c45a55710ac9b888efc@syzkaller.appspotmail.com

loop0: detected capacity change from 32768 to 0
=============================
WARNING: suspicious RCU usage
syzkaller #0 Not tainted
-----------------------------
fs/btrfs/volumes.h:872 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
6 locks held by syz.0.680/8076:
 #0: ffff888078859278 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x246/0x320 fs/file.c:1261
 #1: ffff888034360420 (sb_writers#24){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2710 [inline]
 #1: ffff888034360420 (sb_writers#24){.+.+}-{0:0}, at: vfs_write+0x227/0xb90 fs/read_write.c:684
 #2: ffff888034360610 (sb_internal#4){.+.+}-{0:0}, at: btrfs_sync_file+0xcaa/0x1230 fs/btrfs/file.c:1724
 #3: ffff88805386a6f8 (btrfs_trans_num_writers){++++}-{0:0}, at: join_transaction+0x41b/0xd60 fs/btrfs/transaction.c:298
 #4: ffff88805386a720 (btrfs_trans_num_extwriters){++++}-{0:0}, at: join_transaction+0x41b/0xd60 fs/btrfs/transaction.c:298
 #5: ffff888034a383a8 (&root->log_mutex){+.+.}-{4:4}, at: btrfs_sync_log+0x21a/0x28a0 fs/btrfs/tree-log.c:3335

stack backtrace:
CPU: 0 UID: 0 PID: 8076 Comm: syz.0.680 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 lockdep_rcu_suspicious+0x13f/0x1d0 kernel/locking/lockdep.c:6876
 btrfs_dev_name fs/btrfs/volumes.h:872 [inline]
 btrfs_dev_stat_inc_and_print+0x328/0x400 fs/btrfs/volumes.c:8282
 btrfs_log_dev_io_error fs/btrfs/bio.c:-1 [inline]
 btrfs_simple_end_io+0x1e6/0x3e0 fs/btrfs/bio.c:399
 btrfs_submit_chunk fs/btrfs/bio.c:848 [inline]
 btrfs_submit_bbio+0x1316/0x1ea0 fs/btrfs/bio.c:906
 btree_writepages+0xb68/0x1260 fs/btrfs/extent_io.c:2390
 do_writepages+0x32e/0x550 mm/page-writeback.c:2554
 filemap_writeback mm/filemap.c:387 [inline]
 filemap_fdatawrite_range+0x1ef/0x2f0 mm/filemap.c:412
 btrfs_write_marked_extents+0x1ac/0x300 fs/btrfs/transaction.c:1174
 btrfs_sync_log+0x9bd/0x28a0 fs/btrfs/tree-log.c:3386
 btrfs_sync_file+0xdaf/0x1230 fs/btrfs/file.c:1769
 generic_write_sync include/linux/fs.h:2640 [inline]
 btrfs_do_write_iter+0x72e/0x880 fs/btrfs/file.c:1468
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x61d/0xb90 fs/read_write.c:688
 ksys_write+0x150/0x270 fs/read_write.c:740
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6c42f9c799
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6c43e09028 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f6c43215fa0 RCX: 00007f6c42f9c799
RDX: 000000000000fea7 RSI: 0000200000000200 RDI: 0000000000000005
RBP: 00007f6c43032bd9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f6c43216038 R14: 00007f6c43215fa0 R15: 00007fffadae2ee8
 </TASK>
BTRFS error (device loop0): bdev /dev/loop0 errs: wr 1, rd 0, flush 0, corrupt 0, gen 0
BTRFS error (device loop0): bdev /dev/loop0 errs: wr 2, rd 0, flush 0, corrupt 0, gen 0
BTRFS error (device loop0 state A): Transaction aborted (error -5)
BTRFS: error (device loop0 state A) in __btrfs_run_delayed_items:1162: errno=-5 IO failure
BTRFS info (device loop0 state EA): forced readonly
BTRFS warning (device loop0 state EA): Skipping commit of aborted transaction.
BTRFS: error (device loop0 state EA) in cleanup_transaction:2042: errno=-5 IO failure


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

