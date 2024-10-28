Return-Path: <linux-btrfs+bounces-9191-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9EF9B2B9E
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Oct 2024 10:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C0372825F8
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Oct 2024 09:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11AC1922F2;
	Mon, 28 Oct 2024 09:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Pcc8XNPa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="h9LToVRT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042A7190052;
	Mon, 28 Oct 2024 09:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730108166; cv=fail; b=AUcCClKt5WvSW+bBkFp4A2OE3n7KuF1YkG5vRGU6bAX8H3ot8VMchpTSa1lXjzQi8TgoIrzYCCb33TwtMTvasx1SJ4gR5YDtHLYBomUrseACE5r8WJv/GK7y7+0TDyJ+ZnCDg0fLB+AGQSRkJWzEzcwtjF3o3GCvrXxEG0lR8UY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730108166; c=relaxed/simple;
	bh=oe6tv59qns58L15jTt54OjQk/maKW7P6MIc19MSZIRo=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GqQ1LBia4hA2QESW8Kfvkw7tKS8hY0awPnpSIzVXNROswKGAYnWyniZuB7OKruYRyUO1WNmZj51Mwahnifc1lbhrF/gU7cSV+RCua+7wPf/gnn4HhXdhlAL2LYv7cQCMbSyBxEW9/Lcu05iTaxLZLUr0A6GAf4DncNdxlZZc29g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Pcc8XNPa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=h9LToVRT; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49S7tfMq017593;
	Mon, 28 Oct 2024 09:36:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=UTurNERyB1KTehuix8KxTk/Qb6e5b/VzDilMAGhS6MQ=; b=
	Pcc8XNPa0QVe+npgrsOuz66yAOxuBCwyQmsW0lesWMMtECupImR6cGZCIyK1xf3o
	f2SbVv6Qe7LGq1p3xrVQK8m2/CrXVb4lTIG99AyZgYMyfcP/YAd5gnLVpTwXmtaZ
	Xn20bY1XBsqSttkTCwunz6SZOlG+wTNLAHRwtBizrIvr5lIe3JEZVI6iY7Vs7bYg
	lMu95ho0wNRqf7+grDlG6PlSjY4vIb6rIkrhSY0WCfddkajJDXbsJJiiLyMUQB4K
	sfi+3S7F4KbMnH5cj6iqQjm37uxry6Q6ggWH9TvznzQk1EhnGb9g6jm2kTP+Fx6V
	9BD5DI9XKnDbp0Cnzfm5jw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grdqaa9y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Oct 2024 09:36:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49S98bZn008350;
	Mon, 28 Oct 2024 09:36:01 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2049.outbound.protection.outlook.com [104.47.51.49])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42hne7njer-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Oct 2024 09:36:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rfNumYSAHfPBVWoCOTPVBOWJRsP/dONqtwhpYAhnW3PBt9hQTFcMRucXJQy5JwC2YS1idhXb6ywTzxecJBx+4N4TnULlBoskO1OfBMcTfY9pXhMJoll2tE2+ar3z0Mk6mNJZojnRrAAJG60LnDjL5sWScJplo7XNmmKOeaQe3yZ6My4OHToIdAciWf3RyVN6AyPViMzoan34W0i4Qxre8QfFpCHx+9UipNnhkTbmiH+ws8Pcu6E1RyWZqWowf4M031RWErKdadP/j/NZMFhDtk14+1U6HZ0+qOwyjhzs76nT5NZ7y33hN+vnsW8FQU8RTH9t7se5sXURLwTTQKCLNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UTurNERyB1KTehuix8KxTk/Qb6e5b/VzDilMAGhS6MQ=;
 b=HVIWkCurkYPXV84oumdg+wMSNhx9f8wgr0mtmb0K4AAdMgNY82h8HqOIxeZARIxpEKBUeMijMdGTk1nYFOfOZZCMz5hI2xtbufpigP95hDE6LxSjT/P1V4GDsObBx7UJrLHNYK84PhhBxXGS5PCUtpZC7AyYknnn0T3WkjlZHNGOSRMDjFUrZhqzAEcCrEu6oYCVBKdL3/14E+efymwy+c4D/1KMzva8Hkq8PYcvsYuNXw3fj7dA4Ot+aCBP5Fwy1qh5iCHi+ZcMFJ84J/DomIaB/zlahmlrcOEDNgqWYArE5sQqrmPynTUtSrbPQfBkn5cpL+nsH+74PT5BpCViwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UTurNERyB1KTehuix8KxTk/Qb6e5b/VzDilMAGhS6MQ=;
 b=h9LToVRTdwUfqB0oFX9xNa5NytpBBj0wjIwui3a9ceUwoOrbs1ux/Zybxbj7EisAbbhXJAIycALo60R/v9U2Wy/tl/tUdYl/YAp7xC50+oySyI4RiCtnELI8LYecpiF+I5i1DO/s9JhIaZE0KSXO5U+D3Ts/AfpgiZZDGVpFsjU=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH7PR10MB5676.namprd10.prod.outlook.com (2603:10b6:510:130::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Mon, 28 Oct
 2024 09:35:59 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8093.021; Mon, 28 Oct 2024
 09:35:59 +0000
Message-ID: <519bd0ca-1843-4927-803c-0e03f4e4df93@oracle.com>
Date: Mon, 28 Oct 2024 17:35:55 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: generic/366: add a new test case to verify if
 certain fio load will hang the filesystem
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
References: <20241028054121.50985-1-wqu@suse.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20241028054121.50985-1-wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0003.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::20) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH7PR10MB5676:EE_
X-MS-Office365-Filtering-Correlation-Id: 55cd4332-88ab-4fcc-7d1d-08dcf733ee1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aDRRWVpsNVVMKzdVMHY3SXNqSE93SlhWL3hEaVdGU1RYQS90Wnk0Y01KcG01?=
 =?utf-8?B?ZHFOTXJxeURHdTBjblZGajBFVVF3a1FFMndjYUhZOHI1UjRQeEloQUoveUh1?=
 =?utf-8?B?Wm53dktaUnEramdVdFh6OTF6cVJhOHBrZjY0amJxbStmbTBlL2wxaHpuRHhq?=
 =?utf-8?B?ZFQ4MEdvRGZoYytQR3BBcDU5RGd0UEJhR1F2b29DNk9aTllmZnI2Kzg5cEJZ?=
 =?utf-8?B?a2d1aTdBWnI0amdSQmkyVm8yclZZaEpEb0ErZXA1MGtYdHBDeWZGcXpoTGh2?=
 =?utf-8?B?UmdRV0o1WHpsMW9pYjBreFVhd1BSeFo4YXBZU1NIZXU4ZGVDRCswb2pKdWFl?=
 =?utf-8?B?TTIyK00yY293dG4rOU50ZlozU3FCalc2c0FwUGhLdk5ETko5Y0E1WHhWeVIy?=
 =?utf-8?B?dGZEeWNETldsSnM1UDM5aDlieWxsV2c4R3NaV0pKclVlSTQ5U09MQjgxVUZp?=
 =?utf-8?B?WXZ5NWFqR1I4ZlIwcEJMQ2tpdDA0UjhHcnExYXpRV3I2ZnViNWFWWmZZVm1q?=
 =?utf-8?B?UDNNdFZ6VGxWcVltZWVLSGIzc1BPVVdMdllwSkhvYnFnUnU4NUplbkFKejhT?=
 =?utf-8?B?VTFHUUJMU0J2cCs3Zm83RkVnUG45WEw0Y01GNzJjQ3YwNE9DMkpGTE1uUEEx?=
 =?utf-8?B?YmdreDN5N1NVSW8veExGWWg4OEhNbGZUMDVtQXN3NGVLWlQxTHJFQmQrdVNU?=
 =?utf-8?B?OHRHUlkxSHVzMlBtOVJCQnYwUUNTQ3NMN1VyTlBCZng3TzBPbm5nOGF0YVdL?=
 =?utf-8?B?U01MdFVBeEtycEQ5Ky9XWW5BNmdNYUdicjFtNUhWZGFwNkMzaW15NWJsQTlS?=
 =?utf-8?B?Z2piT3ZJaUJ5NDFFWGwvdEtRSm9QTFFQN3ZyTytwT2k0TXhaRWlZb0xpbFcw?=
 =?utf-8?B?TDFyMFdaWjhNUGI3U2pmVFN6akhKb0ZHUUJ1alNJZHNZdmI1QmdUZHNCcnVm?=
 =?utf-8?B?YjBtYzlTbzJyYk85aC9MR0ovellHNFNwb1MzOXFidm8yZ1FJWWFKdGQrazhl?=
 =?utf-8?B?MTNxSW5pZ1cvbzByWE5nVytuSkpoSVVXWmlyZjVNMFd1Tzd5RnZwQ3U0aVph?=
 =?utf-8?B?bnErS3JOQVdzRXA5ekM4S2dreHNBeWlnTExjQUlvY08zdmFyc3VJVm1TUmxZ?=
 =?utf-8?B?MFVuNVEra2lJS1Jaak1paDFaQ1hLNEZrMThpSWZCTzBtZFVDZzRyNTAzL1VU?=
 =?utf-8?B?Q2hpb0xHSWoxY2RRem1za0pVNUxETW5iMi95ZUk4SGV4Q29oejFmOGxLWVB1?=
 =?utf-8?B?OTFXUm91YlZmVEVZS011VkphdEtFZTJvQ05oRWhGOWJ1Rno0UGl3MjQ4WW1I?=
 =?utf-8?B?aU42MjVFYS9vL21oa3VxTEZlOUhFcHhOTlhhUVdLNk5SV3JISGpkd0d6QUti?=
 =?utf-8?B?Z21qMnhXK3N4bmFhZlF6ZUNYTWJPR0Z3THppc1laODQ4NGVpQzdwdm1acHRS?=
 =?utf-8?B?YjQ0OWM0amJ6QlBEdzBaSDFSeGE4aWZlbVBsOTh6d2ZTaFdoam5tamhpRHdm?=
 =?utf-8?B?dk5ZajR3dmo0bm9reTJzNmRvRkpEMk5nd1lSWm9kTmdYVDUxbU1RS21rTnVr?=
 =?utf-8?B?WEpvMU9WRnRDWTNMSkxoQUVOcnM2VkM2Rm9VMmdvcTd1R01la1cxUGVYNmpt?=
 =?utf-8?B?UWtocm84RENEWUZnOWxZSmVXSVZWdDZ5TkFnVndLSmpOVnJ6T1ppbXVaQlNj?=
 =?utf-8?B?K25VcHJJTUNOcUVDVkVFSDRpYXkrb0pGU3FGbXhBM1FsZTNOblY2SEh2Y0NK?=
 =?utf-8?Q?C2olpWcu8MflR31yh7DHIDG0QHXX0Zxs6WklI9U?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U211RjFjekpwM3pUYTYrWkFiOVZUbFhhQ0t0VTN5SUxTOXFBZWFKREZVT1dN?=
 =?utf-8?B?Rm14TlBmM29WRmlLNWpUbFg3MFUyaWphdnJBS0ppZkNGejdtTFFhZlJZWkU1?=
 =?utf-8?B?MkNyNzlsZ3l2TE5FdTlwUzFaVzd3NFgvQkM5cXlBWDgvTFJpMDZOSHVma2h1?=
 =?utf-8?B?UjJzb1FNQmNQd3A1Zm9tN1N5QnZqYVNlUTdYVHdkTlVva1J4MytLUlQ4aE0r?=
 =?utf-8?B?d0J1cXVYTUoyOU5yaWJ6TmpDd3R5bUJ6SWVETXhWM0NYcE5TQytsOEp3NC9J?=
 =?utf-8?B?bVpaY3lkK0lJNDQrZXArUmJySEM0aE1RVzVGc3ZxelVDcW1RaXVmU0owWHRu?=
 =?utf-8?B?S3RNVDl2NnhoSWx1ZXFSN2F2Wms3V3V4V2h4VHMyYmRTYjNTYThURlpSOUUv?=
 =?utf-8?B?NGRBSERHT296L2s1cUtFZUltWkxWT1ZBKzN6YkphTGtMMEowejRHRkZmVXdG?=
 =?utf-8?B?RURHbFNlUCtrWXlCUWtKbktXNW1RcmE0VFBpK05ZZ2JDeHZJUiszR1BVRVhj?=
 =?utf-8?B?SnB4YWp5V1U3eDl5a01jdTcwaHVCa0ZiWi9Lb1hCZDY0UENtemVGWVZtaEMw?=
 =?utf-8?B?ODA0eG5pclY0VlhDRkIrY2ZUT1MwVVd6dzgzbHc1d0JvdGVudEJMaG14a0la?=
 =?utf-8?B?MG5KejZFbm1nM3R2YW8xbVRKMFlONXp5WFhhdnlJMkRjQUVrWGdsQnVDcjJ3?=
 =?utf-8?B?TE9raEtLKzhLQlgxNWRXdGxwVW5MaW9CN0Y1OWszdWZYcHZJVkh6R2FUcEdq?=
 =?utf-8?B?ZUpJT0VidGxQMGQzdEF1MEtMQysvQ0NXRlNaajdIdzh0L3k3RkxMRDNCZUJY?=
 =?utf-8?B?TEh4Y3kxa1hXMlVXVkF2MExKanREK2pJODhHUXV3VE9KZkNkS3ZEMnN3dnRT?=
 =?utf-8?B?RThaMlBRSE5md3dORFRnNVNpSmpHSlhlZUt2RU0xRytuSG5XNnZZUHBrVGF3?=
 =?utf-8?B?OU0xSHBWQ2VkRFRwQkRXaC9vWXF6eVBSNHkvMVBRMFYwdVBQN2xCTzd4a254?=
 =?utf-8?B?NUNzMVZoMlRweXlkZ0pYck5WN0gwaHhIb3BwYVFlWWJCRXdIYjEySi92ZWo5?=
 =?utf-8?B?Um5Rb1pGQWMwcDhGaUh4Qzc1Qk1JK01ka1RNRVh5Zm1YY3p5SmJCYjhEWDlK?=
 =?utf-8?B?bnl2YmxtakNDcm5nZVFLSXdwdlRPT0pwSk1nZFJYRTVYRVB6TFBkbDhySUVn?=
 =?utf-8?B?aU5PejdpemE3VlMvbVNCS2RMeE5WM3Joc0FJVVAzbEkrd0I2bWNMMGQ1SW1W?=
 =?utf-8?B?c3NmT0hqTFN0bWErZDh6SlhrQVlOQUVoVTRBQ0Z3N2FVeklCMHF4YjlXMTJT?=
 =?utf-8?B?RmhnVVNRVkpkbUwxZENvdlZNbk5nYXpHK0FPLzZ0TFNTY2ZVb2kxUzkxTGJZ?=
 =?utf-8?B?enlKdkI1UlVBd3VvRVMzNDZJSGVybEh2eVc2eHBNZnFCSFkvWVZiZzZuME1i?=
 =?utf-8?B?dURrckYrUHFwdHkvaXhoMHpZa0puVkVBUUxoVDVtK1lFalkvU0tsMVpYSTVD?=
 =?utf-8?B?UG1lSjlVYzFnaElFOFE4bnM5NTFwYmRHdGkwYUtTQ28yekNqYm9wQnkzU2tv?=
 =?utf-8?B?bEpEOVhydlFNWmZwZjlhbkhpODJnNVN4VUNVRk4ydmFlYmJmZTdIUEtqZkJB?=
 =?utf-8?B?eEZxQ1dCMnVKeHFJb1E0K2hYdWVxUWRqTkdXbXhob3YyUEEvY2ZsSms3Z0s0?=
 =?utf-8?B?aHFRRG0vcU54eTk3cTBXRk9TSEsveWZUY0NnMExrbEcwakZxTkluU1ZSTDQr?=
 =?utf-8?B?K2ZTTEp0elVBUlRyM0VOZVI1eWxUVWJFMjduUy9XV21UZnNJeUNPVElQMTBa?=
 =?utf-8?B?S0lHdHNHdHN6TWFmaUc3c3BMYzFSWkdJL2xoaW82cklML0VaL3JRNzNOS2Rl?=
 =?utf-8?B?N0h4UFZEbHJsZ3VNTmsrcnJYT1FrbHRLanp6VkRtUEZySVlLQnBLcVRONjBk?=
 =?utf-8?B?NVk2QnBEUUt4Ulk5M1R2SGdXRWdDM1JCMmQxaXVNYzRrYllaQ0N6eEtlRDY1?=
 =?utf-8?B?NEplRHRNejF4N0xLOFhhV1ptRnZOYWg5bHJYM3RCVysyNDU0U0IrZncxTXp4?=
 =?utf-8?B?bDdZMkkxcGs4aDBPVXZXVXk3NkhDcm9wMHhLcnNkS0xKWG5icFh6Zk1PS2RV?=
 =?utf-8?Q?9dZqSCYH/ROvQAJm7H5bghTis?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	riF3YE5hBqXGSHKhumV7S/nZw2Q/P9nlSRmoT75QUS7hNP10ALJgm32i4YUnwUerBN0xt3yeJ3ybpHwFfwSoTMXi2HxNUfJf1/vTG0cgnHRjNYREjNI6LSFx0jPNHHYjEYc30WlLfE+s08qhzT3b2q3PD7mfVRyA/wRNHjFhaGcLiKcTfrIHbH43EvY1AdYTxj0F5FFvNzSVMPWUvVQRIXHdo388TM4JYD408PTGMh8Sf0pPqbqeyh85SUSv5FhZCWzVffDhgl4B12p1qzYppYEpGs9xmY87Rlw6V0r2SQECy3eNMg7mwflyxiiT58HwczG8N9mT452i5kdZxbc+MPhRjOl5spxqhUHYGG7q7bOzasf4OFRClHiBtS5sKlqaZwguKrDmpacyPWbkpOeo5Xywg/7rwUZMrby8G+9ePk3o29LdAbemdSRcBybSGnWoMYEuWcxQQWuF4Ho6ZhMXs7FHY3Blu16g8nqBzngqGHwyLgG0/1MLzEmHUucpr/y2RKbz8GgwKhlNh7ceEEVTaIaqwrQbBLmYE0nED5M7oD6gb74a3zBCT62QVlbaV0wswbEbX48hlPZRZHa7W1tJJKRu3/65Y+s6Dcxmh3xlDz0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55cd4332-88ab-4fcc-7d1d-08dcf733ee1d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 09:35:59.3246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xTlS7n0Gv4IoA6iPhk6T6JtQSeuCEHXxNazCqqxA7RCoUPP0HE9gz7ZQXqavAhp6Ui6BOnoBjIuwT4JkDZst6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5676
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-28_01,2024-10-28_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410280078
X-Proofpoint-GUID: KeYYB5PxgxiOyNNWRC_04qfG-laerohx
X-Proofpoint-ORIG-GUID: KeYYB5PxgxiOyNNWRC_04qfG-laerohx

On 28/10/24 13:41, Qu Wenruo wrote:
> [BUG]
> During the development to make btrfs pass generic/563 (which needs to
> make btrfs to support partial updaote folios), generic/095 causes hangs

  s/updaote/update

> during tests.
> 
> The call trace for the hanging process looks like this:
> 
>    __switch_to+0xf8/0x168
>    __schedule+0x328/0x8a8
>    schedule+0x54/0x140
>    io_schedule+0x44/0x68
>    folio_wait_bit_common+0x198/0x3f8
>    __folio_lock+0x24/0x40
>    extent_write_cache_pages+0x2e0/0x4c0 [btrfs]
>    btrfs_writepages+0x94/0x158 [btrfs]
>    do_writepages+0x74/0x190
>    filemap_fdatawrite_wbc+0x88/0xc8
>    __filemap_fdatawrite_range+0x6c/0xa8
>    filemap_fdatawrite_range+0x1c/0x30
>    btrfs_start_ordered_extent+0x264/0x2e0 [btrfs]
>    btrfs_lock_and_flush_ordered_range+0x8c/0x160 [btrfs]
>    __get_extent_map+0xa0/0x220 [btrfs]
>    btrfs_do_readpage+0x1bc/0x5d8 [btrfs]
>    btrfs_read_folio+0x50/0xa0 [btrfs]
>    filemap_read_folio+0x54/0x110
>    filemap_update_page+0x2e0/0x3b8
>    filemap_get_pages+0x228/0x4d8
>    filemap_read+0x11c/0x3b8
>    btrfs_file_read_iter+0x74/0x90 [btrfs]
>    new_sync_read+0xd0/0x1d0
>    vfs_read+0x1a0/0x1f0
> 
> [CAUSE]
> The root cause is a btrfs specific behavior that during a folio read, we
> can trigger writeback of the same folio, which will try to lock the same
> folio already locked by the read process.
> 
> The fix is already sent to the mailing list:
> https://lore.kernel.org/linux-btrfs/62bf73ada7be2888d45a787c2b6fd252103a5d25.1729725088.git.wqu@suse.com/
> 
> This problem can only happen if all the following conditions are met:
> 
> - The sector size of btrfs is smaller than page size
>    To have partial uptodate folios.
> 
> - Btrfs won't read the full folio if buffered write is block aligned
>    This is done by the not yet merged patch:
>    https://lore.kernel.org/linux-btrfs/ac2639ec4e9ac176d33e95ef7ecf008fa6be5461.1727833878.git.wqu@suse.com/
 > > [TEST CASE]
> During the debugging of that generic/095 hang, I extracted a minimal
> reproducer which is much smaller and faster, although it still requires
> several runs to trigger a hang.
> 
 > The test case will run the fio workload 32 times by default, which 
is> more than enough to trigger the hang.


> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   tests/generic/366     | 80 +++++++++++++++++++++++++++++++++++++++++++
>   tests/generic/366.out |  2 ++
>   2 files changed, 82 insertions(+)
>   create mode 100755 tests/generic/366
>   create mode 100644 tests/generic/366.out
> 
> diff --git a/tests/generic/366 b/tests/generic/366
> new file mode 100755
> index 00000000..2ebc5728
> --- /dev/null
> +++ b/tests/generic/366
> @@ -0,0 +1,80 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2024 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 366
> +#
> +# Test if certain fio load will hang the filesystem.
> +#

It is a good idea to also specify the type of workload being used
with fio, for example, as in generic/095
----
# Concurrent mixed I/O (buffer I/O, aiodio, mmap, splice) on the same files
----

> +# This is exposed by an incoming btrfs feature, which allows a folio to be
> +# partial uptodate if the buffered write range is block aligned but not yet
> +# full folio aligned.
> +#
> +# Such behavior makes btrfs to hang reliably under generic/095.
> +# This is the extracted minimal reproducer for 4k block size and 64K page size.
> +#




> +. ./common/preamble
> +_begin_fstest auto quick
> +
> +. ./common/filter
> +
> +_require_scratch
> +_require_odirect
> +_require_aio
> +

> +_fixed_by_kernel_commit fa630df665aa \
> +_fixed_by_kernel_commit xxxxxxxxxxxx \
> +	"btrfs: avoid deadlock when reading a partial uptodate folio"

An extra _fixed_by_kernel_commit.

> +
> +iterations=$((32 * LOAD_FACTOR))
> +
> +fio_config=$tmp.fio
> +fio_out=$tmp.fio.out
> +blksz=`$here/src/min_dio_alignment $SCRATCH_MNT $SCRATCH_DEV`


> +cat >$fio_config <<EOF
> +[global]
> +bs=8k
> +iodepth=1
> +randrepeat=1
> +size=256k
> +directory=$SCRATCH_MNT
> +numjobs=1
> +[job1]
> +ioengine=sync
> +bs=512
> +direct=1
> +rw=randread
> +filename=file1
> +[job2]
> +ioengine=libaio
> +rw=randwrite
> +direct=1
> +filename=file1
> +[job3]
> +ioengine=posixaio
> +rw=randwrite
> +filename=file1
> +EOF
> +_require_fio $fio_config
> +

  So this fio drops splice and extra sync and posixaio workloads
  from generic/095.  And iterates the workload.

> +for (( i = 0; i < $iterations; i++)); do
> +	_scratch_mkfs >>$seqres.full 2>&1
> +	_scratch_mount


> +	# There's a known EIO failure to report collisions between directio and buffered
> +	# writes to userspace, refer to upstream linux 5a9d929d6e13. So ignore EIO error
> +	# at here.

  This can be updated with a short snippet of how the workload
  helped reproduce the bug.


> +	$FIO_PROG $fio_config --ignore_error=,EIO --output=$fio_out
> +	# umount before checking dmesg in case umount triggers any WARNING or Oops
> +	_scratch_unmount
> +
> +	_check_dmesg _filter_aiodio_dmesg
> +
> +	echo "=== fio $i/$iterations ===" >> $seqres.full
> +	cat $fio_out >> $seqres.full
> +done
> +
> +echo "Silence is golden"
> +
> +# success, all done
> +status=0
> +exit

looks good.

Thanks.


> diff --git a/tests/generic/366.out b/tests/generic/366.out
> new file mode 100644
> index 00000000..1fe90e06
> --- /dev/null
> +++ b/tests/generic/366.out
> @@ -0,0 +1,2 @@
> +QA output created by 366
> +Silence is golden


