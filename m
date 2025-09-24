Return-Path: <linux-btrfs+bounces-17167-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A7AB7B9C8DF
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Sep 2025 01:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EDC264E33DE
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Sep 2025 23:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA45129BD83;
	Wed, 24 Sep 2025 23:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="VrPUL79I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D02DlbfF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698D329AAF3
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Sep 2025 23:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758756410; cv=none; b=KDoPxnkhik4w9iTJQnfIANxStSGGdMm+UW487STYzcGke6CVIfm4y9q4ZRUsk6WQ00DohCydwyRYdcL1JBsPzQCdjQfpPZRxcIOG/HPuDHVurYrrwwezosSET2/vKr7Kmyr9wyKcKMPEJvauS4Hyln+Fv6GC2f0eGC7Lputt8I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758756410; c=relaxed/simple;
	bh=1sm/yUg/IHmnRUVZcd0PZsT8p3UiBmGxKXLJ38bmjSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lTvtby9tAaLSF/iJ1TTRP9GVa+WNs2T3CM/RK7kjmWOln1gGvWFWgUCHHT5PkhD+kvgSg54a+hh9pNsLibmHLq7DciLgzwIPogUj4vn1aieAYPotp8MG8N6OrSh5GYNxFYc3KOTcmylc0T65z6vjMzP+ptHybWIzYfgCW9zValg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=VrPUL79I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D02DlbfF; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4D3FC7A00CE;
	Wed, 24 Sep 2025 19:26:47 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 24 Sep 2025 19:26:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1758756407;
	 x=1758842807; bh=XTs/3VMJLeBuROleEymgPunmjsr0iyx4DQMVP6IFxjY=; b=
	VrPUL79IB9DTF3nCpQbtxzZHmmq9JioQrAUdWLXr5+NOd/QSASTozwFbHTvIOMNp
	tJWH+8VbsExeWSr71f+AGXJJsFF6pDUcAR6Rz4GfTuG1K/AA1LxCx3qTEZ56xhPD
	/7J6XFHu6buAMFyv32Bg3OfrIryyS7XvzQFzDg3n/a0paI8n/SvPY59XvHgaLXPt
	pOvYpziuECltFBhTly1VFi/kWd4Nzj8EZwHJgQro2nXyv5kbdysXiaJLZdddWhI6
	MoQSVg6IkHFYyUT6mn2vbfqmUJB91yExua8Xy9JyYt2NEiKMuiLrxDGOX9AbAU2e
	LZucYncSqjv+0FkUdMkV4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758756407; x=
	1758842807; bh=XTs/3VMJLeBuROleEymgPunmjsr0iyx4DQMVP6IFxjY=; b=D
	02DlbfFtFVKX8K5fd4vjA+MeRXA7z/hXAJ0JArbWc3JUhcg+OoQnxk2G9mDJTTPh
	j0M2xqrpa/2q/twKQsqU2YtmBgXoAflG1mWsZiIKfRDvWnocbNW41i9jKuyjUpGc
	eCak8BgIZC0zz8GEZXkBZ0eZLQEbmZA3PaZi8CWy4V1/C4ucnER36ZplpTHvUvsN
	EI7Yi0/Tx3/7DVYMx96v7OPsMHt1/bTX6mpZEcRNS2pzaYl8/C0Nr/fmD5Pmb9ay
	V5YszNdVu0VeQvIIBukeIFwqPTAZ6RnzG72/32+QyEm+FWMMl3pRrzyGBLM4DXHO
	RG3JzqEVu5Vue+8yS+pDg==
X-ME-Sender: <xms:Nn7UaCx5zGrlknHHBFuJjAnZ5GUdkC9LPAvbkzeTfTOzCHi06mOpeQ>
    <xme:Nn7UaFsXT7w8dCr6Q-_GfF1vNMJO5hxORkK21bL6hR_pBrPknVq4A1EQyHiFSH_Dz
    kIb8zuqKZgxtSeBDPu9uD1pDrnVGoQmEv-kOgTGFyK60o6ca1NZ0w>
X-ME-Received: <xmr:Nn7UaBu8CuN-TjLIhulbs8dgagpC44NbJcnAYqapLryl0vKAa6CtZpXBYBXkQDts4IGaDwW8L5WSqAti2FWFZCYFVTc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeigeelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeehhf
    duhefgkeehudefvdetgfetleeuiefgfefhfeegjeekfeehhffgkeejhfdvheenucffohhm
    rghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopeef
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehfughmrghnrghnrgeskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehkvghrnhgvlhdqthgvrghmsehfsgdrtghomh
X-ME-Proxy: <xmx:Nn7UaCPdQAxZMwEazz_vvUfm1KCZ3iDRcko_iDihbuM4tdhBi7agWQ>
    <xmx:Nn7UaH0V8R593DiMXECxSWlF4_eb5M3uL5-mamZADjAN7LwvYZQk3g>
    <xmx:Nn7UaGP1wQURkDcsPdH96J_OsVXm3raO-HmmBGdsWZr3YiGg_XCmeg>
    <xmx:Nn7UaP12IzVlM5Fv8yMwp7f_CxmgkOgQd-0v0qvZxwlG26fVbsEW6A>
    <xmx:N37UaNug5YN4bwZK3ZwPzAzI7_hg5o5jpfuI0GE8MJp2Tf4X-pFPTDkG>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Sep 2025 19:26:46 -0400 (EDT)
Date: Wed, 24 Sep 2025 16:26:44 -0700
From: Boris Burkov <boris@bur.io>
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: don't ignore ENOMEM in btrfs_add_chunk_map()
Message-ID: <20250924232644.GA1540167@zen.localdomain>
References: <0d537ef90213e54835f7aaa090498787db27b33a.1758752652.git.boris@bur.io>
 <CAL3q7H7v-9M485_svy_5BCaWVaf+61DvFB6gMUEWhR=2ykM+qw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H7v-9M485_svy_5BCaWVaf+61DvFB6gMUEWhR=2ykM+qw@mail.gmail.com>

On Thu, Sep 25, 2025 at 12:05:21AM +0100, Filipe Manana wrote:
> On Wed, Sep 24, 2025 at 11:24 PM Boris Burkov <boris@bur.io> wrote:
> >
> > btrfs_set_extent_bit() can return ENOMEM, which
> > chunk_map_device_(set|clear)_bits() was ignoring, so
> > btrfs_add_chunk_map() was silently failing in those cases. This led to
> > double allocating dev extents, ultimately resulting in an EEXIST in
> > add_dev_extent_item(): (ignore the btrfs_force_chunk_alloc_store thing,
> > we are using a DEBUG feature that isn't widely used here)
> >
> >   ------------[ cut here ]------------
> >   BTRFS: Transaction aborted (error -17)
> >   WARNING: CPU: 5 PID: 3586339 at fs/btrfs/block-group.c:2764 btrfs_create_pending_block_groups+0x5fc/0x620
> >   RIP: 0010:btrfs_create_pending_block_groups+0x5fc/0x620
> >   Code: 9c fd ff ff 48 c7 c7 e8 69 64 82 44 89 ee e8 4b 87 e6 ff 0f 0b e9 99 fe ff ff 48 c7 c7 e8 69 64 82 48 8b 34 24 e8 34 87 e6 ff <0f> 0b eb a0 48 c7 c7 e8 69 64 82 44 89 e6 e8 21 87 e6 ff 0f 0b e9
> >   RSP: 0018:ffffc90060693d38 EFLAGS: 00010286
> >   RAX: 0000000000000026 RBX: ffff8882be92fed8 RCX: 0000000000000027
> >   RDX: ffff88bf42f6e040 RSI: ffff88bf42f60c48 RDI: ffff88bf42f60c48
> >   RBP: ffff888282585d18 R08: 0000000000000000 R09: 0000000000000000
> >   R10: 4000000000000000 R11: 000000000000691d R12: ffff88c0471a3300
> >   R13: 0000001dc6500000 R14: ffff8882829d9000 R15: ffff8882be92ff40
> >   FS:  00007f7ccbc2c740(0000) GS:ffff88bf42f40000(0000) knlGS:0000000000000000
> >   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >   CR2: 0000000004e421c8 CR3: 0000000cd6384001 CR4: 0000000000770ef0
> >   PKRU: 55555554
> >   Call Trace:
> >    <TASK>
> >    ? __warn+0xa0/0x130
> >    ? btrfs_create_pending_block_groups+0x5fc/0x620
> >    ? report_bug+0xf2/0x150
> >    ? handle_bug+0x3d/0x70
> >    ? exc_invalid_op+0x16/0x40
> >    ? asm_exc_invalid_op+0x16/0x20
> >    ? btrfs_create_pending_block_groups+0x5fc/0x620
> >    ? btrfs_create_pending_block_groups+0x5fc/0x620
> >    __btrfs_end_transaction.llvm.3999538623537568469+0x3d/0x1c0
> >    btrfs_force_chunk_alloc_store+0xaf/0x100
> >    ? sysfs_kf_read+0x90/0x90
> >    kernfs_fop_write_iter.llvm.10031329899921036925+0xd0/0x180
> >    __x64_sys_write+0x279/0x5a0
> >    do_syscall_64+0x63/0x130
> >    ? exc_page_fault+0x63/0x130
> >    entry_SYSCALL_64_after_hwframe+0x4b/0x53
> >   RIP: 0033:0x7f7ccb4ff28f
> >   Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 a9 89 f8 ff 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 44 24 08 e8 fc 89 f8 ff 48
> >   RSP: 002b:00007ffda7138f20 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
> >   RAX: ffffffffffffffda RBX: 0000000009c13140 RCX: 00007f7ccb4ff28f
> >   RDX: 0000000000000001 RSI: 0000000004e401b0 RDI: 00000000000000c8
> >   RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
> >   R10: 0000000000008000 R11: 0000000000000293 R12: 0000000000000000
> >   R13: 0000000000408820 R14: 0000000000407f00 R15: 00007ffda7138fc0
> >    </TASK>
> >   ---[ end trace 0000000000000000 ]---
> >   BTRFS: error (device nvme0n1p2 state A) in btrfs_create_pending_block_groups:2764: errno=-17 Object already exists
> >   BTRFS warning (device nvme0n1p2 state EA): Skipping commit of aborted transaction.
> >   BTRFS: error (device nvme0n1p2 state EA) in cleanup_transaction:2018: errno=-17 Object already exists
> >
> > This was pretty confusing to debug and I think it would be helpful to
> > get the proper ENOMEM error sent up to the appropriate transaction when
> > it happens.
> >
> > Note:
> > Most callsites of btrfs_set_extent_bit() are not checked, however, which
> > does give me pause. Either we have a lot more inaccuracies like this out
> > there, or I have misanalyzed this scenario. I was able to reproduce the
> > above calltrace by injecting enomem errors in to the set_extent_bits
> > path here, for what it's worth.
> 
> Most callers are not checking -ENOMEM (or other errors) because we
> shouldn't have -ENOMEM with any of the functions that end up at
> set_extent_bit().
> There, under the 'again' label, before taking the io tree's lock we do:
> 
> prealloc = alloc_extent_state(mask);
> 
> If that returns NULL, we proceed, take the lock and navigate the rb tree.
> If it turns out we need an extent state record (and we don't always
> need one), we call alloc_extent_state_atomic().
> If that fails (returns NULL) we do a goto 'search_again', which
> unlocks the tree and does a goto to the 'again' label at the very top,
> where we once again call alloc_extent_state() and repeat all those
> steps again.
> 
> So if we can't allocate memory, we keep doing that loop over and over
> until we can allocate or don't need to allocate (due to concurrent
> changes in the tree) - we never return -ENOMEM in set_extent_bit().
> 
> The same logic applies to btrfs_clear_extent_bit_changeset(), the core
> function to clear bits from a range - we don't ever return -ENOMEM and
> keep looping until we can allocate.
> 
> The only io tree function we return -ENOMEM is for the convert
> operation (btrfs_convert_extent_bit()), where the single caller can
> deal with -ENOMEM (I remember doing that logic many years ago).
> 
> So I don't know what that error injection you mention is doing or that
> btrfs_force_chunk_alloc_store thing you mention with some custom
> debugging feature, but I don't see how we can return -ENOMEM.
> Care to elaborate in detail?
> 
> Thanks.
> 
> 
> 

Thanks for the reply and explanation.

I did indeed miss the looping in set_extent_bit() and somehow got it
confused with convert_extent_bit(), because I do remember reading the
first_iteration check. So first things first, I agree with your analysis
on the return value.

As for the error injection and debug feature, here is the full story of
what I was up to:

For a few years now, in prod, we have been using the sysfs
force_chunk_alloc file added here
https://lore.kernel.org/linux-btrfs/20220208193122.492533-4-shr@fb.com/
to force metadata allocations on healthy filesystems to create a buffer
to protect from ENOSPC. This predates our adoption of auto relocation
and then dynamic relocation, so it is possible we don't need it anymore.
But we are writing to it for metadata block groups when they have <5G
allocated. (And we carry an out of tree patch to include that sysfs file
without CONFIG_BTRFS_DEBUG)

Now, what I have observed on prod hosts is the stack trace that I included
in the commit message, so I was investigating that. I looked pretty
closely at one such host in drgn and observed that we had a pattern in
the dev extents that looked like:

Logical L: Single data chunk at physical P
Logical L+1: Dup metadata chunk at physical P-1, dup mapped to P

And writing the DEV_EXTENT item for the second stripe was causing the
EEXIST.

During that investigation, due to mis-remembering ENOMEMs from extent
state bits in my quotas work (that code also uses changesets...) and
mixing up convert_extent_bit() and set_extent_bit(), I hypothesized
that ignoring an ENOMEM might cause that error. So I made a workload
that hit the force chunk alloc file, added manual random ENOMEM
injection into chunk_map_device_set_bits() (which I now agree is
pointless and can't happen), and did in fact reproduce the same pattern
of error. From there I jumped to the conclusion that this is the problem
and sent this patch (and tested my new code with the stupid non-real
error injection). It didn't help that the host I was investigating did
have a good amount of OOMs in the dmesg to further lead me astray :)

So at this point, I need to go back to the drawing board on what is
causing the overlapping chunk allocations, it does not appear to be OOM.

On the bright side, this is great news, because I was NOT looking
forward to trying to fix all the callsites, especially if unwinding the
successfully set bits before an error was needed...

Thanks,
Boris

> >
> > Signed-off-by: Boris Burkov <boris@bur.io>
> > ---
> >  fs/btrfs/volumes.c | 47 ++++++++++++++++++++++++++++++++++------------
> >  1 file changed, 35 insertions(+), 12 deletions(-)
> >
> > diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> > index 2bec544d8ba3..eda5b6b907d9 100644
> > --- a/fs/btrfs/volumes.c
> > +++ b/fs/btrfs/volumes.c
> > @@ -5434,28 +5434,42 @@ static int decide_stripe_size(struct btrfs_fs_devices *fs_devices,
> >         }
> >  }
> >
> > -static void chunk_map_device_set_bits(struct btrfs_chunk_map *map, unsigned int bits)
> > +static int chunk_map_device_set_bits(struct btrfs_chunk_map *map, unsigned int bits)
> >  {
> > +       int ret;
> > +
> >         for (int i = 0; i < map->num_stripes; i++) {
> >                 struct btrfs_io_stripe *stripe = &map->stripes[i];
> >                 struct btrfs_device *device = stripe->dev;
> >
> > -               btrfs_set_extent_bit(&device->alloc_state, stripe->physical,
> > -                                    stripe->physical + map->stripe_size - 1,
> > -                                    bits | EXTENT_NOWAIT, NULL);
> > +               ret = btrfs_set_extent_bit(
> > +                       &device->alloc_state, stripe->physical,
> > +                       stripe->physical + map->stripe_size - 1,
> > +                       bits | EXTENT_NOWAIT, NULL);
> > +               if (ret)
> > +                       return ret;
> >         }
> > +       ret = 0;
> > +       return ret;
> >  }
> >
> > -static void chunk_map_device_clear_bits(struct btrfs_chunk_map *map, unsigned int bits)
> > +static int chunk_map_device_clear_bits(struct btrfs_chunk_map *map, unsigned int bits)
> >  {
> > +       int ret;
> > +
> >         for (int i = 0; i < map->num_stripes; i++) {
> >                 struct btrfs_io_stripe *stripe = &map->stripes[i];
> >                 struct btrfs_device *device = stripe->dev;
> >
> > -               btrfs_clear_extent_bit(&device->alloc_state, stripe->physical,
> > -                                      stripe->physical + map->stripe_size - 1,
> > -                                      bits | EXTENT_NOWAIT, NULL);
> > +               ret = btrfs_clear_extent_bit(
> > +                       &device->alloc_state, stripe->physical,
> > +                       stripe->physical + map->stripe_size - 1,
> > +                       bits | EXTENT_NOWAIT, NULL);
> > +               if (ret)
> > +                       return ret;
> >         }
> > +       ret = 0;
> > +       return ret;
> >  }
> >
> >  void btrfs_remove_chunk_map(struct btrfs_fs_info *fs_info, struct btrfs_chunk_map *map)
> > @@ -5488,6 +5502,7 @@ static int btrfs_chunk_map_cmp(const struct rb_node *new,
> >  EXPORT_FOR_TESTS
> >  int btrfs_add_chunk_map(struct btrfs_fs_info *fs_info, struct btrfs_chunk_map *map)
> >  {
> > +       int ret;
> >         struct rb_node *exist;
> >
> >         write_lock(&fs_info->mapping_tree_lock);
> > @@ -5498,11 +5513,19 @@ int btrfs_add_chunk_map(struct btrfs_fs_info *fs_info, struct btrfs_chunk_map *m
> >                 write_unlock(&fs_info->mapping_tree_lock);
> >                 return -EEXIST;
> >         }
> > -       chunk_map_device_set_bits(map, CHUNK_ALLOCATED);
> > -       chunk_map_device_clear_bits(map, CHUNK_TRIMMED);
> > -       write_unlock(&fs_info->mapping_tree_lock);
> >
> > -       return 0;
> > +       ret = chunk_map_device_set_bits(map, CHUNK_ALLOCATED);
> > +       if (ret)
> > +               goto out;
> > +       ret = chunk_map_device_clear_bits(map, CHUNK_TRIMMED);
> > +
> > +out:
> > +       if (ret) {
> > +               rb_erase_cached(&map->rb_node, &fs_info->mapping_tree);
> > +               RB_CLEAR_NODE(&map->rb_node);
> > +       }
> > +       write_unlock(&fs_info->mapping_tree_lock);
> > +       return ret;
> >  }
> >
> >  EXPORT_FOR_TESTS
> > --
> > 2.50.1
> >
> >

