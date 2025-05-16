Return-Path: <linux-btrfs+bounces-14076-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB48FAB95CD
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 May 2025 08:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C00C47A855E
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 May 2025 06:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E582222A0;
	Fri, 16 May 2025 06:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qrRJJwW3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bBcAJmT0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BCB13790B
	for <linux-btrfs@vger.kernel.org>; Fri, 16 May 2025 06:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747375669; cv=fail; b=qqjwP6qwyBT7MknzSwU5nfhlzhsHBoO58R9W50nkdzcIubTUgiL4N1rNgxN/u2Or8jdfc/MSenv29HwCypo7IJNdwt2qyYBzi+2Wla8vm3j4UtbptmxOIXTo21G1o5R9GUHql5ll2zJkH1r9SjH2nrGDzp6WRDeLKIn7AzpdIEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747375669; c=relaxed/simple;
	bh=7t2IkiIw2UN4Kx5jrLPAyWgAsJrozwA7dooNFGhbH8I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Hm7g+pwetYAjE/vjfHt6Xqx3cz6JtqQYpthVqPtpRxv66Eu/VxiobBpZE9ZpkU7tAkq7tLiMG0YaG7cWzN58fvEFiN2yP6u4gjb+atJ9KE96c4X/RyXBxNEtO9OILYRDrC5YVMZBUYPo2lXNnhHBnC+RA+g02VgKV+MuLLbuupQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qrRJJwW3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bBcAJmT0; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FLgQsL006870;
	Fri, 16 May 2025 06:07:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=36WHfvOSlpuHrsYr55v2097yJBIsdP4R/2n+uU8wJEU=; b=
	qrRJJwW3cYyFCKRuW28rSem/cdYIqcJ0D6RcbEWYmSNDXB7/MHSzrK7YZsnNxwcV
	wrmyY/PQxOfH5wiukjRFY6kYlcv0uWt1x9eYydxFykqyBioxwFgSdAegSyaxe7Za
	r9s3SWCiGf2NgvWTx02FEJ7ObrXAX2UwBxfnrZSxx1RBmotw23dYJRqEpasJ7oTP
	c0EUY/xOfHEC1KlMJCnXZWNC5DMGR/oi8rrlkyHTTyIebpC0CcwqjNrTP7gCS7cK
	z1xHsX5wIGnpUPuZYNb+37/YPLp0XJtVUmRmJX5+QcnbmG014WcIOx1ilVDTIYH3
	xAJor9JaqQCipZKYJxH4mw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46nre00q4p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 May 2025 06:07:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54G5F077016253;
	Fri, 16 May 2025 06:07:36 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46mc35q8fa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 May 2025 06:07:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QYiAfoMCSFnHkvGBzTwCM81T9FBR8Fqvb49oWt6+bXoKFjSE5XMMGUTtQDZBbgx58X6NBBdKhYVV+DSlc6A1f+DlWQpC7Gd/gxoolAD36z/M9Cu16ZqyiIgnqpJjoLkYpgs0WjCKxgDn5q40LwNW3swxRRFH318lr+XUOXWWdE9MB4YBjr/b7XK4DV/MXso0tGF/ZETNEPG9745THC5sTvjeBvGVLbA4MTXocttSPmn4Mzjdc/pGWyxB3ZvzcOXmU4tXU3kT+X2a17XZChrysOH/MGq3y4X9TNdY2T0sba6q67QgPqLF7PpXtccGYW0pda34kp4Iabxv8zN4zS090A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=36WHfvOSlpuHrsYr55v2097yJBIsdP4R/2n+uU8wJEU=;
 b=A7iRuCYJMne9GTTKSlJzrDmSzd/L5eNTGUcPnv6oYdCoy8wkBMJT2kunQJ1DRFrUKRzm/h8+O2XM894EIimOZZtcLOh8WMhcf//L+RF9bNQQwRE+7oXd/xxOwNZN/REsjWxHpMfIw46L3zS9N+hoacVjUysX+QfrzWStQang9YicsodwrRGSYugI3YgNrv/0hZrmnU3v4PIK3zXZ16GBAva0myV2VPBL0bIa6TNxH7todl/J6aw76StS6V5R77YaBlDwR8i76B5GkXxeqkLQC+rBgFXs7lk/aquIvqde00TbAqgWHY+N7g2YiLeByq/hPkowyLZpwBQ4ULHynOhBfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=36WHfvOSlpuHrsYr55v2097yJBIsdP4R/2n+uU8wJEU=;
 b=bBcAJmT0oBv0UuL1/Rw2G1MI5W6EB3EdfyavewU0LTmjJMO7A7bczsdY7kqLdsgFHnss+Bf/4B9QZO6/hVHvBXm8hxTpeIKHn1bnqsGkYSouYN5u5WvqSSnj1keqvLHq82B2Gv8WAd86ZIJtd25jz2bP6APly7pV+MQz8GeUUNU=
Received: from IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
 by LV3PR10MB8084.namprd10.prod.outlook.com (2603:10b6:408:282::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Fri, 16 May
 2025 06:07:28 +0000
Received: from IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5]) by IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5%4]) with mapi id 15.20.8722.031; Fri, 16 May 2025
 06:07:28 +0000
Message-ID: <bb54583e-3017-4636-b31f-f50fc847294a@oracle.com>
Date: Fri, 16 May 2025 14:07:22 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: add prefix for the scrub error message
To: dsterba@suse.com
Cc: wqu@suse.com, linux-btrfs@vger.kernel.org,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
References: <7cb4279a93d2a3c244e18db8e5c778795f24c884.1747187092.git.anand.jain@oracle.com>
 <adb7e0b9365da95d9497c4cde18233f3e52e41df.1747364822.git.anand.jain@oracle.com>
 <96747079-c47b-4df6-8200-90ba91220c20@gmx.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <96747079-c47b-4df6-8200-90ba91220c20@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:4:194::18) To IA4PR10MB8710.namprd10.prod.outlook.com
 (2603:10b6:208:569::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8710:EE_|LV3PR10MB8084:EE_
X-MS-Office365-Filtering-Correlation-Id: 135f2d44-049b-40ae-a2c3-08dd943fefb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dWRtU0lNeUxQWktNTzIxTXlqUGhGVEtPUThKdEZicnQwM2dtUm93Q3dNeWJw?=
 =?utf-8?B?YWFDUHY2SEhYVGxBMUZQS2dnTjNNcXdtd0l6VmVvS2lpQnk1T1ZBLzV4d21y?=
 =?utf-8?B?bWpuUVM3VFNLeFNGZlBlcS9UNW05L2ZNRytVaSs1aGRnYzBKNllTZzQvaE9U?=
 =?utf-8?B?MmI5M2t5RVhkaXdzcm9aczJjMXNHZ1VxbXM3UWx3UDBEek1YbEFkNlBxY2xU?=
 =?utf-8?B?d1NxOXhaRFROdUhBWXNHTVhjSERKdWJiSGRwclFtcDB4RzZCTUNhMjFySHlO?=
 =?utf-8?B?Q291NnVjM1pCK0ZVS2NzcWtRZ0Y5eG5EdiszUWFTUit6L0h6VTZ3TE5CRUl2?=
 =?utf-8?B?ZWxoMEoxNVI4T2Izb0NMeGhwTTRMNmJ0U042UmNKaThaUHdBWjJnRG1nVmZJ?=
 =?utf-8?B?cm84U0RXVzhVNWtxQkluek1UMlVWSVA1NE9VVis1Qy8yMk5wRGhFMGw5RzFX?=
 =?utf-8?B?ekR5R2UrakduY3c1NEhhOUwxZVpRbmFuZGo0ZXR6VEtPK013UkxiNjY3cXJy?=
 =?utf-8?B?Zi8wYnl6cmltZkJJY3JEYXZZUlNZQVZ4aytZcWxoZ21lQStPZkxiR29CSkxv?=
 =?utf-8?B?ZVFyT1ZaenhUcWhYTEV6eDFCZnF1WHYyajhiM2FadmZQOWZCc1VRcnVFVDVZ?=
 =?utf-8?B?dm9RYThxWDFHR2Z4YUhHUUtxNkMwbUFNejVhUXYycmpwTFlsWWFzUmgrZW5G?=
 =?utf-8?B?QTB6SGZxWEZTeXRSTkdrZ2J4SGNwUStBWS9SN2JqMWprdVZTT1dPQ2I5Mmtk?=
 =?utf-8?B?ZTlKN0VtZ2YyVkdQZ0VMc1Z0ZnFjTnF6M0V6QTZxWjhaYVZVcm9ERyswNHc5?=
 =?utf-8?B?QVE0VU5NYzJKZGxTM2dEM0JQbWt2cnloam1wZXZZSGlzQnhuUnJOYUc3anJn?=
 =?utf-8?B?dHVQTjZaaDFxVE5wcnN2VHk5MVBJa2FlQkJ4ZmVjalVrdHJLQUU2M0V2UmNL?=
 =?utf-8?B?eHZxUDdpeVV5QWdWdklCRFFFSUxmemFuaXBubk1uMkh0cGdWVG5DQzA5bnNq?=
 =?utf-8?B?bHNZWTg4bEFwYTRYbk1PTUFoT2Q1bDBFMXRBaktBK3ltVVpiZjFuMEJVdTRj?=
 =?utf-8?B?dHlPKy91RW56cEswS3R4b3VEU3Q3N3l6L1JHYmdhdEV0eC9LaHFVaG9xd2lw?=
 =?utf-8?B?Z0FwWjkrY3VmR2lYK3JJSFEwVWIxRER0UXJ4cHVIYy9OUEtERHdod1ZFUS9M?=
 =?utf-8?B?ZTZOYmYwZWhJMW0zak1KbFV1Rllibm5Zc3BXL2xIRUhYQm43QUpsbkpEaXd5?=
 =?utf-8?B?WHF6OTMrWGRRcXhWdjFaK2lxVHFPaTAxUUt6S0V2VGlZYzNpT1BudzZENlBY?=
 =?utf-8?B?TGhwTXgzMEYvVDNFWmR2cUVCdDNoakNRNGxXaXVlYjF1NlhGb2wwUXg0RDhY?=
 =?utf-8?B?bzZBV2tZTkJydU5OWGlYUExxU0drOVQrQTJTaHJRYkltSWt4SHV4Nmw1bFBD?=
 =?utf-8?B?SFNqUFJKNHFjY0E1VDZPaGRCYlZQRWpjMDZubjgxQ0tyZUN5Vy9yNTNwdU5H?=
 =?utf-8?B?a09mRitKLzB3bWRGRGdMYmxpTzRTZzBaU042UXRBZjVGcUY4bGFtZEVneEt6?=
 =?utf-8?B?TWJhYkpVTldVMjc2TWl1VStLdWpYRmdDV2t1VkdlOEgvU3BCaXNtSlpHVkZZ?=
 =?utf-8?B?QW9qL1JFbWI0V0tMeUtLdnY2V21MTXVoOU5sanJCdkdIdksxQmtOK2VEeHVr?=
 =?utf-8?B?SFFXYWEvRlc0LzkxeEMyRlRmQ2pwY1gwZ1ltYUxmRUNxdGQwRE1jazBMNmZL?=
 =?utf-8?B?b1IrS1RuT052bjJIU1J1MjdEQ29vMzJsekJleGxSU3RDWHRYYXlEdkF1M3ox?=
 =?utf-8?B?NVRXZVI0TVFNcjFQSFNUdE9LL0p3M2YwSUl5Z3hDM3dHQkdMb3MyNGtYd25a?=
 =?utf-8?B?NWQ4aFIyckNvcnpPb0IzWVNHbGViNUVrYlRjVUtnVThXeWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8710.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mk9oNHBaUHJDdDVGZE9DV3FqK1ZvY1R4VG9GWHpCd2lQUEtJQnIwK2d1S09Q?=
 =?utf-8?B?ZlVpbjR5MXQvK2k4VmlJTkF1cEd4czR3Sm1IdGZOVzU1UjJrakJUYUUwTy9E?=
 =?utf-8?B?b1kxZ242bjZXYXM4aUV3YklOc3BRUDJkcmEwaFEzRWFnTitlYXFLejZ6dU5Q?=
 =?utf-8?B?eDRKMkJLUit0bkExY0tqaGhCeGsvTzl1TWorTVlQREc3K25qRm1DNW5MSE85?=
 =?utf-8?B?K1p2UDR5ZzgrMmwvYXNUVGRwMmlUQUkvQUhZT3RkemNkblFQWSsxNjdwbEI2?=
 =?utf-8?B?dlg1SGU2MmRSNXRDRWJ4djA2dGVqc3h0Rm1VQTBtbElLU1IyWkgvSlR0SjQ0?=
 =?utf-8?B?YmZjbFpkbW54UDdJY3NLZENBcFNWNkRMUS92a09Bd3ByS0czQXhqbmplVUZ2?=
 =?utf-8?B?aFJNSDlub1NxOU5zdDgwcWNwN1V6VVNvbWUvejYxcFJ1Yk9EK28xU2tTODZ2?=
 =?utf-8?B?V3IzNWVieGxzSVE2VGJCNFp1c20rRVZxb04xbG1tNlZOQ2ZwV2treWcrZGc5?=
 =?utf-8?B?aW4yMlRRTit6L1MzZFlpck1WVTVaQnJJWXF0amNSelp3dmVGRTIyTjZBb1Fj?=
 =?utf-8?B?Q29MOXVsbGhSdU9XZWlEckhZVkZlWURyREtCaWdSb0tvMGpTR251bGprY2FD?=
 =?utf-8?B?d0ZWcDkyaDVOQkszcnBub2ZMVDBGRlU4Y2JiM1hCeWhRek5EREtxY3dnNkhT?=
 =?utf-8?B?WFV1TDk1dEVjemlRWTZWa08ySmRVbVpGUDB3RTZUbjVVN0lCWDBGK083K3pa?=
 =?utf-8?B?MWEzV3R4emY4ZDFheTQwKytaZDUwU2dHYko2bVJCeUF4MlNaakhMMW45NEV6?=
 =?utf-8?B?NGFzZTZBRE9LVDAyVUQvWmZuWjZXaXhUTHVRaUVubXpYTFZ4M0h4WmF2bytP?=
 =?utf-8?B?UWJHb1lUSzdLTjQ4dkxtRmhLZFVFRHM4LzlBNnB0NGppNEUyQ0VWVUhqYjFm?=
 =?utf-8?B?c0RMV2ZvblMxY1pYempwUThNczRQdElWb3FQdDNsYmZHUzc0T1JNNmh2aGhh?=
 =?utf-8?B?Wm41a21pa3UwZFpyMUpvTjdjL2Zod0x0WENLdHI3ekExeTkxejAyZzBBZmkv?=
 =?utf-8?B?RkQ3MFBFbEloWmdzQ0g3aS9XV0xYV2hmaW1qOWJXNVpQOE9renFrRmtISnlF?=
 =?utf-8?B?NjI4Q1FrOUE3MlYzUmc3TU45SUZSLythRHRKazdhcEt3T2xCUVR6aTFoYkJZ?=
 =?utf-8?B?NkowWDFneFVueTA5L2UrdGdKOURuQXo3c25uWlB5ZTRubVlQSDk2Q0J6NFFt?=
 =?utf-8?B?aThkekZtNGpSUUV1TksxMUoreFB1OWl6b1RXUEUyTGY1RTlOVmJJZTliRDdS?=
 =?utf-8?B?YlAzUGRwcWhUb0RrcGIrWk94THlqQlZyVVBzc2Q1bEQzcEdTUURmdGJyU0w3?=
 =?utf-8?B?REZLcS9wNXY3OXZTOEtPVWNQRkJwNmJuanpPNTE1S29PSGpBV1h3dis0Mlg3?=
 =?utf-8?B?cTZuYkxDMTVkZlhYWkNCaUxTNkdKTU1JSW8wWlJnN3VIeGdpS2pIek1QVGc0?=
 =?utf-8?B?OFEzZWZzTUdhMXlETXh5MjJReHNnYW12dnl2R25DRWlPb1oveVhRYnNTWHQ2?=
 =?utf-8?B?YitPeHFla3J1WTFEUmlTSzExYWFJOWgwbnJiamxKMlhYUEVGc3hWYk05eXdV?=
 =?utf-8?B?cnl5YzdYaElvUGlqUVNuNCtQQUVuMC9kOS8rTy8xNDgrOEhIc2JnUitEd0dx?=
 =?utf-8?B?YkVNc0p5ekpPdVdLVmQ5eS9OZmVKUTBXNjdsNHFlaENydGZEZW9pak1HbjR1?=
 =?utf-8?B?L0VmOEZPclhNVWo0QkQ3N1lQZlVSbEVIVXFTS2RzSkFDNHNpUFczSGRQd2tT?=
 =?utf-8?B?TWpMNG1Rb3Uvd0U2RDB5bm1pKzBlRmdob2tEQk0wbk9FcGhPdGRSMXhjdUFr?=
 =?utf-8?B?NTRDN04vTnNRYjNvMkpaVndMRW9kYWlSSlpiUEcwVkVVaWlENUtRaXg3eS9v?=
 =?utf-8?B?TkpIL3ZZV251aDlpVm5qZWUvS0NWYm1vdmRBYzZIaW02blhJRHUvcUNRTzc1?=
 =?utf-8?B?aFgzcytKaGNVaktjR0VhOHJqem4yUzRpMS9zUm00YTJFQlRaV2Juc2NQd3ZU?=
 =?utf-8?B?ckdOK1RsWExGcktoR1RaUml6TUY2QUJsMVNqTlRPcmVaQXlWbmw3Q3lZMHIv?=
 =?utf-8?Q?RlELz3nexIclJ9ntX5UvSallh?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Y2gsQRSXQ2GA9TxXK7y7iLcEytas/OpBTEVpTGB0XWKFZpHpOcJ3pJgCDwT7iSXcgot2Wxu60WQXeZPyflDNOUNDeRkIti+WSZSSND1xPgo7IPfLzw+01xDsiU+rHi2R156+bZu5Fel2cg8DKOdNBXVSLRNFlcWcTlsM4izGSKQwV74ja1+zZcJj1SnA2xpqZkU/nELQ3iyulaTLwhytqfGvuljYeVMwqYulw1d8VWkIWY0urd4WezBCjBvsE3bjkPJhJl1QNW6doScmJ+J+M91p8nd7HzD6FBHXLZ7SfbFf474BfjSuRQnRbrt8yi5ZlUIajY15CZnwTexqwWuRbOyK9xWbR4Wxqbrsjel4HMAmf3yq6vXLxdkdbjeVuNXXqb12RQUE2MaQS/sKQzugQS83E1Bu0xE7GIKFTvI7+hUGLlZc8I1c11XneQC2N0HXuGBZY9GhduOilFkMcNDfkbSiufbE76oSeLBY9VGHGv4tpZCn+wS2FBJR7i+ux650u2ihRXaEKlIs42jWm0gpPv4ScMJI3YQqfpd3kpMBKVQWjjwax3XCkX4ASkOQg9dZ3y4M4iAk8ByHWgSD9auqPasqJnXix/pk1/1sM2/tb7I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 135f2d44-049b-40ae-a2c3-08dd943fefb2
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8710.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 06:07:28.5447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hf0hdgTijQ+zBqeTHmGuxMfKz/OcGZZ5+akYFEqdFlloEZ1KwEiNff2FjHTKPIFd6kmDvvn9mc1rOivVSbvL0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8084
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_02,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 suspectscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505160055
X-Proofpoint-GUID: NSlD6thzWgfXYxJx3MNaWzZK8pGaVZnQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDA1NiBTYWx0ZWRfX+tuuTkHkooCo dvepj2q/1cP28yfw9Zqs96xMS0rh9vel0qTeKVP3+cpMtDF6sv6kxs3gY7wvGyfU7DHUsbcHZII xWSXckmRyD5jrUE61pf+97FT55wzq/BSRZQ/oSmf5J1NgR2cZkeWayrYNJXiWsml5n6WSXlszdy
 bPkOC/1eIxxwjRNcDJoeINk33RFBOLIGENgSRUDALPH3wSVxNTJW0rkkJTu3uwGlnw2fHGvEeTk ZX4RNECHNCVqqKx0LwUSc1Oqb2NMhfAJH60OnwM4udPgBKhTJlr9oCUa8dHQYvXpDmphgk5vWYo 5Q6hQPBTWC+kxjhIxEbptoyieu+fhQGtmZtitBniv9LKc3HxyvUm+W0AiTGUHOCpp8HtbgwzupJ
 21yoLSXuaeYwnJCc95NeVIp7RYJCP3t+p0ZBnvQtgkmb0/1zMczxbkb/Q2cdB5s3SoiHD8WO
X-Proofpoint-ORIG-GUID: NSlD6thzWgfXYxJx3MNaWzZK8pGaVZnQ
X-Authority-Analysis: v=2.4 cv=O9s5vA9W c=1 sm=1 tr=0 ts=6826d629 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=iox4zFpeAAAA:8 a=daw_LDfcejecEDRRkgoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=WzC6qhA0u3u7Ye7llzcV:22 cc=ntf awl=host:13186



On 16/5/25 12:25, Qu Wenruo wrote:
> 
> 
> 在 2025/5/16 13:27, Anand Jain 写道:
>> Below is the dmesg output for the failing scrub. Since scrub messages are
>> prefixed with "scrub:", please add this to the missing error/warn/info as
>> well. It helps dmesg grep for monitoring and debug.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>> v2:
>>   Fix remaining scrub warn|info|erro missing the "scrub:" prefix (per 
>> David’s review, ty).
>>   Drop rb
>>   Drop Fixes:
>>   Update git commit log
>>
>>   fs/btrfs/ioctl.c |  3 ++-
>>   fs/btrfs/scrub.c | 53 +++++++++++++++++++++++++-----------------------
>>   2 files changed, 30 insertions(+), 26 deletions(-)
>>
>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>> index a498fe524c90..680a5fdf89c3 100644
>> --- a/fs/btrfs/ioctl.c
>> +++ b/fs/btrfs/ioctl.c
>> @@ -3142,7 +3142,8 @@ static long btrfs_ioctl_scrub(struct file *file, 
>> void __user *arg)
>>           return -EPERM;
>>       if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2)) {
>> -        btrfs_err(fs_info, "scrub is not supported on extent tree v2 
>> yet");
>> +        btrfs_err(fs_info,
>> +                 "scrub: scrub not yet supported extent tree v2");
> 
> Duplicated "scrub", please drop one and change the phrase.
> 

I saw that too, but the sentence after 'scrub:' didn't sound correct.
I'm fine either way — could this be fixed at merge? Thanks.


> The remaining looks good to me.
> 
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> 

Thx.
Anand

> Thanks,
> Qu


