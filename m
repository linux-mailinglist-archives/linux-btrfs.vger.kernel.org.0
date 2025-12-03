Return-Path: <linux-btrfs+bounces-19477-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9542C9EACA
	for <lists+linux-btrfs@lfdr.de>; Wed, 03 Dec 2025 11:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B40073A1298
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Dec 2025 10:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17FB2E92AF;
	Wed,  3 Dec 2025 10:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YVsBsKxn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95816213254;
	Wed,  3 Dec 2025 10:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764757014; cv=fail; b=U7JcPS9N7dfqnkU6XczCLP9hG374m28h1G9o+JMpndPnBD7hwosuxECbzsD9vC31DxxeRKp3W/4QDud4bveoEGAYXskfYEVqZS03scGE9PrBJeSpYD1ucyeLoG4SA5uCH/4bgUPVy59yyn7Cz1ShU8URABNhouJ+wFj1W9EkBdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764757014; c=relaxed/simple;
	bh=UNUtwEc+5Ohe0fD9vJxh3UTWPN3GfU6jZHR+WxrbcNg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EMk3clU6Y99tnP3PqwtFhPWU29Nfpw48lXXfia21qZRmRnS1VdZa/vDPRivX9wYvx4KlGr+MbgC4yLO1Ku6xoyhQeCd8G34kte8TQItBzeqs17psih/7AK8GxIeh6OxlOp4n9TfVbiuyxU5N/4lnp+YXUBp+SUw3A3gmpyiAEEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YVsBsKxn; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764757013; x=1796293013;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=UNUtwEc+5Ohe0fD9vJxh3UTWPN3GfU6jZHR+WxrbcNg=;
  b=YVsBsKxn9yRPegK3FT4v2Ln9CAQBYjgjHZ/DrUFN697pBK0IuggngdN5
   mEEB+79fT1KaVUtW6UbBa6NkVKjyhGnuoUiMB+NJPqkDeeBvp6EYOCft0
   Vr963sccMRLBQDyCUeJ4JE3buuNrAMCNj3q84oXF2W4SVRMrWuZehk7GV
   HegR9AjaKY0ArE6Dpy72F/XDxaED6lRw+M3ZLKkFwv+s2XSx8tKFpJQK7
   TMOg1yvVrK4rIjZ7msnBZfclNWdKeQN28uVcI9XVHA55Fup7ODPLdZqyV
   312phS7koT/xeWSjbfnoADEvv2c2NbHsoRjqbjyHDRRXLJHVLYR1A0F6e
   A==;
X-CSE-ConnectionGUID: 0k+EH+uaQhGkmUhhYlUz6A==
X-CSE-MsgGUID: 4eNiC6ohSe6wR+HJHsFuaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="54294631"
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; 
   d="scan'208";a="54294631"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 02:16:49 -0800
X-CSE-ConnectionGUID: z0wJUwSlTKWHbhTLFl9TmA==
X-CSE-MsgGUID: WcThD9DcREiuO2W5JUFvGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; 
   d="scan'208";a="195430473"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 02:16:45 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 3 Dec 2025 02:16:41 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 3 Dec 2025 02:16:41 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.23) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 3 Dec 2025 02:16:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J6/5fg+fmKehLKbAywo4tRDo/mmgSA2e33qQb2TXSOA4+KRrVp1R5mdycZlTRf9uq2wy8TTiDFZRkMwGSK5aCy4G9Ez0lFaCIgyltIBYe/4i/j5Q14cuVXyjuhnzrACdllr8URpB8LrbYQt92DFyBjos8toOVvxVsQH3eVrGvolzYl2kwwWLCSGKCPkAfm06Ts4CgVXdBIQ54VzghzhVcsLXYgbcNcrjmYoJwRQy2PML8hyaVj8s00mLcKI+pxuhtZXRlUFT2VOElTcNt/qSY8yl6CpgGPO+l8WKOUbKZSeiquDPAS1ZPerfUNmOqxnvcegmXOzDZmQjcMLMPGVJyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F/6Sf4fW7c+b/tH0dWjF2xtUfgdTvmPJJcqECwaBbLQ=;
 b=Vjo+9f0dQaWcDrevE7DGdP1VPRsKT3mCfqPW4M/HM5EGDDvmmsgD4/SlxuDZ7/6EI+Ej7x7ETFLSxqkHni/YZ4vkbP+wuYKg/W9Q9HlNNdfAY95imM+hXaMWZLyziIXY7fUtuaTyKgCBFdPV5/E0gUA6MzZFMD5eWaowd5xxseRCCoWNBFK/Z6RYi+VLXb5utX8Og4PTI6TQbzFKaeEjk12LROK3OQ6RdyJiM1+4O8Dcnc305ODrbL5QMmc/1BdaFQo6UvqvAlq6YbrLM13nvEmYj8kTLvtZBT35DSOiFPYQmEm7fsnBy6SdIOspVPGJR2tUQ6R0ZfWxlrkdpiohxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB6374.namprd11.prod.outlook.com (2603:10b6:8:ca::8) by
 DS7PR11MB6040.namprd11.prod.outlook.com (2603:10b6:8:77::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.9; Wed, 3 Dec 2025 10:16:33 +0000
Received: from DS0PR11MB6374.namprd11.prod.outlook.com
 ([fe80::15ef:b5be:851f:52b8]) by DS0PR11MB6374.namprd11.prod.outlook.com
 ([fe80::15ef:b5be:851f:52b8%7]) with mapi id 15.20.9366.012; Wed, 3 Dec 2025
 10:16:33 +0000
Date: Wed, 3 Dec 2025 10:15:29 +0000
From: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To: Christoph Hellwig <hch@infradead.org>
CC: Jani Partanen <jiipee@sotapeli.fi>, <clm@fb.com>, <dsterba@suse.com>,
	<terrelln@fb.com>, <herbert@gondor.apana.org.au>,
	<linux-btrfs@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
	<qat-linux@intel.com>, <cyan@meta.com>, <brian.will@intel.com>,
	<weigang.li@intel.com>, <senozhatsky@chromium.org>
Subject: Re: [RFC PATCH 00/16] btrfs: offload compression to hardware
 accelerators
Message-ID: <aTANwYrQi5MwRyUQ@gcabiddu-mobl.ger.corp.intel.com>
References: <20251128191531.1703018-1-giovanni.cabiddu@intel.com>
 <aS6a_ae64D4MvBpW@infradead.org>
 <8d3e44b0-23d8-4493-8e7e-33bbe1d904ef@sotapeli.fi>
 <aS_f9axsi0QmmhiL@infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aS_f9axsi0QmmhiL@infradead.org>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
X-ClientProxiedBy: DUZP191CA0037.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f8::9) To CY5PR11MB6366.namprd11.prod.outlook.com
 (2603:10b6:930:3a::8)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6374:EE_|DS7PR11MB6040:EE_
X-MS-Office365-Filtering-Correlation-Id: c9d2e166-9975-46c6-cea9-08de3254eaaa
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7LGebMLwQ4bNvF3XESmGMClZVq6pleFEZJczJdUiaGDVS4Q1Q35TOcqPhcXR?=
 =?us-ascii?Q?Ujg3aw6OTSMx534gNFcV5bKibFh2wki8AIWscMO7klQdonJKk/bbLNm88J3c?=
 =?us-ascii?Q?VOKvcQ4aKLy4Oy9RZUitgkDgG17z4hmkrslgz9l680D2H/uYvoPChhNluYD+?=
 =?us-ascii?Q?NPX4E9BifDKfkY+2HvCIP4ilDyuGswN31GyLAfRoazSXoUG02tpYBb+v2Gan?=
 =?us-ascii?Q?xJtHD+jOIb2kepYptUs/e21l3DaM79nP9BASvVFjFoqzCgq8G/cbtrDT49QX?=
 =?us-ascii?Q?3bdY1vw4+xVtkifXAiaoKv37GzztCO5LHjCKsx9IidU2JGfnsOHVfrvIbutC?=
 =?us-ascii?Q?EoECPJQGnFhoslHn5RtUSeB5LNmXpv1/yRXTjKMIkDvByfL/qhkwPlkz7Wci?=
 =?us-ascii?Q?ZRwpz5Q+C7QvEr6AqJ1B0pbB1jdqaYnJWbGYeDzcGc8lKM2BFLe6mO3mG6w8?=
 =?us-ascii?Q?unVudwzeFP8I95iEzVT47VBTspgYdhDMtmBVWXLLWn2+yTFVvbsMLCFlPSKJ?=
 =?us-ascii?Q?0Go/TRt+ximKUnBFCgL52Ov0Gh+onQWrMbBIYFkwe9D7E9ddoJjIGs48Ti7+?=
 =?us-ascii?Q?Nqew+zZsUdDEslAk5W54BsFEyDOpqt0VkcdbxdxAQDNRZluC5o+jvGz7CCC3?=
 =?us-ascii?Q?/zx1IbVz3GAkuEJWWXHRdQu37fSVR1hcUFIvct1CTAVE5D5f8xxICUSmXomX?=
 =?us-ascii?Q?46t0EmOKPRIY2mPXli0MUoH/8hwjQbRTZjJjxY7kj7O8tC8hZq3J9G/UZiMO?=
 =?us-ascii?Q?neioQdXxzNUnq5gZ4jNY9XQT5QpSJBoi7m98D4/Up78RNmGt1hNk1Mownv5k?=
 =?us-ascii?Q?QXbacsZT5uThrrj9ZbmC8lPItZcO6865HF4aokl3q0eUQVv9ua0AA3aTgvOo?=
 =?us-ascii?Q?8HuGTfZZZTuhfd5UrDGK6H3dvry5/Uwy/og2wnAxuWvC0gSgcaq8lmAN0C+/?=
 =?us-ascii?Q?m5Ww7huEcVM+uZRxWPXRVMory8v8VhnikvoFR+tuU2lixalAKZQGe64BZxbV?=
 =?us-ascii?Q?M2t9aozEbL42T3aAY7m7iPwnc0HrL8yHeRklto5zUtb5nkGqQ0ORyisQxpv8?=
 =?us-ascii?Q?gnVt6uaVIwUz7H4XHfriF46VXVr6GzoW6ZPZP9Ar3mEik6EKrNnHq05Oy5Js?=
 =?us-ascii?Q?6OlyAKV3JfTonJ0ERg+FAv3jiNPrMg+Rsti8fWLDF4+pxbaVT5bq22qZcXc1?=
 =?us-ascii?Q?ue7xWon7lvWvGAXAjM4J0FWv/4qjV3/vT7pUmTliXCZK6NBhq+l8L0isSrMT?=
 =?us-ascii?Q?1rg40oxaQiXFFIe/Rz7iWYVu23qUfkJ6zHa9QBik9EsxR5BX1ChS6tqHFrol?=
 =?us-ascii?Q?NKlIBnZZbsWMxJKV2FjAlUpC7r5QNQhTYW6rAyFyt8M3n5gE/E03PO6NqXY1?=
 =?us-ascii?Q?WcebRKdl1ypDL/5aN2/t09wJFSpxD9TzbhcOP+06NUDBebuIJ5A9vmZg+Dse?=
 =?us-ascii?Q?bXM1GHllMB7wqcXTwB0V67FE8EmqbmV6nVwp8rSMozGBW9ZCJZ8Q+g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6374.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dnnDj80DrWdX16zprkEq9PJQtP+PXg6+TBPbIIb1vziyn+Oiprh9H0SIlM5L?=
 =?us-ascii?Q?m6s59tTO1cmlrgwTeVFknRBqMFZStxEuaMgxR0/4byQ7dKrWGrC9FfUSk0HT?=
 =?us-ascii?Q?gH3zAb4TSu9KdxZ3PTkDB0PW1QZM9T6iHi4MHGDE5VusDlstlb/XirR8UYpy?=
 =?us-ascii?Q?8qpxLm/V4u6X+uvlk7yCjYpRjd1muAhif9QVMHr+RfedjGmwzRgn0VG9RGR6?=
 =?us-ascii?Q?7//DscetGMKR9TXkr4d2C2/yHI4E5z2N5b1k+gTCkZmsC0GXokbL3Q3Nj67x?=
 =?us-ascii?Q?OZGWNhJZUetdVWzI5vPj3wVA5YXaMQXqlrXzBFFJAQEG4EGU8jnDN6x7x6Gr?=
 =?us-ascii?Q?3e/O8shla/MgHoVluq9qmrrhRn8frUQhXQDDJKc9tclnsklNpKDZRWjMFeMI?=
 =?us-ascii?Q?0xOa4JcTYpTHdu570JbsdS0bOwWDwZ2LPj00gp8Kgal5iAPYse10I/5smTU3?=
 =?us-ascii?Q?dMsBUBQQ/G2+6aj4zkj2WQ+7JXAy1FjU7XwPiAtkXai+3Gu+K16MMH2Pulx3?=
 =?us-ascii?Q?6AmnP5Jnc6vvXFH+ePCElL5ordgK7CDfsmUAlkPcnyiSrDR4qxTZTXGKsIEF?=
 =?us-ascii?Q?F/48GAddPHTOWohuRStrRJL66uWjKmSTgxDTAorpc8ThV+KNu17bTVC4/6Dz?=
 =?us-ascii?Q?+A6dj842EJ6Z5nu1894ScxgR5TxOtLI1MZ9EumJMXFq8MrdesICrMyK6pga8?=
 =?us-ascii?Q?dYjItWN/LgUajrFE3c4FPQcJ0tkmm+Pkk8Tqr0QOGJ1naVS0mfjkkhFPtflL?=
 =?us-ascii?Q?u75XViM5Q49lov6J4IdRvSsRr1+NkMh196+z+0+71JUvL39kPuftdRfRflFw?=
 =?us-ascii?Q?uX0mQmLG2nupXcvhZEMZRtkpCtTWt5ToMiQwceujRnOUk2ni9hz4EjFt8viK?=
 =?us-ascii?Q?0rpgEVIOVxxka6ZB1zNaBYn4NGMRhMgHRjvc1/GVkj72TCOJoQmyMlTrG0St?=
 =?us-ascii?Q?sdwqmdi7K4YVJKaW+HOo4XCzjVnAHmI+HlK4HKckKnih6dKcBMe1Dx/b1uOr?=
 =?us-ascii?Q?NZJE1RRTZQZhAhifK3S9i2DvtipioN5WteYaqTPrgPlYvi1oFMmkgxyOIqYp?=
 =?us-ascii?Q?M8Fd7KsinVf1dqNtNd6a46sN7lXKko5MhqGL1BDocuTVORTAJKS8uKtrkBbV?=
 =?us-ascii?Q?uGGvQZx12wXcvxjRny+t+9oHo1SoOnf7HSaaoTR1xK+uxZpfW7+6TeQgyDMd?=
 =?us-ascii?Q?BrpVYnLWSQoJTjfb3GU8hjZUJS2XqnaaHRB8ODtidI1Eu1gbZzVVhqxgDaIl?=
 =?us-ascii?Q?bHyiwZBHgPngwegflV8FT1V4sIoxn+0nkkE+XVf+xCCgoILPQ6yj3qauKFCn?=
 =?us-ascii?Q?Kaf35lX5lYQS3ZBp727I9bdyvDBzO2GyKVvG7XDMcDzCaeX/07SgHVarxFO8?=
 =?us-ascii?Q?Q2/S49LB52mgqIKF55sbDqfs/yzEKsz98axGm3div6EFHTiu3YV+GeYPN5vr?=
 =?us-ascii?Q?t94stL+vIVT3mByjBh5wdOw+lzAvvcIHkQvcXdbGnGHjAcBwptaJLhrXX+VJ?=
 =?us-ascii?Q?ZHPEYohobfC3ORl39E5XUUrBK2hkvr+XKNBV/RBY5iTlCPEb0zf7ycgMFe8I?=
 =?us-ascii?Q?OesPpC4OCmUnovLVnGvCEjwSth5Qb6NBWCjSPh/6YeEfxR2kHWc7jmHiRU/J?=
 =?us-ascii?Q?bg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c9d2e166-9975-46c6-cea9-08de3254eaaa
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 10:16:33.2008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fb8dby02lZDgxn9mSuoWxNvzCiu7JXCJI/Uno+VEPF2n3gV1bkl9qneSmp3TnckxCrMwestNKXu+0XetRb+w9soMUkfD5D4WX6OmfduCjIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6040
X-OriginatorOrg: intel.com

Apologies, I should have included you in the TO list on my earlier reply
to Jani:
https://lore.kernel.org/all/aS8fo0h32Yp+ZSPV@gcabiddu-mobl.ger.corp.intel.com/

On Tue, Dec 02, 2025 at 11:00:05PM -0800, Christoph Hellwig wrote:
> On Tue, Dec 02, 2025 at 05:46:29PM +0200, Jani Partanen wrote:
> > 
> > On 02/12/2025 9.53, Christoph Hellwig wrote:
> > > On Fri, Nov 28, 2025 at 07:04:48PM +0000, Giovanni Cabiddu wrote:
> > > > +---------------------------+---------+---------+---------+---------+
> > > > |                           | QAT-L9  | ZSTD-L3 | ZLIB-L3 | LZO-L1  |
> > > > +---------------------------+---------+---------+---------+---------+
> > > > | Disk Write TPUT (GiB/s)   | 6.5     | 5.2     | 2.2     | 6.5     |
> > > > +---------------------------+---------+---------+---------+---------+
> > > > | CPU utils %age @208 cores | 4.56%   | 15.67%  | 12.79%  | 19.85%  |
> > > > +---------------------------+---------+---------+---------+---------+
> > > > | Compression Ratio         | 34%     | 35%     | 37%     | 58%     |
> > > > +---------------------------+---------+---------+---------+---------+
> > > Is it just me, or do the numbers not look all that great at least
> > > when comparing to ZSTD-L3 and LZO-L1?  What are the decompression
> > > numbers?
> > > 
> > 
> > What makes you think so?
> 
> Well, if you compared QAT-L9 to LZO-L1 specifically:
> 
>  - yes, cpu usage is reduced to a quarter
>  - disk performance is the same
>  - the compression ratio is much, much worse
The compression ratio with QAT-ZLIB-L9 is close to SW-ZSTD-L3 (lower is better).

Here is an updated version of the table for clarity:
 +---------------------------+-------------+-----------+-----------+-----------+
 |                           | QAT-ZLIB-L9 | ZSTD-L3   | ZLIB-L3   | LZO-L1    |
 +---------------------------+-------------+-----------+-----------+-----------+
 | Disk Write TPUT (GiB/s)   | 6.5         | 5.2       | 2.2       | 6.5       |
 | (higher is better)        |             |           |           |           |
 +---------------------------+-------------+-----------+-----------+-----------+
 | CPU utils %age @208 cores | 4.56%       | 15.67%    | 12.79%    | 19.85%    |
 | (lower is better)         | ~9 cores    | ~33 cores | ~27 cores | ~41 cores |
 +---------------------------+-------------+-----------+-----------+-----------+
 | Compression Ratio         | 34%         | 35%       | 37%       | 58%       |
 | (lower is better)         |             |           |           |           |
 +---------------------------+-------------+-----------+-----------+-----------+

> 
> and we don't know anything about the decompression speed.
I'll share the decompression benchmarks in a future revision once they
pass internal approval.

> All the while you significantly complicate the code.
The changes in BTRFS are about 800 LOC and the core logic is straightforward:
convert folios to scatterlists and invoke the acomp APIs for offloading
compression/decompression.

The majority of the code is in the QAT driver to enable the algorithms.

Regards,

-- 
Giovanni

