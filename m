Return-Path: <linux-btrfs+bounces-4884-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DEC18C1DB7
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 May 2024 07:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D7C5B22233
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 May 2024 05:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC02152790;
	Fri, 10 May 2024 05:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gmMf3YzQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F98515217A;
	Fri, 10 May 2024 05:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715319115; cv=fail; b=T8cNkeTYaE1lnVMZxEtct31O0ZlUguu6zM+7yHJu+3J/6lZJq9jSk6qIPuJCPX68R4lWGtQqepQVpWV8J6YWpcuaIjQeVXxuxgZUWnKRkqTYBz+HoDXuzRQ8dnCSEKRlk7GsROyH7dHWWs9M0yuR4QU2B8im6MbuAxUcH9vw9uI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715319115; c=relaxed/simple;
	bh=YSTkSYy2QaEkgerWvbJ9xxMB2UAejWtGgNLgRusLgTQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WwPmiHGX3+4hdEibKvAX2QT9g6PVBWRORi4NYMriOP8hilg0w7hCB/aU8A0rfENJKDejxCKnat+fjR1QBHP3WG1zii+ewWbqKPnU0uri7Z61xfA+Rb/I6AY8CTZLwQZRG3grm6GvOZCOOeODoDgA1Sz/qE5kzse0d66p7bz2yBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gmMf3YzQ; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715319115; x=1746855115;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=YSTkSYy2QaEkgerWvbJ9xxMB2UAejWtGgNLgRusLgTQ=;
  b=gmMf3YzQd7qBEUZ0QWFViXjFNInndvy1l9s+IAMrdWQuv5TikDJvRZ0q
   mhZJV5Tf2V50UkqITko02k4sBlZdSiTPMSgB/rgl8ySM3o0M1jEWfcZdD
   1/hebRlaFlwVOOayfOhkdv/KYQO8yAZQdaIMhVY7kW4tzPGa0ye6lZyYw
   mGG9of8Lc6O1EIOLKugSNQ+LN4GSLjpPatbdKwhrEFsWegMQKCVxc+WiE
   HwV+R8pPJrnzJ5xleR1SFyGx7QYR0iHDx3vRElRzky0ei0T74463Uj+G0
   il57qIHQT4R7cQmnUg1k5ZAKrcz2XoyEEqilfn3Xp3hwVAJ2pLDBBz9CM
   w==;
X-CSE-ConnectionGUID: 3IVoE6ogSqaD0P02avj2ow==
X-CSE-MsgGUID: AMn49gZmTzCshmc+A4Uckg==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="21878098"
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="21878098"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 22:31:54 -0700
X-CSE-ConnectionGUID: AbRs7/AdQeudG2x57+xCSw==
X-CSE-MsgGUID: /eHhCgglQ+O5c7Ayna9xBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="33926873"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 May 2024 22:31:53 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 9 May 2024 22:31:52 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 9 May 2024 22:31:52 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 9 May 2024 22:31:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QYTEzvHBIgwtpwvqgjRsmKuuCrmRQB1pZPGUxOt/EV7mplBI7sfbooJz2IzhEYVs//rH5eOx9t7jzlGAjmVjMq2blAlhGs6maa2uo4I39K7fAQNZcjcWS69AnBVJTn71+KEdBoVkJFas4UCMAVKm6i7jlYcbqWGja5HJnItxd9T7/wG0INxZKS6vETapobhw1LLP8MdNb5Orad5xBGmuYamaFPl9EFGcUT5N+pyZP6VVKDoLUN6Z79Uv77Mwvn6gq0XeOqGKyWP9cvkCjaQ7/2mVf0FCGoTUeG19c8qgMdqYLzUjHloqOP0HItVQEX42s74l/Z7AK34Ih0jrGRxQkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jvnoU6/oVE8BfQV2iAWlGFQ2mbLHv98gfLsWPKcBQx0=;
 b=PTih1kEZI61aRjPQwIkOT85HGT44An8vls5HydldVC3tkM5TQCqB9SFWZpaqyxPEcbwAcpPSHAPKRMMXwftX8I+PmXMZ817LmGAX3m0FkSf8PcugDafgIQ5S5q6gYW8usnPpw7CBvm/RrgSszXH+Bjhh5ChueTJLSeJ8gbY0w3XdohujrMP/zul9vmH9qaDIy+epwJC0N/iM36mBrADFPBcnj7J401y1OjrkIbYP8Ey9iU3FbMavrb5qDNcc2/moKfhFcIhciJVIc46NAfr4RGj1cHmXw4oxfmQXLG1KOeLodEwI+JT7OuyO+dR/xT3KcjL5QBvNdEBxigpbEUVwNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by IA0PR11MB7933.namprd11.prod.outlook.com (2603:10b6:208:407::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 05:31:50 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%4]) with mapi id 15.20.7544.048; Fri, 10 May 2024
 05:31:50 +0000
Date: Thu, 9 May 2024 22:31:39 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Navneet
 Singh" <navneet.singh@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-btrfs@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 06/26] cxl/port: Add Dynamic Capacity mode support to
 endpoint decoders
Message-ID: <663db13b464f8_25b78929486@iweiny-mobl.notmuch>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <20240324-dcd-type2-upstream-v1-6-b7b00d623625@intel.com>
 <20240404093201.00004f33@Huawei.com>
 <661065683552f_e9f9f2946@iweiny-mobl.notmuch>
 <663903b35b66e_2e2d22945a@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <663903b35b66e_2e2d22945a@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-ClientProxiedBy: SJ0PR13CA0110.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::25) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|IA0PR11MB7933:EE_
X-MS-Office365-Filtering-Correlation-Id: 2796a0a1-6f54-4e07-4013-08dc70b27e2a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UjFwvOiwVm57NwY0t3M+4o2RjywW901wbPnxjengmiDh8npgHvtKq955y9hs?=
 =?us-ascii?Q?KPLfnCHmQm+x8G57kaoDV6Tjt5cFbeGaJUh7ntXBqkuYyI1wk1Ky/N7HLpY/?=
 =?us-ascii?Q?c/lDEcm2VI39CCKKNBPRTeNPl+Kdk5/J5AxWVqKCqkHFYDEBo4YXrY1VULYV?=
 =?us-ascii?Q?sPNA/MjUY80+zzFVizb/+6zLhGKPOmGKZhY+uHX78k3fppHsuNPefVL2ctum?=
 =?us-ascii?Q?mB09tAEXtUR+9cOTICNL0kycvQR8hzzZlC1vlYwWSkqIyA7dhrv0f0LIpx99?=
 =?us-ascii?Q?Io2gLsP9Q7QmEds9PGbTkyrXAMX5eJYKlpjbuObXi55Qv44tXES0fd5CIifN?=
 =?us-ascii?Q?CUHn/fO/nMe5tSvr9omi1Zbv5duQ65RAYZ8FFSuz8LnQ0jFTJgDSJ53dyLhY?=
 =?us-ascii?Q?6q4j0coMvL53S5XiU2oBv6PKg4eyNPAaO8F4WI5XF5Pwksb/2h+PvlLeo5+S?=
 =?us-ascii?Q?qxnQyZfGW4ZaG3NqK1R4W/pPLEKtH3g7YBXhkXbolv9biHzCjDVpGM6Skh2e?=
 =?us-ascii?Q?vibpqFSSPIG8c37bGJDjS6YNcRy48rvN2DFILBlEwMfODmK+h3VkYii4+oaR?=
 =?us-ascii?Q?I+zX1P8tugJMtf3nHBAdqKmgNvevnSjIug68J8v8B2Nx4GRJSyVBXodtUkJn?=
 =?us-ascii?Q?LyWK0PqascuUnl7FqbMVLgTmC/I3ejSG/t9ez3l3WCy8nacPrB0Izl5x9yFr?=
 =?us-ascii?Q?JnrOtDI3PDuiyMpANPDvKIR/1QYc2/4A8qJiHXGCohWWUk22lE0XLLa3WbKg?=
 =?us-ascii?Q?CWAb84ehbhym9ZHOCT5yUAvxvED+Bgqz6xGADup6S/lxQNtB/3XrUjW5jKZs?=
 =?us-ascii?Q?firyOfHdllwZRkg9wQyeC9aSAVORrBwAOatHk0BFxub/lEvDSapnUfAjpUZm?=
 =?us-ascii?Q?7kjpDPFAE8nDo8x/nlO7vMM2FIJMoDDCTV4ZEcC59ytciosJymHtvVNtLAqM?=
 =?us-ascii?Q?03Wz/DEZrvt/riVB1GpwVCrBa56SVJL7y2+CzX7wutWqUUKWWMu4synIF3XF?=
 =?us-ascii?Q?MINIm8GZM3zvQQQMACryKy64iX2D18YNWqkRPg6zuWapVYeuh76P5VbCDjfv?=
 =?us-ascii?Q?AoriiuFaewRo4hSA1A90UFNAKDgCNZpvVU/skojmpX8Hag64MHxT1JSh4pz0?=
 =?us-ascii?Q?1UGdpRdVQgJH2oN6nsEI8MRX4o0zJYv5rt7UFHKc3c8hC3lkK0fHlMq+HCV+?=
 =?us-ascii?Q?vFR33m+oNhkE0rXG1bjND2eRyUbuzF3QCDez1JKs7FjNrSauST5tRQuuNJqJ?=
 =?us-ascii?Q?enr23ZtRc+zVeVLxN/5X0vKdKYB17knzUg1ccr4hWA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QW5AN3ycrhhzyOZzGy58iQmV+PmCYB6f5Cgwx+GTiusOcdk8lVNsaxuAFsGM?=
 =?us-ascii?Q?uI0KRiFT3Hzq8AYmuqNqOcFd4jlaDwXohpXgfuxb8DWqMxleqQDYPgmfL8Pk?=
 =?us-ascii?Q?5/Aw9LkIBFEmfuzsVs+3QAM5kWkaxIns8ELwVS4RWKEmoS9g00YUqAiWGJJ7?=
 =?us-ascii?Q?6WygMST0+km+Hhg694tAdos14mXNfm97UhfnvVtWTYYQEcAwsYdkUCkqBQxD?=
 =?us-ascii?Q?TnVuech7mi/PKi79m96CbCyNCf2sEPm6Dkxo79hXw0Xa3Z7q0MbvkWSshpji?=
 =?us-ascii?Q?NHBWttRx1tdTpEbkQv1ElZBorXT8ly6TTny8CL3gxLJkqY5rMBEqV1izwBvE?=
 =?us-ascii?Q?pL65cPoY/sXmo9CPcustLqxoTsvEmGkdUevPQ5BtmEAZSf3tqmHMK2HjqfPh?=
 =?us-ascii?Q?xqW6bilRb8f+FGDGSf5NqGEe2yhl8CUcSD4xk4P7sgBtKUlypPROKatHG6XT?=
 =?us-ascii?Q?s4m8Mw1yTf0G4kk9QdYbu6MclerE+nmut3flux87RMhjGSfpJ8+pBjpTHYGP?=
 =?us-ascii?Q?Aj+Gj8vH53np7EQlzNkTQd+mKGfaxWcD/stXVncb8anXjEpo/QlXT3Wkux7C?=
 =?us-ascii?Q?gitphtGll4FefDFs/jPogrngK0jQ80cpZg2+p6Kjqah3MUDsweWuZDO0WrIS?=
 =?us-ascii?Q?O3yyr/bxTz0IMbBtLtNN6HrLxCmvsD3/E1F6S9fajTC3eOVCpI9JRmlO2iVG?=
 =?us-ascii?Q?vi8emQVuB5mlA/BZ3TmxK5B+WK8O1PIyM8JxoSGpI212YEMkp9rE/YaoEetx?=
 =?us-ascii?Q?EAEVgjH+fItFCflRiN15cA1SaixNKjmREeiuAqNEx1xY9VacQIpCVTgj5ujN?=
 =?us-ascii?Q?nzxUhafGu1KPxRXiuJRI3tBGwkKt1M9lGnFqkLLzN9YbndYxsTfwBVe+dYIy?=
 =?us-ascii?Q?NgFQL541Z9HeZZ0tuOFEHYY/9xQ1vZNk3qe2jvuscOMGyGFTlJ9fD8PEH2Fh?=
 =?us-ascii?Q?AsVGImWfxZfZh7sKPn8xkapSeDGtjQ+PzliM++hN0ltXqFonkVronBdbqhww?=
 =?us-ascii?Q?Q0ZtJ5g9iWubNCIiXWj0olasotNx+P5WyBro0ew07iBbIzwWbDGdT3PB3h7n?=
 =?us-ascii?Q?LhDRrKlVj6imcU0MA3qwhe92Q75+ouomORT9nJmkzJjJvVxYszA0m2yC8TnN?=
 =?us-ascii?Q?4X2qxikoKg8xBc8WXrCw6LFT17JuxNrJzyeskv+SRNas8h1/lA5iqirj+tAW?=
 =?us-ascii?Q?7WswkonAudJBbispbV/n0M3x+DGhQeiOd5FyA07zpxfopVaxgTFnfoagFunB?=
 =?us-ascii?Q?D3C8Ty45EjSXz5fhVqf9wQIQdvP9CTyrMn9yXwFfkTOoK73LeXTTJxSLaWvA?=
 =?us-ascii?Q?uUC46uczdDL+nbhlM98HKT+raxX7pzblXksd9zlcEpSk8IwPAjALXsRyiNrW?=
 =?us-ascii?Q?pBcz7qCJ2d2CbimqID/dudg6XMQ1wTVOrvcMgcappy+6sm/8+tzovMpdjdAX?=
 =?us-ascii?Q?oShNl6d94prBRB2AdeaVYED0GxsXMjpH5sPz2xaKst3ny0VkrYur34K670BX?=
 =?us-ascii?Q?CM0ktujq0JLGLtA6hLLnO9tCx0Pd1WwMuKYdcLuorHwv9WC5ZhFVP2TgAuVH?=
 =?us-ascii?Q?4nWqiZcMF5EhNRxPCJETh/MDtrHsVNmyWp+aIYbunaLtx27NvqPrZaEwT6c3?=
 =?us-ascii?Q?AitGsl2AQgQVUfeIBmhMLnn3wV8Le5QdsSEpiopoYdLX?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2796a0a1-6f54-4e07-4013-08dc70b27e2a
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 05:31:50.5245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WTHM6OvNXqcx08BJDQhsSFXrDJYWao9X7wNjbYthZ6wXh5ASz9xu7Brdv8UJXOqCXyR9t2LlU6ZJOSKtgcIBbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7933
X-OriginatorOrg: intel.com

Dan Williams wrote:
> Ira Weiny wrote:
> [..]
> > > > +	case CXL_DECODER_DC0 ... CXL_DECODER_DC7:
> > > > +		rc = dc_mode_to_region_index(mode);
> > > > +		if (rc < 0)
> > > > +			return rc;
> > > 
> > > Can't fail, so you could not bother checking..  Seems very unlikely
> > > that function will gain other error cases in the future.
> > 
> > Sure, done.
> 
> Can dc_mode_to_region_index() be dropped altogether? Is there any
> scenario where dc_mode_to_region_index() is really handling an anonymous
> @mode argument? I.e. just replace all dc_mode_to_region_index() with
> "mode - CXL_DECODER_DC0"?

Once we open up DC partitions to support multiple regions, no.

How about we remove the check in dc_mode_to_region_index() but keep the
function?  That makes it clear that we are converting from an enum to int
index?

Ira

