Return-Path: <linux-btrfs+bounces-16069-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 051A4B25977
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Aug 2025 04:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED09D3AC486
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Aug 2025 02:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82ED124DD11;
	Thu, 14 Aug 2025 02:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i4/MdL5G";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Cl1uwGID"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F124115C0;
	Thu, 14 Aug 2025 02:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755137824; cv=fail; b=V5E3FcO6tXLtkLMEBXEzBtH4MeoGJ7CNj0JYHdqeEP0aLYz9V4K6717LMEhtMEb9O9wPquJhuRcLnM9oIrg68H7DR1VtVht+ghizPcW21L+tG3P/MR5fpKE+lYF8KC+5BuOOu8K8BRdQL1rxr5JuN5GANgXLkIbvb+dMOtqY5aA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755137824; c=relaxed/simple;
	bh=sj9WMfU+J58v/++hHwY8XOjX1WJMJr55WoSYf7Ci+uc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qKuPfq2FlZtwcDtwbR77Jl+7+QzcufO49uRXTF0oc3FxtuFm9jJymeFV8yxQJcNTbKQ5TFJrctbj3DQT86Caa125TfaPPBUMEtqgRhNoLfZbbtiikHM+2CDRS2e9J1GCVmdp0OrghS/ATxuUg2rT2GxfSnrPr5Ry23zGeTBRVM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=i4/MdL5G; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Cl1uwGID; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DLuJt9005875;
	Thu, 14 Aug 2025 02:16:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=T+SNFHLgteH6fzetQvfyQ8dyEiV9qiblAiMAuM1Q2oY=; b=
	i4/MdL5G+mLKkk8C4CICQoh1KBDeTHtRbCaITNvK/sZXE0bynYWH0JqUo7RC4T80
	YADCSfxpTL0dyapdngG2UlZPAjcJ0wdRpN/D8g5h6EhCi8xRQkhyhEhgddnmOCOB
	h3pUdEG7scLBYqCxEyoJDUyqGpiM+/HwsfMi+EFQFqx0+82RaUkfaJLnQfnjwtf5
	69FtvhtpdsODwxMbQEielcvG2dsnFc1wxwLs4f2qNF/iVjHFZBm6/F39FDtZx4kr
	Om0guwmpZP8XlhFX/1G2+qD7cCe+sUEABwUFrX8M88rowUogqwkT6A98S6AzTS81
	j30lvPJ0EYME4fq1y0jyBA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dw8egrnj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Aug 2025 02:16:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57E1CEap038569;
	Thu, 14 Aug 2025 02:16:55 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04on2040.outbound.protection.outlook.com [40.107.100.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsjpd8t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Aug 2025 02:16:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gGh3nYIkb4spOsClUp4Q55h8S17tDB05jTceti9YvVOT/BqfCSZ1A5BDBCN3e6oSS0OdADsF0vELpUAi9uu9zkhKIDhPQXmCUsSGFo2b54TEMJOzk12kY5VJMk0F06JGIt6QMijnyO0hGfO9H6oHgjjThMVQzQ6ISHOn/C5z29nUEEIdbPgo1BEa4qrtFT4x2P7ougZmrE5Z+eOEA5lq6gCI5g3mD0BrKw3iFUnUiV+B4oSrO420ngPpLAK8L3G/j+zsXS9D+rEQFaMrnRUp+1yoszVoGVstQgwiM9Z+BBl1/1tR9PVJxfOv4PnoKLJ73+9DdeTK1R7GVQZU6TeaQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T+SNFHLgteH6fzetQvfyQ8dyEiV9qiblAiMAuM1Q2oY=;
 b=yIHZwyAnmfTdM/sDjEg/prXgItZjIMBz+ge1DyxbcOOacxdn60ak48nrWToDREqe+J1nJFPH+mZNPech/s99jHN0Eofq6bnLT3YtXl0+3c4d0HeHK+iqgef3b4NHvmBzvp4j+Xyz6t0N5XCACtHFMPmq0ojs/74ciIfhl3AJa0nKTpbXLAOfcxH3WBLIpxLM2gzUDgIaJ0KX5rc7QoPVs1QNhUJZ/QcHNPzoyaPyQvIsO/I/+lvVy3RPIX7xN2zV6xWQgI8Vy8JisGeofCBZSAb7Yd2UnXaEz8NmIWEyn0AxVLOpFEM0I+DFQb7Tnel8hpTnf/yxS47Ra7tC3wW8AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+SNFHLgteH6fzetQvfyQ8dyEiV9qiblAiMAuM1Q2oY=;
 b=Cl1uwGIDrt+FhxNdWi6pPCC+AwptRKEdjZXXAs7+M+PlBhwCZ+ExnjitiaW9h5YS9vuJKko/vDZDcXKedUmRQ1gaXu300WA3uLdAndNL/J4LjXqzKMpjlYTHYlGAyabHIAiGg5w+jTjeZcbethPJ52utQRSoyp3bPbPPi+Nud78=
Received: from DS0PR10MB6078.namprd10.prod.outlook.com (2603:10b6:8:ca::5) by
 CH3PR10MB7458.namprd10.prod.outlook.com (2603:10b6:610:15a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Thu, 14 Aug
 2025 02:16:53 +0000
Received: from DS0PR10MB6078.namprd10.prod.outlook.com
 ([fe80::edc1:7c2:8fe8:a6b]) by DS0PR10MB6078.namprd10.prod.outlook.com
 ([fe80::edc1:7c2:8fe8:a6b%5]) with mapi id 15.20.9031.012; Thu, 14 Aug 2025
 02:16:53 +0000
Message-ID: <7004f11c-a84c-475f-8267-a815e43f7726@oracle.com>
Date: Thu, 14 Aug 2025 07:46:47 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests: btrfs/237: skip test on devices with conventional
 zones
Content-Language: en-GB
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>
Cc: Zorro Lang <zlang@redhat.com>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20250626131833.79638-1-jth@kernel.org>
 <5275455d-3cc8-430f-90e4-533e6572ec97@oracle.com>
 <9e7e864c-fd3d-4d50-87da-b8ded6765b9a@wdc.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <9e7e864c-fd3d-4d50-87da-b8ded6765b9a@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MAXPR01CA0116.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::34) To DS0PR10MB6078.namprd10.prod.outlook.com
 (2603:10b6:8:ca::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6078:EE_|CH3PR10MB7458:EE_
X-MS-Office365-Filtering-Correlation-Id: dc035dc9-eac3-45ba-30c5-08dddad8a271
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aXBZTWQ1endpSnRTSURRTkFTMzBzZ1RBNHFPbDZLQTNGM1c3UXE0OGRYRW5C?=
 =?utf-8?B?MUYxUjZkNkxrNWdBNThtdlRBeDZibFAzQmZyZVBnOUJNcHpQcTRzQW5nTHd5?=
 =?utf-8?B?SWZzSjVkQ1F6b3dyZWc5NUVIYjFEUG4zRStKMDM4Mkgybk10YlpVcDdiL2dl?=
 =?utf-8?B?WFNWYUN1R2dGZytURVczRGs0ZCtiaHI2c3VOZnFrSStmZ3F3OGFWVDZjNW1F?=
 =?utf-8?B?VE1ybWtzR0pNQkoxMXRqL0M1aHdnaUx1NVhJK0d5TzFBV1ZqbUhITUdQUE5N?=
 =?utf-8?B?Wnk2aEk5SksreVREaE1aandaaVJTNFhYZ0ZnZHFWVG91N1NsRkZEZEFBQlgv?=
 =?utf-8?B?STBkMzZuajFMSjZVcHF3ZGlhbk1SN1pKQ25uanhpSmFPOW5GSnVCbTJTNnNV?=
 =?utf-8?B?ZE9aYkZaTXlBYmU1bEJrWFUzMytDbXpRS1R2ZmhMQmMra2VSWG9ESXJneVhI?=
 =?utf-8?B?dkFxSE4xYVVRK1Z1T1RRdnBVQzQ0UDJLVVBkZ3NuYjdiSEYrTWYrRFNVeDh3?=
 =?utf-8?B?aldsbENGR2ZmOWZwM21XMEUrSzZRanNOMFg1VGNScUZCdE51YkpmS3N4aGJR?=
 =?utf-8?B?T2cvdERqRGJ0RnUvQXlhQUJZeE5JcnZkWit0dGM1K2dKaThrTmtTdWxzTVVF?=
 =?utf-8?B?K0FnR1JDczJkd21ydmdsejltZ0xzM0lkY1UzY05LNnhOclphVVdoVm1ocEU5?=
 =?utf-8?B?TTJxNDhxSWtHckx5WmFQMVArcnB3dnJpUlZaVFdZSC94Y0FsbVFVRDFXSmQ2?=
 =?utf-8?B?cDhZbEJGaXE1blhzVjJBbEp3b3gxTUNmbzRiTVQ1MkNCZ2pnK0U1TG9GOVZ2?=
 =?utf-8?B?MUhCMlpzaFdOaXRwUkVSc1dHQm1oemNJbTVvMGp6T2NoaTNtSm9CQ21OdzZK?=
 =?utf-8?B?blhERXNvbnpRekNkdjlrL2ZHUWtVdGRLdUgzL200SXlPSjNFN2dKdWQ1Y2NF?=
 =?utf-8?B?SkxqSlZEMWpVcmhhUVFXSEZjcEdSbFp0eDA3d05uT0lxQVVPc0FXVUxnVG1s?=
 =?utf-8?B?TkxKa3A2eXhWNUdwRWhGR3pqbnRwMytkb2dMNzZ1NU5DdE1WZVMybDlkYW85?=
 =?utf-8?B?L0lKZE5lUG1LRlplUC9qOUl6aDc0ako5Q0IrUEtDdXY0UmFqVjErQTlFc08w?=
 =?utf-8?B?V1M5WHhVZGdQQjI4TXVmQ3c0NGJ0UTJYZ0ZyVXBqMHhPamgwc0gwRzV4RG9v?=
 =?utf-8?B?c3FYMVRTYUwvYnEvdDhnNHVDbmRLQkJYZUVYV2VIUDVvSVlmZFJxYjRvN0dS?=
 =?utf-8?B?VmRIMWtvQmJsejRHVVJ3QmxyaC9lOFduc0IxR1FJZkVUczhHWUFaeDIxek54?=
 =?utf-8?B?L2NTb2ZXZCtTMWdvWG9zclV3ZU1GdXdEcG16dU9IbWVzUVFuTm5MMS9ONlRH?=
 =?utf-8?B?SFRFVkJHNFl1amZDVUgwYXN3UHp0RmJwaVo1aFI1Y01BOWxKU0U4aGF0dU5h?=
 =?utf-8?B?WFBMK3NVTjh1cXVjQ25tQUxwa2htS0lBV21UUXlCMnliS1dybVorVmNDUk53?=
 =?utf-8?B?dEtNZ3NXQndBKzlzMStqNTRkTVJ4SEpYdzhIMUZ4NkJEU2xPbUpLcHBtSFpD?=
 =?utf-8?B?Z3hxemFuNW1GL2Yyb29mY0RCblRTcGR4MFkydWlZaHN1SlNENmJibmNFU2wy?=
 =?utf-8?B?WURsS0x4eFJsY2pNSVA5UkJ4LzVNOE5odjhKUEQrTTFmOVRJS2VwU3BOTGRl?=
 =?utf-8?B?N016NWxJV0lWcUZhOW9BSzAyS0F2cVoyYUZNOEFLa0FZdFdQcDZyQVV5bklr?=
 =?utf-8?B?N2tEVzNrTUVvRnlCRkJhUFhhQTljNlpNTVdxMEZHbGtSeVVYaUlhNVdZM1RO?=
 =?utf-8?B?OEU5cnArbnVoZE1iSyt6dkFwTExZUjhDK1pJZHkxSy94RG05YjYvbjRrZ1M4?=
 =?utf-8?B?ajhqZDN3Z0hjcFpkYWpvVUx0Z2pUd3MrczR3YndIcHE5ZVp2NDdZR1JMRkRi?=
 =?utf-8?Q?NstIkGyUyH4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6078.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QjZOd0tGQlpaL0txRTV5eWVFT0R0TE1ScWg0cGRISDloQ1NPaXJHcmt2dEZy?=
 =?utf-8?B?NFlqVVNkYk8xbU0zc1oybHh5NGxzV21CTGFRK1pJSDIzUEpFcVhVcGwrUzFO?=
 =?utf-8?B?elRxQ0Vlb1A4RUMxU0JtUFRQdkgrRGtqbHVEQmdxbXFicTROWi85WDdnMHJj?=
 =?utf-8?B?VzRsVFRHT2ljbkhaUUxSUWRveFd6Q2lxeTdUY1NmVWhDaWtNRVN5anAvOUlK?=
 =?utf-8?B?L1NWdDFtZW5icG1PMFBaYUQ1WWE3d0k4VXhTMWowaERtck1oVERPOUNGeldz?=
 =?utf-8?B?OHRUdmdVRlBTeHo0TDE3MUErazNKNjZRNjgvaUE5aGZCcGpLa3hUQlo4S09E?=
 =?utf-8?B?bWNUN3lTTjRJditnOVNEb1djT3R1STQ2UDR5a2hKVEQyaE5DcjRoTGUyc0Ir?=
 =?utf-8?B?akppM0twUG5mU3BHL2E4b3g3V0h1YTZQNmJPSjh5ZUNBTUwvK05CMlhsZnZm?=
 =?utf-8?B?T2pRaStqRWZjUzV6M0lqL21yUUY1TXUxN3FuYUdxME5qTHgrU3V3RDducVVp?=
 =?utf-8?B?cy9xQTl0S0dVanZqTDlxYjc4cDVMR2FyWjlQcnNNeDIyNzR5cTd2TG5Nb0U1?=
 =?utf-8?B?aE8welhEM0dObk8zTUhqZW5FN2VwZ1I4OU9pbGN6VU9uMzRsYUh1STBZdkVB?=
 =?utf-8?B?b2N2SnRPRnlWU09KeC9FdW1wRTBhM1hXaWJLbE4zTDVYQ1dhM20rL2dYRVlq?=
 =?utf-8?B?UG96MFpUMTd3T0lOZVNkdkxha1BxZDdDcGZ0NzhQbHJFMUg3LzRwSE4rRUdL?=
 =?utf-8?B?bzE5WlRBWlFaODlNanV2Y0V6dW9QemwwRXdpYzdUOVBlaFF3NEF6L25icVJz?=
 =?utf-8?B?YzdmNm81aERINEEyTmtBV0kyZnpYakMwUnBWdDI1TnNhd0pKTWJ2WEtXei8w?=
 =?utf-8?B?VkRVdHg2SWw3UEhaaU5QaytjeCtqR0t4dFpURHlQRklVR1pGTDhEMzZyejVC?=
 =?utf-8?B?VmRSMjlTNVdaRlQ2WTJlanI0czQ2b0xuaUpxZGI1U3orbWZuN2dGL3JaM3I0?=
 =?utf-8?B?TzI1WDNQWkVKYlJQWFp0bm5saXNCOTlNeGhoNmdmeVJacmsyUWpuYTYvYVJl?=
 =?utf-8?B?VGFSYjJ1WFIycWFVemtYK2lXaU1RYnIrellLbGdqQUdBZStqNzdoQ1pqbURm?=
 =?utf-8?B?MTlzajRzUWttRlB6UVoyWUVabDNpaDcwM3VOQ2pxdkZ6Y2lJSVJ5d1JTeHpp?=
 =?utf-8?B?MEVES0pIUlFITHhnUVhoV29wdWc3d2NUcWtPRkMyTlBwZjBGRy9OQVIzdHVn?=
 =?utf-8?B?cE5rVkxaRVJSMmFVdzRlM284QWxSblgxQkJSeGdhdXlxMnVtTzRjNDZnd1Zt?=
 =?utf-8?B?WCtWWUdDREpKM2JoRElLNjZocWF5WFNPVmNyMmEyYWRIV2YyZHlyK0dxV1pu?=
 =?utf-8?B?UDVMUVgvM1pOSkovemlEaURJT2lUN1pIMFppN1BHUkhoT3hwY3A5dDFRTXBN?=
 =?utf-8?B?a2FSaGRodno2SitrY3FBcnR4ZVRPMlNNVTZaTzlnb09VQy9qSENlWCthZ1VN?=
 =?utf-8?B?SWtPWGE3YThqYUxjZVRQUFpQaGw5NXBseTRHb2lQVWYyTmtMS3BqaHREbnMy?=
 =?utf-8?B?V2hKbkEyajhXWXk1QnBVeTM2VzVrcjBqVnNkM3dIK1pFbWhETUZYMUw4S1BE?=
 =?utf-8?B?NkhBd0FPQWJPWlZZbStZSW9ydjFkcXRSOFd2QUZJOS9JMXZUSmZoU2FjaWtq?=
 =?utf-8?B?V3lsaWdGS2RvU1VYOHk1OGFDbFJEcU9zcDRQZ0JxOFFZNlhJcXRvVno3SDhr?=
 =?utf-8?B?RE9UcUV6RTAydVkzSVNsLzJSWFpvZDdrTlh6N2VMcXhtRnlIVzhPRGFjdG1Z?=
 =?utf-8?B?YzR0NjgyWXdEMXNpQVBGN1p2bjkwaDZXT1MydUxTOFp6a3MySGprVm43V2l6?=
 =?utf-8?B?VHVvUUZOMWVadXlueENrQlRaQm9qa0s2S0hmTDdUZTdRUXlTaEJtN1B0ejU4?=
 =?utf-8?B?REpqMFNlTzhUZFFXTHdrWEVUNU5JRFRVeHM1alRHN2ZmdVBpL1dpRWhSSjRl?=
 =?utf-8?B?UnFqTHM0VDhsY3VCcFZ3Zm5xckQ5SHRpY2lYK3d4dGNIUWltT2FBWnZOTGw1?=
 =?utf-8?B?dFVOUGRzWWtFem5JTCtmaG9McTJ1M2xCSERnNjZ3cXFHU1JRbzhqYUhKN2pG?=
 =?utf-8?B?aHB1em9NYnFCRlgzT0NTYitxRzY3M3lOS2RSemY1RysrT3BwMndoS3JWckh5?=
 =?utf-8?Q?kzWvCxgS54qn9QaaQHbKH7bZJoBr6FYw/cv3LtkxRW/E?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5QanT7sdl4RWSQp6VJ8q9MMohysqyj1we/IKQRkpJtJEhJVMQjtqx7W8QpM7mBalbpaZlp7msL8Lyiu/d8Nf9NoXE4nQMz72Z/Dc3awxCka5m1RrjnLb88eT+SBJnlEteENu3LKYhRvgohVA3Ng0n0Wm4SrEyTOOtDDVIvOcnhKBFw455Q+M+lCXnWixDlf+05X3+/vz40aPM3rRS5BHk4OS3DDanS8fTtlCi6Lyv0fBa7T/D8nrOfuRyvUwdZue+ExyYqssAR9kmIZF+oshNzqqfFQpGiqN0dmSyVWXQdtozB5oc7NAM2/1qIlnDP76o0brVR+IXqpnijYdzKJH8/L3LpHVNoIM8c/25lift1vuBSDZO6F++ay8CWPXy/GsICeCgD84J4p5GHuqu1c8g8RyUIXiaVGXhFpzVj5TeDb6pRXm6QQGDaQg+14HONvmuDM2nDERcW16Y5162grFHocjG8NVkAyo5na3D1pUcXpu1Jkfk4LtSa2Mf3/dV6CN9wT0OkYliKikd6WB/wKmvYifHM6PyC6GUnAOsk776XoKLJfR+HDV2I7VevoGbBSvKIMcxbiBbJeGWdITQtXrWQts1/idibPgmFXFY8gVu20=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc035dc9-eac3-45ba-30c5-08dddad8a271
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6078.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 02:16:53.4656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IESYCoAJfuROEQw0sCbkajQgUVwHUOv9M07DySY4WGl8UjVC9bFl6VGdtUTQBcztt5N1cNmgERh61oanC1d58g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7458
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508140016
X-Proofpoint-GUID: Qeh6jgSbaXQOrEwDpuGhGeTAHi6dRCUY
X-Proofpoint-ORIG-GUID: Qeh6jgSbaXQOrEwDpuGhGeTAHi6dRCUY
X-Authority-Analysis: v=2.4 cv=ePQTjGp1 c=1 sm=1 tr=0 ts=689d4718 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=g85ECLxEWdUrMRjy44AA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12070
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE0MDAxNyBTYWx0ZWRfX6a1ceL4wwwhA
 +pZUWDqj2pMwOH+XVw4c/27qONv+9H9Z26jwE6AuHyKaIi8uqQ5gDy46LoeWEUz/XnXuvR49zZ8
 B3IHRzek+M+xCTvBAuX2vOASOQLLAAWDcxcAPWQLhCSrgprWYpxiIu+tFjHguJDm72zijaKzfgs
 01hAg+CEhTiHTrdBp6pWngKnXFRJwzrZ94dfmFeHavWTrLPDH46SLht9ZKD185aM/pybmKf86vA
 1H0as0X8OGrSR1NxtZMAMyrayNbOqbNP8D03yo0RvkGQYUWFqOdzA9RlaguJthAx4FyTOGtD19e
 L9tMLUEJZTdloBvBCCI4ROeGlfOTbzhf/tj7da2PDbNLdS3Cd1RzODfzsqqZQoCtJbUB4aIWKUo
 2xX+YFIfTacLFXyEta6/afNzONMkN8RLPU733YxlzbJ3tG8hYxypSBzaQqjKNl3ZW/I9YT/2

On 16/7/25 13:27, Johannes Thumshirn wrote:
> On 12.07.25 15:53, Anand Jain wrote:
>>> +$BLKZONE_PROG report $SCRATCH_DEV | grep -q -e "nw" && \
>>> +	_notrun "test is unreliable on devices with conventional zones"
>>> +
>>>     sdev="$(_short_dev $SCRATCH_DEV)"
>>>     zone_size=$(($(cat /sys/block/${sdev}/queue/chunk_sectors) << 9))
>>>     fssize=$((zone_size * 16))
>>
>> Johannes,
>>
>> The test case still fails on a zone device with no conventional zones.
>> However, if we use tail -1, it works fine—with or without a
>> conventional zone.
>>
> 
> But if the data is placed in a conventional zone and we recalim it, the
> write pointer will not be reset (as there is none) and you'll still see:
> 
> -Silence is golden
> +Old wptr still at 0x073338
> 
>> $ modprobe scsi_debug zbc=host-managed zone_size_mb=256 zone_cap_mb=256
>> zone_nr_conv=0 dev_size_mb=4096 num_tgts=2
>>
>> $ ./check btrfs/237
>> ::
>> btrfs/237 5s ... [failed, exit status 1]- output mismatch (see
>> /Volumes/work/ws/fstests/results//btrfs/237.out.bad)
>>        --- tests/btrfs/237.out	2025-07-01 17:41:30.943699725 +0800
>>        +++ /Volumes/work/ws/fstests/results//btrfs/237.out.bad	2025-07-12
>> 21:39:03.756275219 +0800
>>        @@ -1,2 +1,3 @@
>>         QA output created by 237
>>        -Silence is golden
>>        +Old wptr still at 0x073338
>>        +(see /Volumes/work/ws/fstests/results//btrfs/237.full for details)
>>
>>
>> Following diff fixes the issue.
>>
>> -----
>> index 2839f6e42797..7f460c1415bc 100755
>> --- a/tests/btrfs/237
>> +++ b/tests/btrfs/237
>> @@ -28,7 +28,8 @@ get_data_bg()
>>     {
>>            $BTRFS_UTIL_PROG inspect-internal dump-tree -t CHUNK
>> $SCRATCH_DEV |\
>>                    grep -A 1 "CHUNK_ITEM" | grep -B 1 "type DATA" |\
>> -               grep -Eo "CHUNK_ITEM [[:digit:]]+" | cut -d ' ' -f 2
>> +               grep -Eo "CHUNK_ITEM [[:digit:]]+" | cut -d ' ' -f 2 |\
>> +               tail -1
>>     }
>>
>>     get_data_bg_physical()
>> @@ -36,7 +37,8 @@ get_data_bg_physical()
>>            # Assumes SINGLE data profile
>>            $BTRFS_UTIL_PROG inspect-internal dump-tree -t CHUNK
>> $SCRATCH_DEV |\
>>                    grep -A 4 CHUNK_ITEM | grep -A 3 'type DATA\|SINGLE' |\
>> -               grep -Eo 'offset [[:digit:]]+'| cut -d ' ' -f 2
>> +               grep -Eo 'offset [[:digit:]]+'| cut -d ' ' -f 2 |\
>> +               tail -1
>>     }
> 
> Oh OK, then tail vs head it is. Still there shouldn't be more than one,
> IMHO.

Yeah.. for now it should be fine. Are you sending a v2 for this?

Thanks, Anand

