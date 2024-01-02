Return-Path: <linux-btrfs+bounces-1197-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4228B8224A3
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jan 2024 23:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C626A1F2372C
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jan 2024 22:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90B5171A6;
	Tue,  2 Jan 2024 22:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CTR97ZDO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84675168DE;
	Tue,  2 Jan 2024 22:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rzOr3Wv34tyIp90a/09FmAC/QNGqYZhSiB74+R3UGGA=; b=CTR97ZDOfcPf4k2rEA5KgzXFdR
	q5ynUbuLQMUgRDDEk9BlD0T92pCkUYYOZi+CMeuPoCTPhflP4he1hNv/EgVSYLvmUtXmAGIwKP4lR
	1tcPUWY0L44X8QYU1npNyy6OVpMtbUO7jgLVMjkLMg9uPRPVdXfSTHZg7SzIHahdkS+cwspOHsA4g
	971F3W4dT3DVQRIvezPJQqZFzTKEPJSj0PzUO2VxSzkuxZj+Hs+XB+CUQycu/T0wh5L4OR7WezkXS
	vzsOQQy8L+oysjTSQ+eCjlE7UoCUE47VhhyqM5aY5cQ+11BBSxtlErmK8KKqBL5p283pEsqkq8up8
	10gt4Tog==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rKn5S-00BK6Y-Ba; Tue, 02 Jan 2024 22:18:14 +0000
Date: Tue, 2 Jan 2024 22:18:14 +0000
From: Matthew Wilcox <willy@infradead.org>
To: David Sterba <dsterba@suse.cz>
Cc: kernel test robot <oliver.sang@intel.com>, Qu Wenruo <wqu@suse.com>,
	oe-lkp@lists.linux.dev, lkp@intel.com,
	Linux Memory Management List <linux-mm@kvack.org>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com
Subject: Re: [linux-next:master] [btrfs]  8d99361835:
 stress-ng.link.ops_per_sec -18.0% regression
Message-ID: <ZZSLpjttJec+t1CQ@casper.infradead.org>
References: <202312221750.571925bd-oliver.sang@intel.com>
 <20240102162620.GA15380@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240102162620.GA15380@twin.jikos.cz>

On Tue, Jan 02, 2024 at 05:26:20PM +0100, David Sterba wrote:
> On Fri, Dec 22, 2023 at 05:59:34PM +0800, kernel test robot wrote:
> > 
> > 
> > Hello,
> > 
> > kernel test robot noticed a -18.0% regression of stress-ng.link.ops_per_sec on:
> > 
> > 
> > commit: 8d993618350c86da11cb408ba529c13e83d09527 ("btrfs: migrate get_eb_page_index() and get_eb_offset_in_page() to folios")
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> Unfortunatelly the conversion to folios adds a lot of assembly code and
> we can't rely on constants like PAGE_SIZE anymore. The calculations in
> extent buffer members are therefore slower, 18% is a lot but within my
> expected range for metadta-only operations.
> 
> This could be improved by caching some values, like folio_size, so it's
> a dereference and not a calculation of "PAGE_SIZE << folio_order" with
> conditionals around.

You're in the unfortunate position of paying all the costs of a variable
folio size while not getting the benefit of variable folio sizes ...

There's no space in struct folio to cache folio_size().  It's an
loff_t, so potentially huge.  Also there are people who have designs
on the remaining space in struct folio for a variety of purposes.
Would it be better to be PAGE_SIZE * folio_nr_pages(), which is cached?
That's at least dereference, then shift-variable-by-constant, rather
than dereference, shift-constant-by-variable.

