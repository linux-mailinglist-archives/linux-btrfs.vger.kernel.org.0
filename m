Return-Path: <linux-btrfs+bounces-10877-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C156A07F77
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 19:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0DB93A10CE
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 18:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C641946A2;
	Thu,  9 Jan 2025 18:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="oZCjvyzo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WsoDe/JO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AB018787A;
	Thu,  9 Jan 2025 18:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736445957; cv=none; b=XO7UESCItRQikYwmOlPrRosWCu0jDJiyQBp91z+LLVWoORrvoGX9O7GULTM6uYMfBmEZiq7lj/RootXnQaPfOt3e2K/9vfTFHRish2Nm5kSoRLKC9uBvpixN8j+7pJQH5icSxy8jqJXzQBt3V5u7XH+iaMFcxV3ycnUz3KPLucg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736445957; c=relaxed/simple;
	bh=ByhjISKepdce2A/sy1lzmh/brAH0DC4UESOCwje0Zoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZR3jxoFkEVGyAYlq7nC7+bDRVH/t1OXFEXxziby3DbJefOyc/18gdc02LsaTbCrCN4e55BHmKIA2hfG5Qp5rfXeQk++wKrlz6miWPb237OEXUMHNHy1zStOtK26s3kQHFy5UqqjvXpnGj/Bo/iw6qDuOajsmrDTuNgU/sjBTRtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=oZCjvyzo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WsoDe/JO; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C124B254012C;
	Thu,  9 Jan 2025 13:05:53 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 09 Jan 2025 13:05:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1736445953;
	 x=1736532353; bh=Ad0gQtnGTFWpHuVDZchoARKLTa0nVhdE9DU4+Nw0jLI=; b=
	oZCjvyzoCgDYlGZ7cl3ymXX34Ljw8I8JVvQgGR+2bHzdtCEFxIXZfnJWlKW9KpZO
	/SUjWdhM/x3t0YuS0TEuMEyuGzJxaI0REG33SXUPgzcGeqKTLcVm0eFwRsfLy7JS
	cIC1ztOQyfjNWyf/ng/4PXsbNoCx2KzTCzD1uC7AJcwZq/X0cK3kL69tJjrQ4DOU
	BCQWneE58m6D3RddpUeV3jYVFYYUgWJEbfo+TF91SjvCJvEkAobmt216kt+K7HG6
	muMhMr/184FcMvyO0Knkkf14iWbeX+fkU4dREPFvVM1RzR/LeB50AV+pOnkWaPdh
	fQ8vDwqlVMSeLGMn4ePYZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736445953; x=
	1736532353; bh=Ad0gQtnGTFWpHuVDZchoARKLTa0nVhdE9DU4+Nw0jLI=; b=W
	soDe/JO2DE26/B00qxZAx4vPiRpu0WOo8Bt+WUa5yCR+Ju4tMHqtOJQfGka1sWT1
	/GpsOKlQBZvTQ7XRRuMthQvnMAFPpLoHUVww1h3VW9TRyDn02hLgoj+1qy+RCmXy
	uS//+D0TaAhS6mji3w/n7xuapx2gUA9xEV17rC4w7M3H1XUzx1n3Lct13RlGpwso
	V2Qq6nSb+LkkHcSTCxKm+idNFzZZFmfr98X8c+LvCkAMVKGhP5PMEuyN+kmUdOPJ
	03ue7cjyWX4W8Ah6jsmK/N7FcuW3H/EcFtwHDbsT4oZjdiStAJ4uOWKbBS55rTCz
	FWKoT0ibGQ3MSRVw//0Aw==
X-ME-Sender: <xms:ARCAZx30bDZAYwIGJbEB6-8BIGYtEAv-ozGPd4Fp5K0SLOxUNsVjkw>
    <xme:ARCAZ4EaaIii18z9ZrIt4TZsDu2sGwlDs97WrN38pSdiKXMudxGwawYYlYAFxEHN0
    C_eYDIzOGkmF449hws>
X-ME-Received: <xmr:ARCAZx6Hb-AkiYj6CBhkOKs_A3Hq81HxdBSNvyXmKu7NQX-QFvniFqJdQevxXjKoS_JL1sBHrn_wSmUTrPTro4L6LJ4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegiedguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    jeenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihhoqe
    enucggtffrrghtthgvrhhnpedulefhtdfhteduvdethfeftdeitdethedvtdekvdeltddv
    veegtdeuuddtiedtieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepqhhufigvnhhruhhordgsthhrfhhssehgmhigrd
    gtohhmpdhrtghpthhtohepfihquhesshhushgvrdgtohhmpdhrtghpthhtoheplhhinhhu
    gidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthgrsg
    hlvgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ARCAZ-3nbJuqkSjHvSF7iJJ2cy00fQ__Cxh-ewglqv3W959xAn6LVw>
    <xmx:ARCAZ0FyfZbrTBUpvijFvJonfwyc9LMpJMXuPDVfjZd0xXCVLQIGcg>
    <xmx:ARCAZ_-n4vpWvpfrtbl9Fy1dZQtfboTISsiPMjimAhdUWzVNaX3aSA>
    <xmx:ARCAZxkzIumdD-rYBt92hHO7vNmn88rlp-ATkvSMleqSSRuS2524-Q>
    <xmx:ARCAZwiss4kM1JFtW64rIkOZa-R2SdjkXjgvAkiLGi7kuJZVMV6vHxo8>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jan 2025 13:05:52 -0500 (EST)
Date: Thu, 9 Jan 2025 10:06:24 -0800
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 2/9] btrfs: fix double accounting race when
 extent_writepage_io() failed
Message-ID: <20250109180624.GA1932498@zen.localdomain>
References: <cover.1733983488.git.wqu@suse.com>
 <51e0c5f464256c4a59a872077d560cb56b7509a2.1733983488.git.wqu@suse.com>
 <20250108222458.GB1456944@zen.localdomain>
 <deea65a5-8870-4c33-9446-7d531b4b8451@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <deea65a5-8870-4c33-9446-7d531b4b8451@gmx.com>

On Thu, Jan 09, 2025 at 02:15:06PM +1030, Qu Wenruo wrote:
> 
> 
> 在 2025/1/9 08:54, Boris Burkov 写道:
> > On Thu, Dec 12, 2024 at 04:43:56PM +1030, Qu Wenruo wrote:
> > > [BUG]
> > > If submit_one_sector() failed inside extent_writepage_io() for sector
> > > size < page size cases (e.g. 4K sector size and 64K page size), then
> > > we can hit double ordered extent accounting error.
> > > 
> > > This should be very rare, as submit_one_sector() only fails when we
> > > failed to grab the extent map, and such extent map should exist inside
> > > the memory and have been pinned.
> > > 
> > > [CAUSE]
> > > For example we have the following folio layout:
> > > 
> > >      0  4K          32K    48K   60K 64K
> > >      |//|           |//////|     |///|
> > > 
> > > Where |///| is the dirty range we need to writeback. The 3 different
> > > dirty ranges are submitted for regular COW.
> > > 
> > > Now we hit the following sequence:
> > > 
> > > - submit_one_sector() returned 0 for [0, 4K)
> > > 
> > > - submit_one_sector() returned 0 for [32K, 48K)
> > > 
> > > - submit_one_sector() returned error for [60K, 64K)
> > > 
> > > - btrfs_mark_ordered_io_finished() called for the whole folio
> > >    This will mark the following ranges as finished:
> > >    * [0, 4K)
> > >    * [32K, 48K)
> > >      Both ranges have their IO already submitted, this cleanup will
> > >      lead to double accounting.
> > > 
> > >    * [60K, 64K)
> > >      That's the correct cleanup.
> > > 
> > > The only good news is, this error is only theoretical, as the target
> > > extent map is always pinned, thus we should directly grab it from
> > > memory, other than reading it from the disk.
> > > 
> > > [FIX]
> > > Instead of calling btrfs_mark_ordered_io_finished() for the whole folio
> > > range, which can touch ranges we should not touch, instead
> > > move the error handling inside extent_writepage_io().
> > > 
> > > So that we can cleanup exact sectors that are ought to be submitted but
> > > failed.
> > > 
> > > This provide much more accurate cleanup, avoiding the double accounting.
> > 
> > Analysis and fix both make sense to me. However, this one feels a lot
> > more fragile than the other one.
> > 
> > It relies on submit_one_sector being the only error path in
> > extent_writepage_io. Any future error in the loop would have to create a
> > shared "per sector" error handling goto in the loop I guess?
> > 
> > Not a hard "no", in the sense that I think the code is correct for now
> > (aside from my submit_one_bio question) but curious if we can give this
> > some more principled structure.
> > 
> > Thanks,
> > Boris
> > 
> > > 
> > > Cc: stable@vger.kernel.org # 5.15+
> > > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > > ---
> > >   fs/btrfs/extent_io.c | 32 +++++++++++++++++++-------------
> > >   1 file changed, 19 insertions(+), 13 deletions(-)
> > > 
> > > diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> > > index 417c710c55ca..b6a4f1765b4c 100644
> > > --- a/fs/btrfs/extent_io.c
> > > +++ b/fs/btrfs/extent_io.c
> > > @@ -1418,6 +1418,7 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
> > >   	struct btrfs_fs_info *fs_info = inode->root->fs_info;
> > >   	unsigned long range_bitmap = 0;
> > >   	bool submitted_io = false;
> > > +	bool error = false;
> > >   	const u64 folio_start = folio_pos(folio);
> > >   	u64 cur;
> > >   	int bit;
> > > @@ -1460,11 +1461,21 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
> > >   			break;
> > >   		}
> > >   		ret = submit_one_sector(inode, folio, cur, bio_ctrl, i_size);
> > > -		if (ret < 0)
> > > -			goto out;
> > > +		if (unlikely(ret < 0)) {
> > > +			submit_one_bio(bio_ctrl);
> > 
> > This submit_one_bio is confusing to me. submit_one_sector failed and the
> > subsequent comment says "there is no bio submitted" yet right here we
> > call submit_one_bio.
> > 
> > What is the meaning of it?
> > 
> > > +			/*
> > > +			 * Failed to grab the extent map which should be very rare.
> > > +			 * Since there is no bio submitted to finish the ordered
> > > +			 * extent, we have to manually finish this sector.
> > > +			 */
> > > +			btrfs_mark_ordered_io_finished(inode, folio, cur,
> > > +					fs_info->sectorsize, false);
> > > +			error = true;
> > > +			continue;
> > > +		}
> > >   		submitted_io = true;
> > >   	}
> > > -out:
> > > +
> > >   	/*
> > >   	 * If we didn't submitted any sector (>= i_size), folio dirty get
> > >   	 * cleared but PAGECACHE_TAG_DIRTY is not cleared (only cleared
> > > @@ -1472,8 +1483,11 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
> > >   	 *
> > >   	 * Here we set writeback and clear for the range. If the full folio
> > >   	 * is no longer dirty then we clear the PAGECACHE_TAG_DIRTY tag.
> > > +	 *
> > > +	 * If we hit any error, the corresponding sector will still be dirty
> > > +	 * thus no need to clear PAGECACHE_TAG_DIRTY.
> > >   	 */
> > 
> > submitted_io is only used for this bit of logic, so you could consider
> > changing this logic by keeping a single variable for whether or not we
> > should go into this logic (naming it seems kind of annoying) and then
> > setting it in both the error and submitted_io paths. I think that
> > reduces headache in thinking about boolean logic, slightly.
> 
> Unfortunately I can not find a good alternative to this double boolean
> usages.
> 
> I can go a single boolean, but it will be called something like
> @no_error_nor_submission.
> 
> Which is the not only the worst naming, but also a hell of boolean
> operations for a single bool.

I think you could do something like:

needs_reset_writeback = false;
then set it to true in either case, whether you submit an io or hit an
error.

It's your call, though, I won't be upset if you leave it as is.

> 
> So I'm afraid the @error and @submitted_io will still be better for this
> case.
> 
> The other comments will be addressed properly.
> 
> Thanks,
> Qu
> > 
> > > -	if (!submitted_io) {
> > > +	if (!submitted_io && !error) {
> > >   		btrfs_folio_set_writeback(fs_info, folio, start, len);
> > >   		btrfs_folio_clear_writeback(fs_info, folio, start, len);
> > >   	}
> > > @@ -1493,7 +1507,6 @@ static int extent_writepage(struct folio *folio, struct btrfs_bio_ctrl *bio_ctrl
> > >   {
> > >   	struct inode *inode = folio->mapping->host;
> > >   	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
> > > -	const u64 page_start = folio_pos(folio);
> > >   	int ret;
> > >   	size_t pg_offset;
> > >   	loff_t i_size = i_size_read(inode);
> > > @@ -1536,10 +1549,6 @@ static int extent_writepage(struct folio *folio, struct btrfs_bio_ctrl *bio_ctrl
> > > 
> > >   	bio_ctrl->wbc->nr_to_write--;
> > > 
> > > -	if (ret)
> > > -		btrfs_mark_ordered_io_finished(BTRFS_I(inode), folio,
> > > -					       page_start, PAGE_SIZE, !ret);
> > > -
> > >   done:
> > >   	if (ret < 0)
> > >   		mapping_set_error(folio->mapping, ret);
> > > @@ -2319,11 +2328,8 @@ void extent_write_locked_range(struct inode *inode, const struct folio *locked_f
> > >   		if (ret == 1)
> > >   			goto next_page;
> > > 
> > > -		if (ret) {
> > > -			btrfs_mark_ordered_io_finished(BTRFS_I(inode), folio,
> > > -						       cur, cur_len, !ret);
> > > +		if (ret)
> > >   			mapping_set_error(mapping, ret);
> > > -		}
> > >   		btrfs_folio_end_lock(fs_info, folio, cur, cur_len);
> > >   		if (ret < 0)
> > >   			found_error = true;
> > > --
> > > 2.47.1
> > > 
> > 
> 

