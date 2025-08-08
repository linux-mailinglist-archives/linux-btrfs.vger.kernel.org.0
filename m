Return-Path: <linux-btrfs+bounces-15917-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B61ECB1E1CA
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Aug 2025 07:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FF233AC90B
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Aug 2025 05:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35341F1317;
	Fri,  8 Aug 2025 05:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qmDlR9h4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oBqiypX3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61091EFFB4
	for <linux-btrfs@vger.kernel.org>; Fri,  8 Aug 2025 05:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754631670; cv=fail; b=OqBpI+HWtPoS29/DsNJyQCD5jPKSqtz5KQ29hgdwt2y5pdVNSU5E76SKBVuEJNH4xMhEf7CFQZseoU/bZXxMk6+m8c7hR/XBJyo8VanpwaepzSC3pbTNhZE66GqrnZXfWyDmpm9Cnd0V6Oy4ynut7xcu8j94sKs3pv48rANlxl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754631670; c=relaxed/simple;
	bh=zpaUQa+vx0b54v6fyujZJGi2G2ygwcYD+RPAt8jLl3c=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ty+fVs4rndPc+lUVa7jitR7q4EFw0/howsMfyoO6hyrpPQcA6rsGizV2NNynJldIAggyQ+NdMEYDXLfKQCDtphAIsOoaNUoakM1lonSAKJkYavGFBiTcJ68p1sIOJSUeN3++CGGuUuTlj1kLEIqpPx0etA8RmNdCBBP1SePdk0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qmDlR9h4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oBqiypX3; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5783u92q007133;
	Fri, 8 Aug 2025 05:41:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=LPFD6dJL3PwaM5QwYGpPPV99p/EfgUVEBbf/ziMrnfs=; b=
	qmDlR9h4JFx+0LoEEO3sl+xnn5jP/oI3JIAdH/LWNhfGsmmJLvVIXBqjXTY5QZn0
	71mMMwU5iYms6BVagB8fhedDooc0LlOB0lf3oRBm2a3kP2TEK74OHzkVSeT3Xtau
	WTk8c6Z0KKG6Zp76b8X9VxEGQBE5/1YZa5MtzKJToX6+zsTe7531m5SfQFGrEFBF
	uCFy+YtdJ+XCzDL0Lonuv7tvaysAIMl+epd0xlNg1ceLG0IRhNOQE61OlD4OMJP0
	7dDTxulMMB5FEVC4nSBweToG/1o7pS4Rx6DrtmH57aSe2INEME15Zn0FbivXvv5T
	f2Z94BUPfU5Lk43XGbmCHw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpve5k93-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Aug 2025 05:41:05 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5785e8dt028403;
	Fri, 8 Aug 2025 05:41:04 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02on2075.outbound.protection.outlook.com [40.107.96.75])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48bpwpjruu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Aug 2025 05:41:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KGYeUd8eBQYQz7QKFEaupAh+RO8+mdb+7O5qwhkUrgfjY6etcfaaiomYrOXzwiVnbfChVpnq4ORs57vCoaoQpXJFvenSVOm9Wi5rbCQjoTF/aP/dw0SDdTsbyiANqhe5u/L3EGUYJ+MCdPTH6YYhxRvIof4iX3vOOcy6m2tAhqRTaOhX685nvs8E7vFpEnCdC4DFylrIlhy5UzvcVx1S87vJfvfbb+Ct+tKI74Uut5nVl8DmOPUnMVWcHbqFFXWGJgKX8H0K9LMpt5iv50u/cgtXmRcVE4yaPLw7gLinVJw9FbATJo7N3Mf9OBJmbRLclMnwTm2Il12fxj5gKfVMMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LPFD6dJL3PwaM5QwYGpPPV99p/EfgUVEBbf/ziMrnfs=;
 b=SPMi4xLuEFhopmi53R+zPdWYXBe0rXu6zSYMEFMNEVXz+lYEZ+zBaWVAWfAsZrD5M/OEvMB4Ol2ZSBFRxacPEcpVAfT2hgXXI3UBz0NVkTrZBOKLliTE0+49xuwMX0a9UWVcM+i+svCtfHg8YyaJGAilWmJgbKc/Cth1FQ2WUcEXn0aqu/Mb0wNNyWrJPxiA1p6G6gzK4weaFnF35w4j7+U/YMJh+vlVD8UXJo+Y2rIv/CmiWQcopGzLn6XSjp3jP087sE8s3YXixr4A5GDtWUe6zRWpuiX1BqwC/LuS05b/iwdAp8suATI/d0P92aX0HykZXQWFciQua5Q9gk/8Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LPFD6dJL3PwaM5QwYGpPPV99p/EfgUVEBbf/ziMrnfs=;
 b=oBqiypX3CnGbgZGZFKjuCzYMKKblPkyoIV6tmT7bMba4xmECawxstrJ2+gcxtaM/EJgQlnK6gfKyzuA6j12+fm+7V+y/n3C96mkaGkxyWxZZxwyDID4l+PI7WbSaOaU0fx5vdyDIOlH5txMSpdAFCQdJdNAKgaj1kZZ1Sycm81E=
Received: from DS0PR10MB6078.namprd10.prod.outlook.com (2603:10b6:8:ca::5) by
 MW6PR10MB7640.namprd10.prod.outlook.com (2603:10b6:303:245::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Fri, 8 Aug
 2025 05:41:02 +0000
Received: from DS0PR10MB6078.namprd10.prod.outlook.com
 ([fe80::edc1:7c2:8fe8:a6b]) by DS0PR10MB6078.namprd10.prod.outlook.com
 ([fe80::edc1:7c2:8fe8:a6b%5]) with mapi id 15.20.9009.013; Fri, 8 Aug 2025
 05:41:02 +0000
Message-ID: <0905172b-c9b4-49e8-9a0e-45702f495074@oracle.com>
Date: Fri, 8 Aug 2025 11:10:57 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: simplify support block size check
Content-Language: en-GB
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <c90d9b78c3c1bab713c301f643e32496471bc2bd.1754549826.git.wqu@suse.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <c90d9b78c3c1bab713c301f643e32496471bc2bd.1754549826.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0113.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::14) To DS0PR10MB6078.namprd10.prod.outlook.com
 (2603:10b6:8:ca::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6078:EE_|MW6PR10MB7640:EE_
X-MS-Office365-Filtering-Correlation-Id: dd406e21-8e38-4183-efaf-08ddd63e28cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YXhlQ0tHaDc3THliVWVkajhVRWp3RGY1ZzhpaHUzd2pDVEZxM2NUWE5iaHJT?=
 =?utf-8?B?eGZIV1RrYTRrRGFkNVNDR1ZQMk91TzQ5Wk4wd3VFNjBnOWxNSW82d29iREth?=
 =?utf-8?B?VjBQMHVlWlRoQzlYSHY5WVV0cHVrWk4wcTRVc1d0VnRuS04vMm1jMzFyeVdR?=
 =?utf-8?B?cG9FenBJQ0RRUy9IM0FmNXF5NGxJdFdBdlgyZW9PSFR3MEZKdnhDRDRNTjRJ?=
 =?utf-8?B?MDFTRHUrUjZaeVB6cWgvRmwrdUc0MlpnOXV1N1g4MnQrV1VIR3oxR3E1a3Fw?=
 =?utf-8?B?SFErODRsbktzeDNRcC95a3NrOVRKby9mUDhsUWg0WmpMeE5TSkt1NXlYWGhP?=
 =?utf-8?B?bCtWNFRzVlE3aGc3SjhCKzAzNVNndW5iWlpYM2JFaTJESXZrRTRLOHNrN2w0?=
 =?utf-8?B?Q0VlbEh4d2l1azB4cEkyZGxmdFhjUktIbWVuS2xGUkRBUXJUQlgxbW9nOE9n?=
 =?utf-8?B?NkVqcGFsRzgwWTZWWTBDbjBBUGdKSDFoOTB5S0NjdjArR0lpOUdObStHL2Yw?=
 =?utf-8?B?TEtSdVd1KzlhcmZvOXFsczdRdldmVVpzSU1od09JNmlydUVaL3RWa3R2dm5u?=
 =?utf-8?B?WnlvSXMrSDZNQitKeUE5Ry8wcEkvZ21tMyt1K3ZhR0p0b1VacjE1ajNISkFK?=
 =?utf-8?B?QWZsdVV1OERpZWNIR1U0NWNkMlVCT0xjWk1wRndBYldZbGpwYURISVBya2hE?=
 =?utf-8?B?WlFCU1l6RGlRRlN2cHY0UlVMSFkrRGlwQmpJdStHeVZQQ1lUMVVxaXRjQy9J?=
 =?utf-8?B?NFAvYk1IUmRHRnRkMGYvakNsM1VqRnVCODdYaXRITlFHM0diZHZZdGEyRStx?=
 =?utf-8?B?TVhhRzZHSUdYNGlWSFZaYUF0SDlOcXR5cG5JeHRHV3lOUm1pbUl3V1FBd2xD?=
 =?utf-8?B?V1huakFva1V4a3lwSDZHRGgwNWZSWmdYYzhkbURRRnNRTkczb1h3ZU4xNVBy?=
 =?utf-8?B?d09CK0lwcmxXUC9Cai9Wc3JwOTJ0TFBHSnZZNnBnOEk5amJaWnNoblAxa0lI?=
 =?utf-8?B?bkpXMk5CZnRHaS82UEJQM0M1SDR3cUxSQUxiVDVQdnd2LzRZL0JBOGF0QnFx?=
 =?utf-8?B?bFpQWXowNmh5NENDc0VsVFVPREF4OFNoOGFXZ0YydEU3Y0ZFZWY3SEtnQ051?=
 =?utf-8?B?dE1KOHFUTFFZUEIrMjFmd1hFNlVDdXVaTFY5Wnl1NkpCY0RGTFYxeDBvVy9P?=
 =?utf-8?B?d0NZR0l4YkFGeVVFamdFRDRndjM1ZS9lcUtCbjZYRm5oTW5nL1hYbE40cHdz?=
 =?utf-8?B?Z1BBUE1zVnBQY0gvOER2dXNMall3ZzdsdDFtRlRsYzZZTWxQbk90NFphTkU1?=
 =?utf-8?B?S0NFa25LNVgwNE5PcGVBenp2Wk96U0FiZytrcDgrRmUybGFla3k4RlFNVE1F?=
 =?utf-8?B?RHRJU2Q0Uk5DVSt6KzlyZU5yR3hqa3Q3OWx5YjF1TUFvdU1WdGx4QjNHWDds?=
 =?utf-8?B?MTZhcmRtdE13dnh5TktucW95dVlBNzAyUlN0MnVrL25XRDVxcXpxSTdpMW5R?=
 =?utf-8?B?SFR2dlNrL0ZqMVZ3MlJJTmZlU2FiWHdZYmF0TXJ2c1hPcVZLOE9Cb0ZQRnlY?=
 =?utf-8?B?MWxVbVVNRmd3SnVneVEzT1BEQnptRzFtOHkyeHFvRi9oTW1acFIwNEs4dWdx?=
 =?utf-8?B?c0NVVTdvYkdUdHd3cExVR0t3K0V1WVc1WHNKWHB5Z24xN1ZWYUVyY2hKNnhh?=
 =?utf-8?B?QWdXWE9ITnNySThLWWIza2NLYTRSRXE0MXV3K1ZBNkltYVNJaThmbTdyMHcw?=
 =?utf-8?B?bEdrbE54cGp3ZWJrc1VpTnFrV3p4ZitKTHo0RVBwZnBnUW9qOERuZ2FhdSti?=
 =?utf-8?B?aThHaDNsUzFWOXc2QXV1K3NhYklsSjgrdlN3Z1JMMHM4V1J5L3JYUzBzbVRz?=
 =?utf-8?B?TnIwOW01cXdNRm5lemEzMjlqSGRtZ2JKTkNPZVQwZEl6RTlBK3dpejcxaXBS?=
 =?utf-8?Q?mpApKdjiTQQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6078.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NW1vWWtoR0FvMWs0dEoybDFPeUVJSFRISWlLaEZQTXJaeHZaUmFJcVhaYUpL?=
 =?utf-8?B?MU9rZU5NRU1WT21qU3NrTlR4aDhNd0Jma04veFNLNmQwaEFtZTRUV0xzbWRH?=
 =?utf-8?B?UHRJcmpTSFJLK05KV1dic0NxanNYT2RQUXlwWHFLaDMxWmt1blRseVQzUlJl?=
 =?utf-8?B?N0JCL01ic3VVMXV3Y09VTXFqckwxYUFCaE1meTBQQ1RxNE0zUDBKRURic0VV?=
 =?utf-8?B?MUZkUDREanBNVUdCYXY0RU1CZ256Y2ErbUhldDNON2R3eU1EdGJBYzBnQXEx?=
 =?utf-8?B?U2V1NkxaNXJKRURaSkdYeVg2OTBpZXhLTllWcWVCamt3TXQwMGVPUEJRcXkr?=
 =?utf-8?B?b1FzYVUzcVJYUGNHVkFDenRvMVFvVy8yYmM2OGptUVB0c3J0UlpBZG5iay9Q?=
 =?utf-8?B?UVVLUk5OS0VabkZ5dFNaN1dWOEJkQmJzUm16K1JCeGZYOS9SVi9SdTBidEpP?=
 =?utf-8?B?SitMbGc1alMxNW1HWUduVnZDcmNxOFdxVGhVVkQyNzRscWV0S2x3NnVCd1BD?=
 =?utf-8?B?WTA1RjdmSUV6N0UzZHVaM3hZYThOWS82TmtPaUs1Si9SeDhwR2laUU1lOHZX?=
 =?utf-8?B?Z2NoY0o1VVJrcVU2ZzdlNEJ4N2tpTm5MMkhaOWZ1R01IZGJrVE9nclUvbkRq?=
 =?utf-8?B?V0YzcEZIbmNhZU5YZzcyOEJMemM4WVZONkM3bERGUnJBTHNJNUp5KzVxOGJR?=
 =?utf-8?B?dkRBMXpGUTd3OE9KR3A1SU5HSGVVWFZjRDV5aVY5eVRwWmVLMWFlcW9qVlJp?=
 =?utf-8?B?M0pxYi9qSkJIVGZlZmlVZjdqVG1UVDIvSzRQVjNMVzFsQmlhVmNMdGg3NGIz?=
 =?utf-8?B?YlQ1T1pFOUxWeGtXdUI0bzByL2NEc2VLWWFpejZoeWJKWGhFVHFpbHVxeXND?=
 =?utf-8?B?TTArQzFhTDRTMUN3eDgzNkc4M3N3cVFnMW1uWThZd2tZUkMyby9Hd2hheXNQ?=
 =?utf-8?B?SjI3YlBWSTFMdWttc0ZJRk5aOVljOFhxQVZVUW9FWkNTc2QybFBZcTFkUm5J?=
 =?utf-8?B?U3lEcjgyVXpkMFlPL0hUbUVGTkNiKzduZnZCV3JtUm5Wdy9iSWtKM1lucGho?=
 =?utf-8?B?Ky94VHJXZ1FSR1VWV2pBUkZnUldwbUNhSHIwcEJwT0V4ckRwSERYK0lQMm1U?=
 =?utf-8?B?Q3JtZCtHWGN3ZnNIMm9JK3VoR0JTMGhQMzYwZXdVVU9BcG84a21QdlNpNWM4?=
 =?utf-8?B?dTY3UkNFelBMNVhqTzhyYWZ2b3JNaC9PNkwyR3VWUW96VVZvZTN4ZDZSOWZF?=
 =?utf-8?B?RXQ4dGUwaUpVTHNWK1VoTFpic2pSZ0pocnkwNUdmKzRRT3dzZ21QQkVSZ0FX?=
 =?utf-8?B?Mjc2Q01nbGhuSmZ0b1F3WWRwTzFjdk9GeWdZaTNsdVVNMDMwVkxjSVI0d2hl?=
 =?utf-8?B?TjZ6amFZc0lBMWo2bVVhWkpNaEFZV0dydmtVT3FRanNESFQ1TmdxVG9hOHl5?=
 =?utf-8?B?L3p0eU1BdFpIOVZrRVovUWxUa3JacU9XTEFic242UmNwOHUrVWNIeEk5cmJ3?=
 =?utf-8?B?amlIdjd5SXVsK0F1VGhiRUo5N21QMTBBeHZucDhseTQyM3lLSFNiTFJCY2kr?=
 =?utf-8?B?R2NVZTJrWHpEbzdualhBVVQ3Yi9QQm95cDdNa0c3REFaclBoaUo5ZjVoM05B?=
 =?utf-8?B?YlE0L2Q3QmFQdzNNOGpueXIrSWYzaWdhMFM4RkQ3Q0kyM2F0OTN1YXpSUjZN?=
 =?utf-8?B?N0dxQk1iMUZSM1dvWGJjL0pEOVRlN2g5MkFUMGxnOGJzcitIZ1h1SGVxeU1O?=
 =?utf-8?B?ZXdab0R5RG1SZWtBUlZiNzNXaStqS2NGL0NIZVYxbFpmNTFCY0V1RVJlZ0Zu?=
 =?utf-8?B?WDZRa0pUcGhLc01jMUJVWkFjbi9oUDFzSVFoYlRHaXpRMy8wcjNYREhTbFV4?=
 =?utf-8?B?YTRLZ1pzUkpTMzhRQnA4eExaSFpQbDI0UzBpc0tjck1JK0xtbDd5azdEYlBZ?=
 =?utf-8?B?T2gvNi9rc0hpVmFBSld2bldXVnZxQTBpZ01wb1hsNWpSaTV0MEw4ekNaTzlj?=
 =?utf-8?B?eVEyYXhsWTBQL3NYWUZjakE1N2djZkNYQXNHaDBZZDEzbVo3ZkUxbU5acHp4?=
 =?utf-8?B?OHdpbFk3WGxVRDRPc2VmWWxrR25LVDMreVJvZFdseGEzQXZDUVFlR01rODNT?=
 =?utf-8?B?dFBtWGY2ZW05Q2dGMGc1ZmJLcFFlenV2SGl2V0lYNTgrbjFyUXpHdGE2bDZo?=
 =?utf-8?Q?7uiYtE8YCLUI28geMvVoECpuj1aheMBJZtxmUiSp3WMh?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wTzmbmeDConjQBFTRAZGe2kBN5A65asJb3j2WhbRC7CDX4gHOGj5PcmPKyU+g4QvMCof6xFRIpMPtS1UncfzBFKWZUXnnLcAPOlnDulXZIRzekO66IQp8CLwsthyXtV3vJgMytwOPj+WgDN7gEYWrrbMU9jd8XNPp96ZV40S/h81SWD+MrcVE1tAirQoKgQkTS31mgLJ8AVxj0Ay+rF2XyoYzb8lvSIa8eQBqGtS3QhDG5KZm9qpt6o+BtE4d9nwhDoye9CGvWtvy844z3J6JMwv5+TkBoR1rfIg97zQkLaZqL7Wp+usk1l2Lz4LCj2ptC1Ppn/S9kIjrJjB2ZJlQf3gKBH+BlYyubGG1u7caNLKUn0EBxzl+35SodJEFnbYj2mOVjAeXdeNceDrcyRzcoNBlNE3B8hoWR694LDu4enr06HkFWb01Q/OL7ADoBPjquTvs3TbzSZxqxseSrItoQn1JM//9TI+hSDt2xk8blB4qlr1LfZXL3zja1JOsAomxmFsquMcuoL63bEwy9ZidJsJB/QLbdc/RSUIonU4t9/20acvH8PjscNORD2452b7TYbxXpMlDIlS0zZl4/9xxWsyqaG90nrADA6OMo9DZN0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd406e21-8e38-4183-efaf-08ddd63e28cc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6078.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 05:41:02.0918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fpNvAsn5bGA4dbBVlrTq0s88/gxGoph9jXwKt9FEX5Fwtcqy9fxmCazE3mDf97NtnAChCSU7Hb4ZzI+RnFjz7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7640
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508080045
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDA0NSBTYWx0ZWRfX04EpTQNkqcwn
 M1vspkA/fH1pqqrqT9kX/20dNs7ejLGcmScj/PwUbeCwRHlZKi82+HoYC+WzOLvspn2kc1T/ZtK
 ptUCjLkldaBvrHCaqKZLjYsFdxXUlLjEyn5jVov53rewO8IAu4bjJaUbWRNmu+5yuIFaZcN3OZR
 tgY0wy37N31STy6z/GNG3k0dOWYkt9hJNqV6Ed4ZqeqIYMZTllT8J0yQBp/Bd1sQEC3g702/jdI
 o8Gs3AXvrnn4NbJuHQXe0SsXMU8Y7T5+DYMP6Wv1jNpwC6qIVUfnDu6SwBGtLh88ZRcBMg97M9w
 mRWnr3QmjY1X5dsmuC66WUA9Wdl7F+HRySv42UTg9DPlWjJesV3np+7/s4NIVhLj2rxGSl6Cd0r
 Jmy6kKpOvwE5DMqy9o/4uk8TteE97stoQQXUEw+U0h1qjMIVvjVHhSob08BdZpw/fBYkZl3e
X-Authority-Analysis: v=2.4 cv=ApPu3P9P c=1 sm=1 tr=0 ts=68958df1 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=iox4zFpeAAAA:8 a=yPCof4ZbAAAA:8
 a=d8AD10hqjYnxoRiOpTEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-ORIG-GUID: Ox4JKBmAFpO8C0YnKToXtU3MFOSN-6Sq
X-Proofpoint-GUID: Ox4JKBmAFpO8C0YnKToXtU3MFOSN-6Sq

On 7/8/25 15:01, Qu Wenruo wrote:
> Currently we manually check the block size against 3 different values:
> - 4K
> - PAGE_SIZE
> - MIN_BLOCKSIZE
> 
> Those 3 values can match or differ from each other.
> 
> This makes it pretty complex to output the supported block sizes.
> 
> Considering we're going to add block size > page size support soon, this
> can make the support block size sysfs attribute much harder to
> implement.
> 
> To make it easier, extract a helper, btrfs_blocksize_support() to do a
> simple check for the block size.
> 
> Then utilize it in the two locations:
> 
> - btrfs_validate_super()
>    This is very straightforward
> 
> - supported_sectorsizes_show()
>    Iterate through all valid block sizes, and only output supported ones.
> 
>    This is to make future full range block sizes support much easier.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/disk-io.c | 17 +----------------
>   fs/btrfs/fs.h      | 29 +++++++++++++++++++++++++++++
>   fs/btrfs/sysfs.c   | 18 ++++++++++++------
>   3 files changed, 42 insertions(+), 22 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 9cc14ab35297..427480a8bcf8 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -2442,27 +2442,12 @@ int btrfs_validate_super(const struct btrfs_fs_info *fs_info,
>   		ret = -EINVAL;
>   	}
>   
> -	/*
> -	 * We only support at most 3 sectorsizes: 4K, PAGE_SIZE, MIN_BLOCKSIZE.
> -	 *
> -	 * For 4K page sized systems with non-debug builds, all 3 matches (4K).
> -	 * For 4K page sized systems with debug builds, there are two block sizes
> -	 * supported. (4K and 2K)
> -	 *
> -	 * We can support 16K sectorsize with 64K page size without problem,
> -	 * but such sectorsize/pagesize combination doesn't make much sense.
> -	 * 4K will be our future standard, PAGE_SIZE is supported from the very
> -	 * beginning.
> -	 */
> -	if (sectorsize > PAGE_SIZE || (sectorsize != SZ_4K &&
> -				       sectorsize != PAGE_SIZE &&
> -				       sectorsize != BTRFS_MIN_BLOCKSIZE)) {
> +	if (!btrfs_blocksize_supported(sectorsize)) {
>   		btrfs_err(fs_info,
>   			"sectorsize %llu not yet supported for page size %lu",
>   			sectorsize, PAGE_SIZE);
>   		ret = -EINVAL;
>   	}
> -
>   	if (!is_power_of_2(nodesize) || nodesize < sectorsize ||
>   	    nodesize > BTRFS_MAX_METADATA_BLOCKSIZE) {
>   		btrfs_err(fs_info, "invalid nodesize %llu", nodesize);
> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> index 8cc07cc70b12..4548371ca10c 100644
> --- a/fs/btrfs/fs.h
> +++ b/fs/btrfs/fs.h
> @@ -29,6 +29,7 @@
>   #include "extent-io-tree.h"
>   #include "async-thread.h"
>   #include "block-rsv.h"
> +#include "messages.h"
>   
>   struct inode;
>   struct super_block;
> @@ -59,6 +60,8 @@ struct btrfs_space_info;
>   #define BTRFS_MIN_BLOCKSIZE	(SZ_4K)
>   #endif
>   
> +#define BTRFS_MAX_BLOCKSIZE	(SZ_64K)
> +
>   #define BTRFS_MAX_EXTENT_SIZE SZ_128M
>   
>   #define BTRFS_OLDEST_GENERATION	0ULL
> @@ -900,6 +903,32 @@ struct btrfs_fs_info {
>   #define inode_to_fs_info(_inode) (BTRFS_I(_Generic((_inode),			\
>   					   struct inode *: (_inode)))->root->fs_info)
>   
> +/*
> + * We support the following block size for all systems:
> + * - 4K
> + *   This is the most common block size. For PAGE SIZE > 4K cases, btrfs
> + *   goes subpage routine to support it.
> + *
> + * - PAGE_SIZE
> + *   The easily block size to support.
> + *
> + * And extra support for the following block sizes based on the kernel config:
> + *
> + * - MIN_BLOCKSIZE
> + *   This is either 4K (regular builds) or 2K (debug builds)
> + *   This allows testing subpage routines on x86_64.
> + */
> +static inline bool btrfs_blocksize_supported(u32 blocksize)
> +{
> +	/* @blocksize should be validated first. */
> +	ASSERT(is_power_of_2(blocksize) && blocksize >= BTRFS_MIN_BLOCKSIZE &&
> +	       blocksize <= BTRFS_MAX_BLOCKSIZE);
> +


> +	if (blocksize == PAGE_SIZE || blocksize == SZ_4K || blocksize == BTRFS_MIN_BLOCKSIZE)
> +		return true;

  So just remove this line for multi-page blocksize support?
  Looks good to me, either as-is or with David’s suggested changes.

  Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks.


> +	return false;
> +}
> +
>   static inline gfp_t btrfs_alloc_write_mask(struct address_space *mapping)
>   {
>   	return mapping_gfp_constraint(mapping, ~__GFP_FS);
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index 9d398f7a36ad..a3c3281a4949 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -409,13 +409,19 @@ static ssize_t supported_sectorsizes_show(struct kobject *kobj,
>   					  char *buf)
>   {
>   	ssize_t ret = 0;
> +	bool has_output = false;
>   
> -	if (BTRFS_MIN_BLOCKSIZE != SZ_4K && BTRFS_MIN_BLOCKSIZE != PAGE_SIZE)
> -		ret += sysfs_emit_at(buf, ret, "%u ", BTRFS_MIN_BLOCKSIZE);
> -	if (PAGE_SIZE > SZ_4K)
> -		ret += sysfs_emit_at(buf, ret, "%u ", SZ_4K);
> -	ret += sysfs_emit_at(buf, ret, "%lu\n", PAGE_SIZE);
> -
> +	for (u32 cur = BTRFS_MIN_BLOCKSIZE; cur <= BTRFS_MAX_BLOCKSIZE;
> +	     cur <<= 1) {
> +		if (!btrfs_blocksize_supported(cur))
> +			continue;
> +		if (has_output)
> +			ret += sysfs_emit_at(buf, ret, " %u", cur);
> +		else
> +			ret += sysfs_emit_at(buf, ret, "%u", cur);
> +		has_output = true;
> +	}
> +	ret += sysfs_emit_at(buf, ret, "\n");
>   	return ret;
>   }
>   BTRFS_ATTR(static_feature, supported_sectorsizes,


