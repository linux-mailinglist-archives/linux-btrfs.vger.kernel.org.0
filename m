Return-Path: <linux-btrfs+bounces-12695-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3EBA76B9D
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Mar 2025 18:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0791A1669CB
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Mar 2025 16:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FF2214216;
	Mon, 31 Mar 2025 16:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="p2wV6V4l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Nr40HmVr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050C21DF75A
	for <linux-btrfs@vger.kernel.org>; Mon, 31 Mar 2025 16:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743437350; cv=none; b=giRhftpxId/G4Reeotacop8chDldLRqybONEc9EHVJzvEWHhoHNsl8JkNtyNTBCuZ8fXWNtSyujXoArGS+CGB89fGbQihzZKNQPrDDRutxNh2w0ANaPoQ1Q/wJm9o1GxJ6eFMMRSA4xX4DtmHvDqZH2/xLwYP4ZGRuteOyfJONs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743437350; c=relaxed/simple;
	bh=o8denoa4GraVyAzL7BPuiZjJpvQbpHDmZorNXdtRk7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a9aJ8lfZkda/V65yET4yKFX7cADTLgO5Byoqnk3q5vbXlJnWVdH2RytO3dqvYvfieu7QFCdpwWZh0qzNkjhcQbSAIXWOqoqMfHVMAjgohJGLk7coc9u0YyOeER1L9fYj41h/3t2BMEvHlwYeIiRr9HyRlXO5EP5BDTQLwN9VRKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=p2wV6V4l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Nr40HmVr; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id DF79711400C6;
	Mon, 31 Mar 2025 12:09:06 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 31 Mar 2025 12:09:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1743437346;
	 x=1743523746; bh=H4Ei9i7hjeDN7R+O8h4t2rcitDeakJd9c/Ap/I5ejYo=; b=
	p2wV6V4lmMKneUd/u0ujCi6wkZSF7TlnaEc7kozJfyCUst+s/3xSyh7zIMyUEjsr
	B7jo/j3D34GCeEhF2C15uAITV6zLNJfk3x0PfTD79EtDCt0jrenWPfLRbZc0uUud
	ItO0eZF5MT2T7J+iWwhhtP9KferBJUiBWrmn8Qy6KgkNH3SxHYYOTx9DUDhSc6qX
	Q9LQvsFHBg/S4cGLLuTrlhMfrWW4UewFo14kUYJF4xhc7uSyrFefcyBnOYR00oSp
	HgSBMMsdlAiTHPhcI7ZkQFT5VihZ8hg85sHPfxehl8grZmqtB1EEnhVjLNALioti
	tlD3BzLaVzcptTJdaR6t5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743437346; x=
	1743523746; bh=H4Ei9i7hjeDN7R+O8h4t2rcitDeakJd9c/Ap/I5ejYo=; b=N
	r40HmVrtX50UIJKZVHcSRFF2uu6obC4OdN313bz7rj4Diqext0aLzTW9RWjzRnYc
	qNJr9/E7jGpVn3h00RmQZIZgD0+YwFnNIcTqt9RmLIPMQ7gZDDeg6Oha2pz/tN7Y
	lf8AmSDdFwA/I5TqHSGVZE90OBISt1MKqcggpnzM8eRSRKTEGj3Tp84SW9cWIkZ7
	xh/BEfQyxjUzdoYvt4BN/eDuUiyPumpTwWuZ1G2kJSRLgvQgMhz+eWai/9yDkeMp
	hyz3KRdLnJqSp/peh+hdrCerwT9D7ZO/H8lEARMWIIqhYgQowVqxIthuR5ojXCt2
	HTkl+Buch9fXVSMgLnm5g==
X-ME-Sender: <xms:Ir7qZ_W3pJ5zjOZ7KmegYmDz20pLcCUW1txtKsVLSVwggSX-Mw348A>
    <xme:Ir7qZ3mNOt1uZ5WL68kFJNBbQedMl2SblB2E5YVAL1G6jI3UYUR7JwTc5bh9GRLNK
    7ygES7KZvaLKN30nio>
X-ME-Received: <xmr:Ir7qZ7ZK9R1QJUHW1oo7utXpJ6HdPHr5vhh-T601eDzpD8zQozEREZ79amJtpcVYQNZLhVfxVFSHsvh7XiRQhWbqdRk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukedtfeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioh
    eqnecuggftrfgrthhtvghrnheptdehudeuvdekvddvieektdegieehvdekffeivdevheeg
    ieevuefhudekvdduheejnecuffhomhgrihhnpehgihhthhhusgdrtghomhdprhhunhdrsh
    hhpdhkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspghrtghpthhtohepfedpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepfhgumhgrnhgrnhgrsehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepkhgvrhhnvghlqdhtvggrmhesfhgsrdgtohhm
X-ME-Proxy: <xmx:Ir7qZ6W_OxtyzI48FDv-7mLhlel2tNrgex9h_9bt_pdwbZv7rMNLZA>
    <xmx:Ir7qZ5mb_kQZ8ERFY0Dd5Q5X6DBeXlM9uUWyCwPR9V0B5RRFoEXyHQ>
    <xmx:Ir7qZ3dSJsAXGsJxH827I3u3e1whxV804-dn40kbEcyrhLCnYTetrQ>
    <xmx:Ir7qZzGYueinHywMHuETeYkInDBqmcqNii4GXxmyunkUYNQS5N-dMA>
    <xmx:Ir7qZ_jvA0y-aZ-oCSL9ltwrQpz6gbXhSx1OaAk3uW5RHvfTkQCPHLdV>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Mar 2025 12:09:06 -0400 (EDT)
Date: Mon, 31 Mar 2025 09:09:52 -0700
From: Boris Burkov <boris@bur.io>
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: fix broken drop_caches on extent_buffer folios
Message-ID: <20250331160952.GA2625072@zen.localdomain>
References: <1c50d284270034703a5c99a42799ff77de871934.1742255123.git.boris@bur.io>
 <CAL3q7H7TjsBzTrCrJ5ibOsBj1LyuJB7ZHUnKXyjr31pqm4bzXw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H7TjsBzTrCrJ5ibOsBj1LyuJB7ZHUnKXyjr31pqm4bzXw@mail.gmail.com>

On Mon, Mar 31, 2025 at 12:33:38PM +0000, Filipe Manana wrote:
> On Mon, Mar 17, 2025 at 11:47 PM Boris Burkov <boris@bur.io> wrote:
> >
> > The (correct) commit
> > e41c81d0d30e ("mm/truncate: Replace page_mapped() call in invalidate_inode_page()")
> > replaced the page_mapped(page) check with a refcount check. However,
> > this refcount check does not work as expected with drop_caches for
> > btrfs's metadata pages.
> >
> > Btrfs has a per-sb metadata inode with cached pages, and when not in
> > active use by btrfs, they have a refcount of 3. One from the initial
> > call to alloc_pages, one (nr_pages == 1) from filemap_add_folio, and one
> > from folio_attach_private. We would expect such pages to get dropped by
> > drop_caches. However, drop_caches calls into mapping_evict_folio via
> > mapping_try_invalidate which gets a reference on the folio with
> > find_lock_entries(). As a result, these pages have a refcount of 4, and
> > fail this check.
> >
> > For what it's worth, such pages do get reclaimed under memory pressure,
> > so I would say that while this behavior is surprising, it is not really
> > dangerously broken.
> >
> > The following script produces such pages and uses drgn to further
> > analyze the state of the folios at various stages in the lifecycle
> > including drop_caches and memory pressure.
> > https://github.com/boryas/scripts/blob/main/sh/strand-meta/run.sh
> 
> Not sure if it's a good thing to add URLs not as permanent as lore and
> kernel.org...
> I would place the script in the change log itself.
> 

Good call, will do so in the future!
I guess kernel.org needs a pastebin too ;)

> >
> > When I asked the mm folks about the expected refcount in this case, I
> > was told that the correct thing to do is to donate the refcount from the
> > original allocation to the page cache after inserting it.
> > https://lore.kernel.org/linux-mm/ZrwhTXKzgDnCK76Z@casper.infradead.org/
> >
> > Therefore, attempt to fix this by adding a put_folio() to the critical
> > spot in alloc_extent_buffer where we are sure that we have really
> > allocated and attached new pages.
> >
> > Since detach_extent_buffer_folio() has relatively complex logic w.r.t.
> > early exits and whether or not it actually calls folio_detach_private(),
> > the easiest way to ensure we don't incur a UAF in that function is to
> > wrap it in a buffer refcount so that the private reference cannot be the
> > last one.
> >
> > Signed-off-by: Boris Burkov <boris@bur.io>
> > ---
> >  fs/btrfs/extent_io.c | 17 ++++++++++++++---
> >  1 file changed, 14 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> > index 7abe6ca5b38ff..207fa2d0de472 100644
> > --- a/fs/btrfs/extent_io.c
> > +++ b/fs/btrfs/extent_io.c
> > @@ -2823,9 +2823,13 @@ static void btrfs_release_extent_buffer_folios(const struct extent_buffer *eb)
> >                 if (!folio)
> >                         continue;
> >
> > +               /*
> > +                * Avoid accidentally putting the last refcount during
> > +                * detach_extent_buffer_folio() with an extra
> > +                * folio_get()/folio_put() pair as a buffer.
> > +                */
> > +               folio_get(folio);
> >                 detach_extent_buffer_folio(eb, folio);
> > -
> > -               /* One for when we allocated the folio. */
> >                 folio_put(folio);
> 
> Instead of adding this defensive get/put pair, we could simply change
> detach_extent_buffer_folio():
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 19f21540475d..7183ae731288 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2768,6 +2768,7 @@ static bool folio_range_has_eb(struct folio *folio)
>  static void detach_extent_buffer_folio(const struct extent_buffer
> *eb, struct folio *folio)
>  {
>         struct btrfs_fs_info *fs_info = eb->fs_info;
> +       struct address_space *mapping = folio->mapping;
>         const bool mapped = !test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags);
> 
>         /*
> @@ -2775,11 +2776,11 @@ static void detach_extent_buffer_folio(const
> struct extent_buffer *eb, struct fo
>          * be done under the i_private_lock.
>          */
>         if (mapped)
> -               spin_lock(&folio->mapping->i_private_lock);
> +               spin_lock(&mapping->i_private_lock);
> 
>         if (!folio_test_private(folio)) {
>                 if (mapped)
> -                       spin_unlock(&folio->mapping->i_private_lock);
> +                       spin_unlock(&mapping->i_private_lock);
>                 return;
>         }
> 
> @@ -2799,7 +2800,7 @@ static void detach_extent_buffer_folio(const
> struct extent_buffer *eb, struct fo
>                         folio_detach_private(folio);
>                 }
>                 if (mapped)
> -                       spin_unlock(&folio->mapping->i_private_lock);
> +                       spin_unlock(&mapping->i_private_lock);
>                 return;
>         }
> 
> @@ -2822,7 +2823,7 @@ static void detach_extent_buffer_folio(const
> struct extent_buffer *eb, struct fo
>         if (!folio_range_has_eb(folio))
>                 btrfs_detach_subpage(fs_info, folio, BTRFS_SUBPAGE_METADATA);
> 
> -       spin_unlock(&folio->mapping->i_private_lock);
> +       spin_unlock(&mapping->i_private_lock);
>  }
> 
>  /* Release all folios attached to the extent buffer */
> 
> It even makes the detach_extent_buffer_folio() code less verbose.
> 
> Either way:
> 
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> 
> Thanks.
> 
> >         }
> >  }

That's a neat way of fixing it. I still think that having a folio
pointer passed into the function that could be dead halfway through
the function feels dangerous.

If we can prove that the private is always the last reference, then we
can comment that the variable is dead after any path with a folio_put.

Because we call this from paths where we are removing the extent_buffer,
maybe we can actually be pretty sure the folio refcount is always going
to 0?

> > @@ -3370,8 +3374,15 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
> >          * btree_release_folio will correctly detect that a page belongs to a
> >          * live buffer and won't free them prematurely.
> >          */
> > -       for (int i = 0; i < num_extent_folios(eb); i++)
> > +       for (int i = 0; i < num_extent_folios(eb); i++) {
> >                 folio_unlock(eb->folios[i]);
> > +               /*
> > +                * A folio that has been added to an address_space mapping
> > +                * should not continue holding the refcount from its original
> > +                * allocation indefinitely.
> > +                */
> > +               folio_put(eb->folios[i]);
> > +       }
> >         return eb;
> >
> >  out:
> > --
> > 2.47.1
> >
> >

