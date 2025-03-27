Return-Path: <linux-btrfs+bounces-12607-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D56A73665
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Mar 2025 17:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DF6A1764A6
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Mar 2025 16:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192DD19D882;
	Thu, 27 Mar 2025 16:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eCUwe/Qy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Czjm76bz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDC57E9;
	Thu, 27 Mar 2025 16:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743091881; cv=fail; b=qX2k30mDnH/1NdF/rUplgB7KVBom3s5OrZKakIDQmL/JcmVcQuosiSeF4rkiCTPbXRQw+tf+acUcBoVGEtvHXAxr42L2TsLtgRiU6wGruURV8BTifnSIhqEmOQMAe/uUEiK5b8OzDjO7GYKlTXGJ1Az7FRj8MGLaBh7PaOepuZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743091881; c=relaxed/simple;
	bh=jVAquyzFXx7CViqsWAcEn8z4rfmrtXw60l97jdew/5o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Uux7HvFzWcxCnznPJptfegjsrGFJfgAYx7E4/GlDBp1M/TCA5j/m0fSMDsdFK2KpupmFOtLhbw9IETDLicrM0yuPqZQXaLEWE3h43VHSTXE7pFMO21yBUZAqwRiizn496RFKREqrkRXFhNv1SyKef3lxhbqDLaLLmadLc56Fkr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eCUwe/Qy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Czjm76bz; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52RFfrI9025730;
	Thu, 27 Mar 2025 16:11:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=MSMcsD2IS60Cq3/msHDDGFN+GsnXJtLpMVtOBQ7aVwA=; b=
	eCUwe/Qytz47C2v1MBcQtBlFj6ORfD76Hrmju2dOaN3JWE4n2qTCUaph/UzBxuI5
	lZQZbBf7eJ8bEouhgLOy5y6zJEudfF+Nn3M5pXu3Fy0lQuysYKE6Qn8RRK9zeFlh
	SVNOHugVlo3jVnhLfF4plX1BK9xWv7G5TuwYcsRWbubMUbPhA5E69qI198HEofzg
	9RmQCMb2CQGVecfn0bSOE2pjXS8H7tS6FPoq7zipADhzboCS6W52w7xBy9EB6UGl
	A0ncilgz3b2+9SPYpzBM5mPlsUnmZjZEeQ/Jd4mnC8tdY4GOx71XYUjo2sBv5AL7
	2xwepGeU0TWU1G5aUszMcg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45hnrsn5b2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Mar 2025 16:11:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52REpTij029908;
	Thu, 27 Mar 2025 16:11:07 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45jjc409f5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Mar 2025 16:11:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vz8BZG4ReG3rNN2HzGOd6Swsniz6UzYYCTN6uJnDE0liYimOpMK48lOxRTBU+Olg4oZiE0QMxgBxD+87fTFAuOJIgTsaEahtbNrTCeVSPVEoJd7V8h7bnI+gAJV+4Tgobp0cmCc4d5BX+Gr5v3KLYFW+RBguM6aYDNw2ZIoFlytC+/8ld/K9d8QQKvo3DEu1MyTuM4aoku0BeboRKXIybm57aO0eQJjGMROc/CxHg8PMxxbpeG6HuU1iHM8vs025FzFwals+v/FBT4CfN3kK4bYYigwrhbR8Z1OBYwVyXSeW74/VpQU4ddYS90fL9k0d7PJDzyoNRcvoSlAFVSvCsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MSMcsD2IS60Cq3/msHDDGFN+GsnXJtLpMVtOBQ7aVwA=;
 b=LT+Q5oU9YI0MCnU8YL0ED24zA650dg0v2hI2T9QRJLiLKDUGOg7rPhXeV4dDqMyGfdaifMKhOTiPeHOLGjnMIctlWTdnnLqIf4TNnk0XE4nRmmgNqMJS2ozs7UpcYl9r9dyb8KYSZhhqprudHXc7m5NUoaVKw/fKl5ZdEm1Klb/ArdXe4e4ZzrM72+MmYLsihF89Yvrp3nzRs0yUrSs/5ZQM4LUWVY63xMjT8raaitrYCt6Q7g0ZSjr6wzt5UZ/65mZrHB0rvgTlYqvhzjKz/l67/UaqAhpXUVlgAHW1Z+/4Mi29wSDS025nlYTD0wFTZX2e/F9xr4kr5kHxHieoAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MSMcsD2IS60Cq3/msHDDGFN+GsnXJtLpMVtOBQ7aVwA=;
 b=Czjm76bzpUI0sPZRD30amztkgO9TmnIzNRzNxwl3ljwicASx7xs9HjNafdoGM2ZVnrnDyWQlPrfV4UBNDOGcDqdzscKMSy5SJAHGosKtAuomeMoHNa8Ph9atf3haMJWyTFoVIBQn4f5phyNfsec6K0PBVqAVzvsJ5RXDi3/RQrM=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA1PR10MB6344.namprd10.prod.outlook.com (2603:10b6:806:257::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 16:11:04 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 16:11:04 +0000
Message-ID: <d6b2158c-afde-4b4c-9ec4-44b38c0ddade@oracle.com>
Date: Fri, 28 Mar 2025 00:11:00 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] fstests: btrfs: zoned: verify RAID conversion with
 write pointer mismatch
To: Naohiro Aota <Naohiro.Aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>,
        Zorro Lang <zlang@redhat.com>, Filipe Manana <fdmanana@suse.com>
Cc: "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
References: <8390a7748c1e2005fb7b9dbc1f5e6bd38ea22506.1742382386.git.jth@kernel.org>
 <D8Q8M54FIFKG.34J9M1WWISFNR@wdc.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <D8Q8M54FIFKG.34J9M1WWISFNR@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0013.apcprd06.prod.outlook.com
 (2603:1096:4:186::18) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA1PR10MB6344:EE_
X-MS-Office365-Filtering-Correlation-Id: 57a7ec2b-52ad-4b18-b14f-08dd6d49f96a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UTJESTR2OWlNMmxHbCtPMlJGTnlSa2tNRytBdjBDcTNCYU1nU29ya25DYlhy?=
 =?utf-8?B?ZWxOMW9XT1pQczRxRk9EN3lobXdPM1JRbCtQeGVxd1ZqWFFYQUpEZlljb0M1?=
 =?utf-8?B?OHhCUWJyUGdKTFc3WXcxMDN4dFpNeGdWN0NKcDRiMDRhbEpnWlBvS2w2b082?=
 =?utf-8?B?WHMybGZlQ1N4T3A3MmdJSlgzdnZxVHRISExSQW5hQmxEMWk3a0g0OWRiWisy?=
 =?utf-8?B?U01VblNEaDl0eVhCcmYyZ3ZkSHRncEJLT1p4ak13VEVScFJJNEs2dHdYQS9M?=
 =?utf-8?B?VGkyY2pISFdsM1Rxclkwb1hFYU5GUUFMbHVhbFNEZngzb2FKakltWmFYQWFX?=
 =?utf-8?B?OFRKMFBSOE1WdTQ2K3RYTW04MVh1cUhpMGMwM2VuSE8wNUlHQ0tUaHdwQm9S?=
 =?utf-8?B?bnhIUDRsWnRhUS96b0F2VWdrNjZsNUpxR2VFa0pEQ2xtR2JzNEZKSGU3RVpj?=
 =?utf-8?B?OS9wMGVFMGlsaWJnM2tXaWxCcHNmR2l3Rm1qU3RQdTAzcUdjdFlLUUlCSnJR?=
 =?utf-8?B?QnhUNm5CQldPNzd1N3FRMU9kdzRaNFllR1pmS0pqNnVocnIvRW9pM216c2ds?=
 =?utf-8?B?MVMvZm9tMGt3Q0lhdklhSWVMSWVwWlEray9zZ1g4SmwxOGNPbDcrMjgyRUlE?=
 =?utf-8?B?VFdCNzczdUxoK0l6QmQ5RVA2aDdHaEFPOWJBRGRkYmorSW5OS1NRTDZDNHN0?=
 =?utf-8?B?RlBuWDVSTWlaVUNycE4vZlZaVjg4ZHFzVFEvdTR5ZkhHYVRnL1Fod3lVclE0?=
 =?utf-8?B?UjNZV3llMlduM2tyZDVBOHJVR0x5K0FuZUk5OFROMUZ6dVZpb3JJclkwdGxL?=
 =?utf-8?B?dDhmaU1CNC9FUnkwam1OT09rdFk2dFh2MWtvbEtDMVQ4SWRpUW9xV1pSaHN1?=
 =?utf-8?B?cUMvNk9lek94VWFrZEZ6OGE2elgxRG1IRGl5eEVVVUkvMERnNUE4M0dEcGFI?=
 =?utf-8?B?MllhUkYzSmUyaDZYb1F2NEJYdWpibDQralFKTkRNSTVGdU53ZTluYTVqaTNu?=
 =?utf-8?B?SDdBdHkvU2NyL0ErQWMreGo3ZGpVZkVCTEF6ZE8xOFdlaFRBaVpUd0VWa2ha?=
 =?utf-8?B?YkpjaGs2Z044NHBQenQzcXlnZmFJQnF4REFwL2ZJVnFHYkdZVm0yc1VvM01q?=
 =?utf-8?B?QXQxZjN6WTJiLzJFUmtCdHlHZTNsMThSYTF5RWhGeWJGTU5kSENzcnFEM1pu?=
 =?utf-8?B?RFBxYlN6eGpIcEh5cWlyWGpRVHlRcVNBVjY4UUNOU0xId05BUDF1UlZ2UEtU?=
 =?utf-8?B?TWk0QW5ocjdSMFNPcUpsdWZMOHhaL2JqcWdreDcybFhvTjlsYkpiWm5YbmFD?=
 =?utf-8?B?NEZMM0VnVUYyazlPTzdBVWRhSEM0VFQvRHMwYVRYbm1aTjNLZmp4N2ZPZXBp?=
 =?utf-8?B?MEJtYlRqVzJNZkg2cjlLaFNhdkR2cmpBRVExaUY0NllsQ2xuVWdkejUrWVZv?=
 =?utf-8?B?Qk1KcElONzd4c3h1R3pnT01vVU5xMWE1Q3JocVhTb2hGNE03UEwwSk0xRjR1?=
 =?utf-8?B?TWhJN0dEdVg3VWhQTnBrblpCQjd0b3Y3ZFphWFVkV1RFMEN6aWd6c1ZOSVB5?=
 =?utf-8?B?NFQzeG95TFVKVnVIWFpVcTMxeXdTNDJUSXZ6RlVpUkJveE00d3BGUytuVmZJ?=
 =?utf-8?B?QVFvSkxhZmlhZ2o4QU0yZkMzMitvT0E1YjNiVDFsKzRrVHJmcnBxa0w4S2k4?=
 =?utf-8?B?czkvZnlIODFMSXZCN0VVcmRNNk9RWTRHQlRLMENjeThJV3lpcFhJd1UzY2Zq?=
 =?utf-8?B?LzlMMGZaSmRQVkpwSGlqbGFIMDR5aFVmVWYxOENLWXBIWFVOVjVMbVZwdWl0?=
 =?utf-8?B?by96THljRGtUUWNRV3l3MGMvYk95WW5jMG9PbFU1RUZydmI0RFZCc29Qalov?=
 =?utf-8?Q?Py23rx/BOEuZi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V1ZHWHVtaitRa2hHRTJuZDl0NmVLWkYweHRHN3lzRHZtVkdJcTVTSGRUMmNQ?=
 =?utf-8?B?TWVlTFhod0NEU0FhOFkwVk5PZVRkbVNZSFQ1RWRjV1VCZG5jazR6d1RRQzk5?=
 =?utf-8?B?aDkzbFJ6dFM0S1BrVG92eGtqUE1tV29lZjFGWitodFhGTlRGK0xReXpKbC9k?=
 =?utf-8?B?N3BicUxaVUhzWE5TMDlUKzBCcXVKU3hxN1VsU29OZHFNUktqQ2d0YTFXd0VB?=
 =?utf-8?B?d1QyUmZZYU9TZ2lPTHBiLzRoWmJUOU8xbnRwMnNFc3JNS2xhVHllb015ZlBl?=
 =?utf-8?B?TjlPT05XY1EvcUx6RGl5N3hYN2F3OW52Z2lsQ2UyVW5uMzNmcG9DU29kTXRU?=
 =?utf-8?B?QXBtQ0VjK3Q0aWhEN0JkRmQ2bm5mUFNOdGF1VEltNTE3TFNEdUhhR1FwRldK?=
 =?utf-8?B?UzM0L3cvVzRsTEozcXgxa09Ha3B1VkRPWXFqK0crQUZSRW11VUhLd3ZLSERC?=
 =?utf-8?B?c2VoTkVDdWNpcy9sYWZ1U0lCejZwTDA4VUg3OTFLeHpSaVI4UFJ6VDlUN0xr?=
 =?utf-8?B?b1ltTXZnTkRkWldNdi9yWURVKzRyMlR0K0JlTmx1Ukw5U1daS1FEN1ZLSDZ6?=
 =?utf-8?B?K2Ftbll4M0QySy90QlI3eXE3TWl5TVpHSGdMNElXelZKTXg2aFBPRHA1TEtD?=
 =?utf-8?B?aDdaYnMrWFVBK2Z1NER2OUlMeExwa2ZWQkx5TkxVWDZzZmVuY0Z0amx4M3I3?=
 =?utf-8?B?emlQQThSclF4T2xDQTJ4SHBzR2t1NytwMFg4WU5QNjZoMjZkdTNYaU5idGla?=
 =?utf-8?B?QThFOFNIaTAraHpSbWRnRGc5MWJuZXNURlBSR0pzcFFqeVZybzM3QW9vV3h0?=
 =?utf-8?B?dmNiUW1oWDNWUDhPc2s2MGRpcDVISUdTM2hZODZVM0M1cDZIcWVDYVhNaDY1?=
 =?utf-8?B?MlBVMXdtWkx0WnUweEhKT1pJN2wvaENzTkEyMVNVN3ErVWJDTlp1Y1FxK0ZF?=
 =?utf-8?B?NU1aQXRYSVNMTitLa0tnNVlvS09Qayt5ZFIwU2RKVmhuRUlGRzl3UnA5ekU3?=
 =?utf-8?B?RDFHUXY2d1hUaUhHNXpHTEFSdzNyeXpkMFI3SlB4ZHZiRmcweS9veVU3K2pE?=
 =?utf-8?B?cE5TUzFTNE81ZHg3czdtQjQyakg3b2xsVG9RTVFRM0tXWFhUQWNpUGdKVTdS?=
 =?utf-8?B?ZStCWjI2SlFPTUJSbkhCT2pmNXIxWHlXbUhEUkZsNXNOaG4wRlJqenJGMXph?=
 =?utf-8?B?QStGRnhkN1hCZkVtOGlNTmV1RDV0cDNyY0VOTmdybFBlMHB3dDAxMU9nK2Fk?=
 =?utf-8?B?SXVkWndLdHdKYW4yRk5mZG9JaHp2QS8xWkwxNUU3MWZPeG9IZDJuUWpUVUlP?=
 =?utf-8?B?ZDdEZ0ttMWl3K2trVTFwWUtMYW1SNHoxTjhEd05QLzducFEzZFJqZXBoUU0x?=
 =?utf-8?B?bU1QZFhUTlhyaVYzN0piRjlvS2hNWWlsSUNCZGQ1U3hybW9TNFFSV1JncEFY?=
 =?utf-8?B?SVUwcG1PbXU1aFcxY09zMitkYXpDY1JaejJ4cmNRVjJKUW8xdlR0UWlhTTFZ?=
 =?utf-8?B?a3h4NE1vaFltVHVKU3FmbFJhQzhHaVR1bzFrZEhORDUzTjNodHg3ME9RamdU?=
 =?utf-8?B?Sk55YWJoOTNBUW03OEZmZFd6T1Y1MVdXbDlDT3JFWGIvVnB2bHdjdzFTSjhO?=
 =?utf-8?B?U2Fyd01aTTBoMHg2L013L0gvRTJlVEt1Q2ZNdVdtRDBTZGlCMEhROThqSEIx?=
 =?utf-8?B?UlcyQm1QNis5Rkx5M2gySGdPaGZzdE9QZSswVWR5Uy8rT3VjMnIwNkUzTTU3?=
 =?utf-8?B?Y1BkQTRQbmNiOVdlUUVTRG9hZlJQclZEZU1mb214QVBvNmN2QVdIUjZIVW1N?=
 =?utf-8?B?N1NCdFlxb043RE82Tm5XbUxMVm0wZ2huT24waHNyRllRRlBBcW1sSG5jZ2xZ?=
 =?utf-8?B?Y0VNSzdya0c2RUcwTlorN3BaUlZreUNwalIwSnp0YXM0KzNFdXV0SGhzVFJY?=
 =?utf-8?B?R0JMUk5DQ2FqcldYejVCS25ORllYWVNXcE90d1oxRUZPTFlzZk1zWVFmNkV1?=
 =?utf-8?B?RUdqSGhZYnkxS2ZySUdaSkh5SnhxMHh0c25sTHpYMHliRlNNQ1NwenRoQWpF?=
 =?utf-8?B?enllMWZkODExb1g0NE43RXl3S2lqelI2TnI0ZFNtS0wvQ1ZlanpvV1pSTVRT?=
 =?utf-8?Q?rzOXrUg9mm7sQL0FpJjmu/Vxj?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wTSnGXgc3CLi6nBZM3x+yAT/Iy3tB9LXtONwfZUZdx1LtgM4/44SnKcj6Ke+TEBDcITYTvcwCUtnas2hy90lhDwiqbjOVnUmUevWAhLGaapBpOAlKW9srR/5wxwzWMaVAKmbrinJDyPz0pXWf+tUncRZozMzETIWDzovP+89dm2SJAjlkT3VrlhlBB0LDJBNEGmgBRPY0o42uXaMcP/HWErvKlNt2BSr3FpQhZPJvTPcoFfZTG4sXKht1oRduP2hpa+a54l+3/g+S6MeGGRrvv7oQDXByGem833mpHblpXSAknP0lFgJwoTGqx67wZ4YuOQi+LtjTagp5kLRQjnv5c/2KKKUoX1pZmpy5BkO/S2s0njUN8oFsLWRu796ZuVJgjaOtQF0q8qEN81NNGWc3wwUfUfOl5dT1lmlfUXhpcm8aDpnmsE2AlXHAouxuIFeY1t3Zj9/Eiyb5LNi2kDdlqj/GJp5yDz+zunNr3uT3hVKnZnHHeJLrS3lm/WeTG2z4lq6tXf99HtCdFzV6weIUDQco270dHzmlyv2jfZEfhCywZsxVeMFrlYrakOBm1GAuY/Q7rJ5C7MDCVFKdyF76hmtcMyjufart54HMhDqqXs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57a7ec2b-52ad-4b18-b14f-08dd6d49f96a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 16:11:04.4459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LK3P+f2z5z8Calms1zCINGQwRdiO1+RZXCPrp8zH0SYmN7SQ+heCgGO/CxQJ28oFEgYQd8/gRZli4QLD/y5jVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6344
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-27_02,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503270109
X-Proofpoint-GUID: IvPG7RYlmFkUe93qx_uyszhZsgWWlZTz
X-Proofpoint-ORIG-GUID: IvPG7RYlmFkUe93qx_uyszhZsgWWlZTz

On 26/3/25 21:39, Naohiro Aota wrote:
> On Wed Mar 19, 2025 at 7:09 AM EDT, Johannes Thumshirn wrote:
>> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>>
>> Recently we had a bug report about a kernel crash that happened when the
>> user was converting a filesystem to use RAID1 for metadata, but for some
>> reason the device's write pointers got out of sync.
>>
>> Test this scenario by manually injecting de-synchronized write pointer
>> positions and then running conversion to a metadata RAID1 filesystem.
>>
>> In the testcase also repair the broken filesystem and check if both system
>> and metadata block groups are back to the default 'DUP' profile
>> afterwards.
>>
>> Link: https://lore.kernel.org/linux-btrfs/CAB_b4sBhDe3tscz=duVyhc9hNE+gu=B8CrgLO152uMyanR8BEA@mail.gmail.com/
>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>> Reviewed-by: Filipe Manana <fdmanana@suse.com>
>> ---
>> Changes to v3:
>> - Limit number of dirtied zones to 64
>> Changes to v2:
>> - Filter SCRATCH_MNT in golden output
>> Changes to v1:
>> - Add test description
>> - Don't redirect stderr to $seqres.full
>> - Use xfs_io instead of dd
>> - Use $SCRATCH_MNT instead of hardcoded mount path
>> - Check that 1st balance command actually fails as it's supposed to
>> ---
>>   tests/btrfs/329     | 68 +++++++++++++++++++++++++++++++++++++++++++++
>>   tests/btrfs/329.out |  7 +++++
>>   2 files changed, 75 insertions(+)
>>   create mode 100755 tests/btrfs/329
>>   create mode 100644 tests/btrfs/329.out
>>
>> diff --git a/tests/btrfs/329 b/tests/btrfs/329
>> new file mode 100755
>> index 000000000000..24d34852db1f
>> --- /dev/null
>> +++ b/tests/btrfs/329
>> @@ -0,0 +1,68 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2025 Western Digital Corporation.  All Rights Reserved.
>> +#
>> +# FS QA Test 329
>> +#
>> +# Regression test for a kernel crash when converting a zoned BTRFS from
>> +# metadata DUP to RAID1 and one of the devices has a non 0 write pointer
>> +# position in the target zone.
>> +#
>> +. ./common/preamble
>> +_begin_fstest zone quick volume
>> +
>> +. ./common/filter
>> +
>> +_fixed_by_kernel_commit XXXXXXXXXXXX \
>> +	"btrfs: zoned: return EIO on RAID1 block group write pointer mismatch"
>> +
>> +_require_scratch_dev_pool 2
>> +declare -a devs="( $SCRATCH_DEV_POOL )"
>> +_require_zoned_device ${devs[0]}
>> +_require_zoned_device ${devs[1]}
>> +_require_command "$BLKZONE_PROG" blkzone
>> +
>> +_scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
>> +_scratch_mount
>> +
>> +# Write some data to the FS to dirty it
>> +$XFS_IO_PROG -fc "pwrite 0 128M" $SCRATCH_MNT/test | _filter_xfs_io
>> +
>> +# Add device two to the FS
>> +$BTRFS_UTIL_PROG device add ${devs[1]} $SCRATCH_MNT >> $seqres.full
>> +
>> +# Move write pointers of all empty zones by 4k to simulate write pointer
>> +# mismatch.
>> +
>> +nzones=$($BLKZONE_PROG report ${devs[1]} | wc -l)
>> +if [ $nzones -gt 64 ]; then
>> +	nzones=64
>> +fi
> 
> Nit: We can just do "nzones=64" as "head" just pass through all the line if the
> number of zone is less that.
> 

The `%nzones` variable can also be removed entirely.

diff --git a/tests/btrfs/329 b/tests/btrfs/329
index 24d34852db1f..1c9b95f350a6 100755
--- a/tests/btrfs/329
+++ b/tests/btrfs/329
@@ -33,14 +33,8 @@ $BTRFS_UTIL_PROG device add ${devs[1]} $SCRATCH_MNT 
 >> $seqres.full

  # Move write pointers of all empty zones by 4k to simulate write pointer
  # mismatch.
-
-nzones=$($BLKZONE_PROG report ${devs[1]} | wc -l)
-if [ $nzones -gt 64 ]; then
-       nzones=64
-fi
-
  zones=$($BLKZONE_PROG report ${devs[1]} | $AWK_PROG '/em/ { print $2 }' |\
-       sed 's/,//' | head -n $nzones)
+       sed 's/,//' | head -n 64)
  for zone in $zones;
  do
         # We have to ignore the output here, as a) we don't know the 
number of

> Other than that nit:
> 
> Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>

Added.

Thanks, Anand

> 
>> +
>> +zones=$($BLKZONE_PROG report ${devs[1]} | $AWK_PROG '/em/ { print $2 }' |\
>> +	sed 's/,//' | head -n $nzones)
>> +for zone in $zones;
>> +do
>> +	# We have to ignore the output here, as a) we don't know the number of
>> +	# zones that have dirtied and b) if we run over the maximal number of
>> +	# active zones, xfs_io will output errors, both we don't care.
>> +	$XFS_IO_PROG -fdc "pwrite $(($zone << 9)) 4096" ${devs[1]} > /dev/null 2>&1
>> +done
>> +
>> +# expected to fail
>> +$BTRFS_UTIL_PROG balance start -mconvert=raid1 $SCRATCH_MNT 2>&1 |\
>> +	_filter_scratch
>> +
>> +_scratch_unmount
>> +
>> +$MOUNT_PROG -t btrfs -odegraded ${devs[0]} $SCRATCH_MNT
>> +
>> +$BTRFS_UTIL_PROG device remove --force missing $SCRATCH_MNT >> $seqres.full
>> +$BTRFS_UTIL_PROG balance start --full-balance $SCRATCH_MNT >> $seqres.full
>> +
>> +# Check that both System and Metadata are back to the DUP profile
>> +$BTRFS_UTIL_PROG filesystem df $SCRATCH_MNT |\
>> +	grep -o -e "System, DUP" -e "Metadata, DUP"
>> +
>> +status=0
>> +exit
>> diff --git a/tests/btrfs/329.out b/tests/btrfs/329.out
>> new file mode 100644
>> index 000000000000..e47a2a6ff04b
>> --- /dev/null
>> +++ b/tests/btrfs/329.out
>> @@ -0,0 +1,7 @@
>> +QA output created by 329
>> +wrote 134217728/134217728 bytes at offset 0
>> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> +ERROR: error during balancing 'SCRATCH_MNT': Input/output error
>> +There may be more info in syslog - try dmesg | tail
>> +System, DUP
>> +Metadata, DUP


