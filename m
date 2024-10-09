Return-Path: <linux-btrfs+bounces-8725-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 780D0996E8B
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 16:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31A99282203
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 14:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985E019DF9E;
	Wed,  9 Oct 2024 14:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n/uGmT0Z"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6E5433B6;
	Wed,  9 Oct 2024 14:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728485190; cv=none; b=my9ibOiENj3Z+eIYpc/9A3nU2oWv/STbFshs0slPoabxdcgZUPqj0qxDZafd8ChytdxTPagp7Z5FcBPXnNAIZZYafVvVyYxHO9vfzfr8kif7cz9a5crKqTZ1XvK92HV1kF/fCXrytzZIJB4Lz/Nkagf/WLnqvTUbNNdoE4YNMN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728485190; c=relaxed/simple;
	bh=xXD0CGxWWzLTAw/TXApXZkvVnSpZBuc19McI4xF2HPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=plwXkkm+SiF1XSB6w7ApXy9xBt/3PZto+dhR5lpH5mKQOEdkBvMjNDerItiC26F84E30XlZHSJ4AE61sxuTrk5r69QhVwFDCb+d/9QKjJ26tYNhmuYRY65Vkwqco8hqyxuBrrL25c35SNUjVOj1p/Jau8rsubEcgK2sRwmKQU90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n/uGmT0Z; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728485189; x=1760021189;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xXD0CGxWWzLTAw/TXApXZkvVnSpZBuc19McI4xF2HPE=;
  b=n/uGmT0Zz2vHm/9KBfuqprqmB90YGYP77EzztxEol4weJVGApEobYyXD
   s4kzNm1+cl40ibp3kVuTAvuVsHLKibP5I2L+gaqU1+kZTbm7R0/6gb10k
   8IexRY49x9L0bG7nZE7sZYbxPj29+dMgp3H2PWb59xpViL5pa5HUnS7bw
   sMAE5G24JkJJ0IksH6xMiD6xvxLUu1K1pqr1yuoswkSIcm/nJwvKzAzxy
   Vek4os0faE1Q0KLaiLdkpfpMqPWd4swbWdTbusROlk6p18nAUPv8s32Th
   Ez/9s0vRNwLsQ2Zp4HfcMsxwX8nm8Oer2lNndjUj4LQnnCqhVCsgjpDhT
   A==;
X-CSE-ConnectionGUID: SNFjQBGiQxiVyVnpFAi6Yg==
X-CSE-MsgGUID: PZ4ws1chSsaNVzKqTNZ3hg==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="45259095"
X-IronPort-AV: E=Sophos;i="6.11,190,1725346800"; 
   d="scan'208";a="45259095"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 07:46:28 -0700
X-CSE-ConnectionGUID: AJQomrpJQ2WqZ2mRP+8BlA==
X-CSE-MsgGUID: nNhaAVk2TEuOKbqR/zLgWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,190,1725346800"; 
   d="scan'208";a="99606822"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa002.fm.intel.com with ESMTP; 09 Oct 2024 07:46:24 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id EFE8B807; Wed, 09 Oct 2024 17:46:22 +0300 (EEST)
Date: Wed, 9 Oct 2024 17:46:22 +0300
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
Message-ID: <ZwaXPm5WrzLVoUuw@black.fi.intel.com>
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
 <20241007-dcd-type2-upstream-v4-4-c261ee6eeded@intel.com>
 <20241008161032.GB1609@twin.jikos.cz>
 <ZwaW9gXuh_JzqRfh@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwaW9gXuh_JzqRfh@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Oct 09, 2024 at 05:45:10PM +0300, Andy Shevchenko wrote:
> On Tue, Oct 08, 2024 at 06:10:32PM +0200, David Sterba wrote:
> > On Mon, Oct 07, 2024 at 06:16:10PM -0500, Ira Weiny wrote:

...

> > > +static inline bool range_overlaps(struct range *r1, struct range *r2)
> > 
> > I've noticed only now, you can constify the arguments, but this applise
> > to other range_* functions so that can be done later in one go.
> 
> Frankly you may add the same to each new API being added to the file and
> the "one go" will never happen. So, I support your first part with
> constifying, but I think it would be rather done now to start that "one
> go" to happen.

Alternatively there is should be the patch _in this series_ to make it
happen before extending an API. I leave the choice to Ira.

-- 
With Best Regards,
Andy Shevchenko



