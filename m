Return-Path: <linux-btrfs+bounces-3102-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DFF876576
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 14:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00D1B1F25621
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 13:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DAD3838A;
	Fri,  8 Mar 2024 13:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EbQ95NfZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="H0IrgnBR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC64652;
	Fri,  8 Mar 2024 13:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709905127; cv=fail; b=tN7rOF4Lm++HrsYujPNZwIcvfe3Q1VHsQf0qPF07UfrX1VLpbdLsJy571XShDsIaxk0ROvOVsT7cv+NvYgABZRulMIbouLyA/jrn6YbaoOvnkQO0DtAh4vJO/Y6PWd2FJ41ZhuS2ZOSS1dSGD7MWJHriU7uEFxbtrJLiuA9ZJCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709905127; c=relaxed/simple;
	bh=m5kMNXdBOdHdxhGeite5Yo6IuXP0nvfds2n15Ezhn20=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OVzCBJq/Wy9e6gOMih6C5I7DPn3G3z/vz1XErzXOacdIdzFGz5ptNtmEN/C4zgzvQe/xXc8ZPbgn9uNFev4xPSEkVJtddj2A/yS7qm8VZvFLgtaRR5bhyDrlLE9nGSx2EPmEoTMTGnFnEdCYfD9LlEP8WEpBACWQyb+eqlOwWCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EbQ95NfZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=H0IrgnBR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 428DT5hp030404;
	Fri, 8 Mar 2024 13:38:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=LEurKvpMzQofG+PTbRU+0qhIinAcJnZ8q8WlyIcS5AY=;
 b=EbQ95NfZ+TjDVCNS/eLoWiksW+EO/+Uv4T9EojkaPQ29hXvFrfUcE+RYPP6FlW2X2nxn
 y7Czu//Xt0t1APsLaDI0vmCbuc8ltTBYJzXCZGnuMzQa7ICZxnrtxVKfjl+9V28Tt3nk
 HNFAofaX5IjqTuSUUrsKYe4v0UyCfPNmoiy/tR3zX35DjlIfsXYON5x8AMxK5NBzk5oh
 Rc0PdhgEyS+yzvsq44Uep6+yLz2y0rKRmC+bFbRcLNLcNV2ea3a+dKZg+Tfbimcxt4un
 nHXUg9SzZY6MR/b+Kdk99HdKzwKXYMieTX06UKJheHkaCPQPseI9K+ydcbea2AOrdWDI Wg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wkv5dq27j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Mar 2024 13:38:43 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 428CtXqW027590;
	Fri, 8 Mar 2024 13:38:42 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wktjdakpu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Mar 2024 13:38:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AMq4lDNyaPMKL9a7SpDGox6RnN+kKk2QETwrqQfmTnP0+5NDO6DtOLL9eDGTFQf+/YU8MX097PNW4ZX29UEx8PNFlMwvsUAvba0Xh56EzHo8thIePUslPDmX2a9OQcmX3QbVvWq/UNGb0CtOQur4V8/k49xVkIAor68ZXLoa7sVth6bWvCLUVBDcMeE463E6cXnpLSmACF1PfXftkRZGQ/kgoU1HyVLeYhVXD2tfPra7q30MDjMay0BkgMUOMKXZV05++sjFfJQ6K4kqxsfMm/m4foqsV22WGNl8p+naeFkW/HdjVrCcNzQ4vTeBMkPwh9cuQ1en4wc8wVzqp/K+iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LEurKvpMzQofG+PTbRU+0qhIinAcJnZ8q8WlyIcS5AY=;
 b=c/AHOx8R6D3Pao1aFuMNHMi9mm3+zorp2sAXR+Xvv7ylJdFySud8kl1sL2QyOzltq/k0rpCq3EUb4tS+L4wR3LGYIRmJNrm0UhqrKLMscs7Pljk4xF6TB81hLTuwg8gnKSuaOXt9zYu/3g8HP4wQ5KsRx9+0/o6FV2AlH7/NtVnAARVFK2eoajP/99264eAV+KmimoJ+GicvyhADJo/Kch/XVgS7B3I5hq4SjfC/669EK3e6skh2HZbPcsnpefP7VuQD9MbMw9yL1x7HQHZ2zdgmG4QSDTkwlj08kbnoIEH1n0tk0y9ReR99Q8J0P2zPw50ECGcN7QHpzEwp+tB07A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LEurKvpMzQofG+PTbRU+0qhIinAcJnZ8q8WlyIcS5AY=;
 b=H0IrgnBRGUFsHGwErecLxDlI7BZvU15CW5RlkvQ16guKJxIftBWSorHE2NStsA2y1ZPQRfU7lelDBNNKn2viH0axzJ60O5m0s4I/G5EAyTuu1/4534ApLJArS5XkyH9AUv55vWJoySQs2ORsJqdIBcXvVgrX4zHLapNn9vVaic0=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH0PR10MB4860.namprd10.prod.outlook.com (2603:10b6:610:db::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.31; Fri, 8 Mar
 2024 13:38:39 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 13:38:39 +0000
Message-ID: <4df941f0-4044-4d4c-9024-3fcbf0690819@oracle.com>
Date: Fri, 8 Mar 2024 19:08:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] btrfs: test mount fails on physical device with
 configured dm volume
Content-Language: en-US
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1709806478.git.anand.jain@oracle.com>
 <c68878cb99025b8c8465221205d5de9e40777b18.1709806478.git.anand.jain@oracle.com>
 <20240307192017.4lxymyxhplysad4i@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20240307192017.4lxymyxhplysad4i@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0001.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::14) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH0PR10MB4860:EE_
X-MS-Office365-Filtering-Correlation-Id: d0d9fadb-91e5-4bad-b0ca-08dc3f75102f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	NbwgMcDBCKkklyy/cMLelwJOfDCMa/s2fsSZYH4gpJ1ePhL23+95Za3ftRY32/un1cPm0WoCUEDS1SDmiTAb3BhQp0gu8krk79VvlQ2+nJ7Q5IHOpNm3P6EeZe4z2EKxDw9DPmvg2qWOPBMQ/0GxEDD1xy5hZ22wFPPSz0hkH4Br0NNEaIQjOB71y2BXOE7tV8Tfnh3qeMOlJsTvk5kPbaZKgp7ifnZdRDZwEBVPhqbTDpw3VgTQNsRxqxTyCs53ztZ1elrcZsGuvaYswL+UVNdHtxEN+w2CbFe7qTf+7g3ufVSlwPR3E797ala7tVwoIxsmQrVYtRigzMkKlqLtgfwdKKCwbdkLz9NkD5Q+XtR/LKC+f5EuK4NFJLmpWUAaCxUdY4dp/K74sTOTwmRwmo2NILG4faXDkXNODniiy+5Dy/jQzB8p5Wng632xp9LTQljJbWXKUHnLc1oKWtn4oJ8IWyUFoCkVBgRu5Z/AS3w+L93B1GxfSTKkOt4xj1zvCWJqPqQtAwzwpGMKp95S9PHsVdgrHpgt8Ab5THddhE/hc4Bsc9cu/GZjW55N2uz1TRNWuiycySIj9Gm27AiiLtORLMm3ElTWq+9I7qUUNzkOxJQWgSlZhfLtI2TdyuJvWkSfa35CmoLduP9O2NeV4IH4m3Dm3B0hzowZTkX3Xuk=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bWROeUhYd1B0Rm1HYTZmYW9LUFp2QWUwL0lsc2drbW1WdGFZbm9FZGtMZTJa?=
 =?utf-8?B?bXkxRWFmT0g5T3BaeUVLRW45UThOZW12M01SMHU0UFhxL0xZWlBUaFpQeTJm?=
 =?utf-8?B?bS9wek1pRVdPVm1sQ3BlMmRnajFKek5qNmpFTnlacVpMREttcHRJcVVLcFN5?=
 =?utf-8?B?RHhXK2FJMWVWbXU0MWJmVktIeVhJdjVkWGFXcFczRUtMR1hKNFZlTEk0K3hl?=
 =?utf-8?B?T0tmTzNPN3FabXlMclNzNk9kU2NXOVRaVTVOamFudVFpNmhkSG9TcnZLT09R?=
 =?utf-8?B?d05uNlJBOUVkWStGRENaVUZsQW5NYldDUTJTUnNJN3NmbTdKZ2JGbGJaS29Z?=
 =?utf-8?B?QWIzUlpuNVBlTjU5eThvclRvOFIvUUxNTXozRXBtdGlKVFhab2dIVnJEUnha?=
 =?utf-8?B?Z1NlSlBGdnh4MUZZcllXMVRMRTNvaXlJT1hvY2ZDckpEOHM3MmNqQkIrNHJG?=
 =?utf-8?B?UzRDUlhoaFNFNmtmM1BmbjVDam1DYktlRUxJZGp6dnNiRXMvbmxvRmFPdi9v?=
 =?utf-8?B?aElzMnpNM1N1TXo1MUxoLzRsSUNGZVAwL1NNS053aHI2WThxR21LV014aFVX?=
 =?utf-8?B?OUVlRzUxdnJqOHdLZXlUaVU4ak1GV0Vrbm5vNjBWWTB3ZE1HUk5oNE55Y0g1?=
 =?utf-8?B?WjdRcVAwaytaalNjeFdhMU0rUktYaU4vejJlTjRlY293OFJEQzNWbVBwS0RG?=
 =?utf-8?B?ZkJUbjhSQ0ZEOFhrMDFlRFpQZEh0TGtnZ2J5REg5NklFNDBCU09Ia0w0TXVX?=
 =?utf-8?B?ajdBM0NER1FpM1VrNUcyaGszM0ZxdGx2U0s4VE1GdzFzTFVLZGlpVTZWYnFp?=
 =?utf-8?B?RmZhazhEL1R1R3RTSTc3czJUQ1hjcHllZTBPQXJDV0ZtUzZBb1JMVWljREdR?=
 =?utf-8?B?UklTQTk0aExVY201WnphS09xbk1Nb0U5eTlQU3o4TFkwWVJTcHFkWFpGQi9h?=
 =?utf-8?B?amVxbVc2UEJPRE12S090MDVnSFFqME9pbWE1N1NuVXU0L1RQVkVmSHJkZUVX?=
 =?utf-8?B?TlRVZHQxL2YxU1FhdE00TjVEaEhuMFpEbnlleGFSTGpIR2JWeThHMUFEMDFI?=
 =?utf-8?B?Z3AzZlAvbTVTNTJlZ0pqVmxYSExBV0hpb1lXR1FNbTBxUXc0L0hOMTRlYnVI?=
 =?utf-8?B?TnYzdzFSYmVzSGkyOENRN2VOS0R0YnlaVHVrMmVZMjRKSlBFUFY4QTAzVGQ4?=
 =?utf-8?B?K0RUdmFhd28va2VJMk5KWWRHVlZmQk5kV2tCNU9UTFBIL2ZiUzU4STl2eURz?=
 =?utf-8?B?SkpxZGNnemZtcEtsWk5JUU9vOEpIZ0JrUnphbHlLZEpXT2ZteVAraFNDZnFx?=
 =?utf-8?B?bFJHVDM2RmljS0VOcVB6L3ZtTWNsOGVnckZpT3JKTzhnYTlpeS9PQ3g0VGw1?=
 =?utf-8?B?a05EY05BLzVBdUpHMkVXQkxlOUlnU1NIZHR2U1dTSUZ6ZXFMTkFFbCtsVXZU?=
 =?utf-8?B?Mjh5cEcrRXNtQzhpRHpwUUJDR0o3VDcxWTJZRFAwVnJUMjRDK0dFQzczNnpt?=
 =?utf-8?B?SWV5cXplSGdoTnJuZ2VVMTdZaHpVL2pNaUkvZWIrZ24zMHg4NGhmcDMvNU5a?=
 =?utf-8?B?VWRoNU8rK05QSk5iRkUvdnF5RWxzT3BJSTVWZ3ZyVGZpN3V4dkFua1V0bjcv?=
 =?utf-8?B?bzg2eWNLcE9wU0RjVmFDY1grWEovdzFxazFBWkRMazBYbmJOY2FXTEpVN3ZR?=
 =?utf-8?B?ZXp1SVdLaUw0ZWFyR2U4dUJLYmtuVkNEZko2d1JqOXUvSVMvcXpsdFd1VEZS?=
 =?utf-8?B?eHloYzZyalJXclhvcUJHTUltamFsMDhQYWx2ZTgxbnZFOVBSbFYrN2crZ2M5?=
 =?utf-8?B?ZVV3QUd2MmtDTWE2TVJETFJxaGpBR04zMkJDN3pkQWh3WUlFaHYrNkF4U2RC?=
 =?utf-8?B?M1RucU1kaEp4cmtOelJYcFVHcm5GL3NFRzIxWnV6amgwVlJrdERGNFpkR1RQ?=
 =?utf-8?B?SUM2QWJscURPMDFGTDZFVkZqOFZZRlRETmpVeUxYRnhESkZEYkxENkcrdzhL?=
 =?utf-8?B?WkJoaWdmRUgremtWOTVpZ2wzOTd6bk5ucG9QRGthSlNOOG5ZRlhvRDJqU0JM?=
 =?utf-8?B?L0lObFJKVm1tbW5ERnpScWtJV2NZT1FoeG5TMXU2alYwMzdPSU5HQXFpamlR?=
 =?utf-8?Q?SXnaWKHIv0nyo/Xhg1UBwWRjp?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	yP6TYu0PyW0GagD1vTOPk4exQl2BvFO1CC1Ug0xR3F0qYuYOFZpsSkDqpLuDSI4yQeudH+DF2mxpPXXMulCsxgtUsU18NNcsDQh0vGDbbKoaf+5IKFo7bLRkGlbvKdyx6e7fM+gui3NKBIt4vegopQs3PkRJoVL6aJpW1FypqltKjuzWMaJW9K53Z71Zb7Viw/cl0G5EX9MfaFC3xrl3YsgC2TPyqsMOj+xRaL2cwObqEy4SSoNqKgCQ0uFVF7TVvYlBzn8ISnVUJVDw8XN+f2vz7+Ylkig5/HkMxG3FaBkRAlCAVJM57T2mAziE5l1nKPfeRZ3Y8n+d9dXuiSHOqQKapRE4eEehO0SGSMokNDob4/JOkzpmEEYeiWpqQT6gwC7TX3bCajcvpGep3bUzMYRuyoIumtkTbZ/TMBxtC8vZm36n0/yYcooKrU0LlLlc7/UtDwOczEtuPV30jKpHbMRvNyHFzv9VpoGC+bskoLKzYRTYGzWAgtLjhmbZWQIcPhe0QcMRdQO40H/WLnD/uUfQ7iSJ2FbOqlbeBpi00+PrB0eqBVmbkD/0mQpLerknOZVL49Mq5BwODj1Eey57twm26UlMCjDLvGN/e6IJkjc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0d9fadb-91e5-4bad-b0ca-08dc3f75102f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 13:38:39.7976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OyAWrd8lBSgBLoyANnPmPcDN7uyPnIPi8L/IlqCbANSRziTIkEIYdMiMYOrE0vkPiKKxuq+44CLu8N3nYhhQrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4860
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403080109
X-Proofpoint-GUID: k426u4Rk5s5i_8Rq2QmEhR_mtEvLuycC
X-Proofpoint-ORIG-GUID: k426u4Rk5s5i_8Rq2QmEhR_mtEvLuycC



On 3/8/24 00:50, Zorro Lang wrote:
> On Thu, Mar 07, 2024 at 06:20:24PM +0530, Anand Jain wrote:
>> When a flakey device is configured, we have access to both the physical
>> device and the DM flaky device. Ensure that when the flakey device is
>> configured, the physical device mount fails.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   tests/btrfs/318     | 45 +++++++++++++++++++++++++++++++++++++++++++++
>>   tests/btrfs/318.out |  3 +++
>>   2 files changed, 48 insertions(+)
>>   create mode 100755 tests/btrfs/318
>>   create mode 100644 tests/btrfs/318.out
>>
>> diff --git a/tests/btrfs/318 b/tests/btrfs/318
>> new file mode 100755
>> index 000000000000..015950fbd93c
>> --- /dev/null
>> +++ b/tests/btrfs/318
>> @@ -0,0 +1,45 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2024 Oracle.  All Rights Reserved.
>> +#
>> +# FS QA Test 318
>> +#
>> +# Create multiple device nodes with the same device try mount
>> +#
>> +. ./common/preamble
>> +_begin_fstest auto volume tempfsid
>> +
>> +# Override the default cleanup function.
>> +_cleanup()
>> +{
>> +	umount $extra_mnt &> /dev/null
>> +	rm -rf $extra_mnt &> /dev/null
>> +	_unmount_flakey
>> +	_cleanup_flakey
>> + 	cd /
>> + 	rm -r -f $tmp.*
>> +}
>> +
>> +# Import common functions.
>> +. ./common/filter
>> +. ./common/dmflakey
>> +
>> +# real QA test starts here
>> +_supported_fs btrfs
> 
> BTW, what cause it have to be a btrfs specific test case? I didn't any
> btrfs specific operations below, can you explain the reason?
> 

Right. Now I notice it can be made generic. I have converted this
into a generic test case. I'll send it when the kernel patch is
ready. For now, I have to withdraw this patch.

Thanks for the suggestion.

Anand



