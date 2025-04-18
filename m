Return-Path: <linux-btrfs+bounces-13165-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E14A93A48
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Apr 2025 18:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D8313BE130
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Apr 2025 16:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1AA2144D3;
	Fri, 18 Apr 2025 16:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="GNvc6kHc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q5l/Yvh2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366002147E3
	for <linux-btrfs@vger.kernel.org>; Fri, 18 Apr 2025 16:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744992221; cv=none; b=EkOZRvB/xYtxBHXnKBRESHgYl2iPDxQVE8C0q7nLrT2i4zlu+Z3NItWB0HEWhJcCMZVuzDlAaCq9chrJd1xLJO/sA5dhqH83/fcLMMYyUkYTenwKnriagLAX6yMhsOOH5Ild4wQuUpPIBcWPAaik4iYH4cptBU9kV5LV77sjwYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744992221; c=relaxed/simple;
	bh=8r+laSByp3GXUbYnxHM7MrxdB4QdkDC4W5zgp5eYQno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UykBbBzm0n3wbopb1MD1pNe8N3QBkTGCtHwRi9bieduSGvzzoX1oBMs7+IYzv7PwZBsPt2xBwKDF24HA7+vDLNcmDfmvEo2sBTUBiClCuICnJNmhNjstYZdQ0gCRbOQvpQf3F3P+27PszBqfvm+bQiZp+8tEKmxjz+zy7VIgwmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=GNvc6kHc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q5l/Yvh2; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DFD2F25401A2;
	Fri, 18 Apr 2025 12:03:36 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 18 Apr 2025 12:03:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1744992216;
	 x=1745078616; bh=wswOV2p1FH6hmzKNZHLV94dDGvM/61e7eUvcjE3i87k=; b=
	GNvc6kHcVAIvVWZoa0R88lNmML9D9Mo0TiphfoTy8iOYS0bG3KJhVEkpipZoAunE
	DcpdwpqlmxnbZqWoYvOErq8v4AYCbmXILFQwAHcplwZZWlQoBXcZW8DhIRAQ4MuX
	SPH7007Ik4/ROEuymReTWg1sMkUhOWmS22nVLpqsSMRyPquOF4mB8XaIUOnN7r9P
	gYnIS/qeaOOX0w/S0VkCh0qiiZqVjGyxZ1JENl1ZYkMgVXThdYs+BWGIHzBxlxHY
	I3aq1fyWBhqr580tf9LiNy01U9OUI/hLyKLjLoDo3sfeUcgbHN3PFZKAROJb7mbs
	lwAVSGMZ46clCLx4kSbx+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744992216; x=
	1745078616; bh=wswOV2p1FH6hmzKNZHLV94dDGvM/61e7eUvcjE3i87k=; b=q
	5l/Yvh2HkvM5VdOVuNvt819Me9DZHRc0Owzyr/N5qggLwcLR63W77ZPKMs9u7IqL
	IlHF9of7VMNmArUWpTuAiWnw6MMlQc/Ps//uoMU+KdV5JYC5+xNYKq0fSolxbtI6
	krgQUBmopwnyyKTCEf9hVtdq8Vln9E+INZ3jL6xKmciYAR9QiEGOafDpRyY24AgA
	HEo/MdFTVSeLQhGQKB/VFWPR1kOeYagk//KSvRGQL8WvAn3YkH0X7g1Y/GDgfSVG
	H64OQFYIX/Y28dPUWhmA0eEMx7EhP2Pw2XqCpxmn4Vmfy2tiwEXkZDPYVCd1EKCA
	nnNzcMCDgfMcoiH6DUSVA==
X-ME-Sender: <xms:2HcCaDyGvf9YyjZS5YagyD-0lRLR3nVfeFOtenJ6E7QubFH2RH5F_w>
    <xme:2HcCaLQrkjljrD_6mlY9d9Yvmkn3pmqDE-0gulLEBYjosoc1ROE2Doe_LTTQmV0fh
    FA_6x4zu58WF2zF0k8>
X-ME-Received: <xmr:2HcCaNWr0C8MBaDkSym0d53u2dvx-7W72YtwPrAMMs6BlwSkc7pDPWtQQuFBgomzDANjeQJIgCw9xmJ4wqqis4Z6FPk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfedvheekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioh
    eqnecuggftrfgrthhtvghrnhephefhudehgfekhedufedvtefgteelueeigfefhfefgeej
    keefhefhgfekjefhvdehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhr
    rdhiohdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epfhgumhgrnhgrnhgrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvggvlhigsehs
    uhhsvgdrtghomhdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepkhgvrhhnvghlqdhtvggrmhesfhgsrdgtohhm
X-ME-Proxy: <xmx:2HcCaNjzeTnlsxko23gWst3QrCbLTIQrGngzC-UvI7pFg7ExFcUFDg>
    <xmx:2HcCaFCnZGHxmVB6JGIQJk6VUTHO2xIC_SMkVAzvOezJx_srL6--SQ>
    <xmx:2HcCaGK50wTUWrcn1RGB9A9i9V8vaG566O4ERA_WU0npXC3DHvZO7w>
    <xmx:2HcCaECMqZtSGuamQd4udk4zLI5o1ddnqPfeXX3Y47vFfYmFdUsP7g>
    <xmx:2HcCaFj4slTTmJyFgYxnQesKbyxhiJmxQS-rItEIcxTR58_1pZjO8IIu>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Apr 2025 12:03:35 -0400 (EDT)
Date: Fri, 18 Apr 2025 09:04:50 -0700
From: Boris Burkov <boris@bur.io>
To: Filipe Manana <fdmanana@kernel.org>
Cc: Daniel Vacek <neelx@suse.com>, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH v2] btrfs: fix broken drop_caches on extent_buffer folios
Message-ID: <20250418160450.GA2669173@zen.localdomain>
References: <f5a3cbb2f51851dc55ff51647a214f912d6d5043.1744931654.git.boris@bur.io>
 <CAPjX3Fc9YAmfKGdNrQK=Zsv6NVERUnK9Fxg=7Z4vCBrimEjyVg@mail.gmail.com>
 <CAL3q7H7JAeT3C_+SULVRdZA6XsnHpoZD_je6dEKzj+K53KVgWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H7JAeT3C_+SULVRdZA6XsnHpoZD_je6dEKzj+K53KVgWg@mail.gmail.com>

On Fri, Apr 18, 2025 at 11:49:50AM +0100, Filipe Manana wrote:
> On Fri, Apr 18, 2025 at 10:24 AM Daniel Vacek <neelx@suse.com> wrote:
> >
> > On Fri, 18 Apr 2025 at 01:15, Boris Burkov <boris@bur.io> wrote:
> > >
> > > The (correct) commit
> > > e41c81d0d30e ("mm/truncate: Replace page_mapped() call in invalidate_inode_page()")
> > > replaced the page_mapped(page) check with a refcount check. However,
> > > this refcount check does not work as expected with drop_caches for
> > > btrfs's metadata pages.
> > >
> > > Btrfs has a per-sb metadata inode with cached pages, and when not in
> > > active use by btrfs, they have a refcount of 3. One from the initial
> > > call to alloc_pages, one (nr_pages == 1) from filemap_add_folio, and one
> > > from folio_attach_private. We would expect such pages to get dropped by
> > > drop_caches. However, drop_caches calls into mapping_evict_folio via
> > > mapping_try_invalidate which gets a reference on the folio with
> > > find_lock_entries(). As a result, these pages have a refcount of 4, and
> > > fail this check.
> > >
> > > For what it's worth, such pages do get reclaimed under memory pressure,
> > > so I would say that while this behavior is surprising, it is not really
> > > dangerously broken.
> > >
> > > When I asked the mm folks about the expected refcount in this case, I
> > > was told that the correct thing to do is to donate the refcount from the
> > > original allocation to the page cache after inserting it.
> > > https://lore.kernel.org/linux-mm/ZrwhTXKzgDnCK76Z@casper.infradead.org/
> > >
> > > Therefore, attempt to fix this by adding a put_folio() to the critical
> > > spot in alloc_extent_buffer where we are sure that we have really
> > > allocated and attached new pages. We must also adjust
> > > folio_detach_private to properly handle being the last reference to the
> > > folio and not do a UAF after folio_detach_private().
> > >
> > > Finally, extent_buffers allocated by clone_extent_buffer() and
> > > alloc_dummy_extent_buffer() are unmapped, so this transfer of ownership
> > > from allocation to insertion in the mapping does not apply to them.
> > > Therefore, they still need a folio_put() as before.
> > >
> > > Reviewed-by: Filipe Manana <fdmanana@suse.com>
> > > Signed-off-by: Boris Burkov <boris@bur.io>
> > > ---
> > > Changelog:
> > > v2:
> > > * Used Filipe's suggestion to simplify detach_extent_buffer_folio and
> > >   lose the extra folio_get()/folio_put() pair
> > > * Noticed a memory leak causing failures in fstests on smaller vms.
> > >   Fixed a bug where I was missing a folio_put() for ebs that never got
> > >   their folios added to the mapping.
> > >
> > >  fs/btrfs/extent_io.c | 28 ++++++++++++++++++++--------
> > >  1 file changed, 20 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> > > index 5f08615b334f..90499124b8a5 100644
> > > --- a/fs/btrfs/extent_io.c
> > > +++ b/fs/btrfs/extent_io.c
> > > @@ -2752,6 +2752,7 @@ static bool folio_range_has_eb(struct folio *folio)
> > >  static void detach_extent_buffer_folio(const struct extent_buffer *eb, struct folio *folio)
> > >  {
> > >         struct btrfs_fs_info *fs_info = eb->fs_info;
> > > +       struct address_space *mapping = folio->mapping;
> > >         const bool mapped = !test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags);
> > >
> > >         /*
> > > @@ -2759,11 +2760,11 @@ static void detach_extent_buffer_folio(const struct extent_buffer *eb, struct fo
> > >          * be done under the i_private_lock.
> > >          */
> > >         if (mapped)
> > > -               spin_lock(&folio->mapping->i_private_lock);
> > > +               spin_lock(&mapping->i_private_lock);
> > >
> > >         if (!folio_test_private(folio)) {
> > >                 if (mapped)
> > > -                       spin_unlock(&folio->mapping->i_private_lock);
> > > +                       spin_unlock(&mapping->i_private_lock);
> > >                 return;
> > >         }
> > >
> > > @@ -2783,7 +2784,7 @@ static void detach_extent_buffer_folio(const struct extent_buffer *eb, struct fo
> > >                         folio_detach_private(folio);
> > >                 }
> > >                 if (mapped)
> > > -                       spin_unlock(&folio->mapping->i_private_lock);
> > > +                       spin_unlock(&mapping->i_private_lock);
> > >                 return;
> > >         }
> > >
> > > @@ -2806,7 +2807,7 @@ static void detach_extent_buffer_folio(const struct extent_buffer *eb, struct fo
> > >         if (!folio_range_has_eb(folio))
> > >                 btrfs_detach_subpage(fs_info, folio, BTRFS_SUBPAGE_METADATA);
> > >
> > > -       spin_unlock(&folio->mapping->i_private_lock);
> > > +       spin_unlock(&mapping->i_private_lock);
> > >  }
> > >
> > >  /* Release all folios attached to the extent buffer */
> > > @@ -2821,9 +2822,13 @@ static void btrfs_release_extent_buffer_folios(const struct extent_buffer *eb)
> > >                         continue;
> > >
> > >                 detach_extent_buffer_folio(eb, folio);
> > > -
> > > -               /* One for when we allocated the folio. */
> > > -               folio_put(folio);
> >
> > So far so good, but...
> >
> > > +               /*
> > > +                * We only release the allocated refcount for mapped extent_buffer
> > > +                * folios. If the folio is unmapped, we have to release its allocated
> > > +                * refcount here.
> > > +                */
> > > +               if (test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags))
> > > +                       folio_put(folio);
> >
> > ...is this really correct? I'd do rather this instead:
> 
> Yes, it is correct. It does deal with cloned extent buffers, where we
> need the extra put since we didn't do it after attaching the folio to
> it.
> Alternatively we could probably do the put after the attach at
> btrfs_clone_extent_buffer(), just like for regular extent buffers, and
> get rid of this special casing.
> 

I didn't do it this way originally because I was hewing to the model
that we were donating the allocated refcount to the mapping when
inserting it (modeled after readahead) and I did not have a
corresponding model for these ebs which are not added to an
address_space.

I agree that your proposal results in simpler code so I will run it
through fstests as well. It's difficult to predict if there are any
negative side effects to these eb folios having one lower ref count
at steady state. It _seems_ like it ought to be fine :)

Thanks to both of you for the review,
Boris

> >
> > @@ -3393,22 +3393,21 @@ struct extent_buffer
> > *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
> >          * case.  If we left eb->folios[i] populated in the subpage case we'd
> >          * double put our reference and be super sad.
> >          */
> > -       for (int i = 0; i < attached; i++) {
> > -               ASSERT(eb->folios[i]);
> > -               detach_extent_buffer_folio(eb, eb->folios[i]);
> > +       for (int i = 0; i < num_extent_folios(eb); i++) {
> > +               if (i < attached) {
> > +                       ASSERT(eb->folios[i]);
> > +                       detach_extent_buffer_folio(eb, eb->folios[i]);
> > +               } else if (!eb->folios[i])
> > +                       continue;
> >                 folio_unlock(eb->folios[i]);
> >                 folio_put(eb->folios[i]);
> >                 eb->folios[i] = NULL;
> >
> > And perhaps `struct folio *folio = eb->folios[i];` first and substitute.
> >
> > Or is this unrelated and we need both?
> 
> This is unrelated.
> What you're trying to do here is to simplify the error path of the
> allocation of a regular extent buffer.
> Nothing to do with Boris' fix, and out of the scope of the fix.
> 
> >
> > And honestly, IMO, there's no reason to set the EXTENT_BUFFER_UNMAPPED
> > at all after this loop as it's just going to be freed.
> >
> >         }
> > -       /*
> > -        * Now all pages of that extent buffer is unmapped, set UNMAPPED flag,
> > -        * so it can be cleaned up without utilizing folio->mapping.
> > -        */
> > -       set_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags);
> > -
> >         btrfs_release_extent_buffer(eb);
> > +
> >         if (ret < 0)
> >                 return ERR_PTR(ret);
> > +
> >         ASSERT(existing_eb);
> >         return existing_eb;
> >  }
> >
> > >         }
> > >  }
> > >
> > > @@ -3365,8 +3370,15 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
> > >          * btree_release_folio will correctly detect that a page belongs to a
> > >          * live buffer and won't free them prematurely.
> > >          */
> > > -       for (int i = 0; i < num_extent_folios(eb); i++)
> > > +       for (int i = 0; i < num_extent_folios(eb); i++) {
> > >                 folio_unlock(eb->folios[i]);
> > > +               /*
> > > +                * A folio that has been added to an address_space mapping
> > > +                * should not continue holding the refcount from its original
> > > +                * allocation indefinitely.
> > > +                */
> > > +               folio_put(eb->folios[i]);
> > > +       }
> > >         return eb;
> > >
> > >  out:
> > > --
> > > 2.49.0
> > >
> > >
> >

