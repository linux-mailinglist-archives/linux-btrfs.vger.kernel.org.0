Return-Path: <linux-btrfs+bounces-11030-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF1FA183D7
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jan 2025 19:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C4583A4AF5
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jan 2025 18:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5231F7080;
	Tue, 21 Jan 2025 18:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RjJvrBfa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E97A1F238E
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Jan 2025 17:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737482399; cv=none; b=KECIrSWTb5dWHh+t5cdIgsFADIJ0g6jhY8mAEoOMh3z48VODs3kmXUf0pf4rqXncOW8sPlPeWONukmm966YNcC8cKq4uPWqBIpMtl0y4//mYDr7nJ7K6QTMuR7EsWffnSaOg7VTvyY/dny8IQGvKgW1jGtrU0hhXB6I6RmTpfXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737482399; c=relaxed/simple;
	bh=48o1JaAAARybYR64Dw7EYPXcGLWSSjtolUtrWvH4OfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J3Nq0Ne234JX8JKlX+EXv43q3dZ8CzOOMrXltj1tfFdQvAYBnFKWW6NZ5rWEqD5hl7Xx8d1Rwah8XwTGBmA2/0KTdCef2Gd4NSCMeN29H70sogzuy+9MXjJUk9OIJr9qK+OFkdt1n6lP41iK+OGYsWMBfvSHMP8Nh2MUeiOKNac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RjJvrBfa; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=mM1DmFMD84o4xHIaRdoZbWoarwE49RJSf9e8ATgb938=; b=RjJvrBfaD3tjtfevEFE4k9Cp61
	/BW/KKcFdbfZjXjRKhnT2qenRU/EoNmFFTo/An+1WszlB7/ofwq10Bjtf9bxkf0Sbh4TP/0ocqGBQ
	gTdENe/XgnOKknLMaGGh/mlM7VU75KCvfiA2G95NFTVeNg2TsfSg0WnfP1eMhb7cJRJclSw/Pc5r8
	CxyqaPLe9Z8XIhvSciIP997rP00ByjaWyQ/feY1aJnd3SoLUI7cN0fSE1/ZUaHJgrYksAd08xaH0u
	6ZwFrKTkqoCraBDDs/S1QpWadzLKXm01VraFma5ugqMjpla99/9EruER1zFUVzAsScaQjm0JTWCGJ
	Cy449liQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1taIXa-00000001u9A-093t;
	Tue, 21 Jan 2025 17:59:54 +0000
Date: Tue, 21 Jan 2025 17:59:53 +0000
From: Matthew Wilcox <willy@infradead.org>
To: David Sterba <dsterba@suse.cz>
Cc: Qu Wenruo <wqu@suse.com>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/3] btrfs: Fix two misuses of folio_shift()
Message-ID: <Z4_gmbY6_sTVAeIL@casper.infradead.org>
References: <20250121054054.4008049-1-willy@infradead.org>
 <20250121054054.4008049-2-willy@infradead.org>
 <33fa9947-cead-4f38-a61a-39b053f37a03@suse.com>
 <20250121161011.GG5777@suse.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250121161011.GG5777@suse.cz>

On Tue, Jan 21, 2025 at 05:10:11PM +0100, David Sterba wrote:
> On Tue, Jan 21, 2025 at 05:51:40PM +1030, Qu Wenruo wrote:
> > 在 2025/1/21 16:10, Matthew Wilcox (Oracle) 写道:
> > > -		/* For now only order 0 folios are supported for data. */
> > > -		ASSERT(folio_order(folio) == 0);
> > 
> > I'd prefer to keep this ASSERT(), as all the btrfs_folio_*() helpers can 
> > only handle page sized folio for now.

I'd rather have the assertions in the places that actually don't work.
And the better assertion is !folio_test_large(folio) as it only has to
test one bit rather than testing a bit and then also testing a field.

> > > -			if (folio_index(folio) == end_index && i_size <= end) {
> > > +			if (folio_contains(folio, i_size >> PAGE_SHIFT) &&
> > 
> > Although folio_contains() is already a pretty good improvement, can we 
> > have a bytenr/i_sized based solution for fs usages?
> 
> Good point, something like folio_contains_offset() that does the correct
> shifts.

I'd call it folio_contains_pos(), but I'm not sure there's a lot of
users.  We've got a lot of filesystems converted now, and btrfs is the
first one to want something like that.  I've had a look through iomap
and some other filesystems, and I can't see anywhere else that would use
folio_contains_pos().

