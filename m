Return-Path: <linux-btrfs+bounces-4733-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B895E8BB3BB
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2024 21:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA8D21C23A43
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2024 19:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D014158A1B;
	Fri,  3 May 2024 19:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fHBPbz+J"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892C0155303;
	Fri,  3 May 2024 19:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714763377; cv=fail; b=VUjJVCNlDQ1e0rLB5UFqD9DxKqAcRWZ28gGy+uO06n4VY/2342YXs5YjMSxayRTRQGi8iLrtnNTmJDdByo6ZU/wjkUFhdtqSM7fxCZ/ZuBv1IaiWMD/kfdl/Xi5+Uj/hRedBgcsRa+eiLBrIlJbQBzGqu9Q4gi2q7tJKxSDtq8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714763377; c=relaxed/simple;
	bh=Qt03UTT0bC4sn0ud/5TrF2pwhKUvTulRzOy4cNpd2G8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=baqa83oqxZtlYngsxow+Isr3L3EzwRnaQYYxWbmcGDYIE5WMXuIjCqGCYGlfXIlidaiDi/MJf3LOYfuTlRt02MBUHpjMloNZomBR4hlN+FCEjdvD5G4DXuHgWuAH+HvqlVYGg7ryzjxl46B7nnN70obso3CUadayzRfT55kmBRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fHBPbz+J; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714763376; x=1746299376;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Qt03UTT0bC4sn0ud/5TrF2pwhKUvTulRzOy4cNpd2G8=;
  b=fHBPbz+JwnesO0y4UrbeE7u+PDTyX5vKUlPmzFHd2p22DBd5dEEcvsbB
   2F4THxpx0aEzVlOFSZnagtPGkWT0RxkcdKzhEuVQUJFd3FnUgoyhV70Q5
   sy/JkeJrojrQzZzPsEvBjM9/1c3bfK3VFh0fjsOMmzxs3q1JnkTdVeMPF
   gFAtVXreh6D0C91gKGnlNU8og2DHYUuQ75MLMTdW50JGTdbT20t4PaMLD
   /TBCcPT37+gk0MyanzogKrNKUh1LHdRzXZ8/ItLHiQR2IpmE6TKpTkR7D
   ZJU+B9v56VmG0eNCUI+OubfArHJ0sJMs8/fLFlq0ylarhKS6zRxMiI94w
   A==;
X-CSE-ConnectionGUID: TVpfcL6UQwyYWWATsPQi3g==
X-CSE-MsgGUID: YeQNbHH0TiuzsoO30U4+TA==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="21199182"
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="21199182"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 12:09:35 -0700
X-CSE-ConnectionGUID: QDt+2RQxQp68NC15P6nOmg==
X-CSE-MsgGUID: aBbNEll9Qvufu3iwIpUt4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="27559956"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 May 2024 12:09:35 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 3 May 2024 12:09:34 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 3 May 2024 12:09:34 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 3 May 2024 12:09:34 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 3 May 2024 12:09:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DKtOzejxiqQaJAubI9Zv8qxiVo3EnOySwkw2PuKuxrmpdrwhTwjWRl6HtJIMf4qyL8pqa6nxqSr3X8knsIiJih2qQG73q2UjROBm73si9edmLFMFY7/x7HWofj3XTaXHqQ1yscRZg0xX3dPoycOJ7bJK5wO56hPXNuUesr8LTmFAvmeUyovpLQRGKF2cKciZysXoW5/BgIK/lgGtWwRyN2TogiYQqJV2uagWHS8YDxljqdr9rGJFmvvFbKbY5rZgmFfaQz6aBE1cQrJk4Yq32FE5/SYZcKMCf842I6UAf8mvkIj0WxbGu4BwzJlqV5UTYqSzUzjx5icZ8k162N7HHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kyAzt/SELrjJzVQ+TqNf+JKtnYe8KTuvJYQ8OM/f98A=;
 b=Sk8J5KVziKT+REybkNfJjpT4Y7m4YXqs4gehyCt5a9euEbQIlLxr0mE9knROL1e4meUYj01T/HzN6R5eK3xuaYYULq+jNk5ceGPjsNf3bMO2qKYSbiEN6E/s6weyyATWmVIDhL48Edyk468+Iplk451oUz6YqVsQOfPDIJEA4YAucK882YABwMT1KFoOmCoObhAWP3XFoz4bB+ZzUWk2jimZRrNLHE1gvvlhe4+nKK5NAeZ//EOLZN5quKTDAPccdKIZ3QGTGt+0n44KWS2PdRhK13m/F0JCvUaoJGinXYq+pUvcstsSG/U/wS5q/ZiAYbDCeBTjiBFR+0+C0Q1QBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SJ0PR11MB5072.namprd11.prod.outlook.com (2603:10b6:a03:2db::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Fri, 3 May
 2024 19:09:31 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%4]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 19:09:31 +0000
Date: Fri, 3 May 2024 12:09:27 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Alison Schofield <alison.schofield@intel.com>, Ira Weiny
	<ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Navneet Singh
	<navneet.singh@intel.com>, Dan Williams <dan.j.williams@intel.com>, Davidlohr
 Bueso <dave@stgolabs.net>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-btrfs@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 05/26] cxl/core: Simplify cxl_dpa_set_mode()
Message-ID: <6635366717079_e1f582941d@iweiny-mobl.notmuch>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <20240324-dcd-type2-upstream-v1-5-b7b00d623625@intel.com>
 <ZhSPHvoTHl28GXt1@aschofie-mobl2>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZhSPHvoTHl28GXt1@aschofie-mobl2>
X-ClientProxiedBy: SJ0PR05CA0160.namprd05.prod.outlook.com
 (2603:10b6:a03:339::15) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SJ0PR11MB5072:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d3dae98-a683-4208-68f7-08dc6ba48ff7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?y1Tk6aBgYJfG3imdyiCvKFk3ayR5AwRZj+EQC+Aj7LqcvQmbvVzDtEpDpJRk?=
 =?us-ascii?Q?nSGxYKz65sxaIpcNqP7u5QGB/uKV15+E0tC9RU3KSUD1qxcGX6JsT+qlB7+a?=
 =?us-ascii?Q?jUZoXL0MspIKrH1rNgUhwB51BC8EjDE/ubj37vJBnWi8x959dCgg7mEHW7w8?=
 =?us-ascii?Q?HbGnW5e43xtU7tjcGPi2+Ps1wuSGbVS+XYqxmKKOMgUomUrAPsnl5LFmpHHV?=
 =?us-ascii?Q?0Rvv6PpcQmcZhOBoDrzAt+A/cQTEwE9vk6sEC7JsIQyjsKgb48uAjGRIPnnh?=
 =?us-ascii?Q?QotegjVXEmRLvwQuZXyIPdeiaiMqty0r7/ArA4ivZEl14uTyPeulZEP6NoTF?=
 =?us-ascii?Q?7RjCUCmiBIEBmFK6JnQsjWLnsEu3WmPyFR8KcRPA5cqHEsl4o2+XUIVe9Y0K?=
 =?us-ascii?Q?8hvkqcAeaesGprowGeeddMcRhbsljgXFzG2xO9qmAnT9itn5hUt1oc7uUy7s?=
 =?us-ascii?Q?VCozmZEakII7qw50z1w5bEBEZhQOBtZqFoOvE0zVIr2uaYJb+ZWG46cwaO7O?=
 =?us-ascii?Q?/wIFlrC4WYsAUMNTJxbGziaW9DOfA4a5kKT1EtEuhzRVcuWuAjCQGpey3tEC?=
 =?us-ascii?Q?0UyvVqIpM71ty/RH/qa+xB22/YSEtlGf0WJMco83MyAuhEruLRHUh/AkAlx4?=
 =?us-ascii?Q?V9+3AaQ0l8RU9fxyTfVD89fVS/QMwLlTVUFCyccGG1gMTZQaetJBDrwK31op?=
 =?us-ascii?Q?C3Ek8a2t6zOAy1lRJnl2bnXvrd0Cj/rckw9bMCL5R6VtS/w4Aho7QqAthFaQ?=
 =?us-ascii?Q?dBUKcGLNc8Fx9cIyBBrdMZE94179Mo/Q994Znd5SmIpgmNrN87lenfruExTr?=
 =?us-ascii?Q?NARhIbvSlAYMzRaZ/oQ8En/1xq31LZHAwcQq2zK5ETeR8IQqtHaKCu3xZ9BG?=
 =?us-ascii?Q?OxL3xFI6rvMpy7JkwnotyPEZrLybGeuIRQHeMjWDBG21/vGDlNYw9OLo+P7Y?=
 =?us-ascii?Q?sSgaaBBUT4HLZ2rzrLD0KFXbumpTT2+WflAvZtmN6tJuVDaG+2u6dLdVEGrJ?=
 =?us-ascii?Q?8c8I9yhzNCHvVXAvdPBKbcqdVvu8iMS/eF58xgiGZOOZ6SfCzX10581Uet4D?=
 =?us-ascii?Q?MFuJFKi5LFYpoXT2CNxl4CArgUL6WcUCxN/hB4KKoDzjwHyOGRnQnj4U+IBk?=
 =?us-ascii?Q?3uhj3Us1KgqtygQWyVChGFLvC9UL6r/q74GMHvhLpgxTnn6CMZHLKG00iXqz?=
 =?us-ascii?Q?Xw9d2JoX9TmOQJRej1qUIzeVlP5a12OacX+e6If6zGs9ZvjHHNS+uL4Vm1vR?=
 =?us-ascii?Q?SLHuHTOou2AsqMgHpmzxzP2B5T5N6JWR9X3SEpYZkQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o2uVBqF3RfDDLq0w5e+lGl6LXLbWSF3raVX1zXRhh9KHRp1BMRMUrLU2P91r?=
 =?us-ascii?Q?Y/ks/9PEFcncC1/5sIycbCv7syxQpLmWCEPm8Ze9nj3sFxYbcRb5O6H4yPvV?=
 =?us-ascii?Q?Ecl47hHioPj5lC/52b7VwzHBPq9jEJ626evNH8n2r3qVRTsCOeKQuMmb4UAs?=
 =?us-ascii?Q?YGHv21+FPIflKs6uOQNpblJdevYFB/ORJ2j6V6+1OZXf7iU6gYnAUAOy+Qaj?=
 =?us-ascii?Q?Bwhxqar8KuaAtrQtg7zjYsolwF5bS0emu9RZVRhmaXbetJxOpu+8FmWNhZZ2?=
 =?us-ascii?Q?Vm5ZRlsmvxg3jWDYrh9XCMv2utzqAU4ypDvAVfFISqwhmcF4tEq+WA0sEdQ3?=
 =?us-ascii?Q?0N9m3BwonHGR24gJ24hwmwu6enT8apBmVm8aAbFd35Df3w87iYUiGnPtNvRy?=
 =?us-ascii?Q?ldPFtB9B2ET9dWDWPBa/P1txrCOJdbRrEoUU1Gq0QKuW9h31PD7dJDMntiu8?=
 =?us-ascii?Q?at8PEpD4OVDRWi5viSF9pFEiehtfaUOJH5EfoNT0VxAxsVteSqtMx+2tv3Rw?=
 =?us-ascii?Q?sy4NQUyby5aSsjUsXPv5mrDuhsmUI1f/HOSp4Qkku4j00VlXP9sL1ldkTWQ4?=
 =?us-ascii?Q?urVYwH82S8gtEuTmAiRXHg358i1TLGPMhvIX2F8nbNbOeMl3DyP9vtiwZ1dn?=
 =?us-ascii?Q?WhXem37HooSwmIP9bQMKtQ1DTwU+S3idud3mQAnHZh9IPuqdPpxkLzYeb3+E?=
 =?us-ascii?Q?EdIng9ofqOIM2cMyiQYIMKBZU1J8ub+D0QoyQTES0zjgc33WjAT05q8vJRyj?=
 =?us-ascii?Q?65zFssoHpuG4fcyAHMZvRsfEQye8cqtnm2DQXDbiMlJiAjEIAbC3suq9GVeZ?=
 =?us-ascii?Q?uTm/vDXraHMek3eG0DKcciHiC+a5cZ3r2uYNtOqRZLjqXEJkzIqGV6IET0zf?=
 =?us-ascii?Q?NMBnTT73YF0N6ubDgMGF3aKEfmDnSDPRa7UxNXQcDeLlvWdsDIepLKOCYI87?=
 =?us-ascii?Q?RX8wGFzd/38+oQs2FecKJ2ZB4j7pmw4CSK7k00c1ShijgEpk++3gpK4VjJzT?=
 =?us-ascii?Q?0DH04IchvYpF7SHx6rseEcVcziVVGRD5u/KJfmTv+jifFimA8JYmxRD2of4R?=
 =?us-ascii?Q?4Yv0BSACstljakw5/xXipS/Y3Sx++Nt40Ng9qcD8+zx223SEGYyLVdg1b7NL?=
 =?us-ascii?Q?zYh03oQVqQTEx8HdqdK3Jb39LMzDa/iDT2e0KmkobEcNt2IqTE+86lEsLHvz?=
 =?us-ascii?Q?J+PJEBCLO+XiCA4CONDBrrhoi6Ug1OjdNyxw0p69gGDUmgfMCu5lOBH/3uIA?=
 =?us-ascii?Q?iMa915mhOgQge9QuYlM9TjP2Fa4zILsZt2ibY8jabfH2euU7U3VVIpyfbz5s?=
 =?us-ascii?Q?VJsD/UXNN8/OnFOkGGPo+rX/r3Jbw2jv99v0sUGToF9W+43Gg95GdHQY5X7C?=
 =?us-ascii?Q?6L+o7WkyoIEsooJOT96mQhuXqmFUZ9wx1mtROUnX6ZgicdDTv3VFtOa97ZQB?=
 =?us-ascii?Q?oPFvZLmuEMJK0JjdyrIsz0i54oXqNzJS6mIszxa6zDESK9gXO1FDz9PJcnB1?=
 =?us-ascii?Q?/soUQzguzJSISl38LwQmCYSFINNR+31Goezrw8n1prf4Og1bbucQ6ubtjTPb?=
 =?us-ascii?Q?MCU7jOKMjdgDajV2MAqBMFOMFZtdWHgC8viN8XU7?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d3dae98-a683-4208-68f7-08dc6ba48ff7
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 19:09:31.5703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: grlN2k42p29FUbLqe1FevHBOMZYKsINWFSqBz6GJtP8ovdkaeeoR7RoQAZVgqk5bhMU1QH93jESVzu8yXBPJrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5072
X-OriginatorOrg: intel.com

Alison Schofield wrote:
> On Sun, Mar 24, 2024 at 04:18:08PM -0700, Ira Weiny wrote:
> > cxl_dpa_set_mode() checks the mode for validity two times, once outside
> > of the DPA RW semaphore and again within.
> 
> Not true.

Sorry for not being clear.  It does check the mode 2x but not for
validity.  I'll clarify.

> It only checks mode once before the lock. It checks for
> capacity after the lock. If it didn't check mode before the lock,
> then unsupported modes would fall through.

But we can check the mode 1 time and either check the size or fail.

> 
> > The function is not in a critical path.
> 
> Implying what here?  OK to check twice (even though it wasn't)
> or OK to expand scope of locking.

Implying that checking the mode outside the lock is not required.

> 
> > Prior to Dynamic Capacity the extra check was not much
> > of an issue.  The addition of DC modes increases the complexity of
> > the check.
> > 
> > Simplify the mode check before adding the more complex DC modes.
> > 
> 
> The addition of the DC mode check doesn't seem complex.

It is if you have to check it 2 times.

> 
> Pardon my picking at the words, but if you'd like to refactor the
> function, just say so. The final result is a bit more readable, but
> also adding the DC mode checks without refactoring would read fine
> also.

When I added the DC mode to this function without this refactoring it was
quite a bit more code and ugly IMO.  So this cleanup helped.  If I were
not adding the DC code there would be much less reason to change this
function.


[snip]

> > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > index 7d97790b893d..66b8419fd0c3 100644
> > --- a/drivers/cxl/core/hdm.c
> > +++ b/drivers/cxl/core/hdm.c
> > @@ -411,44 +411,35 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
> >  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> >  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> >  	struct device *dev = &cxled->cxld.dev;
> > -	int rc;
> >  
> > +	guard(rwsem_write)(&cxl_dpa_rwsem);
> > +	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE)
> > +		return -EBUSY;
> > +
> > +	/*
> > +	 * Check that the mode is supported by the current partition
> > +	 * configuration
> > +	 */
> >  	switch (mode) {
> >  	case CXL_DECODER_RAM:
> > +		if (!resource_size(&cxlds->ram_res)) {
> > +			dev_dbg(dev, "no available ram capacity\n");
> > +			return -ENXIO;
> > +		}
> > +		break;
> >  	case CXL_DECODER_PMEM:
> > +		if (!resource_size(&cxlds->pmem_res)) {
> > +			dev_dbg(dev, "no available pmem capacity\n");
> > +			return -ENXIO;
> > +		}
> >  		break;
> >  	default:
> >  		dev_dbg(dev, "unsupported mode: %d\n", mode);
> >  		return -EINVAL;
> >  	}
> >  
> 
> delete extra line

You don't like the space following the switch?

Ira

