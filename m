Return-Path: <linux-btrfs+bounces-12105-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ABECA573AC
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Mar 2025 22:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F17B83B0846
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Mar 2025 21:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6F421C9EC;
	Fri,  7 Mar 2025 21:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="p4PzK7mV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="7vdeCSxu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C3F1AA1D9
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Mar 2025 21:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741383415; cv=none; b=JTf6NZGMQ+KlCrrD1/t5B/zA3YrB9SM8Izq5odQtdln6JdWuk4EWxYCWeTnTqSmG8GOPcfokYIz+EQRlY0BbUsaU3f61jBYOsLPNBMSjL5ADF45KBTEHgvBaIn/kA9TGp53nCrNAlVXPYEMbjZNlqDO7Qd7aKF3NCIL1lS9f0os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741383415; c=relaxed/simple;
	bh=lEaSoE9TBd9eJoWsVnhOIUAKFmRGbA50K2hfy+N+bRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jvbBxcdyLXHTJaPz0YwayoWHRdT8P4sZCJtUOzVW5wRn8kY9WDKa+eJ1QgJh0kh83Yk48X7Y0f9Ezp95RLEefa+8Uhhn6f74pZawsrAjrca9LxSHap2WKKorLQ4LBA+2EQXkhD/rQoPJiGxTexKqNq1DTruwDUsRNspiklx+iv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=p4PzK7mV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=7vdeCSxu; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 45EE01140184;
	Fri,  7 Mar 2025 16:36:52 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 07 Mar 2025 16:36:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1741383412;
	 x=1741469812; bh=+kD+TtYdMzETGJW3jlD6SigUPhfooj+rgTI3cKkugWY=; b=
	p4PzK7mVktZHGSkTIrcGxY704Cl8WQeLJew4JYDNt0/TMTZGOqvbQuzdqd8/qR9f
	WyF3IujFDnFWwY8ZBvGBFzBcynWPGKvoiDpgov5SH+AL9Wd6MfcusDu5wJMWUhz6
	F1AX8VAEcDrRReZHJ6YZeVAYqVAoDhcKtt86x0udobE8JTo2eErpoJrA7F11gQ6n
	2B9f0C8KtE56zEFdE99uaNdlItC/dKl+OgsC6Pn3+TEPo1QYtdnmVNopvhWURqj1
	LRzTpRUdiRMPmVgoB0Go8Razr05FvHhdYN0Z1hMboTl2imfzpfs46ddF6mGd92rT
	eT+ydT5pKXzEx2pbdZ910g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741383412; x=
	1741469812; bh=+kD+TtYdMzETGJW3jlD6SigUPhfooj+rgTI3cKkugWY=; b=7
	vdeCSxudwDTM4+IdE4kI9kD6LFmXMQQRWndEP2yzu95BHcoPrkso/3VC+dIark78
	KFtWdD082jkJ+hsfF8FO2WsD2pJcFlnT+6cEA3KUo2Vd72BRTze4pSqoaa7eCHFS
	GfIoT3E1R5aev/Xsk9ZL92Ajk+semXT7xktwUY6c6mXiAQfsA66YrqrrnuiQtL4H
	2m4J0Yfj8JOtH8tB7+RylPjw73/uw0ICk4FbzYAviYc5XiMdI9KV6STqqmMq/flv
	TltBoj7nf4WQlfcwa3flJRBUFG2/8SKduRyx7omXuWD6QOsSuDvYEtmFBwdNsOne
	4nh6ROY7v2bfsRp+TI3DA==
X-ME-Sender: <xms:82bLZ3LAltOewrEjHzbOSCSj4YjtFyuO_1P6zZrMjZ8tBDEpIOiogw>
    <xme:82bLZ7J4JBWLyHmrNbGeEkJuGQOBIM3Zk3BVfZiJF5CVy9XRzZIYQv8T4Dal7ubTw
    lOkK2NkcaJaf4ssKxk>
X-ME-Received: <xmr:82bLZ_unb1xTZMPU_aQeTHfk2m4juK58KVlgILyuhvqDoAimkm2sBk4tir2_ma_xn0rKjD6INuJuGUm2xKYtp9h6H8o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduuddujeehucetufdoteggodetrf
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
X-ME-Proxy: <xmx:82bLZwZ0vXa6KDO8p80YtkS-4Vu24GopiA9975z2BeT7hKYWvQEWWw>
    <xmx:82bLZ-aOsyog1Km-wJe9USXD3Ub8CCJRLyqIjo8iH9iJh5xxPPqevw>
    <xmx:82bLZ0AYxTFxi2FhOdB9Ma5V3ts-dB-TYfDDmw-QP51VAPhWJgF_Ag>
    <xmx:82bLZ8ZkUpJNoWuzDzZycXTJ-64TrhvJ1CBr7sv6EYMic2yJw8UvCA>
    <xmx:9GbLZ-FFYPv-4A3Px_0KRbP004I1kQoz-Y3ozp5nzTvIchRr5zSFlsVd>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Mar 2025 16:36:51 -0500 (EST)
Date: Fri, 7 Mar 2025 13:37:45 -0800
From: Boris Burkov <boris@bur.io>
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 2/5] btrfs: fix bg->bg_list list_del refcount races
Message-ID: <20250307213745.GB3554015@zen.localdomain>
References: <cover.1741306938.git.boris@bur.io>
 <8ba94e9758ff9d5278ed86fcff2acdd429d5deee.1741306938.git.boris@bur.io>
 <CAL3q7H49V0cbzx0sW__5AY0ZyXnPq15f6eNTa0kGJHvNZEbyOQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H49V0cbzx0sW__5AY0ZyXnPq15f6eNTa0kGJHvNZEbyOQ@mail.gmail.com>

On Fri, Mar 07, 2025 at 02:24:34PM +0000, Filipe Manana wrote:
> On Fri, Mar 7, 2025 at 12:31 AM Boris Burkov <boris@bur.io> wrote:
> >
> > If there is any chance at all of racing with mark_bg_unused, better safe
> > than sorry.
> >
> > Otherwise we risk the following interleaving (bg_list refcount in parens)
> >
> > T1 (some random op)                         T2 (mark_bg_unused)
> 
> mark_bg_unused -> btrfs_mark_bg_unused
> 
> Please use complete names everywhere.
> 
> >                                         !list_empty(&bg->bg_list); (1)
> > list_del_init(&bg->bg_list); (1)
> >                                         list_move_tail (1)
> > btrfs_put_block_group (0)
> >                                         btrfs_delete_unused_bgs
> >                                              bg = list_first_entry
> >                                              list_del_init(&bg->bg_list);
> >                                              btrfs_put_block_group(bg); (-1)
> >
> > Ultimately, this results in a broken ref count that hits zero one deref
> > early and the real final deref underflows the refcount, resulting in a WARNING.
> >
> > Signed-off-by: Boris Burkov <boris@bur.io>
> > ---
> >  fs/btrfs/extent-tree.c | 3 +++
> >  fs/btrfs/transaction.c | 5 +++++
> >  2 files changed, 8 insertions(+)
> >
> > diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> > index 5de1a1293c93..80560065cc1b 100644
> > --- a/fs/btrfs/extent-tree.c
> > +++ b/fs/btrfs/extent-tree.c
> > @@ -2868,7 +2868,10 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
> >                                                    block_group->length,
> >                                                    &trimmed);
> >
> > +               spin_lock(&fs_info->unused_bgs_lock);
> >                 list_del_init(&block_group->bg_list);
> > +               spin_unlock(&fs_info->unused_bgs_lock);
> 
> This shouldn't need the lock, because block groups added to the
> transaction->deleted_bgs list were made RO only before at
> btrfs_delete_unused_bgs().
> 

My thinking is that it is a lot easier to reason about this if we also
lock it when modifying the bg_list. That will insulate us against any
possible bugs with different uses of bg_list attaching to various lists.

When hunting for "broken refcount maybe" this time around, I had to dig
through all of these and carefully analyze them.

I agree with you that these are probably not strictly necessary in any
way, which is partly why I made them a separate patch from the one I
think is a bug. Perhaps I should retitle the patch to not use the terms
"fix" and "race" and instead call it something like:
"harden uses of bg_list against possible races" or something?

> > +
> >                 btrfs_unfreeze_block_group(block_group);
> >                 btrfs_put_block_group(block_group);
> >
> > diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> > index db8fe291d010..c98a8efd1bea 100644
> > --- a/fs/btrfs/transaction.c
> > +++ b/fs/btrfs/transaction.c
> > @@ -160,7 +160,9 @@ void btrfs_put_transaction(struct btrfs_transaction *transaction)
> >                         cache = list_first_entry(&transaction->deleted_bgs,
> >                                                  struct btrfs_block_group,
> >                                                  bg_list);
> > +                       spin_lock(&transaction->fs_info->unused_bgs_lock);
> >                         list_del_init(&cache->bg_list);
> > +                       spin_unlock(&transaction->fs_info->unused_bgs_lock);
> 
> In the transaction abort path no else should be messing up with the list too.
> 
> >                         btrfs_unfreeze_block_group(cache);
> >                         btrfs_put_block_group(cache);
> >                 }
> > @@ -2096,7 +2098,10 @@ static void btrfs_cleanup_pending_block_groups(struct btrfs_trans_handle *trans)
> >
> >         list_for_each_entry_safe(block_group, tmp, &trans->new_bgs, bg_list) {
> >                 btrfs_dec_delayed_refs_rsv_bg_inserts(fs_info);
> > +              spin_lock(&fs_info->unused_bgs_lock);
> >                 list_del_init(&block_group->bg_list);
> > +              btrfs_put_block_group(block_group);
> > +              spin_unlock(&fs_info->unused_bgs_lock);
> 
> What's this new btrfs_put_block_group() for? I don't see a matching
> ref count increase in the patch.
> Or is this fixing a separate bug? Where's the matching ref count
> increase in the codebase?

Sloppy to include it here, sorry. I can pull it out separately if you
like.

The intention of this change is to simply be disciplined about
maintaining the invariant that "bg is linked to a list via bg_list iff
bg refcount is incremented". That way we can confidently assert that the
list should be empty upon deletion, and catch more bugs, for example.

It certainly matters the least on transaction abort, when the state is
messed up anyway.

> 
> As before, we're in the transaction abort path, no one should be
> messing with the list too.
> 
> I don't mind adding the locking just to be safe, but leaving a comment
> to mention it shouldn't be needed and why there's concurrency expected
> in these cases would be nice.

I can definitely add a comment to the ones we expect don't care. (As
well as the re-titling I suggested above)

> 
> Thanks.
> 
> >         }
> >  }
> 
> >
> > --
> > 2.48.1
> >
> >

