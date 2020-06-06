Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9DB1F05FD
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Jun 2020 11:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbgFFJ50 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 6 Jun 2020 05:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728659AbgFFJ5Z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 6 Jun 2020 05:57:25 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9BDFC03E96A
        for <linux-btrfs@vger.kernel.org>; Sat,  6 Jun 2020 02:57:24 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id j13so7028124vsn.3
        for <linux-btrfs@vger.kernel.org>; Sat, 06 Jun 2020 02:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=TWLGcuU0qIcanFBKmyKsyvRuiHHIRP9fstZoZ7iR094=;
        b=OhefKxUVMFk4RiW4pfFXBw0KpMQtkqUy7d21fzYCnvO8Seyo9AluVmQTf9Q/MdpCUR
         w3WqeZtmeGxKv6dFRNGnSZ/ayqEb7tzcHfwurz+w+AQSHtbOjWkimbPQ/QesFc7qa6pQ
         IHyHVgOZmvSkGxRTqBh17VdBf5fFuKnHDBx+4CLYjMGhZNDTg242UrlngRAP1KLrMTH0
         xVM3TH5j+PfsY/iQmEl7+oOHoKv9DuBlSWPWS3deSzK8HUlMUPEyV4jGAXCo6NrHeULf
         OQN3QACTSgn/NeXZkUn6gI+EbYnZvgGvG8L7H/JkVrMoI2Jm3E0VM11XyRZCmAPfqudC
         6qlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=TWLGcuU0qIcanFBKmyKsyvRuiHHIRP9fstZoZ7iR094=;
        b=O7qZ5P3H7BDBz61ctttaEadrkg+kGqkddFZTjM9fC2FDInSbTZRTFA65XPe8sf2tc4
         dMYy3hy5myrYsztn4+dHDoY4pPzWRv7PzpWTyZoG33TViKD6s3ifkqCwpgr6YL4/ifE/
         xFVy156pBZ9JYvnK7KIIuWjHJ9avah6KQ94Stjb+k2bkHZ21h4PsgDucQmLYtdSYfq0H
         AxNawMbxLJ4la8uWsTgp4o05qY1XaulNLTco6iTzpB4S5+pRwio+jWxZF4NJbvffnJGr
         ZSY5gEqd6D6bbPqOR1nLcK9UfSYqb1uXRs0+Bwk599+hKW2HKvKhK2c8Cq+lyf8ye/pL
         bYww==
X-Gm-Message-State: AOAM530LFaJ0/hELTKefnzDhE6vM+Vx6mbYBSaa4RteI4UC70oW4hC7N
        ultdINtK4Ovw2mzOVYd2W3jK/QJ3DaLCF3yLoyQ=
X-Google-Smtp-Source: ABdhPJwo0XBqiHHUIO6XyHIdAOH9CPLuxFj4lP2Z6dXXBx9rg7iYSkxRTLReIiq7ZmdbD4TMf5727pfCw/PuqDfTgHo=
X-Received: by 2002:a67:f9d6:: with SMTP id c22mr9287676vsq.14.1591437443752;
 Sat, 06 Jun 2020 02:57:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200522123837.1196-1-rgoldwyn@suse.de> <20200522123837.1196-5-rgoldwyn@suse.de>
 <SN4PR0401MB35981C3BAEDA15CC85D13AE79BB00@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20200526164428.sirhx6yjsghxpnqt@fiona> <CAL3q7H6eVOTggceRgZakmoh8jNRJm5BXwNqE0Mx3By5_GgH5YA@mail.gmail.com>
 <20200528163450.uykayisbrn6hfm2z@fiona> <CAL3q7H700X4E5-NjTWcWwosBwLuKeFPOPx00f+OVn=2fBfmJbQ@mail.gmail.com>
 <20200528183848.siuljkvqmxbqa436@fiona> <CAL3q7H4SMOJEkAgQEd+i=yeJP20Mv7AthbxaE2==BVr=SGtyjg@mail.gmail.com>
 <CAL3q7H6Hvjzi_bcKZFprApkrnoUDFGHO9wD52xSjS1rZ0_cbVA@mail.gmail.com> <20200605204345.benpwz2rwfivovmn@fiona>
In-Reply-To: <20200605204345.benpwz2rwfivovmn@fiona>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Sat, 6 Jun 2020 10:57:12 +0100
Message-ID: <CAL3q7H4F9iQJy3tgwZrWOKwenAnnn7oSthQZUMEJ_vWx3WE3WQ@mail.gmail.com>
Subject: Re: [PATCH 4/7] btrfs: Switch to iomap_dio_rw() for dio
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "dsterba@suse.cz" <dsterba@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jun 5, 2020 at 9:43 PM Goldwyn Rodrigues <rgoldwyn@suse.de> wrote:
>
> On 16:17 05/06, Filipe Manana wrote:
> > On Wed, Jun 3, 2020 at 12:35 PM Filipe Manana <fdmanana@gmail.com> wrot=
e:
> > >
> > > On Thu, May 28, 2020 at 7:38 PM Goldwyn Rodrigues <rgoldwyn@suse.de> =
wrote:
> > > >
> > > > On 17:45 28/05, Filipe Manana wrote:
> > > > > On Thu, May 28, 2020 at 5:34 PM Goldwyn Rodrigues <rgoldwyn@suse.=
de> wrote:
> > > > > > > And who locked the extent range before?
> > > > > >
> > > > > > This is usually locked by a previous buffered write or read.
> > > > >
> > > > > A previous buffered write/read that has already finished or is st=
ill
> > > > > in progress?
> > > > >
> > > > > Because if it has finished we're not supposed to have the file ra=
nge
> > > > > locked anymore.
> > > >
> > > > In progress. Mixing buffered I/O with direct writes.
> > > >
> > > > >
> > > > > >
> > > > > > >
> > > > > > > That seems alarming to me, specially if it's a direct IO writ=
e failing
> > > > > > > to invalidate the page cache, since a subsequent buffered rea=
d could
> > > > > > > get stale data (what's in the page cache), and not what the d=
irect IO
> > > > > > > write wrote.
> > > > > > >
> > > > > > > Can you elaborate more on all those details?
> > > > > >
> > > > > > The origin of the message is when iomap_dio_rw() tries to inval=
idate the
> > > > > > inode pages, but fails and calls dio_warn_stale_pagecache().
> > > > > >
> > > > > > In the vanilla code, generic_file_direct_write() aborts direct =
writes
> > > > > > and returns 0 so that it may fallback to buffered I/O. Perhaps =
this
> > > > > > should be changed in iomap_dio_rw() as well. I will write a pat=
ch to
> > > > > > accomodate that.
> > > > >
> > > > > On vanilla we have no problems of mixing buffered and direct
> > > > > operations as long as they are done sequentially at least.
> > > > > And even if done concurrently we take several measures to ensure =
that
> > > > > are no surprises (locking ranges, waiting for any ordered extents=
 in
> > > > > progress, etc).
> > > >
> > > > Yes, it is because of the code in generic_file_direct_write(). Anyw=
ays,
> > > > I did some tests with the following patch, and it seems to work. I =
will
> > > > send a formal patch to so that it gets incorporated in iomap sequen=
ce as
> > > > well.
> > > >
> > > > diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> > > > index e4addfc58107..215315be6233 100644
> > > > --- a/fs/iomap/direct-io.c
> > > > +++ b/fs/iomap/direct-io.c
> > > > @@ -483,9 +483,15 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_it=
er *iter,
> > > >          */
> > > >         ret =3D invalidate_inode_pages2_range(mapping,
> > > >                         pos >> PAGE_SHIFT, end >> PAGE_SHIFT);
> > > > -       if (ret)
> > > > -               dio_warn_stale_pagecache(iocb->ki_filp);
> > > > -       ret =3D 0;
> > > > +       /*
> > > > +        * If a page can not be invalidated, return 0 to fall back
> > > > +        * to buffered write.
> > > > +        */
> > > > +       if (ret) {
> > > > +               if (ret =3D=3D -EBUSY)
> > > > +                       ret =3D 0;
> > > > +               goto out_free_dio;
> > > > +       }
> > > >
> > > >         if (iov_iter_rw(iter) =3D=3D WRITE && !wait_for_completion =
&&
> > > >             !inode->i_sb->s_dio_done_wq) {
> > > >
> > > >
> > >
> > > Thanks. As I just replied on another thread for that patch, we
> > > actually have a regression.
> > > There's more than the annoying warning in dmesg, it also sets -EIO on
> > > the inode's mapping and makes future fsyncs return that error despite
> > > the fact that no actual errors or corruptions happened:
> > >
> > > https://patchwork.kernel.org/patch/11576677/
> > >
> >
> > There's also some deadlock/hang, I have triggered it twice today with
> > generic/113 on two different VMs:
> >
> > [14621.297370] INFO: task kworker/1:117:15962 blocked for more than 120=
 seconds.
> > [14621.298491]       Not tainted 5.7.0-rc7-btrfs-next-59 #1
> > [14621.299231] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> > disables this message.
> > [14621.300523] kworker/1:117   D    0 15962      2 0x80004000
> > [14621.301558] Workqueue: dio/sdb iomap_dio_complete_work
> > [14621.302389] Call Trace:
> > [14621.302877]  __schedule+0x384/0xa30
> > [14621.303555]  schedule+0x33/0xe0
> > [14621.304167]  rwsem_down_write_slowpath+0x2c2/0x750
> > [14621.305121]  ? btrfs_sync_file+0x1fe/0x4d0 [btrfs]
> > [14621.306217]  btrfs_sync_file+0x1fe/0x4d0 [btrfs]
> > [14621.307113]  iomap_dio_complete+0x11b/0x260
> > [14621.307888]  ? aio_fsync_work+0x5b0/0x5b0
> > [14621.308585]  iomap_dio_complete_work+0x17/0x30
> > [14621.309476]  process_one_work+0x275/0x6b0
> > [14621.310275]  worker_thread+0x4f/0x3e0
> > [14621.310869]  ? process_one_work+0x6b0/0x6b0
> > [14621.311403]  kthread+0x12a/0x170
> > [14621.311819]  ? kthread_create_worker_on_cpu+0x70/0x70
> > [14621.312460]  ret_from_fork+0x3a/0x50
> > [14621.312983] INFO: task kworker/1:199:16063 blocked for more than 120=
 seconds.
> > [14621.313921]       Not tainted 5.7.0-rc7-btrfs-next-59 #1
> > [14621.314680] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> > disables this message.
> > [14621.315724] kworker/1:199   D    0 16063      2 0x80004000
> > [14621.316445] Workqueue: dio/sdb iomap_dio_complete_work
> > [14621.317101] Call Trace:
> > [14621.317437]  __schedule+0x384/0xa30
> > [14621.317928]  schedule+0x33/0xe0
> > [14621.318339]  rwsem_down_write_slowpath+0x2c2/0x750
> > [14621.318981]  ? btrfs_sync_file+0x1fe/0x4d0 [btrfs]
> > [14621.319609]  btrfs_sync_file+0x1fe/0x4d0 [btrfs]
> > [14621.320203]  iomap_dio_complete+0x11b/0x260
> > [14621.320721]  ? aio_fsync_work+0x5b0/0x5b0
> > [14621.321249]  iomap_dio_complete_work+0x17/0x30
> > [14621.321844]  process_one_work+0x275/0x6b0
> > [14621.322376]  worker_thread+0x4f/0x3e0
> > [14621.322871]  ? process_one_work+0x6b0/0x6b0
> > [14621.323408]  kthread+0x12a/0x170
> > [14621.323827]  ? kthread_create_worker_on_cpu+0x70/0x70
> > [14621.324473]  ret_from_fork+0x3a/0x50
> > [14621.324983] INFO: task aio-stress:16274 blocked for more than 120 se=
conds.
> > [14621.325896]       Not tainted 5.7.0-rc7-btrfs-next-59 #1
> > [14621.326579] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> > disables this message.
> > [14621.327580] aio-stress      D    0 16274  14855 0x00004000
> > [14621.328280] Call Trace:
> > [14621.328602]  __schedule+0x384/0xa30
> > [14621.329056]  schedule+0x33/0xe0
> > [14621.329478]  rwsem_down_write_slowpath+0x2c2/0x750
> > [14621.330118]  ? btrfs_sync_file+0x219/0x4d0 [btrfs]
> > [14621.330747]  btrfs_sync_file+0x219/0x4d0 [btrfs]
> > [14621.331346]  iomap_dio_complete+0x11b/0x260
> > [14621.331886]  iomap_dio_rw+0x3bc/0x4c0
> > [14621.332372]  ? btrfs_file_write_iter+0x645/0x870 [btrfs]
> > [14621.333076]  btrfs_file_write_iter+0x645/0x870 [btrfs]
> > [14621.333749]  aio_write+0x148/0x1d0
> > [14621.334196]  ? lock_acquire+0xb1/0x4a0
> > [14621.334682]  ? __might_fault+0x3e/0x90
> > [14621.335172]  ? __fget_files+0x132/0x270
> > [14621.335668]  ? io_submit_one+0x946/0x1630
> > [14621.336184]  io_submit_one+0x946/0x1630
> > [14621.336680]  ? lock_acquire+0xb1/0x4a0
> > [14621.337175]  ? __might_fault+0x3e/0x90
> > [14621.337707]  ? __x64_sys_io_submit+0x9c/0x330
> > [14621.338269]  __x64_sys_io_submit+0x9c/0x330
> > [14621.338812]  ? do_syscall_64+0x5c/0x280
> > [14621.339303]  do_syscall_64+0x5c/0x280
> > [14621.339774]  entry_SYSCALL_64_after_hwframe+0x49/0xb3
> > [14621.340416] RIP: 0033:0x7fb6cd395717
> > [14621.340875] Code: Bad RIP value.
> > [14621.341304] RSP: 002b:00007fb6bf7e1de8 EFLAGS: 00000202 ORIG_RAX:
> > 00000000000000d1
> > [14621.342262] RAX: ffffffffffffffda RBX: 0000560d3d92ea60 RCX: 00007fb=
6cd395717
> > [14621.343180] RDX: 0000560d3d92ea60 RSI: 0000000000000008 RDI: 00007fb=
6cdb32000
> > [14621.344081] RBP: 0000000000000008 R08: 0000150e50ac6651 R09: 0000000=
0003081a8
> > [14621.344981] R10: 00007fb6bf7e1df0 R11: 0000000000000202 R12: 0000560=
d3d8fe110
> > [14621.345897] R13: 00007fb6bf7e1e10 R14: 00007fb6bf7e1e00 R15: 0000560=
d3d8fe110
> > [14621.346820] INFO: lockdep is turned off.
> > [14742.125500] INFO: task kworker/1:117:15962 blocked for more than 241=
 seconds.
> > [14742.126456]       Not tainted 5.7.0-rc7-btrfs-next-59 #1
> > [14742.127156] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> > disables this message.
> > [14742.128156] kworker/1:117   D    0 15962      2 0x80004000
> > [14742.128875] Workqueue: dio/sdb iomap_dio_complete_work
> > [14742.129633] Call Trace:
> > [14742.130010]  __schedule+0x384/0xa30
> > [14742.130494]  schedule+0x33/0xe0
> > [14742.131068]  rwsem_down_write_slowpath+0x2c2/0x750
> > [14742.131956]  ? btrfs_sync_file+0x1fe/0x4d0 [btrfs]
> > [14742.132834]  btrfs_sync_file+0x1fe/0x4d0 [btrfs]
> > [14742.133712]  iomap_dio_complete+0x11b/0x260
> > [14742.134475]  ? aio_fsync_work+0x5b0/0x5b0
> > [14742.135205]  iomap_dio_complete_work+0x17/0x30
> > [14742.136018]  process_one_work+0x275/0x6b0
> > [14742.136677]  worker_thread+0x4f/0x3e0
> > [14742.137154]  ? process_one_work+0x6b0/0x6b0
> > [14742.137805]  kthread+0x12a/0x170
> > [14742.138236]  ? kthread_create_worker_on_cpu+0x70/0x70
> > [14742.138901]  ret_from_fork+0x3a/0x50
> > [14742.139389] INFO: task kworker/1:199:16063 blocked for more than 241=
 seconds.
> > [14742.140305]       Not tainted 5.7.0-rc7-btrfs-next-59 #1
> > [14742.140998] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> > disables this message.
> > [14742.142056] kworker/1:199   D    0 16063      2 0x80004000
> > [14742.142877] Workqueue: dio/sdb iomap_dio_complete_work
> > [14742.143397] Call Trace:
> > [14742.143654]  __schedule+0x384/0xa30
> > [14742.144017]  schedule+0x33/0xe0
> > [14742.144352]  rwsem_down_write_slowpath+0x2c2/0x750
> > [14742.144859]  ? btrfs_sync_file+0x1fe/0x4d0 [btrfs]
> > [14742.145386]  btrfs_sync_file+0x1fe/0x4d0 [btrfs]
> > [14742.145863]  iomap_dio_complete+0x11b/0x260
> > [14742.146289]  ? aio_fsync_work+0x5b0/0x5b0
> > [14742.146701]  iomap_dio_complete_work+0x17/0x30
> > [14742.147168]  process_one_work+0x275/0x6b0
> > [14742.147579]  worker_thread+0x4f/0x3e0
> > [14742.147954]  ? process_one_work+0x6b0/0x6b0
> > [14742.148377]  kthread+0x12a/0x170
> > [14742.148722]  ? kthread_create_worker_on_cpu+0x70/0x70
> > [14742.149257]  ret_from_fork+0x3a/0x50
> > [14742.149671] INFO: task aio-stress:16274 blocked for more than 241 se=
conds.
> > [14742.150376]       Not tainted 5.7.0-rc7-btrfs-next-59 #1
> > [14742.150948] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> > disables this message.
> > [14742.151962] aio-stress      D    0 16274  14855 0x00004000
> > (...)
> >
>
> Seems like the btrfs_inode->dio_sem. Would you have more information on
> which process is holding on to it, or if there was a failure?

This happens 100% of the time.

At btrfs_direct_write():

down_read(&BTRFS_I(inode)->dio_sem);
written =3D iomap_dio_rw(iocb, from, &btrfs_dio_iomap_ops, &btrfs_dops,
       is_sync_kiocb(iocb));
up_read(&BTRFS_I(inode)->dio_sem);

than through iomap_dio_rw(), we end up calling btrfs_sync_file(),
which tries to down_write() the dio_sem.

>
> I will try to reproduce at my end. Thanks for testing.

You should have no difficulty reproducing it.

And another lockdep warning:

[  422.202844] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  422.204113] WARNING: possible recursive locking detected
[  422.205014] 5.7.0-rc7-btrfs-next-59 #1 Not tainted
[  422.205722] --------------------------------------------
[  422.206598] aio-stress/1665 is trying to acquire lock:
[  422.207776] ffff8fbc9a24d620
(&sb->s_type->i_mutex_key#14){++++}-{3:3}, at:
btrfs_sync_file+0x1fe/0x4d0 [btrfs]
[  422.209538]
               but task is already holding lock:
[  422.210424] ffff8fbc9a24d620
(&sb->s_type->i_mutex_key#14){++++}-{3:3}, at:
btrfs_file_write_iter+0x80/0x870 [btrfs]
[  422.212075]
               other info that might help us debug this:
[  422.213089]  Possible unsafe locking scenario:

[  422.214141]        CPU0
[  422.214578]        ----
[  422.215098]   lock(&sb->s_type->i_mutex_key#14);
[  422.215990]   lock(&sb->s_type->i_mutex_key#14);
[  422.216940]
                *** DEADLOCK ***

[  422.218115]  May be due to missing lock nesting notation

[  422.219060] 2 locks held by aio-stress/1665:
[  422.219815]  #0: ffff8fbc9a24d620
(&sb->s_type->i_mutex_key#14){++++}-{3:3}, at:
btrfs_file_write_iter+0x80/0x870 [btrfs]
[  422.221516]  #1: ffff8fbc9a24d4a8 (&ei->dio_sem){++++}-{3:3}, at:
btrfs_file_write_iter+0x6b4/0x870 [btrfs]
[  422.223437]
               stack backtrace:
[  422.224335] CPU: 0 PID: 1665 Comm: aio-stress Not tainted
5.7.0-rc7-btrfs-next-59 #1
[  422.225960] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
[  422.227728] Call Trace:
[  422.228046]  dump_stack+0x87/0xcb
[  422.228667]  __lock_acquire+0x17d0/0x21a0
[  422.229545]  lock_acquire+0xb1/0x4a0
[  422.230272]  ? btrfs_sync_file+0x1fe/0x4d0 [btrfs]
[  422.231250]  down_write+0x38/0x70
[  422.231821]  ? btrfs_sync_file+0x1fe/0x4d0 [btrfs]
[  422.232502]  btrfs_sync_file+0x1fe/0x4d0 [btrfs]
[  422.233169]  iomap_dio_complete+0x11b/0x260
[  422.233838]  iomap_dio_rw+0x3bc/0x4c0
[  422.234404]  ? btrfs_file_write_iter+0x6d9/0x870 [btrfs]
[  422.235311]  btrfs_file_write_iter+0x6d9/0x870 [btrfs]
[  422.236250]  aio_write+0x148/0x1d0
[  422.236872]  ? lock_acquire+0xb1/0x4a0
[  422.237560]  ? __might_fault+0x3e/0x90
[  422.238291]  ? __might_fault+0x3e/0x90
[  422.239002]  ? io_submit_one+0x946/0x1630
[  422.239874]  io_submit_one+0x946/0x1630
[  422.240565]  ? lock_acquire+0xb1/0x4a0
[  422.241162]  ? __might_fault+0x3e/0x90
[  422.241711]  ? __x64_sys_io_submit+0x9c/0x330
[  422.242336]  __x64_sys_io_submit+0x9c/0x330
[  422.242943]  ? do_syscall_64+0x5c/0x280
[  422.243420]  do_syscall_64+0x5c/0x280
[  422.243878]  entry_SYSCALL_64_after_hwframe+0x49/0xb3
[  422.244626] RIP: 0033:0x7f77e38aa717
[  422.245219] Code: 00 75 08 8b 47 0c 39 47 08 74 08 e9 c3 ff ff ff
0f 1f 00 31 c0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 b8 d1 00 00
00 0f 05 <c3> 0f 1f 84 00 00 00 00 00 b8 d2 00 00 00 0f 05 c3 0f 1f 84
00 00
[  422.247827] RSP: 002b:00007f77d6cf8de8 EFLAGS: 00000202 ORIG_RAX:
00000000000000d1
[  422.248924] RAX: ffffffffffffffda RBX: 000055c78674c400 RCX: 00007f77e38=
aa717
[  422.249959] RDX: 000055c78674c400 RSI: 0000000000000008 RDI: 00007f77e40=
59000
[  422.250924] RBP: 0000000000000008 R08: 000000a0afa4d2c9 R09: 00000000000=
09e34
[  422.251958] R10: 00007f77d6cf8df0 R11: 0000000000000202 R12: 000055c7867=
20f10
[  422.252989] R13: 00007f77d6cf8e10 R14: 00007f77d6cf8e00 R15: 000055c7867=
20f10

Thanks.

>
> --
> Goldwyn



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
