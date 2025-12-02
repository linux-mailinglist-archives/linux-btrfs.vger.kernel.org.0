Return-Path: <linux-btrfs+bounces-19466-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 81636C9C5E6
	for <lists+linux-btrfs@lfdr.de>; Tue, 02 Dec 2025 18:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B894D3467B6
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Dec 2025 17:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749E62C0261;
	Tue,  2 Dec 2025 17:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JrGtW8g2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D381A1F4190;
	Tue,  2 Dec 2025 17:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764695984; cv=fail; b=SLcC5kdkK4VTBxogCgLSKQgb3S8Q5WUL2cDDwVkq/iygQalHUfs7jRWBOjvJ0a7iEr6ZO+tdRh/sddVUONSFGgA7jEAvJAwzQ8uFMudj0M47dPUNM5DsWM33VCIKIfkelKEurh8Hs4DbvPUsmw9PzHYK/CabgBIyj/MAu1no8DU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764695984; c=relaxed/simple;
	bh=0apFGSU8JEIJ783iHUZh3xOshw+MfV6IVfvbnyCwfJA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZwivXmd+Q9NAGSu0Rxql6y1Svjh6wopZCO3KxLANKotAbM/ME5LlVeDye1iUVn42skc4juVvXegmEXrxhjpSlbpUQwvM+VcdNQRbpVCxyS2uBfKb0kjJA3WsVWtHgkUPQaLKJbzG5WgSXqU1WMOwf+7EbE6yl8eXkqFFyl4s5UI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JrGtW8g2; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764695983; x=1796231983;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=0apFGSU8JEIJ783iHUZh3xOshw+MfV6IVfvbnyCwfJA=;
  b=JrGtW8g2iyBd8sM62LXZ0vk8M2Rumf7eQEEJB+Zl0758cmUWmbmcFjo2
   coeRWHKBdFCHTxQcVbi4iQe6NdawEOGtVd0llAjXxyz6HkiZuWcUwO58P
   Eeszjx56mMcvG0LrgMMg4aX6cXKHhIun2yzJQVTZrb48ZeNrTWp8wJrdH
   DsYFUT9XgQTU/eueOYBA7K4RIlKfRl2aF6pgupflPFtlbQxKRmtva3dJa
   5pOcOf+UCMaCtHzUeSTPb9p8JTsMgHl22U6nbcC8R35kFnNYmQg7BAc7/
   ZJtcSnuHqVceUH+pm9FuUohf8lYquKj5AO+wczJlaHc1dXnzrOFMa7Zqb
   w==;
X-CSE-ConnectionGUID: xlResSKCQi2+/Ndf72BEHA==
X-CSE-MsgGUID: C9gQ6bqxSXaJLYhgheM56Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11630"; a="84069555"
X-IronPort-AV: E=Sophos;i="6.20,243,1758610800"; 
   d="scan'208";a="84069555"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 09:19:42 -0800
X-CSE-ConnectionGUID: zaI20U6CRmCw5IGKOL5qrQ==
X-CSE-MsgGUID: 93iV5Q45QYqk+xXw+PZQww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,243,1758610800"; 
   d="scan'208";a="225118735"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 09:19:42 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 2 Dec 2025 09:19:41 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 2 Dec 2025 09:19:41 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.57) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 2 Dec 2025 09:19:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kmuCw1nC5e2IyWEpJY6quSgLlaKxHuAjyQSivUUK8eKVBhytSm+aIi4DTS59tK2FonjGpl5oMoMJRo0g67onSdi7asfMxj5DQVnguOJFbWQzUjeJIaOldlEd0FExmnW6+TPDUfJARF6vW/AG9kKFf1u53OSpFk5Txh+7c2biIaPyWWgQ2h76L+dUps7wxmdyUJ2DrDAOqYFgIjjCChEEMBP8dQoY4Gxp61IPBZHWieVOX/eVU95pGSH1X00eqEGTpIW1DZfA0IHzTrq4lm2ujxI9WZ4EgomEkZABSbfERKCjLQe93PbazIMzJKekQMv5Y0ZqaJZOWWmWyV9n8jL2pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RaqWTFNgBbM/ky/VNXDdhtrAhN93YpmDN83ANBbZYxE=;
 b=nXcsutknwZP0GTF11Vqdal5JUNjcZqIJGHfvJKXJwbsEqQXUGYLrj0q92mLZIAVFCA3rExV7KqgWN91I7Do0JLBeYhkFnKtI56LN8X+iZflBUjjyEwv4oFbNSzxfaJDKidZFdeocyjxNnBdmb6GS+kVpuViI6RJECDr/O+fE+Hq4uJbV4g7E5/ioSfaVJTZrnKTEIIYyPWYvzziKs5Mb2ijDUf0HKK0nibwelXSfPgsa1rVogXniBQM78QhEhssRiI8aKJ9sk6gBEeMelnMqYxO8f6Y/VWSlrlbOZBJ8Q4hlciROXgukSjF2TKKX6WxKp/tdKVQVO0o03t9ceTYbtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by SJ2PR11MB8422.namprd11.prod.outlook.com (2603:10b6:a03:542::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 17:19:37 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::22af:c9c9:3681:5201]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::22af:c9c9:3681:5201%5]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 17:19:37 +0000
Date: Tue, 2 Dec 2025 17:19:31 +0000
From: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To: Jani Partanen <jiipee@sotapeli.fi>
CC: Christoph Hellwig <hch@infradead.org>, <clm@fb.comi>, <dsterba@suse.com>,
	<terrelln@fb.com>, <herbert@gondor.apana.org.au>,
	<linux-btrfs@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
	<qat-linux@intel.com>, <cyan@meta.com>, <brian.will@intel.com>,
	<weigang.li@intel.com>, <senozhatsky@chromium.org>
Subject: Re: [RFC PATCH 00/16] btrfs: offload compression to hardware
 accelerators
Message-ID: <aS8fo0h32Yp+ZSPV@gcabiddu-mobl.ger.corp.intel.com>
References: <20251128191531.1703018-1-giovanni.cabiddu@intel.com>
 <aS6a_ae64D4MvBpW@infradead.org>
 <8d3e44b0-23d8-4493-8e7e-33bbe1d904ef@sotapeli.fi>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8d3e44b0-23d8-4493-8e7e-33bbe1d904ef@sotapeli.fi>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
X-ClientProxiedBy: DUZPR01CA0181.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::22) To CY5PR11MB6366.namprd11.prod.outlook.com
 (2603:10b6:930:3a::8)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6366:EE_|SJ2PR11MB8422:EE_
X-MS-Office365-Filtering-Correlation-Id: 2824045c-48ea-435d-2771-08de31c6f83d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1qcxbG4GS1b3nqMNjQJF4OU0+N4zIjZ2+0Z9/4UnswTkorBL28KDVLjF/P8L?=
 =?us-ascii?Q?iniE5+D0Ri7U6U63AAq90JBIDD40MY+WFoCQYE3IWcPeWWxoqZoSaJ8bc5kz?=
 =?us-ascii?Q?/gPDsf/OgHL9lJpHDwAc7T2QbJImzFhruDK8GjdPcqYrN20HHYPG5FLrj6pT?=
 =?us-ascii?Q?CNGba5f0kcp+df4cSGyT1aAqCPFRPgaKHVbQ7gra6fX2DRoZPH09kPlHL1r7?=
 =?us-ascii?Q?bNI2CWVOoQYVqlG28nMSiF4UnRtimXiYlbm1KmMKoa6QqwNdd9pBRGPzwU3g?=
 =?us-ascii?Q?mg+KnPGn25Y8uuz6YeKDlm7piFs+RkRFrwnNn/WzAVodSDnNtinxrKZPogbt?=
 =?us-ascii?Q?T3Pd3SZL4wAi8qgyIImNxHhCb5yHJFl/sG5Rf2nheJtc3J0znvHg6pY8JuFl?=
 =?us-ascii?Q?hVOJPYwCBqq+05+8tSNUf7hURtpTYIZoz3LMGJdgTV0dUAy+5Zg4yqlLxYac?=
 =?us-ascii?Q?fUSaIAExJAS1rZSju/g4RqzcyHlWfRcUHo0hHWi/atBAv65vCdAeBd6a3PpT?=
 =?us-ascii?Q?KpVF1nFdNaQP0EJSrGD8Nk6+0pyLwtdFAK7vQT4nZBszsU0kfgEd2R1e/xF6?=
 =?us-ascii?Q?0rk4XTGzptDEIy+SdGWAyHtoHRtAlf9TxvRhF6hnXTN1NhNTYHF31eWIAoZR?=
 =?us-ascii?Q?R9Tbei/cO2j8lZmL23pWbBhCHKYXIuVUcZnNdtbq4qh+KAZo1qnKeZGPi/bd?=
 =?us-ascii?Q?02rAGNTgOyjmvpOULkoNhsdmjLSKsC2GVr0mY8iiWaCStro2T0P/BCbrRjwS?=
 =?us-ascii?Q?6M6ggq23KzVA5EGm5+MXXy32ncMV2/SW4Z/AIAHGkDkjL7BsH5AbSziMlLRF?=
 =?us-ascii?Q?lQaYo0zSBHFxXZHn5gVuc53cuq6K76uqHBXwLbHzi5VUAZbc/N8MdNs5Wmkm?=
 =?us-ascii?Q?dXB81t2bZ6hi6XmbI6gkiGciyNpUjdZMFYQaQG10LfzbMCY/nyS5pDLIYfH/?=
 =?us-ascii?Q?WICZJipPCvfqUoLNHqxPoh566LwckFb4YTSE3D+e2mUxX5aNVL9qsn+1Yv1t?=
 =?us-ascii?Q?BGCmHZDCQDCqzM+ZROK48LxbN4MbteexoiVwUwMtuQ17X0PphE4HA23yomWT?=
 =?us-ascii?Q?Yt1wCofClDsDPDbVHKG9pRzyD2acQ2uqhBVPkqO52/hag8BvtKvyCS7L1bOQ?=
 =?us-ascii?Q?qKoSsh39EaZEptoXcK8FoNb5UrttF0CRrwsGgQyl7O/9hTb81IIyvi7lOY14?=
 =?us-ascii?Q?Jy9BUGrrWud7uOoDvM1J/bs0gETMHwS1aTwOzM9D8EtIg7rCI8C0QxmQKPO4?=
 =?us-ascii?Q?mZXAE9wfewpMN1y2apfBql4fZ5UYA9dBSLxmtCco086KJ+eLdY4ekXeHXx4G?=
 =?us-ascii?Q?RR36lTwsg87qPuVYxdjAeChcWCXl3MU40WEloRjqfLLERRRP86uszVQEdf2l?=
 =?us-ascii?Q?Fz9GvLsdm7G0Z+uCU6mKRJoLymxX2Nx5omC2lc5+CTpDNZ3y8k3kg5/7tIRU?=
 =?us-ascii?Q?1vTJe+KHDyitb6etJx5veTCXnlerJAB7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UtA3Hpebx7hga7tEnBjyAFF3y77LQrdeiesTe4FxXKf5oFYu1vttZM2EztV9?=
 =?us-ascii?Q?Wnn8Wuxdv+2N8li1Sufp0yIAbwkIclG/9uY2wYoI0OOg1K/zdApKi1jj+jD5?=
 =?us-ascii?Q?rbDo3M51zS5C3zzyIo1BWHJ/21cuyfiO+s6PLnT226vfLmu5PY3uiuK4SWWt?=
 =?us-ascii?Q?MYzmTB7VcN7KDpMmX8aWnU6T6kj1dSKDQZI0E1vOD9PX2lyLkMXMokxoFwPr?=
 =?us-ascii?Q?gJj2DcGutYbyFc1LCHKcyErHzKE4cVRYvB2CTvW0g1m4RN3Cp0qbGV9zlvSx?=
 =?us-ascii?Q?mEY4d9KBU9OdVwmOc8/GYbN6zdyukxMgNUA9+4CYeVgf5K3lL29P8EYDDkHX?=
 =?us-ascii?Q?qnxSw0g8agVFLQ1Y8CDeAc1OYdn3Q8It+URgVm7LgRksAjcnIl/I0MpjYNkb?=
 =?us-ascii?Q?IxDD2+P7olF7UtTeARmzSxHZZbN6G1yHBUqno4LrLIVrb2PHPVHg8rFE/zhf?=
 =?us-ascii?Q?QuRz2cNtPuqrB49fJSV9RmcMn375bbDdOIFyHfhV8MAsT/v8uI05e1jRHtQY?=
 =?us-ascii?Q?9dgCDm7AUMSMi4BdHEYyap4s7YghQ+UDdlPBWeAP0CchFpp+CdOqwaC8y7dI?=
 =?us-ascii?Q?RggJYwDdL0QQmsri+pf3NrJL78MN5WO4c4XXKunkRkPQmbLjBWt43p/Wt5K/?=
 =?us-ascii?Q?QCswExlMo+/30eOrmzbLV1oIWIOjCT5dM2/bGqiQiZwWVonDwwk/1q3ZoCOB?=
 =?us-ascii?Q?DmvXnvPzuFUwRyK+bqKvEFFS756iCjeAv35s2LCOFZoD6RTVbBuowsivpuPn?=
 =?us-ascii?Q?b3ch1hLPzfbok/9K2HdN9mUTt8g9fjmJpz3fbHnzDmJuA2oSBc8B6wbEAPVK?=
 =?us-ascii?Q?0u8RYfUYqWEVxbKo/OOI1E91o5vXQS4ydOTb/bqoT3AindfNj0SqxGY5f7cM?=
 =?us-ascii?Q?pQOeA7CtopD4N1pnQT2cr4vdMA0lblDR+p9DURv2qhRsSLSaEOpGCHcTcrxB?=
 =?us-ascii?Q?IN367j5vXGIrsc59eD27cNkU+obH7SCkyHSpl7hg8P17xQ0b4ZgLfw3JubQX?=
 =?us-ascii?Q?fmOJ7LYCj69aWdOTe8WMtT/Di2fHOCrWoasca6DBCJlSgT+LiZz1/jXwnm+c?=
 =?us-ascii?Q?SIw/PcNhFEgJSvh7KPagGILJihduiC8NpjX5DdEc7IkxKpEKqXY4kprHMhQr?=
 =?us-ascii?Q?F1JKaUrE+gsiRODvf010p9LjTKQYYLU/fhhIFvsB/UNfWImfPri+hmG44jFq?=
 =?us-ascii?Q?TWrM0AGMPKCwUt1etWAW+PTquPByD1lCyMMCQD0+SwFN52nxTVN67QfCrzLd?=
 =?us-ascii?Q?2gCkNsKB7WDhT+w98wqYfnWIjav+RoXFm1m40VRNwr0PDuEVlSGADltNdu/3?=
 =?us-ascii?Q?edURxm0Vpt1XcKXOEA+x9GnMrFHN+oOl193DhxFYRhPNuhWT1plvlry7jzdp?=
 =?us-ascii?Q?CJuTddTS6HuRPfIR4lbehtMiWgHhC3wiwTgbrNYQJhwDFOWIkdyNebaUWRu/?=
 =?us-ascii?Q?oP8oJ8cUDA1FQKMSy4FyJCgkqcuGXZqbk4i+VEwL5V+62xrBwc7YuR5bblsS?=
 =?us-ascii?Q?b2slLytOajgvrN68sY653ZxddyN+Dqnm194udMlzgJ1xMeaYb062WXQMZ0Xs?=
 =?us-ascii?Q?S6wJUL3a+p5exswSKh+n9tR6pxtvkD+HLwAJBJ0ixM2xlbSrYG9lkziEVnDm?=
 =?us-ascii?Q?nA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2824045c-48ea-435d-2771-08de31c6f83d
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 17:19:37.2869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uzBHqTD2LgmnE+zk7H9hu14n/xfEv/QtIK8BW/qjD3ynyqkVoHuQ+wQbC+MAOzBaxRfp99PytWJYwAKWr1YwdmdHpXuJ8U7Gz7ntjLCEvXA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8422
X-OriginatorOrg: intel.com

On Tue, Dec 02, 2025 at 05:46:29PM +0200, Jani Partanen wrote:
> 
> On 02/12/2025 9.53, Christoph Hellwig wrote:
> > On Fri, Nov 28, 2025 at 07:04:48PM +0000, Giovanni Cabiddu wrote:
> > > +---------------------------+---------+---------+---------+---------+
> > > |                           | QAT-L9  | ZSTD-L3 | ZLIB-L3 | LZO-L1  |
> > > +---------------------------+---------+---------+---------+---------+
> > > | Disk Write TPUT (GiB/s)   | 6.5     | 5.2     | 2.2     | 6.5     |
> > > +---------------------------+---------+---------+---------+---------+
> > > | CPU utils %age @208 cores | 4.56%   | 15.67%  | 12.79%  | 19.85%  |
> > > +---------------------------+---------+---------+---------+---------+
> > > | Compression Ratio         | 34%     | 35%     | 37%     | 58%     |
> > > +---------------------------+---------+---------+---------+---------+
> > Is it just me, or do the numbers not look all that great at least
> > when comparing to ZSTD-L3 and LZO-L1?  What are the decompression
> > numbers?
> > 
> 
> What makes you think so?
> 
> If CPU util numbers was single core %, then I would agree with you. But its
> 208 cores so there is quite big saving, like over 20 cores saved if I have
> understood this right.

Probably what triggered the question is that all compression ratios are
similar, except for LZO.

Also, in the previous version of the table I didn't specify that for QAT
we are running ZLIB (even if this set supports ZSTD w/ QAT).

Here is the updated table:

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

Key takeaway: QAT offload aims to reduce CPU utilization while maintaining
competitive throughput and compression ratio.

At a throughput of 6.5 GiB/s, QAT-ZLIB-L9 stores the data in significantly
less space (compression ratio 34% vs 58%) and uses far less cores to do
that (4.56% vs 19.85%) compared to SW-LZO-L1.

As for decompression:
  * zlib offload supports both compression and decompression.
  * zstd offload currently supports compression only; decompression
    falls back to software.

I'll share zstd and decompression benchmarks in a future revision once
they pass internal approval. I will also include measurements for SW-ZLIB-L9
for a direct comparison.

Thanks,

-- 
Giovanni

