Return-Path: <linux-btrfs+bounces-14110-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B27ABB7AF
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 May 2025 10:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51D273B9EF5
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 May 2025 08:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD67C26D4D8;
	Mon, 19 May 2025 08:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j79i6OOz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3942726A0E5
	for <linux-btrfs@vger.kernel.org>; Mon, 19 May 2025 08:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747643947; cv=fail; b=t+INNCB/y8Cx9jNO7p1RaHP+0Cv21gkEK+HV3l6JycWmqjsYPyRxVDvKKwYu24NbcA1WAdw6ibZ+8qDCp/rwJJ2fqZwn3Q3U92k57X52F7ZRpIcI77j1V0Oge0dmXhngjI0PNIFqIAv7vEJKaFcJsrkUr73CQitYGUbT9BxTKZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747643947; c=relaxed/simple;
	bh=8BVm4SXaZBVNhMyLI8PlzwZJg93TGoCD8xM+Gp48C0s=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=SrADG7FfsTWvuZBoiixpKowjA7IYZSVDgMIVuXnYSmL4v3+FsSAZ+OrjrA6JkZ3ZKtffwJAYeXWlFgQqS4ch4oWlrIOv184V1f6VFW0BxRK8vMvrI0NmNYzRRoVMw8TpZQrLNNN4ZWemZGdx2lCSuJhwjYOemlWWlgbKlikS2Z0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j79i6OOz; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747643945; x=1779179945;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8BVm4SXaZBVNhMyLI8PlzwZJg93TGoCD8xM+Gp48C0s=;
  b=j79i6OOztWnazk5raQdhNzUfGoMGSA1qxJzqWKSL4kcM3Ky0Hf+FnxtL
   gDqt8cUp/d7JreV/NY5ZroOTiJkla5kabzJSUjzIMAVLR7pXHwALNraVn
   ISbg29AYb1IcF60hvDgbIyh96FwwsGqoeKvstRe8lgCNPxDjAje/AQ3Oc
   o6/cgKql4Irh3EBHpeBo0RIAiA1PRJ0x1sYLg5VW2iCUJPgVRYt7WRx/j
   uW4NLP1P/6qIzadfhbdXmgc/q078iNQVdo0h9Nb3U6MzZmC+AosSaU5gw
   Xqy9QIQx6g26n4S/43Pz4PENFCOfOY6U7qnNAqgr85ubzSr9tUPx7Y780
   A==;
X-CSE-ConnectionGUID: BWKooFUuRMStfJ8i0hrQng==
X-CSE-MsgGUID: s6mbcwe7QBmNUlUR0+Olmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11437"; a="74933553"
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="74933553"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 01:39:04 -0700
X-CSE-ConnectionGUID: YPwVL9pBTKS1mn1rfJlIKQ==
X-CSE-MsgGUID: AQU8njEtSSKdIPZCNiaC3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="139719891"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 01:38:57 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 19 May 2025 01:38:57 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 19 May 2025 01:38:57 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 19 May 2025 01:38:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QWNYlUn03cjiNoQQmc3Uwwt98JIBKIDLA8wEYfYX36KjeIE/KVcrB+7naFVegkqtHpdFc+od9eLiVSABM8uLIGS1yPF8H4e2N2ojODAAWWFiXcJqeLxAyQ5iEqx+JvXzmZGbUsaT5o7L79EhwY+djwNI+x7fVszz1iObJhz25W+eJEjWu61ItAA/4VKSYyMgwuNHVhLk24fR2T2NRfRSnptEq6RYK6sPJkC450lrGA0mNDknLm8IK3e66rzG3hquDhzjArYxDb5db1nhy4lQyE9MyN7bl+IG9rIoBD+apVvUfNze1QMYHda85E2Al3FDh15k6je4iQM0DRkgQ2p1dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dq38bbP9oWbjiqkrn0LnojkzOtMTLBHl5FoTm++2DxY=;
 b=fkKSXDLSDOWPnvI0LV6tJ8MgJx6wS8sHifWI9tFQXsSMxnBqPlf9GpJ1Pzo2WQ0ogKR5u7tRdnn2JDrJKv7BFYTsO8GTR8PJHxBF6irFwkl0cgXe/EqKFJCq2y6Ssm1Y74g+U+o8q7aSoJVyrOL9KzZgYU3xV05HrfW7pXu3Ik+QrM2G3rgCfUjSDskjQxLcfHNEEyYJ77rzTyp+CIcNpsANLGxiAmA0DJzvgn6FBYMKuXIVvcMAPovbaWRlMJMaGKcNTjVVT0PkT+HF4/Kg46WGdNetJiJuwDIz5Ln79tVcB+pAJZ1jYt7L60KzOjlCFsIOpSrRcqj70mMinmO8Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CYYPR11MB8360.namprd11.prod.outlook.com (2603:10b6:930:c3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 08:38:40 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 08:38:40 +0000
Date: Mon, 19 May 2025 16:38:29 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Josef Bacik <josef@toxicpanda.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, David Sterba
	<dsterba@suse.com>, Filipe Manana <fdmanana@suse.com>,
	<linux-btrfs@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [btrfs:pr/1157] [btrfs]  5e121ae687:
 WARNING:at_fs/btrfs/extent_io.c:#release_extent_buffer[btrfs]
Message-ID: <202505191521.435b97ac-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: MEWPR01CA0001.ausprd01.prod.outlook.com
 (2603:10c6:220:1e3::9) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CYYPR11MB8360:EE_
X-MS-Office365-Filtering-Correlation-Id: 42b8303a-1836-4c10-7062-08dd96b08e4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?f6la1VGgvjKn3PxbVbM+D8OY0ywyVfEAZ0Y7do85yUM3HONwMHnSonbf9pRG?=
 =?us-ascii?Q?N6wc5XyMOEF4tJslVn5yMx8N6n3Kap2Z+VO/VnkD99jAQ0NbzDCfIruSxRr0?=
 =?us-ascii?Q?V7wbEvGEbgIRgo9Pup2p3nQrhzAL6SnwIfnOksv2BEePdoRjLRwzR3wf4Woo?=
 =?us-ascii?Q?9LaFP++52tSOs9sDulGSWTstE4ztoW9NKOib9NsOJKC6GvTjDYhNSirjq4Yd?=
 =?us-ascii?Q?u8EQ83SuLtsazVdbY/EmLZfY5Xnq4AWdwOAVvu9ckswg3l1E/kJF3KbqSeaU?=
 =?us-ascii?Q?L0P4z8Q4qRYojkL1jS6vLh9um2AiG82cUzJEf6NVTkCFxxk/e/ibwaTPmGOg?=
 =?us-ascii?Q?8o3f4R8yr8qeB3aq5+LbxVJKQ5n1DHHmTjZN/kvp1I5BiyilWzgemx3tcRRT?=
 =?us-ascii?Q?UImH36/60+8MGynW5nRT/pQSivnumwFY5nuApMFV6yFaOUPfc1dDE2aVVzpr?=
 =?us-ascii?Q?oEwMyR8S1RhhYPk13jOjg6PRSmKXbmYHV/jqeyXyvtTruCNEGH/Rb/i/DmGd?=
 =?us-ascii?Q?Su/H0gaCDeRtcFqXo+QAiJEzDVC8K4ZVv3kMPZ+pmBDb1qEdsiaZyPLiBywW?=
 =?us-ascii?Q?qIU2YGIKUvXsdCCX5TJOYQXTTvh/FFJxs2cROcmcQiFChnR9ZRM2BPWZNQaJ?=
 =?us-ascii?Q?fl/VX+koPGkDGGt06xfcbv0fiPK5GgN4ng66wJ8BVLWPn3PRsKRtjA2lyszl?=
 =?us-ascii?Q?nbvQB633oZvq440waPI8tXVrifipLSFdDz+QoPprIK3LBDPLuy19QyTRrGNp?=
 =?us-ascii?Q?0b+PO3vFBFffWNjxkLfvc68GkIN3XloAu8Zjc+sMmmbZxs97ZQrzz3eVSi7a?=
 =?us-ascii?Q?WDap+pWPXZgrPXHQbgKhYEgiO7f91TR5wRxrWGX2RcvPG7u0KKVDr6Tg80cf?=
 =?us-ascii?Q?/PT6TkBgmE0YOmq1IpobkRmIWrDna5ozi867Wp8PBWP/iSn9xR1TIHpP0p3a?=
 =?us-ascii?Q?aqxkfvc1cWyshjDVoJH89O/Fqmt6pZaBlK3MFWkHyp0DoUjdFQj5hS/YilsW?=
 =?us-ascii?Q?hRZ1WD0VwDfwQSfY7DCrbY6KGaM9OHLX9CA+4b655Qn8GVe4dXEe0L0Mgc9K?=
 =?us-ascii?Q?8YTu+wJrA/On00Tm4gfOPg5s/D7bgwThEr2oayxb4b42KZrVINQXA8frligO?=
 =?us-ascii?Q?gCm+I8ZMOT5eh9ZMq/W45uTmaSTTdpHH245CDyYMUs9WXVbNVGEOQUBfIBd4?=
 =?us-ascii?Q?571UqO1lroprGwKNM+fKQeF4h7Cr6T6h5dbUrgNYW83IeKSWT+chpyap9P2T?=
 =?us-ascii?Q?+pSQU1YSXZ6mZ6XEgX0ptHBBeVTisM7NQMHv44f88xFnaWDF7Zxew57bqZwp?=
 =?us-ascii?Q?Nm/O6/6EscxvBcMYsDgxPiGgRLOcsTYu4umL5JYJdinldzlc0nFoUfquM+lk?=
 =?us-ascii?Q?Y3CYLr8Z9xgynTVX5yt5DN+t8VBS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OjUcqr4IaC99iTWJSG5ImNBulFhBLUAoLh29FwLEAxruv8f4o8QTsAi4u38K?=
 =?us-ascii?Q?i17NHTPdCZQ3X6mqSoRNKE0/s9/d6b31mVN04fJRfPcG/2dT+tk53BMNOmnM?=
 =?us-ascii?Q?gtIBzs2bI62LFsXbkSl8WWqdmfmVKQluTeHsm8/KnkI08VqhumiDSrPQ/0pK?=
 =?us-ascii?Q?srPusCKBQSBVCN+GOy6UijyEZZV6oUnbOxd+uArzcEIVxwWM/RqitZ5hK4YG?=
 =?us-ascii?Q?ubVQSM7OUYQs54B43/6DLBRoFJboH7YL9qcOftfSfEfn2Dpe8xXBJyOBVhZ5?=
 =?us-ascii?Q?zu+Q6ubkwiYlmx0hrGb1S186G1I8pKN35acdHSGrI7QtaSdlazTSYaSQDIQM?=
 =?us-ascii?Q?+H/ogPsATNYPCx5eqX95s6CKZg1lwYSpzGj86f3KY3aolNjuVSxeR+dKayr6?=
 =?us-ascii?Q?GNyGxRsEYGYMFrvj0PXCNWLBZBfwvIfLV2jwn0Q7ASaWdSGU7u3HhtQorOcN?=
 =?us-ascii?Q?XUB8QULE20Sz7U1TBqdGSaS5LVm55ERZh+Fs/ARRLxnspamUpe5KLWlwbACK?=
 =?us-ascii?Q?nDZWVpR+WGIPTfZ8b5n6lvFiRrwXi1bOJVTS5fk70xjMeUuCVqY8rhphNeLT?=
 =?us-ascii?Q?3SU42KZRt7Vr9jvtZqp7dUlGsES+0aCMPS8mwhUClWhFhxQoilLEFN/HZHbB?=
 =?us-ascii?Q?9GaZinZsUBeTL3QgM5kNw+1ar2o0/Bx0OEDFd50sKC7W6/hmY0Ja4U3r3+tc?=
 =?us-ascii?Q?S173LSrBdOUag+5DDxsRU7QZZ/A2XSMoOkX6yAMG2Yjm4OhltrcXWo1AN6BA?=
 =?us-ascii?Q?Hq6ilfc9oul88uFG/VzGC2S5OdMQOMupUoAsTy35g+6/b8XYasBhU6ujgUHA?=
 =?us-ascii?Q?DjDkTf6Z61vyixWBJ7lvYxfJoX+JG0fGi++CCtfAlwLFkJ0WLlTcFBQbUr/C?=
 =?us-ascii?Q?Y6miFbsVNu6r0bOguGGR1NUnFWpIs1sCjodTxLVJ/WlWkeaHAsoxW94LYyWR?=
 =?us-ascii?Q?mCQ1wooTsb7mH75prQF8h9Z966L8hGkAVc4OZ/sbv93VxqFIow3YD9HHFIOQ?=
 =?us-ascii?Q?+HCDAc6rtU7uAmwM6YztbRPU+Awd9e7ld0FK8DSkgyQJmRfI7VFbpnsstge/?=
 =?us-ascii?Q?irkI7JaA6NV9sfjK3F2yBos2aL4coTmYZp10kVwUXmlLYInCIlgxnQnrVmQN?=
 =?us-ascii?Q?YnQiz+hwDGsnAoGwOlIrIcOok8y8/dvvJ4y/Z5efgxywYni1rcB5L58mJB2F?=
 =?us-ascii?Q?0oq2dnuF4SQul3Ms+eXG1WHw4hOg3Cfj9I7tGq4YWD+M53uXNMHxQoa6GMjJ?=
 =?us-ascii?Q?bA6/dWYhGxXEEF69bMOYcl5J1l36GGVBYNtt03uF4L2t8TK9uSfRV5oqyOzV?=
 =?us-ascii?Q?w9CNwjL24z+KrCYJWlM7KGdD4KMOIpc4sLKXY7dMiazCSsHzk3ek0lmSIzI3?=
 =?us-ascii?Q?1S2oo2sZEDAE1aUZxIxMgBrZvsoXKLK5nGeZCwZsvxql9Zf5M1XKbpGkLwBk?=
 =?us-ascii?Q?OSzvK8NlCCLMUvpEco7lZ00rCYHn/FgUHYZesBlkKBXjPIQRX6JZaurECAzJ?=
 =?us-ascii?Q?R35JbGxs8pQpqzs4+FVhn7bI7yhMB1lOcj1lsfArOr715HSwpXt8q4es2FQB?=
 =?us-ascii?Q?17MvnLMZFFSYcG0uTB+FZrZz74ofHLoEdS1fXEEjsK+CXKA8UOqUFXKLazth?=
 =?us-ascii?Q?+g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 42b8303a-1836-4c10-7062-08dd96b08e4e
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 08:38:40.5263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VoedeOhEsRVpYHmFVghcfHdOTfX5Jz9IxDjA0qGNdxIoYkajtIReufSvodwV8QLBhs8IirMHaRr9sxYJEp6icA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8360
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_fs/btrfs/extent_io.c:#release_extent_buffer[btrfs]" on:

commit: 5e121ae687b8c16294230d69ea16a49a08d5e332 ("btrfs: use buffer xarray for extent buffer writeback operations")
https://github.com/btrfs/linux.git pr/1157

[test failed on linux-next/master 8566fc3b96539e3235909d6bdda198e1282beaed]

in testcase: blktests
version: blktests-x86_64-236edfd-1_20250318
with following parameters:

	test: zbd-009



config: x86_64-rhel-9.4-func
compiler: gcc-12
test machine: 192 threads 2 sockets Intel(R) Xeon(R) 6740E  CPU @ 2.4GHz (Sierra Forest) with 256G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202505191521.435b97ac-lkp@intel.com


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250519/202505191521.435b97ac-lkp@intel.com


kern  :warn  : [  298.897265] ------------[ cut here ]------------
kern  :warn  : [  298.899068] WARNING: CPU: 151 PID: 3403 at fs/btrfs/extent_io.c:3417 release_extent_buffer+0x163/0x1a0 [btrfs]
kern  :warn  : [  298.901741] Modules linked in: scsi_debug sd_mod sg null_blk dm_multipath intel_tpmi_power_domains intel_ifs i10nm_edac skx_edac_common nfit x86_pkg_temp_thermal coretemp btrfs kvm_intel blake2b_generic xor zstd_compress kvm raid6_pq irqbypass snd_pcm ghash_clmulni_intel sha512_ssse3 ast snd_timer cxl_pmem qat_4xxx sha256_ssse3 libnvdimm intel_qat intel_rapl_tpmi isst_tpmi intel_uncore_frequency_tpmi drm_client_lib snd sha1_ssse3 intel_rapl_common isst_tpmi_core intel_uncore_frequency_common nvme iaa_crypto ipmi_ssif drm_shmem_helper soundcore dax_hmem isst_if_mmio intel_cstate intel_uncore pcspkr cxl_acpi pmt_telemetry idxd intel_vsec_tpmi intel_sdsi nvme_core pmt_class cxl_port i2c_i801 drm_kms_helper spi_intel_pci crc8 isst_if_common intel_vsec authenc spi_intel i2c_smbus wmi idxd_bus acpi_ipmi cxl_core ipmi_si ipmi_devintf ipmi_msghandler einj joydev pfr_telemetry pfr_update binfmt_misc drm fuse loop dm_mod ip_tables [last unloaded: scsi_debug]
kern  :warn  : [  298.919759] CPU: 151 UID: 0 PID: 3403 Comm: umount Not tainted 6.15.0-rc6-00223-g5e121ae687b8 #1 PREEMPT(voluntary) 
kern  :warn  : [  298.922215] RIP: 0010:release_extent_buffer+0x163/0x1a0 [btrfs]
kern  :warn  : [  298.924038] Code: 48 89 df e8 ff fd ff ff 48 8d 7b 38 48 c7 c6 00 2f f3 c3 e8 0f de 73 bd b8 01 00 00 00 48 83 c4 08 5b 5d 41 5c c3 cc cc cc cc <0f> 0b e9 ec fe ff ff 48 89 ef e8 3e c1 e7 bd e9 d4 fe ff ff e8 34
kern  :warn  : [  298.928358] RSP: 0018:ffffc90019b67198 EFLAGS: 00010246
kern  :warn  : [  298.929924] RAX: 0000000000000000 RBX: ffff8bb5656c2ac0 RCX: ffffffffc3f34471
kern  :warn  : [  298.931812] RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff8bb5656c2aec
kern  :warn  : [  298.933695] RBP: ffff8bb5656c2aec R08: 0000000000000000 R09: ffffed76acad855d
kern  :warn  : [  298.935576] R10: ffff8bb5656c2aef R11: 0000000000000001 R12: 1ffff9200336ce39
kern  :warn  : [  298.937453] R13: dffffc0000000000 R14: ffff8bb5656c2ad0 R15: ffffed76acad855a
kern  :warn  : [  298.939326] FS:  00007f2b2224d840(0000) GS:ffff8bb15adc2000(0000) knlGS:0000000000000000
kern  :warn  : [  298.941372] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
kern  :warn  : [  298.943019] CR2: 00007f2b223cd400 CR3: 000003355cd4b005 CR4: 0000000000f72ef0
kern  :warn  : [  298.944901] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
kern  :warn  : [  298.946786] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 0000000000000400
kern  :warn  : [  298.948660] PKRU: 55555554
kern  :warn  : [  298.949793] Call Trace:
kern  :warn  : [  298.950874]  <TASK>
kern  :warn  : [  298.951888]  free_extent_buffer+0x1e5/0x2a0 [btrfs]
kern  :warn  : [  298.953511]  ? __pfx_free_extent_buffer+0x10/0x10 [btrfs]
kern  :warn  : [  298.955199]  ? btrfs_check_meta_write_pointer+0x17b/0x4b0 [btrfs]
kern  :warn  : [  298.956965]  btree_write_cache_pages+0x3e7/0x900 [btrfs]
kern  :warn  : [  298.958641]  ? __pfx_btree_write_cache_pages+0x10/0x10 [btrfs]
kern  :warn  : [  298.960405]  ? stack_trace_save+0x8f/0xc0
kern  :warn  : [  298.961777]  ? __pfx_stack_trace_save+0x10/0x10
kern  :warn  : [  298.963194]  ? stack_depot_save_flags+0x3d/0x610
kern  :warn  : [  298.964637]  do_writepages+0x171/0x770
kern  :warn  : [  298.965941]  ? kasan_save_track+0x10/0x30
kern  :warn  : [  298.967272]  ? __kasan_slab_free+0x33/0x40
kern  :warn  : [  298.968623]  ? __pfx_do_writepages+0x10/0x10
kern  :warn  : [  298.969989]  ? btrfs_write_and_wait_transaction+0xda/0x210 [btrfs]
kern  :warn  : [  298.971752]  ? btrfs_commit_transaction+0x18de/0x29f0 [btrfs]
kern  :warn  : [  298.973433]  ? sync_filesystem+0x16c/0x210
kern  :warn  : [  298.974766]  ? generic_shutdown_super+0x73/0x380
kern  :warn  : [  298.976171]  ? kill_anon_super+0x36/0x90
kern  :warn  : [  298.977450]  ? btrfs_kill_super+0x37/0x50 [btrfs]
kern  :warn  : [  298.978957]  ? deactivate_locked_super+0xa1/0x190
kern  :warn  : [  298.980368]  ? _raw_spin_lock+0x80/0xe0
kern  :warn  : [  298.981641]  ? __pfx__raw_spin_lock+0x10/0x10
kern  :warn  : [  298.982975]  filemap_fdatawrite_wbc+0xd2/0x120
kern  :warn  : [  298.984316]  __filemap_fdatawrite_range+0xa3/0xe0
kern  :warn  : [  298.985692]  ? __pfx___filemap_fdatawrite_range+0x10/0x10
kern  :warn  : [  298.987178]  ? deactivate_locked_super+0xa1/0x190
kern  :warn  : [  298.988537]  btrfs_write_marked_extents+0xfa/0x240 [btrfs]
kern  :warn  : [  298.990140]  ? __pfx_btrfs_write_marked_extents+0x10/0x10 [btrfs]
kern  :warn  : [  298.991802]  ? _raw_spin_lock+0x80/0xe0
kern  :warn  : [  298.992993]  ? __pfx__raw_spin_lock+0x10/0x10
kern  :warn  : [  298.994253]  ? _raw_spin_lock+0x80/0xe0
kern  :warn  : [  298.995427]  btrfs_write_and_wait_transaction+0xda/0x210 [btrfs]
kern  :warn  : [  298.997041]  ? __pfx_btrfs_write_and_wait_transaction+0x10/0x10 [btrfs]
kern  :warn  : [  298.998758]  ? mutex_unlock+0x7e/0xd0
kern  :warn  : [  298.999887]  btrfs_commit_transaction+0x18de/0x29f0 [btrfs]
kern  :warn  : [  299.001417]  ? start_transaction+0x219/0x16a0 [btrfs]
kern  :warn  : [  299.002862]  ? __pfx_btrfs_commit_transaction+0x10/0x10 [btrfs]
kern  :warn  : [  299.004445]  ? btrfs_attach_transaction_barrier+0x1e/0x80 [btrfs]
kern  :warn  : [  299.006057]  sync_filesystem+0x16c/0x210
kern  :warn  : [  299.007232]  generic_shutdown_super+0x73/0x380
kern  :warn  : [  299.008480]  kill_anon_super+0x36/0x90
kern  :warn  : [  299.009609]  btrfs_kill_super+0x37/0x50 [btrfs]
kern  :warn  : [  299.010941]  deactivate_locked_super+0xa1/0x190
kern  :warn  : [  299.012185]  cleanup_mnt+0x1e5/0x3e0
kern  :warn  : [  299.013281]  task_work_run+0x116/0x200
kern  :warn  : [  299.014446]  ? __pfx_task_work_run+0x10/0x10
kern  :warn  : [  299.015643]  ? __x64_sys_umount+0xff/0x120
kern  :warn  : [  299.016814]  ? __pfx___x64_sys_umount+0x10/0x10
kern  :warn  : [  299.018058]  syscall_exit_to_user_mode+0x1d2/0x1e0
kern  :warn  : [  299.019348]  do_syscall_64+0x85/0x160
kern  :warn  : [  299.020462]  ? __pfx___do_sys_newfstatat+0x10/0x10
kern  :warn  : [  299.021746]  ? syscall_exit_to_user_mode+0xc/0x1e0
kern  :warn  : [  299.023020]  ? do_syscall_64+0x85/0x160
kern  :warn  : [  299.024160]  ? __count_memcg_events+0x18d/0x470
kern  :warn  : [  299.025390]  ? syscall_exit_to_user_mode+0xc/0x1e0
kern  :warn  : [  299.026664]  ? do_syscall_64+0x85/0x160
kern  :warn  : [  299.027788]  ? handle_mm_fault+0x409/0x6e0
kern  :warn  : [  299.028956]  ? do_user_addr_fault+0x8f7/0xfb0
kern  :warn  : [  299.030170]  ? exc_page_fault+0x57/0xc0
kern  :warn  : [  299.031291]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
kern  :warn  : [  299.032631] RIP: 0033:0x7f2b22479b37
kern  :warn  : [  299.033713] Code: cf 92 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 8b 15 99 92 0c 00 f7 d8 64 89 02 b8
kern  :warn  : [  299.037628] RSP: 002b:00007ffd8afea8f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
kern  :warn  : [  299.039399] RAX: 0000000000000000 RBX: 000055dd9bf33318 RCX: 00007f2b22479b37
kern  :warn  : [  299.041089] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000055dd9bf33430
kern  :warn  : [  299.042788] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000073
kern  :warn  : [  299.044487] R10: 0000000000000000 R11: 0000000000000246 R12: 00007f2b225b4264
kern  :warn  : [  299.046183] R13: 000055dd9bf33430 R14: 0000000000000000 R15: 000055dd9bf33200
kern  :warn  : [  299.047878]  </TASK>
kern  :warn  : [  299.048755] ---[ end trace 0000000000000000 ]---


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


