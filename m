Return-Path: <linux-btrfs+bounces-1080-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 831AE81A0FF
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Dec 2023 15:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 234871F2250E
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Dec 2023 14:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD1A3A29D;
	Wed, 20 Dec 2023 14:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QwhmbAbI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1881B38F9B;
	Wed, 20 Dec 2023 14:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703082006; x=1734618006;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Cpy14Hdv+G05egV79hbRzIYlL3cC/Rq5mKgn8sI00YE=;
  b=QwhmbAbIRUIcwyczkN35Nd7r8M3X10De/maDN40E75kkr7ER6ftXsx3o
   yGjdKY1sOK/j2oOuxT50ppqG2ebLz36dx9elwqscR++FWgf4RtDYoJb/s
   POuIQ3GbwOi8Y0YpiYtla26ae4N4ssOxaYw7J4EHNUSzUBNF946tsURCa
   +YAJ0xmQbY2JrFHWjfkH0GqqSYngoWTjLDLug0AAjrTQmdzMxnbRf/o+i
   lhLe/4pKM+X65CL79Uzi3EgMl65vI/a5QgNOGid2ml+vbdjkjkWCrVHhe
   cNNUYf6UcLHEABgD9PAm83ygo4tI6MTZILuSu6vdLSzBOerO8wyGDKXx2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="375309623"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="375309623"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 06:20:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="866987960"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="866987960"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 06:20:04 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rFxNz-00000007YVJ-2dru;
	Wed, 20 Dec 2023 16:17:23 +0200
Date: Wed, 20 Dec 2023 16:17:23 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	David Laight <David.Laight@aculab.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] lib/strtox: introduce kstrtoull_suffix() helper
Message-ID: <ZYL3c1S7B9PHPEwI@smile.fi.intel.com>
References: <cover.1703030510.git.wqu@suse.com>
 <e042f40ea5cf7fa8251713d5bb7a485f42c5615b.1703030510.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e042f40ea5cf7fa8251713d5bb7a485f42c5615b.1703030510.git.wqu@suse.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Dec 20, 2023 at 10:40:00AM +1030, Qu Wenruo wrote:
> Just as mentioned in the comment of memparse(), the simple_stroull()
> usage can lead to overflow all by itself.
> 
> Furthermore, the suffix calculation is also super overflow prone because
> that some suffix like "E" itself would eat 60bits, leaving only 4 bits
> available.
> 
> And that suffix "E" can also lead to confusion since it's using the same
> char of hex Ox'E'.
> 
> One simple example to expose all the problem is to use memparse() on
> "25E".
> The correct value should be 28823037615171174400, but the suffix E makes
> it super simple to overflow, resulting the incorrect value
> 10376293541461622784 (9E).
> 
> So here we introduce a new helper to address the problem,
> kstrtoull_suffix():
> 
> - Enhance _kstrtoull()
>   This allow _kstrtoull() to return even if it hits an invalid char, as
>   long as the optional parameter @retptr is provided.
> 
>   If @retptr is provided, _kstrtoull() would try its best to parse the
>   valid part, and leave the remaining to be handled by the caller.
> 
>   If @retptr is not provided, the behavior is not altered.
> 
> - New kstrtoull_suffix() helper
>   This new helper utilize the new @retptr capability of _kstrtoull(),
>   and provides 2 new ability:
> 
>   * Allow certain suffixes to be chosen
>     The recommended suffix list is "KMGTP" (using the new unit_suffix
>     enum as a bitmap), excluding the overflow prone "E".
>     Undermost cases there is really no need to use "E" suffix anyway.
>     And for those who really need that exabytes suffix, they can enable
>     that suffix pretty easily.
> 
>   * Add overflow checks for the suffixes
>     If the original number string is fine, but with the extra left
>     shift overflow happens, then -EOVERFLOW is returned.

NAK. Read the v1 discussion why.

-- 
With Best Regards,
Andy Shevchenko



