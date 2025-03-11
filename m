Return-Path: <linux-btrfs+bounces-12183-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BA7A5BC78
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Mar 2025 10:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16C9B3B2984
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Mar 2025 09:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94E622D4FE;
	Tue, 11 Mar 2025 09:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CqHhXSSb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173ED22F3B1
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Mar 2025 09:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741686093; cv=fail; b=cArtuhRl1dFYsn/K0joshLJWGY8WC7kkrilpmfpKd5To/2PI6wZOmGiYuuNHnOBSW15Lxytx2bx8Xv6ik27jLZdXCKrDsrp/8hAUY1KMjmRLI+Gob4vR3LAC/mM1RPaNEg5WqTvJsEhXQ+SImtV1UiqlrFn+b8hazzubDsv3Caw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741686093; c=relaxed/simple;
	bh=AYFmW/+3eHZRz9Hyr7joH4/Vld9QRftS2M+wMI2HmjQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GtKquREzolxQXoSRKGvorDjJivIlS9HQLcTMfnhdEoW8VY7vgvt1XICa/icETwlXL6tgjOEPIGscou2mxkOL1kmTJUia4x2bTCUqi49sCxH4AyhCo2ukp+4GpDd4VTI9yVa5cH+cFgyI/fKMWywX2qbQUIeaqSWObV0TaTYfEO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CqHhXSSb; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741686091; x=1773222091;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=AYFmW/+3eHZRz9Hyr7joH4/Vld9QRftS2M+wMI2HmjQ=;
  b=CqHhXSSb0rbifNetESDO6IzNdvNbFPQohigrsq3vYuuelHJRHN1yklnn
   WNJJKW8pvp/3TSrjFgAs5dN7tZ2GIA0CDuEUS7ScMCkO+7EjELvCh65Sc
   +Acnpe3C8hwmeo2IZGpii6AvtzdTlU4W9rqgocKL9ybgoLaEmHa0dzl/y
   8x6brWBE+2MIln4OlS9zi3t9wPQI2LAr7s7R08N4+S+eUtYgj9uSXd54w
   KeAfJK8LGyBWTP5su62/GIPQMcFGrLrCdpdpdBKnCqTgbqJjnxaVSmR4+
   UtT2h5fvoFnhO4Ojn48Epz05kmy3nJ0hALdEuGQrmFMr7iDvgk+Vj38VN
   g==;
X-CSE-ConnectionGUID: /dhVuejJQoKkpuI+tg3ceQ==
X-CSE-MsgGUID: z25R/Co2SAWm0IdTDOdBBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="42433566"
X-IronPort-AV: E=Sophos;i="6.14,238,1736841600"; 
   d="scan'208";a="42433566"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 02:41:30 -0700
X-CSE-ConnectionGUID: StJcvHzLRfOcAAkbkvImPg==
X-CSE-MsgGUID: 3V6kKKtlSsqzgS1S2GBE0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,238,1736841600"; 
   d="scan'208";a="143463572"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Mar 2025 02:41:29 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 11 Mar 2025 02:41:29 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 11 Mar 2025 02:41:29 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 11 Mar 2025 02:41:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wVbExCRIVTZuk5GV7WZa9IhmYdgyvzZENmQ25jsu4zlWfN/fo8y6adB5LPsyWiGjU5FAJanOom3FyHtPleMYDT/T6D9Zue+TTnMtA0AFNlqGULztdoBJYwArHvQ8PiHSbCFhp3ZVQm5AgiBTNTQSxpTWiTg9nrBHMHpVxBGFlWeg1tuL21bbSoM3aChkLa5jZeNei5ZBe5khIsLUXJruSIDm3LANvOhirDpTEHKVInMm+SjLbaNrjRS093AtJtC19+jfVzg+AqR1lYwaBa/hwJRA/ZjD05KMeaou22F7RbndlaAJ3xrwBZveH26QRb6v6m+XYBmgW7lVDlueba+Ivg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oOR+3ZhF0Boubf2GThWxq+VNtt3kOrF4Gp7pburoN1M=;
 b=IAXrl1ShWyJC4h/62gdfAr5A1BHjD627EWj8MEQO2yOJEDdxb+vIfwYh6W99UOymtELmlPaK3KjAZJyX1CdulhqNMoxyl82s2bhaZXHCZEllSNf5CPwIOFH6onSJ7IFKELYBYcIe6UR963UUK7kVfmqL+5V5y+Fmcjq8YYLeyzi5VIK8c0nejAq1lj9bNxIjSn5FjD3k0O8gN23HCkPulPZqkUbpfVzsmqnXB4OPR+C6fSeXC0i6mk5+ERKpAGKSyTebDM/zY5h0kNQwuoDybAKQ/QTHg+kH2FM6bzmih2UhQFz67pqRN3WvehA3zD+r4e8F7sBxf0lmjRWUZCo3oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
 by CYYPR11MB8408.namprd11.prod.outlook.com (2603:10b6:930:b9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 09:40:45 +0000
Received: from DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e]) by DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e%6]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 09:40:45 +0000
Date: Tue, 11 Mar 2025 17:40:37 +0800
From: Philip Li <philip.li@intel.com>
To: Filipe Manana <fdmanana@kernel.org>
CC: kernel test robot <lkp@intel.com>, <linux-btrfs@vger.kernel.org>,
	<oe-kbuild-all@lists.linux.dev>
Subject: Re: [PATCH 4/8] btrfs: make btrfs_iget() return a btrfs inode instead
Message-ID: <Z9AFFQsxmn1jdO9d@rli9-mobl>
References: <f6d2a09fb43742fb5be38f820908510e298f8d40.1741354479.git.fdmanana@suse.com>
 <202503082341.T7dnq95G-lkp@intel.com>
 <CAL3q7H4kad4ojST6ejTQqWMzr-J5ikVb=OABConGjXUHKrV6FQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H4kad4ojST6ejTQqWMzr-J5ikVb=OABConGjXUHKrV6FQ@mail.gmail.com>
X-ClientProxiedBy: SG2PR04CA0159.apcprd04.prod.outlook.com (2603:1096:4::21)
 To DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5423:EE_|CYYPR11MB8408:EE_
X-MS-Office365-Filtering-Correlation-Id: 658a5b81-86b0-43fe-b947-08dd6080cc2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cEVodDFHZ0diMWZaUUNjSS9uaktMWmZmak1nbjJCTVJGNXZsSHhWaStYMkFS?=
 =?utf-8?B?RnZEMUJxSTUrcURQYnhEQTN6NmdIcmhjRTVtMit5QlRzbkFNZlA5aVg1YU5j?=
 =?utf-8?B?NUNPdFNIeTFKWXVwdHAvSkVpKytVcWE3aXNLcS91YTdLVjRURTNuN2JtMjdX?=
 =?utf-8?B?d3lSM2tOQXZQUFh0aGN4L0M4TWR5YUVtVGlpYktMamIweE1zYW9CMTBmRkJj?=
 =?utf-8?B?Q0oxYU1kUVg2bmkvKzhzbVdoaXVrVXBId0lNOXFLVVFFbzkrcWd3Zmo5bzJu?=
 =?utf-8?B?K2dIY1JDdEtDL0lXMy9zOUVLWTUxcWdkV2JFKzkvaFZjd2Q3d1dHTXNPNnpO?=
 =?utf-8?B?SEVPSUpHS3hwOU5iS2lNZjdTN25Jd0dYamZqNE5JYUxobWcxbHBYQkVjb2hQ?=
 =?utf-8?B?aWVBM0Z2ekpYbGpIRWVlUVFEOVl5REZkVGI3bU16YXhKd3NqNEZpQkRIazZ1?=
 =?utf-8?B?UTRTWkFhU3BkYTdGZ1FVU1ZxQnQxSFBZNlNoS1liN2VENU5meEQvc3M2TjE2?=
 =?utf-8?B?c3llRlFDbjN2cEVSNFVWNG50NFZtSW5hdkVPaWxyQ1orMi9QaFRyWXNDd2FK?=
 =?utf-8?B?TkxPMFRoWktHRGdCYkJPSS8xdjFtYklTT3J2cEY3Z25Hb1BRbGxidlVlUit6?=
 =?utf-8?B?K2MxdW9UN1pyU0tGME1RV2lBc3JMT1JYR0RuR2RtQk8rcGFlMkxzZCtjNGds?=
 =?utf-8?B?U09uaWlza1haWDkrZVBvTjEyeG1JaEtRazY3WGdISnAvNEN4aVBrZDF4RzJL?=
 =?utf-8?B?MU9PQ2dLMjNGdVpQUmF6WVhCLzdGYnNXaUxWL2pkUGpPMXhCekNwOXpwVmNU?=
 =?utf-8?B?KzJNQTVIMTZZRGNUa0NGYlJzMmxiMWNVNkVDQnIwNjlhdWZkRkZ5STRsckJt?=
 =?utf-8?B?SnBYTDZOWTZYYThBYk1jeHdndjMwTW9CWVBLcit4OVNNYkRTSjdWeEo4dEl1?=
 =?utf-8?B?Zys4aTVCTUk3amEyTjlIdlNRMFV6QjdiR2dES0ZxMFZ0ZzdRUjVxTStNeUVa?=
 =?utf-8?B?RkJzdHJFUjVIVTl3RndtbDltOXpWNnpuWCs4cDUrbmhoODBtbnM3VUxGdG5w?=
 =?utf-8?B?b01ncm1BbzNYWFJzV2tZSmdacm5zdjQxc3EydjErdEtKTGZMQURJME56YjNY?=
 =?utf-8?B?Ti9xR2ErVC80Z1QxRUQ5S1MvR21RR3VLNCtWeTJubiswZ0N1Q3dBcDFQZTdo?=
 =?utf-8?B?b3pwMUVhcW5pbW5BS0dHc09uTDNvTzhRZjNEcDhUelErRlVPbU1SMUJwZFNP?=
 =?utf-8?B?TWdJcTVSN0RpdDhwSzhFempDelFUQTA0QmhFc1hNZzIyZFVMWUF3bStEOHdU?=
 =?utf-8?B?MVhyUFdWQXVjOFRva2dNRmVDTkZoOERzUlFBR05YelFxRVdPcGlvZW4yWlZ6?=
 =?utf-8?B?d25YY1d4U1NwdmFkZzVmWEh2T2RrcDFlNlhhZW1OU1YwL1FNd1ZJdjZGYnY3?=
 =?utf-8?B?TmIxRktaT3YxN1FDVCtFZWJTKzBzeEl1aytKWDFDN1JoNEZEVTgxMGlNWTlr?=
 =?utf-8?B?RThmT2c0Q1FVYXVDVWxFTU83NkZJNHJvcHlrRG5jc2FiVUpwYlZ2OHZ0V2xP?=
 =?utf-8?B?ekdKcHpPeWZPTmdySlo4d1lIQ1BBTzVNMXcxTGFJUnNxb2RRLzJOcUh0Rktk?=
 =?utf-8?B?ZmpjMWNaU1p3b0E5dklhRis2TDJ5WWFUOFZvWFZ3bGN1N3FJMU4rRFRlUjBS?=
 =?utf-8?B?d0UzU3ArRUc5MWlyV3MxVEtJdUNNeDFCSzlWQjI4dDFXdEJUaTlFVjVIYk1s?=
 =?utf-8?B?U0d3UWNNdmk0TTNlb0doVDFQODk2cWxxQzlhZTAyOGRzb2F2c2N2QzRxbzVS?=
 =?utf-8?B?T0o3ZlI1Yk10S2JrVll3QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5423.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODFvcmVJcHAyV3lFVFE3N0VPSnoxdWE2alpxREcyRTJIdjZLd1BEU2Yzd0s0?=
 =?utf-8?B?cVhWZHNaRXpVZ081NDdZbTZ1S0pyR2NFb3JYWkVhQVg5b2h3UUxCZ3IzS05Y?=
 =?utf-8?B?VDhadzJ1ZXFBS1V5VWNJNlhzR05NQlcxTW9IUFBMVXRCbFR0OFhGdWw5Wkds?=
 =?utf-8?B?UUtPQ2dyQVhMcnFJMllwbk50cnpxc2RhK0V6T1ZoQW1wQlpFanVPL3BSalg4?=
 =?utf-8?B?U3ZWRHBaSWp6bXBrWUhZOXhFR0pwNmx6dmhaQ2pZc1ByQXZQN2lMdUN1L1ZF?=
 =?utf-8?B?Z29hU3JmcEZpZEFiSktQMS9xUDdubEpJUDhjeWhzVktvUlZCYUg0TU9QM3Yr?=
 =?utf-8?B?WFRDUXN5eDZpcE0yT2tCeWJxK0lLVm1lZjVXRWlzR3VaajFOQjJGU0FZMzFs?=
 =?utf-8?B?UjczNjVreW1rZGFid09vQ2dMT3h2UEFDMHBtV2tQakdtWE8wNk5MWHF1b045?=
 =?utf-8?B?RDhYSDkySnQ4R1BabjdoZTZXZGVlYXM4M3FiQ0I3bEhIbFlKN3pBdVp0bFlt?=
 =?utf-8?B?bVFCVG95Slpjczk0TGFuN0x6RnNDRjE3cGN3Q3pkQ0pHalRTWnpmbm0vMzlw?=
 =?utf-8?B?aGVUVk9HT3EzNGNraVp4cmdOOVdPa3dsWExRUHRQS3o3TlUxbDBBaHVUMjlN?=
 =?utf-8?B?OTUwUkg5V1htYXoxNUxHQjNGQkFYaDRaWEp0TDhZOTkxTHIrRlh4dHhhamJy?=
 =?utf-8?B?V1QvdjZSUDdxbDEwQ0JTM3ZaM291RytjNUQxL2tCTWZ4TGNrMWxObjFjNTVK?=
 =?utf-8?B?WkhwbTZMWFpDcE5qM2VDUHpNY1pRSzBVQTFDWVNZa0llTGJRWTQ4VGV6My93?=
 =?utf-8?B?M0dib1NBWE54MmRYSEc0K0kvaEtDRnJHUnp5WHErTUVkYVRSOUhaVG5qL3pR?=
 =?utf-8?B?c2U2S1lzdHR2SXJSS3dGYTVVT2JRNDhnQkk4aGNRdTBaeDVrMFJYTHZaMWlr?=
 =?utf-8?B?TThDYS93UEVIVHF3WFlXTUY2L0tUWFBHOHNaNzEwUEpSNVhTNzRQbHE5YjRG?=
 =?utf-8?B?U1hzOHRDYnBmbE04aTdZN25IOWZhT056K1J2TWhsRVdOa3dRSGlVTlEzRUNw?=
 =?utf-8?B?MGtiK2h6UjljZ2R5WDRSa1hETTdmSGJySFFqM01LSDN3Q2UwMFgvVTcrZkxn?=
 =?utf-8?B?alhSR2VIMk5ieEF6RDBzcDVtcTBXekFqTG5KbVhTSzFSc2JwWFlURmVWVkVP?=
 =?utf-8?B?WXFmMDVwUjZyOWNubmhLa0pmdldZaDQ4enRpQkYzT3FNbks0QkxGY0N2YW9Q?=
 =?utf-8?B?QlJLdEh4OGJJMzMzYVQxZnlWMnpiOU9ibHRTUXQ1QlNRd0NhRDczNWwrbTc2?=
 =?utf-8?B?dEtVb212MU8zcHVIaHRDYTJBUFNyL3FqRUtLMnk1QmtHa09ZT2ZRTFowVjNq?=
 =?utf-8?B?emwrWEtJTnl0ajdNT1M3TWEvY3FPQjZhV0dlT1FacEorNU1xSENiczU2WXBX?=
 =?utf-8?B?aUZ2Z1pWakJwbDlhYVllVi94emxlbGZNOEhlUTRsVitRTDVyQjBBSWNrZ0R5?=
 =?utf-8?B?Lzl5M09ENGJWVDk3d2JibmRSbXpqZTJ0NXUreENFWGtZQ3pOaXVDUzN5c3hQ?=
 =?utf-8?B?Q2NXbmZGNkQxMUNzN2RQY1dhNmtEYXdQUW1lbjdoaStLcG1LY1RVempiUVhW?=
 =?utf-8?B?ay9PbHhlbW9WUFhTY0RYK2hub1lzRGVDbzY1MzI2aVVwS0dZNXFMcng3NE9F?=
 =?utf-8?B?V09YYnZ5U1M2QTZIWElIUlA1YkNuMDNzVldFVWtZZFFqT2JXSWdMdElidGQr?=
 =?utf-8?B?cWUvQ1QxRG5DY0ZXeVJvcnlreUtDdEMxNVdRcE9zd1J0dFhxQVpCbFNEcFhU?=
 =?utf-8?B?Yk1DbkZaNk45QzcvWVovanJqYktiVWl3S0FQanZrQUNmVVYrZkRmWndQeEpW?=
 =?utf-8?B?RGJYb25FVHRwNkdpdktha216VmErQmNUY0NqS3VCQmpqbmVXS3pETWRzdEg1?=
 =?utf-8?B?TmdXWk81T3FEeWhKc0VNVFcvTUQ4YlVzWlExWUxiQk1DNmREYXlMajZiZyt2?=
 =?utf-8?B?UDlpM3R1SjE1OFVwSEpSeGpmcDNuSUt2eWxxa25tT0FBZWs2RWJlZmFiaHJG?=
 =?utf-8?B?ZWhlcnk4QjBJT0R5alBLMlR4aDFqUXNyTm9wUnF2S1ByQ1dUdGRsMXZyRE44?=
 =?utf-8?Q?0QA+OwwtW+cRHObpJpeDBEWPj?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 658a5b81-86b0-43fe-b947-08dd6080cc2a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5423.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 09:40:45.7350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v5BNtLkTkmf7YYXebozHZ8ZnFg1yIu7yrQd+30+RKhfUFuQ4LsSzMz6tklKNqFIiHGHGF19avRdbgZOCJLGGfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8408
X-OriginatorOrg: intel.com

On Mon, Mar 10, 2025 at 10:45:24AM +0000, Filipe Manana wrote:
> On Sat, Mar 8, 2025 at 3:32 PM kernel test robot <lkp@intel.com> wrote:
> >
> > Hi,
> >
> > kernel test robot noticed the following build errors:
> >
> > [auto build test ERROR on kdave/for-next]
> > [also build test ERROR on next-20250307]
> > [cannot apply to linus/master v6.14-rc5]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> >
> > url:    https://github.com/intel-lab-lkp/linux/commits/fdmanana-kernel-org/btrfs-return-a-btrfs_inode-from-btrfs_iget_logging/20250307-214724
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
> > patch link:    https://lore.kernel.org/r/f6d2a09fb43742fb5be38f820908510e298f8d40.1741354479.git.fdmanana%40suse.com
> > patch subject: [PATCH 4/8] btrfs: make btrfs_iget() return a btrfs inode instead
> > config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20250308/202503082341.T7dnq95G-lkp@intel.com/config)
> > compiler: sh4-linux-gcc (GCC) 14.2.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250308/202503082341.T7dnq95G-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202503082341.T7dnq95G-lkp@intel.com/
> >
> > All errors (new ones prefixed by >>):
> >
> >    fs/btrfs/send.c: In function 'send_encoded_inline_extent':
> > >> fs/btrfs/send.c:5535:15: error: assignment to 'struct inode *' from incompatible pointer type 'struct btrfs_inode *' [-Wincompatible-pointer-types]
> >     5535 |         inode = btrfs_iget(sctx->cur_ino, root);
> 
> 
> You're testing against a branch that doesn't contain this dependency:
> 
> https://lore.kernel.org/linux-btrfs/89867e61f94b9a9f3711f66c141e4d483a9cc6bd.1741283556.git.fdmanana@suse.com/
> 
> It's in the for-next branch of the github repo:
> 
> https://github.com/btrfs/linux/commits/for-next/

Thanks for the info, i will configure the bot to consider this. Sorry for the false
positive.

> 
> but not yet in  any kernel.org repo.
> 
> Thanks.
> 
> >          |               ^
> >
> >
> > vim +5535 fs/btrfs/send.c
> >
> > 16e7549f045d33b Josef Bacik   2013-10-22  5519
> > 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5520  static int send_encoded_inline_extent(struct send_ctx *sctx,
> > 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5521                                        struct btrfs_path *path, u64 offset,
> > 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5522                                        u64 len)
> > 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5523  {
> > 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5524          struct btrfs_root *root = sctx->send_root;
> > 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5525          struct btrfs_fs_info *fs_info = root->fs_info;
> > 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5526          struct inode *inode;
> > 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5527          struct fs_path *fspath;
> > 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5528          struct extent_buffer *leaf = path->nodes[0];
> > 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5529          struct btrfs_key key;
> > 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5530          struct btrfs_file_extent_item *ei;
> > 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5531          u64 ram_bytes;
> > 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5532          size_t inline_size;
> > 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5533          int ret;
> > 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5534
> > d13240dd0a2d13b Filipe Manana 2024-06-13 @5535          inode = btrfs_iget(sctx->cur_ino, root);
> > 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5536          if (IS_ERR(inode))
> > 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5537                  return PTR_ERR(inode);
> > 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5538
> > 6054b503e2eafac Filipe Manana 2025-02-18  5539          fspath = get_cur_inode_path(sctx);
> > 6054b503e2eafac Filipe Manana 2025-02-18  5540          if (IS_ERR(fspath)) {
> > 6054b503e2eafac Filipe Manana 2025-02-18  5541                  ret = PTR_ERR(fspath);
> > 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5542                  goto out;
> > 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5543          }
> > 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5544
> > 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5545          ret = begin_cmd(sctx, BTRFS_SEND_C_ENCODED_WRITE);
> > 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5546          if (ret < 0)
> > 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5547                  goto out;
> > 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5548
> > 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5549          btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
> > 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5550          ei = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_file_extent_item);
> > 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5551          ram_bytes = btrfs_file_extent_ram_bytes(leaf, ei);
> > 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5552          inline_size = btrfs_file_extent_inline_item_len(leaf, path->slots[0]);
> > 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5553
> > 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5554          TLV_PUT_PATH(sctx, BTRFS_SEND_A_PATH, fspath);
> > 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5555          TLV_PUT_U64(sctx, BTRFS_SEND_A_FILE_OFFSET, offset);
> > 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5556          TLV_PUT_U64(sctx, BTRFS_SEND_A_UNENCODED_FILE_LEN,
> > 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5557                      min(key.offset + ram_bytes - offset, len));
> > 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5558          TLV_PUT_U64(sctx, BTRFS_SEND_A_UNENCODED_LEN, ram_bytes);
> > 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5559          TLV_PUT_U64(sctx, BTRFS_SEND_A_UNENCODED_OFFSET, offset - key.offset);
> > 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5560          ret = btrfs_encoded_io_compression_from_extent(fs_info,
> > 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5561                                  btrfs_file_extent_compression(leaf, ei));
> > 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5562          if (ret < 0)
> > 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5563                  goto out;
> > 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5564          TLV_PUT_U32(sctx, BTRFS_SEND_A_COMPRESSION, ret);
> > 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5565
> > 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5566          ret = put_data_header(sctx, inline_size);
> > 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5567          if (ret < 0)
> > 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5568                  goto out;
> > 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5569          read_extent_buffer(leaf, sctx->send_buf + sctx->send_size,
> > 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5570                             btrfs_file_extent_inline_start(ei), inline_size);
> > 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5571          sctx->send_size += inline_size;
> > 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5572
> > 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5573          ret = send_cmd(sctx);
> > 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5574
> > 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5575  tlv_put_failure:
> > 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5576  out:
> > 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5577          iput(inode);
> > 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5578          return ret;
> > 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5579  }
> > 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5580
> >
> > --
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
> 

