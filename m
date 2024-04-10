Return-Path: <linux-btrfs+bounces-4086-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D4F89E91C
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Apr 2024 06:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84E06B20EAC
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Apr 2024 04:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801CE10A25;
	Wed, 10 Apr 2024 04:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nPh+90+R"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95872D268;
	Wed, 10 Apr 2024 04:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712724066; cv=fail; b=TGW9SKTRYlCUS2jfu4dIpiajQwag1XFMIn9H/EQpIddWP/BHjxydRiBnmkyiwRPdjOlU3aXP9dhB0S9LsEv+Gj81rHtRB3W1yWNLCT73xRDaNIiMR1kSoa4ZzBYMtu8EBoonqmhSbGFeVCV9Dmg/n4AnYp6D6Z78ren73B1pxIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712724066; c=relaxed/simple;
	bh=Wn3qjtjXHVtWJ9tTUhLwb/WZ1xbmEEvRn4XImQXUJ/A=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QUaZOvvm2tGYAe9HBe9iNaKZSDQEAiyEbGvqH06kHhYVEYla78QFmbwBD4MXsBBF+Ydclcy8u6kxpCuiFZ0iQ0jMKowDp4NfpWu9pGkPeqePQH3gD1eeQjkbD9KILClwfyMqKYNL4aQ3DkizbcOV4hDwnsxYhBStuXLo1BMrZek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nPh+90+R; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712724063; x=1744260063;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Wn3qjtjXHVtWJ9tTUhLwb/WZ1xbmEEvRn4XImQXUJ/A=;
  b=nPh+90+RFwxU9laCC7xFQRhsUndAiBMkrNYuqf6HP5h9K8SCAY5m0/Te
   RWfwpZpZ8e9tXU6RmL+foQLG/QRYzwFijVLTRbtkNKtgmu3aVH/0CPFiz
   jHf86Z6L7KhXElj5NMIydctQeYgHZLo7NelXvACX7NkmZ6vkttVWTLP4z
   QbJw77a7ORuJjKvMtqOFz6BwdxRXJGTS3IuKIYmK3TQipu3yqPnF0r86h
   THCKwCODOAWv23KpXVHqVN8rkQm/7/FfqAIIeUdsKptTW5sMbhTueXRzs
   BNoDoCZa7w9SjG37dOsUtrzvG85Oxja8+DgfhGR0FMmzffuoGtSjkZ+v0
   Q==;
X-CSE-ConnectionGUID: olgz3eVUSA2TWdTcsNTNYQ==
X-CSE-MsgGUID: ng7ZvsO3Tmayzn8YDAwL9A==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="18676242"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="18676242"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 21:41:03 -0700
X-CSE-ConnectionGUID: TFhlnFYcQGmTSsksOLH/Rw==
X-CSE-MsgGUID: CG8iQFoESZuhoY2iC4QzjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="25038083"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Apr 2024 21:41:03 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 21:41:02 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Apr 2024 21:41:02 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Apr 2024 21:40:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oSwXmT0vqsV1ka7SCM8R0Wq9lat6nkAAjBku23yHfvpzErrGTl3RE2+FINzJf1F+syhkVHVI2dH7iV3E7G51gs66AEcsdatFngCKVBPI3uP0yAXTofd+444fnusFSmkXeZAxZCgvVbRGZBI1ylqmCthSXdVcSaibz5D2dOyssRyJr3r3l+PXGMl5Nnst1u5z5fM7WtbUKPA/ll8LXAzxZuHb3+H3MN2pvB8ehwC/yJmGjazpNxB9VegWGIfip10juXa1JMepIjiEVU6SIQPxcCbd/Txw0R2HIEnMX1ucADydZ/Ny8SsNN3oupCuYWj6TmpgZ2N1rFNmWg9TAPtJZ1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qgeVgxyv0OeHr519O0upFvXyZhKgK+Gbhxg6P3dfOZw=;
 b=lvb0Q9+k7dO4qcEohDpA4fUHCAozo39pfYtKoAwHBiIMN5Qg2iJPIoJuYIZ1ntBAk9rI+nfJWiMo16JVKCWoRUoGFa3hs1rsj8G+IgyC48iuSg0CebxR3lNo1fbX6O2O+vxQA9OfBivCbI9S0WUZKOo+VWSLHuu1xw+Vx1lKrg37Fub4l7vFSSucZtX0sEsOEbH/qCYyhQU32aQ/tfFM/I3ueQko1CZ+fbyisu/N8PYuG0ESfUPdZ86GHMhSJRJFGrpYR5m8Ync6B0n/1lnbIKqeVlIS1THmuEiWEWHvEOggtU1qNDYIO+NrB1DS+HRx4rBiqqlUsKrN5y6nBiJ5QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA1PR11MB8279.namprd11.prod.outlook.com (2603:10b6:806:25c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Wed, 10 Apr
 2024 04:40:36 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e%7]) with mapi id 15.20.7452.019; Wed, 10 Apr 2024
 04:40:36 +0000
Date: Tue, 9 Apr 2024 21:40:33 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, <ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Navneet
 Singh" <navneet.singh@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-btrfs@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 09/26] cxl/region: Add Dynamic Capacity CXL region support
Message-ID: <6616184163627_e9f9f294c2@iweiny-mobl.notmuch>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <20240324-dcd-type2-upstream-v1-9-b7b00d623625@intel.com>
 <20240404112628.0000633d@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240404112628.0000633d@Huawei.com>
X-ClientProxiedBy: BY3PR05CA0044.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::19) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA1PR11MB8279:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MLzgHobsU+mvpRh3hgIPspNwyTvZ3oYksB4e35oChVP2IRb6SPTqgrGqGrVBUN2nyReQgUurIdLI5Y/71n5LnQOZ8PSUbEK4c4zL42GE5SEFNQxvFR3eVSELg+abEGlxsIzs5Hw7a6L4cVNlsES5cWxQ+u8W34s+KmwaFlZalGtAn5ixhVBLe0qjRdcLK6wPdTi/NnDNmFTic6Mm1gUbG26Ky4mPDbewGpx4j3BOqj+0J3N2ZyTGoQntMdM7N4TIIMUvNut5zx0J2ktXWucMZ4/TE/8rgbAY9ay44U+dxavklQJok08rkMCkaswrUlfWSXl6WSeKiFt6zOVYq2v6kxH1hFJQb0HO+nVVp/MHbjgtqEGX/O8fOqbcyHIP9IzkDRWKOVnkhrTufWnlzegD/QjFzGJyMQ++o7fOHfiwnp3L9l8r5cdY5GkTHq/zoKlUw3SmSbZRelBEeV3GYufgKB2CAunHqF3A4edvCF+tT7wmvsjn+Covs3I3MzayHdUzFs4KhLS3ATDAqQf9dEHD98dW6Dbk2ofeAKoluW42WBc9BmcRLf1sxGbvqSrVdub2A0YhH/N9hipHG025UWNTPgcVqCpI9F+E/IF9PcZV0pyymBsCn7JjCBnq+1Hu1Hfi26wUgw/xgqM0USWdyMtwu0+5vJ13bigBlb2nffT7ihI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hTOsV+o0KjgxpfaJgDeJYraFC1QjDreM8zutzk3VY7wLg/sM9wuI92UqLpyK?=
 =?us-ascii?Q?/kmrCFakdFoW6jBYxIInOs7KCd7Mhpd/lsY8ZFpBsfS4TwLWZiEIycJA/5rS?=
 =?us-ascii?Q?DPyORvRQzdsGv5peD4nhsu3/cLrwKoJMlh8ikbjXmSf8UYc67bwmUCM+cxN8?=
 =?us-ascii?Q?wn3daEWmi6g2q4gBih/UdAfODZipDlZvSEl+2PV6YGcsYaZRGyyEvA4cPYPS?=
 =?us-ascii?Q?VMkS1JXDtRJgZ/dPIdBSc0Z6E8eSeJK6q77G/EGWyt9sWymoap1evDFg7bIj?=
 =?us-ascii?Q?N84I3i02X8Ia4a8d9q6RgsGh0/HU8Wcs+9xG5Bi0+HpOgLEEgug44o6zyZGt?=
 =?us-ascii?Q?S6SHgv+nNNeP13ISFG1cTWCnqgbfhCUpPItqiz48nRLFEdhyBqBmLn7fXede?=
 =?us-ascii?Q?9C3fqr0Wm/M2TPbLqOJPb8Uluw/pV7V8PQdi02qMCwsr6eZNnxEf7BZEVw/Z?=
 =?us-ascii?Q?9+8C5HejbeMLCgvAY3OLxr+nqKSBL0GIWw9sGu0NXPmP35aG0WfrSDnAEscw?=
 =?us-ascii?Q?T/vQ0/nyUn10DMpMze0Zmd/46NXHL+79Rmu7D80kwuDajV5NZfDL+4LItlmt?=
 =?us-ascii?Q?V3URQo4A8vyOop2X03LwBkbhiWx/ulju0UGYcncva1PRcG9b1YsTkmj43KUy?=
 =?us-ascii?Q?nEaI9PxiOh3fLyrAAdGkr3Hb7pPHVdD0HgG/2wL2tvRleeiaqKKf4XrhpS2/?=
 =?us-ascii?Q?F7Vv579gBNdyHwt0hYamCiIOLjiiPPxftBgPFVEoxAdWkA3jINXPXtbJV5/Y?=
 =?us-ascii?Q?c265qlNhzaDJ297+8RlOeqv8T2xrGD7Q3FKcm1ziPDbImxU8I6znyiFfC858?=
 =?us-ascii?Q?JjVpjzp/0C5WaP5l5hOquN4vCc5kaWakGpZkXaTVbwddcjOCtBdXn0dfhs+j?=
 =?us-ascii?Q?YEX1jFeAO464WZzxwaKlxmX7rRwBHxkeJMwf7tNtE+or9ITBKRyjieCyf1Gq?=
 =?us-ascii?Q?V8tyNvVR6iSe2rPgrmg5KFg7jM0TmfPt+upU5/vrZof4iWWWX02A2wzsBwkS?=
 =?us-ascii?Q?78Q6TTNqeIAwgi1bCtMgddttYrdwWoMqsPd4S2vvyj5i7WUbZCuRnDjycktz?=
 =?us-ascii?Q?Zfx6JYdCAin2CsAOr8XLpJ+9ZNGSO0dtq/Md0Fdo5GhNBFIs1CI/+wEkBiN0?=
 =?us-ascii?Q?QR08kbxE+KG4npJ3I7cQIgAitVSvwacpYQ+OBgOVQTfoIREEIb57AgBLBN43?=
 =?us-ascii?Q?p2yrvlfkILMQVy2X5HSWlED0r7HX0w594HMieo7T0no7kMD6WvvfS2QNIf+A?=
 =?us-ascii?Q?hxh4I8NajkhINu0aLsjeOUbyKAtsLPZgI2zXbQxDPrqiXUgBgkS0lzsbOPY3?=
 =?us-ascii?Q?QZRRxzSa2UmDVg/omGBtSzHRaFGtiIaMu12Z5clnds2Zubw0WJv/l7JcajOs?=
 =?us-ascii?Q?e96StdhP7LH0xvpVO27Cg+uM8vDFhfwonkYVVFU0AiJznqXSCxLwI1IlKPds?=
 =?us-ascii?Q?sobp85jL2BPLlGWIFFumJguQdE+IgxGxu27e9lyLl+/QMkIiEPo77RQ2S1nz?=
 =?us-ascii?Q?12iEAnaNoR0ld9+lHW8GTIoT0DeMm4ix6mpvZB+WNQwlENEaYxrwq42L7IRa?=
 =?us-ascii?Q?LIQuDQV7wzvnKmz0zJsnFGg8tFukYd3kaBp3NF9F?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 86329e63-d52a-41e0-8e0f-08dc59185d80
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 04:40:36.4173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sT9Gz97oVwgbAAiXwaipNVxyRBGaUC/ZV8vihc9TZhSeIEhZgZANFjYuKgFgH46JScLgLFNq14avfCtBbzJq0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8279
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Sun, 24 Mar 2024 16:18:12 -0700
> ira.weiny@intel.com wrote:
> 
> > From: Navneet Singh <navneet.singh@intel.com>
> > 
> > CXL devices optionally support dynamic capacity.  CXL Regions must be
> > configured correctly to access this capacity.  Similar to ram and pmem
> > partitions, DC Regions, as they are called in CXL 3.1, represent
> > different partitions of the DPA space.
> > 
> > Introduce the concept of a sparse DAX region.  Add the create_dc_region
> > sysfs entry to create sparse DC DAX regions.  Special case DC capable
> > regions to create a 0 sized seed DAX device to maintain backards
> > compatibility with older software which needs a default DAX device to
> > hold the region reference.
> > 
> > Flag sparse DAX regions to indicate 0 capacity available until such time
> > as DC capacity is added.
> > 
> > Interleaving is deferred in this series.  Add an early check.
> > 
> > Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> > Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> With the -EBUSY others addressed LGTM.

But the other docs do not have that notation.  Also the EBUSY was not changed
from the previous documentation.  Only the text for DC was added.

I'm inclined to leave this.

> Fan's duplication comment
> might be something to tidy up later.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks,
Ira



