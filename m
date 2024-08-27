Return-Path: <linux-btrfs+bounces-7537-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A800F95FE0C
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 02:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C504E1C21BD2
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 00:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9564A2D;
	Tue, 27 Aug 2024 00:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ewewymFi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2095.outbound.protection.outlook.com [40.92.90.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0736D2107
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2024 00:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.90.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724719658; cv=fail; b=gklaG8rNytZdb4W1gOk1ipjlLpMMnfa1r3xKjf4OAsPbxnkcy38LgU8MHNmRR1b3B39ZDFMUbOgvSDg2D2SrKN7H7ceN9uL+Z4LUCTBOSUqzSFNdYjgEV6CluicBYy787zp2VmrcTRZcoSg5RgtV+wzZSRfMfPzsxIBiT4A+lp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724719658; c=relaxed/simple;
	bh=9hDlv5uUuplT/NQn1zo+sy0qKos5pN45C83N4NoEZ4Y=;
	h=Content-Type:Message-ID:Date:Subject:To:References:From:
	 In-Reply-To:MIME-Version; b=YzGMqT8mfc9cZ8JwFEOtOCz/vzndHRk+LQGuggvfkDPZ6VniG1fhHjqkOe6g0DaxEc+iFx43DawNEWjFcRK5Ey1UjJV6gGwMZ9QqkAgP8oIFMAmo/5jGMOrzd8210VFcrb2Sc74Lh/cYaQL6lQNtYkfRXlnfei2JzDG7YnNG75k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ewewymFi; arc=fail smtp.client-ip=40.92.90.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qcjdnIyHsyB0KC6GQTjhMGaUkiu6/cGVi4MJLs8Dpzw1cQeeKb18X6lj0OpewnL0ZLMpUSGs0SeKQ7ZA0+WYu940x2ZBhn2oX2EV964t6AKE/7gXhzlv/cklPyhcV59yYofr1bFvV6aWQMrOUiZXmBj6n6i0968WYF7A/x8hOhlRhQWPNaYzggCIo92F3dKyED7HvZECb4mNc343TPbdF1W3PmL9/mo9NV9xrie5OjzVXzcQbORO4DlNlo1rfaqshGpcQzN7q/yzllp44H7fspWYV5vxJOUkzl+mGe9lmuJnYYPenpTfXRRXz2rvizjjH6Hzgm8MUbHOeqKJvlcKRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ghdWkq94oCq+rJ2hoFXWMWjYQ0JCeqmcfA7aC08Z/q0=;
 b=CJhJLsCAtELWMvjPVdD+Bx6vO/ZIJkS7jsMvaGEbJ0nvcggYielCnnCM35r5tghyuK692a2ECHBeLdK3nh0ULAjjXX+vALO7Rc23DB10DaOsaECd8ODIZvg4gg6MjUom5dnZ/qjyp8WLMqCnfEN/j2B00afzBMaUKhDMVrjf17ije7sXOGtTTIlMaMv0jEbw45W7A0pmpjGC9qaStRnukkkJ7l7rRXkeC7SAoQDHt8zmqgUByG78JGYIT35TBfqjepfg46w2bEUpxO3E5ZfXWyguzpQPlvc9g9XcbuGcMo54qPmEIKIphPyySgaDsUBQrduRw1vS/qijVf/cla1tpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ghdWkq94oCq+rJ2hoFXWMWjYQ0JCeqmcfA7aC08Z/q0=;
 b=ewewymFidCUxLdziz9+SHLU/t5T9wVqlGO2TgdKcWj1miom3WNPxrQAtkxfL6C0cTs9l2egdbGjm5PC7XBUNCROYpj4AQPR7ZwkBIXXF9IsbK71ojQGKMBwks8v47cdeLYmyjM2Fl3kon3QWR5lzZiw3ruGNaR335onU+yhmoxdjKbHxyXYJSNNJ12Cch+eaxkbFSxLB8Xc9DbteKbzKnoWnhoqcatSEbR9X+fJxRwuXKdQEry/rPulwClDanOPuBZ9o72Dwsr5f4DVWdejp+iUnL72Y+RYnliq2UfpAlwWwfBAYw0e+NV+3orjqx9UU0fTv+i6OgsamXDLffauDRA==
Received: from AS8P250MB0886.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:54b::7)
 by AS4P250MB0587.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:4bd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Tue, 27 Aug
 2024 00:47:33 +0000
Received: from AS8P250MB0886.EURP250.PROD.OUTLOOK.COM
 ([fe80::e8e5:32e2:57ff:ab61]) by AS8P250MB0886.EURP250.PROD.OUTLOOK.COM
 ([fe80::e8e5:32e2:57ff:ab61%2]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 00:47:33 +0000
Content-Type: multipart/mixed; boundary="------------9w0Z7640Y89oiPfOUT0vTjlR"
Message-ID:
 <AS8P250MB08866EFCC85A9CCCAF99E65E8F942@AS8P250MB0886.EURP250.PROD.OUTLOOK.COM>
Date: Tue, 27 Aug 2024 02:47:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Errors found in extent allocation tree (single bit flipped)
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <AS8P250MB0886A81B469CD5F707144EA38F852@AS8P250MB0886.EURP250.PROD.OUTLOOK.COM>
 <6d90baa9-ffc1-4c9d-87b2-4ba89983bef1@gmx.com>
 <AS8P250MB08869C932AF99C5C087F1B408F8B2@AS8P250MB0886.EURP250.PROD.OUTLOOK.COM>
 <012717c6-4e7e-44e9-9906-5f13e4273c35@gmx.com>
Content-Language: en-US
From: Pieter P <pieter.p.dev@outlook.com>
In-Reply-To: <012717c6-4e7e-44e9-9906-5f13e4273c35@gmx.com>
X-TMN: [MnM/abyoakS7pXzPB3CgK6O2xO/xy0bV]
X-ClientProxiedBy: PR2P264CA0044.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:101:1::32) To AS8P250MB0886.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:54b::7)
X-Microsoft-Original-Message-ID:
 <ae9ff8fc-b4da-4856-94f5-ac7d4aa0be26@outlook.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P250MB0886:EE_|AS4P250MB0587:EE_
X-MS-Office365-Filtering-Correlation-Id: 2256fe62-4040-47a0-a22b-08dcc631d65d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|6092099012|461199028|5072599009|15080799006|19110799003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	mHRNXSgWrXHaHjjpPpOkTYPmAdmXa9lbgXWYa3FyrEaaRmp9jei0qNYB0kgWwWZhuTQsirvVE5OSyhj6y08v6fmabGIVUJAyCPQmmWIVC2JZswFx5m/43r5j7in5KrxveuCQVbtxIp7FROVL10f9jiVyqriU2qqN+Mc6N2oCyXPmSRYpI/yyZ37Bt5LXfK0LPJU8kbSdqwWikA6SW9STtsv4sIH1DZHdrhbeL/fY0/pPcIlxJc1wkejhkAPFlzjTDG0CIzaUMtM3atnBPg1AO9ug/1ZMHo/peQ3CLfqwjyc4rEF5MqF+/e2tdrah5FK7TK9vFe7d8bsBhIKLqazd71TbVuK7L95UauEG/zTgV4Libi7M4h82Awb+93+wMO1QgmTBZkLlKp4J9QvDt8Am85ej3JT+Rb4vzqu59fdrEefLnnyrF+nuTQDDNCqA9/J1QU9b3yJDQi2RtiGWO1vNB7hKC/Dr0FszhyESY1/jp59gFdTbjHVpSXUd00aWPGLQJ3mLDGbFHkr4tlmH8NP03onkwIw7C3mYDmkQafLLg0VWa8hKoh+0N1oZNe0WqOG9LOX74SHgwCU2fd1GeoNUJZIMKOy4oqhoGx94LD6+KgQGxm8APfLctWc/DrdThxsVr1Am4muMgVrimRM1v3FCIuFqe1u6Nc3XG1bb7yrJjGaAR9FWKR64QAeVnS80A5zdv3ZyYywQvvCDoRL1p0Gbc32mkBjh4jbvZu2pgL+lRnw=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OHZlNmZsQnZnd3pNaUZPS3prRS9PYjNyVVJ0NzZPSjdlT2NwZWV1dUZVdk82?=
 =?utf-8?B?djFtK1FNSWdWSHRiUnZEWUlITlBnYWY2eXlPd3kwazBiSUZGTHVGbEdhRTNw?=
 =?utf-8?B?SEtPZEJVMHVFNzY3TnVoSndEWFk2eXpyOGp0VmZuSml0UGcybXJjcFA1UXlm?=
 =?utf-8?B?dCtnUTc5MnpFSThPcWloc1BxTlpkOEd6ZGs4TStJQW1aSWFVRHh6TnFuZjRT?=
 =?utf-8?B?TmozbHhXNEc2ajVjTEtWbmtud3R4bmxnZnVQUEg4VjdDRHBoM2Z2ZXZiMTJE?=
 =?utf-8?B?bHp6K1duK3NTelkyM3hERTQ3eENXSE85WStnMGpSa1IzbVV0TVlWTHp3bVJq?=
 =?utf-8?B?VW13QVpFbGpVR2M3SHRwWCs1UHVhQ1JYQWFvT1Rua0pUcVVucmxoRDJGbUNV?=
 =?utf-8?B?dVpHNllQQ3RzMmt1OStKSjhHcWZ6Z1Fuei9oVGcrM3FLdGp0aldsc09OY2c3?=
 =?utf-8?B?MWo1NStyaGltMU93YkpGc3dCSnFyZTZNMi9IQWc0aTIySUEwRVBXUFNKd2RW?=
 =?utf-8?B?Vy9wNHlPcWE2YjI2Y01BTmlPNDdRampUanplV0pCa09ITWdMNzE0aGM2ZzVF?=
 =?utf-8?B?RU5sZWlnU2NRSlJlamhURThGOXhhV2pZWEJYN2hSdlFyaTBRZUhFajFCOU9p?=
 =?utf-8?B?VWE4Um9vMDU2ZDlYYU5lMXBvSUU2VDRKekp4dUFoc3lkMTBmc0YxVkZWczZl?=
 =?utf-8?B?RXp1UkVqL1JjZlM4M1JrZUhSYWVzbUFNQ01vb04wNHk3SllPaiswWGdCTzRz?=
 =?utf-8?B?TnRtV0VCend5WmU1V0JMSHFVUzY5MEpDT0xjclJMeU1zNzJoTFJCUmFHdnk4?=
 =?utf-8?B?dHlnV3U5dEhNL3BVejZuQ2lNMllyajg2NWNSSXpYWFNEL3FTdWtyNXlIQ0dz?=
 =?utf-8?B?QnNZNitoNXc5VEE1dExIcEM4aU9OWEdEaXI1cDVPd1JUcHY5TmRETXV6NGVS?=
 =?utf-8?B?NC9pby9YcHJZcWJMTUJ5L00rb0NNaTY5VnhJcFMxRUlrRUFCMUNkcTVPQ3Fj?=
 =?utf-8?B?TjlYMjFoQUJVZ0ZIRGdlYXU2cEVHRExiYWRVdHZaSDBXZmFuRUZDdDhBRzNV?=
 =?utf-8?B?d1JyMmgxNGVIUmV4Q1luUjVDd2ZJSnhhRzdwUkdrZUg0UzlNMXR4c0d1aEFE?=
 =?utf-8?B?OFJZNEVrYW9jeDVnQlRsOWRRZXRTa1dBbFVrOXJhK1FpdER4K0pMNDRkemVQ?=
 =?utf-8?B?R2dPNUpNZDIzMmJvZ3JtOS9iNGZwVEZBYWtrTTB0STF6WFdFU0hIQjEwTTBT?=
 =?utf-8?B?NVhhNDByN2FFaFBNTnZuWWdtci9YNjZDYld2VFVXMDB3UzRnN0ZYWkFlM2dr?=
 =?utf-8?B?RE82eTlGUUZJUjgyT29xeFlJZUN0WXJobldlV29EbkRkZFNJeWRYSWllME9N?=
 =?utf-8?B?ZlZReHlhNmNoWUNKTmNHUUZpbDlUakM3a2xFOXI2Rlg3d1F4MDA3angzckpx?=
 =?utf-8?B?VW52VGdGNXZaY2VnQ2Q0bkY2VitieWdsSDFBZjZuU2VVd1BWOWZSK0VFZVU3?=
 =?utf-8?B?b04vdmFacFpuQWQ3TnBMeVBIbGlmOWk3YWRTcnR0bmhENFdSUFcwUDFkajFM?=
 =?utf-8?B?UFowbGJjZWJtbXJsanpwa05IemR1d2VtTUNCaUl0czBzbm1aQno5VTFHK0Jv?=
 =?utf-8?B?dGFuZWZBelVHTXZkSjhoTTMzZ2xkY0FKUXdIMGxiWks1YWNmYmdOazU1NG9N?=
 =?utf-8?Q?WxK/GexiS6OCGv19F7AK?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2256fe62-4040-47a0-a22b-08dcc631d65d
X-MS-Exchange-CrossTenant-AuthSource: AS8P250MB0886.EURP250.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 00:47:33.3612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P250MB0587

--------------9w0Z7640Y89oiPfOUT0vTjlR
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/08/2024 01:18, Qu Wenruo wrote:
> After your latest --repair try, the fs should be more or less fine, you
> can try remove the offending file.
>
> Just a minor problem left with the superblock used bytes, that can be
> fixed by another "btrfs check --repair" run very safely.

No luck, unfortunately. Removing the file fails (automatically gets 
re-mounted read-only, and the file re-appears), and btrfs check --repair 
fails to repair the super bytes_used error (output attached).

> Another possibility is, the fs is old and you just migrated the drive/fs
> to the current platform, but I doubt about the case considering the file
> is some browser cache, which shouldn't be that old.
>
> Just in case, mind to try something like memtest86+ (UEFI payload) or
> memtester (inside the OS) to rule out the hardware problem?

The fs is only around 1.5 years old, it never left the system. The file 
was last modified on July 22. I'll run another memtest.

Thank you,
Pieter


--------------9w0Z7640Y89oiPfOUT0vTjlR
Content-Type: text/plain; charset=UTF-8; name="btrfs-output-2.txt"
Content-Disposition: attachment; filename="btrfs-output-2.txt"
Content-Transfer-Encoding: base64

Li9idHJmcy5zdGF0aWMgLS12ZXJzaW9uCmJ0cmZzLXByb2dzIHY2LjEwLjEKLUVYUEVSSU1FTlRB
TCAtSU5KRUNUICtTVEFUSUMgK0xaTyArWlNURCArVURFViArRlNWRVJJVFkgK1pPTkVEIENSWVBU
Tz1idWlsdGluCgpzdWRvIC4vYnRyZnMuc3RhdGljIGNoZWNrIC0tcmVwYWlyIC0tbW9kZT1sb3dt
ZW0gL2Rldi9tYXBwZXIvbHVrcy14eHh4eAplbmFibGluZyByZXBhaXIgbW9kZQpbLi4uXQpTdGFy
dGluZyByZXBhaXIuCk9wZW5pbmcgZmlsZXN5c3RlbSB0byBjaGVjay4uLgpDaGVja2luZyBmaWxl
c3lzdGVtIG9uIC9kZXYvbWFwcGVyL2x1a3MteHh4eHgKVVVJRDogeHh4eHgKWzEvN10gY2hlY2tp
bmcgcm9vdCBpdGVtcwpGaXhlZCAwIHJvb3RzLgpbMi83XSBjaGVja2luZyBleHRlbnRzCkVSUk9S
OiBleHRlbnRbMjIxNjcxODMzNiwgNDA5Nl0gcmVmZXJlbmNlciBjb3VudCBtaXNtYXRjaCAocm9v
dDogMjU3LCBvd25lcjogNTAwNTg3NTEsIG9mZnNldDogMCkgd2FudGVkOiAxLCBoYXZlOiAwCkNy
ZWF0ZWQgbmV3IGNodW5rIFs3NDE5ODYwMDkwODggMTA3Mzc0MTgyNF0KRGVsZXRlIGJhY2tyZWYg
aW4gZXh0ZW50IFsyMjE2NzE4MzM2IDQwOTZdCkVSUk9SOiBmaWxlIGV4dGVudFs1MDA1ODc1MSAw
XSByb290IDI1NyBvd25lciAyNTcgYmFja3JlZiBsb3N0CkFkZCBvbmUgZXh0ZW50IGRhdGEgYmFj
a3JlZiBbNTc2NDYwNzU0NTIwMTQxODI0IDQwOTZdCnN1cGVyIGJ5dGVzX3VzZWQgNTk2NzU3OTU4
NjU2IG1pc21hdGNoZXMgYWN0dWFsIHVzZWQgNTk2NzU3OTkxNDI0CkVSUk9SOiBlcnJvcnMgZm91
bmQgaW4gZXh0ZW50IGFsbG9jYXRpb24gdHJlZSBvciBjaHVuayBhbGxvY2F0aW9uClszLzddIGNo
ZWNraW5nIGZyZWUgc3BhY2UgdHJlZQpbNC83XSBjaGVja2luZyBmcyByb290cwpFUlJPUjogcm9v
dCAyNTcgRVhURU5UX0RBVEFbNTAwNTg3NTEgMF0gY3N1bSBtaXNzaW5nLCBoYXZlOiAwLCBleHBl
Y3RlZDogNDA5NgpFUlJPUjogcm9vdCAyNTcgRVhURU5UX0RBVEFbNTAwNTg3NTEgMF0gY29tcHJl
c3NlZCBleHRlbnQgbXVzdCBoYXZlIGNzdW0sIGJ1dCBvbmx5IDAgYnl0ZXMgaGF2ZSwgZXhwZWN0
IDQwOTYKRVJST1I6IGVycm9ycyBmb3VuZCBpbiBmcyByb290cwpmb3VuZCA1OTY3NTc5OTE0MjQg
Ynl0ZXMgdXNlZCwgZXJyb3IocykgZm91bmQKdG90YWwgY3N1bSBieXRlczogNTYzNzEzNDIwCnRv
dGFsIHRyZWUgYnl0ZXM6IDE0NzIxMzM1Mjk2CnRvdGFsIGZzIHRyZWUgYnl0ZXM6IDEzMDcyODI2
MzY4CnRvdGFsIGV4dGVudCB0cmVlIGJ5dGVzOiA5MDg3MjIxNzYKYnRyZWUgc3BhY2Ugd2FzdGUg
Ynl0ZXM6IDI1MTk2MjI4NjgKZmlsZSBkYXRhIGJsb2NrcyBhbGxvY2F0ZWQ6IDgxNzE3MDEwMDIy
NAogcmVmZXJlbmNlZCAxMDU0OTk4OTI1MzEyCgojIG1vdW50CgpybSAvbWVkaWEvcGlldGVyL3h4
eHh4L0Bob21lL3BpZXRlci9zbmFwL2Nocm9taXVtL2NvbW1vbi9jaHJvbWl1bS9EZWZhdWx0L0Nh
Y2hlL0NhY2hlX0RhdGEvZjg4ZDlkNDZlMWFiNjRlM18wCmVjaG8gJD8KMApscyAvbWVkaWEvcGll
dGVyL3h4eHh4L0Bob21lL3BpZXRlci9zbmFwL2Nocm9taXVtL2NvbW1vbi9jaHJvbWl1bS9EZWZh
dWx0L0NhY2hlL0NhY2hlX0RhdGEvZjg4ZDlkNDZlMWFiNjRlM18wCmxzOiBjYW5ub3QgYWNjZXNz
ICcvbWVkaWEvcGlldGVyL3h4eHh4L0Bob21lL3BpZXRlci9zbmFwL2Nocm9taXVtL2NvbW1vbi9j
aHJvbWl1bS9EZWZhdWx0L0NhY2hlL0NhY2hlX0RhdGEvZjg4ZDlkNDZlMWFiNjRlM18wJzogTm8g
c3VjaCBmaWxlIG9yIGRpcmVjdG9yeQoKIyB1bm1vdW50CgpzdWRvIC4vYnRyZnMuc3RhdGljIGNo
ZWNrIC0tcmVwYWlyIC9kZXYvbWFwcGVyL2x1a3MteHh4eHgKZW5hYmxpbmcgcmVwYWlyIG1vZGUK
Wy4uLl0KU3RhcnRpbmcgcmVwYWlyLgpPcGVuaW5nIGZpbGVzeXN0ZW0gdG8gY2hlY2suLi4KQ2hl
Y2tpbmcgZmlsZXN5c3RlbSBvbiAvZGV2L21hcHBlci9sdWtzLXh4eHh4ClVVSUQ6IHh4eHh4Clsx
LzddIGNoZWNraW5nIHJvb3QgaXRlbXMKRml4ZWQgMCByb290cy4KWzIvN10gY2hlY2tpbmcgZXh0
ZW50cwpmYWlsZWQgdG8gcmVwYWlyIGRhbWFnZWQgZmlsZXN5c3RlbSwgYWJvcnRpbmcKCnN1ZG8g
Li9idHJmcy5zdGF0aWMgY2hlY2sgL2Rldi9tYXBwZXIvbHVrcy14eHh4eApPcGVuaW5nIGZpbGVz
eXN0ZW0gdG8gY2hlY2suLi4KQ2hlY2tpbmcgZmlsZXN5c3RlbSBvbiAvZGV2L21hcHBlci9sdWtz
LXh4eHh4ClVVSUQ6IHh4eHh4ClsxLzddIGNoZWNraW5nIHJvb3QgaXRlbXMKWzIvN10gY2hlY2tp
bmcgZXh0ZW50cwpzdXBlciBieXRlcyB1c2VkIDExOTM1MTgzNDIxNDQgbWlzbWF0Y2hlcyBhY3R1
YWwgdXNlZCA1OTY3NjAzNzkzOTIKRVJST1I6IGVycm9ycyBmb3VuZCBpbiBleHRlbnQgYWxsb2Nh
dGlvbiB0cmVlIG9yIGNodW5rIGFsbG9jYXRpb24KWzMvN10gY2hlY2tpbmcgZnJlZSBzcGFjZSB0
cmVlCls0LzddIGNoZWNraW5nIGZzIHJvb3RzCnJvb3QgMjU3IGlub2RlIDUwMDU4NzUxIGVycm9y
cyAxMDAwLCBzb21lIGNzdW0gbWlzc2luZwpFUlJPUjogZXJyb3JzIGZvdW5kIGluIGZzIHJvb3Rz
CmZvdW5kIDU5Njc1MjQwMDM5MSBieXRlcyB1c2VkLCBlcnJvcihzKSBmb3VuZAp0b3RhbCBjc3Vt
IGJ5dGVzOiA1NjM3MTM0MjAKdG90YWwgdHJlZSBieXRlczogMTQ3MjM3MjczNjAKdG90YWwgZnMg
dHJlZSBieXRlczogMTMwNzI4MjYzNjgKdG90YWwgZXh0ZW50IHRyZWUgYnl0ZXM6IDkwODY4OTQw
OApidHJlZSBzcGFjZSB3YXN0ZSBieXRlczogMjUxOTg0Mjc5MgpmaWxlIGRhdGEgYmxvY2tzIGFs
bG9jYXRlZDogODE3MTcwMTAwMjI0CiByZWZlcmVuY2VkIDEwNTQ5OTg5MjUzMTIKIAojIG1vdW50
CgpscyAvbWVkaWEvcGlldGVyL3h4eHh4L0Bob21lL3BpZXRlci9zbmFwL2Nocm9taXVtL2NvbW1v
bi9jaHJvbWl1bS9EZWZhdWx0L0NhY2hlL0NhY2hlX0RhdGEvZjg4ZDlkNDZlMWFiNjRlM18wCi9t
ZWRpYS9waWV0ZXIveHh4eHgvQGhvbWUvcGlldGVyL3NuYXAvY2hyb21pdW0vY29tbW9uL2Nocm9t
aXVtL0RlZmF1bHQvQ2FjaGUvQ2FjaGVfRGF0YS9mODhkOWQ0NmUxYWI2NGUzXzAKIyBmaWxlIHdh
cyBub3QgYWN0dWFsbHkgcmVtb3ZlZAoK

--------------9w0Z7640Y89oiPfOUT0vTjlR--

