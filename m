Return-Path: <linux-btrfs+bounces-10788-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86ACAA0533C
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jan 2025 07:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 749F51644D8
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jan 2025 06:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37CEB1A7255;
	Wed,  8 Jan 2025 06:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YUj5kRvK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vzlQ8aR8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74AD3FBB3;
	Wed,  8 Jan 2025 06:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736318049; cv=fail; b=D5/xuW5w5ZVYh3fHXHrpv9lN61nOePWgqGbBw/Ssbq1yHPdtOEu0lkR+Bis37iqyBUpNeqgwOtHvONSLqoOxQiqqijGI1XeU55pwYU36vXhnEH9YV5WBCbA5dr3JkCPo7kw9RZYQBJH17plKao0Nn4fWrZwSd11cuvVzWsH45i4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736318049; c=relaxed/simple;
	bh=stkvEKuiAYYE3QjY3l5CIDBUX5gN7ldVV/Pn6+UbCsk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OTiJu0tzOLP+9prA5OCD1l2KBCd4CVsoP9Yg1shoqjilPr8NBqT3EPB0g1CXH7gMs+UaxdhuiDGJa65+UWLilFjNMo7zYeQUwqX1dYfD/mOf7EOsIaAX8fIvHGPpzbnZaLb7wHoOatLcXogz/Qi6v0WC8UiEywBgVOYxcJ7/Bp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YUj5kRvK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vzlQ8aR8; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5081tqOT015729;
	Wed, 8 Jan 2025 06:34:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=wna43YLUpqXQOi1RPrlANaMVk5JP6BsoqcxAjVU1Eqs=; b=
	YUj5kRvK9XSf7YaenfCydMleGb1xNOGovMgetWsNa6rdklyOcOsQgz+aqAnc9vfD
	o1nBNdOqNzhgZxPWDEd5NbH9+MA4uvGxLV4gDbRq/34vX6l03VEI9mEDjhGOB5Aw
	aYpFj5zsq/SZOHIf6qLVrnKI7nSSVy33OsZU6hgufovsKjnpA3cn6EJTmFkvTG8o
	9j1X+H3ixUWn9jSEMRCNp5DUc6q7DHu+vByOf3O8PjLmGYY/Pf5HfMDrNBAU4akW
	8ye2DYxxeQxEqKspls+UtaCQ89lQAoHreF4N7YL1VIHYv1EGJKTRUVoQv2c8mgNF
	MlCsXUBQWKgcPOb+rY0/iQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xuwb68tv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Jan 2025 06:34:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5083rpKx011977;
	Wed, 8 Jan 2025 06:34:02 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43xue96vq0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Jan 2025 06:34:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=deILW8Wg2+lJraQnz2VUmfUp9pROQtKjVWPCuORCHlBlxX/wqmMqN4CBilat8LmaCRxu5QVDxi5JlUDFCnMF9hYw/JFtg3S2t1J7fhEngW/dcBfkH8b9lgf7mBdH6k+i5ZKE3WZbzPAYFA9nolvqX9t2F6MRXDiWSdOCWBeG+bCwTTcJPSl6HKovHWWsoR87HrcOYUmWU8dDIKT2b58YiFG+0GCskeGhzWlfomOAWGCsSGoUVj4TRIDPZjOePEfPDxWMg9Zh0sfWaeucZNCZb6PO1sVHpCIVVQiSMfIV9LcQDJADmZgNlqM8neFTPwvce+JUmNFCeqZeApbJ9rZ65A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wna43YLUpqXQOi1RPrlANaMVk5JP6BsoqcxAjVU1Eqs=;
 b=YPxH9p88EsydxFn1KE1cPhHg4YboOaqX7oq5QXL11OKGYmUcUfzS4vpeeED83DZY1h+MtobFeHe2trrQtjGNxyTGIAzumY4KiAGp4Mh1dAvr0fsRyIOBusE8kWp9zEzJ4AbiG5tAWEFJCWt8STo0ZBNShp7R17mC4/0eu/Ys8QOOtTgcWTGRrAegLHsLUqx/g1pOktI0QI+hu2IH5fYJ3D6ziba6fI1ronakuT85C9JsTIjRGXI8LEKdeAbfUpUy0MSq+7CwyMvlLTxvo8i75DE61QPdAiVhRrUK/IbkCOKXFEaFeyDsloNup+9aKAG3dzU4FZlr4QhaSp674UtMtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wna43YLUpqXQOi1RPrlANaMVk5JP6BsoqcxAjVU1Eqs=;
 b=vzlQ8aR8DbNlspPB+QiLo4IhlGSP9lb+/5DJ9nHFeVEE+lIm0aq36/vbE/ZlzkdFz3060ZM+Y8LKiLFz+jPb3pW1YSeEVNS8qKBeNrqdRr6/Trp4N5f+EQ+4FtGoWY+WvTOQiaSb1vfwFl/fGR55XWjFOma2oHJPe6HejaJiYdw=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BLAPR10MB5042.namprd10.prod.outlook.com (2603:10b6:208:30c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Wed, 8 Jan
 2025 06:34:00 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%2]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 06:34:00 +0000
Message-ID: <b085669a-3684-4031-9e0d-3275289e86b6@oracle.com>
Date: Wed, 8 Jan 2025 12:03:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] btrfs: add test for encoded reads
To: Mark Harmstone <maharmstone@fb.com>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Cc: neelx@suse.com, Johannes.Thumschirn@wdc.com
References: <20250106140142.3140103-1-maharmstone@fb.com>
 <20250106140142.3140103-2-maharmstone@fb.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20250106140142.3140103-2-maharmstone@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0069.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::10) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BLAPR10MB5042:EE_
X-MS-Office365-Filtering-Correlation-Id: fdaa12f8-5e61-4d55-f0e1-08dd2fae6fb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YWJSWE1uZUtLc2ZJQnJuN21IanJEdkZQaXlXeFhuaFZ1T0hkUG8zUjI3Z2ZC?=
 =?utf-8?B?SkVSVUhOejFGSHg2YzBPSXp1dSt4czB5NllFdnVKTDdHeTZUMjRwMjV0bjdh?=
 =?utf-8?B?RTJzUUdpNjMwbFlwMWh1ckttbVBFV2VCNTRhazUyVEVQYm1XOWxSbWUvNXRv?=
 =?utf-8?B?Y2dFeUtaMndqNFNHUEYxMGY5aUJ1VXVJVGwxZ0ZYVkRuYWtXMHhXS2ovQ0RM?=
 =?utf-8?B?Q09hNllDUnQvRlBxSjlvRC9kTWhRRnVyU0pwYVFFTUluNDdoZHNjVEY0bU1x?=
 =?utf-8?B?dGxMNXlNT1hsVHk0UmsxUXlNTER5bXRhVjJMbmdrQ1ovRm9ITmxGclBqWmJl?=
 =?utf-8?B?UWtZSE8zVzY1MnFyTE1yQU1kWHdiT29yMU5ZMkFlcnpoNnFXR3hFMmVOdllL?=
 =?utf-8?B?TzhTdW5WeGR4ckRIOVNVck43dWRiYWVxdVVSODJEZ280YjZveWJ0Z1Z2eVJG?=
 =?utf-8?B?azhmRHltREdTc3p0QnlOZW55L1NIM0ZpdW1aRHJPZ21qTlhnNUJRMDhBdDFs?=
 =?utf-8?B?aCtxdm9aTUVTQ2I2TUNZTlgxa1pBbStLdFZveGVNSlpVb3RZTDluY0xndE1M?=
 =?utf-8?B?OTdmaFNEVGJxMUZsVkp6SXRWQUZ2SFo0Y0NUK0Rab1VKNlhHYWx4bjQxeXB6?=
 =?utf-8?B?QktiYSt1UmlkMG5JNXVmZ0FIaU1yY0NscHpsMVZZVGk4TlBqODBQZUFyY2du?=
 =?utf-8?B?M3dINzFtK1pOdzdENTRGTFNoZ2poRURSRzBqU0lxSjFwQXBNeHVUQUNSVmhO?=
 =?utf-8?B?TktxTk5scDNuY1MzeithdUo5RDMyby9OVURsdVpISk1xRUNFUjQvQm1sYmpo?=
 =?utf-8?B?a1pUNmNkM20vVzBxN2x1eXJIUHlVeE9jaVJtaXRjd3BjWUVaVHAwc2c2bVhZ?=
 =?utf-8?B?T1lQQXZab3Vub0dsdFAyZmV1c3VPQjBKQmUvRTJCcGdGOENwekNPQmZ1MWpG?=
 =?utf-8?B?NnB6bkJIWHBrb01sbmFZWXFqQ0YzQmM5Ykx1ZS9NU2FVU1A5a0daS2NUMUlC?=
 =?utf-8?B?Q29rOStzRFkvLzJadW16YVBZcit5L1RNUmkzei9WOWJkaU9aT2JINFB1bU5x?=
 =?utf-8?B?Q1ZpRUZ6Vm5TbmFObCtwVW9SMmo5RzRsdUdSZlZ6VisxWTF6bzZlaS9XSDEw?=
 =?utf-8?B?bUU1VTlER29EcXNZckZmOWJyZStDVDBHWDQrVVphS1gwQXhHMDgvUmVob0JY?=
 =?utf-8?B?UzFGVys3REt5bnM0RVpyYkYyNGIwYW1DbnRXbml0K1Z2MmE3aXB5aW9mcGZC?=
 =?utf-8?B?Yy9Cc0pVbm13ZHdLNTg2b1kxbW56UFR3dXRZb0pXdFpMOHBsczYxb21yR0ha?=
 =?utf-8?B?UXN4K2JTajNYc0t4QjlLeHI4VVhocEJwV0hhbDlESFVWckVPR3hWcEtpSUpB?=
 =?utf-8?B?MFdZbWh1WVBERzRHVi85cmI0NkJ4RDlkRW0wczRuakt0VXF1ektmM21aR09o?=
 =?utf-8?B?ck0vdUhGaTQ3N1pHcDFlMXJrcEFiWGRGRUNCdzBUY05RWm5ORjdodCtuSjRa?=
 =?utf-8?B?Y21vWFdSeXB0YkZMQ2xNbkx1Y09JdmlKam9vMHlxSHFJcjU1bCtQMzR0ZFZm?=
 =?utf-8?B?RkszN2JtYWxZRnZkSkpteTU3RC96U0wyMS92cnVxTVVLTXZONGtLQklPMDhy?=
 =?utf-8?B?a3F1bWIvU1hHMmV1aU5oMzdCVU05WSt5dm5PQ0ViRko0K2plajJkYkpPR0hO?=
 =?utf-8?B?V3l2MVFFZ1JqV2V4N3BMcm5ZTVpMbGtlYUxaOTF3Y2pJNUlEWkFIeE1nbEZi?=
 =?utf-8?B?T1YwNm4rc0pNc2FhZDVibE81OEpCOG1pTmpKbmhqMmVsVWxpakJsU0J3QStH?=
 =?utf-8?B?YUN2QU1zUDRoTGp1RUtXUVd3U0RGWGpoZ3dyZnFmMGc1RFZ0VWtMVGY2Szhi?=
 =?utf-8?Q?zZxmVoX9C7wgt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U211V0FCMWJ0Qmt3cFFlNndUenRnSk81VEZtQk1zaHBncmlxS2RWQnE1c2Yx?=
 =?utf-8?B?VGNjWnBPR1dqc2JCWXZIaW80N3V3WjZPRmxEMUFmOFRxZE00RFdVQnowMmlo?=
 =?utf-8?B?S2lvSW16OC9mN24wUm5Vc2dUUzI0U1FhNVVtZUh1SUk1OExOSXI1dUdqTDIv?=
 =?utf-8?B?TTQvYXFZSzM3Ykcxbis0SHJ3Wk8zMFd2Vy82MXYrVlhGNHRKSnFnb2hnM21l?=
 =?utf-8?B?UTNEOWg0cG5XMkNPOFhkcEFOTkhoK0FJaEJaY1lVSWp1NDgxd3BHeU1leDF4?=
 =?utf-8?B?UjRCL2djZHZHSFpVRnNwVDJ4ZXBOT0lrSVErLzYyQStZckRMbElPRzJDZEJZ?=
 =?utf-8?B?bVRoNlQvU0dFR3B3UXV4NmY4Q1hwMm1CbnVCTDFsdVpoaEJ2TjVxMUhBc0Rp?=
 =?utf-8?B?Z2dqNitnRmZJRC93bmlHbjZudGhTSUN5WWljN0RNOHVUUWZkdU8wajVndkw5?=
 =?utf-8?B?MWthaDRaTGlWQUdYSENyUjF6R3J4RFR1bWl6N1pPVXZDazVUUW8xU09hTzNG?=
 =?utf-8?B?bnZLdHp3VHVjUXhqNVpjZ2sxdXhLZHpVSjg2WVM5eXIvUGJhZ1BOWmFoMWEr?=
 =?utf-8?B?NGp6K0VORVZvOXk3WW5OK2dPdFE2eGJVUGU3MlR3dXIzREdxSHRPTmxJa053?=
 =?utf-8?B?WjBhK0dHWVBQMzN3SWVYRlpDN0dkOTZOK1VmRmg4UU9QRlRpSnBDUk4wWUZx?=
 =?utf-8?B?MVBOdndaOTVzTzkybGZ1S0o3ZGZoK21pdmNHVDVhOGtkU1RHOUdWRzJmTm5N?=
 =?utf-8?B?TlZVMWxlMVZjaXpua09QYXprblJyQUM4cHlKeGJTN2hCaXBYNjdvblZHT2FJ?=
 =?utf-8?B?cURROVZVWThvUk8zcTNWSUxyWVBDb3UzVjl2M1BXNERnc1dUYzJEL3V0ZFF2?=
 =?utf-8?B?cTJmakcxZGRacTUvT0V2R3FYeS9ScHhuRGZTQ01SY2lUWTl1YUhMS1RXZG9Q?=
 =?utf-8?B?UGdQSmtSOWRya0NDeTJyK29OeXlaNHJIb28wZVFJUnREeXZidXc4bmxFZ3gz?=
 =?utf-8?B?a0RqN3NrZlFPckRpdXVmTU5qaWRXV3hZQ1Fzak96Rk1lamNEdWRLWFdTM2o0?=
 =?utf-8?B?NmlsdjdNTDFTRFFDMnNNaUcyOHphM25MZEhnTXYyaUJKK2VRdjBrbXFvQmEz?=
 =?utf-8?B?aHNyb1pTTWFZTEZMMDFvSFRTVE9rNThUNzlhSUl2dmdZZDkwRENweUo4b3Y2?=
 =?utf-8?B?bTQ5a0tsY0FmM2VuTWJldlpUOWtObWU2MkhJT093czNzVXUydXJmMWNIM0Ir?=
 =?utf-8?B?aUozcmoyNitwM0hJcXAyME9uTkFkZWdtQkV4MXV3VWlGZ0FXNHpZUGVwaHRG?=
 =?utf-8?B?V0YxTlE0dHFVUUNCVC9SaWpQaUQvcjZLV2JRRkE5MmoxWFI3Y3dYaXZTd25T?=
 =?utf-8?B?VnA5WlQ1NFZweVBXZkYzeVV2dVFiMUtNaDl0R2tmSUNUaUxBSjNoTVFQN1pV?=
 =?utf-8?B?cGZDU2NyY2FWRHhDSGx4OStOWFhuODhEVysrTUV4b29oZC81NGNjM0RDQXlO?=
 =?utf-8?B?c0s0Ni9aWGlYMlUyeU5uUkpSM3lwQ3ZNQlNzK2hYamcxZDZIc2FyNHNVajZ1?=
 =?utf-8?B?WXRZZEFuVURoa1V3MzYzYWJGU1oyTVNaRGpRZ0hwRjh4VHN1VEFkMnI4cGg4?=
 =?utf-8?B?NzhKa2g1amx0UW5GSEZ6aGxtQlJxUHJHM0hvS0UzUTkzMXdsT1E4NUNEcnlu?=
 =?utf-8?B?MDdLM1IzcElvUVBBM0FzUHl1eWFrVzhyeGhieTBRR0UrTHFlNTdQdkYzWEdz?=
 =?utf-8?B?S3ducHV6dHArUGJxUHhmczQycmYvNVE3QXE0b3hDUW1BL1NEa0JyU2lvLyt2?=
 =?utf-8?B?YWNjNXJHK2FoRTRuRlJUa25yQ2p1bUxOZWJZRFFhcUNtZHRxSEpGWjVwWlBT?=
 =?utf-8?B?cmhJcVEwYkk1R296eWZJTlZvcGFHSSt5YUZPOHBsYUc5R0g0cWJmeklBRWJu?=
 =?utf-8?B?WndoalJINlNoaUtWNTZiR3RJbHVOZEdzUHhjTUFic1p5dTZ0SjMzckduZWR3?=
 =?utf-8?B?R0F5NmlwdU9ucXU5RkI0alJRbHlTMGhaT0hZK0pEOTJYMzA4Sjd5UU5manR3?=
 =?utf-8?B?QlNDK29QK2ZUZzZMVmNFNE9zL0V4T2RiRWtsUXArNUJRMlY3MjZyeWV6Sjl6?=
 =?utf-8?B?VDc4YUx1NnpNL1Q2NElxL1lHVnlvUmkwcytJVzRodzF5Ry9KL1YrOHNqQmZr?=
 =?utf-8?Q?V/VeRxDn0WOPDyS6HvRNuv7yUxnS7n0HD/811K4IyqxJ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KbryrqjQUX7FsY3c3wowatR2Uz1SHrwQWyGy+lc5RaryW6oI8XX0kGdrD88qLIgGJk0ddEp329sc5c3rH+l9sBdwT/KD9MyPGGKpmyPm8uadicVUt4X8426oGdmrQZJD/OQmbgVNwVmt/zrGSNu4G6qbDKMondNjTbz8+X8ATZp3Rk2k4zIpeDWp/5cK8PDmo2iwdn7oAotOpPjxttTG2iLBd+iWhHgD0xt86X74TU7zUTBtTU8VYf0itiZaHIQECc9L4wTIr6y6owseJ0TOHr/SdaEuF3t68XHXqbOOUaVE5J33bcp+Vq1mCWy2zvcwSPb0zvXP7tHOzTHikYj+c5jMJYco103+g0BTclid82LbdTZduNfLDZrl6OgIo72HFhsIXLY+R4+tlD8Mo/Ehr4e9t3ZacscUaKVR+jWlY7JJW0AAgRL7AI7k0CqfGZCFPrrR31eAOjjIZRsOYuQTRL9zCpL/DeENI5E/5IvcnhgBQuPgqwwMoWWmgYQmhGUbrfsfD/BRIX/t+0hAgHcwsGbTt35YeaUIKcj4v8FxlbK6wM1MpCLQbur8agF41OHjPnP3HgNRE2uT9SJtn8zcU3aNqyJ9gApetgOHZ5/rXmo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdaa12f8-5e61-4d55-f0e1-08dd2fae6fb5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 06:34:00.5105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /1KmOD3VMqvEFERwmUPR3a4p1SRwwLP6wmt8ft5Bl0y7ilsTB1s5+P067TY9fvoDgBLlNP5lMCVW0S6KP+kOHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5042
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-07_06,2025-01-06_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2501080051
X-Proofpoint-GUID: AbchIeUM3lUu4e11AMf1ng4cmameh8HO
X-Proofpoint-ORIG-GUID: AbchIeUM3lUu4e11AMf1ng4cmameh8HO

On 6/1/25 19:31, Mark Harmstone wrote:
> Add btrfs/333 and its helper programs btrfs_encoded_read and
> btrfs_encoded_write, in order to test encoded reads.
> 
> We use the BTRFS_IOC_ENCODED_WRITE ioctl to write random data into a
> compressed extent, then use the BTRFS_IOC_ENCODED_READ ioctl to check
> that it matches what we've written. If the new io_uring interface for
> encoded reads is supported, we also check that that matches the ioctl.
> 
> Note that what we write isn't valid compressed data, so any non-encoded
> reads on these files will fail.
> 
> Signed-off-by: Mark Harmstone <maharmstone@fb.com>
> ---


Looks good. Add to the group io_uring and ioctl.

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thx.

