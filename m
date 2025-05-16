Return-Path: <linux-btrfs+bounces-14079-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF38AB9B66
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 May 2025 13:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB6A5177938
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 May 2025 11:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BF3239E69;
	Fri, 16 May 2025 11:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="gDAsmuxB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E9A238C1D
	for <linux-btrfs@vger.kernel.org>; Fri, 16 May 2025 11:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747395824; cv=fail; b=i/bYgSSiLKFgFrjBZKF/BaHNJni90DbDEM4sDTpqDVCKuaIIOYTcAX5pzyl3pwhLnO9WCEyELgu0Ycu9rWkkkmz9M6DRd2WvwehfQUfMYfZCHOAMockzWbfkNOqpAmVKcyaLaoDWAyOa8TTXBrETJB/jaH1FwpL806J0lH8CMOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747395824; c=relaxed/simple;
	bh=9SxtOzXCQAtuE1LyQ85CVXmWJTu5Zrg6951qLEMHHLA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=Toeak40wp1ErwvG/6gvWn9Zkn0lEWmoYpqpHkGu0VrL2pgS9ix+H6A2GmSl+7RvRQM706MmUJ7tdIkmpQavn+UgYLtRvfVRrJ8eyk7NLiTxniPPHqcBtomY1HUxKxSizPlW9jjDZRH26ylWuoaP5mxVW5ZDcxdWQq6bsyC9Ymi0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=gDAsmuxB; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54G7jTlw014509
	for <linux-btrfs@vger.kernel.org>; Fri, 16 May 2025 04:43:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=
	content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=OXDriG/XcQXVupN3a31A+NmHtM4vAgq17V/Qx+Ohncs=; b=
	gDAsmuxBWBuhVQ8rC80xO7DZiKiia+A5qI/X6pXG9PnE4Mt9Zc9M0HuEee76kybR
	CEJ0E8/6ELxziTY3dkLNxKf9zp+4Hg/DzbBDGJq1MW5ui59MqoB0uXTkJY4asVPT
	0SjiugPdpQGB8zvBTJLdfXUOkT+TO0aN1ZFWUl3S49Y7/s8ga/9lu3I8evUQf9HR
	6mo0u7wNY3qnCssBqnu4hz2LKd5R/gG6UHxTw27WAkfZM6fFgWVC5bKMs2RsZI0H
	ymV2VjctfAwQHLzUmLelvLnTbvjWpKC58hPkH+cT91cs3EzK9VPGtKdNV7OjDCzq
	nBUruHGPxCGpV4o7EEkRiQ==
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2048.outbound.protection.outlook.com [104.47.57.48])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 46nsdukdb2-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Fri, 16 May 2025 04:43:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dbq/Xbpky2VwVyG14t1CZSMA/64jg5G1h1ENF8b4L9jsSsFdj9VDRlKcHhBHZdDN9reODsjZx7ywIuKqzl0f17PexPEe91dADY8Pf21sZ4VtkZQdlp9ODhljdSU1TcmcoJNROc9DuWmMImgkSEfhCGrvKzuuqdQT1QWfloaLVMIeRyBQt4BwLF2dtEZ47RTqb1cZM9A7ek11KqoJ3JPjkKKxaIK0yKa5RgzeoORE/43R9o/UjBRdzNDJsSOoPLOIpYdaCAa8ktPJtK+5ttW2VkDnCG/hqtl1m5cWlSF2vA2N2AwP8jWxDdslx9KVt3EJDFj2jDBpwVAz1gATHc5Phw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xL/ERX8bn221CxgI2fyQ+0MVAv0YN0WeAYlH9Wf8yKM=;
 b=a1mDh7dNcLFWUd+tzGD5j0ARg6L0dteqacXTz6+sD4fHLxYSkDUNPz7EbWd/zy+aLFzbCq+LwhyPxvX4ayjsoQCGrRtzS1FsUDtrHSFAttTBy35QciurD4vHQ2dxMq1W03NBTNgk5qlJYCcTuC1O1Y8EKzgxyb07KyUPAquW4doRu7rLutPrBXDXwlKgc4rr09eiPwAc6yu4g6NiYgBnt7sd/ALu/0aJKD+gIA/sYaXVK9S+BW+baByv45ry8ud4wkviPtNI7H2vtH3372TRK01O4E+mGEYJN1vR5xMCzD7WW73iFgKnahIxqcw5ipcLRIfB8EujMqVV8EHbkSF4RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com (2603:10b6:a03:4c0::15)
 by IA0PPF5259F06B7.namprd15.prod.outlook.com (2603:10b6:20f:fc04::b1e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Fri, 16 May
 2025 11:43:37 +0000
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8]) by SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8%4]) with mapi id 15.20.8722.031; Fri, 16 May 2025
 11:43:37 +0000
From: Mark Harmstone <maharmstone@meta.com>
To: kernel test robot <lkp@intel.com>,
        "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [RFC PATCH 09/10] btrfs: move existing remaps before relocating
 block group
Thread-Topic: [RFC PATCH 09/10] btrfs: move existing remaps before relocating
 block group
Thread-Index: AQHbxbeTvk5pZcojQ0W6S1YOKxwu17PVAiAAgAAh9QA=
Date: Fri, 16 May 2025 11:43:37 +0000
Message-ID: <9cfe187c-efce-4449-be3c-72ea584b13f9@meta.com>
References: <20250515163641.3449017-10-maharmstone@fb.com>
 <202505161726.w1lqCZxG-lkp@intel.com>
In-Reply-To: <202505161726.w1lqCZxG-lkp@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR15MB5669:EE_|IA0PPF5259F06B7:EE_
x-ms-office365-filtering-correlation-id: 279529b6-7a60-41d8-35cf-08dd946ee564
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MnNMbFR2aW9yVTdhUnZKaHgrRUw0MG9GUzNFcW1SZTQ4MFdvT0svK1JOZW5i?=
 =?utf-8?B?bVBXck4yTVc1a1d6ZkNDM0VkRTlWc2dzaFREMWpJalgxT0hEZUpWSVkwNlNS?=
 =?utf-8?B?Q3A3N01rdldTSUlRcGRlMXFzQ0JBSis1TndlaFRmTXUxNjFZdGNjcTRtbWJW?=
 =?utf-8?B?MDZiaXlMRk13b2w3L25VYm13OXo3VFA5dnJ1WFlzTC9KRzNDK0NEblNsbDBm?=
 =?utf-8?B?anE5b05GZWV6Vm1EaWR5MW5iSGxDaEl6c2ZEb2p6aHVuQzRqQkZkbEJSUG5z?=
 =?utf-8?B?aElKeXFwL2t2LzRlTEFPQnA5MWwxZWd0bWR6Y29LSEYrZE9FMDIvZzlrMXAr?=
 =?utf-8?B?YnBNb3oyUDV3dy9xSDhZT3NZQzYzWEVRMyttelpPYW1VQ2QxV0RzWk12eTNI?=
 =?utf-8?B?NTQxeGxBNmlaWEtSOXkzVE1DLzZNbHUyWE4vYllZQlNkMlBPVTdGcUJwVktJ?=
 =?utf-8?B?d2s3dHo5M0xTOVczZzZMaEcvenNJeEFobjIzK0YyWWN5bjUwblRHY2pseWZq?=
 =?utf-8?B?Y2MvQ0VHSjdSK0ZBeXVHc3dNWnJYNFU1dERjWjhFajY5elFnUHkvdWNOcmNp?=
 =?utf-8?B?QXplQjFOaDFJd3AzYk1pNG8yWXdMVFk2c29pQjlLSHpmd21jaDRPTTVGb1lB?=
 =?utf-8?B?Ylhxek5ReVZSUjJxZk9jMCtTUnFOUWdic3pRaXphYVhYbEVaTTdCVW5LRGtL?=
 =?utf-8?B?UFZGby8zSWhwRTNFalNOaTdPOXNGNUdBR0tvTG0yUWlkZ2JmUldzQUk3N1ZQ?=
 =?utf-8?B?endrTzgwTGx5R3k3K0xCdGxISGpHampVUExOWWdsWWkwd2g2NXZreFlXUnNm?=
 =?utf-8?B?N2podkpPck9Qbnh5Nno3QWprZWh2MVVhelIyK09sTHkxS05hMWt0b2RZQ2tn?=
 =?utf-8?B?TXFpdlNSdWVNZlBCZGNaUUhpZENSeW1HKytJUEVYSzE3U2NLZG56S3ZER3l5?=
 =?utf-8?B?emo0UWZHZTI0ZVh2aTBkaWVycnFUWDA3MjMwbWU1YjdyMml5Qlo4RHdBMUJh?=
 =?utf-8?B?U0lsVHpoTm1JNmVTSUxudi9EQUw1WEZQMk9uUEJEYW1qdXJxcTlPMFB3SHQw?=
 =?utf-8?B?QW1VMncwdXk1TGpKT3BDdG55ZlpqR1hlbFVncHp0YW5SNUM1bHV0N2dBRTZ6?=
 =?utf-8?B?NXgzQVlhdEU2VCtDdHFXaEFxeWE3MEt0RUQrMjFtK21IK0hYZ1Nma1ZtdXBx?=
 =?utf-8?B?enNXZnFqbUQzUTArRTN0V2JPUUlXVkJ0a3pCZ3c2R1lwTnUyd295dnF0VHlu?=
 =?utf-8?B?NStMRm54OHVRYkJyMlJwM0d4TDhFVjlrNkk2eC9SSWNheG81dUQySFdEL1Zq?=
 =?utf-8?B?SDh0RW5CRzE4M1Q5dUJLNW1mT1QrVVd1SXl6T1JjOHF5aE5wWVVxSTlFQUJE?=
 =?utf-8?B?aDFxeEpGcVNnelpSVjF5dTQySzJKRXJMWXViSVkzZko0VFZ5d3A3MlAzWFI0?=
 =?utf-8?B?QVVjRTVPOGRHQ21NRkwvOHpWNHVubVlhK2JOTms0bTkvNGtrSk1sRDY0RlBw?=
 =?utf-8?B?bHdzL2RRcU9YQUVnS0w2UEQ0M1kzeFlJeWw4dFk5cldYYkVrSTRKQ01nSms3?=
 =?utf-8?B?SzZIYm5FdW91aWltUE54STFreU5MWDhTUUJGZ0NJdnNadk9PRWVlVFR1Mmta?=
 =?utf-8?B?emR2UUNCby9uUWlGVlhWaTVGSWFGdnV4djUyb3llRjdoc1RPelVLK1hNVjRV?=
 =?utf-8?B?UGZvN1Z1cDdnYVkzVUk4VC9tYVNXNGNMT1VlcTFhM25BalZpbUd1S20xNnJm?=
 =?utf-8?B?U29MdkozVnFjMXdGWGVZSUY3UUgxSXo5Zi9mbS9CSWl0R2lkdUtCS214eUpp?=
 =?utf-8?B?cHA0L1VyNVBLR25JMEs0S0d5QUlPNk1pRExiRlREenNXcTIxUWVXdE4rZVhC?=
 =?utf-8?B?bDhXdUhVM3NVOTF3c0ppd2xvZlpiN1N3RGdWZFJzV3pXdDFFMC9tMmdtNmFq?=
 =?utf-8?Q?fx492ZFzI8AOWCmk7b2wMttWHwHWq7aU?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR15MB5669.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U3JwU0prM1FmcnRDcysvZVlReWJzQVJRbFhDOHplRWNCSldBNmNKMlA3eFpC?=
 =?utf-8?B?bVB1QU14TE9LZVJ4RnZrRHJoM1o5elhwRXMxRmtCa0xtNWUzbmV6RnVWa0ZR?=
 =?utf-8?B?NU9qQWtwSFpqU1dzallHeG5DdUtYaEVUbEtYaDkvOHNreHo1STFCeHJHVE1X?=
 =?utf-8?B?K050TnpZSHlJSC9CaEljY1RJMCtuVkl6cWZHSTF0cWQ3S2Y3VVBQLzcrMm0r?=
 =?utf-8?B?U2hIOFQxMk9QelRUTEpLNFJWL080VkEzZHhhSzdYZG1pRnpGWUFST2pPcE4x?=
 =?utf-8?B?ME1LRGpCVkNSQjQwMVJwdHVFSVVNbDNzcDkzYWRzNlJIL0VkdER4QmtNNmRk?=
 =?utf-8?B?dlRIbHFFTmhaKzJVS2hxSVRnTGpmaEQzb2l0bVFYcm9ySHdtUHFPN3plTUNw?=
 =?utf-8?B?MERZRldDcFNsZ1RYWXc1b0NzL1Q3MXo2RXM4ZGpjYVhpQnduTWFVdnphejhs?=
 =?utf-8?B?UmxSNnNvZEJYZHJ1bDlhd1VscldicS94T0FKN1FOKzQ1ZUN4WUtkcnVyVDZU?=
 =?utf-8?B?U2xqNmhjNmEyamwvTmVQbmxsaGgwamIwVTRqM3AvcnJsNWdmelZ2cW9EMTRZ?=
 =?utf-8?B?WXV0cXlQcFZRQnNBZTZEdXRQcDVhcjBlS0JmV203K3ZMYXZZRUdHMk5OM0Fk?=
 =?utf-8?B?ZzV2L1JiL1NMa0EvWmZtQnlwT3lWd1kyMlh4UUptWUc3WHY4YW9uZGx1QVJo?=
 =?utf-8?B?MWlsU3hKOEpZbzBpTGFab0dlNTFESDgrbDJDUGc0M3VDVnZCUGFxTkxCMFhT?=
 =?utf-8?B?T1hncldQNjV5M283aFk2SHVHeHFNMjJPSXpMTStSMkIzb2RZOU50dkZDK01I?=
 =?utf-8?B?MFJ1NEpFNTF6dWd3dHorWmhQdm5hVnJ0eldVTkpuTS9RcnN2UWszS0tDMnFu?=
 =?utf-8?B?WkVIVEdJaDN0bllOa3A0UGxkbEg0WE40bHEwa2l0UTlLbWpsN1BoVk16cHpj?=
 =?utf-8?B?N1VRRmJpNGU4VDFuYjU2TTlwNlY2aVhHSEd1Q25EY3BqOXlPUU1XQzlESm0y?=
 =?utf-8?B?S2FSYkU5YWcycWkxa1NrRktlekU2UE15VEVjMDhjbllnMFI0SWlwUWl1ZWQ5?=
 =?utf-8?B?SjdLbFpkOVFvS2RSSWFPeE9NbUZhMkdGVFNQNGlOUXRqcmw0dlE2OE0rb1Fk?=
 =?utf-8?B?ZTdNQ2RJK1dOU2tvYVlRN1luaEczdW14MExWbGNQSG8vc0l6cVIwckVhaE1v?=
 =?utf-8?B?UG1pdlo4aEU1LzhxbkdEdURhTVpTWkZNNHBnTXpreWFDdy9VZk5BeGlIVVBV?=
 =?utf-8?B?T25kUXAybjVaQU0xUEVGVENDWk9GTm1RdzY5NGtWNStwQkVpbTA0NGJ1ODcz?=
 =?utf-8?B?UHhHZnJMaVJjbkhJSERWQU1QMDhmbnc4V2EreHVjcWFmVmpFZjJYZ0I1RHAv?=
 =?utf-8?B?S3NYbmhjTmxaaGM3akpLZU4raFRsUkpIciszcktzSEJjZ1drbXArVi95Z2Y5?=
 =?utf-8?B?TUxQeE5FNDcreGZOaE1xUkVRd1M0VUM5Y1ZML2VmN3FoZ1crRGpuOVROSWE4?=
 =?utf-8?B?K3hTYjhzSTZMdGk4SUR2MnZvSnBLOXYwNll4NlYzU3pmVEw3Q2F6bzZTbVh1?=
 =?utf-8?B?cmlMY1UrVVI1NS9aZzRBRWhIazl6TjJXcGwyMnBDbnZRTExhR2c5NFhqTEw5?=
 =?utf-8?B?TndHcW9UemVHNDdmN3Yya2kzaHY5eUVZaWs2akwrSkRvWnFOTGhiWDFiSHJh?=
 =?utf-8?B?VzY1UTVhLzROeXVBVE5NdUN2NEJldWdSL200VDdtaks0TVMvanoxYWd0OEIz?=
 =?utf-8?B?bFdXRE9IUDdSeS8vaTY1a2FkYWY3Umg5cmRhRHpqUGI4RUZzZ3EvcnJTMWMr?=
 =?utf-8?B?UVNuRE00UzhjbUtwNk9PZ2VES3hXajBCYlRtdEVuOFBZNklWUXZVSk1IZ2dC?=
 =?utf-8?B?YVN4OTNkSHpkSFF1QUFtV3R0M1l5K0R4VzEzb1ErZTZEVWo4Wk83SjZTT3FM?=
 =?utf-8?B?NFEzVTZVd2ttdVczN2dEYjJlaXlzeWhaZ2YxYzlrcVVxc0s4L0VOZ1lPMXdo?=
 =?utf-8?B?S0RZOVc3RDNhU2lVRzhEK3Rmek5NeUZCL2g5SFNXNXhtTnhKOElSVnp0emg2?=
 =?utf-8?B?QWFWR0x2THdpMVV0RFFpMFNVRThjQmptUDBRejBOK3hDeUE2RjlDOTdkMnhX?=
 =?utf-8?Q?aIYg=3D?=
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR15MB5669.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 279529b6-7a60-41d8-35cf-08dd946ee564
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2025 11:43:37.1936
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o0MWAyISafBCW2SMSOyx1UYgCLehO1FoKpqceE0F95TuHKA3jR6ob/ayBdRm7nYUfRYiDAMUdsqT7Y7n7nt6dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF5259F06B7
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-ID: <DF201951DC3C1E409FB0434DA7046DCA@namprd15.prod.outlook.com>
X-Proofpoint-ORIG-GUID: i-jHalEX7IobVj8w3kgfA7K5MI2KYKsW
X-Authority-Analysis: v=2.4 cv=cZzSrmDM c=1 sm=1 tr=0 ts=682724ed cx=c_pps a=l5p8UTqLmUd1ApN92JXWiQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=anyJmfQTAAAA:8 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=FOH2dFAWAAAA:8 a=i3X5FwGiAAAA:8 a=QyXUC8HyAAAA:8 a=o-2g_wVk12G3IjXy7ngA:9 a=QEXdDO2ut3YA:10 a=mmqRlSCDY2ywfjPLJ4af:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDExMiBTYWx0ZWRfX9JzvIH3YPkQh 8J3YkqZKNfTW21UGNPIiX+c5T/yWt4oIcb/nQUuHEOM/8IONG2/MqBxf9V+7PJ3Rq4saX6B3Ia0 IE8woAtIeg5sjeZT0fOJZaCoEfAtsBplyeVVsvOD+pG9Se7FcWLq79w9IHjjUv+vdI01iyjfn3C
 eXmkBAsEilNz0RHhiXnHkCWLSbavGyyYrqC2VVKw6ETV7pjRjVlzRZf0qDvhMRJYAF8kEEf6y2P L3gf0gezLgdrNKbH3CsEbiOPE0yH+s2plUuw9wGpr9HgaT9TNAoFWcrQnh8j3AFeKeTZoHTsNnD HRaUcdcpVZxe1rpSj0PN6mvnsggrlM1gRxX7tPkygsftz3RmQyLmKjiKhOqNRRmJ3ioo0VmuUj6
 KJAR7d4sxJ6zEZ1rjH7ULwHSf7NloCrmWH0QIOXh+XXGhBbHK3pn2fWFLDFPMjHFcTL09eLQ
X-Proofpoint-GUID: i-jHalEX7IobVj8w3kgfA7K5MI2KYKsW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_05,2025-05-16_02,2025-03-28_01

Kernel bot is saying here that I'm relying on 64-bit modulo even on=20
32-bit processors, which is easy enough to sort for the actual patch series.

On 16/5/25 10:42, kernel test robot wrote:
> >=20
> Hi Mark,
>=20
> [This is a private test report for your RFC patch.]
> kernel test robot noticed the following build errors:
>=20
> [auto build test ERROR on kdave/for-next]
> [also build test ERROR on next-20250515]
> [cannot apply to linus/master v6.15-rc6]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://urldefense.com/v3/__https://git-scm.com/docs/git-format-patch*_ba=
se_tree_information__;Iw!!Bt8RZUm9aw!62MBgtgUBKJiRzdqPxiQTuw-_8GZHkeBKL3gkY=
vxPzAhENOx0BjCPNqmDBzj50VZzLPMMjlG$ ]
>=20
> url:    https://github.com/intel-lab-lkp/linux/commits/Mark-Harmstone/btr=
fs-add-definitions-and-constants-for-remap-tree/20250516-003914
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git  =
for-next
> patch link:    https://lore.kernel.org/r/20250515163641.3449017-10-maharm=
stone%40fb.com
> patch subject: [RFC PATCH 09/10] btrfs: move existing remaps before reloc=
ating block group
> config: i386-buildonly-randconfig-002-20250516 (https://urldefense.com/v3=
/__https://download.01.org/0day-ci/archive/20250516/202505161726.w1lqCZxG-l=
kp@intel.com/config__;!!Bt8RZUm9aw!62MBgtgUBKJiRzdqPxiQTuw-_8GZHkeBKL3gkYvx=
PzAhENOx0BjCPNqmDBzj50VZzMhIuygf$ )
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=3D1 build): (https://urldefense.com/v3/__https://d=
ownload.01.org/0day-ci/archive/20250516/202505161726.w1lqCZxG-lkp@intel.com=
/reproduce__;!!Bt8RZUm9aw!62MBgtgUBKJiRzdqPxiQTuw-_8GZHkeBKL3gkYvxPzAhENOx0=
BjCPNqmDBzj50VZzNUkCx9l$ )
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202505161726.w1lqCZxG-lkp=
@intel.com/
>=20
> All errors (new ones prefixed by >>, old ones prefixed by <<):
>=20
>>> ERROR: modpost: "__umoddi3" [fs/btrfs/btrfs.ko] undefined!
>=20


