Return-Path: <linux-btrfs+bounces-5633-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 427C390322B
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jun 2024 08:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DDBFB22817
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jun 2024 06:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130BB171079;
	Tue, 11 Jun 2024 06:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aberj6y5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UI5aa8Rj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B016679C2
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Jun 2024 06:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718085823; cv=fail; b=QirplNl2MCzKejbwqA5UA088m81X4iGiNwm1ywsKyEiG3poT3Ohpr8rXpXg3T0bnTVnvC8hKH9LI1xi90Yh3N494Ve6C5YD50seHk6YmkCl3SL2f/2aOKR2Hwbi2HMMtkM31O/nT9cXDC7GlkX/pH9MNMAGQfce3vFsbUYS6TRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718085823; c=relaxed/simple;
	bh=mIhX4GfgJ393j14G78tRfSzzDAWRVe5N+628AKz5U1U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J2yKykcfS9U8bDp1bdiJVAKtWaoOZ5IVIgCKadfJkVECRhCF2Uhrpvp5noWZw+z3132V6oRx85N7yLRDPUf2EI8p6a27PTRr+Ra5wK3hlQSrkZWjdmMu3sOoqYM/eiT9L81+CuoOyjEM9m68FSZp4k/5WZ9rUjKCJAyouYaQgTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aberj6y5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UI5aa8Rj; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45AMRStK029338;
	Tue, 11 Jun 2024 06:03:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=mIhX4GfgJ393j14G78tRfSzzDAWRVe5N+628AKz5U1U=; b=
	aberj6y5Yt4XpqJdFTGlGcHQSz73xf5if+NHga/UIm5NkawLe9LX6yda0CrWlQnX
	2D7jZd0wgk/E/3DHRwY63aXh4ZLAdPEckcJatXwsjfB4cNSeetqZXKy169zYp7oN
	Z1aeei9y96PIYve8DhKpdGthIgK+mcjw6WoiJ9CsfZ6JUPC9OnpqRotrFhiPoTcm
	Tb6ED6atbqqj+UfCZ5uxE5YwayXQhanF66Pm/vfTBi3RRrCwjoLL/NPrt5Dj2f0b
	Y8G+hXlD+tRdn2uyXufEUqDcOl2BJZ4B0sSDdhIObA3mlhdcpq3KykWpR7ZI4yr3
	hNiWZO/+nf/r+UrgW1dshA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymh7dm269-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Jun 2024 06:03:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45B55iG0014226;
	Tue, 11 Jun 2024 06:03:32 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yncetg6c7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Jun 2024 06:03:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j7YMxzwuB2ivORz42AuD/C8UhixaJKg3xua+gN+j5d/TT3jIEBHWBYf92eJq6MjXlTdcviR7ugT+RYBbaYvMeTswcBol9fmGf54otkQKZrWUz/o8wxovFbEk/JzGGfpFDOQlZGOUQjDG7wWiTm11C8oxrCCayk3vrQe5AYKtmgmUvVtNU4Eok2hKF7zKJXFhemv33cGx3NlouQhYSeKmHPouJxDN5XqnaoweNmFnnc/TFcSVCcdOAbQT8MtR3JAQ4tCJlbv2D07v0wE5ZrX/F+jOuhHxBG8SqhJQK7NTlgAonOlbM7m1mib7C4zTgfRA9uaJP7+qNfktcBmQjcsRjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mIhX4GfgJ393j14G78tRfSzzDAWRVe5N+628AKz5U1U=;
 b=kHecrNhEBcg5z+qDHt/uzv2p1DCjd6xycE6zgeSC5ZLdWRjJD83YfV5dKpVT0x2SfKmhP3/J9euhAZ5o3TT3aL+uY2Glb880XoHzDRQnogNw8THcRhTjU54eueQvNR7pd/+cjs+636tv9en9GerGXo2eZTwkghMGuVWsmH7Q+dW4JmSn4J/B4kcWKfBYvT9P3/pgPHZHhssCIaAmjnAUyS+G+mZe20Q97cH6b5VEhxlvM5nbf+vbyi94n+jX+MwAcL6gQ27qXAyqgdQeFEcxQ4vx9tlh5WhEznmT3dtwPZNLMYy1gMzin3bk+28l6VuHwYv32Of2vp3WIxVdLNrtOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mIhX4GfgJ393j14G78tRfSzzDAWRVe5N+628AKz5U1U=;
 b=UI5aa8Rj+ZwBvw6gEzslTl/ZJie0Z4HE0bbue4Nrc7lb6NMdDwwjDDBHMHjUsP4Jm9lkDaHCcXL5TjVtn6e9yPkQVQjLaRJgo+Laui7ylD8/XTpB9IX3x+hahGMzXb5CWgcAzCW2EJlK3i2YmxYKt+Tx0vVBCmtRMmF2tP1Mc3o=
Received: from DM6PR10MB4347.namprd10.prod.outlook.com (2603:10b6:5:211::11)
 by IA0PR10MB7623.namprd10.prod.outlook.com (2603:10b6:208:493::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 06:03:30 +0000
Received: from DM6PR10MB4347.namprd10.prod.outlook.com
 ([fe80::1e9d:8ed8:77a6:f31f]) by DM6PR10MB4347.namprd10.prod.outlook.com
 ([fe80::1e9d:8ed8:77a6:f31f%5]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 06:03:30 +0000
From: Srivathsa Dara <srivathsa.d.dara@oracle.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
CC: Rajesh Sivaramasubramaniom <rajesh.sivaramasubramaniom@oracle.com>,
        Junxiao Bi <junxiao.bi@oracle.com>, "clm@fb.com" <clm@fb.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "dsterba@suse.com"
	<dsterba@suse.com>
Subject: RE: [PATCH v2] btrfs-progs: convert: Add 64 bit block numbers support
Thread-Topic: [PATCH v2] btrfs-progs: convert: Add 64 bit block numbers
 support
Thread-Index: AQHauGDoDe2/f94lNECPwQghwg/+QLHCGSbw
Date: Tue, 11 Jun 2024 06:03:30 +0000
Message-ID: 
 <DM6PR10MB4347A0EADF68B973447C5591A0C72@DM6PR10MB4347.namprd10.prod.outlook.com>
References: <20240606102215.3695032-1-srivathsa.d.dara@oracle.com>
 <c3060faf-f0e8-4bd2-865b-332e423a8801@gmx.com>
In-Reply-To: <c3060faf-f0e8-4bd2-865b-332e423a8801@gmx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR10MB4347:EE_|IA0PR10MB7623:EE_
x-ms-office365-filtering-correlation-id: 0d451d3d-1e56-49dc-d022-08dc89dc37ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?aVo5T3dzN1MwUUZTaGFzaTdnR0IzdWhIYmlOdnIxZWhBckNPdFg2UytRbzB1?=
 =?utf-8?B?cXBUVjFiQjBvN1RMK0NjdkVXT2lYemlxTUduZXphVkVEWUNJMnJ1QjN6MU5V?=
 =?utf-8?B?OUFoKzZjbzFaVUZoTmRyN2VCRmowOUYrNmJEYkpVMndsYVN6MEpPcnVQN092?=
 =?utf-8?B?S0dNWFdVSFRpRnlzaDE0REpKWjZ5NVRISnRwRThBZi85L21JS3ViaXk3YnBT?=
 =?utf-8?B?MVFjZnRMRVFlM3ZJWnhaSndYRGova2ZnSkVEK3JrdTVxNy8zZWhSUUxRTG9Q?=
 =?utf-8?B?RFFJRUt5Y1RNcWpObTY5STRWVGF3VnIrTGJzOVd1M2Q5OWdyaDY4bHM2WWhT?=
 =?utf-8?B?YVUyU2RpVlZUcDhhUzhRL1pUcVY0OXBkUm83UEJoLzhrUjFDZTBlSUZtbTJl?=
 =?utf-8?B?VkJza1ZNekNsREQ4TTdNZTFXL3lOU2JmMW1rV3lNU0xaU0xMYTlyekJTbEc0?=
 =?utf-8?B?aUhuWTZZRzFxZ2gzNHg4RGZublJWNTR1K1N3KzBVUE5ybUpoM3lCODFDV1BM?=
 =?utf-8?B?THZ1ZlozNVBYSkYzZmM0NmNpUjlNVzN6TkdVR3V1bXo3Mm1XZXhYL3NtaCtH?=
 =?utf-8?B?UnFoeGs0Z3ZVbThqb1dUbklibG5mYkZtS3B4WDNtR25UbGpqaTYyUUFndy9Q?=
 =?utf-8?B?Q09tbk9CRWVOT1BISkZJdXZJbU1mRXA3YTVRNHcvUG1pZUJsS3pRRXd6clV5?=
 =?utf-8?B?YXFEazE4ZVEwRzh0Sk5uZ2dQRlJ1aXlBQlQrTDdjWkVhdElCbFlIdzZmNXVX?=
 =?utf-8?B?Q2lvaEJubHhmK3NCUTloQVNwZ2VTVXpmWi80K05LU09ma1l1MjlmY09jVmVD?=
 =?utf-8?B?Siszd0h4cjFUTzNiVzVMeEgxOTdOcDBPdTIySHVKOXp2NlhiZ0VXcFNhVVR2?=
 =?utf-8?B?c0hyNFhyWVR5YjFPNkttcFVMamRBUHdXREUyOTRSd1BuVHBTYlBOSWxPMVVv?=
 =?utf-8?B?SUFRQkdseWV5ZWRiNEF4SmV1UW1SbTF1d213cEJpTGk3aThSRDdFcGNxRDRw?=
 =?utf-8?B?TFJsTTNvWDJaSlVKNlQ1azVjV0dINmM2NnZBcHNCSW5ST3Q0MHppUEh0dHlJ?=
 =?utf-8?B?dzJpU2o0TnkvTnVUenB2N0NDYUZXcElJTVhmWGp3RnRsY240L2RkQXN4c3do?=
 =?utf-8?B?MHRHZmYwdGcyV3lxMEVjNjBFWFVNdHBITXRuczIyaHVybWxPTFlYKzlmUi9D?=
 =?utf-8?B?cThjVC9uZkd5dnVDL1orcE56czZDTFhnd3FSU0swTnNMTTErWVhWdTYwMjRD?=
 =?utf-8?B?S1BBVWZIaFdycVZpZlBSUzVyL1BvbC9pV285SWVsbUM4VnozL05QVjIxcHZE?=
 =?utf-8?B?ZUszZGpUVk1QZ21SbHNaL3NZSE53K2pYcFJ5ME83dC81NUpGUlROdVFCVlAz?=
 =?utf-8?B?QnFobXZmTGhuT1V4eFNYNXNUU3pZTGhoRHlRME1acDI0d1V0Q0V5bk00MFRQ?=
 =?utf-8?B?NVNCLy93MlY4MVNUWFBJUDB6ZXd2M2pha1ZmSm51R1F2VjNmRFBRa2JyNEt6?=
 =?utf-8?B?Um5NRW9hQmdSa1V6dmg5WG90ZG9iNVhlQ2p1SzVrUGM2R2xEUTZ3M2Rhb0Y1?=
 =?utf-8?B?aXRMeUNQSGRUdEZzQUpiWE9YMFV2eXlqMkVPWTYrUE1ucDl5UEthTjFJbkox?=
 =?utf-8?B?Z2VJRmpXbXBsSzdqUU1WTUp1YmV4Tjdsc3FMQ1d3SjNlL1puNXJCb2ZQQ1po?=
 =?utf-8?B?cVZVanhPTk8rUWZkeDJzK2dma0o5U05LMnM0UnZYaGEyL0JlWm02Z2pTSHNG?=
 =?utf-8?B?bWpLUWZBQjB3T1hHL3JwQTZvRVg1a0N6L3lrZHArSjJ2UG5sVERTdXFLZWhU?=
 =?utf-8?Q?82JgowHMc/0no6gq5iHarhhSlJ82KwlWwN2M4=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4347.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?ODE1Y0VralNyUFBBZVhMUnRzOXdJdSt2eVJsT0NxbTRaT3pYUU1vNHB2UDhw?=
 =?utf-8?B?YXNDamFLQ3IxWkNBNkVtNXhLaXpxVUNmNEsrcyttdlIxZHJzc1JNcEh2dnFl?=
 =?utf-8?B?aUN0cmNpd2E0cElXaXh4UnhKQlFJMEZrbXJHd3JodHdyaXVncUswbnRiM2dG?=
 =?utf-8?B?ZEJieENRSjd2Z1NxWTAreTNWR2JlK3ZjS1RMWVB1cmhPTlVra2hDWXlKN0Iy?=
 =?utf-8?B?MThCVFc1Y1l6UkVyYXZmaU4wNTFqS2VjOFVtSlJRR0ZsckRoSUp3TFBmVTZE?=
 =?utf-8?B?bncvc3B3MTVJNkFZMlpDc1JaZUpjdHpKQk04djVCQ0JhdVlOeTVENkNucWlM?=
 =?utf-8?B?SzR4MFdVeVNsNk44V3FNajdJam9rbHl3WVQwWURUOVlkdEpmRWV2NU1kRnZR?=
 =?utf-8?B?dmo5bjl4QzJqSjgwck9HNkZCK3NmLzAxdDV6Y1g1ZHVVRzVGZjk1R2Q3NCsv?=
 =?utf-8?B?bjU4MjNuWWI4NHJhenU1WVcrSU53SXY2WlFsSDdwd2E0VHhIdVpMVDZVcjJY?=
 =?utf-8?B?SG1CUzM0dVFWeFlMcWU0NUpibFdDQ3J2bDd1LzlyN0UwTThiVitSNFFSRVNJ?=
 =?utf-8?B?WmZ2ZUcydXF2U2YvZ211UW1iRm1TdGUxU0c5cC8vMkVJN1YyK3hMUU9hN3FL?=
 =?utf-8?B?R2hGYk5vS1BPRWo0UHF2cURvVlRrYy9kdHZWU3lUTjMzd0prcjN1VVZETlVr?=
 =?utf-8?B?VE1LYmFucVg3T2IvcmYwTnV5bXQ5U3E3T1JneENIS1VqNUQ1cUt1SEpnK2ti?=
 =?utf-8?B?NXFsbFUvU2x6S0FxcEsrTTkzMEpwR2QwaWR3Ri9IYnZ2UytnWXBsY0xhS3NZ?=
 =?utf-8?B?QUlsSEhXTDZFNDZFVHpCbnlpeWwzSUp5cjRlNmFJRU5EUmF4OGxyTzByaVRZ?=
 =?utf-8?B?TE5CU2FSczlQM293Wi94bEhwSkRRU0NGendOaDZVS05mVFBheXZ1cUFMVzk4?=
 =?utf-8?B?U24rc2V3L1pZbXlUNllCbWI1RDY3QXJXbkxmVWwzclpjK2FWcXJBdi9CNE4z?=
 =?utf-8?B?OTBRY0FoZm03NmNpUFdvMVVRdmRCU2FaaGVXVU9OOE9qTkZOS2pNT011RHU0?=
 =?utf-8?B?SStNL0hhZ2RsTTVGVGlxcDdhM0lmZ3ZPUmJrMThYRmc5M2diWGdlZHQ5RG01?=
 =?utf-8?B?ZWgvdVM2WHZYTUYvbEJUem5Bb3dlRVhSeldRdm5uVHFiSnFXbUdFcldtYlJC?=
 =?utf-8?B?bjR3ZTBkOGZYTk90QSswV1l1cURiSnQ3elZ4U0J1Qm1aaW40MHdTeUxES3Az?=
 =?utf-8?B?dWhCdHd3WVVVS1RnY05ha0NYbFFuZlJkWXZmaGphRjYzSzBYR3JXTytNN3J6?=
 =?utf-8?B?QTlFNE9PQitHdUl4Z1RjYWNaN3M1cE5aVkpsbStJWTRFSmZGTnk0QU1BQkJG?=
 =?utf-8?B?YjFuVDdGUEQra1RTbWk1ZjV2Z3B1YnB5WHUzV0Zaemo5YitzSHBmZS8wUnJO?=
 =?utf-8?B?djBkMnNaa3FBWTRkTlRvdVZJd3dRZ3ZURkdXVmI1KzhtQTBTUnZnMTNSc0RM?=
 =?utf-8?B?b2d5Y3Y2RzM1MmQxWjJDNXNGaWtWZEpvaVJzRUtuVmJSZjRmZGwzSjdCR2pO?=
 =?utf-8?B?NFE4THY2RlRpTXg4cU1GeUxsUGNoTFF0bmhEYW9iajFKSzUyRDU3clhieTh5?=
 =?utf-8?B?bnhqRFgxeXRQUXpIZ0RKSGFneGtjZnlHd3pzM1pVRUVHeU4vMkIzK1BoZ2Fx?=
 =?utf-8?B?TmtuNUdlSEVlNmFTT012VG1aZjVlVUJ6YlBsMTAxbGFvTlI1QjRQTWdFOTJ5?=
 =?utf-8?B?RVVDNEUxTnZYb1N0Vjk3TWhMUFdtNVpXNUNCcjZxckVMRVlmQ2p4dFN3Ny9l?=
 =?utf-8?B?bU1SQW9tOU5rVzcxK08xMkNvb1JZWDd6SCthN0VrT215aUFnZ2p0eXUwWU5Z?=
 =?utf-8?B?Y1VYM0hSWWRxYWZqNHI5Z3MxcW1hSzl1UlNaY3hhaTY4eVA2NVpGcmtWWm0v?=
 =?utf-8?B?bVNWMmZjemtWNEFnakVwNkh1MUZSUjJRQlRCci80WXNMcTBVVEtQNFhnNzY3?=
 =?utf-8?B?VlNJZkpTUlNuMy9jVlJTNW0ySU9WRG1PVGNyQk5xd0N0RjVLZ3dSZW00TDJT?=
 =?utf-8?B?Rk9HY0xybTRmMDhoUjZ2TnJnMXFLQUJNK0JZdysvMW5vSDNPQVpJdXUyRTJF?=
 =?utf-8?B?eU04MVBnRUlVVW5LSlFyOGJieURpMWtJUGNxdG9McjlVN1o3aXZmNjhDQzJF?=
 =?utf-8?B?NFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	lR/AY/xFxObBmp+IBwaZtm3WixDHL6jeLBIYE9v44wHsDOsXKECs+g8Z70aNoseyu9A+1XVgJ3XL0m2eK1QCs0Bu8EwOQBeAZSTrvr5/0NqlY6KINbIa/2coT/yUbJzcQ99fESyc2/qQSXpgNwMoiW6BlNMwk1682agwThczRR5arlc0ndbsHQhOYo23Fpkd4l1pWfzV8R78SnlkOiMOrLIO35xJbVFXorMc6ZsR1OLFRjni7fysJZQ3MyGPiD0BwK2LMjjYElkSgU/pdPTgoZi3t4M6yHTMjx4u0WsFxoFWk1KMAS7G0EN9+sb/CkCxqWIdgSaruDFBEsrvLigS16Tzzb11bjJzXUKC/Q2sBcfvZtf8fcLauq8Wjk+rJJ22kApuB07yY0O6JECU/nudd6fwMTa2djvawkU/mt/6gku8ldke1BTvVBX/+ZWul836NQZ3pw7DafA+hYfPVuxZmLMeYE66MWzTfBWsERC0LC2i0mQ5Wm139I1zwFQCamWJHz+BH9KlNs+S7S4vzr7ZIe0hccrwNfV+HrI1R7acW7iwM+lRYMU61GgxqZL1rcUd9N8uwgjhgRg2SIPPmbDtzSU+0PU/5lDpBxc9cMpEzfM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4347.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d451d3d-1e56-49dc-d022-08dc89dc37ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2024 06:03:30.3412
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g3n1syTJbxlpqRL75ahs/ZBxVXGTJFeHN8ye/zP+KvQzrm55dcciinDyt8ucbOUJQ3PLm7SNaeQOqdkIUMZlTwgRGFwUUIwjpY2BkxQU9uw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7623
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-11_02,2024-06-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406110044
X-Proofpoint-GUID: JxHdQX-jP14Gl0w4U2nN97qY_xH-HbWj
X-Proofpoint-ORIG-GUID: JxHdQX-jP14Gl0w4U2nN97qY_xH-HbWj

PiDlnKggMjAyNC82LzYgMTk6NTIsIFNyaXZhdGhzYSBEYXJhIOWGmemBkzoNCj4gPiBJbiBleHQ0
LCBudW1iZXIgb2YgYmxvY2tzIGNhbiBiZSBncmVhdGVyIHRoYW4gMl4zMi4gVGhlcmVmb3JlLCBp
ZiANCj4gPiBidHJmcy1jb252ZXJ0IGlzIHVzZWQgb24gZmlsZXN5c3RlbXMgZ3JlYXRlciB0aGFu
IDE2VGlCIChTdGFyaW5nIGZyb20gDQo+ID4gMTZUaUIsIG51bWJlciBvZiBibG9ja3Mgb3ZlcmZs
b3cgMzIgYml0cyksIGl0IGZhaWxzIHRvIGNvbnZlcnQuDQo+ID4NCj4gPiBFeGFtcGxlOg0KPiA+
DQo+ID4gSGVyZSwgL2Rldi9zZGMxIGlzIDE2VGlCIHBhcnRpdGlvbiBpbnRpdGlhbGl6ZWQgd2l0
aCBhbiBleHQ0IGZpbGVzeXN0ZW0uDQo+ID4NCj4gPiBbcm9vdEByYXNpdmFyYS1hcm0yIG9wY10j
IGJ0cmZzLWNvbnZlcnQgLWQgLXAgL2Rldi9zZGMxIGJ0cmZzLWNvbnZlcnQgDQo+ID4gZnJvbSBi
dHJmcy1wcm9ncyB2NS4xNS4xDQo+ID4NCj4gPiBjb252ZXJ0L21haW4uYzoxMTY0OiBkb19jb252
ZXJ0OiBBc3NlcnRpb24gYGNjdHgudG90YWxfYnl0ZXMgIT0gMGAgDQo+ID4gZmFpbGVkLCB2YWx1
ZSAwIGJ0cmZzLWNvbnZlcnQoKzB4ZmQwNClbMHhhYWFhYmE0NGZkMDRdDQo+ID4gYnRyZnMtY29u
dmVydChtYWluKzB4MjU4KVsweGFhYWFiYTQ0ZDI3OF0NCj4gPiAvbGliNjQvbGliYy5zby42KF9f
bGliY19zdGFydF9tYWluKzB4ZGMpWzB4ZmZmZmI5NjI3NzdjXQ0KPiA+IGJ0cmZzLWNvbnZlcnQo
KzB4ZDRmYylbMHhhYWFhYmE0NGQ0ZmNdDQo+ID4gQWJvcnRlZCAoY29yZSBkdW1wZWQpDQo+ID4N
Cj4gPiBGaXggaXQgYnkgY29uc2lkZXJpbmcgNjQgYml0IGJsb2NrIG51bWJlcnMuDQo+ID4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBTcml2YXRoc2EgRGFyYSA8c3JpdmF0aHNhLmQuZGFyYUBvcmFjbGUu
Y29tPg0KPiA+IC0tLQ0KPiA+ICAgY29udmVydC9zb3VyY2UtZXh0Mi5jIHwgNiArKystLS0NCj4g
PiAgIGNvbnZlcnQvc291cmNlLWV4dDIuaCB8IDIgKy0NCj4gPiAgIDIgZmlsZXMgY2hhbmdlZCwg
NCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2Nv
bnZlcnQvc291cmNlLWV4dDIuYyBiL2NvbnZlcnQvc291cmNlLWV4dDIuYyBpbmRleCANCj4gPiAy
MTg2YjI1Mi4uYWZhNDg2MDYgMTAwNjQ0DQo+ID4gLS0tIGEvY29udmVydC9zb3VyY2UtZXh0Mi5j
DQo+ID4gKysrIGIvY29udmVydC9zb3VyY2UtZXh0Mi5jDQo+ID4gQEAgLTI4OCw4ICsyODgsOCBA
QCBlcnJvcjoNCj4gPiAgIAlyZXR1cm4gLTE7DQo+ID4gICB9DQo+ID4NCj4gPiAtc3RhdGljIGlu
dCBleHQyX2Jsb2NrX2l0ZXJhdGVfcHJvYyhleHQyX2ZpbHN5cyBmcywgYmxrX3QgKmJsb2NrbnIs
DQo+ID4gLQkJCSAgICAgICAgZTJfYmxrY250X3QgYmxvY2tjbnQsIGJsa190IHJlZl9ibG9jaywN
Cj4gPiArc3RhdGljIGludCBleHQyX2Jsb2NrX2l0ZXJhdGVfcHJvYyhleHQyX2ZpbHN5cyBmcywg
YmxrNjRfdCAqYmxvY2tuciwNCj4gPiArCQkJICAgICAgICBlMl9ibGtjbnRfdCBibG9ja2NudCwg
YmxrNjRfdCByZWZfYmxvY2ssDQo+ID4gICAJCQkgICAgICAgIGludCByZWZfb2Zmc2V0LCB2b2lk
ICpwcml2X2RhdGEpDQo+ID4gICB7DQo+ID4gICAJaW50IHJldDsNCj4gPiBAQCAtMzIzLDcgKzMy
Myw3IEBAIHN0YXRpYyBpbnQgZXh0Ml9jcmVhdGVfZmlsZV9leHRlbnRzKHN0cnVjdCBidHJmc190
cmFuc19oYW5kbGUgKnRyYW5zLA0KPiA+ICAgCWluaXRfYmxrX2l0ZXJhdGVfZGF0YSgmZGF0YSwg
dHJhbnMsIHJvb3QsIGJ0cmZzX2lub2RlLCBvYmplY3RpZCwNCj4gPiAgIAkJCWNvbnZlcnRfZmxh
Z3MgJiBDT05WRVJUX0ZMQUdfREFUQUNTVU0pOw0KPiA+DQo+ID4gLQllcnIgPSBleHQyZnNfYmxv
Y2tfaXRlcmF0ZTIoZXh0Ml9mcywgZXh0Ml9pbm8sIEJMT0NLX0ZMQUdfREFUQV9PTkxZLA0KPiA+
ICsJZXJyID0gZXh0MmZzX2Jsb2NrX2l0ZXJhdGUzKGV4dDJfZnMsIGV4dDJfaW5vLCBCTE9DS19G
TEFHX0RBVEFfT05MWSwNCj4gPiAgIAkJCQkgICAgTlVMTCwgZXh0Ml9ibG9ja19pdGVyYXRlX3By
b2MsICZkYXRhKTsNCj4gDQo+IEknbSB3b25kZXJpbmcgZG9lcyBleHQyIHJlYWxseSBzdXBwb3J0
cyA2NGJpdCBibG9jayBudW1iZXIuDQoNCk5vLCBpdCBkb2Vzbid0Lg0KDQo+IA0KPiBGb3IgZXh0
KiBmcyB3aXRoIGV4dGVudCBzdXBwb3J0ICgzIGFuZCA0KSwgd2UncmUgbm8gbG9uZ2VyIHV0aWxp
emluZyBleHQyZnNfYmxvY2tfaXRlcmF0ZTIoKSwgaW5zdGVhZCB3ZSBnbyB3aXRoIGl0ZXJhdGVf
ZmlsZV9leHRlbnRzKCkgaW5zdGVhZCwgYW5kIHRoYXQgZnVuY3Rpb24gaXMgYWxyZWFkeSB1c2lu
ZyBibGs2NF90IGZvciBib3RoIGZpbGUgb2Zmc2V0IGFuZCB0aGUgYmxvY2sgbnVtYmVyLg0KPiAN
Cj4gSSdtIGd1ZXNzaW5nIHRoZSBjb2RlIGJhc2UgZG9lc24ndCBoYXZlIHRoZSBsYXRlc3QgYzIz
ZTA2OGFhZjkxDQo+ICgiYnRyZnMtcHJvZ3M6IGNvbnZlcnQ6IHJld29yayBmaWxlIGV4dGVudCBp
dGVyYXRpb24gdG8gaGFuZGxlIHVud3JpdHRlbg0KPiBleHRlbnRzIikgY29tbWl0IHlldD8NCg0K
SSd2ZSB1c2VkIGJ0cmZzLXByb2dzLTYuOC4xLCBpdCBkb2Vzbid0IGhhdmUgdGhpcyBjb21taXQu
DQoNCj4gDQo+IA0KPiA+ICAgCWlmIChlcnIpDQo+ID4gICAJCWdvdG8gZXJyb3I7DQo+ID4gZGlm
ZiAtLWdpdCBhL2NvbnZlcnQvc291cmNlLWV4dDIuaCBiL2NvbnZlcnQvc291cmNlLWV4dDIuaCBp
bmRleCANCj4gPiBkMjA0YWFjNS4uNjJjOWIxZmEgMTAwNjQ0DQo+ID4gLS0tIGEvY29udmVydC9z
b3VyY2UtZXh0Mi5oDQo+ID4gKysrIGIvY29udmVydC9zb3VyY2UtZXh0Mi5oDQo+ID4gQEAgLTQ2
LDcgKzQ2LDcgQEAgc3RydWN0IGJ0cmZzX3RyYW5zX2hhbmRsZTsNCj4gPiAgICNkZWZpbmUgZXh0
MmZzX2dldF9ibG9ja19iaXRtYXBfcmFuZ2UyIGV4dDJmc19nZXRfYmxvY2tfYml0bWFwX3Jhbmdl
DQo+ID4gICAjZGVmaW5lIGV4dDJmc19pbm9kZV9kYXRhX2Jsb2NrczIgZXh0MmZzX2lub2RlX2Rh
dGFfYmxvY2tzDQo+ID4gICAjZGVmaW5lIGV4dDJmc19yZWFkX2V4dF9hdHRyMiBleHQyZnNfcmVh
ZF9leHRfYXR0cg0KPiA+IC0jZGVmaW5lIGV4dDJmc19ibG9ja3NfY291bnQocykJCSgocyktPnNf
YmxvY2tzX2NvdW50KQ0KPiA+ICsjZGVmaW5lIGV4dDJmc19ibG9ja3NfY291bnQocykJCSgoKHMp
LT5zX2Jsb2Nrc19jb3VudF9oaSA8PCAzMikgfCAocyktPnNfYmxvY2tzX2NvdW50KQ0KPiANCj4g
VGhpcyBpcyBkZWZpbml0ZWx5IG5lZWRlZCwgb3IgaXQgd291bGQgdHJpZ2dlciB0aGUgQVNTRVJU
KCkuDQo+IA0KPiBCdXQgYWdhaW4sIHRoZSBuZXdlciBidHJmcy1wcm9ncyBubyBsb25nZXIgZ28g
d2l0aCBpbnRlcm5hbGx5IGRlZmluZWQgZXh0MmZzX2Jsb2Nrc19jb3VudCgpLCBidXQgdXNpbmcg
dGhlIG9uZSBmcm9tIGUyZnNwcm9ncyBoZWFkZXJzLCBhbmQgdGhlIGxpYnJhcnkgdmVyc2lvbiBp
cyBhbHJlYWR5IHJldHVybmluZyBibGs2NF90Lg0KDQpPa2F5LCBnb3QgaXQuDQoNClRlc3RlZCB0
aGUgY29kZSBiYXNlIHdpdGggdGhlIGNvbW1pdCBjMjNlMDY4YWFmOTEsIGl0IGRvZXMgaGFuZGxl
IDY0IGJpdCBibG9jayBudW1iZXJzLg0KDQpUaGFua3MgZm9yIGluZm9ybWluZywNClNyaXZhdGhz
YQ0KDQo+IA0KPiBTbyBJJ20gYWZyYWlkIHlvdSdyZSB0ZXN0aW5nIGFuIG9sZGVyIHZlcnNpb24g
b2YgYnRyZnMtcHJvZ3MuDQo+IA0KPiBUaGFua3MsDQo+IFF1DQo+ID4gICAjZGVmaW5lIEVYVDJG
U19DTFVTVEVSX1JBVElPKGZzKQkoMSkNCj4gPiAgICNkZWZpbmUgRVhUMl9DTFVTVEVSU19QRVJf
R1JPVVAocykJKEVYVDJfQkxPQ0tTX1BFUl9HUk9VUChzKSkNCj4gPiAgICNkZWZpbmUgRVhUMkZT
X0IyQyhmcywgYmxrKQkJKGJsaykNCg==

