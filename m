Return-Path: <linux-btrfs+bounces-19473-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A856C9D3B7
	for <lists+linux-btrfs@lfdr.de>; Tue, 02 Dec 2025 23:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 93E864E4550
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Dec 2025 22:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158292FB618;
	Tue,  2 Dec 2025 22:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l/f8jeu1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BC62DC352;
	Tue,  2 Dec 2025 22:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764715112; cv=fail; b=brYOplQI4zapP//lOo9N9vlQ16s/2AqFF3d+rMMv4BMVI+7CGhDfdrXE9v1SH9VujOU5I/ry4ctl12pD+KFD6B1TpIp1qDgPH4k0cagqkORxMNvo6EowDNYvb9WtmUZ1V+sVnKQezrxDQcTv9P5F2UUsLwCy8q2+eGAZL4NCPAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764715112; c=relaxed/simple;
	bh=EkJEhCsc8ilgJQFFPB5XwXFaWoZg5v/YsA7FS29Qazk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=puX/XwuxF4WS9NbevwViFouJ8Fypep+T8PzUNu3wcxlnFtOvCLTnhSeIFH789aXj0od5W1PBJwL1HhjKHXyM6kSeRUvhNqqHXGe8kZAMhy7dd8zQdqkqv+aL0B9PfOUcCaPhTC+ETB4WAY/Cwc1dMAN2Im7VX+xj4Qo2y6xm54I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l/f8jeu1; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764715111; x=1796251111;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=EkJEhCsc8ilgJQFFPB5XwXFaWoZg5v/YsA7FS29Qazk=;
  b=l/f8jeu1jOil5nrn8S8Qrf6wrgv1eI3Kwx+ngSvF+KleoyFaj6v9kU1f
   aDfmPl0ZgSEFrZl+VIRPX5csNzFtl34YStOPcO8vVRR0+9K2+XX6NvEb6
   SxkJhWX7HDE2Sk9aCrrLLmchy4nIHkml2ZvvRRrTR2Vq3MbQ5eEX7SQOf
   WEukrmfcVo9ymd8yJvhnCxh+q3yoVOZdyXZl6uU3LUR3vj3t59EdFHMRz
   XFa6oQYNwZDDPfN6CHE6XGnFGHIrJWoCx1vZmfv+1025mXYA29nv3j5Nn
   k31wkez99HkbaDPdPaIzWRfls+FWg2rWhyluC9qGpxjG/G/+/pS/TSb0E
   A==;
X-CSE-ConnectionGUID: YyixOa0gTRmu8LJjoEbFfA==
X-CSE-MsgGUID: tQWkY09jT2i4LIOAuP6A8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="77807216"
X-IronPort-AV: E=Sophos;i="6.20,244,1758610800"; 
   d="scan'208";a="77807216"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 14:38:26 -0800
X-CSE-ConnectionGUID: 1o20dtR5RNe3zp0iGqWP0g==
X-CSE-MsgGUID: GHFj8hMfQTW3pWRx4XyPAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,244,1758610800"; 
   d="scan'208";a="217849097"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 14:38:25 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 2 Dec 2025 14:38:24 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 2 Dec 2025 14:38:24 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.61) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 2 Dec 2025 14:38:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xsHGIP3S2GBD/RNOFvzCjJNFEe7qt9DvRF8KLY48wioai+kTjqoSRiYT8bFjFCbgJUGRH1cFPQMARqRF5OkfhqrU5nDKjtV1HNvwSZAt1m0lFl2nwN9kFrcc1i+xJvMxJ6FX1X01xbYGtnIpN/1Om99B6YktA3JoKkWb6LmM404CvVPARGcT49MCso6KKwqmBA+PIbstuRmbG76Ub46vG27yNsG/ZeJUZvD/EaLHXrztfKf3mXjzyJbkFsHg9a67qYFNvfNJRkhMTLawyNA2C7Pt9F8H8YN4B3f8cXMgsBPGCIyoxND+iK036JVNI0ATDodLIqHaKG2N7hHJhy8+yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bW9rG0qQ46C59354hO4BSLjZc5zQxh4p0r1A/C4Ec+I=;
 b=V0qoimf3Q8to78yXdFhis245qz3lBJKl66l3Tl4p/FBOreS9D76FYgS8hGI3l3951m9eQhZ+cSwOqu4XM2+t5K7zeriznwG47FQJqIXANwvOLeZl787D15xTHVQt694WHiuSFDl856txp+iOb9XBzEKFt6i7MR3MWoNVWUOAiFFnWLwPjgZlB0mM9z4zXcKq5/mhXzmgGDdzvJbBmFf+ns9Sj0kELbtRQO6KoYFSGI2xH3T6pmc1VBo8e3l/R4W1L1zUsJ7/fxl0Q4eERZfRadBLY5WWbeTbdzqE9lKEwWQuC+UX0VYEfyZFdAwdNcucUqyvAqT5RPOSE8rGaPwORg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by LV8PR11MB8698.namprd11.prod.outlook.com (2603:10b6:408:205::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 22:38:05 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::22af:c9c9:3681:5201]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::22af:c9c9:3681:5201%5]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 22:38:05 +0000
Date: Tue, 2 Dec 2025 22:37:55 +0000
From: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
CC: <dsterba@suse.com>, <herbert@gondor.apana.org.au>, Qu Wenruo
	<wqu@suse.com>, <clm@fb.com>, <terrelln@fb.com>,
	<linux-btrfs@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
	<qat-linux@intel.com>, <cyan@meta.com>, <brian.will@intel.com>,
	<weigang.li@intel.com>, <senozhatsky@chromium.org>
Subject: Re: [RFC PATCH 16/16] btrfs: add compression hw-accelerated offload
Message-ID: <aS9qQwPeM6UVvcQ+@gcabiddu-mobl.ger.corp.intel.com>
References: <aSok4RiuQVZ8zckR@gcabiddu-mobl.ger.corp.intel.com>
 <0617afdf-14d4-4642-8298-69ef71f53b4d@gmx.com>
 <c4f89df0-9373-4329-9e61-9b5592ddc2f2@gmx.com>
 <aS2nA8+YpNbKjXeo@gcabiddu-mobl.ger.corp.intel.com>
 <aS2v6g3f5nYi6hC+@gcabiddu-mobl.ger.corp.intel.com>
 <453951a9-0c8d-4e1a-be4f-2617c6a51fbe@gmx.com>
 <aS4UNIfxGK0y6HzO@gcabiddu-mobl.ger.corp.intel.com>
 <e532ff5c-a5a6-4ebf-977a-721471594908@gmx.com>
 <aS8dNt3gCzlIxBIs@gcabiddu-mobl.ger.corp.intel.com>
 <0bd22b17-97e8-4b8f-a7a5-5e79d280c078@gmx.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0bd22b17-97e8-4b8f-a7a5-5e79d280c078@gmx.com>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
X-ClientProxiedBy: DUZPR01CA0034.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::10) To CY5PR11MB6366.namprd11.prod.outlook.com
 (2603:10b6:930:3a::8)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6366:EE_|LV8PR11MB8698:EE_
X-MS-Office365-Filtering-Correlation-Id: e32dfcce-f537-46b0-d942-08de31f37520
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OFBrQ25FaEFRNTZKYktBOEdxQ3lIR1B2bEtxeDNMKzIvckhmR2gvU3RtSmxs?=
 =?utf-8?B?cFRkY2RObk5xd2x5dmc4RGFORlFuRXFaMU02K3FVSE52UGFHNVExQjNDdmxt?=
 =?utf-8?B?M2dlUjVzWUdac093aWxtNGk5ZWNIMXovK05QdCtONDJNQnpmUzR2bnlPU0dO?=
 =?utf-8?B?MG8xZjZYYUlJc2tJbnVXOGNKRi9YTmhyUlB6MFc3YnpFaG53WndmQlNZdVJq?=
 =?utf-8?B?ai9FUXpEajdZdExMbHhUZ2laZ2E3RGdNQ0NReU1nNFE3UkpuTmF5V0RlTld1?=
 =?utf-8?B?V21XR25GZnU2OWNsM3BkMTZtYzk4ZHVPd0dPTlhoZTZqWDkzVHRTQ3JNV0tF?=
 =?utf-8?B?M1VheWt2OE02TU41QStVTGRtVGtJeVNZMUFZeUUwY3JvbXNmUVdHcmVRcEwr?=
 =?utf-8?B?T1hwVG9pb0x5SFUzZjVlRHZJSW8rWXlmQVIxdVltcnB4RHZUTmZqVFJneWQ1?=
 =?utf-8?B?VGtteTVKUGJLMzg1NnFKdDJqMllUd0ROY2hTMjdLMGRQczNKWHI4eE5WNDBs?=
 =?utf-8?B?TzNOdzVyZkpEUGlzREFRQk9jWGdqdTg3L0w5UG5uUm9ESkE0YXJuZ0VOallI?=
 =?utf-8?B?SW5oSkVkNmdlR0RGSUR2YVdZdmRlcE1rZE5uKzljNkpQT09qNXFSOGhJdjZh?=
 =?utf-8?B?NjVYb2h0T1V3bVpPOE15RHJmZHd2dVpCRk1GTzUzdzg1ai96L0hjN3NzVms1?=
 =?utf-8?B?Sk00RnVYeUZOb3J2enBWUEhkN2xqSGtta1dlMHRIWnFHOEF0TTRLRkFpR2pZ?=
 =?utf-8?B?c2NoMXQvelg4L1N2TFlCL0h1Uno1VjZKNStCVnYxQ1ZwY3pScnk0cW1yMlZo?=
 =?utf-8?B?RHI1dktDQTZBdGgxMVI5aGNZcnYvMFZoMlNJQ09tS3lDeVNVa3ZrSm9pZTdV?=
 =?utf-8?B?MUlwRU0rZ0d0UWdGdTdaL1poZEx4K3FhbXdhNjExWmMzNHNHQU5WcExJQmpZ?=
 =?utf-8?B?dk43NGl1bzNhMFZkbVNoN0hyamhJTnVGVWN5OVZSL3ZqWWpHS1BXbTh6MjZa?=
 =?utf-8?B?UGpCNkEweWlpcThIRjdNanV4eHhsWXV6OGFsWjJFaDNoS3ZkTGQ2RkJtUDRR?=
 =?utf-8?B?ZzEvWFl6OHZtVW9oWDZBTjNIZXB6WlFmQUhEMXAza1FldzAwQzRRVnlHdlVW?=
 =?utf-8?B?dGZaRFFDamx0a1UyQTZpNHFPaTBTNXdseHdZOEFPclhvaTJPQ3FmTWRlUmw4?=
 =?utf-8?B?ZUoyVXdBTjAzWUt5eFhDbExuck5ibUVMaHhkTlRSV3pTQVFnbjhBdUdrOFFz?=
 =?utf-8?B?Rkh6ODdnbDRCbXVQVWFXSk5mMFlRSVdFZGY4TVJKT3JKY2YwQU1FdHVFWFVa?=
 =?utf-8?B?QllER2prRmdjVEZwZUdIUnh5NE1qTHhaemI3THhBWUNHaXhKZmtWeW53UVcy?=
 =?utf-8?B?QUtCUy9Zbmh3Q2NiV3hZTHZxT1gxM3o0bTB1aGVoOU9YaFgveEtPbkIvM21n?=
 =?utf-8?B?OEpKY3NNaS8rR0ZHRTBvOFViakdmMHZlS2hrTHovWVdIdXppM3dFb3c2Rkhz?=
 =?utf-8?B?anNhaW1YSFd5SlhaKzlZbnBBZFphdHBmby9vVFRJQ2xiWllVQkxpQktlcEdV?=
 =?utf-8?B?Yi94RnRDZ2V3ZzVIVnd6V2dpU2kwWVovVCtIZnZ4akUxNXZZeWRnT01ObmVm?=
 =?utf-8?B?ZjBOSnJUVkt0eVVMYnNMRC91cUZUZVZCemRpWCtZbGZEK3JrMXVSY3VTVktL?=
 =?utf-8?B?OStDQk81T2FzRG9FM1BvV1JMNmhUaWVQZTJjYjhMQ0pvR1UvRDZ5ZHdjWVYx?=
 =?utf-8?B?SmxEZHJWeDdFTWJlVm04NU02TWJadGtRVDVhOEY5YWRISEF3b0xpbzEwcHNv?=
 =?utf-8?B?eHdQSjB4N0l2RittZzVUOFVXM0JCUm13eEEycjJhQ3VoN2oxYlFQZm9LWWtV?=
 =?utf-8?B?R0RSR0dxNGFJalhmWktIMiszeS9YNVNtWEVvQTV6cUdpSHY5R3dJaExpQXN3?=
 =?utf-8?Q?uZJaAPABufikQmrjDp6oZMNKday29sEf?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHE4SVVWanliS1lNbXZGSkU5M3JTQVVvZ3JPcUIwYkpidnpjcjRhSVkwZC9a?=
 =?utf-8?B?TnlJYU52aC9XVVkvZVFOYTJmYloyaG8xWlFXWTZNajk2L0wyRy94anVKV0hY?=
 =?utf-8?B?a0E5QWdQZU11Nzl6N3FVbjJOVjJKNERHTjRGbXV4VXZTYWR2cFplRUJURkRI?=
 =?utf-8?B?QkVxMFVvZGdoUmF4U2FsNDIzSVkxN2NKMHB5M3Y5ajRHdURINU9Ba1dWMk50?=
 =?utf-8?B?WERCSk0xdFNTSHlDL05Wd2YvdWhpVHdteElZcG5GbDRiMlhER294WTVYMEUz?=
 =?utf-8?B?anFFcHdiMkdNSVlYd3ZWMkhpYVZMR2tRa0VsQ2VJckZEdVdmTTFzMkI5NTJW?=
 =?utf-8?B?dU1aNVUwQWIxdXFhR011V1RWdGZneU1NbDZaWS8wdzg5ZEpvZlh1bHFNeFla?=
 =?utf-8?B?bERtZCtldGIvOTNVWmljWlRPNlVMVVRPY04ydXVnZ0hYNC9hSTJoZ2xVTEtx?=
 =?utf-8?B?Ykt5aXU4Y3VKeUhmQ0MrRTh6MEVwc0hocXJTUHRqTEdMck5rZ1hwOHI0UHNB?=
 =?utf-8?B?RVlVOTAzd1Rta0svTnBKbGU0VUw2OUx5TEZXR291R1VjMlA1bGdrcHdoY3dT?=
 =?utf-8?B?UE1hRktMMGFtZ2M2djhIQ21RM0t0Vkg0aUdoblJ2WDRPTXV2Uk1EVDBOdG1z?=
 =?utf-8?B?cnZ2dUExVEtVbnFBamg5SnVnRU1CTnpScGk5RnYyU2hmYTNsdThVMHQ0REE1?=
 =?utf-8?B?TnJRU1Q2UERxanNBak5PY3gyWUhNY0dOQVYyVmxFTUN4K0l6S0w4MkFLdlN2?=
 =?utf-8?B?U1pZMkJsUnI5YUlldzIvZ05PQzZUU3R0UG1Iek5FeTd4WS9tVnV6cXVpVzFF?=
 =?utf-8?B?bjJYQ0d4TnhKcGFKOEl6U2J5UjkxQy96dVBqbkxET0hxWk5FTzhiekhFSDVW?=
 =?utf-8?B?TnMybjdua1JXR2NNcVh0Vkp5SDVJbm5nQnd3ZGxyTnpvdFVnRVhSb1daSkNp?=
 =?utf-8?B?UUR0WlR5WGN0YWZGSVBBbVlxbnJ3OHlMcTVOTWUrNExKYkorbnlrallvT0VF?=
 =?utf-8?B?ZkFrZng1RmV3SE9IVWtSSjJ4ZWhKNzd1bm4vYTdWbHh5QnlPRUlHbVpWQVNZ?=
 =?utf-8?B?T3Boelh3U0lRcldOLzVlUzJOYlhiNXh0ejNtUjhhTEZvUE1TUTFTUnB0bVdM?=
 =?utf-8?B?dmZwbGpuNUUxdmkwSi9FTnJlSGxNTXNKYlNvcHRlNUVpUUFQVlZ3eHZLenhN?=
 =?utf-8?B?NW5uRVpXd080TWFhV1BUcUY3R1VJT0tneHpxSXZ5ZHRSSUtrMWZCcWphQzFV?=
 =?utf-8?B?b1hRWTQ3S0JZcmxXdWI5bFBJazRSa25SSE5qT25xNTZZRlNLV0daOG9xTWps?=
 =?utf-8?B?VHZOUlI2V2FwTUwwcEJZeEY3WkNvWGI4MFNaTk0rWWwwYzd5clA0aVNtQTVi?=
 =?utf-8?B?a3ZzQlRFbXU0TWpvWjhGaXEyN042a09jNEdUeENxRGFYR3JNSWtxdnFVbjBP?=
 =?utf-8?B?QytjNllhMW5rZ0puN1ZYUXNGTGNvcFdldTBBbHkvRGJienp6OVF0RW9nQ2RG?=
 =?utf-8?B?MkQvNk1PbmRMTFoxT2VMY3JLb2NNaUJIeDJocERmUFhqak9CbHpTVmNLYkpj?=
 =?utf-8?B?cnFRUzVBa2pCUXYyZGRSUy9lYmx2cHlORTFtdlo2bTNxUkE2TXQ3dCs3MWZJ?=
 =?utf-8?B?R2l5YzBpeVlLQkxRM1NpVlJkRW9FUmVqckRFb0hSZVZDNnl4bk4vZzg4YW5o?=
 =?utf-8?B?dnk5NUxJRUJMaFgwOVYzTktoTFZ2MzdvNDE2NXpOem1YajFCRFJrUitiTFNz?=
 =?utf-8?B?M0FwVDFKMjFBSGU3cllJM0p4WDEwSkI2bWlwWWZNWGhXZlh6Z05Lajc2ckh6?=
 =?utf-8?B?MFR4aDZicVZPc0duWHJ6Z3U5SWFqcXg2Q2JrN0ZOaTUvOFhHVXRuLzFFa3ZM?=
 =?utf-8?B?UDBkOHM4aDFjQ0hlRmh3ZG9BOFR5amVOL3dkUmk3c1llWXM2RUwyVktlL1Zj?=
 =?utf-8?B?M3UxVlUxM0ZtTUhLMU5jcjVKdzUxclFaTTk1QVRzdll1Mk4relFQLzV4N0Rj?=
 =?utf-8?B?RHlyMlFHZThWeHVaTG9takpYbmIxU0RSQkRUb1h4L2hpNlJVcHZPU0h5cW1V?=
 =?utf-8?B?RVJBbjc5b2IyT2ozS3hkMmlCdUxBYTd0NldSdStrMkoyTDMxdGJUYXJQeUh3?=
 =?utf-8?B?TXg1azdSbWZQWnc5ekRMSGIvZWhBOGp3eG13Y2xGaENpQzdaeVQ5L0tjcTZM?=
 =?utf-8?B?L3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e32dfcce-f537-46b0-d942-08de31f37520
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 22:38:04.8415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MjLTU6EY0GV7kMt5wececb26h1Vu8LXlev7EGTlK4u2moRklmkb5CJdkepx0Dpv60pMtXKQpQz7jKu5EWrZPF7LGjHRjpbqhNzIQR81jebU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8698
X-OriginatorOrg: intel.com

On Wed, Dec 03, 2025 at 07:08:50AM +1030, Qu Wenruo wrote:
> 
> 
> 在 2025/12/3 03:39, Giovanni Cabiddu 写道:
> > On Tue, Dec 02, 2025 at 09:43:24AM +1030, Qu Wenruo wrote:
> > > 
> > > 
> > > 在 2025/12/2 08:48, Giovanni Cabiddu 写道:
> > > > On Tue, Dec 02, 2025 at 07:27:18AM +1030, Qu Wenruo wrote:
> > > [...]
> > > > > > Here is what happens:
> > > > > > 1. The acomp tfm is allocated as part of the compression workspace.
> > > > > 
> > > > > Not an expert on crypto, but I guess acomp is not able to really dynamically
> > > > > queue the workload into different implementations, but has to determine it
> > > > > at workspace allocation time due to the differences in
> > > > > tfm/buffersize/scatter list size?
> > > > Correct. There isn't an intermediate layer that can enqueue to a
> > > > separate implementation. The enqueue to a separate implementation can be
> > > > done in a specific implementation. The QAT driver does that to implement
> > > > a fallback to software.
> > > > 
> > > > > This may be unrealistic, but is it even feasible to hide QAT behind generic
> > > > > acomp decompress/compress algorithm names.
> > > > > Then only queue the workload to QAT devices when it's available?
> > > > That is possible. It is possible to specify a generic algorithm name to
> > > > crypto_alloc_acomp() and the implementation that has the highest
> > > > priority will be selected.
> > > 
> > > I think it will be the best solution, and the most transparent one.
> > > 
> > > > 
> > > > > Just like that we have several different implementation for RAID6 and can
> > > > > select at module load time, but more dynamically in this case.
> > > > > 
> > > > > With runtime workload delivery, the removal of QAT device can be pretty
> > > > > generic and transparent. Just mark the QAT device unavailable for new
> > > > > workload, and wait for any existing workload to finish.
> > > > > 
> > > > > And this also makes btrfs part easier to implement, just add acomp interface
> > > > > support, no special handling for QAT and acomp will select the best
> > > > > implementation for us.
> > > > > 
> > > > > But for sure, this is just some wild idea from an uneducated non-crypto guy.
> > > > 
> > > > I'm trying to better understand the concern:
> > > > 
> > > > Is the issue that QAT specific details are leaking into BTRFS?
> > > > Or that we currently have two APIs performing similar functions being
> > > > called (acomp and the sw libs)?
> > > > 
> > > > If it is the first case, the only QAT-related details exposed are:
> > > > 
> > > >    * Offload threshold – This can be hidden inside the implementation of
> > > >      crypto_acomp_compress/decompress() in the QAT driver or exposed as a
> > > >      tfm attribute (that would be my preference), so we can decide early
> > > >      whether offloading makes sense without going throught the conversions
> > > >      between folios and scatterlists
> > > 
> > > This part is fine, the practical threshold will be larger than 1024 and 2048
> > > anyway.
> > > 
> > > > 
> > > >    * QAT implementation names, i.e.:
> > > >          static const char *zlib_acomp_alg_name = "qat_zlib_deflate";
> > > >          static const char *zstd_acomp_alg_name = "qat_zstd";
> > > >      We can use the generic names instead. If the returned implementation is
> > > >      software, we simply ignore it. This way we will enable all the devices
> > > >      that implement the acomp API, not only QAT. However, the risk is testing.
> > > >      I won't be able to test such devices...
> > > 
> > > This is only a minor part of the concern.
> > > 
> > > The other is the removal of QAT, which is implemented as a per-fs interface
> > > and fully exposed to btrfs.
> > > And that's really the only blockage to me.
> > > 
> > > If QAT is the first one doing this, would there be another drive
> > > implementing the same interface for its removal in the future?
> > > To me this doesn't look to scale.
> > 
> > I should have explained this better.
> > 
> > The switch is not QAT specific:
> > 
> >      /sys/fs/btrfs/<UUID>/offload_compress
> > 
> > It does not require any other compression engine that plugs into the
> > acomp framework to implement anything.
> > 
> > Here's how it works:
> > 
> >    * If `offload_compress` is enabled, an acomp tfm is allocated. The tfm
> >      allocation in the algorithm implementation typically increments the
> >      reference count on the driver that provides the algorithm. At this
> >      point, the hardware implementation of the algorithm is selected.
> >      Compression/decompression is done through the acomp APIs.
> > 
> >    * If `offload_compress` is disabled, the acomp tfms in the workspace are
> >      freed, and the software libraries are used instead.
> > 
> > So there is nothing QAT specific here. The mechanism is generic.
> 
> But only QAT requires this, a "generic" mechanism only for QAT.
If this solution is adopted for other accelerators, they will need it as
well.

I tested sending traffic to another device that plugs into the acomp API
(Intel IAA) and then tried removing the module while in-flight
compression operations were ongoing. It was not possible to remove it
(as expected!).

IAA currently only implements deflate (not zlib-deflate), so it cannot
be used for this specific case, but the same limitation applies. There
are also other drivers in drivers/crypto, including non-Intel ones, that
integrate with acomp for compression.

So this is not QAT-specific. The problem exists for any accelerator using
acomp when dynamic removal is required.

Thanks,

-- 
Giovanni

