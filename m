Return-Path: <linux-btrfs+bounces-769-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E3280AECD
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Dec 2023 22:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52D701C20C7A
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Dec 2023 21:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA8B584DB;
	Fri,  8 Dec 2023 21:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b27eecjV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796FFA9
	for <linux-btrfs@vger.kernel.org>; Fri,  8 Dec 2023 13:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yz6ceR8eN/TsTPRu/2U8w/726s+d9e9TT1jMTgZB91A=; b=b27eecjVzIpxjJpM3FqQGjN0Qc
	9NY9wSUCgWivCAMg4xu1NdGa0wzCeHA1wQhxYlzY8Yo1bP8S/td584TokkFhinq8TDXMunb5PfnJu
	oGs0X4gcy6vN3rweW0KLoKYToLVrcmCKqp8gHNNWVynEOa87kT6JwNgPYnj49TZ04ke3Kr2+jOx//
	ZeSrikaRPcviCG5kNQQcCAB3jbGwXq8HoJ8jPO4vtN9TIQ80wwyFeW+psLHf4y4qZVW3mh9+Ortvp
	zoG7HsKHGX9wwg0Cs/TkYaLYXsK+svdtRdDruTxO6YE2DGmQz54OQgA71ywN8nlK+6A7YABMH/0md
	inoqBzMA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rBiKk-006avR-QS; Fri, 08 Dec 2023 21:24:30 +0000
Date: Fri, 8 Dec 2023 21:24:30 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Qu Wenruo <wqu@suse.com>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs: Use a folio array throughout the defrag
 process
Message-ID: <ZXOJjiP7OoEMKYaT@casper.infradead.org>
References: <20231208192725.1523194-1-willy@infradead.org>
 <20231208192725.1523194-2-willy@infradead.org>
 <226b0c8d-3d6f-46a1-992c-874ed0c667fb@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <226b0c8d-3d6f-46a1-992c-874ed0c667fb@suse.com>

On Sat, Dec 09, 2023 at 07:44:34AM +1030, Qu Wenruo wrote:
> > @@ -875,7 +875,7 @@ static struct page *defrag_prepare_one_page(struct btrfs_inode *inode, pgoff_t i
> >   	folio = __filemap_get_folio(mapping, index,
> >   			FGP_LOCK | FGP_ACCESSED | FGP_CREAT, mask);
> >   	if (IS_ERR(folio))
> > -		return &folio->page;
> 
> What's the proper way to grab the first page of a folio?

It depends why you're doing it.

If you're just doing it temporarily to convert back from folio to page
so you can make progress on the conversion, use &folio->page.  That
is a "bad code smell", but acceptable while you're doing the conversion.
It's a good signal "there is more work here to be done".

> For now, I'm going folio_page() and it's the same wrapper using folio->page,
> but I'm wondering would there be any recommendation for it.

folio_page() is good when you actually need a particular page.  eg you're
going to call kmap().  When we get to finally divorcing folio from page,
folio_page() will still work, and &folio->page won't.

> > @@ -1172,7 +1172,7 @@ static int defrag_one_locked_target(struct btrfs_inode *inode,
> >   	const u64 len = target->len;
> >   	unsigned long last_index = (start + len - 1) >> PAGE_SHIFT;
> >   	unsigned long start_index = start >> PAGE_SHIFT;
> > -	unsigned long first_index = page_index(pages[0]);
> > +	unsigned long first_index = folios[0]->index;
> 
> The same for index, there is a folio_index() wrapper.
> 
> So should we go the wrapper or would the wrapper be gone in the future?

folio_index() has a specific purpose (just like page_index() did, but it
seems like a lot of filesystem people never read the kernel-doc on it).
In short, filesystems never need to call folio_index(), nor page_index().
You can always just use folio->index unless you're in the direct-io path
(and you shouldn't be looking at folio_index() then either!).

> > @@ -1189,8 +1189,8 @@ static int defrag_one_locked_target(struct btrfs_inode *inode,
> >   	/* Update the page status */
> >   	for (i = start_index - first_index; i <= last_index - first_index; i++) {
> > -		ClearPageChecked(pages[i]);
> > -		btrfs_page_clamp_set_dirty(fs_info, pages[i], start, len);
> > +		folio_clear_checked(folios[i]);
> > +		btrfs_page_clamp_set_dirty(fs_info, &folios[i]->page, start, len);
> 
> After my patch "2/3 btrfs: migrate subpage code to folio interfaces",
> btrfs_page_*() helpers accept folio parameter directly, thus this may lead
> to a conflicts.

I built against linux-next 20231207; I thought all your folio changes
had landed there?  If you want to adopt these patches and land them
after yours, I am more than OK with that!


