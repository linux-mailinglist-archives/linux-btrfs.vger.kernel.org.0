Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2F6629643
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 11:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238426AbiKOKuP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 05:50:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238418AbiKOKtp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 05:49:45 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD29222A6;
        Tue, 15 Nov 2022 02:49:17 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id f18so2019939ejz.5;
        Tue, 15 Nov 2022 02:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=33zHiIrdoO2UoepEKyRaRVdNZjEtu5CN9IjvFX3uaZY=;
        b=a/Z4RknSI4n/gL/3utpF34Cu0NwOZPjRvDi+zJPjyVKY7THXua0NBOIQhwz9fIVJWo
         Jb6QmFiSdNNkhSBMNlTLhe6MiU2HLe7LX6pnorP+5w1VyJfBxu1p5nUJr9bEx7YpxKqt
         fqpFafed54nyjZ9gQLBU+duXWFm+8YiGySxzVjOnk4RwDuzo8MEQmKj2DvvNasGn+b5O
         31ti/khuiTs+WlanpnUAiswXLvrGy+YCPzJV63Ng8Ad+ML8Vt+iITynw3NiwKBQuXdv0
         8mg9BwMasinLaVn7kGILzrw+LbmnuvMYUqD4ExY1erHm6bmxpQKgx7MxTdCzIT/B/SKe
         F4QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=33zHiIrdoO2UoepEKyRaRVdNZjEtu5CN9IjvFX3uaZY=;
        b=SDLIq2Xz14GaKApYYD5hO8t521wpDO6ZJ/QAjKykCvG9aBdbI3iJnkz1XA+G2OYdZP
         k3cn0sKNiPScObs65dxQYFuSn4e6TzEGV9xJQ28CdbhoYYShlSFZemcRc7U4JfBOHiic
         ZSuDtw2q6oxr9H6GJTAex2v3lDLjxQC89ejuodf9K38G62VZHaCzTjRzTEarAqg7wFdo
         9ARQ9ROnXs+znU9hZZQ5+XGGjcWGsWxM6x0qhBjDN5Tji9+HK+bNpczjgY2EiNlQFdJR
         SBbq5MYaUeHF5A7MbCBcPDox9fCNaJx87hJaP9gclhLLxFuQ0XcP81iBZEYPUS2qY9dW
         mrEA==
X-Gm-Message-State: ANoB5pmEvcbcYIuT7QNR4LjWYPRyTZw8OTYK6sbhfuMEuf3iU2aFPqE/
        UqSwtNILi7pxw2e40Qs/MNaP9030MPkgudiWWQc=
X-Google-Smtp-Source: AA0mqf7VQd6NqiHNZvwJElD1AdeJDi59NNAZHAGxCxrMukzHvAhyn/kRvkqAQl56Oc0spwQJfd++oHeTKovQ5w1t+kE=
X-Received: by 2002:a17:906:2b94:b0:7ae:5ad1:e834 with SMTP id
 m20-20020a1709062b9400b007ae5ad1e834mr13065298ejg.312.1668509355655; Tue, 15
 Nov 2022 02:49:15 -0800 (PST)
MIME-Version: 1.0
References: <CAO4mrfdLsMZT1ytmTCK4m0xXezxskTUbQjqZoGobMVhnZgdfmw@mail.gmail.com>
 <CAO4mrfcYtXiuuaPtm==heNarkMqTUGoKWxnmiOC3jvhfjeOBFg@mail.gmail.com> <08a18fd6-3ce8-a063-90cf-e659004d0894@gmx.com>
In-Reply-To: <08a18fd6-3ce8-a063-90cf-e659004d0894@gmx.com>
From:   Wei Chen <harperchen1110@gmail.com>
Date:   Tue, 15 Nov 2022 18:48:40 +0800
Message-ID: <CAO4mrfcnodR8csMs7s8SCgE5k7LEk2emhEJSaKs7+Ye3NzaXGQ@mail.gmail.com>
Subject: Re: WARNING in _btrfs_ioctl_set_received_subvol
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        osandov@fb.com, sweettea-kernel@dorminy.me,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Dear Linux developers,

Thank you for the advice. Please find the crash report in the upstream
release v6.0.0 below.

[   93.080051][ T8445] Kernel panic - not syncing: panic_on_warn set ...
[   93.080584][ T8445] CPU: 0 PID: 8445 Comm: a.out Not tainted 6.0.0+ #39
[   93.081120][ T8445] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
[   93.081919][ T8445] Call Trace:
[   93.082209][ T8445]  <TASK>
[   93.082478][ T8445]  dump_stack_lvl+0x1b1/0x28e
[   93.082897][ T8445]  ? io_alloc_page_table+0xfe/0xfe
[   93.083340][ T8445]  ? panic+0x81b/0x81b
[   93.083709][ T8445]  ? _btrfs_ioctl_set_received_subvol+0xbe0/0x1660
[   93.084260][ T8445]  panic+0x2c2/0x81b
[   93.084597][ T8445]  ? __warn+0x131/0x220
[   93.084955][ T8445]  ? asan.module_ctor+0x4/0x4
[   93.085379][ T8445]  ? _btrfs_ioctl_set_received_subvol+0xc93/0x1660
[   93.085933][ T8445]  __warn+0x1fc/0x220
[   93.086282][ T8445]  ? _btrfs_ioctl_set_received_subvol+0xc93/0x1660
[   93.086744][ T8445]  report_bug+0x1b3/0x2d0
[   93.087034][ T8445]  handle_bug+0x3d/0x70
[   93.087345][ T8445]  exc_invalid_op+0x16/0x40
[   93.087708][ T8445]  asm_exc_invalid_op+0x16/0x20
[   93.088121][ T8445] RIP: 0010:_btrfs_ioctl_set_received_subvol+0xc93/0x1660
[   93.088707][ T8445] Code: 76 e6 8a 44 89 fa 31 c0 e8 9f 55 a6 06 4c
8b 6c 24 10 eb 18 e8 7e 3a 04 fe 48 c7 c7 20 75 e6 8a 44 89 fe 31 c0
e8 fd b4 cd fd <0f> 0b 4c 89 ef 48 c7 c6 c0 87 e6 8a ba f6 12 00 00 e9
a7 06 00 00
[   93.090000][ T8445] RSP: 0018:ffffc9000280f7a8 EFLAGS: 00010246
[   93.090524][ T8445] RAX: cceb294c9a36ee00 RBX: ffff88802b27c001
RCX: ffff88801e0cc880
[   93.091197][ T8445] RDX: 0000000000000000 RSI: 0000000080000000
RDI: 0000000000000000
[   93.091833][ T8445] RBP: 00000000fffffff4 R08: ffffffff816b75fc
R09: ffffed100c784f14
[   93.092488][ T8445] R10: ffffed100c784f14 R11: 0000000000000000
R12: ffff88802c664440
[   93.093079][ T8445] R13: ffff88802c6643f0 R14: 1ffff110058cc888
R15: 00000000fffffff4
[   93.093585][ T8445]  ? __wake_up_klogd+0xcc/0x100
[   93.094019][ T8445]  ? _btrfs_ioctl_set_received_subvol+0xc93/0x1660
[   93.094542][ T8445]  btrfs_ioctl+0x1cf0/0x9db0
[   93.094858][ T8445]  ? btrfs_ioctl_get_supported_features+0x40/0x40
[   93.095352][ T8445]  ? lockdep_hardirqs_on_prepare+0x428/0x790
[   93.095870][ T8445]  ? rcu_read_lock_sched_held+0x87/0x110
[   93.096361][ T8445]  ? __bpf_trace_rcu_stall_warning+0x10/0x10
[   93.096887][ T8445]  ? lockdep_hardirqs_on_prepare+0x428/0x790
[   93.097401][ T8445]  ? do_vfs_ioctl+0xc35/0x29e0
[   93.097853][ T8445]  ? __ia32_compat_sys_ioctl+0xb90/0xb90
[   93.098321][ T8445]  ? __lock_acquire+0x6080/0x6080
[   93.098754][ T8445]  ? slab_free_freelist_hook+0x12e/0x1a0
[   93.099216][ T8445]  ? tomoyo_path_number_perm+0x5be/0x790
[   93.099668][ T8445]  ? kfree+0xda/0x350
[   93.100028][ T8445]  ? tomoyo_path_number_perm+0x627/0x790
[   93.100500][ T8445]  ? tomoyo_check_path_acl+0x1c0/0x1c0
[   93.100967][ T8445]  ? rcu_read_lock_sched_held+0x87/0x110
[   93.101502][ T8445]  ? lockdep_hardirqs_on_prepare+0x428/0x790
[   93.101995][ T8445]  ? print_irqtrace_events+0x220/0x220
[   93.102327][ T8445]  ? vtime_user_exit+0x2b2/0x3e0
[   93.102647][ T8445]  ? __ct_user_exit+0xd9/0x160
[   93.102946][ T8445]  ? bpf_lsm_file_ioctl+0x5/0x10
[   93.103249][ T8445]  ? security_file_ioctl+0x9d/0xb0
[   93.103566][ T8445]  ? btrfs_ioctl_get_supported_features+0x40/0x40
[   93.103953][ T8445]  __se_sys_ioctl+0xfb/0x170
[   93.104232][ T8445]  do_syscall_64+0x3d/0x90
[   93.104501][ T8445]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   93.104855][ T8445] RIP: 0033:0x7fbfad8e4469
[   93.105126][ T8445] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f
1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b
4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d ff 49 2b 00 f7 d8
64 89 01 48
[   93.106297][ T8445] RSP: 002b:00007fffb93a1248 EFLAGS: 00000202
ORIG_RAX: 0000000000000010
[   93.106853][ T8445] RAX: ffffffffffffffda RBX: 0000000000000000
RCX: 00007fbfad8e4469
[   93.107377][ T8445] RDX: 0000000020072c40 RSI: 00000000c0c09425
RDI: 0000000000000006
[   93.107901][ T8445] RBP: 00007fffb93a1260 R08: 0000000000000001
R09: 00007fffb93a1260
[   93.108441][ T8445] R10: 0000000000000001 R11: 0000000000000202
R12: 00005650a6c01170
[   93.108933][ T8445] R13: 00007fffb93a13a0 R14: 0000000000000000
R15: 0000000000000000
[   93.109418][ T8445]  </TASK>
[   93.109843][ T8445] Kernel Offset: disabled
[   93.110188][ T8445] Rebooting in 86400 seconds..

Best,
Wei

On Tue, 15 Nov 2022 at 18:42, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2022/11/15 18:30, Wei Chen wrote:
> > Dear Linux developers,
> >
> > I hope the following bug report is helpful.
> >
> > Best,
> > Wei
> >
> > On Sun, 13 Nov 2022 at 19:38, Wei Chen <harperchen1110@gmail.com> wrote:
> >>
> >> Dear Linux Developer,
> >>
> >> Recently when using our tool to fuzz kernel, the following crash was
> >> triggered. The bug persists in Linux 6.0.
> >>
> >> HEAD commit:  4f5365f77018  Linux 5.15.76
>
> Not related to the bug itself, but more on the report.
>
> I'd say, if the bug persists in the latest release, then please use the
> latest kernel in the report.
> Not use the latest LTS as the commit.
>
> You know most (if not all) linux communities are working on upstream
> code, not some LTS branch.
>
> Thanks,
> Qu
>
> >> git tree: stable
> >> compiler: gcc 7.5.0
> >> console output:
> >> https://drive.google.com/file/d/1wkzu8jz6edriSP6TpsCGYD5AzkLajIEv/view?usp=share_link
> >> kernel config: https://drive.google.com/file/d/1flhc33savDkmYN6PRU5C2vXDX0LAKMvM/view?usp=share_link
> >> C reproducer: https://drive.google.com/file/d/1zKWsWAOcaHfPKewTG6P3pnnVfwH_WXa9/view?usp=share_link
> >> Syz reproducer:
> >> https://drive.google.com/file/d/1jUR8_6Re4xpJhyLdXqPiiV72WT-Tk8A-/view?usp=share_link
> >>
> >> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> >> Reported-by: Wei Chen <harperchen1110@gmail.com>
> >>
> >> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000007
> >> R13: 0000000000000000 R14: 000000000077bf80 R15: 00007ffd3c817900
> >>   </TASK>
> >> ------------[ cut here ]------------
> >> WARNING: CPU: 1 PID: 29222 at fs/btrfs/ioctl.c:4521
> >> _btrfs_ioctl_set_received_subvol+0x221/0x430 fs/btrfs/ioctl.c:4521
> >> Modules linked in:
> >> CPU: 1 PID: 29222 Comm: syz-executor.0 Not tainted 5.15.76 #5
> >> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> >> rel-1.13.0-48-gd9c812dda519-prebuilt.qemu.org 04/01/2014
> >> RIP: 0010:_btrfs_ioctl_set_received_subvol+0x221/0x430 fs/btrfs/ioctl.c:4521
> >> Code: e8 74 34 44 ff 83 fb fb 0f 84 de 01 00 00 83 fb e2 0f 84 d5 01
> >> 00 00 e8 5d 34 44 ff 89 de 48 c7 c7 c0 f8 39 85 e8 9f dc 2e ff <0f> 0b
> >> e8 48 34 44 ff 89 d9 ba a9 11 00 00 e9 45 01 00 00 49 8b 4f
> >> RSP: 0018:ffffc9000aecfd40 EFLAGS: 00010286
> >> RAX: 0000000000000000 RBX: fffffffffffffff4 RCX: ffffc900013ed000
> >> RDX: 0000000000040000 RSI: ffffffff812d935c RDI: 00000000ffffffff
> >> RBP: ffffc9000aecfda0 R08: 0000000000000000 R09: 0000000000000001
> >> R10: ffffc9000aecfbe0 R11: 0000000000000003 R12: ffff888014210400
> >> R13: ffff8880208d2000 R14: ffff88810c4f21c0 R15: ffff88810f37b600
> >> FS:  00007f41ffc27700(0000) GS:ffff88813dc00000(0000) knlGS:0000000000000000
> >> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> CR2: 00007fab915f7008 CR3: 000000002096e000 CR4: 00000000003526e0
> >> Call Trace:
> >>   <TASK>
> >>   btrfs_ioctl_set_received_subvol_32 fs/btrfs/ioctl.c:4584 [inline]
> >>   btrfs_ioctl+0x2154/0x3d50 fs/btrfs/ioctl.c:5007
> >>   vfs_ioctl fs/ioctl.c:51 [inline]
> >>   __do_sys_ioctl fs/ioctl.c:874 [inline]
> >>   __se_sys_ioctl fs/ioctl.c:860 [inline]
> >>   __x64_sys_ioctl+0xb6/0x100 fs/ioctl.c:860
> >>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >>   do_syscall_64+0x34/0xb0 arch/x86/entry/common.c:80
> >>   entry_SYSCALL_64_after_hwframe+0x61/0xcb
> >> RIP: 0033:0x4697f9
> >> Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48
> >> 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
> >> 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
> >> RSP: 002b:00007f41ffc26c48 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> >> RAX: ffffffffffffffda RBX: 000000000077bf80 RCX: 00000000004697f9
> >> RDX: 0000000020072c40 RSI: 00000000c0c09425 RDI: 0000000000000005
> >> RBP: 00007f41ffc26c80 R08: 0000000000000000 R09: 0000000000000000
> >> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000007
> >> R13: 0000000000000000 R14: 000000000077bf80 R15: 00007ffd3c817900
> >>   </TASK>
> >>
> >> Best,
> >> Wei
