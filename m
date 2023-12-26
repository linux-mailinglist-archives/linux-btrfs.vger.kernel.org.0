Return-Path: <linux-btrfs+bounces-1137-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6396181E587
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Dec 2023 07:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 135981F22495
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Dec 2023 06:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1E44C3DE;
	Tue, 26 Dec 2023 06:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PyVxD4Mv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A20B4C3BD;
	Tue, 26 Dec 2023 06:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703572669; x=1735108669;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=h30QkdJua341y7XU9tstsZbr98bg+tMNTsxTHbHpPMU=;
  b=PyVxD4MvK1vLJ4TzNR7qu7qlVeECYvN9Hs4PoGI9/mRoawKiKWSMxI4d
   SIdL0tTmrdhCVYNes5RNSCyGqklESwYEj8dGhx4ugdgQoyE15AHDYhu23
   CWSBujCMmZrXgAVL6IcO3+BqvQXTPl6+nAMB9jtVxJN8ZnlyWwyjADZtx
   SdaGGdo8wUDFgGIAM1sx/Alksc8AhPnHYPBZznDZN0bct12/JI5VNYAU6
   cWcTAzISkd8XQM+s7DmjgMg7UOKqrrW2i14nSAZgIK7kjZKjwnkdnNNIU
   KRdHN54kB/2qNXeTjTcw441IDrSxGhAOxcbTR5u+syyHYhQu9EVT9vsJo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="3409955"
X-IronPort-AV: E=Sophos;i="6.04,304,1695711600"; 
   d="scan'208";a="3409955"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2023 22:37:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="806813703"
X-IronPort-AV: E=Sophos;i="6.04,304,1695711600"; 
   d="scan'208";a="806813703"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 25 Dec 2023 22:37:46 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rI14R-000E8r-2M;
	Tue, 26 Dec 2023 06:37:43 +0000
Date: Tue, 26 Dec 2023 14:36:57 +0800
From: kernel test robot <lkp@intel.com>
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	christophe.jaillet@wanadoo.fr, andriy.shevchenko@linux.intel.com,
	David.Laight@aculab.com, ddiss@suse.de
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 2/3] kstrtox: add unit tests for memparse_safe()
Message-ID: <202312261423.zqIlU2hn-lkp@intel.com>
References: <56ea15d8b430f4fe3f8e55509ad0bc72b1d9356f.1703324146.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56ea15d8b430f4fe3f8e55509ad0bc72b1d9356f.1703324146.git.wqu@suse.com>

Hi Qu,

kernel test robot noticed the following build warnings:

[auto build test WARNING on kdave/for-next]
[also build test WARNING on akpm-mm/mm-everything linus/master v6.7-rc7 next-20231222]
[cannot apply to akpm-mm/mm-nonmm-unstable]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Qu-Wenruo/kstrtox-introduce-a-safer-version-of-memparse/20231225-151921
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
patch link:    https://lore.kernel.org/r/56ea15d8b430f4fe3f8e55509ad0bc72b1d9356f.1703324146.git.wqu%40suse.com
patch subject: [PATCH 2/3] kstrtox: add unit tests for memparse_safe()
config: m68k-randconfig-r133-20231226 (https://download.01.org/0day-ci/archive/20231226/202312261423.zqIlU2hn-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231226/202312261423.zqIlU2hn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312261423.zqIlU2hn-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> lib/test-kstrtox.c:339:40: sparse: sparse: cast truncates bits from constant value (efefefef7a7a7a7a becomes 7a7a7a7a)
   lib/test-kstrtox.c:351:39: sparse: sparse: cast truncates bits from constant value (efefefef7a7a7a7a becomes 7a7a7a7a)

vim +339 lib/test-kstrtox.c

   275	
   276	/* Want to include "E" suffix for full coverage. */
   277	#define MEMPARSE_TEST_SUFFIX	(MEMPARSE_SUFFIX_K | MEMPARSE_SUFFIX_M |\
   278					 MEMPARSE_SUFFIX_G | MEMPARSE_SUFFIX_T |\
   279					 MEMPARSE_SUFFIX_P | MEMPARSE_SUFFIX_E)
   280	
   281	static void __init test_memparse_safe_fail(void)
   282	{
   283		struct memparse_test_fail {
   284			const char *str;
   285			/* Expected error number, either -EINVAL or -ERANGE. */
   286			unsigned int expected_ret;
   287		};
   288		static const struct memparse_test_fail tests[] __initconst = {
   289			/* No valid string can be found at all. */
   290			{"", -EINVAL},
   291			{"\n", -EINVAL},
   292			{"\n0", -EINVAL},
   293			{"+", -EINVAL},
   294			{"-", -EINVAL},
   295	
   296			/*
   297			 * No support for any leading "+-" chars, even followed by a valid
   298			 * number.
   299			 */
   300			{"-0", -EINVAL},
   301			{"+0", -EINVAL},
   302			{"-1", -EINVAL},
   303			{"+1", -EINVAL},
   304	
   305			/* Stray suffix would also be rejected. */
   306			{"K", -EINVAL},
   307			{"P", -EINVAL},
   308	
   309			/* Overflow in the string itself*/
   310			{"18446744073709551616", -ERANGE},
   311			{"02000000000000000000000", -ERANGE},
   312			{"0x10000000000000000",	-ERANGE},
   313	
   314			/*
   315			 * Good string but would overflow with suffix.
   316			 *
   317			 * Note, for "E" suffix, one should not use with hex, or "0x1E"
   318			 * would be treated as 0x1e (30 in decimal), not 0x1 and "E" suffix.
   319			 * Another reason "E" suffix is cursed.
   320			 */
   321			{"16E", -ERANGE},
   322			{"020E", -ERANGE},
   323			{"16384P", -ERANGE},
   324			{"040000P", -ERANGE},
   325			{"16777216T", -ERANGE},
   326			{"0100000000T", -ERANGE},
   327			{"17179869184G", -ERANGE},
   328			{"0200000000000G", -ERANGE},
   329			{"17592186044416M", -ERANGE},
   330			{"0400000000000000M", -ERANGE},
   331			{"18014398509481984K", -ERANGE},
   332			{"01000000000000000000K", -ERANGE},
   333		};
   334		unsigned int i;
   335	
   336		for_each_test(i, tests) {
   337			const struct memparse_test_fail *t = &tests[i];
   338			unsigned long long tmp = ULL_PATTERN;
 > 339			char *retptr = (char *)ULL_PATTERN;
   340			int ret;
   341	
   342			ret = memparse_safe(t->str, MEMPARSE_TEST_SUFFIX, &tmp, &retptr);
   343			if (ret != t->expected_ret) {
   344				WARN(1, "str '%s', expected ret %d got %d\n", t->str,
   345				     t->expected_ret, ret);
   346				continue;
   347			}
   348			if (tmp != ULL_PATTERN)
   349				WARN(1, "str '%s' failed as expected, but result got modified",
   350				     t->str);
   351			if (retptr != (char *)ULL_PATTERN)
   352				WARN(1, "str '%s' failed as expected, but pointer got modified",
   353				     t->str);
   354		}
   355	}
   356	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

