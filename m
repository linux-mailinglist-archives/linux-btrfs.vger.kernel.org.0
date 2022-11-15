Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 596B96295E2
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 11:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237987AbiKOKcJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 05:32:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237900AbiKOKcI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 05:32:08 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65AA123154;
        Tue, 15 Nov 2022 02:32:06 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id m22so34868321eji.10;
        Tue, 15 Nov 2022 02:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z1PDWh2BPoh4gWyjuYxNmovlz+yfeJ1CuwMYyoCNxOY=;
        b=L9bRyDLV/Tk1AhwKAGbs7i2o7ZN8OfdmUK/rRzi96hy8PuyV+BixuoaooonSyW/gmx
         pQEuyT2vDgV3ylVn1sjs+X47HpCyUYG7oUx0kRRdC+QN4UEcPeLqYsuTcPPHZ96sRI6O
         OQ8psYFlkwJeeCLYY5ih9KpaGNExPvHkaUjPZ1SX0oXPRbHzm7df6IwtwEl8kkCu0kDc
         lXpaTUuU4qFWwd49sGBhI7Hg1xdvqA1QQbJa7Eg+AmZ6qRSsG3XlEWqMIKosGbSpFU+A
         QZVgm7G2rpUUholT1vuBcR8MyxIBaEdUONvNiCAHG0J9CvOoY+37JzKkOAO4w02xo9LH
         DMxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z1PDWh2BPoh4gWyjuYxNmovlz+yfeJ1CuwMYyoCNxOY=;
        b=AhiCSloTZP6zYcfhboLMtdrNgOZMF8zO3DQCmiqRwGfheU0O1ft6DPOWj9wEuQOF3h
         g+F+zVJAYwRiAboJOV0NmHZkeH2d1q3HGMBNfkW7v8o9ULE/cS0tRmKHCai4UIJ62g43
         7d7m1QrGSUpOXYrNc64zFNttuwLuZj64ekaxbVtaRF+ME1kTiJJkuC34rsy+0Wl6g42e
         MjxjdTNRQHNIpPrTwf8g7NzKRoLJoOXCdbnBN1/j1ZnV3zGXWB1UHnMpViLRGGFbB9vY
         npwu52zE1JIaGv9OP9r2DemxrLIoLtzcngKG77auRDID1iP39XbzsL3hTuP9Quie5Wn9
         Xf2w==
X-Gm-Message-State: ANoB5plEryV5OUGIZtP5/Ny5quoeEIothOA7Y0IpoegTSc5d9s7xSKYq
        no+t5TNUvdf578ZJAFrD/p5MT8w7iIXZK38DtjOGALonQX7yzQ==
X-Google-Smtp-Source: AA0mqf6pfuLne0GGWqow6tevFnHLK65MfI56dJvJYQnbWNWlw0HjbcveyufEimIjE0G9BP4pRisHIVOUA4G4C9LeEoE=
X-Received: by 2002:a17:906:594f:b0:78d:b695:1d68 with SMTP id
 g15-20020a170906594f00b0078db6951d68mr13340105ejr.235.1668508324781; Tue, 15
 Nov 2022 02:32:04 -0800 (PST)
MIME-Version: 1.0
References: <CAO4mrff-w=CzU50Pivy63hCkN3CGZuus9_X1gp38jrAjt+zDHw@mail.gmail.com>
In-Reply-To: <CAO4mrff-w=CzU50Pivy63hCkN3CGZuus9_X1gp38jrAjt+zDHw@mail.gmail.com>
From:   Wei Chen <harperchen1110@gmail.com>
Date:   Tue, 15 Nov 2022 18:31:29 +0800
Message-ID: <CAO4mrffs=zjgdoAbr=j3tfaEsqUOAB+jPO5-_HTKWQ2zdjApog@mail.gmail.com>
Subject: Re: WARNING in btrfs_rename2
To:     clm@fb.com, josef@toxicpanda.com, linux-kernel@vger.kernel.org,
        dsterba@suse.com, linux-btrfs@vger.kernel.org, osandov@fb.com,
        sweettea-kernel@dorminy.me, syzkaller-bugs@googlegroups.com
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

I hope the following bug report is helpful.

Best,
Wei

On Sat, 5 Nov 2022 at 17:26, Wei Chen <harperchen1110@gmail.com> wrote:
>
> Dear Linux Developer,
>
> Recently when using our tool to fuzz kernel, the following crash was
> triggered. The bug persists in Linux 6.0.
>
> HEAD commit:  4f5365f77018  Linux 5.15.76
> git tree: stable
> compiler: gcc 7.5.0
> console output:
> https://drive.google.com/file/d/13yLtjGuaSn1yXSDKHvljVv0E7fCFr9Rk/view?usp=share_link
> kernel config: https://drive.google.com/file/d/1flhc33savDkmYN6PRU5C2vXDX0LAKMvM/view?usp=share_link
> C reproducer: https://drive.google.com/file/d/1-feRs7-HKy0GK-5ohB0K7N650p5hwvIs/view?usp=share_link
> Syz reproducer:
> https://drive.google.com/file/d/11mlL25Wi6FDhAqdB09Rs0whf2BwaDRmd/view?usp=share_link
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: Wei Chen <harperchen1110@gmail.com>
>
> [ 1902.364247][ T8409] WARNING: CPU: 0 PID: 8409 at
> fs/btrfs/inode.c:9249 btrfs_rename_exchange+0x1940/0x1a80
> [ 1902.365033][ T8409] Modules linked in:
> [ 1902.366506][ T8409] CPU: 0 PID: 8409 Comm: a.out Not tainted 6.0.0+ #36
> [ 1902.366977][ T8409] Hardware name: QEMU Standard PC (i440FX + PIIX,
> 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
> [ 1902.368751][ T8409] RIP: 0010:btrfs_rename_exchange+0x1940/0x1a80
> [ 1902.369207][ T8409] Code: c6 40 59 e5 8a 44 89 fa 31 c0 e8 60 ae b1
> 06 e9 d9 fd ff ff e8 41 93 0f fe 48 c7 c7 20 58 e5 8a 44 89 fe 31 c0
> e8 c0 0d d9 fd <0f> 0b 4c 8b 74 24 08 4c 89 f7 48 c7 c6 e0 86 e5 8a ba
> 21 24 00 00
> [ 1902.375785][ T8409] RSP: 0018:ffffc9000a3078a0 EFLAGS: 00010246
> [ 1902.376240][ T8409] RAX: a789841e5e599800 RBX: dffffc0000000000
> RCX: ffff88801bd4a440
> [ 1902.376755][ T8409] RDX: 0000000000000000 RSI: 0000000080000000
> RDI: 0000000000000000
> [ 1902.379309][ T8409] RBP: ffffc9000a307a98 R08: ffffffff816b75fc
> R09: ffffed100c784f14
> [ 1902.381635][ T8409] R10: ffffed100c784f14 R11: 0000000000000000
> R12: ffff88802d4c4001
> [ 1902.382185][ T8409] R13: 1ffff110059c3c34 R14: ffff88802ce1e1a0
> R15: 00000000fffffff4
> [ 1902.383843][ T8409] FS:  00007f5309be8700(0000)
> GS:ffff888063c00000(0000) knlGS:0000000000000000
> [ 1902.384458][ T8409] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1902.386314][ T8409] CR2: 00007ffc9b9ccdcc CR3: 000000002ab2f000
> CR4: 0000000000750ef0
> [ 1902.386851][ T8409] DR0: 0000000000000000 DR1: 0000000000000000
> DR2: 0000000000000000
> [ 1902.387938][ T8409] DR3: 0000000000000000 DR6: 00000000fffe0ff0
> DR7: 0000000000000400
> [ 1902.388519][ T8409] PKRU: 55555554
> [ 1902.388773][ T8409] Call Trace:
> [ 1902.389020][ T8409]  <TASK>
> [ 1902.389235][ T8409]  ? btrfs_create_common+0x420/0x420
> [ 1902.393268][ T8409]  ? vfs_rename+0x6f8/0x12e0
> [ 1902.393592][ T8409]  ? do_raw_spin_lock+0x151/0x8e0
> [ 1902.396081][ T8409]  ? __lock_acquire+0x6080/0x6080
> [ 1902.396414][ T8409]  ? down_write_nested+0x116/0x180
> [ 1902.396746][ T8409]  ? down_read_non_owner+0xa0/0xa0
> [ 1902.397077][ T8409]  ? do_raw_spin_unlock+0x53/0x8a0
> [ 1902.398551][ T8409]  btrfs_rename2+0x86/0xf0
> [ 1902.398889][ T8409]  ? btrfs_mknod+0x100/0x100
> [ 1902.399196][ T8409]  vfs_rename+0xdb6/0x12e0
> [ 1902.399499][ T8409]  ? __ia32_sys_link+0x90/0x90
> [ 1902.403865][ T8409]  ? d_splice_alias+0x126/0x570
> [ 1902.404213][ T8409]  ? _raw_spin_unlock+0x24/0x40
> [ 1902.404530][ T8409]  ? security_path_rename+0x1ab/0x230
> [ 1902.404879][ T8409]  do_renameat2+0xce3/0x1350
> [ 1902.406307][ T8409]  ? fsnotify_move+0x4e0/0x4e0
> [ 1902.406631][ T8409]  ? check_heap_object+0x1b0/0x360
> [ 1902.406993][ T8409]  ? __check_object_size+0x15b/0x220
> [ 1902.408485][ T8409]  ? strncpy_from_user+0x1e6/0x340
> [ 1902.408847][ T8409]  __x64_sys_renameat2+0xce/0xe0
> [ 1902.409171][ T8409]  do_syscall_64+0x3d/0x90
> [ 1902.409464][ T8409]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> [ 1902.413074][ T8409] RIP: 0033:0x7f53090e4469
> [ 1902.413369][ T8409] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f
> 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b
> 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d ff 49 2b 00 f7 d8
> 64 89 01 48
> [ 1902.416768][ T8409] RSP: 002b:00007ffc1afb3f38 EFLAGS: 00000206
> ORIG_RAX: 000000000000013c
> [ 1902.417295][ T8409] RAX: ffffffffffffffda RBX: 0000000000000000
> RCX: 00007f53090e4469
> [ 1902.417791][ T8409] RDX: 0000000000000003 RSI: 00000000200000c0
> RDI: 0000000000000005
> [ 1902.419402][ T8409] RBP: 00007ffc1afb3f50 R08: 0000000000000002
> R09: 00007ffc1afb3f50
> [ 1902.419910][ T8409] R10: 00000000200004c0 R11: 0000000000000206
> R12: 0000558a65401170
> [ 1902.420402][ T8409] R13: 00007ffc1afb4090 R14: 0000000000000000
> R15: 0000000000000000
> [ 1902.424733][ T8409]  </TASK>
> [ 1902.424949][ T8409] Kernel panic - not syncing: panic_on_warn set ...
> [ 1902.425362][ T8409] CPU: 0 PID: 8409 Comm: a.out Not tainted 6.0.0+ #36
> [ 1902.425793][ T8409] Hardware name: QEMU Standard PC (i440FX + PIIX,
> 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
> [ 1902.426400][ T8409] Call Trace:
> [ 1902.426607][ T8409]  <TASK>
> [ 1902.426802][ T8409]  dump_stack_lvl+0x1b1/0x28e
> [ 1902.427129][ T8409]  ? io_alloc_page_table+0xfe/0xfe
> [ 1902.427461][ T8409]  ? panic+0x81b/0x81b
> [ 1902.427734][ T8409]  ? btrfs_rename_exchange+0x1850/0x1a80
> [ 1902.428100][ T8409]  panic+0x2c2/0x81b
> [ 1902.428369][ T8409]  ? __warn+0x131/0x220
> [ 1902.428665][ T8409]  ? asan.module_ctor+0x4/0x4
> [ 1902.428982][ T8409]  ? btrfs_rename_exchange+0x1940/0x1a80
> [ 1902.429342][ T8409]  __warn+0x1fc/0x220
> [ 1902.429604][ T8409]  ? btrfs_rename_exchange+0x1940/0x1a80
> [ 1902.429967][ T8409]  report_bug+0x1b3/0x2d0
> [ 1902.430284][ T8409]  handle_bug+0x3d/0x70
> [ 1902.430550][ T8409]  exc_invalid_op+0x16/0x40
> [ 1902.430859][ T8409]  asm_exc_invalid_op+0x16/0x20
> [ 1902.431172][ T8409] RIP: 0010:btrfs_rename_exchange+0x1940/0x1a80
> [ 1902.431566][ T8409] Code: c6 40 59 e5 8a 44 89 fa 31 c0 e8 60 ae b1
> 06 e9 d9 fd ff ff e8 41 93 0f fe 48 c7 c7 20 58 e5 8a 44 89 fe 31 c0
> e8 c0 0d d9 fd <0f> 0b 4c 8b 74 24 08 4c 89 f7 48 c7 c6 e0 86 e5 8a ba
> 21 24 00 00
> [ 1902.432768][ T8409] RSP: 0018:ffffc9000a3078a0 EFLAGS: 00010246
> [ 1902.433148][ T8409] RAX: a789841e5e599800 RBX: dffffc0000000000
> RCX: ffff88801bd4a440
> [ 1902.433635][ T8409] RDX: 0000000000000000 RSI: 0000000080000000
> RDI: 0000000000000000
> [ 1902.434120][ T8409] RBP: ffffc9000a307a98 R08: ffffffff816b75fc
> R09: ffffed100c784f14
> [ 1902.434606][ T8409] R10: ffffed100c784f14 R11: 0000000000000000
> R12: ffff88802d4c4001
> [ 1902.435098][ T8409] R13: 1ffff110059c3c34 R14: ffff88802ce1e1a0
> R15: 00000000fffffff4
> [ 1902.435589][ T8409]  ? __wake_up_klogd+0xcc/0x100
> [ 1902.435954][ T8409]  ? btrfs_create_common+0x420/0x420
> [ 1902.436303][ T8409]  ? vfs_rename+0x6f8/0x12e0
> [ 1902.436601][ T8409]  ? do_raw_spin_lock+0x151/0x8e0
> [ 1902.436917][ T8409]  ? __lock_acquire+0x6080/0x6080
> [ 1902.437240][ T8409]  ? down_write_nested+0x116/0x180
> [ 1902.437565][ T8409]  ? down_read_non_owner+0xa0/0xa0
> [ 1902.437883][ T8409]  ? do_raw_spin_unlock+0x53/0x8a0
> [ 1902.438204][ T8409]  btrfs_rename2+0x86/0xf0
> [ 1902.438485][ T8409]  ? btrfs_mknod+0x100/0x100
> [ 1902.438773][ T8409]  vfs_rename+0xdb6/0x12e0
> [ 1902.439098][ T8409]  ? __ia32_sys_link+0x90/0x90
> [ 1902.439402][ T8409]  ? d_splice_alias+0x126/0x570
> [ 1902.439714][ T8409]  ? _raw_spin_unlock+0x24/0x40
> [ 1902.440025][ T8409]  ? security_path_rename+0x1ab/0x230
> [ 1902.440368][ T8409]  do_renameat2+0xce3/0x1350
> [ 1902.440662][ T8409]  ? fsnotify_move+0x4e0/0x4e0
> [ 1902.440960][ T8409]  ? check_heap_object+0x1b0/0x360
> [ 1902.441295][ T8409]  ? __check_object_size+0x15b/0x220
> [ 1902.441627][ T8409]  ? strncpy_from_user+0x1e6/0x340
> [ 1902.441957][ T8409]  __x64_sys_renameat2+0xce/0xe0
> [ 1902.442277][ T8409]  do_syscall_64+0x3d/0x90
> [ 1902.442570][ T8409]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> [ 1902.442945][ T8409] RIP: 0033:0x7f53090e4469
> [ 1902.443226][ T8409] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f
> 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b
> 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d ff 49 2b 00 f7 d8
> 64 89 01 48
> [ 1902.444404][ T8409] RSP: 002b:00007ffc1afb3f38 EFLAGS: 00000206
> ORIG_RAX: 000000000000013c
> [ 1902.444947][ T8409] RAX: ffffffffffffffda RBX: 0000000000000000
> RCX: 00007f53090e4469
> [ 1902.445430][ T8409] RDX: 0000000000000003 RSI: 00000000200000c0
> RDI: 0000000000000005
> [ 1902.445920][ T8409] RBP: 00007ffc1afb3f50 R08: 0000000000000002
> R09: 00007ffc1afb3f50
> [ 1902.446416][ T8409] R10: 00000000200004c0 R11: 0000000000000206
> R12: 0000558a65401170
> [ 1902.446931][ T8409] R13: 00007ffc1afb4090 R14: 0000000000000000
> R15: 0000000000000000
> [ 1902.447440][ T8409]  </TASK>
> [ 1902.447848][ T8409] Kernel Offset: disabled
> [ 1902.448182][ T8409] Rebooting in 86400 sec
>
> Best,
> Wei
