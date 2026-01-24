Return-Path: <linux-btrfs+bounces-20979-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Nt3IOHVdGlc+QAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20979-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Jan 2026 15:23:29 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB2E7DCA1
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Jan 2026 15:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DD290301A15B
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Jan 2026 14:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9254332143E;
	Sat, 24 Jan 2026 14:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hdXsdJ2a"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBCE320CB3
	for <linux-btrfs@vger.kernel.org>; Sat, 24 Jan 2026 14:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769264600; cv=none; b=ds1GI5IaKWpUNIVLwgPUu+FJaE6rfKpe3FYksaSP4beu0rQJtus4yR625+iUQE1M4fUclts4E9bNR27tO/fECZUl3+pOYRaqyQgAzZKhwuxN+59JUDIPjzqTjBY1cQFP99E0afQtEerU/NImbGMm+vpuwnZ/qNboTVpvJSVW1L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769264600; c=relaxed/simple;
	bh=g/A8GVDKd6dDGFqUGzMaCJIEbE2VW77Gso2vo6ixcg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cinw8jVaV0fu/8k11qE2j2LmAKrfQz9yfJEE/5IkJZ5zjTGUrfFP+Dg8j1AN05tc0ZZ7LWICzyyfVBMw2T5FoBnT2vCQxQvKUGshcX+PSY/9b+dxVRoFvrCSVY4rXu/JCVSeMtvukB9URqCEu9WhfaSe3nAi0mj3kemb7u1Ej2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hdXsdJ2a; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769264599; x=1800800599;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=g/A8GVDKd6dDGFqUGzMaCJIEbE2VW77Gso2vo6ixcg0=;
  b=hdXsdJ2a65HKunbRcTogPZ1D7584r4utFfssBOlbSVxOgGbWT+s7SUVE
   OjwinrnB16oJ0vohB14rq0zr531yPWsD6wRbVU3KoPJmlgsEzWCMzj3ZR
   xf8IRVLD3Na4F4DL/Bmkle5AB6mi0BqWhPLmlE+WcEz+Ve7kqezfjdUPF
   hTo/l4N4USyP/hvwD8NApaXEuTgX1WBRn+naZd8cai5vBqf3UYgFstOP5
   fRBflGSmJD1B/fzFzDSRVAsvOfyarjIQpulHccS05IB49vWwsVIe9HV8P
   fqxyqI1P6VoFBvTbpViIxzqQqkpfgiI8mAajC7drvscRAEzgGf1ycxIsA
   w==;
X-CSE-ConnectionGUID: ZzRBmm6BQT+w52hapMZ77g==
X-CSE-MsgGUID: cWWub5NiQZeOK6y5eR0reQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11681"; a="81860910"
X-IronPort-AV: E=Sophos;i="6.21,250,1763452800"; 
   d="scan'208";a="81860910"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2026 06:23:18 -0800
X-CSE-ConnectionGUID: 1Me6drxfTLmwjA9ltI8q5Q==
X-CSE-MsgGUID: M9gqQZY5Si6tB4OVtEAFrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,250,1763452800"; 
   d="scan'208";a="207079696"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 24 Jan 2026 06:23:17 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vjeXi-00000000VF8-0E5w;
	Sat, 24 Jan 2026 14:23:14 +0000
Date: Sat, 24 Jan 2026 22:22:45 +0800
From: kernel test robot <lkp@intel.com>
To: Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Naohiro Aota <naohiro.aota@wdc.com>
Subject: Re: [PATCH 4/4] btrfs: tests: zoned: add selftest for zoned code
Message-ID: <202601242218.d7G9ZivU-lkp@intel.com>
References: <20260123125920.4129581-5-naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123125920.4129581-5-naohiro.aota@wdc.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-20979-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,git-scm.com:url,intel.com:email,intel.com:dkim,intel.com:mid,01.org:url]
X-Rspamd-Queue-Id: 6DB2E7DCA1
X-Rspamd-Action: no action

Hi Naohiro,

kernel test robot noticed the following build warnings:

[auto build test WARNING on kdave/for-next]
[also build test WARNING on next-20260123]
[cannot apply to linus/master v6.19-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Naohiro-Aota/btrfs-tests-add-cleanup-functions-for-test-specific-functions/20260123-210300
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
patch link:    https://lore.kernel.org/r/20260123125920.4129581-5-naohiro.aota%40wdc.com
patch subject: [PATCH 4/4] btrfs: tests: zoned: add selftest for zoned code
config: um-randconfig-r133-20260124 (https://download.01.org/0day-ci/archive/20260124/202601242218.d7G9ZivU-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.4.0-5) 12.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260124/202601242218.d7G9ZivU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601242218.d7G9ZivU-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> fs/btrfs/tests/zoned-tests.c:107:35: sparse: sparse: symbol 'load_zone_info_tests' was not declared. Should it be static?

vim +/load_zone_info_tests +107 fs/btrfs/tests/zoned-tests.c

   106	
 > 107	struct load_zone_info_test_vector load_zone_info_tests[] = {
   108		/* SINGLE */
   109		{
   110			.description = "SINGLE: load write pointer from sequential zone",
   111			.raid_type = 0,
   112			.num_stripes = 1,
   113			.alloc_offsets = {
   114				SZ_1M,
   115			},
   116			.expected_alloc_offset = SZ_1M,
   117		},
   118		/*
   119		 * SINGLE block group on a conventional zone sets last_alloc outside of
   120		 * btrfs_load_block_group_*(). Do not test that case.
   121		 */
   122	
   123		/* DUP */
   124		/* Normal case */
   125		{
   126			.description = "DUP: having matching write pointers",
   127			.raid_type = BTRFS_BLOCK_GROUP_DUP,
   128			.num_stripes = 2,
   129			.alloc_offsets = {
   130				SZ_1M, SZ_1M,
   131			},
   132			.expected_alloc_offset = SZ_1M,
   133		},
   134		/*
   135		 * One sequential zone and one conventional zone, having matching
   136		 * last_alloc.
   137		 */
   138		{
   139			.description = "DUP: seq zone and conv zone, matching last_alloc",
   140			.raid_type = BTRFS_BLOCK_GROUP_DUP,
   141			.num_stripes = 2,
   142			.alloc_offsets = {
   143				SZ_1M, WP_CONVENTIONAL,
   144			},
   145			.last_alloc = SZ_1M,
   146			.expected_alloc_offset = SZ_1M,
   147		},
   148		/*
   149		 * One sequential and one conventional zone, but having smaller
   150		 * last_alloc than write pointer.
   151		 */
   152		{
   153			.description = "DUP: seq zone and conv zone, smaller last_alloc",
   154			.raid_type = BTRFS_BLOCK_GROUP_DUP,
   155			.num_stripes = 2,
   156			.alloc_offsets = {
   157				SZ_1M, WP_CONVENTIONAL,
   158			},
   159			.last_alloc = 0,
   160			.expected_alloc_offset = SZ_1M,
   161		},
   162		/* Error case: having different write pointers. */
   163		{
   164			.description = "DUP: fail: different write pointers",
   165			.raid_type = BTRFS_BLOCK_GROUP_DUP,
   166			.num_stripes = 2,
   167			.alloc_offsets = {
   168				SZ_1M, SZ_2M,
   169			},
   170			.expected_result = -EIO,
   171		},
   172		/* Error case: partial missing device should not happen on DUP. */
   173		{
   174			.description = "DUP: fail: missing device",
   175			.raid_type = BTRFS_BLOCK_GROUP_DUP,
   176			.num_stripes = 2,
   177			.alloc_offsets = {
   178				SZ_1M, WP_MISSING_DEV,
   179			},
   180			.expected_result = -EIO,
   181		},
   182		/*
   183		 * Error case: one sequential and one conventional zone, but having larger
   184		 * last_alloc than write pointer.
   185		 */
   186		{
   187			.description = "DUP: fail: seq zone and conv zone, larger last_alloc",
   188			.raid_type = BTRFS_BLOCK_GROUP_DUP,
   189			.num_stripes = 2,
   190			.alloc_offsets = {
   191				SZ_1M, WP_CONVENTIONAL,
   192			},
   193			.last_alloc = SZ_2M,
   194			.expected_result = -EIO,
   195		},
   196	
   197		/* RAID1 */
   198		/* Normal case */
   199		{
   200			.description = "RAID1: having matching write pointers",
   201			.raid_type = BTRFS_BLOCK_GROUP_RAID1,
   202			.num_stripes = 2,
   203			.alloc_offsets = {
   204				SZ_1M, SZ_1M,
   205			},
   206			.expected_alloc_offset = SZ_1M,
   207		},
   208		/*
   209		 * One sequential zone and one conventional zone, having matching
   210		 * last_alloc.
   211		 */
   212		{
   213			.description = "RAID1: seq zone and conv zone, matching last_alloc",
   214			.raid_type = BTRFS_BLOCK_GROUP_RAID1,
   215			.num_stripes = 2,
   216			.alloc_offsets = {
   217				SZ_1M, WP_CONVENTIONAL,
   218			},
   219			.last_alloc = SZ_1M,
   220			.expected_alloc_offset = SZ_1M,
   221		},
   222		/*
   223		 * One sequential and one conventional zone, but having smaller
   224		 * last_alloc than write pointer.
   225		 */
   226		{
   227			.description = "RAID1: seq zone and conv zone, smaller last_alloc",
   228			.raid_type = BTRFS_BLOCK_GROUP_RAID1,
   229			.num_stripes = 2,
   230			.alloc_offsets = {
   231				SZ_1M, WP_CONVENTIONAL,
   232			},
   233			.last_alloc = 0,
   234			.expected_alloc_offset = SZ_1M,
   235		},
   236		/* Partial missing device should be recovered on DEGRADED mount */
   237		{
   238			.description = "RAID1: fail: missing device on DEGRADED",
   239			.raid_type = BTRFS_BLOCK_GROUP_RAID1,
   240			.num_stripes = 2,
   241			.alloc_offsets = {
   242				SZ_1M, WP_MISSING_DEV,
   243			},
   244			.degraded = true,
   245			.expected_alloc_offset = SZ_1M,
   246		},
   247		/* Error case: having different write pointers. */
   248		{
   249			.description = "RAID1: fail: different write pointers",
   250			.raid_type = BTRFS_BLOCK_GROUP_RAID1,
   251			.num_stripes = 2,
   252			.alloc_offsets = {
   253				SZ_1M, SZ_2M,
   254			},
   255			.expected_result = -EIO,
   256		},
   257		/*
   258		 * Partial missing device is not allowed on non-DEGRADED mount never happen
   259		 * as it is rejected beforehand.
   260		 */
   261		/*
   262		 * Error case: one sequential and one conventional zone, but having larger
   263		 * last_alloc than write pointer.
   264		 */
   265		{
   266			.description = "RAID1: fail: seq zone and conv zone, larger last_alloc",
   267			.raid_type = BTRFS_BLOCK_GROUP_RAID1,
   268			.num_stripes = 2,
   269			.alloc_offsets = {
   270				SZ_1M, WP_CONVENTIONAL,
   271			},
   272			.last_alloc = SZ_2M,
   273			.expected_result = -EIO,
   274		},
   275	
   276		/* RAID0 */
   277		/* Normal case */
   278		{
   279			.description = "RAID0: initial partial write",
   280			.raid_type = BTRFS_BLOCK_GROUP_RAID0,
   281			.num_stripes = 4,
   282			.alloc_offsets = {
   283				HALF_STRIPE_LEN, 0, 0, 0,
   284			},
   285			.expected_alloc_offset = HALF_STRIPE_LEN,
   286		},
   287		{
   288			.description = "RAID0: while in second stripe",
   289			.raid_type = BTRFS_BLOCK_GROUP_RAID0,
   290			.num_stripes = 4,
   291			.alloc_offsets = {
   292				BTRFS_STRIPE_LEN * 2, BTRFS_STRIPE_LEN + HALF_STRIPE_LEN,
   293				BTRFS_STRIPE_LEN, BTRFS_STRIPE_LEN,
   294			},
   295			.expected_alloc_offset = BTRFS_STRIPE_LEN * 5 + HALF_STRIPE_LEN,
   296		},
   297		{
   298			.description = "RAID0: one stripe advanced",
   299			.raid_type = BTRFS_BLOCK_GROUP_RAID0,
   300			.num_stripes = 2,
   301			.alloc_offsets = {
   302				SZ_1M + BTRFS_STRIPE_LEN, SZ_1M,
   303			},
   304			.expected_alloc_offset = SZ_2M + BTRFS_STRIPE_LEN,
   305		},
   306		/* Error case: having different write pointers. */
   307		{
   308			.description = "RAID0: fail: disordered stripes",
   309			.raid_type = BTRFS_BLOCK_GROUP_RAID0,
   310			.num_stripes = 4,
   311			.alloc_offsets = {
   312				BTRFS_STRIPE_LEN, BTRFS_STRIPE_LEN * 2,
   313				BTRFS_STRIPE_LEN, BTRFS_STRIPE_LEN,
   314			},
   315			.expected_result = -EIO,
   316		},
   317		{
   318			.description = "RAID0: fail: far distance",
   319			.raid_type = BTRFS_BLOCK_GROUP_RAID0,
   320			.num_stripes = 4,
   321			.alloc_offsets = {
   322				BTRFS_STRIPE_LEN * 3, BTRFS_STRIPE_LEN,
   323				BTRFS_STRIPE_LEN, BTRFS_STRIPE_LEN,
   324			},
   325			.expected_result = -EIO,
   326		},
   327		{
   328			.description = "RAID0: fail: too many partial write",
   329			.raid_type = BTRFS_BLOCK_GROUP_RAID0,
   330			.num_stripes = 4,
   331			.alloc_offsets = {
   332				HALF_STRIPE_LEN, HALF_STRIPE_LEN, 0, 0,
   333			},
   334			.expected_result = -EIO,
   335		},
   336		/*
   337		 * Error case: Partial missing device is not allowed even on non-DEGRADED
   338		 * mount.
   339		 */
   340		{
   341			.description = "RAID0: fail: missing device on DEGRADED",
   342			.raid_type = BTRFS_BLOCK_GROUP_RAID0,
   343			.num_stripes = 2,
   344			.alloc_offsets = {
   345				SZ_1M, WP_MISSING_DEV,
   346			},
   347			.degraded = true,
   348			.expected_result = -EIO,
   349		},
   350	
   351		/*
   352		 * One sequential zone and one conventional zone, having matching
   353		 * last_alloc.
   354		 */
   355		{
   356			.description = "RAID0: seq zone and conv zone, partially written stripe",
   357			.raid_type = BTRFS_BLOCK_GROUP_RAID0,
   358			.num_stripes = 2,
   359			.alloc_offsets = {
   360				SZ_1M, WP_CONVENTIONAL,
   361			},
   362			.last_alloc = SZ_2M - SZ_4K,
   363			.expected_alloc_offset = SZ_2M - SZ_4K,
   364		},
   365		{
   366			.description = "RAID0: conv zone and seq zone, partially written stripe",
   367			.raid_type = BTRFS_BLOCK_GROUP_RAID0,
   368			.num_stripes = 2,
   369			.alloc_offsets = {
   370				WP_CONVENTIONAL, SZ_1M,
   371			},
   372			.last_alloc = SZ_2M + SZ_4K,
   373			.expected_alloc_offset = SZ_2M + SZ_4K,
   374		},
   375		/*
   376		 * Error case: one sequential and one conventional zone, but having larger
   377		 * last_alloc than write pointer.
   378		 */
   379		{
   380			.description = "RAID0: fail: seq zone and conv zone, larger last_alloc",
   381			.raid_type = BTRFS_BLOCK_GROUP_RAID0,
   382			.num_stripes = 2,
   383			.alloc_offsets = {
   384				SZ_1M, WP_CONVENTIONAL,
   385			},
   386			.last_alloc = SZ_2M + BTRFS_STRIPE_LEN * 2,
   387			.expected_result = -EIO,
   388		},
   389	
   390		/* RAID0, 4 stripes with seq zones and conv zones. */
   391		{
   392			.description = "RAID0: stripes [2, 2, ?, ?] last_alloc = 6",
   393			.raid_type = BTRFS_BLOCK_GROUP_RAID0,
   394			.num_stripes = 4,
   395			.alloc_offsets = {
   396				BTRFS_STRIPE_LEN * 2, BTRFS_STRIPE_LEN * 2,
   397				WP_CONVENTIONAL, WP_CONVENTIONAL,
   398			},
   399			.last_alloc = BTRFS_STRIPE_LEN * 6,
   400			.expected_alloc_offset = BTRFS_STRIPE_LEN * 6,
   401		},
   402		{
   403			.description = "RAID0: stripes [2, 2, ?, ?] last_alloc = 7.5",
   404			.raid_type = BTRFS_BLOCK_GROUP_RAID0,
   405			.num_stripes = 4,
   406			.alloc_offsets = {
   407				BTRFS_STRIPE_LEN * 2, BTRFS_STRIPE_LEN * 2,
   408				WP_CONVENTIONAL, WP_CONVENTIONAL,
   409			},
   410			.last_alloc = BTRFS_STRIPE_LEN * 7 + HALF_STRIPE_LEN,
   411			.expected_alloc_offset = BTRFS_STRIPE_LEN * 7 + HALF_STRIPE_LEN,
   412		},
   413		{
   414			.description = "RAID0: stripes [3, ?, ?, ?] last_alloc = 1",
   415			.raid_type = BTRFS_BLOCK_GROUP_RAID0,
   416			.num_stripes = 4,
   417			.alloc_offsets = {
   418				BTRFS_STRIPE_LEN * 3, WP_CONVENTIONAL,
   419				WP_CONVENTIONAL, WP_CONVENTIONAL,
   420			},
   421			.last_alloc = BTRFS_STRIPE_LEN,
   422			.expected_alloc_offset = BTRFS_STRIPE_LEN * 9,
   423		},
   424		{
   425			.description = "RAID0: stripes [2, ?, 1, ?] last_alloc = 5",
   426			.raid_type = BTRFS_BLOCK_GROUP_RAID0,
   427			.num_stripes = 4,
   428			.alloc_offsets = {
   429				BTRFS_STRIPE_LEN * 2, WP_CONVENTIONAL,
   430				BTRFS_STRIPE_LEN, WP_CONVENTIONAL,
   431			},
   432			.last_alloc = BTRFS_STRIPE_LEN * 5,
   433			.expected_alloc_offset = BTRFS_STRIPE_LEN * 5,
   434		},
   435		{
   436			.description = "RAID0: fail: stripes [2, ?, 1, ?] last_alloc = 7",
   437			.raid_type = BTRFS_BLOCK_GROUP_RAID0,
   438			.num_stripes = 4,
   439			.alloc_offsets = {
   440				BTRFS_STRIPE_LEN * 2, WP_CONVENTIONAL,
   441				BTRFS_STRIPE_LEN, WP_CONVENTIONAL,
   442			},
   443			.last_alloc = BTRFS_STRIPE_LEN * 7,
   444			.expected_result = -EIO,
   445		},
   446	
   447		/* RAID10 */
   448		/* Normal case */
   449		{
   450			.description = "RAID10: initial partial write",
   451			.raid_type = BTRFS_BLOCK_GROUP_RAID10,
   452			.num_stripes = 4,
   453			.alloc_offsets = {
   454				HALF_STRIPE_LEN, HALF_STRIPE_LEN, 0, 0,
   455			},
   456			.expected_alloc_offset = HALF_STRIPE_LEN,
   457		},
   458		{
   459			.description = "RAID10: while in second stripe",
   460			.raid_type = BTRFS_BLOCK_GROUP_RAID10,
   461			.num_stripes = 8,
   462			.alloc_offsets = {
   463				BTRFS_STRIPE_LEN * 2, BTRFS_STRIPE_LEN * 2,
   464				BTRFS_STRIPE_LEN + HALF_STRIPE_LEN,
   465				BTRFS_STRIPE_LEN + HALF_STRIPE_LEN,
   466				BTRFS_STRIPE_LEN, BTRFS_STRIPE_LEN,
   467				BTRFS_STRIPE_LEN, BTRFS_STRIPE_LEN,
   468			},
   469			.expected_alloc_offset = BTRFS_STRIPE_LEN * 5 + HALF_STRIPE_LEN,
   470		},
   471		{
   472			.description = "RAID10: one stripe advanced",
   473			.raid_type = BTRFS_BLOCK_GROUP_RAID10,
   474			.num_stripes = 4,
   475			.alloc_offsets = {
   476				SZ_1M + BTRFS_STRIPE_LEN, SZ_1M + BTRFS_STRIPE_LEN,
   477				SZ_1M, SZ_1M,
   478			},
   479			.expected_alloc_offset = SZ_2M + BTRFS_STRIPE_LEN,
   480		},
   481		{
   482			.description = "RAID10: one stripe advanced, with conventional zone",
   483			.raid_type = BTRFS_BLOCK_GROUP_RAID10,
   484			.num_stripes = 4,
   485			.alloc_offsets = {
   486				SZ_1M + BTRFS_STRIPE_LEN, WP_CONVENTIONAL,
   487				WP_CONVENTIONAL, SZ_1M,
   488			},
   489			.expected_alloc_offset = SZ_2M + BTRFS_STRIPE_LEN,
   490		},
   491		/* Error case: having different write pointers. */
   492		{
   493			.description = "RAID10: fail: disordered stripes",
   494			.raid_type = BTRFS_BLOCK_GROUP_RAID10,
   495			.num_stripes = 8,
   496			.alloc_offsets = {
   497				BTRFS_STRIPE_LEN, BTRFS_STRIPE_LEN,
   498				BTRFS_STRIPE_LEN * 2, BTRFS_STRIPE_LEN * 2,
   499				BTRFS_STRIPE_LEN, BTRFS_STRIPE_LEN,
   500				BTRFS_STRIPE_LEN, BTRFS_STRIPE_LEN,
   501			},
   502			.expected_result = -EIO,
   503		},
   504		{
   505			.description = "RAID10: fail: far distance",
   506			.raid_type = BTRFS_BLOCK_GROUP_RAID10,
   507			.num_stripes = 8,
   508			.alloc_offsets = {
   509				BTRFS_STRIPE_LEN * 3, BTRFS_STRIPE_LEN * 3,
   510				BTRFS_STRIPE_LEN, BTRFS_STRIPE_LEN,
   511				BTRFS_STRIPE_LEN, BTRFS_STRIPE_LEN,
   512				BTRFS_STRIPE_LEN, BTRFS_STRIPE_LEN,
   513			},
   514			.expected_result = -EIO,
   515		},
   516		{
   517			.description = "RAID10: fail: too many partial write",
   518			.raid_type = BTRFS_BLOCK_GROUP_RAID10,
   519			.num_stripes = 8,
   520			.alloc_offsets = {
   521				HALF_STRIPE_LEN, HALF_STRIPE_LEN,
   522				HALF_STRIPE_LEN, HALF_STRIPE_LEN,
   523				0, 0, 0, 0,
   524			},
   525			.expected_result = -EIO,
   526		},
   527		/*
   528		 * Error case: Partial missing device in RAID0 level is not allowed even on
   529		 * non-DEGRADED mount.
   530		 */
   531		{
   532			.description = "RAID10: fail: missing device on DEGRADED",
   533			.raid_type = BTRFS_BLOCK_GROUP_RAID10,
   534			.num_stripes = 4,
   535			.alloc_offsets = {
   536				SZ_1M, SZ_1M,
   537				WP_MISSING_DEV, WP_MISSING_DEV,
   538			},
   539			.degraded = true,
   540			.expected_result = -EIO,
   541		},
   542	
   543		/*
   544		 * One sequential zone and one conventional zone, having matching
   545		 * last_alloc.
   546		 */
   547		{
   548			.description = "RAID10: seq zone and conv zone, partially written stripe",
   549			.raid_type = BTRFS_BLOCK_GROUP_RAID10,
   550			.num_stripes = 4,
   551			.alloc_offsets = {
   552				SZ_1M, SZ_1M,
   553				WP_CONVENTIONAL, WP_CONVENTIONAL,
   554			},
   555			.last_alloc = SZ_2M - SZ_4K,
   556			.expected_alloc_offset = SZ_2M - SZ_4K,
   557		},
   558		{
   559			.description = "RAID10: conv zone and seq zone, partially written stripe",
   560			.raid_type = BTRFS_BLOCK_GROUP_RAID10,
   561			.num_stripes = 4,
   562			.alloc_offsets = {
   563				WP_CONVENTIONAL, WP_CONVENTIONAL,
   564				SZ_1M, SZ_1M,
   565			},
   566			.last_alloc = SZ_2M + SZ_4K,
   567			.expected_alloc_offset = SZ_2M + SZ_4K,
   568		},
   569		/*
   570		 * Error case: one sequential and one conventional zone, but having larger
   571		 * last_alloc than write pointer.
   572		 */
   573		{
   574			.description = "RAID10: fail: seq zone and conv zone, larger last_alloc",
   575			.raid_type = BTRFS_BLOCK_GROUP_RAID10,
   576			.num_stripes = 4,
   577			.alloc_offsets = {
   578				SZ_1M, SZ_1M,
   579				WP_CONVENTIONAL, WP_CONVENTIONAL,
   580			},
   581			.last_alloc = SZ_2M + BTRFS_STRIPE_LEN * 2,
   582			.expected_result = -EIO,
   583		},
   584	
   585		/* RAID10, 4 stripes with seq zones and conv zones. */
   586		{
   587			.description = "RAID10: stripes [2, 2, ?, ?] last_alloc = 6",
   588			.raid_type = BTRFS_BLOCK_GROUP_RAID10,
   589			.num_stripes = 8,
   590			.alloc_offsets = {
   591				BTRFS_STRIPE_LEN * 2, BTRFS_STRIPE_LEN * 2,
   592				BTRFS_STRIPE_LEN * 2, BTRFS_STRIPE_LEN * 2,
   593				WP_CONVENTIONAL, WP_CONVENTIONAL,
   594				WP_CONVENTIONAL, WP_CONVENTIONAL,
   595			},
   596			.last_alloc = BTRFS_STRIPE_LEN * 6,
   597			.expected_alloc_offset = BTRFS_STRIPE_LEN * 6,
   598		},
   599		{
   600			.description = "RAID10: stripes [2, 2, ?, ?] last_alloc = 7.5",
   601			.raid_type = BTRFS_BLOCK_GROUP_RAID10,
   602			.num_stripes = 8,
   603			.alloc_offsets = {
   604				BTRFS_STRIPE_LEN * 2, BTRFS_STRIPE_LEN * 2,
   605				BTRFS_STRIPE_LEN * 2, BTRFS_STRIPE_LEN * 2,
   606				WP_CONVENTIONAL, WP_CONVENTIONAL,
   607				WP_CONVENTIONAL, WP_CONVENTIONAL,
   608			},
   609			.last_alloc = BTRFS_STRIPE_LEN * 7 + HALF_STRIPE_LEN,
   610			.expected_alloc_offset = BTRFS_STRIPE_LEN * 7 + HALF_STRIPE_LEN,
   611		},
   612		{
   613			.description = "RAID10: stripes [3, ?, ?, ?] last_alloc = 1",
   614			.raid_type = BTRFS_BLOCK_GROUP_RAID10,
   615			.num_stripes = 8,
   616			.alloc_offsets = {
   617				BTRFS_STRIPE_LEN * 3, BTRFS_STRIPE_LEN * 3,
   618				WP_CONVENTIONAL, WP_CONVENTIONAL,
   619				WP_CONVENTIONAL, WP_CONVENTIONAL,
   620				WP_CONVENTIONAL, WP_CONVENTIONAL,
   621			},
   622			.last_alloc = BTRFS_STRIPE_LEN,
   623			.expected_alloc_offset = BTRFS_STRIPE_LEN * 9,
   624		},
   625		{
   626			.description = "RAID10: stripes [2, ?, 1, ?] last_alloc = 5",
   627			.raid_type = BTRFS_BLOCK_GROUP_RAID10,
   628			.num_stripes = 8,
   629			.alloc_offsets = {
   630				BTRFS_STRIPE_LEN * 2, BTRFS_STRIPE_LEN * 2,
   631				WP_CONVENTIONAL, WP_CONVENTIONAL,
   632				BTRFS_STRIPE_LEN, BTRFS_STRIPE_LEN,
   633				WP_CONVENTIONAL, WP_CONVENTIONAL,
   634			},
   635			.last_alloc = BTRFS_STRIPE_LEN * 5,
   636			.expected_alloc_offset = BTRFS_STRIPE_LEN * 5,
   637		},
   638		{
   639			.description = "RAID10: fail: stripes [2, ?, 1, ?] last_alloc = 7",
   640			.raid_type = BTRFS_BLOCK_GROUP_RAID10,
   641			.num_stripes = 8,
   642			.alloc_offsets = {
   643				BTRFS_STRIPE_LEN * 2, BTRFS_STRIPE_LEN * 2,
   644				WP_CONVENTIONAL, WP_CONVENTIONAL,
   645				BTRFS_STRIPE_LEN, BTRFS_STRIPE_LEN,
   646				WP_CONVENTIONAL, WP_CONVENTIONAL,
   647			},
   648			.last_alloc = BTRFS_STRIPE_LEN * 7,
   649			.expected_result = -EIO,
   650		},
   651	};
   652	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

