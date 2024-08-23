Return-Path: <linux-btrfs+bounces-7422-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 002D895C337
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2024 04:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 833A51F23AE9
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2024 02:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D4C27713;
	Fri, 23 Aug 2024 02:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HWZGvY0s"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29AB1CD31;
	Fri, 23 Aug 2024 02:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724380013; cv=fail; b=tGow3x64JHLvIebe+jVmdV8auS2N8A361fI5s3a7+y6un7ehs5d+XY7Kb3rvrOgI964vnifgyEPLuKph+H9O5Ijfda/5B1ZLwnCgHEq+8cDKNkIm6y0f5hM3t2rWFAIt4juFIX3w3LMyjg7azcIwliV8CHUv8GgBuzDb92vGRGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724380013; c=relaxed/simple;
	bh=/9UcnSXD/sYfhyJ2qMOEE+MKe/gTD2f7147yz3f8xHU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VR4hhG0rDy5h3M2RXTKzA01m8dO/JS7rKVriUrNffg2+FGt373QcCcuRnYtK/9AbLBtpxUsGOBdvufbPPmEfn3oL2aFaJXsAJavgLUDQwVrZsE1qoSZ29bIu+bFPHSnG1FyZGEhVQYLHvMJOZoneayPZVXrYK7wwNODiHhHRP1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HWZGvY0s; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724380012; x=1755916012;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=/9UcnSXD/sYfhyJ2qMOEE+MKe/gTD2f7147yz3f8xHU=;
  b=HWZGvY0s7tJ7s1/HVrytnFS7r3QroaT+czcQVJxV3gpcsnUPwECCbj/J
   88ayYA5s+CFMTM9s+xD/9Fs3fjqE1oZoq1kxnAbmhF8TtwZjjgxAdrocY
   tpsLrLpfPu25HsW/YNR4NeXX0XfRSOWxbOL4iefY+tGmKeIiCoAyKku4z
   IPxW8qu3hT6eUTbCzLO/yJVQWnkG1fjO0hMykxrasHTqKm1B4lv5kbi+4
   dssV7Tm5C84WSbzbyG4JBmJF5RLKtDLDQ4A7M44iHZ/98tdp389KrpkuY
   ZKJ4LgOdOIVbD4nv35V+/2pxf1MDBNE6WL8EGN8Ap9tCqJSF48lqq0YtD
   A==;
X-CSE-ConnectionGUID: 4Ka0/5azRKelIb0xIFcDbA==
X-CSE-MsgGUID: Yy9J1hnaSlOzTyA7OUyQmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="33990049"
X-IronPort-AV: E=Sophos;i="6.10,169,1719903600"; 
   d="scan'208";a="33990049"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 19:26:51 -0700
X-CSE-ConnectionGUID: UVmPIgSMQAOnxBVlwsOGmg==
X-CSE-MsgGUID: dbaqVokoSx+/NlXfFojQGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,169,1719903600"; 
   d="scan'208";a="61672646"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Aug 2024 19:26:51 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 22 Aug 2024 19:26:50 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 22 Aug 2024 19:26:50 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 22 Aug 2024 19:26:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JNtmPk5xENT3Znym6GZV6wSlVWNi4dqxarosdKr5Z6Qw41dWQj4yKG2E1E5DChVmEr7dyCO9zzxWNEb1SLMKs0UE3ILoJ34icMLgfkLO/4UVx4A1c62FoE1kuuIMQ2kZ0ak0Kjm/7xVmaDNvbr9AAUZtWENVZyTP2qR7pRJIIFRlrczBaIoibeuLTE7MDx8l/5QJxkAgskScqjaloOzsbrwvFQGoEodgstUZ4bbb/3VCVz0NEUF86jO8mU+1wFYydb8FkBX+CzELxedNJWqDmAA9ke98mTgPrLIuajpKAyMqJIsqP0qPEtbcILr4LgEEjkPb/PqRRuBgi4iijAIxJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7zOp3sn5ENL7oy+Q6OCF/YBzW02pxiiC7gz9k7a1Kl4=;
 b=CmhDVs9o3t4v00TrZzbQQy5D+kvLd7cY/p5o6ZwqvQ9oMzHL7eqeuylTBT93d/+68sLQHt5JJt0ht+Jfnt4rD3ldKx8I/gWUPEBNxFpITt92Z+NENIpzkLVWNdmiehUCK2qOyZYn1vbkpNLL+KpqlK003EBcUBQGE8KiAFVxpM4DllTFBj+KHabeJR91hgdjZr9uVo+015egsrqe9XLAMljVZh7INUfeXpv4MEGWz2moBypRRKp7YeOFZP2bI0XWXK1D9v6Pnody8Hzk7vdOebKD2bKIR2rDwS9qvJ+pNny9st8ZMPtvf/CQjoHoe1L5EmWsppJPa/qm/vVCNL4Hpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA1PR11MB8524.namprd11.prod.outlook.com (2603:10b6:806:3a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Fri, 23 Aug
 2024 02:26:48 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%6]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 02:26:48 +0000
Date: Thu, 22 Aug 2024 21:26:42 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <ira.weiny@intel.com>, Fan Ni
	<fan.ni@samsung.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	"Navneet Singh" <navneet.singh@intel.com>, Chris Mason <clm@fb.com>, Josef
 Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Petr Mladek
	<pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Rasmus Villemoes
	<linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>
CC: Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Alison Schofield <alison.schofield@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, <linux-btrfs@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <nvdimm@lists.linux.dev>
Subject: Re: [PATCH v3 09/25] cxl/hdm: Add dynamic capacity size support to
 endpoint decoders
Message-ID: <66c7f3624d881_1719d2943b@iweiny-mobl.notmuch>
References: <20240816-dcd-type2-upstream-v3-0-7c9b96cba6d7@intel.com>
 <20240816-dcd-type2-upstream-v3-9-7c9b96cba6d7@intel.com>
 <8eefaa52-ba46-4e9b-8695-c086e08b0498@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8eefaa52-ba46-4e9b-8695-c086e08b0498@intel.com>
X-ClientProxiedBy: MW4P222CA0026.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::31) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA1PR11MB8524:EE_
X-MS-Office365-Filtering-Correlation-Id: e9a3069d-e7f7-4c94-044e-08dcc31b0a3d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ol96cpDrsajERoEeKL28FJhFU056FilpYKXl6c4+nGo0RrTfJfxSh473zUc3?=
 =?us-ascii?Q?8KRKmu5kVuxxQYJzXT8Ioe3Fztjgk5n8uoEVQRZM3AXCd63f7FYeSZxfOoYw?=
 =?us-ascii?Q?A4msC0i1hJgjumRhXgvb8YNVTq6qj7DU+wBmxww3rjarSvR8ESzlOkwz909r?=
 =?us-ascii?Q?cu6vhIhlsSwMntejpRaZGMFFobW/cJdwhkDU/6VPEvTD+J8nf8shjrmCB39V?=
 =?us-ascii?Q?vpYtJAL6GJjj0sCRQo7WDToPgTnViRSHMXBPUw+6FWJkKVuTNdy1ufwn8RmI?=
 =?us-ascii?Q?M/QMyTaoNWhcXa4ROJhUq7BiRfhGKtrCCmCssFMvVThpD2GbnwGvrp7STJv7?=
 =?us-ascii?Q?arMGkOuTcy1SWrI0sBW5t88AbSRSrOzeAK8v8/mrImvbcuMoAK3Oi5vHzQuq?=
 =?us-ascii?Q?0dEgxTEecnKiBxjmH6gxYMIwgjy4sWLh8ytbRLBD7pyTh98kza8o2znzYD5X?=
 =?us-ascii?Q?So/3LTq9cPJbKsFE385j6w/0ihVP7y+z+TtJKzja2IpkH6meiWM4lmqQYHxq?=
 =?us-ascii?Q?/BW2r/RQaNdZOHM96llHRURyLheJgkls9l9LSzdvGpd7PU3NjsPGBxyhMirD?=
 =?us-ascii?Q?cIntQ1xus5mxaoJaa0DwHvNFSXyjtM/TE12NwTozNNZnQsSAwDDOlJiWbAt5?=
 =?us-ascii?Q?2iIsOcwoJ62ESa7GIGRGcAf4jpzDXBBhWymOUUYHPobvc2N+/W6H+rQvzaP4?=
 =?us-ascii?Q?ur1V90PqDOGTJcH4HkEVzDvBTIIYJyvHiT1KWBE2m91v7f0KuAD4O52vf+Ff?=
 =?us-ascii?Q?g/0EeG6HdAEAGjhG7W3eAVmfP5v5igSTetagy3KniBqCaD3BkIn147Tdgmys?=
 =?us-ascii?Q?yd+Hnzwj5dnoAJ2mjXogxHh4Qs1ABYnTMMNByesayJsEX0TGfeR9EcWXGiBM?=
 =?us-ascii?Q?CB4tkWwHgBg6D9H4AL2V0uAtYtI9rmrsm1TiwdP2l71U53RHGduz29f4EHor?=
 =?us-ascii?Q?7tpUtgl/bG2UbrhkifCX/pUe09N9aElgJcE8tciwBgH5GW9VgYRTVtFqnR9C?=
 =?us-ascii?Q?fMIQ6A5DcoS8a7u82pEvCrRZLYQAOymaJixKJxSbJMetFyU/6N6SzrWDXjzf?=
 =?us-ascii?Q?jbasvNSAT8vwddDhtCRyMlpls3iJcbc9vrsoe/nq7mdTcqLEqXJOJpTHmhzn?=
 =?us-ascii?Q?RDgUvvQbEBNQxwNIwnjgDr1EVA71/L3iYySmfNSMD+x1V63k9BYycILVoTHq?=
 =?us-ascii?Q?Rw5oyOsZ0u5vaaoq9JFxIdRaj4Yski1uSYrV/Q9WbbjyLVjp8zOwTHyjB8ev?=
 =?us-ascii?Q?FU3a0t+9nKM3gnj0nKvne+8lqW4EHwl0tZqOWrsDjQMXT9UTu2PQ0z9/pTVZ?=
 =?us-ascii?Q?IgQApO362xf8WXvd687KSs560kJkIoEMw7pp1UFLbEALxK7iDftK2vvwDuz+?=
 =?us-ascii?Q?9g5D+Zb94900IwrNyCtY0maW1KzK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m6au82mvB+W5X4clAsuJ/udEIzfie206CpWjRJfFhqNeM6c8mSUwt8DcNFlo?=
 =?us-ascii?Q?LJLSnxNvVijcO74QYeo/cQxyRCszReBCTnrcOlijQQDgZSWJ0JTLl6dtDnGd?=
 =?us-ascii?Q?XWGLIurV2o4MXlBnrrT3k05piHzkcV+I/EaspNeL7av5rtqXxR6y4WqXA6z1?=
 =?us-ascii?Q?4LUJJE4iCEqQurNHP1HbCs8Q2CzmB9mVOrAL64BFE0UD7hTFAFO1GwyDXycS?=
 =?us-ascii?Q?9XHHuCF9/7zFLqp+HftyFDKSDRXmpGQM6c8Nf9aokEPpCeGx/NyScg7DtzT4?=
 =?us-ascii?Q?vWs2vNolGuNho/EZ/V7q0eIA7myrm1mmxIr753UyWcbMmOzNUxo4aicXxBAz?=
 =?us-ascii?Q?7oE8cb+xKZ/i01bzGUBflBRk0201zUr0MT2SDucOmVeAfSiPusKI7cdtiKrr?=
 =?us-ascii?Q?W1p1qxUJTxz4+J/QyLV6IrJTulyzTOY0O8eTVc1oHr3yozUotFfJw/0WoPds?=
 =?us-ascii?Q?aEuQLyEcWuzbfU1XDJnuxUrSAfW4XHD/drnWwz0H+2rofTiyJFBQRRCApmb2?=
 =?us-ascii?Q?JnbuJH3UoXCxPPI8+gZ2/yeMyNj2+dPtpyAlv1gZoTujeEL4LOmOJjdL0fCx?=
 =?us-ascii?Q?G9pcOd50No9Ne6168AJoYnJKP4R64qd//iMJedndjsLmoEWiWM7V5mtbwuMC?=
 =?us-ascii?Q?DM79ATizwh9Mn4snnlSx94lmbwuUUIEzEbRi8ibNLxvxEWsDOQvy7UcB4WwI?=
 =?us-ascii?Q?CQ6gfLfki3blKFM8Zu7KDQed7V6xK9LGI+/d6aRL74BIBEf+cI0YNDt8tMM/?=
 =?us-ascii?Q?TK3eoM9zAdHI5SbrDB6jE0BtW1Aw1Dco2H7SYuDP8aEKWmaJoEFkGlv1/aZU?=
 =?us-ascii?Q?vKXDphx2GXRZ5UEB0RPIOB6I/V74IWFetOMgmNFhE92N6hJITkdYttzDgMqT?=
 =?us-ascii?Q?CCgFaq0ShViD+Hup81NR8bfzexLTQgUGAoMZWYVogHOG/2bUKUJFyFJIFf+F?=
 =?us-ascii?Q?VQIMBPZ+pa0W5fAfF8gusbrBraxTXVaS4OFq1BU9vB9hHTn95BBkJ5eiN+Tf?=
 =?us-ascii?Q?oLRujNc5/NIvGCgnq5KVlBfQhVjTItu/Tz2deB03j9qyKC3GCSkrNLUpA3ld?=
 =?us-ascii?Q?9pWCX5X5TjZX/L0bqvrQpP3M6Cg2mQWOzLdmZeUhg8ZJBSk3D37M9gtJiJGC?=
 =?us-ascii?Q?dddR0asQFcPY7SEFRazT/HRtaUi0PCq5TNQImO4FGOnuwQFpUR+E5cMqFFKE?=
 =?us-ascii?Q?dJ+czccDn6Fuk+nkjsMlOLm/hdsczvrvWI2LZasa5dj0cGycv6//urvqBiRv?=
 =?us-ascii?Q?TgmQMjk9iutrrU5u9aBxdDZLNLxUyEikrpLKva7n5OGy3MKQhLJFA+z50gmS?=
 =?us-ascii?Q?WRfkT3JUsRG1cQQjdi5YIfrMogx4FWE25nJ8nGbKAPl2BSf4wqz3+71NuFXZ?=
 =?us-ascii?Q?DESZGqa9laGqG3obxO34mso5XE8bNSmoow4SVUBIwolsm7RiksMPaNDM1sAj?=
 =?us-ascii?Q?FSKV7Wz6EguD93Dv74cuUFnmo85eMNFlU+/8fHLVRmiRhnCna0whamH++pEJ?=
 =?us-ascii?Q?Y9IkG9y4yUohETZfKSyp2KbRHKAZ9prO/9tPf/AecBlxaqPy3op4VXSi2w5b?=
 =?us-ascii?Q?FAlmFbSzJ7BPah834OYRV75fpq7RQ9opaXuiKjz6?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e9a3069d-e7f7-4c94-044e-08dcc31b0a3d
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 02:26:48.4846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3uSyd+ndSp+hytgCixnibhPAuy7dmvo5a/fYJnDJhlX28+HD/rtXLi+LEy+hv4pUcDJorARmYBz1IyXy5QCxfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8524
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> 
> 
> On 8/16/24 7:44 AM, ira.weiny@intel.com wrote:
> > From: Navneet Singh <navneet.singh@intel.com>
> > 

[snip]

> > +static int dc_mode_to_region_index(enum cxl_decoder_mode mode)
> > +{
> > +	return mode - CXL_DECODER_DC0;
> > +}
> > +
> > +static int cxl_request_skip(struct cxl_endpoint_decoder *cxled,
> > +			    resource_size_t skip_base, resource_size_t skip_len)
> > +{
> > +	struct cxl_dev_state *cxlds = cxled_to_memdev(cxled)->cxlds;
> > +	const char *name = dev_name(&cxled->cxld.dev);
> > +	struct cxl_port *port = cxled_to_port(cxled);
> > +	struct resource *dpa_res = &cxlds->dpa_res;
> > +	struct device *dev = &port->dev;
> > +	struct resource *res;
> > +	int rc;
> > +
> > +	res = __request_region(dpa_res, skip_base, skip_len, name, 0);
> > +	if (!res)
> > +		return -EBUSY;
> > +
> > +	rc = xa_insert(&cxled->skip_res, skip_base, res, GFP_KERNEL);
> 
> Maybe rename skip_res to skip_xa, given most of the vars in CXL with
> _res are 'struct resource' to avoid confusion. See 'dpa_res' above.
> 

Good idea.
[done]

> > +	if (rc) {
> > +		__release_region(dpa_res, skip_base, skip_len);
> > +		return rc;
> > +	}
> > +
> > +	dev_dbg(dev, "decoder%d.%d: skipped space; %pr\n",
> > +		port->id, cxled->cxld.id, res);
> > +	return 0;
> > +}
> > +
> > +static int cxl_reserve_dpa_skip(struct cxl_endpoint_decoder *cxled,
> > +				resource_size_t base, resource_size_t skipped)
> > +{
> > +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> > +	struct cxl_port *port = cxled_to_port(cxled);
> > +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> > +	resource_size_t skip_base = base - skipped;
> > +	struct device *dev = &port->dev;
> > +	resource_size_t skip_len = 0;
> > +	int rc, index;
> > +
> > +	if (resource_size(&cxlds->ram_res) && skip_base <= cxlds->ram_res.end) {
> > +		skip_len = cxlds->ram_res.end - skip_base + 1;
> > +		rc = cxl_request_skip(cxled, skip_base, skip_len);
> > +		if (rc)
> > +			return rc;
> > +		skip_base += skip_len;
> > +	}
> > +
> > +	if (skip_base == base) {
> > +		dev_dbg(dev, "skip done ram!\n");
> > +		return 0;
> > +	}
> > +
> > +	if (resource_size(&cxlds->pmem_res) &&
> > +	    skip_base <= cxlds->pmem_res.end) {
> > +		skip_len = cxlds->pmem_res.end - skip_base + 1;
> > +		rc = cxl_request_skip(cxled, skip_base, skip_len);
> > +		if (rc)
> > +			return rc;
> > +		skip_base += skip_len;
> > +	}
> 
> Does 'skip_base == base' need to be checked here again before going to DCD?

No it is checked below...

> 
> DJ
> 
> > +
> > +	index = dc_mode_to_region_index(cxled->mode);
> > +	for (int i = 0; i <= index; i++) {
> > +		struct resource *dcr = &cxlds->dc_res[i];
> > +
> > +		if (skip_base < dcr->start) {
> > +			skip_len = dcr->start - skip_base;
> > +			rc = cxl_request_skip(cxled, skip_base, skip_len);
> > +			if (rc)
> > +				return rc;
> > +			skip_base += skip_len;
> > +		}
> > +
> > +		if (skip_base == base) {
> > +			dev_dbg(dev, "skip done DC region %d!\n", i);
> > +			break;
> > +		}

... here.

After any skips between pmem and the first DC partition.
Ira

> > +
> > +		if (resource_size(dcr) && skip_base <= dcr->end) {
> > +			if (skip_base > base) {
> > +				dev_err(dev, "Skip error DC region %d; skip_base %pa; base %pa\n",
> > +					i, &skip_base, &base);
> > +				return -ENXIO;
> > +			}
> > +
> > +			skip_len = dcr->end - skip_base + 1;
> > +			rc = cxl_request_skip(cxled, skip_base, skip_len);
> > +			if (rc)
> > +				return rc;
> > +			skip_base += skip_len;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +

[snip]

