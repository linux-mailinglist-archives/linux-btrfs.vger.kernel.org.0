Return-Path: <linux-btrfs+bounces-7514-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C5D95F7F8
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2024 19:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D4C92819BF
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2024 17:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31C61991B6;
	Mon, 26 Aug 2024 17:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RG7jfQBZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED041990A5;
	Mon, 26 Aug 2024 17:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724693008; cv=none; b=fzsi2ISXWeuMDisjZ9WpUGDTn+jgES37XyMKEC+I5ELgvH5c8kx/LIZxCiLORMea34EoWP/bUJSTx1jIHpJkCze/UHhfNbVDxbTcpjAn9BZ/QMbWKMXN1XSeyaZ3Jmhk65PZhQj9c3KvY9JM8JT2asfj7G9REgjW8aTNc+VNa6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724693008; c=relaxed/simple;
	bh=EH4sLmUi31moY38px/brd6V2p1f9A3ICQEkXbIPLoGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dCDqqdWeccaZFIJ7jYTQMApU9KlbMwEK/+IXgNzyJF+KcC1j60kiOhwnl9oWA9Gj+SsO62ck1FGHthQ7mLNk160i5/lMYG8kETFex+TINtaQf9OavTnVZGflu40OGwzNuWpGrugpiVHKQhlDUi4ADmdnHo03SRMP2BLwN0k6TWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RG7jfQBZ; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724693007; x=1756229007;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EH4sLmUi31moY38px/brd6V2p1f9A3ICQEkXbIPLoGI=;
  b=RG7jfQBZDEE+xybcGDjX9YoxUj9drbl/SUod1/1aYLD6Q+gR5UxauPu1
   LcH2GvM7hUqUMp2zAGcAUHW1P88VeyjfhEDJX4q+rZZjg5ZtWNrLAk5Vx
   ZxpA7t1f07WGID5WZz18LYlxCbw2cWeuNpUPti02iGTVNl/wvq1vnTBRN
   vNyvHX8etKcrdQGkDoMoxb8YgnfH+x95FOKkRO8MLUeTWIVzxqc6+CHaM
   QtQ+ZoKiyDoO2TeJHJlRi83ANKgxbgVbfE30yVyZ3cOcp9oT5ogEtyXNe
   CpwAXLeRSsQjWh49QGaSBpBMtT/BWOWu1WT3MNdlR9RD0eOM9bDjQnk50
   A==;
X-CSE-ConnectionGUID: j1Jf8l10S2mjGbi4pYugwQ==
X-CSE-MsgGUID: aMrX+BC3T9iiDBY2Ff+vng==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="40635600"
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="40635600"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 10:23:26 -0700
X-CSE-ConnectionGUID: 8A35PKczQaeEPyg9h8MbHQ==
X-CSE-MsgGUID: NdgO3xEzQY6GDoWJMR2D+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="67264184"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 10:23:21 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sidQz-000000021TV-2vmu;
	Mon, 26 Aug 2024 20:23:17 +0300
Date: Mon, 26 Aug 2024 20:23:17 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Ira Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>,
	Fan Ni <fan.ni@samsung.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Navneet Singh <navneet.singh@intel.com>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-btrfs@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	nvdimm@lists.linux.dev
Subject: Re: [PATCH v3 02/25] printk: Add print format (%par) for struct range
Message-ID: <Zsy6BbJiYqiXORGu@smile.fi.intel.com>
References: <20240816-dcd-type2-upstream-v3-0-7c9b96cba6d7@intel.com>
 <20240816-dcd-type2-upstream-v3-2-7c9b96cba6d7@intel.com>
 <ZsSjdjzRSG87alk5@pathway.suse.cz>
 <66c77b1c5c65c_1719d2940@iweiny-mobl.notmuch>
 <Zsd_EctNZ80fuKMu@smile.fi.intel.com>
 <ZsyB5rqhaZ-oRwny@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsyB5rqhaZ-oRwny@pathway.suse.cz>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Aug 26, 2024 at 03:23:50PM +0200, Petr Mladek wrote:
> On Thu 2024-08-22 21:10:25, Andy Shevchenko wrote:
> > On Thu, Aug 22, 2024 at 12:53:32PM -0500, Ira Weiny wrote:
> > > Petr Mladek wrote:
> > > > On Fri 2024-08-16 09:44:10, Ira Weiny wrote:

...

> > > > > +	%par	[range 0x60000000-0x6fffffff] or
> > > > 
> > > > It seems that it is always 64-bit. It prints:
> > > > 
> > > > struct range {
> > > > 	u64   start;
> > > > 	u64   end;
> > > > };
> > > 
> > > Indeed.  Thanks I should not have just copied/pasted.
> > 
> > With that said, I'm not sure the %pa is a good placeholder for this ('a' stands
> > to "address" AFAIU). Perhaps this should go somewhere under %pr/%pR?
> 
> The r/R in %pr/%pR actually stands for "resource".
> 
> But "%ra" really looks like a better choice than "%par". Both
> "resource"  and "range" starts with 'r'. Also the struct resource
> is printed as a range of values.

Fine with me as long as it:
1) doesn't collide with %pa namespace
2) tries to deduplicate existing code as much as possible.

> > > > > +		[range 0x0000000060000000-0x000000006fffffff]
> > > > > +
> > > > > +For printing struct range.  A variation of printing a physical address is to
> > > > > +print the value of struct range which are often used to hold a physical address
> > > > > +range.
> > > > > +
> > > > > +Passed by reference.

-- 
With Best Regards,
Andy Shevchenko



