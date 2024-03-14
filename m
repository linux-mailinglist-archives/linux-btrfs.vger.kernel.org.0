Return-Path: <linux-btrfs+bounces-3286-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D9E87BD29
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 14:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA5011C2172D
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 13:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944DD5A104;
	Thu, 14 Mar 2024 13:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aNzmgVjB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VSivaBUm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDACC59B6E
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Mar 2024 13:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710421207; cv=fail; b=atSJTc8cHDUHRGFFeK/q5cz964p5ZwAKQr+7Q5KyG7M/z92E/P6IWUET4lFNKDdT2eMu06uVP1NO2Ofc4f9Up1H034fxe+ffNyBo8K0vxUUfLOpXtddqJMTGrFntjfxxQ/wOZQFdwEHm3fBZbVoyfw+In/l7qxhbHOXDf5HcG/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710421207; c=relaxed/simple;
	bh=iFR3Ygt5hPmTonAVr3LiSiEKDrLIQ71xKkPHayxH5/U=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Db25gE8ClI0vmUuwy3dzU3LuJcFzvEcGrhuENmHrXP+ApbOSZ1Lh5I+I0MuqwCl23BPtWX/3JIIpiVux77hcxbmHQpyG99HJM79tKrU9k64HqaohQJv+uaVdnValUe2Mj5idqIJqMqH8dU1NNVm32gqDEi7ebDx3onMwF+LJ238=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aNzmgVjB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VSivaBUm; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42ECLaT6020271;
	Thu, 14 Mar 2024 13:00:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=0fuS6o2iuuK5NbFJ5ve+KQf3N5G6cSCnZGTBjEHGO/w=;
 b=aNzmgVjBx0S12R3a0DGCzvrW62qk4NTJkZknCSOaHPFvAzcvAyF0lhKSVVEscLTUMYpN
 8KUzGnE2SG0Ew7A4C/4iZQO0rMptrSap6+iUqVph23yqWuwA8eR2u8XFjVo50xcHd9s9
 BMZC+k3+t2FN30+pv95AYpPUpJvzxeiUO2M8C5Y7v8Talj3Ku5fhl3GfMg2p94qsUUu/
 E+hxoZVUCLdeLtqZRSP3LRHyhfA+1zaroavX4YQFCCk/SpYz/sWhs8tC5F6QHjLU1Bm+
 pdAbGoZKuRT+/Co0bF0p0Z18Nk8AxK7ZcBDTuq2BS1DBhhhHLRfI5Ga1vQhCr54cnrEV Cw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wv0abg5hb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Mar 2024 13:00:01 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42EBVOOu037319;
	Thu, 14 Mar 2024 12:59:59 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wre7ac61d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Mar 2024 12:59:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wv/K0kMIjf6vxYodx8EideJDjpr/gyNcmBOqzQfPqbbkp91mRmABTlTXiWne8lDveRShSL2rHEou0yQUyCDbdmJZNOT7niyPCersoWUPb2qIbrBSqq9dYpGMXUPkjdiykvtRcPCj+n3JysqVtDvkqe156OYI0bUTk9KYZQ23FNX3K82TvPEZZkgwlVlucyC1khOjgTWuiJqKxihCWtt7UotOJ7r1JXNU4AbEvJyBKjdXUw7MpTE6l3LxC/EoiYrgea8Hzr3jeqt51lDLLkscW0SMFKSUJ5acU/yR+4oN6ysUXuaA1uK9RAYfXG6x1OBZ3hZUYhuYq3cf5FO8NlJwoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0fuS6o2iuuK5NbFJ5ve+KQf3N5G6cSCnZGTBjEHGO/w=;
 b=FQjgRrVMetqxKWqyjHB1ja/lqOmJivXibsJHyxb0wG0Qu88thcBaUNwkNP95nmIsZhFHGaPS6GYcZ6uaes91l9N52Irak5vmaR263qPTcxE9H/qR6H8I1DFMVvUvQOS9vKZAbaoC7w8pAtVL8XbJQqtfitEQ6jJnR4tyfNog0bpOVJf6jsPganCFsiJylMXfQNGx+Be3zWANRSOrkVIXuf5FbyNj4s2oFrOXHTsF+ERCkvj4ezShwLN0mrkQcyMGqfYm+MovExVmDG5/f6VjIX3xYG074VaK2zlE2Ncyn6JkBUpwaon+jQGg++D0rHF3v0I7qvzlCN3gNJmvUS8sAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0fuS6o2iuuK5NbFJ5ve+KQf3N5G6cSCnZGTBjEHGO/w=;
 b=VSivaBUmSRK7sMdB4u79ItZgOZ0m0AWoDlGTOROpQO4wrR9XwAGSohNCbzZsCE5P5/+phsL+oj01oYovAqLgN65yte95pQ2ndg/WHErX3NHDlTUcxyRH/ge4i6YAOD7/ao4a/ExdCg6QycQjUZcnFrua/ap6xrtXFVm4PwetZ6I=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA2PR10MB4745.namprd10.prod.outlook.com (2603:10b6:806:11b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.21; Thu, 14 Mar
 2024 12:59:57 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7362.035; Thu, 14 Mar 2024
 12:59:56 +0000
Message-ID: <2490b05b-6367-4adc-91ec-b5489cf04edf@oracle.com>
Date: Thu, 14 Mar 2024 18:29:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] btrfs: fix extent map leak in unexpected scenario
 at unpin_extent_cache()
Content-Language: en-US
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1710350741.git.fdmanana@suse.com>
 <f3c7f68caa8f3568fbf2d561b35604823bb5985f.1710350741.git.fdmanana@suse.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <f3c7f68caa8f3568fbf2d561b35604823bb5985f.1710350741.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXPR01CA0100.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::18) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA2PR10MB4745:EE_
X-MS-Office365-Filtering-Correlation-Id: 44ec1620-50f3-4231-fb4c-08dc4426a5af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	oitIXOOq1c366l20aSZx9qPjDjdT/IjCknfC4UeHq4TpjnyXD7soWRhmn3UR2YlEQZVD8t0i1q+uhn5EPelkWGnLPsDQcaQW0kEIV642LceeIjHdqiGdIM30m5kXvjUQalbdRb0StsR3StrWWGFfbQEzsXka6UlUFtHWFyQJ60L/5LfZdAjTxnzi5kLtJLmTYyks4U6B2oj0cBnF0g8uHqeKHfA6Lv0HgJUQaD4briQlkL690MHYx20qEHNxd0+zYePOerNLe9No2HEnClmv26JciJ4KrbqddwrC8vPukZDbt8BprUCIt/dHtTjKkF9Cg3YosJKv3bAcUlmEsb2cfONKcjsFUfRklcGy+vR+N5XX5mnOEK98baeRCcU7RgSMaQ5csnHHqahDMf0IGRH50nVW+aT2OsWIu7m5rMMLzFBCez8NTCM0H9T0jt5SG/IYr7ytCXYRw57Af+0IrQY/QfU2ilozKCRIIYI+K35a02UMVbF8Mb5K3lGDLMc95AOn0fsUNHu94AdseM7gAT3M6T1U6KYfKu+JzpmxrS3icLMysWLgP0aFYb7Pv9m8A8PI2hKz3Eeg1HBW7uEHqGczzKaPTTtrSkTtI2Om8ImGWXMt9yMBKvdJ1/BYMqkw9LZLFMu7g7+ipbgbUPm1zx+jSG1v13P1kmreHo+hA8QZwgk=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YklIWmQyTWl3LzJOVjA2YmpUL1JnVFlmcXk2eE90cFZXb2RxZmoxVkJPaDZB?=
 =?utf-8?B?Q05aQnVZREg1WkhFUFhhWkRtRTBkaldMb0p2cGdnUFN0VW1tTXIrQnBRbXUv?=
 =?utf-8?B?VERFMEJrSTRpbG1ITEpab3prQThEckY5VDdyckIvVnVzd3FDL0tQWTBCT2FB?=
 =?utf-8?B?WFBqNnlqWk5KV1NWWDJJcE5SWVE5dWx5aVVlb0RlM0ptZ2JLMWRhcmpUWkYy?=
 =?utf-8?B?MU5tbXpjSVlsYlQ5RnA2cGtkUHU5QURTeVh2MjNPRFJhcjUvZnBOcXB1V0pw?=
 =?utf-8?B?UWVHTTg2S1J4UEhFZDNjRDdPeTczTUZlcU11dWpFZFdWelV5MlhOU0VnUVBV?=
 =?utf-8?B?YzBkV3NJK1FyQVp5SkVQcXo1N1lCY1VWL3hadXFjbnVlVFJpdlZUTjE5TENN?=
 =?utf-8?B?QmFFb3crNlhEWjY0Rzk4TGw3c25ublQwNUVBRWV4U21aTndlNXhxWkRGTVNG?=
 =?utf-8?B?cmg5R3FiRFlKY3krREp1UFZkQlZ6SDN4WFZ1dUgvWGlGZ2ZDQ3Y5VDNvKzZM?=
 =?utf-8?B?Vkw5c2prVlRFZEducEJXVzJhYUZFUEp2SmNFd2E2UXlMdnM2Z1l2Qi8vTWpU?=
 =?utf-8?B?SXlZZVQ1YUFiMmwyU3Vzd3J1QkQ2Y2gwdGdjN3diV25lOGtPQmdScXZuZTdy?=
 =?utf-8?B?UDdqVnRxbXUxbHFCTXIvcFhqSEJmR2Jhb3c2QXFQL296SitGbm1nbjdlMkFk?=
 =?utf-8?B?Uk93WDJaTS9scVdnVElvQUhWRm1SUmVQU3IxRGxCNkZ0KzZIdWpqSmMwOE9t?=
 =?utf-8?B?YWR6clJ0QXh3eGpjQWtVMk5wQm9BTUxVZU9qMXZNV1pra093YzJNVnZIOUVK?=
 =?utf-8?B?U2FxM0w5NzVDVFdOSG9pTXVOaVhFSDc2T2lYWFNoUkc0Y0grM1FOdHZqNVRV?=
 =?utf-8?B?MHBsRHo3bWtjQjl1cWxXaWcwTHA0OG9kbGlneWR4NTZ1K1g2bklQcUQrYXMx?=
 =?utf-8?B?cFFlYkdFakxVa01rL1RGSmUzWm0vQ3BZWHdXODl5UXZ4VUI0YVFiVTR4aVRZ?=
 =?utf-8?B?QlZWYUVodS84bUFHU0lEdFZzVEVEWmdvZDRmSkJLc2dyMTdWbkVsSlBjMURN?=
 =?utf-8?B?a0pxZnVuaE1ocDZDaVJveS9QYnU3aUVyeFIrOXBGbHFHdlJRb2FMOEFZOGNl?=
 =?utf-8?B?UVFKUjZRSmp2Y0dhbVNQK1dDU25ibWhCY0J1cnpXdmJQdnZDYXJkTXF3RFdG?=
 =?utf-8?B?ZEk1QWtLZlJlbEFlL1RnVENldkFrMXFCQWZlWXlLdDk2aWpSc2RTbW9kbUNQ?=
 =?utf-8?B?amlDem0vTWtuVlRuVitiRHZkT1BzbTFTTHU0c2lIS1I1cTNrUkFzd2l3NTVM?=
 =?utf-8?B?MUFMR2orMUw2cWN0V3pLY3lVZFVyejNQSnd3bFhwNVJSbEl6eWo3cGYyaGdQ?=
 =?utf-8?B?ajdhalcwM3I3MnJyOGFVZTZ2b043SGJjbUExeFF3aWZwcGVkbWRUVnh0Ykxr?=
 =?utf-8?B?TXdWY29QaTUweFp1ZGpRNUVPSVV5TDI0Vm8zc0lIdGNRc08rdGN1N21NNitZ?=
 =?utf-8?B?aUtIbkpuang3YWRUYU9peG5qdks2UlZNR2VqM1FSeEZKOFdlNTdvNlZhczA3?=
 =?utf-8?B?M0FXMFhjSkFTSHpKOFJLZTZZYzBjSnpscndYTWpjc2J2T2hjaEd3ZUFzcmNZ?=
 =?utf-8?B?UnpTVHhUWTR3NldaSmdLbG94NCtnYWJuREZ5MEk5YkNENjNYZFhpcU5BWE4r?=
 =?utf-8?B?cU9Db0tzcjFNWnZudUZtTHhYRzN1NThUWnBDdGZKTEo3cTRQTk9OTktoV2p4?=
 =?utf-8?B?RjFpa2FKcStDdExRMjdnbkNQaDFrQlZsblNEWGp4SEpRd3hMalFxanJjK2dn?=
 =?utf-8?B?empLTCtaY2NtZTFwcHdqYy9md0FaNVVzNFIwNVR3MHZKcWNHaDQrVGwwSkxW?=
 =?utf-8?B?bmxyVHlVNVJ3am10RWhYRHhSMmxmUllYd2VvS2tWZ09LVU5KOWNOWHFiNXE1?=
 =?utf-8?B?NEJRNnY5MHgvT0p0cEtra0laZ2tJSTV2bVIySzU4dzJ2OVVJMGNqS3RPZVpk?=
 =?utf-8?B?YmV3VEUyMDlUWC9ibTVPQldWMllLVEg0TkUxMzZRUHBzOVBUVDcvU2FGTjU0?=
 =?utf-8?B?QXZ1RjVQb3RGU1ZlNGZwVUg2MlhsRXc2OWduOEpHK3hMMHRVaTFmRnN1Q0xZ?=
 =?utf-8?Q?hDnn8lw8gYc8w8kXyE3U2Ah1m?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	PDDXdbzgBiEbbhv2m09bEaspqXB7e5Il2x3chDg6m4qFhq7QLPxoi5SCxfbh/W7HQ9Awjnprrk4GFWMsrrpXGEJB5I+zzVPxuBx8PTvU0K58tR6JIVttokrw/R4qUc1qBUH5OVJuI1OuQLP3aWmy3Pwn6wai+i/Ji3Z0H11+KGwxxi1k3teVnuDxf0Cb0iz/lD0iwsq/Jf2Y3FeoHxF6g5Fix4FlK7iyvY/1pEWEKbDkxRfrmmk3PlBaxW2K0i1f40RKZJ70OWJUJFnX638CKtjB0rmDdcNPMS5RLGNMj+tpGTEdK/Q/Y7F9bYssJZFgQgOZEW1kiLl8wRyCAhlvH4dRjTgDWAWJYxsbj+TmUGmon/8RnP7tbw/5uucyBBgQBSKi/8Hzn9nbpGL+go6fGO5yo0HTZ6xjHXj66AXfmATyevw1sxYyv+WW3N4X5JXUHMszBIW69LEG1WqJhD4Di5OF0jHAQWVinwAx1WR6I4Y4LUY/rhj/2P3mrY/Plis84+Kp7TzNVKKp6EYISljcspjDXME9nl4D3L803vv45e/7aZ6lMgt8P2MWJ4NKVkXgo57udoVc9p/9gr9S6Vo+eaTA93iPmIEptHSIcQO/Hzo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44ec1620-50f3-4231-fb4c-08dc4426a5af
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 12:59:56.2683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vq5m4uUI5paZIFGTbzOmADvWwqIsHHURk3/Y7VDwRHq+xxK04siQEXu3qNexQyWHxPyaFRYUCz/jwfZCXr91Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4745
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_11,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403140094
X-Proofpoint-GUID: TTUlI7fY4UapXEyubMYLLNWSkaDPglDv
X-Proofpoint-ORIG-GUID: TTUlI7fY4UapXEyubMYLLNWSkaDPglDv

On 3/13/24 22:58, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> At unpin_extent_cache() if we happen to find an extent map with an
> unexpected start offset, we jump to the 'out' label and never release the
> reference we added to the extent map through the call to
> lookup_extent_mapping(), therefore resulting in a leak. So fix this by
> moving the free_extent_map() under the 'out' label.
> 
> Fixes: c03c89f821e5 ("btrfs: handle errors returned from unpin_extent_cache()")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>   fs/btrfs/extent_map.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
> index 347ca13d15a9..e03953dbcd5e 100644
> --- a/fs/btrfs/extent_map.c
> +++ b/fs/btrfs/extent_map.c
> @@ -340,9 +340,9 @@ int unpin_extent_cache(struct btrfs_inode *inode, u64 start, u64 len, u64 gen)
>   		em->mod_len = em->len;
>   	}
>   
> -	free_extent_map(em);
>   out:
>   	write_unlock(&tree->lock);
> +	free_extent_map(em);
>   	return ret;
>   
>   }



Looks good.

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks, Anand


