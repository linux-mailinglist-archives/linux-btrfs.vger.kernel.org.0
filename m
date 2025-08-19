Return-Path: <linux-btrfs+bounces-16143-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64176B2B5B4
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Aug 2025 03:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E9DD3AFFF0
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Aug 2025 01:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF89E1A2547;
	Tue, 19 Aug 2025 01:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n2vJExVV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D15A2F32
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Aug 2025 01:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755565575; cv=fail; b=aAe3RcLd+Rzrt/uhsXuNXPeW2MR2NQZDVQHMTNqxYy2UE7eJi3xB9gE/a7NqBP6I8u4ktq6PD7RljjsXXZB7RTesEEIY6aoRCyMYnWGyiaO5YMKXaa8WljxgL1CSWRI8vefS1wRlT6+GW8VByC8kvQYhFlkbPX6XTa5+eul3Lk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755565575; c=relaxed/simple;
	bh=frzoIEDbjoT7dmj03T/OZr+tIkbP+aQOZMi3prv2EI8=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TNJDsj69q0zYChRfGkmyEQPOhz3OBV8mOH9P0kJB4+0mSKLpgBl7XoQHZt+P33RbKRNdj8Ea3WkHSLzWzU8Upr8D2mi3WW0vek5tJa3bShNUWzwR5S6F6+K9lXQGuVnGgROUMgOhW9kR3ualsv9xciYERm6DSw84CiS/R32wRLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n2vJExVV; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755565573; x=1787101573;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=frzoIEDbjoT7dmj03T/OZr+tIkbP+aQOZMi3prv2EI8=;
  b=n2vJExVVSj02jSjbjRSeK1g4EG0C8Xt9rxnpow5Dkq+467P8Pu+GGv+Y
   kKM79fQizjRK5Uh09OZIz7yNp14PF0Hj/xV4Y2Y9T8Y/c29YKTtViwYhP
   l8lRpRjF5Qxj6FkdUgol8skhVdjZVUVbWDX8DGUgt+WObZrDB84Y6gQv3
   yVLlIilgrEC2DAmw8JrhBQ95yAGhgRHpQUi9TN2Bmyg5jMtIU4Xm8Nt4H
   irKWhTEfEliYr57eaKIXhIzETGEg0Xbbm1affaDjnyU0sA4Av5S+z3kE+
   0MLw/mv8678sJ2QN59IL6WN/7a5BNdYSGC9nSAQPWSLI+Cgi4TPJDE/vt
   w==;
X-CSE-ConnectionGUID: ZzQ5iuBvRdOaVOr9Ejrd8g==
X-CSE-MsgGUID: rZRwsrX8S3aOmF6bGfTaWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11526"; a="57948009"
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="57948009"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 18:06:13 -0700
X-CSE-ConnectionGUID: TId7nCopQn2i63tgcsOkCQ==
X-CSE-MsgGUID: 9sBMz8d9Tf6w+ssNTkAG+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="191395667"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 18:06:10 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 18 Aug 2025 18:06:09 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 18 Aug 2025 18:06:09 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.76)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 18 Aug 2025 18:06:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yo8PyoFJwXHXU9udVKDTAwEJ/7/dX2+PAdsfMkaIiMogMS1jJvA8JgKL6siXufPL133RzgX5oFsWcPsEgfZyCRj0NwHetH9jzU0KigGbfdgPuP2gluwIyS6yRK0NHRKlm+3WNI64SIt57Gb3E1C3K3gYzarUcdHJoHwovSUqFOIZXz4Z8ewkpatg7N9r4LeRhlFKZ0e0No6jrUSQmw09Aj0hBaMkcOk3irr5WzDyh120Ci++aBH4s81EZOirE1z3bcP929hyq4uARo21EBpyhrHey3ZD8pRKQOOoDPZcjGv0sfFLYNUuO1TN1k1d42SF52XKwANBsxAHWDiuN2jXaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WKblu6Xli/hoegL++q16rtc+Km1oMlKzUMvV6yCZ+4A=;
 b=Nl7Ap7lF5DNT2tvpLrG9miKZmjils48L5r5C9UpaB6IrE6SgPxWlBu9eBkGf2ypUFFGMBTZFLfs02xf3g7tptXi5V6KXOo5AAKdfM/NUMaY6yCNidTRLDZXd/aSJDW49mfyPRfuX1LR0cgbJDPpFIvTf4bBcYAWelL+Ieaz0KUk5Skd0n3b6ngYKG3/Y534EKfHYELf5Vow+5Gsvt7RIgoKV6rDUz76gVViURn/ZYtlHDOLLZDmCOA4Bd9hWgArmgFizmRR0625cR+VrawQ/hgfQ7xlKd5CehmUdtHVbYBoTADK+6cWeWMP1KS7IfnoGcF9iZSclCDSP6p15XoPdeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB6905.namprd11.prod.outlook.com (2603:10b6:510:201::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.22; Tue, 19 Aug
 2025 01:06:00 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 01:06:00 +0000
Date: Tue, 19 Aug 2025 09:05:52 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Mark Harmstone <mark@harmstone.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-btrfs@vger.kernel.org>,
	Mark Harmstone <mark@harmstone.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH v2 03/16] btrfs: allow remapped chunks to have zero
 stripes
Message-ID: <202508181031.5f89d7-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250813143509.31073-4-mark@harmstone.com>
X-ClientProxiedBy: SG2P153CA0023.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::10)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB6905:EE_
X-MS-Office365-Filtering-Correlation-Id: 6062b840-fefb-41c8-40b2-08dddebc8f80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Nq/pcojGqnGntZbdHgD3rtcDGdIkX/4LIcmdcv692LoFWbtqRePkizQMKO5U?=
 =?us-ascii?Q?xSkXrBUcK5mWFObhhQpXaHMoz0PhWNSChYo3jVcnEJombnIIJGYj3IfD1+3T?=
 =?us-ascii?Q?mfq5uXfjsnSpIP+ezJTpXv/zHTm1PaX+7BFoZns2krWsB8YuUpZsPMc4o4Hz?=
 =?us-ascii?Q?56V8NzUe63JULoiOJHhDXsmWn+xGWTqLQ6O1mdcKBBni0KEnIBWETE29sWJd?=
 =?us-ascii?Q?1NS6oNb/Szutx6GxypO5VZSZJEXlu8w09DRU2EHD4MconH7o7rCJ2ZkjqLiv?=
 =?us-ascii?Q?vQijwHHyxCiGT7IFvA3ICoGUOD7gjLaW50PSLw//ShsYDApAwv7lmSDBxFRP?=
 =?us-ascii?Q?J/9108B1EpOvxn6sxF8us9zo+xqTgyAQkly5IrQ8MMcJkhaNcDtobHMlE3nA?=
 =?us-ascii?Q?M22NNMowqgrylilMtwpM5DJ/I5bJ3cge4ijR1XmT7ZInU0IIFMEbhEgrZdwQ?=
 =?us-ascii?Q?L8RZVPYzviptkBkhe4hABOOGQXESCIvp6q1yB0AJfJDj9ERE8PmDD40/+VlC?=
 =?us-ascii?Q?VZrIIHMb9LOW/N52c55wZ2Ys2E3DrVlw6/INh8JuFQPTkQxevrEo4LaDeL7S?=
 =?us-ascii?Q?yDSXFQZwImyrefe2wwta65C7k7n8p93IpaUtdpPKB5Jrj2t1NS/CuS1fcBc0?=
 =?us-ascii?Q?yxa8Qk4978QbNmridJKoODnwWOKQ5xngdAG47MG4zPZExQEZh1RHHdSQGaYh?=
 =?us-ascii?Q?nK6jqaIrMHSuYc63nasypW6ZJZ2yRITYZfjQL3DQcz57zdQ8wEFNjBr+M4pH?=
 =?us-ascii?Q?LlRqQBIfF0Ky8dss5PAs+sWi7Ur6DOf+hRgY6baAk66RP3rGf9bFljygo7Gc?=
 =?us-ascii?Q?JHvjn3eNZ5Zb3d6r/0hI7+m8nqavSrgvR7DCPoklmbP3imDv6t+Z7vHrB71Q?=
 =?us-ascii?Q?388ZsJbY2PPLG9adYIS7/9bZSfHbcTSbv7+YTj/B8iywvYwVPSnP6X6huB2W?=
 =?us-ascii?Q?C8XCoBWhOZbZPANIvuBZ1qmoNKoAGEaKBV8NXTrLwt15BMQyrE4/YE2ihpxO?=
 =?us-ascii?Q?2Jbt/iGCrj5/2j4j2tgcjMRk6pwv8oWLyYl57+ycUlB2oUVsXolsMZC3zvd6?=
 =?us-ascii?Q?nZJ2ytUkMrxeYfEZqkjY9RjiHvT3ltyxZZxPQRF6hMwF2EHmyv2cfLk1+A1C?=
 =?us-ascii?Q?ZC8Qla4/FDVMsYvIEhAkqmJ9GTkzDqsJfrCwTYX//Rjjamx4EylXV7oNfJiY?=
 =?us-ascii?Q?XRY318zwj8moaDc982+86YhFThkQxKoP4DuqqJimLnT5rYDdd9f+2AcNncjR?=
 =?us-ascii?Q?GeHCWgwhi0aLtfLhH4hhV9ePGxRmjS62tmzQt5Htf/8Fy/8l/caYkQoPobeE?=
 =?us-ascii?Q?t29H/YaXPosrFFmwjBfBsL0tz/3HRWr87d4tBQrGfxq/p4mgJrtr0VnhcaB/?=
 =?us-ascii?Q?bdFmgV+pyeK1SLX7tut/R73u81uh?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ux0zRAWWXA/kLSx/k+q0mjNVEa1wWV2T1oCUMG1Toz3O4zZesvc+Dq9Zld20?=
 =?us-ascii?Q?j+amCWsAQAvLBAlhqm1wT9BpMidum9OrzJppTl0A1/3Aj54qWFgLcboyB+pI?=
 =?us-ascii?Q?1JVRgApYHn2WiGpxUYs7KVACt2iuhI7wJbvtVR1mV5gogEEGK5kOD/VUc9GR?=
 =?us-ascii?Q?w+sZcu8HjelpnndPtvBjUnP+wo9GWVrYMwrsZ5+FnzqP/897otdV/zdqpT8W?=
 =?us-ascii?Q?qfirZSyaCUf0WaR5hhQV+j/9GQ2M74uvtRWsZTDp9iAKE33CaiYEmXlf4jaB?=
 =?us-ascii?Q?WHVOckCKml9ohUKbupZlF+jqRRquXTXz/h8tPQNAZYEdAq46uoTspiLA6nkn?=
 =?us-ascii?Q?R1SF1VrjhIPrw5S1bkit0FQ6ZK2pROWmlpO+LbcQtSKlMVXeHaeVBPMuaJIT?=
 =?us-ascii?Q?thqOyDbUVQIi+kR6hCuGuKcVzNZN8casnmtD9x4SvdZs9swIllSmYAm4sPno?=
 =?us-ascii?Q?xUzrR+dDTe7FfQdyxAGOvcxBnLHqR6Vys966F8HmDk20DGcavoKg365FEBN0?=
 =?us-ascii?Q?9nkQlRA8AmmHidzfWtoSWASWAWYAoz90gvPrHTe91coZHt0wMEB5HkcWc/QC?=
 =?us-ascii?Q?qS4t/K6L8mC3a7wZ+afq32SmBIE256UMDMjozCfUBE7PGakYKxZmppdcLx7w?=
 =?us-ascii?Q?TK5sok6t80hZ70hSsPbkzAiAYK7quWrutHO8tLzlRFUx50mGaLC0T4ZKE0Q8?=
 =?us-ascii?Q?SeWs5J6M3oLp7T85Bz3pJo3VA/wmmAmGkAt5e2rgU0eAt91T41oFeQE4c3NS?=
 =?us-ascii?Q?dN8ZirAR6MCJchytx0lK2I3cAqBx+GvrxkxdrdJItFKEyas4zEItHtl/ExuP?=
 =?us-ascii?Q?+v3jh7lp+fiiAQk5H34KyxULhsZlQ+6xo7v6HK9yXiQ2MsVbrE4cmymkJur5?=
 =?us-ascii?Q?cZvMbTN/0z9/9kbWgXEne8iAtKeHe2vpz7PV468e0uTNxC6brdM+lBre+d6F?=
 =?us-ascii?Q?nDBSgmNyPVRzr27EAya0tp37D8lsMl6bHWLaqj0RsCfUrFNQW5PGmnQ3tH9y?=
 =?us-ascii?Q?Jh9iDsq+zHOjCJqDGl/jHlbC4MSdNO+brluuNBaKYSjAmWHmWSCy490LgKGT?=
 =?us-ascii?Q?PUe5fpHJxedYYuZlchbl2MHYarqsOsQ+yxvl/9p0IH9XVYA0lgc9rtVf8Vpp?=
 =?us-ascii?Q?3joEAFUZqfI/PEXSNToS3mbZ/2tfbyGWbM6l6W8nyYJDKgr0sa25zlEgv6p8?=
 =?us-ascii?Q?nfQz5g3aINDJWD30OBQ1WA8qjEBSYGxUOicsGzJSLzgrLzlLqopmwjm6xr3P?=
 =?us-ascii?Q?mkF5Ihr9cMpckEY2NPuw2U/utLzXIlBFYCQb6l+9SOdaLvaMfut8LGcz0AAP?=
 =?us-ascii?Q?P2RbMS2Ve/O6mHDYj0br+FFW2AcsbqbdntBJpc/g3UUzoMqToO08ROcWt1Q7?=
 =?us-ascii?Q?+0DDrXkdYlp3TCKCtno8Cder87jlbw33rCMjnSSY47lj5r0+k2/qRkM8qMYc?=
 =?us-ascii?Q?qsrRP7+/RdK8zsL28x/eDZUEO11HQTWI/OI9Uh05F9bemh0V6NPGpKKDdF5C?=
 =?us-ascii?Q?eNbTIYi04Ih90Eu5T33Bz5AjniM5+85E8KB81sWKzH7sxxL1Olef1Yqevas8?=
 =?us-ascii?Q?tjL8yoJdGXvsigkhw/quzyqE051WU0eLDzXAsvLXru9FMFlKLmouXmlAkW3Q?=
 =?us-ascii?Q?6A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6062b840-fefb-41c8-40b2-08dddebc8f80
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 01:06:00.3447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fWYOLMcNLlWkpwwYtVQlUbMPCdgWZBU45B3n2gbr8akf8fedG1cwRIJ2AhYZFC2qv0yT0gcY3usvFuSlSgZTXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6905
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "kernel_BUG_at_fs/btrfs/tree-checker.c" on:

commit: 7ec33e314b27be8996378a9601527017b6ebba95 ("[PATCH v2 03/16] btrfs: allow remapped chunks to have zero stripes")
url: https://github.com/intel-lab-lkp/linux/commits/Mark-Harmstone/btrfs-add-definitions-and-constants-for-remap-tree/20250813-224507
base: v6.17-rc1
patch link: https://lore.kernel.org/all/20250813143509.31073-4-mark@harmstone.com/
patch subject: [PATCH v2 03/16] btrfs: allow remapped chunks to have zero stripes

in testcase: xfstests
version: xfstests-x86_64-e1e4a0ea-1_20250714
with following parameters:

	disk: 6HDD
	fs: btrfs
	test: btrfs-group-02



config: x86_64-rhel-9.4-func
compiler: gcc-12
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz (Haswell) with 8G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202508181031.5f89d7-lkp@intel.com


[   65.722045][ T7549] ------------[ cut here ]------------
[   65.727330][ T7549] kernel BUG at fs/btrfs/tree-checker.c:847!
[   65.733149][ T7549] Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
[   65.739195][ T7549] CPU: 5 UID: 0 PID: 7549 Comm: mount Tainted: G S                  6.17.0-rc1-00003-g7ec33e314b27 #1 PREEMPT(voluntary)
[   65.751607][ T7549] Tainted: [S]=CPU_OUT_OF_SPEC
[   65.756182][ T7549] Hardware name: Dell Inc. OptiPlex 9020/0DNKMN, BIOS A05 12/05/2013
[ 65.764022][ T7549] RIP: 0010:btrfs_check_chunk_valid (fs/btrfs/tree-checker.c:847 fs/btrfs/tree-checker.c:1004) btrfs 
[ 65.770855][ T7549] Code: 24 18 4c 8b 5c 24 10 e9 81 f9 ff ff 48 89 4c 24 18 4c 89 5c 24 10 e8 78 9f 52 bf 48 8b 4c 24 18 4c 8b 5c 24 10 e9 2c fd ff ff <0f> 0b 48 c7 c7 a3 99 51 c2 48 89 4c 24 10 e8 f6 9e 52 bf 48 8b 4c
All code
========
   0:	24 18                	and    $0x18,%al
   2:	4c 8b 5c 24 10       	mov    0x10(%rsp),%r11
   7:	e9 81 f9 ff ff       	jmp    0xfffffffffffff98d
   c:	48 89 4c 24 18       	mov    %rcx,0x18(%rsp)
  11:	4c 89 5c 24 10       	mov    %r11,0x10(%rsp)
  16:	e8 78 9f 52 bf       	call   0xffffffffbf529f93
  1b:	48 8b 4c 24 18       	mov    0x18(%rsp),%rcx
  20:	4c 8b 5c 24 10       	mov    0x10(%rsp),%r11
  25:	e9 2c fd ff ff       	jmp    0xfffffffffffffd56
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	48 c7 c7 a3 99 51 c2 	mov    $0xffffffffc25199a3,%rdi
  33:	48 89 4c 24 10       	mov    %rcx,0x10(%rsp)
  38:	e8 f6 9e 52 bf       	call   0xffffffffbf529f33
  3d:	48                   	rex.W
  3e:	8b                   	.byte 0x8b
  3f:	4c                   	rex.WR

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	48 c7 c7 a3 99 51 c2 	mov    $0xffffffffc25199a3,%rdi
   9:	48 89 4c 24 10       	mov    %rcx,0x10(%rsp)
   e:	e8 f6 9e 52 bf       	call   0xffffffffbf529f09
  13:	48                   	rex.W
  14:	8b                   	.byte 0x8b
  15:	4c                   	rex.WR
[   65.790121][ T7549] RSP: 0018:ffffc9002239f960 EFLAGS: 00010283
[   65.795985][ T7549] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000001500000
[   65.803738][ T7549] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff88814af8e0bc
[   65.811492][ T7549] RBP: ffff88814af8e33c R08: 0000000000000001 R09: 0000000000000005
[   65.819246][ T7549] R10: e400000000000001 R11: 0000000000000000 R12: 000000000000000a
[   65.826998][ T7549] R13: 0000000000000008 R14: 0000000000000005 R15: 0000000000ff0000
[   65.834749][ T7549] FS:  00007f8edf369840(0000) GS:ffff8882182db000(0000) knlGS:0000000000000000
[   65.843446][ T7549] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   65.849838][ T7549] CR2: 0000562e34dee000 CR3: 0000000201f00005 CR4: 00000000001726f0
[   65.857589][ T7549] Call Trace:
[   65.860704][ T7549]  <TASK>
[ 65.863474][ T7549] ? set_extent_bit (fs/btrfs/extent-io-tree.c:1099) btrfs 
[ 65.869002][ T7549] btrfs_validate_super (fs/btrfs/disk-io.c:2369 fs/btrfs/disk-io.c:2558) btrfs 
[ 65.874869][ T7549] ? crypto_alloc_tfmmem+0x92/0xf0 
[ 65.880390][ T7549] ? __pfx_btrfs_validate_super (fs/btrfs/disk-io.c:2393) btrfs 
[ 65.886682][ T7549] ? btrfs_release_disk_super (include/linux/page-flags.h:226 include/linux/page-flags.h:288 include/linux/mm.h:1424 fs/btrfs/volumes.c:1337) btrfs 
[ 65.892995][ T7549] open_ctree (fs/btrfs/disk-io.c:3373) btrfs 
[ 65.897997][ T7549] ? __pfx_open_ctree (fs/btrfs/disk-io.c:3282) btrfs 
[ 65.903426][ T7549] ? mutex_unlock (arch/x86/include/asm/atomic64_64.h:101 include/linux/atomic/atomic-arch-fallback.h:4329 include/linux/atomic/atomic-long.h:1506 include/linux/atomic/atomic-instrumented.h:4481 kernel/locking/mutex.c:167 kernel/locking/mutex.c:533) 
[ 65.907740][ T7549] ? __pfx_mutex_unlock (kernel/locking/mutex.c:531) 
[ 65.912572][ T7549] btrfs_get_tree_super (fs/btrfs/super.c:978 fs/btrfs/super.c:1937) btrfs 
[ 65.918346][ T7549] btrfs_get_tree_subvol (fs/btrfs/super.c:2074) btrfs 
[ 65.924203][ T7549] vfs_get_tree (fs/super.c:1816) 
[ 65.928432][ T7549] do_new_mount (fs/namespace.c:3806) 
[ 65.932749][ T7549] ? __pfx_do_new_mount (fs/namespace.c:3760) 
[ 65.937580][ T7549] ? __pfx_map_id_range_up (kernel/user_namespace.c:382) 
[ 65.942669][ T7549] ? security_capable (security/security.c:1142) 
[ 65.947330][ T7549] path_mount (fs/namespace.c:4120) 
[   65.951561][ T7549]  ? 0xffffffff81000000
[ 65.955533][ T7549] ? __pfx_path_mount (fs/namespace.c:4047) 
[ 65.960193][ T7549] ? kmem_cache_free (mm/slub.c:4680 mm/slub.c:4782) 
[ 65.964939][ T7549] ? user_path_at (fs/namei.c:3131) 
[ 65.969259][ T7549] __x64_sys_mount (fs/namespace.c:4134 fs/namespace.c:4344 fs/namespace.c:4321 fs/namespace.c:4321) 
[ 65.973843][ T7549] ? __pfx___x64_sys_mount (fs/namespace.c:4321) 
[ 65.978934][ T7549] ? do_user_addr_fault (arch/x86/include/asm/atomic.h:93 include/linux/atomic/atomic-arch-fallback.h:949 include/linux/atomic/atomic-instrumented.h:401 include/linux/refcount.h:389 include/linux/refcount.h:432 include/linux/mmap_lock.h:143 include/linux/mmap_lock.h:267 arch/x86/mm/fault.c:1338) 
[ 65.983938][ T7549] do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94) 
[ 65.988257][ T7549] ? exc_page_fault (arch/x86/include/asm/irqflags.h:37 arch/x86/include/asm/irqflags.h:114 arch/x86/mm/fault.c:1484 arch/x86/mm/fault.c:1532) 
[ 65.992749][ T7549] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
[   65.998441][ T7549] RIP: 0033:0x7f8edf568e0a
[ 66.002672][ T7549] Code: 48 8b 0d f9 7f 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d c6 7f 0c 00 f7 d8 64 89 01 48
All code
========
   0:	48 8b 0d f9 7f 0c 00 	mov    0xc7ff9(%rip),%rcx        # 0xc8000
   7:	f7 d8                	neg    %eax
   9:	64 89 01             	mov    %eax,%fs:(%rcx)
   c:	48 83 c8 ff          	or     $0xffffffffffffffff,%rax
  10:	c3                   	ret
  11:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  18:	00 00 00 
  1b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  20:	49 89 ca             	mov    %rcx,%r10
  23:	b8 a5 00 00 00       	mov    $0xa5,%eax
  28:	0f 05                	syscall
  2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- trapping instruction
  30:	73 01                	jae    0x33
  32:	c3                   	ret
  33:	48 8b 0d c6 7f 0c 00 	mov    0xc7fc6(%rip),%rcx        # 0xc8000
  3a:	f7 d8                	neg    %eax
  3c:	64 89 01             	mov    %eax,%fs:(%rcx)
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
   6:	73 01                	jae    0x9
   8:	c3                   	ret
   9:	48 8b 0d c6 7f 0c 00 	mov    0xc7fc6(%rip),%rcx        # 0xc7fd6
  10:	f7 d8                	neg    %eax
  12:	64 89 01             	mov    %eax,%fs:(%rcx)
  15:	48                   	rex.W
[   66.021939][ T7549] RSP: 002b:00007ffe66b952e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
[   66.030126][ T7549] RAX: ffffffffffffffda RBX: 0000557c5d7619e0 RCX: 00007f8edf568e0a
[   66.037879][ T7549] RDX: 0000557c5d761c10 RSI: 0000557c5d761c50 RDI: 0000557c5d761c30
[   66.045631][ T7549] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000557c5d762940
[   66.053384][ T7549] R10: 0000000000000000 R11: 0000000000000246 R12: 0000557c5d761c30
[   66.061140][ T7549] R13: 0000557c5d761c10 R14: 00007f8edf6d0264 R15: 0000557c5d761af8
[   66.068895][ T7549]  </TASK>
[   66.071750][ T7549] Modules linked in: snd_hda_codec_intelhdmi snd_hda_codec_hdmi btrfs blake2b_generic xor intel_rapl_msr zstd_compress intel_rapl_common snd_hda_codec_alc269 x86_pkg_temp_thermal snd_hda_scodec_component raid6_pq snd_hda_codec_realtek_lib intel_powerclamp i915 snd_hda_codec_generic coretemp snd_hda_intel sd_mod snd_hda_codec kvm_intel intel_gtt sg snd_hda_core drm_buddy ipmi_devintf ipmi_msghandler platform_profile kvm snd_intel_dspcfg ttm snd_intel_sdw_acpi dell_wmi snd_hwdep irqbypass drm_display_helper dell_smbios ghash_clmulni_intel mei_wdt snd_pcm cec dell_wmi_descriptor drm_client_lib rapl ahci sparse_keymap rfkill snd_timer libahci drm_kms_helper intel_cstate mei_me pcspkr dcdbas intel_uncore libata mei video snd i2c_i801 lpc_ich soundcore i2c_smbus wmi binfmt_misc loop fuse drm dm_mod
[   66.142949][ T7549] ---[ end trace 0000000000000000 ]---
[ 66.148220][ T7549] RIP: 0010:btrfs_check_chunk_valid (fs/btrfs/tree-checker.c:847 fs/btrfs/tree-checker.c:1004) btrfs 
[ 66.155057][ T7549] Code: 24 18 4c 8b 5c 24 10 e9 81 f9 ff ff 48 89 4c 24 18 4c 89 5c 24 10 e8 78 9f 52 bf 48 8b 4c 24 18 4c 8b 5c 24 10 e9 2c fd ff ff <0f> 0b 48 c7 c7 a3 99 51 c2 48 89 4c 24 10 e8 f6 9e 52 bf 48 8b 4c
All code
========
   0:	24 18                	and    $0x18,%al
   2:	4c 8b 5c 24 10       	mov    0x10(%rsp),%r11
   7:	e9 81 f9 ff ff       	jmp    0xfffffffffffff98d
   c:	48 89 4c 24 18       	mov    %rcx,0x18(%rsp)
  11:	4c 89 5c 24 10       	mov    %r11,0x10(%rsp)
  16:	e8 78 9f 52 bf       	call   0xffffffffbf529f93
  1b:	48 8b 4c 24 18       	mov    0x18(%rsp),%rcx
  20:	4c 8b 5c 24 10       	mov    0x10(%rsp),%r11
  25:	e9 2c fd ff ff       	jmp    0xfffffffffffffd56
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	48 c7 c7 a3 99 51 c2 	mov    $0xffffffffc25199a3,%rdi
  33:	48 89 4c 24 10       	mov    %rcx,0x10(%rsp)
  38:	e8 f6 9e 52 bf       	call   0xffffffffbf529f33
  3d:	48                   	rex.W
  3e:	8b                   	.byte 0x8b
  3f:	4c                   	rex.WR

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	48 c7 c7 a3 99 51 c2 	mov    $0xffffffffc25199a3,%rdi
   9:	48 89 4c 24 10       	mov    %rcx,0x10(%rsp)
   e:	e8 f6 9e 52 bf       	call   0xffffffffbf529f09
  13:	48                   	rex.W
  14:	8b                   	.byte 0x8b
  15:	4c                   	rex.WR


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250818/202508181031.5f89d7-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


