Return-Path: <linux-btrfs+bounces-5270-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9468CDFEF
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 May 2024 05:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 584261F219AB
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 May 2024 03:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169E3374CC;
	Fri, 24 May 2024 03:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gC8d4qCf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KWsj3ami"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CA01C17;
	Fri, 24 May 2024 03:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716522692; cv=fail; b=BMMiOpSGOdVsTRTEhNmj90EnFc2QvdxlyFVdRrj2YpfaMqTxROoAsrhWQtjgWq8F7xXvue2oS5hrnuk79CkKtDZfFXR46wa25Q/41n4n4uO/9eyYP9U0SlUNv02rdUagN6cv9JJ2L0TX26AGA6mbZCCshARonbJKcdekBW+txfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716522692; c=relaxed/simple;
	bh=Oovnuvq6qltlUWx9WdoQVD6lyoA2YoH+olHEQIpE5Zc=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IR8xbXRLoOHiY5hWPve9mB0wUqoRXDoHZoC947Ijc9CLFGcFa9WkHVaL1Vf3l4LnN9rtUsCXEDRiHH9CVyD1uDmqZK+/YMRWxJtLU1Rj5jxDX2OPvY1H2u+O/Lp9kjfE89S7WOhEvKN5bbp7KAcg4c7BqcO+ird+RBO3uelbwGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gC8d4qCf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KWsj3ami; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44O2unE9026258;
	Fri, 24 May 2024 03:51:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Cz6CEsPsYSRqzOSQLL+Bi6DGU6WZGklwu6/28I7qAW4=;
 b=gC8d4qCfpbWgRg1buwMaOULzzQ1hXB4G6GYI60oYxgbms2Ssbdg6OVWTYMNxEFtUv+Yv
 sgJdUCNVrT77WOEsxgcZenIWUtyU1HXkqxCNfGZCHnhZaY1r52BONgbBvfo3RRKqjB2t
 VBv+15gP9IIO2CjIDApYfPRYlvmJDCUYHf+Dt29CDap9t3KxO1tJvQSeZVr/wTp9ZCZ0
 3ThQzlApejyq2nvR+xecxpXU5xoIKk+jB5L0ANSXUXgEbYT43DjwPNNMWdOOERCcvHzY
 PIwaJtm0MuBWhsF94Scu8Cf/7h3uinX6GIHgIdzSmtCdxOHj9Bxzvj2sxW557AjwZwOw 3g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6kxvbksw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 May 2024 03:51:27 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44O1ACpW037850;
	Fri, 24 May 2024 03:51:26 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y6jshdn8s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 May 2024 03:51:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q1dFYxXkv9OsS9wUzQd2LJJWDpPJR6q8AcvdRcs8F0CXKhEZbQpMKDcECVCTYx+YezIi+nSoiwEhwO3Jbr4omS9DhoZpZ4KTbm46pk8UhuB5CeuEVSYKIKASipS4uU0TDRL4JHfo/anh6xWobPCHjH7oEW0JgaufRr1zNaO8NA0HJ3hlzcJ9RtQUsjC7gIH0IhaPyl36fYsVdPuj4W1fo+czY/btA8Cg//h03+KIXHdqGhwBbYXz9IUsdlvvR6o4m/YPi6YBU/1kfshPkP5MFGJxTyZn59kIT5ztbEJQmavFtshmKDr1tohx5QswfqddoYt2KzMu9NH1MpTNg55uhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cz6CEsPsYSRqzOSQLL+Bi6DGU6WZGklwu6/28I7qAW4=;
 b=hvMRhfH89Wf715sq32jr0/jeuXXvezpZGn5cflamiL2g0IjMjXrO3HGPS9KPgFc8uhiv3k5OJhfIhOfD0ZhpmRs83hs7v4PR0Ses9eaJNLVCStfmfX31Ld+HI4SPbjsd6MW3I9H31YlD9DRN5SKkbrxV06e5gn5hin24bxwMJv+SgC5W6obsFEg18YOegJvEIXMQm5gZm/2RoH8lw5kF2onpfL6fTSv9rQqmzoOfROOmtQoiobTsMAPG743VMvjaLLGsNfVlXhj+hN8fqaVj57WfWf5VSahNmKXJ444MQ//8H+I0DJIZk0IvCAteE/Xp8XG65+IxEED8rLGSdVMmUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cz6CEsPsYSRqzOSQLL+Bi6DGU6WZGklwu6/28I7qAW4=;
 b=KWsj3ami1orJUV4zvCGE64+Ix232joYcs0Ixi7f1zCAAfTbxAr3Rn4Oj7JMjYpFt4aEbdGKurA/clxdxj3WUgEy+B1Tk4L0X915cFNTTLZ5YlhIXpY3Z7RqXdTBrxpeqdutIMaeGV/Gw1Ffj22u8BXlewsThnv7fzbRZFK8QWwE=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SN7PR10MB7048.namprd10.prod.outlook.com (2603:10b6:806:347::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 24 May
 2024 03:51:24 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%6]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 03:51:24 +0000
Message-ID: <c3eeb574-203e-4b1c-99f0-61fd3cd48232@oracle.com>
Date: Fri, 24 May 2024 11:51:18 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: mkfs the scratch device if we have missing
 profiles
To: Josef Bacik <josef@toxicpanda.com>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <adcf935ecd3d44957ee244b91790ee7b73df134b.1715112528.git.josef@toxicpanda.com>
Content-Language: en-GB
From: Anand Jain <anand.jain@oracle.com>
Autocrypt: addr=anand.jain@oracle.com; keydata=
 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
 y4F0QrzFk5Hg4pvnpDur6Cbp
In-Reply-To: <adcf935ecd3d44957ee244b91790ee7b73df134b.1715112528.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0042.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::11)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SN7PR10MB7048:EE_
X-MS-Office365-Filtering-Correlation-Id: f85cd83c-5e74-4e64-cc03-08dc7ba4c860
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?MEdZUnY0SWQrc0oxaUM1QVp4Wm82Rks0UEF4dlh5K1dLK3NpM1RyTnpBamlR?=
 =?utf-8?B?L3FpV1BDZDBSQlJCQUIxcG1RbGdBOEwvT3JiNmtkdVNMQXJzK0M0VWd5Uno1?=
 =?utf-8?B?MUd0VngwYjVxdG94MUlZblpDTGpQdE5TRnVENFpRQ1JQS3E0c1R3ZVNlQ1Bk?=
 =?utf-8?B?RWlkVnBIdXpvN21RazlsNXBlVEd2U1pqZFUrZGh1RjdmR251TTNpSDdYMEpV?=
 =?utf-8?B?OXJkbzYrRW0rNEFDV3g5SDdLeDkxUHhNUTJQUmVEMXFYbGhkWXlvYmNKMWVq?=
 =?utf-8?B?blk4UmY1QzVDcXE3VHZlR1ZFRTdseHdybjB6M01MaEQyVEgwOVd6WWh2UFBT?=
 =?utf-8?B?OUx2RFF4WnhWTzdZQmtKYlFQa3BGZ2tEOFZFMmxQMTNRMzVvampYc2p0T0k1?=
 =?utf-8?B?dHVHM3N5TGtOcHJTSU1HU0hBdHdNRXJFQmpUdEJHZW80VlV4UnFEM1B2Zm9q?=
 =?utf-8?B?UW5JTzhUMEc3V3g0d2FXZnJQUTJ1eVN3OWJ4bC9UNWk1VTJPTDBWeUt0L21a?=
 =?utf-8?B?OXdCTDBoL3AybndOUFhEcnJaTzY2bkVWakIrYjlIYUMyLzFGNzBTNDlDam50?=
 =?utf-8?B?Mkpzc3NXQXNuN1VtRUpxUUZDaGFzd3B5NzUxSDlNUnBGUGpZcjNIYUs3QkxB?=
 =?utf-8?B?LzVnaUM0WFBsOW4vdVoyMjg2Z2RYMzVWSnRianRJb3RZNHZveklRYUNMTUZ4?=
 =?utf-8?B?Z1VIdXBPMlNjbVRIdDkrQnFwUVZFZU9LTFlESUtHT2FoSkZnNFdUWGo1RDcr?=
 =?utf-8?B?OWhhQkNobndSTUJxb09UeG9zK21OSVo3VW51M0VTQ2RaMGlKaTNHM1VSZDU5?=
 =?utf-8?B?VU80RHIzMFVuRzhWMVU0c1lLMzdzNjhQUXJVMkJxK2kxM20wano4YnlBT0V4?=
 =?utf-8?B?SWNrTERIN0RPenVUZ1hDTVJzN09WNDJzUkVTWmdBQ3ZDSUQyV3pocXpNY05u?=
 =?utf-8?B?SGJFNk42VGZVeG9CM1YzMUFrM0YvY2FsUldaWXB0UXV3aXdlY0FPcnVwa0wz?=
 =?utf-8?B?NXdtVEJuMU9hK1BpYzNoazZGSGp1WjMrVU91TjdnL2p3TDJMUWNNT2dhSFA4?=
 =?utf-8?B?R09aVjhZM3BTMHhPeHJTQVhyRjgvT0doUVdTUWJZaEw1ZmtnUFgvVzFLM1Vp?=
 =?utf-8?B?VkxzeUo5UktQNjRBb0dscVY1bjJmQ1hHaFZwVmFRbHZPYVBCM3dVNnk5OXVa?=
 =?utf-8?B?eVY0SzBnUDgzd2QzcDZ3N3lieGhPZ3IrTFZjYndGMFJnKzhBQzN4YythckNO?=
 =?utf-8?B?cGhKWnRCTnR4Qm53SFVuZlR4YkRBSDF5c05ibHFhQ1F5QnRzd1k1bWE0WDgv?=
 =?utf-8?B?L2MwWEFzT0ZVK21zVWtRRVFjcnhQeFhlRFpnc3Z6QXc3UUQxcGl3U0ZDc0Rp?=
 =?utf-8?B?amdaVHJvYWJROVJUVDAzb1VqbEJsaWRhZGQ0V2trTlM4azN6U1ExTFBralFH?=
 =?utf-8?B?M3JZWkMxWU44QkNKMmtaRG9HSnIrdnoyOE1vK3JQaVV3dEFhai9WVjRxZ1or?=
 =?utf-8?B?d0hMSWxCWTJmNjFSUEhXZ3M4WTVsdTMySUV4Mk1VbXJSV1JueXpzNDFSVFY3?=
 =?utf-8?B?RmttMklLL2RoV3ZTMjN1d1RIc2NMcmlPQ0Z6REFVNC9pSGRxK1MxN3dxbUp2?=
 =?utf-8?B?Q0Y5UnBFTzh6ZmtqWmMxcnQ0VzBDSW9jRzZvUGlqdXVSTVppWk9WRDhsK1pD?=
 =?utf-8?B?MXhqek4vOVVqUjBLS2ZvY3U4TndyVlp6OTR4QzV5VFkvQ3k5bk1wQm5BPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Ukd6Z2pkYVBueFFpbDcrakNtMllEdFV2YnoyL1RieXBhb3c2SmdXemVJVUl0?=
 =?utf-8?B?VzBGRWZaRHI2V1VNcWUrZ2Uvcm1pRVBJWmtUUGtBbkxUREtzT1N2Zkc1dGtN?=
 =?utf-8?B?OE8vTjhJN3VJdHBCYXlMZE9lbUtsRVU2L204RnB0MlJTME9pRW5rR0xhQmo0?=
 =?utf-8?B?cHRVdTdXVjJrRGh2RUE5dU5OZWUrMmhoZ2VCdFN3eDhDQmJhUVFMbmtuWFJL?=
 =?utf-8?B?SDlNT0tQMDNkYjdQcU1TT1BJamVUL2E4Mm92aUN5Z1NrdFp1YVVWSytLOTZW?=
 =?utf-8?B?WEhpMjlzeTZEMmN2T1ZDM0N4M2VzcTN1aHhySkZXY1J2MkV1ZGJaUW5FTUNu?=
 =?utf-8?B?T2IxZzhqUWtoQ2RyOTlRUmFLL01CVUlJUmV5T280MTZhY3JEK1ZBU3V3cGMy?=
 =?utf-8?B?cXBDb0Jqb3hFRFhIcW1SdXpQWUpvTkZicllEQmZxZkVXaVBjMTlMdWJYaXIx?=
 =?utf-8?B?bzcxRFdScEZjRkc2dGU4bnlMdUp4bWlRek5kY2lIRGZZa1ZsNVJyMFBSOVVz?=
 =?utf-8?B?YVhORFRIWmpEdlRORkY0U3dFbzFyMUpIdGZTK0VjWUpzaWcyVjc5NVdwemZl?=
 =?utf-8?B?c1pZb3BtbnhsVkRkQVJFMEl3eklnbW1mTXB6Ykk0RjlieldocS9Nbm84c2Zy?=
 =?utf-8?B?ZXFMRlNRWGI1eHRmVEZabHY3NHM5QmpYblB0b3lRb0U2K1JmYW1Xc20xVThE?=
 =?utf-8?B?M21NN2NkN2RZRCtsSFNVMko4VitPVjlSeW1pUURPSEdmYzdHYzhuQXpUVjNx?=
 =?utf-8?B?V1MycU1IbjlSODhWblNYZndQZFMzOHdKcjFhMWF0R01KclI0MkVQVW1DUDc4?=
 =?utf-8?B?amErVWpTQkpXbDVhRkFEUlU4cU1WZUxXLzFITGo4RHR5NE9kNkthblhDWXpM?=
 =?utf-8?B?WW1DNkJIUVZrTmxvMmQ1SzNvY3RBK3pva2t4VE45b0lnSlR2aXJYYWRPaXBL?=
 =?utf-8?B?Wnd2bDZZZjFvdjVaQk9JTFBVM2NnYTM0dmVRWWVJK0RwaFlPKy9hVXJtRjBw?=
 =?utf-8?B?NkU0amo2R0ZqSkpyS2M4UzZKN0V2VmNxRGdnT2dqeVNlcDhxaGRoQXhWWFZU?=
 =?utf-8?B?T1BJZG84WEx3MDZta3k5ck1wcEZUOE5zam5obU1HakVoNEptVW4wR1FrNmNR?=
 =?utf-8?B?MEhnMWF6ajFCRjZOeEJNT0l4LzhZSTZRc1dwNktTZHdVWjBYeFhsZ2s4YUpr?=
 =?utf-8?B?RkJvRGpHZzdEYnhnQUtwSmdZazdsT2RvYWIzYmZHb0dURDZCU09PeGVXNC9H?=
 =?utf-8?B?ZE5BRTFCbEpMd3JMWUphYnRWZFdvOTN2SUJ0Rm5RdnV3NVJmODBWaDVvR3Vu?=
 =?utf-8?B?Y2YyalFvUmxBNkpaVFVvVlFTZExmZFQrUUJPckZ5R0REUjcvNlFteDBxRGxn?=
 =?utf-8?B?TldrS3BOYldzaGYzU1l4ck01YVdsSUtoRU4ydUErRlQ5NnQ5WFcxL216ekNi?=
 =?utf-8?B?aUUyeHhxbENESEVNdzczY3I4cmliSmpZcjJzRXBnMGdtR3ZaMmZydzZpbFNo?=
 =?utf-8?B?dDk2ekYySTA1U2VBdUhNQVBLUkU2OWJucllha0E2RHc0MmVqY3ZReEJ3c3Mr?=
 =?utf-8?B?QU1DNVBFU3U0QVNnTVFob0U2RmNqeXhrL0VoRFh3UkVkQlp3RURRWWFXTEh5?=
 =?utf-8?B?R3JsVGpwaVVxN1QreVpKRGlKR05MdlBBSGI2ekxMcnViMjY3QzZEUDFBMkJ0?=
 =?utf-8?B?UVZ1bWowckdCTU9XWXRoSTA0MEROWmE4TVppTmhkNEppdEZPRjFyMGJBa1Q1?=
 =?utf-8?B?Y2dKQ3o0cFFPS1ZaUXl1SUlodHpKUWlnNDlZL1J6N1FvM05RbC9VRU42UlVH?=
 =?utf-8?B?SzZoRC9ua3E3YVllM1JKMUlISldWU0VhY1pHYjNVcStaRTcvR1l6TkVaV3Na?=
 =?utf-8?B?a2pXbVo5SUc2Z3Jabk9YYTVWL0lXeCsveVhmSjFpajRiRXh4d0hxZHZmb2V2?=
 =?utf-8?B?M1UvblgvbXd4Y0RuODhlTVBtYW44WWltK0NOcW9DY0d1b2xaZDZtNVQ5TkJG?=
 =?utf-8?B?OG8rSmZRdTJpMEtoczRZaHo1Z0JhVUNocFlHUHY3bnB5a3RYaVYrMGh2RGJ2?=
 =?utf-8?B?ZDVvYStrL1VDK3pCZm9CT2FIbVpMOXA2Z3hzdG1mR2ZIdm5ESU9FalZkckpQ?=
 =?utf-8?Q?fGiSsOZXALQhBibuyzNZVQO6S?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	NibxqqDnlQla7jursOJoETUOeZamFDbdaGC/G6elNttx3LkxLPmGn5PM0mLyXFKW4XUfLuopxP9CT97u0Sj25b0ZlwWksm85MljfvDKTVhTNx4jbGqpshbD095j/RfWS3zPFX/CZRkH01QpUSfG/0lhKlBr/q6fP/ao3C4xjcli5PHpQYTqvS6AINlO3urtq+3hskDDmeMTKB0K/E0oWuEtxWL0FlaEAj06Xi8rdRsq34UfC/4Z9JacQw1RlhSYxzUJGedZEAqfcHoxekOFmIhG59mSenYrtr81ykxzPuk4IzMc/DO2v6TNtPqyhb8t4wES9kfGlZ8Co8mXgT1jQrmWLhCD5T2jtbicHEZlqwL8kzNUmYzpea2huOQfeMUwHvaX4Qnwoq8XTB/S9B58blkvz2FE1MgwfkP5rZX2fLnMWTNU47nJxM/fcfqt0dOQointUkcLb9LaBsRmQg/EpIx0nErcMj6YHTd5XU8Wpoc5Y3pyN5MqhNTl5cU080EvkepWhFed5g++FD1/2LVJvvbN6YuESXxg86ozXfs3JUy25tRhwjuMFsjFdgMjzokjzNCAeRbcRBuCuOmFCnz71/7wczLGkFHFC6HyXbLa56Hk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f85cd83c-5e74-4e64-cc03-08dc7ba4c860
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 03:51:24.8997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1JaJm9vG8cGHNi+okxwYnvmgISu4j3TS0d5YsSdbYDjH1zFSmYyRExPaFTeHq59bME8SQPE9pqY2XQfThZ5ZHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7048
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-23_15,2024-05-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405240025
X-Proofpoint-GUID: j7wh5iUrTdxUmNnWy8e9XNmQQWTKna3C
X-Proofpoint-ORIG-GUID: j7wh5iUrTdxUmNnWy8e9XNmQQWTKna3C

On 5/8/24 04:08, Josef Bacik wrote:
> I have a btrfs config where I specifically exclude raid56 testing, and
> this resulted in btrfs/011 failing with an inconsistent file system.
> This happens because the last test we run does a btrfs device replace of
> the $SCRATCH_DEV, leaving it with no valid file system.  We then skip
> the remaining profiles and exit, but then we go to check the device on
> $SCRATCH_DEV and it fails because there is no file system.
> 
> Fix this to re-make the scratch device if we skip any of the raid
> profiles.  This only happens in the case of some idiot user configuring
> their testing in a special way, in normal runs of this test we'll never
> re-make the fs.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Applied.

Thanks, Anand

> ---
>   tests/btrfs/011 | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/tests/btrfs/011 b/tests/btrfs/011
> index d8b5a978..b8c14f3b 100755
> --- a/tests/btrfs/011
> +++ b/tests/btrfs/011
> @@ -257,6 +257,12 @@ for t in "-m single -d single:1 no 64" \
>   	workout_option=${t#*:}
>   	if [[ "${_btrfs_profile_configs[@]}" =~ "${mkfs_option/ -M}"( |$) ]]; then
>   		workout "$mkfs_option" $workout_option
> +	else
> +		# If we have limited the profile configs we could leave
> +		# $SCRATCH_DEV in an inconsistent state (because it was
> +		# replaced), so mkfs the scratch device to make sure we don't
> +		# trip the fs check at the end.
> +		_scratch_mkfs > /dev/null 2>&1
>   	fi
>   done
>   


