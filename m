Return-Path: <linux-btrfs+bounces-8542-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EABE998FF61
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2024 11:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6CE9283EA5
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2024 09:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E10E14830A;
	Fri,  4 Oct 2024 09:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NSspCGi/";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="RmjufcpZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C04146000
	for <linux-btrfs@vger.kernel.org>; Fri,  4 Oct 2024 09:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728033008; cv=fail; b=ZYGu364NJ3U5f0PQJ0x92G85YA0hLiEDsG6KPPb1T0slGFeQQ0p6OqUbYbsDcVv+su4ogh6xWIqtV1MShiwp3kawgnaKATl6XJwCEkNxyUo9olKGRnGAqg22g5oZQxI3ElrCVwEuYwn83g8g3Tty6h5ffBfix8SoTuJFzn+OKJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728033008; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MK968XDZGsQH+6QmP/otZYWJOutjjIdpB8FFEwcBPIHURT+DUiG5/OVZMHnnDqHaOInWnSqrC7vDG2Ha4H9YNYlRV9dSmdAtVICCTDCDDdhTN2tG8lLVa1e1WkvqjIDUqxawipY+a476SmUzXQaFuPcRDgqv2MtbU+c7d77LYtg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=NSspCGi/; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=RmjufcpZ; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1728033006; x=1759569006;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=NSspCGi/e86ziwgYBOvAd6uw4NoiGxx8kL+Lq4fXpN6dOn122w9jbhCW
   OezEGIxuTlqBD3ig+zqY2aBR2m6glmYbvNcRDVAzWzPFWdN2IERGdC9Ku
   d31Kf+VS2jiiDAbFDddqqw9TJBqIpPa3rJXyHbd2xKmyuPZvHCbg6iKdn
   fBCOvXTVKl561SJ0Uk2FxYpgsfYQZ3ZulCg94RDcC2l/4IhVDEUZM+YOz
   CUgWjj2vQVeR2hsx/4XNEkYIleyqFchG5CLgariIOIG8wzvo1WiPCUPgx
   FucD3TUJQ2Xj7Hw3r8NZyxOwEC7XOROjUTe/OVJyyaeFQqy3sIgMdhA1g
   Q==;
X-CSE-ConnectionGUID: JyQ29T4ARSGKeKqXoxoJBA==
X-CSE-MsgGUID: 1jskek7zQfOQHBCtj2+fyQ==
X-IronPort-AV: E=Sophos;i="6.11,177,1725292800"; 
   d="scan'208";a="28652999"
Received: from mail-westcentralusazlp17010006.outbound.protection.outlook.com (HELO CY4PR05CU001.outbound.protection.outlook.com) ([40.93.6.6])
  by ob1.hgst.iphmx.com with ESMTP; 04 Oct 2024 17:10:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IsNV/utfCslTqntVPzEUUdmnuZH7g+/jSWM+dPgivsuH1wUQnP/sroxk10ecoFb+NBlCbgA3SAxv7NIzglSe467PdZ/uTN2ACnilopWMPYyJ6J1X6o0Np6s5XkFcQ0AUHcZDvTvhrV3o/Yc2eJ+QyAoWPP3YjWTRiT8qeBwkFBaPb3XYg35Z7E4dSW2YH27AC5RzD9eay24oLGOSa2iN3VjE0fERvc8oCThPSmLl0jCs8MemD6GbYOxQ8zIqLusdFgGAgbyrb06LLGblt2T1u1DnZoplWKxA7enoY6R6irF23BwhNBCk93k2kUh9mB3IZv7WZittihwyPrXtHdiS+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=E5P+uApEQJmFUSXSYS6nd8GCm4IL+2hDFu4mS2TuyoTOqog1EFkt9arEYk7/xUgl+1EpPAyeS3Q2d4OdhzG/ltTQCMKR0j2wZCkSdUMg7SLQN+IzSm4hDbLA54z6sOkzkqOhxnFP0BRprOloSLArl3RKCKUjLM3S1yu1+S0tHKPbYUWwThIoz1mvT3xR/iLzll2zMZz0eGfe64NzV1hk2eqjmLIdo5iQALLVwmK/dadV0kLUIDTC4Fa/AZcSw8dgd5GQgYvljJAGqhTaIyP7n63pY9Hrrw+bRmJkxPUWzwGyOPQa8gj0ZSJr7m1QotV6qVcLrYcj3nCJy0r1tT2k2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=RmjufcpZIxSpIeG8j8N+aF4wjL7meFsk6RJz4Q4ItpmRSBe76K+mvfQZYUDvoI6ychy05ToaiBU8HwQNA2kQkDdBVadNctnr74gqwGwtoPJC1I/qo6Cot0eDCC3zX6DInQG6Xx/WGDRU0XVGcYXAIeRR3mZRwe3VI6HC746j1Fg=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH8PR04MB8591.namprd04.prod.outlook.com (2603:10b6:510:25a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Fri, 4 Oct
 2024 09:10:03 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 09:10:03 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Naohiro Aota <Naohiro.Aota@wdc.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
CC: WenRuo Qu <wqu@suse.com>
Subject: Re: [PATCH] btrfs: fix clear_dirty and writeback ordering
Thread-Topic: [PATCH] btrfs: fix clear_dirty and writeback ordering
Thread-Index: AQHbFhmax6Udrcucl0m4L/fAhC7hW7J2TjAA
Date: Fri, 4 Oct 2024 09:10:03 +0000
Message-ID: <e6342dac-af42-4c4a-bbf1-30f7c7f0ead4@wdc.com>
References:
 <e329dec3e85540e13dac7aefab1d554134214ebe.1728017511.git.naohiro.aota@wdc.com>
In-Reply-To:
 <e329dec3e85540e13dac7aefab1d554134214ebe.1728017511.git.naohiro.aota@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH8PR04MB8591:EE_
x-ms-office365-filtering-correlation-id: 4f85f049-ff1b-4986-9933-08dce45454d5
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aE9BS3U1STYrc2VwMlhXd3daUHdDNm9NRmVPT0ZQcG11VXpsdWVqVUlwU3JJ?=
 =?utf-8?B?QUlCWkRsai9zOUpvZlNwRGdUT0JVaWQ2TTZNWmtqOWVWUy9hR204UGZMN2pn?=
 =?utf-8?B?ZjBmTWNqQUJ4dFJTcnRlODNYanM2T28ra3NDT29uRytzV0czb1NheEZDK3NR?=
 =?utf-8?B?ZzA1d2ZySWMvUUFHR2Y2Sjl6YTZxdWY0WDQzMUhkRDVqdnRWRENIeGF5T1lu?=
 =?utf-8?B?VTBsR2sxMW1BZHRjR3c3c3ZQcWhwa2ZIcVZJN1puQXFQQi9NNDg2UkdrRmRz?=
 =?utf-8?B?YWlSSmNTTGFycWNyVk1tQk5tU2xTOXpjcnJMYkVwVE5la3dvTWdzSUdhUndn?=
 =?utf-8?B?RkQ3cHBQdUJ4NElYVWJKOG13bDZSUWRvRjFkaE1hdW9lRGdkdk1mTjl3YzZF?=
 =?utf-8?B?TzNyQU1nYUpZbWUzOWtCQVJkZktHZlpxaEtpaURRejd2MWs1SXRLanZrMGh2?=
 =?utf-8?B?MFNmaUJ1dGhmK3ZDbWJHN0xhdWowVjZUVXhyWjNIVzl2NjE5NEc1R1RMR0w2?=
 =?utf-8?B?TVNtazVXMy9pNXhmclNmbmtFMmNjOEw1ZlQxTkJWZ2Rva2I1b1Nob3hRRkI0?=
 =?utf-8?B?Z1VITFIyZm8vaCs0aUE5aDJWQ0xrSUFSRlRGeXJIc2pIQUNCamlkZ2lIeTBP?=
 =?utf-8?B?WHRXOVFkYWtXUm12WjBZYzJ3QzFmWTJ3aktsNk5xbE9RdGNsSVdKSStka2lK?=
 =?utf-8?B?Qm5qWUJKZWIwd0RkNXMxaUVLUlF2YnJTbEtiOWpXZlhoaUtBOElSUGltU0FO?=
 =?utf-8?B?OW9KS3MreVVkWDJoTTVIdW5rYjNQenlZRE1JYXZ2ZjFMTFVhWHNuS1laTDdk?=
 =?utf-8?B?V0h5MDNCN2IvTStDVjVvT0xsc2pVRjhnOSs1NTdPR25JaHMxMTdJVGRWVXkx?=
 =?utf-8?B?SEhHcWV0WXZDOGxyUDFHQWRacmQ2ZmlhcDBpVTZKNkFBZkZvVVdJVnhDKzhp?=
 =?utf-8?B?NWVob0FUZWFVQlFsY1B0emloUWpPeWlNTTBPdHFNendFTUMvRHRXZ05oM2ww?=
 =?utf-8?B?TE0razVKaFZqbk1iNjVVQ2V6N0dsWmZYa1dMSG1uK0pJTE1lNkJMTmMxVUI2?=
 =?utf-8?B?RmRGejRSeGc5am5RdythUm9zZzBwcCt2Z25QeUljcGVMZStodHpZWnVFUkRW?=
 =?utf-8?B?ZGNQeUE1ZmVOOTVNdGNjcUVwM1pSTm1ZZWFvSVc5eGpoT0RpQUlxZTVDVEha?=
 =?utf-8?B?bnRSbWczNHZsb1ZnbkxobWhTaUV5OWNOS1FYbVVhYUY3WS9nNkdyU3NkdkJn?=
 =?utf-8?B?M2c4a2hGdVBCRkY0Mm5ldEI2YzlMMWgrMEF4M1dYTE16cnZPZmM0dnNodVBj?=
 =?utf-8?B?cXZvUDZyMWdrK2J6WnRRSHZjVzh4Mmx2bHc3VnlyeVlwVmh1U2RwSUNuMVFy?=
 =?utf-8?B?QmNBK25mM2R0aGZBbFhPbVh6ajhkY0Y2NlRIL1JGczJnVVJZc09LWUUwU3JL?=
 =?utf-8?B?aWF3a1Y4NXQ0QXArQkpNZFdQUTM3VE9XWjB0clVDRlB0UDk1aGNjajN6aHVT?=
 =?utf-8?B?WWt4YkJiWExnNjhnV0krWTFWd2JuSTUxQXNGQ2QrblNnRmRSdDNHdStlQlFx?=
 =?utf-8?B?WFFleGIva014U2ZITGo0bk9WYnJRZm5DOEdkNGNwZkpCajdyYXV6cFg2RVZu?=
 =?utf-8?B?dmRNSm1wcC8yS25saVBMQnFHdXUzSEh0OUhLSENoNFdvM2gvNXF1R1lNTi9P?=
 =?utf-8?B?ZDUwWTJ6RkRKclQrUlFNc2ZEcGEwVFVtb3JwU2Z3WVd1cS8vT0dEa084QjFl?=
 =?utf-8?B?NWtDSWJSclhsQzFKMEd6cllsQXlneEo2Uk9sQ1grRCtOK0llNmFoUmZwYUJn?=
 =?utf-8?B?bFl6Vmd0cnlqZEdpM0pXQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c3JqQnZRTWYraWsvdzVmbHBEcFhKMTNnME5rMkhQL1hseTI3NlFoQWxSYmUv?=
 =?utf-8?B?ZjhjVUpkMGpydGRSYkxOWHk2UmdZYkplMlU5QmZKYVFjM0dhd3J2dDNwMkZF?=
 =?utf-8?B?VGl6MTFJR083YWtUV2VZWXVVMG85VkNoQ3RXT0U0a2JLOVlCR2MwZ2t1ZnZE?=
 =?utf-8?B?bGdEcHBQUDRnVDNXWThvTFprbG56VTdZZUxSNktSREZEeC9Lb3gvdHVmOU9C?=
 =?utf-8?B?dnIzSGtnSUlEeE1ZamszaWI0cTN2a1RkMlZBdGRCZXN6cWdGRUVBY1Q2aDNN?=
 =?utf-8?B?WXlTbTFaYXRISHB2VWk0TGtsemlkRC9HLzNXSytydWFGb2dHcTBGR25Nc3Ir?=
 =?utf-8?B?Q0dFYnVYaW1DVkRZM2F3dE1Lbkt3Yi9UMlhqaXhoS1NLWWtlaEMvdnpmOVlO?=
 =?utf-8?B?V2tKYWRVTi81a1lpTms1MTd3TUg1dzlHQUtWdzZhMWE5SlQrR3hramZmNmhV?=
 =?utf-8?B?UkQzWVliU20zQzRaUHF4WmtYU25CVlFORFNTSFhwRSt2RXY4M2l4VEJSSlEv?=
 =?utf-8?B?eXlsb2VoREJxaWdmYnJhcHdUaFk2RXNGYTNWLzNFQXhlYnA1ZjJlS3AzdGZS?=
 =?utf-8?B?UTFScWRKTEhxQjNkWlB5V0FGTHNCNytxYlo2MFF6MStOUmtXaEN4b1BoYWVX?=
 =?utf-8?B?MzJlc3QwcWhTYWJYczAwOG1GcC9uREZ3ZW9FbDRVMXZxY05WUkxhdUV6WWtF?=
 =?utf-8?B?YXhFRmQybit5cWRaWVBpZk4yQVdUWXZWT3dQSm40d0doVTZnbWsxaHQ4djR6?=
 =?utf-8?B?SFdneXAwY0R4NVNPUGpIVHQ1RUFlT0tLVkU1TW4wUWtnQkVFNjMvamN4VnEx?=
 =?utf-8?B?bUlCb0c1dDRuSzhMS2RLNnVoZUMwU3FPY05FZmVHNklSaTlDemdNVXh6NUx1?=
 =?utf-8?B?RG5yS3psZHNKU3V4cWNlNnB5endVVm5ZRWlkVERVOTBhUkd6THZsSXQ0QkhI?=
 =?utf-8?B?bnVwSklvTlI1UmwxNEJ5WW9TZkJXUFY4K2JyOTFDQmlHT3lWL0p4NFBDa3Uz?=
 =?utf-8?B?N0I0VDA3Qlg3UkxRanBJbm9tQXNQeURyT0toN0svZ2pjOTlTZGZvZjE1TTJz?=
 =?utf-8?B?UFY3eW9VeGNaTGNaQm5XNWtSYVFtSDYvbEZVa0dpMkFXN1k3WExhMTlRTVpS?=
 =?utf-8?B?SE5ZUzc2N3RUMVRVdkJFT2ovc1VRcUxhVFdpZUdqRXdjaGVOeGd5TjVNNVFa?=
 =?utf-8?B?YjA4cVlKRG1WT21FM1lHZVNISTNQNjR0YlVjY1RISEI1eGtkNUdJZjhnbFVV?=
 =?utf-8?B?VjdWV1QzNGF6Wk83YVBEclM2ZVZFTmtKSDR4SGVjZnJ0WTM3SE5WOUE1MmVP?=
 =?utf-8?B?K3RzTFFVNHU2OEZQZmdIblJseGVjRXdWTTgwamxwVkovcWJ3bTBMOXg5Wm1L?=
 =?utf-8?B?OWJKQ2txMS95VkZvZGFxK3hQSXAxZmFlSytZS0V1aVJ5Mm1xdXl1RVk4Rm9P?=
 =?utf-8?B?VlNCV2Q4V2lIRWlhaitJTTVWYndrV2dWNVVGQ2lEcHVmc3VMbVZmUk8vMEdh?=
 =?utf-8?B?UU1wbGtYQnhxRE9IYVFBSDEvd2t5czFrK0dOSFk0OC9pOXcwbEgrb0tLb2sy?=
 =?utf-8?B?VHlzYzBPdkVaN1EraEZXd0xFcStWbjl6VE5pU0YzYWxzWTNzRy9Na1hiL2dv?=
 =?utf-8?B?aTh2eTlWZHpjVlU2eEg4dTBDamFFVmtLSnlvL3pqTlNxZVgvZ0poVFd0blNz?=
 =?utf-8?B?aERpSW9RZkRyR3dldlFvL05lMmU2K1dUdjNYVTVkVWlKWnJGYkNHbFpFMWZY?=
 =?utf-8?B?S3RmVjBacW11UWhXYlhQeFJvUlczTDJJM1FDSTE5eUEyVEozcWJVczhDK1V4?=
 =?utf-8?B?WGpJTnBoSW1aSWNuY0tmRVByZEhuVHhTY3lweUZzcDJib3NZdUpFaFRRWHBp?=
 =?utf-8?B?cEdYbFFYLzczUzFFQiswQVN5SEd0Vk1hUFZRMTg3RldGNEdJTE03ak5EUEMw?=
 =?utf-8?B?V2VwbzZ3enNIUUxqTzRTSG9naTZEbzU2Wis4RHNrNVdNZnlVSW9NdmR4ek9F?=
 =?utf-8?B?Vjd1SE9YamRrN3ZsZ1VxcEVTdzJLalZiUDZob3FlY1QvRGtzUFpzN1Q2WGU3?=
 =?utf-8?B?L2YxTlFRZFhXeGhnSGZLdW9uSmVMNzIrYWdKWm1ndFgrZDlTNlBTU2VsTmxT?=
 =?utf-8?B?RFFGOUhoUkcyOGkrUlpRcHZxNUJ0d2oyRE1ueUVpdTRuQ3l4NHVMbGhpZmpv?=
 =?utf-8?B?azZjWEQ1TDgrKytNby94ZUNwS2lrNzQ3a1V4QVlFNUlDMWF5MWliYXlsZUEz?=
 =?utf-8?B?bXhWdC9RUll6RDc4cVQ5TFluOU5nPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D585BF9E41841D4B85DC9D9ADF85CBB0@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LqOJnoN1qMJ/xzSAKf016Oy7KM0QAtQfs4Dp8avuL7Cwos5qv7ROjwHbaSSZI+VE2oc6Ea35RHjUs91k7zq0P9S4FGcAhcT+AdL6nJRQMO8/SQKjOCQHvtXXimrfDG/2CimsMbOOaXSuIillvqKko/WxzKBHN9l12iuDaNxpbGxD6dt+D0WxCgK3XtggknYJ+gN8I4E4rder7PHg/IUb7rZUa8jg7vPKatm2J72T/pAJzJHmcINL7jOqhUMwvtERCvF3DI7GNagvxpW+k/YSIb/vBeFfTmvW/WjG+j4Om6W7/XFEIc+ZZp4jkAVfmMOzHBwBHYnWXyNMtNeOJTQ1DWDLd+a++eEDze0lKUgYI3vxgGGWk3e/QqSAopW1UiA8eWmQ5oCBuoxHvIL7hnewGzvviffovRWPus8Kk4bScbSlGQqNCXoPWaezKcGRxzm1wnb9MKWeY5vqqm0isDyzNcsvnlzkEMTofPuhhk2/V7HhGNWf2/ptvn9TMFq6J3BbTkqtlDi0QK7wIGWgnkooPpkAM01Z0YEIOIhVChfByqgFDA3aVQo4nhP3+1QXQQoUDercS3binOKNV7GAAYuCVYlbskL+DDSO+gwGvEbFJxCyJWAKQ+vNnChf/oPa8LMr
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f85f049-ff1b-4986-9933-08dce45454d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2024 09:10:03.1018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BJfgltTm+kLk3QLNMOGIZntMdFSvUY0kEgQ0FbExL+YKi++X9LMpTt0Q3I7UufB5h3siyp1YuLYy8RoxPBaLL+jn7O3wCq0CqJvOXZ27cT0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR04MB8591

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K

