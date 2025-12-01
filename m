Return-Path: <linux-btrfs+bounces-19431-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CCAC95F90
	for <lists+linux-btrfs@lfdr.de>; Mon, 01 Dec 2025 08:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8C9B6342E00
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Dec 2025 07:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C36828980A;
	Mon,  1 Dec 2025 07:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hS1h0dbP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EFE288517
	for <linux-btrfs@vger.kernel.org>; Mon,  1 Dec 2025 07:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764573211; cv=fail; b=OLem3z5JlHQ35OILGcmBwAjLdUQxrYpV2sBSkijnoF29Ww0qiTiHDjRWnH9THLXI/BhxyGwwytQGRP6M0+1tvUs8slz4Y08eK9SCj1BSo6RlkafjQt50rMzy3NMfSZ1m+bNlfXqUWyJ2Q952+WBEuo0X82qx+cljdYcONtTuccU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764573211; c=relaxed/simple;
	bh=bIV293Jbf+4QMqdxcM7si8FV1UKdexYPqiT5Btw5Xig=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=cQ5ghcNrtEiBGM4zUT8YavcpWvNm4dxyUdXZcgk+GXEOXxdR55UR0ekZWmjXUc3tLS9ki5uUNKoZG+lI/aUzXAtHQ5Za0rpUSOENVywFddS6a/e6/OOc0+fiuiZam0HQBph9/IwT0urjJxbDYdVt3MIP/0IRrGpfKLScgATYseU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hS1h0dbP; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764573206; x=1796109206;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=bIV293Jbf+4QMqdxcM7si8FV1UKdexYPqiT5Btw5Xig=;
  b=hS1h0dbP/CHLzKTiorIIiDPi3b/xZ9J1sFWSh9VwFuWDfTbbLC+fGlcQ
   CP9VgoAd+kmy/SZJYJBWDnTu10bzawycrUPDNjU+6XzgEntZ0Xn8REzuI
   x7NNXW1KFYS+uLAP+/Jrfe9fhR3s7/bS93Q6On93dttBBwivTc2aQnsr6
   o+MkqiOicRsvdgr3SRNLRINCDcSLtWKRzZessA7Ai2Z6lXpfeUG6oaaKD
   DAOo+HXSYcGFT4E5MJbnh64hhRp39E9VcfL1townlQp4UMovG6QTjscB4
   ltxBuC5LLgjevwm83DWOcROdqeHjn4stLWAv4NfJqS3PD05RRIiSVx+1Y
   A==;
X-CSE-ConnectionGUID: OXhN06TZSBaJl93gIGehEQ==
X-CSE-MsgGUID: c9rsLo6LQlqdlIldrzCIrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11629"; a="91977527"
X-IronPort-AV: E=Sophos;i="6.20,240,1758610800"; 
   d="scan'208";a="91977527"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2025 23:13:23 -0800
X-CSE-ConnectionGUID: Nxw76zzQSxGckj7jTTzpzQ==
X-CSE-MsgGUID: 42PmIf0zR9aiKEqCkotv/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,240,1758610800"; 
   d="scan'208";a="198186660"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2025 23:13:23 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Sun, 30 Nov 2025 23:13:22 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Sun, 30 Nov 2025 23:13:22 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.39) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Sun, 30 Nov 2025 23:13:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S3H7juA7fH2vpK2XplT18vA9wO6TnyfN61oDG2n1YxNqjSYOV50SWy8H797nf4AWLtxp3SNiFOrMUxjNYU3TcV/Hp4zrBwlx5jeV7CrtbeVWvNVw8r85sFnQOs1pmjB52MGehIcapS/SuHDsZycrJK+vnkudqMGsiBvdE85i4ERH2IfzBdbNC73//lbqhFb1Ov274fVlzGJWsU9W5V0UvkNUXYCYgXZlY7NhVubAe3PMP1ghDmgHw+YgfFFrQK+SD6ZI5W1ZhRqFBgsaxSGLMffU+xLEZeNr6UcMj8DtZHCSBZh3rROXnK4aR+xegAijGHrZ5ecPjlwtiQNL8ZIn9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nRk4xepfWx374jbGgHYE0OMK9eqnMMthbJ9w/e9sJsw=;
 b=RfDdl0krqFYPvCrFplO7uNwV0ta/tC/eC313Q8udfFY7pvTUO5JOlGkQyTSpjT5vudr8Q8IFSoT8E5Nxdg3Hci3hWhtji51baxQZPtx7GsqYNfAZpRaVMgQsCwY0Epa/l6mQD+Ud+jWfvyD8DbsDKTuZ+trNuXJKXcl1X1QGDbhIEYsykUTCm5aVN0+l/NMJNEnOVO7/bxe69d7j1foCwhb+swW90B89oeKOTrp5EybjOUpx/3R6YJJqA9wgjLL3im6UYFd0zbZHyGR006MnEY4295wSD/yVe5cYvvj/srQVIIF4LBdevdKWLjE27XZ2RpZmr2cMVEjiteJPlUvWYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by IA1PR11MB8221.namprd11.prod.outlook.com (2603:10b6:208:451::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 07:13:14 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 07:13:14 +0000
Date: Mon, 1 Dec 2025 15:13:06 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Qu Wenruo <wqu@suse.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, David Sterba
	<dsterba@suse.com>, <linux-btrfs@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linux-next:master] [btrfs]  4591c3ef75:  fsmark.files_per_sec 6.0%
 regression
Message-ID: <202512011418.cce5b747-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TP0P295CA0038.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::11) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|IA1PR11MB8221:EE_
X-MS-Office365-Filtering-Correlation-Id: 42561693-9e73-43bf-db60-08de30a917c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?MoDPBqxYT6X/ZwfbeO+Y+g9HwiKOC40/HWiSgAlOc3hiiUJLcM8tz789bV?=
 =?iso-8859-1?Q?RYMMA72NN9ELix8zF26lT50fmwFxTK3S4fI577VKhIxpP4qf02f9YyZbIQ?=
 =?iso-8859-1?Q?kLnxo0mLl4yvBSKsDXzvm6icWTVUl/W+f92FcjYQCjkH8FTpD19dwdCIDO?=
 =?iso-8859-1?Q?jRDzB3sU14KKYJAOpUC+txY9NmNanungKgGw4Uyg3hNwUxieH3t9V7j3bG?=
 =?iso-8859-1?Q?fguJ20KXjOEDaGpGuAlTE411AboPvXnd7RnjNqQIofcuScXUgu3S6+Vp7J?=
 =?iso-8859-1?Q?1vJbkxTPChQZ3KGDQ/AR4PZ+eLCZHNab5t9ysPO0aLBkIOOfqIyJi6/Eev?=
 =?iso-8859-1?Q?II06YbmEPreeCDphByaDgjCVIIjEfsk+zv2OfoVNXYZllz6Fq0/wkYgqJg?=
 =?iso-8859-1?Q?odlP5qBED7N623aPYof3LpcsVtvqY3bz8eN+t90u1AtUWWWsri9OvPyYSD?=
 =?iso-8859-1?Q?0KA8yBu+EZhfMBt2KvErC/p//86lkxhP1RBY4oxBfrcKyfREPlgoUqeEfU?=
 =?iso-8859-1?Q?Jif1lDVyUYvyFyC1QGxmnYIir8+vuQDj1gvsc32JvVy+FHrDRAMYrNDM9P?=
 =?iso-8859-1?Q?44rYcrmgVN1+wIktbHM7LuBLlSeGU5r6STlvCvjkfVcLVzEaTId+T/0S+w?=
 =?iso-8859-1?Q?pNQTJcvQ5doEKHqzpJw5w21hcUaHFxrLaUHSRAeZOcrzGQD/5bD92e7Wav?=
 =?iso-8859-1?Q?y3tYBJpRSDZtrU8WXzpoDaiB1+zDN7d82JJM5W0I+72D+OQVOVHo/9d8Me?=
 =?iso-8859-1?Q?9esD5CfflCIj+/9UGKwUEAg8O+/NjIwsi77XHGh4eiLS3Gqdrv/W8rhho3?=
 =?iso-8859-1?Q?2c0amuXshZZHQbdR72YtHBTriyIga+4fwzc147Fb07jXKH1d3VApAaUUhd?=
 =?iso-8859-1?Q?KDMUvHBioroFtG4ICE6HlZixbx64tJVQcFqWTHxrUmbDEfi57RRV/lCsk+?=
 =?iso-8859-1?Q?uthYXGjzQWhbYkKI6d+Q9bV1LbGIC2qIA8SODT7Z4G7WeGqvfYvOXnD6NT?=
 =?iso-8859-1?Q?sa8bsgQwSd2jLxNgcNOKjwCdZ3ifnGibnDDuNFTXOMaUz7w2ZNjl4rsLna?=
 =?iso-8859-1?Q?/DAqus1/ZDAsRAYHbxdrFEyAvpNe5F/912veED1GWagWSqPxJedShrhw0t?=
 =?iso-8859-1?Q?D0oWEHziq+lhlv1GP2dktzLOewXETKC0f0pX2sS1y1PGH7OPq/DckNptlJ?=
 =?iso-8859-1?Q?r+ddg3gwcgOZxsoad8mvmok/OS2rNvC24WrRawkphXcx7pu0u3i+MCVpNO?=
 =?iso-8859-1?Q?DbE/XR0NuMyRHGgSvWQyTd4dg+42KwRI/50xGjJXzP8AbLBFD/qowlIs7L?=
 =?iso-8859-1?Q?vN2hmpYAkPsD8ijq4McN9VCSF3f2vf4U5MNjKQIRV4ENyvQaq3/yB5pE08?=
 =?iso-8859-1?Q?TVVrw6v7Qks3imR5etf1xaM3mDd85n6fAUD/nUBFvQgkNMcY74TcDeGfRz?=
 =?iso-8859-1?Q?e0iAfOdfPOUgS1aNCcFscEPkc/UY8F/RzbRWhI0uFsZdSIc/9UMcvmpT2v?=
 =?iso-8859-1?Q?7XAdXwoaxpXSoYB/sHbRBgvEiLuhP+Ml+IcYZnhKFCCQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Z6eBnQ8E+ori7/ZQiHtnf06S51RxGKUF1VKZZKLhN3Jw/69h2cKjyB2y9G?=
 =?iso-8859-1?Q?+1fFFXdRrGs3T4weeUYJzIjF9IAvXw7NbDUFeeEIvH6fEvOhBJMm/Rn/5f?=
 =?iso-8859-1?Q?IsH7wuhwXULz2C7YQbWluJvSxc6pEUhGO807yeM8Xqw7SoQNqhA+HDGoKF?=
 =?iso-8859-1?Q?/v+YM9ALb+kZ2x35usg0cx/8nuw5ibyTjd5b8dwcUYCBe8tc20TCcrwA+D?=
 =?iso-8859-1?Q?DcTSypRAIWKSE1kWBN6WzabnvUIGO66M5lpWtxkl4/hfDL9OdxTwvk6iDj?=
 =?iso-8859-1?Q?BHLLlgRu9eflzfljWhd5o16DUF2vyxIXvMVlxO47tDsz9YuRDz5GC+FwL7?=
 =?iso-8859-1?Q?MyoXvIXkOJQ3Qoe+4AYk/IlIAL3HLarrdlVbvCMU/gn6un8Q/AvakWFpeu?=
 =?iso-8859-1?Q?CY4ihf60q/2quQnjTwGRBDm/9oxr4EE4G/Y9kI/f9Bgf4H09Zz7f9sFKHl?=
 =?iso-8859-1?Q?TCMAEqg0lvaaQy/V/nIQ2RwtN2/RwSgmGjUN8D2/EWcu0NA8Wme4IOfzdc?=
 =?iso-8859-1?Q?5yFBi1zHAdG6jAI8Rg9Z0tUn0RbH6JPBufbA4RO+93d9wHo3Bq1n9/mkKU?=
 =?iso-8859-1?Q?vEfOUSO/rxRxFfjycBVw0mUR/BGmDLKNslZRa/K4cD045UDCTrC5oJkEvM?=
 =?iso-8859-1?Q?o9rHRgtYXsvc5saymSNm3WjJRBMp6gbOa8rZf4qX2pFqY8DJkTORWSfYU0?=
 =?iso-8859-1?Q?8MUtQOGwyh/7EAN9zeIlt1Cd2cdlp8lYQvSEbccEn+yJwx9hgoA52S93+8?=
 =?iso-8859-1?Q?87ZGXNSaavn+0JnifwogCMJWnwQVmzMYnlkntF0+l6A0rYLsW3ny+fM/h4?=
 =?iso-8859-1?Q?ZW9tVHI+neBmo+GBVQltXMmeneJVN7DSC7cj6DMJLYo7xL0Z5qn8cZ0tVq?=
 =?iso-8859-1?Q?hxVVXKkL2XicYySNDkwa0m3g0jxttzBF2byZmXcJMw+hqb58GHoLLoXLFU?=
 =?iso-8859-1?Q?d36SgbZlT1gwUxfH2KdEDOck9Sc2BN9vHoUQzPrPquS5d4DadtAkAtce75?=
 =?iso-8859-1?Q?ti9qqzryzyYUAnibSeTPK7xyH1hIU+QmYON56QQC32PoIeTdbI2a5K6DL8?=
 =?iso-8859-1?Q?rnBBxVJJbF312XvDjL2NaFu0mPx96do3GJ4oTV6NQUqzR0YFWgKJ/ktqUv?=
 =?iso-8859-1?Q?3u+9TG9/02N7iQ06nmiMPw0soZMBjaqNJ+mh/pJeYxPxCMk1uopGfR58jO?=
 =?iso-8859-1?Q?BmrE1eqys2JYsi5szsOxbBGgoSv/P8qMUou3A7Gddr5LLMZoDB+G1+7kTi?=
 =?iso-8859-1?Q?cN1jkyGL8its5I6QlfuiYX3y+wwvcVrAx+5ZqGek75UVUvG82QMhqNnbrq?=
 =?iso-8859-1?Q?XZEmuaBZHJdEMZHacQeovntlsjByKUl46JRxMwQY8fOeCKvKk0oBvSscCL?=
 =?iso-8859-1?Q?5Ld8+2UXFR+/GjE+vGWXDGgK+0K0Nmw0qNL7G67Mxl6935+GFQc9JmaOPa?=
 =?iso-8859-1?Q?8mTk71RpmyzgAGAHr2dSE8tQLDIzMBwse7SjK/V39aBOV1WyeEWob3BAOr?=
 =?iso-8859-1?Q?fYBnajE2mHRhzSqFMR1dW41F9LaSVp6pvchfPfG57f+pFBb4MBxHvHN7qR?=
 =?iso-8859-1?Q?iyZI2E8e948vk+i7DNv9sBmZfy9mhsyFCGAPT0vo/lZ04NPY5Ey+3QIrxj?=
 =?iso-8859-1?Q?V4LfLZzfg5pttwfPq4ZJFI278ihgiHMh0tZ3JGNqZ0ZYs2JntbztsvMQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 42561693-9e73-43bf-db60-08de30a917c0
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 07:13:14.8288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ECm8h9F4iGGvMcHCC++4v+kHhMzeaAOaZfNtaqIO5sH3gCCCqqNsdtAJiO8pc+ZVRvRrt7rtMv7PJcR8OPRUSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8221
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 6.0% regression of fsmark.files_per_sec on:


commit: 4591c3ef751d861d7dd95ff4d2aadb1b5e95854e ("btrfs: make sure all btrfs_bio::end_io are called in task context")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[still regression on linux-next/master 7d31f578f3230f3b7b33b0930b08f9afd8429817]

testcase: fsmark
config: x86_64-rhel-9.4
compiler: gcc-14
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	iterations: 1x
	nr_threads: 1t
	disk: 1BRD_32G
	fs: btrfs
	filesize: 4K
	test_size: 4G
	sync_method: fsyncBeforeClose
	nr_files_per_directory: 1fpd
	cpufreq_governor: performance



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202512011418.cce5b747-lkp@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20251201/202512011418.cce5b747-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/disk/filesize/fs/iterations/kconfig/nr_files_per_directory/nr_threads/rootfs/sync_method/tbox_group/test_size/testcase:
  gcc-14/performance/1BRD_32G/4K/btrfs/1x/x86_64-rhel-9.4/1fpd/1t/debian-13-x86_64-20250902.cgz/fsyncBeforeClose/lkp-icl-2sp9/4G/fsmark

commit: 
  81cea6cd70 ("btrfs: remove btrfs_bio::fs_info by extracting it from btrfs_bio::inode")
  4591c3ef75 ("btrfs: make sure all btrfs_bio::end_io are called in task context")

81cea6cd7041ebd4 4591c3ef751d861d7dd95ff4d2a 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
   2835756          +417.5%   14675488        cpuidle..usage
      1.86            +8.0%       2.01        iostat.cpu.system
      0.03            +0.1        0.09        mpstat.cpu.all.irq%
    692.83 ±  4%    +291.8%       2714 ±  2%  perf-c2c.HITM.local
   1759106           +13.7%    1999245        meminfo.Active
   1759089           +13.7%    1999228        meminfo.Active(anon)
     97891          +244.8%     337480        meminfo.Shmem
     94.83           +14.9%     109.00        turbostat.Avg_MHz
      2.64            +0.4        3.03        turbostat.Busy%
   3441714          +348.8%   15445681        turbostat.IRQ
    173268           +21.0%     209675        turbostat.NMI
  14691815            +1.9%   14977241        fsmark.app_overhead
      7623            -6.0%       7164        fsmark.files_per_sec
    134.64            +6.3%     143.18        fsmark.time.elapsed_time
    134.64            +6.3%     143.18        fsmark.time.elapsed_time.max
      9200 ±  3%     -19.7%       7387 ±  6%  fsmark.time.involuntary_context_switches
     86.83            -2.7%      84.50        fsmark.time.percent_of_cpu_this_job_got
   1080981          +184.3%    3072946        fsmark.time.voluntary_context_switches
    439969           +13.5%     499415        proc-vmstat.nr_active_anon
   1752888            +3.3%    1809943        proc-vmstat.nr_file_pages
     19123            +8.8%      20805        proc-vmstat.nr_mapped
     24488          +244.6%      84392        proc-vmstat.nr_shmem
      0.50 ± 23%  +17318.6%      86.74 ± 10%  proc-vmstat.nr_writeback
    439969           +13.5%     499415        proc-vmstat.nr_zone_active_anon
    519115 ±  8%     -13.8%     447557 ±  5%  proc-vmstat.numa_pte_updates
      0.01 ±145%     -75.0%       0.00        perf-sched.sch_delay.avg.ms.[unknown].[unknown].[unknown].[unknown].[unknown]
      0.01 ±145%     -75.0%       0.00        perf-sched.total_sch_delay.average.ms
      7.54 ±  2%     -80.4%       1.48 ±  4%  perf-sched.total_wait_and_delay.average.ms
     90615          +400.9%     453850        perf-sched.total_wait_and_delay.count.ms
      7.53 ±  2%     -80.4%       1.48 ±  4%  perf-sched.total_wait_time.average.ms
      7.54 ±  2%     -80.4%       1.48 ±  4%  perf-sched.wait_and_delay.avg.ms.[unknown].[unknown].[unknown].[unknown].[unknown]
     90615          +400.9%     453850        perf-sched.wait_and_delay.count.[unknown].[unknown].[unknown].[unknown].[unknown]
      7.53 ±  2%     -80.4%       1.48 ±  4%  perf-sched.wait_time.avg.ms.[unknown].[unknown].[unknown].[unknown].[unknown]
      0.29 ±  3%     +15.3%       0.34 ± 11%  sched_debug.cfs_rq:/.h_nr_queued.stddev
     10.12 ±162%   +1647.9%     176.95 ± 49%  sched_debug.cfs_rq:/.left_deadline.avg
    640.50 ±162%   +1585.6%      10796 ± 50%  sched_debug.cfs_rq:/.left_deadline.max
     79.88 ±162%   +1605.9%       1362 ± 50%  sched_debug.cfs_rq:/.left_deadline.stddev
      9.91 ±165%   +1679.7%     176.43 ± 49%  sched_debug.cfs_rq:/.left_vruntime.avg
    627.07 ±164%   +1616.5%      10763 ± 50%  sched_debug.cfs_rq:/.left_vruntime.max
     78.22 ±165%   +1637.0%       1358 ± 50%  sched_debug.cfs_rq:/.left_vruntime.stddev
     18650 ± 21%     +43.4%      26753 ± 15%  sched_debug.cfs_rq:/.load.avg
    535519 ± 24%     +57.8%     844844 ± 21%  sched_debug.cfs_rq:/.load.max
     83672 ± 18%     +45.9%     122097 ± 18%  sched_debug.cfs_rq:/.load.stddev
      0.29 ±  3%     +15.3%       0.34 ± 11%  sched_debug.cfs_rq:/.nr_queued.stddev
    131.47 ± 11%     +36.6%     179.54 ±  9%  sched_debug.cfs_rq:/.removed.load_avg.stddev
     48.29 ± 24%     +37.3%      66.31 ± 14%  sched_debug.cfs_rq:/.removed.runnable_avg.stddev
     48.29 ± 24%     +37.3%      66.30 ± 14%  sched_debug.cfs_rq:/.removed.util_avg.stddev
      9.91 ±165%   +1679.7%     176.43 ± 49%  sched_debug.cfs_rq:/.right_vruntime.avg
    627.07 ±164%   +1616.5%      10763 ± 50%  sched_debug.cfs_rq:/.right_vruntime.max
     78.22 ±165%   +1637.0%       1358 ± 50%  sched_debug.cfs_rq:/.right_vruntime.stddev
     37076          +330.3%     159559 ± 27%  sched_debug.cpu.nr_switches.avg
    226740 ±  8%    +325.1%     963782 ± 28%  sched_debug.cpu.nr_switches.max
     54972 ±  5%    +330.7%     236749 ± 29%  sched_debug.cpu.nr_switches.stddev
      1.69 ±  2%      -6.4%       1.58        perf-stat.i.MPKI
  1.59e+09            +6.7%  1.697e+09        perf-stat.i.branch-instructions
      1.24            -0.1        1.19        perf-stat.i.branch-miss-rate%
  31035192            -3.1%   30087169        perf-stat.i.branch-misses
     21.19            -2.9       18.26        perf-stat.i.cache-miss-rate%
  62982002           +13.8%   71675571        perf-stat.i.cache-references
     36278          +444.1%     197408        perf-stat.i.context-switches
      0.68           +18.5%       0.81        perf-stat.i.cpi
 6.171e+09           +20.8%  7.458e+09        perf-stat.i.cpu-cycles
     88.73           +12.1%      99.46        perf-stat.i.cpu-migrations
    469.88           +24.6%     585.61        perf-stat.i.cycles-between-cache-misses
  8.71e+09            +4.7%  9.122e+09        perf-stat.i.instructions
      1.51           -16.7%       1.26        perf-stat.i.ipc
      1.52            -7.1%       1.41        perf-stat.overall.MPKI
      1.96            -0.2        1.78        perf-stat.overall.branch-miss-rate%
     21.03            -3.1       17.97        perf-stat.overall.cache-miss-rate%
      0.71           +15.4%       0.82        perf-stat.overall.cpi
    466.60           +24.2%     579.57        perf-stat.overall.cycles-between-cache-misses
      1.41           -13.3%       1.22        perf-stat.overall.ipc
 1.579e+09            +6.7%  1.686e+09        perf-stat.ps.branch-instructions
  30885879            -3.0%   29951394        perf-stat.ps.branch-misses
  62532042           +13.9%   71194254        perf-stat.ps.cache-references
     36012          +444.4%     196039        perf-stat.ps.context-switches
 6.133e+09           +20.9%  7.414e+09        perf-stat.ps.cpu-cycles
     88.10           +12.1%      98.78        perf-stat.ps.cpu-migrations
 8.651e+09            +4.8%  9.063e+09        perf-stat.ps.instructions
 1.173e+12           +11.6%   1.31e+12        perf-stat.total.instructions
     56.95            -8.7       48.30        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
     56.94            -8.7       48.29        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
     31.91 ±  3%      -4.4       27.47 ±  2%  perf-profile.calltrace.cycles-pp.__x64_sys_fsync.do_syscall_64.entry_SYSCALL_64_after_hwframe
     31.90 ±  3%      -4.4       27.46 ±  2%  perf-profile.calltrace.cycles-pp.do_fsync.__x64_sys_fsync.do_syscall_64.entry_SYSCALL_64_after_hwframe
     31.88 ±  3%      -4.4       27.45 ±  2%  perf-profile.calltrace.cycles-pp.btrfs_sync_file.do_fsync.__x64_sys_fsync.do_syscall_64.entry_SYSCALL_64_after_hwframe
     22.14 ±  5%      -3.6       18.55 ±  7%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     22.13 ±  5%      -3.6       18.54 ±  7%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     21.24 ±  5%      -3.4       17.82 ±  7%  perf-profile.calltrace.cycles-pp.devkmsg_write.cold.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     21.24 ±  5%      -3.4       17.82 ±  7%  perf-profile.calltrace.cycles-pp.devkmsg_emit.devkmsg_write.cold.vfs_write.ksys_write.do_syscall_64
     21.24 ±  5%      -3.4       17.82 ±  7%  perf-profile.calltrace.cycles-pp.vprintk_emit.devkmsg_emit.devkmsg_write.cold.vfs_write.ksys_write
     21.17 ±  6%      -3.4       17.78 ±  7%  perf-profile.calltrace.cycles-pp.console_unlock.vprintk_emit.devkmsg_emit.devkmsg_write.cold.vfs_write
     21.17 ±  6%      -3.4       17.78 ±  7%  perf-profile.calltrace.cycles-pp.console_flush_all.console_unlock.vprintk_emit.devkmsg_emit.devkmsg_write.cold
     20.60 ±  4%      -3.4       17.24 ±  7%  perf-profile.calltrace.cycles-pp.serial8250_console_write.console_flush_all.console_unlock.vprintk_emit.devkmsg_emit
     23.36 ±  2%      -3.3       20.04 ±  2%  perf-profile.calltrace.cycles-pp.ast_mode_config_helper_atomic_commit_tail.commit_tail.drm_atomic_helper_commit.drm_atomic_commit.drm_atomic_helper_dirtyfb
     23.36 ±  2%      -3.3       20.04 ±  2%  perf-profile.calltrace.cycles-pp.drm_atomic_helper_dirtyfb.drm_fbdev_shmem_helper_fb_dirty.drm_fb_helper_damage_work.process_one_work.worker_thread
     23.36 ±  2%      -3.3       20.04 ±  2%  perf-profile.calltrace.cycles-pp.drm_atomic_helper_commit.drm_atomic_commit.drm_atomic_helper_dirtyfb.drm_fbdev_shmem_helper_fb_dirty.drm_fb_helper_damage_work
     23.36 ±  2%      -3.3       20.04 ±  2%  perf-profile.calltrace.cycles-pp.drm_atomic_helper_commit_tail.ast_mode_config_helper_atomic_commit_tail.commit_tail.drm_atomic_helper_commit.drm_atomic_commit
     23.36 ±  2%      -3.3       20.04 ±  2%  perf-profile.calltrace.cycles-pp.drm_fb_helper_damage_work.process_one_work.worker_thread.kthread.ret_from_fork
     23.36 ±  2%      -3.3       20.04 ±  2%  perf-profile.calltrace.cycles-pp.drm_fbdev_shmem_helper_fb_dirty.drm_fb_helper_damage_work.process_one_work.worker_thread.kthread
     23.36 ±  2%      -3.3       20.04 ±  2%  perf-profile.calltrace.cycles-pp.commit_tail.drm_atomic_helper_commit.drm_atomic_commit.drm_atomic_helper_dirtyfb.drm_fbdev_shmem_helper_fb_dirty
     23.36 ±  2%      -3.3       20.04 ±  2%  perf-profile.calltrace.cycles-pp.drm_atomic_commit.drm_atomic_helper_dirtyfb.drm_fbdev_shmem_helper_fb_dirty.drm_fb_helper_damage_work.process_one_work
     16.02 ±  2%      -2.6       13.39 ±  2%  perf-profile.calltrace.cycles-pp.btrfs_submit_chunk.btrfs_submit_bbio.btree_write_cache_pages.do_writepages.filemap_fdatawrite_wbc
     16.02 ±  2%      -2.6       13.40 ±  2%  perf-profile.calltrace.cycles-pp.btrfs_submit_bbio.btree_write_cache_pages.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range
     17.78 ±  3%      -2.6       15.18 ±  2%  perf-profile.calltrace.cycles-pp.btree_write_cache_pages.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.btrfs_write_marked_extents
     17.10 ±  3%      -2.5       14.62 ±  2%  perf-profile.calltrace.cycles-pp.btrfs_write_marked_extents.btrfs_sync_log.btrfs_sync_file.do_fsync.__x64_sys_fsync
     16.92 ±  3%      -2.5       14.47 ±  2%  perf-profile.calltrace.cycles-pp.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.btrfs_write_marked_extents.btrfs_sync_log
     16.96 ±  3%      -2.4       14.50 ±  2%  perf-profile.calltrace.cycles-pp.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.btrfs_write_marked_extents.btrfs_sync_log.btrfs_sync_file
     16.97 ±  3%      -2.4       14.52 ±  2%  perf-profile.calltrace.cycles-pp.__filemap_fdatawrite_range.btrfs_write_marked_extents.btrfs_sync_log.btrfs_sync_file.do_fsync
     20.03 ±  3%      -2.4       17.64 ±  2%  perf-profile.calltrace.cycles-pp.btrfs_sync_log.btrfs_sync_file.do_fsync.__x64_sys_fsync.do_syscall_64
     31.50            -1.9       29.60 ±  2%  perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      9.66 ±  2%      -1.9        7.78 ±  4%  perf-profile.calltrace.cycles-pp.btree_csum_one_bio.btrfs_submit_chunk.btrfs_submit_bbio.btree_write_cache_pages.do_writepages
      9.03 ±  4%      -1.5        7.52 ±  2%  perf-profile.calltrace.cycles-pp.btrfs_log_dentry_safe.btrfs_sync_file.do_fsync.__x64_sys_fsync.do_syscall_64
      9.02 ±  4%      -1.5        7.51 ±  2%  perf-profile.calltrace.cycles-pp.btrfs_log_inode_parent.btrfs_log_dentry_safe.btrfs_sync_file.do_fsync.__x64_sys_fsync
      7.50 ±  4%      -1.5        6.01 ±  3%  perf-profile.calltrace.cycles-pp.btrfs_check_leaf.btree_csum_one_bio.btrfs_submit_chunk.btrfs_submit_bbio.btree_write_cache_pages
      7.05 ±  3%      -1.3        5.71 ±  3%  perf-profile.calltrace.cycles-pp.__btrfs_check_leaf.btrfs_check_leaf.btree_csum_one_bio.btrfs_submit_chunk.btrfs_submit_bbio
      7.68 ±  4%      -1.3        6.38 ±  2%  perf-profile.calltrace.cycles-pp.btrfs_log_inode.btrfs_log_inode_parent.btrfs_log_dentry_safe.btrfs_sync_file.do_fsync
      5.79 ±  3%      -1.3        4.54        perf-profile.calltrace.cycles-pp.__submit_bio.__submit_bio_noacct.btrfs_submit_bio.btrfs_submit_chunk.btrfs_submit_bbio
      5.80 ±  3%      -1.2        4.55        perf-profile.calltrace.cycles-pp.__submit_bio_noacct.btrfs_submit_bio.btrfs_submit_chunk.btrfs_submit_bbio.btree_write_cache_pages
      7.05 ±  4%      -1.2        5.85 ±  2%  perf-profile.calltrace.cycles-pp.copy_inode_items_to_log.btrfs_log_inode.btrfs_log_inode_parent.btrfs_log_dentry_safe.btrfs_sync_file
      5.97 ±  3%      -1.2        4.80        perf-profile.calltrace.cycles-pp.btrfs_submit_bio.btrfs_submit_chunk.btrfs_submit_bbio.btree_write_cache_pages.do_writepages
      6.43 ±  4%      -1.1        5.34 ±  2%  perf-profile.calltrace.cycles-pp.copy_items.copy_inode_items_to_log.btrfs_log_inode.btrfs_log_inode_parent.btrfs_log_dentry_safe
      4.43 ±  7%      -1.1        3.35 ±  3%  perf-profile.calltrace.cycles-pp.btrfs_work_helper.process_one_work.worker_thread.kthread.ret_from_fork
      4.74 ±  3%      -0.9        3.84 ±  2%  perf-profile.calltrace.cycles-pp.brd_submit_bio.__submit_bio.__submit_bio_noacct.btrfs_submit_bio.btrfs_submit_chunk
      3.60 ±  7%      -0.8        2.77 ±  3%  perf-profile.calltrace.cycles-pp.btrfs_preempt_reclaim_metadata_space.process_one_work.worker_thread.kthread.ret_from_fork
      3.60 ±  7%      -0.8        2.77 ±  3%  perf-profile.calltrace.cycles-pp.flush_space.btrfs_preempt_reclaim_metadata_space.process_one_work.worker_thread.kthread
      3.80 ±  3%      -0.7        3.14 ±  2%  perf-profile.calltrace.cycles-pp.mkdir
      3.76 ±  3%      -0.6        3.12 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.mkdir
      3.75 ±  2%      -0.6        3.11 ±  2%  perf-profile.calltrace.cycles-pp.__x64_sys_mkdir.do_syscall_64.entry_SYSCALL_64_after_hwframe.mkdir
      3.76 ±  3%      -0.6        3.12 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.mkdir
      3.70 ±  3%      -0.6        3.07 ±  2%  perf-profile.calltrace.cycles-pp.do_mkdirat.__x64_sys_mkdir.do_syscall_64.entry_SYSCALL_64_after_hwframe.mkdir
      2.81 ±  7%      -0.6        2.19 ±  3%  perf-profile.calltrace.cycles-pp.btrfs_finish_one_ordered.btrfs_work_helper.process_one_work.worker_thread.kthread
      3.82 ±  4%      -0.6        3.22 ±  3%  perf-profile.calltrace.cycles-pp.btrfs_csum_file_blocks.log_csums.copy_items.copy_inode_items_to_log.btrfs_log_inode
      3.82 ±  4%      -0.6        3.22 ±  3%  perf-profile.calltrace.cycles-pp.log_csums.copy_items.copy_inode_items_to_log.btrfs_log_inode.btrfs_log_inode_parent
      3.45 ±  5%      -0.6        2.88 ±  2%  perf-profile.calltrace.cycles-pp.btrfs_lookup_csum.btrfs_csum_file_blocks.log_csums.copy_items.copy_inode_items_to_log
      3.44 ±  5%      -0.6        2.87 ±  2%  perf-profile.calltrace.cycles-pp.btrfs_search_slot.btrfs_lookup_csum.btrfs_csum_file_blocks.log_csums.copy_items
      3.30 ±  5%      -0.6        2.75 ±  2%  perf-profile.calltrace.cycles-pp.btrfs_force_cow_block.btrfs_cow_block.btrfs_search_slot.btrfs_lookup_csum.btrfs_csum_file_blocks
      3.31 ±  5%      -0.6        2.76 ±  2%  perf-profile.calltrace.cycles-pp.btrfs_cow_block.btrfs_search_slot.btrfs_lookup_csum.btrfs_csum_file_blocks.log_csums
      2.35 ±  5%      -0.5        1.81 ±  6%  perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.34 ±  5%      -0.5        1.80 ±  6%  perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.26 ±  5%      -0.5        1.74 ±  6%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.25 ±  5%      -0.5        1.73 ±  6%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64
      1.86 ±  3%      -0.5        1.36 ±  4%  perf-profile.calltrace.cycles-pp.start_ordered_ops.btrfs_sync_file.do_fsync.__x64_sys_fsync.do_syscall_64
      1.83 ±  3%      -0.5        1.34 ±  3%  perf-profile.calltrace.cycles-pp.__filemap_fdatawrite_range.btrfs_fdatawrite_range.start_ordered_ops.btrfs_sync_file.do_fsync
      1.84 ±  3%      -0.5        1.35 ±  4%  perf-profile.calltrace.cycles-pp.btrfs_fdatawrite_range.start_ordered_ops.btrfs_sync_file.do_fsync.__x64_sys_fsync
      1.81 ±  3%      -0.5        1.33 ±  4%  perf-profile.calltrace.cycles-pp.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.btrfs_fdatawrite_range.start_ordered_ops.btrfs_sync_file
      1.80 ±  3%      -0.5        1.31 ±  4%  perf-profile.calltrace.cycles-pp.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.btrfs_fdatawrite_range.start_ordered_ops
      1.78 ±  3%      -0.5        1.30 ±  4%  perf-profile.calltrace.cycles-pp.btrfs_writepages.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.btrfs_fdatawrite_range
      1.77 ±  3%      -0.5        1.29 ±  4%  perf-profile.calltrace.cycles-pp.extent_write_cache_pages.btrfs_writepages.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range
      2.90 ±  3%      -0.5        2.42 ±  2%  perf-profile.calltrace.cycles-pp.btrfs_mkdir.vfs_mkdir.do_mkdirat.__x64_sys_mkdir.do_syscall_64
      2.94 ±  3%      -0.5        2.47 ±  2%  perf-profile.calltrace.cycles-pp.vfs_mkdir.do_mkdirat.__x64_sys_mkdir.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.97 ±  5%      -0.5        1.50 ±  6%  perf-profile.calltrace.cycles-pp.open_last_lookups.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      1.63 ± 11%      -0.5        1.17 ±  4%  perf-profile.calltrace.cycles-pp.__btrfs_run_delayed_refs.btrfs_run_delayed_refs.flush_space.btrfs_preempt_reclaim_metadata_space.process_one_work
      1.63 ± 11%      -0.5        1.17 ±  3%  perf-profile.calltrace.cycles-pp.btrfs_run_delayed_refs.flush_space.btrfs_preempt_reclaim_metadata_space.process_one_work.worker_thread
      1.68 ±  3%      -0.5        1.22 ±  4%  perf-profile.calltrace.cycles-pp.extent_writepage.extent_write_cache_pages.btrfs_writepages.do_writepages.filemap_fdatawrite_wbc
      0.81            -0.5        0.36 ± 71%  perf-profile.calltrace.cycles-pp.submit_extent_folio.extent_writepage_io.extent_writepage.extent_write_cache_pages.btrfs_writepages
      2.68 ±  2%      -0.5        2.23 ±  3%  perf-profile.calltrace.cycles-pp.btrfs_create_common.btrfs_mkdir.vfs_mkdir.do_mkdirat.__x64_sys_mkdir
      1.88 ±  5%      -0.4        1.43 ±  6%  perf-profile.calltrace.cycles-pp.lookup_open.open_last_lookups.path_openat.do_filp_open.do_sys_openat2
      2.38 ±  2%      -0.4        1.96 ±  3%  perf-profile.calltrace.cycles-pp.btrfs_create_new_inode.btrfs_create_common.btrfs_mkdir.vfs_mkdir.do_mkdirat
      2.77 ±  4%      -0.4        2.36 ±  4%  perf-profile.calltrace.cycles-pp.check_leaf_item.__btrfs_check_leaf.btrfs_check_leaf.btree_csum_one_bio.btrfs_submit_chunk
      0.66 ±  8%      -0.4        0.28 ±100%  perf-profile.calltrace.cycles-pp.fbcon_redraw.fbcon_scroll.con_scroll.lf.vt_console_print
      0.88 ± 25%      -0.4        0.50 ± 45%  perf-profile.calltrace.cycles-pp.delay_tsc.wait_for_lsr.serial8250_console_write.console_flush_all.console_unlock
      1.52 ±  6%      -0.4        1.14 ±  3%  perf-profile.calltrace.cycles-pp.btrfs_async_run_delayed_root.btrfs_work_helper.process_one_work.worker_thread.kthread
      1.85 ±  4%      -0.4        1.47        perf-profile.calltrace.cycles-pp.btrfs_insert_empty_items.copy_items.copy_inode_items_to_log.btrfs_log_inode.btrfs_log_inode_parent
      1.73 ±  4%      -0.4        1.35        perf-profile.calltrace.cycles-pp.btrfs_search_slot.btrfs_insert_empty_items.copy_items.copy_inode_items_to_log.btrfs_log_inode
      1.46 ±  6%      -0.4        1.10 ±  3%  perf-profile.calltrace.cycles-pp.btrfs_run_delayed_refs_for_head.__btrfs_run_delayed_refs.btrfs_run_delayed_refs.flush_space.btrfs_preempt_reclaim_metadata_space
      1.96 ±  6%      -0.4        1.60 ±  2%  perf-profile.calltrace.cycles-pp.btrfs_commit_transaction.flush_space.btrfs_preempt_reclaim_metadata_space.process_one_work.worker_thread
      0.60 ±  8%      -0.3        0.26 ±100%  perf-profile.calltrace.cycles-pp._find_next_zero_bit.steal_from_bitmap.__btrfs_add_free_space.unpin_extent_range.btrfs_finish_extent_commit
      0.70 ±  8%      -0.3        0.38 ± 71%  perf-profile.calltrace.cycles-pp.vt_console_print.console_flush_all.console_unlock.vprintk_emit.devkmsg_emit
      1.34 ±  6%      -0.3        1.02 ±  3%  perf-profile.calltrace.cycles-pp.btrfs_create_common.lookup_open.open_last_lookups.path_openat.do_filp_open
      1.77 ±  3%      -0.3        1.45 ±  4%  perf-profile.calltrace.cycles-pp.btrfs_add_link.btrfs_create_new_inode.btrfs_create_common.btrfs_mkdir.vfs_mkdir
      1.46 ±  5%      -0.3        1.15 ±  2%  perf-profile.calltrace.cycles-pp.btrfs_force_cow_block.btrfs_cow_block.btrfs_search_slot.btrfs_insert_empty_items.copy_items
      1.47 ±  4%      -0.3        1.16 ±  2%  perf-profile.calltrace.cycles-pp.btrfs_cow_block.btrfs_search_slot.btrfs_insert_empty_items.copy_items.copy_inode_items_to_log
      0.69 ±  8%      -0.3        0.37 ± 71%  perf-profile.calltrace.cycles-pp.fbcon_scroll.con_scroll.lf.vt_console_print.console_flush_all
      0.69 ±  8%      -0.3        0.37 ± 71%  perf-profile.calltrace.cycles-pp.con_scroll.lf.vt_console_print.console_flush_all.console_unlock
      0.69 ±  8%      -0.3        0.37 ± 71%  perf-profile.calltrace.cycles-pp.lf.vt_console_print.console_flush_all.console_unlock.vprintk_emit
      1.21 ±  8%      -0.3        0.90 ±  5%  perf-profile.calltrace.cycles-pp.run_delayed_data_ref.btrfs_run_delayed_refs_for_head.__btrfs_run_delayed_refs.btrfs_run_delayed_refs.flush_space
      0.90            -0.3        0.60 ±  7%  perf-profile.calltrace.cycles-pp.extent_writepage_io.extent_writepage.extent_write_cache_pages.btrfs_writepages.do_writepages
      1.71 ±  2%      -0.3        1.40 ±  4%  perf-profile.calltrace.cycles-pp.btrfs_insert_dir_item.btrfs_add_link.btrfs_create_new_inode.btrfs_create_common.btrfs_mkdir
      1.52 ±  3%      -0.3        1.23 ±  4%  perf-profile.calltrace.cycles-pp.insert_with_overflow.btrfs_insert_dir_item.btrfs_add_link.btrfs_create_new_inode.btrfs_create_common
      1.51 ±  3%      -0.3        1.23 ±  4%  perf-profile.calltrace.cycles-pp.btrfs_insert_empty_items.insert_with_overflow.btrfs_insert_dir_item.btrfs_add_link.btrfs_create_new_inode
      1.17 ±  6%      -0.3        0.89 ±  5%  perf-profile.calltrace.cycles-pp.btrfs_create_new_inode.btrfs_create_common.lookup_open.open_last_lookups.path_openat
      1.36 ±  7%      -0.3        1.08 ±  3%  perf-profile.calltrace.cycles-pp.btrfs_alloc_tree_block.btrfs_force_cow_block.btrfs_cow_block.btrfs_search_slot.btrfs_lookup_csum
      1.80 ±  3%      -0.3        1.54 ±  4%  perf-profile.calltrace.cycles-pp.btrfs_get_32.__btrfs_check_leaf.btrfs_check_leaf.btree_csum_one_bio.btrfs_submit_chunk
      1.10 ±  5%      -0.2        0.87 ±  3%  perf-profile.calltrace.cycles-pp.btrfs_csum_file_blocks.btrfs_finish_one_ordered.btrfs_work_helper.process_one_work.worker_thread
      0.79 ±  6%      -0.2        0.58 ±  4%  perf-profile.calltrace.cycles-pp.btrfs_insert_delayed_item.btrfs_async_run_delayed_root.btrfs_work_helper.process_one_work.worker_thread
      0.93 ±  3%      -0.2        0.73 ±  4%  perf-profile.calltrace.cycles-pp.btrfs_extend_item.btrfs_csum_file_blocks.btrfs_finish_one_ordered.btrfs_work_helper.process_one_work
      1.30 ±  4%      -0.2        1.10 ±  2%  perf-profile.calltrace.cycles-pp.log_all_new_ancestors.btrfs_log_inode_parent.btrfs_log_dentry_safe.btrfs_sync_file.do_fsync
      0.96 ±  8%      -0.2        0.76 ±  4%  perf-profile.calltrace.cycles-pp.insert_reserved_file_extent.btrfs_finish_one_ordered.btrfs_work_helper.process_one_work.worker_thread
      0.88 ±  3%      -0.2        0.69 ±  4%  perf-profile.calltrace.cycles-pp.__memmove.btrfs_extend_item.btrfs_csum_file_blocks.btrfs_finish_one_ordered.btrfs_work_helper
      1.17 ±  4%      -0.2        0.98 ±  2%  perf-profile.calltrace.cycles-pp.btrfs_log_inode.log_all_new_ancestors.btrfs_log_inode_parent.btrfs_log_dentry_safe.btrfs_sync_file
      0.97 ±  3%      -0.2        0.80 ±  2%  perf-profile.calltrace.cycles-pp.csum_tree_block.btree_csum_one_bio.btrfs_submit_chunk.btrfs_submit_bbio.btree_write_cache_pages
      0.94 ±  4%      -0.2        0.77 ±  3%  perf-profile.calltrace.cycles-pp.__pi_memcpy.copy_extent_buffer_full.btrfs_force_cow_block.btrfs_cow_block.btrfs_search_slot
      0.97 ±  4%      -0.2        0.80 ±  3%  perf-profile.calltrace.cycles-pp.copy_extent_buffer_full.btrfs_force_cow_block.btrfs_cow_block.btrfs_search_slot.btrfs_lookup_csum
      1.00 ±  4%      -0.2        0.84 ±  2%  perf-profile.calltrace.cycles-pp.copy_inode_items_to_log.btrfs_log_inode.log_all_new_ancestors.btrfs_log_inode_parent.btrfs_log_dentry_safe
      0.82 ±  3%      -0.2        0.65 ±  5%  perf-profile.calltrace.cycles-pp.setup_items_for_insert.btrfs_insert_empty_items.insert_with_overflow.btrfs_insert_dir_item.btrfs_add_link
      0.92 ±  2%      -0.2        0.76 ±  2%  perf-profile.calltrace.cycles-pp.crc32c_arch.chksum_update.csum_tree_block.btree_csum_one_bio.btrfs_submit_chunk
      0.93 ±  2%      -0.2        0.77 ±  2%  perf-profile.calltrace.cycles-pp.chksum_update.csum_tree_block.btree_csum_one_bio.btrfs_submit_chunk.btrfs_submit_bbio
      0.89 ± 10%      -0.2        0.73 ±  2%  perf-profile.calltrace.cycles-pp.btrfs_write_and_wait_transaction.btrfs_commit_transaction.flush_space.btrfs_preempt_reclaim_metadata_space.process_one_work
      0.84 ±  5%      -0.2        0.68 ±  6%  perf-profile.calltrace.cycles-pp.btrfs_do_write_iter.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.87 ± 10%      -0.2        0.72 ±  2%  perf-profile.calltrace.cycles-pp.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.btrfs_write_marked_extents.btrfs_write_and_wait_transaction
      0.75 ±  8%      -0.2        0.60 ±  3%  perf-profile.calltrace.cycles-pp.alloc_extent_buffer.btrfs_init_new_buffer.btrfs_alloc_tree_block.btrfs_force_cow_block.btrfs_cow_block
      0.60 ±  5%      -0.2        0.45 ± 44%  perf-profile.calltrace.cycles-pp.btrfs_comp_cpu_keys.__btrfs_check_leaf.btrfs_check_leaf.btree_csum_one_bio.btrfs_submit_chunk
      0.87 ± 10%      -0.2        0.72 ±  2%  perf-profile.calltrace.cycles-pp.__filemap_fdatawrite_range.btrfs_write_marked_extents.btrfs_write_and_wait_transaction.btrfs_commit_transaction.flush_space
      0.87 ± 10%      -0.2        0.72 ±  2%  perf-profile.calltrace.cycles-pp.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.btrfs_write_marked_extents.btrfs_write_and_wait_transaction.btrfs_commit_transaction
      1.02 ±  6%      -0.2        0.87 ±  3%  perf-profile.calltrace.cycles-pp.btrfs_check_node.btree_csum_one_bio.btrfs_submit_chunk.btrfs_submit_bbio.btree_write_cache_pages
      0.82 ±  4%      -0.2        0.68 ±  6%  perf-profile.calltrace.cycles-pp.btrfs_buffered_write.btrfs_do_write_iter.vfs_write.ksys_write.do_syscall_64
      0.88 ± 10%      -0.2        0.73 ±  2%  perf-profile.calltrace.cycles-pp.btrfs_write_marked_extents.btrfs_write_and_wait_transaction.btrfs_commit_transaction.flush_space.btrfs_preempt_reclaim_metadata_space
      0.89 ±  2%      -0.1        0.75 ±  2%  perf-profile.calltrace.cycles-pp.crc32c_x86_3way.crc32c_arch.chksum_update.csum_tree_block.btree_csum_one_bio
      0.85 ±  4%      -0.1        0.70 ±  4%  perf-profile.calltrace.cycles-pp.btrfs_finish_extent_commit.btrfs_commit_transaction.flush_space.btrfs_preempt_reclaim_metadata_space.process_one_work
      0.75 ±  5%      -0.1        0.61 ±  3%  perf-profile.calltrace.cycles-pp.writepage_delalloc.extent_writepage.extent_write_cache_pages.btrfs_writepages.do_writepages
      0.96 ±  6%      -0.1        0.82 ±  3%  perf-profile.calltrace.cycles-pp.__btrfs_check_node.btrfs_check_node.btree_csum_one_bio.btrfs_submit_chunk.btrfs_submit_bbio
      0.82 ±  4%      -0.1        0.68 ±  4%  perf-profile.calltrace.cycles-pp.unpin_extent_range.btrfs_finish_extent_commit.btrfs_commit_transaction.flush_space.btrfs_preempt_reclaim_metadata_space
      0.81 ±  4%      -0.1        0.67 ±  5%  perf-profile.calltrace.cycles-pp.__btrfs_add_free_space.unpin_extent_range.btrfs_finish_extent_commit.btrfs_commit_transaction.flush_space
      0.69 ±  4%      -0.1        0.56 ±  5%  perf-profile.calltrace.cycles-pp.filename_create.do_mkdirat.__x64_sys_mkdir.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.70 ±  5%      -0.1        0.57 ±  5%  perf-profile.calltrace.cycles-pp.copy_one_range.btrfs_buffered_write.btrfs_do_write_iter.vfs_write.ksys_write
      0.89 ±  3%      -0.1        0.76 ±  4%  perf-profile.calltrace.cycles-pp.btrfs_get_32.check_leaf_item.__btrfs_check_leaf.btrfs_check_leaf.btree_csum_one_bio
      0.73 ±  5%      -0.1        0.61 ±  5%  perf-profile.calltrace.cycles-pp.steal_from_bitmap.__btrfs_add_free_space.unpin_extent_range.btrfs_finish_extent_commit.btrfs_commit_transaction
      0.66 ±  6%      -0.1        0.55 ±  4%  perf-profile.calltrace.cycles-pp.btrfs_search_slot.btrfs_insert_empty_items.insert_with_overflow.btrfs_insert_dir_item.btrfs_add_link
      0.62 ±  7%      +0.1        0.72 ±  2%  perf-profile.calltrace.cycles-pp.btrfs_alloc_tree_block.btrfs_force_cow_block.btrfs_cow_block.btrfs_search_slot.btrfs_update_root
      0.00            +0.6        0.63 ±  3%  perf-profile.calltrace.cycles-pp.__queue_work.queue_work_on.__submit_bio.__submit_bio_noacct.btrfs_submit_bio
      0.00            +0.7        0.66 ±  3%  perf-profile.calltrace.cycles-pp.queue_work_on.__submit_bio.__submit_bio_noacct.btrfs_submit_bio.btrfs_submit_chunk
      0.00            +0.7        0.68 ±  3%  perf-profile.calltrace.cycles-pp.__schedule.schedule_idle.do_idle.cpu_startup_entry.start_secondary
      0.00            +0.7        0.69 ±  3%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.__sysvec_call_function_single.sysvec_call_function_single
      0.00            +0.7        0.71 ±  2%  perf-profile.calltrace.cycles-pp.clone_write_end_io_work.process_one_work.worker_thread.kthread.ret_from_fork
      0.00            +0.7        0.73 ±  3%  perf-profile.calltrace.cycles-pp.schedule_idle.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      0.00            +0.8        0.82 ±  4%  perf-profile.calltrace.cycles-pp.__folio_end_writeback.folio_end_writeback_no_dropbehind.folio_end_writeback.end_bbio_meta_write.orig_write_end_io_work
      0.00            +0.8        0.85 ±  3%  perf-profile.calltrace.cycles-pp.folio_end_writeback_no_dropbehind.folio_end_writeback.end_bbio_meta_write.orig_write_end_io_work.process_one_work
      0.00            +0.9        0.88 ±  5%  perf-profile.calltrace.cycles-pp.__schedule.schedule.worker_thread.kthread.ret_from_fork
      0.00            +0.9        0.94 ±  3%  perf-profile.calltrace.cycles-pp.folio_end_writeback.end_bbio_meta_write.orig_write_end_io_work.process_one_work.worker_thread
      0.00            +1.0        0.95 ±  5%  perf-profile.calltrace.cycles-pp.schedule.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.00            +1.0        1.05 ±  3%  perf-profile.calltrace.cycles-pp.sched_ttwu_pending.__flush_smp_call_function_queue.__sysvec_call_function_single.sysvec_call_function_single.asm_sysvec_call_function_single
      0.00            +1.4        1.43 ±  2%  perf-profile.calltrace.cycles-pp.end_bbio_meta_write.orig_write_end_io_work.process_one_work.worker_thread.kthread
      0.00            +1.6        1.60 ±  2%  perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.__sysvec_call_function_single.sysvec_call_function_single.asm_sysvec_call_function_single.pv_native_safe_halt
      0.09 ±223%      +1.6        1.74 ±  2%  perf-profile.calltrace.cycles-pp.__sysvec_call_function_single.sysvec_call_function_single.asm_sysvec_call_function_single.pv_native_safe_halt.acpi_safe_halt
      0.00            +1.7        1.66 ±  2%  perf-profile.calltrace.cycles-pp.orig_write_end_io_work.process_one_work.worker_thread.kthread.ret_from_fork
      0.74 ± 13%      +1.8        2.56 ±  3%  perf-profile.calltrace.cycles-pp.sysvec_call_function_single.asm_sysvec_call_function_single.pv_native_safe_halt.acpi_safe_halt.acpi_idle_do_entry
      1.91 ± 13%      +2.3        4.22 ±  2%  perf-profile.calltrace.cycles-pp.pv_native_safe_halt.acpi_safe_halt.acpi_idle_do_entry.acpi_idle_enter.cpuidle_enter_state
      4.26 ±  5%      +8.7       13.01 ±  3%  perf-profile.calltrace.cycles-pp.acpi_safe_halt.acpi_idle_do_entry.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
      4.26 ±  5%      +8.8       13.02 ±  3%  perf-profile.calltrace.cycles-pp.acpi_idle_do_entry.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      4.28 ±  5%      +8.8       13.04 ±  3%  perf-profile.calltrace.cycles-pp.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      4.40 ±  5%      +9.0       13.43 ±  3%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      4.15 ±  6%      +9.1       13.22 ±  2%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      4.49 ±  7%      +9.4       13.92 ±  2%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      5.00 ±  8%     +10.1       15.06 ±  2%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      5.01 ±  7%     +10.1       15.11 ±  2%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.common_startup_64
      5.01 ±  7%     +10.1       15.12 ±  2%  perf-profile.calltrace.cycles-pp.start_secondary.common_startup_64
      5.51 ±  6%     +10.1       15.65        perf-profile.calltrace.cycles-pp.common_startup_64
      4.64 ±  2%     +14.4       19.00 ±  2%  perf-profile.calltrace.cycles-pp.asm_sysvec_call_function_single.pv_native_safe_halt.acpi_safe_halt.acpi_idle_do_entry.acpi_idle_enter
     61.00            -9.3       51.68        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     60.98            -9.3       51.67        perf-profile.children.cycles-pp.do_syscall_64
     31.91 ±  3%      -4.4       27.47 ±  2%  perf-profile.children.cycles-pp.__x64_sys_fsync
     31.90 ±  3%      -4.4       27.47 ±  2%  perf-profile.children.cycles-pp.do_fsync
     31.89 ±  3%      -4.4       27.45 ±  2%  perf-profile.children.cycles-pp.btrfs_sync_file
     22.16 ±  5%      -3.6       18.57 ±  7%  perf-profile.children.cycles-pp.ksys_write
     22.15 ±  5%      -3.6       18.56 ±  7%  perf-profile.children.cycles-pp.vfs_write
     21.34 ±  5%      -3.4       17.91 ±  7%  perf-profile.children.cycles-pp.vprintk_emit
     21.24 ±  6%      -3.4       17.82 ±  7%  perf-profile.children.cycles-pp.console_flush_all
     21.24 ±  6%      -3.4       17.82 ±  7%  perf-profile.children.cycles-pp.console_unlock
     21.24 ±  5%      -3.4       17.82 ±  7%  perf-profile.children.cycles-pp.devkmsg_write.cold
     21.24 ±  5%      -3.4       17.82 ±  7%  perf-profile.children.cycles-pp.devkmsg_emit
     23.36 ±  2%      -3.3       20.04 ±  2%  perf-profile.children.cycles-pp.ast_mode_config_helper_atomic_commit_tail
     23.36 ±  2%      -3.3       20.04 ±  2%  perf-profile.children.cycles-pp.drm_atomic_helper_dirtyfb
     23.36 ±  2%      -3.3       20.04 ±  2%  perf-profile.children.cycles-pp.drm_atomic_helper_commit
     23.36 ±  2%      -3.3       20.04 ±  2%  perf-profile.children.cycles-pp.drm_atomic_helper_commit_tail
     23.36 ±  2%      -3.3       20.04 ±  2%  perf-profile.children.cycles-pp.drm_fb_helper_damage_work
     23.36 ±  2%      -3.3       20.04 ±  2%  perf-profile.children.cycles-pp.drm_fbdev_shmem_helper_fb_dirty
     23.36 ±  2%      -3.3       20.04 ±  2%  perf-profile.children.cycles-pp.commit_tail
     23.36 ±  2%      -3.3       20.04 ±  2%  perf-profile.children.cycles-pp.drm_atomic_commit
     23.32 ±  2%      -3.3       20.01 ±  2%  perf-profile.children.cycles-pp.ast_primary_plane_helper_atomic_update
     23.32 ±  2%      -3.3       20.01 ±  2%  perf-profile.children.cycles-pp.drm_fb_memcpy
     23.30 ±  2%      -3.3       20.00 ±  2%  perf-profile.children.cycles-pp.memcpy_toio
     19.59 ±  3%      -3.1       16.50 ±  2%  perf-profile.children.cycles-pp.do_writepages
     19.68 ±  3%      -3.1       16.60 ±  2%  perf-profile.children.cycles-pp.__filemap_fdatawrite_range
     19.64 ±  3%      -3.1       16.57 ±  2%  perf-profile.children.cycles-pp.filemap_fdatawrite_wbc
     16.74 ±  2%      -2.9       13.83 ±  2%  perf-profile.children.cycles-pp.btrfs_submit_chunk
     16.75 ±  2%      -2.9       13.83 ±  2%  perf-profile.children.cycles-pp.btrfs_submit_bbio
     17.98 ±  3%      -2.6       15.34 ±  2%  perf-profile.children.cycles-pp.btrfs_write_marked_extents
     17.79 ±  3%      -2.6       15.18 ±  2%  perf-profile.children.cycles-pp.btree_write_cache_pages
     20.04 ±  3%      -2.4       17.64 ±  2%  perf-profile.children.cycles-pp.btrfs_sync_log
     31.50            -1.9       29.61 ±  2%  perf-profile.children.cycles-pp.process_one_work
     11.88 ±  3%      -1.9        9.99 ±  2%  perf-profile.children.cycles-pp.btrfs_search_slot
      6.52 ±  3%      -1.5        5.00 ±  2%  perf-profile.children.cycles-pp.__submit_bio
      9.03 ±  4%      -1.5        7.52 ±  2%  perf-profile.children.cycles-pp.btrfs_log_dentry_safe
      9.02 ±  4%      -1.5        7.51 ±  2%  perf-profile.children.cycles-pp.btrfs_log_inode_parent
      6.54 ±  3%      -1.5        5.02 ±  2%  perf-profile.children.cycles-pp.__submit_bio_noacct
      8.86 ±  4%      -1.5        7.38 ±  2%  perf-profile.children.cycles-pp.btrfs_log_inode
      9.67 ±  2%      -1.5        8.19 ±  2%  perf-profile.children.cycles-pp.btree_csum_one_bio
      8.05 ±  4%      -1.4        6.68 ±  2%  perf-profile.children.cycles-pp.copy_inode_items_to_log
      6.44 ±  3%      -1.3        5.14 ±  2%  perf-profile.children.cycles-pp.btrfs_insert_empty_items
      6.14 ±  3%      -1.2        4.95        perf-profile.children.cycles-pp.btrfs_submit_bio
      6.93 ±  4%      -1.2        5.76 ±  2%  perf-profile.children.cycles-pp.copy_items
      7.58 ±  2%      -1.1        6.44 ±  3%  perf-profile.children.cycles-pp.__btrfs_check_leaf
      7.58 ±  2%      -1.1        6.44 ±  2%  perf-profile.children.cycles-pp.btrfs_check_leaf
      4.43 ±  7%      -1.1        3.35 ±  3%  perf-profile.children.cycles-pp.btrfs_work_helper
      5.02 ±  3%      -0.9        4.09 ±  2%  perf-profile.children.cycles-pp.brd_submit_bio
      6.60 ±  5%      -0.8        5.75 ±  2%  perf-profile.children.cycles-pp.btrfs_cow_block
      6.58 ±  5%      -0.8        5.74 ±  2%  perf-profile.children.cycles-pp.btrfs_force_cow_block
      4.93 ±  3%      -0.8        4.10 ±  2%  perf-profile.children.cycles-pp.btrfs_csum_file_blocks
      3.60 ±  7%      -0.8        2.77 ±  3%  perf-profile.children.cycles-pp.btrfs_preempt_reclaim_metadata_space
      3.60 ±  7%      -0.8        2.77 ±  3%  perf-profile.children.cycles-pp.flush_space
      4.03 ±  3%      -0.8        3.24 ±  3%  perf-profile.children.cycles-pp.btrfs_create_common
      3.56 ±  3%      -0.7        2.86 ±  3%  perf-profile.children.cycles-pp.btrfs_create_new_inode
      4.23 ±  3%      -0.7        3.55 ±  2%  perf-profile.children.cycles-pp.btrfs_get_32
      3.80 ±  3%      -0.7        3.15 ±  2%  perf-profile.children.cycles-pp.mkdir
      3.75 ±  2%      -0.6        3.11 ±  2%  perf-profile.children.cycles-pp.__x64_sys_mkdir
      3.70 ±  3%      -0.6        3.07 ±  2%  perf-profile.children.cycles-pp.do_mkdirat
      2.82 ±  7%      -0.6        2.19 ±  3%  perf-profile.children.cycles-pp.btrfs_finish_one_ordered
      3.82 ±  4%      -0.6        3.22 ±  3%  perf-profile.children.cycles-pp.log_csums
      3.65 ±  2%      -0.6        3.06 ±  3%  perf-profile.children.cycles-pp.__pi_memcpy
      3.55 ±  5%      -0.6        2.97 ±  2%  perf-profile.children.cycles-pp.btrfs_lookup_csum
      2.37 ±  5%      -0.5        1.83 ±  6%  perf-profile.children.cycles-pp.__x64_sys_openat
      2.36 ±  5%      -0.5        1.82 ±  6%  perf-profile.children.cycles-pp.do_sys_openat2
      2.29 ±  5%      -0.5        1.75 ±  6%  perf-profile.children.cycles-pp.do_filp_open
      3.36 ±  3%      -0.5        2.82 ±  3%  perf-profile.children.cycles-pp.check_leaf_item
      2.28 ±  5%      -0.5        1.75 ±  6%  perf-profile.children.cycles-pp.path_openat
      1.84 ± 11%      -0.5        1.32 ±  3%  perf-profile.children.cycles-pp.__btrfs_run_delayed_refs
      1.84 ± 11%      -0.5        1.32 ±  3%  perf-profile.children.cycles-pp.btrfs_run_delayed_refs
      1.86 ±  3%      -0.5        1.36 ±  4%  perf-profile.children.cycles-pp.start_ordered_ops
      1.84 ±  3%      -0.5        1.35 ±  4%  perf-profile.children.cycles-pp.btrfs_fdatawrite_range
      2.38 ±  3%      -0.5        1.89 ±  4%  perf-profile.children.cycles-pp.setup_items_for_insert
      1.78 ±  3%      -0.5        1.30 ±  4%  perf-profile.children.cycles-pp.btrfs_writepages
      2.40 ±  3%      -0.5        1.92 ±  4%  perf-profile.children.cycles-pp.btrfs_add_link
      2.90 ±  3%      -0.5        2.42 ±  2%  perf-profile.children.cycles-pp.btrfs_mkdir
      1.77 ±  3%      -0.5        1.30 ±  4%  perf-profile.children.cycles-pp.extent_write_cache_pages
      2.94 ±  3%      -0.5        2.47 ±  2%  perf-profile.children.cycles-pp.vfs_mkdir
      1.98 ±  5%      -0.5        1.50 ±  6%  perf-profile.children.cycles-pp.open_last_lookups
      2.28 ±  3%      -0.5        1.82 ±  3%  perf-profile.children.cycles-pp.btrfs_insert_dir_item
      1.68 ±  3%      -0.5        1.22 ±  4%  perf-profile.children.cycles-pp.extent_writepage
      1.88 ±  5%      -0.4        1.44 ±  6%  perf-profile.children.cycles-pp.lookup_open
      2.00 ±  2%      -0.4        1.57 ±  4%  perf-profile.children.cycles-pp.__memmove
      1.65 ±  7%      -0.4        1.24 ±  3%  perf-profile.children.cycles-pp.btrfs_run_delayed_refs_for_head
      1.53 ±  6%      -0.4        1.14 ±  3%  perf-profile.children.cycles-pp.btrfs_async_run_delayed_root
      2.77 ±  5%      -0.4        2.40 ±  2%  perf-profile.children.cycles-pp.btrfs_alloc_tree_block
      1.96 ±  7%      -0.4        1.60 ±  2%  perf-profile.children.cycles-pp.btrfs_commit_transaction
      2.24 ±  4%      -0.4        1.88 ±  3%  perf-profile.children.cycles-pp.copy_extent_buffer_full
      1.80 ±  2%      -0.4        1.44 ±  4%  perf-profile.children.cycles-pp.insert_with_overflow
      2.65 ±  4%      -0.3        2.31 ±  2%  perf-profile.children.cycles-pp.io_serial_out
      1.33 ±  7%      -0.3        1.00 ±  5%  perf-profile.children.cycles-pp.run_delayed_data_ref
      0.93 ± 25%      -0.3        0.61 ± 12%  perf-profile.children.cycles-pp.delay_tsc
      1.66 ±  3%      -0.3        1.35 ±  4%  perf-profile.children.cycles-pp.read_block_for_search
      0.90            -0.3        0.60 ±  7%  perf-profile.children.cycles-pp.extent_writepage_io
      0.81            -0.3        0.52 ±  8%  perf-profile.children.cycles-pp.submit_extent_folio
      0.73 ±  2%      -0.3        0.43 ± 10%  perf-profile.children.cycles-pp.submit_one_bio
      0.44 ±  7%      -0.3        0.19 ± 11%  perf-profile.children.cycles-pp.btrfs_start_ordered_extent_nowriteback
      1.95 ±  6%      -0.3        1.70        perf-profile.children.cycles-pp.btrfs_init_new_buffer
      1.76 ±  5%      -0.2        1.53 ±  3%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      1.33 ±  3%      -0.2        1.12 ±  4%  perf-profile.children.cycles-pp.find_extent_buffer
      0.79 ±  6%      -0.2        0.58 ±  4%  perf-profile.children.cycles-pp.btrfs_insert_delayed_item
      1.02 ±  4%      -0.2        0.81 ±  7%  perf-profile.children.cycles-pp.btrfs_lookup_dir_item
      0.94 ±  4%      -0.2        0.73 ±  4%  perf-profile.children.cycles-pp.btrfs_extend_item
      1.18 ±  2%      -0.2        0.98 ±  2%  perf-profile.children.cycles-pp.crc32c_arch
      1.30 ±  4%      -0.2        1.10 ±  2%  perf-profile.children.cycles-pp.log_all_new_ancestors
      0.96 ±  8%      -0.2        0.76 ±  4%  perf-profile.children.cycles-pp.insert_reserved_file_extent
      1.09 ±  4%      -0.2        0.90 ±  6%  perf-profile.children.cycles-pp.btrfs_bin_search
      1.05 ±  4%      -0.2        0.86 ±  5%  perf-profile.children.cycles-pp.btrfs_release_path
      1.08 ±  2%      -0.2        0.89 ±  2%  perf-profile.children.cycles-pp.crc32c_x86_3way
      0.70 ±  8%      -0.2        0.52 ± 17%  perf-profile.children.cycles-pp.vt_console_print
      1.02 ±  2%      -0.2        0.84 ±  2%  perf-profile.children.cycles-pp.csum_tree_block
      0.66 ± 19%      -0.2        0.48 ±  5%  perf-profile.children.cycles-pp.__mutex_lock
      0.66 ± 19%      -0.2        0.48 ±  5%  perf-profile.children.cycles-pp.mutex_spin_on_owner
      0.69 ±  8%      -0.2        0.51 ± 16%  perf-profile.children.cycles-pp.fbcon_scroll
      0.69 ±  8%      -0.2        0.51 ± 17%  perf-profile.children.cycles-pp.con_scroll
      0.69 ±  8%      -0.2        0.51 ± 17%  perf-profile.children.cycles-pp.lf
      0.67 ±  9%      -0.2        0.50 ± 16%  perf-profile.children.cycles-pp.fbcon_redraw
      0.67 ±  5%      -0.2        0.50 ±  4%  perf-profile.children.cycles-pp.alloc_reserved_extent
      0.98 ±  2%      -0.2        0.82 ±  2%  perf-profile.children.cycles-pp.chksum_update
      0.62 ±  9%      -0.2        0.45 ± 17%  perf-profile.children.cycles-pp.fbcon_putcs
      0.89 ± 10%      -0.2        0.73 ±  2%  perf-profile.children.cycles-pp.btrfs_write_and_wait_transaction
      0.84 ±  5%      -0.2        0.68 ±  6%  perf-profile.children.cycles-pp.btrfs_do_write_iter
      1.70 ±  5%      -0.2        1.54        perf-profile.children.cycles-pp.alloc_extent_buffer
      0.62 ±  4%      -0.2        0.47 ±  4%  perf-profile.children.cycles-pp.btrfs_remove_from_free_space_tree
      0.59 ±  9%      -0.2        0.43 ± 17%  perf-profile.children.cycles-pp.bit_putcs
      0.83 ±  4%      -0.2        0.68 ±  6%  perf-profile.children.cycles-pp.btrfs_buffered_write
      1.02 ±  6%      -0.2        0.87 ±  3%  perf-profile.children.cycles-pp.__btrfs_check_node
      1.02 ±  6%      -0.2        0.87 ±  3%  perf-profile.children.cycles-pp.btrfs_check_node
      0.88 ±  4%      -0.1        0.74 ±  5%  perf-profile.children.cycles-pp.split_leaf
      0.93 ±  6%      -0.1        0.78 ±  2%  perf-profile.children.cycles-pp.read_extent_buffer
      0.85 ±  4%      -0.1        0.70 ±  4%  perf-profile.children.cycles-pp.btrfs_finish_extent_commit
      0.76 ±  6%      -0.1        0.61 ±  3%  perf-profile.children.cycles-pp.writepage_delalloc
      0.82 ±  5%      -0.1        0.68 ±  4%  perf-profile.children.cycles-pp.unpin_extent_range
      0.79 ±  3%      -0.1        0.65 ±  5%  perf-profile.children.cycles-pp.kmem_cache_alloc_noprof
      0.62 ±  5%      -0.1        0.48 ±  4%  perf-profile.children.cycles-pp.set_extent_bit
      0.81 ±  4%      -0.1        0.67 ±  5%  perf-profile.children.cycles-pp.__btrfs_add_free_space
      0.55 ±  4%      -0.1        0.42 ±  4%  perf-profile.children.cycles-pp.remove_free_space_extent
      0.62 ±  5%      -0.1        0.49 ±  6%  perf-profile.children.cycles-pp.btrfs_check_ref_name_override
      0.69 ±  7%      -0.1        0.56 ±  4%  perf-profile.children.cycles-pp.btrfs_reserve_extent
      0.82 ±  4%      -0.1        0.69 ±  4%  perf-profile.children.cycles-pp.btrfs_get_64
      0.69 ±  4%      -0.1        0.56 ±  5%  perf-profile.children.cycles-pp.filename_create
      0.70 ±  5%      -0.1        0.57 ±  5%  perf-profile.children.cycles-pp.copy_one_range
      0.77 ±  5%      -0.1        0.64 ±  5%  perf-profile.children.cycles-pp.steal_from_bitmap
      0.81 ±  5%      -0.1        0.68 ±  5%  perf-profile.children.cycles-pp.wait_for_xmitr
      0.62 ±  4%      -0.1        0.49 ±  9%  perf-profile.children.cycles-pp.btrfs_lookup_dentry
      0.62 ±  4%      -0.1        0.50 ±  9%  perf-profile.children.cycles-pp.btrfs_lookup
      0.59 ±  9%      -0.1        0.47 ±  4%  perf-profile.children.cycles-pp.find_free_extent
      0.61 ±  4%      -0.1        0.49 ±  6%  perf-profile.children.cycles-pp.check_inode_item
      0.46 ±  8%      -0.1        0.34 ±  7%  perf-profile.children.cycles-pp.btrfs_tree_lock_nested
      0.54 ± 10%      -0.1        0.42 ±  5%  perf-profile.children.cycles-pp.btrfs_drop_extents
      0.46 ±  8%      -0.1        0.35 ±  6%  perf-profile.children.cycles-pp.down_write
      0.52 ±  5%      -0.1        0.41 ±  5%  perf-profile.children.cycles-pp.btrfs_set_extent_bit
      0.86 ±  4%      -0.1        0.75 ±  5%  perf-profile.children.cycles-pp.btrfs_comp_cpu_keys
      0.65 ±  6%      -0.1        0.54 ±  2%  perf-profile.children.cycles-pp.btrfs_set_32
      0.50 ±  4%      -0.1        0.40 ±  5%  perf-profile.children.cycles-pp.__cond_resched
      0.65 ±  7%      -0.1        0.54 ±  6%  perf-profile.children.cycles-pp._find_next_zero_bit
      0.39 ± 10%      -0.1        0.28 ± 17%  perf-profile.children.cycles-pp.drm_fbdev_shmem_defio_imageblit
      0.39 ± 10%      -0.1        0.28 ± 17%  perf-profile.children.cycles-pp.sys_imageblit
      0.51 ±  6%      -0.1        0.41 ±  2%  perf-profile.children.cycles-pp.__btrfs_update_delayed_inode
      0.57            -0.1        0.47 ±  5%  perf-profile.children.cycles-pp.xa_load
      0.52 ±  3%      -0.1        0.42 ±  6%  perf-profile.children.cycles-pp.lookup_one_qstr_excl
      0.27 ± 37%      -0.1        0.18 ±  3%  perf-profile.children.cycles-pp.asm_exc_page_fault
      0.52 ±  8%      -0.1        0.43 ±  4%  perf-profile.children.cycles-pp.check_extent_data_item
      0.29 ±  8%      -0.1        0.20 ±  4%  perf-profile.children.cycles-pp.alloc_extent_state
      0.25 ± 37%      -0.1        0.16 ±  5%  perf-profile.children.cycles-pp.exc_page_fault
      0.25 ± 37%      -0.1        0.16 ±  5%  perf-profile.children.cycles-pp.do_user_addr_fault
      0.24 ± 37%      -0.1        0.16 ±  4%  perf-profile.children.cycles-pp.handle_mm_fault
      0.47 ±  2%      -0.1        0.38 ±  3%  perf-profile.children.cycles-pp.up_read
      0.23 ± 37%      -0.1        0.15 ±  4%  perf-profile.children.cycles-pp.__handle_mm_fault
      0.38 ±  3%      -0.1        0.30 ±  8%  perf-profile.children.cycles-pp.start_transaction
      0.31 ±  5%      -0.1        0.23 ±  4%  perf-profile.children.cycles-pp.btrfs_tree_read_lock_nested
      0.41 ±  9%      -0.1        0.33 ±  5%  perf-profile.children.cycles-pp.random
      0.38 ±  4%      -0.1        0.31 ±  5%  perf-profile.children.cycles-pp.push_leaf_right
      0.48 ±  8%      -0.1        0.41 ±  5%  perf-profile.children.cycles-pp.cow_file_range
      0.32 ±  4%      -0.1        0.25 ±  4%  perf-profile.children.cycles-pp.down_read
      0.39 ±  6%      -0.1        0.32 ±  7%  perf-profile.children.cycles-pp.btrfs_clear_extent_bit_changeset
      0.30 ±  6%      -0.1        0.23 ±  7%  perf-profile.children.cycles-pp.btrfs_update_inode
      0.52 ±  4%      -0.1        0.45 ±  5%  perf-profile.children.cycles-pp.clone_leaf
      0.26 ±  5%      -0.1        0.20 ±  8%  perf-profile.children.cycles-pp.btrfs_delayed_update_inode
      0.28 ±  5%      -0.1        0.21 ±  3%  perf-profile.children.cycles-pp.btrfs_leaf_free_space
      0.34 ±  8%      -0.1        0.28 ±  4%  perf-profile.children.cycles-pp.btrfs_insert_delayed_dir_index
      0.27 ±  3%      -0.1        0.20 ±  7%  perf-profile.children.cycles-pp.alloc_eb_folio_array
      0.37 ±  5%      -0.1        0.30 ±  3%  perf-profile.children.cycles-pp.btrfs_next_old_leaf
      0.33 ±  6%      -0.1        0.27 ±  4%  perf-profile.children.cycles-pp.btrfs_read_lock_root_node
      0.32 ±  7%      -0.1        0.26 ±  6%  perf-profile.children.cycles-pp.alloc_inode
      0.26 ± 16%      -0.1        0.19 ±  6%  perf-profile.children.cycles-pp.check_dir_item
      0.28 ±  7%      -0.1        0.21 ±  6%  perf-profile.children.cycles-pp.kmem_cache_alloc_lru_noprof
      0.36 ±  5%      -0.1        0.29 ±  3%  perf-profile.children.cycles-pp.free_extent_buffer
      0.25 ±  6%      -0.1        0.18 ±  7%  perf-profile.children.cycles-pp.btrfs_alloc_page_array
      0.40 ±  9%      -0.1        0.33 ±  8%  perf-profile.children.cycles-pp.__write_extent_buffer
      0.19 ± 20%      -0.1        0.13 ±  7%  perf-profile.children.cycles-pp.__wake_up
      0.24 ±  5%      -0.1        0.18 ±  6%  perf-profile.children.cycles-pp.alloc_pages_bulk_noprof
      0.39 ±  8%      -0.1        0.34 ±  7%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.21 ±  9%      -0.1        0.16 ±  6%  perf-profile.children.cycles-pp.find_lock_delalloc_range
      0.37 ±  8%      -0.1        0.32 ±  7%  perf-profile.children.cycles-pp.tick_nohz_handler
      0.24 ±  5%      -0.1        0.18 ±  2%  perf-profile.children.cycles-pp.leaf_space_used
      0.41 ±  2%      -0.1        0.36 ±  4%  perf-profile.children.cycles-pp.memset_orig
      0.34 ±  5%      -0.1        0.28 ±  4%  perf-profile.children.cycles-pp.btrfs_free_tree_block
      0.23 ±  7%      -0.1        0.18 ± 10%  perf-profile.children.cycles-pp.check_inode_key
      0.30 ±  5%      -0.1        0.25 ±  4%  perf-profile.children.cycles-pp.__push_leaf_right
      0.46 ±  6%      -0.0        0.41 ±  5%  perf-profile.children.cycles-pp.__filemap_get_folio
      0.19 ± 11%      -0.0        0.14 ±  8%  perf-profile.children.cycles-pp.block_group_cache_tree_search
      0.22 ±  7%      -0.0        0.17 ±  5%  perf-profile.children.cycles-pp.btrfs_alloc_inode
      0.22 ±  8%      -0.0        0.17 ±  7%  perf-profile.children.cycles-pp.fill_inode_item
      0.26 ±  4%      -0.0        0.21 ±  7%  perf-profile.children.cycles-pp.btrfs_get_or_create_delayed_node
      0.17 ±  8%      -0.0        0.12 ±  6%  perf-profile.children.cycles-pp.rcu_do_batch
      0.18 ±  7%      -0.0        0.14 ±  3%  perf-profile.children.cycles-pp.__free_frozen_pages
      0.27 ±  6%      -0.0        0.23 ±  9%  perf-profile.children.cycles-pp.btrfs_dirty_folio
      0.25 ±  3%      -0.0        0.20 ±  4%  perf-profile.children.cycles-pp.unlock_up
      0.23 ±  5%      -0.0        0.19 ±  7%  perf-profile.children.cycles-pp.btrfs_log_holes
      0.08 ±  6%      -0.0        0.03 ± 70%  perf-profile.children.cycles-pp.xa_store
      0.19 ±  4%      -0.0        0.15 ±  6%  perf-profile.children.cycles-pp.btrfs_del_items
      0.18 ±  9%      -0.0        0.14 ±  3%  perf-profile.children.cycles-pp.rcu_core
      0.19 ± 10%      -0.0        0.14 ±  6%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
      0.20 ±  6%      -0.0        0.16 ±  8%  perf-profile.children.cycles-pp.up_write
      0.26 ±  6%      -0.0        0.21 ±  9%  perf-profile.children.cycles-pp.inode_logged
      0.19 ±  7%      -0.0        0.14 ±  9%  perf-profile.children.cycles-pp.mod_memcg_lruvec_state
      0.13 ±  8%      -0.0        0.09 ±  7%  perf-profile.children.cycles-pp.btrfs_csum_one_bio
      0.12 ±  8%      -0.0        0.08 ± 13%  perf-profile.children.cycles-pp._raw_read_lock
      0.24 ±  6%      -0.0        0.21 ±  8%  perf-profile.children.cycles-pp.btrfs_read_node_slot
      0.06 ±  7%      -0.0        0.03 ±100%  perf-profile.children.cycles-pp.d_alloc
      0.20 ±  6%      -0.0        0.17 ± 10%  perf-profile.children.cycles-pp.read_tree_block
      0.14 ± 10%      -0.0        0.10 ±  5%  perf-profile.children.cycles-pp.__memcg_slab_post_alloc_hook
      0.07 ±  8%      -0.0        0.04 ± 71%  perf-profile.children.cycles-pp.btrfs_get_chunk_map
      0.12 ±  7%      -0.0        0.09 ±  6%  perf-profile.children.cycles-pp.lookup_fast
      0.18 ±  7%      -0.0        0.14 ±  6%  perf-profile.children.cycles-pp.rcu_all_qs
      0.08 ±  9%      -0.0        0.04 ± 45%  perf-profile.children.cycles-pp.xas_create
      0.17 ±  8%      -0.0        0.14 ±  5%  perf-profile.children.cycles-pp.crypto_shash_digest
      0.15 ±  9%      -0.0        0.12 ±  6%  perf-profile.children.cycles-pp.__btrfs_end_transaction
      0.09 ± 12%      -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.__btrfs_free_extent
      0.11 ± 12%      -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.btrfs_set_64
      0.15 ± 15%      -0.0        0.12 ±  8%  perf-profile.children.cycles-pp.btrfs_block_rsv_release
      0.10 ± 11%      -0.0        0.07 ± 12%  perf-profile.children.cycles-pp.btrfs_verify_level_key
      0.16 ±  7%      -0.0        0.13 ±  7%  perf-profile.children.cycles-pp.chksum_digest
      0.12 ±  7%      -0.0        0.09 ± 17%  perf-profile.children.cycles-pp.__btrfs_release_delayed_node
      0.14 ±  7%      -0.0        0.11 ± 12%  perf-profile.children.cycles-pp.do_open
      0.19 ±  3%      -0.0        0.16 ±  7%  perf-profile.children.cycles-pp.folio_mark_accessed
      0.09 ± 14%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.btrfs_get_16
      0.17 ±  6%      -0.0        0.14 ±  6%  perf-profile.children.cycles-pp.allocate_slab
      0.11 ±  8%      -0.0        0.09 ± 10%  perf-profile.children.cycles-pp.insert_inode_locked4
      0.08 ± 10%      -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.__xa_store
      0.11 ± 10%      -0.0        0.08 ± 11%  perf-profile.children.cycles-pp.inode_insert5
      0.12 ±  9%      -0.0        0.10 ± 11%  perf-profile.children.cycles-pp.__d_alloc
      0.09 ± 11%      -0.0        0.07 ±  8%  perf-profile.children.cycles-pp.btrfs_calculate_block_csum
      0.09 ± 12%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
      0.10 ±  9%      -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.__d_lookup_rcu
      0.09 ± 11%      -0.0        0.07 ± 10%  perf-profile.children.cycles-pp.btrfs_get_8
      0.09 ± 10%      -0.0        0.07 ± 10%  perf-profile.children.cycles-pp.find_inode
      0.08 ± 10%      -0.0        0.06 ± 11%  perf-profile.children.cycles-pp.__mark_inode_dirty
      0.09 ±  8%      -0.0        0.07 ±  8%  perf-profile.children.cycles-pp.getname_flags
      0.08 ± 11%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.copy_for_split
      0.08 ±  8%      +0.0        0.11 ± 11%  perf-profile.children.cycles-pp.folio_unlock
      0.10 ± 16%      +0.0        0.14 ±  9%  perf-profile.children.cycles-pp.work_busy
      0.31 ±  5%      +0.0        0.36 ±  5%  perf-profile.children.cycles-pp.__filemap_add_folio
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.x2apic_send_IPI
      0.04 ± 71%      +0.1        0.09 ± 10%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.btrfs_bio_counter_sub
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.sb_clear_inode_writeback
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.update_entity_lag
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.worker_enter_idle
      0.17 ±  8%      +0.1        0.23 ± 10%  perf-profile.children.cycles-pp.__xa_clear_mark
      0.00            +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.__rdgsbase_inactive
      0.10 ± 15%      +0.1        0.16 ±  8%  perf-profile.children.cycles-pp.update_rq_clock_task
      0.00            +0.1        0.06 ± 13%  perf-profile.children.cycles-pp.local_clock_noinstr
      0.00            +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.pick_task_fair
      0.01 ±223%      +0.1        0.08 ±  6%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.01 ±223%      +0.1        0.08 ± 22%  perf-profile.children.cycles-pp.do_perf_trace_sched_stat_runtime
      0.22 ± 11%      +0.1        0.29 ±  4%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.00            +0.1        0.07 ± 12%  perf-profile.children.cycles-pp.get_cpu_device
      0.08 ± 12%      +0.1        0.15 ± 10%  perf-profile.children.cycles-pp.xas_set_mark
      0.06 ± 13%      +0.1        0.13 ± 12%  perf-profile.children.cycles-pp.set_next_entity
      0.36 ±  7%      +0.1        0.43 ±  5%  perf-profile.children.cycles-pp.end_bbio_data_write
      0.13 ±  7%      +0.1        0.21 ±  7%  perf-profile.children.cycles-pp.raw_spin_rq_lock_nested
      0.13 ±  5%      +0.1        0.21 ±  6%  perf-profile.children.cycles-pp.xas_clear_mark
      0.06 ±  9%      +0.1        0.14 ± 10%  perf-profile.children.cycles-pp.read_tsc
      0.00            +0.1        0.08 ± 16%  perf-profile.children.cycles-pp.strnlen
      0.00            +0.1        0.08 ±  4%  perf-profile.children.cycles-pp.__smp_call_single_queue
      0.01 ±223%      +0.1        0.09 ±  7%  perf-profile.children.cycles-pp.__get_next_timer_interrupt
      0.03 ± 70%      +0.1        0.12 ±  8%  perf-profile.children.cycles-pp.irqtime_account_irq
      0.01 ±223%      +0.1        0.10 ± 13%  perf-profile.children.cycles-pp.finish_task_switch
      0.00            +0.1        0.08 ±  8%  perf-profile.children.cycles-pp.__wrgsbase_inactive
      0.00            +0.1        0.09 ±  7%  perf-profile.children.cycles-pp.cpuacct_charge
      0.00            +0.1        0.09 ±  7%  perf-profile.children.cycles-pp.wake_page_function
      0.04 ± 44%      +0.1        0.13 ±  9%  perf-profile.children.cycles-pp.native_apic_msr_eoi
      0.23 ± 10%      +0.1        0.32 ±  7%  perf-profile.children.cycles-pp.ktime_get
      0.00            +0.1        0.09 ±  7%  perf-profile.children.cycles-pp.ct_kernel_exit_state
      0.00            +0.1        0.09 ±  7%  perf-profile.children.cycles-pp.wake_bit_function
      0.05 ± 46%      +0.1        0.15 ±  6%  perf-profile.children.cycles-pp.bio_free
      0.07 ± 11%      +0.1        0.16 ± 11%  perf-profile.children.cycles-pp.set_next_task_fair
      0.00            +0.1        0.10 ± 12%  perf-profile.children.cycles-pp.bio_endio
      0.00            +0.1        0.10 ± 10%  perf-profile.children.cycles-pp.cpuidle_governor_latency_req
      0.03 ±147%      +0.1        0.13 ±  4%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.00            +0.1        0.10 ± 14%  perf-profile.children.cycles-pp.wq_worker_running
      0.01 ±223%      +0.1        0.12 ± 11%  perf-profile.children.cycles-pp.wake_affine
      0.00            +0.1        0.12 ±  9%  perf-profile.children.cycles-pp.available_idle_cpu
      0.00            +0.1        0.12 ± 16%  perf-profile.children.cycles-pp.tick_nohz_idle_enter
      0.00            +0.1        0.12 ±  8%  perf-profile.children.cycles-pp.wake_up_bit
      0.12 ± 10%      +0.1        0.25 ±  4%  perf-profile.children.cycles-pp.__slab_free
      0.06 ± 60%      +0.1        0.18 ±  2%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.02 ±141%      +0.1        0.14 ±  7%  perf-profile.children.cycles-pp.__switch_to
      0.00            +0.1        0.13 ±  2%  perf-profile.children.cycles-pp.folio_wake_bit
      0.48 ±  3%      +0.1        0.61 ±  3%  perf-profile.children.cycles-pp.kmem_cache_free
      0.08 ± 10%      +0.1        0.21 ±  5%  perf-profile.children.cycles-pp.buffer_tree_clear_mark
      0.06 ± 19%      +0.1        0.19 ±  8%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.13 ± 11%      +0.1        0.27 ±  5%  perf-profile.children.cycles-pp.update_load_avg
      0.40 ±  5%      +0.1        0.54 ±  3%  perf-profile.children.cycles-pp.btrfs_bio_end_io
      0.02 ±223%      +0.1        0.16 ±  7%  perf-profile.children.cycles-pp.perf_tp_event
      0.12 ±  6%      +0.1        0.26 ±  4%  perf-profile.children.cycles-pp.enqueue_entity
      0.07 ± 18%      +0.1        0.22 ±  7%  perf-profile.children.cycles-pp.update_se
      0.06 ± 13%      +0.2        0.20 ±  7%  perf-profile.children.cycles-pp.tick_nohz_stop_idle
      0.06 ± 11%      +0.2        0.21 ±  4%  perf-profile.children.cycles-pp.__resched_curr
      0.04 ± 71%      +0.2        0.19 ±  5%  perf-profile.children.cycles-pp.nr_iowait_cpu
      0.02 ± 99%      +0.2        0.18 ±  7%  perf-profile.children.cycles-pp.poll_idle
      0.18 ± 23%      +0.2        0.34 ±  4%  perf-profile.children.cycles-pp.__wake_up_common
      0.00            +0.2        0.16 ±  5%  perf-profile.children.cycles-pp.pwq_tryinc_nr_active
      0.07 ± 12%      +0.2        0.24 ±  3%  perf-profile.children.cycles-pp.wakeup_preempt
      0.08 ± 35%      +0.2        0.25 ±  4%  perf-profile.children.cycles-pp.do_perf_trace_sched_wakeup_template
      0.06 ± 45%      +0.2        0.24 ±  7%  perf-profile.children.cycles-pp.sched_clock
      0.13 ± 22%      +0.2        0.30 ±  9%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      0.07 ± 11%      +0.2        0.24 ±  5%  perf-profile.children.cycles-pp.select_task_rq
      0.08 ± 16%      +0.2        0.26 ±  5%  perf-profile.children.cycles-pp.native_sched_clock
      0.08 ± 17%      +0.2        0.25 ±  5%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.12 ± 22%      +0.2        0.30 ±  7%  perf-profile.children.cycles-pp.update_curr
      0.01 ±223%      +0.2        0.19 ±  9%  perf-profile.children.cycles-pp.__x2apic_send_IPI_dest
      0.10 ± 16%      +0.2        0.29 ±  8%  perf-profile.children.cycles-pp.update_rq_clock
      0.00            +0.2        0.19 ± 11%  perf-profile.children.cycles-pp.bit_wait_io
      0.06 ±  6%      +0.2        0.25 ±  4%  perf-profile.children.cycles-pp.irqentry_enter
      0.76 ±  4%      +0.2        0.97 ±  3%  perf-profile.children.cycles-pp.__folio_end_writeback
      0.23 ± 14%      +0.2        0.45 ± 11%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.10 ±  7%      +0.2        0.33 ±  3%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.06 ± 14%      +0.2        0.29 ±  2%  perf-profile.children.cycles-pp.llist_reverse_order
      0.18 ±  3%      +0.2        0.42 ±  5%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.00            +0.2        0.24 ±  5%  perf-profile.children.cycles-pp.folio_wait_bit_common
      0.16 ±  7%      +0.2        0.41 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.14 ± 10%      +0.3        0.40 ±  4%  perf-profile.children.cycles-pp.tick_irq_enter
      0.00            +0.3        0.26 ±  7%  perf-profile.children.cycles-pp.__wait_on_bit
      0.00            +0.3        0.26 ±  7%  perf-profile.children.cycles-pp.out_of_line_wait_on_bit
      0.19 ±  3%      +0.3        0.46 ±  5%  perf-profile.children.cycles-pp.enqueue_task
      0.00            +0.3        0.27 ±  5%  perf-profile.children.cycles-pp.folio_wait_writeback
      0.30 ± 10%      +0.3        0.57 ± 11%  perf-profile.children.cycles-pp.__pick_next_task
      0.13 ± 14%      +0.3        0.41 ±  2%  perf-profile.children.cycles-pp.__btrfs_wait_marked_extents
      0.15 ± 14%      +0.3        0.43 ±  3%  perf-profile.children.cycles-pp.btrfs_wait_tree_log_extents
      0.00            +0.3        0.29 ±  5%  perf-profile.children.cycles-pp.__filemap_fdatawait_range
      0.24 ± 14%      +0.3        0.54 ±  4%  perf-profile.children.cycles-pp.dequeue_entity
      0.19 ± 25%      +0.3        0.49 ±  4%  perf-profile.children.cycles-pp.menu_select
      0.16 ± 10%      +0.3        0.47 ±  5%  perf-profile.children.cycles-pp.irq_enter_rcu
      0.00            +0.3        0.31 ±  5%  perf-profile.children.cycles-pp.btrfs_btree_wait_writeback_range
      0.00            +0.3        0.31 ±  4%  perf-profile.children.cycles-pp.filemap_fdatawait_range
      0.27 ± 11%      +0.3        0.58 ±  4%  perf-profile.children.cycles-pp.dequeue_entities
      0.29 ± 10%      +0.3        0.61 ±  3%  perf-profile.children.cycles-pp.dequeue_task_fair
      0.12 ±  6%      +0.3        0.45 ±  3%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.30 ± 12%      +0.3        0.64 ±  3%  perf-profile.children.cycles-pp.try_to_block_task
      0.77 ±  4%      +0.3        1.11 ±  3%  perf-profile.children.cycles-pp.folio_end_writeback_no_dropbehind
      0.86 ±  4%      +0.4        1.21 ±  3%  perf-profile.children.cycles-pp.folio_end_writeback
      0.53 ±  2%      +0.4        0.89 ±  4%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.00            +0.4        0.39 ±  7%  perf-profile.children.cycles-pp.io_schedule
      0.33 ± 26%      +0.4        0.73 ±  3%  perf-profile.children.cycles-pp.schedule_idle
      0.26 ±  6%      +0.5        0.72 ±  2%  perf-profile.children.cycles-pp.ttwu_do_activate
      0.90 ±  4%      +0.5        1.44 ±  2%  perf-profile.children.cycles-pp.end_bbio_meta_write
      0.00            +0.7        0.71 ±  2%  perf-profile.children.cycles-pp.clone_write_end_io_work
      0.35 ±  3%      +0.7        1.07 ±  2%  perf-profile.children.cycles-pp.sched_ttwu_pending
      0.33 ± 13%      +0.8        1.14 ±  2%  perf-profile.children.cycles-pp.try_to_wake_up
      0.18 ± 11%      +0.8        1.00 ±  3%  perf-profile.children.cycles-pp.kick_pool
      0.70 ±  8%      +0.8        1.53 ±  4%  perf-profile.children.cycles-pp.schedule
      0.25 ±  9%      +1.1        1.38 ±  3%  perf-profile.children.cycles-pp.__queue_work
      0.48 ±  3%      +1.2        1.63        perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      1.02 ± 13%      +1.2        2.18 ±  3%  perf-profile.children.cycles-pp.__schedule
      0.28 ± 10%      +1.2        1.46 ±  4%  perf-profile.children.cycles-pp.queue_work_on
      0.51 ±  2%      +1.3        1.77        perf-profile.children.cycles-pp.__sysvec_call_function_single
      0.00            +1.7        1.66 ±  2%  perf-profile.children.cycles-pp.orig_write_end_io_work
      1.14 ±  6%      +1.8        2.94 ±  2%  perf-profile.children.cycles-pp.sysvec_call_function_single
      3.14 ±  5%      +8.1       11.25 ±  2%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      4.46 ±  4%      +8.7       13.19 ±  2%  perf-profile.children.cycles-pp.pv_native_safe_halt
      4.46 ±  4%      +8.7       13.21 ±  2%  perf-profile.children.cycles-pp.acpi_safe_halt
      4.47 ±  4%      +8.8       13.22 ±  2%  perf-profile.children.cycles-pp.acpi_idle_do_entry
      4.48 ±  4%      +8.8       13.24 ±  2%  perf-profile.children.cycles-pp.acpi_idle_enter
      4.61 ±  4%      +9.0       13.64 ±  2%  perf-profile.children.cycles-pp.cpuidle_enter_state
      4.64 ±  5%      +9.1       13.72 ±  2%  perf-profile.children.cycles-pp.cpuidle_enter
      4.99 ±  5%      +9.5       14.45 ±  2%  perf-profile.children.cycles-pp.cpuidle_idle_call
      5.01 ±  7%     +10.1       15.12 ±  2%  perf-profile.children.cycles-pp.start_secondary
      5.51 ±  6%     +10.1       15.62        perf-profile.children.cycles-pp.do_idle
      5.51 ±  6%     +10.1       15.65        perf-profile.children.cycles-pp.common_startup_64
      5.51 ±  6%     +10.1       15.65        perf-profile.children.cycles-pp.cpu_startup_entry
     23.25 ±  2%      -3.3       19.94 ±  2%  perf-profile.self.cycles-pp.memcpy_toio
      3.81 ±  3%      -0.6        3.18 ±  3%  perf-profile.self.cycles-pp.btrfs_get_32
      3.49 ±  2%      -0.6        2.94 ±  3%  perf-profile.self.cycles-pp.__pi_memcpy
      2.00 ±  2%      -0.4        1.57 ±  4%  perf-profile.self.cycles-pp.__memmove
      2.65 ±  4%      -0.3        2.31 ±  2%  perf-profile.self.cycles-pp.io_serial_out
      0.93 ± 25%      -0.3        0.61 ± 12%  perf-profile.self.cycles-pp.delay_tsc
      1.08 ±  4%      -0.2        0.88 ±  5%  perf-profile.self.cycles-pp.btrfs_bin_search
      1.07 ±  2%      -0.2        0.88 ±  2%  perf-profile.self.cycles-pp.crc32c_x86_3way
      0.66 ± 19%      -0.2        0.48 ±  5%  perf-profile.self.cycles-pp.mutex_spin_on_owner
      0.98 ±  4%      -0.2        0.82 ±  3%  perf-profile.self.cycles-pp.__btrfs_check_leaf
      0.66 ±  8%      -0.1        0.53 ±  6%  perf-profile.self.cycles-pp.btrfs_force_cow_block
      0.77 ±  4%      -0.1        0.64 ±  4%  perf-profile.self.cycles-pp.btrfs_get_64
      0.52 ±  4%      -0.1        0.41 ±  7%  perf-profile.self.cycles-pp.kmem_cache_alloc_noprof
      0.45 ±  5%      -0.1        0.34 ±  4%  perf-profile.self.cycles-pp.btrfs_search_slot
      0.98 ±  4%      -0.1        0.87 ±  4%  perf-profile.self.cycles-pp.check_leaf_item
      0.39 ± 10%      -0.1        0.28 ± 17%  perf-profile.self.cycles-pp.sys_imageblit
      0.77 ±  5%      -0.1        0.66 ±  5%  perf-profile.self.cycles-pp.btrfs_comp_cpu_keys
      0.60 ±  7%      -0.1        0.50 ±  6%  perf-profile.self.cycles-pp._find_next_zero_bit
      0.58 ±  6%      -0.1        0.48 ±  3%  perf-profile.self.cycles-pp.btrfs_set_32
      0.60 ±  5%      -0.1        0.50 ±  4%  perf-profile.self.cycles-pp.find_extent_buffer
      0.46 ±  2%      -0.1        0.37 ±  2%  perf-profile.self.cycles-pp.up_read
      0.39 ± 10%      -0.1        0.32 ±  6%  perf-profile.self.cycles-pp.random
      0.21 ±  5%      -0.1        0.16 ±  9%  perf-profile.self.cycles-pp.down_write
      0.24 ±  3%      -0.1        0.19 ±  7%  perf-profile.self.cycles-pp.__cond_resched
      0.40 ±  3%      -0.0        0.35 ±  3%  perf-profile.self.cycles-pp.memset_orig
      0.24 ±  4%      -0.0        0.20 ±  5%  perf-profile.self.cycles-pp.setup_items_for_insert
      0.08 ± 12%      -0.0        0.04 ± 71%  perf-profile.self.cycles-pp.start_transaction
      0.12 ± 11%      -0.0        0.08 ± 13%  perf-profile.self.cycles-pp._raw_read_lock
      0.14 ± 12%      -0.0        0.10 ±  6%  perf-profile.self.cycles-pp.block_group_cache_tree_search
      0.07 ±  9%      -0.0        0.04 ± 71%  perf-profile.self.cycles-pp.leaf_space_used
      0.08 ± 15%      -0.0        0.04 ± 45%  perf-profile.self.cycles-pp.rwsem_spin_on_owner
      0.19 ±  7%      -0.0        0.16 ±  6%  perf-profile.self.cycles-pp.down_read
      0.14 ± 10%      -0.0        0.11 ± 10%  perf-profile.self.cycles-pp.check_inode_key
      0.18 ±  6%      -0.0        0.15 ±  8%  perf-profile.self.cycles-pp.set_extent_bit
      0.19 ±  7%      -0.0        0.16 ±  6%  perf-profile.self.cycles-pp.btrfs_root_node
      0.14 ± 11%      -0.0        0.11 ±  8%  perf-profile.self.cycles-pp.mod_memcg_lruvec_state
      0.07 ± 11%      -0.0        0.04 ± 71%  perf-profile.self.cycles-pp.__free_frozen_pages
      0.11 ±  9%      -0.0        0.08 ± 13%  perf-profile.self.cycles-pp.alloc_pages_bulk_noprof
      0.16 ±  4%      -0.0        0.14 ±  3%  perf-profile.self.cycles-pp.unlock_up
      0.13 ±  5%      -0.0        0.10 ± 11%  perf-profile.self.cycles-pp.check_buffer_tree_ref
      0.09 ±  5%      -0.0        0.07 ± 11%  perf-profile.self.cycles-pp.kfree
      0.07 ± 14%      -0.0        0.04 ± 45%  perf-profile.self.cycles-pp.btrfs_clear_extent_bit_changeset
      0.08 ± 11%      -0.0        0.06 ± 13%  perf-profile.self.cycles-pp.btrfs_get_8
      0.10 ± 11%      -0.0        0.08 ±  4%  perf-profile.self.cycles-pp.btrfs_set_64
      0.13 ±  8%      -0.0        0.11 ±  6%  perf-profile.self.cycles-pp.rcu_all_qs
      0.10 ±  9%      -0.0        0.07 ±  9%  perf-profile.self.cycles-pp.__d_lookup_rcu
      0.13 ±  8%      -0.0        0.11 ±  6%  perf-profile.self.cycles-pp.read_block_for_search
      0.14 ±  4%      -0.0        0.12 ±  8%  perf-profile.self.cycles-pp.up_write
      0.14 ±  5%      -0.0        0.12 ±  9%  perf-profile.self.cycles-pp.btrfs_release_path
      0.10 ± 10%      -0.0        0.08 ±  8%  perf-profile.self.cycles-pp.free_extent_buffer
      0.10 ±  8%      -0.0        0.08 ±  8%  perf-profile.self.cycles-pp.rwsem_down_write_slowpath
      0.09 ± 10%      -0.0        0.07 ± 10%  perf-profile.self.cycles-pp.find_inode
      0.10 ±  8%      -0.0        0.08 ± 13%  perf-profile.self.cycles-pp.check_inode_item
      0.06 ± 11%      +0.0        0.08 ± 11%  perf-profile.self.cycles-pp.___slab_alloc
      0.07 ±  9%      +0.0        0.10 ± 11%  perf-profile.self.cycles-pp.folio_unlock
      0.04 ± 44%      +0.0        0.08 ± 18%  perf-profile.self.cycles-pp.__xa_set_mark
      0.06 ± 16%      +0.0        0.10 ± 11%  perf-profile.self.cycles-pp.update_rq_clock_task
      0.02 ±141%      +0.0        0.06 ±  8%  perf-profile.self.cycles-pp.sched_balance_newidle
      0.06 ± 46%      +0.0        0.10 ±  9%  perf-profile.self.cycles-pp.btrfs_map_block
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.x2apic_send_IPI
      0.17 ± 10%      +0.1        0.22 ±  4%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.00            +0.1        0.05 ±  7%  perf-profile.self.cycles-pp.update_se
      0.00            +0.1        0.06 ±  9%  perf-profile.self.cycles-pp.worker_enter_idle
      0.02 ±141%      +0.1        0.08 ± 12%  perf-profile.self.cycles-pp.pick_next_task_fair
      0.02 ±142%      +0.1        0.08 ±  6%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.00            +0.1        0.06 ±  9%  perf-profile.self.cycles-pp.do_perf_trace_sched_wakeup_template
      0.00            +0.1        0.06 ±  9%  perf-profile.self.cycles-pp.schedule
      0.00            +0.1        0.06 ± 17%  perf-profile.self.cycles-pp.__smp_call_single_queue
      0.01 ±223%      +0.1        0.07 ± 12%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.00            +0.1        0.06 ± 17%  perf-profile.self.cycles-pp.finish_task_switch
      0.00            +0.1        0.06 ± 17%  perf-profile.self.cycles-pp.tick_irq_enter
      0.01 ±223%      +0.1        0.08 ± 14%  perf-profile.self.cycles-pp.dequeue_entity
      0.00            +0.1        0.07 ± 11%  perf-profile.self.cycles-pp.irq_enter_rcu
      0.07 ± 16%      +0.1        0.14 ±  9%  perf-profile.self.cycles-pp.xas_set_mark
      0.00            +0.1        0.07 ±  9%  perf-profile.self.cycles-pp.cpuidle_enter
      0.00            +0.1        0.07 ± 12%  perf-profile.self.cycles-pp.get_cpu_device
      0.00            +0.1        0.07 ± 10%  perf-profile.self.cycles-pp.sched_ttwu_pending
      0.00            +0.1        0.07 ±  6%  perf-profile.self.cycles-pp.enqueue_entity
      0.00            +0.1        0.08 ± 16%  perf-profile.self.cycles-pp.strnlen
      0.03 ±100%      +0.1        0.10 ± 12%  perf-profile.self.cycles-pp.update_load_avg
      0.16 ± 17%      +0.1        0.24 ±  6%  perf-profile.self.cycles-pp.__folio_end_writeback
      0.12 ±  5%      +0.1        0.20 ±  5%  perf-profile.self.cycles-pp.xas_clear_mark
      0.06 ±  9%      +0.1        0.14 ± 10%  perf-profile.self.cycles-pp.read_tsc
      0.02 ±149%      +0.1        0.11 ±  6%  perf-profile.self.cycles-pp.prepare_task_switch
      0.00            +0.1        0.08 ±  8%  perf-profile.self.cycles-pp.__wrgsbase_inactive
      0.00            +0.1        0.08 ± 17%  perf-profile.self.cycles-pp.wq_worker_running
      0.00            +0.1        0.09 ±  5%  perf-profile.self.cycles-pp.cpuacct_charge
      0.04 ± 72%      +0.1        0.13 ±  8%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.00            +0.1        0.09 ±  7%  perf-profile.self.cycles-pp.ct_kernel_exit_state
      0.04 ± 45%      +0.1        0.13 ±  5%  perf-profile.self.cycles-pp.cpuidle_idle_call
      0.04 ± 44%      +0.1        0.13 ± 11%  perf-profile.self.cycles-pp.native_apic_msr_eoi
      0.00            +0.1        0.09 ±  7%  perf-profile.self.cycles-pp.btrfs_submit_bio
      0.00            +0.1        0.09 ± 15%  perf-profile.self.cycles-pp.try_to_wake_up
      0.00            +0.1        0.10 ± 10%  perf-profile.self.cycles-pp.bio_endio
      0.01 ±223%      +0.1        0.11 ± 10%  perf-profile.self.cycles-pp.__queue_work
      0.09 ± 21%      +0.1        0.20 ±  5%  perf-profile.self.cycles-pp.menu_select
      0.00            +0.1        0.12 ± 13%  perf-profile.self.cycles-pp.ttwu_queue_wakelist
      0.02 ±141%      +0.1        0.13 ±  8%  perf-profile.self.cycles-pp.__switch_to
      0.01 ±223%      +0.1        0.12 ± 11%  perf-profile.self.cycles-pp.perf_tp_event
      0.00            +0.1        0.12 ±  9%  perf-profile.self.cycles-pp.available_idle_cpu
      0.12 ± 10%      +0.1        0.25 ±  4%  perf-profile.self.cycles-pp.__slab_free
      0.06 ± 45%      +0.1        0.19 ±  7%  perf-profile.self.cycles-pp.update_rq_clock
      0.00            +0.1        0.14 ±  4%  perf-profile.self.cycles-pp.end_bbio_meta_write
      0.02 ±142%      +0.1        0.16 ± 15%  perf-profile.self.cycles-pp.kick_pool
      0.15 ±  7%      +0.1        0.30 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.00            +0.1        0.14 ±  7%  perf-profile.self.cycles-pp.do_idle
      0.00            +0.1        0.15 ± 10%  perf-profile.self.cycles-pp.clone_write_end_io_work
      0.06 ± 11%      +0.2        0.21 ±  3%  perf-profile.self.cycles-pp.__resched_curr
      0.04 ± 71%      +0.2        0.19 ±  6%  perf-profile.self.cycles-pp.nr_iowait_cpu
      0.02 ±141%      +0.2        0.17 ±  5%  perf-profile.self.cycles-pp.poll_idle
      0.00            +0.2        0.16 ±  4%  perf-profile.self.cycles-pp.pwq_tryinc_nr_active
      0.08 ± 14%      +0.2        0.24 ±  5%  perf-profile.self.cycles-pp.native_sched_clock
      0.12 ± 23%      +0.2        0.29 ±  9%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.01 ±223%      +0.2        0.18 ±  4%  perf-profile.self.cycles-pp.process_one_work
      0.01 ±223%      +0.2        0.18 ±  9%  perf-profile.self.cycles-pp.__x2apic_send_IPI_dest
      0.02 ±141%      +0.2        0.20 ±  8%  perf-profile.self.cycles-pp.irqentry_enter
      0.12 ± 16%      +0.2        0.32 ±  6%  perf-profile.self.cycles-pp.__schedule
      0.00            +0.2        0.22 ±  4%  perf-profile.self.cycles-pp.worker_thread
      0.06 ± 14%      +0.2        0.28 ±  2%  perf-profile.self.cycles-pp.llist_reverse_order
      0.10 ±  7%      +0.2        0.33 ±  3%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.05 ± 46%      +0.2        0.28 ±  3%  perf-profile.self.cycles-pp.__flush_smp_call_function_queue
      0.50 ±  2%      +0.3        0.76 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      2.42            +6.8        9.23 ±  2%  perf-profile.self.cycles-pp.pv_native_safe_halt




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


