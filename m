Return-Path: <linux-btrfs+bounces-8989-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7369A2E81
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Oct 2024 22:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19D86282ABC
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Oct 2024 20:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60232281E2;
	Thu, 17 Oct 2024 20:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="leHQDlVp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C188622738A;
	Thu, 17 Oct 2024 20:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729196964; cv=fail; b=L7mEuFX9zwB+uUHRlSGpPRtdYse4vNjj9p9dYPxqr1yQgeMs5yJSY/steRbSXmD16XxsACNU1kUNXGqiBcxwiR1fnQyWygVFvaj3yrceth2GCoQ0q6MJvOFs1+eGzs/+ufEAjpqA67nPn07FMGaEyePVqkkbpDyiokAOsHMUmYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729196964; c=relaxed/simple;
	bh=t6vp905Jfxwi7FzL7Ob+lLGe56EZaEa37GWs66ZVWE4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ik4oit20Rr554HGZeIJ9/7nw+scFKmEPUk3O/onUB/F/ZebBnGw/S8ECcMf2LfS1zHmv6gFcdlhkfn80lBuhdhdxYHUm2CRRMv36loyAxBsyXggydgaDyAJp2EfUF0PDEaq3UHwSfkdMB8aOgSNmhLwXj8lbGCvI8ijwQi4Z5CE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=leHQDlVp; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729196958; x=1760732958;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=t6vp905Jfxwi7FzL7Ob+lLGe56EZaEa37GWs66ZVWE4=;
  b=leHQDlVpiVfAXAvNLCSQiQaa4alkzHZvwyO9Vn9i27lSDKJ/yGXNaV49
   5vhf7MBBYl8TRzVSdrxBpRMs9pu8iExRMljQOjZTAXMTxImj++ypWWf+j
   4TAR+j5lKDN0TNoDjKspEdZ8PXbwro6xYMfa1ufekNvhRQGk5S7wdY+eg
   5RnRJ/liHdmcY/U48g1eRf3NssjevLuGkgD7OaDZtQJTBu55SmfLe7BT1
   eH0ax49/juqXyQGk4tSiaQyyn3W1yrkrigj2os5NtlJURbguOJv8CQcc4
   d7Efei0VvvKlfnD2VcP7nP1GV52C2y4Kz9V/gLPGTaKOI5pa4DrXo0Mok
   A==;
X-CSE-ConnectionGUID: WzBnjpV7S9mgxUceXlptYg==
X-CSE-MsgGUID: EnoZASwkSN2zjlhDRvmMKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="46170749"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="46170749"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 13:29:18 -0700
X-CSE-ConnectionGUID: CJHbJL0fTyyWDLxdjYyG3w==
X-CSE-MsgGUID: nt+IyeR8RzKm2qw3YfOCOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,211,1725346800"; 
   d="scan'208";a="109478182"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Oct 2024 13:29:17 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 17 Oct 2024 13:29:16 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 17 Oct 2024 13:29:16 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Oct 2024 13:29:16 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 17 Oct 2024 13:29:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iiMNF6rHR97aZ27zZyvxUg7JQ3/D7MFoZJxyJ82Xo8io/8UoqNSCpXiG/8pcIuGZ1uat2Gfc/ldEHzEYAt0jKL1onzH3D+HUBQDY4oSa1cerFmXnVyVb4aVQRzYxgb28GCXvmOObH5t7gjpGx+FgUpd2m18QHaBT9GFx9FBtOCHQq5UdE3wEfAiWMq09ZT4D5AT0fjuKGD1G3PPYT7T5u+fLux75Hd/ZWFLlAH5dGK8wN4HWH5PXCUFCLHQg4vu8pwDuQScRYI1J2q64BA7deVjwbTGuM9FaN56WLLDz7sWS9Idf1xfWdvBuU4uViaQP5w6fNKyVdiQ2v7W56qy4Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/qiW+B7+1bewn5oWLz5VHGCNddiLGKmFZ+Z9qTbe/0o=;
 b=pzRqkmH5Ndtte4+HshON8lkyq5Hxe7wRl+to0aS3gEBdceAN0n6fq3aKBFU4bsUodSHM7eEhNSjNiM7IQ0d2RLfwJON3mXaWluKIT4eaRVmwFKdZfZefsT3k+TvhBJ5h7uISH5RvUjWnF4fmcqWlSrHDDvAO94tTYQVAzkKDI0W6EAAdYdRUN09CU6SXpeeqw0nrW+oz70+fYXSADx504IzmjEQcWuij2r59K1mUX085ibDOW6f1ujg4+eOW7gSz915pcyxIDs2njKipPkuo9rfkGydzXd8kT2sIUUvjJbYwbcVpokl/7prCgbT7dLIkGquSbT/REXcMiHiYTSjlHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MW3PR11MB4554.namprd11.prod.outlook.com (2603:10b6:303:5d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 20:29:12 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%3]) with mapi id 15.20.8048.020; Thu, 17 Oct 2024
 20:29:12 +0000
Date: Thu, 17 Oct 2024 15:29:02 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Ira Weiny
	<ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Navneet
 Singh" <navneet.singh@intel.com>, Jonathan Corbet <corbet@lwn.net>, "Andrew
 Morton" <akpm@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-btrfs@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <nvdimm@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 15/28] cxl/region: Refactor common create region code
Message-ID: <6711738e4caae_2cee294da@iweiny-mobl.notmuch>
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
 <20241007-dcd-type2-upstream-v4-15-c261ee6eeded@intel.com>
 <20241010141826.0000796e@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241010141826.0000796e@Huawei.com>
X-ClientProxiedBy: MW4PR04CA0050.namprd04.prod.outlook.com
 (2603:10b6:303:6a::25) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MW3PR11MB4554:EE_
X-MS-Office365-Filtering-Correlation-Id: a912e9a8-d126-4d97-d1cb-08dceeea5c69
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dVsYAYB785u3mOx8bUftpaAsq8y6SqugKSGbmpIocJdAu25a9jSM/+xXz8Sb?=
 =?us-ascii?Q?PIAUgp+84Jifa3wZCEO1Vr3zKtbfAcJGbqqpdpaLmOmzH164Jo9cQ50XgO7W?=
 =?us-ascii?Q?SITYga9OIX1pfBJj7qCzBk5WE8LwnDDSpPOlH8bXkANP5J8pxOtTWDMdCyki?=
 =?us-ascii?Q?Y84ymTsq9sMBzsQfwVKQ6rRwjugdg2p2JK5bnNmdNOOIhfoXoJubgirdaFE7?=
 =?us-ascii?Q?cjR0LRsRIcIuTi2WQvbdV4H14MuNtRQwsKFkM/gFuAgVJt0aOsvzkk29mD0S?=
 =?us-ascii?Q?KszpiOE9x7Vm1KLeHTasdYIK1vsOFnUuXCT6APMf+mpDAEqN6WsIdDN5aq4k?=
 =?us-ascii?Q?KiJ6/NsFStZpL0RZ8R9c0M3Z4hNd0IczX/Y/NhFWT/YBhjLufVuRqWLhyUis?=
 =?us-ascii?Q?Bdb8Tg+VNQkPdjdBcxD5O0UeU0VswawUSJCRpuAnhxGT956bR0PgWaFNNA/n?=
 =?us-ascii?Q?xhk/EF2ZCdjNGvrQBzp6PucA3CxvhAIHoXE7o9fhunun4DDLwefcTRxdf8BY?=
 =?us-ascii?Q?4GwIwetk4WRZurqCViQs5cSE0/8AqCN85jTVqTFgy4ckXIhwzZ3CQL+dt0Im?=
 =?us-ascii?Q?ZcTn8sy4xpIu7w+O4l9lox8mqL3Bw6oO0Ny7n2xCCcb/CBWuSLnM3l8OGgEk?=
 =?us-ascii?Q?Zv7cn58dHl8EMuq+vxoSHGAM4TpY+GlymX6ahOuebPjmvoFCeoBrtLBs/afB?=
 =?us-ascii?Q?oWyu6zoVxtxScuz/YDG3vywqdCjuap8zUZTqCqbVTNeqIpXlbhMYADEtnnBB?=
 =?us-ascii?Q?CR49ef+FzA64eNtlWBbjcOo6YdrtcqqhE8EwqnrQVatyVAWUohfNXd2U0XJg?=
 =?us-ascii?Q?n9sQkq382Oy0DIINaM9y9D8Li9gmIYBCeBOqt+cI1RzIzEMQvx2lS5KT31by?=
 =?us-ascii?Q?SGjp1kXE7GNpa6uTjncpV5pDPayVsEn5OCN2zZdojm8SNeRDEJw00ID0X7lH?=
 =?us-ascii?Q?Hjx8lBLLf6wte4cYS0ouN9rmbWyRObIbxWvaQjgxcUDq2Zl55RsB+9GRUTtv?=
 =?us-ascii?Q?ykn3YSwwL0rAA2nzlz/rJQyUaejQe57rFTAO8I4wCMSa2sDMoGwfk96/ohGG?=
 =?us-ascii?Q?xknAZ0hIoQKnm5nKgjVoVKFG6Op8RWIrxzntzxFc8nRjT13stSd+LNl5Sq3a?=
 =?us-ascii?Q?/cfdJzU5wCYJJN4UUSsJ82wEGNo8lzk8HSiS5Sne3z/fiLrs91pVr/1C+Yra?=
 =?us-ascii?Q?odgbdvLInF0/xZGS/Py9vAzAhTsDtHw3yIoa2G3+uUgYmhpsFlAEBANzOfcH?=
 =?us-ascii?Q?5HeYOaIdMSzbK3QiuxzN0fTtV/VyvbpeLq9JVRJwZaVaY54NfCKzVvdzVfOT?=
 =?us-ascii?Q?+C2JsXLoBW75SPD9MvwV7Phn?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+vmynPRh5GJSzTEQCNysEJPV50B3M3+E1PZd/oNY639QAUP38U78HV2zGaYq?=
 =?us-ascii?Q?3+vDfVszs5QQE0zW6nV1QuOdtLVXnO5Ro4nG/tmlMaRY0Hi3wBy0lg3j1S8T?=
 =?us-ascii?Q?nGpud6GSln1RpJf/gVJ4LmiBlMGoJgqLsH0MgmlEUMgZpWA0XGrpfHslzZeQ?=
 =?us-ascii?Q?uTgeFCuIyh9AzTZmhmBCSPLJFKuPLUK7cIQyoqSjTe4awhLeFVFbk8kHvdTT?=
 =?us-ascii?Q?1NMEYp2G69i4YY3AXYcmyojbGZkXTwEmCI41O+92WNhiNC1j5kRCp4sIhSEs?=
 =?us-ascii?Q?upuWgpOdHU9k9FD0Bc+Kf8XAXKS4XP1vugo79Z/FuBHoWPXlcuuwXGEgVpel?=
 =?us-ascii?Q?gAk0HFnnPjpr7DaSH3Jls0EySA7imnOX7maH6PZ+l9hbirzDoz02VWOf+KsA?=
 =?us-ascii?Q?jTx4Jb/C7jzAP0uW6IGz+JeXfvHVFM3r0KCd0qV5mJOYJOmY8k6mZ9vayC1e?=
 =?us-ascii?Q?ZuZQtBsD7fLvoqUeaTduPfB2zeuupZzTP4UGXGbdC0mQUbv9dN3MqXPfBDlW?=
 =?us-ascii?Q?GQ0WEMBjPmezT2KaPGJtifEc7JtvtvC7kOZJgDsNzHUr5DQAb6Jg2XLRhJMe?=
 =?us-ascii?Q?ljUSAH4ma+Hb4h1HBvxf59bCEErLEOsM8+C05KwXA3VvV4J+Vf4qsZii1OFS?=
 =?us-ascii?Q?tKnvZHNKHMY7BDPd+0FMLqNeHtqBQ1zS0l+Qr7MDz+iZU3Mj4qhUx7APDzkt?=
 =?us-ascii?Q?XtFH5d2HICXVECYcTxnSOgsiqFueHOeYySVJLSdrg/OLjW3/3tpAMbagyDDh?=
 =?us-ascii?Q?NITW1iPJVMDrBUBvPVTjneChgjoIVOu7tBXcZ2glU7TVlWmLrdbJi9h2sJ1Q?=
 =?us-ascii?Q?5GcFaXoU0BZjctr58NromXmGeFDB4aGnwQELnt2eTiQtsEgGWQQreFC1qPKl?=
 =?us-ascii?Q?zzLq8gB1/JLZwwL634bxO8dkqN1TQoO7idn0EjX5g6xMOxaeDmt2xYkN5TVf?=
 =?us-ascii?Q?u3F9I6GHvseN/2TSk6n0WHKWiH3/BasuMN2nj58YF4bWzX8/cmsJn5f5A1/t?=
 =?us-ascii?Q?ZipeR3He0Q+Ckc3WrvXEorz3LizBfv5wrbi72VT3KSodXyKY8hyq6pebChiw?=
 =?us-ascii?Q?A9G2mX+uFUtsW+goojTVKxj6E42/FKk7X4YwQ+fr+bV5duVM95lty65FdHLu?=
 =?us-ascii?Q?5+6e0pqUdKGj24w/G3CGEYYmg4mUFQWqB/05H6Kvxs24rIJYN6djL1cOgd5F?=
 =?us-ascii?Q?Zj3cBEoidZ0RPznqbkoD35c0qbKRUJhh5gZSsrN2lF2TZmVnpL28Z4IAyp3V?=
 =?us-ascii?Q?p+eN8SUnbe2pdY2XWUYAqImER/4EGTrda4GCQY0btqG7/foHHLWMe0yoDdyv?=
 =?us-ascii?Q?n/2xItRTVOfLPn7TuGzVc4sruQ6FHUdoQFmek4aGvdQtrHOJJitIZqXl03En?=
 =?us-ascii?Q?cIn+Y7P0WuCTyrAmlLXiTDT3Z7ISqVDyFkyXR9p77LGqoV+LtOk+XSbpHvgP?=
 =?us-ascii?Q?rx12AKmP9gSRPh4THdR/CeI73tWKbPi2289xgGS2nzmfRlhW2gqyXd7JO2Pv?=
 =?us-ascii?Q?eUL4gZxxsWlUr1E5wfAkCUvmmoukZa5QlH9Yr43BqS6N2edXj5svVEcxQuEf?=
 =?us-ascii?Q?4tNIQ+cRgYlKFZMdiXBVvJTRLE9Xl1lcbs/OfwDj?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a912e9a8-d126-4d97-d1cb-08dceeea5c69
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 20:29:12.3189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3JwOZoAnsv42JFskqBebXUXBJbtupB0fqYwI0Zj0dfBLNF26dlkItQXtBWSaLFLRLtPBJxmDgLp239KjQxlYxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4554
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Mon, 07 Oct 2024 18:16:21 -0500
> Ira Weiny <ira.weiny@intel.com> wrote:
> 
> > create_pmem_region_store() and create_ram_region_store() are identical
> > with the exception of the region mode.  With the addition of DC region
> > mode this would end up being 3 copies of the same code.
> > 
> > Refactor create_pmem_region_store() and create_ram_region_store() to use
> > a single common function to be used in subsequent DC code.
> > 
> > Suggested-by: Fan Ni <fan.ni@samsung.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> Nice.
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Is it worth dragging out cleanup like this to the start of the series so
> Dave can queue it up as 'good to have whatever' and reduce this set
> a bit?

The problem was that this patch depended on the region mode change...  But
that was an easy change.

I've moved it forward.

Ira

