Return-Path: <linux-btrfs+bounces-8884-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EA799BCD2
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2024 02:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 738401F21B7D
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2024 00:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335AD33C9;
	Mon, 14 Oct 2024 00:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mxK3IotU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDA0196;
	Mon, 14 Oct 2024 00:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728864328; cv=fail; b=AP8osv4bBp+UigCVh7n77a4qzkg3ZECBSO4Vbd9Dl2FPGUc3nNibjV5QKRwatJ7NuXp2D6HMy02cbx4lIsVsNtm2klJRHbdS0z/mvEsp+ZWee2xsQ+y3vfLkvTp6ykhyDez3H3An9iOyD4bmpX7487Ltp8VCa5zVTZUor7p9W24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728864328; c=relaxed/simple;
	bh=CHBiE1iulB+3vFggGngyPeH4Pk18SzYb8cTfSEPipZA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lLyapmSnzLqhoq/yIYNX5L0lefN2+tMYdejFbA1pxaggR2cpeGD61WWvo24Fy/nDu7eC7oW9QvKAxCAoV5X91qj8mIo2t/S/6W8+FQb6KHHoX+hmIY/mHArBMFot6FnOXYmNfRoBEm7oxRR3rAJ/7RqSpNQt3x6Fwr7pRWo3tmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mxK3IotU; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728864325; x=1760400325;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=CHBiE1iulB+3vFggGngyPeH4Pk18SzYb8cTfSEPipZA=;
  b=mxK3IotUAMwt7KFC9wjfEtGYaCJM6dPSRS8/4XRafoPLJuGvfO5HFL/b
   6ixkpXfHx8zAQnCTk47rvhhyaqCoq9dMQii0lmnCx07l3FsxPKAgECJJa
   /GTTbS3px3k/qbAFZahOBMfQ0e34BEPq0dL8VO8za/HYRvrIIGhDw/Ivk
   BjdhCI+cqa5IjNlRIMGxPsBhHvTUfhmoVUEqTl65HChEBFte/DJyTO7pu
   UVF2Xxc9x81y2pxPiJ3x2yEHbK7w6obcyTiQadhdFPqeDbwGdWP6hFpSK
   y7vI1txKjf/NXSpBnOcEo3LQoCq72xYd1R5jLmNvNQPWrq7QqdzRfp2nG
   Q==;
X-CSE-ConnectionGUID: XuHZyfSTSKSphmGRdP/4sw==
X-CSE-MsgGUID: o4lyuNtUQMeCb9sZDWr5JA==
X-IronPort-AV: E=McAfee;i="6700,10204,11224"; a="39581470"
X-IronPort-AV: E=Sophos;i="6.11,201,1725346800"; 
   d="scan'208";a="39581470"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2024 17:05:21 -0700
X-CSE-ConnectionGUID: MoUFpWqnRw+YzH6fuK9iAg==
X-CSE-MsgGUID: Yhfp1aZUSOO0Bggcqdx7FQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,201,1725346800"; 
   d="scan'208";a="78240116"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Oct 2024 17:05:21 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 13 Oct 2024 17:05:19 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 13 Oct 2024 17:05:19 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 13 Oct 2024 17:05:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q869YsY/LR3YYFwmztUUlkrl/kc/pdrfpeo+7CNIXwfLfYnupL6ARIcyJbLvzbNgVkk8Uu/jGDtNPH42uBOlFbdVrnQPZMFYRgpkSlm9902Ywg4pXkQRQoqWYwF8iM7AnBy9K5bTjAbkJTb2B7k0/r3gY42CPrj6hbw2fDv1RXFufGRTbT6ov+JrnyqtmLhRz812+VBNWdDKwzukRLjTgGPdTxsmD+ThQURx5GAZ3lbltzMMJxoYzh6Mg0qGn+ysQMLmXroluXeL2bsz8YsIbJUK5th7AYhDhs/T7lGFsdLrUvcByBe7/Q0XG8g6tdlLENCYn/xMi6p7T1Zib9PsMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=92UsloObDLIuA4FzA9AAWJJnS/d6oenqFk6funVWXM0=;
 b=iKTvuYPIfQYpzM3Y7aduhoHaNTWkcgUQ/nrhKsvEPTk83RlbUz6ta8L0NmL0n2Q8dDKUKjGgHrR/HFOKB5/kQ62hTlHVR/nqWqy2Mf0CdLyqW+e4N3oOmPIpOOF/0+StVeynMGCrsGyNb/+ZnHm6gQGWdJiP4TklmIWh+9RPRQThE18L5NTCrgQSyf0j5GoqIs+FAm+Hz+e1100DMmGc0hfH67bTIWWbCXzIsnnXD580+VNOX0OgR83SLLzu4PrPvU9hLYgOgCXJo7Ectp5HUQj8HkVjd7ZK5tGLAKLHeOPu4UxmR4wANyaanR6QKoFhQKIViv5nHwughK4s8j/DTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by IA1PR11MB7726.namprd11.prod.outlook.com (2603:10b6:208:3f4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 00:05:17 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%3]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 00:05:17 +0000
Date: Sun, 13 Oct 2024 19:05:11 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, <ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Navneet
 Singh" <navneet.singh@intel.com>, Jonathan Corbet <corbet@lwn.net>, "Andrew
 Morton" <akpm@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-btrfs@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <nvdimm@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, "Li, Ming" <ming4.li@intel.com>
Subject: Re: [PATCH v4 08/28] cxl/mem: Read dynamic capacity configuration
 from the device
Message-ID: <670c6037718f_9710f294d0@iweiny-mobl.notmuch>
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
 <20241007-dcd-type2-upstream-v4-8-c261ee6eeded@intel.com>
 <20241009134936.00003e0e@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241009134936.00003e0e@Huawei.com>
X-ClientProxiedBy: MW4PR03CA0303.namprd03.prod.outlook.com
 (2603:10b6:303:dd::8) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|IA1PR11MB7726:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c821e26-f8c8-435f-9510-08dcebe3e2b9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GQTBFMwZVuzQiD/R3/2pUlw5nbsnw826dVIG0vOIxDHL5iuVDVH2t8l9MAK7?=
 =?us-ascii?Q?c7oNPX4T/BtGIexyPmohGzqqaTLmPX74dsrli935tEZGYWfEDWyBX4gCpyDW?=
 =?us-ascii?Q?VnFqoK7Rqw08UfxW9cQ/UGbV2pwCHhxXGllmkUSRi1SqoGs567rCKfwth5Zd?=
 =?us-ascii?Q?y5t5ZuMTEHOdjyJADEUwMOIxYrcfdtYIuEbBTIljpJm05Y7pMdSJZt0pgpdo?=
 =?us-ascii?Q?embYoNQKRsLS+4bbCDOFeScDIF9l7MiyELyIkjbkZD1XwRQt6RA19B8fv6GJ?=
 =?us-ascii?Q?wkubcLTQXc7PHdJvviwsFLvGPo6q/l6o4eI/7iahdk6V40+h9C+nYuJAPugV?=
 =?us-ascii?Q?LDVCWw7dYPEARd1Dt+ZG5MrrrYpHDtncS8dlRzlYMnqlOLwQR7AaP30HeiTt?=
 =?us-ascii?Q?VvKo+KHPp2LXV5iXphy7cxy+hUH7ThxTbhghl9D98cYGpMlQNbKx7bJCPS8T?=
 =?us-ascii?Q?PJgb9rw/ksLulxEA9iSnXrj4xXQIwYkCWTyH5Zu5JUdiuSepKvd414P1y2pX?=
 =?us-ascii?Q?A8XmD0OjWB/G3c8nqhq1EmgkKrs0V2T6e/+uRud/GrpFgXNcWVH4JVqj5hzY?=
 =?us-ascii?Q?wXZlFBpwPbOesdMj3CuhEDSYdZYJGSlgVKLyZZSMrfZ5dgshw3FHBAB3dyIR?=
 =?us-ascii?Q?vou5G+Z5qq0w9chTusPrJTb4GmCYulw34pe33Bl9dr6GmlcOB98RRWQ/F1Y3?=
 =?us-ascii?Q?5E5jSn6WwzocpaYfirVAn1oHz/A7sr9UAHuPpJy9dVMn5NnJ9VfSakoFw4r8?=
 =?us-ascii?Q?tGiGYYeY868Vcn0BMuFTrdBhsaJdCm/4qOSKGWbO4BPJoA5fpnQfNa10iO+o?=
 =?us-ascii?Q?CT2LEg96NDm1/yPPq0lEsXJDrjyipsaunWcm0nM4pWFJizrWqfyknm8N553f?=
 =?us-ascii?Q?oMrpLYThTiCjj8REvY4raZqw3o+TKS2Jx16WADQWlFGCop9rIIX+grM7kiQz?=
 =?us-ascii?Q?oIWgZYcecj+Dn/S3BMnpy7ropRDIr1L/ritFLvSOffMVS4DVoHi6FE8Z3g5w?=
 =?us-ascii?Q?bQ25o7rjfY2ixJFTSPMzAM6pOhtQP9SGOBoaSZU8X+Kl3g4u6hKRSeSsluY+?=
 =?us-ascii?Q?v28sWUJEu3GqAPxmP6y+IL0R+OT5suorvbKAhMw9XBA9WuVvuv73vc0/yUzS?=
 =?us-ascii?Q?Fh7+rWWiaBuxpkpkrXyOxZxHUGhS5VxJVjRhZ4p5IvR1ekycUsD9kR4xGLsi?=
 =?us-ascii?Q?ORRRsEnrWpm3Wi36PS1t8pij0/VO2X9lKdw8jMZljFGGpsybUP7dXQJ1JOov?=
 =?us-ascii?Q?vWm6rgqgNaXPkO4iqLu01ol+DtHMRFmsbnNc1QA+Vg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vmeINsZ7saBjJADHQHAvkfRX/+tPn8jWD4lSftBAyuKsAghyQv+ur8yUWtmm?=
 =?us-ascii?Q?ccyWGsjmiq4WxMC4/gNnIGPFUn2wcG30bL81+U/eWxzsq/VeZBtNRXefDij7?=
 =?us-ascii?Q?8oQ7PlacvfPSB+VJjKg+U8G9ZSkZTvN1W3FawUo0Io15t+PybJWqd3hef3x3?=
 =?us-ascii?Q?AT9JAc8qyD3kmX905dLpg1TqbXRV3djSVK+1rBJO9nYwrWCnSLFM0vrNsAFI?=
 =?us-ascii?Q?IBvsobT0CiD/fvKUVkRiHs25xobcw1YG4pniYdYZgzm2iH7g9PUBTq45TUK7?=
 =?us-ascii?Q?F9JdBipb2Dzwg+OWZPOBO0YvR3aTw//rNaq2bd8dv6tptNuI+6liCo9UdYva?=
 =?us-ascii?Q?LHrm6p2faGsIszC7SLfARRyfgkWgDSDunSg63aUgkTtgsJR0E4bP+MPhC794?=
 =?us-ascii?Q?ETM9MGQyuNzRilp8YyqYdRos5GuXoNquovXGh05iApidQ+yOfLOug6GryePN?=
 =?us-ascii?Q?Thb79yhtKDFSHId6taFzn4Cndfr1rAbJXorML26fO3XgLHEt0IYokv0mMpoz?=
 =?us-ascii?Q?hNSaeLjSSPVod1q3EXHq8/c5FRtp/KqzKr3Lyre68/pBsJA7jEdTP9SF0t4r?=
 =?us-ascii?Q?4IqKT1CFNs1QneeMBKecVImHa3D4ZrFqxGAG3z8vImo8au08x38xe4U0KzIS?=
 =?us-ascii?Q?yQUg9gXiS7iuF2v3Onsuncl0MWG+QwCIEPwnCeNBw50DFZwmHwKy6tN4H+4H?=
 =?us-ascii?Q?Piy3TkDsPXjr3+Id05e4aXInYaxg/Qs4rLY9owZNXnp0IIGnx71M11ofFNxI?=
 =?us-ascii?Q?ApISsUZYFDlJZEllts4R4bV017QqX1MrBYqHRDEPpQcf8XX67khgoFl3Tn07?=
 =?us-ascii?Q?IOmVIh5979qSpwz/rmRjF0MkAB819XTDz1ZOsOClbeMuzrpO+LUKAatObyE5?=
 =?us-ascii?Q?NRnXqYzVA/y/qvQFb8vHF9WlRVKvTT3bVj/hn0cJ5WzxtHE47EZcc82c4o6e?=
 =?us-ascii?Q?Gz6zGXt7BxopJImntCXDaFjPQQRgv4KnMRKlnRAf/qb+37a4e4GVCwFnIhTd?=
 =?us-ascii?Q?aywCi/M1lQZPYcF86yg7ovTxJvPCB/XeJkU4OqS+G+MqmTf28BUUP8Tw3d44?=
 =?us-ascii?Q?gPaMCTgq3UGBea9G8QXPQBTId3aLa4RhGn5QI3QaD0rT0sos8Zou51EHN1Uz?=
 =?us-ascii?Q?c7dytpEl0+MnNP4hUGWz5wMlPHQlfGoKbJU5O5sHBcPUz7n7eGPfDP5GsO1I?=
 =?us-ascii?Q?Jq/Zhv/hxBvUEgCzUYkbZ9ZW2AnDCnOGyyrvq8cLxdBmr9BM7Kp9VIlTd7Ad?=
 =?us-ascii?Q?YLVfEyTA/sX5SYbrWD52jz/VboQdNRVb2XW1kuMiC6+G/CzeESBbcccGICzB?=
 =?us-ascii?Q?c43MoqViCBNujKFrcS/onDg4+QcRdasxrz6K987tPMTWQawlFFf2ifZAamyN?=
 =?us-ascii?Q?zi1/HXnFXu5hupeVWe6uFpGiqewdBb6IzWEgmIR2ty+Bw4Tza5Sa5gnsXLRL?=
 =?us-ascii?Q?zI48q4b6BYl3CT4jMZ6Llcpm0AdMWD2fq8PlHXG45p9DUSWFFSsVtw1ztoEw?=
 =?us-ascii?Q?jKkh7zuppXUVilCPvNS8GK8T1FPzbITGfkjAq9r5SWrnrp9nl1vrD8CfswXb?=
 =?us-ascii?Q?0NvruOFoFsQ7nO9gSel4UQZsYAHfsIoJkH1uRYQp?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c821e26-f8c8-435f-9510-08dcebe3e2b9
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 00:05:17.6483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +aoKNWNztPQgIdMngxin/T2osm4jC4QgtH3ktiVFyZBknsuruZ/AO5/rX92QDDXadZgtYFc8HYbcDOs7/ITGWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7726
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Mon, 07 Oct 2024 18:16:14 -0500
> ira.weiny@intel.com wrote:
> 
> > From: Navneet Singh <navneet.singh@intel.com>
> > 
> > Devices which optionally support Dynamic Capacity (DC) are configured
> > via mailbox commands.  CXL 3.1 requires the host to issue the Get DC
> > Configuration command in order to properly configure DCDs.  Without the
> > Get DC Configuration command DCD can't be supported.
> > 
> > Implement the DC mailbox commands as specified in CXL 3.1 section
> > 8.2.9.9.9 (opcodes 48XXh) to read and store the DCD configuration
> > information.  Disable DCD if DCD is not supported.  Leverage the Get DC
> > Configuration command supported bit to indicate if DCD support.
> > 
> > Linux has no use for the trailing fields of the Get Dynamic Capacity
> > Configuration Output Payload (Total number of supported extents, number
> > of available extents, total number of supported tags, and number of
> > available tags). Avoid defining those fields to use the more useful
> > dynamic C array.
> > 
> > Cc: "Li, Ming" <ming4.li@intel.com>
> > Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> > Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> Looks fine to me.  Trivial comment inline

Thanks.

> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> 
> 
> > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > index e8907c403edb..0690b917b1e0 100644
> > --- a/drivers/cxl/cxlmem.h
> > +++ b/drivers/cxl/cxlmem.h
> ...
> 
> > +/* See CXL 3.1 Table 8-164 get dynamic capacity config Output Payload */
> > +struct cxl_mbox_get_dc_config_out {
> > +	u8 avail_region_count;
> > +	u8 regions_returned;
> > +	u8 rsvd[6];
> > +	/* See CXL 3.1 Table 8-165 */
> > +	struct cxl_dc_region_config {
> > +		__le64 region_base;
> > +		__le64 region_decode_length;
> > +		__le64 region_length;
> > +		__le64 region_block_size;
> > +		__le32 region_dsmad_handle;
> > +		u8 flags;
> > +		u8 rsvd[3];
> > +	} __packed region[];
> 
> Could throw in a __counted_by I think?

I was not sure if this would work considering this is coming from the hardware.
From what I have read I think it will but only because the region count can't
be byte swapped.

Is this something we want to do with structs coming from hardware when we can?

Ira

