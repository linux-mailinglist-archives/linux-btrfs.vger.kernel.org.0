Return-Path: <linux-btrfs+bounces-10615-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A5F9F83B9
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Dec 2024 20:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A61431891EF3
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Dec 2024 19:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28F51AAA27;
	Thu, 19 Dec 2024 19:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XSWFAv0I";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GhrLxW0t"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598191AA786;
	Thu, 19 Dec 2024 19:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734634806; cv=fail; b=F9eamr5wte1WkEVuD0nBJqDxRIZSt3hSfvgeuSx7RwniavhKF5Vj4jwpGppwjj9ITB3DwjS9PulKo270WELmEJlV3+lhaAs9l85m3l7MoIarpHbdcf0fe/3SgkCZiBrGcfx9V1Ng5ssx/Nx/Ao9PU4Jx1Q/nzYFOC8kH+eZxiYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734634806; c=relaxed/simple;
	bh=57B40f6L3Nb3Qhsr1Xph6b68WgvD11dpN+0AJK+7PRY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZnUkwZP6GejCGQCpZ1WQvAou1lNWD7+F89cuvGcEBfQd96a1YasY5zGvRpW4ta6B8uNgAR4d3L55Qw42mq63sPkrbvtSsGcnhO0Q9ZG4Kx3RbU2kSM81ljQss4MTIc+kRgHH1+ukL2hiGRBuFFD5WzcRWtZeOZKJDpGv6Y9t1qI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XSWFAv0I; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GhrLxW0t; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJIMiNP030947;
	Thu, 19 Dec 2024 18:59:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=uC01/njuGhF8tt83j4STGjxPszkvzCbNVv8RT/Ka7bQ=; b=
	XSWFAv0IXu6IkHblPKXC7o6KUSuTntkVP2WscxyFysG0KUroOakKxePpXfJ+ddEZ
	k+0RYqkBRxNYTQD9JdGOXPES4lZC7ctuPsB9GpUmNq4u7jg7R+dvliIn1QjNDjDP
	NT0qhbK7qYEo/VgTd86Y/NrZh+7WKpJ+D9diIr1cUiwym7DCRexDBxq5/TrbaM54
	Fv3kcXOWm4i18dovTblT0Pbqqp+G3I29LVUzEN6bsu2eqiyl8b/Ou9uvuQkKX6lp
	am2tC0Eo5zANVkF+cI9YHYtbRMoVX8uur/8CHeYYaItiUwPYP+Qya9SE/qXtO6YT
	GsiS4gegBZYqzvC4XhlcoQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h2jtbw7x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Dec 2024 18:59:59 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJIWM6D000550;
	Thu, 19 Dec 2024 18:59:58 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43h0fbq735-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Dec 2024 18:59:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C0dCvr3sFnFBV63yctQHAIVaQB/VTSQMvQhMPhc0cK5UuHysBnI6Z3KE60Xp06IOa/5/vMKQ9q2mQpHN+1Dg7WoyhOceGxj+zOk4rXeEOVdjTCD5wXbUt7yHhspmbKreETgKMv+o72mJUpHvQfhuXIa74+nuiLHC+r86uNV4rLcLMGS+YqTfPDoGhtFt3QVl/6SpH2lGBEFmxiC5BSw2H9Pb6XpM8Z0M7RuePDV3NtNMy/RPagg/kF6GobiNsNVhANDzh88FVL79fiT4humlyen0Q9t3IoLQrFewAwqSJu8K2FbfzXIow6wZA96H061k8sowYaixYmPQdJ6/cJsQ6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uC01/njuGhF8tt83j4STGjxPszkvzCbNVv8RT/Ka7bQ=;
 b=QTIdf2dhFdtcR+AIPi/X3CJZaAvGm4gdH8V1l4ap/GBpY36PR/vAYKLFDewyxnWevHg6Jsg5TKmp6Rg/cV2xCvkUxMn+RCYAdmLvhZmc0sEuo2rW/QSrwLEuNFLWo3uqpCmg3ejcZDY0cN+Xz6IhUoPGJQnJyd7xwY6cc2/Pg6pBNGDKMQ5vTieuXbGuMeWrKXp2BP9Vz1QS8e4tFLMKL4uxO3727FPcX3pq9x5ATzGDf4MQMqKOJmGOsAPwYTn9/xTuUu3KvcN+ojqEzo3J2Oe9Xym2Ol2JRP0+lT5s1Xzdt4WOSynUB+dZsgYN21QsXFaJkNBXdve/KDk2AQLUWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uC01/njuGhF8tt83j4STGjxPszkvzCbNVv8RT/Ka7bQ=;
 b=GhrLxW0t2HmXmUU8xKkS4YZ/922qdogGb6BLGWurQ/044CvKdSSec/yOsNoYECpeckD5GbpwuVWictdH/5blLgT8AQZ3JTKc32o98fMBtkfW+cmhmWzP+OdFh8XOo0Y3jZSssR/3qrd+fvxqGSIm0Fft8H+XzLvvMuM+MjQfIPs=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by LV3PR10MB8058.namprd10.prod.outlook.com (2603:10b6:408:286::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.14; Thu, 19 Dec
 2024 18:59:56 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%2]) with mapi id 15.20.8272.005; Thu, 19 Dec 2024
 18:59:56 +0000
Message-ID: <38a661e3-f8be-4511-8be0-d16c589a540d@oracle.com>
Date: Fri, 20 Dec 2024 00:29:50 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs: add btrfs_read_policy_to_enum helper and refactor read,
 policy store
To: "Colin King (gmail)" <colin.i.king@gmail.com>,
        David Sterba <dsterba@suse.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cd8135e4-2de5-48d7-a7de-65afb201b3fe@gmail.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <cd8135e4-2de5-48d7-a7de-65afb201b3fe@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::19) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|LV3PR10MB8058:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ec09a4f-d032-46b3-30c4-08dd205f536f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZUxNeTR4N3YyNWhkSGE2Q2xleTJFNUE3Vzl3SXlyVVdmYnN2cTRnR2xsZ294?=
 =?utf-8?B?YjZ2Z1hERmMxcmpuMi8yUGhoTXAzRTJZYW5wbk1Id0QvNWducXBsU0tOdkF0?=
 =?utf-8?B?TXhxWHFGSzFtS2FBWGU4ZHVVQk5DbXQ3R3RvZWVOQU1Kc1J3SWtrZ3VueVhZ?=
 =?utf-8?B?WERUeXZYS3ZjV0l1dFFnZ1BOb0lwWDdxYSs4ODBSVmRNRDMzaXc4ZzY3aThB?=
 =?utf-8?B?ZkF4UlBrVGJaQ1M5OWNFdUQzZlBkaU9hQ3Q5VVlhMElScUpPQnQzMDZCcTd5?=
 =?utf-8?B?OWlCN0lsVFdDb29hWTJnTWs2S1RUU0YyaHBCRUpMRTh4bk9FVEhCbXJ4TGF2?=
 =?utf-8?B?OUd4OXpMRHFnUWpINHVWT0RLTEFYUVpSVWg4OGxkeW9HZWNYVUZpMGxDak5m?=
 =?utf-8?B?aGJwczJ3TGdxcmdESXVkd1QzY0txSnJXbjdZbnVGSlh5Sk9DN2lGaHRuWmFn?=
 =?utf-8?B?ak5SVkdGTjVyVE02TFNkSlRsUFo4NlMxMlpVcXNZSVh1NTFvb1IrbHJzVERE?=
 =?utf-8?B?QXBQRkV4TTdUN3YwT1JhSEtDRTUwYkpjeHRlaSs5MUpCMCtaTzF6bER3ZmRU?=
 =?utf-8?B?cllVUUN1dWtRalVndkJqVVJ4MUFrSXNQaUdBeSthS1UwZUZORjdZYTZEZU9k?=
 =?utf-8?B?ZFQ0UXozYVo2YU5FQlQ4TjFweVBic3BCNk1CVnZVWTQzdGNYRUFIWEUrSm4x?=
 =?utf-8?B?S3g5NHZ2S0QzTFRMMVh1OXZFTWpSTGFONmJWU1ZWcUtjMWUvdWNqMVZIWUlQ?=
 =?utf-8?B?ZVN3cmM2cnBQYjE1ZXZvaTZCVWNRdHljL2NqT1dxTUV2aHhESWZBQ0RmSEdR?=
 =?utf-8?B?dHdpMzJQOGNIanM2WTFDNEV4cng0UVlURUEva2ZDM1RRQWduZGJIeGRtSUwv?=
 =?utf-8?B?ZEhpL2tQS29CRVlCOGpwMThCK2R2Y29maHlmOGRlVmN4NW8raGYvbDU1TkFG?=
 =?utf-8?B?MHQ2cE9SVTk3Q3FSa2JEV3k0VStveHZnZStyaVhUYndTQndSMEtvbmJEdkp0?=
 =?utf-8?B?NlRuWUIxS0plOFNrbEJGTS9IZEpIbjZSY0dLY3BndDdpdXFvdGRNOFhxd0JO?=
 =?utf-8?B?Z09MVHpBdGVEdUd3QldxN01UTEY3VkxsYzVBN1NBdWZtZy90ak9sd01JNUVQ?=
 =?utf-8?B?bm9kY3l3eXNGNk1yNDJ4aEtTKzU2VjFnTmpwSzNJeXRJdkdhRytjaDUya0V3?=
 =?utf-8?B?clI4UVFNM0NOL0o3UUE1UmpUSTRjUU4xR2IrenkzaTlVZ2pPNHAvL0ZlYTFF?=
 =?utf-8?B?WlpNOWlJcWJEcXBGeFdHNzZ2ME1sandUOWhIVVJCUW01ZlgzamVzSWt5Rndu?=
 =?utf-8?B?cytBTHhNVmR4UWttMW9FMVNwWUZQZzFaUmRCdllta3BQM3RXTnpoVWVjU3ZN?=
 =?utf-8?B?eVRnYXdPcmpsaDd1bW1yRE5UYTR0U1piMFJ2S0h6dGc2M0Rnc0VYb1BZczNC?=
 =?utf-8?B?VDlGTzQ1WlVRWDErcGxtSHhsWHQzbGxCY29maVlzZjVualYyRWNmNWVDTEtT?=
 =?utf-8?B?Y0Q0NFltYVEyaThoQjVOSkhVKytBeFFiZDZETDJZWWxKbUQ2YU85eGJyOWpM?=
 =?utf-8?B?Y0Q2UUxpYTJ4QVB4LytKaVNmUThlOFhNR1dqVVgydm1BalA1dE9UbWlPeG9k?=
 =?utf-8?B?aVdQcFkwZVM4MUxLc2FrdEkxZjJlcDVBWEJwdEVqM0prTUJrd2tITnY2Wm96?=
 =?utf-8?B?VS9oSE1Od0craTVlUkVZK204NktmT1BWRittMmZWdjZNQVU4MUVrWURUeUQ2?=
 =?utf-8?B?VERzMTJKeld2VXRXUnlxRWFBbWJHUERLK2hDY3kxMWtGTnI0YkNvclFnOHds?=
 =?utf-8?B?KzlXaUJvdGpXRWU4bUdidz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aXcxK3BlZ0JUWEhBU2QwSGo2T29jcENZN0tqZ0E1VXRSQlUvNnU0a2N5SnRL?=
 =?utf-8?B?bWoxTm1KSWxyMHdyelBjK0VEb0FwdjF3bGpSUHZ0VDUyS2FhRWlMenVyYjBx?=
 =?utf-8?B?VFJMYVA0eFFCelVaelUvY0ZwTWdZS29kM2Jtbng4UjAxbmNob04wdkQ1SmN1?=
 =?utf-8?B?RDBXVC9UZHlaNXhvKzJLRzc0MDFSN0QrUFdaK1VEWitJQnlGbE1pZHQ1MkpU?=
 =?utf-8?B?OWxCcHNROC9LWVVYTFNmaXl2UDdJVXJnQWNUWTlOVFg4b1dFczhTMzZucG5H?=
 =?utf-8?B?TVNOQ0EyRWV0ejRxN3FEMmZ2RVpNcC9MNXUrMExhSU5xQUNNVHZ1dFJqNXc2?=
 =?utf-8?B?WTJ0ZjFvVFRiUEZTcTJzK1lQNGQvYTdEdEkvdHkvMWtRVTBLdkptNFhqRHJt?=
 =?utf-8?B?TmUvc1U5aXhOUXZTSHY1L0F0ZldmcTJWQWVMWUNjVHh5WnBxbm9KUUJtUzJp?=
 =?utf-8?B?aUNITUNrRjlMK1JycEhRVW1KemRKci9adW9sOGc1UFQvVzR3RU5seXRqbnU2?=
 =?utf-8?B?ZXdBTGdlaWZxSG9QK0VFa2J6Rm9CTVJidTErYnJnUS8zcFY5bEg5Y3VyU1c5?=
 =?utf-8?B?Mlh0S3pKZ1Z1MzdyeVZYT0NYcXNBTGFOZnpRVFA1NmQzeWN0ZUlmYllnbDc2?=
 =?utf-8?B?MUxKM2lwejZaSEhQckl0NjFQU3A5RlRRWVVWckQrVHJwbld2eUZuRGNYNGx5?=
 =?utf-8?B?Q0xqNzkzVVJIbUhPTWlZZHFieVZIamUxYTZPOU9rL1pBNDZ5S0NRdVF6T01a?=
 =?utf-8?B?RXl3OEljSUI5T3RDeGJOMytkRmg0eHBSbzJFdnIza3Bsb2p4RVc3RFV5VkdO?=
 =?utf-8?B?SU8vS2JMcVI3WldseVNzOTd3c1VKUE9ZVUM4d1N6ZkhSUUg4aGRVWmxKZ2hS?=
 =?utf-8?B?d0ZtRkxDSUE4bDJacFErb3F2b1dMdW8wS0E5MU93Ym96djVrdXNVbU16eFho?=
 =?utf-8?B?MmRvZWtTOVZ0eVlGdXEvZFZmRnRrSi9WUU84VE9FY1czU3ZUd0hxYTJWVTZp?=
 =?utf-8?B?OElFQU0wZzgvQ3IrK3hHOXVvaU5INlo5SGtheCsyT1Nka1NHRTFOai81SzJu?=
 =?utf-8?B?aEw5eHhGSGRVQ3VPT3hwaEpweXhGU2lna1BaWXcvclFJRTlDR2wrTW1RZlRm?=
 =?utf-8?B?RWtIbGxOcW45cmFWUzF5YUladXVCMmt2M0ovOHhEbzNpd3FEaXgrWFVwZkpl?=
 =?utf-8?B?VHFoQ1dOTHJyTFBFVWNCWEtnYkcydTRXdysxOHJoNWJRRnVBNmY1azFETW5k?=
 =?utf-8?B?SGMwVlZDam5ZVGZycTBhbFlJSGV6cm16Mk9wZnVNNy90Ni9PcDJLN3RGZUxD?=
 =?utf-8?B?a0xIS0VMSUx1TTBQUW45TEc0NkYzcFRWRTJkQ01hSUtjMm1oTmNBRkxOVTFu?=
 =?utf-8?B?STlvNEFhOXNhd3dtQ1Y3eEhnYSs2dnRIeDJoTVJwdWdoRGRRTmdGYTlUSy9E?=
 =?utf-8?B?Q2s2dlZRbFJ6QXpRZ3NzTmIzZlJvNVZuTGVRMlpIL003Y2RUYVpmaUwxc3Uy?=
 =?utf-8?B?Zy9oUHdhdVpaaThSczZNNk9TRmQrY0I4UVRvU2Z4UU9MWEFSWjJMTUpUOEg1?=
 =?utf-8?B?RnltYXlhYXRYbUtHT0tIQnpSbnQ4SmFRbmgvM3RaN3Y4VWx5TzJBd2tSUXJE?=
 =?utf-8?B?TWhaVVQ4QXd4dlk5YVFzYXVzL2lEOTVIK2Jyd04yYm1wUTNEbFlNb05LbjBJ?=
 =?utf-8?B?N0NybTRVejRHQWM5LzEvUnZVTG5ESVJ0cStrU2JqTndUWG5hS094TTNZS3Q0?=
 =?utf-8?B?dHVLdS80QUl4cktNN2RmUTFKbEVFOFd1MHE5WkNvMWtzTDJGVUQ1cHBraWN4?=
 =?utf-8?B?NmJPMG00cTQ0dEJ5WTNqemhYUWJ0RzJ5WHpOZHZWNFRZUFZjRVR0OCtUbmMx?=
 =?utf-8?B?cHY3M256VDdPR2padGtYNlpQQTloc0tzS2pKMXhqMHZhWEFzY1d1Z2grdlpq?=
 =?utf-8?B?cElFV0FqN0pib1U5eDVvODY4THpucFNqU2liUTNZSUdsbWVjWkM3bnMyVmda?=
 =?utf-8?B?WHkyc21PNWIzK0xrdk5rSjRHdENUY1dGS09ISmp0TkRkeE5CMXFuc3I4SW13?=
 =?utf-8?B?bnJWNTZuVjRnbktvOEViYUc5Vms1N0hMTmhwUU9WeDZSY3RPNlFsWGt2SWoz?=
 =?utf-8?B?S1RGSlRMVzhLS0ZnOERSZzdtcUI3RWMrR01Ea2kxVGxUSjNCSjlRM24rK1FZ?=
 =?utf-8?Q?c1sIJmLRqI9wp1K2WgCDa7Xmn/fzTrBopQS3I3QYTxMG?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pvKtZ+aLU0dwJsfdR6wbALKnnHvfOJAXFPKiErDImeYHrfZaNeALd5PQlGR3bKaBcVhlhsOzVZr6yZrFFXIP7n0je3NiR0G9w9XqNALE3z9UGxwKNr3uqWA05Q73xqJtxk3831NIq3h9zkcxF3Kfn0mfo9SwgvCBgK5d3cORKQRP04TAFs4QMU35SWXao1oYLFu8yt0Bt0k4gBxNBIJdtbRJ2XkBVlpr7xmanb2o8d71Uzfwa9TLZVFxBiZZW49DAhVcKfxDFN7eQxPDrE9Hj9VGHKvPl174F8ADE6jssVhY9htB3JlwoFT2kNvS2w20wFLUM+txwoLhMbmGIol+ew7+eoOODESMLTeDolGg8a8dnjLlq5NIbrGsGQoUWIniTBOYqWaWoV31izlozTZbDrUP56Pd6umJ2LnKmTnGqV9EH7RIww+b+DRdnHkLLuzjcf6AlERlBjpdZ2FRVauuHU7olx+BUVosIAkfy6cmbtYRBatyTUbEEeNmnznuUij80MltHUpr3ytDEbrrsJH5fhVOSOHzZfmBs9EYBkwoaIbcctfv1ukA84BFgH5IXwDpx1cACozbvt+2K7uJE54jHrk9x/D6FPtFm4ILsA47G6I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ec09a4f-d032-46b3-30c4-08dd205f536f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 18:59:55.4102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ypcnD3D7olFSGdawg0tTfBKQBY4IQpzNzXdo6ktIXlsTYZ4RyZ4nDdrdLu1IXP32LM6/c41I42N0O/rYH3beow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8058
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-19_08,2024-12-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412190150
X-Proofpoint-GUID: aDA7C868QhowvbA0sqhICHpM3a0DFtpk
X-Proofpoint-ORIG-GUID: aDA7C868QhowvbA0sqhICHpM3a0DFtpk


Hi,

  The changes have already been submitted and will be included in the 
next re-roll.

  https://patchwork.kernel.org/project/linux-btrfs/patch/9fcc9f01bdab846db231b427f98fbb3e9df7c7a5.1734370092.git.anand.jain@oracle.com/#26168805


Thanks,
Anand

On 19/12/24 21:10, Colin King (gmail) wrote:
> Hi,
> 
> Static analysis on linux-next today has found a potential buffer 
> overflow in fs/btrfs/sysfs.c in function btrfs_read_policy_to_enum()
> 
> The strcpy to string param has no length checks on str and hence if str 
> is longer than param a buffer overflow on the stack occurs. This can 
> potentially occur when a user writes a long string to the btrfs sysfs 
> file read_policy via btrfs_read_policy_store()
> 
> int btrfs_read_policy_to_enum(const char *str, s64 *value)
> {
>          char param[32] = {'\0'};
>          char *__maybe_unused value_str;
>          int index;
>          bool found = false;
> 
>          if (!str || strlen(str) == 0)
>                  return 0;
> 
>          strcpy(param, str);   /* issue here */
> 
>      ....
> }
> 
> Colin


