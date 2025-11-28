Return-Path: <linux-btrfs+bounces-19422-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8834DC93452
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Nov 2025 23:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6EDB84E2CB2
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Nov 2025 22:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0119E2E8B7E;
	Fri, 28 Nov 2025 22:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RC4N+OiP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4982D4B68;
	Fri, 28 Nov 2025 22:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764369650; cv=fail; b=O/b4qeRQDEwMk9NHyOrtzm77W7qYjnQ1O7qt1/tuLHmX1GPYVPCOWCLK733llEaZlZMsQZFpIMDrp/ZbNVo+jb5wkTgfcFu7BeVMqZTuMn/b7SAWbVYMXwNMZQfms9LL2ksWGTUVB5Cv1LFb6OK6fMWvGGFW3/OX1Xn7pmqrCy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764369650; c=relaxed/simple;
	bh=W1yQIPfW9GBKJxOY/jfpaLsZsA8IWsIBuT3aWylIdaM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UlWx+vilIynXzkwn0FH/ntN1bV1hxEzAbmWZnNZdHBZxb2UboTygbVJJpORnju7Q2k3Yg0qFNlQat/zHwbTf/A/xsiqQRYkkppEXgKsIPR5C+8EzqViVzWPPDX25WM2js3mFbQ9YLyeY3g2YzmXp7h3hGW+gO9HiKQDiA4jCBMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RC4N+OiP; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764369648; x=1795905648;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=W1yQIPfW9GBKJxOY/jfpaLsZsA8IWsIBuT3aWylIdaM=;
  b=RC4N+OiPwoylsqIlXvcqOG3r88ar66pUPjukSQJ1KfXmtXgMEh6ZKd4H
   8n/pEN/PmojrgYmi8JPMYi2sH3Dr/c3ePfB20802bpiBJpxcJVZbalPHb
   iQE8hK28VRkDKqAe03NTTAQGQ730xK6lJZqRIVt+QwUmYKwe/gx2eSupc
   pJ3AyEK0f2UaHggCvux1Q0KqwmyJuUnUGdynm01e5uZbReW2SDQoCNeon
   OyKEmpUTrEtI1v4walNVqR7SEkkmR8Id5Py5i4LrjeiJKWIQasdX0O8lw
   jToQNz4Iy9phP0BBCs8W5e8wQ7ueeEVdkzLtw3snp9GwAsLO6l7s6bae5
   g==;
X-CSE-ConnectionGUID: jF3V3CmpSNCrZ51krWBuPg==
X-CSE-MsgGUID: CgAOw5peQH62mR4KcuNvTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11627"; a="77755795"
X-IronPort-AV: E=Sophos;i="6.20,234,1758610800"; 
   d="scan'208";a="77755795"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2025 14:40:47 -0800
X-CSE-ConnectionGUID: YqSUkgqBRlKTXOyaqnzALw==
X-CSE-MsgGUID: hI/MKvmnS52pr/NYN1zbjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,234,1758610800"; 
   d="scan'208";a="193663336"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2025 14:40:48 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 28 Nov 2025 14:40:46 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Fri, 28 Nov 2025 14:40:46 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.13) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 28 Nov 2025 14:40:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fPmCIa32oUVhjA69mdMuJIzBxmVi259/MbwTqb9RAVXgL/SF2CgsAah08rkPCwRxFCnTufZjs7oMl+rIcdkUYdm/yFUWeZ1OCcP6Zh18UauHsFfT1G3v40aAvsLuVUoKUcaluWxyHWKYaS2fSNMjGA7s2CkCEYEHVpLJhwfEKAWTUQ7ycKzhmNQaDtnmG5eisHjbYXVNv+6bOm0SCXMD6KnkvLTZ0wvFLWHd+QgiciUhLLyU36xYs0DrkR39ssqDXmLoRtLt89a3tQVf6bDCSe6bOUWHRuokpGCIQWlVrz5t6YMViqbNlPPjr2E+WObwLrc6GpU1A3dYHh254RxYMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F1PSgLXMmhJ6asrIJSwnhT4fG8GlMYGTyn34MrwB+Ms=;
 b=hjjPUK2lDWH3ZgrUrNorsoW9b+wNFYD8Q5M1MHuhQgask5VrYeOtQHuT0i1p/JmYAsTK1IE0Q0bwFY8WvP3jYQ8gQpgGEk5jOrpqiDLIdMWfeSTGv4FdxMKsv/Bl9aU1nB+Fv0SgTZr6iqAkSCtLKYlihoc4/53DRXBuBM1a2JOKx1ZpbPgNyQydd1S953YNe0Wydj9IcYEW6MWbzYAmYLIjQ0R7m6Ve66NQiHbSVaDjJYhAjp2t1klFIDL1ZZOl2kcdfchEOM6l5VhdtZRNAR3y+EWAC9WYRa0UFC3AIRKAUTyIRsHm/t10MeX5wt6EkuSXiB9EDr5G7iunc0kRfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by SJ2PR11MB8371.namprd11.prod.outlook.com (2603:10b6:a03:543::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Fri, 28 Nov
 2025 22:40:43 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::22af:c9c9:3681:5201]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::22af:c9c9:3681:5201%5]) with mapi id 15.20.9366.012; Fri, 28 Nov 2025
 22:40:42 +0000
Date: Fri, 28 Nov 2025 22:40:33 +0000
From: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To: Qu Wenruo <wqu@suse.com>
CC: <clm@fb.com>, <dsterba@suse.com>, <terrelln@fb.com>,
	<herbert@gondor.apana.org.au>, <linux-btrfs@vger.kernel.org>,
	<linux-crypto@vger.kernel.org>, <qat-linux@intel.com>, <cyan@meta.com>,
	<brian.will@intel.com>, <weigang.li@intel.com>, <senozhatsky@chromium.org>
Subject: Re: [RFC PATCH 16/16] btrfs: add compression hw-accelerated offload
Message-ID: <aSok4RiuQVZ8zckR@gcabiddu-mobl.ger.corp.intel.com>
References: <20251128191531.1703018-1-giovanni.cabiddu@intel.com>
 <20251128191531.1703018-17-giovanni.cabiddu@intel.com>
 <1dc1adaf-635c-405b-84c9-97d9567f8c14@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1dc1adaf-635c-405b-84c9-97d9567f8c14@suse.com>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
X-ClientProxiedBy: DB8PR06CA0061.eurprd06.prod.outlook.com
 (2603:10a6:10:120::35) To CY5PR11MB6366.namprd11.prod.outlook.com
 (2603:10b6:930:3a::8)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6366:EE_|SJ2PR11MB8371:EE_
X-MS-Office365-Filtering-Correlation-Id: 404227fd-3a19-4d8b-95ce-08de2ecf29cb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NHlhNzduSWVlNERSR1ZVcUJHOG1KejBsUU5wNXVndjl4akxyTFBhVzFOSHlt?=
 =?utf-8?B?dWUrUVR5emxyVE5BdTk5SkVzS3JmMHV1ekp0WElVZEcrV29XaDUxdk5MU2hU?=
 =?utf-8?B?Q3RFNURiVFBUZksyU2tQc0FmbnFiMyt6djNhTUhzRTE5YlREbGcyVWQ1UWxD?=
 =?utf-8?B?TUFnY0pDcnVrUElLa2V1SHJyNDRISGczc2NvYTZPUTdoVlVtY2llbExRWkJQ?=
 =?utf-8?B?WXdDenlTV3VYWU15dm9TeW9LbFRtaStqY0F6cEt6VzFMb3lqWDdjVDJYcm1h?=
 =?utf-8?B?RnRiN21RL0E0elRCTHdBS2RtdmpjQ1ExdFNUemZ4R1lQeGNiVG01VkdUSi9y?=
 =?utf-8?B?NFFkMWNMc1FKakt4UGg2Slh6QXNYNC80TlJFUXQ0OGhvbVpKTzRicmgxTnpo?=
 =?utf-8?B?UXRIU1Y3Q2ZxZmlXdVI3bWdoVHlVVklYa0o5WjVIeVVmYjdBZ1JER0p5ZGtS?=
 =?utf-8?B?MXl6K2h3WVZXOEZ6bmMvR2dQdG9GM1hhUWpkYVczTUMxNDU4Q1ZmeVVyMUlt?=
 =?utf-8?B?OUcxRXRzWFdQMHBrcDB1aktDSjk2VXNHQjd0TEJEVDF2STRCZy93dFBXRVpk?=
 =?utf-8?B?a2dpY1FudXNuanZlbklGOWkrYW9KYmZITllKMGU0WjJhMXJzb09Obm5SdGhM?=
 =?utf-8?B?TXVFZWh4Z0h1bzFDUU5aa2QrUithbTdUaGN1RUY5SGlSUUZFSmRJaERXd3VE?=
 =?utf-8?B?aEVlclluRmxEUHhneU9tZ0JIMis3a2NjSnhFdUwyTlF2T0VUUmY2b2VjVTJ0?=
 =?utf-8?B?N0U5RkU3ZlBmZk5OTUliMXZjUFhnejZQOWFuWXRTUnNDbFJxYVVGUEZsZEVo?=
 =?utf-8?B?R1VqY1pMRHNudTl1SVhSNEVNS0tBdlBuYzAyT0wvazlUeHpHYmhRdk9rcGxQ?=
 =?utf-8?B?UEt6ckIvNU5hOTB4SG5iTHhtZXpETkFzUGdKcUppVnFEVjZTZC82RHlXWWZ3?=
 =?utf-8?B?VTZ0Mi95Z1VCRjdnYmlKMlZjN3lKS3RWMnBYNyt3K3R0UDBvWXhsVW4ra2xN?=
 =?utf-8?B?TmNUT1RXYTdEbFZwYkhOVjhQYlZpSERlVEwxWGdxQkVTK1JwMUo5M3lnU1pL?=
 =?utf-8?B?VURSb2M1ZnBrUE1EZ2hlWWdQeUR6d2F5TzBidk5mc2tZV2RNaXFaTGZRbFFl?=
 =?utf-8?B?cDYyb3d4QTViMkVXZ0hWRndWK2NPZ1NXeThGV0crRityaGVaUnNEV0p3Z0tM?=
 =?utf-8?B?WHZYbzN3YWtpemQ2M2F0VHVzaS85QXVMeFN5YzZhN210VElpSlBZb3dIdCsv?=
 =?utf-8?B?OXdyUGFJSmZCYnR0ZFBuNlRKbnlJbGV2TkFzQXVhNzZzaFVyVzFmajJXaU8x?=
 =?utf-8?B?YXJMUWdLRXVCOFVpODNMM2FabnR0RVBDa3FxeC9kMWVuc1dsWXBBbm5KWDgy?=
 =?utf-8?B?YnJ4dHJOZStKdFRGM1FRUFZzY093eVZmYkRISlcyWkt5bGxVN3FwNXVlTTFh?=
 =?utf-8?B?ckxjbVllSjR4ZXE1YktMSW1Ca3phSHNnYUk1NXNqR2NjNU0zTWhPOWVPTFlm?=
 =?utf-8?B?dlQxWjJPcmVBUmx3d29NYU1rdU5hMngyc1lRS0ZnQmY3bTlKeGZua0RSSjI1?=
 =?utf-8?B?M3NyR0ZIRDhxMDZEcHh4NUVGUjdrNHE5WEkrMHpMRldKVjRnNnlhZklIK3BR?=
 =?utf-8?B?RVl1b0t0WDlFTkN5d0tpWnNxWDZCQU9zMktkTC9RNkxtRXFDRGFpMVMxQzJk?=
 =?utf-8?B?Q1FPYVJKRFUweXNyZm5mS09FRWk1eGxlTXdLYlhVN2FMVU9wVmJYY1pzM3hF?=
 =?utf-8?B?SFBxSk1NQjVzVjVrYjhwZlZNNUpDQ2hUMll4Q2VtbTYvUkdrcld3V1owRDR5?=
 =?utf-8?B?SjJ1UUdvNnZZaXlVckd0cWkxcVhIbWJGK1pTQzNOQ2F5SGxwUjJWZnJWRmM2?=
 =?utf-8?B?UzNOQWJVZW5oVWdwQS8zbWUrdTRzcHNQUFIvYWh6Ylp4SCtJMVEwWE9zSlYz?=
 =?utf-8?Q?HyG6Bk5D/wbeXvzVYhu6D9VvA/sz3RjM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0dqd1FkMW5yNTZHcEFkMlVKMjg5S0N4V2EyNFpFRkxBRmQ0Zzk1UVlNRjVa?=
 =?utf-8?B?bkFVQTRPWEtLcE9QT2Jidmo3TE9LYU44UlBubGNrdi93YTBEVXVZYzZwc1VD?=
 =?utf-8?B?RDZYTnA1bTJaMWpadFlFbzFkMlV4UE0wd1A0bzBiVVZxMVB4ekhrVE1PUkNo?=
 =?utf-8?B?eEZOUUd2Q0x6U3B0d2FRbFppRmhiWkhWOEhlTXpzcmhFbkYxWWZES2RkNjVy?=
 =?utf-8?B?ZXN6NzJWdUVjeFcrWEU0SmFPZzVaUnVodXFWUkYvZTUxaDlRRjVnVkhmaG1O?=
 =?utf-8?B?TWNFOEV1ZDFjcVd3ZWxUMEpQb3VuUEpzb3BFT0Fnek1CYkwzVmJhL2RIaktu?=
 =?utf-8?B?UWhhMnAyTWpEWFdTWEpzMC9sQjJKNisrblgwMzdUQzl0SW5XN3RIL0FNcm9D?=
 =?utf-8?B?ZDlrczBqUXVBZGZIa1R5anBWdlBkMlIyejN1UU5WaWhSeXBpMlE0REppYTUr?=
 =?utf-8?B?OE8zNFF4ME00azlCK0VCUm1wcWxGLzBHeksycTdsODNwYUgrMXVBWWFDalZ0?=
 =?utf-8?B?MHdVWDhRNktIRlN3S1NmWmJJZ3N6R01jNWMrS3doRk43RVhTbFJoM3puSjF1?=
 =?utf-8?B?NXZldDJtd0V2eVR0bDNRZFVsOERqdlp0K3hwMk5DSDJVbkswVEE5ZURmcmJH?=
 =?utf-8?B?Y2FJN1A5RE5Lc3RLL0cwdXh1dVZha2Z2Qk5rL2o1bVRnQTlDbW1oSDFiWll0?=
 =?utf-8?B?RzVwa2lBQ1IwbGFFNmVXRkFOYXZoUVJNRjROc0FNd0RwU2syMVZhSGtpelJn?=
 =?utf-8?B?L0xBU2pOMnQzYkhKa1d2OWRiVXg3NjcvcUR2SWJhNjVVUFlpa2g1WS9Qeisx?=
 =?utf-8?B?TXRvaUJxc1h2Z0ltL2hmK3ZyVkRSeERZVk9PTUZ1Rll2bW1zMXIyQ2lWYm9s?=
 =?utf-8?B?SmF3L0tuNG0rUlg5SnNMbVdDS0dYSUtJbmN5Witmam1sOURtNDVTeUxuNzJD?=
 =?utf-8?B?NFErU09rQTZEd3FZQVdjSDFoNThsYmh3NnRVSWpnd2xoWXVjNjhxTUJFMGN2?=
 =?utf-8?B?cU02S1ZjTlYvOXFYR2lNN2dURlBEbEsrQ0c5ejBRd2huZ1B0RVZuVldwUHdF?=
 =?utf-8?B?UmR3bTVXN2NsTDQyczVkOVRIMWJxRGZNblVXcTJQYk1xbmZEbzNBUG1jeUJE?=
 =?utf-8?B?MjNNYTJWOUR6V1hXQlhPeURKRVduRUwrZnFubzB5YlU3akRsaW1odE83RzJL?=
 =?utf-8?B?SzltczZCQzEyb0lKcnU5dnQxeHp6SGUyVEJhTUUzWkIrYkVqRFhhNFFHcHZq?=
 =?utf-8?B?TjdVSXN4ZTVuTEltMTlTUEUrcHl5S2xDY2NRTzZ5SkVCS3haTXc5NGpNRldH?=
 =?utf-8?B?Y3RuZ0hvUk10azNSbU5XTmNWSFE5ZHRkNmNxa2hoM2RVRnZ3NGw4L3dtSDVJ?=
 =?utf-8?B?WVdRT0RIK0MyZkFQWW5rWERwWUdUVjYyd05WczVVaGltWlFlV0VxbmszQnI3?=
 =?utf-8?B?bU5EMG40OXdVNWxTOFR6dEtKSXgxVnNkRm5aMlJxZmhCMjJNUTNidEZOK3NL?=
 =?utf-8?B?bTlLMlVnZXVuaDJOZTdvdEsvTkN3V0lGcVlFOU5CYzhXVW5RMnRLSWhGdFhM?=
 =?utf-8?B?QmV0bC9ibU85eUdGZUNjSXBLQ0dTb0V4UFpoMk5hNFZFRFRZQUlLOTNkT29y?=
 =?utf-8?B?ZTdlTVZFbUZUUDZVWm4zN3g1MU9qVFc5ckY5YytEdFg1Ri9yai9wWkdQc1J1?=
 =?utf-8?B?UzUwYTFTUTZpbEdJeW4wQmVxMWcxMStFSi9LcnYzK25haE5sS3BTQ3RuSnhp?=
 =?utf-8?B?VzRmdHNDcFQ1M1l6N1U3TXp0VjVuYUdDVXYyaWNna1MxdHZyakFqQkwyeWty?=
 =?utf-8?B?SUtJb2VOdnZ2V0EybnFWVFNYNDdSQ01JUVhCZ1M5eXhmTmc5Z0J3RzJLQzds?=
 =?utf-8?B?MDZBYVVDbnNveTB4VjRCQzE4a2UxbEplakRwMVZEcVkxNEo2d2lucVdaTnFK?=
 =?utf-8?B?c3dWNTZqM3QxS1hpZ0FHZEJsUEh1cWFPQ3kyV0J2SWhpN0Z0MXc1V2p5cTE3?=
 =?utf-8?B?clNVSmY1WC84aG9TM21uWlpvNFcvZUdLaWJKVXY0MVFpOFJJc0RFb0hnYmFL?=
 =?utf-8?B?Vi8wU1A0azJOL2NqaDlwa2xOeUhRUHVsMmc3KzFlYmtESDRpcXQ3RjdGTWdU?=
 =?utf-8?B?Sk9SYnN4Z3E2OE11enR6Z0JQa3RXTlBBWU5obmR1M0pianJBODVMend1bDA3?=
 =?utf-8?B?eHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 404227fd-3a19-4d8b-95ce-08de2ecf29cb
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 22:40:42.8806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MNUYLG5eJdrkABjyFzeWvckacG0zBSfWQ6STz/aAKM2iJ1tY+rL1G8vG/MeW+0fEqrRz7ySUUJV/5KZsFh+7401Fpdeotph2yCEql4L6NVM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8371
X-OriginatorOrg: intel.com

Thanks for your feedback, Qu Wenruo.

On Sat, Nov 29, 2025 at 08:25:30AM +1030, Qu Wenruo wrote:
> 在 2025/11/29 05:35, Giovanni Cabiddu 写道:
> > Add support for hardware-accelerated compression using the acomp API in
> > the crypto framework, enabling offload of zlib and zstd compression to
> > hardware accelerators. Hardware offload reduces CPU load during
> > compression, improving performance.
> > 
> > The implementation follows a generic design that works with any acomp
> > implementation, though this enablement targets Intel QAT devices
> > (similarly to what done in EROFS).
> > 
> > Input folios are organized into a scatter-gather list and submitted to
> > the accelerator in a single asynchronous request. The calling thread
> > sleeps while the hardware performs compression, freeing the CPU for
> > other tasks.  Upon completion, the acomp callback wakes the thread to
> > continue processing.
> > 
> > Offload is supported for:
> >    - zlib: compression and decompression
> >    - zstd: compression only
> > 
> > Offload is only attempted when the data size exceeds a minimum threshold,
> > ensuring that small operations remain efficient by avoiding hardware setup
> > overhead. All required buffers are pre-allocated in the workspace to
> > eliminate allocations in the data path.
> > 
> > This feature maintains full compatibility with the existing BTRFS disk
> > format. Files compressed by hardware can be decompressed by software
> > implementations and vice versa.
> > 
> > The feature is wrapped in CONFIG_BTRFS_EXPERIMENTAL and can be enabled
> > at runtime via the sysfs parameter /sys/fs/btrfs/<UUID>/offload_compress.
> 
> Not an compression/crypto expert, thus just comment on the btrfs part.
> 
> sysfs is not a good long-term solution. Since it's already behind
> experiemental flags, you can just enable it unconditionally (with proper
> checks of-course).
The reason for introducing a sysfs attribute is to allow disabling the
feature to be able to unload the QAT driver or to assign a QAT device to
user space for example to QATlib or DPDK.

In the initial implementation, there was no sysfs switch because the
acomp tfm was allocated in the data path. With the current design,
where the tfm is allocated in the workspace, the driver remains
permanently in use.

Is there any other alternative to a sysfs attribute to dynamically
enable/disable this feature?

> 
> [...]
> > +int acomp_comp_folios(struct btrfs_acomp_workspace *acomp_ws,
> > +		      struct btrfs_fs_info *fs_info,
> > +		      struct address_space *mapping, u64 start, unsigned long len,
> > +		      struct folio **folios, unsigned long *out_folios,
> > +		      unsigned long *total_in, unsigned long *total_out, int level)
> > +{
> > +	struct scatterlist *out_sgl = NULL;
> > +	struct scatterlist *in_sgl = NULL;
> > +	const u64 orig_end = start + len;
> > +	struct crypto_acomp *tfm = NULL;
> > +	struct folio **in_folios = NULL;
> > +	unsigned int first_folio_offset;
> > +	unsigned int nr_dst_folios = 0;
> > +	struct folio *out_folio = NULL;
> > +	unsigned int nr_src_folios = 0;
> > +	struct acomp_req *req = NULL;
> > +	unsigned int nr_folios = 0;
> > +	unsigned int dst_size = 0;
> > +	unsigned int raw_attr_len;
> > +	unsigned int bytes_left;
> > +	unsigned int nofs_flags;
> > +	struct crypto_wait wait;
> > +	struct folio *in_folio;
> > +	unsigned int cur_len;
> > +	unsigned int i;
> > +	u64 cur_start;
> > +	u8 *raw_attr;
> > +	int ret;
> > +
> > +	if (!acomp_ws)
> > +		return -EOPNOTSUPP;
> > +
> > +	/* Check if offload is enabled and acquire reference */
> > +	if (!atomic_read(&fs_info->compress_offload_enabled))
> > +		return -EOPNOTSUPP;
> > +
> > +	if (!atomic_inc_not_zero(&fs_info->compr_resource_refcnt))
> > +		return -EOPNOTSUPP;
> > +
> > +	/* Protect against GFP_KERNEL allocations in crypto subsystem */
> > +	nofs_flags = memalloc_nofs_save();
> > +
> > +	in_folios = btrfs_acomp_get_folios(acomp_ws);
> > +	if (!in_folios) {
> > +		btrfs_err(fs_info, "No input folios in workspace\n");
> > +		ret = -EINVAL;
> > +		goto out;
> > +	}
> > +
> > +	cur_start = start;
> > +	while (cur_start < orig_end && nr_src_folios < BTRFS_ACOMP_MAX_SGL_ENTRIES) {
> 
> This function get all input/output folios in a batch, but ubifs, which also
> uses acomp for compression, seems to only compress one page one time
> (ubifs_compress_folio()).
> 
> I'm wondering what's preventing us from doing the existing folio-by-folio
> compression.
> Is the batch folio acquiring just for performance or something else?
There are a few reasons for using batch folio processing instead of
folio-by-folio compression:

* Performance: for a hardware accelerator like QAT, it is more efficient to
  process a larger chunk of data in a single request rather than issuing
  multiple small requests. (BTW, it would be even better if we could batch
  multiple requests and run them asynchronously!)

* API limitations: The current acomp interface is stateless. Supporting
  folio-by-folio compression with proper streaming would require changes
  to introduce a stateful API.

* Support for stateful compression in QAT: QAT would also need to implement
  stateful request handling to support incremental
  compression/decompression.

> 
> The folio-by-folio compression gives us more control on detecting
> incompressible data, which is now gone.
> We will only know if the data is incompressible after all dst folios are
> allocated and tried compression.
> 
> [...]
> > @@ -165,6 +216,20 @@ int zlib_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
> >   	const u32 blocksize = fs_info->sectorsize;
> >   	const u64 orig_end = start + len;
> > +#ifdef CONFIG_BTRFS_EXPERIMENTAL
> > +	if (workspace->acomp_ws && len >= 1024) {
> 
> The length threshold looks way smaller than I expected. I was expecting
> multi-page lengths like S390, considering all the batch folio preparations.
> 
> If the threshold is really this low, what's preventing an acomp interface to
> provide the same multi-shot compression/decompression?
Performance (i.e., latency) and support for stateful (see above points).

> And please do not use an immediate number, use a macro instead.
Sure.

> 
> [...]
> > @@ -418,6 +468,20 @@ int zstd_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
> >   	unsigned long max_out = nr_dest_folios * min_folio_size;
> >   	unsigned int cur_len;
> > +#ifdef CONFIG_BTRFS_EXPERIMENTAL
> > +	if (workspace->acomp_ws && len >= 2048) {
> 
> And why zstd has a different threshold compared to zlib?
These thresholds vary by algorithm, device, and compression level.
I tried to generalize them. For ZSTD on QAT GEN4, for example, QAT only
implements part of the algorithm. The remaining steps are handled in
software via the ZSTD library. This makes the offload threshold
different compared to zlib where the algorithm is completely executed in
HW.

That is why I asked in the cover letter whether it would make sense to
expose these thresholds through acomp. The concern is that I don’t want
to waste cycles converting folios to scatterlists only to discover that
software compression would have been more efficient.

Thanks,

-- 
Giovanni

