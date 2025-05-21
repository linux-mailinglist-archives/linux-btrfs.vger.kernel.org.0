Return-Path: <linux-btrfs+bounces-14159-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E68ABEE11
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 May 2025 10:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 760B317EAD0
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 May 2025 08:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9982367D5;
	Wed, 21 May 2025 08:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oCA1hSJT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kJkUOy0F"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB1B23371E
	for <linux-btrfs@vger.kernel.org>; Wed, 21 May 2025 08:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747816657; cv=fail; b=kmyyKSZoFiv94ZIZP0fod3aoW258fSLFDlJctQpXDOddeVxRlVpQSmhjqFHkdvXfneJWqM75TdtK/aTk6nx7u6saGi92ddj2fdf0fbxVdOeaeucwQRfeyOOncSLZqDkawow+D5o/Vobqhl4OVwcIePsMXxD8x+1l1441bfW5pnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747816657; c=relaxed/simple;
	bh=Jv9W4YiZ5NEDgE2q/oe9/VtVfUMz9tI3zYPMpW0AO/g=;
	h=Message-ID:Date:From:Subject:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oF0RC98C0TedvMst15zm2eR9KPDCZc5Z7TkvtIA5nOulbJ1EULrp9jW7zPtiJkOaXJLgOsYRo1RL31P//pHPohMYMd063asGMXc6KumnonDQcycORyeNIbwPVqbv9581le2mJKsNEYiOzKRkdmLY0d8hGTVnO8jMx3BmOe+qwRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oCA1hSJT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kJkUOy0F; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54L7gheg014531;
	Wed, 21 May 2025 08:37:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=1Vke9N2h7RqPa1eJv45cnpHXEo7InslMT+K2ut5zeQY=; b=
	oCA1hSJTry6vGxJGmRf26gViNtSIrTRtVCQVTQr/oWy9UPw4w9qipjkm3asZjrNd
	UUZna3wlQKDhlQZXQ3xVjEwxyDGY9ZpOGmPV29HKr3/LvvwHE9vXKOmSjQ9Oufg6
	V+53HtlTAjmNxf6xxty8YE2p4bIct3iRFN7ccQkMIS/XtbRoWQpexykrbPZwP19T
	qjoF/8rRdk7gJEqJqrJFH+lGA6WCszrQxUCKbu5pqa4TjZlwf44IXHGnBldztBps
	WDRD+Rua+ygt+DG9zfn67aBdBwCWApqm0/FNzbiHBFT7FL1b6LuAXjAlPLoOFGjd
	F7EEkFtoPsgUBFOBo29DnA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46sanvr3hk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 May 2025 08:37:25 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54L7sg8Z034517;
	Wed, 21 May 2025 08:37:25 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46rwephy2q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 May 2025 08:37:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cKDjMS98D2iP5KeOfRQCz9eAdHXpib6TZe1pFllhLMy/YgcqioY6vMXbogrywalLdsyQs2Lkl4R6VupGas41QXt1pFoqyq5ED85lU7iegqUc+g09UUz7fmKNRBvi+lt5bmxqBHrdY5oKkB7qBtzHL03jAphgUcy2NuVrEPEypsDJkgU1nXfBMRRpS+6/XVpCJzGK2RU5ni9DG/YCxqw9XuOgDysmkWm1uhvJoM2k03Sluk4m7JG2KarSJkjFfgPHXJiYR6vutUR2leDg4F60Smbj8jt3yIoKqHcFSsZE1XezItsImMQaL3IRBfrVtmLP0EpIs21tE74VpBHJPtHlGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Vke9N2h7RqPa1eJv45cnpHXEo7InslMT+K2ut5zeQY=;
 b=X4RNgNcxGdJCNyNzhk65YLJzXTsQ/H6NJqHA6SGTBPy1KzCN2uhA4L3liU8yeOyrgmJgsvvTzqGG8JgGJYGEhBDF91/3Tot3d7KCFF6Oz20MUVerGBUZ0c3Xp45PbFulcGtpoVzopK3/r7ajUFl3R0yEv9V9oAbYqwfrG4sGd5jcL4UH4nwt/thgtD6lUTZrIJHyWfNWDVlRdN6ShbK6/tJzqJJCTvQdus5GrzdB4DmSkavPPKIbkJEOZziLX3KhB3WjAX6omKLD264Mi1r+t3vt/r3KQnKoOBDdLCfPP9CXSuItn3VlqGqpliJq75ry8eZYiczCR+14gF+TfWXe3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Vke9N2h7RqPa1eJv45cnpHXEo7InslMT+K2ut5zeQY=;
 b=kJkUOy0Ft9FXcfuOmVtqfWtbBChjIBfzIqK/adiRWhLvM0aeBRRNO712jGJHA9AERn6AJ3MoeVmi5QtmagpjrROylaXrGDyhX+pJyAVwA3G2cDT2tEj7AhGUcm282YncBDujOmXWTXHjv8eWha427Sy9QolA50MDcWmAHuod8lo=
Received: from IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
 by PH0PR10MB4407.namprd10.prod.outlook.com (2603:10b6:510:31::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Wed, 21 May
 2025 08:37:23 +0000
Received: from IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5]) by IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5%4]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 08:37:23 +0000
Message-ID: <5e79efb5-94f8-43e9-8ff0-c7ffdc027c8a@oracle.com>
Date: Wed, 21 May 2025 16:37:18 +0800
User-Agent: Mozilla Thunderbird
From: Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH RFC 00/10] btrfs: new performance-based chunk allocation
 using device roles
To: Forza <forza@tnonline.net>, linux-btrfs@vger.kernel.org
References: <cover.1747070147.git.anand.jain@oracle.com>
 <c49ee3e6-b0f8-4886-a364-e745d0e5d091@tnonline.net>
Content-Language: en-US
In-Reply-To: <c49ee3e6-b0f8-4886-a364-e745d0e5d091@tnonline.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0132.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::17) To IA4PR10MB8710.namprd10.prod.outlook.com
 (2603:10b6:208:569::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8710:EE_|PH0PR10MB4407:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dd4fdd5-9161-4706-3e97-08dd9842b514
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c25PbzlHMFhVckM5SHNmRG9Wc1dlNFZFV3NjSzFNcis1MzBSSTQwNFM0ajhs?=
 =?utf-8?B?Zi9KdW1UM0cvK2NnaTgxMnpjbnFiSDQwZkozRG9QUGJPdVZML0ZYSVhUN2xF?=
 =?utf-8?B?VVJjQkdVc3RJSWlXdEhmQ0drMzdkWi9Cd2l4S1N6SVJRdGp2WjIyTnRwbUx0?=
 =?utf-8?B?elJ3NmRtNHlUTGtXa082U3FTTjJ0cjZJQUg5SnZLSXBzcjl5aU9pQ1RnMEMx?=
 =?utf-8?B?bzFBLzBlazQ2YXZJT0FHeEJ6dE5jY1N0ZGliSHRCZzcvQ2FFTG04RndqZ0JK?=
 =?utf-8?B?SXduNWhoWEp0WUJJY0tKNS82bjN2ZnBrYmlPdzRXd1Bha01ubllRVmJZcjFs?=
 =?utf-8?B?UDFsRGRZNTZhYzVPVHhIQzQ1blNuaUJ0a1lMeUFMN0RGR3Z3Z3JSUGN2OVQ0?=
 =?utf-8?B?Zy96R3RqVjZKbTdJOUYvZ0RlTFJGSllSOHVldjNBb0lIeUtqWEFrcHRIUFdi?=
 =?utf-8?B?UTAvYVZ0S3RGYmtnaXZJZUNHeWlPbFhma2VlWVY5SDNla2lPenFOL2tYL3ow?=
 =?utf-8?B?WVpNNGtBcWhGakhxV2ZCMXNDMUZJMUpMOVdyVTMyenZQTXovNjVlVzJuWDNL?=
 =?utf-8?B?SWl3UURhQllzUTBuSmRmT2dLMmIwTHBiWkltYmNFTkNxcUZhUTBHS1htcEV5?=
 =?utf-8?B?MkpJaWlMdFlCa0VNTmNKUXJ3azZMbStMY3JEL1NFSXNNbnpxOWR6WTVCWjZJ?=
 =?utf-8?B?REQ0V1V3YTBmWTNBekttWEZwak5VWlp1VEt1UGNKOG9rRTZZQTVRZlEzWmtF?=
 =?utf-8?B?UVdlZTJaeHhVTEhTejlCWk8yTmUvOGVRdm8yeFNpd3pKY3FMOGJ6MUhRRENn?=
 =?utf-8?B?T3JxdERJYVcxYnU3enZ4aitWbW1LVjYyTDkxRGNWYnhHczViUElEb0FZZWxY?=
 =?utf-8?B?Z2tCYlFkREM3clZvb2FWYXNXTnZkYVBkaGtWdDM0TUVlZWJlcHFCUzNjSlpG?=
 =?utf-8?B?M2lyQ3hpVWdmNlFYWFRubjBMK1dVWVBGQmQwaEdBL1JNSmRRUDZ6N041bHhK?=
 =?utf-8?B?ekVoTS9YUkRKQmVzRGp0dUxNQ0pCUHBxSEl0VWtyK3krVEtaUWpqRzI2SGh2?=
 =?utf-8?B?WktScmwyM2RrS0xlMmRNZWxuZ25nM1lzVks2OHI0dVhyQnFSWHVxMUtTVXhY?=
 =?utf-8?B?QVdkdGtIaXNtUFJLK2tQbmlTcS95ZExxRGRPYkJnRWkrbDBzT2EvcEtOVzBa?=
 =?utf-8?B?bW53OVdNU20yMHM2d1FsSk9hQy9jYzlXdkc3ZU1hb2IxWXRyUFMvUmVFbEo1?=
 =?utf-8?B?UlNWeDBaV2R0aEF3WWZIQ2xqU21PMDlkeTVLYXBoTzZYaFhJQjlHZVh6ay91?=
 =?utf-8?B?N3V4c2pwSVlmMk5oRll1dXJ6WnFHT0RjNm9uYmlSK0JCV0tia2dJamd4WC9R?=
 =?utf-8?B?U0dhME1HTFZwK2JsRG9YTDZpRlNOU1ErRW1YVzg2bnNxRnE4RGV0cG01NUsy?=
 =?utf-8?B?WlEyb254T2U5aklicEs0a1VvWTVJWnZkY1R1S3JGYWJGTTM1dC8yc0RaZ2lK?=
 =?utf-8?B?ZSsvaUs4Q3BpVHVLMHJBWUpOZnhJOXBLc3JrbTNRdGx2NWtBQjR1VExHcHFS?=
 =?utf-8?B?WnJQMUVxRDVyK0xJQjhTNVc4YnpFR09iQXpPMXlydUJkWjVVNkxtQlRLd2N6?=
 =?utf-8?B?Tm5wMUU0bFJhZ3d3V2x4a0duUFYra09kS2tHL3czNktzZlFRTmNWN1VNVWoy?=
 =?utf-8?B?ZDZYbDB0SW1iYnUzeTNiUkNBay80NTAvdFoxaEZPNVZzMXFoNGhHUnJJdlVL?=
 =?utf-8?B?M0ZXRTIremgrY0wycU5YWW13TWlncm5QMmRvcmVEYWEweTZLQWhmYUFsdHJl?=
 =?utf-8?B?LzNBYkxGTGJHeEVCWFpaaC9WaEJobTdBcnpTWS9vYXFpZ1RtZ0pxSCthTmth?=
 =?utf-8?Q?6SLj20IGiFtxG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8710.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TDdyeWhVWGtoRU05dCs4ajA4NG1FRzhuMDFJalh2Vm9rbFFacjlqVHJjbjQy?=
 =?utf-8?B?cFBUVnNvajh1SHRPMmovak02ZW0yODFkSUFLZW1QaEVaS2RTcFUyRmdNUWxC?=
 =?utf-8?B?NkdEL01malFxWThiTmhmY0NxdEtBejFDU1AzK0NVc1d0Z3dvbW14N1d5b2FW?=
 =?utf-8?B?aVZ4dHFqdEMvK2Q2WjlLcU9qcjZsQ3RYTkpmWGV1eEtPRGpuWWRnTENVNjRz?=
 =?utf-8?B?d0ptb1N4MzVaV1NUV25xbnplUDdXbjNNbTFaN2lwYWRGYmNEYzhYWFRrOXFY?=
 =?utf-8?B?OGlYMXlzV1RiVVMrK1pQZWZPNG84Uy9LRnFPOGtrTnh5T0d4S1lZdTNqMnBO?=
 =?utf-8?B?RFVRc0w5ZTg1NGxpTk10VjNSUFRxNWx3NjZWN3h5NFFZUWRybGVBV1p6c2ZH?=
 =?utf-8?B?TTFyY01NZjlCNFhDMlhHaU5tb3BNRFdLQ1lHODlPLzVvNnRqVk9BdW1OdDRK?=
 =?utf-8?B?bUF5THBFeXh6RG8rcmFjWGdKS0ErQVRsVjhMdnNLOTFDcWJvek9wUy94S21v?=
 =?utf-8?B?S0EwcERneCs4SWdqdWxlZFlOYmhvTTlGZjB6Q2hmM2hPQWtBRWhEa0c0YTZR?=
 =?utf-8?B?KyswNnJQMGI0aGhIbnVna0QzVUZRbkRtSGRxMXVkVG9WVVN1cmFmRkNmSlhP?=
 =?utf-8?B?MUJxVWtnTlBTVHdQVXp6KzFVcDdSODJkaE95L2F2N0VpQTJKNkppYkQyWHM0?=
 =?utf-8?B?NUd5dzFrMDFkTnV4blFrQzNaTFUwRGZBZjBTOEJhMkpjWmJnYksxaG9lV3lD?=
 =?utf-8?B?RDdQTFU5SHFLeGZ4dlVEUlJITGFVOXBzQVR2eVhSaTN1aUx5NjFnVDJHQU1W?=
 =?utf-8?B?QlVYT29GVGVudmh1bDhhbmZBUFlRMWpIZGNSN0VtY3U4VXlSZmMvUTllYlhH?=
 =?utf-8?B?aEJDNkJzWFdHanpmSGVPYTJoS2hPWFJKS0hNUDFzU3ArMnZqbUNqZGRabWJF?=
 =?utf-8?B?S2hMUnBxSUV2WkpGRnlVMCtaODhrV29JbEN6bXVWUSs3K2dUMk93ZGJCOGJv?=
 =?utf-8?B?Withb05lVGZocG5meStzNU9YZG05NnJkOHQ2N09OcEZ0dzc2ZGtQbUZ2Vm9C?=
 =?utf-8?B?OVgrRzh5M3pKK3FEemd2d0RnT21RY012bXJoV3laajZ2STdweHB6aDQyVmRT?=
 =?utf-8?B?dTg3cDcxY0FucGJFNTdRNkVuRWZUM3QvZnpheTlPQnFIRXRMK21tYkN6TS8v?=
 =?utf-8?B?cWVMQ0pXRGZsVG10eFhIYndSdkdBSGE3aGNaWExEL0diY2lFbGlCN2hMb0pa?=
 =?utf-8?B?dkQ3MFkxME5iU3lCb2dXbUU2TzE1RmFpdEtLZTlFN1YrS3JHREYvR1FiemdD?=
 =?utf-8?B?bW40bGxjenMwaUhhdm03NEhtUm5hcVNrM1I4endpK3hQOGh5UVFDYmdWa1p1?=
 =?utf-8?B?T1FFUzltbzlwSGxrRElBV1c2UkNtcFIyOW9NV2djRXNOelNydWE2bVhpYTJk?=
 =?utf-8?B?M1RjOXJpS0ZLdW0wM3JVZnpxK2d4dCs4QSt1SWVsbzJVSGxpVTh1TG14MGVI?=
 =?utf-8?B?a0lEd1drbGY3b3JTNGdWN3QwZVg3OWJPTkRuVkVBNGNpaC9LWTM4WVhQdzkv?=
 =?utf-8?B?YktQbFdIR2JKaDU2WXliYitlc1UrRDBiNkdkdGNzRmxHazF2SFQ1UnBLWi9y?=
 =?utf-8?B?N1VleUtBVmkzTWFJSWhPV3EzQzlsdEdHUkVpSnc3RmNvNkV5SUFOdE5rVnp6?=
 =?utf-8?B?bXdJeVI4MjhGRE9CMjFocTErZEhORDA2Ymg4TkRKM0xod29zT2pkSys5bVdD?=
 =?utf-8?B?cWRIZ1ZySWd1UkV0REdTWlFUdnNLN0VLNGRKU2g1RFBRSjNtd1psSWRBZ3R4?=
 =?utf-8?B?Uy9BNkJCUGozT1R3NXdOWWRyR1RCL241d3l0Q1NORkJtUzBjSC96VDc3VjBD?=
 =?utf-8?B?WnMwb0Uyemk0dUhhQUlsMWswKzloUkg5RG53bmxRaTJBaXRYbkpzc3habWd0?=
 =?utf-8?B?UnpmbTUxd1ZYVFdhRnUzOE5WeVNkbzFCdUpUU2gxNmZ3anNwcVVRS2U4elh3?=
 =?utf-8?B?YXFVcmU5WXNlN0tnSDdiMDFQbzZ1Uytyc1YyK0paTElDcHQvMjVXOG95VmJ2?=
 =?utf-8?B?TXFGUTJlTnYwU3k5VCtiWFg0UHNKQ0RTcmhJdG1JRmVFb3Z5RHB1VGVNSXE1?=
 =?utf-8?Q?Dz66FNyIW7putlCwu5zdAl/wC?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8UU8rARNve42uIr2ib9+nO0NcYhz8jHVSePXy/GozJL4/LWGAlOhJ2o9Aj+OH3LnVEjd0J9ySmOsl2tsZiXcz8BKnssHt9cG96LfSD7loSQuEfM6mzEjveMbRCgwoXrR9SMSbQFEkp9QRzKyx1kvJ1EWW40A4RvU85ckpm9N4l6pdYL0/XSD+URWuetBg9R40Nq+v0yCtvupHT0qYO/QlvNROSNt6IEKPxwwRvviFX7k/fW4VWhhEQUxqGiM/YUlkymEaww47PTb/xG5LfwAoGbR71j6lq1VbO+mdPl/CZb5ZzkPy5DbluOO3d0yWja/eIPzrKhVc97+mFQ8uka91PITFK2JrioU3FR5u5ozmVXqtOY6hSJOWPdIRwzeu4H7nsxlzuVQoked6iDWlyA10xW8KZ1+Q8no/6hyHmLNa1v4yxRwRIiKa8m2llNh7vGkDfEVbHa0jzxPk4IFaJ6xpJ1WaJdtyQ9ZkXO8wOfMDslMVk8yvKBgiofUazXWIpugbxEHu4EDfYnS3NOTdyeAT5L9W+G0NC4MdU5rsoFXf8rIcud19h1sotZ+xGOlTFC0quL+o29CmcvOca4bHooMkM5Y3kH1B3yaa5PKyhbQyD0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dd4fdd5-9161-4706-3e97-08dd9842b514
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8710.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 08:37:23.3055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GurGlOe46IQCaFAk1Y3zVtrWKoXtgGQ/TiAOVlJS41h8uYrEdFQAzTn1bi8RaV7m97b8PTkDF64/doVEvIQTxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4407
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_02,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 suspectscore=0 adultscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505210083
X-Proofpoint-GUID: wqx1fw-TVViaZoKPvnjvcZh_ZrVwRAzg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDA4NCBTYWx0ZWRfXwFRHWy/UhIvv kxy+jD05egxbnrophQ9ZAv63A/ObHs4+kIKRjWkLQQoC3H8NdyB1MQ3T45g0kxE4sO5WM7Pge0l Q34hhgQi94KC6RSyfV1hAi6o5+ky2Q9ANaxhqMA/624My0JdrziSLAd+uGwePkziwv4ZuwTage3
 n4z6+DbWQOeMn1YmYl2Oo7GO4QaPfwqkRu1m6bSqvxvFYDd9DR+eX3KOaHnVPrafwWvp4uSym+s h4ihOZOwn3bFXxyosABnUWiRiwFH4gwsT6jCYoy4zeB/9k6SnBFCNjnIXYWTexETq+0LUL/H1G0 C+YY11mi6bBpvkuAXqeouT891T6Dk94KeD6MFXrWoW/xPqaK10E1XFLXuvnjZI9Bu4JXUaGf0z8
 0gxxp5Y4/prTr2pbtkbddRN5fuZv4UFxKk5lCPbp2AhuJhviEijza1aGWiV0L9xTMMUle7Ji
X-Authority-Analysis: v=2.4 cv=e8YGSbp/ c=1 sm=1 tr=0 ts=682d90c6 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8 a=kT-NTsFwAAAA:8 a=YMHIh2XdHQLm0B4FOWwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=TLwuWKmryFjkTYsgBL5T:22 cc=ntf awl=host:13206
X-Proofpoint-ORIG-GUID: wqx1fw-TVViaZoKPvnjvcZh_ZrVwRAzg



On 20/5/25 17:19, Forza wrote:
> Hi,
> 
> On 2025-05-12 20:07, Anand Jain wrote:
>> In host hardware, devices can have different speeds. Generally, faster
>> devices come with lesser capacity while slower devices come with larger
>> capacity. A typical configuration would expect that:
>>
>>   - A filesystem's read/write performance is evenly distributed on 
>> average
>>   across the entire filesystem. This is not achievable with the current
>>   allocation method because chunks are allocated based only on device 
>> free
>>   space.
>>
>>   - Typically, faster devices are assigned to metadata chunk allocations
>>   while slower devices are assigned to data chunk allocations.
>>
>> Introducing Device Roles:
>>
>>   Here I define 5 device roles in a specific order for metadata and in 
>> the
>>   reverse order for data: metadata_only, metadata, none, data, data_only.
>>   One or more devices may have the same role.
>>
>>   The metadata and data roles indicate preference but not exclusivity for
>>   that role, whereas data_only and metadata_only are exclusive roles.
> 
> This sounds like the old preferred_metadata (Allocator Hints) patch 
> series from Goffredo Baroncelli[1] back in the 2020, now being 
> maintained and improved by Kai Krakow[2] and others. Is this an updated/ 
> enhanced version of those patches?
> 

Thanks for the comments.

I haven't reviewed the implementation details of [1], so I can't make a
direct comparison. The goal here is to define a generic device priority
range from 1 to 255, which can be externally assigned and stored.

In one of the current modes under development, ROLE_THEN_SPACE, devices
are first grouped by three priority levels, then sorted by available
free space at the time of allocation.

I’m calling them generic device priorities because even when all devices
have similar performance—as is common in most general-purpose setups—we
can still use priorities to enable simple, linear allocation for the
single profile.

>>
>> Introducing Role-then-Space allocation method:
>>
>>   Metadata allocation can happen on devices with the roles metadata_only,
>>   metadata, none, and data in that order. If multiple devices share a 
>> role,
>>   they are arranged based on device free space.
>>
>>   Similarly, data allocation can happen on devices with the roles 
>> data_only,
>>   data, none, and metadata in that order. If multiple devices share a 
>> role,
>>   they are arranged based on device free space.
> 
> The Allocator Hints patch series show that this is a good method. We are 
> several users that use those, also in production environments to good 
> effect. Some argue that having more tiers would be beneficial, it could 
> be combined with defrag or balance operation to place data on slow or 
> fast storage.
> 
>>
>> Finding device speed automatically:
>>
>>   Measuring device read/write latency for the allocaiton is not good 
>> idea,
>>   as the historical readings and may be misleading, as they could include
>>   iostat data from periods with issues that have since been fixed. 
>> Testing
>>   to determine relative latency and arranging in ascending order for 
>> metadata
>>   and descending for data is possible, but is better handled by an 
>> external
>>   tool that can still set device roles.
> 
> Benchmarks using round-robin, latency and latency-round-robin and queue 
> based scheduling show that latency based allocation can be particularly 
> useful for some workloads and device types. It is difficult to 
> generalise, but based on benchmarks we see that a good all-rounder is a 
> queue based approach. See [3] for a complete set of raw data from these 
> benchmarks.
> 

I'm not commenting on the implementation details. My point is that
dynamic latency-based allocation was previously rejected because
temporary latency spikes can mislead the allocator and cause data to
land on the wrong device.

That said, for reads, there are indeed patches that support a latency-
based read_policy.

> 
> |  # | Storage    | Jobs | Test                | Policy      |   IOPS  |
> | -: | :--------- | ---: | :------------------ | :---------- | ------: |
> |  1 | HDD RAID1  |    1 | RandRead 4 KiB QD1  | pid         |      81 |
> |  2 | HDD RAID1  |    1 | RandRead 4 KiB QD1  | round-robin |      93 |
> |  3 | HDD RAID1  |    1 | RandRead 4 KiB QD1  | latency     |      89 |
> |  4 | HDD RAID1  |    1 | RandRead 4 KiB QD1  | latency-rr  |      87 |
> |  5 | HDD RAID1  |    1 | RandRead 4 KiB QD1  | queue       |     102 |
> |  6 | SSD RAID10 |    1 | RandRead 4 KiB QD32 | pid         |  68 800 |
> |  7 | SSD RAID10 |    1 | RandRead 4 KiB QD32 | round-robin | 143 000 |
> |  8 | SSD RAID10 |    1 | RandRead 4 KiB QD32 | latency     | 142 000 |
> |  9 | SSD RAID10 |    1 | RandRead 4 KiB QD32 | latency-rr  | 137 000 |
> | 10 | SSD RAID10 |    1 | RandRead 4 KiB QD32 | queue       | 143 000 |
> 
> (table wraps)
> 
> |  # | Policy      | BW (KiB/s) | Avg Lat (ms) | 99 % Lat | 99.9 % Lat |
> | -: | :---------- | ---------: | -----------: | -------: | ---------: |
> |  1 | pid         |        328 |        0.310 |   30.016 |    242.222 |
> |  2 | round-robin |        374 |        0.091 |   26.084 |     60.031 |
> |  3 | latency     |        358 |        0.041 |   26.608 |     32.900 |
> |  4 | latency-rr  |        348 |        0.041 |   28.181 |     33.817 |
> |  5 | queue       |        409 |        0.050 |   24.511 |     35.390 |
> |  6 | pid         |    275 456 |        0.458 |    8.029 |     10.290 |
> |  7 | round-robin |    572 416 |        0.217 |    0.338 |      0.627 |
> |  8 | latency     |    569 344 |        0.219 |    0.306 |      0.400 |
> |  9 | latency-rr  |    547 840 |        0.227 |    0.326 |      0.449 |
> | 10 | queue       |    571 392 |        0.218 |    0.457 |      0.594 |
> 
> I think md uses a mix of queue based and sector-distance based approach 
> depending on device type[4].
> 
>>
>> On-Disk Format changes:
>>
>>   The following items are defined but are unused on-disk format:
>>
>>     btrfs_dev_item::
>>      __le64 type; // unused
>>      __le64 start_offset; // unused
>>      __le32 dev_group; // unused
>>      __u8 seek_speed; // unused
>>      __u8 bandwidth; // unused
>>
>>   The device roles is using the dev_item::type 8-bit field to store each
>>   device's role.
>>
>> Anand Jain (10):
>>   btrfs: fix thresh scope in should_alloc_chunk()
>>   btrfs: refactor should_alloc_chunk() arg type
>>   btrfs: introduce btrfs_split_sysfs_arg() for argument parsing
>>   btrfs: introduce device allocation method
>>   btrfs: sysfs: show device allocation method
>>   btrfs: skip device sorting when only one device is present
>>   btrfs: refactor chunk allocation device handling to use list_head
>>   btrfs: introduce explicit device roles for block groups
>>   btrfs: introduce ROLE_THEN_SPACE device allocation method
>>   btrfs: pass device roles through device add ioctl
> 
> 
> 
> Have you considered how to deal with `df` and disk free calculation? Are 
> device roles preserved during `btrfs device replace`?
>

This is the foundational framework; the remaining features will be added
progressively.

Thanks!
Anand

> Thank you!
> 
> [1] https://lore.kernel.org/linux- 
> btrfs/20210116002533.GE31381@hungrycats.org/T/
> [2] https://github.com/kakra/linux/pull/36
> [3] https://gist.github.com/kakra/ce99896e5915f9b26d13c5637f56ff37
> [4] https://github.com/torvalds/linux/blob/ 
> a5806cd506af5a7c19bcd596e4708b5c464bfd21/drivers/md/raid1.c#L832-L843
> 
> 
> 
> 


