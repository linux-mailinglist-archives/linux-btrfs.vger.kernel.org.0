Return-Path: <linux-btrfs+bounces-10547-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B579F6229
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 10:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DB7C1707EE
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 09:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D651993BD;
	Wed, 18 Dec 2024 09:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CFstQx8t";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="S5nVqHe2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4807156676
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 09:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734515420; cv=fail; b=sJXagSZoKNgToYrcZNfgkePEkYY/JQDjoIoPdYJCzStHsbnA7xPto/noCNc5sYzG2nAef203bFFXIMlQDkBAZvvJPQjyxLRJzhYr0XwXVRYkmNIXOMg696oGZ54WmJdZIp8twWp1az3mJXA8aG5plCeTY2ctMY9+lzfvEFhj5qg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734515420; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s/uQMa55K+eGB/0+LKjBTrMh6of2f5webZAMYHphUvdmNFu1DoyFGgKc2MzX4lEY3p8kQkRruf0UQruXhLBPbH2AEQpmrA1SXScZY7LMjnUPrQQgq23YXMsiTIqNQSLL2vLPQnrBG4WJAc9rFJGaKbs5uFrhRXiHOJgen5W8Ovo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=CFstQx8t; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=S5nVqHe2; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1734515418; x=1766051418;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=CFstQx8trdIvtZ32hgS0xDsP6fKgb+AQKluYu3DteKArd6lMGnuRLNYU
   sNwv6OdAYX13PIk22bg2mgtgPn1CfRzYNxEPnTlgOTWjLgBKzhsImXr1n
   iDIl6aCQFrR46sQbPZGbyvPeKogH/dLmTc3jeE2QPH2a2mM2xiBkYkZFT
   5hGM9PbQfMAe4ByOWw2Xh72xoc1rGE6egQP9HuOx/MaVfB40s8cA5LEBD
   +1h64OoK4uD2TOq3t5uV8QncFuKRxoTZ1A8p6bTcLCXI3kK2YEDZucvsr
   PsdOfs9D1enNyRBTBO20L/zH3IgPmCUqnmpW/W2xhZ0ckxDGv3KaD5/46
   g==;
X-CSE-ConnectionGUID: ONdJpg++THaJrBRWKvcZBw==
X-CSE-MsgGUID: 8kDo8q10QgOHS6TAYdvh/Q==
X-IronPort-AV: E=Sophos;i="6.12,244,1728921600"; 
   d="scan'208";a="34655185"
Received: from mail-eastusazlp17010003.outbound.protection.outlook.com (HELO BL2PR02CU003.outbound.protection.outlook.com) ([40.93.11.3])
  by ob1.hgst.iphmx.com with ESMTP; 18 Dec 2024 17:50:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RjyvpRpcbiuRHzFmaFTsYeXlRPAxpVmW831Ee7DTknebKFbmIY7cFRo+W6LtfEauAJdosnyJXU0q6UMS2ROkp33gy7hCqkpkF1dUpM2YqMXwSBB4zWCFlPSmpVk9uwWv5JYGQIzxW2D8Lb5OpWlz73Sia1dMrNXtaHw04gqLjn2C/g8k7/0u84yPQo6iqV9RvQcC6lXlBefu/QMgF+N47NMHiabf9fn1kNzZuAqofEMpCRj30fg5YYQck9Hrrryn2PS6MTPxgjM3Jzs4X4sRemPv7VBVZZgEQTDZ88f/2N52LU30MIV/Wj2npp2vPEjtTqU7uf1TOTnjtqAomGxwAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=K0pTvxFChDu2IVAGjJg+QlwDin17j25DtBnOr8x+ktFnqv/M/7ySSe0BWSfSoPIf8HR57tBI4MKcSciIbEiHE7QTj9q/IZbJ/68cbs4X4srZOIzbsBraPP9PNsuZHqgFAajlq48HL/AV9LaDh/eCpPsHTS0mJaA00sgmvd8OAveycC4kiVHS7XbpVsUWPly08leTOgOnShTwAxcsysJV4LDoHm4cwI6fIuv88rBGYpxqYE6U/bIsYjqWtq6bawdFZm5ZP/G0dVvZycjcZ12VdnEz3Im+n/A/7Fr6yahTPKGFWCToaszsZeClnSnlohD/Hsx9WxVUdEDIPW6TxMNGhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=S5nVqHe2wZ114C0/w/FTks9uv/bL1tcLvi13miuZb7ydleJkt0LS684nmIUzSln9B7FKl0DUf4o7BpaMiI5E23IWiOgDnetaeAGGI6uZj6Bw+kd/WdE1mwo12wTBhIj4qLOZTjAwgipjbFCxAaO2TdyZRiS4UOlzTAjRIXwzR4I=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH8PR04MB8760.namprd04.prod.outlook.com (2603:10b6:510:258::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Wed, 18 Dec
 2024 09:50:14 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%6]) with mapi id 15.20.8251.015; Wed, 18 Dec 2024
 09:50:14 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: WenRuo Qu <wqu@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: sysfs: fix direct super block member read
Thread-Topic: [PATCH] btrfs: sysfs: fix direct super block member read
Thread-Index: AQHbURZ8VTr/xJeUHE2n3DiSJU2CXbLrwkqA
Date: Wed, 18 Dec 2024 09:50:14 +0000
Message-ID: <01647aaf-c0d7-4c92-bdfc-724effd93492@wdc.com>
References:
 <67a25027c7d05f33c71015b60fcfb75d89ac0ab9.1734503454.git.wqu@suse.com>
In-Reply-To:
 <67a25027c7d05f33c71015b60fcfb75d89ac0ab9.1734503454.git.wqu@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH8PR04MB8760:EE_
x-ms-office365-filtering-correlation-id: ca5fe083-c66b-4367-c956-08dd1f495ef2
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SnIvYlY2SjVsNjZSaHBQelczdzB4QytsOUMvZlpSTWRubFJ2MlJDVzh4bTVw?=
 =?utf-8?B?aEE5WEJEdTNhMFRmbmw2WkdKRkVaOVN5SkhmZS9xS2VOR1Y1dTNPckd4Q3BY?=
 =?utf-8?B?NE4yMGVPSnliT1pYdDByRjl0UVJCcEVBWkNJZ0JrY3lmYjhzcGhabHNhVnI2?=
 =?utf-8?B?cUY4Ri8wWG5mQnV0YTZTYUFnZlpEZkREcmVEYUpvQiswRE9zN0xvajN3R25w?=
 =?utf-8?B?TkM2OWdZb0VvazRSV0NVOXR3VHVWbzV5NXVXSVJFT0R5RU1jMXk1NytBSXNv?=
 =?utf-8?B?RGQ1dXEzK3JwZTU1bWFVbjFUbXViNFg1TVJyUmdLdWJRUzA5dnZSUkwvb3Vq?=
 =?utf-8?B?OVVyRlFZdzNDdDBSYmJRdlBQSTl2VE9lMVFkQlZrV1F5R0s5cVBtc2FRL0RP?=
 =?utf-8?B?ZU1NcWRtSndkSVFlRjNiblBpQVFibkpBOER2bzNEeHVjUitnR09YMWZkN0tn?=
 =?utf-8?B?UnkvSEJlWk43YVBsQlkvUDFaMnp5eVp1TGVXcmRIanFVUnVXKzdwQlVKZGRK?=
 =?utf-8?B?Q1F2cWNFSkZ1elVLYk1DZ3BzYXFWd3hHRDUzMTJCYlQ2WC9vcmFFb0M4K3lB?=
 =?utf-8?B?N2hsVzBRQWpRRlRQcDRnRld4bGpVeU9lZlJ3aHdoSEhqTUJyOStNd05jZ3pr?=
 =?utf-8?B?Qnh5SytQTE54S1draDB4KzhFeWx5b1pncElTc0ZKOFFMYU04bnhVUDlsVWlS?=
 =?utf-8?B?aGE0Zmtub2NaaWVsZVlnV1hheldtU0dPVWxCcDVMUVpFekd3TUE2R2VzMlBY?=
 =?utf-8?B?TnpuM3gwS2pNeFlRVm40Y3dXSVpXMWNhYjk2anAwTW9RdEs5UjY1OFMvcEJn?=
 =?utf-8?B?WHNsSnpsTHRWaElUL2xtaWlnQkxjeFo1MzBrRUo1OWdIQndGR1hGVFJ5OXdr?=
 =?utf-8?B?UGwyblZ4QjBpaFRid28rdXRzalNmcUNTS0EwZFJBNXhMMW5uUXFGbHU3T21o?=
 =?utf-8?B?QnZEWGh1dHlGSXlsMDFyWW1yaTFlQ1NjUHYvRUNlc0Q3UERFZVlZQU9LQUsz?=
 =?utf-8?B?ZmErbFo5dkh6UHhjZUVSbGNLMjBQT2wwZGl0K2JyMHh6SmlQRUE5T25Ibm14?=
 =?utf-8?B?ajVNTHplOVlmczdhejQ3VzhiYmhlS0l2VUFIeW9jQ2FBN1hnSlNvekZFaDds?=
 =?utf-8?B?d2Fra1JpcW5KWHE0eThyaG5YK2Y3cVVZS0pHay9JL2JqNGdvT3pqUFNkbk5j?=
 =?utf-8?B?eCtNRWEwckRPL3drQWk5UnRDS3Z3MUJxK1B5SS9wblJGMXVSRlEwZ05FRG10?=
 =?utf-8?B?UlZvTUJ5bTJjeVRHakVZMXVOUk5DRmYrcldYc1R4TTA0MU9GSUdScGEvT3Fi?=
 =?utf-8?B?WjlSclJKZGJTZ0pKTXFqVGJCVnIwSEFsK3QwSzJKVURuY0J2Q0dlN1NQRGUw?=
 =?utf-8?B?V2xTMkVpZ2tKZnNOZU82d09tU3U2K0JENGx4T1FjeXdjeDlRRDBTSnFyb0Zk?=
 =?utf-8?B?ZDEzYzMxS25yZU5JODhGMDZSd2kwazhNNXE2RG14QnY3UFYzTEVSNFdXQjY0?=
 =?utf-8?B?QWM1VFpkT0R0ZllZR3hVajh4NWNBL3Vsbm1hSlhNMGJBRm5wYmVVNHA1TDZC?=
 =?utf-8?B?eUU2a3FsbjFwUm54aGRGVjc4eUlrMVh0eG5TZDV0cHlUbHpEaEVHYVQ0Q1pv?=
 =?utf-8?B?YzR0emFYVXhXN3Qvb3NJalJTdGZtZWhkMVZDUFo5clNsTDRTbm9PK1dZcHJa?=
 =?utf-8?B?MElpazA2VHJvM2tSZTJZemdmK2E3OUYzZkRaRTlJaGNRTGpCR1lBV3VqRTJY?=
 =?utf-8?B?QXpkaUxOMldjb3grcUoxR3ZMdEdXa3Mwd20vbWs3MEtRZXRQMkc5ZkNsZVZy?=
 =?utf-8?B?aFNJK0lWcXJzSnplaHA1eVZ1bzFmWnZseHYyV08zUWdsdEVWN3lpMGM1QlVO?=
 =?utf-8?B?c1REcUFTd1VaaWw4MXl1MDZXRWw5clZDY2Z4cXo4U1pJNDdCbVY2aG85eG5M?=
 =?utf-8?Q?p37Z4D0+uAt/2Dk5VIcKWO51SLKhJXIm?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WDYyU1Z0L2lsT1RjU3MvTWR2YmdwVk4wSEk2VlZuamw2bmQvTkhNNXRTWkxt?=
 =?utf-8?B?L2V4cXlWTlJSclJ6bWl5NExjZjgvY1pqY0dKR2tOVEtXcmQwQkhmbExTQmY4?=
 =?utf-8?B?WjBYMm01MExobnJndlFjdVpZVlZiN24zWFFPYS9wYVRnSkozbzJ0dW5XTmoz?=
 =?utf-8?B?eWVFWVkrWjBpSk82UU92Mi9sRWpIRFJMeUQ0WXRZQk5EUXozZVVzbzBWZkVW?=
 =?utf-8?B?UHFkKzVBcUgwV0ZkRGRHaEVoSi9EZ3daT3VndzFoYXlkcEVhNzdvQm9jcGc3?=
 =?utf-8?B?enZnY1ZHZFlmNm5lRlBvNndqcGFKS09BZC9PWUdIdW1ybVdGLzFIaGlCSndF?=
 =?utf-8?B?Qi9uZHNKaytvTkpwSUhGUXVaeDM0ZWxPRFBncUFhTDhWU3g2TkNWQTA5QVZu?=
 =?utf-8?B?Y0Y0NnovNkJJUHhCb0tCK0pNeWI5dzd2czBYSHZJZnRFMGdHSTlBdnFRZjdy?=
 =?utf-8?B?RmluVHord3h4NVU0QnlEbS9KeWd1dGJDNE9pc1kyYi9EL2xkczBwd3Q1d1VF?=
 =?utf-8?B?MFJLTXRJYjBMU3RKSVRjcWRCOER6cys3V1ZCU2NxSmdwRDFFb1hqQ2NPcmFT?=
 =?utf-8?B?V2k4NGkyWDR4aHNpaHZ0di9mLzdOUmdXVnZtcG1EamtQdzhCWmlnNUpsM3ZT?=
 =?utf-8?B?a3dZUXU3akNUUk1GbDZPbWlOclVGTjlnRkJ1MzNRZUQ0SnU5Q3FmSXNnTU9m?=
 =?utf-8?B?M0JtVTZWUWRmb1dTMUV3eHA4ZDQ1TDMvNFhKN3UvRzZtRHFVaUZ1eGtRbGlI?=
 =?utf-8?B?M04xK3V3d0Y2U3ArWStPMkhUVDdwbUcxODZrQzdjbW95RytpQm0zdWV1NHBq?=
 =?utf-8?B?bkRGblJjR1hVSHNiMWFTQUFINEpZenJxWlhETlptQ083QzFnY1VGcHF1Q3Fx?=
 =?utf-8?B?SklBS1NBeW84cm5ZbU81aUhwdk5oU3NsK0JqWnYvbUFwSFFmY0ZlN3pNT3lN?=
 =?utf-8?B?TGN1Y05wQTJVMmVHNWJNWE56TVJpV3NSV0ZGelBXQTJlVm94NFFqZkVlWnhu?=
 =?utf-8?B?Y3NBVm1mZ0lZU3BqdTlKYmR4U2pxWkZ3NG5kNlVpc0c4bHdLNU9odFBGQlla?=
 =?utf-8?B?RC9NZ2JZaXp2MWtsTHo1N2lZZTlUOVJnaldheDFLLzR6TzJMOVkzUSt6QkRP?=
 =?utf-8?B?QitMcEMvSUN1TndCaTNpcUJuS0RrWFNpMjZCUHlSU2VJcTVQQzRSM1duR005?=
 =?utf-8?B?UTIvblRNOG9vNlNKV0RuOXZGNzdSNThBZGl4cnZVMWgvTExDRkhtU3VPdFlh?=
 =?utf-8?B?TFBIUnl5L3Rzc2Q3bW9rSlF2NVVybVBrVEpmcS9DNlo1VFdVZUNwMHRHdEMy?=
 =?utf-8?B?bEtyU2dVZk5nTkNIVyswKzg4WEtJQXppRDFnZDE5eTQ0OW9JQWtDTjVTOHd6?=
 =?utf-8?B?ZSs2SkhrMnpOMnI5cHJHb3pacnBoMEIwN0xrNEp4czlGZ1BIM2x2b21ZRGY0?=
 =?utf-8?B?Ynhqb05mb0RFSUtQYktuR2h2VncxS3dLMzJWMkhJS0lraEV0dERnZlRPUTUr?=
 =?utf-8?B?ZzBxVnhhT1FLMHBCc0QzSzZ0Ni8wTC9xdjM5dksrK2JFSlFpRkJ6Z2FXVnF0?=
 =?utf-8?B?eFFlMkl1dy9mY1VIMVR3LzhnM0RrQndlWWd4TEk5NHRaelEwTmd6TmF6REhD?=
 =?utf-8?B?QkJmdnlEMXdPQ0lSYzZWRUVWL3lUTFVXcVpMRkU2MzdjUElaZ1U5KzFNMzIv?=
 =?utf-8?B?NloyUEpFb1IvcDBGUUdXaDgyODk5UXROQ29hVXR1Qzd4b3ZLQTBIOWx0UEFn?=
 =?utf-8?B?WWNhVElUaVljVjhGOHFORVVNN280ZlZPWUdnZ2NYd01pclBhaS9MRVliY3NZ?=
 =?utf-8?B?WWladW04Zy9xMUliMEp4RUZJZ0RsTEtMWDg0Y0VlYmFjVXJDUXJxVzJUckll?=
 =?utf-8?B?dWtpZC90aHloYmlhNGt3cFhBT20rb3VreVR1dktRQWFYSXpkV0xub3RuQmZB?=
 =?utf-8?B?b3JpV3drYXhrK0RHNlJFWmM5VDB2WkhvREdWaGYyMkg0QjFUb2p3NkVZdzg0?=
 =?utf-8?B?RzFqcGpNOUhHc3FtS2tlaTNoMjZ1T3RDdW5LSVRtNTBuZFc0RjBWMGN1QTJC?=
 =?utf-8?B?eUcyY3hYajk1ZkRuQXd0enpQdm4wL1AxRDM5c1p6VDRhR2llYzJvWmtScy90?=
 =?utf-8?B?V2FCREFFMTgrYkRMTVFiOUxWY1MvNEtjWm81emdwR2QzaEhxUVRCWjUvamE4?=
 =?utf-8?B?Qnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F792028B21B3CB45A9079C4308EDEF8B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Wx3vKevg2YLQ1j5yOlz5vIEgE5LD9xpkGDp4106VuVW67iAuiz7WXKIHomHdxqU1kzbEbLKRxH1RgOsS4jr/E/qsEob+7DWkpj4CcpZb8N4Y7EVmxPPzdRGlrQLqvDn8s7p7oyX0+G0g5AMzhgw9WOwVmKLdHnrg+phVq1ijxZKfmhpN7MtwQY13kP+rVn6EeZTGkbzjlXqMkhXCKan4XEoC3R1HCSF5eodANwdQcZa7G5Lk9UeQx81swJhv4NXZkvenN7Lm7OleJ6HwWcjY6lH2+C4jfjPa0Gi+IBxUjZwGxBnCTnI8ZfVWgaRQI2RW9+3wle37FGEQVm2ryP0ggXMXJb2tdanKsEU59ByX78HVpzJeA5OZq1Cn2ONcAjS/ZAUBKe2GKx+RFgsJGwiwSYjQh/q8H/Z7FSjDe51gTEZD+SEI3kJ4fMFyYkh4Nzj06V9ymIOIlhIWXf4KXHtCOl13WKCo1UzKfLrNb6rPEdogv5Y2eph0s4NOW13fJTgaWo/MV5KpMoz5FrDMwrG3qoZe03pmXmG3639rafMXtw2XN15r08Tbik8RrqC0738REJVcKt4juSDTkoN/CqwykKGxgiGOk/+qCN6VY63F3VNk8YGW+1qInyp4uowZ07tW
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca5fe083-c66b-4367-c956-08dd1f495ef2
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2024 09:50:14.2428
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XYnNOehmLTtZrdi0BEhCUoDhdfLkbslG+d79Zhw+WUdx/LWJ4E/7M2R5IJ2wzoSzcEU/jeJGH/0ARsSEyK94DUfrvuHft2E5DIvfLc5o5Nk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR04MB8760

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K

