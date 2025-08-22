Return-Path: <linux-btrfs+bounces-16270-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4975B314D9
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Aug 2025 12:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3AF17BC183
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Aug 2025 10:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4738C2C0260;
	Fri, 22 Aug 2025 10:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lQFYdRP6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Tr9azZvC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17572D0C8C;
	Fri, 22 Aug 2025 10:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755857487; cv=fail; b=RgS1RClnrKGHBpSlCmR1r0alMPrLSakE/yAyW3Fy/Lt94iOw4M7qx0wW+v3nqCv41rx8rh+V+55T/QwiHcdUlpVu0OXnSolld54+7TdAJEgrjS/LeSPBBr2OwSuXURGjDo5imoRQbeveUM+au6fen0QvtX25vt4ey09ze3iWmNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755857487; c=relaxed/simple;
	bh=Fmd3biCheyT3mJ+Drl8LXdl9dtPArBW9BNjqYVQUyBQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ttxT+NWr2N9CK0CDshlbTHA7HsB5DgJNFw34/l5i4kFl/uiFQl4z9e7kgzoFgvTDM6m3L7wU1kWfRcGb0M+Ow5+ruChx0iJAv8WTH5Q0wyV+33XfdUlsCYc4zxEbfFG/BfvD9BaY2johgxKmW15FWFPDU0JOSelIZvViw/LYrEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lQFYdRP6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Tr9azZvC; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M9vkP7026102;
	Fri, 22 Aug 2025 10:11:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=e50jr3AXQyPm0GrAbcKeHOJxfcnc5TgI3+YfNQntR58=; b=
	lQFYdRP6Ev/i1AnK7y1YUyIhCkYC0UMzCV+JB6BOzDOAKQbbyeJi3OqRkMroeHqD
	IqD5X4C+xUtHlz0vcXfF71PNm2yhoLECXrdjGNJY7X6skyOn5ZS950prjahvwx57
	L76jyGfHFKWgZ5Qi6hWR8Q9TqEe6dYLPcTdO+zWUTHnJ3zRYvbAycXttLwwVflR/
	DFTOP+IUUxRO2QLCjQGoOdn9sZK1S7j3ORVjeTx7bS8p9xjc0aizhHogoxNQvlBH
	Yykq1i/sCYHU85fxr8vaCX0Xis84BYNNxqiv3fLVgCFHWc/Ol/Vv0koERcR7x+10
	S/3fKq0CiOQ1nT/buec6NQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48pabh8usw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Aug 2025 10:11:20 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57MA0p1u007290;
	Fri, 22 Aug 2025 10:11:19 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48my3t72fb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Aug 2025 10:11:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r1B2mm7OBb2sUMYZYJxnKBnMp8b9m3hcBsti4ir/D48X6FR8lMcALT4cPZOMqNuaEVQ3OBEerCoE86TfzbFGBnRsDqhMrpu2b8wX/px74qWeXIWx4i9E+hLT+tn3fcQvAH4ETLp0T7LBCc3Econ4FKzIQrKiR4ieBLEY52tZhmTHh1pIbYSJhVfHVb5Qinm6txrgT37303Ym5QQuCIWKgCdzjDq9y7iRdBK4mQv8NEl5y/PLSCuRzzytlBfWh1Lj7o0KmNV3jNLAizUPPbMy1XioWLlwY1YVNcT0XDhKzJXV2F3A2zlX1qO5hgWjYOztWA3oWTFuS7UdJ9Y4pNI+1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e50jr3AXQyPm0GrAbcKeHOJxfcnc5TgI3+YfNQntR58=;
 b=JpwqSW967asd/MNAIGSdG+BQTVBME6THkgpZUrUlGdF4tmSazmTXzDXNnlPMepKAiBWaj7mmbOvSWr3lb9N3KeI22BzAEtyH1wdoIXfTMN3TG+sTPhIOH2RXevmKQTB8YP32z0X6KpKc2gDnnJ2mO7IOJeICmH72GkSwt+QXUzNJIwP7JHC4sORiLvBNP59m7okm322HDv+Fr9xmMitl9EKfrYCANRl2mngUGAhIaSOFPU4C2pLDRnEE0n6mg2YHQCanrd3o7O2MWcuKNMv62l+8Y/Tt/Avj9/2iOMTswY6GA1syHL0WT3uQj9QH3uFVzM0ANKtMKQs0cYHmacYeQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e50jr3AXQyPm0GrAbcKeHOJxfcnc5TgI3+YfNQntR58=;
 b=Tr9azZvCX8JDNLZGi0kzkT6q6KG+sFOPg9PptlJ47gtUmrmLEqaF/czpjaicTbhtYuLGZ9T25N8JIpzelVIIlo/esQhM3+v8HRtg0QNwO0PCJxE+HX+unu4WIHhZovf4y7WG3ocqI6OFcJ0llOh4eQaezlPSOaIumybp1jJrBzo=
Received: from DS0PR10MB6078.namprd10.prod.outlook.com (2603:10b6:8:ca::5) by
 IA1PR10MB7485.namprd10.prod.outlook.com (2603:10b6:208:451::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Fri, 22 Aug
 2025 10:11:17 +0000
Received: from DS0PR10MB6078.namprd10.prod.outlook.com
 ([fe80::edc1:7c2:8fe8:a6b]) by DS0PR10MB6078.namprd10.prod.outlook.com
 ([fe80::edc1:7c2:8fe8:a6b%5]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 10:11:17 +0000
Message-ID: <5360c391-fd92-4891-ad31-c4b3038c8a3d@oracle.com>
Date: Fri, 22 Aug 2025 15:41:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tests: btrfs/237: skip test on devices with
 conventional zones
Content-Language: en-GB
To: Johannes Thumshirn <jth@kernel.org>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20250818095338.66277-1-jth@kernel.org>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20250818095338.66277-1-jth@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0P287CA0014.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::16) To DS0PR10MB6078.namprd10.prod.outlook.com
 (2603:10b6:8:ca::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6078:EE_|IA1PR10MB7485:EE_
X-MS-Office365-Filtering-Correlation-Id: 93552655-7797-4a34-44eb-08dde1643b33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MWJsS2dtRGovci9IZGNKb2hNaU5KcE9INlo1NVZWZks3VFZ0RTRWREpzY004?=
 =?utf-8?B?ZWI2NHkwSElIYXMwUjZyenZWWUUvSDFsczh1aWNOc1g1VzA5RngvdmxYSzZQ?=
 =?utf-8?B?cUpYNEM4OTVaOXViT0ZJWWx6eDcwSHhoY2lvb3hFaS9JN3h3SThQeFJzU3lm?=
 =?utf-8?B?SGFYV1dUVSt2WGN3R0tqYnlRam5BTTZ2N2hzNzZYalBKcXNzTkhkbE8rckoy?=
 =?utf-8?B?MmNEZHZqOGFkZGFWL1l4TU5id0JUdG9NaUhqL3g1NU94M0VSVWtpdEVxeWRz?=
 =?utf-8?B?TCsrcXR6aWIvTER4SkozRHg2dXNBcThMVnl0czJxUGdJOTYwdStad1YyTHh0?=
 =?utf-8?B?czVqUVZjbTNQZWVrbzBsTEdCOUx3cHBINzZNdk5vb01FL2grL1Q2VWJqSmc1?=
 =?utf-8?B?TnFFeTF3ZGEvZU8va213eG4yNHIzVnEzMWJmSlRzN1VNMC9CanRvUVFyM3M1?=
 =?utf-8?B?Kzh3QnpnYm1mM25OYW5GVUlEcG51cHNhbWRKYjNCSjlsSWcyMnVxNVFkZFhh?=
 =?utf-8?B?V0dsZmpCc1RHWTMwRXV0QS9HbkplV3NjYmYzaWpBY1JINjByQjlVTFNDRW1q?=
 =?utf-8?B?N2VRQldaYzVEcnB6b2VsZXA5ZXk2VWRzTkZnMHQ1UTRZSHRFMHdiWnJ5c1Jp?=
 =?utf-8?B?MVMzbkFMcSsyQ2NYYzhFODJRT3l2RWkzSy8vN2taSEtTUFhmUFM3RUd4d09s?=
 =?utf-8?B?T0hnNGI3di83Mkduck5pYXlGa3Q0MVd4OVlkQ0lHRVpTZlZrL3dBTlEvRGxk?=
 =?utf-8?B?ci8zZnZFMktRU1BQTytJN25kMnVKb2FJaHFwaVFuaVY0Tm0rZXUyM2pmeEhO?=
 =?utf-8?B?MXdsTG5BVDJwWGdDRjRwbE5kRDBVaGV2U2VsbzQrK0FTaHhXZ0FTb3RlMlU0?=
 =?utf-8?B?TDYvRlR3cVpTZHlLRVNCVFRBTmVmYnVrenNtRG01ajdOSktwTS9oVyswVzdF?=
 =?utf-8?B?OG50SWY5TVQvZnJLWW5JeG9IM2l5VVh2YlZscFJEd1BLb2MzWHViQmhlcDg2?=
 =?utf-8?B?WDU3Ykd0c05zSmptc1F2T3Jmdys5ZFR5eEFTeWdOdEl4Mmd5WnJhaTlmUXFv?=
 =?utf-8?B?cFVCYU5tNzBHWTk0WERxY0p0UlBQcnliVVlDWW4vQ2ppYW8zTFhkRzZPeUY5?=
 =?utf-8?B?Ujg2eEhwTkxibDdIOXZNeDNMM1F4blJUZ0l1SDR1SlcwMExXY1U4d21PWTdD?=
 =?utf-8?B?ejI0YUNYbTZ2YnVkY3dIUm10bElUc2JOOTdseUlTeDdOKzRzMEpkQlcxeWZN?=
 =?utf-8?B?bFN4TVVGSFR0aW1uZkVxZXN1YVU5anovUkVFalF3alpwQ0tTWGRGNm5hQ2xi?=
 =?utf-8?B?MXI5UTU3bGN1TkRtbzFTaGNRNDlVQUVpRVk5UVNPYUMyZGl4R2RGYVFhSWls?=
 =?utf-8?B?RjBValBJU29KeTNSMTNWcS9keXRZZks5akZXV0xkNm9WNGEyZUxNRVRlU3FK?=
 =?utf-8?B?eitYQ09ZeUN2dWJTZktZSEtmSjBMVnNuWFMweFV2cFJ1L2UrVUxhcjFiYTFM?=
 =?utf-8?B?MGxoUDMzZU9pbjc3ay9vSTVLQXJCa3d5RUZwNmw0T0FQY1JybGZ1Tk8xZUV4?=
 =?utf-8?B?b1dOV1NyWXFROWt1YlZKQmdZQklxNzZIOEphR2JHWkJZR0duTlVvdFZrSy9o?=
 =?utf-8?B?RmJZUG16TjZBb3ZwTFBTUElNM3Q5bjZpQ0xBU0NxeHo0K1E4aG8xUEsyMUJm?=
 =?utf-8?B?cGpHUG5OaXh4RTROaytqSkh6QVdONzRnb2VLOUhrZWtpVEF4L0xsQkhSMlFQ?=
 =?utf-8?B?cnBBR2dnTW5xbGMwcGVJWnFiYWcvaUU2aHU2ank2TkUrM2VKNDZuSmFpR2sv?=
 =?utf-8?B?THM0OGp6SUMzVlN4MGdycnpDUWFpYmhJQnBQZW9Xb000VkV3QVhsSWdwQ0pW?=
 =?utf-8?B?YktTRExLSGQ0MjlrUkxkMjFFb2NaSU1xQkZsQytCWEJSZFo2clBiRXdSK2dS?=
 =?utf-8?Q?HeJhKotqyOg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6078.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QVViN2YwTWJxNlkyWWhRamE0bFR0d3ZkM0x3aFFiZk5GVHhaTGhzTGs5eWtG?=
 =?utf-8?B?eUw1WnBMeUhzRWZTMWlmU09GdDVEOXVQb0RUeVcrbVEzVVlmeDFyY0RZc1pm?=
 =?utf-8?B?RkZ1M3Q0NndXbGVBRlkzVUw4WTYyRytsak5RTkhJSytSdDZzMVRvcjdoUjZQ?=
 =?utf-8?B?RHhrTG1ya25FL0JWbHdLdGdIRFBYOGNQT0g1S3pxRGdmY1AwNmZNbmhVdmFE?=
 =?utf-8?B?T3pDWmM5bVRhMEx4WGJPYjVPWVBwc0NrWkhTa2NJY3lhNlFrY0YzUk45SXlY?=
 =?utf-8?B?TE1UcnF0RjFzSWpVMHRNMkhIZHFkQVFWRml1NWdRN0lCQXdnNzZ6L3hjU3h4?=
 =?utf-8?B?YnY5d0trenRCVlluZHVhdGQybWQ2NnJTNDBPaGVtbDNLaVFHV3FNcTBuTWh0?=
 =?utf-8?B?R0hkQXROWkliRUlBcTJ2TTA5STEzZTE2eGhWVVowQ0tJQ20xSkF6M2wvNTUy?=
 =?utf-8?B?Mm0wb28vSjJBV0c2UXJrUFRoYnRhNzYyYkdRQWJQRHB5OTBIUmZlZ2trUDcr?=
 =?utf-8?B?OVZYNzFaM2N2eHMxWWl3WnVlNGI1cEhqN0IvS2Y4TThQZmozRUFUcEFuWW90?=
 =?utf-8?B?VnFYT1g5VkNQZFBzNXJQZXdxVWRHdkRSMG5meEt4Qm5Qa1E3WmhWZzkwWm5T?=
 =?utf-8?B?RUcrSU0yT0RpU0MrN0JvZFFzQ1NHZHlNQ3ZiaENsUlgrS0FKM1l5eEFwYmda?=
 =?utf-8?B?ZkJ5Nmo5NVJ5by9tUEdBZC9GS0hmWUlqeHVmb0l1UzBVSC9iN0VSZVdROE5R?=
 =?utf-8?B?ODN6eHM3VU9PZDRJV1RYa0d4WFNwWklqVXNVdkQrQXZ1cWpWZkVBSXZxUWpS?=
 =?utf-8?B?RkZyS3M2YnJLbm5RQU13UlYydFQ3VHpoVzlKZGRNeWRsNWdSdHRPcm9wR1N3?=
 =?utf-8?B?cmpXdHJJOFRkcUVaTi9BaW1oWCtEUHZuT2krNytrVTZUVk4yV3p1UlJOL3BU?=
 =?utf-8?B?ZFNlZmU2cmJ2TVJ4VU1UNFlYZ21UVktacFJFSjZ4SCtqY0JWTjBCaTc3SFhX?=
 =?utf-8?B?cmJJbGc3YytDQWhZZ2FGRFpUMnlDc21DQ0k0NWpvcVZFM01jUHJDcm95dGFQ?=
 =?utf-8?B?SjVzL0JIdDd0U1JFditLYmU1clQrdVBuMkFWYitmcEtaQUZ0dzVqMWRWL0Nq?=
 =?utf-8?B?Z25jY3ZXSDlscVRxRnlRNFk2YzdkWnFHenhyKzBzUlBhSHNQb0orYXNyZVh4?=
 =?utf-8?B?dU9HTjAzbEt4YVE5WlcwVWR0L0U1NDN0eVZnQjBUQU1jTzFYOUZ3bGpLQW0y?=
 =?utf-8?B?RXNOaGI0cloyR0hpVFl0d0tTdE9FRlVlclQvYmtzOC9vSGt2cGc0ejV1c2gr?=
 =?utf-8?B?TUJ0M0xLeTh2ZCtDUFdscVRWY0FiOWNQMmc1NlNoZFhyUk5vQ05jNm1wQ2Nq?=
 =?utf-8?B?RURDZnZaaW5KTlVpZkpLYUVlOENYZDljZXVSbUxxNjNvdEErSmxIdS9nMEVj?=
 =?utf-8?B?UEUzVDFrS3dzdHZNaTVYeHFXYThPeTNHZ2Rrb0dJTjUxeVltR1RneUlkQW12?=
 =?utf-8?B?N2lWMXlqaDJlL3RNMGZla043WVJVcng2OXduNXNpTEd1d2Jpbi9yZzRudXVF?=
 =?utf-8?B?RkdQdzgrSEJXdE1Ra3kxOE1GekZjemE0ZHBIWUZ3SFdsN3cvQlNaWWdEbE93?=
 =?utf-8?B?LzFjMy82dVc5elAyaUFnVW9UUHMzaGI5dTJTZkU0dVc2Tzh1SkgvZHQxK25M?=
 =?utf-8?B?a0VEelByc2JwOGY4WG92YjZzM2Qwemo5blYwWVB5L1IreTM4K3g0clFkRVpW?=
 =?utf-8?B?YXArMzdBajZ0R0ZxU2s0cUxBRUdvWnVUODZuaStFTkllZ1VaNzE2U1lscVNt?=
 =?utf-8?B?eXFldTR3Y0hpT1BsSDZhYlBEM05Rdm9kZ2ZpdGNwVU96c3pQa2dvY2ZpcGRC?=
 =?utf-8?B?TWkzRW9NOC9XeXVVc2FGV0xGT0RBSWtyemJZOUlCd0phR0pHSXBMQlNwSG9K?=
 =?utf-8?B?ckRFMFpncFViQmFmUFRWOEFMN3NKZnU3QUVUcCtZWHU3R1pMK0l6STFNTVE3?=
 =?utf-8?B?MVVSVWlseWNEQTRMMStyOHVieXFNSUEveWtvQjF2ZEx4VE1LSW1TdnBROStX?=
 =?utf-8?B?Rm9lai9lRlp1TDRrN3lMTk90Nk9rUHVjeXBUb1JnVjVBTW5vOWNEa2RJZitG?=
 =?utf-8?B?dGM1OGhtbVVWc3Bxa0hFWW1uYkhhTmpzaFlueE5RWUZ1cjhHaHQ4b2p3RXAv?=
 =?utf-8?Q?cqTUxvCaB4YzkugQ8oW97ZYiNVC1YsGZBw/EtUf5mD3I?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wKq8ZEirYWPQrYd2IICevsWSAJbMCtw4OWxVu9gTlA+UecHpZ5YY4nV8ro2oHtPc6x9AhUpyxNFXnEgBicWYrifoA8sz02++i68sSGS0k9IQpHwMRHN9AzTK8QuqohkqAXnjZU+HR4xcYo92A7rQ2Z5AiqOyTZX5rMY/1ldlZq4GAzTDNkZBIw4LbpxsDa/Q6oALjna1D20JA+TzsXFSUXh7fJNDSdCg+Puo6B728bocFco/kYnxKt3Z0jPF/QEnIaOrufuoMU5xDB9Ap7iWXDUhPIVFVUeQLNAJ5pmM+0yN1+6rdrgPG0mzs14V95xQfKHa4Aq1tRTdl/QUiZ+ch28j+TtYiZ/Z4e1XHM0npA7KN032KCjBRFk1TSiQe1hgnP1SwgaA5Hm0NdIt7xOdEg/0wE+/WnY2TnV0mibQ4fK0MfE5Ep5gVI8jCBURy9F+FBgg4QLBUJyZnXW193VMpCjV2sQAuE83gaL0lFgFRn9tgR639cm2bNL3ZIG/75GGDcsFDsmR3wwGt+FYWF41381vSekM09xu0T3KeF6Fbg63EXNW8rNFtHcZJyBmM5hmFrQdxDxqwXUCF7ZI69X6a7ZOZll235eoVFxLlCjK09M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93552655-7797-4a34-44eb-08dde1643b33
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6078.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 10:11:17.3044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZMn3gBGThe3eddG6FCLe34cp45mVXfzSBNHBF0JcIa6RXDg6/lgBMjMbS8+ABx30M3UdJ2kh88IVRGMpEarGiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7485
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508220095
X-Authority-Analysis: v=2.4 cv=E+aUZadl c=1 sm=1 tr=0 ts=68a84248 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=JF9118EUAAAA:8 a=yPCof4ZbAAAA:8
 a=oQERPQ-8MmVjASnDL9YA:9 a=QEXdDO2ut3YA:10 a=xVlTc564ipvMDusKsbsT:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: u8zbGzApNA_NZw8d1vKIrua3DmtyQsTm
X-Proofpoint-GUID: u8zbGzApNA_NZw8d1vKIrua3DmtyQsTm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIxMDE3MiBTYWx0ZWRfX5jdvjVL4pfTS
 jJZqwRZD9lHsaJbZZYnahv8Mb24997xfHQ7qzLGFYLdmtRp6JzhP3yVhOz3+NHH1MdxLAbeQC69
 1HTtbJSK6ZPKzbCAqikZ0XGpImcf4dok3YyDh7+IuDAkNmTI5czF5j3G/ehgW/I/w0S+HdBedl0
 CnEKMLizeSDB6tnvlQh/mKkpTPbDq7uIC8ZjWWY9ZoPZ1ACaobkZZSn1j+0uJOIt03fh1t5VYtc
 kBJBcGj1meREK9dPjcvhcXHGs56b0sbXgXXh0KDfGQfMepPNFrsnt1IsSeTh/AaxFM00/ugVBxq
 vE1eHh00ZKRqt9jHiaoz+1PsMpVvfG1cMp91E1twSpfRxDk1qXO4hOvP9DyEPBEQwU6spSD6cRX
 wODblAsFi1OIy+18jV24tvEfhlhRKg==

On 18/8/25 15:23, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> Skip btrfs/237 on devices with conventional zones, as we cannot force data
> allocation on a sequential zone at the moment and conventional zones
> cannot be reset, making the test invalid.
> 
> Furthermore limit the output of get_data_bg() and get_data_bg_physical()
> to the first address.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> ---
> Changes in v2:
> - Use 'tail' instead of 'head'

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks, Anand

> ---
>   tests/btrfs/237 | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/btrfs/237 b/tests/btrfs/237
> index 2839f6e4..675f4c42 100755
> --- a/tests/btrfs/237
> +++ b/tests/btrfs/237
> @@ -28,7 +28,8 @@ get_data_bg()
>   {
>   	$BTRFS_UTIL_PROG inspect-internal dump-tree -t CHUNK $SCRATCH_DEV |\
>   		grep -A 1 "CHUNK_ITEM" | grep -B 1 "type DATA" |\
> -		grep -Eo "CHUNK_ITEM [[:digit:]]+" | cut -d ' ' -f 2
> +		grep -Eo "CHUNK_ITEM [[:digit:]]+" | cut -d ' ' -f 2 |\
> +		tail -n 1
>   }
>   
>   get_data_bg_physical()
> @@ -36,9 +37,13 @@ get_data_bg_physical()
>   	# Assumes SINGLE data profile
>   	$BTRFS_UTIL_PROG inspect-internal dump-tree -t CHUNK $SCRATCH_DEV |\
>   		grep -A 4 CHUNK_ITEM | grep -A 3 'type DATA\|SINGLE' |\
> -	        grep -Eo 'offset [[:digit:]]+'| cut -d ' ' -f 2
> +	        grep -Eo 'offset [[:digit:]]+'| cut -d ' ' -f 2 |\
> +		tail -n 1
>   }
>   
> +$BLKZONE_PROG report $SCRATCH_DEV | grep -q -e "nw" && \
> +	_notrun "test is unreliable on devices with conventional zones"
> +
>   sdev="$(_short_dev $SCRATCH_DEV)"
>   zone_size=$(($(cat /sys/block/${sdev}/queue/chunk_sectors) << 9))
>   fssize=$((zone_size * 16))


