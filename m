Return-Path: <linux-btrfs+bounces-4084-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D82489E8D2
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Apr 2024 06:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1186286FA0
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Apr 2024 04:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D3110A13;
	Wed, 10 Apr 2024 04:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TOxTdO1O"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4AEBA50;
	Wed, 10 Apr 2024 04:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712723147; cv=fail; b=NByNOnjnobmhVyJkt743n3chGx8yJtVhUQ6F6L8DdeDYPP7Jrf8W72qgLSa976blqLLgHxk+DZe/SV8C7E+JdYwceGVF6Igl5fg4ywFiDcXzvJdeoaw3YhRZNZIGHScgA1wXkTbER/c7kuDGFN+e1+PCxWupsMJfJyuYcGgdKTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712723147; c=relaxed/simple;
	bh=qrR9Xe4HHC0MT5hs6eNbG1X+3euS8WltuxsWsb5bIDQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZcP9dB7fgxQta0ymhgW6RzXepsuEP61uN3US0+Qr4NcGi/ItL2A8JOgnBuAXamxyOFSgQlx550J8xANQuf6lFYYLhiOgJXoQ70EpvHNDz6H63ZtfGGLu17BYS8FQOB09blu1VPilCarhMYJJM1yov26nL3vTWEwHrEJ8WZusros=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TOxTdO1O; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712723146; x=1744259146;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qrR9Xe4HHC0MT5hs6eNbG1X+3euS8WltuxsWsb5bIDQ=;
  b=TOxTdO1OpYlb9VTBklt31N9pEp5IVEWfE4MhgcOTF95JZc6h6Vz1Y12d
   zqNnGN6Tk6r/TsBJHHiPU35UePclH1eieDpkslCksOfYXU8IQnrKpuqX5
   aMyM6RZG6HLhlAT2ODcMhFMlxfFUw+aeVdjQelwnH7xD9mf2jzE9hgbyU
   TmmVttGd3pUAzaN1Not15FLh1JMnFZYMwONZAolph4c1YJWDfi/OPtuQs
   2xGhNsv9CTQ1iabAwaZaucdewCK+Qw238q5TeENqtvwnQQSgM6+b+M8Z0
   oZf3Sc6zhFjHdou3yPVLOe0Y00UD5o3YCbAwd5gSUQ15GfXK6M3XSAzW8
   w==;
X-CSE-ConnectionGUID: 6vZWXsliQf6Wfcr6hVDAww==
X-CSE-MsgGUID: I2CpvMTgRLqDGDyXb+h66g==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="11906786"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="11906786"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 21:25:36 -0700
X-CSE-ConnectionGUID: 4O1EbLc0TFaSsNEdxAslqA==
X-CSE-MsgGUID: ffgD1ViZSbW8GiVikusPcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="20526446"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Apr 2024 21:25:35 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 21:25:35 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 21:25:35 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Apr 2024 21:25:35 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Apr 2024 21:25:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kBnn1l1lY03oE7s6oIqmJ3Sa6twPmyJYQ1EPqoYRJntpBwzCPlh86P1j0eobqkojdHedgnohGj5vcPdhrQTX6/kDQHrQ/lTmHgbuo6FwCA5bJL/j2TQdBA/78u4H6bW+siVRI5flq5S/TsPTJRtB0qZJA513pNdLCwxfe/1HEAEnjp5VtcjHB8YWqUsYP89Ob4AMqFQSxSiaHcvNUwUaFQfe6EgRaSu9hCzcodD740/wlGIxnSeYbTA73nkfA2b+YhYVC5yyKUj2jdySwWglAdEq8reBG9BJx0lXSSPdASJ4bT+NvkPIwAz10Lo6DBH4SKL1D8RlfCEtHvE1B7IxUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4LNxSq4Cdk1xhLCssSyHqbMDY8TfZGifk9I1OeNOT0E=;
 b=diXjKS1uCLxyk5qVlewsU6FTGbyB4nNLh+oIXGlSVRPUQroJwHLwfwNiNPVSG3/NxwOrLWSbTj9jmAQgt5evxCle29LKwpfN6NYuWg9Zbw0DltMnFMvBPkys+ANa0etVgV5fqO/t7KvxDFCG0BuabMvCPLRrrLq8YjNJJ4tzmsQVT/qb/zDRJNlrkJ56RihzaQ/CQFDP4kZJRbYhedvPf2JdoBlz6iYLLpZK0QNr0vzpTwEj1nzyCceNmNTGJWQcLXKNqBPB5LuJAwoQzFnTSESuh4VOtvIzWJ25/YCdrPLtKzcFL6KkyLLinANi8h9pa1VablEZquhcLR40YROd6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SJ0PR11MB6790.namprd11.prod.outlook.com (2603:10b6:a03:483::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.10; Wed, 10 Apr
 2024 04:25:32 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e%7]) with mapi id 15.20.7452.019; Wed, 10 Apr 2024
 04:25:32 +0000
Date: Tue, 9 Apr 2024 21:25:29 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: fan <nifan.cxl@gmail.com>, <ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Navneet Singh
	<navneet.singh@intel.com>, Dan Williams <dan.j.williams@intel.com>, Davidlohr
 Bueso <dave@stgolabs.net>, Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, <linux-btrfs@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 09/26] cxl/region: Add Dynamic Capacity CXL region support
Message-ID: <661614b92b6bf_e9f9f29420@iweiny-mobl.notmuch>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <20240324-dcd-type2-upstream-v1-9-b7b00d623625@intel.com>
 <ZgNMz9doYO0KlgKU@debian>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZgNMz9doYO0KlgKU@debian>
X-ClientProxiedBy: SJ0PR13CA0077.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::22) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SJ0PR11MB6790:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7gK5Ceq01KvQ5YYuf/rury2bTBzOQQmJXs9P8MmL4nNPjs2F8r5EBzTkuLwA70CqAYF27Zj7GmFVg3qWMYfu85Iu1mtmHOBDmvMUyEBeRFSPZrYz/dw75aMx3I4J+ePe92e1gDM0rdaCjdYgWiv1YPvibXLXQ9C1sk+ybdnErn7oxlJYkjufWM0Z2tAld6Q4KaQBO30KCzgtm0MyAD4f1bWMr8h+BvlsoU7qauD/hOFwe42CaIxyfWhJa7lGehPIYh6GcznKYs/wsnkQiVlYqEiXYXBQpa31h3PxkF4lTUpEbtSgYEx/FrqJbL7kMAPPd1Piq2EPeiq/Drj77ek+lSCxeJuitRCkbmVZa3XstaoQBHNPGxGsxUXHD3Xlskuh3kfYBWhc8ytBqtydbjn+qK5C/Y+jevhpQFql0ziQrsSc5Xxp74yi9dpyBgH3Gn94qShDx11bpv7EVKdK+AkOUVukvnV1/j7e5ObOndKC/JMF0XVOdhiIRAd3Wz/KCNjYt3NoH1WIeDXMnjrC2nLwjcowV8/I88bdYzvZ5Qe1c0vPvu2cFK5/ZAR+t8nVoCoo3k8SkngFilszB7ULxJV5rvyzkdgV8tP/QjO1VcvgeonfggCq7zimKMtsfWB5K3aBhfeduRjalDbAfd7frN4fdWFEhVXw/gbEBbJTBxqC2/I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Rbx2jBSkBdnDKj0wMg6hJr1BSdCT68V/0MSR4CvwyW8AD2og3ELvFuM56mt1?=
 =?us-ascii?Q?bXM+/3XiOtya4DBvKNJa/056/omJgxNeN7exP1ZlzOfSwNuV4SFwkTv4M19X?=
 =?us-ascii?Q?651DPFeDqF3AkMbCffNG/0OBRdlU77J3ayyvFvqDz2s8nzimFM0R2Tv/5tvS?=
 =?us-ascii?Q?iOB1zJM7l13649gF0dJTuCULtGnTWBhLzIO7BF6lQFjP9uu293pH3G3SfNiH?=
 =?us-ascii?Q?6ggPm7oy+tE1X3CdNo0rRpXMZpqc4idBPcEYzNxj5+wpfPU2bLGHL4UqjvUp?=
 =?us-ascii?Q?d15OqpH29C4V9LeQhpooKl8Gwf5g80ViyM35+89Nx7Gr675DKDPqdcVbKv+I?=
 =?us-ascii?Q?jy9+sLfdF2A09NCZCZHxkOIyT5TP99lLgfYDi9RAtuvjyzFhq6kBKKL4wBjv?=
 =?us-ascii?Q?Wx0eWEc53A5RbTdAmcP5dWE6O4DkNUAoNBgD5sdxU/L/FtZHfo4KtyYXq1jf?=
 =?us-ascii?Q?5dDCmjyhsTle6OBAZUDPqHvyFn3awHTN3CNlXtAu9gbJsOHhhUQzmwRb9Z1F?=
 =?us-ascii?Q?GrJIWPNzw3akSoCQX6ne3GvOBHaXPcG0ztfFR0JfLKmIImK0INIu1kBcw5AP?=
 =?us-ascii?Q?Nop/fMMUqpvlXoVu1wdrTW41kAYCPlBpyfVex4e30Xw2b5MbxrTwx9wscKHa?=
 =?us-ascii?Q?3rXEMNI2sYLW5TJPeHt0GKUrpRID1QOm3Y3HfVX/AM/jlOhdJlxE3LbQ4/UA?=
 =?us-ascii?Q?j1AThtPv0lLDeLJ/WDbB9Q+WOxBXywWK4LLYoUWfFmyFLmuxNwkPpYw7uoIt?=
 =?us-ascii?Q?3BHEyyUIb9PJ3g2ekHDuhYeL57/3Di4X67J4BdNA63VAJC+yQLdAV/pAo39R?=
 =?us-ascii?Q?QSFqY4EpgYR6Kb4iq+10ANQoYArkFPbfIxJnLOnyVhP6gmETfmsMgKC1xCLd?=
 =?us-ascii?Q?nugW4TEuVx7QxLaFRHi+fdbR8bCsThj/azEtP7rO5XaxBDGWCaTC4j5//qFZ?=
 =?us-ascii?Q?u/AUWmOlw/9VqMklHEQlLkoxsx7xAi+6HHVD4wSbQxdkRPY1iiCFLn44gkDz?=
 =?us-ascii?Q?rnd0H1Zwiq2YoHqDj23N4l644cRHY4GcEtRAwWCzhiea4EquHKNKwevmKGJs?=
 =?us-ascii?Q?ZNT3cy1Grj577awoVvkbZSPrBoNkHpEZapSRSmYVQFYiJT1XG9d+COkp98eL?=
 =?us-ascii?Q?omS+0uRRterNei7m2+fU0qitxU2OxgG49bpDgHGOS7yZD0LPRfrVWYHgrotE?=
 =?us-ascii?Q?O5D+f3hwI5WImP6IBDf/mf4z3b11EVbfCl5PUrMynnTAMVTx+RQ4vP5vzZlC?=
 =?us-ascii?Q?LRuI2weKI99WQhBnYHMVAYEZeAdObofJUibzJIok3mwR4COeLdtMxj3U+ZUD?=
 =?us-ascii?Q?DUJ95tKemS+LQK6Q70qxz2s41/pZUM9iU3YIDpOHffcfDQPB4wvU06/R4vRK?=
 =?us-ascii?Q?vtoVSPR/qnOrcnOjVT5DvgbDqG6UGHVWU9wE+1pGq6yfosMwoOPpnTXw5kYb?=
 =?us-ascii?Q?xzLroikmqRHohZ4wvnoF+jOS72Tlk7CzsF8uS/qKBfK+pqTECv+L7vfWkiTv?=
 =?us-ascii?Q?8sOMYkUblG8/IspXU7Vz00psNgaWFhinQaDM1F13EYulzRqu0dKBcfkuCn+n?=
 =?us-ascii?Q?xvTPSIGfYbZwYqqiLp+yaFqU7/RNBjpYRuXtghPD?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c67c247-d223-46ab-8441-08dc591642ba
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 04:25:32.5083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ICDSWXLPB6mVGL4wvDTspRI+27DL8pwY6cp5UnNm+Tla92nv3cYi0GI6arRmdbzbKXUVJUUY2tkOiu2fyXdl/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6790
X-OriginatorOrg: intel.com

fan wrote:
> On Sun, Mar 24, 2024 at 04:18:12PM -0700, ira.weiny@intel.com wrote:
> > From: Navneet Singh <navneet.singh@intel.com>
> > 
> > CXL devices optionally support dynamic capacity.  CXL Regions must be
> > configured correctly to access this capacity.  Similar to ram and pmem
> > partitions, DC Regions, as they are called in CXL 3.1, represent
> > different partitions of the DPA space.
> > 
> > Introduce the concept of a sparse DAX region.  Add the create_dc_region
> > sysfs entry to create sparse DC DAX regions.  Special case DC capable
> > regions to create a 0 sized seed DAX device to maintain backwards
> > compatibility with older software which needs a default DAX device to
> > hold the region reference.
> > 
> > Flag sparse DAX regions to indicate 0 capacity available until such time
> > as DC capacity is added.
> > 
> > Interleaving is deferred in this series.  Add an early check.
> > 
> > Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> > Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 
> > ---
> > Changes for v1:
> > [djiang: mark sysfs entries to be in 6.10 kernel including date]
> > [djbw: change dax region typing to be 'sparse' rather than 'dynamic']
> > [iweiny: rebase changes to master instead of type2 patches]
> > ---
> >  Documentation/ABI/testing/sysfs-bus-cxl | 22 +++++++++++-----------
> >  drivers/cxl/core/core.h                 |  1 +
> >  drivers/cxl/core/port.c                 |  1 +
> >  drivers/cxl/core/region.c               | 33 +++++++++++++++++++++++++++++++++
> >  drivers/dax/bus.c                       |  8 ++++++++
> >  drivers/dax/bus.h                       |  1 +
> >  drivers/dax/cxl.c                       | 15 +++++++++++++--
> >  7 files changed, 68 insertions(+), 13 deletions(-)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> > index 8a4f572c8498..f0cf52fff9fa 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-cxl
> > +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> > @@ -411,20 +411,20 @@ Description:
> >  		interleave_granularity).
> >  
> >  
> > -What:		/sys/bus/cxl/devices/decoderX.Y/create_{pmem,ram}_region
> > -Date:		May, 2022, January, 2023
> > -KernelVersion:	v6.0 (pmem), v6.3 (ram)
> > +What:		/sys/bus/cxl/devices/decoderX.Y/create_{pmem,ram,dc}_region
> > +Date:		May, 2022, January, 2023, June 2024
> > +KernelVersion:	v6.0 (pmem), v6.3 (ram), v6.10 (dc)
> >  Contact:	linux-cxl@vger.kernel.org
> >  Description:
> >  		(RW) Write a string in the form 'regionZ' to start the process
> > -		of defining a new persistent, or volatile memory region
> > -		(interleave-set) within the decode range bounded by root decoder
> > -		'decoderX.Y'. The value written must match the current value
> > -		returned from reading this attribute. An atomic compare exchange
> > -		operation is done on write to assign the requested id to a
> > -		region and allocate the region-id for the next creation attempt.
> > -		EBUSY is returned if the region name written does not match the
> > -		current cached value.
> > +		of defining a new persistent, volatile, or Dynamic Capacity
> > +		(DC) memory region (interleave-set) within the decode range
> > +		bounded by root decoder 'decoderX.Y'. The value written must
> > +		match the current value returned from reading this attribute.
> > +		An atomic compare exchange operation is done on write to assign
> > +		the requested id to a region and allocate the region-id for the
> > +		next creation attempt.  EBUSY is returned if the region name
> > +		written does not match the current cached value.
> >  
> >  
> >  What:		/sys/bus/cxl/devices/decoderX.Y/delete_region
> > diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> > index 3b64fb1b9ed0..91abeffbe985 100644
> > --- a/drivers/cxl/core/core.h
> > +++ b/drivers/cxl/core/core.h
> > @@ -13,6 +13,7 @@ extern struct attribute_group cxl_base_attribute_group;
> >  #ifdef CONFIG_CXL_REGION
> >  extern struct device_attribute dev_attr_create_pmem_region;
> >  extern struct device_attribute dev_attr_create_ram_region;
> > +extern struct device_attribute dev_attr_create_dc_region;
> >  extern struct device_attribute dev_attr_delete_region;
> >  extern struct device_attribute dev_attr_region;
> >  extern const struct device_type cxl_pmem_region_type;
> > diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> > index 036b61cb3007..661177b575f7 100644
> > --- a/drivers/cxl/core/port.c
> > +++ b/drivers/cxl/core/port.c
> > @@ -335,6 +335,7 @@ static struct attribute *cxl_decoder_root_attrs[] = {
> >  	&dev_attr_qos_class.attr,
> >  	SET_CXL_REGION_ATTR(create_pmem_region)
> >  	SET_CXL_REGION_ATTR(create_ram_region)
> > +	SET_CXL_REGION_ATTR(create_dc_region)
> >  	SET_CXL_REGION_ATTR(delete_region)
> >  	NULL,
> >  };
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index ec3b8c6948e9..0d7b09a49dcf 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -2205,6 +2205,7 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
> >  	switch (mode) {
> >  	case CXL_REGION_RAM:
> >  	case CXL_REGION_PMEM:
> > +	case CXL_REGION_DC:
> >  		break;
> >  	default:
> >  		dev_err(&cxlrd->cxlsd.cxld.dev, "unsupported mode %s\n",
> > @@ -2314,6 +2315,32 @@ static ssize_t create_ram_region_store(struct device *dev,
> >  }
> >  DEVICE_ATTR_RW(create_ram_region);
> >  
> > +static ssize_t create_dc_region_show(struct device *dev,
> > +				     struct device_attribute *attr, char *buf)
> > +{
> > +	return __create_region_show(to_cxl_root_decoder(dev), buf);
> > +}
> > +
> > +static ssize_t create_dc_region_store(struct device *dev,
> > +				      struct device_attribute *attr,
> > +				      const char *buf, size_t len)
> > +{
> > +	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev);
> > +	struct cxl_region *cxlr;
> > +	int rc, id;
> > +
> > +	rc = sscanf(buf, "region%d\n", &id);
> > +	if (rc != 1)
> > +		return -EINVAL;
> > +
> > +	cxlr = __create_region(cxlrd, CXL_REGION_DC, id);
> > +	if (IS_ERR(cxlr))
> > +		return PTR_ERR(cxlr);
> > +
> > +	return len;
> > +}
> > +DEVICE_ATTR_RW(create_dc_region);
> 
> create_ram_region_store, create_pmem_region_store and
> create_dc_region_store have mostly duplicate code, should we consider
> extracting out as a helper function and pass region type for ram/pmem/dc region
> store?

That is mostly done with __create_region().  But the following is a nice cleanup.

I'll test it.

Ira

21:24:37 > git di
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index e8549af47da7..8a83a415fd0b 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2638,9 +2638,8 @@ static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
        return devm_cxl_add_region(cxlrd, id, mode, CXL_DECODER_HOSTONLYMEM);
 }
 
-static ssize_t create_pmem_region_store(struct device *dev,
-                                       struct device_attribute *attr,
-                                       const char *buf, size_t len)
+static ssize_t create_region_store(struct device *dev, const char *buf,
+                                  size_t len, enum cxl_region_mode mode)
 {
        struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev);
        struct cxl_region *cxlr;
@@ -2650,31 +2649,26 @@ static ssize_t create_pmem_region_store(struct device *dev,
        if (rc != 1)
                return -EINVAL;
 
-       cxlr = __create_region(cxlrd, CXL_REGION_PMEM, id);
+       cxlr = __create_region(cxlrd, mode, id);
        if (IS_ERR(cxlr))
                return PTR_ERR(cxlr);
 
        return len;
 }
+
+static ssize_t create_pmem_region_store(struct device *dev,
+                                       struct device_attribute *attr,
+                                       const char *buf, size_t len)
+{
+       return create_region_store(dev, buf, len, CXL_REGION_PMEM);
+}
 DEVICE_ATTR_RW(create_pmem_region);
 
 static ssize_t create_ram_region_store(struct device *dev,
                                       struct device_attribute *attr,
                                       const char *buf, size_t len)
 {
-       struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev);
-       struct cxl_region *cxlr;
-       int rc, id;
-
-       rc = sscanf(buf, "region%d\n", &id);
-       if (rc != 1)
-               return -EINVAL;
-
-       cxlr = __create_region(cxlrd, CXL_REGION_RAM, id);
-       if (IS_ERR(cxlr))
-               return PTR_ERR(cxlr);
-
-       return len;
+       return create_region_store(dev, buf, len, CXL_REGION_RAM);
 }
 DEVICE_ATTR_RW(create_ram_region);
 
@@ -2688,19 +2682,7 @@ static ssize_t create_dc_region_store(struct device *dev,
                                      struct device_attribute *attr,
                                      const char *buf, size_t len)
 {
-       struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev);
-       struct cxl_region *cxlr;
-       int rc, id;
-
-       rc = sscanf(buf, "region%d\n", &id);
-       if (rc != 1)
-               return -EINVAL;
-
-       cxlr = __create_region(cxlrd, CXL_REGION_DC, id);
-       if (IS_ERR(cxlr))
-               return PTR_ERR(cxlr);
-
-       return len;
+       return create_region_store(dev, buf, len, CXL_REGION_DC);
 }
 DEVICE_ATTR_RW(create_dc_region);

