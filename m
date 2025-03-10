Return-Path: <linux-btrfs+bounces-12149-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C762A5A3C9
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Mar 2025 20:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD37A1734EB
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Mar 2025 19:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4D52356D7;
	Mon, 10 Mar 2025 19:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="NE9ISmCQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n9crS+UF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B53227E9E
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Mar 2025 19:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741634887; cv=none; b=VwI5enRuT0hEWDT7HKedwCUYnQIJ5xOWOjSRk9z5ARRa5plrAXWDrE6+f6gu5wsvPKrWWCLDLkPpjNWoThfJwb8X/quxQl7FXfsZbFB0X5gSckNzWraUw6OFeLR0SNfQQaTZwzApuZcZhherswsMSam5ARoW7mxgDLC+8pMbQLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741634887; c=relaxed/simple;
	bh=Xpgw0z9+ToyYRGkhf/IotxUkhVuMAD84XRhyk8K9/N8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nsXfubgrmzrEFc5EWQQFumRXRUo9gJaiCjR4gUJX1fOjkM9ZnvE+nvbSEAZBjuqwraVEIkufhFUboUNvy/xpNtx2AKTwkpUQ4tATmTKIqxYUtOZqShlY0GkA4cStIHbhRmXNBEQ3hHcTYVNhTDV8iGIrDCe9Bv8tAUeZaOFo/7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=NE9ISmCQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n9crS+UF; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6903C2540230;
	Mon, 10 Mar 2025 15:28:03 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 10 Mar 2025 15:28:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1741634883;
	 x=1741721283; bh=lCJz9PpP1gj6xYDZbik/XIc4N+yzyZNf4ynTHZJc8cs=; b=
	NE9ISmCQZXlhyKI3T6bGHzNAdHoEXGI1+rMH7fxji4YLQezdBTNBSWQjNRr9i8zV
	n8mN/jnHqEwNtROhh2ZHP6boHwfDPAw60cNRqIQvRpzWc5pRQcUlQnT0AGjXElcs
	xH4+J47ors1k3kb9IILoRGo9+Vl4Xlr66zFi7oVRnHbJIGOcy2N5vglFzwFAYmmh
	DUBDKNkWVeLChJcI+iYF8QTZ/SDcwhEcSEThhdPNCY5/imsEKb9nrLSUswYSega4
	2kxDP0vfw3NsPBofGYeTnyjFNzuBaSL3QZI51kMPAn4PWOYj4KSlV/BiBJPN1hz6
	XY31Lqvzwq3kEW6EMtOIUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741634883; x=
	1741721283; bh=lCJz9PpP1gj6xYDZbik/XIc4N+yzyZNf4ynTHZJc8cs=; b=n
	9crS+UFMdC8R6HC+Za42qVlTWO9Bp9DsODuKqT3cb8rojluItvAzKDXLmsNSc/Qz
	YfEiX0EDK07Gsol4M0joU+GZxhn/97xfqrDWXqfgRzfK6cb7VSKY2m20FUIH+LuL
	fniso8bJTRohvwUiyHAM2tT41QY7a/Yw3/ODluTsYx2jm+Dic4ipvUXKCiiAxhZC
	SpdJ0AuW8iJHUd0wKAYfQAfIu5ahOTqqerVroX2+i9JWbPQqNLqCeDIh9KHm0Yza
	gfhFncMXtPqRBjYtQZkn41Ws2Nkm+0grLna8oqglz+qmxHfcGVcs7yxGDeIeNCim
	4EVPfkxzL9n0fiDqYST/A==
X-ME-Sender: <xms:Qj3PZ2wHQTKNZYTe6TfgPd_6QMvH4zl8gZAN88GOuPIIfUGVwum-cw>
    <xme:Qj3PZyRN4ZmRjgEsJr1kFzxWom6XyIKTLtkd-07iiYrstcG1EK-w-UsCakp9q3w9E
    a0K7XKm-BzfPJXRHy8>
X-ME-Received: <xmr:Qj3PZ4WIzDw2zaaiCruXS5yJ-AMuYLk9PmofOOMxJaNY7YO3jsppR1tGNWyCqi6qOP6cHyfJzPqKUMOj8BqqD6gnKDE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvddtudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioh
    eqnecuggftrfgrthhtvghrnhepudelhfdthfetuddvtefhfedtiedtteehvddtkedvledt
    vdevgedtuedutdeitdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehfughmrghnrghnrgeskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehkvghrnhgvlhdqthgvrghmsehfsgdrtghomh
X-ME-Proxy: <xmx:Qj3PZ8gKPRtwg_bd4LdxiNKES7_jQ937lXXtspuOsC40wDLSZ4vjjA>
    <xmx:Qz3PZ4ALUQ2vGDc5ps74BD4eYM6e79VvQ53tw1b3iYJjCUjYrf74nQ>
    <xmx:Qz3PZ9KBvZZE0dzudFsbdW-0ZrgxH_gXlSmhYN3188rzz3Tgduix7Q>
    <xmx:Qz3PZ_CDiK10fnCeKtcq08wl6FZcqxLxsxiVOcYh9tRctlCiXiwctw>
    <xmx:Qz3PZ7OPETl3pUtWUiAfTr500TJwS8X0Hz_ikIgtxXpAUFzpRgH0-Quo>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Mar 2025 15:28:02 -0400 (EDT)
Date: Mon, 10 Mar 2025 12:28:51 -0700
From: Boris Burkov <boris@bur.io>
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 1/5] btrfs: fix bg refcount race in
 btrfs_create_pending_block_groups
Message-ID: <20250310192851.GA857458@zen.localdomain>
References: <cover.1741306938.git.boris@bur.io>
 <f66e903dd583274967fcd45844e6444c4a49d98b.1741306938.git.boris@bur.io>
 <CAL3q7H4ErZWCa2qC1UgXVCfahA1Qx=WdeEGJ8E3COCLuH-n=5A@mail.gmail.com>
 <20250307213202.GA3554015@zen.localdomain>
 <CAL3q7H7k3eTUB3DtUSHAVNxs1kyXuoaT4GUO5MaDUWOO=th-+A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H7k3eTUB3DtUSHAVNxs1kyXuoaT4GUO5MaDUWOO=th-+A@mail.gmail.com>

On Mon, Mar 10, 2025 at 12:41:20PM +0000, Filipe Manana wrote:
> On Fri, Mar 7, 2025 at 9:31 PM Boris Burkov <boris@bur.io> wrote:
> >
> > On Fri, Mar 07, 2025 at 02:13:15PM +0000, Filipe Manana wrote:
> > > On Fri, Mar 7, 2025 at 12:31 AM Boris Burkov <boris@bur.io> wrote:
> > > >
> > > > To avoid a race where mark_bg_unused spuriously "moved" the block_group
> > > > from one bg_list attachment to another without taking a ref, we mark a
> > > > new block group with the bit BLOCK_GROUP_FLAG_NEW.
> > > >
> > > > However, this fix is not quite complete. Since it does not use the
> > > > unused_bg_lock, it is possible for the following race to occur:
> > > >
> > > > create_pending_block_groups                     mark_bg_unused
> > >
> > > mark_bg_unused -> btrfs_mark_bg_unused
> > >
> > > >                                            if list_empty // false
> > > >         list_del_init
> > > >         clear_bit
> > > >                                            else if (test_bit) // true
> > > >                                                 list_move_tail
> > >
> > > This should mention how that sequence is possible, i.e. on a higher level.
> > >
> > > For example the task that created the block group ended up not
> > > allocating extents from it,
> > > and other tasks allocated extents from it and deallocated so that the
> > > block group became empty
> > > and was added to the unused list before the task that created it
> > > finished btrfs_create_pending_block_groups().
> > >
> > > Or was it some other scenario?
> >
> > To be honest, since the detection of the error is so non-local to the
> > time of the error with these refcounting issues, I don't have any
> > proof that exactly this is happening. I just have a bunch of hosts with
> > wrong refcounts detected after a relocation and started squinting at
> > places it could have gone wrong.
> >
> > Your original patch and the very existence of the BLOCK_GROUP_FLAG_NEW
> > flag suggest to me that the two running concurrently is expected.
> 
> Well, even before that flag, there were problems already, but not so
> easy to analyze because list_del_init(), list_empty() and
> list_add_tail() are not atomic operations.
> 

It's funny because at first I was worried this was going to be some kind
of "we can't guarantee the order of the bit set vs the list empty"
re-ordering optimization kind of thing before I realized it just needed
a lock. Grateful it was the simpler case :)

> >
> > Would you like me to attempt to produce this condition on the current
> > kernel? Or I can duplicate/link to some of the reasoning from your first
> > fix here so that this commit message tells a better self-contained story?
> 
> You don't need to go trigger it and trace exactly how it happens, but
> mentioning a hypothetical scenario is enough.
> 
> Even before finishing the creation of a new block group, other tasks
> can allocate and deallocate extents from it, and on deallocation when
> it becomes empty we may add the new block group to the unused list.
> This is possible because during the lifetime of the transaction, we
> often flush (trigger writeback) dirty extent buffers because we
> reached the BTRFS_DIRTY_METADATA_THRESH limit or we're under memory
> pressure, so btree modifications on the extent buffers will be forced
> to COW, freeing the extent buffers previously allocated in the new
> block group and allocating new ones in some other block group, so that
> the new one becomes empty and is added to the unused list.

By the way, do you have a good argument why we don't need to check the
flag in btrfs_mark_bg_to_reclaim? It seems similar enough at first
blush, especially if you imagine a very low reclaim threshold, like 1%.

I'll look into your original patch more closely and think harder about
it, but also curious what you think.

> 
> With that:
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> 
> Thanks.
> 
> >
> > Thanks,
> > Boris
> >
> > >
> > > Thanks.
> > >
> > > >
> > > > And we get into the exact same broken ref count situation.
> > > > Those look something like:
> > > > [ 1272.943113] ------------[ cut here ]------------
> > > > [ 1272.943527] refcount_t: underflow; use-after-free.
> > > > [ 1272.943967] WARNING: CPU: 1 PID: 61 at lib/refcount.c:28 refcount_warn_saturate+0xba/0x110
> > > > [ 1272.944731] Modules linked in: btrfs virtio_net xor zstd_compress raid6_pq null_blk [last unloaded: btrfs]
> > > > [ 1272.945550] CPU: 1 UID: 0 PID: 61 Comm: kworker/u32:1 Kdump: loaded Tainted: G        W          6.14.0-rc5+ #108
> > > > [ 1272.946368] Tainted: [W]=WARN
> > > > [ 1272.946585] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.3-1-1 04/01/2014
> > > > [ 1272.947273] Workqueue: btrfs_discard btrfs_discard_workfn [btrfs]
> > > > [ 1272.947788] RIP: 0010:refcount_warn_saturate+0xba/0x110
> > > > [ 1272.948180] Code: 01 01 e8 e9 c7 a9 ff 0f 0b c3 cc cc cc cc 80 3d 3f 4a de 01 00 75 85 48 c7 c7 00 9b 9f 8f c6 05 2f 4a de 01 01 e8 c6 c7 a9 ff <0f> 0b c3 cc cc cc cc 80 3d 1d 4a de 01 00 0f 85 5e ff ff ff 48 c7
> > > > [ 1272.949532] RSP: 0018:ffffbf1200247df0 EFLAGS: 00010282
> > > > [ 1272.949901] RAX: 0000000000000000 RBX: ffffa14b00e3f800 RCX: 0000000000000000
> > > > [ 1272.950437] RDX: 0000000000000000 RSI: ffffbf1200247c78 RDI: 00000000ffffdfff
> > > > [ 1272.950986] RBP: ffffa14b00dc2860 R08: 00000000ffffdfff R09: ffffffff90526268
> > > > [ 1272.951512] R10: ffffffff904762c0 R11: 0000000063666572 R12: ffffa14b00dc28c0
> > > > [ 1272.952024] R13: 0000000000000000 R14: ffffa14b00dc2868 R15: 000001285dcd12c0
> > > > [ 1272.952850] FS:  0000000000000000(0000) GS:ffffa14d33c40000(0000) knlGS:0000000000000000
> > > > [ 1272.953458] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > [ 1272.953931] CR2: 00007f838cbda000 CR3: 000000010104e000 CR4: 00000000000006f0
> > > > [ 1272.954474] Call Trace:
> > > > [ 1272.954655]  <TASK>
> > > > [ 1272.954812]  ? refcount_warn_saturate+0xba/0x110
> > > > [ 1272.955173]  ? __warn.cold+0x93/0xd7
> > > > [ 1272.955487]  ? refcount_warn_saturate+0xba/0x110
> > > > [ 1272.955816]  ? report_bug+0xe7/0x120
> > > > [ 1272.956103]  ? handle_bug+0x53/0x90
> > > > [ 1272.956424]  ? exc_invalid_op+0x13/0x60
> > > > [ 1272.956700]  ? asm_exc_invalid_op+0x16/0x20
> > > > [ 1272.957011]  ? refcount_warn_saturate+0xba/0x110
> > > > [ 1272.957399]  btrfs_discard_cancel_work.cold+0x26/0x2b [btrfs]
> > > > [ 1272.957853]  btrfs_put_block_group.cold+0x5d/0x8e [btrfs]
> > > > [ 1272.958289]  btrfs_discard_workfn+0x194/0x380 [btrfs]
> > > > [ 1272.958729]  process_one_work+0x130/0x290
> > > > [ 1272.959026]  worker_thread+0x2ea/0x420
> > > > [ 1272.959335]  ? __pfx_worker_thread+0x10/0x10
> > > > [ 1272.959644]  kthread+0xd7/0x1c0
> > > > [ 1272.959872]  ? __pfx_kthread+0x10/0x10
> > > > [ 1272.960172]  ret_from_fork+0x30/0x50
> > > > [ 1272.960474]  ? __pfx_kthread+0x10/0x10
> > > > [ 1272.960745]  ret_from_fork_asm+0x1a/0x30
> > > > [ 1272.961035]  </TASK>
> > > > [ 1272.961238] ---[ end trace 0000000000000000 ]---
> > > >
> > > > Though we have seen them in the async discard workfn as well. It is
> > > > most likely to happen after a relocation finishes which cancels discard,
> > > > tears down the block group, etc.
> > > >
> > > > Fix this fully by taking the lock around the list_del_init + clear_bit
> > > > so that the two are done atomically.
> > > >
> > > > Fixes: 0657b20c5a76 ("btrfs: fix use-after-free of new block group that became unused")
> > > > Signed-off-by: Boris Burkov <boris@bur.io>
> > > > ---
> > > >  fs/btrfs/block-group.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > >
> > > > diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> > > > index 64f0268dcf02..2db1497b58d9 100644
> > > > --- a/fs/btrfs/block-group.c
> > > > +++ b/fs/btrfs/block-group.c
> > > > @@ -2797,8 +2797,11 @@ void btrfs_create_pending_block_groups(struct btrfs_trans_handle *trans)
> > > >                 /* Already aborted the transaction if it failed. */
> > > >  next:
> > > >                 btrfs_dec_delayed_refs_rsv_bg_inserts(fs_info);
> > > > +
> > > > +               spin_lock(&fs_info->unused_bgs_lock);
> > > >                 list_del_init(&block_group->bg_list);
> > > >                 clear_bit(BLOCK_GROUP_FLAG_NEW, &block_group->runtime_flags);
> > > > +               spin_unlock(&fs_info->unused_bgs_lock);
> > > >
> > > >                 /*
> > > >                  * If the block group is still unused, add it to the list of
> > > > --
> > > > 2.48.1
> > > >
> > > >

