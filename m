Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF27607EC
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2019 16:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfGEOcc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Jul 2019 10:32:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:37174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbfGEOcc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 5 Jul 2019 10:32:32 -0400
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22D26218A3
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Jul 2019 14:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562337150;
        bh=hIIHrQQeaUI0F91YYMidfAvPhMQrt9Web6AfJ6Atjfs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=y7wZExJeOoTQsWMIxaok18FhTM0ZVsHxl/Rg9/aVtS2GThQTLvOfs+p282PL6HECL
         6j2KTK7zksX9JyMtjzjqil9F9lZOMpyUNsn45BMWQvwdT09p2yXPqO5FFVVwMZoTwY
         tw/7DCXkcPhK+mNUnH+2lp0xY114zh3do0CUvuWc=
Received: by mail-vk1-f173.google.com with SMTP id 9so1217977vkw.4
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Jul 2019 07:32:30 -0700 (PDT)
X-Gm-Message-State: APjAAAVJwVVbAtyOadyjZH/2zuUerPM08y0J5w0D9ItcUrDYnMeiC8PA
        W8Nxv2gVg4f4QMBSXOX090aPsVCbu3OesGc+QG0=
X-Google-Smtp-Source: APXvYqzjGuwjGF0quY7EJK5HNzjJwQGc/uBah29+dHuGFMkk3SBOlrBEG8jUI67eMfLCEeGIZ8iVDdjEskX3cx4D4SI=
X-Received: by 2002:a1f:9ad7:: with SMTP id c206mr1242667vke.31.1562337149097;
 Fri, 05 Jul 2019 07:32:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190704152419.20715-1-fdmanana@kernel.org> <4cdbcb14-c0e6-bdf7-e542-3c7f0286c91e@suse.com>
 <CAL3q7H6648gYV4AAQmoR23_9Z3DBq074OKCRn5K6i5cERfsnug@mail.gmail.com>
 <1f4daf23-1438-785b-92b4-e494ce270c2d@suse.com> <CAL3q7H7MRxw6CpgGsJDFE5qgnVsMn7CgmQLf0aKfmXX41wwNXA@mail.gmail.com>
 <7015f763-1949-661c-f1ed-4008f34e3b57@suse.com>
In-Reply-To: <7015f763-1949-661c-f1ed-4008f34e3b57@suse.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Fri, 5 Jul 2019 15:32:18 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5eBizJsjcsu5=Da334vDoFiaHP2a5g-STtKTCQT1KnBw@mail.gmail.com>
Message-ID: <CAL3q7H5eBizJsjcsu5=Da334vDoFiaHP2a5g-STtKTCQT1KnBw@mail.gmail.com>
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

On Fri, Jul 5, 2019 at 3:26 PM Nikolay Borisov <nborisov@suse.com> wrote:
>
>
>
> On 5.07.19 =D0=B3. 17:23 =D1=87., Filipe Manana wrote:
> > On Fri, Jul 5, 2019 at 3:09 PM Nikolay Borisov <nborisov@suse.com> wrot=
e:
> >>
> >>
> >>
> >> On 5.07.19 =D0=B3. 13:42 =D1=87., Filipe Manana wrote:
> >>> On Fri, Jul 5, 2019 at 11:01 AM Nikolay Borisov <nborisov@suse.com> w=
rote:
> >>>>
> >>>>
> >>>>
> >>>> On 4.07.19 =D0=B3. 18:24 =D1=87., fdmanana@kernel.org wrote:
> >>>>> From: Filipe Manana <fdmanana@suse.com>
> >>>>>
> >>>>> If we failed to allocate the data extent(s) for the inode space cac=
he, we
> >>>>> were bailing out without releasing the previously reserved metadata=
. This
> >>>>> was triggering the following warnings when unmounting a filesystem:
> >>>>>
> >>>>>   $ cat -n fs/btrfs/inode.c
> >>>>>   (...)
> >>>>>   9268  void btrfs_destroy_inode(struct inode *inode)
> >>>>>   9269  {
> >>>>>   (...)
> >>>>>   9276          WARN_ON(BTRFS_I(inode)->block_rsv.reserved);
> >>>>>   9277          WARN_ON(BTRFS_I(inode)->block_rsv.size);
> >>>>>   (...)
> >>>>>   9281          WARN_ON(BTRFS_I(inode)->csum_bytes);
> >>>>>   9282          WARN_ON(BTRFS_I(inode)->defrag_bytes);
> >>>>>   (...)
> >>>>>
> >>>>> Several fstests test cases triggered this often, such as generic/08=
3,
> >>>>> generic/102, generic/172, generic/269 and generic/300 at least, pro=
ducing
> >>>>> stack traces like the following in dmesg/syslog:
> >>>>>
> >>>>>   [82039.079546] WARNING: CPU: 2 PID: 13167 at fs/btrfs/inode.c:927=
6 btrfs_destroy_inode+0x203/0x270 [btrfs]
> >>>>>   (...)
> >>>>>   [82039.081543] CPU: 2 PID: 13167 Comm: umount Tainted: G        W=
         5.2.0-rc4-btrfs-next-50 #1
> >>>>>   [82039.081912] Hardware name: QEMU Standard PC (i440FX + PIIX, 19=
96), BIOS rel-1.11.2-0-gf9626ccb91-prebuilt.qemu-project.org 04/01/2014
> >>>>>   [82039.082673] RIP: 0010:btrfs_destroy_inode+0x203/0x270 [btrfs]
> >>>>>   (...)
> >>>>>   [82039.083913] RSP: 0018:ffffac0b426a7d30 EFLAGS: 00010206
> >>>>>   [82039.084320] RAX: ffff8ddf77691158 RBX: ffff8dde29b34660 RCX: 0=
000000000000002
> >>>>>   [82039.084736] RDX: 0000000000000000 RSI: 0000000000000001 RDI: f=
fff8dde29b34660
> >>>>>   [82039.085156] RBP: ffff8ddf5fbec000 R08: 0000000000000000 R09: 0=
000000000000000
> >>>>>   [82039.085578] R10: ffffac0b426a7c90 R11: ffffffffb9aad768 R12: f=
fffac0b426a7db0
> >>>>>   [82039.086000] R13: ffff8ddf5fbec0a0 R14: dead000000000100 R15: 0=
000000000000000
> >>>>>   [82039.086416] FS:  00007f8db96d12c0(0000) GS:ffff8de036b00000(00=
00) knlGS:0000000000000000
> >>>>>   [82039.086837] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >>>>>   [82039.087253] CR2: 0000000001416108 CR3: 00000002315cc001 CR4: 0=
0000000003606e0
> >>>>>   [82039.087672] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0=
000000000000000
> >>>>>   [82039.088089] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0=
000000000000400
> >>>>>   [82039.088504] Call Trace:
> >>>>>   [82039.088918]  destroy_inode+0x3b/0x70
> >>>>>   [82039.089340]  btrfs_free_fs_root+0x16/0xa0 [btrfs]
> >>>>>   [82039.089768]  btrfs_free_fs_roots+0xd8/0x160 [btrfs]
> >>>>>   [82039.090183]  ? wait_for_completion+0x65/0x1a0
> >>>>>   [82039.090607]  close_ctree+0x172/0x370 [btrfs]
> >>>>>   [82039.091021]  generic_shutdown_super+0x6c/0x110
> >>>>>   [82039.091427]  kill_anon_super+0xe/0x30
> >>>>>   [82039.091832]  btrfs_kill_super+0x12/0xa0 [btrfs]
> >>>>>   [82039.092233]  deactivate_locked_super+0x3a/0x70
> >>>>>   [82039.092636]  cleanup_mnt+0x3b/0x80
> >>>>>   [82039.093039]  task_work_run+0x93/0xc0
> >>>>>   [82039.093457]  exit_to_usermode_loop+0xfa/0x100
> >>>>>   [82039.093856]  do_syscall_64+0x162/0x1d0
> >>>>>   [82039.094244]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> >>>>>   [82039.094634] RIP: 0033:0x7f8db8fbab37
> >>>>>   (...)
> >>>>>   [82039.095876] RSP: 002b:00007ffdce35b468 EFLAGS: 00000246 ORIG_R=
AX: 00000000000000a6
> >>>>>   [82039.096290] RAX: 0000000000000000 RBX: 0000560d20b00060 RCX: 0=
0007f8db8fbab37
> >>>>>   [82039.096700] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0=
000560d20b00240
> >>>>>   [82039.097110] RBP: 0000560d20b00240 R08: 0000560d20b00270 R09: 0=
000000000000015
> >>>>>   [82039.097522] R10: 00000000000006b4 R11: 0000000000000246 R12: 0=
0007f8db94bce64
> >>>>>   [82039.097937] R13: 0000000000000000 R14: 0000000000000000 R15: 0=
0007ffdce35b6f0
> >>>>>   [82039.098350] irq event stamp: 0
> >>>>>   [82039.098750] hardirqs last  enabled at (0): [<0000000000000000>=
] 0x0
> >>>>>   [82039.099150] hardirqs last disabled at (0): [<ffffffffb7884ff2>=
] copy_process.part.33+0x7f2/0x1f00
> >>>>>   [82039.099545] softirqs last  enabled at (0): [<ffffffffb7884ff2>=
] copy_process.part.33+0x7f2/0x1f00
> >>>>>   [82039.099925] softirqs last disabled at (0): [<0000000000000000>=
] 0x0
> >>>>>   [82039.100292] ---[ end trace f2521afa616ddccc ]---
> >>>>>   [82039.100707] WARNING: CPU: 2 PID: 13167 at fs/btrfs/inode.c:927=
7 btrfs_destroy_inode+0x1ac/0x270 [btrfs]
> >>>>>   (...)
> >>>>>   [82039.103050] CPU: 2 PID: 13167 Comm: umount Tainted: G        W=
         5.2.0-rc4-btrfs-next-50 #1
> >>>>>   [82039.103428] Hardware name: QEMU Standard PC (i440FX + PIIX, 19=
96), BIOS rel-1.11.2-0-gf9626ccb91-prebuilt.qemu-project.org 04/01/2014
> >>>>>   [82039.104203] RIP: 0010:btrfs_destroy_inode+0x1ac/0x270 [btrfs]
> >>>>>   (...)
> >>>>>   [82039.105461] RSP: 0018:ffffac0b426a7d30 EFLAGS: 00010206
> >>>>>   [82039.105866] RAX: ffff8ddf77691158 RBX: ffff8dde29b34660 RCX: 0=
000000000000002
> >>>>>   [82039.106270] RDX: 0000000000000000 RSI: 0000000000000001 RDI: f=
fff8dde29b34660
> >>>>>   [82039.106673] RBP: ffff8ddf5fbec000 R08: 0000000000000000 R09: 0=
000000000000000
> >>>>>   [82039.107078] R10: ffffac0b426a7c90 R11: ffffffffb9aad768 R12: f=
fffac0b426a7db0
> >>>>>   [82039.107487] R13: ffff8ddf5fbec0a0 R14: dead000000000100 R15: 0=
000000000000000
> >>>>>   [82039.107894] FS:  00007f8db96d12c0(0000) GS:ffff8de036b00000(00=
00) knlGS:0000000000000000
> >>>>>   [82039.108309] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >>>>>   [82039.108723] CR2: 0000000001416108 CR3: 00000002315cc001 CR4: 0=
0000000003606e0
> >>>>>   [82039.109146] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0=
000000000000000
> >>>>>   [82039.109567] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0=
000000000000400
> >>>>>   [82039.109989] Call Trace:
> >>>>>   [82039.110405]  destroy_inode+0x3b/0x70
> >>>>>   [82039.110830]  btrfs_free_fs_root+0x16/0xa0 [btrfs]
> >>>>>   [82039.111257]  btrfs_free_fs_roots+0xd8/0x160 [btrfs]
> >>>>>   [82039.111675]  ? wait_for_completion+0x65/0x1a0
> >>>>>   [82039.112101]  close_ctree+0x172/0x370 [btrfs]
> >>>>>   [82039.112519]  generic_shutdown_super+0x6c/0x110
> >>>>>   [82039.112988]  kill_anon_super+0xe/0x30
> >>>>>   [82039.113439]  btrfs_kill_super+0x12/0xa0 [btrfs]
> >>>>>   [82039.113861]  deactivate_locked_super+0x3a/0x70
> >>>>>   [82039.114278]  cleanup_mnt+0x3b/0x80
> >>>>>   [82039.114685]  task_work_run+0x93/0xc0
> >>>>>   [82039.115083]  exit_to_usermode_loop+0xfa/0x100
> >>>>>   [82039.115476]  do_syscall_64+0x162/0x1d0
> >>>>>   [82039.115863]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> >>>>>   [82039.116254] RIP: 0033:0x7f8db8fbab37
> >>>>>   (...)
> >>>>>   [82039.117463] RSP: 002b:00007ffdce35b468 EFLAGS: 00000246 ORIG_R=
AX: 00000000000000a6
> >>>>>   [82039.117882] RAX: 0000000000000000 RBX: 0000560d20b00060 RCX: 0=
0007f8db8fbab37
> >>>>>   [82039.118330] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0=
000560d20b00240
> >>>>>   [82039.118743] RBP: 0000560d20b00240 R08: 0000560d20b00270 R09: 0=
000000000000015
> >>>>>   [82039.119159] R10: 00000000000006b4 R11: 0000000000000246 R12: 0=
0007f8db94bce64
> >>>>>   [82039.119574] R13: 0000000000000000 R14: 0000000000000000 R15: 0=
0007ffdce35b6f0
> >>>>>   [82039.119987] irq event stamp: 0
> >>>>>   [82039.120387] hardirqs last  enabled at (0): [<0000000000000000>=
] 0x0
> >>>>>   [82039.120787] hardirqs last disabled at (0): [<ffffffffb7884ff2>=
] copy_process.part.33+0x7f2/0x1f00
> >>>>>   [82039.121182] softirqs last  enabled at (0): [<ffffffffb7884ff2>=
] copy_process.part.33+0x7f2/0x1f00
> >>>>>   [82039.121563] softirqs last disabled at (0): [<0000000000000000>=
] 0x0
> >>>>>   [82039.121933] ---[ end trace f2521afa616ddccd ]---
> >>>>>   [82039.122353] WARNING: CPU: 2 PID: 13167 at fs/btrfs/inode.c:927=
8 btrfs_destroy_inode+0x1bc/0x270 [btrfs]
> >>>>>   (...)
> >>>>>   [82039.124606] CPU: 2 PID: 13167 Comm: umount Tainted: G        W=
         5.2.0-rc4-btrfs-next-50 #1
> >>>>>   [82039.125008] Hardware name: QEMU Standard PC (i440FX + PIIX, 19=
96), BIOS rel-1.11.2-0-gf9626ccb91-prebuilt.qemu-project.org 04/01/2014
> >>>>>   [82039.125801] RIP: 0010:btrfs_destroy_inode+0x1bc/0x270 [btrfs]
> >>>>>   (...)
> >>>>>   [82039.126998] RSP: 0018:ffffac0b426a7d30 EFLAGS: 00010202
> >>>>>   [82039.127399] RAX: ffff8ddf77691158 RBX: ffff8dde29b34660 RCX: 0=
000000000000002
> >>>>>   [82039.127803] RDX: 0000000000000001 RSI: 0000000000000001 RDI: f=
fff8dde29b34660
> >>>>>   [82039.128206] RBP: ffff8ddf5fbec000 R08: 0000000000000000 R09: 0=
000000000000000
> >>>>>   [82039.128611] R10: ffffac0b426a7c90 R11: ffffffffb9aad768 R12: f=
fffac0b426a7db0
> >>>>>   [82039.129020] R13: ffff8ddf5fbec0a0 R14: dead000000000100 R15: 0=
000000000000000
> >>>>>   [82039.129428] FS:  00007f8db96d12c0(0000) GS:ffff8de036b00000(00=
00) knlGS:0000000000000000
> >>>>>   [82039.129846] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >>>>>   [82039.130261] CR2: 0000000001416108 CR3: 00000002315cc001 CR4: 0=
0000000003606e0
> >>>>>   [82039.130684] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0=
000000000000000
> >>>>>   [82039.131142] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0=
000000000000400
> >>>>>   [82039.131561] Call Trace:
> >>>>>   [82039.131990]  destroy_inode+0x3b/0x70
> >>>>>   [82039.132417]  btrfs_free_fs_root+0x16/0xa0 [btrfs]
> >>>>>   [82039.132844]  btrfs_free_fs_roots+0xd8/0x160 [btrfs]
> >>>>>   [82039.133262]  ? wait_for_completion+0x65/0x1a0
> >>>>>   [82039.133688]  close_ctree+0x172/0x370 [btrfs]
> >>>>>   [82039.134157]  generic_shutdown_super+0x6c/0x110
> >>>>>   [82039.134575]  kill_anon_super+0xe/0x30
> >>>>>   [82039.134997]  btrfs_kill_super+0x12/0xa0 [btrfs]
> >>>>>   [82039.135415]  deactivate_locked_super+0x3a/0x70
> >>>>>   [82039.135832]  cleanup_mnt+0x3b/0x80
> >>>>>   [82039.136239]  task_work_run+0x93/0xc0
> >>>>>   [82039.136637]  exit_to_usermode_loop+0xfa/0x100
> >>>>>   [82039.137029]  do_syscall_64+0x162/0x1d0
> >>>>>   [82039.137418]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> >>>>>   [82039.137812] RIP: 0033:0x7f8db8fbab37
> >>>>>   (...)
> >>>>>   [82039.139059] RSP: 002b:00007ffdce35b468 EFLAGS: 00000246 ORIG_R=
AX: 00000000000000a6
> >>>>>   [82039.139475] RAX: 0000000000000000 RBX: 0000560d20b00060 RCX: 0=
0007f8db8fbab37
> >>>>>   [82039.139890] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0=
000560d20b00240
> >>>>>   [82039.140302] RBP: 0000560d20b00240 R08: 0000560d20b00270 R09: 0=
000000000000015
> >>>>>   [82039.140719] R10: 00000000000006b4 R11: 0000000000000246 R12: 0=
0007f8db94bce64
> >>>>>   [82039.141138] R13: 0000000000000000 R14: 0000000000000000 R15: 0=
0007ffdce35b6f0
> >>>>>   [82039.141597] irq event stamp: 0
> >>>>>   [82039.142043] hardirqs last  enabled at (0): [<0000000000000000>=
] 0x0
> >>>>>   [82039.142443] hardirqs last disabled at (0): [<ffffffffb7884ff2>=
] copy_process.part.33+0x7f2/0x1f00
> >>>>>   [82039.142839] softirqs last  enabled at (0): [<ffffffffb7884ff2>=
] copy_process.part.33+0x7f2/0x1f00
> >>>>>   [82039.143220] softirqs last disabled at (0): [<0000000000000000>=
] 0x0
> >>>>>   [82039.143588] ---[ end trace f2521afa616ddcce ]---
> >>>>>   [82039.167472] WARNING: CPU: 3 PID: 13167 at fs/btrfs/extent-tree=
.c:10120 btrfs_free_block_groups+0x30d/0x460 [btrfs]
> >>>>>   (...)
> >>>>>   [82039.173800] CPU: 3 PID: 13167 Comm: umount Tainted: G        W=
         5.2.0-rc4-btrfs-next-50 #1
> >>>>>   [82039.174847] Hardware name: QEMU Standard PC (i440FX + PIIX, 19=
96), BIOS rel-1.11.2-0-gf9626ccb91-prebuilt.qemu-project.org 04/01/2014
> >>>>>   [82039.177031] RIP: 0010:btrfs_free_block_groups+0x30d/0x460 [btr=
fs]
> >>>>>   (...)
> >>>>>   [82039.180397] RSP: 0018:ffffac0b426a7dd8 EFLAGS: 00010206
> >>>>>   [82039.181574] RAX: ffff8de010a1db40 RBX: ffff8de010a1db40 RCX: 0=
000000000170014
> >>>>>   [82039.182711] RDX: ffff8ddff4380040 RSI: ffff8de010a1da58 RDI: 0=
000000000000246
> >>>>>   [82039.183817] RBP: ffff8ddf5fbec000 R08: 0000000000000000 R09: 0=
000000000000000
> >>>>>   [82039.184925] R10: ffff8de036404380 R11: ffffffffb8a5ea00 R12: f=
fff8de010a1b2b8
> >>>>>   [82039.186090] R13: ffff8de010a1b2b8 R14: 0000000000000000 R15: d=
ead000000000100
> >>>>>   [82039.187208] FS:  00007f8db96d12c0(0000) GS:ffff8de036b80000(00=
00) knlGS:0000000000000000
> >>>>>   [82039.188345] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >>>>>   [82039.189481] CR2: 00007fb044005170 CR3: 00000002315cc006 CR4: 0=
0000000003606e0
> >>>>>   [82039.190674] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0=
000000000000000
> >>>>>   [82039.191829] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0=
000000000000400
> >>>>>   [82039.192978] Call Trace:
> >>>>>   [82039.194160]  close_ctree+0x19a/0x370 [btrfs]
> >>>>>   [82039.195315]  generic_shutdown_super+0x6c/0x110
> >>>>>   [82039.196486]  kill_anon_super+0xe/0x30
> >>>>>   [82039.197645]  btrfs_kill_super+0x12/0xa0 [btrfs]
> >>>>>   [82039.198696]  deactivate_locked_super+0x3a/0x70
> >>>>>   [82039.199619]  cleanup_mnt+0x3b/0x80
> >>>>>   [82039.200559]  task_work_run+0x93/0xc0
> >>>>>   [82039.201505]  exit_to_usermode_loop+0xfa/0x100
> >>>>>   [82039.202436]  do_syscall_64+0x162/0x1d0
> >>>>>   [82039.203339]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> >>>>>   [82039.204091] RIP: 0033:0x7f8db8fbab37
> >>>>>   (...)
> >>>>>   [82039.206360] RSP: 002b:00007ffdce35b468 EFLAGS: 00000246 ORIG_R=
AX: 00000000000000a6
> >>>>>   [82039.207132] RAX: 0000000000000000 RBX: 0000560d20b00060 RCX: 0=
0007f8db8fbab37
> >>>>>   [82039.207906] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0=
000560d20b00240
> >>>>>   [82039.208621] RBP: 0000560d20b00240 R08: 0000560d20b00270 R09: 0=
000000000000015
> >>>>>   [82039.209285] R10: 00000000000006b4 R11: 0000000000000246 R12: 0=
0007f8db94bce64
> >>>>>   [82039.209984] R13: 0000000000000000 R14: 0000000000000000 R15: 0=
0007ffdce35b6f0
> >>>>>   [82039.210642] irq event stamp: 0
> >>>>>   [82039.211306] hardirqs last  enabled at (0): [<0000000000000000>=
] 0x0
> >>>>>   [82039.211971] hardirqs last disabled at (0): [<ffffffffb7884ff2>=
] copy_process.part.33+0x7f2/0x1f00
> >>>>>   [82039.212643] softirqs last  enabled at (0): [<ffffffffb7884ff2>=
] copy_process.part.33+0x7f2/0x1f00
> >>>>>   [82039.213304] softirqs last disabled at (0): [<0000000000000000>=
] 0x0
> >>>>>   [82039.213875] ---[ end trace f2521afa616ddccf ]---
> >>>>>
> >>>>> Fix this by releasing the reserved metadata on failure to allocate =
data
> >>>>> extent(s) for the inode cache.
> >>>>>
> >>>>> Fixes: 69fe2d75dd91d0 ("btrfs: make the delalloc block rsv per inod=
e")
> >>>>> Signed-off-by: Filipe Manana <fdmanana@suse.com>> ---
> >>>>>  fs/btrfs/inode-map.c | 1 +
> >>>>>  1 file changed, 1 insertion(+)
> >>>>>
> >>>>> diff --git a/fs/btrfs/inode-map.c b/fs/btrfs/inode-map.c
> >>>>> index 4a5882665f8a..b210e8929c28 100644
> >>>>> --- a/fs/btrfs/inode-map.c
> >>>>> +++ b/fs/btrfs/inode-map.c
> >>>>> @@ -485,6 +485,7 @@ int btrfs_save_ino_cache(struct btrfs_root *roo=
t,
> >>>>>                                             prealloc, prealloc, &al=
loc_hint);
> >>>>>       if (ret) {
> >>>>>               btrfs_delalloc_release_extents(BTRFS_I(inode), preall=
oc, true);
> >>>>> +             btrfs_delalloc_release_metadata(BTRFS_I(inode), preal=
loc, true);
> >>>>
> >>>> I think the correct freeing function is btrfs_delalloc_release_space
> >>>> here instead of just releasing the metadata.
> >>>
> >>> No, that won't work. Tried that before and it gives this:
> >>
> >> Be that as it may, but what reverts the actions taken in
> >> btrfs_check_data_free_space - it doesn't just allocated a data chunk b=
ut
> >> also modifies qgroups counts and data space_info struct.
> >>
> >> btrfs_free_reserved_data_space_noquota in turn reverts data_space_info
> >> changes. And in case of quotas being enabled we will also screw the
> >> accounting.
> >
> > Things have always been screwed up with quotas enabled.
> > All tests that enable qgroups fail when using the inode cache, and
> > it's been like that for several years at least.
> > I'm not trying to fix that here, nor in any other patch, just fixing a
> > specific error path triggered
> > by some tests that don't enable qgroups.
>
> Even if we ignore the quota side of the problem, the issue about data
> space_info->bytes_may_use modification in
>
> btrfs_check_data_free_space
>  btrfs_alloc_data_chunk_ondemand
>    btrfs_space_info_update_bytes_may_use
>
> is still not revert in the failure case.

Nikolay,

The bytes_may_use counter gets decremented once the extent is allocated.
If we were leaking it, we would see a trace when unmounting the
filesystem, and I certainly wouldn't send this patch trading a few
warnings for another one.

Thanks.

>
> >
> > Thanks.
> >
> >>
> >>
> >>
> >> <snip>
> >
