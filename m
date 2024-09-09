Return-Path: <linux-btrfs+bounces-7897-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 322F9971BF3
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Sep 2024 16:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 892FD284FAF
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Sep 2024 14:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BD51BAEC4;
	Mon,  9 Sep 2024 13:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QRnb0Vje"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FB91BA890;
	Mon,  9 Sep 2024 13:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725890278; cv=fail; b=TgBTeZ8ZX3SvYpJ39dGE9aFDJ79Le6QY4rLs04KY07zecaSgufXBKc59i0dKpviGhrx1uYSh1aVFL+1zxeNaJgGSgmivzHsMCNCFKhUV72Qg+bzcxTUXLAB2R3lY30ExA4Y2hQ+S4lZ3S9MDIE7ExZ/laNaax9PThn471FkLJlE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725890278; c=relaxed/simple;
	bh=RCTTar3aSAjajpcBLywr3PI2OIqPlmw7KMDYlUI8oHY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oRRp0LoLbX8n7gWg/GQFiDZSEDjPEmiJrljg1b2wuBdLrdkoHluD46xIcsnx5EwxVFGU9OxFrqLK4X5AqYDAxKcrHvUUe2we9uYhn8fOZ5naZflaMGZSWOC+bQQOSece973vSI6Lmgrhad+XnjbDbJ3COFIsJ8abZaQkoCzy8YA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QRnb0Vje; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725890277; x=1757426277;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=RCTTar3aSAjajpcBLywr3PI2OIqPlmw7KMDYlUI8oHY=;
  b=QRnb0VjesSK/dHoZLFjnf3DwLX28FNvm8H8sVQSekmKvGuCk8bOqgcjg
   zp2/Xa0irqk3qvAkG3Q7DI+oT3PsrX/eu6vQEUuhBIRFjfXJmkGudCFzN
   fjwihxDsMAtwdTCslfCFXdiTihP64WQjNZ0pcQnqSZB4MKMxvhBKEYAHY
   wv2/Z/k1hLIVD8nFhfw1st2xTbjmiDJmfuY0VJwLxojpCzzgumZpRz9dG
   4zise6sTG3QorzD8SFGBVwrTc3v1xCRdaqJ4RHfZX5ShkZeqeRd+nYiRT
   qQxtRBxstCOXB8PGJ3prN6BqxC1r7BfEnjPUbHXGHLcDI5jfOUKdSbi+c
   Q==;
X-CSE-ConnectionGUID: ga37d5HiQB6XkSa+4i9iuA==
X-CSE-MsgGUID: HXXz0im9SzyIYp1ovQ2TOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="24462759"
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; 
   d="scan'208";a="24462759"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 06:57:56 -0700
X-CSE-ConnectionGUID: EHwlwArsSLW5lt8KXVemcA==
X-CSE-MsgGUID: D+440NSHS3GeFzvA1uwC5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; 
   d="scan'208";a="66652938"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Sep 2024 06:57:56 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 9 Sep 2024 06:57:55 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 9 Sep 2024 06:57:54 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 9 Sep 2024 06:57:54 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 9 Sep 2024 06:57:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VC3ySgNMCiD8wLKgFvYSuTfO2EAxN6LZfghSdyEEjZijomHclxSbeVfp557+zLp2POscb36GYL+DyHYdjSdoiU9vLZXM0oH1j1G0aF6V2ZKW82C+V1SIcpjI12dcQaPICww6UzEl6DB1xDN59nWlWia4GoNzh/eA2KTpSpfL2L2E1zv44VVuqKFTybYOolv17Lbr7HfcdCRYR5IgCsCVGChe2KF+vRq6V2qTd7+AUP3R6bC0UDNYgksaO83N0dmgXVgGHCR5rs0pIsvK8p256qKMmcMwQVnauDfYxlvjKGfDockpOnPNYt3D5gh5XBiqAWkY/AsWnndeHqPhHF8w4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dveML4ViEM/Zfv7SXV/GT2+Em8xwREmpd7Ne0XoKpeo=;
 b=pMnaV46lKO+vvH/bik3FQ5GDNIDsClJ2CXGga2NWnVEn8U9XkPkMhrocz15UmygOsulD7CsdUvV+VzHX4qsyo5CA22J4040tI00ibv4+jorUKnbScjPR5wktv/XahVmOj0uuBNO3SGibOk2MJHUjhivGU0E0QNLjnTJ/NPqoNacb4DWCHokWr5iAgdBzsVI1mU0oprhXr02U/T2t74Tn7aMs6MXJmyxBhnVRpIhJPTvkyO5CC5iDgI5uFGxURhb3ROw2FhyoINkPAN4WkEVWJClV2TnHhnTFKe0nYr0UY1om2suZhS1ZGJ7DRACmVfiyO/6vfgeFOT9vWGRxTP99dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MW3PR11MB4587.namprd11.prod.outlook.com (2603:10b6:303:58::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Mon, 9 Sep
 2024 13:57:51 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%6]) with mapi id 15.20.7939.017; Mon, 9 Sep 2024
 13:57:51 +0000
Date: Mon, 9 Sep 2024 08:57:42 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Ira Weiny
	<ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Navneet
 Singh" <navneet.singh@intel.com>, Chris Mason <clm@fb.com>, Josef Bacik
	<josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Petr Mladek
	<pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Rasmus Villemoes
	<linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>,
	Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, <linux-btrfs@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <nvdimm@lists.linux.dev>
Subject: Re: [PATCH v3 24/25] tools/testing/cxl: Make event logs dynamic
Message-ID: <66defed6b37c2_f937b29469@iweiny-mobl.notmuch>
References: <20240816-dcd-type2-upstream-v3-0-7c9b96cba6d7@intel.com>
 <20240816-dcd-type2-upstream-v3-24-7c9b96cba6d7@intel.com>
 <20240827153204.00002bff@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240827153204.00002bff@Huawei.com>
X-ClientProxiedBy: MW4PR04CA0285.namprd04.prod.outlook.com
 (2603:10b6:303:89::20) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MW3PR11MB4587:EE_
X-MS-Office365-Filtering-Correlation-Id: a2bbc3ce-56d7-4c6e-909c-08dcd0d764af
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?K9YVyBgcuQMMh2InX3r4t6I32K39dH2P0WFblJEfGOuSyhdkfwQ3PVmz8XhY?=
 =?us-ascii?Q?OJAhY9NT+PRBumhqAYzpN9tXuHmLINEDsNbRpLyDNuDeKkrVvr2Rj4PUi7ky?=
 =?us-ascii?Q?ak4TLSuhYlyZGq/LkpuPs6eklxlc3K/mXmVV+dJloD7foMMIx+Bw2YrIJzVN?=
 =?us-ascii?Q?qdVoEpl/vCBGxrgN3FbFA2hEOBV22T0gWvcf1Ky1rncpjJiKnsEYdlu5mWbN?=
 =?us-ascii?Q?RtANN5KJu09xzhnZnmG+ZqVHRumf97AOg6gyCID77bcCXjANi9JcLlf4NKZp?=
 =?us-ascii?Q?PASyJMUDDibOzU2Fqe4+KBi8aIY6V9n4zLITfGnY+wsSDwcD9dH72VR4YTAz?=
 =?us-ascii?Q?w1EIDvdHnEos9DBQ2LnUfI/iOHD6tC9xsS0agMbG57IBiFme7wfr6sbXVlpG?=
 =?us-ascii?Q?++TYa/M+1Jz7CLymO3KR3bTYJZ3GabsFQ/NGxC2XPbFY00IjjcKAqS7qbZHb?=
 =?us-ascii?Q?hXb2OsEybljrbfHQFCFUX0Nbw1n/zPV4VumQn3DkrxQosfX8L45Q5o4Yz+f0?=
 =?us-ascii?Q?E9BCNd0gW1OPH3rX11WAOAc8DZBUYwSlsz40anX+GyoZXrC7Wg9U+BiVxKG2?=
 =?us-ascii?Q?fgG305FlwWjed+kJoj1K9jbbbD1X/IjYBPKxeXW9i9uRosRxhAl7P4C7g5Tu?=
 =?us-ascii?Q?qxVR834Fs5K+fR4XBkgUpDX5bZqRNEPDReZOdkDKeh5Db9E32+5CGZAK8bni?=
 =?us-ascii?Q?pXtbAyoN5FJDkv5rbcI38fDGWvOclU/totBIFdK4QIX5iY8uDtsktBe+bRXn?=
 =?us-ascii?Q?4vqoMLj7jc8mr3AlUj1KG10FVcwoRY3X4SBfodV7/vbPpZKwtZOp6c3SM4Va?=
 =?us-ascii?Q?jRwBel118fIj5dO1y6E2ftQt8EbSP9JcMU5L7n0shnAMv1EnpKPTxgy/q1cH?=
 =?us-ascii?Q?tRgGaq5OwDzg78OnUnxVGv8ehnzyyydxPY6BH13jR7Bda3gTFlqNhDEOX2Kf?=
 =?us-ascii?Q?mWzqzTulT/z1oSODl7n2AEykpLqPzKkLu4TzueMMrHJSCMT80KLkOIRQK6OS?=
 =?us-ascii?Q?Im6hC3uDEceq8Y3rNKyhj3Rouyo+WvJqBfMbFP7GJNEbzOXhsGv0PCROYQFy?=
 =?us-ascii?Q?hxfi7v2sdJ7Q1h0LY8DmVBFiQxH2nkNHjEZleXTZCGpk4rrG3PZBfhYOQy1E?=
 =?us-ascii?Q?51BwPkq56sKZ49WRo4XccQc0+MB8vFrMw+YLTZyWL4pMfFhX6VTB35rIMuvt?=
 =?us-ascii?Q?Ed1WPE9UXL3d2q8SuGHKUSqiSkvONGuFQhVenQ92HHmO/Q738OseS2b1eNhL?=
 =?us-ascii?Q?rFqQWe8H6dkmAhoXZ/mcwc3r7dYx+ysZ29hRNjDX5zswVk3+kFJT83qs3nvX?=
 =?us-ascii?Q?5sjbt6H4UrNs7/MqXyWCbD4dtIvWRQpuY1QGIQGz66NDUw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GG4lYsUqU+gAt9pjSsTcAmgt85w0LRNYzghoIZXw7S6kV/NT14duhOTDC/NW?=
 =?us-ascii?Q?hoC+K0tAOT5RNrfH+Du/QlQ5LarHGWC4FoL6vD+FhOOvUeRCRpCoEBiHYx02?=
 =?us-ascii?Q?rE1jjH5ng9L5DGLMr6zKrM6++HCEVIspD4cvHIbggrDeRXiZ1H+xQqiWApEn?=
 =?us-ascii?Q?hSZYd7bhIWhk/50PULMNrQONjRVfy8aBUb4ZyqP/5cMWxxvlkzrR1tKuJexm?=
 =?us-ascii?Q?CG2n0gqmUyxduuyxwQNSJS+8ewpMd1RB+m9ZgeMU3kxqdCh3/h/g+1GYXp/w?=
 =?us-ascii?Q?XtmJyvKPHcs7Bk5IdxrkL/sb4p7zoOc97teY9FSHgGGkP0i2VYUeCyKRG+fT?=
 =?us-ascii?Q?K5avsPP8f/NltRDHijh1j/sxYEGH/UF1+19j2dBIK6kq3UaoYoSDomQo8Xl2?=
 =?us-ascii?Q?xlmOBb+XprntHTcE7QiB480DE7Ydo3vyhvjbiiZsHv2UnQTDU1rbO0zRv3en?=
 =?us-ascii?Q?ICGJ4FSYxT6kADEVvXgp+XNKRcpwDmZDkRWk4U4uUOaX5dKZ5E9TQI5p9RMw?=
 =?us-ascii?Q?ST19aTNrYhly9JJLtX7LcMKIPFDBr7dh710gfJ/3Lw0wdLoo2nCwHrov6r/k?=
 =?us-ascii?Q?4CIN2NDaz+6OjdcdFcz1JdTNxDF9fYDZGukamh64UgbHRCWYuk2x+KWqrH3O?=
 =?us-ascii?Q?NCJeR/yjR6nQywrNgkSwBQeyhfmKni+j2CR7UVoJdA+I7mjVfmMbY+iTQp4z?=
 =?us-ascii?Q?0S7HDPk14vwIyLcm0kp82/hWI1QiNb2hu1gqyQSeRLlsEAm4WdFexKu9zCsM?=
 =?us-ascii?Q?Co/hCbLEb9rSIfuqdLVx6RwgyKIEx67fVCXxNPZskrJqiAw75Evh3jDizPMI?=
 =?us-ascii?Q?qxIfHkvZRqucPFp5fSvk52lss3daUkw7dpkSlkNCbS/IMtqzwizT/O2EIWRC?=
 =?us-ascii?Q?gkN1yiAc6ixksy3R9hbikA/qzcIZ80UG8Mq/rz3jKC/asNpk+snKsdPtoxEC?=
 =?us-ascii?Q?d/jg1h5+FK+b7cBse5WDGcPIKxCgCga7VphpTIMvVzxfUV6HmHy/W+8HhckX?=
 =?us-ascii?Q?KsPf7yka6ZJ3DeyOJHMkZqStb/uJiBHtvM2ZQEXfggkxY+uZj9Z7tWEjx5jp?=
 =?us-ascii?Q?SWHpzFQscKg5uHV+XeGkSP0dQrdCnOkeyOrLOnZ8uWoOVVnyC3dcCgV2YCUO?=
 =?us-ascii?Q?1Ze8lF7rbc9sjPWk/WXLL7p/LOGQOSb//Ftr3hpNCBsqyV6KKsJvawZSWsdJ?=
 =?us-ascii?Q?6eC87pwdAMhDf7If/hyGiXtqdCyoA2UB3DMWmCY0FJ0Qfq/kgg34vG/+kawA?=
 =?us-ascii?Q?FX3/HtrtGaYX90JoleeODKzJ4iWn8o4fEhDIdOm+J+yiV3oPBryRJGeZpDWD?=
 =?us-ascii?Q?raFczH8RxogUHSeCh1gBVP5wYwFx3t+vrVFTC+FDJlwbw6Ym5ENxtkOlUlOd?=
 =?us-ascii?Q?6FvRWx0JT+S8wReX9QYoPhxOroZ8stz0bZxntNz6oUx5dr8Ii8n28x35qOFW?=
 =?us-ascii?Q?yGneklNx3PBnvhX9r+JBcdFRi8cJHygIYUcAuQwKvolbJSuRhO9pzrimNirJ?=
 =?us-ascii?Q?hqa06nHjh3wg7PRnh68Ob9vFmBkIkqVZ+e/8JksVZ1d3qBVWDttfOlfMGNB3?=
 =?us-ascii?Q?rvsXW1+qYP+43CMUelmhj4I/Cz0Tkm+V4d4BVTVh?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a2bbc3ce-56d7-4c6e-909c-08dcd0d764af
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 13:57:50.9455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ap8t+KHDTTR1XCKC1P7cD/D0MG5E7gFXDx7hs7z32oNY3QF99o9zeUGDmigmeGefIVjujTdICWGeMgEFptwdGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4587
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Fri, 16 Aug 2024 09:44:32 -0500
> Ira Weiny <ira.weiny@intel.com> wrote:
> 
> > The test event logs were created as static arrays as an easy way to mock
> > events.  Dynamic Capacity Device (DCD) test support requires events be
> > generated dynamically when extents are created or destroyed.
> > 
> > Modify the event log storage to be dynamically allocated.  Reuse the
> > static event data to create the dynamic events in the new logs without
> > inventing complex event injection for the previous tests.  Simplify the
> > processing of the logs by using the event log array index as the handle.
> > Add a lock to manage concurrency required when user space is allowed to
> > control DCD extents
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> Probably make sense to spinkle some guard() magic in here
> to avoid all the places where you goto end of function to release the lock

Yes.  Sorry this patch did not get as much self-review as it should have.

> > 
> > ---
> > Changes:
> > [iweiny: rebase]
> > ---
> >  tools/testing/cxl/test/mem.c | 278 ++++++++++++++++++++++++++-----------------
> >  1 file changed, 171 insertions(+), 107 deletions(-)
> > 
> > diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> > index 129f179b0ac5..674fc7f086cd 100644
> > --- a/tools/testing/cxl/test/mem.c
> > +++ b/tools/testing/cxl/test/mem.c
> > @@ -125,18 +125,27 @@ static struct {
> >  
> >  #define PASS_TRY_LIMIT 3
> >  
> > -#define CXL_TEST_EVENT_CNT_MAX 15
> > +#define CXL_TEST_EVENT_CNT_MAX 17
> 
> Seems you added a couple more. Don't do that in a patch
> just changing allocation approach.
> 
> I could find 1 but not sure where other one came from!

I wasn't sure either.  see below...


[snip]

> > @@ -233,8 +254,8 @@ static int mock_get_event(struct device *dev, struct cxl_mbox_cmd *cmd)
> >  {
> >  	struct cxl_get_event_payload *pl;
> >  	struct mock_event_log *log;
> > -	u16 nr_overflow;
> >  	u8 log_type;
> > +	u16 handle;
> >  	int i;
> >  
> >  	if (cmd->size_in != sizeof(log_type))
> > @@ -254,29 +275,39 @@ static int mock_get_event(struct device *dev, struct cxl_mbox_cmd *cmd)
> >  	memset(cmd->payload_out, 0, struct_size(pl, records, 0));
> >  
> >  	log = event_find_log(dev, log_type);
> > -	if (!log || event_log_empty(log))
> > +	if (!log)
> >  		return 0;
> >  
> >  	pl = cmd->payload_out;
> >  
> > -	for (i = 0; i < ret_limit && !event_log_empty(log); i++) {
> > -		memcpy(&pl->records[i], event_get_current(log),
> > -		       sizeof(pl->records[i]));
> > -		pl->records[i].event.generic.hdr.handle =
> > -				event_get_cur_event_handle(log);
> > -		log->cur_idx++;
> > +	read_lock(&log->lock);
> > +
> > +	handle = log->cur_handle;
> > +	dev_dbg(dev, "Get log %d handle %u next %u\n",
> > +		log_type, handle, log->next_handle);
> > +	for (i = 0;
> > +	     i < ret_limit && handle != log->next_handle;
> As below, maybe combine 2 lines above into 1.

Ok. done.

> 
> 
> > +	     i++, event_inc_handle(&handle)) {
> > +		struct cxl_event_record_raw *cur;
> > +
> > +		cur = log->events[handle];
> > +		dev_dbg(dev, "Sending event log %d handle %d idx %u\n",
> > +			log_type, le16_to_cpu(cur->event.generic.hdr.handle),
> > +			handle);
> > +		memcpy(&pl->records[i], cur, sizeof(pl->records[i]));
> > +		pl->records[i].event.generic.hdr.handle = cpu_to_le16(handle);
> >  	}
> >  
> >  	cmd->size_out = struct_size(pl, records, i);
> >  	pl->record_count = cpu_to_le16(i);
> > -	if (!event_log_empty(log))
> > +	if (log->nr_events > i)
> >  		pl->flags |= CXL_GET_EVENT_FLAG_MORE_RECORDS;
> >  
> >  	if (log->nr_overflow) {
> >  		u64 ns;
> >  
> >  		pl->flags |= CXL_GET_EVENT_FLAG_OVERFLOW;
> > -		pl->overflow_err_count = cpu_to_le16(nr_overflow);
> > +		pl->overflow_err_count = cpu_to_le16(log->nr_overflow);
> >  		ns = ktime_get_real_ns();
> >  		ns -= 5000000000; /* 5s ago */
> >  		pl->first_overflow_timestamp = cpu_to_le64(ns);
> > @@ -285,16 +316,17 @@ static int mock_get_event(struct device *dev, struct cxl_mbox_cmd *cmd)
> >  		pl->last_overflow_timestamp = cpu_to_le64(ns);
> >  	}
> >  
> > +	read_unlock(&log->lock);
> Another one maybe for guard()

done.

> 
> >  	return 0;
> >  }
> >  
> >  static int mock_clear_event(struct device *dev, struct cxl_mbox_cmd *cmd)
> >  {
> >  	struct cxl_mbox_clear_event_payload *pl = cmd->payload_in;
> > -	struct mock_event_log *log;
> >  	u8 log_type = pl->event_log;
> > +	struct mock_event_log *log;
> > +	int nr, rc = 0;
> >  	u16 handle;
> > -	int nr;
> >  
> >  	if (log_type >= CXL_EVENT_TYPE_MAX)
> >  		return -EINVAL;
> > @@ -303,24 +335,23 @@ static int mock_clear_event(struct device *dev, struct cxl_mbox_cmd *cmd)
> >  	if (!log)
> >  		return 0; /* No mock data in this log */
> >  
> > -	/*
> > -	 * This check is technically not invalid per the specification AFAICS.
> > -	 * (The host could 'guess' handles and clear them in order).
> > -	 * However, this is not good behavior for the host so test it.
> > -	 */
> > -	if (log->clear_idx + pl->nr_recs > log->cur_idx) {
> > -		dev_err(dev,
> > -			"Attempting to clear more events than returned!\n");
> > -		return -EINVAL;
> > -	}
> > +	write_lock(&log->lock);
> Use a guard()?

done.

> >  
> >  	/* Check handle order prior to clearing events */
> > -	for (nr = 0, handle = event_get_clear_handle(log);
> > -	     nr < pl->nr_recs;
> > -	     nr++, handle++) {
> > +	handle = log->cur_handle;
> > +	for (nr = 0;
> > +	     nr < pl->nr_recs && handle != log->next_handle;
> 
> I'd combine the two lines above.

Ok. done.

> 
> > +	     nr++, event_inc_handle(&handle)) {
> > +
> > +		dev_dbg(dev, "Checking clear of %d handle %u plhandle %u\n",
> > +			log_type, handle,
> > +			le16_to_cpu(pl->handles[nr]));
> > +
> >  		if (handle != le16_to_cpu(pl->handles[nr])) {
> > -			dev_err(dev, "Clearing events out of order\n");
> > -			return -EINVAL;
> > +			dev_err(dev, "Clearing events out of order %u %u\n",
> > +				handle, le16_to_cpu(pl->handles[nr]));
> > +			rc = -EINVAL;
> > +			goto unlock;
> >  		}
> >  	}
> >  
> > @@ -328,25 +359,12 @@ static int mock_clear_event(struct device *dev, struct cxl_mbox_cmd *cmd)
> >  		log->nr_overflow = 0;
> >  
> >  	/* Clear events */
> > -	log->clear_idx += pl->nr_recs;
> > -	return 0;
> > -}
> 
> >  
> >  struct cxl_event_record_raw maint_needed = {
> > @@ -475,8 +493,27 @@ static int mock_set_timestamp(struct cxl_dev_state *cxlds,
> >  	return 0;
> >  }
> >  
> 
> > +static void cxl_mock_add_event_logs(struct cxl_mockmem_data *mdata)
> >  {
> > +	struct mock_event_store *mes = &mdata->mes;
> > +	struct device *dev = mdata->mds->cxlds.dev;
> > +
> >  	put_unaligned_le16(CXL_GMER_VALID_CHANNEL | CXL_GMER_VALID_RANK,
> >  			   &gen_media.rec.media_hdr.validity_flags);
> >  
> > @@ -484,43 +521,60 @@ static void cxl_mock_add_event_logs(struct mock_event_store *mes)
> >  			   CXL_DER_VALID_BANK | CXL_DER_VALID_COLUMN,
> >  			   &dram.rec.media_hdr.validity_flags);
> >  
> > -	mes_add_event(mes, CXL_EVENT_TYPE_INFO, &maint_needed);
> > -	mes_add_event(mes, CXL_EVENT_TYPE_INFO,
> > +	dev_dbg(dev, "Generating fake event logs %d\n",
> > +		CXL_EVENT_TYPE_INFO);
> > +	add_event_from_static(mdata, CXL_EVENT_TYPE_INFO, &maint_needed);
> > +	add_event_from_static(mdata, CXL_EVENT_TYPE_INFO,
> >  		      (struct cxl_event_record_raw *)&gen_media);
> > -	mes_add_event(mes, CXL_EVENT_TYPE_INFO,
> > +	add_event_from_static(mdata, CXL_EVENT_TYPE_INFO,
> >  		      (struct cxl_event_record_raw *)&mem_module);
> >  	mes->ev_status |= CXLDEV_EVENT_STATUS_INFO;
> >  
> > -	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &maint_needed);
> > -	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> > -	mes_add_event(mes, CXL_EVENT_TYPE_FAIL,
> > +	dev_dbg(dev, "Generating fake event logs %d\n",
> > +		CXL_EVENT_TYPE_FAIL);
> > +	add_event_from_static(mdata, CXL_EVENT_TYPE_FAIL, &maint_needed);
> > +	add_event_from_static(mdata, CXL_EVENT_TYPE_FAIL,
> > +		      (struct cxl_event_record_raw *)&mem_module);
> 
> So this one is new?  I can't spot the other one...

Its coming back to me now.  The cxl-events.sh test relied on an expected number
of each type of event (Including an overflow count) which were completely
fabricated previous to this patch.

	num_overflow_expected=1
	num_fatal_expected=2
	num_failure_expected=16
	num_info_expected=3

To maintain backwards compatibility this new code needed to preserve those
counts.  The buffers and number of entries were adjusted to make the output
match.  However now the logs need to actually over flow to create the overflow
error.  Furthermore, the handles are the array entries.  cxl-events.sh passes
before and after this patch.

That said, my math was wrong.  A max of 16 with 16+ entries added to the
failure log should result in the counts above.  I added a couple extra to the
overflow though.

Good catch on this.  I basically hacked it to match and moved on.  I've cleaned
it up for the next version.

> 
> 
> > +	add_event_from_static(mdata, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> > +	add_event_from_static(mdata, CXL_EVENT_TYPE_FAIL,
> >  		      (struct cxl_event_record_raw *)&dram);
> > -	mes_add_event(mes, CXL_EVENT_TYPE_FAIL,
> > +	add_event_from_static(mdata, CXL_EVENT_TYPE_FAIL,
> >  		      (struct cxl_event_record_raw *)&gen_media);
> > -	mes_add_event(mes, CXL_EVENT_TYPE_FAIL,
> > +	add_event_from_static(mdata, CXL_EVENT_TYPE_FAIL,
> >  		      (struct cxl_event_record_raw *)&mem_module);
> > -	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> > -	mes_add_event(mes, CXL_EVENT_TYPE_FAIL,
> > +	add_event_from_static(mdata, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> > +	add_event_from_static(mdata, CXL_EVENT_TYPE_FAIL,
> >  		      (struct cxl_event_record_raw *)&dram);
> >  	/* Overflow this log */
> > -	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> > -	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> > -	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> > -	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> > -	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> > -	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> > -	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> > -	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> > -	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> > -	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> > +	add_event_from_static(mdata, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> > +	add_event_from_static(mdata, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> > +	add_event_from_static(mdata, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> > +	add_event_from_static(mdata, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> > +	add_event_from_static(mdata, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> > +	add_event_from_static(mdata, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> > +	add_event_from_static(mdata, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> > +	add_event_from_static(mdata, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> > +	add_event_from_static(mdata, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> > +	add_event_from_static(mdata, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> >  	mes->ev_status |= CXLDEV_EVENT_STATUS_FAIL;
> >  
> > -	mes_add_event(mes, CXL_EVENT_TYPE_FATAL, &hardware_replace);
> > -	mes_add_event(mes, CXL_EVENT_TYPE_FATAL,
> > +	dev_dbg(dev, "Generating fake event logs %d\n",
> > +		CXL_EVENT_TYPE_FATAL);
> The dev_dbg() fine but not really part of making it dynamic, so adds
> a bit of noise. Maybe not worth splitting out though.

It's just debugging that we are indeed adding these to the now dynamic list.  I
added a print for each type.  I've added even more debugging with the clean up.

I'm going to leave it in for now because it is part of ensuring the dynamic
events work.

Thanks,
Ira

> > +	add_event_from_static(mdata, CXL_EVENT_TYPE_FATAL, &hardware_replace);
> > +	add_event_from_static(mdata, CXL_EVENT_TYPE_FATAL,
> >  		      (struct cxl_event_record_raw *)&dram);
> >  	mes->ev_status |= CXLDEV_EVENT_STATUS_FATAL;
> >  }
> 
> 



