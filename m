Return-Path: <linux-btrfs+bounces-3844-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1C5896015
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Apr 2024 01:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D882A286341
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Apr 2024 23:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBCC47A7A;
	Tue,  2 Apr 2024 23:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jeY6FcNU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCFA42076;
	Tue,  2 Apr 2024 23:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712100371; cv=fail; b=WKJD5a5n8Wd1LYYOLNKGoiOrcvGJj1w5aGHqpMN8LZWzZTYCtIDTvkaCwaUdeZxtQW8Znr0NjVUA/wB+kZUjupIBoHTg+uaKnLxFOXWL2QWlqLoywjEk/AnUjeaCK6fylV2vP7HY1pDAjIxd4x/39p+jjMWIW0E9bPYpJc8a7Yg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712100371; c=relaxed/simple;
	bh=gLlWigV7svQpJkCsv2GQ9BdkZGqSqI2nBkt9nWQF22s=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=huhimrVtnhCh4y/EowEtP+qYTCqhzt891lg8CUK9EOY8C9CdHEvfCbrkY5LKPlxbxz4Cd2QABZf8cVEPfBZiq75H0ymqQ+31bBk0dU8ozFLARWLZGa2hXdyBKhB8rdvpMtWTvAIRC6bK4aqUaO6B1lvav/eg2mvWWA2nWp0ap/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jeY6FcNU; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712100368; x=1743636368;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=gLlWigV7svQpJkCsv2GQ9BdkZGqSqI2nBkt9nWQF22s=;
  b=jeY6FcNUaQycWzgAniW9vxnJafcTv3GoKErYPNHJswcrTR4qX4Q6L7lT
   Tmn/z3DovPZS/Dhv7hk/BOT1SAtTh5muaQK0COHAz1grH5RT9xPigdAs2
   l7wTrqCI05Gv4hSaWtHrZUDKXf5unvOfK0zQ5kAKflL6wNb7v+sj3k9M9
   999Z2MkxtBCTVNL1CtCTVYNRd6mpq+TAkGlnX5Kpk8JQwYC5xap2pVk51
   IzQz6U5EB9Q1seBEWXKRAgU1M5fNAQUY4XNRsRw8oxnjgPEW3OXv6cuAG
   6AqNEK/R2GDUnkc2+U+7iDxFJOGJ2KyLL2p3aGBQ2S8qNt/XwbDppB+UG
   A==;
X-CSE-ConnectionGUID: VRvffff5Q8+o1I4agHJnWg==
X-CSE-MsgGUID: ckyygLZETni02B+kA53sJw==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="17923631"
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="17923631"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 16:26:06 -0700
X-CSE-ConnectionGUID: huDJV0gzQISGMCLqP+kujg==
X-CSE-MsgGUID: mhbJsk2hRVmoEg+kMf9frQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="18285123"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Apr 2024 16:26:05 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Apr 2024 16:26:04 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Apr 2024 16:26:04 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 2 Apr 2024 16:26:04 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 2 Apr 2024 16:26:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JtoZopH4VID1zRYFkckO1iTBp/YabK41ENFEIkj8OApJog2YKA2wkQTSxijLRp0bxZ3dbK6hzirT4/nbbWGLca6Y4JZ35tAiDV8FPNM59HeupvnnvPiw/cdoKL1By18mq6mmQTnSny4qho1oHRpcnuoyl3qYLsAC806t+QPtPrUJi1W8R4RkpqSFrX8Vwk2W/A1tqXm8LEtRPAwIXeK+MkU2FFa5E3N98FBYJaN82iJlSCBAnA/6DdvMDe/hh1MIBFKosoKFnWzR+bAN2l4sOjvfz5wxdTVWtLmCOVJznLG78UrxgteGq/L6WfCmJ3G2f08xWJ8X6VI82bi8rIbHkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yXuUEf53VzVQmzJBpI4LH93JK+SqRUTjksVb3O8TSsA=;
 b=babGFCuZ/RbqNWk4dRgg0lHEU4PT2TB6gHIKLVMrikLaMFQMt8pZyfUMNQuWsOpl6soCrkU/U5YJn2ziX1wo7mjOzEK7/W85s06yUHwXATHBOOgx7yDNwEANp1Z6WahaZjNmI0ULRO8BpLBm+ngm/g6cDjpZnQgD7fL5mYgPKwull/zg78dqi+m3VtyfzXS2dbu8Pd45eJa9/sRrnPvcxWht+Yw3S8YQ0To15U6HQdNlrvESuDTg27DpsZwqnJVLS99xumYDIEpbmbmF0imhcnhMHY+Enit1fgtbXMBBGU3Bc3BRKWnzlQxd7ALFHTNKBNrsPeH1NxfsV1pH+bY6cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DM4PR11MB6477.namprd11.prod.outlook.com (2603:10b6:8:88::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Tue, 2 Apr
 2024 23:26:02 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e%7]) with mapi id 15.20.7452.019; Tue, 2 Apr 2024
 23:26:01 +0000
Date: Tue, 2 Apr 2024 16:25:58 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>, <ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Navneet Singh
	<navneet.singh@intel.com>, Dan Williams <dan.j.williams@intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, <linux-btrfs@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 02/26] cxl/core: Separate region mode from decoder mode
Message-ID: <660c9406d683b_8a7d0294b9@iweiny-mobl.notmuch>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <20240324-dcd-type2-upstream-v1-2-b7b00d623625@intel.com>
 <yd6mynddwk755ypomyspzxfsqwm7j5g47yfmbw2yfwoadpnnqy@7g3ktxrwkeau>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <yd6mynddwk755ypomyspzxfsqwm7j5g47yfmbw2yfwoadpnnqy@7g3ktxrwkeau>
X-ClientProxiedBy: BY5PR20CA0030.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::43) To SA1PR11MB6733.namprd11.prod.outlook.com
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
X-Microsoft-Antispam-Message-Info: 8exTkFvgGDC0ETVnxfyUx7U67DWOXLHZK1a/twHagwDpJ5byVcNcR0I8QxFtzhJYVpb0cVohgjq5PnpWPCkvEiH69qGowxgoWf+PnEiUWi3klRHXlpqKwj6TGThj8EAP1/7vYBY3+T+qpKBTWtDhtUvezRUH/zsbDBq0mm+CyrE6dHeQQZGpOOJdsbU91zkP+vo/NsS1zw48SvdFg/z9UE+smLelonUdF/ARjeLJZ71mC5NBqQfd/NVFTbLWu9fWiSO8aLppXtyjhb/IPcoWbbtfYFA856qcWLvkpJaOuCbz5/NeNOJ6SPFU1W4QKvkVj2kyGGhe7bbHPs5W1lGNEaB8Y4HAT/wzrAPbUN+95uZ07oavc4MyelL4RRaD4e11806xTLdQIEppYm4gb8lTrF2j1eVj4KTze95MO1QQbuWVRDjDcvSVpqlYSKQjpPhhauyNqYLl1uCVUgo+Ox9NyOzMtp8LEVR3RjbBUX/6auM+On9cfGIjSbBf3shrNQZvCKZ3/dbbabPkQU37j/8gBzH74xYpkk/aPScBksi7OD5Q674124Kffogmzh30lML5vgAsXrEs5AO1uYbtCXoF6QzryKFgestaeCEqHc4bIKGLsUMFFRYK2QLzNDtNmcTT+5j9CyICUgf0DzDmAx3n9XgF/k+MMGT6jZ9HE/naBj8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ADEPas/6+bhxnFPjWPoPcKuASanggKwp3RtP+a/tJ4wcJkKgHeQk3F1aEmaL?=
 =?us-ascii?Q?StS3ZXAK67Fc9exBT8aRX9Mg48gyqqE/CKdWf3ltoXAavtEVQg3humA3LR1I?=
 =?us-ascii?Q?vbl2H4pLoR4A5MTX0r6NvFU72Zq8AUlWddS6G5zMYI2ixM598vXsp/qMLiUA?=
 =?us-ascii?Q?16aEVlU/RukiHT29S0NVUfmQAgMiMAxXGAg6ofGq+KNBaAqC7+itPKeJ2hPv?=
 =?us-ascii?Q?02vfYywVZ6OSU6zhBn3uZhPmNRtfy3ErGjpDAYD2mgEa8x334l8MQviB+fhd?=
 =?us-ascii?Q?Tfczuym9yPtQfHCfSwEi82jbknCKe430dmefA8sROc4/c+mSVA5LJyKSMgfb?=
 =?us-ascii?Q?VbwyOvaktHNuFVNwaZnx3RqamM16mB+5i4Y4btzy1rqdpAvg2lFF3Wk+xcN9?=
 =?us-ascii?Q?McY5SEMAWYHqq5rE/noIcH2Eg+JPSWnLto7M4tM0vrYs8+3gLFUaaO20+wKe?=
 =?us-ascii?Q?ABK360cqA+PIpn8VSVA/lPELh7YrsjJrf79/RfpsLCmoncuu16tLfDItmU34?=
 =?us-ascii?Q?XjJxEVizGBKiYH66pLu7AR5sBdZEfOWZM+hHjhN1r1AFNV+ZTEaJm6EBbDTh?=
 =?us-ascii?Q?ay0Iu3281KW2ophfpvwRdzctwWJjAgKbWM8khhOadmngCAQM0xPMxEjN8RA3?=
 =?us-ascii?Q?9KGM1fa4lhYZ4AFSJBOeauaW+pLIeOqmhqZdPpN+9K02ma7iJlGj4qDET2Hr?=
 =?us-ascii?Q?C4oClvJYSOEkPrFhZxhgT3zS3NfxdrKdYNnHrIGL5MJbM73QBYJI9fTRMPCy?=
 =?us-ascii?Q?aDJKsyBQyu7APfFtrJ80TZO5oFXXgPjW8nn35fDXBclYhxdzsitQgGL+ctlX?=
 =?us-ascii?Q?dJcL26uosqVDJK2GzwfzZU7xlUyQ1hwXSE8eXwpEMYETbNxP4esRpSqaAhS/?=
 =?us-ascii?Q?LmuoAwyWJcOVcpNFwP50jnzePvjN+9qVLFbFRnfiKboy3yrkepndAX17YcUT?=
 =?us-ascii?Q?V4u0TJjeQfRO0/Fe7/IesWZHG+Te+bP2ZiR0CHTOJO3BKIE5wlGpcrtbWBuL?=
 =?us-ascii?Q?jE1+jcRtcA1rcR0Cpqt683tLOrLupntqEE17by40BZsSPXwzpdmDErlhPc6g?=
 =?us-ascii?Q?sVWMrYZwPViPUbYxVuwQYc6e4M7zNtsFToqcuU3MuFr6y+rgxK3a94eIWcum?=
 =?us-ascii?Q?vKi54MppbXT8SykgGZachdIJixY+lNdqALP7ZwWlJBWcYcb09So6k3r7Zvz+?=
 =?us-ascii?Q?HtH83hvMq0D+KR9ncdUWeOy+y4XIR0gSl4ERpTN8aw94WmQWUFRLhL0GgeV/?=
 =?us-ascii?Q?qrSeFBulkDSEcsh++gqxnpRJkPELQ4Bo+ISUT5cFVZHkwJTDRLK0Xb2i0uFa?=
 =?us-ascii?Q?P5D6M6eYpXosT9RJ47mjaFydKyE3bvST3czX5QK6dwVEWKoUfsyH2HivIYjT?=
 =?us-ascii?Q?ObVurNDywVCLNYOYaIHoALU3GQTfEwOImMmGV4SXRMuXO5ShT3nV4hOvCO/h?=
 =?us-ascii?Q?Bxsx+UEPqiD5dcN8pWBuk6Phl9pN/ZKnKGHs/4Zkwf2iq3IcF5iGtyRiS7f4?=
 =?us-ascii?Q?daP9tNVLTnkplCg06qwAe7SrWScxwhMHAYBwKvhFOfC9v4kgDMLyFcT564El?=
 =?us-ascii?Q?16MBr4STnSgR66wMYZAN0CXvEXN8a3Cpp2lBPOFq?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 064be70f-2a33-4c8a-8fa3-08dc536c4285
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 23:26:01.9157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XwEzv6Y6xemqCiLiwdd0spjCkj34DsdlXwWRvGDyuERdyeV6ICgu9DqsArWY5QbWQoksoc2gChAmU8UH55+Sbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6477
X-OriginatorOrg: intel.com

Davidlohr Bueso wrote:
> On Sun, 24 Mar 2024, ira.weiny@intel.com wrote:
> 
> >From: Navneet Singh <navneet.singh@intel.com>
> >
> >Until now region modes and decoder modes were equivalent in that they
> >were either PMEM or RAM.  With the upcoming addition of Dynamic Capacity
> >regions (which will represent an array of device regions [better named
> >partitions] the index of which could be different on different
> >interleaved devices), the mode of an endpoint decoder and a region will
> >no longer be equivalent.
> >
> >Define a new region mode enumeration and adjust the code for it.
> 
> Could this could also be picked up regardless of dcd?

It could be.  But there is no practical need for it without the addition of
DCD.  So I don't think it should be.

Ira

