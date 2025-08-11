Return-Path: <linux-btrfs+bounces-15975-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84BD1B1FE61
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Aug 2025 06:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3388B3B94E5
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Aug 2025 04:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91656221FAC;
	Mon, 11 Aug 2025 04:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="quURxpET";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IrS2SXop"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386BA2E36EC
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Aug 2025 04:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754887132; cv=fail; b=LgVJDgaboCbpVpUo3Mg0+KlbbfBWDt7PdbNbeQ9UGylKiLLj1j8JFthcfhFb5x81HpSPJYwXrMw7uLFQX6+ie2Tx4qagCqYfhKiqC0/k32Qi+5GbmMM2W4ogDN3yOw8v/AM+g27dFAoMvV8bSjAC1ZMcGaW/QnSm6mYsWnQwop8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754887132; c=relaxed/simple;
	bh=jrfderINkW4Fj6jdP/I1oGBW+1JfBK4OsV/TflcW0wY=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L9A8DAAS0X+tS4LnrtPohzjf6JI4lYkJqRxAbMmDXufwCj8D+0zJNHeMQxNVSRQ4UZKnmXIEpLFeG0BjYVcV0UEdAe8lgmJlGp0vOtj4KfVTw+zO3EzW9Y6XOlrwcfn9n7kso/CRqchaeFNduO06kQgBIQUiO2MR90MF2rI9e/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=quURxpET; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IrS2SXop; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B3Na9C002072;
	Mon, 11 Aug 2025 04:38:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=jrfderINkW4Fj6jdP/I1oGBW+1JfBK4OsV/TflcW0wY=; b=
	quURxpETR3g67XhO78noCVhGQ0Ws6DEtLOnwA2VmSdmkGxxiVrxQXavVfvCY/+MB
	qLt5Zp1Hjw7OLlExfCBl/M4QPIaQHPa7BRwLZfIaO1OSfUt4k8/3iT8SMCz7BK8a
	ngom4WpqY/k25ELMgAi2t2RM2+d1b2wHbPB2IDh6XV4Z/OkYg7bhmdH+PPkvHu8f
	ojW3/d6MzNHk/++zafg7or2qk13IwHeoWydVeeY21uiGobiKpRGutsbTQL+Sjl07
	QjrRL0+fFymDKrbOx7AGRx0evWje/6tbmkXxXImnCSwWP/c2CzKxbBUFM/3cD+GU
	lbGjD4/NpCHLwmUos7uAlQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dwxv1nen-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 04:38:41 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57B3I8Nl009833;
	Mon, 11 Aug 2025 04:38:41 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsee82j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 04:38:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wo91HZUpoKy7HepL0fPs/Sm9abzsIlMOKKXIRBk3YE3tBvt99tubTpABioS+gHs0RjFZF+0CbXRZ9SUuony/nSd3hU4ZMWzFvtjyRgTqwIATW3/GQXN+XwlTezRO4y/Zb7Ufg1/KhLolRDm1uJSXnNATQiWHeKctZxS9FSGInr61VsZ5Oc/BBjYGJxHOTN3eFnYfRL+0/m+7QYb2qSIeQffSXar+0eGytH++k3rGvJcENRKhOerR5gxLji7o1QxdlvQo6XZeg0kqsq0tzb7xm2krxdridG6gJTY19bwymvfTp/fChjM5dWEU61d6SvHMMr3VkpXeeJIdOBETxZA/kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jrfderINkW4Fj6jdP/I1oGBW+1JfBK4OsV/TflcW0wY=;
 b=O4l+UI5f+7HDOtLJrp2MYL14TMMs/pVO+rPt6yc94DRMr7PwpQFwtwARUKcDhCrbMi4ig2uUmUZczeLiYCrEWzrMalhigCfnBMsWhI9mMTRlezYQzQGT/FVRIiKgdVC/jZVXR1Z0QjSVSuVa8OgfDS8qkOpfszEKYmJ18xFKdlk+0HO+EEN3szZjwUhxoKNaeRbQsSeV81u8TpwQWtyDRrZulv+ApUSat03Xfa/1IYtfeQW0bXSo1GajVU8SQ7T2+ukT+v0rvH5RuyyFouGh0EzxVK6+TY3sdlxS60ClBEj74/30VTRiEeMteTRWooBxqbKsaq20BkZ226uVh8nakg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jrfderINkW4Fj6jdP/I1oGBW+1JfBK4OsV/TflcW0wY=;
 b=IrS2SXopR53AD95nD33+0C2Vkh9P7joNrkL0TSbkVIcmNh/4cLVa9dbh5M8oI7Q8J2tqIm4hq/QkfDl7qC+YRzEbPDe/ZvbwQ3rohNqnUsJuXLt8/eR4Fp4LCF6lmm00zfTEP3QSiTjb2TC2tVaziH4+fdcm6GnUJujwy3kVrCo=
Received: from DS0PR10MB6078.namprd10.prod.outlook.com (2603:10b6:8:ca::5) by
 SA1PR10MB5885.namprd10.prod.outlook.com (2603:10b6:806:234::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.16; Mon, 11 Aug
 2025 04:38:17 +0000
Received: from DS0PR10MB6078.namprd10.prod.outlook.com
 ([fe80::edc1:7c2:8fe8:a6b]) by DS0PR10MB6078.namprd10.prod.outlook.com
 ([fe80::edc1:7c2:8fe8:a6b%5]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 04:38:17 +0000
Message-ID: <df6ef807-dda9-4683-afce-523a1ec1d0bc@oracle.com>
Date: Mon, 11 Aug 2025 10:08:12 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: use blocksize to check if compression is making
 things larger
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <14db816c702a3567faa0cd5efe2110b6ebfba970.1754871148.git.wqu@suse.com>
Content-Language: en-GB
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <14db816c702a3567faa0cd5efe2110b6ebfba970.1754871148.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0039.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::10) To DS0PR10MB6078.namprd10.prod.outlook.com
 (2603:10b6:8:ca::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6078:EE_|SA1PR10MB5885:EE_
X-MS-Office365-Filtering-Correlation-Id: 60aa2af6-b618-4b8c-c5fc-08ddd890e414
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MDA1TlVTTkZ4U3BpV2cyWnA0WHB2MjZZcms2UVB1akJiZTIzT3NYUDd0T2FN?=
 =?utf-8?B?RDRVTW4zZXdCVGVodUd1cUppbExkODY5UXlGRDJvUVZNZjJWSHlpcW9LQjlE?=
 =?utf-8?B?cWdTUURadmRHdERIZ04vNDM3NkQzSWJYcEZXRitONWU2UHczU3czZTFyeWdT?=
 =?utf-8?B?QTdGZTcwYmJXN0RQWnlsOUNuaXRueHdnYnQ3elpmKzBxdWorQ2hQcHVPNkpQ?=
 =?utf-8?B?dm5TYUlta3NUdWh3Z0dYRXBQekdLMVo0aTdNLy9NWFdsS0pDQ1BLcFNLVThC?=
 =?utf-8?B?TU9Uc25hZGY3N1J1UEdoc0lZeFFPUkg4RENaUlliTUFkbmxiaERUZTlhRHFL?=
 =?utf-8?B?VnVMbzVQWVhHOGRZSlJyY09XaHYvaklNWHM1bWRndFE4QklUTm1ESEFyV1dZ?=
 =?utf-8?B?bVpQUUIwZFVQZU5saEJsdVV2Q1IxWHdkNm9KMnBtU1h4MFRISHk1NTVKNm1p?=
 =?utf-8?B?eHNjeVArWmlQMGQ2Rkk0ZjJwSjd0YkY5Vk1ncEZYdGltd0E4VGdIQkhsSzFK?=
 =?utf-8?B?SGdMY2xaanJuZlhjMGx5VTlqKzFRMjloL3JFY21aSWExcmVobTVDRnZEUzRZ?=
 =?utf-8?B?UzcrbjNWbjdKWUJaeGFhS01KWjY4bXA0OG9ONi9xTTRPR0hhbWRlcGV1bE1Q?=
 =?utf-8?B?Y0NVS3l3cHNqdDc3QXNZRWtobkJIS3dxVW83QmNrZTJjOTV2b2RvMmNaSXJ5?=
 =?utf-8?B?Z1NBL2I5dFduVXZFMnp2cldKaG5jTERzOG04MXpmMWZwMWpQWS9RQXJ6YnEy?=
 =?utf-8?B?RkJUZFZ3ajV2ZjJtQmVMUzdNOGhjL2ZaQ0t4RHpoRnJuNjRjd1ZqWklYMGdP?=
 =?utf-8?B?dlN0QTIzNnhBcGRnek1URDNwYlI3MjBvdGhMcHlJMmFZS0ZEMU50a3FaZzJE?=
 =?utf-8?B?MFJSaHBIbStpT293YUJ0VHFrN1BlWUpSL1VsQWZlTU82UEp1aFVoWjJOY0ZZ?=
 =?utf-8?B?MXBYV0NVVjJWbHE2MyttdHpNZ0RQRnZGWm1YTGtsaFFTMlJJT1AxRGVzZEdY?=
 =?utf-8?B?aEFURVZKbnRleDJxckxrbTNiNG90RGQxMFMvMkl1QmxjQ1VYL2orazZ3bjJw?=
 =?utf-8?B?bkJpczBuYXQxSmRKQWVlSnAyODc2b0VEM21WYWtKcGVrcVEvVFR1L2s0YW5N?=
 =?utf-8?B?REE4d29zb1dhSXdVbVNpa0NkTDUwTXkwWEFMN083ODZ4RzF0NEJ0V1F0bm9i?=
 =?utf-8?B?RUQ2WlREZHlFc0MyR0k1NTYzc0pKOGV0cmp4VFVpdllrVnlPZTU0Y2FzSFJo?=
 =?utf-8?B?REw5ZEI0bk1TOWdBcWpNUlMvWnY1VTVRdVg4WmNjdDZsY2k5WGtmK3NDRFRG?=
 =?utf-8?B?dVdiSnoxa1Y5VjN2U2dqZXI4NDRNcTdaR1lFSks1ZnVpcDc4L28zeFBBcGZW?=
 =?utf-8?B?L2VDdEJuMytOc1kzblVVKy9TWStNT3Y3dkRxNWtQZHczTnZQaWxJUllRRndC?=
 =?utf-8?B?YUlPOFpwUGttWUd5OFk1QjhSUHY2WlE2UE9qZDErUElSZjU2RDhzbE1xL3Uw?=
 =?utf-8?B?RklSWGEwWGdJTUdicUpIeHFvUHBaUVAxWWFWY3BPMWlPbWxxNGpkeDVhY0th?=
 =?utf-8?B?ZEJPUFpRU3Q1SUM2bjd2UDBid2tXLzMxelMrL3hka05mTlJGem00MlZ3b0xQ?=
 =?utf-8?B?RVZ6VkR4T3FkaXRvMTJyc3VROEhxTG1nU2ZDZitGbFVmbFZETGE2S3pud0NZ?=
 =?utf-8?B?bEFXWDhpSzBIeUF2TWdQcXBzYkhkcFVqc3J2V2UzeGtpQUhPbHR6NFdPdC9U?=
 =?utf-8?B?cTV3THl2S29UeWo1MVpmOERNRjBuV2tKcGkxRktOY0EvQjg0K2g5V2lsZGtN?=
 =?utf-8?B?UTdZb0ZLOEVZU25zcHdING1xZ1g5MlNFc2hVeG9DaXBqOVhZdEd0THlUd1dq?=
 =?utf-8?B?SFM3TzlIb0ZRRS9BbS91dWJ3MXBMcXZjdU5tRGhXK08xM01wSEFSVzBXUmFl?=
 =?utf-8?Q?b9y5Uu/eMZw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6078.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eFQ0cjduVWxISXNJUVZya1hsZFFYTWppWk5TVzZhUnJXZm9HcG9jMGxTWDcy?=
 =?utf-8?B?M1YwT0dBdXVkSWFlbTVVdit2WjR4NGdVai85VWVFNWxaREZPQ2pONTJXNHRs?=
 =?utf-8?B?aTZadGFld0F6eVc2M2JES2RFR0ZUSWxXNStHYzdOUFgraGpuNzFVc3duU1FM?=
 =?utf-8?B?d09jZ0duRmRZL1JZUmlYYVZsQXg4bWplS2tiSmRLSnRCd3kzeDZ5RGZmczJD?=
 =?utf-8?B?dlZKU3YvQ2lyU1FKYlFZdDUraVY5RUc4bFY0bEZJaE5vYUR6WDg4d3Y4UlFq?=
 =?utf-8?B?WVlnUFZDU2xWbG9OYTRDNXkrcTZ3cWpuUGE0eDdjbW8wZU9DSVV6L21JTmd1?=
 =?utf-8?B?WUdFdFExbEg1TVhaVE5aQytnbXgwQWNxamZocVlZNVJBSVRrdk5NUVlsNVJR?=
 =?utf-8?B?T3hyNFM1TXJYTGhTU05LRE5WM2V2eitremgrWFhtNDMzZ0MyRklXWVlNQnFU?=
 =?utf-8?B?VnJUdjhtSUJPNEFVUFBmZjZYZHBvL3ltbjE1ZkZlU1pMV1h1YUlyTThTYnpa?=
 =?utf-8?B?Q2RlYUh4MWhrTE1QYldUdGRTWlZ1K25SamNNdkFhV1JmTysxem5adU52NjBW?=
 =?utf-8?B?WmtmRm9GSXZHNkdadWNicXM5c09NWG1kY3dySzZ4eXpPVGYySGRuVWg4S2dE?=
 =?utf-8?B?c1JFTDRCVitOY3ZBSDZXb2pUa1p3WEtxR2syWDlvdS84Rjd5SUdWTDZycmJN?=
 =?utf-8?B?YWcvNTRpOFFudUJOQmJaVXpXRWxCK2h3ZldGSVIvNG5LamxLemJjZzRjRWU0?=
 =?utf-8?B?TGZSUkI4bk5HYTZnRjhNL1k4YU9QTmFyWVB6Unk5eFdiSURvRnI2Zk1EUTBv?=
 =?utf-8?B?b3VWTUR4RFdRVDBLdC9BWHZFbkNpalo2eGNDSGdhOGF1SEd0alB0YUZkZTNs?=
 =?utf-8?B?emNIZmw2NUhzMkQ0dnpqSzNPUFp5anJ0Y0lBckRMM2tWa1BwMFNtcmg0U3pZ?=
 =?utf-8?B?SDdWL1IwNkNERTdoQUlQNUtXTnB4OEdhV0hzQnpmMGFkbHhFNklDL0xLeGZ5?=
 =?utf-8?B?YUxGVktqRnVmN1RFYVZMcEZaWXVTOUIyQzA1U2ZpYWhBR0pDVzVFcm8xU05I?=
 =?utf-8?B?WFZhU3A4d0dISmVoZHRzc014NjBNTVNEVGExSFFaUHVmY3gwaHZjbkNDbldI?=
 =?utf-8?B?S2lvMmNOWlpYcWVFNlpjTFlUekRmS2EvZVQ5RVlHTWwreG5JZS8wUlk2eHZl?=
 =?utf-8?B?eXdvVGFSTDN1RzdTeUw1MFFSbnJNRHNvN3FBc3RnWkhSbGxyZjE4OHlvZElZ?=
 =?utf-8?B?WWZtb2Z1QnRFaGVHckRBb3JqYzVYby84L2xuelV0cjErNHNZa0pmb0FoNW02?=
 =?utf-8?B?cE41ZE84V2pBUlN4UXlEd3JweEo1QUhnOVdkTEc3TjBtanZISXBZRE96UTht?=
 =?utf-8?B?bm01dG1rVEdMdCtqcnUyTEFmRXdnUGVKL2Zyc2pJY3pxUGFOMHh6OCtMeS9k?=
 =?utf-8?B?T1NtdVVTYXN4Yk9ZeGpoOUFTK2FldG10dk5scnVQVk9lWGxWRW5keEhoVFhO?=
 =?utf-8?B?VjFVSGRXK2RHOHZnZjFZRVl4NWJFZXluMkxhaUY3QlEySnVxVXU2SU51cEtk?=
 =?utf-8?B?Vy9aTGVvbWNIZ21VY2E2QWxJeWRzRTdYZVBPMHZJcmkzNmdXcG9KMnpTMCtL?=
 =?utf-8?B?clE1WWdMTC9GVGdMa3pmZUZ2UHBKZlJVNkUxbjNZcXAvSGcxeUVEenBRUlcy?=
 =?utf-8?B?WFVQd0hwWFR5TFFmTTlVL0hGcCtJSjZRZEFRRE83QURrR2RTWTBVeUR5VURu?=
 =?utf-8?B?OGxVdktiZTBTMzQvUndiMm5WZG9nMzl0NHcvekRrbDU1SjZQbWt6RzhWRTZq?=
 =?utf-8?B?cGp3TFdtcmFicXFqZmM3V1NQbWthc2RHYzQ2ZEZ0a01zTkM4TXcvb2dIRHBI?=
 =?utf-8?B?VkpKMUxNK1NMa3FaY3JFTjBqdDR1M2RzeTZib0RYZVpOOGZJMTJNbEhPQjBi?=
 =?utf-8?B?TUhyOWg3ZXd3c2MvS2dkOHMydm9DWnVZbzZPQXMvRGZiN3JXOVBERTFhSGxt?=
 =?utf-8?B?Q2FYSHo2Z0FNYm9IVDJqZ2pGcHZwTnYzdHJHM0JFRk5JVUxZSlpvd1ZBNnBS?=
 =?utf-8?B?OTlwUFdFTUlaUzZyM2ljSllwT1dCUjFMTTk5MVl2TVlHUEhsNVdwZ1FQTm1L?=
 =?utf-8?B?UWNvVlgxaWx3Uzc1UGcxRVlwRXl1eVhza0F4WmFiSGxveHExN0FtV0ZtUzdL?=
 =?utf-8?Q?7YamTBYjZNWCULemtXJFXFb7aXcFX94Lv1LZ6dfXTpqX?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8JVTESdRo7EMjnztHyIyiTN0f0BBXKV5MYDrdXmz9mxy+69jOcQ5nwJVDjkncSe6ZNpz4OUL58wN8nbmMHcwA8yA4uawxdRJXBWkiglEGjaRR8iWBmbPIlX9G/wPxgyWNR+4IwtKkIo4mO5Xa1I3qkI/no+8XuDjvhkkY5syf8359+Sa204/mlzKkfrJ6B3TS8oZr1PkNmtkBnBnFonZxOgZoQm5w3HWtcyFtn9BrxNJ92s09qLJcLe47heoGFRk4SK5eVrYa8YsZfnZVqLnsX6niy8U5ER7qtWVdMLncgZZE5Acjn3jNNJWnLEOhxNwdfPs46rtL1HYqhGCNXLd3agMgDhQWC8XlfXhn0abiqbHV/QEKnZV7k+Mu787QWvB3o2uK5MeMfDnFoteh1bw75yTx381UNh/DQHQBcoEyU9UuFI+iob+A4qlalim+RRfqr3Hn0Yy6GN5dbR54e+WWSn1OGeT4NxUSdVGcAxLsWo7r/MzHcbB/jlPLtP1C3EaZr4WQ5Gw4xoQI5Dtg+4ziPJ1ohR0h4v2pgZdgjx96NTB3smOhSx6+tvRqmM3AmY+CJ66uH7YrwubJjmzjAjmRmeqsFaGnDS/5hqn7GFdf/E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60aa2af6-b618-4b8c-c5fc-08ddd890e414
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6078.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 04:38:17.5984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xU/xzC5fVbayWRzy7c3ivJDve+CKxsvR31dSFGLcBe7CKRtSfegVCRpMaIUuUl+GMaB024E10421ak16W1MZcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5885
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-10_06,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508110029
X-Proofpoint-GUID: TeQfpTBMfD3dSnx0ta6Ty4Gf1GE_Rixt
X-Proofpoint-ORIG-GUID: TeQfpTBMfD3dSnx0ta6Ty4Gf1GE_Rixt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDAyOSBTYWx0ZWRfX4xujCBoOyyho
 UJQiXxAV+WshJXgnFUedVveDPTJbKD9N7aiZaxbmDWnW/gEqV9+Wgtcr55kxfeqw8I+wflErkEV
 RDqqYuZP3AHEXmCVAgm+LMpd74Ajzz7yC977RQo3ciah8MUafddhjp5D660WC61r2et/M8/4d4F
 UQZPle6zSvL9k6VXPdCon4vmYCbGLMHEFTV9CH95DnE1yAezZc5MtLuvWitNRDpz788NE+GsjLm
 GE1v2OJgAJDZLrsGKIrj7Y99CzWzBOZSLLtxF8zNS5HQrYgm03w66oL/rRJy6Z1XaMM2dJ5aKN4
 GS3ddh6R5Qt6QJLAE9fSZI5ENMfr+mdXORRZyE8Kkmot6QXopTp/Lji0DzUWqVnOsRphWNjVN2o
 9FUvfFXXv/zy0jUc3pn+1cKX02LCDb/OuvYFRfMewZgfFkxYgeEaZgNvNVtZRmCMz1uLkunh
X-Authority-Analysis: v=2.4 cv=KJZaDEFo c=1 sm=1 tr=0 ts=689973d1 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=W2J9TUFY3fnUcNkd:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8
 a=-bYqSSMGz4WteIM-f0IA:9 a=QEXdDO2ut3YA:10 a=_Xro0x9tv8kA:10 cc=ntf
 awl=host:12069



Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thx


