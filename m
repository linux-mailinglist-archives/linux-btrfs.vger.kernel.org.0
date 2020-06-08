Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D45C41F1C3D
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jun 2020 17:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730237AbgFHPjk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Jun 2020 11:39:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:43986 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729580AbgFHPjj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 8 Jun 2020 11:39:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 46AE1AC4A;
        Mon,  8 Jun 2020 15:39:41 +0000 (UTC)
Date:   Mon, 8 Jun 2020 10:39:34 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     Filipe Manana <fdmanana@gmail.com>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "dsterba@suse.cz" <dsterba@suse.cz>
Subject: Re: [PATCH 4/7] btrfs: Switch to iomap_dio_rw() for dio
Message-ID: <20200608153934.stmv2prkukp65fbr@fiona>
References: <SN4PR0401MB35981C3BAEDA15CC85D13AE79BB00@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20200526164428.sirhx6yjsghxpnqt@fiona>
 <CAL3q7H6eVOTggceRgZakmoh8jNRJm5BXwNqE0Mx3By5_GgH5YA@mail.gmail.com>
 <20200528163450.uykayisbrn6hfm2z@fiona>
 <CAL3q7H700X4E5-NjTWcWwosBwLuKeFPOPx00f+OVn=2fBfmJbQ@mail.gmail.com>
 <20200528183848.siuljkvqmxbqa436@fiona>
 <CAL3q7H4SMOJEkAgQEd+i=yeJP20Mv7AthbxaE2==BVr=SGtyjg@mail.gmail.com>
 <CAL3q7H6Hvjzi_bcKZFprApkrnoUDFGHO9wD52xSjS1rZ0_cbVA@mail.gmail.com>
 <20200605204345.benpwz2rwfivovmn@fiona>
 <CAL3q7H4F9iQJy3tgwZrWOKwenAnnn7oSthQZUMEJ_vWx3WE3WQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H4F9iQJy3tgwZrWOKwenAnnn7oSthQZUMEJ_vWx3WE3WQ@mail.gmail.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10:57 06/06, Filipe Manana wrote:
> On Fri, Jun 5, 2020 at 9:43 PM Goldwyn Rodrigues <rgoldwyn@suse.de> wrote:
> >
> > On 16:17 05/06, Filipe Manana wrote:
> > > On Wed, Jun 3, 2020 at 12:35 PM Filipe Manana <fdmanana@gmail.com> wrote:
> > > >
> > > > On Thu, May 28, 2020 at 7:38 PM Goldwyn Rodrigues <rgoldwyn@suse.de> wrote:
> > > > >
> > > > > On 17:45 28/05, Filipe Manana wrote:
> > > > > > On Thu, May 28, 2020 at 5:34 PM Goldwyn Rodrigues <rgoldwyn@suse.de> wrote:
> > > > > > > > And who locked the extent range before?
> > > > > > >
> > > > > > > This is usually locked by a previous buffered write or read.
> > > > > >
> > > > > > A previous buffered write/read that has already finished or is still
> > > > > > in progress?
> > > > > >
> > > > > > Because if it has finished we're not supposed to have the file range
> > > > > > locked anymore.
> > > > >
> > > > > In progress. Mixing buffered I/O with direct writes.
> > > > >
> > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > That seems alarming to me, specially if it's a direct IO write failing
> > > > > > > > to invalidate the page cache, since a subsequent buffered read could
> > > > > > > > get stale data (what's in the page cache), and not what the direct IO
> > > > > > > > write wrote.
> > > > > > > >
> > > > > > > > Can you elaborate more on all those details?
> > > > > > >
> > > > > > > The origin of the message is when iomap_dio_rw() tries to invalidate the
> > > > > > > inode pages, but fails and calls dio_warn_stale_pagecache().
> > > > > > >
> > > > > > > In the vanilla code, generic_file_direct_write() aborts direct writes
> > > > > > > and returns 0 so that it may fallback to buffered I/O. Perhaps this
> > > > > > > should be changed in iomap_dio_rw() as well. I will write a patch to
> > > > > > > accomodate that.
> > > > > >
> > > > > > On vanilla we have no problems of mixing buffered and direct
> > > > > > operations as long as they are done sequentially at least.
> > > > > > And even if done concurrently we take several measures to ensure that
> > > > > > are no surprises (locking ranges, waiting for any ordered extents in
> > > > > > progress, etc).
> > > > >
> > > > > Yes, it is because of the code in generic_file_direct_write(). Anyways,
> > > > > I did some tests with the following patch, and it seems to work. I will
> > > > > send a formal patch to so that it gets incorporated in iomap sequence as
> > > > > well.
> > > > >
> > > > > diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> > > > > index e4addfc58107..215315be6233 100644
> > > > > --- a/fs/iomap/direct-io.c
> > > > > +++ b/fs/iomap/direct-io.c
> > > > > @@ -483,9 +483,15 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
> > > > >          */
> > > > >         ret = invalidate_inode_pages2_range(mapping,
> > > > >                         pos >> PAGE_SHIFT, end >> PAGE_SHIFT);
> > > > > -       if (ret)
> > > > > -               dio_warn_stale_pagecache(iocb->ki_filp);
> > > > > -       ret = 0;
> > > > > +       /*
> > > > > +        * If a page can not be invalidated, return 0 to fall back
> > > > > +        * to buffered write.
> > > > > +        */
> > > > > +       if (ret) {
> > > > > +               if (ret == -EBUSY)
> > > > > +                       ret = 0;
> > > > > +               goto out_free_dio;
> > > > > +       }
> > > > >
> > > > >         if (iov_iter_rw(iter) == WRITE && !wait_for_completion &&
> > > > >             !inode->i_sb->s_dio_done_wq) {
> > > > >
> > > > >
> > > >
> > > > Thanks. As I just replied on another thread for that patch, we
> > > > actually have a regression.
> > > > There's more than the annoying warning in dmesg, it also sets -EIO on
> > > > the inode's mapping and makes future fsyncs return that error despite
> > > > the fact that no actual errors or corruptions happened:
> > > >
> > > > https://patchwork.kernel.org/patch/11576677/
> > > >
> > >
> > > There's also some deadlock/hang, I have triggered it twice today with
> > > generic/113 on two different VMs:
> > >
> > > [14621.297370] INFO: task kworker/1:117:15962 blocked for more than 120 seconds.
> > > [14621.298491]       Not tainted 5.7.0-rc7-btrfs-next-59 #1
> > > [14621.299231] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> > > disables this message.
> > > [14621.300523] kworker/1:117   D    0 15962      2 0x80004000
> > > [14621.301558] Workqueue: dio/sdb iomap_dio_complete_work
> > > [14621.302389] Call Trace:
> > > [14621.302877]  __schedule+0x384/0xa30
> > > [14621.303555]  schedule+0x33/0xe0
> > > [14621.304167]  rwsem_down_write_slowpath+0x2c2/0x750
> > > [14621.305121]  ? btrfs_sync_file+0x1fe/0x4d0 [btrfs]
> > > [14621.306217]  btrfs_sync_file+0x1fe/0x4d0 [btrfs]
> > > [14621.307113]  iomap_dio_complete+0x11b/0x260
> > > [14621.307888]  ? aio_fsync_work+0x5b0/0x5b0
> > > [14621.308585]  iomap_dio_complete_work+0x17/0x30
> > > [14621.309476]  process_one_work+0x275/0x6b0
> > > [14621.310275]  worker_thread+0x4f/0x3e0
> > > [14621.310869]  ? process_one_work+0x6b0/0x6b0
> > > [14621.311403]  kthread+0x12a/0x170
> > > [14621.311819]  ? kthread_create_worker_on_cpu+0x70/0x70
> > > [14621.312460]  ret_from_fork+0x3a/0x50
> > > [14621.312983] INFO: task kworker/1:199:16063 blocked for more than 120 seconds.
> > > [14621.313921]       Not tainted 5.7.0-rc7-btrfs-next-59 #1
> > > [14621.314680] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> > > disables this message.
> > > [14621.315724] kworker/1:199   D    0 16063      2 0x80004000
> > > [14621.316445] Workqueue: dio/sdb iomap_dio_complete_work
> > > [14621.317101] Call Trace:
> > > [14621.317437]  __schedule+0x384/0xa30
> > > [14621.317928]  schedule+0x33/0xe0
> > > [14621.318339]  rwsem_down_write_slowpath+0x2c2/0x750
> > > [14621.318981]  ? btrfs_sync_file+0x1fe/0x4d0 [btrfs]
> > > [14621.319609]  btrfs_sync_file+0x1fe/0x4d0 [btrfs]
> > > [14621.320203]  iomap_dio_complete+0x11b/0x260
> > > [14621.320721]  ? aio_fsync_work+0x5b0/0x5b0
> > > [14621.321249]  iomap_dio_complete_work+0x17/0x30
> > > [14621.321844]  process_one_work+0x275/0x6b0
> > > [14621.322376]  worker_thread+0x4f/0x3e0
> > > [14621.322871]  ? process_one_work+0x6b0/0x6b0
> > > [14621.323408]  kthread+0x12a/0x170
> > > [14621.323827]  ? kthread_create_worker_on_cpu+0x70/0x70
> > > [14621.324473]  ret_from_fork+0x3a/0x50
> > > [14621.324983] INFO: task aio-stress:16274 blocked for more than 120 seconds.
> > > [14621.325896]       Not tainted 5.7.0-rc7-btrfs-next-59 #1
> > > [14621.326579] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> > > disables this message.
> > > [14621.327580] aio-stress      D    0 16274  14855 0x00004000
> > > [14621.328280] Call Trace:
> > > [14621.328602]  __schedule+0x384/0xa30
> > > [14621.329056]  schedule+0x33/0xe0
> > > [14621.329478]  rwsem_down_write_slowpath+0x2c2/0x750
> > > [14621.330118]  ? btrfs_sync_file+0x219/0x4d0 [btrfs]
> > > [14621.330747]  btrfs_sync_file+0x219/0x4d0 [btrfs]
> > > [14621.331346]  iomap_dio_complete+0x11b/0x260
> > > [14621.331886]  iomap_dio_rw+0x3bc/0x4c0
> > > [14621.332372]  ? btrfs_file_write_iter+0x645/0x870 [btrfs]
> > > [14621.333076]  btrfs_file_write_iter+0x645/0x870 [btrfs]
> > > [14621.333749]  aio_write+0x148/0x1d0
> > > [14621.334196]  ? lock_acquire+0xb1/0x4a0
> > > [14621.334682]  ? __might_fault+0x3e/0x90
> > > [14621.335172]  ? __fget_files+0x132/0x270
> > > [14621.335668]  ? io_submit_one+0x946/0x1630
> > > [14621.336184]  io_submit_one+0x946/0x1630
> > > [14621.336680]  ? lock_acquire+0xb1/0x4a0
> > > [14621.337175]  ? __might_fault+0x3e/0x90
> > > [14621.337707]  ? __x64_sys_io_submit+0x9c/0x330
> > > [14621.338269]  __x64_sys_io_submit+0x9c/0x330
> > > [14621.338812]  ? do_syscall_64+0x5c/0x280
> > > [14621.339303]  do_syscall_64+0x5c/0x280
> > > [14621.339774]  entry_SYSCALL_64_after_hwframe+0x49/0xb3
> > > [14621.340416] RIP: 0033:0x7fb6cd395717
> > > [14621.340875] Code: Bad RIP value.
> > > [14621.341304] RSP: 002b:00007fb6bf7e1de8 EFLAGS: 00000202 ORIG_RAX:
> > > 00000000000000d1
> > > [14621.342262] RAX: ffffffffffffffda RBX: 0000560d3d92ea60 RCX: 00007fb6cd395717
> > > [14621.343180] RDX: 0000560d3d92ea60 RSI: 0000000000000008 RDI: 00007fb6cdb32000
> > > [14621.344081] RBP: 0000000000000008 R08: 0000150e50ac6651 R09: 00000000003081a8
> > > [14621.344981] R10: 00007fb6bf7e1df0 R11: 0000000000000202 R12: 0000560d3d8fe110
> > > [14621.345897] R13: 00007fb6bf7e1e10 R14: 00007fb6bf7e1e00 R15: 0000560d3d8fe110
> > > [14621.346820] INFO: lockdep is turned off.
> > > [14742.125500] INFO: task kworker/1:117:15962 blocked for more than 241 seconds.
> > > [14742.126456]       Not tainted 5.7.0-rc7-btrfs-next-59 #1
> > > [14742.127156] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> > > disables this message.
> > > [14742.128156] kworker/1:117   D    0 15962      2 0x80004000
> > > [14742.128875] Workqueue: dio/sdb iomap_dio_complete_work
> > > [14742.129633] Call Trace:
> > > [14742.130010]  __schedule+0x384/0xa30
> > > [14742.130494]  schedule+0x33/0xe0
> > > [14742.131068]  rwsem_down_write_slowpath+0x2c2/0x750
> > > [14742.131956]  ? btrfs_sync_file+0x1fe/0x4d0 [btrfs]
> > > [14742.132834]  btrfs_sync_file+0x1fe/0x4d0 [btrfs]
> > > [14742.133712]  iomap_dio_complete+0x11b/0x260
> > > [14742.134475]  ? aio_fsync_work+0x5b0/0x5b0
> > > [14742.135205]  iomap_dio_complete_work+0x17/0x30
> > > [14742.136018]  process_one_work+0x275/0x6b0
> > > [14742.136677]  worker_thread+0x4f/0x3e0
> > > [14742.137154]  ? process_one_work+0x6b0/0x6b0
> > > [14742.137805]  kthread+0x12a/0x170
> > > [14742.138236]  ? kthread_create_worker_on_cpu+0x70/0x70
> > > [14742.138901]  ret_from_fork+0x3a/0x50
> > > [14742.139389] INFO: task kworker/1:199:16063 blocked for more than 241 seconds.
> > > [14742.140305]       Not tainted 5.7.0-rc7-btrfs-next-59 #1
> > > [14742.140998] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> > > disables this message.
> > > [14742.142056] kworker/1:199   D    0 16063      2 0x80004000
> > > [14742.142877] Workqueue: dio/sdb iomap_dio_complete_work
> > > [14742.143397] Call Trace:
> > > [14742.143654]  __schedule+0x384/0xa30
> > > [14742.144017]  schedule+0x33/0xe0
> > > [14742.144352]  rwsem_down_write_slowpath+0x2c2/0x750
> > > [14742.144859]  ? btrfs_sync_file+0x1fe/0x4d0 [btrfs]
> > > [14742.145386]  btrfs_sync_file+0x1fe/0x4d0 [btrfs]
> > > [14742.145863]  iomap_dio_complete+0x11b/0x260
> > > [14742.146289]  ? aio_fsync_work+0x5b0/0x5b0
> > > [14742.146701]  iomap_dio_complete_work+0x17/0x30
> > > [14742.147168]  process_one_work+0x275/0x6b0
> > > [14742.147579]  worker_thread+0x4f/0x3e0
> > > [14742.147954]  ? process_one_work+0x6b0/0x6b0
> > > [14742.148377]  kthread+0x12a/0x170
> > > [14742.148722]  ? kthread_create_worker_on_cpu+0x70/0x70
> > > [14742.149257]  ret_from_fork+0x3a/0x50
> > > [14742.149671] INFO: task aio-stress:16274 blocked for more than 241 seconds.
> > > [14742.150376]       Not tainted 5.7.0-rc7-btrfs-next-59 #1
> > > [14742.150948] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> > > disables this message.
> > > [14742.151962] aio-stress      D    0 16274  14855 0x00004000
> > > (...)
> > >
> >
> > Seems like the btrfs_inode->dio_sem. Would you have more information on
> > which process is holding on to it, or if there was a failure?
> 
> This happens 100% of the time.
> 
> At btrfs_direct_write():
> 
> down_read(&BTRFS_I(inode)->dio_sem);
> written = iomap_dio_rw(iocb, from, &btrfs_dio_iomap_ops, &btrfs_dops,
>        is_sync_kiocb(iocb));
> up_read(&BTRFS_I(inode)->dio_sem);
> 
> than through iomap_dio_rw(), we end up calling btrfs_sync_file(),
> which tries to down_write() the dio_sem.

I see what is happening in the code. Also, we have generic_write_sync()
called  twice. I will work on this. Surprisingly generic/113 works just
fine for me.

Thanks,



-- 
Goldwyn
