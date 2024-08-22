Return-Path: <linux-btrfs+bounces-7407-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF3195B4AA
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2024 14:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C6951C231EC
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2024 12:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB7C1C9456;
	Thu, 22 Aug 2024 12:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aTqtZlss"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E941C9452
	for <linux-btrfs@vger.kernel.org>; Thu, 22 Aug 2024 12:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724328480; cv=none; b=DeX/SoVvbEF6BZ2KNQz9/noq4eD69fAZZL83ZLYIgQ7GgkZEpJSqQL+hzJ9ocQt7PNmhFl5MTuIGtqs32BHoQdpZmHE4aOZyV0OflkOOezSevFB6zfoW4SzZXy6stvrbMPJoZkmexnnDTsDa+GcJu77zFe+mEO2ppCywL7KIgJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724328480; c=relaxed/simple;
	bh=K6EsYllLHIUjofzCQiAtoDtWY0oOo8fOj8s1n8zfnU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bz8fZ3tMFUKz3AuuQ6eRklO5AsIbJYeXg2WczLKt5qiGsjLWR/FMjwCO5NM5OdcQnHaHQdVBABvvnW9p9jfJiop323g0o6w0UhhXFwKK2+DegJal5b1buPg08Hm+fQoF0SrT1v66nwL9erlHIq3QDwK6iu7sfpSm+w9ICbEKbWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aTqtZlss; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=DUe/Urm+0reIbIlypNQIYbpK3446z7WDCRLPHoI0Fho=; b=aTqtZlssyfBuJMn3aff6PPocPO
	NvJ5xdI2y5mwu6v+19683egGCFbzjlRdNL0ZStL2JKzjQYb/6XSCyUTOcoNf//nmdmnZkdB9oQcYW
	ToUm4GrKQ8y1izDL2lGeLXKL1BIxqnNkgZ1nb/HJX3YR9B1AND1FLrQSv0H4MG+iFPsKpb6tEZ/W0
	oT+7Q7mVcjNHhjxLDVaPDKLsvyhBm9cbXcO+s2foXctkcqqmocdyuf3ZVB3zqB6BSJEu9SPLafMtx
	M/pDAbukseKE82PDs/+ntjhxTe083gDygPWZhX+ELbIEOqtloOwIbcqDIM7MJFV+yOvjd/g4Tm4sZ
	pEosfeSw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sh6bZ-0000000ATrQ-0l6g;
	Thu, 22 Aug 2024 12:07:53 +0000
Date: Thu, 22 Aug 2024 13:07:52 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Li Zetao <lizetao1@huawei.com>, clm@fb.com, josef@toxicpanda.com,
	dsterba@suse.com, terrelln@fb.com, linux-btrfs@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 02/14] btrfs: convert get_next_extent_buffer() to take a
 folio
Message-ID: <ZscqGAMm1tofHSSG@casper.infradead.org>
References: <20240822013714.3278193-1-lizetao1@huawei.com>
 <20240822013714.3278193-3-lizetao1@huawei.com>
 <Zsaq_QkyQIhGsvTj@casper.infradead.org>
 <0f643b0f-f1c2-48b7-99d5-809b8b7f0aac@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0f643b0f-f1c2-48b7-99d5-809b8b7f0aac@gmx.com>

On Thu, Aug 22, 2024 at 08:28:09PM +0930, Qu Wenruo wrote:
> 在 2024/8/22 12:35, Matthew Wilcox 写道:
> > > -	while (cur < page_start + PAGE_SIZE) {
> > > +	while (cur < folio_start + PAGE_SIZE) {
> > 
> > Presumably we want to support large folios in btrfs at some point?
> 
> Yes, and we're already working towards that direction.
> 
> > I certainly want to remove CONFIG_READ_ONLY_THP_FOR_FS soon and that'll
> > be a bit of a regression for btrfs if it doesn't have large folio
> > support.  So shouldn't we also s/PAGE_SIZE/folio_size(folio)/ ?
> 
> AFAIK we're only going to support larger folios to support larger than
> PAGE_SIZE sector size so far.

Why do you not want the performance gains from using larger folios?

> So every folio is still in a fixed size (sector size, >= PAGE_SIZE).
> 
> Not familiar with transparent huge page, I thought transparent huge page
> is transparent to fs.
> 
> Or do we need some special handling?
> My uneducated guess is, we will get a larger folio passed to readpage
> call back directly?

Why do you choose to remain uneducated?  It's not like I've been keeping
all of this to myself for the past five years.  I've given dozens of
presentations on it, including plenary sessions at LSFMM.  As a filesystem
developer, you must want to not know about it at this point.

> It's straightforward enough to read all contents for a larger folio,
> it's no different to subpage handling.
> 
> But what will happen if some writes happened to that larger folio?
> Do MM layer detects that and split the folios? Or the fs has to go the
> subpage routine (with an extra structure recording all the subpage flags
> bitmap)?

Entirely up to the filesystem.  It would help if btrfs used the same
terminology as the rest of the filesystems instead of inventing its own
"subpage" thing.  As far as I can tell, "subpage" means "fs block size",
but maybe it has a different meaning that I haven't ascertained.

Tracking dirtiness on a per-folio basis does not seem to be good enough.
Various people have workloads that regress in performance if you do
that.  So having some data structure attached to folio->private which
tracks dirtiness on a per-fs-block basis works pretty well.  iomap also
tracks the uptodate bit on a per-fs-block basis, but I'm less convinced
that's necessary.

I have no idea why btrfs thinks it needs to track writeback, ordered,
checked and locked in a bitmap.  Those make no sense to me.  But they
make no sense to me if you're support a 4KiB filesystem on a machine
with a 64KiB PAGE_SIZE, not just in the context of "larger folios".
Writeback is something the VM tells you to do; why do you need to tag
individual blocks for writeback?

