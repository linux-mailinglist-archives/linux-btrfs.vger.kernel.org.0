Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24B4F14285E
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Jan 2020 11:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgATKpX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Jan 2020 05:45:23 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:46594 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgATKpX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Jan 2020 05:45:23 -0500
Received: by mail-vs1-f66.google.com with SMTP id t12so18631986vso.13
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Jan 2020 02:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=vXNk5XYzYiRRVI/Q4JFeAB6Lfn0DD3HESPk2TCKpb14=;
        b=XRfq0nrZB01utOB+m653q0MKgaceJn5kRs7j+TQ/ZELH8KfjvK8x7PldXDdAP7FTFy
         n0ZconR8X/lIwPWC8VHMbLVcu+JO4IbxnJ152bX7tJMWEl8mPM5apTbvkOxb+oL2CYce
         M3TjJ8CwIHQUjGooRHI2c8jugAUPw9ABxhhLTRbib7nFmW1j9M7qGL9ViWK8PNv55M12
         W/kglQeD8e7OOvF6fMmgp/MPIkVlM/D5DEhATNpDDRpRwMLPu+F7/tfbmCo9Xa4fK4yL
         PMb0X1zwJeY4xOd8H4jBjyoYuSStkkalka5XS6esfuMmvoIgIyzV5AcOhCfWGeEzK4xS
         LM+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=vXNk5XYzYiRRVI/Q4JFeAB6Lfn0DD3HESPk2TCKpb14=;
        b=VWVvHGwaoTAPnsuteblDFgIQm3RZrGt8rRJVIaHqVmfHCtoGj8jV6lW2dF3SdlID4N
         9uPVRQy7HMg3VFks1LuJ/vN+dBDbhR2hfL/nwC5WfcLVXspLJ7zkIKFDMLIo/XUClK3J
         PRyV08Aeou+eB1DnPUCtZxt0/rNT05eBaisjryDNQ+AsLd3pW4pmpCs0TIVOfN284bci
         jwoTgYqwy0owt3UAC3ChvL6jdDKk9cUdaaZSh8mp85Ws8w69nFWSSf+wHGMAoDQlAzRq
         QG+U9mI0UUHJMc+PEvtLSFx6Cy7y/921+qmQ9Wlc4Ny778URY3tNtvENzAAFDz8Eakm9
         J0ew==
X-Gm-Message-State: APjAAAX9S0ULLaPM92yG2hNqom7o9P9TjuynWwl1WPJ+wzm5T/ZBatsW
        lQNHM2qIr7Jj3+zBAiuQUK7PUylZzW9NEs1nIA4=
X-Google-Smtp-Source: APXvYqxTYO/0NF8MxsUarl0DHlSgJaUG6TIvYKtSheMxkh9iRuY0TOt5K6TKZQhXbW9xiiVwcmm1ETfOxZr8Map+HAc=
X-Received: by 2002:a05:6102:535:: with SMTP id m21mr11679447vsa.95.1579517121690;
 Mon, 20 Jan 2020 02:45:21 -0800 (PST)
MIME-Version: 1.0
References: <20191115020900.23662-1-wqu@suse.com> <CAL3q7H6jrMYXcLVJ4nYjVXWDxz_Lb-49zD=sq++68ZywL7dKEg@mail.gmail.com>
 <241a644d-d71c-56c9-5820-aa3b19aacf39@gmx.com> <71084455-3033-d5ee-5694-6c2176562e50@gmx.com>
In-Reply-To: <71084455-3033-d5ee-5694-6c2176562e50@gmx.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 20 Jan 2020 10:45:10 +0000
Message-ID: <CAL3q7H6L3FO+1Po6Ra74vEoEDWHB2U0V+Ssa+X0+K0keusWz1g@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: scrub: Don't check free space before marking a
 block group RO
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 20, 2020 at 9:43 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2020/1/18 =E4=B8=8A=E5=8D=889:16, Qu Wenruo wrote:
> >
> >
> > On 2020/1/18 =E4=B8=8A=E5=8D=881:59, Filipe Manana wrote:
> >> On Fri, Nov 15, 2019 at 2:11 AM Qu Wenruo <wqu@suse.com> wrote:
> >>>
> >>> [BUG]
> >>> When running btrfs/072 with only one online CPU, it has a pretty high
> >>> chance to fail:
> >>>
> >>>   btrfs/072 12s ... _check_dmesg: something found in dmesg (see xfste=
sts-dev/results//btrfs/072.dmesg)
> >>>   - output mismatch (see xfstests-dev/results//btrfs/072.out.bad)
> >>>       --- tests/btrfs/072.out     2019-10-22 15:18:14.008965340 +0800
> >>>       +++ /xfstests-dev/results//btrfs/072.out.bad      2019-11-14 15=
:56:45.877152240 +0800
> >>>       @@ -1,2 +1,3 @@
> >>>        QA output created by 072
> >>>        Silence is golden
> >>>       +Scrub find errors in "-m dup -d single" test
> >>>       ...
> >>>
> >>> And with the following call trace:
> >>>   BTRFS info (device dm-5): scrub: started on devid 1
> >>>   ------------[ cut here ]------------
> >>>   BTRFS: Transaction aborted (error -27)
> >>>   WARNING: CPU: 0 PID: 55087 at fs/btrfs/block-group.c:1890 btrfs_cre=
ate_pending_block_groups+0x3e6/0x470 [btrfs]
> >>>   CPU: 0 PID: 55087 Comm: btrfs Tainted: G        W  O      5.4.0-rc1=
-custom+ #13
> >>>   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/0=
6/2015
> >>>   RIP: 0010:btrfs_create_pending_block_groups+0x3e6/0x470 [btrfs]
> >>>   Call Trace:
> >>>    __btrfs_end_transaction+0xdb/0x310 [btrfs]
> >>>    btrfs_end_transaction+0x10/0x20 [btrfs]
> >>>    btrfs_inc_block_group_ro+0x1c9/0x210 [btrfs]
> >>>    scrub_enumerate_chunks+0x264/0x940 [btrfs]
> >>>    btrfs_scrub_dev+0x45c/0x8f0 [btrfs]
> >>>    btrfs_ioctl+0x31a1/0x3fb0 [btrfs]
> >>>    do_vfs_ioctl+0x636/0xaa0
> >>>    ksys_ioctl+0x67/0x90
> >>>    __x64_sys_ioctl+0x43/0x50
> >>>    do_syscall_64+0x79/0xe0
> >>>    entry_SYSCALL_64_after_hwframe+0x49/0xbe
> >>>   ---[ end trace 166c865cec7688e7 ]---
> >>>
> >>> [CAUSE]
> >>> The error number -27 is -EFBIG, returned from the following call chai=
n:
> >>> btrfs_end_transaction()
> >>> |- __btrfs_end_transaction()
> >>>    |- btrfs_create_pending_block_groups()
> >>>       |- btrfs_finish_chunk_alloc()
> >>>          |- btrfs_add_system_chunk()
> >>>
> >>> This happens because we have used up all space of
> >>> btrfs_super_block::sys_chunk_array.
> >>>
> >>> The root cause is, we have the following bad loop of creating tons of
> >>> system chunks:
> >>> 1. The only SYSTEM chunk is being scrubbed
> >>>    It's very common to have only one SYSTEM chunk.
> >>> 2. New SYSTEM bg will be allocated
> >>>    As btrfs_inc_block_group_ro() will check if we have enough space
> >>>    after marking current bg RO. If not, then allocate a new chunk.
> >>> 3. New SYSTEM bg is still empty, will be reclaimed
> >>>    During the reclaim, we will mark it RO again.
> >>> 4. That newly allocated empty SYSTEM bg get scrubbed
> >>>    We go back to step 2, as the bg is already mark RO but still not
> >>>    cleaned up yet.
> >>>
> >>> If the cleaner kthread doesn't get executed fast enough (e.g. only on=
e
> >>> CPU), then we will get more and more empty SYSTEM chunks, using up al=
l
> >>> the space of btrfs_super_block::sys_chunk_array.
> >>>
> >>> [FIX]
> >>> Since scrub/dev-replace doesn't always need to allocate new extent,
> >>> especially chunk tree extent, so we don't really need to do chunk
> >>> pre-allocation.
> >>>
> >>> To break above spiral, here we introduce a new parameter to
> >>> btrfs_inc_block_group(), @do_chunk_alloc, which indicates whether we
> >>> need extra chunk pre-allocation.
> >>>
> >>> For relocation, we pass @do_chunk_alloc=3Dtrue, while for scrub, we p=
ass
> >>> @do_chunk_alloc=3Dfalse.
> >>> This should keep unnecessary empty chunks from popping up for scrub.
> >>>
> >>> Also, since there are two parameters for btrfs_inc_block_group_ro(),
> >>> add more comment for it.
> >>>
> >>> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >>
> >> Qu,
> >>
> >> Strangely, this has caused some unexpected failures on test btrfs/071
> >> (fsstress + device replace + remount followed by scrub).
> >
> > How reproducible?
> >
> > I also hit rare csum corruptions in btrfs/06[45] and btrfs/071.
> > That from v5.5-rc6 and misc-next.
> >
> > In my runs, the reproducibility comes around 1/20 to 1/50.
> >
> >>
> >> Since I hadn't seen the issue in my 5.4 (and older) based branches,
> >> and only started to observe the failure in 5.5-rc2+, I left a vm
> >> bisecting since last week after coming back from vacations.
> >> The bisection points out to this change. And going to 5.5-rc5 and
> >> reverting this change, or just doing:
> >>
> >> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> >> index 21de630b0730..87478654a3e1 100644
> >> --- a/fs/btrfs/scrub.c
> >> +++ b/fs/btrfs/scrub.c
> >> @@ -3578,7 +3578,7 @@ int scrub_enumerate_chunks(struct scrub_ctx *sct=
x,
> >>                  * thread can't be triggered fast enough, and use up a=
ll space
> >>                  * of btrfs_super_block::sys_chunk_array
> >>                  */
> >> -               ret =3D btrfs_inc_block_group_ro(cache, false);
> >> +               ret =3D btrfs_inc_block_group_ro(cache, true);
> >>                 scrub_pause_off(fs_info);
> >>
> >>                 if (ret =3D=3D 0) {
> >>
> >> which is simpler then reverting due to conflicts, confirms this patch
> >> is what causes btrfs/071 to fail like this:
> >>
> >> $ cat results/btrfs/071.out.bad
> >> QA output created by 071
> >> Silence is golden
> >> Scrub find errors in "-m raid0 -d raid0" test
> >
> > In my case, not only raid0 raid0, but also simple simple.
> >
> >>
> >> $ cat results/btrfs/071.full
> >> (...)
> >> Test -m raid0 -d raid0
> >> Run fsstress  -p 20 -n 100 -d
> >> /home/fdmanana/btrfs-tests/scratch_1/stressdir -f rexchange=3D0 -f
> >> rwhiteout=3D0
> >> Start replace worker: 17813
> >> Wait for fsstress to exit and kill all background workers
> >> seed =3D 1579455326
> >> dev_pool=3D/dev/sdd /dev/sde /dev/sdf
> >> free_dev=3D/dev/sdg, src_dev=3D/dev/sdd
> >> Replacing /dev/sdd with /dev/sdg
> >> Replacing /dev/sde with /dev/sdd
> >> Replacing /dev/sdf with /dev/sde
> >> Replacing /dev/sdg with /dev/sdf
> >> Replacing /dev/sdd with /dev/sdg
> >> Replacing /dev/sde with /dev/sdd
> >> Replacing /dev/sdf with /dev/sde
> >> Replacing /dev/sdg with /dev/sdf
> >> Replacing /dev/sdd with /dev/sdg
> >> Replacing /dev/sde with /dev/sdd
> >> Scrub the filesystem
> >> ERROR: there are uncorrectable errors
> >> scrub done for 0f63c9b5-5618-4484-b6f2-0b7d3294cf05
> >> Scrub started:    Fri Jan 17 12:31:35 2020
> >> Status:           finished
> >> Duration:         0:00:00
> >> Total to scrub:   5.02GiB
> >> Rate:             0.00B/s
> >> Error summary:    csum=3D1
> >>   Corrected:      0
> >>   Uncorrectable:  1
> >>   Unverified:     0
> >> Scrub find errors in "-m raid0 -d raid0" test
> >> (...)
> >>
> >> And in syslog:
> >>
> >> (...)
> >> Jan  9 13:14:15 debian5 kernel: [1739740.727952] BTRFS info (device
> >> sdc): dev_replace from /dev/sde (devid 4) to /dev/sdd started
> >> Jan  9 13:14:15 debian5 kernel: [1739740.752226]
> >> scrub_handle_errored_block: 8 callbacks suppressed
> >> Jan  9 13:14:15 debian5 kernel: [1739740.752228] BTRFS warning (device
> >> sdc): checksum error at logical 1129050112 on dev /dev/sde, physical
> >> 277803008, root 5, inode 405, offset 1540096, length 4096, links 1
> >> (path: stressdir/pa/d2/d5/fa)
> >
> Since no clue why this patch is causing problem, I just poking around to
> see how it's related.
>
> - It's on-disk data corruption.
>   Btrfs check --check-data-csum also reports similar error of the fs.
>   So it's not some false alert from scrub.

Yes, I figured that later as well.
The problem is really with device replace, passing false to
btrfs_inc_block_group_ro() during scrub is fine, but passing false
during device replace is not fine.
I haven't checked (due to lack of time) if the problem is incorrect
data written, or if it's the checksum that ends ups in csum tree that
is incorrect or stale.

>
> Considering the effect, I guess it may be worthy to use your quick fix,
> or at least do chunk pre-allocation for data chunks.
>
> Thanks,
> Qu
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
