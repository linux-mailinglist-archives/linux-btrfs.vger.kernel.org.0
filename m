Return-Path: <linux-btrfs+bounces-19957-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5793FCD7046
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Dec 2025 20:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FC1E301F5D5
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Dec 2025 19:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7125D33BBD2;
	Mon, 22 Dec 2025 19:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dnU6kI1V"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1804E32D44B;
	Mon, 22 Dec 2025 19:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766433328; cv=none; b=jZY3vVsh1SLOFbb7Rtf9KOH3gwI/9bsKcebRFOvXk7pOdyrs3R0HUw8cTPp5EhAY4V03Gs5CuCHocgB6O6vfx8Eti7EI94Q6EE43j7CWn8GZLhWqw5XSzzM46aCbc2D9r9RBy8jxymEWRX2zyYyHIIv4N1orLQFTLG0nG1aP26I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766433328; c=relaxed/simple;
	bh=faxuRQ98w3w3AiTuKAdaMxKF7N4LhPW8CIv8V3TK6l0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SZ3EPEHRyb2ot4pVyfEVBrZQIlcdXpgU791UMSFnhGlt+/4FKQdQ/M4isthGGlY/oGE90gls7WgFs0oIIvV/bRPBKQeS8OK3Hm4e58tcOtmgLkRPsjq+9eklvDjR4mCvXJi/NkQ9cCvUi0B7V0zqvAEpKnea+XOpEUqUBzuPSbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dnU6kI1V; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766433328; x=1797969328;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=faxuRQ98w3w3AiTuKAdaMxKF7N4LhPW8CIv8V3TK6l0=;
  b=dnU6kI1VhDnbl+9zlPWw6O9J8XoeuWHX7FU5cDXU8mE3Dw31G9poNknC
   uJDSltchR2JN5M6vQfecJ8zjVhAUCMhRKbSVBEbH+U/3m2rx+TtvmJjx9
   JY2YATxLaN1p2oVsjq65rsTUR9TYgrhPA8We6h8G2upaz4IFjboC0eHku
   dxtDdca7kMSlCroGbrr9GFGYmH4rapXomxoNUFJen47rGUQ7z0MwPeMw3
   VswA0EypP4ayC9klPGtNpa00Z6LO9nygSKOl4ArVSRM1URrohf6zroE+s
   1qVHQG9VXJTpCBT+UJuWTqxD03mYSXIRAmlZAtMBYMlqus6KY0Uk4P2cv
   A==;
X-CSE-ConnectionGUID: XgvzLm9lQMeCtQ1Nj9RE8A==
X-CSE-MsgGUID: zwEe4emiR9+FjFqaxmSRmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11650"; a="68274160"
X-IronPort-AV: E=Sophos;i="6.21,169,1763452800"; 
   d="scan'208";a="68274160"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2025 11:55:27 -0800
X-CSE-ConnectionGUID: 1xlpX9p5Q2WyLoOdvs0kaw==
X-CSE-MsgGUID: BmooQDGgRI+OgxdmXGgAKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,169,1763452800"; 
   d="scan'208";a="237011330"
Received: from lkp-server02.sh.intel.com (HELO dd3453e2b682) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 22 Dec 2025 11:55:21 -0800
Received: from kbuild by dd3453e2b682 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vXlzy-0000000013h-24Qj;
	Mon, 22 Dec 2025 19:55:18 +0000
Date: Tue, 23 Dec 2025 03:55:07 +0800
From: kernel test robot <lkp@intel.com>
To: Vincent Mailhol <mailhol@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Chris Mason <chris.mason@fusionio.com>,
	David Sterba <dsterba@suse.com>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kbuild@vger.kernel.org,
	linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, dri-devel@lists.freedesktop.org,
	linux-btrfs@vger.kernel.org, linux-hardening@vger.kernel.org,
	Vincent Mailhol <mailhol@kernel.org>
Subject: Re: [PATCH v3 3/3] overflow: Remove is_non_negative() and
 is_negative()
Message-ID: <202512230342.Lgha2HGH-lkp@intel.com>
References: <20251220-remove_wtype-limits-v3-3-24b170af700e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251220-remove_wtype-limits-v3-3-24b170af700e@kernel.org>

Hi Vincent,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 3e7f562e20ee87a25e104ef4fce557d39d62fa85]

url:    https://github.com/intel-lab-lkp/linux/commits/Vincent-Mailhol/kbuild-remove-gcc-s-Wtype-limits/20251220-190509
base:   3e7f562e20ee87a25e104ef4fce557d39d62fa85
patch link:    https://lore.kernel.org/r/20251220-remove_wtype-limits-v3-3-24b170af700e%40kernel.org
patch subject: [PATCH v3 3/3] overflow: Remove is_non_negative() and is_negative()
config: i386-randconfig-141-20251222 (https://download.01.org/0day-ci/archive/20251223/202512230342.Lgha2HGH-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512230342.Lgha2HGH-lkp@intel.com/

New smatch warnings:
block/blk-settings.c:702 blk_stack_atomic_writes_chunk_sectors() warn: unsigned '*_d' is never less than zero.
block/blk-settings.c:702 blk_stack_atomic_writes_chunk_sectors() warn: unsigned '_a' is never less than zero.
drivers/nvme/host/core.c:3353 nvme_mps_to_sectors() warn: unsigned '*_d' is never less than zero.
drivers/nvme/host/core.c:3353 nvme_mps_to_sectors() warn: unsigned '_a' is never less than zero.

Old smatch warnings:
drivers/nvme/host/core.c:5032 nvme_free_cels() warn: iterator 'i' not incremented

vim +702 block/blk-settings.c

d7f36dc446e894 John Garry 2024-11-18  689  
63d092d1c1b1f7 John Garry 2025-07-11  690  static void blk_stack_atomic_writes_chunk_sectors(struct queue_limits *t)
d7f36dc446e894 John Garry 2024-11-18  691  {
63d092d1c1b1f7 John Garry 2025-07-11  692  	unsigned int chunk_bytes;
d7f36dc446e894 John Garry 2024-11-18  693  
63d092d1c1b1f7 John Garry 2025-07-11  694  	if (!t->chunk_sectors)
63d092d1c1b1f7 John Garry 2025-07-11  695  		return;
63d092d1c1b1f7 John Garry 2025-07-11  696  
63d092d1c1b1f7 John Garry 2025-07-11  697  	/*
63d092d1c1b1f7 John Garry 2025-07-11  698  	 * If chunk sectors is so large that its value in bytes overflows
63d092d1c1b1f7 John Garry 2025-07-11  699  	 * UINT_MAX, then just shift it down so it definitely will fit.
63d092d1c1b1f7 John Garry 2025-07-11  700  	 * We don't support atomic writes of such a large size anyway.
63d092d1c1b1f7 John Garry 2025-07-11  701  	 */
63d092d1c1b1f7 John Garry 2025-07-11 @702  	if (check_shl_overflow(t->chunk_sectors, SECTOR_SHIFT, &chunk_bytes))
63d092d1c1b1f7 John Garry 2025-07-11  703  		chunk_bytes = t->chunk_sectors;
d7f36dc446e894 John Garry 2024-11-18  704  
d7f36dc446e894 John Garry 2024-11-18  705  	/*
d7f36dc446e894 John Garry 2024-11-18  706  	 * Find values for limits which work for chunk size.
d7f36dc446e894 John Garry 2024-11-18  707  	 * b->atomic_write_hw_unit_{min, max} may not be aligned with chunk
63d092d1c1b1f7 John Garry 2025-07-11  708  	 * size, as the chunk size is not restricted to a power-of-2.
d7f36dc446e894 John Garry 2024-11-18  709  	 * So we need to find highest power-of-2 which works for the chunk
d7f36dc446e894 John Garry 2024-11-18  710  	 * size.
63d092d1c1b1f7 John Garry 2025-07-11  711  	 * As an example scenario, we could have t->unit_max = 16K and
63d092d1c1b1f7 John Garry 2025-07-11  712  	 * t->chunk_sectors = 24KB. For this case, reduce t->unit_max to a
63d092d1c1b1f7 John Garry 2025-07-11  713  	 * value aligned with both limits, i.e. 8K in this example.
d7f36dc446e894 John Garry 2024-11-18  714  	 */
63d092d1c1b1f7 John Garry 2025-07-11  715  	t->atomic_write_hw_unit_max = min(t->atomic_write_hw_unit_max,
63d092d1c1b1f7 John Garry 2025-07-11  716  					max_pow_of_two_factor(chunk_bytes));
d7f36dc446e894 John Garry 2024-11-18  717  
63d092d1c1b1f7 John Garry 2025-07-11  718  	t->atomic_write_hw_unit_min = min(t->atomic_write_hw_unit_min,
d7f36dc446e894 John Garry 2024-11-18  719  					  t->atomic_write_hw_unit_max);
63d092d1c1b1f7 John Garry 2025-07-11  720  	t->atomic_write_hw_max = min(t->atomic_write_hw_max, chunk_bytes);
63d092d1c1b1f7 John Garry 2025-07-11  721  }
d7f36dc446e894 John Garry 2024-11-18  722  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

