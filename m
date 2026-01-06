Return-Path: <linux-btrfs+bounces-20116-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 404CFCF634A
	for <lists+linux-btrfs@lfdr.de>; Tue, 06 Jan 2026 02:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 47659301386D
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jan 2026 01:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE4932ABCD;
	Tue,  6 Jan 2026 01:02:25 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ot1-f77.google.com (mail-ot1-f77.google.com [209.85.210.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E4E32AAA7
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Jan 2026 01:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767661345; cv=none; b=JEqSxxplIChHeccK3O9tcWdme5AuAWlPqROoiKDr6+3jmSm08KgwykjI9z4SAr3SEggoKO2UtsiPtLVQHRcpu+M8GsdNSIq9vDB2cdVpv9ygPz2UlEpXiDJNloMZ0hW8A2/XjnLTprrHbzaW4vMAx/+W+4wafaQE59cv+HGDbBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767661345; c=relaxed/simple;
	bh=CW5mH7R8jU22uKPKQQW9TGVcA/j74nIgvDwZikrQN5E=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=LuR1Te0Bg/8ZbA6U4Tnzx4Qv7QJMJMtVXzkyqf5viXokH2CSzAi7GHNvbAEvTyFAC6Pt/UQsO8w5mlOdPbfAglgD0J6UjKgZfQ8CB5P56ZKMHR6ewFAAviC+cKU1uqm1BTJIDo+KyvgLOpIznGPIoQMAa6j01QsfucqI2f9+lms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f77.google.com with SMTP id 46e09a7af769-7c75798bfacso1479193a34.1
        for <linux-btrfs@vger.kernel.org>; Mon, 05 Jan 2026 17:02:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767661342; x=1768266142;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AECU3kGblORPS4UnsO7HEl0FKt2cbm56ofBHa9ZgJYg=;
        b=r9ZDVNpob9/PoXiKrOEuiXNIoNDGmZ6hiE/ZnXBEZA05+EMsn6BrucLIyklrn7QxwK
         ND51wQKiCc8P0OfILYFe/pvFTIp9wEQKv1pIG/GPXJogZ+7huimRfRBKqeNqj1odBRzD
         aZEKz11/H6V7HmkW2WGc6U7PKedXecO1K3PAUKjozTaoxC/KHrt6yPIAbmo2fTA9MT2n
         1O4vQwtEKbueDB1V1oOajxG6ASmiFLMe5Xxh5fUSHGEaiIgfMRBpHwuRUCmCsDzUK+f2
         5LNYOWNelSjQMbluS+juDqNhLu6UrdyrD166X7X6MxxQr2TinnmNbQW3QngGeLRu4wVa
         MQoA==
X-Forwarded-Encrypted: i=1; AJvYcCUNf/NRVe3c1PRT5uTdUbCyNDc5/HjgCZXzVnxl3x1eVPDC1dwKfOGmQw3DETsY8u+cSdImoBodoFx58w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwBaSBYyaTG/r46f0s9HtHyFIzurSgQ7tey5psYKLssQtIKWnh+
	anhMa4j7L3kpNfTBL4nasK6xCyZG0mmQZErB9LjQW3+bXdJvD/D1Jsd+Vv6IFeJoeWmIVD8Gp/4
	XtVOnUL5/GtSijkYRTRlzfwlz8Izr70zYO7gEieJX1X57u71g8giuXZdq1NY=
X-Google-Smtp-Source: AGHT+IHgx/sxjiLkOPdW89o/aOmfCHot5DV+G0ahkV6nRW2ZWhQeRvp7tvLyYwRAK98ifwZEutgPW9jcQSiYzyFEqdG5pj3qcsAk
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:b303:0:b0:65f:20c8:5e7a with SMTP id
 006d021491bc7-65f47a2701bmr642087eaf.67.1767661341776; Mon, 05 Jan 2026
 17:02:21 -0800 (PST)
Date: Mon, 05 Jan 2026 17:02:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <695c5f1d.050a0220.1c677c.0335.GAE@google.com>
Subject: [syzbot] [btrfs?] WARNING in btrfs_put_transaction (5)
From: syzbot <syzbot+6d30e046bbd449d3f6f1@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b69053dd3ffb wifi: mt76: Remove blank line after mt792x fi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=137c3fb4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a94030c847137a18
dashboard link: https://syzkaller.appspot.com/bug?extid=6d30e046bbd449d3f6f1
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/18036fd3b399/disk-b69053dd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bcf4c5ec9d8e/vmlinux-b69053dd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b4101a9d1eed/bzImage-b69053dd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6d30e046bbd449d3f6f1@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: fs/btrfs/transaction.c:145 at btrfs_put_transaction+0x52d/0x560 fs/btrfs/transaction.c:145, CPU#0: btrfs-transacti/1033
Modules linked in:
CPU: 0 UID: 0 PID: 1033 Comm: btrfs-transacti Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:btrfs_put_transaction+0x52d/0x560 fs/btrfs/transaction.c:145
Code: 07 fc ff ff e8 94 2a f1 fd 4c 89 f7 be 03 00 00 00 48 83 c4 18 5b 41 5c 41 5d 41 5e 41 5f 5d e9 b9 1b be 00 e8 74 2a f1 fd 90 <0f> 0b 90 e9 6f fb ff ff e8 66 2a f1 fd 90 0f 0b 90 e9 8c fb ff ff
RSP: 0018:ffffc900052e7970 EFLAGS: 00010293
RAX: ffffffff83cfcd4c RBX: ffff8880a4cba000 RCX: ffff888034bf3d00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000001
RBP: dffffc0000000000 R08: ffff8880a4cba013 R09: 1ffff11014997402
R10: dffffc0000000000 R11: ffffed1014997403 R12: ffff8880a4cba000
R13: 0000000000000000 R14: ffff8880a4cba358 R15: ffff88803251cc88
FS:  0000000000000000(0000) GS:ffff888125e1f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffde9f8b92c CR3: 000000000dd3a000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 btrfs_commit_transaction+0x22cf/0x3b10 fs/btrfs/transaction.c:2598
 transaction_kthread+0x2b1/0x450 fs/btrfs/disk-io.c:1587
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x510/0xa50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>


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

