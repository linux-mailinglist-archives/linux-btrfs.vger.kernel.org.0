Return-Path: <linux-btrfs+bounces-4248-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B14348A4716
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Apr 2024 04:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28AC61F21C30
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Apr 2024 02:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8766B182B5;
	Mon, 15 Apr 2024 02:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mdAyfH1m"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DAD17F8
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Apr 2024 02:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713149298; cv=fail; b=Dr4BdGJUWhfULePFrqybaXIhVv4cpDqS2PurKtu8jMKN6CeXgrPt7mG99V5bohCF+iCtif6CgJOGl+COUn2ROAm7pX5Q0CI0jtPkxwYy8lAdS4kVOGo2K1YPCUGlrfgAkrB4buHQybk96UaqQGXYjnKEtrk/qbWgWEJfumhCZ8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713149298; c=relaxed/simple;
	bh=7Mfvjwy39GCqwbYfAcs5so6KJ06dlJod5tRCzKNpFEY=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gFuTQazvSpYQhZsOJWjrw4TdJk6KTtXjVFdgVwUn0NZl9X/5EUDJWGre2QOHPSzL+eAz+WaHsSKY8cTgL7+Gagive9zRuinBpy8W/jNCKE9kaOZJIoZ1sep3GslyyMFGQxvOqexDpqt8Hy0uFX4tFfJaz8QC1d/m+PK02j0HQlQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mdAyfH1m; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713149296; x=1744685296;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=7Mfvjwy39GCqwbYfAcs5so6KJ06dlJod5tRCzKNpFEY=;
  b=mdAyfH1mK9imPaBgeJvaKUEDv+TleeHL2ZOaS8JEtSLb7VPb0uiL7n70
   M1DYHLOxX3wEqGnKBf/Xy9A/k/r+5YZDzFY3XuJM2d0NoSUSZTQtsgkkk
   cERfudUFEtFoM5Vwb3F47fXPZOdJNgwcfs8W1nYuVRka6mxODgzCe4mtm
   8GcvCM/0JJCCxJMrMe5gVciwGcZvfDBva7Y/kJ5tMO6Ylw3a7iSzpIIA3
   aZnuspTg8yf92vv6W33NAIwUBWCbD6QXzbd+1j01lPtd9ROsvqrBk6Aqi
   FEkKJ8ykYyvttXD3M5kYvChqzI68Na7U0g34y6ZksttLwW1nWqV0uILVJ
   w==;
X-CSE-ConnectionGUID: m8QuP33YSHuNJmJp3wz76w==
X-CSE-MsgGUID: OvUhHZcHSNarcAv8BNF0MQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="12299564"
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="12299564"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2024 19:48:09 -0700
X-CSE-ConnectionGUID: 9lgRfVswTSmPizCLnxu0vQ==
X-CSE-MsgGUID: puE4f6RYTkKrlozjfS7EhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="21833265"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Apr 2024 19:48:10 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 14 Apr 2024 19:48:09 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 14 Apr 2024 19:48:08 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 14 Apr 2024 19:48:08 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 14 Apr 2024 19:48:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eib5wkLrgO32Ogs3JS/fk/tE/BBLFlDbN9mdDWIuqP7prIlhIN4QWaESp6eEcK6rDKdO1ejNnobp6hcHm/8Py+4PHk9+NdgKawbijmbj693Vz9DTP39sBi0cavLq7hCDhDuIb/Ojw+pLKa0/nQbFhDYgFCRf4US/A+e/LYwGKrjVZaheh6Hs3HqnRqrxhYyoOy9i0Q+XW+QQKiRa+e17IstjtSX9uAeFhEBfa13XnpgotfgCl+TLSnsowShTMDumFSyiLeUCwfW+0wmP2AsagNalfuD1EU8InwVcP6i8YMD5cggf3HyNj7HXZnymVujUUXRUC44tDrgimRmg2beHwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qiUBWxbGNaknYTd8BgLmE/M30hKMqgrhLY9Y6qt3Htg=;
 b=YWCg12PNzbXJFXRccQnSITfZ2XqjkfU/0hPNWk2H0K0ze0skHlEf47R0yvCMZldakFsIouyR760juTjHXl9PLrZKAhSpo2F7ZrojQN+Wc4+43kZBSLaBSY5TadnFYPcXZOoAolfNcs4gfsZYDDf+rb6t7vBlLX1a6aLtux92P4x0fyl1FVBlP97YcIHLL2We+1mfgbLcrzbAnHXMfK5OAOr2PfpR7O08ciloRan7DPJFtyzrjyxfT73BP+o2Iebi4CI8bNQgZTO++hmM431aH1NXinHuAo8MUNTmsku3MHBEzgoz3dxp7YpmZBGUr+nSKaZcm4V6YJ/9wcdhuwE2JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by IA0PR11MB7862.namprd11.prod.outlook.com (2603:10b6:208:3dc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7430.46; Mon, 15 Apr
 2024 02:48:06 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7472.025; Mon, 15 Apr 2024
 02:48:06 +0000
Date: Mon, 15 Apr 2024 10:47:58 +0800
From: kernel test robot <oliver.sang@intel.com>
To: <fdmanana@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-btrfs@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH v2 10/15] btrfs: add a global per cpu counter to track
 number of used extent maps
Message-ID: <202404151034.cd36195c-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c52817a5221e712a7b3cb3686496eed82d9e04ce.1712837044.git.fdmanana@suse.com>
X-ClientProxiedBy: SG3P274CA0002.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::14)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|IA0PR11MB7862:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f450c51-a7a9-4639-0405-08dc5cf67a49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LdIXMRisjB1wH1QogjFfq53VrMA+/FV9Sfjm+VmmrSlICCM2AxC1ucXXTdRlVmWew4oOWlzg738YWUnbHfQ1Yq6oxlU1PClzRntcxUgvsfe0u0RQhzGg3l/6Sp9DcBZn/4LiHkM4hNqsPEsHH4KQKaYfWZ3udLuhTz6YFmyrcMmoZd5qsuPXGLL2QhXhRNYC31dNVOgRH7P+T75rhp8PcMr9e2luNTpgMhEvJiCWAceYl8XRIvXuF5DRx9BAv54J6o8OjW+BQn/2SKiOUbLjiSEUNbsp8vwju/fAeINPY2wt18DMgnqKfjbl/H+HYEVKkcMMA6Gdgip9KohxiJP/0g2mnPq7uh/v/2bLxLB9jPuNCDIpr3+fRRdWJKjNucxSRU0XJpju0N+wzUI45WlCUPS16lGVE3u3zh0wnPvS9GN7kxBBzcs7Hl8cD3iG8/sY/yBOyYuh+AMMCPCn+9csPo7SLl7HGsUNkcWbTk93nTjuv/ByOhFpKyjaH0CYRlzzB/crht864QNIDhVZPDVYDSCgD8VTb5AHkkDvNB7MiR+EW3lWlzThUBTLv8rSYHJMH7O2iSyw8NywEOUWB7LF7xZ9ynyFM6yoma8x9lVbV7a71x8J0sxo1GZf5jHL9KJX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3y3LNq264203DEFILMM7O0GC4E2K11rFysQMS2L3OhFKT+xQpe9wCMwdZyME?=
 =?us-ascii?Q?o+3xWSyba/txNKnLm1kflRFNxG7nJBiy9E9POL5QqKSXM+U2rrK8yjfn0vnN?=
 =?us-ascii?Q?rSddJwmcAxwtWFFcNqs5OXoP7rRtfnSXzoteb8iMreh2x+Cl5PCb5FnnOTkz?=
 =?us-ascii?Q?POXuc4BemTVKlUEM6F9D0PRe6YJLNLilyF4gHFBVo9mG5QnL1zEGLjUxy5lK?=
 =?us-ascii?Q?ixEwA/Q0yqDHEpTPBvvVxTmkI1k78QnhpnmJpV5fxIk99vMgTddVgbEh8PWZ?=
 =?us-ascii?Q?oa6MKNBMbVVXQvaat0CfRv8Lh9YSmFvM9kDlj5rQRoG2U5XNfIK4nLQJRcR9?=
 =?us-ascii?Q?hKU/S5lUB+wu5r5Jo0k84LFmrUXuVqIlvf2dOdZf60/x9JZnV7VdhzGr/Je3?=
 =?us-ascii?Q?FDcrJ3ghXtHbg7eBDjiDRlOz8kTrgHfHWRzIJEBaECZUGMRpFXbVftnmzhqj?=
 =?us-ascii?Q?z6ZMSRw8g5WbS+0JSclQLMyGSU/EQ94sIj64MCvsuZbzJbKOmz83hngbwJ+K?=
 =?us-ascii?Q?T7DB67iWlUrwQbkge4dm38v8GJJTiUmuxckoisClSsRx6du+OoRVRoZ7Sdnq?=
 =?us-ascii?Q?Loq7z/vEnmdUz2BrrZ+gqZdCauQBe2fBVGckhym8rZmRw7zaTPzZfVF4HucU?=
 =?us-ascii?Q?jEibpXrNKvkACrUdRgXWNYMb+kp6IlSVEwu1TmQSjjMYeHlSlfGOp15tx85L?=
 =?us-ascii?Q?6OnoQzYyHm9djGsCU+wnn1YhwI+vwhhdUkAhk7OhWb5/asdcTOhsopHXRthc?=
 =?us-ascii?Q?7+AxA21fzaO8nvJtGrEqwRQyne49EXKk/kpL5aF1LCbwZnRAR61jVj2UvHe6?=
 =?us-ascii?Q?fNkEQ/YbgSebuuB2vjHfVQ2e/nbi9aKaZpgNOTf3/R23M5Z5Tjq9hmQdagnA?=
 =?us-ascii?Q?BSQAFdvbljdaizb5o7Yx+O7sXnLkQkb7eDRGLUesT2QqPWXnhaU+qSVXq/EF?=
 =?us-ascii?Q?uiSaQ7WJXRycvaUAuJ6DWM9fiUzlea3GtbedmtJGysqIRUqgO01NlE2eWGG9?=
 =?us-ascii?Q?JTpAJ9aw0AjZ/wJtcOOUjJfuftRVFIjen5OXYowi1Br2C3qbFTROV2BNYm3b?=
 =?us-ascii?Q?g7Fm6RpDLbbkJgBCL0NzS18xu/s1tXj7WRlMvqTGOy8+HW+2fk4w/XaWqvrQ?=
 =?us-ascii?Q?5r1I1LPhjLRVt+7cCYvkweXu0oHb7Cr4AG0I/Suru5pv35nOqLhe9xd9f8s8?=
 =?us-ascii?Q?uJ4u4RWIE0TNrh/4ru7HyD1audZoF1PIgGzd9sU2psRDnHnUO5YNualmOSmx?=
 =?us-ascii?Q?HaERPxbhYnlswFck6gjCLOySxOTH/7GdLmJ+0uhK0Z/vgnx828h/1r8WFic0?=
 =?us-ascii?Q?jwSX6GIPlntaiBT+QIDw4knvBrcfsYgdzzYdnjYnK3hZKKvBSLKz5F5RJC6A?=
 =?us-ascii?Q?Qy7rAZu5ArP6sBFK0eUfVpYvBBBnqTrPs4GpUzd9FV6vtvOaGoPz5O8iwdXv?=
 =?us-ascii?Q?QiyteG1jWpu6Flv4AaL5v/5N2BCl+nmiC3Lcs0QL3oqNthSmdlyX1DtWEo2K?=
 =?us-ascii?Q?7JU8snD74LlgtrLpGDaZPns5vJlbHm42BXIm9wZYqo9LjrC09HK5wvmTgYX1?=
 =?us-ascii?Q?Un0U5pgRGEkniMLHpdDLmCCp1MlrLlk1r9TJD4Co/3fYufWUDQjfH1Cycr6S?=
 =?us-ascii?Q?1g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f450c51-a7a9-4639-0405-08dc5cf67a49
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 02:48:06.6302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VpjBfthX5dZH+4PMG7hmdxUK+inAt/fJfb2ePLnmBhu6nnaWUau0zvPYh3JH77tsdR1N12EVcKxn6iS4YEYzfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7862
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "EIP:__percpu_counter_sum" on:

commit: b1c708ad024484a86a493ac9b1c94ba55ed9aec5 ("[PATCH v2 10/15] btrfs: add a global per cpu counter to track number of used extent maps")
url: https://github.com/intel-lab-lkp/linux/commits/fdmanana-kernel-org/btrfs-pass-an-inode-to-btrfs_add_extent_mapping/20240412-015132
base: https://git.kernel.org/cgit/linux/kernel/git/kdave/linux.git for-next
patch link: https://lore.kernel.org/all/c52817a5221e712a7b3cb3686496eed82d9e04ce.1712837044.git.fdmanana@suse.com/
patch subject: [PATCH v2 10/15] btrfs: add a global per cpu counter to track number of used extent maps

in testcase: boot

compiler: clang-17
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+---------------------------------------------------+------------+------------+
|                                                   | a4dd4472f7 | b1c708ad02 |
+---------------------------------------------------+------------+------------+
| INFO:trying_to_register_non-static_key            | 0          | 6          |
| BUG:unable_to_handle_page_fault_for_address       | 0          | 6          |
| Oops:#[##]                                        | 0          | 6          |
| EIP:__percpu_counter_sum                          | 0          | 6          |
| Kernel_panic-not_syncing:Fatal_exception          | 0          | 6          |
+---------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202404151034.cd36195c-oliver.sang@intel.com


[  201.010606][  T168] INFO: trying to register non-static key.
[  201.011499][  T168] The code is fine but needs lockdep annotation, or maybe
[  201.012269][  T168] you didn't initialize this object before use?
[  201.012951][  T168] turning off the locking correctness validator.
[  201.013663][  T168] CPU: 1 PID: 168 Comm: mount Tainted: G        W        N 6.9.0-rc3-00121-gb1c708ad0244 #1
[  201.014742][  T168] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  201.015907][  T168] Call Trace:
[ 201.016332][ T168] dump_stack_lvl (lib/dump_stack.c:116) 
[ 201.016878][ T168] dump_stack (lib/dump_stack.c:123) 
[ 201.017392][ T168] assign_lock_key (kernel/locking/lockdep.c:?) 
[ 201.017966][ T168] register_lock_class (kernel/locking/lockdep.c:?) 
[ 201.018604][ T168] __lock_acquire (kernel/locking/lockdep.c:5014) 
[ 201.019210][ T168] ? __slab_free (mm/slub.c:4099) 
[ 201.019799][ T168] ? kern_path (fs/namei.c:2625) 
[ 201.020345][ T168] ? kmem_cache_free (mm/slub.c:4233 mm/slub.c:4281 mm/slub.c:4344) 
[ 201.020984][ T168] ? kern_path (fs/namei.c:2625) 
[ 201.021555][ T168] ? kern_path (fs/namei.c:2625) 
[ 201.022098][ T168] ? kern_path (fs/namei.c:2625) 
[ 201.022623][ T168] ? lock_release (kernel/locking/lockdep.c:5244) 
[ 201.023186][ T168] lock_acquire (kernel/locking/lockdep.c:5754) 
[ 201.023827][ T168] ? __percpu_counter_sum (lib/percpu_counter.c:?) 
[ 201.024440][ T168] ? mutex_unlock (kernel/locking/mutex.c:549) 
[ 201.024984][ T168] _raw_spin_lock_irqsave (include/linux/spinlock_api_smp.h:110 kernel/locking/spinlock.c:162) 
[ 201.025594][ T168] ? __percpu_counter_sum (lib/percpu_counter.c:?) 
[ 201.026203][ T168] __percpu_counter_sum (lib/percpu_counter.c:?) 
[ 201.026800][ T168] ? debug_mutex_init (include/linux/lockdep.h:135 include/linux/lockdep.h:142 kernel/locking/mutex-debug.c:87) 
[ 201.027371][ T168] btrfs_free_fs_info (fs/btrfs/disk-io.c:1272) 
[ 201.027986][ T168] btrfs_free_fs_context (fs/btrfs/super.c:2103) 
[ 201.028585][ T168] put_fs_context (fs/fs_context.c:522) 
[ 201.029136][ T168] btrfs_get_tree (include/linux/err.h:61 fs/btrfs/super.c:2051 fs/btrfs/super.c:2085) 
[ 201.029698][ T168] ? btrfs_parse_param (include/linux/fs_parser.h:73 fs/btrfs/super.c:272) 
[ 201.030293][ T168] ? security_capable (security/security.c:1036) 
[ 201.030869][ T168] vfs_get_tree (fs/super.c:1780) 
[ 201.031399][ T168] do_new_mount (fs/namespace.c:3352) 
[ 201.031950][ T168] ? security_capable (security/security.c:1036) 
[ 201.032538][ T168] path_mount (fs/namespace.c:3679) 
[ 201.033065][ T168] __ia32_sys_mount (fs/namespace.c:3692 fs/namespace.c:3898 fs/namespace.c:3875 fs/namespace.c:3875) 
[ 201.033643][ T168] do_int80_syscall_32 (arch/x86/entry/common.c:?) 
[ 201.034492][ T168] ? syscall_exit_to_user_mode (kernel/entry/common.c:221) 
[ 201.036999][ T168] ? do_int80_syscall_32 (arch/x86/entry/common.c:278) 
[ 201.037611][ T168] ? do_int80_syscall_32 (arch/x86/entry/common.c:278) 
[ 201.038214][ T168] ? do_int80_syscall_32 (arch/x86/entry/common.c:278) 
[ 201.038814][ T168] ? do_int80_syscall_32 (arch/x86/entry/common.c:278) 
[ 201.039445][ T168] ? irqentry_exit (kernel/entry/common.c:367) 
[ 201.040004][ T168] ? exc_page_fault (arch/x86/mm/fault.c:1567) 
[ 201.040579][ T168] entry_INT80_32 (arch/x86/entry/entry_32.S:944) 
[  201.041121][  T168] EIP: 0xb7dedd4e
[ 201.041595][ T168] Code: 90 66 90 66 90 66 90 66 90 66 90 90 57 56 53 8b 7c 24 20 8b 74 24 1c 8b 54 24 18 8b 4c 24 14 8b 5c 24 10 b8 15 00 00 00 cd 80 <5b> 5e 5f 3d 01 f0 ff ff 0f 83 64 7a f3 ff c3 66 90 90 57 56 53 8b
All code
========
   0:	90                   	nop
   1:	66 90                	xchg   %ax,%ax
   3:	66 90                	xchg   %ax,%ax
   5:	66 90                	xchg   %ax,%ax
   7:	66 90                	xchg   %ax,%ax
   9:	66 90                	xchg   %ax,%ax
   b:	90                   	nop
   c:	57                   	push   %rdi
   d:	56                   	push   %rsi
   e:	53                   	push   %rbx
   f:	8b 7c 24 20          	mov    0x20(%rsp),%edi
  13:	8b 74 24 1c          	mov    0x1c(%rsp),%esi
  17:	8b 54 24 18          	mov    0x18(%rsp),%edx
  1b:	8b 4c 24 14          	mov    0x14(%rsp),%ecx
  1f:	8b 5c 24 10          	mov    0x10(%rsp),%ebx
  23:	b8 15 00 00 00       	mov    $0x15,%eax
  28:	cd 80                	int    $0x80
  2a:*	5b                   	pop    %rbx		<-- trapping instruction
  2b:	5e                   	pop    %rsi
  2c:	5f                   	pop    %rdi
  2d:	3d 01 f0 ff ff       	cmp    $0xfffff001,%eax
  32:	0f 83 64 7a f3 ff    	jae    0xfffffffffff37a9c
  38:	c3                   	ret
  39:	66 90                	xchg   %ax,%ax
  3b:	90                   	nop
  3c:	57                   	push   %rdi
  3d:	56                   	push   %rsi
  3e:	53                   	push   %rbx
  3f:	8b                   	.byte 0x8b

Code starting with the faulting instruction
===========================================
   0:	5b                   	pop    %rbx
   1:	5e                   	pop    %rsi
   2:	5f                   	pop    %rdi
   3:	3d 01 f0 ff ff       	cmp    $0xfffff001,%eax
   8:	0f 83 64 7a f3 ff    	jae    0xfffffffffff37a72
   e:	c3                   	ret
   f:	66 90                	xchg   %ax,%ax
  11:	90                   	nop
  12:	57                   	push   %rdi
  13:	56                   	push   %rsi
  14:	53                   	push   %rbx
  15:	8b                   	.byte 0x8b
[  201.043677][  T168] EAX: ffffffda EBX: 004f14ca ECX: 004f14df EDX: 0210a960
[  201.044439][  T168] ESI: 00008000 EDI: 00000000 EBP: b7fa3474 ESP: bfbe8ad0
[  201.045227][  T168] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000292
[  201.046161][  T168] BUG: unable to handle page fault for address: 28a5a000
[  201.046968][  T168] #PF: supervisor read access in kernel mode
[  201.047675][  T168] #PF: error_code(0x0000) - not-present page
[  201.048368][  T168] *pdpt = 000000001a10a001 *pde = 0000000000000000
[  201.049105][  T168] Oops: 0000 [#1] SMP
[  201.049606][  T168] CPU: 1 PID: 168 Comm: mount Tainted: G        W        N 6.9.0-rc3-00121-gb1c708ad0244 #1
[  201.050803][  T168] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 201.052100][ T168] EIP: __percpu_counter_sum (lib/percpu_counter.c:147) 
[ 201.052770][ T168] Code: 90 90 90 89 d0 d3 e8 d3 e0 25 ff 00 00 00 74 2e 89 45 e8 f3 0f bc 4d e8 83 f9 07 77 21 8b 45 f0 8b 40 34 8b 34 8d f4 b5 9c c3 <8b> 04 06 89 c6 c1 fe 1f 01 c7 11 f3 83 f9 07 8d 49 01 75 c5 8b 45
All code
========
   0:	90                   	nop
   1:	90                   	nop
   2:	90                   	nop
   3:	89 d0                	mov    %edx,%eax
   5:	d3 e8                	shr    %cl,%eax
   7:	d3 e0                	shl    %cl,%eax
   9:	25 ff 00 00 00       	and    $0xff,%eax
   e:	74 2e                	je     0x3e
  10:	89 45 e8             	mov    %eax,-0x18(%rbp)
  13:	f3 0f bc 4d e8       	tzcnt  -0x18(%rbp),%ecx
  18:	83 f9 07             	cmp    $0x7,%ecx
  1b:	77 21                	ja     0x3e
  1d:	8b 45 f0             	mov    -0x10(%rbp),%eax
  20:	8b 40 34             	mov    0x34(%rax),%eax
  23:	8b 34 8d f4 b5 9c c3 	mov    -0x3c634a0c(,%rcx,4),%esi
  2a:*	8b 04 06             	mov    (%rsi,%rax,1),%eax		<-- trapping instruction
  2d:	89 c6                	mov    %eax,%esi
  2f:	c1 fe 1f             	sar    $0x1f,%esi
  32:	01 c7                	add    %eax,%edi
  34:	11 f3                	adc    %esi,%ebx
  36:	83 f9 07             	cmp    $0x7,%ecx
  39:	8d 49 01             	lea    0x1(%rcx),%ecx
  3c:	75 c5                	jne    0x3
  3e:	8b                   	.byte 0x8b
  3f:	45                   	rex.RB

Code starting with the faulting instruction
===========================================
   0:	8b 04 06             	mov    (%rsi,%rax,1),%eax
   3:	89 c6                	mov    %eax,%esi
   5:	c1 fe 1f             	sar    $0x1f,%esi
   8:	01 c7                	add    %eax,%edi
   a:	11 f3                	adc    %esi,%ebx
   c:	83 f9 07             	cmp    $0x7,%ecx
   f:	8d 49 01             	lea    0x1(%rcx),%ecx
  12:	75 c5                	jne    0xffffffffffffffd9
  14:	8b                   	.byte 0x8b
  15:	45                   	rex.RB
[  201.054977][  T168] EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: 00000003
[  201.058373][  T168] ESI: 28a5a000 EDI: 00000000 EBP: ee833d88 ESP: ee833d70
[  201.059245][  T168] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00010097
[  201.060208][  T168] CR0: 80050033 CR2: 28a5a000 CR3: 0502cfa0 CR4: 000406b0
[  201.061046][  T168] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[  201.061893][  T168] DR6: fffe0ff0 DR7: 00000400
[  201.062503][  T168] Call Trace:
[ 201.062978][ T168] ? __die_body (arch/x86/kernel/dumpstack.c:478 arch/x86/kernel/dumpstack.c:420) 
[ 201.067652][ T168] ? __die (arch/x86/kernel/dumpstack.c:434) 
[ 201.068186][ T168] ? page_fault_oops (arch/x86/mm/fault.c:709) 
[ 201.068788][ T168] ? __slab_free (mm/slub.c:4099) 
[ 201.069398][ T168] ? kernelmode_fixup_or_oops (arch/x86/mm/fault.c:767) 
[ 201.070107][ T168] ? __bad_area_nosemaphore (arch/x86/mm/fault.c:814) 
[ 201.070815][ T168] ? kern_path (fs/namei.c:2625) 
[ 201.071402][ T168] ? bad_area_nosemaphore (arch/x86/mm/fault.c:863) 
[ 201.072062][ T168] ? do_user_addr_fault (arch/x86/mm/fault.c:?) 
[ 201.072729][ T168] ? exc_page_fault (arch/x86/include/asm/irqflags.h:19 arch/x86/include/asm/irqflags.h:67 arch/x86/include/asm/irqflags.h:127 arch/x86/mm/fault.c:1513 arch/x86/mm/fault.c:1563) 
[ 201.073359][ T168] ? pvclock_clocksource_read_nowd (arch/x86/mm/fault.c:1518) 
[ 201.074135][ T168] ? handle_exception (arch/x86/entry/entry_32.S:1054) 
[ 201.074815][ T168] ? atomic_dec_and_mutex_lock (kernel/locking/mutex.c:548 kernel/locking/mutex.c:1153) 
[ 201.075553][ T168] ? rwsem_down_write_slowpath (include/trace/events/lock.h:95) 
[ 201.076301][ T168] ? pvclock_clocksource_read_nowd (arch/x86/mm/fault.c:1518) 
[ 201.077099][ T168] ? __percpu_counter_sum (lib/percpu_counter.c:147) 
[ 201.077771][ T168] ? rwsem_down_write_slowpath (include/trace/events/lock.h:95) 
[ 201.078512][ T168] ? pvclock_clocksource_read_nowd (arch/x86/mm/fault.c:1518) 
[ 201.079292][ T168] ? __percpu_counter_sum (lib/percpu_counter.c:147) 
[ 201.079968][ T168] btrfs_free_fs_info (fs/btrfs/disk-io.c:1272) 
[ 201.080615][ T168] btrfs_free_fs_context (fs/btrfs/super.c:2103) 
[ 201.081282][ T168] put_fs_context (fs/fs_context.c:522) 
[ 201.081910][ T168] btrfs_get_tree (include/linux/err.h:61 fs/btrfs/super.c:2051 fs/btrfs/super.c:2085) 
[ 201.082549][ T168] ? btrfs_parse_param (include/linux/fs_parser.h:73 fs/btrfs/super.c:272) 
[ 201.083205][ T168] ? security_capable (security/security.c:1036) 
[ 201.083857][ T168] vfs_get_tree (fs/super.c:1780) 
[ 201.084444][ T168] do_new_mount (fs/namespace.c:3352) 
[ 201.085054][ T168] ? security_capable (security/security.c:1036) 
[ 201.085690][ T168] path_mount (fs/namespace.c:3679) 
[ 201.086281][ T168] __ia32_sys_mount (fs/namespace.c:3692 fs/namespace.c:3898 fs/namespace.c:3875 fs/namespace.c:3875) 
[ 201.089463][ T168] do_int80_syscall_32 (arch/x86/entry/common.c:?) 
[ 201.090154][ T168] ? syscall_exit_to_user_mode (kernel/entry/common.c:221) 
[ 201.090895][ T168] ? do_int80_syscall_32 (arch/x86/entry/common.c:278) 
[ 201.091578][ T168] ? do_int80_syscall_32 (arch/x86/entry/common.c:278) 
[ 201.092250][ T168] ? do_int80_syscall_32 (arch/x86/entry/common.c:278) 
[ 201.092939][ T168] ? do_int80_syscall_32 (arch/x86/entry/common.c:278) 
[ 201.093621][ T168] ? irqentry_exit (kernel/entry/common.c:367) 
[ 201.094251][ T168] ? exc_page_fault (arch/x86/mm/fault.c:1567) 
[ 201.094913][ T168] entry_INT80_32 (arch/x86/entry/entry_32.S:944) 
[  201.095560][  T168] EIP: 0xb7dedd4e
[ 201.096066][ T168] Code: 90 66 90 66 90 66 90 66 90 66 90 90 57 56 53 8b 7c 24 20 8b 74 24 1c 8b 54 24 18 8b 4c 24 14 8b 5c 24 10 b8 15 00 00 00 cd 80 <5b> 5e 5f 3d 01 f0 ff ff 0f 83 64 7a f3 ff c3 66 90 90 57 56 53 8b
All code
========
   0:	90                   	nop
   1:	66 90                	xchg   %ax,%ax
   3:	66 90                	xchg   %ax,%ax
   5:	66 90                	xchg   %ax,%ax
   7:	66 90                	xchg   %ax,%ax
   9:	66 90                	xchg   %ax,%ax
   b:	90                   	nop
   c:	57                   	push   %rdi
   d:	56                   	push   %rsi
   e:	53                   	push   %rbx
   f:	8b 7c 24 20          	mov    0x20(%rsp),%edi
  13:	8b 74 24 1c          	mov    0x1c(%rsp),%esi
  17:	8b 54 24 18          	mov    0x18(%rsp),%edx
  1b:	8b 4c 24 14          	mov    0x14(%rsp),%ecx
  1f:	8b 5c 24 10          	mov    0x10(%rsp),%ebx
  23:	b8 15 00 00 00       	mov    $0x15,%eax
  28:	cd 80                	int    $0x80
  2a:*	5b                   	pop    %rbx		<-- trapping instruction
  2b:	5e                   	pop    %rsi
  2c:	5f                   	pop    %rdi
  2d:	3d 01 f0 ff ff       	cmp    $0xfffff001,%eax
  32:	0f 83 64 7a f3 ff    	jae    0xfffffffffff37a9c
  38:	c3                   	ret
  39:	66 90                	xchg   %ax,%ax
  3b:	90                   	nop
  3c:	57                   	push   %rdi
  3d:	56                   	push   %rsi
  3e:	53                   	push   %rbx
  3f:	8b                   	.byte 0x8b

Code starting with the faulting instruction
===========================================
   0:	5b                   	pop    %rbx
   1:	5e                   	pop    %rsi
   2:	5f                   	pop    %rdi
   3:	3d 01 f0 ff ff       	cmp    $0xfffff001,%eax
   8:	0f 83 64 7a f3 ff    	jae    0xfffffffffff37a72
   e:	c3                   	ret
   f:	66 90                	xchg   %ax,%ax
  11:	90                   	nop
  12:	57                   	push   %rdi
  13:	56                   	push   %rsi
  14:	53                   	push   %rbx
  15:	8b                   	.byte 0x8b


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240415/202404151034.cd36195c-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


