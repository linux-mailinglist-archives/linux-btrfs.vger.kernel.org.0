Return-Path: <linux-btrfs+bounces-8736-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B71999710E
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 18:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6430B1C21FCF
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 16:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463191DEFC2;
	Wed,  9 Oct 2024 16:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mMqRLFBH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3CD1D07A3;
	Wed,  9 Oct 2024 16:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728489892; cv=none; b=crseXkJfqflkBqwZfiyT78U7lEeR1jInwaHxgGB6n/0PZMayNhBxvsBkJEvLCaNi/40ebjVZcSZII+v+7WOBfr34HedK5Kp4X5O0aqXw+RAZQ62970pq73ebJkux+xvMTBncV/H0T2ltc/0shgKlm5deJ4Z/HMeMoHl2VZ5LuUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728489892; c=relaxed/simple;
	bh=S7VOLr15MA5IYpxNnw6xgbwUOkXwGf/+Y/OeUbY9oZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ISKSZqQ8b4cSoAazUo5ksswysYHY3EpPD1CSQPPNw7UkM/qB/R0RHsJ0OFOnx5ZjCSHVXHNLwuXliyYf3M7acLXoju5HhAh7Jqm2ASxVCeR+Crwzw1SvMwMK0CMTBcSJKcXuhmB0WctUgV2XFWKoIwwt0VcQebjG7c3ZaUdV+4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mMqRLFBH; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728489891; x=1760025891;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S7VOLr15MA5IYpxNnw6xgbwUOkXwGf/+Y/OeUbY9oZk=;
  b=mMqRLFBHn6HXxrsLLJp7yCpLQri273Wd9PIqBqFouek5KW9lJnGqIU8z
   ilv54wxa3U21A14s97BuQNN8bmyYUpcV2m8UxjnkBJFecoNx+WCLubozF
   JMAMnYOUXbbNwY55FqXpHEmnfpY7jLidc+hKhpsKlh70qQGnl3ziBPgmN
   AtWh6UgHbYEMaGmzs0kTVI8mDlTdPntDAnhwVAFdceZgbzgahSUZEvqJj
   R6xYOpYfeVf1tN9YMYCVew+d4l1nbVRHHpLL0HtYGdIvCsKicd3ZUIddC
   IBxp07OQUQVIwPLN/p9w3j5lTHW1/AkIfj2fNjpMm11hXKqF9LJooVROU
   g==;
X-CSE-ConnectionGUID: MFREpKG5Tfu6oO68frH4vg==
X-CSE-MsgGUID: Azlxt9QbTq+hp6EzsimnqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="39163345"
X-IronPort-AV: E=Sophos;i="6.11,190,1725346800"; 
   d="scan'208";a="39163345"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 09:04:50 -0700
X-CSE-ConnectionGUID: sdQLp+9IQuq57QIp38SDtA==
X-CSE-MsgGUID: N99/WQr4SpWFntETzZXecw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,190,1725346800"; 
   d="scan'208";a="80805323"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 09 Oct 2024 09:04:45 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 0BDAB50F; Wed, 09 Oct 2024 19:04:43 +0300 (EEST)
Date: Wed, 9 Oct 2024 19:04:43 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Sterba <dsterba@suse.cz>
Cc: Ira Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>,
	Fan Ni <fan.ni@samsung.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Navneet Singh <navneet.singh@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-btrfs@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-doc@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v4 04/28] range: Add range_overlaps()
Message-ID: <Zwapm97gV0y7Up9H@black.fi.intel.com>
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
 <20241007-dcd-type2-upstream-v4-4-c261ee6eeded@intel.com>
 <20241008161032.GB1609@twin.jikos.cz>
 <ZwaW9gXuh_JzqRfh@black.fi.intel.com>
 <20241009153641.GK1609@suse.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009153641.GK1609@suse.cz>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Oct 09, 2024 at 05:36:42PM +0200, David Sterba wrote:
> On Wed, Oct 09, 2024 at 05:45:10PM +0300, Andy Shevchenko wrote:
> > On Tue, Oct 08, 2024 at 06:10:32PM +0200, David Sterba wrote:
> > > On Mon, Oct 07, 2024 at 06:16:10PM -0500, Ira Weiny wrote:

...

> > > > +static inline bool range_overlaps(struct range *r1, struct range *r2)
> > > 
> > > I've noticed only now, you can constify the arguments, but this applise
> > > to other range_* functions so that can be done later in one go.
> > 
> > Frankly you may add the same to each new API being added to the file and
> > the "one go" will never happen.
> 
> Yeah, but it's a minor issue for a 28 patchset, I don't know if there
> are some other major things still to do so that a v5 is expected.

At least seems printf() changes have to be amended, so I think v5 is
warranted anyway.

> If anybody is interested, reviewing APIs and interfaces with focus on
> some data structure and const is relatively easy, compile test is
> typically enough.

Except the cases where a const pointer has to be passed thru non-const
(or integer) field in a data structure. Tons of the existing examples is
ID tables that wanted to have kernel_ulong_t instead of const void * in
driver data field.

> The hard part is to find the missing ones. There's no
> compiler aid thad I'd know of (-Wsuggest-attribute=const is not for
> parameters), so it's been reading a file top-down for me.

Yeah...

> > So, I support your first part with
> > constifying, but I think it would be rather done now to start that "one
> > go" to happen.
> 
> Agreed, one patch on top is probably the least intrusive way.

-- 
With Best Regards,
Andy Shevchenko



