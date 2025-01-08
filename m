Return-Path: <linux-btrfs+bounces-10785-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B0CA04F9C
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jan 2025 02:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 036361637EE
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jan 2025 01:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AD21957E4;
	Wed,  8 Jan 2025 01:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m4iKoWlV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xRthQKFM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9268D1553AA
	for <linux-btrfs@vger.kernel.org>; Wed,  8 Jan 2025 01:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736299466; cv=fail; b=fB0RV85FmSObjF8BYHvj2XVGSbiDVTYw62tBmedSs1DM5wovP4n4Oxure6V6LDtMVRem4q+lsf2zQXmIrqQrvdFeV/VSD+AiUqaIJ7B3K834na36WnEDBX/JOodKbRabgPlpVdDcHMQj1OKl8B7rmLkMPnuz0ut44CVWdA27AOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736299466; c=relaxed/simple;
	bh=GBsmBnqjE4+wEeqL8czGrehw631cw8uv+QYpa43ZME8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aiPApfCoxKBoDGpQcgNt4WHpDNBoHWi6obe1gimS1irkWujHjC8Im4GpLYHLL/SDeUnMILFRCSvhNm8i0nSPSI6MHrtb11fUhVb2wZLVBGbo+lK80XfK23sPFuxuQt39t2PgZTxjLoQ2q34p2jR1DtUbzbHow82ur9QRYD0tlpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=m4iKoWlV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xRthQKFM; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 507MMhcW028446;
	Wed, 8 Jan 2025 01:24:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=UGxW+LGnQrBQHhmvaNi1cRto/hUJCVLm/pKzi30R5Dw=; b=
	m4iKoWlVXLYNDWv/I54G5TvVviW0jE2zd+v8rEZTVnjto4cdxKwWaycgh9qWKTpW
	sXgC2Pp89YBQPBQX8EaXxkEidfzl9LrJ/ccpGj+MTOEcw1/Pf4Qd78Eg2SaoIcea
	K8b5KSUOkmcIzSNw5q0I3gyCQpRGGElCusznbHmAL1Dpa8FLWyzAtVK14BtZP6VK
	hRO22/iARo0e/OKzQBAbyLmwx0yYRpH7r2ApJM6e01Y+e28Ws4HoJApilFOSo+aU
	hQtLUNkzY57oUiuFlYWwoMm0U5MlTY8K23h4QPZqPk+/5svcSO3q6SJ1gAsi9Ta8
	R6nCH3y9d2Tru+kdYBEdlQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xuk067wc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Jan 2025 01:24:09 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 507N0JY7019965;
	Wed, 8 Jan 2025 01:24:07 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43xuefgmqg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Jan 2025 01:24:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ox6OgSJyljb8ziT4ZlkuphcSEavzU5rrteugegHEQzlr7qP60xSKbFAmqPh/RzCmIi0Wn/1+MICC4j6O3fA79a4F2yihpz2k2PHH8nqk55IOAYvDnLM8tqKrWNaKVmrHfGt0vfoGAO3m9VHJp1j1iLgdKqUQF1EGd8V6QuDlHlhp9Idn3h3CjzEngvoDgn2vUMGOgpGe7UhviLG25Q2c1qoUZUW8/slH28vD4l9J1EdsBAwV7ghqdOskad9Jn0s2zvIV7JvR9fr5iqjQwsG3hUjOQW7h7OH23sLHqsRyjbaltLtr7XTQJ9f8S2RjALLU6njH/Q8NDX9Hs3KHSN9+Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UGxW+LGnQrBQHhmvaNi1cRto/hUJCVLm/pKzi30R5Dw=;
 b=HIW8lxxW0On5YW33WX5kY/yUmnjQqEHYdGwUxYiKY517vtCHF9FXYSZURTVMCVv++qacSSZUz18bCfOi6GVyT5dnN+MrMnW9+oO/N6lrAgxE/8rJTnod/oObT8SRAX+2KI9/caEYz7Rf6AUpzz8gfcoqNFET/szhbJbCwna0SNeO+T3NoG6HCEfE9PGMeBrYDzRk0vo5hAzQD+cbeY1MfY/XH+h2WHdUyAbrZTp68iOJOHZnENXsuHw6EMdG7eWsnlmM3a81Zvhed5i9K7TH2xXxuyXe1F8G/0jRQ/uJIw1uYpMistWI8dhujzoqWYqD0DdFy8ZsBs9QNVzUozAonw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UGxW+LGnQrBQHhmvaNi1cRto/hUJCVLm/pKzi30R5Dw=;
 b=xRthQKFMkcNMN2ZYmk/E8Dy7uL7PRuJ4MBD1qkserLIv3E9Y+ZchMVWS4FvCfqPA6ucPyj2YGSE62xbFHkkdXLMerk3z3jX7gt4W81dXRCxd060mHDB/ngcqaip7QKsIiFXLDKx/tym1rLaCyBGlqEtChd4qdshAu5dnQbghOBE=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM6PR10MB4187.namprd10.prod.outlook.com (2603:10b6:5:210::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Wed, 8 Jan
 2025 01:24:01 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%2]) with mapi id 15.20.8314.015; Wed, 8 Jan 2025
 01:24:01 +0000
Message-ID: <cfa7e8c8-12c0-4ef2-b58c-9e9e02c6ba56@oracle.com>
Date: Wed, 8 Jan 2025 06:53:55 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/10] raid1 balancing methods
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org, dsterba@suse.com, Naohiro.Aota@wdc.com,
        wqu@suse.com, hrx@bupt.moe, waxhead@dirtcellar.net
References: <cover.1735748715.git.anand.jain@oracle.com>
 <20250102135808.GP31418@twin.jikos.cz>
 <42d63c80-61a9-4c53-b9c5-be8025a65b97@oracle.com>
 <20250107145604.GE31418@twin.jikos.cz>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20250107145604.GE31418@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0091.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::14) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DM6PR10MB4187:EE_
X-MS-Office365-Filtering-Correlation-Id: c9bebdb2-6ac4-437f-aa3c-08dd2f8321c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MWNoclZJSEtjOGpIbzBRQ3d4TUM2OVEyNG5rckdpNVphOURjYzhzdzg3ZG5y?=
 =?utf-8?B?c3VHbmRmTytQMlcrdnZBMTl1OFo0TkNDbWE4TFlpZDJjV0FxSTZvb1pXVFQ1?=
 =?utf-8?B?Tng4bDlySG9ERUMyeU1FM2FrUmNaZXk4NnpwMVNRdHZKNUpPdHdXVTlJcTVR?=
 =?utf-8?B?d3FSaDlVZGhaOXF2WVJrU1FkVnFJY2NSN2J1YWdBazJObEdadHI4QmpITGZH?=
 =?utf-8?B?czdQeXlCWFJxNTlWT1FMVElad00wV1p0SDlERjFqUnRENmtOZFZJZkZJR2cy?=
 =?utf-8?B?aWNLSWJOSlNsUURCNGhEY0VKa2lENWo5dyt5eWtpMU5CcVFrNnRlZ216Skc4?=
 =?utf-8?B?SC8wVlFSazJaMEt0aUVzc1hyNmFNYVNyeEhMWUt2UGtJUFliNm5HcWVwT0NI?=
 =?utf-8?B?MjdCR0hjb0puNTRySDk4VStWMC9rR0NXcWhEOVBrdHJBMUdnSkJHaW91cE54?=
 =?utf-8?B?Rm5wV29RZytyUjVvRk4yWFpMMjVLVXhtZGVDR3BlQlVSeGFRYkhZTTBidVBi?=
 =?utf-8?B?TGZIcUdMdkZHeDdyL1FCa1N0UzAzNUJxQVdnVFJGMGxFZTRlMUNJODg0Sm9B?=
 =?utf-8?B?TTY5Z3dkMm5uQTYxM2k4Nmo4aEF6RDhiWUVvZUxtUVBvUFlRQ2prOXA3Y2Fy?=
 =?utf-8?B?eXQvU3FrL3Rva2NwQXkveU91RzNRTVAxczBJME1GOGVVbXBmdGR2dTBVZEcz?=
 =?utf-8?B?R3V1UmZRMFRWRjFaQkkyZ1h1ODJHMmVGelZ3dmhhVllIWmpRU0psa3ZCNlNO?=
 =?utf-8?B?b1NRbHZDT29Oa0tlRlhsdFZSVUIyaFR2NTJCMXIzZkw5M3IvVitCQm42aUx2?=
 =?utf-8?B?WDRERG9VMnlpV1NUS2VBbkgvMTJVL2ZzQS9LdTg4ZjZWM2t6VzJjK3lnQko1?=
 =?utf-8?B?YU1DTFdvdnVvMUpjV29OSWpzUk1JZDAxR01BSjlLU3ZzZWhNQXBmRkNaNWNv?=
 =?utf-8?B?aFJLMFhPeUFDZkdaR2tJa2Izb0VKazM3cEJXdFZ3NFhzTk1UV3cxckpvN0Vn?=
 =?utf-8?B?RkFpczNzOE9sSUdld24zMWwwcjk0Z2Q4L2FLdTEwOVNYN2tvbm10aGJURk0x?=
 =?utf-8?B?ZXZiWkVhaFh4WCt5NzMwUkJaZGNMSVJkcnNVTmRBY0YvU3ptUG1kN3A1UjRi?=
 =?utf-8?B?N2hQTG9HL2dJaUY3UVN5TW9aZ056SndzQjlheEJpSGljY0c0eTJhTXFwMnF3?=
 =?utf-8?B?K1VxUGFUR3h4ZmlkdzUyWVRud0ttU2tvOEJDcjFDSlFvRXRCclVGRkc5QTJ4?=
 =?utf-8?B?M01GV1Evd2RGem5zK2s0dzA4VkFNNWZsS1AxY1JVZzh2SXlEdUIyWlpwQXpR?=
 =?utf-8?B?a2FLOFgwVjJHZFlPZTFZSVZoODg4RTBIT1NyWHJNWEV3VXlMbWY2ejBUL3B1?=
 =?utf-8?B?Q1dNNE5EOFRBL0dzSEhqOVk0Z2VYcjBmcVp4V3czdDl5UFU5NGZtaC8xRzlh?=
 =?utf-8?B?SXdGY1FBdXZrRUkwRmxsYkc5T2psRFpmSVFUNTVuTEY3d3NqNnVTcDd0cjM3?=
 =?utf-8?B?WnFoRm1aZWJCTzdwWm5STXdpVTdML3RoUzljSHE3MFlNL2orWndyOTU2eWRi?=
 =?utf-8?B?NTl5d3ZhcS9pNmFjek55c1VaRVF4ckF1S0dUWDZpNHR3ZnFjdzFnczZnQzNG?=
 =?utf-8?B?dElDbVYxQ2w2N1RsaWw3YmtCZ012OHVLMnVQd216MnMwbE9xeUNrbkxOR1Ni?=
 =?utf-8?B?b3UrcmxHZlh4UWJPVXJlcitKZ0svR2ZPMSt6MmFia0pCczRwSnlPVEw4Um0x?=
 =?utf-8?B?YmlvanlGeFBkTHRqcUozbVVVeC8xeDY4WjhSNWRxR0h1UW9nbnBJdHd6TWNF?=
 =?utf-8?B?cGNhV2xoY0RvbktqaURmTHlxWStRMmptSlMyYlUzTXpwOVdZejNTYm8xYlZk?=
 =?utf-8?Q?k2eFms5Wc5+nG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NSsrL2YyelZ4dDhXekxMVlBDWXh3a0cweEJRbXRSMHQxZlpaOWozSlNReWc4?=
 =?utf-8?B?UDRvSXJQVWZYMW5WdHdhWVBuN3pQRjVFS2c3OU0xM2hSZnRwNmxVTElnWnpW?=
 =?utf-8?B?SzIwUDF6VjN4OTBCSGtSbmVOS0cxWGlUM0EyNzBObzlSVS9Dc0lRM2tHdG96?=
 =?utf-8?B?cjYzQzBJbmlJM3krVGNYRFp2T2VhSWNPR0hBTGpsNkpRdEhiMkxmQzFLM2Ey?=
 =?utf-8?B?RS9Vc1YwOXRJWHBZbUVVVi9RYVB3VkFYSlR2Y3o0bGRVTFAwNWtzNWpqU0Q4?=
 =?utf-8?B?WWlUSm1oQ09PaXBzek53YkQ1M2ZkakZWRWk3UzBrVnQ0R3IwdENOMVZMVTBS?=
 =?utf-8?B?d2ljRmNUc1h2UEVmTkt1b1lUU0d1QTV2NDBnZXVKMVNWZ3cxVXE1d3Z5VE1m?=
 =?utf-8?B?T1pRWlhTdW9CQVNEbjFOUUhJZXFVR0EvWFBlMW5IMGtUNmNLQ21PRVF0WUZk?=
 =?utf-8?B?VmJmemtKSHJqc3dNK3VaNkxYQSs2YXZPYzQ2Z2loM2xjNnIxTmN0UGY2Umhl?=
 =?utf-8?B?Mk11cDhQS2VOV0lVUXBmOTBkUGJxeWxqZEVpSjZ6M2x0cGFUS2FidHNPd2xQ?=
 =?utf-8?B?S0JHZG5sZEIrZzFta0N2ZGc5cjhrcUVORncrbnNJYkVGUTJBNEdXY3dEQTlQ?=
 =?utf-8?B?TjhNZ0w2QVZRUEtuQk9MZ0J3VzRCR3lQL0NLQVhTVFFKWXZlNEZtUlVFQ3hB?=
 =?utf-8?B?cXkwOHF3bmowS0hNckJkd1U3L0NjTityUGdFOHBKWVJVNEVRMnJNZUlpK204?=
 =?utf-8?B?Z1A4YjhMcy8zVUpyTEVNdXordHB2dHFCR3FlaTFKQUJVMEdXY1JFMWZhZlpu?=
 =?utf-8?B?dVE1ZGVpcHJLQ1pQZmNJUEluRnBWdXY1dWNnd3BlUTZHZUp4Q0NUTTFyTGtv?=
 =?utf-8?B?d2NrL252Q05ab2d2MHZQenE0aTVrUTdHQktYaVpyUjI3ZzBjL0hRcTVoMHB0?=
 =?utf-8?B?ZHNOSlFXem1mbVJ3VWN3UERwcWEwWXBlRGFKckFiVzYwUHoyRTdDOGtZbk01?=
 =?utf-8?B?N1VqazZ2NE9OYTRSdXVodzZZYVVHRnBpTktFQm9QK0N5OWRRT0xsMk1WNFI3?=
 =?utf-8?B?VEtTSnkvdFVBR0hVMVNNVHJtRlcwNjg5SnlFV3N4ZGFqQ0RoYmYxQ2JsRVpr?=
 =?utf-8?B?ejdJMXcrZkxBUnpXZWlubjhpNXNScUhRNUhCb3hwcmd0d3lnRUhpK2F2WjF5?=
 =?utf-8?B?N2ZFSC9lZEhwWlNOWDRIbnZOWGZsaFRBWWZVMmpTQU91SloyV1dEdWxIUlp4?=
 =?utf-8?B?eU5RcWNNakZXZlJRZWxUendlN3k1S2tsQWl6T2FEOUUvRU90dVNoK2JBMjZr?=
 =?utf-8?B?YTliY0J1SzF3UjhMRUxobVg1bTlCMDlBaWdwMjYxV2d5RGxzNUpINTFocGpP?=
 =?utf-8?B?bFd3TThPR2xOc1FhdDVjdEdXZUhmMm1OcytQSHZRQ01PT1lWTlBzUldoWmlB?=
 =?utf-8?B?VHkza3JPb1BGTzk3N2FrYlRBbUZ0Ykl2NW54dTNxelZOdm9oWGNnQzRVeDQ0?=
 =?utf-8?B?M09kY0hkanF6Tlk3b1VtQStCUEw1ZUlkMVczQkNsUm9GazgyYk5qbStsOFRt?=
 =?utf-8?B?YnJJQ2JvL0s3RFkrRU5kYyt1c281SFBXcmhzaVhDNFQ5N0JMZVZlRTBhbWJk?=
 =?utf-8?B?akYyM1FzQ2VFS2loSmZucVVqZDhrY0FzR25Jb1FUTFBCWDJXK0pFL0Y4eExu?=
 =?utf-8?B?V3QyeGFjK1lJZWNBL0M2djdheGM4Tkt2V0RJeGNjWW5Ra1JMK0tEYjJmZnBn?=
 =?utf-8?B?cWFYUVFjdzZ2aWxCL3RZcjNpUmNWTy9DWHQzcU9YZTduaEFGeVhwM1ZyOWxn?=
 =?utf-8?B?QWczVmFnblhvc2Q0RFJMOVVING41cFFxQlBGSGJqeko3NkFQd08rQVlsV0dX?=
 =?utf-8?B?ZnZFN0JEamx4VElkL002S1pXTWxLQkdreHR0enhOUVBqM2g3UnlqWVJaRkxt?=
 =?utf-8?B?S0RYb3lSU0ZkdkFiR1NvMk1kTzVzSE9qL1lPUDNnRldscVlHZ25XWlNMc3k0?=
 =?utf-8?B?NjRreGF2M1NESFZwMW5xQWhhZmIxcWpYRkM0QTI3TnIxOUl0bWN6Zy9hU2lO?=
 =?utf-8?B?VStJMkhPaVJpNjJMMCtISFBrdTVJMVVISTI2VWJHblJZR281QW1ZT2FlUm1k?=
 =?utf-8?B?OVFJeVQzNzZyLzc2UFphUEZsMVJ0U0xObXpWa3J1bjN4bnJFRGV1SkZLSndy?=
 =?utf-8?Q?sRyPjjLlwFHsvz7USGXhLGmevIuFrAwjJ66S8xvdgFk/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yvHoGs7SXq4lnv0g8YlqN2wgUJgBsDykWbtoGh7JdVSoDq6udjPdQkIp45E52qSDCFPPFwrGbiWsPhHSi8CDFZt7ochk00VSthGir015A5NNlAIL3y5wDSPQrlh2P8yxnwgyGvxNx3zQ/EO+eKofBQTqISb7ZfE3b4xvll4NJlA4I6yZmIKyt2TYYhYrF5QaphdCrBAlu0zAsYFv+26Dvdu8Ib3vbpLPmY298Fd+7W5MA8rDxx7VW6tle7Zg09+BJNjn/XyzPIKeJLdJWLfIcuTlGLE1jhLoKMguQUZfxuW/rdsOQQ0fmiEK5cnlj9c4fCjq0ZcBLX+QgBjzUaXOZ9rdG8NJ2+6gDyYEeoTcHNyaja+i8HHo3lqigFMiWgJwKkgQXOiCxSmI82gp1I/vnTwEiipOSuc6xLAkDB8FHeQc2EsgDfJPqnXCpq8kKXnceSV2+TKc2t50j4bMff/wxYxLcTAOGJhM2kwBNj1eDjHPXC2qw58YRpNg3+y11FIjwdub8Tgc35h3hqiGXPXyVphY7CAjRNhdYxJQAjMlDo4s3TZa7q8HP7NEKokg2w/H+KYPW4i7TBlzz+AOFGuqQvEk6BBqeiuIkP9jo+kCoHc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9bebdb2-6ac4-437f-aa3c-08dd2f8321c8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 01:24:01.3890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 25sGCy1PZhUngtABjn5yVWTJplLsFzWOHA5sg61zqX6GbHn/1YkFjMZ3zPJF9h06KK+i6jmdyS5vnY0jJOShgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4187
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-07_06,2025-01-06_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501080008
X-Proofpoint-ORIG-GUID: a_PUzR36PPLwhlGjTjE_wj2WDiCSNxae
X-Proofpoint-GUID: a_PUzR36PPLwhlGjTjE_wj2WDiCSNxae

On 7/1/25 20:26, David Sterba wrote:
> On Thu, Jan 02, 2025 at 10:29:13PM +0530, Anand Jain wrote:
>> On 2/1/25 19:28, David Sterba wrote:
>>> On Thu, Jan 02, 2025 at 02:06:29AM +0800, Anand Jain wrote:
>>>> v5:
>>>> Fixes based on review comments:
>>>>     . Rewrite `btrfs_read_policy_to_enum()` using `sysfs_match_string()`
>>>>       and `strncpy()`.
>>>>     . Rewrite the round-robin method based on read counts.
>>>>     . Fix the smatch indentation warning.
>>>>    - Change the default minimum contiguous device read size for round-robin
>>>>      from 256K to 192K, as the latter performs slightly better.
>>>
>>> This depends on the device and load and the read pattern so any number
>>> is fine, I'd rather stick to something that looks sensible if the
>>> difference is slight. Changing that later based on extensive benchmarks.
>>>
>>
>> The optimization should target the generic read-write workload, where I
>> find 256k or more reasonable, though I am unable to demonstrate this at
>> the moment. It's a good idea to gather more feedback. I've sent a fix
>> with SZ_256K and for a missed bug, hoping both are folded into their
>> patches. Thx.
> 
> As discussed, the min contig size will be tuned. Per current testing the
> balancing seems to work so we can keep it as is for now.
> 
>>>>    - Introduce a framework to track filesystem read counts. (New patch)
>>>>    - Reran defrag performance numbers
>>>>         $ xfs_io -f -d -c 'pwrite -S 0xab 0 1000000000' /btrfs/P6B
>>>>         $ time -p btrfs filesystem defrag -r -f -c /btrfs
>>>>
>>>> |         | Time  | Read I/O Count  | gain  |
>>>> |         | Real  | devid1 | devid2 | w-PID |
>>>> |---------|-------|--------|--------|-------|
>>>> | pid     | 11.14s| 3808   | 0      |  -    |
>>>> | rotation|       |        |        |       |
>>>> |   196608|  6.54s| 2532   | 1276   | 41.29%|
>>>> |   262144|  8.42s| 1907   | 1901   | 24.41%|
>>>> | devid:1 | 10.95s| 3807   | 0      | 1.70% |
>>>>
>>>> v4:
>>>
>>> As we're at rc5 we need to get this series to for-next soon, before rc6
>>> is released this Sunday. I'll do one review pass and then move the
>>> patches to for-next. I'm not convinced we should do the module parameter
>>> but as this is to ease testing let's do it.
> 
> The testing delayed it but now the series is in for-next, with some
> cleanups and fixups I did. The remaining thing is to accept suffixed
> sizes as sysfs (ie. use memparse), I did not implement it as the feature
> is usable without that and we need to get it merged now.

  The for-next patches match misc-next, reviewed, fixed, and ready to go.

Thanks!
Anand



