Return-Path: <linux-btrfs+bounces-2576-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 695B085B788
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Feb 2024 10:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DFDE1F28396
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Feb 2024 09:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B250E60881;
	Tue, 20 Feb 2024 09:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OzcWwiyN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191BC5FDB0
	for <linux-btrfs@vger.kernel.org>; Tue, 20 Feb 2024 09:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708421463; cv=fail; b=HHD6RRP4V3KRSFLLm48nJif7ppJJxFbQN4L64/mB5E6lns/zLqgRQ8JBvk6sQ+B/eujkyErBquNwxe4+gXCC36r/xa6LKidA5KZrPSpSXmZW6kOrBI8haRYOHEnFP0IQuE0ZHae1dgMC5NW0EpDVHLolqY/RWDNTc+5T08ltzN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708421463; c=relaxed/simple;
	bh=ckqnfXl3bl6OikapMr7OjdVGbawn42F0lC5dKcX6p3o=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RSWE62LJGWkAWzIP0mVspyOCsHkkCb6Co6wM+tohc6z6xFQs0sH+vq+khSE88ry10+wZovnihNHmtjUXPCQylD0S+y8HMSh6znIaBHfjYFbvPha28+z6HdeSY1qHMmI2koF8uqUIoqbcNhKSe7g0145wW6fqoBL4qlnvdqGSMJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OzcWwiyN; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708421462; x=1739957462;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=ckqnfXl3bl6OikapMr7OjdVGbawn42F0lC5dKcX6p3o=;
  b=OzcWwiyNXSMhHkuEYdkPJIzATXeE/rf3VdI8rfobIJZ1s2wNpYRaiCWz
   P87QfKSGwVEIBJIrZlNdbfnQrrkAfo5BVGxoULaxjNaOb36MHFP6Wz40b
   wmxXjNfiVCx+OaNsSwe5gsUlBOB4VvH4QsbHyOx/Wbd+sEXaABzdvY1/C
   9y64121t4mwJq9fjiaSrEMFBcFWD/cAs69F1kHXHQvfGX8diBu87k9TWG
   lVj5hPI2XzUPvkKAp+jvp0DctMajz50ovQhWW4u6ydOtHW1l7M1KeIyiT
   q7Toeg3FJ4ULl0sgzoCsPZb9xMPJYRlkGkij56/IPOzrcdiXT5Lrwnk7F
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="2659128"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="2659128"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 01:31:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="35751946"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Feb 2024 01:31:01 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 01:31:00 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 01:31:00 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 20 Feb 2024 01:31:00 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 20 Feb 2024 01:30:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QTb4UaY/QuKfkKqg9NhA/QEwDhcJw+uRVwUkSem6PlNWjOc1Lnlpcm3+LzHGG/fvcM+3eesEgwz7SaFf8Yyj5pkAR1mh9obXn7UMx0N+q6KT2KGkYcjg4jE7KdpCDQ6F997PWcRE8KQW4ZzVc62VsTC76a5bfGDk7AJPPA4i3nmvtplYPElZFUhGh38QaupXTyQG1uyhHq+P2HzHRx+WfG9JArexY8KI/RaTgjrJg3TM9WYTHxiHSSaCBRH5HJxZ5rHVfdUMlr3sLQHyxNGK8qAgKupBDbmGgtSCw41dWzDYAeCaxG/GT0rAzFvICU5OnLXlSjcudWSt1NcjrR3AwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JtneqN1vvZXLpxxU/NoPCXRDVLcoiZ2p6TbIZ/mSTec=;
 b=bCww5ClTAFIDWRSPGzKuOV7jS45mCf/LOgGQIehd4Zff8CxLTtML2x0IPeQ1ZRRCsC5/OdDqOF3rQouADK58WGMBMhM7VDfR2Hvv2wWVYiFiEOeG/R2tQxHIFw1tyLeNvuXBPUYKHi3anU8gpxSyvYRedUFpMncYH4RrYP/6O5fXw4N2sb5qx2oYz64DXnRcMLGZpL4YoShRmxaAxw235zds5YbroLnlyCqUAhUfqJNpsi69fQrwVbfIeXP1Y4Rfd05ufBR51JKQb5V90wRD2RKPo4wBA59eBFs7usxVU/cjGWM9LWb5uAfsA5buxnmx/9vh7iMoj3fCvve5C32Fyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by SN7PR11MB7067.namprd11.prod.outlook.com (2603:10b6:806:29a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Tue, 20 Feb
 2024 09:30:53 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::b99c:f603:f176:aca]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::b99c:f603:f176:aca%5]) with mapi id 15.20.7316.018; Tue, 20 Feb 2024
 09:30:52 +0000
Date: Tue, 20 Feb 2024 17:23:58 +0800
From: Yujie Liu <yujie.liu@intel.com>
To: Qu Wenruo <wqu@suse.com>
CC: Qu Wenruo <quwenruo.btrfs@gmx.com>, kernel test robot <lkp@intel.com>,
	<linux-btrfs@vger.kernel.org>, <oe-kbuild-all@lists.linux.dev>
Subject: Re: [PATCH 3/4] btrfs: subpage: introduce helpers to handle subpage
 delalloc locking
Message-ID: <ZdRvruJGPJbMlw/V@yujie-X299>
References: <02f5ad17b6415670bea37433c8ca332a06253315.1708322044.git.wqu@suse.com>
 <202402200823.Su3xBnia-lkp@intel.com>
 <549a5778-ee2f-4520-9147-f09854a50948@gmx.com>
 <ZdRbi3gumI2fGhUq@yujie-X299>
 <f4a2d37d-33fc-426d-975e-5408ada21710@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f4a2d37d-33fc-426d-975e-5408ada21710@suse.com>
X-ClientProxiedBy: SI2PR01CA0016.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::20) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|SN7PR11MB7067:EE_
X-MS-Office365-Filtering-Correlation-Id: 494a6704-1ced-4bb8-11a2-08dc31f6a18c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qzv8FNqoNyDXHAUKXSTBZZKQHPfJ52nBzLOj6LvXuf6GVsK5/5ihU3tUSL4GADQLB1ZV1OWo0jC5YHRle3+CEI2ANefqgeAcHi2gTk/EzK7o0FLxiFU2sM14qzjis4uW0X+CIcQLAew4jBR0y6H5heyE99WNrHoxquazd35J9tsyg4meUHPhCYw+ehH/f6U/+pLPoJndDREY1EP3pYedyi/LVTP333T9WoDeMLb1OKgcN9cuXLuXbIYpekS6otpq6dhJ5wiwNTKhQu4mqIlD8a2WO9xskSJ7fbNt96OrKukZ7LcbqDuRiWYqi+7l4WKPzEHHHEdf2kuUf1Hq/W2MAL8QnoKsd2Dnau0NbgfwGRPn3ehhlIq1Vd/DRZWDwspp7+hP3Z+08nLH1x74pt3nP0tMw033yaoy/DFXD2omy/s5te1ldU753zoUnlkqgpSzSxQFomhY8gZmL54pmIcf9lVStPVO/g4s7/3VG7yu9MyQgfbRZopZ8BB+40csWm32d2pX70H7wqs5h6AEZKu6Bg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkFra2gzdzV0aHU0N2JtcjZTYUtyZGVGSnZDUzlrdS90NmlyOFdpUXRuQVV0?=
 =?utf-8?B?dVVUTEVDbk5EV0JEVWdSK3BHQVV4Y09PMWdsdzY1bExROHBrSnZpMGpVZlBB?=
 =?utf-8?B?T05JM1FLUHBKOVRCMjJsMklNVEpQOWdhN1pTR1hzU0pqNXJZRWpXemJzWnNK?=
 =?utf-8?B?ZGNUZ2Y4M0FKY1pRRzVveUJ1cUhRTkVRSW80UlNjYUV1a1lWOXNkbzl2Y1Rh?=
 =?utf-8?B?SDNQR200UjJvSUpLa3NKZW5IUjMrTm5MREVETHAvVHJpUDAwVi9LcVc3WHFx?=
 =?utf-8?B?RUl0OEN4RHdRWGlDcmhaemNVakdrRStzNjBCbk55bTlqUzh4bGlHd1FHdWtZ?=
 =?utf-8?B?T0gxT2VoY1JqdW00QWxwanJrOHc5OU5FUjI1M2lPblNPbHNWbkI3V2o2NkRM?=
 =?utf-8?B?VEtCOXNnTWVLQ3R0dG9RakJ1bk1EZzFFSUc0NEpKZlFMYkRrMjBDdTJSL1d1?=
 =?utf-8?B?b2xQeGxLNjhVcERIVGwxYnpFVTlVV3QwN1FrTG5vS3F0bUxxaFl4aWtpUXJJ?=
 =?utf-8?B?TFNEUzFDOVlCOTc5aEcrTjNDdFE4eEFFN2l6VnBqSVBCbzBLeVYzcUZLS25P?=
 =?utf-8?B?U1RtZ2pwbVJRNm56SEYzNW43cWliVFIvL0lxQllTd0srMXRwajhPRE9sckpu?=
 =?utf-8?B?Zkx3ZFdLZkg4V0x5S0JnUXZEcVlKalk4cndXSE9vVUVQT3JhZkowTnZjcHk4?=
 =?utf-8?B?cDFIaFZUWWYzVU1tbGs4RS9pNDVQVW5odUo4UUhHKzZTbW5qTkRmSVVKR2U3?=
 =?utf-8?B?S1RlY0szYjJjWVIxbXNSM2NYemlsZ2dkenpUcWtyL3lQeWhrMTZ6dmtnREYw?=
 =?utf-8?B?L2N1VG9OY1BLaHQ3T3VDRjVaNXNNQlBMWG9FaWRkeEFnWXN3Qkd6bFY5c2tO?=
 =?utf-8?B?bDVVcXNzeEd0eUQydnRrbUY2bFRadTJMV1R5cUdZWkY2UVB0Q1F4TzM1Nzdo?=
 =?utf-8?B?M2F6cGVkczR6YXZrN1JwYnFTam5vSy9uZkRYL1FRT0JJb3BuUERFek1FRHE3?=
 =?utf-8?B?dzEvbllDREkycnZ1MUpMWDJJTWhxMWU5SkNxQ0NNNFRyRUFrMkNFdnZlZmkw?=
 =?utf-8?B?bnlSOXorRTNhQWdtV3FtYWw3ZUJJVmpLUEZkSmk1QU9LQXNJdnVsQi9FQmpG?=
 =?utf-8?B?c3g4ZzV0OWJPYjJrQ0c0YXB3RmJIQXlFVHJkd3hRNkZXUzJZc1k2REZsUWZo?=
 =?utf-8?B?Q2xXNi9YejZLTUlSb0paa0dLVlB6elZLYU9jUm5XUXFEKzErejZtOFc0MnVh?=
 =?utf-8?B?SUlCc1lOSmFKeTVjQTgrS2hFTnY1dUJybzRTREZTdGswMlVDa3I1VlB3UG0w?=
 =?utf-8?B?b0ZyNi9lUXovZE5UYUtRblR6MDhEd3RaNTY0WFRoSzIxUjFXUzFzam1hMTFY?=
 =?utf-8?B?SWUvdlZRMVA4dFgwdGY1RlV3OFNMdm5NUm91cUhYaUJGVk9JdS9lWkJkdElQ?=
 =?utf-8?B?SExBMjhhZVFaZmlXWmF4WmtDaVdMTkF6U3BGeTl2L0VQOEpUbW02SS9wczBp?=
 =?utf-8?B?Vno0TkNOY1RrWUJqTHdZcDBjMVRmQVY5bWo4Smw3bDRobHRIUzhWb1pOdVBU?=
 =?utf-8?B?M2w1Q0QwcGZ0M2VMUzhMc2ZkS1RYSDhQOHI2c2QweWJDTkY5cFJCQ0NDNElM?=
 =?utf-8?B?d1hDVHVxcWpiT0VIQkVNbXNXWUYxMkI1b2VSTmxBaUZwYk9xUGxYYnEyOHgv?=
 =?utf-8?B?VHJCdFM2OTA1dWFrSEs1N21SZExFdzNCRyt0bENMWXg0Tks5cndtellFeE1G?=
 =?utf-8?B?Q2FmaE41aWUyZ3M2ZGNjSG1SaXpwRCtBbkZIaHczQkRUbldueThrNEIxd1Q3?=
 =?utf-8?B?MkZsK3czdjExVk44bEhDTlAyZnR0Nm1Ca0NmQjJGRXQvMktHcDJCNktrN0g5?=
 =?utf-8?B?Q0FzdXdZcVFnS05DbnpES0FteHhteWZ4SHpEN2cxL0JwOU5rMXFieG1PMm5R?=
 =?utf-8?B?aFBBYlBYNlN0ZEQ1ZnpBZlBCUmY2SW8xdkR4Y3JRV3psWmhZMXR5SXJ4cTFP?=
 =?utf-8?B?QXgxQzcrcnRHSEVxKzdMYzhORWVvKzJZdlc0OXc1eXd3QTNocHNIT2hvNkR4?=
 =?utf-8?B?di9wYjVnVXZ1NUVWOGFWc2tiWU5kekc3a1BBNEk1S2pxN0hjVUhiaFZpVHpF?=
 =?utf-8?Q?Z3dWBFW71ISU/vGC51DsxcIjc?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 494a6704-1ced-4bb8-11a2-08dc31f6a18c
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 09:30:52.2801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kwFx8K3IKY6gF2eOxYjshiIZJJ68WzHbUTOZtuBMof291zHGcY2PRGA3CMDGvVnkh/04D6Eb299ou0WAb3FERw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7067
X-OriginatorOrg: intel.com

On Tue, Feb 20, 2024 at 06:56:33PM +1030, Qu Wenruo wrote:
> 
> 
> 在 2024/2/20 18:28, Yujie Liu 写道:
> > Hi Qu,
> > 
> > On Tue, Feb 20, 2024 at 11:46:17AM +1030, Qu Wenruo wrote:
> > > 在 2024/2/20 11:22, kernel test robot 写道:
> > > > Hi Qu,
> > > > 
> > > > kernel test robot noticed the following build errors:
> > > > 
> > > > [auto build test ERROR on kdave/for-next]
> > > > [also build test ERROR on linus/master v6.8-rc5 next-20240219]
> > > > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > > 
> > > This is applied without the previous preparation patches.
> > > 
> > > Is it possible to teach LKP to fetch from certain branch other than
> > > applying them directly to for-next?
> > > 
> > > Do I need certain keyword in the cover letter?
> > 
> > Sorry for applying this patchset on an incorrect base. If the cover
> > letter mentions that the patches has already been pushed to a certain
> > branch, usually we will skip the patchset and directly test that branch,
> > but seems the bot didn't recognize that there is a github link in the
> > cover letter. We will investigate this and fix it ASAP.
> 
> My guess is, I'm using github's branch URL in the cover letter:
> 
>   https://github.com/adam900710/linux/tree/subpage_delalloc
> 
> I guess I should go something more traditional like?
> 
>   https://github.com/adam900710/linux.git subpage_delalloc

Thanks. We've fixed the bot to recognize the github links in both of
above styles.

Best Regards,
Yujie

