Return-Path: <linux-btrfs+bounces-1439-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1209B82D0C6
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Jan 2024 14:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8499DB216ED
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Jan 2024 13:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F4023D2;
	Sun, 14 Jan 2024 13:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oAZCHPLz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207C12100;
	Sun, 14 Jan 2024 13:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705239766; x=1736775766;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0SdNNY8cR3/JqcCcTMz3H6BUbuomCCtkQgHAbuevA64=;
  b=oAZCHPLzKIuuAoJEJpHIkybBTh5WJZncEApPe3H7nhJdd/i346hBy51K
   bAhg0y0JwpTKSmL1KTZMF+tazZPXkFVeVUA/gd3kfmM52zHhHQ6muuYoh
   oZl/WLBEBIvmnn7yC7nRyX30572LadsGqC1szTcRibH7MU4dfrsY7IVPw
   Gn/dURF+hd10mjZPj/IV17qDmOgQC6kHUKr5VN7SRvpRCRi/FHD13Z4tz
   Bqsq9Gt/d+EqX20RIw8haj15NLDMyuxFWJlm1h3e7HCJt7Db+109go78r
   4Ml/PUrQAA/CV/1EdtFlFi6UL20J089nfxXeKMRZOeqyL8c2pMkTHKxwk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10952"; a="465841160"
X-IronPort-AV: E=Sophos;i="6.04,194,1695711600"; 
   d="scan'208";a="465841160"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2024 05:42:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10952"; a="817567764"
X-IronPort-AV: E=Sophos;i="6.04,194,1695711600"; 
   d="scan'208";a="817567764"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2024 05:42:43 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rP0l5-0000000Dtxx-47nJ;
	Sun, 14 Jan 2024 15:42:39 +0200
Date: Sun, 14 Jan 2024 15:42:39 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	christophe.jaillet@wanadoo.fr, David.Laight@aculab.com,
	ddiss@suse.de, geert@linux-m68k.org
Subject: Re: [PATCH v3 0/4] kstrtox: introduce memparse_safe()
Message-ID: <ZaPkz7gU42Eahf4L@smile.fi.intel.com>
References: <cover.1704324320.git.wqu@suse.com>
 <ZZllAi_GbsoDF5Eg@smile.fi.intel.com>
 <7708fc8b-738c-4d58-b89e-801ce6a4832a@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7708fc8b-738c-4d58-b89e-801ce6a4832a@gmx.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Jan 07, 2024 at 07:28:27AM +1030, Qu Wenruo wrote:
> On 2024/1/7 01:04, Andy Shevchenko wrote:
> > On Thu, Jan 04, 2024 at 09:57:47AM +1030, Qu Wenruo wrote:

...

> > Having test cases is quite good, thanks!
> > But as I understood what Alexey wanted, is not using the kstrtox files for this.
> > You can introduce it in the cmdline.c, correct? Just include local "kstrtox.h".
> 
> Not really possible, all the needed parsing helpers are internal inside
> kstrtox.c.

I'm not sure I follow. The functions are available to other library (built-in)
modules.

> Furthermore, this also means memparse() can not be enhanced due to:
> 
> - Lack of ways to return errors

What does this mean?

> - Unable to call the parsing helpers inside cmdline.c

??? (see above)

-- 
With Best Regards,
Andy Shevchenko



