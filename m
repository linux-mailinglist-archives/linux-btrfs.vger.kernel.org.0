Return-Path: <linux-btrfs+bounces-2223-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CCF84DB78
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Feb 2024 09:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C54A81C23B06
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Feb 2024 08:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB056A350;
	Thu,  8 Feb 2024 08:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iOJlhNtv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A097E67A00
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Feb 2024 08:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707381149; cv=fail; b=kEWi674gyrZQkw9DsBuQ3Kbn5q3tQmIOq1D11YKCbpOkmmBBryB0f/qz5J/1uA73AcBKMWKrejDvMKV9asSWt28mziYTf8QUlityuYLzWdw/YaO0/RPWBfF29UOnWf1o3IuFWy50ynT/hKfL3Cek5yk4XK92wz9AETT+pQEK49Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707381149; c=relaxed/simple;
	bh=4vWBzvpcnWdFtFIEKWcpNp2fukTNJTUgcfvu46XXnb0=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=o+ZzP8BDJ66+SIt9hAPxm8GIgItfcTn6DbT1tK2zEuaf2UPHYMkTwl4bBWISW0gKrlhV+wHFQcTdivFpry4AekCnTO4g5ux5eqnXlydy5KIIxbuYkEpOzNbPlcCe/ZnT4jsGmIh7zH60jYlGbIwbAgFqecWxKwoq4kf/A44EawU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iOJlhNtv; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707381148; x=1738917148;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4vWBzvpcnWdFtFIEKWcpNp2fukTNJTUgcfvu46XXnb0=;
  b=iOJlhNtviSjL7TXP5CpRZjM6ArBBVOMqGAjoT8BwQvTdmT8KA1x8F+/0
   CkYAActlcZ8YfZMhFXZbVJEgT/nRQELheTcJztWuSANA3xZAdJswZUUnN
   Svk6Vdl8RnidlDbaCvcfGsTVSKF6As8JOlTqZpeD6oDA5N+2xmHFjWtUG
   cOnYT/X8yGgoNK4NAhhMB35RjY7JGrFkVSfN1Xm9xd+rP8vdkt9JbZELp
   XBCch0UBF4Lri7Jn8/8IA10hogZdX78GyzkOGmE3jCuZ03Ab3CqWMjWNa
   845gBtlwl09xTvgK/o3D0oSDuDQV/f3WU6XhXaUwTzQVH6BxHD5ljFVlI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="1324877"
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="1324877"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 00:32:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="1585098"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Feb 2024 00:32:24 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 8 Feb 2024 00:32:23 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 8 Feb 2024 00:32:23 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 8 Feb 2024 00:32:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jo6BAs6m+00U/ROu31KehoWFD4fmLEvjVekEW5io5Z3J1bsjIMAVpZ2SI/Vjx7pAUDufLOYRXPqe50IwgRkBUUBhIB4v3PNJZ21u7DpentDhGOjemRTOzHnAoKJAhGjHL8bcu8x85Oh/PoOYCScs2T0NBJ2uO3K5iI7B8nWGn+O+lXTWJGSTamlo0WFRgrq8WgwoVkJuEu3dTyI2wPtpTYTidFGKlVGI+xGm4aiv3JgzBKTXE9GmhRGHBMjWaI3onn5lZvP/ItrjdA2ZFVTxmzegfy0P4ClLqo4ISzfNn2VllUaVsu7TOMsEjosRkxsAGIwxjiC/Ei5SzJSsyYp64g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hl7OYAlJfTflVIPBQ9OvXpUkNCn00QotxOI97moirVw=;
 b=FjC9E+TmzTCJfSw0DkqC6DcAYIhywXwm7UYXROrUYjTpJRBvNnmFJ3j6v4Qxzupzh0s/TieVUXI9XBaGlYkT9pksJX6G5dZYaEGE4eRCOqYdrdQhOt0mUmtsUQA8aDTFFi2TPLBdENgbPKozQ8AdnaFmN4UKvj5jCZP0skHRxN7hlUuL+N3mvxBYAYCohvFWzl3Sl1fW0DepvknoKtU4e+OOr2YwcGXWnWX+PjHNWy9QNcHgKVj0h6x40Jh9+T8Jym/ZePk7UxtkLOgC49s/lHI8AD2Kz/p5Y+JEe4ZCi46BKzhziYHY4pWl/6ilRfaFSt/I6pquv4osZk7miCPOaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by BN9PR11MB5228.namprd11.prod.outlook.com (2603:10b6:408:135::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38; Thu, 8 Feb
 2024 08:32:21 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e%3]) with mapi id 15.20.7249.038; Thu, 8 Feb 2024
 08:32:21 +0000
Date: Thu, 8 Feb 2024 16:32:13 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Boris Burkov <boris@bur.io>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, David Sterba
	<dsterba@suse.com>, Qu Wenruo <wqu@suse.com>, <linux-btrfs@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [kdave-btrfs-devel:dev/fixinclude-to-send] [btrfs]  a9e57fc34c:
 xfstests.btrfs.303.fail
Message-ID: <202402081613.c4636ea9-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR01CA0135.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::15) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|BN9PR11MB5228:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e53aea8-3be1-4a84-7a25-08dc288077d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: he+nzm/XJws0xppYBSlIuYJ2eLXkWiQQHmwLuFAhq504+SvccHsGhvPZWcRWf1dVIjroxFC36sRkaIM1KzrRUbiU+bHiW+XtKRGaTMBkAfeanmMEBPDjbG3OTLHd/QsB2ZRJC6A103569sNiW7hNmsiV71/qs+X0FOu8zkzST5/iqC5u3Ii8rAlUDVPcslukbdKzeH5so9WIsR/Y9ihxXWRYze3ME+C9y/yPgSb+hmE0yDRyvK86yog5W63Xb9YbLhPEcD06JdFJMN0FYsYsE6PEZJ4zmbOmTUfEs/Us9DNmssI3L8B+4XZzSFlswKX4C2MtacL3EpV24gxHyUuSM0ZjyM24N9BJRtvrdSHKttV3P1Gjf7tfpZj5O4yI16IN2tUpQ0GhpKOKwKfAJQihF60EQbNGnVxE2aH+cmjZx/IXiLfBDPZtOky464x9eeA9ukMLPEJfPELvqz2wiFW8l1+QzaSSO3Lo1o+fio0grbX81H6t/AyOSdik7d1UCW4Q1M/xuVr3yhwIq3r8mA9VXM3kTMSDnokJOnC+hkiMunVYONjZ9t2yanJJNjw6zWMFZhZ/DvRUWD6AmGtXk7MfQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(376002)(396003)(39860400002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(36756003)(41300700001)(66476007)(66946007)(6916009)(66556008)(54906003)(316002)(86362001)(5660300002)(8936002)(6486002)(966005)(82960400001)(478600001)(38100700002)(8676002)(4326008)(2906002)(83380400001)(6506007)(26005)(107886003)(6666004)(2616005)(1076003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TyC+8EfaiFRn0brXIn/vQ5T0FE/vQ1oaUWQ+KSU6DADzVVAUDINFsqzDwqKN?=
 =?us-ascii?Q?o3Nl/3PCKRi3uCqibnJhYd+PyppCSJ5riA6uVbt2l5yDzih7vN3xAf3+rVac?=
 =?us-ascii?Q?syAA1Mscp8x1ekUDMvvKTPFxEaBPK9X/0v2I4IwLgi/BXyT6Q8A0LUfAyUwJ?=
 =?us-ascii?Q?h10fKUQZUFN67ACTZ1fbeN4NaMJLWqomjDxIxIzwEg4r9vsTquOxR2egDjXJ?=
 =?us-ascii?Q?uq8WSoB8WTw9A8JBzs8K4oMZbayqRN2qWIH1GuRXgxjUDRZV1n0w1IgijJqe?=
 =?us-ascii?Q?orhOB2C8QlDZ+46euZgUMdg5HmBnSK91CZlnUTmqxycnwLCOowXcZBVNuhW+?=
 =?us-ascii?Q?NZXkiPYK5/cmi0dJY/8PzAplpc9lQlEJ1eqPuudQgVDBI5qwI4dRbn8ypFao?=
 =?us-ascii?Q?HGAdiit3AztcU0oZExIaHVKpOG8HtbMPXtZ2q6wly0n9tmAp+q9H8nmA7bXi?=
 =?us-ascii?Q?P4sj2shi7OhPMxPVc5ZSSjzVPNAHc1gCPglBZRVO7tTP8pS+BAAOY5jUsfJm?=
 =?us-ascii?Q?E8inRiCwJYDta/xnvc6vvjFSsC6eQrPPTAuS7/w5OXTi5jSGZSfwIvcO/e7v?=
 =?us-ascii?Q?FW5UTszkT4EKMdMyxzxONogTNOW0LPCUpojqWRs9OdbAcBPsJh0+1GKIsY9/?=
 =?us-ascii?Q?cU3tOPW/dFip7W7RgCdCL8YsZZaHp+tlxcMkrMwUSloFys4p2E/bHtJAHUjX?=
 =?us-ascii?Q?O5HtwN5G9rBEGjL5yoKWv5nb79q8Cu6v68ijfJAkKHH/EDe+TYt61tKoBwLs?=
 =?us-ascii?Q?n83X1Bkx2j0+KnDCwd6UQKUm25/Hzc0FQvn/KDyNCt0vbvD81pqqbkcbvcXL?=
 =?us-ascii?Q?nxmcpShLIjNSy9xHGu8COp37EfL8QTMH/+JjcAr4iYA5/wz+v53nX+P+jmz9?=
 =?us-ascii?Q?lpFkm9jo7UgKMtNGsgLHlrWGLjmv6KsQkRS6lEgXVxY/vLfqflxMoPV5K8L9?=
 =?us-ascii?Q?+sXlHxYpYqjz4vVKrxuKO1UxYw6+WKktYu7RFPWmzGVcq1wWMl2cikCfSyeX?=
 =?us-ascii?Q?o1aVSpiEnY7ZMxKwlq6vrhBNcQAmAOXqS65N0nGi48UBUJzS00CRnZnIDRpc?=
 =?us-ascii?Q?mM3ZhsQ3Qq5/nBpz41XL5x6MT6BNZVDjWsrJmyo3fr9oV2fcB7P4B5pZ+QXq?=
 =?us-ascii?Q?YXpIm0+2dpC7j1KQxmhkUyNgwpMNYLnKiCOire8o9Ms/CEQgowK11FMvw1Ip?=
 =?us-ascii?Q?uTqVRrjdY6j3rpCbf/GcA/9swJWi4lEgXo874izRvHTL5MyLdZxcAjmQq7gW?=
 =?us-ascii?Q?JkJs2UwT5ye4whEjgWtZ26HmAX8uBBx6IAJN1GUODsdajfuflNwVVRIhYqVx?=
 =?us-ascii?Q?MfyVhcVHYMf3UAW934LcfgVh5ZrMEC2zUYL5bfzOc/yzZJJByBX8clcD7XdQ?=
 =?us-ascii?Q?ZzYSxnwFqjjdRtjrmTB1i9XaqX+qhabCCbXBR5VBvCRGyKAlfFyznsJvxlpK?=
 =?us-ascii?Q?FLwoHVo7dFbZnjIgueNnPf0xA3MMXi/GzR7q/hrKEpIHcoM0tpvAjP+TxsJq?=
 =?us-ascii?Q?QGVsqDmckekfJ4R2U4WwUUArodp5SXnL/QqOF2HgPQpmxK7yRUTWU8HP+JoA?=
 =?us-ascii?Q?fN+dLSkZtB9ekOl+xLdynWhcekyu7kZt6NXKXX94OwOp2Pro42U3OcqsdTSB?=
 =?us-ascii?Q?BA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e53aea8-3be1-4a84-7a25-08dc288077d9
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 08:32:21.2011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LuQL4JP2hOqb0D0DTaAEutUyNLVhmHkU/Q4bVjwET4NTSQILhLPZlqK+cc86DvTkFbtMPZR6LXso5tzI4W1sVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5228
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "xfstests.btrfs.303.fail" on:

commit: a9e57fc34cc3c8a898d742086a94a0f66c683bee ("btrfs: forbid creating subvol qgroups")
https://github.com/kdave/btrfs-devel.git dev/fixinclude-to-send

in testcase: xfstests
version: xfstests-x86_64-c46ca4d1-1_20240205
with following parameters:

	disk: 6HDD
	fs: btrfs
	test: btrfs-group-30



compiler: gcc-12
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz (Haswell) with 8G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202402081613.c4636ea9-oliver.sang@intel.com

2024-02-06 17:08:46 export TEST_DIR=/fs/sdb1
2024-02-06 17:08:46 export TEST_DEV=/dev/sdb1
2024-02-06 17:08:46 export FSTYP=btrfs
2024-02-06 17:08:46 export SCRATCH_MNT=/fs/scratch
2024-02-06 17:08:46 mkdir /fs/scratch -p
2024-02-06 17:08:46 export SCRATCH_DEV_POOL="/dev/sdb2 /dev/sdb3 /dev/sdb4 /dev/sdb5 /dev/sdb6"
2024-02-06 17:08:46 sed "s:^:btrfs/:" //lkp/benchmarks/xfstests/tests/btrfs-group-30
2024-02-06 17:08:46 ./check btrfs/300 btrfs/301 btrfs/302 btrfs/303 btrfs/304 btrfs/305 btrfs/306 btrfs/307 btrfs/308 btrfs/309
FSTYP         -- btrfs
PLATFORM      -- Linux/x86_64 lkp-hsw-d01 6.8.0-rc2-00014-ga9e57fc34cc3 #1 SMP PREEMPT_DYNAMIC Tue Feb  6 21:49:37 CST 2024
MKFS_OPTIONS  -- /dev/sdb2
MOUNT_OPTIONS -- /dev/sdb2 /fs/scratch

btrfs/300       [not run] unshare --keep-caps --map-auto --map-root-user: command not found, should be in util-linux
btrfs/301       [not run] simple quotas not available
btrfs/302        13s
btrfs/303       - output mismatch (see /lkp/benchmarks/xfstests/results//btrfs/303.out.bad)
    --- tests/btrfs/303.out	2024-02-05 17:37:40.000000000 +0000
    +++ /lkp/benchmarks/xfstests/results//btrfs/303.out.bad	2024-02-06 17:09:21.788971907 +0000
    @@ -1,2 +1,3 @@
     QA output created by 303
    +ERROR: unable to create quota group: Invalid argument
     Silence is golden
    ...
    (Run 'diff -u /lkp/benchmarks/xfstests/tests/btrfs/303.out /lkp/benchmarks/xfstests/results//btrfs/303.out.bad'  to see the entire diff)

...

Failures: btrfs/303
Failed 1 of 10 tests




The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240208/202402081613.c4636ea9-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


