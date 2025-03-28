Return-Path: <linux-btrfs+bounces-12637-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 257C0A741CB
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Mar 2025 01:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EF58178AC0
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Mar 2025 00:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8331A264A;
	Fri, 28 Mar 2025 00:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W/vGsa8h";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UBtbrFNq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D046518DB01;
	Fri, 28 Mar 2025 00:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743122442; cv=fail; b=pwT2QuCKGCqEkwCxaz/aUGuI89XQP3Dkqa1GzGDp6FYO+v5uv0RQ+aZ/z3O0fUM8e2wen58WIxoJ9FZ9nmhJUfGMNPgz6D5McEIMWV0gox4H5XVvHLnJxuAtmG/Qzj/tWJJyNaKVs/fzKoANmsM1GXze5hKxOV6+6jZxS9kk7m4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743122442; c=relaxed/simple;
	bh=JzOp40qyZ+HE98Tng0Eu7sU+IqA+SuqJ6tOfbcq5lp8=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ds26FCc9xrj316Z3zb266bUZXHiRw6RcZMyMvdNOy1erfC+c435nNii3i89sK3nQzVmk5Q8QAMpMdkGH9kjRNCigAyB4K+OiOaczRWy8AbOIsD4NVCwAYkJo3p0FNIrFCqtKaL4+jDUUUn1P2BJNa4MrXCBOeUo0J76ux7xvZ3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=W/vGsa8h; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UBtbrFNq; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52RLMv3t007319;
	Fri, 28 Mar 2025 00:40:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=z5KyQddQLjT0qXjdLuE++t7YNJU7PJO04fjl+yvUfVw=; b=
	W/vGsa8h5RiXmd639HrTPEWkgTP/QIKzN1UraGQ5h0j898dNo3CM30D5DNaf3jQx
	P8bbYVypOLsPJ6rBVGmftkO3JL063o8K7bRgSXoR5IOaMUyTawZYNAwecKIOY2oi
	PfwL9RZsg5hta3UpHzvOLvoljm+8uEWSA7BaVT7iENQbyGW6hk5CvRKfnHliUJro
	3bJfhm9+xDyO9+TQJ0zi1/ewDSKuoeqNra0VXhYE9fczDg1U+DIVJL2Jqjtbs58o
	iRQy7tpdbw9bTO8H5dhGXlLn9l64g4qpPRgoMHSToZqjYNMrC0RHu1CRCRqxq7Sg
	saaphXEe2T3cZNfSCZGo6A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45hn7dwxp1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Mar 2025 00:40:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52RN6j2m008236;
	Fri, 28 Mar 2025 00:40:36 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2171.outbound.protection.outlook.com [104.47.73.171])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45jj6xsf9a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Mar 2025 00:40:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QUQJdo9ZCP5PTR3zftW0cflYwIILhdoIj9T/z/XhpE0ut1d+a0Ro2V4++ZpH2cCrESagvztoy+0ZyZ6N3IPX1f3phw9N7WE7f01S7mjw7h/HwAfBPN5NRm5WN3/a9+iEOh1o5QQ2Uuc0u2YE8c6WJk/IlI9YMM0EegEXPpOHTseiBOnISLzJhhSuYxxxYUyBhn0YCySyDFI/5Id5cO9Y0QLuHyqu6YQ118VzQpgsZt7wPY2XnIGfTSjfdJ02L8qg/QnEjEUjQ+nNKhcAC0rCY6JrzArRHiA2B5vZ/N6LkKyK/FEOVlZ5zn8OEpzX44QhXK4E979mb6N6UbenucTlRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z5KyQddQLjT0qXjdLuE++t7YNJU7PJO04fjl+yvUfVw=;
 b=a+ZGfrPAsNTJRTkGLwccOpPa7uQ5KroKJzqeRzsJZ7mxhp6WQSc+rAQy05ySo3XmsXOf3mIYZ4DE+ikazjcnHxMCF7rP1MQpdJlXlRpAmsxPKtFmfNaiAhl1gWIWW7UH4wZGHCH+vmS8xhHBpCeZ4934Q2K6cmacb0PkwzoQvdw7kyLCfkcXAO97YGdLXs55u6Sh0vUEboz1GGWsLenJzW0x7gsgxrhsCb4XumcWgDiJDfvYjiC9EZgqc71toIlD4sT/gOJv4XRZa821NM26Z80BB724MrS4wvlDBNVH8Xf5rXHS6hAF39ROHzfAV+g3sc2jMK9cvnhbAyysJ8GAdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z5KyQddQLjT0qXjdLuE++t7YNJU7PJO04fjl+yvUfVw=;
 b=UBtbrFNqg6vCPC7TKxmGq1z0vciIIRuSzaByvZOgiV4PxqR7G8J5pPT739LtDP9Ps953xdMtH7CTLGETZDuYBsI8+o2X/VLe3sKCV51RDU7zsdUWu1cXOaHDqnpImkw6P9uffCp6+CgsSjN+huik6I02hVxCyI9ddD+JybzYxxQ=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BLAPR10MB5092.namprd10.prod.outlook.com (2603:10b6:208:326::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.27; Fri, 28 Mar
 2025 00:40:34 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 00:40:33 +0000
Message-ID: <945cc1cc-d16f-4dd3-b13a-948e3239dbb3@oracle.com>
Date: Fri, 28 Mar 2025 08:40:29 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] fstests: btrfs: add test case to validate sysfs
 input arguments
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, david@fromorbit.com, djwong@kernel.org
References: <cover.1740721626.git.anand.jain@oracle.com>
Content-Language: en-US
In-Reply-To: <cover.1740721626.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0209.apcprd04.prod.outlook.com
 (2603:1096:4:187::12) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BLAPR10MB5092:EE_
X-MS-Office365-Filtering-Correlation-Id: 298253a5-7bab-4ab9-1625-08dd6d91261b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eXpkd1VzaXRiWkpSdzJKYkhJWlgvK1NUSWpOOUZCSDJqNElSR1llWThoTHli?=
 =?utf-8?B?Zk9DUmlTZzc4eThrd0FjTGxwTWV4aElmTnVIMW8zSzBiQkp6TUxQRVEvYTFj?=
 =?utf-8?B?MnhSSkZoQXArbFJWTEIrOGd0UnVHNjhpOER2THYvdmN0WmpkMk8xYmwvOGI2?=
 =?utf-8?B?U1RFbUpvOWFTS1gwenpDS2F2NEx5cTRGa1hiaFRlK3hMWW5FaXVESjdmdVJT?=
 =?utf-8?B?VVJLMTQ2cTYyT25JaXJEOVJDU3RTV0JEWUI2T01iNzB0Q3phdWsvK05ma3ZL?=
 =?utf-8?B?dEk5V3BwditBakJCK2p5cTJ3R2N0MHpqZGVkcFJxTFRscGFPRXQySlNhZytu?=
 =?utf-8?B?U1k1RFJLaEsreDZlWER3YjJmQkRDYUovWWhad2kwODVma2VnalUvVENlempC?=
 =?utf-8?B?dElGenJROHZoMEhTaVM4WUxSZFNUbktzWHIzdlRYaTNYVTg4TmNLLzdFUkU4?=
 =?utf-8?B?UjRFeDc4SVBjSGlHWXpiNHBqMHhvZERuVGpXV2I0VE9vak5sN0JHRjkxS1Qw?=
 =?utf-8?B?ZlNIVHM3V2xCUWM3UG1ESTJjdnU2UUg5dFFVSjg5VGlqR3RjQUxPdDM3Tk51?=
 =?utf-8?B?YTNEa3pKZ1QxS0hJSkVYSjZmcThDQWRQVWgxYjZVajFtSHpGZ0lLbzRkUHJn?=
 =?utf-8?B?aXZWNEJPVG16bzlwS3ZqMVd6VUNVSW1yMlhaM2pEa2xiM0RzQ2U0L3hpbE1Z?=
 =?utf-8?B?MmdqNjVtRUNIdUZkZ2dGck9BRjJZQTROY3pFdmJBMStUTjQxMnI1OE01Z2c5?=
 =?utf-8?B?czk1YUxZUmJibHR3UmxkQWJPNlhuRnFuYi9URzZHVHNBYWNhZk43MUthSW8w?=
 =?utf-8?B?QUZRRzQvNmxuMzA2bHVFdHlXWjhhYzY2dUQwaFd4bVQvQTEyMmdqNDIwL0pI?=
 =?utf-8?B?NFhWbG1uOUFnR3ZNVFQrckRtWnZ6ejNzYnBUVXhWRGN0N3RYSFRyY1Izd21O?=
 =?utf-8?B?dSs2dmZTbFQwSXBkcHVrMmdxcDNWYk9RMUVPVXBCSXg5dTdhYWU0cVErZW5u?=
 =?utf-8?B?ZGJDUzFJcVJvdzQrWGJBMlR3bERabU1ibzZYb3h5U3A3NitZZFJuZzFBT3Bi?=
 =?utf-8?B?dlh3djgvZmdJK1kzVi8veGNBTHpkZEp4cmpFdUU4ZXUwcGtGQm45aVFMbHc5?=
 =?utf-8?B?RGRHQ3YwYXdqdmdwR2xiT1o3SGlCdHZuZ3p6Z1Jhd1JpeUFSd25zazNEQ3Fq?=
 =?utf-8?B?NWdBN0JmWjRGYkY5YjdnWkFPaUIvSStDcEdlbXRZS0dKeFFZVm9MWHZ1QWt6?=
 =?utf-8?B?OEQ0UExSemxVaXY4a2hFVTc5UzJFSk5uZmxtZXp2a0pMdisxKzNXR09qeEJL?=
 =?utf-8?B?NmsxNitzV3UxUlRrSGkzRzdLRzBlS21BNjFSdXFEblZ4T3l1cTRzUXRSbm5C?=
 =?utf-8?B?UWxPMk00UzV0anZ1ek01dlNtNnJqeitKSnAzbEQybHNpS2I5OGc2dmxKK0ZF?=
 =?utf-8?B?d0pCTFVwaFUzbDV5VHdTV0wrK21XNktYZm5leE5CM0p3cGZ4RHN1d25aQzlS?=
 =?utf-8?B?VXRWLzMvTWxON2NhYTFQdjFlZlJRQVlPSVVnelhOeG1Yd1FzR0VibW1RKzND?=
 =?utf-8?B?NS9zWXNqUTR5UWZNM2tzUEZGT3ZMdEZmU0Y5RWZrVWdqR3E3M2VkRXlQMlFo?=
 =?utf-8?B?Y2cxbEpWZmg0aFc5WXVXOVo4Ty9aUHEyU3RQSkVQNnpKTjdEMng1dFRPc3ZD?=
 =?utf-8?B?NlB5NU92WEY3N0M0MUhNT3ZUZnRGRlFPbUlTeHYyUDZsY0c4cWxMNU8wMUpr?=
 =?utf-8?B?MW1zWGc5L1JnU2VmSnlzWUc1c1RjOHgxbHU4dFJaRWVlWlorTy85OTBuK20v?=
 =?utf-8?B?dXJjand1WTlHa2ZFK1d2WEJOclh1QVM5TytiWVFrbW15cWhHc3h1b3dXaTMx?=
 =?utf-8?Q?xl/g9WWToRrgw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cTFpb2JkdHNNdzFsMDVHd21IZVBRRUNiUm5kSnczOVJlZUVIQ29XM0dxQk1C?=
 =?utf-8?B?M3JxaHpnR0hKekVyOEtja1MxaVVrN3dMV1NCY1NIMW1IS1RTNlVkd09Rd3FZ?=
 =?utf-8?B?REh4V3JTbGl3QStLRkpFODNtdW1WVm1RQW9tdHdGaGZwaXEwZnFTc0loNWZV?=
 =?utf-8?B?WG5SZGNGUENrMXp4T0FuUzhnMExFOWF5SXZEekl6R2gwbFhXN2crcXFmaDZl?=
 =?utf-8?B?RFRPOTRXZ3Z4NEhFejBWNmlNdGplMndtNFphaDlNVVJJNHNiNVhEMlZaNEtL?=
 =?utf-8?B?S0h4QnMxLzJKTjZUdFBNWnQ3ZGtNRjNvNjFObVdidmx4NlJhNTNXY3VZUHBP?=
 =?utf-8?B?dWZpbjdHWjdZdGNaUitDWnZPMUhsaXZNSm5pNDkrbzlwdjBWb3JMVDk5UFVa?=
 =?utf-8?B?ZlpYekxaQ08xeVNLbHlQYlFUdUpESHRWTW9WT0l6REtyTEZreEsxNGlPVXFy?=
 =?utf-8?B?ODdWaVphS1hXQW5ocHo5SnArK01vSDFVYTRoQmF1OGNPWlpERXhBaUNxeXdP?=
 =?utf-8?B?cmxWTkxHWldEUlpDdG5rWG5pbjcxUm9RNFVLUEF1eTRCOGJNc3ZBNm5xOUUw?=
 =?utf-8?B?YXIzbkVpVnEvSytwamphb01IWWxLZ1E5Vkxtd3BZc0hnRUZoOTFGNnlUVFg3?=
 =?utf-8?B?dU1wQzIrMGlmWWZ3Q1BuS0xuVW1HU1NvY0swRWlyWDBSOW83blVESUROZnBW?=
 =?utf-8?B?eEduMVBNOG9YN1ZMcDUwNERvVncrWmlBZHczNjRVMDlWcGFhbTd5VDNubjY4?=
 =?utf-8?B?emtZTy9WcFM5NWNEM1pzbWVJNXZqRDJZOGM2andZQWxzaWVmK1pSS3JHaXpm?=
 =?utf-8?B?RCs4dUtsK1BuUEFpZ2RmcitOdkhmQm1NdDF1bjRKS1haenJVNXEwZy9ZSXAw?=
 =?utf-8?B?ZHdOa08rM3YvNk5WbGxwV3UrdFZmWHpsR05EK3BiYnFsTmd3NDRZKzNwVjVW?=
 =?utf-8?B?RXBUd3hwK2QvSnJSRU9WdWQyd21rT0NDZjQ5amlXTFo1RnNNdlUrQjA0S2pS?=
 =?utf-8?B?UUxRTkhBQm5zZUJLa1RLSVFCRFJoSG1JeVNFRFp3a3lkdHFhMEM1MGJqWnp6?=
 =?utf-8?B?b1V6V0N2S3pveVkzQ2d6ZzV3RkhPNEsycDVBN2lJNWFpNmlad0hHUmUwby85?=
 =?utf-8?B?MjIvdElsWFkrcWZ6c0d4T3RaRGJuMVpDalZJWTFuNUFhK3IrUllJUEdxRTMr?=
 =?utf-8?B?MCtFMkVtK1NRWEhWbTR1SmdBdTQ1MUJkTjY4dTkxL0x4dTFjTkZGYUhFUks5?=
 =?utf-8?B?RVE5TExLajVEaHlLdDlycDJxTW11N3hvMWxqaWRtZW1JbDh5NVVUcERTcGZS?=
 =?utf-8?B?alJPeFdpMjUvRGw1cmVjN1hZSEJzUDZLeDlhN2ROSkM3dUZzSGZWL2YxbDdu?=
 =?utf-8?B?NmNxQmptSXp0VFJzUE5WUzJsSFZuMkpNVXpNWk4vSXNKSmRSWnV5VVdZQlNj?=
 =?utf-8?B?QllwcnEvZkljZDJYZm1zNThyRVNaNGlUKzkyQnhUQi9GcVRsRkZBYzZhNk9E?=
 =?utf-8?B?TU9aT3BKVzRaclNySWtpMVFld0RDNEJEcW5lL0FUMThkckVPZm05RzhINHBV?=
 =?utf-8?B?d1NwbDRzZ1BteU9JV1FHQUJyKy93bzd3Y3FubENtZGNuSDVFYTZkVXVUbE92?=
 =?utf-8?B?eWR2YzlONUI4OG44dzJjN2UxQUlCM2lLUlp2cmRvdXJDMlJlNHJ2bUJpeS9s?=
 =?utf-8?B?cFlpeUpsT3kyN2MvOTVSTm43K2dUT2lRRTM3dU5rODJqeFJUYkQ1WjBDcGJH?=
 =?utf-8?B?bVdJbFBFVkNOdm9id0FEWVBQTTlGV1JkWFN2RWdDYlh4Sit4T3lpY2ZKZS9P?=
 =?utf-8?B?ZHNTR25zc3lpdXo3a0NKcjRVYzljcXkvK2k0cDRraGtvOERxNE4zK3M2ODVF?=
 =?utf-8?B?eG9zQ3NuZWFVSTVlNGhzUnIyOGVpSk1ELzlKVlVLa0JUNGEzaXdLcjNLTnJI?=
 =?utf-8?B?dWlTeXdCbVlISXB0N29OMUFwdXhySG5FOGVwUW5YLzdpUDZVb0NleENrR3ZE?=
 =?utf-8?B?Wk1UdlB5T1paV2ZCVmJwd3U3UTBSUDFqU3YyM0JjZ1U4ZDQrSGFzSmlLckQ2?=
 =?utf-8?B?NzV3S29qNkc2TnBwMkkrMjhDSlU3YXg5MXVBZEF1SVg5UDAyMVVGVnpadDZD?=
 =?utf-8?Q?1kJCEKUwCfcfsKhXzu/8Ewcau?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QT7N9oZUm+pPh6u866zikRso+WfTnSU5gT21BZKMQ2atSmU21zkpznKo9uCc20GKZV5SvtmE2sbwlQ/S21PWLI3hRtKZFMsNfjQCHFSVN7FhXxl1NL6PH0W7aQ4g8nHjM0VZPCMY8MRVKq0HQiPf6QYzt7wLak1lnf6LnurLd6YUWwpFddIlBy5s8IfDRgVC6p761+UtsL/dv0GL6+EaP75dBQ+9hDr2WapOL+MV0atMxo+R8IznMLrG46B9ULZ6WJ2WMylCe3EliL1hAqN73uz6FTxyWI2CvN2O2zx245Y0FONP6vKzmaywOqZD4QXpPg+nuqrHKBwo5fqWwDXI80BaQOkEJ0GSOybvqa5ilMe/JTjUbOg7EDkFd9sWeKTmvgLDfFNLnnZsZAD7nEaN0yreWIyKJe6EmXH0pNowAK0BMrA8K/z5Eqyk701xsN/Pun27uL0T1GaXJLtre2l2TaoBK8C78P0z3/6Z/pReKpsi4PWCyX/UzNQNhvWFTYAmi5N9lsmazcq+hNZtlWH1CtPDK6xLrHObp+9OzhOUjnllR4EUo1WAoKIxglyk6mOeyUxsBvXyj6WPn6uv/kQcFFUv3mLv1QYjQVlprhM1r38=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 298253a5-7bab-4ab9-1625-08dd6d91261b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 00:40:33.8068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Siz1HFpi6o9uTuZraE2gLAkRYqkeqjv0A0ABmFDF1EPYs7nO+3nK5VWBfXYqik7cb6tDijKFsM3rvQEcC3QM5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5092
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-27_05,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503280002
X-Proofpoint-GUID: zsimgL-vVq11hi11ygtxm-7F1IlW9i0x
X-Proofpoint-ORIG-GUID: zsimgL-vVq11hi11ygtxm-7F1IlW9i0x



On 28/2/25 13:55, Anand Jain wrote:
> v4:
> Fixed the double quotes in 1/5.
> (Thanks for the review! If no other comments, I'll push this set on the
> weekend.)
> 
> v3:
> https://lore.kernel.org/fstests/b297a34f-4c09-48bb-86a3-fea50c364ba8@oracle.com/
> 
> v2:
> https://lore.kernel.org/fstests/cover.1738752716.git.anand.jain@oracle.com/
> 
> v1:
> https://lwn.net/ml/all/cover.1738161075.git.anand.jain@oracle.com/
> 
> Anand Jain (5):
>    fstests: common/rc: set_fs_sysfs_attr: redirect errors to stdout
>    fstests: filter: helper for sysfs error filtering
>    fstests: common/rc: add sysfs argument verification helpers
>    fstests: btrfs: testcase for sysfs policy syntax verification
>    fstests: btrfs: testcase for sysfs chunk_size attribute validation

Applied to the upcoming for-next.

Thanks, Anand


> 
>   common/filter       |   9 +++
>   common/rc           |   3 +-
>   common/sysfs        | 142 ++++++++++++++++++++++++++++++++++++++++++++
>   tests/btrfs/329     |  19 ++++++
>   tests/btrfs/329.out |  19 ++++++
>   tests/btrfs/334     |  19 ++++++
>   tests/btrfs/334.out |  14 +++++
>   7 files changed, 224 insertions(+), 1 deletion(-)
>   create mode 100644 common/sysfs
>   create mode 100755 tests/btrfs/329
>   create mode 100644 tests/btrfs/329.out
>   create mode 100755 tests/btrfs/334
>   create mode 100644 tests/btrfs/334.out
> 


