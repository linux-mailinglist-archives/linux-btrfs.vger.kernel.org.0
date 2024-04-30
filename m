Return-Path: <linux-btrfs+bounces-4649-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 767748B686F
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Apr 2024 05:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97964B22F3B
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Apr 2024 03:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77DBB11185;
	Tue, 30 Apr 2024 03:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AcDDf4+X"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61F5101DE;
	Tue, 30 Apr 2024 03:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714447400; cv=fail; b=Vm0sBFtf+KofTTvquHsEmR/GFDW1Dq830+pjHDGhpgwUNSUQTsteixwKkvirQ2UPbq/RPe9lj2Tb/trzihWyNOqCGEbeRp3MxdjM7RCJRdPhLsY7ml82FNGLkWIwyCJDG0uDVdrPoGIQYfuR7T+zjylFFMRfpj+b9zMeYB1/2BA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714447400; c=relaxed/simple;
	bh=AtTvNtQDvMDw6+sS+Yl/cNdU8pRNaXDcqGC/jOMIAHA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cDXrjqjVcRc506j42k+S5sYv90vwca/2zMA6AjUEN2qLtQgs9M3Aslx9FQIvRhVBwdXhRuaWblmjdNUEzijPakGZM2tUuxbKNEX+/OVuehPDEck+ZKZuqViL+tMFuSb35J1WI/R8Yw3YEsoRqcNkpe+84wOY3ZGlpdPFRlnydPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AcDDf4+X; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714447399; x=1745983399;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=AtTvNtQDvMDw6+sS+Yl/cNdU8pRNaXDcqGC/jOMIAHA=;
  b=AcDDf4+XkdNf4TD44vYbjd6LVVs8UVm0XpLkxAx6LerRg9JaduoAOKw9
   T0jjzfVxic1JVbcgE7hnL/mvS9Wtq4HUgbfpbbOmPsc9a6RcVWjIRJGkT
   1AHsnaVRl5iaIhTqbLb80S/KOgkZ38QN3rZyeT3F0dBwhXMGtTlpxqBkH
   YAp8dbkTMRv7s6GCXDCW/7NI1V0Ssfmv9d7khTm7O45MHGVPxtti3J3uD
   BjbqIyCnKZk5XCvmpXnZG/odOfhKXmVnCgF3gYbbdL5c12kQvF/8HKiVx
   prk6Oon/3ZsTM7xfRwmZsAAS63MgN6XEovX3GuvbA30gObDQFoWtNOi8b
   w==;
X-CSE-ConnectionGUID: mXIIyVSvQBytDZD2GzNaDg==
X-CSE-MsgGUID: aQSj1UqARL20bSN2zMBYSw==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="13958921"
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="13958921"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 20:23:18 -0700
X-CSE-ConnectionGUID: FCmYPrpUQReLdEDIlS181A==
X-CSE-MsgGUID: fly+hsUPRMm3c871AY7R7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="57508593"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Apr 2024 20:23:17 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 20:23:17 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 20:23:17 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Apr 2024 20:23:17 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Apr 2024 20:23:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G9tz6D5AwEroVMBzqE/1r5xsmqv/4nFlR4Dvr8dTY8XIS7hF1y2di/v4Vk3LUIXrlJfVNOUK/QlmAkQGj7WFA7atTmOlCdOkiXg53rtUCcNfi0SMitbJHRGZvdcwCsyMyE2FZWAM4zyCM3lhhG3w9oeOsiBPKwSyccgm4wFaSew5B0knb84nZcdiudQTYtlcuraKoPtUpFC9C09Tu3zirJB6rCH+0wf1qJNyqw2U+GtvezuFqFsMtjfQeoCYEs1Dyv4KpdamwrXaPGhcnng9SCy5sszS2iTe8AB4Sa8CLScL5eLcDTL4kklsQFYuMkuOn4xtyqJM4h6Q9UXGaC5lOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uKcvzYIrmrCebYOyrBWQgnWrGMMKkt4jWzSptcRdN2g=;
 b=R0EVFzbpO+wJtIOXsX/fZrHHkLRjgzS/cLLvJ7OpyMzyPbL2msJd6eTZiU+HpTbAIWtEK4aNXonzKrKXn8HVQLZE5dDOQgYoTV9gCWpzpTAvOcqXzpux3pk6jOsdC5qurnj+PSEapNzmDQw5M6mPwDQrtDddTAKtu5tgqN9nqJLkKnFKBrdquDBkHJ74jnGHQ/gYqNYCCaR7U8k5KhDWrL4Y7ujL9i4vwY7JQagCk1tM/H0UKwrWQ0Iwhfc8Pmj+1BKwgcyBQlqYPLm0pVU6smWU1TK5Lmjz/xdQNjimECBPxIAU9nPr02XipGZJ4Dg81A7QqNWEF2E5SZO7vR10IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DM4PR11MB6359.namprd11.prod.outlook.com (2603:10b6:8:b9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.24; Tue, 30 Apr
 2024 03:23:14 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d543:d6c2:6eee:4ec]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d543:d6c2:6eee:4ec%4]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 03:23:14 +0000
Date: Mon, 29 Apr 2024 20:23:10 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, <ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Navneet
 Singh" <navneet.singh@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-btrfs@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 16/26] cxl/extent: Realize extent devices
Message-ID: <6630641e5238e_e1f5829431@iweiny-mobl.notmuch>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <20240324-dcd-type2-upstream-v1-16-b7b00d623625@intel.com>
 <20240404173241.00003a6f@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240404173241.00003a6f@Huawei.com>
X-ClientProxiedBy: BY3PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::30) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DM4PR11MB6359:EE_
X-MS-Office365-Filtering-Correlation-Id: f086c509-c9c5-4a2a-864c-08dc68c4ded5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DEVi/2p/gS5rWu1xp/KzQlIx3ndMRUGzfQnRjp4/T3Z74IUmuTagwrzMA4Dy?=
 =?us-ascii?Q?Fkz49dudcndoRuFdP4zfpKLrmIX42FlAUtviPgn9zmcX4gr+tl+tlztu4E8a?=
 =?us-ascii?Q?LVdbQkfqpZNgl1aHihthwWIIU3FAe6NoBHOMQhb6OH1RAau+oAY1Fgz7oul+?=
 =?us-ascii?Q?ujwjLV9qgsi3awrwRzq6yvlNvC8Ov6bquX29O6rENmbGop6F2KPhV2P1rKQS?=
 =?us-ascii?Q?tTWRhML5ghpJH4toDu+fRgyp8hWZPJ1FURBdQics8t38zje+YzDY6RWcCn0a?=
 =?us-ascii?Q?qHviL6gcc/ebmwNYkFGBxEuthJVJc1z6EMRPaj0PQ+3B+XeiYRavjLIPB5h1?=
 =?us-ascii?Q?5H86Tr8jctFxQTISsfy37oM5yZ7XVV29kzJ5AuRRT/+ePPQls5A7wrhhRs7W?=
 =?us-ascii?Q?JJyN9IfNeJj09pd/Aizmuqwz3NhU/UOuno/AhV1pAYOKLh/hnf1n4Y4C8xQ1?=
 =?us-ascii?Q?dMP9Ww13L4vbpWqjTwQZX6PWR7UWjWBzePQB6/aHH7IdXwtlt1s8XZGLbsRI?=
 =?us-ascii?Q?goMJ9Gyp59V1b1qrl15wPDvqeFr5ChNyiahknQEPWixLk1cKxBp00fsOt2RS?=
 =?us-ascii?Q?YvpwyMIc9jJhjw7FxHUiF7hqWQxs0gM2i1grtcRQcEx3JGgmWCl/Q6eF2Gfn?=
 =?us-ascii?Q?88idUOuDysaUYk+uK/VbiERhGzIBT2DkXiU1L6evkWlC0dbSC5BZTP/JXSLW?=
 =?us-ascii?Q?1cFbL8RcnaBXT/5J44IxbkIHPWpLn8HcftLB/aQaxJzkQgodsnsK9cQiQI7i?=
 =?us-ascii?Q?sseBAbwaQKXrA1k/qxDwVHOX0NRz7nFGE35iBoRtmxVbfwDYKEEbAXevHuw5?=
 =?us-ascii?Q?8A13H3BV9TC2Vxvvpk3oyl3Pp+amMAb1p57CNz3zvXazweNDhXyyh2jXGkec?=
 =?us-ascii?Q?xTO6fht25L6xAYnv+MSJxBkO5zMtpJZmQBXmVqt4yI/257CCMNmHNvhK+oLg?=
 =?us-ascii?Q?jO2HNjKlTSOTw2UbAblQRyQyo/WxhPsHGGbktL4WIcWDEkgYsp6jd87F8fPg?=
 =?us-ascii?Q?9FX/vS16NR2wYU+/Og1mguXVzt0IUiQQB5e96/w0a66IBHWRW56xeD5yQdeZ?=
 =?us-ascii?Q?ErXpfyUe6G2EADYfi5ejG4Aa4IOOd7D0DXFdfIvLqrARS/Qqu5OHnkIpG7L+?=
 =?us-ascii?Q?TtdxxaF2D7yBcYEqlWD6N17vqFNijD5VH3PZkJ0zbBlPD04dZm5SBmPOSz8j?=
 =?us-ascii?Q?+a9viHZGR7h5P9EearjJ4ObNhfcd/IeSvL0zMfc0IINXHRbKGqUqt6qbgNDq?=
 =?us-ascii?Q?Uu0voHzm7xDCmF8Z4tpHsP1+AoT9Yk9+8Wq2EV6GpQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YUmb9AgKxPOE7hyBVE3T/BFOYx4Grr27FNLBe/vtOFTT9iEJQypSplOdA2Sa?=
 =?us-ascii?Q?3Facqr9p8E6Oi6pJKa29w47pQ2SPTGIy7IEA9hYnlA7eZbFVf4LvhN3/++Xi?=
 =?us-ascii?Q?cRxfbEzkfzndmvQj3cWypnWL24l761mJPBqf8VL5ZGoJWt7FpPwpACNV0S/k?=
 =?us-ascii?Q?wTfX0Tq3gROu5uXV+uEDl+/O/l1p8G/6V8DWJNg+iFL2QhUvJKR+1q5JcNjd?=
 =?us-ascii?Q?ujdPpFzLYP406Gaaf5P+5H56b6gJHy6jafPR8ZIUuqE6oM25VSHPgRVolKVd?=
 =?us-ascii?Q?iyDjxeknAEmnajgKMkkMlVjRucABt9a93MUDvFjguWvlTxC5s/5mK5p7NoVZ?=
 =?us-ascii?Q?zXLo+yzLUBIv4tDJ9Ri6iCA8zRjGABlA20oWFyuH+88Hk/QQqrOVBammq00y?=
 =?us-ascii?Q?zkoL7jRBVgwgbuiWFgaMRlBtC+Ea/W9KEXid+N0nGDDsedjQuHdO7KdmKWr3?=
 =?us-ascii?Q?egyb7u6J3OeTOCpo8E6Zr4QfKsVbkuz4q+W7x/LMd6SM5vPuNEDyWZh8djjf?=
 =?us-ascii?Q?Mrlrp3NRq5pvTa/Un0q+DWR0vmOov0SLyI10JG+/p0acZmYRuAzm/jBG/vPV?=
 =?us-ascii?Q?Ajv90cs1rSnf+ZlwRcC/k+o8UcDry+2aSsHpdhF35vY9JUDw0380T2pSXcKi?=
 =?us-ascii?Q?0nZAEshQymdnnWvbkl7IThzVu3MUDrLWIZyBDa6QBSKQVy+Jy3Q2mWCXgea8?=
 =?us-ascii?Q?5qdobSxJ4X7qb3MX+Pk9w+fxmQ2DqLvDWCZUxrthKdk6c//q/xeb7h9jxxI6?=
 =?us-ascii?Q?Jqbyy4Y8Hqzazttt7h6TDvCg4rINII9rHSDzN3CLOu51tAeyffhD6Sz/c5q+?=
 =?us-ascii?Q?ZrI3jV4GMDeMuqM8dEjfj6NapGpaE6kMwDt9EaEXG7HK8OoQtUu9OwzXJHB7?=
 =?us-ascii?Q?WPanys06F5Xr/8gWSQVs6h0lZE9sA/5PO7raFSoObAeOo3oVok4DQBNVJ5SU?=
 =?us-ascii?Q?zVYf9to/tsueE7qXk3k3AeBZqdMVeSuks3BBsFPRV8Dlua5PAjOurYqlnWUZ?=
 =?us-ascii?Q?Hxvk1dc9HDZjpyAxlucz9ial0bErQ1QN7xZXhkdNMBeEQbYBc6/AamPj6X1r?=
 =?us-ascii?Q?gOHGj5vgVbsWCzBPfE329bHLbo1P7vXA3fc7oKQgfInZG5jnR50VhVC3n+WV?=
 =?us-ascii?Q?qGLBapFxL2jmDPx/KM2y+b7p/1PFlO/yMzB14QfwYV9vYAy8Jy7u8vnYp5Xp?=
 =?us-ascii?Q?PSklHxT1M5DUojxXib3jV1WmUindXtz9oNwJpiYZmcelhjVDMMHPio2dEWCw?=
 =?us-ascii?Q?sGwGRlSYl8rzUDx+FanEvu5VF7HCBVCqlVZRbEpqn3JA4dxQCkK0U+HoxZk+?=
 =?us-ascii?Q?z5fkx4RQ3mqWNEIAkKmHuhssdOhwe/6EY+7SURjAIYCtkzo9GhPkHyz4o8ze?=
 =?us-ascii?Q?aaNDKLY2gBbsb0GhUG1Wq/t1Wze5b538H6IUtoj1ZzK4CIHXSDzr267zcxoP?=
 =?us-ascii?Q?qwrSqexMczMLCHB3JWI0jhQj+ey+0Tj62igXCLDoS0RwZG9U/f4FvbnZACR7?=
 =?us-ascii?Q?NWRumoon7hmfhwNNZTrLfaR16Zs9T+UA+ci9KreB7ak3pQu3M/RZjat5A5yZ?=
 =?us-ascii?Q?nnZFt+pwZRSf8NtCrMUwHRguXGX19mlveVbKhU7E?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f086c509-c9c5-4a2a-864c-08dc68c4ded5
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 03:23:14.3026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uSqzq6HNtcQUxy3anrjd6C8m7Mua7jxvpw67KD0b31FDPRK9lZXlLaHvYqvEZxXZu83Ocha/0zNngRGIee15gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6359
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Sun, 24 Mar 2024 16:18:19 -0700
> ira.weiny@intel.com wrote:
> 
> > From: Navneet Singh <navneet.singh@intel.com>
> > 
> > Once all extents of an interleave set are present a region must
> > surface an extent to the region.
> > 
> > Without interleaving; endpoint decoder and region extents have a 1:1
> > relationship.  Future support for IW > 1 will maintain a N:1
> > relationship between the device extents and region extents.
> > 
> > Create a region extent device for every device extent found.  Release of
> > the extent device triggers a response to the underlying hardware extent.
> > 
> > There is no strong use case to support the addition of extents which
> > overlap previously accepted extent ranges.  Reject such new extents
> > until such time as a good use case emerges.
> > 
> > Expose the necessary details of region extents by creating the following
> > sysfs entries.
> > 
> > 	/sys/bus/cxl/devices/dax_regionX/extentY
> > 	/sys/bus/cxl/devices/dax_regionX/extentY/offset
> > 	/sys/bus/cxl/devices/dax_regionX/extentY/length
> > 	/sys/bus/cxl/devices/dax_regionX/extentY/label
> 
> Docs?

That is a good idea.

> The label in particular worries me a little as I'm not sure what
> is in it.

I envisioned a pass through of the tag.

>
> If it's the tag one possible format is a uuid (not a coincidence
> that it is the same length) and interpreting that as characters isn't
> going to get us far.  I wonder if we have to treat it as a binary attr
> given we have no idea what it is.

In thinking about this more (and running some experiments): none of these are
strictly necessary in this initial implementation.  No code currently uses
them directly.

I questioned these in the past and I've done so again over the weekend.

I was about to rip them out entirely when I remembered Gregory Price's
comments on Discord.  There he indicating a desire to very carefully place
dax devices.  Without at least the offset and length above (and to a
lesser extent the label) this can't be done.

One still has to create and delete dax devices carefully
to place a dax device in a specific place.  But the above give the user
the information to do so.  Without it the user must coordinate with the FM
even more (which we could require initially).

On particular issue is the simplification I made within the kernel to
track extents.  The extents are no longer ordered within an xarray.

This means a user can't accurately predict which extent will be used when
allocating a dax device.  One has to experiment and look at the resulting
mappings of the dax device to see if it got allocated in the right place.

For example:


|      DC region                                      |
|-----------------------------------------------------|
|--------|          |--------|                        |
| (ext0) |          | (ext1) |                        |
| (1G)   |          | (1G)   |                        |

If the above extents were surfaced in the following order:

	ext1
	ext0

Then a dax device of size 1G was created.  The dax mapping would be:


|      DC region                                      |
|-----------------------------------------------------|
|--------|          |--------|                        |
| (ext0) |          | (ext1) |                        |
| (1G)   |          | (1G)   |                        |
|                   |(daxX.1)|                        |

Allocating another dax device would result in:

|(daxX.2)}          |(daxX.1)|                        |

I don't think this is exactly what the user is going to expect.  This can
be resolved by by looking at the dax device mappings though.[0]  So I'm going
to leave this for now.  But I expect some additional porcelain is going to
be required to fully meet Gregory's requirements.

[0]
	/sys/bus/dax/devices/daxX.Y/mapping[0..N]/start
	/sys/bus/dax/devices/daxX.Y/mapping[0..N]/end

Back to the label field:  It is currently just the 'tag' of the individual
extent (because no interleaving).  My vision for the interleave case would
be for the kernel to assemble device extents into a region extent only if
the tags match and export that.

Thinking on it more though we should leave label out for now.  This is the
second time it has been questioned.

> Otherwise a query inline that may well be answered in later patches.
> 
> > 
> > The use of the extent devices by the DAX layer is deferred to later
> > patches.
> > 
> > Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> > Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 

[snip]

> > +int dax_region_create_ext(struct cxl_dax_region *cxlr_dax,
> > +			  struct range *hpa_range,
> > +			  const char *label,
> > +			  struct range *dpa_range,
> > +			  struct cxl_endpoint_decoder *cxled)
> > +{
> > +	struct region_extent *reg_ext;
> > +	struct device *dev;
> > +	int rc, id;
> > +
> > +	id = ida_alloc(&cxl_extent_ida, GFP_KERNEL);
> > +	if (id < 0)
> > +		return -ENOMEM;
> 
> Whilst it doesn't matter hugely, it's nice if the release does things
> in opposite order of the creation. So perhaps move the ida_alloc
> after kzalloc or reg_ext?

Actually there is an ida resource leak here if the alloc fails.  I'll fix
that too.

> 
> > +
> > +	reg_ext = kzalloc(sizeof(*reg_ext), GFP_KERNEL);
> > +	if (!reg_ext)
> > +		return -ENOMEM;
> > +
> > +	reg_ext->hpa_range = *hpa_range;
> > +	reg_ext->ed_ext.dpa_range = *dpa_range;
> > +	reg_ext->ed_ext.cxled = cxled;
> > +	snprintf(reg_ext->label, DAX_EXTENT_LABEL_LEN, "%s", label);
> > +
> > +	dev = &reg_ext->dev;
> > +	device_initialize(dev);
> > +	dev->id = id;
> > +	device_set_pm_not_required(dev);
> > +	dev->parent = &cxlr_dax->dev;
> > +	dev->type = &region_extent_type;
> > +	rc = dev_set_name(dev, "extent%d", dev->id);
> > +	if (rc)
> > +		goto err;
> > +
> > +	rc = device_add(dev);
> > +	if (rc)
> > +		goto err;
> > +
> > +	dev_dbg(dev, "DAX region extent HPA %#llx - %#llx\n",
> > +		reg_ext->hpa_range.start, reg_ext->hpa_range.end);
> > +
> > +	return devm_add_action_or_reset(&cxlr_dax->dev, region_extent_unregister,
> > +	reg_ext);
> 
> Indent

Yep.

> 
> > +
> > +err:
> > +	dev_err(&cxlr_dax->dev, "Failed to initialize DAX extent dev HPA %#llx - %#llx\n",
> > +		reg_ext->hpa_range.start, reg_ext->hpa_range.end);
> > +
> > +	put_device(dev);
> > +	return rc;
> > +}
> > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > index 9e33a0976828..6b00e717e42b 100644
> > --- a/drivers/cxl/core/mbox.c
> > +++ b/drivers/cxl/core/mbox.c
> > @@ -1020,6 +1020,32 @@ static int cxl_clear_event_record(struct cxl_memdev_state *mds,
> >  	return rc;
> >  }
> >  
> > +static int cxl_send_dc_cap_response(struct cxl_memdev_state *mds,
> > +				    struct range *extent, int opcode)
> > +{
> > +	struct cxl_mbox_cmd mbox_cmd;
> > +	size_t size;
> > +
> > +	struct cxl_mbox_dc_response *dc_res __free(kfree);
> > +	size = struct_size(dc_res, extent_list, 1);
> > +	dc_res = kzalloc(size, GFP_KERNEL);
> > +	if (!dc_res)
> > +		return -ENOMEM;
> > +
> > +	dc_res->extent_list[0].dpa_start = cpu_to_le64(extent->start);
> > +	memset(dc_res->extent_list[0].reserved, 0, 8);
> > +	dc_res->extent_list[0].length = cpu_to_le64(range_len(extent));
> > +	dc_res->extent_list_size = cpu_to_le32(1);
> 
> I guess this comes up later, but such a response means that if we are offered
> multiple extents in an add with the more flag set then we always reject all
> but the first one.

I've thought about how to best support for the more flag without major
complications.  So far the use of the more flag is IMO more trouble than
it is worth.  I agree that the spec is clear WRT the grouping of a
response with the more flag set but it is very vague on __why__.

> 
> > +
> > +	mbox_cmd = (struct cxl_mbox_cmd) {
> > +		.opcode = opcode,
> > +		.size_in = size,
> > +		.payload_in = dc_res,
> > +	};
> > +
> > +	return cxl_internal_send_cmd(mds, &mbox_cmd);
> > +}
> > +
> >  static struct cxl_memdev_state *
> >  cxled_to_mds(struct cxl_endpoint_decoder *cxled)
> >  {
> > @@ -1029,6 +1055,23 @@ cxled_to_mds(struct cxl_endpoint_decoder *cxled)
> >  	return container_of(cxlds, struct cxl_memdev_state, cxlds);
> >  }
> >  
> > +void cxl_release_ed_extent(struct cxl_ed_extent *extent)
> > +{
> > +	struct cxl_endpoint_decoder *cxled = extent->cxled;
> > +	struct cxl_memdev_state *mds = cxled_to_mds(cxled);
> > +	struct device *dev = mds->cxlds.dev;
> > +	int rc;
> > +
> > +	dev_dbg(dev, "Releasing DC extent DPA %#llx - %#llx\n",
> > +		extent->dpa_range.start, extent->dpa_range.end);
> > +
> > +	rc = cxl_send_dc_cap_response(mds, &extent->dpa_range, CXL_MBOX_OP_RELEASE_DC);
> 
> Long line that doesn't really need to be.

Yep

> 
> > +	if (rc)
> > +		dev_dbg(dev, "Failed to respond releasing extent DPA %#llx - %#llx; %d\n",
> > +			extent->dpa_range.start, extent->dpa_range.end, rc);
> > +}
> > +EXPORT_SYMBOL_NS_GPL(cxl_release_ed_extent, CXL);
> > +
> >  static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
> >  				    enum cxl_event_log_type type)
> >  {
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 3e563ab29afe..7635ff109578 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -1450,11 +1450,81 @@ static int cxl_region_validate_position(struct cxl_region *cxlr,
> >  	return 0;
> >  }
> 
> >  static int cxl_region_attach_position(struct cxl_region *cxlr,
> > @@ -2684,6 +2754,7 @@ static struct cxl_dax_region *cxl_dax_region_alloc(struct cxl_region *cxlr)
> >  
> >  	dev = &cxlr_dax->dev;
> >  	cxlr_dax->cxlr = cxlr;
> > +	cxlr->cxlr_dax = cxlr_dax;
> >  	device_initialize(dev);
> >  	lockdep_set_class(&dev->mutex, &cxl_dax_region_key);
> >  	device_set_pm_not_required(dev);
> > @@ -2799,7 +2870,10 @@ static int cxl_region_read_extents(struct cxl_region *cxlr)
> >  static void cxlr_dax_unregister(void *_cxlr_dax)
> >  {
> >  	struct cxl_dax_region *cxlr_dax = _cxlr_dax;
> > +	struct cxl_region *cxlr = cxlr_dax->cxlr;
> >  
> > +	cxlr->cxlr_dax = NULL;
> > +	cxlr_dax->cxlr = NULL;
> >  	device_unregister(&cxlr_dax->dev);
> >  }
> >  
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index d585f5fdd3ae..5379ad7f5852 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> 
> 
> > +/**
> > + * struct region_extent - CXL DAX region extent
> > + * @dev: device representing this extent
> > + * @hpa_range: HPA range of this extent
> > + * @label: label of the extent
> > + * @ed_ext: Endpoint decoder extent which backs this extent
> > + */
> > +#define DAX_EXTENT_LABEL_LEN 64
> 
> Something called DAX_* doesn't belong in this header...
> Either give a CXL_DAX_ prefix or move the definition if appropriate.
> 

I've remove this as well as the label sysfs instead.

Ira

