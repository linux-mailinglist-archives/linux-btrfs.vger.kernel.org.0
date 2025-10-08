Return-Path: <linux-btrfs+bounces-17523-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB9EBC36EF
	for <lists+linux-btrfs@lfdr.de>; Wed, 08 Oct 2025 08:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 694AC4E2659
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Oct 2025 06:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5305E2E266A;
	Wed,  8 Oct 2025 06:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UYgGBhHS";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="djy/LPh6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C864F296BD6
	for <linux-btrfs@vger.kernel.org>; Wed,  8 Oct 2025 06:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759903617; cv=fail; b=oXREO5u6ecPnXRpv2Hwk5ClYlxW4slIdQqNVQbJ5VNkonkY24e2BAO5uNlEyy4xU5WxTwM6Irqb21CKa7PUezLs1HQuclcfscakR0v5pO3IdH8srevSpRl22s0Wa2cmoqfD/ZgD38BSdoT5eXQkV2FlFEWj3Y73PMnwXky4B83c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759903617; c=relaxed/simple;
	bh=Yv3t1T0Ooy57adl0LuRc3DhFXOgsCa81Uum1vaUSrdE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fbXVJ9/1KuCmAOiYi2U85tOLV3BGXxvtN4b/oacALR5MKv7bwlzP+Tlw+M1XT1IXKfBy8CiXehm/GprexC0CdC08HInz509pdzUA2GaQOrd/czM+JGa5w+veezXP4Bh5ZvIxYMoMURJRqK8Oun2Ab3Ga/dOUoQd048ElfOyEiwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=UYgGBhHS; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=djy/LPh6; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1759903615; x=1791439615;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Yv3t1T0Ooy57adl0LuRc3DhFXOgsCa81Uum1vaUSrdE=;
  b=UYgGBhHSZ8Yn1VyFOJ3I4dmhff7Gg0xsrOaVoc5kw9W0IOxSBKXAPWoT
   oJj1EFDn3B/NI/UJHWRDvf5xsPDcYt1oHe5IDbA6BGaqEdnHX73ZFk8X0
   h0qA7aZ3+Qld3uzO4RMzwW+kkvHK5H58INUkqRT7KOx58uAIE81UbYCx8
   N74hbCfmbDIXTLpRFUekig/e8TyAxede3uU/dGmk/W0gdNoItYMldWuOq
   s+TbHRFWnIw/R1zAaGGpofORqw5OoIhDYDBdl3s8KpQT6HaPwm8OCTLwX
   HeMYY+0H9eVMfOhNlkvfrUmSex/NvFYMkS9A108vzn9hTmaaDw7Da60n8
   w==;
X-CSE-ConnectionGUID: 3a9kVG0WQ2yEnt2AoUa2tg==
X-CSE-MsgGUID: 0HFbKBc0Rr626qHFiGKz6w==
X-IronPort-AV: E=Sophos;i="6.18,323,1751212800"; 
   d="scan'208";a="132812214"
Received: from mail-westcentralusazon11013053.outbound.protection.outlook.com (HELO CY3PR05CU001.outbound.protection.outlook.com) ([40.93.201.53])
  by ob1.hgst.iphmx.com with ESMTP; 08 Oct 2025 14:06:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZOtRsfCHGguQTv/KPF10PBiFQxcqP77guPdmb2gSmG55QCzWoQb9ZEh+m+ErLtlwhY/EGTEOtfKLSdqJxgCuv8ooDv5ZLVXEzDx+IIqKSEVCEfzFzHkgeEiwbp1ZCo7YkxnhHWzPa5bf1xKcD0kgDeF8c93rgzsMpvs+zPogslGIk0AI46DPtEJiQKqrCUScJGkisv/8KRAOVCAkqvp4L6IzNaa9e80JIujMtk8NtHLSGeXO7hTJGYszrqufWBCZsxdvOHihbGDH0MxTbkHor2t3buv5/Cq01qaR6ebd9dxLUWLX2q3QsRpuoM40eViRCpFzC/ClpUR8PDxOpKCgVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yv3t1T0Ooy57adl0LuRc3DhFXOgsCa81Uum1vaUSrdE=;
 b=IQNl4NOr5kC5sAscYpQLiMIt4YWwdv2PmYmTl+byqZ+YWp5qGNGM1L8oYZCx+57WaSCux3zkxDIcRzkCPvKWIp4XQrht9pYZq6GababE9DLVjdLj1Pgqy1AgVRqzL9pILxp0O0By2OXzRqYdIuzvS2LlgwxCnRo1SQ4I0uVI7MPnJD4RWVbfNpvlaubZALc22xnKbQEkn/PHFfKmR1FMsPeSHLUHX8X+KiHcDvUCOlT1YAZkg0XE4ngqHTvqj1iipyDCWnUy3rbly4eQmaYhvqLIMBeTAlLseBCaPinWfVoLS1txQCnBdThypu6dUzgmwW0acaasdtp6UUNk53xifw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yv3t1T0Ooy57adl0LuRc3DhFXOgsCa81Uum1vaUSrdE=;
 b=djy/LPh67CfYk7m0Tjaf22CLOTDz9ZSjMcnuvWcDbELTya/sQr9Fhbt8DZef1tqyFaEvWDy2qNmU9jXSedj1eYW5UyMblsUvI2uxPwnN3T40LWHuxIErSNFHYssT4SI1W+yINAlP75sCej/Qf1LLG1WcNmcN/wKA5wkBOfauJn0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DS0PR04MB9438.namprd04.prod.outlook.com (2603:10b6:8:1ff::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Wed, 8 Oct
 2025 06:06:52 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.9203.007; Wed, 8 Oct 2025
 06:06:52 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "hch@infradead.org" <hch@infradead.org>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: zbd/009 (btrfs on zone gaps) fail on current Linus tree
Thread-Topic: zbd/009 (btrfs on zone gaps) fail on current Linus tree
Thread-Index: AQHcN1KuGCX0HNOhIkayN1jmYD5sCrS2iOkAgAE6w4CAAAEogA==
Date: Wed, 8 Oct 2025 06:06:52 +0000
Message-ID: <c5b15471-5a8a-4e0b-a7d5-ad682785b581@wdc.com>
References: <aOSxbkdrEFMSMn5O@infradead.org>
 <e0640c83-e600-410e-bbcc-4885852389c2@wdc.com>
 <aOX-g97die1kbVY7@infradead.org>
In-Reply-To: <aOX-g97die1kbVY7@infradead.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DS0PR04MB9438:EE_
x-ms-office365-filtering-correlation-id: 81c50a05-98f8-452c-95cf-08de0630e029
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|1800799024|10070799003|366016|38070700021|7053199007;
x-microsoft-antispam-message-info:
 =?utf-8?B?a2l3VGhZZHlONkU1MU56TGIzTk9PUElMVjdCb3QxMFNETC9kS082NFhrZFVn?=
 =?utf-8?B?TDNBTHpCYWNkQ0NtYnhEMjFvK2VLVFdxc3h4SmJoNnNPTkx0dVJuOGRSbnVZ?=
 =?utf-8?B?ZEU0aGZKZnFHV2JIc0h4cnlmeDNHWXhnelYwTStxQWVqSmFLdUcySm9WKzRY?=
 =?utf-8?B?QjZQT0tqUzA5N2tDSk1MdENOcjhiMExSRW9uWlBlVVZJS0orejMxQi9Yb04y?=
 =?utf-8?B?eHp4WFBWNFd3RzhINEJ0UzNvWnlNbmMyWjZFenR3YzdtdGl5MXBUR2doUDZy?=
 =?utf-8?B?YUZMY1RWTCsxNHhLcGZPOFdteEdkZEQrT3NlOXBWcFFtY0htTWxPOU1UajYw?=
 =?utf-8?B?K2JQcC8xcXpuSWRBWFJkSUYvNWczRWFCeGRaU21JMHBWU2ZmdEdtR283UnJO?=
 =?utf-8?B?Yi93ejJuMm1SN05KdzNLVEZnYXNTVDBXaEJjQTlGVmV2dmZ2cHIzUW5CMTk4?=
 =?utf-8?B?VnRVWXl3c0cxVzkyS0trYm5iQjhtZ2tHbVU1WS9lOURPSTdVSVdxNEhHZmQv?=
 =?utf-8?B?clVoMzA1TFVIMHpvTjVwOEZtRyswMmtYemNyV1Z2SUJ5MGJnSlRKbDZrS1VR?=
 =?utf-8?B?bHdpN01qQVRBeWZnTGNkZ0tsL2tReE5yc3BObUNYQjczZmRWRklPL05FSEx3?=
 =?utf-8?B?R3daQTA0cjRZUVc3SUt6V29teGdKdGs5QUdwOForVkY5M3lCdU5XSkdEbTF4?=
 =?utf-8?B?NEgzWXdkLzRhSWhoaC82WkxETlpnSEtCdFplUFFxS3dTdmc1Z0RBVGF4WE9Z?=
 =?utf-8?B?dVFkejVNR3B2K3cvTHdER1Y4RkZUWEV2RytYZ3BGcGw5Nm1iWXpEdzlOckJW?=
 =?utf-8?B?eTVLRHNhOVlQa29SdjVEcUc4TDVxM0RWaGIyVjduRWFadmZUcFNsNWRJdEVh?=
 =?utf-8?B?UGRURDdTWXNYWlFXRUJLL3VGZVlIZmhwSEJOYXljekhKNlZBNnIzTG15Y21M?=
 =?utf-8?B?Y1JQZzNNbDJqakZNN1VtMHZUckxTamdZM0VlRzNGZXg2SUU4Yzh5M1I0dGg0?=
 =?utf-8?B?cUtka2x5Ukg0S2VXMDFML3VQbmd5YnZBTUxYTzdaU1dwUUVxdks0M3l1RlBo?=
 =?utf-8?B?Q3VpbHZCTFdwZHNXUWVNM1pLbnFxT0dyU2FsRlptTndaR0RhUm5JRkViaHB0?=
 =?utf-8?B?dUhuTlU5cWI2eG9TdllBVUFJaGh1Q3FhWWZXZmkyVkk3cGFod05xVTZ2U3BJ?=
 =?utf-8?B?YXNHclZuUVhiSGgvZnJhN2o5ZzFzOGxNdndmR05NMk1STVBubUJBZkdHbFVv?=
 =?utf-8?B?SlYwME53aWd2NXFLRXJ6eWlOaFJ3U2JlYm1WeDBaWkh6UlhFMzB5dDY0TTNp?=
 =?utf-8?B?eGkrZHZqclNrbjhHMVJuZWVlNC9tekZWTWd6U1F2dnMwd1ZJcmtjTU1oN3dS?=
 =?utf-8?B?UnJSd2xFN09ZbmRWSUdUdmhSZ205bkVsZmdMSGszdlRmK05TU25hUEZIZld1?=
 =?utf-8?B?ZGRaMUZZdVkybHd3OUVGOVFvVTMvVXU4RGl6VlhxemRuMlRLM2JCQlRZREs1?=
 =?utf-8?B?anBsL3lsNm9JNGVpcnM1dmVGdG53L0RrU2pkWjllWWdsS1N1a2xHQmtHL2xF?=
 =?utf-8?B?VnNLTjZlSTdqZmt2Sm1GN2ZtTlFDdEpFRUZNdExZTmUvem9oRVAwSm1HVVlB?=
 =?utf-8?B?ZGtKTDlmTmJzR05XL2pjMVJlclU1YzJHcmtqREpGZUhNUFBUc3pMMGhVYlAz?=
 =?utf-8?B?SWVnZFdVZkg4RnV2NlVNYzZNSUpZLy83aGcrdHNQb05wRXB0dXN3MHUxM2VM?=
 =?utf-8?B?WnlXNXovUW4yV21tOHE0RXlXRzFLMlplYWNvVXd5YTBIUjI3TjYxY1JxOUxO?=
 =?utf-8?B?akVNNGwyUnV1NHJ4Z0l0N2FXK2xlYnB5SWUwZ3MwTlhTWTVjT0tDcHdCb1BT?=
 =?utf-8?B?b3ViYWJabWV2c0ZKd0lOb1M1dERVWk83Y2FnUUVZdDI3TkRQZnRaWVNYenZY?=
 =?utf-8?B?ZGVoQmdjQVVGUytoNGRLMkJGL0FKWDVncHpER29ETFQ5bWRUbXRGaFVhQkZK?=
 =?utf-8?B?cExLclF3ZjVLRzVxTUUwR1NndGdmM2pHb3E4NHV5OUFHTVdZOXFVd1EzdnhC?=
 =?utf-8?Q?EqIIvZ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(1800799024)(10070799003)(366016)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RTFMTU4xQkUwR1hrRjU5UUJTRjJNWnVrQ29TQmpvSDBzZ0dDV2toaml0dkgx?=
 =?utf-8?B?emF5LzhXSlZnYW1TMDVTbUFCcGRjRnpva01UYUFkSGpNeWpNNE9paWhyNnpV?=
 =?utf-8?B?WDhwRVVnYnJZcWVWclNmcTAvYXNxOXZCb3ZEQnlOcVlnMlN6dWJpRWgzd2FC?=
 =?utf-8?B?STBKZEVieFJ2QzBNWS9Ib3djb1dDVUs1bTFkTllEUHNvRkFhUHRZYk9PL0RB?=
 =?utf-8?B?SFZYNnlVM21sV2VteG85UU1ZMlY2R2paVmZmYzNVQlkrSWtMeEwwdndWeW0x?=
 =?utf-8?B?aTZOeEl0Y0Q0NkJxTXVGNDFJMEVKak95Q0Ivb2tTYzdSNWFZVFdLNmE4L2lT?=
 =?utf-8?B?c29jWVVzOTRkQmt6Wjh6cWVHVHA1Q0pKQTc2dEhVaVFFWHMzbVpUdjNIR0c3?=
 =?utf-8?B?Nk9MTDM0S2xNYTRJRC9iclpJV2IwdVRiQjNvQnRZU1ZzbENZS3RIbU12Mm54?=
 =?utf-8?B?SU8zSU5nYlk5MVEyT1QwYVN6ZjI0M1RqRklXWHJyaDNxVmw0dlJ2WTNQNEgv?=
 =?utf-8?B?UW9QZFE0RVF1SkJ6T0VhRVpyTWRubzJPYU55Ri8xU095ektSLzE2cHdqdnhF?=
 =?utf-8?B?V0RYd3Z5dnhhekpZUzNxVGdCSDQydDM4TVNSYUkxaVk1ekYrRXVJWGxkL2dQ?=
 =?utf-8?B?QURIeUkzK2lXdndwRzdnQnVUNkRlN3Z3YUNxclI0L3pVRXJkSk9WQ25NT2U3?=
 =?utf-8?B?Y1Z0UEFMUFV3bTdoOXIrVnFuK1RXeE1XQmhUb3RPNGRQTGhlZDBoUngwTkpr?=
 =?utf-8?B?SmxsYUlLSkMvd2l5aytRYjNCejhwR3hpdzRwU1lVQUt1RmRoMHVDdXB4cERz?=
 =?utf-8?B?M3g2d0M4c04ydEZBeFZRZGEwMS9abUw0ZHRkSE56WWVnSk5sVU1yQ1lNUFQ0?=
 =?utf-8?B?ampvZWV5OElJTXdOdXhEQjJYZVp0cmNGMzhTMCtGc2hKeUZFNGVnMHIzTHlC?=
 =?utf-8?B?VTZ1V0IzWWpidVp2QURSaDM1RjNtM0UvWDdyN2dMUVdTQXJ1SGZ6YTFqRk4y?=
 =?utf-8?B?Y1ZDaDZDVXBKUk5STFpsaHoyUHI4Yll3aWVKYmwvN0l3U2MzbFdHdEg3Wlg3?=
 =?utf-8?B?R3dRY01vRU5SeDlzMm95cG15a01nbHJKNTJQRXdhMm8xRnlhUmJUdzkyZTBS?=
 =?utf-8?B?T2UzR0txRE01b0lXYlFZZ0FETlh3MkdUTERTdmZ4bjVUdHJBdlkyNFJyUVJj?=
 =?utf-8?B?QXR5SUh5N243c1B0eUdRd0JGeS9kRUtTbHlaNGxtNFkyMjZqYWNDYnNodUJl?=
 =?utf-8?B?aVpsbEc4TUorZVRpK2YzcS9oVE1kN2Z2a2IxbVFtTVRqSkdVcDVVWUxWbXA4?=
 =?utf-8?B?bkp6NUNCOEcwSDhINXY2Nlp5NlNBTlVPRE96Tm5vaWo1Vlpza2wxanlWa2R1?=
 =?utf-8?B?U09zYVV5MjByV01qVXNvb2ltMTJ1bjVDUzI2bVhsVElmZEt1SnZ3eGN0ZExH?=
 =?utf-8?B?MUpJc2ZzUjNlZTljTEhKN1ZhUmdmTW9iVGlKbE93T1k2M1gxZUR6NzJFNVpN?=
 =?utf-8?B?S25URnYzelY2YWd6cUExNzlUd1E3aFZzVWhjRmh4UkZzRDRKZ0RpQlZBaGZv?=
 =?utf-8?B?aTN3REdCbWIzTDliMFB1dDdXODFwdW5XcXArR3lsNW1vcDFTOVYwTm8yTEJL?=
 =?utf-8?B?aCtsaEhoeTdEdFBrRzE3b3dQdmdaK0prbVlBd3lNTUhseXRhSC9ENkx2bllG?=
 =?utf-8?B?d1BVNlRTdjVLNnMycVIwcS9LUTVMNTFJMjc4OHFsL1c4V2lWN1crcCtnRjhH?=
 =?utf-8?B?OFVsTGM2L2pVZS8vdTd4eE1va1RuaU01TkYxN2pCck5wUGpWRVlFWmlXMEJD?=
 =?utf-8?B?OW10ZW01TExMQUdzRjhjUmhtMUhNZUdoK1BsNlJYWWF5bnR0TlZlUGVPS1ll?=
 =?utf-8?B?SWlheXRtTWUrcm5LUXhQS1Q3OVMzU013T3pvclFvYkFoTWgzN2tKdXVRT1Rq?=
 =?utf-8?B?V0pGakFXK2ZaTnBORkNCa2pjWEY3YjNJeXpuT281OUg4ekJvcm1TR0YzWWFZ?=
 =?utf-8?B?MHVJRWg3Z0JLTmEvd1l6MVhSd0YvZTNYOEkwNmRsU0lQVTU4ZmtXYzlCazJT?=
 =?utf-8?B?eVMrQUFmdHp5U2twa0h1cWVyTm1DMnVJMHBLUjI2NndxUXpzR3pZbUJxY3Yz?=
 =?utf-8?B?VFJvYXYvQTM3SDF2NnRpRmdQV2VINHk2VTVWR20rcThQWEdhMU1DS05LalFj?=
 =?utf-8?B?WUtXMzdyemNkM1Yzdkl5aEdyQmE5NlhvZnVOQWFUYmpTYWppQVNZeXVMeERq?=
 =?utf-8?B?K1UyWDBBa2lNVmZaY2locFB2RXBRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C47C154E6CDECF41B1D34C2855888A88@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PJfI5vuaB2gaV8EhPFg+tjR/mLEfmIUpi8hk/9sc8KkE1LghxhRNVt0d7yv41iaYE3V8BaZLzvDT3lGloLy+d3HE9Xb6q4KRs5Dy5JRij4KATW+2IrbAc/O9h4cEuUTyxwjefga3NxIn5mRkGnp9YugMRR41JjcMo6UbCCn1db41sjbSue966LDfzCE2wcxMCNmHzL8WQLBmcT19WnrR1EVWSvhLfmDr4izRNT0gZosmiCPdeZkUgnvsPp868cV1l/z8AeeWckle2wNknA16uT/NxTmcP4hmIh/+nI/FVqeWJJpHYndpQpCpghB6q8+BGp+6Mpv854/RU7AH5eG66BsnKwvYg3/tYd8k2S450h+SgkER/qJvoIuyZLJZnZ1DvCLS7744O3NdmJnYCneF4XCpjiBq0DhBNYq/bvxaEMhEpiqjR4+nPvIaFiQ5QZXInWXOAcliAZwhRosfIwRwWGD5oN9FDrXrxYJfFdhd1Ce5DdSITMpS1UWnUvJvDTiNeuGV6Xepc01f2lkUkhS6cZ24YSt+LXIr9pkABg453agoqd91cSr4ZQZN5uIQavsVQa1I92Ps0FYRc1tiSzZ3SInM7EbVQQ5K+iBbIAlSYOHzU/4qm15WZCRnBMXa/cXl
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81c50a05-98f8-452c-95cf-08de0630e029
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2025 06:06:52.1931
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JygtE3zN5TXBq7sNscltWfC3HRNSg2MMed7iz3KmM+frGHtdv/rorDMWkrqJs9NuKZDBANQQ56YxI0gffyce8p2Fv0XaBZC1auklYmQ1wNw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR04MB9438

T24gMTAvOC8yNSA4OjAyIEFNLCBoY2hAaW5mcmFkZWFkLm9yZyB3cm90ZToNCj4gT24gVHVlLCBP
Y3QgMDcsIDIwMjUgYXQgMTE6MTY6MDhBTSArMDAwMCwgSm9oYW5uZXMgVGh1bXNoaXJuIHdyb3Rl
Og0KPj4gaG1tIGhvdyByZXByb2R1Y2libGUgaXMgaXQgb24geW91ciBzaWRlPyBJIGNhbm5vdCBy
ZXByb2R1Y2UgaXQgKHlldCkNCj4gMTAwJSBvdmVyIGFib3V0IGEgZG96ZW4gcnVucywgYSBmZXcg
b2YgdGhvc2UgaW5jbHVkaW5nIHVucmVsYXRlZA0KPiBwYXRjaGVzLg0KPg0KPiBNeSBrZXJuZWwg
LmNvbmZpZyBhbmQgcWVtdSBjb21tYW5kIGxpbmUgYXJlIGF0dGFjaGVkLg0KPg0KT0sgSSdsbCBn
aXZlIGl0IGEgc2hvdC4gRm9yIG15IGNvbmZpZyArIHFlbXUgaXQgc3Vydml2ZWQgMjUwIHJ1bnMg
b2YgDQp6YmQvMDA5IHllc3RlcmRheSB3aXRob3V0IGEgaGFuZyA6KA0KDQo=

