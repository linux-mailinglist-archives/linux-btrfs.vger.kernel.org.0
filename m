Return-Path: <linux-btrfs+bounces-3843-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47837896010
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Apr 2024 01:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B18641F25104
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Apr 2024 23:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B2F47A53;
	Tue,  2 Apr 2024 23:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DkTxymig"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1686E1E531;
	Tue,  2 Apr 2024 23:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712100309; cv=fail; b=Q9jNagmuV3QiBRS+B4+ZjK/s5gnB1q8i48tCmuBY0mplMWsqyzevE5lQsgEe+Dl+HEogWB9zP/nKVNtcYEmdDGUvPYotSDUuVyE6dF+B255v/Ld0hXnS7weO6gCQTmoTImYpG3sEzC41x5iE3g+MSVzPzJuhMypc588QxtCXkx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712100309; c=relaxed/simple;
	bh=CLThJF/hKW5Y9WtsoJpmX7gOXfa6DVcNoOHYFfVbCLI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QWruVXdyIW7pgKr3XnFdTjsUORzhbRsSs9Fk4WH8tWj0RypGvDi8/MxD6qSec+u9ndD6lJEZBePYfQLPwq7HDAs0OCRUrHIimJ2RGBEKDTgJBoUhfsDFZQ2Qx4z6ljkjUDifG23Bfhe6dAHfZGaLqH+xBDpff4oADt8OWPiNdzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DkTxymig; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712100307; x=1743636307;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=CLThJF/hKW5Y9WtsoJpmX7gOXfa6DVcNoOHYFfVbCLI=;
  b=DkTxymigTsNWYZQbBYX2NsYI/zKJtVcHZ51+LI6ShHROhznobcREvTL+
   NIB3YxH0fQynQ4GB+JzBP5nJ/Xw2Ls5DbBp6BsDTqV2/M/J0tfrNSQKVa
   xhY7vmGH6eN8VUDN2R+SMPt1Ot4f7TS2mgaxTOTbQN0nocBQIpHFVfe7w
   kCQagIpyoAHE1DSNohh0R7WiA9lWtDBL2SzC4meMsNh1tUSWMeS5sK5hQ
   EqEj4B3p+VQj56LdG/1mUXnvwp1KLuPI9jneqXpTYZcSG7Q1ryjYGptoD
   jT1iXqTuByAMeegCk61IcrccSHtovSBFaEpaeeBnFSWkXc5g+c4eiWBvk
   g==;
X-CSE-ConnectionGUID: +EdGDpG6S2W4BlIi4ZXB0Q==
X-CSE-MsgGUID: PI4gmc1GQhCLgZPE9UPCGQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7148848"
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="7148848"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 16:25:06 -0700
X-CSE-ConnectionGUID: hXbcOjnoQ9uYesF0IUOTHQ==
X-CSE-MsgGUID: fLZIRbqNTtuRKrystXi6Ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="22923732"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Apr 2024 16:25:06 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Apr 2024 16:25:05 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 2 Apr 2024 16:25:05 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 2 Apr 2024 16:25:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kz0GJ+139mtlkS1znnzPxfH5bgHBcCbo4v4fK2RZkCJ6zm5EC93Grybe6hlm64dltqNJ5pEN6xzj4GwnV1iur0vdekINIulXkXTj6kxpZPifRIeV2xCN06l288aIn2Au4ZLd47PfVpG3zSln+QwZvu8ZO4N7lkI++9pO6CeEJoEi9WcXpmIY8HmOKJmZa1aDlmOqfxw7QQbPfNGCpU/T0L+6bs75DsPbu5eWZXdL0K+nc7uhtlZnam4msABNH7a6525DekarALx/MFmJExly6P09szeDJ+deyCBfqtUxKMewjiDpQbdL1kwMPnXhf4LnFoSM/xWJJzb0cbukkbqKQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l6sGcEY96244eMMnkxZnecG50imT3+/FRUWVhfaESw8=;
 b=Cn4xsF4oosvWDzK1hzv+r9dJShelbqsbEFfC+kRThzsUkn6hW9zt8qrDoy1aVnkxLMaH8kjO7wNHTl4pyb9aL2nfIXmZLSuKvNiev2D13uT0yiDHfig8JrWRGlZMzO8ou544wI8+86XpMNJlydk5mue2Lxcwcaj7xuST/GFuQAimYETz0Gp84bZq2dZisckfxiANzAMtZPEFEYUEbWOgbub78yjHjRgFUg3MkeXzHDis/v1EA0sxDDC7xvjN1plv5g88MbtjNBxECXWD0KxQ+aTRqFNfqpP7+1Tuch1scztxRLyUHtroP9pCgj8MApiIu065PlwsUTjXvcYkmTuLFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DM4PR11MB6477.namprd11.prod.outlook.com (2603:10b6:8:88::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Tue, 2 Apr
 2024 23:24:57 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e%7]) with mapi id 15.20.7452.019; Tue, 2 Apr 2024
 23:24:57 +0000
Date: Tue, 2 Apr 2024 16:24:50 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, <ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Navneet
 Singh" <navneet.singh@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-btrfs@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 02/26] cxl/core: Separate region mode from decoder mode
Message-ID: <660c93c2b2623_8a7d0294af@iweiny-mobl.notmuch>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <20240324-dcd-type2-upstream-v1-2-b7b00d623625@intel.com>
 <20240325162010.000036cc@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240325162010.000036cc@Huawei.com>
X-ClientProxiedBy: SJ0PR13CA0194.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::19) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DM4PR11MB6477:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HmU+1kiwskDiwqiCKQ3ObJ1CFXhYrVZw0epklnBvrJRLePLn2tKKjCDr9ijzjSXClznslHlr3UVtVjR+KEzuYLumW6t8d7QGTkZpxB3s/frN5qSxBe8j5aEKaecPY5FaR1h34jRlUofkXP+jR1/7cj4ZRzCEKLZuJ4O3y6kGezayombvJ7/CiQvFfelka6DNi9pygdwq00CX23CXUK4fhx23YQ/cipXoZ23oop6rIZRTDASwNidKVyEYVsOJpqRWKWXYbXqC0NxHIvp+MhMHVqyRd6pzCDRH0KLaqdHyVGgQz8dZ/VCyCO0vKTytopt4C/pbCf2bjfUtF0O7YxuwgfBbv75KPAUFXQ9FrLBK4k8FOnaSaNH67Qr/lT2KRAgPpGY+q4Tc3rlUhClQzQpaJ+jHlxAGZ/KhzVohJJU0qktnPeZNN+FCco8VJcbJgMTZNIOcdzFnoVGt+taAN0OnPl2PCB25nVpwLdgNouepTifKyAUpTgVpAQat9RfeAIVekaM0+lzcErTgZfww7ne8f1qyZU04BrjfNCqf9rDT7Fh2kNeiqqtGZJ3oiWBMeAKLDtCvd4jJFQ6pD81izbenjuT4ckhf4M6gkIaeczPgEqfrp4QgbZHnZ7uUL/8qaacquOkxeTmmATLv8cRMNquivc+2r3qUDg+Tt8AQCcUqHWg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yKvOB+zzaXBFJ7Qa1Z4uNEka0kRtKCcHQRzM0uhXrTWbmi5Yj+NeGqdsmBOe?=
 =?us-ascii?Q?fro12SXGFB2fkyzI61e6YIGflxktps3w3rh2QjrETz7VzXC0ri1/sOM3H+JF?=
 =?us-ascii?Q?iMBkncF+ADBEA0cTeMl+jcpVcmxzjFJKh+3KYqUKqp+4ztWGT8mwx2jsz+/J?=
 =?us-ascii?Q?/4oWlZbY1uFz9/IdlyBZLwWo97l4RkRUIUFMUBC9iFZo2a18fApi/mlLpOAb?=
 =?us-ascii?Q?2diOb6Q+hw2MlEQCFO7JMFENV1QVkp+iQnYsl9JAFnF2zXuTMqvqxluFWWfJ?=
 =?us-ascii?Q?reyHI1rbU2r3kIrywB77WJkk1ChDTeE2UiqxydLwB0Yk5VSxcB9MhQJoJKkP?=
 =?us-ascii?Q?B/XegpbMqWqWk/0xK/NSOqOcfrU4QxZLGxTKfGV5u/dKAC6iqFLb9OO2pUTX?=
 =?us-ascii?Q?CuyaBN+iZIqylkzZbefC78gFWr8Vn0xpqEB/EJBWyk9PTWrRITe8i/ZIx70e?=
 =?us-ascii?Q?OJMlNq11XJ0QdpQBHFAbBjSK3u7XSr/Y7mDuXujWwU6mC/HrjdaaaOgOpFrI?=
 =?us-ascii?Q?vqAiDpp1zedIPdxWx160LqXOTulLPuvwYgyR4sOlqAXAYeZxW9oFGUGMC3Du?=
 =?us-ascii?Q?AaVC/2tsNQYiu2yJ6XtaoPczdH5Fcg6OlplDEF5KI8wbvZPRYX+BpOSMfVjN?=
 =?us-ascii?Q?+6IvkYTVp9Aw3/4s11/SfJ4aKw8IAmhgSoOsRfT/aW7ZYmNnf0z49LjjTuqG?=
 =?us-ascii?Q?HN+aGESid86u+8eWDBs9KjsBijxuTuRUdxPtqBwViJaTZREjMY6R6GJ1wiwQ?=
 =?us-ascii?Q?AacXcqrHufo74slXT8ZfAQgO1Pr0xCVuL/rMKxycEnLt44vc4WHNOxiKwmVS?=
 =?us-ascii?Q?z22DEEnZQbreW5a4M8A35bZLeJ+5DoRAqjSuKXjRGaiUsb1A6yejH/nlTfKz?=
 =?us-ascii?Q?f1DPgitOHYLjeg0iFhR1S2UGFUKBzdDtNaMBjqUBrRZ5Bv1OZRMEXEmL9bnX?=
 =?us-ascii?Q?nsrT8hhlw4S1DrweFKLLstCtE1iprR27ET/dFtTiI6HVduMoW6Dizz/7xYb4?=
 =?us-ascii?Q?VQL+hbF0m5aKBqplYHZKV2FG+3K3/Deqbhs2PszmZ05epZJ3cc3KLqx9aaBP?=
 =?us-ascii?Q?fTp3C2tJGKBD4KcwZSb8absMlesw6Dosisf7hcHqKEoI4T9TF0Qk0EcVBQOM?=
 =?us-ascii?Q?Ffp7oHNmYcrh+aHNg3BDiYx09iFbDOlQxo3Ccut2kY6j9LROeWJcEQP15rIW?=
 =?us-ascii?Q?TG0v/lJ9kximyEVZA2PVClnEyR4e/P7YW+5X2hxqkGwnthAvRynC2uMnPQlc?=
 =?us-ascii?Q?HFM+KtzwQi28MurxEAdy+l8gIJgV8Jw8Tdo6YqxDH2a6qBCX5K/JSFBIEY/t?=
 =?us-ascii?Q?KUbMlZeEf006ZnCEkcef4jrR4szfk0eqsf/YTJRewTmtGNOpeNcangxZnDYZ?=
 =?us-ascii?Q?ptvG9Kbig67KTwOm2Rs4b8ebGnw067BBe7mRHPwyzzZFU0yjm4sGDZiOJPrh?=
 =?us-ascii?Q?fx9RdKay3DCyoD40Bwe7yZ7NzvIWdKCyhCa66011YYmENzqogSMWxciDcJ6/?=
 =?us-ascii?Q?zU/SwRDtKkaqWpBSugo5gc46WL7nCmB2zwmZ9lNwkprY2RGPmqKFqalga4O8?=
 =?us-ascii?Q?WgAD0M9zgjsTRwlRe7H1l5qecN3HxMqe+qYosSy7?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cb8f66da-0a57-43b9-8dd2-08dc536c1bba
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 23:24:56.9395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1SjFn+BBoKX7VstM+wL860/oDQrKJmfEn3wI6yQQ7bq52AUMhgVugsuorLB0oCn2cKQVqA8r5sjr8I3eICKAKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6477
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Sun, 24 Mar 2024 16:18:05 -0700
> ira.weiny@intel.com wrote:

[snip]

> > 
> > ---
> > Changes for v1
> > <none>
> > ---
> >  drivers/cxl/core/region.c | 77 +++++++++++++++++++++++++++++++++++------------
> >  drivers/cxl/cxl.h         | 26 ++++++++++++++--
> >  2 files changed, 81 insertions(+), 22 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 4c7fd2d5cccb..1723d17f121e 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> 
> 
> > @@ -2800,6 +2814,24 @@ static int match_region_by_range(struct device *dev, void *data)
> >  	return rc;
> >  }
> >  
> > +static enum cxl_region_mode
> > +cxl_decoder_to_region_mode(enum cxl_decoder_mode mode)
> > +{
> > +	switch (mode) {
> > +	case CXL_DECODER_NONE:
> > +		return CXL_REGION_NONE;
> > +	case CXL_DECODER_RAM:
> > +		return CXL_REGION_RAM;
> > +	case CXL_DECODER_PMEM:
> > +		return CXL_REGION_PMEM;
> > +	case CXL_DECODER_MIXED:
> > +	default:
> > +		return CXL_REGION_MIXED;
> > +	}
> > +
> 
> Dead code.

Fixed thanks.

> 
> > +	return CXL_REGION_MIXED;
> > +}
> > +
> >  /* Establish an empty region covering the given HPA range */
> >  static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
> >  					   struct cxl_endpoint_decoder *cxled)
> > @@ -2808,12 +2840,17 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
> >  	struct cxl_port *port = cxlrd_to_port(cxlrd);
> >  	struct range *hpa = &cxled->cxld.hpa_range;
> >  	struct cxl_region_params *p;
> > +	enum cxl_region_mode mode;
> >  	struct cxl_region *cxlr;
> >  	struct resource *res;
> >  	int rc;
> >  
> > +	if (cxled->mode == CXL_DECODER_DEAD)
> > +		return ERR_PTR(-EINVAL);
> 
> Not a bad thing necessarily, but why do we now need this and didn't before?

Ah.  Because in devm_cxl_add_region() the mode of CXL_DECODER_DEAD used to
return -EINVAL.

There is no logical equivalent to decoder dead in the region mode (regions
don't need it).  So this correctly flags the error based on the decoder
mode rather than introduce a mode for regions which does not make sense.

I'll update the commit message because that is hard to see.

> 
> > +
> > +	mode = cxl_decoder_to_region_mode(cxled->mode);
> >  	do {
> > -		cxlr = __create_region(cxlrd, cxled->mode,
> > +		cxlr = __create_region(cxlrd, mode,
> >  				       atomic_read(&cxlrd->region_id));
> >  	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
> 
> 
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index 003feebab79b..9a0cce1e6fca 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> 
> 
> >  /*
> >   * Track whether this decoder is reserved for region autodiscovery, or
> >   * free for userspace provisioning.
> > @@ -511,7 +532,8 @@ struct cxl_region_params {
> >   * struct cxl_region - CXL region
> >   * @dev: This region's device
> >   * @id: This region's id. Id is globally unique across all regions
> > - * @mode: Endpoint decoder allocation / access mode
> > + * @mode: Region mode which defines which endpoint decoder mode the region is
> mode or potentially modes?
> 
> If region is mixed, I guess that means endpoint could be pmem or ram in theory?
> Don't think anyone has implemented anything yet, but is the potential there?

Yes the potential is there.  The endpoint decoder is set to
CXL_DECODER_MIXED in __cxl_dpa_reserve().  But I am unclear how that will
ever be executed except if the BIOS sets up a decoder to span ram/pmem.
In this case the rest of the stack is not going to work and will complain
about mixed mode.

Ok Dan clued me in.  Check out cxl_dpa_alloc().  Spanning partitions is
not allowed.

So the comment is targeted toward the 'normal' case even though the region
could be created incorrectly via BIOS.

Ira

