Return-Path: <linux-btrfs+bounces-7498-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B15895F2D8
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2024 15:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D59921F23FDE
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2024 13:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB311185B77;
	Mon, 26 Aug 2024 13:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ky9zwDdo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399EA2C95;
	Mon, 26 Aug 2024 13:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724678680; cv=none; b=mFQixAmw65czEkeJScPGWzha0d+czCBsrUs19ytGP4I7LNWsz33ZNSgfAT5+xwmOdRUjnAckYHy6wRzW12FuBbGre0k2yC59Iw+kjmCIBxUj8iiToT77TKFf7Is4zFEcTOKrS7qIZcFKnuLx4sxDWS4alsGJ1on74HJtW0DhhaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724678680; c=relaxed/simple;
	bh=xfEqhEDpmWF2aBmxxyu37rCNaOAJ77ma15Jwxkgm6Q4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AZ4qiQjvjk1HTYhuGGnIQmMwcUZ8DCgXJln0BKziPHf1C/eVQQjBpZ4aNDGMMZFNV+Mp5RYxH4ecKtLTGlDbOhtKRGEQ40nQVGVpCq3ZUfZJv48mPBTRwlAEyn3gGMcRv+eECngW4y5qFC9FovLrYw8SWsJlaJEibmLbWOTAtJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ky9zwDdo; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724678678; x=1756214678;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xfEqhEDpmWF2aBmxxyu37rCNaOAJ77ma15Jwxkgm6Q4=;
  b=ky9zwDdoe2dfXGbrov2pnwf+/Y7vfkIR943MtSs567GaJWtGyjkx09Wk
   gy4vIXhHPwlyjVfqqFzY8ht9ImGecmFJlg1dS6zT6ctTwqN0a4/exPXqE
   pM5OigC+3bFJsIn52grvfaVk2pqcdTRJDhfXqNh4sAJVJjJOk8Oy59X6m
   SXtzrc/zv77BQl2OLVYSTkRVvnEKd0+i4/vFSEi/jvJAktY3e+8IvTDIi
   lKlyb7a3d01ujELxia1O6eqJzwAK2P37qxiTbAppdGFlrR1yVlM/qNn0Y
   eyK3suBDCb00wKP9OmWbKBVpulBBmJSacGfN31rD+FsN+w3WZk00UgGFg
   w==;
X-CSE-ConnectionGUID: 4VxtkrMbS8GEWqjEoUNqjg==
X-CSE-MsgGUID: zZfxmvlkSNqWaLEvC4f7wA==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="23281410"
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="23281410"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 06:24:37 -0700
X-CSE-ConnectionGUID: xQeijwBhS+6GvIOEaDqo4g==
X-CSE-MsgGUID: 1VWYcWNxQfGomDPvu7kDqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="62479751"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 06:24:33 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1siZht-00000001wVd-0PJg;
	Mon, 26 Aug 2024 16:24:29 +0300
Date: Mon, 26 Aug 2024 16:24:28 +0300
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
Message-ID: <ZsyCDP-AJqH02zJk@smile.fi.intel.com>
References: <20240816-dcd-type2-upstream-v3-0-7c9b96cba6d7@intel.com>
 <20240816-dcd-type2-upstream-v3-2-7c9b96cba6d7@intel.com>
 <ZsSjdjzRSG87alk5@pathway.suse.cz>
 <66c77b1c5c65c_1719d2940@iweiny-mobl.notmuch>
 <ZsyAZsDeWLNvSec9@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsyAZsDeWLNvSec9@pathway.suse.cz>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Aug 26, 2024 at 03:17:26PM +0200, Petr Mladek wrote:
> On Thu 2024-08-22 12:53:32, Ira Weiny wrote:
> > Petr Mladek wrote:
> > > On Fri 2024-08-16 09:44:10, Ira Weiny wrote:

[...]

> > > > +	static const struct printf_spec range_spec = {
> > > > +		.base = 16,
> > > > +		.field_width = RANGE_PRINTK_SIZE,
> > 
> > However, my testing indicates this needs to be.
> > 
> >                 .field_width = 18, /* 2 (0x) + 2 * 8 (bytes) */
> 
> Makes sense. Great catch!

Which effectively means usage of special_hex_number().
But again, consider to unite this with %pR/r implementation(s).

> > ... to properly zero pad the value.  Does that make sense?
> >
> > > > +		.precision = -1,
> > > > +		.flags = SPECIAL | SMALL | ZEROPAD,
> > > > +	};

-- 
With Best Regards,
Andy Shevchenko



