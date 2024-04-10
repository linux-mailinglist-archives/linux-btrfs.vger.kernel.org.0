Return-Path: <linux-btrfs+bounces-4095-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F8789EAD7
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Apr 2024 08:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D96A1F21D8E
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Apr 2024 06:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5005B29D11;
	Wed, 10 Apr 2024 06:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ithPrv49"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A147B8F44;
	Wed, 10 Apr 2024 06:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712730552; cv=fail; b=sgltyJqbsR92x0cglLlejOljT8yNrgMy0puwewMgUw0XuNYK+2C9vcpxk5uwrk/vfNewtz8qTE2QVJFFh5SPvit1MR4ENiEewiTxS4tb/R2DJkj6e1i2GOBl+HWcX2T0/iEuW29AVzPiQiGhw/psVOtap8dO4OxSs2zEYM24t3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712730552; c=relaxed/simple;
	bh=dyjigUqvRLsaMK0s9taibwmyTkaCgafUUR4cX200eQM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gAUKe8BmifFlAhEYNZJick3taQjRFj2yafE2dvhceH5uIDTBbE31R0QDaGA6BFSOxaKrIHRaBzwpfaII165CueTjKE1wwM0jg6EkCwlToV+kG31bCGvj48vReSrFIfyUN5mjvIqr4eNWBcvDJXJxUplBW4tWm1dXmb8J7fY/TCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ithPrv49; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712730550; x=1744266550;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=dyjigUqvRLsaMK0s9taibwmyTkaCgafUUR4cX200eQM=;
  b=ithPrv49U17XOXoYSCMxGNRkuES8u3LX0typ2xeTXmvJhz8uqW5DDugt
   dFPu14srHDttvAo8cUWHIDbxPyls+3xutJAQrorHw6oykkEcwV0yVk7g7
   o3zRtTaFaZz/dCfnLdYM+za8W775K3Ich5cpCT8AMxzwuPLE0bs2NodyV
   kCvvolDTqMXQmCbbiaf6izKd8bvnZv9pD9nVS1XaJXiNmz/A1anjckI7K
   RAHzF9qXYIFBVFGcLVErdFOOiR2IRUZtD153o2/InsIAPwHlsaLy2yeh4
   dgnN36C2DrN+dwuHK+UO52JWyG4VNJMuMGC3qZH/4jfNss61YWgD1IVfn
   w==;
X-CSE-ConnectionGUID: CTYO6F0aR32w1uf1y3FMmQ==
X-CSE-MsgGUID: WBghcSglToGLnJP0ZSRpRw==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8178135"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="8178135"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 23:29:10 -0700
X-CSE-ConnectionGUID: 9yIIf2oOSmK4yD8Hych3vQ==
X-CSE-MsgGUID: +UEzrKDaSFGmj3v3ssrYcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="43705422"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Apr 2024 23:29:09 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 23:29:09 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 23:29:08 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Apr 2024 23:29:08 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Apr 2024 23:29:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DRqdtO6o1/olgxgfGMitnw7AkZMgIzBeFlPimEFDJKMrodms1GIv1+pG4aiW2/sh7iJ5HiPKgLmv/cuRt5OCBz/Ceje4F9twu2eDAY5JboPHjfWl7yMQSHC86fU8YFt02laGzDb4L6zRujFS4QShKFUy3B/MDq6MZ6fmI1vQALhXRValkYCzEKLgfXm8xVGSGXtZRHwml/88GpR4IYa00VLusIYhqwRXxc/e6kKofcKud2/jsh8AzhnUVXA2HmNw48oyegByM+oKkILhb0KFeczi4h6zkFvqIiiHRg3tqrtAmnYNGaZP1Gxu9sbnSw1KagW+fCMOLD7npxtNM/2A1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7gwQA/93q6STX0o3050HV01qj5J/modreymc63yQ7Bw=;
 b=Y/aPg+edWn4eqHX13vt0jtgWmDKTxW7a/oVUX+RVb5zZKQr987n69yIx4BvTd2bLXjjONLDph2JFweuUochrwbxbJ4UWLquHZiq5LuV7D8gazEtimw4xEkPIWZADDnZ9nQheAMe0ZMybAzviffQoyfBlGzjiQGYwJP14IVKgsipRhtLy9bLoOb6Fc+iKAWvUU8Oq8vBght5NWnmWmuAKndtAvAbnkZRvXrAm3N61t5s/j9urOIgBKN2C8E5QuANjnomQqNAym3FIAA2jdyyiD0NDbRF+1HHlRp2kduk7D55Jk8ko9JR13291W4H3RnCIDfUjIgFTy4VpQOYvPiP4ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH8PR11MB6754.namprd11.prod.outlook.com (2603:10b6:510:1c9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.30; Wed, 10 Apr
 2024 06:29:05 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e%7]) with mapi id 15.20.7452.019; Wed, 10 Apr 2024
 06:29:05 +0000
Date: Tue, 9 Apr 2024 23:29:02 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: =?iso-8859-1?Q?J=F8rgen?= Hansen <Jorgen.Hansen@wdc.com>,
	"ira.weiny@intel.com" <ira.weiny@intel.com>, Dave Jiang
	<dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Navneet Singh <navneet.singh@intel.com>
CC: Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Alison Schofield <alison.schofield@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 14/26] cxl/region: Read existing extents on region
 creation
Message-ID: <661631ae232b3_e9f9f2947@iweiny-mobl.notmuch>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <20240324-dcd-type2-upstream-v1-14-b7b00d623625@intel.com>
 <33489603-3da4-498a-ac0f-8021df2150e4@wdc.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <33489603-3da4-498a-ac0f-8021df2150e4@wdc.com>
X-ClientProxiedBy: SJ0PR13CA0093.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::8) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH8PR11MB6754:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MBC52xx9PK17FkCUD0OC1pE0+J8MSAZKjSpV+1kleXzjcSadPnECg7pIQTNIXWWkJj2u+Lm5r2OxMCiiQaG9Pi+6A/oAd6hDjgo94xvwDwZpebYqGxXEXQvgh/zCuWaAS1O2UpllB/lKF8VLl8vvLvjLivD7op1hVuq3riI+H7rK3o8K6ldRJndM/hHyID/Rb970Jsw1Tg2yuJStUa/75B/xhdD5UQuMH2VBaKYijpMQHHxMXdfnrQPmmpme+ZxG3oVizFeRrMYJExDmenF1N7Gb5szXKxElSPjXYSt7vh+RB2HUeERtaZrCCNidKzmFS47BN9DnucsuH2/248HNxiMdlyQyndyz8870TK5yeB6BJA0o0rPxXEQIWJunMhzNM6vrUeCr9V+cfMwQkmuSZMKYw99FoRQMsyBo1B6zJ2qoG1W5sRRb1wqX4Hw2H5Wxaqn8076Nq5uo0qkdlRsjmlGmBEimdWuWlBYZcjnQ+jh5mpw903ClGRHkvOXfNHqvZ1HaM6HsBXGXh/OnnV7dz4axriuXZSK5i65OFDRVWt6xMYCChAw6oB/mLYNKEfEViaGYBgHUFhlfsbWd469O7HIQ1MWeMDHgp6K+z+6eEbPY1dlQ3RJpBWe8qNiaGO+1hZiyJcZLa0DI+2f27BEDuufMw3fYCBCSIKXBWPvWxug=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?GB+PXvtWrmBh6z21aTPQwo9X3zxs/nr6DQ0ls5T94RJHk2GXO5v8oG6QRe?=
 =?iso-8859-1?Q?+b3qA5XtcifemP0GeSyeYOgsTSzOmJIIV4whzCHRvE2p7eTyc8sK6fYrUu?=
 =?iso-8859-1?Q?nI20j/ZIXEiXsNULf16G549FK91twFjAvm7baDe4O/1DpWrJkuGeCqglQB?=
 =?iso-8859-1?Q?IazrP5WBRnrVNlNA47u/wyP+UJ+woiPh1cSbeMRXnlqTPRSA1VjoY0sYRX?=
 =?iso-8859-1?Q?2akzM252hii3yygZ1zOjyw4Ce4XSPEIhtmftCL6ETJWH/Gq0IosC5GWeij?=
 =?iso-8859-1?Q?bvW5UM3rLVqkLR7bgQoz8Xmdyh3Gopqy9zp8XtmMHrsiQ8+VAqiOyM2zbf?=
 =?iso-8859-1?Q?B7fAY04zewz8rixw7Bsp81vRO26jW0bDXQZ0bIiB2R6PuZ8/ZylSkdFxey?=
 =?iso-8859-1?Q?KrvTeqfpQChNnpv38hieMpaPXXi9U3NC5BT6c82ZTnSicT84djWTaJpPnz?=
 =?iso-8859-1?Q?5ru39BSdh4xhhltZcCC6ZmLBzL7CWZSY8ZorHt2icas2CbmorAX6mpYT4o?=
 =?iso-8859-1?Q?rLs84Wufds15C7DiAfdKHNWXXJLTq5RLAzzz32Ormd2IyyIHuEpi470lwO?=
 =?iso-8859-1?Q?Cvs8OyEZrlXAZBvtX4Zbz99AC1zyFLTVTPTRbxpTMqk8Xau1GbHNxAQdgA?=
 =?iso-8859-1?Q?zXHS5OL8B5uoKxdFy+kqnYlQOBpqIb3QdkKvsHePpSiBnAwwfxPlTXxXUQ?=
 =?iso-8859-1?Q?WWicLFdKicRpp4a+2VUxnM68NR9014Yxg1qAsFNSURWLeCz3I+6m8z32O5?=
 =?iso-8859-1?Q?ZieYo2CXoTmnaIz9AxrdnxSNkEvrxlND86/1NyDXnRdm5EewZa/fRrV9jj?=
 =?iso-8859-1?Q?3348BpKGkZemX7AvBOdWivXRb2zcyWAdfD0sgWXCpxbmfH+b2cQ0ssrtfO?=
 =?iso-8859-1?Q?OgWuGiOMTlgDLEqrVleNPuuneFF97zlj7gKbpwdZWGZr1XHM+hhQw7kvoc?=
 =?iso-8859-1?Q?jNDQLZQ4zbH43sTdk3s6sTF6oHZA/klhf4ZeQOY+oVrHNivi9JfXCj9FCM?=
 =?iso-8859-1?Q?+KH3N8AqZzmP+pgPmDT++191JUqSnEBbkX396DSwfT1T2SyUyEA2ibX9OI?=
 =?iso-8859-1?Q?hoIzh5otLKRpzzei27kdxTQCVdy6oYZnJrEMZWTNyeeIkdRrKi70Kw4Ilq?=
 =?iso-8859-1?Q?d8nuk8Co0OAl3WC89dZt1GXSey2URVdskY79u/Y4TmLUHcQFXInTxmxvru?=
 =?iso-8859-1?Q?Hvfa429rvDAs3a+PMsRXrph/+3Gu3Ez2mBaf3j1kiG6GUT40vg9s6S/AIU?=
 =?iso-8859-1?Q?PpCazuGOmk5wPwxVV19iltG4sDaJUgc/HdGfZfSkT1WCq5wsTXdEr/F7kI?=
 =?iso-8859-1?Q?flhK9xzrNG7alDhACPrdHqydVAOoo3fX2082RTyJ1wYuFx7FEZ8ZleX1EN?=
 =?iso-8859-1?Q?EZJPOqVahEU8iHq810BvayzmtDHkodDdD8opOEyRIH5D5WvS/vqoGeVjDP?=
 =?iso-8859-1?Q?9ZAAAbFNwr/KLZHdCKXrD78J2PriiuquzrkslB1VAIHaunRtADfp7cJglk?=
 =?iso-8859-1?Q?FJOlsrP4G4Gx+1PZcMRghrm40wnKedp2Fwp17ahXmMn93Wnl3m3zUh2lar?=
 =?iso-8859-1?Q?onYPEXaHOiOeVb8Dv977QEnLjexmYLC9o6poCg9kodvvmGc81YnxPikeQK?=
 =?iso-8859-1?Q?nxtCZqZ2kd+XjoUzR/dnCjSxaMDlIJqtYs?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e1049e2-235c-4c63-9741-08dc59278547
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 06:29:05.6156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w8IUQ3X9c0mTX4I0oPHV7MfNzqAhGBNbWfkPlMY4L03X6f0Rhbo1bUgkWh3y3Kj8RDu8vD+qHlFSwA4ttspzAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6754
X-OriginatorOrg: intel.com

Jørgen Hansen wrote:
> On 3/25/24 00:18, ira.weiny@intel.com wrote:
> > From: Navneet Singh <navneet.singh@intel.com>
> > 
> > Dynamic capacity device extents may be left in an accepted state on a
> > device due to an unexpected host crash.  In this case creation of a new
> > region on top of the DC partition (region) is expected to expose those
> > extents for continued use.
> > 
> > Once all endpoint decoders are part of a region and the region is being
> > realized read the device extent list.  For ease of review, this patch
> > stops after reading the extent list and leaves realization of the region
> > extents to a future patch.
> > 
> > Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> > Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 
> > ---
> > Changes for v1:
> > [iweiny: remove extent list xarray]
> > [iweiny: Update spec references to 3.1]
> > [iweiny: use struct range in extents]
> > [iweiny: remove all reference tracking and let regions track extents
> >           through the extent devices.]
> > [djbw/Jonathan/Fan: move extent tracking to endpoint decoders]
> > ---
> >   drivers/cxl/core/core.h   |   9 +++
> >   drivers/cxl/core/mbox.c   | 192 ++++++++++++++++++++++++++++++++++++++++++++++
> >   drivers/cxl/core/region.c |  29 +++++++
> >   drivers/cxl/cxlmem.h      |  49 ++++++++++++
> >   4 files changed, 279 insertions(+)
> > 
> > diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> > index 91abeffbe985..119b12362977 100644
> > --- a/drivers/cxl/core/core.h
> > +++ b/drivers/cxl/core/core.h
> > @@ -4,6 +4,8 @@
> >   #ifndef __CXL_CORE_H__
> >   #define __CXL_CORE_H__
> > 
> > +#include <cxlmem.h>
> > +
> >   extern const struct device_type cxl_nvdimm_bridge_type;
> >   extern const struct device_type cxl_nvdimm_type;
> >   extern const struct device_type cxl_pmu_type;
> > @@ -28,6 +30,8 @@ void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled);
> >   int cxl_region_init(void);
> >   void cxl_region_exit(void);
> >   int cxl_get_poison_by_endpoint(struct cxl_port *port);
> > +int cxl_ed_add_one_extent(struct cxl_endpoint_decoder *cxled,
> > +                         struct cxl_dc_extent *dc_extent);
> >   #else
> >   static inline int cxl_get_poison_by_endpoint(struct cxl_port *port)
> >   {
> > @@ -43,6 +47,11 @@ static inline int cxl_region_init(void)
> >   static inline void cxl_region_exit(void)
> >   {
> >   }
> > +static inline int cxl_ed_add_one_extent(struct cxl_endpoint_decoder *cxled,
> > +                                       struct cxl_dc_extent *dc_extent)
> > +{
> > +       return 0;
> > +}
> >   #define CXL_REGION_ATTR(x) NULL
> >   #define CXL_REGION_TYPE(x) NULL
> >   #define SET_CXL_REGION_ATTR(x)
> > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > index 58b31fa47b93..9e33a0976828 100644
> > --- a/drivers/cxl/core/mbox.c
> > +++ b/drivers/cxl/core/mbox.c
> > @@ -870,6 +870,53 @@ int cxl_enumerate_cmds(struct cxl_memdev_state *mds)
> >   }
> >   EXPORT_SYMBOL_NS_GPL(cxl_enumerate_cmds, CXL);
> > 
> > +static int cxl_validate_extent(struct cxl_memdev_state *mds,
> > +                              struct cxl_dc_extent *dc_extent)
> > +{
> > +       struct device *dev = mds->cxlds.dev;
> > +       uint64_t start, len;
> > +
> > +       start = le64_to_cpu(dc_extent->start_dpa);
> > +       len = le64_to_cpu(dc_extent->length);
> > +
> > +       /* Extents must not cross region boundary's */
> > +       for (int i = 0; i < mds->nr_dc_region; i++) {
> > +               struct cxl_dc_region_info *dcr = &mds->dc_region[i];
> > +
> > +               if (dcr->base <= start &&
> > +                   (start + len) <= (dcr->base + dcr->decode_len)) {
> > +                       dev_dbg(dev, "DC extent DPA %#llx - %#llx (DCR:%d:%#llx)\n",
> > +                               start, start + len - 1, i, start - dcr->base);
> > +                       return 0;
> > +               }
> > +       }
> > +
> > +       dev_err_ratelimited(dev,
> > +                           "DC extent DPA %#llx - %#llx is not in any DC region\n",
> > +                           start, start + len - 1);
> > +       return -EINVAL;
> > +}
> > +
> > +static bool cxl_dc_extent_in_ed(struct cxl_endpoint_decoder *cxled,
> > +                               struct cxl_dc_extent *extent)
> > +{
> > +       uint64_t start = le64_to_cpu(extent->start_dpa);
> > +       uint64_t length = le64_to_cpu(extent->length);
> > +       struct range ext_range = (struct range){
> > +               .start = start,
> > +               .end = start + length - 1,
> > +       };
> > +       struct range ed_range = (struct range) {
> > +               .start = cxled->dpa_res->start,
> > +               .end = cxled->dpa_res->end,
> > +       };
> > +
> > +       dev_dbg(&cxled->cxld.dev, "Checking ED (%pr) for extent DPA:%#llx LEN:%#llx\n",
> > +               cxled->dpa_res, start, length);
> > +
> > +       return range_contains(&ed_range, &ext_range);
> > +}
> > +
> >   void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
> >                              enum cxl_event_log_type type,
> >                              enum cxl_event_type event_type,
> > @@ -973,6 +1020,15 @@ static int cxl_clear_event_record(struct cxl_memdev_state *mds,
> >          return rc;
> >   }
> > 
> > +static struct cxl_memdev_state *
> > +cxled_to_mds(struct cxl_endpoint_decoder *cxled)
> > +{
> > +       struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> > +       struct cxl_dev_state *cxlds = cxlmd->cxlds;
> > +
> > +       return container_of(cxlds, struct cxl_memdev_state, cxlds);
> > +}
> > +
> >   static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
> >                                      enum cxl_event_log_type type)
> >   {
> > @@ -1406,6 +1462,142 @@ int cxl_dev_dynamic_capacity_identify(struct cxl_memdev_state *mds)
> >   }
> >   EXPORT_SYMBOL_NS_GPL(cxl_dev_dynamic_capacity_identify, CXL);
> > 
> > +static int cxl_dev_get_dc_extent_cnt(struct cxl_memdev_state *mds,
> > +                                    unsigned int *extent_gen_num)
> > +{
> > +       struct cxl_mbox_get_dc_extent_in get_dc_extent;
> > +       struct cxl_mbox_get_dc_extent_out dc_extents;
> > +       struct cxl_mbox_cmd mbox_cmd;
> > +       unsigned int count;
> > +       int rc;
> > +
> > +       get_dc_extent = (struct cxl_mbox_get_dc_extent_in) {
> > +               .extent_cnt = cpu_to_le32(0),
> > +               .start_extent_index = cpu_to_le32(0),
> > +       };
> > +
> > +       mbox_cmd = (struct cxl_mbox_cmd) {
> > +               .opcode = CXL_MBOX_OP_GET_DC_EXTENT_LIST,
> > +               .payload_in = &get_dc_extent,
> > +               .size_in = sizeof(get_dc_extent),
> > +               .size_out = sizeof(dc_extents),
> > +               .payload_out = &dc_extents,
> > +               .min_out = 1,
> > +       };
> > +
> > +       rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> > +       if (rc < 0)
> > +               return rc;
> > +
> > +       count = le32_to_cpu(dc_extents.total_extent_cnt);
> > +       *extent_gen_num = le32_to_cpu(dc_extents.extent_list_num);
> > +
> > +       return count;
> > +}
> > +
> > +static int cxl_dev_get_dc_extents(struct cxl_endpoint_decoder *cxled,
> > +                                 unsigned int start_gen_num,
> > +                                 unsigned int exp_cnt)
> > +{
> > +       struct cxl_memdev_state *mds = cxled_to_mds(cxled);
> > +       unsigned int start_index, total_read;
> > +       struct device *dev = mds->cxlds.dev;
> > +       struct cxl_mbox_cmd mbox_cmd;
> > +
> > +       struct cxl_mbox_get_dc_extent_out *dc_extents __free(kfree) =
> > +                               kvmalloc(mds->payload_size, GFP_KERNEL);
> > +       if (!dc_extents)
> > +               return -ENOMEM;
> > +
> > +       total_read = 0;
> > +       start_index = 0;
> > +       do {
> > +               unsigned int nr_ext, total_extent_cnt, gen_num;
> > +               struct cxl_mbox_get_dc_extent_in get_dc_extent;
> > +               int rc;
> > +
> > +               get_dc_extent = (struct cxl_mbox_get_dc_extent_in) {
> > +                       .extent_cnt = cpu_to_le32(exp_cnt - start_index),
> > +                       .start_extent_index = cpu_to_le32(start_index),
> > +               };
> > +
> > +               mbox_cmd = (struct cxl_mbox_cmd) {
> > +                       .opcode = CXL_MBOX_OP_GET_DC_EXTENT_LIST,
> > +                       .payload_in = &get_dc_extent,
> > +                       .size_in = sizeof(get_dc_extent),
> > +                       .size_out = mds->payload_size,
> > +                       .payload_out = dc_extents,
> > +                       .min_out = 1,
> > +               };
> > +
> > +               rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> > +               if (rc < 0)
> > +                       return rc;
> > +
> > +               nr_ext = le32_to_cpu(dc_extents->ret_extent_cnt);
> > +               total_read += nr_ext;
> > +               total_extent_cnt = le32_to_cpu(dc_extents->total_extent_cnt);
> > +               gen_num = le32_to_cpu(dc_extents->extent_list_num);
> > +
> > +               dev_dbg(dev, "Get extent list count:%d generation Num:%d\n",
> > +                       total_extent_cnt, gen_num);
> > +
> > +               if (gen_num != start_gen_num || exp_cnt != total_extent_cnt) {
> > +                       dev_err(dev, "Possible incomplete extent list; gen %u != %u : cnt %u != %u\n",
> > +                               gen_num, start_gen_num, exp_cnt, total_extent_cnt);
> > +                       return -EIO;
> > +               }
> > +
> > +               for (int i = 0; i < nr_ext ; i++) {
> > +                       dev_dbg(dev, "Processing extent %d/%d\n",
> > +                               start_index + i, exp_cnt);
> > +                       rc = cxl_validate_extent(mds, &dc_extents->extent[i]);
> > +                       if (rc)
> > +                               continue;
> > +                       if (!cxl_dc_extent_in_ed(cxled, &dc_extents->extent[i]))
> > +                               continue;
> > +                       rc = cxl_ed_add_one_extent(cxled, &dc_extents->extent[i]);
> > +                       if (rc)
> > +                               return rc;
> > +               }
> > +
> > +               start_index += nr_ext;
> > +       } while (exp_cnt > total_read);
> > +
> > +       return 0;
> > +}
> > +
> > +/**
> > + * cxl_read_dc_extents() - Read any existing extents
> > + * @cxled: Endpoint decoder which is part of a region
> > + *
> > + * Issue the Get Dynamic Capacity Extent List command to the device
> > + * and add any existing extents found which belong to this decoder.
> > + *
> > + * Return: 0 if command was executed successfully, -ERRNO on error.
> > + */
> > +int cxl_read_dc_extents(struct cxl_endpoint_decoder *cxled)
> > +{
> > +       struct cxl_memdev_state *mds = cxled_to_mds(cxled);
> > +       struct device *dev = mds->cxlds.dev;
> > +       unsigned int extent_gen_num;
> > +       int rc;
> > +
> > +       if (!cxl_dcd_supported(mds)) {
> > +               dev_dbg(dev, "DCD unsupported\n");
> > +               return 0;
> > +       }
> > +
> > +       rc = cxl_dev_get_dc_extent_cnt(mds, &extent_gen_num);
> > +       dev_dbg(mds->cxlds.dev, "Extent count: %d Generation Num: %d\n",
> > +               rc, extent_gen_num);
> > +       if (rc <= 0) /* 0 == no records found */
> > +               return rc;
> > +
> > +       return cxl_dev_get_dc_extents(cxled, extent_gen_num, rc);
> 
> Is it necessary to spend a device interaction to get the generation 
> number?

Not completely necessary no.

> Couldn't cxl_dev_get_dc_extents obtain that as part of the first 
> call to the device, and then use it to ensure the consistency of any 
> remaining calls, if any are necessary?

... However, this is not a critical path and the extra query to hardware makes
the code a bit easier to follow IMO.  There are 2 distinct steps.

	1) get expected number of extents and the current generation number
	2) query for that number whilst checking that the gen number is stable

Doing what you suggest results in special casing the first query within the
loop which is kind of ugly IMO.

That said, with the new retry requirement Fan pointed out I'll consider this in
that new algorithm context.

Ira

