Return-Path: <linux-btrfs+bounces-5573-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5C4901174
	for <lists+linux-btrfs@lfdr.de>; Sat,  8 Jun 2024 14:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BCF7281F7F
	for <lists+linux-btrfs@lfdr.de>; Sat,  8 Jun 2024 12:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB11176FC9;
	Sat,  8 Jun 2024 12:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="C3zjTxSU";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="lhiPgH2K"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF252206E
	for <linux-btrfs@vger.kernel.org>; Sat,  8 Jun 2024 12:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717849858; cv=fail; b=SCx95PjCpu3XMoAspUQ9FAaFP36z5259gfzST5BIc3DRxCsap8Qh24h/ZVH/EXPqguyQXGaX2uRcfmXScTXUmq42Fff58oCcn+iuMXhDnM9ckUPBiXfeqF6DDhLX3/apWaBrT5im+Cns0GTkzvrFy6E8OrhZ7kBapxmoXLOXitM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717849858; c=relaxed/simple;
	bh=kyd+UjHQwDndPnlqZKwrpnxf8sOzm3uF3IpRO4hQp34=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ePz3ovAiosd5fZ5klTIjGuC8bbZFvWmWobtUflgkbrxUkiMau4WFpKy8ka21fxjgz1Rli5HlohSItETQ/GZku/y+hJOCl+P2mgZlDyT/1ScjmT+RIUjaQRSRhciMVHcchl8oWHYlLWXx6CHMkq1XkmcHNFHVt0WK7WuwjlkybdY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=C3zjTxSU; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=lhiPgH2K; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1717849856; x=1749385856;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=kyd+UjHQwDndPnlqZKwrpnxf8sOzm3uF3IpRO4hQp34=;
  b=C3zjTxSUpvqBzgHegfnXCZLK+QHABQrlr9FVCe7PmeUf1Zx/SZIBvPQg
   hGMpErbV14go30JUfX7I2f2kFPETbe6YmxJoQ9d1jhD+YoIxP1zR7pDoQ
   JdpsCZTl28Orfvd9yax5PI6jMU6a3H06Aeb+CgdnR2bg0YEedjq/ZqyRK
   ZWWRXxqhRQc5EPhwwzP4MB9gm3wJPrf8LZ/hSWhHkVdWhvXGYN7Pjakd3
   D0z5nxQlpFS/DBzNU626MI9KlO65LOA1u7hy4G5pDg4wX9KDShcglnEdH
   EUTY9ixrPAwsZhz+cNxepLvS9DCSQ4U9ndrV3Cf5787wGeOtUlf6Tt2Gr
   w==;
X-CSE-ConnectionGUID: qweVx04qRxSVBmLZbFPaZw==
X-CSE-MsgGUID: NBwXkjXkTBi/gWYmH4QRyQ==
X-IronPort-AV: E=Sophos;i="6.08,223,1712592000"; 
   d="scan'208";a="18579933"
Received: from mail-bn8nam11lp2171.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.171])
  by ob1.hgst.iphmx.com with ESMTP; 08 Jun 2024 20:30:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K8IS/s7eGQmQISwbAaqq1ry0meWzfyYIayKcq7g0OzEBqwTahlBH+UY3wQFJohKKSMbeiOFnSyfQsYutXBKoRsX5jz4V4q5CaOZFsOk5dvPWDfQW+PeIkAVNZzguhSrbRCJS0GyIMEXqurPEiG8OTNyzeB5htpx7vzNike8LbasbkvC+XNNizApJySC4+5TaBC8fGR/aZYNSH2NkjxwkrSO1fGVK7OoCZxytiKSPs8lN7vch4xJ1tAxJMtlxP+7NwDVFXQlXY3kQOlIpacWSAitUf23NXxq8UPwXQVNRxJsXcZLdb3o9mOpovvLHA/sC7U9GEmMxhA6HKatJyGs/wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kyd+UjHQwDndPnlqZKwrpnxf8sOzm3uF3IpRO4hQp34=;
 b=k5fiybuhXEnE7/g2FqPFc2EGmtrR6lVLIA+PtA5CbYJR20ApsfSWm8IipqVU2H4LY0/ZjlF/IN1xBTRQ17RXAEXLNAfRPto97DxVxchpZEE1d8+txOezvKFsWiBK4PJK788yvDfnFPvZbZP/jxXvP/FICbcWG4i63hOPnacsBjZ4n+5nw6sQs6RJJW3krUtf2XmIaySsRJP8O+AsltEYdJR+c05Xs6v5x9am+wYcsNEBTtOzJEUdYXgKHJc82761G2cmIJVaIGGu2E2BJmYgpI8qqsVyxnjpu/mehlju/sCNoNocuUHwBLa6DUMDgm9do9r5pmsODUw9tmNiiLH+Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kyd+UjHQwDndPnlqZKwrpnxf8sOzm3uF3IpRO4hQp34=;
 b=lhiPgH2K7mjEEFRly+svH7hPlyd6GI3tlgLK1I0Qs9GIdxyVrbtZEEFVyV53eTuysn5mrmLCSaA1YCXDftJ1KomgglfLkgaPS/l5XAYbfDSuaBWB5icTwuqb8MTDGBhrwqWuDr4XrWOyHa7WUtwnkUR4KBYxNM0d6sOGUGb6JFs=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB8289.namprd04.prod.outlook.com (2603:10b6:a03:3f1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Sat, 8 Jun
 2024 12:30:45 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.7633.036; Sat, 8 Jun 2024
 12:30:44 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Boris Burkov <boris@bur.io>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH] btrfs: retry bg reclaim without infinite loop
Thread-Topic: [PATCH] btrfs: retry bg reclaim without infinite loop
Thread-Index: AQHauRXqxAbciW4+qUa3DQKezgHuIrG9zTEA
Date: Sat, 8 Jun 2024 12:30:44 +0000
Message-ID: <0223c6e3-08a1-411e-adc9-a66fbed950a8@wdc.com>
References:
 <3ed106331a7ff61303c9e1c2930f8a7673b80a86.1717790627.git.boris@bur.io>
In-Reply-To:
 <3ed106331a7ff61303c9e1c2930f8a7673b80a86.1717790627.git.boris@bur.io>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ0PR04MB8289:EE_
x-ms-office365-filtering-correlation-id: fb7253fb-85f9-45a7-d0ac-08dc87b6d154
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?cjdUSytEb1BwK0FkMW1xYlpyRUU2Vy9lTHNIUzlsQkltenBFZEhRdWtBbzFw?=
 =?utf-8?B?aittZWE0cjFsUmZjNzlHYi9STmZuWGxwMlo3OW9jL1VxbVhDaU9QQ2xiZ2Iw?=
 =?utf-8?B?VXdrRWpFQVRndEdvcEVOa1NTNzIyWTVuMi9qbVZsSG8zd2RHN3crQlZIQzhj?=
 =?utf-8?B?cWFodEM3dFBZS3NrTmhCN09oNEtLZngyTmM3aU00WC9iZy9TSjBmL2QvSlpU?=
 =?utf-8?B?NkdQQlVkM2Fhb1JxcGlWeGZkZEhxNmhqejR4SGNjemxUeFZKQThnNWxUZlpU?=
 =?utf-8?B?V2lCaXFRQ21hYm94SHJVa3FoRlNKVyt0ZEhCVDltdml0ZEZUQ0F3WnkxUkc4?=
 =?utf-8?B?U2RjNWhIK0hLZEdEM0RlOU1yVnFZRG5DcWVvNk9xbzlpQTlMbURnZVdrUE45?=
 =?utf-8?B?bEtiSlhuSG9CZ1dpZWdCcjVPR2hMdlRDZ29JQ2k2a3BEbzZzWllJRzg4QWJO?=
 =?utf-8?B?T0dtOXRzU2lVZHBXcXN2eWc5OHkyUEdTNjA2L2hIT3hBQmF2czIwOXk4OXdk?=
 =?utf-8?B?NzV5THlxN05YMWsyK3pYL1lCenEvUVRJYTZsRit6M2ViM0xreUx5L1pGWkh3?=
 =?utf-8?B?ZlZnR01tdFJ1K0ZsQXhONEtmaTFTTWFPenY5YVRPbllQdE9nVzh0Vis3Q1ZY?=
 =?utf-8?B?eEY0WjBiVERFYWhuaHZudnV0QkNhQ3IxSEhoZFQzOWViak9OTzVzSUZON1F3?=
 =?utf-8?B?MVRTVjFKcEI1MVRWNGczZStvOGFkUGhtbEo4aWhHSjFzamZpYWN4UG1IVXJp?=
 =?utf-8?B?WUs4bDVIczFKd3Ryek1ZenF6a3BPNmVyQ2FBK2c2R3R1ZG1RR2VVVmQrcmlQ?=
 =?utf-8?B?ZFl0WDNJak85OGZiNVd3djJoNWxNUUl5K0xTdWFoS0ZXZVJwVmV6bEFPS204?=
 =?utf-8?B?a0FrbWN2RFp3OGFGREUwa3BkbFBjbkdLejNnSUluRGZlazZjKzM3L0JaR1lt?=
 =?utf-8?B?QVhXcHJZd21NeE5yV1h2WVZhMXJwWGhWVStEMnVWYWZzV2h5QjY0aWt1bGh2?=
 =?utf-8?B?OWV0aHpjVi9GckFZY1BmMzNNSWVLMGtZVVV2aGR4ZVZ0Z2RhTUYwOFNid21D?=
 =?utf-8?B?TzhTZXpPREEzS1NCVi9iVk0xOExrUTVVVDY5K0p3N2dGcEFoa2lDWnM2RnQ1?=
 =?utf-8?B?Q3E0NWZsMlV1YU5sSThMNW5iWmRiR01oQW4zWGU2T3Z3TFU1YWUzaTQ5Y2g5?=
 =?utf-8?B?MjhVOG1rb1BmMkNVNFBRQ2g4bUdCYnZnZnJGbVBSYnZZaWttQ09ZQngwVnN6?=
 =?utf-8?B?Rm1lWTJ5aDlXVHUzcUp3TXNWdU9FcysrQmMxUmZXTzlOOEc5aXM3cVFlcjVq?=
 =?utf-8?B?V3B1OWFFTUF1ODB6UUVodW1CbkhqQjBOMDVabXRnTXdBbXBpQ3FEcDRjbXgv?=
 =?utf-8?B?S2RaZUZVallqdG1mQi8zd2ZrU2VYM0YzNCtJQ0hMbjAxL3VRTEFiTlcvdUdI?=
 =?utf-8?B?Znp6K2ppdkFqNExsL3dDS014ajlZNTBMQjI1SEVVOVVJT2ExcGpvMitDWHNk?=
 =?utf-8?B?VEdEdkxyMXlOdzY5elM3a0loRGxMWFBKZ2NiamJqOWphUUIvVkFSUG9YdDls?=
 =?utf-8?B?VGZUTGNNYnpiaVpGQm5oVHRBS1dPSmYrZTRENXB0REluQ3VUZnFYaG5QSVpU?=
 =?utf-8?B?V3ZScm5MRDh3ejF3RktZZDN6YnNEa0o1dGVsZmNWdkY3MTVNUGZ3VlE3ZWdQ?=
 =?utf-8?B?UGt2ZTNmdWRKWjNTRVR5UDhQZzBvc3BFYUU4Zm1XR3Jad1ZKZGtEMGlxZitW?=
 =?utf-8?B?K1ZNZThna3JZcEw4NTcrTkFUQmkweS92NGM0S1Ewdm12Zjk4ck5XRDhzQ1hv?=
 =?utf-8?Q?JaBqcVv3TNa1m8QMuLlhxQI9HKN4hCy4sUBKI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UUltODlnWHJuZGc5dkpoU3Y2VlZrOHdkaGtYWWF4aWM4dk1LeE8rV1BoY3la?=
 =?utf-8?B?Wk81T2dTb0tPbmpRM3crL1dnTGU2dkI5ZnhmcXM1Y1VoMlVuTDlSU25md05O?=
 =?utf-8?B?YTI2L1JWZERsL1c3bVUrUXluV0tDa1VSQnJzbldMdDJFdHBPS1p6a2ljK0xp?=
 =?utf-8?B?Y0ZOZkJnZDJSK2paWExVUE1rTTdZeW1remx5ZmxpZTVGZU5tUk9QYlhsNUJj?=
 =?utf-8?B?dC8yVzVoaHNIbDdrTDl3ZCtmTXY2SGJHQTF1WnpLTklXeUxjYVFJKzkwZHc1?=
 =?utf-8?B?SWY3TklicWdKcytVMkFIUnM4RENPd093cHIvbWp2dVdycVJxelFQM0x0Z3Ru?=
 =?utf-8?B?VVAxNE5IZzBCUjVzanp3WXVyZUpaREtkcktpN2R1OGJuMlhuMFU1bG5xMzIz?=
 =?utf-8?B?TnU3d2c2TUQvKzhpNHZWQmpqcWwvUjR3NDFYNlM4VWc2WWUxWkZkUlNJN05n?=
 =?utf-8?B?M28wT0V2QWlyeHRYRHhMR2FTR3hqV1hrZWZRNU5OeEtHWExJdjNlSVdDYWVl?=
 =?utf-8?B?VEtWZ0FhWEVEcC9LRzJHTjRaRmFoTUMyWmZ0MUd6YURBVGxsUmpHUkgrY3h4?=
 =?utf-8?B?clEydVpRb3RSeTdaTDlMSUc5ZVVSbHRsMmFoWFpQWDFnb3I5akpNZUt3RDFN?=
 =?utf-8?B?eVJyWjFCRVdDS2loK0ZVNXorMHZYSGFBN3dscTZsY3NGZ0lkdnFsM1hTdWJ6?=
 =?utf-8?B?MmJkR1YzQUgyb29zSnpYbjErbW5iMm5QZVMvaHFlWDNHbEhzWmN0MWVvMkZr?=
 =?utf-8?B?T2lIeFc3ZlhWSHk2eEl3SmtFWDN2RU40TVpFZWtDT0lIbjkwSUpJRGhDUWpU?=
 =?utf-8?B?WlB2RG9oUGZHZUNYa3F3Y0R5VTh5d0ptRG43N0dPRkJRZUQ1UlgvNkZzSVk3?=
 =?utf-8?B?ZHZ1RjhiMGlRUmNHMFhEcUNMNHJ2MXJFVDFUK0NXN1ArV0JpTHYwL1grUktp?=
 =?utf-8?B?d1c3cERoSXNMNkpaSlVRcXZIelFWOGJ5TUorL2JVLzRtTVRlUjZjZEhxNnBt?=
 =?utf-8?B?eURQYkRkZUU3Z1EwMVBzZWVJaTVEdVZwa05HSTl0eHhUSGk2dUZER3ZzL0c5?=
 =?utf-8?B?S2t0OEUyZ1BtSXdPUWNmemRXL2labElRMjdmV2ZxK3N2MnFSN0g0WVhkSUtC?=
 =?utf-8?B?dmovOVUrdTBRWjAraWxlcVNhUG1JTTVvRnpXTmlrU0tKamNDdXdmVHdEU21J?=
 =?utf-8?B?VHdRMEFUQXk4dnJZSS9kVUdjcHVXanpaZWpSeDlTTXJHS0R4Rk9kUnNBZlZI?=
 =?utf-8?B?a2l5eDZpZXBxb2UydUg3TkFmS2tTanFETEd1QnJVQnV3ZllkN2JLcmd1QUtX?=
 =?utf-8?B?Y3VUTENaSm5UcmlnNjh0YlRvVHVQM3Q5QzNwaHN2L3Qrc1RXTFZVajNzaHMr?=
 =?utf-8?B?S1FsTkIxTXpNSldSWkZaK1YrNlhlRHN5ZmJVT054Vk84bzVSS043VzRCWS9Y?=
 =?utf-8?B?azdhMTEwSXBIVksyTWxiMHJJYW52KzA4N3RRcEZxMy9oODZmQ0RVZkNtRUJF?=
 =?utf-8?B?WUdtWlpnNlRKUUZWS1grWG1YN2VSbUgyWWJQa2xuWjllRlF2QnN1VENwUVd2?=
 =?utf-8?B?c0s4dmIxV1BrUUoyZXNNV0MzUWlUL21DKy9xKzhvUDA1Z2pMYWhpU2pYR3JC?=
 =?utf-8?B?NDk3Mi81M0ZwTlpJczA1SUtnRUphOGs4OXVha1g0dStHWGNqVkJYODQ5UEVn?=
 =?utf-8?B?dkhDZHlxdk9tWVFXT2JjbWt0VElnOVJ3WUJENVFUaHI1VkkvNzlJYzdaWFBp?=
 =?utf-8?B?b0xoUC9LbStGWWtiV0UwQitxVXJGWHlaU3BoR2kycWk0ejg1c0x0dXZhcmNu?=
 =?utf-8?B?a1E4ZlhvVlBiWENNS3UrLzJHRFpBaHFjSmlaMEVXYWVuQ2loSnRhUUNnOEdk?=
 =?utf-8?B?LzlpOTdBeklyVnFaOU9NTnR4QUNXakQ2aEliaHJacVh2d0h2V3hMQnJDM1VW?=
 =?utf-8?B?N1lOR3FPUmlnT1E4RSthN290ZC95Qll5M0NpSjd5cy9iTmwvdnNhNW9YdHZD?=
 =?utf-8?B?VmVVWDBHbEc4OXZQaUdZMEExWEt2YnQ3bk9HWks3NFY1RWVJQ3ZQbU5mQnFx?=
 =?utf-8?B?dlp6MFdFM3VSd2NzNTVzSm5hWS9PQXl1eEw5ZDQ0dDU0WU5CdEljUjYwT2lV?=
 =?utf-8?B?alQ5Q1Y3UHlFZDJFcUlMeUVZamovOUFaMHdIQlBzcHpEdVZGOG9NOUVuM0t2?=
 =?utf-8?B?WmZSVWw3VUFkNW10VTJ3c3FvOWdBYkNlNSt3WHlReVRCYUZpSmRPS05GWkJk?=
 =?utf-8?B?bU1yM24yRlhDeVY1cEphbGJRempRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <199F6F963DB3F444B18911D235FFF6B9@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Nw5JnoLPRPu+tAHM5LtQ8KFbqNsjS2AOQKj1NxK+SvW8WgAw08nCKFzFnXgx1xQQpD5yxhBDT3qzBOyAhM8rMDJOmHxDjcft7nFqi2AYs5XPmgmr+YWfoDOeI4Hevn5aJf7UcVV33U9lqapT18xOZm3vwt7XEmaQXJA+FFZGEGOWOllwNQebAG9xzYyXfIioNQZrusG8yKpZPTQo71ts9gfgEwhiuo6+/dSuCTEmv7niJpRr2EF50AurSy+PpUl/Q8hWyfU2MZmO9p/y3XoaKOCyARtI7TxM2wsywcd+C3YkkOfYzDos0Tzr5GhZQ7q0aZKtCTPbWVM2/XAPxwgOuvO6rnxJdnzOmwZZle0KRmnyLi5i0OSoK64kcYGsC8zcRCNOlWp5uiXUr9jllR/i+H0N3j5Ci2DAr4Nisx+klX+PDACE5oGauGGXztZQQvAGqHVXHvFhN/Bfa1hFrgESSiqEzO1jBH7KMpyktEUoSW1liRTmNT6ax2DDfMdAjhpvoblFHplfoeWkBj8DhkL/4RJt0LJHGUOQyv7xy228Xb6m0/kXk1a7/sqRLRGxxXz5pn2Yp1CbKEfF/mae4yB6WsSxgPr/lODxyfBn99jy/kwA8GN5/NpR+q2hNqe5cCGG
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb7253fb-85f9-45a7-d0ac-08dc87b6d154
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2024 12:30:44.5203
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PbqRtNxnZadfvYr8XUW248RRGFBQ+YLKUfgw/PmOJP9zI8Pf1x7J1ixtutbnFSjKiqgMbNygSQGgyU7E78+bAyHbjvQu0BAX78pu0aM2VRQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8289

T24gMDcuMDYuMjQgMjI6MDQsIEJvcmlzIEJ1cmtvdiB3cm90ZToNClsuLi5dDQo+IENjOiBzdGFi
bGVAdmdlci5rZXJuZWwub3JnDQo+IEZpeGVzOiA3ZTI3MTgwOTk0MzggKCJidHJmczogcmVpbnNl
cnQgQkdzIGZhaWxlZCB0byByZWNsYWltIikNCj4gU2lnbmVkLW9mZi1ieTogQm9yaXMgQnVya292
IDxib3Jpc0BidXIuaW8+DQoNCkkgdGhpbmsgdGhlIGNvZGUgdXNlZCB0byBsb29rIGxpa2UgdGhh
dCBiZWZvcmUsIGJ1dCBJIGNhbid0IHJlbWVtYmVyIGlmIA0KbXkgbWluZCBzZXJ2ZXMgbWUgcmln
aHQuDQoNCg0KPiAtCQlpZiAocmV0KQ0KPiAtCQkJYnRyZnNfbWFya19iZ190b19yZWNsYWltKGJn
KTsNCj4gKwkJaWYgKHJldCkgew0KPiArCQkJLy8gcmVmY291bnQgaGVsZCBieSB0aGUgcmVjbGFp
bV9iZ3MgbGlzdCBhZnRlciBzcGxpY2UNCg0KTml0OiBJIGRvbid0IHRoaW5rIHdlIHVzZSBDKysg
c3R5bGUgY29tbWVudHMNCg0KDQpBbnl3YXlzLCBhcyBpcyBpdCBsb29rcyBnb29kIHRvIG1lLg0K
UmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5j
b20+DQo=

