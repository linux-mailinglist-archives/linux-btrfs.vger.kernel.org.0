Return-Path: <linux-btrfs+bounces-4779-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD93A8BD28B
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 May 2024 18:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D112D1C21F56
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 May 2024 16:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E920B15665A;
	Mon,  6 May 2024 16:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b1IBJpPo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AAE155A4F;
	Mon,  6 May 2024 16:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715012541; cv=fail; b=XkeMUgL4/MzE8sgrAokfNnH86U0STXLilvJy6s7d1EldiwCcE25TvTZRFoOokNf3KOMRJdeIxtPJHQ72WIMlmo8ON1ff2amigIsDf/phAhejpBmW59F23ZwfQwJpa1XydU0d+UwNQzj+N7a6CMulBxKGVVlCldQCfpngwbnwXGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715012541; c=relaxed/simple;
	bh=lEC7XDP3YUivlQ9SpmlCWWNRbhym7f6CanKN1Ts0ORI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hscIw8XdyB/HpATrqSsfjyuqhkiZd1PuxrjhAypX5A0jvTCuWnW/a+lCZVVSZWt4gYcC1Pp35hEIhMfto2sHcYW6rluNG7cQ6+wjDJ1fftFoToJb1+raMwTrVjpC0Spn9bfbM0CLeLqU9LFi41ZkFBphlzVFNwqeFt0xo1Zq1Lk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b1IBJpPo; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715012540; x=1746548540;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=lEC7XDP3YUivlQ9SpmlCWWNRbhym7f6CanKN1Ts0ORI=;
  b=b1IBJpPocvCKyWxQe02BlPfinBa2nPPzwwx2TXcq/Yh1VZpWQzmxaYzt
   4hLkRxwPX/5Xl1CLoO+XPl5Qr1uAIvxpVKxojujHyKUDnpafjD3lR2U13
   c+TYl6KMiwgRjMpGpEeurKWKwoJC0smDBi/r61tdCaBDjJ9zJED9Std/N
   C3zlZ7q19n7RqCIQtdORDZwOSsnh6urq+c7of3ukfhnAiMjXN3Ue7pEVY
   w5Yg56g5O7BjKqqp9vQ8/MD798aoC9qlR9FjMqsJl7rEZuPr0tVFukc+H
   5EkNtEM2vUm5qrzuuy1ltYEfZ0R8k7z18D5m3b2uIx58XERZIqdmOf4fP
   A==;
X-CSE-ConnectionGUID: 92xhuhFhTkmQxizhiZ2TZQ==
X-CSE-MsgGUID: 3g0ezANkT9+YG5fpHZADcA==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="11306276"
X-IronPort-AV: E=Sophos;i="6.07,258,1708416000"; 
   d="scan'208";a="11306276"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 09:22:20 -0700
X-CSE-ConnectionGUID: /p6sf1k7Q0Wyo9yNVBpBkA==
X-CSE-MsgGUID: etnZUyafTf6Y+A3RZ9evrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,258,1708416000"; 
   d="scan'208";a="65675552"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 May 2024 09:22:18 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 6 May 2024 09:22:18 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 6 May 2024 09:22:18 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 6 May 2024 09:22:18 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 6 May 2024 09:22:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aZAzADgLeAA0HAl1z6iHng2vbc/aPhmrHwtD2OWFKcVS9SvSzQA2fyQgaZZoe8jFsjrIeZgG7KTpYYKovO+cSNsPv1M64s+tZREzovlolYgENn0hr9b7/lQTQ0nl2YThr38Ofn3uEmrEROovOeH60kcay9yfFfuKyyIk/xUdUf8N/K6NKZb0pu9q7n+dDRhMvoOf9F4gwsCDHJ2z9yuzgybV6xYPWfH4sgPP7SM9WSEqYSXih4NQEk1Ynz5w6YO/vMYV6VWLRtzrBJ91p3qLqraCssJbd0GR/LNAH95WQ7BAK6LDa6fRIB5cSdDL5WCoxtCGvfjc5n1EnDgD8VG1ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=60GSO+1Z+b+yT94aCbq0eGLeoeqlkhUQgqmcUayJONo=;
 b=J3jRu3WAx7PAXejO6e3leI7Hq0Jn83kImg0V+DMhHatr/ODEYRhfMUzqsnlP0vDqvbQg7HLFHBUoBegpQPOqq53dauFx7Pmkl/HOn+G8HB5pk/9iKw47nSUeLEJSut5xNZRjZFSe3WNOVH2MOztTEUb3iLEEKGa0RgcMyIp49qBWRgpqFIo0iKyzUXYsWoI+igjLdaLiSRetvdIFXshubMfZeola2/qo2gu0ScFrXql/Hr8Cx1vUceZRZkup9zg60R/fKpFqLflii6iv+g6TQRndyp8DTt8rI79H5XEEPUlS0SDWDVkzYmVsFBXv/5orEW8hVJVaL6rQmP2HrEW3NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB6324.namprd11.prod.outlook.com (2603:10b6:208:388::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 16:22:15 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 16:22:14 +0000
Date: Mon, 6 May 2024 09:22:11 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Ira Weiny <ira.weiny@intel.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Navneet
 Singh" <navneet.singh@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-btrfs@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 06/26] cxl/port: Add Dynamic Capacity mode support to
 endpoint decoders
Message-ID: <663903b35b66e_2e2d22945a@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <20240324-dcd-type2-upstream-v1-6-b7b00d623625@intel.com>
 <20240404093201.00004f33@Huawei.com>
 <661065683552f_e9f9f2946@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <661065683552f_e9f9f2946@iweiny-mobl.notmuch>
X-ClientProxiedBy: MW4PR03CA0217.namprd03.prod.outlook.com
 (2603:10b6:303:b9::12) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB6324:EE_
X-MS-Office365-Filtering-Correlation-Id: c8b47720-c842-4f13-3dca-08dc6de8b08f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ojNj9H70rTjpMLi60Ta74kYqI7WRx8wJniWNWhOdqvEFvOpM7omsrgb/oOpK?=
 =?us-ascii?Q?wDs3JXhKkj7d2g9quYb93Q5rAoL3nNv1Gj2vF0IHezo4hHX6O+m68TI3pyAV?=
 =?us-ascii?Q?xt4TXgG8dCCkyKYCIPDPzKwZNAQOKovqYoRQG9v+5ND7qWq1hv2Ne/Rnc8r5?=
 =?us-ascii?Q?mF91LFRTAHhqot84TrE1ZE4Opdyn3FvF3NI8ICLUOqHDk+AOK1LGbpK064H2?=
 =?us-ascii?Q?wJJcdWLDyMywkHk01coPAJvCp7GzvUAcypdSmZMXajq7nOz2ZBZQ0eS2pYPL?=
 =?us-ascii?Q?+DneYFdBxtW6Qfxs9G2Wlm5NxAnP5LoakUr0+4sag0Xt7QEuyxtZ88UwSHEh?=
 =?us-ascii?Q?QA3gDTJupUdgT3Vgngq4FIT/7Jb+GiRDEpohTq56BzM6b2Xz7kUuIRNKBtrw?=
 =?us-ascii?Q?PUgkZd8+aXMA2sNiNQ2bk1Dup//TJNdi4hit0a3bO9hXwOp5qYj5R1c1xpBd?=
 =?us-ascii?Q?BEK/yrUCDguus4wbeypt8gTGneSMintK0R1kY+eZ5RfrB5KBItv9h+YNFVgZ?=
 =?us-ascii?Q?ehKvjC8wzD2sFu4QY4mbvbxqiOag5nijq56eD+UmWrcupNdes+r9Lbc0txES?=
 =?us-ascii?Q?SlaXA7+sys9MgeiiIeLCAkqzssIP/BWmtYcluE/Nt61EIiDCWTrY07Y1Z3Sv?=
 =?us-ascii?Q?25Z3+7FvtH0Dl5nJ/BuWdsMkIX4ULFInfsrW+h5vZJrnAz7EA+gnJt92cl/Q?=
 =?us-ascii?Q?LqiVOc+K062CUThb/2fYW3QrwvU+jp97esOq2B9J0RHZRO+YpvToPgR4eZ2H?=
 =?us-ascii?Q?nO0o99qKHDT+nQO+49Nm2OsLPOjMYTSk2kVFtQ+8uK2KJD3Z4vTaWMuXfgeq?=
 =?us-ascii?Q?SwMAZtBv7Kb9bgAHjrqp3Wu94sQs80bJs7dCdFRidNu3npmJza2zeUeA6ZE4?=
 =?us-ascii?Q?QCa+GOYS6UtZMZp6w8Q82QGWV3ceH2LfXdSNkOUtkIGWL+/oS15yjQfMeTPl?=
 =?us-ascii?Q?7Lg46D4sGxm7dlivSeXMo0gKr6+j9T+nsRpirZU5pS7oZ2ZUpiKSOUiw0Eoy?=
 =?us-ascii?Q?B7+z0OWErLQ8n/gyA6xOy8A16YWs5Ai3B2JGP9Rgw84Hvm9eecnfbXC1gJxY?=
 =?us-ascii?Q?WtKvakpVqkThOFr+8WemRTOR15CZ9cA2ziy1LVLDi8b13fGuZSuPJpDFBXrr?=
 =?us-ascii?Q?Gdoxdpqin/OZw1DaLKYtLqQLW+mnSEODWRhuhpClnGqXaQIUE/gk3lCy7fTk?=
 =?us-ascii?Q?E5+zqESK2Pu10vaRAiX0KPecgG1j+o5pFQn0Y0ABndkS7Nlc9W9W0FKPWb2+?=
 =?us-ascii?Q?8hfRf8hKvxVzEBDv9bM4ems05PyLbAb/QDpPJcZ78g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vM7arkHwqtqPbIxyVjIbqYo4O022Ux5PCLppDEXIeCzMJnDhthdJgfHVEI2j?=
 =?us-ascii?Q?oBVLNANSwlziOyXZ4Ff7rqoKvq/04TzTSn4nxwPRDVssmPqLxxQveI5iCeDS?=
 =?us-ascii?Q?3+SL6Uy0N3CmABN162hMrJq4nnBzkxX/S8BZq/RnZJr+stwbUGONneMbp9eb?=
 =?us-ascii?Q?otmi3z5om97lQBPREoYiDuw18J/OiBv7s72SHpZS32yeTiRyFYlQd25XRvsk?=
 =?us-ascii?Q?txNTzM9UfiDgFb3VJNRb78X7zfy86HJydJZv5ajCPqFgep+2/rLcikEVOIsj?=
 =?us-ascii?Q?hFXieg5b81khtuTalGRCUVdcmVX8f+Yw3RsalhEEkGNOr1/Eya10wmdbSHh1?=
 =?us-ascii?Q?3hBPL6yUcqP06sGcaOuiH8RYeRuDZcQuDdMmb4tC3F+PuDu4xYyjxdwnyBQ4?=
 =?us-ascii?Q?k/X1G4mhAIzwkEOP3MuGouVhd6hP7ixfdSWSLql04FU74yAL0X3soTorwjN5?=
 =?us-ascii?Q?w6/R7k90UhWoezOIISAGl+gBJCBS1rDWT14vzVmZH7XYPQix+7RyC19qWlNf?=
 =?us-ascii?Q?owtZ0HXhHx5EVqobuRBS/413Sm5I3I3KXTjSFrnVYhMaxjR6Nw/syRCD1pgh?=
 =?us-ascii?Q?qIhzMpBXpBVilZhgMlo+vs5aYJMaYRVaGZ8/mGt5JD7gGDNAkid7vJayrCWZ?=
 =?us-ascii?Q?2lHAnWPsOfljTYxK/ljeUV57apqkSFaS1/3kcoYohWPYOudNr5YRMuPM1hUb?=
 =?us-ascii?Q?fQkyhVpQO7XMTjyY6TT+KX58T5j0wG46hk8C4sDNw9jeBz+sp/IA0diKNyNS?=
 =?us-ascii?Q?it1DbmekPQ9RBZ/q+w7++x38XjqwPtRTFkJS8Lg6erCEhFp6WlUKLxOlJ6yo?=
 =?us-ascii?Q?VJA5NRtV/agDcrbhFl8/lCGkMHz4E9/+RanWXDivPb1kdtWiu19Lj25fLE92?=
 =?us-ascii?Q?CcMojWGXM7WV583OsVQo6ugHsj9CRS4z+/xBQPiaQz34CCgoyd7iiSgUGLub?=
 =?us-ascii?Q?18DgTjK82tw84Bf7uNz8iO7DRjaHFxvs0aTT/PbhU6MoQmkQquqiF3w7V47e?=
 =?us-ascii?Q?Fdjm921rJ1V3Yqe2/DQZ/Vz/vj7dtprAoGP2CXueGrDj4OA5o8aOR4XV3CET?=
 =?us-ascii?Q?fd5H4qAFXYNKJd/5Ani+i3UZYvZs9RKi6S4AEVjDRLh7D8vNYEwh07Dhcu3D?=
 =?us-ascii?Q?ILXUbK2jkhhMdN3eMYAq31ekpVovKr8auMhA78u8cBn8o06103ThenD+Q6TC?=
 =?us-ascii?Q?J4lIrqHtlA1bsY7WZRG1KLaiPeVdJ5eBVThrun+r0oyhcgCtSYIMKg7FQOJe?=
 =?us-ascii?Q?q66yc9h/NdBhUF/47UuU43EkWEe01UhjTChs8lOUM794IRFli73pGgDpNCpH?=
 =?us-ascii?Q?uDmFFo7MPbf0M2w/oKJIzw6LyFHInh2ozplPXaONAs1zJSqM3PCZq+27tzTd?=
 =?us-ascii?Q?K6bCS6ZkL0jKL/VQsvdCqUgTSDHipRVff0FWooAFitNDwg7KVZM1BaHOTdR6?=
 =?us-ascii?Q?eHcCml7fbGcCMkDygT3ZMN0A6rXqTVOzWG2O0DKy957y/1cWDNU8Yc11jZB1?=
 =?us-ascii?Q?7FIfYmiFAgWfEBUbys8Z67Lm+xEXXhwGVtWGaQlovL0ZCQ4vEgflThL0lohj?=
 =?us-ascii?Q?Jjz3+Dot1YFnHFo2OECymi/5fPhz6HCne6fw6POavr6jPjrw7qbzDBd/KW2C?=
 =?us-ascii?Q?1Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c8b47720-c842-4f13-3dca-08dc6de8b08f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 16:22:14.4443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F8/OaRi9PMbRFxb/r+4hLP1GUl8v/QuynQZKEHE5BF3++g947D1aCr5xb1BI0PhR7zTMXqqqIg68H4fed+H+O31qrxONBCcJPmGDth7zNuk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6324
X-OriginatorOrg: intel.com

Ira Weiny wrote:
[..]
> > > +	case CXL_DECODER_DC0 ... CXL_DECODER_DC7:
> > > +		rc = dc_mode_to_region_index(mode);
> > > +		if (rc < 0)
> > > +			return rc;
> > 
> > Can't fail, so you could not bother checking..  Seems very unlikely
> > that function will gain other error cases in the future.
> 
> Sure, done.

Can dc_mode_to_region_index() be dropped altogether? Is there any
scenario where dc_mode_to_region_index() is really handling an anonymous
@mode argument? I.e. just replace all dc_mode_to_region_index() with
"mode - CXL_DECODER_DC0"?

