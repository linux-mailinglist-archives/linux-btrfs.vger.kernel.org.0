Return-Path: <linux-btrfs+bounces-13969-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB2EAB5096
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 May 2025 11:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 021AA865085
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 May 2025 09:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8346123C508;
	Tue, 13 May 2025 09:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="H17hRUux";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="V/cOuhZy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1220D23E342;
	Tue, 13 May 2025 09:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747130261; cv=fail; b=raSvOauXI6UmEkvaieWTaHGoBd16CyZi8OlwEP6+5WYLEgUqA3d7ufnvJpVm+J9HcuncUZCboyjcfJAiYTnAlqUWS7JQcLXWvZH+ZFMLSn5R+jI1MwwCk+1P3AKPz5qcw1bMszPWl6Vq+/EcfqohwAMYwA9U9J04PcHQ2Q4Yu3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747130261; c=relaxed/simple;
	bh=Ym6eWGWe60lbeQ6LlMWeza37MV/7UKnOafUbHhsOOhs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jUwm/2IsWTFdkoidmSf6EyGAE1pAxsisbYebgTR8Z3JTz4JQA4EhFu+/zIfD9AxTWRJyzm1Q1W3v+9L+8VFDxfeaGJGmZFZnDpRDgkuEzWx1HELS0r8cPx+m9H7J+EhNBKJXaZ7BHDEjly46Tn15vZlmcrscSv6SRsywNNgOQv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=H17hRUux; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=V/cOuhZy; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54D1BtAr000697;
	Tue, 13 May 2025 09:57:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=rI8AM98QakEf3wxsq7WTc0wsT7hEKj974sTWsBAkIhI=; b=
	H17hRUuxalUdUY6zX8T6Uq8cAyt9z5xxG5Jd1Prgglv6IZ0DedaTGRnQLekOAABV
	5CooIsQnvhxiq/wr7kaJ4Liv7liwpJc+Z/n9db4koxga9tNe7rbNN7N3DwkNdcxL
	9St+okvdSjzZjmj3mQ9GbsZEi3s3yKHmH5mjuEB/oiB+zQRDwJpT4vHfqTYkTJQn
	i94eqTTgDkSRchle5zZ76UEetjdsso6ELjyhEewZpTbEDgu+KMmNMjWoU4iPDvsv
	xT0lDDeiN3MyR8BCq3jsy7vzPxq4E3U1O5Fyli/OZ6qaxTBVQlzhRA7ow2/0dZ33
	0BKmSygbjUpMCAI66ITfzg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j0epmb93-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 May 2025 09:57:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54D7pMpp033187;
	Tue, 13 May 2025 09:57:27 GMT
Received: from cy4pr02cu008.outbound.protection.outlook.com (mail-westcentralusazlp17011026.outbound.protection.outlook.com [40.93.6.26])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46hw8eer9d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 May 2025 09:57:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rIrKHNTBfehi9NQmjWWMSYJ+3XnIjpOnMwvFnpO2TADdDNlMR/SjpqWRkDMWj/8M2efvBHu9sBM822fATsJnOBFegyBKX8IjVFKijuy3Zl9f+6d9jCnGIWYuoTU8+qoG9dKHe7qthSS+AxamO19FrHpUboh8je0XMXtHVhtkWt4owVkb8M7rgPV9cEC/OqmIOic/h6/FMiIgwS3VcxXZgBFeUbjiAQud3DPBiO3VKdyH37Vmh/d/3n7ylSWA4EN8vARMljIjS0kPfODqRcweH0F1z+y8MsKJBFnGPsvvVnCe33hUN5RGsQLFcv+dLhPI58l1O0IH9oWiVGlE2ZWT1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rI8AM98QakEf3wxsq7WTc0wsT7hEKj974sTWsBAkIhI=;
 b=FUiXtr+mcrKMWAfn1kuDaVsYm24Uq7INgbV3NLmGxPvi+IezTscjDkMLrLZr9+FOBGEyX81RxKb11LCdwmKN8rpuzlkvbXriuoD3wF1AIV8lYgXqxoC5M3rd7+v4J2TVhoh5NGyyo2A7CYOE7fluVEDrmnK/zql5tbWSU/N7r8zaoiCjgyxnvdyA8yV3lbnIgXXhJ1xnpFyDAffVdejW9YAANXmdSM/jt3tGjBxPwBlSNc7seRrrstvv7An5NWsL5RcRL1crm+xYVslkVaZVJXh7NKo+m7OHQnGS6I6qC3NRgO/5M2jEJvtOeiMx5Z32pu3QnM+8mPGMEUTjUzS08w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rI8AM98QakEf3wxsq7WTc0wsT7hEKj974sTWsBAkIhI=;
 b=V/cOuhZyiRsUhY/lMNXGVMk6X1tb8etJ+1yX0CUuOTseZKUwAqtJjiKGppGwVWwVMdbF7NDfLGdnki/+GmOyNTrx5hpqLdHxJN6BXGPGLO1c9GMYBw7Np0xzMWsuhNCpq96UhguzZwOTGIHyFZZ/Wo6XRf9W3/704H6Q984YJKo=
Received: from IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
 by BLAPR10MB4961.namprd10.prod.outlook.com (2603:10b6:208:332::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Tue, 13 May
 2025 09:57:24 +0000
Received: from IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5]) by IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5%4]) with mapi id 15.20.8722.024; Tue, 13 May 2025
 09:57:24 +0000
Message-ID: <f442c391-cb4d-4b9b-ae1d-e38d2d573c25@oracle.com>
Date: Tue, 13 May 2025 17:57:19 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: btrfs: a new test case to verify scrub and
 rescue=idatacsums
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, Filipe Manana <fdmanana@kernel.org>,
        Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <20250512052551.236243-1-wqu@suse.com>
 <CAL3q7H7cqfhVNwEJ6dgXgZSmfUbOrSNZuua3MPWTs0LJ43BQXQ@mail.gmail.com>
 <c119cf23-3165-42fd-85f8-e2240eb9b7df@suse.com>
 <CAL3q7H4dxAGTK9XBe2Yeoywy7-HTktwt_Jcp=FE0yNYnrU8H0A@mail.gmail.com>
 <4208096e-459c-4379-99a5-6bf1defc65ac@oracle.com>
 <0d50d010-0010-4cee-a663-c6e86b3b5409@gmx.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <0d50d010-0010-4cee-a663-c6e86b3b5409@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::12) To IA4PR10MB8710.namprd10.prod.outlook.com
 (2603:10b6:208:569::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8710:EE_|BLAPR10MB4961:EE_
X-MS-Office365-Filtering-Correlation-Id: 1530d6e3-1657-4f95-fd40-08dd92048f6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WWpTSUxhOEF6ZE1LcVhHa0NpdzZremlISVVvTHpCaUloaGJ0K0Fmc21TZlZI?=
 =?utf-8?B?ek1NVFZIazFmb0J5MFpVMDBYalZnajNrZ3pkREJSb3ZFbkQ2bDVvc2t2emFp?=
 =?utf-8?B?TUpKVzRtaS9uUFIvYkVmbWtqM1dOQW1zRndNM1ZwcGt2cmp6TVFjS3hwYTVt?=
 =?utf-8?B?SnpqTys3MmV0ekZCZUJ6dzJtWGYxM3E3TjNycHByc2RiQnd5bzE4eElMMUth?=
 =?utf-8?B?L3lwZTlBMzZsN3lIeHhQNEQzdE1EdlRTZ0RkUjJnSXRhUElYaGdwWEMzWHRv?=
 =?utf-8?B?ZHF4eWdYZFVpVC84K3JnRW5QRHpDQk40UHlGS2ZpS09hSjZPNDhvYnh1WGNl?=
 =?utf-8?B?b3pYdnNvNGIyQSs3Zk80Y2FvaFNORmJ3YXNHRFJoWHFWWHdaVXZSNmd3T2NR?=
 =?utf-8?B?SzJHcGNkYXBjQWF2bjhwUmNOdGkzcDhoakV2NURlUWhKSXVGRk04cFVDOUNH?=
 =?utf-8?B?ME82eTB6K1B5UDFHL2R6UGtEU0kwWExJc0toalpOQUZReVNOcUxKNEQyQmlk?=
 =?utf-8?B?dWlpUG9JM04zK1EydVd4b1dWZkY0VUwybWNEb2poaW43T1ZKWHZNZHh6WWVw?=
 =?utf-8?B?MEpSTXBCc0hGdkxaN29ZUEJkK20wem9nMDBiajUxcEZ0YVFRSVNaNzFYdmF0?=
 =?utf-8?B?MldEbnVNSS9HSnNKZTNJRnV3TWRIbzdKWmZlR1Y3ZWp3WlZLdmFua0NZdlZQ?=
 =?utf-8?B?eFEyUDcxUnRjMGpEdlZ2SUFmdzBla1cwWVNvcGhOdUd0WE9VWWg0Vm9aTlJD?=
 =?utf-8?B?eUE2RzU3c1QwSWNrKzBJQUlNVDZDdnBacmx1VndXd2FuOWNlWklhbWxHSnFx?=
 =?utf-8?B?cGNYVFYxdmtoREgwTGhrSVN5YnI5V2NLcUdVc0RlU0xYaFdJWWZoTFoxSUQz?=
 =?utf-8?B?UVJzaWFibTg3RkZKMVI0MGRCakl4MlZySGJnVDNHR3ovcmpDSi9vdCt5Z2cx?=
 =?utf-8?B?cTIzRG1lVit2aGg3dkhlZ05WZGUvYzNmNzNQNmZNSXcvWWVNcElqNEFYUEEx?=
 =?utf-8?B?TVllRVMycDFmTXBqR3R6SU9DT0dQSEJ6N25mSXFWblF6N0JVUFhqSjF4b0ps?=
 =?utf-8?B?eEJDeTBxVmd5YmdTU0hhOEFUTERiMXpGOU9ZQ1U1d2crSkljd1B4VVdtcCtP?=
 =?utf-8?B?M1laVmtTWXZyeFpMU0ZtbkphcTdhSzlFQk9FbklTM2h4RUplSTV4QlZyRCtY?=
 =?utf-8?B?K3F6dkRhQ05yMTVjR05vakUvZEIvdDYyTzdRTjZUd21EUjY2S01BNndoT2Jo?=
 =?utf-8?B?cUV5b1FFNnlqQ1lBcFBvbzNxRFpramhydm56elNCSFFreWNwdktKc1hETmpL?=
 =?utf-8?B?RnQ0Vy9WQTRDbTR6bjFFMzVIRXZzSWorSVZvZGE2YzZMUFVNZEZLYTg3NlRG?=
 =?utf-8?B?ZlpFSEZoR2FscVJjdm85akVCMUVaaGVnaHpnWWxrSFMzTzdSbVJLZjl0Y3Nm?=
 =?utf-8?B?REhnT2daTEFmNkpjeTFvMUpoaVE3YXhGdHB0RHpSNjJad1ZISDdlcGhuUDF6?=
 =?utf-8?B?M24rajF4bWp4eXBOaHNLN3Y5cnZNeXE2Yk04bVh1S0YxV0phNzdFR1ZHT0pq?=
 =?utf-8?B?VFZvQkFnQk9TVDJIUGxvMnI2TmNyY0RyOGpaaHJHQnRoRTI3Y3hidmI0N3dI?=
 =?utf-8?B?V2drTm1tUEhTQTNxUVQ0TmRROG50MmtvOExZZ0VNQ3JqcFFkY3l5cllLc0VT?=
 =?utf-8?B?NzdzcVVkd2JqWUl2SjRCbUhrVC9sSnB2V3M5cTQyOVdOdlMybTdDZmhOblU4?=
 =?utf-8?B?RnpXczRUeWFtSmZYVHI2OXpIWHR6c3VpUHQ0eWhDdTFiZlNCbVZTblRKK0VE?=
 =?utf-8?B?TmNmdml5dk95WUlvelNaeTFiRlR5ZzVyM2VDdWVud1cwaTA4M3B1bytpSzZ4?=
 =?utf-8?B?b08wdGN1N21MVnpkV1dmQ0x4Q3NNTUNWWlJCVmRlcjY2eXkvcSt1OXNUQ0dt?=
 =?utf-8?Q?bn1gVe7LXjY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8710.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZnUyR2dSZ0xsQjIzWG4rNFFmK1JzSXFKdVhqVGM2dlUvaXFMS3Z4cFZ5K2F1?=
 =?utf-8?B?aHg4STdSYmxmdENEeThDNWR3WVVzMkZ3VjhPbEgvcUFTaUtaajVFL1lFcGRQ?=
 =?utf-8?B?dUdvYThFVzBYUU5CTjRPd1Y5YnFaYlhheVBTai9oKzIxaVUrSUdsU0tBWlZx?=
 =?utf-8?B?WHA2dGpSa3UxdGczUTc2WlRtOTYzS25IVmhTU3V1UE1zR20yZUx6T1cyS0ds?=
 =?utf-8?B?Z1ZiUHZIb3RVaGZXTURZUEJpZlh6c3BHbmdjdmNVSDhVQTdVa2xCYkd1amRw?=
 =?utf-8?B?RjNIQlpONjhuWkRrNzd0Q2t0SjN2UlRvWnNvek56ZldKLzNUUEVyUGJXUDRS?=
 =?utf-8?B?elhBb2NydVVBU05MOWcrT0RBRGVSSXNkblF5bXFUb0NGS2F0VmJpTmd1OER2?=
 =?utf-8?B?THdONE9KcEZ0M0p0aXNlUGR5b0VTZzVaaHVrMGdQYmkrbVZZZHRZa2E3SHh1?=
 =?utf-8?B?ZlQ5SXJNRjNXQ21lMU8zZGlLNzZtT0EyNFNJUzZNZHdwZFBKSFdXZ1M0ekpL?=
 =?utf-8?B?NXRYUFd2S3FtOGwwZE1xOEJvVFNBbDEwOXFtYm9ERlkwMlU2aU9HS2Jwd2xu?=
 =?utf-8?B?Q1E2eUhHUFFJUHE4RmFkMmxzOWliMkRBZVpjQTNNcUc2M1pBbVUwODVVbmwr?=
 =?utf-8?B?c1hUa1RCY21uUkpzOWxsWU1hWGw0bXRqaVpUY3ZacGduL0V4TVlOT0owb2V4?=
 =?utf-8?B?VWdyaXpBUGUzZG90Wmp1NGV4ME1JN0JDVG5KR01YOUtVUlQ1ZTF3SmRpVjBz?=
 =?utf-8?B?c2dCZ0NuNlpnK2ptdGlXdWUwVzRQeDU3bkZkcVZkcVk1ZHVpVkZESk5oRmYy?=
 =?utf-8?B?Z0lJZ3dHaFVEdVlQR09OMjZTTFkwYXJtbHVpNmJ2WWlaa2g5am92UHBPdDVF?=
 =?utf-8?B?dk4ySG9KVTdNVTFXNjlHQ01PQzdlLzgwbXJ4ZFNQdWZHZ0QxSkZMZ21yNGJT?=
 =?utf-8?B?Qk5pemVHSXV1NFhLOXdOSm4yME1jb2d2VTYyYU5ON05NTDMxQVZlcjBodlJU?=
 =?utf-8?B?MXc4K2QwcVViQXZyaGkvcXg2dEFJcEEwMVY1eWo2QUx5K2ppTlpmT3hFUnNS?=
 =?utf-8?B?NjB2UUgxdmNLYklDYTFSTVluUHBUdlBqUllEZytJRlZ6YnZMeHFqa08yRlo1?=
 =?utf-8?B?cVdBSkZueEZLKytyT2xJWkd5d0xUZzdOd2lBSXgxZFBrSWxrVk9FMHd0VFQ2?=
 =?utf-8?B?SjRuL1FJZTdTeGNiM01VeVJKVjBYQjF4blljZXdCd2dxTW9jUGhTbVlaTnll?=
 =?utf-8?B?RVJyUzQzY29QQ2ptZTAzUzk2cHBGMXNmcE9UdzFNMjhmenhyNUxCVnczNnFZ?=
 =?utf-8?B?UDBTS2NtT1lOT2VxM2N4a0t3SFovZkl6UTdubzgrTGpiRGQwWWpPcjBDaFN2?=
 =?utf-8?B?enFTWG11eStsR2pMVXdYTmNwbDhxT0JDOXdsdzNVVEFOekFxcGZIbCtOMTdQ?=
 =?utf-8?B?RnQ0N3hwUmw0Vm1vVjNyaXBzeTIraFcrNGVBWDV6TlNpdEpjbGthV3daMWZD?=
 =?utf-8?B?eE5FNTRNOVNrNXNjdDVHRW5kY2JGRGlXSGx4Uk9GSTFCbi9VNWVMaHJkWk5u?=
 =?utf-8?B?U3k2c3VKL3FER0w0U2dxR0JjNDdDTFUyd0hkWTVyS292cE14eHFnMTVtVHR2?=
 =?utf-8?B?UUpTc3JvSHdOOG9sZzkrcUZGSHFoTGtJbGU2VUdhWTFrQm1MWmR4Wm5YSmJi?=
 =?utf-8?B?a1VCOVNaWWRXTHFuWnREMThucnZyWERnLzRFQ3FmaGlybFQwa092TVNhVEI0?=
 =?utf-8?B?Ni80RXBkcHpuV3pGTmx3cGxrRTFaVXFvN2plVlpoVDU1SHpVcWplMUQrNXpU?=
 =?utf-8?B?YitjT1V2MjdQRE9VZ29TMDFFYitTL1RXYVlvYW1YWFZ2a0JaUjBUMkFMM2VN?=
 =?utf-8?B?RzZ3UUYvSzNPQ2lscUNFMnphaTZGa29YcnpFTkpuaEREa3ZhcVpQM2JUbFFu?=
 =?utf-8?B?RHJuNlhMSCtOT0o4b1NScnZRMXk0Zm5PSmpMZ0t2RVAwU3ZLYWVjTkcrL1ph?=
 =?utf-8?B?T1lhZDdkUXQyaFBzK0NnZXZJRDJEeWJtL0VNa203VFN3a0pxalBvaWxYaUEy?=
 =?utf-8?B?Q3VNS2lwWEtPR1pXWm42d01oL083UUYvMEFnWm9WS05ZR1FIeUVlaEt4QWVz?=
 =?utf-8?Q?xF0ToxgSG00LJ25dQKiwLdGIj?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Zda9e0zXrT7JhN9RVkEePu0CW7Ipp1ABigtmDqst55yppqzn5gkzY8UPkv/4TG9Cf8knNxwtG6zYZwf3erc9xciq4Yv8ugaFR0suXQLCAiDmWmdG8+tLI7C8y9uHMvUtkfrJSBH84KMiQQ2ccfiTF49oui0yw7JtflcB9wEMnPLkB7MO83xphB3DjRnLSgN3CWd1KjDsERPYcI9szifRxGPyfATZpAw6aUSQ10JmoKgd3DOJdoGCJMKjW9f3Gm4mbYZi/zQJ19Kze2Jp5CKavNopmkJgRbjN/axYRnCMk5Zn7bOfFzRZPGmGtwDS2NpDbSMLCVJNBPHDINXLDcCnxNSPF5/EgW910FP72d2G/NgnD1dA1RPeMgLPwL0YDbHsRxx96h/l03tP+DxrzNY/PVTbEOtWC4PpAw56XSNGyHtFkc0/o7vkZeCSnL7lJ/+kbI4QjU2N2o0yFr4sMggXFlCzyz1j9eALateqBQ7jAaiW+Pl/big7JPM0Akejm1ZrEb0mDXQ7TazuEBSGnxTAVuW4d+QG5CnhmXAEbPS7QtYiDk33mSt78t8K6iP8nZz4ZfH/cipU9Ud1nnOQ067ZiHENcZyNLUrRJcidEJjRr0Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1530d6e3-1657-4f95-fd40-08dd92048f6d
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8710.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 09:57:24.4020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MuzhPQ9gJoS/ks7MFC7lvSu7Umw9UoUZTPU0iDkfgrBitHofthYc4U2bkj8k0AwvKrWA53zhdUjnP5onMuWIlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4961
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_07,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 bulkscore=0 adultscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505130094
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDA5NCBTYWx0ZWRfX4FKpQOCVvbXe 3K0657SMo51/9TxxdaZfBoZ/ypnUmmXG0NgXwokN9Moaxd73PTeT0FLcjGAwUTqAHUin8VKkLjd 2l52wg+/KMmTw2+wP76/ma2a9r+C7wbQLrrOtN5BH+N4lUfmHXtEx8ZVlw/B7CTZ+KeTR6sL1Nt
 PZygJep5PMjDSUY2tjlIfbW0GvtIcwXC9PLQM179As3jLGO6OfgSwnPS932NiMgkrZoX25BgG5t vOTT6LBvgpQjxOTL+sVUcPx9vB1kfZy97DY3YP0JmYgWQV5qlJWFNhak8YSYuj2RX+Gz4kvvAVZ PKQOPVVSP8+xmKVnF95OxaGpkFdYqHskgaS5LusjYZrUOCYNxvEIszncBiVN5n09Wm3gsKcy5oZ
 w4qwlPIKgS3YtCcaOG4ymi4wjEgpxMlIxiS2v7cE6u8zqtd9iaaacJ8K5aki9tZIDyYnOJTm
X-Authority-Analysis: v=2.4 cv=DO6P4zNb c=1 sm=1 tr=0 ts=68231789 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=iox4zFpeAAAA:8 a=crbpY0kx44Izy5Ded4QA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=WzC6qhA0u3u7Ye7llzcV:22 cc=ntf awl=host:14694
X-Proofpoint-ORIG-GUID: 1YXYIgEL3UoNeLUfC9xeR0Rb1Qt1eIRm
X-Proofpoint-GUID: 1YXYIgEL3UoNeLUfC9xeR0Rb1Qt1eIRm



On 13/5/25 16:57, Qu Wenruo wrote:
> 
> 
> 在 2025/5/13 18:24, Anand Jain 写道:
>> On 12/5/25 15:54, Filipe Manana wrote:
>>> On Mon, May 12, 2025 at 8:51 AM Qu Wenruo <wqu@suse.com> wrote:
>>>>
>>>>
>>>>
>>>> 在 2025/5/12 17:14, Filipe Manana 写道:
>>>>> On Mon, May 12, 2025 at 6:26 AM Qu Wenruo <wqu@suse.com> wrote:
>>>>>>
>>>>>> There is a kernel bug report that scrub will trigger a NULL pointer
>>>>>> dereference when rescue=idatacsums mount option is provided.
>>>>>>
>>>>>> Add a test case for such situation, to verify kernel can gracefully
>>>>>> reject scrub when  there is no csum tree.
>>>>>>
>>>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>>>> ---
>>>>>>    tests/btrfs/336     | 32 ++++++++++++++++++++++++++++++++
>>>>>>    tests/btrfs/336.out |  2 ++
>>>>>>    2 files changed, 34 insertions(+)
>>>>>>    create mode 100755 tests/btrfs/336
>>>>>>    create mode 100644 tests/btrfs/336.out
>>>>>>
>>>>>> diff --git a/tests/btrfs/336 b/tests/btrfs/336
>>>>>> new file mode 100755
>>>>>> index 00000000..f76a8e21
>>>>>> --- /dev/null
>>>>>> +++ b/tests/btrfs/336
>>>>>> @@ -0,0 +1,32 @@
>>>>>> +#! /bin/bash
>>>>>> +# SPDX-License-Identifier: GPL-2.0
>>>>>> +# Copyright (C) 2025 SUSE Linux Products GmbH. All Rights Reserved.
>>>>>> +#
>>>>>> +# FS QA Test 336
>>>>>> +#
>>>>>> +# Make sure read-only scrub won't cause NULL pointer dereference 
>>>>>> with
>>>>>> +# rescue=idatacsums mount option
>>>>>> +#
>>>>>> +. ./common/preamble
>>>>>> +_begin_fstest auto scrub quick
>>>>>> +
>>>>>> +_fixed_by_kernel_commit 6aecd91a5c5b \
>>>>>> +       "btrfs: avoid NULL pointer dereference if no valid extent 
>>>>>> tree"
>>>>>> +
>>>>>> +_require_scratch
>>>>>> +_scratch_mkfs >> $seqres.full
>>>>>> +
>>>>>> +_try_scratch_mount "-o ro,rescue=ignoredatacsums" > /dev/null 
>>>>>> 2>&1 ||
>>>>>> +       _notrun "rescue=ignoredatacsums mount option not supported"
>>>>>> +
>>>>>> +# For unpatched kernel this will cause NULL pointer dereference 
>>>>>> and crash the kernel.
>>>>>> +# For patched kernel scrub will be gracefully rejected.
>>>>>> +$BTRFS_UTIL_PROG scrub start -Br $SCRATCH_MNT >> $seqres.full 2>&1
>>>>>
>>>>> If the scrub is supposed to fail, as the comment says, then we should
>>>>> check that it fails.
>>>>> Right now we're ignoring whether it succeeds or fails.
>>>>
>>>> Currently it indeed fails for patched kernel, but I'm not sure if it
>>>> will keep so in the future.
>>>>
>>>> E.g. we can still properly scrub metadata chunks, and for data 
>>>> chunks we
>>>> may even delayed the csum tree lookup so that if we got an empty data
>>>> block group, we just do an early exit.
>>>>
>>>> Or should I do the failure check, and update the test case when the
>>>> kernel behavior changes in the future?
>>>

>>> It should check the current expected behaviour, and if that changes
>>> one day, then update it.
>>>
>>> I always find it terribly confusing when something is called and we
>>> ignore its stdout/stderr and exit status - it makes one wonder why the
>>> command is being called, if the author forgot about checking what's
>>> supposed to happen.



>>
>> Makes sense.
>>
>> As there is no way to check if the kernel has commit fix 6aecd91a5c5b
>> testcase will crash the system. That's a bit concerning.
> 
> In that case you can add the test case to dangerous group at merge time.
> 

Oh, right — we can use dangerous.

I thought you were still sending v2 with Filipe's review comments?


