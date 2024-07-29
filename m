Return-Path: <linux-btrfs+bounces-6835-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C0893F847
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2024 16:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6415E1C21DBB
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2024 14:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF05155CBA;
	Mon, 29 Jul 2024 14:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CZO1F+hM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mxocwJV5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BA2145B38;
	Mon, 29 Jul 2024 14:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722263421; cv=fail; b=sunLiw0LJVEgMT62cwJdJV1kpES5xa3X8AenrrsnM0VTZCmouYykwfj3RGp6qz9tb/sL2rPc3cKRamyXgy+x97o4br+KSnvucK164FLfEmfUziqImd6w9y9hOQrZtZUugeo+liG9TaMDPsIf/1pekc/Okb4SpNK5oJYkuTYODdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722263421; c=relaxed/simple;
	bh=tRqba8d9QIHguRKL0BP0QO0qCa67SiQWTTO4uEyMoVQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LrVKZCxevKasW/oGCMU+fxCsPw9lU6sWiEXiYl0X9OgQVaOuKsPDr4Z9akIeEEJje6zFeniTqKk00IPURF08mXxzwWoyQASkWG1pQOKo/MtlVXap9fCGgsIr0AXIyYyHP1QpM8kXnM7MfXOTs/Is1X6iEC2gFyKwUhYo6XNyqI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CZO1F+hM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mxocwJV5; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46T8MaiU006298;
	Mon, 29 Jul 2024 14:30:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=tRqba8d9QIHguRKL0BP0QO0qCa67SiQWTTO4uEyMo
	VQ=; b=CZO1F+hMfz1DLs/AtWPD1hkvQnnXu10TB20RDrXgSucTlfkr2bjBUauFd
	VlfnyqTUoflufzmGqYXBgDNqtzGdn/z2sUrEdIgk+/BRPQEurYEKHHhk6f3JQM3/
	sDsAAsxydMhFikBz7AvOA0Fi9VrK+6EfljddJxV/zl/tqKC9r0bsh9Cn6EWOlsBe
	fDAipNbY1UaOUOwsRBWQ9V2d0oZoG8So2aO21xuNtG9pshf5zy7TLy9TsgQGQ3xt
	FYkZS+AyDMa6EF9ZbQzWGVyGmfv2iZpICxcFJ5YY5y5ETKv+uYaYYPa6jih0l7sP
	pkRZc1K+iKrqgw59CKSV0qaFAlXzQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40msesjp6r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jul 2024 14:30:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46TDaVCi005879;
	Mon, 29 Jul 2024 14:29:54 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2173.outbound.protection.outlook.com [104.47.73.173])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40p4bxt415-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jul 2024 14:29:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HdHBmMhiHnDHYuzSA9VB2SjUQLzD9+VWnlI7QPQzXse4Z/cqwqzJL9f96QNA4cWe/WLiB/4AH//64T7UPwp6vtTKIfVHHsWJwHLmj0QvBn/7gk9Z1W9p2lzyemy4lvbyYDXwefmuxaWjoHfbDTzdIkV2mUCUK57EFdaN79t7QfQysbyOpvFIQw1lsUYMfxlE0oIFGZptmatz+sNBm8NtAFjmuYZFZ3Ws2BxCnOxCJH93MfbmB/KPlud6iynXZkjwLKHOL6P/BwL2/bbVbSvxuKKtr48AkgSSzVQnxMPL/d+CSVq9uRCKHVbgdh/3lSu0s3Lk0YA+aPYT04lbiHd48Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tRqba8d9QIHguRKL0BP0QO0qCa67SiQWTTO4uEyMoVQ=;
 b=EUSPRzksbY5gUQnRmEjl3Cofvd9QR5klrmprAYyryvmxFr6Joi4BYTn+D2XxXgiXeVe1MSBwfX8R4Yh+BC9GLFGRFLe01sahKsm/V1b9PemdaZE5ZMNvhd1GARASJWS0nPsc1rIJ7CIdbVFymC6ZO85YprCa2y6Yd2bvCXClR2SKFKQHhGYgEcDWmLjrieoDNfRhLAjHVmAs6jjwy+wgKQ8NtQpK/5ADidVPSz3Au/sdp0BtSvUSgYBH+mLZUJmWb2aceJM0KxIHnOErtOA9yabp+caGabaHIjmOF70FPUHinP5VqCS2CBlwtbjtoSuw20JgGE9F7x4SUhh9VX2zPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tRqba8d9QIHguRKL0BP0QO0qCa67SiQWTTO4uEyMoVQ=;
 b=mxocwJV59WopyJbs9fF9MEM4uLyihFXvdtuIOktApCYkvK+1Geyue4grsw4TkET/+f2Ws8qfwuxbA4Iwx658XgBmSdAZ8KEE//q1Y8NBkS286cwrL6Ci+OS5BF2lgJLzLDb+Sbl7OglSNgHy8whcnmSXm1WLtHbFBwRCc0fQwsc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY8PR10MB7337.namprd10.prod.outlook.com (2603:10b6:930:7b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 14:29:50 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 14:29:50 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: yangerkun <yangerkun@huawei.com>
CC: Filipe Manana <fdmanana@kernel.org>,
        Christoph Hellwig
	<hch@infradead.org>,
        "zlang@kernel.org" <zlang@kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "linux-mm@kvack.org"
	<linux-mm@kvack.org>,
        "hughd@google.com" <hughd@google.com>,
        Andrew Morton
	<akpm@linux-foundation.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] generic/736: don't run it on tmpfs
Thread-Topic: [PATCH] generic/736: don't run it on tmpfs
Thread-Index: AQHa2oA7EytQH4xmnE+FwylJW5vDVLH/3wCAgAYHbYCAB+IPAIAACgEA
Date: Mon, 29 Jul 2024 14:29:50 +0000
Message-ID: <418B7A4D-30D7-44B4-B3F3-5BE97C04BACE@oracle.com>
References: <20240720083538.2999155-1-yangerkun@huawei.com>
 <CAL3q7H5AivAMSWk3FmmsrSqbeLfqMw_hr05b_Rdzk7hnnrsWiA@mail.gmail.com>
 <4188b7b5-3576-9e5f-6297-794558d7a01e@huawei.com>
 <9514fd55-4f83-8e43-bdf7-925396ab5e48@huawei.com>
In-Reply-To: <9514fd55-4f83-8e43-bdf7-925396ab5e48@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CY8PR10MB7337:EE_
x-ms-office365-filtering-correlation-id: 8ce13158-f3f4-4e70-2bfa-08dcafdae7ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dWpNVW1nQ3ExdjU3TkkrNk1OMnFkYklnTURpb1J0TXR2VkVJcElBMGpIcGFF?=
 =?utf-8?B?amdBM0tiMEYybXlxa0w1VHhxaUROYXVwT1hQUnFNTFBRYVI0OEU3RjBwb1dm?=
 =?utf-8?B?YkppK0NZRG5GWVBHTyt6bGtDYzhTb0NiNEl5cmRaUm5DRTRLcWRxWWgrUGNE?=
 =?utf-8?B?UWpFT0JDTzRyWENKbklhTGo1TWp1UzR3SExMV1hSL1ZPb2J6b2JjRlRER0d0?=
 =?utf-8?B?YW9xamxFdlhVK3Y1MjIyOHhEdkk0RjMwY2E2RzFDOXYweWYxN3pyNUQ0algx?=
 =?utf-8?B?aEtBMVJRMVBOUEsrK1U5YVlvK3IvRWMwNlZYRnVIRWhuMVM0UVVCTzZVVmNY?=
 =?utf-8?B?UFpXN1pubVU1cGtpSk5YNFJNamVOYW5OMHROSXNHWTdhTEhIL040VWRwaS9R?=
 =?utf-8?B?NitmU3crTno0bXpVZ1RiUURNNUNjWFhQdExRQ01RNG83MTNCcnJieG9EaVhw?=
 =?utf-8?B?UGE1cmdOV2x5S0JtTWlWTGhLUUFZWEFGRWl0Zmt3anZWMVhyRFp3cnVWUHUr?=
 =?utf-8?B?REVUL2xIdVA3SWNvaFdidVVYdjBWUFNQa0h6NnVPL09wVXhRbXZWczBlMnRz?=
 =?utf-8?B?RWZ2Z3hUV1BCVjlBQitqb2cxRFdJN1hOV3VMb1pORVBGZzRDUmNYRGFqcEY0?=
 =?utf-8?B?YXRuZkhCVEx2SGFXQXM2eHNicDdIcTc3NzNSSTFZSmQvYVUwOXZUbHlnOVpw?=
 =?utf-8?B?VjFQMUcyWGdPSEhGcGtlQ2prOU55OTFrVHdGZUg5dlJmRFBYejh0Z2tWQUYz?=
 =?utf-8?B?MnhEUldmT2NmTENZcStGcVZER3RSSUMwSTlkSjB1bnhjdnlBL200SHkrZ3h3?=
 =?utf-8?B?a3FmZCtSclZZbVI1SW16azJzamVKeFgyOEtmWFFLUGl0bCtwMS9rTXYwMHVk?=
 =?utf-8?B?OCtxYW8wQXhwQ0t4MWUxaWM4MWJKREx4OXh5c1ZRRmo5cW5CZ29NWmdORWpj?=
 =?utf-8?B?RTlQS2dWL0lIVFg5L2tGM0tsZXJpUnQ0K0dUL25IS29yMjE5alZjV3pGY1kv?=
 =?utf-8?B?NjAvQXl1d004VGppdHVoNHljMDVkekxhZldsck5wWk9IOGw3Sm9RWit0TXFQ?=
 =?utf-8?B?bUtXQ3ZUcFB6bEN1eDhzdnhuT2xaVkt3NFdMeHdrYWVWMEF1Sit0RWJRZTdD?=
 =?utf-8?B?ZDAzbmFGMjg2MERTK0tMa2VSYnVhSnh1T0ZkL0RCODFhQmZtY3BncFJnVVgw?=
 =?utf-8?B?MW1WdWNIMThlNi8vYWpPVkhiZ0JtcjZqSkdkYjlCM1lvcUdVaGxidm43Wnpw?=
 =?utf-8?B?SjlGZFBLM2RaVkhObzI3dHNLUTJUSUpmbDBLVHBxVTJiMHd0VFMxREZNdklB?=
 =?utf-8?B?aDVUREs0c3J3V3F2QXliayt6Z3NlWUVzVkVYamRFS0ZQcVA0cVNhM1R3OE9Z?=
 =?utf-8?B?U1llNnVZaTFlOVFTOElSbkp0Q2dnS1E0OXN2eE03NDU5dGthR05jNjZESEVO?=
 =?utf-8?B?MHZvYVFTVjNHYjdjMVpkeWl4dytiQVFqa2RQUmgvbERqMWpTVnBtYzl0OVd4?=
 =?utf-8?B?LzRsUk0zSEdxYTRkblNDSk1Wa09FZlNwemV3K0lTclZVV0hMMTA5Z0FjN3I0?=
 =?utf-8?B?NlV3WWlZZUd3SWZWdnBMWTgycndtc0pEVmtObEgwRlFIUkRjQ3kxYTg4WjBv?=
 =?utf-8?B?ekZDUkZGMTdpVW1uTTlDUWthSzFYc3M2b3lTLzNsV1pBYTlzZTdEVzZtdGc2?=
 =?utf-8?B?RHg5SWRHaU40d1U2dTNhcDJ0YUlRQ3gxdGRqcFUwZ0FoVFhCbzdOb0VVeVRH?=
 =?utf-8?B?QVk2dENMNStaOUk1Ym5aOU9oQ3c2Mnd0blU0Q1hJNXV5N3hiV3VMa3dEZnhS?=
 =?utf-8?Q?c4RBT8338u7iuB34ipG1i1eSENV/JJ2qsR77g=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OGRMZG5ZSXAxL1RLRVdRZUthUzVMcHBBVW1LN0RUSHpidTZuNC93VFpzMWxZ?=
 =?utf-8?B?TUk4Z3BzN3hid01taTROaU1UWUtxQ1U0eG8wSlpYZ3NWYTNFbVZzaXg4RXpn?=
 =?utf-8?B?UkpvQnBsNTRjaGtuSm5uRlNoYVVHWVBrS3RJOEhFbmFpUExZSkhlRklPcStq?=
 =?utf-8?B?WjYwekluY1ozalBualVvcWdYT1p2bWJHNXBNbmJJaVpSRDJxS1FkV0MzUlU3?=
 =?utf-8?B?Ylcra21KclZ1b1gvV0dnTGpTNmVRRlEzL3ZHSkk5RGZMYzdtdlpaN283cEdB?=
 =?utf-8?B?VDRIK0FUNzI0NFRqeDNaSzMvZzNGR25tenRCRWN4UG41eVhQVG1pUEJjbGMz?=
 =?utf-8?B?MEoyQmZkM2czeGQwNkRtMjdBa2Q1b0VqYUdibFJTVkRveUw1UEtWN3MyaFAv?=
 =?utf-8?B?V1VydWNwSjluM0tUTU9JUk9xQkRhdHgyU2VISExoNmJBcW54SEZCYWVSMmVW?=
 =?utf-8?B?aGNNb29pUGRrYmpLL1ozUklCY0FCVVZPNmxhWUIvUXFkQnFQSUZYNXEvMmpx?=
 =?utf-8?B?cUpuVWdGa2ovZmZ4cUVnL3Z3djY0TUtzbmsyOUx3c2JlbTZua0N4b3VQdVRC?=
 =?utf-8?B?UWJvYitRRnVFQ0o4OXNkU2JYV0hCdE5wQVVuVEFlNXJKcHgvNHZ0MHZHSVU1?=
 =?utf-8?B?UjZkdXV3OURVN1JPaWUweE5EQk84RE1YcDRTcEdWRUFVOHJZRGVnTkxkVTNF?=
 =?utf-8?B?bFN0eWw4U0hmbGFIVXUrRk1MUlF6UTBReUxXRDlCa3l1QTZ5SnlqUHJacTlp?=
 =?utf-8?B?cktINEp0VGhKNmRqMGtSRnZUZTVrN24ybDArRGxhQTRCY3ZZTGRmd2MveTFW?=
 =?utf-8?B?R1pJVjNjb25VT203VmcxRksrMjVxU2VvK1RnVXR4Uk9YUVVvVjZjZ3RZTjVo?=
 =?utf-8?B?eFhqcGk2Y0ZoVitQcDhCNGZxalpmSGhnY0ZhbmRwUExjT3BLWW12bTJYQXQ0?=
 =?utf-8?B?WkdGNXFIRXlPWmEwbGxKd3BKVFl2R1hSMWdVM2xFdFpIY0k0WTNaU3NTODhS?=
 =?utf-8?B?OGdWNkxsSStObit2Nm1PK1JJS0pPVWVJcmFEQ2FhMnJxckVPM082VmV0YXhN?=
 =?utf-8?B?NTREK3FqdldPVVdSa3p1MkRybTkzTmNUZmN1dCtnb1c3dnpOUDljOThVbThs?=
 =?utf-8?B?VWdoL3pORFVhTUY4TUNSNTFFdzVsL3M3S0xlT0xMcFEyRVJ4S2J5TFV3Rmx5?=
 =?utf-8?B?MmJCZjAwdlBscG5PR2o1T2pQVmdJZmVGSndrTi9NU2Fma2MrM0trS3VVTzJx?=
 =?utf-8?B?NFdvNHpVbGNsTXF3bUhORVpqSUk3QWp2clFRMm9uYkdjc0hGUVZ4NERvdzRK?=
 =?utf-8?B?ZjQzdzJXYndoM05CSWViMU40MFdpbU90NzREY3dPSnJSVkNYVmxPbm9ndDNP?=
 =?utf-8?B?TENKdTF5dkl6RHI2WXlLM01nVjEwS3JTb2xPUEJKak5qZkRNVndqeTFWNUZo?=
 =?utf-8?B?T1psdjlqVFBZWGdLOHUwM0pMc2tDV0FoUHp6N0Zoc2tieXRWUDdPamNkQzFm?=
 =?utf-8?B?ZityQU8xajhHaGtXV0pCVStwQ3pDWjhXOTFkTUJSN2lUQllYaWJzZUE2dkZa?=
 =?utf-8?B?d1VvSzZYUTV6SW9SaTUrN25aZEtUaG9reGw1dnpmaDJkUGl1SExVNVFnRDRD?=
 =?utf-8?B?aGxmSEM4TlZpNEpGM25VTEppR0pDQ1FpMXBFWEdlWTVSUWNvWU5GWDVxbEdO?=
 =?utf-8?B?dStsVjZrbWxEWHF0UEQ4QzNITktQZVlUMzZDZEExWnlGeHZxMFJ2V2ozSWUw?=
 =?utf-8?B?aDd6eVFsVU9JU3lNUDdMYzVxOFNRbnBjTFQ4djM0TUh1WlJKSExNckViNG1O?=
 =?utf-8?B?bDczMk5JRndJUE9zK0RFVk0rblRkNnJNaFhlRGFNVnY2cFVOaG1xR2pidWg0?=
 =?utf-8?B?K0EzUi9aNHdmVmY4azNORkIyWEYrS3d5b2haREl4cGw4SjMxdWpTdXltQ1lD?=
 =?utf-8?B?UkNFcVY1ZWZMVDQreFBHaEt5c2l1TmZicnBjclNZUVBqZmVHNnRERFkwTnB3?=
 =?utf-8?B?ckhZWStBNXZpQlRjNHV2aFVpMHhoU2lRQTMrTUVsQjcrbkxTcE5hMVdqdFoz?=
 =?utf-8?B?YlBpSnlManJWTlJ5Yk9nNXdCSXpmblJPV1MvWG04Zm5VK2JUU1hZcXhNSU82?=
 =?utf-8?B?NE1jcUh1TkJSUVRyaTZRVndJYStaS2ZLN1U0N2ZKRCtkVVFsS1QyNGU3NjdU?=
 =?utf-8?B?Vnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2FC6B09699A1D0419CF356AB5B89A52D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2nu0lIhpilb+HV64V0JCr4sLNNJuH/Um8v8x5/hJr0HnwY9yPmCqMyrmlCA/bQMFU8QtLy9GOpE9QrrsFUYBCAUU4OvQybD3mI3j8FPcED6p3MpK6R2OJ2QcApEfTYafNJ/EzX0zTWDVVsxfhCoBsMCayjBx2r0FducYrIapTUDmPfl4HS+zY0QbdW/f4M2wm9NB0ora/kzpg7qUSLaprQ9PP1nDIiR9qMgvB2xknFoafT/Hpa4ryz4y2rV9CAU5nYpldScmXNC5MaeB5BhEM0SNg/8VNFPdgC3DXbE8tdz5G9qIC1AQYleNDWmrUAjkHd85Wv6p8BPLDjZ3vO5y0Mt9Y8uDLp7kg+1ACpo4Pf4oose+am/RleDMralgPu54mo1NxV52Pk2kqHha7vzqYMTJqx20DEvqCFSCrROjV+uY1HvdJV71HTqvDOFJmJz51sYHRU54X5q2ymhf3yN2fROrBLZTRkYpTySgLoJA390XR8I8T7vmcMFC653s+/BKlnZevw4BXDxXX/rw5mp2n+9vHgIiu0jyRcYmdNWjZ1q4JMgD9vz8G95SVsavWlAPZ8ga7kV4BY6Mfn25M56BPVM9qVhkM/SuhS/aU6vTpkk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ce13158-f3f4-4e70-2bfa-08dcafdae7ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2024 14:29:50.8183
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5exnI9zVki4vcBQA9NLWVspA5Pb0xQUW3FwcNSxMp51IrSJZfOWRHpV6Pc+VZIlCyEdUDM/FI1rUdFFTItXfcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7337
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-29_12,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407290097
X-Proofpoint-ORIG-GUID: 3GHBcH5GifW7CP9XS_Ki9nf4JdwPEuPU
X-Proofpoint-GUID: 3GHBcH5GifW7CP9XS_Ki9nf4JdwPEuPU

DQoNCj4gT24gSnVsIDI5LCAyMDI0LCBhdCA5OjUz4oCvQU0sIHlhbmdlcmt1biA8eWFuZ2Vya3Vu
QGh1YXdlaS5jb20+IHdyb3RlOg0KPiANCj4gSGksDQo+IA0KPiDlnKggMjAyNC83LzI0IDIxOjMw
LCB5YW5nZXJrdW4g5YaZ6YGTOg0KPj4gSGksIEFsbCwNCj4+IFNvcnJ5IGZvciB0aGUgZGVsYXkg
cmVsYXkoc29tZXRoaW5nIGhhcHBlbmVkLCBhbmQgY2Fubm90IHVzZSBwYw0KPj4gYmVmb3JlLi4u
KS4NCj4+IOWcqCAyMDI0LzcvMjEgMToyNiwgRmlsaXBlIE1hbmFuYSDlhpnpgZM6DQo+Pj4gT24g
U2F0LCBKdWwgMjAsIDIwMjQgYXQgOTozOOKAr0FNIFlhbmcgRXJrdW4gPHlhbmdlcmt1bkBodWF3
ZWkuY29tPiB3cm90ZToNCj4+Pj4gDQo+Pj4+IFdlIHVzZSBvZmZzZXRfcmVhZGRpciBmb3IgdG1w
ZnMsIGFuZCBldmVyeSB3ZSBjYWxsIHJlbmFtZSwgdGhlIG9mZnNldA0KPj4+PiBmb3IgdGhlIHBh
cmVudCBkaXIgd2lsbCBpbmNyZWFzZSBieSAxLiBTbyBmb3IgdG1wZnMgd2Ugd2lsbCBhbHdheXMN
Cj4+Pj4gZmFpbCBzaW5jZSB0aGUgaW5maW5pdGUgcmVhZGRpci4NCj4+PiANCj4+PiBIYXZpbmcg
YW4gaW5maW5pdGUgcmVhZGRpciBzb3VuZHMgbGlrZSBhIGJ1Zywgb3IgYXQgbGVhc3QgYW4NCj4+
PiBpbmNvbnZlbmllbmNlIGFuZCBzdXJwcmlzaW5nIGZvciB1c2Vycy4NCj4+PiBXZSBoYWQgdGhh
dCBwcm9ibGVtIGluIGJ0cmZzIHdoaWNoIGFmZmVjdGVkIHVzZXJzL2FwcGxpY2F0aW9ucywgc2Vl
Og0KPj4+IA0KPj4+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWJ0cmZzLzJjOGM1NWVj
LTA0YzYtZTBkYy05YzVjLThjNzkyNDc3OGMzNUBsYW5kbGV5Lm5ldC8NCj4+PiANCj4+PiB3aGlj
aCB3YXMgc3VycHJpc2luZyBmb3IgdGhlbSBzaW5jZSBldmVyeSBvdGhlciBmaWxlc3lzdGVtIHRo
ZXkNCj4+PiB1c2VkL3Rlc3RlZCBkaWRuJ3QgaGF2ZSB0aGF0IHByb2JsZW0uDQo+Pj4gV2h5IG5v
dCBmaXggdG1wZnM/DQo+PiBUaGFua3MgZm9yIGFsbCB5b3VyIGFkdmlzZSwgSSB3aWxsIGdpdmUg
YSBkZXRhaWwgYW5hbHlzaXMgZmlyc3QobWF5YmUNCj4+IHVudGlsIGxhc3Qgd2VlayBJIGNhbiBk
byBpdCksIGFuZCBhZnRlciB3ZSBnaXZlIGEgY29uY2x1c2lvbiBhYm91dCBkb2VzDQo+PiB0aGlz
IGJlaGF2aW9yIGEgYnVnIG9yIHNvbWV0aGluZyBleHBlY3RlZCB0byBvY2N1ciwgSSB3aWxsIGNo
b29zZSB0aGUNCj4+IG5leHQgc3RlcCENCj4gDQo+IFRoZSBjYXNlIGdlbmVyaWMvNzM2IGRvIHNv
bWV0aGluZyBsaWtlIGJlbG93Og0KPiANCj4gMS4gY3JlYXRlIDUwMDAgZmlsZXMoMSAyIDMgLi4u
KSB1bmRlciBvbmUgZGlyKHRlc3RkaXIpDQo+IDIuIGNhbGwgcmVhZGRpcihtYW4gMyByZWFkZGly
KSBvbmNlLCBhbmQgZ2V0IGVudHJ5DQo+IDMuIHJlbmFtZShlbnRyeSwgIlRFTVBGSUxFIiksIHRo
ZW4gcmVuYW1lKCJUTVBGSUxFIiwgZW50cnkpDQo+IDQuIGxvb3AgMn4zLCB1bnRpbCByZWFkZGly
IHJldHVybiBub3RoaW5nIG9mIHdlIGxvb3AgdG9vIG1hbnkgdGltZXMoMTUwMDApDQo+IA0KPiBG
b3IgdG1wZnMgYmVmb3JlIGEyZTQ1OTU1NWM1Zigic2htZW06IHN0YWJsZSBkaXJlY3Rvcnkgb2Zm
c2V0cyIpLCBldmVyeSByZW5hbWUgY2FsbGVkLCB0aGUgbmV3IGRlbnRyeSB3aWxsIGluc2VydCB0
byBkX3N1YmRpcnMgKmhlYWQqIG9mIHBhcmVudCBkZW50cnksIGFuZCBkY2FjaGVfcmVhZGRpciB3
b24ndCByZWVudGVyIHRoaXMgZGVudHJ5IGlmIHdlIGhhdmUgYWxyZWFkeSBlbnRlciB0aGUgZGVu
dHJ5LCBzbyBpbiBzdGVwIDQgd2Ugd2lsbCBicmVhayB0aGUgdGVzdCBzaW5jZSByZWFkZGlyIHJl
dHVybiBub3RoaW5nICAoSSBoYXZlIHRyeSB0byBjaGFuZ2UgX19kX21vdmUgdGhlIGluc2VydCB0
byB0aGUgInRhaWwiIG9mIGRfc3ViX2RpcnMsIHByb2JsZW0gY2FuIHN0aWxsIGhhcHBlbmQpLg0K
PiANCj4gQnV0IGFmdGVyIGNvbW1pdCBhMmU0NTk1NTVjNWYoInNobWVtOiBzdGFibGUgZGlyZWN0
b3J5IG9mZnNldHMiKSwgc2ltcGxlX29mZnNldF9yZW5hbWUgd2lsbCBqdXN0IGFkZCB0aGUgbmV3
IGRlbnRyeSB0byB0aGUgbWFwbGUgdHJlZSBvZiAmU0hNRU1fSShpbm9kZSktPmRpcl9vZmZzZXRz
LT5tdCB3aXRoIHRoZSBrZXkgYWx3YXlzIGluYyBieSAxKHNpbmNlIHNpbXBsZV9vZmZzZXRfYWRk
IHdlIHdpbGwgZmluZCBmcmVlIGVudHJ5IHN0YXJ0IHdpdGggb2N0eC0+bmV3eF9vZmZzZXQsIHNv
IHRoZSBlbnRyeSBmcmVlZCBpbiBzaW1wbGVfb2Zmc2V0X3JlbW92ZSB3b24ndCBiZSBmb3VuZCku
IEFuZCB0aGUgc2FtZSBjYXNlIHVwcGVyIHdpbGwgYmUgYnJlYWsgc2luY2Ugd2UgbG9vcCB0b28g
bWFueSB0aW1lcyh3ZSBjYW4gZmFsbCBpbnRvIGluZmluaXRlIHJlYWRkaXIgd2l0aG91dCB0aGlz
IGJyZWFrKS4NCj4gDQo+IEkgcHJlZmVyIHRoaXMgaXMgcmVhbGx5IGEgYnVnLCBhbmQgZm9yIHRo
ZSB3YXkgdG8gZml4IGl0LCBJIHRoaW5rIHdlIGNhbiBqdXN0IHVzZSB0aGUgc2FtZSBsb2dpYyB3
aGF0IDliMzc4ZjZhZDQ4Y2YoImJ0cmZzOiBmaXggaW5maW5pdGUgZGlyZWN0b3J5IHJlYWRzIikg
aGFzIGRpZCwgaW50cm9kdWNlIGEgbGFzdF9pbmRleCB3aGVuIHdlIG9wZW4gdGhlIGRpciwgYW5k
IHRoZW4gcmVhZGRpciB3aWxsIG5vdCByZXR1cm4gdGhlIGVudHJ5IHdoaWNoIGluZGV4IGdyZWF0
ZXIgdGhhbiB0aGUgbGFzdCBpbmRleC4NCj4gDQo+IExvb2tpbmcgZm9yd2FyZCB0byB5b3VyIGNv
bW1lbnRzIQ0KDQpJcyB0aGlzIHRoZSBzYW1lIGJ1ZyBhcyBodHRwczovL2J1Z3ppbGxhLmtlcm5l
bC5vcmcvc2hvd19idWcuY2dpP2lkPTIxOTA5NCA/DQoNCg0KPiBUaGFua3MsDQo+IEVya3VuLg0K
PiANCj4gDQo+IA0KPj4gVGhhbmtzIGFnYWluIGZvciBhbGwgeW91ciBhZHZpc2UhDQo+Pj4gDQo+
Pj4gVGhhbmtzLg0KPj4+IA0KPj4+PiANCj4+Pj4gU2lnbmVkLW9mZi1ieTogWWFuZyBFcmt1biA8
eWFuZ2Vya3VuQGh1YXdlaS5jb20+DQo+Pj4+IC0tLQ0KPj4+PiAgIHRlc3RzL2dlbmVyaWMvNzM2
IHwgMiArLQ0KPj4+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlv
bigtKQ0KPj4+PiANCj4+Pj4gZGlmZiAtLWdpdCBhL3Rlc3RzL2dlbmVyaWMvNzM2IGIvdGVzdHMv
Z2VuZXJpYy83MzYNCj4+Pj4gaW5kZXggZDI0MzJhODIuLjlmYWZhOGRmIDEwMDc1NQ0KPj4+PiAt
LS0gYS90ZXN0cy9nZW5lcmljLzczNg0KPj4+PiArKysgYi90ZXN0cy9nZW5lcmljLzczNg0KPj4+
PiBAQCAtMTgsNyArMTgsNyBAQCBfY2xlYW51cCgpDQo+Pj4+ICAgICAgICAgIHJtIC1mciAkdGFy
Z2V0X2Rpcg0KPj4+PiAgIH0NCj4+Pj4gDQo+Pj4+IC1fc3VwcG9ydGVkX2ZzIGdlbmVyaWMNCj4+
Pj4gK19zdXBwb3J0ZWRfZnMgZ2VuZXJpYyBedG1wZnMNCj4+Pj4gICBfcmVxdWlyZV90ZXN0DQo+
Pj4+ICAgX3JlcXVpcmVfdGVzdF9wcm9ncmFtIHJlYWRkaXItd2hpbGUtcmVuYW1lcw0KPj4+PiAN
Cj4+Pj4gLS0gDQo+Pj4+IDIuMzkuMg0KPj4+PiANCj4+Pj4gDQoNCi0tDQpDaHVjayBMZXZlcg0K
DQoNCg==

