Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21055667737
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Jan 2023 15:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239706AbjALOkx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Jan 2023 09:40:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238507AbjALOkS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Jan 2023 09:40:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325586219E;
        Thu, 12 Jan 2023 06:29:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B158B61FCB;
        Thu, 12 Jan 2023 14:29:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2657FC433F0;
        Thu, 12 Jan 2023 14:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673533796;
        bh=JZRrvN/jvv2tf46l8snNx1waBKFLB2GgX+Ugtds07Uo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=H8zFkN0nxR0LAlC0m4Bpcf1pyRjdsqkrjoW5AFHvcjPjp/2hlbBcUvEjtJfr77l6X
         brLTwE7TVBiAe5PGwCI5kWBt4c4WsJ2gI6kaEy+4IDqo60BUuOL+xmK9rcMTi5GNHO
         /o4GSVZQ8lVm8CrZDBHHbBn5U96zsk9RmyZ+iccJjkFlUOqkY+9ELjj9OW/Xhju1n0
         aSjLMhYTkKjpK2/jNnQv/49GVgAiv3u1RIyQ0esQVFHAE4Dr4tLxIbJ/eVN2+7ys09
         KFUO8bvRbyhLI71vR2OuJtGvjWyQbpCxQPI2f3eQ3yoaTKQ+kHSkuxeDMhFkEvv7E7
         leWErimj2Yu9A==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-15ed38a9b04so375336fac.8;
        Thu, 12 Jan 2023 06:29:56 -0800 (PST)
X-Gm-Message-State: AFqh2kp0FbkfIbI59p4kpypVGk+eyGxqDWmvUEeelEuMfIz2U1iDlcKk
        yYcE4/UUwGOfM5CeJ3G//bFwQrbHttvimGD0fQk=
X-Google-Smtp-Source: AMrXdXsTjQrtvlU+ITja5ZdOicFU0LN6CRxYrwtF7sj1Q+FOTxnhk68fkVaJqeJQtnXsh0s6Lowl9MwGrm4HV2qhZeM=
X-Received: by 2002:a05:6871:22c2:b0:15b:945f:9102 with SMTP id
 se2-20020a05687122c200b0015b945f9102mr909950oab.92.1673533795209; Thu, 12 Jan
 2023 06:29:55 -0800 (PST)
MIME-Version: 1.0
References: <7f25442f-b121-2a3a-5a3d-22bcaae83cd4@leemhuis.info>
In-Reply-To: <7f25442f-b121-2a3a-5a3d-22bcaae83cd4@leemhuis.info>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Thu, 12 Jan 2023 14:29:19 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5XUr2=kLEV192yU6cZakX_diS5+WRLq7LHkGPUOAZZZw@mail.gmail.com>
Message-ID: <CAL3q7H5XUr2=kLEV192yU6cZakX_diS5+WRLq7LHkGPUOAZZZw@mail.gmail.com>
Subject: Re: [regression] Bug 216908 - General Protection Fault in btrfs_file_llseek
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Matthias Schoepfer <matthias.schoepfer@googlemail.com>,
        Boris Burkov <boris@bur.io>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 12, 2023 at 2:05 PM Linux kernel regression tracking
(Thorsten Leemhuis) <regressions@leemhuis.info> wrote:
>
> Hi, this is your Linux kernel regression tracker.
>
> I noticed a regression report in bugzilla.kernel.org. As many (most?)
> kernel developer don't keep an eye on it, I decided to forward it by
> mail. Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=216908 :
>
> >  Matthias Schoepfer 2023-01-10 13:58:06 UTC
> >
> > When creating a large file (i.e. mkfs.ext4 within yocto embedded linux task, which means, 8+GB file), mkfs.ext4 will report a segfault and I get a general protection fault, the system becomes more or less unstable after this.
> >
> > I can reproduce this 100%, when I do the same with 6.0.6 kernel, it works fine.
> >
> > Here is the Kernel dump:
> > Jan 10 14:12:38 michelle kernel: BTRFS warning (device nvme0n1p5): bad eb member end: ptr 0x3fea start 2704543268864 member offset 16383 size 8
> > Jan 10 14:12:38 michelle kernel: general protection fault, probably for non-canonical address 0x85d8740000000: 0000 [#1] PREEMPT SMP
> > Jan 10 14:12:38 michelle kernel: CPU: 21 PID: 2143606 Comm: mkfs.ext4.real Tainted: P           O    T  6.1.4-gentoo #2
> > Jan 10 14:12:38 michelle kernel: Hardware name: Micro-Star International Co., Ltd. MS-7C37/X570-A PRO (MS-7C37), BIOS H.70 01/09/2020
> > Jan 10 14:12:38 michelle kernel: RIP: 0010:btrfs_get_64+0xe7/0x100
> > Jan 10 14:12:38 michelle kernel: Code: 40 08 48 2b 15 b2 3a 15 01 48 8d 0c 04 48 c1 fa 06 48 c1 e2 0c 48 03 15 af 3a 15 01 81 eb f8 0f 00 00 74 12 31 c0 89 c6 ff c0 <0f> b6 3c 32 40 88 3c 3>
> > Jan 10 14:12:38 michelle kernel: RSP: 0018:ffffb2d4ca4c3dd0 EFLAGS: 00010202
> > Jan 10 14:12:38 michelle kernel: RAX: 0000000000000001 RBX: 0000000000000007 RCX: ffffb2d4ca4c3dd9
> > Jan 10 14:12:38 michelle kernel: RDX: 00085d8740000000 RSI: 0000000000000000 RDI: 000000000000000a
> > Jan 10 14:12:38 michelle kernel: RBP: ffff96fbbfd9c600 R08: 0000000000000001 R09: 00000000ffffdfff
> > Jan 10 14:12:38 michelle kernel: R10: ffffffff94a3a700 R11: ffffffff94aea700 R12: 0000000000000003
> > Jan 10 14:12:38 michelle kernel: R13: ffff96fbbfd9c600 R14: 0000000000000003 R15: 0000000000003fea
> > Jan 10 14:12:38 michelle kernel: FS:  00007f6ac90e5780(0000) GS:ffff97071ed40000(0000) knlGS:0000000000000000
> > Jan 10 14:12:38 michelle kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > Jan 10 14:12:38 michelle kernel: CR2: 0000557c6f245760 CR3: 000000019a64a000 CR4: 0000000000350ee0
> > Jan 10 14:12:38 michelle kernel: Call Trace:
> > Jan 10 14:12:38 michelle kernel:  <TASK>
> > Jan 10 14:12:38 michelle kernel:  btrfs_file_llseek+0x269/0x670
> > Jan 10 14:12:38 michelle kernel:  ksys_lseek+0x61/0xa0
> > Jan 10 14:12:38 michelle kernel:  do_syscall_64+0x56/0x80
> > Jan 10 14:12:38 michelle kernel:  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> > Jan 10 14:12:38 michelle kernel: RIP: 0033:0x7f6ac91e4d3b
> > Jan 10 14:12:38 michelle kernel: Code: ff ff c3 0f 1f 40 00 48 8b 15 e1 90 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb ba 0f 1f 00 f3 0f 1e fa b8 08 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 0>
> > Jan 10 14:12:38 michelle kernel: RSP: 002b:00007fff68e04038 EFLAGS: 00000297 ORIG_RAX: 0000000000000008
> > Jan 10 14:12:38 michelle kernel: RAX: ffffffffffffffda RBX: 000056367d4ffea0 RCX: 00007f6ac91e4d3b
> > Jan 10 14:12:38 michelle kernel: RDX: 0000000000000003 RSI: 0000000000000000 RDI: 0000000000000004
> > Jan 10 14:12:38 michelle kernel: RBP: 0000000000000004 R08: 00007f6ac92bef90 R09: 000056367d4f6160
> > Jan 10 14:12:38 michelle kernel: R10: 0000000000000000 R11: 0000000000000297 R12: 0000000000000000
> > Jan 10 14:12:38 michelle kernel: R13: 000056367d4c0eb0 R14: 000056367d50d620 R15: 000056367d4ebab0
> > Jan 10 14:12:38 michelle kernel:  </TASK>
> > Jan 10 14:12:38 michelle kernel: Modules linked in: xt_CHECKSUM xt_MASQUERADE nvidia_drm(PO) nvidia_modeset(PO) ip6table_nat iptable_nat bpfilter nvidia(PO) uvcvideo videobuf2_vmalloc video>
> > Jan 10 14:12:38 michelle kernel: ---[ end trace 0000000000000000 ]---
> > Jan 10 14:12:38 michelle kernel: RIP: 0010:btrfs_get_64+0xe7/0x100
> > Jan 10 14:12:38 michelle kernel: Code: 40 08 48 2b 15 b2 3a 15 01 48 8d 0c 04 48 c1 fa 06 48 c1 e2 0c 48 03 15 af 3a 15 01 81 eb f8 0f 00 00 74 12 31 c0 89 c6 ff c0 <0f> b6 3c 32 40 88 3c 3>
> > Jan 10 14:12:38 michelle kernel: RSP: 0018:ffffb2d4ca4c3dd0 EFLAGS: 00010202
> > Jan 10 14:12:38 michelle kernel: RAX: 0000000000000001 RBX: 0000000000000007 RCX: ffffb2d4ca4c3dd9
> > Jan 10 14:12:38 michelle kernel: RDX: 00085d8740000000 RSI: 0000000000000000 RDI: 000000000000000a
> > Jan 10 14:12:38 michelle kernel: RBP: ffff96fbbfd9c600 R08: 0000000000000001 R09: 00000000ffffdfff
> > Jan 10 14:12:38 michelle kernel: R10: ffffffff94a3a700 R11: ffffffff94aea700 R12: 0000000000000003
> > Jan 10 14:12:38 michelle kernel: R13: ffff96fbbfd9c600 R14: 0000000000000003 R15: 0000000000003fea
> > Jan 10 14:12:38 michelle kernel: FS:  00007f6ac90e5780(0000) GS:ffff97071ed40000(0000) knlGS:0000000000000000
> > Jan 10 14:12:38 michelle kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > Jan 10 14:12:38 michelle kernel: CR2: 0000557c6f245760 CR3: 000000019a64a000 CR4: 0000000000350ee0
>
> See the ticket for more details.
>
> I first assumed (see the ticket) it might be the same problem that was
> fixed by "btrfs: fix resolving backrefs for inline extent followed by
> prealloc"
> (https://lore.kernel.org/all/20230104160512.620453792@linuxfoundation.org/
> ) -- but that is already in 6.1.4, so I better keep my nose out of it
> and let the experts look into this.
>
>
> [TLDR for the rest of this mail: I'm adding this report to the list of
> tracked Linux kernel regressions; the text you find below is based on a
> few templates paragraphs you might have encountered already in similar
> form.]
>
> BTW, let me use this mail to also add the report to the list of tracked
> regressions to ensure it's doesn't fall through the cracks:
>
> #regzbot introduced: v6.0..v6.1.4
> https://bugzilla.kernel.org/show_bug.cgi?id=216908
> #regzbot title: btrfs: General Protection Fault in btrfs_file_llseek
> #regzbot ignore-activity
>
> This isn't a regression? This issue or a fix for it are already
> discussed somewhere else? It was fixed already? You want to clarify when
> the regression started to happen? Or point out I got the title or
> something else totally wrong? Then just reply and tell me -- ideally
> while also telling regzbot about it, as explained by the page listed in
> the footer of this mail.
>
> Developers: When fixing the issue, remember to add 'Link:' tags pointing
> to the report (e.g. the buzgzilla ticket and maybe this mail as well, if
> this thread sees some discussion). See page linked in footer for details.

Right, it's a different issue.

I just sent the fix to the btrfs list:

https://lore.kernel.org/linux-btrfs/860221a4cf1642689ed17404c12b920d1acf1019.1673532966.git.fdmanana@suse.com/

Thanks.
>
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
