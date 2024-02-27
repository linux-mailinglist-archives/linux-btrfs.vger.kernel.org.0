Return-Path: <linux-btrfs+bounces-2826-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17AD98685FA
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Feb 2024 02:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B95C1F2517A
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Feb 2024 01:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25826AB8;
	Tue, 27 Feb 2024 01:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EIdJrt2S"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EE84C9B;
	Tue, 27 Feb 2024 01:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708997710; cv=none; b=M+gon6SqGXvrH0VLJD/iASuJzANumKLe+3UKWLj1osuf3VoNwnifrHdFuVrJC51TLZsCbPHZtqx+z/M73ThVN97ELWcvtJBAXHlBawC//8HGlxM48LunQHg5xU3dD4CDs99f6iONKmVldAeRH/taqqd74ANLfrIKH0wC2ZW/0Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708997710; c=relaxed/simple;
	bh=I4qbGa1x1CoD5kBOxiBqkFTCRyoMQhZk9v2T6sCcWaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ubo69MVLXjG9sEbpzdpC3I+If73irYS9VABMVz4Upt7Z+hWuEiiZYZM3dfMZc6rS9RCH7LDoULc4LCUCzdiFWU/mSWwAxum6XQ/C5pg2HWybLCRfKHF0WkcoyBzXcmQcYdhONxw+pRuI9mvzjb2KirTuRqNngG4lOyDYUqg1GpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EIdJrt2S; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708997708; x=1740533708;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I4qbGa1x1CoD5kBOxiBqkFTCRyoMQhZk9v2T6sCcWaQ=;
  b=EIdJrt2SFctd8f6JU0tYY8NaeZT6YaxZv3uiN0t/1MwlRQYXVWIsGi55
   h+VbPwvwWdNIk9kzkhFSkAp1x4xZBlpAUKIuVO55agnNW542EVZsC1Gaz
   LogpP4vE+7PmgxiABd3fhYaewqVGEVUEpZNWEbv07uwbus2Ibm0kk04R2
   hAtkqEVfccssrZeFth7uh4xFqWVRwb0CUu2fCh0bU9xuGv6Wnt59InNx3
   nQKwvSiLZvMAYoe/bPJsFthzaZVonckwFEbVfINGJY3c2PZm0q7BR3ujl
   kNHYT/MB/0ByUTFCBT4oJVCjyN9nREFvknc0rm4pu7dDXxm73kNkIJVhN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="14757284"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="14757284"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 17:35:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="7406508"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 26 Feb 2024 17:35:02 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1remN1-000Apj-0j;
	Tue, 27 Feb 2024 01:34:59 +0000
Date: Tue, 27 Feb 2024 09:34:25 +0800
From: kernel test robot <lkp@intel.com>
To: David Laight <David.Laight@aculab.com>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
	'Linus Torvalds' <torvalds@linux-foundation.org>,
	'Netdev' <netdev@vger.kernel.org>,
	"'dri-devel@lists.freedesktop.org'" <dri-devel@lists.freedesktop.org>
Cc: oe-kbuild-all@lists.linux.dev, 'Jens Axboe' <axboe@kernel.dk>,
	"'Matthew Wilcox (Oracle)'" <willy@infradead.org>,
	'Christoph Hellwig' <hch@infradead.org>,
	"'linux-btrfs@vger.kernel.org'" <linux-btrfs@vger.kernel.org>,
	'Andrew Morton' <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>,
	"'David S . Miller'" <davem@davemloft.net>,
	'Dan Carpenter' <dan.carpenter@linaro.org>,
	'Jani Nikula' <jani.nikula@linux.intel.com>
Subject: Re: [PATCH next v2 03/11] minmax: Simplify signedness check
Message-ID: <202402270937.9kmO5PFt-lkp@intel.com>
References: <8657dd5c2264456f8a005520a3b90e2b@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8657dd5c2264456f8a005520a3b90e2b@AcuMS.aculab.com>

Hi David,

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm-misc/drm-misc-next]
[also build test WARNING on linux/master mkl-can-next/testing kdave/for-next akpm-mm/mm-nonmm-unstable axboe-block/for-next linus/master v6.8-rc6 next-20240226]
[cannot apply to next-20240223 dtor-input/next dtor-input/for-linus horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Laight/minmax-Put-all-the-clamp-definitions-together/20240226-005902
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/8657dd5c2264456f8a005520a3b90e2b%40AcuMS.aculab.com
patch subject: [PATCH next v2 03/11] minmax: Simplify signedness check
config: alpha-defconfig (https://download.01.org/0day-ci/archive/20240227/202402270937.9kmO5PFt-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240227/202402270937.9kmO5PFt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402270937.9kmO5PFt-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/kernel.h:28,
                    from include/linux/cpumask.h:10,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:63,
                    from include/linux/swait.h:7,
                    from include/linux/completion.h:12,
                    from include/linux/crypto.h:15,
                    from include/crypto/aead.h:13,
                    from include/crypto/internal/aead.h:11,
                    from crypto/skcipher.c:12:
   crypto/skcipher.c: In function 'skcipher_get_spot':
>> include/linux/minmax.h:31:70: warning: ordered comparison of pointer with integer zero [-Wextra]
      31 |         (is_unsigned_type(typeof(x)) || (__is_constexpr(x) ? (x) + 0 >= 0 : 0))
         |                                                                      ^~
   include/linux/minmax.h:39:11: note: in expansion of macro '__is_ok_unsigned'
      39 |          (__is_ok_unsigned(x) && __is_ok_unsigned(y)))
         |           ^~~~~~~~~~~~~~~~
   include/linux/minmax.h:49:24: note: in expansion of macro '__types_ok'
      49 |         _Static_assert(__types_ok(x, y),                        \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:56:17: note: in expansion of macro '__cmp_once'
      56 |                 __cmp_once(op, x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y)))
         |                 ^~~~~~~~~~
   include/linux/minmax.h:70:25: note: in expansion of macro '__careful_cmp'
      70 | #define max(x, y)       __careful_cmp(max, x, y)
         |                         ^~~~~~~~~~~~~
   crypto/skcipher.c:83:16: note: in expansion of macro 'max'
      83 |         return max(start, end_page);
         |                ^~~
>> include/linux/minmax.h:31:70: warning: ordered comparison of pointer with integer zero [-Wextra]
      31 |         (is_unsigned_type(typeof(x)) || (__is_constexpr(x) ? (x) + 0 >= 0 : 0))
         |                                                                      ^~
   include/linux/minmax.h:39:34: note: in expansion of macro '__is_ok_unsigned'
      39 |          (__is_ok_unsigned(x) && __is_ok_unsigned(y)))
         |                                  ^~~~~~~~~~~~~~~~
   include/linux/minmax.h:49:24: note: in expansion of macro '__types_ok'
      49 |         _Static_assert(__types_ok(x, y),                        \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:56:17: note: in expansion of macro '__cmp_once'
      56 |                 __cmp_once(op, x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y)))
         |                 ^~~~~~~~~~
   include/linux/minmax.h:70:25: note: in expansion of macro '__careful_cmp'
      70 | #define max(x, y)       __careful_cmp(max, x, y)
         |                         ^~~~~~~~~~~~~
   crypto/skcipher.c:83:16: note: in expansion of macro 'max'
      83 |         return max(start, end_page);
         |                ^~~


vim +31 include/linux/minmax.h

     9	
    10	/*
    11	 * min()/max()/clamp() macros must accomplish several things:
    12	 *
    13	 * - Avoid multiple evaluations of the arguments (so side-effects like
    14	 *   "x++" happen only once) when non-constant.
    15	 * - Retain result as a constant expressions when called with only
    16	 *   constant expressions (to avoid tripping VLA warnings in stack
    17	 *   allocation usage).
    18	 * - Perform signed v unsigned type-checking (to generate compile
    19	 *   errors instead of nasty runtime surprises).
    20	 * - Unsigned char/short are always promoted to signed int and can be
    21	 *   compared against signed or unsigned arguments.
    22	 * - Unsigned arguments can be compared against non-negative signed constants.
    23	 * - Comparison of a signed argument against an unsigned constant fails
    24	 *   even if the constant is below __INT_MAX__ and could be cast to int.
    25	 */
    26	#define __typecheck(x, y) \
    27		(!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
    28	
    29	/* Allow unsigned compares against non-negative signed constants. */
    30	#define __is_ok_unsigned(x) \
  > 31		(is_unsigned_type(typeof(x)) || (__is_constexpr(x) ? (x) + 0 >= 0 : 0))
    32	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

