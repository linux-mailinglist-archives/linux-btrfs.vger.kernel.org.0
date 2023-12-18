Return-Path: <linux-btrfs+bounces-1026-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2697D8170BB
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Dec 2023 14:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44A9C1C24711
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Dec 2023 13:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C4E37866;
	Mon, 18 Dec 2023 13:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UoGvaYxk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69F71D146;
	Mon, 18 Dec 2023 13:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702907047; x=1734443047;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=G/JDSsjaBbpRf47CjuV2xxri4aEDlv0U+LcRg8Kpez4=;
  b=UoGvaYxkF3eLP5wlEQrsTg3dwAra4RnN7h8qI95Hbqk5duFN3MoJ5Cae
   DMhsSBa4IvOb2ZwxgU1lyLugXDnStG9sDkGswOpqqajYNchtnZvU4yaj1
   6hwyXL90muq0GAtjqO2u3zut7Ad5a2kMJGwffWBwg+UbMCFKimzE7XeCI
   aqS06bPJOTqr1FbpTkondN5yl5t5z6qGy6V/2Sl4VjX/GQPdxf3WhkCU/
   u2SXQtnXsdYKCV4rRqLjY1M0JNAnh8TmAZf+5s/PLHCd6CwOykuufNrVA
   WleBm8cOpw7GInkt0yk/R8mX6r/1fK+QCvLUCXObw+KGoegs8ZppLX9CP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="8957884"
X-IronPort-AV: E=Sophos;i="6.04,285,1695711600"; 
   d="scan'208";a="8957884"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 05:44:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="898974742"
X-IronPort-AV: E=Sophos;i="6.04,285,1695711600"; 
   d="scan'208";a="898974742"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 05:44:04 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rFDub-00000006x8d-3pIB;
	Mon, 18 Dec 2023 15:44:01 +0200
Date: Mon, 18 Dec 2023 15:44:01 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] lib/strtox: introduce kstrtoull_suffix() helper
Message-ID: <ZYBMoUT8pDL0Rn5V@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo


On Fri, Dec 15, 2023 at 07:09:23PM +1030, Qu Wenruo wrote:
> Just as mentioned in the comment of memparse(), the simple_stroull()
> usage can lead to overflow all by itself.
> 
> Furthermore, the suffix calculation is also super overflow prone because
> that some suffix like "E" itself would eat 60bits, leaving only 4 bits
> available.
> 
> And that suffix "E" can also lead to confusion since it's using the same
> char of hex Ox'E'.

How would you distinguish 25E with [0x]25e?
I believe it's unsolvable issue as long as we have it already.

> One simple example to expose all the problem is to use memparse() on
> "25E".
> The correct value should be 28823037615171174400, but the suffix E makes
> it super simple to overflow, resulting the incorrect value
> 10376293541461622784 (9E).

So, then you can probably improve memparse()?

> So here we introduce a new helper to address the problem,
> kstrtoull_suffix():

This is a horrible naming. What suffix? What would be without it
(if it's even possible)? I have more questions than answers...

> - Enhance _kstrtoull()
>   This allow _kstrtoull() to return even if it hits an invalid char, as
>   long as the optional parameter @retptr is provided.
> 
>   If @retptr is provided, _kstrtoull() would try its best to parse the
>   valid part, and leave the remaining to be handled by the caller.
> 
>   If @retptr is not provided, the behavior is not altered.

Can we not touch that one. I admit that it may be not used in the hot paths,
but I prefer that it does exactly what it does in a strict way.

> - New kstrtoull_suffix() helper
>   This new helper utilize the new @retptr capability of _kstrtoull(),
>   and provides 2 new ability:
> 
>   * Allow certain suffixes to be chosen
>     The recommended suffix list is "KkMmGgTtPp", excluding the overflow
>     prone "Ee". Undermost cases there is really no need to use "E" suffix
>     anyway.
>     And for those who really need that exabytes suffix, they can enable
>     that suffix pretty easily.
> 
>   * Add overflow checks for the suffixes
>     If the original number string is fine, but with the extra left
>     shift overflow happens, then -EOVERFLOW is returned.

And formal NAK due to lack of test cases. We do not accept new generic
code without test cases.

-- 
With Best Regards,
Andy Shevchenko


