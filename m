Return-Path: <linux-btrfs+bounces-1146-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EFF81F011
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Dec 2023 17:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63F3A283454
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Dec 2023 16:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C3745C0B;
	Wed, 27 Dec 2023 16:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n6Ya4vFN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669A545BE7;
	Wed, 27 Dec 2023 16:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703693530; x=1735229530;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uL/IFA0b3nM5f0Ms5MQUI+8BdmUkqzQ7dhE/A/Ig3pE=;
  b=n6Ya4vFNeHzd0P+5yZhcGzOMyO/6dZtv92YYOzeZZ4W8W99KQzpSCxf7
   NNa5F8TvfpW4OwwnfFlhDBusDIVS+Y9mqg4wTv3QxoungtmCsc5XmhPQE
   fzqT3KT05Ktuh3Dhq9arSTOx78EtWl8rPRX9axUvOfAJU30ZlkYbVnWRR
   zZvYMrXxqSlgr9wEcdFnMiq8fgdbeDJylDX7y11NY0C9+0kBooTWzH6Px
   jlnZFg/oQQe9KhQHbafmbbV66sKaVpB0NDYSANf8Gs5C8oCCp6j5e7lEM
   aQjCZpPU0OQHnuMov6hztWiObICucDze7Uhzc/QtDrO1TRJg/op/tOOYN
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="15127766"
X-IronPort-AV: E=Sophos;i="6.04,309,1695711600"; 
   d="scan'208";a="15127766"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 08:12:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="896941256"
X-IronPort-AV: E=Sophos;i="6.04,309,1695711600"; 
   d="scan'208";a="896941256"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 08:12:06 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rIWVn-00000009SWf-2ZIz;
	Wed, 27 Dec 2023 18:12:03 +0200
Date: Wed, 27 Dec 2023 18:12:03 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, christophe.jaillet@wanadoo.fr,
	David.Laight@aculab.com, ddiss@suse.de
Subject: Re: [PATCH 0/3] kstrtox: introduce memparse_safe()
Message-ID: <ZYxM0_hPdqdWxdOv@smile.fi.intel.com>
References: <cover.1703324146.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1703324146.git.wqu@suse.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Dec 23, 2023 at 08:28:04PM +1030, Qu Wenruo wrote:
> Function memparse() lacks error handling:
> 
> - If no valid number string at all
>   In that case @retptr would just be updated and return value would be
>   zero.
> 
> - No overflown detection
>   This applies to both the number string part, and the suffixes part.
>   And since we have no way to indicate errors, we can get weird results
>   like:
> 
>   	"25E" -> 10376293541461622784 (9E)
> 
>   This is due to the fact that for "E" suffix, there is only 4 bits
>   left, and 25 with 60 bits left shift would lead to overflow.
>   (And decision to support for that "E" suffix is already cursed)
> 
> So here we introduce a safer version of it: memparse_safe(), and mark
> the original one deprecated.
> Unfortunately I didn't find a good way to mark it deprecated, as with
> recent -Werror changes, '__deprecated' marco does not seem to warn
> anymore.
> 
> The new helper has the following advantages:
> 
> - Better overflow and invalid string detection
>   The overflow detection is for both the numberic part, and with the
>   suffix. Thus above "25E" would be rejected correctly.
>   The invalid string part means if there is no valid number starts at
>   the buffer, we return -EINVAL.
> 
> - Allow caller to select the suffixes, and saner default ones
>   The new default one would be "KMGTP", without the cursed and overflow
>   prone "E".
>   Some older code like setup_elfcorehdr() would benefit from it, if the
>   code really wants to only allow "KMG" suffixes.
> 
> - Keep the old @retptr behavior
>   So the existing callers can easily migrate to the new one, without the
>   need to do extra strsep() work.
> 
> - Finally test cases
>   The test case would cover more things other than the existing kstrtox
>   tests:
>   * The @retptr behavior
>     Either for bad cases, which @retptr should not be touched,
>     or for good cases, the @retptr is properly advanced,
> 
>   * Return value verification
>     Make sure we distinguish -EINVAL and -ERANGE correctly.
> 
> With the new helper, migrate btrfs to the interface, and since the
> @retptr behavior is the same, we won't cause any behavior change.

Thank you for the prompt update, I will be off till end of January,
and in any case this is material for v6.9+, so I will look at this
afterwards.

-- 
With Best Regards,
Andy Shevchenko



