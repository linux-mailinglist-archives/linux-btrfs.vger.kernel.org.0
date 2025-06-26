Return-Path: <linux-btrfs+bounces-14977-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62429AE9784
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jun 2025 10:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B55B25A2781
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jun 2025 08:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E1E25C831;
	Thu, 26 Jun 2025 08:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXC41stB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D815425C6E5;
	Thu, 26 Jun 2025 08:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750925285; cv=none; b=Jnr4vG7+hH0oeOXJPcdCv/Bv9gy7ENUlxI09zL95osKwqaTu+aNGsYgZqtkqWCzmJwFzAx1cEoz2GBGOGZ0ZIkXKt8rZRI88RvXYAPOKi/DVujC/0gVjlOdZQtcpWhqQMqCMmena7RCH7WUkNFlMh907z9sRwXtinlu5IiK5vKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750925285; c=relaxed/simple;
	bh=gAzKTSgSp68b9IMQWQFKh+3mmgTpa4TDO4r6rFK720U=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=rnt7W/DHIySEcOfS+wrBk3hb6ck/M//UN/+ENB0Ty8n7vOjwiQVhi1yt8nSPCOM5RL3Lwi5NKlNSBXKU+2U1Ng/+QrriQrH6l7opFxQUUoWLDQyQOnM0jFhSpL1pedXMtdMgsGqrrhaZ7lMkB09wTYSVEBbtgKGBQmP29PP1r70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cXC41stB; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e8187601f85so579225276.2;
        Thu, 26 Jun 2025 01:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750925283; x=1751530083; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SjO1G/XUcJ7a9ivy0+i5qLS+ytfTqVMHX0FC/YbGVtU=;
        b=cXC41stByorkxRb8qoYPcydawoPd7r6zF19hV83gInyH6Cny4mhE7FqGqYX4zpxM1Y
         rlUnsATWqOO/yjJ+LzxyU2Hf3hbfokusw6Kc/9+0GPor7acS8dRVWGNgFnDlHV4lCxvh
         uusNNg7Y6ZM/cEsPPWgVHVbEnO0iJaNpn4cqspTA9OPl8YLbDkHGquxq7A4VaEsGReVc
         uJeAnUdyV8XFXYOjF/QSOMnMibxpv1cdzjkbTtAOWl6eBz5aUNnkcg+5Stq8cF94VmV6
         gOuAD9eB9aktrt5BzS/fhYXGgEvFa2l4MqnVAW3i0aerrwI0ohrwEY15TrO9zEBe7JnQ
         mRXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750925283; x=1751530083;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SjO1G/XUcJ7a9ivy0+i5qLS+ytfTqVMHX0FC/YbGVtU=;
        b=h2J8IxaGsLhk0c2In/Zjevmv1tNSQX+LxAAexDnnfYnKfJJ+lY0UPpaX94Um3XJcgi
         AXLsvgo0Sjq/rKxnuWPKFE8E3vgwmOp4Khb/8yBb4p8mpdSQvKZcYl+QoBYITMV6CUxG
         5b5MnpAz+gXZe+DYiSDMoR7xSTZwjpsEdslq9DqNrZylt9Qu6LmKhJbkPI7M6m3MNEZv
         eubyLw2r0k0W34RdDMB+XXaY1kUdOInTLBTNJANNjxtD2RW5fZ8lItb0g8Xf76QnERyd
         2bLeK4RV0QwM9c2kP+k6AEkAjKkJKJSst0kwskUgx8P8lbxWiqU2J7HzIFvpPynCRgW6
         eCZg==
X-Forwarded-Encrypted: i=1; AJvYcCUbjbh9lOQBJ3UF1vsWjFUVi9dsIybsr1AI/KbmSEWsbpZK5PwXr8Eda7RMwZMddQANMmdZs8g4qIFghJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjFEHCV/fZTGLUxUzTAZ3MYUcQPeNo67vP2AUFMewn4xpgOvIH
	O6BHa4zSzFhwFC2Qzel3au3n2mNc8GhgmSYlrYPlKbALTdiZXtEugyo5gIPOrsfeS0P2wkWuVTd
	dUMQXJpkHMccfS8HhJK0sU1iMFDAb2H0=
X-Gm-Gg: ASbGncsZNSdwGn4lC6iFnFBH28HzhCz1mcwE64AE4r8QJCH89Puy32U2wVHl2HufV0x
	IKtOVf8MbgwCapfydLaNsEO984AqiN40CjBvpxmqng9nJfg08380wMliMWBy9wXotPUpr3ZRFan
	UyY7u7Sc2lEOGR1o+CccW2EwDh6TJJZN3G0NLAHmORWEdaEw==
X-Google-Smtp-Source: AGHT+IFV7R4CkXPbX6sM9T1X2WigCRlTUzHAi+djdeWv610aFLocOhlbtP7KGbEizWHiDmwDy/mf0IK6w5eBJpZIviA=
X-Received: by 2002:a05:6902:2683:b0:e81:b2a2:c633 with SMTP id
 3f1490d57ef6-e8601765aa8mr7135237276.32.1750925282648; Thu, 26 Jun 2025
 01:08:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: cen zhang <zzzccc427@gmail.com>
Date: Thu, 26 Jun 2025 16:07:51 +0800
X-Gm-Features: Ac12FXyoRfr0TPbopbf5An2cqZRTVlmf2cyWmw_FJzHtOjGjaDV5xjkwsa8TFls
Message-ID: <CAFRLqsVDimnqBx0_pDF-bqEQ3epha2d3r6cKm-0b6UdzkkE42Q@mail.gmail.com>
Subject: [BUG] btrfs: Assertion failed in btrfs_exclop_balance on balance ioctl
To: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, zhenghaoran154@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello Btrfs maintainers,

I would like to report a kernel BUG, which appears to be a state
management issue in the balance ioctl path.

The kernel panics due to a failed assertion in btrfs_exclop_balance()
at fs/btrfs/fs.c:127. The assertion fs_info->exclusive_operation ==
BTRFS_EXCLOP_BALANCE_PAUSED fails, indicating that the function was
called with an unexpected exclusive operation state.

Here are the relevant details:

Kernel Version: 6.16.0-rc1-g7f6432600434-dirty
Hardware: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996)

Crash Log:
assertion failed: fs_info->exclusive_operation ==
BTRFS_EXCLOP_BALANCE_PAUSED :: 0, in fs/btrfs/fs.c:127
------------[ cut here ]------------
kernel BUG at fs/btrfs/fs.c:127!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 95466 Comm: syz-executor.6 Not tainted
6.16.0-rc1-g7f6432600434-dirty #52 PREEMPT(voluntary)
Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS
1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:btrfs_exclop_balance+0x632/0x640 fs/btrfs/fs.c:127
Code: b5 fe e8 11 0c c7 fe 48 c7 c7 60 06 19 9c 48 c7 c6 80 08 19 9c
31 d2 48 c7 c1 40 08 19 9c 41 b8 7f 00 00 00 e8 7f 2e 7b fe 90 <0f> 0b
66 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90
RSP: 0018:ffff88811c37fd88 EFLAGS: 00010246
RAX: 0000000000000068 RBX: 0000000000000000 RCX: 7c00c5848baac500
RDX: ffffc9001dfc5000 RSI: 000000000000092e RDI: 000000000000092f
RBP: 1ffff110277c95ae R08: ffff88811c37fc2f R09: 1ffff1102386ff85
R10: dffffc0000000000 R11: ffffed102386ff86 R12: ffff88813be4ad70
R13: 1ffffda204ef92b5 R14: dffffc0000000000 R15: ffffed10277c95ae
FS:  00007fda4d92c6c0(0000) GS:ffff88840ff1b000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b31222000 CR3: 000000012ebdb000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 btrfs_ioctl_balance+0x9bd/0xf10 fs/btrfs/ioctl.c:3548
 btrfs_ioctl+0x104f/0x1480 fs/btrfs/ioctl.c:5303
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xd1/0x130 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcf/0x240 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fda4e7fa35d
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fda4d92c0a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fda4e94c1f0 RCX: 00007fda4e7fa35d
RDX: 0000000020008c40 RSI: 00000000c4009420 RDI: 0000000000000003
RBP: 00007fda4e86b4b1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: ffffffffffffffb8 R14: 00007fda4e94c1f0 R15: 00007ffc61c2f0d0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:btrfs_exclop_balance+0x632/0x640 fs/btrfs/fs.c:127
Code: b5 fe e8 11 0c c7 fe 48 c7 c7 60 06 19 9c 48 c7 c6 80 08 19 9c
31 d2 48 c7 c1 40 08 19 9c 41 b8 7f 00 00 00 e8 7f 2e 7b fe 90 <0f> 0b
66 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90
RSP: 0018:ffff88811c37fd88 EFLAGS: 00010246
RAX: 0000000000000068 RBX: 0000000000000000 RCX: 7c00c5848baac500
RDX: ffffc9001dfc5000 RSI: 000000000000092e RDI: 000000000000092f
RBP: 1ffff110277c95ae R08: ffff88811c37fc2f R09: 1ffff1102386ff85
R10: dffffc0000000000 R11: ffffed102386ff86 R12: ffff88813be4ad70
R13: 1ffffda204ef92b5 R14: dffffc0000000000 R15: ffffed10277c95ae
FS:  00007fda4d92c6c0(0000) GS:ffff88840ff1b000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b31222000 CR3: 000000012ebdb000 CR4: 00000000000006f0
note: syz-executor.6[95466] exited with preempt_count 1

Here is the machineinfo:
--------------------------------------------------------------------------------
QEMU emulator version 8.2.2 (Debian 1:8.2.2+ds-0ubuntu1.7)
qemu-system-x86_64 ["-m" "16384" "-smp" "4" "-chardev"
"socket,id=SOCKSYZ,server=on,wait=off,host=localhost,port=24674"
"-mon" "chardev=SOCKSYZ,mode=control" "-display" "none" "-serial"
"stdio" "-no-reboot" "-name" "VM-1" "-device" "virtio-rng-pci"
"-enable-kvm" "-hdb"
"/home/zzzccc/go-work/syzkaller-old/syzkaller/test/btrfs/disk.qcow2"
"-device" "e1000,netdev=net0" "-netdev"
"user,id=net0,restrict=on,hostfwd=tcp:127.0.0.1:35475-:22,hostfwd=tcp::7313-:6060"
"-hda" "/home/zzzccc/go-work/syzkaller-old/syzkaller/test/btrfs/bookworm.img"
"-snapshot" "-kernel" "/home/zzzccc/linux-DDRD/arch/x86/boot/bzImage"
"-append" "root=/dev/sda console=ttyS0 "]

[CPU Info]
processor           : 0, 1, 2, 3
vendor_id           : AuthenticAMD
cpu family          : 15
model               : 107
model name          : QEMU Virtual CPU version 2.5+
stepping            : 1
microcode           : 0x1000065
cpu MHz             : 3593.248
cache size          : 512 KB
physical id         : 0
siblings            : 4
core id             : 0, 1, 2, 3
cpu cores           : 4
apicid              : 0, 1, 2, 3
initial apicid      : 0, 1, 2, 3
fpu                 : yes
fpu_exception       : yes
cpuid level         : 13
wp                  : yes
flags               : fpu de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx lm rep_good
nopl cpuid extd_apicid tsc_known_freq pni cx16 x2apic hypervisor
lahf_lm cmp_legacy svm 3dnowprefetch vmmcall
bugs                : fxsave_leak sysret_ss_attrs null_seg
swapgs_fence amd_e400 spectre_v1 spectre_v2 spectre_v2_user
bogomips            : 7186.49
TLB size            : 1024 4K pages
clflush size        : 64
cache_alignment     : 64
address sizes       : 40 bits physical, 48 bits virtual
power management    :

--------------------------------------------------------------------------------

Here is the log of this
bug:https://github.com/zzzcccyyyggg/Syzkaller-log/blob/main/c206ec44dc552558339e6db76afe471d2dcee23b/log3

Thank you for your attention to this matter.

Best regards,
Cen Zhang

