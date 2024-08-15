Return-Path: <linux-btrfs+bounces-7210-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 796D89528E0
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Aug 2024 07:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DBE31C212E9
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Aug 2024 05:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136941448F6;
	Thu, 15 Aug 2024 05:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BNBG+n61";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DrBm9ZWD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D78153BD9
	for <linux-btrfs@vger.kernel.org>; Thu, 15 Aug 2024 05:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723699052; cv=fail; b=Kakz09XwZ2lpsKQOMnvt4fLWWKle+1Z5d8atiXcX5EN7Duvadf+EXkaNHb4EVh6BexmZ/yhdCPLp0Ey23DJW26AQJtv9MK71/FPkXDdOkxwLO0By1sfuu7fcwVSd2+nc3wJPT1QQT4BdyqOm1MahqtcFhohvK4+RYY9YeHHQ4XU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723699052; c=relaxed/simple;
	bh=tTP7SoBTWRsqhuVn8hDp+Fus9nYrSVLqEHdmsSPCZ8E=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dIR3Jb8u4/4SeFLehUKzf+s3hZ8B1yUUToVMaq+7Eyw1YkavUcoXrfQ383WBCAtn7HW2dn0KhJ90fWP0b4JAVqV0bmLsaUnOl7zME52upyhpm78kdv3GUpUNowjHjy8bHmgr7xk3fTzJo8VxrOLdc+91NJERpVSCPMSuylSPt4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BNBG+n61; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DrBm9ZWD; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47EHsah0029302;
	Thu, 15 Aug 2024 05:17:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=QHc6svBXlH2qxQX5x7upoxcBY73PWzqRZCu6NjuwfC4=; b=
	BNBG+n61+jjd80ycsaVx0f9XfZBu3EC3O22TfMalDlSDBB3EfdPOLuzqwcnlpT4X
	0vPBHzAgY14Itvji+iQiNR6g5pk05J4MuhzokSs+3NBAtTKiUe/B9zZAcp59lbE9
	e6NCaffA642g5FPpsYu8rwlEH+eum++2Jt0gOjVVBxGByqhr6XnjJDl8jw0cWfFz
	PmAtE5Uxyqp4xImNX2vJm8quO/TVXfmpCSnQfN6klCETREUeu59nPpbLzO46fi1+
	lGgqlcuoad4BeDFsKcMUWwL5ZU/3yadd5RsYizU6ZWNQBSIgE5haKCB6uy4Cn//E
	z16h65838jypAzIfiGZNlA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40wytthv2m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Aug 2024 05:17:27 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47F2RwGT003397;
	Thu, 15 Aug 2024 05:17:26 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40wxnap1pr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Aug 2024 05:17:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b8NMJ4Dw4F06AWMCjQi3IY+otZTi3sBnpYUfsluO5LkjAW3Y6HYgKhNJc+THsDfJn48UbPWTtZJoTUaS3VPdQiPY6xfVdE42XhYU9TZkhgAQQXG8A9gVlGb2AObZkrV64Kuqzb4OS3ElW2C08UHjo8V51/vDrsZErRHB9AAXZ5J0I8uUDOot/W/uHBEqjHrJlUTKciwQ+s45Q8D4GeTnJ9srS0dnF76vtiAIM5wc2PildoXuN3BaGusqaEGPLBMliKI7UpK19VVD6DA4taMrPH8nCgoQ2J/OpM/VUDP6g297VGKzxOVtaw5lTOJVOA3yRvFglm6sGReYPGwXxeXPdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QHc6svBXlH2qxQX5x7upoxcBY73PWzqRZCu6NjuwfC4=;
 b=wHriAO6T1lKVjaazX2GgTTYECDEbYScvr2iJImyCPzsvQFzDe8fxCWejlF3knVa1CQ73IPVvHrmA/ulJsu6fZP6RPtnj0ceuUyX9tYYosCXTM9oKiOUVuRddvtk7pR14gy7kbboYEQ6JppGRY+08apkHSm47l+exswBA9++vzggQPK62a2tPrHv8P+bOQipYNy8OZwuG0ilJO6CIHISuN95w5g5aK3Qel/edyLC9DozPGqlpMybbfPWACT+YAVNQ8Zec8qTLa758wCSG95+TRzAZPqtTDu8Eb8XRTq6rzQw5cIzBPnJUYoYLhugruXkBgP04eBEs9053yRCXBq7Yxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QHc6svBXlH2qxQX5x7upoxcBY73PWzqRZCu6NjuwfC4=;
 b=DrBm9ZWDR/ltVXXhq4jOVrYE3ewtJTNt+W1wGegd+tK24S77Ln9MILrEREJsqeIajoFXGeDj9oy01yFHBe2JRUxV5bFC1O3uSsbU1b/rRTAawiCLr0FkKXlVb3ogSAdvnUMqqQn9R/bdi1o5T1mdaPY1FLKhaItn6jEgx8fbEXk=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH7PR10MB5832.namprd10.prod.outlook.com (2603:10b6:510:126::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.15; Thu, 15 Aug
 2024 05:17:05 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%4]) with mapi id 15.20.7875.016; Thu, 15 Aug 2024
 05:17:05 +0000
Message-ID: <209d5658-01bd-4c06-ad2b-c7fc281a0c0f@oracle.com>
Date: Thu, 15 Aug 2024 13:17:00 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: tree-checker: add btrfs dev extent checks
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <eb543cde2378cc111b0b8359ef94ff0dbd51ee58.1723355397.git.wqu@suse.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <eb543cde2378cc111b0b8359ef94ff0dbd51ee58.1723355397.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:820:d::7) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH7PR10MB5832:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c0f9b71-7240-4cf9-2ffa-08dcbce980bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WmZ6VWIybHVLdWtKcitMUk85VlpubkpXVWJ3MDk4ZUlNdDFwOVRiak42alJP?=
 =?utf-8?B?N3hpK2ZCcFVVV1NtWmkrM2ZpaDhTbVQ2OHlzVTFkaG0rVDhpRlhTcnRMcUZD?=
 =?utf-8?B?UnJ1ZTVqWHd2eW4zWkFPcXR2YUdZcFhnQ01adnVhcEZEOGxBQjhSTzhYTmpw?=
 =?utf-8?B?Y0FYWkN3VTVITmR5bFMwSjhab2FpZCtPaHZJTUkrOXJTaFZFVVNuL3pwT1NT?=
 =?utf-8?B?K0xsOGY0YzFNVHNJOVhrZk5YdGJWYk13c1o5bWJENExBU09KWjdMc2ZsT25a?=
 =?utf-8?B?eGh6MUhBOTBDWmxPK0FMR3VwRXJWNDhWM1NicS9peXB0T2h3WGExN1pQY2hL?=
 =?utf-8?B?eFpXbzlvMmczNFZjUlhSaU45Nkp0Wk5vckt1WTBmNEh6OHNLanZobUdycHZq?=
 =?utf-8?B?dTYrbzlwUW9FWTZMUUMvMUdKWDNvc2NiVkptekE4NDJQdjZ3RkJ2eEVWc0U1?=
 =?utf-8?B?V2V6dTc3dEQ2U09sS2tHNTAvSldqL2krVUYvdENVeXpyMFdqb3BFNTk0QW5Q?=
 =?utf-8?B?TGdzQWFXSmhmNjlwenA1bGtITWQvNm1zU3lIT1ByOWIxajVvbjFKU1ZFYUZh?=
 =?utf-8?B?amd2NWwrOWIwTVZaU0g5SVBSeFBTMU9XdjlFZnpPV3JsVUV6SWV1clV4TFY1?=
 =?utf-8?B?b3F0SGI3RkVMbXplTjNjVjYvWGI0Q05jcXRxUDBoWmFEeEZhTlR4MlZzcWV1?=
 =?utf-8?B?REszNzlSYTB6NUFUYmlJUThhcmZqRUUzRlJVdktoWUlONUhNWVRaY2F1cnlr?=
 =?utf-8?B?SnZiTmNaa2pZYmJlWkNRaERwcHVUZVA0WHBSdjg0d0RGNjR3dmNmQ2lQZUVN?=
 =?utf-8?B?QTl6S043Q0hidlczZHRtaVVhVDZqcWpCVzFXNTlCb24wZEtrUXRKYVRocWNF?=
 =?utf-8?B?SjhqK3NLZ1lBRFdKbHlYUHZvb2dlem5lNE9weVFrenVNT2dUR3dZUWIyOTM3?=
 =?utf-8?B?NGF1azJhL0RldlQrdDZKcStGbmRzZG5peUtVaitsalhCZ1U1cjlDOVdWKzNN?=
 =?utf-8?B?OFdxU2VMUU1pdjRHS1gvNXp0SWNhZFp6cU00SHhqZnJBQ3hEaitSaTBVbWJK?=
 =?utf-8?B?dnQ2WVdlL0ZSa2s1cmNhakNnQUtmc25FSThROStkaXJPc3duTE9zYkRKcW1n?=
 =?utf-8?B?S3NHWmhtNDhhRGt3UGNuMHVDYU44MGNxRU14RXNDdHpGeVJrZm9VVDVHVU9L?=
 =?utf-8?B?QmhrWTltRkduaTd1bXk3TjViZ2JzZ1oyeW9uQkd1OGVXUmVmRFpkOGNiOTla?=
 =?utf-8?B?a2ZTcGptZmFPL1gyQ2hJSGl4MEk2YmVFK2ZEdlZKeVNLeCtuQ3lhUlhIWUk3?=
 =?utf-8?B?MUlDV2kwMnhDd0dLcXpqUFhDZ05JR0dCd1A3Rlg1ZEZuSTRBM29odUVvTDU1?=
 =?utf-8?B?Y2R6Y09OVnEwb1VXd2xkMFl5MFlrcTd4N0lmRERRbDhqb3JzN2FUc2tSRGNW?=
 =?utf-8?B?b3hTeXdtQ1RyZlR1RzBGMm5FbndaQlR3ay9xaUt6NGZXS2g3ZmF3dUFtRU0v?=
 =?utf-8?B?RG5RQzlRRWZ2WTVJVTIydlk1dEJTRlc3Z0hFaTE2eVhKM05qYzBXM3g3SGk0?=
 =?utf-8?B?QlR3TmtXc2lhRnc3WDM0dFZ1S2hJTG1sVEVLZHpXaGVURTQxeDE5VlFvRVls?=
 =?utf-8?B?S1MwNHRodFFlNUZsaFNMQWJ0ZlZTYXB3c05xcGlaWFRaZTM4b0IxZk9WYllH?=
 =?utf-8?B?aEJHMXVMTTBabTNHSWd5MzE5VVZkVmpBbjB3TjVKL1JadXBoQkVoMzR2NG1O?=
 =?utf-8?B?TnFTVWdHQWlZSTNSRlZHdytINS9nNHNYNWtnRUU3cVIxRTNEM1FqUFpiWVhw?=
 =?utf-8?Q?kk8Sx9K6meI++LPIQM5Mggmvm7nV66zDiZSug=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VURJbTBMSEVQYiszUDRtR2xDdzZaVzNGUW5aanNINWk0bFo4MlA0VkQ1Q21z?=
 =?utf-8?B?NnFaOTRYZndaQk1ET0JsQTZYMUNycWpGTXFUcVFMWEJNZzBXRDJPWVhTRzlW?=
 =?utf-8?B?WU5WQW0vN1pRMFNiRnRIL3dUb0hWYlFicWhWVTVwT3JWS3Z2VDdQaG9pa0Z0?=
 =?utf-8?B?NG1CSFpmcmppVEdjRXZRNHQzL2ZWS094aUI2WUg0MzBNZ3NYSnFRTHdIUVFQ?=
 =?utf-8?B?bnZpUEJXWW5lSjZrS2VXaU1KQmt3MFIyU3pUTXV1eFpraWR5bkUzM3hvN1dz?=
 =?utf-8?B?dkYyL2FCRlB1Q0hZbVdxbTRjMCtBc2kyTms3S2NyVHVtd0M1WEp3V3IyU1B3?=
 =?utf-8?B?QytkMDllMnp3YVhpbk01cHVnQS95Q1IzWjJGNy9WN05oSzBxcDB6MkpUYzZq?=
 =?utf-8?B?MFk5d1RvNTA0ZU1mNWVGc0lwNjRQbHdlMDFjeWVRRk0xSjJRZ2xaZHRLYWFU?=
 =?utf-8?B?NVMvcDR1bnNRU28rZUZzbEliTVFiengzdGlSbXMwQ3NFclY2V2ZoSFgyaWtl?=
 =?utf-8?B?TGZ2U1BmbE96UHk4WTM2KzlNK2l0RTgxK1RuY21JMHd2ZnVXSE5seDRpRlpL?=
 =?utf-8?B?Y1JCYStRdE5IOXBOaTZwTVJLRldMVE9ZUW9zQlRBNis3ZG1RQVZXVmJtNndC?=
 =?utf-8?B?WWJPTFEwc1VwWHRCVXdOTzdOeHE5cklQUzZOb0QrejRTYWR6bmJsRXpPai9C?=
 =?utf-8?B?VUhuNHpCVkp6SEY2MGpjMjVNcjMvM0ZWWGEydXpCamVpNi9HTGFMSDhMQnJ6?=
 =?utf-8?B?NHdNeHpidUptOENhN1R2cG95MFpyd1pIWHF3MWx1SnhKQ3MyYWliLzZsTnNR?=
 =?utf-8?B?WGNzdCsxR2FaeTlBTWlZS042WFo1d1NJRzdlNll0a2luYUpGR2NvWko2VkpY?=
 =?utf-8?B?dEdHeU1mMXNlckJUZ1lMYWtyRzRWUkdTcE55UjJubnNkMWxKTmFRMG9QZWt4?=
 =?utf-8?B?K04rYzMxOVpZSlVxM2ZyUlR4akFZTnVGczhmb1YzaTc4dU5hSXdDekU1dFZS?=
 =?utf-8?B?NkpxZEJMaXZGUS9IcGE1TWpraElCSmpranVMSDlrdmt3VGZNMUZwc3A1SSt5?=
 =?utf-8?B?UkJFdUFlamM0MTltdnNKNjBlZU44akt6MVZieFRBcmFxSVVXUHQ5K01QcWY5?=
 =?utf-8?B?UENMUDZpM25FYklUaUxhV1l1bk5zZlE3amNyTDRyWlM3Ykg4Z0h1WlhGQkN4?=
 =?utf-8?B?eFZXNHp3a1hRNXZuOWRtZ1IvZWRQbDZvM3JPclc1UzNvZHNkQ3F5K2tlL2ZN?=
 =?utf-8?B?aktTY3dXTzZxdXBsWWRtUWhlYlVZS3BXZFBEVGU0WlFrS3pwczlPUU5CN25h?=
 =?utf-8?B?TVNTNUQzT09heWdhUjBuUG52b0hzaUVzSTRGNGpXM3puNnJHMG03b2ZINXJ2?=
 =?utf-8?B?MnBpc082L3Y1NVlld2dEa1JhYmJyeWpicWp5MTBzVWJ2K1lZK2h3RVR6U3A1?=
 =?utf-8?B?eUwzWTFFQW9KelZYM1VqcTZUWlIyUWRiUXRTNzZQWGw4RlEwcW82UzhJTmhr?=
 =?utf-8?B?RmdVR2tlNHlqbXdFeEtoWXRZN0hEN0RjL0RsaUUvRC83WDJxc0ZTeWhYU0Vv?=
 =?utf-8?B?alJQdW5MS3lYVDVDK1prR1BHcE5oV2VqbGs4TTJ1OUgvUktuYS9TaWY1WEln?=
 =?utf-8?B?WitLaTBGQzVRUlN4ZVp3NW9hdVdrTCtEOHh1eXN6WWdaaEdXNTBrdktDMXp3?=
 =?utf-8?B?NUFkMGxjRzBmcGNHcFI0NU9tRG5zVVBDTGF6RDZDT3V6dFYvdGphVUxCWTlt?=
 =?utf-8?B?YjNLbko0aHhxeW1xZ0pzNTY5bGxPc0lkNHhvWiszUWpxZW5SN1JhUXd5VVlx?=
 =?utf-8?B?bndoUlhYVWgrV1BUSEpMSUdNVnNYM1JQdWJBcjdHVy9GRzRVbE9GOWF0N2Jp?=
 =?utf-8?B?UG5QWU9WYTVOU1REQytQejNIZkcwTVVLaEVNTHNsclk2ei9DOHdreE1Fbytr?=
 =?utf-8?B?dlF2dDZ6NVMzUEVaL1Z6cTByOGtPbnZPbGUxQ0QzWHpyVUtpWk1hUFhLODZD?=
 =?utf-8?B?TlN1MEJrL3plUHYvTHZ5MVJ4eW9kYnhCNFhCVE51bnUxTngzZzkxcGk5NnEw?=
 =?utf-8?B?MVBpcFlOV1pPUlZrNFlYZ0EwWE0vYnVLbG9ZT3lZWEJLTGFiV0RudG5ycFky?=
 =?utf-8?B?dlBjajVFOFRyaUFtd242d2FHT3Zjby9ZVTBBb0xySlZaS0xTQWtUOVVHY2ZH?=
 =?utf-8?B?QWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sXYdXoPk5tplLgcR1IaOlcVQA3dseUqfobKn/vP+Lo06zqSJganAQI3vIpOQrxLo3A8Hk8IgeTbBwn92bwn1TXC/G2sA8/LoJfBwekf9zZYd2svw4uXFv7Zy1cHNcdh5S8NDhSJVQgP/sWr0roL5HPoTLAnYvEgxSpvGTjZOusEzBEeEq28X60BuVI+kuDdmXq1OA41sawCB3hAL+dXvEr7hT4uSum1pTt2jbwWXwbr/Gj73hTdPmvmXj7np+718RlwNCxEAQPSggCiIpvRohtv0YP2M8vd1G96pEV7ysjXmB/DITvGtL676Zq/bymAmNoQzPEZLikY4q4tgSSBmbVJbHh2HfQq0iYq8VPzBFycO3qDuTE0VdvNlEJizBZWB2xf3fYnRcW0WnznbpEjDahqAPChSOC9XCPj6xZyHC7fVQG9J5nCiZ3iiEPojdKOGFDmZ6IlUF9iRVcjJsdMgIZoLC4i2G6B0cJWwxCg+96CzP2qiTlRZGYZkOwDYPynFPoQEeV9FS0x4G4IDj7K+TQogTsV+UrkVJ38IgV9LHIgeoIUrcUniwOS11C9QwwUxSHOPtg5BQqbvsRYLRo71MkN115P+2325nFdumvNuMvI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c0f9b71-7240-4cf9-2ffa-08dcbce980bd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 05:17:05.7492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HMetXBHzwSyyaBjLuUww9Lr3lmOjgU+hcoIUzgWEopIJ44Pa3gOqg2sNS6JQCxLDTIxkkePhGeGrEkfE36NyEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5832
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-14_22,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408150036
X-Proofpoint-ORIG-GUID: DulQF-FknS6bwLn7Fw49692MHZSeYIm1
X-Proofpoint-GUID: DulQF-FknS6bwLn7Fw49692MHZSeYIm1

On 11/8/24 1:50 pm, Qu Wenruo wrote:
> [REPORT]
> There is a corruption report that btrfs refuse to mount a fs that has
> overlapping dev extents:
> 
>   BTRFS error (device sdc): dev extent devid 4 physical offset
> 14263979671552 overlap with previous dev extent end 14263980982272
>   BTRFS error (device sdc): failed to verify dev extents against chunks: -117
>   BTRFS error (device sdc): open_ctree failed
> 
> [CAUSE]
> The cause is very obvious, there is a bad dev extent item with incorrect
> length.
> Although we are not 100% sure of the cause before getting the dev tree
> dump, I'm already surprised that we do not have any checks on dev tree.
> 
> Currently we only do the dev-extent verification at mount time, but if the
> corruption is caused by memory bitflip, we really want to catch it before
> writing the corruption to the storage.
> 
> Furthermore the dev extent items has the following key definition:
> 
> 	(<device id> DEV_EXTENT <physical offset>)
> 
> Thus we can not just rely on the generic key order check to make sure
> there is no overlapping.
> 
> [ENHANCEMENT]
> Introduce dedicated dev extent checks, including:
> 
> - Fixed member checks
>    * chunk_tree should always be BTRFS_CHUNK_TREE_OBJECTID (3)
>    * chunk_objectid should always be
>      BTRFS_FIRST_CHUNK_CHUNK_TREE_OBJECTID (256)
> 
> - Alignment checks
>    * chunk_offset should be aligned to sectorsize
>    * length should be aligned to sectorsize
>    * key.offset should be aligned to sectorsize
> 
> - Overlap checks
>    If the previous key is also a dev-extent item, with the same
>    device id, make sure we do not overlap with the previous dev extent.
> 
> Reported: Stefan N <stefannnau@gmail.com>
> Link: https://lore.kernel.org/linux-btrfs/CA+W5K0rSO3koYTo=nzxxTm1-Pdu1HYgVxEpgJ=aGc7d=E8mGEg@mail.gmail.com/
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Looks good.

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thx.

