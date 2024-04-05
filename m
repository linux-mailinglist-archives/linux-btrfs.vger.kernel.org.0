Return-Path: <linux-btrfs+bounces-3984-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A4089A5DA
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Apr 2024 22:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40E451C212C4
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Apr 2024 20:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8484F174EE9;
	Fri,  5 Apr 2024 20:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P2Vqq/Cb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4ADE174EEE;
	Fri,  5 Apr 2024 20:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712350578; cv=fail; b=opAD0NJFj3xpI3H/qUYCYRBL0sh/MQB9b6fTvsm96jbUNVajETyU5Xq2fYEAuXQtqBH1ewXMmhq7g4y4vw/VKXv1bwLHN0mCnIRurfh/ZuDuvhkL8C14yaD+OEl9q8/CgqzAaukQvUe4RCwFSea9hZps1qJ6mlCDVaaLdtUcZIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712350578; c=relaxed/simple;
	bh=mxih+5h1wOVUHyiQ5ArwPpVv2+h4yrH2ysqButiFGVc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FFazH0x3Xp/veWvR3pPjhPKrGtFNGasc1NODT4JyW5gT/FznXFQ45vsMsVuKLxIY+VOoQSyO5wrVn8+l34U1VtAjNRa+c4Vcttmxgmvi2Q2uIM3Q2NK/84rXEwKUxfi7DNQZhdmhM+vZcRGAW8X9q5LZaoO9A5XwuLzOS/jopmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P2Vqq/Cb; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712350577; x=1743886577;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=mxih+5h1wOVUHyiQ5ArwPpVv2+h4yrH2ysqButiFGVc=;
  b=P2Vqq/Cb9WjY6JKpB1Qadq342/kwecJoOT5aCpKQc4w1VulSXkLkV/05
   4SAlQUnA4sYHItcL3s6EDs/32LlAOVMOC/tqxi7fyvDxUtVDodqc0dmCe
   rOZoUOm0ZtuyJ1AhLK0sS0EuhuZ/UnJmTLaF6XuH6FBP8HW5yDzVXUeNB
   1xgLJpyCG9aU6YLtBBi34qiqj8uHt5ihFWKvZLJshE/JSya4/73JcPQWR
   AggQztkL/6B7P8orP709HhIeR+4zQM4sQ0dvp6bJO10BIUAfUpJneK+cC
   ts9JNGpjEs55x5rRIzcxWx3ntZxWpkSLIphhOdOYFrX+SdinSayj5O142
   w==;
X-CSE-ConnectionGUID: ZpBzjt2PQPqj6Z1KbgxBfA==
X-CSE-MsgGUID: BKrX/BaESGSAusQiDoTQZA==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="25136354"
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="25136354"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 13:56:16 -0700
X-CSE-ConnectionGUID: JcCL7kDlSOOls9Tx1K7TUQ==
X-CSE-MsgGUID: qRYq2cBkRpa/KmF9WZop9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="24004805"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Apr 2024 13:56:16 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Apr 2024 13:56:15 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 5 Apr 2024 13:56:15 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 5 Apr 2024 13:56:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AVNEaTmVZej2xLnZ3hR/tZb3OqYrt69F1+ZjdSZ0rSwLTyJDy86d1IKao/AJWMkvz58PO+XYtA9a76kDEJMXk2R+LCbmt0fYdWiZnsB81QP9ZocLZ9CZaXC+dXSARdA8pbtNSOklPf6LgvAtkWbF2qo5Zj+Q49x7mqfBUnGXqJAwi+d2vedM/zJpMXrmm8qSy0UbTVxssuu+mwOgYTOeGqrR5jG7NpnD8xT2N5Rr7RXMV62JkRqvbCduzGZ76lbTJ3bpz1kk8BIRVoZNC1CDIKEPickvtPxq4XjX+k2E9QgSEctMLIZRqg11RMh22kHicZj+Z3VQw5W0i8YvPeqy1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kimK4qUH7nirStfZYkoOklyiowt7bybuyTrgPqCB2f8=;
 b=nz7dlbMpeoeKH+OU69L2FV0H+l+PtsHJ9ZjfGZmrhOBVx1DlMtZbq+Hcbe807yKUksXvAoSglpApOwSA+NQaY1jsfCTLpYYgmaPCTRtY4CM/PrPXMCUND9EH1QzKu5a+AN0PifncVEyAo8sgAkNqNHSBla0/rMXCVbn0/F26tw4Mg4mlsVFFNMvlO4tayBABRL50QvNNwEFw7oDuDusIuFbDF9WlwPdYlvKJ2JRsjb/9Q2pTcfM947Zwul5teE34YdaM6//FGZmCVTSpK9MvxZFDpMzDOSOppf+cDt2dhgcw3ti/K/0IQ+MA/Vj+53v7Qcz56ilcc+3wXywmick++Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DS7PR11MB6128.namprd11.prod.outlook.com (2603:10b6:8:9c::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.26; Fri, 5 Apr 2024 20:56:14 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e%7]) with mapi id 15.20.7452.019; Fri, 5 Apr 2024
 20:56:13 +0000
Date: Fri, 5 Apr 2024 13:56:08 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, <ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Navneet
 Singh" <navneet.singh@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-btrfs@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 06/26] cxl/port: Add Dynamic Capacity mode support to
 endpoint decoders
Message-ID: <661065683552f_e9f9f2946@iweiny-mobl.notmuch>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <20240324-dcd-type2-upstream-v1-6-b7b00d623625@intel.com>
 <20240404093201.00004f33@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240404093201.00004f33@Huawei.com>
X-ClientProxiedBy: SJ0PR05CA0177.namprd05.prod.outlook.com
 (2603:10b6:a03:339::32) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DS7PR11MB6128:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MTdZytPa0t0MiyCwRYUjxm/r1bDuNsg3fF6ULUTpd2BBMDu6/1VTUL2xgqwpvy/V914Z4Lmpf4X6PGsptG4driePtFyWO9AY6j4VnY37a5nFLX4omUidlAPxBFmZPC8Cfhn7SqHGX/acXQdUmGjdDaT4zouCPp1CKHzWEZXvhFpzh20sIUgA9e2GDCfQOyXEBQ/PbdlPZnkRAG/JJ1d2d1nwt8tUe3XHdKb2qokmItFp+7IEvnATFRR1l4by4AnSZVM1/s/VwfQhdFeiJ80BD3RPemkoAA8WvblaweFpQFAf3IMSdjM2xYnWwwfEOaLC77CuFsqCoHXJ+Q9ICqt0uYRIioJusqx+hLvXI2sAvwB4K1dK+Xf+yal64M3SOC3wXZfgJU7e/sIX4sWi76gJzF/noJCrtgna0oQ2A1eGGUHadohXd7ebsa/AuYq+jMXNuLqYLHrbuamv35L+SOy+QAv8pLWyPB4AQLt8m6qxfznWgrpfTJ2+BNIYDtUyEqqZye39mri073kyeqWZk5GNysA1XWjjr4XLysvy3eYGtt+w89R25tYEOVqztY/kZpgW5nIZTKquiYCB/Rs5sHXw9rEgd53D9uhutbo9VBCmrrsiWA8l/IHOXApqqFRWDZ47vgmfKkKdwgYSsH5Kaig1lvwHM55+FUQP4/OFMXOljVU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4CsX6b7SOwBRoFfw9N+I10Vx+GzJCyXKA6wiJupHbc3/UrfUN3MFDsVzLQpY?=
 =?us-ascii?Q?N4my7e+dIzCMV/4m9e4DToLICQKOZm0Demenu510lTWcEainOrG+iPg9VOtM?=
 =?us-ascii?Q?LPXEms/m/EEo8T2dL8yd50yAkU0DEIuHPm5vKKDeWqPplLBENY+hL276xCgI?=
 =?us-ascii?Q?1ayA8z42dzIbn4hRREbctz2UcpaW7COmsO6gbZwJhf+3KV5cUAGjDdgwZtYs?=
 =?us-ascii?Q?CLbJoz+dgHGpgNd9k2faELR9/ic2PWZqn9VsyoCSvYRyfmzUUn7y1FHtOBg/?=
 =?us-ascii?Q?8pcPhhsKkAkDD/08h5YJeH2/HKxwy+vLt5wpVTp2Mb9UotrSTdtfIK6Ysh9/?=
 =?us-ascii?Q?1Jc7M/cWYlTCvOXRjEz7JuxEz7ZOMS+NejRCA2T7JIG9L4NL4FYuWt6A6iCT?=
 =?us-ascii?Q?xm65Cq57g53B5xRp1VVHCvjTWgfhiLZM3jdDDSrHdNziy9K59NtMAYgLjqPf?=
 =?us-ascii?Q?ZSXSdfj45G+Dg9sBNJKaSNY0eyjw4QRLJl26Gym/BghFXLdXHbDNoJ1uvUDC?=
 =?us-ascii?Q?obPREtk89Jfltvs49Lm1utIswUVxrTu5YCHTw9a1LuemYSwAcV5SCuXmPE6u?=
 =?us-ascii?Q?KYu3S7g1tI4IeWklZw4zrHQ/50B0IpAROQI2ebZ8DMI50o90RE6CmGPjp7Gq?=
 =?us-ascii?Q?k/TuBnz0MYnvyVo4AQ5fOnFTztMiUDQhxRKVihZ/lgSNWNSxYxbeCOXBLM42?=
 =?us-ascii?Q?jotoMW6W/TX0EFdAXuGaHCrJiXWOO3sNahyxLG2TQratxB/rkmb/6d62+U5J?=
 =?us-ascii?Q?fJ397pcie46yIe85KEFNLhfUVo8xgywbqr66bo89EzQkpR2kUTko+nJNKSBI?=
 =?us-ascii?Q?nVGHXn200xwZ7Jdpec0WOmdDrjkuJtLEFIWbGtBMNN1V8o3oeC/6xbWNtFAp?=
 =?us-ascii?Q?gwK0h2+oM91ZF3b6ca/NKY+oNsHw5tVijz3WwPN+zD68uo7UOL9QB0j2HWxd?=
 =?us-ascii?Q?bjgHbRokL/2slBNnxJVbmiItQGyAJBmmjbwYE2JZF5ClFvMcp47I3sqvoOS9?=
 =?us-ascii?Q?TtERTpE+O4smXjSSq5j3kWAXmQXkYd4ymknpJUaTwGjTMKxTKt0tRMez1cWW?=
 =?us-ascii?Q?yaEW/K89ZXQyGq5MstZsUZnWlfjPFzoHHaog7/0k5PkXFxQC4x1DL6drDLJm?=
 =?us-ascii?Q?63vxz9Gd1hyTHXrw2F24DClqdf0523tCjCCBAHIsKuN3HiqXCBlDafvq6T5u?=
 =?us-ascii?Q?NlFSEUlC6yah/hsL6pfoiVLz2+JiLRc+GlTKrqhbgNJTEWByKV/+WgzHozbk?=
 =?us-ascii?Q?IKhZdbRHb7k360gMyfzSBLGiqHlOKNe5dha1roslClbZgX4+tXhxEAXJnnlq?=
 =?us-ascii?Q?STbSona0wApUZwBU/QWM1lXvNInfyDGng9uMsjF8rgVosmx6tl+4PRJyqzuX?=
 =?us-ascii?Q?imdcZAaW1wXbXVvEGzY6FW+GgUA0pieT1OLSmwskTJTEZ61TUUSofDNgFrGb?=
 =?us-ascii?Q?tK7vFaHvSWzGLM/BqayqudrxdvQUE6xACPqNEhYW2uv7s97rW6ivhFHFfjv1?=
 =?us-ascii?Q?eXODLmlLUhL8Q2cl00ytzRgwzUxgwLm4ZXog1NscMuVJDCRnYjnNpcXkaPts?=
 =?us-ascii?Q?2bvJ1CswyxdjeD/C+BNdPAFwEfE6je6ykl0r2EZn?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e65bebe-e840-4a46-ccb8-08dc55b2d316
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2024 20:56:12.1566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0SXlIBISxlYC61oAKSX02EwhqVEgbIRAtbmCkSFAxDU54nSiIEn0jtc9MAjCO9p76GWWaxBSQDQGQg0lk3WYeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6128
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Sun, 24 Mar 2024 16:18:09 -0700
> ira.weiny@intel.com wrote:
> 
> > From: Navneet Singh <navneet.singh@intel.com>
> > 

[snip]

> > diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> > index fff2581b8033..8b3efaf6563c 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-cxl
> > +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> > @@ -316,23 +316,24 @@ Description:
> >  
> >  
> >  What:		/sys/bus/cxl/devices/decoderX.Y/mode
> > -Date:		May, 2022
> > -KernelVersion:	v6.0
> > +Date:		May, 2022, June 2024
> > +KernelVersion:	v6.0, v6.10 (dcY)
> >  Contact:	linux-cxl@vger.kernel.org
> >  Description:
> >  		(RW) When a CXL decoder is of devtype "cxl_decoder_endpoint" it
> >  		translates from a host physical address range, to a device local
> >  		address range. Device-local address ranges are further split
> > -		into a 'ram' (volatile memory) range and 'pmem' (persistent
> > -		memory) range. The 'mode' attribute emits one of 'ram', 'pmem',
> > -		'mixed', or 'none'. The 'mixed' indication is for error cases
> > -		when a decoder straddles the volatile/persistent partition
> > -		boundary, and 'none' indicates the decoder is not actively
> > -		decoding, or no DPA allocation policy has been set.
> > +		into a 'ram' (volatile memory) range, 'pmem' (persistent
> > +		memory) range, or Dynamic Capacity (DC) range. The 'mode'
> > +		attribute emits one of 'ram', 'pmem', 'dcY', 'mixed', or
> > +		'none'. The 'mixed' indication is for error cases when a
> > +		decoder straddles the volatile/persistent partition boundary,
> 
> I love corners.  What happen if no persistent and decoder straddles
> volatile / dc0?  Would only happen if the bios was having fun I think..

Yep same issue with a wonky bios...  I did not change this text.  Only got reformatted.  But it is worth changing to:


... The 'mixed' indication is for error cases when a decoder
    straddles partition boundaries, ...

> 
> > +		and 'none' indicates the decoder is not actively decoding, or
> > +		no DPA allocation policy has been set.
> >  
> >  		'mode' can be written, when the decoder is in the 'disabled'
> > -		state, with either 'ram' or 'pmem' to set the boundaries for the
> > -		next allocation.
> > +		state, with 'ram', 'pmem', or 'dcY' to set the boundaries for
> > +		the next allocation.
> >  
> >  
> >  What:		/sys/bus/cxl/devices/decoderX.Y/dpa_resource
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
> > +		return -EINVAL;
> > +
> > +	return mode - CXL_DECODER_DC0;
> > +}
> > +
> >  static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
> >  			     resource_size_t base, resource_size_t len,
> >  			     resource_size_t skipped)
> > @@ -411,6 +419,7 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
> >  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> >  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> >  	struct device *dev = &cxled->cxld.dev;
> > +	int rc;
> >  
> >  	guard(rwsem_write)(&cxl_dpa_rwsem);
> >  	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE)
> > @@ -433,6 +442,16 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
> >  			return -ENXIO;
> >  		}
> >  		break;
> > +	case CXL_DECODER_DC0 ... CXL_DECODER_DC7:
> > +		rc = dc_mode_to_region_index(mode);
> > +		if (rc < 0)
> > +			return rc;
> 
> Can't fail, so you could not bother checking..  Seems very unlikely
> that function will gain other error cases in the future.

Sure, done.

> 
> > +
> > +		if (resource_size(&cxlds->dc_res[rc]) == 0) {
> > +			dev_dbg(dev, "no available dynamic capacity\n");
> > +			return -ENXIO;
> > +		}
> > +		break;
> >  	default:
> >  		dev_dbg(dev, "unsupported mode: %d\n", mode);
> >  		return -EINVAL;
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
> Fully agree with the comment that a string + enum table and search
> is probably appropriate here.
> 

Ok, done.

Ira

