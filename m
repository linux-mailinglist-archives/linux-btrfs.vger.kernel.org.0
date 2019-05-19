Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9417622852
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 May 2019 20:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfESSZB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 19 May 2019 14:25:01 -0400
Received: from mail-ua1-f48.google.com ([209.85.222.48]:45595 "EHLO
        mail-ua1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfESSZB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 19 May 2019 14:25:01 -0400
Received: by mail-ua1-f48.google.com with SMTP id n7so4504235uap.12
        for <linux-btrfs@vger.kernel.org>; Sun, 19 May 2019 11:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=qL6exKqM92oEgu+amnHqAN1xkTGNHPzhqQAvw96zqbc=;
        b=jnEjVaq5aEfcNTzM+eGPEDqw04XPmcZ6dGgyrA3jtBGkoU/0dmkdLWwfjp+GfHhPC/
         oFa3yfnbQKrU01QSyp8dytYJZGkga+R9XqHGzJwBC5Gw2YGJLudjAR9n0XWTu0Rl0Nux
         0scVWtIAeUs91VfZ94Z0W3eWWh9S/AftNeUWXpvCMd7F334VyWtpWlcMWRqyViyEz8vB
         CKpQxP/p6TegGy9MmG1bHSLKwHkBeEJFOJlwkaFUnkUvB9AZRyZCf8vVi9NW4fuWxb9n
         b3x05sjLDb0zhLo6n6odUiOXa8lzKvry45goyB0RLwLJnNjUr8TRp7ckYl8SpwLIDA8u
         LqtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=qL6exKqM92oEgu+amnHqAN1xkTGNHPzhqQAvw96zqbc=;
        b=l74QmqjPPZzOloChRWodfezOtxMfyn16ht9JNSqh4eHHP9/E/uNoHPN8dD1fkM6Pwa
         hbAv1IthishjPNyFt/ov68NvgeolCIcr1AyXm0dvPNUcc9RceJRKgn4PM4Oo6+huuCRD
         lY+pxcEqt0VlpcuqfxsnOFf2Cf4+gOCMvQk+8svxeglEyDyPWquG1+VzgTJeq7xjd3Cl
         K/C0vY5CWtskVwQbqtKh1/K9JxMoHBUo5Q+oMWivA1ZrIbbbAeBKhevxL3Dkao4ikIbs
         /y1rfkmZBB3LTVXF7PG3sg5G86KQBrFbRsX9+OzTpNVWE34r+VWV8IcyMdMP8RALNuuw
         s4ow==
X-Gm-Message-State: APjAAAVBcQtjDrXFIxVrYQc8KwV+shzEEq6tIJMieXjlmyJJ8/0v8e5W
        zpyyiuLvaLakMzupC8JxjXpCrwV7IqW8O6A5jjUsfQru
X-Google-Smtp-Source: APXvYqzQ1FsOgH3v0iWwpKXeH4y/PK7XAj5KCST6JnfTPzkoaEBVkCKmYhz2vIpXY1xR6qwacfusxfjTMJAFvq11gIM=
X-Received: by 2002:ab0:70b1:: with SMTP id q17mr9824353ual.123.1558261530982;
 Sun, 19 May 2019 03:25:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190518230330.GK20359@hungrycats.org>
In-Reply-To: <20190518230330.GK20359@hungrycats.org>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Sun, 19 May 2019 11:25:19 +0100
Message-ID: <CAL3q7H5veRD4gNV19L_7ZQAzK_zWpSRZ_-9M8U1mzECcmCRNww@mail.gmail.com>
Subject: Re: 5.1.3: unable to handle kernel NULL pointer dereference in btrfs_reloc_pre_snapshot
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, May 19, 2019 at 12:50 AM Zygo Blaxell
<ce3g8jdj@umail.furryterror.org> wrote:
>
> There are several new things in 5.1.  First a lockdep warning:
>
>         [  146.037574][    C3] hrtimer: interrupt took 2002067 ns
>         [  365.442210][    C2]
>         [  365.442616][    C2] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>         [  365.443477][    C2] WARNING: inconsistent lock state
>         [  365.444389][    C2] 5.1.3-zb64-253cbcb7e197+ #1 Tainted: G    =
    W
>         [  365.445491][    C2] --------------------------------
>         [  365.446670][    C2] inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ=
-W} usage.
>         [  365.447961][    C2] swapper/2/0 [HC0[0]:SC1[1]:HE1:SE0] takes:
>         [  365.449941][    C2] 00000000d8a506e5 (&(&wsm.lock)->rlock){+.?=
.}, at: zstd_reclaim_timer_fn+0x29/0x190
>         [  365.452043][    C2] {SOFTIRQ-ON-W} state was registered at:
>         [  365.453394][    C2]   lock_acquire+0xbd/0x1c0
>         [  365.454180][    C2]   _raw_spin_lock+0x34/0x70
>         [  365.455021][    C2]   zstd_get_workspace+0x63/0x280
>         [  365.455889][    C2]   end_compressed_bio_read+0x1cf/0x450
>         [  365.457373][    C2]   bio_endio+0xce/0x1c0
>         [  365.458203][    C2]   end_workqueue_fn+0x3d/0x40
>         [  365.462307][    C2]   normal_work_helper+0x92/0x540
>         [  365.463127][    C2]   btrfs_endio_helper+0x12/0x20
>         [  365.463926][    C2]   process_one_work+0x219/0x5b0
>         [  365.465856][    C2]   worker_thread+0x50/0x3b0
>         [  365.468178][    C2]   kthread+0x113/0x150
>         [  365.470036][    C2]   ret_from_fork+0x3a/0x50
>         [  365.471078][    C2] irq event stamp: 9111086
>         [  365.471833][    C2] hardirqs last  enabled at (9111086): [<fff=
fffff8ee003dc>] _raw_spin_unlock_irq+0x2c/0x40
>         [  365.473624][    C2] hardirqs last disabled at (9111085): [<fff=
fffff8ee001db>] _raw_spin_lock_irq+0x1b/0x80
>         [  365.475919][    C2] softirqs last  enabled at (9111082): [<fff=
fffff8e0aa211>] _local_bh_enable+0x21/0x40
>         [  365.479666][    C2] softirqs last disabled at (9111083): [<fff=
fffff8e0aa687>] irq_exit+0xd7/0xe0
>         [  365.481182][    C2]
>         [  365.481182][    C2] other info that might help us debug this:
>         [  365.486991][    C2]  Possible unsafe locking scenario:
>         [  365.486991][    C2]
>         [  365.491624][    C2]        CPU0
>         [  365.493150][    C2]        ----
>         [  365.495753][    C2]   lock(&(&wsm.lock)->rlock);
>         [  365.496972][    C2]   <Interrupt>
>         [  365.497928][    C2]     lock(&(&wsm.lock)->rlock);
>         [  365.498814][    C2]
>         [  365.498814][    C2]  *** DEADLOCK ***
>         [  365.498814][    C2]
>         [  365.500495][    C2] 1 lock held by swapper/2/0:
>         [  365.501404][    C2]  #0: 0000000047f0977b ((&wsm.timer)){+.-.}=
, at: call_timer_fn+0x5/0x2d0
>         [  365.502888][    C2]
>         [  365.502888][    C2] stack backtrace:
>         [  365.504240][    C2] CPU: 2 PID: 0 Comm: swapper/2 Tainted: G  =
      W         5.1.3-zb64-253cbcb7e197+ #1
>         [  365.506643][    C2] Hardware name: QEMU Standard PC (i440FX + =
PIIX, 1996), BIOS 1.10.2-1 04/01/2014
>         [  365.508310][    C2] Call Trace:
>         [  365.508909][    C2]  <IRQ>
>         [  365.509420][    C2]  dump_stack+0x86/0xc5
>         [  365.510172][    C2]  print_usage_bug+0x208/0x2b0
>         [  365.511040][    C2]  mark_lock+0x5af/0x660
>         [  365.511811][    C2]  ? kvm_sched_clock_read+0x18/0x30
>         [  365.512755][    C2]  ? print_irq_inversion_bug+0x220/0x220
>         [  365.513764][    C2]  __lock_acquire+0x293/0x14b0
>         [  365.514600][    C2]  ? save_trace+0x3b/0xb0
>         [  365.515351][    C2]  ? mark_lock+0x26a/0x660
>         [  365.516126][    C2]  lock_acquire+0xbd/0x1c0
>         [  365.516896][    C2]  ? zstd_reclaim_timer_fn+0x29/0x190
>         [  365.517833][    C2]  ? zstd_put_workspace+0x170/0x170
>         [  365.518736][    C2]  _raw_spin_lock+0x34/0x70
>         [  365.519519][    C2]  ? zstd_reclaim_timer_fn+0x29/0x190
>         [  365.520448][    C2]  zstd_reclaim_timer_fn+0x29/0x190
>         [  365.521359][    C2]  ? zstd_put_workspace+0x170/0x170
>         [  365.522279][    C2]  call_timer_fn+0xab/0x2d0
>         [  365.523038][    C2]  ? zstd_put_workspace+0x170/0x170
>         [  365.523913][    C2]  expire_timers+0xba/0x180
>         [  365.524761][    C2]  run_timer_softirq+0x8f/0x170
>         [  365.525933][    C2]  __do_softirq+0xd9/0x45a
>         [  365.526787][    C2]  irq_exit+0xd7/0xe0
>         [  365.527499][    C2]  smp_apic_timer_interrupt+0xa7/0x230
>         [  365.528474][    C2]  apic_timer_interrupt+0xf/0x20
>         [  365.529311][    C2]  </IRQ>
>         [  365.530733][    C2] RIP: 0010:native_safe_halt+0x12/0x20
>         [  365.531847][    C2] Code: f0 80 48 02 20 48 8b 00 a8 08 0f 84 =
7b ff ff ff eb bd 90 90 90 90 90 90 55 48 89 e5 e9 07 00 00 00 0f 00 2d 32 =
ad 60 00 fb f4 <5d> c3 66 90 66 2e 0f 1f 84 00 00 00 00 00 55 48 89 e5 e9 0=
7 00 00
>         [  365.537202][    C2] RSP: 0018:ffffa93040d1be58 EFLAGS: 0000021=
2 ORIG_RAX: ffffffffffffff13
>         [  365.539913][    C2] RAX: ffff9c1746f34000 RBX: 000000000000000=
2 RCX: 0000000000000001
>         [  365.541246][    C2] RDX: 0000000000000001 RSI: 000000000000000=
6 RDI: ffff9c1746f34000
>         [  365.542526][    C2] RBP: ffffa93040d1be58 R08: 000000000000000=
1 R09: 0000000000000000
>         [  365.543807][    C2] R10: 0000000000000000 R11: 000000000000000=
0 R12: 0000000000000002
>         [  365.545205][    C2] R13: ffff9c1746f34000 R14: ffff9c1746f3400=
0 R15: 0000000000000000
>         [  365.546695][    C2]  default_idle+0x27/0x170
>         [  365.547489][    C2]  arch_cpu_idle+0x15/0x20
>         [  365.548540][    C2]  default_idle_call+0x28/0x40
>         [  365.549569][    C2]  do_idle+0x1d8/0x2a0
>         [  365.550481][    C2]  cpu_startup_entry+0x1d/0x20
>         [  365.551554][    C2]  start_secondary+0x18a/0x1e0
>         [  365.552568][    C2]  secondary_startup_64+0xa4/0xb0
>
> Then a NULL pointer dereference:
>
>         [ 6232.422945][ T4605] BUG: unable to handle kernel NULL pointer =
dereference at 0000000000000649
>         [ 6232.425219][ T4605] #PF error: [normal kernel read fault]
>         [ 6232.426362][ T4605] PGD 0 P4D 0
>         [ 6232.427051][ T4605] Oops: 0000 [#1] SMP PTI
>         [ 6232.427932][ T4605] CPU: 2 PID: 4605 Comm: btrfs-transacti Tai=
nted: G        W         5.1.3-zb64-253cbcb7e197+ #1
>         [ 6232.430158][ T4605] Hardware name: QEMU Standard PC (i440FX + =
PIIX, 1996), BIOS 1.10.2-1 04/01/2014
>         [ 6232.433929][ T4605] RIP: 0010:btrfs_reloc_pre_snapshot+0x24/0x=
50

Known problem, should be fixed by:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D10995c0491204c861948c9850939a7f4e90760a4

Which is not on 5.1.x (at least yet).

>         [ 6232.436091][ T4605] Code: 04 00 00 0f 1f 00 0f 1f 44 00 00 48 =
8b 47 10 55 48 89 e5 48 8b 50 18 48 85 d2 74 2b 48 8b 80 f0 01 00 00 48 8b =
80 18 1a 00 00 <f6> 80 49 06 00 00 02 74 14 8b 92 00 01 00 00 85 d2 74 0c 4=
8 8b 80
>         [ 6232.439211][ T4605] RSP: 0018:ffffa93041877cf0 EFLAGS: 0001028=
6
>         [ 6232.440425][ T4605] RAX: 0000000000000000 RBX: ffff9c16570dcc0=
0 RCX: 0000000000000000
>         [ 6232.441720][ T4605] RDX: ffff9c17eb84c000 RSI: ffffa93041877d6=
0 RDI: ffff9c16570dcc00
>         [ 6232.442961][ T4605] RBP: ffffa93041877cf0 R08: 000000000000000=
1 R09: 0000000000000000
>         [ 6232.444103][ T4605] R10: ffffa93041877cc8 R11: 000000000000000=
0 R12: ffff9c1874e78548
>         [ 6232.445275][ T4605] R13: ffff9c16570dcc38 R14: ffff9c18590c3c0=
0 R15: 0000000000000000
>         [ 6232.446484][ T4605] FS:  0000000000000000(0000) GS:ffff9c18764=
00000(0000) knlGS:0000000000000000
>         [ 6232.447765][ T4605] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008=
0050033
>         [ 6232.448714][ T4605] CR2: 0000000000000649 CR3: 000000007ba2a00=
2 CR4: 00000000001606e0
>         [ 6232.450023][ T4605] Call Trace:
>         [ 6232.451163][ T4605]  create_pending_snapshot+0xc8/0xf60
>         [ 6232.454249][ T4605]  ? __mutex_lock+0x42a/0xa00
>         [ 6232.455684][ T4605]  ? btrfs_commit_transaction+0x480/0xab0
>         [ 6232.456884][ T4605]  create_pending_snapshots+0xb4/0xe0
>         [ 6232.457683][ T4605]  ? create_pending_snapshots+0xb4/0xe0
>         [ 6232.458465][ T4605]  btrfs_commit_transaction+0x488/0xab0
>         [ 6232.459615][ T4605]  ? wait_woken+0xa0/0xa0
>         [ 6232.460224][ T4605]  transaction_kthread+0x155/0x190
>         [ 6232.461070][ T4605]  kthread+0x113/0x150
>         [ 6232.461888][ T4605]  ? btrfs_cleanup_transaction+0x620/0x620
>         [ 6232.463035][ T4605]  ? kthread_park+0x90/0x90
>         [ 6232.463678][ T4605]  ret_from_fork+0x3a/0x50
>         [ 6232.464688][ T4605] Modules linked in: mq_deadline bfq crct10d=
if_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel dm_cache_smq aesni_=
intel dm_cache dm_persistent_data aes_x86_64 dm_bio_prison dm_bufio snd_pcm=
 snd_timer joydev ppdev sr_mod cdrom crypto_simd snd sg dm_mod cryptd glue_=
helper ide_pci_generic input_leds parport_pc soundcore psmouse piix pcspkr =
serio_raw rtc_cmos bochs_drm evbug ide_core parport floppy i2c_piix4 qemu_f=
w_cfg evdev ip_tables x_tables ipv6 crc_ccitt autofs4
>         [ 6232.473176][ T4605] CR2: 0000000000000649
>         [ 6232.474009][ T4605] ---[ end trace 6f7a8491777a8b04 ]---
>         [ 6232.475357][ T4605] RIP: 0010:btrfs_reloc_pre_snapshot+0x24/0x=
50
>         [ 6232.476284][ T4605] Code: 04 00 00 0f 1f 00 0f 1f 44 00 00 48 =
8b 47 10 55 48 89 e5 48 8b 50 18 48 85 d2 74 2b 48 8b 80 f0 01 00 00 48 8b =
80 18 1a 00 00 <f6> 80 49 06 00 00 02 74 14 8b 92 00 01 00 00 85 d2 74 0c 4=
8 8b 80
>         [ 6232.479946][ T4605] RSP: 0018:ffffa93041877cf0 EFLAGS: 0001028=
6
>         [ 6232.481409][ T4605] RAX: 0000000000000000 RBX: ffff9c16570dcc0=
0 RCX: 0000000000000000
>         [ 6232.483965][ T4605] RDX: ffff9c17eb84c000 RSI: ffffa93041877d6=
0 RDI: ffff9c16570dcc00
>         [ 6232.485338][ T4605] RBP: ffffa93041877cf0 R08: 000000000000000=
1 R09: 0000000000000000
>         [ 6232.486697][ T4605] R10: ffffa93041877cc8 R11: 000000000000000=
0 R12: ffff9c1874e78548
>         [ 6232.488828][ T4605] R13: ffff9c16570dcc38 R14: ffff9c18590c3c0=
0 R15: 0000000000000000
>         [ 6232.490076][ T4605] FS:  0000000000000000(0000) GS:ffff9c18764=
00000(0000) knlGS:0000000000000000
>         [ 6232.491497][ T4605] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008=
0050033
>         [ 6232.492503][ T4605] CR2: 0000000000000649 CR3: 000000007ba2a00=
2 CR4: 00000000001606e0
>         [ 6232.493944][ T4605] BUG: sleeping function called from invalid=
 context at ./include/linux/percpu-rwsem.h:34
>         [ 6232.495520][ T4605] in_atomic(): 0, irqs_disabled(): 1, pid: 4=
605, name: btrfs-transacti
>         [ 6232.496799][ T4605] INFO: lockdep is turned off.
>         [ 6232.497538][ T4605] irq event stamp: 18823342
>         [ 6232.498259][ T4605] hardirqs last  enabled at (18823341): [<ff=
ffffff8ee00386>] _raw_spin_unlock_irqrestore+0x36/0x60
>         [ 6232.499913][ T4605] hardirqs last disabled at (18823342): [<ff=
ffffff8edf8659>] __schedule+0xd9/0xb70
>         [ 6232.501353][ T4605] softirqs last  enabled at (18822830): [<ff=
ffffff8f2003a0>] __do_softirq+0x3a0/0x45a
>         [ 6232.502848][ T4605] softirqs last disabled at (18822803): [<ff=
ffffff8e0aa687>] irq_exit+0xd7/0xe0
>         [ 6232.504580][ T4605] CPU: 2 PID: 4605 Comm: btrfs-transacti Tai=
nted: G      D W         5.1.3-zb64-253cbcb7e197+ #1
>         [ 6232.506380][ T4605] Hardware name: QEMU Standard PC (i440FX + =
PIIX, 1996), BIOS 1.10.2-1 04/01/2014
>         [ 6232.508613][ T4605] Call Trace:
>         [ 6232.509151][ T4605]  dump_stack+0x86/0xc5
>         [ 6232.509840][ T4605]  ___might_sleep+0x217/0x240
>         [ 6232.510687][ T4605]  __might_sleep+0x4a/0x80
>         [ 6232.511513][ T4605]  exit_signals+0x33/0x250
>         [ 6232.512366][ T4605]  ? blocking_notifier_call_chain+0x16/0x20
>         [ 6232.513637][ T4605]  do_exit+0xb9/0xd70
>         [ 6232.514315][ T4605]  ? kthread+0x113/0x150
>         [ 6232.515060][ T4605]  ? btrfs_cleanup_transaction+0x620/0x620
>         [ 6232.516281][ T4605]  rewind_stack_do_exit+0x17/0x20
>
> Then the kernel is pretty firmly hung:
>
>         [ 9251.809489][T31622] sysrq: Show Blocked State
>         [ 9251.810626][T31622]   task                        PC stack   p=
id father
>         [ 9251.812730][T31622] rsync           D    0  4679   4673 0x0000=
0000
>         [ 9251.815531][T31622] Call Trace:
>         [ 9251.817059][T31622]  __schedule+0x3d4/0xb70
>         [ 9251.817751][T31622]  schedule+0x3d/0x80
>         [ 9251.818386][T31622]  btrfs_wait_for_snapshot_creation+0xb2/0xe=
0
>         [ 9251.819287][T31622]  ? wake_up_var+0x40/0x40
>         [ 9251.820077][T31622]  btrfs_setattr+0x316/0x5a0
>         [ 9251.820870][T31622]  notify_change+0x2f0/0x450
>         [ 9251.821665][T31622]  do_truncate+0x73/0xc0
>         [ 9251.823106][T31622]  do_sys_ftruncate+0x12b/0x1c0
>         [ 9251.824576][T31622]  __x64_sys_ftruncate+0x1b/0x20
>         [ 9251.826003][T31622]  do_syscall_64+0x65/0x1a0
>         [ 9251.827017][T31622]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>         [ 9251.828250][T31622] RIP: 0033:0x7fc5836d6c97
>         [ 9251.829905][T31622] Code: Bad RIP value.
>         [ 9251.830864][T31622] RSP: 002b:00007fffd20dd408 EFLAGS: 0000024=
6 ORIG_RAX: 000000000000004d
>         [ 9251.833133][T31622] RAX: ffffffffffffffda RBX: 000000000000000=
0 RCX: 00007fc5836d6c97
>         [ 9251.834482][T31622] RDX: 0000000000000000 RSI: 000000000000053=
c RDI: 0000000000000003
>         [ 9251.835980][T31622] RBP: 0000000000000003 R08: 000000000000000=
0 R09: 00000000e7379d85
>         [ 9251.837482][T31622] R10: 0000000051ef429d R11: 000000000000024=
6 R12: 000000000000053c
>         [ 9251.838969][T31622] R13: 00000000000002bc R14: 000000000000028=
0 R15: 0000000000000000
>         [ 9251.841044][T31622] crawl_5268      D    0  4781   4770 0x0000=
0000
>         [ 9251.845477][T31622] Call Trace:
>         [ 9251.846430][T31622]  __schedule+0x3d4/0xb70
>         [ 9251.848194][T31622]  schedule+0x3d/0x80
>         [ 9251.850050][T31622]  wait_current_trans+0xcf/0x110
>         [ 9251.852115][T31622]  ? wait_woken+0xa0/0xa0
>         [ 9251.853495][T31622]  start_transaction+0x156/0x4d0
>         [ 9251.854845][T31622]  btrfs_start_transaction+0x1e/0x20
>         [ 9251.855605][T31622]  btrfs_clone+0x4cc/0xcf0
>         [ 9251.859008][T31622]  btrfs_extent_same_range+0x4c/0x80
>         [ 9251.861967][T31622]  btrfs_remap_file_range+0x28b/0x340
>         [ 9251.863063][T31622]  vfs_dedupe_file_range_one+0x111/0x170
>         [ 9251.865141][T31622]  vfs_dedupe_file_range+0x157/0x1f0
>         [ 9251.867887][T31622]  do_vfs_ioctl+0x27f/0x6e0
>         [ 9251.868664][T31622]  ? __fget+0x126/0x220
>         [ 9251.873198][T31622]  ksys_ioctl+0x75/0x80
>         [ 9251.876000][T31622]  __x64_sys_ioctl+0x1a/0x20
>         [ 9251.878012][T31622]  do_syscall_64+0x65/0x1a0
>         [ 9251.880419][T31622]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>         [ 9251.883663][T31622] RIP: 0033:0x7f839dbb1777
>         [ 9251.886061][T31622] Code: Bad RIP value.
>         [ 9251.887446][T31622] RSP: 002b:00007f839cab5978 EFLAGS: 0000024=
6 ORIG_RAX: 0000000000000010
>         [ 9251.889513][T31622] RAX: ffffffffffffffda RBX: 00007f835c0a4ee=
0 RCX: 00007f839dbb1777
>         [ 9251.891472][T31622] RDX: 00007f835c0a4ee0 RSI: 00000000c018943=
6 RDI: 000000000000036f
>         [ 9251.893255][T31622] RBP: 00007f839cab5d00 R08: 000000000000000=
f R09: 00007f835c039cb0
>         [ 9251.894945][T31622] R10: 0000000000000005 R11: 000000000000024=
6 R12: 0000000000000001
>         [ 9251.896073][T31622] R13: 0000000000000018 R14: 00007f835c039cc=
8 R15: 00007f839cab5d08
>         [ 9251.898101][T31622] crawl_5268      D    0  4782   4770 0x0000=
0000
>         [ 9251.899005][T31622] Call Trace:
>         [ 9251.899494][T31622]  __schedule+0x3d4/0xb70
>         [ 9251.900122][T31622]  schedule+0x3d/0x80
>         [ 9251.900904][T31622]  wait_current_trans+0xcf/0x110
>         [ 9251.902195][T31622]  ? wait_woken+0xa0/0xa0
>         [ 9251.903689][T31622]  start_transaction+0x307/0x4d0
>         [ 9251.904568][T31622]  ? btrfs_inode_flags_to_fsflags+0x90/0x90
>         [ 9251.905825][T31622]  btrfs_attach_transaction+0x1d/0x20
>         [ 9251.907413][T31622]  iterate_extent_inodes+0x2e0/0x390
>         [ 9251.908843][T31622]  ? release_extent_buffer+0xaa/0xe0
>         [ 9251.909672][T31622]  ? _raw_spin_unlock+0x27/0x40
>         [ 9251.910855][T31622]  iterate_inodes_from_logical+0xa1/0xd0
>         [ 9251.912145][T31622]  ? iterate_inodes_from_logical+0xa1/0xd0
>         [ 9251.913008][T31622]  ? btrfs_inode_flags_to_fsflags+0x90/0x90
>         [ 9251.914088][T31622]  btrfs_ioctl_logical_to_ino+0xf3/0x1a0
>         [ 9251.915107][T31622]  btrfs_ioctl+0xba1/0x2cf0
>         [ 9251.915997][T31622]  ? get_task_mm+0x20/0x50
>         [ 9251.916838][T31622]  do_vfs_ioctl+0xa6/0x6e0
>         [ 9251.917555][T31622]  ? btrfs_ioctl_get_supported_features+0x30=
/0x30
>         [ 9251.919220][T31622]  ? do_vfs_ioctl+0xa6/0x6e0
>         [ 9251.920102][T31622]  ? __fget+0x126/0x220
>         [ 9251.921079][T31622]  ksys_ioctl+0x75/0x80
>         [ 9251.921852][T31622]  __x64_sys_ioctl+0x1a/0x20
>         [ 9251.922670][T31622]  do_syscall_64+0x65/0x1a0
>         [ 9251.923924][T31622]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>         [ 9251.925292][T31622] RIP: 0033:0x7f839dbb1777
>         [ 9251.926224][T31622] Code: Bad RIP value.
>         [ 9251.926812][T31622] RSP: 002b:00007f8397ffc458 EFLAGS: 0000024=
6 ORIG_RAX: 0000000000000010
>         [ 9251.928082][T31622] RAX: ffffffffffffffda RBX: 00007f8397ffc78=
0 RCX: 00007f839dbb1777
>         [ 9251.929838][T31622] RDX: 00007f8397ffc788 RSI: 00000000c038943=
b RDI: 0000000000000004
>         [ 9251.931848][T31622] RBP: 0000000001000000 R08: 000000000000000=
0 R09: 00007f8397ffc960
>         [ 9251.933334][T31622] R10: 000055be24244c40 R11: 000000000000024=
6 R12: 0000000000000004
>         [ 9251.934763][T31622] R13: 00007f8397ffc788 R14: 00007f8397ffc66=
8 R15: 00007f8397ffc890
>         [ 9251.935998][T31622] crawl_5268      D    0  4783   4770 0x0000=
0000
>         [ 9251.937424][T31622] Call Trace:
>         [ 9251.937896][T31622]  __schedule+0x3d4/0xb70
>         [ 9251.938612][T31622]  schedule+0x3d/0x80
>         [ 9251.939198][T31622]  wait_current_trans+0xcf/0x110
>         [ 9251.940643][T31622]  ? wait_woken+0xa0/0xa0
>         [ 9251.941668][T31622]  start_transaction+0x156/0x4d0
>         [ 9251.942460][T31622]  btrfs_start_transaction+0x1e/0x20
>         [ 9251.943204][T31622]  btrfs_clone+0x4cc/0xcf0
>         [ 9251.944232][T31622]  btrfs_extent_same_range+0x4c/0x80
>         [ 9251.945732][T31622]  btrfs_remap_file_range+0x28b/0x340
>         [ 9251.948171][T31622]  vfs_dedupe_file_range_one+0x111/0x170
>         [ 9251.949207][T31622]  vfs_dedupe_file_range+0x157/0x1f0
>         [ 9251.951123][T31622]  do_vfs_ioctl+0x27f/0x6e0
>         [ 9251.953129][T31622]  ? __fget+0x126/0x220
>         [ 9251.954640][T31622]  ksys_ioctl+0x75/0x80
>         [ 9251.958247][T31622]  __x64_sys_ioctl+0x1a/0x20
>         [ 9251.961062][T31622]  do_syscall_64+0x65/0x1a0
>         [ 9251.963316][T31622]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>         [ 9251.965372][T31622] RIP: 0033:0x7f839dbb1777
>         [ 9251.967046][T31622] Code: Bad RIP value.
>         [ 9251.967753][T31622] RSP: 002b:00007f83977fa978 EFLAGS: 0000024=
6 ORIG_RAX: 0000000000000010
>         [ 9251.970311][T31622] RAX: ffffffffffffffda RBX: 00007f8364524dc=
0 RCX: 00007f839dbb1777
>         [ 9251.974458][T31622] RDX: 00007f8364524dc0 RSI: 00000000c018943=
6 RDI: 00000000000005ae
>         [ 9251.977869][T31622] RBP: 00007f83977fad00 R08: 000000000000000=
f R09: 00007f837012f780
>         [ 9251.980263][T31622] R10: 0000000000000005 R11: 000000000000024=
6 R12: 0000000000000001
>         [ 9251.984197][T31622] R13: 0000000000000018 R14: 00007f837012f79=
8 R15: 00007f83977fad08
>         [ 9251.988018][T31622] crawl_5268      D    0  4784   4770 0x0000=
0000
>         [ 9251.989881][T31622] Call Trace:
>         [ 9251.990586][T31622]  __schedule+0x3d4/0xb70
>         [ 9251.991704][T31622]  schedule+0x3d/0x80
>         [ 9251.993954][T31622]  wait_current_trans+0xcf/0x110
>         [ 9251.995135][T31622]  ? wait_woken+0xa0/0xa0
>         [ 9251.996811][T31622]  start_transaction+0x307/0x4d0
>         [ 9251.997689][T31622]  ? btrfs_inode_flags_to_fsflags+0x90/0x90
>         [ 9251.999005][T31622]  btrfs_attach_transaction+0x1d/0x20
>         [ 9251.999918][T31622]  iterate_extent_inodes+0x2e0/0x390
>         [ 9252.000837][T31622]  ? release_extent_buffer+0xaa/0xe0
>         [ 9252.001758][T31622]  ? _raw_spin_unlock+0x27/0x40
>         [ 9252.002615][T31622]  iterate_inodes_from_logical+0xa1/0xd0
>         [ 9252.004283][T31622]  ? iterate_inodes_from_logical+0xa1/0xd0
>         [ 9252.006174][T31622]  ? btrfs_inode_flags_to_fsflags+0x90/0x90
>         [ 9252.007222][T31622]  btrfs_ioctl_logical_to_ino+0xf3/0x1a0
>         [ 9252.008960][T31622]  btrfs_ioctl+0xba1/0x2cf0
>         [ 9252.009829][T31622]  ? get_task_mm+0x20/0x50
>         [ 9252.010800][T31622]  do_vfs_ioctl+0xa6/0x6e0
>         [ 9252.011624][T31622]  ? btrfs_ioctl_get_supported_features+0x30=
/0x30
>         [ 9252.013060][T31622]  ? do_vfs_ioctl+0xa6/0x6e0
>         [ 9252.014621][T31622]  ? __fget+0x126/0x220
>         [ 9252.015302][T31622]  ksys_ioctl+0x75/0x80
>         [ 9252.015996][T31622]  __x64_sys_ioctl+0x1a/0x20
>         [ 9252.016744][T31622]  do_syscall_64+0x65/0x1a0
>         [ 9252.017489][T31622]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>         [ 9252.018600][T31622] RIP: 0033:0x7f839dbb1777
>         [ 9252.019544][T31622] Code: Bad RIP value.
>         [ 9252.021882][T31622] RSP: 002b:00007f8396ffa458 EFLAGS: 0000024=
6 ORIG_RAX: 0000000000000010
>         [ 9252.023923][T31622] RAX: ffffffffffffffda RBX: 00007f8396ffa78=
0 RCX: 00007f839dbb1777
>         [ 9252.026751][T31622] RDX: 00007f8396ffa788 RSI: 00000000c038943=
b RDI: 0000000000000004
>         [ 9252.029657][T31622] RBP: 0000000001000000 R08: 000000000000000=
0 R09: 00007f8396ffa960
>         [ 9252.032056][T31622] R10: 000055be24244c40 R11: 000000000000024=
6 R12: 0000000000000004
>         [ 9252.035145][T31622] R13: 00007f8396ffa788 R14: 00007f8396ffa66=
8 R15: 00007f8396ffa890
>         [ 9252.037693][T31622] hash_prefetch   D    0  4786   4770 0x0000=
0000
>         [ 9252.038625][T31622] Call Trace:
>         [ 9252.039558][T31622]  __schedule+0x3d4/0xb70
>         [ 9252.040310][T31622]  ? rwsem_down_write_failed+0x165/0x300
>         [ 9252.042065][T31622]  schedule+0x3d/0x80
>         [ 9252.043483][T31622]  rwsem_down_write_failed+0x16a/0x300
>         [ 9252.044315][T31622]  call_rwsem_down_write_failed+0x17/0x30
>         [ 9252.045363][T31622]  ? call_rwsem_down_write_failed+0x17/0x30
>         [ 9252.046235][T31622]  ? do_unlinkat+0x124/0x2f0
>         [ 9252.047065][T31622]  down_write_nested+0x91/0xc0
>         [ 9252.047956][T31622]  do_unlinkat+0x124/0x2f0
>         [ 9252.049087][T31622]  __se_sys_unlinkat+0x2c/0x40
>         [ 9252.050215][T31622]  __x64_sys_unlinkat+0x1a/0x20
>         [ 9252.051262][T31622]  do_syscall_64+0x65/0x1a0
>         [ 9252.052015][T31622]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>         [ 9252.052878][T31622] RIP: 0033:0x7f839dbad2f7
>         [ 9252.053532][T31622] Code: Bad RIP value.
>         [ 9252.055254][T31622] RSP: 002b:00007f8395ff9ea8 EFLAGS: 0000024=
6 ORIG_RAX: 0000000000000107
>         [ 9252.058096][T31622] RAX: ffffffffffffffda RBX: 00007f8395ff9ed=
0 RCX: 00007f839dbad2f7
>         [ 9252.061460][T31622] RDX: 0000000000000000 RSI: 00007f8374004b3=
0 RDI: 0000000000000003
>         [ 9252.062771][T31622] RBP: 000055be24865b58 R08: 000000000000000=
0 R09: 00007f8395ff9f80
>         [ 9252.064705][T31622] R10: 000055be24244c40 R11: 000000000000024=
6 R12: 00007f8395ff9fe0
>         [ 9252.066166][T31622] R13: 00007f8395ffa200 R14: 00007f83740135f=
0 R15: 00007f8395ffa1b0
>         [ 9252.067530][T31622] crawl_writeback D    0  4788   4770 0x0000=
0000
>         [ 9252.068817][T31622] Call Trace:
>         [ 9252.069369][T31622]  __schedule+0x3d4/0xb70
>         [ 9252.070087][T31622]  schedule+0x3d/0x80
>         [ 9252.070848][T31622]  wait_current_trans+0xcf/0x110
>         [ 9252.071663][T31622]  ? wait_woken+0xa0/0xa0
>         [ 9252.072423][T31622]  start_transaction+0x156/0x4d0
>         [ 9252.073282][T31622]  btrfs_start_transaction+0x1e/0x20
>         [ 9252.074382][T31622]  btrfs_create+0x5d/0x200
>         [ 9252.076407][T31622]  lookup_open+0x4a6/0x7f0
>         [ 9252.077416][T31622]  path_openat+0x43c/0xb80
>         [ 9252.078200][T31622]  do_filp_open+0x99/0x110
>         [ 9252.078936][T31622]  ? __alloc_fd+0xf8/0x210
>         [ 9252.079557][T31622]  ? do_raw_spin_unlock+0x4d/0xc0
>         [ 9252.080274][T31622]  ? _raw_spin_unlock+0x27/0x40
>         [ 9252.080964][T31622]  do_sys_open+0x147/0x220
>         [ 9252.081815][T31622]  ? do_sys_open+0x147/0x220
>         [ 9252.082864][T31622]  ? trace_hardirqs_off_caller+0x22/0xf0
>         [ 9252.083840][T31622]  __x64_sys_openat+0x20/0x30
>         [ 9252.085299][T31622]  do_syscall_64+0x65/0x1a0
>         [ 9252.086174][T31622]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>         [ 9252.089099][T31622] RIP: 0033:0x7f839dbab6c4
>         [ 9252.090040][T31622] Code: Bad RIP value.
>         [ 9252.090823][T31622] RSP: 002b:00007f8394ff7ca0 EFLAGS: 0000029=
3 ORIG_RAX: 0000000000000101
>         [ 9252.092767][T31622] RAX: ffffffffffffffda RBX: 000000000000018=
0 RCX: 00007f839dbab6c4
>         [ 9252.094963][T31622] RDX: 00000000000e09c1 RSI: 00007f836c000f7=
0 RDI: 0000000000000003
>         [ 9252.097107][T31622] RBP: 00000000000e09c1 R08: 000000000000000=
0 R09: 00007f8394ff8060
>         [ 9252.098710][T31622] R10: 0000000000000180 R11: 000000000000029=
3 R12: 00007f8394ff7f60
>         [ 9252.101003][T31622] R13: 0000000000000003 R14: 00007f8394ff83b=
0 R15: 00007f8394ff8330
>         [ 9252.102726][T31622] kworker/u8:10   D    0  4861      2 0x8000=
0000
>         [ 9252.103924][T31622] Workqueue: btrfs-endio-write btrfs_endio_w=
rite_helper
>         [ 9252.105197][T31622] Call Trace:
>         [ 9252.105863][T31622]  __schedule+0x3d4/0xb70
>         [ 9252.107614][T31622]  schedule+0x3d/0x80
>         [ 9252.108680][T31622]  wait_current_trans+0xcf/0x110
>         [ 9252.109742][T31622]  ? wait_woken+0xa0/0xa0
>         [ 9252.110439][T31622]  start_transaction+0x307/0x4d0
>         [ 9252.111166][T31622]  btrfs_join_transaction+0x1d/0x20
>         [ 9252.112049][T31622]  btrfs_finish_ordered_io+0x493/0x7c0
>         [ 9252.112840][T31622]  finish_ordered_fn+0x15/0x20
>         [ 9252.113525][T31622]  normal_work_helper+0x92/0x540
>         [ 9252.114246][T31622]  btrfs_endio_write_helper+0x12/0x20
>         [ 9252.115298][T31622]  process_one_work+0x219/0x5b0
>         [ 9252.116206][T31622]  worker_thread+0x50/0x3b0
>         [ 9252.117327][T31622]  kthread+0x113/0x150
>         [ 9252.118964][T31622]  ? process_one_work+0x5b0/0x5b0
>         [ 9252.119873][T31622]  ? kthread_park+0x90/0x90
>         [ 9252.121320][T31622]  ret_from_fork+0x3a/0x50
>         [ 9252.122422][T31622] kworker/u8:13   D    0  4864      2 0x8000=
0000
>         [ 9252.123559][T31622] Workqueue: btrfs-endio-write btrfs_endio_w=
rite_helper
>         [ 9252.124720][T31622] Call Trace:
>         [ 9252.125313][T31622]  __schedule+0x3d4/0xb70
>         [ 9252.126074][T31622]  schedule+0x3d/0x80
>         [ 9252.127124][T31622]  wait_current_trans+0xcf/0x110
>         [ 9252.128700][T31622]  ? wait_woken+0xa0/0xa0
>         [ 9252.130263][T31622]  start_transaction+0x307/0x4d0
>         [ 9252.131214][T31622]  btrfs_join_transaction+0x1d/0x20
>         [ 9252.132088][T31622]  btrfs_finish_ordered_io+0x493/0x7c0
>         [ 9252.133039][T31622]  finish_ordered_fn+0x15/0x20
>         [ 9252.133874][T31622]  normal_work_helper+0x92/0x540
>         [ 9252.134718][T31622]  btrfs_endio_write_helper+0x12/0x20
>         [ 9252.135961][T31622]  process_one_work+0x219/0x5b0
>         [ 9252.136832][T31622]  worker_thread+0x50/0x3b0
>         [ 9252.137697][T31622]  kthread+0x113/0x150
>         [ 9252.138301][T31622]  ? process_one_work+0x5b0/0x5b0
>         [ 9252.139192][T31622]  ? kthread_park+0x90/0x90
>         [ 9252.140112][T31622]  ret_from_fork+0x3a/0x50
>         [ 9252.140972][T31622] rsync           D    0  5273   5264 0x0000=
0000
>         [ 9252.143027][T31622] Call Trace:
>         [ 9252.143958][T31622]  __schedule+0x3d4/0xb70
>         [ 9252.144690][T31622]  schedule+0x3d/0x80
>         [ 9252.145359][T31622]  btrfs_wait_for_snapshot_creation+0xb2/0xe=
0
>         [ 9252.146585][T31622]  ? wake_up_var+0x40/0x40
>         [ 9252.147642][T31622]  btrfs_setattr+0x316/0x5a0
>         [ 9252.148644][T31622]  notify_change+0x2f0/0x450
>         [ 9252.150041][T31622]  do_truncate+0x73/0xc0
>         [ 9252.150843][T31622]  do_sys_ftruncate+0x12b/0x1c0
>         [ 9252.151670][T31622]  __x64_sys_ftruncate+0x1b/0x20
>         [ 9252.152572][T31622]  do_syscall_64+0x65/0x1a0
>         [ 9252.153331][T31622]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>         [ 9252.154299][T31622] RIP: 0033:0x7f4747c07c97
>         [ 9252.155085][T31622] Code: Bad RIP value.
>         [ 9252.155710][T31622] RSP: 002b:00007ffe11b5c228 EFLAGS: 0000024=
6 ORIG_RAX: 000000000000004d
>         [ 9252.156910][T31622] RAX: ffffffffffffffda RBX: 000000000000000=
0 RCX: 00007f4747c07c97
>         [ 9252.158415][T31622] RDX: 0000000000000000 RSI: 000000000000431=
0 RDI: 0000000000000003
>         [ 9252.159914][T31622] RBP: 0000000000000003 R08: 000000000000000=
0 R09: 000000006019b829
>         [ 9252.161801][T31622] R10: 00000000f126d13b R11: 000000000000024=
6 R12: 0000000000004310
>         [ 9252.163819][T31622] R13: 00000000000041a0 R14: 000000000000017=
0 R15: 0000000000000000
>         [ 9252.166066][T31622] rsync           D    0  5536   5535 0x0000=
0000
>         [ 9252.167721][T31622] Call Trace:
>         [ 9252.168555][T31622]  __schedule+0x3d4/0xb70
>         [ 9252.169998][T31622]  schedule+0x3d/0x80
>         [ 9252.171450][T31622]  btrfs_wait_for_snapshot_creation+0xb2/0xe=
0
>         [ 9252.173042][T31622]  ? wake_up_var+0x40/0x40
>         [ 9252.174110][T31622]  btrfs_setattr+0x316/0x5a0
>         [ 9252.175217][T31622]  notify_change+0x2f0/0x450
>         [ 9252.175876][T31622]  do_truncate+0x73/0xc0
>         [ 9252.176611][T31622]  do_sys_ftruncate+0x12b/0x1c0
>         [ 9252.177623][T31622]  __x64_sys_ftruncate+0x1b/0x20
>         [ 9252.178394][T31622]  do_syscall_64+0x65/0x1a0
>         [ 9252.179117][T31622]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>         [ 9252.180031][T31622] RIP: 0033:0x7f18fd07fc97
>         [ 9252.180796][T31622] Code: Bad RIP value.
>         [ 9252.181954][T31622] RSP: 002b:00007ffe74d8fff8 EFLAGS: 0000024=
6 ORIG_RAX: 000000000000004d
>         [ 9252.184307][T31622] RAX: ffffffffffffffda RBX: 000000000000000=
0 RCX: 00007f18fd07fc97
>         [ 9252.185614][T31622] RDX: 0000000000000000 RSI: 000000000000004=
0 RDI: 0000000000000003
>         [ 9252.187156][T31622] RBP: 0000000000000003 R08: 000000000000000=
0 R09: 0000000006f20a4d
>         [ 9252.188286][T31622] R10: 00000000fec50bd5 R11: 000000000000024=
6 R12: 0000000000000040
>         [ 9252.189758][T31622] R13: 0000000000000000 R14: 000000000000004=
0 R15: 0000000000000000
>         [ 9252.191364][T31622] rsync           D    0  5657   5646 0x0000=
0000
>         [ 9252.192711][T31622] Call Trace:
>         [ 9252.193407][T31622]  __schedule+0x3d4/0xb70
>         [ 9252.194980][T31622]  schedule+0x3d/0x80
>         [ 9252.196228][T31622]  wait_current_trans+0xcf/0x110
>         [ 9252.197748][T31622]  ? wait_woken+0xa0/0xa0
>         [ 9252.199109][T31622]  start_transaction+0x307/0x4d0
>         [ 9252.199821][T31622]  btrfs_join_transaction+0x1d/0x20
>         [ 9252.200726][T31622]  btrfs_dirty_inode+0x49/0xd0
>         [ 9252.201545][T31622]  btrfs_setattr+0xab/0x5a0
>         [ 9252.202718][T31622]  notify_change+0x2f0/0x450
>         [ 9252.203728][T31622]  utimes_common+0xd1/0x1b0
>         [ 9252.204723][T31622]  ? user_path_at_empty+0x36/0x40
>         [ 9252.205881][T31622]  do_utimes+0x126/0x160
>         [ 9252.207323][T31622]  __se_sys_utimensat+0x84/0xd0
>         [ 9252.208554][T31622]  ? entry_SYSCALL_64_after_hwframe+0x49/0xb=
e
>         [ 9252.209427][T31622]  __x64_sys_utimensat+0x1e/0x20
>         [ 9252.210250][T31622]  ? __x64_sys_utimensat+0x1e/0x20
>         [ 9252.211004][T31622]  do_syscall_64+0x65/0x1a0
>         [ 9252.211642][T31622]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>         [ 9252.212481][T31622] RIP: 0033:0x7f134482f5cf
>         [ 9252.213135][T31622] Code: Bad RIP value.
>         [ 9252.214049][T31622] RSP: 002b:00007fff0f2177a8 EFLAGS: 0000020=
2 ORIG_RAX: 0000000000000118
>         [ 9252.215790][T31622] RAX: ffffffffffffffda RBX: 000055c4321eb9e=
0 RCX: 00007f134482f5cf
>         [ 9252.218157][T31622] RDX: 00007fff0f2177b0 RSI: 000055c4321eb9e=
0 RDI: 00000000ffffff9c
>         [ 9252.219486][T31622] RBP: 000000001044b93d R08: 000000000000000=
0 R09: 0000000000000001
>         [ 9252.220761][T31622] R10: 0000000000000100 R11: 000000000000020=
2 R12: 00000000000041fd
>         [ 9252.222370][T31622] R13: 00000000000001ba R14: 0000000000000dd=
0 R15: 000055c4331b8920
>         [ 9252.223673][T31622] rsync           D    0  5738   5737 0x0000=
0000
>         [ 9252.224600][T31622] Call Trace:
>         [ 9252.225202][T31622]  __schedule+0x3d4/0xb70
>         [ 9252.225899][T31622]  schedule+0x3d/0x80
>         [ 9252.226934][T31622]  btrfs_wait_for_snapshot_creation+0xb2/0xe=
0
>         [ 9252.227778][T31622]  ? wake_up_var+0x40/0x40
>         [ 9252.229043][T31622]  btrfs_setattr+0x316/0x5a0
>         [ 9252.230231][T31622]  notify_change+0x2f0/0x450
>         [ 9252.230888][T31622]  do_truncate+0x73/0xc0
>         [ 9252.231717][T31622]  do_sys_ftruncate+0x12b/0x1c0
>         [ 9252.233081][T31622]  __x64_sys_ftruncate+0x1b/0x20
>         [ 9252.233997][T31622]  do_syscall_64+0x65/0x1a0
>         [ 9252.235153][T31622]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>         [ 9252.236000][T31622] RIP: 0033:0x7f8caed39c97
>         [ 9252.236660][T31622] Code: Bad RIP value.
>         [ 9252.237255][T31622] RSP: 002b:00007ffeae338928 EFLAGS: 0000024=
6 ORIG_RAX: 000000000000004d
>         [ 9252.239037][T31622] RAX: ffffffffffffffda RBX: 000000000000000=
0 RCX: 00007f8caed39c97
>         [ 9252.241188][T31622] RDX: 0000000000000000 RSI: 000000000015275=
8 RDI: 0000000000000003
>         [ 9252.243395][T31622] RBP: 0000000000000003 R08: 000000000000000=
0 R09: 0000000020b5ba51
>         [ 9252.245377][T31622] R10: 00000000ccbe09e2 R11: 000000000000024=
6 R12: 0000000000152758
>         [ 9252.247158][T31622] R13: 0000000000152370 R14: 00000000000003e=
8 R15: 0000000000000000
>         [ 9252.249075][T31622] rsync           D    0  6041   5657 0x0000=
0000
>         [ 9252.250729][T31622] Call Trace:
>         [ 9252.251523][T31622]  __schedule+0x3d4/0xb70
>         [ 9252.252676][T31622]  schedule+0x3d/0x80
>         [ 9252.253283][T31622]  btrfs_wait_for_snapshot_creation+0xb2/0xe=
0
>         [ 9252.254194][T31622]  ? wake_up_var+0x40/0x40
>         [ 9252.254873][T31622]  btrfs_setattr+0x316/0x5a0
>         [ 9252.255618][T31622]  notify_change+0x2f0/0x450
>         [ 9252.256277][T31622]  do_truncate+0x73/0xc0
>         [ 9252.256882][T31622]  do_sys_ftruncate+0x12b/0x1c0
>         [ 9252.257800][T31622]  __x64_sys_ftruncate+0x1b/0x20
>         [ 9252.258769][T31622]  do_syscall_64+0x65/0x1a0
>         [ 9252.259675][T31622]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>         [ 9252.260510][T31622] RIP: 0033:0x7f1344832c97
>         [ 9252.261143][T31622] Code: Bad RIP value.
>         [ 9252.261710][T31622] RSP: 002b:00007fff0f215788 EFLAGS: 0000024=
6 ORIG_RAX: 000000000000004d
>         [ 9252.263489][T31622] RAX: ffffffffffffffda RBX: 000000000000000=
0 RCX: 00007f1344832c97
>         [ 9252.264891][T31622] RDX: 0000000000000000 RSI: 000000001e0357b=
8 RDI: 0000000000000003
>         [ 9252.266145][T31622] RBP: 0000000000000003 R08: 000000000000000=
0 R09: 000000006118f1f7
>         [ 9252.267829][T31622] R10: 000000004caa4fd0 R11: 000000000000024=
6 R12: 000000001e0357b8
>         [ 9252.269205][T31622] R13: 000000001e034660 R14: 000000000000115=
8 R15: 0000000000000000
>         [ 9252.270445][T31622] rsync           D    0  6056   6052 0x0000=
0000
>         [ 9252.271359][T31622] Call Trace:
>         [ 9252.271863][T31622]  __schedule+0x3d4/0xb70
>         [ 9252.272776][T31622]  schedule+0x3d/0x80
>         [ 9252.273805][T31622]  btrfs_wait_for_snapshot_creation+0xb2/0xe=
0
>         [ 9252.274671][T31622]  ? wake_up_var+0x40/0x40
>         [ 9252.275293][T31622]  btrfs_setattr+0x316/0x5a0
>         [ 9252.275950][T31622]  notify_change+0x2f0/0x450
>         [ 9252.276593][T31622]  do_truncate+0x73/0xc0
>         [ 9252.277198][T31622]  do_sys_ftruncate+0x12b/0x1c0
>         [ 9252.278130][T31622]  __x64_sys_ftruncate+0x1b/0x20
>         [ 9252.279033][T31622]  do_syscall_64+0x65/0x1a0
>         [ 9252.279919][T31622]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>         [ 9252.280985][T31622] RIP: 0033:0x7f1210e44c97
>         [ 9252.281759][T31622] Code: Bad RIP value.
>         [ 9252.282466][T31622] RSP: 002b:00007ffee2cf1388 EFLAGS: 0000024=
6 ORIG_RAX: 000000000000004d
>         [ 9252.284480][T31622] RAX: ffffffffffffffda RBX: 000000000000000=
0 RCX: 00007f1210e44c97
>         [ 9252.286229][T31622] RDX: 0000000000000000 RSI: 000000000215998=
7 RDI: 0000000000000003
>         [ 9252.287779][T31622] RBP: 0000000000000003 R08: 000000000000000=
0 R09: 00000000cab6edc0
>         [ 9252.289095][T31622] R10: 000000000f6ab90b R11: 000000000000024=
6 R12: 0000000002159987
>         [ 9252.291000][T31622] R13: 0000000002159788 R14: 00000000000001f=
f R15: 0000000000000000
>         [ 9252.292462][T31622] rsync           D    0  6057   6036 0x0000=
0000
>         [ 9252.293648][T31622] Call Trace:
>         [ 9252.294162][T31622]  __schedule+0x3d4/0xb70
>         [ 9252.295297][T31622]  schedule+0x3d/0x80
>         [ 9252.296006][T31622]  btrfs_wait_for_snapshot_creation+0xb2/0xe=
0
>         [ 9252.297222][T31622]  ? wake_up_var+0x40/0x40
>         [ 9252.297885][T31622]  btrfs_setattr+0x316/0x5a0
>         [ 9252.298598][T31622]  notify_change+0x2f0/0x450
>         [ 9252.299433][T31622]  do_truncate+0x73/0xc0
>         [ 9252.300147][T31622]  do_sys_ftruncate+0x12b/0x1c0
>         [ 9252.300923][T31622]  __x64_sys_ftruncate+0x1b/0x20
>         [ 9252.301864][T31622]  do_syscall_64+0x65/0x1a0
>         [ 9252.303550][T31622]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>         [ 9252.305122][T31622] RIP: 0033:0x7fb8ac752c97
>         [ 9252.306353][T31622] Code: Bad RIP value.
>         [ 9252.307711][T31622] RSP: 002b:00007ffd26a98a68 EFLAGS: 0000024=
6 ORIG_RAX: 000000000000004d
>         [ 9252.309634][T31622] RAX: ffffffffffffffda RBX: 000000000000000=
0 RCX: 00007fb8ac752c97
>         [ 9252.311138][T31622] RDX: 0000000000000000 RSI: 000000000003b8d=
8 RDI: 0000000000000003
>         [ 9252.312535][T31622] RBP: 0000000000000003 R08: 000000000000000=
0 R09: 00000000fae42cf6
>         [ 9252.314737][T31622] R10: 00000000c4789b67 R11: 000000000000024=
6 R12: 000000000003b8d8
>         [ 9252.316611][T31622] R13: 000000000003b790 R14: 000000000000014=
8 R15: 0000000000000000
>         [ 9252.320560][T31622] rsync           D    0  6098   5713 0x0000=
0000
>         [ 9252.322299][T31622] Call Trace:
>         [ 9252.322989][T31622]  __schedule+0x3d4/0xb70
>         [ 9252.324098][T31622]  schedule+0x3d/0x80
>         [ 9252.325722][T31622]  btrfs_wait_for_snapshot_creation+0xb2/0xe=
0
>         [ 9252.327835][T31622]  ? wake_up_var+0x40/0x40
>         [ 9252.328908][T31622]  btrfs_setattr+0x316/0x5a0
>         [ 9252.329944][T31622]  notify_change+0x2f0/0x450
>         [ 9252.331741][T31622]  do_truncate+0x73/0xc0
>         [ 9252.334177][T31622]  do_sys_ftruncate+0x12b/0x1c0
>         [ 9252.335989][T31622]  __x64_sys_ftruncate+0x1b/0x20
>         [ 9252.337216][T31622]  do_syscall_64+0x65/0x1a0
>         [ 9252.338116][T31622]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>         [ 9252.339213][T31622] RIP: 0033:0x7febc735bc97
>         [ 9252.341655][T31622] Code: Bad RIP value.
>         [ 9252.345081][T31622] RSP: 002b:00007ffcf612ff38 EFLAGS: 0000024=
6 ORIG_RAX: 000000000000004d
>         [ 9252.349045][T31622] RAX: ffffffffffffffda RBX: 000000000000000=
0 RCX: 00007febc735bc97
>         [ 9252.350665][T31622] RDX: 0000000000000000 RSI: 000000000001552=
d RDI: 0000000000000003
>         [ 9252.353091][T31622] RBP: 0000000000000003 R08: 000000000000000=
0 R09: 0000000012a668b5
>         [ 9252.355035][T31622] R10: 00000000de52d2d3 R11: 000000000000024=
6 R12: 000000000001552d
>         [ 9252.356175][T31622] R13: 0000000000015310 R14: 000000000000021=
d R15: 0000000000000000
>         [ 9252.357365][T31622] rsync           D    0  6776   6775 0x0000=
0000
>         [ 9252.358629][T31622] Call Trace:
>         [ 9252.359122][T31622]  __schedule+0x3d4/0xb70
>         [ 9252.361402][T31622]  schedule+0x3d/0x80
>         [ 9252.363523][T31622]  btrfs_wait_for_snapshot_creation+0xb2/0xe=
0
>         [ 9252.365202][T31622]  ? wake_up_var+0x40/0x40
>         [ 9252.366599][T31622]  btrfs_setattr+0x316/0x5a0
>         [ 9252.367290][T31622]  notify_change+0x2f0/0x450
>         [ 9252.368030][T31622]  do_truncate+0x73/0xc0
>         [ 9252.368721][T31622]  do_sys_ftruncate+0x12b/0x1c0
>         [ 9252.369720][T31622]  __x64_sys_ftruncate+0x1b/0x20
>         [ 9252.370526][T31622]  do_syscall_64+0x65/0x1a0
>         [ 9252.371592][T31622]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>         [ 9252.372583][T31622] RIP: 0033:0x7f655f77cc97
>         [ 9252.374104][T31622] Code: Bad RIP value.
>         [ 9252.375233][T31622] RSP: 002b:00007ffed35c0ee8 EFLAGS: 0000024=
6 ORIG_RAX: 000000000000004d
>         [ 9252.377674][T31622] RAX: ffffffffffffffda RBX: 000000000000000=
0 RCX: 00007f655f77cc97
>         [ 9252.379391][T31622] RDX: 0000000000000000 RSI: 0000000000665c9=
4 RDI: 0000000000000001
>         [ 9252.380617][T31622] RBP: 0000000000000001 R08: 000000000000000=
0 R09: 00000000d25d9afd
>         [ 9252.381751][T31622] R10: 0000000000000000 R11: 000000000000024=
6 R12: 0000000000665c94
>         [ 9252.383402][T31622] R13: 0000000000003e73 R14: 000000000000000=
0 R15: 0000000000000000
>         [ 9252.384567][T31622] rsync           D    0  6984   6983 0x0000=
0000
>         [ 9252.385504][T31622] Call Trace:
>         [ 9252.386010][T31622]  __schedule+0x3d4/0xb70
>         [ 9252.386750][T31622]  schedule+0x3d/0x80
>         [ 9252.387874][T31622]  btrfs_wait_for_snapshot_creation+0xb2/0xe=
0
>         [ 9252.389374][T31622]  ? wake_up_var+0x40/0x40
>         [ 9252.390200][T31622]  btrfs_setattr+0x316/0x5a0
>         [ 9252.390922][T31622]  notify_change+0x2f0/0x450
>         [ 9252.391637][T31622]  do_truncate+0x73/0xc0
>         [ 9252.392311][T31622]  do_sys_ftruncate+0x12b/0x1c0
>         [ 9252.393125][T31622]  __x64_sys_ftruncate+0x1b/0x20
>         [ 9252.393954][T31622]  do_syscall_64+0x65/0x1a0
>         [ 9252.394676][T31622]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>         [ 9252.395943][T31622] RIP: 0033:0x7f78ed2efc97
>         [ 9252.396902][T31622] Code: Bad RIP value.
>         [ 9252.397765][T31622] RSP: 002b:00007ffdd821d338 EFLAGS: 0000024=
6 ORIG_RAX: 000000000000004d
>         [ 9252.399339][T31622] RAX: ffffffffffffffda RBX: 000000000000000=
0 RCX: 00007f78ed2efc97
>         [ 9252.401105][T31622] RDX: 0000000000000000 RSI: 000000000000053=
c RDI: 0000000000000003
>         [ 9252.402560][T31622] RBP: 0000000000000003 R08: 000000000000000=
0 R09: 00000000e7379d85
>         [ 9252.404327][T31622] R10: 0000000051ef429d R11: 000000000000024=
6 R12: 000000000000053c
>         [ 9252.406268][T31622] R13: 00000000000002bc R14: 000000000000028=
0 R15: 0000000000000000
>         [ 9252.408686][T31622] rsync           D    0  7101   7069 0x0000=
0000
>         [ 9252.411754][T31622] Call Trace:
>         [ 9252.412261][T31622]  __schedule+0x3d4/0xb70
>         [ 9252.412884][T31622]  schedule+0x3d/0x80
>         [ 9252.413457][T31622]  btrfs_wait_for_snapshot_creation+0xb2/0xe=
0
>         [ 9252.414338][T31622]  ? wake_up_var+0x40/0x40
>         [ 9252.414978][T31622]  btrfs_setattr+0x316/0x5a0
>         [ 9252.415625][T31622]  notify_change+0x2f0/0x450
>         [ 9252.416284][T31622]  do_truncate+0x73/0xc0
>         [ 9252.416949][T31622]  do_sys_ftruncate+0x12b/0x1c0
>         [ 9252.417897][T31622]  __x64_sys_ftruncate+0x1b/0x20
>         [ 9252.418663][T31622]  do_syscall_64+0x65/0x1a0
>         [ 9252.419510][T31622]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>         [ 9252.420331][T31622] RIP: 0033:0x7f7932bc5c97
>         [ 9252.421284][T31622] Code: Bad RIP value.
>         [ 9252.422844][T31622] RSP: 002b:00007ffe0a539f98 EFLAGS: 0000024=
6 ORIG_RAX: 000000000000004d
>         [ 9252.425023][T31622] RAX: ffffffffffffffda RBX: 000000000000000=
0 RCX: 00007f7932bc5c97
>         [ 9252.426558][T31622] RDX: 0000000000000000 RSI: 000000000001552=
d RDI: 0000000000000003
>         [ 9252.427700][T31622] RBP: 0000000000000003 R08: 000000000000000=
0 R09: 0000000012a668b5
>         [ 9252.430284][T31622] R10: 00000000de52d2d3 R11: 000000000000024=
6 R12: 000000000001552d
>         [ 9252.432318][T31622] R13: 0000000000015310 R14: 000000000000021=
d R15: 0000000000000000
>         [ 9252.434347][T31622] rsync           D    0  7488   7487 0x0000=
0000
>         [ 9252.435713][T31622] Call Trace:
>         [ 9252.436297][T31622]  __schedule+0x3d4/0xb70
>         [ 9252.437079][T31622]  schedule+0x3d/0x80
>         [ 9252.437699][T31622]  btrfs_wait_for_snapshot_creation+0xb2/0xe=
0
>         [ 9252.439153][T31622]  ? wake_up_var+0x40/0x40
>         [ 9252.439765][T31622]  btrfs_setattr+0x316/0x5a0
>         [ 9252.440596][T31622]  notify_change+0x2f0/0x450
>         [ 9252.441431][T31622]  do_truncate+0x73/0xc0
>         [ 9252.443237][T31622]  do_sys_ftruncate+0x12b/0x1c0
>         [ 9252.444209][T31622]  __x64_sys_ftruncate+0x1b/0x20
>         [ 9252.445969][T31622]  do_syscall_64+0x65/0x1a0
>         [ 9252.447892][T31622]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>         [ 9252.448988][T31622] RIP: 0033:0x7fcbefae0c97
>         [ 9252.449926][T31622] Code: Bad RIP value.
>         [ 9252.450658][T31622] RSP: 002b:00007fff46667858 EFLAGS: 0000024=
6 ORIG_RAX: 000000000000004d
>         [ 9252.452226][T31622] RAX: ffffffffffffffda RBX: 000000000000000=
0 RCX: 00007fcbefae0c97
>         [ 9252.454438][T31622] RDX: 0000000000000000 RSI: 000000000215998=
7 RDI: 0000000000000003
>         [ 9252.456297][T31622] RBP: 0000000000000003 R08: 000000000000000=
0 R09: 00000000cab6edc0
>         [ 9252.457896][T31622] R10: 000000000f6ab90b R11: 000000000000024=
6 R12: 0000000002159987
>         [ 9252.459583][T31622] R13: 0000000002159788 R14: 00000000000001f=
f R15: 0000000000000000
>         [ 9252.461542][T31622] rsync           D    0 24380  24315 0x0000=
0000
>         [ 9252.463391][T31622] Call Trace:
>         [ 9252.464530][T31622]  __schedule+0x3d4/0xb70
>         [ 9252.465163][T31622]  schedule+0x3d/0x80
>         [ 9252.465764][T31622]  btrfs_wait_for_snapshot_creation+0xb2/0xe=
0
>         [ 9252.467107][T31622]  ? wake_up_var+0x40/0x40
>         [ 9252.467967][T31622]  btrfs_setattr+0x316/0x5a0
>         [ 9252.468631][T31622]  notify_change+0x2f0/0x450
>         [ 9252.469322][T31622]  do_truncate+0x73/0xc0
>         [ 9252.469991][T31622]  do_sys_ftruncate+0x12b/0x1c0
>         [ 9252.470646][T31622]  __x64_sys_ftruncate+0x1b/0x20
>         [ 9252.471354][T31622]  do_syscall_64+0x65/0x1a0
>         [ 9252.472045][T31622]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>         [ 9252.472953][T31622] RIP: 0033:0x7f28ec348c97
>         [ 9252.473913][T31622] Code: Bad RIP value.
>         [ 9252.475006][T31622] RSP: 002b:00007ffe93c62658 EFLAGS: 0000024=
6 ORIG_RAX: 000000000000004d
>         [ 9252.476355][T31622] RAX: ffffffffffffffda RBX: 000000000000000=
0 RCX: 00007f28ec348c97
>         [ 9252.477678][T31622] RDX: 0000000000000000 RSI: 000000000310fc8=
b RDI: 0000000000000003
>         [ 9252.478822][T31622] RBP: 0000000000000003 R08: 000000000000000=
0 R09: 00000000502ba51c
>         [ 9252.480199][T31622] R10: 0000000093a39e92 R11: 000000000000024=
6 R12: 000000000310fc8b
>         [ 9252.481893][T31622] R13: 000000000310fc00 R14: 000000000000008=
b R15: 0000000000000000
>         [ 9252.484213][T31622] rsync           D    0 27243  27242 0x0000=
0000
>         [ 9252.485369][T31622] Call Trace:
>         [ 9252.485959][T31622]  __schedule+0x3d4/0xb70
>         [ 9252.486660][T31622]  schedule+0x3d/0x80
>         [ 9252.487331][T31622]  btrfs_wait_for_snapshot_creation+0xb2/0xe=
0
>         [ 9252.488400][T31622]  ? wake_up_var+0x40/0x40
>         [ 9252.489168][T31622]  btrfs_setattr+0x316/0x5a0
>         [ 9252.490430][T31622]  notify_change+0x2f0/0x450
>         [ 9252.491868][T31622]  do_truncate+0x73/0xc0
>         [ 9252.492612][T31622]  do_sys_ftruncate+0x12b/0x1c0
>         [ 9252.493305][T31622]  __x64_sys_ftruncate+0x1b/0x20
>         [ 9252.494093][T31622]  do_syscall_64+0x65/0x1a0
>         [ 9252.494818][T31622]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>         [ 9252.495638][T31622] RIP: 0033:0x7f5a75c6ac97
>         [ 9252.496270][T31622] Code: Bad RIP value.
>         [ 9252.496881][T31622] RSP: 002b:00007fff87966968 EFLAGS: 0000024=
6 ORIG_RAX: 000000000000004d
>         [ 9252.498321][T31622] RAX: ffffffffffffffda RBX: 000000000000000=
0 RCX: 00007f5a75c6ac97
>         [ 9252.499686][T31622] RDX: 0000000000000000 RSI: 000000000310fc8=
b RDI: 0000000000000003
>         [ 9252.501139][T31622] RBP: 0000000000000003 R08: 000000000000000=
0 R09: 00000000502ba51c
>         [ 9252.502778][T31622] R10: 0000000093a39e92 R11: 000000000000024=
6 R12: 000000000310fc8b
>         [ 9252.504313][T31622] R13: 000000000310fc00 R14: 000000000000008=
b R15: 0000000000000000
>         [ 9252.505483][T31622] rsync           D    0 29249  29206 0x0000=
0000
>         [ 9252.506712][T31622] Call Trace:
>         [ 9252.507203][T31622]  __schedule+0x3d4/0xb70
>         [ 9252.507820][T31622]  schedule+0x3d/0x80
>         [ 9252.508384][T31622]  btrfs_wait_for_snapshot_creation+0xb2/0xe=
0
>         [ 9252.509249][T31622]  ? wake_up_var+0x40/0x40
>         [ 9252.509889][T31622]  btrfs_setattr+0x316/0x5a0
>         [ 9252.511213][T31622]  notify_change+0x2f0/0x450
>         [ 9252.511921][T31622]  do_truncate+0x73/0xc0
>         [ 9252.512529][T31622]  do_sys_ftruncate+0x12b/0x1c0
>         [ 9252.513513][T31622]  __x64_sys_ftruncate+0x1b/0x20
>         [ 9252.514255][T31622]  do_syscall_64+0x65/0x1a0
>         [ 9252.514973][T31622]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>         [ 9252.515847][T31622] RIP: 0033:0x7fed84d83c97
>         [ 9252.516506][T31622] Code: Bad RIP value.
>         [ 9252.517090][T31622] RSP: 002b:00007ffcc53a2298 EFLAGS: 0000024=
6 ORIG_RAX: 000000000000004d
>         [ 9252.519706][T31622] RAX: ffffffffffffffda RBX: 000000000000000=
0 RCX: 00007fed84d83c97
>         [ 9252.521744][T31622] RDX: 0000000000000000 RSI: 000000000000596=
8 RDI: 0000000000000003
>         [ 9252.523149][T31622] RBP: 0000000000000003 R08: 000000000000000=
0 R09: 000000003d380066
>         [ 9252.524286][T31622] R10: 000000003e4b7b14 R11: 000000000000024=
6 R12: 0000000000005968
>         [ 9252.525833][T31622] R13: 0000000000005780 R14: 00000000000001e=
8 R15: 0000000000000000
>         [ 9252.527207][T31622] kworker/u8:6    D    0 32394      2 0x8000=
0000
>         [ 9252.528109][T31622] Workqueue: btrfs-endio-write btrfs_endio_w=
rite_helper
>         [ 9252.529162][T31622] Call Trace:
>         [ 9252.529620][T31622]  __schedule+0x3d4/0xb70
>         [ 9252.530238][T31622]  schedule+0x3d/0x80
>         [ 9252.531049][T31622]  wait_current_trans+0xcf/0x110
>         [ 9252.532542][T31622]  ? wait_woken+0xa0/0xa0
>         [ 9252.533290][T31622]  start_transaction+0x307/0x4d0
>         [ 9252.534303][T31622]  btrfs_join_transaction+0x1d/0x20
>         [ 9252.535468][T31622]  btrfs_finish_ordered_io+0x493/0x7c0
>         [ 9252.536355][T31622]  finish_ordered_fn+0x15/0x20
>         [ 9252.537128][T31622]  normal_work_helper+0x92/0x540
>         [ 9252.537923][T31622]  btrfs_endio_write_helper+0x12/0x20
>         [ 9252.539083][T31622]  process_one_work+0x219/0x5b0
>         [ 9252.540688][T31622]  worker_thread+0x50/0x3b0
>         [ 9252.541764][T31622]  ? __kthread_parkme+0x61/0x90
>         [ 9252.542690][T31622]  kthread+0x113/0x150
>         [ 9252.543339][T31622]  ? process_one_work+0x5b0/0x5b0
>         [ 9252.544313][T31622]  ? kthread_park+0x90/0x90
>         [ 9252.544974][T31622]  ret_from_fork+0x3a/0x50
>         [ 9252.545832][T31622] btrfs           D    0  5374   4732 0x0000=
0000
>         [ 9252.546726][T31622] Call Trace:
>         [ 9252.547422][T31622]  __schedule+0x3d4/0xb70
>         [ 9252.548317][T31622]  schedule+0x3d/0x80
>         [ 9252.549039][T31622]  wait_for_commit+0x59/0xa0
>         [ 9252.549990][T31622]  ? wait_woken+0xa0/0xa0
>         [ 9252.550896][T31622]  btrfs_commit_transaction+0x10e/0xab0
>         [ 9252.552582][T31622]  ? start_transaction+0x93/0x4d0
>         [ 9252.553594][T31622]  relocate_block_group+0x1e6/0x620
>         [ 9252.554631][T31622]  btrfs_relocate_block_group+0x15a/0x270
>         [ 9252.555857][T31622]  btrfs_relocate_chunk+0x50/0x100
>         [ 9252.557019][T31622]  btrfs_balance+0xa76/0x1330
>         [ 9252.558018][T31622]  ? fs_reclaim_acquire.part.23+0x5/0x30
>         [ 9252.559194][T31622]  btrfs_ioctl_balance+0x19f/0x310
>         [ 9252.560392][T31622]  btrfs_ioctl+0x15b9/0x2cf0
>         [ 9252.561840][T31622]  ? __handle_mm_fault+0x10d7/0x18f0
>         [ 9252.563285][T31622]  ? do_raw_spin_unlock+0x4d/0xc0
>         [ 9252.564568][T31622]  ? _raw_spin_unlock+0x27/0x40
>         [ 9252.565417][T31622]  ? __handle_mm_fault+0x10d7/0x18f0
>         [ 9252.566161][T31622]  do_vfs_ioctl+0xa6/0x6e0
>         [ 9252.566773][T31622]  ? btrfs_ioctl_get_supported_features+0x30=
/0x30
>         [ 9252.567957][T31622]  ? do_vfs_ioctl+0xa6/0x6e0
>         [ 9252.569532][T31622]  ? up_read+0x1f/0xa0
>         [ 9252.570449][T31622]  ksys_ioctl+0x75/0x80
>         [ 9252.571248][T31622]  __x64_sys_ioctl+0x1a/0x20
>         [ 9252.571907][T31622]  do_syscall_64+0x65/0x1a0
>         [ 9252.572551][T31622]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>         [ 9252.573371][T31622] RIP: 0033:0x7f1adf7b7777
>         [ 9252.574000][T31622] Code: Bad RIP value.
>         [ 9252.574582][T31622] RSP: 002b:00007fff0b20c208 EFLAGS: 0000020=
2 ORIG_RAX: 0000000000000010
>         [ 9252.575774][T31622] RAX: ffffffffffffffda RBX: 000000000000000=
1 RCX: 00007f1adf7b7777
>         [ 9252.576889][T31622] RDX: 00007fff0b20c298 RSI: 00000000c400942=
0 RDI: 0000000000000003
>         [ 9252.579571][T31622] RBP: 00007fff0b20c298 R08: 000000000000000=
3 R09: 0000000000000078
>         [ 9252.581214][T31622] R10: fffffffffffffa4a R11: 000000000000020=
2 R12: 0000000000000003
>         [ 9252.582703][T31622] R13: 00007fff0b20da3e R14: 000000000000000=
1 R15: 0000000000000000
>         [ 9252.584082][T31622] rsync           D    0  9889  32454 0x0000=
0000
>         [ 9252.585219][T31622] Call Trace:
>         [ 9252.585678][T31622]  __schedule+0x3d4/0xb70
>         [ 9252.586522][T31622]  schedule+0x3d/0x80
>         [ 9252.587201][T31622]  btrfs_start_ordered_extent+0x115/0x1c0
>         [ 9252.588174][T31622]  ? wait_woken+0xa0/0xa0
>         [ 9252.588779][T31622]  lock_and_cleanup_extent_if_need+0x1e6/0x2=
50
>         [ 9252.589645][T31622]  btrfs_buffered_write.isra.4+0x21d/0x800
>         [ 9252.590471][T31622]  ? ktime_get_coarse_real_ts64+0xbd/0xe0
>         [ 9252.591282][T31622]  btrfs_file_write_iter+0x224/0x5c3
>         [ 9252.592029][T31622]  new_sync_write+0x113/0x180
>         [ 9252.592676][T31622]  __vfs_write+0x29/0x40
>         [ 9252.593304][T31622]  vfs_write+0xcb/0x1d0
>         [ 9252.594092][T31622]  ksys_write+0x5f/0xf0
>         [ 9252.594776][T31622]  ? entry_SYSCALL_64_after_hwframe+0x49/0xb=
e
>         [ 9252.596007][T31622]  __x64_sys_write+0x1a/0x20
>         [ 9252.596871][T31622]  do_syscall_64+0x65/0x1a0
>         [ 9252.597507][T31622]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>         [ 9252.598336][T31622] RIP: 0033:0x7fa67fb40804
>         [ 9252.598966][T31622] Code: Bad RIP value.
>         [ 9252.599528][T31622] RSP: 002b:00007ffddaa933d8 EFLAGS: 0000024=
6 ORIG_RAX: 0000000000000001
>         [ 9252.600704][T31622] RAX: ffffffffffffffda RBX: 000055aec3a31aa=
0 RCX: 00007fa67fb40804
>         [ 9252.601834][T31622] RDX: 0000000000000400 RSI: 000055aec3a31aa=
0 RDI: 0000000000000001
>         [ 9252.602958][T31622] RBP: 0000000000000000 R08: 0000000041070b7=
3 R09: 00000000a3bf2e0f
>         [ 9252.604081][T31622] R10: 00000000fc115b71 R11: 000000000000024=
6 R12: 0000000000000400
>         [ 9252.605219][T31622] R13: 0000000000000000 R14: 000000000000000=
0 R15: 0000000000004804
>         [ 9252.606869][T31622] rsync           D    0  9896  32668 0x0000=
0000
>         [ 9252.608227][T31622] Call Trace:
>         [ 9252.608690][T31622]  __schedule+0x3d4/0xb70
>         [ 9252.609305][T31622]  schedule+0x3d/0x80
>         [ 9252.609874][T31622]  btrfs_start_ordered_extent+0x115/0x1c0
>         [ 9252.610670][T31622]  ? wait_woken+0xa0/0xa0
>         [ 9252.611285][T31622]  lock_and_cleanup_extent_if_need+0x1e6/0x2=
50
>         [ 9252.612154][T31622]  btrfs_buffered_write.isra.4+0x21d/0x800
>         [ 9252.612976][T31622]  ? ktime_get_coarse_real_ts64+0xbd/0xe0
>         [ 9252.613770][T31622]  btrfs_file_write_iter+0x224/0x5c3
>         [ 9252.614513][T31622]  ? pipe_read+0x2d7/0x320
>         [ 9252.615200][T31622]  new_sync_write+0x113/0x180
>         [ 9252.616086][T31622]  __vfs_write+0x29/0x40
>         [ 9252.616805][T31622]  vfs_write+0xcb/0x1d0
>         [ 9252.617690][T31622]  ksys_write+0x5f/0xf0
>         [ 9252.618305][T31622]  ? entry_SYSCALL_64_after_hwframe+0x49/0xb=
e
>         [ 9252.619572][T31622]  __x64_sys_write+0x1a/0x20
>         [ 9252.620416][T31622]  do_syscall_64+0x65/0x1a0
>         [ 9252.621070][T31622]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>         [ 9252.621906][T31622] RIP: 0033:0x7fe52293e804
>         [ 9252.622544][T31622] Code: Bad RIP value.
>         [ 9252.623161][T31622] RSP: 002b:00007ffdb710d208 EFLAGS: 0000024=
6 ORIG_RAX: 0000000000000001
>         [ 9252.626275][T31622] RAX: ffffffffffffffda RBX: 0000562cd8c1aaa=
0 RCX: 00007fe52293e804
>         [ 9252.631065][T31622] RDX: 0000000000000400 RSI: 0000562cd8c1aaa=
0 RDI: 0000000000000001
>         [ 9252.633021][T31622] RBP: 0000000000000000 R08: 0000000077107f3=
d R09: 000000009629dc29
>         [ 9252.634152][T31622] R10: 00000000f3a0d5e5 R11: 000000000000024=
6 R12: 0000000000000400
>         [ 9252.635336][T31622] R13: 0000000000000000 R14: 000000000000000=
0 R15: 000000000000494b
>         [ 9252.637023][T31622] kworker/u8:22   D    0 19751      2 0x8000=
0000
>         [ 9252.638388][T31622] Workqueue: btrfs-endio-write btrfs_endio_w=
rite_helper
>         [ 9252.639380][T31622] Call Trace:
>         [ 9252.639851][T31622]  __schedule+0x3d4/0xb70
>         [ 9252.641138][T31622]  schedule+0x3d/0x80
>         [ 9252.641687][T31622]  wait_current_trans+0xcf/0x110
>         [ 9252.642879][T31622]  ? wait_woken+0xa0/0xa0
>         [ 9252.643507][T31622]  start_transaction+0x307/0x4d0
>         [ 9252.645971][T31622]  btrfs_join_transaction+0x1d/0x20
>         [ 9252.647153][T31622]  btrfs_finish_ordered_io+0x493/0x7c0
>         [ 9252.648142][T31622]  finish_ordered_fn+0x15/0x20
>         [ 9252.648815][T31622]  normal_work_helper+0x92/0x540
>         [ 9252.649540][T31622]  btrfs_endio_write_helper+0x12/0x20
>         [ 9252.650366][T31622]  process_one_work+0x219/0x5b0
>         [ 9252.651056][T31622]  worker_thread+0x50/0x3b0
>         [ 9252.651681][T31622]  kthread+0x113/0x150
>         [ 9252.652394][T31622]  ? process_one_work+0x5b0/0x5b0
>         [ 9252.653432][T31622]  ? kthread_park+0x90/0x90
>         [ 9252.654385][T31622]  ret_from_fork+0x3a/0x50
>         [ 9252.655278][T31622] kworker/u8:24   D    0 23273      2 0x8000=
0000
>         [ 9252.656480][T31622] Workqueue: btrfs-endio-write btrfs_endio_w=
rite_helper
>         [ 9252.657504][T31622] Call Trace:
>         [ 9252.658027][T31622]  __schedule+0x3d4/0xb70
>         [ 9252.658672][T31622]  schedule+0x3d/0x80
>         [ 9252.659248][T31622]  wait_current_trans+0xcf/0x110
>         [ 9252.660050][T31622]  ? wait_woken+0xa0/0xa0
>         [ 9252.660733][T31622]  start_transaction+0x307/0x4d0
>         [ 9252.661437][T31622]  btrfs_join_transaction+0x1d/0x20
>         [ 9252.662215][T31622]  btrfs_finish_ordered_io+0x493/0x7c0
>         [ 9252.663271][T31622]  ? trace_hardirqs_off+0x22/0x100
>         [ 9252.664692][T31622]  finish_ordered_fn+0x15/0x20
>         [ 9252.666198][T31622]  normal_work_helper+0x92/0x540
>         [ 9252.666894][T31622]  btrfs_endio_write_helper+0x12/0x20
>         [ 9252.667661][T31622]  process_one_work+0x219/0x5b0
>         [ 9252.668460][T31622]  worker_thread+0x50/0x3b0
>         [ 9252.669122][T31622]  ? __kthread_parkme+0x61/0x90
>         [ 9252.669919][T31622]  kthread+0x113/0x150
>         [ 9252.670951][T31622]  ? process_one_work+0x5b0/0x5b0
>         [ 9252.671771][T31622]  ? kthread_park+0x90/0x90
>         [ 9252.672612][T31622]  ret_from_fork+0x3a/0x50
>         [ 9252.673597][T31622] rsync           D    0 32700  32584 0x0000=
0000
>         [ 9252.674731][T31622] Call Trace:
>         [ 9252.675215][T31622]  __schedule+0x3d4/0xb70
>         [ 9252.675833][T31622]  schedule+0x3d/0x80
>         [ 9252.676419][T31622]  btrfs_wait_for_snapshot_creation+0xb2/0xe=
0
>         [ 9252.677604][T31622]  ? wake_up_var+0x40/0x40
>         [ 9252.678437][T31622]  btrfs_setattr+0x316/0x5a0
>         [ 9252.679102][T31622]  notify_change+0x2f0/0x450
>         [ 9252.679751][T31622]  do_truncate+0x73/0xc0
>         [ 9252.680364][T31622]  do_sys_ftruncate+0x12b/0x1c0
>         [ 9252.681062][T31622]  __x64_sys_ftruncate+0x1b/0x20
>         [ 9252.681758][T31622]  do_syscall_64+0x65/0x1a0
>         [ 9252.682403][T31622]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>         [ 9252.683249][T31622] RIP: 0033:0x7fb9aeac3c97
>         [ 9252.684114][T31622] Code: Bad RIP value.
>         [ 9252.684866][T31622] RSP: 002b:00007ffc119166a8 EFLAGS: 0000024=
6 ORIG_RAX: 000000000000004d
>         [ 9252.686296][T31622] RAX: ffffffffffffffda RBX: 000000000000000=
0 RCX: 00007fb9aeac3c97
>         [ 9252.687437][T31622] RDX: 0000000000000000 RSI: 0000000000665c9=
4 RDI: 0000000000000001
>         [ 9252.688585][T31622] RBP: 0000000000000001 R08: 000000000000000=
0 R09: 00000000d25d9afd
>         [ 9252.690550][T31622] R10: 0000000000000000 R11: 000000000000024=
6 R12: 0000000000665c94
>         [ 9252.691703][T31622] R13: 0000000000003e73 R14: 000000000000000=
0 R15: 0000000000000000
>         [ 9252.693296][T31622] kworker/u8:2    D    0 27596      2 0x8000=
0000
>         [ 9252.694284][T31622] Workqueue: btrfs-endio-write btrfs_endio_w=
rite_helper
>         [ 9252.695456][T31622] Call Trace:
>         [ 9252.695940][T31622]  __schedule+0x3d4/0xb70
>         [ 9252.696803][T31622]  schedule+0x3d/0x80
>         [ 9252.697369][T31622]  wait_current_trans+0xcf/0x110
>         [ 9252.698383][T31622]  ? wait_woken+0xa0/0xa0
>         [ 9252.699578][T31622]  start_transaction+0x307/0x4d0
>         [ 9252.700881][T31622]  btrfs_join_transaction+0x1d/0x20
>         [ 9252.701828][T31622]  btrfs_finish_ordered_io+0x493/0x7c0
>         [ 9252.702761][T31622]  ? check_preempt_curr+0x89/0xb0
>         [ 9252.703490][T31622]  ? trace_hardirqs_off+0x22/0x100
>         [ 9252.704229][T31622]  finish_ordered_fn+0x15/0x20
>         [ 9252.704981][T31622]  normal_work_helper+0x92/0x540
>         [ 9252.705717][T31622]  btrfs_endio_write_helper+0x12/0x20
>         [ 9252.706592][T31622]  process_one_work+0x219/0x5b0
>         [ 9252.707295][T31622]  worker_thread+0x50/0x3b0
>         [ 9252.707944][T31622]  ? __kthread_parkme+0x61/0x90
>         [ 9252.709211][T31622]  kthread+0x113/0x150
>         [ 9252.710350][T31622]  ? process_one_work+0x5b0/0x5b0
>         [ 9252.711536][T31622]  ? kthread_park+0x90/0x90
>         [ 9252.712272][T31622]  ret_from_fork+0x3a/0x50
>         [ 9252.712989][T31622] btrfs           D    0 18515   6402 0x0000=
0000
>         [ 9252.714466][T31622] Call Trace:
>         [ 9252.715433][T31622]  __schedule+0x3d4/0xb70
>         [ 9252.716305][T31622]  schedule+0x3d/0x80
>         [ 9252.717074][T31622]  wait_for_commit+0x59/0xa0
>         [ 9252.717764][T31622]  ? wait_woken+0xa0/0xa0
>         [ 9252.718548][T31622]  btrfs_commit_transaction+0x10e/0xab0
>         [ 9252.719509][T31622]  ? btrfs_mksubvol+0x497/0x630
>         [ 9252.720325][T31622]  ? btrfs_mksubvol+0x524/0x630
>         [ 9252.721426][T31622]  btrfs_mksubvol+0x5b1/0x630
>         [ 9252.722762][T31622]  ? mnt_want_write_file+0x28/0x60
>         [ 9252.724341][T31622]  btrfs_ioctl_snap_create_transid+0x16b/0x1=
a0
>         [ 9252.725818][T31622]  btrfs_ioctl_snap_create_v2+0x125/0x180
>         [ 9252.726779][T31622]  btrfs_ioctl+0x1753/0x2cf0
>         [ 9252.727628][T31622]  ? __handle_mm_fault+0xdb3/0x18f0
>         [ 9252.728753][T31622]  ? do_raw_spin_unlock+0x4d/0xc0
>         [ 9252.730215][T31622]  ? _raw_spin_unlock+0x27/0x40
>         [ 9252.731791][T31622]  ? __handle_mm_fault+0xdb3/0x18f0
>         [ 9252.733716][T31622]  do_vfs_ioctl+0xa6/0x6e0
>         [ 9252.734540][T31622]  ? btrfs_ioctl_get_supported_features+0x30=
/0x30
>         [ 9252.735553][T31622]  ? do_vfs_ioctl+0xa6/0x6e0
>         [ 9252.736471][T31622]  ? up_read+0x1f/0xa0
>         [ 9252.737482][T31622]  ksys_ioctl+0x75/0x80
>         [ 9252.738155][T31622]  __x64_sys_ioctl+0x1a/0x20
>         [ 9252.738879][T31622]  do_syscall_64+0x65/0x1a0
>         [ 9252.739566][T31622]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>         [ 9252.740616][T31622] RIP: 0033:0x7f4ae0ccf777
>         [ 9252.742024][T31622] Code: Bad RIP value.
>         [ 9252.742948][T31622] RSP: 002b:00007ffc3acf3de8 EFLAGS: 0000020=
6 ORIG_RAX: 0000000000000010
>         [ 9252.745840][T31622] RAX: ffffffffffffffda RBX: 000000000000000=
0 RCX: 00007f4ae0ccf777
>         [ 9252.748076][T31622] RDX: 00007ffc3acf3e28 RSI: 000000005000941=
7 RDI: 0000000000000003
>         [ 9252.749789][T31622] RBP: 0000558e833b2260 R08: 000000000000000=
8 R09: 00007f4ae0d59e80
>         [ 9252.750918][T31622] R10: fffffffffffffa4a R11: 000000000000020=
6 R12: 0000558e833b2290
>         [ 9252.753406][T31622] R13: 0000558e833b2290 R14: 000000000000000=
3 R15: 0000000000000004
>         [ 9252.755640][T31622] rmdir           D    0 23372   3771 0x0000=
0000
>         [ 9252.756792][T31622] Call Trace:
>         [ 9252.757267][T31622]  __schedule+0x3d4/0xb70
>         [ 9252.757969][T31622]  schedule+0x3d/0x80
>         [ 9252.758571][T31622]  wait_current_trans+0xcf/0x110
>         [ 9252.759295][T31622]  ? wait_woken+0xa0/0xa0
>         [ 9252.759910][T31622]  start_transaction+0x156/0x4d0
>         [ 9252.760690][T31622]  btrfs_start_transaction_fallback_global_r=
sv+0x37/0x1b0
>         [ 9252.761741][T31622]  btrfs_rmdir+0x6a/0x1b0
>         [ 9252.762411][T31622]  vfs_rmdir+0xba/0x140
>         [ 9252.763345][T31622]  do_rmdir+0x21e/0x230
>         [ 9252.764091][T31622]  __x64_sys_rmdir+0x17/0x20
>         [ 9252.764733][T31622]  do_syscall_64+0x65/0x1a0
>         [ 9252.767313][T31622]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>         [ 9252.769832][T31622] RIP: 0033:0x7f704e283327
>         [ 9252.771509][T31622] Code: Bad RIP value.
>         [ 9252.772262][T31622] RSP: 002b:00007ffcc4a0ee38 EFLAGS: 0000020=
2 ORIG_RAX: 0000000000000054
>         [ 9252.773761][T31622] RAX: ffffffffffffffda RBX: 00007ffcc4a0ef6=
8 RCX: 00007f704e283327
>         [ 9252.775215][T31622] RDX: 00007f704e355000 RSI: 000000000000000=
1 RDI: 00007ffcc4a10bc8
>         [ 9252.776884][T31622] RBP: 0000000000000002 R08: 000000000000000=
0 R09: 0000000000000000
>         [ 9252.780325][T31622] R10: fffffffffffffa47 R11: 000000000000020=
2 R12: 000055a38de8dca0
>         [ 9252.782592][T31622] R13: 000055a38dc8b487 R14: 00007ffcc4a10bc=
8 R15: 0000000000000000
>         [ 9252.784105][T31622] rsync           D    0  8275   8267 0x0000=
0000
>         [ 9252.785379][T31622] Call Trace:
>         [ 9252.785854][T31622]  __schedule+0x3d4/0xb70
>         [ 9252.786472][T31622]  schedule+0x3d/0x80
>         [ 9252.787043][T31622]  wait_current_trans+0xcf/0x110
>         [ 9252.787740][T31622]  ? wait_woken+0xa0/0xa0
>         [ 9252.788373][T31622]  start_transaction+0x307/0x4d0
>         [ 9252.789076][T31622]  btrfs_join_transaction+0x1d/0x20
>         [ 9252.789809][T31622]  btrfs_dirty_inode+0x49/0xd0
>         [ 9252.790480][T31622]  btrfs_setattr+0xab/0x5a0
>         [ 9252.791122][T31622]  notify_change+0x2f0/0x450
>         [ 9252.792195][T31622]  utimes_common+0xd1/0x1b0
>         [ 9252.793151][T31622]  ? user_path_at_empty+0x36/0x40
>         [ 9252.794337][T31622]  do_utimes+0x126/0x160
>         [ 9252.794954][T31622]  __se_sys_utimensat+0x84/0xd0
>         [ 9252.795638][T31622]  ? entry_SYSCALL_64_after_hwframe+0x49/0xb=
e
>         [ 9252.796507][T31622]  __x64_sys_utimensat+0x1e/0x20
>         [ 9252.797289][T31622]  ? __x64_sys_utimensat+0x1e/0x20
>         [ 9252.798049][T31622]  do_syscall_64+0x65/0x1a0
>         [ 9252.798684][T31622]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>         [ 9252.799965][T31622] RIP: 0033:0x7fc971e655cf
>         [ 9252.800734][T31622] Code: Bad RIP value.
>         [ 9252.801524][T31622] RSP: 002b:00007ffec29a85f8 EFLAGS: 0000020=
2 ORIG_RAX: 0000000000000118
>         [ 9252.802793][T31622] RAX: ffffffffffffffda RBX: 00007ffec29aaad=
0 RCX: 00007fc971e655cf
>         [ 9252.805816][T31622] RDX: 00007ffec29a8600 RSI: 00007ffec29aaad=
0 RDI: 00000000ffffff9c
>         [ 9252.808412][T31622] RBP: 000000002d376874 R08: 000000000000000=
0 R09: 0000000000000000
>         [ 9252.809587][T31622] R10: 0000000000000100 R11: 000000000000020=
2 R12: 00000000000041ed
>         [ 9252.810855][T31622] R13: 0000000000000000 R14: 00005618c65b700=
8 R15: 00000000000041ed
>         [ 9252.814042][T31622] rsync           D    0  8395   8389 0x0000=
0000
>         [ 9252.817187][T31622] Call Trace:
>         [ 9252.817653][T31622]  __schedule+0x3d4/0xb70
>         [ 9252.818297][T31622]  schedule+0x3d/0x80
>         [ 9252.819052][T31622]  wait_current_trans+0xcf/0x110
>         [ 9252.819833][T31622]  ? wait_woken+0xa0/0xa0
>         [ 9252.820906][T31622]  start_transaction+0x307/0x4d0
>         [ 9252.821957][T31622]  btrfs_join_transaction+0x1d/0x20
>         [ 9252.822980][T31622]  btrfs_dirty_inode+0x49/0xd0
>         [ 9252.823717][T31622]  btrfs_setattr+0xab/0x5a0
>         [ 9252.824475][T31622]  notify_change+0x2f0/0x450
>         [ 9252.825384][T31622]  utimes_common+0xd1/0x1b0
>         [ 9252.826368][T31622]  ? user_path_at_empty+0x36/0x40
>         [ 9252.827482][T31622]  do_utimes+0x126/0x160
>         [ 9252.828423][T31622]  __se_sys_utimensat+0x84/0xd0
>         [ 9252.829294][T31622]  ? entry_SYSCALL_64_after_hwframe+0x49/0xb=
e
>         [ 9252.830444][T31622]  __x64_sys_utimensat+0x1e/0x20
>         [ 9252.831195][T31622]  ? __x64_sys_utimensat+0x1e/0x20
>         [ 9252.832653][T31622]  do_syscall_64+0x65/0x1a0
>         [ 9252.834242][T31622]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>         [ 9252.835707][T31622] RIP: 0033:0x7f40e72005cf
>         [ 9252.836684][T31622] Code: Bad RIP value.
>         [ 9252.837272][T31622] RSP: 002b:00007fff8cb07958 EFLAGS: 0000020=
6 ORIG_RAX: 0000000000000118
>         [ 9252.838534][T31622] RAX: ffffffffffffffda RBX: 00007fff8cb09e3=
0 RCX: 00007f40e72005cf
>         [ 9252.839716][T31622] RDX: 00007fff8cb07960 RSI: 00007fff8cb09e3=
0 RDI: 00000000ffffff9c
>         [ 9252.842343][T31622] RBP: 000000002e5f13f9 R08: 000000000000000=
0 R09: 0000000000000000
>         [ 9252.844312][T31622] R10: 0000000000000100 R11: 000000000000020=
6 R12: 00000000000041ed
>         [ 9252.845435][T31622] R13: 0000000000000000 R14: 000055ed97268f9=
0 R15: 00000000000041ed
>         [ 9252.846566][T31622] rsync           D    0 27409  27397 0x0000=
0000
>         [ 9252.847461][T31622] Call Trace:
>         [ 9252.847938][T31622]  __schedule+0x3d4/0xb70
>         [ 9252.848835][T31622]  schedule+0x3d/0x80
>         [ 9252.849581][T31622]  wait_current_trans+0xcf/0x110
>         [ 9252.851403][T31622]  ? wait_woken+0xa0/0xa0
>         [ 9252.852587][T31622]  start_transaction+0x307/0x4d0
>         [ 9252.854561][T31622]  btrfs_join_transaction+0x1d/0x20
>         [ 9252.855878][T31622]  btrfs_dirty_inode+0x49/0xd0
>         [ 9252.856903][T31622]  btrfs_setattr+0xab/0x5a0
>         [ 9252.857659][T31622]  notify_change+0x2f0/0x450
>         [ 9252.858317][T31622]  utimes_common+0xd1/0x1b0
>         [ 9252.858973][T31622]  ? user_path_at_empty+0x36/0x40
>         [ 9252.859814][T31622]  do_utimes+0x126/0x160
>         [ 9252.860770][T31622]  __se_sys_utimensat+0x84/0xd0
>         [ 9252.861818][T31622]  ? entry_SYSCALL_64_after_hwframe+0x49/0xb=
e
>         [ 9252.863123][T31622]  __x64_sys_utimensat+0x1e/0x20
>         [ 9252.864209][T31622]  ? __x64_sys_utimensat+0x1e/0x20
>         [ 9252.865269][T31622]  do_syscall_64+0x65/0x1a0
>         [ 9252.866258][T31622]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>         [ 9252.867525][T31622] RIP: 0033:0x7fea0da5c5cf
>         [ 9252.868154][T31622] Code: Bad RIP value.
>         [ 9252.868715][T31622] RSP: 002b:00007ffd6d35c1f8 EFLAGS: 0000020=
2 ORIG_RAX: 0000000000000118
>         [ 9252.872619][T31622] RAX: ffffffffffffffda RBX: 00007ffd6d35e6d=
0 RCX: 00007fea0da5c5cf
>         [ 9252.875131][T31622] RDX: 00007ffd6d35c200 RSI: 00007ffd6d35e6d=
0 RDI: 00000000ffffff9c
>         [ 9252.876585][T31622] RBP: 00000000256a5835 R08: 000000000000000=
0 R09: 0000000000000000
>         [ 9252.877970][T31622] R10: 0000000000000100 R11: 000000000000020=
2 R12: 00000000000041ed
>         [ 9252.879579][T31622] R13: 0000000000000000 R14: 000055613a3ede6=
8 R15: 00000000000041ed
>         [ 9252.880917][T31622] rsync           D    0 18114  18105 0x0000=
0000
>         [ 9252.882081][T31622] Call Trace:
>         [ 9252.882617][T31622]  __schedule+0x3d4/0xb70
>         [ 9252.883251][T31622]  schedule+0x3d/0x80
>         [ 9252.884147][T31622]  wait_current_trans+0xcf/0x110
>         [ 9252.886769][T31622]  ? wait_woken+0xa0/0xa0
>         [ 9252.888511][T31622]  start_transaction+0x307/0x4d0
>         [ 9252.890235][T31622]  btrfs_join_transaction+0x1d/0x20
>         [ 9252.894332][T31622]  btrfs_dirty_inode+0x49/0xd0
>         [ 9252.896219][T31622]  btrfs_setattr+0xab/0x5a0
>         [ 9252.897910][T31622]  notify_change+0x2f0/0x450
>         [ 9252.899336][T31622]  utimes_common+0xd1/0x1b0
>         [ 9252.900074][T31622]  ? user_path_at_empty+0x36/0x40
>         [ 9252.900830][T31622]  do_utimes+0x126/0x160
>         [ 9252.901522][T31622]  __se_sys_utimensat+0x84/0xd0
>         [ 9252.904071][T31622]  ? entry_SYSCALL_64_after_hwframe+0x49/0xb=
e
>         [ 9252.906114][T31622]  __x64_sys_utimensat+0x1e/0x20
>         [ 9252.907223][T31622]  ? __x64_sys_utimensat+0x1e/0x20
>         [ 9252.911404][T31622]  do_syscall_64+0x65/0x1a0
>         [ 9252.912242][T31622]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>         [ 9252.913097][T31622] RIP: 0033:0x7f3a427115cf
>         [ 9252.913724][T31622] Code: Bad RIP value.
>         [ 9252.914318][T31622] RSP: 002b:00007ffcf0586d68 EFLAGS: 0000020=
2 ORIG_RAX: 0000000000000118
>         [ 9252.917091][T31622] RAX: ffffffffffffffda RBX: 00007ffcf058924=
0 RCX: 00007f3a427115cf
>         [ 9252.919064][T31622] RDX: 00007ffcf0586d70 RSI: 00007ffcf058924=
0 RDI: 00000000ffffff9c
>         [ 9252.920484][T31622] RBP: 000000001824f8ed R08: 000000000000000=
0 R09: 0000000000000000
>         [ 9252.921626][T31622] R10: 0000000000000100 R11: 000000000000020=
2 R12: 00000000000041ff
>         [ 9252.923624][T31622] R13: 0000000000000000 R14: 00007f3a42597fe=
8 R15: 00000000000041ff



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
