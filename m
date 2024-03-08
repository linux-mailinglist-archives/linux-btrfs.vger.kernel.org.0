Return-Path: <linux-btrfs+bounces-3101-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD161876570
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 14:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E9E7B23D16
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 13:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F354538389;
	Fri,  8 Mar 2024 13:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I2wrPGfk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ljVoFKTo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EB72CCDF;
	Fri,  8 Mar 2024 13:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709904943; cv=fail; b=XEIDzK4QhB10PJaWFHOExyfR0+7uLuEsAQqTsKfU4S8/8aKhps0jU7xSU1pBUD4iYm6JLg4Yf1lyzvxBV0w89Iwu17d3PQ07x7T+NorDxtbN6N7uqcOLXeth5kBYMpzE8YYCDQYSwRuq8G5L6RZtLjpbvdDrpzXufdCmyXAwLRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709904943; c=relaxed/simple;
	bh=9q+BZzOUyt+Ddr7T+SbgCUq3FG6T7pqKREq1+pPIAMw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=l5dhSr7tPC9xopGY+t9twYKlj/LC6AjrgtsHGMQBR4qIssKJ3/E5gxLjUDwGLg77xe0QEIfcEuraopM8InZcIFkCOT4ZPtIXT9fHR1bqchnFMxjgOAYKnefktcCvKLQefLJazlJu2U+Dkrm5uOz/52/Bp72A7hz/syNYFb9dWgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=I2wrPGfk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ljVoFKTo; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 428DT9hq023058;
	Fri, 8 Mar 2024 13:35:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=ZWWhfoG7Sgt/fF1Lsqs3EqIV7V4SRAGPfHPkCbBzeSU=;
 b=I2wrPGfkegr+VN/aygRkCBitfFwP/RQ/SSUnH6FZi/NWi6x524ZPJ7ywlDemzCTsM6h/
 V5V90Ps0ds7qByzuU1wyIRs1jK7io+WOzdXyRHvbn4BfRrUfVTbeoAkU+RUSjr1QWWr9
 ywoDPKddJM/9JhDg1ggK8XXUV4WqrKiWOhvaSA4FxMYr1q4a5McW7Tw0miJoWYhmUScn
 b9MqRI96SkHqMR5aCNiaeOz45XYO1VLk6YhnTLIK5k0NTuT5A9YjZXP0fNU7gU/Dxj3L
 AwJ0XOJOKTneltot/zhkn87zAD4mBh8mRM/qQPZaQzcJqRhWBVMGkuCHjHqdHZXW2AH5 sA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wktw4esqp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Mar 2024 13:35:22 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 428DPJKq031823;
	Fri, 8 Mar 2024 13:35:21 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wktjcs27b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Mar 2024 13:35:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b4ROXmoSyD3YmY7XClO3Fo/uRSnMzp2iERzd08DWtE/qfIZGBPDrX+8UZvqueA52isTiRY7kf9CHTkpOuKHaORYa/mvjHueiBa6V7BzQIgNWb7s9E66pVJ+UxE9Yk0INawZFU3fE/WsFBQb1EBdJRQyk19aKIsVmZtZx4uN585oOhqgrC5g/X0nyCvX3joYoWiBzxHWXpXShoZkt37HxosrRo3a98fROZxzXUSWO0Xa5C3SyLwviHIq6R7/brTGt7L6hb8kmhxDfdUS1VwKMYrfwLCCMajs1x5BXxWL5v+R3PAFk/s3lO/WzslWeOgG6W5Jei1VtMcJ/NXGuZXqbPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZWWhfoG7Sgt/fF1Lsqs3EqIV7V4SRAGPfHPkCbBzeSU=;
 b=aGCba6lOCaBRW4kj5aOqfqwjTLvOu+VNpfgJ8VBW9XVeBthbb9aGQd8MkMhNiNTczlp9HaVa+CHtXg8ttlTp/6pSJYIrlo+Zhh3xI2LfqF05nAvo8d1xDk+Z3gaCb5yZfF01pf8kb+kTH/E93biA+qGFkZABQRYSphlVLkAzR40uAHcVl1rAdwThEyQJieNCzSrZilUTx6BenvjJPucWLAzK6b/RSpoP12DM40xd3ldmqbmNn5AiCJZ3FRVeCWHGvxq+44r/ZpUDemCi1WpBmW7hLDj0Bks23A5s4ld41ZmOIiHQi+ISOQAHxGpetuE26DDIN5PCTPpWWEyuX4DtKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZWWhfoG7Sgt/fF1Lsqs3EqIV7V4SRAGPfHPkCbBzeSU=;
 b=ljVoFKTowdMgFaWWUUI82FMpgDnLZiJIB+a9DSgOK9hr+wJSLdEbjCUy52yeJd+AURsnNqE887LmCsA/8RcwuSyaVlLkTPSLayf7g4Na/i64cEj4eCdIgWI/RF0M3wgNNtLQATyAuCC5LyHYiHuzWN+t26cc8EHgccyIsoht2gc=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH0PR10MB4860.namprd10.prod.outlook.com (2603:10b6:610:db::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.31; Fri, 8 Mar
 2024 13:35:19 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 13:35:19 +0000
Message-ID: <290e74fe-d199-4c8c-bf02-f7003232dad9@oracle.com>
Date: Fri, 8 Mar 2024 19:05:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] btrfs: test mount fails on physical device with
 configured dm volume
Content-Language: en-US
To: Filipe Manana <fdmanana@kernel.org>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1709806478.git.anand.jain@oracle.com>
 <c68878cb99025b8c8465221205d5de9e40777b18.1709806478.git.anand.jain@oracle.com>
 <CAL3q7H5NgJ3hpFFk8GcESX0n61=r_J7=daAbDqZjpEHek=2djA@mail.gmail.com>
 <5c4ca62b-a448-42bf-a196-6365af832889@oracle.com>
 <CAL3q7H4HV-UBd9hEKB1+isH2H4TThsx0DnvfYxsY+=BB64PqqA@mail.gmail.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <CAL3q7H4HV-UBd9hEKB1+isH2H4TThsx0DnvfYxsY+=BB64PqqA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0053.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::8) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH0PR10MB4860:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d99e609-fbd2-45a9-9834-08dc3f74987b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	RB6Ze2Yje/2/W0d8Gf/lMqBiFCs69ZNLHt9UNR81Ks9bjbZegoH5fwIBRzxTFv+X/5iVY/WmOOCZm1tQoKDoa9sHPPpPisl+jl7aE6RVd3rBbFYKc/F0RbAVG4e/UEByFXoK0sjf+8NnvS35r7yC8gxJbb6Ak8uw6Y4tQa89eF/83MIOzRXxev/HED2tJ8E3nVs0/nGktRbir6CF4kCWrZe8CzylH6GxdjfRouZQxsgS5Q60ctOPHZveAdF6HppTeBxirODw+oHqbAkcgQlkR/BeWU03EPWDmZo0hCoUplvCBc7kHxEf54HEejNH56yuHOmKbeL/SMtvEnJIQfkxnL/HsZL3NWGxY3j3/qpBMTfXbWdVQ3gTXnKAmTtHfCFF1W0tHyc7/s89wVnSqtI/BLKgq9n7doUsJ00TBs7ut6HKOf3x7kcSKkz4hYk0BlLcHFubPrp7Ju9WIFfF+ok8xcv//8IYwMHuC+ArlbE+fVVXBAJn9KnSC/+HkrfHZ6NecCzWc8G8sQfREZxMTYVmFR5flFWxl0iK95FN8e8c1amkeLDvgTS76IX+OfL+yg4cWdshoG7bq6SegzEkQyF29LbnmauK5n0anU8dFlEvYYE=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UnRQL3ZIenN5b2ppTWhtTklLYmNPRmdCZ1lHV1dJQ3IrY3Uwa21NMWlqcVhD?=
 =?utf-8?B?bWdReDVtZWVyYXpVc0p4VCtkZTF2YndvMTNWUldxWUxRY05TU3VGb3ZiYjZu?=
 =?utf-8?B?cjFmM0s1SFJlODhGRnRROEMxcDlSR25VM0J2K0RIN0E2T2dYeHFRZFdSakZM?=
 =?utf-8?B?K3YwZGV6MUttcTFxTlVaOXZ1R05hRG5teHlhR3VjenFhRlFvVURLaExMN0E4?=
 =?utf-8?B?d1BiT0ZFd3R0dGZlUTZZT25CSVRrZnZiZUdEaFFGOWxNQmdUWkpNWkxqclRK?=
 =?utf-8?B?UkdldVFQbVU1UWxMMGlVT1kyRkR3YjJDalM1RFZuMHRTTm1aVlNVeDU1N3p2?=
 =?utf-8?B?dHRxV3hOKzdSMTlVTTRhaGlTcmYxdEk3cDljQThCNVJxQ1F5dHVLMlEySHJD?=
 =?utf-8?B?b2JqcExwMWpwNGVJY29hanExTm8wQmtHUDNSbEVTTFRxNVJxT0F6eVFvVnln?=
 =?utf-8?B?L1k4ZS9WdjA1S3RCWXdBMGlpK0g5ZmFwcithWFNxTnArbitTT0FMcXA3UkhB?=
 =?utf-8?B?ZTBMOHJzckV3OGJkYWlYdWpjSEVpK08vQkpvb290MUpQbUQyTG81MExlcEV0?=
 =?utf-8?B?MDVoRE9rVWovWmlmN2E3QkF6WVJqSzFFbUNWQlRaTTB0Vit3QVM4V25LMEN2?=
 =?utf-8?B?UWxDZTVGbVFBTHF0bzBId2hoWENFM0pMbUJCdDNsM0w3bFp1aVRkNTVQYU11?=
 =?utf-8?B?NmkydURFYmZHM0FjblhnazdXTGoxeEhYaHlKd2tHa0kvWDlQZXJHNk1PWkVi?=
 =?utf-8?B?U1J2VzVETVdTQnpHTG9TVCtOWWtaeTVka0JRMDBTZ1ZCUmlzMVlUWWEveVRy?=
 =?utf-8?B?czIzOFNMWkZ1am5URTF4cUxjbk5FbWxyRGYxd2dFNzF6SG9YK3hzQkFyOWpR?=
 =?utf-8?B?Q0E2aisrVll5U25yN0NxN01Wd2ZhUG14bXh3Zm9WeW52U0U0NVV2enVkYTgx?=
 =?utf-8?B?ZGsrMzhGZkwwYzJhZnZLNXlkY2tPSzdKa0RJRmczdysxL1NzSXU4dGc0WTEy?=
 =?utf-8?B?bXN4UXVNeGlLU2FSZE5IMmpnMUJaRzVuU1Q1YU9PcHV5b2NKYlRHQ2FXaTE1?=
 =?utf-8?B?QUFlRmJnSGg5Q0s3clpmSXF2d3ZiaTJQWmRIVUE4R2ZuenFYb2VOcDJJYkJF?=
 =?utf-8?B?MVJDUFFKalJBMy8wbkhTUThVK2J6anpkRG9aN2hOK0NtZXlxREN4Ym91NVVv?=
 =?utf-8?B?Q2FabDdkTFp6VFhWOWdlWDFKNTZnUVFhOWtQTjV3RDJ6L2tJQXFjd0l0ankw?=
 =?utf-8?B?eTVadkU1MGJ0U2Q4N0RkNkdLeU9MUE9IclduYXp4MFNNOGdVeFBaM1hwZFk0?=
 =?utf-8?B?UUtIRXA2eVhFWW1lZW9xWXQwdXJDYmQ2YUdjeTByVDBSUHZLcDJLR1hjbjZy?=
 =?utf-8?B?U0lCYUlvVnlKYlpzaklXMjBvOG1HNkxIR3V5WHFKNGpkRDVCRUlhRVNRV0hV?=
 =?utf-8?B?U1JhSFZFRHV4eDlwZ2pQeW81VUtMZ0NvelFwSDR1YlFBM3FvSWJiZXY2SXl3?=
 =?utf-8?B?QWpFek5nUHhsY3pibStHTVhOTGhhcElxd25Cbm1uZnI4Q2JsdmFHdVlWSnhW?=
 =?utf-8?B?RUtuUEQyRjRaRGdicTNmK2hQM3Zad2lXcTJWSkpGRlg1cERSUzhwa0wrVDlm?=
 =?utf-8?B?dTRyQTA5amx5OG9jL1FLREh5TlUwNnEweGtnVlRVTlhkTG9pSmtCRXUxT1FS?=
 =?utf-8?B?cjk4bGJ5a1M0Y0VVTDBxeGtyTzlyK0svUU1xUi92cERPb2RQQWNWNWY1NlFm?=
 =?utf-8?B?WEFEUkE0UEY2NzJnTFlCWm1hVzJiMjM5QXpES2JJNXo3YzNRaTJqTHd1Tkll?=
 =?utf-8?B?RVlQckJHRG1aRDZOT01BTnorMkl6a3dpQVo2M00wUEpNdmpkUDVNVitZckNx?=
 =?utf-8?B?c0hxejU2ZGZQOVVGK3YrbUJCRTBoRkVkWmY2bUJRL0VTYzdienVLekdLcUpj?=
 =?utf-8?B?eTBCcVVLUXNDZUZPbUFPVVpOeWVzNE5vZGVkc2J6QzdLMlZlZlFGUjIzazV1?=
 =?utf-8?B?dmU1YnNYRjU2NFUrNmJWZ2tudkNKYjBlWkMwdDM3dTdtSXdTczd6dEwva1p4?=
 =?utf-8?B?L1hRN3lZeEFtS21RV1Y2cVJ0aG51cjYzYmhYbzg1Z0gvSCt5TXBaVFNUS21Y?=
 =?utf-8?Q?WVQD3jZMObozODuP5S3Hasfjt?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	55CdD+JU1zNbDU57o9E8bxgev8ECACEVaRetXplQdV41NsaqYKhG9z48pWGvCkorL1juhCCQtsb1oj+cJfpBFwRsOZqrzLv4lmzgX66iBkvK4pHYhelfJi5M6BXvt6usHtil5F5mfgqw9a6XySKgvGa6FkPiodqXO6LAi0G6wSvkhQ+dQMK8WYnfBAuNnZnPPvw9h+pomsXLnZFEE6KwU6E68Ba9MRhd4NvGQt+4tRy1VJycmqHuWYPvDOsIl/ZkerrgbU+tvOgEq7WPM2YWHu+xGlazDJsWmzO8FtBO0S5FwUf7P41ueaAvgTxDZ2ZNJTUsx4q4ELiytCL40guVa1uHMGbibRBAekXRXt0BMTFoPEDtm7Zhy73Ay15zOGCtBHoT/0uNrYC+YGrDuTCEa+wXoMHG23wMnSZYPgpWAF2VfHJZABHxfwrmFM94Pyd6cUxiongRMulRvy2wn+fdPIfjXBa5UtvmC2Mju3qGFOd2qYI2GWl9Gz/XpoU/zpnoq9qKMH38PZkUOtnvkG6dI2Ve9W4imOYZOAqQ/tHcKgGyC/KXTNjOD2SCtNZOiKxXQVlshiFlWq04G9ualDwASQuwO1phMr+bq+Tsj7wWZNg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d99e609-fbd2-45a9-9834-08dc3f74987b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 13:35:18.9939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GU2vBkbc+3jMRkADbdMBoHBFXYZikZ868FPuu4dG8UA04RCxd5VsbCRsK4FbpVlu/PiIhTzB+4qrrC5/PNwDDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4860
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 spamscore=0 phishscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403080109
X-Proofpoint-ORIG-GUID: i52OkDXzFdf1FPJygKFrjbPUkjF8qTL3
X-Proofpoint-GUID: i52OkDXzFdf1FPJygKFrjbPUkjF8qTL3



On 3/8/24 18:00, Filipe Manana wrote:
> On Thu, Mar 7, 2024 at 4:46 PM Anand Jain <anand.jain@oracle.com> wrote:
>>
>>
>>> I'm also not convinced that we need this test, because the bug could
>>> be reliably reproduced by running all existing tests or just a subset
>>> of the tests as I reported there.
>>
>> This test case was motivated by btrfs/159; and recent report;
>> yep, most of the lines here are taken from btrfs/159.
> 
> Ok, so it's motivated by what I reported, triggered by btrfs/159 but
> only when other tests are run before it.
> 
>> However, I wanted a test case in the tempfsid group which
>> exercises multi-node-same-physical;
> 
> Sure. It's just that we could trigger the issue simply by running all
> existing tests, or just a subset as I reported before [1].
> It was fully deterministic and David could reproduce it after the report too.
> 
> What surprises me is that no one noticed this before and at some stage
> the faulty patch was about to be sent to Linus.
> 
>>
>> If there are no objections, I am going to add the tempfsid group to
>> btrfs/159 for now.
> 
> That is confusing, please don't.
> btrfs/159 doesn't test tempfsid, it existed for many years before the
> tempfsid feature (introduced in the 6.7 kernel),
> it just happens that it triggers the issue if other fstests are run before it.
> 
> That would also be pointless because running btrfs/159 alone doesn't
> trigger the bug, so running "./check -g tempfsid" wouldn't cause 159
> to fail.
> 
> Between that and a new test case that is somewhat redundant, I'd
> rather have the new test case with proper documentation/comments.
> 

I have converted this test case into a generic one. Now, XFS, ext4,
and Btrfs (after a patch) match the golden output. I'll be sending
the btrfs kernel patch along with it.

Thanks, Anand


> Thanks.
> 
> [1] https://lore.kernel.org/linux-btrfs/CAL3q7H5wx5rKmSzGWP7mRqaSfAY88g=35N4OBrbJB61rK0mt2w@mail.gmail.com/
> 
>>
>> Thanks, Anand

