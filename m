Return-Path: <linux-btrfs+bounces-13016-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C13A890CB
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Apr 2025 02:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 024D717D478
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Apr 2025 00:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB9E482F2;
	Tue, 15 Apr 2025 00:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="B5QFpBtJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HOjkJJo8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D306111BF
	for <linux-btrfs@vger.kernel.org>; Tue, 15 Apr 2025 00:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744677621; cv=none; b=VCkIWEFuoPU2SAqd+LnySIxTHxpiWBQLgG4rNeWyDPlQVx8bYNJmvB8BTpTkvlwcxXAUKmmzDnwrcBUJ2GjlCU+QszjOn/3G+D14kFPcgDJT+BZYVkgL7xiKrXgh/HRFW4xVy4M1H486aQrba4d9GseUH++8fHEFmC5cxbW814c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744677621; c=relaxed/simple;
	bh=4MtJa5E7a4nTE8vdHfXCHFrToAwLSS/73UnoTrUUcEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WzqYrq+1NLKWMP4Nm23tFFXPptE4N+qZ8xAz98554yt1aPw0quzVw7asfwvHuONXuM+xCK0u3n4xqqo0IRDhjAxN8S8yoLZbKFIffPSQwXX5sHXjmvqqjQvH9FAaXHpveJ3l/ju1Hne85z/VsL1L/f2PcwuPvrouVaV8F6oRFKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=B5QFpBtJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HOjkJJo8; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 33D3B25402E7;
	Mon, 14 Apr 2025 20:40:15 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 14 Apr 2025 20:40:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1744677615;
	 x=1744764015; bh=2F50zWtAOaYfiwaXA65gRbdSJOww5VjrdPM+iZphzhA=; b=
	B5QFpBtJ3HAsOTzmw1xx1PMk7FUgr+J07CE21VQlgWatCgPg3Cj+2AL/zh4foOIa
	La75fnjRFp9bxXCtI0vo3ZTm0rJNFTOdBvEWj3URhBgSjViJGVZNZ3nAesEyuz5r
	FaX6eDLOmu2E0+iwGNhXdelb4X6z7DWDAVZKB8YRAidI1t5cpSI9pYjDsuB8TJRn
	rVDrOK9UkIbjpRfrBR7COnmMPQWe7rC01ZMcJ17G0qd7ItIRDpOAQwp5PSZ0gmwP
	envIfnKulyCMmbho2KON5+IZzNX5lWVu92oLwkMl92x8zuvqjedGsbnUWK80bqzA
	MK1Avfmo0DHl24H1WptBXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744677615; x=
	1744764015; bh=2F50zWtAOaYfiwaXA65gRbdSJOww5VjrdPM+iZphzhA=; b=H
	OjkJJo8s1PoLuCVjXhEQM+MSM0ZJUe+TuTPXXLG1vP+s0gcOoSNo8QCnZC2bTHF8
	DXMDr1zZ8bGt94fkyb6mGiBfpaTwCCu2cIRf0Tr4qnJMuoulLbNd3Mfx5PXOxCt8
	s4N6m6g+OmjfHoBNrPvfxcbRBCP+GOcoEs7lFJqEN5CxgDkSnvp9JW0T5qX/Zcgq
	hv/mB+NGOysdALbiIYM5+dce+2i919zvokA+oOMphbgjp8TLitiF8kSLvrKCOaOR
	2IxLyWCSg07BA68NSdzSYKOIG5Z7t3Vv/1dwF9n4kvOAQRUt3Pzp4P1aj1NQpmd6
	2xbVIXR1On3Bp1FLZX++w==
X-ME-Sender: <xms:7qr9Zyztnv0KoDGzjTFEhNHTckdPcHV9jr3ApnazVXM12dwgnYKANw>
    <xme:7qr9Z-SfRto5UjCdeLEW27CqTsph46OpZPs1MrCrGFbka4-igdd2pxu3gGE4fPfD-
    DS4Zcg3BxVZDNvIivw>
X-ME-Received: <xmr:7qr9Z0VESXl3UXeDjeVavzQQSpqXH2L_4iWgWaqtVF9U23QcjN0XERgeaqZpVU20y1UbazMs7gO5ZeeB0L5NVL5io2k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvddvtdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioh
    eqnecuggftrfgrthhtvghrnhepudelhfdthfetuddvtefhfedtiedtteehvddtkedvledt
    vdevgedtuedutdeitdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehquhifvghnrhhuohdrsghtrhhfshesghhmgi
    drtghomhdprhgtphhtthhopehjohhsvghfsehtohigihgtphgrnhgurgdrtghomhdprhgt
    phhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepkhgvrhhnvghlqdhtvggrmhesfhgsrdgtohhm
X-ME-Proxy: <xmx:7qr9Z4h7B4JsBOERlthH1a8B4ss6EEgsJD3J3wrnn7e0jIxf6700ag>
    <xmx:7qr9Z0CNzyOMEAMrOCn6W0w2sabupbvWTlew-xNSv-qP-zmb7h-daQ>
    <xmx:7qr9Z5JALfAsqsC-d3iGMbPePsoiiztoDkVg6noSj9v7Yg-gRq-1eg>
    <xmx:7qr9Z7A7fYC5XB-01VLiLNszM7Tc0T0O6mxV6pF4H2-inS1RVhMRtA>
    <xmx:76r9Zy76_e0JwtlHw2FObi1_2s3rZQzq44NvkrtB3MRn-5nc9Aeh0Utt>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Apr 2025 20:40:14 -0400 (EDT)
Date: Mon, 14 Apr 2025 17:40:37 -0700
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH] btrfs: fix race in subpage sync writeback handling
Message-ID: <20250415004037.GC3218113@zen.localdomain>
References: <ff2b56ecb70e4db53de11a019530c768a24f48f1.1744659146.git.josef@toxicpanda.com>
 <e13cf6fa-edd2-454f-8635-da8559b97ccc@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e13cf6fa-edd2-454f-8635-da8559b97ccc@gmx.com>

On Tue, Apr 15, 2025 at 07:15:42AM +0930, Qu Wenruo wrote:
> 
> 
> 在 2025/4/15 05:02, Josef Bacik 写道:
> > While debugging a fs corruption with subpage we noticed a potential race
> > in how we do tagging for writeback.  Boris came up with the following
> > diagram to describe the race potential
> > 
> > EB1                                                       EB2
> > btree_write_cache_pages
> >    tag_pages_for_writeback
> >    filemap_get_folios_tag(TOWRITE)
> >    submit_eb_page
> >      submit_eb_subpage
> >        for eb in folio:
> >          write_one_eb
> >                                                            set_extent_buffer_dirty
> >                                                            btrfs_meta_folio_set_dirty
> >                                                            ...
> >                                                            filemap_fdatawrite_range
> >                                                              btree_write_cache_pages
> >                                                              tag_pages_for_writeback
> >            folio_lock
> >            btrfs_meta_folio_clear_dirty
> >            btrfs_meta_folio_set_writeback // clear TOWRITE
> >            folio_unlock
> >                                                              filemap_get_folios_tag(TOWRITE) //missed
> > 
> > The problem here is that we'll call folio_start_writeback() the first
> > time we initiate writeback on one extent buffer, if we happened to dirty
> > the extent buffer behind the one we were currently writing in the first
> > task, and race in as described above, we would miss the TOWRITE tag as
> > it would have been cleared, and we will never initiate writeback on that
> > EB.
> > 
> > This is kind of complicated for us, the best thing to do here is to
> > simply leave the TOWRITE tag in place, and only clear it if we aren't
> > dirty after we finish processing all the eb's in the folio.
> > 
> > Fixes: c4aec299fa8f ("btrfs: introduce submit_eb_subpage() to submit a subpage metadata page")
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> >   fs/btrfs/extent_io.c | 23 +++++++++++++++++++++++
> >   fs/btrfs/subpage.c   |  2 +-
> >   2 files changed, 24 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> > index 6cfd286b8bbc..5d09a47c1c28 100644
> > --- a/fs/btrfs/extent_io.c
> > +++ b/fs/btrfs/extent_io.c
> > @@ -2063,6 +2063,29 @@ static int submit_eb_subpage(struct folio *folio, struct writeback_control *wbc)
> >   		}
> >   		free_extent_buffer(eb);
> >   	}
> > +	/*
> > +	 * Normally folio_start_writeback() will clear TAG_TOWRITE, but for
> > +	 * subpage we use __folio_start_writeback(folio, true), which keeps it
> > +	 * from clearing TOWRITE.  This is because we walk the bitmap and
> > +	 * process each eb one at a time, and then locking the folio when we
> > +	 * process the eb.  We could have somebody dirty behind us, and then
> > +	 * subsequently mark this range as TOWRITE.  In that case we must not
> > +	 * clear TOWRITE or we will skip writing back the dirty folio.
> > +	 *
> > +	 * So here lock the folio, if it is clean we know we are done with it,
> > +	 * and we can clear TOWRITE.
> > +	 */
> > +	folio_lock(folio);
> > +	if (!folio_test_dirty(folio)) {
> > +		XA_STATE(xas, &folio->mapping->i_pages, folio_index(folio));
> > +		unsigned long flags;
> > +
> > +		xas_lock_irqsave(&xas, flags);
> > +		xas_load(&xas);
> > +		xas_clear_mark(&xas, PAGECACHE_TAG_TOWRITE);
> > +		xas_unlock_irqrestore(&xas, flags);
> > +	}
> > +	folio_unlock(folio);
> >   	return submitted;
> >   }
> > diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
> > index d4f019233493..53140a9dad9d 100644
> > --- a/fs/btrfs/subpage.c
> > +++ b/fs/btrfs/subpage.c
> > @@ -454,7 +454,7 @@ void btrfs_subpage_set_writeback(const struct btrfs_fs_info *fs_info,
> >   	spin_lock_irqsave(&subpage->lock, flags);
> >   	bitmap_set(subpage->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
> >   	if (!folio_test_writeback(folio))
> > -		folio_start_writeback(folio);
> > +		__folio_start_writeback(folio, true);
> 
> This looks a little dangerous to me, as for data writeback we rely on
> folio_start_writeback() to clear the TOWRITE tag before this change.

During an extended test of a branch with both fixes, I did in fact see a
deadlock that looked like an extent_write_cache_pages going re-doing
writeback on a page that should have had the mark cleared. I'm not 100%
sure it is this, since it took 60+ runs of the logwrites crash test to hit
the deadlock during the instrumented workload

Anyway, I will take a look at and test your other proposed fix in
Josef's other email.

Thanks,
Boris

> 
> Can we do a test on the dirty bitmap and only call clear TOWRITE tag when
> there is no dirty blocks?
> 
> (This also means, we must clear the folio dirty before start writeback,
> there are some exceptions that needs to be addressed)
> 
> By that, we do not need the manual tag handling in submit_eb_subpage().
> 
> Thanks,
> Qu
> 
> >   	spin_unlock_irqrestore(&subpage->lock, flags);
> >   }
> 

