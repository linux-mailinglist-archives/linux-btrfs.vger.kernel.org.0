Return-Path: <linux-btrfs+bounces-8772-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CAE7997CBD
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 07:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBE39B23833
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 05:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D3C19DF9A;
	Thu, 10 Oct 2024 05:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OZ/dEKY5";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="GY9KGx6J"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3706818C03D
	for <linux-btrfs@vger.kernel.org>; Thu, 10 Oct 2024 05:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728539751; cv=fail; b=ntBBivPiD0GNkQI3JIFxfl3F3QRg7NUx+PBmH/b6C6LlQUyqgPirz6LP/LP7qSIBcbH9PEvGANMTlv2d+K//hBFEMYxfJ4Of0Sbb+KgP3IccmXpYfC1ox6b6LYQSGWmnoEtcQUNuUbMgkY2Lr5dUswuhcUMahmww+TDJZ2VecSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728539751; c=relaxed/simple;
	bh=xjb9Toqo/uMe2G/gd16Q7jLIhxWsMefeyR0RawnIZHY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gjFQhGGbozUCQfqaf5AxxC9wDdKdd7wSO5at6OulHM5AvBY39VOhwhkr1k8YEG6duoo2o5hDdzFfB8N6kRIrEk821he4yHgMBTRW5gyMLXjzeD3yr9J8ab0tdjHwppd5Ao9cz+wVIlXvWPC85NvrIlxCeDUmc5o086CnqWmzwXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=OZ/dEKY5; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=GY9KGx6J; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1728539749; x=1760075749;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xjb9Toqo/uMe2G/gd16Q7jLIhxWsMefeyR0RawnIZHY=;
  b=OZ/dEKY5z1LHvIy3kf687iInnYVXVNU/cSg7E+v1st62eBTpNliptJMY
   089KYCutgFE94BN9hHdOBHQDVYnrGTjnJZVOJo0niZR2Fhyabvzycy3uc
   dXJ3AZb+bQRQ0SKqEZPtMTM218xt17NS+fIE0WAge4etShsjJccpvB0Sl
   OYCrhQVowOjhS7RH9xVya48ZsbvjdgPmBdN5Te8l/oVAa4cqsrynmABDt
   VhmBtBGhZD8p1td1mjNJsp7hl5kV/Ew6GU8FLc3mhCcVUwxyNBBQ7bwXK
   5/AHne35VlrnC1NrVN7yWFEFiXYQHHaEl6i/IDtjsDEAxxNl6dT+I3YWJ
   Q==;
X-CSE-ConnectionGUID: Oj4HyRjLRfa6MQJ6CmsY1g==
X-CSE-MsgGUID: YKn2d/6lQG+3M6JakHsgXQ==
X-IronPort-AV: E=Sophos;i="6.11,192,1725292800"; 
   d="scan'208";a="28742278"
Received: from mail-dm3nam02lp2045.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.45])
  by ob1.hgst.iphmx.com with ESMTP; 10 Oct 2024 13:55:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T6ydQShHiPSEc3dwY0U7GAavS1+2W5ALzX1L7SpOlzLOtD+HfEd0JrA6Aq+erKn0AVZl3RqU30a1iuy6YFyeOdaDJ+RFkqA4TYDsQVNZqIgX2oYOsezyKIi+Xr1Lk9O3kuHXJGa3ggHXYOVj/ziRZ0DGkeC0HiIwZ70OmL/kNbIHIqEfaSLYX2W0XhZeeZcnYrEKcrp0ZS3ztdUHV2N4yRLDBO32UlPyRkX9QvEIIEbLLXtKLB9sANTzjFVUg7QH30ZVg17rFFExRTINup0wlZihlCG05tKSdNGbL3fj5rc04wat1aQlsSiWBVqr0zxT+mOUlXqIEmJFwfJbEnhtFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xjb9Toqo/uMe2G/gd16Q7jLIhxWsMefeyR0RawnIZHY=;
 b=xQ9tQSyVypWGM2CoWZJJhrW6UDfMKsgPEHCsba77NAvYjFhdxB94LAqhMKG8wSEQAoHsTFn7iFvXIeNsporlP76J53h4GBNX5QPWwfI/hjs+ZA4fvZjMwu7pryPelDAZKL/TnLmvONMyRb2Tc53k2yZ+KujXhhfO6EjOnsrmXXYBKrytLX3N56Eea5qCBdENkwI/MZssG3gcM1yly76AZBn91wwZnCD8s4xPI0CMFJbrAROnlYwik12+a19i/7PuoApdbPTY+QGKuUAki6XU5Ew74Gzk8GcyCoO97fa7urW6HLFAshl+HpXhyUngU4Br1EKQ6Gfw/6Fpzf35VHZeMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xjb9Toqo/uMe2G/gd16Q7jLIhxWsMefeyR0RawnIZHY=;
 b=GY9KGx6JLO/oH9tIJXNcekUwy/ls2Ar6L5wpIOAe9/VKcd3MFum5xBhP7HMZON/szk21o7P7XAg53VoDsIzpVgGSzQrd7rJS3dfcMASg4nyR1dhh15XqsGMgOg01A0WebMHwyd22h6MQLLp8i8noteqN+hjprqg81A0gsGdWq1U=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB6681.namprd04.prod.outlook.com (2603:10b6:5:24c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Thu, 10 Oct
 2024 05:55:46 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8048.013; Thu, 10 Oct 2024
 05:55:45 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Filipe Manana <fdmanana@kernel.org>, Johannes Thumshirn <jth@kernel.org>
CC: David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>,
	Filipe Manana <fdmanana@suse.com>, Naohiro Aota <Naohiro.Aota@wdc.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] btrfs: implement partial deletion of RAID stripe
 extents
Thread-Topic: [PATCH v3 1/2] btrfs: implement partial deletion of RAID stripe
 extents
Thread-Index: AQHbGmBpcs30+Qb4ZUSrcQZ0vkIQurJ+n40AgADdyoA=
Date: Thu, 10 Oct 2024 05:55:45 +0000
Message-ID: <353f80a5-3fda-4061-9438-6b53e1500d8d@wdc.com>
References: <20241009153032.23336-1-jth@kernel.org>
 <20241009153032.23336-2-jth@kernel.org>
 <CAL3q7H6Nv+GSpPHMsQ-H4gdz4vk-ecXgtScqCHP1wsNkaB7H9w@mail.gmail.com>
In-Reply-To:
 <CAL3q7H6Nv+GSpPHMsQ-H4gdz4vk-ecXgtScqCHP1wsNkaB7H9w@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB6681:EE_
x-ms-office365-filtering-correlation-id: 0e92ef3c-d2c9-48d4-519c-08dce8f02f0b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|10070799003|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SlhGQXkxclBVblNOa1pSQS8rZlVmRXhIZzlwN29iNkk3TVVBR2tZbmR2dEU0?=
 =?utf-8?B?elFuRTVvc1hkUExoWTh3WXN2bWZPZGRkSlBiRWNHSVpFSkJrVENrVWZ4Mzls?=
 =?utf-8?B?T25wS0tXZW9RY0lUMSsyQ2VQaHB5Wi9GYy9tOFNRamg2UFFza2hHR0FZR1V1?=
 =?utf-8?B?MmxaakNWSjJ3ZldGRVY5QTlsWTlXMnZtSUdvR3lvUDF4K1E5VG8xVEVOYlZl?=
 =?utf-8?B?ckdqYlNERkoxUytoV1pIbTlNb2dZUlpXa0c5MEFRS01pMG4xUmVKalFYSDJq?=
 =?utf-8?B?bXNhd2JUY2VwSi9Scjk5U2FmV3hOMUFLNXdVSm9OMDgyT0dFOFlkZDFXSURy?=
 =?utf-8?B?TUJ1SjBqemhFRzNSUXIyOHlnbVI1NGRlaWhEdE4vZ0pUZUdiclJsTGdOWU9G?=
 =?utf-8?B?Vlo2UjAyc00zQkxueDFUdVIzbVhVQ20yOHRjQkRrUmhXaVkvb1FIdUpKaHRN?=
 =?utf-8?B?R3NoSzlIMFBwMWh3ZzFyWHFHaHJLaXZqWUs4ejRCTENaSlZhc1BBR1UvZ1NS?=
 =?utf-8?B?YWxWVkJtMTc0WjcrK0dPaVBCK2Z3RkdxSFJoSk9NUDlKU0dTUVVCTFRGU0Z3?=
 =?utf-8?B?dWV0SUFsMi9MSkxvQXJCakNiclF0bk5xdFY3UGxPVGs5SDdIamk5V01UMXlx?=
 =?utf-8?B?T015cFZiVzF6enFRSmZHM0Z4Z3ZrUFp5SkFiSG5kVDYvWlY3Mzg3U3NGcEhm?=
 =?utf-8?B?UnJIOTJqVXpMWGJHOWhHQktYUDBjY29NUklUR0VtUlJKQlhtdVZGbkNkN3JN?=
 =?utf-8?B?WTNkVkRpQ2RmNGg3NFUwS2ZVNEplYjY2eUdNamlscXoxekFqTHpjN1A3TFBl?=
 =?utf-8?B?dlhaRFg5TDdVOGI3V0FnSS95Y0FLVmVwbEdMSU96SmlQYW1nRWtZb2dpVk8x?=
 =?utf-8?B?LzVIcS9oaEV4R2xBR0RYRWVTNHIvTkVCbDh1ZTk1aHo3Q0MzcHhKL0lRVzVW?=
 =?utf-8?B?dzV1REhWZFNMT3dxeCtJTHE5enlWK2RKU3dpVlB5TlQvM0tJQXNZKzNZc2pL?=
 =?utf-8?B?K2xMRUthd1ZqeXEvRU9CRm1QY05rc2dPaVFTdzg4RHJPc2k0SHdNZnVCS0tx?=
 =?utf-8?B?Yk9MRTlnWTh6TE9CNityenZmL2Q4VEU0bG1jNHVHUmpLMjB3U1g0MUxoOVl1?=
 =?utf-8?B?enVKTTgyU0pSc2dBckk1eXJWMEpYV1FSSTJ4OUZPSTJuZjhra3JONGRUZ200?=
 =?utf-8?B?dUdLSHoyUlEyM0JTQllBU29oNU84NXB1S2tLT2poMzU5SXlGdzB2dk83Y3Uv?=
 =?utf-8?B?eDZTblhkZTJqN2IxMytIQlllSjZzQzNzdGFQVVM4b1VmUTg2dkwva1laR1ZZ?=
 =?utf-8?B?M2xNZ3JNYnErYmVaV0RhbVNJZjNic2x3K2VKSDNLRmZCcWFTb1AyYmxGTVNP?=
 =?utf-8?B?UHFEOTNpaTIyT1Z6YTdzTFJjdmtSYktzMEl1U1c1ZlRBTVNXcmRkc0RFK0NL?=
 =?utf-8?B?UUcveWNsdDYzdE9TL21KbVhTazc2eFZLak96dGpoMVJVQTh5Vkc0dUFqbXZP?=
 =?utf-8?B?SmZTUndVWHNYQ3R6YUhPU1F5WjN4T3BEdFJaakNXNDJTWEswUCtHR3JFcU9k?=
 =?utf-8?B?ZFZVMy9Db2JDNWhoVEtURHJvRHh5MHY5OVFFUFVtcllRdjFxalBwVURQLytM?=
 =?utf-8?B?TjUzbFduU1JLRFBuS1lmZVJxQlFMRi9qZ0pxL1MvRkxwWEcrZ3B0RUpGRytG?=
 =?utf-8?B?RjJleHU4YkNJYTBxR0gyekh2S0dnWTNZemNIcTNEKzhDLzVseFhmN0YyVWFm?=
 =?utf-8?B?dGxJWGNjVUZMTVhFS1E3QWtNRERFVm1UZVUxZ0RqMlZkQ0NqTm0xVGMvME5k?=
 =?utf-8?B?MmhlaEdXZGpuZzl3eHB3dz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VWNING1wZDAybFRLaHVuVDQxeENnWWMxcTJBc0xOclV2d2xTR2hJcGZmaGpp?=
 =?utf-8?B?OS9kMGFOWElvR3JFOC9VTkw3aWt1U2dsZDVhcExHMDJBeUZxTVBoMjQ4R0p3?=
 =?utf-8?B?bDd0S3ZMRlYxWE5Eanh1SlZxUHVZOGJOa202TWQyUzRONHA4U1JQRlZhTkhD?=
 =?utf-8?B?YmhHeGc3UkI1M2JrT3lXZ2NqN09wQWI0VXUvSW5KSWJEK29ETG9ZUTJYVGN6?=
 =?utf-8?B?eHloeGpmK2tmc3U0aTRVTXdsL1JyQ2gyaUVzK0FvTXcwdG1jenhqSmJNSURG?=
 =?utf-8?B?VDNKSTc4OUJqTUt5elZCMnFMMmMyMGpQVVBUTGJsMlBvQUFVYUNlRXRSbzBP?=
 =?utf-8?B?NDlzUG8zbTNGMWM0S2J3bmx6OERGVW1Fd0dGK2dEdjZVL25PS1pkZnhrajBi?=
 =?utf-8?B?VVc2b0lpR3ZWbEFSM284T0NQSDNxekpHNWFmL1BoaHRSM1VEZkVDdEVFRlRQ?=
 =?utf-8?B?cDNDRy9lRlViWW9WbHR2Y05MN1o2bmxWSStCck9VcW0xdVVFakR0Z2t2bHFP?=
 =?utf-8?B?YjRaMCt6ZElYdXZCOWxmekc3MzhMZ09tMEhxMHNSaVYwbXlUbGx0TTRZNzU4?=
 =?utf-8?B?Yzl1cGlzRiszeGR2R0pTSjhJUkdrQWxXczZiS0gyZjhTMGVvbnVHaGRRaTFJ?=
 =?utf-8?B?SVdXa09pZmRzR0UwVDV6c01NWUpPKzUyM21qRmYwZ2NvK0ZESXZZTkNKbngr?=
 =?utf-8?B?RCtJcVdydUEwVm9TMnE5OTJUWEl5ZGRpZjhTOGxXaFB1bXRaQlZsejVxbmZ4?=
 =?utf-8?B?a2thWkQzYUJXSUt4c2VZbGlyTmlKKzZBWUJhQysrTUZHZFBZZ0s1WWRYaW1F?=
 =?utf-8?B?QmJQRjl6TjA5SXpSdjI1M0crV0ZFU200TVJQejBoOTkrNEsyM014clVXZEZ0?=
 =?utf-8?B?UkNYNGdjYm9pTUtKWTdmT3JDb2JtcDRScGg2b1YzZ3ArZjkvbVZZVFlBejJx?=
 =?utf-8?B?OFlJTEt2dzFKdTA4NDcwT3kxV0VLdnFlZ1lMOXJqTHR3bHM3T3o2TnBkajV5?=
 =?utf-8?B?QWl3SVlXVTZUbUdQTnZPMWFuYTl0Q3dCekJzOGFoV0tSVHRaZmxPQ0lEYmpW?=
 =?utf-8?B?NTh3RHo1eW1lbHFXd0wxMjBwbUdVV0NNZE9pb1BQVGFsSkNTTTF5Q2NtZ0py?=
 =?utf-8?B?Zzh6MXA0NFFNMjBLVFVORnZzT2RxZCthamdEZXN6Qi8rbUpCNFd4bFl2UG56?=
 =?utf-8?B?YjRzcjEwbzlzV1lFSGxIRGdaZGJtdWZnQkNkSkphMWdRVEZrNHVrY0hzcTRS?=
 =?utf-8?B?SnM2NkxoamJmcTVUYkdaTWFFWTFVWUQwcWZHSTVMQXdyUUE4TnRyU1diVlhE?=
 =?utf-8?B?c0p6a2hPdVRCb0FsbkpFem4zNXBySjg1MEVKbTZLdy9MUEtNRU9lbVVwYjFx?=
 =?utf-8?B?SmY5aDIrYjljQWNNbEJCSGVVU256WUY3aUF3REtRQkErOTJNQkY5VC9DcmlS?=
 =?utf-8?B?bkd3UjNLbmkwSjkrVW1zdi9sY1V4SUtvZG5mUkZDUk16Wi9VWDZhSkl2cmpt?=
 =?utf-8?B?clhnK1ZYcThINTlObXc3eERjUGRMMzk2bkpUNXVCNzdNQ0hpL1JCK1ZPYlNJ?=
 =?utf-8?B?TUNNZXU2Y1ViaWR4aFJ1eVFvRmpEMWorWHpkN3cyNm4rU1ozOWpVMGdUdVNB?=
 =?utf-8?B?cFNhTWpmNU1vODNheWpSNWREWVp3NEFwMEhBb2p4bHRpMUhqWS9vejJzWUZT?=
 =?utf-8?B?Y3p6c1JIMnczVzNrUndDTGhDWDJyQi95NE1GS0tTWk9hODh2NUVkMzFCR1VP?=
 =?utf-8?B?Zmd0VFYrWXl2SGVZcVdLREErQ1Q3QjFqTzBYTUpQNUZiUXk4SG1iRzhXeVM3?=
 =?utf-8?B?NHpmMGhVWDFrTC94SlVhNU84eVRqSFNjazRnY2NhdzdZK2JUWUZBcml1NkQ2?=
 =?utf-8?B?RWVWdlFBRHREejVYcnJNVVhPYnZCMjcwNzVYU2lqaVBNa0JsUHNHTEdUNXZ5?=
 =?utf-8?B?cUtSTTdGcEVMb0FlNTRCRGd3eEtxNkNGcWZMeUw4RWhDL2J3d3VnaWVDUVJu?=
 =?utf-8?B?VnRHVGxlRXVReE5PZEhBWUh4UW9hL29hVGI0UTZMZEpEWUNudE9GdWkvUkNr?=
 =?utf-8?B?aytTamp5WlZMby9lZysvRGliQzk4WDNmSXFTemVtUFFMbWJJUkozb1hKZncx?=
 =?utf-8?B?VUlpOE85YlhodUh3c2cva2VKRUpST0lMZHNjeDBXa1J0UDNZaGpoZFlkSE1J?=
 =?utf-8?B?dllJVzRRM216SUh0MlQwY3c5YmtNWGdDYjIxV29YalpUT3lhTTcwNFE2cWov?=
 =?utf-8?B?YlFzMTgzVTJVL21BSnVSck51Z01BPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <63FCE6A80C34294BA4E512CFB335E2A7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	S18LwdT+b72f/U6hj0+IKucGyimHsSvef9Bb36hY4kqkTK/Ha1TwRiKH8h4gBGq6cnuj3DyfRi95agLyqsTR7/hhcCiCW4YWM/dCccRezQ6+xZviudrIfLLl9655bvGMOtkqP0WSwlkEkw5oR98ntJTufhLOZS3AQmp1FzNPyeHiy82Svo8aHqp+Ws6rBpRRNSdfK0nDJ3TXHkEhST47ngrbje66B/9H/MPV0+xN2SAI3yAL76GJKYMLOuUyC1Cnp4Cf7I7EJqPm3QEkFUHzzTo4vVsTUgbAEFzNrA3twLaBRkBt2GgMiVcoWofwzhu2E5WosJGRVVWU5WmwPhendl9Jpcaf8oillOxTTse91/rlkaKBCj8AqDqjw/WAaZqfk0GlyMbWI6aJsZsrIsUH6TSAC0v5ZYejZjb9GiPjQlJm/v/VPD4q6+aAnaFtr3BytP507xlXCiUQ3HhvGvxW2B9qaozqU+lYQ+oLJ6ByJmX20rhUvVhSketogkdhibwLGf13jAGCoqLIysGo/e3REyA7gT5V7tIv/7JwjLsHaei99VgD5pmlwma7gamu7+Ld8Bx7cS6ZL3yQ7+AZHtrBPnaa/xQZq9UlkB+PcvL2BVoX1ZYD1Yq5L079CD0bTPa4
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e92ef3c-d2c9-48d4-519c-08dce8f02f0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2024 05:55:45.8800
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RHlFJpm1wohyI9ZekXsquJSFlej9A4vNO9Iv/vnsUbHAGEUdnSbk+9vrLtUol6W+h89E1AbdrLHsicJhc5q/bKBoZy+vO46YAqI4Agl0uGk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6681

T24gMDkuMTAuMjQgMTg6NDIsIEZpbGlwZSBNYW5hbmEgd3JvdGU6DQoNCj4+DQo+PiArc3RhdGlj
IGludCBidHJmc19wYXJ0aWFsbHlfZGVsZXRlX3JhaWRfZXh0ZW50KHN0cnVjdCBidHJmc190cmFu
c19oYW5kbGUgKnRyYW5zLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHN0cnVjdCBidHJmc19wYXRoICpwYXRoLA0KPj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBidHJmc19rZXkgKm9sZGtleSwNCj4+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1NjQgbmV3bGVu
LCB1NjQgZnJvbnRwYWQpDQo+PiArew0KPj4gKyAgICAgICBzdHJ1Y3QgYnRyZnNfcm9vdCAqc3Ry
aXBlX3Jvb3QgPSB0cmFucy0+ZnNfaW5mby0+c3RyaXBlX3Jvb3Q7DQo+PiArICAgICAgIHN0cnVj
dCBidHJmc19zdHJpcGVfZXh0ZW50ICpleHRlbnQsICpuZXc7DQo+PiArICAgICAgIHN0cnVjdCBl
eHRlbnRfYnVmZmVyICpsZWFmID0gcGF0aC0+bm9kZXNbMF07DQo+PiArICAgICAgIGludCBzbG90
ID0gcGF0aC0+c2xvdHNbMF07DQo+PiArICAgICAgIGNvbnN0IHNpemVfdCBpdGVtX3NpemUgPSBi
dHJmc19pdGVtX3NpemUobGVhZiwgc2xvdCk7DQo+PiArICAgICAgIHN0cnVjdCBidHJmc19rZXkg
bmV3a2V5Ow0KPj4gKyAgICAgICBpbnQgcmV0Ow0KPj4gKyAgICAgICBpbnQgaTsNCj4+ICsNCj4+
ICsgICAgICAgbmV3ID0ga3phbGxvYyhpdGVtX3NpemUsIEdGUF9OT0ZTKTsNCj4+ICsgICAgICAg
aWYgKCFuZXcpDQo+PiArICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9NRU07DQo+PiArDQo+PiAr
ICAgICAgIG1lbWNweSgmbmV3a2V5LCBvbGRrZXksIHNpemVvZihzdHJ1Y3QgYnRyZnNfa2V5KSk7
DQo+PiArICAgICAgIG5ld2tleS5vYmplY3RpZCArPSBmcm9udHBhZDsNCj4+ICsgICAgICAgbmV3
a2V5Lm9mZnNldCAtPSBuZXdsZW47DQo+PiArDQo+PiArICAgICAgIGV4dGVudCA9IGJ0cmZzX2l0
ZW1fcHRyKGxlYWYsIHNsb3QsIHN0cnVjdCBidHJmc19zdHJpcGVfZXh0ZW50KTsNCj4+ICsNCj4+
ICsgICAgICAgZm9yIChpID0gMDsgaSA8IGJ0cmZzX251bV9yYWlkX3N0cmlwZXMoaXRlbV9zaXpl
KTsgaSsrKSB7DQo+IA0KPiBUaGUgbG9vcCB2YXJpYWJsZSBjb3VsZCBiZSBkZWNsYXJlZCBoZXJl
IGluIHRoZSBmb3IgZXhwcmVzc2lvbiwgYXMNCj4gaXQncyBub3QgdXNlZCBhbnl3aGVyZSBvdXRz
aWRlIGl0Lg0KDQp5dXAgd2lsbCBmaXggdGhhdCB1cC4NCg0KPj4gKyAgICAgICAgICAgICAgIHU2
NCBkZXZpZDsNCj4+ICsgICAgICAgICAgICAgICB1NjQgcGh5czsNCj4+ICsNCj4+ICsgICAgICAg
ICAgICAgICBkZXZpZCA9IGJ0cmZzX3JhaWRfc3RyaWRlX2RldmlkKGxlYWYsICZleHRlbnQtPnN0
cmlkZXNbaV0pOw0KPj4gKyAgICAgICAgICAgICAgIGJ0cmZzX3NldF9zdGFja19yYWlkX3N0cmlk
ZV9kZXZpZCgmbmV3LT5zdHJpZGVzW2ldLCBkZXZpZCk7DQo+PiArDQo+PiArICAgICAgICAgICAg
ICAgcGh5cyA9IGJ0cmZzX3JhaWRfc3RyaWRlX3BoeXNpY2FsKGxlYWYsICZleHRlbnQtPnN0cmlk
ZXNbaV0pOw0KPj4gKyAgICAgICAgICAgICAgIHBoeXMgKz0gZnJvbnRwYWQ7DQo+PiArICAgICAg
ICAgICAgICAgYnRyZnNfc2V0X3N0YWNrX3JhaWRfc3RyaWRlX3BoeXNpY2FsKCZuZXctPnN0cmlk
ZXNbaV0sIHBoeXMpOw0KPj4gKyAgICAgICB9DQo+PiArDQo+PiArICAgICAgIHJldCA9IGJ0cmZz
X2RlbF9pdGVtKHRyYW5zLCBzdHJpcGVfcm9vdCwgcGF0aCk7DQo+PiArICAgICAgIGlmIChyZXQp
DQo+PiArICAgICAgICAgICAgICAgZ290byBvdXQ7DQo+PiArDQo+PiArICAgICAgIGJ0cmZzX3Jl
bGVhc2VfcGF0aChwYXRoKTsNCj4+ICsgICAgICAgcmV0ID0gYnRyZnNfaW5zZXJ0X2l0ZW0odHJh
bnMsIHN0cmlwZV9yb290LCAmbmV3a2V5LCBuZXcsIGl0ZW1fc2l6ZSk7DQo+IA0KPiBTbyBpbnN0
ZWFkIG9mIGRvaW5nIGEgZGVsZXRpb24gZm9sbG93ZWQgYnkgYW4gaW5zZXJ0aW9uLCB3aGljaCBp
bXBsaWVzDQo+IHR3byBzZWFyY2hlcyBpbiB0aGUgYnRyZWUgYW5kIG9jY2FzaW9uYWwgbm9kZS9s
ZWFmIG1lcmdlcyBhbmQgc3BsaXRzLA0KPiBjYW4ndCB3ZSBkbyB0aGlzIGluIGEgc2luZ2xlIHNl
YXJjaD8NCj4gQnkgYWRqdXN0aW5nIGl0ZW0ga2V5cywgdXBkYXRpbmcgaXRlbXMgYW5kIGR1cGxp
Y2F0aW5nIHRoZW0gKGZvbGxvd2VkDQo+IGJ5IHVwZGF0aW5nIHRoZW0pLCBzaW1pbGFyIHRvIHdo
YXQgd2UgZG8gYXQgYnRyZnNfZHJvcF9leHRlbnRzKCkgZm9yDQo+IGV4YW1wbGUuDQo+IE90aGVy
d2lzZSB0aGlzIG1heSByZXN1bHQgaW4gdmVyeSBoaWdoIGxvY2sgY29udGVudGlvbiBhbmQgZXh0
cmEgd29yay4NCj4gDQo+IEl0J3Mgb2sgZm9yIGFuIGluaXRpYWwgaW1wbGVtZW50YXRpb24gYW5k
IGNhbiBiZSBpbXByb3ZlZCBsYXRlciwgYnV0IEkNCj4gd2FzIGp1c3QgY3VyaW91cyBpZiB0aGVy
ZSdzIGFueSByZWFzb24gYmVzaWRlcyBzaW1wbGljaXR5IGZvciBub3cuDQoNCg0KSSBkaWQgaGF2
ZSBhIHZlcnNpb24gdXNpbmcgYnRyZnNfZHVwbGljYXRlX2l0ZW0oKSBhbmQgZHJvcHBlZCBpdCBh
Z2Fpbi4gDQpCdXQgeWVzIHN1cmUgSSBjYW4gcmVzdXJyZWN0IGl0Lg0KDQpCdXQgZmlyc3RseSBJ
IGhhdmUgdG8gZmluZCBvdXQgd2h5IGJvdGggb2YgdGhlc2UgKC0gYW5kICspIGFyZSBidWdneS4N
Cg0KLQkJCWlmIChwYXRoLT5zbG90c1swXSA9PSAwKQ0KLQkJCQlicmVhazsNCi0JCQlwYXRoLT5z
bG90c1swXS0tOw0KKwkJCWlmIChwYXRoLT5zbG90c1swXSA+IDApDQorCQkJCXBhdGgtPnNsb3Rz
WzBdLS07DQogIAkJDQpUaGUgJy0nIHZlcnNpb24gcGFzc2VzIHhmc3Rlc3RzIGJ1dCBub3QgdGhl
IHNlbGZ0ZXN0IChhcyBpdCdzIHRoZSAxc3QgDQppdGVtIGluIHRoZSB0cmVlLCBzbyBpdCBkb2Vz
bid0IGZpbmQgaXQgYW5kIGJhaWwgb3V0KSwgdGhlICcrJyB2ZXJzaW9uIA0KcGFzc2VzIHRoZSBz
ZWxmdGVzdCBidXQgZ2l2ZXMgRlMgZGF0YSBjb3JydXB0aW9uIG9uIHhmc3Rlc3RzLCBiZWNhdXNl
IGl0IA0KZGVsZXRlcyB0aGUgd3JvbmcgZGF0YS4NCg==

