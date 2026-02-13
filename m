Return-Path: <linux-btrfs+bounces-21658-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BwyMrKHjmlyCwEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21658-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Feb 2026 03:08:50 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 456B11325DE
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Feb 2026 03:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A7AEC306BC9B
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Feb 2026 02:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD30225417;
	Fri, 13 Feb 2026 02:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dZBk9iZ8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9037C3BB5A
	for <linux-btrfs@vger.kernel.org>; Fri, 13 Feb 2026 02:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770948527; cv=fail; b=KVRoCmXfmXGW/+nOyL25RO/0gwdz1WZQN9QfNnqtIYxkmLiNsVAJkWixVZ1hO0rBV7FuxoPekWrKa4KLtM2oAAWKXP6SgAoYKn1jHvZ5mLn46msY/QwvGtY2OZ9l+i4Ly77ooIyJNKST/06J/7hMQrS5SCWEpWAyk+/Tv8k5mDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770948527; c=relaxed/simple;
	bh=jj7QZQktx8P9dV3YHu/Pl6sAk8AHITjhiCYu+44Iito=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sJDhHYWL24vEHIBHW19HxIroiVd5RoaZ8tcD4FN3Hz+MkpVKSeSMvDkE3dz1gTYlBNawiU6ijur/iUF6GAgUNZ1WzlfHJZ9Xdp2vOsyK4ENEinwFzx2umfcpS+YFAV+lcnJPEbdthXxWnFeAZ+s3opjBYVYvo6YwE74W3g8YbYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dZBk9iZ8; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770948525; x=1802484525;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=jj7QZQktx8P9dV3YHu/Pl6sAk8AHITjhiCYu+44Iito=;
  b=dZBk9iZ8mUChb84zsQ9mwx83OPLTvEi0cdxXBG1gqUi+/sMek+pUDwLb
   u0n0q97LAxekuCjsDkfe9i+fyjuuxE+Nmj5GFOEnkByZGgm2CdUSZpR0I
   H0ZKNCeB4sYUi4cVlmonzCS0mdR04gcP71ovwELsbFKSN2YxCRPX4UyLH
   7BzeTIAk5UlfwlZV5o3oFvrmvvSkZcL8N5fGoLcBDExhGuDuARpT5WX9p
   qGtFLUmlQrQHBHdCsSf6GuFXPppFSI3vh8uVXwuzx57Ccy9rWYIWJ8pb/
   T5tQJa6GF1hMf/IYF28SQ44XDTYyIck9HCvZwvEfS/DJ1RR+c0PQo6r8Y
   g==;
X-CSE-ConnectionGUID: J1uX0kLKS2ykCdL2kfG4Ag==
X-CSE-MsgGUID: gnn39WVcQ2qaP4Kp2kXhzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="72206530"
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="72206530"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 18:08:25 -0800
X-CSE-ConnectionGUID: KwHl5TpRR0qBLMBhJDcKUg==
X-CSE-MsgGUID: /2wVF4mnSbGBqYWyWRIpiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="217758995"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 18:08:26 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 18:08:24 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 12 Feb 2026 18:08:24 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.42) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 18:08:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KHkYrntY9b1kLoJOVLKHgncAx0jV4+MpCmVmfLlqiMriF7nM1dY/74JeH3540Gzi2Lcp1KxNGOVZnreayDOjg6dhir0GRhGoylHARRHLligQ2/YF99oRDh109FYe184cSXNX8F3cx1UZqagZ/OcMHFsyjla7Q3kzrManqHp8gDlYzDFeIwb0pQPDEZWFB1qjCY8z8ylHcDKIu/GIqs2nt09DUnzkNUx/TUmhZoqptAPiP2luXvqXRXqcM5+MonssS+/RB4gX4wp/w3RQeE3/jzfNspjr5WEwdkHJIIobxgRcVry/zoxgMWjZk4L4/Md3jBqMTXrOAVIxNG4Azr3/HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vB8Syje+iB4muENsX+tObEc7sPoXqzdLdUofQF9ouAY=;
 b=RbJsyblSiKuib9VDvd5cEpGKictCCiMDyKHcfefspyxrTSPN93kjyXQObnCCmocbb0z8zE+m0pxw5bHzpUI6Y97/j601jGXGbOytbeeOhm3V59ze4mlH1AL7MfAdR+JbbETcsdgdPVYHTNLla7bC1fJGtntSVPRSkFAmkLXQ8k7a7D7X9pFS203J9TBtvKTdMSXOojEWgxe5DeybM88zEyKtQMIWeTuvVu6RreQbYnDB31yNL+XCJwWdW+Sydd1SsG5sLmfVBNAIN9yskp3iR3CjwmE7LqBa6FCHaKfA500kfPxNPkz+Xx2syFefuvCzMtFmeuc6O/AAWHxZ3qENNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH8PR11MB7966.namprd11.prod.outlook.com (2603:10b6:510:25d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 13 Feb
 2026 02:08:17 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::e4de:b1d:5557:7257]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::e4de:b1d:5557:7257%5]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 02:08:17 +0000
Date: Fri, 13 Feb 2026 10:08:08 +0800
From: kernel test robot <oliver.sang@intel.com>
To: David Sterba <dsterba@suse.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-btrfs@vger.kernel.org>,
	David Sterba <dsterba@suse.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH] btrfs: sink RCU protection to _btrfs_printk()
Message-ID: <202602130950.db059ac8-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260205114546.210418-1-dsterba@suse.com>
X-ClientProxiedBy: SI1PR02CA0057.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::10) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH8PR11MB7966:EE_
X-MS-Office365-Filtering-Correlation-Id: ad582ace-4390-454c-aa3a-08de6aa4c02b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?j3WX7Fjn9dPsg3/kdlVkNz6xxCANCilmrjLgVRxIR9cTRXN7uluC8TJvtnaB?=
 =?us-ascii?Q?ga9RTcbqyjHQXFs2+yuNdOZ8pR3SIXPU3p2OvN0HEjBnGjTlvVQ6I+JMNhSt?=
 =?us-ascii?Q?5Z2B65QwMEyksKGs83z9b1UcMTK+12EVCT1qxCqBKPeVQWnYLOvxdAL1c+dc?=
 =?us-ascii?Q?MDLmkwsxbI34cAQvw+jQaub5xZi/rb9pH/mu0Gfufmr6iliyMxHESFQmtYCQ?=
 =?us-ascii?Q?xRRPCch6JDv2hHjyn8yxrSgzG6DVoUGvpjBUpEzX8NQMW6NmzlmV4re6ThrP?=
 =?us-ascii?Q?ixEUEJqcx/rp8H51xogpZN5hFOJ0H12vS/o3x1BUYUnhyn9iR3Eo7f9NDjga?=
 =?us-ascii?Q?AMoE9YE1fWQ3k80HmkeS2peJCanAUGPeUGYS4t91sdR7QU33Usi1m8+yM+P5?=
 =?us-ascii?Q?CzV8rx1/RJNp8B5lwq2gkOlIT2scnnfW6B133LnUm8iNBBlCq6w1mlCwQdT+?=
 =?us-ascii?Q?4RUZVWKAGo0cYlIGEgdG4+Lxwen2XPliBev8hlrDUBYuznKQfX17DAFQ5v/q?=
 =?us-ascii?Q?WXG6NgDZLW58hfSg3wufDDwSNqcoXHaxzy++Cdlu6tcPKQo84OZjATyFa4DZ?=
 =?us-ascii?Q?jOIoQLz8hZCu6ywH5nXTknbyUGtQRF0k/aSuhXcdhqt0M35MnCOJb/eeG5CY?=
 =?us-ascii?Q?DmDaT3UFnRy2+St8Nm6ukU08Zawz3pO+HHfU2BasFwbxqL0dnLpIwIemkor4?=
 =?us-ascii?Q?eRASc3onktCrcrvyVYNyPZvL+dQOpefoKnIzSKnFIfDvWpCqW6kHrwbM/sUg?=
 =?us-ascii?Q?azm0kTFc/pxPti+WXguUu3tKfNiiooXp0/sUDbLJbfuWXbL9qOLKBe6hz96m?=
 =?us-ascii?Q?vtBCI31gjwc2wQza7SvVOchFxiS11eGxMu+ArKNLCvlcbGcbX1R175uAkNBE?=
 =?us-ascii?Q?3V/lJ0tKRdQRQBanm/EQsPeT49ggfCBEr7ApQ3BnNz3fuscZ0HoVPswRBRao?=
 =?us-ascii?Q?Ts4wAT/fN6+LUPF0Bu2L3AVn2cr6sYVzB/iQVfb93NvQ8lQrXkQQbk7e5KkS?=
 =?us-ascii?Q?MTSUuFlYyh2o60K7YZlDSBLNDy+3YvXn5Fp8vaeZGdalIvtkOPfn2QlaiLH5?=
 =?us-ascii?Q?GfLSGO5R3FKXN9ubLiMiXjDmR8A+pewcQ4iWl9gRX3gQikFxcqW27KrhWvh7?=
 =?us-ascii?Q?3RcMyAMChaZz0t2h+yRWrpkD53h0tybje4iyo6YYYaXPWeaxOTnZpBVSqpQk?=
 =?us-ascii?Q?iSyuqr0av9ZWg5/p0wHoYISrpgcmRpu1IAF4I8vNTsGzkYN1kw7RkfLmDG4c?=
 =?us-ascii?Q?535EHvKsaI0ZS0gy/raVk2Nc9NYjCzQHx1aEs/ORVNSF2kj1ZtydyZOAs2bW?=
 =?us-ascii?Q?ke2TUKYfATFwlmsDTNR3BhafRFYzlVoggA99kuEhOMp7LexrsF1y2xl9ckSs?=
 =?us-ascii?Q?8WbsEVrdHIRv8eOKtvj7HfHM1AXbzVf2nhiFBE6dp5Vb8ndbiyZTzIsEQhFK?=
 =?us-ascii?Q?A8Lgs20MfUHrN50lxvFW1hsisFf+jA3THkxm6roh0GSssHQRhF5j2BiExDXt?=
 =?us-ascii?Q?wqPHFmK3Z1dAcEMDhrMQe/LC6mnEU6god+6m+zzaqNk6n2lPEKJi10FzbuGI?=
 =?us-ascii?Q?TOuGRZlyqxCa+AYx1eUUYo9102lG9R+eR1fFxyUN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3HYvKLcMkIY94HxwA40eHliohfHfVu+qvYP5PJqxTQfDU5cDPX8zJ0WWJPNI?=
 =?us-ascii?Q?/F28fNGyzcQycVlXEdzyjQduS2IcwQfgfaOClJ/jR69kXHwmASQ2CfctHZ4Y?=
 =?us-ascii?Q?mViUdwlfrNy5pPb4UiFAdP2SRmX63LGRS/ebL6C/TtlgzF3JXr74up5DfELi?=
 =?us-ascii?Q?cQF01rgpYYmUDmgkvjF3hpUK+juq9rvBYB19kpE38R6QjcFtTifH/C6NCfsM?=
 =?us-ascii?Q?DivuTHScv8wQ6I0cB4Gyr07xjMJ/0/0xm32NR/7aCnRRRYgil9huZkDovx5A?=
 =?us-ascii?Q?EeRO2K2G4S8rzyOF8GwIoxaqsP/NUBYK6v4uqOlYN6wxe7D1XdkhzGdk5kng?=
 =?us-ascii?Q?2mJOpGcnJ5e896k19S62NHNCIC3ED2CGRmkGNdtPJHl3ScBH4yToLDCWyAFQ?=
 =?us-ascii?Q?qHSuJQ1RzRMegs/A40fUCbiPFgpikfA2K0kicEywxBtw/Yei2F6CCdSABm3d?=
 =?us-ascii?Q?1aEby+FdZzX5RYgrH7IlGp202yRhy2nkrRU5qPzYu+nxZS7JZwJha5XaMwbv?=
 =?us-ascii?Q?qqvwNlle2Yn4S4u2bYbCErSJ3GWVfRnEUAmJsTCXr+2g3lFUig27R2tZRdgv?=
 =?us-ascii?Q?RU+XE8RUPnWr/17ClBaLvaLdlTGyqjg64TQqsTZDTHOZhptiqNjE5VMgvXFd?=
 =?us-ascii?Q?bPf3IiNSYEUoONs4SjB0v0N2DIGlkTga4Xn/rcm9n5V/OZWsy58SBzGocPOz?=
 =?us-ascii?Q?Q3krKDbCBzPAVaZm9ftPsHD2QGcJzft/uS+QClCdUmfUMD4sdpT7jQgcA+mI?=
 =?us-ascii?Q?FOnvxEuE7mb5kSgd5WfLMwHqnz+1eM3VPFN5oxiKXuPpnEE9eHQaNBU97/jo?=
 =?us-ascii?Q?dQ2fPdekt3EmBcQZWLuR3ojdX+sQG5S7J6u3RA8SErrRUHFgVM2McDxkZ0fk?=
 =?us-ascii?Q?8V9gxSVhovP7pJPKkiwSh2KCsZSSfoRx9NaLgcbO3h1wxPjr9pR0/G+Lodvk?=
 =?us-ascii?Q?yeiyCIY+B4rIaqPLq0uG2ZgBvOhxvZcpXkngMg4ij3CgX11prP3z1gWMNG0r?=
 =?us-ascii?Q?2TgKaAmaXBnKbwHK1WRrVBQfgqLsdNK+ra30yK7yUeHH82aZeP9YrfUCH47e?=
 =?us-ascii?Q?md6gVL5B0Y9ANfL0KQ1ZtHJu5tiYc8ybG+1NC/cd7AIS2JegbtBD+lQ/WTe3?=
 =?us-ascii?Q?fqFOx3Y6I/yMA9ggNr3tNX+nAWCI4c/PNN4S02HeIjbs/PDiiTWk6qUoCHw8?=
 =?us-ascii?Q?VA3a+uXY9mGRUugClJRfri58aYOS+kU860GBFzqqWeyg8ETasKX2uprMIeq5?=
 =?us-ascii?Q?utF2WeOigRyPcZQ47D+3oHdEFruFOh0CbByaLDU6OgFYVRz2qmycuu8OLiWu?=
 =?us-ascii?Q?zN6x7YPb6H5l/BRi+6rju5iqgqsq6vLlj4dJ+/WA+mG7C+oTsFEWdL1FOo9/?=
 =?us-ascii?Q?FAWzboh+NLBxmTSKWHNOYEG9myp40meaQdneIo2DWoHwg2q5aUhvuZWDk7Et?=
 =?us-ascii?Q?2oqgYaloH9aoFkIFESh6CcoKKJP9ib+tZMV9kTlpki3kOzlgxGRzUY/ZWzie?=
 =?us-ascii?Q?e1FW5qb7rpm9NVn+rNQ3u8E06ah1P6t/owML2J4GxoRgrzO063wPUGjguTYZ?=
 =?us-ascii?Q?H3ejJ9XFYjZ7Y+QAHog4m2EjGDzwJIO9cVUwFZto706X4T8me2EA2EnP68WS?=
 =?us-ascii?Q?B+8o5EeszIRpGbtFWKbwoHygwtSL4xp2cTHo46UZ2+kGuyVM25KQd33hOD5d?=
 =?us-ascii?Q?XoTI5t37mf5Hm+BnTBO5A9AKmeyIxIZ9uHg8rn7TDJ/CFlcCNvKZpwSQoFyk?=
 =?us-ascii?Q?s+ViR3Bv+A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ad582ace-4390-454c-aa3a-08de6aa4c02b
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 02:08:16.8770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q7ihoeKv1EaSYrBKY2ZlYAMaJAi9TI3gGKKSTLAjJGI+DnwXjZIlCMdlFQjI1lxcGweBaf4Qw/PFPiHumngatw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7966
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[oliver.sang@intel.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-21658-lists,linux-btrfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+]
X-Rspamd-Queue-Id: 456B11325DE
X-Rspamd-Action: no action



Hello,

kernel test robot noticed "WARNING:suspicious_RCU_usage" on:

commit: a7bc95298723a9c79cc429adfb7dc1f37ff55a8d ("[PATCH] btrfs: sink RCU protection to _btrfs_printk()")
url: https://github.com/intel-lab-lkp/linux/commits/David-Sterba/btrfs-sink-RCU-protection-to-_btrfs_printk/20260205-194735
base: https://git.kernel.org/cgit/linux/kernel/git/kdave/linux.git for-next
patch link: https://lore.kernel.org/all/20260205114546.210418-1-dsterba@suse.com/
patch subject: [PATCH] btrfs: sink RCU protection to _btrfs_printk()

in testcase: perf-sanity-tests
version: 
with following parameters:

	perf_compiler: clang
	group: group-02



config: x86_64-rhel-9.4-bpf
compiler: gcc-14
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202602130950.db059ac8-lkp@intel.com



kern  :warn  : [  282.723760] [   T5053] WARNING: suspicious RCU usage
kern  :warn  : [  282.723764] [   T5053] 6.19.0-rc8-00144-ga7bc95298723 #1 Tainted: G S
kern  :warn  : [  282.723768] [   T5053] -----------------------------
kern  :warn  : [  282.723769] [   T5053] fs/btrfs/volumes.h:856 suspicious rcu_dereference_check() usage!
kern  :warn  : [  282.723773] [   T5053]
other info that might help us debug this:

kern  :warn  : [  282.723775] [   T5053]
rcu_scheduler_active = 2, debug_locks = 1
kern  :warn  : [  282.723778] [   T5053] 4 locks held by mount/5053:
kern  :warn  : [  282.723780] [   T5053]  #0: ff1100058fa07c70 (&fc->uapi_mutex){+.+.}-{4:4}, at: __do_sys_fsconfig (fs/fsopen.c:472)

kern  :warn  : [  282.733684] [   T5053]  #1: ff1100080763a0e0 (&type->s_umount_key#45
user  :notice: [  282.739077] [    T979]   File "/usr/bin/py3clean", line 209, in <module>
kern  :warn  : [  282.746062] [   T5053] /1

kern  :warn  : [  282.758521] [   T5053] ){+.+.}-{4:4}, at: alloc_super (fs/super.c:346)
user  :notice: [  282.768758] [    T979]     main()
kern  :warn  : [  282.776531] [   T5053]  #2: ff110005cb3fb8d8 (&fs_devs->device_list_mutex){+.+.}-{4:4}

kern  :warn  : [  282.790726] [   T5053] , at: btrfs_init_dev_stats (fs/btrfs/volumes.c:7975) btrfs
user  :notice: [  282.793082] [    T979]     ~~~~^^
kern  :warn  : [  282.799023] [   T5053]  #3:

kern  :warn  : [  282.807834] [   T5053] ff1100019d555d18 (btrfs-dev-00
user  :notice: [  282.810637] [    T979]   File "/usr/bin/py3clean", line 195, in main
kern  :warn  : [  282.815878] [   T5053] ){.+.+}-{4:4}, at: btrfs_tree_read_lock_nested (arch/x86/include/asm/jump_label.h:37 include/trace/events/btrfs.h:2293 fs/btrfs/locking.c:147) btrfs

kern  :warn  : [  282.826610] [   T5053]
stack backtrace:
kern  :warn  : [  282.826616] [   T5053] CPU: 9 UID: 0 PID: 5053 Comm: mount Tainted: G S                  6.19.0-rc8-00144-ga7bc95298723 #1 PREEMPT(full)
kern  :warn  : [  282.826622] [   T5053] Tainted: [S]=CPU_OUT_OF_SPEC
kern  :warn  : [  282.826624] [   T5053] Hardware name: Inspur NF5180M6/NF5180M6, BIOS 06.00.04 04/12/2022
kern  :warn  : [  282.826626] [   T5053] Call Trace:
kern  :warn  : [  282.826630] [   T5053]  <TASK>
kern  :warn  : [  282.826632] [   T5053]  dump_stack_lvl (lib/dump_stack.c:122)
kern  :warn  : [  282.826640] [   T5053]  lockdep_rcu_suspicious.cold (kernel/locking/lockdep.c:6877)
kern  :warn  : [  282.826648] [   T5053] btrfs_dev_name (fs/btrfs/volumes.h:856 (discriminator 9) fs/btrfs/volumes.h:851 (discriminator 9)) btrfs
kern  :warn  : [  282.826845] [   T5053] btrfs_device_init_dev_stats (fs/btrfs/volumes.c:8119 (discriminator 6) fs/btrfs/volumes.c:7957 (discriminator 6)) btrfs
kern  :warn  : [  282.827048] [   T5053]  ? __pfx_btrfs_device_init_dev_stats (fs/btrfs/volumes.c:7921) btrfs
kern  :warn  : [  282.827256] [   T5053]  ? kasan_save_track (mm/kasan/common.c:70 (discriminator 1) mm/kasan/common.c:79 (discriminator 1))
kern  :warn  : [  282.827262] [   T5053]  ? __kasan_slab_alloc (mm/kasan/common.c:340 mm/kasan/common.c:366)
kern  :warn  : [  282.827267] [   T5053]  ? __rcu_read_lock (kernel/rcu/tree_plugin.h:416 (discriminator 2))
kern  :warn  : [  282.827273] [   T5053]  ? kmem_cache_alloc_noprof (include/trace/events/kmem.h:12 (discriminator 2) mm/slub.c:5273 (discriminator 2))
kern  :warn  : [  282.827280] [   T5053]  ? btrfs_init_dev_stats (fs/btrfs/volumes.c:7970) btrfs
kern  :warn  : [  282.827494] [   T5053] btrfs_init_dev_stats (fs/btrfs/volumes.c:7977) btrfs
kern  :warn  : [  282.827707] [   T5053] open_ctree (fs/btrfs/disk-io.c:3546) btrfs
kern  :warn  : [  282.827910] [   T5053] btrfs_get_tree_super.cold (fs/btrfs/super.c:982 fs/btrfs/super.c:1944) btrfs
kern  :warn  : [  282.828112] [   T5053] btrfs_get_tree_subvol (fs/btrfs/super.c:2087) btrfs
kern  :warn  : [  282.828315] [   T5053]  vfs_get_tree (fs/super.c:1751)
kern  :warn  : [  282.828322] [   T5053]  vfs_cmd_create (fs/fsopen.c:231)
kern  :warn  : [  282.828328] [   T5053]  __do_sys_fsconfig (fs/fsopen.c:474)
kern  :warn  : [  282.828333] [   T5053]  ? __pfx___do_sys_fsconfig (fs/fsopen.c:356)
kern  :warn  : [  282.828337] [   T5053]  ? do_faccessat (fs/open.c:530)
kern  :warn  : [  282.828345] [   T5053]  ? __pfx_do_faccessat (fs/open.c:465)
kern  :warn  : [  282.828352] [   T5053]  ? do_syscall_64 (arch/x86/include/asm/irqflags.h:42 arch/x86/include/asm/irqflags.h:119 include/linux/entry-common.h:108 arch/x86/entry/syscall_64.c:90)
kern  :warn  : [  282.828360] [   T5053]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 (discriminator 1) arch/x86/entry/syscall_64.c:94 (discriminator 1))
kern  :warn  : [  282.828364] [   T5053]  ? do_syscall_64 (include/linux/irq-entry-common.h:298 include/linux/entry-common.h:196 arch/x86/entry/syscall_64.c:100)
kern  :warn  : [  282.828371] [   T5053]  ? do_syscall_64 (arch/x86/entry/syscall_64.c:113)
kern  :warn  : [  282.828376] [   T5053]  ? do_syscall_64 (include/linux/irq-entry-common.h:298 include/linux/entry-common.h:196 arch/x86/entry/syscall_64.c:100)
kern  :warn  : [  282.828382] [   T5053]  ? do_syscall_64 (arch/x86/entry/syscall_64.c:113)
kern  :warn  : [  282.828386] [   T5053]  ? __pfx_from_kgid_munged (kernel/user_namespace.c:534)
kern  :warn  : [  282.828392] [   T5053]  ? do_syscall_64 (include/linux/irq-entry-common.h:298 include/linux/entry-common.h:196 arch/x86/entry/syscall_64.c:100)
kern  :warn  : [  282.828396] [   T5053]  ? do_syscall_64 (include/linux/irq-entry-common.h:298 include/linux/entry-common.h:196 arch/x86/entry/syscall_64.c:100)
kern  :warn  : [  282.828402] [   T5053]  ? do_syscall_64 (arch/x86/entry/syscall_64.c:113)
kern  :warn  : [  282.828406] [   T5053]  ? do_syscall_64 (arch/x86/entry/syscall_64.c:113)
kern  :warn  : [  282.828409] [   T5053]  ? do_syscall_64 (include/linux/irq-entry-common.h:298 include/linux/entry-common.h:196 arch/x86/entry/syscall_64.c:100)
kern  :warn  : [  282.828415] [   T5053]  ? do_syscall_64 (arch/x86/entry/syscall_64.c:113)
kern  :warn  : [  282.828418] [   T5053]  ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4629 (discriminator 4))
kern  :warn  : [  282.828423] [   T5053]  ? clear_bhb_loop (arch/x86/entry/entry_64.S:1549)
kern  :warn  : [  282.828430] [   T5053]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:131)
kern  :warn  : [  282.828434] [   T5053] RIP: 0033:0x7f5027d8b4aa
kern  :warn  : [  282.828458] [   T5053] Code: 73 01 c3 48 8b 0d 4e 59 0d 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 af 01 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 1e 59 0d 00 f7 d8 64 89 01 48
All code
========
   0:	73 01                	jae    0x3
   2:	c3                   	ret
   3:	48 8b 0d 4e 59 0d 00 	mov    0xd594e(%rip),%rcx        # 0xd5958
   a:	f7 d8                	neg    %eax
   c:	64 89 01             	mov    %eax,%fs:(%rcx)
   f:	48 83 c8 ff          	or     $0xffffffffffffffff,%rax
  13:	c3                   	ret
  14:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  1b:	00 00 00 
  1e:	66 90                	xchg   %ax,%ax
  20:	49 89 ca             	mov    %rcx,%r10
  23:	b8 af 01 00 00       	mov    $0x1af,%eax
  28:	0f 05                	syscall
  2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- trapping instruction
  30:	73 01                	jae    0x33
  32:	c3                   	ret
  33:	48 8b 0d 1e 59 0d 00 	mov    0xd591e(%rip),%rcx        # 0xd5958
  3a:	f7 d8                	neg    %eax
  3c:	64 89 01             	mov    %eax,%fs:(%rcx)
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
   6:	73 01                	jae    0x9
   8:	c3                   	ret
   9:	48 8b 0d 1e 59 0d 00 	mov    0xd591e(%rip),%rcx        # 0xd592e
  10:	f7 d8                	neg    %eax
  12:	64 89 01             	mov    %eax,%fs:(%rcx)
  15:	48                   	rex.W
kern  :warn  : [  282.828462] [   T5053] RSP: 002b:00007ffde3afb828 EFLAGS: 00000246 ORIG_RAX: 00000000000001af
kern  :warn  : [  282.828466] [   T5053] RAX: ffffffffffffffda RBX: 0000561df73281d0 RCX: 00007f5027d8b4aa
kern  :warn  : [  282.828469] [   T5053] RDX: 0000000000000000 RSI: 0000000000000006 RDI: 0000000000000003
kern  :warn  : [  282.828472] [   T5053] RBP: 0000561df7329ca0 R08: 0000000000000000 R09: 0000000000000000
kern  :warn  : [  282.828474] [   T5053] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
kern  :warn  : [  282.828476] [   T5053] R13: 00007f5027f1d580 R14: 00007f5027f1f26c R15: 00007f5027f04a23
kern  :warn  : [  282.828490] [   T5053]  </TASK>
kern  :info  : [  282.828501] [   T5053] BTRFS info (device nvme0n1p4): bdev /dev/nvme0n1p4 errs: wr 0, rd 0, flush 0, corrupt 3073, gen 0
user  :notice: [  282.829495] [    T979]     pfiles = set(dpf.from_package(options.package))
kern  :info  : [  282.868038] [   T5053] BTRFS info (device nvme0n1p4): enabling ssd optimizations

kern  :info  : [  282.871066] [   T5053] BTRFS info (device nvme0n1p4): turning on async discard
kern  :info  : [  282.871071] [   T5053] BTRFS info (device nvme0n1p4): enabling disk space caching



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260213/202602130950.db059ac8-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


