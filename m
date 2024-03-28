Return-Path: <linux-btrfs+bounces-3697-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E77D88F71D
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Mar 2024 06:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36A1F1C244DF
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Mar 2024 05:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE26405FF;
	Thu, 28 Mar 2024 05:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dVV1bWx6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F9A386;
	Thu, 28 Mar 2024 05:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711603256; cv=fail; b=dOtrJf6Fo48nn+0JOsacGvBhdX2Z+aKVvh1YHjCc21PmPHEW+Ajj747iAvjPz1mXlBg0MqHgNTuWhHlWda9RLffomaIZJhuHwV4duy9H6wpPWcPzgSr2yzeqJI0ss4fwCBeD8Tz/h2W4DB25Wdqhx6Jmpx5vz89j6fuyzWOTEfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711603256; c=relaxed/simple;
	bh=kaTnCIOqo7oyFL08mwxiZhOmCVMwCikcDQvYxqeyRz0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tjEiKwz5YUwKa77/DoyWfT/CtUuOYoLhx8IWQCvvYA6Vs52zH1HZ418hyAR6QcDwM8a0QoK0zzDtmkMci926KkOdev3h6LbKlAxBc4NV+eFV2KcAJqEeFXE9kim0ei/1JDc4Voe7M2qlOLLg34yJcvWlLaPZS6VoWptCMjXGtls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dVV1bWx6; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711603255; x=1743139255;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=kaTnCIOqo7oyFL08mwxiZhOmCVMwCikcDQvYxqeyRz0=;
  b=dVV1bWx6QamsgvgkCiERzIRo9v5WFoHqDzQ1CcrCsOWu4URNWaf2E2Y+
   CNQb0zF7y8egqfaGZu7R/cBV91d3rU4RF4N/hCAC1g++ZCZzQNReBc/Ag
   KKLzAOmVNMDN/oIG+kyDmYLUum7F8e8SAiY5kPzzaYvcaT030dwbh3QoZ
   IKlbxu7KwLoCo3pMZMZY8VwRAi/V+OPOu6MiZ4M/AUuVlVU4v+RroqY4m
   YcffsQ7xXU0uycHSQNHe++CVrqbE2/DjlFGGz72hMFlo2udErd/tAec5c
   501y2d1Mst5T5PA5tNnERaxYL/Mrm+q+vbFusdFd4durX7sffpSXp1cGy
   w==;
X-CSE-ConnectionGUID: ECBp9nO+RKmlpb9kMaBKBg==
X-CSE-MsgGUID: WirowdJkRY6ORVL5g53lkg==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="6601848"
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="6601848"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 22:20:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="21177592"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Mar 2024 22:20:54 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 27 Mar 2024 22:20:53 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 27 Mar 2024 22:20:53 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 27 Mar 2024 22:20:53 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 27 Mar 2024 22:20:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TzsCGD74lQBJhGpe+mXsii1WceKcKhOELU3QG4tO5VPuwk6zYtHTo0aioUUE3V9rTR8tjVOKH3TrsNwbqDziHbKah4dT1zbn9x2Id0rKZbE9jPjvjHVmAqQ6iDDvx53p1ETGRwV+nzlY/c/2wARDVTtl1nKyKcbqyPlZKLVFqfdRRMYvnsLj0BUB29Jv/04qqnRIEY7Ha18waVFGZ2U8mx4WOJd0cYAU/4nXsLvpnCRg3L82gOARHAfk1tCXXUAyE9p19NxD0W+sZWJjiojyPPdTlnueCwHtlGS8pdrp+HOPcb0yljlX/2+8yA6Pv3BucJshyc8PzcQuEySYRS9NJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZLNtqWhFr4J1vu2Ywnv/3HwJu56y5y36vXp558PZPrg=;
 b=EBiEOwtO3CfK+TgACDFLIC26q+qo7QzE6KDGJxgfwNR7ayuEfW3tuyDDnn+jKXhindahymJLIPUIrxPVr9ZeU0KdIP4/2/xEkKiBRjg+E38dP65hrk6FLvVRHcyrMJ9cpYP19xfkDby+nhNNeGvkAOnSYaIpolqzjXgygv//MujP5YGqVKEqzt/msBQE4HmpLEVkIRFJ8U9ks70eLIA0JR2lL8Bt20IVFpSnTOTiCUk9yVXIPGtXS1HPJy4r77CpAoekvRLwxurJr5LolFawjH1HwNYmAf0UZ1EqXBlurxfyZ95A/GsjbO2qTXQKBBQDNiPm4jXB0HuQc4oie+bM5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DS0PR11MB8666.namprd11.prod.outlook.com (2603:10b6:8:1bd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Thu, 28 Mar
 2024 05:20:49 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e%7]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 05:20:49 +0000
Date: Wed, 27 Mar 2024 22:20:45 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: fan <nifan.cxl@gmail.com>, <ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Navneet Singh
	<navneet.singh@intel.com>, Dan Williams <dan.j.williams@intel.com>, Davidlohr
 Bueso <dave@stgolabs.net>, Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, <linux-btrfs@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Chris Mason
	<clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
	<dsterba@suse.com>
Subject: Re: [PATCH 00/26] DCD: Add support for Dynamic Capacity Devices (DCD)
Message-ID: <6604fe2dae8ea_2089029486@iweiny-mobl.notmuch>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <ZgHPUggTfSCIx8cI@debian>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZgHPUggTfSCIx8cI@debian>
X-ClientProxiedBy: SJ0PR13CA0151.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::6) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DS0PR11MB8666:EE_
X-MS-Office365-Filtering-Correlation-Id: b695ddfe-5e0d-446b-f638-08dc4ee6d471
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I2yleYLmP+MUuVnGzDGwTVuT6R6vu4YwLZXaI+0iiBrtqfemw2PL9TNmqc/rwbworEKUdtXXpyH0d4wxIPXV5X/0fYid1R6ZgOpr8e08Ohn17GV5Wp39e8dXEFPbRNuH6aOZGkfyqQkvWoo6oJfiS1Rx5AIX2w27MWgKKPH48oBJ/hk9351HyRTD5zVm6aYajqwCTd9OwrQd2PdzDHP2f63Us3cUtDki7FHwTet25fWRTCj++yiQ4h+vVZpK055Wbb1Ix01AXK/DOPXIzUUnWzxnEVKGIoNuhgx6xhB7lfl9+781cVa48Kw3awepsWIlOBqtqr4biD0+4DM2AnnKVK8yQLFbS6zrQNVcL4pX56r6NvFPoP+grYUT4Lq0sxp6PKKh85Iry/zEIv6yknymf09ublAKxcnO1tMf7lAg2Or+slTjngnPRCJav3oHxNfquGNLliqXe7oJk7Y6RKOLs1He64k32DB9vSxXUEzme4FZAwOe1GmtYhmME1CarP9FJV1jWOJD7tF7aphITEfZNErXyETCjJLSAyG0I1npnBU+BSlf92F1TKH0Ai1+C9BFGHKqrl1IyDOAM1UQlnBe1nWC2Hh2Asmh56BtULOyRXE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?suxrfL8oLtQxZAVpDUK3wmrMDdnxxXac+BZ+iV7z1GCMQ2oHRJKjNyKLQCtW?=
 =?us-ascii?Q?JBz35nfwYqjSmcURALb7dkTsL6KCDm8XkZ7JIuly+quKGqZ5dL/OiS7kIbAl?=
 =?us-ascii?Q?EPEoZNNuvF3aQQSt62/p0Q8N3prbtreu/j5j1BFFM1y9f66aCGsvfyD32Ikp?=
 =?us-ascii?Q?yBqPBF9VdAfsI7oLBAsWnv7FoiHC14VFcEYFoDjMRd401Obz7U/HQySBimNq?=
 =?us-ascii?Q?b/8y/WBukq2EAP0OZ7c3V6QsKrA5fBKkEa3VEBb+J1KGck+vhUzY4t8mycCK?=
 =?us-ascii?Q?XUQiyzsr1LbJV5faYUQiBlkPp3Xdq2uhOqE16GEf/BMOjdIiSeff4xCjxWUC?=
 =?us-ascii?Q?1FJrC+9vZF2HR6BSgrLhZU5X1Fvdk29U4FBD+PZbYZzb88lZmIiSNqtgvMCg?=
 =?us-ascii?Q?p8GlfuEeKbSmddjgOKvFF58MB4GOVOwpSZAUlqgDdVSdXrzBL9eBs8ss6hy6?=
 =?us-ascii?Q?GOEObY7w12ti4tQrmCJ7wSk5yypCfBNhU0pqpsg0CqqqCODD9UmzyiIgrX2N?=
 =?us-ascii?Q?oZHmUcHXo+HRWNYY4ZdTUEqRGGHxuTW233/PcighTFdlsfVFaecxImeVBhDb?=
 =?us-ascii?Q?9vIFF4eMRc6SJAS0qjCKlkNThqnVnttI8rp+gKNwDldJPqUT/25FwUYDqouI?=
 =?us-ascii?Q?0XIDm98SGdaiQ7E4JUyqN/efRualD6eaYZdtdJGJ4V1HdtOaL9rKL5uVLFjq?=
 =?us-ascii?Q?jRDnF7kRKWp0nSldqGTAhBbE7eNAz0oHmFoqCTwk9rzsaga51Hrf5oKCMDOX?=
 =?us-ascii?Q?VEbHqvUmoQiYeBFYQf9v264j7CACKGHlYWKEnmjyvYHgIi11DVu/LNmXulps?=
 =?us-ascii?Q?Izr18nBKla+L4M20mHWSYdoOowfXVraCYGhr3YpT4S+W3KVZ0p4wNX8DgLXQ?=
 =?us-ascii?Q?iJxETKqJpRK4PxJxLnp6TTv2sXrzDJo9yxGm1c4nO2t2lAGp1aqLwe6uzHIJ?=
 =?us-ascii?Q?6tfNK1hFV1CWXQa6i9NBwK16AO0eVpgydCbvjvK4MaXKUjOp4j0CtxKvwbrU?=
 =?us-ascii?Q?XwoAMOdLcNTWGrAczjx3DLUgsTNlN6i/3zOtfjnVB1pkyigo0o/PBkHALfkb?=
 =?us-ascii?Q?1/pLxwLxgzpztqBpi5VRjqeg5nMy+2TsJ+AGGmS6oyCeoxwjQE7hfDtS4pIS?=
 =?us-ascii?Q?qDWOQrFUwgHlC8vjdrdIS8B7B012xk/Cx+t6xHhhtBE/2SuvGH94Pno+jxfy?=
 =?us-ascii?Q?VHRwJTTL3UEhENba1ps8dBOwpTmMo04yotlK26RLi87SYyx9dohfv4mT9JUV?=
 =?us-ascii?Q?Mi8PWbJhelVxJeMJomiaFPz1P2VYvK9c7NAUwQLKYcEx4BQP+0JotFhqunNs?=
 =?us-ascii?Q?OaPF2CDuWuxkov/k4/74TDH9+NqL6pg1jlNxdqawKdfst8O0s+dis6DzUOQx?=
 =?us-ascii?Q?o+0GfyqSi2MFfyzSHj0F6VgQ7TwitgPpaME0G0Eul8YP8ek744JpZo8WGk6h?=
 =?us-ascii?Q?ZOrqkEI8johSa9t/H4a91iVcI/IHmHuNyeKjmdFXXULEZ2uCXp72e3F7d4VU?=
 =?us-ascii?Q?fEZMLXwXV4nCHYwUV3Y984xFTgBeBaJQ28mvwFlR811ziqvhm1qc28E+2vJ8?=
 =?us-ascii?Q?imJwSDzeffco/oxLD0aeEIQBxFlVZ3v6A7L+619y?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b695ddfe-5e0d-446b-f638-08dc4ee6d471
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 05:20:49.4329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VU5xiFKnH7pWgbAR8qx5ReoqhdBYzUDfZsC7b4iSfgwJaNSsryLd5hvsEqCfjJoBKpNBwNzXvBsf9hy8lmK05A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8666
X-OriginatorOrg: intel.com

fan wrote:
> On Sun, Mar 24, 2024 at 04:18:03PM -0700, ira.weiny@intel.com wrote:
> > A git tree of this series can be found here:

[snip]

> > 
> 
> Hi Ira,
> Have not got a chance to check the code yet, but I noticed one thing
> when testing with my DCD emulation code.
> Currently, if we do partial release, it seems the whole extent will be
> removed. Is it designed intentionally?
> 

Yes that is my intent.  I specifically called that out in patch 18.

https://lore.kernel.org/all/20240324-dcd-type2-upstream-v1-18-b7b00d623625@intel.com/

I thought we discussed this in one of the collaboration calls.  Mainly
this is to simplify by not attempting any split of the extents the host is
tracking.  It really is expected that the FM/device is going to keep those
extents offered and release them in their entirety.  I understand this may
complicate the device because it may see a release of memory prior to the
request of that release.  And perhaps this complicates the device.  But in
that case it (or the FM really) should not attempt to release partial
extents.

Ira

[snip]

