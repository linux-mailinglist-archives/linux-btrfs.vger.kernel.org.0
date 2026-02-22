Return-Path: <linux-btrfs+bounces-21819-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDzQKqWammmTdgMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21819-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Feb 2026 06:56:53 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 316C516E878
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Feb 2026 06:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07291301AA79
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Feb 2026 05:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F7A1A262D;
	Sun, 22 Feb 2026 05:56:31 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0279813D8B1
	for <linux-btrfs@vger.kernel.org>; Sun, 22 Feb 2026 05:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771739791; cv=none; b=nq8IwkXlLWgX0igEcXC7HEC00Izp6vOlCgXb2HUNbSjxekIieUSPIVScFrk5TK6e4ofZaR8sh8pgk5c5da3zbFCcTuAC6AHS1848NjHvSn4JO83gyoAFqNF9hN41O8fTX4kJVlL3nNeN1LJdYVQZdlVsXYC2J+yMu0Np7tfEkSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771739791; c=relaxed/simple;
	bh=1OdX+md+a1zz/20Xq4bHcBDaXb3cPGVdBdXHXlu7NT0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PLWOojAscB9m3hkAiqzyoPiuqK6lJcqCVjW4qV+59+NULGu5QIzUpN1IApnd2TJfCMBKrDU6sct6MxEIGlWgbMj0MSvcOay0YopiLFFytJo0YRHLtGIyrAjXFNM5Z94hMLcaQkGKQMhaJEca/ff2zneoLvzrL6kW4c0x2pq8whU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7d4d6edec7eso21465815a34.1
        for <linux-btrfs@vger.kernel.org>; Sat, 21 Feb 2026 21:56:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771739789; x=1772344589;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rXQMWTzJZsG1fQtRoJmSsS973Erm0cV9X9ibsgEStvw=;
        b=nWN9iuyKdbtwAmzTTOw13JYzRVbhoqkPXEGDU522gTrAKq427Nr5KLbiCzYtrhaH4h
         lZ13MVQDTsLFDWzqPh+P3hmFBE0ec3MEyPF4sHMZQ0/xMRiQdioHtOSV9VSpTjFIhvnI
         cOMEqKlg18XU1Osxhs3BxhWyMVWUkqy02kTWSA8P8bJ0rnhgWwuO6lqXSh6WpS4UO92O
         jiIRTeMQQOvILzi1fNW0s4CaoLq+7pknzWcXJo37jf/Zb3MKv5lW9/EHKndg785duOvS
         V6TJ2qoP1YdrY00kHFd7CRYsaKIsjNxi24KP0Rc+Mh1I1OZI/xW/2T3JX0DI38a5IKnE
         Dq0w==
X-Forwarded-Encrypted: i=1; AJvYcCV8MZt9nODakXukVhXajxE9NY5+ampUTWjrDuKmgaAVso5zIykfl6bgIrEcRsT/kE/0Vto9BpSKp2rg8g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJbB0s6fCc0sS54UdxcJrvLljg+bdfOWuPweHcgqimYQ+6jQ07
	29S2VH1t1XlmwVvj1LQWw70xnZo/mG94pDEP+GCFJxciY84xnfAzKKYPnDID6Corh4akon0MZO+
	3UGIKtgfBzpoqpvJp9os+EsxUqZmQMgdr1Ef1nZmPO8MjhTOe13hCsEvRXUA=
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1c9f:b0:677:5e0a:a92b with SMTP id
 006d021491bc7-679c424d590mr2280286eaf.13.1771739788897; Sat, 21 Feb 2026
 21:56:28 -0800 (PST)
Date: Sat, 21 Feb 2026 21:56:28 -0800
In-Reply-To: <68ff35d4.050a0220.32483.0015.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <699a9a8c.a70a0220.2c38d7.016d.GAE@google.com>
Subject: Re: [syzbot] [btrfs?] WARNING in lookup_inline_extent_backref (2)
From: syzbot <syzbot+b0e66d3779134f468156@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, wqu@suse.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=65722f41f7edc17e];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-21819-lists,linux-btrfs=lfdr.de,b0e66d3779134f468156];
	SUBJECT_HAS_QUESTION(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,syzkaller.appspot.com:url,appspotmail.com:email,storage.googleapis.com:url]
X-Rspamd-Queue-Id: 316C516E878
X-Rspamd-Action: no action

syzbot has found a reproducer for the following issue on:

HEAD commit:    d79526b89571 Merge tag 'spi-fix-v7.0-merge-window' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11211fb2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=65722f41f7edc17e
dashboard link: https://syzkaller.appspot.com/bug?extid=b0e66d3779134f468156
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11a469e6580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16deeeaa580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-d79526b8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/49624ca295fd/vmlinux-d79526b8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b6bf3fe0601b/bzImage-d79526b8.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/bdd2b04fef16/mount_0.gz
  fsck result: OK (log: https://syzkaller.appspot.com/x/fsck.log?x=11b2d95a580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b0e66d3779134f468156@syzkaller.appspotmail.com

------------[ cut here ]------------
ret
WARNING: fs/btrfs/extent-tree.c:837 at lookup_inline_extent_backref+0x143e/0x1980 fs/btrfs/extent-tree.c:837, CPU#0: syz.0.51/6188
Modules linked in:
CPU: 0 UID: 0 PID: 6188 Comm: syz.0.51 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:lookup_inline_extent_backref+0x143e/0x1980 fs/btrfs/extent-tree.c:837
Code: d8 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d e9 48 80 cb 07 cc e8 52 e3 de fd bb fe ff ff ff 4c 8b 74 24 50 e9 af fe ff ff 90 <0f> 0b 90 48 8b 84 24 88 00 00 00 48 b9 00 00 00 00 00 fc ff df 80
RSP: 0018:ffffc9000f436dc0 EFLAGS: 00010202
RAX: 0000000000000001 RBX: 0000000000000001 RCX: 0000000000000000
RDX: ffff88803cfb0000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc9000f436fe8 R08: 0000000000000000 R09: 1ffffd40002a7c88
R10: dffffc0000000000 R11: fffff940002a7c89 R12: 0000000000530000
R13: ffff888012fe3dc0 R14: 0000000000000009 R15: ffff888040dba000
FS:  00007f51785dd6c0(0000) GS:ffff88808ca5b000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f51790e02c0 CR3: 0000000042618000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 insert_inline_extent_backref+0xa8/0x300 fs/btrfs/extent-tree.c:1206
 __btrfs_inc_extent_ref+0x271/0xa00 fs/btrfs/extent-tree.c:1505
 run_delayed_tree_ref fs/btrfs/extent-tree.c:1771 [inline]
 run_one_delayed_ref fs/btrfs/extent-tree.c:1803 [inline]
 btrfs_run_delayed_refs_for_head fs/btrfs/extent-tree.c:2003 [inline]
 __btrfs_run_delayed_refs+0xf93/0x4240 fs/btrfs/extent-tree.c:2078
 btrfs_run_delayed_refs+0xe6/0x3b0 fs/btrfs/extent-tree.c:2190
 qgroup_account_snapshot fs/btrfs/transaction.c:1589 [inline]
 create_pending_snapshot+0x1141/0x3ac0 fs/btrfs/transaction.c:1872
 create_pending_snapshots+0x17c/0x1c0 fs/btrfs/transaction.c:1942
 btrfs_commit_transaction+0xf75/0x31a0 fs/btrfs/transaction.c:2439
 create_snapshot fs/btrfs/ioctl.c:779 [inline]
 btrfs_mksubvol+0x9bc/0x10a0 fs/btrfs/ioctl.c:857
 btrfs_mksnapshot+0xab/0xf0 fs/btrfs/ioctl.c:899
 __btrfs_ioctl_snap_create+0x52e/0x750 fs/btrfs/ioctl.c:1163
 btrfs_ioctl_snap_create_v2+0x1f8/0x3b0 fs/btrfs/ioctl.c:1242
 btrfs_ioctl+0xa62/0xd00 fs/btrfs/ioctl.c:-1
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5178f9c629
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f51785dd028 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f5179216180 RCX: 00007f5178f9c629
RDX: 0000200000001480 RSI: 0000000050009417 RDI: 0000000000000003
RBP: 00007f5179032b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f5179216218 R14: 00007f5179216180 R15: 00007ffc1c52f3d8
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

