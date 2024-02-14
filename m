Return-Path: <linux-btrfs+bounces-2397-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E46548554A9
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Feb 2024 22:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 135661C2207A
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Feb 2024 21:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CF813EFF5;
	Wed, 14 Feb 2024 21:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="wUwlJOke";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ky0/eB5+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC65128831
	for <linux-btrfs@vger.kernel.org>; Wed, 14 Feb 2024 21:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707945844; cv=none; b=U1hFEL5R8kC+zl7sf8FMlEhdcHp7Q+tdfSu5LJjUOek6IeySJdCy5gvJvbyCJwK1CkHNCUVpH0y8isdB/qnudtGI0dNehmm2GsQd3d9aKXpTdUnrlJ8rr2U86mVKH5edTYBJJT6oMxqdnZ8yOPSzd0URr9eqw2ks1mxEw/Kb1Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707945844; c=relaxed/simple;
	bh=dspyr6+d28GU65r38m68QWZDOsC5YLvlxhQuFbZVuNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LWbLfHwsq9zh+1ZMmv1rZDhq6xB9+nhXMxlWlC1MOsqtgApkzjLhbUYD4irnEBU9yI+k+JqMbh+eaQLnqNxzyEIGly0JrrZ0Xu369WhwAHVR7oz+h2syu+0ea87GU57B6/yXKSOqFYrGvTjuvoa17i8dCDnDx/8/wsVTYrkeeJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=wUwlJOke; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ky0/eB5+; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 63C0D3200A13;
	Wed, 14 Feb 2024 16:24:01 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 14 Feb 2024 16:24:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1707945840;
	 x=1708032240; bh=eTMhTMTPQ5zkUISlOi2cBPdbENYvPJKZW2EX50gzepU=; b=
	wUwlJOkeeVXtV7W+ZIzlBl5qhc2ksRA+qZHUDGK5dNc6d54aK/R1sHdoPTCMKW9Y
	8CDQPH2FGkGdWk1sln9dS+3/9OpfXOmc889KcAO1U1Z/qv+4DPJ2vYRZEuL6/avn
	3qMauUeHp3qOvmRGGDkIaOS2gjI2wG5R3ihlu/VAISBBtZFHpcuCI8ykIr6oFZZC
	PtzXbW9TpmRY5VhwbgTAR2g+IWrxyKFwLL+mX2E9cR2cqTz06lRa99f9rgxoKR3v
	ask8MG6iQs80RmWIR4CUl/RWtm9tBWoUH58oQSSRuC92IpihvDUpF8/aLW3mxqNZ
	7TFTXLX0XGiZHMVti/b3VA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1707945840; x=
	1708032240; bh=eTMhTMTPQ5zkUISlOi2cBPdbENYvPJKZW2EX50gzepU=; b=K
	y0/eB5+zncXtNydxZt1DgeyzRE9sBO3RNiCPVyhOjCBHbMQALW0If4tSjmbLCHwW
	IRVTVt9+IuNyRWupNd2I6JF/81Tdz3xkPC8jFd8OvB+IUhzUAOtMGXM2tMARBYj3
	nTMJeqxzpEyvhJigmLW/H7HIgwc3xmzBPtCVaisuh5d6sQ77PaC8NxOfhLzSJO9p
	+PrkPQ6mN2tS8sb/g5g5mj+v/0S1Vpfl6PF2uw9l3rgF4jYMk9u91a1+0swNuMmz
	QKC+iqCG/pJ14K6UVNQNfGmTvC0eNEGBWjGQKeA6RsbkGArPscPpPeVw7FkrzyGv
	folNiH7JZ1a+x6gJ+jNOA==
X-ME-Sender: <xms:cC_NZSZ7udEHJmlTlFhIxx7KXs3MkApbG-nV57VAXsMWES35MSi2Vg>
    <xme:cC_NZVavm7MH6wNFuyY4BGTQ4PjfK3afd9ZUpakEuOrQJJ30wm_Aqa0oIE6Y5OYw-
    1NBksW0oH2Hi3_9rdE>
X-ME-Received: <xmr:cC_NZc9DeYeFj490n-I-WPb666mktHOJcYWGp2dvUml6RxMEv8xz6ggJoTgCwtkqSfKgmVLddgD9rhvgLoRkixOYnSU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejgddugeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpeeuohhr
    ihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnh
    epieektedvhfejveehieetuddvvdffkeeileelkeejgfekiefhueekvdfhgffhffeknecu
    ffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:cC_NZUpFRevWXTeVA8CgZf_oyxVsoJ5QdFjNLvQMjneYTqkQkW0CnA>
    <xmx:cC_NZdrAOrEM9tftSP1mhTb53fAIJD6R4Uih-b_AWm3rr9N3fUuYmg>
    <xmx:cC_NZSSVJpU1-U7V8FyPWUAtuciovjrQpg-YcxlzZ95HcR8Z4PJ2dg>
    <xmx:cC_NZU1Pp1gdQvsm0lzBCX9O4we4OqEhcRvV07hmxzfznQRNEwEEdw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Feb 2024 16:24:00 -0500 (EST)
Date: Wed, 14 Feb 2024 13:25:37 -0800
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 0/3] btrfs: make subpage reader/writer counter to be
 sector aware
Message-ID: <20240214212537.GA481589@zen.localdomain>
References: <cover.1707883446.git.wqu@suse.com>
 <20240214182117.GA377066@zen.localdomain>
 <28cd604c-230f-4f80-be5c-f835372d80d0@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <28cd604c-230f-4f80-be5c-f835372d80d0@gmx.com>

On Thu, Feb 15, 2024 at 07:39:15AM +1030, Qu Wenruo wrote:
> 
> 
> 在 2024/2/15 04:51, Boris Burkov 写道:
> > On Wed, Feb 14, 2024 at 02:34:33PM +1030, Qu Wenruo wrote:
> > > This can be fetched from github, and the branch would be utilized for
> > > all newer subpage delalloc update to support full sector sized
> > > compression and zoned:
> > > https://github.com/adam900710/linux/tree/subpage_delalloc
> > > 
> > > Currently we just trace subpage reader/writer counter using an atomic.
> > > 
> > > It's fine for the current subpage usage, but for the future, we want to
> > > be aware of which subpage sector is locked inside a page, for proper
> > > compression (we only support full page compression for now) and zoned support.
> > 
> > The logic of the patches seems good and self-consistent to me, I don't
> > see any issues.
> > 
> > However, I think it would be helpful to at least see the client code to
> > motivate the bitmap a bit more for the ignorant :)
> 
> Sure, if needed I can include them into the incoming subpage delalloc
> patchset.
> 
> > 
> > Also, from a semi-cursory inspection, it looks like this relies on
> > extent locking to ensure that multiple threads don't collide on the
> > subpage bitmap, is that correct?
> 
> The current plan is to make find_lock_delalloc_range() to always lock
> all the ranges inside the page, at least beyond the end of the page.
> 
> The main work flow would look like this:
> 
> find_lock_delalloc_range()
> {
> 	int cur = page_offset(page);
> 
> 	/*
> 	 * Subpage, already locked, just grab the next locked range
> 	 * using the locked bitmap.
> 	 */
> 	if (btrfs_is_subpage() && write_count > 0)
> 		return grab_the_next_locked_range();
> 
> 	while (cur < page_end(page)) {
> 		/*
> 		 * The old find and lock code, including
> 		 * the extent locking
> 		 */
> 		cur = locked_range_end();
> 	}
> 	*start = the_first_locked_range_start;
> 	*end = the_first_locked_range_end;
> }
> 
> So for non-subpage cases, it's the same.
> For subpage cases, the page would be kept locked until all its subpage
> sectors are written.
> (But would need extra cleanup if we hit some error during subpage sector
> write)
> 
> And the above workflow is still being coded, not yet tested to see if
> there is anything fundamentally wrong, thus it may change.
> 
> > You should check with Josef that his
> > plans with getting rid of the extent locking don't clash with this.
> 
> It would still conflict, but the extent locking part would be the same
> as usual, so I believe the conflict can be easily resolved.
> 
> And I'm pretty happy to help solving the conflicts if needed.

By conflict, I meant logically/conceptually, not in terms of git merge
conflicts.

Right now, AFAICT, your code relies on the fact that the extent is
locked to ensure that two reads don't trip on the bitmap. If Josef takes
that out, does the assumption still hold? Page lock gets taken after
modifying the bitmap, right?

Sorry if I am misunderstanding you.

> 
> Thanks,
> Qu
> 
> > 
> > Thanks,
> > Boris
> > 
> > > 
> > > So here we introduce a new bitmap, called locked bitmap, to trace which
> > > sector is locked for read/write.
> > > 
> > > And since reader/writer are both exclusive (to each other and to the same
> > > type of lock), we can safely use the same bitmap for both reader and
> > > writer.
> > > 
> > > In theory we can use the bitmap (the weight of the locked bitmap) to
> > > indicate how many bytes are under reader/write lock, but it's not
> > > possible yet:
> > > 
> > > - No weight support for bitmap range
> > >    The bitmap API only provides bitmap_weight(), which always starts at
> > >    bit 0.
> > > 
> > > - Need to distinguish read/write lock
> > > 
> > > Thus we still keep the reader/writer atomic counter.
> > > 
> > > Qu Wenruo (3):
> > >    btrfs: unexport btrfs_subpage_start_writer() and
> > >      btrfs_subpage_end_and_test_writer()
> > >    btrfs: subpage: make reader lock to utilize bitmap
> > >    btrfs: subpage: make writer lock to utilize bitmap
> > > 
> > >   fs/btrfs/subpage.c | 70 ++++++++++++++++++++++++++++++++++++----------
> > >   fs/btrfs/subpage.h | 16 +++++++----
> > >   2 files changed, 66 insertions(+), 20 deletions(-)
> > > 
> > > --
> > > 2.43.1
> > > 
> > 

