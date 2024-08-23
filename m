Return-Path: <linux-btrfs+bounces-7419-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA2895C314
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2024 04:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E318A1C21FB8
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2024 02:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59D31D530;
	Fri, 23 Aug 2024 02:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mhKpeb8O"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F249917997;
	Fri, 23 Aug 2024 02:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724378527; cv=fail; b=EdYiF5tTsTLpJJ9otp472nbec73jC8khbbLit/ts/M5ajtzGO8vLh3ForHgQPCQlg/wf5aZjxIwgJfLzjhcwb2uyxs5qJcDYqvLJenNUwrBqWzohRc5pjAOScjvBUTEvWia2PpDNTYLC5Mfn5jS2JAH+Bv0SbbhIjNtojLnJseU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724378527; c=relaxed/simple;
	bh=KsllmmfyMj8BFvtqSRA3NwxnhHqKHTQomVoDb2Lvyl4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mKA6B2D6AEvrOrMPagmW1KjXIYNaItd8o3bMLsgIQD7V3M98JgA1dgYnINIdmXf58VB4vDEvnPXwcC+Wlxo3QsSj7n6Ipzd1UoIFBTB/sduxFsUK4VAD1DN5s7bqaCKh5a4HiHDH1ZrmgkwF2L2Vw7Jit4Et7nbnJoEfIOELLiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mhKpeb8O; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724378524; x=1755914524;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=KsllmmfyMj8BFvtqSRA3NwxnhHqKHTQomVoDb2Lvyl4=;
  b=mhKpeb8OfePEcTFtw7C+N6U09C0+dv5+iO8NzBROCB0ARm3SIGrhtUb4
   pBbDSsbhLEZubvEaZwM9ld6YVB7KyaKEw+8uZp9pqll3IbV09JZ8FBt4v
   OH9+TnBWim3KGNqZ9UeNhhjFFl8yJsWiwuHF0pUoTmr26xVX51a843WSa
   OyWTrfwSevkvC4Le7pl/T6Zbmr3AtQJ9GYHHx91In8FJl8kN9l9Lia+x5
   zn4f8bZgJXU7R7td08AUpfbG0YMo4YBLV/OWOq6jZ+LUQSjbBAdzZkFnL
   bv+hDuoC5pcDFpXGmj440us+WbpQhDoradegEwTGXa6fd2H4sg5AgYqiQ
   w==;
X-CSE-ConnectionGUID: ZTQeebKkS6KMtwAKC4wkJg==
X-CSE-MsgGUID: Kh0nCeXSTey5pqA13siwew==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="45348580"
X-IronPort-AV: E=Sophos;i="6.10,168,1719903600"; 
   d="scan'208";a="45348580"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 19:02:03 -0700
X-CSE-ConnectionGUID: pPe8IevGQ6ep0YnLYiyG+w==
X-CSE-MsgGUID: /Mj+AO+MQrWPWj74ecc13w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,168,1719903600"; 
   d="scan'208";a="62377621"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Aug 2024 19:02:03 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 22 Aug 2024 19:02:02 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 22 Aug 2024 19:02:02 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 22 Aug 2024 19:02:02 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 22 Aug 2024 19:02:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ta8Wpav/P1Jz4oFxsNOZgVJ/917+nZAg4NQf/mBvs07l115ww1SJM4I+L0lWO5QDgSw34VJksKe4ouS4ZVqfARWvIufwOk/Nk12MGSDDyOFIautrzApKOR3by1VVdfo8TrEf+RE1NHxmCLpu3Q1ySpNTII6XYPU/mqVNR+OSRPthLemBK1+sgeJbnFx4M1fnq5as9yTXG+I+ii3HjKwH7dMD+v2/WU7oQAR4dVPNLy42hxA6mOrJPEz7MKcUz79ud6/LRwLVw1/BiO8CNXb0vL2kJIgSD2rf0u1p5xoHAOKHbeGe6BCWM2d74KESRi0w4v6nD/YYpXI8JFpNYyBhwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=da24zGL50ggQZ5bXIrFLqrVmYU0un+wA3etiU2HgtZE=;
 b=SLQu+pxz76jsQkXD25MXIyYO/Fo4MOeSsmPQSZ8h1BkwQO19MYtTSytWSR/9tSObOqmbySc7UNlnV4h+HdNExurwTtWcZb5UqTdh/pDCpYsGHt6dTwmhRO+DMukvuj0mzZJn3czzwSbulFCH9KBcYItND6dlZPo94TbNt1Bc4unQ7/3cw9DI2nVF+T7NLwmMcgN94DoWObt6uXiD98AhALhwVB8NT/Ko2HEOgk651E9U707zHCV+F6PYZgUxeddY/W4VM4gdkL3jQjUEQXXP0p4AR/add9Y7rYCDt9zVfNVE3EUhdQcn8xuHhj6vLgtpQ7OtTxUTs0YrdITW2Q5fVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH8PR11MB8014.namprd11.prod.outlook.com (2603:10b6:510:23a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Fri, 23 Aug
 2024 02:01:58 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%6]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 02:01:58 +0000
Date: Thu, 22 Aug 2024 21:01:49 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Fan Ni <nifan.cxl@gmail.com>, Dave Jiang <dave.jiang@intel.com>
CC: <ira.weiny@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Navneet Singh <navneet.singh@intel.com>, Chris Mason <clm@fb.com>, "Josef
 Bacik" <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Petr Mladek
	<pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Rasmus Villemoes
	<linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>,
	Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, <linux-btrfs@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <nvdimm@lists.linux.dev>, "Li, Ming"
	<ming4.li@intel.com>
Subject: Re: [PATCH v3 06/25] cxl/mem: Read dynamic capacity configuration
 from the device
Message-ID: <66c7ed8dd34b2_1719d294f4@iweiny-mobl.notmuch>
References: <20240816-dcd-type2-upstream-v3-0-7c9b96cba6d7@intel.com>
 <20240816-dcd-type2-upstream-v3-6-7c9b96cba6d7@intel.com>
 <1ce9afe3-6f24-4471-8a10-5f4ea503e685@intel.com>
 <ZsTL1QQgYjVdfzqj@fan>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZsTL1QQgYjVdfzqj@fan>
X-ClientProxiedBy: MW4PR02CA0028.namprd02.prod.outlook.com
 (2603:10b6:303:16d::7) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH8PR11MB8014:EE_
X-MS-Office365-Filtering-Correlation-Id: 28d2b995-c89e-402a-c731-08dcc3179201
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2q8r7+0AHxBWFUaCrZhFKOD0meMC6alMP7NpceUACEC36KhePuIkBvcfiE3H?=
 =?us-ascii?Q?booOjG7V1L5gdlDEc5fz6hZr/mj+wWTaX+W+NvK0TrsXUE0vj/L7MO8Lw267?=
 =?us-ascii?Q?SCqS+yjSghde/PK9NIx6HKRJ0RYqMDV+TCu0+7Ia1F7jMO+9KU0PGebUMBLe?=
 =?us-ascii?Q?6czrUNde1WiM+03cV3zq0EGrbZkaRHw6b9TeGiizfJk8DUoVIRaSL1JfpsFB?=
 =?us-ascii?Q?HZ1RdWzN2ub6l6cHgV6uAMyLDZ+tbhJhBLBcjrs+8PTu4yDrs54by2eFBKgk?=
 =?us-ascii?Q?H2AY/FDBz6rXOIUHz7eDKQQrhKnlJtCQI85fbBW+93dqxUM5+q6cxhc2DPCw?=
 =?us-ascii?Q?wCVPQjcaUKO3hAEG8S9C5gijcy1gSrytuNmaKZFp8ju9wzJO0L/E44KlH8D4?=
 =?us-ascii?Q?YamOnqY1Nwli9/kUMmCZbJnFGc+5ovWIX5ZLIKZ7WbkxuVW6CNFxs0/Q8kNA?=
 =?us-ascii?Q?Zv6j/R+gDflPyXj12wuosw/oFR7QfzzNwGEA0qIUFZkURxITctaxN6EUjwnl?=
 =?us-ascii?Q?w7EX13V6/VkbIslgzl+lZ7aeNpSw8ashalZiR2a/IHHEmiwXE3DopqnWrDU3?=
 =?us-ascii?Q?zYDJPASVY9nZ7tYY2DlBBAltNLnC4gHdFJ8TvsOXe8bnzvJWB+YD7ti+Vz86?=
 =?us-ascii?Q?xM2BRGNfJH2gwieggzV0MOkvzCXRs81c9vI7KNaxl5Cjb/R2A+BgAZamxXPk?=
 =?us-ascii?Q?fV9oLe44IqP0CHFJW99bBEXvbBrOU9MBZpUHgt4ydG8Oe+f9gFDPnwWi0jdm?=
 =?us-ascii?Q?8Tr52pxv7X1xT9LPXp7Ipe29mAnFAYlxn/5rCb/cDx4kVBm7J0/FWAY89Ope?=
 =?us-ascii?Q?5e0e9Dc2OAXyvQTx+Kych5KqgvFzpHIML+mjNA0Ogyow4hhCykW54uxetwbz?=
 =?us-ascii?Q?sNuNIEG4W056RgCfQV+6MhWxlxgQ0ox6kghFBHA3RotwyviT5iYjDxaGfaJo?=
 =?us-ascii?Q?XaCmuozfd6Pfb3EtEv1lxL+PJ4vYh2hrMivW67X7d5FQ4fcoridTTjDCLqgq?=
 =?us-ascii?Q?FRYSugz63wbnO10Fsy/oXboAnv2ODhx9b1P81NINBt6NL+zTCzEz44gQU098?=
 =?us-ascii?Q?Yi/zR2b1+mgQfkG5QCHuiRca0+s5Gc7+IAjEO4sdP5FX2baaDPsFv3m5FFb0?=
 =?us-ascii?Q?5oJC0kxZUmQRg9Ir6TRjgns9Hgg+yCQP3khMbAgwlKw6H8mkOlhTP7+SLNkA?=
 =?us-ascii?Q?8IZVnLUJyi2c1cI7e0plL5Bpsu21b9uYor8aLro2STRDNckD84hkFUXWNYNF?=
 =?us-ascii?Q?UF8NeipzayKA5k2M6QBbFYelO53pAK5gq7+evw68Rw7mOf+spUE1mCO1WKDs?=
 =?us-ascii?Q?w3r+clbAushi3Jt+PB65L0CHXAfUCp4DMNw3ek9sBqKObQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OZiN2DZNO/UTCrQLUt3vZyusb+wFElt5xfF5PQHM2HIBqspIS9BpT1VaFo/C?=
 =?us-ascii?Q?WYBOwO05AIlbIC0+rc+YpMf8bD2COaq2msiBsBV8pxmOraK927XgOeLkHKIO?=
 =?us-ascii?Q?sol2V2b8pbyEXVnij/1cJDopMJSz4m8uAT84pUPYyJ/oi+3GqNcV1o5fuAcc?=
 =?us-ascii?Q?KQspQpjzby7MNj6wRVpfgDNNbmQ4egTN1i9eWDW6mgOq9QgRHUx1n6X+Ncla?=
 =?us-ascii?Q?S+eh5nlaqZIUNo7bAtvdOW3T5BISbohrKkhMhb0kosgwF2g+3uIgu2+d0Kw/?=
 =?us-ascii?Q?uznq68mUG/myLYZtLb4bsnSQ4qyVAz6CmKa5zbcNAtcSIccE6uA7uAr2tzcN?=
 =?us-ascii?Q?EPQ3scTP/4EXvd2ClzN6CiL5aOPywqadop87x1q8xTf2Nc29Xw4nfAXLi5Ir?=
 =?us-ascii?Q?Z1HDkRzaePQkmx3W2r2ASBLEJsm2X1wN7mJsyQf/MlxVN1UpBfHyMDqpmJYu?=
 =?us-ascii?Q?8zqKJa0R/efxM12dkf6eMTAOqGgocJ51/hp7Dw12ANP6060jMVqwyD4tCSgI?=
 =?us-ascii?Q?MulTzE8tOcocZIFum9Sa/YxGvSfdxR1Np4MsiW/8m58ivgaW9lcg9Ym3K49Y?=
 =?us-ascii?Q?Y6OV+LvTzjFmXLV9DAsQE+ae4iwHoiiVsB/kIQzbq+79xjJ+z32jcJzVe/0S?=
 =?us-ascii?Q?NVjbJUpAiIoWDFYFAjULX/04rYXVJlsRDoo756SMrCCVf5eDVlFCive2DQc1?=
 =?us-ascii?Q?BTFJ6ZN+8SdeF0Nu5+tNdv+U3pnonJaJl2Pokjb5dKEdajLFqzNv7SpJo1L+?=
 =?us-ascii?Q?H+gVSK9YntjCTH+SgO/J3dKbaYd+KtoONh31NiJcIEir8CsU/W2Flc/FY6jg?=
 =?us-ascii?Q?npEcDZ7Y0EMR1cRzXrvcTZPbK8eINLkpjbbG13BdEgBQY6BVIj9OszfhWsRj?=
 =?us-ascii?Q?ReJD+5EE+3rSXN0TccJRpVlgQmfXxLrD5qPnC4atwkKmOQgTC2qYWNSExLnF?=
 =?us-ascii?Q?DaWbMZwIFqsIYQMPzev9LG1MAQtPj+0TnqaoSowARxbUWrb4Urgm8AZyIj1F?=
 =?us-ascii?Q?XLlJnoHZ5WA3r+jfAqxqJwzDEahoxolDI36aE74G539oDtNNYHHtxE8AktN0?=
 =?us-ascii?Q?I0+0XNuMjr1882WCEsF/YFxf1ATGVyLWaGDPLq8BrPNlYo6V+RATRsFdMeza?=
 =?us-ascii?Q?+p2Hacl59d+JYwEpOs4S1S7EUnFsVQBOTxAt3lcgm4Fyhie2xquLNNy7QQb7?=
 =?us-ascii?Q?pIIOO/BBMvBZ17Vim/SjE42syOhYg3HgcxPl3uwn7TCBjxF70wIlBOMXmRzO?=
 =?us-ascii?Q?PSECZXm6fLUURPNZNbM5/bWqM62Hqy2tUkOBMfF2IDTAGm0lGi5Rk7tWJXdX?=
 =?us-ascii?Q?N2cxX8tVrfufKfR9U39sy3rrWAdFcAA4uExN073Z7YI+6u2927+euOSD2ftt?=
 =?us-ascii?Q?wQcNiVW+zxIk9lS8BrKdxDoSJjatI5IjZDpWsvgzwhvlFsENUAS6sK9yB2vr?=
 =?us-ascii?Q?ENJndV/LsWUzQpvHw5gdpUetRSOUgW7T54HkVEZzMFF35FQnKjLREnTZPnq9?=
 =?us-ascii?Q?Kg28ywzxGr5I0leQ1FHdgXpcc0gdj9m37xw/qMvTkuX8gplOvPWtUmJe1Ijn?=
 =?us-ascii?Q?mBW2pQiVp7tUr64HwMp22koAy63Hu+41gGGT6eoM?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 28d2b995-c89e-402a-c731-08dcc3179201
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 02:01:58.4030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2AAxvCK8iLtYO9oEra52w2m7rVh0fJ4Brh3peIeEjlz/h7AlZYzplUO1E3VbFAbtw+OW1QdWfNyL0AM6WM7zMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8014
X-OriginatorOrg: intel.com

Fan Ni wrote:
> On Fri, Aug 16, 2024 at 02:45:47PM -0700, Dave Jiang wrote:
> > 
> > > +
> > > +/**
> > > + * cxl_dev_dynamic_capacity_identify() - Reads the dynamic capacity
> > > + *					 information from the device.
> > > + * @mds: The memory device state
> > > + *
> > > + * Read Dynamic Capacity information from the device and populate the state
> > > + * structures for later use.
> > > + *
> > > + * Return: 0 if identify was executed successfully, -ERRNO on error.
> > > + */
> > > +int cxl_dev_dynamic_capacity_identify(struct cxl_memdev_state *mds)
> > > +{
> > > +	size_t dc_resp_size = mds->payload_size;
> > > +	struct device *dev = mds->cxlds.dev;
> > > +	u8 start_region, i;
> > > +
> > > +	for (i = 0; i < CXL_MAX_DC_REGION; i++)
> > > +		snprintf(mds->dc_region[i].name, CXL_DC_REGION_STRLEN, "<nil>");
> > > +
> > > +	if (!cxl_dcd_supported(mds)) {
> > > +		dev_dbg(dev, "DCD not supported\n");
> > > +		return 0;
> > > +	}
> > 
> > This should happen before you pre-format the name string? I would assume that if DCD is not supported then the dcd name sysfs attribs would be not be visible?
> > 

No this string is not used for sysfs.  It is used to label the dpa
resources...  That said in review I don't recall why it was necessary to
add the '<nil>' to them by default.  I'm actually going to remove that and
continue testing and if I recall where this was showing up I might add it
back in.

> > > +
> > > +	struct cxl_mbox_get_dc_config_out *dc_resp __free(kfree) =
> > > +					kvmalloc(dc_resp_size, GFP_KERNEL);
> > > +	if (!dc_resp)
> > > +		return -ENOMEM;
> > > +
> > > +	start_region = 0;
> > > +	do {
> > > +		int rc, j;
> > > +
> > > +		rc = cxl_get_dc_config(mds, start_region, dc_resp, dc_resp_size);
> > > +		if (rc < 0) {
> > > +			dev_dbg(dev, "Failed to get DC config: %d\n", rc);
> > > +			return rc;
> > > +		}
> > > +
> > > +		mds->nr_dc_region += rc;
> > > +
> > > +		if (mds->nr_dc_region < 1 || mds->nr_dc_region > CXL_MAX_DC_REGION) {
> > > +			dev_err(dev, "Invalid num of dynamic capacity regions %d\n",
> > > +				mds->nr_dc_region);
> > > +			return -EINVAL;
> > > +		}
> > > +
> > > +		for (i = start_region, j = 0; i < mds->nr_dc_region; i++, j++) {
> > 
> > This should be 'j < mds->nr_dc_region'? Otherwise if your start region say is '3' and you have '2' DC regions, you never enter the loop. Or does that not happen? I also wonder if you need to check if 'start_region + mds->nr_dc_region > CXL_MAX_DC_REGION'.
> > 
> That can not happen, start_region was updated to the number of regions
> has returned till now (not counting the current call), while
> nr_dc_region is the total number of regions returned till now (including
> the current call) as we update it above, so start_region should never be larger
> than nr_dc_region.

Yep.

> 
> > > +			rc = cxl_dc_save_region_info(mds, i, &dc_resp->region[j]);
> > > +			if (rc) {
> > > +				dev_dbg(dev, "Failed to save region info: %d\n", rc);
> 
> I am not sure why we sometimes use dev_err and sometimes we use dev_dbg
> here, if dcd is supported, error from getting dc configuration is an
> error to me.

We are trying to reduce the dev_err() use.  cxl_dc_save_region_info() has
dev_err() which is much more specific as to the error.  At worse this is
just redundant as a debug.

I'll remove it because the debug output is pretty verbose too.

Ira

> 
> Fan
> 
> > > +				return rc;
> > > +			}
> > > +		}
> > > +
> > > +		start_region = mds->nr_dc_region;
> > > +
> > > +	} while (mds->nr_dc_region < dc_resp->avail_region_count);
> > > +
> > > +	mds->dynamic_bytes =
> > > +		mds->dc_region[mds->nr_dc_region - 1].base +
> > > +		mds->dc_region[mds->nr_dc_region - 1].decode_len -
> > > +		mds->dc_region[0].base;
> > > +	dev_dbg(dev, "Total dynamic range: %#llx\n", mds->dynamic_bytes);
> > > +
> > > +	return 0;
> > > +}
> > > +EXPORT_SYMBOL_NS_GPL(cxl_dev_dynamic_capacity_identify, CXL);
> > > +
> > >  static int add_dpa_res(struct device *dev, struct resource *parent,
> > >  		       struct resource *res, resource_size_t start,
> > >  		       resource_size_t size, const char *type)
> > > @@ -1294,8 +1447,15 @@ int cxl_mem_create_range_info(struct cxl_memdev_state *mds)
> > >  {
> > >  	struct cxl_dev_state *cxlds = &mds->cxlds;
> > >  	struct device *dev = cxlds->dev;
> > > +	size_t untenanted_mem;
> > >  	int rc;
> > >  
> > > +	mds->total_bytes = mds->static_bytes;
> > > +	if (mds->nr_dc_region) {
> > > +		untenanted_mem = mds->dc_region[0].base - mds->static_bytes;
> > > +		mds->total_bytes += untenanted_mem + mds->dynamic_bytes;
> > > +	}
> > > +
> > >  	if (!cxlds->media_ready) {
> > >  		cxlds->dpa_res = DEFINE_RES_MEM(0, 0);
> > >  		cxlds->ram_res = DEFINE_RES_MEM(0, 0);
> > > @@ -1305,6 +1465,15 @@ int cxl_mem_create_range_info(struct cxl_memdev_state *mds)
> > >  
> > >  	cxlds->dpa_res = DEFINE_RES_MEM(0, mds->total_bytes);
> > >  
> > > +	for (int i = 0; i < mds->nr_dc_region; i++) {
> > > +		struct cxl_dc_region_info *dcr = &mds->dc_region[i];
> > > +
> > > +		rc = add_dpa_res(dev, &cxlds->dpa_res, &cxlds->dc_res[i],
> > > +				 dcr->base, dcr->decode_len, dcr->name);
> > > +		if (rc)
> > > +			return rc;
> > > +	}
> > > +
> > >  	if (mds->partition_align_bytes == 0) {
> > >  		rc = add_dpa_res(dev, &cxlds->dpa_res, &cxlds->ram_res, 0,
> > >  				 mds->volatile_only_bytes, "ram");
> > > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > > index f2f8b567e0e7..b4eb8164d05d 100644
> > > --- a/drivers/cxl/cxlmem.h
> > > +++ b/drivers/cxl/cxlmem.h
> > > @@ -402,6 +402,7 @@ enum cxl_devtype {
> > >  	CXL_DEVTYPE_CLASSMEM,
> > >  };
> > >  
> > > +#define CXL_MAX_DC_REGION 8
> > >  /**
> > >   * struct cxl_dpa_perf - DPA performance property entry
> > >   * @dpa_range: range for DPA address
> > > @@ -431,6 +432,8 @@ struct cxl_dpa_perf {
> > >   * @dpa_res: Overall DPA resource tree for the device
> > >   * @pmem_res: Active Persistent memory capacity configuration
> > >   * @ram_res: Active Volatile memory capacity configuration
> > > + * @dc_res: Active Dynamic Capacity memory configuration for each possible
> > > + *          region
> > >   * @serial: PCIe Device Serial Number
> > >   * @type: Generic Memory Class device or Vendor Specific Memory device
> > >   */
> > > @@ -445,10 +448,22 @@ struct cxl_dev_state {
> > >  	struct resource dpa_res;
> > >  	struct resource pmem_res;
> > >  	struct resource ram_res;
> > > +	struct resource dc_res[CXL_MAX_DC_REGION];
> > >  	u64 serial;
> > >  	enum cxl_devtype type;
> > >  };
> > >  
> > > +#define CXL_DC_REGION_STRLEN > +struct cxl_dc_region_info {
> > > +	u64 base;
> > > +	u64 decode_len;
> > > +	u64 len;
> > > +	u64 blk_size;
> > > +	u32 dsmad_handle;
> > > +	u8 flags;
> > > +	u8 name[CXL_DC_REGION_STRLEN];
> > > +};
> > 
> > Does this need kdoc comments?
> > 
> > 
> > > +
> > >  /**
> > >   * struct cxl_memdev_state - Generic Type-3 Memory Device Class driver data
> > >   *
> > > @@ -466,7 +481,9 @@ struct cxl_dev_state {
> > >   * @dcd_cmds: List of DCD commands implemented by memory device
> > >   * @enabled_cmds: Hardware commands found enabled in CEL.
> > >   * @exclusive_cmds: Commands that are kernel-internal only
> > > - * @total_bytes: sum of all possible capacities
> > > + * @total_bytes: length of all possible capacities
> > > + * @static_bytes: length of possible static RAM and PMEM partitions
> > > + * @dynamic_bytes: length of possible DC partitions (DC Regions)
> > 
> > Did this get added to the wrong struct comment header? 'cxl_dev_state' instead of 'cxl_memdev_state'?
> > >   * @volatile_only_bytes: hard volatile capacity
> > >   * @persistent_only_bytes: hard persistent capacity
> > >   * @partition_align_bytes: alignment size for partition-able capacity
> > > @@ -476,6 +493,8 @@ struct cxl_dev_state {
> > >   * @next_persistent_bytes: persistent capacity change pending device reset
> > >   * @ram_perf: performance data entry matched to RAM partition
> > >   * @pmem_perf: performance data entry matched to PMEM partition
> > > + * @nr_dc_region: number of DC regions implemented in the memory device
> > > + * @dc_region: array containing info about the DC regions
> > Did this get added to the wrong struct comment header? 'cxl_dev_state' instead of 'cxl_memdev_state'?
> > 
> > DJ
> > 
> > >   * @event: event log driver state
> > >   * @poison: poison driver state info
> > >   * @security: security driver state info
> > > @@ -496,6 +515,8 @@ struct cxl_memdev_state {
> > >  	DECLARE_BITMAP(enabled_cmds, CXL_MEM_COMMAND_ID_MAX);
> > >  	DECLARE_BITMAP(exclusive_cmds, CXL_MEM_COMMAND_ID_MAX);
> > >  	u64 total_bytes;
> > > +	u64 static_bytes;
> > > +	u64 dynamic_bytes;
> > >  	u64 volatile_only_bytes;
> > >  	u64 persistent_only_bytes;
> > >  	u64 partition_align_bytes;
> > > @@ -507,6 +528,9 @@ struct cxl_memdev_state {
> > >  	struct cxl_dpa_perf ram_perf;
> > >  	struct cxl_dpa_perf pmem_perf;
> > >  
> > > +	u8 nr_dc_region;
> > > +	struct cxl_dc_region_info dc_region[CXL_MAX_DC_REGION];
> > > +
> > >  	struct cxl_event_state event;
> > >  	struct cxl_poison_state poison;
> > >  	struct cxl_security_state security;
> > > @@ -709,6 +733,32 @@ struct cxl_mbox_set_partition_info {
> > >  
> > >  #define  CXL_SET_PARTITION_IMMEDIATE_FLAG	BIT(0)
> > >  
> > > +/* See CXL 3.1 Table 8-163 get dynamic capacity config Input Payload */
> > > +struct cxl_mbox_get_dc_config_in {
> > > +	u8 region_count;
> > > +	u8 start_region_index;
> > > +} __packed;
> > > +
> > > +/* See CXL 3.1 Table 8-164 get dynamic capacity config Output Payload */
> > > +struct cxl_mbox_get_dc_config_out {
> > > +	u8 avail_region_count;
> > > +	u8 regions_returned;
> > > +	u8 rsvd[6];
> > > +	/* See CXL 3.1 Table 8-165 */
> > > +	struct cxl_dc_region_config {
> > > +		__le64 region_base;
> > > +		__le64 region_decode_length;
> > > +		__le64 region_length;
> > > +		__le64 region_block_size;
> > > +		__le32 region_dsmad_handle;
> > > +		u8 flags;
> > > +		u8 rsvd[3];
> > > +	} __packed region[];
> > > +	/* Trailing fields unused */
> > > +} __packed;
> > > +#define CXL_DYNAMIC_CAPACITY_SANITIZE_ON_RELEASE_FLAG BIT(0)
> > > +#define CXL_DCD_BLOCK_LINE_SIZE 0x40
> > > +
> > >  /* Set Timestamp CXL 3.0 Spec 8.2.9.4.2 */
> > >  struct cxl_mbox_set_timestamp_in {
> > >  	__le64 timestamp;
> > > @@ -832,6 +882,7 @@ enum {
> > >  int cxl_internal_send_cmd(struct cxl_memdev_state *mds,
> > >  			  struct cxl_mbox_cmd *cmd);
> > >  int cxl_dev_state_identify(struct cxl_memdev_state *mds);
> > > +int cxl_dev_dynamic_capacity_identify(struct cxl_memdev_state *mds);
> > >  int cxl_await_media_ready(struct cxl_dev_state *cxlds);
> > >  int cxl_enumerate_cmds(struct cxl_memdev_state *mds);
> > >  int cxl_mem_create_range_info(struct cxl_memdev_state *mds);
> > > @@ -845,6 +896,17 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
> > >  			    enum cxl_event_log_type type,
> > >  			    enum cxl_event_type event_type,
> > >  			    const uuid_t *uuid, union cxl_event *evt);
> > > +
> > > +static inline bool cxl_dcd_supported(struct cxl_memdev_state *mds)
> > > +{
> > > +	return test_bit(CXL_DCD_ENABLED_GET_CONFIG, mds->dcd_cmds);
> > > +}
> > > +
> > > +static inline void cxl_disable_dcd(struct cxl_memdev_state *mds)
> > > +{
> > > +	clear_bit(CXL_DCD_ENABLED_GET_CONFIG, mds->dcd_cmds);
> > > +}
> > > +
> > >  int cxl_set_timestamp(struct cxl_memdev_state *mds);
> > >  int cxl_poison_state_init(struct cxl_memdev_state *mds);
> > >  int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
> > > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > > index 3a60cd66263e..f7f03599bc83 100644
> > > --- a/drivers/cxl/pci.c
> > > +++ b/drivers/cxl/pci.c
> > > @@ -874,6 +874,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > >  	if (rc)
> > >  		return rc;
> > >  
> > > +	rc = cxl_dev_dynamic_capacity_identify(mds);
> > > +	if (rc)
> > > +		cxl_disable_dcd(mds);
> > > +
> > >  	rc = cxl_mem_create_range_info(mds);
> > >  	if (rc)
> > >  		return rc;
> > > 
> 



