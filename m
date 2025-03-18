Return-Path: <linux-btrfs+bounces-12366-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD5DA66E62
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Mar 2025 09:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C82918996DC
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Mar 2025 08:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC802036E4;
	Tue, 18 Mar 2025 08:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UpfnaLwh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ic1Q/mns"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60C41FFC55;
	Tue, 18 Mar 2025 08:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742286917; cv=fail; b=dt+VlbH+Dy+Iv1tThREzs7bu3K8SnMenjKZpLtpDdmzErPMIiZAKRSyyoWESFkasQ0qPniFlwkr8AAiqfObwbSvIspQEIt+fgcQ1+L7c6PCOGJEzPZtUIUo2pLM7HsXwSiNPq+P7kWedhMbp9HU/9b9ihwVH5x0epOSZrAiGUZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742286917; c=relaxed/simple;
	bh=9LI4KOk+s4BKLXzqKMq2vBx9UqvTg14iqOuPSwiOnHU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DLIKUtiZlvQ7ifQKXnrudHN+8Pb4p+jpDTz825hWhkQmpgUdXHCuUqE5ceTA32fy3HRxgTog7o5Q0WQObtXwsnVyUcIDbblDstW1UwD9SbRdFO0mS84JEoIZKotjW5oxU395V6jqkuUXRS6Fc85BcaZiOTS06bUG5YqdphyGuhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UpfnaLwh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ic1Q/mns; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52I7tkaw025102;
	Tue, 18 Mar 2025 08:34:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=NBrMnfYHBXymomZiJPrFCrqL/O2u2K0VdzHui0NCsfI=; b=
	UpfnaLwhEOaMKgVIA/SMAwSHvqVo3TY7RghRfqvJVAsJQAHFJ9Hd512mexibsuTD
	+wyh8R9WU6tlRrHgfeckIFPCTFZ0Faa3qUIESLTAb12F9TMAx9yKTFCst2QlqQOW
	YenGFhcG2Vvdly83ZIQT6wbtH4THoyyxOPAslW5nrrnp5h6UNqfQFVr2QwnWR02w
	KalyaHCptTVYlNBw6nwwV8YpLbF8cgXDIc0qDvztffuk0O1A9mk/KxM/z0XUwlum
	UhbbcBMOQ6VljAEMCFiVMjnRDah5LMS3poJKM103bvEQ4DzkP67bVDhP3GJEK7wU
	GcQva/NvtQmFU7AIHVuIuQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1hfvn2t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Mar 2025 08:34:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52I6UGBu018827;
	Tue, 18 Mar 2025 08:34:56 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45dxdjs90v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Mar 2025 08:34:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KM69Z3KhEExPle2ByNaI5ErE31tyxLyDbf70bAMz9ZYJ2zSUNpmR5VZllkakpEEQdMxRNOFPu9e5+HirLoCsudXIOGP2ykqopjShWwz4RUtamBusp3vNtF9tzMwGsa2tYANZPHyopmoUCaJL8IgJxxMZgfHe/YnEnpXXdTvtziP1uHRgyUX31ZJAAYuAcR9TmnhFTIqJP/AO90Z/TFx9NvG9d0dE8pCgWG9vcObnvNSBWQoBKhEsxkWZ11yEgi8d34yaEFkjS+IJbTTT02fc0+xra0Lsh1hVyZTR/0hyFC4HR0s7BqmxYwBfVhxtpcFjlKCc94b334pVWHb4kByETQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NBrMnfYHBXymomZiJPrFCrqL/O2u2K0VdzHui0NCsfI=;
 b=P5ejFVA5oiGIxl0zuwDz5tRBJ2OTMmkMTI9Wg5WcHP/85lJuVqDNW37WlCMIcj9UQ1DwejykUBGguhJHNFfMpKk6DamJrhYqvHXQe4PthhN++ShA9sGGLC1RKRHb00dziF/TAUTqFqlC50k2yzmQZMr5Hk+U0Y9r/6hJe2/RDO7pYs1hpBDGOYDQTYrKruO2hj+svaUSd7lr7byz3HHNqqr4gmjsu2CTaRyMTnhQK4TvToC0kz7kjY4btDCaP4flZQ0JvilDsUwntbBqg8y7wy3Krs+CKuwSzQ9+XGzaeeOsXXVuHE3P4AkEvN1Ba5bv0PLNHCV20F9mhpoLBF+BWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NBrMnfYHBXymomZiJPrFCrqL/O2u2K0VdzHui0NCsfI=;
 b=ic1Q/mnsb2yxFTd5uMgp4h4+us/8+ODZHqzdxpQOGW7C9AKuCucvOvt+UMjzThCARw1h6Xa9d3nOrC8TO0wphBe6eL7JAql0znPZQ+1bb+628TngfvcAz78+kp/C1lNoi1uVT2vBxSbzPnf1E91iGpsbm6jSwvmykSzgmnCpR+s=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BY5PR10MB4387.namprd10.prod.outlook.com (2603:10b6:a03:211::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 08:34:53 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 08:34:52 +0000
Message-ID: <a50388a1-3d10-484d-a5bf-762423d13ee4@oracle.com>
Date: Tue, 18 Mar 2025 16:34:47 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: btrfs: zoned: verify RAID conversion with write
 pointer mismatch
To: Johannes Thumshirn <jth@kernel.org>, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Zorro Lang <zlang@redhat.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <5c6dcd33d98c4d79630748381b2aa3880fd156ac.1742223870.git.jth@kernel.org>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <5c6dcd33d98c4d79630748381b2aa3880fd156ac.1742223870.git.jth@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0132.apcprd02.prod.outlook.com
 (2603:1096:4:188::15) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BY5PR10MB4387:EE_
X-MS-Office365-Filtering-Correlation-Id: c31095b3-a2f4-4b11-021e-08dd65f7c0b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Tkc2a0JtejBkOHZNU0JHbVVoWFkrWjRlNkJaNGhqVS8vdjVPeWZwRkUvTEJS?=
 =?utf-8?B?NUVBekxhRUNTcHRuenV5a3NXd3l6bDZQbkRaM213eDhIM3RoNkJVM2Vrd0U2?=
 =?utf-8?B?MXQvZGxmT2FMSFViMHB2WGF3c1pHdmxSMnd2d0xNeUZzLzFUazFyVnp1S3Vv?=
 =?utf-8?B?Ynd0Z0kzKy8zVzFXQnZienRCOWhQUy9GbzAvbUp5STRZeUxZYzBhd2JyUkwv?=
 =?utf-8?B?REEwM3ZKazN4MytJbHAwTEpiSC9NWk9hNW5FWDlaaUg3b2R3T2hFUzFFajNs?=
 =?utf-8?B?WHhhZVk4YVE1Y2dyQkhTcWFKb3BHb2c4c2s4dzg3SjNXbGZjUzE2NE9kTzNZ?=
 =?utf-8?B?ZWZKaURlRXFxd1VPWmEwSTY5bkNXamxUMVVEWVgwM1hNZlVzQTgyM0ovcmhK?=
 =?utf-8?B?ODBTNXZnOEk0ZjExTEhWTzJFZ1M0S2pNeXRoVmpjb2VDTVlRNi9jb2JxeGlV?=
 =?utf-8?B?NG9zd0xUbVFTTU5XTCttejUrMTNxNEZxRUd1WnZ0T0QwczlnUHRYMVdEN0ha?=
 =?utf-8?B?S2s3TkFMcUpTWVRSRjZzZXZiTzNkYmZmamRsT3NPNmNRTDN6M2xBOFVjd05G?=
 =?utf-8?B?YW1ReEg4OEdxUGNLR2VGNURjUWQyd3ZFV2hWY2dSanJ2RHI5UXkzNzJJS1JV?=
 =?utf-8?B?WW45U2I5TXZHME9IL3AzRmxNdk8yVlhLSTFaTU44dmF3bEVKb0JYMmoyellV?=
 =?utf-8?B?eHlFWmdrT1JSUVBKSXltNFFnMTdaUjJZUjVjYkVLMjg2blMyd3Z2bCtlZFVh?=
 =?utf-8?B?emhQZVprSjZ0elhGK2hnMldETDBEYUFaNnJaQzl0MVd1SllQaWlVb01UQkdo?=
 =?utf-8?B?T3V1U2V3RDBWV25jb0cwSmZpV2ZtR1M3aXI3VUpuSWl1UCtTWmE2bG9zN05Z?=
 =?utf-8?B?WlQ1VW9saVFiaGVWUUg2OVR5MEQ2OHB3d05kTGU2aGgyYmh3cnhtWmowTHlP?=
 =?utf-8?B?ZU1yR0RVL0lYNm1ySWo0OC8zK3ladGNSOG5kZXVlWU1heTQ3ZUVTeGhxdTdo?=
 =?utf-8?B?aEtKY1BVbXZUOVlucTBTT29xRlgrMlV5N1FEYnJsTFZKM1ZEdXQ0OGFPU2w4?=
 =?utf-8?B?SjQrSmoyZ3BwdE1ENTQ4cTVXWTgyRFEwblUyaXg1akcybEthMUE1UnNPcS9Y?=
 =?utf-8?B?UFd3cGI4d3pnVFhnbGpENjI5RXExME55NDlDVVlBYWxwcFhvdlJyQlR5RlNm?=
 =?utf-8?B?SEg3c3lBSjY1LzZLS2ZyV1VWR3pheDVsUTJEN1VMczZ0M0sva2FZbUVnTmRa?=
 =?utf-8?B?QnhhUHNHaVhIRXgzNXdRa3N2djlycDkvNTF6YjlNSm9CTHhaWVJlc2Nub2Fa?=
 =?utf-8?B?Rk5ZN2tqTkJPeVFHcDNoNXBSbU05MTFCWUlXVE55UjJ3R3NDdGJqUEpKYnhB?=
 =?utf-8?B?bHllNk50eDdwQ2UySHNQOUhvR3oxY2N6bUIyaDAxZy85YUNlbW1VM0dqRHhL?=
 =?utf-8?B?MDYyYlFkSCtXZXJ1eUx0Y3IyOFRzZ2h1MktYeVBNUTVOL2FYcmVmRDU4aklL?=
 =?utf-8?B?TmJmczNXalJPTjNRM283R0hMV1lNaksrNGJTS2dmdnpFVE1YWi8xSUx5MkZ3?=
 =?utf-8?B?Y3lGVmovUStkYTBpTFhrUjRnTDZQZkFhTlZDd1RnR05QRmFLUDNzeE1wcENk?=
 =?utf-8?B?ZUdydjVVZWJYcVh2OVM1VVdoV1d5NU02V1BWTHZDZ3pOVjAxUEtDV3V0RlpW?=
 =?utf-8?B?cmxKcFU2dFNxZmdrNytFTjU2clF0NG9Wc2gxaVkzd0JoNEJNcHIwR0x2Mk95?=
 =?utf-8?B?N3VrSGM4ZmVvanBwWjlXa1g5RDdkWndjeWJmUXcrdWpQenVpU2ozWWR5Y0Vi?=
 =?utf-8?B?UENCZktIVDdKWUg5WmhBb24xQWRYTWQxWis5YWhVM0t0cllMZTI1WVJpMW9P?=
 =?utf-8?Q?7RzbeUwswZN6T?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bSt0YmJnc1FuM1h6NjhoTTFwT0hFVjhOd0tESEpNZk4yckVuVzB0Z3crejYz?=
 =?utf-8?B?a1M3ZElJU1FVK1FOVE80OTExRlovUEtOOU5JN3RyMUxxQTg0ajRZSGo4QlZj?=
 =?utf-8?B?VE03VlN3YUdLM2dLQ0lRbXJoKzNBVXhjSmduTzZQbVZtemlQM0VLWmtObktk?=
 =?utf-8?B?aWtaQ3BWYzFIMGRYVkZVQzgwUU1FRWFhcCtWeDBzWXVpQUcrNS9ia2d2Vmph?=
 =?utf-8?B?czRGdGhYaEpkWDY1cGR5WGlwZnpqZkFnK0dkT2Frbkl0NUcrWG9Hc2hSTjVF?=
 =?utf-8?B?WG50QWhGWmJGWUxSbWk3cjBYY2J2YXhITHBmMm1IVmwrQklVdDFKSjRtYkti?=
 =?utf-8?B?d2tnTWUxWXM3WndxNitYMzgwVUh4SWdmbjMwRGhQb0F1czMxWThLRkZHMGRl?=
 =?utf-8?B?VER4L2xLeWRrTGZkTFo3Nmhwd0ZmNDFqcUJBSVlMbGJOZmQvVlFGVVRPUDUz?=
 =?utf-8?B?YlNYZUpEVmpRMnZjT1RZMDlxMVR1OUVML3FNb1pNZmZhaVFnUTRhdldQeUI3?=
 =?utf-8?B?NllBT2YwdnE0UTFMdW1yUGdOV0YyajR2WlpyTTV3YTQxaitHM2lJSEwxdEMy?=
 =?utf-8?B?aTdVSUk2R2w5Z2I3TWRKN0hnTk44YkRCeFNZMVJUcXZWWXRVbFA2eVV5N2lS?=
 =?utf-8?B?ZTExTllkWkE4NmtSbkUwTmI4RnNwTFdzdGlXcnFnZ05UdG1acVY1YWhEQS9Y?=
 =?utf-8?B?VVY0OWhxd2JsZm5QMFl6bHppc1AyQjRQa21qZzlsdzJhSVJ2d2k5aE5GckI2?=
 =?utf-8?B?bEVTdDZhaWlMeEhmd1RLRkMwZ3R1dklsV2RpZ3hzcmhhNThyNkxCMVYxN1Q4?=
 =?utf-8?B?ZHJ0eUhYY1F0NnRhV1hPREJJQUxmNzlTZzcyeW91V2Vjd1hBTUpXNVo1SERq?=
 =?utf-8?B?QnBCUFR2U0RSc09HSDY4eWRJc2lVVVRraUNaRVVMT2h3MUpPckovYUlkQmk0?=
 =?utf-8?B?Vjg5cE5aV1hjUHc2NXcybS9TOFRaWE1sYjRyRDZQWlBMZ0JWOHh2TFVGbDF3?=
 =?utf-8?B?Ry90TEx2SW9IZWdFa0hYQzAzR2Q3UXFVbHNrUWl2OXhaUHBJTkZ3Nm00Rmdh?=
 =?utf-8?B?U29jVTMxVi96SnNYY0NydSs5UkREUDNScjdKdW5qeEVFaCtjVytYTUd5V3dV?=
 =?utf-8?B?MG9jeGhMMyt0NHNXUkpqUmhETHBJUjZ3Unhkb2hWaE42YS9SZEMrRnZ1amVp?=
 =?utf-8?B?TGIzL1U4ZmkzUWpBQXRXYTFBa0hXME1BTU4zVjd3S3I1enRaeFhtT0xuV1Nt?=
 =?utf-8?B?Z2xiaktxT2ZWbUhnVDFWVFhoZkhaTHFDMG9hejBQRjBDT0NKTkJLZldCV2o2?=
 =?utf-8?B?d1lJWnhieE5RTGF0dTNzdzZzZDg3ckNCU2EvNlJ4QWJZYXp2eHZaUDM1aW9o?=
 =?utf-8?B?bnAwYTJBNmlJR2ZicktvUnpmc0szbFhPVmdQZ0hwRi9VZi9HYitxSUkwWUgz?=
 =?utf-8?B?V3Rtb1dWcGxQaVFpelZ3TjFqWmxVcW5mL052V2twamhxUGgvUWZVR1paSGRo?=
 =?utf-8?B?SWFwMFdkazRYcnl1c1VDczFBbVd0WUlDa0o0THZGUzZkYmtad0NZRURKaDJ2?=
 =?utf-8?B?MXNjRTY1Q2I2cm9IQktMSXVGR0FMYk14S0lDZ3BpSmpmdzQrc2hEMVBZb1dk?=
 =?utf-8?B?V1Q2ZkhkeWN5M0p2em0yeHcvODB5c1gydFplYXVmY0NPZ1RUczd4OHA4c1Yz?=
 =?utf-8?B?bVB4Mzl5WWhWUHArN0J1c3BnZUJoT0Jib1ZqeVV5b0liSXNycWRNd0lMOVFQ?=
 =?utf-8?B?akEzczNia1RxT0gvdVhkWlF4V0I4dG5vVzNOQVB1ZVJvZi9ENTZ0SmtCaW4w?=
 =?utf-8?B?MFN2N3JuaGNaOWl3WDlCQVNMWEVZcVBrY3NMYlRWd2VGcjhPQjRVZGorT2JE?=
 =?utf-8?B?S3cvbkJlbkJ0NXlxWHB4TTJnYUo2djJyTEF2WWNjbUwyeStmVnFjMTd5dXM1?=
 =?utf-8?B?SEJST09IYUJxdlQ2S3V0dk1HU2tSY2xNQlZHeXNuZFA0eEdSWFI3czhteXJw?=
 =?utf-8?B?Tm9PeGxWOHhJcG1uU2J2cVNoSGlxVTJxZ2NtdjROdnFoNG04OEZNdzY0S0M1?=
 =?utf-8?B?Yk9DWHN2aFB3SWFNTUh3c1M2MlRGK1Mrbk9pK1pCbjE0eE1Tb0dDOVQySUdL?=
 =?utf-8?Q?dIhaKoeMw4elevYuxFLOKc/Co?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Q4QwDh/wbz13bIf+bdQ2srHdj1bzjXrpIj0tFrsGJqlpuosgMIT/ZdD6AoiEsINjktZU8PX7a7tBYGi3/bKaKBhU8vGOgMTYZB3u9M0BROFJzrej2t5EYR6hrDGLq96rJc2qfTc79muLcWGsEF0XsPjm7rEsHz/7suC6ayMN732OAZI7Tigbq1VUCTnAsJj7JK9Of4OKUPxtPbDxzL+sPns/03IeNsGGf52ZdDR7h/X8POTB7/2Xt3dYGIazbwRN9hC/UEAyZcB8f+7ctUrW+aS7O9nLApNMbrELvWeXdkPUYgCLPXmrlPkswXPiSdtuLwHtbbm5FRjaAWMLprd8W+qUtNQgCHDzLzXWknjBI+Wq9prSpenn2FhAbhVomApRyQ3ZBNi2NDsN+q6z6mUtmvZhIrDgXiNAL/NUjiMDLbtFaZ4dW/8cKIPly9t/FyAvRUPbB3r3DShKY2Iw1qtcsMuJisTKQ/Q6NNyCtuwVbfaIXH9Q9+0TKbhys4yDulfGagCXMcVrggTqNMCoZgP73r95moHx3sgm/N5fuxxsurjE780kVp5xC2APqN1i4foA0BM0t4dwdcGNpqrnzKYJcFSgnmDuwbbC8GpLrQzWXmk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c31095b3-a2f4-4b11-021e-08dd65f7c0b5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 08:34:52.4795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ofDfv0gmJWHoN7etvxzhETk+GPUwlfpPnQNQyC1Rmjjclz3TXj8xAphHH48lurwHarsMu/gluYzhSz3kJ9NHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4387
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_04,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503180060
X-Proofpoint-GUID: 6rLxmyLkvwkz7hFttbYRPL5RrG3slV12
X-Proofpoint-ORIG-GUID: 6rLxmyLkvwkz7hFttbYRPL5RrG3slV12

On 17/3/25 23:04, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> Recently we had a bug report about a kernel crash that happened when the
> user was converting a filesystem to use RAID1 for metadata, but for some
> reason the device's write pointers got out of sync.
> 
> Test this scenario by manually injecting de-synchronized write pointer
> positions and then running conversion to a metadata RAID1 filesystem.
> 
> In the testcase also repair the broken filesystem and check if both system
> and metadata block groups are back to the default 'DUP' profile
> afterwards.
> 
> Link: https://lore.kernel.org/linux-btrfs/CAB_b4sBhDe3tscz=duVyhc9hNE+gu=B8CrgLO152uMyanR8BEA@mail.gmail.com/
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>


looks good.

    Reviewed-by: Anand Jain <anand.jain@oracle.com>

added to for-next.

Thanks, Anand

> ---
>   tests/btrfs/329     | 61 +++++++++++++++++++++++++++++++++++++++++++++
>   tests/btrfs/329.out |  3 +++
>   2 files changed, 64 insertions(+)
>   create mode 100755 tests/btrfs/329
>   create mode 100644 tests/btrfs/329.out
> 
> diff --git a/tests/btrfs/329 b/tests/btrfs/329
> new file mode 100755
> index 000000000000..441be133e230
> --- /dev/null
> +++ b/tests/btrfs/329
> @@ -0,0 +1,61 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 Western Digital Corporation.  All Rights Reserved.
> +#
> +# FS QA Test 329
> +#
> +# what am I here for?
> +#
> +. ./common/preamble
> +_begin_fstest zone quick volume
> +
> +. ./common/filter
> +
> +_fixed_by_kernel_commit XXXXXXXXXXXX \
> +	"btrfs: zoned: return EIO on RAID1 block group write pointer mismatch"
> +
> +_require_scratch_dev_pool 2
> +declare -a devs="( $SCRATCH_DEV_POOL )"
> +_require_zoned_device ${devs[0]}
> +_require_zoned_device ${devs[1]}
> +_require_command "$BLKZONE_PROG" blkzone
> +
> +_scratch_mkfs >> $seqres.full 2>&1
> +_scratch_mount
> +
> +# Write some data to the FS to dirty it
> +dd if=/dev/zero of=$SCRATCH_MNT/test bs=128k count=1024 >> $seqres.full 2>&1
> +
> +# Add device two to the FS
> +$BTRFS_UTIL_PROG device add ${devs[1]} $SCRATCH_MNT >> $seqres.full 2>&1
> +
> +# Move write pointers of all empty zones by 4k to simulate write pointer
> +# mismatch.
> +# 'blkzone report' reports the zone numbers in sectors so we need to convert
> +# it to bytes first. Afterwards we need to convert it to 4k blocks for dd.
> +zones=$($BLKZONE_PROG report ${devs[1]} | $AWK_PROG '/em/ { print $2 }' |\
> +	sed 's/,//')
> +for zone in $zones;
> +do
> +	zone=$(($zone / 8))
> +	dd if=/dev/zero of=${devs[1]} seek=$zone bs=4k oflag=direct \
> +		count=1 >> $seqres.full 2>&1
> +done
> +
> +# expected to fail
> +$BTRFS_UTIL_PROG balance start -mconvert=raid1 $SCRATCH_MNT \
> +	>> $seqres.full 2>&1
> +
> +_scratch_unmount
> +
> +$MOUNT_PROG -t btrfs -odegraded ${devs[0]} $SCRATCH_MNT
> +
> +$BTRFS_UTIL_PROG device remove --force missing $SCRATCH_MNT >> $seqres.full 2>&1
> +$BTRFS_UTIL_PROG balance start --full-balance $SCRATCH_MNT >> $seqres.full 2>&1
> +
> +# Check that both System and Metadata are back to the DUP profile
> +$BTRFS_UTIL_PROG filesystem df /mnt/scratch/ |\
> +	grep -o -e "System, DUP" -e "Metadata, DUP"
> +
> +status=0
> +exit
> diff --git a/tests/btrfs/329.out b/tests/btrfs/329.out
> new file mode 100644
> index 000000000000..eab11130981d
> --- /dev/null
> +++ b/tests/btrfs/329.out
> @@ -0,0 +1,3 @@
> +QA output created by 329
> +System, DUP
> +Metadata, DUP


