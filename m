Return-Path: <linux-btrfs+bounces-11749-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC12BA431D0
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 01:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 069831897FDF
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 00:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B604C83;
	Tue, 25 Feb 2025 00:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SXGLxi8b";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RUvPt2mJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB501C27;
	Tue, 25 Feb 2025 00:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740442831; cv=fail; b=Eyc0vCv6BMLOyVWpQvtFOWYsUhoapyRXBQnzI3PKKSe+DNgQrCl100QuMoHp8n4cPiP1vLgho5lg48YQM5i3W+2k9Iu/EAta888dA/BtnxflCRcelY6o/knoRMfkO4sQmjKptn3WNaljB34wdl186VnDM8vzfJjqV6yrgrxFgF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740442831; c=relaxed/simple;
	bh=xHIkn9THDVpfvRtE13eGwSC4GgEJeldxxjZ2VnnKFs4=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=adCOvXX72qT5NK42tpxSemUhIiuFwNfFMMDRuULAsGy4CE/tHTUey5IuXXcIcoffwl6C90PMQ8viYEuowKUnyurQA/f3vhTOWiOE8loNChFdOSuVODmLB7G9JW6i5y2oRbOzShGiqQ/7X2rWA+vthDaTELa19gxxqLsvsK+16o4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SXGLxi8b; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RUvPt2mJ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51OMK3OS025137;
	Tue, 25 Feb 2025 00:20:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=HooYHaE5xYCc6OyL4dKhIh84SiWa9CMH2ZlXapLV2ug=; b=
	SXGLxi8bT7OAGQeBmzRjyKGKkZEnmQiELoGUVXIvCsDikroAo+MoNa3CWdKO1rF1
	NcbDIDh9OeKdK6uQb8j6ImieGPOC1QvN2dwk98Dh2ZPS8fEU9mnolgyNOz5wF1tD
	BcDwIMF2YojYKC70CgNMMkxNW/NVCxo4TQm7sbwgTZqU06LCEbDRVduCEWbyy8tC
	SAadlEkZ71t4fHm68zB/HG4jlZ6TCOefr1d31jO3inPpA9AeA3NqEvqnwCsBHP8v
	Y3wLPjOHDrYfOY3SZL8SbCL152BmnAbqTaNWAFts5od0BzHwROkaO+sgY0jGJi+7
	Ci8pilYk3nyJQlTyDQWhRg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y50bkvsh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 00:20:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51ONqYhJ008174;
	Tue, 25 Feb 2025 00:20:20 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2043.outbound.protection.outlook.com [104.47.70.43])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y51eg130-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 00:20:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DPzkM0tfpAJ6dZcU4IbHZmvz97iGmEz1IfS05BiHgQuYH7q/npCyAPMOLVdwmylgGU0dUzlh1oOH3wB98jlJZoY9fWYCAQMoPPn0cnbspNnkiYwXiIW70wpav100uZTUX+8IDlly79X1L0pn1IxcbRA9h+Q+legF3Ln97WATTtN0JHjnxVQox8onhf6uuLGpCdeNbzxHMgwif331Jm+qyYzsTJchznWzMf7FXQtcvWFdSQ9isFLV5IpVgRdMPNSqUaZABug0I3cMQVHnQvdOGR2CgtpIPepK1QelfICVyhfp7Et5U4WCHXNyhOS4lKcxkFY2KeJYzIND2sdVhIPrcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HooYHaE5xYCc6OyL4dKhIh84SiWa9CMH2ZlXapLV2ug=;
 b=OMWwlVTNsV47aw/hxQMOomjS4Y/qSqu/EMYHe/p8zgEGN6jPDgQqUfdQetyen59KFIH/eW1XwfFeixOfX48NfXXSVAimIi6kYFyEvr0zpuNiuMIdv0jh3rk8M0X9hcRz+0ll2M1qLt7PuS5e9yCf4YpqkU4wmntQN0zRC9JPbysZvYvX+h6NkuzpQuSEBzVTm2jeUKpCXtOSTFEkhB4CfLFBSn/YkoM091LUs+oFCBcc/GQZGytmZP5kyraryiyXBYf4bxr/rDXjCeZSMPdFEfUULIg4sKBJcCcu9xTAz6KdH9vE9jokbycTdWcBBHUqBb9WS6ndrhLleLbMOgNT1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HooYHaE5xYCc6OyL4dKhIh84SiWa9CMH2ZlXapLV2ug=;
 b=RUvPt2mJQ5S8RSJRCcqy9ojR7lpAtb/mgyDxZayEJFC99ENunbkVKHpdHdWmYcqenImXDUZPdffJsxaWLVqLaphcORcy62gwOPpTcaoRsd6WKqtDu6BBlbnVvwe9kJSlW3auPpaglRlpDLhFhchOvvi5aP/gW58IESerFiwlTbc=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MN6PR10MB7468.namprd10.prod.outlook.com (2603:10b6:208:47b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Tue, 25 Feb
 2025 00:20:16 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 00:20:16 +0000
Message-ID: <b297a34f-4c09-48bb-86a3-fea50c364ba8@oracle.com>
Date: Tue, 25 Feb 2025 08:20:11 +0800
User-Agent: Mozilla Thunderbird
From: Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH v3 1/5] fstests: common/rc: set_fs_sysfs_attr: redirect
 errors to stdout
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, david@fromorbit.com
References: <cover.1740395948.git.anand.jain@oracle.com>
 <e18babf503e66ce798c3df4353174afd4f771303.1740395948.git.anand.jain@oracle.com>
 <20250224181854.GB21799@frogsfrogsfrogs>
Content-Language: en-US
In-Reply-To: <20250224181854.GB21799@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0171.apcprd04.prod.outlook.com (2603:1096:4::33)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MN6PR10MB7468:EE_
X-MS-Office365-Filtering-Correlation-Id: 06dffbc6-1fae-4746-d145-08dd55322d97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cGdBTkVVbU5EY29rS1YwaTJDdUljZUU1THdLOVhtR0VIcm5pbGI0elVmdXJW?=
 =?utf-8?B?STdWVFdVb3dvL0tjZ1hkVWlHK2hFVXZqMUVKOUpSUVdnZlVxUjFLdWNvSWdJ?=
 =?utf-8?B?V0lXZzNJYnQxckVHWlJvS05xd1J5VmxTK0pCSlVYS0lwSFl0UkNSOGJwK0hm?=
 =?utf-8?B?MS95VnN0aEV6K3FKRXY3ZWNNRm56ckR1VndSTDlzc2dmMkZNdVVCeGhUZHlF?=
 =?utf-8?B?UWpCcDN3MVhQK0dPcEhDSlZkNHVnK1NEdDBaT09RZUIwVXJqNTVyMjQ2TGlN?=
 =?utf-8?B?eDloMlR2R0E2cnNjS1VwOEJFS1ptTTdkbVVQbitFZElielZLbW9ZQnBXUE5V?=
 =?utf-8?B?cHFnRmoxSmVOVjYwMHV1dm1zUHV4a1hDM3RPMDJLWEFBb09zaG5jdmJSWFBM?=
 =?utf-8?B?ZkV6NjlJdkV2WEZRclZTaGNCdWVuTHgyOHRrNjZMbUpsdlo0L1Q5ZUdOK2JH?=
 =?utf-8?B?elR0ZHYzSXN1UEJkb3Z3VUVEMnhwU0NBMzlYUFpkMEJoRElsM1RFc0o0VTJL?=
 =?utf-8?B?d3dNU1dQS09DNElzeW1ySkJiYS9hOEpjNjlYSm1yS2gvUFVyNitaWTBrZGlh?=
 =?utf-8?B?dmlNaE9TdG04NUkwRVZNUkNEbHRYTVZsZDVwRmV5RGh6OWF4d0Zma0tua2pP?=
 =?utf-8?B?YkxZOTczOFBoalNObS8vYkNoSzFHbmVaaExoQlBHKzdpUE9wL21JZXdPcjha?=
 =?utf-8?B?OWN5KzBlOXFEU041Vm5RTUpySng3TTJNOVVBdk8ydk4vQWFPZHZiRFQvQlpS?=
 =?utf-8?B?bE83M1ZaSkNqM2tiRG45YU1XWUErekszUzZJWXNSR3l5aWVIeXVNSWFpY01i?=
 =?utf-8?B?VjdGVnRkamErM0JoUndmK1FOMnMrMlh0ZmdPWWZGN3RvOFdsREdLTTVaZFVy?=
 =?utf-8?B?amUzY1kySERSSE9XRUJNd2xpeHVURzRTOStnNlpmMWZwejZ0VGw2SVlnc2ZO?=
 =?utf-8?B?MDVaMXdUZGt5SEdBYTZuWmgzMzFHRkh4MjloOVNnU1lrdVF0UFo5RFc1YVNZ?=
 =?utf-8?B?aUJOQ1EwaXZaUGpZOWR1NFJUUHRuaHlnZXVNTmlyMUQxUGVlbGpGang3eGRx?=
 =?utf-8?B?eWs2azV1T3pJaHVHd3p5R2N2RStSVTRpR3Vsa1pGUTFiTjhCdnZ5ZmJUMmtR?=
 =?utf-8?B?WnFZeXI3d2p4VGUzQ2hCcjZCQjgycVhvekRQV1E5YXlyR2VWZ3NWRG9hSlNK?=
 =?utf-8?B?UGxvd3dYaGlHMUV3Z2x1Z2I0d0ZXWjlreXNWZmVFVHlnMmJyblp6TXUxY3hh?=
 =?utf-8?B?OVZBTkh0SXVOZXV2cGx3aVZEMFRuQS9qVjhOMEo3dlVqTUE1Z09sYXhTSDRB?=
 =?utf-8?B?eXg0ZkpMejR0eTcvbDRPVzltNXlxbGQ3M3FBUCtsZkI0dHlNNjFxeUdiaERn?=
 =?utf-8?B?Q0Fad0ZTNnBjZGZrTkJKcWs4cnlsaDZEdDVxN2poeTlaM2NaeE5kemxxRTRt?=
 =?utf-8?B?dVJRMHExMnpyY1RnU1ZWTEM0eG12bEdBQ2JFY1ZJQnZlVHZsS3M4VVVoTTI4?=
 =?utf-8?B?L2kzTHRGRWRyWExMRlRhMFhmN0M3UWtpMitoU2hkWTEvVTEvSGszT25hcENK?=
 =?utf-8?B?VGIxcGV3cEpoVElRMWRockl2aHZZS3dKZ0s0SmVXKzMraGVzSFNBalpKS2lI?=
 =?utf-8?B?Y0ZEUytXUWpJRkRyQVNDLzRyd0FlUkVDblFzSUJEZzlvMjIzTmZObXRvbm1X?=
 =?utf-8?B?citLTGVhVDlxVElhU204Wk9zaUVTdm1mYWVKeER2c1NVM09nYzBWWWdXaFYw?=
 =?utf-8?B?NUZBVEF3cWZoQVJCanZ2ZFl6d0RGSzVsU3lKSVMwalFSaE5MR1ZFTCtuT055?=
 =?utf-8?B?MWJIUHMyMTlCaDVQTHN4TkNIUGVhcVVNbThhOWVwRzl4LzdUbHZGTUdXZFRJ?=
 =?utf-8?Q?OaLP8h0DbA5ks?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SDZTbThpK0ZFZ29JTW50SDNOZVQrdWZsb2lyd2dBZnpIV1ltejBLTXhUSlBB?=
 =?utf-8?B?OUxLYmQ2dTd0MGJ1eEZ4UG1oY1ZSQ2lzTk9xajhuZnNKL1YzM2JCR1JIdDVt?=
 =?utf-8?B?V2k1Z2FuQ2NxQWVhWGRmZEJvNjJlR2tHbm83Q3AvYURXRDRqZkl5OUdxdVMr?=
 =?utf-8?B?S2xJRTI4NXBjSHlIQjlYVGlJMGR1SkdKcDJjYUhINzcxR1ByNTRPSlJZMWxB?=
 =?utf-8?B?TzFKeEZyeWlrcmxZRnZaLzNPL2tYejF4UEQ2YSsxTUlubGY5azZTc3ZvZS9H?=
 =?utf-8?B?NWJ0OGxVUTM5MWhGQi8waWZYaXdVajJFZThmNjZJa2IxWE12M1ZNNnlVYm5C?=
 =?utf-8?B?dXhGdm5aUGhtWkIyTmNpcEh3ODlBcjI0dk80U0NMMmJiTXV3UVBJQjlBTUZj?=
 =?utf-8?B?cStvTmNnb0ZYYnZndVprMW41N1BJSWIvMUphN2kyd01kTG45L3REQVB6VVVu?=
 =?utf-8?B?ek9oMDVFZEVOa0lDYkRFTWE5UnhMMVJjMVhOZUpZUitpV3BDSEREV1FNZ3g2?=
 =?utf-8?B?SXc3RHh6NnBZZ0VkY21Cck1xTnJUUXk2R2tHUmtYRDdvWSsxbVRQcWJoa1Ro?=
 =?utf-8?B?bFN3ZHhnMG9hMHlYR0M0RnlGUldDaEpiamgvejhwVVNqWVBLWktkL0p4dmFV?=
 =?utf-8?B?YTVuNS8xcGZNN1F1aVF3U2k1NU1IS2JCb0oybW9Zc0Uza3JjdW9QbEQ1UzRJ?=
 =?utf-8?B?aVh6c2RnUkZNVHRDaWlyZTNteFVnYno0NXZVNTR2bjdKYW9GWk1iU04xdmFs?=
 =?utf-8?B?OUhjVU8zN2FmaTVsKzZleFByVmRFT1lEVUtnWW1wWGZ0WWdNZm9KWGJRT1I2?=
 =?utf-8?B?a2hDYitKMmZHWGhqWExUeXFnbzVzb1VWNWRtRlBoZStHWTUyb3JYUmlEMmgw?=
 =?utf-8?B?ekh0cmdtenhxVVpzMG1OYmlkYVoxN05zazFhc21yQ25sWHo4Z3hFMXJ1aG9P?=
 =?utf-8?B?Zm9Cc1U5V3BUWmpTTkplb2lzdW9UajNlbFNscmVkVDNQYmh1dE9ncjJyY1l2?=
 =?utf-8?B?Nzl4aVQ5WVBuTnU2WVRjUExsR2RrL0x1VFZvL3orbXdPWi9CeFU5aEhLQzg5?=
 =?utf-8?B?RzJtWVR0Q2VwREhtSHNFaGRhZzFRWkowR2pXUjR4eEZvaFBnbEFRcTByeGZM?=
 =?utf-8?B?ZE1WVmVua1RvMFcvRVU4UjRBcGx5a2NsM1Mvaiswb3lwbDI4ajZaMTFYeFc3?=
 =?utf-8?B?THAzWDFGelpRd0p5eGU2NUJ6Tlllc0JESVRxUzVWdmMyRVpGTnRET1NkWGVE?=
 =?utf-8?B?YlV6YkFUNW52cEh4V1M0WHgyUWZEUWJlLzY5RXphdzJ0Z0RBQVhJcnVnMW4z?=
 =?utf-8?B?bnFFRWhmL1dFNmw1TE9MRnY3aVpQTzRtNWJpY1hyUmw4WGd2SGZwcGcvVWpP?=
 =?utf-8?B?bkx4OVRTVFhPcWQ2TFJodC9QamhrNnptMkU0SDFJT0ROc3J0R3VER2Y1RzhC?=
 =?utf-8?B?d3JyVEpObTVicDRncitsZGtiTXZnWW94eDJ5cWlCaGdQTHB6dVcwRzdkYTYy?=
 =?utf-8?B?VlJua3N4U05sVGJ2dTBqUWJ0N3JDeWZkZzc1bFRUUG9xdzRWSXFsZVNXOVJC?=
 =?utf-8?B?R3pDL2RpTXRnMHpZZEFrbENqSTRvckpZYlhuVGRSc004TVZjeTlnTUc1WkNs?=
 =?utf-8?B?RFAyK29IdlJjUlh0UnV1Yll1NVFUS3FPanc4Y3VOYURTTlFaQTJrd0YvU3hk?=
 =?utf-8?B?SldyV2FkL3JGbFRXemRHWmRBWDk2RkwrZjlDdHgyRHMwTmg5c3cyTm1VL1VB?=
 =?utf-8?B?WGc0SkVYcnJ4K092Q0FaQUNodlJ5MVZqbmhxWTRQUDR1TTgySWRWOHpRQ1ll?=
 =?utf-8?B?NENEb1piN0FvajJZdmE0OXF1NjhmSW9oYTE2RzczT0hYandibmp5ZW0venM5?=
 =?utf-8?B?Wll0NEFuaDlTUVFZRlg5dUdFUzdBWW8wWFlXQ3JPWWFiQWVXbEkyTG4yR2Iw?=
 =?utf-8?B?amN3L1NWUjVCdjNoTjBvcTRvZ1JLeGFlYXlXbnFtVkZ4TDM4QWptNDh5RGxY?=
 =?utf-8?B?Ukl5dlUra0I3MFhhQTh6cGorODJ2UjJJd1J0R1l3RFdmdElRWXczMndBaE5J?=
 =?utf-8?B?dUZ6OW9heWdPYjVWWm9uVi9qR2NhdXU4MFBhQk42N0pnQWNTZ3VLbGVZNUlm?=
 =?utf-8?Q?vcM4O0te/+RqICpD5SfMRbLb2?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gF/JfslYWv02j2tq3i/F4GrGPvgs0RM9quXlk23Oy3u+NMZJB4V92/xLznWCNUc6kZtDB0Rtaz2wRbqs8PBMmgzUVwztObcAai9giXjDdo9WOB910z+2YDfBlq7cgXDqDPmeO2Nw1uyMvO2+YW08kZd3dyXIBoI7YlRgzBpFhsGyQMhANDbusRIwBuzGzuPm/n+Ff9fiHPfkRXR3fVHUBSgupPFdVzWRMGA8BB8ACBjH96U33dkq3Ve+lEyHfTO0LFlTvrOJf64fCPkmtxzfxgpq4PRgMaE23pin7I61sFW/GB/OLd4dUO6N56YW4eJDFMBtORu95FleuaqEwTsLzlzYvQPd6zqBZC5jhVW9kMynJV0UqK4tv0Hr4AvEBtz/XMU8pQjw1GL/E8QNwhGUaucMqfTRApnCb14u/DY/ecBKoznFNdxBRHBjR3dgA1ud7D/eTLhmB4NMWf0R19Qx3g6NacIfSYcKmEeJmyiH32OXdxT/+h9YD67Hlp5RXFu+lfR49diSmDa8Z4+WkQXH6K2grXtcA48ig3fmx3nlfVNW2UzL5mFs5g8NIut2+tMUMcGUyMMSFjnt0mgngilipe6VsdwNbJwy7MPi2RkTW20=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06dffbc6-1fae-4746-d145-08dd55322d97
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 00:20:16.1994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gzSOGWMN8AWyzSDxdrg2821zA6cBc58y0zD5fwJhll1P26ZwGlWmPfRMcMkMhFTiHh8yTlr/1BEtvn5a8o9tYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7468
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_11,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502250000
X-Proofpoint-ORIG-GUID: 1ajIG2HEx8m5lxvs8540YzIv2X0Y9eQ0
X-Proofpoint-GUID: 1ajIG2HEx8m5lxvs8540YzIv2X0Y9eQ0



On 2/25/25 02:18, Darrick J. Wong wrote:
> On Mon, Feb 24, 2025 at 08:15:04PM +0800, Anand Jain wrote:
>> Redirect sysfs write errors to stdout as a preparatory patch to enable
>> testing of expected sysfs write failures. Also, log the executed
>> sysfs write command and its failure if any to seqres.full for better
>> debugging and traceability.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   common/rc | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/common/rc b/common/rc
>> index cf6316a224ff..942e201649dd 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -5081,7 +5081,8 @@ _set_fs_sysfs_attr()
>>   
>>   	local dname=$(_fs_sysfs_dname $dev)
>>   
>> -	echo "$content" > /sys/fs/${FSTYP}/${dname}/${attr}
>> +	echo "echo "$content" 2>&1 > /sys/fs/${FSTYP}/${dname}/${attr}" >> $seqres.full
> 
> Did you mean to    ^ escape ^ these double-quotes?  Without it,
> whitespace in $content might not be logged correctly.
> 

Oh no! I remember fixing this. Looks like I messed it up during the rebase.

I’ve fixed it locally and will wait before sending.

Thx.


> --D
> 
>> +	echo "$content" 2>&1 > /sys/fs/${FSTYP}/${dname}/${attr} | tee -a $seqres.full
>>   }
>>   
>>   # Print the content of /sys/fs/$FSTYP/$DEV/$ATTR
>> -- 
>> 2.43.5
>>
>>


