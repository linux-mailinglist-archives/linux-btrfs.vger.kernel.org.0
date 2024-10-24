Return-Path: <linux-btrfs+bounces-9109-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5AF9AD982
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 03:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A55BD1F21E17
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 01:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB2313B791;
	Thu, 24 Oct 2024 01:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dA8oPHND"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3612C9A;
	Thu, 24 Oct 2024 01:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729735154; cv=fail; b=aCWzfqb48lFpwSFotfTl45S8EIB49CxZJ6bmptqxozki/GsUYISuMpCEC//LAkZNeiUe6aSkY3MW5jztDLRbb4rXuZ0i0mmGTqkTBb9jkYEPKDfiO8l/z4TOYyZz/z3XQubeA6z3A180E5UP1pP2fj+gl+73I/iHGUiS4CfqMC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729735154; c=relaxed/simple;
	bh=kWVdrYjo8vTSYe25KcErkwYjyqfddKmxbBU10BFiod8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Wefo96GlZkZS269UItq9UvqWUAVXoAfABV2fJKKwRfAy2nlqrx2pkwF9mkdWqM6FeSBUC97JiZZIa/Hw73wbp9As1P39oXcUL7DTBoKhqZBYPbZNbffJbG3wg6NnppessyRXwdIT5ECiYCa1OGkIKFxyDVvCHm3EjFgdHnFkiIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dA8oPHND; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729735150; x=1761271150;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=kWVdrYjo8vTSYe25KcErkwYjyqfddKmxbBU10BFiod8=;
  b=dA8oPHNDF5GxGxrueqi/IISISddnhSCu+ROXxasFpVmPVh41RvO6pSs5
   O62uP2nDu0fidz19uoogmOarlla6rDXblcAW8pFS/saVPVs0T1W9J85DL
   YzAjccAU8ljXGAis37ceoDbRO9utNerx8WDrO7CfkbslbueesnREPDsNn
   cdI7yL720cnWnbExdbAj6BtpCpJPmIQezMEHMwK3/VTHOhljbRuiMN/7I
   oQCTh/6/fMeSHXGqeRhbXwDg6yIgoHpKMoezCRcs6GXCxyFQlWE0DU9LH
   LcloPw7gWcCcIVODCba0MaFMj75wOaA3v6ua6w7PQCjcFInQNa7/i9TSg
   Q==;
X-CSE-ConnectionGUID: KVgtiM/WTm6BHoCqj72+ow==
X-CSE-MsgGUID: AKTLJPrNQhyILQCTE4gndw==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="40742037"
X-IronPort-AV: E=Sophos;i="6.11,227,1725346800"; 
   d="scan'208";a="40742037"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 18:59:10 -0700
X-CSE-ConnectionGUID: BmiLDwb8SyC00tMHYmgV3Q==
X-CSE-MsgGUID: vwtPpaeUTLaR1AZTFkPHxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,227,1725346800"; 
   d="scan'208";a="111251643"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2024 18:59:09 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 23 Oct 2024 18:59:09 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 23 Oct 2024 18:59:09 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 23 Oct 2024 18:59:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d3jZbfjgEwVNZT1+fYWKowcnryHJ/wVsCAZMK0TFWzDoXY/VMgOvKuhM/ou0S4VkSE4FD2iDOVbjeuNjrmnA8Ysbit6dbrdW8zbrNZ5so5ezPYsUySRKz1THMBmet5z9ZWReB5ZYyl48/AqfFbVw4kIGgWA7NRlcsJttxj7Dfj26Uld9q9JZ6JC9WvMrebLiSAb8CeNB73lkZVhXQOb/vfH/acmbcQlgJLcBuL8RBBruiIe7mxwLqZfPEXpl2+t0qioHojRBqwv6yZLTMcBdiE5djQRqkQS5g2BwbjFEj7dxT90jtkH4fJo3c1wf4EBOPCfZtdnIhbBjDBem9yd7kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/lixa9vgPIf5JiMAEc4gPo3LhXYwumjpSUUz+7R2XRo=;
 b=N1h3p7jBY68zthvXuo/L2fXTgWx+Zfag5Svsp08N8+vj6qE341BCate45B1moPKsy5LGIKDNOCigJFEQU+K2rqJSUOOHt8Cjgak22E2F7Q3BgGOLOKcZe+j79id4ItQi03JZedonrT7lqdjgJQ1wNs+63woXfYKcj77HmeFUrG3GeS84zCkGQ/icZUzQJmShmvf+nVd1NuEOiFeebWejOcZqSpRout2YNf7pH5D5hjX9M+OzYlYbDqYNJCzOMbOXbBoEukc0tJ5qKXWQlRfCx3JfS+1Xk4WriRflyx67ahodxAJrYSA+2mQcNmZiOutT3im0DoBcdVtQPOCBK+Cnrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH7PR11MB5959.namprd11.prod.outlook.com (2603:10b6:510:1e2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Thu, 24 Oct
 2024 01:59:06 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%3]) with mapi id 15.20.8069.027; Thu, 24 Oct 2024
 01:59:06 +0000
Date: Wed, 23 Oct 2024 20:59:02 -0500
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
Subject: Re: [PATCH v4 27/28] tools/testing/cxl: Make event logs dynamic
Message-ID: <6719a9e5f2a29_da1f9294c4@iweiny-mobl.notmuch>
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
 <20241007-dcd-type2-upstream-v4-27-c261ee6eeded@intel.com>
 <20241010164920.000017d8@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241010164920.000017d8@Huawei.com>
X-ClientProxiedBy: MW4PR03CA0305.namprd03.prod.outlook.com
 (2603:10b6:303:dd::10) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH7PR11MB5959:EE_
X-MS-Office365-Filtering-Correlation-Id: c7407dde-4a05-401e-460a-08dcf3cf7164
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cZ7vzaXUAoRwVsiWCP0cvGhQzVUUJ9Pk+mMTB/XSYdALfIHzqfxBNi67qEB6?=
 =?us-ascii?Q?VZIjYlhEVlkZxhqfefQWfKcHBD4Cqo4JV6sEmOGsahTs9BBcCEIF2JCwMy2E?=
 =?us-ascii?Q?ap25a+MBZL3FiE+6IlYv79D6NN4ZXMXdJVFknDx6NpxG9i6BGOaNdU+MXg57?=
 =?us-ascii?Q?bv4LuHybFaWCEZO0y+4EhrOy6MkQefUjyRP82xiVcz0qZNie0ZlQ+BvWlfV/?=
 =?us-ascii?Q?AB4UcwtiWt3Jh+oA/SfbiBPfaCtLBCsO/KNVcB2wtIDelPnRcFJO942exjix?=
 =?us-ascii?Q?qM4jCxk0hoULWC3zrtJSUBH5qmCALun+a4LPlEbncvVqYF69MQ0JT/sioRul?=
 =?us-ascii?Q?iZy/PGcJzpJw8f6Dzi8MjEhzHa4x0gToNv9xvU1yM2rF0PhIl/wzzRw2ph9e?=
 =?us-ascii?Q?tl/h7TYHr/mm9Pg5r1Jsm5N/QCelV2sYT6zvUHVLRFErUD3oEN8anbdqrN6L?=
 =?us-ascii?Q?39TV991yXGRz4htXZBckUdEUpG7Sq9QsZH34vMxBemcoSioPxNh4WK2EJosr?=
 =?us-ascii?Q?9oNRT4KXWHajGuBWr9sWdfJQO4xGgRAneclDLcnpw7UrRtY5kgNun+R9YJ5f?=
 =?us-ascii?Q?TmY99daW4cuxGmNNXpHLwMJZqES9scbfmDO4ChwHeXXwwjkbbymeQm5S8mRr?=
 =?us-ascii?Q?Hr2+3tlR5RDbyVt5rut46KepUQD3h4faVqfQ9NrUsxc9S2szfHBuioFAXZ6M?=
 =?us-ascii?Q?Z3Bx7DWdoiGOBT6tWLeIItJb+sBh/qpMT31DhqheBq2l0oGeAwU4YX1yqgY0?=
 =?us-ascii?Q?Ofn9OiyvFgkR7BRrEy+sMba8edI8iv5XXBEOXDMFnf/YeOuzVxvQsR8C/h7X?=
 =?us-ascii?Q?pSGtAD8KiUpSmGbC2AiD7SK9Rl0m2XZmFj4hYI9dorXJoSOJ1qZbTVxS4Swr?=
 =?us-ascii?Q?CHUgrQuGXqGw4+MpJYhe/xWChiGWe1ZKBF9IR+A9scODQm/qQUDihDLL+BMR?=
 =?us-ascii?Q?QtaPfYL9/WldLTw4iy7Wo0onJHR5ROSy+l+rujHSZV1C7/KJC1YLJhK0HbJh?=
 =?us-ascii?Q?OUGYQJRu4qVMaxKBNM3zoC+qCJPZjf5NU6gUFESOqh557kRz7lNrtVmhJZY9?=
 =?us-ascii?Q?NxfySSjRh4CfQKpGa22AZfMv9dho+Hq35N64cl0jwNMEuvO3+rPu0ag/qBDi?=
 =?us-ascii?Q?OCB4PpVgqqdJ+gKvgSs97GljLUIAymzi1XyBVnFPnzY9G0xQJUfKRtTEH9xm?=
 =?us-ascii?Q?7tJQfiud37Jq+KQPB/ty7EGi6v9E2GQh9RWznIpA5AKVOXCyBhZa1Na1haHs?=
 =?us-ascii?Q?VCDF2hASnh8ZX/Z+CRf552ZJPU68k1xgwEP9/p4QnRztU/8XR1PQ/edFKfCC?=
 =?us-ascii?Q?5sjNmktZccWIV0kyhq3Xf64Y?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?82Kj4++X5lPbHnjMKpQH5MzqmpZLRv3dmxifp0k6QKQ8T1wyjI0q/fgovNCT?=
 =?us-ascii?Q?sIwzEqDguxBwWOrtwBx5HGFdHkX6ro3dGH2SZ4cHWmIoSgBNnYvUz8gvPF5o?=
 =?us-ascii?Q?hjxy6eAhvlBuxnhmIr67Q6q17+E0Eqst24U1XLEvxl9r6Nkc2utl2/rT9aVt?=
 =?us-ascii?Q?QsSS++CfGk6gcMnudbBP71+mDXNeMRuGhTrTXWFRa13dWQoqS6Gvmwo33Cp+?=
 =?us-ascii?Q?sP3jxY4v1/o618fh8cl/BItMNCynYD4Ykou+cwKLdt5pPbxhnKH6l/k/eTm8?=
 =?us-ascii?Q?nKeH+G9UmF6C0dEiaq590Y1m142wp/GQwENNBVUd9ionZtvsKeWakBRxjl05?=
 =?us-ascii?Q?LO7MbAfYwd87U9hIdJNfsve0p6ZFLXEIYdwmk1gponMj9Pd7fMNVV6jzkN7I?=
 =?us-ascii?Q?Hss2O3leow4Uuc2dCW0JQ878HyvwAxeEIs1vvMOoLHdBTDKPT+nS7JdS6Av2?=
 =?us-ascii?Q?3rFoVRWQwRp195lYkyurQYOqVSwLAK5IcxHbb8wbcTgwemUN/dtDa4Rrcr5F?=
 =?us-ascii?Q?Grc6mIdXiSvfor7jbjAJZ6Ojg8buCl31y4QmG28W8Tx+3YJrfsXAikMIrhBo?=
 =?us-ascii?Q?l60sFTdVcfitfeLMtG09PqlnwblUx4TFWXFqAYPMEKsJ0Q8f0MStkN7pCrg5?=
 =?us-ascii?Q?0aaJNa2G0axI4r4y0LDCFNdRsqyqvChkwmt25BegNKadcazoEKBv04NycwKC?=
 =?us-ascii?Q?/MFnw5Ge/l1RYKUw1e7yE4k8+9n5Q8SsgvA33X5w4ZoQ4RedAmG95+fYDV5D?=
 =?us-ascii?Q?Mrz58GcCdV687OLFNnrRf2RSr0oMFHkRu/zWMxgF9a/PcrsegxmFz8vJjVMy?=
 =?us-ascii?Q?voDKlxfYUKQlE1tcpsxh+llYfEAbBF9fWBgSv82sr+f5/gYlpXd+9JuIpBkD?=
 =?us-ascii?Q?/mDlIk9nMe+bIvhymlON71V3fKH/zuO7AE8ThNaxXZ4hychNbC84CkAzx8gf?=
 =?us-ascii?Q?34EG9owAZ6nKGvmY5dt981AkRgiAdSr7TBMNe8PoQEUblNfz4aoiBmcSaGbD?=
 =?us-ascii?Q?jJ53cP9vVydGzcNtwNwbb6CJBenGAvZnu/Z9xBLZCRKSKY7Ckffy88DQuiJV?=
 =?us-ascii?Q?iRIxpw7FYhKS4tquNFmtELphOtFFNZt2dO7sVqNhw5ap7HnxDp8H3kvRDe8A?=
 =?us-ascii?Q?QEajveLNAuR6jodpoZXBVY6pLl+RKtibXhIdgx8s/Q4GThH95GO5RUgiNpXX?=
 =?us-ascii?Q?I/YTNWh4Rsl41wy0FNRPicUmvfdPnN7XgtMsmoGfLOPDGJ2zRQizcrERBMYG?=
 =?us-ascii?Q?Po4kBoFpsiSzCTbWUjEbgYTb2Uqytb1rP5VuOWbW6A5Ntqvbz/wtQ2qNeS1y?=
 =?us-ascii?Q?N23vjZt86VHz2t770VcE4AhIIuQMUCZF6geAHQS7QOoD3uzPGDxJtTheg+If?=
 =?us-ascii?Q?818xJeJrnAUnQaEemb0ozwo4Y7pMxW4CZylKc6E+/cx0KHPO2hYYPK9sr1hE?=
 =?us-ascii?Q?FZhH0ericLP87PGXyJOKQqsyR6f7r7hagbpTtyHJdTxNJBKq7w+KcJQrxInv?=
 =?us-ascii?Q?RjFZCqq9aigOlo6VPA7OWiyJbqWRuL9v1ndjmXuBAL7sWm7bKsFRVEJIenTa?=
 =?us-ascii?Q?1pWUu24WbmUMy9mFt0cNGee8+7XHcIOyl8XbICZ+?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c7407dde-4a05-401e-460a-08dcf3cf7164
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 01:59:06.7774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HYmvtPfQ3PIOIxBrfQbh1ljmTnq9LdSNXcoF8acR2jDHJ0TAP4fYuvKhzXCCWAsP8zyDxeZC5hyXlWM4SL4ROQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5959
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Mon, 07 Oct 2024 18:16:33 -0500
> Ira Weiny <ira.weiny@intel.com> wrote:
> 

[snip]

> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> Might be worth breaking up into refactor (the static cases) and
> then new stuff.

I had it split but the rework became difficult.  And this is test code so
I merged it.  I'd rather keep it as is.

> 
> Otherwise one trivial comment inline.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks.

> 
> > 
> > ---
> > Changes:
> > [iweiny: rebase to 6.12]
> > ---
> >  tools/testing/cxl/test/mem.c | 268 ++++++++++++++++++++++++++-----------------
> >  1 file changed, 162 insertions(+), 106 deletions(-)
> > 
> > diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> > index ccdd6a504222..5e453aa2819b 100644
> > --- a/tools/testing/cxl/test/mem.c
> > +++ b/tools/testing/cxl/test/mem.c
> > @@ -126,18 +126,26 @@ static struct {
> 
> >  /* Handle can never be 0 use 1 based indexing for handle */
> > -static u16 event_get_clear_handle(struct mock_event_log *log)
> > +static u16 event_inc_handle(u16 handle)
> >  {
> > -	return log->clear_idx + 1;
> > +	handle = (handle + 1) % CXL_TEST_EVENT_ARRAY_SIZE;
> > +	if (!handle)
> > +		handle = handle + 1;
> 
> That's a little confusing for me
> 
> 	if (handle == 0)
> 		handle = 1;

Done.

Ira

