Return-Path: <linux-btrfs+bounces-11604-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED500A3D183
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 07:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABB153BA600
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 06:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49D01DFE00;
	Thu, 20 Feb 2025 06:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Sy43SFJY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ze+7EYG8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBA0B664;
	Thu, 20 Feb 2025 06:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740033975; cv=fail; b=Oqh0Yf67JSE/+YVxtyOUui7MYLPSmLORTdIQh7nAijkPONOCINN1wwSGE0wne31JgkNF9PxjjSns6bJctwteM2QDx9WVvPh+l+vW32Nn9lHa9ewvwr4yAo0aJ11y+5SlQr7AW8mzer4yWjGrmuYYj4bjM3WaI6f2ENT0Le0xLdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740033975; c=relaxed/simple;
	bh=vf4t7ie4KG+FX9DUcxfpShlT8mfwLW1KmMDLS5D/XBU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=B35VJ5JxmJusWBbVqYHCyDvKSjaey9p8O29Bxvd7zWQyYlJd/FBqbxUJmBd5Itd990GfqF2dtnT9UbWzczSWngi6Vt2PHiwk1/zH0VS9UhHAS1nfgNenUCcX/pM32uwu1gsqbW98NGuvU9X52GYbgmibon3DUzZ2WQ7F0NwTDQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Sy43SFJY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ze+7EYG8; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51K5fkFD011820;
	Thu, 20 Feb 2025 06:46:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=pWh07WOpDsOEap67L2Wau+j+AKGzI/7npMp8SZA2jKk=; b=
	Sy43SFJYxsBcvl7QBJ+AGKUNKGrv6QC4mlWffuWT+6R8MTupToa2aHpykj1PDQih
	B5Vm+OteqgQ2XgXTM+MQpbYQHfy254Ylab76fWKmpZoIVIiPq0NhU5+OA4YswG8f
	HhmcprzOCUltxVJd6ix1VoN64eF+hGZJTPXuEKf9xNTlxqRCtE0Tn/T5hX8TWCKq
	KpmwFPocjotguYOxkQeiQVuMA2wVADgesUPN7rsfdmX5PZY02bfGNc+hQKd3wcOs
	790vCZSyDOPGrsa3oGNUs6LiBI0XBBdb9rj8HRfC4mR6E2s5tRwwc7fEeA7313xj
	dOsRoNBQyzURxTDsHlQIKw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w00n3gam-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 06:46:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51K4UVAe002113;
	Thu, 20 Feb 2025 06:46:02 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2043.outbound.protection.outlook.com [104.47.57.43])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44w0tmrjtx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 06:46:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k8P4t/GFidmUw6OfFJ1CbFi0UL8j3auE7l8klm/HKqtfN6H2hnSYW9+rsrSpdBVVKdMZ+UPruEpChNd5Q/gck8NcN7D8+yhoDOmwA8tHhuNWrga1ilhOtOGth3J1EzU2dc1N9Y5u6VWY2OYTYcdI7JHMaJrY/Nxk6afkB2iACYYKtfEE/quBsEud4KKqFHHniME4pmniU144UpbwfiFA6o5zyYkJWahqF6REq8IlNE0wpvVgDsY9VtiI89wDKsruaQgYie1eKbY6wfeM7MN251ZmzsVdPi2rHz8YyJDQw9jAvxx9y0Ub7SDH+pn0vPYUxJfAu4F8L+k/BCkRTGQzGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pWh07WOpDsOEap67L2Wau+j+AKGzI/7npMp8SZA2jKk=;
 b=nji4BuV3eq4CSvQ46+lnPPpedYITWc1pGN2RKYnRPZxV/8GI5rj+0Aaec1weT4jipW8FwqS9z7l8Wadogxj3TTzmeAMpZGIBfAhpkvSdDkORojBlzDLC35yxKtJEUWsxV/7jHEcGGpHH6bqSbGbTm5MDlgs1oNOY/FDWsviEdvB+aOXAJElHE0ZNP+341lkwoempf44x4z/it1GObg8tVJDBCakIiihmu3nH7IaZ3RvWh2EU7HulSNr63ucx3OfEsScU3IOQEnrvkSMR3eG5VPcQPhTgdTwtWGJjwfuttmYl+dKgFREbsJtNWb7hCPh/t4M9kfZ3fBYxELZyO29i5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pWh07WOpDsOEap67L2Wau+j+AKGzI/7npMp8SZA2jKk=;
 b=ze+7EYG8vDWZjA4uIgCknE4O9OeTyn6k85r0CIgoglkkexoyGWNqOMiheyv36KWiuTv0ImzntaWrOvA9lvCaEyoXbNyzJH2I0RmSHNpzOkw7Mjz7MAxwhpMTniLrWjUfIbESMnaPenNDa+MFYvbFfKSoiozxPOGJPdfGQXy0kxM=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB4773.namprd10.prod.outlook.com (2603:10b6:510:3e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Thu, 20 Feb
 2025 06:46:00 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8445.020; Thu, 20 Feb 2025
 06:46:00 +0000
Message-ID: <2757cecb-6c81-43a9-9bf2-7349b1f5ba14@oracle.com>
Date: Thu, 20 Feb 2025 14:45:55 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] btrfs/254: fix test failure in case scratch devices
 are larger than 50G
To: fdmanana@kernel.org, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <cover.1739989076.git.fdmanana@suse.com>
 <27997253fd18428b2eb24d3f5ddd19885f058259.1739989076.git.fdmanana@suse.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <27997253fd18428b2eb24d3f5ddd19885f058259.1739989076.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: JH0PR01CA0185.apcprd01.prod.exchangelabs.com
 (2603:1096:990:75::10) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB4773:EE_
X-MS-Office365-Filtering-Correlation-Id: 57c1df87-baf0-4354-9616-08dd517a3c8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bU1rLzRlVC8wNVVRNWpqU0hqTkxUTEkwV2c1ZkxMNEJsRFNtSVlJOWVEZVdP?=
 =?utf-8?B?cDl0Nkc2bEhQSGcvbFh6SXFlaE9NOHJENVlGQ3FZYUhybGdlRk5hRk5QZlAw?=
 =?utf-8?B?K3JvOGZFWmU4NERmMzZWUktjL1ljMW9jaERQS3l1TkJVdkZXR0g5SEdYMFVs?=
 =?utf-8?B?aDhaUHR1aURCbllqZGY4aUZFeXZPVHA0WXp2dEF5dlVtMjNzUDNEcTBLNTdv?=
 =?utf-8?B?WHE3bFVLY0NXNGlwTUZuSFFuRlJqb2lwT1FZUEVBaThCZ0xqL3hzWFhtc1hL?=
 =?utf-8?B?ZVBZSjR0bHFjSXFCckdQZnY2c1IyalZuRFUwOVllcldrWkhQSUlZS0FyRVZa?=
 =?utf-8?B?aGRsQkFaSldQclVqcXpPVnlvdkVNMDFPd2o2NUxzM0JXaitkTXlDWmpLZVFO?=
 =?utf-8?B?cmlHK1o4RFIyVG5icGpjaDJRUWZmOWRIcVIvTTJGeGd6dHVGS0JJeUtobzR0?=
 =?utf-8?B?T2k4OERZWG5JT0IwYUpzMVlZa2xJckpJdStMaXV5aDB2NE9rd3hlOEJTMk0z?=
 =?utf-8?B?NUxWT2V4enBvbW9hcjBEQ0lBVkFUeFBxQjErM2FYK0hBd3V1bWoxR3BwcnJw?=
 =?utf-8?B?YjNmVkRoS0d4NERLUUtHWUw3QkNyZ3d6ZURONkZ0WkF0UnJqL2E1a3pCbUFh?=
 =?utf-8?B?SU9Dd2g5ZlBFVStQRzV4SW5BLzdDTURqVytKZDlWejR2ZnQ1V2V2dVpHa202?=
 =?utf-8?B?ZHpFemxsRmsyb3FDV2FzcmltdktuMUQxMXFwSTExYzV3djN0UFpocjdqaWR5?=
 =?utf-8?B?K1hUQUwvSlUxNlVrdXBuRnBPenF1Vk5WN3I0SFhqOWpKL2ZFZk4vaUtXeXox?=
 =?utf-8?B?czdGTWxBcEN1c08xMysycFkvaUQ0NWY5NzZiMC9temxzRmNCVEM4dE5pcEtp?=
 =?utf-8?B?T0hXUWEzTjVsWGIxUlg4S3FjdEQxVU5qLzFPZGFOTGVSaFR0T2h4aUQzTjhS?=
 =?utf-8?B?VmQvTjhMQ1puQ1NuWC9qMVVyS0d1R0FlNjhtS0k4YU91SkFrUU9FdUtBdUFy?=
 =?utf-8?B?VlQ0UEIxRUwwVUtRbVlVQ2tvejdadFdXTWlrT2FmRk5iaWhrdHhTbEJEbDlP?=
 =?utf-8?B?OUE2dU9Bak5GdDMyQWhqWW5Zcm5kZTJ5amtRSkpZcnVPc21VaGlYOVF6VUl1?=
 =?utf-8?B?b1BRMnNyNHIwSUhkQWEwdG9ldjhkNVh6ZlhCRnozRmZ5ZkxqeEtkMHJ2dEV1?=
 =?utf-8?B?MEVlSWxGWHpaU0tZYkdwQm1lQTArNlBxUnBFU1Mwb3VKNDdYb1h5bkN5Y3pI?=
 =?utf-8?B?ajY1VDRiZzBKMVQ4dUxEVFc4dHl2QkVwN0plU202V2diNXNncXgxeE1SVW90?=
 =?utf-8?B?WHRxbFJWRlVjeTJReVdNaUVGY2xldW9SbUNqengwNGpZaDJRbjVyR00zQ1ZP?=
 =?utf-8?B?VzdVaHFSNCtXSVF6VUVMcW1lNzJnWTZjR25YaFZkUVBkaWVOZHF6SVJ6Vjhk?=
 =?utf-8?B?LzZETVh0aWxFa0VlMTducHF0eG9rbUlDckFWckorNUdRMVllV3MyTWI5b2RB?=
 =?utf-8?B?eVg4MitKSWxHeGFrTGJiOWd6cGRDK0NzTHJNcUJrNUhLQ1ZueEJyRFhmZTI4?=
 =?utf-8?B?aEl0QzRsK3JCdThVTmVJYkwzUzVwdFpaa2xqUEc4QzZpSWR4c2xHcW9QQzZB?=
 =?utf-8?B?cHovYzExM1FJM0dUcEE5TVRoUEtFdGVQMEdHdmk0YWFwSytHOWRrT25teTZQ?=
 =?utf-8?B?MlJBY1pGcFlJVlpqcGJLSTUveUxTN1c3d2pNUFIxNVNaNlpHZDZTa1hjaHNp?=
 =?utf-8?B?VTdRWUdDejE3QmdBUUhrK1MwMThUeStjYVVaYVhqc2krRTAxSFRIczh4TTNk?=
 =?utf-8?B?WTdBUjFPRnNFZXNFTnJDbU9ZbDlmdDdjMWUzVzhpajlHczVCVFJ5UjVmMDRq?=
 =?utf-8?Q?GB1xnMBtlJN0H?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VHFrVTVNT1VyMTJHYVhTTFV5aFJtSFJmODd1c0NMKzZZMytzTEoxbkNjWjdh?=
 =?utf-8?B?VWh1M0tDR0FiUXEvbGdmbnhuQmNxeGx6YVB0bmpXd3FrTVI1ZTJFd0lDWjFM?=
 =?utf-8?B?L3RWNmZiVDNiU2JGS1JCRUxaQ05ZYnVlYzB5aUVGNkNmUXg5aGdLa1UwaHJ5?=
 =?utf-8?B?RWJ6TlBabjBBSmNJUnlUS05uSzVyWkdiMU5ERzF6T2p0aGtwU2VGUjZZWDJJ?=
 =?utf-8?B?WEZ3MXYxT2oxVTI0SVg5RHk3em16RjNueElZUVZ3WTV5QjFaWmFQVG1icXlG?=
 =?utf-8?B?eU5LM0pzL2Nib0VETUtJOWpibDJEVmNjanZhQ0p3UVNXS1JmTG9qVGVQcHlT?=
 =?utf-8?B?MWFLT3ovcWtHb29IcWNNS0o5ZlRCcDU5Z0JuS1JwUEh1VW95b2wzMGt2OHFl?=
 =?utf-8?B?V3FPTXRHNHFBMk9aUDQvcFhPTG9xMzh5cmZKWDdrd1Z4aDdQaTJLZzRBUUFO?=
 =?utf-8?B?WktFK05MTXlERzEybURQZDRGVy9FKzlzZGtQSXB6cCtBQm9hbzIvSzd3d1Nw?=
 =?utf-8?B?L0VpRHUxb3FZMXhlRDRiKzBHV2w2T3Nja25yTUdsSUtERmc5RDRkeW9CcnBj?=
 =?utf-8?B?ck1ISFp0ck1zNXh3Q3M3citzVy82d3F6NUhiWW5nS21qdU53cjFVRW9JU1Ax?=
 =?utf-8?B?Z3VRUEhSZ0ZPeVpEVUQvSUNjczc1djhPQ09ZekxQbmhvWmw1OTY0dWdpczlp?=
 =?utf-8?B?RUtRTjFMTTI2Q1RIeGtJK0hoeTh0b1piM1NOYTlhcHpOUVdTWFd6NjVQSzFM?=
 =?utf-8?B?Nk11bEJYOW5rcEROeDFFSUtwc0JVQ040dzQ2MENsY1BibXJzNGNzNGUvOGQ4?=
 =?utf-8?B?U2x6dzZzanl4UWRnL1hqZkxyYzhBM1Jqc3FZMEpPV1lRa3dneWlUV2JOU1hC?=
 =?utf-8?B?ZXJ3a20wSWdkN3h6R3ZDMytJT28rVlk1Rjd4RUc3N25uNW96QkxzTllvTjJK?=
 =?utf-8?B?cXQ5dnZGV1N6YVBTVmdhTjFwSEhYN3BCWWlpazBySkdLSy9XZG9DMHQrMUFO?=
 =?utf-8?B?bklTaHlsM2E2L0p2Sm1aS3VrZEc5c2FHbnNvSzVsM1pyNVpCYXFiUzFUUEdL?=
 =?utf-8?B?eGlYc2pvM1dvNFFnT0d4ZHBERnVGcWEwSWoxTlNtaFpxZTA1WlBhOGVTamQ1?=
 =?utf-8?B?V09JTmhGMUhvL0JhUXBocXBTTkR0SHRaMHJsWm01Kzl1L3VGYnNUWGswUUkw?=
 =?utf-8?B?bVZkY0ZlQThxQlorRnRLeUFaTTV1TkpGU2RZemZESTlLbXZVTWN2ZG5ESlBD?=
 =?utf-8?B?UFk0L3UrcVRDc1F5WkZIMThsSElIN29OMEV3Z0t6TU4xU1ZXVjJuUXNqYm5k?=
 =?utf-8?B?WFRXckN1ZFA1VzUzQ3pSOTdNZW5XUHRuem0zYXZPWmxVcUxUUFA5WThUaS9z?=
 =?utf-8?B?dWNKZjZmYkVtOFJrNERLZEVqd2ozclgwN1RMZFY0dWZhSklBRkZmRm4vbE91?=
 =?utf-8?B?bWVER2V5S0VGVGR4em9zWHI0UFEzeUxvWmh1bFlDS0x5UDhGOWhHZ1Nub1pj?=
 =?utf-8?B?RldVVjdxM1RFMkxOZEovdnZYQnZwZ01NQmhoNCs4RjdxaGNyMVJJZ2NNRzdO?=
 =?utf-8?B?S1ZpM2p3QjN0MU1kdkczdWxsTDZSRDhNb0RUclVOZGRHYmtVR200RnUydzNy?=
 =?utf-8?B?MFl0K1JSdm5mbEZjejJBS0NTL3MwY25lckxRNHQwcHFjWUZDdmhOdENoeDFw?=
 =?utf-8?B?WFFiRFhTNlJTb0txSFNKaEE0TUcxYk80eFZ2Wmw1UU1iR2Q3NGlPNkQxWkgx?=
 =?utf-8?B?THlOeStNbFhTS3hhNExzdjFSRVUxQXowSmNjdlEyUEVmc0lOZnpmZXpSanFK?=
 =?utf-8?B?aG02b21EblFka01Pc0JOem1JTWxiajNzNjFxaHNjOUV5VlpZMFVJRG5KZXpO?=
 =?utf-8?B?QVZtWmJ1MitZTkMvQlJnZk9rM0w5N3VjVHlCSDdoYTE5YVd3dHppNUZjUmkz?=
 =?utf-8?B?K0hHZ0lubktUZExKRVdSU01jWWxvQlp4RUs1R3N4VDVaM08rM0VPeHBVejUx?=
 =?utf-8?B?dWx5cWg3cnl4czdXSThKSlZNbHdMRG9TcmxQYnVCbmg2b3NwWFFNNWRkaVA2?=
 =?utf-8?B?R1FBb01sc0ZySWJ4VWdvc1JKa0lzU2x5bmU5WDBGazBQUmpiem5BZGQyYUt6?=
 =?utf-8?Q?dibAN+b/nvHubnofzVo1A1SVu?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sDefgkLuhPlBo9B7gQ4eCpyaxmeO/TnRgg09U9ExHKAHpgRIRoreRyx6fV427m0bUsm4uTvBiIRWyLiE+lj0hPCx5enmjxyH843jyHgQM0qQ088evndilA0yMvWRea5fFVPX4XpNeebajmvxcQ6w7qfyZOdzxzKPbFDpDbE7ETETIw/cDjskJGHZzGoxLnXrwA9Bry3MVqAKcRRj5zFpWa71SRYt90ho/HlsFnxeXbWIeYsv29YqysIANwPkddEPlYG09V22Tan1qqXpcjo3/NFDbDT/k/D+IYShatDSaxn5pRhLsRQnAL+fVjBs1npGHFINgxMxj1H1qf3bz5/LBZVN3RfwqUYPt6v2W5uN0wfOmzRjbWvslMZ2WkJUopaE1ZN1Ij24KNgusnQlGelyhEiziWADoqrUnxLlXj6+cjA26iJLluLPdIkkOw1ca7Ge+vTcHdON6i9eITHwewAmaGG19C7+mGqn+yN/Lt+Lu8ddfngRjvF0h0Ir4hqTLo7ZdyZAH/g9jEG+uvzbVCcZeIK5f7Z8CBS1sZbQVqNYGRc47t/PjfmPc2B56wVgLnDOVSyUa6DcOh/g77jS2/nQrnSmN/mglPYKEaepTZM97PI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57c1df87-baf0-4354-9616-08dd517a3c8c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 06:46:00.3376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3M3E4WsmueFNQsbFI9E9J7LowZxQlyRIN45370ak4Z0p5xK8j5MyXRiPW8QuIQfgQlK7OhFPFPedbZeO/JkbRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4773
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_02,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 spamscore=0 phishscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502200047
X-Proofpoint-ORIG-GUID: iGOolPevXGPXQXFzd2hAugvozDfFRIyf
X-Proofpoint-GUID: iGOolPevXGPXQXFzd2hAugvozDfFRIyf

On 20/2/25 02:19, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> If the devices in the scratch pool have a size larger than 50G, then the
> test fails due to chunk allocation failure when attempting to create a
> multidevice filesystem on $lvdev and $scratch_dev2. This happens because
> the $lvdev device has a size of 1G and metadata chunks have a size of 1G
> for filesystems with a size greater than 50G, so mkfs fails when it
> attempts to allocate chunks since it needs to allocate a 1G metadata
> chunk plus a system chunk and a data chunk.
> 
>    $ ./check btrfs/254
>    FSTYP         -- btrfs
>    PLATFORM      -- Linux/x86_64 debian0 6.14.0-rc3-btrfs-next-187+ #1 SMP PREEMPT_DYNAMIC Tue Feb 18 10:53:23 WET 2025
>    MKFS_OPTIONS  -- /dev/sdc
>    MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1
> 
>    btrfs/254 2s ... [failed, exit status 1]- output mismatch (see /home/fdmanana/git/hub/xfstests/results//btrfs/254.out.bad)
>        --- tests/btrfs/254.out	2024-10-07 12:36:15.532225987 +0100
>        +++ /home/fdmanana/git/hub/xfstests/results//btrfs/254.out.bad	2025-02-19 18:07:06.479812229 +0000
>        @@ -1,5 +1,13 @@
>         QA output created by 254
>        -Label: none  uuid: <UUID>
>        -	Total devices <NUM> FS bytes used <SIZE>
>        -	devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
>        -	*** Some devices missing
>        +ERROR: not enough free space to allocate chunk
>        +btrfs-progs v6.13
>        ...
>        (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/254.out /home/fdmanana/git/hub/xfstests/results//btrfs/254.out.bad'  to see the entire diff)
> 
>    HINT: You _MAY_ be missing kernel fix:
>          770c79fb6550 btrfs: harden identification of a stale device
> 
>    Ran: btrfs/254
>    Failures: btrfs/254
>    Failed 1 of 1 tests
> 
> Fix this by creating a 2G $lvdev device instead of 1G.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>   tests/btrfs/254 | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/btrfs/254 b/tests/btrfs/254
> index 6523389b..ec303e24 100755
> --- a/tests/btrfs/254
> +++ b/tests/btrfs/254
> @@ -44,8 +44,11 @@ _scratch_dev_pool_get 3
>   
>   setup_dmdev()
>   {
> -	# Some small size.
> -	size=$((1024 * 1024 * 1024))
> +	# On filesystems up to 50G the metadata chunk size if 256M, but on
                                                             ^s
Typo if->is.

> +	# larger ones it's 1G, so use 2G to ensure the test doesn't fail with
> +	# -ENOSPC when running mkfs against $lvdev and $scratch_dev2 in case
> +	# the device at $scratch_dev2 has more capacity than 50G.
> +	size=$((2 * 1024 * 1024 * 1024))
>   	size_in_sector=$((size / 512))

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Fixed and applied to for-next.

Thanks, Anand

>   
>   	table="0 $size_in_sector linear $SCRATCH_DEV 0"


