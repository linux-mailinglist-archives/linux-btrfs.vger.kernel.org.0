Return-Path: <linux-btrfs+bounces-4085-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7AD89E8FD
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Apr 2024 06:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D1581F261A0
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Apr 2024 04:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DB8111A5;
	Wed, 10 Apr 2024 04:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RkdYduHA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AED10A1B;
	Wed, 10 Apr 2024 04:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712723750; cv=fail; b=ixJ2rRTUVFRSXE7EnleQ1ycaqpeVSw+VVYwwxWJoSSW22LsgZFjOIN8seHgDp+EZAhcy/fN7KK58/qd4H3AIYw0X0JMm/MCPH8OKXNN9VZkfhxA4lmJejDF1MSs9JTsTY7+7bJefcqgGQEiBuB9eb86sffIIYlph0mG5Dz6HZuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712723750; c=relaxed/simple;
	bh=zuVLDw2O+9VK75tHf0a8hmbLAnXGAlsdZSZVcd5Q/84=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TXnrV6auP2ixZpbMgEj4fOa8kZrwmimLmOfS8yQ7fXEsEO/X1DEx+g1DKR0tW0Il4kaHYZv24XZvfKBKrkeb5OL0DOP6st4UwCKfIRVBgyC4N8s0YRku9pq0KYNT8m+j2dAL8wUkcmhYEdIjJQDE3fp9tPSqzhzwqvsXj5zF88k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RkdYduHA; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712723748; x=1744259748;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=zuVLDw2O+9VK75tHf0a8hmbLAnXGAlsdZSZVcd5Q/84=;
  b=RkdYduHAKI8LRR37PGEojJOFJWu95D2pU2kxf/+aOPv7FmHG8iepCtB9
   ogNwxmofuOOkD4f7YsejP5T+RN3fKQalv/TiMW20RMLfMXktCVbytNi9b
   2bByRWhwyGOHXbrqGNRkAyLQHcoP7tQ2sf7BSve7PD7vR8HPPHkDqiopy
   z6R2DuKydttJ6pZnigwG0Ru7pE2Vh/8qXPyx62ThdEbRw7rnHZrzkStsY
   ZCx84gLT/oAOOPgYK0E+pZOx/pWO0XXTK+B/op+5+0KWIEZ+0OFjvBY8t
   nfCDVClBssJvGc7O0z6LbEW8lG+9xgBI6TJBzuqMPZV8u41OJ2/eZR95E
   w==;
X-CSE-ConnectionGUID: 770AGzWbToakQ5kwG0PbPg==
X-CSE-MsgGUID: mDgQ/sSuQVac5ENiSkqpLQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="7939235"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="7939235"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 21:35:47 -0700
X-CSE-ConnectionGUID: im3UDHr6Rhu3iWyvG4qMhg==
X-CSE-MsgGUID: bpVdGQO5QTydrM2Tg7gTSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="25223905"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Apr 2024 21:35:48 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 21:35:47 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 21:35:46 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Apr 2024 21:35:46 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Apr 2024 21:35:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iIng7hRa6ghuO0TeYJon6yO18XhLGnhyOkxE7eHO240ZXfvcMoiJLjMK87RgHvp5g4LUtIs8DJ7w6IPHwVCa4pGcw4AC9VxD5cUVTDM6bGc9oRDglHhGE2aB0FnywctQo/CdFKXYz6+llu39PEKoCqkw7GdlniQv/3CumFyCkoZ2jSKLOSL5KT/FOYBps5FU3KT3Tud23R3/5hdPnQJDGSE5Ms+fCGrRxoNl9PpYvJToc+BK722uYov1HrU2oQBzd4i5Mv7UrnQ74XHw5F+DtbsavUplcqBmy5Uo4yq2KWdssKwCqnyoP7pvMkKMDnovhA7v0b+0+cgRGhu6b+Ht/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KFmCnnMucaqph7LZrhlQn9/lBpgRqAtwsq0b1dTSm0I=;
 b=VKeETD126CrIHY/vNdgtoj5r+sj6ZcUeQ/ZBo2NMARYvA2jbInkGcN+JTCTk300bOHvH6f/Ap+6ID2D3L7/rF9wyh/40UeuxGiaQpn5p9sZpjYgLQTSMV7ADVaLZRbgbViCORwb5TQvb3fVpRtQpcp0tmxf77ZlaKNRMxgYzS4FvrLpivO3EL3OrJw4S8Map8BN7IUzvpZ5N91z8lJc7NmEzYnS62G3uqE6GlmZO5yQSyIY6oGMKkyhZYpkCbV39+rDBU9bM0pNHp+GG8pTfCRgakAdROoYQGVsA1LM+swlvWbihq8fNUN1tCD5PAum4TWMChdxu6unhJW3supaxpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA1PR11MB8279.namprd11.prod.outlook.com (2603:10b6:806:25c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Wed, 10 Apr
 2024 04:35:43 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e%7]) with mapi id 15.20.7452.019; Wed, 10 Apr 2024
 04:35:43 +0000
Date: Tue, 9 Apr 2024 21:35:40 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <ira.weiny@intel.com>, Fan Ni
	<fan.ni@samsung.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Navneet
 Singh <navneet.singh@intel.com>
CC: Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Alison Schofield <alison.schofield@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, <linux-btrfs@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 09/26] cxl/region: Add Dynamic Capacity CXL region support
Message-ID: <6616171c47d0c_e9f9f29460@iweiny-mobl.notmuch>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <20240324-dcd-type2-upstream-v1-9-b7b00d623625@intel.com>
 <dde02c34-fcf3-4adc-8920-7fd7fe202d54@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <dde02c34-fcf3-4adc-8920-7fd7fe202d54@intel.com>
X-ClientProxiedBy: BYAPR08CA0066.namprd08.prod.outlook.com
 (2603:10b6:a03:117::43) To SA1PR11MB6733.namprd11.prod.outlook.com
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
X-Microsoft-Antispam-Message-Info: 6M4m1m3hSMu3vc/GAz2KDNZoVpjpMXf7ze1ZbsBldnXPn0s6LiADysnt2/aTaKqTezXNL9Yzzz9fpE60lSdR+XpTvZXDKS4mXlfPJE7yKtczXcGz5wQiEe0byxZvkbLPeA4Tyu/vckVKspCbCSznKLlzuMj9wRKQwMKksyTkqO+8KA1V53ruIVq/H0w/3PEZPATt+iuGn0suLt0i8UcaLt68zXJqDSDyEE/Eio2Q6ajkHtFpUIpei7dPiLpIZQiBCdMGTTJuvTCtSFCKRjltuoJoYA2b1uLZlUz/gHl6LHoaRjkiY2rv7E6ilitmTOwNE0swO3vOnoHFrqhqLoAEQiZeeLYiP5cGlHThEm7iJXgehOCCSpnQwLWogHIgR+AuKKlZHm+jtFkgh02bTncJSaJBoIcjaKtuT7yLhwMthPZEZxth3nLgvZSruGz6DiuD+QotM990v1S4h6B1QF3kvP7o5pK1k1BteUVevU7V16AMfTvH9alzmUaMPwY7DRTfp6coqaLgzRlHuwD3/YoAE74nRmsaC/NzvKXNYrR2YWvq0dsp/3C2IEcarSmVnXP0FnJJCM8u314RbK2iRhCoEWT/t+CZHuxNwi7J4Tpg0nsVGI5i53ejPdWtE3mxcTgRunoYIk1sTit8hFWdA0wpzJrdgW2GEGfzFpU6j19sqEs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X9kPh8qtqy0+5ItMYuM04sCf6lfUtuAAvInTmbyQKYlzJqfDEuOVtlCGg+YR?=
 =?us-ascii?Q?0LWr1a6axqqpYDMOBQVDrqvcvy3AwV5ZqDIDuQlJWgPxqZWBPNFfJSJjDY36?=
 =?us-ascii?Q?rrklfYqEye0D1w8Bi1m+bsH4DJeyTFJf3qnnOzpKp5x9U0jmrsdE1WwNnJa+?=
 =?us-ascii?Q?NFfPRyxDXfwYyhipojI4srVeVGJQhev94sHxQ/obKXag1qS7IvQY9BbXNZSP?=
 =?us-ascii?Q?L8fkCODqi8qXSEtHoxQBuILBg0Srwn6Je4EEEHL3GkOT+Gc9slrIbkplE2t5?=
 =?us-ascii?Q?jo5cj69CT54wcQ5HjNVc9vGHcwjiEgnrexVl+tZZ3GBK7/pyzBkhUOXGEoqR?=
 =?us-ascii?Q?GqOzHmrTGpOkNiz0P6eCxAZ3y+CymFlkC2jwVvSFYe1+RfytddRBkuIkO9Ya?=
 =?us-ascii?Q?/dy416mA/amrksHI38rJ8r7wS8SPOJDSxQsjrvP0ihxhYL/gZt0LO2wCZVPm?=
 =?us-ascii?Q?zU+R5hLXuXm/UazoyyR4LAYpvQJmUZNydF6YnZlhXSW52hrxxnK8RAWrWzRR?=
 =?us-ascii?Q?vBD4199f3QD9p2bp2PpEH/vDXwvarhqoTeXE/Eit5ulmsObGd1w6XWgKys9Q?=
 =?us-ascii?Q?iul3KgzdnOGhScxmE5PV410udvDepjxZN3z5LXcRZlQKOJ75/T1KG2fQkz2E?=
 =?us-ascii?Q?r/WFCaBZUBo+KZIBB1BYxShRcn1B4HS+buvTwlWSL9ZEOKxZ9tcYU/vdUTgb?=
 =?us-ascii?Q?Askk7Q/AGDqPkAFEPWCVNX9lKW2HdxDjkdNuO89hsXXnGXI2n0t6MKHTObai?=
 =?us-ascii?Q?Jl+Sh9t3KElGcouVPnTCRrhCCYDgQVk7PKOZH5ujMJBEGbp4tomlXuEK/ARU?=
 =?us-ascii?Q?PSqCgZsas/jerws+F6q2zz8gtktXIcxZDDjSyyE6piK5KrKfg1qvehM7tUiq?=
 =?us-ascii?Q?Sh91KIMptkQaXt1QDnMebmfsogYrce2VECnzaEmplLcDyor10DxZrSgnvOnU?=
 =?us-ascii?Q?8iPHhqivzzZCGsOH4Xx+Flvn7B9U4C8EuJ9blLMhGKxWnOTGO7ToZZ5P06nb?=
 =?us-ascii?Q?3mUDPNMm3X3zZBuE3+is3jcG2hUP2xJmOMJx+Q7Zeuc8Tn3is3JOhglHsFKz?=
 =?us-ascii?Q?//srMzx90yNpitIDc+cD22tDTbbY/yvqp31GsTz3fFZiebKUrMk2kYacSqQL?=
 =?us-ascii?Q?15CqwJfIr3mPlZWlkFWXpxhRLc/gYA4XMcDLyMcIQePebT2jpEA+BBmt0JFQ?=
 =?us-ascii?Q?GFh5p0dQsJk3wBOuQBDwEKKgHcdsaOCH9H7/OGjuUrJX/gmPnWQwoxLVUAZI?=
 =?us-ascii?Q?fGrdugIkApxGbsIAOEXEq2fRbzw5DWfZdJEOm4MRYwkmeFNBS6+9ti2wLeZN?=
 =?us-ascii?Q?1zTF/YmiKfzk3DD0OHC1UlJkH/CYw8KTA+4IMqczV84HeZ5ciAKIeJ00kj85?=
 =?us-ascii?Q?ZDb7Ix5fqoKb23Kz8wdhItWJDfIMMVDbko+PfS+nvd235sbxbC/G78xcjXzI?=
 =?us-ascii?Q?1d3FPhn2RSIo+MYnSd0QEFqw20Ps6MckaSaM38UvTIU+J6opOJ23GIRb2GtG?=
 =?us-ascii?Q?OjQKH5GrFlbntQb1PEIa+PLwkkVZdUud7dShz8Yhf9v5ISvdL1qY/OkDUtpn?=
 =?us-ascii?Q?LyP82S+gBkl5qqsbYUb3gzFS7LKEK+J0lXsG07Si?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f6ab09b7-bb4a-4676-4bf1-08dc5917aef3
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 04:35:43.5916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ioI8cZygcTHwxpHjFoKo7NXn3R4YILPCFAF5SOGKckS+TJHp6OXzQwsq9ZsoIbu9278oKLb+gg9OhQ8apGGDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8279
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> 
> 
> On 3/24/24 4:18 PM, ira.weiny@intel.com wrote:
> > From: Navneet Singh <navneet.singh@intel.com>
> > 

[snip]

> >  
> > -What:		/sys/bus/cxl/devices/decoderX.Y/create_{pmem,ram}_region
> > -Date:		May, 2022, January, 2023
> > -KernelVersion:	v6.0 (pmem), v6.3 (ram)
> > +What:		/sys/bus/cxl/devices/decoderX.Y/create_{pmem,ram,dc}_region
> > +Date:		May, 2022, January, 2023, June 2024
> > +KernelVersion:	v6.0 (pmem), v6.3 (ram), v6.10 (dc)
> >  Contact:	linux-cxl@vger.kernel.org
> >  Description:
> >  		(RW) Write a string in the form 'regionZ' to start the process
> > -		of defining a new persistent, or volatile memory region
> > -		(interleave-set) within the decode range bounded by root decoder
> > -		'decoderX.Y'. The value written must match the current value
> > -		returned from reading this attribute. An atomic compare exchange
> > -		operation is done on write to assign the requested id to a
> > -		region and allocate the region-id for the next creation attempt.
> > -		EBUSY is returned if the region name written does not match the
> > -		current cached value.
> > +		of defining a new persistent, volatile, or Dynamic Capacity
> > +		(DC) memory region (interleave-set) within the decode range
> > +		bounded by root decoder 'decoderX.Y'. The value written must
> > +		match the current value returned from reading this attribute.
> > +		An atomic compare exchange operation is done on write to assign
> > +		the requested id to a region and allocate the region-id for the
> > +		next creation attempt.  EBUSY is returned if the region name
> 
> -EBUSY?
>

To match the other documentation I would say no.  The other docs show
ENXIO/EBUSY/EINVAL without the negative indicator.


[snip]

> > diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
> > index c696837ab23c..415d03fbf9b6 100644
> > --- a/drivers/dax/cxl.c
> > +++ b/drivers/dax/cxl.c
> > @@ -13,19 +13,30 @@ static int cxl_dax_region_probe(struct device *dev)
> >  	struct cxl_region *cxlr = cxlr_dax->cxlr;
> >  	struct dax_region *dax_region;
> >  	struct dev_dax_data data;
> > +	resource_size_t dev_size;
> > +	unsigned long flags;
> >  
> >  	if (nid == NUMA_NO_NODE)
> >  		nid = memory_add_physaddr_to_nid(cxlr_dax->hpa_range.start);
> >  
> > +	flags = IORESOURCE_DAX_KMEM;
> > +	if (cxlr->mode == CXL_REGION_DC)
> > +		flags |= IORESOURCE_DAX_SPARSE_CAP;
> > +
> >  	dax_region = alloc_dax_region(dev, cxlr->id, &cxlr_dax->hpa_range, nid,
> > -				      PMD_SIZE, IORESOURCE_DAX_KMEM);
> > +				      PMD_SIZE, flags);
> >  	if (!dax_region)
> >  		return -ENOMEM;
> >  
> > +	dev_size = range_len(&cxlr_dax->hpa_range);
> > +	/* Add empty seed dax device */
> > +	if (cxlr->mode == CXL_REGION_DC)
> > +		dev_size = 0;
> 
> Nit. Just do if/else so dev_size isn't set twice if mode is DC.

Ok yea.

Ira

