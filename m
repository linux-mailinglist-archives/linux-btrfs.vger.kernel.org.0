Return-Path: <linux-btrfs+bounces-11356-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C64D4A2E2F7
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Feb 2025 05:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8C493A5294
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Feb 2025 03:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466A5139CEF;
	Mon, 10 Feb 2025 04:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LotySJfn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87638C2C8;
	Mon, 10 Feb 2025 03:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739159999; cv=none; b=osIe04dUIu9iP2YkyVIjtbDz6N4vsxsQ4m0Ivnf1EW3RQRNum0NZr0cKTQ0OIl6HXQrkPCfcoEEGtfbX/upPq4Hyr1MuWSzZ9R6z/KT0tJ04/ReLlX2PNfvNZFJd2e7HkH55EoEBNHLAz6IymfoeCA8IV7oC+ReQ21e59lHwR0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739159999; c=relaxed/simple;
	bh=0IQnX5rIQ6iJ+Gz+vDwsDFTCNOIWk1rpS/NkS9DZvpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lsyI6cDS50b5zThhYQ8TzOZAjbvvJoRKxFD/PPiKiG962qOwVMQTcthZasT0YHiHsJJjJn9Hx3p8xfRBlRC993sbPImC0J2OtqGY1db82RoLurZK+t/Z/wRp8KZQoG3+yTvQk1ZQVYj3v0xTpGGlkHEimIvBwkvk+I9e1eFdO+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LotySJfn; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=aQcoOI1vF/61BNw9oNJ37RzGQz1jlTBg966oZbAwpX8=; b=LotySJfn2Wt8DD2GopdtZz4W84
	LjaqCxAtn4la25zvAw3+zmPzBChh5aLu7TfrTppQJsnhppMBNXkCZIb5MZVBYIgP0N0MbqSlcHyDL
	XRhqiRHI0FADlW67Tzg4CNhQ/N6LEJZXoKvIKxjlCG+WDhK6t7BIIkQjlWWppFzaktNvwxkrPbjLl
	HdzYbbCwT2sJsydexTqkxzZlUcEXW7exqu36Hz9ZEAGVr6JRGRl2Pit6DdOpEZw2yw0qc2osS0eeF
	DLyB3yMe6ncpGzpPNGtwhb01KSJ9VJ3vcmrwnTm98AHlECIAStqZDtUE6G0TJlSlH00TuNZH3h0xp
	82+i37nw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1thKxf-0000000Edio-0SaD;
	Mon, 10 Feb 2025 03:59:55 +0000
Date: Mon, 10 Feb 2025 03:59:54 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
	linux-btrfs <linux-btrfs@vger.kernel.org>,
	"fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: Btrfs crash on generic/437 on x86_64
Message-ID: <Z6l5uhuhAJ3Vepcq@casper.infradead.org>
References: <152296f3-5c81-4a94-97f3-004108fba7be@gmx.com>
 <Z6ly-MHIztjtS98S@casper.infradead.org>
 <a33deb4e-3f6c-4a5e-9da9-ad403a858aca@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a33deb4e-3f6c-4a5e-9da9-ad403a858aca@gmx.com>

On Mon, Feb 10, 2025 at 02:13:53PM +1030, Qu Wenruo wrote:
> 在 2025/2/10 14:01, Matthew Wilcox 写道:
> > > [   58.305921] BTRFS info (device dm-0): using free-space-tree
> > > [   58.319296] run fstests generic/437 at 2025-02-10 13:24:19
> > > [   59.283069] BUG: Bad rss-counter state mm:0000000048578720
> > > type:MM_FILEPAGES val:1

> > We need to figure out how we came to not unmap the page from the page
> > tables originally.  Looking through the merge log of the mm tree, my
> > suspicion falls on the following patchsets:
> > 
> >         - "synchronously scan and reclaim empty user PTE pages" from Qi Zheng
> >           addresses an issue where "huge" amounts of pte pagetables are
> >           accumulated:

https://lore.kernel.org/linux-mm/2766D04E-5A04-4BF6-A2A3-5683A3054973@nvidia.com/
looks like a similar splat with the problem narrowed down to the reclaim
PTE pages patchset.

