Return-Path: <linux-btrfs+bounces-11720-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8212CA4120C
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Feb 2025 23:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D93033AEABE
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Feb 2025 22:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF1B204C19;
	Sun, 23 Feb 2025 22:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AJ7sPCKj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RbVnrOK8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BBF1DDE9;
	Sun, 23 Feb 2025 22:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740349935; cv=fail; b=QzBccXH2uMRjLdyvxD+ZknL/JuVTzLVPRuaMs0lZZ5VpNT5Q1ElxcsD3BuXG81DyTpECGrkHH7NYjjhIOE420yEIJ13sOZlJQcf6DTuAIBskiQR1n5Z4UhkU4QXEzRYr34zJnslAL2LEux+R/g7zwWf10V93Pxc1w/5+kriv+lk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740349935; c=relaxed/simple;
	bh=k4S+dWksdaoTCCl8f4fSEFcJ4YpI3dX2efcLcDArNJA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DT1/V2L2O0nbTJAeOGxTaVI00K16XrltFaFzqVrm/kcNjR8JEM5eFzEm8yII7DsEMrFqCpKc5NnueHQ9CTfty0gxD8wHGMdz9EfS1djMrreSauGC9LcGGV4Y/Tw/akMydf1/S332eObmyoiLl8eviIR/ekW6mIxXMbZB7vnkP7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AJ7sPCKj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RbVnrOK8; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51NMK1ss027748;
	Sun, 23 Feb 2025 22:32:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=v31OYyt04yqY924SEGRdlt3Q55AjHBuFwRZa3MGf4TE=; b=
	AJ7sPCKjxcjGIDEOrxUFbyMm6Q3/kLLJvH2y/7N4QyKz3YVjmLNNTA5D1sd5fxds
	EM7kFx0b3UUb9FroZIJhxuicyt788goFpbU8eM156Cb5WWfjxrEzvktr6Lns38wU
	LOs/VESPLV0IIqu8dLWonwQkrmiQ9acCdLFl4hWCd0NStntiQANdgJ73BEkm3L2h
	WChKG+2MY6LFIAhef8FjLW7KakqzAHGZeOvfW4nuhPChbX1KoCsJsZOk6LA48MsZ
	bf6pbv/a0FfLptK7RgxkXExSWAkBE0KZrBMoXlpmNiqXqg5rUKa9mBTpCgpqzkv9
	I2vCkq6YPZJtdN2L2rbOmw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y5gahhfw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 23 Feb 2025 22:32:09 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51NMHc7o007551;
	Sun, 23 Feb 2025 22:32:08 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2045.outbound.protection.outlook.com [104.47.56.45])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y51d03dd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 23 Feb 2025 22:32:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g+gA5YYf4ET4LfhxETHRP+o+2YdFVGSuJw58ZQxErGEtcMbmhhnZNcjUkfu0dtGD5Z/bakihCGahwpUmJjxz7fQPnsH8hlWfshGTRvt3LR0krueM9IUQNL8PmHzuXAo9LbNlAJaNiqei5KNMOfwYJE35+owLf60zDL29jhV3+YPP4IHQvVoX7OKUmOTUPNWZ+GMWPSFrTMFpBVenKhDIidCTUeE+A5+IV3xEd50WmiqqlWwaWGvsOUuhYiLXoVzPIArYqTrppfe1ldUQ14H2KTl2QQnZW6/JIwNc80ekV9vF3YgcXb3D33+M/T9F48UWf/F1KLTRfzdgpQCIMSDaHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v31OYyt04yqY924SEGRdlt3Q55AjHBuFwRZa3MGf4TE=;
 b=JfcMfv2TVwmnQw3PGICaH8TTi4KcNoIYEoaoYvRL63Vu4rlNuaQoQKiUHVFcs/0mCFrSxa86NUozkKZyu2YtWsA48Tfx0tDqMJ/zJ/Mw/DaFU8M7VM2sTVdXNI2a8Q6qX4lyKFtMXg49wilPD2NqeuXIjIqlPRpwDeVzXcmZRkTxS8u4XViIHj3VGPRBDjhWzy+T9Gr2pGrvdd3UIqJgR2kSq4vbKg7ymTJA3hWh2GGMVhL0LoSMmaJOtcy6K7aAlaGeqj93in5ZeIQxC6TCcSqnYDzPPkzUWELZrRMtX2nPYeoSY0p3+86GRiTUtv6yGNIaWyDNHPZmXObsBuLwpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v31OYyt04yqY924SEGRdlt3Q55AjHBuFwRZa3MGf4TE=;
 b=RbVnrOK8DN6x7yf4DFfc1w38fk5sxHzihxK5DYnFvHL/wvgOpqxamMw8cV1/yo82FMx3mJp/OlnT+h68H0ROkQ0TwCBZQLwHNA9HLQIESzaxcU1W/fK6VMH4aL8UTzRGHxV7l9Q1Cq5HsOvQ5oOH2DLohRfHywDCe7QYo6Re4UA=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM6PR10MB4348.namprd10.prod.outlook.com (2603:10b6:5:21e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Sun, 23 Feb
 2025 22:32:02 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8466.016; Sun, 23 Feb 2025
 22:32:02 +0000
Message-ID: <2315deff-94a4-4cf2-979d-83459903caa4@oracle.com>
Date: Mon, 24 Feb 2025 06:31:57 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: btrfs/226: fill in missing comments changes
To: Zorro Lang <zlang@redhat.com>
Cc: zlang@kernel.org, fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@kernel.org>
References: <e73cfe5310a8cee5f6c709d54b8c18ff52e39a0a.1739918100.git.anand.jain@oracle.com>
 <CAL3q7H4GgaQKTLzXzza4xKsoa22pG6MbOFYOuNhK-5J-ieZdRg@mail.gmail.com>
 <20250221150311.eabczmxfxnvndkqk@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20250221150311.eabczmxfxnvndkqk@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGXP274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::16)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DM6PR10MB4348:EE_
X-MS-Office365-Filtering-Correlation-Id: 98111b50-ebba-4b9d-ecf7-08dd5459e47d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dytWZCsxWHYzTzQzdElqN2hIS2J0dGwzaWVGekl1OHZJQW8vOFNCZlRYSGxr?=
 =?utf-8?B?eEVaK1puTE5ud3BTMXVneSsyRGZ3UEtsZzQwSzc5cHlaY1BEM20zKzBoeHd0?=
 =?utf-8?B?ZVpHU2ZWRFJaVmtzL045Q3dsYW81UU1BREFRcUZwTXBYeFFxMW5lWStPYzNG?=
 =?utf-8?B?QkZpSnlxRDNEWEIvUmdobDRLTkIzOE1vcnlYaVlGdmRYOThoUDBMVzhqalZ1?=
 =?utf-8?B?a3pzRnR0OWw5TWxycjYyWjdXcGZhYjNPcnZiMHkraWRTMkVSeWFzLzcxTnd4?=
 =?utf-8?B?dGVVQ1ByeFFGTWVlemh2WFZCVWtSVHRjcTk2bFZiNGs0VzRoM29Fd3Q0b2xJ?=
 =?utf-8?B?ZHJSMHVMbXI5NnM5ZzZZcmlhaDdwR0FUNmZIS0RoZVBBSmplbzBRdm5TcVRQ?=
 =?utf-8?B?V0pzRnhkT2J6U00wMUFYZHZueExTZS9UOGRTTlFuWVRJR29oWlM2eGdnZUl2?=
 =?utf-8?B?YmFOYnJMcExaeTRqeSt5bkRUSUo1aXB3OERZY0gzdnJxbjcxd1hDbGNmOTZw?=
 =?utf-8?B?YWFEekFOcWNjeVFZUG5EVDRYdE91WVpUVVZLdGhmZnc4NjBzUlgrUlUycEdr?=
 =?utf-8?B?Z2JSNmNIUFhLSTdmeDJPc041cThSNm54dnUxVGd5OGtOS25mOHl4TUV0dU8y?=
 =?utf-8?B?WGZXSHByWjRyV0FrVHRkTDI0OE4zVXVoRmdjMzdqYW1XTC9WekVxWTZoK0dV?=
 =?utf-8?B?andBZG9KWEJqZXFUdFVkUWRHVHVwcDRDcmsvUnExSVhUcno4c2Z1SUloSUJB?=
 =?utf-8?B?OHFubnV3dHdXQ1VvalZUMU9nbkk2bVVTdnA1Wmx2c21CLzlUSlA3Ymd0RkNu?=
 =?utf-8?B?T0owbEVIMjRSRlBlK0NiSDd3K3BWUU9SRFRDRHUxWjhCSStpQmlxbTNCeC94?=
 =?utf-8?B?NzV0OWNIQzRpSWJTSWZGcFBSV2ZDN1ZJS2o3R0FZYUI3MVRTWllRbU94ODJF?=
 =?utf-8?B?Z1BmTUo3eHZWSXp1R0JlNnhqRWwvd0hKVFgzeUpoTEF2M3d2dk8vR09wQUlH?=
 =?utf-8?B?TVRPRzRzb1dwZXFsL3NINmtRSWQ0NTlVZlNhcW1MWUczOXFSbjRqY0VPcE9Y?=
 =?utf-8?B?UndBUnRkcXVJbDVrcmtYSGRpLy8vOWkrSWhsNHBVR095VkF5UjdrYWVUejFT?=
 =?utf-8?B?bkZLSTBTaGh5a2lYVGNOTkdqOVArWWJ3YThCbllpcTlkMzdhV1p6UktsQ3dR?=
 =?utf-8?B?anhZNlZGUGNuRDNpU1Azd3hEQ0pNRldBSFZGcTRqWXp6UGRtOFl0MU1RaTdl?=
 =?utf-8?B?SkNCdEJ4WUlYZTlxRkVjOURDTWpJajZoVUpOdDFucUVKTDRvWENxL1VkUERJ?=
 =?utf-8?B?WnVQU0hLZDlvWTk2dVlpb09UNThMOVRwQW9sanRhYm8ydnVXU3NVdGhnb2ln?=
 =?utf-8?B?RTkvckpwd0dMc0RkRlZHTy85YjJKMVpmei9TcVo5MmF4M3owVFFkNmFCcERQ?=
 =?utf-8?B?cjNiZU1zRWF6WUs0MGdaU1Q4WGV2WUZOaFBDem1sUG1TblZDanE4c3JiaVBJ?=
 =?utf-8?B?dlRLbjdkNzJMaEVxQXh6WVJxUmoxRXhacFZtZnI3ZlFCcnBMbTVWcTE3elJs?=
 =?utf-8?B?RWgreTEwbnBDR0Q1aTJZRFUrTFAvRXllNEJmcS9yTXJWYnJzUUFGYVF6VFA5?=
 =?utf-8?B?cmhZb08rU2w5R1o0Y3NmdGxTb21RUTVXR3RrZ2hPUHIvZFdMdUhidmtCempU?=
 =?utf-8?B?ZXgyR2U4L0lHNVZnaVRpZ1JXZ2F1TWxxOUIyVU01NDRtMldKN2pKenFLZXBa?=
 =?utf-8?B?dkl6S3dtdEJFOVg5RVdSQ2ZZa3lzUENJZlJDbk1ZZ0JBN1NibHZaV2JsOFQr?=
 =?utf-8?B?V2JzS3FxaVkyczJzMDdyQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S0tNaUNRNFRDYmRUVEpGWXEvZjRFS1VtRWJ2V0RnSlBxWTByQXN1U1dmOU1w?=
 =?utf-8?B?d0tHeXcrdFd6SjlqNFRpZ0psK1JLQWx5YXBUMmU2eEtqVkRLaTcvemxrNUxh?=
 =?utf-8?B?QWMrUTJJRXlYU2pibkVHSEw5dUNnZTF6bkMzWUhpaFhXRkFub3RhRlR5bGxa?=
 =?utf-8?B?bzlLb2lxaGt4UldseGtVd3lNZVRnbmlJWFIvUGwzT1hpOEZuNkpuTWEycXFN?=
 =?utf-8?B?Q3g0OXorNEtNWm95YXVxcU9yNWtpQjR0Q1BCRDkxZlBNeGFzOS9CQnJiY0JV?=
 =?utf-8?B?U0RXRnFuRkRjN2RwakVpUnRLVVdKL0lOWHFUSm1oclVFUTBraDFDV1k3aHVo?=
 =?utf-8?B?QkI2Yk5PMlBNNG9XcFE1OVpkeXQ1V1ZOdkY1MUtDd3FuNDN1THlQVm1Ocmwz?=
 =?utf-8?B?MUFvcytqdk1tTU5xQnlXZ3R6T0I5Z2xXL0FUMGJVb09vVmxQYStFVmwyb1pL?=
 =?utf-8?B?TWFlZEZTR3VvMUlrcTJOMWIrdHdFRW9yamMzYytJWG44eExETlZpa0hKaDZv?=
 =?utf-8?B?UStDeEUySytsOWMxTHhyN1ZqSHZpZVJjTjJuSXkxMkJEU2tnSkJrQkd2THFn?=
 =?utf-8?B?RFZxSENoZmdRMkNKY3JtYmhuVnd5N0VDd01wd01aVFYwZFRIT2tOK3Y4OURV?=
 =?utf-8?B?WmY4c0lyTFlVbTU4ck9lNUx3SlJ3WVFPUGw0bWhkRis2WFFsL3oyMGJwUkxV?=
 =?utf-8?B?WGNsaVZPYjQrbUlMekRmWmlxdFVQUnBvdHRlZHplNU5sMVRId3ZoRnRCMlE5?=
 =?utf-8?B?ZDVSWHVZdUxrRytMSCs4WDBYd0E0emUzbmUxWW5BUHliVDFUUXVzWGEyelhJ?=
 =?utf-8?B?bTlwTk5pLzhMb25seVlUd0JJOVhaei9LMXVJeTVLazhiK2ttcUZOY1ZZRENR?=
 =?utf-8?B?TGsxNVlINlM5Ni94bWs1OTJER1R5dUtGSDdKMUFQOFNBcUsrcURTRmdPWlVk?=
 =?utf-8?B?cDc5Z2VlemJlWmdzeFVmbUlWQk5COURxaHIrbnRuWWVmSDFpNmJpbmtkb1o3?=
 =?utf-8?B?NVQyZFExNXRPbGRFbTB4U3dIdlloSjFmUCtzUFgxUVg1Q0cvR1ZKam5zUVc2?=
 =?utf-8?B?ZGU2anZBU3FwWmdQMkNLeEZxMU9LbHI2YjdGVVorby9zNDBVbXc4Sk1UZE9D?=
 =?utf-8?B?aUtEUldOazU3WktjWFJSNGxIT1ZpQ0ZkWmEyYk5PYTlKYjN2NnUzVzhzTGVi?=
 =?utf-8?B?ZGFCbWpLUjRyM0QyR1BsRlY1Q29KdzZRcUIyVExWWWtMNENpL3pPN0FxMmNj?=
 =?utf-8?B?L2JwYkhvUWpTTmhkV0MrSTRIQUliRGxxZ1NWMEF0aksvSlRMcHdneFM1RGdk?=
 =?utf-8?B?QWkzc3NaSXRUYm5vUC9kSEFWTFFtelFRelExeXdCMTJWdnhYZENGVmpoTHVs?=
 =?utf-8?B?QVhMeFBxNlJLdjMwNEtlWExCOTVPZmR1OHRmQmRqakcxQWp6OUxMalBOSC9T?=
 =?utf-8?B?TGNEWXFHbzZFTjRCQkdUaHdWMjhMR0hEeTdFRXVOLzN6RXg3QlUxL0RTQ3lY?=
 =?utf-8?B?UWduTEhVYklUVU9Bc0MwTEtaZHBoVTBjbkR3ZkNVblZ2SUswbTZjUXUrZjNS?=
 =?utf-8?B?dUNtNmpCYWc2alFWbnhsVXBRejFDV1d0ZlJCM01RYzhmTldadGw0YmVRRDRo?=
 =?utf-8?B?eVRpd2h5bDFpek5PS2h2K0JZTlRSQkVkWTlHLzA0cTZOUnMwcEFTaXRKeVc2?=
 =?utf-8?B?ejRrbzdxRkJkcWRLOFE3dFk5N3dyVW5kcGUray9yWlIwRVlqRUpFU2FCVGNp?=
 =?utf-8?B?aVd6V3pZQmlrMG1BekRJeTBYS3JPU0dQeUUxK2dOaDNsaU5OcFFHS08rZDVJ?=
 =?utf-8?B?L2RSSk90RllBa1V4Z1YyV1JKQ0tteVVLY1FLR2ZVclp2TUZlU1dMOGdML0Z4?=
 =?utf-8?B?MXB3TVcvQW9EL295aUw5WWtEWUNlcGRFYTY1NVhUYUluMU9FRjgxNG85WGpI?=
 =?utf-8?B?YlRVRU1NMG5waXRVTjRoY1ZIOVR1M3JxOHllbXlRcnlQRUE5TVVCUGVZSUd1?=
 =?utf-8?B?b1lrZGJ2SE9WUm9JaTUza2xrUHczUmp0a05ucVNuOTdxbW1QTUJXeGtibHRV?=
 =?utf-8?B?UmNQNGxHUm5KQ2ljSmdFcXM3ZXFiS3NjOVFXMFBSTHJzNHNLNVd3ZXNtRkg2?=
 =?utf-8?Q?vj5W9BpkzrnoVNEGnCecu5tyL?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LxK04fP8TUrxyt+gRM2xG3VPk5yV+pa1UMq9O9KPeq8kbuUJHSADCupVuIw7cymFziTAqSpSfuuIyKkRim7hHvM8VVzRXvIQGt7wZYcIwKR8jcsBY2XADbFMedN6sVthAUviZYP1ZH9zsCxarAbeb5LZGQBYjA1h/7WCqnUDKi1SuK9LlTY/cLX5D8dPQmgE7tZDzQvkMfZjMOqrPKE54gSi/TTGWXjrLC/UyiqcCuAfX15Ad1SRS+YXVvA9568gx1N27ygjki5VZQjtEM8dSiNWFpZ3s6OaArdql6Wxbs0YWEMgYlaU1+igOWQo92YKqynOoQqX1oj8S4KU0IsDphAoNW/HRn+WCUiKQ0ET/lcc9mGyOgaRUNBE3UpmvSPh22o5dKBn8cgqx37+2CA8N59lne/CSvnZ9hUfqdBe9lNGBhA2tmXnuZM3HV22aGCXkkdjwOS57amFlW/SgmIATMl23n9b6rh7MMl6LAr/CFQpNcBnfDcqdVL5ROlSgSmAGESESCJl78gQNar5j9Hy7t9m+atGGPqgG7cWH7/lE3R0YOhIyMeqp0G2uAqmMCaZagqoWV81GZSAQXSOr0DRfbD5QGnYmS5Ww6nyZI+JqOA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98111b50-ebba-4b9d-ecf7-08dd5459e47d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2025 22:32:02.1520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ht2urlHt5aEyz5yX8zoLg1tdh1H83o5RnrwBl4mpbInqWKFcQxcOzVsk8kP+L/ux0gpmfuaDJ91l5OmPGX7bIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4348
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-23_10,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502230178
X-Proofpoint-ORIG-GUID: WFnegxHY9k56msjo7d_gRmB5_50Bi6-w
X-Proofpoint-GUID: WFnegxHY9k56msjo7d_gRmB5_50Bi6-w



On 21/2/25 23:03, Zorro Lang wrote:
> On Fri, Feb 21, 2025 at 12:04:32PM +0000, Filipe Manana wrote:
>> On Tue, Feb 18, 2025 at 10:36 PM Anand Jain <anand.jain@oracle.com> wrote:
>>>
>>> From: Qu Wenruo <wqu@suse.com>
>>>
>>> Update comments that were previously missed.
>>>
>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>> ---
>>>   tests/btrfs/226 | 6 ++----
>>>   1 file changed, 2 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/tests/btrfs/226 b/tests/btrfs/226
>>> index 359813c4f394..ce53b7d48c49 100755
>>> --- a/tests/btrfs/226
>>> +++ b/tests/btrfs/226
>>> @@ -22,10 +22,8 @@ _require_xfs_io_command fpunch
>>>
>>>   _scratch_mkfs >>$seqres.full 2>&1
>>>
>>> -# This test involves RWF_NOWAIT direct IOs, but for inodes with data checksum,
>>> -# btrfs will fall back to buffered IO unconditionally to prevent data checksum
>>> -# mimsatch, and that will break RWF_NOWAIT with -EAGAIN.
>>> -# So here we have to go with nodatasum mount option.
>>> +# RWF_NOWAIT works only with direct I/O and requires an inode with nodatasum
>>> +# to avoid checksum mismatches. Otherwise, it falls back to buffered I/O.
>>
>> Btw, this is different from what I suggested before here:
>>
>> https://lore.kernel.org/fstests/68aa436b-4ddd-4ee7-ad5a-8eca55aae176@oracle.com/T/#mb2369802d2e33c9778c62fcb3c0ee47de28b773b
>>
>> Which is:
>>
>> # RWF_NOWAIT only works with direct IO, which requires an inode with
>> nodatasum (otherwise it falls back to buffered IO).
>>
>> What is being added in this patch:
>>
>> +# RWF_NOWAIT works only with direct I/O and requires an inode with nodatasum
>> +# to avoid checksum mismatches. Otherwise, it falls back to buffered I/O.
>>
>> Is confusing because:
>>
>> 1) It gives the suggestion RWF_NOWAIT requires nodatasum.
>>
>> 2) The part that says "to avoid checksum mismatches", that's not
>> related to RWF_NOWAIT at all.
>>      That's the reason why direct IO writes against inodes without
>> nodatasum fallback to buffered IO.
>>      We don't have to explain that - this is not a test to exercise the
>> fallback after all, all we have to say
>>      is that RWF_NOWAIT needs direct IO and direct IO can only be done
>> against inodes with nodatasum.
>>
>> So you didn't pick my suggestion after all, you just added your own
>> rephrasing which IMO is confusing.
> 
> Hi Anand, please talk with Filipe (or more btrfs folks) and make a final
> decision about how to write this comment. I'll drop this patch from
> patches-in-queue branch temporarily, until you reach a consensus :)
> 

pls pull for-next. (force updated).

Thx. Anand

> Thanks,
> Zorro
> 
>>
>>
>>
>>>   _scratch_mount -o nodatasum
>>>
>>>   # Test a write against COW file/extent - should fail with -EAGAIN. Disable the
>>> --
>>> 2.47.0
>>>
>>>
>>
> 


