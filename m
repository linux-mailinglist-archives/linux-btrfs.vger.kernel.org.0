Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576737C42DE
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Oct 2023 23:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjJJVpU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Oct 2023 17:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234666AbjJJVpS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Oct 2023 17:45:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29036D44
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Oct 2023 14:45:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D9D5C433C7
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Oct 2023 21:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696974314;
        bh=Jfjx7dSwm4Lo/Bs4OGuPP3acwmNdp/4e7WPsMeeZp3w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=easl/08EwUftyQAkI4UQ6NE/q/hU8+bQ/qhljrwjDQjWuReLapZYsklK29IUKnYP3
         Om1+TYjRl2UCuAnyQbn17XXsLGoKqZW18eB23tSNFFhV1ABUd7sF2lXxEcjmK3AekE
         FvcF5QPxQZQlPeDz4fD1s6s3VOFAMkYMY/vAyJ6FLNtp/ljOIUU2VWu+Kd67ndrH5e
         aViFQN/KwIdrufnOKfPmO7E9xJtiq0VPvB5sddIwmgeVT7IiRG3n4c/CM/cqx8S4XT
         lJ12YCLn1e8/uW4bxL8VMl70kt2J8Ra7FM5ER8TnEpKzaAuWYOk/vNbXHiaKKnsep6
         8u4kd+NWBBceQ==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-1dcf357deedso3910798fac.0
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Oct 2023 14:45:14 -0700 (PDT)
X-Gm-Message-State: AOJu0YzaYS7isDUQY9/3hOl8z/PFJNHIFZm7dIrfCFWu1+imfX8Itk3v
        /0Arl8D31k+3sOIt0ClpNtV15NZndT+how32BEE=
X-Google-Smtp-Source: AGHT+IGGEaed01G8z/ZzQz75r7aWxhYhzAminfKYPPJ9SPzm7EahahJB4M5UklHMS0mbncvTe5Ppz13TXJe96ccBb3Y=
X-Received: by 2002:a05:6871:78d:b0:19f:aee0:e169 with SMTP id
 o13-20020a056871078d00b0019faee0e169mr24496926oap.30.1696974313880; Tue, 10
 Oct 2023 14:45:13 -0700 (PDT)
MIME-Version: 1.0
References: <13f94633dcf04d29aaf1f0a43d42c55e@amazon.com> <ZSVyFaWA5KZ0nTEN@debian0.Home>
 <ddb589008e7a4419b67134be7ae90f8b@amazon.com>
In-Reply-To: <ddb589008e7a4419b67134be7ae90f8b@amazon.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Tue, 10 Oct 2023 22:44:37 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4AEvZGNZyx8Yd4XD0AQMojQ3ifp-wmpcN9mEtxWpTOOQ@mail.gmail.com>
Message-ID: <CAL3q7H4AEvZGNZyx8Yd4XD0AQMojQ3ifp-wmpcN9mEtxWpTOOQ@mail.gmail.com>
Subject: Re: btrfs_extent_map memory consumption results in "Out of memory"
To:     "Ospan, Abylay" <aospan@amazon.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 10, 2023 at 10:23=E2=80=AFPM Ospan, Abylay <aospan@amazon.com> =
wrote:
>
> Hi Filipe,
>
> Thanks for the info!
>
> I was just wondering about "direct IO writes", so I ran a quick test by f=
ully removing fio's config option "direct=3D1" (default value is false).
> Unfortunately, I'm still experiencing the same oom-kill:
>
> [ 4843.936881] oom-kill:constraint=3DCONSTRAINT_NONE,nodemask=3D(null),cp=
uset=3D/,mems_allowed=3D0,global_oom,task_memcg=3D/,task=3Dfio,pid=3D649,ui=
d=3D0
> [ 4843.939001] Out of memory: Killed process 649 (fio) total-vm:216868kB,=
 anon-rss:896kB, file-rss:128kB, shmem-rss:2176kB, UID:0 pgtables:100kB oom=
_score_a0
> [ 5306.210082] tmux: server invoked oom-killer: gfp_mask=3D0x140cca(GFP_H=
IGHUSER_MOVABLE|__GFP_COMP), order=3D0, oom_score_adj=3D0
> ...
> [ 5306.240968] Unreclaimable slab info:
> [ 5306.241271] Name                      Used          Total
> [ 5306.242700] btrfs_extent_map       26093KB      26093KB
>
> Here's my updated fio config:
> [global]
> name=3Dfio-rand-write
> filename=3Dfio-rand-write
> rw=3Drandwrite
> bs=3D4K
> numjobs=3D1
> time_based
> runtime=3D90000
>
> [file1]
> size=3D3G
> iodepth=3D1
>
> "slabtop -s -a" output:
>   OBJS ACTIVE  USE OBJ SIZE  SLABS OBJ/SLAB CACHE SIZE NAME
> 206080 206080 100%    0.14K   7360       28     29440K btrfs_extent_map
>
> I accelerated my testing by running fio test inside a QEMU VM with a limi=
ted amount of RAM (140MB):
>
> qemu-kvm
>   -kernel bzImage.v6.6 \
>   -m 140M  \
>   -drive file=3Drootfs.btrfs,format=3Draw,if=3Dnone,id=3Ddrive0
> ...
>
> It appears that this issue may not be limited to direct IO writes alone?

In the buffered IO case it's typically much less likely to happen.

The reason why it happens in your test it's because the VM has very
little RAM, 140M, which is very unlikely
to find in the real world nowadays. Pages can only be released when
they are not dirty and not under writeback,
and in this case there's no fsync, so the amount of dirty pages (or
under writeback) accumulates very quickly.
If pages can not be released, extent maps can not be released either.

If you add "fsync=3D1" to your fio test, things should change dramatically.

Thanks.

(And btw, try to avoid top posting if possible, as that makes the
thread harder to follow.)

>
> Thank you!
>
> -----Original Message-----
> From: Filipe Manana <fdmanana@kernel.org>
> Sent: Tuesday, October 10, 2023 11:48 AM
> To: Ospan, Abylay <aospan@amazon.com>
> Cc: linux-btrfs@vger.kernel.org
> Subject: RE: [EXTERNAL] btrfs_extent_map memory consumption results in "O=
ut of memory"
>
> CAUTION: This email originated from outside of the organization. Do not c=
lick links or open attachments unless you can confirm the sender and know t=
he content is safe.
>
>
>
> On Tue, Oct 10, 2023 at 03:02:21PM +0000, Ospan, Abylay wrote:
> > Greetings Btrfs development team!
> >
> > I would like to express my gratitude for your outstanding work on Btrfs=
. However, I recently experienced an 'out of memory' issue as described bel=
ow.
> >
> > Steps to reproduce:
> >
> > 1. Run FIO test on a btrfs partition with random write on a 300GB file:
> >
> > cat <<EOF >> rand.fio
> > [global]
> > name=3Dfio-rand-write
> > filename=3Dfio-rand-write
> > rw=3Drandwrite
> > bs=3D4K
> > direct=3D1
> > numjobs=3D16
> > time_based
> > runtime=3D90000
> >
> > [file1]
> > size=3D300G
> > ioengine=3Dlibaio
> > iodepth=3D16
> > EOF
> >
> > fio rand.fio
> >
> > 2. Monitor slab consumption with "slabtop -s -a"
> >
> >   OBJS ACTIVE  USE OBJ SIZE  SLABS OBJ/SLAB CACHE SIZE NAME
> > 25820620 23138538  89%    0.14K 922165       28   3688660K btrfs_extent=
_map
> >
> > 3. Observe oom-killer:
> > [49689.294138] ip invoked oom-killer:
> > gfp_mask=3D0xc2cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_COMP|__GFP_NOMEMALLOC)=
, order=3D3, oom_score_adj=3D0 ...
> > [49689.294425] Unreclaimable slab info:
> > [49689.294426] Name                      Used          Total
> > [49689.329363] btrfs_extent_map     3207098KB    3375622KB
> > ...
> >
> > Memory usage by btrfs_extent_map gradually increases until it reaches a=
 critical point, causing the system to run out of memory.
> >
> > Test environment: Intel CPU, 8GB RAM (To expedite the reproduction of t=
his issue, I also conducted tests within QEMU with a restricted amount of m=
emory).
> > Linux kernel tested: LTS 5.15.133, and mainline 6.6-rc5
> >
> > Quick review of the 'fs/btrfs/extent_map.c' code reveals no built-in li=
mitations on memory allocation for extents mapping.
> > Are there any known workarounds or alternative solutions to mitigate th=
is issue?
>
> No workarounds really.
>
> So once we add an extent map to the inode's rbtree, it will stay there un=
til:
>
> 1) The corresponding pages in the file range get released due to memory p=
ressure or whatever reason decided by the MM side.
>    The release happens in the callback struct address_space_operations::r=
elease_folio, which is btrfs_release_folio for btrfs.
>    In your case it's direct IO writes... so there are no pages to release=
, and therefore extent maps don't get released by
>    that mechanism.
>
> 2) The inode is evicted - when evicted of course we drop all extent maps =
and release all memory.
>    If some application is keeping a file descriptor open for the inode, a=
nd writes keep happening (or reads, since they create
>    an extent map for the range read too), then no extent maps are release=
d...
>    Databases and other software often do that, keep file descriptors open=
 for long periods, while reads and writes are happening
>    by the some process or others.
>
> The other side effect, even if no memory exhaustion happens, is that it s=
lows down writes, reads, and other operations, due to large red black trees=
 of extent maps.
>
> I don't have a ready solution for that, but I had some thinking about thi=
s about a year ago or so.
> The simplest solution would be to not keep extent maps in memory for dire=
ct IO writes/reads...
> but it may slow down in some cases at least.
>
> Soon I may start some work to improve that.
>
> Thanks.
>
> >
> > Thank you!
> >
> > --
> > Abylay Ospan
> >
> >
