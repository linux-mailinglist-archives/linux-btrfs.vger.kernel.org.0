Return-Path: <linux-btrfs+bounces-6437-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B9F9302F2
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Jul 2024 03:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DABD01C216B0
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Jul 2024 01:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59BC9DDC3;
	Sat, 13 Jul 2024 01:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ip2n6sDZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wsDo1wpe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A7C8BE0;
	Sat, 13 Jul 2024 01:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720833107; cv=fail; b=OV6hTfazcrD7ndVa8evp5t2QkAtu81F9Lgo7btGZxWiHkcapq7dJl6HOZQpTWZsV+wxqXEEnc3Tq+pnu2aHCsxQXGS0zJ9Ns1Et8h1Mn5RCLAENNT5fFtJgyeEZviUAbgh0xfwg0xvr/uM1/bJ8AlcJ6pg5vvwp4seKK0LtprL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720833107; c=relaxed/simple;
	bh=6XYUtOdcQJ8AU9+E7h/pMwFJ5KrB1bDZqFCmmvD3Mao=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hiVx5TJXgVFzJ9RRBmG6TWVMde8AoUhjvmpI6DlU5xkGA8Yp/FYB94YtMi5vLnTNCAPt0KAsNx7uagD2V9hSjsu5JFCJkAKR5VabND/cMyfzaEnrLRUAqfqx5B6aiHNOZvwFB+FNo04h5FfftcsnjgaNq5t9zuoEXaUXW+op8a4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ip2n6sDZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wsDo1wpe; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46CNqGna010456;
	Sat, 13 Jul 2024 01:11:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=UwnRQ9OfBWM7tpJ++njTvoSooplkJLYlP/SuwsWKaCQ=; b=
	Ip2n6sDZbjk+aeB00u36MSsENe5Ql01GNOga7xTv/EbEPU6uX03ina8iOlcOURfW
	gW223wdf4PTefGuMpaKgNWtHDpaXgMNqNWpzHf62wRYD3JYxj9m6IoTfEEdyKHgL
	goaHA0Cxa/udp/qUAPkFOkE/+iB3vtjBxpW2UL8qdISvtUa7W2GTIbar/DPVvRhn
	0+ggSpKGl8Htmf6xJQiBSEaYq9AzUPrlRs64gCRlrOe1T4EOpbvwduZ0ms1e0C+J
	8GBLbaTThdHfLQa6GGXoa729dUMdKi33XOxhYe94kH2oRXolssZFzrFu9H7gZ0Ob
	EmfdxNhp/eNK1U0ZNXARpg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406xfswanr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 13 Jul 2024 01:11:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46CLeuAo010941;
	Sat, 13 Jul 2024 01:11:39 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 409vv7r6wu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 13 Jul 2024 01:11:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uNa7LlHpZkvBXIVYrpof4T+rVf6U1n97PypYR9ipBohjNtDYWn9QroiUt2JjSgL4oGHEUgpdYIuNnTCTqintJPr5gqkS4b3PKZCLHQOUoTxOvvG93s3bhXjY5eXAq/Lx5tAnHdcy8TPVSwRLMXSb6DLvRD04Fd+zQ1WE3WLC/juZl3B47BKDVOTSe355mJnKZFL//r20AkWfVbvJJiHbP1K3xYgwAgsV8x4Vqe7JJE7JYRw2GJyrCVSsseveZ2n2rXAV/kHYg4SfER6ljX8U77hagUniUPzz4iJCiUD1zCp27IgJVSy/V9DyHEhIA3LTXaWi1QgOcAVB89toGl3+Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UwnRQ9OfBWM7tpJ++njTvoSooplkJLYlP/SuwsWKaCQ=;
 b=XtTcKCFOUYpcDp/CAD5KjoKz9emhFUPyIDNMuwEUgMonK2BS+xrGui/a3qBe6dRziTZsNniAqCL2RJJHGsvMZ4q/m3yFy4d2iJJgCFnrfWFmZoT43fX3qlQrRCeDRsyR4TsYgzHzAiwHmoiZlbj+oP7VLQk0Jf0WvjA8lZSbQjnsm/gjJzXQYTUQV9m0jjy8Xw4dSKemq01Uc0tQiAONmIHcXyRF9XdM27k7B6H7dVUcBXKsy2UH6h6V6//3xvXj67Env8+0gf/McZyRGprGahr8B5xUIuRUvOlWsGH6GIvlxVFhaB9U0pQVpi2R+AGv/nVxDe8PeaoeL3Y2XyZNvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UwnRQ9OfBWM7tpJ++njTvoSooplkJLYlP/SuwsWKaCQ=;
 b=wsDo1wpejU0l5l6JEEdqJWZ3Mw8aVMN5Sfvh2h4nqz/YRVe4lfTrLdO7CDpc9Un0EqO1v2Nc2d1hznSLhIZxEqwySH5P4/o48ahJElvZYn+ZNNYhUzLGi5FRRdIJOnRWe5aH2j21pc0ICN/Kk10JYpF1c9p9kf3xImNs3/PhQHk=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA1PR10MB7738.namprd10.prod.outlook.com (2603:10b6:806:3ac::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Sat, 13 Jul
 2024 01:11:36 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%4]) with mapi id 15.20.7762.020; Sat, 13 Jul 2024
 01:11:36 +0000
Message-ID: <22509d51-1fc9-4581-9350-f57478439e76@oracle.com>
Date: Sat, 13 Jul 2024 09:11:31 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] fstests: btrfs changes for for-next v2024.07.13
To: Zorro Lang <zlang@redhat.com>, Filipe Manana <fdmanana@gmail.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20240712164132.46225-1-anand.jain@oracle.com>
 <CAL3q7H4cmHXmJJP8-DoRKF-nQe_L+1rwutZ0BHGk5GMzujGAXA@mail.gmail.com>
 <20240712185400.zwxazqdgjef4kmvq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20240712185400.zwxazqdgjef4kmvq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGXP274CA0012.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::24)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA1PR10MB7738:EE_
X-MS-Office365-Filtering-Correlation-Id: c356e38b-ee0f-4fef-7d76-08dca2d8be10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?bXdYQ0xxa2tsR1YvZm45N1ZTUUJlNk53UlZyck1KVko4SFAzc1E5VmNId0N5?=
 =?utf-8?B?Y1VkUmg5RVhSbHpaN0htWXFmdWEraWxBSVhJdmY4dlBCVitVSWtzUUc1cklX?=
 =?utf-8?B?ZU9zSUljcU1RVDRFMDlGWnU0MjVZWG1zek5LQnZlNDJBWVg0VDFmdytyYUw5?=
 =?utf-8?B?SVhsbm1uVitNV20wTGVGY2JEQ1Q2VngrenNQSVZKNmhFc0IwbXJWTyt6MlFM?=
 =?utf-8?B?ZFoycXdOekVxTWZvOGdNUytZeGt4WEc4NmJ0Zy9mMzY4UE51WlM2YnhLc013?=
 =?utf-8?B?UGxuY0lhVGFCdDFFdGozNWlzVlk1WHE4MXRUQ0p5MzVDRnBtZ1NJVTcrcFpE?=
 =?utf-8?B?SlFKUGcvUTVHdlFWR0hLYWM0ZHQwcXBWZlQzbHlnVC9NLzU4amE5azFIanJv?=
 =?utf-8?B?RDV2blc3ckxyUDhzOTJHbVJDRGJCTVZnd0k4MGdmTTArWFlhL1cvMTV3VGVE?=
 =?utf-8?B?ZWw4TlBSdThKMzVTVmM0NFRUZlB1anlQN2Vya2JNc3VubzhhK00wdDVQazV1?=
 =?utf-8?B?anVWR2FZTkpnNXZqZXJJT204QWorUnZscXZjVWp5T3FnTnJkU3A5cjhwZWxY?=
 =?utf-8?B?ZFJhMkFiUDYyUFZBeUIvUnhUakc3citwK1I4c0hTcGtyQXlhQ0dKcWJrUVBE?=
 =?utf-8?B?ZGFwdXZUWEs5amg1bkQxRHNhSWw1UXhYdk1MZnRRRWZmZGxUbVFlYnArejZ2?=
 =?utf-8?B?a2xpb2Y1RGc3Y1hoTWs5d0N5L2htR25XeDlLWGgwRUFneW5tV0RtaE1OVnd0?=
 =?utf-8?B?eFNnZmZmNS9hS3d3c3dYR1l5eWlEUFMwd2NUYXBkR0t3QVowazVUeW80Z2lx?=
 =?utf-8?B?Y0JRU1Z5eUl5SklTdkJsV3ZmUlVPcldsZ2NHVlhqUmQ4VmFXbGE4M0lheUlR?=
 =?utf-8?B?YTF5elN2ODlLOTFlQXZXWlJncTM0ZWlrcVlxSWtDZjRiQk9ZV0VpdHQyWE12?=
 =?utf-8?B?dmU0Mk45a21RblZHT1ErT1FKOWNjWWc1YWY4MHo4b3NMSFk0c01HeXhMekNC?=
 =?utf-8?B?SVYzZlJuSmZWazRqY2d5cGE1NkV0dUpMN2VYZHNOOXRMR2Fnc3BIeTFKbndY?=
 =?utf-8?B?M0hEY0UyMDlSME1tK2cvNEp3R0RzVENxYmJ0MHRXcEFDZ3M4R2tzL1ZxS2RB?=
 =?utf-8?B?aUJ0bVNEbmNKUDhzdnZ3VUtmUFZMR2duTW0yTTlLc0NSaWc2M1Q3RmZaNm8w?=
 =?utf-8?B?bENIUWZ6WEVxOHlvUkg3Q3JMSW9WN1BhVXB0cVpYRkJTSmhRYXhtditzc0xi?=
 =?utf-8?B?Z2JCWjNsdkZXMHBQSXA2VW0vamc2STNqY0xURnJubjFtQWNZVlJLVk5iQkJE?=
 =?utf-8?B?TU5maEc3OTFydXdFOUo0SmJYOGxsMjV5VFhpT3hTbFVvbkV6eVFyRklwRkZR?=
 =?utf-8?B?aGtWbFNCNEtEemdOeU9LMDNFSU5BVnEwQXJUVmJuVVZmQmdmeGtsdUVZeU1R?=
 =?utf-8?B?OXI5QmpZVTEyY0g1YTVZdDUxUm4rQ0ZlQlVId21DL0llTzBtcUZIMFY4OUlm?=
 =?utf-8?B?ZWZBM1UrSEJxUVVTMzc2OXY4Vks1ZCsybGttckJTVXlqbXV1MmRlOFhpRDB0?=
 =?utf-8?B?d1BlUmlHekdkZHNMQXF2QVNOVE04OTBWNFFRWGxFczdYWFVHVE9qaWVIWjhq?=
 =?utf-8?B?RWxBcTJEbXdCUC9QUUMvdFpncENFdlRleXpydnBFcGJrYm8vY0NsTWNQUnlE?=
 =?utf-8?B?K3pmTklUczU2akovc3czbCtOQXFLNjdtQmFwVjNWYWk4MTRURUxkUWEwNUk3?=
 =?utf-8?Q?bTNuIB6b3NA96dA9X0=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Q3BzL2FYTkduNTRRM1ZGL1Z3VDFhcThkUWVaZ0luQzFabm1BMXVwdE9PQzE3?=
 =?utf-8?B?Q0VydG5PSTd3R0NBczRIYUJWYXE3K3p1TFozbXJWUmdHaGc2WVJOakdnS0tr?=
 =?utf-8?B?dUUveFd2ZHhBMEdIYXBEcFY1ZVNDcytaZlVSbDBhNklTbHhRekJ2bHErTldk?=
 =?utf-8?B?QTFzOTVsYURDMGlqdndJRHNWWktRd2hhNUkrN1dweTZWVkk4a3Uwdll5aUl1?=
 =?utf-8?B?M21aRUhzRFlCMHR6b1pjQ1pZUXQxV0ZGYVlFS1NMWHYxY0tMYnhtTnN4WW8z?=
 =?utf-8?B?WXBwSWFBUUJOVkl5QlN5SjVzYmZVWFZMUHJGMVFmSmNtWm5vbXpRaFFWUlFz?=
 =?utf-8?B?enZldXdpcHE3YUNZcnVNNUhERWJHNWlvUEtvckcwRWtmNThpSTVkc3dUdlp1?=
 =?utf-8?B?UVJwZ2JSZVN4WEs0b2J5TjV5bHNlNTdCeEpLNzZXcnJyZ01pdk5XazNrdHdW?=
 =?utf-8?B?VmExa2RlSXcrY0lFRC9Vc2d2LzRUNzB5cHVJT2Y0YmhubklWS0RqUGxPUWVq?=
 =?utf-8?B?NnBSc0RHTnBWU3lNcVdaNTRNTUVjYjBBV2k3NlAwakhtVzVveDE5dHNwUVF0?=
 =?utf-8?B?Z2pCcTNsbXArem4zQ2JQL05BblFVc2dyZ1l2NHdZVWkvVDhycWN2NFgraDVn?=
 =?utf-8?B?MzlmdDRHME9FS2ZwbHVVT3ovWHRQTnlQSnlFSHZIT1Jqb1hhTmNkREVjSjJk?=
 =?utf-8?B?ayt3WUVrcFF2NU1aU00zQkdHdXMwR3hnUDFNTVlzaHJzakZWeE1vZHpGaXpS?=
 =?utf-8?B?OHg0NGFFS01QelpUQ2lBYTdka04vK2dYeVQ0c0syUS9NUldPNmdFcVpkYXJ0?=
 =?utf-8?B?TERqTVFFc0I1cDFVMlhPeGd4VWN3LzlNaDB6UUhNbEQvTWxFa1A3ZEVUL1d6?=
 =?utf-8?B?RC9jQ0dONFRCdGFCa0kwSDlwR2phK1R1TVo2NktPRjB5cjB4WU9nRHVYQ3JH?=
 =?utf-8?B?RjBmZ1U2YVNUT3VjNXkyd1I5blNmWUozY0JHaWZLZDlzUU5jSGNPSHU5Si9M?=
 =?utf-8?B?VGFKS0FsbU9EMVlBaGdydDYvWFBkT00xUlk3dW1NankraVJybDF0Rm9SWUxk?=
 =?utf-8?B?UU5ZUzArM2xhV3M2ZE53Vi9GZ2RkN1poMFl6dUNJUm1SNmdJMUJuOFZyUTM0?=
 =?utf-8?B?N0ZaQzVwRjJ5MkZlNmJ0WjlPS01Ga3Vwdk5UUVpETlRNcEZZL1dWL2JzTm5I?=
 =?utf-8?B?Tm9jLzA4dC81WXFpMWlmRnBMS2ticjFQQkdTRTZxTGFLNERLZUYreFZnbnNT?=
 =?utf-8?B?Q3NQV3piZ0EyT3VmRTBjZjk1SlNkTnJMc21sUDJkVW1BUFBKZnlvaW84Uktx?=
 =?utf-8?B?bmdCUERhS3g2dVZOdG5vS25DTER1L2pGVUpGNlV3ZUdnZnprb0k5ZlE4SGdo?=
 =?utf-8?B?aXpON080Nnh4ZFNod0hBUXU2YUpJVk5NSStnVFFzNkpMVTAzTGhTd3A5QkNa?=
 =?utf-8?B?UmVuMnd3d2NIeUlodUozQ29wZzZGMlA3c2E0bVBSN1N0UzBIUEdDSlZRUHNO?=
 =?utf-8?B?V09WTnFNeDdHVkwxc1VMeERER2FidmxQd0xNN0NkTTFWZFA1MUdkUjdPMnh0?=
 =?utf-8?B?N1hMRFFJK2o3RWxWMEVrRUg4dDVCQVFUYWREY0R6ZU9zNk9jY2YycG0zTW03?=
 =?utf-8?B?RmdkR0V6bWpFYnBIUGRoamRRSG52UE10a1lDYnJtNCszSE81VnZ5RW00ZUM3?=
 =?utf-8?B?OUxkeGVENE51aEpsaXYwMzZXNlV5RGFuUzFVOVhXSFd5anJIeVBwQWtkTU4z?=
 =?utf-8?B?UkxLREFnMWZFazd6TVdtM3NYMjlOYlo4c2lrR1N5b3pPY1kyQUhRUjFlaDI3?=
 =?utf-8?B?SG9ZZ3haN1BLcWJqeWRidzJzS3NnS2RsVDZNeFVvcEdnZSs1dzJjTS9QM3BD?=
 =?utf-8?B?SnBtaFdHVEM0ODlxQ2hubHhlcUUrbTJXaVB0WFRLUkpLeVJsS2VIZWx4TWhO?=
 =?utf-8?B?S2NEaWNxeTJ1NjlxUndXV1hDVG5nYXZGUWdsTmxOdFhSR2NUK1h0QjhoVzhR?=
 =?utf-8?B?eTYwY2VwaEhvMWo5aWdQazNoQ2d6ZDUzOVVSd2F5RXQvaG9lL211YTI5Z2cv?=
 =?utf-8?B?dFppdTJpQzFwcUprUDJnVDlJbVR3UXhJb2ZKVlQzNGtUS0RRTnFUbXBaTVk3?=
 =?utf-8?B?bjBoWUtFNW5LQjBIV2RMaFh5TU9Hd3FJOTdUVnpVNnpjbWk5aUV1alBuRjl2?=
 =?utf-8?Q?BFx+cHyb6hT731Svy5+jDT8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	B6d1J8xEAyPkCry3Lq8USjoWYDJnuIxaHXAHl3S7QfmFNzfVFxMNOIj+pqx2fl0YOxdHrfKE7BT4xBlmR6dNbk/kTueg2PJNFtqhlIUaNXj2aP/mAhNBTN9B6kzJQNF9Ebb6jkSMJ7Pl2SrNE/Ddgaf2N2+EnnDB76jPQ5UE9qO75Ner0+a0q8ac1Zm/u2WzKO2UDsjNBiWpwY0/nwxatKJaCczxJ+GW4RZ6RXRUD7OBiidFuFV0MdvNCdjuGBHrbM/+hx/V6JewZEEs1cBAafyOsi42P2761FN3GR8zLgExysEiuljMtMCACigAb+JNauyDoyXjfe8oBCKmHpBMb8LGPwATJ8em+l3+72LD0m1xSkKsKM14yXi9InFcZbIsdPr14QwUE+Ra4Nh/5HnLV+E6r8v3/Pr6e+FUZ1+M/GqMk4aMUKMk/Fe2eg8LPAxj+H0+Kk2yk2K/ypAqgqzOS2XcPUUeCV0dQKbnL5U71Qw4UJJ76zwP8reUYbve1+tL8N0MPUAmKSuD0W/ZH0iqdXWb7k+8PdMNu8CbLp49k2A4WLl5HdmqUzXXHaHz++COL8B7hxkaxb2XsP2Xc/5fhhRmhFsfhLp9TEkUwlkE22o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c356e38b-ee0f-4fef-7d76-08dca2d8be10
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2024 01:11:36.8514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QkFAxJFk4wAXUrMP4Fqr7MgKvLvZNbJjxNxSRE9RWmii12KXxLc3RsvNt22o0k64GCnvkZmnx/Ua3e/BqQZ1uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7738
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-12_20,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407130007
X-Proofpoint-ORIG-GUID: -Qoa3uzZTg3JCvS4_V33BP-_nUNUqV3T
X-Proofpoint-GUID: -Qoa3uzZTg3JCvS4_V33BP-_nUNUqV3T



On 13/7/24 2:54 am, Zorro Lang wrote:
> On Fri, Jul 12, 2024 at 05:48:58PM +0100, Filipe Manana wrote:
>> On Fri, Jul 12, 2024 at 5:41 PM Anand Jain <anand.jain@oracle.com> wrote:
>>>
>>> Zorro,
>>>
>>> Please pull this branch, which contains a small set of fixes and a new squota testcase.
>>>
>>> Thank you.
>>>
>>> The following changes since commit 98611b1acce44dca91c4654fcb339b6f95c2c82a:
>>>
>>>    generic: test creating and removing symlink xattrs (2024-06-23 23:04:36 +0800)
>>>
>>> are available in the Git repository at:
>>>
>>>    https://github.com/asj/fstests.git staged-20240713
>>>
>>> for you to fetch changes up to 8e0a68f2cbe9cc2698110ac85765a0c4681b290f:
>>>
>>>    btrfs: fix _require_btrfs_send_version to detect btrfs-progs support (2024-07-12 21:59:22 +0530)
>>>
>>> ----------------------------------------------------------------
>>> Boris Burkov (1):
>>>        btrfs: add test for subvolid reuse with squota
>>>
>>> Filipe Manana (1):
>>>        btrfs: fix _require_btrfs_send_version to detect btrfs-progs support
>>>
>>> Johannes Thumshirn (1):
>>>        btrfs: update golden output of RST test cases
>>
>> Can you please include the following trivial and reviewed fixes too?
>>
>> https://lore.kernel.org/fstests/6e7ee8ec1731b5d3d44f511b075fa2edb0b38661.1720654947.git.wqu@suse.com/
>>
>> https://lore.kernel.org/fstests/bdbff9712f32fe9458d9904f82bcc7cbf9892a4b.1719594258.git.fdmanana@suse.com/
> 
> Thanks Filipe remind that :)
> 
> Hi Anand, I'll merge these two patches directly, especially the 1st one
> which conflicts with another patchset I'm going to merge. So I'll deal
> with them together.
> 
> Thanks,
> Zorro
> 
>>
>> You reviewed the last one, but you missed it.
>>

Oh no.  Thanks, Filipe and Zorro.
-Anand


>> Thanks.
>>
>>>
>>>   common/btrfs        | 20 ++++++++++++++++----
>>>   tests/btrfs/304.out |  9 +++------
>>>   tests/btrfs/305.out | 24 ++++++++----------------
>>>   tests/btrfs/306.out | 18 ++++++------------
>>>   tests/btrfs/307.out | 15 +++++----------
>>>   tests/btrfs/308.out | 39 +++++++++++++--------------------------
>>>   tests/btrfs/331     | 45 +++++++++++++++++++++++++++++++++++++++++++++
>>>   tests/btrfs/331.out |  2 ++
>>>   8 files changed, 98 insertions(+), 74 deletions(-)
>>>   create mode 100755 tests/btrfs/331
>>>   create mode 100644 tests/btrfs/331.out
>>>
>>
>>
>> -- 
>> Filipe David Manana,
>>
>> “Whether you think you can, or you think you can't — you're right.”
>>
> 

