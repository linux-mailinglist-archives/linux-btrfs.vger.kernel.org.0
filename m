Return-Path: <linux-btrfs+bounces-4411-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 575838A99C0
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Apr 2024 14:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 777701C2134B
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Apr 2024 12:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7EAD15FA6D;
	Thu, 18 Apr 2024 12:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UBM8sHYj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uRviJskt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD8371B20;
	Thu, 18 Apr 2024 12:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713443363; cv=fail; b=NlxSpVETN11uX2K0BjC478rGHUg71h26KMqDE3Boqbo5xdMIFp5ln0zZ3Vi7IVdWjWehPYzH7fFC/gUi2TpP3neECx/PIsl4X51fTP5C/fA3M4iaH4Ytp05ZT6p9S0bKoNW7oQJyrDNlq98JSW3uHFwIW3s7RUnmXgAG6eY2iXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713443363; c=relaxed/simple;
	bh=jVJDunWLz+Xcykb4FZHQ3k/pcx9Ztn20GwEppCiHnKs=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mF5N1D9Dh8bdQ/AKchhyQaDIN7BCltNPBL6fqwHR93I24C6UDTy0kSAJjpD3S8VoJLxeHlEvxdiN1iJ7ACgGjT0L9uthVCEwaAP9HxXecCi0s4u+nuyJBLiU2TcVJZ+4sy1F59mTG8/1OZr/XgCTLwwxPqp168a+EYd9ozup8Cc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UBM8sHYj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uRviJskt; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43ICJoiX023603;
	Thu, 18 Apr 2024 12:29:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=jVJDunWLz+Xcykb4FZHQ3k/pcx9Ztn20GwEppCiHnKs=;
 b=UBM8sHYj57uQozp38PYudfJkjn6uWhFl1vCL8FKFAJFtrxNcDSScIfjVF17PgmxKXr4J
 NRfLdiy8wcQk/HcKinpr+ScF3UNW6hwk+V7HeP/HAfwvmQyEBD93vYgbrq662sAvpj4o
 /3HfQuXDzd6nU4MwG26ipymGdFMOWsxZffsUAiAoxzNDrBfJP5XSkE/9Lbe+pDRjWd3K
 a55GO8xecF8VOSnkOWS8+4/XqfkKjdmaiBV6sQfkc62pryIoI259cUrlrGspDQOiHao7
 rCoUSySIJvvAJJMLymstlsACqwnh4yvmVhjKjT2HosqPrqvvvG5e+5dygAT5XmAl/F0a Yg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfhxbt5m3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Apr 2024 12:29:19 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43IBUfJw021661;
	Thu, 18 Apr 2024 12:29:17 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xfgggm7fg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Apr 2024 12:29:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dpKt8IjCybI6NGaKpCgh4Q02x8NnpAz/lUL7U6GD1UV3CW+ueDm7NjxALNy4Afn/WkwzR5iGUX52GxW+2mNBqbu8C53e+08FeC80Lhy61SWjIfdbegkN4yndyaxWf88eFNyWQQkb9c79rIhoNy3AuSf6aVmvGv5rHIii4wOMfee/LrHxMBJibCAFfKRzdpUfnV6b30djO8puya5yj5sQsVBSeK0bYBCUQEtulEt2YMfOhOw+xcwoxNlh/nN/5OiicQ/4SY0N2XFLGPK1qHoTZITXxYr9PfTD/rH7eBPttuwLleoTx/TanNqHTfOusGg/gnhhM091WxIHTKdNEg46aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jVJDunWLz+Xcykb4FZHQ3k/pcx9Ztn20GwEppCiHnKs=;
 b=keYT83olYkLlZS8WhWCHW7k1jOBm6EAcv5RMrD8XOVEoIQqhqDSBn12ZfcmNLBw6mf5XbOMS6f1l8006PWu2q6jnWhP6Mkh0wEvbe63yaDv6R7iEY3vS6ecijyGlVUk5mHJ2iRgXdsQ9KO3H8t5D5MKTnNq07xaLMyHthJK8uNSoLaZ+XWNldpi2qZDdM9iCEaWv/+fuJsLfQjwJbrQFyGrAgYxOUrbNP+D6voy4uk0FZ04rYvuqtNYadnimtBCuseffJycn8lbY643JGIOzRKyusNb4FALfPiaIkYxSbwYhLkznLONY3KfuFAoau7rk5IwOapgsAB8MGpOv94OxDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jVJDunWLz+Xcykb4FZHQ3k/pcx9Ztn20GwEppCiHnKs=;
 b=uRviJsktZJXl6g1QUjUhVemyXdTpGiRjfJi6mljxqOf7V+AUvWjglEdRU76t+mXV+oAfzOIXtniGIFsYg8j1J3oGXIps29uKGMPzlEF+IR+Ok5LSc5gffZgUyS5d87bfUqSLO6B9Y1TVePHcm3IWzX0Sd/Oy4dfKaf1OUXfeJeI=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB5055.namprd10.prod.outlook.com (2603:10b6:5:3a9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.41; Thu, 18 Apr
 2024 12:29:16 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7472.042; Thu, 18 Apr 2024
 12:29:15 +0000
Message-ID: <4b484c5a-6114-481b-8c69-306b674115f5@oracle.com>
Date: Thu, 18 Apr 2024 20:29:09 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] fstests: btrfs: rename _run_btrfs_util_prog to
 _btrfs
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
References: <cover.1712896667.git.wqu@suse.com>
 <fc228d4f0056a421f22de1638fd69d59827dc641.1712896667.git.wqu@suse.com>
Content-Language: en-GB
From: Anand Jain <anand.jain@oracle.com>
Autocrypt: addr=anand.jain@oracle.com; keydata=
 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
 y4F0QrzFk5Hg4pvnpDur6Cbp
In-Reply-To: <fc228d4f0056a421f22de1638fd69d59827dc641.1712896667.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGBP274CA0009.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::21)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB5055:EE_
X-MS-Office365-Filtering-Correlation-Id: 30695cfa-2c07-431d-99a3-08dc5fa3291c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	/TbCHAQYUVZdwOXqWvBuk5pAfZolKOs+rDyQ32JxlbQVjZ3nK7Rc6y0dXRfXtP5QEnHiU2HXgjAGAXStKh6FHQ3nEEHNc2m5TN43bPneuB+kO5mFH+dv7w36Q+EppjY+n9TIa/eNatrBXaR3ottMJ0v9J3+5p933WWok/vk64rdeSh6JpdSUnbfbYAjj6Hxa5kEr5XvPPnWw0lWCfWOlTn0B0jZH/nAUa66eCvZYQd1keVQXc1QhDTz5hE91NND8loCtwBYSF77tLpY2qXYXdcQp8Yt8u+8IpieaRruATsCImZp1iMDsG38Rqr1tFaNNr0flN7VFov2Vt7VOu5qqpSQ48/zyQ/t45xJnkTC5nt5rtrSNSvOTpFHMnIM5z0nFg9jG+CtzZXWgG2ogrdr+ReDXBy0jyDYRX41rANuKLBk8zeop5+stYn5/wpb81EcV57kJym+shzwC40X5phH6bt5VqqlXjLewZwjKvvCyMPIAAaeQ6px0wAP3ZBCjebbt3MhSH/u06RG5kkYllZooxSHmo8QdywuhsIWJXoNLogNOf3TZTIvINQApntnZljV9DKpa/U1igOO8c9egW9iKuxJZPoXg/nEVql0NjHhK0pmiKmDOOLvX7eUT9lQJpr67VFdtOAPynKLhigWy/QI0HmE3JX+L3JtiQapareqgGIc=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?M1JxSWZvUVpSTGVnZDh2QmV3VWVMVTFQaWtLK3UwaXFLbE5ab0t6VjNLekZ1?=
 =?utf-8?B?ODVpVXRZV3BlNVZSaXVsTVBYWkhlaTNIdjcwNDk0UnVYVGJMYnRDSkcvVXVr?=
 =?utf-8?B?NkVwSEZuR21UdGZmVzFsR3BmdHVKaDhzeXdiNVVKWTRvRkdMRWRIWFJtZGg4?=
 =?utf-8?B?SDhvek15OC8wekttUXl1NVlNQVJEOEhMbXI0NUlVeHR4UDY0cUFJR2dzaWZs?=
 =?utf-8?B?TEhhaDBpWkdHZ0pHRWVDWmJoZnhXUU81b1k4TUJTRVc5dmlXMENmTllJdDU1?=
 =?utf-8?B?c2toaWlwRHBOR0x2dFVjOThNeFc0NnRycXZQRGFMY1ErR1R5Q2tKU3M3MXpn?=
 =?utf-8?B?b1FJcVBmR29LeW55WGxtaFlqU0RBODAwRFdtUE5DUCsvY1dtK3IvWGRJNjVH?=
 =?utf-8?B?SlY2Yks0N1VhSjA3cmFxRnJWd05CYklVeDRiSUhMN2N2L2xKcm1KSU9nTzkv?=
 =?utf-8?B?TFNRYUQybG5kcVhjK3MyUnU1TlJvR2FrY2MxdFVaakh6L1BYYUtLaFRxdm0w?=
 =?utf-8?B?ZTBIRGVMUGVIMjNJVTJBdUhYYzJIU0tUdExLUUNncDFNdjUyZ0pqMEovcmZD?=
 =?utf-8?B?MFMxenV2eXpQU3JwaExEeGlNc2M5YldVWWVpT1NsakwzWllqUC9qaW5TbFd2?=
 =?utf-8?B?b3Z6MUEzSG1ucmpPODVIbFlrejN3UXMvQ0NTa0lOV1hlMWtaTGJCOGNJRjdZ?=
 =?utf-8?B?K3BvMGRubFRNUjJ0R24zbUlvMzdsbjNVR01XTzFINTE0SUtveTJKbGV6Wk90?=
 =?utf-8?B?NnNoZ1lxeXQxVkROUkdlN1pGMitmcUJjMGd3cUwvYkltcUtVdGZQYWJQeFdx?=
 =?utf-8?B?cTFjbitJNS8yRFA3YkY4MzdkK21GUnBRYjBUeWR2WFVqekhFSUtnSTd5a0pu?=
 =?utf-8?B?UHY5R1lrWldnVVdlUWhoNXZQd255aGxReThadGRjWkN4djV3S0Q4WnNzc0NI?=
 =?utf-8?B?YXZPeDdTSi8wNmFweXRmVTFIL0ltVDdMMTdzc1MrVklVbU44dVltTG1VYjNo?=
 =?utf-8?B?QkFsQkFIdFlpYmlEd1hWQkIrWUZibktCekxzSzcvOWpmemhpbjh3ZkdqZEFi?=
 =?utf-8?B?WUJMWm1FUm9SQ21VQkt1SjVzUmZVOUFEVEdDWitPQUFZMHhSajkvZS9vNHJH?=
 =?utf-8?B?Y0xhTHJhckwyaWhkdXBuV1NKbmRpTFF4ZS9kYXA0SUMwUWFCMGVZcjdtNHB5?=
 =?utf-8?B?Vmo3S0RLbDlGUG8xUVBzQ1Q3c0p2Ty81YStzL3l3NW1tYmp3aFlYSjRTZEQr?=
 =?utf-8?B?QlFzcm9vK0RnVmRVNlFYWWxuL0l3Tmd0dG8yRHhSWWY3VGpDUTR0bHdxUDNU?=
 =?utf-8?B?Y0IyTFRTdksxSzNpTWdOaE94TDBOMTNEbjBydE5NOEN3Q002eDUyTGRrRzNk?=
 =?utf-8?B?Mzd1dnZacWZwd3M3UTVUNVhZaFV0T2pyK0d4VzdYbkdqaHIzWmJqUUZ6MWZH?=
 =?utf-8?B?bVFOMU5BZVlPalhhbWd5R3JIMEVQWVhoSUZGYmRGMWNRZXhCS1lzN1NZVUZF?=
 =?utf-8?B?Mit5dWpXdkxFUDdyZlc2b2kyTnhaTUI3YVVkMStoejdGbmRyWGNEZktpTy9O?=
 =?utf-8?B?OGcrK0JXU0FWNno0eGxCMEtVVnhLdjhuemxuRTM4QnFzUWdUTENJYmtBZ1ZU?=
 =?utf-8?B?TEh4V2lDa1pxWkJvUkhNRVl6TkliaHczYVRIbVYrd1VOTk5GWWhaUFN1SW1l?=
 =?utf-8?B?czcwakR6bEpyUzgyNkRKWGcwcnhJSlZjM3pSVk95Ky9ldUxMODFzdWhsOTBp?=
 =?utf-8?B?UlR1RWY0dldLejlKMm90MEE2aFA5MnNpSm14N2YveWNzOFRBc01mMFVUTzBs?=
 =?utf-8?B?NDgrZDkzYVA3VmxRSkVOZDRCVmEyZi9zaUxLYVg5dXpmbjVPQmJlQWZCMXN1?=
 =?utf-8?B?SnU2eE1pcWtreGY5OTc0TGhDUSs2RU5waDlFZFBPcTMvZEMyK2RONzJtVUp6?=
 =?utf-8?B?bmFUenIwN3g5VUt5aUhhMTFaQTZ3ZjNjVUxuMTF6Q0lPdXIveEc5YkJyT2dX?=
 =?utf-8?B?M1hxVTU5Zk9SY1pqcUcxU3ZEV3RkRXgwQ3NxUkY5cjhKaHlXaU9sOVBsQ25F?=
 =?utf-8?B?YTVLWVRQVDFTUk0rSHdyMG82WG9WRWY1RWV0eU9tR25oWWxIb2RyaC9QZDVY?=
 =?utf-8?B?MUcva3M2SnRtdUFib2hRcjNTU0dnSFFTSjRXaXdITWtvcldTS0ZxYjUyTFFz?=
 =?utf-8?B?dmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	1k6acy8TDSQoF++ZCK25GKYB4QFcv4GqJAX0UlSUFCKegfcEaH2U6Q1S3JzaVbJn61aGxH4RSSg93BTlHjH3ynEzeOJLEHQ2yibNGKuabXd4/F9fUp7TMzX8AVqe4SsORuYyRemwtQXJkY+GmMvQbpxGgttwrfU/lHOOUk22aeCT3ALqfAUxzNcI3fl5w9MdeErOjdJ2ze234KNHx/6tlcEWzmHDQYqHUZ63n2GiaXWjrba91n8wh9APVPjPk7G4K4DCV7UpLn1newKDHd78hG9RWhWB68dUsdN/h+Fs/kLT7cWaPMMLESV52VazUCXZcLLOv7XR9tyRj8OgkQFKp/1Owp7U7nbvm3U+24NqIbtrkmjWTStwK+YPqqoMPTP/mWCJ1ypjDR/GHgYrKDt+76YtQmIkGKTM0plCkJJhEJsMFiJ3ZBQwWWF5tuqfN7SsV99ZcC4dWRkt49ODDXlGoojMVpQIUXcvOWqHDN1U40AF2vzPu3e8qoYaUn8Mdd0ag+MuXYzNp9pC8XKcXwzQlxuPNcBSMvBbHTjleYDZcPszEyn8IwmFAWAZcsOug8J69B6KiSVh/KDzWWMTKdRK7EEBJ5reYdIJLOv7RDH117U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30695cfa-2c07-431d-99a3-08dc5fa3291c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 12:29:15.7124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X+4UAcm00jnEpQ3aik6PRTSjVwBLos3QqChVRe+hVsqpTBGAfboNZk9LwRIhgC5YtHMt7iqog0Q6H9wS76vSFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5055
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-18_10,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404180089
X-Proofpoint-ORIG-GUID: pWg8qETYj359jJIWs5T2p8vXD7TsqTY8
X-Proofpoint-GUID: pWg8qETYj359jJIWs5T2p8vXD7TsqTY8

Reviewed-by: Anand Jain <anand.jain@oracle.com>

