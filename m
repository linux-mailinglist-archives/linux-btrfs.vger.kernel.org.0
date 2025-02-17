Return-Path: <linux-btrfs+bounces-11516-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F92A38AE1
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2025 18:48:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA94D3AB308
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2025 17:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F1322DFBD;
	Mon, 17 Feb 2025 17:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OMRDt9bg";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="W2AsY0Jf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDF722D4F1
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Feb 2025 17:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739814470; cv=fail; b=qQGRooTf0yXNBm8OrZOq8Js6B7tcvG6RcQIuZ+LLpER0nkbuXFE4al1iQnsy+eBxsE3I407mRNM0MwRnL2GKKj3hzMcMLIsmyFfx23eSIcOHUDrdWUiB5kh1Bcv6yUx5YtlyM5bEtiP0962L6bapIPdHrf4ROWMuZ1P+D9+OT50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739814470; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Lc6H0kyxLA5foTnXhmqQo8bn4yMUu2zQAzKSVFilOSIs2N6lCrn2WN04l5C3eKYA1qY69zVz1kGSB4nDjL6cPSsUinHZEI7Xt3m3s12xbrQYBxuxJ95N9JInC62VCEwfa1jEEVnczniSnRCkn2E4UdYUrf8kQBjiz3402rxg37Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=OMRDt9bg; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=W2AsY0Jf; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1739814469; x=1771350469;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=OMRDt9bgFlOcIb3+YgdLyCG0E8qL8Go+PEXIjP0OvGwys/qo/a+UAC5+
   0d1apCfpQ2oGtdPPHoy4kNUvexBXPTLB1qnBc7mMctAhBvl0pz8P7K+XM
   C7YO7an3TGXQQ2gfCaDvnB7rTPWzBAe42tSxnmaITg6KOuqzwwvq9RDrY
   86kyl0GiGr5ePcmOCryvyhaZj0cDlgk32p4Hb9EMvWYL/F++r3dt+VfdP
   rr0vH1+JtVTjqBW+eaMU5ChbZnnsyxi0Gs9F/jN5XDzNNNdbL7kNiUK8W
   N4Nt6m3EAcyEf58pPsgVyjmbeEN5+v9QnoKyh2DzkIJGNNt1hUV01ksKw
   g==;
X-CSE-ConnectionGUID: wfvf2niOS9OVPCtFMM/7FQ==
X-CSE-MsgGUID: LCftVjtTRMGDf4pWmRGuZg==
X-IronPort-AV: E=Sophos;i="6.13,293,1732550400"; 
   d="scan'208";a="38673284"
Received: from mail-bl0pr05cu006.outbound1701.protection.outlook.com (HELO BL0PR05CU006.outbound.protection.outlook.com) ([40.93.2.10])
  by ob1.hgst.iphmx.com with ESMTP; 18 Feb 2025 01:47:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ckxj8dMMkDWm0w3s204AUEH1uJ6TJXxiEg2NYxrraQFS6PdMpuptwXXTOjtvO9EkfX0mi5+S90F8Yy8/8uSip03MPbF0wNkYNtbGod4bvQo0L1UaXkr3b5c90xC34CruMXcHar79ySKBCXMq6Rnv5viHIGQPR9FISxuZWmT586gZtfrtV7se6bQhr8taeLS+mispTZlBKNxHMrRfdwhSn4Rgaiwlgo5nd83NtjV6d971JDuR14DeRkJinrsqHjxKIED8TaGJkkMjD4GqZA7zmReuV/DRAtbIeokXNedtMLv8SJ7HZ4N6HMt+MA345PpBOMaDXh6c8j1GEGyi4h1i9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=tmKJV7F0pqIPMVJw6j4qHJ/nHydgmOf3+k3NYut44LFBUn5OKXfKKVzC+azFrIMQb5dBzDgiQmrbc9N4HLHaX/olljph/Id540252uVbeMn0wUSMqQJmIrqhsWIdf/L1W7tIoLy0jVs+FnIWGVR+sc3nXWivP7QLMRSJjjr+6oqZ95aJqZj3BF0xXtBHzWnRKovuLxorSOGzXnN9KbsO8jjljcsFGbX12JEDrpVpOy95suP94jyV2ibeCNoSaMvexJYwcmv31L4lQGCDK1crYD9Y6vOCAIy5u85+Ut9i2Z3ao37DL/zimd4rA6F58dJqzJ7Lt6HV/E6ntf7FXh7cog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=W2AsY0JfoiaXp7WTO5M7tEOT4GsyYac98bOXG0wd8+iHfTHfdDI7ZlSsqkarGGNNeHTiEc3ziYXwKRHSGwnqPH18Om3RbNIqYdj/9JfUqgLRdL6UkAylBhpQTAjIDamIcKAYP+qHsEtdgX6Cs+Qt3LeQFspArmmcuy1G6+sOWck=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB6953.namprd04.prod.outlook.com (2603:10b6:5:24a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.17; Mon, 17 Feb
 2025 17:47:46 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 17:47:46 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/3] btrfs: fix use-after-free on inode when scanning root
 during em shrinking
Thread-Topic: [PATCH 1/3] btrfs: fix use-after-free on inode when scanning
 root during em shrinking
Thread-Index: AQHbgHT786Q3SVvo4Eiez07aFkVP9bNLxzAA
Date: Mon, 17 Feb 2025 17:47:46 +0000
Message-ID: <8c820852-1918-4ee5-8af4-635bbfa60921@wdc.com>
References: <cover.1739710434.git.fdmanana@suse.com>
 <38c908d189e4bd6c5d137c20d9fb905509625069.1739710434.git.fdmanana@suse.com>
In-Reply-To:
 <38c908d189e4bd6c5d137c20d9fb905509625069.1739710434.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB6953:EE_
x-ms-office365-filtering-correlation-id: ae5a1d36-ebc6-4b9f-48ee-08dd4f7b302d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?R1BpWGV4QW4rVXcxdEE3RjNvVG40NjF4UDRPOU5YZTdXdFRSNFR6NUI5b1dD?=
 =?utf-8?B?VU1NSlE2Nk53MGdNK3lSVDBVZkVOVjl1dHRjQ1IvRmRIcFlQUUE2N2JEZTZy?=
 =?utf-8?B?NlVRL0NFa1E1allkZUJUSjR3Qm9oUFJsTWFMVUtmOTI3anZpY25JNm8xQm1I?=
 =?utf-8?B?azZTWC84dEtlRHlnTkVVQ3BISnEvVWphVGt1bHpzK01aMXJnZ3dnMTM0VFNZ?=
 =?utf-8?B?MHBVY0lxT21jNXB0bjBMZkQ4NENaL0JuRFhBVUsvR2plb2o3akIwMVdVVTdp?=
 =?utf-8?B?aVdGRlBlaHh5SlQraks2Ump0THZSaGh2Nk5NcEFpWEtiVVMwSmgzSXBpblVE?=
 =?utf-8?B?bEhJNm5kVlNQUnJ4cnVuNm5rMHNxVkR4cEdMSnpCMGVoK0lrbGx3MTg0bm8v?=
 =?utf-8?B?WmFqMXoxcnVWTy9zUUZkQ0I4KzRjVTNlSnd1c2ZBNDBnREdLQkQxVm9ucnJD?=
 =?utf-8?B?eXZHWElFVCtTUkRJM1ZGa015UU8yMERqSDFDYlVqeVdPWlZ6UVhLZkVybm9I?=
 =?utf-8?B?cWdpNmVNVkk5dmlwSEh5VXNUUk8zVzUveXByUEdoamx1RzcvaEZSWFpUT3NN?=
 =?utf-8?B?dmpsYXBza2l4d2ZPK01EZUhrMnVVZHhZTUE2TEE1WXRyUUFobGRhUEdMMU9U?=
 =?utf-8?B?c1lXSnI2TTZhbWtqUVRCVFMwOHVCM0pZNGpTNkVKY0I3QWM3VGhuK0tJVXFX?=
 =?utf-8?B?UzFpeHp5Z1ljZE9rb2NzTlNPTHd3K0xFREJYdHlzMmxVMXhCeXJkQ0pac3BS?=
 =?utf-8?B?ZG9DZi9sYUdaQmNyNmN6SGtXdHYwZm1TZ0JIVWYvbSt6OXR4NDVhVVoxNEhk?=
 =?utf-8?B?Ym4zdUxiUFJNNnpEUEE0YTQyLzJFbm1Jc25zaVZCM3ZqTUdQT2QvTC8vNkI3?=
 =?utf-8?B?eDdKbHp6OHkwZkRjTHBjaVZwMDYvYzFQeWE1T1U3Z0ptT2lPeE41TWlPbEhh?=
 =?utf-8?B?Z1haUkxCTFRXd05ySnd6ZE1hNk9RQVg5VS8rNEZsZEZGSDRkUko0bThrTElO?=
 =?utf-8?B?dWx0Tk5MblVmTGg4TUpKbzFSRTlOTUt4emhWeVEzM0hjZy9ZeW9mM25PQmc4?=
 =?utf-8?B?eWZUUENoM2lwM1JBV21zanRZMjZINVp1Y21VSWl4VzBieFY5ckUzcGRMRkJi?=
 =?utf-8?B?dGdrSUhzZHlwSldncTVnUFlGbzZRMU55NjNwVjN6cjhzWFNHMjl1N2k5WTFF?=
 =?utf-8?B?bVg2ckFiQUNVbWhLS1J4UlZ1amUwQmVKbzIzNk1ESnBsS3IwdE85VmtyR3lv?=
 =?utf-8?B?RHRzK25qMlUzTVhTTzVscjkySnVUTHdxaCtiNzB0akdCcXdwWm9OWVJObXVh?=
 =?utf-8?B?NXB4Zzc1NHFHWm9yQVpXOGRCT3k0eTBBVGV1dThaZ3BHaFhZbUxEdlc1cEw2?=
 =?utf-8?B?Nm9GenIwLzNMT2Fhb2MyVEYvSWExVm1WOWdVUWRFN2xCMnBBVTl2MDV3OFVh?=
 =?utf-8?B?bmU5MTlacXRHWm83Zjd3K1d0Nnd0R0JWRld1VUtaMEVXNFk3Wko0YmhPKzRQ?=
 =?utf-8?B?NWM4QU5VaVkwenFuaEdHQXREckk0Sis0eU90TTB5MFNUV3pjUkhkSzY2Z0xs?=
 =?utf-8?B?YUZRSmtvV0V4RWplTHh6aldFQkQ5ZWUxcGZURjBSZ21TTWN4bHZqWTlzS0Mr?=
 =?utf-8?B?Rk1odVJMQmx6NlE1SGYyMW1GY25uTW1PcFByc1ZlS0x3Q2Vqekh1V0VyMlV6?=
 =?utf-8?B?UFlROTRiOExpanVoRWRRNE9wMFFtNHBwWHV2ampScFVhblRkZXk5amJpUDlU?=
 =?utf-8?B?ejRqWVhEd3BWb2syRG1vYjIzY3F6bXBGMGxicTdUejRFd0Q3YTFKYmdCb0Z2?=
 =?utf-8?B?NUpmSGhuUmszdllyRTVGMjBSZ3ZmVW81c3UyYnAzbzk4Ky8zR1MvVzdFVXo4?=
 =?utf-8?B?WEZib3l0ZHJKUFFBU2gvcVF6L1phOC9VaEtCZ0NPVjZkZ05HcWpiVk8xd0Fv?=
 =?utf-8?Q?+qEN6vuSQKbp5F7S1YygdYQ0g0rSBUM8?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?REZBM0JQSHllNXduWURpRWR1YXcvY3Q5U2F4dDk2QkE5Q1dXTnk5ZzlNUndF?=
 =?utf-8?B?ZC9ZU09tbXUrNUpOWnQxMWVweU43TzNSckR2N25kdFBNbUxWYS9IUlpjNkNO?=
 =?utf-8?B?OW5JL1d2WnNNMzVGM3dKQ2FIaDZVOHIyb1hXZGFOMXc0OFJOckR5OFNMWHVK?=
 =?utf-8?B?aEZoRTgyYTREMTVlUncwN0Fvd0dYTTBqbVpZUkVES1lrTHgybHhvcm1KNUJv?=
 =?utf-8?B?WFRSUUV5Y0Jrc1ZnOXE1Tlk2WS9YQkgxbUgzQjdIdkRoRk9sTnYrNGlSdUhN?=
 =?utf-8?B?NklidlpDUlE4cmZyY3hEbEhFM01QNkdaR3JkZUhDNXJDUks1WEVHTmEwV1Zj?=
 =?utf-8?B?YUVLaXRCWU1veTUwdFRjMjVPUVo3d3U1bnc3RjJsY2Q5WVRDUEMwWWpGdCt4?=
 =?utf-8?B?VHFpZUZwOWJydm5yRStRRHVMeVJvTXZLRHNnSmgrTys0MVdOS1MrVzNEbzRs?=
 =?utf-8?B?bm1uLzhNNG1vUnB5K0pQQXczOUxGb1orYmFHZWY1OVlVM1JQSlNuTVBjdEIr?=
 =?utf-8?B?cUQwQTl1QTdrYXp1YUhLL1J2aWxGQng0RnFXa3BoRzl4bmY5cDNIZCt0RE1t?=
 =?utf-8?B?bDhZUGhCdHJqcm83N2s5Vlc4cmkzcjVCNXBTUzF1RkRwQnlYMGQvU1dMajJ4?=
 =?utf-8?B?Y0E3Ry9CRkg0VU1DMVVhNUx2MmNreTViR3dFVHIvK0dpZ0ZFWW10U01QZWlP?=
 =?utf-8?B?clJpSUk2NldjdjJGbHhScjhHZ1ZrVmlXd3ZsenlxaGwxQjlFUVpwWnFsT09y?=
 =?utf-8?B?alJVbkdLMWo5WHlDQjFMZkV4WC9MckZLanJ6SS8rWnVyY21pTjZYK1pHbHh2?=
 =?utf-8?B?STJyNUUzcGoyc0lMcWtuVlp2ZU14Y2Y0M0FTeTdDNWVCR0hMWWY5aTZiYjVl?=
 =?utf-8?B?Y2ZjU1d0OFRxOWZTNVFNOS9RSXJPM3NWc0VXY0MxWHJnWmNXenY4SkRjVGIz?=
 =?utf-8?B?ZDAxcE1BN3ZVS3N1bVE1bmtKNUllbHgvWFcrUEJvdGZ2eGpSOWQzVlpEVGxq?=
 =?utf-8?B?KytIUHdzMTRzNWFrZjBvbUp5Tk5JU0hzSnd0a2txVzU3bnhQa0E5aWJ1c0FE?=
 =?utf-8?B?TVQvK0lrWGl3Nmt3aGhtT3FaSjZZMEpPTWRUWmcySW9LQThieEtVTjJtb1Q3?=
 =?utf-8?B?RGJtdjhUQ1IxV0dESjJBc0tCeW1ucHhSTlRLaDV6cjhiemNUV2FSK1AzaWt5?=
 =?utf-8?B?UjczNTlPSHRoQU1tVUF3NVZWSWExeGt3czJEVkt1U3dSMWIyS2hBeWp0MnJP?=
 =?utf-8?B?ZTJLOVRWcC90am0vSnRIak1zTG9hTTR2RTVyNzZrc2tjTEZ3QU9CNlgrMlhB?=
 =?utf-8?B?QjZzU1JaZTV3WExxbmU2bXYxUTZWd2ZDUERLeVZBVEJLRjN5endSdTlFYzdr?=
 =?utf-8?B?NmV1R3pIZzhqbnp4aXMwb2NvNG1sTVdkSGJtUVdPc2JCWDg2M0lJSlhOcDBY?=
 =?utf-8?B?VEJKQzREU3hqMUdGNFpuenJ2QlNhbFlabVI5K0hZS0lzZGJjdFZkUEc3Njg2?=
 =?utf-8?B?RldWOWpiSzNjVnpqdVBDOUpheUZDekFnRHlhYzBJRE4xUXRpbkpISzZPb1Qx?=
 =?utf-8?B?cFk2UHI1S1NhbEU1T3pPM0NWa0dLRlgrRnhWaWxPdFVrYnhsNTE1NGs0Y3pa?=
 =?utf-8?B?VTN3ZXh1aGI3R25zdHVtRlpnbWkyeHFlbTZmUjVYR3lhVFQ4dDlPQlNhYzRN?=
 =?utf-8?B?SWVFVFBOZkJtTzBhNVBVbHhUREZ0MjZBSi9XNGRPVnZRa3N3bUpDeTl2OXZK?=
 =?utf-8?B?aS9TWkRLTlk2eWg4dGdwaTNKZG9ZK2RLTlVGc1NJTStzR21XN2k0bmlZQjR0?=
 =?utf-8?B?M1BOaFFWV2xUbFpMNGhIMWxPWWZEdTRtNUdvVmxQYmdJdmRiZHJnRUhBaVF2?=
 =?utf-8?B?SGJRd2p0eU1oMnA1SFBpTHpSRmFQdmxmT0NhcUJyV1h6ZGZRNEU0cnFnNkpy?=
 =?utf-8?B?bmlSUHUxMkxqUXVBb2FjNVpWZnRCUEVaU0ptYWFDckd5ZzZ2Q1BsTFJuUG16?=
 =?utf-8?B?TE5ZaXFBS0pDb3R3YWVwejRLWTVNN3RUbkpjWFozR0RWOUJjUjB4OXFVYjlk?=
 =?utf-8?B?bGdPZ0RxOUx4TStkRFQyTDF5WDYwQ2toWExLeGU5aHhyNXIxQnIycTA3cHZk?=
 =?utf-8?B?Rk12Yisxd09GSkw0SzRxOExySm9QRkdPNTFEZVBVRG9sd3M5NjByVlhGYWRZ?=
 =?utf-8?B?M1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <71C8D70125446C47ACD0A101329F0DEF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oL1LVfTFLZXj1nQSJ3YOcDW72INkfdYcI7GjgjxL1WJT7YRtrB0crQXa3V+3hjS+nZ3oX8l84u/zF/MCUCan7ktokAizJ7EGte8sBjiynoEbD84OFXijGLB8WPH/4Zk0CXjVCnrpG+SmYGY30i7AvU1qY1aNfO8pXSY2/23JY8sB7XuyvKquu9ZJ34QNxyRWA88jUAS/Ve6bxMuNGkfcLLaSTPtMDHYI9eABmPPInL7oUSmpgFpD66lm6ErItKkQsHNkZ5nHcJc0CqcmWrrw4bMC0A3pLpOkw/36Z2NNUW3WqIWqpQ+fSitu6w4JySAdgubQ0knlGNEpXLnEzz1d0y0kcOo+dwshl4FLLmwCCgd6hSdopDs6tkedA5KFIet35PvrjiO3snp/oC90qJQ7cMbjHcMY6Wx75+8tUx43uUko02WhPd3XnOOhHbyQE6s8Lj/h7Zc05ei5tzhCaz/qjeroP53K8SKFD29DixGOIKv51nOSI8Homf96DO7qnNXS9QlizZLqXOs8DAlL4blxRwKvwV7Bao/nH1J0nhqkUdYzSAshhUwqnh0IQDWF+eg+87RwdZ/GbL8y0SVEFFV6P8jw70zu1iyl77uKbdWdBqTV6R16A3t/BzuZEMawme6Y
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae5a1d36-ebc6-4b9f-48ee-08dd4f7b302d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2025 17:47:46.3824
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: waBdCWUEZ00c6mHRnCoQI+tl2Zrm45bmzoNrNZEhDBlLyAhA2Za6w6QeNH50iftu3GHBb8833Vy8DChsiu+RgVTPZfM91lx6MHk380yhr14=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6953

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K

