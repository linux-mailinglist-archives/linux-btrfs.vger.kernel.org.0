Return-Path: <linux-btrfs+bounces-3807-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7C88938D8
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Apr 2024 10:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63308281BB5
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Apr 2024 08:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E34C148;
	Mon,  1 Apr 2024 08:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ocmkrg2y";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zaS6ZIs5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBF4BE62;
	Mon,  1 Apr 2024 08:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711959483; cv=fail; b=Q8pMx+t77lmYKAzccPsw8GYj5UPCW9uPX7vCdX3alpNUeDJF6o2k0aBNsBbLKUgWehm6vkzkTlomCDmAnTnPPHUyYH8HZ5VAZM7mtslnwOGkIfKuoHlCHWcjEVi6vRfADyjf8IekI1fy8EvwdMnDXvm7P+ZUm1vMNoiKWx2UqlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711959483; c=relaxed/simple;
	bh=IlNTVlk93eetEfWRxQTbhZiRPcC3GxES51ETwOuEq4s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cayI7CZp8RE2hCnJSF+ctn0HBd10Sgnc2aTl1NpswRj06o4bh17Pthfe5O7HAHAL0O50EtvSDb5UWNHQgfx+ww8XQYP3PKz/yKZigPXSE9BH5gk/tc0nnlo0hioXN/4rO2woipOHvkPmm3GgRc6YX/4/lZAlh4fnvcHeUHiz394=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ocmkrg2y; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zaS6ZIs5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42VMtXiE009074;
	Mon, 1 Apr 2024 08:17:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=IGqHP0XzZKoggfshD8Z/zOf6zGLyg9Qa/Md2BRpczIw=;
 b=ocmkrg2yKuClTZ/uVoZ1ubWgrI3tx+SmLn8UJ6AqhCjpAaLSxDAk+007NWv7QORoSN3Z
 LTY0SZPj9s3PzMCBynUIC3uKqFoa1F7+u6MZZQAUDVBJ7eaR563eENEn9K605/cxPMDz
 3Xb1Btpgjw4Rm5FnkTaUrEuoyn765vSNe9CJ6h5Xvo6hf063SOpLs7SddluoJ4P8I8zL
 eokjXIIxGzbgV2ypSMmOZafz16RZW4A9fotFZVO15NYsx/GhEqfv5hy/f2xdnaWzzTW7
 0cjM6slRYbfo7tWyYUNfoQ3xW2thQLpmZM9VSSnpv7lRoLYrEecOLpdo+ArX9HidwCow zg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x695ehwhj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Apr 2024 08:17:58 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43175c3j023188;
	Mon, 1 Apr 2024 08:17:57 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x696532em-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Apr 2024 08:17:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z6Gy7wH9zOhV4FK1YFqXnUwC19Xg3U1BooIj3E8PKw/NZnE/MluxT0KMkYDOiMN6kf+pXFBwxYu1BKjlAIb9+1v5aRt19UF0ifLUAyyJ20k4KeRwRk6ukIunGH7Tiq2w9GmEMk4EL+wnwtcAvVEw/CptP+a+i/chA2xES5fgiWfsNYOc2t+Eov185gcAdMfFAlYNOi57JLcfffH7NawVkdLH15icmbBmETTW+HCfX7wy8RCPNR6cj0s/om/ugWDpnUcLkFMU0Gg1cDgsQhAwxBdj47vUPGWXUtogGk6WdfLFFvstsJH8xTiivHC8ZvpA/qrpnA48sbS+LG6x9iaM/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IGqHP0XzZKoggfshD8Z/zOf6zGLyg9Qa/Md2BRpczIw=;
 b=ZRN03PCL1/eGssJ3n3jZNfflnNAlwZyXQuZPEnenWeSUMqzQAbroYkr67TUwS0NkMNwa3vvQuzm+nJZEyT9OFnb0CQmiunrqdAG+J34zrcMFYZ7J/1m3igYOLRl+1BnyuWcUBYIytfFKtmZEH+6zvAqRz5sVgfrZ3i27u7LC4PE+tLhPBAmmWJKMEM9A5UROQEZeATVzoBW3plKKZZ6j31YLzp6T0z3wnsTK4RcZhFMv5lNHp0+W5x7TMShh9xgM/K2UXpnC+ZQq6RbPLpmbntfYYZpUQi7xuqjDpWMwBCQyYWNeqc775aLTxrbPwRQnCO8xFxQTJuYt4VqtP5ixpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IGqHP0XzZKoggfshD8Z/zOf6zGLyg9Qa/Md2BRpczIw=;
 b=zaS6ZIs5XDZmplzoOGSaCmFMyKdlnv2JAOVWWIRpyc+0My4d3+0/faxSlAnkGypQh6izHEJ1b3CgF90fBHRlUOEwv2sjNmQunAUXiMY8P6CdJi5KGNUwA8vR8HrDd1qoATI/qErBdbxN8oRHZjbp5Romk0HvWaAaG0/3W9v/rtQ=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB5213.namprd10.prod.outlook.com (2603:10b6:5:3aa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 1 Apr
 2024 08:17:55 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7409.042; Mon, 1 Apr 2024
 08:17:55 +0000
Message-ID: <55848f52-86bd-41cb-8bf5-a521a6aa42d3@oracle.com>
Date: Mon, 1 Apr 2024 16:17:49 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] common/btrfs: lookup running processes using pgrep
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
References: <572b5b3f11cc414bd990d1580f8bf287f4797676.1711952124.git.anand.jain@oracle.com>
 <a21b3427-ae9f-42e3-a335-3fcb3c10e081@gmx.com>
 <1c581fa7-f481-48b8-8a55-fed0ea5ed38f@oracle.com>
 <0e32055d-f603-4de4-b354-b7a7e016953a@gmx.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <0e32055d-f603-4de4-b354-b7a7e016953a@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0051.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::6) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB5213:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	iCGHOMixcpKH302XQGdCeYSCF72LYtt9jsDZc24CpQgleyeaAcCrZxlDKqD+nnd9F8p1WgupUMJsrQS9mSw94bb8Ou2TAJ405O8SRrIx2JhEN/Z+CYWqJUr8FD3hgjb6s717yABts+NAyM1+vR04u3WE16qNlIPlSqc0HqdNdYHptNJViEZTpN2yGLCXltv3p+Ss2YZ/ZJgUhIPx/tlYBWM5kNpEnriDlMZajQLOnkFSupsb4BKM5Fe926rppOH1G6Rp+sHjyotREpV5Fc0/DeVjHIt4FD8KOEQgeWe4aKRbM0hGjAo7tjvi/X2kjFjRDlZghhOpd6hSJMsU9pYIlpGzpNXfW9K5/jMLpVhJXeCT3Cr6+3Uc1yLPQS3fJ+tLS6VWH42d5lk8OdKKGgqq4JCdUCXZ5tDpBuGjgUBZGs+A+It8AVA86heKdRb6DdV+kcWblAQKXJxyWmkbrIaEYL5r0Emhdq6I9UDcvZmh2iTYKCnvFT4H427QuVDEqAakMA1gn4/aAyOM3awT6kwGFSVj9vHkGnGGsSBDkcChQx/d6+2SsJc75+zowvh6eDIUOZ825Hbn6cqmOubQD5YuQDEXyzCKtc2GLtHpa9Zg6i8v3G7T4M0cVqXjEzGN43GFXTguVBp/2WwomM1Tk2diOLau4p1/U5hU+oG6n9d6CsQ=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YVBVTjNBUEkvWm5wUDVuWDZoK01nWm5uNm1lSE1TTGRxTTVCelVLOTdHS2t2?=
 =?utf-8?B?S0pwUStkWFhoNFZwQ2h0MkRKbkNQc01vOHhIbllSU2R3M1FkcjBiMVB4d1VD?=
 =?utf-8?B?TmY1d2NmaFF1NTE5YksrREVjc2poNzkybGxxaVZSZ1VTbGkrZW9HbUNHWkVn?=
 =?utf-8?B?QWFJZk04RXR0QmFEU3VOaGtjWUZIcW9KMTQyb2F1U0ZsZkU4MVIxOUYyZndp?=
 =?utf-8?B?M0hESnNGY0FTRktCbzNMUzZ5VXpOR1BldWFoYkU4NjRsYjY3VkZOc2p3M05N?=
 =?utf-8?B?dyt3TnU2Mm1LaFZQa0VvNS9DeXl1MzlMOTl5bk81VGtSdkpzb3lVeWdjRkVC?=
 =?utf-8?B?alVvSjV6UzdXcmZWUGxoL1BJRnVvTXNWRzV0OUk0VFFKcEFWZ1NmWFh0cVR6?=
 =?utf-8?B?QzJ5OXlkRzJFWDBwUzFNaUo3aVN2NGlHeHZxeWxmY3lyTGRrcmY5K1ZOaDdm?=
 =?utf-8?B?YmNUaC9UeEVLZUhZSWt5ZUFUNGFMRTNnS2xJZWZDUDRoQ01vQUcrMlFIb01L?=
 =?utf-8?B?WGlsSnMyZ2QyVGdKMUlvNzNjb1dyYzFpdXUyd05CWlNGUEF1ZGhaZkFVT0pD?=
 =?utf-8?B?UTBLNER2bzJCWEROTTdDUTVKam40THV3OE9EVVVud2pxM2dzeUl3TTZKdk5W?=
 =?utf-8?B?Z3l6Rmg5ZXJ0MTRvRW5WUFR1NEpKL0IvSnhDSUFRdW9ERkNlRXFzam43NG1h?=
 =?utf-8?B?Qm9rSUF6TE9Wdng5WFhVZXVOQnZXM01sL0d6VHdLeGdqZzRhODJDc056ekdU?=
 =?utf-8?B?bWJKcTNtNmE3TW5xMmMwRzljWHNXVm1ZTVh3ZGc4WjZSOGthTGdqTEhEMGdm?=
 =?utf-8?B?S0dUNmtzSzhzRlk0QnhGTjJSM0FPNjg4RGc3VlcwRnNGazdISTIzMkwxcHM0?=
 =?utf-8?B?VjVDamhHVXdpOWpYRkhQdlhVSHZRdEw4QUhRS0djM0JSVDJMVUJFWUtraFps?=
 =?utf-8?B?OGloRi9NNXk2cjVBZHZGUFE2VnlkaWNaUlkvdG1hOWd5QTFhWjM1c1NVajB4?=
 =?utf-8?B?VCtFYm4zTUpjeldEbnFxdmRZSU5vbEhTdVFFQU5ubnFudHdvVDlvSEs0Zkhp?=
 =?utf-8?B?emN4SzNldmQxbjRTU1crNEUrZ2FBbUtqK3dzbjY5dS9PWkRhUEUrTXJsZC9L?=
 =?utf-8?B?QUpnU2FVNWV2UllNVXk1MkdLbE82d0RmQWlZQUhLdUsvUmJKZVBya2dJZDVi?=
 =?utf-8?B?cjNCZUZjL0lmT3FMR1dmNTI4dWdBb3hsT2VHaU1JRHlIdXViWjVWS0hQck5V?=
 =?utf-8?B?V3BWWDltSzZLNE5objFJdVdtWlhveitlR0xTdU1mb05MR3Q5bG85emljQStK?=
 =?utf-8?B?bXRCVS9JTE0ybFQ3Z2tUWm9mM05WUXNwYm5mc0MwYlN5ZmRKY0VZTFh6K1Vx?=
 =?utf-8?B?TzBsSzBTUlRKcW9FUGh0WEVMZXlDVGV3VHh0VUhiUXdZSjlRdlN1NFJzNCt5?=
 =?utf-8?B?U21mM0t0ZU0vcGY2bzczZzhCYUY5NU9uZ2pVb1BLVnNGODI2cXBaYlZETXM4?=
 =?utf-8?B?VTVwaE0xeHhISTFwS09HWEdhd1lhY0ZPNGhPN0RFeXIyUmNZNi9pVnJWd1JL?=
 =?utf-8?B?Z0VHZmtDWnMrei81UW81Tmx5UTFsZFZxNUozYnFpZFAwdVo5QlpTR3dIYkRT?=
 =?utf-8?B?TDVGSTNyM2lEOTJUSFk0TFZ1VVlTczUvdFN5OFpjaWVJb29MK1I0bG0zNDFx?=
 =?utf-8?B?L203aHNnTkVCNnJPOXhrdHJmdGl2K3VrMEI0eDRhU3lWTVpGSlFMMFpteFFx?=
 =?utf-8?B?eHptZjVYTmtSS0dKN3pwZmZFMkltM0pzMlh4bXBBelZxWng5SWVLVFNBeDE5?=
 =?utf-8?B?dHlTTU5ZcUx4UXBUZ2xiWkgxeGFBdW5lZE1vUmgvdktnZXRlcXZxZ1NVaytx?=
 =?utf-8?B?VU4vN1luVHpTTlN3L0VxTmx6MEVETUdiZlNnR2lzUFRNaGZWcENSZkVySGRH?=
 =?utf-8?B?WGxtWHNRR0lNc1g3QVY3T0VrdTZoNUlKOGUyMVkxUi93NjlHY1laZUNuS3Av?=
 =?utf-8?B?TzV6U0ZZaHY3NU05cTdWdHFmdFRROEorclZwWlc4ZXhsYUxtZU8xMHFrYWVK?=
 =?utf-8?B?dERjYTY3aDFqaWNMeFFxSFl4RVJtek5acFNTZ3ZVcDZDcUQ4OGx6RVNUODNW?=
 =?utf-8?Q?mW8BVmmIOoGvSI79CgGKGcpSE?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	dhUtvcry3yWyEMXdzowwcVs6kvmPVHDAFwAGKMDbe5VYQ3OacYJ9E7EKARu34PpGHNO1629mfOKp8VCdjOwBL21uv1PGfp0MVPVLWz0gB0RLtRRrDVnu0UeV9MlfQrPzHUhejy1+GPtuptAWrQfG8UXtjZI7q0qS/3Rha9C3gjxRocrVQlpX8H9OnkuwLQ2O0rFDU2g8n0MbxhVUeuYG+4tdBCBmPFtvZtRize9lyydunPkzRSn2z3Z5DEP2msKG2JrsNAdPHs0M/U3gyNibZkwLNzaxoHs8hYYjWLX5zxZP0lbmTRANH32M3oPWJ+HP4PHMqDInqerJNOK+YqRGmZQUKZAHrvpEWCPMNvwfzz1/lhIAiek/rDpqtfOnGgXc7vA0A5DGMJCEdZBc/wQF5XmzHu/v9xPvzs1sRvltGhxch4d664o6Ksgk+X4PmeSnXktl6+ax2nT2GnZKG9T1kRpQrsmkGkJRQUxTsDEj3/DHpdZ5GmrZ6V/yTbjf2XvDtstLmW7JCI8+Gvxp4XqV+ZkTMTBtNOloVyyDU2q6FmDvmax1GOkZMNSQLgf1wNaNXip31IuyrYVrMo48Iz2YtrWVXMBCRBqt23g/hle7dHo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c33f323c-c963-46bd-1013-08dc52243bbd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 08:17:55.7228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XFpBdDgiufNffzNfUTEdWDmOlP4judM6sdMGhjcEFTM5ePA27mlsXrRdd2a+T5kq8lCkbKCEXlCvECEZ/Qkgew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5213
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-01_05,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 spamscore=0 suspectscore=0 phishscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2404010058
X-Proofpoint-GUID: K5k_cFrqixn1Y7MRm5vPJDZB6LNXsvUd
X-Proofpoint-ORIG-GUID: K5k_cFrqixn1Y7MRm5vPJDZB6LNXsvUd



On 4/1/24 15:51, Qu Wenruo wrote:
> 
> 
> 在 2024/4/1 18:10, Anand Jain 写道:
>>
>>
>> On 4/1/24 14:21, Qu Wenruo wrote:
>>>
>>>
>>> 在 2024/4/1 16:46, Anand Jain 写道:
>>>> Certain helper functions and the testcase btrfs/132 use the following
>>>> script to find running processes:
>>>>
>>>>     while ps aux | grep "balance start" | grep -qv grep; do
>>>>     <>
>>>>     done
>>>>
>>>> Instead, using pgrep is more efficient.
>>>>
>>>>     while pgrep -f "btrfs balance start" > /dev/null; do
>>>>     <>
>>>>     done
>>>>
>>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>>
>>> Looks good to me.
>>>
>>> Although there are already several test cases utilizing pgrep, I'm not
>>> 100% sure if pgrep would exist for all systems.
>>>
>>> Shouldn't there be some checks first?
>>>
>>
>>
>> Actually, I checked on that and noticed that pgrep comes from
>> the same package as ps. So we are fine.
>>
>>   $ rpm -ql procps-ng | grep -E "bin/pgrep|bin/ps"
>>   /usr/bin/pgrep
>>   /usr/bin/ps
>>
>> Thanks, Anand
> 
> So I guess busybox based system won't be supported anyway for fstests?
> 

  There aren't quite a lot of tools required for fstests in BusyBox.
  pgrep is not new in fstests, as you noticed, so not introducing
  a new failures, so for now, it should be okay.

Thanks, Anand

> In that case it looks fine to me.
> 
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> 
> Thanks,
> Qu
>>
>>
>>> Thanks,
>>> Qu
>>>> ---
>>>>   common/btrfs    | 10 +++++-----
>>>>   tests/btrfs/132 |  2 +-
>>>>   2 files changed, 6 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/common/btrfs b/common/btrfs
>>>> index 2c086227d8e0..a320b0e41d0d 100644
>>>> --- a/common/btrfs
>>>> +++ b/common/btrfs
>>>> @@ -327,7 +327,7 @@ _btrfs_kill_stress_balance_pid()
>>>>       kill $balance_pid &> /dev/null
>>>>       wait $balance_pid &> /dev/null
>>>>       # Wait for the balance operation to finish.
>>>> -    while ps aux | grep "balance start" | grep -qv grep; do
>>>> +    while pgrep -f "btrfs balance start" > /dev/null; do
>>>>           sleep 1
>>>>       done
>>>>   }
>>>> @@ -381,7 +381,7 @@ _btrfs_kill_stress_scrub_pid()
>>>>          kill $scrub_pid &> /dev/null
>>>>          wait $scrub_pid &> /dev/null
>>>>          # Wait for the scrub operation to finish.
>>>> -       while ps aux | grep "scrub start" | grep -qv grep; do
>>>> +       while pgrep -f "btrfs scrub start" > /dev/null; do
>>>>                  sleep 1
>>>>          done
>>>>   }
>>>> @@ -415,7 +415,7 @@ _btrfs_kill_stress_defrag_pid()
>>>>          kill $defrag_pid &> /dev/null
>>>>          wait $defrag_pid &> /dev/null
>>>>          # Wait for the defrag operation to finish.
>>>> -       while ps aux | grep "btrfs filesystem defrag" | grep -qv
>>>> grep; do
>>>> +       while pgrep -f "btrfs filesystem defrag" > /dev/null; do
>>>>                  sleep 1
>>>>          done
>>>>   }
>>>> @@ -444,7 +444,7 @@ _btrfs_kill_stress_remount_compress_pid()
>>>>       kill $remount_pid &> /dev/null
>>>>       wait $remount_pid &> /dev/null
>>>>       # Wait for the remount loop to finish.
>>>> -    while ps aux | grep "mount.*${btrfs_mnt}" | grep -qv grep; do
>>>> +    while pgrep -f "mount.*${btrfs_mnt}" > /dev/null; do
>>>>           sleep 1
>>>>       done
>>>>   }
>>>> @@ -507,7 +507,7 @@ _btrfs_kill_stress_replace_pid()
>>>>          kill $replace_pid &> /dev/null
>>>>          wait $replace_pid &> /dev/null
>>>>          # Wait for the replace operation to finish.
>>>> -       while ps aux | grep "replace start" | grep -qv grep; do
>>>> +       while pgrep -f "btrfs replace start" > /dev/null; do
>>>>                  sleep 1
>>>>          done
>>>>   }
>>>> diff --git a/tests/btrfs/132 b/tests/btrfs/132
>>>> index f50420f51181..b48395c1884f 100755
>>>> --- a/tests/btrfs/132
>>>> +++ b/tests/btrfs/132
>>>> @@ -70,7 +70,7 @@ kill $pids
>>>>   wait
>>>>
>>>>   # Wait all writers really exits
>>>> -while ps aux | grep "$SCRATCH_MNT" | grep -qv grep; do
>>>> +while pgrep -f "$SCRATCH_MNT" > /dev/null; do
>>>>       sleep 1
>>>>   done
>>>>
>>

