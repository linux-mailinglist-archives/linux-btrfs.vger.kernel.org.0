Return-Path: <linux-btrfs+bounces-12397-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7930A682FD
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 03:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4781D42249C
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 02:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C5D20F077;
	Wed, 19 Mar 2025 02:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bwGcWi91"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D223F9D5;
	Wed, 19 Mar 2025 02:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742349985; cv=fail; b=MgY3G+2sRi7TUfH/5qZA59Izc0OZZUFzFSIYxoYanxHEvFHPrK9qayXsCT5dfij4LzzJtiKtCu6WLhM4PEFq/wpOVsF8AxOIRi8NIaIGndjLKYMMXv+e79qMz8ejPh1VrH/Q4VWLmiBXVqXeMt122W0PKL3O/u2uItTlrasO6gs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742349985; c=relaxed/simple;
	bh=Ht8qfSTzCIUyWc/lP6qyOa1cojMzJlUSjkwQ21JkqiU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mMUKD0PMpfmGHyr1pj0QBZjUHV56UtB9LO6m6rVHLCjMjMcM5zFGinQnjhTuVXUE088NnQnHcLMAOChGDCtpnCV9hx3ypeRK+sjjl7lHwSRlO6guVO4C6coBJ1PKKIoaX6X5yBjAB6XST7VMy2KuoVZmE/ScvEg15b0CWjqhtEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bwGcWi91; arc=fail smtp.client-ip=40.107.220.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r+I5Y9pwXnlASqumQYDiiDeFA+HMMUbBwZ2X1xGa+Ft3rgdyJGm9LlQlPUvCK2mAbEHMzkQ0KPV4SKbwI49TuUh2pDhovYBOmZp7IedjONobSutILjpeGggW53b3VPMuLR8jKp8P2R/uy4LF2i941ThSzrZPIaXC2lXdsgj5ONmscnCLgYzqIy9jTZ4asgMxhDmAqTq9DdNgGXNCn9OfudKwdXt0hfNJP0K1iNvWJ1US5p5tJDfKjfCcONfcrRyQ8ZuaQn8H/JcrTFXqjlwRM46LqrPWcjAj5LPynitd7fV/CFzREt2Oglw49bFjGDozNuTjbG4JA0eg6e7T75cjJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ht8qfSTzCIUyWc/lP6qyOa1cojMzJlUSjkwQ21JkqiU=;
 b=lkUarZfXqIUy2/SLZxABCGvscEIn3rcRkdmzVRJBpf7MyUoSFrdij/1H/PB/Mr200XOwL/uOlIGQ1bEtiua1N/oCMj2p2cBD9myeNh2yi1ImVYA0GCBm10mWwgcjpuW/l9TcIbaUa0BxyctVl/OXyA0IKRhud+YCrdauMQAmrFe1F0KyceqZd4ZpPFsHwBFcmIejJRdZbezFkq01cS28UoIiNcz0TBrEN2hj/94fTWfzYsBryRe4IVorxhWPEuS5OIXI6oR8kRu+CvdV5NLIjFDN3Bzg7/3KvgQo31Q+ySfyxXQPVnLnu4D5M/q3LC0IKxWMILBRuz/0A27o6ul4Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ht8qfSTzCIUyWc/lP6qyOa1cojMzJlUSjkwQ21JkqiU=;
 b=bwGcWi91AJEXKIBCqdPAh6ysCIQwZQadsO/Ufb7nyJANLD7oKVrTHr8y2mw6Q3G5RnwxHMimGjzLMBmcDrrRNTbfDcRkmjKCtqIRlf9udInrBWKpD2TyJ+R6AjO11NZg7gGZhBDbYSLLxQexEB27ln5WJMbwM3tPBKao2oUZZR5406QZmAiv370NH7ZPinKBSFzcv0aCKyFDoujwK1x1JwjGftPUYkS+R1nIhNaJ9keBmO0YQkSvrudB1RLIMymhAcvH3e16o1crWcxTfJw0ojatQY1jSw8p5fYiAQPib60W+6Dg6jLteu6Uz6SRE/9DHPubMm4bPCLbYM0Y2O1pmg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DM6PR12MB4329.namprd12.prod.outlook.com (2603:10b6:5:211::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 02:06:21 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8534.031; Wed, 19 Mar 2025
 02:06:21 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Naohiro Aota <naohiro.aota@wdc.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
CC: "dlemoal@kernel.org" <dlemoal@kernel.org>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "hch@infradead.org" <hch@infradead.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v3 1/2] block: introduce zone capacity helper
Thread-Topic: [PATCH v3 1/2] block: introduce zone capacity helper
Thread-Index: AQHbmHGOqqAPbZ3po0uI/YlQ9VLPaLN5tiGA
Date: Wed, 19 Mar 2025 02:06:21 +0000
Message-ID: <a92da829-79f3-47b7-a37a-c99b69cebad5@nvidia.com>
References: <cover.1742348826.git.naohiro.aota@wdc.com>
 <3b1a27ddd0a5c0bc1e60d9802eb43c91c7d22617.1742348826.git.naohiro.aota@wdc.com>
In-Reply-To:
 <3b1a27ddd0a5c0bc1e60d9802eb43c91c7d22617.1742348826.git.naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DM6PR12MB4329:EE_
x-ms-office365-filtering-correlation-id: baade976-30e8-42b0-13b3-08dd668aa4f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?a0hmYjlIUjU5OWFvUFRGM0ExYXBJdGUxa3o3Snk3N0RmRForRWZLUmlJMzVK?=
 =?utf-8?B?SlVWQ2NzU1ExV042QkhJV0RVMG8xcVpSdXFMb1hNeittanJnQm1WK2MyT2Fx?=
 =?utf-8?B?RVZ2QXR2UGV0czZvKys5R1FXangwaFNoTnhCQzRQeFBWd3gwdW9iY05UUHYx?=
 =?utf-8?B?YkFHOUhiZFZpN1dhamdRRlBtTitFN1NRUDA0VGF6OEc5STBlZmtzK1FMQ3Ba?=
 =?utf-8?B?SmhSdzZ6dUR1aUtHbytWamFMWmllT2wxdHJsUXk3cFVZTldNbHkvS3hKUHho?=
 =?utf-8?B?L0FwSi95d0dkSk9tdnBVeU5jWVJYQTQzZ2t2NHQ3UWZLWVJpVFIrQkt6Ky96?=
 =?utf-8?B?NHpPaEpVS1JPMEJFYzJhbXRjRkxNNGRlZU90WnNybW0rL0lDTmFnYU9SMWdT?=
 =?utf-8?B?VCsybmw4VlM4a0xpTzIxYmN2V2FEdmEybTgxdnVPZXFyUy9QaDRqdm9ZVzZZ?=
 =?utf-8?B?L0ZoQUxTV0lzQzhCSUZRSmJUSEVvUzU1S3ZqK2VHUHQ5aFMycGpERDE2Tzhj?=
 =?utf-8?B?SktwL01sR2V0NGppNC9SZzhvU2R1VXgyMGJWMDZLY3hlR29hdjZ6VThBVVR5?=
 =?utf-8?B?T1ZITkhjVGVMQ0hCSTNXYno2czNCTkExMEE5SzUySGJlT0ZIdGdWK3FBRmFz?=
 =?utf-8?B?a29XV3dCMWZsK09sUFdOdDg4UncyWSt6YndpMWRsdTVPN2hFd05LOGlKSkt5?=
 =?utf-8?B?S3pOSDB4cXZQYWhTdU5kSUxueHBjR0tqOHB3aVE1N056QjVxSDlVOU1Tcml0?=
 =?utf-8?B?cHZoZFU5TjlCdzl5WTMzSVdreWx1cGNteGphMEFja0Q1aXBHeXdUWDFOWXRN?=
 =?utf-8?B?RStkU3RwVDk1Nkc0OUhyREptVlF6TGk2bnZrS0QycENaeTM5TWt1ZnpNRlJa?=
 =?utf-8?B?U01XWWwxbXR4dXQwMC9oUElwcTYybU1VNFRWTjU3STFVVFh2dmRaREZzR0RG?=
 =?utf-8?B?Nm1RRGF5ODVBWnFydVhwcnU2OURnL0hkTjFrNWlhRWdXVitSUTdNTkRES0N5?=
 =?utf-8?B?Y2dJM2trZUQyRmJIQ1pNT3BJZVRsbkNQb2dHYnlPb0pUelh1VThMU21TV2pK?=
 =?utf-8?B?TDhBa3hPR1RQSHlnQ1NDUE1oVmdGTG5BcFBYejYxcmhUeWRDUEdUVnYyai9K?=
 =?utf-8?B?V21qZ29lYWQrRjVjekRuU3dvYlF6WUtxblRLQ1oxRzJ3UFhERmdUZjg3WEVY?=
 =?utf-8?B?UkJ4bEQzbmxEWkRNSjg5NFFoSkg4WkxNVHVrckJuTUtVb1VWQmpzYWxMd2V1?=
 =?utf-8?B?Qyt1cGdNSTVTb3QzSEpLNFNxYjBBdk9zRU5UUFk5VnFrdUdOSWt6M2ZKVUdB?=
 =?utf-8?B?NmNrVElVUng0NkxlcG15c0dvOC9JaFk3RGVRY283d1VaOVRrZDBEdTdESWho?=
 =?utf-8?B?VXUyQ0NvelJrd2ZpOHZMUzJLZEF1K0JMNG5KVFpkNWhLaHhrSHlUMnZ5alF1?=
 =?utf-8?B?UjE5YVg1TjRRYi90UDBseWIybG8zcy82dFVCQUwyYnp1bmRVbWx5N3RodE9K?=
 =?utf-8?B?SW96WTAyVFVjZEhQajlOU3pSaVRpUEhWcnd0K1kwQzFBNlpTenVPV2JMWFZC?=
 =?utf-8?B?WXJyY1BrdEI0eldrODU3Zm9qWTFQM3RWRHZ0Vkc2bnJQWVpQd0FScjBINXds?=
 =?utf-8?B?aFcrLzR3REVBelhqRi9hZFZ2V2I3a1hid0dLaEhNd1lyNnRlWm80MUg2cElw?=
 =?utf-8?B?dmtOclNrVUk3TWZyZHJBVjRuMkJxQkxCQVlOemF2UUF4U0ZkVDkzVnpUbWwy?=
 =?utf-8?B?MUYyaVJEUmJwemRNbXdJdTkxMUNreGxBUFhlNlNZZi9ZeUY2UU5qS1AyZjdo?=
 =?utf-8?B?eGRZVlVGdGZCVlNjYThxNko4b0w1L29tYjNEWFNId29nMjBLc2pLYjhvanQz?=
 =?utf-8?B?RGNUaTVPS0Uzb1pDNXhtVjE4SmZpNkFDaEtOV2lyV1pKcVU3M2tncGVlRFY2?=
 =?utf-8?Q?9tcGc+uPJO/exb9UDsN+/7BE6VGMcZ/+?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ODZxbU1Qa21aZE9FcTJPZy95NjBKQ3kwM1JXQmpkUzVMS2hvZTdHWVVXbUov?=
 =?utf-8?B?NzhPL0xSWCtzbjlaRlVlWWg3aXBRM3ZSVGNUai8wNHduUzZqaFlrbkhtdDcw?=
 =?utf-8?B?ai9rWHMzRDVLSGlLMmVuR29TQW0wbm5OZitkTTVBQkttUEk1UW1lK2poTHpK?=
 =?utf-8?B?V21CSFcxU2VJLzFIUGlsL3lYNXJ1UTJLU2VoenRqNkhnYzBrTytUZEdRV2Z1?=
 =?utf-8?B?ZDZROUo0V0g5eCs1ditJb3JiZk1NU1V4dmJTRTQ1YmRlNktpLy9wNXh6citv?=
 =?utf-8?B?aERkZjA3Tm9lL3kxY21QS1poRGI5T2hTSDR1QVp0dVBZd0NPRGYyVzJUUFBt?=
 =?utf-8?B?dTA1QzFzTjUrcmtTTFVGZnQ1aWFzWTR1OFFHai95dW90ZXpUc3RGS3M2a1M1?=
 =?utf-8?B?WUhOeDZMdjc1RUJEWEVlMUpXWEpUcjV5WktINWVQL0FjSWpYaFRmVUEvbzg4?=
 =?utf-8?B?QjRUbUMraU1QN0cyMndFVjExZmQzR1VpekdnejF4ZmMzVjRxRWFyQmJXMXYx?=
 =?utf-8?B?NVVmS1RqKzBxc1EwMTB2bHUwYkwra2Jkczl4WWxvTnc2TUdnN3Q3dlZsK055?=
 =?utf-8?B?bWEzZkdoWUllWGJ6ejBPYTFGSkY5cHdqTzZrN1JkeGJLK0xYeHRKaDgraS9h?=
 =?utf-8?B?VFQ0UFMzcWZSMWFadEd5KzJ4WHVKamZ5dU05NmVoTmJEU0ZXMjR1WG53alRC?=
 =?utf-8?B?T2xDSDBTVzNaL1Y3ZUNBanlyZC9kclh2c04vZEF6Ui9wWFN1MmZhdDJvSUlI?=
 =?utf-8?B?NUxwYWtFMk41aHZ2Wm5WYUJYQ1orbjdjQ2Rja0xBcmx1c2ozVzdKanU4aVZy?=
 =?utf-8?B?YW1qaFRwRG1DS2FaMWthczFmcSs2ODcyQkFwQjVGM3FTYjFaeFZleWN3a2xv?=
 =?utf-8?B?K3NXNlpBMEVCeFJYOEV6TDBuVk9IV3p4RlVVeTVrQ2VFak5hSyt1Z01wUXNm?=
 =?utf-8?B?NFQvUUlaUlYycnN3M21zUEVxSzRJdHFib3MrWXJJd3d5cDIvcS9sY21iMlFR?=
 =?utf-8?B?VWxsUnRnSGhkNFZaRmxDTXg3VUhIa2VsazJXbExpTmlyUGpyZUpPbjVRb0tr?=
 =?utf-8?B?R2QwZnNKNEhoUzB3U0luQVVUT1I4eDZ6YVN3RUVSKzFOUkdkNFJvTXRZak5R?=
 =?utf-8?B?ZzJVbC9kQmZ4T3Z1SXY3WUduZWdRQ2FaeGs1ejZTV3pOREE0VGIyNnlWa2pS?=
 =?utf-8?B?Z0w1NEFYUGw1S3h2M1hsSmE3REtLeUpmU2h3T1dIclh0VDQrdXVlRFpuZC85?=
 =?utf-8?B?Zml5NFd5QWFmSWNoTHk0OHI0VEVMY25HMW9yRFlHMjkvVTdoMmJPeDI5dDFh?=
 =?utf-8?B?dzgzSHByOGpacEduNGNMcWNoTjNyeHFqUCswVTBVNFZWdTFiQVZTZWRJRkk5?=
 =?utf-8?B?U3dRODJTcnF2WHhZM0UrT3hQbC9FZmNwZlFPU2tRcFp0S1dYRGpDa3o4ZTJ5?=
 =?utf-8?B?dkRoMXNsZFEyUGtmTWx5UkorUWsrUFkyb2pxS3NPZytELy9YOUljWDNPOTRO?=
 =?utf-8?B?Nzh0YzlKc2M4bHQxamdkT254VUNPSk1DQlFDMjJVcWgvL3lLQ0IyZ2tycWZP?=
 =?utf-8?B?dnJTL2czYXpPYzd6eTdtVE5zTHdISk5nLzR2WldSR1FhNTFyNTdqbGJqV2xu?=
 =?utf-8?B?M0ZvS2Q0Z3hWR2hnZGEyb2dBMEgrcFZwdE5pbHVhQmFvcnlPaks1a2xpNzNu?=
 =?utf-8?B?Mkk4MVhPS0JUc1YxNW9aeHJyM2RoNDErQzJLLzkvMmp6MVlLNFM1ZGZGV1dJ?=
 =?utf-8?B?dEFxckYxQm44WlhJS281UkFtWWgwMkE5L0JjU01EM0I5Qm5zY0lzNVoySGZE?=
 =?utf-8?B?Vi8vOTA3SDJiNW5sZzI0VWhkMGRmT3RlMjVsUHdxaDRPZ2Z1MVV6bC94OHhK?=
 =?utf-8?B?akhCZkRQMjc4OS8xa2RRQS85alhUeWNxR0ova00wYno0R1JFdFpFNWZ5aHZ0?=
 =?utf-8?B?WmVaTWJ4aE1Bai8wTVNVU0VZSVljTGN0bXZNOFp4VFlwNlAyeDFKREVqMXFU?=
 =?utf-8?B?b29HSjE3V0N1bHVmTE4wRStWZkRSZUhTS1lVOEFKcGpyRVVqVFJxcmVXektP?=
 =?utf-8?B?RnhLb1R4QUFtUFhjaHhBTUN2aEVUY1p4YWRuM1BldnNBYmtUemxOblZBQWdW?=
 =?utf-8?B?NlBiYmc2ZXlwbXZzSUhLbFRwN3VrcURteHkrY3k5TFUwMzNGRE5GL29SMUJU?=
 =?utf-8?Q?zfqkf46VA9vGFqb4buSqp/EKpt+1ZxSS5GDOxAD/91vq?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6B0A02913E48E249B8852877BE2EF257@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baade976-30e8-42b0-13b3-08dd668aa4f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2025 02:06:21.5107
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UYRt6BHnsfi8eAoAW270iN4FUamhx6Y2HNJoo5XH9LlG/ciSbkHThQJhQF0lz+1pZSS7bLJlEw9BefshjrWEQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4329

T24gMy8xOC8yNSAxODo0OSwgTmFvaGlybyBBb3RhIHdyb3RlOg0KPiB7YmRldixkaXNrfV96b25l
X2NhcGFjaXR5KCkgdGFrZXMgYmxvY2tfZGV2aWNlIG9yIGdlbmRpc2sgYW5kIHNlY3RvciBwb3Np
dGlvbg0KPiBhbmQgcmV0dXJucyB0aGUgem9uZSBjYXBhY2l0eSBvZiB0aGUgY29ycmVzcG9uZGlu
ZyB6b25lLg0KPg0KPiBXaXRoIHRoYXQsIG1vdmUgZGlza19ucl96b25lcygpIGFuZCBibGtfem9u
ZV9wbHVnX2JpbygpIHRvIGNvbnNvbGlkYXRlIHRoZW0gaW4NCj4gdGhlIHNhbWUgI2lmZGVmIGJs
b2NrLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBOYW9oaXJvIEFvdGE8bmFvaGlyby5hb3RhQHdkYy5j
b20+DQo+IFJldmlld2VkLWJ5OiBEYW1pZW4gTGUgTW9hbDxkbGVtb2FsQGtlcm5lbC5vcmc+DQo+
IFJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm48am9oYW5uZXMudGh1bXNoaXJuQHdkYy5j
b20+DQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtj
aEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQo=

