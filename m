Return-Path: <linux-btrfs+bounces-10737-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E6DA02539
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jan 2025 13:22:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E9251636F4
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jan 2025 12:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34B61DB95E;
	Mon,  6 Jan 2025 12:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="fBiHGrBZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECC51DB92A;
	Mon,  6 Jan 2025 12:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736166147; cv=fail; b=CdnfiZHggAsGoSAbYEiD0ILSP/iO2ecnIJY8EyA7VLfKdobjLRby22yOAS9nrJzL3IcsUBFPrmCpSR4ALX9AzLtwVbxvGE4WzbcA0/d8BqrU3PiQnNCmU8/2twbEaE0/x7Kbm7NglFF16JTTkX3CKZs1/1aBq31ul0x3jBQOq4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736166147; c=relaxed/simple;
	bh=X67r82YPepPvC0hF1WzCIpofkMC98fPxJHpI/w1HcFM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jV5JEY6w1cooDhrfPPwxyh9H14StchECafOUxTyoHu8C6L1YBkToI7eAB+4h5dM2nf364mz3sWiX9nRHB8prxnuFX5b1uCQQSoSf00Z5SjWfyshYfhlJhrrAjN8PVgw3UIA69qpQ1Qk4ix6z0rQpYy+FFzEC5QRn5VJjY+pWHEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=fBiHGrBZ; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 506AFr6b016249;
	Mon, 6 Jan 2025 04:22:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=X67r82YPepPvC0hF1WzCIpofkMC98fPxJHpI/w1HcFM=; b=
	fBiHGrBZr9ITPa5q+6/afNGaUQovW3SCEiR/iGQNLM/7gf3OTr8UD7oH6D73eiL7
	A4Uw+9LuCZXwFqhX9iDBVznBXJW+tdc5WBf8lcZ/SxDIoglZ7a8RlBtILCjOb9TR
	AxBB4WFq8dmUJp4yLvrIsEh/wYFnns7sMpeGTOqwhn7sSIR1tYjLMax5Nlo2V+6L
	pbizM6maGvL7eQr62e7ie8d9z+DkdzoeGZZMqz6CfO953iSNK7LbFA0mr4hcklOw
	IHhjUZXrgtx/clHtK6lcPiGZEUzGnOY8r5OdwfkB23i+5vBWhHeb3Mpe1hod4ZrZ
	/0kW1yIC8fsHTI3xSEUKVw==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 440d8prh5u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jan 2025 04:22:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rfRbcBd2amKY8/i0SdDsY2PznemmAnayHmWn4092zL2H2DKgxy4osky4hNqXoThJpqeql0fgYjMEVPsky3vtwKxSLeEtmNpeEEG84haw5H/gkH9BSyCj+TIPwxH4k5mdfYDzH4TxiIR5fU8GPxMektgbVTf5wfHidobNjljmXmVPoGkAS1vSr/WDMCQsJKNJAGQcoT9lM15q8A0LHLkOTw4Yd203QAeGgQroWibBvgECTGVlkaKDD8h+/ZT5yWMnnMgXRWaftbmpop1/mc/8U3aE8sfFaSpnTpZk5LefrhRAWQwFNFoJ2gFfBgJlwmCVn1wbJ9p3T9k3boQVgBa7Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X67r82YPepPvC0hF1WzCIpofkMC98fPxJHpI/w1HcFM=;
 b=MlIAWoXfzEcYvkCP0zVu8Tg2ZD+5hc6caBcLomxUvjIl3YEbgJzIICPNWQQo2j/YLFasRe8QWh24d2psLT6KwbzWb+NkZUbKQ7UhgQtfYFKI0nyU5leTHbSzOnShzh8fQzGZ9yBuubjAvWNP5Fn0CkpClFODw+/r3iJqoe7TPKrGWydSSRd0z7cKxr6K2/xIjrIOK8sDzo9p6gKxGvzdqpVYaNIv2NkFd4Qb5SofxrPrnTD87VJNV4XUtvvHeTxvTFgGY3dBkCHQL9DxdZQSUb8YX7iRjDl0UgbkmO4MKyDFbnEkk6+fr/AJqaDfvs5dezTrjlELzsPkPGQiG5OaCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com (2603:10b6:a03:4c0::15)
 by BLAPR15MB3889.namprd15.prod.outlook.com (2603:10b6:208:27a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Mon, 6 Jan
 2025 12:22:15 +0000
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8]) by SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8%5]) with mapi id 15.20.8314.015; Mon, 6 Jan 2025
 12:22:14 +0000
From: Mark Harmstone <maharmstone@meta.com>
To: Anand Jain <anand.jain@oracle.com>
CC: "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "neelx@suse.com"
	<neelx@suse.com>,
        "Johannes.Thumschirn@wdc.com"
	<Johannes.Thumschirn@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v3 2/2] btrfs: add test for encoded reads
Thread-Topic: [PATCH v3 2/2] btrfs: add test for encoded reads
Thread-Index: AQHbUiZAIn5LmtYsIE6yK+AKtJrmrbMFUHsAgAPPqYCAAKbLAA==
Date: Mon, 6 Jan 2025 12:22:14 +0000
Message-ID: <587c35b8-eb77-49e2-8979-37a5a3a31427@meta.com>
References: <20241219145608.3925261-1-maharmstone@fb.com>
 <20241219145608.3925261-2-maharmstone@fb.com>
 <20250103161314.GA4067957@perftesting>
 <174a47bc-2ff4-455a-897d-39316352d444@oracle.com>
In-Reply-To: <174a47bc-2ff4-455a-897d-39316352d444@oracle.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR15MB5669:EE_|BLAPR15MB3889:EE_
x-ms-office365-filtering-correlation-id: ac063587-4f1e-4357-febc-08dd2e4cc10a
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|7055299003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OVBRZHV6YjRmQnZ3dUtHbjFPRnFjSUdyNGVKWXBjTGxjMFNxblIrYVU4R3hX?=
 =?utf-8?B?UmlCdElzb0U2YkdrRnZLY1hkTXlZNnR1OWdDc09ZS3dvdjllM3hRRE9ySWFO?=
 =?utf-8?B?Z2RnR1F5Z3dDcG5YbHprd3VXVU5rRGphZEsydDc0R21aUUhOY2piMzhHSUtG?=
 =?utf-8?B?dEZ5NE1xTkRYMUhVYW5yU3dEdExEa2srMjM2L2VoNFczZFZXYWg5WUJieXZm?=
 =?utf-8?B?Vk9tTDhXNUIxMHJkTFp4TzNseG9tNjNRSFY0bEpIUldmQndPYUxSRFpHMXJX?=
 =?utf-8?B?MXcremlQcGl2b1d2V0xjZGJxK2sxRHppN2VNSjdKRzVkTFUvNVNGd1d5eDVZ?=
 =?utf-8?B?K05SYTk2bEpDdG40VjNPL014bi9KZVpIOTdTM21QdnZOTkw5NkpzNDVXb1hC?=
 =?utf-8?B?MTNjWHBOOUdVQnU0WllWa3ovaXhMLzdVVzRRZkJ2NXJvQ1dFV2hrSHZ3dFg3?=
 =?utf-8?B?eGJqUXMzYkR3aW5lTHBiRWQzTTRCZkVSWGFQVHVvSVRLaGxDU2dHWnUzdDEx?=
 =?utf-8?B?UDVtUCtvdDVIZHNsMkpYUnlmejNUZksweW1hRSsxQThxZkFqeW1EeXNCNzRQ?=
 =?utf-8?B?dzA2emdQZ21uSUgrTmFIYWJXRENlSGRldEF1cGhjMStQUXJBWDdRMytoVlFh?=
 =?utf-8?B?aTFVNXJNQzBHZjhzUjBEUlFMNFdkQTZVWE55VTJLMVo2UStLRWRacWY1QkNk?=
 =?utf-8?B?eGFQQm9LcXdsaVFmdlZVMmczNys4VFYyYlJmMzFnWEtHY0lqOVJtUVVYdk9F?=
 =?utf-8?B?eHlvV29sQ2VIall6K3cyS2dqWHZHSysvV2RMelVnZVpmT2lwTTFzTkVFaE05?=
 =?utf-8?B?OTFHTW5tRnpJYUtuYXphbjVQVTIwVzd3UGFpUnZxRXlUd0hPY1dhWHEySUM4?=
 =?utf-8?B?K2xUaGg1UmxXNTNueHFjbW5RVzJieXZPNHdVU0hzRDBZQ1NSMlRPTTdNdEtE?=
 =?utf-8?B?aVgycUxhZ3FUdzI0VkQvenJ2d1NEWnFWMXNNOWF0RVU2Smp0OFAwVElJZW9v?=
 =?utf-8?B?UkRBUHg3TUFmWHppMGZhT1F1b1VhYlA3L1VRbmtQaHJxbWZkWkxDaDhZaEFz?=
 =?utf-8?B?MDYyNUF1Q1c1SXAxb1diNWdhODB3Q290UHAzSmw3eTZzdHdObjZ5Qm0zNk55?=
 =?utf-8?B?VHVrTzlHQ3NzRkFQZmRjYytEU003alpuOWJsaFRKWEJyL01PbUo3VWRSam5x?=
 =?utf-8?B?WkYyMlM4dVBxYWhzZ2k2b3dtS0UrNksvaytRTWZaRHIzUmxiekQvdGpqSlhY?=
 =?utf-8?B?RmtpaVZBc3dwQ2tITS9hZjllYVZQVU9uV05aNGFJTlA4UW1IMkFQTU9uRFpT?=
 =?utf-8?B?NzNYNmhQTllzbnZtRkx4enMvTXd2WUxTOUpmRlI2R0ViaXNHdTFxakt4eG0x?=
 =?utf-8?B?MVlUTkt6dEEybHRSWlNxcHBBTzhhdkY4ZGM2M2k5TFBLWnlDcjZXV3RQMG1m?=
 =?utf-8?B?dHcxazE5RnBHSEtlUm8waVBaQzh0YjNjdUd5RW1MTEV3eW5aUGRIdFk3MzFO?=
 =?utf-8?B?dHc0NHJWbUJKWE9QNHBwc204SGROK3IwL2U4cG5mZHVCWWlJbUZZZG10NVVU?=
 =?utf-8?B?SW5YWU4wZGVmR1ZMb2REdlBCR21HR2JWWjQrNDZJZ2NNZ0dVYTFJZXIxSmwy?=
 =?utf-8?B?cmdpTFZDcGJxTXVjTXJMR2pXYjdyRzd0a3lObVI0NjNQSTNkZlhxVXZ1VGN6?=
 =?utf-8?B?TnlrWVJNd3lwWndueHBYbmhhQ0ptZHZ3Mi9oSWFyZmpRTGJuUHQ3dDNyTUNM?=
 =?utf-8?B?dUJqdHBIZXVBMFFtYzFQaHc4TTZBSFB4WXNPbUM0aWhmM3hYQ3JrMysyc2dl?=
 =?utf-8?B?ZEl1NXJtYUZLdlZKRW9uV3BzbFhQcjhuY2tacm5BVytkcjZRM09RQ3dNSUp3?=
 =?utf-8?B?M3R0NzJZTFp0SEM1VWVacm50SHdPWEFpZDhXeDFxNzNPeVpTSmppV1lKZ0Js?=
 =?utf-8?B?NUlBMW4wQktrMjk3V1Bza1ZXQ3dubXJBVmFURHd0ODlNRnlOV2tseG9zVHRi?=
 =?utf-8?B?V1dLdEFCcm5nPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR15MB5669.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(7055299003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZHJkTmd5dFVoRUFwM0F5VUJxMlA5dUNTMUx3MHZqQytCRXcvZ3hERFpyZHVp?=
 =?utf-8?B?SWN0OXZjTzNwU3huclJ4dzQ3MTlzOE5BcExBbG9aMGV3MUdXMWxVUXBjdkIx?=
 =?utf-8?B?T1llVzBlSTd4dnBsbXpuSHMzdjZKejh5dGxZaVNtaHZYN1dJOCtBY2FBZUZq?=
 =?utf-8?B?RGZwdEZrT1JYaUh3c0IvcWZVOTVmcGhKaFJaUlJsZTVNaXVZbFNIU3MzOE5n?=
 =?utf-8?B?Q0NKdm9IL29tTllEQUVKeUd6OHJTSnlXQ09RcjIzZGp5TTMydFcxdWoxZTlN?=
 =?utf-8?B?aDR0MEcvUllzLzNKSW9kd1J5ZmY3YURkMEc0eXkzaTRWbjJyY1dQMkw0OSs2?=
 =?utf-8?B?ZXFpK0FoZUtQNTE3WEc0dnR4MWdFTWU1blZEd2RMMEVvdnpkN2k2SXNpWE96?=
 =?utf-8?B?cEE0VlRDUmVZZzBuUmN0V2FhWlpNYU5WdXRMb1diK0VMa1lYQW5nUjlMSEpN?=
 =?utf-8?B?VTNKY21vZm90QTdqMDU3elNDYnJZK3dFQlRSZCs2SlVOb2VPcncrUGJTT2xO?=
 =?utf-8?B?bzZ2VHAzaVNzcVlQYU5VK01qYWMwcTZCdFg4SFJwUStyKzhZMWVFdXRQQWJR?=
 =?utf-8?B?SnVGdS8zWmloSmtlWVVkd0FvcWdzUFY1em43eDEwbFgvVzRNL01GVE5lN2VY?=
 =?utf-8?B?dFc1QkkyOVJMS3FzVGUvUHY3YkU5R1gycGIzeHpIMWp6SGI4anJ6U1preVYx?=
 =?utf-8?B?MXRvWGpCUzZIVnhGckh1UW5GQm8xOEZGd0p4dENUNTI4NktSU1FkdklTeHdO?=
 =?utf-8?B?UW1qRXU1Rmx3ajI4MGsyTGFvN0pnYUpIRDB4MU9CVlVLRHpRR29iL3haODEz?=
 =?utf-8?B?RDR0RDQvdjFZbFFsakl0WnhxY09INUlxS3IvcTFkYUVReXFZdHlLSjN1WlVZ?=
 =?utf-8?B?Q2pqT2ltQXlYKzRaSFNyMWFHSFZ1WVFpWUgxNENWeFJNVlEyaS85OTlEcFIx?=
 =?utf-8?B?QkxaSGdJM3ljOHBuMWpHNnlLaUwxL2t6cWppSVlQaGJGbDNPYzJ6V0NVUE5n?=
 =?utf-8?B?V1lYZmlYWlRqdW9ybHRBaUNrdU04QWRhdENOc0RLQmMwOVNQZ2x5MHBZcnNh?=
 =?utf-8?B?WEpWbUlXVXZVekR5eDlHRit5WWt4cUhmLzFuVEZKa0pNRDlMVS9OanlhWGdU?=
 =?utf-8?B?K0VJTDVyWFQxUFFid1RlQ1NwU3FLcEthUzgrczRyOWhHOFk3dVpseVBpclRD?=
 =?utf-8?B?MU9selp2eC9lRENMcGxlbzkrM1RrU0tkNlZLMnA2NzJqUnhGamJrNzhrU29o?=
 =?utf-8?B?cUZlVHR0VDJpbkZPRE0wM2l5Z2p6cE40MFNDcHRyL0wyODUxcE1SbG51WWo2?=
 =?utf-8?B?ZTlWaUxLUXRYVzYyVmkvR3kwTXVqVzk2cFdjcDB0ZWhJYlNoTG1oSk1ubGRp?=
 =?utf-8?B?WVorRm4zaE5hRTdISThNVjdsdkdLd3V2TU5jRmtWZUkzZFlMK1huNm9NR3dG?=
 =?utf-8?B?cHhtTGhsYTh4SjNYVzRjZDFBcjZ0UGxqWWtub2JiRzRzUHgvZmxZUTBDRVlI?=
 =?utf-8?B?QmNaQ0lTTm8rc1ZyUXM1V0lPMWQzcnkyRnorQlNiRlBGU1J1aXZXbzBVL0Z4?=
 =?utf-8?B?QlNmdmZWai91ZnhwUlorZnNueWRZWXpXVWd2L3lDU3dtdlNINkljSlBvN1Bm?=
 =?utf-8?B?WlZ0bTQ2dXU4NXQrWHNGZFpXZVhGTlM0NlNIeEU0SG04ZjU3TGd1enBzTGRH?=
 =?utf-8?B?K040Q3ZVeG44TUdmTy9lUW01ZjNFUWkwdGo4SDEvb1ZITW1jd1lEWlkrRkNY?=
 =?utf-8?B?VFk2Tk9jNkU1YTBmVFdYMmo3U2tNQ0plbVhBMForZWttSEdxOWJvKzY0QXZn?=
 =?utf-8?B?WTczWFNWRkc0TldocEVaK2tDMEIvc1g2NVg2ejFaRHRUcTN3T2hvQjl5OE0y?=
 =?utf-8?B?bWw1NnVHcWtETU5aY3VRbDlzM1o0eFVuaVNCNFR5bFNad0ZwQWRvQmdZTytE?=
 =?utf-8?B?cWpqa2tuWUpxTTdhU1IzcDB3ZWwxd1p2QWZCSTk2QWNSalNJSTZqNklPTzRY?=
 =?utf-8?B?MzQyLyttcWtDbXhuV3cydmt4NWNVdmxFU3hiWHN2L1lEeHpiSHBsVlZ5NXpV?=
 =?utf-8?B?c2lOc3dzTk9HUUlUeHlGamszTlc1TWhqdUp1bkFvMU1uaExYSHU2OWdIbmh3?=
 =?utf-8?B?ZTZ4RWZJaGlveTZoRFBMcm4yWFdCOUZaSmR1RHFEOFpOYU5qajBPNklBT1hG?=
 =?utf-8?Q?3nR41Ang0vcSTp6lC/35tl8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <60A452942F3D9641BFA375333FF3D5C3@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR15MB5669.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac063587-4f1e-4357-febc-08dd2e4cc10a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2025 12:22:14.7103
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mRO7/zqN1w6iLlCcwcIQJY8+XhpcXDbHNKFns2KXoc//beVRlPbi66T/DokOHIwc9nq+gZVPAPxtMptnqdvB+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR15MB3889
X-Proofpoint-GUID: fntFGltXG9LNBaxEkr7fvnL_PuvA4_41
X-Proofpoint-ORIG-GUID: fntFGltXG9LNBaxEkr7fvnL_PuvA4_41
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

T24gNi8xLzI1IDAyOjI1LCBBbmFuZCBKYWluIHdyb3RlOg0KPj4+ICsNCj4+PiArX3NjcmF0Y2hf
bWtmcyA+PiAkc2VxcmVzLmZ1bGwgMj4mMSB8fCBfZmFpbCAibWtmcyBmYWlsZWQiDQo+Pj4gK3Nl
Y3Rvcl9zaXplPSQoX3NjcmF0Y2hfYnRyZnNfc2VjdG9yc2l6ZSkNCj4+PiArDQo+Pj4gK2lmIFtb
ICRzZWN0b3Jfc2l6ZSAtbmUgNDA5NiAmJiAkc2VjdG9yX3NpemUgLW5lIDY1NTM2IF1dOyB0aGVu
DQo+Pj4gK8KgwqDCoCBfbm90cnVuICJzZWN0b3Igc2l6ZSAkc2VjdG9yX3NpemUgbm90IHN1cHBv
cnRlZCBieSB0aGlzIHRlc3QiDQo+Pj4gK2ZpDQo+Pj4gKw0KPiANCj4gX3JlcXVpcmVfYnRyZnNf
c3VwcG9ydF9zZWN0b3JzaXplIDx4eD4NCj4gDQoNCkFsbCB0aGUgcmVzdCBsb29rcyBnb29kLCBi
dXQgdGhpcyBpc24ndCByaWdodC4gDQpfcmVxdWlyZV9idHJmc19zdXBwb3J0X3NlY3RvcnNpemUg
dGVzdHMgZm9yIGtlcm5lbCBzdXBwb3J0LCBJJ20ganVzdCANCmFjY291bnRpbmcgZm9yIHRoZSBm
YWN0IEkndmUgb25seSB3cml0dGVuIHRoZSB0ZXN0IGZvciA0ayBhbmQgNjRrIHNlY3RvciANCnNp
emVzLg0KDQpJJ2xsIG1vdmUgdGhpcyBiaXQgdG8gdGhlIGlmIHN0YXRlbWVudCB0aGF0IGZvbGxv
d3MsIHRvIG1ha2UgaXQgY2xlYXJlciANCndoYXQgSSdtIGRvaW5nLg0KDQpNYXJrDQo=

