Return-Path: <linux-btrfs+bounces-1282-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8CF825FE2
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Jan 2024 15:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 703921F229B7
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Jan 2024 14:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16458BE8;
	Sat,  6 Jan 2024 14:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RWzMiQrY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277178826;
	Sat,  6 Jan 2024 14:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704551689; x=1736087689;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=upqLxaJtbw7oUd8/dQ4/u1/YUv0bdd0aioloGDo7Hss=;
  b=RWzMiQrYvgpPx8dSiXAH4eEi1ny5YF3qriirfNCy0WtMtDjrMjGQb5o2
   IOHIo+Ee+iJC84QQfJPx7Hm6VUVo5gi/VB/UXeQPV7eTRKvApTazewDd/
   3YTwrRNmN3THN07g5E2hWE5dsSFqcbDIz92yblsAPL3pszyH6EqRpGcd7
   RnK4bbExscNl/m4xKN30HcM3zP9eINN9QMtTRMWt5UUdxvd/f/9cvj8WT
   5wq/w6hph0j5jdEF5X1UvPtGAkhF5CoLRCeA9nG08jP93pW3xxH+bEYTG
   szvxArIlgAUpy3zdQL0gOGTNK8FpPPb4cr4PwPqDl8L3V9Edu8mkKjPVb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="401440963"
X-IronPort-AV: E=Sophos;i="6.04,337,1695711600"; 
   d="scan'208";a="401440963"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2024 06:34:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="730726614"
X-IronPort-AV: E=Sophos;i="6.04,337,1695711600"; 
   d="scan'208";a="730726614"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2024 06:34:45 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rM7l4-0000000Bvia-1jXH;
	Sat, 06 Jan 2024 16:34:42 +0200
Date: Sat, 6 Jan 2024 16:34:42 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, christophe.jaillet@wanadoo.fr,
	David.Laight@aculab.com, ddiss@suse.de, geert@linux-m68k.org
Subject: Re: [PATCH v3 0/4] kstrtox: introduce memparse_safe()
Message-ID: <ZZllAi_GbsoDF5Eg@smile.fi.intel.com>
References: <cover.1704324320.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1704324320.git.wqu@suse.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Jan 04, 2024 at 09:57:47AM +1030, Qu Wenruo wrote:
> [CHANGELOG]
> v3:
> - Fix the 32bit pointer pattern in the test case
>   The old pointer pattern for 32 bit systems is in fact 40 bits,
>   which would still lead to sparse warning.
>   The newer pattern is using UINTPTR_MAX to trim the pattern, then
>   converted to a pointer, which should not cause any trimmed bits and
>   make sparse happy.

Having test cases is quite good, thanks!
But as I understood what Alexey wanted, is not using the kstrtox files for this.
You can introduce it in the cmdline.c, correct? Just include local "kstrtox.h".

I'm on leave till end of the month, I'll look at this later.

-- 
With Best Regards,
Andy Shevchenko



