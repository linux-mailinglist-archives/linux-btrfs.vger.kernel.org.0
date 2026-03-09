Return-Path: <linux-btrfs+bounces-22292-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCZKELMOr2njNAIAu9opvQ
	(envelope-from <linux-btrfs+bounces-22292-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Mar 2026 19:17:23 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E76CF23E7A7
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Mar 2026 19:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7F999303F54E
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Mar 2026 18:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BC52E4247;
	Mon,  9 Mar 2026 18:09:30 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DD8285C80
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Mar 2026 18:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773079770; cv=none; b=QVmzSIp6c5PBygEDfY8eR3/m8eOfwa+LIZio2C56hJPMVJ+4YxfmPlWAEhX0Ezr7O09POWUWiOx3iaeBaafXwf65d6evXttCL37CQsMOeBFGgK7RJ/rW90Q/gvvJSCHZtUEn5OholYXrnGgkDvt9rgYx/MdPHtIksESe6ImGTec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773079770; c=relaxed/simple;
	bh=SznvAvqNCRElUNPMzSkqSUSr8mKELL3XsKc1SwggWmw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=NksgcnNxMGn+LQMXirCobt1UHm9/rzSvZlJSzhf8If2mL4c82V/BneMIiEgcHSMCdVoCY54v+UjF50W44rRCJKcRO7nenUIqpDYglIFDeOLgM7RJ1p83tpcj4wQ8oWB3149jjwLA9EBlKx6dd/y9owVDukJ7878gh8N9jlGfrKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-67bb77eb9f8so9409573eaf.1
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Mar 2026 11:09:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773079768; x=1773684568;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fMD6/Q/SdweF5qLhXKzO6kQHbt/0bKCUTR88DfHKC0k=;
        b=VCcPYvZVTFye+vav68OQNaaytjFlm6dEAeBfb6w6QGZFMqvV8f1RUBzd/gAjKI9CaN
         R4RJfggEH1DA4TSkRYZEQ57+8lRnjc8Qv3+9uENH+icbhAzSyhQvbioRjYjdiFLlGNQC
         65y6cC1EfZGyb6mPGGfdewRaV/onG9QQPUMPx0bE0C+TfV4ZBG4Vi5s2gySPOWVn/1Wq
         zELma0dm9LzUtfm+QdTMG5JNNblYRTBZV772rBOoboOQZ/1DEQW3eD+wAF9qXZAIDr/y
         VNLQp7WbN5Z+wg2DcnPfU4bdWVO0lQQOmW6S/Q5fG0bTlpSXGDK9kUugzl6zUKhQcuRa
         j2UA==
X-Forwarded-Encrypted: i=1; AJvYcCU2JTMR5RP1/OCHM0/DzbLZFcJXYtGsAo5JmMfAUf5iJHoJ6Vsk2CDwMMFKm1+B4BP+5HO7OyW36One5g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyoXYKMJTqjxdfhOD5ErgJMJ9XrKDegruvN9+CeVss0UbIwYEaY
	O7QKoLXz8E+ZBFLJaudsUIoHTw9XCGhDEq4nd5ryHFRfx08jCrQQgTffdWWhBhxRZYrGc00DEOV
	tUbkPhRTTBp0c5TU/nu4Khcbb8xm1MYC8hACeJIQdxS7I4QddNZHyHuEqA6E=
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4d09:b0:67b:aa33:408f with SMTP id
 006d021491bc7-67baa33467amr4720903eaf.55.1773079767903; Mon, 09 Mar 2026
 11:09:27 -0700 (PDT)
Date: Mon, 09 Mar 2026 11:09:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69af0cd7.050a0220.310d8.0030.GAE@google.com>
Subject: [syzbot] [btrfs?] kernel BUG in btrfs_backref_release_cache (3)
From: syzbot <syzbot+128c98b49b7ffb4c8fa3@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: E76CF23E7A7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=c5c49ee0942d1cdb];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22292-lists,linux-btrfs=lfdr.de,128c98b49b7ffb4c8fa3];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[goo.gl:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,storage.googleapis.com:url,googlegroups.com:email,appspotmail.com:email,syzkaller.appspot.com:url]
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    c107785c7e8d Merge tag 'modules-7.0-rc3.fixes' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12d0ab5a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c5c49ee0942d1cdb
dashboard link: https://syzkaller.appspot.com/bug?extid=128c98b49b7ffb4c8fa3
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-c107785c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f3bc281ac705/vmlinux-c107785c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ecd5165e5812/bzImage-c107785c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+128c98b49b7ffb4c8fa3@syzkaller.appspotmail.com

BTRFS info (device loop0): balance: start -d -m
BTRFS info (device loop0): relocating block group 6881280 flags data|metadata
BTRFS info (device loop0): found 1 extents, stage: move data extents
BTRFS info (device loop0): relocating block group 5242880 flags data|metadata
BTRFS info (device loop0): found 10 extents, stage: move data extents
assertion failed: !cache->nr_nodes :: 0, in fs/btrfs/backref.c:3151
------------[ cut here ]------------
kernel BUG at fs/btrfs/backref.c:3151!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5318 Comm: syz.0.0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:btrfs_backref_release_cache+0x234/0x260 fs/btrfs/backref.c:3151
Code: 0f 0b e8 6f 74 bd fd 48 c7 c7 e0 96 17 8c 48 c7 c6 00 9e 17 8c 31 d2 48 c7 c1 80 97 17 8c 41 b8 4f 0c 00 00 e8 9d 85 1f fd 90 <0f> 0b e8 45 74 bd fd 48 c7 c7 e0 96 17 8c 48 c7 c6 40 9e 17 8c 31
RSP: 0018:ffffc9000dd477a8 EFLAGS: 00010246
RAX: 0000000000000043 RBX: ffff8880434c6020 RCX: e86cf94f153c5b00
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 0000000000000002 R08: ffffc9000dd47527 R09: 1ffff92001ba8ea4
R10: dffffc0000000000 R11: fffff52001ba8ea5 R12: dffffc0000000000
R13: 1ffff11008698c04 R14: ffff8880434c60f0 R15: 1ffff11008698c21
FS:  00007f83542826c0(0000) GS:ffff88808ca56000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055819b279168 CR3: 0000000044955000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 relocate_block_group+0xb80/0xe90 fs/btrfs/relocation.c:3628
 do_nonremap_reloc+0xa8/0x5b0 fs/btrfs/relocation.c:5251
 btrfs_relocate_block_group+0x75b/0xae0 fs/btrfs/relocation.c:5410
 btrfs_relocate_chunk+0x10f/0x810 fs/btrfs/volumes.c:3590
 __btrfs_balance+0x1dab/0x2ae0 fs/btrfs/volumes.c:4492
 btrfs_balance+0xafa/0x11f0 fs/btrfs/volumes.c:4879
 btrfs_ioctl_balance+0x3d3/0x610 fs/btrfs/ioctl.c:3445
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f835339c799
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8354281fe8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f8353616090 RCX: 00007f835339c799
RDX: 0000200000000180 RSI: 00000000c4009420 RDI: 0000000000000006
RBP: 00007f8353432bd9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f8353616128 R14: 00007f8353616090 R15: 00007ffd7d2ef558
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:btrfs_backref_release_cache+0x234/0x260 fs/btrfs/backref.c:3151
Code: 0f 0b e8 6f 74 bd fd 48 c7 c7 e0 96 17 8c 48 c7 c6 00 9e 17 8c 31 d2 48 c7 c1 80 97 17 8c 41 b8 4f 0c 00 00 e8 9d 85 1f fd 90 <0f> 0b e8 45 74 bd fd 48 c7 c7 e0 96 17 8c 48 c7 c6 40 9e 17 8c 31
RSP: 0018:ffffc9000dd477a8 EFLAGS: 00010246
RAX: 0000000000000043 RBX: ffff8880434c6020 RCX: e86cf94f153c5b00
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 0000000000000002 R08: ffffc9000dd47527 R09: 1ffff92001ba8ea4
R10: dffffc0000000000 R11: fffff52001ba8ea5 R12: dffffc0000000000
R13: 1ffff11008698c04 R14: ffff8880434c60f0 R15: 1ffff11008698c21
FS:  00007f83542826c0(0000) GS:ffff88808ca56000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055819b279168 CR3: 0000000044955000 CR4: 0000000000352ef0


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

