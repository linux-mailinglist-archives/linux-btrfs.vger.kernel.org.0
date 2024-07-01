Return-Path: <linux-btrfs+bounces-6058-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0901191DB3A
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2024 11:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1F3128440E
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2024 09:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE1584D13;
	Mon,  1 Jul 2024 09:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dDiqgxaE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B10943AD2
	for <linux-btrfs@vger.kernel.org>; Mon,  1 Jul 2024 09:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719825289; cv=none; b=h0UKql2YK/vXTrGftownK37zFn6NZ+9aV0j9sKTQXYOUaBA49no+ozOyIBGZhAGCPPOUTAEH1Xdfe54qiFxIXaK+r9IlYXJxrzzfrWCbv89XEJ57Z7om0WDrXmShFYc0WtA1Yz4cQ4pvJPB9QbKwROyk4FoL5YIoo5qklZglP5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719825289; c=relaxed/simple;
	bh=toT+b33o5kkYFKBpb9Awypgll9Q1Z3NuxSGBaDAv8xw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sOB+W3G7iWLDxXrgNAiyYPhA+BXJrEP5dSAGteqMBR/2dSKqTzXMqMm28+MKsOuNgjlDw2+/gAVrCbuYozfny+61knBqQwtbho9fixd+cp7GWRDFxXX5tPVT8oAcW2IAFdZk6lfoQsYHhDx72dYd4+hlm3JScTNY0nbSMkt4/O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dDiqgxaE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1CA0C116B1
	for <linux-btrfs@vger.kernel.org>; Mon,  1 Jul 2024 09:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719825288;
	bh=toT+b33o5kkYFKBpb9Awypgll9Q1Z3NuxSGBaDAv8xw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dDiqgxaEGBTnzAN6V/R4kkEzqVfJIXQqixz2lZmw2sEcxIxpVXNAKV85gDWigUPEy
	 kM7FwQT0lP8vch1mzQf8cI6jmUAOvyUzXXqpT/fd9R6k69uHwOUkmMoxjRN+hyu8by
	 BlpPtKvJYg3dNnr0p285Q8aE3v4FYyCnbDMiWEnnstot/TdJMS+UT5dAOQjlFze0HC
	 UJMmB8Ew/kn1XiSykES6ppok/97qZl/k6BD54iVVbT1R3RrN3/YbYs6p4+OezqEdSu
	 TO/tz23Gt01ZnAnUmDI2lmKBiGRy1qRn266MlaHWhDu+Wgn04pXIZMMFTGDj7Zu+jZ
	 oLU3P3xNwyG2g==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a724440f597so323668166b.0
        for <linux-btrfs@vger.kernel.org>; Mon, 01 Jul 2024 02:14:48 -0700 (PDT)
X-Gm-Message-State: AOJu0YwB04FAwjhfrg0gjw4P6lGc1EM0vO5NCRGNj6zmJgTL+WrW65fk
	1YCjK1eiTxGCvsWTazhi1Sy/t/i+mpjSMgA2MDWY8yQmTtqMiKJHbfM+Gar8VLwH6aApnIIXAnn
	ieNfB6F70jdNgSb2JQ98i77cmbbE=
X-Google-Smtp-Source: AGHT+IF0Mw0sAEUPLKrPfvYo4KPmdfoQzVYsKc6cXZa8RK6Pmbz6LvAuMAtW5Z/cmV3aainleF3kb06py2RvyWoCrmA=
X-Received: by 2002:a17:906:6a15:b0:a72:5bb9:b13c with SMTP id
 a640c23a62f3a-a75144bae99mr424678266b.75.1719825287453; Mon, 01 Jul 2024
 02:14:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <58e8574ccd70645c613e6bc7d328e34c2f52421a.1719549099.git.naohiro.aota@wdc.com>
 <CAL3q7H5jCHVhz1E4UgNdujtiX9FHhiWVhHsN3ow70WGHRTf94A@mail.gmail.com> <ikeovp477s5ittkv4tbr2ljzgaz34asc26kj6kwtoggvvfvc3r@qcls3233ff5f>
In-Reply-To: <ikeovp477s5ittkv4tbr2ljzgaz34asc26kj6kwtoggvvfvc3r@qcls3233ff5f>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 1 Jul 2024 10:14:10 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4-DpS-YR4hW2kfj_zPKskGdze0mnwiSebMzchy3zVOTA@mail.gmail.com>
Message-ID: <CAL3q7H4-DpS-YR4hW2kfj_zPKskGdze0mnwiSebMzchy3zVOTA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: avoid possible parallel list adding
To: Naohiro Aota <Naohiro.Aota@wdc.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 1, 2024 at 8:14=E2=80=AFAM Naohiro Aota <Naohiro.Aota@wdc.com> =
wrote:
>
> On Fri, Jun 28, 2024 at 10:45:30AM GMT, Filipe Manana wrote:
> > On Fri, Jun 28, 2024 at 5:54=E2=80=AFAM Naohiro Aota <naohiro.aota@wdc.=
com> wrote:
> > >
> > > There is a potential parallel list adding for retrying in
> > > btrfs_reclaim_bgs_work and adding to the unused list. Since the block
> > > group is removed from the reclaim list and it is on a relocation work=
,
> > > it can be added into the unused list in parallel. When that happens,
> > > adding it to the reclaim list will corrupt the list head and trigger
> > > list corruption like below.
> > >
> > > Fix it by taking fs_info->unused_bgs_lock.
> > >
> > > [27177.504101][T2585409] BTRFS error (device nullb1): error relocatin=
g ch=3D unk 2415919104
> > > [27177.514722][T2585409] list_del corruption. next->prev should be ff=
1100=3D 0344b119c0, but was ff11000377e87c70. (next=3D3Dff110002390cd9c0)
> > > [27177.529789][T2585409] ------------[ cut here ]------------
> > > [27177.537690][T2585409] kernel BUG at lib/list_debug.c:65!
> > > [27177.545548][T2585409] Oops: invalid opcode: 0000 [#1] PREEMPT SMP =
KASAN NOPTI
> > > [27177.555466][T2585409] CPU: 9 PID: 2585409 Comm: kworker/u128:2 Tai=
nted: G        W          6.10.0-rc5-kts #1
> > > [27177.568502][T2585409] Hardware name: Supermicro SYS-520P-WTR/X12SP=
W-TF, BIOS 1.2 02/14/2022
> > > [27177.579784][T2585409] Workqueue: events_unbound btrfs_reclaim_bgs_=
work[btrfs]
> > > [27177.589946][T2585409] RIP: 0010:__list_del_entry_valid_or_report.c=
old+0x70/0x72
> > > [27177.600088][T2585409] Code: fa ff 0f 0b 4c 89 e2 48 89 de 48 c7 c7=
 c0
> > > 8c 3b 93 e8 ab 8e fa ff 0f 0b 4c 89 e1 48 89 de 48 c7 c7 00 8e 3b 93 =
e8
> > > 97 8e fa ff <0f> 0b 48 63 d1 4c 89 f6 48 c7 c7 e0 56 67 94 89 4c 24 0=
4
> > > e8 ff f2
> > > [27177.624173][T2585409] RSP: 0018:ff11000377e87a70 EFLAGS: 00010286
> > > [27177.633052][T2585409] RAX: 000000000000006d RBX: ff11000344b119c0 =
RCX:0000000000000000
> > > [27177.644059][T2585409] RDX: 000000000000006d RSI: 0000000000000008 =
RDI:ffe21c006efd0f40
> > > [27177.655030][T2585409] RBP: ff110002e0509f78 R08: 0000000000000001 =
R09:ffe21c006efd0f08
> > > [27177.665992][T2585409] R10: ff11000377e87847 R11: 0000000000000000 =
R12:ff110002390cd9c0
> > > [27177.676964][T2585409] R13: ff11000344b119c0 R14: ff110002e0508000 =
R15:dffffc0000000000
> > > [27177.687938][T2585409] FS:  0000000000000000(0000) GS:ff11000fec880=
000(0000) knlGS:0000000000000000
> > > [27177.700006][T2585409] CS:  0010 DS: 0000 ES: 0000 CR0: 00000000800=
50033
> > > [27177.709431][T2585409] CR2: 00007f06bc7b1978 CR3: 0000001021e86005 =
CR4:0000000000771ef0
> > > [27177.720402][T2585409] DR0: 0000000000000000 DR1: 0000000000000000 =
DR2:0000000000000000
> > > [27177.731337][T2585409] DR3: 0000000000000000 DR6: 00000000fffe0ff0 =
DR7:0000000000000400
> > > [27177.742252][T2585409] PKRU: 55555554
> > > [27177.748207][T2585409] Call Trace:
> > > [27177.753850][T2585409]  <TASK>
> > > [27177.759103][T2585409]  ? __die_body.cold+0x19/0x27
> > > [27177.766405][T2585409]  ? die+0x2e/0x50
> > > [27177.772498][T2585409]  ? do_trap+0x1ea/0x2d0
> > > [27177.779139][T2585409]  ? __list_del_entry_valid_or_report.cold+0x7=
0/0x72
> > > [27177.788518][T2585409]  ? do_error_trap+0xa3/0x160
> > > [27177.795649][T2585409]  ? __list_del_entry_valid_or_report.cold+0x7=
0/0x72
> > > [27177.805045][T2585409]  ? handle_invalid_op+0x2c/0x40
> > > [27177.812022][T2585409]  ? __list_del_entry_valid_or_report.cold+0x7=
0/0x72
> > > [27177.820947][T2585409]  ? exc_invalid_op+0x2d/0x40
> > > [27177.827608][T2585409]  ? asm_exc_invalid_op+0x1a/0x20
> > > [27177.834637][T2585409]  ? __list_del_entry_valid_or_report.cold+0x7=
0/0x72
> > > [27177.843519][T2585409]  btrfs_delete_unused_bgs+0x3d9/0x14c0 [btrfs=
]
> > >
> > > There is a similar retry_list code in btrfs_delete_unused_bgs(), but =
it is
> > > safe, AFAIC. Since the block group was in the unused list, the used b=
ytes
> > > should be 0 when it was added to the unused list. Then, it checks
> > > block_group->{used,resereved,pinned} are still 0 under the
> > > block_group->lock. So, they should be still eligible for the unused l=
ist,
> > > not the reclaim list.
> >
> > The reason it is safe there it's because because we're holding
> > space_info->groups_sem in write mode.
> >
> > That means no other task can allocate from the block group, so while
> > we are at deleted_unused_bgs()
> > it's not possible for other tasks to allocate and deallocate extents
> > from the block group,
> > so it can't be added to the unused list or the reclaim list by anyone e=
lse.
>
> Thank you for the description. May I incorporate this to the commit log?

Sure.
Thanks!

>
> >
> > >
> > > Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > > Suggested-by: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
> > > Fixes: 4eb4e85c4f81 ("btrfs: retry block group reclaim without infini=
te loop")
> > > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> >
> > The change looks good.
> > I would however make the subject less generic, maybe something like:
> >
> > "btrfs: fix adding block group to a reclaim list and the unused list
> > during reclaim"
>
> Sure.
>
> >
> > Reviewed-by: Filipe Manana <fdmanana@suse.com>
> >
> > > ---
> > >  fs/btrfs/block-group.c | 13 +++++++++++--
> > >  1 file changed, 11 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> > > index 7cde40fe6a50..498442d0c216 100644
> > > --- a/fs/btrfs/block-group.c
> > > +++ b/fs/btrfs/block-group.c
> > > @@ -1945,8 +1945,17 @@ void btrfs_reclaim_bgs_work(struct work_struct=
 *work)
> > >  next:
> > >                 if (ret && !READ_ONCE(space_info->periodic_reclaim)) =
{
> > >                         /* Refcount held by the reclaim_bgs list afte=
r splice. */
> > > -                       btrfs_get_block_group(bg);
> > > -                       list_add_tail(&bg->bg_list, &retry_list);
> > > +                       spin_lock(&fs_info->unused_bgs_lock);
> > > +                       /*
> > > +                        * This block group might be added to the unu=
sed list
> > > +                        * during the above process. Move it back to =
the
> > > +                        * reclaim list otherwise.
> > > +                        */
> > > +                       if (list_empty(&bg->bg_list)) {
> > > +                               btrfs_get_block_group(bg);
> > > +                               list_add_tail(&bg->bg_list, &retry_li=
st);
> > > +                       }
> > > +                       spin_unlock(&fs_info->unused_bgs_lock);
> > >                 }
> > >                 btrfs_put_block_group(bg);
> > >
> > > --
> > > 2.45.2
> > >
> > >

