Return-Path: <linux-btrfs+bounces-14505-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D00BCACF807
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jun 2025 21:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F18E189DE4E
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jun 2025 19:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5A127BF80;
	Thu,  5 Jun 2025 19:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LRuS6SRQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3451F12F8
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Jun 2025 19:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749151886; cv=none; b=EhM/e9ijLvCwKO8q8BK6tH08dCUo/FVV0qVZvDOxhLR/egQpaHYR+0G3Rj4bbs3mF+NKzlJfldf1EzaV3LKSGMzZR8LYkXsoGxs1JSLHuENfrL4q16aZ9r7Nt2ZzaCGQ0Qiu2mYiADCXXUmzmwsW+gClXP+Z6DWlD6KoOqlMyOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749151886; c=relaxed/simple;
	bh=Vb3zDqy3p/iaFhvOuPBB5LWLkHWCJy+QDCVcxpPZxI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ClEiuaNvGcV3H9fBK0pGh9AM7VAGxRFJwN5rzcbhBjFgNXt/ExlC6f4GK3J5XdfRwEX9VIf+cMIIikAsA2sAZ7l2PVmvSqsrCY6u4detckO8HBthn/18RuMBm9X7wB1qGK30ah6wb9XgG95nfqCg38AVgjhOoUWutWsojbisgNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LRuS6SRQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D0CFC4CEF0
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Jun 2025 19:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749151885;
	bh=Vb3zDqy3p/iaFhvOuPBB5LWLkHWCJy+QDCVcxpPZxI4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LRuS6SRQFbTYhMdCuuypMUcAOQut6jdZpjrOQLPH5PA2nZEyFy8528Y+V4ZwcgMvR
	 ooyzT1RKMMcFvjD2PvbzydG+aXL6H+uha6YEON2NBqJCpWzKGKXjEM1/QvCuuu7Ikl
	 xUdSQuG2+jId5h6AqF5wKu1bDu0EmFKTPa2ysBCFdBt7Yf2MfdlSlK9KihdKoigyhP
	 ODu3cDM7TkRLbv1m04tWwcG2ZcmynHMEr5HWUqrDZLEX4Momg35xWenXbD5ikgRkZc
	 taIH5J07UNIMc4iwl6fslBpvg9w9HLIBZg5XfDu6H1LTfxF/vIBbgFFJOzZHQ025SY
	 diPe/jCBEKusw==
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a503d9ef59so1071664f8f.3
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Jun 2025 12:31:25 -0700 (PDT)
X-Gm-Message-State: AOJu0Ywux4rMqEit9IIpINOHfqJjhQoi5Ix3S7BzAjJWubEIX1uGbuqI
	3y+ON1tSXKTe0oWvj4VP914tYlPM2tfmdJ3HvrS4gxN2TI+IspM6hoTtW6Q4ImaINbmGeQFlC+A
	A8SKsvPEyw3koNjBnek1f3FCTfcGum9Y=
X-Google-Smtp-Source: AGHT+IFYFtNKa8ze2eogogkqQX7kcRT4Nlq2ZrUOuQnMnxeqos7nMIDP4lJPsEifWR36aZUk6RWVbINeKws09fq9gy0=
X-Received: by 2002:a17:907:2d8e:b0:ad8:a329:b488 with SMTP id
 a640c23a62f3a-ade1a932e7fmr45958366b.13.1749151872706; Thu, 05 Jun 2025
 12:31:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <59c8f858b893a9d37b76d4b3bdf985c904b4c8fe.1749052938.git.fdmanana@suse.com>
 <20250605174957.GB3475402@zen.localdomain>
In-Reply-To: <20250605174957.GB3475402@zen.localdomain>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 5 Jun 2025 20:30:34 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4_Rr+NgsJX+m2we3JPp7cZsyrykEKLhvLvR3iT9bFP9A@mail.gmail.com>
X-Gm-Features: AX0GCFsgpXYXEde-wYu5PMxYuk9nWsvyxggIxnmlEfcDPpePuDcpuq11XtEtHN8
Message-ID: <CAL3q7H4_Rr+NgsJX+m2we3JPp7cZsyrykEKLhvLvR3iT9bFP9A@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix race between async reclaim worker and close_ctree()
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 5, 2025 at 6:50=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
>
> On Wed, Jun 04, 2025 at 05:18:11PM +0100, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Syzbot reported an assertion failure due to an attempt to add a delayed
> > iput after we have set BTRFS_FS_STATE_NO_DELAYED_IPUT in the fs_info
> > state:
> >
> >    WARNING: CPU: 0 PID: 65 at fs/btrfs/inode.c:3420 btrfs_add_delayed_i=
put+0x2f8/0x370 fs/btrfs/inode.c:3420
> >    Modules linked in:
> >    CPU: 0 UID: 0 PID: 65 Comm: kworker/u8:4 Not tainted 6.15.0-next-202=
50530-syzkaller #0 PREEMPT(full)
> >    Hardware name: Google Google Compute Engine/Google Compute Engine, B=
IOS Google 05/07/2025
> >    Workqueue: btrfs-endio-write btrfs_work_helper
> >    RIP: 0010:btrfs_add_delayed_iput+0x2f8/0x370 fs/btrfs/inode.c:3420
> >    Code: 4e ad 5d (...)
> >    RSP: 0018:ffffc9000213f780 EFLAGS: 00010293
> >    RAX: ffffffff83c635b7 RBX: ffff888058920000 RCX: ffff88801c769e00
> >    RDX: 0000000000000000 RSI: 0000000000000100 RDI: 0000000000000000
> >    RBP: 0000000000000001 R08: ffff888058921b67 R09: 1ffff1100b12436c
> >    R10: dffffc0000000000 R11: ffffed100b12436d R12: 0000000000000001
> >    R13: dffffc0000000000 R14: ffff88807d748000 R15: 0000000000000100
> >    FS:  0000000000000000(0000) GS:ffff888125c53000(0000) knlGS:00000000=
00000000
> >    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >    CR2: 00002000000bd038 CR3: 000000006a142000 CR4: 00000000003526f0
> >    DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> >    DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >    Call Trace:
> >     <TASK>
> >     btrfs_put_ordered_extent+0x19f/0x470 fs/btrfs/ordered-data.c:635
> >     btrfs_finish_one_ordered+0x11d8/0x1b10 fs/btrfs/inode.c:3312
> >     btrfs_work_helper+0x399/0xc20 fs/btrfs/async-thread.c:312
> >     process_one_work kernel/workqueue.c:3238 [inline]
> >     process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3321
> >     worker_thread+0x8a0/0xda0 kernel/workqueue.c:3402
> >     kthread+0x70e/0x8a0 kernel/kthread.c:464
> >     ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
> >     ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> >     </TASK>
> >
> > This can happen due to a race with the async reclaim worker like this:
> >
> > 1) The async metadata reclaim worker enters shrink_delalloc(), which ca=
lls
> >    btrfs_start_delalloc_roots() with an nr_pages argument that has a va=
lue
> >    less than LONG_MAX, and that in turn enters start_delalloc_inodes(),
> >    which sets the local variable 'full_flush' to false because
> >    wbc->nr_to_write is less than LONG_MAX;
> >
> > 2) There it finds inode X in a root's delalloc list, grabs a reference =
for
> >    inode X (with igrab()), and triggers writeback for it with
> >    filemap_fdatawrite_wbc(), which creates an ordered extent for inode =
X;
> >
> > 3) The unmount sequence starts from another task, we enter close_ctree(=
)
> >    and we flush the workqueue fs_info->endio_write_workers, which waits
> >    for the ordered extent for inode X to complete and when dropping the
> >    last reference of the ordered extent, with btrfs_put_ordered_extent(=
),
> >    when we call btrfs_add_delayed_iput() we don't add the inode to the
> >    list of delayed iputs because it has a refcount of 2, so we decremen=
t
> >    it to 1 and return;
> >
> > 4) Shortly after at close_ctree() we call btrfs_run_delayed_iputs() whi=
ch
> >    runs all delayed iputs, and then we set BTRFS_FS_STATE_NO_DELAYED_IP=
UT
> >    in the fs_info state;
> >
> > 5) The async reclaim worker, after calling filemap_fdatawrite_wbc(), no=
w
> >    calls btrfs_add_delayed_iput() for inode X and there we trigger an
> >    assertion failure since the fs_info state has the flag
> >    BTRFS_FS_STATE_NO_DELAYED_IPUT set.
> >
> > Fix this by setting BTRFS_FS_STATE_NO_DELAYED_IPUT only after we wait f=
or
> > the async reclaim workers to finish, after we call cancel_work_sync() f=
or
> > them at close_ctree(), and by running delayed iputs after wait for the
> > reclaim workers to finish and before setting the bit.
> >
> > This race was recently introduced by commit 19e60b2a95f5 ("btrfs: add
> > extra warning if delayed iput is added when it's not allowed") and we
> > didn't have any assertion failure, crash or inode leak in this describe=
d
> > scenario because before that commit since btrfs_commit_super(), called
> > later at close_ctree(), runs delayed iputs again, and there was no such
> > assertion about BTRFS_FS_STATE_NO_DELAYED_IPUT at btrfs_add_delayed_ipu=
t()
> > of course.
>
> I found this paragraph really hard to read and confusing. Could you try
> to reword it into a few simpler sentences? Maybe something like:
>
> "This race was recently introduced by commit XXX. Without the new
> validation at btrfs_add_delayed_iput(), this described scenario was safe
> because close_ctree() later calls btrfs_commit_super(). That will run any
> final delayed iputs added by reclaim workers in the window between the
> btrfs_run_delayed_iputs() and the the reclaim workers being shut down."
>
> I think just breaking up the sentences helps a bit.

Sure, I'll replace it with that in v2.

>
> >
> > Reported-by: syzbot+0ed30ad435bf6f5b7a42@syzkaller.appspotmail.com
> > Link: https://lore.kernel.org/linux-btrfs/6840481c.a00a0220.d4325.000c.=
GAE@google.com/T/#u
> > Fixes: 19e60b2a95f5 ("btrfs: add extra warning if delayed iput is added=
 when it's not allowed")
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
>
> A few small notes/questions, but LGTM, thanks.
> Reviewed-by: Boris Burkov <boris@bur.io>
>
> > ---
> >  fs/btrfs/disk-io.c | 18 ++++++++++++++++--
> >  1 file changed, 16 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> > index 3def93016963..84c8f9f19649 100644
> > --- a/fs/btrfs/disk-io.c
> > +++ b/fs/btrfs/disk-io.c
> > @@ -4324,15 +4324,29 @@ void __cold close_ctree(struct btrfs_fs_info *f=
s_info)
> >       btrfs_flush_workqueue(fs_info->endio_write_workers);
> >       /* Ordered extents for free space inodes. */
> >       btrfs_flush_workqueue(fs_info->endio_freespace_worker);
> > +     /*
> > +      * Run delayed iputs in case an async reclaim worker is waiting f=
or them
> > +      * to be run as mentioned above.
> > +      */
>
> This comment was quite helpful as I initially wondered why keep both
> calls. But it made me think and read the above comment as well. So thanks
> for including it.
>
> However, the comment you are referring to also says:
>
> "This works because once we reach this point no one
> can either create new ordered extents nor create delayed iputs
> through some other means."

Ah yes, that's stale now and when I wrote that comment (not that long
ago), I missed that the reclaim workers can create delayed iputs too.
I'll update that part in v2.

>
> Which I think you have shown to be not true in this analysis/fix, as the
> reclaim workers themselves are adding more delayed iputs after this
> point.
>
> >       btrfs_run_delayed_iputs(fs_info);
> > -     /* There should be no more workload to generate new delayed iputs=
. */
> > -     set_bit(BTRFS_FS_STATE_NO_DELAYED_IPUT, &fs_info->fs_state);
> >
> >       cancel_work_sync(&fs_info->async_reclaim_work);
> >       cancel_work_sync(&fs_info->async_data_reclaim_work);
> >       cancel_work_sync(&fs_info->preempt_reclaim_work);
> >       cancel_work_sync(&fs_info->em_shrinker_work);
> >
> > +     /*
> > +      * Run delayed iputs again because an async reclaim worker may ha=
ve
> > +      * added new ones if it was flushing delalloc:
> > +      *
> > +      * shrink_delalloc() -> btrfs_start_delalloc_roots() ->
> > +      *    start_delalloc_inodes() -> btrfs_add_delayed_iput()
> > +      */
> > +     btrfs_run_delayed_iputs(fs_info);
>
> If btrfs_commit_super() will cleanup any stragglers as before, do we
> actually need this btrfs_run_delayed_iputs()?
>  I suppose it makes the
> semantics of the BTRFS_FS_STATE_NO_DELAYED_IPUT bit more clear. OTOH,
> all the bit really does (and is documented as doing) is block new
> delayed iputs, which is valid at this point whether or not any
> already exist.

I added this final run of delayed iputs not just to make it more clear
but to be safer as well,
because btrfs_commit_super() is run only if we're not in RO mode.

Even on a RO fs, things like log replay can be run and create delayed
iputs in the future.
We currently don't do that for log replay, but there's no strong
reason not to do it one day either.
Just a safe net.

Thanks.

>
> > +
> > +     /* There should be no more workload to generate new delayed iputs=
. */
> > +     set_bit(BTRFS_FS_STATE_NO_DELAYED_IPUT, &fs_info->fs_state);
> > +
> >       /* Cancel or finish ongoing discard work */
> >       btrfs_discard_cleanup(fs_info);
> >
> > --
> > 2.47.2
> >

