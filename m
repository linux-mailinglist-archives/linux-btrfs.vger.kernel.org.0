Return-Path: <linux-btrfs+bounces-7412-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8127F95BE05
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2024 20:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A19771C2333F
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2024 18:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4341CFEBF;
	Thu, 22 Aug 2024 18:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bF4tjkTA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010251CCED8;
	Thu, 22 Aug 2024 18:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724350237; cv=none; b=sY+oewH1A+vnG955RhNgeKez4IHvOWPgkFRGFeS+57xdcezCJpjgHoQLn21ebOiZ06+uWaHJdY6mu6dUWLzAnfXgVGTyIzjhR6P++obx53dacoztT2q4cSfmk6TQ32RMYl1Oo42no9mn5sOHl8Dfl0MWpAasfnCuFVuwvd19gpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724350237; c=relaxed/simple;
	bh=8aCefIXweGBUoRWYZSdIIFT8jjG5mDwMgH7k/y1Pq5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eht2wfZ5AI5engG4cptY3Rw4NkmNp8KxgHlarNf1tzpwDeDs/8Scclah6WmiUqFpoauPh7AAYISJtvgNSNKc+9bKGb1M9Q4BU2WaDlgx3aAsQxzt9psKTa8drhuuqnTqM3qWxxCPHY3bS0YxfQPoUDvtCWwZ+6M4/Cc/92xwZ2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bF4tjkTA; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724350236; x=1755886236;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8aCefIXweGBUoRWYZSdIIFT8jjG5mDwMgH7k/y1Pq5w=;
  b=bF4tjkTArfD9Rfeg85eo+OPlNzl5g8u6M1VvkqfQ2szQLVfOVCbVoC+w
   DjrUWNZTuz0/DJuUmqnMhr/sQnUajB1FYofN1sjnboOFRwKjNYpgieMVy
   lnQFODudPeeF1tDj3rXvtlQZjiQOHZxQbbkckFJY/b23S4TUdBEOkpLlr
   Nxy2OZzXosU6gZvOv2myloAuzikBjusmp9uQCIswaVWskNYWvai0skowU
   wnsSjALAz0wx1yWkWzkTGqzZbRzUrtWnMtFaH6nW/hkjTpLT3rjtMQaSU
   hYJNPnDh9gKCZfaSqX8fDWQsygF2iSe3O0WOg33xo8xRiKZXaLjWN1QkD
   w==;
X-CSE-ConnectionGUID: 1s72LtBoQuKa1fU2fEMzaw==
X-CSE-MsgGUID: xuUHn6IASC+eqUq1hhICSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="48182735"
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="48182735"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 11:10:35 -0700
X-CSE-ConnectionGUID: JD0MT8omRCesHeBPQIDPyg==
X-CSE-MsgGUID: 2+q/L8J8SAazZiJ4lksfnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="61840944"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 11:10:30 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1shCGQ-00000000XhF-1IC1;
	Thu, 22 Aug 2024 21:10:26 +0300
Date: Thu, 22 Aug 2024 21:10:25 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ira Weiny <ira.weiny@intel.com>
Cc: Petr Mladek <pmladek@suse.com>, Dave Jiang <dave.jiang@intel.com>,
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
Message-ID: <Zsd_EctNZ80fuKMu@smile.fi.intel.com>
References: <20240816-dcd-type2-upstream-v3-0-7c9b96cba6d7@intel.com>
 <20240816-dcd-type2-upstream-v3-2-7c9b96cba6d7@intel.com>
 <ZsSjdjzRSG87alk5@pathway.suse.cz>
 <66c77b1c5c65c_1719d2940@iweiny-mobl.notmuch>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66c77b1c5c65c_1719d2940@iweiny-mobl.notmuch>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Aug 22, 2024 at 12:53:32PM -0500, Ira Weiny wrote:
> Petr Mladek wrote:
> > On Fri 2024-08-16 09:44:10, Ira Weiny wrote:

...

> > > +	%par	[range 0x60000000-0x6fffffff] or
> > 
> > It seems that it is always 64-bit. It prints:
> > 
> > struct range {
> > 	u64   start;
> > 	u64   end;
> > };
> 
> Indeed.  Thanks I should not have just copied/pasted.

With that said, I'm not sure the %pa is a good placeholder for this ('a' stands
to "address" AFAIU). Perhaps this should go somewhere under %pr/%pR?

> > > +		[range 0x0000000060000000-0x000000006fffffff]
> > > +
> > > +For printing struct range.  A variation of printing a physical address is to
> > > +print the value of struct range which are often used to hold a physical address
> > > +range.
> > > +
> > > +Passed by reference.

...

> > Is this really needed? What about using "default_str_spec" instead?
> 
> Because I got confused and was coping from resource_string().
> 
> Deleted now...
> 
> > > +		.field_width = RANGE_PRINTK_SIZE,
> 
> However, my testing indicates this needs to be.
> 
>                 .field_width = 18, /* 2 (0x) + 2 * 8 (bytes) */
> 
> ... to properly zero pad the value.  Does that make sense?

Looking at this, moving under %pr/R should deduplicate the code, no?
I.o.w. better to use existing code for them to print struct range, no?

-- 
With Best Regards,
Andy Shevchenko



