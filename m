Return-Path: <linux-btrfs+bounces-18578-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9478FC2CC45
	for <lists+linux-btrfs@lfdr.de>; Mon, 03 Nov 2025 16:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E09AA4EA1AA
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Nov 2025 15:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27555319600;
	Mon,  3 Nov 2025 15:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DH/VsfEe";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="D3AB/mYj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974A330C610;
	Mon,  3 Nov 2025 15:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762183042; cv=fail; b=ZJBxR0D+G+iNrCGD7bkoo6L3jci8I7QRieD9HADtUfAfh4hqhgzbRR8jMyPSwHz531RPhS9zTISSIQiw0TCGwIINt1C1oHYsSmolKBAWp7RfE8SxQimq1IC+9hLLci5OMcCliHUD54CAQ0O0uWGxZYPGipMMz8uHmzvndNl74rQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762183042; c=relaxed/simple;
	bh=QCZZoFZP3K9dy2y+spFNkSXrP7Ypw8a41s/XtBGPNKo=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TdFyi7c1Ji7GkLMAMZlRk4/QHe/7PSciH+by8kDG/JEUvaoaPi6eUFtQ3rINsWAR0bBansaKdcZupIEHhOE2u8QqE8xTk4JI0shDMXEJGYgwF0kTz5vhjhHFV/fSeoFHQa/EbZ8pEmcUTPuiRL/fSkxcqJ9KSS2ue0k2Snzb/2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=DH/VsfEe; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=D3AB/mYj; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1762183040; x=1793719040;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=QCZZoFZP3K9dy2y+spFNkSXrP7Ypw8a41s/XtBGPNKo=;
  b=DH/VsfEeFqJJwhIqO3vf2gau+DqEimc36Quce1JB6qhaKBsdEQqc1t78
   SyHozvBeNGlzWnM0XY+Go4H+lkxb+CWRKcZ8d9tYnjOpCi5/Pl/PsF9sp
   sIiEJx3fF+PurOqQJHJeYaOshLwdmcTcAV7DR0y1XR/Brx/Gn24JhSP8D
   2/DwyQWT2Z0NQhB6IVrZRiiMpglKX9ao78dcGil4650UdrYk2B0EqEFOD
   emYRxj1voUnR+XShehSkGOKdalxj7DhpiFJ/fBmMpBOVf1V3sjiNKcPGw
   sYHek60Zmw0Z1z0ze4lda5Xn+E0zyudYmhDQXbZsI5PlyN3zS3tgupK2l
   w==;
X-CSE-ConnectionGUID: RT4dOXReS+Ob6EJ1LcSKjQ==
X-CSE-MsgGUID: 1UgjouBYQZSl6OAHuYgvRQ==
X-IronPort-AV: E=Sophos;i="6.19,276,1754928000"; 
   d="scan'208";a="131395800"
Received: from mail-westus3azon11010037.outbound.protection.outlook.com (HELO PH7PR06CU001.outbound.protection.outlook.com) ([52.101.201.37])
  by ob1.hgst.iphmx.com with ESMTP; 03 Nov 2025 23:17:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JWu3pIkAsPQrFzF7IjCqndjMybZdiggdT0dtVHjRqQ61DDOiYJLBJICsHIcZUQjhL95wGOEi+ZsySuv8p51cy7duPJS0XhDQ4wjFSjUeHg/zptrtBuS2kIHDOaud8JvEklWm3IJGQXO8fUUDlUoY3mZ2P6yvXMrwiZXOgHIGtn6cZI6vHO8aiKqdBur/ekwe4D4t2SodHUrG9dTiO+09PEqhv7GM2k2/xVKoosOl7BRAbSHe1Wr3eHuvfubjvMQF9zl7uj0pdcNiUcaXEPP+XJwMK44cUSi3C/g2uOUlGyb++M2wqCx76L9My1eqkzz1A/hS5zfcH4uh9iP7HSBgPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QCZZoFZP3K9dy2y+spFNkSXrP7Ypw8a41s/XtBGPNKo=;
 b=bIHK+1GGLxnG6jUjRjO0oiKIdi8DQ67mWGa3fHxzioONoB06Z37wJ1QSbrcmjj9lYchAkHapCMbIFXkbdhP04xRFiwAwC0DApv60hVfitM3jpkQ7oZUEkF/ZcWlqsroIQAKy0Aqbpj6+8qMxtk9hrmWvqhxjocsVvzuscV6KncijAqdrdZ820oe0Fqb6MFkerMjkqx74KAt7P+1bWbHKsmkH1LSRk/yqMDbz9EOZU6kOBlb7000s9AVd/gpfFzsoj0xjvWPZK1HdMxV3zX6KnsbhmLa+EO3/wRB2mM4w6BuguV6ryQZD/k3NWQh6RWMe7cbA8j198YvRIIbJzSsk+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QCZZoFZP3K9dy2y+spFNkSXrP7Ypw8a41s/XtBGPNKo=;
 b=D3AB/mYjom4fMZzORjebZR5UPTJqVr/oyyOShJovrb2tFBbsZiPR89xrDqSL0+jzAOLazjKyF1tjJEw1h+yHSQQAUvH4HbWV9LJCW3MVnlSJm1HnXFIpbgASaTGWiuuLv5C9n7DYWW4WqrFlsIgOKbrDEcgLdWHwV8AEAz9njrY=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by SJ0PR04MB7312.namprd04.prod.outlook.com (2603:10b6:a03:297::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 15:17:16 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%3]) with mapi id 15.20.9275.013; Mon, 3 Nov 2025
 15:17:16 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Keith
 Busch <keith.busch@wdc.com>, hch <hch@lst.de>, "dm-devel@lists.linux.dev"
	<dm-devel@lists.linux.dev>, Mike Snitzer <snitzer@kernel.org>, Mikulas
 Patocka <mpatocka@redhat.com>, "Martin K . Petersen"
	<martin.petersen@oracle.com>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>, "linux-xfs@vger.kernel.org"
	<linux-xfs@vger.kernel.org>, Carlos Maiolino <cem@kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, David Sterba
	<dsterba@suse.com>
Subject: Re: [PATCH v2 11/15] block: introduce BLKREPORTZONESV2 ioctl
Thread-Topic: [PATCH v2 11/15] block: introduce BLKREPORTZONESV2 ioctl
Thread-Index: AQHcTMcxviMgxsdh+kOUBgn3533ol7ThEFCA
Date: Mon, 3 Nov 2025 15:17:16 +0000
Message-ID: <982ed7d8-e818-4d9c-a734-64ab8b21a7e3@wdc.com>
References: <20251103133123.645038-1-dlemoal@kernel.org>
 <20251103133123.645038-12-dlemoal@kernel.org>
In-Reply-To: <20251103133123.645038-12-dlemoal@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|SJ0PR04MB7312:EE_
x-ms-office365-filtering-correlation-id: 3515d2e9-1208-423b-9b1f-08de1aec12b2
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|10070799003|19092799006|921020|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?N1BHNDZpS3RLVThSSi9ia2N0SDNpcG5rTkJVWitjdk5peXV6YVZIdHBqdU14?=
 =?utf-8?B?V0NWOFNwWFZpR2FZYVdlaXdzTUNiZ2RQRURXOUtnV3FURDJMVS96dmpyRGRM?=
 =?utf-8?B?UHVlbUtyWEl6V0pHSU5OSTVkUjdsaG1XNEJUMkEvN0RCOEIvMHo0c0lTSzhh?=
 =?utf-8?B?YnhXbkdENC9hc3UrRDQyMEZwQUZQdno2OEFuMjQrTjBCVEdiMEcxcmFaaVNY?=
 =?utf-8?B?WUlvckpDRUcxNDVPUVI5ZXk0S0FBSlRCcEVTK1pyKytzN3VBSHFlMGU4S2RW?=
 =?utf-8?B?VEUzRHMvaXRYQitnZExmMGROZkF3T3FUQU5BME55K1RYbDBxVmlva3NKWUhY?=
 =?utf-8?B?Ykh3QWNHTTRhWmNXd2RxeFFVL21TaEx5bmVQMm43RE1vMk1UZFMrOGFNUjZI?=
 =?utf-8?B?cXFpYndGbjY1Mk1OM0tDRjNoTDRkKytkZFJkTmtkZDg1L3BIV3RpVUdUcXBK?=
 =?utf-8?B?ZWt5cmF3b1hSa2hmclRyY1UvQ1hVaEtBMlpyc1VQRk1aaW0wam5jSldpRStv?=
 =?utf-8?B?NmxBN0Z0T2FBTWlIYWxhZS9BaW9aMEZ4eGZWVmxFTVlzVmU1ZFVFdzBBMFVE?=
 =?utf-8?B?aEI1eHhIaEJCeXZrTjc4N0ZiSFlEM29hcmttSHZBRzNsSWxOajNqdWVkT0E5?=
 =?utf-8?B?d0lQeS9iU0JHNVJsN2wrOGsrY25TN0xVT21lKzNVNEp3RHAwQ25YaFl0TVJv?=
 =?utf-8?B?VmVoWTVXNjVVOTNZNklLZUJkckNyY3lwTWJNMjFtM3BIbXVmdG0xMHRjeExk?=
 =?utf-8?B?ckRzVFVWMGhRMGg5ZldUaFJVRFp0RmFjOXhBQjlIVjZzUTVGYjRabmlwSzJr?=
 =?utf-8?B?aDVqVEFleUJiRVpFUmZRR2VDWFRiem1PMHRIVmJHYVdjWW5ydGR5NW8ySVB0?=
 =?utf-8?B?aVlycEc2dCtsNVJTbldVVk85OHZpL0dyTG94NzlEV1VNSkttSURsWWl2ckt2?=
 =?utf-8?B?TXJGTnZzakM0aEdlNjlyMklicm9RTFNWb3lGUXZmbVVnT2xScVdSdUpDY3Fo?=
 =?utf-8?B?OFdJU1RUM1RYNEhYWjVqV0h5U0dSbDFGc1ozcTRLeWxKb0tWYXpaZmp3RUti?=
 =?utf-8?B?b2dISitZUVZpNDA4NXRtT1ZsTEJ4eEtwUmlLUDFXQm55cGkrRGc0WXFvclFa?=
 =?utf-8?B?eWpwQWFDUWFtRlUzZzJUdE0wSXVsSGZLTWwwKzJGS0FKLzlqd1ZLUWxjdkNm?=
 =?utf-8?B?K0F4akxKNnpDOWJ6MGVRbmxhRTUya3UybmgyVmhDbHQxSVZTRmFQcDhzOThz?=
 =?utf-8?B?aElzQUdVZk0rVDRXc0kra1MwclBMUHBTbnVCR2NrOXlhWWdqTm1CSTVKV1h0?=
 =?utf-8?B?RVNWeGhURnBPaWYxb2MxbCt0dlJTdWpRdDlhL3VXR1llSitINVRuY0FDbHl0?=
 =?utf-8?B?dnRzWUxFcVArQThOaVhBS1QycXF1THZkMUJuZExNc0xkRDI1SjFNVXh0Z09I?=
 =?utf-8?B?QmhPU0I4V2Yzb2JDMTVvSTFaRmdlL0E0SGxkaStsOEJyRmlLTWFOcDdsbTIv?=
 =?utf-8?B?ajVaTjRlTzNIVW1qeExqcm56dHRQMGdDU2c2bWIzdkVTYXVhQlhZVEVlRWE5?=
 =?utf-8?B?TWRRZzhUQnlJZXJkWGNSb0FWNG4vZ2RnbklwRFE3NDQwbXVkOHZSZ2ZSc0lW?=
 =?utf-8?B?T1E2MkdpRHJKSEZwQzhYTjdqbHhMUE1iZmIzZ2tKbTUyMXJWSUZsN1o5dG5X?=
 =?utf-8?B?cW9OQVZiR1hleVplSG9xbG9WaVB2N2RGOThOc21heTNUbklVc1d5N2NyUWJn?=
 =?utf-8?B?MEFGMy9vVUw0VGtiZUJYYzQ3UzN0bkpDblBXZXJBUUc3ak9EcXFIcDdwK09t?=
 =?utf-8?B?L1VrVXcrbXBlVWRpMWFPdDhiYkhidzZtTlZ2SUFFdUhseG94N2tYcG9hYUpl?=
 =?utf-8?B?VVcvcXVyMkQ2SVdpNnNxVHhTOHNrdXkzcXozTyszK1k5WlZEY3Z2RFZWZjV1?=
 =?utf-8?B?V0pwWXJqblhtcGpEaGxoaTI0Tk9WbGlRd2lFQXYyT0p4cFBERUxRSGJiNzQv?=
 =?utf-8?B?QUFoSHVSMnJDbGRyamFLSklpcUxEdExOVTRXdFZtekRkbGt0M3J5cGU1L3RS?=
 =?utf-8?B?aWM4NThSMW9tSWxaZ1hydnFRVGNVNVJVcnQwZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(10070799003)(19092799006)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YTBJTmVjZ05jV3JKQzVXU3FLbEVuc3BkNFZKanp2TkRTRkN4dEJxcnYvL2ta?=
 =?utf-8?B?OStraFFBbmV3UHBTZzVlV3hUWUkyQnNReHVMaWpVeXg5VUdYTld4eDByRXlH?=
 =?utf-8?B?c082SUZ5cXRxaHJKb1ZTZVdTL3FvOHlYYm8rK2x2OTV4VTFIMzNDYUhUNW5O?=
 =?utf-8?B?Y2s2SENMNk1xQ1BUTWxJeXNsa09jQ0xzaEZRZlRCT3dVbURqaFl5Q1RWc2lq?=
 =?utf-8?B?WDdTK0VTcUVDb2xONHVZQ3JsQ2JOazk5OTd4eE9pY2dxdmhTQzRpWUVROVkx?=
 =?utf-8?B?RkFHT2FkZ0xvRU05ZFhVOTRkY0xFNjFBRWZ2NFpFV08xQi8xSGx5ZWkwUXRN?=
 =?utf-8?B?cHdJMUs1aVI2aTExeUpDY0doNG13U2hsazR2NlJOVXhOb0lmVGZIMEVwdVQv?=
 =?utf-8?B?YU1GZ0xPcmxuREhhdkxJbDNHMFNBZ2hqTXlQVDZlQ1YvcTZkaHFaS3Q5MnQx?=
 =?utf-8?B?Z01CejJKbzZVK2xxaXo5OXY1V3dqOGh0T0lDQ08yYlJSbmovSU5LRHBoei9r?=
 =?utf-8?B?aXYvMDBBbzVmS1gzNk5NV2w3OU1HZEhUTDNBV25UVTZzc3JqKzNLZFBMMmVV?=
 =?utf-8?B?V2ZQbG4wMDFSQmJyRWkrc3NpakFWMTJyTzZIM3h4M25lZ2dCZUN4V2swek1s?=
 =?utf-8?B?ZWdqbUhkazdzdEVZWEtaQjZpRmhhaHJidXV3RHZrRWVYT2lFbTJwRVoxdHhx?=
 =?utf-8?B?UjlQVTFjaytFck4wY3M5MFczeUhWU2ZTUVp2amowSDAyTDZ2NFZvR0JhR0Rv?=
 =?utf-8?B?bWhLQW1wRkxWOHlnTitQeUJDWlNiRGxFNTFtMVRvSUl6c3U5K0hqOVorb056?=
 =?utf-8?B?TjQrWEZSTGlsUXNxUnpSNHVqaGVMdWVGZmlyL1pjdnBqQS9sM2RKcnFjMDcr?=
 =?utf-8?B?SDZMdE8vT3YwY1VURW1HcWorR21tZjNVbFZURWtCVWFya21rYzdSY2daMnJJ?=
 =?utf-8?B?ZmhISVhOTXpBS2srNldRdkJQdzFDUjc2dWpsSWdPeUtwVndNZ3ZLTW0vQlB4?=
 =?utf-8?B?cTZyU0NxSmlVdG4zMzFENUhOUlZ1OG5DMmJ6ZWZIL0dyRlVHbEt1VWRxVG1Q?=
 =?utf-8?B?OFhHTHU0b0YweW1SbjdWczJpbmNuWlNSS01hYVYrWXIvaTRad0xuMW5iTkZH?=
 =?utf-8?B?VXBkaUVBNVhzK2hRQ1FCbjgwbzRtRWFCK0VZWHpKUmVJR1AzaGFnaUd6b09D?=
 =?utf-8?B?VXJPR3dmYkE0ODFoNFV3Qko2WWF1RU1tbndNd3ZYQU4xL00xNHU1SmpHR05k?=
 =?utf-8?B?UXdjTklBckxkcjFuT1JBb2d1NE9pQk9kazRPZzFySEs0V29PVWowbHlkWVU0?=
 =?utf-8?B?Mm5UN1c2Nm9McW0yNC9CU0UydWRWUHo3TkhIUlRJaTExNEkwSEo3SjlweVIr?=
 =?utf-8?B?WU80V1ErVEZqUWhUUVFoNDZ3NExra1lsYlA3V1JZSHh5TTgvc2FqWnV2bkNh?=
 =?utf-8?B?ZzZ1cy9aMlBpWWZmZVpBd2I2TVRjVjRxU2Z6M2tLSXJ1czk5YnB2andnMUpX?=
 =?utf-8?B?aVA2cmpqK3cwM0dqQWNEeldiL3dtTTNEQ1FidzhyYUd2TmtmeHovblYxck45?=
 =?utf-8?B?blpLbElTUWdTTm94M1lqYnpFczdQd1NsTUpXcXdTemhOTVdVT2g0V2YzVVBD?=
 =?utf-8?B?cVVoMW5RL1pHTE01MHpIRWd6M0lnU3RTUndWOERrSGl1Q0dtTGhJeGg4NFYr?=
 =?utf-8?B?MUlKN1h2MTFzK0hpRWpjRzVpbDVvR3lVZkg3bGl1RXA4aFJoUGV6Z1FYb01Y?=
 =?utf-8?B?RGdtbHVoUWgzRmU1bVlTKy9mUzU5MjZTNE5Wc25uc1hsOEQ3bG1uRzFqYWVa?=
 =?utf-8?B?NjVFWktHTlRuOEtxOE0xVk5wZjNLZklFYmxzVVIyTHFjWmJRV1FpYklYcEhB?=
 =?utf-8?B?QXRNcVE0OHhFem5oVlZhWGxRcVZiZWtCK0hnNmUwbHVzQXNFd1ZtZURzeHEr?=
 =?utf-8?B?cmEzc2xTZWJ3SjBsa3krN1hNQWNEUVFOYUJOdktiaHQyRExnaFJ6dmVMNkRI?=
 =?utf-8?B?dUFVM3VnQldSdzVOYm80ZE1nRmdVbTU1RlVSeUlrNWNmRnIrbEdRZmpWUzQ2?=
 =?utf-8?B?ZGEwWm1sUWdUUnRnS0MxTEdNeFRDOUdrcDY0VUxJeVdMeGZxTkVaT0NlaWlG?=
 =?utf-8?B?UDY0cVJMUGtGVGc2L3QraFJITjBDeDVIMWYyOUhjMlh5Tk5meFlkLzdxdmdK?=
 =?utf-8?B?MWRRRkV4TU5rWVZZOXZKZkdNQWpMSHFXK3ZuRWNmbER6L0M5ZGVaZXAzU1F1?=
 =?utf-8?B?YVk5OFdEY0JvL3BaLzJrSm9HMUhRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5929271E347E8F4485510E6935DD6055@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vq86Ee78Dvz4JM/b6L8TfFvKfs0ZJB/Gs/l03hcdUNgdr59Xkyk7TspFUaNSoT8oTLDiY3znIr/k3HDy1kktODF9EhME1EJdrOVNmO94NbfX1Iv1mSynsnruNngMGIWPMFNoftGqKJuh2IzYarXwMIJ3hOG1abWODmZQI+KFtkzDcbmi5akeVag88PAkTIUjHuHlLReICZH6sZOK60B8RoUJa+Cnwint6sOnqhG3YGKHbSqP9MCu1gBUQLpA2eTlKfhO7iHEhfstvNnxDpR9cwFphGKxbMHxZ6mzNcQaiOaOW00cmRj8kN0iH5SZ+dKPGLTvgkNaTE0KrGdZwTZfN1F7CCR26mk/L6C/JoSqQppBKFCVhRbu/YGB3sYV1++XRqiltG28m3AdVS2dZxb3JmLSxaoImQtUi7FY8uMq+ANwgiOT34i+5//2tWHG0LjTVjxGqra2Oz5zILLvk4VxNZTD8wzQC8vQO3Qj87D5gF5LyN0fb3a2D978hPcpYobyAtrTuD7DT3ezg5TuJ75n3ajYcqbl4xDC3zj/XuBPmV1D3q6LoeMYLY1IjYwgYvrU8LJW/5XnSTsuEsyDG3n4EUpH+DRlOWYj05OUU4VokWt5IxM1kzJMU5iLvQgOxvH6
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3515d2e9-1208-423b-9b1f-08de1aec12b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2025 15:17:16.1454
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OM/SegE4K067SD36zMz6XdwT/SotVoQfQmC9ahk0T1xs/SfCBIIZslwjx+VBJ6eCGr/Yv/5dd382+KU18oxtVPxoxIBjryCbynUb1NRMN+w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7312

T24gMTEvMy8yNSAyOjM4IFBNLCBEYW1pZW4gTGUgTW9hbCB3cm90ZToNCj4gSW50cm9kdWNlIHRo
ZSBuZXcgQkxLUkVQT1JUWk9ORVNWMiBpb2N0bCBjb21tYW5kIHRvIGFsbG93IHVzZXINCj4gYXBw
bGljYXRpb25zIGFjY2VzcyB0byB0aGUgZmFzdCB6b25lIHJlcG9ydCBpbXBsZW1lbnRlZCBieQ0K
PiBibGtkZXZfcmVwb3J0X3pvbmVzX2NhY2hlZCgpLiBUaGlzIG5ldyBpb2N0bCBpcyBkZWZpbmVk
IGFzIG51bWJlciAxNDINCj4gYW5kIGlzIGRvY3VtZW50ZWQgaW4gaW5jbHVkZS91YXBpL2xpbnV4
L2ZzLmguDQo+DQo+IFVubGlrZSB0aGUgZXhpc3RpbmcgQkxLUkVQT1JUWk9ORVMgaW9jdGwsIHRo
aXMgbmV3IGlvY3RsIHVzZXMgdGhlIGZsYWdzDQo+IGZpZWxkIG9mIHN0cnVjdCBibGtfem9uZV9y
ZXBvcnQgYWxzbyBhcyBhbiBpbnB1dC4gSWYgdGhlIHVzZXIgc2V0cyB0aGUNCj4gQkxLX1pPTkVf
UkVQX0NBQ0hFRCBmbGFnIGFzIGFuIGlucHV0LCB0aGVuIGJsa2Rldl9yZXBvcnRfem9uZXNfY2Fj
aGVkKCkNCj4gaXMgdXNlZCB0byBnZW5lcmF0ZSB0aGUgem9uZSByZXBvcnQgdXNpbmcgY2FjaGVk
IHpvbmUgaW5mb3JtYXRpb24uIElmDQo+IHRoaXMgZmxhZyBpcyBub3Qgc2V0LCB0aGVuIEJMS1JF
UE9SVFpPTkVTVjIgYmVoYXZlcyBpbiB0aGUgc2FtZSBtYW5uZXINCj4gYXMgQkxLUkVQT1JUWk9O
RVMgYW5kIHRoZSB6b25lIHJlcG9ydCBpcyBnZW5lcmF0ZWQgYnkgYWNjZXNzaW5nIHRoZQ0KPiB6
b25lZCBkZXZpY2UuDQoNCg0KSXMgdGhlcmUgYSBkb3duc2lkZSB0byBhbHdheXMgZG8gdGhlIGNh
Y2hpbmc/IEEuay5hIGRvIHdlIG5lZWQgdGhlIG5ldyANCmlvY3RsIG9yIGNhbiB3ZSBrZWVwIHVz
aW5nIHRoZSBvbGQgb25lIGFuZCBjYWNoZSB0aGUgcmVwb3J0IHpvbmVzIHJlcGx5Pw0KDQo=

