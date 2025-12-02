Return-Path: <linux-btrfs+bounces-19451-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0B6C9AB2C
	for <lists+linux-btrfs@lfdr.de>; Tue, 02 Dec 2025 09:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D69A0344896
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Dec 2025 08:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156FD23D2B4;
	Tue,  2 Dec 2025 08:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="L1ZM1DJv";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="C+s7JxkP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C90C3FF1
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Dec 2025 08:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764664449; cv=fail; b=M5YsE602t1EjBCLxbUmDM0zI8MKBq+W3bFgM84qWX5JBl4MadJNmxiy5V9t/wWOU5KUarxXOTNwmV99nqI9zWfB74iXiJ1O7BaRKlddHkk9sgzlZPb1aFxnWa3Yo6qyHOv1O65WMBeqRh+/FJ7yxh1UWl1dSfJHxwvMK6qwEgXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764664449; c=relaxed/simple;
	bh=fZQuPLFttOF750hJQh+84IypB/91nmAI5lSYQKWVmW0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Na/0QNnR6S7I1jt2zjyr5N2UwsFXorRuRihPTmaHM6UuJRRXxglcmakT6Z/YjsiXmHoVJmN2bc4wvGNUiKuFwaTVymCLePOPTcLJqYeLx+CfMy1vyoPjoD6TexrJo7QcDZvAV3ZDMVM7VVDDEhKHrq2l1ol4q4/MnDRZo4mA8aw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=L1ZM1DJv; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=C+s7JxkP; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1764664447; x=1796200447;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=fZQuPLFttOF750hJQh+84IypB/91nmAI5lSYQKWVmW0=;
  b=L1ZM1DJvbCUkVM/D4U5dvQZStRLMW1YASjPTfgh/XFwcD3hWmmwEm1U6
   a+nY+V17FE/9kSU5fnEIJ+CkFXWV+052etTAn1CBjA1jY+kbRTQ8nDsDI
   vuxmb0cMNqLaV3evb7c/LEcKli42JgeNNbksgyChWaJInr2MIIYUbZvKk
   hBsYTX7x3JNO4PSuesP7LYnmYsGxcVuEvawS7A1EhSpfmEhU7qDYLGhRb
   NGH7ifp/v1WLXG+hWsM38Fv/6g6LSH/OP8k3Pku7t1XabWHLmwCU4mc7i
   FHH3sMcbEhoNltQbNf0ddXys9Hwncgq9fjFg+GtgJQTnJ++JymUsJUvcv
   A==;
X-CSE-ConnectionGUID: xu5YZI9zTBmHW2qEeT8juw==
X-CSE-MsgGUID: dyzuz0/NSU6Qw28QdR8IOg==
X-IronPort-AV: E=Sophos;i="6.20,242,1758556800"; 
   d="scan'208";a="136226792"
Received: from mail-eastusazon11012037.outbound.protection.outlook.com (HELO BL0PR03CU003.outbound.protection.outlook.com) ([52.101.53.37])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Dec 2025 16:34:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UxZPblM/XesYM85qKjuGei0b0U+lCjDaVGH1dwwZLr/huu4QlXPuIbnth0E6FhLnUcMkkeNoL7ioJgPvKIAoKpp5SMGxuWDtV+0iCUijI1rEykn7q23XpaCGzRKcejfdiH/fsnTB9smF8jSsGCqeemJym1wmf5xap++IIx63CRGn0ii1LG2oEw2LtUVqR/ij9pBMQTpmdkK+OuCoyhZNljWKl19MATROcWfQinS55p97owmMHq65s2bRhaZUGx1v2D29/11TlfiZeQH8V+c+o6BwQhofZ6k6fWOLhxV0EOh57DUike2/ltB+4VEMbI2cwQGXhh1XbNVmx4znNp5fkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fZQuPLFttOF750hJQh+84IypB/91nmAI5lSYQKWVmW0=;
 b=godLUVm0NU24y1/B3CVe6cHXYyxRfzWLM+PxuhiDQHeRgDsf9m1M4sMAZgqAHi5DODgCyJmZ+A/bUKgAs1JO8yFRK7piF3nbsorwK4sdm9z2TZMJXZYURnM5hgkJ3DFRRFElxLu0qncSekt+2xw3q0+HUWrx3OgJ2d5x8/rYzeISW8re1Mvuql+BxnXa+ESpabRvyrdacwOdgnPM4R/quZIDnnAu+fGto30qy+N2CzwQqHLn4K8eOsn3owSFX1HTwtRope2CcNCQmeJknODxPP65B9VbEkUpf6+y8LTQbwml1EzWdhq6UYsrhlAuqAMXlO2S6pdzU0OgWGnzjg3wfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZQuPLFttOF750hJQh+84IypB/91nmAI5lSYQKWVmW0=;
 b=C+s7JxkPk9oTRFIGiO6FXcw/YTtktWtB3dnE0XEk4nYq45reiTp9lM716HI4esqsB8XJb4Zgrz98wzjr9c6dpBLOqyZHZSvAGLMMqPaPcEnySbhihZmPhcdh6FjLzMERDHMLN6PEiPU0neBV7dfUopmhcJhaJddJjcJab44iE3M=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by BN0PR04MB8112.namprd04.prod.outlook.com (2603:10b6:408:144::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Tue, 2 Dec
 2025 08:33:48 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%7]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 08:33:48 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: HAN Yuwei <hrx@bupt.moe>, Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	linux-btrfs <linux-btrfs@vger.kernel.org>
CC: Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [BUG] 6.18-rc7 cannot mount RAID1 zoned btrfs.
Thread-Topic: [BUG] 6.18-rc7 cannot mount RAID1 zoned btrfs.
Thread-Index: AQHcYFs7YSrT6wG320KO9dO6k+5PS7UIL5IAgAAJsgCABdLGgA==
Date: Tue, 2 Dec 2025 08:33:47 +0000
Message-ID: <DENLBYCUSKZP.13MWTQQNEAUBW@wdc.com>
References: <0BED8C36F63EBD8F+f61c437e-3e5f-4a1c-9c18-17fd31abfcd4@bupt.moe>
 <e865d52c-8f07-431a-8fff-907bd6cfb0e8@wdc.com>
 <F24595B65EF81413+dddb8a6c-9da6-4480-b168-fcfa20d3c296@bupt.moe>
In-Reply-To: <F24595B65EF81413+dddb8a6c-9da6-4480-b168-fcfa20d3c296@bupt.moe>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: aerc 0.21.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|BN0PR04MB8112:EE_
x-ms-office365-filtering-correlation-id: c6a62d7e-a234-4786-ffa4-08de317d8389
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?bkZOU3EwVWU1R1M5TE9tMU5sTkJTSTZ0bFM3Z1FwSzlOT0huVlo5UlplSGFC?=
 =?utf-8?B?Q1dqREtUNVNRTHhZTzJNZkhjMm1iQmZGd0NWMmJCTXJacHhnQ0JneXNqa1J4?=
 =?utf-8?B?UWxwYW44K1ZCb29ENUtrWWhNd0pFeUQ2ZlZFcDlwcEZHYWxJVk0vM1M3R0VM?=
 =?utf-8?B?NjZleDlHaEp2SE1KV1NmdDJSUWtVSFJ6djdZaG9uNFE2amwrUEpoVkcxNHph?=
 =?utf-8?B?TkpyVVdIU08xY1BrS3Fvek9XQ0I2TjFUQ2M0OEpBL0Z6RUJWaStZVmVBMXR5?=
 =?utf-8?B?RXppOFM3M1Vjckk2TmdZZFRXVFI4OWd3SEhuUjF5MDhxc3ZQOHMxUUlzTUZj?=
 =?utf-8?B?YkJmSDlvYXErZFZQLzlzalZ2Tnd1MTBkSzhGaUt1Tm4wMGh2Wmg5cmVCNVF2?=
 =?utf-8?B?ZlN4MHdvNEhBb1NTM0IvZm1pQk1XNnJiSnQ1VXdObkdlYjFuQWJIVGI3QVlU?=
 =?utf-8?B?WEs1c1V2U2pCQXpvS3RTUmlQWnE3em5aSWg0aGxGQlN1ZVJSRGx5WUsvZ1Qw?=
 =?utf-8?B?ZmVQZVFUSWhRb0dGbDdJK3FNYUN0TU5obGxkUE9UNUs0TUJnZS9EUWFnWVkz?=
 =?utf-8?B?djFKM1pGZytyRVZtemZCdVJ4Q2ZhMW9BaXZ2UktmbEZkU2R0NnBINXp3dXdR?=
 =?utf-8?B?eU0wb1lmcDFDdlJlVVYzSHFOc1ExYTZZOExPdGF1dzFFUVdXTGE4SzRXdmRl?=
 =?utf-8?B?OUlTbUZwbXB3MmpqZ3lIZTNRUFFGbHVTeUFsNW9DTnBVVmNXQzE4Um0zdWVN?=
 =?utf-8?B?MENXNUJudElNUkxOcVB5Vjd4YkNWZnFqTWpVdXV1NE11VXBoa3JidFhKYThC?=
 =?utf-8?B?N0YzMWNDbGRpaEozSVBnR3R2OWowVHJkbzk1cXNmend0c0lRVnJBd2dFdWxR?=
 =?utf-8?B?Z2xSekJSLy9pRU1oRlN0dmdkRDAvLzhxWGptV3BsMDFoelpJS2ZYblFENzlR?=
 =?utf-8?B?bTlLQUYzL0xwTzdkc203aUNoNEprS2hIK2RPa3hKc0dkYXptY3g2WWZ1NXJ3?=
 =?utf-8?B?NFc2YmJmVHlhVGdDMWpuWEhMMm1qQjNncGhFUzdTOURrNitremdCV3lrNEhQ?=
 =?utf-8?B?ckxTbmNOYWpLb2JQVTlwYXNTOVhiQVA2b3ZXNEs3UmE4MDh4TWp1cEQ5RVpS?=
 =?utf-8?B?VmVtblRwbE1rYzM2dUNaWkhVU0tLa2ZJSkVsY3hQUC9JcWYzZGpVeFVCaGEw?=
 =?utf-8?B?V3U1RXpwQXJ6SkE5eVBBa2dRTW1RZFhWQXR6dnR3bnhxN0wwK1pubjZJV1dk?=
 =?utf-8?B?TlczaWlEZlJhN3dmZ09zUnE5aktrNUJrd25vUjVCTG9NMURHWUhqZVF0Y2Ir?=
 =?utf-8?B?ZFVkU25NaUJ5bUxydkJqOXI4ZEdlUFpmdlliUloxN2MzYU5BWCtFS0xady9s?=
 =?utf-8?B?cE9oTjNpREFyTUU5OFVlRkd0NkJxNmFYVUtEUnNzYVBZNndhMEp0bTJWZzFR?=
 =?utf-8?B?ay83ZWFHU29SMjc1R2tsQkZtUCtNWWVtd01MckkzZm1KTEhlUmpSTWFZYzIw?=
 =?utf-8?B?UVpNL25UMlVJbFIzbzA0MUJTSjZaeitzSlpDNEVYeTRXaUQxMVptYXMrOFdO?=
 =?utf-8?B?WmxKQXlwTC9CbGx0YnNEcFMvdnZuSEtObnlqODY0REdLUm9oZXM5THFBVFNr?=
 =?utf-8?B?R2RrbmtSVWNnVDZEeW5nK25MSnR1eWFqb1I0bTkzbzJBTkJXK2tGT3d0SDhh?=
 =?utf-8?B?S0dUU1V3MXpHejZKYWhZYkpjMVY3VDdyREZINm91Nk9haEd6WFlLUDFyTFQ4?=
 =?utf-8?B?Z0VXYUF2WGN6bUtYN3piMFVDaUNPM20xbGd2eXZZQVV1RzRIVXE5L2JYczQ2?=
 =?utf-8?B?SVhpaUlWSE40SmlmWEx0S0JadnNLYXIyUTBxMitYbUVRckJVVlFHeTE0bXBq?=
 =?utf-8?B?UWp6SWJSQlJPZ2VzQy83cHBLSWhJSDM4N0Z6SGgrRTJJc08zQjVXbnc3dEVE?=
 =?utf-8?B?c0Z5TU5MVm1hdTYyUXZOVGtiS0o4cllNYVIzaDdVYkxFTVNOWHlhWGVSdUt2?=
 =?utf-8?B?Q2UydUdhcllOaXEvYkdZZUdsTkZML0NHYkJrWHNzTG5DNE1jaUdlRU1NRnNN?=
 =?utf-8?Q?vEvesm?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RWJlVFR4OVVSREdZV21hVVBIZmVOTi80TmFocXpWWVVBOFB0TE5LTGhpZ0s4?=
 =?utf-8?B?aUVhT01yTzJrRTFzY2UwQTBrdUx2V2VPZkxNY0wwaWxjT3BEdGo0Z3JhbkMx?=
 =?utf-8?B?eHFJNUFuMVdaek05ejVtVStwb0tmSmxOSFFLRUlRaFhJRnd0OUxMTnAwTlJX?=
 =?utf-8?B?SEFsUzh2RG44MERob0NUSjNIRWs1SWdQMjRMWkw3ZU5QZTZnUWZucE1aK0hv?=
 =?utf-8?B?NHhHWGZLTkZRYXpKcFNRRlVOTDg5V0FxU2V0RlNOS3doZFNEWkhsU3RtWDAx?=
 =?utf-8?B?M3VLUUxuL01ic29KdzhqQ1B3TzA3U24zdEwyRHgrS0RPL1ppMGcxOHJxWlRW?=
 =?utf-8?B?OUtSS1hodEpBVzRTWGp5UFZ5L056Wkg2a1BsVkdTU3BtUExORGNhd0N0OGFB?=
 =?utf-8?B?NEFwb3ZKWmlLdGpqV3JGWjhHallLSWpXTXNKZFFZQ0RDYzgwQUtmekViN285?=
 =?utf-8?B?MWRxNFBzQiswNWs4UnNLZEE0YVR6SEtwbXYyYnVLSVRhQVA1ckFnbVJXNXZ6?=
 =?utf-8?B?MkNGb0F3Tm1DTWxzckh0NkpOQXFnNjBiNE1QYTdRTmliaE5ZTlh2NmZuektJ?=
 =?utf-8?B?d0Q0K0w3OWt5YjkyclFhZEFaOWlPN2FNcmRteE9NK3YrWVRSZGdSQTdDSm5u?=
 =?utf-8?B?djF6Z3REcTBMTkRYeFpPNXdPS3NSTXBzWTAxM1M3Sm9zcEFTVkRvUHU5Tmkx?=
 =?utf-8?B?MVVHVU82UnZtck0yRmxmM0FSVllET1F6UnNLMndrSlNHNlpHOWo3U3JpOGpj?=
 =?utf-8?B?UXF0NFVEK3BVQk9sU1ZzeWx0N1FiZ1hON2Jad21LUFIrY0JyMHZaS0x1OHVw?=
 =?utf-8?B?cEFTd1Fuc2krSVpjSGtXY2lqV2xETWxaWkx4bUhRS3ZUV255bDJJRy9OWXRF?=
 =?utf-8?B?aHA5cGVBNHM4QUljS1Q5UDc2SDgrMS9xa3lXTkpJV3pNNHRsYW43bWFvQ3or?=
 =?utf-8?B?cUl3azVqYzRDOFdhTHppZG1KMldaWXlVdWtzVEhVZ1JpQm9KUlp1V2JlQWVD?=
 =?utf-8?B?Tk1sSWtKNnI1MVNRU0VCNVdoa2xHVGxPQmZiRVJFOVFaMTF3Y2FyYTZJNDV3?=
 =?utf-8?B?UkNQMjBXb0Mza1pDVEF4QzZYZjFBR21iOVUwS051d3U0MUd4WnpmSGQybkVN?=
 =?utf-8?B?Y21CdzNKUjMrVWVPTmdBa01UVXNmME1ESllkL1FoWTdBN3RqeEtiQ21oU3pC?=
 =?utf-8?B?T2Mxb2VBNG9KSk8rNndNRG5vM1RzVVg4ZnNOVjlqSExoNlptdngxeWYrNWlI?=
 =?utf-8?B?dEpIb3ZsMXhOT2xaekJyOUh5V0FMRUh3Q1NOZElDQjVvc3hCNW1aYTJLeFJL?=
 =?utf-8?B?cGYxQkRyL25rUENZa1NVbHRKTC80eC9mS3hObFF6YWM1MDYrOU5rWVBiTzZK?=
 =?utf-8?B?NFFoaDFyZlZPREU5QnpYSFRvQ1d6N0prMVBaTmFHaGdKRmxpYXhIaWpTZElP?=
 =?utf-8?B?RHI0bWVraXlmb2EzS2U5V2pwSVN6YW5kdnJEbnU2U3VNK1gyb0RtTlNHOW00?=
 =?utf-8?B?dVlHVGxWM3lPOEhVQ3B0WUhGQ1MvMlRKWlB2T1JRUWQ5MEZKM0tnY1ErZ013?=
 =?utf-8?B?R1g1UGpDRXdwdnNoNWordVRNWUppbmhXWXYvYmNaYWk4S3lmYnUyclA4SStK?=
 =?utf-8?B?SmdubGlYTUliV0RuZlIzRjM3VDhBc2N5Q0x1elFzMlJXUndwbmxKczdpbllJ?=
 =?utf-8?B?VFg0ZWpvZWQwN1Vod2tSRUZhaHlGRjkyQURuVnYrZ1RVVGE3M3N1MFNuWjIx?=
 =?utf-8?B?a3gzdkRYM1lSMktQYXgwdDZmbXVXdG9RQ2NOUzJ4aGZjMzRwWEJvWlpIR3dm?=
 =?utf-8?B?cDVnQktNSUU3czJpeHlpWEQ0L3lMdml2aVJRLzNHVy8ycnlGTG9tdSsrQ2h2?=
 =?utf-8?B?eEYzcldNT3JVbkRCQmFjejJjZ3d3TEFjZ1ZIM3VwanFjaS9uREFyNnQ0SVp4?=
 =?utf-8?B?eVo2bVo5d1hFZUkyU0FweXd0dk5FZ0JaczUvdmtqSTMyM1QrZmFxL3VqVGNj?=
 =?utf-8?B?cXlkN2VZMk5CZjFHR2kvMk9WZG95ek5zYUpxT3JkNjZscjB0SXArUlZydDNX?=
 =?utf-8?B?V29tdXp2c2JnajhQVHloOHUwcnJRSldFVDVJdkl3NXd5dXZvbTNSYXcvdUMy?=
 =?utf-8?B?MEpoZ05OWjRYWTlOdFVQVFMyMGZxejEwWmVDb212LzNpMUlzTHZ6VVJSczR3?=
 =?utf-8?B?WHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8957A1A75EC194458B38B5EFEB2FE4A2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aYM9kEvN6d+8gCxi5xjZzAF3ZpnXbJj6ijlwd6U1UDYi+tgnLCh4znHcSqn/1WiEiQMkGdzeLrpWMHxv1jUJrJ4gBweUclug5Vob2qCJSJ2JOrKEkbVihS2RKkwGCtUvQPphD6tzlQ/tDgewtR/CmZvcMCYlvzNqM8JdEdzw/+9CHCM3Uv++pGzGngTZAAp84zoZpCLRCpd7u4AOmhdOmcsXSpOAM68bCFCiCUO/SkpHpHKIFLR73lWjHBToqpcFV9sdHKjjvd9CrWRInVaJs8FKI/vfDMIICQ1I/GGezT55WR23G3hq9UYSRAtzLMyL/NhDEiL+m22Qe+AWWzN+65CZbcOU1Chq/FdsiJWwPC3ASeuh39PHrd3Gt5KDxxkVI2ebNYT6b75SvT/rTjh9UYAqMbiPIZ9F0U5/z4T8yNSqcr/FyykxZ0kbGnjGLl5pRUNdaMNxfQBah7KUKrdcrjJDPQ9an8E+SkixDuEkt+Qc+6Qc88xOsziMgVpftDIg7Ru7wdbsDHB9V+x5Fye7PNiRwmwetMhjkP0aYqOGN3TkKf7Lir+iy3EYwnW1D/v4uHvk/jgLgmGP+Ns/bSxxBu5bo6BX6y1sVofJzBhmMN2hFM71Dea2++L47ABYsQA2
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6a62d7e-a234-4786-ffa4-08de317d8389
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2025 08:33:48.0625
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HujAJQuO2+5MIRLldNN5wP5xD9TF5wv8p5DE5HGUl4iQHSav2KQlc2DlNl1ofaGk60L/RRrgB7UFtI1wNXhAKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB8112

T24gU2F0IE5vdiAyOSwgMjAyNSBhdCAxMjozOCBBTSBKU1QsIEhBTiBZdXdlaSB3cm90ZToNCj4g
5ZyoIDIwMjUvMTEvMjggMjM6MDMsIEpvaGFubmVzIFRodW1zaGlybiDlhpnpgZM6DQo+PiBPbiAx
MS8yOC8yNSAxMjozNiBQTSwgSEFOIFl1d2VpIHdyb3RlOg0KPj4+IC9kZXYvc2RkLCA1MjE1NiB6
b25lcyBvZiAyNjg0MzU0NTYgYnl0ZXMNCj4+PiBbICAgMTkuNzU3MjQyXSBCVFJGUyBpbmZvIChk
ZXZpY2Ugc2RhKTogaG9zdC1tYW5hZ2VkIHpvbmVkIGJsb2NrIGRldmljZQ0KPj4+IC9kZXYvc2Ri
LCA1MjE1NiB6b25lcyBvZiAyNjg0MzU0NTYgYnl0ZXMNCj4+PiBbICAgMTkuODY4NjIzXSBCVFJG
UyBpbmZvIChkZXZpY2Ugc2RhKTogem9uZWQgbW9kZSBlbmFibGVkIHdpdGggem9uZQ0KPj4+IHNp
emUgMjY4NDM1NDU2DQo+Pj4gWyAgIDIwLjk0MDg5NF0gQlRSRlMgaW5mbyAoZGV2aWNlIHNkZCk6
IHpvbmVkIG1vZGUgZW5hYmxlZCB3aXRoIHpvbmUNCj4+PiBzaXplIDI2ODQzNTQ1Ng0KPj4+IFsg
ICAyMS4xMDEwMTBdIHI4MTY5IDAwMDA6MDc6MDAuMCBldGhvYjogTGluayBpcyBVcCAtIDFHYnBz
L0Z1bGwgLSBmbG93DQo+Pj4gY29udHJvbCBvZmYNCj4+PiBbICAgMjEuMTI4NTk1XSBCVFJGUyBp
bmZvIChkZXZpY2Ugc2RjKTogem9uZWQgbW9kZSBlbmFibGVkIHdpdGggem9uZQ0KPj4+IHNpemUg
MjY4NDM1NDU2DQo+Pj4gWyAgIDIxLjQzNjk3Ml0gQlRSRlMgZXJyb3IgKGRldmljZSBzZGEpOiB6
b25lZDogd3JpdGUgcG9pbnRlciBvZmZzZXQNCj4+PiBtaXNtYXRjaCBvZiB6b25lcyBpbiByYWlk
MSBwcm9maWxlDQo+Pj4gWyAgIDIxLjQzODM5Nl0gQlRSRlMgZXJyb3IgKGRldmljZSBzZGEpOiB6
b25lZDogZmFpbGVkIHRvIGxvYWQgem9uZSBpbmZvDQo+Pj4gb2YgYmcgMTQ5Njc5NjEwMjY1Ng0K
Pj4+IFsgICAyMS40NDA0MDRdIEJUUkZTIGVycm9yIChkZXZpY2Ugc2RhKTogZmFpbGVkIHRvIHJl
YWQgYmxvY2sgZ3JvdXBzOiAtNQ0KPj4+IFsgICAyMS40NjA1OTFdIEJUUkZTIGVycm9yIChkZXZp
Y2Ugc2RhKTogb3Blbl9jdHJlZSBmYWlsZWQ6IC01DQo+PiANCj4+IEhpIHRoaXMgbWVhbnMsIHRo
ZSB3cml0ZSBwb2ludGVycyBvZiBib3RoIHpvbmVzIGZvcm1pbmcgdGhlIGJsb2NrLWdyb3VwDQo+
PiAxNDk2Nzk2MTAyNjU2IGFyZSBvdXQgb2Ygc3luYy4NCj4+IA0KPj4gRm9yIFJBSUQxIEkgY2Fu
J3QgcmVhbGx5IHNlZSB3aHkgdGhlcmUgc2hvdWxkIGJlIGEgZGlmZmVyZW5jZSB0b3VnaCwNCj4+
IHJlY2VudGx5IG9ubHkgUkFJRDAgYW5kIFJBSUQxMCBjb2RlIGdvdCB0b3VjaGVkLg0KPj4gDQo+
PiBEZWJ1Z2dpbmcgdGhpcyBtaWdodCBnZXQgYSBiaXQgdHJpY2t5LCBidXQgYW55d2F5cy4gWW91
IGNhbiBncmFiIHRoZQ0KPj4gcGh5c2ljYWwgbG9jYXRpb25zIG9mIHRoZSBibG9jay1ncm91cCBm
b3JtIHRoZSBjaHVuayB0cmVlIHZpYToNCj4+IA0KPj4gYnRyZnMgaW5zcGVjdC1pbnRlcm5hbCBk
dW1wLXRyZWUgLXQgY2h1bmsgL2Rldi9zZGEgfFwNCj4+IA0KPj4gICDCoCDCoCDCoGdyZXAgLUEg
NyAtRSAiQ0hVTktfSVRFTSAxNDk2Nzk2MTAyNjU2IiB8XA0KPj4gDQo+PiAgIMKgIMKgIMKgZ3Jl
cCAiXGJzdHJpcGVcYiINCj4+IA0KPj4gDQo+PiBUaGVuIGFzc3VtaW5nIGRldiAwIGlzIHNkYSBh
bmQgZGV2IDEgaXMgc2RiDQo+PiANCj4+IGJsa3pvbmUgcmVwb3J0IC1jIDEgLW8gIm9mZnNldF9m
cm9tX2RldmlkIDAgLyA1MTIiIC9kZXYvc2RhDQo+PiANCj4+IGJsa3pvbmUgcmVwb3J0IC1jIDEg
LW8gIm9mZnNldF9mcm9tX2RldmlkIDEgLyA1MTIiIC9kZXYvc2RiDQo+PiANCj4+IA0KPj4gRS5n
LiAob24gbXkgc3lzdGVtKToNCj4+IA0KPj4gcm9vdEB2aXJ0bWUtbmc6LyMgYnRyZnMgaW5zcGVj
dC1pbnRlcm5hbCBkdW1wLXRyZWUgLXQgY2h1bmsgL2Rldi92ZGEgfFwNCj4+IA0KPj4gICDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGdyZXAg
LUE3IC1FICJDSFVOS19JVEVNDQo+PiAyMTQ3NDgzNjQ4IiB8IFwNCj4+IA0KPj4gICDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBncmVwICJcYnN0
cmlwZVxiIg0KPj4gICDCoCDCoCDCoCDCoCDCoCDCoCBzdHJpcGUgMCBkZXZpZCAxIG9mZnNldCAy
MTQ3NDgzNjQ4DQo+PiAgIMKgIMKgIMKgIMKgIMKgIMKgIHN0cmlwZSAxIGRldmlkIDIgb2Zmc2V0
IDEwNzM3NDE4MjQNCj4+IA0KPj4gcm9vdEB2aXJ0bWUtbmc6LyMgYmxrem9uZSByZXBvcnQgLWMg
MSAtbyAkKCgyMTQ3NDgzNjQ4IC8gNTEyKSkgL2Rldi92ZGENCj4+ICAgwqAgc3RhcnQ6IDB4MDAw
NDAwMDAwLCBsZW4gMHgwODAwMDAsIGNhcCAweDA4MDAwMCwgd3B0ciAweDAwMDAwMCByZXNldDow
DQo+PiBub24tc2VxOjAsIHpjb25kOiAxKGVtKSBbdHlwZTogMihTRVFfV1JJVEVfUkVRVUlSRUQp
XQ0KPj4gDQo+PiByb290QHZpcnRtZS1uZzovIyBibGt6b25lIHJlcG9ydCAtYyAxIC1vICQoKDEw
NzM3NDE4MjQgLyA1MTIpKSAvZGV2L3ZkYg0KPj4gICDCoCBzdGFydDogMHgwMDAyMDAwMDAsIGxl
biAweDA4MDAwMCwgY2FwIDB4MDgwMDAwLCB3cHRyIDB4MDAwMDAwIHJlc2V0OjANCj4+IG5vbi1z
ZXE6MCwgemNvbmQ6IDEoZW0pIFt0eXBlOiAyKFNFUV9XUklURV9SRVFVSVJFRCldDQo+PiANCj4+
IE5vdGUgdGhpcyBpcyBhbiBlbXB0eSBGUywgc28gdGhlIHdyaXRlIHBvaW50ZXJzIGFyZSBhdCAw
Lg0KPj4gDQo+ICMgYnRyZnMgaW5zcGVjdC1pbnRlcm5hbCBkdW1wLXRyZWUgLXQgY2h1bmsgL2Rl
di9zZGF8XA0KPiBncmVwIC1BIDcgLUUgIkNIVU5LX0lURU0gMTQ5Njc5NjEwMjY1NiJ8XA0KPiBn
cmVwIHN0cmlwZQ0KPg0KPiBsZW5ndGggMjY4NDM1NDU2IG93bmVyIDIgc3RyaXBlX2xlbiA2NTUz
NiB0eXBlIE1FVEFEQVRBfFJBSUQxIA0KPiBudW1fc3RyaXBlcyAyIHN1Yl9zdHJpcGVzIDENCj4g
ICAgICBzdHJpcGUgMCBkZXZpZCAyIG9mZnNldCAzNzQ0Njc0NjExMjANCj4gICAgICBzdHJpcGUg
MSBkZXZpZCAxIG9mZnNldCAxMzQyMTc3MjgwDQo+ICMgYmxrem9uZSByZXBvcnQgLWMgMSAtbyAi
NzMxMzgxNzYwIiAvZGV2L3NkYQ0KPiAgICBzdGFydDogMHgwMmI5ODAwMDAsIGxlbiAweDA4MDAw
MCwgY2FwIDB4MDgwMDAwLCB3cHRyIDB4MDdmZjgwIHJlc2V0OjAgDQo+IG5vbi1zZXE6MCwgemNv
bmQ6IDQoY2wpIFt0eXBlOiAyKFNFUV9XUklURV9SRVFVSVJFRCldDQo+ICMgYmxrem9uZSByZXBv
cnQgLWMgMSAtbyAiMjYyMTQ0MCIgL2Rldi9zZGINCj4gICAgc3RhcnQ6IDB4MDAwMjgwMDAwLCBs
ZW4gMHgwODAwMDAsIGNhcCAweDA4MDAwMCwgd3B0ciAweDAwMDAwMCByZXNldDowIA0KPiBub24t
c2VxOjAsIHpjb25kOiAwKG53KSBbdHlwZTogMShDT05WRU5USU9OQUwpXQ0KDQpDb3VsZCBJIGFs
c28gaGF2ZSB0aGUgbGFzdCBleHRlbnQgb2YgdGhlIGNodW5rLCBwbGVhc2U/IFlvdSBjYW4gc2Vl
IHRoYXQNCndpdGggdGhlIGZvbGxvd2luZyBjb21tYW5kOg0KDQpidHJmcyBpbnNwZWN0LWludGVy
bmFsIGR1bXAtdHJlZSAtdCBleHRlbnQgL2Rldi9zZGEgfFwNCmdyZXAgLUIgNCAtQSAxIC1FICIx
NDk2Nzk2MTAyNjU2IEJMT0NLX0dST1VQX0lURU0iDQoNCj4NCj4gc2VlbXMgbGlrZSB0aGV5IGhh
dmUgZGlzdHJpYnV0ZWQgdG8gZGlmZmVyZW50IHR5cGUgb2Ygem9uZXMuIFNob3VsZCBJIGRvIA0K
PiBiaXNlY3QgdG8gcGluIHRoZSBjb21taXQ/DQo+DQo+IEhBTiBZdXdlaQ0K

