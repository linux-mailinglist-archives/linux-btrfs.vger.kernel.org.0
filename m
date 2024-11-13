Return-Path: <linux-btrfs+bounces-9604-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4F39C7937
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 17:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 693881F23476
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 16:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB7516EB5D;
	Wed, 13 Nov 2024 16:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Hpc2xgPU";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="T+Z78Y2G"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1DC7E111
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Nov 2024 16:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731516398; cv=fail; b=Uf/Z0LRjhraH3FXGKYWWGXgKZnFCSk5LD/KsHAkmR0hXjrDP52BYHFc1ubmhQnZ0pl/SSAUFZtiyDQEvL2rNvXuSoRtckIwjUd6/9sy6LGsHV05Uw9p3D0AgUsUIMaqaCz4IKlrMux4qcBYOj5GaM6B3uPAwX1UtlCrTVuLLzs8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731516398; c=relaxed/simple;
	bh=qemtCHi9poXNpTBzg0eHvfNt2n3ddmdzLrDDrV8QmOw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RBUZFzu6juBit05FZ+CEDLp8qFcPU0gNOh6zMmIzMkbsM1aV8pP8jF9p8mChg1/vkdGuPS0z285CZHK+Gdzk59rMJEqxe2GqyMl1wgdLp4kONrASke5gZ2vAchmK0X9v1CInzDPx8TcqxCDoAJWLyEeiaezdnNivo+KiOiX0tIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Hpc2xgPU; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=T+Z78Y2G; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1731516396; x=1763052396;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=qemtCHi9poXNpTBzg0eHvfNt2n3ddmdzLrDDrV8QmOw=;
  b=Hpc2xgPUURL+4FtpLhLHj068AByd3HLrRwx8QyZgSd4malzth0dojq6y
   6gejrhlbSiLiiBQgLbt45ykT99zvjUk1qj2kaejJ15JbY+F2biHlZAnz3
   xwwgsOnejHlhMzXEAsmJHmlMWjy4LGE4WtCz5Yic0FGNCD5S5gyj1vAjI
   jxzDkBVnaZ0w3jt/1cGBjAUMPF1x0RWWrK/LlPMg8oZfVT9cT4oY73azy
   zxtltEM7VLEqjpYB9wPjcPrLvukT9xsT8/peFgPGxZyddcxlAQTNGQzjS
   +ZcygjZMJfeUeNb0rKXCkq+MOGU8CaHINbeqpYwZrkRpakGfah//2fzUj
   Q==;
X-CSE-ConnectionGUID: DE2iotwKQKKa3Kj8nLcbhw==
X-CSE-MsgGUID: SbmIKcIpRN+6rtilY1qR1g==
X-IronPort-AV: E=Sophos;i="6.12,151,1728921600"; 
   d="scan'208";a="32468746"
Received: from mail-eastus2azlp17011030.outbound.protection.outlook.com (HELO BN8PR05CU002.outbound.protection.outlook.com) ([40.93.12.30])
  by ob1.hgst.iphmx.com with ESMTP; 14 Nov 2024 00:46:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rgOfzbodkRrq5gmSzAK1Bnu7Vys3pCJplGK6xwUkPa9veD0i1indfhqmzFcj5UZehQ/3OTsMw+pV1mY9HpQ4nq5yIK2qVzKioR5pArAr27FjiH7/mO3YIg1KK84nGnpH9dvpZLfzTeDgSDLN6JBzgYcEP8HUtpFJZbFkslCPF8qQbTTkw28cjJ8EvluA0OhDHJvs7OUTI0M1zquoSauPIvfQha3CBh7bxuiBg7fDSLTAlN9pNEg8fn81S7RF9rvG7WZrya3mJuMN/7tcKWqKUkSKojoFvq9eUa4taocWN8t1sQp0yneXdrD3X9odGqp2Gefn4rKziKo8mlmz4wvWaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qemtCHi9poXNpTBzg0eHvfNt2n3ddmdzLrDDrV8QmOw=;
 b=EODXScpNXAzN3K3+VYYn0eQwAy8hBcmUzrFVrGsoQ7YxGexWpsVorFZGwaX3DUfErETW2EojMOfILXiLPdX6zEa+F/TVOxWoZW01HNnQPFiLOcOu5o1htAy3uo0NbpDh2KVz5AKewAxrgDEaW6FYemTzLazUkb7mJRxi2/T61g6S9pXAlX3m6akSBxT3UnZRfr/R9C7tLUdIj8kq9C/5gcwwkv3Zhu+/yrzl6jnt6fUI8HTU3iAODxInfjrY2GqpZ8eRoESHk12sqNRpMU9nMSpT5n5YF0oApXcyBNNV96y4LOtB5HL678eydfmMLvENC/xewNR211wJ94RM53KVJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qemtCHi9poXNpTBzg0eHvfNt2n3ddmdzLrDDrV8QmOw=;
 b=T+Z78Y2GWZXCROWsBnortsiW3k7PhpEQrDoXewtPAVARDdV5BWXCXxWoUihxGTbbSvCpIdWk1TWB41oqtSc0RsZVkZ6Ly76mmwGuwyZk1vsRCsLzILqUait1eC68h3ZkUUecgMr7Xm/Z5cUXgHBOMYbXvSagIXnG+hp4U9l1ImQ=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by IA3PR04MB9331.namprd04.prod.outlook.com (2603:10b6:208:508::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 16:46:31 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%5]) with mapi id 15.20.8158.013; Wed, 13 Nov 2024
 16:46:31 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Josef Bacik <josef@toxicpanda.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH] btrfs: fix improper generation check in snapshot delete
Thread-Topic: [PATCH] btrfs: fix improper generation check in snapshot delete
Thread-Index: AQHbNemWi8GBHdXSekKm8Xo/bNLdXrK1a1uA
Date: Wed, 13 Nov 2024 16:46:31 +0000
Message-ID: <f8b5263b-309b-4290-8b69-1f86b8fb1578@wdc.com>
References:
 <b1b8f27cad83060a4157af8f7514681a85956549.1731515508.git.josef@toxicpanda.com>
In-Reply-To:
 <b1b8f27cad83060a4157af8f7514681a85956549.1731515508.git.josef@toxicpanda.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|IA3PR04MB9331:EE_
x-ms-office365-filtering-correlation-id: 04fc00e9-a478-434c-18f2-08dd0402ba42
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ci9XbnhqOFRDN0VWeEYvUXRWTURBODdJVnZOcTBVZGNwUmlRMjRRUGJkV1A1?=
 =?utf-8?B?VE9QclhPQ0F5UTBJNURMa24wZmlFc1AyNVN2RlZqMFBMWXpSMkJrcXlZYXBv?=
 =?utf-8?B?S1hML0s5dHdsSFQ0elkxT0VDbUIrSkR2cHRFanZLMjRqWWhsQlN1MldDcDA4?=
 =?utf-8?B?TXUvaW1DSXZzME1VYmNlVm00M2FkR0xiR21uRFAyb1VsUlpQbjRXcjZhQW94?=
 =?utf-8?B?dG9QS29mTDEwQW1sQjFUQjArbXQ3dEl0Z28vQUNQWmN6d3JRMEZyOVdSRGp2?=
 =?utf-8?B?N3dyRW5ObXp2dWZBMVcrNjh4THpNWmY0ZnpFSy9OSlBpY2VnWWRIbnRZZVZo?=
 =?utf-8?B?QjFOaGhjRW1YZVZhTkQzK2FsM1BScXBudVV4ekxDbW1BWlo0Mlp6KzRIaEV3?=
 =?utf-8?B?M1hRZ1F3My94aWFiRkpBY0RwMFBIVlBFTkVJc2xQVXBINVJPakU5Ykp3TElh?=
 =?utf-8?B?bXJpWUEyN3lFR09MZTZOQjAvY1ZCaDNaa2xIT3o0NzVybFY2OFEvWkowN3h5?=
 =?utf-8?B?R1lUeG5Jd0dhMmlVR0hDQi9NMzFLeDZHdjJSTjg3eW1VU2xoYjNSVzdSN0Iv?=
 =?utf-8?B?MkQyTFh0VVI5ald5UDMvbS9palhmOWJ0eWhBaEUrNzAyTWNjcWg1aXhUQVlW?=
 =?utf-8?B?eUVsbFVWU21ITTFrTUlLcWxzSHNrVnFMOWM0ZDAySFFibXpiS0tPQmlpUUpS?=
 =?utf-8?B?NEM1M3FqN2RVSy9zTENSSnFMQUoxVUNicStKeFBab1M5SUxNSzlvVDh5bXlw?=
 =?utf-8?B?UmpQc3FNTGFNOWpxNGxSVzJGY3dOd1diUEg4Sk8yNWVGWm5FMkk4aGZmTUp4?=
 =?utf-8?B?d2lYYkp4S083ZStTQzBYYzFBSTk1b3ZIN1NzQitQSHJJaTA1VVdmYk5yMzVy?=
 =?utf-8?B?SDNQZzlDSWFBN3dUbkNtblpuK2JsNlpyS2p3Nk5MdW9RNjQ4QStGV1plS2RW?=
 =?utf-8?B?Qm5QZkJ3VGNsVmNTbzM2dklSRlB6QzMxY1lUMnRCdjgvNXRRL0szZ0pqK2Vx?=
 =?utf-8?B?cVhISFhVN3BZWTJBbDNjbU9kRDlzVXA4TUNaL0xvSWZKSEhNQU5BQWlJMjFH?=
 =?utf-8?B?SHoxMDY3ZlM0eFpxT0Q5Q3FtOWZJWGovY1VWYkIrRmh4a0ZFZkJPZWNReUQz?=
 =?utf-8?B?TmFLWmpLN2thUzd3ZUk4T3ZVRVhqMC85djhZWU9OTDRPNVVqUCs5YVgzbjBl?=
 =?utf-8?B?SWpaU0VyZzgwZXpQSE52NGRIbC92bHUwNWtLRHlnRGw2ZllrQ3A4UzF6d1Jm?=
 =?utf-8?B?a1FwNW83MFhzSlo4MjFpMUpWVVpteFJkQmdnOVA0NUtiOHcrc1ZhbWkyMXd4?=
 =?utf-8?B?UGZuVk03V1YzVy9nczYzWSsxdjZzc3pvWldzL0VqeHZsMU5XeGtIQXl6a1ll?=
 =?utf-8?B?eW5uQjJnTnROaGV5djdQU2tGcGVZY1NCUGhBWUtjdGszQWZ4ckw3UHlwOFpX?=
 =?utf-8?B?Q1k1a0VzOWl6Zmdmb3pvSENUY0ZNUnRQZVZpYzdSUDNYQ3pyZnNtcTg0eWZ1?=
 =?utf-8?B?RkRnc3E3TFplbnFwTTBmNmwvWmtGV3R0a2JZcURNNmRVajR5bVVUSHZUbldy?=
 =?utf-8?B?VGtkbWRYMDVlUjJhVG96R252djYxWDJHeU5jSTgyaC8xaGVVSlN0ZzR3aXg0?=
 =?utf-8?B?cVBMVStOU3dDUHlERmxRdHQxbWRRK2I5SGdnMVB6QUl6cnlEOFRTV3dKOFla?=
 =?utf-8?B?TEVLWmlUOWtUYmFhdEZFazdBTENhQkFlZlA5TUVHRFpNMWZSYlR6TmVDcTM3?=
 =?utf-8?B?eUI1VFJGL3hwT3N2cHd1TWNMWVZwQWgvZktLa3ZiTk83N3QvU3AzWkZ4YXM5?=
 =?utf-8?Q?KQkaYU7Wv4ApcCwFGgeF9ksp53IH3EtIIW+S0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K2FDMVZNYXg3VXdQK0xEVnhiVDIvdDh3S1gyUC96M291V3NmT0hIN005M21z?=
 =?utf-8?B?RWM4K1RUeGtzL2hLenZIZFFIL3IzcXZXV0QvN3ZJbTBGaGtWejhhekNZVUI3?=
 =?utf-8?B?akxSNUk3dVR0ZGNyR0lvRmxCL2UrUUluSWx4N3M3am40ZE9wemFhRW5saHN6?=
 =?utf-8?B?NjNyck85T2lIK2ZremIrbW9seWVtWXc0RzZlVjNnUFB3SFhncnJPNER0WkZH?=
 =?utf-8?B?YTV6eGowVGVMYTZTT280NHFJMDZTR3AxNGlHTS81Y0JmMG1FVVArYVJJSGYx?=
 =?utf-8?B?L01ISzZYRCtweVlMd2pwdksxbW5yK1V6WTVJZlVRV0g1a0U5L1hTN2dZdFM0?=
 =?utf-8?B?SmJDL09rcFNsT0IyRjFoZHo2Sjk4bFJMMng5OE5RcUpieUd3OEw4Mnd2SVA4?=
 =?utf-8?B?T1NuajVlVzdONkdOTzRzWHF6L2NDUW93bGZVOHNiTTRWWFArcVk1a05uZ0tp?=
 =?utf-8?B?R295VU1zZzJ5TVV2dzY1WW5YREJ3c3E5NUdCY2FiWG9lY29nTkRnOFA4L2F1?=
 =?utf-8?B?d0wxSWY0NUQrQ2tDNmErWUduRkJtK1dIL2trRnU4cUxWdjVwVWE5QlAraXUr?=
 =?utf-8?B?eHlmZFlCK2tEOUE0WDltMDhsRi9XTStYSzRDVm5sYlNUWnhtTVY0cFkzQm8v?=
 =?utf-8?B?cVhPMEtsNlJVNENUTTh2TzlTZk5QSEkwdWNBeUFiUXliMk9Bc0Q5Nk1RcG5u?=
 =?utf-8?B?L0FDRjZaUnNDNWozOVU2b2dVK2Zvd1lTcFhkcjlXcExtN3Q1ZElBRzhiOWIy?=
 =?utf-8?B?T1FuWGhtcUd6TW9QM3JoK3ZNZE1qdzNpWmZjZlB2bzR3eHBLMkxoVVBJQVp4?=
 =?utf-8?B?Q3NwQmk1VlIvMEZ4OEhsYWt1WGRLZ2xWT2hodW1KTGlVbW5FU0psN0NkdmZC?=
 =?utf-8?B?UGR0R0Y0MU5lU1R1cGdoNFhxOFBtajRqZi9wV0NBS1VMamJXVC9CWUhYVXJV?=
 =?utf-8?B?YndjVEpQNXc4RUVjNnpveEpCVnpWWmc2RU9rWXQ5dTVtOFc0ZUdGNFFsR1JR?=
 =?utf-8?B?V0p5Z0tYeTB2NmlnWHEyOWw5YUxJbUFBZ29nTHE3WUl0ZHlJN3A2aWhicWMv?=
 =?utf-8?B?MXFsdWlQeGtUbmR4a2padHZjS2xaS2RwTTdrYnFvU2xvSW1KYi9JT21qZUF6?=
 =?utf-8?B?KzVxTTA1WTFnYXdDNFVmL0NCZno4Rnh3eUNNM3FscjJuZlBNQ0w5aFVPMDRu?=
 =?utf-8?B?cWFZeno3QUpvTVAzTnRNTEJYWFBleHlkQi9wUVcvc2UxUm0ydFhVRDdnTFpl?=
 =?utf-8?B?cHNQa2NZaUZEUFVQcVZQQ2YvaXBmRGxuekVWei9hdWxYQ0ZMZTRoR211RnpJ?=
 =?utf-8?B?N1VYRDNjUUNzK3RSbWJnZWZwT0RzVlQyNkE1USt0SGtrRjhJTUNQamJXZndi?=
 =?utf-8?B?dUlld09xN3lneTB3ckNNd2w2OUVEaTUvQ0VxaVVwV3FVRU1uUkJXbUIrR1la?=
 =?utf-8?B?RTRFc1JpQnBJVkRyQisvcENIY2VodC9wRW04OXZqTWd4MHJjaCtOeE1YWnVZ?=
 =?utf-8?B?enpYWTNBSGZEOWZOcGduWUlDeEVEYmtDMWhyTjg3eDdZVy9RYTZKWnd4a1N3?=
 =?utf-8?B?Y05xNzhxOVZhS21rOUVYZzZ3dy95ZmF6YlcvaGhsTHFTcUUxM3ZEc2J0d2Za?=
 =?utf-8?B?RXFvRkZVeVRvRHdKUlZKeXJtTHk5VVE4bFQyMGcyM1dSdGJLZ0p0M3FpamNW?=
 =?utf-8?B?R2VvM21Sck5vanBqczNLRkZtektoN2tKdUxtWkYxMnd2Si90TWRoOEQ5ZW5Y?=
 =?utf-8?B?VlV6VG1mNlRFTVdaK212SnNhcGt6Rmo4OFN2VEVRWEVmdVU2Y3U4emVXdzV6?=
 =?utf-8?B?eHF1UTc5Y0Q0bExkMkNLa2F0K3FNbld2OFJJVUtFbGordTBDaWQzTklWU1di?=
 =?utf-8?B?NG5DZWdjZE5QcVJQUmVWemYvVTF4ckVUVVZsemNQSk04NlpIRC8rbUNvc2tu?=
 =?utf-8?B?RzFBSnFxRlI5MVhncExIQm15QkI1QlFCVGRhbTFIMFpxclJ2NlE1WnNzbWxw?=
 =?utf-8?B?RFprUk04dE5tQjdlZjNsOTNoSnNKK2hJRm81RFNmRm51Nncza2p6U1ZiWVdM?=
 =?utf-8?B?T2pwek9Rc2lMUWdCRThxazJwK08ySU9CT1A3cDk3VUNTcGVlYTlISjZGM0Qr?=
 =?utf-8?B?M1pEVjdSTDlNSDRQYlkwOUdIajc5UzByOGhqUmEyNTNYTnh0Wngwb1NDejJ4?=
 =?utf-8?B?cUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A601EA1838C6F441ABD1801864335BC1@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4WAMtXY2vZPY1iTIXV1QRPdoehhkdPmqdHzqIfNu+bsViUfjre4b8XKoS3S2pg7aOZiGm+UeNc/16OTs7JSMQrnNeI/qEuKuq5PkRYkyczEx5Bss/0Wdmlke2uzYtXLgP4YH/2pM3S23cbpyjQtVyYjfocodGYfSyNK+H1YT1mdEGXyitpUiBif1PrLfKVGtITp3IJ3YoCwvYQyo7WrlXrBG0678mvWDbpdpkCBvfcVF4e3khVB9HP4rAWXH/gBxdlhuiZsJB/b+WlkJr7d1GUwngylFixI3VoP4lYRgApocPnaOq7IHO6qXb86dgjLbrERlly2NAKC268wk81xSFMAC86DMCjm5rKlqgvwhVTLGBR25INFHV6g81dPeel+Ko3UPSj0YQQqVCP0G3m6yqIgT/6Z7D+hwfHXFRRYgYRogKz3KyhFx8e8cEX9gfStZ4X82fG220LQdhu2oWEk3jiqaB9xVw4dxwZXT9cGsKBSFZnQ4e06PmIZtn5XLaY0OJDAkDedUOz3Jt5T57nrFj3b6MafYarTGcvinx+D3ULAQv3DX0SIswpLEW+QmLkvsoSiXUzH2ZLKPFrSS8EMVFjx+rGwPY3Mqrz2D/7ZqN7OscEB8aOWXKl9+IedKuOgV
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04fc00e9-a478-434c-18f2-08dd0402ba42
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2024 16:46:31.7392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0JhxGqDpSeWc0iUnXcQfeJo+WXNahW69pHBaL0db1/C6TmxxxmMhVXOsC84Rxuh1VKPkJnnVo9VQ9r4CgjM59TAusch+l9nOwPlEU83N7NA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR04MB9331

T24gMTMuMTEuMjQgMTc6MzIsIEpvc2VmIEJhY2lrIHdyb3RlOg0KPiArICogQHJvb3QgLSB0aGUg
cm9vdCB3ZSdyZSBjaGNraW5nDQoNCkNoZWNraW5nDQoNCk90aGVyd2lzZSwNClJldmlld2VkLWJ5
OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRodW1zaGlybkB3ZGMuY29tPg0K

