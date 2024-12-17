Return-Path: <linux-btrfs+bounces-10457-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD519F4588
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 08:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59C26188DE54
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 07:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2807E1DB363;
	Tue, 17 Dec 2024 07:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BoAZd3NN";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="vs0D644s"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E4C145B39
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 07:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734422031; cv=fail; b=NI/eREx1X8Eb9CL0azW/cCddzlpH7nGPAB3GboBuccUgez00YCMQKm6+XinDT7fUDPSe+vev/rzebPAGyeuDRhNYAG8X5+uhW+ltd/7SD6h2G7nejj8woM/LD6qrOiVozDUw1SRmiuThg/hpAY1ZZQTCCvOXJ3+l31MJus1D8XI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734422031; c=relaxed/simple;
	bh=+IRkO/lc/JCcmlxf5JQScQhnb0BOervx0pBBjEkg/7o=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hOUmSRB/8Y84cNf2isS03ekoq8XHIoYQrQr0ra5fq9EaayQlCA6t80HGic8Bp1JyuwnXM7LIWaceGodc1fXYG2rPlJ89u6kI5on8W7vvdlTjRk/DLEjib1kzqt/m9acH8X+U4R6hvB65575s2+vVyWIgkukBDmLqSoKTU5m7kmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=BoAZd3NN; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=vs0D644s; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1734422029; x=1765958029;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=+IRkO/lc/JCcmlxf5JQScQhnb0BOervx0pBBjEkg/7o=;
  b=BoAZd3NNBznJsRugby25F6DwGDxRAqtwNedRM7BDXf3mTwSLp4efq+T0
   yQhgCUEveBnVMLee70/RBA4C4FsdGy2fWHXUrJadVla7Lvv7/9feQHyQS
   epM8GAAzxr4nispBV8BUkLc9EwOtNt83thTWdzCydOjuUmp++upA1fdRI
   gcChOqDyRrN0WlVi+pioHjRk7JY49rxJg8aWyfqpkae4CV/m45JYmJKz7
   m9j9+LUU0v/83TLu+9zGWauHx0ZIyxhqofPoSglFqhTcenv22wlyYtaek
   Isy7WhNWnfumUpEBYbA7W0Iw/Qhk7JPTR2/RBXqv7fYjVQjwLxESFuRmj
   Q==;
X-CSE-ConnectionGUID: iZhGK4E1T8iDS0TNxSdUVQ==
X-CSE-MsgGUID: NGOZxJEbQuGideZ5f4trng==
X-IronPort-AV: E=Sophos;i="6.12,241,1728921600"; 
   d="scan'208";a="33351032"
Received: from mail-southcentralusazlp17011026.outbound.protection.outlook.com (HELO SA9PR02CU001.outbound.protection.outlook.com) ([40.93.14.26])
  by ob1.hgst.iphmx.com with ESMTP; 17 Dec 2024 15:53:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tKix3O/3dC207u8gikLrtaNOvUzPbr1gO37RCvAmwHkF/hp/obFwD6GeU9XBPxVfAtfUDWMty2yEKo3nCKgjeoWni/xFt93hv11X4qN5847d2raRUmiGfzh9ufqg2Gt8Nm/NZ3+lI1EWFhXaUpSswp7w8tvqm24ljXAZN3iZpVxrzKHSYaPeemKwyeHSkhZJo5izNaa+bXskEsQ/89FnJchoaBI8hMRVRjQahvcjUG6JKxzjoqngM3jktEJ66MUu5nUPhGri/1cp1kVWnOtGDbHzgMpRWc1lFWUHHW23fPA36LZtFIKun+cCToNygrtK5tTiI+Ao9JIU6IFEnYIc0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+IRkO/lc/JCcmlxf5JQScQhnb0BOervx0pBBjEkg/7o=;
 b=LEqfA42lvzZ/WG+M3r3LODtKk31QGqXz8MeZDD7Rw2kRqM8a4gJ4Sy1M+hA/WyOWt0kTNM4AvMjf9oW7nbXMVuNqrUWQU4jhymmxMO+KET8owY10C8gZ6tzwV+ViZJV6KQitFdRwHqwQYeZfw/5nDXiDG+nOfmxkbD4vvO1ir1n/kZ0xxk4i/4tneqa2IUqQunUACGVIN2xG7oT4F6XRuGs/73T3Uabt22EwUgnolgO2OjfRbhnwIxycLN6zSMabr2JQg24Qt9Y6oIWHPT6+VUm+craCsHUAghh8t1FIlPd0d98qT0f3MrZP5LvDacsKpXuHM0SgZ7qayRLSqniXIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+IRkO/lc/JCcmlxf5JQScQhnb0BOervx0pBBjEkg/7o=;
 b=vs0D644sg4KdfQXkv33IgjiCzo0QkFaAZwbDRzZGX/lutmNhqBDacDi0grPmUgRZoGMMVqN0a5nQoJxLC7yNiL4omiRRploFfU9JZHrlK45UG/juJ0QzWqRyyTuIEj/eTvwc/RoB2uRjxIJkOn7WvwW9ulJR7M5Kb5RwxIxl48I=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN0PR04MB8048.namprd04.prod.outlook.com (2603:10b6:408:15f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Tue, 17 Dec
 2024 07:53:41 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%6]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 07:53:40 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, "fdmanana@kernel.org"
	<fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 4/9] btrfs: move btrfs_is_empty_uuid() from ioctl.c into
 fs.c
Thread-Topic: [PATCH 4/9] btrfs: move btrfs_is_empty_uuid() from ioctl.c into
 fs.c
Thread-Index: AQHbT96u+/clE8YV3kSG0Y+dvLbev7Lpll0AgAB7doA=
Date: Tue, 17 Dec 2024 07:53:40 +0000
Message-ID: <252bbd01-e4b3-4523-807a-f9bdd3647a24@wdc.com>
References: <cover.1734368270.git.fdmanana@suse.com>
 <7aef21820a6bad0e41699f18660038546adbbc9c.1734368270.git.fdmanana@suse.com>
 <785dadec-8352-46d2-864d-3df93d979db1@gmx.com>
In-Reply-To: <785dadec-8352-46d2-864d-3df93d979db1@gmx.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN0PR04MB8048:EE_
x-ms-office365-filtering-correlation-id: 3297d6da-8d5e-4816-2fb0-08dd1e6febe3
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cnUxTnk4S2lyREdOSHVqRUxid3FPaU9qZTNHbHBOQ0ViSUlRWDNrdWNzSEZr?=
 =?utf-8?B?bEU4R1BjZFFyS29uZU8vZGdYTTV1WWpmR2Z5cHp0ZUY4aFV4MkppWFlXdVZG?=
 =?utf-8?B?Ny9YUlVyUGc3TE9nMmdWdEZMOWZUNnVPS1pPNFNlUmMvRDFnd004b2RNUmZN?=
 =?utf-8?B?TmpXMEkxZmNkZUtOb2Q0NCt1emx3ZlN2VGxMMGd3TVJncVpsQUEzcXZzQ1Vp?=
 =?utf-8?B?S0RLMktwVkxFWUlCdDN4MFh1aVhTRVI1L2RITTNzRW5aY0pybW8zZzRvbGJX?=
 =?utf-8?B?OXh0ZkorcUN0TGdhREVQSnJkWDhkT0k1YWR5ZUJtSXZOWDB5NzdmTm9oZWla?=
 =?utf-8?B?M280OGd2VWlxdy9oQVBtTG92UzRDTVZoN2lJWUM4dG53REtSVlNPQ0N0SW9i?=
 =?utf-8?B?ai9UYXExY2F2U3d0eFVDbUNyLzRUMGp5SFl5d1NkTU9iSU5DRGhFMGZRR1ZF?=
 =?utf-8?B?TnJrZUZCN0k4cTVBZHpXc05BZG1rSlVDL0hEdGlDcGxQM0dTYWdvUUkrU3VB?=
 =?utf-8?B?ak53ZlBBUDNMbVlTUkwwc3RSQ0ZVZmdPaStLU0djZmVtTlFGYzh0YXZCcXlJ?=
 =?utf-8?B?WlhPRnlDeS94RDBOdC93cmo4d1ZYWGNUU3U0ci9kSGkxMGJ6STFHY0tWaE5F?=
 =?utf-8?B?c1RQa0l4cVhQOVhPS2RnaFpSeEdzMHpLTlZhWDJVQVhZanVoSUxIVzNVbjZC?=
 =?utf-8?B?UWFIbkNZZmsvcVl2djFtRElPb0tiN05WQjhjdHV5VGlRL1hsUm9LSElyK3Np?=
 =?utf-8?B?ZFRxMVBkb0hFV1JmNVcxVUVWbU9CTGxEL2k5cDhrT3haOHNLMU5Td1hreWVP?=
 =?utf-8?B?YjlRMysya1pGcWVMU000QVZTTXlqTU9wUVp0YnVFNThwaVl5QnBmVlpVU2Fr?=
 =?utf-8?B?RnJ5UElnWi9INUZEMy9FdlVXRDc4dFYveC8yRFhzcklpQmJjOUl0UXBLc3Az?=
 =?utf-8?B?QjNyelhYSVZGbWxwSVdqUStuU2p2Qkt4czR1dUtFc2FiNC9KOFBqVWs1Nm5y?=
 =?utf-8?B?ekNoUUF2SlZpNGQ2a3kxdVpVeExjZlcxNUhudGlvTmlpSnZIbjU1dzBUR3lp?=
 =?utf-8?B?QlVjZFhmbmhvM3V4SEJYQzNlU09SWkUxeEpVU01OakFNV3NhRnN1cFNMcDNv?=
 =?utf-8?B?M2EzOFZoMWYwWkVDMmd6ZjlNTDlqb3dUVE5RU2pjNWpWV2NVamRGUG40emRk?=
 =?utf-8?B?cE16ZmpMR0F4a3hNWW5JNHZtR2RHcUh6MWMwVmdUQ1B1dkR3UUplQW1yeE1y?=
 =?utf-8?B?OENxWE1POVV0ZmFHNFhjYU5jcGM3bmdDYWdkTW8zUzVBa0NEUW44UFB2dDZW?=
 =?utf-8?B?aTBQelAwQXo1TXI0My96a2xmK1Q5Z0tlUW5ham9EajBQbE40TC9LZUxZZmRR?=
 =?utf-8?B?dDJ3d1pQMGt5VnB4T1o1NERQWExCOVQvdktWSmg4WHBsdE9nbVo4d0RhL2ZX?=
 =?utf-8?B?YXphOWVJaEJpdmdYSnJoTUhTRHJia3BqNXJuQ2g0Y2dTWDV4SmhVUWswUVJY?=
 =?utf-8?B?ZXdKOGk3N1lwajN3ZDMvL0NVazloTmIrM3lIb3dWazRKdU5saldtQk9UeDg0?=
 =?utf-8?B?L1lGS0ptbnV4SlFLMms1V1FhUUZNRFIwSDBmTDJBYlJrMTJwMWlUQVVISEtl?=
 =?utf-8?B?eENWeTZaMUlDWlo2TjRyVHFkc05tbUI2a3JMbVFKQ1BzOTMvTTMvaWVmOFpo?=
 =?utf-8?B?aklEekxUQzVwT1R1RVhKWWRXTUg4ZExZb2hmTDdScmhtMlJyMUVTZ21nSmFS?=
 =?utf-8?B?VDc4dlJRdTE5TDdCcHRYWFU3Y3k4SUNJdE8wVXR3UTA3ai9CQllyMGNNOUtp?=
 =?utf-8?B?RnhQUDlwaWlmOGNyUGpwWGpwdURDVURjUWROWmJMUktpMzJab0EwekIyeUho?=
 =?utf-8?B?aFdBK2ZHck5WcXMvWlNLOGxZVXloL0VpNjJGT3FHUFZyY1MvMmNYOVhJNCtR?=
 =?utf-8?Q?mxPqGjfSy0+9kRGKQKDvRaJlwql43Qki?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z21WR0VXTk1RM2p6Q3VkdHJoMXBwa0FXblpXK1hCSHgyOW1BZzJPaXc2azQv?=
 =?utf-8?B?UmdOaGlEckFXM1Qrc0RYODRGeTM0VE1HaTJaNTdPbFJNWmhUQUdqTnZrYUFu?=
 =?utf-8?B?TGdHZ1NxbWtkMDhCRjYvQ3dLR1RBWUpaQkw0OXprRDN2SHNLamdGdkRGTUI4?=
 =?utf-8?B?SmJndTRBTFM2MVVaZmtsdGVVUU85M3I1ZW15bWMrenQxT2xnTmlGSDNOUW9H?=
 =?utf-8?B?SGZhRXRzc0xhNWtOQTNNckdLTUpJRW9OWTlaRzVvNE9FRTJMNGF0YUNkQlNK?=
 =?utf-8?B?RDZuTzVJd2hrLzMvejM5TUs3TnNrZU9POUkzeFNkMXdMSVJNTXIraWlzSHJN?=
 =?utf-8?B?NGhxOUZsRy95TkREUWpValFrWGFDTC9ZVTl5RHI1aVlneDdyd1ZHd2xROXVz?=
 =?utf-8?B?cmxqNVBQSTVtSUJGb2ZlSUZIRGZrVDRuaDVyeDZGOUxCRStycWhYaXFTOXRl?=
 =?utf-8?B?Q2MzL0FwZ0FCSjVlYzhUcG9GSW9JY3ZzRFJwQW9PMUVYNGcyNjlyYUZxM3Bw?=
 =?utf-8?B?OXF6aXYvREZ2dG5RdnN0K3pSZm5HcHpjeTUxaUQ1QmsxcHRJNnJWSEdVN0M4?=
 =?utf-8?B?UnNGT085cTVSUEtpN0E5Zi9NSzU1VDV6MUh6WE5vS0VRYkJFa1RpZDRQb2k3?=
 =?utf-8?B?Z1F1eHN5RVkzblNWYlhGZHFib3l6SXVza0xSU0kvbEJHZCtTOW0yNDJ4cG1X?=
 =?utf-8?B?V3NSTEtienZWUm9QR1cwZkJDRzNPb3M2TjRtM0UvVi9YYzhWTE8rNWlRbHJh?=
 =?utf-8?B?OXlLUHRmR1VDOW9tdkU5QSt0T1R3YUVOM0Jqa2xXVS9uQktpSnpiKzFHb2xk?=
 =?utf-8?B?VFhUWTQ3TFlDdktuZ2NGRWt4cFo4TlYreWdJNDZEaStiM0h2VHllbFc1Z1l6?=
 =?utf-8?B?NytvWGxvQ1NFMzM2eXpkek02dmVwZVpMdHkvWUxUdkY0eHZQM3Jma3ExRC9M?=
 =?utf-8?B?ZU10UUdBNHVHT1NyY2hYQ0ZNYXlZVllFaWZlWTNMYThMa2RRYmE0aTBoZ0NF?=
 =?utf-8?B?ZHBvQkIyY1o1S2N2OVFiZTFiVEFCVTJhYkJQbGdudFFwSkZqY2NjMUNzQ1Vs?=
 =?utf-8?B?YkpUSkxTTWFWUEk0TzNqVG9tZ3FGTTlvYnkvU1dDQTBzRHhYOW8yZDVLcGRl?=
 =?utf-8?B?dVVtSzAvMG5CVGRPYkFoOWV6bzh4d2VMZllDZDZtaU02NndkdFpPWmV0eVo2?=
 =?utf-8?B?RFg2djl1Y2hpenhJMnZxRi93RklEMWZYb3NqUC9lMjdmWW5LQjlYRDJ0eTV0?=
 =?utf-8?B?Z3F6bGVEMHdRT0N2VzA0WDFoWjFUV1hEdzRQazU3S1YrWFhpMjRRcmFCN3Bq?=
 =?utf-8?B?UEZZTTJ2WDd2ZkNKd3RPdDRGd29sZmRMVXgxOTQ3b2xtN2Erb2FqSVNNbkNz?=
 =?utf-8?B?SjlJZ01IRjZia00wbktoeTZvNjJoM3ZNUjFHTDhrWEQzampCa3hhTW91VDVC?=
 =?utf-8?B?aUNwRkF2bmFyWk9YUFFJc2VwSm40aGtCWFh0SkUwSklKQ3ZvWE5aa3pXNmZM?=
 =?utf-8?B?WjdSK1dSejczUnFyV1JkOXhDN2Ira2U5VzhYVU85YU1Md1ExaTU0UkpuZW9Y?=
 =?utf-8?B?TmpvTmRoS1BpK3NlMzZTbjlYY2NPUEY5S0dPYkdOaWNxaFh3ejJYZDY4NnFo?=
 =?utf-8?B?UThYcCtZWkx2NnZWYXdkYmFHcWc3eFZBdzBLeEc1YzdsNFdPeVFkWnBjWU1t?=
 =?utf-8?B?UTZucG1RaW8vbFFhK05YY2RoNWllYlQ1VURCdmxMZ3V6MEw1TUNReXg2OWdB?=
 =?utf-8?B?SFloaWVXRUxPbEFpb1Q3SWlReFEycXA5SmJDK2x2dldsM25JbVVhaVRkSEcr?=
 =?utf-8?B?MWlqTTdWN2M5cWxmb3BqK0xVNjFzVFRITmQvQ3ZwM1pxM2xudGkrTnZkRlZR?=
 =?utf-8?B?MFNlQ3g1REY1Nlg5U3ZEVC90VVA2d3VhV28rc0RUazYxbVlBZHk5alZsZFhW?=
 =?utf-8?B?NWUzSTNJbEIzY1hsaFBnaVZZRXpPb2JRdDd2cjI2bUdxbGd6WWhaYXF5QnlL?=
 =?utf-8?B?dUt2NW9XdmtFZzh3TEcrR1B6Q0kwcmFkK1krc3pwMVdqS3kyMmp1Z0orSG5y?=
 =?utf-8?B?aWlvL2JOejRLb0xpMElOWXFsand4QU5QQlBnUXdpU2pvNktmb0pZYkpRZ1Vq?=
 =?utf-8?B?eXpzaVlSRU55Y21SUG4yK3k5eWlCamgvb0NxYzJDa2dQRm8yYytjMG9VSUFx?=
 =?utf-8?B?WGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AE0D6ED6C7B07F4191E703A4AC54E607@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zMhz26TDfaKHqKyRnXcmkmKP669AOfq1TPqpGqFTbJBjxZa+SLxxE5tNvQZ+1F8n8z47M2uan8Ne4ZJN9YTNUNkO3MA3ZFdFVv91oNNjliqX/YR1nsmoURQqULublWMeYjaQGlVdMpSZFKaYd/aN7Ow/a2UmnkQ7Pthl6M7851PCk9BHRLqPzntajGAGFzuXhM5gKVT85XXTstC+Ryd+nhpvhRvaJCTz+e3dwoH7rhZJw7uXVo5IWFYna9B9H7/zlnpDzfWg61g4qjLc+G5J/kAWXKdyA4Ks+ePJH/XckTi1yg1pVBpIJvCMzc0a0xj/yqA0daVj7dOW9kiQflQbrZ8fs1ZwPjmH/rQRJ6Hnj3RfbAIrHMh1vK8VJ6m85XYtawUXXf2CzuJsNk0uZ5x3JQvw7A4F9dZkJGokoHZhv3/vJ01g6YewVxpmlW/ENMuT5WGrMu8yvJBvIpeXc7J9aPAFgGaqauCIrwn+firpM+uPxkc+gVGAZsT56q6+ju75B3afjiIXjKa+ShUBwyFiSL0KuABGmCkd9Ie0gX4LLneA1flMamfHJtj3QCAI0uLVAfV1g2kpYvGCP8Zp6YSNBxoYeIGrKn2ACeXlpndQmPExalUbzP26ch/YFYoMX4VY
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3297d6da-8d5e-4816-2fb0-08dd1e6febe3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2024 07:53:40.3839
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y62RL8oVfHBDKE3aSzqqAB8ywd6jkCpN7ND3HQUPi3YpELjZUiJdH7ww8kMTr5wopmKJz8DpkDhm5UJb2+inCkou+kb45cKuwGxomZv9JgQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB8048

T24gMTcuMTIuMjQgMDE6MzIsIFF1IFdlbnJ1byB3cm90ZToNCj4gDQo+IA0KPiDlnKggMjAyNC8x
Mi8xNyAwMzo0NywgZmRtYW5hbmFAa2VybmVsLm9yZyDlhpnpgZM6DQo+PiBGcm9tOiBGaWxpcGUg
TWFuYW5hIDxmZG1hbmFuYUBzdXNlLmNvbT4NCj4+DQo+PiBJdCdzIGEgZ2VuZXJpYyBoZWxwZXIg
bm90IHNwZWNpZmljIHRvIGlvY3RscyBhbmQgdXNlZCBpbiBzZXZlcmFsIHBsYWNlcywNCj4+IHNv
IG1vdmUgaXQgb3V0IGZyb20gaW9jdGwuYyBhbmQgaW50byBmcy5jLiBXaGlsZSBhdCBpdCBjaGFu
Z2UgaXRzIHJldHVybg0KPj4gdHlwZSBmcm9tIGludCB0byBib29sIGFuZCBkZWNsYXJlIHRoZSBs
b29wIHZhcmlhYmxlIGluIHRoZSBsb29wIGl0c2VsZi4NCj4+DQo+PiBUaGlzIGFsc28gc2xpZ2h0
bHkgcmVkdWNlcyB0aGUgbW9kdWxlJ3Mgc2l6ZS4NCj4+DQo+PiBCZWZvcmUgdGhpcyBjaGFuZ2U6
DQo+Pg0KPj4gICAgICQgc2l6ZSBmcy9idHJmcy9idHJmcy5rbw0KPj4gICAgICAgIHRleHQJICAg
ZGF0YQkgICAgYnNzCSAgICBkZWMJICAgIGhleAlmaWxlbmFtZQ0KPj4gICAgIDE3ODE0OTIJIDE2
MTAzNwkgIDE2OTIwCTE5NTk0NDkJIDFkZTYxOQlmcy9idHJmcy9idHJmcy5rbw0KPj4NCj4+IEFm
dGVyIHRoaXMgY2hhbmdlOg0KPj4NCj4+ICAgICAkIHNpemUgZnMvYnRyZnMvYnRyZnMua28NCj4+
ICAgICAgICB0ZXh0CSAgIGRhdGEJICAgIGJzcwkgICAgZGVjCSAgICBoZXgJZmlsZW5hbWUNCj4+
ICAgICAxNzgxMzQwCSAxNjEwMzcJICAxNjkyMAkxOTU5Mjk3CSAxZGU1ODEJZnMvYnRyZnMvYnRy
ZnMua28NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBGaWxpcGUgTWFuYW5hIDxmZG1hbmFuYUBzdXNl
LmNvbT4NCj4+IC0tLQ0KPj4gICAgZnMvYnRyZnMvZnMuYyAgICB8ICA5ICsrKysrKysrKw0KPj4g
ICAgZnMvYnRyZnMvZnMuaCAgICB8ICAyICsrDQo+PiAgICBmcy9idHJmcy9pb2N0bC5jIHwgMTEg
LS0tLS0tLS0tLS0NCj4+ICAgIGZzL2J0cmZzL2lvY3RsLmggfCAgMSAtDQo+PiAgICA0IGZpbGVz
IGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDEyIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYg
LS1naXQgYS9mcy9idHJmcy9mcy5jIGIvZnMvYnRyZnMvZnMuYw0KPj4gaW5kZXggMDljZmI0MzU4
MGNiLi4wNmE4NjMyNTJhODUgMTAwNjQ0DQo+PiAtLS0gYS9mcy9idHJmcy9mcy5jDQo+PiArKysg
Yi9mcy9idHJmcy9mcy5jDQo+PiBAQCAtNTUsNiArNTUsMTUgQEAgc2l6ZV90IF9fYXR0cmlidXRl
X2NvbnN0X18gYnRyZnNfZ2V0X251bV9jc3Vtcyh2b2lkKQ0KPj4gICAgCXJldHVybiBBUlJBWV9T
SVpFKGJ0cmZzX2NzdW1zKTsNCj4+ICAgIH0NCj4+DQo+PiArYm9vbCBfX3B1cmUgYnRyZnNfaXNf
ZW1wdHlfdXVpZChjb25zdCB1OCAqdXVpZCkNCj4+ICt7DQo+PiArCWZvciAoaW50IGkgPSAwOyBp
IDwgQlRSRlNfVVVJRF9TSVpFOyBpKyspIHsNCj4+ICsJCWlmICh1dWlkW2ldICE9IDApDQo+PiAr
CQkJcmV0dXJuIGZhbHNlOw0KPj4gKwl9DQo+IA0KPiBTaW5jZSB3ZSdyZSBoZXJlLCB3b3VsZCBp
dCBiZSBwb3NzaWJsZSB0byBnbyB3aXRoDQo+IG1lbV9pc196ZXJvKCkvbWVtY2hyX2ludigpIHdo
aWNoIGNvbnRhaW5zIHNvbWUgZXh0cmEgb3B0aW1pemF0aW9uLg0KPiANCj4gQW5kIGlmIHdlIGdv
IGNhbGxpbmcgbWVtX2lzX3plcm8oKS9tZW1jaHJfaW52KCksIGNhbiB3ZSBjaGFuZ2UgdGhpcyB0
bw0KPiBhbiBpbmxpbmU/DQo+IA0KPiBPdGhlcndpc2UgbG9va3MgZ29vZCB0byBtZS4NCg0KVGhl
IGdlbmVyaWMgdXVpZCBjb2RlIGFsc28gaGFzIGEgdXVpZF9pc19udWxsKCk6DQoNCmJvb2wgX19w
dXJlIGJ0cmZzX2lzX2VtcHR5X3V1aWQoY29uc3QgdTggKnV1aWQpDQp7DQoJcmV0dXJuIHV1aWRf
aXNfbnVsbCgoY29uc3QgdXVpZF90ICopdXVpZCkpOw0KfQ0KDQpzaG91bGQgd29yayBhcyB3ZWxs
LCBidXQgSSd2ZSBub3QgdGVzdGVkIGl0IGp1c3QgZXllYmFsbGVkLg0K

