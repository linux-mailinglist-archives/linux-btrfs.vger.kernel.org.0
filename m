Return-Path: <linux-btrfs+bounces-19729-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FBECBCBFD
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Dec 2025 08:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1733530102A1
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Dec 2025 07:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD5430DED5;
	Mon, 15 Dec 2025 07:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bhuRPTu2";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="GwIwtlMN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888F32222B6
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Dec 2025 07:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765783168; cv=fail; b=uPN7gw3+sArZcrwppA7CqbbD1Im5R0IiGeIDCY19OtvFDZFRGfw4C3WR2R2TO73Le0ubhZS/bD6mjY30/7nZXRSpPRURyAeBwqdYkIIzRNINU9wLPSMiy22s4Yj59w1wm5k4Gb/0haUi+Gv2uvYG42xWjxGHc7Qh5jBwj+oj3d4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765783168; c=relaxed/simple;
	bh=GzuLweOdztrQPeH4Q7zRLFNWhpTpG38xXfjBHs+RJ8o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AFU140DQxiaiWLni1DOrloGL9WcDwRP5pMtZHUvO7wevfq8NyQxUbep9YLzM9eFY2IJJy9x//ccSAmMPfl9Zio4ZYUm5GAAFkm2ibRC2pF40xoeI0jXE/CPTv2FCWexPTP75hpyn3JEpbrE5vEQvu2m1EPCYvcfJ6PcN9dJvMKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=bhuRPTu2; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=GwIwtlMN; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1765783165; x=1797319165;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=GzuLweOdztrQPeH4Q7zRLFNWhpTpG38xXfjBHs+RJ8o=;
  b=bhuRPTu20CBNAGZSjkoaRhlh+PaQdsPMWqJU0veAbuMT5dk5mZ8B+ZKM
   4i+4xk2LzwgIDq7zUz/Dr4AOF4ANXFqH99b0XfJCMQFqOIz7ujDokEPY3
   ea6XQ1PYcTAvVeCPCKNQng1wLuMI1Z69QrmNxnk4JHkcy6OclzXgTNMw3
   4RX+adeTsxBDfNvAqfgig2q1hYMzxBkYQJshu1WS4BehaaVET9JIxs+tj
   bH7bhFJk7yzaW9SUEG5+RVgL1hBeLs4dAzFEaxDhTk9glYzhx8EqXJWSO
   bDJPJEwFBFvBxWBymRKXB9acvIGrTt72G/BvxE+g0PzRqt9c2W6B4FKA0
   Q==;
X-CSE-ConnectionGUID: CNE6ox16QzaEoTQAo7H3sg==
X-CSE-MsgGUID: EoudMFFHSvKlnyEvnFlsaA==
X-IronPort-AV: E=Sophos;i="6.21,150,1763395200"; 
   d="scan'208";a="136519413"
Received: from mail-southcentralusazon11012042.outbound.protection.outlook.com (HELO SN4PR2101CU001.outbound.protection.outlook.com) ([40.93.195.42])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Dec 2025 15:19:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xdPAiKQUbzjXAIXxtYcB1aAhkaGFgz8aphMRXgcsG7dbcLCFhS/4TlyDbUE+4orQfBUGmN3j+CMwLp+s4V13nuMs6xpearYkA635JWyudNfff/lCRHoAoUNaWdup3uKZ6L/U8Nbq8b4yRw6iBClrOE1e6DRN6l1ZyP6DJIXedC+nFWb+yVUhii9xRjkwmfvzTC34Ay02hj41h+RO0AnPFEwERDIdUv4RbsCbY923BEDLD+ItoOLPLaDYoQmgGOdzRYhKCBk3n5zXdhBgqCIJk8EksVXpyO3IAvid4lYqZuyJEksImP8BD4dNZxWdV9qc9NKA3ft88xh/4soVrXBvbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GzuLweOdztrQPeH4Q7zRLFNWhpTpG38xXfjBHs+RJ8o=;
 b=BQO6kFRh1/L2Zs3k9rOEPvBndzwTPPTPaNkj3EwwqxENGBiO6FSdH3mL56PSGB52nkmTm9x4S8n6cXAxYRHVoFBTfUUgUp7m0dhLKlytX4c7isIy3CTiDNgrFn8YcR7qQi9hoVxc0TmxKWbxS/7FSYGRuF9YZy8ExN1DvsFcMPRNe0EimWTOiIdDw7dvueUHd0ExXkB+UhgQ+OBag96k7/cyGcY01/asdaR95rtOpOUmeRUtg+zeIl3ElwCGZgnbzvS+Fh068eHxwGO9rWSEDg+UKUjdwMHQd8aRyQqwbwbroLMcRXIqlNuXkH2u2AIGFmVIlzatFKN0F0KQfF7aVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GzuLweOdztrQPeH4Q7zRLFNWhpTpG38xXfjBHs+RJ8o=;
 b=GwIwtlMNMRKOz7l6bpieXbnO32NdE7iopNn5WnlQAu7Z7n7luAndXoDZoCFwrWaRZTWBUvcCf4U0d2CmndBBFHqCQOETD6bJoQDtk2XOMX9h0HC36UoHpfudXXBZP/RX3iAcYhTu5LIFOTqVhpf4ozCMzJ//RnBYfqC2r5W3JyM=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by PH0PR04MB7448.namprd04.prod.outlook.com (2603:10b6:510:b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 07:19:23 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8%5]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 07:19:23 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Naohiro Aota <Naohiro.Aota@wdc.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
CC: Filipe Manana <fdmanana@suse.com>, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v4 4/4] btrfs: zoned: also print stats for reclaimable
 zones
Thread-Topic: [PATCH v4 4/4] btrfs: zoned: also print stats for reclaimable
 zones
Thread-Index: AQHca+3WGPicSlMOiEGxPjslRBw+VbUiOzGAgAATOYA=
Date: Mon, 15 Dec 2025 07:19:23 +0000
Message-ID: <64085a09-4239-4155-848f-08d8d7a85081@wdc.com>
References: <20251213050305.10790-1-johannes.thumshirn@wdc.com>
 <20251213050305.10790-5-johannes.thumshirn@wdc.com>
 <DEYKFE9UI1UK.14D3BD16J0ISW@wdc.com>
In-Reply-To: <DEYKFE9UI1UK.14D3BD16J0ISW@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|PH0PR04MB7448:EE_
x-ms-office365-filtering-correlation-id: ddd84c5c-9f09-44a8-e588-08de3baa45d6
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|19092799006|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?QVlrZjZZY3dPR09sRFRCUGY5RzdZWUtoNTdhT3crNzJJZzIwSGZqdFBDRjVX?=
 =?utf-8?B?MWo4SkQwRUdCd3ZTc0ZYQ2FLdDNGdkkwMDZ1Q0tERmZ2WjRhdUZFVG1RNkd2?=
 =?utf-8?B?Y0VZVHB6MEdmZWEvTnhEdGRZQUdiTEFUOHpvaHFOeUNRNU5aVEhZdHUxT3lR?=
 =?utf-8?B?YW0wTkx2N3VzSkp2Q1c4NlB6Y0FsRGlLcEd0bllhL2xDeDZWVW5MTjN2Mzdt?=
 =?utf-8?B?WTF1dnAxRUtkWjNKb3MycTVFbHZBMlZMeksxdVZWTnBMY2puaGZZSWxXcnox?=
 =?utf-8?B?dHdOcENrSjMyQ2xnTTlWSWYrUEczUGJONUpaM2ZpNlpOV2Y1T0lxK1M0MTFJ?=
 =?utf-8?B?S0lud25NSVByOXMwVi9KNnVPY1F1R3B6NHRWeVlMQkVQdlpWVXZZOFlpUFJT?=
 =?utf-8?B?SEtmNUVMRHI1Q3pTNjRHTktpeE1DYWlaWEZRS2l6aStKRFRKYis5QkF0ajc5?=
 =?utf-8?B?aFVEY0ZYT1VrdzBYMU9MM3BJTFRzbmZFUTQxMnEva3ZRbEZwV0l5NkNHQ0tz?=
 =?utf-8?B?VXRZZmgwSFhmZjVaTXRQY3ZKelAwSFFTQ2EzelY2WkcxaW1rRmNTSGZBYU9P?=
 =?utf-8?B?RG9RU3cyb2s0L2d2QkJJN1Q1d1RsV00wTXYyQTZpNEZKemxQK0FGRldtQzRD?=
 =?utf-8?B?QWprOW51QWJPZVBkcU1sNmtCcVM4ckI0c0Z1c0ZJcVh0dzZnNGZiblI5K05z?=
 =?utf-8?B?bkRpNGJWWEJYTFgxeWZ6ZnU0YThaVGtJeXFDSEZZdElsa0tBV2I2K3MrSWxa?=
 =?utf-8?B?QVREdWFvVUdxWU5DOFRKQnk3MWRRd3BtYkhnMFpoUmxXK1hFSEZxNW1PcUt5?=
 =?utf-8?B?dWNSb1kweC94MWRsM0pKdk1UejBQdG5xcFU2ZjNuZ3RYU1U4TFl1Q0pCdmNE?=
 =?utf-8?B?SnVVTmgyeFNsdHFtMC91dyttVGdDYmYxMVgyOVBVRjJEOW5lWEREOTBkdjRE?=
 =?utf-8?B?L1NrM2phOTREakJDZVU0aDE4QVNxZ0ovSzN4VWxBbkRUay8wVkVzdmFpdy9E?=
 =?utf-8?B?SmFwMDJ4RVR1eERIWjBDcWNER2p3M0h4bVNCNW5WY2JwbUVFL0ZKWjV0WDBG?=
 =?utf-8?B?ZEhzNXRwR1hWSDhxRkZsMG54cGZaTXlyQ051NFpOQzRiWVlyNzdrVUE1UHJM?=
 =?utf-8?B?NnF3MVNRN1g4S0ZUcWViMWU1QnQ5WWY1OUJpM1FwNVBXWGMrcUFlYU9qRGxK?=
 =?utf-8?B?Mmh0cmExY1RkTG9ndVYzZWo3eHl2MTM2OWdwMkE4WXNiUm5sNjVqdUhFYjdG?=
 =?utf-8?B?aVNxY2FwRHo3NlRlUzNxVG5Fanc4dmN3Y3FqUHY5TXhoVTgyR0hERFU0TFNt?=
 =?utf-8?B?Q29mZnQzcGwxcFduWGJsSVdlaTRpYkliQldRUGhzNU9zR1hEeDR1dm9Qa0Z4?=
 =?utf-8?B?bUMxTEN3ODJZZkp2Z2RQVWk5Zm5XaDFsOHJRaklWeUhDWWpwazF6OGx6OW83?=
 =?utf-8?B?TGxyS0FFUkk0UWl4ZDZ4THdBQ1F1ZTdYYnlpVk1RU0JESmhhMnNFbHlabzZ2?=
 =?utf-8?B?bTdRT0s3TmMxOVphMHJ0YXJwckYvUGZaNVhQT1NBV3g0cEZjYmxhb214TTUy?=
 =?utf-8?B?U1FpMUJMOWlzdlhzZEpFVFZUYmdxZGNwQkpkN2kzbTArMldOOHhwU1dwTEJo?=
 =?utf-8?B?NHcya0tDa3A4WGp3N2R1WTBWVVprWG5WdnFzT2lXSVg4TDNuazVFY2hYbXVT?=
 =?utf-8?B?SUVobW9YS2Zrb3NCbHI5anM4NXBiQm5xK3UwR3B5aDQrQ2ZyakhNT0loRThL?=
 =?utf-8?B?WFdsOFhuQVZxelBPckc3VUVKbXp0M2wrUW9JNUZHbDVBeWEweEFqNERXN21C?=
 =?utf-8?B?cG9qMy9COG5wVHh6c3RQMzhPM2ppeWNab3M5N3krcS9CSkZmRGdvM2tYcGN0?=
 =?utf-8?B?d1hyMXVHeSttSHVGWUxNZVRMVHdtQTdpUktmVXUvbWEyMEZyeWhpV0NZRStQ?=
 =?utf-8?B?b3RmK0dvU2xQL0k5SElrbWpoOUFpOElpSFN4a3daT0QyQ214WTVnUndUZ20w?=
 =?utf-8?B?bGI3SVpXbEdZYjNwOEM1WXZkNTNvbG1LWlo0WGJJWTNvZitWWEpGQnVIcTl2?=
 =?utf-8?Q?hhEePV?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(19092799006)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TkdzK1pVdjU5T2tFbFFVTDh0VXpDNEo5R2VTcHZMWG9TaktLSi90Q1VaYVRE?=
 =?utf-8?B?T05wZTJVU3BsMWhpbENDajRjejRodEM3ZVN3Yzl4QVdIbTVFZmJSL2ZobDVH?=
 =?utf-8?B?bVRKMVFSeHRhRVhNcVhPWlBkdmd2OWUyNnJBN2FvN3hFZzNXVExnZVJzMkNZ?=
 =?utf-8?B?S1pOTit3RmdQZ0ZSZVlLeDdMS3B4QXd0ZDQvenNnWER2all6NnZ5d25UWlMr?=
 =?utf-8?B?MVVIZmk3ZEZ3SXAvMStncUsyUzdMcmkyWnJ3c29WdXRtT3JaanYvRW1ndkhM?=
 =?utf-8?B?U29YWEY0bngxMEhveWloeXlGdjRPSmJvMkdiL1hwai83Y2ZVUTBZeWM5UGxU?=
 =?utf-8?B?SkdpLzhPNyt0SmgxMzR0TTgzcmxoK0V1L29NVHovMUE5YVJoUld3QTFXQnNN?=
 =?utf-8?B?SHZxYnh5K2JzRzRjemhwM25nN0dMOEJVamVVQ1NVMTY3UC9sckVmUXExUVJp?=
 =?utf-8?B?ejNKRFhwVHJ5aVovbGxFbHR1U2xCdVVFVnJEQ3FJMm5hc1RJZlUrVjQ3YjRW?=
 =?utf-8?B?ZXJjMEg3VGY2bjI5bHZGeVdGY3UvYXV3bW1tekJFS1M0bXphclVpdFlvb3h1?=
 =?utf-8?B?b3VpYW9oVEh1cXRxb1Ard29mN2xvTE1KeU0wR01aVytVQUk5a2RpOWcxUkN1?=
 =?utf-8?B?dXR0MU52UUpQK2RIOWMyZnlIbEFsOEd1Ri80L05xTVRMTVVGUk5PWE5FdVpC?=
 =?utf-8?B?YzlMWU90Wk5YZ1hQTVp5MldSMkxIOS9sRkxjSW1LOWtUSG05eEZPVTZJejFt?=
 =?utf-8?B?VXZhVGNGTnRuak5tY0ZXU3hRSXFQdXJQYVkySnFqTkZja3diaU1LbHhwVHFz?=
 =?utf-8?B?ZVBKRUgyMlpTZ3lNTHgySitLTWNISnB0LzdQWE9zUFdIaFRtbTBYcjVJQVdV?=
 =?utf-8?B?SEtZTlF4bFRKdmgwdnJYVWNBSU9BeWZycEQ0OE1MQUpxeFhBMGVNbmU5K2xs?=
 =?utf-8?B?NVZOV1JBS2poRjF4OVdqYjNiUE1KU2l3eVJraDZuUThidkxBYUpCVEhHd21L?=
 =?utf-8?B?YURuOGx0RzMzdWhNNnZVdjRhbG5GWTZuZmNSNFVHTldIMVRUN21HM1d4SU8w?=
 =?utf-8?B?RVl2QkpSdC9IdlNMKzAzU29MZ1VNbjR5R09iVFpoKy9kOE1MclVUTVhvQmhp?=
 =?utf-8?B?L3JtZzllTlJoeGxYVEg5ZzlYNE9aWnJRb1JpK2hBYXJLVTFsMWZtaHFMQjRW?=
 =?utf-8?B?cVY3RzBvRkNEaVlYOTRsNk54Y3JYTDl4T3pQVXRHV1BKY292dEJaRGpIaUZ6?=
 =?utf-8?B?d3BUSDBLc0d0bWNNQlFvVm9FMXFpTDlRNFZ3djhhVnVtWjVzZXI1RFR5eStj?=
 =?utf-8?B?WkxqLzB4QnpCRlZaeGZ5OStHb2lkek9GeFhmQ1RnNTlkU2pvY3JFT25OY3NH?=
 =?utf-8?B?ZWptM2RxK0sxYTExM3kwd3BubDVERFBoRys1Yms4ekNZNnl3NXMvMXJmbGhC?=
 =?utf-8?B?SEY0RGlKeFRYYTU2SzNPT1NpZC84KzN3a0VzbDVMUlhRYzEvT0Y0MXBzRHll?=
 =?utf-8?B?SVJqUndpZXBOeXhWSElMMkJUNUZrU1B5Z3NVb1pydjlQYVpQSEwrTk9YQ1Mv?=
 =?utf-8?B?aS81REtuc2dUV09GQ0U4MnVKazlGdVQzSVJ6Rk5NdzZIY01Pd3JUZi9jOU1o?=
 =?utf-8?B?ZXkrNExmaEtSVXZoeDJBK2FEZTJDY29YSlp5U240VXptenZDNDJqYTNoS01G?=
 =?utf-8?B?dlAxNXpIcU5SSFZlRW4yRkM5NkFudG1vMzlncmVYNDcwTFRZSUVSbStxM1lt?=
 =?utf-8?B?S2g3d1kvK09rak4zdTYyM2FzMkhEUEtZcmhhb2taTkpucU4vRGdSUGRjQ09Q?=
 =?utf-8?B?RGRhaFpJYzViYUNNeURXSi90QWxVTEFJaGtNWTN1bG9oakFpc3BTa2Vsa2Yy?=
 =?utf-8?B?dUNHbDJ1YW1qVE1wUktMUysxb1crN2lHcWlROVcvQW1GTzEyTjZyRHdCS3R4?=
 =?utf-8?B?bTA0SkpSaXlPUjc2d1MvOFJ0Z24yalhrQ1NKSlZrS2dreU5Ddnd4b0FqRlFq?=
 =?utf-8?B?Z3hXNmhvcFJ6Mk5VcEY3S0lLSitBOEVKMDVYTDh5NHZTOEpmYU9wQmkrOEUy?=
 =?utf-8?B?aUFhbDdUd3ROYkZCcjZvSDZmQnRBaWRtcmtvZjNsb0swSFl3UG1FZFpJMDd2?=
 =?utf-8?B?MzJOaklkck9BQlhSL3JVMDZHdytRTnFWTjFvK0haQk9rR0JqbEwzR0ZNOGE2?=
 =?utf-8?B?blR3SW45VVZyYlh6YTQvODNnZEJsVzl2QUtLL0hnMGdCUVdsazFWbjVzd3pB?=
 =?utf-8?B?ODBRMGkwY3Y1T2RFaVd1bkQrVFJ3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F2DB952FAC2D45489DB79787DAE64151@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GWSxuAhccXQ5dan5T9q6KR/zNSP9FqyZAGVJ85KH9Ox9QpSrpHoLLkcFZxIGZ458eXlNL+JDVmuxgY5ZRQRfjwGTrLCmCP8qNkcl/ZBazGMgYHEfR9+ubqr1iJ4cx349MlUl9F0JQAs5sa/+lEqqXHzwi5REuXYmKHyuMYVS9N5p76QBGEg02La4Xu0iDpqCSn6qULOk73SVsR82FwIM//gtx0QrQhRqkKcfFzmCwDp3JVDzt1WZrco/yBhYoYBKNaJczpwwV3hJGlL1ZEjpm/5S0zghvVHkVnYywe5dbJBytRHFJMWWfwmqU0wepl9s5pM2HnwN9E4GZ3QNsyW32SzvAy3IdUS1jzf20YrDFk8oHbXqb1y6BECf7U6u70xlXEl6Fj6fvcxCF9sG1tSmEmTTzwZ0QHJtAmS5Wl0dQjMklTtOlgoIX+fHCORFAcpwLoT62Tqw3Wwqsn+gIkZvq6gNc0bzNRxPcTFveFVwDiIlr5j7YrmyZsYuLa9P0mlb2DKr+feCn+5ZYETnr2LXYxo9StMqH7KjO3C07Z2vcUEojM7pMMcq9uEvOY5O5UrZfD5E8B6IyczWYwNzYIuhGCbDLW0z9GYXQgU3zmNkbkLiojjQ4ToaeGkDcSWy0Tut
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddd84c5c-9f09-44a8-e588-08de3baa45d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2025 07:19:23.4901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 92UAmwPy7d/izC8qNuOL9LgxCGJpwI+DVFxaiExD8cyWJjR07uh6SFzjSOQNeVBiw3m2Gm1S2GX+M0IVLmCkmaX5QnyFCaXKhSLXk5qqC9M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7448

T24gMTIvMTUvMjUgNzoxMCBBTSwgTmFvaGlybyBBb3RhIHdyb3RlOg0KPiBPbiBTYXQgRGVjIDEz
LCAyMDI1IGF0IDI6MDMgUE0gSlNULCBKb2hhbm5lcyBUaHVtc2hpcm4gd3JvdGU6DQo+PiBDdXJy
ZW50bHkgdGhlIHpvbmVkIHN0YXRzIGFyZSBjb25maW5lZCB0byB0aGUgZmlsZXN5c3RlbXMgYWN0
aXZlIHpvbmVzDQo+PiBhbmQgbm90IHRvIHRoZSByZWNsYWltYWJsZSB6b25lcy4NCj4+DQo+PiBB
bHNvIHByaW50IHRoZSB6b25lIGluZm9ybWF0aW9uIGZvciB0aGUgcmVjbGFpbWFibGUgem9uZXMu
DQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogSm9oYW5uZXMgVGh1bXNoaXJuIDxqb2hhbm5lcy50aHVt
c2hpcm5Ad2RjLmNvbT4NCj4+IC0tLQ0KPj4gICBmcy9idHJmcy96b25lZC5jIHwgMjEgKysrKysr
KysrKysrKysrKysrKy0tDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspLCAy
IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9mcy9idHJmcy96b25lZC5jIGIvZnMv
YnRyZnMvem9uZWQuYw0KPj4gaW5kZXggNjk4M2U3MTc3YzBhLi5kZDZhNmE1ZjViNGUgMTAwNjQ0
DQo+PiAtLS0gYS9mcy9idHJmcy96b25lZC5jDQo+PiArKysgYi9mcy9idHJmcy96b25lZC5jDQo+
PiBAQCAtMjk5MCw2ICsyOTkwLDcgQEAgdm9pZCBidHJmc19zaG93X3pvbmVkX3N0YXRzKHN0cnVj
dCBidHJmc19mc19pbmZvICpmc19pbmZvLCBzdHJ1Y3Qgc2VxX2ZpbGUgKnMpDQo+PiAgIAlzdHJ1
Y3QgYnRyZnNfYmxvY2tfZ3JvdXAgKmJnOw0KPj4gICAJdTY0IGRhdGFfcmVsb2NfYmc7DQo+PiAg
IAl1NjQgdHJlZWxvZ19iZzsNCj4+ICsJc2l6ZV90IHJlY2xhaW1hYmxlOw0KPj4gICANCj4+ICAg
CXNlcV9wdXRzKHMsICJcbiIpOw0KPj4gICANCj4+IEBAIC0zMDAwLDggKzMwMDEsOCBAQCB2b2lk
IGJ0cmZzX3Nob3dfem9uZWRfc3RhdHMoc3RydWN0IGJ0cmZzX2ZzX2luZm8gKmZzX2luZm8sIHN0
cnVjdCBzZXFfZmlsZSAqcykNCj4+ICAgDQo+PiAgIAltdXRleF9sb2NrKCZmc19pbmZvLT5yZWNs
YWltX2Jnc19sb2NrKTsNCj4+ICAgCXNwaW5fbG9jaygmZnNfaW5mby0+dW51c2VkX2Jnc19sb2Nr
KTsNCj4+IC0Jc2VxX3ByaW50ZihzLCAiXHQgIHJlY2xhaW1hYmxlOiAlenVcbiIsDQo+PiAtCQkJ
ICAgICBsaXN0X2NvdW50X25vZGVzKCZmc19pbmZvLT5yZWNsYWltX2JncykpOw0KPj4gKwlyZWNs
YWltYWJsZSA9IGxpc3RfY291bnRfbm9kZXMoJmZzX2luZm8tPnJlY2xhaW1fYmdzKTsNCj4+ICsJ
c2VxX3ByaW50ZihzLCAiXHQgIHJlY2xhaW1hYmxlOiAlenVcbiIsIHJlY2xhaW1hYmxlKTsNCj4+
ICAgCXNlcV9wcmludGYocywgIlx0ICB1bnVzZWQ6ICV6dVxuIiwgbGlzdF9jb3VudF9ub2Rlcygm
ZnNfaW5mby0+dW51c2VkX2JncykpOw0KPj4gICAJc3Bpbl91bmxvY2soJmZzX2luZm8tPnVudXNl
ZF9iZ3NfbG9jayk7DQo+PiAgIAltdXRleF91bmxvY2soJmZzX2luZm8tPnJlY2xhaW1fYmdzX2xv
Y2spOw0KPj4gQEAgLTMwMjYsNCArMzAyNywyMCBAQCB2b2lkIGJ0cmZzX3Nob3dfem9uZWRfc3Rh
dHMoc3RydWN0IGJ0cmZzX2ZzX2luZm8gKmZzX2luZm8sIHN0cnVjdCBzZXFfZmlsZSAqcykNCj4+
ICAgCQkJICAgYmctPnpvbmVfdW51c2FibGUsIGJ0cmZzX3NwYWNlX2luZm9fdHlwZV9zdHIoYmct
PnNwYWNlX2luZm8pKTsNCj4+ICAgCX0NCj4+ICAgCXNwaW5fdW5sb2NrKCZmc19pbmZvLT56b25l
X2FjdGl2ZV9iZ3NfbG9jayk7DQo+PiArDQo+PiArCWlmIChyZWNsYWltYWJsZSkgew0KPj4gKwkJ
c2VxX3B1dHMocywgIlx0cmVjbGFpbWFibGUgem9uZXM6XG4iKTsNCj4+ICsJCW11dGV4X2xvY2so
JmZzX2luZm8tPnJlY2xhaW1fYmdzX2xvY2spOw0KPiBJIHRoaW5rIHdlIGRvbid0IG5lZWQgdG8g
dGFrZSB0aGlzIG11dGV4IGhlcmUuIEFzIGxvbmcgYXMgd2UgdGFrZQ0KPiB1bnVzZWRfYmdzX2xv
Y2ssIHRoZSBCR3Mgc3RheSBvbiB0aGUgbGlzdCwgYW5kIHdlIHNob3VsZCBiZSBhYmxlIHRvDQo+
IGFjY2VzcyB0aGUgZmllbGRzIHNhZmVseS4NCj4NCj4gV2VsbCwgb25lIG9mIHRoZSBwcmludGVk
IEJHcyBjb3VsZCBiZSByZWxvY2F0ZWQgYXQgdGhlIHNhbWUgdGltZSwgYnV0IEkNCj4gZG9uJ3Qg
dGhpbmsgdGhhdCdzIGFuIGlzc3VlIGhlcmUuDQo+DQpJIHRoaW5rIGl0IGlzLCBiZWNhdXNlIEkg
aW5mcmVxdWVudGx5IHNlZSBjcmFzaGVzIHdoZW4gdXNpbmcgd2F0Y2ggLW4xIA0KY2F0IC9wcm9j
L3NlbGYvbW91bnRzdGF0cyBhbmQgaW4gYSAybmQgdGVybWluYWwgaGFtbWVyIHRoZSBGUy4gU28g
YXQgDQpsZWFzdCB0aGlzIHBhdGNoIGlzIGJ1Z2d5Lg0K

