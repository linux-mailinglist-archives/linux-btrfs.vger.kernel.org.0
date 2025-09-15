Return-Path: <linux-btrfs+bounces-16814-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CEA1B5727A
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Sep 2025 10:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BA6517E3C3
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Sep 2025 08:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E622E7622;
	Mon, 15 Sep 2025 08:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NScFlHwq";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="XDhMC42a"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AE92D5410
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Sep 2025 08:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757923490; cv=fail; b=MHQdv9KzFj3BuGQCZJAhi8hvInP8ZddeEEAkEo23BRgPNeFpf2W2ms3tOBMIYlQtOFEVrm5QmHguSw1k5h39hb8TQI0jtEUKWpmRdq0AUf97Fc5V8Xw+M92ibXcV6Chdli+L7o3NLR/DONPI0kwXN5wNW070wPZV4W8fv/auAGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757923490; c=relaxed/simple;
	bh=w5ghvzurnVS5QpisTScSx2iWfn9objF+WABb5oTm5yg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PlTq6OzDTXuTT0tY+PgFZghTuMD67X7niUo13O2/th82Craxy81LcUH+wOhzw9psnsVXdf9JIN1rmpWjwSwtco35MEnyUpmozxczfbv5OfRZRYIshh4oN3AN+j+2qicMsP0+ViUAd7QD+SFmFRRHBfgftPfGkoC9J29RdfPaIT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=NScFlHwq; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=XDhMC42a; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1757923488; x=1789459488;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=w5ghvzurnVS5QpisTScSx2iWfn9objF+WABb5oTm5yg=;
  b=NScFlHwqv0F2NIrH7M3zoF/bHUC5oE2twBoWBHDcNOdXOnH9HAqDZBOp
   geuFCz0SjNZ/WGBAaUbIBPh3txNRz6siZyumYtzmwVOsT1Q1SsLEL0OZw
   N4Bjg6VkWw/TcqUmAPb/72kLjm5DZnrJCpKfa/PZZhSQd4czSTmiU3F0u
   oJ11NPiG5xGzOmmoWOngb2xMjVVkorey9nX+qhEIsKyGLQZeffK6svDy4
   mU4LtZWnQw+MH6tcCwOKhmtOcA3UPA1wOA/QJ4TT9ox76SGzB78FM5xMG
   MLTDUCs2Q84y5rE4H5IAiTsBI7SnSYDtvB0Xq3zcfBM5sHMtkn0w5WKEJ
   Q==;
X-CSE-ConnectionGUID: RzU1f8XITU2GyHs6saG7VA==
X-CSE-MsgGUID: odhQfzQ2QDGWHV8D1ob6Hg==
X-IronPort-AV: E=Sophos;i="6.18,265,1751212800"; 
   d="scan'208";a="120030429"
Received: from mail-westcentralusazon11013019.outbound.protection.outlook.com (HELO CY3PR05CU001.outbound.protection.outlook.com) ([40.93.201.19])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2025 16:04:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nrEYTG71gQA/rfLkl7CjNrPzb3YRWCJW3205JmePpCTsy6Kwv1yzvDqRBlh011BpgV+oRfTD8QM4Tb5qhcIlRaFw0+lq/pQw3CVeprD0745VhkQLlyGJ1zJaEEy2CbjlTUevpsg3oyLWv4fpHy2E4NIYEqHFS45BBWCysXXN3y3Wy2440GBH5cKDsroJmYKxeQOiIWt73VAam5Ojmxy1JoVD9j92o4XxEkxpHSMjKpyLG6aLqL6KEI1giZkdLh+8tZAGuWI3V36pKF55chKyql5utj22rqumcjdBQVV2AD/H5BZzV/4y+uOXLEcdXmARrqNTCH0yikLm6djufOKfTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w5ghvzurnVS5QpisTScSx2iWfn9objF+WABb5oTm5yg=;
 b=m0cR2LM6qzTpTejQeszHCMwlJrs+733JxbmT0C/TSVUSqqDTvFjiV9FjDxMT1ckXemLI+a9GcNgTRwS3fS1YUuM8AoLS0rgVrU8CerScBPguNej0s71p1MXu/YemCnd5kC/XFmJsGDtxYkTrTs46UHroPcDNUYD29ZMJSHHSqzgYXTi8/fwRRtpobRUynglsMyi2DQF/MPjpCsUaN98rl1tY9/R+EOQHPqCL5H7eB4qZMV88VKsALtvjIyPUvie4HC7Kj0/Zj7ymZRFDUzA9TLRQ6o15hRgEgddvrcPjpinI7Z9MBsHi2JlXSz3LEoUJKm0DGpEAPwXb7tbIzOAPYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5ghvzurnVS5QpisTScSx2iWfn9objF+WABb5oTm5yg=;
 b=XDhMC42aHGWLd8WatXCsMdqYwGR4Yexgf+9jBpfRZRjcmeBKaJY6wXTB4NMSS2ZsoVoS96nVgK3t76OwdH6IU7LKASPAYPLiIo/vnfd/nQadbKtmYw2V7VonSANg8DzJqNgJGxIykD+Q76La6H5gUn8uS37J2N1/ApnzvbAoKuo=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BL0PR04MB6609.namprd04.prod.outlook.com (2603:10b6:208:1cd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Mon, 15 Sep
 2025 08:04:40 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 08:04:40 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: HAN Yuwei <hrx@bupt.moe>, linux-btrfs <linux-btrfs@vger.kernel.org>,
	Naohiro Aota <Naohiro.Aota@wdc.com>, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: performance issue when using zoned.
Thread-Topic: performance issue when using zoned.
Thread-Index: AQHcJWG554cLgRNI6kq+V/MRpm0fY7ST5AAA
Date: Mon, 15 Sep 2025 08:04:40 +0000
Message-ID: <4560397d-4ef4-4182-a888-ef2266a89a70@wdc.com>
References: <tencent_694B88D85481319043E0CE14@qq.com>
In-Reply-To: <tencent_694B88D85481319043E0CE14@qq.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BL0PR04MB6609:EE_
x-ms-office365-filtering-correlation-id: 436d116e-534d-4260-5e6d-08ddf42e8581
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|366016|19092799006|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?VSsyUVlzY01IeDU2N3BjVG1jYjJodDhLdXZLSFh1TUFsSWZrc1EvVE1VNkQv?=
 =?utf-8?B?UytHV0tQUlQrU3RMMUtaZ1VYYXlsdlYzeTBwOFc1SGZlNHVFRUJDeEJMYllT?=
 =?utf-8?B?SmpVQzRVNHhTeDY3VDU4ZHpHSDJWcWlzdEVuRmg0Q2EvSndHcitDTnBpWlY1?=
 =?utf-8?B?OElCY2xENVllOHlid0ZYSmNDbDU2UTlGR1RaT1pqM2pYeEJYaDI3YUN1QzNy?=
 =?utf-8?B?QS94bGMxeStYbURXelpoZmsvSlBBYnRhZ1kxUER2dkxETWZrS25VRlJxdUFN?=
 =?utf-8?B?T0k1U01CbXBDTDlQVDI2ZS8vY0tvMytyMFcya2dFc3dqVjBCWTZZemJBU3JU?=
 =?utf-8?B?cGhJaEVBWW9PUDdHZzYyZVhDb1JKYjBqd0M3ZzNYcEEzcHVJVHY2UmxITFJR?=
 =?utf-8?B?cU5jYkNSbDV0NXpOLzhZVGkyUnBlVHVvbzZHcTNneVQ3YXhPR1JpMGFQWDR4?=
 =?utf-8?B?SHpod0VIc2RYOUFLelBnckExV0YyYU5LQ0x4U3lBVzFWOHpGbFI0akxRUU1z?=
 =?utf-8?B?RC96ODJwSW5Rd2lLcFlLbXRwK2E0VjFQSWsySmJaYzN6SFpMeWpDTVdqcDF0?=
 =?utf-8?B?dVNRN1JJS25lRkFwcEpqN08zMHZKaHljTDhuY0M2SXlJa2JPYktHeU9FbXQ4?=
 =?utf-8?B?eS8rd29wemI3SUxmbnNpNkc2THJNVkNKcDEvVmFhdkR1QS9Sb3VxeFlpaVFp?=
 =?utf-8?B?TFpnRmhnVXFrQTF0UStwT1FGby8zWFlWTHd2Mk1IbjNUS3NzV2ZHNTUvbnNN?=
 =?utf-8?B?N09mN05aSmthbE1zVzJCa3pWN3dLNUI0MmxLNklmNEd0b2dLUDVJeFlEQndC?=
 =?utf-8?B?aW5FZjg1Z0dLSW0rYlZFVC85aHlOcXFOWTY3ZUY2VW1vdDBxV3I2Z0RLeXpN?=
 =?utf-8?B?Y09rYzNoUEdGM3MvQUdVMlhIQ2pOM3IrelB6Q053aUw3a2YwMlFxaTlJQXdY?=
 =?utf-8?B?VGtyMGIzaFNwUmRrM2xrVzd4R3g1Y1VWTU0xK0U1aU8zc2FURlN1TFNmMHds?=
 =?utf-8?B?SWRSSkVGQm9JSDIwcktrdTBzbnFxZjVmVDhNWFkwUDgxeVN6K21xRTI0cUVJ?=
 =?utf-8?B?RU1TTU5VekJ5M0lGWXRiajVFcDA3M1pxd1gzL3V0a1RENFBGN211UlFVQWJJ?=
 =?utf-8?B?dlZiMktzeUI0NUMrNk5CVkIzYXM4Tk9pYzhuNVJlS2o3RWg0ditTQkdZaWNJ?=
 =?utf-8?B?N3RUV21DT1lhdjZGaFdNbWhrMzZBVVJPM0M5RWNCQWhjcnl1bDg0T1hyczZE?=
 =?utf-8?B?eWluZWtzRW9jVjJzaTFyd05GQlFqcG9BZ1ZLUVdPa1EwZTUyN2NlRURrRWNM?=
 =?utf-8?B?YTIreTErbzF3Tlg1dTBFb0VremVGeEtVL3R5VTRDWDhoblU2YlkzSlVpNWZS?=
 =?utf-8?B?VUdDTXl2WW9SYk5Xa3diY2lVQU5NOGlLcEN3U1pDbmFQOWpGQU1ORG52dGQz?=
 =?utf-8?B?Qk1ZenJQdnI3a0FCR2RnY01icnJWTmNsT1JEekxLbUVrU3lkSW45c2xjQ3ov?=
 =?utf-8?B?RFVHTW9jbWVwNFYvc2dxZENPZnpMelF2TDEvTUo5MlRvQk5VSEMzWmswZTVP?=
 =?utf-8?B?ZHBrejdMNjk4cGF6Z3krbGs5NUpFT0dlZ2NMTEdsU29NKzJSWDdNUGc3Qnl2?=
 =?utf-8?B?ejViTUMyOXRNTWNtZTVDYzYyRExoN0pJMFZQM1hVd2FQelo1N3ZURUhvbURX?=
 =?utf-8?B?VzdXYTBER25IWEVGUG1nYUs2cEllbHgyZHBpdnkzL3dsUnY5V1V1cHdTai9w?=
 =?utf-8?B?TUt2d0ZWN0xRM2FwUEJCTkFCaWM1MytWbzN6U0ZFUmFuS2RxUWJXZEZ3M1Y0?=
 =?utf-8?B?Q2IxcVU2SHZmZUNIWGVVUENxbENBQzFmR2RERXE5dWs3ZlhXcmVWYnlpcnUr?=
 =?utf-8?B?NlJWQURlbkpxV0ExYk4wS2RBWnFXeUQwQ2QrbkM1QzR0eGV2cWNOZHZuQ3U2?=
 =?utf-8?B?NjZ6NlpmczBHdFlZV0ZQY1Q5dzcyU21EYzRWMHJMTFJkNTdQZWJRek5pL0RP?=
 =?utf-8?B?Q3BsdmEzemlRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(19092799006)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aGkwcitNVDhOQXVHSmtueElESEU3MC9pdVlrZktqK3dDRzY4cUViVlU0VFdI?=
 =?utf-8?B?clZzdjMxdkpHTWhzbUpxN3ZobGtzcFc3c0FOaGpuOEY0Wm9lY2cwd1cwdnNk?=
 =?utf-8?B?aUg0NGNBc0lQVkc1dGQ0MllNS0NLb1BQcGkxMVlhS20vM29GRngyaHNkd0Zy?=
 =?utf-8?B?eFZJa3FKV3Y1RVdYNVFZZTd4aFIrQjN1b1Q4QTA5VUJRSmdmY21FQU9vSU9h?=
 =?utf-8?B?cTZ2RkRLejlPZTNlcjlnZW9CdVBDcTIrTHdZZDJMZjVoZjdTRE9QWUxhRlll?=
 =?utf-8?B?YWtsZlUwWDlNYVRBTUdiU1ZyK1dmTFF5QXhoNTNHZzlNdGJ2RDZKU240Wkdj?=
 =?utf-8?B?ZUF5ZDZOZDVIWlVUaTAvMFU4ZjFBWWErbUNteWVnTGJ1eHR4V1JXc1pYNGtE?=
 =?utf-8?B?SWl4R3VOZGFKZjM1ayt2eU9OM3FaTlpzZVdRRVlMMzlWU01yTDBRb1c0UThK?=
 =?utf-8?B?MEtROEg1T1pNa09CZWZHdnZmeW5qdTJ5d1QwQ1VhV0Mvcm8wdjNuSFpQU0FQ?=
 =?utf-8?B?TzRVcmtETkhJR25kTit1MjVCQTByTWkwVGhjcGlBeXJ6ZUprU2E4NHNCU0V2?=
 =?utf-8?B?a0s2OTVKYVJ0cjJGaGNBYzBZQnorTlZEblBibGtMQUNDTTJSWmZaNFd1VDIy?=
 =?utf-8?B?VEVRMkY0SXZIQXVvcjU2a2RkN1FGOUhzazQyR1NWeVI0a2xDbkt4WmtUdC93?=
 =?utf-8?B?ZW1Da3plYjFrNEMxS1hTWlhRcHZQYXNhOFNlazBCalZLbExMM0tFSDd4RFZN?=
 =?utf-8?B?SE5wZ282ZmJCU3dvdW9xUmN1SHV3WW9CSkcweWFhZCtCSFRtRVE0dXNsMjE1?=
 =?utf-8?B?cCtmQkRNT2RYdTA0R1crM3QzKzR3V01hQzlLcm9oSkFLYk1ieEZQTnpVdmVq?=
 =?utf-8?B?VDlEMVMyUXdRcUo4dVRwL2VjdzVZK2pFM3NIVUQrTXdDSTEvRG1TRERSZTIz?=
 =?utf-8?B?MWNrZUpMeHlmeVdWUllXMTBMbFVwaDhGczlmQXVHVm5nQ09TUW90aWtLRlJw?=
 =?utf-8?B?UTRnTFIyOUF6S2VPZmVIYkk3eEFhMndxOWs1OFdGZWRmdHpVUzdzbkdmNERa?=
 =?utf-8?B?dEkwNG9kRGI1MDBIVzQ5MXl4VWI5RHhVMzNuMkZwNjdEb0RLR3N5bTJ5Q1Uv?=
 =?utf-8?B?cG5DWFRkQ0hNSVdxaGdLaDVJdnllZW1kNEF3SkNIeXhzS1pVZ0UxRGhQeGk2?=
 =?utf-8?B?dTVsWXY2MThCMWNYWG51Mkp5VnB6TDRIUHJkRTRMMlZ0Tm40aDUxeWlBVEVB?=
 =?utf-8?B?M3U4NWxRZGRFTWVTdHNLUUlzMmxNRnZiYjBLMFh5ZVUwOWNCNFRoZ2lBRzZI?=
 =?utf-8?B?amJuMHRkRFFrZjlxN0YxQTdEeDl0WjNXQkdPaEV5QkZLYjhVY2xienAxT2xx?=
 =?utf-8?B?b3FoVkhrT3VKTXE1d2dCRjNiM1lXR3FQM2xDcWQ0dVM2KzR0TEovb01GaXhD?=
 =?utf-8?B?ZFV6TThPUWw3TTE5c3pMYzNPMUNGUVJTdjN0ZDZubVNwdlNIWDZDMkZPUTFD?=
 =?utf-8?B?dWpKRVNNNDhBS1FXMnZtWWk0cFYxTS93eWh4d3ZxeUlTck1abDZSWitXdkEv?=
 =?utf-8?B?QTB1ai9MVUNVMy82OWZMMFlRblZSOXZKckZhTUQwZ3IxY0loQzQvMjJoZEFy?=
 =?utf-8?B?OEMycGdYMEM4QTJTQ1d4SDVoNEphOXdEbC9NYnIrRjErUGFWN3JhRUo4K2pm?=
 =?utf-8?B?RFpVQTlUenROYjkvS2Zkclhpd1VZVkZ1eVU1WlJGeUV1eDhGVXVReVBaMWFJ?=
 =?utf-8?B?a0RSdTZqRTRZZ1FzTHRWWEZpMC80dHJwczhIbkFwc0NLcXFkWk5VOC9ZWVZi?=
 =?utf-8?B?eXhad1RDMkFGKzdSS0N3WFhmcTVhbEs3QzN6dVppaHN2cElYSm1KeHc4bFBI?=
 =?utf-8?B?Y01haCtJenFTQnpNeU1FbGJyVFJXWWxkUjRUSXJYbU5VUmI0QlM1d0Rid1VK?=
 =?utf-8?B?ckRHNGs4NkhmWjFyZEpSL0ltdHhjbXpPVGlrems5akxIbFJHbmkwcEpFNXNl?=
 =?utf-8?B?QTZEN1lGM2JZcmp2aGNGaW13Sk50a3BDUGZvZHMrMFRaVGhsTmRiWXh4Nm9U?=
 =?utf-8?B?aDd5Nng5U01iUlRXcWJrV2l6ZVU2OFIzRW1kOUlUZkxjZExPMXZ3VVZiOWhY?=
 =?utf-8?B?RnNVU1AreUEyVFB0cU5DTUdpRWNPZDd5a3oycGhzK1B5blNVT2FJTFRlcWhy?=
 =?utf-8?B?UmNMNHpzZzRrZDc3Z2pYbjI4R0ZQKzZxNXlta2ZQUnUreSs5eUZlR0lkMXUr?=
 =?utf-8?B?U0p6UlFqN2ROMTJud1ptcitzOGhRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <65462DB94F74C243BCE64FB6AA4AC66B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iJ5U/gkU0/rYSOCCWqiEVhh0ontHlfBeLvxKbXvA6Plv/pGtVNOSEjN21OkAbUopI5/Dj/p2Inxx5fQTauYxAKuQW6aU4MAI/O9Nh0WjMNVv/zCnZVQSoLWFB+BHhAeEjPqHZ3XKc2BKDpzhGWv5zarU009C7+occK7LLiTXLnTqejeaw0ZY4sJ6503Pdjzb0rRd6ImmWG7xjuNnzY4NFxfpUxe/QCtGDnADcdaln0PjEv4QGAiqeLcG0SzaU9NoXOKSJ5eULol1jNPdBd3QR7FUGKdMX0K4qaadAyRqAiqjp9nQrqN/qbvC617CmZAPwcc0rzd4Asj6uKbpIuSjCVOyqRMFHeYJETDht/U4orNlDl30uP3DWPQ0TBZsU+ilJWldwHN696nWmrfH2ClE4JsPcbv6ZJ66NL8LIzqe5TjhGVR7fil/RL6j14uZBntOxP1vmo8oi2dfYZ/e1Lm6Fo0nYKpMhRUI76uF9NAGIG4N97oe+1QRd07OgSsAHKPE2o6blV5ICxZFQjRYyoQSxk+0b7GRyRenA8q83iqbfNjsm4qbevOPcKdPIRmJBzRHdm6o7pbaY0REeNv/vpoGVAJNisvLnCfFxqM3t0vh18btmrY/x2eg8q2dg/W/yj40
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 436d116e-534d-4260-5e6d-08ddf42e8581
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2025 08:04:40.1491
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JBAwAIMRZezRXEPsf5UUQ9fSXk5cud4gLf3/z49JB1dwrxgKLa4zVXkEfp7ARp3NyPOHdIT5Xq0Lajb83099tcyDGf8q4qG7a2NCcVL3udU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB6609

T24gOS8xNC8yNSAxMjoyNCBQTSwgSEFOIFl1d2VpIHdyb3RlOg0KPiBIaSwNCj4gSSBhbSBleHBl
cmllbmNpbmcgcGVyZm9ybWFuY2UgaXNzdWUgd2hlbiBjb3B5aW5nIGJpZyBmaWxlcyB0byB6b25l
ZCBidHJmcyB2b2x1bWUuDQo+IFdoZW4gdXNpbmcgY3AgLXIgZm9yIGNvcHkgZmlsZXMsIGl0IGFj
aGlldmVkIGFib3V0IH4zNU1CL3Mgc3BlZWQuDQo+IEkgd29uZGVyIGlzIHRoZXJlIGFueSB0b29s
cyBvciB0ZWNobmlxdWVzIEkgY2FuIHVzZSB0byBwZXJmIGJ0cmZzLg0KPg0KPiBUaGVyZSBpcyBt
eSBidHJmcyB2b2x1bWU6DQo+IE92ZXJhbGw6DQo+ICAgICAgRGV2aWNlIHNpemU6ICAgICAgICAg
ICAgICAgICAgMTIuNzNUaUINCj4gICAgICBEZXZpY2UgYWxsb2NhdGVkOiAgICAgICAgICAgICAx
MS4xMVRpQg0KPiAgICAgIERldmljZSB1bmFsbG9jYXRlZDogICAgICAgICAgICAxLjYyVGlCDQo+
ICAgICAgRGV2aWNlIG1pc3Npbmc6ICAgICAgICAgICAgICAgICAgMC4wMEINCj4gICAgICBEZXZp
Y2Ugc2xhY2s6ICAgICAgICAgICAgICAgICAgICAwLjAwQg0KPiAgICAgIERldmljZSB6b25lIHVu
dXNhYmxlOiAgICAgICAgICA5Ljk2R2lCDQo+ICAgICAgRGV2aWNlIHpvbmUgc2l6ZTogICAgICAg
ICAgICAyNTYuMDBNaUINCj4gICAgICBVc2VkOiAgICAgICAgICAgICAgICAgICAgICAgICAxMS4w
OFRpQg0KPiAgICAgIEZyZWUgKGVzdGltYXRlZCk6ICAgICAgICAgICAgICAxLjYzVGlCICAgICAg
KG1pbjogODQxLjQ0R2lCKQ0KPiAgICAgIEZyZWUgKHN0YXRmcywgZGYpOiAgICAgICAgICAgICAx
LjYzVGlCDQo+ICAgICAgRGF0YSByYXRpbzogICAgICAgICAgICAgICAgICAgICAgIDEuMDANCj4g
ICAgICBNZXRhZGF0YSByYXRpbzogICAgICAgICAgICAgICAgICAgMi4wMA0KPiAgICAgIEdsb2Jh
bCByZXNlcnZlOiAgICAgICAgICAgICAgNTEyLjAwTWlCICAgICAgKHVzZWQ6IDE2LjAwS2lCKQ0K
PiAgICAgIE11bHRpcGxlIHByb2ZpbGVzOiAgICAgICAgICAgICAgICAgIG5vDQo+DQo+IERhdGEs
c2luZ2xlOiBTaXplOjExLjA3VGlCLCBVc2VkOjExLjA2VGlCICg5OS44OSUpDQo+ICAgICAvZGV2
L3NkYyAgICAgICAxMS4wN1RpQg0KPg0KPiBNZXRhZGF0YSxEVVA6IFNpemU6MjMuMDBHaUIsIFVz
ZWQ6MTMuMzFHaUIgKDU3Ljg3JSkNCj4gICAgIC9kZXYvc2RjICAgICAgIDQ2LjUwR2lCDQo+DQo+
IFN5c3RlbSxEVVA6IFNpemU6MjU2LjAwTWlCLCBVc2VkOjQuNjJNaUIgKDEuODElKQ0KPiAgICAg
L2Rldi9zZGMgICAgICA1MTIuMDBNaUINCj4NCj4gVW5hbGxvY2F0ZWQ6DQo+ICAgICAvZGV2L3Nk
YyAgICAgICAgMS42MlRpQg0KPg0KDQpPbiB0b3Agb2YgUXUncyBhbnN3ZXIsIGNhbiB5b3UgcGxl
YXNlIHNoYXJlIHlvdXIga2VybmVsIHZlcnNpb24/DQpXZSd2ZSBtYWRlIHNvbWUgcGVyZm9ybWFu
Y2UgcmVsYXRlZCBmaXhlcyBpbiByZWNlbnQga2VybmVscy4NCg0KVGhhbmtzIHlvdSB2ZXJ5IG11
Y2gsDQogwqDCoMKgIEpvaGFubmVzDQo=

