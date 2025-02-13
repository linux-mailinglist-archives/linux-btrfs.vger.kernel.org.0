Return-Path: <linux-btrfs+bounces-11436-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AC6A33562
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2025 03:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B62B9168029
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2025 02:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797C1146585;
	Thu, 13 Feb 2025 02:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IL6qvUWY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDBC1EB39
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Feb 2025 02:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739412987; cv=fail; b=gL2X6FCjmfREmtvbO0VnRUxuuFl+5rhLdtU8NurL7blaO/ODD0Fdu+9FALT4kPaOyRIYu+r0pok9KD0ZcBdD5puFY/Euj2otTcZOSXGrQOpu20PlDeZunzGL3iTMKgt0ADnmBBO5+KvesM/rrp0vPuVpBoOySSfYnJ8P3Q9fApc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739412987; c=relaxed/simple;
	bh=Awb4hMgTEbWDFm7IjC0Ai2zLQGcKTxuR6rC1ydu16OQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZsWLmIphoBH5TM6CRm209wSlyTWRefQRK4zzTWg+B6wGmvmee98D1A3tRzVO+ogottD8uEHHqEdoXeWlGOJTYtSk3mmWf6C5uwTF1icVETgMnxNO7hDrEe5kH+OFC6LVHokciYUkq1yJNV3gfjB0wLKBHjiAx1KdC1S+IlETHGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IL6qvUWY; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739412986; x=1770948986;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Awb4hMgTEbWDFm7IjC0Ai2zLQGcKTxuR6rC1ydu16OQ=;
  b=IL6qvUWYarE+ZhOs9Cwa10F6djT1sK9caaH4GUM3a24nPWND1xrrVq4Z
   EdZLpUrxxZM8ZWd+IPhke5pC4qgOYMmCqkGBugWS+7fOgaVc+oCiO1Wxc
   0F2zqdeNRaSApYCFZpQZP7FpP0wRdrL8dDNtOC728m4NBJRyGFyJq+CQF
   oENVZwLtM26ZFO6ZtVOifPAFofS0XjA9VYBEZv3krX0nfBv13ZALx0LI8
   Y11Q+Iza2OBpg1mrcCMHsrSE6uU8fn0Q+m7JpAMfuYX7JceJmyCdHsMi6
   B1EdKtJYDCb8oaI4QCZCFWK8fOKwFN6ZEV5EAkGQyRUCia9pAvBWkls3G
   A==;
X-CSE-ConnectionGUID: vGZc3oEUTp6jkmUuh8MFzw==
X-CSE-MsgGUID: AHePqEjoQS6MZ1HMXF1X2g==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="39283211"
X-IronPort-AV: E=Sophos;i="6.13,281,1732608000"; 
   d="scan'208";a="39283211"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 18:16:25 -0800
X-CSE-ConnectionGUID: sVXk3mIYQM+Lej0jo0W/zw==
X-CSE-MsgGUID: DgHpiCTpRYGCmC6IuWD6pQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="112850749"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 18:16:25 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Wed, 12 Feb 2025 18:16:24 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 12 Feb 2025 18:16:24 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 12 Feb 2025 18:16:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dh8Fyrmu416alEqmiC2ruTUSHzY+lGUBf4xd5ixcSoMASzbGK04v4pAtwhk0O2BSxaG3s0S/xGuNjkiw2dMYolbJw+Rj7u8+om04odL6cGbPgtfSWI0VgAZzipipNuEpVp11wwohPh24rgJIxyJCjC5wsGRp9p5Pe7YwxJ0szELcZ9e7V8aiFfkbWxv9pNf0mjVHaeCxFC+NoAcbGIMHje/sMKnr4+pSwNVq4wyscgsiLEE03hpUu8x2n+JNdIKn7lU6gqX2BxDzCKwuOXAnI686ZXSxvAxPlfAndo3PXEV5uBfSiffy3a9ToGWgAL6YLOvy8PSTUniCBB8IKirUIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Usm/S5uskbRVouaLz1F1mqQCQ9qVbE4Zp70jNXEqNvQ=;
 b=OIwao1XhJwm7fNzXNT2plg2DA6ezFUDMOyxAdqIL7tcb9Ux6IjPB/V1iI/C+DbaBw7HjS3Idkh5LSzyHa+d2+AHZIrRQTIUd4pVKcL4dgJyKfwcL6G76QVXA00a+DQa3a9d/SGMCKYJ2SVHaNkZgG7nqRKCwmBPBsTHQ29vwPsVqh61vyfecklSXaA365BdY29WwAZkNGtDyorWFRSVNq432OMMFf6f0/au6apg3y1CRh5E9qiDlSYOZbzuw0FPmqPfgGaHKqhMTNxQiJYfF4qzijnuFW0wja+AxbV9iRRhIzluoHxw68zYQAcfXNommq1A1jZzgfiIXq8iWSlncUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MN2PR11MB4664.namprd11.prod.outlook.com (2603:10b6:208:26e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Thu, 13 Feb
 2025 02:15:53 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8422.015; Thu, 13 Feb 2025
 02:15:52 +0000
Date: Thu, 13 Feb 2025 10:15:43 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Qu Wenruo <wqu@suse.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, David Sterba
	<dsterba@suse.com>, "hch@infradead.org" <hch@infradead.org>, Filipe Manana
	<fdmanana@suse.com>, <linux-btrfs@vger.kernel.org>, <oliver.sang@intel.com>
Subject: Re: [linux-next:master] [btrfs] 92a6e5b713: xfstests.btrfs.226.fail
Message-ID: <Z61Vz9Tu8TllGkCv@xsang-OptiPlex-9020>
References: <202502121035.e70df273-lkp@intel.com>
 <d9720346-bf14-440c-9a57-8e8c25864059@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d9720346-bf14-440c-9a57-8e8c25864059@suse.com>
X-ClientProxiedBy: SG2PR02CA0083.apcprd02.prod.outlook.com
 (2603:1096:4:90::23) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MN2PR11MB4664:EE_
X-MS-Office365-Filtering-Correlation-Id: 06fa55f2-5f1f-4896-b801-08dd4bd45728
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N1A4Q2h4QnlVaThrRklIY3BxalFBWXo5eU9Mc1FBUHRZTzFub0RxWWNXZXpF?=
 =?utf-8?B?S0h2OEt4T3dpWTZuTnlFektBSEJ5NU0zaXZJWU5KRjFOWkdFNnBkZGxDOWxO?=
 =?utf-8?B?V1NDNGsxZDZzRTRhd2dhdTdiUk51bWhsaVE5eDVPb1lNSnRwa2FmdER6TzRr?=
 =?utf-8?B?SGsxR2wxcGF6djRUMGJiaEF2Rk5GZ1R1eUROemNKYy9OMVcwUzR6TGtDNU9D?=
 =?utf-8?B?MWpLSzl6ZVkxbkR3TGlSSkkzMFF5czUzb3RRU1cwd2phYmlyZHlCei93MDg2?=
 =?utf-8?B?UlNJNFFYSGFyZENQWXAzNGwvbFNVWTV5YUxQYUFBMWl0cXNPZ0x1TmxQVld1?=
 =?utf-8?B?ajlHTC9SMmxtcGdQeWtoWUN1MWs3aURBSm9BYkxJd1BmazNDS0VKcVRtZjhI?=
 =?utf-8?B?Q1VNZmRBb09yaE9HZXgwYlEvZUJqb3g1endLVjlRRkN2QjRYTEZtL21Tb1dK?=
 =?utf-8?B?eHI1alo2ekp3aFR2K1g3ZkpKMFFBOWJtWmlTWHBvWG1XRllidmlIQkwvUGpP?=
 =?utf-8?B?WDQ2REdSVUJXWWtOOVJ2YkJVVUxiT3BOTGZ4ZXBmeFYwcmYrdkRRUG82S0V5?=
 =?utf-8?B?enQ1TkNIT2NWSEpSS3JWWW1ESzlsZDJIdFlONjlsTE1vU1QwcDMwTStyY05V?=
 =?utf-8?B?VEJ0R1QrcHBPMjhWM01aWE1FUitsaXVnUHJwd3R3YTJ0NDB2eEVjR2RaQmxE?=
 =?utf-8?B?enV0dXBaU01tSkhGQ1pFSjA4SGxFYXV2emhFVkpubW56U2VzenpySnVUU2ph?=
 =?utf-8?B?clNjam1GSFI4VzVOSlRyNTJKQzVGazErOTQ3WVN5SGlDZXlsQTNBMytJMHFv?=
 =?utf-8?B?WE9ETVNYSHlLSUFsTkVMeTlMdXBGR1crcFBjaXZ4R1VVcm9DVW92MjZ4dmtJ?=
 =?utf-8?B?WXRET1RiKzBub3ozSlhXbWtiODFzS1pRYnZ1VncrZU0zSmdhd3RsQm0rYnBz?=
 =?utf-8?B?aDg5ZDhvaXRNNmNEbGszNWpIQTdwKytzcVFRcUIwNTIwRFBwK3R1QXE0VzRm?=
 =?utf-8?B?b00rZHNYZjdYdW96cU0wS2FxNUh2TWMwU0k3TWZyeG1vK2JYbG5wQmFyVXVv?=
 =?utf-8?B?ekFJRHNoTFM5NDRFZGx1TkQwZEJiZ01TVDNkNkp3V1I3bDI0VVY2aVlZZW5I?=
 =?utf-8?B?bUdrTEhuMzN6cUpibjdRcHVhU3ZUNDh4ZlVROGE5aG9lWnBFRWNFak9mbnJG?=
 =?utf-8?B?VHQvZUxWTTdqMDB2eDZKM2RlQThLYkIvTDk1a2NZM0h2SFBqMUF0V0FJYW1i?=
 =?utf-8?B?VC92Z3NPVlpxYUVlVUIwR040ZkdEVWRXYmVOQW9YWlV1czFUVVk1d3ZVNUlL?=
 =?utf-8?B?OE5jNGtNaWwyTHVBVTNONGwzZ1hCdURjdURPcmh2L01EaGZTOUo4ZWZsVHU2?=
 =?utf-8?B?dVgvUTRxMXdCT0FISlA0UTVNUUQ5TDhQdlc4dGEramVTeTZQZVh3UWIxTGRG?=
 =?utf-8?B?T3lVdFpFeUlHUW11NHBiY3BMNnNtc3ZDN0NoOTVjdjk1SUwwNm90UEVyY0dL?=
 =?utf-8?B?TlFIKzdKTDdtTkRvVWhET2tMeldtbmVKSHRldzVtWnJ0d3VDc2dhSzFSVDk5?=
 =?utf-8?B?U0RxTGpiU1FyTEMvbFZldEtTNmV5bGN3K1IzVVV6cHNFcGtjbjRSaUVvWE1w?=
 =?utf-8?B?eS9PMXgyaHNPckhRQUkwTHpWSDFkbEdqMGx4L2NQZkNjdWlzMTI3bDRyanBo?=
 =?utf-8?B?N3FGVWpzV252YW1jTzdqR1ErMDFVVzBZVlRpdGR4K1ZTRmlrUHYvWG9iSnZx?=
 =?utf-8?B?UDJ3R3ZlQzZFTDlZZEZhZHpnTERBUWN4SE85WUpQOU1nTi9jazlEem1NVFFG?=
 =?utf-8?B?TjVmYnhyTlpsR1J5VHFidkdob3AyWTU3TWJTTlMyTTJoNnlLZituMmxuQ3ZW?=
 =?utf-8?B?TCtpdmZ6c24wNFVVcHRiM0g2Yyt5SUhzN2xtVkJjSC9Ta1E9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NndpYTR3WEYrS0JBMVJ5TjBIVlFPZ1hqTlF5bjZmQVhPMXZNUU45dFVjTHp3?=
 =?utf-8?B?K0NCcDFwOWMzQ1owNjRjVGJVeUpaL2pCYlpuZGxjZlNEdm1YdHJ3QUdRa0NU?=
 =?utf-8?B?S01PeHZzYisyUkI1YkVmSWJaL2NrdUg5M1lGUERRRGZiNUtZaUQrNytzQWZt?=
 =?utf-8?B?UWwyajliMlJvYnV0c3AvZHJDMStNQWh0cHFHZ1EzcTBPYUxOTnJxRithV3pP?=
 =?utf-8?B?Snhxa3R5YWhrWWFraGNXWFRIZFJnQ3dweUp6VE9XdVhNZzh6Nkc4Rit0cUR3?=
 =?utf-8?B?MlgwR1VzL2Z2NWNWSE9MQjhuek9rcVlid2lwQjFHMjlwTDNkUEgrNWhHVTE2?=
 =?utf-8?B?WnBOVVFyWVlVV3VRT1RnT3VMNytsU1NJbmVmVUc4b2kxOHFOOGFtRlFvOTlm?=
 =?utf-8?B?V2I5bHZZTlRCeFRHbkY2RmJNUjkxcTA3djh5ZEZSUDUrek4xZXFHVk0vR2o0?=
 =?utf-8?B?WHlPZE1lUXFNMjlEWVNya05LYlhLNXRpK09KdGxDWVRoU3grVHlTZnFwYXV4?=
 =?utf-8?B?UjF6c09HeWQxN3Aza0xyd2xFNktnYkhPN0pQYkI3M3ZVRzhVZnJ2V2tsb2pv?=
 =?utf-8?B?YVlNajdzTWRBaUd2OEZFQkdjSDBZZEU5MTRSOWltbnpxMHZHamRHVzV0VVZ2?=
 =?utf-8?B?OHI1bW0wWmx0UmtkNkpoYTEzTDhEelk2eEE3bk5SYkMvcVUyRFFWNDZqcWk3?=
 =?utf-8?B?aHRSdVZWdyt5djd2dzJ0TFM2UzRSdkE1YlRLU2IvWGl2blhMTnlraXZxY3dw?=
 =?utf-8?B?TzhURXJOS041REpTOVVKUXppK3N0dnZ0THJoZFFQdVVWTlkweWFGa3kzRTho?=
 =?utf-8?B?Zk5rT3IrM0lBNCtvVGZqWG5oNzVFNUt3WFlUTHh6dU9LdmlsUXJwaDViTWpD?=
 =?utf-8?B?T2RLYzBlTGtXUy9SV1dSOHEwdlBsMFQrbGlPaXVKa0NBRlNCMVV3dWhUOFpw?=
 =?utf-8?B?R2ZneHgzNzUza2lyK3ZyN3BIemYxNURIOTJtTWNNVndtSU9NZjF3eG91Lzg3?=
 =?utf-8?B?NkRud3lHZzhXc0lxVE5NM3RocWFTVmFvbCtnbzlJUW16OWYwWnlHMWs5WG9L?=
 =?utf-8?B?ZW51TXQvN0k3M3RHTVdhN21qeHZObHhxUW9SOVlQdEJXR1ZBTC9IdjFmZVFp?=
 =?utf-8?B?QTFpdmJsL3VHQlpqamFLcXllRWlYQXdvYklIeEFxTVVMcERxNlRnWGtOdjhT?=
 =?utf-8?B?cGtHKyt0YjBLc0ZEbzQ1SXVMTW1nVHJHdENWSnEvcVNWdHhCYzhFWnEycGNY?=
 =?utf-8?B?ZlFMSmdhc0JQV3FPZUU4WVBTalBkZlE4ditqRUZPRy9GVVMwQ3p0MW83UXlJ?=
 =?utf-8?B?MHBsOHRrQm1DeitrN2MvRjYrY1dJWVBla05vaHhTVmVZMGFQaDVEdkpVRFU2?=
 =?utf-8?B?d0NmT2ZpLzc4dytFbVpjMzZMY1N2cmFHb1pUMEV5Mk13MkdFYk1Uc1VFVldO?=
 =?utf-8?B?Sm9TWEs3ZitnbmdkcHNwcGpWUFUraEpMNHlSNEd0VVJZaGI2a3A4dEhXYXhG?=
 =?utf-8?B?ZzNkcUl3R2V4ci9vQWpIcnRIU200U05qVnNXcFdaQkZDOFBDZzRqcGk2SFdi?=
 =?utf-8?B?N1pZbGpHNy8zZXo2SUdTcWhMclFNQ3FrV2dPV1VZMUlXb2xkb21jRkJBRk5D?=
 =?utf-8?B?VG5UQTlnQjdDTDBsRVFoTkFRdmd3d0UvVEtOczUrNlluWTBSOHlPWU9LR2xu?=
 =?utf-8?B?bGM5RnZSeEZoSFV2aVE5TU4xRGV6Z0ttR0FMYjJSS0tDTG9BVmllV2x4Yjd4?=
 =?utf-8?B?MTZaQlRVZ0dmVTNyVC9lbTh5VDlqVWp1cjBjdGlKS1pUK1g4S3J0b1h2ZHhh?=
 =?utf-8?B?WHJ3UUtBZnJGNHB5bWxoUktzcGUwUVZOM0gzOGlZeGd3cGZtZDBBOWNzWm1t?=
 =?utf-8?B?c0ZxZHgxbS9mNHVMT3JVMEwzWnl6TmZ0LzRoS0g0VjZXdkVsTDMvaENXQTFK?=
 =?utf-8?B?ZlVVVEpIWmM3akM2OG81WUkxSjJZUUlubjI5RXk1UERSZjZWQ3FIaDJsZHRW?=
 =?utf-8?B?RkJxb2h5eDdNbzlyNWQ5V3YvdHliU2hIOXBqT0xhQjVrUGVvRlJYR0FIZ1lB?=
 =?utf-8?B?Y1NEaEpIME45czJNWE1oSkZoYXJ3alFNdGFSSVFNeUJocmE3MmliSEh4VDNu?=
 =?utf-8?B?aEtMeHBOOVFNckFqTHNYTW5sc3RZZHZsVlNDdHgzeHpSaE5NTEV6c0JQOHRt?=
 =?utf-8?B?RHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 06fa55f2-5f1f-4896-b801-08dd4bd45728
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 02:15:52.5118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E1wfYDLiTGjVZaZvTxtdaChHTDtLUFZBmp29gmu8YbfAqob+Lnkt9eNrHPuU6jaHTnPF1Pbg6eyQ+OxgAHUjaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4664
X-OriginatorOrg: intel.com

hi, Qu Wenruo,

On Wed, Feb 12, 2025 at 04:52:56PM +1030, Qu Wenruo wrote:
> 
> 
> 在 2025/2/12 15:14, kernel test robot 写道:
> > 
> > 
> > Hello,
> > 
> > kernel test robot noticed "xfstests.btrfs.226.fail" on:
> > 
> > commit: 92a6e5b7138df60388f43065b22d0fd846ab8802 ("btrfs: always fallback to buffered write if the inode requires checksum")
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > 
> > [test failed on linux-next/master df5d6180169ae06a2eac57e33b077ad6f6252440]
> 
> This is a known one, please update the test case, see this fstests patch:
> 
> https://lore.kernel.org/linux-btrfs/6b66d881e152296eab70acc19991d9a611aefde6.1738792721.git.wqu@suse.com/

thanks a lot for information!


