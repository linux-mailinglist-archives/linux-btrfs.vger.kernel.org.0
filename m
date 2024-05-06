Return-Path: <linux-btrfs+bounces-4764-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A9F8BC68D
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 May 2024 06:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F50EB2118B
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 May 2024 04:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7010844C9D;
	Mon,  6 May 2024 04:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CxoRbNWB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453F61DA3A;
	Mon,  6 May 2024 04:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714969464; cv=fail; b=mf7aXZW/4lUcQeuTQa7Cm/nJn1JQ/eyu0DG+BaKV3U2LwlG7CRjX6XVqyWBV9qCDuOjldespGPaaqKa4RQds6z5wrFCmqmLotd7qDn4OMJpbR6jRPXnQwwhpIPZD+kawdKaR0KBVSYgKy9qjOsN8ZwpgxZgYVmytJFhoDdk2eko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714969464; c=relaxed/simple;
	bh=MItERBKYpCvt1hICtxJHFX/NgVLsAx5D8ls/wCN8wj0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iQu2MOt2h03GOkGnfsLNhGSFryvBwUCb/bopb5XEOu0n6GLCRSywgNod7n8LFiyXpaoeGWevuYaNNfXNiObHHpKe3Yfs8+HCFVtnv1BLVg76ZO3DV1PV6qP5Yo0RZBbpJXoQuJVxs2qG+1IoplaXzBFPrVGWzu5p9/K3JA5i4YM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CxoRbNWB; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714969463; x=1746505463;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=MItERBKYpCvt1hICtxJHFX/NgVLsAx5D8ls/wCN8wj0=;
  b=CxoRbNWBZuowiTSQT7K3A3256sCfe0GZ7cfcnxPnnH0vUcC2D7rwj0e7
   K/ebR6GHCSZlVHiFwRQ6HhmSQcRWksKmmuiIbgs4G/Scd1GRKrlpbY5fW
   Gtqlo9ryEtm/EudEi6W8+/i5j/fdf6HjGy1qN0yGLctPpix1Fe7kOoUWk
   0vteQOXr3IyQybRar2k+8vFpS1io/AwzWqSqoEeC3Pp/3wJngUIbEBwRa
   sal+TAX/Q8xZQ6l13/cjs2AJm8GnYnTvMlhnzmRLNKaKKgSTZtlcy0xXe
   iEnpotYPTTSCqI4bJSQNKzCGpOUhfFZh1X3LJBNS+JlYrHSyIESFeF8hq
   A==;
X-CSE-ConnectionGUID: Xy+5P/MlQeiUKY7yhp+5qA==
X-CSE-MsgGUID: K0kNpuAqTz2b4hgt6sFAhw==
X-IronPort-AV: E=McAfee;i="6600,9927,11064"; a="28172423"
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="28172423"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2024 21:24:22 -0700
X-CSE-ConnectionGUID: Pg1OWZAXTs2aP51WRad9+w==
X-CSE-MsgGUID: yHDlJr3+SIi5dtRBO6kUhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="32835709"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 May 2024 21:24:22 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 5 May 2024 21:24:20 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 5 May 2024 21:24:20 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 5 May 2024 21:24:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FiM3ZDxUBA2+iG2kPzGFyWGWnbLdIXoWJeZKyF88gnMn1RcGzZiHCUW60X3Pfu3sHxRpdBUpXXZODbOa2ueJ7UILDBbaqEl8ocD+OjkUN+45XrDs1zxuiAO865j0LQqYkd7yz+zRTugHgX4OxSKLZNKU1YRYRC8p9lhZ++wDFpv35bkX4q+LoXsLwKncPg9swm13V6U4/4FFkqniBn2Rj9IS8EV6n83T8roQJ4O8LYvGSS2W7WcCJ8ibwaMQLDZNZwdEGOC6LP6X2yBERvaL7hehVt4bQYWxkyOb/z6zDCfSdrMCp5kI60VaTqsbvoYCY19joRXmRsgiLq1IhYu73Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ku5ExviFJkAA3ICQ8BTOZ9NLDyAQJI2e3K+tnMVYDiM=;
 b=BKMYwtZcjKvcts4iiNAy+Ynak8nvx3P73ea7ufBIcJLW9TWuo6eOhjCs5Qe4gSPRCkrDigrxm1ttZLYfafNMr/SuMG/rIAyY4FzEkv82NnzAPWeFU6h6vfMZN/mhNQXvOFymm7evSWIH+TkoeDxaGT0mMuAD1xCwx4NEYMnV1BM0HRMBV7V8XLvHcA7mmdd8aLv8mZrRl8zF4L+YYXCTpEYULTQoGp0PeQzoiNlgbKwL34EV+o5BJhexs5CjYRJtIVYUB0z3+zQf33c1D47gW5YbQQycGh5DHTL5uEb0xzI5unjTgmh30DA2pbHeOvDRZ43LiZJKA1C65gnrdcyYCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by BL3PR11MB6531.namprd11.prod.outlook.com (2603:10b6:208:38e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 04:24:17 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%4]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 04:24:17 +0000
Date: Sun, 5 May 2024 21:24:14 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Ira Weiny
	<ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Navneet
 Singh" <navneet.singh@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-btrfs@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Chris Mason <clm@fb.com>, Josef Bacik
	<josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 00/26] DCD: Add support for Dynamic Capacity Devices (DCD)
Message-ID: <66385b6eb5f54_25842129416@iweiny-mobl.notmuch>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <20240404184901.00002104@Huawei.com>
 <6632d503f3ae5_e1f58294df@iweiny-mobl.notmuch>
 <20240503102051.00004a99@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240503102051.00004a99@Huawei.com>
X-ClientProxiedBy: BY3PR04CA0028.namprd04.prod.outlook.com
 (2603:10b6:a03:217::33) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|BL3PR11MB6531:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e793fce-039a-4ba5-83d0-08dc6d8464f6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2YGqR7/ZHaK7DcAasC8CSJfHMmzkKV+B7HCLmiQoY17Ir0x1N8Ni3a6BWpcl?=
 =?us-ascii?Q?7wovyZUPalF+8WNbxbQUsggTSSVoxYWKKLHAp+o9CENt5uSbvfuEEKk/GCYy?=
 =?us-ascii?Q?XQRfQ6hakgD5vj97t9RMjqYW1jJch/rlYInj7OENjuJwC/tr+UhWporoPobw?=
 =?us-ascii?Q?NFo6kR2gDAQ9mn4rVvQ+H3TqSfYMCD2Q5Kn895B5SndUvhrsUnm4odXPirzC?=
 =?us-ascii?Q?GQck+B9HYS89AybsTT5++VtUU3xA8NWO/QMdlmIXRuXC57pahdlNHbWrVX56?=
 =?us-ascii?Q?ItY8j3s0wfj2rlr5azdbv2rzGa4Vg1GA7hlkGaXZxFDehfn+niFdC4VsXsQb?=
 =?us-ascii?Q?ZjCnlH0Dg339j62/Kc1OVtP/U9GyBAmc+z1L3W+utn1F3fFBkCFd5c/INx/p?=
 =?us-ascii?Q?AgTRM0wQCehJG7N2ItAKcHdP6ZE1GbXuz3LhOro6iLamUfdhgBxes1w+FwVq?=
 =?us-ascii?Q?H3H+HfN9NCpDxNab+bcItJBZVltEgVFkHjTmAVRywsQAmVgK/urjOSvqBakB?=
 =?us-ascii?Q?PtjZLbWrzCLxa+EVXF6cXoJ3AYFFxS5Jr/CpUV7dZzT0K+YJkzm87CNppFO4?=
 =?us-ascii?Q?6DUQBdQBwgPIhcwO97dik6ZQUi6siglRcKfx1OvauN2bAZbQybmpzJ+NRXML?=
 =?us-ascii?Q?p42p15b1mx2cYQiZsgbeqa/wsyygfDg8/fj1b6dmA+9RS1Y9FTVn3E/tHm8R?=
 =?us-ascii?Q?Rqa9HKhcna8RBFjS1aFzCcmGTCTxCP++lK4RAUR2NEenVKSTECenaeydWZfy?=
 =?us-ascii?Q?IHxb2C7BoIQCvACKC4rim6P7K68kTEYQcvZmLmeLB8lstw4okIaYRSUAQaaI?=
 =?us-ascii?Q?MsDrHwLjoGGwCfqzKyRBUXEifvk7IEYl0jr7+TO1nl08dH86KhNHRv1UXSNH?=
 =?us-ascii?Q?bUcEY5ScQNpmi54sSxb4lKdtjZVa/qWq487JamIKtD17aiRX5tVq9vTGRl/Y?=
 =?us-ascii?Q?L8aSVZ5fZPXHVAdXk8XftIvL1qb8RtqcL1TwAm9KtcgBpKtNoSbeY/ng80UW?=
 =?us-ascii?Q?9GTIKzQS6LJ21i4IA26avhpfho1iKLjT2t7T6vNaAt+1eeC4pyx5rNAcCogd?=
 =?us-ascii?Q?Ndn1nwb8XDgwq3abxRl6EzO0v2iwNzbwe065+yL0iIj1IXxIEliYe+/porry?=
 =?us-ascii?Q?UTMWd91TKg6rjcdlQJfmxRITebvrGAxkvxXew6fYpYQfZdAEURAkY26gi20t?=
 =?us-ascii?Q?GEMQ53yeCBtwFdVZ34kh+Gb7m5VzYMMkUe8GUZjkPq2wM+M2oKJ4kLd+ZEDm?=
 =?us-ascii?Q?tQjMirogwU+/BcFXus88sfuaBP4lybRobqOLVfoKZQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8BbD99qZdjdu7r51wipocZcD3Ytm06gox3u6sd6KvmLekPg6pA3JWTVgc8G5?=
 =?us-ascii?Q?14bOqZLMvGdx2WTVmZzetC+V41OvIbRwqDD9fq6dRomVPQmyuAMKxJeTC6cH?=
 =?us-ascii?Q?Ko9DCwbZ3NYeqeLAxpPI7z7ULV3ZWpHvVNd+OuMlEh2DJbRvgIoNqFzNHNy8?=
 =?us-ascii?Q?9ay/GndO08pR6Q3RkangrI15rr/TKyH0y4Qv4Vfaj8pbLz2OiTu+YT91nr30?=
 =?us-ascii?Q?oLfaqq7P8uti9LEGoryYTwKm9OKLg85+8LqZ+xNUSt8c85XU7lywgGr6zfF7?=
 =?us-ascii?Q?harhW0sqmV6ILKklBNk49Kwn0PMjOaGel2hNw5SwrzJRVVLjJQ5CWjKA32E8?=
 =?us-ascii?Q?vz++buYPviaJMa0QVmf7DqbHVvaMcyhywkRjmLd1K/pttf2fHPo2Cybl5+3a?=
 =?us-ascii?Q?Qiww5ln4dgAAmrTVyeRT5Q+/SK0d3wPADypqoIqNo3W2HColFyuWNyI8JuvU?=
 =?us-ascii?Q?9VTbFTRFI93Wid1/o/lQP/cP/HuH8R5vRrDcijTcAXCM0j//6HUQU6EHnYPg?=
 =?us-ascii?Q?MfvUIQK4D6nza2k7iBpZLX0zLKS9WMYD622Dybnxy9UpzeEpkr1h3yT0IZZg?=
 =?us-ascii?Q?VYOg9HHVeygd0HOQc0o4kh8GCcGDa4CIKWIPR8wcSI/zDlPe0UAFY4rE0LX2?=
 =?us-ascii?Q?QcgCtCd4ipzs3IDQGm6r4aj4nfXYAQML747YbH2tAqOW5nni5Au2yjG5VD0M?=
 =?us-ascii?Q?7RBPAGqmsm77icN4WhHkc89V3wDpSJSktll1bXcyeIfcfsSYwWs0FHBnRpht?=
 =?us-ascii?Q?eh3p5gtsK3BygTDeJyBVsl05jn3lcl2IXzAp9FsaQQZhNiChA/GM0RdI1bRt?=
 =?us-ascii?Q?Iay+FHWrQXzKC785S6IslAMe52E/ICofy91J7QrNXQMT1RDcJDcVgev6uxFQ?=
 =?us-ascii?Q?olhPSt4ZkfOkIRXTMGiRCCabpQ0pXSnnrJ1flbsyfU9Bs3zSaMFUHWKWd+nh?=
 =?us-ascii?Q?2c8OySlf6MGLN+oZqXh/TzFBW+cTg/9TEns3hc1onOJiM4L0yxPuOCHtKNGF?=
 =?us-ascii?Q?OC1DLRsxm5UGqsgc/i0sxwUf12zLyOmXH2OsOAOS0fLK8jcF2lX5BLr/cjE4?=
 =?us-ascii?Q?EdZaYHUTwZAuyspf3EZULRtFzpav9RcmL0sb09cmTxD16iEwMV467SgJuFoH?=
 =?us-ascii?Q?Gcx1fraoyerctdEYFCwH6qiU9xNJIctwGcHxMIvVz6bkclbZZzA5XSF0DOse?=
 =?us-ascii?Q?+kWgsu4XFt563N/4HnV859IOnFTtdignvtxfC07lKulzmE2Y7B7hQ7ozN0b4?=
 =?us-ascii?Q?vH8bPixgfQuVxnyL7UIJtNCgV5tJgGcdFRQTfPPknpwVkvci2rFD0OHvFww2?=
 =?us-ascii?Q?dA5MwgR2Y9Az7gdXTc9sdRpH4cmAxJKru472cU52CNaWmMDHTFx5Ud1nvsft?=
 =?us-ascii?Q?nKlbbQwpFgtFxV9lvAM9HqoVBBIUUdmx5L8uD73LyFiLYKzFXeedLgqjVx9G?=
 =?us-ascii?Q?u237DjS1wec9YzgV75ofqNMlTmhlIp2puPXUwsxmdE1nwyAOyyQfw2wyib+e?=
 =?us-ascii?Q?n0Ca+0MF8V6cTRPVevOgLBIhtNmmnZojH9pRzkxVUd/NxRs8VTTa8P0D/9Xp?=
 =?us-ascii?Q?/X6WIbeNNlS8XXAB4Hl3Ur27T4Def0VumfmtdSnV?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e793fce-039a-4ba5-83d0-08dc6d8464f6
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 04:24:17.8277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6BzEYhmKUdbb/fYMz5vOHsnjMwKLDVWqcc3ip/BdZoFKmz2OpDtne7apAiLncVJ0bmB535a/pZTt2Iajw8lhIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6531
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Wed, 1 May 2024 16:49:24 -0700
> Ira Weiny <ira.weiny@intel.com> wrote:
> 
> > Jonathan Cameron wrote:
> > >   
> > > > 
> > > > Fan Ni's latest v5 of Qemu DCD was used for testing.[2]  
> > > Hi Ira, Navneet.  
> > > > 
> > > > Remaining work:
> > > > 
> > > > 	1) Integrate the QoS work from Dave Jiang
> > > > 	2) Interleave support  
> > > 
> > > 
> > > More flag.  This one I think is potentially important and don't
> > > see any handling in here.  
> > 
> > Nope I admit I missed the spec requirement.
> > 
> > > 
> > > Whilst an FM could in theory be careful to avoid sending a
> > > sparse set of extents, if the device is managing the memory range
> > > (which is possible all it supports) and the FM issues an Initiate Dynamic
> > > Capacity Add with Free (again may be all device supports) then we
> > > can't stop the device issuing a bunch of sparse extents.
> > > 
> > > Now it won't be broken as such without this, but every time we
> > > accept the first extent that will implicitly reject the rest.
> > > That will look very ugly to an FM which has to poke potentially many
> > > times to successfully allocate memory to a host.  
> > 
> > This helps me to see see why the more bit is useful.
> > 
> > > 
> > > I also don't think it will be that hard to support, but maybe I'm
> > > missing something?   
> > 
> > Just a bunch of code and refactoring busy work.  ;-)  It's not rocket
> > science but does fundamentally change the arch again.
> > 
> > > 
> > > My first thought is it's just a loop in cxl_handle_dcd_add_extent()
> > > over a list of extents passed in then slightly more complex response
> > > generation.  
> > 
> > Not exactly 'just a loop'.  No matter how I work this out there is the
> > possibility that some extents get surfaced and then the kernel tries to
> > remove them because it should not have.
> 
> Lets consider why it might need to back out.
> 1) Device sends an invalid set of extents - so maybe one in a later message
>    overlaps with an already allocated extent.   Device bug, handling can
>    be extremely inelegant - up to crashing the kernel.  Worst that happens
>    due to race is probably a poison storm / machine check fun?  Not our
>    responsibility to deal with something that broken (in my view!) Best effort
>    only.
> 
> 2) Host can't handle the extent for some reason and didn't know that until
>    later - can just reject the ones it can't handle. 

3) Something in the host fails like ENOMEM on a later extent surface which
   requires the host to back out of all of them.

3 should be rare and I'm working toward it.  But it is possible this will
happen.

If you have a 'prepare' notify it should avoid most of these because the
extents will be mostly formed.  But there are some error paths on the actual
surface code path.

> 
> > 
> > To be most safe the cxl core is going to have to make 2 round trips to the
> > cxl region layer for each extent.  The first determines if the extent is
> > valid and creates the extent as much as possible.  The second actually
> > surfaces the extents.  However, if the surface fails then you might not
> > get the extents back.  So now we are in an invalid state.  :-/  WARN and
> > continue I guess?!??!
> 
> Yes. Orchestrator can decide how to handle - probably reboot server in as
> gentle a fashion as possible.
> 

Ok

> 
> > 
> > I think the safest way to handle this is add a new kernel notify event
> > called 'extent create' which stops short of surfacing the extent.  [I'm
> > not 100% sure how this is going to affect interleave.]
> > 
> > I think the safest logic for add is something like:
> > 
> > 	cxl_handle_dcd_add_event()
> > 		add_extent(squirl_list, extent);
> > 
> > 		if (more bit) /* wait for more */
> > 			return;
> > 
> > 		/* Create extents to hedge the bets against failure */
> > 		for_each(squirl_list)
> > 			if (notify 'extent create' != ok)
> > 				send_response(fail);
> > 				return;
> > 		
> > 		for_each(squirl_list)
> > 			if (notify 'surface' != ok)
> > 				/*
> > 				 * If the more bit was set, some extents
> > 				 * have been surfaced and now need to be
> > 				 * removed...
> > 				 *
> > 				 * Try to remove them and hope...
> > 				 */
> 
> If we failed to surface them all another option is just tell the device
> that.   Responds with the extents that successfully surfaced and reject
> all others (or all after the one that failed?)  So for the lower layers
> send the device a response that says "thanks but I only took these ones"
> and for the upper layers pretend "I was only offered these ones"
> 

But doesn't that basically break the more bit?  I'm willing to do that as it is
easier for the host.

> > 				WARN_ON('surface extents failed');
> > 				for_each(squirl_list)
> > 					notify 'remove without response'
> > 				send_response(fail);
> > 				return;
> > 
> > 		send_response(squirl_list, accept);
> > 
> > The logic for remove is not changed AFAICS because the device must allow
> > for memory to be released at any time so the host is free to release each
> > of the extents individually despite the 'more' bit???
> 
> Yes, but only after it accepted them - which needs to be done in one go.
> So you can't just send releases before that (the device will return an
> error and keep them in the pending list I think...)

:-(  OK so this more bit is really more...  no pun intended.  Because this
breaks the entire model I have if I have to treat these as a huge atomic unit.

Let me think on that a bit more.  Obviously it is just tagging an iterating the
extents to find those associated with a more bit on accept.  But it will take
some time to code up.

> 
> > 
> > > 
> > > I don't want this to block getting initial DCD support in but it
> > > will be a bit ugly if we quickly support the more flag and then end
> > > up with just one kernel that an FM has to be careful with...  
> > 
> > I'm not sure which is worse.  Given your use case above it seems like the
> > more bit may be more important for 'dumb' devices which want to add
> > extents in blocks before responding to the FM.  Thus complicating the FM.
> > 
> > It seems 'smarter' devices which could figure this out (not requiring the
> > more bit) are the ones which will be developed later.  So it seems the use
> > case time line is the opposite of what we need right now.
> 
> Once we hit shareable capacity (which the smarter devices will use) then
> this become the dominant approach to non contiguous allocations because
> you can't add extents with a given tag in multiple goes.

Why not?  Sharing is going to require some synchronization with the
orchestrator and can't the user app just report it did not get all it's memory
and wait for more?  With the same tag?

> 
> So I'd expect the more flag to be more common not less over time.
> > 
> > For that reason I'm inclined to try and get this in.
> > 
> 
> Great - but I'd not worry too much about bad effects if you get invalid
> lists from the device.  If the only option is shout and panic, then fine
> though I'd imagine we can do slightly better than that, so maybe warn
> extensively and don't let the region be used.

It is not just about invalid lists.  It is that setting up the extent devices
may fail and waiting for the devices to be set up means that they are user
visible.  So that is the chicken and the egg...

This is unlikely and perhaps the partials should just be surfaced and accept
whatever works.  Then let it all tear down later if it does not all go.

But I was trying to honor the accept 'all or nothing' as that is what has been
stated as the requirement of the more bit.

But it seems that it does not __have__ to be atomic.  Or at least the partials
can be cleaned up and all tried again.

Ira

> 
> Jonathan
> 
> > Ira
> > 
> 



