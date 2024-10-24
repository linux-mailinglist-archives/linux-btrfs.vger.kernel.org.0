Return-Path: <linux-btrfs+bounces-9123-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D119ADE2E
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 09:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF42E283A3A
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 07:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13691AD3E1;
	Thu, 24 Oct 2024 07:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kUBN4f4z";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="afXRU5Lm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA811AAE02
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Oct 2024 07:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729756221; cv=fail; b=M0Ia/VR7pOvruHWECL8hiVo8mtjf3ldzmSzZLNodyK0pmha2SZtyqcx2qTYVC5LKGqP6pFEUfELo1xdI434GUlzIMRFpVPgV4FwBl+R32A6w7oG1vXhoPHKIKe5i9d5meFuRcIfaYS5hE4qcCfH2gF70IQ1z1l3OZ+ttOBPFXgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729756221; c=relaxed/simple;
	bh=+aXAimby/MgWEXp9lWsrVfiLWh7+JdrmZoza5gG7tFQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b7YhgRzATw3RiCU+7abB75jkilOst3hQs8otP1+qa931xBDQeyGeI5SF4Tg2k61ZAHusKtmilpMe0aVARVDQKI5PwcrujfuKuWl9yKl4Z+Bezpnwx5M7cVQIJcSs2yCGJs5NufvJBZbU1/JHYOzxS1v2PMnkJNm1EQKtqGVe2g4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=kUBN4f4z; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=afXRU5Lm; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1729756216; x=1761292216;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+aXAimby/MgWEXp9lWsrVfiLWh7+JdrmZoza5gG7tFQ=;
  b=kUBN4f4zddMS/lUNbZ1EDzJVq2f1z8l1D8vsyfs+cUFesAWEnJeDgkCO
   3bdbiJtp8M7/F7Ba6VIcdhpIPUcJYTwbT/G+G4LvbMhNXc2UoLDNpyg6x
   xjfnlr7EgsU59A40ouVb5d6Wch5zUUUV+GezBvszrFBixeCRPZIHb0JP2
   iiYJzspdNv14FV7uy95v+RBGU+446J9l+S/nX3QdOTZhGZbe+yzVjYP0e
   1w5Q8YLSmyQ/ah6jSihfl/miJDY1BszgjQX2V6JX+RGodqbrJeifIU4HP
   b9kdUga5pfa9GPISN7J5L5aCsKUWbCo2rJdU/9NYXNb7JyyMijrb8WaSP
   A==;
X-CSE-ConnectionGUID: z2KMcR/fS7K8GjLRc3ysRg==
X-CSE-MsgGUID: QTSLMFxnTcmTcr8fGCk3CQ==
X-IronPort-AV: E=Sophos;i="6.11,228,1725292800"; 
   d="scan'208";a="29753591"
Received: from mail-westcentralusazlp17011026.outbound.protection.outlook.com (HELO CY4PR02CU008.outbound.protection.outlook.com) ([40.93.6.26])
  by ob1.hgst.iphmx.com with ESMTP; 24 Oct 2024 15:50:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RxINATrWNfb5T+rg/AuhpeB0LGnWZOEjyaZXOOnHt1hTjbpt7BDOc/Qi3lFJ1F4YYecH4WtWra4wCz0mABWgz/Mqjg2Yqfj/NFkw3jJdXuTpZDNopMnldxUI6HTVeSJM0+pWkER2sU9NYDzaT0RPgzuiNQRmygU8mwJdOf4HKMjaFvClu+NGuQPZNcywJQPhyVZKJ6+/hVpg/dqFBzsy4nyOc85NaFCKRPe6FM0qCT6tWcYVU06ZgfGrPag5NJiVlbB5DJsvpe/oBXtJdgogoGnNXM4dTcQMlh/lPuNkFH+AGnMNSDo93DeqrbxmkZ/yLMxL4+Yvd+GayRap4UVBHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+aXAimby/MgWEXp9lWsrVfiLWh7+JdrmZoza5gG7tFQ=;
 b=EgFa2JMGO81P7o7jeWR2y4Ka2xtzaQGyClsVyusuW02LqnO9C0DUlgizVldmQcGq23HKXNO8EUHVI6WmoqnYPK98Qd0rEPn2LnqF7unm8nswqHxm1g1gjOOYuplJ4I+ZOg/PPz6BUwzGyOD9qPHnzX2Oer0yaZnKzOokG+JrnjQa9itbhSRnL/2MAte6TRy5XtQoOJou9j8VVmQz69jIR0YNidtMs4PYjtZ1fVkwoOndqmrenxI30gF2zhSvZF3zCnU6E/gbFDD6To1LH1VO4u8//LvabCHtMPvuZLXlZmsiSDQlrBfwblbmL/zzwmS2KKvjYdEzbK8QAZQsM2oBpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+aXAimby/MgWEXp9lWsrVfiLWh7+JdrmZoza5gG7tFQ=;
 b=afXRU5Lmd2/eanLqNk5tO5uaNCENV69yfEYjITM0C5BB6nPlDZFclgJ8LF8UrrQK2P43yw9ZMiOI5vNTwGM7OWU+3qPl9MCEEITSA+su+W9endtr5P/FdtG4D4nxOrAWmFf+upFoPKIYgCJreV5GsWrYc4n5yY+gQ21jP9XGx34=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CO6PR04MB7570.namprd04.prod.outlook.com (2603:10b6:303:a4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Thu, 24 Oct
 2024 07:50:07 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.8093.014; Thu, 24 Oct 2024
 07:50:07 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "dsterba@suse.cz" <dsterba@suse.cz>, Filipe Manana <fdmanana@kernel.org>
CC: Johannes Thumshirn <jth@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, Josef Bacik <josef@toxicpanda.com>, David
 Sterba <dsterba@suse.com>, Filipe Manana <fdmanana@suse.com>, Naohiro Aota
	<Naohiro.Aota@wdc.com>
Subject: Re: [PATCH v5 2/2] btrfs: implement self-tests for partial RAID
 srtipe-tree delete
Thread-Topic: [PATCH v5 2/2] btrfs: implement self-tests for partial RAID
 srtipe-tree delete
Thread-Index: AQHbJU8Ogj87CgT5lU27GcRnIfLBybKUnCyAgAAS7ACAANj4AA==
Date: Thu, 24 Oct 2024 07:50:07 +0000
Message-ID: <54e5dbdb-39cc-4525-8839-f3f020e500f7@wdc.com>
References: <20241023132518.19830-1-jth@kernel.org>
 <20241023132518.19830-3-jth@kernel.org>
 <CAL3q7H7houfrJjOOnmpA6T4xQDa-y1AqsA1AKBQZuOV4ygUVMA@mail.gmail.com>
 <20241023185332.GE31418@suse.cz>
In-Reply-To: <20241023185332.GE31418@suse.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CO6PR04MB7570:EE_
x-ms-office365-filtering-correlation-id: be8ab261-1d48-462f-32f3-08dcf4007a69
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ODRzR29IV1MyT3ZZVTFBeXlWS0NvM1A1citST1FGb1kvcVZYcUVEWXZrMDVx?=
 =?utf-8?B?bW0rUXZRdm0rRFI3cTJMc0wvUXlpN2Y2YzVNNVFnWWpSeW9vcjRDRXU1eWxK?=
 =?utf-8?B?UDQvMnFQeTQ0dVFNVit4UEczdUowblVmTzYrMUJLS3R2OWlUNTFLenRDcWZH?=
 =?utf-8?B?aHhCNEk0SW5nTmJlVk9DV0dSczZNa1h2UGVjOG12aTc5TTZraXIxTVdvN2hV?=
 =?utf-8?B?cHdVNlR3T2MxbG93ckI5MWIxVHdCbDVyVENjZllpcmdobWZuRzFtL2pwcE56?=
 =?utf-8?B?bTBlUkJDWlJHeGZ2aXdHWUgvU0NvMXA5RGtRWE1vTFQwUDkrQUZsRHpUcW80?=
 =?utf-8?B?WEhmdFQycGZ4SWJMdGxQd2ZURnFzaTY2Y3dndjQya0xic2JSSXNtOTNBQ0po?=
 =?utf-8?B?bnNmNnpyQ085c2NFbkxkb2EzYmhwTDRQb1RBaVJiQThxcWlOVi9TR0pyZzJL?=
 =?utf-8?B?cFQwNnMramZGbXYrZEdrVmdTU3o2TlFSRVB1cisrZnpBbVEzWXhqbDQ5RnRq?=
 =?utf-8?B?SzY2RWVqRjg0UXQzOU1yYmlTNjdXSXUyc0Q5Z0tNQTZmRjFCeitaNzlIeXdL?=
 =?utf-8?B?RENTdU5GcFVROUhlNXdxQXAxUDJEQXpFYkhmQ2R1aTVJQnpwVnJHSUdtcXBV?=
 =?utf-8?B?MmZVYVhNNndmN0FxOG05b3dqNHhiQ2E3by8rMnJ3c0ttT0lRdU11UWNtcTJO?=
 =?utf-8?B?ejN2cFRTQThCaHJZWXhXcUk4WlBZc1Y4Nzd4bnhoOUQxVEhRVmN6d3o2VDA5?=
 =?utf-8?B?VFBDalVlZURmcUlvUWVBTnRKV0VObzJCRmcxVldrSm9tQVZBNUFLOWJVVFdH?=
 =?utf-8?B?MlpvRFplQnhmMVlIOUllVFhpVWNBRGdjQUVqbTJ5bXp0ak81aGtMaVVUVlFU?=
 =?utf-8?B?ZUVzRk9uLzI2SVFnNWwvMlBsRDdvZlcwalBiNG00bUQzOC8vWW5aa1Rnb1Np?=
 =?utf-8?B?VTdmTmozLzQ0K1JEb3dKUEdTZWZ1RkY4MnJacEQrK3VLSW5Nb3QzZTRSK1pa?=
 =?utf-8?B?TDF1cE9NNkpjbGZZVTU2VFZTQ2pqeDVKNjNjY3FuMzJpeXkxV0xSUTlGTmxM?=
 =?utf-8?B?cktjSGQvVFN2dlh0V0ZOak16TnVldnpTV2FNcVhLUWROaXBUR1h5WEdXK2Q2?=
 =?utf-8?B?ZTZKR3p0emxwb0hQUFBqTmhnRkZjcDhXNmJoa1kyTGpKVFVSUlpkQ3pzMHNF?=
 =?utf-8?B?dmZ5dTgwSEYzcTFYME9LMmg2Ulpsa0xZR0xpMnJLeXdnNmM4UnUwa3BnYk5Q?=
 =?utf-8?B?U3VoTjhzbGpISWRQckdNTldVRXBIcEkzZEdmQzBHRE04V0tNQjFhOERkME5C?=
 =?utf-8?B?eFVSb1VVdG1oODgreGdrNVh4SUZsekhlc1phazNQZkpVdXAvQ01WaUdtaG51?=
 =?utf-8?B?MUFneXdoaFJOUEsrQXdtQWVuTTdHcGZvWXhCUEpXNEc5TE1NNG9DWjZwM05j?=
 =?utf-8?B?YlhKSVdrVm1NdVZGd1VKZXQxRWp5OXVydk5WL01SZWhsaDJ6Z3hoZE9qeHFI?=
 =?utf-8?B?aEpZNUdld1JpMWJidThTUEpRRzB2Y0NCQ3cvd0JnWXhPdDNZZUFHRUFDd2Rp?=
 =?utf-8?B?aUk0dXFLb3dpUC9qelRxdENINHE1Z2VLWDlFNGxKTC9yTGxMbWdYN3BwQ01z?=
 =?utf-8?B?SXZwOGhZaEY2SzlCKzVESjRpQVNZbWVWaXdiUHhzZTRiN2N4NC9CYzRkZCty?=
 =?utf-8?B?M1Z1UGZuTkRkTWVYZ3JaZ2RQeGJMbisxbWFFT0w2dFQxeDhlU0NHRDhHc3pF?=
 =?utf-8?B?WnNibFMwc2NFK0x3Tml4amd0dzhBYnVIdEdxcU1iWURnVnhQL3BRU1lOejJK?=
 =?utf-8?Q?cCh/IeJ4lQGnkUezScSlynW1oFvW5rb4ekExM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q1JkcDdHRlNwek1jRVdmSTlqZGEyYWZnZkVxOVFqRlRUVjRXWHh3bGNtMngw?=
 =?utf-8?B?Z0xGZDFQNUJmUWFMcTUzZTBXdk5GSEptUFVOSmtNTFcyZ0p5QXpKR3lOZklu?=
 =?utf-8?B?M1puK21CcTZPa0ZxZUlyTGpHc1RrY1BVZVdER01GdUNEbnpWeU5xQ1VnczFl?=
 =?utf-8?B?aWJGK1NXb3I5OWN2U2haa3UxMHdxbG52Rms2ZFZKUlJCR051MjUwNlhkaEVT?=
 =?utf-8?B?Y2Jkam5zdWduWTN6cDQveEIrQy9CREc2OGN1dXdjV0dOeUZMbmdSc1F5Y2ls?=
 =?utf-8?B?a3VIMnpUMUdHbGlxZC9lZFlNbG1LYk5MTHFIWEh5WmN3WGk4Z09tWUMxNjhi?=
 =?utf-8?B?VHlmQWJHV0VVcUczeUVKM3RJQmU2MmtTVXUvNUFYdW9Kc3MrbmoxSzAzTThl?=
 =?utf-8?B?aFgzeUpOYVMzeExNS2NQbGhvVW45ZEZTM004NkFxbVRucTc1YkdteXoyQzNO?=
 =?utf-8?B?V0ZzQ1pFc2RZY3lvdTB6SWE1K3NRb2tvN3JzNzF6ZXVyK0N4YzNrNitvWjN4?=
 =?utf-8?B?cURwNHNFOExLR0tmMXcvcUdMOURYenIyZWxkN3dGa05nM1VlSXBERHc3UTRl?=
 =?utf-8?B?QWpjQ1JlaE5vUlVEQmZERzZmQmhaQVlxQW1kOWFuSkxUayt6RDY0UTFWa05o?=
 =?utf-8?B?MnBSK29wOEZ6amhvaDY2cWRONHVYT2NkendMMGxTNUpwTTJNRGIrdFZ0RmVU?=
 =?utf-8?B?UEwzQ2wzVktDcXpzUGNwREU2TXBBd3FaSjNDbEpXRVZPVUJ3OHAvTDNMVE1S?=
 =?utf-8?B?MHJUbkllckMrSVpVZVE2aXdhaDJKeVdrdDVaTjBwSVB1dnpYYjFoWVlvQ3F5?=
 =?utf-8?B?c1NYWm9ObmN1cFFWYlZ1OVIyQ2VobkFIUDhBREZxNHBzcFZzMlBqY0V4SUMz?=
 =?utf-8?B?SFNRREVKR0IxT2NrQytqRE5BeDVDajVyd3g0eTNpWHFsV256ZE1sMjZDSHZM?=
 =?utf-8?B?VHdiY3F4bTJiRk05Ti95bmNnanczYU4rZzhBdE1hQmZQOXoxb1YrZnhhQzI0?=
 =?utf-8?B?bHRDWkpVWFRrVFBITXR6M3k0MzBGQmlSUUFDS0RsR3I5UHZzOVN4WDUvazJz?=
 =?utf-8?B?clBVdDF5Qk1qekpCMHhCZ2djbVNhSGFOMWRIdUozRk03WGhyMlFCN0Z3Wlkz?=
 =?utf-8?B?NGo5aFg3OTJ3SVBkWVJkaFhyamFQZGR4a1A0OUkwUzNiZmVyUzFMeldSaDVC?=
 =?utf-8?B?NVJjNVN3YmZ2UFJVZTE3N3NuUmI5djlSNkdCUm9mSnAwZUxkVklzczFVejVI?=
 =?utf-8?B?REoxbWRxWk9FV29CNEx6bDkrUUttQlUyUFNVbWRxSitUTnZ0TVA0NFVjK29v?=
 =?utf-8?B?R3M0QWNFZ0lLZWcwazFLZjZVSUhlU2p0Ri81ZWJ2a0h3NzdmamJCZTNYMC8x?=
 =?utf-8?B?dlE1ZThzWnFJc1E2WmF3QlB4b1RFOG1sVFhpREs1Yy9peVpCSTJtZGJhZW9k?=
 =?utf-8?B?UHY4RjVWQTUyejlITzlGZ1NreEl1QWJGODRxSFY3RkFHeDNQemRGd1RQb20y?=
 =?utf-8?B?c1ltcHFORHBpK0VyV3YzRDY3ZmorcGpvMmhkcExvZ2JZYkFkSjh5Um1GNmlS?=
 =?utf-8?B?VFdzVDQ3UUhEWUVxTGVGWHQ4Z1NHL2E4S29Lc25sZmE3ZjVTQUpoc3VmSlVM?=
 =?utf-8?B?bWswYXRPNWgxRzhNekN2MVFPNWFmK0RjeS9TajEyRDF5M3UwYXkwMTB6Um9Z?=
 =?utf-8?B?QTMxWjhQc05jS2NwZ2ljMHpsazBILzBtQkRMQWNUbWI5YXhpaHRxaUszVHkx?=
 =?utf-8?B?ckd3MVNBMldYOGFrbWRQOGU2bVlGTjJ3bzJVL09LbDVuZkdwcmxuM0ZZSmFD?=
 =?utf-8?B?Y2VYR0E3SmpJZEx2SjBTL1Q0ODdxcnk4TTBnZG5YeTBMeUcyT25KUlZBYlg1?=
 =?utf-8?B?QXRKNXJDTCswS2dTQ1hhL2UxMlBZRkFlVlRvUUJ4TWhheU5vNXM3QWFKbzVB?=
 =?utf-8?B?VzZ2S25qVEZZVSthVUNqLzdURk5HVTBkZTdjWktLbGlZTzBFRzBFeVlwM01C?=
 =?utf-8?B?SHMwN05QL1QzMlVERlFELys4NjRjWjZMWUw5NUNPRUNLSVFZRWFuRXpuUitu?=
 =?utf-8?B?YXlVMllRcUVzZHhxYVZhM3l2VkQwN0x2WUZMclhkanVFM2ovMHIzU09uOStu?=
 =?utf-8?B?MmxjZ3luS3I5VnlaYnI2RXBUSG5BdkUwMkMwU2ZXR0FNZm5CQnFzTnk5MHVu?=
 =?utf-8?B?SVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <358839A2F72CB04C99F729728E8116E1@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6bcsTmkpSw6FRAOwk1JLsCBNCgvqV9RkEsYm3NyfiTDCVdZL0OlSwV+7pycFzbBACPqW7fxMnIvFeKW2Jl5KTE9tjKXh/VTGwrWPpY7SbX3ha4TQQHGAzYoMsI9X0BWAde1u24xy3duqD8fRsWHNwb+kNdEwEkYWhcqf8oMeYqkWrbsKAlkM/9MKZvTHpcHp39vBhziDnYY6QkOAS6M4AeRfmaIgoakBhXVlaPMZVdEX7gekiqf3hkAwIvZjsrWS8TjzYTLp4upIqb6YY95H/MmfKr5PIfHDDN1IWjYZoBO1v0sLE4lgcQR89l0dZJ9ajCtFHKx5cbcQDn6OWNS8BXWr0ymebxMD9om9Iz2g3mqHVOfL0O4SDaNeYy9R3DqQhPYleoALqoXURcKG3sFGAgHO2m78Q3g6eyRc7Zv1rAtxU3jCAcbzSST47NI1geqFVKMzPxQCI/pGMxcyMckx8C3kA27kOn/JSLWxEZ2jpuLV3B5RwIVLMglVWCDSwmwUakLNT2N4CVB8dpW2vADVZ2CI7FzpIN/2e7ELng7GJwC9tHEKRsi2gprtQg3A6su7y68L3le4a6hKs0QPD7PSFVx/KhMoNLdJQ75hDQo3mP1+nZzU/rzdyNdvU6kJPhX1
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be8ab261-1d48-462f-32f3-08dcf4007a69
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2024 07:50:07.0615
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wsey3zYayEzB8kQhwKiGlKJ9BtB5M/2DoO3tjyrg46V0IeJ+3IuhiBL7yQsLdlenkJg5JTzdH2PFNgKVsmXRsKNIL8K0ucdTiw7TXzAtyNo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7570

T24gMjMuMTAuMjQgMjA6NTMsIERhdmlkIFN0ZXJiYSB3cm90ZToNCj4gT24gV2VkLCBPY3QgMjMs
IDIwMjQgYXQgMDY6NDU6NDlQTSArMDEwMCwgRmlsaXBlIE1hbmFuYSB3cm90ZToNCj4+IE9uIFdl
ZCwgT2N0IDIzLCAyMDI0IGF0IDI6MjXigK9QTSBKb2hhbm5lcyBUaHVtc2hpcm4gPGp0aEBrZXJu
ZWwub3JnPiB3cm90ZToNCj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgJmlvX3N0cmlwZSk7DQo+Pj4gKyAgICAgICBpZiAoIXJldCkgew0KPj4+ICsgICAgICAg
ICAgICAgICByZXQgPSAtRUlOVkFMOw0KPj4+ICsgICAgICAgICAgICAgICB0ZXN0X2VycigibG9v
a3VwIG9mIFJBSUQgZXh0ZW50IFslbGx1LCAlbGx1XSBzdWNjZWVkZWQsIHNob3VsZCBmYWlsIiwN
Cj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgbG9naWNhbCwgbG9naWNhbCArIFNaXzMySyk7
DQo+Pj4gKyAgICAgICAgICAgICAgIGdvdG8gb3V0Ow0KPj4+ICsgICAgICAgfQ0KPj4+ICsNCj4+
PiArICAgICAgIHJldCA9IGJ0cmZzX2RlbGV0ZV9yYWlkX2V4dGVudCh0cmFucywgbG9naWNhbCAr
IFNaXzMySywgU1pfMzJLKTsNCj4+PiArICAgICAgIGJ0cmZzX3B1dF9iaW9jKGJpb2MpOw0KPj4+
ICsgb3V0Og0KPj4NCj4+IFRoZSBidHJmc19wdXRfYmlvYyhiaW9jKSBjYWxsIG5lZWRzIHRvIGJl
IHB1dCB1bmRlciB0aGUgJ291dCcgbGFiZWwsDQo+PiBvdGhlcndpc2Ugd2Ugd2lsbCBsZWFrIGl0
IGluIGNhc2UgYW4gZXJyb3IgaGFwcGVucy4NCj4+IEl0IGlzIGNvcnJlY3QgaW4gdGhlIG5leHQg
dGVzdCBmdW5jdGlvbiwgYnV0IG5vdCBpbiB0aGlzIG9uZS4NCj4gDQo+IEZpeGVkIGluIGZvci1u
ZXh0LCB0aGFua3MuDQo+IA0KDQpBaCBzaG9vdCwgdGhhbmtzIERhdmlkLg0K

