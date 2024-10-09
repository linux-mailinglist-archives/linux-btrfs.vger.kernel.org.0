Return-Path: <linux-btrfs+bounces-8721-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A219996E63
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 16:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B9EC1C21C44
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 14:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A471A38EC;
	Wed,  9 Oct 2024 14:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mSgIstK3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDDE1A0B0E;
	Wed,  9 Oct 2024 14:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728484910; cv=none; b=nbs2zarpXilptm036WqF+vXRC+bHto3H9yiWyjR/1Kl9fTQP4K+T8KUnp7EpvbwvOSG1suc6DJ76JPErinHoz4beR2ukuZP+ufdPZvEjsYfSjyAhWpgC8kud90v3ONjh2lJsYhej+VrTXlcgl1j6AhRnvxw/08xdP7xXEzd7AkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728484910; c=relaxed/simple;
	bh=Gl2IeEubOk79g6U+KbMn6Odz077Af2guzD6QCiQErmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UzP02XprqjWSqhN5hQLttCQI+Q1MJ7pMpgGDQ4iV5OSagRvJ3yWxu6jUzbGvUv5Cper76BDoPrZa6wmLlN6/gdYPVfy2IVnGgICJaAMjtB/6ZcDMp25KHhRx17iqKqdhseE9xZp3Zan4Z87dRyMsMQDbtYYxqF1pxkUXVJ9zya8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mSgIstK3; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728484908; x=1760020908;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Gl2IeEubOk79g6U+KbMn6Odz077Af2guzD6QCiQErmA=;
  b=mSgIstK3tFZ283Wa7jty6K6yBwYq15jPsHpXYo/+YBs6KcyN3BFwdgEj
   xlJDedaeziVNenaCejffTDHzVP4qfKrGLri4sAs6nPfDehr56bXgMsTNA
   CYid2juE7uKZ/R2jZ5MSd9LW6jvqBL27SeLcZQ4b4q+xsQzAmA+aTwhp7
   caWKXRP1NUGgaLV+ScmZBAGe7vFnbhRlIv5SeSE8zFphB78AAgFMde1ru
   coM9pm9325Q02rUMCRyRX7KJ9sRB/Ckyhq8/FK+y3N6twGka3ecV9Gcmz
   ziBPzmtBccVr2HK5dW1D4TVtvu7oJsbIujzZdF3lv37loCVBz9/x/YQVt
   w==;
X-CSE-ConnectionGUID: PpxA3CCcSkWhcSvpQpzXuw==
X-CSE-MsgGUID: g19W9BH3TCO51EAgZ9ZEJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="27920309"
X-IronPort-AV: E=Sophos;i="6.11,190,1725346800"; 
   d="scan'208";a="27920309"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 07:41:48 -0700
X-CSE-ConnectionGUID: o+Qry20MTliuzt4LYcghzg==
X-CSE-MsgGUID: ADUDfGf1RWuVEf3ok9ArMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,190,1725346800"; 
   d="scan'208";a="77101129"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa008.jf.intel.com with ESMTP; 09 Oct 2024 07:41:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id DE45B807; Wed, 09 Oct 2024 17:41:41 +0300 (EEST)
Date: Wed, 9 Oct 2024 17:41:41 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
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
	linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v4 02/28] printk: Add print format (%pra) for struct range
Message-ID: <ZwaWJcfD8lPLhpY2@black.fi.intel.com>
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
 <20241007-dcd-type2-upstream-v4-2-c261ee6eeded@intel.com>
 <871q0p5rq1.fsf@prevas.dk>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871q0p5rq1.fsf@prevas.dk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Oct 09, 2024 at 03:30:14PM +0200, Rasmus Villemoes wrote:

...

> Rather than the struct assignments, I think it's easier to read if you
> just do
> 
>   struct range r;
> 
>   r.start = 0xc0ffee00ba5eba11;
>   r.end   = r.start;
>   ...
> 
>   r.start = 0xc0ffee;
>   r.end   = 0xba5eba11;
>   ...
> 
> which saves two lines per test and for the first one makes it more
> obvious that the start and end values are identical.

With DEFINE_RANGE() it will save even more lines!

..

> > +		if (buf < end)
> > +			*buf++ = '-';
> 
> No. Either all your callers pass a (probably stack-allocated) buffer
> which is guaranteed to be big enough, in which case you don't need the
> "if (buf < end)", or if some callers may "print" directly to the buffer
> passed to vsnprintf(), the buf++ must still be done unconditionally in
> order that vsnprintf(NULL, 0, ...) [used by fx kasprintf] can accurately
> determine how large the output string would be.

Ah, good catch, I would add...

> So, either
> 
>   *buf++ = '-'
> 
> or
> 
>   if (buf < end)
>     *buf = '-';
>   buf++;

...that we use rather ++buf in such cases, but it doesn't really matter.

> Please don't mix the two. 

-- 
With Best Regards,
Andy Shevchenko



