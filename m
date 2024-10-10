Return-Path: <linux-btrfs+bounces-8828-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 304249995E1
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2024 01:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5C16284AA2
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 23:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7241E9066;
	Thu, 10 Oct 2024 23:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="X0Xn8Kcs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GVhnvMfR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B55E26AC1;
	Thu, 10 Oct 2024 23:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728604667; cv=fail; b=T7V7plvIJAJeo2tWmcG2pCBAMrSb3ouhainImOp2eVncIudqobo7EOZNWOV7vmidrP2m+0HAmxTMgTVwbs7jmW9lzfMkCOoIQhCLySb/VIdBMGUCblfeMPXzkcS/XNp2nfSS8Nkr9gAsiAXvYsZalNYaCzhmwEP3ZpKpnwzyM+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728604667; c=relaxed/simple;
	bh=1rXu4/XWttnoxpPWjy4nEAwg57U6KgPvJyFdQfMrxnE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MUjeOywOmTjoPA964lED1BYwUHbDLvB52nWGGVsgzFzWEyKkLl/ulBwEOQBF4hQ9G3BKrU8wTPEXWl9ffXuJ6S6gI6vUbRw6K45fJs15FYkw13YHEmY+Enml3lBPZY7jfwHTMftb1PqmrCKLu9yzRExlQlFaTRPz0+30XxckiG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=X0Xn8Kcs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GVhnvMfR; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49AJtdGW012144;
	Thu, 10 Oct 2024 23:57:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=1rXu4/XWttnoxpPWjy4nEAwg57U6KgPvJyFdQfMrxnE=; b=
	X0Xn8Kcsz9oCg5nISr7fAxk1paU8CdYNZ7bK1pwxcWReAc2D7C4NDKgis9HJ6uDd
	rwb8sFo8JK2DEDaHsuWc7uUfxpCPEeSHyJxOASOZ3aK1QWawJi2/c2sbZ8Nldgel
	he6Dbe5tJEoLFtSG7xUQnIm0vSmVbv//+bxSj7VgdtV/HDtinj46C5zFG/ksDQBV
	DiZYiptlWUyGgXGN7+FsBDra+yhw9XtKdQBQz8ou0dBwj+fDjVmtS6J4odCoysiR
	Wrrf9fnJun7XD7ETH0QRW5pof3BG3RSTTei2XmAJwZCI4NHZDGUMwkEXamEgO53g
	TzxA5bqSb0YPw9/RUIzEzw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42302pkqyt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Oct 2024 23:57:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49ANXP1s009279;
	Thu, 10 Oct 2024 23:57:37 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422uwaqae7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Oct 2024 23:57:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a5SSgzb+fYje3sEQIF5mGE5CWbI96lfhjlYC/HgOKLfluTZLpfJ6cXzYCqQeCRTTJzumuS+jBdLHN/TUrznNxzQ3m944yEvvxTfk7MWpY6OP412tLG5+a+1nM97TVLpLub4zMynSk2gMWPPDHs1pJs/cPlJz3HCuwGx5ZKNyFCZoJjT70WbLO6kCxrPnfqaOOeEp03XR2obKXbxlgBGxvdPCqyTB1upRNoCPd515outnkQzUC5IG5TS56cQwXR6Y9F3vcPS5T+kWAJ7HO7T6lDkBQQmvzlO6JpxRPPZv1biTA2HuuMiikHNMA3sQ0jNcKLBV3Uj+ageRDwoYuL8OLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1rXu4/XWttnoxpPWjy4nEAwg57U6KgPvJyFdQfMrxnE=;
 b=kc96ziHSayu/68zXVw46BtINkce6yMBoGfsbZdNN7a/lQx8Q1KDCvW4rGA4F6sAgQwEFX6f1H1AVkvinFCUIam4L9P4Hd/LzpseFzfIV2EVe5uH6dq4CD0OPGne33pziIQz94hlfoOBxQ0iPIF+n/YB7tX3gneDlTWeiEfsWYGLpcusJz6IYXaXE0EYTkCbtAAlfDWOVcbhYYmFWjnD5aL0fjviRhlTJ/Zc6HsIum/LOlWijQ03uvezSMPEfam8Upa9De2g+Wv1cmDx5pd/VEaFoQZMUdAGvrfGbilUsA5sQZv9SBDiVMHxv48fJcNV2oMz4gTJ2fFzpvPyy0U0XfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1rXu4/XWttnoxpPWjy4nEAwg57U6KgPvJyFdQfMrxnE=;
 b=GVhnvMfRhsHfs41WsxlgZUt4ynBtHr+z1ut5XUjTWYop7of3KQ6NlfEvlVGcDIkp7fulj/ZISrpb9CGrpmLdomib8+n2DQYFJYx7pAqoitvzqfFxgok9f7kdowpm1ZThB327pl2gxa1p8FejYXbHdtFPYC794IzoHdZNM4ot8H8=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MN6PR10MB7997.namprd10.prod.outlook.com (2603:10b6:208:500::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 10 Oct
 2024 23:57:34 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8048.013; Thu, 10 Oct 2024
 23:57:34 +0000
Message-ID: <87d0d2d5-f4b3-430e-a139-769f5f10e0c5@oracle.com>
Date: Fri, 11 Oct 2024 07:57:30 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix uninit pointer free on read_alloc_one_name
 error
To: Roi Martin <jroi.martin@gmail.com>, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241010194717.1536428-1-jroi.martin@gmail.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20241010194717.1536428-1-jroi.martin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0030.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::15) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MN6PR10MB7997:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c05de89-5bb2-49a9-7f28-08dce9874f7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UHhId1RBTEhwRTY2eWlOQ3Z0MUw3Q2VBYkdqVTBSaFlNdTJibmFuRnhhRmYx?=
 =?utf-8?B?V1ZkcW44OEhlNGNiYWdpQ2YzUWluS3h6NDdyeGRDYTIxRmV2MTVRbjVlL2li?=
 =?utf-8?B?VVBDcHFPcnRkdjd5ak4yS3FkZkh3d0FVckF5ZUNIRjBBMUpGc0VJeFh3S09S?=
 =?utf-8?B?UVQ3MitvdFpWdzRGeDZyejlhdm8zeU52N3pFMGc3S1g4UFVzcTNTZHJvMzRo?=
 =?utf-8?B?aHljeTAxMmpWd3lINmFhZHhtWDN3cGMrWWVNTVB0bm81cWRkOHdFVWZiME5Y?=
 =?utf-8?B?VThqTjlCTDRvanJ1c2l2b2R4YXJtajI0YzQ1ZWFOS1pwNWZ1OG0rNFUvQ3d2?=
 =?utf-8?B?aU9OQlM2MGFsQlNwSDJMbENubE9kbkhUUG5jT2hTUUtGWllFUm1PSEREQWkx?=
 =?utf-8?B?cldCUzVjeE14ZlhlYzBCajF4dkNKNDBYaTJrOThCc082UFRBenRaaFo0SG9r?=
 =?utf-8?B?YTJDL2tZRUQwZ1M3KytxYklHcVJMajNybDdhUkpySkZ5b0dYdGhabG0zOHpJ?=
 =?utf-8?B?bUFMZExubmdHOUlpL2NkZ294TEs4ZmxjRGk2ZFRsbHdDb240T0xLdENVVjJr?=
 =?utf-8?B?WEFIL3hnK3ZZSDMwRk1RUmcxOWlUUTJJNGJaanpFeXJ3QzlpSTNHTW9jd0FV?=
 =?utf-8?B?Nk44MjFwWGdCREMrY2V4eEFHL3hJSUZnakVZMTdmV2d3NkFnUEt0REtZUHov?=
 =?utf-8?B?eUErU016Y0lOMTk2V29Xd2tyM1U5TWRZZzBXQURRMzc5OGYrR1RKUHpTTllt?=
 =?utf-8?B?UVJLS2Q4RHJodEo3TDY1Z0VRbFpUUkc3UjdhRFI1UlpTRi80MHRHY3VRL2I0?=
 =?utf-8?B?Q1VxaEM3OHlTNERjZlQxb3NHbnk0TUVzb3lVRHljY1NKZ0REeVlNWUtxd1hy?=
 =?utf-8?B?aWFCOE5vU2g3S2lNaHo0d1pRcmowTTRxbmdISE13UGNoYnZYNmFpdzRxc3NX?=
 =?utf-8?B?dzN5UDhMN3B1cHFKRkFFNjVVK0lxNWFqN0tuMHBvcFRTRmI2T3NmUGxCREh2?=
 =?utf-8?B?TlZ4Z3FIR0xyN09xR0NVZnduWlJVL216Y3c4MXFJTHJ5VDViLzdDWXpRVnVC?=
 =?utf-8?B?ZmhOS2IwOTYxSGhoTmp1ZjQyR0MySjlxOHpBaSt0V3o0R3RTU2ozWExoell4?=
 =?utf-8?B?VjBXY0ZDVVYwU3JqWkQyS1dWcmxUc3dhSHpXNVV5OGovUlJEQW4rdjYzR01U?=
 =?utf-8?B?UVJkRUZjUG05WTAzOFNtSVJsUnV1NHI0NGtyenZxakZRaWJzL2lhMGxsU3Vs?=
 =?utf-8?B?Y09seUo2RWZoK1JwYmp1cS90Y1ZtWWV6UlJpQjFZL2twNU5TdmkwVmw2dWRs?=
 =?utf-8?B?WXcrZmwrRXZIMGpXbDZrWlVVY0ZTT0wwOXJ5QnlGcTBBc0VOQlV2SkhGb2pD?=
 =?utf-8?B?Ny81K3E1aDBIUWlkQUJnUkk0Sm5iUE1waGRkUGtmY1JwZFR2WHk3LytGYUhY?=
 =?utf-8?B?WkRSMTc3dmFyS2dMSTE2cHg3MVpoYmQrNkpCMUZWLzFCdkRUZUFKL2xCK0pa?=
 =?utf-8?B?UWJYTWZNalVQWlE4U2U0UlF5SDMxbzQxRGpLMkxXSStrRlVkcEpWV2QzZXh6?=
 =?utf-8?B?QXdZcnR6MDI5K3NtQ3hkWWYyUFpVQnNkUExzbWwrc1d5V1pLQUpwUDRDUUFo?=
 =?utf-8?B?dFhoMUtLVlRNRElEZHBuRFhQbWxpNlkwSWNrQit2aWt2WW9zYjZ4bUJvSytx?=
 =?utf-8?B?emE2ZjY1WjV4Sm1pbmRlTG5ET3JhWXB1S1Q4anNaWnFYSVluS2dob2Z3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cjRJNHNTR1NVN3JQTGVPM1RHY3gycVY1RkJlWWlxWndlSDQyK3VqYmI2b0kx?=
 =?utf-8?B?ME9LMkFhVWY3SzV3d20rT01VRFp3NzFpcWs5MWJTbkhGSUdUYjFOMFloNUhQ?=
 =?utf-8?B?dEo4Q2gxWHlNQVl1cUZmT05lbjZBTXhLSmFHMU9aVkpxNjVwRVNvVFBybzU3?=
 =?utf-8?B?QUgrT3lLNm50NGNLN215d2tUZzdxQ0dBS2JIc3lRZmNxalhHTU5pb1RSbWk2?=
 =?utf-8?B?YVRUdFp1QlJEaFB6d3ZqWUgzM3ZtOEloU1l2UFRTdmFLbXRUV0FtSjNIV2Fy?=
 =?utf-8?B?ZXBzYk5wZzlEY1RZanQyMU9SM05mbnFraHhrbloyNGwvZUEvVk5Lc0tyWEhw?=
 =?utf-8?B?QjFsK0QrVmc4T1E4THNFRWRkRGJEQm53bEd0TmcxY3dWYUVyekdnakN2Zlpa?=
 =?utf-8?B?S1phaVo1VHFEVDR4VzdFUHUwRm5WWnczby9BRHhXd3RVN0hDWXFta3dQdjI5?=
 =?utf-8?B?TXFBMkx3bXU3VGZLdUU5UitSK0JwRk0xWm9CcnE5N2lmM1k5ZlhGS2wyQ3hr?=
 =?utf-8?B?cnRGMm8yTlpSbmZPWkRjdWdxS0haOEhhQkNJdW45NlBBWEYzWFhFU1FXZkFz?=
 =?utf-8?B?Q0xOV2NXZjRIREROM3pQL0pLZHNEb2puQTQyWGxwWklzaWl5ZWVIYnI0L0dV?=
 =?utf-8?B?OWNlaG9WM1F2V2ZmWWdkR3VvVVd6Vk95TXNrdklWc0h6bG1GdUIyUVloVXJi?=
 =?utf-8?B?S1QrM1NWRkFsTEdjRExJY2dFdGY5OVZ4bnI5ZUtFNTZ2K2NySlduajNvWkpU?=
 =?utf-8?B?QjFaby95MktiMlpYQjZpZUhROVIvRUtmTm5BNjM5K2JHS0Yya2MyTHJnK3Zr?=
 =?utf-8?B?TEJ0VzZDbUtmaDFBQTZ3N0JmVVFGVXpVQW5YZ1QwM0xsbVFLT2h2ZXkwSnB1?=
 =?utf-8?B?VkpzK2sxSHFHa3FvT1o1RU1EQmFVNDhvbXNib2p6ZkEwR3Z4QjhpZFFkaDFH?=
 =?utf-8?B?aTlaT0d3ZnJqait3V01wOE9UTjZzbEZRZUo5QjM4MkU2NlZSR1RrVlFzNnV4?=
 =?utf-8?B?SVJ6Mk52cVVlN2FwcVRzdXNnNTRmelAybjN5bENNMFM0blVpc3c5NE9ZRnY4?=
 =?utf-8?B?aXRnSFlXN0orSXEycUpjK09GeGZlRHRmd09YUWtZZTBFdFpKZGwzM016NXpa?=
 =?utf-8?B?MGJhTS9oM3NlNXYxMGE4NjJJWk1ZeU1EdExMV3I5blZlaU80djYyUzAxOFpK?=
 =?utf-8?B?QWVIODRxaUo1V1RQTWZCazZsa0JubS9SQkRYOVFwQ0xTMTc3TUVwMi9sZm0r?=
 =?utf-8?B?ZkQwQWZjQTVyc0ZXa3oyVEtZa1Z0K2dsdWFieEdpd3oyTExPZEljRTNoYkdm?=
 =?utf-8?B?d09Ec0ZGOXpqL3Y3WHh3VTBHWGE3QnI3dm1tTmVya0VLNlBFUTFnVGlaYjgx?=
 =?utf-8?B?Z1VQSXNPTkZmeDhHUFNnZDBkN1d3b2lzdEJld3RFV3NrS3hvU1RpTEdOMWdW?=
 =?utf-8?B?UEZoL21meXZrc1Z3QkFyUWtmbWtRaGJ2NHVSc1BxQkx2NVV6TFhxQm5KQ1BW?=
 =?utf-8?B?Q01MQ3c4VzRsbzI2SWovNm1JbTR1K3MyaWordlg5SEk1Zk1INWFKYjZvTUd6?=
 =?utf-8?B?Y2tETU5wMS9Kd1NUdWJ5dkdNeWpHY1RueU1ZRWUzMnUvN0lBcjZuWGEvSjl5?=
 =?utf-8?B?QkRGeFlyODBGRUNrZWpWMThIVXZoWjRBVG56TW5GbU14cnJJRzBRNmVUUUZl?=
 =?utf-8?B?T3ZQcXcxZnoxYlIxWDRZVDN2YnZMc3FaR0VZRHE0V2ZGRngvRFlWZUZHRlpD?=
 =?utf-8?B?bThuTS9yUi8rN0VRaFdaN3JCMVVQY1NOVWcwaG1PZ2RyWWJGSlpUYTlwOEhp?=
 =?utf-8?B?RWw1K1lyVk9pQnVTOTdZdXNOL3pkbkxjRXphckNzODJXbFZtTTlReElWNlE5?=
 =?utf-8?B?MTlkT2sxYStLRDN4MTdLc2JuaHlCM2lYbUlmdjhwMDJtYnFwbTlTY0FGcmQ2?=
 =?utf-8?B?blVDMTB3MjBXWnRybXFKbVhkOXJOZUFqbXcxZlhCLzlWMGZQS29OOTNLSktx?=
 =?utf-8?B?Z2h0SVUrMjZZZnI0cmtZdExqRS80ckZzRktJMDlST3pLeUlGZlZhbWxVeFdQ?=
 =?utf-8?B?M0M4TzNFVWdmcEtjNlhNRGNmK0VFQUVBTmxlQmtPdEcvMWUxcUx3MXRaRnhu?=
 =?utf-8?Q?0sAKYIq/a8YDYs/f/vfO4HxHg?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	C5oyYE5GEnpSLT+aNrd9fogqrbqlMSf1llA7Bw7Eu56vHmAbJtaZ6uq8ZXzILsTHFKQtfzs+7HvPawsg3LT5lqW0fZpyNdBwvoYW7Rgq/dX3wUQGTUsTGWW2vWfjlET6NmuQyWOp385l7uF5AG2jLam295/zTzzMSq16nIKcGqGXwNUIzmuu87SgEgOWWTC5zVgtJLSHn25dt4wmths1i0I1TZDQUxWS52EhA2L2gJq4MNSpQ6Npp0n0pOMqwm22ZVZubHORbrZlDME5UOIc0V1D1V9f10wiAazBrKm1hJF7qHJuEAaajdiIKlouhS/wOFYk86PgHlA4kIGdtD1Jy5tMbjnUoqlRwFZiloX/YVL07G3HdXSvt5H0/eNsSD4U6FNISkEBotir010t+unVpZuqt7+K0fgXMSnWMh2WVOEAvr7BkWUXbS1soJaHVAQwgGPu0BIQFGm80yHf+bnehjookso3F4fHHB4Ebp5VQxl3bCipjEt5HaDh9LcPWZAAWtJ4RLQvAcFNNRl1wPHiV8qqf+6D5nt2cLBDE8PTSOOM1b8qhQOyL9Cnq25Bgr3174XU9sM48BwI+SWC/y5VkI/hQ0mj3yxqxqy07na1zBQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c05de89-5bb2-49a9-7f28-08dce9874f7b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 23:57:34.6834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xeA28omWmR+xUwKzgJ/KNai7EUZCDPgCPLqJLVRsS+C1bD+pMnG3heq00hCuUV6+VbwPrq34+EZ4Jm7NzIPWcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7997
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-10_17,2024-10-10_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 mlxscore=0
 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410100158
X-Proofpoint-ORIG-GUID: hcqlINl9ChF9y13lmb9VyOVm9eV57MxA
X-Proofpoint-GUID: hcqlINl9ChF9y13lmb9VyOVm9eV57MxA

LGTM

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thx.



