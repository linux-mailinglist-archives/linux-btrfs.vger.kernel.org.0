Return-Path: <linux-btrfs+bounces-4540-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B30C98B13DC
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Apr 2024 21:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42A1D1F24560
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Apr 2024 19:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5A313BC29;
	Wed, 24 Apr 2024 19:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZehXmRR7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4F21848;
	Wed, 24 Apr 2024 19:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713988684; cv=fail; b=QcUSpL99Ab/Vul1nYBlHgrGzT/szXLreh+S7vZkk5ML08ZXeGgqd3xUDiIB8+2sVEMKLSTpZ7RDBiAxeJeya7EZBDonwFN8Oz48MJpRoVy5lUMJhc0OQeMyWUnFjYT6ZxST7LlxHN8yc9YVU+biwodpFfpRKShS6pDpFF+9fQko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713988684; c=relaxed/simple;
	bh=MEeRhcOm+jSdO0vNczUVXEhBA5MtnbefxQtesql3JmY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eSPbCp4gnmege8SufgiJzj2hGZI54JFosvqWlgYCcql0zz6CU4WkDftlS6wDPjar0lBCGosQESlLQoB1BngYK6kVqIRizXoAKgqF+c+3rkfGgfzxSWfziEWNjRhbOZ6KkxFstYiDslQjw0PdV3azDiRFqNlyfnhDUQDl7TdBwRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZehXmRR7; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713988683; x=1745524683;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=MEeRhcOm+jSdO0vNczUVXEhBA5MtnbefxQtesql3JmY=;
  b=ZehXmRR7H16GIto2m/wJuDDWKsJi8Da8nMB5Tt/DO3tZkQ8CECOEj+7f
   kDQiavA2CIwHtWvYMoVqn2LjlAuP5fsnj3t9ObOJq+8HlMi2FUR/t8n0R
   /dIiW5Ehn7bkbto7QefZCbWSHAQUDzVKiG3nFQgCDsDtr3UX7MVdobeHc
   mo0amkUTRbGK/l2MoVxNSu/cKjTHGQcqUUXhFVtmFXddgr2pmisAHqmLZ
   LPQonI6wASYoatpUvf2vDAcZGHehpIGv0I2o/jwdWC1S42auEZAg2VeCR
   0jFCKUBlnIXcP8LWmrOJq1PpnRiQlMk/NXnXo7AMAW2CHhQw3kxPayiM4
   g==;
X-CSE-ConnectionGUID: 8r7hJ/CVQO++9nmW4DZjiw==
X-CSE-MsgGUID: wy34/G1ySmux09zcESOQXg==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="13430580"
X-IronPort-AV: E=Sophos;i="6.07,227,1708416000"; 
   d="scan'208";a="13430580"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 12:58:02 -0700
X-CSE-ConnectionGUID: Jrf59H4kS9y208vVuhmFsQ==
X-CSE-MsgGUID: 6Pr7vdEQQZ2yTyE/jEgMAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,227,1708416000"; 
   d="scan'208";a="55767368"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Apr 2024 12:58:01 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Apr 2024 12:58:00 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 24 Apr 2024 12:58:00 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Apr 2024 12:57:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gL9dmYnySA/dyz0FiasfmsGuJOf3aANc4ORj5bYtnzketxbIK2fCAY/KhjADU3lv97oBeWZJ8MO/8NyVT5yPKqGE4KiaorrOwpCx4Fi04MyF9IXFLxWxYUNfITrLhF5NLVATIEnRaJz4MfjFwMb3VKvzYK/xGGh9i4azRO+Vt4WImo/FVDed3iTxZFNv5mVv314JWbFj2grmwyKA9Ej68Z5pkW6b2mXc3UsMnnMx0opcC8CN1E+iP6ICTzOf0/d2Le7gL2NdGgdUV8qq7Afda8zB2hjWL0sXJ0qVHLEP1D3Q4cn55HnU/DiOSrBvdO3pPHHhwOrDnHCwYvJBYWixZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TX/NKOC2Sley8SQ+KZZdEGJVUs817cb4lTkcQiqxIdw=;
 b=WkJkSMxUM65iOPq85yZ8jbviWe5TbANOI5M+4Vv+ac3yjDiRiBNLl/34Qox05egmmAYuUMP5CPbFslqPWJDmJg80gkZ27r2difC1WcTKl4MYBaGbQhGZXfv8v4gNwipqVJbilARZ7wTNhtw4IW/EunuPquF2JAgQ+gIjFBFyd93iX49SNHeGrEC9Ai20NyqJz3IJjJEGIRULttgmuujowQZTGoav+U7Fgqxy+tsFPtm3dZAC067lBtm+ZKEXHTk+k2iG/MNQkhASzPFLFRRGUgY9lU0ZwPpaBKG2RNNl0OL2AXwg8altw+8ZTY3RyP+u4ufGVLtNIWysYRBJswCCWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH8PR11MB6925.namprd11.prod.outlook.com (2603:10b6:510:227::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.24; Wed, 24 Apr
 2024 19:57:58 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d543:d6c2:6eee:4ec]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d543:d6c2:6eee:4ec%4]) with mapi id 15.20.7519.020; Wed, 24 Apr 2024
 19:57:58 +0000
Date: Wed, 24 Apr 2024 12:57:53 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <ira.weiny@intel.com>, Fan Ni
	<fan.ni@samsung.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	"Navneet Singh" <navneet.singh@intel.com>
CC: Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Alison Schofield <alison.schofield@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, <linux-btrfs@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 16/26] cxl/extent: Realize extent devices
Message-ID: <66296441d655a_e9f9f29497@iweiny-mobl.notmuch>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <20240324-dcd-type2-upstream-v1-16-b7b00d623625@intel.com>
 <10a45890-422d-4956-bfe0-101eee23b323@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <10a45890-422d-4956-bfe0-101eee23b323@intel.com>
X-ClientProxiedBy: BY3PR05CA0057.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::32) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH8PR11MB6925:EE_
X-MS-Office365-Filtering-Correlation-Id: 006d4b6e-4455-4d72-5c70-08dc6498d6e3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?F+qQTIEnxe/l+pMCQCrIOQB3HsPcJdBO+yi3LM+Cu9S/7wTVlldNFS6XC/vK?=
 =?us-ascii?Q?lc/gAaNybcIV+lRDkertIUej9cyTiMp/czb4rrJ9gZQcW+vVVzcY3H5fQHfJ?=
 =?us-ascii?Q?q3jbbRkboF5cKP9asjCvM+IJA378SOyodYlgsgnPy6/p0jOAyd+76mwOR3z0?=
 =?us-ascii?Q?KCbEzP2fFsqBH5Zc7WqvPpBxlRDEsl2d0SiB8+nbOQi50wesan5L6AzVwyIR?=
 =?us-ascii?Q?Gox9FXZMORnfDZ0PddykibgcX6isoDgno962KmtrutuZH3bvz+6qX+N3Qa2B?=
 =?us-ascii?Q?8vbwkesumUr+bTEKw9DfLnB9Bmj+7bW+QUtMFULdyDJ99tE6SvjuNjzyXl3y?=
 =?us-ascii?Q?o29a0a0t5MfSmH22rM4gl26A7h5CV3XudhP6baMDC2Q4NiZW8ZppYh13D6AU?=
 =?us-ascii?Q?EYqnr0dTHJ74N9Q2C/W6b2vx4wV57IMeb5DYrOKiK88k7DqkE/TD+LJ/OdkK?=
 =?us-ascii?Q?psqyNwKuv2p7m0W1jvbZKA7MCBvb3Nq0R0QEKajlZiOqpDDnoC053WncyBrP?=
 =?us-ascii?Q?VHfsjsO/2YUx7F3ChxXMgxRO6YBKqItPYAYcvTVqCjXNpewDSoV7IxR7cHao?=
 =?us-ascii?Q?Nw71Zo2CgYvujnen1zfFpnT6yrXavu3sU76vYRRlkBNF/sXHjkYe7roIU5pd?=
 =?us-ascii?Q?FrM5hV3k1l8U6thBouA+M1LfUqImRNLeI3iXBBVNIIg9lJomVMrnz9XV18aa?=
 =?us-ascii?Q?1y7fXWUKEksSDk2Fx0Yz5LXOccL5L4BG3WC8ikf1JjCUXLDMzi74i9V6kioY?=
 =?us-ascii?Q?PlbaPhuEke120XIH9vOzP1wJHB4kkb1uisc9JBkHPRhyu3fCU0TQyWfbgbYg?=
 =?us-ascii?Q?JwjNgIpaleHRsQJPULTvVZGjAx2gOD2VEKydEIJnDRwwK9vF47hGUbFec0gn?=
 =?us-ascii?Q?eMvav3O1pu7hc6sFM6LXCJChuwPkNoxRrLMzNlEvUm7AYnXT2l91+eCiLrwM?=
 =?us-ascii?Q?2q4hws6ku7P8mPGnejwJzVp671qAuzqdpw3CrYgR+RCraD9ruiSa/6Fe7eZW?=
 =?us-ascii?Q?SKYucxdoEU3YdZ7Dd5mE+/JO00fjCOUTnNUCEUl8wrOP7RXgjT0wxOjp3khR?=
 =?us-ascii?Q?ptHwyWHNwrmed7FW143J55a2cTVokzPlDpXVujv6hEUF7HO71G2nmSiJOjnC?=
 =?us-ascii?Q?rRl/9s80zAWASuA2XitUlC9stWHIpXQOnhue2L/1+YpTbs7FlBHWGld83Meh?=
 =?us-ascii?Q?W9NXUFzsdM5LQKX39byB0TeGLeQExwp/qaiiKE/peAGgFvQGjRS8XY51W1y5?=
 =?us-ascii?Q?fepDHyBXs81YWU8yrDKqHvkwUfzKZ4380l3om94zkg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OgBNrbUHg+l5zwhYJGRgBXzbVlZ6iELcBbPkOfzLnN01tR2g3FD1lG79cKHB?=
 =?us-ascii?Q?xYwNhRHfMGfcAuwJSePlugRaFln6Bovd8O6JYjmozeuzADq+frUSE9U0ruxL?=
 =?us-ascii?Q?nV8ZbtEC+82QPTG1Y7MG9/7S9J/mvI0AYXnQI6UC2BGCc6HFWpDWkozDVyKS?=
 =?us-ascii?Q?UGSpDyqY2mWrHxqiqHSpDg8zvMxJEYZjfCTyGbassRKp5EwTHJIlAHhr/fgu?=
 =?us-ascii?Q?akeQCWA3Ud+hYmeyHFr38O9kYDkcc8QLV97MGyxvu7CexO2ekvbE+MSvx8hR?=
 =?us-ascii?Q?cUW112AKhBKJaEMYqjh+gR2GL7Rw3hMyIWlwIK5zX7stKaC70RnQBZNbR91u?=
 =?us-ascii?Q?BwDGPmNgNvXQvq/MtiDg1JLDKgOLwee47+emOYuk/OY/jft0tUJJKJosb5Wa?=
 =?us-ascii?Q?0otno0LqR/WIUxYdHUsO6zq+oL5U2fP19MBWgsMzy5UeQOLgG0XbkUoRrqAT?=
 =?us-ascii?Q?ZZwzXR8AQU1VUp9r5C3z81/htreLCukOFfNfd1BOd9vn4bGA+nR69wsCxwOr?=
 =?us-ascii?Q?5TLpcSvSv6IQ+EjMPMwgcjd6l8O7GmoYnQEpm+IZQVyYxI5999jx1SevIi0b?=
 =?us-ascii?Q?bIZ/YMSPJx5g26grgjgZXG0WWApQUcknW9AIVFJB8GMJELaZgXU6N6FeD+mF?=
 =?us-ascii?Q?2lsOJKeZH/fGpZqryrpnLxFv8LnfRI5QgcOBZWajcGVw8c1QuZL8Us9PhDsL?=
 =?us-ascii?Q?6arHoTZSz3ncDzZQMy7wT8ug+Flru/cw99shN3s+plTKgKdqcrK37wYcSmKv?=
 =?us-ascii?Q?pc4JHN9lLNPU6IqH+11MUsMNhuP1nSq2tCvgdjD0LUw3Bk3gsoYR4/y7GA1A?=
 =?us-ascii?Q?s4ysgHRjk/qcxN0BjYDhd8N2FdBbjB9g7UG2A8tzNq4AkID8qkqBSRgM5lvP?=
 =?us-ascii?Q?Zl1pIejt4b82BBcFhn3CmVspKAq52W30udBMHZyDNFCfYxHKFAymsDoCy+Ku?=
 =?us-ascii?Q?AWBebZ8zqPeMySWn8dYMSZVQO7t+dECYboRArKVgTe1j26re0qu3NHaTSk/D?=
 =?us-ascii?Q?U2jZll08RWqkD6V/BDsu40AReyV0IbirjViQ/TVr6p4YvegIqhNZlr6cZ8W+?=
 =?us-ascii?Q?NkGyElD1UZortrjTqIamw32zG9Kg45B9a2nJds6gQWOCJAQraViVBc+mJpmu?=
 =?us-ascii?Q?21qCUeQjBcoCGilwgkqJkmPHJNJaubrOxH1EeRLofry0dOURNORVv3JTpYaR?=
 =?us-ascii?Q?8fQrS0tdjMKSX7Go2U6J9YxFGkaaqpJf7ZVwhsDXklYRtCqMSGDGpMs4PGY5?=
 =?us-ascii?Q?LKln4t3qarG8G6voeSWqPFsGkaqTv5+iVWfa5OPf+50P9aIvdoN3hH2V06ui?=
 =?us-ascii?Q?Di9VFS9SQ/VQyG5Qfj/tgHb6y19JPNBsLI96rhhWj4q+AZV/IqbLhXmud5Fz?=
 =?us-ascii?Q?drB3UCats9s/jmgHe0+9y2EA5ilW/GpDIQfJoM+pTygyOganDobfu6asSX6H?=
 =?us-ascii?Q?KwveHTZy7h6TCFjepEE9LIPJHdj+OUB1C0gx4K+ZhtcAzPUixNui2rdsCvXR?=
 =?us-ascii?Q?STNkpxV5KFFaOYmCYiJ2M+fXHQSC5ImToFl4TWqqRRUth4GTrbcD+upz7T+L?=
 =?us-ascii?Q?IFZirx5vYbIbUUQ5WI2CP1w3GCh8w7UVkbxHtOpq?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 006d4b6e-4455-4d72-5c70-08dc6498d6e3
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 19:57:58.4517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o/a4hZ2JseV1e4hv3ctCwxAMFewqJGUbcTC0FwSGgJdXGpMj7v/sU7s+L6zn0luRG1CYkJKk1Hi6NaCUbEGr5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6925
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> 
> 
> On 3/24/24 4:18 PM, ira.weiny@intel.com wrote:
> > From: Navneet Singh <navneet.singh@intel.com>
> > 

[snip]

> > diff --git a/drivers/cxl/core/extent.c b/drivers/cxl/core/extent.c
> > new file mode 100644
> > index 000000000000..487c220f1c3c
> > --- /dev/null
> > +++ b/drivers/cxl/core/extent.c
> > @@ -0,0 +1,133 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright(c) 2024 Intel Corporation. All rights reserved. */
> > +
> > +#include <linux/device.h>
> > +#include <linux/slab.h>
> > +#include <cxl.h>
> > +
> > +static DEFINE_IDA(cxl_extent_ida);
> 
> According to Documentation/core-api/idr.rst, IDR interface is deprecated and
> xarray usage is preferred.

IDA != IDR

ida_alloc() provides a unique, unused id for the device.  I worked hard to
eliminate all extra references to the extent objects so as to ensure object
lifetimes.  So I'm keeping this for now.

> > +
> > +static ssize_t offset_show(struct device *dev, struct device_attribute *attr,
> > +			 char *buf)
> 
> Parameter alignment a bit off here? and some of the other functions as well.

Thanks, fixed.

[snip]

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
> 
> Not needed. kzalloc already zeroed.

Thanks, Fan mentioned it too.

Ira

