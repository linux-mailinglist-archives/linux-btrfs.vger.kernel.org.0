Return-Path: <linux-btrfs+bounces-12140-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3424DA5950A
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Mar 2025 13:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA209188611A
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Mar 2025 12:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E9D22172D;
	Mon, 10 Mar 2025 12:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zig7SMEB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461B61E4BE
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Mar 2025 12:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741610875; cv=none; b=eGG+xkYn6iLg1JBrqWpNloBZKs0k1jvi+Hk4W9sZg9RwjkWWFAooG6C45WCBcYbb/42eWrgErOLTy9sOb0mFmnJmAco82qmhm0vzYugOH+rxrNWf9UAFbvYArlZT439Dh11t+DHKF2dn4IR1IAWLnshtC7wakVOSTwYu8coZqLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741610875; c=relaxed/simple;
	bh=ZQG+JEj3zuMRF8rsPEQTgaMUnOyLEADG+f1kNBJ7Y3c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LaF+cMM+unlyDBitQIAmAzoJCiAayCOsV0h8upJm+9K8uQvAqGrYUROppfZqWhMDolxeVI+2aZaA1RcjRPk7MU7ivhUo+WP4fsiR8h1/PxHEZQYKEJB/HpiCPMfaoAnizRBcE3ptIRXTOv6WWgKG36qUxfQcDxDssSdVRSYSmO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zig7SMEB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABE7DC4CEEE
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Mar 2025 12:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741610874;
	bh=ZQG+JEj3zuMRF8rsPEQTgaMUnOyLEADG+f1kNBJ7Y3c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Zig7SMEB3+b2nmXakM+Bz4jbE2HPRUvPm4dhNUtAG/GplrM6sKqu5PNCS1PcSztKM
	 KpkExzxoRK3TC9xzATWZwuo7AuF4wYxXk0Jw15dNvMedXCp4Xz1EeDWxvnPE/bs6u3
	 6RrqqyX/ccOHt/0r+FQftMohjgo4JUviM7Gt+CgQFMgfLumpTcaz+UQ/zHndd37XSi
	 bH7icNhleAu4NRmCvHPYHn8W9dQxn61nChL0ZaFsOQtd3smrJQ0F6Kpkd6NHDZht4M
	 Ti3VJSmzijOTQeUZ58wxJUV7HggHNFkm547o6hEE7p08cXGQCHgvRuoU4pnHPbOFtY
	 tEu3ofQQDEZbQ==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ab78e6edb99so637077666b.2
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Mar 2025 05:47:54 -0700 (PDT)
X-Gm-Message-State: AOJu0YxjahGnszlEznyFuNQ3G3yvF3/nfW0VgzszHJTm06ZOVk+hxjQT
	9NlQmg1DhQftN6a8vSRgGZK7zCpze8p46GnDT6AXxhmpO1UBtG+cd2nN8wbBJK36he2GeRPN2Et
	RqSiC2IbhQ6/xs7Et5wjOUlnzFNE=
X-Google-Smtp-Source: AGHT+IG7AvvBU4+v+bXxCbzAPo1Sfi84gWJN3xgit2Amxq98WfMb3plOYStnXDIcIMCE9Tp2Taffi8UfvB0aZSZV1e4=
X-Received: by 2002:a17:907:7e94:b0:abe:c81a:985d with SMTP id
 a640c23a62f3a-ac25300af3cmr1375175066b.48.1741610873171; Mon, 10 Mar 2025
 05:47:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1741306938.git.boris@bur.io> <8ba94e9758ff9d5278ed86fcff2acdd429d5deee.1741306938.git.boris@bur.io>
 <CAL3q7H49V0cbzx0sW__5AY0ZyXnPq15f6eNTa0kGJHvNZEbyOQ@mail.gmail.com> <20250307213745.GB3554015@zen.localdomain>
In-Reply-To: <20250307213745.GB3554015@zen.localdomain>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 10 Mar 2025 12:47:15 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4uxntEVsq5JUk9FJYHjvOyF5+Wv-nfKOQ37dC10e0LPA@mail.gmail.com>
X-Gm-Features: AQ5f1JorCNppORM0czGWETdGX30F2xBmg8xpUTVPfhvOkugZIIgu4iaTbfmqXNE
Message-ID: <CAL3q7H4uxntEVsq5JUk9FJYHjvOyF5+Wv-nfKOQ37dC10e0LPA@mail.gmail.com>
Subject: Re: [PATCH 2/5] btrfs: fix bg->bg_list list_del refcount races
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 9:36=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
>
> On Fri, Mar 07, 2025 at 02:24:34PM +0000, Filipe Manana wrote:
> > On Fri, Mar 7, 2025 at 12:31=E2=80=AFAM Boris Burkov <boris@bur.io> wro=
te:
> > >
> > > If there is any chance at all of racing with mark_bg_unused, better s=
afe
> > > than sorry.
> > >
> > > Otherwise we risk the following interleaving (bg_list refcount in par=
ens)
> > >
> > > T1 (some random op)                         T2 (mark_bg_unused)
> >
> > mark_bg_unused -> btrfs_mark_bg_unused
> >
> > Please use complete names everywhere.
> >
> > >                                         !list_empty(&bg->bg_list); (1=
)
> > > list_del_init(&bg->bg_list); (1)
> > >                                         list_move_tail (1)
> > > btrfs_put_block_group (0)
> > >                                         btrfs_delete_unused_bgs
> > >                                              bg =3D list_first_entry
> > >                                              list_del_init(&bg->bg_li=
st);
> > >                                              btrfs_put_block_group(bg=
); (-1)
> > >
> > > Ultimately, this results in a broken ref count that hits zero one der=
ef
> > > early and the real final deref underflows the refcount, resulting in =
a WARNING.
> > >
> > > Signed-off-by: Boris Burkov <boris@bur.io>
> > > ---
> > >  fs/btrfs/extent-tree.c | 3 +++
> > >  fs/btrfs/transaction.c | 5 +++++
> > >  2 files changed, 8 insertions(+)
> > >
> > > diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> > > index 5de1a1293c93..80560065cc1b 100644
> > > --- a/fs/btrfs/extent-tree.c
> > > +++ b/fs/btrfs/extent-tree.c
> > > @@ -2868,7 +2868,10 @@ int btrfs_finish_extent_commit(struct btrfs_tr=
ans_handle *trans)
> > >                                                    block_group->lengt=
h,
> > >                                                    &trimmed);
> > >
> > > +               spin_lock(&fs_info->unused_bgs_lock);
> > >                 list_del_init(&block_group->bg_list);
> > > +               spin_unlock(&fs_info->unused_bgs_lock);
> >
> > This shouldn't need the lock, because block groups added to the
> > transaction->deleted_bgs list were made RO only before at
> > btrfs_delete_unused_bgs().
> >
>
> My thinking is that it is a lot easier to reason about this if we also
> lock it when modifying the bg_list. That will insulate us against any
> possible bugs with different uses of bg_list attaching to various lists.

Sure, I get it, while it may not be a problem today, with code changes
elsewhere, it may become a problem.

>
> When hunting for "broken refcount maybe" this time around, I had to dig
> through all of these and carefully analyze them.
>
> I agree with you that these are probably not strictly necessary in any
> way, which is partly why I made them a separate patch from the one I
> think is a bug. Perhaps I should retitle the patch to not use the terms
> "fix" and "race" and instead call it something like:
> "harden uses of bg_list against possible races" or something?

Yes, the "harden ..." is a better choice IMO.

>
> > > +
> > >                 btrfs_unfreeze_block_group(block_group);
> > >                 btrfs_put_block_group(block_group);
> > >
> > > diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> > > index db8fe291d010..c98a8efd1bea 100644
> > > --- a/fs/btrfs/transaction.c
> > > +++ b/fs/btrfs/transaction.c
> > > @@ -160,7 +160,9 @@ void btrfs_put_transaction(struct btrfs_transacti=
on *transaction)
> > >                         cache =3D list_first_entry(&transaction->dele=
ted_bgs,
> > >                                                  struct btrfs_block_g=
roup,
> > >                                                  bg_list);
> > > +                       spin_lock(&transaction->fs_info->unused_bgs_l=
ock);
> > >                         list_del_init(&cache->bg_list);
> > > +                       spin_unlock(&transaction->fs_info->unused_bgs=
_lock);
> >
> > In the transaction abort path no else should be messing up with the lis=
t too.
> >
> > >                         btrfs_unfreeze_block_group(cache);
> > >                         btrfs_put_block_group(cache);
> > >                 }
> > > @@ -2096,7 +2098,10 @@ static void btrfs_cleanup_pending_block_groups=
(struct btrfs_trans_handle *trans)
> > >
> > >         list_for_each_entry_safe(block_group, tmp, &trans->new_bgs, b=
g_list) {
> > >                 btrfs_dec_delayed_refs_rsv_bg_inserts(fs_info);
> > > +              spin_lock(&fs_info->unused_bgs_lock);
> > >                 list_del_init(&block_group->bg_list);
> > > +              btrfs_put_block_group(block_group);
> > > +              spin_unlock(&fs_info->unused_bgs_lock);
> >
> > What's this new btrfs_put_block_group() for? I don't see a matching
> > ref count increase in the patch.
> > Or is this fixing a separate bug? Where's the matching ref count
> > increase in the codebase?
>
> Sloppy to include it here, sorry. I can pull it out separately if you
> like.

Yeah, seeing the reply on patch 4/5, this put should've been part of
patch 4/5 and not this one.
So just move it to that patch, it doesn't make sense here and actually
introduces a bug if the other patch is not applied.

Thanks.

>
> The intention of this change is to simply be disciplined about
> maintaining the invariant that "bg is linked to a list via bg_list iff
> bg refcount is incremented". That way we can confidently assert that the
> list should be empty upon deletion, and catch more bugs, for example.
>
> It certainly matters the least on transaction abort, when the state is
> messed up anyway.
>
> >
> > As before, we're in the transaction abort path, no one should be
> > messing with the list too.
> >
> > I don't mind adding the locking just to be safe, but leaving a comment
> > to mention it shouldn't be needed and why there's concurrency expected
> > in these cases would be nice.
>
> I can definitely add a comment to the ones we expect don't care. (As
> well as the re-titling I suggested above)
>
> >
> > Thanks.
> >
> > >         }
> > >  }
> >
> > >
> > > --
> > > 2.48.1
> > >
> > >

