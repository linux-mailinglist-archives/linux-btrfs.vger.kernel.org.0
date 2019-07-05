Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 602F0604AA
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2019 12:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbfGEKmZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Jul 2019 06:42:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:37752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727642AbfGEKmY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 5 Jul 2019 06:42:24 -0400
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D8DA218BC
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Jul 2019 10:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562323343;
        bh=gCJhtQGFPFMe9RZ9zjxxodY/OrKu1tvBylzMF8hflvE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=N5LGf3buzM8XvDPI8rcZ2rNexxHVNMA3YwaOka8rguy7w78aFulaJovCojO4Wg2Ts
         RN1n+OPLSyl69mV9l/5+naHlbdgtrPXpn9JIcRmP1VVaM3Ex+nrmiXbWigWyMCJFfC
         FOoeOZ/QiGpEXPbUEFPP8yk44c87G/nxbDvJvEAc=
Received: by mail-vs1-f47.google.com with SMTP id u3so3534847vsh.6
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Jul 2019 03:42:23 -0700 (PDT)
X-Gm-Message-State: APjAAAV0S5IKCao+du6WeiSybd+ynfHdRDptuXZw4OCHxt1J8af9b4xG
        x1LZYnoL5ZlXlkk2TsfToct5kaS7zarJHBO1WPQ=
X-Google-Smtp-Source: APXvYqz2gsn//UPxLADgJyAteTJ961y+Rk+BDxRnxzJs6ha7ENOXlk3PHp9C28OnZdCxlaYh7FtIavS98jolehun0ZA=
X-Received: by 2002:a67:ff0b:: with SMTP id v11mr1732766vsp.14.1562323342029;
 Fri, 05 Jul 2019 03:42:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190704152419.20715-1-fdmanana@kernel.org> <4cdbcb14-c0e6-bdf7-e542-3c7f0286c91e@suse.com>
In-Reply-To: <4cdbcb14-c0e6-bdf7-e542-3c7f0286c91e@suse.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Fri, 5 Jul 2019 11:42:11 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6648gYV4AAQmoR23_9Z3DBq074OKCRn5K6i5cERfsnug@mail.gmail.com>
Message-ID: <CAL3q7H6648gYV4AAQmoR23_9Z3DBq074OKCRn5K6i5cERfsnug@mail.gmail.com>
Subject: Re: [PATCH 2/5] Btrfs: fix inode cache block reserve leak on failure
 to allocate data space
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 5, 2019 at 11:01 AM Nikolay Borisov <nborisov@suse.com> wrote:
>
>
>
> On 4.07.19 =D0=B3. 18:24 =D1=87., fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > If we failed to allocate the data extent(s) for the inode space cache, =
we
> > were bailing out without releasing the previously reserved metadata. Th=
is
> > was triggering the following warnings when unmounting a filesystem:
> >
> >   $ cat -n fs/btrfs/inode.c
> >   (...)
> >   9268  void btrfs_destroy_inode(struct inode *inode)
> >   9269  {
> >   (...)
> >   9276          WARN_ON(BTRFS_I(inode)->block_rsv.reserved);
> >   9277          WARN_ON(BTRFS_I(inode)->block_rsv.size);
> >   (...)
> >   9281          WARN_ON(BTRFS_I(inode)->csum_bytes);
> >   9282          WARN_ON(BTRFS_I(inode)->defrag_bytes);
> >   (...)
> >
> > Several fstests test cases triggered this often, such as generic/083,
> > generic/102, generic/172, generic/269 and generic/300 at least, produci=
ng
> > stack traces like the following in dmesg/syslog:
> >
> >   [82039.079546] WARNING: CPU: 2 PID: 13167 at fs/btrfs/inode.c:9276 bt=
rfs_destroy_inode+0x203/0x270 [btrfs]
> >   (...)
> >   [82039.081543] CPU: 2 PID: 13167 Comm: umount Tainted: G        W    =
     5.2.0-rc4-btrfs-next-50 #1
> >   [82039.081912] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),=
 BIOS rel-1.11.2-0-gf9626ccb91-prebuilt.qemu-project.org 04/01/2014
> >   [82039.082673] RIP: 0010:btrfs_destroy_inode+0x203/0x270 [btrfs]
> >   (...)
> >   [82039.083913] RSP: 0018:ffffac0b426a7d30 EFLAGS: 00010206
> >   [82039.084320] RAX: ffff8ddf77691158 RBX: ffff8dde29b34660 RCX: 00000=
00000000002
> >   [82039.084736] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff8=
dde29b34660
> >   [82039.085156] RBP: ffff8ddf5fbec000 R08: 0000000000000000 R09: 00000=
00000000000
> >   [82039.085578] R10: ffffac0b426a7c90 R11: ffffffffb9aad768 R12: ffffa=
c0b426a7db0
> >   [82039.086000] R13: ffff8ddf5fbec0a0 R14: dead000000000100 R15: 00000=
00000000000
> >   [82039.086416] FS:  00007f8db96d12c0(0000) GS:ffff8de036b00000(0000) =
knlGS:0000000000000000
> >   [82039.086837] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >   [82039.087253] CR2: 0000000001416108 CR3: 00000002315cc001 CR4: 00000=
000003606e0
> >   [82039.087672] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000=
00000000000
> >   [82039.088089] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000=
00000000400
> >   [82039.088504] Call Trace:
> >   [82039.088918]  destroy_inode+0x3b/0x70
> >   [82039.089340]  btrfs_free_fs_root+0x16/0xa0 [btrfs]
> >   [82039.089768]  btrfs_free_fs_roots+0xd8/0x160 [btrfs]
> >   [82039.090183]  ? wait_for_completion+0x65/0x1a0
> >   [82039.090607]  close_ctree+0x172/0x370 [btrfs]
> >   [82039.091021]  generic_shutdown_super+0x6c/0x110
> >   [82039.091427]  kill_anon_super+0xe/0x30
> >   [82039.091832]  btrfs_kill_super+0x12/0xa0 [btrfs]
> >   [82039.092233]  deactivate_locked_super+0x3a/0x70
> >   [82039.092636]  cleanup_mnt+0x3b/0x80
> >   [82039.093039]  task_work_run+0x93/0xc0
> >   [82039.093457]  exit_to_usermode_loop+0xfa/0x100
> >   [82039.093856]  do_syscall_64+0x162/0x1d0
> >   [82039.094244]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> >   [82039.094634] RIP: 0033:0x7f8db8fbab37
> >   (...)
> >   [82039.095876] RSP: 002b:00007ffdce35b468 EFLAGS: 00000246 ORIG_RAX: =
00000000000000a6
> >   [82039.096290] RAX: 0000000000000000 RBX: 0000560d20b00060 RCX: 00007=
f8db8fbab37
> >   [82039.096700] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 00005=
60d20b00240
> >   [82039.097110] RBP: 0000560d20b00240 R08: 0000560d20b00270 R09: 00000=
00000000015
> >   [82039.097522] R10: 00000000000006b4 R11: 0000000000000246 R12: 00007=
f8db94bce64
> >   [82039.097937] R13: 0000000000000000 R14: 0000000000000000 R15: 00007=
ffdce35b6f0
> >   [82039.098350] irq event stamp: 0
> >   [82039.098750] hardirqs last  enabled at (0): [<0000000000000000>] 0x=
0
> >   [82039.099150] hardirqs last disabled at (0): [<ffffffffb7884ff2>] co=
py_process.part.33+0x7f2/0x1f00
> >   [82039.099545] softirqs last  enabled at (0): [<ffffffffb7884ff2>] co=
py_process.part.33+0x7f2/0x1f00
> >   [82039.099925] softirqs last disabled at (0): [<0000000000000000>] 0x=
0
> >   [82039.100292] ---[ end trace f2521afa616ddccc ]---
> >   [82039.100707] WARNING: CPU: 2 PID: 13167 at fs/btrfs/inode.c:9277 bt=
rfs_destroy_inode+0x1ac/0x270 [btrfs]
> >   (...)
> >   [82039.103050] CPU: 2 PID: 13167 Comm: umount Tainted: G        W    =
     5.2.0-rc4-btrfs-next-50 #1
> >   [82039.103428] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),=
 BIOS rel-1.11.2-0-gf9626ccb91-prebuilt.qemu-project.org 04/01/2014
> >   [82039.104203] RIP: 0010:btrfs_destroy_inode+0x1ac/0x270 [btrfs]
> >   (...)
> >   [82039.105461] RSP: 0018:ffffac0b426a7d30 EFLAGS: 00010206
> >   [82039.105866] RAX: ffff8ddf77691158 RBX: ffff8dde29b34660 RCX: 00000=
00000000002
> >   [82039.106270] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff8=
dde29b34660
> >   [82039.106673] RBP: ffff8ddf5fbec000 R08: 0000000000000000 R09: 00000=
00000000000
> >   [82039.107078] R10: ffffac0b426a7c90 R11: ffffffffb9aad768 R12: ffffa=
c0b426a7db0
> >   [82039.107487] R13: ffff8ddf5fbec0a0 R14: dead000000000100 R15: 00000=
00000000000
> >   [82039.107894] FS:  00007f8db96d12c0(0000) GS:ffff8de036b00000(0000) =
knlGS:0000000000000000
> >   [82039.108309] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >   [82039.108723] CR2: 0000000001416108 CR3: 00000002315cc001 CR4: 00000=
000003606e0
> >   [82039.109146] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000=
00000000000
> >   [82039.109567] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000=
00000000400
> >   [82039.109989] Call Trace:
> >   [82039.110405]  destroy_inode+0x3b/0x70
> >   [82039.110830]  btrfs_free_fs_root+0x16/0xa0 [btrfs]
> >   [82039.111257]  btrfs_free_fs_roots+0xd8/0x160 [btrfs]
> >   [82039.111675]  ? wait_for_completion+0x65/0x1a0
> >   [82039.112101]  close_ctree+0x172/0x370 [btrfs]
> >   [82039.112519]  generic_shutdown_super+0x6c/0x110
> >   [82039.112988]  kill_anon_super+0xe/0x30
> >   [82039.113439]  btrfs_kill_super+0x12/0xa0 [btrfs]
> >   [82039.113861]  deactivate_locked_super+0x3a/0x70
> >   [82039.114278]  cleanup_mnt+0x3b/0x80
> >   [82039.114685]  task_work_run+0x93/0xc0
> >   [82039.115083]  exit_to_usermode_loop+0xfa/0x100
> >   [82039.115476]  do_syscall_64+0x162/0x1d0
> >   [82039.115863]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> >   [82039.116254] RIP: 0033:0x7f8db8fbab37
> >   (...)
> >   [82039.117463] RSP: 002b:00007ffdce35b468 EFLAGS: 00000246 ORIG_RAX: =
00000000000000a6
> >   [82039.117882] RAX: 0000000000000000 RBX: 0000560d20b00060 RCX: 00007=
f8db8fbab37
> >   [82039.118330] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 00005=
60d20b00240
> >   [82039.118743] RBP: 0000560d20b00240 R08: 0000560d20b00270 R09: 00000=
00000000015
> >   [82039.119159] R10: 00000000000006b4 R11: 0000000000000246 R12: 00007=
f8db94bce64
> >   [82039.119574] R13: 0000000000000000 R14: 0000000000000000 R15: 00007=
ffdce35b6f0
> >   [82039.119987] irq event stamp: 0
> >   [82039.120387] hardirqs last  enabled at (0): [<0000000000000000>] 0x=
0
> >   [82039.120787] hardirqs last disabled at (0): [<ffffffffb7884ff2>] co=
py_process.part.33+0x7f2/0x1f00
> >   [82039.121182] softirqs last  enabled at (0): [<ffffffffb7884ff2>] co=
py_process.part.33+0x7f2/0x1f00
> >   [82039.121563] softirqs last disabled at (0): [<0000000000000000>] 0x=
0
> >   [82039.121933] ---[ end trace f2521afa616ddccd ]---
> >   [82039.122353] WARNING: CPU: 2 PID: 13167 at fs/btrfs/inode.c:9278 bt=
rfs_destroy_inode+0x1bc/0x270 [btrfs]
> >   (...)
> >   [82039.124606] CPU: 2 PID: 13167 Comm: umount Tainted: G        W    =
     5.2.0-rc4-btrfs-next-50 #1
> >   [82039.125008] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),=
 BIOS rel-1.11.2-0-gf9626ccb91-prebuilt.qemu-project.org 04/01/2014
> >   [82039.125801] RIP: 0010:btrfs_destroy_inode+0x1bc/0x270 [btrfs]
> >   (...)
> >   [82039.126998] RSP: 0018:ffffac0b426a7d30 EFLAGS: 00010202
> >   [82039.127399] RAX: ffff8ddf77691158 RBX: ffff8dde29b34660 RCX: 00000=
00000000002
> >   [82039.127803] RDX: 0000000000000001 RSI: 0000000000000001 RDI: ffff8=
dde29b34660
> >   [82039.128206] RBP: ffff8ddf5fbec000 R08: 0000000000000000 R09: 00000=
00000000000
> >   [82039.128611] R10: ffffac0b426a7c90 R11: ffffffffb9aad768 R12: ffffa=
c0b426a7db0
> >   [82039.129020] R13: ffff8ddf5fbec0a0 R14: dead000000000100 R15: 00000=
00000000000
> >   [82039.129428] FS:  00007f8db96d12c0(0000) GS:ffff8de036b00000(0000) =
knlGS:0000000000000000
> >   [82039.129846] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >   [82039.130261] CR2: 0000000001416108 CR3: 00000002315cc001 CR4: 00000=
000003606e0
> >   [82039.130684] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000=
00000000000
> >   [82039.131142] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000=
00000000400
> >   [82039.131561] Call Trace:
> >   [82039.131990]  destroy_inode+0x3b/0x70
> >   [82039.132417]  btrfs_free_fs_root+0x16/0xa0 [btrfs]
> >   [82039.132844]  btrfs_free_fs_roots+0xd8/0x160 [btrfs]
> >   [82039.133262]  ? wait_for_completion+0x65/0x1a0
> >   [82039.133688]  close_ctree+0x172/0x370 [btrfs]
> >   [82039.134157]  generic_shutdown_super+0x6c/0x110
> >   [82039.134575]  kill_anon_super+0xe/0x30
> >   [82039.134997]  btrfs_kill_super+0x12/0xa0 [btrfs]
> >   [82039.135415]  deactivate_locked_super+0x3a/0x70
> >   [82039.135832]  cleanup_mnt+0x3b/0x80
> >   [82039.136239]  task_work_run+0x93/0xc0
> >   [82039.136637]  exit_to_usermode_loop+0xfa/0x100
> >   [82039.137029]  do_syscall_64+0x162/0x1d0
> >   [82039.137418]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> >   [82039.137812] RIP: 0033:0x7f8db8fbab37
> >   (...)
> >   [82039.139059] RSP: 002b:00007ffdce35b468 EFLAGS: 00000246 ORIG_RAX: =
00000000000000a6
> >   [82039.139475] RAX: 0000000000000000 RBX: 0000560d20b00060 RCX: 00007=
f8db8fbab37
> >   [82039.139890] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 00005=
60d20b00240
> >   [82039.140302] RBP: 0000560d20b00240 R08: 0000560d20b00270 R09: 00000=
00000000015
> >   [82039.140719] R10: 00000000000006b4 R11: 0000000000000246 R12: 00007=
f8db94bce64
> >   [82039.141138] R13: 0000000000000000 R14: 0000000000000000 R15: 00007=
ffdce35b6f0
> >   [82039.141597] irq event stamp: 0
> >   [82039.142043] hardirqs last  enabled at (0): [<0000000000000000>] 0x=
0
> >   [82039.142443] hardirqs last disabled at (0): [<ffffffffb7884ff2>] co=
py_process.part.33+0x7f2/0x1f00
> >   [82039.142839] softirqs last  enabled at (0): [<ffffffffb7884ff2>] co=
py_process.part.33+0x7f2/0x1f00
> >   [82039.143220] softirqs last disabled at (0): [<0000000000000000>] 0x=
0
> >   [82039.143588] ---[ end trace f2521afa616ddcce ]---
> >   [82039.167472] WARNING: CPU: 3 PID: 13167 at fs/btrfs/extent-tree.c:1=
0120 btrfs_free_block_groups+0x30d/0x460 [btrfs]
> >   (...)
> >   [82039.173800] CPU: 3 PID: 13167 Comm: umount Tainted: G        W    =
     5.2.0-rc4-btrfs-next-50 #1
> >   [82039.174847] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),=
 BIOS rel-1.11.2-0-gf9626ccb91-prebuilt.qemu-project.org 04/01/2014
> >   [82039.177031] RIP: 0010:btrfs_free_block_groups+0x30d/0x460 [btrfs]
> >   (...)
> >   [82039.180397] RSP: 0018:ffffac0b426a7dd8 EFLAGS: 00010206
> >   [82039.181574] RAX: ffff8de010a1db40 RBX: ffff8de010a1db40 RCX: 00000=
00000170014
> >   [82039.182711] RDX: ffff8ddff4380040 RSI: ffff8de010a1da58 RDI: 00000=
00000000246
> >   [82039.183817] RBP: ffff8ddf5fbec000 R08: 0000000000000000 R09: 00000=
00000000000
> >   [82039.184925] R10: ffff8de036404380 R11: ffffffffb8a5ea00 R12: ffff8=
de010a1b2b8
> >   [82039.186090] R13: ffff8de010a1b2b8 R14: 0000000000000000 R15: dead0=
00000000100
> >   [82039.187208] FS:  00007f8db96d12c0(0000) GS:ffff8de036b80000(0000) =
knlGS:0000000000000000
> >   [82039.188345] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >   [82039.189481] CR2: 00007fb044005170 CR3: 00000002315cc006 CR4: 00000=
000003606e0
> >   [82039.190674] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000=
00000000000
> >   [82039.191829] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000=
00000000400
> >   [82039.192978] Call Trace:
> >   [82039.194160]  close_ctree+0x19a/0x370 [btrfs]
> >   [82039.195315]  generic_shutdown_super+0x6c/0x110
> >   [82039.196486]  kill_anon_super+0xe/0x30
> >   [82039.197645]  btrfs_kill_super+0x12/0xa0 [btrfs]
> >   [82039.198696]  deactivate_locked_super+0x3a/0x70
> >   [82039.199619]  cleanup_mnt+0x3b/0x80
> >   [82039.200559]  task_work_run+0x93/0xc0
> >   [82039.201505]  exit_to_usermode_loop+0xfa/0x100
> >   [82039.202436]  do_syscall_64+0x162/0x1d0
> >   [82039.203339]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> >   [82039.204091] RIP: 0033:0x7f8db8fbab37
> >   (...)
> >   [82039.206360] RSP: 002b:00007ffdce35b468 EFLAGS: 00000246 ORIG_RAX: =
00000000000000a6
> >   [82039.207132] RAX: 0000000000000000 RBX: 0000560d20b00060 RCX: 00007=
f8db8fbab37
> >   [82039.207906] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 00005=
60d20b00240
> >   [82039.208621] RBP: 0000560d20b00240 R08: 0000560d20b00270 R09: 00000=
00000000015
> >   [82039.209285] R10: 00000000000006b4 R11: 0000000000000246 R12: 00007=
f8db94bce64
> >   [82039.209984] R13: 0000000000000000 R14: 0000000000000000 R15: 00007=
ffdce35b6f0
> >   [82039.210642] irq event stamp: 0
> >   [82039.211306] hardirqs last  enabled at (0): [<0000000000000000>] 0x=
0
> >   [82039.211971] hardirqs last disabled at (0): [<ffffffffb7884ff2>] co=
py_process.part.33+0x7f2/0x1f00
> >   [82039.212643] softirqs last  enabled at (0): [<ffffffffb7884ff2>] co=
py_process.part.33+0x7f2/0x1f00
> >   [82039.213304] softirqs last disabled at (0): [<0000000000000000>] 0x=
0
> >   [82039.213875] ---[ end trace f2521afa616ddccf ]---
> >
> > Fix this by releasing the reserved metadata on failure to allocate data
> > extent(s) for the inode cache.
> >
> > Fixes: 69fe2d75dd91d0 ("btrfs: make the delalloc block rsv per inode")
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>> ---
> >  fs/btrfs/inode-map.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/fs/btrfs/inode-map.c b/fs/btrfs/inode-map.c
> > index 4a5882665f8a..b210e8929c28 100644
> > --- a/fs/btrfs/inode-map.c
> > +++ b/fs/btrfs/inode-map.c
> > @@ -485,6 +485,7 @@ int btrfs_save_ino_cache(struct btrfs_root *root,
> >                                             prealloc, prealloc, &alloc_=
hint);
> >       if (ret) {
> >               btrfs_delalloc_release_extents(BTRFS_I(inode), prealloc, =
true);
> > +             btrfs_delalloc_release_metadata(BTRFS_I(inode), prealloc,=
 true);
>
> I think the correct freeing function is btrfs_delalloc_release_space
> here instead of just releasing the metadata.

No, that won't work. Tried that before and it gives this:

[153560.798990] WARNING: CPU: 2 PID: 21184 at
fs/btrfs/extent-tree.c:69
btrfs_free_reserved_data_space_noquota+0x12e/0x170 [btrfs]
[153560.799744] Modules linked in: btrfs xfs xor raid6_pq dm_thin_pool
dm_persistent_data dm_bio_prison dm_snapshot dm_bufio dm_log_writes
libcrc32c dm_flakey dm_mod loop kvm_intel kvm irqbypass bochs_drm ttm
drm_kms_helper drm crct10dif_pclmul crc32_pclmul ghash_clmulni_intel
aesni_intel aes_x86_64 crypto_simd cryptd glue_helper sg evdev joydev
qemu_fw_cfg pcspkr serio_raw button parport_pc ppdev lp parport
ip_tables x_tables autofs4 ext4 crc32c_generic crc16 mbcache jbd2
sd_mod virtio_scsi ata_generic ata_piix crc32c_intel psmouse libata
i2c_piix4 e1000 virtio_pci virtio_ring scsi_mod virtio [last unloaded:
btrfs]
[153560.801913] CPU: 2 PID: 21184 Comm: xfs_io Tainted: G        W
    5.2.0-rc4-btrfs-next-50 #1
[153560.802397] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.11.2-0-gf9626ccb91-prebuilt.qemu-project.org 04/01/2014
[153560.803447] RIP:
0010:btrfs_free_reserved_data_space_noquota+0x12e/0x170 [btrfs]
[153560.803954] Code: c7 f6 85 c0 74 09 80 3d da 8e 13 00 00 74 2b 65
ff 0d 3e da 37 3f e9 56 ff ff ff 48 89 c1 48 f7 d9 48 39 ca 0f 83 27
ff ff ff <0f> 0b 49 c7 44 24 58 00 00 00 00 e9 1f ff ff ff e8 bd e8 c7
f6 85
[153560.804979] RSP: 0018:ffffac0b425efb80 EFLAGS: 00010287
[153560.805499] RAX: ffffffffffff7000 RBX: 0000000000009000 RCX:
0000000000009000
[153560.806027] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
ffff8de010a1c518
[153560.806565] RBP: ffff8ddf51618000 R08: 0000000000000001 R09:
0000000000000000
[153560.807090] R10: ffffac0b425efb00 R11: ffff8de010a1c530 R12:
ffff8de010a1c518
[153560.807612] R13: ffff8dde89f40488 R14: 0000000000008fff R15:
ffff8dde89f40488
[153560.808151] FS:  00007f850aa3e700(0000) GS:ffff8de036b00000(0000)
knlGS:0000000000000000
[153560.808678] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[153560.809210] CR2: 00005568bb4cf670 CR3: 00000002024ce006 CR4:
00000000003606e0
[153560.809740] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[153560.810340] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[153560.810885] Call Trace:
[153560.811421]  btrfs_free_reserved_data_space+0x4b/0x70 [btrfs]
[153560.811964]  btrfs_save_ino_cache+0x410/0x5c0 [btrfs]
[153560.812508]  commit_fs_roots+0xb8/0x1b0 [btrfs]
[153560.813068]  ? btrfs_first_delayed_node+0xf/0x50 [btrfs]
[153560.813615]  btrfs_commit_transaction+0x4d7/0xae0 [btrfs]
[153560.814171]  ? start_transaction+0xa2/0x500 [btrfs]
[153560.814706]  btrfs_alloc_data_chunk_ondemand+0x192/0x430 [btrfs]
[153560.815248]  btrfs_fallocate+0xe5/0x1110 [btrfs]
[153560.815776]  ? lock_acquire+0xa6/0x190
[153560.816302]  ? rcu_sync_lockdep_assert+0xe/0x60
[153560.816854]  ? __sb_start_write+0xd4/0x1c0
[153560.817372]  vfs_fallocate+0x153/0x290
[153560.817890]  ksys_fallocate+0x3c/0x70
[153560.818489]  __x64_sys_fallocate+0x1a/0x20
[153560.818999]  do_syscall_64+0x60/0x1d0
[153560.819503]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
(...)

Thanks.

>
> Looking at the interface and naming of functions it could be confusing
> as hell which function  needs to be used ;\
>
>
> >               goto out_put;
> >       }
> >
> >
