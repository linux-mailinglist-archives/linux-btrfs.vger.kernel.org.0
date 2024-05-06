Return-Path: <linux-btrfs+bounces-4781-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 887118BD376
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 May 2024 18:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA9871C21964
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 May 2024 16:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67056157485;
	Mon,  6 May 2024 16:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="keNNG/ZD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A3A13DDD8;
	Mon,  6 May 2024 16:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715014617; cv=fail; b=PhbWiNND0G+IjSaaFXnC31TbSsMDLtXc+LwGaoLWmJPuGIM372l1EvVMg2YxvU09k8u3eMUHHi6x6iwlRGUPyTPgmoBbo1kkmk9b/lJQ2WrnIZXJj9oqgl1lxdPTpnNbmIvwFKP+pp1r80QoZicZtb/G+Va9qxbto7nqbhmiz98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715014617; c=relaxed/simple;
	bh=LRR43HiivhXqN5zWXwbpZnXiwCsMdnJUHiAxfhVOtu8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=a338rDgX5HOwYEPmjJ4szwCg/PmjCPBH4srGodM6K7YuAR4PlisqZwC0AI0q2k7NnFWoB2SdYLzzBfq8i7LQNCzaIQjnRkryLiFwzgV0/69wu6ZD4MWKsOeQU2AE1cWshscNKbUsj3ZDOMtrGglXZdMO/T5gE4Ilg7E/hTyvyrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=keNNG/ZD; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715014615; x=1746550615;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=LRR43HiivhXqN5zWXwbpZnXiwCsMdnJUHiAxfhVOtu8=;
  b=keNNG/ZDc5fgRWiv8YMd0f3A/jF17qfnR9Q5Tl2OCqI+D0WfwRhiVKKI
   v77WGZrB6Ubh1pludsJA+yqrdae6X3pWejf9p/0E0XoYXEJqO9OjbUjx0
   0RcfRI9zUAlmgE8FghYH1XFNP/dMC90+YkvuDGttU8nLB8FfXn9FRnlbp
   WslsSBGh/da/p+zrDpPKCEeGw/jEXaJWh0kKqJ39kZeHlbeBnFGhcMlTS
   36sBhoz+qWkD6SOJQ1VW9S5OvWLqOtym0KFmf6gdrZENb0QO805C8HvQf
   pWXyY0n6MwBU8E3APwfK9yKpv/VslBaaxc3M2LMl0zR5btnq4pE0hcFYs
   A==;
X-CSE-ConnectionGUID: K7EMWaU/SGiN5Z9aqqHetg==
X-CSE-MsgGUID: oPYU7dbzQAaKJshBFeNb9Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="13722944"
X-IronPort-AV: E=Sophos;i="6.07,258,1708416000"; 
   d="scan'208";a="13722944"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 09:56:53 -0700
X-CSE-ConnectionGUID: KyfYfr20S5qPTyIJkOxs3Q==
X-CSE-MsgGUID: FD7VXddHT1qAca2yfBXCNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,258,1708416000"; 
   d="scan'208";a="33024772"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 May 2024 09:56:53 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 6 May 2024 09:56:52 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 6 May 2024 09:56:52 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 6 May 2024 09:56:52 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 6 May 2024 09:56:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f6T7ivBFD6Q5Tg5JNDKHUYSQrHmGo+GPQSJxzLVwUVllcXJbOR7MXcX2bfKCOPDPC0jLpi+sv1gN0hcNsFfOgHLEvNBjrc7n/mPD6iPhjXt7Wq/LO9cd3sfXkjUpRaFfX0ucFGW1rnTDFXXwclvUS3NKoSNPg8687HPcFumppyZVB6Rusp6TX4vhnAUHMylV+vGBl/a81dME6TibxnROH5aMOrTKHxduaQUb4WZHj5ZIUmfj98OQzKaljHxXa2aIzpfVPbpnoMx/hct5kUf24JgdKBfOToLT3LP8W4cN37su8vaL3V0idGUJqrrQkyxQ1ojOCJvuEqNZjIQt9lIkFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I74u/K6RY/Z00k1ovruIH6BBzkfrXt2BcISq1+EqOUk=;
 b=jOmuwNoe/KIOx3jRdh89IO0ciLSAbgcKPKDz3RlHXrGLkOkCMoUC4xSXyMRKbdjxuN9M0LSgFDa5ByggEqftcErXaXQSqYEwqO3Ebf4SpKwCXlkqzR25kwYbQPKpmN9yZr14ZOAfl7mdcCdELPQ3SC1//rYfCiMPzXtBLTFgNg/6VbrJOaIUBWhepRjHHUI3ybNk94wDnzEnmBN/YnkgQYkahRglYfNyTQimE/XTh3TjcAD0AFDjbvpYftH8i/6JSF7THIkbODpI+mHG1O19Zzn+ffzenw+ACISyd8PQGG4z7I8ZZ0zd2d5nxXeZc9gScdu9IbOUh+ZZI4Zt6zuUGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS7PR11MB7691.namprd11.prod.outlook.com (2603:10b6:8:e4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 16:56:43 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 16:56:43 +0000
Date: Mon, 6 May 2024 09:56:40 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>, Fan Ni
	<fan.ni@samsung.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Navneet
 Singh <navneet.singh@intel.com>
CC: Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Alison Schofield <alison.schofield@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	<linux-btrfs@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 13/26] cxl/mem: Configure dynamic capacity interrupts
Message-ID: <66390bc876ad7_2e2d22947e@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <20240324-dcd-type2-upstream-v1-13-b7b00d623625@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240324-dcd-type2-upstream-v1-13-b7b00d623625@intel.com>
X-ClientProxiedBy: MW4PR04CA0270.namprd04.prod.outlook.com
 (2603:10b6:303:88::35) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS7PR11MB7691:EE_
X-MS-Office365-Filtering-Correlation-Id: f87e2ad1-6070-4a44-c0b1-08dc6ded81ce
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qDmXECfMey37ZlIEqtDFGgZtjHrpapH7Z2Y8RLUOk39OGRIVbS3QPz0uB+0j?=
 =?us-ascii?Q?M2UcJBT2WJ9NMx2mtJcm3BUzc5erb8r8BsHg0M3SImF2lNuKZV6GMRdWHfYu?=
 =?us-ascii?Q?kX+BQ6NAx7+OkdenJTdSM6Wh3jEbk9minkkwsSE7kLAu3zcTzHFfdgFkLcFl?=
 =?us-ascii?Q?nG0NcW39aD9BSPN7rgLXegRLM0OBcTXP05IkS7Lqx3+aUcRieVTYuoNztEJt?=
 =?us-ascii?Q?z80u42EIOGFoz5QePDJEio9nfjUHz6IsBql2udrp8V3puq1mZCxbU1AwbTVg?=
 =?us-ascii?Q?Fjws7aijH2aoUcHJRexQuwR6d0DIhuVhpQ3eeJAZnhMjoBSnvbJx5rxc6JH0?=
 =?us-ascii?Q?nORkyYkoXooqsN8Q9FNQXlRf4PcgSYi5ku2/fo9B/yNOV6rU988S4OOYzmZx?=
 =?us-ascii?Q?ApAXjnTl+SqEpSVXemgUXXOz8NJk0qsoJzwyh2Uf0TQZ+qrTpTKNbts85Bxf?=
 =?us-ascii?Q?T1mAZuchgNpMM+sdvu2KeL6LAT9BtTYz+fVC6tT8kHlwZMLbKt8S4JbwpZhz?=
 =?us-ascii?Q?pZy2zHMMtrtaNCh37+oDcxmCGs4hQDNbK5FGSwYalq7o3wid2vWrA87bb2Sp?=
 =?us-ascii?Q?rcuTKpptbbXB108+8fT7zk4UR3WRi50wkmBfNts+CYRi+1e+U05BkutQ7IT7?=
 =?us-ascii?Q?moVowaoR0GmC+ykl9EnTuaSzt8MfkMjRbjhJ614GB6CYTQEeinPzZJhL+UAP?=
 =?us-ascii?Q?jYp8VFA9lsMRfoCeP9AqIxgCPiNp9ue6y3r1FCE8NYJ/D50mFVYS1tXzCRNQ?=
 =?us-ascii?Q?6O5ZhvWFWtYtXXwF9NSfTwK7ujDkcoVFJkizIAQmPjTzLgWSR5n6cyUKDosh?=
 =?us-ascii?Q?kcO+srXsJsXr5L6CyXPmmG7bkZw1hoEAvAUBxO6NRUJOMtMTaWtCO2U+JzNg?=
 =?us-ascii?Q?645TqzuAJu/S9LXqrXkjQvmitVj0czDN7iAw+pFPEbwMUz4nIDFNO6VA50Gw?=
 =?us-ascii?Q?jH4GLMQ6aidsg5Nz0MyB4j5r4dYq5q70XJgrWG/aL41/pVzYUSgSR8FxljbE?=
 =?us-ascii?Q?0O18AzoaVvgVlWHFIRKH+YXUQySxyr04cTY52fKfiu/JWvvRS1Sf2Y8CeJKq?=
 =?us-ascii?Q?LRhbolSeA5cO8xQF0kQ0MOY5V60ALNIxBKA5I8xPUfICEfIlnGY2Vzmi6qhx?=
 =?us-ascii?Q?4XC8Hc88Kg55umv/rFCzUCriYQ/AJQOIrw93q+k7BKfVRXHjZ3jt1VXdb4Jc?=
 =?us-ascii?Q?PjVN6cpwPy7zm/MhD1FFI3tUAxnPjMmdW/MCOpNBILLdBkHKNwBLXEx4m+6r?=
 =?us-ascii?Q?kKeeiPrhKvSOyQ8GhX05NzoLhgphOQUQq5gCt8zG4g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NJuU/JoCHMGlMvmbdek8Zd/5eHDaZLh1uaRa6wpxiFb8TDZ36KInEgKpbHTO?=
 =?us-ascii?Q?JRi/K7XKqNtgGc2Vh/E9JtLex0g0lDF50Mr53mAYEAPhxGfeHqJqLMoC/Ao3?=
 =?us-ascii?Q?nTe5yUSeATc+LiueMk0Lglgs1Rtho+imTq1M8me33KeBVqtLHmJVR86ecnKp?=
 =?us-ascii?Q?ooiThTJlmWlejr/7TOw8r+HE1Iqn+w5WKniEr0mfWUJHJYCOYHh/DnUEoyzw?=
 =?us-ascii?Q?j/njvQGjPP2pGewzCfH8GYrXrXT0NPQRN7SUO/gsM5HL15c5Dj2yn2/B2Be7?=
 =?us-ascii?Q?v3SKevl+DmMR+HPuGThx6DPWXbeefSqbywCSHe4mJPsXQtgvpZXWlwvW+szB?=
 =?us-ascii?Q?o7Zqh0NJ+qE2qn9GKCUN7P+8Y78e6NE8ZrCa2W1eNo7CQEfbOQig/pid/mQj?=
 =?us-ascii?Q?aGqqCdyb94NCML58ZFm199X2cgHGHbwOA9D9pJppCqxZtR2l9/aPy+09Uczm?=
 =?us-ascii?Q?ii+COGn0woTK9Ap1tm5LW0/2vBLBWEKpaUr9weF47I4GREYNdPixu37YXtzr?=
 =?us-ascii?Q?SxweFo5nPkqce1LgoQm9VPkfprCD80+IN7A/hZAV1wu1x+dt42vydKwsHCCn?=
 =?us-ascii?Q?upHlXCss608UZ9M7r8s/Qir53z4JuZMjhitFyWBPOaZHUJfXVs/H6cUx/cSX?=
 =?us-ascii?Q?lqzKKhVOlOCizbNReQaaZUprGo6e8A1x+2KHcwpQghaZPP96Uf4Oepy1BWuh?=
 =?us-ascii?Q?6ssfyuZW6MN07rG6jbNK+bD37ZzUEEu0DzimHyPhNuuzHx9ZRQAaRKTYBfbX?=
 =?us-ascii?Q?HfzZFvq+2akg9WoYmegpjwSPg3lbRX/7fchUHzn5pRnl5gWX7rLPYkS9p+mM?=
 =?us-ascii?Q?7dwosik3bMDzSYu4kuSx3a3TWF2FHkr3gRPPEviao5BBJRT80mgcawK6XzgK?=
 =?us-ascii?Q?P3nnOOTfYhESF0pY0TtDj0O2zAHZkifrlcm9dk0Fhia4vDlziml1mkfnvaCK?=
 =?us-ascii?Q?FyNTvSkH3ICJ6lsmieOQvH7sknW0+fjGyQRE0qvefPcFw7wDRycpiWWBdFmc?=
 =?us-ascii?Q?D6aPdRDaUoEvbpMhAEF3TE6Qswk8JXrQA6cm5ETXZEEDaOanNJDTSnx8p0EJ?=
 =?us-ascii?Q?PAKFdu9g/wq7QNCAfs2iZw8u1Dy9Uek3qlvfu6iL1hkztVTpGAShbWTmbe2k?=
 =?us-ascii?Q?c8kRD3TH66QSqConUopNKLbLiB7Xodn8CjsRugqb9VQvh+DzcOgeleqjPXfE?=
 =?us-ascii?Q?8NN3+YSNjkylND7XEZ0qYjcqq/Hzxa4lSBSAAOjKrEeByB7HiJbUDjReKniD?=
 =?us-ascii?Q?AG1nKu/PxcgXLdUQGjit9sHbOcW1/3EoSRcC6ar0sAIxO7z6wmsn9c2HwGrB?=
 =?us-ascii?Q?Oel8qGCsyRJ7Rtu72dbCQLXCzOZq74lKvJDCWbRQA9SpvVwx0frzosuf3X7V?=
 =?us-ascii?Q?sv6T/tKB4UZQsbS+JjGEOvDWHl2Sc4EVKU/4MpW1vwF/YXfAduxx4TpJRZt6?=
 =?us-ascii?Q?5xQgyviVpGGDlzSt0XPFb9cY/9UttORBx5nqNs/T8PlvUa0Zr7Zp8j1B5Nb7?=
 =?us-ascii?Q?dr+mmRglWGV4E2P8H8yEYZIp4cG2oL2az8MTbehhY7f0SyRGXf9qp9XP8EAT?=
 =?us-ascii?Q?3wff3UmAYiCDn1UgrAORHQaocJLebt5yN1JIy1iolh5XiKXSM0El7q0T6Vk+?=
 =?us-ascii?Q?5Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f87e2ad1-6070-4a44-c0b1-08dc6ded81ce
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 16:56:43.3831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f4F/ML9HOwa7Zc7sxDPuI4/BKcy84CkfYcDNy9INwVdLQMBAk6RPWCHwbgdeJixiInEptt4voS2StoyaoKxOs7gxLw62zAZiKJySwsadRnI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7691
X-OriginatorOrg: intel.com

ira.weiny@ wrote:
> From: Navneet Singh <navneet.singh@intel.com>
> 
> Dynamic Capacity Devices (DCD) support extent change notifications
> through the event log mechanism.  The interrupt mailbox commands were
> extended in CXL 3.1 to support these notifications.
> 
> Firmware can't configure DCD events to be FW controlled but can retain
> control of memory events.  Split irq configuration of memory events and
> DCD events to allow for FW control of memory events while DCD is host
> controlled.
> 
> Configure DCD event log interrupts on devices supporting dynamic
> capacity.  Disable DCD if interrupts are not supported.
> 
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes for v1
> [iweiny: rebase to upstream irq code]
> [iweiny: disable DCD if irqs not supported]
> ---
>  drivers/cxl/core/mbox.c |  9 ++++++-
>  drivers/cxl/cxl.h       |  4 ++-
>  drivers/cxl/cxlmem.h    |  4 +++
>  drivers/cxl/pci.c       | 71 ++++++++++++++++++++++++++++++++++++++++---------
>  4 files changed, 74 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 14e8a7528a8b..58b31fa47b93 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1323,10 +1323,17 @@ static int cxl_get_dc_config(struct cxl_memdev_state *mds, u8 start_region,
>  	return rc;
>  }
>  
> -static bool cxl_dcd_supported(struct cxl_memdev_state *mds)
> +bool cxl_dcd_supported(struct cxl_memdev_state *mds)
>  {
>  	return test_bit(CXL_DCD_ENABLED_GET_CONFIG, mds->dcd_cmds);
>  }
> +EXPORT_SYMBOL_NS_GPL(cxl_dcd_supported, CXL);
> +
> +void cxl_disable_dcd(struct cxl_memdev_state *mds)
> +{
> +	clear_bit(CXL_DCD_ENABLED_GET_CONFIG, mds->dcd_cmds);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_disable_dcd, CXL);

Just use the open-coded bit ops, or local / static helpers because these
helpers do not consume any other infra from core/mbox.c.

>  /**
>   * cxl_dev_dynamic_capacity_identify() - Reads the dynamic capacity
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 15d418b3bc9b..d585f5fdd3ae 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -164,11 +164,13 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
>  #define CXLDEV_EVENT_STATUS_WARN		BIT(1)
>  #define CXLDEV_EVENT_STATUS_FAIL		BIT(2)
>  #define CXLDEV_EVENT_STATUS_FATAL		BIT(3)
> +#define CXLDEV_EVENT_STATUS_DCD			BIT(4)
>  
>  #define CXLDEV_EVENT_STATUS_ALL (CXLDEV_EVENT_STATUS_INFO |	\
>  				 CXLDEV_EVENT_STATUS_WARN |	\
>  				 CXLDEV_EVENT_STATUS_FAIL |	\
> -				 CXLDEV_EVENT_STATUS_FATAL)
> +				 CXLDEV_EVENT_STATUS_FATAL|	\
> +				 CXLDEV_EVENT_STATUS_DCD)
>  
>  /* CXL rev 3.0 section 8.2.9.2.4; Table 8-52 */
>  #define CXLDEV_EVENT_INT_MODE_MASK	GENMASK(1, 0)
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 4624cf612c1e..01bee6eedff3 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -225,7 +225,9 @@ struct cxl_event_interrupt_policy {
>  	u8 warn_settings;
>  	u8 failure_settings;
>  	u8 fatal_settings;
> +	u8 dcd_settings;
>  } __packed;
> +#define CXL_EVENT_INT_POLICY_BASE_SIZE 4 /* info, warn, failure, fatal */
>  
>  /**
>   * struct cxl_event_state - Event log driver state
> @@ -890,6 +892,8 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
>  			    enum cxl_event_log_type type,
>  			    enum cxl_event_type event_type,
>  			    const uuid_t *uuid, union cxl_event *evt);
> +bool cxl_dcd_supported(struct cxl_memdev_state *mds);
> +void cxl_disable_dcd(struct cxl_memdev_state *mds);
>  int cxl_set_timestamp(struct cxl_memdev_state *mds);
>  int cxl_poison_state_init(struct cxl_memdev_state *mds);
>  int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 12cd5d399230..ef482eae09e9 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -669,22 +669,33 @@ static int cxl_event_get_int_policy(struct cxl_memdev_state *mds,
>  }
>  
>  static int cxl_event_config_msgnums(struct cxl_memdev_state *mds,
> -				    struct cxl_event_interrupt_policy *policy)
> +				    struct cxl_event_interrupt_policy *policy,
> +				    bool native_cxl)
>  {
>  	struct cxl_mbox_cmd mbox_cmd;
> +	size_t size_in;
>  	int rc;
>  
> -	*policy = (struct cxl_event_interrupt_policy) {
> -		.info_settings = CXL_INT_MSI_MSIX,
> -		.warn_settings = CXL_INT_MSI_MSIX,
> -		.failure_settings = CXL_INT_MSI_MSIX,
> -		.fatal_settings = CXL_INT_MSI_MSIX,
> -	};
> +	if (native_cxl) {
> +		*policy = (struct cxl_event_interrupt_policy) {
> +			.info_settings = CXL_INT_MSI_MSIX,
> +			.warn_settings = CXL_INT_MSI_MSIX,
> +			.failure_settings = CXL_INT_MSI_MSIX,
> +			.fatal_settings = CXL_INT_MSI_MSIX,
> +			.dcd_settings = 0,

No need to initialize dcd_settings.

> +		};
> +	}
> +	size_in = CXL_EVENT_INT_POLICY_BASE_SIZE;

Let's skip adding this new #define and make it explicit, i.e. wihtout
needing to crack open the spec, that the dcd settings are incremental to
the original payload size:

    size_in = offsetof(typeof(*policy), dcd_settings);

> +
> +	if (cxl_dcd_supported(mds)) {
> +		policy->dcd_settings = CXL_INT_MSI_MSIX;
> +		size_in += sizeof(policy->dcd_settings);

...and then this can just be:

	size_in = sizeof(*policy);

> +	}
>  
>  	mbox_cmd = (struct cxl_mbox_cmd) {
>  		.opcode = CXL_MBOX_OP_SET_EVT_INT_POLICY,
>  		.payload_in = policy,
> -		.size_in = sizeof(*policy),
> +		.size_in = size_in,
>  	};
>  
>  	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> @@ -731,6 +742,31 @@ static int cxl_event_irqsetup(struct cxl_memdev_state *mds,
>  	return 0;
>  }
>  
> +static int cxl_irqsetup(struct cxl_memdev_state *mds,
> +			struct cxl_event_interrupt_policy *policy,
> +			bool native_cxl)
> +{
> +	struct cxl_dev_state *cxlds = &mds->cxlds;
> +	int rc;
> +
> +	if (native_cxl) {
> +		rc = cxl_event_irqsetup(mds, policy);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	if (cxl_dcd_supported(mds)) {
> +		rc = cxl_event_req_irq(cxlds, policy->dcd_settings);
> +		if (rc) {
> +			dev_err(cxlds->dev, "Failed to get interrupt for DCD event log\n");
> +			cxl_disable_dcd(mds);
> +			return rc;
> +		}
> +	}

I think this could be simplified if cxl_event_req_irq() simply skipped
the non CXL_INT_MSI_MSIX modes. I.e. cxl_event_req_irq() is being too
strict after the policy settings have already run the gauntlet.

