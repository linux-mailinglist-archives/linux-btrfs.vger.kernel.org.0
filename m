Return-Path: <linux-btrfs+bounces-12929-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 844F4A833E4
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Apr 2025 00:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5655819E8895
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Apr 2025 22:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C09216E05;
	Wed,  9 Apr 2025 22:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bBbheHv0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HFyVEdVO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1981213E90;
	Wed,  9 Apr 2025 22:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744236317; cv=fail; b=VSsEmFeI+WBB9884OYQwQEoC8Yy8fOvaEB2X7PpQs+KEaPdzUkaKNsqeg2fVZ60SZ1Edy8mB90muuvXHMslNIqaGi6Gl/Aqa9mats1Rlsrml1zP6heO0wOxJn7/qYh3k+ZBxDzMxI2aeiKmFcnKllJK/MpIME6vJQP/JGgT+/oI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744236317; c=relaxed/simple;
	bh=c6RFmaOi3H3xbAoTlGHChoPMJYy0TqMv3jrdqvlEoME=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KWR+MYC07ZWlwJWG1l6HTvWSBaFJQjys8Egou+5Exf/k5zjcqk2Xz2QcJNMjUCu7tHJLhk1yt+QHH3XiLEwew5kI4Rhqc+NqvMHIuiIt6VYMFPTusXeG3PxBztnrOp1kdEzR+JVK9HR41N5CBun5biZaogXhYvLXWhAMObQisMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bBbheHv0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HFyVEdVO; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 539M1p3c013613;
	Wed, 9 Apr 2025 22:05:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=2XbEYOl7yHP8xJwAtRm/V1eLpqrMOZE9j7WeKkECrNc=; b=
	bBbheHv0UqKheyDVcK/cpccwmw7bxx9HCv4G9XcvJuB+oYwF7OQTGgauQ1OqLS47
	BgXPRYlWIFY1BER0wdGrB54qPNsW//aaTTBYQygKQo6pVdmyYtuDuZNRc8hK3vmJ
	PJx+nWYE1Dfyga8zu7hKm+dPoQKKfdojX3KFFxOg+fxWj9+xnJ5wabkp3KMcmUoZ
	hgd5cZ0iclNlHNFGiFzgk/RwydUvHLX7MCvKFSA/t3CZjwB0ewgmonQIX5pCv43G
	qgF7R8+X90a0+R3mdBSdTj24E15SluTBvkniW+hLLtNEykeXUJP/mSJ08yacfUz3
	TBLdzxtr5geNWH1kxdiDSQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45x1b0g069-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Apr 2025 22:05:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 539LffFq023777;
	Wed, 9 Apr 2025 22:05:11 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45ttyhqj3k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Apr 2025 22:05:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nyoEkDcUk0GCW5PJJUn2fiYrcSa0jN+zd6MpzpM18BGbphnFO2Za3WYSVGc9/ny/ChPoi2fEp8BwgunFvIWHGRoLYQknGKtZjIz/I2Hr6nUMeojXk3ojvHnyo7MtDmCGBJ4ecGdfVQOrfXvdCgbeMDOjdAwTuQmpp47t3AqFL6B8OuHW7OBEDPsmqbjVP2yMuqu284NUfTyZ4bKOxiDU/sEnTb+eRFDtQY00MUUqqAdX3awgDduJw3uxw76V1aK7FtuTJZnHb2wbgIuOJX4fCzHCMMNZyUUUxN0JAeQf2tpCBDtOAyLbBJxe5BkbNFGE/Qs2W+3Q5zMHHpP4QkZP6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2XbEYOl7yHP8xJwAtRm/V1eLpqrMOZE9j7WeKkECrNc=;
 b=OTdnPh0MdmeGEUFkYX+yWgrbFp8R8wXZ4ZnA4XT+X18GZgFyuU+DokxSc/cJnBD7sb80QUv6WIU9HoWYms4aNwTd31GnHWt01fewvIrKj8+lEIJFg7sVPkll14UnrSEM8mNPuHyBVB2RoHPPDep5wsYNzZ+3rXp/Ccbs1QtmaITTm0fAsTLQU49UMeWRSrVWjh+oZRkdBjBeVCaEfV6AT/KuFMesIGbDXNAtTGG50cWySriNwE6weOpqrZP8mPMI1/8vh9MzKeLRAYeWwXLFiX9GQB5ayux/RF3mRkLtC3aIIhYujeW1YMO/j0iXExCMpZ+Jfrb/nKIfGXUQYkn2fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2XbEYOl7yHP8xJwAtRm/V1eLpqrMOZE9j7WeKkECrNc=;
 b=HFyVEdVOIsua2Ft9lpooWDKonijbKPRsfc8z7gqbDEEJHhEQ8gFP2OCJ+e4EJNxzSoFKO5qK9FX4H7G1E6Wq7wdccF7menNkOSd+5YSM66r6RVNF1U/fadb6FDk7iB4yZlkPYeaeRCSE3mZ3wyohejLX8JNmx7x59XE45oIDBjQ=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BY5PR10MB4163.namprd10.prod.outlook.com (2603:10b6:a03:20f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Wed, 9 Apr
 2025 22:05:08 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8606.027; Wed, 9 Apr 2025
 22:05:08 +0000
Message-ID: <aa1d2f51-135f-483c-bcb4-6e09761d1274@oracle.com>
Date: Thu, 10 Apr 2025 06:05:03 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fstests: add btrfs standard configuration
To: Filipe Manana <fdmanana@kernel.org>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <cfb8c19533ac3c764edc1fe62b7fde75e76579a4.1743137470.git.anand.jain@oracle.com>
 <CAL3q7H7nx9D_CQhWXNGjBcZ6We+B3qmsGdpbG_p0qdCHM-dpfA@mail.gmail.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <CAL3q7H7nx9D_CQhWXNGjBcZ6We+B3qmsGdpbG_p0qdCHM-dpfA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0052.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::21)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BY5PR10MB4163:EE_
X-MS-Office365-Filtering-Correlation-Id: 540acef8-68ba-41f2-2878-08dd77b29720
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?emY1VXNiaUVaM1QvS1NLNmxkblB3UUIwL1NtVXZqejBUd3hwVTkwN1NLdFg3?=
 =?utf-8?B?NElKWmtHY2FyK3RlVnFQUGpGcXlrUGFGUDA0MGVxU3luYjg4WkNxbk5Vb282?=
 =?utf-8?B?WUQ5UVlIZjFaOHU2UklEYTNPWnJReXlrNnlLOG9Ibk9pc09zdlVBUnRlczBy?=
 =?utf-8?B?Yk9NS2JmRDNiYlBLRU9ZVFJzWXU4Vm9Qb3Q1bTFJSE9uNjF1cGJiemxWVzNV?=
 =?utf-8?B?NUZIK0ZadzdjSzNPTE9xY2UrUTVaYXhvejBKSDNzeGxtSm8wZHo3Vy8zQUNh?=
 =?utf-8?B?UE9oZTIwYVhiaVhQOWVEYTRDVmNXRlJHMUpBOFdyTktCRnRpeU1oVno0ZDMz?=
 =?utf-8?B?UERBK1dYWWRRcDYrdTc3dk5BTmpVNDI0QXRMNVVPWmpQbmNCZHB3bzFuS2hX?=
 =?utf-8?B?L2NlNUh5Y2V1TEQzZW56eUlPYS9neHFpQWlxQk5rVXZ6dkF5WitMdFd1dnF1?=
 =?utf-8?B?WTFJOXdVV2lIVGc1MmNDRkFZbzB6NG5lVDc2MVE5TU9vdXVhMDh5bWZDTnov?=
 =?utf-8?B?ak9PYmxaNXlzSktVNWphQTJJbjlJZnFCYlk3OTI4cHRER2RVNWpNMzJuMkwy?=
 =?utf-8?B?YXVHd25QZE1EcG1JZjlkalpkV0Q4SWZhcUZZY2k1VEZuRzBjeENwcUtGOXNW?=
 =?utf-8?B?alJpck00L1VZNnhWS2RaRG52blcxR1JZMmh4RjdhUkkrV3YvaUNsUHFoY04x?=
 =?utf-8?B?RUFpOEs5U2FvcVFrak44VVI3UzlZMDhzWnRPQ1ZFclhtUU9UMXZJNnJHMW1O?=
 =?utf-8?B?TUk2WEl4U0VVejVRRlBDa2tiMUljTjZFRFd2bWVzNzBuUE4zWmRaSzhDMmVk?=
 =?utf-8?B?MlBTbXNaQjVYcEI2aFAzNkhEZG1hNkd0UjBFUnpBMktmTGNRengrQjJ5RU5J?=
 =?utf-8?B?UThaTitLazNBNldmTnpkOXVZSmJNa0lodWxBY0VwTC9EdmREUm9kUzE0Q25T?=
 =?utf-8?B?RGJ2bzdYREhnczR2RCs0N1pqMTBkVUhleDVYS2ZOcWVkMmZMKzdZa201emZM?=
 =?utf-8?B?aXhWdnpHN21NbVZEMTNYUGtMeG1ueE1ibmNpWkRZQ2QycDVRVHlROUw1OW85?=
 =?utf-8?B?T0NDWlk5MzFBMXRVdXFUN1JUL1pnNVJKNnF5VzAxd1o2Z3hUN21LVFF6UThY?=
 =?utf-8?B?MFpONGRoWVNkRDdMYS9LRXAzSFpBUUhRSFU1REVMbjFUOTF6Uk1sdklKZ2s4?=
 =?utf-8?B?Q0J4eFhwdHRFMS9xRXFlWjVPb2RLS1ZwdFRvNndoTk9zd1lZN1FsL3MwU3hW?=
 =?utf-8?B?Sy8yUmlNLzMrZFRNNk1yWUoyMTBCNWFWNmhwRzZuSWhaYVJmYmt4TTRkanNj?=
 =?utf-8?B?MWRmb2RFc250dTRRblJ4dG1HNUVCRFdXdjhuRkU2TEVUSTlJeXIyb0wrMkFy?=
 =?utf-8?B?RTMwYno4eUtyNGFtdVVOWGtZQmcrQ2J6ZzdSYUtrYUI2TUNvaUxZRkdvL2ZE?=
 =?utf-8?B?TnBINUpJSmNCWG53TFUvRVRnZUU0VEx5dVd4QU5iaCtLR0d3V1hVUlBDTjFK?=
 =?utf-8?B?U2d3Y2Z0U3VTejZrSE9GMEt1ZDdsV0JqeWE2S09qVlA0ZmE4eCtBTk1hblpL?=
 =?utf-8?B?NVNnbGYvMXVsWWw1WVpIaTJJWmZzbXBXdDdKYzE1Q3gwZXNNTWZ1am5VODRZ?=
 =?utf-8?B?YkQwNFFObHhtcGpxTVEvV3JPcEl2aEVPdDl4bmhJdHljSCsrRHdoUVN6NlVG?=
 =?utf-8?B?WDZTSyt5Tkwyc2YzWXZXbi91cXJIWEFJL0ZCRGZWUzhHTkc1bTlRTGhoMEFG?=
 =?utf-8?B?THRDTDFpTFliMXIvY0wrVEM3N0IzZEZvUmlIR05kMXhxZzBIMmQvQXdWN3d5?=
 =?utf-8?B?Nkh1Wk40VVJQVzM1Zkl6NTBZWDVVK1krUm5yNU9CZXMySTkyeDRjUWJ6Z2JQ?=
 =?utf-8?B?VDd3dFJCakdoWUNkUzRKTG4vQ0RIbWtnQUlycExRd0pxVzJpblZhOEpYZ05Y?=
 =?utf-8?Q?Ipwq2nY0fS0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZDlzcS9obFdNVG83T0xmQjFSdEh5TE1JaTRTbSsxcnVuekhCT09KRXJZQmtF?=
 =?utf-8?B?N1pLaFFQeU1tMHl3WFdWYVZIQ1lSZnMyS002RFUwUG1TNjUvc0gvNm1XaXpq?=
 =?utf-8?B?dHV1WGhsVjYxSEJWWFZPNG9DbVhTNWY3YjBJdGV6aTM4Zm9WYlhldUx6Uzl6?=
 =?utf-8?B?clQ0YnBlZGZKMUxrRjVDbTVPenlsRGRrNmJHZ3BkUXdsTmI5c1BZYWZGcEpU?=
 =?utf-8?B?SHA0c3Q3bWg4ZVBzaWczb1FLWDFiUlFnOFdKQXFLY3Q2Z1dZcGd5dGphc3FD?=
 =?utf-8?B?bXFPeEhmRUpmZUNZQUlJSndDcXFBRDJmOHgyak8rY2NTNVZTVUZxdWJScVIr?=
 =?utf-8?B?US8vZ2FYUiszeXRjK01Uc2FXeUhFQnpIRmhqRFdmaGNHN0tuUUpoODJsWURl?=
 =?utf-8?B?MmpmdW9OUXczRDhlOTNtNWwySHhBRGRjU3JhTnoyeDhLQkg5TDJWdzVZS1pK?=
 =?utf-8?B?cjFxa3ZiMTlJSms5VDJLU1lPT0d1ZkFrMUpUazZZWGxDcklJdVkxRW1RNS95?=
 =?utf-8?B?YUZHSFQvaWhIK0gwc05XSXJxTTNGWUhvTEVIK1B2bmFpdjUxWmJvT1B1RHZh?=
 =?utf-8?B?OSswQjQza0NyNWw5RjEwOTVFaGkxYzQrZUVaYUo1T1c4aVRxUlU3bHNtWmhk?=
 =?utf-8?B?TGNzS1FrUUFMc1lvZmlNMC9WcVBxN0g3UTh2MngyTlRPQnRJd0FmNGhQMmxm?=
 =?utf-8?B?S3AxYXhMV1hUWFJ5R2g3TS9DYlc0OGhXaUhydFBYVWhQVTFuN0pIYzBrSGhi?=
 =?utf-8?B?aTF5Y2RjaXBnOVMyL0dJMVZXd3QwNzE1NlByRkdsMTNwMy9lV1dSUEJLak9m?=
 =?utf-8?B?M2N3WVZ4bFVoU3JDblBEbHJ4NzNObUU0N3FOUTZ6TjBlY2ZGUU92b3N2RHhp?=
 =?utf-8?B?bmhBbWdjRzdSQW5jNWtKRTRkSnhudEdYVDE2ZXpiWG5DM0ZqOW9Za1J5Y1dL?=
 =?utf-8?B?Z0FtUS9NUHNxWkFvU05OVWdWckV0V25Ud0grYURjOURzeVl2dTBvUU5wVkky?=
 =?utf-8?B?ZlF1UzA5YUwvRUhoSUsxSkhTRmlPKzNpaEJQNDdTSDVuWWZYOWNxcndHSDUw?=
 =?utf-8?B?RzJYNmlHdnJnclNtaW5sYVFZdFgwSDdIa2FiVnY0VmpSUkhWZDdoMU5hUUZz?=
 =?utf-8?B?RWVZeTRQR2p0RUxJVk9iVk9HaGNzdGVMQ2k3ZGFTUXBuUTB0NmxwRWo0d2ZY?=
 =?utf-8?B?RmNzUklyQXM2TDlWeWtyMC9QRS9zLy9ZQXYybDVZYUN3ZjM5cno5V1p3NThR?=
 =?utf-8?B?dWNvTWFFNCtBSFlLbzdvckcwRGtaWTI4QmZPcG1rWWx4a2thU2V5eTc2Tk1j?=
 =?utf-8?B?SG5DL2grSGVSSTdMZGs1OCtJQnZwOHphcnhJOUhJanh0dVpiOUlyVVdKR3BQ?=
 =?utf-8?B?SitiOC9ydmQ3NnJQaWUxOTN3ZTJxUWpUTzZWUEFqWjZGVmcxUnBVWU5QKy9j?=
 =?utf-8?B?U2ZDTHBUZ1NHNXVBZm5IUlVIZjNKZWE3N0ZRMFNieDRBdTJFeWRjeEFtMHhN?=
 =?utf-8?B?UkNTb1oybzZLcFJkQ3ZUZVVsd2NYZk5xNDZkdzdkekR4UTFDakZYaFQzelIv?=
 =?utf-8?B?NFNMYmdveEZnSVZUNUJ3NWZ0M0pjR3RPOStzOEcxS2VqMjNROERpQlBVMEts?=
 =?utf-8?B?Q2J6ZVNWUThWRXg5eldMb1JnYjV4SlhiSjAvV21jZXJCaE9hRzljQmNZWnpo?=
 =?utf-8?B?eWNOeHBVTUtvL08vUjlCcFU4aWwvODFNSUNhWVozZkhiUWRuS2RPeDNERVdT?=
 =?utf-8?B?QWgreGtnRmJlRU9rNGNuSStMVFZjRzlLbENsNEFMVU95Tk1Jb2FFaVZHbHMv?=
 =?utf-8?B?WWovMXBwQVJ5aWNneUZuQ3dYT3lFOWtLeWg2RjdLTlJncFhITzBZbUFzNWdW?=
 =?utf-8?B?U0xTK3VKYThtVERIYTJZSWNvY2NhQTFlMkhIbnBVUFkrajhlNXRFSjV4VmV1?=
 =?utf-8?B?dnQ4TXFDQVN3ZzZteGpzckh4MkQwWnVkU3J4NXRNSVphdmdJQnRCa0NOWnF5?=
 =?utf-8?B?c1AzMDNZQ0MvZTBCbTJianhHSHpIZFJJUTJiY2FoYWI5Y3NVZlJYK2hVN3Vm?=
 =?utf-8?B?aUJqYy9SSCs3M3RVU0ozL0RtVkxmRFdaR3dHckhGV3pQb3FWU3cvbTJWNXpS?=
 =?utf-8?Q?UKRDbEoKmITDJXIrL+ERaUwNc?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Qn+L3e7jVHHvgFNaXFxNY0O/zbMyuVcTVF2k6OSl7JVFElZnCZ4frtvzH4mj+b2/7eOTMyHQizXwx9DIsBvTFysDwRqthbac3azYsKmW4Z3IfrM9w9iqcRuueY515sN8je1CXJpH+bOB1QOvmEJnmKSnDkO/hIidaHQmCvz318BCat0J73e4fcK3VlRd2cls0BhDKqTn0YNCMGj37bHVPy7OgWt/NPorBzcH+Nr2RCJpF62FYgi7mZHtYoWUQ49rs8G5fVIi/8DGZzxwkf6p6p1RepswEp/i0GNU7Jb2/ThetvFq7kAxdQhdwiEXdO8/vNYFdJnY+9P4ItUJb/z9FoDi6+hzZHf5w7peOsfe1Q0mt9epODLMUNOXhLWW3s87cEqCrQAbsTRi0KwX2E2aFW3gb1KLLUSR5cwf55P9ZHLsex1hdw3ah2/b4xAy0ZmP/PmoR3peEI2go3FSHKhV6lB6ZuE5Bh8paCpHZv5eUR2/SEHf3MXBO14gmH4LMT3x8Md8+eh2pRXNM0BMlFXhyO8Ea1gZHcH5YJlb3lPhKocWAle56dERzfjkPm7aGuj1YiKLGvTr7zARxdCAmifyXDprJGhO8XWa/4/h0lX3HbQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 540acef8-68ba-41f2-2878-08dd77b29720
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 22:05:08.2973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yP2CwS6K4Wd+DKkptVAS+iwBgAFOtmdxN3vRMtpQO/SjmGE9VvMAFcdgUOjmw6L1QvGVRBxoZmkdwfFFfOq6Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4163
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_06,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504090151
X-Proofpoint-GUID: FULmQh_4NGuIKxFgIjeDpkddgOhV-WxT
X-Proofpoint-ORIG-GUID: FULmQh_4NGuIKxFgIjeDpkddgOhV-WxT



On 9/4/25 18:00, Filipe Manana wrote:
> On Fri, Mar 28, 2025 at 4:52 AM Anand Jain <anand.jain@oracle.com> wrote:
>>
>> Here's a standard configuration for quick, regular checks, commonly used
>> during development to verify Btrfs.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>> v2:
>> - Renamed config file to `configs/btrfs-devel.config`
>> - global section renamed to `generic-config`
>> - Section names now use hyphens
>> - Added `RECREATE_TEST_DEV=true`
>> - Removed `MKFS_OPTIONS="--nodiscard"` from `generic-config`
>>
>>   .gitignore                 |  2 ++
>>   configs/btrfs-devel.config | 40 ++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 42 insertions(+)
>>   create mode 100644 configs/btrfs-devel.config
>>
>> diff --git a/.gitignore b/.gitignore
>> index 4fd817243dca..9a9351644278 100644
>> --- a/.gitignore
>> +++ b/.gitignore
>> @@ -44,6 +44,8 @@ tags
>>
>>   # custom config files
>>   /configs/*.config
>> +# Do not ignore the btrfs devel config for testing
>> +!/configs/btrfs-devel.config
>>
>>   # ltp/ binaries
>>   /ltp/aio-stress
>> diff --git a/configs/btrfs-devel.config b/configs/btrfs-devel.config
>> new file mode 100644
>> index 000000000000..3a07b731abd9
>> --- /dev/null
>> +++ b/configs/btrfs-devel.config
>> @@ -0,0 +1,40 @@
>> +# Modify as required
>> +[generic-config]
>> +TEST_DIR=/mnt/test
>> +TEST_DEV=/dev/sda
>> +SCRATCH_MNT=/mnt/scratch
>> +SCRATCH_DEV_POOL="/dev/sdb /dev/sdc /dev/sdd /dev/sde"
>> +LOGWRITES_DEV=/dev/sdf
>> +RECREATE_TEST_DEV=true
> 
> All these mount paths and device paths are far from "standard" as the
> changelog suggests.
> It's certainly different for me.
> 
> Plus this isn't sufficient for some tests that need more devices in the pool:
> 
> btrfs/292 needs 6
> btrfs/294 needs 8
> 


Thanks! for the review.

Yep, as mentioned in the comment, feel free to modify as needed.
The goal is to stick with the most common device paths, but
if you think another one device paths are common, I’m fine with that.

I had considered automating it, but device paths don’t support
user attributes. If they did, we could’ve used that to detect
devices for fstests automatically.

I also looked into emulating zoned devices using a block device
as the backing store — that’ll need more work.

For now, just going with a basic approach.


> I'm also seeing RECREATE_TEST_DEV=true for the first time. Why is this needed?
> 

Filipe, some of these are from Josef's fstests config. It mkfs the
filesystem on TEST_DEV for each test case, probably to make
sure everything starts fresh. No?

>> +
>> +[btrfs-compress]
>> +MKFS_OPTIONS="--nodiscard"
>> +MOUNT_OPTIONS="-o compress"
>> +
>> +[btrfs-holes-spacecache]
>> +MKFS_OPTIONS="--nodiscard -O ^no-holes,^free-space-tree"
>> +MOUNT_OPTIONS=" "
>> +
>> +[btrfs-holes-spacecache-compress]
>> +MKFS_OPTIONS="--nodiscard -O ^no-holes,^free-space-tree"
>> +MOUNT_OPTIONS="-o compress"
>> +
>> +[btrfs-block-group-tree]
>> +MKFS_OPTIONS="--nodiscard -O block-group-tree"
>> +MOUNT_OPTIONS=" "
>> +
>> +[btrfs-raid-stripe-tree]
>> +MKFS_OPTIONS="--nodiscard -O raid-stripe-tree"
>> +MOUNT_OPTIONS=" "
>> +
>> +[btrfs-squota]
>> +MKFS_OPTIONS="--nodiscard -O squota"
>> +MOUNT_OPTIONS=" "
>> +
>> +[btrfs-subpage-normal]
>> +MKFS_OPTIONS="--nodiscard --nodesize 4k --sectorsize 4k"
>> +MOUNT_OPTIONS=" "
>> +
>> +[btrfs-subpage-compress]
>> +MKFS_OPTIONS="--nodiscard --nodesize 4k --sectorsize 4k"
>> +MOUNT_OPTIONS="-o compress"
> 
> Why the --nodiscard?
> I don't use it in my setups, doing the discard doesn't cause any
> significant slowdown for me using 100G devices with qmu (raw type and
> with discard support), and it's good to the discard.
> 

Yep, it doesn’t take much time on mine either. I’m fine with
dropping nodiscard.

> So I think this is far from standard as you claim in the changelog and
> won't fit everybody. It certainly doesn't for me.
> 

The main things are the other config items, except for the ones under
the 'modify as needed' comment (ignore the nodiscard part). As long as
we’re all on the same page that every release needs to pass this, we’re
good for now.

Thanks, Anand


> Thanks.
> 
>> --
>> 2.47.0
>>
>>


