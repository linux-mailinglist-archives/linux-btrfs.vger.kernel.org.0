Return-Path: <linux-btrfs+bounces-3983-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A01589A5B0
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Apr 2024 22:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1029F28305A
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Apr 2024 20:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433D3174EDB;
	Fri,  5 Apr 2024 20:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O7Y9F/Kz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23591C6A8;
	Fri,  5 Apr 2024 20:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712349279; cv=fail; b=SZc1r47kFFhl2WlYIrG+bGCthwmVxcwuItAIkdbCCpQMZCmw1zcSj/PilNkuv9lZerQenH0iBbKPaAMANcXLp0GY+nYKJHSvAwAq/Fn/7hL2/3oR2MvKtvpZxJRbu7TJwmrq9GBFVLcPcAdXEORluUQEPEyuFEaDExRKLOjKnBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712349279; c=relaxed/simple;
	bh=rb4d+uItvZhxjN/FrnjmVNOinAsqpHT2TogqihCQ8v4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rNC5eEANogFt8y0P1ji/PqpcBEGi44xbJnn/g1kVDiBLqHOXMs9ffyOFPvQ/KgSQuuKysfO0L1zmnikH6b3cOswPsruDvA1QpEn1IJpsTC7L5Hh0KVob0PkVkBqpnpP5tASswFs4gt42/HuQBOfk8vhR0U8l7jluoNtzqJD3SHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O7Y9F/Kz; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712349278; x=1743885278;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=rb4d+uItvZhxjN/FrnjmVNOinAsqpHT2TogqihCQ8v4=;
  b=O7Y9F/Kz1R0BA13JNIZZf3VgfPhF8gPvdKfFbncCk0DpQbJoP4zyyynv
   /Ri8uqWM2Wpm4I4yvZClnV/uoZcWE5M9dBS5WSdyecHK1z3uuhMFWuNqJ
   CMzN9cbjzkPhNpCupyTDN2rORmeF10gwg8HqYDQJYb+THhn5wnYqFMvqk
   QD7pie5pu1TwQSpE4ZSsQLYLLjX0yYE5ItqXh8MzApwhpiSJDHU+TilQE
   mVfgcGSHQzW8ySFuGsJEqqNK7iC7EbaFwJ+TZgLk8hsJ8JyF4ZtTanW5E
   r41Q8okODwmT4P98oBFLL4z8XSNgf47w02RmpAUXvCCYGmuanI3JW/bHN
   Q==;
X-CSE-ConnectionGUID: +5x5w9RBS7+numct4wwWTA==
X-CSE-MsgGUID: aEXI/hiCTSCrWLFAyYVAvA==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="18426246"
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="18426246"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 13:34:37 -0700
X-CSE-ConnectionGUID: 75clTShnQOiZQ7rdjNP6eQ==
X-CSE-MsgGUID: eNCv+S1yQYGA3rFhKKpXLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="23768375"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Apr 2024 13:34:37 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Apr 2024 13:34:36 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Apr 2024 13:34:35 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 5 Apr 2024 13:34:35 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 5 Apr 2024 13:34:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jbAc9OU4tx8Vrw7UrXpko8FEecP2ZCxvDF+nSphDfmfcE8X4WocNpF3MDwW6jbhXwwFILj8ExAi17Il2DJ/H1kyIv+IZlc3x8ZwESMjXvCbt1WtADPqeYUsnXB8OeUG37f1A1mszlX9x3IdvTlABSYpAiWhgPgC7N2SqL7PUsyU8QCcSIWT6vRZrM29khJupumg1IE4QS3+A653eFlrCNEclI8pawSJ0BtE72xD6s+4ceXJdQZr9C2jeW/7y2W0pk0QASwdASDIK2c6GAMnoDfbfqR/bu0GiO14IrbcwN3A/xvQmY42dvIHYu5QS89gBnvtAup9W5dJf8OLKuYauWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OL/oUOwL/gJ1wkh2wun5jX9Omm7JN8bGiYUZswHS0vA=;
 b=Fm2dsbIPT5sgmGPPg+z1nvFPUeR4D1iSn0oyylmmEv8voTYMnHUaMweofZgxof6d7JMnn2vTrIjc0iUKS0w7xntvnw9a90kUtHTubRdHOVNHvdVE+SQetdJ94gro9FGORbo0iC0/SaQktcJzPC5x2NPdLvnlburQYwEn3xuXov+4nN/ySHhsuTSvqn4VNP+tJTBiVjqc7ckfBizJcUr4j7nRKXEyObDxVaO3ASH03w9NoigtRG4NYyyyBtdMoKPY6+YDJ6gnidglIr1mgyMlH9dTE3gBb5WcHVShFB/erfnYAFXI5+R8KzK3bjRqbVgQOA3KhQJyxfXpt7JhiY14ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by BN9PR11MB5305.namprd11.prod.outlook.com (2603:10b6:408:136::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Fri, 5 Apr
 2024 20:34:31 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e%7]) with mapi id 15.20.7452.019; Fri, 5 Apr 2024
 20:34:31 +0000
Date: Fri, 5 Apr 2024 13:34:24 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <ira.weiny@intel.com>, Fan Ni
	<fan.ni@samsung.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Navneet
 Singh <navneet.singh@intel.com>
CC: Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Alison Schofield <alison.schofield@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, <linux-btrfs@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 06/26] cxl/port: Add Dynamic Capacity mode support to
 endpoint decoders
Message-ID: <6610605049149_e9f9f29439@iweiny-mobl.notmuch>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <20240324-dcd-type2-upstream-v1-6-b7b00d623625@intel.com>
 <891efc78-4f4b-494b-8c51-4f15db68ef23@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <891efc78-4f4b-494b-8c51-4f15db68ef23@intel.com>
X-ClientProxiedBy: BYAPR03CA0020.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::33) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|BN9PR11MB5305:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RG6vMMxddM6KGv13+j4Dcrf0pMR74D5lrJzLekGKINYxMA1zyXeWrYOoxetFrOzJ6Eb1inmTKw2tYlmGoiOHVGXQm02iNWvo0leL1ieB4bW2/hh3uECAIJ7hWLB8dxa8lMKMbu2f3EhUAA00BnsbbcTvLHPu84IKDyRqGHBbNJFX6VxnPWRkrBlzE4+zf8vIA8SLvQJeIwJxzYORR2IcQEJwxs8K4wn2d6P0UesrzTnOrXx1M7j2cBV2yV75wi4rvtx5DXJaPc84vDRSFgXuLqw/kWmT1C7dQXA09MlIMCAvDfAqoI8Jah/CZESgPMnO4UMv3fTn/v0tgSObH3crcIk0STQor18V11U7GTiHJffXU1aBSI3Cjp2WSC4+u8sSik9nY0atr6xyqzIc1XgAp1ZEFFLbD7TnhTXxSExyRFFBkyvLTcpL1HKk5qEaojE4CaFvKulfYBdHl3LEj2NwRE4AAY8YXFYxlli0UydDuHPFVdYbruVudWMxKT2iCsaB/TR4ZQW3EGE+tGzmyDMBoe8X0fEouZxpRybu0IHBnZmO7prL+u5Z9cc36Heg8LWl64CUBW75mACQZ4ZX9Q15Kqi6fc5GQOCT+J/EQoa4dy9ZPEmgfsEFwbzanmUKyUFRu3lYIggpmGkWMvhUrVuXFauYFluRmQ9dF508DcrsTbM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+5k6f5yF7vaGRQJlCkrADSQk3POYqmIjN9P2j1yUTuK9C0YCk98V8fg5PfYY?=
 =?us-ascii?Q?SVQWojRx1wWqxS26yTKwf945Fh63vRZ8Hi7dCsfkXkv8fI1LTGcWJcQxAJMA?=
 =?us-ascii?Q?nzeT/LCo8rNGqDepSDh1y7ocwa4Z7mvxBrTZCy1MjWoEXi5j6G2FJVYprGxh?=
 =?us-ascii?Q?AVucChMt7mqWHJW0lyofJ5Qhcgolg5cI7mTXBkfEO2nxUMSyGFzv+Y2KpLwH?=
 =?us-ascii?Q?gpVLbGbPTrnII74mCLIlZhHju/u7nyE7fobcRfLd9qPvkv/N27durOGhfbjF?=
 =?us-ascii?Q?S1B3vFqgWKvQQjbWQxFaU+ZS+xtEVOgRmApxdhgs0k8rwkQiW+NVRpDqw4OM?=
 =?us-ascii?Q?9gCnfIqFVHzqLWaPQFKt+1Fiye+ALIVWf2UmZVATnNVAtcp5OtvQJCdjCUQd?=
 =?us-ascii?Q?WgBv8d06uVhiYjM/n+5m3+9pn1UMLrQ4dUwREef8I0j3oMvPFeR4aHGTNGvV?=
 =?us-ascii?Q?Gik/4V1IHIPTMe5w0XpU3NOwfg5NFACZlc5nnG/EGFCJXjq7qprA4hHhoOPF?=
 =?us-ascii?Q?Eib4WRCsLSILNCAZACBROdNnGx/OX4ceMrbo/e0QMuDOP6IMT52WAn+Vf6fX?=
 =?us-ascii?Q?yjf3rkz63Ag/HKVH38TKA9Ugfqo4w1RkHWRD0ztHhiHyg3F7MicdMrFym/hE?=
 =?us-ascii?Q?wyYFjan7H77bz/uym4AlGC9jcweUhFa9HjOUDBk9u9CkE+HllOAhnl5JH17z?=
 =?us-ascii?Q?KfRkbJDJtBPCkKVRgWUv0Pn+uXQV8EF2TEIpRcxwD2/CmqmzzKPeYp4Cq0RT?=
 =?us-ascii?Q?Oa2CqfEuJMGp1x3s0VYq0S5crzp8Tg9Z5lTKAzz6hjfB1sHOWruD62Goaiyd?=
 =?us-ascii?Q?pAVZGYOJmGwB8iENZMZTvfk3nC7WSwyv+kSW3QPIzr6nfCd13TwHXzjPiuOK?=
 =?us-ascii?Q?3OlMrKS3ZnJcDdTxVHQy7HOuCFVHmdmuTgOkd6Smjk51aIoynX0XS8F4Lrx1?=
 =?us-ascii?Q?HWGEnaMJueh0mEtjZC6GWcJh4kMA2bfGspVVPnlwB7o7YI2YUmx4e9l18VuN?=
 =?us-ascii?Q?TiPBqniOYdPgWww5o4KtGYFRsx6qO1wL9rvKNm/jgcaLGvXKVRi3mTZOT1hl?=
 =?us-ascii?Q?Jl3MRtwjLwfo+ARpy64vca4pmQAVfoTdUcjZIBiNaDTf3c/tAVcx75bvPelM?=
 =?us-ascii?Q?u90we18ugyRyFH92gyiRb3fMLAG0MWNgzRYlCNJPF1cF0hsABUtqpDamxkaV?=
 =?us-ascii?Q?60Coyt/qY2EFrj+cqITLn/zrY4rUB2AdxrF8hd1UvDuIld3NrQdzUfPrw5Va?=
 =?us-ascii?Q?iYDpSJX6zZSUIyHeZkNHbSydURX6IU0WEYGyqTKHSV1Hu748LFqZKOCI/nX2?=
 =?us-ascii?Q?kfc6jTVs2mvClDCtqVSCaE/Ofq2DKDMH1eYNFYUjohHLUc/UcauBOngy0NOC?=
 =?us-ascii?Q?Ifqg/13OZZ6/qSyuEEO3B1y9LacAL2T9i0caz3DDmJisQRw56k+GEl+jrQp2?=
 =?us-ascii?Q?sxIrsk1Q1jit7QvYdgPF/Go/GRyG4KX9JQbzzRP9vQi915G45M+tjirYZt2i?=
 =?us-ascii?Q?sPBuHFs/NL+QyD0A3eNeLQIr4/E/LlaycBgzSufXqW2cBwdL2aqd6P/ZpqU3?=
 =?us-ascii?Q?qjZX9kaxNqg4rj5hUzJl5g7d9wwHrQBB2oZbYmjy?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 023a8074-c0df-4b68-b10e-08dc55afcbef
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2024 20:34:31.1704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lI2hj6rU0jqiGSYu3Oto9iNOjjv0wfuq52f60BMoscQRrC3q0PNzA3CDCFfud5zpjl04svV+BITTSrXU/liitw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5305
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> 
> 
> On 3/24/24 4:18 PM, ira.weiny@intel.com wrote:
> > From: Navneet Singh <navneet.singh@intel.com>
> > 

[snip]

> > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > index 66b8419fd0c3..e22b6f4f7145 100644
> > --- a/drivers/cxl/core/hdm.c
> > +++ b/drivers/cxl/core/hdm.c
> > @@ -255,6 +255,14 @@ static void devm_cxl_dpa_release(struct cxl_endpoint_decoder *cxled)
> >  	__cxl_dpa_release(cxled);
> >  }
> >  
> > +static int dc_mode_to_region_index(enum cxl_decoder_mode mode)
> > +{
> > +	if (mode < CXL_DECODER_DC0 || CXL_DECODER_DC7 < mode)
> 
> I second what Fan said about readability here if you do (mode > CXL_DECODER_DC7) for upper bound check instead.
> 

Sure...


[snip]

> > diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> > index e59d9d37aa65..80c0651794eb 100644
> > --- a/drivers/cxl/core/port.c
> > +++ b/drivers/cxl/core/port.c
> > @@ -208,6 +208,22 @@ static ssize_t mode_store(struct device *dev, struct device_attribute *attr,
> >  		mode = CXL_DECODER_PMEM;
> >  	else if (sysfs_streq(buf, "ram"))
> >  		mode = CXL_DECODER_RAM;
> > +	else if (sysfs_streq(buf, "dc0"))
> > +		mode = CXL_DECODER_DC0;
> > +	else if (sysfs_streq(buf, "dc1"))
> > +		mode = CXL_DECODER_DC1;
> > +	else if (sysfs_streq(buf, "dc2"))
> > +		mode = CXL_DECODER_DC2;
> > +	else if (sysfs_streq(buf, "dc3"))
> > +		mode = CXL_DECODER_DC3;
> > +	else if (sysfs_streq(buf, "dc4"))
> > +		mode = CXL_DECODER_DC4;
> > +	else if (sysfs_streq(buf, "dc5"))
> > +		mode = CXL_DECODER_DC5;
> > +	else if (sysfs_streq(buf, "dc6"))
> > +		mode = CXL_DECODER_DC6;
> > +	else if (sysfs_streq(buf, "dc7"))
> > +		mode = CXL_DECODER_DC7;
> 
> I think maybe create a static string table that correlates cxl_decoder_mode
> to string. Then you can simplify cxl_decoder_mode_name() and as well as here.
> And here I think you can just do a for loop and go through the entire static
> table. 

Ok...  Sure.

Ira

