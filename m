Return-Path: <linux-btrfs+bounces-9418-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8526C9C3A61
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2024 10:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E6CF1F22190
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2024 09:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E370D15B14B;
	Mon, 11 Nov 2024 09:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AGrj2+ty";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="VBlkUEC/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B3861FE9
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2024 09:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731315890; cv=fail; b=EAouqZB1FOR38krzMYZDFR0yJjCv2h/yGcezXQCDeapIeq75ZVeumM9fojd0Y61079nszpUWuCxrWlU/CGFQug0p9Md16j8oJmmNdGheQ3/xMCTMuLW7a8gcFtlQodAUP4Jc6lT4MXgjBzVSOWKDHEWYk1aZuaIlnLFK6szQ9vw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731315890; c=relaxed/simple;
	bh=x5Cg8eBCA3X2C6eeT+NiTE+MZOyS+CJNlLjfwKXbGtc=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KYu/bN1fqnaRN6BoFHHs83MY0jzpPG4Uz72A6X1Kbjo4yBrf8iCv5t0Bdoyr4lgRL8oQTSP8VCq1tlWvCVu4KZwHzfmSOY6wdqTmhTfhmhubnZH/6TNiyKZMf3vTryKOWNzxgbogpA/FrrgpeaiRSk+YHWLz4M5dyqlp3Nn1rbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=AGrj2+ty; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=VBlkUEC/; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1731315888; x=1762851888;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=x5Cg8eBCA3X2C6eeT+NiTE+MZOyS+CJNlLjfwKXbGtc=;
  b=AGrj2+ty1rNxSwHjwwvXTvkIpk6r6SqE2vG38uSD/Dx/h0q/VGDswvwG
   OI3xqhnjiPPNQ5ddTJ5TT94Eqdu8Je/Oc0m0ImL59PjBysFVg8aHP/1YV
   ja3fCsjbaZXBVN3b37qJ2/vMPueYH+zXdlU0WbdUlSvUjz+0ni2PUdQDv
   K7pJUfqH4oblI6I9e9ILdU5FRQhPmuK0D5La9JtEf4FzZBX0yiERYqlwt
   //oyRoApl/zZLklEInx28byQTrPbGgbrUo2DkW9Pa32RlJyr0XoMSULiC
   eqpstdVc1HKG5dD6IGSwmvP7bwFlS97JueOGrSmKaxBnNIr+IaFaGWzGu
   w==;
X-CSE-ConnectionGUID: SogBrKxvQnSAfgB21MdD8w==
X-CSE-MsgGUID: TFXaNCgUTXCV2X/kTHTOwQ==
X-IronPort-AV: E=Sophos;i="6.12,144,1728921600"; 
   d="scan'208";a="31112210"
Received: from mail-northcentralusazlp17013058.outbound.protection.outlook.com (HELO CH4PR04CU002.outbound.protection.outlook.com) ([40.93.20.58])
  by ob1.hgst.iphmx.com with ESMTP; 11 Nov 2024 17:04:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m7MSpwkqeJYY2lJexjbbQVrmRbsPXG/z427w2/6J3Zt75eS93cJ0NMB0zInFti+RrNylWu9s8QgAtipci0ta9vcYKtR7dx70/I+BJBSK0ysGRN8UW1WJ7l0DUtDRDtDNkj+nHTGo7FsOgoPg9uU92Ej4nFiXjUrF2Kw1OiXFk5GfoWdgJf6pLEbWPorWBd8p17cOClCgmzxrd6nnANJrZb/G4dzi7w9MeCpKizlUIpsPhOVgqCcxxexg6m21JCF4Zh98U0/VlD9QNk5tbe+1pe2A8dj4Sx9r0NLFftv8eVlp0723eH68Qnp2a1YdhHllTox0V8Bjgz/6vo7yt4MA4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x5Cg8eBCA3X2C6eeT+NiTE+MZOyS+CJNlLjfwKXbGtc=;
 b=K3nPONpHakJbnKuD07u6Ma2YKB8f3Xmki/7jyBdc8cwmpGQpdayXAXp8S0nIJWjfqaOrDljGDeLoHIxYQqnQNuOidjcZIsHzLnhWrvActCCLfMScm4AR1Ji7xoGsBJBk2NPai2hQ0rwGCirttMZ4qP/8fXSALHgljnIbNTXh8SZijT+Fm++oUlxZqncNhQhqGWksfzibY5aDNAO9JxQu6ekLUhlBq69Os4cFFQsbv2R8rfzYkQfhysLQW38QyqYUTOozMQENDNjd+1+Pukh+8n5jHH71s3OTTUTPTOhKOVWJmFdPQ9CSrlItrReicrNlnYkxfTP6T752GflP0Wbelw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x5Cg8eBCA3X2C6eeT+NiTE+MZOyS+CJNlLjfwKXbGtc=;
 b=VBlkUEC/2+Hbkpx267HKHi/2w9r7VB9UnryvrlZd4ugf4XDFIgB02eMAfcCaoZRNeViMf9t/cklohH/oOh/DZEub4a520ahego4JImVE2sVGTK2Ia+E5CCc8N+hhGWqOUXYpd5cXl6VirK6wo7Gj+XEEhgV/D+BPJxQPT4b/lPs=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by BL0PR04MB6561.namprd04.prod.outlook.com (2603:10b6:208:1cd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Mon, 11 Nov
 2024 09:04:39 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%5]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 09:04:39 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Naohiro Aota <Naohiro.Aota@wdc.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 3/3] btrfs: zoned: reclaim unused zone by zone resetting
Thread-Topic: [PATCH 3/3] btrfs: zoned: reclaim unused zone by zone resetting
Thread-Index: AQHbNA5O9pIO1tz6MEK8gI8luaY07bKxyVsA
Date: Mon, 11 Nov 2024 09:04:39 +0000
Message-ID: <a419cf9f-7fa3-4f75-b459-23c1fe014c14@wdc.com>
References: <cover.1731310741.git.naohiro.aota@wdc.com>
 <72946446ca8eda4477e0a11ea0b9d15cb05aa1e1.1731310741.git.naohiro.aota@wdc.com>
In-Reply-To:
 <72946446ca8eda4477e0a11ea0b9d15cb05aa1e1.1731310741.git.naohiro.aota@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|BL0PR04MB6561:EE_
x-ms-office365-filtering-correlation-id: db384c8b-bf90-4c49-ff6e-08dd022fdf8c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?U1ZVWEp5V0UzMGZVNTRVSDl0Z0g3V29nMWpkN24wb0JPOVZkT2tnSXBzRXJs?=
 =?utf-8?B?VG5mV1lkM2hjZ2V2ZjJIUDV0MWpFeUZaaEswSG9hcmZoT3ZYT1lKTzRIcnNS?=
 =?utf-8?B?MGtxL0JsYzFhWkgzUy9iYkpZVTJPd3RtUFA4WEtja09PcFBEU2xlQllvb2tM?=
 =?utf-8?B?SElucE0wU2ludDFCQUJGMEYyWUNvWk11YnZraWFRTEZEemljamExaURFM3F6?=
 =?utf-8?B?d2N5bjN6WXhMVlUxMnJQSUVOaDFTSmlQQlc2OFp5TXZwUDR0THdweDlpaVky?=
 =?utf-8?B?VTU0VUZpeTZROHVoNDE4d1gwaDM2N1FFUWkwSE5lRWdxNEV2UEhNYk9Ub1ls?=
 =?utf-8?B?NWpaK3BUc24zMUEyck5halU4TUhIS21EYTZhakFGNEo3WmJuTjlHaW82QkhS?=
 =?utf-8?B?VWJVNGZmMUJ2ODJtcmhKcFNZQjhGbnpsUFdMOGdkS0ExSnJhN2xGKzF5UGZy?=
 =?utf-8?B?Wm05Y3poTlJJQ2FhUEVLeDRhRncrcURWa2FXSUpYSUo4WnZTV3VMNHpjeVFo?=
 =?utf-8?B?Q2c1b0VFbXlia250alcyRGdSQXZXSHpkdHhLeU9JQ2wxbVoxdjN2VVNueWxn?=
 =?utf-8?B?SEdBaVFGb2k4V3UrancveVc5RjR6OGZmczcvS1h5LzhuT3JMMkNlSUl0UjRn?=
 =?utf-8?B?dHRTNzFEUmFrYmU2M3RVdENuNTNDOHdPeFhKY0RtREhGaENkSDdNbEJLM05q?=
 =?utf-8?B?RDhZdUQ0SHlrYkJHaDArTW9pTXBpTGpVNW9CMWlGdDUvcEIzMUZ6ZFlwNk80?=
 =?utf-8?B?aDN5amRCOU0wTHFsZWVvcnJKTHhQRmFFcmVOc0VtSWRKVkZqWUZjTmVJWXFE?=
 =?utf-8?B?TzVSVjlWcWx1SFFRSGNiYnlZTXlJeEpDdmtlcTVaYVphMUFyaEZLSENsRUZF?=
 =?utf-8?B?dndSby9Ma1p5eTNuL0lBTWlBM3B0L1p3aExGYjROL3c2ZXF6c1pmSHhHc2xw?=
 =?utf-8?B?dTZFZVZ4TXN6MDhQaFFZcnhNZDd3bFpXNklmb1lGcGN2TVVoeDFIL0tQNFE1?=
 =?utf-8?B?dkJaREs5c2NzRGtrSjRmVGhIQzQ4ejdaL2JFeWVPOGhSRmF4SEVQQzZXZ1VU?=
 =?utf-8?B?c1luK3pXMmdlazJveE9ORW1nclQ5OG9QcEdGTFkyK3VUOHZwV3plTXdDZ012?=
 =?utf-8?B?WHFLb2ZmOEZlYmdFcDJ2R3RCMEU2OXI5Q3UrQjBzOFZOSUhkcmpheGsxSTJr?=
 =?utf-8?B?RURQeTNvTjhiU3luRU04cTlJcUpvd1o5VjQzdzA0TUtZTGppQTN2UU1EVHVC?=
 =?utf-8?B?bTMycDBDUTNHazRtcVF0SFdWR2k5YUZ4TThBR3N6VndBUURYY2tTcmVEb0ZV?=
 =?utf-8?B?UGovTVIyVUNmVnVza2t6Y1JSL25YRzNka0lsbHhXTHRXZ0dDaTNXeDBsakJR?=
 =?utf-8?B?aFNQazBEeFA1dHBkMG90bmFvd0h1NlVVS3I3WnhsUUZPSFNqNTJoZGJIaGZi?=
 =?utf-8?B?QXNHTXJKNHlFOEd0SDRmeDg0UnNHZnF1djRiQTA4SWVuNWQwMlc2NmdabzI4?=
 =?utf-8?B?QVBVdTF2MkpiMnZIejFsSUYvUmhoeWRub01WMkpLMFdZelNhZVY1RDc0aVVk?=
 =?utf-8?B?UFR6MC8vTDYwTVpGQ1dMZkhXVHRRUFRqYzRoKytkUjlISGpvNGJndEtmaE44?=
 =?utf-8?B?RDFYTjlUQndrRUpQaE1Wa2dkcjlUenpjWlBER0t0V1JlYkY3dHloeGxWQTdP?=
 =?utf-8?B?a291c1NmOURUK04yRGVCTm9HaXNFOGZ2NTdtNUl4TlNNM3ZsNjhFQ0hSbjBZ?=
 =?utf-8?B?cFNuVVVaQnE5cFh3dnZCdVhkZFdTUkduUDZhMWwrb3VTZytDMDVaanhEWXov?=
 =?utf-8?Q?TNndazTgQ0ZzUbl7j1ErupBa2hfp8RGnvftuc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K0hxbmpVemxTQlhvbnNUemVvTTM2eTlBa2Q1QmE3YzdqOERWZVdKRWVjckc4?=
 =?utf-8?B?Vk9ZOStRME9EMGhpaFRRY1NZc3ZkRjU1bWFkcUxmejErYjN2eHFBMmpIZmFk?=
 =?utf-8?B?T3d2Ym1vRStuOEJsNFRCWnFhbExMTDhqcHVTUXEvbm11KzhpNjRzcXlQbVpO?=
 =?utf-8?B?b3Y3aExPVTA3dnpZMEhVUDlsRHhEbm5EeEd4TGxNRUt3TG1IWDZqWlZZSjQw?=
 =?utf-8?B?RHBQYjFTMTFRMks2eFVESE82RGpRQTBYY2F3WEZGM2plNnNtaDNzTmNpb1BX?=
 =?utf-8?B?VW05U0ZhdHpubUl1KzJ0b1VKUlB2aWFCeEJWbG45UmdORGpERE9DaEdMbU1W?=
 =?utf-8?B?Y3NFcll6UVpQZDRqL1RSRytVanVSc09NV01CVVJrWU4yak9ySlVDTGl5d0Zw?=
 =?utf-8?B?RXd5Qk9sN3drSUhiaEJiMFAyNGR2TWNTQ3JFai8rbDJRTzBjUTN4MUdUS0x2?=
 =?utf-8?B?Q0RtZDdyWWtmUXQyZDFsSFErZEo4V0hFYVF0dGNrU1ZxU3o1eHJFOGRUUWVl?=
 =?utf-8?B?aFVreUpPYWcwZTdCS0pEVnpha3NaZkVHT3crdVBpbmhkRytESnJwZUZiZ2pB?=
 =?utf-8?B?TU1qVGhlWi80elh5OHZUY3BwSEY2T1ozMmxxZWU5YkZpc0QrWGszckVQYXNV?=
 =?utf-8?B?MWtwakN6NkxyUUFUZzExekFPQjJBQ0g3MzFuejVyWVY0b3N6cDRYVVBuZVNZ?=
 =?utf-8?B?Qk52TUxOT0orODNVdHRZVHg5Zlo4V3FpaWc1c0tUeStHT3JtK3MxZXZBMFJU?=
 =?utf-8?B?bEZNVTliZ2pMYXhjaHFrWWNUekhWVWdCZjIyaTR6MHVDaktUbm04N0RaVHRk?=
 =?utf-8?B?bnNNZU1wb0NqQ0R2T2pFNWJTdDFCRDFHTE9YOGFCYXRIdXFLN2M1ckNuRFRW?=
 =?utf-8?B?bGZpRzNPSEVuSHRGQUpwYlk0TEhzZTFDRHAwc29qVHNDWGZJYW1Xd1VpVkli?=
 =?utf-8?B?KzBXY1ltUlVvM0JhS3k5R1M4cUZ6T2NBZG1mR0hHaWZZN3JBSFk5YzRkN1Ny?=
 =?utf-8?B?eVFJZGkrekJMZkxzUU9LL2g4aDFoeFY3bXBoRDdqUVdiYkFNa2p0UEo3VTRl?=
 =?utf-8?B?Y1lmdmRwQlEwUEZkZnhYYlFlZDZLMGFGZisyZjV3RmNDSDNHNVN6QUNxTFBz?=
 =?utf-8?B?ZXhSdFdldWpuUlgvZDNZUWdpZmlSRzdpcWtwS2M3Qkd0SjNwTTRmSjJGSW5w?=
 =?utf-8?B?bEQ5ajNNTENSc0llRnY3WmVDdVRBS1grejFybmMyWVZiS2h3N0VDeHlHYkk3?=
 =?utf-8?B?SXJMMFFsT3JsZDVHUjBrUS85ZGpZU3hvbnJ2NjRFVHl3Ri9wZXRsSzREYUQ2?=
 =?utf-8?B?dzYycWlqNFBiTFUraVo2a0p3aEc1YSs2VW9DQnV0d3ZPK0tuMFVrY3cxVjRN?=
 =?utf-8?B?Q1lYakR1OWI5V1RYdG5yV1hpU3FsY2w3WHhtQWZ1ZEI4bUdSSE83dHNzWTZk?=
 =?utf-8?B?NGtUS3cxUWtIUVhwcmIva2FHbEppNHliSTBjTndBR3d3WlJmTzkwOGxqc3VG?=
 =?utf-8?B?T3BCYUprTlp3UDJiSnJuU2U0TDJNZmd1NWVQMm5zbTJYc0ZSNFhNaGQzSHhJ?=
 =?utf-8?B?Tk1iSitXS1BJbDNGejRkc0thaXhWdGxlWWsxRGQ3M296VUdvOEFvTThBNHRI?=
 =?utf-8?B?V3NpakI4M2xRZ2J6Y3Z3M1JuaEdDc3dGU1NualFiRktwWjNsT1RkSVZnOVhK?=
 =?utf-8?B?L2ZCd0RkVnJpMjEvS3hvS0dLbFN3VFFhWXJYRVAvZno0Q3pmUjQraTd4RTJq?=
 =?utf-8?B?WVlaZ3lqMCtaY1g1eFhBWkVCVEU3REt3S2NKSXJDL3dWbjBaSytLN2pPMC9t?=
 =?utf-8?B?dWhkNUtRVGp5dmxCanpMRWtqb25JRk5WNDR6KzhXUzY1UVZJWWh1T3lPZUNP?=
 =?utf-8?B?U0ZHVXBOb09CMkJQZXM5THdra1ZWQ1Q3a09LOVhqZ1ZlY1ZCVk8rMzhybmNX?=
 =?utf-8?B?Z21qcnRUOGUvV3FGeHR1Unl3TUovYWt1ZloyZzVzdFlTMi8rVDJPNWF0QXdk?=
 =?utf-8?B?MnpLOHMrY2l3RS9SVGZCOHBlOFU1dDIrUFhaZEo5ODFYQXdqTzBEVWJVVi9i?=
 =?utf-8?B?UlBja2ZYb2todmJvdWZXUVJuVjVTRlUvOElYQmJ0cmJSUXAxQVZUMVBYUHhY?=
 =?utf-8?B?ckJvT1I4Vy9mTHRUallxY0tXQ0JxM1BvK3pEdk9BWTBIY3RqSkRxS0xnN1lk?=
 =?utf-8?B?M3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0B613E0F8C01F5478BA6E09FD0AD5109@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	h6OdNib0BcAgBWIDYxve7UhldZNX2yjvvTeagYg6rXDIEvOvkZH+kLVnHcT/9wCeOEAnDRyQ93Ovyp3re7WcFRwXacG5S0Citc1tteBf7N/dFgNTwlJqEHHblhnACYcMzKxtGd2cpZDHxCpJSfLDXKvIByPXZ0dpmE9EesCHNnTC8g8dFfoXJk6ru2VtmKpur+m6ay1B42fUk7MYy80tTzJ/0TyxkX7R58BbTnKVvLWO06BvkuhCQl376Nwi00yfiwNy9RaaIDc2xJrkpAI+1Gn2A5Yguq7EvybR1uPZxIMyRL6E7lqmH1daZ6eT/jwmW5yp1Jyqf3z4Zk1C9SyO/oYOZDT9oa6O0LS+E8UYnR83wahgkZDI9Pw+D8fgJ+yI+XkqJav1frIvVS2luvJKDcK8BbxWGG8NX6FelCvxCfTTfBpYJP4ge+tVAVtdxT4t5vf2/v9Q94JcNAUloCKUU2cQwypNQopUjM5I5t8jHIEpuSmAYv9Gv5Sz3jgHfX1YfVLta4i+7dSVwQiwxDA4sQ/o9j4hgJ7fnh1E9egdMVXTXw72SqIcOyEkopFBl7SER0ebXSsMCPU+hm80NepgmBOKagV8SRU8+Gy5q4/WJPcxQu7U1RRDwYCMZD9S8/5I
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db384c8b-bf90-4c49-ff6e-08dd022fdf8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2024 09:04:39.3201
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oD9G2OPf6PGMO6ySLNt/MZfepP5++uqVEMBeAUjXbRhIUOAHPUFlzk5+lUH5KIheul++Qrrp/kjNA86XjmPFXu2lkPTfrRe+7DUsQHLZZDE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB6561

T24gMTEuMTEuMjQgMDg6NDksIE5hb2hpcm8gQW90YSB3cm90ZToNCj4gKw0KPiArLyoNCj4gKyAq
IFJlc2V0IHRoZSB6b25lcyBvZiB1bnVzZWQgYmxvY2sgZ3JvdXBzIHRvIGZyZWUgdXAgQHNwYWNl
X2luZm8tPmJ5dGVzX3pvbmVfdW51c2FibGUuDQo+ICsgKg0KPiArICogQHNwYWNlX2luZm86CXRo
ZSBzcGFjZSB0byB3b3JrIG9uDQo+ICsgKiBAbnVtX2J5dGVzOgl0YXJnZXRpbmcgcmVjbGFpbSBi
eXRlcw0KPiArICovDQoNCk1heWJlIGFkZCBhIGNvbW1lbnQgd2hhdCdzIHRoZSBkaWZmZXJlbmNl
IGJldHdlZW4gdGhpcyBhbmQgDQpidHJmc19kZWxldGVfdW51c2VkX2JncygpPw0KDQo+ICtpbnQg
YnRyZnNfcmVzZXRfdW51c2VkX2Jsb2NrX2dyb3VwcyhzdHJ1Y3QgYnRyZnNfc3BhY2VfaW5mbyAq
c3BhY2VfaW5mbywgdTY0IG51bV9ieXRlcykNCg0KTWF5YmUgY2FsbCBpdCBidHJmc19zcGFjZV9p
bmZvX3Jlc2V0X3VudXNlZF96b25lcygpPw0KDQo+ICt7DQo+ICsJc3RydWN0IGJ0cmZzX2ZzX2lu
Zm8gKmZzX2luZm8gPSBzcGFjZV9pbmZvLT5mc19pbmZvOw0KPiArDQo+ICsJaWYgKCFidHJmc19p
c196b25lZChmc19pbmZvKSkNCj4gKwkJcmV0dXJuIDA7DQo+ICsNCj4gKwl3aGlsZSAobnVtX2J5
dGVzID4gMCkgew0KPiArCQlzdHJ1Y3QgYnRyZnNfY2h1bmtfbWFwICptYXA7DQo+ICsJCXN0cnVj
dCBidHJmc19ibG9ja19ncm91cCAqYmcgPSBOVUxMOw0KPiArCQlib29sIGZvdW5kID0gZmFsc2U7
DQo+ICsJCXU2NCByZWNsYWltZWQgPSAwOw0KPiArDQo+ICsJCS8qDQo+ICsJCSAqIEhlcmUsIHdl
IGNob29zZSBhIGZ1bGx5IHpvbmVfdW51c2FibGUgYmxvY2sgZ3JvdXAuIEl0J3MNCj4gKwkJICog
dGVjaG5pY2FsbHkgcG9zc2libGUgdG8gcmVzZXQgYSBwYXJ0bHkgem9uZV91bnVzYWJsZSBibG9j
aw0KPiArCQkgKiBncm91cCwgd2hpY2ggc3RpbGwgaGFzIHNvbWUgZnJlZSBzcGFjZSBsZWZ0LiBI
b3dldmVyLA0KPiArCQkgKiBoYW5kbGluZyB0aGF0IG5lZWRzIHRvIGNvcGUgd2l0aCB0aGUgYWxs
b2NhdGlvbiBzaWRlLCB3aGljaA0KPiArCQkgKiBtYWtlcyB0aGUgbG9naWMgbW9yZSBjb21wbGV4
LiBTbywgbGV0J3MgaGFuZGxlIHRoZSBlYXN5IGNhc2UNCj4gKwkJICogZm9yIG5vdy4NCj4gKwkJ
ICovDQo+ICsJCXNjb3BlZF9ndWFyZChzcGlubG9jaywgJmZzX2luZm8tPnVudXNlZF9iZ3NfbG9j
aykgew0KDQpBZ2Fpbiwgbm90IGEgZmFuIG9mIHRoZSBzY29wZWRfZ3VhcmQoKSBtYWNyby4uLg0K
DQo+ICsJCQlsaXN0X2Zvcl9lYWNoX2VudHJ5KGJnLCAmZnNfaW5mby0+dW51c2VkX2JncywgYmdf
bGlzdCkgew0KPiArCQkJCWlmICgoYmctPmZsYWdzICYgQlRSRlNfQkxPQ0tfR1JPVVBfVFlQRV9N
QVNLKSAhPSBzcGFjZV9pbmZvLT5mbGFncykNCj4gKwkJCQkJY29udGludWU7DQo+ICsNCj4gKwkJ
CQlpZiAoIXNwaW5fdHJ5bG9jaygmYmctPmxvY2spKQ0KPiArCQkJCQljb250aW51ZTsNCg0KZXNw
ZWNpYWxseSBhcyBub3JtYWwgc3Bpbl9sb2NrKCkgY2FsbHMgYXJlIG1peGVkIGluLg0KDQo+ICsJ
CQkJaWYgKGJ0cmZzX2lzX2Jsb2NrX2dyb3VwX3VzZWQoYmcpIHx8DQo+ICsJCQkJICAgIGJnLT56
b25lX3VudXNhYmxlIDwgYmctPmxlbmd0aCkgew0KPiArCQkJCQlzcGluX3VubG9jaygmYmctPmxv
Y2spOw0KPiArCQkJCQljb250aW51ZTsNCj4gKwkJCQl9DQo+ICsJCQkJc3Bpbl91bmxvY2soJmJn
LT5sb2NrKTsNCj4gKwkJCQlmb3VuZCA9IHRydWU7DQo+ICsJCQkJYnJlYWs7DQo+ICsJCQl9DQo+
ICsJCQlpZiAoIWZvdW5kKQ0KPiArCQkJCXJldHVybiAwOw0KPiArDQo+ICsJCQlsaXN0X2RlbF9p
bml0KCZiZy0+YmdfbGlzdCk7DQo+ICsJCQlidHJmc19wdXRfYmxvY2tfZ3JvdXAoYmcpOw0KPiAr
CQl9DQo+ICsNCj4gKwkJLyoNCj4gKwkJICogU2luY2UgdGhlIGJsb2NrIGdyb3VwIGlzIGZ1bGx5
IHpvbmVfdW51c2FibGUgYW5kIHdlIGNhbm5vdA0KPiArCQkgKiBhbGxvY2F0ZSBhbnltb3JlIGZy
b20gdGhpcyBibG9jayBncm91cCwgd2UgZG9uJ3QgbmVlZCB0byBzZXQNCj4gKwkJICogdGhpcyBi
bG9jayBncm91cCByZWFkLW9ubHkuDQo+ICsJCSAqLw0KPiArDQo+ICsJCXNjb3BlZF9ndWFyZChy
d3NlbV9yZWFkLCAmZnNfaW5mby0+ZGV2X3JlcGxhY2UucndzZW0pIHsNCj4gKwkJCWNvbnN0IHNl
Y3Rvcl90IHpvbmVfc2l6ZV9zZWN0b3JzID0gZnNfaW5mby0+em9uZV9zaXplID4+IFNFQ1RPUl9T
SElGVDsNCj4gKw0KPiArCQkJbWFwID0gYmctPnBoeXNpY2FsX21hcDsNCj4gKwkJCWZvciAoaW50
IGkgPSAwOyBpIDwgbWFwLT5udW1fc3RyaXBlczsgaSsrKSB7DQo+ICsJCQkJc3RydWN0IGJ0cmZz
X2lvX3N0cmlwZSAqc3RyaXBlID0gJm1hcC0+c3RyaXBlc1tpXTsNCj4gKwkJCQl1bnNpZ25lZCBp
bnQgbm9mc19mbGFnczsNCj4gKwkJCQlpbnQgcmV0Ow0KPiArDQo+ICsJCQkJbm9mc19mbGFncyA9
IG1lbWFsbG9jX25vZnNfc2F2ZSgpOw0KPiArCQkJCXJldCA9IGJsa2Rldl96b25lX21nbXQoc3Ry
aXBlLT5kZXYtPmJkZXYsIFJFUV9PUF9aT05FX1JFU0VULA0KPiArCQkJCQkJICAgICAgIHN0cmlw
ZS0+cGh5c2ljYWwgPj4gU0VDVE9SX1NISUZULA0KPiArCQkJCQkJICAgICAgIHpvbmVfc2l6ZV9z
ZWN0b3JzKTsNCj4gKwkJCQltZW1hbGxvY19ub2ZzX3Jlc3RvcmUobm9mc19mbGFncyk7DQo+ICsN
Cj4gKwkJCQlpZiAocmV0KQ0KPiArCQkJCQlyZXR1cm4gcmV0Ow0KPiArCQkJfQ0KPiArCQl9DQo+
ICsNCj4gKwkJc2NvcGVkX2d1YXJkKHNwaW5sb2NrLCAmc3BhY2VfaW5mby0+bG9jaykgew0KPiAr
CQkJc2NvcGVkX2d1YXJkKHNwaW5sb2NrLCAmYmctPmxvY2spIHsNCj4gKwkJCQlBU1NFUlQoIWJ0
cmZzX2lzX2Jsb2NrX2dyb3VwX3VzZWQoYmcpKTsNCj4gKwkJCQlpZiAoYmctPnJvKQ0KPiArCQkJ
CQljb250aW51ZTsNCj4gKw0KPiArCQkJCXJlY2xhaW1lZCA9IGJnLT5hbGxvY19vZmZzZXQ7DQo+
ICsJCQkJYmctPnpvbmVfdW51c2FibGUgPSBiZy0+bGVuZ3RoIC0gYmctPnpvbmVfY2FwYWNpdHk7
DQo+ICsJCQkJYmctPmFsbG9jX29mZnNldCA9IDA7DQo+ICsJCQkJLyoNCj4gKwkJCQkgKiBUaGlz
IGhvbGRzIGJlY2F1c2Ugd2UgY3VycmVudGx5IHJlc2V0IGZ1bGx5DQo+ICsJCQkJICogdXNlZCB0
aGVuIGZyZWVkIEJHLg0KPiArCQkJCSAqLw0KPiArCQkJCUFTU0VSVChyZWNsYWltZWQgPT0gYmct
PnpvbmVfY2FwYWNpdHkpOw0KPiArCQkJCWJnLT5mcmVlX3NwYWNlX2N0bC0+ZnJlZV9zcGFjZSAr
PSByZWNsYWltZWQ7DQo+ICsJCQkJc3BhY2VfaW5mby0+Ynl0ZXNfem9uZV91bnVzYWJsZSAtPSBy
ZWNsYWltZWQ7DQoNCgkJYnRyZnNfc3BhY2VfaW5mb191cGRhdGVfYnl0ZXNfem9uZV91bnVzYWJs
ZShzcGFjZV9pbmZvLA0KCQkJCQkJCSAgICAtcmVjbGFpbWVkKTsNCg0KV2hpY2ggcGVyZmVjdGx5
IGZpdHMgb25jZSB3ZSBnZXQgcmlkIG9mIHRoZSB0d28gc2NvcGVkX2d1YXJkKCkgbWFjcm9zLg0K
DQo+ICsJCQl9DQo+ICsJCQlidHJmc19yZXR1cm5fZnJlZV9zcGFjZShzcGFjZV9pbmZvLCByZWNs
YWltZWQpOw0KPiArCQl9DQo+ICsNCj4gKwkJaWYgKG51bV9ieXRlcyA8PSByZWNsYWltZWQpDQo+
ICsJCQlicmVhazsNCj4gKwkJbnVtX2J5dGVzIC09IHJlY2xhaW1lZDsNCj4gKwl9DQo+ICsNCj4g
KwlyZXR1cm4gMDsNCj4gK30NCg0K

