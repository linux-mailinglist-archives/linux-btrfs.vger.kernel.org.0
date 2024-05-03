Return-Path: <linux-btrfs+bounces-4732-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2E28BB1BF
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2024 19:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ABA82884DF
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2024 17:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED061581F9;
	Fri,  3 May 2024 17:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NS3uGtWd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2C1157E87;
	Fri,  3 May 2024 17:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714756888; cv=fail; b=u22YvDhdobd6tLFT1C26BYsuCE8Yuh1re3r1GbQEPqkQetdvV0bspdXZd/BHUWxrwtf3aCPvpQUQsgVMswUd5i4lZuKYQi/iqjwm69K6ibKDCdBJGt+7Q39GWn1g+fb6++1kBXM04uNg6FStsFrr4+Jg6rjTSsBNwi66eMMJwdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714756888; c=relaxed/simple;
	bh=FIvrSrVNYVl6cVayn8kzxHiJmO1TnayTAynatr0IVr0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bYMoPfR2dMco5U/ZGfbI70J02RRQjdLQH4v2gjPVKmzk5izRii2+YaVO1aZVhK7bgQ0+5IE2gxrtwX1MkDhd3LybaBqlIe0i906j2BPMOZlk+NAB1nvk3rDZBy0b/5iUtAKvY7e9IuLOxVWtxcslDpAbimP1aRYcEOkN5TbpV/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NS3uGtWd; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714756887; x=1746292887;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=FIvrSrVNYVl6cVayn8kzxHiJmO1TnayTAynatr0IVr0=;
  b=NS3uGtWdsKvUMXLyRdZNsbDAZ+0KhYTxslenkJfwdY9CyQBNcwuNAAmB
   KHXB22k6zk1s7wz07avlL1h5VhAysRpok9c8ax7xUGhT+2EcMqZL2oO9p
   yeHBpfiwi6TGiDjA3eVCqOZQeFl80HWSahqPS482ISC2oQYNd524QH1xB
   7SWXdQ7ix7xt8/8wOzhtKABjGzi993cxym9L2VET5ECjtc2ONYk80xyYq
   5gNScAlQAMAkkX0yJ+WgvaPWzMbRxtqkER4g1xFXcssSlS0ppBxRIUrA8
   Lzy6//acnuJ54vUWnNMC8tjNSQLnghy8qaIdTke/oBJ9y0NRUTidlrPDl
   Q==;
X-CSE-ConnectionGUID: PCAaByFtT+yPXZxp5BbPIA==
X-CSE-MsgGUID: NM2Miyz5SyipEELjepMVvQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="10500327"
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="10500327"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 10:21:26 -0700
X-CSE-ConnectionGUID: dOyewa/YQAGRixL0XdntdA==
X-CSE-MsgGUID: xSRrK+vjQL2rbpWjPRro8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="27597599"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 May 2024 10:21:26 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 3 May 2024 10:21:25 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 3 May 2024 10:21:25 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 3 May 2024 10:21:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mm9PmvLoQGNWsCwPUkmpxcGdsLbpdgGSU8wXtDu936lmb5u3qP24lsTvJ9PRqN99Y3s8TlCnOFxJ77mYlIGBOOBZYhMcQzBw5RTRh0Ceq3QqF5aYKgKZ7gQIq5gs3DZV+ps4Bb8sXb9FL0QFtNm8L03GhI7L5XFUG2BXigB4+RsIVdSqhY05F5hkP+QkaK6iuCXIsM0SZClzk2VLVZgOEaR9RYHabN4z+YPIf6iG3iQw2AXnsT/3IbrHfVfGlzrPauE9Y7ROt5SFtHwYJ+iEwvKGx1eAr4+j7e9wn+pf02LA9QdiBsRHiVImo+uSuqqda7AOWhsaRhafhGZcN7kROw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WMpxDIZMcJnjAGD4BNjzMVjXCNpNKlSxXgQgnRy8DSw=;
 b=XcQe6RAQEeTuwxvcJpNB0rt69sGSi2vl9u5XqHJVFT9yTp7Y1A+Am/kW5bbtjwSBzQsQuY+ZQuwZqSBt5IZBXhuAlfwyanWi6Wx4O4sdVkVhmcb6DCBRODBLkNTcmGQlCm5NOd7tbxDn6oHcG0JtQp/+MQoj2f8ev1DPW6LA0nCHkKvvsJVCkDt1rT8ZU+wukf0e27F6ap2AcSGoywj+3eIbzvKZj5H0D3d6lG7gEey822ZFE5P6FR5qlMIhDHYY+JmC6sHn78XUNC9WGGtUQZCk9R/+Oinq4lnIQ46Dwia7OS/Ix18NVuzyNtKW6takAwl1pjVZwS8jbDxwWlHdDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CO1PR11MB4963.namprd11.prod.outlook.com (2603:10b6:303:91::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.34; Fri, 3 May
 2024 17:21:22 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.7519.031; Fri, 3 May 2024
 17:21:22 +0000
Date: Fri, 3 May 2024 10:21:19 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Ira Weiny <ira.weiny@intel.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Navneet
 Singh" <navneet.singh@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-btrfs@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 07/26] cxl/port: Add dynamic capacity size support to
 endpoint decoders
Message-ID: <66351d0f9ac2e_1aefb29492@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <20240324-dcd-type2-upstream-v1-7-b7b00d623625@intel.com>
 <20240405145444.0000437f@Huawei.com>
 <66351a55a38db_e1f58294ce@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <66351a55a38db_e1f58294ce@iweiny-mobl.notmuch>
X-ClientProxiedBy: MW4PR03CA0326.namprd03.prod.outlook.com
 (2603:10b6:303:dd::31) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CO1PR11MB4963:EE_
X-MS-Office365-Filtering-Correlation-Id: 588b478e-997f-4d8f-f814-08dc6b9573f0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3ccDIWMAXfTkLzerh3IZ+hI3e6wRZcGYeiGIl5zgetLkLT+Osr4C0BFzG9BY?=
 =?us-ascii?Q?4GhJ6ArihkO/uFqWJtUkruanFfNgRxyt2cuwkTqOw0/qyr9FeSxguKlNx+jW?=
 =?us-ascii?Q?dphTK7+nsz+Wi/5IqfaMmY/LYMP6oAzLV6iA3rt3rSiB9dTt+xo4vJ7354er?=
 =?us-ascii?Q?zAjLk3+0p3RDqqk6+Heo1ykiD343X20f4y0EyPMzLMugEz62+K+OB4mcKydO?=
 =?us-ascii?Q?gaHdVabYAa6hgh2u87Iks1b7u1k1MCxWB3HLuyLDQahFAO/ZElPLZu0+5Wrn?=
 =?us-ascii?Q?CO/KlP0yFuYAFMvsf67FJnRT92C19wPpxDgIS3Fzc6jJxbuTu26K8eTqVTxu?=
 =?us-ascii?Q?bQUdNJ+IN7Qf7aL4TWYTYN7lFxkO8E31vDyjgTi2waqBTSWL2zkNcJjeOulG?=
 =?us-ascii?Q?UmtofkXE0Ln5U1oBgcghczJCdXsiJyuUjOZamoRyoWuI57wdR8BZI6mwRbMW?=
 =?us-ascii?Q?98iTJyivlx4oeLIAUP0D2HCdM+hbJxgY/R8mDcfKI9OcNUS41PQPu9quyOU9?=
 =?us-ascii?Q?gjYhMSY85nicQL9JLWRYj3ytZvKgM6CTEeBVZGjr4BOgNbzrUc20ib6tJTIE?=
 =?us-ascii?Q?JlaYoLpBouMT7ACLOlQ6vpRJIGHoHtmQoYr5Jz4ZXVK282KPn+XRHRt2trsj?=
 =?us-ascii?Q?7n+hPvPGnOiOy6Wyx+L8ES63RicB6yfuGYpJayc/4QbTP0WQhVD1i5lI7hPJ?=
 =?us-ascii?Q?+keWuwYIi3hdzatpZwPcMa+shwTctzKmcav37xPH+O7OXh0c0kdxrYymYiya?=
 =?us-ascii?Q?roFPDIgcZtaEU7imnr+fdyqyttuzyUc/MMvS2hYrDj0fS/v95bJ3crNkh2g2?=
 =?us-ascii?Q?gUvAyie2O867fe9V6P/cdYIYGhV5jllLilciRrRTWw0525lL7CIx8PaM1k3q?=
 =?us-ascii?Q?w/rGbUzy2bQqbE7pv3X3g4dSMPC+OWF+TCWOp3EKeQeOS0fMqHuPGpYtX5DM?=
 =?us-ascii?Q?1ZouQibCBynw5pwAMREe4CZlTRslDw8GNwCJN6FG/pxiTz2hgkf9C42XlHmy?=
 =?us-ascii?Q?+AkiOYLlKYPwD5PM0j53iDokaSN96gSIpuRQaJNMaMKI5kpDGKSPS0yI0Pmw?=
 =?us-ascii?Q?Qwjn8uCOlWA3q/Ojt/9DWlb3s1lg5LYfKLNXn4hQWV73qQzvY/1VWhYM5yw+?=
 =?us-ascii?Q?3jsN8hY/T7rZpxyEx+nEQG2TqnRNBjvaHvFkXY4ynQ5bG/RA+jJIswJHQDf2?=
 =?us-ascii?Q?JjMiWXHm/EWkKOXmCfn+QTjP0exCzLtuweML0lAajEsKU2xbGHUKgoSyhBBK?=
 =?us-ascii?Q?VaybNsNiHAs5KJBGn4uWbzP4Hs8Rmrj/mF7EB8csSw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CywmPnOejuC1+hGC95U6T6eKPcO5wqaxT6Uhk8H5TknaTy5iT5OVRDL1D/nM?=
 =?us-ascii?Q?PWBG0SqKrqUy1vAEdFJHmJDu12AgNrve/zk//rcccUTGLW9MS8SbGen20eUJ?=
 =?us-ascii?Q?ey9OOYeruhtePv951LBucKqCHh4Ugu9wJXMRHVtBa8/sAToxy86BrGPZ8D2A?=
 =?us-ascii?Q?SNCOdn/pGFfHsNV2ddL6hUq/pzNzTH1WEf9hJWwrjev+jX7ZYf9UrzX79Oaz?=
 =?us-ascii?Q?v2RdjHpgdPErpJ//x/PkazhJEVYIkx4Yi/yMI/qdZYYPX0FiPgvFNRzKBWLT?=
 =?us-ascii?Q?YE3QeNypiORCLd1hK0Kq/OyanGmGyPxyJU7NoaiynCnYE8wYueO3MXCsC1Yv?=
 =?us-ascii?Q?LJMUUxrhyyatGu1fwVEySukA5QvXLtJYR/04EZS65raoilgEaS4JR5gct5pS?=
 =?us-ascii?Q?GGh9r78AP6GdxAbI3upPJfhcAr9npwVxFzkoWDhL5LW6PSzUVaePUeK5tOKs?=
 =?us-ascii?Q?2u/4o3kpyfYLd0fPJdvwUR+PNUmSSpD8po8yc/OYuxuc6a0IZDzkSdvG82Tz?=
 =?us-ascii?Q?Kbtz0kJO8zzYLgL0PDl0y7SSVD5dJdwFMgv9V/GBm/mMd6Gjh6/3w9WfqDmy?=
 =?us-ascii?Q?C/M/CFiWVL774JCZ/M2Jl3UzhmVSxryZgGEGa84egFQ/dWayPUY8S3weKexS?=
 =?us-ascii?Q?Xo/6C7I8g1hzLDY7IXF36A+PpUcqcr9SKDCauiqa7Hsul9xI3/NsjggvvvcS?=
 =?us-ascii?Q?r93270Lmr5AA+L05LRcnxLPW8gk3Xy0Of+HuVR+8yP6Y/0gR/4CYso2d0Kuu?=
 =?us-ascii?Q?5bhYzSR4l5a8fjVw1STNHHpirGNtLkepd3d157jX1OL6qXVxmqE2s5RIxKG3?=
 =?us-ascii?Q?6glmgBvaVS3VfLm2F7NgxkXd3Lzs0dEs/4Vd1u3PLsV6HySvSQZGWcNAwR/q?=
 =?us-ascii?Q?RJa5vEXrlTaADOgOeH6XkmuXtwmj/R4+S3BnhAf4hf1aIdviW1ILU/HZU7aL?=
 =?us-ascii?Q?aP4aOwJzcAJshhGlfAzqc7A7Nhwc+KnIrY5hzL5mgZ6CfWvKoFDE8/gsTYxM?=
 =?us-ascii?Q?DS4e9wKQFbH5W+hZL8cjefFt9XAa8N2uUCo3iv5GhjVoiWpLJSvKLOhCqLM6?=
 =?us-ascii?Q?0H0Je7o64oQOzaevu/HMB3dXy1rtpUTVj0CiBFSyL1XS+RDVEtPQBrj28vxO?=
 =?us-ascii?Q?NlWJzRne8nHkwb/YrBEukjVUjoiCE6r7S+e/ySsI8gUGca7hcTsJ2p6yueQm?=
 =?us-ascii?Q?R0l2ElD1gCvpPXCwje/eB1Zkym6uOEUcrDRYJFfW5usd6KjuZ48+Pwuh2rQT?=
 =?us-ascii?Q?qwafc2V9E60nhTWhdzXg26uA1KiWoXOcYKyKy5vNk4HHqNLRxHOAtX9zVM6G?=
 =?us-ascii?Q?7afs3/2Qwt+Nm3r4/O2LaJn4ZNOfnQanonn7H/U8/debtYUsu2ky76q817eo?=
 =?us-ascii?Q?DZl+l6LBF/TWj9CP1EgzkUtDxirEnl+uZajUBKLk699Nsrc1wOtv61+k0Rch?=
 =?us-ascii?Q?bGBOm/bA67Sdist04GxfKaiT2zthLmdW2HkzrSFSYquyUMA5GjtCcQjfsAPs?=
 =?us-ascii?Q?3krFssCUoh3ZX2iU/HN+b23J8rMqiRClFPX0q2ZqDhTMKE5w4wE28gxnhTkz?=
 =?us-ascii?Q?lU8DwRvh+0EZU10PlX+PXpspgeu2Xm+ofzUSyarBnTvndQiDJMqmeVsg60cU?=
 =?us-ascii?Q?bg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 588b478e-997f-4d8f-f814-08dc6b9573f0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 17:21:22.0539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V/gqzDelLpPF1UKCxMKxW9xyy8BjPvOkcp0EKdhzBitE7jngEXA00tEstg5Di5Icn8MeQrJRnBZ3eguKRu5O3+ftNaLMhY/7eZJHZ7/PNLA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4963
X-OriginatorOrg: intel.com

Ira Weiny wrote:
> > >  	else
> > >  		free_pmem_start = cxlds->pmem_res.start;
> > >  
> > > +	/*
> > > +	 * Limit each decoder to a single DC region to map memory with
> > > +	 * different DSMAS entry.
> 
> This prevents more than 1 region per DC partition (region).

Why? Multiple regions per partition is the current status quo for other
partition types.

> > I notice in the pmem equivalent there is a case for part of the region already mapped.
> > Can that not happen for a DC region as well?
> 
> See above check.  Each DC region (partition) was to be associated with a
> single DSMAS entry.  I'm unclear now why that decision was made.

The limitation of one DSMAS per partition makes sense otherwise that
would indicate performance across different spans of the partition.

> It does not seem hard to add this though.  Do we really need that ability
> considering dax devices are likely going to be the main boundry for users
> of a DC region?

It seems like extra work to make DCD a special case compared to the
other partition types, so the burden of proof is the other way. Why
tolerate DCD divergence from the status quo?

