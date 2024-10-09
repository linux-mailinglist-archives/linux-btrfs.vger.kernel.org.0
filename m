Return-Path: <linux-btrfs+bounces-8723-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35172996E71
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 16:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 563541C22C8F
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 14:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7021A0B0C;
	Wed,  9 Oct 2024 14:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cIHKu2rk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E815519DF5F;
	Wed,  9 Oct 2024 14:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728484987; cv=none; b=RaQ2oXbANYSTDFhmCTdyg8RUZuSARlacV8WG9yQbYIf/I6b7/uAaCCSJOZGdlKigA4gTdnESSA8umFCJMZPelFIXxFcPnpGADerPLnOera7WcZmbCxKwqeD75yMosllYA5mCrAcnRj/7C83H2kVFChuiZSsZrzjlN2/vAvUFzl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728484987; c=relaxed/simple;
	bh=hf4on/r5tPwKyDpoq+OEWgpFtnZGs8sN7/MSF1eK+4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A2pqDpGZvzgwClY/FxRlivrIVh7rDtuhXn/7tpuG1Ab+0e3ZP4OukmNDx1EPQhzjIAR5+G61AW+uKhGVkKMAAQ3eW7IP8dCRe603DnTBjeNDa6dqSIxbD1oZHRKJS7YLWNTWJDvEBgYW7aaQBnbHy+c7bHqfKG+mui/SPZ+v+NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cIHKu2rk; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728484986; x=1760020986;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hf4on/r5tPwKyDpoq+OEWgpFtnZGs8sN7/MSF1eK+4M=;
  b=cIHKu2rkscPknfuJ/oboQ3MjvgfW8jyjmjQhwEaGeCLlXfMq9h+OoT4e
   wfq0YnVBC1WoybSE+uoOlSPVdleKJZkbKhAWn8fWppJLMRvvHIdqL++1C
   9CMUIYtOQtFETCABldz+O4Ntm1d9FVs/Mnh1qCbUiSmMIVxFMBuN5yhit
   46tATQRNNzVtH4VoQDdgQI+kESK4PUQk6oiAwatJQAE/fMG4XXf9Bl0Xc
   hVXS61O3XwEslObPixuBTrBMYAhF6xwnRsc95HenfbV789HLtMpAhPhST
   SLRaHpPwIOEUAch/m6nzSLyC1E6aBXiJsij8bVs1AFyWoBVuldM45jAk+
   Q==;
X-CSE-ConnectionGUID: KSi0YeU4QS2R1F5hlLAngA==
X-CSE-MsgGUID: NQc8K75lTjqRnbS4JElNEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="27737863"
X-IronPort-AV: E=Sophos;i="6.11,190,1725346800"; 
   d="scan'208";a="27737863"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 07:43:05 -0700
X-CSE-ConnectionGUID: 72lAOzH0S52oi+21m+H9pg==
X-CSE-MsgGUID: cn1yz7O5TCeTmob0zzsP7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,190,1725346800"; 
   d="scan'208";a="81289743"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 09 Oct 2024 07:43:01 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id E3F47807; Wed, 09 Oct 2024 17:42:59 +0300 (EEST)
Date: Wed, 9 Oct 2024 17:42:59 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Ira Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>,
	Fan Ni <fan.ni@samsung.com>,
	Navneet Singh <navneet.singh@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-btrfs@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-doc@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v4 02/28] printk: Add print format (%pra) for struct range
Message-ID: <ZwaWc0-VxNpNeWBN@black.fi.intel.com>
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
 <20241007-dcd-type2-upstream-v4-2-c261ee6eeded@intel.com>
 <ZwVkNNpVrJ4lHQ8p@black.fi.intel.com>
 <20241009132737.000046ca@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009132737.000046ca@Huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Oct 09, 2024 at 01:27:37PM +0100, Jonathan Cameron wrote:
> On Tue, 8 Oct 2024 19:56:20 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Mon, Oct 07, 2024 at 06:16:08PM -0500, Ira Weiny wrote:

...

> > > +static void __init
> > > +struct_range(void)
> > > +{
> > > +	struct range test_range = {
> > > +		.start = 0xc0ffee00ba5eba11,
> > > +		.end = 0xc0ffee00ba5eba11,
> > > +	};  
> > 
> > A side note, can we add something like
> > 
> > #define DEFINE_RANGE(start, end)	\
> > 	(struct range) {		\
> > 		.start = (start),	\
> > 		.end = (end),		\
> > 	}
> > 
> > in range.h and use here and in the similar cases?
> 
> DEFINE_XXXX at least sometimes is used in cases that create the
> variable as well.  E.g. DEFINE_MUTEX()

I understand your point, but since there are many similarities to struct
resource, I would stick with naming convention in ioport.h.

> INIT_RANGE() maybe?

-- 
With Best Regards,
Andy Shevchenko



