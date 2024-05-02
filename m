Return-Path: <linux-btrfs+bounces-4679-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C148BA1F7
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 May 2024 23:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50D9F1F217F1
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 May 2024 21:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116EB181BB1;
	Thu,  2 May 2024 21:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RGNkjK7+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB2C1E86E;
	Thu,  2 May 2024 21:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714684355; cv=fail; b=cG0H5wlZvpr7DhIVDXUBORm93VAPyarscRLWsKtiC9Jf6SqCFnbBaL7FkGABNtJEP0Q/JTCwbgPttrTj/vl54BYLJ9uESTRq1pSPw0Cd5PKoXB/2eF8vNqf0C5ZHWDv/Lap3wHh6I3Yvnt+5Iaz+E/XCWfK2UyoivV56ZNvRz2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714684355; c=relaxed/simple;
	bh=egMeb48Vj5d4GDdURveO+eyhz8qJlf3ZhxjPa2NXZA0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZI5REsnbeYPMYRTsu8p9E2xqJytxEPu68zRdn9T6ikIAnYSdWo/Cm47Ik/hlJPeUY3Gl1KiOWRp3Pq6dwt2GeXyUmPFKrsBU/E+/68KjwwyYRsR55xWhOLeMTXXSezH+SUZlmX60ay9eMO2AUhzr0LRSf5wdsDqhvFrGUE6YHqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RGNkjK7+; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714684352; x=1746220352;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=egMeb48Vj5d4GDdURveO+eyhz8qJlf3ZhxjPa2NXZA0=;
  b=RGNkjK7+ldsppDdg6Of4n7qlQTgRYGDO6jdCXhyo1lTVbKzZv2+VJFF6
   Ut9RWSOSsTa9hsWtPsIgejCsqQX7iKGtjpBM+dabpi/6TaSxku73S6JlK
   412BtCiCpJz3N5j+3omUrIr5Zv5i0goA1E2Tz1+WtLQUJ8uarwtiY0Xw6
   dqMvxFJRHcByN50MRMJQ/zVVm30D0MzKM+bRz8CpzMLZzByAdNP8x7Vw5
   ovhFFnrhaGUkM7kAf5zfaZKGJYJyWFYhQ2aX18CWt2L3IF37RfHfsf4YE
   5vv5HUtzsfe4SKQ8P855El3uOzP3SsrV0waK3PFS0C6/1Oi+2sZhm4vf0
   g==;
X-CSE-ConnectionGUID: /yrZfERnS7GsmMZpwVJJPA==
X-CSE-MsgGUID: ishlqaDoSLmPdsRg7u6e8g==
X-IronPort-AV: E=McAfee;i="6600,9927,11062"; a="21626735"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="21626735"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 14:12:31 -0700
X-CSE-ConnectionGUID: wcrRftdgQ8CJcYmOTvt1pA==
X-CSE-MsgGUID: PnYYStRURe+6ylKa9FXQmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="31751528"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 May 2024 14:12:31 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 2 May 2024 14:12:31 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 2 May 2024 14:12:31 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 2 May 2024 14:12:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QCfHnrYgpEW9DYwh3f9IxSqegqbGM0EN5frWyEhwfSFQG2630YAdl/smhTQyErqELs99nOAH3+Dz0HwsrofyGXzIF5ck9wuxIja+mqaTw8+QWcxBZFykliXo6MlEyjjt7IgEvwo0vqdFtxuQrsK1/JKXlo6eRET9F5Uv4wiE/0eaI+M1no4QraYqdyF0oUKullp1bmAyrb7fZVCTwegR9zQ9V1gKqSZ/OzTZuj3BJoAx307PB7vyPe5s8zgmfQZDx0XIGKDaRP0DMbW80AgMLF52h1ok0pdfYZPJLkOZEupifbjSQYpEKlWJaaguZcfvC9Z84KvNoIN9BKmuBB+qNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9fpTDcr4b2vcR8SeGXI4TrLHu/qIzNPW7tXcTC0g+6o=;
 b=hsZObpYYpKUY7lJwLnbYHEnDTUStJr089XOzvpmBr9nVUa+smI2bbKgJZA4RGe5FhjVImJNq34MRXz0lZz4WA7KweVbDoQR+xZ7p/UWMjhd/dRkXZ3VaZS5KV314fOWmjQvQ7jM0pWW4WNJatcV/A70vBxpTh9w1cc3Ct52sq8rws+Ic1g6YyPmww9tVmdPs6HKABjOc/Q8AQ21gE2ab2Qd95lH9ZcGCw5bktULU2DkAzVBRC79bCR78JO6Xccrj+xTut3lU2XYtAr4w35CW7nyIRdSIG2BoxpavTKPlO2QJuJZ9U1UXvFzrLlJPTRjxGSJWgXD9AVZF6Ou8OyOUaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA3PR11MB8022.namprd11.prod.outlook.com (2603:10b6:806:2fe::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Thu, 2 May
 2024 21:12:28 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.7519.031; Thu, 2 May 2024
 21:12:28 +0000
Date: Thu, 2 May 2024 14:12:26 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Ira Weiny <ira.weiny@intel.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Navneet
 Singh" <navneet.singh@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-btrfs@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 16/26] cxl/extent: Realize extent devices
Message-ID: <663401ba2e237_1384629438@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <20240324-dcd-type2-upstream-v1-16-b7b00d623625@intel.com>
 <20240404173241.00003a6f@Huawei.com>
 <6630641e5238e_e1f5829431@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6630641e5238e_e1f5829431@iweiny-mobl.notmuch>
X-ClientProxiedBy: MW4PR03CA0138.namprd03.prod.outlook.com
 (2603:10b6:303:8c::23) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA3PR11MB8022:EE_
X-MS-Office365-Filtering-Correlation-Id: f7e6e7c9-3071-4796-80d6-08dc6aec92b8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9iFwAvHKAqMXphVZR43hH9kmXw6ThOsRmA8KhAXTIZBRWiWX0ftlqOVZjxum?=
 =?us-ascii?Q?froy3KopscMq5NEmhYWkG8ZJtDncc+t/k0M2QsatkuAALd1686s/VM85kxDJ?=
 =?us-ascii?Q?C0tNgPkMgwU2HfsmY1lpZNk7MRE41I7hfXEIigAIXAxHpAQKP0hTeWuTNYnY?=
 =?us-ascii?Q?3RR5qd1LNkCbujVwXWFZ5G/7lR9j+712Qv4BekxzG9Ut4dEaifTRGLbn3um8?=
 =?us-ascii?Q?XVGD7teUwttIxKY+5BR8TwiSaFmQm/2Z60G+C2v/6uDxEWsS4ppNcxuvT9/X?=
 =?us-ascii?Q?cLEJ73X5LAdTNFn5dbSV+8Ib4hCuDAeNSx8lv3FHkAsMn0LHnnhAjNbQhDOP?=
 =?us-ascii?Q?j3ooh3e0BwWbQwyjMMaDQ6cCUURlG+XVXUGyWgbHs8TAiE3P2B/AGeP6BETc?=
 =?us-ascii?Q?rx1N/K/kQymMKznCWzkRzmVz6TC+dbZjkXYl2bnKDA7lChdEEq93Mfmp0UoO?=
 =?us-ascii?Q?gJU2AS+KriFckfu5YGyrLjFyLMCAsPdg/EBWQZ5DCt867mAna/ZkxkFvOuEg?=
 =?us-ascii?Q?ZYhS/BYeI1cxB799L1PhOK103bDJ+CsR44dEM6pOfCKtc2LA4w8HXsDFt++2?=
 =?us-ascii?Q?SRoPT8Vgeyx0cT4195uv2D4hgjcM14LiajUol+/U+/UFZmiMNR5zQNCZCnM7?=
 =?us-ascii?Q?fPw2U/52lZwwUh1r7eHJQhucf/y3DyMp2CD7I3qAFCj7tNqEsrgZV8v47H0A?=
 =?us-ascii?Q?IHyG/Hy2gtVMdR4sOKMMTN2PrUZyyh4x6xAQuxvcH66NCi5l9MOM/oSxoEv0?=
 =?us-ascii?Q?Q1gd5jyxmRPuBwjqXAzaAOvruF3Vgh4DWQouVZbUXyIhDcNpDPtyYeDucSJK?=
 =?us-ascii?Q?CFuJKRA4VL/weypk06sjWIPraoKKCugkLl+Uy4NU5HfYVQqcf0v1V/y2g0BU?=
 =?us-ascii?Q?emRKTKKMTo0osXNZUoNFixmjcupNpgHy6ydbuGgAGxHiKCFUu5dVmDX5xsVu?=
 =?us-ascii?Q?KSaWiNgLhJhESaTLItmt/opMGkrwuaQ3auSj0K1IzZrlBPAYhoi6XapNZqe9?=
 =?us-ascii?Q?wEFCe+J7QqxOCicBQVGl8iiit8APTuDIFbtO0Lzasj/WzewdTGv0yMvI9QcC?=
 =?us-ascii?Q?MkwHEMOyThQ9/nCPj37qkaNM6+t9wBeF07LJtq3tqsakAqleXPzp4JmDQ1Ti?=
 =?us-ascii?Q?tFA3TbARI+FfxQdSkTJYWi9Ui2CFIe8MdF7VWPxMIi7ILCiT7JYZ28AnBlPz?=
 =?us-ascii?Q?3lHr1IyZb3YzTP11jIqGcwky/12K/jYY/iKB+2TR8zpE8uKzjl8BObLZwI9L?=
 =?us-ascii?Q?MejLjpKAgdlw3Ju7D2IQyPz36CKfwUFrE6y1vjMfVg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LC254O9NN5Noc/1aDi1BMpSvn899fgwTEuH34VtgHxwCd6Oywl4Dn6TW5Xka?=
 =?us-ascii?Q?BmL1CO+K0iVRdBeoS/p02bhuCNxaqOPPXddcQf0RnTJX/dBmXlOX0r6GY1pO?=
 =?us-ascii?Q?SF3A/aVewrjgj/wVgfznDzGhnz5Ql/Qap40Lz3IceP4tMYJHCPTRy7pIbQV4?=
 =?us-ascii?Q?EG/bBASCzwREkpuNddH5qi/rI9EpjdT8aQORu53evrbfr63W4payQ1MQDTUA?=
 =?us-ascii?Q?1E7DWGhhuTocQIePRmFA8inBKqbbeGg5LEdfHl/fb8CNH4y2A5lf/u1oCUZ2?=
 =?us-ascii?Q?TgupYbT0dCv2QmG24raE2UjgW7gPcn8Gr4WIhfpAOji0pjSocAP95GdTEK/5?=
 =?us-ascii?Q?omGB/yeMahkNkC0g5q5QepujoqJeegCg8vulJ+FTcLAqDpZjVeTN9zBboPsa?=
 =?us-ascii?Q?MGPJs2OCV/tBJg3z6yrme1DKleDSwG+eFJ7VK0ym366ufUqVPFwB5eoaUB5n?=
 =?us-ascii?Q?AsBbmayJGsxrFVqKiL5FMgNza5+TothlIC28/l4e+rjDBMe40PpSWkgV8vXm?=
 =?us-ascii?Q?Fx+z1Q3F7lWRQ/bqzvGv0Xylak26QaL1zLRs6lgOGjI3cfgVY11QMRf3U5mZ?=
 =?us-ascii?Q?5YVTwPd+W0AILR9JPWE52AHB26b8RkoZeiPtgcR3LrkkLGSgYOfAkpaFzjoE?=
 =?us-ascii?Q?0EPOy6P13qeSedi8ENi5BhCNVXeDAI+TjPSJXAmyRVUjSVSfBepHmlg2CR0b?=
 =?us-ascii?Q?+RW7V9YrrAo/gPtjkOL//qrjHTve+WiPaMaWn64zO8J62LkZ/GhszBmVpL6X?=
 =?us-ascii?Q?PO7yjKJ71GUH+NZUTO2fGoQsDXHN9xBpPkBRy1tuCdLFC2rTnjJPrEHnpCaw?=
 =?us-ascii?Q?og7gGomiMq2KbVhIOFdMHi+8EuBarI4tHXhEmumq0dSKFsHRWkrM7OdW+tji?=
 =?us-ascii?Q?5xHa240P1hdvvR+tdEpewpRh+sZzBcudB39qN2W7jT14il/ySu4hUbdUN/vs?=
 =?us-ascii?Q?SRF/OE28QmMA0ufEDKCdffkoctrgz19qyKEtxLfohC5/9YiGwFij09O0Y12h?=
 =?us-ascii?Q?q98ohbTy3zIZ6ozoxaZlTJIBQUwDruWpoZEmT4PbD998deYbXhgpXVmYCbTB?=
 =?us-ascii?Q?TrbIrBYMc+f2rJKFznX4fwWW58QC3gr90l36+fyUXRFUX67aWLA5CKIxze6l?=
 =?us-ascii?Q?MJXWAUXjU/ag05Ti+yUR1P2zNV6CvffdbrZUCJ1fY3aBeHzEqo0YgfMW23Xr?=
 =?us-ascii?Q?I9lSi1zNwBj/YwHl5yQvM+PS1Z9F6VpWCgVorpFGnmax5iQ1LQG9nRfsLvxQ?=
 =?us-ascii?Q?LleFSYV8oG49B76YOxcKy5IPYsNYXg8dwvOcVBfaTrhPWbQGiHTIV5e+d4yQ?=
 =?us-ascii?Q?mURN8/RC4AzTmVU/DVF5rgWufbFz4jWAm1w/tM91Vg6pymaEm9piZhwiR+yy?=
 =?us-ascii?Q?kgGOJh4qw+2mTioSChhLBBzZJ90DZWyDlqpTjkv+kavtXFt/zX/H/EfIqup5?=
 =?us-ascii?Q?9gR/C0soPsKIMqPxEn/eqnT/V1xTsDO4l+mFon0BkMRYbRZmF5fYwvCIIGz5?=
 =?us-ascii?Q?fwP+ukMOJenKO7Xt5mGvl5idrEAdDSS9V4o1ifYCiWpOi8z0HLRFkGbVO5o6?=
 =?us-ascii?Q?WU5O+YiFnQLRLk/75Vr2xoVBKC9rMFj10is/IdYOSUAFnsxZFNn+V2a7xTwP?=
 =?us-ascii?Q?Fg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f7e6e7c9-3071-4796-80d6-08dc6aec92b8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 21:12:28.7808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PFlNIz1rUFV8WPykuYJCHwffDn7gh/PVOe2S0WjLSHkqX/V30XRNTEbWDg5Xe05pgL/2uWaMPR6Uw4cbVz7VmInmI6z2Yv6ZhFW1egipAP0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8022
X-OriginatorOrg: intel.com

Ira Weiny wrote:
> Jonathan Cameron wrote:
> > On Sun, 24 Mar 2024 16:18:19 -0700
> > ira.weiny@intel.com wrote:
> > 
> > > From: Navneet Singh <navneet.singh@intel.com>
> > > 
> > > Once all extents of an interleave set are present a region must
> > > surface an extent to the region.
> > > 
> > > Without interleaving; endpoint decoder and region extents have a 1:1
> > > relationship.  Future support for IW > 1 will maintain a N:1
> > > relationship between the device extents and region extents.
> > > 
> > > Create a region extent device for every device extent found.  Release of
> > > the extent device triggers a response to the underlying hardware extent.
> > > 
> > > There is no strong use case to support the addition of extents which
> > > overlap previously accepted extent ranges.  Reject such new extents
> > > until such time as a good use case emerges.
> > > 
> > > Expose the necessary details of region extents by creating the following
> > > sysfs entries.
> > > 
> > > 	/sys/bus/cxl/devices/dax_regionX/extentY
> > > 	/sys/bus/cxl/devices/dax_regionX/extentY/offset
> > > 	/sys/bus/cxl/devices/dax_regionX/extentY/length
> > > 	/sys/bus/cxl/devices/dax_regionX/extentY/label
> > 
> > Docs?
> 
> That is a good idea.
> 
> > The label in particular worries me a little as I'm not sure what
> > is in it.
> 
> I envisioned a pass through of the tag.
> 
> >
> > If it's the tag one possible format is a uuid (not a coincidence
> > that it is the same length) and interpreting that as characters isn't
> > going to get us far.  I wonder if we have to treat it as a binary attr
> > given we have no idea what it is.
> 
> In thinking about this more (and running some experiments): none of these are
> strictly necessary in this initial implementation.  No code currently uses
> them directly.
> 
> I questioned these in the past and I've done so again over the weekend.
> 
> I was about to rip them out entirely when I remembered Gregory Price's
> comments on Discord.  There he indicating a desire to very carefully place
> dax devices.  Without at least the offset and length above (and to a
> lesser extent the label) this can't be done.

Careful placement of dax-devices physically requires an entirely new
allocation ABI. There is the mapping_store() interface that was added
for a specific kexec / VMM fast restore use case, but that never
envisioned the sparse region case. So I do think it is worthwhile to
punt on that question to a later add-on feature.
 
[..]
> I don't think this is exactly what the user is going to expect.  This can
> be resolved by by looking at the dax device mappings though.[0]  So I'm going
> to leave this for now.  But I expect some additional porcelain is going to
> be required to fully meet Gregory's requirements.

Not sure what the exact requirement is, but if it's the typical, "I want
to allocate by tag", then I think there is another potential coarse
grained solution that probably covers most cases. Allow multiple
dax_regions per cxl_dcd_regions, where each dax_region manages an
exclusive set of tags.

The host negotiates a dax_region tag layout with the orchestrator and
can then trust that all of the extents that show up in a given dax_region
belong to a given tag or set of tags.

This is not something that needs to be considered in the initial
enabling, but is potentially a way to avoid bolting-on a new fine grained
allocation api after the fact.


> [0]
> 	/sys/bus/dax/devices/daxX.Y/mapping[0..N]/start
> 	/sys/bus/dax/devices/daxX.Y/mapping[0..N]/end
> 
> Back to the label field:  It is currently just the 'tag' of the individual
> extent (because no interleaving).  My vision for the interleave case would
> be for the kernel to assemble device extents into a region extent only if
> the tags match and export that.
> 
> Thinking on it more though we should leave label out for now.  This is the
> second time it has been questioned.

I don't understand the issue. That is a critical piece of information
and it is at the cxl device level

/sys/bus/cxl/devices/dax_regionX/extentY/label

...now I would just call that "tag" and UUID format it (to Jonathan's
point), but I see no rationale to hide what is most likely the most
useful information about an extent.

