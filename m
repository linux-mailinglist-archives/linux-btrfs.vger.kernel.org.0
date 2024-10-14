Return-Path: <linux-btrfs+bounces-8888-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D6999BD5E
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2024 03:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4050B1C214F4
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2024 01:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2711C6B4;
	Mon, 14 Oct 2024 01:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AW8ma8rl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A32101EE;
	Mon, 14 Oct 2024 01:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728869660; cv=fail; b=MDeKBUPdjOqLxYINrtswzDBdOnJBMXvExs0wIvKQOKcotRlynxYZs4IVM4HHVPfslDuyWtj7pnjEuYDgvoqBrz1rAUjlDaZA1omFq9RcaCJTUm4I06UoRFS9zKFyLKVg7NnjkdG4J8q8VOXKEejLVlwRuoDmLPWJeGAF1eeMs+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728869660; c=relaxed/simple;
	bh=PdcPwf3qvaZhiGPPfqrUM8phSrlSTsj2bqOf1Vnv1Ck=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GCmmewf0f2YzXuaF1WhRaftF7nGqpX1+pbi0wD7CXFEow7h7bEXGIbRwkeUDSetA9B8T1yeci8eBgapVWeIrvV7hzxpHLm52UDiRzibq3U8Lnvk+SWadDpHE0e32conPi4eQ4VV45Bj27zXZjQFFomBssMJ72ddgGhyhLxiqHCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AW8ma8rl; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728869658; x=1760405658;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=PdcPwf3qvaZhiGPPfqrUM8phSrlSTsj2bqOf1Vnv1Ck=;
  b=AW8ma8rlQJcpzkwWrO7hYmQchWEHLBQruy3oGmrR3deWaJhCSviWd3Zt
   t6KZa88pJhKpwYAc4aD9FGgOoCe+e5mpZug3DYNVuEEQ+gmrGGQpFjzGr
   dKgo2oMtazITJ1BnPyGoBGzOkCTbGX8h11sVVTXGZhdOOr+cSYXgYM3wv
   wV1vhIDROpfqWEuWS6XDNizsKZUYOFEHpJA3qk0W7qoqLqiSVw3qo4T1e
   L+L0Zv8nedmoApxkNVmtfTdAlZ5LiNP+ltrNTcBZUZThdBSiejbEeCFmx
   Rw0fPQNe9Ga/BaVhBHvPuH2vRElFq/4D77VmzZ8YRj8rqEMkkyCwvS+Rq
   g==;
X-CSE-ConnectionGUID: nEAC6Yl6T9a09dyuT4d2Dw==
X-CSE-MsgGUID: ma/r1RaSTtCEljh4VxM+Jw==
X-IronPort-AV: E=McAfee;i="6700,10204,11224"; a="32116996"
X-IronPort-AV: E=Sophos;i="6.11,202,1725346800"; 
   d="scan'208";a="32116996"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2024 18:34:13 -0700
X-CSE-ConnectionGUID: wql8we1qQba5TiD1UT7hJA==
X-CSE-MsgGUID: 2Oy4fDwtSGSvqHWHQGrZ1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,202,1725346800"; 
   d="scan'208";a="82042990"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Oct 2024 18:34:12 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 13 Oct 2024 18:34:12 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 13 Oct 2024 18:34:12 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 13 Oct 2024 18:34:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O1/Bd1H61ltu0pTgOavRdTFeyWTywzeO+ZVjssGGf1GeKZHhjnnqS7pWCgEXyM6B+1hl/M1wf6XLk0yzacXUkGuix3RhB/oI6LOv+noYl7gviaIatWoKaySe5P8QnwzebZrrlgI56cBDxR6nUnj/xHEU4oNIXP8pbBOo/tODA45rTqSUhhYHzmAlpRL4Oj2bvxTYhSzW7G84upDIvbQpS6n1QCZMiplLc4JYcDKa4QLOABTBc1MysE85tMEYNT4urL+ibHVV1eg1Xf11j/Mgao9c7DTd2h2DBkt3rXg+feA+qPtHdduaVP9WAigpgCxUDNshVIgCFg8rajH5VSDymg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PqTCxQMosksTx/YKcybNHRixLApMhf/a4oNR9ZkU2+Q=;
 b=oKW1g+MWc5tTAAuzyszl5pVKBr849BjPeoz6Ypa2z5KDJiksyTZnBDKqI11xlPQjgbW1s+3b+EirJplMrYBpQ4Es8iVdGQdpexQXXxx8wQpZoT7XzcrX6HR2iDAFnR7tpOaYW5GbfSnqPzBrKuOknX+HDdUEZY9zvD+YEzGhUbqrfWjcpljadYRipeE9SpS3J9Uq8SWmeO5+tNGT+sPMrsKLpimrtypdJ2QSQNWbFGg1oDp/nMfl9QVKcU1YjuYqVkX0w8lJIS0gryGHGgiFMOXTwN+uSSf1sfIusaItY8MJdtpZghm0HxqINF3x+fxsj6tNKTE15zFehyXdRnBuyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CY8PR11MB7847.namprd11.prod.outlook.com (2603:10b6:930:7c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.24; Mon, 14 Oct
 2024 01:34:10 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%3]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 01:34:09 +0000
Date: Sun, 13 Oct 2024 20:34:05 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Fan Ni <nifan.cxl@gmail.com>, <ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Navneet Singh <navneet.singh@intel.com>,
	Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>,
	Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, <linux-btrfs@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 13/28] cxl/mem: Expose DCD partition capabilities in
 sysfs
Message-ID: <670c750d42e5_12d98c2949@iweiny-mobl.notmuch>
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
 <20241007-dcd-type2-upstream-v4-13-c261ee6eeded@intel.com>
 <Zwbrm690XW_8ImRW@fan>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Zwbrm690XW_8ImRW@fan>
X-ClientProxiedBy: MW4PR03CA0220.namprd03.prod.outlook.com
 (2603:10b6:303:b9::15) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CY8PR11MB7847:EE_
X-MS-Office365-Filtering-Correlation-Id: 2514161d-97eb-46a0-8d46-08dcebf04d11
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JbP9tHn+Cxv8It5mnIMrefZKxv4Va5Dlx1lSO1geDPOWclQjLpjnh+a0++IA?=
 =?us-ascii?Q?hH9NYjEoXt/MHMBYYdFy6GaYTFb+BIFPnY+ekFWHPLzSBYUQCKLJMWGJV0Nj?=
 =?us-ascii?Q?8XA+pKG8gHGNkVGZxUEhgWsFChnZ+LRMEve2y3/v3Yyv9Xym+blEx6NY5Nfv?=
 =?us-ascii?Q?lbDWwmiVkU/pLniqR8X0M3kKm82mHJIXkmlAuMBc7oWiO8UqgRr8mR7jmfyZ?=
 =?us-ascii?Q?3T20UK7gF5uCbIV22vgsSVF4ijRbikp6FULA5vtu/2NYP99SDvmzQr+LAtbS?=
 =?us-ascii?Q?aVwi8K4dgT/dLo4c5vsx0Cd1krPFlgNfxuUtQQjMYT0dwsCpJS3bYh+XS6iP?=
 =?us-ascii?Q?SA16jAbQpxyLorOtRq1w3Xl+EiehkzZwvoNXvQT8W+VjgunOG6QexgBGhKER?=
 =?us-ascii?Q?qTmDIyYrwfEwA3tcNLz1Z96k+qZ53CzNEPZHRAh3CK/Pui2LQqiqc+zPQpiA?=
 =?us-ascii?Q?nRSVplrmvzVh/8hCbDrbK2VxoVKBmypOyTaimpuuN2rEeV87n71UeQEwb8yS?=
 =?us-ascii?Q?Mz/nmWOWeana+bZ5HbB7VVEB1qtMY3nnxu6O+9Oj+m/+9DYPIQseuHnO/HQz?=
 =?us-ascii?Q?p2rJZ3WArVeogFhOkr+d3MX2tU/c6ULUz1e0DWFgLDKOWNS91GyXLV4fcUru?=
 =?us-ascii?Q?LqGsxC6K+UW8ZkMu3eXKt8hYEM0MuNzcsDm1k/nMxykA5if5TRKXWcM9//Za?=
 =?us-ascii?Q?gAszCznCxlCyupLwwxYvHPSAduVapanGwNN6qzRR0P+X4aLt/bxu1IAOjyaZ?=
 =?us-ascii?Q?rl+mvxWKfLlNF4hJCSea3tctl7qFW7kxDRIlumKU3LtGXBu61SNPlD1Xc/q2?=
 =?us-ascii?Q?HbjZDk/E13rNQKd/Sh1S2p2xwMgwg5Jk2skagHSd/qhUV5gkq4N/G4OkikAt?=
 =?us-ascii?Q?gzg3ttz1lHF7PEBLDPaEGCcCPFrHgsG4IcF278sZPXzD+jukv+M91j0U5CVx?=
 =?us-ascii?Q?n710Xec5XZsps14rSvv1EGsFOn6D3KCOkhBAfX8Dve6AfIMPnhtkIO8Bk9Me?=
 =?us-ascii?Q?vYnXNmkFnfVK0Vt4jOI9PmE1niE2noltTRV00WwYkWmdAHI2UmxmZSuEqLCR?=
 =?us-ascii?Q?HIqcD0lU+i9Z/inNfGZTazGPY2h9QNuF9+sz7wWYsXa4179oku5NOxFQTKl6?=
 =?us-ascii?Q?zXnU2cZeolhn0bY3ilyKIJ5ojm0XqoxutnmkwO3u4erstkibMEWJiLY44402?=
 =?us-ascii?Q?hppVjxSjeHG6YSSWKhxxlja4k1p7QLgexuMosdQkPKTxox2SgmmR+TXiaJfq?=
 =?us-ascii?Q?MZtT/jyDD+gcfqfzTZ3xBag0sVb+m7v9lKlBLF2ddg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uflyL07GIhuSS+aAHytHG5mpVcjWudXpqndF28rONd5LxO07sCQxQ0Uu7tAL?=
 =?us-ascii?Q?TmAbchaDr3VKSllqN2V6axDxPUXaOZcBJL+AN7q4nNE8hocXun2weYLwJqAB?=
 =?us-ascii?Q?7/PVlxV4caUu+7s4LZ247AgsXGPGnSHoDN3b1t6rf04Dbr+IngFCcd4mpmtC?=
 =?us-ascii?Q?r6NcqKbg+AKeY48zM1Uye3mLCTfT0njUzhpGFDAJzbqOesMH+UXzief9N13E?=
 =?us-ascii?Q?iazFKaZrxakCLZ9phEDWJ7uKOc3lzWpVC8nreyfEUHqXashfGKJ3zXvj9PK9?=
 =?us-ascii?Q?ahHiMOfTybWAP82TpbbZ12+9sTnQOXNAInsW01z42U8b8glgEtBsg1r1s00+?=
 =?us-ascii?Q?jVxDdK4Jz8k8ZGm64X9pDTZbU0iDsCmVPI0QiHY1g77ZmTto/4kYaSpTPnar?=
 =?us-ascii?Q?cH4Nq0zTmTRWsS/f/inW11sJ81Ucs+d5uuR4Oh5h7xURuD/oU7gPeL/qjfHp?=
 =?us-ascii?Q?5QCPSCoaveDWWvNo+p72AiyS8ngSZE9qhhE5qlkMUCwJaQm5wlhDHLTv9qZL?=
 =?us-ascii?Q?n08PcPYysofufcRULfF/iCTKag6Kdw/+90/W8sBEYe+pkPHDWE3RkNHmbu3i?=
 =?us-ascii?Q?PjUTch5k0bVILKG0Yv+srXxB2DEBYcz6hpb3/Ny3E06SdPH2pgC1H4FIVVcS?=
 =?us-ascii?Q?JXlt3M3DMvLxwgKqNoK4HRq7/SHFJnxYdr260gNZtTky5mw6zGIqld4ZLi6w?=
 =?us-ascii?Q?3Dkm2o4+jbRyRHMLRQDUGntresSWKLgqDWOwoAxbpuBsR1+qaWsjEhGlnqZj?=
 =?us-ascii?Q?omopoz2YAGp2IahxFeWQvrOXB2g9ZDlqASjdY4nXkCrEtdG9FOsl/XebbAZd?=
 =?us-ascii?Q?ihucktpSzifr/Fhhb73BjTUQVFoYsAJ4exQIGtRGJybbFRl0qIoX8K+BT696?=
 =?us-ascii?Q?chazbATwH97Rh8RHy2lDcMcxP07P3T314XowYTtZLNZ1eTOWpqjlTDXV1GvH?=
 =?us-ascii?Q?bXOGBqF/zGrrjrKmg5o6VFgGBcmJwh1gESFIkyIgrJdu7alXfpsIIFgz6j7S?=
 =?us-ascii?Q?r922UxbFl5Yzo3pjyuvXuRcQJxbK7PW9pAN0TVA0+YAtTyubfZc4Jc7Kk6Yr?=
 =?us-ascii?Q?mNa4VNA0Gc7UD3GfLO3Cflzt0Tuv12j1Q3jgnJ3qLp9u3VciZ+BKknjAO7sJ?=
 =?us-ascii?Q?WCfXHyuA3akWpaGIjAWwjZJ4zSH+TsIs0z3eClCzK+oET5DDvx93ONIoUNAc?=
 =?us-ascii?Q?ZgZ9SLXe3JKzvv1gqQh8Jdoy0FIh3ivDJh/2N+/5sVQ/LXxsBPvTI96McsRO?=
 =?us-ascii?Q?o3KjeaPxhA80Nr95E6n+V9GtvBfXWLkUiMS5Va4vroVl33ZFrJUXlhKIRchk?=
 =?us-ascii?Q?EkBEMBYsjqyjVMWASh77zo4WxL2BEpqGfrTFzGyJqG5Nx8xZBsyJe8PtL7Cy?=
 =?us-ascii?Q?hY5RdOS+jecSWgYz/rKU+hpFFxsJLZmpDGyxjDgiACGrO4KsPY7NuQNj9QkW?=
 =?us-ascii?Q?EYiWrEWRsWx7p7Vel7zUD1TYhHYsoBI5Bh4j9ZwMBlQrNwKQPOCjuUdVqHRT?=
 =?us-ascii?Q?B75MLZ1lb1G6deOikAWtlE7RmlqpXckKcCi1mMVB8mJ2JcheM0ZjeQv4IIHo?=
 =?us-ascii?Q?hU0Xd9HS3cXRP5OCole8U9HacDn9QfkmnnMWqlsj?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2514161d-97eb-46a0-8d46-08dcebf04d11
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 01:34:09.8996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rqvW+Mli7lyx+yCwYV8PyZXUoh/5TIxKWJr+Ixt35sb7oufdMb4egDz8FniQxDySSk4UGLfMim4Ubnk+XE5+vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7847
X-OriginatorOrg: intel.com

Fan Ni wrote:
> On Mon, Oct 07, 2024 at 06:16:19PM -0500, ira.weiny@intel.com wrote:
> > From: Navneet Singh <navneet.singh@intel.com>
> > 

[snip]

> > +
> > +static ssize_t show_read_only_dcN(struct cxl_memdev *cxlmd, char *buf, int pos)
> > +{
> > +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> > +
> > +	return sysfs_emit(buf, "%s\n",
> > +			  str_false_true(mds->dc_region[pos].read_only));
> 
> For this function and below, why str_false_true instead of
> str_true_false??
> 

Oh!  I did not realize they were not the same.  That API is tricky.

Yea str_true_false() is the correct call.

Thanks for noticing that.
Ira

