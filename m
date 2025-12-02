Return-Path: <linux-btrfs+bounces-19458-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F92C9BAB4
	for <lists+linux-btrfs@lfdr.de>; Tue, 02 Dec 2025 14:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7AE1D4E3671
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Dec 2025 13:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF82631B836;
	Tue,  2 Dec 2025 13:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="cugs8CbI";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Ftkkb9nF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0303115BD
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Dec 2025 13:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764683414; cv=fail; b=bAVOuEbqkOSmsEjuw6gzUZCpUi6Sr8Szq7LZbj5ezbLI+m04yIWY/kHSvlFlZuFcoTD5ua/KK1Co6ZjUKJk4RKlkbRSqTYVCNv3LcWpgtmtK9B4e2qlSghMAGpiiSMGIMF0/b3gc4sfltkSaPV/mSy1+RVxIjHY3ue6uPDZ55wg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764683414; c=relaxed/simple;
	bh=AZzEIosNUukdOu8Y7qsdR7hRI+q5t5WaT4X7m3PST1s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mtdR6XJ+5cSewL/MmZGFZ0ikyHmOjiuwqKZwtX685P4JqszRCvkAdq74rWIlAFq/pAwGv/vIid4qrZYKnj4B5tU5cuwheGadrNAc6QCWbUO+XE20y3iD5NdL0bRyHDdENY6xZIwUWWknxjRy1VBhsPX/G6DORbADUP9SmBERp0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=cugs8CbI; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Ftkkb9nF; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1764683411; x=1796219411;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=AZzEIosNUukdOu8Y7qsdR7hRI+q5t5WaT4X7m3PST1s=;
  b=cugs8CbIdmLBbHS4GHZpe9xhzXBhqTOKyFP4zuGKiXkxu8l0uvZnm3lE
   yO0VDQvmiHDLddRaPb/M122cSXq628YEZ2xkl3uF5w0hTiFGb6UcQRlOn
   DWnoZboc13tY71FGUq9MtWuYoJmrRZCDpPxj4jOMC2Idp50V3VGe/Lngg
   BXv2dNeQ/PZOG8W5jnWXCWJgVvTnqgYoJzlWzVGcOwCPAXg+V6DHY8foS
   c6YdCL6m/RYFuqzK0LAl8Ogj1AmdOfjOyoUzMg8TfJ+K+rg6cI3f5T6LD
   oUNSNLmCX6IpwUjI2tLOIK44/jH7PPv7hYQI+QthYdV6AMymz93cjgqVJ
   A==;
X-CSE-ConnectionGUID: oRAtacz1R3iGD2HVWxVSUA==
X-CSE-MsgGUID: vjR2RCojQrKNbCNht2DOcg==
X-IronPort-AV: E=Sophos;i="6.20,243,1758556800"; 
   d="scan'208";a="136243609"
Received: from mail-westus3azon11010054.outbound.protection.outlook.com (HELO PH7PR06CU001.outbound.protection.outlook.com) ([52.101.201.54])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Dec 2025 21:50:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uki4kkQxNmPDP+ObuCUHHBMdEYFs7d3oyd4stEc6q1fFQffY3Cw7QQMmoahop6E/7Kz01JMc8WHfApU4O4/DPgSYQPdYC+/w+FLs94dlyi7+xt8WnQdaeyTMZ8bsubhWLktMvJT5rGcVrS/IEqfVU8z6FRTSp7Fe9uiSVx+3lbfdrHcWjMBmOPfwTcllQoxVR79avJNo73ek5oAiYyi0pPfVdY+v2KA/KNDpQFTKckEBcKpPKrJJ54wEQqI3xKWOANUYnJB8qL0YFkhbv7s9qgdwvgzghr3wyao+2itQsU2Zv3GvMFaa/Kf+VY7Y1lPgggo91notoeqQrezE/4sx0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZzEIosNUukdOu8Y7qsdR7hRI+q5t5WaT4X7m3PST1s=;
 b=M6Jk4V5kvPfAbjST/UCCmfF5Fb9eAZVYCph9JApDu2YKR5vJ4hVX2zb9C7YJqnYFDhtxT68nTY+ACY5lCH/Y7oRzmSMcGK8vN/i677MDoyRjX8zUeojc8aygCrMB6WD7kU8xXzUjfRbZL6HAPw2f9i8F0FUS3/22Zh01UazwIUfz032lWZevAZZey+QpYxy3z4yooXLZHpMHtjbKmrcxotbFbYIA8hIYGym2iBnebWEAumGYd/UFPT82Dl4Zu+6JlXisdCkmQ8+NfyAhxV9myPEUff0Dq+A+fGTHRvVezNCD9wrXCRAMknO2SxDhC+5Zx9At6XfVR453KSm3LuUjDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZzEIosNUukdOu8Y7qsdR7hRI+q5t5WaT4X7m3PST1s=;
 b=Ftkkb9nFX8OYqaPQahSmd+L5t3VQa36ukLpl7mgjwoQ2dekmB9G00dWTALFj0ylsM42bcGFaqdwVVKrNGfG0ywy3NJ1zVebkM7dvtOZlO9craDbMG9ypnvPRx4YndcSOAnB5xZpVftJNip8ywyxZsF8jJxfpoqpmE48JWsmVWsI=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by DS4PR04MB9724.namprd04.prod.outlook.com (2603:10b6:8:280::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 13:50:08 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8%5]) with mapi id 15.20.9388.003; Tue, 2 Dec 2025
 13:50:08 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: hch <hch@lst.de>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Naohiro Aota
	<Naohiro.Aota@wdc.com>
Subject: Re: [PATCH] btrfs: zoned: don't zone append to conventional zone
Thread-Topic: [PATCH] btrfs: zoned: don't zone append to conventional zone
Thread-Index: AQHcY3TCGzy69Bges0G3xAhmmRQFUrUOWIaAgAADvQCAAABQgIAAAaaA
Date: Tue, 2 Dec 2025 13:50:08 +0000
Message-ID: <27a0dd17-2cd5-488f-8f5b-3896dcc060f7@wdc.com>
References: <20251202101631.155235-1-johannes.thumshirn@wdc.com>
 <20251202132943.GA25391@lst.de>
 <f746ae11-f29d-4b6f-b2c2-1fcd63713c24@wdc.com>
 <20251202134413.GA25716@lst.de>
In-Reply-To: <20251202134413.GA25716@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|DS4PR04MB9724:EE_
x-ms-office365-filtering-correlation-id: 122b4039-4fc9-4ee9-232b-08de31a9b4aa
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|366016|1800799024|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?WUNxRDVsNzV5NzZNdmJLYWRwN2gzNEI2ZjBWYWtScEJWcVBOemJxR29wdmR2?=
 =?utf-8?B?a2J6ZkZPRVpHSENHMlUxZ3I3SmxzMUs1Uk9pM2V5c2VMMWdWd2w2dGMzS3pM?=
 =?utf-8?B?bzJEUkVDMTMwUXFwTDU1WjRNUTZONHNXSGZJVy8wSXdreW1KVXFrMGpRbDRH?=
 =?utf-8?B?VWtOc3ZoU01UOHRucCtsTnUyRFJXTFN4UUF6TVVqZW9BSmVBMkZRY1FHcTdQ?=
 =?utf-8?B?d2xlRVJKdlkzdWtSL0FEc0FES2NlVkdqR0drTnhva3V6VnVEb1RIekdNTUda?=
 =?utf-8?B?Y0hNLzhQVGRNRndSZWVtYkV0VzZlN1pneHp5TWt1OG9DMWJ2NXNlMURKQ2tM?=
 =?utf-8?B?RzBZZzloeXIzWTNLOGZkOGJZdzJHb2t3U3ZvTUtGZE5wRGgxazl1MXhMTG4v?=
 =?utf-8?B?NXZwVVBhaDJhcHV6T3dEZVR4Z2RVT2hXWEFUeHNydjFEMmx3UE93YUxTZEtJ?=
 =?utf-8?B?bUVBRm5jcW5qZytLSWRIN0JFd2FQbHB1bTc1TjhFbTFHNHY5NUEyd1FFbi9u?=
 =?utf-8?B?NUFJT1NLMEdVdXptMkRaWktwY2ZFNXVCZUF6L0pVQS95V0RrRExvRDRNUHlV?=
 =?utf-8?B?Y1NaTHR1ck1UWmJ4a1ppU0NPM0ViQ2ppd1IxSllRclpSL3haSXJOTVVWRzV2?=
 =?utf-8?B?VlFJTHVpMURPcUFWN3RRbmhqMzlPWURXTGh0TlV5djJ2V2Z0aC9lZy9jOGVK?=
 =?utf-8?B?M0xDdWd2MjZ2czVVSkkrVnhvUnlseFRrR21HdG9ib25yTi9PV0V5cGpOSlVr?=
 =?utf-8?B?SHc3eTdOT3l1U3diU0tGUmhGRjdDNUlkWkZRSUF4aXFGbWdJMDY2T09iL3c5?=
 =?utf-8?B?U0JUWWtaQTUvLzM0aHpCbnRtT2JQV2l6UmkvaGpXUlRRZzFEOXFCL1lnWVgz?=
 =?utf-8?B?TWpRVktnOG5vczhOajZlZnpMTG9sVmc0NTlSbHcyK2pTS2Y5eGw2T2pMUlI0?=
 =?utf-8?B?ZFRucGJqMTRXRi9QOGZ1c2IrVTJPb0pQbjFOaG5aYnF1UUZqMjBvay8vY2xX?=
 =?utf-8?B?MGwvSXdBRVBNV1ZndXhPczRha1FKUDdZM05XbVVoa1N1cHNxTm52c1piSjVE?=
 =?utf-8?B?cWMyb0JlL0w2RVJqRlNCRC96S3NTU3AzQUJ1MHBEOStVdlhodzI5ZGYwbDhn?=
 =?utf-8?B?bXJDV1lHSkpxRTBLL0NsM3JIQmZSZ3o1anh6VlhoZlc5a05BbEpLMDM4eWQ3?=
 =?utf-8?B?S3phcjFDYlVDZG12UVhoVEFJc0VXOHJMSzBlOHNIQk9lZTA3dExMNUVVNUZs?=
 =?utf-8?B?N2ZZTTVyaE9PWjV3RlNseFZobGY0c2J6eWJydWl0MlZmM3FwbmQzLzZZaWJU?=
 =?utf-8?B?Skx3Q3ROZXNVTllYbnJ4QzZHTFVYdTJ6c3VpM1BVamlFQktvTndDMEJrZnJs?=
 =?utf-8?B?NHZidWlJVVY0b0JRcW1CQkVqczd0SzZOdm1IdUtjN3ZiRzdzSk9TTGg1Q2ZV?=
 =?utf-8?B?anJuc21FYlpUMmVZTkx2OWZubXlmcjZ3M2tOOUxCeTh2WHFqc0hTWUdTMnlU?=
 =?utf-8?B?UjA2MFVGRzNuRTRvT1EyeDZKQWtybS9OS3dPL1ZFYlNPK0ZUTFdnZWl4dXJm?=
 =?utf-8?B?MFNISmRGWEplTzEzWGlFZXdNVE5yTEtwTHJPVFVqc292eG0rUmZGdmNaeFl2?=
 =?utf-8?B?bm9QcmhzdlU3ZE0rK0N0OVJQcjRxTk9qbTBmOUFuN2psMm1KLzNVNzlHUlA4?=
 =?utf-8?B?ZWdnSGFIR3NVUHFuU052UG0xVVpZZVBqL2ZSY28yc1gxRmxJckg4dTdDL1Ez?=
 =?utf-8?B?TzZqRnl6djErZzMwZXJQaFVuUFkrb0tLcERMQkd4amhrcDdKcjBRa2JaOHY5?=
 =?utf-8?B?ejhyeGZ0TWI3R004R3IxZEVVbUJTeEI1bUw2Q3BZT0loUVdUdHkvYlJyVnRh?=
 =?utf-8?B?Z2xuVFp3Q2IxQm9VNXYxc0pkZEs5R0cwd1pDbDhqTU9HdVJ6bytKUUJCaEFB?=
 =?utf-8?B?YitCbWE1Q05BcnRwT0xiL0laZHhwOXd6Vk1WOXI2UjZkaTZlZ2Nubjd6M3o2?=
 =?utf-8?B?UWExekF1dWVnaithYnk2OTlldkpyTTI0dWtxYkk0Z0F5c3hzWFg5UmVyRU1p?=
 =?utf-8?Q?xEKh3b?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(366016)(1800799024)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NGpFOW5GUUlXbWI3MEFHS3VOWDFCOWJBMmtnVFFvSFlEV0pPdWVZQnVqRUFx?=
 =?utf-8?B?dWcwb0Rya3NEeXBETVROcG1uREpvRkFWVzZDeUdCb0xMdGdJU21YY1dzWjB6?=
 =?utf-8?B?cVc0T01JNDJLVjJKTktZUXBDVmxQVHZ4Sit2YjNidXJLZ2xOQkdmUmgvWDZl?=
 =?utf-8?B?UUl6cnhNQUd3UjRINDBvNmtaOTR2SlZwd3hKdDRpZitQTHRoalgzSU9zQU82?=
 =?utf-8?B?NDNacG9UellXTjFXQ3UrR2JUTjIyNmVkamF0Rk5mSEwzZ0tzRExoWE5WNG5I?=
 =?utf-8?B?U0hFdFRWNGtHdlg3YllTWlBnTW82VnhhUmxYbnJsQnVINUUrUDhNNU40RXg2?=
 =?utf-8?B?RXlGclJ2N1p3UGE4VCtEdm1LRnZLTkZYaFh6elIzN011T3M1Q3c4YVExYWY2?=
 =?utf-8?B?S2tUbmZjQ0pBdWVRN2xGSkV0SVJjOWVCazdIK1hGcFA3ZDhzd1N3c2VsZnNm?=
 =?utf-8?B?Z2dyYUZjeG81ZWlMQVlkOWJTajBkMlFIL3R2amxXN0c5OGtpWHBoWnBnUGx5?=
 =?utf-8?B?ZEpxUEZxQ29VK0E0WHlOSVg0MEZuUjNqdC9kV2kzaHkwV3hrMDhtRTR2UURO?=
 =?utf-8?B?YkFSK1B0RHFFVndhOElEWElvejZyQ1hlZ0dWTnJJQXp3ZkNUakxBVTA2WHdY?=
 =?utf-8?B?b3MvSWhIdk1PelJ4VVppbytXVFgrcGloTlpkREdISU1pUm12WWYrWms5b0Fq?=
 =?utf-8?B?bnVDaWVZYy9MYnpQMXh0cTBlWkRxMHdzOTBSRHJ0U3VrSURXQkpqOGlYem9C?=
 =?utf-8?B?T2JRTjBjUWQ2YkZab3BHdm9UMjZtTVRKT21TYlRQRDV0ZDdsZkZlVkRrTkNB?=
 =?utf-8?B?SkVFY2FJeTJnSEU3ZjlhUFFRMHBwckNadFlHelMwTUhjVGtBRy9FNU9nb3RC?=
 =?utf-8?B?QituSGFzOWdlSDBpaDdSempNNmMrcGpyVkw3N016S283NUl6V0NBNlpxU0Za?=
 =?utf-8?B?RHVDVGxZOFNFOUNlc1ZqLzNHRTJQQU1HSitlTXlLVlZTK0JvZFFkWUpLMDRU?=
 =?utf-8?B?bzlVQ2ZmRGYwdGdGZllFdlJzRzBraG1OU2lsampiQkFYdWlRL2FSUVZFRmFN?=
 =?utf-8?B?MWUwcitPbWxMNTJuc2R0c1JvalI2bk1mT243aDJ3RnAvWlRad3VyeDRGbXEr?=
 =?utf-8?B?ZVlTMGpkbGY2YjkvZFhWT2duRTQ4bWl3a21IV1l5YmFNY0MrTkw2V0NQRDR2?=
 =?utf-8?B?Ull1REl0bGFWb25wQ2ZscW9rMjkvdktOaWtOZXVzSHMxcWpzSjE0YVd2enlJ?=
 =?utf-8?B?cUZKMk5lRmZZWnZCR3Yzb1RvMGlrTGg3eDlNN1hnZjdMTjN2QndnbmcyUnJz?=
 =?utf-8?B?eWhOZVE5Y2xuK1FoNWFaMzROTUViZnpKcjVMSWdSRDNMRTJxQnJiU0wySGZj?=
 =?utf-8?B?aC90QXV2LzZkd1ZwQU02NDhBSmcwbXlUelJpV0t3SnY2UEliYjhxWXQvRXZV?=
 =?utf-8?B?VzdDbkN1U1pUNWRiUVpLZ1FWUEdUVTBxUEpPanlROHhMQVpub3VUMXRhQk9s?=
 =?utf-8?B?SE1uN0UyUEVYVU5wbGFrdVhTWFUzN0Z2RUNhcktwWFE2Vnoxc21Wc2oza2J3?=
 =?utf-8?B?QmxlaDZDYnNKMFpGU3N2L2FBdVhkUk1aaUdQV09Eei9QWExWR1cyVTc5S25p?=
 =?utf-8?B?S0l1QzhGT3BjbDNkWXRHSEFnZjJEN0k1Ris3UnNvSkNYZzJVVE1XcW5BTUFV?=
 =?utf-8?B?c1lIY0ZmMWI3dG9JUkNCcHFqK0VDUEk0UW5XMUI1NmVlTmQ1b1JGMFp0akt2?=
 =?utf-8?B?eTZsOWoxV2NuVWhWVU9QVFhtK01FL0tvNHcrcTd6Zjc0WXlHekN2d1NldDlq?=
 =?utf-8?B?WFp0RVMxWGNUaFE2QnIrZC9RV2xxcHZ6WkxoQWFhTlJrSmI0bFB0d3BZektw?=
 =?utf-8?B?L2QzR0hBQ3NvNU4vVjN3WjRGVnptWE15Q2VoNlptOFdLWFA5NDRVNXFpejJC?=
 =?utf-8?B?N2VsYW9kcHBVY1B2a0JDN2VkazJ3a2Q2WWR6MVVTL2ZSZi90c3hKdXVIcFJ4?=
 =?utf-8?B?a2Y4WHhMdlhPNUpoTE42Yit1WGZzaEVydmR1ZzBUZ0V5RjA1UmV5QVlRZGpY?=
 =?utf-8?B?Tk5jVFlTWnZNNWhJbWkrRzZYQ0w1UHNYdlNhQ1poYUtVSGJzdmlwbVdGeEh4?=
 =?utf-8?B?Wkw4UTFZVDZtaXVUTXpPbXlWR3pEdFZLL205dDV3UDdlOHZ3TjhNNDRsdERM?=
 =?utf-8?B?d2pPdHc5NUpyWmlBVzdkNmwzVWN0OUtxdFk5RDRjVjdRalBMTDR0dmxXUGE1?=
 =?utf-8?B?a2RrRi9RTU9NT3ZzRjZ0eHEyUFJ3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A5ABDBBCF5DE2342BAD34FCBB1659DF7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	t15BKaOnJMwZfooGoo6rDsyQP9OIaO0fBwVIF9YDhfl4SDGK7fHdOxxg9Bi26h5hKxHJ4kjwJnM5vzVSEgXsGTNXe6ZaKCG4Rk5tMeKT5Unk4auHfbDahRdueS+yRgbK8f6Tq3uxJmubJpftqg6W8WcxgtWwy7I5cf62JP+7Tf0Qjy4UsVJyudBkTZ+dSo0fSZOEk1cMDEE/wAmO96YeusMbJkqrEifT80vhZHNE5yfHTKYI6Bqz/v3DUQBt3xgFV4V40Z865aJLK+HZ4xdrYQ3ieaKMfR2vxHl3e2StGwdRk5DIaiwRESJxHuhhCToIdhAOHQdlAtpDgMs8qdHbtoZP827uqSpfyHDgBJ1BFISUFZpZSnuSk8AyoNrAltHcQJHt38/JnAeromOdX8/48Cj10xXGlwRa4kcFGMc6nSgDD32SVQ9reULpsgHsBd4lzE3adb+mAY89lCJw8dJVTpPzsQfaX/XyB51Y0DwuI4BTrrTwYWR85BA7z0gomM5WuQv45TW9f/jWIeXB9dUamtrbIy0WiWfmvpntbWO7/eSzrG5XTb1RGwovdnd3VN8C05UpXCf5zMaQiJ9oxv0Pm96MHlF/gz+dv7DwU7YM5n3UZ+GbC+RvHfeXWCbba3Tn
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 122b4039-4fc9-4ee9-232b-08de31a9b4aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2025 13:50:08.3163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gnP1b0k/OIIg8EhTJ4Enae9MJd2IGA++agUzP++2pKUFYoD6qWeFjMpHQHr9NTkB4lrWFlpdZz8+kf7DarrOiTpoXl720nOFrXJZHL5R8xg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR04MB9724

T24gMTIvMi8yNSAyOjQ0IFBNLCBoY2ggd3JvdGU6DQo+IE9uIFR1ZSwgRGVjIDAyLCAyMDI1IGF0
IDAxOjQzOjA3UE0gKzAwMDAsIEpvaGFubmVzIFRodW1zaGlybiB3cm90ZToNCj4+IE9uIDEyLzIv
MjUgMjoyOSBQTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+Pj4gT24gVHVlLCBEZWMgMDIs
IDIwMjUgYXQgMTE6MTY6MzFBTSArMDEwMCwgSm9oYW5uZXMgVGh1bXNoaXJuIHdyb3RlOg0KPj4+
PiBJbiBjYXNlIG9mIGEgem9uZWQgUkFJRCwgaXQgY2FuIGhhcHBlbiB0aGF0IGEgZGF0YSB3cml0
ZSBpcyB0YXJnZXRpbmcgYQ0KPj4+PiBzZXF1ZW50aWFsIHdyaXRlIHJlcXVpcmVkIHpvbmUgYW5k
IGEgY29udmVudGlvbmFsIHpvbmUuIEluIHRoaXMgY2FzZSB0aGUNCj4+Pj4gYmlvIHdpbGwgYmUg
bWFya2VkIGFzIFJFUV9PUF9aT05FX0FQUEVORCBidXQgZm9yIHRoZSBjb252ZW50aW9uYWwgem9u
ZSwNCj4+Pj4gdGhpcyBuZWVkcyB0byBiZSBSRVFfT1BfV1JJVEUuDQo+Pj4+DQo+Pj4+IFRoaXMg
aXMgYSBwYXJ0aWFsIHJldmVydCBvZiBjb21taXQgZDVlNDM3N2Q1MDUxICgiYnRyZnM6IHNwbGl0
IHpvbmUgYXBwZW5kDQo+Pj4+IGJpb3MgaW4gYnRyZnNfc3VibWl0X2JpbyIpIHdoaWNoIHdhcyBp
bnRyb2R1Y2VkIGJlZm9yZSB6b25lZCBSQUlELg0KPj4+IEhtbSwgaG93IGRvZXMgdGhlIEJMT0NL
X0dST1VQX0ZMQUdfU0VRVUVOVElBTF9aT05FIGZsYWcgdXNlZCBieQ0KPj4+IGJ0cmZzX3VzZV96
b25lX2FwcGVuZCBhY3R1YWxseSB3b3JrIGZvciB0aGUgcmFpZCBjb2RlPw0KPj4NCj4+IElmIG9u
ZSBvZiB0aGUgem9uZXMgYmFja2luZyB0aGUgYmxvY2stZ3JvdXAgaXMgc2VxdWVudGlhbCB0aGUg
ZmxhZyBpcw0KPj4gc2V0LCBzZWUgYnRyZnNfbG9hZF9ibG9ja19ncm91cF96b25lX2luZm8oKS4N
Cj4+DQo+Pj4gRWl0aGVyIHdheSwgdGhpcyBpcyBhIGJpdCB1Z2x5IGFzIHdlIG5vdyBzcGVjaWFs
IGNhc2Ugem9uZSBhcHBlbmQgaW4NCj4+PiBtdWx0aXBsZSBwbGFjZXMuICBDYW4gd2UganVzdCBw
YXNzIHRoZSB1c2VfYXBwZW5kIGZsYWcgZG93biB0bw0KPj4+IGJ0cmZzX3N1Ym1pdF9kZXZfYmlv
IGFuZCBvbmx5IHNldCBSRVFfT1BfWk9ORV9BUFBFTkQgdGhlcmUgdG8ga2VlcCBpdA0KPj4+IGFs
bCB0aWR5Pw0KPj4gTGV0IG1lIGhhdmUgYSBsb29rIGhvdyB3ZSBjYW4gbWFrZSB0aGF0IG5vbi11
Z2x5LiBPciBqdXN0IHVzZQ0KPj4gYnRyZnNfZGV2X2lzX3NlcXVlbnRpYWwoKSBpbiBidHJmc19z
dWJtaXRfZGV2X2JpbygpLCB3aGljaCBpcyBwcm9iYWJseQ0KPj4gbmljZXIgYXMgaXQgZG9lc24n
dCBuZWVkIGEgcmJ0cmVlIGxvb2t1cCBmb3IgdGhlIGJsb2NrLWdyb3VwLg0KPiBXZWxsLCBpdCBz
dGlsbCBuZWVkcyB0byBjaGVjayBhbGwgdGhlIG90aGVyIGNvbmRpdGlvbnMgdGhhdCBwcm9oaWJp
dA0KPiB1c2luZyB6b25lIGFwcGVuZCAobWV0YWRhdGEsIHJlbG9jIGlub2RlLCAuLi4pDQo+DQpZ
ZXMgSSBqdXN0IHJlYWxpemVkIHRoYXQuLi4NCg0K

