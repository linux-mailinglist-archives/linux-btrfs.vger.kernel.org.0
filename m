Return-Path: <linux-btrfs+bounces-4089-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56AC189E9CB
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Apr 2024 07:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78C141C2151B
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Apr 2024 05:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0A219BA6;
	Wed, 10 Apr 2024 05:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gJ5+QAnz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974BA134DE;
	Wed, 10 Apr 2024 05:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712727257; cv=fail; b=DU+LEruGsyLN5J152KrZD20Uwk7Qb7Xi9XjBBqSJnZInHugv3qZBgF9xiy0McUm0Y+XWH4f2l69kmVkjFVqzFnHMeT0K8H8qmzAOTk9tnzaN8vf6iSStCfX8xWbUSGrxeBcPwW5Im032Bxew4ncd3sj/c12JeMVw+Pt9Mq9Xo84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712727257; c=relaxed/simple;
	bh=Vs9h5pnC1eVGPfxEApTh0hyCpWJj5i35TnBeLne14uE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=O6Pry/Y+TzBKfsnewUFR8SQg8dq/MEsRsBCKdNke8qeW/WmDCRI9khAjAUZd7G6+ejI1Mo+5KSpyhNb0pxx/qEnpIZVFb79aKsSgFPiXMAhPHf+AjxPOAMUKKAnIxjCljdYfk/QAX8pGMavgRTkDYDvGev2U+ACnDUpBz3ERsDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gJ5+QAnz; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712727256; x=1744263256;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Vs9h5pnC1eVGPfxEApTh0hyCpWJj5i35TnBeLne14uE=;
  b=gJ5+QAnzfq3DCzMP3Y9LJJsxEgpqPeX12N6oZ4M+66HmzfC5pVWKd9qc
   oeG3B5isWoY13NdTuefsox1ELIUC7hL5KMV8AtQ2Y2ByJvY5V6Yyq5O5V
   jpBktnWV4NYFToSf+JmXkXgNN7AH8MagQC+3vV8S17w3upWH0eS1/Vesu
   1aszzJVUatSpR8Nc8+8RbLctx4DgwQsgSuE842wx/Pz960OtlECK26XRN
   lyPiNlae7elZVTnsjz/jTpbT2bJdo+UcshOM4pZ+1+a6YA9gxX1wokpC3
   k/UyDZkg7x3XvD7HviNMrQ4dzTGjF/c7B+mX41HmX7Y/37si2vT19ou7l
   Q==;
X-CSE-ConnectionGUID: PkA/DLBPRiqn401AYtMUQA==
X-CSE-MsgGUID: Bgv0rZFLSY2A6ndAeXC6rQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="11911502"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="11911502"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 22:34:15 -0700
X-CSE-ConnectionGUID: yf7tuJZgSoGAqM6Ajh1ZJQ==
X-CSE-MsgGUID: WG1jtpcyS+GhxdrOOE9fQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="43698082"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Apr 2024 22:34:14 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 22:34:13 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Apr 2024 22:34:13 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Apr 2024 22:34:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f6Ss2UHKzhCQRNpkksuXOQvx8KSmnxbfGIYDio8FT4ZST5qK+SneyG23dIJy6P5J7xglhDIn2GmAzbALSnN05OW4CTLaWIwAUrBnwviYJAmjh9Galvla1hFUpHVfY9Xr/15Qun245cF4CFik2CJ4gaAgMcYWYfV62PI1oJUE9tk/3c7nVpq1znG/kTMnb0+TkUYzdrxwd4FiomfUPvm+oNTTt+rHSOcILGxqN9w5N4TSt54XqmdarNKQT7HWIkXJossBGHIlUoI27iMg/WsM7kUhherkut9G9+GP61FW7LVbJrIhJENsVRvZSqu/sAt9oOb5weBVVlcoOgeuzjFBBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U9UGJBMkXVJ3v1AyWu3fKZxULAOJBhIY2jPQkB1ttQY=;
 b=XmzPaZwaVcj9KPIDwYFllqpD9NU6WJuT2io6MVwSE/zh0bFG9x6u32KE9pVEZviTvwkwltT/k+cLEEBQ/dGZuxqwGc02qUTADb3ZJi/dh4FQ+xePCEh3FH2B6VHm6a5B3IfObGV8ULJaIEF4QLGqDJUh3EkawaODSoClSgHXC/MppsDJqwMDxAQwkDc/d42DsWKAyIQ3cCP989P1gdlugjm4ZBXedQ27KFE7DPa0bUWCDedKuqU5Ne/gDWIfWaz7KDG2RSf/qmxU94ZaY1hnE4hWitNGAX/XbeC3jRqMRHNb0/auX3iNsicujnv7BunlX6QTk0wwFaHc1WhOsvLRkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DM4PR11MB6431.namprd11.prod.outlook.com (2603:10b6:8:b8::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.26; Wed, 10 Apr 2024 05:34:11 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e%7]) with mapi id 15.20.7452.019; Wed, 10 Apr 2024
 05:34:11 +0000
Date: Tue, 9 Apr 2024 22:34:08 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, <ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Navneet
 Singh" <navneet.singh@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-btrfs@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 13/26] cxl/mem: Configure dynamic capacity interrupts
Message-ID: <661624d07d41e_e9f9f2944c@iweiny-mobl.notmuch>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <20240324-dcd-type2-upstream-v1-13-b7b00d623625@intel.com>
 <20240404162245.000032f3@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240404162245.000032f3@Huawei.com>
X-ClientProxiedBy: BYAPR01CA0011.prod.exchangelabs.com (2603:10b6:a02:80::24)
 To SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DM4PR11MB6431:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X0PInNqsZnoRtoaMjS8FjU+HHiPrt6oq89xVc6ZELlycBBIQVjMGLVSdOIYZmy/YGlg+Vz0RSVyBCmexVoB27jMvtMEeKxS37p1ZOpUfBhuOAOvwvFhdfOFkP77pnAnuMsSR8Xjv1phEOlkEYBGk4qENCthnQHY1P9YeE9dvg52iihyUZHe9UHNLumLZCRRwpO99n6bnW4yUEMjJ16pT4Vik4iFurSojBAZH7vTg+i3NnveamsSkvcQfTbsC8jD25Y0d4EquN4S+fxtmfZBaHb5VPdtOEs3Lk748dEhYeWbdWn81FJpb3Zxsx3Mj/Ec6xqRxqGwmpNztbsVqWe6FIIm0bDTNCTllcMP+51d1eeJQNmnY64fldSFzFuQlU20/c8YUFDLzwFefZqT9zq2DiB91vK85ra1uTjVDtnjs3XJbzrEKRtkRgJzQtxPEMrqr3/ACvmANtG9tlstkHQEkMij/5J31/3XvhfD+NXpRk5/j9rN5v4/0LtsNvZRhFLA8xSF/oZvgfZaY2f3mgm5ky6wUHEv6a9fKXjghXxhgEgzpLH4rPOkjpDx0EygOO3kfo+G0/UayyOLhBcqUsM8RtKzR8S14XiirKo7eZotXy0DDXe0QkdGJOp60oSEs2gYRLk6ttW5Fnof+43UM0/C2nhDGXo6ebwRcvZ2UpkMLQeI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YAAfVjf8lDfmt7f+40ku/vJSYtAvcvqGaGpG4lg9PfD5xWPQQ2kdiqVD0JlN?=
 =?us-ascii?Q?4kyN40X8xzoyMDemfL9KfUAPDeenYPlGxU2ebUHbTa7OOeeIqclMIIFU8EOX?=
 =?us-ascii?Q?seoBcrxYOyfeVe3lSPD7PQX8hgfxOHt1SynCQlo9mWcUaVe7n2G3VaxapTty?=
 =?us-ascii?Q?5gDbKDVFkrZOvCXMuO+eDT4N1amWAnF8BZlsCjjigIu5jkxLEWpbJbXTolUv?=
 =?us-ascii?Q?cc5RoEGPdJNtnsEu8jBvXe3gTNCb/DGqtUYTiJ4nMKgE7umvkSSvxRCs76w5?=
 =?us-ascii?Q?MipmVsz8WvYWIizl67wHUCROwAzLAktAQCoLM05RnWdBTHxO4JhhXb0tyd4x?=
 =?us-ascii?Q?azwpLQIBZ0rBAE2SB7XG3re1UAME+hDxqPma+HDXjqtlbAXERQ607ZukETnP?=
 =?us-ascii?Q?ObcVteMqRhpUPFhO2BWBkmHUhbeDZ6ZUYa4Kp+a2eaSPCNPhuqEuXRPqCLwG?=
 =?us-ascii?Q?gJzSXmt0fMTmyu60ivcyXMUtf6R9DOxTqYmVd8++ully1NEoVZb6wCoFT6AW?=
 =?us-ascii?Q?HwtGtBbFqyxS1k/sIyhJ1q93oSazL0LHYboAIMDEVlincvzsIHac3pti0TDd?=
 =?us-ascii?Q?+zXhgVZqMLYXCxyXGrv7JHAQXHlYH5lfk+ROSW/XLCYx3pdpm1R/k+fITB2E?=
 =?us-ascii?Q?mlvTO3LCnWkxQwcM5MgvXLJnvgcUXv9ZAdW30Vj0og6mDPDH59dCuwrk/JIY?=
 =?us-ascii?Q?oh2hBGRxWFZe/r5K9Y8GFsVuE6oUYQUbW0XdJnJvxCjpMD4kv3quImrw67H3?=
 =?us-ascii?Q?IG+GmAEEvOS9H+j7EDD6P4g6EfOpkVgl+Vq3zVsPc+snGH/bJgIx5mi81BLz?=
 =?us-ascii?Q?N4lFFMM1Gb3ELICoe1qnNmT3VfL2R9ComPo6/ejLj5NUmRDNVSMoSCYNXx/a?=
 =?us-ascii?Q?EcQ858gkm7SynSkd6hpgCfiB6RoUxdShba8Rcfp1jc9ZCC32lt6iBwjRIcyW?=
 =?us-ascii?Q?PCYTHBCf80sTqKocn8/AFcn5bfwdusAdBEuVvsip7bJ0GeOF6V46LrE/5KBc?=
 =?us-ascii?Q?0Q0T3/TpyIJA2UxyJMroJNspdul52yrI6mdLTWbwlLU2pC65Jwgj5uBfmvr9?=
 =?us-ascii?Q?V152vaza/TSE0HFXYyh3rXErO4eGvaj2HZlnCSbRxPq4TtCfZDsXuCbh8wKQ?=
 =?us-ascii?Q?yJx0IQzG/zo2h2Es3CuH8ymkeVbpFGE67S71umkUvEtsMRIM51Sg/mAj9tSz?=
 =?us-ascii?Q?wvuhxMhSiiZbT9q6MoBikYeDVgxroMM5oySIeWSBtlXQ3K1v+Pr0UxN5C39Y?=
 =?us-ascii?Q?juXMoGGM+iei82uH2x7dpOK2G0noa83/eVgvYVOrCNgmAY+SHF8Wmh1dz0qo?=
 =?us-ascii?Q?YBXJMDwssjLlyfIJuf0PTgWzl8oQqIBDh7/koxQrh7vFGfLSlYkvnzhfD4D2?=
 =?us-ascii?Q?dLOkt30G8NU6QC4R/cjDAFcegWXoTvXVcMAtg+wXgZweQi61oKwCZQ8A5DoR?=
 =?us-ascii?Q?OeeVH0uz2/e/Fqr1EBrt2PH/9YSEihMToZ17zKS7IHtOVD+IlJZ1q8Yhfx8v?=
 =?us-ascii?Q?RB7bKWtHuCgBMIOc5KDMMk9GIh4g0uzm5GutS2T58EL79XUISJYMA9luWzy/?=
 =?us-ascii?Q?SotkgVkMEuiIGA9+ehqDoXWKgfVDcousRu+eYWgz?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bdb6634-c1b6-47de-81a1-08dc591fd9d1
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 05:34:11.3843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gEG7muFt73CrIx9+jchkQRSCSH13rPNRULDx7dpI5YbbZ3tKj8AWleZAWFOQN6F5zsIAB6WpByp24Y1VaagICA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6431
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Sun, 24 Mar 2024 16:18:16 -0700
> ira.weiny@intel.com wrote:
> 
> > From: Navneet Singh <navneet.singh@intel.com>
> > 
> > Dynamic Capacity Devices (DCD) support extent change notifications
> > through the event log mechanism.  The interrupt mailbox commands were
> > extended in CXL 3.1 to support these notifications.
> > 
> > Firmware can't configure DCD events to be FW controlled but can retain
> > control of memory events.  Split irq configuration of memory events and
> > DCD events to allow for FW control of memory events while DCD is host
> > controlled.
> > 
> > Configure DCD event log interrupts on devices supporting dynamic
> > capacity.  Disable DCD if interrupts are not supported.
> > 
> > Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> > Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> Trivial comment inline and Fan's suggestion on the debug print seems sensible
> to me.

Ok I went ahead and added it.

> Either way
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks,
Ira

