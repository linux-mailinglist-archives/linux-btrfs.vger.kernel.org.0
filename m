Return-Path: <linux-btrfs+bounces-3845-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D23896018
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Apr 2024 01:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C572D1F233AC
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Apr 2024 23:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FA54DA13;
	Tue,  2 Apr 2024 23:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bbdKq6tX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335E62E3FD;
	Tue,  2 Apr 2024 23:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712100432; cv=fail; b=pAyk9Cinu62DVZSAzpTXSOd76pXscb3Z7gDtw2sMWS2jwMUILcJeoIMxDUXuTvhzmEjHOfNAwOuqR4nPEV2dxovTwEYbRB1RflBgbqDxWI5txjlH16t3+O3yPR0lw449JVzgFquiKnhatJFsNtmKx1/2FXVLUpd9dzmek3FNYQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712100432; c=relaxed/simple;
	bh=P7c6j2l8NaQl6C5lNUfV8r12S9R7JwTyq6K4baUnPPQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fm+Ev7vEqzuu17UVQYSve3P5+oJxW/gosS+phrQd0XXxglYKv054w6qDYmczYN5+VyNPpFHkfG1fMd0uzfmEI+Ev3vghLkAsV8ACWDaPDyns1AzR+TP8kdfMtJAXOtRsZAkvv+c09UD2vaw1B3mzXHQxWqOnLsQh7dYIUVbkxJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bbdKq6tX; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712100430; x=1743636430;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=P7c6j2l8NaQl6C5lNUfV8r12S9R7JwTyq6K4baUnPPQ=;
  b=bbdKq6tXQ6scPmN1fP4iT1yAUsztIPWPfh6n8jQF6ypFLg1ohchricvm
   vR/GrA+YnutvZhjKUIi2hJXwtVrQ+ZHAEP94z2VOdvK1ZjfC5X63l9c3w
   Ue7YmfY/QQYle2IXiY/8v/OuR9oQhKRIC1Vq0kTH2x3VH5yIQZNP51BY/
   R1qWmQfI4eJpu/Y/cjNDisZyriflnMeleAjcAzd8t2+6i6P85OIsKxnRZ
   dlUgHEdK+ZKoPc8eY/NWddowYFIimSqarCiEmK4hU+6j732afgXskhDts
   JSQJ6oCrG82Tu7tEaCE2SYTVzU3c92GrjUjHKdArehw36UmvmrrZYVQJw
   w==;
X-CSE-ConnectionGUID: oexVM7jGTjGzIAIbn0HnJA==
X-CSE-MsgGUID: nMfb+/c1RpOL6sMf+jhT4Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="24796547"
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="24796547"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 16:27:09 -0700
X-CSE-ConnectionGUID: XUD/T4ZTQPGJzD1ttnzu5Q==
X-CSE-MsgGUID: vv39Zc3SQrO5CGAPnwqGyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="18053670"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Apr 2024 16:27:09 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Apr 2024 16:27:08 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 2 Apr 2024 16:27:08 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 2 Apr 2024 16:27:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M6lm9QpzRuRhMuug0hBC3G6MwCNhwoUQgXppC5Xk51IDfsK6wS2gqCa7HYDYQS5bCZih4yrK121p8UZxCGH/gFwSJsQAbKAGi6pb6AG0N2s3ievK3cyRMzlIkTUHPaSTFulQkMZlGUM4BDA0QgAIsfnX9BwExy/98zok0L5UUCDa/kuJMnkK9J7VDbuzsG3/YgZIb5+HoAhz/MEQnB6GaHxZlEdW0ylwlF3Yc4yaouuLtDYY0GA5tlvKc5LRenuw/r+1aTzd2k8BOziN+f2uPvctm/x94xWXJ/nJEkedebV3J3pPtU0+eM5N6163hF8PXVw936g//q1nha3n/b87Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HbTBwgHqeb3mUa9Q3LTd0f1Lcynwrge02PmpqphrnX4=;
 b=eTvwUkGenPoR4djiIIOTsUhQoNFWy+qmtJzKo+YuVZUIWF1uE+LKppNq43N38aMLE9k6fzWYHfKaa0zTjWNgzlDsF3UYu+u1wEo5MOuzD/XRht2Nhyuktno4WVIhaffX9Jdt2wZMMtxO4sVcebgiWQJUB0eW6Mu5WC16aM6W2CcRb0obTeX9QPIF6HFbshqOgKE0dLqXBQsCDMWupaVv1r1f0EDN50kvVjvLeOExYT63QBwK2YOqcb1U1YZcndT5/zsbx9rOVknc441ZBdX1wyanp6V3aCfy2GOnh9LcsfLPFhXBL1LHRYVr6o7zVCTLdI/9jcuWAAoJKVPeIZjUhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DM4PR11MB6477.namprd11.prod.outlook.com (2603:10b6:8:88::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Tue, 2 Apr
 2024 23:27:06 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e%7]) with mapi id 15.20.7452.019; Tue, 2 Apr 2024
 23:27:06 +0000
Date: Tue, 2 Apr 2024 16:27:03 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>
CC: Fan Ni <fan.ni@samsung.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Navneet Singh <navneet.singh@intel.com>, "Dan
 Williams" <dan.j.williams@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-btrfs@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 02/26] cxl/core: Separate region mode from decoder mode
Message-ID: <660c9447838db_8a7d0294d6@iweiny-mobl.notmuch>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <20240324-dcd-type2-upstream-v1-2-b7b00d623625@intel.com>
 <yd6mynddwk755ypomyspzxfsqwm7j5g47yfmbw2yfwoadpnnqy@7g3ktxrwkeau>
 <6604fe9e18eeb_20890294a1@iweiny-mobl.notmuch>
 <b6ff085c-8cdc-4867-83fd-9566d59d5946@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b6ff085c-8cdc-4867-83fd-9566d59d5946@intel.com>
X-ClientProxiedBy: BY3PR04CA0021.namprd04.prod.outlook.com
 (2603:10b6:a03:217::26) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DM4PR11MB6477:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vC3jSYEqAQSCEdbEgKIiGjagdu5Bv8j7OxtuUp+WOS3ThKBpTg8GnWVfE4tUC4FdQV8ijk1FYd7eG4dkSkg8ZqbtHHOC1/S4PQyPcVjxqg9WhxsDLi5kBLFwBWKBW+3525hCCy7l4AzdoUYubIoyxoiebwn6KjJhTSXO98nsSHGPpuuFoHqfQ9YA2/oh6O6+1jfDAnZ6FXU8gm77Nh+LICI4BWKa0VVIax74EqFAMALjgTZNszamvgNQyXlSqMzD49T4UirN1NgJEKS3eqjZ9T0Nok7Wkc0EMB4OnAi2eBe5we18GgEUQ6zZuupCftwrFHhjO+tbcmoF7uFvJJqG/aG1+kcO3Jz9YAIM++PRxUTCNQE0/clLnewqtC8UMgnHbe5n+uH1fhEHxzRPiI2i2g0JsrqfB+cJDxZob8vCUMlmrS8WWjKrbErOEDgMYqU9GfOzezBGbitCN/MJb55UBK0iITSc+NB0HXEMw77id8xuMGrUlRs+l8AaP83Ekms7g9WEmJkuFTsNxkQEINnbTNe2DWy1AolM8BKj+TqPSMv93ZCv76qZxUJ8xoQfijerQ62wP7pa1WLJk8Kv8O78Sx9GatLgAYv0o6zElwq3Pml6rNZVTzcEBFgpgHeRw6UY354ZVKH2WGC8NvvTATxcZKBQfFf3VJaAUEGNWYQt17M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?amOXZkjN55d3jMSc32tprPALzW6vgy0fc4rRf29sOKyg4Z2qt4hQjb2QYc0X?=
 =?us-ascii?Q?3Sb+MWMUJ/vW+VZroQc70DN78Ez5fAfZVIcC2fiilcnL/WzxL4x2fqTlSxX3?=
 =?us-ascii?Q?9e4CBM5TqvJLD5AZKIbNkkbpVVtsCuboabm39AoK3k8E0zH2HHM1UEX7Bvy2?=
 =?us-ascii?Q?/Vtwmc/Dq8AW1JLQRlFiEOxhCz1Vq9Jm+jFYHEqaDeH20rrnnmDDNqtHK4rW?=
 =?us-ascii?Q?JupT6fFvkEi0EcBsNVcbJB92Iz6XYEfLxmbYvZ+QFNs64LnXppyzUD7V3PxS?=
 =?us-ascii?Q?YisgxF9ldpjMWrKc9FXJertsX2DADcnEG6D/XMarGaUJDnp0TOSS6ANFHVsd?=
 =?us-ascii?Q?aBZGT3qAs0lMKHviQi7iyZVqhpf06OVuW9SWznltjhc2Tyw9L/Xn87CkipKt?=
 =?us-ascii?Q?YAS6UHF7m/Ngx0xOYGKtTxJvYLSt3kUB72UTtrkpye7Uvc5yVGzUeSGEYDuM?=
 =?us-ascii?Q?bmEpiwFEXk68H9s2ChL8KS2Qgh11QfJu/aYZ7rF5rg6/pJJHO78P5OGAyfU5?=
 =?us-ascii?Q?tyegYqpWs25zr8BfMSephEqawK8NoBjAPhvDs4Nd7p0TB5ntb4ZUrnId7L1U?=
 =?us-ascii?Q?jsGiDsRt1uN9/dHQZejdMQ7H9f+NHMqLd8qRSMwjTGpaIp0uEFlJB3PEes0Z?=
 =?us-ascii?Q?o4HgOUHBBs90XJzXyosrGNLDIcSRGg3FQ7Li+dPn7Aha6yR+mcIWP6Ay2oOs?=
 =?us-ascii?Q?J5ZlkyDcljdyOmrb/l9WYM27tnBveb2UvMenCrALLeQ4OYow/CPPenEBT1tx?=
 =?us-ascii?Q?uLXl4rGz4ZPEuD8B7FMTnGRSeMzbhodZq96TSlVmYZd6fTryqgoMTR4fbXiU?=
 =?us-ascii?Q?nCO5sCsVS698bYHr/TekP3ffYK6vGpzRWzoiXjogYMMNm1WL5SsX2opsYWcW?=
 =?us-ascii?Q?cvxyOR/Zfa8xn3G09gMY+w3sKcsg6zTy+DzuyoGAG8z6b0gb7Ecd+LNfOTcw?=
 =?us-ascii?Q?UfXdwMwt3Igp3FNP3TH78tAvRrYIOCtEJz4NKn8lMSK6M0PvJULzlQNjzJkT?=
 =?us-ascii?Q?JX4jgombv4TVD8TRDquAvN9zmSqJUixTPzLGzLhlnMOYWzJoU/Zn2aShpfHP?=
 =?us-ascii?Q?AvQ8C8ay0t58p+Yb/K/xGc31sxQbZhJxvkT4R4o7uY2LIV6bHDA99StnraY4?=
 =?us-ascii?Q?ZIrh1MnEvH9HeBmjcHA2iOwDg84ZSsgvMjkVPFTkAJ2l7OwL/RFpA6w4Yoqd?=
 =?us-ascii?Q?cP0HorsyZglyObUM+13AC9BYl3n0ClaJhe0Y14QqGEum3c7/uZbOCer6/nDb?=
 =?us-ascii?Q?XTjsGOmJ1yPN/SYlMnRru0Q5wBVcR9VZobuRuxUUuywrYgyemcdin7ev4R1h?=
 =?us-ascii?Q?Im/VdGjf05GxgdLGAPqfNN8wuyL7Jumx1W/SUffIHoJlk2c6w3iGvP3tq7NK?=
 =?us-ascii?Q?zvPOnS62tS3pgD6i7FX0E4PXmpkiAfaJ6J/J/JpieaUmoTvtnKt6NAuD21Lk?=
 =?us-ascii?Q?9nrwtCDLFhgatezM6DCyWYIb+Y3ZVQFuviMBrvUmd0AWHSJjrK4iow5xbK6l?=
 =?us-ascii?Q?wxr+L2/4TvPAJcnSIeN15elTLwGuh6cQ46EN4+sis4XoARMhkdsd4rhWMYvy?=
 =?us-ascii?Q?i+jA74Pg4vhoaMP4sMTol+DADq6tVBKOmpFb0NSu?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 058536d6-caf3-414c-863d-08dc536c68e9
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 23:27:06.3077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w9QYrOwh5w3lWdug4fiWjh2zcObZQCAZ1GtZH5JMXNBgdl9uLLlODadk8C3cQtPZAiBgOzyTEIz0g99EYZwu8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6477
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> 
> 
> On 3/27/24 10:22 PM, Ira Weiny wrote:
> > Davidlohr Bueso wrote:
> >> On Sun, 24 Mar 2024, ira.weiny@intel.com wrote:
> >>
> >>> From: Navneet Singh <navneet.singh@intel.com>
> >>>
> >>> Until now region modes and decoder modes were equivalent in that they
> >>> were either PMEM or RAM.  With the upcoming addition of Dynamic Capacity
> >>> regions (which will represent an array of device regions [better named
> >>> partitions] the index of which could be different on different
> >>> interleaved devices), the mode of an endpoint decoder and a region will
> >>> no longer be equivalent.
> >>>
> >>> Define a new region mode enumeration and adjust the code for it.
> >>
> >> Could this could also be picked up regardless of dcd?
> > 
> > It could but there is no need for it without DCD.
> > 
> > I will work on re-ordering the cleanups if Dave will agree to take them
> > early.
> 
> There's no reason for the change unless it comes with DCD right? And probably no urgent need to taking it ahead then?
> > 

I think I just replied for a 2nd time to this...  yea.

LOL  I have to do better...

Ira

