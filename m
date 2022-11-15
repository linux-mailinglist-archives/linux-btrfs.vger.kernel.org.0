Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033EF6295DA
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 11:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232477AbiKOKbH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 05:31:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiKOKbF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 05:31:05 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A16422BFB;
        Tue, 15 Nov 2022 02:31:04 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id n20so14340101ejh.0;
        Tue, 15 Nov 2022 02:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FQ6PJ0mgAJaeuyyYqe1t7dCUJetYDLl0S3Hf7hELnyI=;
        b=CTpCvDRiICHEN1kD3Fd3j88y9p/gskyYT0yYbPaL2iSVAGiDi76QpdpIrk6PEjdpVL
         fHH3Tu321teDtKiFaKstpU5EVZOsGUjJ+ycbS4S5XBGJC959M9Pd/wQP8pqsa9PkTnoQ
         /upx1ObduY+q71qWL2zkmdRPRW+D/RD0Xu+gv7vobPmojFUOSxCY8rn+3tKY/4Tqk0k/
         38T1G0Qcea3mlOfgdIqgrbLJ1LCBXGZoct/CuDTsOqLu04srbNDVl/VNAHPGFLJjEjtv
         dlqtzeilU42sDho0J8nCLHYY3jhINN1YqhIItG17oT9pT8lfKyVtQQpc9/XPA3g1kB6D
         O4kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FQ6PJ0mgAJaeuyyYqe1t7dCUJetYDLl0S3Hf7hELnyI=;
        b=NijKWaSUgz1kI4ZtFRZORyEB0grqpHnzhSQ0jBqE5hjm+cq14IrnHKyZgpSWFB6mkm
         +5CMl+TEa+do6WcS8yJ594agpVPUfjQTP3QVf4EvCg5gzmxyqrlyZ/lk9pBC4NjNA9ON
         dTwTytLT2+zvLysykUk8d/GbHBu7j+IHNbrLXAI+MiNH3ku4rKjtANtaxYTru0/CxvEO
         Ns+vf4OXSEQTXNZNyYZLn2brKVHSFRm+myyS70/D2Wa5pM0fVdnvjqh+ggq80dVznjcy
         cwdg20Fk6GKscT2s3S5tiKUaA9cA1CYtqY77dgrYPaG8BFm9a9sp6AjNR+/4/QbeTyAb
         M4Jw==
X-Gm-Message-State: ANoB5plzy1WcTXqwicpYoVO3dsCUgCfWNhho22Iwm9TlxGbGYBuk8+Tj
        R5xYZavbJzBoDNOoJHTwN2aUQ0J8PTXfW1/ml8Q=
X-Google-Smtp-Source: AA0mqf7QdCVJBNaciefqAGJ9KkIS5HV78qivBGoiycRZee+SoTYY1UOIZeVOVF5dhsHbHnmj9afhLHqrM0EMGI71//Q=
X-Received: by 2002:a17:906:750:b0:78d:ad5d:75e with SMTP id
 z16-20020a170906075000b0078dad5d075emr13510276ejb.172.1668508262892; Tue, 15
 Nov 2022 02:31:02 -0800 (PST)
MIME-Version: 1.0
References: <CAO4mrfepng=HR3Pd4Nic8VWuAJR6y0AGWMRozg-GYppBAyD56g@mail.gmail.com>
In-Reply-To: <CAO4mrfepng=HR3Pd4Nic8VWuAJR6y0AGWMRozg-GYppBAyD56g@mail.gmail.com>
From:   Wei Chen <harperchen1110@gmail.com>
Date:   Tue, 15 Nov 2022 18:30:27 +0800
Message-ID: <CAO4mrfeJg2r17o+ZbtD5vDZSDaMsYn-XUDdWzeYQgE=mAx1GfQ@mail.gmail.com>
Subject: Re: WARNING in btrfs_cont_expand
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
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

I hope the following bug report is helpful.

Best,
Wei

On Sun, 6 Nov 2022 at 23:27, Wei Chen <harperchen1110@gmail.com> wrote:
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
> https://drive.google.com/file/d/1ARWiyJuypC3aAy8NAR9pYcDjetANaSwF/view?usp=share_link
> kernel config: https://drive.google.com/file/d/1flhc33savDkmYN6PRU5C2vXDX0LAKMvM/view?usp=share_link
> C reproducer: https://drive.google.com/file/d/1N5XpsTkCENoHXZx-NMNJEzvNEJ8UWabd/view?usp=share_link
> Syz reproducer:
> https://drive.google.com/file/d/1dwunpfWOA1Pj9eyLSewmLegtAxtDhvnx/view?usp=share_link
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: Wei Chen <harperchen1110@gmail.com>
>
> R10: 0000000000000000 R11: 0000000000000246 R12: 000000000000001a
> R13: 0000000000000000 R14: 000000000077bf80 R15: 00007ffcb6c26f30
>  </TASK>
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 4806 at fs/btrfs/inode.c:5234 maybe_insert_hole
> fs/btrfs/inode.c:5234 [inline]
> WARNING: CPU: 0 PID: 4806 at fs/btrfs/inode.c:5234
> btrfs_cont_expand+0x4fa/0x5e0 fs/btrfs/inode.c:5302
> Modules linked in:
> CPU: 0 PID: 4806 Comm: syz-executor.0 Not tainted 5.15.76 #5
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> rel-1.13.0-48-gd9c812dda519-prebuilt.qemu.org 04/01/2014
> RIP: 0010:maybe_insert_hole fs/btrfs/inode.c:5234 [inline]
> RIP: 0010:btrfs_cont_expand+0x4fa/0x5e0 fs/btrfs/inode.c:5302
> Code: e8 4b 17 48 ff 83 fd fb 0f 84 a6 00 00 00 83 fd e2 0f 84 9d 00
> 00 00 e8 34 17 48 ff 89 ee 48 c7 c7 c0 f8 39 85 e8 76 bf 32 ff <0f> 0b
> e8 1f 17 48 ff 4c 89 ef 89 e9 ba 72 14 00 00 48 c7 c6 80 3e
> RSP: 0018:ffffc9000cd3fc38 EFLAGS: 00010282
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffc90002115000
> RDX: 0000000000040000 RSI: ffffffff812d935c RDI: 00000000ffffffff
> RBP: 00000000fffffff4 R08: 0000000000000000 R09: 0000000000000001
> R10: ffffc9000cd3fa18 R11: 0000000000000003 R12: ffff888016d0cac0
> R13: ffff888016d30460 R14: 0000000000001000 R15: ffff88801425b870
> FS:  00007f4052485700(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000001b2c22b000 CR3: 000000011acb2000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  btrfs_setsize fs/btrfs/inode.c:5391 [inline]
>  btrfs_setattr+0x221/0x7d0 fs/btrfs/inode.c:5468
>  notify_change+0x548/0x750 fs/attr.c:426
>  do_truncate+0xa3/0x100 fs/open.c:65
>  vfs_truncate+0x1cc/0x1e0 fs/open.c:111
>  do_sys_truncate.part.13+0xa4/0xc0 fs/open.c:134
>  do_sys_truncate fs/open.c:128 [inline]
>  __do_sys_truncate fs/open.c:146 [inline]
>  __se_sys_truncate fs/open.c:144 [inline]
>  __x64_sys_truncate+0x27/0x40 fs/open.c:144
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x34/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x61/0xcb
> RIP: 0033:0x4697f9
> Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48
> 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
> 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f4052484c48 EFLAGS: 00000246 ORIG_RAX: 000000000000004c
> RAX: ffffffffffffffda RBX: 000000000077bf80 RCX: 00000000004697f9
> RDX: 0000000000000000 RSI: 000000000000ffff RDI: 0000000020000080
> RBP: 00007f4052484c80 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 000000000000001a
> R13: 0000000000000000 R14: 000000000077bf80 R15: 00007ffcb6c26f30
>  </TASK>
>
> Best,
> Wei
