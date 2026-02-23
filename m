Return-Path: <linux-btrfs+bounces-21852-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHJjKCHbnGkrLwQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21852-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Feb 2026 23:56:33 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F4017EA18
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Feb 2026 23:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 86CED306EC83
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Feb 2026 22:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C1B37BE98;
	Mon, 23 Feb 2026 22:56:26 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F8F3033CB
	for <linux-btrfs@vger.kernel.org>; Mon, 23 Feb 2026 22:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771887385; cv=none; b=GlmoF1loE0LAK+bDpkdh7UaJy7leQV6/5VA4NMULbiZ0ghfp5S83in4TqgqzSYuMRSh2h6erhmS2cctq1ChhDl2S/1e16+n5tI4qgMPTG2f28qRZEydNYK6e+MB05oOjv1EUwPsxvTBDaPSv+WdJ64V5olZMaLY2/vPnfw9rjBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771887385; c=relaxed/simple;
	bh=krVxbB9hjqNkFJe33bowPmxCyM5sEf1Z7ckFMRNkvG4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ETa/KjUQzO8oU7QWFVQRMm/eLCgC2M4Kr/B1u4T1zoyxZMdG9m/36G9nyn1s8lZ4PMRIlLUk6nsoC3nSd3RT7l436z8aAhg1UbI5aUn9vJK9yjED0W8kiJc+hu7Ty7Yg2aBWrE2K/3yXnvjDjWQ4bSp7L/K3NaIQha+cynq69Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7d192f35a9dso48015783a34.3
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Feb 2026 14:56:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771887383; x=1772492183;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JsJ5Ot0LcjZFprG/Pz8/vPYhS2humQ6zC3BAqr2fbg0=;
        b=jAwanlzaohNGbGt1SVG5Po7gk59vWEJeXo1srAJM0AALXMkG+SS83qhC0NhnlWM/lb
         YGI2tyzqh2YgvYW9Cn83VPG3gvEBjVTjwAO+KmrehmOFoWQZfGXgwaSn/NTRnOtD36sr
         KFircUQOqzrkm4QICGOrBV+fdQUm23c2Uqh7KzBNTwH8cZNbInhAm3/6IwA252IMW96B
         is9i583mDp2dG/Yh9+KT0kkE+ghwOq8VQnqxB3Qs84zSG0sDt3pqQ0+eN/f2l5+c50Ep
         EMO+Z1LSuQ8ahFwgyCMrUtie3tdiUKx33rxPgSLir44eIkn924sJLXBGyf+LOxD530aS
         B04g==
X-Forwarded-Encrypted: i=1; AJvYcCUpXPcb/riVAr0H6EeRUAKS2OFbk+qNBIbxUKn0JZKAE7dqBBv/tJU1HWrn9yRVnA6kgiv2PPGzCg3qVw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzM21iqSQk+ntsNCQHQWCKdvNCuN07Cy6FSUqr8BODENoFiMxd+
	/AWJwBmaNfm51YUl7JBJ79CuN4L6UrrzLWE/h+6OsAQTkvFY7ZLRMmftprn9Kq44+fS2GINq7vI
	op0qcW4vTRYHrPPGLQ2Fho6WqrSjI05JNy6SwioJBYPCawlpzlscB2xCrYM8=
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4912:b0:676:cd01:3da4 with SMTP id
 006d021491bc7-679c44e7588mr4568103eaf.39.1771887383407; Mon, 23 Feb 2026
 14:56:23 -0800 (PST)
Date: Mon, 23 Feb 2026 14:56:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <699cdb17.050a0220.247d23.033c.GAE@google.com>
Subject: [syzbot] [btrfs?] WARNING in btrfs_add_link (2)
From: syzbot <syzbot+f3a86ba8f6ee221654cd@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=abe4fa590468dbfb];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21852-lists,linux-btrfs=lfdr.de,f3a86ba8f6ee221654cd];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,googlegroups.com:email,storage.googleapis.com:url,syzkaller.appspot.com:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,goo.gl:url]
X-Rspamd-Queue-Id: 62F4017EA18
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    8bf22c33e7a1 Merge tag 'net-7.0-rc1' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=113f495a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=abe4fa590468dbfb
dashboard link: https://syzkaller.appspot.com/bug?extid=f3a86ba8f6ee221654cd
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/010f0532c934/disk-8bf22c33.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ed0946db3f63/vmlinux-8bf22c33.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ef1efd866885/bzImage-8bf22c33.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f3a86ba8f6ee221654cd@syzkaller.appspotmail.com

---------[  137.618642][ T6713] ------------[ cut here ]------------
BTRFS: Transaction aborted (error -28)
WARNING: fs/btrfs/inode.c:6871 at btrfs_add_link+0xc1a/0xec0 fs/btrfs/inode.c:6871, CPU#1: syz.5.90/6713
Modules linked in:
CPU: 1 UID: 0 PID: 6713 Comm: syz.5.90 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
RIP: 0010:btrfs_add_link+0xc1e/0xec0 fs/btrfs/inode.c:6871
Code: e1 fd e9 ae 00 00 00 e8 b0 e3 c6 fd 84 c0 74 24 e8 17 dc e1 fd e9 9b 00 00 00 e8 0d dc e1 fd 48 8d 3d e6 64 90 0b 8b 74 24 08 <67> 48 0f b9 3a e9 76 fb ff ff e8 f3 7f 3f 07 41 89 c7 31 ff 89 c6
RSP: 0018:ffffc90005a07860 EFLAGS: 00010287
RAX: ffffffff83e27803 RBX: 0000000000000000 RCX: 0000000000080000
RDX: ffffc9001cdb1000 RSI: 00000000ffffffe4 RDI: ffffffff8f72dcf0
RBP: ffffc90005a07990 R08: ffff88802928bc80 R09: 0000000000000003
R10: 0000000000000100 R11: 00000000fffffffb R12: 1ffff1100c31e974
R13: 00000000ffffffe4 R14: ffff8880618f4ba0 R15: ffff88802a5f8001
FS:  00007f58cbb646c0(0000) GS:ffff888126442000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f9c22d1fb4c CR3: 000000003d082000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 btrfs_create_new_inode+0x11e7/0x20e0 fs/btrfs/inode.c:6804
 btrfs_create_common+0x189/0x310 fs/btrfs/inode.c:6930
 btrfs_mkdir+0xc7/0xf0 fs/btrfs/inode.c:7069
 vfs_mkdir+0x40b/0x630 fs/namei.c:5233
 filename_mkdirat+0x289/0x520 fs/namei.c:5266
 __do_sys_mkdirat fs/namei.c:5287 [inline]
 __se_sys_mkdirat+0x35/0x150 fs/namei.c:5284
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f58cd94b507
Code: 00 66 90 48 89 f2 b9 00 01 00 00 48 89 fe bf 9c ff ff ff e9 db f7 ff ff 66 2e 0f 1f 84 00 00 00 00 00 90 b8 02 01 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f58cbb63e58 EFLAGS: 00000246 ORIG_RAX: 0000000000000102
RAX: ffffffffffffffda RBX: 00007f58cbb63ee0 RCX: 00007f58cd94b507
RDX: 00000000000001ff RSI: 00002000000000c0 RDI: 00000000ffffff9c
RBP: 0000200000000080 R08: 0000200000000140 R09: 0000000000000000
R10: 0000200000000080 R11: 0000000000000246 R12: 00002000000000c0
R13: 00007f58cbb63ea0 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
----------------
Code disassembly (best guess):
   0:	e1 fd                	loope  0xffffffff
   2:	e9 ae 00 00 00       	jmp    0xb5
   7:	e8 b0 e3 c6 fd       	call   0xfdc6e3bc
   c:	84 c0                	test   %al,%al
   e:	74 24                	je     0x34
  10:	e8 17 dc e1 fd       	call   0xfde1dc2c
  15:	e9 9b 00 00 00       	jmp    0xb5
  1a:	e8 0d dc e1 fd       	call   0xfde1dc2c
  1f:	48 8d 3d e6 64 90 0b 	lea    0xb9064e6(%rip),%rdi        # 0xb90650c
  26:	8b 74 24 08          	mov    0x8(%rsp),%esi
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	e9 76 fb ff ff       	jmp    0xfffffbaa
  34:	e8 f3 7f 3f 07       	call   0x73f802c
  39:	41 89 c7             	mov    %eax,%r15d
  3c:	31 ff                	xor    %edi,%edi
  3e:	89 c6                	mov    %eax,%esi


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

