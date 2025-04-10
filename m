Return-Path: <linux-btrfs+bounces-12944-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51672A83CB8
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Apr 2025 10:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA40D7B4D9B
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Apr 2025 08:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08F92135D0;
	Thu, 10 Apr 2025 08:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="n0RkS1BX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Key4WHsW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5A320CCDC
	for <linux-btrfs@vger.kernel.org>; Thu, 10 Apr 2025 08:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744273189; cv=fail; b=WOQYarkKI4XpBxXGfNWusFvo79jjYVtxs8g/F7tFXbd0e7YjMfUhYLlLJrHYwYe+7ubW9hME8sBwebXPUvIu95Ja2J1ZVFG8riE2XlfqFMNUNmKrRWpwsUA5wZT4DbsK6I3mFsF4RYQE4po4maJyKJ/zg4Ckv4fdOZgWIv0SP0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744273189; c=relaxed/simple;
	bh=zf6kULEafrQXOYEdOEo4HYBn36pnNe2o2dDrtyu5+ng=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NHXkUIjv81xu02mj0ENOfTAb7BHN6VCeBfhYgREfapl/ddr1F2gbyqB4fzGPTvkaDGqwC2A9WUnZ/XHL6rTQABkmZyicSFcPo/s/5XfTxZgjj/gHalio4tSyVoRtaI0S2kR4SIgkLz6QXaOig52RXlMQdDX2nYCbZVTMKzgoSrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=n0RkS1BX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Key4WHsW; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53A82Axv031013;
	Thu, 10 Apr 2025 08:19:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=L1JAXy9r1iN3AoZiQcNumc3uSagm8WxtLb/Rpm5ogHQ=; b=
	n0RkS1BXCusplZA19RpL3Az0jn9fMJISlzyVDEtiuBOAWIoWWGIk7ZoORI20GKPX
	LeiobMXinyqXRWJoJp9ie4vvxB7tbwu5gx7bm/5xl9vgYnXabwc3sfPpkbcmBWk+
	PaWyAHf90eHFRLem7ZDPKu1NebAmmhM6o9Z3YLYoMt1fBQLjHepXfGLy+bpnLzrb
	xKTGm0Y8yrMng9S2koTLQkgUG+vj5gBj0kXu1TOR90z5yw89sap9SZbU/p0ImKhV
	Rbgy7xo2e80IeuoDRCbPOkseWeh9kv1Wj6575OSE18d2ywCcsQacZ3hVpAN9qTek
	q8o4fJYzbqm/zuk+EbzpkA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45xa498181-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Apr 2025 08:19:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53A7V125013743;
	Thu, 10 Apr 2025 08:19:33 GMT
Received: from cy4pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17010002.outbound.protection.outlook.com [40.93.6.2])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45ttyj8us1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Apr 2025 08:19:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gO9ilaz0xPT6lGfYWfnXIo8s2yJNT8ZniIQiFMbo5FzsrDwaUklefYjKijS3ymYrwaPanCn8tNcFZvUIsRMtzdY2WY25XMsiBaMpfs2CCoUwI2XLiOqV5Uj3syY1NlO92BJBiY6Be0L2/x3f+bm/F+R7JkEnkhb0c8yWPrCGpiuF0GdIfxfG7IoyfIDub8jUlFjjWeQ+urYgh/5M+T7YUen8bLkkiq1XmJkF1EL9wSUAt/uxy1Imo0TM9epPuMnE7mX4fwJSvG0mIm8Ike2Ky5/5R29G08RCiOK58PoY2hBjQ8TmYoGYPgCJhJVwMN8zpch03WgzbLjxjYc0intI2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L1JAXy9r1iN3AoZiQcNumc3uSagm8WxtLb/Rpm5ogHQ=;
 b=fNqkiJfG9/ceinWRSGSjbn0iowMTEmiRQnz5Qp2kf1hLHmK3xL6WQoVlctmiZ5jQyLrJcCWHA3zhClF3NIC64JD/ppm08kexXRdnNrflgCMvpyhykF+jQA5SffMqKjxrU9B6esrPc/jNON4P7nli3gn7VgwkugcyHpFCMOuaYAZvh7dRro21w+WA1vCxk51RneE+FaeEfi12QQGP1Z+tF9Go/c0WTCFNWyWWsS8nCBSgLXyCiy9SgXajt6SEvwTu7w992B67TREqVxjFnZpS8PC41RUmqcezeA9r3n31zldL/vNPtJhod878PFPFbJWYiO1OA0TLi7YbGMUdA9YDUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L1JAXy9r1iN3AoZiQcNumc3uSagm8WxtLb/Rpm5ogHQ=;
 b=Key4WHsWkRz3e/EW2qzhkJlx2sPY93AKDEY8tCWGdLM1gBR9xa7bYUHkbOAS455bfhegbNZ6ey6JpLIB5sv9irlFBTfOj7d4ZHYW5rWNXk8iBt1tGFsZMOLg5cxSCZcPm/W5yJVD6gap/PaN9vZI8o32KZJxgYdSc1Gyg4JiSto=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BN0PR10MB4903.namprd10.prod.outlook.com (2603:10b6:408:122::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Thu, 10 Apr
 2025 08:19:31 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8606.027; Thu, 10 Apr 2025
 08:19:30 +0000
Message-ID: <0d7306af-a124-4661-ac68-8274a6236928@oracle.com>
Date: Thu, 10 Apr 2025 16:19:25 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/10] raid1 balancing methods
To: Kai Krakow <hurikhan77+btrfs@gmail.com>
Cc: linux-btrfs@vger.kernel.org, dsterba@suse.com, Naohiro.Aota@wdc.com,
        wqu@suse.com, hrx@bupt.moe, waxhead@dirtcellar.net
References: <cover.1735748715.git.anand.jain@oracle.com>
 <CAMthOuMzzURcyMjbv49rkpzqc-PSPa76VkQG+FRCt0e9x_NQCA@mail.gmail.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <CAMthOuMzzURcyMjbv49rkpzqc-PSPa76VkQG+FRCt0e9x_NQCA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGBP274CA0009.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::21)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BN0PR10MB4903:EE_
X-MS-Office365-Filtering-Correlation-Id: c9603630-d254-4637-e0e8-08dd78086ac5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QkhUTnQ0cXU4K090dERwMURtR2tWUmtLckhKalJSanRRY1oyQ2NDM2pKS2hX?=
 =?utf-8?B?dzFYUEF1ZHFLN2QzdkJhYWh4QzVJaWIzK1c0Ti9WK243V3FtMTVTaXJwRThi?=
 =?utf-8?B?eU1qYkFvNkRFdzVoNmViZ2ZscHhIYlhqUmVmeUt2MWxRQTJ0bTloeTVSTlV3?=
 =?utf-8?B?R0RERlRjMDh3R2VhOTB1bGlobWI5TDlHc1p5MVgxYlJaL1FlN1lsZ3lGNnFK?=
 =?utf-8?B?ZldrSWplK3M5ajlZTDFZWFVReHdVMWNlMGlLTEI2OHI5djllVjhZZEFDZkpW?=
 =?utf-8?B?UTMrRDRnSzFacFRjN3VLeWhlcFZtcGhsczZVYnBQcjJNcVFsT1lFNU1QZEFW?=
 =?utf-8?B?ME5hUGRYVkhWRkFBZHJqUmtUYkc3NjJIdTZBRFJuSjI0TmV3OHk3K1B0WGV6?=
 =?utf-8?B?SnlWdWxlN3RYMVUzSTVqd0JPTlJScEZTaUxrTy9iQ25ncjFwbCtuWXovOGhR?=
 =?utf-8?B?MU5SL28xc0JRcVNLRVVGaUtrMXhZSDM3QXNKbHdsRmE2TEd3MmtvaTFucnJ2?=
 =?utf-8?B?emhHT1Q3SC9lRGlPcW5zblVrVC9PaC9kSVFDVElFb1NDdU4yRjM4ZkFReFJJ?=
 =?utf-8?B?cGlYOURvQWFPMVl5V2dLWHdKNWFleWxzNDlJanp4ejJJTEhHSkdiWmltSkx0?=
 =?utf-8?B?dWZrVzY3eFIwOEJBN0NyOGpwZ2RTVVhGaVI2ZExRT1E3dWx0L0diM3dCTHdT?=
 =?utf-8?B?aFM0c0gwVlVOeDE0TWx5R3IyYWdrL1BmZWsxTlIrRFZDaUp3Zjd3dStBYWh5?=
 =?utf-8?B?WjRiTUtKTUR3SEtnTTcxVVhQOEFGTENDODBINDdacHNaYW9RZzJmRkNiUGpB?=
 =?utf-8?B?dnhQcEtJV3JpTnJ6b1dTVzhzZmRqM3diaHhhU3Q1bnlnUGZ0ZTZTKzRHbzBW?=
 =?utf-8?B?Ly9ia3d3bHBZbG5XNjBYemo3bmZGemdzNTZGakxyYVZXcEdXR2pTSWMzWDlz?=
 =?utf-8?B?L2RtVFJGNklzT2NWN1B6WHViT3FORFREdmViZG0rK1FwQUV1VUQ3dE8zbmtm?=
 =?utf-8?B?QW92bHhSWUZ3YlFLZ1ZOOUpTK3l6YUNzL1dhSU9FZXh0NkhwNHhTR1kxa2dX?=
 =?utf-8?B?R1Aydlp2QjBaMWVYdlBXWXRrb1pRU2JwMzFCc0hhWU4vaWZjbHdzc0lpK25Y?=
 =?utf-8?B?cFdNV1NteCtXK2o0ZHQ1dmhuWldEa1RGbndZVXRuR0x2dFJiR1lLUGR2Ujdk?=
 =?utf-8?B?UDhpQmsrc2UzQzljTjVLYUFhcS9vdDFrQ29WamRzaFhiVS9Qc1FCQ1NJRE1S?=
 =?utf-8?B?ZnZSYU5iQVpVVFVYSFZ0OFp4dlVxekNPdmh0UXpwQnY0c3hhTHpkTVNDNjZL?=
 =?utf-8?B?UVBEN2JyK0o0bXI0T1VEUHp3NFVTR1lJL3dsUUt5b0VxeEhqRFZja3ZaamUz?=
 =?utf-8?B?SkR4cjA2SnlDdmlFUGxEK2tUUGhzQURMVHNXMVFGckpBRVdYR1NIQkFHRGxN?=
 =?utf-8?B?NkR5eFhkNHJZK3E3djkwQVBzNVdXODUzTUhkb0pHYVRMZDI2bWUrRStaM1hv?=
 =?utf-8?B?RDJ3UnVUZ2kxR0VUTlI5Nm13OHRDVi82WmN5azdQMldBUG5wYzNDR2lTcC8r?=
 =?utf-8?B?WEsydmFLUENranRxWmI5dlNocDBxeHJ3dDA0bUhsSGJaMGlOcm10VGJuc1p3?=
 =?utf-8?B?b3RvYjF2T2tMZkNreWMweERRVkpvb2RZallMcTlUZGtyVDlSTm55c3I5RG1Z?=
 =?utf-8?B?dkJnM0N6dWtNaHRMbDQ4eFpCaHlrVThrMnVsY25FT1UwVmVhY0JyVXYvYklv?=
 =?utf-8?B?TnJkV1lVNUR3ZVVhdTQzd2FRV2ZJTjZuR3R4V29NRDl6Ymdza0l6MTFmc0pT?=
 =?utf-8?B?RWVtU3p1eFh1NUpPVFVLQStHNTA4b2RZY2VpZGhTVFJnd1F4YlpOM0xQTW01?=
 =?utf-8?Q?Sd0aV2O11u7x1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rmd5VUs4UlFDVU1wUDlmV3RkZ0lUbEMyNmVKbTlFRTZITUdUaE5DZU5tNnA4?=
 =?utf-8?B?YStHdmNBdFROR1JSZ3d6L0dDZHlFemNCYXNsREpoQnJJT2ZKOHEyL0hGMmpK?=
 =?utf-8?B?Y1g3YVJkdDJYb0JRVkZkRFZ0bEFtQll1ZmNpZmRJdUhuUHdncGV5cndqTjh6?=
 =?utf-8?B?czl4U0RValFWUGY3bkxHeDN1anVvMko1Vk1NWnpRb0s4bWRVS2hDdnNtdGd6?=
 =?utf-8?B?aDVETTlxQk9tQXMvUXZVK1pPM052YWVqcHBsK2lOUGNGQnIwa3BqTWErQmoy?=
 =?utf-8?B?eUc0RkM5OTAzY3lDKytaR0FEN0IwVDVFTktjbStjSVZ4V0lSaFhwM3VKQUNh?=
 =?utf-8?B?dG82cmtNNVIwK0J3M2FzZGNpMXgrWjdyeE1XcTN2RHJWbzNuZ3B3aGZXeUJ6?=
 =?utf-8?B?SVJhSGdkWkFnVUxtdTYzT3hDWW4wN2RxUFJrRVlmMUdXeVB4VkhIakg1TVZS?=
 =?utf-8?B?ZkF4dWdyaEExNEUxdDN2NjVNL3pXU0d0SFVSL2p1bm42RS9RT1hYZXFsTkFL?=
 =?utf-8?B?ZjZlZzYvTG94aXJHbWlBOEd3Uk5xNm1ISk5TMGl0NmwwK09YMjhxempPTDZQ?=
 =?utf-8?B?SmxzQXJqUnRtRmxqODVpRWI4SGJsZW9ITDY4SXh6dzFIMG9vOEtSbXoydGRD?=
 =?utf-8?B?QldnS2hQR0ZSQ3NEZnhaSDlsSmZvbXNKMlJFSjhhTnVBbWNjWXBycUNJNzhR?=
 =?utf-8?B?TTZhLzRjZ0pwR0N3b1hINmYrQitJOXloeEhnbkxnVWpCd0Nka1UyNVNwU1g4?=
 =?utf-8?B?dzZJblQ5cVE0eDNsU1phaTlZWjlPZ1pSNDZuZHNpd09BSXdkM3JQZlNOVHRQ?=
 =?utf-8?B?NGk1YTZ2bUlScDdqejFyM0IwNjhzMkdsMDErcFNzUmM5ekxYaFQ2ZENwemN4?=
 =?utf-8?B?YVhLZnExNDA1dS8wa1ltR0dVZVhXaHM3TzBaNHhXS2tSVnRwZFVmY2NoL0pl?=
 =?utf-8?B?NXl3U0JJaXVkeG9iZnJXRjJwelZXZDBKNlVMckd2bGJUeU9sdVk0cmlzK3Bq?=
 =?utf-8?B?bitGTW1MM3A3amtOZ2tSMHEzY3pUZ2hHdnZvREVpd0xaM210SjRaTm1lSmVM?=
 =?utf-8?B?cjdBM2xWZ1NLTUxZV1Q4b1pNaDgxZWtuakF0dERiZ2U5NTluZ0YxbFNMcFc2?=
 =?utf-8?B?ZE5SMjh6b2xSa29DcW5xWUZ6dW1ocmt4Nm9jVHdpRnpreFk2Y1VZTHcvV054?=
 =?utf-8?B?bkl5Ni9HZWsxWVVwNkR4WkFvYkRZZ1Z1YXF2c0hFL0twYmhHMjFpRTVqcG1n?=
 =?utf-8?B?aVRxVzJEUlFEVlhZclRGWTdFbU1MVWcvY1NFQ2cyaFJzQ0ZqMnNJbXNsUTgy?=
 =?utf-8?B?TEFaTXBQVGNTWHZiSVIxV2NZUWlHazFUelBVTlBLZmRXZ2pEVHV2VWxJVHB5?=
 =?utf-8?B?T2FMeHZSTVMxazdtLzBQZnZoZnowSGc2WWpLUVY3N3lvbXZ4Y282aWQ2WW1Z?=
 =?utf-8?B?UUo3YzA5RjQvUUt2dC9qZWZPOWRZeGlsbFNJa1dOb2ZSRExEb01IZnpLY3JQ?=
 =?utf-8?B?S0JyWlNyRzlEa3g3aDRyK1ZUamswT2hFaVhZYiszT3NhVE43MG01enNnYlVm?=
 =?utf-8?B?aFgxanVwaG1IL3AvN3FKRE1wSUxzb3FEVlBHNVQ2ZGxxS05iZXpURS96a2Mr?=
 =?utf-8?B?a3FSQ2hyS2M0Yzg0aExtbzYwTCtZMm9VZDhZNkJqWUhjRWc2VlFzenZUTDNF?=
 =?utf-8?B?SlBvaGJvbXZ3VkltSmt3bkRqa0lxQVB1MWxrVFphcjRzZzQ4RnNyU1RHc01Z?=
 =?utf-8?B?RUsyR3VuRE5tQW8zQkxJSGE2MDZkdTcweTU1NFFkcU9TR0JWNzdvZ21VVXlV?=
 =?utf-8?B?b283MFlVank1VEk0b3dua1Z4UFNlY3JpYjhpdVhLbmxLUnFEUzZaTm41Zlpy?=
 =?utf-8?B?RE93bFRVVWlUVlpEcGRnRGFKZlJmeVFMdW5FTzRqaGU1RU5RKzVpRDlNY29n?=
 =?utf-8?B?dUhSUnVxdTZmczlNWTZUSGdyYmU4eHovYkpyVXVJUTZpZFZpYjFUZXlkcThm?=
 =?utf-8?B?UkUwR0twaWR1dit5d1krYm9GSTNpZTNNbnRLTWZMNWtKdkJZaGNXaUVmbTR0?=
 =?utf-8?B?YXlyZ1JTQzZxWEZxL0hWTUticWhHRkl3b1E1UW14OVUrN3JXTHczOW1PTW41?=
 =?utf-8?Q?Q6W5xOpxI5QNa+jmg6c/hsqwd?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KZiiK+iD+x+b2bph+QE3JS2zEA6Lt6RROLY6p2JnJB/GIrLPCYectlREMOWK/EgcDYdKLtEydqsfBnorjr+o2oVNTZ5MwLJsLGRPiDHdfXYwmpUn9EU15gwCEmPdSq4njQ3/+7ziCYHx0vy2YLtp8UzFmi61dDgfFeB8YVT8dMO7JnWaWcy/8+gJMKtb4kTJ75oVGjwlmmw6BPx+tPR+JkkK9BZWjGxCoFprWw9NY9o5+AKtdqbcAodbgjdK0bV8iUswKNUoM52gPDUmTalyFPzzuUgnZy9n0BIeHBPOQJ0XU3GO3lJMfYtcGiOupB59OwJyZCKaUW0FlbuP+k8SxgEB4J6r6YeV2LvcD+DxTU2zKjaJKCIeBAoDiPHg4hqB7+2un73gxEmjvy44HAfQD2jr1s13s5HfizFP9slZIGVMVKWrKQpaPcv554tumytD70DTbKG9zICB1ojoXZXMtCb0lu3AzmccGX0GFSMf+aOIvxi55vncu/ulR0+t9xDQq9E+pXulZKzTI4pzo9G/W2lksgfUvq56uo3Xw407P1vcgVHpWuFJCFCe0FrItqPo4EDmHJXRUDhCF4m45xLNsofuszGvuHfJs4ZcHoLRS1A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9603630-d254-4637-e0e8-08dd78086ac5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 08:19:30.8616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6JuGdaF93TSkw213/oRvHBD6fmZbsmL/WsXumZ+NbRfGzIjiIvQtTkZEO8VCE8a9lYD2d93NipsW165Hx5KuvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4903
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_01,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504100061
X-Proofpoint-GUID: je1UsXcAvbAqEBM4lhwSqQAURGiaruh6
X-Proofpoint-ORIG-GUID: je1UsXcAvbAqEBM4lhwSqQAURGiaruh6


Hi Kai,

> I've backported your patches to my LTS kernel to experiment with it a
> bit. I've also included the latency-based policy for that reason.
> Here's what I currently got:
> https://github.com/kakra/linux/pull/36
> 
> I've added an idea to use a hybrid policy which combines round-robin
> and latency into one combined policy. But it seems like over time, it
> will just acts like round-robin. This is probably because the average
> latency is calculated over the full history of requests. I think using
> an EMA (exponential moving average) with an alpha of 1/8 or 1/16 could
> work better. But this would require to sample each bio individually
> and add fields to the device structs. Something like this:
> 
> s64 current_ema = atomic64_read(&device->avg_latency_ema);
> s64 difference = (s64)current_latency - current_ema; // important:
> signed difference!
> s64 new_ema = current_ema + (difference >> N); // N = 3 or 4 (alpha 1/8 or 1/16)
> atomic64_cmpxchg(&device->avg_latency_ema, current_ema, new_ema);
> 
> What do you think?
> 

You can assume both devices are of the same type; otherwise, the
logic gets sidetracked, and some performance numbers may vary.
I couldn’t figure out how are you calculating EMA in the kernel
or how well it prioritizes current I/O latency over historical
values (which is a problem should be avoided), or if it gradually
fades out the impact of device's stale latency numbers.

> I'm currently not posting my patch series here because
> 
> (a) it's based/backported on LTS
> (b) I'm not yet very familiar with doing that on the mailing list
> (c) the code is not ready and contains some duplication
> 
> I hope that's okay.
> 
> So far, both the latency and round-robin policies work well in my
> setup. The latency policy actually filters out a low-end desktop HDD
> which is quite slow (according to fio) for individual short requests
> and long sequential reading (acts more like 5400rpm in that case) but
> is actually not that bad for typical random IO with larger block sizes
> (actually competes well with my other 7200rpm disks). Combined with
> bcache, this automatically optimizes the fastest disks into the cache,
> avoiding the slower ones when using the latency policy.

> Overall, loading times in some applications with random but massive IO
> thus seem faster with the latency policy while sequential IO is faster
> with the round-robin policy.
> 
> I think the hybrid approach could fit both scenarios but it currently
> suffers from not adapting well to changes in IO patterns - which EMA
> could solve.

To try it out better, you can take the latency code from this series
in v2 and add EMA to it. For now, keep both devices of the same type.
Test it with a defrag workload. To make it more interesting, add
some noise to the blk-layer transport of one device to increase its
latency, and see if the algorithm dynamically switches to the other
device. Then compare it with round-robin. That algorithm will need
fine-tuning based on how adaptable it should be to intermittent
block layer bottlenecks

Thanks, Anand


