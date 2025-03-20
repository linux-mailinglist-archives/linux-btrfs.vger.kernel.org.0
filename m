Return-Path: <linux-btrfs+bounces-12461-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E24A6A625
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Mar 2025 13:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE77517A773
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Mar 2025 12:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36B0221DA2;
	Thu, 20 Mar 2025 12:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mDONajbE";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="c/MchOJ+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0B817A31A
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Mar 2025 12:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742473302; cv=fail; b=aSLyl//BSyxQX9h8J8PGQcYHRfAkSSZDzhKOjpnRXL57/fg5/H1Z4b9joY1EEAONpKN+DgeQyFjWTElHM1VLFhGuaauB9e8OfPrWJsPLB3W107pXqOD7sXbABnbF4Kr5sQS/BwlwuDHo+6E2ft1CW/OuXh7ZK/pCyF3hFwXAuWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742473302; c=relaxed/simple;
	bh=0+HRn3/kNUwLfBdmPKkaUqTf5uZsvSwhCG70MRldId4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DQF/kQ/uYnVNCaNU0rdUsxzOCR7GFx2kenDxYz5J0rsIAdPYjx9NH2QKbqX5+pgKPAd85qLdHdqNS3WZhRI179F9CRBKydOtbJGWm/EQY9reVXD3g9cPuBTLEwT9fuTGFj7PwEllKvBE/inOOrGtR879bRFJeAMsx1mU/Qud6/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=mDONajbE; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=c/MchOJ+; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1742473301; x=1774009301;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=0+HRn3/kNUwLfBdmPKkaUqTf5uZsvSwhCG70MRldId4=;
  b=mDONajbEsPSqQRYG2QwnMLGdmlxDPAv7o3EsUJeKjMwLQ9XytHh7kr/i
   L8JA1rSEH9tCxmC+9LsFcfq3ObteZliemng/8T7WbikpDkCY5yf/VpMbj
   PlnK4r2KrfVQoQ6a4dTMnJ4o5NMXw+GXWicoaHZc/ezfjK4+vGBlyo1Wr
   AahIbXSoHI1wV3sF49f9POCT9CQrWDXvnhAoQ4qwX4Q4yr2wTApHmrHmC
   ZtU5GARVng4/n0FKthCb0UOG33nNJ7ZQIpsoPlgigzyfXiVPUv8nA0IF8
   kO84ZCBsvyt3gu/r3R9ACP4/B/0REnsYeLydV85qnFeEQAB6Dzg9Slwvl
   A==;
X-CSE-ConnectionGUID: RFih05OTTRSYp3ylIn16uw==
X-CSE-MsgGUID: uewwzHLXQcu6D88lZMiuKg==
X-IronPort-AV: E=Sophos;i="6.14,261,1736784000"; 
   d="scan'208";a="55076933"
Received: from mail-dm3nam02lp2044.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.44])
  by ob1.hgst.iphmx.com with ESMTP; 20 Mar 2025 20:21:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bvCvv9qn+uJ65bAc4CcAuorrmdldO4g5zBpp0SVShzFSKCTixxcfsp5798zf8E+Qqql57hMBFl5/poPCCbaXNoHzwKNChIgchLTwzU/uZM5YpJiQm38QDS0RInDAaQK80ucrv1VUifZHN9xEoZGW3/QtO4LP3Sq5j7kDiUj6J0Dk/xpO2+sfU5SbZI+4n8h2pT3zlmv5QmgwbzPib+vK+y5Zdaeh8gWa0xJZCmLqK2bIGF3vMOyDKInBbRZIVDj+XreAFVXppZLc14K0C/585d0uwKCIP87Zy7glOKpYlaMFAxI3i/+5G9mAvOxGtiqEg0oFxhqkJQKnr5+TTcF0XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0+HRn3/kNUwLfBdmPKkaUqTf5uZsvSwhCG70MRldId4=;
 b=SNpGDhTYx+QO1TmKl+rZqVLBitGzldE0WgOGL2el8phf7095lNLAR+YypO2ESLZKfSmC7ETgcBfgPK18iDvRuW+Kg7WWUF16AIi0yDDpwmkgHaLNhHthkbBSVwxjBNf6eVGsdHX+AmVCmSWXu6ewD9mniWJ1s4TXtdn+oblmooEVG3chqOYE+BFmVX2wV+Kt+plhnVWHfHJlJoQJKWe+3sGtj7go82hvIsXxIPed4pzK2jyNouE0uxga0v7ZNUEw+W7nBc4Dmsz6GvhbxZXF4vleG+f8ImGqSrp4ivI0yP6XIFPlAGtqo0OWCwlHMhfwRovDF7vom/6S2IcXhKDalQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+HRn3/kNUwLfBdmPKkaUqTf5uZsvSwhCG70MRldId4=;
 b=c/MchOJ+2PMCtWY9rYdlkaFChMNwJOKP8q8HVRitdau6U44HbK8Z4qJ7lPwQublLfDpHobi8HgrV2NtKrioRziMKmonAaSIlCmRlxaIYNbbfBnWY0kbbvRJu/GgIjmXjHEoKzkUzaFMSOfYiEqrPXdn4BAUTSs+x+qigdYkFW5k=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BY5PR04MB6964.namprd04.prod.outlook.com (2603:10b6:a03:22c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Thu, 20 Mar
 2025 12:21:37 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 12:21:37 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Naohiro Aota <Naohiro.Aota@wdc.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 07/13] btrfs: pass space_info for block group creation
Thread-Topic: [PATCH v2 07/13] btrfs: pass space_info for block group creation
Thread-Index: AQHbmJaPIJlV2QDVbUKL7NeT1X0CSrN79BOA
Date: Thu, 20 Mar 2025 12:21:37 +0000
Message-ID: <0d717282-474e-4168-80f9-5562c2e10996@wdc.com>
References: <cover.1742364593.git.naohiro.aota@wdc.com>
 <1c2d3aa8f33d04cae6296d2d10a0688f435ef3a7.1742364593.git.naohiro.aota@wdc.com>
In-Reply-To:
 <1c2d3aa8f33d04cae6296d2d10a0688f435ef3a7.1742364593.git.naohiro.aota@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BY5PR04MB6964:EE_
x-ms-office365-filtering-correlation-id: 0be54de5-adff-4a78-317e-08dd67a9c314
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NmNQN1FVcW4yeEUxTWMvWlRUSnZDY3Q3NzRCY0hsZmRReDlacUFHYmJCbHRK?=
 =?utf-8?B?TGlBR3VNenpLZ2VwVFRLNWZnWnRKZ01GR3VHVGJ4OTlmakpXcUl4MUorUThZ?=
 =?utf-8?B?NEFNU2J4OERiSnE2L05hRUVJUTcrUU9tdjBhVEJHWXY4RzhCdnc1YlBvM2hQ?=
 =?utf-8?B?SGV3dGhVemx3VUpKd3RXeUNYanQxQkZjRzRzaFdYY1JkWFBJdmpObGhFNE1n?=
 =?utf-8?B?Rjd6a0N3K3FYZjVjeEhFcUJVSXZkU1pGRHFHOGhTMGFrQ3V5UEY1SU1yd2t0?=
 =?utf-8?B?dHVMSkpHVG9uT3I0R2xGL3hwUUlvM0c4b2tOWXA2cnZxWGdQSU9TVVZUY3Ja?=
 =?utf-8?B?cWlZSGkveWQ2VEhKWmh2VWtUYUVOQnNhdG1Jb0xSd2w5R2FVNEQySXlYQmZZ?=
 =?utf-8?B?SlRWZEpwMUpXdVV6dTBSL3gxbzFzaWRuQmo5YzRJenZWUVVhdVdBekFCWXRv?=
 =?utf-8?B?cWNrRDJwY1RLUzhId0dac1REcDRwTjhGdzhGRGZ3WEJsalljRDlHK08zVldz?=
 =?utf-8?B?cndLdkxtQ3hadHdjRzdRbHJJVm1KVWdtRUxqbzFvcnBoR3RGV3FWZFRPWU0y?=
 =?utf-8?B?WmhpNGM5azVDVXpGS2JqQW5ISDBDcnh4bUtQYjZSUDBka0ZRa0xHR2hocndS?=
 =?utf-8?B?Qkp5REE4YXB0bkxVRGtQL0EzS1NRYUNONUNiSUwyN0VTZXlickFKcGdVZndT?=
 =?utf-8?B?L3picHFOZE1mOHRXaFk1MnlzdFhCKzZxbXE1SVFDdnV5elJqMHp0RDN3S05F?=
 =?utf-8?B?eW01eExJRGNBem5yWHh5QXkybklrVGdlL0tNby8wR0FiREhMbzNOT0IrNHFw?=
 =?utf-8?B?cWY5QUhmSkxkM0doc2lRZ1ZUbEFWREFTSlhZTjI1WURhZUdaM3RLUjVsNzha?=
 =?utf-8?B?dzB3YmdZOFp5dDNGWmhhQnJJSzVVNXgxOXBjejRSWXNPMkhNNXpXY3NyOWc5?=
 =?utf-8?B?UEJ1eUZGTUlKVnhlSTRSTThFZ3lOT2xBUzVkRHcvN2NaYit0Vm9mVEx4akVz?=
 =?utf-8?B?RUJPUTVhSEU5QU52L0ZyWngwZW1QU3QxckY2RURSZm5CalpaUHZNRGl4M2Fu?=
 =?utf-8?B?anI2S0RlRm5HM3NhOGlxT0ZCU1ZZOXFsMzBnMU5sUmdOVG1oaFJBZUJxSWYv?=
 =?utf-8?B?aGFqS3c3QkliVTcyT2tSbVNHZTFrSG0vdjlubDkzZHdxSUhHSXdLRHJqemxC?=
 =?utf-8?B?SzVkUHpBWWc5bytIWkpXUFBEcFFST1BaV1BLWmo0ZS9vYUpYR1VMcTN3a1Nl?=
 =?utf-8?B?alR1MXkyc05IbmVGVTVhTEFxMVhFSkJrTFFRcHhFU2hMcmV3WVlrVnRWSkp6?=
 =?utf-8?B?MCtla25wekFrcEErTWZUbFJEUW81dGdQSEhoYnI4bE5PZlpyc29iMGdVamVi?=
 =?utf-8?B?aW1aaXpRczFEdGk3Rnh3NXJqTWkyVzRZakNlcktISlVxN0hWa0lVbk8wQkZP?=
 =?utf-8?B?SjRteWlHRXhmZll1dlNiQVpVTzc4akRLOFRXNG1ES0E4RlpkOVUyR0Y2Z1pW?=
 =?utf-8?B?Z2lzYTdVSHc0cnJXUmZFOVF0K0ZFYWNveTBrNFBJdUk1cmdVVC84bFJQb1kv?=
 =?utf-8?B?aGVhNDh1bWJGdFQxVXBlZC9ERjgzZHh6dDhiaVVFVmZTOTNadUNHTjlSSURh?=
 =?utf-8?B?NTJlSU9EZjdLbjdicHIvamVrMXNVdzlld3poamxNcnhjeCtIY0VMTmdGT1Vk?=
 =?utf-8?B?TVE2M3FhSFZGMG96LzBHVk41aDJHR0pGSm94RVBVaUlBQnJsNThwcU0xUm1z?=
 =?utf-8?B?MnFBZDhrZ1BmNWdFZGhHRzZuRWpPRnpWTjNWcHh2U2toVjF3dGpDTURkTU1z?=
 =?utf-8?B?V3ZwOFNjSzRWenNNN2VXUUc5TE1yRkdteVdxTzR3dm5nR3pWQmZMQnNFS1Nt?=
 =?utf-8?B?a1FtK2U2d2xCRHRVT0RvZGxoTlovTEtVQ1NaN3kzbVVvTDdBMEtxR2RrMTFq?=
 =?utf-8?Q?3pCIQN0m88jhsvl16gRtAXooovuBKHla?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VlcvMUsxUXZ4WVd2ejdDSHVmOUZMdTNmVXZtRnBJWTJNKzBoRUhjTzZrMk00?=
 =?utf-8?B?anJLUG1FSisrNXpHNHdkVDZvVXdVdWhjTWRGTDYzdFRUem02VThPWDJmZ3pq?=
 =?utf-8?B?bkJxVlhFWHhXbUhRdTk2dlJQWFpyUlhPWmFIV29idzBJd1FTOU9VbzZrYnMw?=
 =?utf-8?B?MnNvY0ZGdmZnUzl6TjNCMEprV0dpTHVJdFBVNG9PTW1CVWQwQ1pDYWJGTjlh?=
 =?utf-8?B?NC9zZHpmVnczTC9xYTh0QUJEQ1A3WDFzLzRSODNVNkRjOU5EdW0xcmNNTVkr?=
 =?utf-8?B?Zzl3SjhtYVo2WDV4aXVldXlCS09vdlRnSVl6TDdHK2NlZXExRUU1ZnpEU1h6?=
 =?utf-8?B?UDc1VlduSTdOSjFBamZqRWxURnFwWG5WRHlxS1FGRmg1bXNZRkJYTTlNd0c2?=
 =?utf-8?B?NzhTSis3WHkyTU8yUklDazgvNmlzbzRyaFlJTDJQc21tT3pNR2pOUmgwQ0x5?=
 =?utf-8?B?a3Q0c2ZzeHpQSEQyMXZFWUgxM2ZubVdaN3F4YUt2U3FmTDFXeXdveHdlOEpq?=
 =?utf-8?B?cktMNXlrWkxhQXp4cHJza1FpRThmMGRobE4zZlRqSlZPTlNWb2NQaDZ3YXNy?=
 =?utf-8?B?cjdZNUd6MUU4YWJNWG1DZWNIeGg0TXp3QmRJUU0xWDdXcEpNTW12SzQ5OCtX?=
 =?utf-8?B?TlZoVS96d29vQ29kQ0w0TE9scWcrd2FyN1owRXJKUHZuUUNLSHMwa0wvb0Vj?=
 =?utf-8?B?L3NwbHFxTU02VGU1SHYrN2I0b0RsTkpXdGoreWVYdy9WMzdOY01QSjc0UEVQ?=
 =?utf-8?B?ekNxdi9nb0tFT0xGZm9ENSs0bmY1RjFpWUhVTWFRV0w2RS9yOU0xRmI5ZFIw?=
 =?utf-8?B?TCs1dW9CTXZSMHVxT1N0QXBqWk1NelVZRkZVM2JPVmdTQmxIMDllM3JleGhT?=
 =?utf-8?B?YVh2UFY0V3pBZUJQN2RtdGEzQWk5cmEvclZLZFp3NGUxNm1qL3hHME4rKzBY?=
 =?utf-8?B?OFpoK0U3Qk02VHd1YnJLNnVJdnVSUDRmZ281dzhBK2pTL2oyb3hRYzlRZjVq?=
 =?utf-8?B?ZnM4T1JHb085MGdRcTJ2UGJPeU9zY1g0U2locndEVnBSVXVpdjZETmZoTTB4?=
 =?utf-8?B?K2FEbGg5OWQ3WmpGbytZM0VFbDZjQ2dPaVY2TEhDdGhpdDVoTFF3Umt0cE13?=
 =?utf-8?B?MnVVU3RHNi8wTUsyU29GcnRCL2dVU3l0YmROSHJLSHo5U0ovT0xzT0J5Q1hy?=
 =?utf-8?B?TS9UYlUzbzFWN3VBL0dIekZ0TExIWTBSNm9rdDBFdXFVcFBQU2lkbVNRTlVr?=
 =?utf-8?B?MkoxaVZ0bXF2bk1TWUJEdml5d3lPUW9Kczd4ak00ZldKL2NNV21tWFlyWkVz?=
 =?utf-8?B?MmszaUZuNVk3VFVTK01DRkxZS2JOY3QwVy9XV0ttQklsNnNwTjNqZnYzQ3RT?=
 =?utf-8?B?c2hoWGFuQmlwdGVHbHUzRW14TitsanppM1IrYmhLektCclBFQ0hFSXU1cTg5?=
 =?utf-8?B?cEE0WlBEM0dxak1qOHNUTjgwODlYV0k4SVJ5aDFOMjB2SlRYc2JtS1ErRytu?=
 =?utf-8?B?UXRUZXdZZStTSUtid3NpWDgwcEpFVmtjZXVyRVNBN2tRR0xML2d1dTZJY1di?=
 =?utf-8?B?Rk1QYVYrcDduSytSbUlXRjBMaGVteU1oVEFtU0FKVTlmcFBpdk1qalo4bWxS?=
 =?utf-8?B?ZzVPM1d0ZDd6U2hZbTJiWU00M3I3QmtIRjUxZG1nRzdUT2E4cHZzMHI4ZXJ6?=
 =?utf-8?B?YTV1WUlUYlAwb25zN0c3aXFxTGltWitPMlR2c2o3Z2s2R0dmR1lZV2ZWdTNT?=
 =?utf-8?B?T2R4WllIek1DMUtESWYydy9UcVVFYndVU213ZVQ5aTlhV0lvSXloeTJLOGlx?=
 =?utf-8?B?UGZIU1RmeUQweVJyWWFYYVlocGV6V0JtSGxRU0JBbjRESFF5T2RuUmlhenVn?=
 =?utf-8?B?V1NCTTBtZkxKekJtR1hxYTJHSnlDQzQ5bEZXekFoaUVFdnQvSG1ZdGlSV3dx?=
 =?utf-8?B?VmlQS1dJMlErZks0Ky82b2ttYkpzc1NEdFJRUEpGQ3FLZktxTFgvRWM3UmtE?=
 =?utf-8?B?WlhWODE1QVJORG0yd2ExdURRMkUxbC9raVdtaEZOdnlveDBrY1NjSHY5MFBn?=
 =?utf-8?B?NGJ3eWNjam91N25yUlhDTDEvbXpqV29mSVJUVFFwTUdJcGxTZWthY25Pd2JD?=
 =?utf-8?B?SGxMK1h1eTVxN05pUnpjam1VNXQ2cWs0clczN0RYdGRhMUhjdTk5a3JRWmN3?=
 =?utf-8?Q?ugD9wiMe97j7aPCkCBUSViU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <65B4EF8ECA9E2D46A96FE9572AF3518B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lNWkearu26qWeIUse1//mxLAahfmsMvaD09xHsV/9Jh2YG260QZQjiz9V3v/zWtOeUVZ7ouTPIjqo8gW9f2friAN/IsJRmyPDFliSfadzllCYu5DcY3HkxOsz6Elu9U5EKF53GyE1ERWlpWTr8LYZlvMXgbOzOf1Jtn5PDfLt/Pf3cCduH1SOSs9qoE09cvrpp7gFtg+5sD4nShwVau28/TfSl2ZrOCEt8k0sp1pscd1xOQ7h6apWlI7g5aOqpNq2ocLtGKnzAsTzp3eNdrH7BAhTL2k0qEQJrsXf0yonxDFsEnV0zToXIvYAmLNzNNawVuU0T225Vc1YZYPkv7PzBG1xpXCWA2Plk5aLRE2MFbLlShSBwCz0fuIlk9cI6n1qpBBxFT8SCx/nZJWF+hgbncP0CjdHILhNL2MxxNbJOh4xUhOgK9DckbfLEPZQcfYZWg+7ZOm3p8k19aBJBOE7XSLM0fxYI6bUa/qT8xXXzLCfdDI1S9KBjoEWTA7MOdBDBHTz/VymNu3QilVXrbx7xBoZ/LUTdBivGOnNFm0DtDsj+LLB1snLnGAeBXJ5cqlDM5ASDaCsd2pgXP8RF6c9PfSKqDG1LQSqAvBsZU55QXkaEhdyKIezlOXWPLb5bcx
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0be54de5-adff-4a78-317e-08dd67a9c314
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2025 12:21:37.6305
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sekhAWjgqL6uypsmLNc6W6HN8zK6TTLMjeTAbA6+tewTx5mxb6yiNjO2QTKVoVJDnE0LSL3+X6ZI8MfXkIC5tngQwTL6iWaaa7IjSDR6uRg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6964

T24gMTkuMDMuMjUgMDc6MTcsIE5hb2hpcm8gQW90YSB3cm90ZToNCj4gQWRkIGJ0cmZzX3NwYWNl
X2luZm8gcGFyYW1ldGVyIHRvIGJ0cmZzX21ha2VfYmxvY2tfZ3JvdXAoKSwgaXRzIHJlbGF0ZWQN
Cj4gZnVuY3Rpb25zIGFuZCByZWxhdGVkIHN0cnVjdC4gUGFzc2VkIHNwYWNlX2luZm8gd2lsbCBo
YXZlIGEgbmV3IGJsb2NrDQo+IGdyb3VwLiBJZiBOVUxMIGlzIHBhc3NlZCwgaXQgdXNlcyB0aGUg
ZGVmYXVsdCBzcGFjZV9pbmZvLg0KPiANCj4gVGhlIHBhcmFtZXRlciBpcyB1c2VkIGluIGEgbGF0
ZXIgY29tbWl0IGFuZCB0aGUgYmVoYXZpb3IgaXMgdW5jaGFuZ2VkIG5vdy4NCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IE5hb2hpcm8gQW90YSA8bmFvaGlyby5hb3RhQHdkYy5jb20+DQo+IC0tLQ0KPiAg
IGZzL2J0cmZzL2Jsb2NrLWdyb3VwLmMgfCAxNSArKysrKysrKy0tLS0tLS0NCj4gICBmcy9idHJm
cy9ibG9jay1ncm91cC5oIHwgIDIgKy0NCj4gICBmcy9idHJmcy92b2x1bWVzLmMgICAgIHwgMTYg
KysrKysrKysrKystLS0tLQ0KPiAgIGZzL2J0cmZzL3ZvbHVtZXMuaCAgICAgfCAgMiArLQ0KPiAg
IDQgZmlsZXMgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKSwgMTQgZGVsZXRpb25zKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZnMvYnRyZnMvYmxvY2stZ3JvdXAuYyBiL2ZzL2J0cmZzL2Jsb2NrLWdy
b3VwLmMNCj4gaW5kZXggZmEwOGQ3YjY3YjFmLi41NmMzYWEwZTdmZTIgMTAwNjQ0DQo+IC0tLSBh
L2ZzL2J0cmZzL2Jsb2NrLWdyb3VwLmMNCj4gKysrIGIvZnMvYnRyZnMvYmxvY2stZ3JvdXAuYw0K
PiBAQCAtMjg2OCw3ICsyODY4LDcgQEAgc3RhdGljIHU2NCBjYWxjdWxhdGVfZ2xvYmFsX3Jvb3Rf
aWQoY29uc3Qgc3RydWN0IGJ0cmZzX2ZzX2luZm8gKmZzX2luZm8sIHU2NCBvZmYNCj4gICB9DQo+
ICAgDQo+ICAgc3RydWN0IGJ0cmZzX2Jsb2NrX2dyb3VwICpidHJmc19tYWtlX2Jsb2NrX2dyb3Vw
KHN0cnVjdCBidHJmc190cmFuc19oYW5kbGUgKnRyYW5zLA0KPiAtCQkJCQkJIHU2NCB0eXBlLA0K
PiArCQkJCQkJIHN0cnVjdCBidHJmc19zcGFjZV9pbmZvICpzcGFjZV9pbmZvLCB1NjQgdHlwZSwN
Cj4gICAJCQkJCQkgdTY0IGNodW5rX29mZnNldCwgdTY0IHNpemUpDQo+ICAgew0KDQpQbGVhc2Ug
bW92ZSB1NjQgdHlwZSB0byB0aGUgbmV4dCBsaW5lLg0KDQpbLi4uXQ0KDQo+IC1zdGF0aWMgc3Ry
dWN0IGJ0cmZzX2Jsb2NrX2dyb3VwICpkb19jaHVua19hbGxvYyhzdHJ1Y3QgYnRyZnNfdHJhbnNf
aGFuZGxlICp0cmFucywgdTY0IGZsYWdzKQ0KPiArc3RhdGljIHN0cnVjdCBidHJmc19ibG9ja19n
cm91cCAqZG9fY2h1bmtfYWxsb2Moc3RydWN0IGJ0cmZzX3RyYW5zX2hhbmRsZSAqdHJhbnMsDQo+
ICsJCQkJCQlzdHJ1Y3QgYnRyZnNfc3BhY2VfaW5mbyAqc3BhY2VfaW5mbywgdTY0IGZsYWdzKQ0K
DQoNClNhbWUgZm9yIGZsYWdzIGhlcmUgKG9yIHNoaWZ0IHN0cnVjdCBidHJmc19zcGFjZV9pbmZv
IHRvIHRoZSBsZWZ0KS4NCg0KDQo+IGRpZmYgLS1naXQgYS9mcy9idHJmcy9ibG9jay1ncm91cC5o
IGIvZnMvYnRyZnMvYmxvY2stZ3JvdXAuaA0KPiBpbmRleCBjMDFmM2FmNzI2YTEuLmNiOWIwNDA1
MTcyYyAxMDA2NDQNCj4gLS0tIGEvZnMvYnRyZnMvYmxvY2stZ3JvdXAuaA0KPiArKysgYi9mcy9i
dHJmcy9ibG9jay1ncm91cC5oDQo+IEBAIC0zMjYsNyArMzI2LDcgQEAgdm9pZCBidHJmc19yZWNs
YWltX2JncyhzdHJ1Y3QgYnRyZnNfZnNfaW5mbyAqZnNfaW5mbyk7DQo+ICAgdm9pZCBidHJmc19t
YXJrX2JnX3RvX3JlY2xhaW0oc3RydWN0IGJ0cmZzX2Jsb2NrX2dyb3VwICpiZyk7DQo+ICAgaW50
IGJ0cmZzX3JlYWRfYmxvY2tfZ3JvdXBzKHN0cnVjdCBidHJmc19mc19pbmZvICppbmZvKTsNCj4g
ICBzdHJ1Y3QgYnRyZnNfYmxvY2tfZ3JvdXAgKmJ0cmZzX21ha2VfYmxvY2tfZ3JvdXAoc3RydWN0
IGJ0cmZzX3RyYW5zX2hhbmRsZSAqdHJhbnMsDQo+IC0JCQkJCQkgdTY0IHR5cGUsDQo+ICsJCQkJ
CQkgc3RydWN0IGJ0cmZzX3NwYWNlX2luZm8gKnNwYWNlX2luZm8sIHU2NCB0eXBlLA0KDQpTYW1l
IGhlcmUuDQoNCj4gQEAgLTU2MTgsNyArNTYyMCw3IEBAIHN0YXRpYyBzdHJ1Y3QgYnRyZnNfYmxv
Y2tfZ3JvdXAgKmNyZWF0ZV9jaHVuayhzdHJ1Y3QgYnRyZnNfdHJhbnNfaGFuZGxlICp0cmFucywN
Cj4gICAJCXJldHVybiBFUlJfUFRSKHJldCk7DQo+ICAgCX0NCj4gICANCj4gLQlibG9ja19ncm91
cCA9IGJ0cmZzX21ha2VfYmxvY2tfZ3JvdXAodHJhbnMsIHR5cGUsIHN0YXJ0LCBjdGwtPmNodW5r
X3NpemUpOw0KPiArCWJsb2NrX2dyb3VwID0gYnRyZnNfbWFrZV9ibG9ja19ncm91cCh0cmFucywg
Y3RsLT5zcGFjZV9pbmZvLCB0eXBlLCBzdGFydCwgY3RsLT5jaHVua19zaXplKTsNCg0KY3RsLT5j
aHVua19zaXplIGlzIGF0IDk5IGhlcmUsIHBsZWFzZSBtb3ZlIGl0IHRvIGEgbmV3IGxpbmUgYXMg
d2VsbC4NCg0KPiAgIAlpZiAoSVNfRVJSKGJsb2NrX2dyb3VwKSkgew0KPiAgIAkJYnRyZnNfcmVt
b3ZlX2NodW5rX21hcChpbmZvLCBtYXApOw0KPiAgIAkJcmV0dXJuIGJsb2NrX2dyb3VwOw0KPiBA
QCAtNTY0NCw3ICs1NjQ2LDcgQEAgc3RhdGljIHN0cnVjdCBidHJmc19ibG9ja19ncm91cCAqY3Jl
YXRlX2NodW5rKHN0cnVjdCBidHJmc190cmFuc19oYW5kbGUgKnRyYW5zLA0KPiAgIH0NCj4gICAN
Cj4gICBzdHJ1Y3QgYnRyZnNfYmxvY2tfZ3JvdXAgKmJ0cmZzX2NyZWF0ZV9jaHVuayhzdHJ1Y3Qg
YnRyZnNfdHJhbnNfaGFuZGxlICp0cmFucywNCj4gLQkJCQkJICAgIHU2NCB0eXBlKQ0KPiArCQkJ
CQkgICAgIHN0cnVjdCBidHJmc19zcGFjZV9pbmZvICpzcGFjZV9pbmZvLCB1NjQgdHlwZSkNCg0K
U2FtZSBmb3IgdHlwZS4gc3BhY2VfaW5mbyBpcyBhbHJlYWR5IG92ZXIgODAsIHNvIHR5cGUgc2hv
dWxkIGdvIHRvIGEgbmV3IA0KbGluZS4NCg0KPiAgIHsNCj4gICAJc3RydWN0IGJ0cmZzX2ZzX2lu
Zm8gKmluZm8gPSB0cmFucy0+ZnNfaW5mbzsNCj4gICAJc3RydWN0IGJ0cmZzX2ZzX2RldmljZXMg
KmZzX2RldmljZXMgPSBpbmZvLT5mc19kZXZpY2VzOw0KPiBAQCAtNTY3Miw4ICs1Njc0LDEyIEBA
IHN0cnVjdCBidHJmc19ibG9ja19ncm91cCAqYnRyZnNfY3JlYXRlX2NodW5rKHN0cnVjdCBidHJm
c190cmFuc19oYW5kbGUgKnRyYW5zLA0KPiAgIAkJcmV0dXJuIEVSUl9QVFIoLUVJTlZBTCk7DQo+
ICAgCX0NCj4gICANCj4gKwlpZiAoIXNwYWNlX2luZm8pDQo+ICsJCXNwYWNlX2luZm8gPSBidHJm
c19maW5kX3NwYWNlX2luZm8oaW5mbywgdHlwZSk7DQo+ICsJQVNTRVJUKHNwYWNlX2luZm8pOw0K
DQpzcGFjZV9pbmZvID09IE5VTEwgc2hvdWxkIG5ldmVyIGhhcHBlbiwgc28gYW4gQVNTRVJUKCkg
aXMganVzdGlmaWVkLiBCdXQgDQpjYW4gd2UgbWFrZSBhIGdyYWNlZnVsIHJldHVybiBpbiBjYXNl
IENPTkZJR19CVFJGU19BU1NFUlQ9bj8gTGlrZSB3aXRoIA0KdGhlIEJUUkZTX0JMT0NLX0dST1VQ
X1RZUEVfTUFTSyBjaGVjayBhYm92ZToNCg0KCWlmICghc3BhY2VfaW5mbykgew0KCQlBU1NFUlQo
MCk7DQoJCXJldHVybiBFUlJfUFRSKC1FSU5WQUwpOw0KCX0NCg0KDQo+IGRpZmYgLS1naXQgYS9m
cy9idHJmcy92b2x1bWVzLmggYi9mcy9idHJmcy92b2x1bWVzLmgNCj4gaW5kZXggZTI0N2Q1NTFk
YTY3Li44YWY1MzYwNzhjYWIgMTAwNjQ0DQo+IC0tLSBhL2ZzL2J0cmZzL3ZvbHVtZXMuaA0KPiAr
KysgYi9mcy9idHJmcy92b2x1bWVzLmgNCj4gQEAgLTcxNSw3ICs3MTUsNyBAQCBzdHJ1Y3QgYnRy
ZnNfZGlzY2FyZF9zdHJpcGUgKmJ0cmZzX21hcF9kaXNjYXJkKHN0cnVjdCBidHJmc19mc19pbmZv
ICpmc19pbmZvLA0KPiAgIGludCBidHJmc19yZWFkX3N5c19hcnJheShzdHJ1Y3QgYnRyZnNfZnNf
aW5mbyAqZnNfaW5mbyk7DQo+ICAgaW50IGJ0cmZzX3JlYWRfY2h1bmtfdHJlZShzdHJ1Y3QgYnRy
ZnNfZnNfaW5mbyAqZnNfaW5mbyk7DQo+ICAgc3RydWN0IGJ0cmZzX2Jsb2NrX2dyb3VwICpidHJm
c19jcmVhdGVfY2h1bmsoc3RydWN0IGJ0cmZzX3RyYW5zX2hhbmRsZSAqdHJhbnMsDQo+IC0JCQkJ
CSAgICB1NjQgdHlwZSk7DQo+ICsJCQkJCSAgICAgc3RydWN0IGJ0cmZzX3NwYWNlX2luZm8gKnNw
YWNlX2luZm8sIHU2NCB0eXBlKTsNCg0KT3Zlcmx5IGxvbmcgbGluZSBhZ2Fpbi4NCg0KV2l0aCB0
aGF0IGZpeGVkLA0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1
bXNoaXJuQHdkYy5jb20+DQo=

