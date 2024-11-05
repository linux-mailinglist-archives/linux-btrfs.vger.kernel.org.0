Return-Path: <linux-btrfs+bounces-9341-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D876B9BD6E2
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Nov 2024 21:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98E2B283D93
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Nov 2024 20:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C68F214410;
	Tue,  5 Nov 2024 20:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Fhj7Yzaa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hpF8OAXG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CF01E909B;
	Tue,  5 Nov 2024 20:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730838050; cv=fail; b=XiHIWl4CJXnhiVv53D65/vfcCTyB85Ybxf21YVPoDt6+dkwiv2jeLNsUlS1nIKbbnoaBrCq6elxKfun92DIh2OimNQZkDD4Vj9YxZSv0McRmnAA9ului0YN4cWq2iblKzCFyzV2AMStsWLhdr+9Uzh9x0yK1209t2FhYfNJyokY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730838050; c=relaxed/simple;
	bh=3v4daQFDWMSfmYi/Mqu4U/KPLFcw/XXDreQN0FPDV40=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Rw2GkT+vFDpg/yf22Kyqgbb7IXArMozuJgwQ8kXEf73DWVZoy/ohdTeViBRGQSiZy92rIz1TAJ26Tzfkaq6BGJrcX/0WuT9UF0bB+MpicALgNSL4GZ1VB9EwgYtABcKmTE0U4vNOIkGjWYqLYHG2FbISjPjP3qGyCcPi4NUfKbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Fhj7Yzaa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hpF8OAXG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A5JAxTA030962;
	Tue, 5 Nov 2024 20:20:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=7EEsJP62ojdfK9j9bZKsIK9dtD7qyIhs9SFCj0/gBD0=; b=
	Fhj7YzaatO81iJ/XR4khp5gmy0iYLO6Vj+ElLPPtKIHQrWNvLwsmdiAO+19WOj8q
	OFo2mun2BRHkmmRPhJArnITl6lTa41i7968awDlFChkxWbYeEf/gav5MkfRcBTdR
	D/QqMm6u4jrAv0sbNl/xTj3NHWeaWa3rRpoRgEGKRbtttfflYSujxQU91RS3Znyr
	J8yXrt1bV7elLnDb2ly7JUelsva4xVkGVLXSdA7clr0asjSAXkHsQW7NK1S0QkVP
	3DOpYZhyJXwtn/YrMgdyrBqSd/K9Kc2zsrsEcyMW3Eclotd5PdBUroTV50g4/IHW
	/q7aec2HyNUq0k2hEKx2MQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42nbpspbpk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Nov 2024 20:20:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A5KESjx004991;
	Tue, 5 Nov 2024 20:20:43 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42p87b1x94-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Nov 2024 20:20:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KzvTqHjG8QytizTzTGnEcGY1csZOjW2SdbByWopPi74IcPxOk+QDxaGWvSRUr35Da8v05BpyRURwMxTaibwr9wOQ9sIBL8VDUolTdj3jyMAfQrnrDrRRa1IZXoMmn+9ZIBN38ggD3l0ZlhzMXhYHWLtWk0ivR4fzyVIQ2MsPTo11GQpn2fOJmL1tuE0XPy2rc8rOxe/xAp2GiOM2zlD2Qr5gODaXcLn0PF1gsrVJRUDlqD0H1k5TJl5/CimD8IsIhJBoDThqKN45cXL41avPMshXoIocNNfupimNamxHtKqROPe6PgqDE8b0DwcFAGBq3stCnGlJD40IWqnNt9ERFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7EEsJP62ojdfK9j9bZKsIK9dtD7qyIhs9SFCj0/gBD0=;
 b=GNjwdPvbEkNU7FU6rWg7J6uLf8iW8/eX6/NlohMy92ZtiTpp3CeqZninugs9+SGclgkVYAQ6P5HjJT0cs79LlFTZGpmZjiZrZiLtCjLkHLrXk+GMOcL0lYJfBJQAUeLMlEkGH7QzwRDi+oIjo/F7a42nmbEGUMKEszCr76yNkIRCGc0vvHISK1BUqLztnqCY8+XzbAloPrR5o2lmvBlnkccp3P7o2f6cdSRekayCmwsTg51LDD/GMw5Kmy73QgLJpmchJFE2pcNZZtOnyKwW9t3DldB45h1G1yPsn7cTjJBcwqIzYztZ/ftBVl1GyND15zS/FVjpjzd0QI4vwVFN1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7EEsJP62ojdfK9j9bZKsIK9dtD7qyIhs9SFCj0/gBD0=;
 b=hpF8OAXG1MPacrCnkKDl93/BCa6PQ8rCu044Xv+EHrHssmnCqIuywad8euPCHA5VCXmVXyFi6/S4819Lt/QSIa9Z0Y4hB5arWO8KMuRCbP29N514G2U9Fgk8g8KYYuXBFwGSrLaLwjLx9gSQlC1L9rXQ9UPSJ5oNKiE9ztEChZo=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by LV3PR10MB7865.namprd10.prod.outlook.com (2603:10b6:408:1b8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Tue, 5 Nov
 2024 20:20:40 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8114.028; Tue, 5 Nov 2024
 20:20:40 +0000
Message-ID: <1a128c40-1a67-42e5-b8be-823c00a931a8@oracle.com>
Date: Wed, 6 Nov 2024 04:20:35 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] btrfs: add a test for defrag of contiguous file
 extents
To: fdmanana@kernel.org, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        Qu Wenruo <wqu@suse.com>
References: <e592bcc458f5c2ec41930975003702a667c92a8e.1730220751.git.fdmanana@suse.com>
 <92697a8420a5c756acfe247352419562793a2196.1730720132.git.fdmanana@suse.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <92697a8420a5c756acfe247352419562793a2196.1730720132.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0247.apcprd06.prod.outlook.com
 (2603:1096:4:ac::31) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|LV3PR10MB7865:EE_
X-MS-Office365-Filtering-Correlation-Id: af9c0671-495b-4bda-b20e-08dcfdd750cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NnhWUEFXQWhmcVZWeDBuWXFsUnVZQVUrbmtpUVJjMUdOQjJRUkU4TE1zVDZH?=
 =?utf-8?B?T25ZQWI4TFFDY1JMT2Y4bThQZnhzYTdSN0JOUkh4NStCNFdCNGJRY29hYmM5?=
 =?utf-8?B?T3cvTXNWSnZWOUdtMHMwZGVoMzR4VGRORFlyc1RxMmc4M3JidnJwcGVVVStC?=
 =?utf-8?B?cjA4ZmRrZ1BiMFZ5ZHN5SGVCdTl1UVk4ZmtORWNTRzA4bWVHU244eWJOSHBV?=
 =?utf-8?B?T0dPdEpQaGcydGNici9aamJyNVZCZ3Z3UXl0M1NRTzYzQ0FoV0c2WXlRY0RC?=
 =?utf-8?B?N1c0N0YyczdLNCtsQTBPQVk0amRMNTQwQXZMTXlOdExvMkJYdW1Zb2FGNEpq?=
 =?utf-8?B?T010ZzJSRWFPYXBtZjNoMXh0UDlDcVg2Lzg2dXJMNy9PRXZWdjA1ZVJzcUJZ?=
 =?utf-8?B?a1o0bWRFcFdybVdoeXpwSFpNYlI4eXU2UzZsRnZKZEhpY1J5cU5TeS81VVJi?=
 =?utf-8?B?cWVQQUd4am9qeDR2c1QyRlNBa3Y3RU1qUzZkYk1xYlVVSHc4S3JoUjk1OUlt?=
 =?utf-8?B?QmNSRXNSYWxSL09Wa1E2bFRFc0xsUGtnckRhU2lpSXlkT2UyVFhTSDczWDFY?=
 =?utf-8?B?L0JZVy83T3FTaUpZMVVvMFAwTGVuWGdjOFlFSTR1YmY0RHdKUGxQZisrUmZs?=
 =?utf-8?B?U0dGbHR3Y0pFM1pCRGw3M2RyUllhcHQvR0NNbDlYNXJLaC9TWWx6YmFROWZH?=
 =?utf-8?B?NXRmRFZQcEswWDBUZm80eUFkcWVtUzlka2MydXRwckU0eEovM1hYRGxIN0lt?=
 =?utf-8?B?blBOSmV5TEIrclJXWkFOUCt4U2JzdzZUaE1jcG1mTDBCdWtrQ3NWZ3hVZlgr?=
 =?utf-8?B?VmxUajZvY28wV2FDTVZYWnNiY2tHei9paE4vZEkyUnlqdjYrV01FdHE3MURs?=
 =?utf-8?B?alVyTjJXNWd2WUdaQUwyanNKa3BJQWx2TldidHp6dmtNQWhjb2ZuNGJpcVZK?=
 =?utf-8?B?cEpNMHRYalJoUDZPcmJ0RlF5S2JzSGN3MFluSkZMOTBwWmU3RllaT1NjbHdp?=
 =?utf-8?B?ck9HY0RSR1NGVVlPcDVEQ1gvRmd1ay84ZE5EeXk5djR4Y0xJSmxrOXI2RUlN?=
 =?utf-8?B?OHJLeTlVbEpjR3JWRlFkMjNmNjhMa3VZRzNrSUZ1eW43Z1pWc3huSi9xYTJL?=
 =?utf-8?B?VU9FdEsvNUxMN2FkNmp6NU1uT3BVS0RvVHFHOHBmbkU3S3ZiNUx3MnhWVUFX?=
 =?utf-8?B?eTN6MzhZbVRMaHNHQ3oyeHRPRTQrZllQb0RvOWF3SnY1T01BRytLRm0rV1JD?=
 =?utf-8?B?YnJVR29QakhHSzJtdDc0aWlSUzFvT3FnWjFQUlRjck9SRGdOTys4MDJBbUtI?=
 =?utf-8?B?eDE2ak80L1pTb0hhbEpUYko5UlNyY1I1SmNrL0VLdXJaNzlLbHJqY3hPNTRQ?=
 =?utf-8?B?bHZaNTZsaTBTNkhib3lWNlV1d1NiakpCYk84MFJGTG1GTUFrT0RUOWg4RFFW?=
 =?utf-8?B?dVo1VjF1Nk96d2lYZFYzTHk5UkdWVGdLTlp1ejg1UFR5ODduNGE0Z2s3RDBW?=
 =?utf-8?B?TTdueFhHN1FlblNHTnhHVFpQTStGZ3pTMGJsV2xTK2p1L3JPa0xYK3h6dFZs?=
 =?utf-8?B?dURlam9Ydm5XOURSdUpOWFpnY3pNSzg4RnRmVXE5eVJHZmlNRzRkMTUyMnNz?=
 =?utf-8?B?Q2N0T0ZYdmczcUN3dno3WVhXcDBOcTZ2Z1o4c05DKzZ6VFhmb2dIMW01Tng1?=
 =?utf-8?B?UGZscTlJb25CYUx3dVdqcFhOeU8yRnBvQmt2bDVza0tjSnZ0azdyNktPTEdF?=
 =?utf-8?Q?608hjVIjR+tkvONUhUfaNIpviRTgQdKUw8hwBgO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VjVUcDhaa2tKOXg2ZXFaRHc1cmRuSnlQWUhhaU9BYk9td05OOWRNWmhiZlNO?=
 =?utf-8?B?YkNPTzNPZzZYZ1NHN245KzdheGpZVC9LSkx4aUlDSzVNd0RibnFIbHJIUnVu?=
 =?utf-8?B?K1hENExMbk9zQWZyM3d2ZXRDbXFhU0krVnB1SGt2cUpuU09DOTlVTG02TE1z?=
 =?utf-8?B?NTFkWDBVTmtEMFpyNGcrOVpSOVp4Z2lOUDE0MittSFAzMFE0VmJqQXhpQ0JN?=
 =?utf-8?B?TWEyaklWZVdzaHl0Y2N0T3YyKytsNm0vQWRlZ3E0MXFvSWFBMi8rOTJ1OTJC?=
 =?utf-8?B?TEVWYXR4amJ6RkZQRkw3MWFrOVAxeDFHa2dMVWlvMDdBb25vVFc4aEJvM1Mx?=
 =?utf-8?B?WDMrZnVxSG9la2RjOUhSRUVyNXdoOGNWaVR3RGJMdmZJSEtUREwwUjZqWGxv?=
 =?utf-8?B?blQzQlVlNkI1UzdRQlNNRkFNeU9LUEdxT2F6enVFZEJhaG4yZVdKeGZjQkg1?=
 =?utf-8?B?dUZKSUFzUnJ3Z0NnaGJFSGptczdBMHp0aERaQmhtb2l4YmVwMWJvZ2tPUDFz?=
 =?utf-8?B?SXBvZnEzZnhLOWRWQXI0L005M1ZJdHBUSzN4OUZSK2JuY0NHQWg2Q2xMQmQ3?=
 =?utf-8?B?Ukoxcy9QKzJaMlVIcmJ4bTg2WGpUY3lWaFYzWmdsOS9HL0lPbjZYZmJsS0hj?=
 =?utf-8?B?ZHE0WHF3cVlRbkdhY1ZjV1B5bEkyNXY1SENEZDJkazkxcGIyWGZDK3pHNE80?=
 =?utf-8?B?ZFJyTzNGc21USXV5SU8vR3liK3grMFVaNDgyMU1LR01YK0NGSmVyMlRicjFJ?=
 =?utf-8?B?LzBaS3dKbERaOEN2WlA0b0o3ekl2TXRGa0Z2S2xOZ2NwNEg4VDJ4TUVMSFJR?=
 =?utf-8?B?RXVUS3NaNDJ4VHNrVkJsYUkrMWlWZlJ6c1UzOVdJQ0lLa1Q2K0VIR0NYb1Ja?=
 =?utf-8?B?OHVHM1VtK3cwMVFGUEYxWmlMb2JPQXoyUXhXaUw2TkFtOVRKeEtNUVBRNWxO?=
 =?utf-8?B?eEs5eFkvY0lqcFQySXVXeTQ1QjRFOEpHYmh4alVzNzZkVCtDVmx1Ni91SGFL?=
 =?utf-8?B?Z1c5UUFVUXl5V1RJeng1Rk9UVytYSllQQ1lONzVFVEs0N3piZk9Rc0ZPRXJT?=
 =?utf-8?B?TEl3eml0RGJQb0FFMzVBUnM0bnVYNm9YWjAybHl0bGVFOEhJTWRkM0wyTGNM?=
 =?utf-8?B?YVpMTWNSL1U3R1A4OWl1M2pQV3FIcURqRFFPM1NuUU5rUFh3SFI1QkplWFJt?=
 =?utf-8?B?Z0VWWjM2QlprL1BDenlxVHJOM29qUEE5S2hZYno1L1B3RU5xR0c1TjllYUJn?=
 =?utf-8?B?UjNiMFg5MGQvWUQwWnlpdWUxdGJhemw0aEJ6dFJqYmtJRUhMc0dkZmE2azdN?=
 =?utf-8?B?b1lER0x6NmUxMUpaQlZER3JUUksrY0RYUU8rbWZLV2tNMXozR051TDBMSGxJ?=
 =?utf-8?B?OGdVRXFTSlFHNUowMVZtcDBhTXBLTlpVTW5ybm83NUY1MFc1cUFxR2hicG1u?=
 =?utf-8?B?OWJZamEyaHgxeHRNbUk1anJSSlRmMnFqRkpVcnV3TTd5RldacjArM0VPQ1pZ?=
 =?utf-8?B?cXFiVkozUm8vaEFXLzFhRjZmMG5FRlgyQ2w4TTFDSzVNYWJBaE9MTFo4bVYx?=
 =?utf-8?B?MmhDU21SZkNETXZOd1FaNm83RVRSZkFEV2hYbUZINENPQjg0dXYxa3prTGVa?=
 =?utf-8?B?TytUdUZMRWlNYzdodTlIbWpHcWFYamdtTkkwWU9YTEJvenhWdTRrQ3pFMmpC?=
 =?utf-8?B?b05ETHg5VXlXeUVmeUN6U2dRNWo1RGtsOUNtUjJKOE9EM1V0ZnVIcysybHJI?=
 =?utf-8?B?b1dvUmQwTzlMRW10djFXVzNrTUZqZ3h3eWwvczJlVjZaSnhxK2lvM3YwQWNv?=
 =?utf-8?B?WVZLRURFOTBKSTFzZEVMTXhRbmYrY2x6d2VtL2xyR21xUzFqT0hEWUVmVDYx?=
 =?utf-8?B?K1JzTUFPb3BEZTl2d1NVTngxTEo0azFObzllT244V0RZaUdteFltTGd5UkhL?=
 =?utf-8?B?dlJFeDRadHhrRUFZakxhNUk0RUNpaFJleTFXY0lpRklvUm84VmRFQ2tCN2ZZ?=
 =?utf-8?B?V2FSaFNNdnhKaTRtNnNaWk4wY09hQ0psMmduN1V5L0NYL2xxRzZoN0pRSGRG?=
 =?utf-8?B?WkxqWDlBUnI4eDRJSHNpT1htTUJQKzNFK2JuWEJ6R3M2UXpRSkJLL3FpZHZL?=
 =?utf-8?Q?nFQ1ap7icnDkiUWNmHJGTNRDf?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LHZePkJvzipr+oe5UNkFfAOUAW2DO5IYIZ2pZC0yZ2+AyDZwRHqa4VC1/8r+qMr+duh8A7h0xR0owvej5u2UXK2cT+qIUry+PggONBrFmtNkhihsuLiNHpBLFAx1rOgx12ppBOL2R/OwkmdcOr8fIIrdqDuyPEHyS9uhuIWUl3vluW4OeyUCVXiXS4dzL9PkHE7bo56TbpD646fvto9hBxNGoA/ot4oXe6xhbaBFcTFDOaANkWLAhYPdSlzldzXSQcsxROPJFIf+UouqGc56FlHINs+kebhiTt+QC94dTR8ZzEylz1r5oSYiBUz7VU4Vp12oxNC+eBlvhYwIUsK5qrkumtpcjyKNLG95NuwB4fPgp+gXTVIq9vLWxl3pez7cok4LQhPLVFDFo2is0QKH6aPYbl51cQldOvWVeZ5zNfy2uNWEF7KvfF5xOFJV6jW/DXbI4Xq9h3kM2XgmbD5duQuKhVVK5TLmCtphqhqZWZiypsaKWGYucYQBsGQJ2m9XPgJTXZGSZA/1v0a1QxRI2DwmtAiTzGO+ofOdSlWfEpTNztg5G9SEmEQoKZp6/hwUnSm+pblQ3XF3FniCDTH68/+eqrY/ZFPqmEZmajxN/Kc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af9c0671-495b-4bda-b20e-08dcfdd750cb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 20:20:39.9809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wV/jFyNfzudhDU6/tzkp8Gca9QwsRKx+sOBXDHCcgwPRaXumHSrefSoeU8Afm4EmMbDxIyYNDIvW16sb13Q1vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7865
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-05_06,2024-11-05_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411050157
X-Proofpoint-ORIG-GUID: jDaGjnmx4zA5AaGLrPfO9wCzSQzq2VJl
X-Proofpoint-GUID: jDaGjnmx4zA5AaGLrPfO9wCzSQzq2VJl

On 4/11/24 19:41, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Test that defrag merges adjacent extents that are contiguous.
> This exercises a regression fixed by a patchset for the kernel that is
> comprissed of the following patches:
> 
>    btrfs: fix extent map merging not happening for adjacent extents
>    btrfs: fix defrag not merging contiguous extents due to merged extent maps
> 
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>


Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thx, Anand

