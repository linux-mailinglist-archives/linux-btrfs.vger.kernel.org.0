Return-Path: <linux-btrfs+bounces-8737-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10719997147
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 18:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 869A6283941
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 16:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B371E285C;
	Wed,  9 Oct 2024 16:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Z93uX+Vj";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Og6ReMEQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3658126C17
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Oct 2024 16:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728490539; cv=fail; b=YicncqrpUg4j3Kj5T1g5XzJXn9I/BT5VIfzVWx9Oa6Wiw5tS/xnhJdYCcFo5Qnqx+Orq1aZuaOoBu+lwsqCbG/vWZ5gAf7j4c/pEJn1NeQfH4q5hyaDEcBi8/n0zF+2GOmJJMCARAkUunICtZPHeomjXBgbB1GiPjQ2B4yx+5os=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728490539; c=relaxed/simple;
	bh=6nmoEKSqd/W2gV06dOyT1wBzaWYfmlCez0URAuRsKyQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=psZz3nc3ezdLdro4pVL1ECkO74U5KAMJYZraJ0V33U+2lW0pfHJHjFexTPgp3cQxQM3V2xFv3/U72p4exUJZcAomp0cdMRhkRAjY1LdZ6vk4qmVXbb49tQQrqRXEauE9aMtMJTAQA5AC0pMCpHgDai9ac0QI8pC3rQ1SBZJqWc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Z93uX+Vj; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Og6ReMEQ; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1728490538; x=1760026538;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=6nmoEKSqd/W2gV06dOyT1wBzaWYfmlCez0URAuRsKyQ=;
  b=Z93uX+VjMYY2RR4pgUQwksVcyxG2LhmEq42SYKB+qfZ11X+mTFnEYwuT
   5FRq2/0uRksWWo/1gwncjHKk3V74hsinWAZFyBCDXerqqhPipjHnyQoTH
   5TitmQbmeVKGbo2q2r4RpgFeQ1bLkEImyExvgIkG8QAh563HpaqNP8X8d
   Y34tv0O5UWYa6tPrypzR5bNaSoxWPpUoblOhqOt8ZO9z8Vo3qx9JB+z+V
   19GOr2hjS0airy703wbAHbmExlqEcFYjuUEiXdPSkXYhSIUgrVZzxQ+N2
   H4ns6aX1HFtSPVY3ZOH/pWNqkHF3Uuyu7HvWBasMhIEcnb2zVmvOtah7E
   Q==;
X-CSE-ConnectionGUID: XVgBFBl0TPmes7w1A/Kkcg==
X-CSE-MsgGUID: fx0lQYGNT0+1GsAd9XGp4A==
X-IronPort-AV: E=Sophos;i="6.11,190,1725292800"; 
   d="scan'208";a="27993787"
Received: from mail-westusazlp17010006.outbound.protection.outlook.com (HELO BYAPR05CU005.outbound.protection.outlook.com) ([40.93.1.6])
  by ob1.hgst.iphmx.com with ESMTP; 10 Oct 2024 00:15:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aEy5ofbCPwo8XKS8prjVGb5i5U1YM0s2F0QlWodB6s+yW0McxcBkg65bkfw94aB3dYQNkOhb9uVC0PJNApMW/5GAFDlU4/YAhwnbV66KZSiWtPwGhXXtKE8WqCV3hTO6cNZG9S0fni1lYxVn1KGzrHvX814X//VPw8vnrkaxiQu0BMuG49YMH0sIAasQT/SfbC5d7z4BIul/exC30OR05IebtP4w24A443HpwWoV4eRS5IrwjhqavMVbH0BsYoYNeCVe6Ljp1Hf2VRfuSfJcvursbpOcO8QxlTeq2zaokUHW5t3oJPZ9SOF4+vk7PLl2NtUuhwzFrVcyU6KyamgeGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6nmoEKSqd/W2gV06dOyT1wBzaWYfmlCez0URAuRsKyQ=;
 b=olHh9FK1WuaycPVnow1SLhcLuBrcSIo904p2chTUW9JN3a6SVvZGMqOKIOjqj6DJGOXIMjolOZPmTsgYX4J9lurJ5s3W4SNvagO37ZOSHaCjQIml2r5U1uesjq2NhJBPYgmFVjqmuC7uFtNgO/hhox5Rr0G7mWRIa9MA+to/VxwoxGL3H7UVPpz5lo+CgAD0SZKVOh617uINm/7BMe8FGiJo1nyJYPQk7xi+uzB0NtvL2jrB4NWokDfLwOPaSDMsT7QiJLGMqq9S0Jfarem1sStG7ke/Tt+I0IHia6UrwDbVHkGgOf/S0/1s/BCCl3kPi2F6j0YiQhOPAIjpL4XvWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6nmoEKSqd/W2gV06dOyT1wBzaWYfmlCez0URAuRsKyQ=;
 b=Og6ReMEQKHI/0zub2yjPvxuoIkAnWjoOzCfXfvcd3yhQCHp4ujJ92HnBIiv2s/btXyUGdEV0epTeUdxEpgP+dYKF5R8Yu0X+pLWHwv1XNJUi1yQ0W14o6D+B+FcQHopcKs7EMtuGFTRpcmGv3znHO2tSmLFSYu7QpCb5Y1yQ/EA=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB6446.namprd04.prod.outlook.com (2603:10b6:208:1aa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 16:15:30 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8048.013; Wed, 9 Oct 2024
 16:15:30 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Johannes Thumshirn <jth@kernel.org>, David Sterba <dsterba@suse.com>,
	Josef Bacik <josef@toxicpanda.com>
CC: Filipe Manana <fdmanana@suse.com>, Naohiro Aota <Naohiro.Aota@wdc.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] btrfs: implement partial deletion of RAID stripe
 extents
Thread-Topic: [PATCH v3 1/2] btrfs: implement partial deletion of RAID stripe
 extents
Thread-Index: AQHbGmBpcs30+Qb4ZUSrcQZ0vkIQurJ+mCoA
Date: Wed, 9 Oct 2024 16:15:30 +0000
Message-ID: <98d4cc0f-4002-467f-ae15-9b14f43fd60a@wdc.com>
References: <20241009153032.23336-1-jth@kernel.org>
 <20241009153032.23336-2-jth@kernel.org>
In-Reply-To: <20241009153032.23336-2-jth@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB6446:EE_
x-ms-office365-filtering-correlation-id: a2d96107-3056-43e7-f9a3-08dce87d9852
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZDFzdjR6cVYxRlYwUnhrc0VORzF0M0xiMlJqN0xRQlFLc3ZhcFFZRGhiY3Rk?=
 =?utf-8?B?SE1CaFZNUUYzRXZZTndVL0R0WEVTdmwwY2tQanVwc2MvU1dFTUpBaGdKTWVG?=
 =?utf-8?B?RUJYYkN5WERWbU1DV2xocE9DUnh4MHc4aFhZRnZxNkprSFBNUENlTDB1TVdQ?=
 =?utf-8?B?QnEyWm9aMHhIa3dlTk9kZE1tcm54UE9RK3I3cmo1UkJ1RHllcEQzV0VJOEtM?=
 =?utf-8?B?VnNYNlR0OXY5bnJFRXlmRFpGa2FOelRpK2s1MEdyb1RESXlCb1VZZGJJcmJr?=
 =?utf-8?B?WXNaWG1GQ1dIYmR4eW4wOEF1UmZ4aXVsRFVmN1pSK3FLSFlXd2NySzZBVEM5?=
 =?utf-8?B?bDJrdU5CQ0xaR2wzK3hneGNMVUtIVmtmdUdVaXVNc2RHaHgxRzBLVTNLS0FZ?=
 =?utf-8?B?OVk3NWVXSDdRN25tdm1aZGdmSUJnZDJWcTdMVUswQkhWRDVwZzNkblp2YldU?=
 =?utf-8?B?OWRZQnlaWmIva2NUVG5Cc29zc1lKbWU1dks5TVNyZ3BCbTdIVFA2bTFCVDF2?=
 =?utf-8?B?VzFxcTVINFgwUXp4bEFyUEtTT3A1TkJIL3lhdEJlQkJmODVJT253eUN1SkR3?=
 =?utf-8?B?MGdNQzNlQ1hFQzJXRWVOSjR6a3h5VklPTGtZTlErL0lBZ1ZEM1ZvbXJyZzd0?=
 =?utf-8?B?elVNcHFMZG40UWdQSW1kMDJSM0szUkNTOGxkd2dCWHlzNUZvQSs0cTdqcU9Y?=
 =?utf-8?B?ZWJDVUU2RS81ZCtCRDhVNXZTdHZEb2xHd2J6SGk1eEh5d0E4cUoxcC9vaHdX?=
 =?utf-8?B?SjZPalVTa1d3cnZtRHpiN3JTMVNxNm9Ob2xFalVsR0xXcGRFN29NRWx6bCs4?=
 =?utf-8?B?aTU0ZE1pbmlnOVBRTEZlSTlGRzltU29Ea21weTg2bjJXU29OdHB2QmZhbTZz?=
 =?utf-8?B?YTBSUmhKSnRNQzJ3QWNzQ28rbE5kbEVMcWFPWFVyVzdJZHNJeHY4Qmc1b1Zy?=
 =?utf-8?B?T2FOc2dFeDMrWHdrdkZKS0xUbGV5YXAvVVhaamhZOWgyaHNrSnlnQ3RFUHd1?=
 =?utf-8?B?c2Z0MXNBOFN5YzBXSXpyRlB2U0NMMzFGZXh3RzViNGp3UTZwTG9xZkZEM0N6?=
 =?utf-8?B?WmNIMXo3YnhGdVFtR2hsSExKcUM2TkJ2cmJaMW4zU05UeFZpMVZiV3M2MVdK?=
 =?utf-8?B?SXIxcm05Z3dWTURNWGp0Z0FpOENJdks0SmIzem9pOFZDRTloTmpxM0xXTUtF?=
 =?utf-8?B?MXJKSnpTSGpTK2ViWG9jTnc4V09yTlNOS2g3dThGNDZvaE5Qei9hdm9MZW53?=
 =?utf-8?B?Vlk5T2psQ1U4cTVWblkxRlY4bU1RV3IxemVnSlBxTUpUTVpmWEFaUEZkWlJn?=
 =?utf-8?B?R1dHQUlHZGN6Mzc4TG1QMlNQc01hdDVXMklIMS9oNEtxK2VqdFBqSG5JWXQx?=
 =?utf-8?B?QlJ3eTVpdnRUOVNwb2hTZUpUQWpzbWdjdHhHdGxBYzVST2lEMEluVEloTE5r?=
 =?utf-8?B?QW5QR1ExMUZaVnNSRWhyL0VlNkZXQ2NpZmxGL3FPK2JkNTdDd01VclpNcFZi?=
 =?utf-8?B?cUVya0VneVJwVEFnUEREQnFIOUJSK0hYbzN0ODB2SU9kcG9FS3lUVTZHMGhu?=
 =?utf-8?B?endTNldqR2ZTdzE1SGJ2aTJiQm1lc0RXbG01aHkreElhallFaUtEYkZvY2x2?=
 =?utf-8?B?SVhjempud2d2cTJpMGNHWlJCMFZkU1JpM1JXZlpJZmhXelAvMFgvcjN1VnBm?=
 =?utf-8?B?bzRzNVcwZG9WQmJhc2hoVGZBdzRUSjdoNVVnb3BveFI2dHRudC9YYnc5Q1JQ?=
 =?utf-8?B?bzZLSWFvbnIxTUlpNW5PUnlNTnBDcnFUYzZnQXI1enlVYTNRUloyYkFDVjhi?=
 =?utf-8?B?a0sxbTZSVURpRnNzT1dOdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZzUrL3pLSmRteWVVWUFncjVjU1BrckN1U1QySExjQXJOc2J5aVFnYlpqdERa?=
 =?utf-8?B?TDg1MS9wbUMyODB2cWpFU1pkTXpvdEt2aWgvVDlTTUNGejdtZjBUNWxmUWhw?=
 =?utf-8?B?bXdyOXh3Qkk0SUhqYytSOWdNei9WVWtndEF3THoyTHk0UVF1cUNTUWE4dXF5?=
 =?utf-8?B?cEpYQWVnRDBhdmVuelQxOUdVVjdPZkdoQm0wN2dBUnFZVUpXWDREV1hLUzhz?=
 =?utf-8?B?R0t0SFVxcWYvaTdjRlZYQk5vdGxtenczMDg0MDAxTWxUQ0lWK0VTNkZQeFp3?=
 =?utf-8?B?SFpxWW8vUnFnZXMycjhaZUwxa2hmUUZBc2VXelhYT0FJMFZJZ3M4cWlJRjRQ?=
 =?utf-8?B?dXFyMnJTcWtnd1NpanZJaFBwak1DUEE1L1lmd1N1bE9SS2tHT1A1QUQyeVo1?=
 =?utf-8?B?ak5mNGJiMEV5S3RqWlFqb2I2V2cxeWFWbmJFQWdrQWttUndSZnVKNDUweUJz?=
 =?utf-8?B?ODJQK0t6Ly85U25FMktrSUEzWUluTnVhWDlzQ1BtVU1kcjdRbEhzQVVIcVl1?=
 =?utf-8?B?ZkhVcjNrc1ZUMGFRdHRVS2ZTRjBYRERRRXowTG9MOFhUb3ZOSFZRby9EbVJM?=
 =?utf-8?B?bjQzeXhvVmFLTGlvWVp2dWdrY1pLWklXS0ZRRXhwTFlNemRGbFhIZjJ6ZkdX?=
 =?utf-8?B?SG80cnk2SG5zWVQ4djRmTjArbkhmM0grVWpaMW12N2ZJejAxamhVMkJKc1FU?=
 =?utf-8?B?YTJ5c1BlK3hzd2pqeFR3eW5XLzJEWHVYSk5hYTh5R1pBVjIwbEpTS2RBL0E0?=
 =?utf-8?B?bEdiU0ZrT2FTNjlsWjlhZ3RUa253bDJQQ0FRSTgrUElmU2kvWlRIS3BsRW9B?=
 =?utf-8?B?Qlc1WTRBNG9PVkhYNVdLZEFDUFowZWtvOUJnRW1GT1FjcDV2Y1dLNVgrNDd1?=
 =?utf-8?B?TDRzV2QzSGJuakdGelVTcFZwTTVyUFhFV01WR3ZtZUFnWEF6MTlrZkNNdStt?=
 =?utf-8?B?Y3QzTmpLcnJEdGxYaDhjbUtZVk9hU3VuL1dTdlVVcUZFS1Y5N2RVSG9iaEhn?=
 =?utf-8?B?WkpTVUUvbHBTNUFxNDVXeTU1TlB2aGprSFlScXFJVzA3S1UzL01rU2VoWmtP?=
 =?utf-8?B?Q2VScnN5OTJlMGlnbGdaTkcxdWlVL1YrNFlZY2IyQkJDdVoweG9MR0VxYWRJ?=
 =?utf-8?B?eDkydzNUbnJHRVpXeW02REpISkRidWVXdU11UVU3Qk45dVprakgzcHBzcUNm?=
 =?utf-8?B?SEFreDFqZk9DN0FVaFYwd0cwU1BoWE84cXRxc3JZeW9MVEdQOTdnU3NadS9U?=
 =?utf-8?B?NWpmemNFYTd5ZkdERDNpRkpYSFJ3cmZaWnVEM3JwdmVIWUszeGNSOFBOdnZa?=
 =?utf-8?B?MTE2VkRtUHJOcmd6cGU0L0ZrU241Z0h3SEJ5UUJJb3A1dEtmN1NJUy9qenlo?=
 =?utf-8?B?MlVXaStPSVc4MzFEdkNoa0krdGZ3c2VmMm1lS3NSOTQ1U1dDQ1pmZzlTa0JV?=
 =?utf-8?B?VGRoTXNTdHhhRkdtVTFQdWNBUDhBV2Nnc1BvY0tlaExPemtxV2E3Nm5jOWF1?=
 =?utf-8?B?UklRTkd3RkdmaU5ad2wxWGJtZGZmODIyZjdvUGJwWmx2NzZOOEhaVzFIeUZR?=
 =?utf-8?B?Nk5RcWJrTllnMHlFTjZZSzVKVGh1UWtxNVYyMG1xL2tUSWRtSU8wLzJOVGtU?=
 =?utf-8?B?L0ZxVE1WVmdMN3pSSEFKUzJoSnpWbGorWWU1WFdkMW1oM2wzaGhIbFhXRnl1?=
 =?utf-8?B?d3RuTk44endaWTAvL3hqM3YxREdoNWRhN3RNNUJpa0ZzMXRoZGp3M3pmNklJ?=
 =?utf-8?B?cGhxWDVISVY1OXdKNkw2ekx0UmRnS04vcHEvbHZKUDBkc2J3MWpVcmtiUFVi?=
 =?utf-8?B?L3FabHpaTE9nNVdqZ0QyQmRnUy9FV2xKY0o3YXpwQk1CZE5vYm1BZU5lZU54?=
 =?utf-8?B?ZkxZOVJaZ0pDcmcrMUl0Q1ZreFhNQzJEMzJPS24yNG5wa29aaTR6SGl2cjlV?=
 =?utf-8?B?SklOVnhRL3V6TTZPNnY0RkNPbDh4cmk0VXNUZ05LZlJ0Y3hMVHBWSFVHMDBk?=
 =?utf-8?B?QmI1eTV6alhKYU9PbGwvVHdVMDNoTlZrYlZxQnR4cWRJV29pUVpRQUlRQVN3?=
 =?utf-8?B?eWw3aFVveVhsTEdmMFNKQ2xrVVdNMkhTckZwK2gyenZuZmw2ZmdhMW14T2VO?=
 =?utf-8?B?ZU5FUnpSUGxNb1QrbUhhdVJDS1Jla0NseU9zUFh0UG4vMEowcnlaL3kxWlky?=
 =?utf-8?B?S1ZMVndCZmVVLzNCMGpjUmVqOUdZR0JMbEkycFI0UXdtK295NFVwYWpFN1Ns?=
 =?utf-8?B?MGJSaTBLRmVId0ZnQlNsckJYZVB3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7CE759C397DDA942B112B2D3F78738FB@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VdFP0x8GxBpk5uT71fFywOuwHWnO4l45MnfwYrDhlkzXS4UsGlV0bwF+CMXJIQDO69MJ5VzdfnXBgoNPQYcMUE5YGpt0qG5+dAS+kL6lndPOnioVATJgiqc+wI7VrEhTCalRKPaUrbcWpJIeg1aTzp59ZFoBAgsl/17ucRpFigRLmQeoAJ8ZFpaYeyfWZoxXGxjOwgPOlkjNsEIyx8myLaEwEYvGM3p0W2+QRWnDNbFS224+KxlkbeMvpg8qqL8qbRMzrP0N0sPvqiojEPIzsEIdFJPj7gPEZbUYrvq1e77ronTAAVtpqPdIub6L3hGA64Tn7hFtfXkeiZTV8l+FOePPCblr+s5WLhhaYqLsoS8hCzIFN+CwMk367UwbNdL5L/ESylrE3hNJnZNsDpfDtmUNXqm6LYyESaguJcZuU06Wg6bZDDa17eh9Ias6X5YnKnpRYPz0oVcISNLhktYSHp/MpG+QcXEtRKu+diTnPZdk1pDTVgstdIXur6V+3aiYWn2sXiwXEMMnE4aGk9tg+oTu7W3U8sroG5jyLzjO4Rqg1pIngpyMWISn1zOA1MUgbY8S/Rs4c0pzDUe61CF3nzxth4/dY3WHWYC9SdAjPuX0THyGCAOk0cZ4wmDA0d0E
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2d96107-3056-43e7-f9a3-08dce87d9852
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2024 16:15:30.3314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FXmTxq+zkxah5pMAEISkNuP/NrWG0anuP1IuuvrKezc6waBXppzCehHdcf04ljnzQtSwhME6RWaXPdM895XyTyu4oQlGohZV0o4oJeP4hpk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6446

T24gMDkuMTAuMjQgMTc6MzIsIEpvaGFubmVzIFRodW1zaGlybiB3cm90ZToNCj4gQEAgLTQzLDkg
KzkxLDggQEAgaW50IGJ0cmZzX2RlbGV0ZV9yYWlkX2V4dGVudChzdHJ1Y3QgYnRyZnNfdHJhbnNf
aGFuZGxlICp0cmFucywgdTY0IHN0YXJ0LCB1NjQgbGUNCj4gICAJCQlicmVhazsNCj4gICAJCWlm
IChyZXQgPiAwKSB7DQo+ICAgCQkJcmV0ID0gMDsNCj4gLQkJCWlmIChwYXRoLT5zbG90c1swXSA9
PSAwKQ0KPiAtCQkJCWJyZWFrOw0KPiAtCQkJcGF0aC0+c2xvdHNbMF0tLTsNCj4gKwkJCWlmIChw
YXRoLT5zbG90c1swXSA+IDApDQo+ICsJCQkJcGF0aC0+c2xvdHNbMF0tLTsNCj4gICAJCX0NCj4g
ICANCj4gICAJCWxlYWYgPSBwYXRoLT5ub2Rlc1swXTsNCg0KVGhhdCBwYXJ0IGlzIHdyb25nLCB3
aWxsIHNlbmQgYSB2NCBzaG9ydGx5Lg0K

