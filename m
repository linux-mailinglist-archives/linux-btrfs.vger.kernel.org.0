Return-Path: <linux-btrfs+bounces-976-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43083814AC8
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Dec 2023 15:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3696285F45
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Dec 2023 14:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1C6358B0;
	Fri, 15 Dec 2023 14:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FNAE/fQG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CA031743
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Dec 2023 14:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sVnXuMWdEM89bw4WQpoL807T+wKJ3yhSTJBIxXK2XOM=; b=FNAE/fQGHxgZf5C0xy0xgbeCaH
	4Q6GUgtav+2wwD/B3lEDlvA6r0KOtaVhzGTFJ5xb3p97CCyFZ9OnpqTohN/xe7l74n+V4UFY4u2gc
	sDnOL8rPS3qNGFu6VayZeC1jk+lXQpYN/XezfOxZq22hvTNHPUrLGnKn/zOjny7FobEzgTYv06FB5
	wVPoMBSzbQBQwUOQF0t1bChDUnJmkAEauOTssBVgQd2cWBf7P0fFmX1g7fBqMBNCPAzJnFwWEyDvt
	llaMYyMzQUTc/2HllHF2ZL5CS9hEsx380jRP3gy1g6VnyA5+Lf6FRKhKKINDRMzdL9X93ZO6+lbig
	xm6Og8FA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rE9LY-000K9C-RM; Fri, 15 Dec 2023 14:39:24 +0000
Date: Fri, 15 Dec 2023 14:39:24 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] btrfs: Use a folio array throughout the defrag
 process
Message-ID: <ZXxlHCDX1YrOKbtg@casper.infradead.org>
References: <20231214161331.2022416-1-willy@infradead.org>
 <20231214161331.2022416-4-willy@infradead.org>
 <47f71d20-efb9-481a-acd5-e0d5b507bbda@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47f71d20-efb9-481a-acd5-e0d5b507bbda@wdc.com>

On Fri, Dec 15, 2023 at 02:31:13PM +0000, Johannes Thumshirn wrote:
> On 14.12.23 17:14, Matthew Wilcox (Oracle) wrote:
> > @@ -1217,21 +1217,21 @@ static int defrag_one_range(struct btrfs_inode *inode, u64 start, u32 len,
> >   	ASSERT(nr_pages <= CLUSTER_SIZE / PAGE_SIZE);
> >   	ASSERT(IS_ALIGNED(start, sectorsize) && IS_ALIGNED(len, sectorsize));
> >   
> > -	pages = kcalloc(nr_pages, sizeof(struct page *), GFP_NOFS);
> > -	if (!pages)
> > +	folios = kcalloc(nr_pages, sizeof(struct folio *), GFP_NOFS);
> > +	if (!folios)
> >   		return -ENOMEM;
> 
> Stupid question, why did you keep nr_pages and not turn it into nr_folios?

Because we're still doing the stupid allocate-one-page-at-a-time thing
instead of allocating larger chunks of memory to do the defrag.  My goal
with this patchset is removing uses of old APIs rather than optimising
btrfs since I don't use btrfs myself.  Particularly the defrag code
would need serious testing.


