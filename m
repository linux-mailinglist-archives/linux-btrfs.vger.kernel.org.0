Return-Path: <linux-btrfs+bounces-11313-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 000F4A29EA0
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Feb 2025 03:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61B3B7A2F42
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Feb 2025 02:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473E2824A3;
	Thu,  6 Feb 2025 02:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RVwJMUL1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TWBwQ7/Z"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702186A33B;
	Thu,  6 Feb 2025 02:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738808024; cv=fail; b=kDw8ZAv4Lh/msvqZXS75oZRdDIddGIF+/Re/2sMWXjVr1/M66fBCXtFTgjEdj0UAErsiA8YEA+9n7pKSWVTXJhpxM9JN5LSlWo2JWbiAWXIDWFKDf6tk2T4mubdpPtI81uziWe+ffDzk5drCnNyFFLf7/89NETXwKL+41Y+d+vU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738808024; c=relaxed/simple;
	bh=2/+GTJDEe77U8cW5U76CfrEibqNhEE0GZXBXrPxra1A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XFbjsXLh+CeJlqhP/V7OqbEJWYsfW80fz/1pUvkwPiBnfhTjWXAnRICmwDi0qX+szHtTH8zzEL0F3RRVAZ6bHhmbV0UvZ0CjifPnVAWb5V2mziMTM1kL2rQussxITogtMfiPlL9tv6ZTbA8F4y8xzDgG7ZWDQmXNJFys11A2dcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RVwJMUL1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TWBwQ7/Z; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5161hOek004902;
	Thu, 6 Feb 2025 02:13:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=/59M4gX2GyNmhc7KFGCjnta4LQ5s9Ew/mcRdvk/WmNI=; b=
	RVwJMUL1zqz/c1hiWT/GkljMgFSWuBdFZobs79+OOxvWFjIhK9SmgghnY84Xi0XE
	NJBcpIqL1NhX0fpH+pnTzc+I5agBgLHTkKUyvkCPKrQUfMrJFtLZ9o0Ynr7aQWrh
	xwZiuujW/hqXGGEaYFJ1d7pJWIsm5C9+cgvCTqZYciUwgJJdsSL/A23X/uR5vdXv
	ArZW1dZdqf4dolA5s3Z37XigtqH0GBOd7OyJ6Y9eE7trnN4L+9/aX8qDj3bFMrRw
	L27zURupx/vhPsXDKc/zE6pnWMqkuT2jmqV2TowGSht9zz6/Ob/7eVZ5q5W8+5b8
	1fKo13kpgjlzmCFmo8EJpA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44kckxmb0d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Feb 2025 02:13:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 516069GO023534;
	Thu, 6 Feb 2025 02:13:35 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44j8gk4f55-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Feb 2025 02:13:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U37Oz6qXPpSj1RCrovADoWt0gIKV6rSlC0aMY/l/6Zn18FOmV5lWJuiJycwMJWh2E+QWoRrHCGoBddiCJrgdFc1XeBYTBBk0e/VKPgaqlMhOLNjUAAOxwpr2J8FR/7dtGUr+RXIqXgIRJAoQJBF81Ldtr3LVZkMgxXi/FYnGu2qxEPQsXIh+SEANuzGnh9zAu6ymvhhisvyWTYvwlYDHHUXK9KBPlhtHURCti25ztAQC0Yym/tbRryqcQq1N2ngj4pefr+XbUEn0f5nTTFYnwB8RR1V6rfG36QhVn/jzRqTKh6aR+miiGwTAGGxZCQKne0vEQyi9bgMRtiK/y0vt/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/59M4gX2GyNmhc7KFGCjnta4LQ5s9Ew/mcRdvk/WmNI=;
 b=yfsh8PMpdx8wyzVSNmBj2dtLoWTpcLiBvsd2aQPeyh0ro7qaPiu4LzOapX8cFFM9p/6C19gSapgAtysghDXb+wL0X6cbiV1amnC/gblKiQgjzFLC9feG83dR98c9RuILzwu/ek7Ur+wSLazi0n2KVKOkVIV2J0LSAVCDwbTUOUZ4N/ENliNhX5e+fHzIkLCyk8NwAXXNGx4vfiIxnfbTUEUFp/AO6iMqAB99SqJ0y0a+zQZa4BIeGbixDAkoI2MFP6QH4Yg0DcPDcQCI5YHUsSWUQOGrWKz5UDsIJExq1Hm79BJlCzCCHhQ8BzUj+kTbbuY2NDpidRTTWJ0rvHPt0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/59M4gX2GyNmhc7KFGCjnta4LQ5s9Ew/mcRdvk/WmNI=;
 b=TWBwQ7/Zh15wfo5+jKjt7kcPltsX9GONwenynPA636Th9oOrJCI0xb6KbpQ4C/0YyAy7fC01LPZyt2Hz1tww4HmYF23uEATEDJKfOq2uSqKRVoWB6zDboex5owyGOdJGe1iAGbFtggvY6wKDNJOHhpXzIdyuRywD91frkkgut6Q=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CYYPR10MB7676.namprd10.prod.outlook.com (2603:10b6:930:bd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Thu, 6 Feb
 2025 02:13:32 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%3]) with mapi id 15.20.8398.021; Thu, 6 Feb 2025
 02:13:32 +0000
Message-ID: <e24e430c-73f8-4e18-be07-624581864de7@oracle.com>
Date: Thu, 6 Feb 2025 10:13:28 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: btrfs/226: use nodatasum mount option to prevent
 false alerts
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
Cc: Filipe Manana <fdmanana@kernel.org>
References: <6b66d881e152296eab70acc19991d9a611aefde6.1738792721.git.wqu@suse.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <6b66d881e152296eab70acc19991d9a611aefde6.1738792721.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGXP274CA0003.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::15)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CYYPR10MB7676:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c5de318-148a-430e-5f21-08dd4653dab8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N1VEc1I2Wi8wbWNjOWlWVjkzZkJMd1hCcUpnUW1uZHgvQTJaVUVXWEZPeG0x?=
 =?utf-8?B?TmwzVHYvd2JEK1R3ZnkvUk5FODlVbW1KdXFhdEsxeS9ySnVlNDJOWktXaEpi?=
 =?utf-8?B?Y0pTWmoxOXZ5dmxCZ2NDY2xzYVo4NEhKQWh6T0VmVlp4TkVac0VFc1ZmQW9J?=
 =?utf-8?B?RGhWRHZQU1k3S3Q0Y0V6TVdvL2dmZTRneHhBb0JUTUF2dTMwaDRNaFh5OEVj?=
 =?utf-8?B?OFU4QVFmOUUwTE9VQUpDVjlSRWlmY1JTR0VvU1MrS2lVNkVobVp2ek91emlm?=
 =?utf-8?B?K2dyYzluRDNPRFM3MDlZc01PaFN6bWdDa2V4aXJob1F5a2ErQUpPdWcxam1n?=
 =?utf-8?B?MkpkdlhkZUNTcGpabmFPRjZCS1VxUkFRdU15YVp0NWk2aWpyVUNORzZaaFBw?=
 =?utf-8?B?VGNMMkRqK01nZjhyczV4RHlyV1NmdEZXVjk4ZzhRZk9EeEZTTmdxV3ZQTjR5?=
 =?utf-8?B?YkpzWHdyN1o2d2tIelk3WkdsVjJNM1VrNkVKOVcxMU1UZDUzdHRDNHFKbWpz?=
 =?utf-8?B?OGdmeWlVNjY3L0pCM1hrY245elVUd3c0cEUzaGlFVHVuVUp2eGtEWk1jaVRE?=
 =?utf-8?B?VEtIYmFFSlE1UnVieXBoQ1c4VHRNazhJVklWRzVnZ21yT2dCaHNYUHRwUUl4?=
 =?utf-8?B?VFFKZWFzYk55SkpicWlqaXhIMFV6bU01Rm1mVHFnT0V5UzErZlZ4VmhJT3Rt?=
 =?utf-8?B?Y2U1ZHk0UkRVWXk3d215KzROeHcvVldtWkNVQVpIRnNrSyt3cmV1UEs4NXgw?=
 =?utf-8?B?Ri9qR01ZS21jTkZtOWVGd0FNUGppeWZreXhucklST0R3bUpmLzBoODJyZStz?=
 =?utf-8?B?WEVxRHNCcldpZW1vZnJhazVuMVQra0VzZ1d2YlpoYUFjZVpXdFByQ0Z4cVpK?=
 =?utf-8?B?aW9yZk9NVUJmQ21QcVhlMVhnazdxZ1NFcUJkaVdRRUpUVnBwbm1Zc3FTWnZs?=
 =?utf-8?B?U08xWEpFNmZTSDBwcFJWaHJSeS82UHJOWkw4WWtHM3hiYWhqaUlJUWRxcjVL?=
 =?utf-8?B?aHl1OTVid1BsUmlEalR4TVh4ZzVJZnpKWUFIWVlFNXpDRDdyNmVINGhQMExY?=
 =?utf-8?B?cnpOMDE4elNzcmlRczFpeUU0WlhsU3V6Sm5UV1NzUEZyeHpEN2h6N0lnSlZY?=
 =?utf-8?B?UkwxUElCV1JFMHBQTktBL2U5enJscjkxZ3JrOTRLU0R3cnRINTg2MkhLNVh6?=
 =?utf-8?B?WExFeDk1WHhFYXVHUFNTb21CMElwNkljTXRCY2xheGVjLzRiS0ZXcWhhWlZ6?=
 =?utf-8?B?UW05NzRGM1ppNWJncnBqZVNMbU9TcytFWUNrZVZwa3l3cVV4ZlhFNFhleWVQ?=
 =?utf-8?B?VCtWMm5iTXFaR2t1M08rS2ZpUDJzWUtnc0dIM0dESmF2TU1qZGdyRHpIQXZs?=
 =?utf-8?B?bEJOZjZ4QlhseVlBeDBlU08wdndQd0ZvclVNcXdOOEJWbEFjZXdBQktHaWlN?=
 =?utf-8?B?QnBMR1pLcUNCb2JMQmt3UEltbEJWUW1lTTd4ZDFxSlYrRVd5Mk9HT2E4dHhM?=
 =?utf-8?B?Z3pUU09GQ0I3a0gwZkp5SDR5S0ZVMEFiQmdWaHNLYUdybGhoaWJQeDloOEc1?=
 =?utf-8?B?ZEFuQjVFS29LNzM1bTRwYUYwR1FRQ2E5ejlEZTA1K3dwUTNwWEcybTJzcDRq?=
 =?utf-8?B?dEVvbTNiMlQ0anZXbzRIKzFQMGlwc0ZDelhVVlRmWjFrMGdoUzZLRDN6cEJ6?=
 =?utf-8?B?V1gxLzRsQUJGY0hDRHBxOVM4dWFUTGRFb1hyZERIQ3lHcUpYMkhPV2lmanp0?=
 =?utf-8?B?TitaMlErMkVYWm9EZWxPS0tIcGdHRTEyS20wZTk5U2lLMHA0MHhmWERnK1gv?=
 =?utf-8?B?a05xYXFyWmd2WE5UL0QwS0Jic3VQTmpGN0lDTnM1bFg5aUswYWd6dUJxZ1da?=
 =?utf-8?Q?w1DOxpEE8uY1s?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y0tJWFJqYlBvQXNJT3ZWa2xCWUZCdmFReUtkU2ZpYldhT1crc3N4a25XMHFI?=
 =?utf-8?B?alB2dmprekZObW56WG9rcExYa2VhdWRXb0RDT1Uyb2txMVdqOWxIRHZNa3JK?=
 =?utf-8?B?V1pOVE56KzNnUW9lY1Eza3o2VzYvbGZ1R2VpVG9uMWFNMXRLMDM0eGVMT1o2?=
 =?utf-8?B?cDA1dVVsQXlZUnIrNjNaZXExdTN3VlhHSUNyZTQ3YnpiR3hLcjV2NnpmdE1L?=
 =?utf-8?B?dEdyZGZYbm1xdWp3bittNnZURVA3ZXdxMndxajlEYWJnaFYyR1h0NWdxWDN1?=
 =?utf-8?B?RVpBVEdIMm90UlJhQkg4ckxnS2RPb2pwNlhMclFHZ2pmejhDOTRoNi9VR2ZS?=
 =?utf-8?B?TXVRbVNUdS9keEtsU1FOTmpDaExxNmJ2VkFFMHpoaThSOXVNWEF5RDJSWjkx?=
 =?utf-8?B?YXlhOFM4NW12bGFkTzRidWd2SUtPcFJiMnp4czNUSDRoeEZyWmd2M2x4NjNl?=
 =?utf-8?B?MjQvbUx1VXA3S2E3VkVYS1NZaFlmS3NEYk1MZkRZUWdQTTJ6aUVVYmRHVWV0?=
 =?utf-8?B?UE9lTkFhOWplaGVvbzdGQ0s0azJxM2toT2tpM2lrejdEUXJ0WitpRjA1THB3?=
 =?utf-8?B?bzVUY2NaSE05MWpTY0txaVBqTW5BRmw2MWVicGFCMkREKzFVODFBZWFJaWs4?=
 =?utf-8?B?cFoxWHBMZU5LaXJQZnJqSjF5cjF5YldPdFAzS0tCVlpIbTI4STZiMUdEeHRN?=
 =?utf-8?B?dHZWVlZkTzh5V0pRNmo3VHRGbStTNEdjVW1QSktsd1lkK1diYjRkbjNqMmt6?=
 =?utf-8?B?NlkzQkNaODlaU2FhcWw0V2Rnc2JSc3hmdzg0TTB0dE56YnlWV0t4aTlsWkkw?=
 =?utf-8?B?MVFPWDhkdVl4dGlYcVBBYkc3b3BwZWVVLzBkMmdMSEpwQ2NTc2hMS1lHbnFl?=
 =?utf-8?B?Yyt2QzVqUGFzamI1anJPRXFmVHRuWkF4blJHWFJndkN0dkwrVHVKZFdpYSt6?=
 =?utf-8?B?UG53VDBtMy8zcXhxMlRtY05YeU1UdXF0TjdER2xWZ0ovTkVtUXB3eEJwd2Fu?=
 =?utf-8?B?ZGloYk91bW1xYmN3ZWVvbFA3N3JDSUQ1ZFVNSU54Y1MzR29Uam4yMVVxdlMv?=
 =?utf-8?B?SFhXU29FQTdwUURNZ2pNbXpLTnZ4R3Y1MSt1QUF0ejVoSVpiTjEwWGFQcUFS?=
 =?utf-8?B?UjNTbXR4MmVrb0puOThrajg4WDRLaVdnTmsrdFl6ZDc3ZFVMRmFzWHRXY1FQ?=
 =?utf-8?B?UjZBaHdUSGFtNUZqNzNKaTErci9nZUtOSGlNaVBrR09pUm80WjVUb01xQklG?=
 =?utf-8?B?QnFmdW8zL1o4eWVDQXpsQytjZzNxem9wMW9vTUlGNUEwR09XdVJWK1B6MEp1?=
 =?utf-8?B?Skpic3lJMERKNmgxRWhDeHhSNmlNOU1qRWt0Y29UOElYV1BQNlRFd01sZ0VC?=
 =?utf-8?B?NUk0L3JFVWhONkdzaU1FaVlpMGFDanZoTUEzOWZRWDBzd2R4b3dHNlhpOHMv?=
 =?utf-8?B?ZzB6TDdjbVFCZitNNWNucHZxUit4YTE1M25qQU5DNDA0NTBZYTBqYk00eFU4?=
 =?utf-8?B?aDBGWmZxMXlJOW4wZkRjelVLUmdiZG1Va3IwTmp6NlRqTmFsR0pUeXZQaTdo?=
 =?utf-8?B?V3N0WUppZ1FYSWp4N1ZMMW84VEQ0WDZLUGl6eDVmUUxmWTBZczAvMVh5R0s3?=
 =?utf-8?B?am5LZ1VRRm5XSnFJcGZTNllWWUtWZnppeXNqdGY4MWxiTGppaUU1aTlMYzhK?=
 =?utf-8?B?bmdVVWZYTUdCMExtZ2M1L0piOU1uRzVSSyt3NmZ6Ymo1cVBFU1A4S1Q2NWhX?=
 =?utf-8?B?dVVrV2EzQnZ1Sjg2NWpJZU1SdVRQcGVhbXpWWCtieG45U0JyWEpLc3Rrbnkz?=
 =?utf-8?B?eS9TWitkREJhbGFrT2NKSm5lRzhEaEZ5Y0RqN1hVSG9SemVTTmhJNHJJYVVB?=
 =?utf-8?B?M3gwN1k3WXJkcG03L3BQdXI5VHpsTDArVGdiQ1dKZXdFclIwbkNZdmxtTVBq?=
 =?utf-8?B?bVlqQnVxZUx0R0xuWXR0RkRUaWxLc0F2eGM1R0dMR2dRNWRSQ2F0cDF1ekZN?=
 =?utf-8?B?eTdzNlgrWlpXcG1HbVIzRk8yZXdvSDRZM1N0RW50c240M01Kbk5IaHkvTDJT?=
 =?utf-8?B?ZDlnMHZTNjAxREVrWVQvcjQyZ005OG92WnQ5a0NRZUh1VXFaRURGTmoxeG5M?=
 =?utf-8?Q?N++k/gOosg4iKPpvUU+wFfQYE?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EkYQ0Kj2zg1ztz7B51idPW/xKhGmjQo/SQ8mBKPqGKwg0fwTgcNEZ0FBelbHRRk4RXht7oPaXI19Hed6vq0U2SHfuqyf/GBQ34+q3FxLQ/t/SUnOmpj6YtVeEhDd/fOGBQ8hXtplxgHhSY9U7bLXzza/9Hc3M2rWgLG+XRIl/NTIkLjOY6+qeLetzgwgLZOyobjOa2kPjAwLbRnpmFEC3QStuDN2d3IRsggGRkA4WPSf+0DFEj+u326V27sXahmlOJVAR47q1ueAA0D0OV29LQLwlyzUGrf7FvV4+tbxoQq1MWBuyvHBp1jIxLKu4h+UbAhAO5QsKiAI97iihqgfuySpzWMfL3brJzzvpa/4j9n/ijgcz4tS3TQBFsSwIk2SUUuce1ZQLbRMxKOHs1EPTYoeZLD4lhZaSHeaV/OJUmiOL+Zdvro72FoUo42WSvu/avp2J3ruZrlmwEkWekNvz3Bc44qeDN+/bS5itbuH79QZzjlxVpIswTyOR/id47pxIU15mcOOjqdbff3BX8LDBySspLYTvRuBkU3D544FiBiq1BPLA4N6UR9cGGZ5EHRV3aUYiheLeVq7CU9Cx4Ak035hICBpjLoIH1McsJ2b/gU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c5de318-148a-430e-5f21-08dd4653dab8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 02:13:32.6728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7K098f27Qi835XQCxF/5bZCJZOd2GhuxP6zhaUZ7yMMOUVLWIu2xuF/WeRkhq6e8x4P+lDdihHt3NSAYmMa3yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7676
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-06_01,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502060016
X-Proofpoint-GUID: cqm7IwKTAyHDryXdjtrluBanwGPoGH0i
X-Proofpoint-ORIG-GUID: cqm7IwKTAyHDryXdjtrluBanwGPoGH0i

On 6/2/25 05:58, Qu Wenruo wrote:
> [BUG]
> With recent kernel patch "btrfs: always fallback to buffered write if the
> inode requires checksum", the test case btrfs/226 will fail with the
> following error:
> 
> FSTYP         -- btrfs
> PLATFORM      -- Linux/x86_64 btrfs-vm 6.13.0-rc6-custom+ #209 SMP PREEMPT_DYNAMIC Fri Jan 24 17:23:03 ACDT 2025
> MKFS_OPTIONS  -- /dev/mapper/test-scratch1
> MOUNT_OPTIONS -- /dev/mapper/test-scratch1 /mnt/scratch
> 
> btrfs/226 1s ... - output mismatch (see /home/adam/xfstests/results//btrfs/226.out.bad)
>      --- tests/btrfs/226.out	2024-04-12 14:04:03.080000035 +0930
>      +++ /home/adam/xfstests/results//btrfs/226.out.bad	2025-02-06 08:23:42.564298585 +1030
>      @@ -39,14 +39,11 @@
>       Testing write against prealloc extent at eof
>       wrote 65536/65536 bytes at offset 0
>       XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>      -wrote 65536/65536 bytes at offset 65536
>      -XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>      +pwrite: Resource temporarily unavailable
>       File after write:
>      ...
>      (Run 'diff -u /home/adam/xfstests/tests/btrfs/226.out /home/adam/xfstests/results//btrfs/226.out.bad'  to see the entire diff)
> Ran: btrfs/226
> Failures: btrfs/226
> Failed 1 of 1 tests
> 
> [CAUSE]
> That kernel patch makes btrfs to always fallback to buffered IO if the
> target inode requires data checksum.
> 
> This is to avoid more deadly problems of mismatched data checksum.
> 
> But this also means, for inodes with data checksum, RWF_NOWAIT will
> always fail, because we will wait writing back the page cache, thus
> breaking the RWF_NOWAIT requirement.
> 
> [FIX]
> Update the test case to utilize nodatasum mount option, so that the
> direct-IO will not fallback to buffered ones unconditionally.
> 
> Reported-by: Filipe Manana <fdmanana@kernel.org>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   tests/btrfs/226 | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/btrfs/226 b/tests/btrfs/226
> index 70275d0aa2d8..359813c4f394 100755
> --- a/tests/btrfs/226
> +++ b/tests/btrfs/226
> @@ -21,7 +21,12 @@ _require_xfs_io_command falloc -k
>   _require_xfs_io_command fpunch
>   
>   _scratch_mkfs >>$seqres.full 2>&1
> -_scratch_mount
> +
> +# This test involves RWF_NOWAIT direct IOs, but for inodes with data checksum,
> +# btrfs will fall back to buffered IO unconditionally to prevent data checksum
> +# mimsatch, and that will break RWF_NOWAIT with -EAGAIN.
> +# So here we have to go with nodatasum mount option.
> +_scratch_mount -o nodatasum
>   


Looks good.
Reviewed-by: Anand Jain <anand.jain@oracle.com>


Thx.
>   # Test a write against COW file/extent - should fail with -EAGAIN. Disable the
>   # NOCOW attribute of the file just in case MOUNT_OPTIONS has "-o nodatacow".


