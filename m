Return-Path: <linux-btrfs+bounces-8531-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7111898FB68
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2024 02:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A741BB20E10
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2024 00:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403ED33FD;
	Fri,  4 Oct 2024 00:07:27 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A18211C
	for <linux-btrfs@vger.kernel.org>; Fri,  4 Oct 2024 00:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728000446; cv=none; b=p53e9mgYw5kU3fi76IzIddUUm5QO8PEddtOrjtgk3W2uvZ1jkB92CK9Cp528im8EhR8oq1sBuKMmXG/DIveOgpKhTRCxb9f8KWOu1zdV7fGGA3zRoCOhCUqlwi2hWIII0NJhJYRcJdQDyycIrkrTtxz3f30bTtggqV8vhaABgAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728000446; c=relaxed/simple;
	bh=LyC74rRI0iQAJHCgyiC2wJvEUqlfviFnqukLtxlo0TY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Hhu7+eqe1BLSIBKQcQCGzHYrPW2Ee6kITBAOn20iSlv5kJwLYyK5LsMDGVtdjHuBpBvzoat0Z23ug0eGzpLygDAC5ykTbU82RfoWVxsT/C/8GfzFKV0icbaUxvbSQyUDhsnBD88SSa+LTjt1eGPWx9PcgojIDsiQluVMkexoDSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a344da7987so19341755ab.1
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Oct 2024 17:07:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728000444; x=1728605244;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/W5GlTpuUgl+FRJBXdCziNEzD6hutSONS/xAErxl+zo=;
        b=JfxeNi7fx+xDE3WS0YCwx7WB7RAEwTtV9BLEKFryRUIE3yGqdqzCEKtzneArlbJcmZ
         Exgc3Tk5CVmGv3vuO8UNpP15HiHytEWQ3ytqM0WVXRjpp37qBECID1b5DH3qqHweWtQ9
         7tf5jsXTeI2pGQDcOC//QAoHBKFfaiXcXCD3wwoJVgZeflM1MNjOUx9FB7D2Id959Big
         oXea6KHwFW3Vgff9D3mE6wLiCFiPSeRywWtk0beD1C9oGBiuz8b+DubzJkul5Dh0ErQU
         aayqytOU/cLgW1VDwfN5uKpOPOiaeuY/apENZizifvp4GEgqJc5aaHZAT9GDPT2/NsIb
         GcfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOEMmJyxwEu0dCSKSSRF3vyLQdVxG4kZNKqJQ9wz67LGQ6AQjaPmPMYxhYepyIc/u5VQ5M6k0qevfIdg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwEQ2Em5pRKvDrfmOHIsWD8DGbXnX5soFD0E1/kIrel/+PC6Gpr
	pFknGFZqn2QJyfUUcui/kR1DC4ZFOgfWHxMB49HQESNM5nVyMmrxLFjtxxmRGHKb5E0zOiMwQHy
	Bvl4QVlis7hk4JYOjTXiH4b42gZlSwPF7jd9JmALraKjNDXawe4cBFDY=
X-Google-Smtp-Source: AGHT+IHl+QHQUXjyMPC8Igx8/eEfmHQR7q2W5EkHdqRrXQ1oxikownohCNGcFpK/mFhklYydUvNvG0czHUYClzWtJzi48CEK8Lt/
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:174a:b0:396:e8b8:88d with SMTP id
 e9e14a558f8ab-3a37599e77amr10251375ab.11.1728000444318; Thu, 03 Oct 2024
 17:07:24 -0700 (PDT)
Date: Thu, 03 Oct 2024 17:07:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66ff31bc.050a0220.49194.03ee.GAE@google.com>
Subject: [syzbot] [btrfs?] WARNING in btrfs_remove_qgroup
From: syzbot <syzbot+f446972e621930b149d8@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5f5673607153 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=14444127980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dedbcb1ff4387972
dashboard link: https://syzkaller.appspot.com/bug?extid=f446972e621930b149d8
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/40172aed5414/disk-5f567360.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/58372f305e9d/vmlinux-5f567360.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d2aae6fa798f/Image-5f567360.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f446972e621930b149d8@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 7433 at fs/btrfs/qgroup.c:1855 btrfs_remove_qgroup+0xab0/0xd60 fs/btrfs/qgroup.c:1856
Modules linked in:
CPU: 1 UID: 0 PID: 7433 Comm: btrfs-cleaner Not tainted 6.11.0-rc7-syzkaller-g5f5673607153 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : btrfs_remove_qgroup+0xab0/0xd60 fs/btrfs/qgroup.c:1856
lr : btrfs_remove_qgroup+0x854/0xd60 fs/btrfs/qgroup.c:1854
sp : ffff8000a3797a20
x29: ffff8000a3797b40 x28: ffff0000da08d800 x27: ffff0000da08d7f0
x26: 0000000000000000 x25: dfff800000000000 x24: 1fffe0001b411afe
x23: ffffffffffff0000 x22: ffff0000ed8738b8 x21: 0000000000000100
x20: ffff0000da08c000 x19: ffff7000146f2f50 x18: ffff8000a3797700
x17: 000000000003c15e x16: ffff8000803600cc x15: ffff7000146f2f2c
x14: 1ffff000146f2f2c x13: 0000000000000004 x12: ffffffffffffffff
x11: ffff7000146f2f2c x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000ef1b3c80 x7 : 0000000000000000 x6 : 0000000000000000
x5 : 0000000000000020 x4 : 0000000000000000 x3 : ffff8000803601f4
x2 : 0000000000000001 x1 : ffff80008ec0334d x0 : ffff80008fcb3300
Call trace:
 btrfs_remove_qgroup+0xab0/0xd60 fs/btrfs/qgroup.c:1856
 btrfs_qgroup_cleanup_dropped_subvolume+0x158/0x194 fs/btrfs/qgroup.c:1904
 btrfs_drop_snapshot+0x2a0/0x1be4 fs/btrfs/extent-tree.c:6260
 btrfs_clean_one_deleted_snapshot+0x238/0x32c
 cleaner_kthread+0x208/0x3dc fs/btrfs/disk-io.c:1520
 kthread+0x288/0x310 kernel/kthread.c:389
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860
irq event stamp: 6130
hardirqs last  enabled at (6129): [<ffff800080a88010>] kasan_quarantine_put+0x1a0/0x1c8 mm/kasan/quarantine.c:234
hardirqs last disabled at (6130): [<ffff80008b3363f4>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:470
softirqs last  enabled at (5920): [<ffff8000800307f8>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (5918): [<ffff8000800307c4>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
BTRFS warning (device loop3): to be deleted qgroup 0/256 has non-zero numbers, rfer 18446744073709486080 rfer_cmpr 18446744073709486080 excl 0 excl_cmpr 0


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

