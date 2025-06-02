Return-Path: <linux-btrfs+bounces-14354-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A55ACA882
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jun 2025 06:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ABA9189C35E
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jun 2025 04:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69853770FE;
	Mon,  2 Jun 2025 04:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Vbn7scao";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="urWdlto3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04C63FB0E
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Jun 2025 04:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748838264; cv=fail; b=gAoj0KNVzSE4ecjBlOgcpUnPyRVTxhs1hAKOe1EaU0/gXDdtFZjBCEW7S5eDZZD5j2qp9I7lfu7SGoDJDcPyy7a9nOMqco8UX3sHlB7E84fs0rSmSzbVaUHXjme1D0YCms9rIW6+gXKsEXicmX4ss0NBt1pB6REuWiYpFUx6RXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748838264; c=relaxed/simple;
	bh=j79ZMW4v6JXrGbGGl/d3Kv4GAkMlb0yMQxdDu18RcrY=;
	h=Message-ID:Date:From:Subject:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aemvluwdNPxFsClSJsLDm3Y7mRKSS5Q+Nh6hwTMIxzVrZ4MVRab4POCKok2o5VLtYS/NcSEP6IefVeNv6T5HRYgMIWe93DKDSD5j98r2l6PHRlNezsMNmAQFXKrKoIy9h7Lo7poc69k+MQuI1AAzQQfTL6B56b5ZRNzs22K9xUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Vbn7scao; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=urWdlto3; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5520KlLB029886;
	Mon, 2 Jun 2025 04:24:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=zE9OMvr6h09p9kK+P7xir0NbSOqzNLsB7dXe+NlvTnE=; b=
	Vbn7scaoZ4Z9qdaESsOTRvDnB4rYzIzybaxFbMBBHnsYII8m1HjPAbwDNVT22jJ+
	zEgQAUq51L11uP2aNhW+muL0W9AArbkiDH5sDTe4dGFPWejFd+TYOGZy9Qq7Hu/t
	iF+wTdv5Ki757w6uJzGOr9Ti72Xkv72qKcTcgBDU3G0+Sa6dZbUm2tkUPELy9Jje
	AN2pi2lPzm3x2Kd7AkdLgydovkMtcCuDfsmHXDs0Gfj8goGVVW0c/o4F188Gmnp8
	xM3imF7atmxgWs0PY2rxhy+SuZDq+BtoqJkoZuZD/EMsfaubb6360jgwZfnP2C7x
	qCSShAFIwen53r779JWhHg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46yrpe1rr5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Jun 2025 04:24:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5521i28U040721;
	Mon, 2 Jun 2025 04:24:19 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02on2076.outbound.protection.outlook.com [40.107.95.76])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46yr77qqny-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Jun 2025 04:24:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RBQyLtx+v1wqlV4SQo40fUUng9t9o4fR2k+9/M7K9/YTCDcbuzx5+Efi6jKV3UxLEhZ1PwBvI5x/okTBmaKA6uovkraBpEO2+WD9lT8gLN32fuxD9TbwZiqcitou7s5K4u+EzmkQFXCHwKq6+F71hVtRVgGrF42rzgiQS8b3IVeGz7+0NJy2XXdCLSqByKfEf+JYe+jBJfNIb9aNZgf9IEVKcwkHTKuG4UJn5Eo0k4ys4SxxO0OLpltOxMYmhYFw/9009EUpPczCe9tXMbgxxiCRCkVh684pZx7HoUXF/UaMXthlJr3Fikq5m2pxKwNSULKjm7P2QYdq4MwLSvZH0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zE9OMvr6h09p9kK+P7xir0NbSOqzNLsB7dXe+NlvTnE=;
 b=pn87RywSc/RRFAP6loPedgeLv6Npl6C0sWwmwFYyCIZPf8so3Er6DQAvMlCgWE5mVSbyTRRRMRf7OzONM6Xu9FxPRVCQsm8+G+/95xoy2sscCI9hS1c2+20HvcKjDRyehZGUwZGtgHDmYtHAk6nT62U2HbnyiSH1utmno6s3Qn2lUrxUEKR0v3HtRmclWIAZ7e4vmycHNNF/dUBpYsUyBzUw+XPCqXmVI4MPZC3imKRoJTuJA83ik+5dxB7qzxLNnSRmx7pyrlqz6wWMQ+bzlbhCvJdTu6f0cb3DfIY0w4+iMnZ/V1FyRlGnB6hJq2Xyi7HIO6UWCOy6JFZDUwIbYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zE9OMvr6h09p9kK+P7xir0NbSOqzNLsB7dXe+NlvTnE=;
 b=urWdlto3oc7aGLGXhzQaFzfE6hUMTqvQUI5/HLtwF3uiAoYb2iQb7L65Jx1Y3XHR1PMz6rZO++WD9gsSP8xkk9CwHhd1qUlKQ5xsN+Qzf6WMuxvE8hgfePsEwfJRYA8vhLFonpBj/E2ifQZ3Yv2zLQp9mizb5aN5Xwo1dwB1hGU=
Received: from IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
 by SJ0PR10MB4736.namprd10.prod.outlook.com (2603:10b6:a03:2d6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.41; Mon, 2 Jun
 2025 04:24:17 +0000
Received: from IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5]) by IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5%4]) with mapi id 15.20.8746.030; Mon, 2 Jun 2025
 04:24:17 +0000
Message-ID: <67bf4ef7-6718-4ab8-85c1-8b8035a8981e@oracle.com>
Date: Mon, 2 Jun 2025 12:24:13 +0800
User-Agent: Mozilla Thunderbird
From: Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH RFC 00/10] btrfs: new performance-based chunk allocation
 using device roles
To: Ferry Toth <fntoth@gmail.com>, linux-btrfs@vger.kernel.org
References: <cover.1747070147.git.anand.jain@oracle.com>
 <fee4ece3-b5f6-4510-89d0-40f964da2720@gmail.com>
Content-Language: en-US
In-Reply-To: <fee4ece3-b5f6-4510-89d0-40f964da2720@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0115.apcprd02.prod.outlook.com
 (2603:1096:4:92::31) To IA4PR10MB8710.namprd10.prod.outlook.com
 (2603:10b6:208:569::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8710:EE_|SJ0PR10MB4736:EE_
X-MS-Office365-Filtering-Correlation-Id: d7501c85-1adf-4d0d-46d1-08dda18d5630
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ckNWSVBrUXN4V2xoOFpRbFVVRmhmS2hRRDR1VEpYTGVFU1oyQUtXY1JKQW9F?=
 =?utf-8?B?dTlUK1ZSN2RWaUVwTUtieUc1a25NZW13TElzZWpmV0hVa01JRTBPWjNxTnND?=
 =?utf-8?B?RVA3cDdVQUFjNnd5K3VyWERYNTV0cVlwRWE2UExrWmhsM1RZZWJsdHIyUWRo?=
 =?utf-8?B?ck5vcjVBWWZoSnFYVnBGeW1RdUlLQVJONXhTUWJ4eFRLalpWVEtqVG9oN1pP?=
 =?utf-8?B?NDhGTndid2RLdldvcFdLdjR5ajFMZFdNbWdyblBzakpuSWROVHp2bXZZejFN?=
 =?utf-8?B?Z3VoMUlVKzBjV0JaMk1mOVc1YStTUkdQeWJ4UFdlM3U3MTQ0dHZJVjM0cmYx?=
 =?utf-8?B?eDkwcTI4Rjd6aHJlNWtzeERxSHIvVGVKV2pkVjJjem56bmM5dUpheTBGOFBT?=
 =?utf-8?B?dUQzTnVXaWlHbHE0ZksvNUhLMGYxY0JiZTBwV1FZUkE3MFl0aytnbGgyOHd2?=
 =?utf-8?B?NUZQL1RyQ1daazZvdVh6bHBQQ2JiTzdpTlZzV0R1VnVNS2FHdFRGWEloeTRL?=
 =?utf-8?B?QjhNZ3hhUlNIVnNOV2xXYXpTT1RhT3BXYkVqS2plOEZNZmtBRkdzbVMyQUkv?=
 =?utf-8?B?SXVDcXF5NndQaTkrM1ZjMFRaUWdMRHNHV05SMFg2YzkvSjBxbmc4dDEvV3pm?=
 =?utf-8?B?QUZIdTFrS0xFQnlyYmFWZy9oUGxSeDJHbTRrcnJPaFNZWlBjQVZ5ZUtXMjlj?=
 =?utf-8?B?MkgxQXprSllIOXRubWRsKy84bGtvUFc1K1B3Mkh0UEFFTURUVUJXanRCcVdt?=
 =?utf-8?B?d0s1L2JFUVdZZkpCUDU1V0FvYm1VTlp1TVdYbnl5VEZ6ZmpkUWx2aG1jK0RC?=
 =?utf-8?B?eEg1NURHNktldFY2TmlwS05PNHJmdmZSUkQ5eEZnRDFLSGcvei9Md1o4NDFn?=
 =?utf-8?B?dGp6UW5GQXdTMUp1ZWN6MW1lVEdzVm9JWU5uQ1dCaUw3WHZNRXpGODZxbkJl?=
 =?utf-8?B?MUdzWVdpanY2VjhCQUx4WU9XVmNhTVBPOHBUeFFqMGc0NittMll3SWoyb2dm?=
 =?utf-8?B?U1pqQWFNakhqL3I5QTdpRE4xaWNLRjNRNC85U0V3ZERaMWJUSlYvZXRhcktG?=
 =?utf-8?B?cHRnaGt6N1g3d3RFbVB0UHJTRGUwS0o4dDdiSjhRRWRWN2tab1d4UzRNdUZp?=
 =?utf-8?B?TmI4RXlqZHdRdk5uTkJ3TyszSUJSTStXTDNIYTlMbjRDK3l2Vjc4Uy9DTDcw?=
 =?utf-8?B?QnNPTnh3dDVNb0FvSmRpZldWcGVNWWhraGQ5bEp4UWZXTDdRK1ZvNGNobXA2?=
 =?utf-8?B?M0xrc0VhZDZFVkUzUkFocStGS1E3RTgxTFRWQjhDb3hMc1VkQUZJYXhBdDNw?=
 =?utf-8?B?TW1iR2YzRy85L0tnOWtPTHBwbTZacW91UE5ZcGlmK3A4NldWamo2MnhMMDJz?=
 =?utf-8?B?bFcwVllGUTZnbUtMTFkxWUN6S3BrSUNmSTRSSEpmZWQ5U2FPQkF3anRCaE5t?=
 =?utf-8?B?Mkl0QUIvNFNrNnhlR29QUDNTc2ZPOHdrdThLZ2IvemlreGVBOHB2alBmREs0?=
 =?utf-8?B?R1lLVUFneURNSmFlQ3V1YkFYaEd0aS9WZTgvcUtpNHFvek1ETzhQZ2RpbXI4?=
 =?utf-8?B?d29BcGpRTTlvWWtHakdSdW92My9SeXBmWVVBbkxnVnNoUUVFV2R2OW5aT2VK?=
 =?utf-8?B?bTJnbTI4K3IzUFVRVjA2YTFQTWxtajhqYWxacGNaWm9hbEhDV3hlYXRmWUpV?=
 =?utf-8?B?NW1XdnFQN1JMcUI0aXEyUjFNZmh0alFJT3RmTy9PZ0NHeWpmUVAzSTA1N2Z3?=
 =?utf-8?B?TmZBR21sNGlaZXIvSUtiYmV4bnlxRXlSQWpqV0hHbklCUWhWNGNqODJTaXhG?=
 =?utf-8?B?STRHQlc3dXd3aSs0T1lacXN3RjVVNzh4aGcyazJVci9NWG5vRllYRzExM1Nt?=
 =?utf-8?B?S1lmNWVZU2ROZFNVYmpVWjFldEVSYXJkRzFXc3VQUUoyalRHSUJtQ1d5NzJF?=
 =?utf-8?Q?cH8iVmR7jM8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8710.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eE9mdXJEcWlzL2psZWdIZy9Zcm1HSGQyeitWTHREUVQxc0dwNjBRZ3lCa1dY?=
 =?utf-8?B?ZXltSG9ZWUZ3ckovL0poTlFMbzl3VGdFamNaRlpnWlpPckpoeUhwWHFKK0Z3?=
 =?utf-8?B?OUhYSlVsSk45bm0wRXNNSkpZMm9NQ01uK1BZNWdlM29xaFNLWkpDTnBzTGpn?=
 =?utf-8?B?TVNCYjU1TmwrY04xK3JiYVFmZkZyVGNwakU2N01FMGlLVVczaWh0U1ZTNFAr?=
 =?utf-8?B?Yk8zdzBVZDNLS2VkQUpZbWFzYkhSN0U4MTA4UFZHRnRsUVh4NHNBeE9XSDln?=
 =?utf-8?B?WTIxK0Jnb05IekRJS0RkaEdCRkZIV2x2TVlCZkxHL2JXbTB2U3p0RCtnc3dL?=
 =?utf-8?B?QjJwWjdnODVFTy9DeHE1N3Rkcm5qVlIycm5xYzRhSDZHMnMwSTVqMXRoVzJn?=
 =?utf-8?B?UlFkM3ZOVzlpcDJWN3JwT1ZLZXZ0N3BNQjlkSkNYRzlrVWFLcEpjMnVreFc0?=
 =?utf-8?B?WFV6MHU4MUxlYWtyektJV2F1OFVpZHdRRHJSQ1ZwRU02bXo4UHhWZTliQkg1?=
 =?utf-8?B?QnJDcEI0TFl6R1FtSmtsUnFqTERacTdZcnpQSkJKTG0xdjhKVWFIay9KRTdO?=
 =?utf-8?B?c1I4b0tzeHJWVUNWS0psZUZpZy96U2QrRHVGZ2cwRDdxYy9KbURWVDhyVUdJ?=
 =?utf-8?B?ZXBKVTRsNUpxd0JaR2lGUG1xQmdqN0RGeUNaSmxtMUtlcnBSTDlFUmpSbWov?=
 =?utf-8?B?T01pTExWQmFGcmJFUEZwMEhhR28wY1NPRmdMYlJVZ0lGQy9JUUd4MmRlYVZP?=
 =?utf-8?B?bVo0RVN2R3dyQmh5NUdyWlJ5WXBqSTc1R29TMWdXcXJBV3Z4N1ZvdEhsdS95?=
 =?utf-8?B?ZHA1aG9VUWFxZDU4TTZ6OG5YVUhEbjlBcDRSZEx2WVlTUVh0Ync2cTMyd1hB?=
 =?utf-8?B?S05icDBEZ2VrdW5iRWwwYjIxK05GMlRselZBTnhwNE1vWmJqeVJRb2djWkVt?=
 =?utf-8?B?SisvR2w5NjlqMmVlZTYxRmp1aTU0cTEvUkVsK3VFcFZHdkhzbzNHU0gzRzZ3?=
 =?utf-8?B?UTJJUVFQWVN3YU5FZi8vbjFLSHp2aHpWbzVaN1NkOG1HR05wUnVEd1NzekZM?=
 =?utf-8?B?RHIrZ0ZEVGRXcUR0TVRzNyt4eHRlWC9vTlEyRHMzRmxvNWUrWms3dWdtclFU?=
 =?utf-8?B?MVdlRS92MXQzYW5zZy9zWkxWRkpOSGkvdmJnS3dLU3RaNlY5a3F6NlRUV1FB?=
 =?utf-8?B?NXdDdWJYdGtQMkJBZ3JoMnZuOHVTVFNDbWJyWVkwc2gxMmlnNGU0eFdzTjRs?=
 =?utf-8?B?MG12SXVBSksvcWJVY0FOK2dKRnpDaHNxaTlnMG5iQXQzb3FSWnkxckZveFNB?=
 =?utf-8?B?cEJVeWhFVUtXWU1xWllrOHRac1JDZmhGTzNQa3pvVWhyamhNSUZIZU5NSkdG?=
 =?utf-8?B?L0w4d3A5N2xjZndPRktTc2h5eEJHTDJta1R0TE1Db1FMb3dXZnZnMERnMFJ5?=
 =?utf-8?B?OWZHZmpxVUxYeHk4aDBCbU1MQUdRa3ZLKzFUTTZjUGhYRXRhUHA0L2VqSWVw?=
 =?utf-8?B?amhIZ2dDUmgrV1lTdEs5M2RGaUV1K25zYmlsQzFnc3djYlFaZ2xPdS9HWTgw?=
 =?utf-8?B?WVVHSEp4RkNIOHJWekZVTVpqdHorc2kxLy9UVHBzL2NZRzFpbDIxd2pUcENm?=
 =?utf-8?B?dEdZZEZ4K2N3ZmpjSXRNdkNvSmNLMy9wVEMvekVSVExRZm1YVVFteUNGdVMv?=
 =?utf-8?B?UmR5dUs0T0JUWUdHZlhnWk4rT09QaW9id1JWdGJ0MEs4Rmp3cUFucTVjWlQ1?=
 =?utf-8?B?L2NpZFBTZWJDMktLb1VKOVdSWWozRHVpM0k1UFRBTVgrTldBZkwvS1BoclZ2?=
 =?utf-8?B?SDZuSTNDNTZxRWNRUXI5akRCY3lUYWMxUFlWbkVycnhIMU1NSDEzOTZoMlJi?=
 =?utf-8?B?d3Z3NTlJZFZCWXZ1QnZHMDJSUUhIc3ZXUjRHMWRMYkN1QnFrMVJCMWdocG55?=
 =?utf-8?B?UXlTejZsMEs3bzBodmdGeGZtRHN1SGhpL25Qd280QW42Q0w0TDdPbmxFYVZk?=
 =?utf-8?B?ektLaWNsM081RWZvR1ZBRnRQZXdQMXQvS1BJNFpnY1dhd2YwZzQ2T0tCTXVU?=
 =?utf-8?B?SjVOQklJd2xIK1ZVZG9oa2hQdjB5QURDdm04dGY4Y1hoL0NXOXMwZVRrM2Vr?=
 =?utf-8?Q?5nqForPlmmuuf38RtavBqyyBB?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tQ6mD0S42WvBV+7UwaePQ0BRKItQCdDmOWPAB4fUFijaSfh0N+T2w5OLaYz/HgnYZiUNdBHasJ9kbbtgFxD1I/JV3C2g6pWhbrPmG6mtAx3waDMhz2QFmNEP+lwzJhmwOJsnrW6PPOJ/89a4nSukU3ca7Hn9iVzni2ydQIWrnbUiA6dJshuaBklxowISu51y8SuOgPcmvVdnrjOsWUW9orDk6WSMAwshwtPRxIuJ8kecpHBIHBXO08iWCF19pIBpFhsEPQmM8oNSMUV75ugNZaTxbaGnUJ9n6pLvn8qLXuaDFf3+/VZOaJEQRlbAM1vEHwodDDyaF7Yd4DeE5jlhploBrm0hyWcNB+dtI+/ucx3du86rW763EYesD610zP+xnjtigQUNElNVGUKYAN28ip/v74wdQJhm2ufWQhIGDvfBqUHMso96TzlO8aHIsLKV3NO5SNQhJPX5hdW4LPX3j2iRCWwvGHtdFn49Be88zFZztgE9WjdGeCAbBCxx5hSi+I32Evsl0zbHPF/NRq90/Yk5sjnnrSS3rWAKnYnbw4VHRIc2Ck/oAt+rX8GV7A0FifsCCL4xncS2GCCqBypcHmku624KeWfjnVaLpW/GOK8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7501c85-1adf-4d0d-46d1-08dda18d5630
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8710.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 04:24:16.9111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h8BLmxIlqMS97X0FUQULEuN90Au87zAa1yWpu5dgyPpQ4+2rHn8BUUnZOlxyf6sghtl4rHJzTnSL701pzsYfdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4736
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-02_01,2025-05-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506020034
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAyMDAzNCBTYWx0ZWRfX8AaQu+6IXXfL Wyzv7Y6vIxuJiD9MqVwdC2n1pP0QKbGS7Hsz8Dd2c0rj22kX+taCkz3bQWLAnJhse/CC5F9SmAs ZrOc6lM3yggURH5Kl1Z/rmMvyEyfbK9GsgD50MyY63FDWv+yD1mQy0m7eYSHDpg2GiFy/YbK3h/
 mRCMrzRkmAkAqOHjzb+C0OOEHKQSouVkGA0HiwsriAFs7GayhDMlcTBfixXzZcwME9hfOOFcPZS +t/2YHMPrp5Q0GPoTi6+IMLwhNq44xCi24UUg5OFdC+LiguKB8kVtn0sz/QsUdipAbtosPZYZeS b0GsOAUPTBOD3uGi+h+2XSDWOY1i5WFwbgmbumiNV72JSO6xuGrRUyQlVg1QH+TO6xGAGSGVzdC
 0EmKcYqzP1oSQK9mQ3Afb7pxyAjfSxQeVNkzH24cgelCrB0U9QUoE6TxQ819Mwh0VVzI7wL9
X-Authority-Analysis: v=2.4 cv=NN7V+16g c=1 sm=1 tr=0 ts=683d2774 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VnqsGTdlBYqaH7PNJsYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13206
X-Proofpoint-GUID: qkEaE4MdL-yCKSjlClRWlN-_QxnDJaFV
X-Proofpoint-ORIG-GUID: qkEaE4MdL-yCKSjlClRWlN-_QxnDJaFV

On 23/5/25 04:39, Ferry Toth wrote:
> Hi,
> 
> Op 12-05-2025 om 20:07 schreef Anand Jain:
>> In host hardware, devices can have different speeds. Generally, faster
>> devices come with lesser capacity while slower devices come with larger
>> capacity. A typical configuration would expect that:
>>
>>   - A filesystem's read/write performance is evenly distributed on 
>> average
>>   across the entire filesystem. This is not achievable with the current
>>   allocation method because chunks are allocated based only on device 
>> free
>>   space.
>>
>>   - Typically, faster devices are assigned to metadata chunk allocations
>>   while slower devices are assigned to data chunk allocations.
> 
> Finally a new effort in this direction.
> 
>> Introducing Device Roles:
>>
>>   Here I define 5 device roles in a specific order for metadata and in 
>> the
>>   reverse order for data: metadata_only, metadata, none, data, data_only.
>>   One or more devices may have the same role.
>>
>>   The metadata and data roles indicate preference but not exclusivity for
>>   that role, whereas data_only and metadata_only are exclusive roles.
>>
>> Introducing Role-then-Space allocation method:
>>
>>   Metadata allocation can happen on devices with the roles metadata_only,
>>   metadata, none, and data in that order. If multiple devices share a 
>> role,
>>   they are arranged based on device free space.
>>
>>   Similarly, data allocation can happen on devices with the roles 
>> data_only,
>>   data, none, and metadata in that order. If multiple devices share a 
>> role,
>>   they are arranged based on device free space.
> 
> I can see the use case for large pools of disks used in server 
> environments where disks get assigned a role.
> 
> For desktop use I would like it a lot better with no roles, just a 
> performance-based chunk allocation to select between a ssd and a hdd. 
> And then used more like a hint to the allocator. Really nothing should 
> go wrong if a data or meta-data gets allocated on the wrong / sub- 
> optimal disk.
> 
> This could then bring back the old hot relocation idea, finally.
> 
>> Finding device speed automatically:
>>
>>   Measuring device read/write latency for the allocaiton is not good 
>> idea,
>>   as the historical readings and may be misleading, as they could include
>>   iostat data from periods with issues that have since been fixed. 
>> Testing
>>   to determine relative latency and arranging in ascending order for 
>> metadata
>>   and descending for data is possible, but is better handled by an 
>> external
>>   tool that can still set device roles.
>>
>> On-Disk Format changes:
>>
>>   The following items are defined but are unused on-disk format:
>>
>>     btrfs_dev_item::
>>      __le64 type; // unused
>>      __le64 start_offset; // unused
>>      __le32 dev_group; // unused
>>      __u8 seek_speed; // unused
>>      __u8 bandwidth; // unused
>>
>>   The device roles is using the dev_item::type 8-bit field to store each
>>   device's role.
> 
> I think filling the fields with either measured or user entered data 
> should be fine, as long as when the disk behavior changes you can re- 
> measure or re-enter.
> 
> The difference between a ssd and a hdd will be so huge small changes 
> will have no real effect.


Yeah, for desktop setups with SSDs and HDDs, the distinction is clear
and stable, so assigning data or metadata based on device type makes
sense. It’s straightforward to handle statically, and a
--set-roles-by-type mkfs option will make it automatic.

Even if the SSD temporarily slows down during a balance, we’d still
prefer to keep metadata on it, assuming the slowdown is short-lived.
SSD performance typically recovers, so there's no need to overreact
to transient dips.

For virtual devices, mkfs --set-roles-by-iostat should also work well.
And later if performance characteristics change permanently, a
balance-time option like --recalibrate-role-by-iostat could
re-evaluate based on I/O stats, confirm with the user, and relocate
chunks accordingly.

Also, I'm trying not to introduce too many options or configuration
paths, just enough to keep Btrfs simple to use.

Does that sound reasonable?

Thanks, Anand

>> Anand Jain (10):
>>    btrfs: fix thresh scope in should_alloc_chunk()
>>    btrfs: refactor should_alloc_chunk() arg type
>>    btrfs: introduce btrfs_split_sysfs_arg() for argument parsing
>>    btrfs: introduce device allocation method
>>    btrfs: sysfs: show device allocation method
>>    btrfs: skip device sorting when only one device is present
>>    btrfs: refactor chunk allocation device handling to use list_head
>>    btrfs: introduce explicit device roles for block groups
>>    btrfs: introduce ROLE_THEN_SPACE device allocation method
>>    btrfs: pass device roles through device add ioctl
>>
>>   fs/btrfs/block-group.c |  11 +-
>>   fs/btrfs/ioctl.c       |  12 +-
>>   fs/btrfs/sysfs.c       | 130 ++++++++++++++++++++--
>>   fs/btrfs/volumes.c     | 242 +++++++++++++++++++++++++++++++++--------
>>   fs/btrfs/volumes.h     |  35 +++++-
>>   5 files changed, 366 insertions(+), 64 deletions(-)
>>
> 


