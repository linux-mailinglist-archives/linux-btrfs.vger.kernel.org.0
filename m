Return-Path: <linux-btrfs+bounces-4088-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B205789E9B2
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Apr 2024 07:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 296FD1F242FE
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Apr 2024 05:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09B618AE4;
	Wed, 10 Apr 2024 05:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TsDigEic"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0882112E70;
	Wed, 10 Apr 2024 05:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712726843; cv=fail; b=p3FPXr8v57aEVcejpz0NjCSNCucbHYn/Q1rUqheaWTAN+UP2hnTZ5P3qVwuTu1BMRIZmw7WcRoHb0i3HtYP6ZLnfTPgYKSuxJpZyjzxCNRCEvvZzAaBJcoO9rwoirqmTif/9ciYsT/WMDzMQjYbsH0GKHrzTpGxbTNvjVtv9nIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712726843; c=relaxed/simple;
	bh=w50MShPcjhezW4TpH+/3kCNKQWop4JRJJF+9cc20gQY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KpU824zyjRp+FL4AtcdaOtOAskvEP4EpepbJUPTn+x6Iq+/bv9q0T5m7WSIS+ln+v+EsdW6uDgIv9eTu0jqT1cejZ/UR8m8+4Ob+PGq6diuvq9KtfPGUS/fkN2irxG+MCf22dH3mj5Jzw/6crGTXgUu4eSFytVuGtzW1O0rboaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TsDigEic; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712726841; x=1744262841;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=w50MShPcjhezW4TpH+/3kCNKQWop4JRJJF+9cc20gQY=;
  b=TsDigEicsq8161GWCrc4UGGrfxFh439Vj8/7bLkcZBOWG8aWlmItA6Xq
   x6vvioUDp+qbbXDndCITuQxyUeELxe9PNHSwsv1iEJ6X5YiZ1nDxQ4Nw2
   n6ZDWDluBD0iwTmTALobMtsKutWCK7Op8WJR/NXIJitG8OMvC9/mzwTac
   NjYlsT1mzRZn7cK+YxOyQPUDVY06f75wN4vpwSRkyEU73Gk5hPcTse60S
   nVDN+/Y/BlJoM+ZJIc18Sr0xeva5qbYsCNoZ4fAV8O+aZ2RsHUX9Ghdid
   /w6cMZ27kzf2mGyXSwMV+f5+Jd2VPyUU9S0ak9IR7PDqoSehsQvYQ2RYi
   w==;
X-CSE-ConnectionGUID: 3j3HGBb7Raan4UB1F5Lsgg==
X-CSE-MsgGUID: rGtfJhjCQw+xAmYoLDk52Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="11844663"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="11844663"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 22:27:20 -0700
X-CSE-ConnectionGUID: c9K23LPvQ7CVRZvLVODiyA==
X-CSE-MsgGUID: qlrQW9HcSiGY2PaBYHYmxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="25045376"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Apr 2024 22:27:20 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 22:27:19 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Apr 2024 22:27:19 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Apr 2024 22:27:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SLNFuoKsW/D08/DaXX0yHhOFp55JpfC6/9t+2n82CQuzlCIv8XMMrfCjjk4o5Nw+1yLti4yeDy/cpGEcM2pnPj2wWaT4d+4O6y6DqhHW4Wlvf0KH4tsSBmXniIMYSQFbZ5QCYgXT0g49SeurQUyg3jkqAl5YqjhvawZvsQS3dOL2a19snZk1Q2LYeWV+sd9zTTwZx0mZl193MFYtBWNJRl7D5YHTiPDRTpxEjJtTfZ/Q8GGW0YMvmvCqTTpOJ8YZN2OhCQKPBwJq64GQat0U6PwFNR2TIFqxPDw/gf1WeCw5ItnaLxKdJLNGtOztGm2Ohtj8eRZqvryftlD11J4N/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OkPNCiJnIgrxwWYuOf1M2vwVUNCLh7pnRo9jU+PDQM0=;
 b=jNMuuVVChZMvP18WAxidGkRE3nnqeXdSOdbE8MDPibGKTbhD+UmSTuABzSbi4RnJBOKx3BlaSnCc3z4DuO990BWJ2g38t7PfnhCo6qSiJ2Np0UdhgvMotZ76jkO2P5LKMBouILPpx8ksn+SF4nr+6vmICHO4GX3HZSWlV8Y2P96QYPaRA57YgW2026/SYlt1aaA72cx+WWb1VTJ8MuOQq8gYi/DcGB4snwAySFS9CI7Fpeq94oiCdsmphCnkAyziuUgf8p+24ClPntn+YaDZ6EghG273DEI5j4sjs+wW66HuwcYT8R5A8yPljsrb5gNdDTuEDf4KrWmk3kmxeWsPHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH7PR11MB6546.namprd11.prod.outlook.com (2603:10b6:510:212::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Wed, 10 Apr
 2024 05:27:12 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e%7]) with mapi id 15.20.7452.019; Wed, 10 Apr 2024
 05:27:11 +0000
Date: Tue, 9 Apr 2024 22:26:59 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <ira.weiny@intel.com>, Fan Ni
	<fan.ni@samsung.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	"Navneet Singh" <navneet.singh@intel.com>
CC: Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Alison Schofield <alison.schofield@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, <linux-btrfs@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 13/26] cxl/mem: Configure dynamic capacity interrupts
Message-ID: <6616232345637_e9f9f2944@iweiny-mobl.notmuch>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <20240324-dcd-type2-upstream-v1-13-b7b00d623625@intel.com>
 <918e6a48-10e1-42c4-86aa-ddd63d785e16@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <918e6a48-10e1-42c4-86aa-ddd63d785e16@intel.com>
X-ClientProxiedBy: BY5PR17CA0021.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::34) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH7PR11MB6546:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5BSlwA0NWXWTf7YVknNiDYtnx1y7RNVkql2G/M1W3VHUOglZIjh07Crbbflo2WzSPIUGX0Zlw78alD+r3JjycjsBZVf3GW+6gJ7stGNigJlVuUNJLn0QELczTSdtZp3/C0r/UCX7HPRZTHTNTL+5ZeqT8/Yiy9oGkdlToL+TLUrwgP7PQk89miUFGxEke8eo2hcKeG+wgqir4RBtW5RmP7QbVrRIq+wmJvXIW51zCzOW9y3OccBkk26HjxuisNJVhMDMKhBjHzVOfh44sRhEn2Gbb+5O0pkzGFjJGh0DfQT2oGANO1RfdL/5drtkPswQeaQhKmealgchwpg+L5qHgPX4l0eOPhHgp7FLJeIL4IadhVs9esYcccB4fvRX7F/8tzC1NhulW/iPOvlcM7FSlnSfunqOqjT9dCqSNHVOKnl7DWAfmkj37T9PeWa8878gNfpuhHGtakMEX7c8+SinfoTvx46BuNgHi7xqLzb8LiWbAFPTyld8Qe1eUgpqFT0V0SR+iYsAVsvxd0E80Lca4Yr9IAzVRXXfjvdCkrGy8HE+NIeBoLGF0r0LX8XVNl0PLjwIQRfiejwv3shDMfctId8YnitRGaxb6k5HHefA4+GPTpEo+HiDUmutnDFOwfRK9mTfP50+9EJPyRwrRTFSjzvhvs4LRfOmA2EQUjLAyK0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C/YxTKaSBNceg9HX7n13ZcffAbVXHxaum93Vtcy4EwHrSvvV/0GLA7HbVe2x?=
 =?us-ascii?Q?fXjlCASQib8zuAmc4PObjiqOCAVycH63/a3rHPeP8CbqGIxQuoknpp/4FQ5a?=
 =?us-ascii?Q?wIpc33wLSplfkIliYyrFAB1BEdouHBdknXXaMFC14NmaD9U7UdmEdhHxPFId?=
 =?us-ascii?Q?sXQiWiLHACwaM2UsNIE8ED5KBB0N8i/S9L5lt041rUoF2JiD46Leo2zmZ6W1?=
 =?us-ascii?Q?GZOtt2ua6EYfZ8KKCQcNTSjTEY8/4rKFQZMfn5YCL+rgYAAKW5HkYykhfFIb?=
 =?us-ascii?Q?t1jUsuVUx2o1kDPyfKz6HoGtkHC5cerQr0zEDZoRKUW38USSjwAM5hfSgTG/?=
 =?us-ascii?Q?Vns7x2tV1OlnBZWwGLRVu13OAa0xcfM3y9zX99Lp9j2U2K5GBX96toJM9wTz?=
 =?us-ascii?Q?DSquKTdBR6Q7ZFXlBO/Iw6LLTlZW+kkXnusmw3Cli2F9XPaix5rptXXEr6Pu?=
 =?us-ascii?Q?bjmfro9UPLaIjzPAnfoRV4LXPkz0ryHmt6YOGhdaSaovLsB38/CeSR0w5Igp?=
 =?us-ascii?Q?h1sg2uSUXApTTstHsUDasFAzEBVCXRHw7RY6084uUZ5CX5IRdhnM/obOqdbb?=
 =?us-ascii?Q?oobNyADs+qQysN/rOhOIX6aFBlU5ZVPuKAzVu7ma1QtNSgwVAWWgnVLmvWWs?=
 =?us-ascii?Q?nVh99vxNW8OYJGLfG6jZ7qRzs6KGAjD6VItAblTv6qbSVf06c7ZH6Mb5pDRh?=
 =?us-ascii?Q?y0ZzRVhg+CosrSPlejQq9gKYHLeNlAt7zUJr97w9C8ZoRzTfJdelId//xsdm?=
 =?us-ascii?Q?plGVyfn2cNKqDk7sUtsp0SRHPWoy8uoyIoDWsBPxZik7kEazpDCjzwJDd0lL?=
 =?us-ascii?Q?fu1NRxvtob+l7Xj5rGI6pc693wRcQKJOAD4hZV1oQQgfjh9g2tFKaU9F5FJm?=
 =?us-ascii?Q?m1TPnK2BS3YHwyGZY08j7vqhZN5o53syJ+ajMLNLizvVidJMSSIsZB0hultp?=
 =?us-ascii?Q?k6eivxjUgjZTxxPdIfMP0njsyANYFr1RILN3TjAnnb8Kmoml4WegfhuIPCjv?=
 =?us-ascii?Q?AX+WQkqx5gORbnhaBsYtATWqyoryyjjAKmcNZybfvBbHkXIgMHTOWRxIeqZs?=
 =?us-ascii?Q?4rsUbnacdZJVe9p3GmWaRvR/bJsIn1HR6STRuH4yrTmS3ts8FRvRGkeQB8rZ?=
 =?us-ascii?Q?uSYXHHXYO5pvfV1U0ecxj4R/B2fc0JE/lK97pkYBq08Bxb+JK2u+fSKV5vpV?=
 =?us-ascii?Q?N62bvqJRe/f2i1cEgJxVdIYsjA3zXpICoo3V6VRbS34ZvmH9u9sp1Ge7k50b?=
 =?us-ascii?Q?eVBJUhQ/sBRLzhFTsrId2Fjkaw593LmJc2PGrcRFwAq9YkD14p+Fjgk8NAeG?=
 =?us-ascii?Q?Cx0djqAb8tJId3kTEwKuRgvGuT60I0WqMQfnSQIzO7jZp3t7F4W4FlcS7qlF?=
 =?us-ascii?Q?up2E1D9fc0sAk/K5pq1ZkTcaUR2RnXMW3xw6lPrVwKSjai6uGH2Uo1Zi6F6v?=
 =?us-ascii?Q?ODQYjU08HnXz31WVuIfIX9jQ04WvOnWaCZ2eIxBojN5hCt/kmNf4rhhUj4rl?=
 =?us-ascii?Q?YamhlIspku40Apa+Bay5gyiCnUQKBYB7E+oQV9ac21wRoF9kPFuqmnHLTJaX?=
 =?us-ascii?Q?U4A8QA2izD2pGW81uUW5Mm4dVcFOmSvMhdHf4lJP?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 54283148-1f8b-4957-be6a-08dc591edf96
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 05:27:11.6291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5lyzqpH4kp+KSKN+5gRViwe3BXoP7Wi6/4onYKSZYhLSL9mfxdwaj2WKQ5fakKkryxHmIpl368IVWnc9vnvByA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6546
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> 
> 
> On 3/24/24 4:18 PM, ira.weiny@intel.com wrote:
> > From: Navneet Singh <navneet.singh@intel.com>
> > 
> > Dynamic Capacity Devices (DCD) support extent change notifications
> > through the event log mechanism.  The interrupt mailbox commands were
> > extended in CXL 3.1 to support these notifications.
> > 
> > Firmware can't configure DCD events to be FW controlled but can retain
> > control of memory events.  Split irq configuration of memory events and
> > DCD events to allow for FW control of memory events while DCD is host
> > controlled.
> > 
> > Configure DCD event log interrupts on devices supporting dynamic
> > capacity.  Disable DCD if interrupts are not supported.
> > 
> > Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> > Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> A few minor comments. The rest LGTM.
> > 
> > ---
> > Changes for v1
> > [iweiny: rebase to upstream irq code]
> > [iweiny: disable DCD if irqs not supported]
> > ---
> >  drivers/cxl/core/mbox.c |  9 ++++++-
> >  drivers/cxl/cxl.h       |  4 ++-
> >  drivers/cxl/cxlmem.h    |  4 +++
> >  drivers/cxl/pci.c       | 71 ++++++++++++++++++++++++++++++++++++++++---------
> >  4 files changed, 74 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > index 14e8a7528a8b..58b31fa47b93 100644
> > --- a/drivers/cxl/core/mbox.c
> > +++ b/drivers/cxl/core/mbox.c
> > @@ -1323,10 +1323,17 @@ static int cxl_get_dc_config(struct cxl_memdev_state *mds, u8 start_region,
> >  	return rc;
> >  }
> >  
> > -static bool cxl_dcd_supported(struct cxl_memdev_state *mds)
> > +bool cxl_dcd_supported(struct cxl_memdev_state *mds)
> >  {
> >  	return test_bit(CXL_DCD_ENABLED_GET_CONFIG, mds->dcd_cmds);
> >  }
> > +EXPORT_SYMBOL_NS_GPL(cxl_dcd_supported, CXL);
> > +
> > +void cxl_disable_dcd(struct cxl_memdev_state *mds)
> > +{
> > +	clear_bit(CXL_DCD_ENABLED_GET_CONFIG, mds->dcd_cmds);
> > +}
> > +EXPORT_SYMBOL_NS_GPL(cxl_disable_dcd, CXL);
> 
> Should these one-liners just go into a header file?

Yea they could.

> 
> >  
> >  /**
> >   * cxl_dev_dynamic_capacity_identify() - Reads the dynamic capacity
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index 15d418b3bc9b..d585f5fdd3ae 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -164,11 +164,13 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
> >  #define CXLDEV_EVENT_STATUS_WARN		BIT(1)
> >  #define CXLDEV_EVENT_STATUS_FAIL		BIT(2)
> >  #define CXLDEV_EVENT_STATUS_FATAL		BIT(3)
> > +#define CXLDEV_EVENT_STATUS_DCD			BIT(4)
> 
> extra tab?

It does not look like it on my end...  :-/

#define CXLDEV_DEV_EVENT_STATUS_OFFSET>->-------0x00$
#define CXLDEV_EVENT_STATUS_INFO>------->-------BIT(0)$
#define CXLDEV_EVENT_STATUS_WARN>------->-------BIT(1)$
#define CXLDEV_EVENT_STATUS_FAIL>------->-------BIT(2)$
#define CXLDEV_EVENT_STATUS_FATAL>------>-------BIT(3)$
#define CXLDEV_EVENT_STATUS_DCD>>------->-------BIT(4)$


Ira

