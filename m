Return-Path: <linux-btrfs+bounces-12641-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 229D0A7429D
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Mar 2025 03:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFD051887B9A
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Mar 2025 02:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F82D20E01D;
	Fri, 28 Mar 2025 02:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JL64KrRL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iXjFCVjU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE44414A82;
	Fri, 28 Mar 2025 02:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743130424; cv=fail; b=SIOxp0ed0gV7uq/8owG5L4HIBBOuDSkpbL6tX+QlVAZyxIBdTtEFhW/8jeW0qw9lvQf+e4AUDlubFD72YOd8SBeVjnEixI95iectekyO9pg13z9QsqfUUCZRb/PCP/znYZ1r5otXp8nXGW82bCEVdUjqsbh2ChtVkwTfGIVqWaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743130424; c=relaxed/simple;
	bh=JuH4dfAfxlrAkLOYvVw7k0oLWIRj/XpTdBnxHDFFYLA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YNWos5eBUElxiT4rYJhJPbB9pKygs1EVivTUjOkzTYl7RmQGF4Zh5oS2ODBFnf6xWN/LL1pI7P/+Sag2oenV0LNdZmtY2tr14z3LS15KkaSbOugvM5NCjjtMdi9uurah6tuH7zUP3ExLfQIEgpoMbVwL2twmbsKnKOIY6kCYva0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JL64KrRL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iXjFCVjU; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52S0vVfH018802;
	Fri, 28 Mar 2025 02:53:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=8varVT982wNIZEVtbVWujv90J6k8yZKJdCqYpDJRx6A=; b=
	JL64KrRL18waV+xz7a79Ilh4ssfH0kQPbIww64LprFemo3CRekd16HkED4bR/0iy
	dk2vy4quda7HnL3oJmCRCWU/27iH31h6ZQltZBty5lL+pgz3tZkargCaLnl5N7Ui
	FQh2ozt/lPesAK8LbmHYSN1H0PK+1vGvBusO8+uO1JSxbZK7VSmrK0bJCRoLd8KI
	TuCdEBU187M3bOQ4D3F2LumQo4sUjrEVm0CDkenZS3xh7W6/q+XQ8qgcb7YyrZAu
	WMA6c6iTnryqCY7N5XKpZbnDR7yV1/2v7gGjKbWfyH6qEpHOfstGujyF0J5ylOyE
	i/YCzarKANAl81gaEaJ8Vg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45hn5me1cf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Mar 2025 02:53:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52S1X3vU015177;
	Fri, 28 Mar 2025 02:53:38 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2043.outbound.protection.outlook.com [104.47.56.43])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45jj95qhbt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Mar 2025 02:53:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sG8UF+QMx9tUSo/1vVAnQxmzgNCGCG/NQqfN2QYRvyl6CLgQ16GY8capUNJtE84yjKJuxw+yk9fSxDUpQ8oBeqXLv2xR8RHPp96CIm1dPg3F2bFOkIWY38SMUsLfm5j049KRZtY/cZR76PlU2yeO2JLOAcfZgjDbzm1QGo76C+qVT7Nj5zNB3ONedaF+srIJwl1eNsuXjC+TJzleVK4/Gr8wbGR3M+kZD9oFvHIk1q/E/Jm6sMpqgPI1o80i7IV/5bI4qzn6/rGSyQM6WTq4yKrQCix1jdKY0dDSf5085Rhq05EhQD6T8t4U8RwU0mEge361ZjEGhCzD86Crl0AA7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8varVT982wNIZEVtbVWujv90J6k8yZKJdCqYpDJRx6A=;
 b=KRgPBGiChB9woymy1EU1j3tExtbbkjktftc6R0W/N0hzf0hLTHY3DGILrYIHPTL8YG3i3N8Dodrj7ZFis2wJiQA3G0mssCBtEzxHQIobo+r06SuNLCG+aW4FGJ1jXCUWf3d+VPek5rUhEgL7VrJ+7Vk1fGDFgaaMkB/FScsPKQToaFKSDChyWf9bz3v7AyhI2y5xMVyB9T/1mjHyXzaeXR6W+WUuq/AYUaCt5sce7k6SmTV0Bn+FTWBAOXAD/zPxnRVRaJdubhOUXsLfBgdvaJbcCKGcIKHfT74jOBMGakeygrYJNjZPKL0LAinVQG+ebi5cZhAvhMbJnrwoZLBQ8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8varVT982wNIZEVtbVWujv90J6k8yZKJdCqYpDJRx6A=;
 b=iXjFCVjUzXYbL4g5T0CEQzh8bh9k2RLrzXGUMrPEhZoCQJSA8yk+imm2XXxce8CT5V9gbCfCnyAJ7b4VMlkFvCQwzegxCnfBfJoMUEO+ebg91faObWMRqQCyQ7zbzUmvWHKTAlKMmPyONNYWGNC+xJ/G46M8lpvYVf3J8zS+EhM=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH3PR10MB7257.namprd10.prod.outlook.com (2603:10b6:610:128::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.27; Fri, 28 Mar
 2025 02:53:36 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 02:53:35 +0000
Message-ID: <437f8a3b-fbdc-4345-81ef-32e99aa40dac@oracle.com>
Date: Fri, 28 Mar 2025 10:53:32 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] fstests: btrfs changes for for-next staged-20250328
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20250328012637.23744-1-anand.jain@oracle.com>
 <20250328020312.psokbxpz5untmeey@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20250328020312.psokbxpz5untmeey@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0109.apcprd02.prod.outlook.com
 (2603:1096:4:92::25) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH3PR10MB7257:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c1ee53e-9fc9-4bf0-985f-08dd6da3bbd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dkhJZ015V3ozZWc4MExPdWtRNVlENjBodzROMDBTNHFIcGY5RU1GbktQK09K?=
 =?utf-8?B?OEw2Z2JxejM3K1VXWjh3Tk1sZlVabStqc0RIbzNzdUhKL1RNd3Jpa09ubmRs?=
 =?utf-8?B?dXM2ZjYrUThlOVJOaUtqcDR1bEVZYWdHUmpnTFR6d0Fib0tFS01JS3ZOZERu?=
 =?utf-8?B?bFFJYXBLR3FqaEd3ZEw3SVVNWk9DYnFDck9oQmRvbEFxY3JXZThWcWxJQ2tT?=
 =?utf-8?B?dUxKWHBqVGZzVjNJQmk4dnl1L0tkVE5mK3QzZFY2aWNsYVpJWHNGZjhKM29L?=
 =?utf-8?B?SHJrS0QzczU4b053ek9RRkxydlF6OGl3elRIVXpYYmk4anUrQlRTbTJNck9C?=
 =?utf-8?B?Ulp3MDVaUERYNXA1amZDNkxuWnZrZWx1VUlLRjRyeWhDL0tVME9kYW9iUnZZ?=
 =?utf-8?B?ZFdTV0RPUVJRUWdvK0ZTUWloUmVTcU95bGVkTW5xcG9nZnRaMGZVbVlZQU5o?=
 =?utf-8?B?V1JINVRmVExTYUZ3S0YzMHFGSWJ4VW00QlFNZGREUkZSQlM2Rm5sMlBTRkFC?=
 =?utf-8?B?ajA0cDlRRHBXWlpkNU1CTVdFdzQvcmNyUXJPRzY5blB3QmI5aTg2d20wcFNQ?=
 =?utf-8?B?Y3l3azJnU2JhRUw1U2ZOOVBzc1VLNFdIWUNzRG1lV3cyRlpHa0pINXVjMVM2?=
 =?utf-8?B?a2NpU3RQbXRrYzNNT2l0YmVlcG1qbXB0VXlGZlhJK2hlY0NRYnAvNytiSnFS?=
 =?utf-8?B?Y2NKdUdMSWowTjhQSE93TTkvWTNyRE9SU0Y5WklRSGxpZ3NwZEkxck5BS1Np?=
 =?utf-8?B?c2ZVaXhYTVVacHBSSnRFYUdtK253WWo0L01KcnUvbEYxU0ZHeTg3NWZVNlI4?=
 =?utf-8?B?RkFnV2ZZdlpqdjhPZC9zZWh2MW8rZWJyTVZEZ1U3c0ZwMThJMEcyOXg0RldI?=
 =?utf-8?B?elNCQ1ZiUEplTXlJa1VRZGNDSFozc0dvL2pPV011dGVTV2lyNDVqMUFwNEJR?=
 =?utf-8?B?ZnRnWnd1TE1qVFdkWXRhU2pTNkYrNVNXZnlCUThCR0IvNko0ZTdoM2J1MTZz?=
 =?utf-8?B?eWpmMVYyamh1UW96NjQyVTlCT3JwN3FmSmdQNU0wZU02TDMxck85YjBHNW9N?=
 =?utf-8?B?RXhKeEdIcjVnalR0RFd2TUtTZlRSMVd2Nm1MNHJoeXdWQU01dEFTMmxWWHJQ?=
 =?utf-8?B?dklaYTNtbkxlRFZTTzJtWko3L21KN3pJT3daaHdYWmlRZHNwcDN6YkxVVEMz?=
 =?utf-8?B?YzI2N2doVTJCUWJCWU5KL2N0NjdTQVI4VG1ib2lFYjlVOCtOZ2R2cS9HT1hr?=
 =?utf-8?B?U3hOaGRoNWxWWElvVXFlMEMyd0kwR0tORE9EVlRLR0ZRM1l3MEdHcjJveXVq?=
 =?utf-8?B?UVFsOWdvM3lwRlNhSzVsbTZGTk4rQ0RPUUt6VElUOWl2Y0U3eTNSYVVWNCsv?=
 =?utf-8?B?WG9OWDROR3lCQU5lV0tKRC9JWktidnlKTGNHQnZ1ZFgxNmNFR1hRbFFBbjhV?=
 =?utf-8?B?SUJVMHF5cG82Zk1hVEtiRDJHQXQ5SHFPTmdiNldlYk9GMStiQVpub0l6Snlq?=
 =?utf-8?B?dktheml3MWJSelU3cXdBTjF6YXNyQXNXTm5SNm5saUVZY3dHTnhxVk1rQlly?=
 =?utf-8?B?ZEsycWZTdXMrc2VZMmFHVGZSWERtdjI3cmdLOWpUQ1c0ZDJtYk5PZ0FtQmc4?=
 =?utf-8?B?ZkxsdThjRjNDcG9JOWF1dWlEcmlCbFlFWXBWNUhSVTlhdC9uS3Fuc3lFbVgw?=
 =?utf-8?B?ckpJZFJrWkRqYTVJRXhVYWFmWk1XL3NJcXl2WnN6amFLaXFObk52QitCMTJU?=
 =?utf-8?B?VEFQRXBQSjI0U0RCeWhsa3V4UjRRMzRVZTFPVk51dEw4Y3hDeDlJQytTcUxy?=
 =?utf-8?B?RkRaaVQxUmRPRFA2RTVzRmExaXVHZmxpVENxbXdwdmxlblBlTGphS2lpdFNu?=
 =?utf-8?Q?Yuhu7OtlbXt6m?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bEk3WWlpMkpDWHkvWGVBY1lZMmJubFh5VHpNdTh5QVZsaG5HbHhqcFVCUmVj?=
 =?utf-8?B?Y3VXc3E1NXUzUk55MFczT1pOMGs4R3FId0FzNldEN0RsbTJib01icytSbCtW?=
 =?utf-8?B?VzJYT2x6bmNscWpleXM1MHFZTm5EbkR5cUJaSXhMb3lNNkw0SVRIaS9BSDN4?=
 =?utf-8?B?NURWU1lVU1dxaHhEUS9DZjQxNzFwNDVOWmVIMVp3Z2M4VUQ5bGJpdlBtWTJH?=
 =?utf-8?B?S2VhcnZxT0lwOEdyQzJ6aEpJNURWOFRoR0xaY2lhczAxRG5JcmY5OTRKWUhI?=
 =?utf-8?B?Y1E3RERlZ2JNMWs5d2tRYU1BdzNmeGEzUDB0d1NpWm9NdFNyNVc3aU1LSWdz?=
 =?utf-8?B?ZVpUeEFYR0JocGdXSS85a2FLQW4ydlljRXpneUp0Nkx0UUM1dGRKOHQrc0RI?=
 =?utf-8?B?N2NHZEcxSHMxd2IrNFFLVnZSZFFNcGxVMmNZNCsvNklQaFRQMFZxUXRlN2I1?=
 =?utf-8?B?cWJkQ1UxZm90Ymg0M1BtRjlFb0d2V1FpcEJjSG44dm1HMGNrUWozTGFQWkNy?=
 =?utf-8?B?ME1tQ1VJb0k1OG11TE03RStpRVA3MUdOMlc4Q2VXUlhndm1RNzFhYUh6eWgy?=
 =?utf-8?B?UitrVkwwMUVrVFVKTGRSa1hKbFBjYUpGdHZEUFVKNmFlWEorTlFhUEFFZytG?=
 =?utf-8?B?WENvVXRrWXJMTWhUajdoMkk2S3VjTk1MTHU3cnNRSks5NUs1OTJhTU5laTM1?=
 =?utf-8?B?N1ZqcWRiUHkrbXNXQTRucnhQZmhaUXQzQWRQdEx3MDJVcTR5TWdBeW5lelp6?=
 =?utf-8?B?SVJlSjdGaE5BRUdmRDYrNjhWaUpLQXp6L3Z0WmV6Uzlxb3VDT3JNYWhvcUtM?=
 =?utf-8?B?a055Ym1jR09yWjYzcTl0S0FhWkgvb01lSTZZejN3VnpqVmNRemZNQ3BOeTlB?=
 =?utf-8?B?K2VhaWZmblA1ejNnNU9CTUdTMzhkd2tCVGlFTGtBTmlLSWZrUFJxT2JPRmpY?=
 =?utf-8?B?aFIwbmJMNEJqU3BQQURCYTdiVGRCd0VxRWZxc01QTXUwMU1ZOFNJSStmQzVC?=
 =?utf-8?B?Z0pXUFdmYytydVhTM3hGemh0R2xhc0NPb2kxbzdmbnNTYm4zSTNFcnlYeXN1?=
 =?utf-8?B?YXlQb056V1NoVDEvTUJRZ2VlM09hc1ZCNm4yL0g0cmRvZVZtREJzMlF5OU11?=
 =?utf-8?B?dzJZWXBuWWNLQW0vK0tQZStuYlFRdnlTK3FpWVlXWHhaamhjQi9DRVZQU0hx?=
 =?utf-8?B?d3BzTHc2aUlzTXJucUJya1Q0eWdiZThOR3crUExZVWU3aWNiZy8yaWxQMnhQ?=
 =?utf-8?B?d0VHZWFyRjBnazlSZkxOck9HU2RCSGROTUdEbHdsQmZtT0IwZDRja3p2bzV4?=
 =?utf-8?B?Ym1PcDZSVmZ2dDFwMXRPNFJQcnB6ZndRZC8yanBxa2lqNzZUSHYyZ3dXU3Er?=
 =?utf-8?B?ZmlzeWhEQXRpWFloZ1RoZ1NqbXhubXNoQWliLzh1cXQrUkE3dkhOUGpha284?=
 =?utf-8?B?NHhtdkJzeC9GUndyQzhYNkRSSWl1bk90YW54OUU3OXZNcCtoK1hYaEZaeFEw?=
 =?utf-8?B?TDRaVzJXVmZDeEtIZ0poOUpsMThzWjdKUXdmandFc3plOGdtR05nZkRvMTN5?=
 =?utf-8?B?RlltWWNYZ050bjhydkVEUWVKZ25JR2RiTERJL0tieTBHZHJjMTN4R255UnRV?=
 =?utf-8?B?dmpYQ3dCQWdpbWpjNVF0cXFkY2doT2wxL3pIcmZiaEdJVlVPTVkzcC9rejBn?=
 =?utf-8?B?QWtzSnZaZlVsS01nengrcGI3N3ltUXJabFVFOVhaemRCd3ZJd29ZWUxrYVlT?=
 =?utf-8?B?K1BYaTRTNzZUeFlCUnZ6anhhTkpLaDBZQ3JGWitPUTdxRXhiNFlpY0I0N2dU?=
 =?utf-8?B?MlRwbnJJYUF0cXM0cWFYOEZHMlp2b3pGeU03TzlWVVpKSXV1TlkvL0RVUTMv?=
 =?utf-8?B?UEFoZG5QdmpKWEtBbUhOWkRxdlZweFBWN1JQbmczWXlLMWh2VEsrN0dlcXQy?=
 =?utf-8?B?VEJURStKa0VlVkx5aGZnNGlIUHIzR0lhZy8xZFpvaFVsY2tFZmZnaVJnd2t3?=
 =?utf-8?B?dXByTVgwSm1EZjlEY2gyN0NwbjE3ODFjeDdQcnZjYUxxWktsdG1PQVVxR3Mx?=
 =?utf-8?B?cldONXFCVWtOVGQwNnptdnFvUTZHcUtFeXlqR2svQWZyb0JlZFlIcVEyVzBD?=
 =?utf-8?Q?BaAsJVsnN8FHSMrHgJcuv8nqK?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kduy2UjxrLTkNYWeSKNe7V7G5oEsudYX5AaKAQ3SFyvOoP3C0H9n+O5nI79W8JolgR8mm2bayYzyoS4Qnvco/llqCS8R2IkJwBsIPY1eumvxhgp7G6vwv8HfKTuvEBVt0yoEP9UZEYdBCe1ZKNalTxoeBnxA1WbZId5NBH5SY7esDCm+CiyvF9XZC0xIYhkfKDU8hOvHqUaYs4YGDa0VLSkWVFfmNd9L/S7lg9m76QI8LKItayH9Tc4z44MPYWQly1z8RWn1D5uiQuTf7nMLhhdI8qZYF+XqOQ/2I+JYjP4Ij7/AoeKOygBItcpKr6EZlRC9stbJ35qxwxbbUKruZ2ewBb5ehorwa+RLCKDezDQB3qZbif9VFgMg8lw7pYesCnE+kaZzuv4myWEcSvlhWT/OEn/gCyRjX+XHHtR/FymUKGPuSMQdrWD5hRZ0e7lmrB+3BwdALlbysA5DGTKAuTDdxRpzfebFH3do1AcZJgK0uogFnRo1G08LiUgV3mcpp4LNPjCf8QDo6/eUI9q3D9ZVtFVjdbEs4VhHabPILWPd/KMBgwLlwWwbnVKnSFnANr0NKx43RY/90AR+NTdEdrgMXsdSq49UYOQKMUh8Y3Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c1ee53e-9fc9-4bf0-985f-08dd6da3bbd6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 02:53:35.8612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JFGx+2hJSSJdff859eDaxdAak9hvCIzqUkiEwkb0EIzCav66uTvGmrL0JvEw90Y2uxS9UrirXD8TeoNQNLO+Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7257
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-28_01,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503280018
X-Proofpoint-GUID: 5U85t_b48tFod8B8f3rWUyEt4niCqAiJ
X-Proofpoint-ORIG-GUID: 5U85t_b48tFod8B8f3rWUyEt4niCqAiJ



On 28/3/25 10:03, Zorro Lang wrote:
> On Fri, Mar 28, 2025 at 09:26:24AM +0800, Anand Jain wrote:
>> Zorro,
>>
>> Please pull this branch, which includes test cases for sysfs syntax
>> verification of btrfs read policy and chunk size. v4 has been on the
>> mailing list for a month now, along with fix from Filipe and Zoned
>> testcase from Johannes.
>>
>> Please note that the commit:
>>   "fstests: btrfs: zoned: verify RAID conversion with write pointer mismatch"
>>
>> has the changes discussed with Naohiro, including his review-by tag,
>> (which is missing in your patches-in-queue branch).
>>
>> Test case number for above commit is changed to btrfs/335 following
>> the integration of the sysfs patches.
>>
>> Thank you.
>>
>> The following changes since commit d71157da4ef4cfdbf39e2c4a07f8013633e6bcbe:
>>
>>    common/rc: explicitly test for engine availability in _require_fio (2025-03-17 00:43:12 +0800)
>>
>> are available in the Git repository at:
>>
>>    https://github.com/asj/fstests/tree/staged-20250328
>>
>> for you to fetch changes up to 208a7f874df38bf873137d00634783422965a7ab:
>>
>>    fstests: btrfs: zoned: verify RAID conversion with write pointer mismatch (2025-03-28 08:25:55 +0800)
>>
>> ----------------------------------------------------------------
>> Anand Jain (5):
>>        fstests: common/rc: set_fs_sysfs_attr: redirect errors to stdout
>>        fstests: filter: helper for sysfs error filtering
>>        fstests: common/rc: add sysfs argument verification helpers
>>        fstests: btrfs: testcase for sysfs policy syntax verification
>>        fstests: btrfs: testcase for sysfs chunk_size attribute validation
> 
> Hi Anand, these 5 patches don't have any RVBs or ACKs. Do you miss that?
> Although you can ack patches by yourself, but these patches are from you,
> maintainers would better not push their own patches directly without any
> RVBs. So please let someone review and ack them at first.

Dave Chinner provided comments on the generic patches, leading to v4.

No, there hasn’t been any RB received. V4 has been on the ML for almost 
a month now. Let me try again.

>>
>> Filipe Manana (1):
>>        btrfs/058: fix test to actually have an open tmpfile during the send operation
>>
>> Johannes Thumshirn (1):
>>        fstests: btrfs: zoned: verify RAID conversion with write pointer mismatch
> 
> I'm going to merge these two patches to the release of this week, and give them
> regression test at first.
> 

Thanks!.
Anand


> Thanks,
> Zorro
> 
>>
>>   common/filter       |   9 ++++
>>   common/rc           |   3 +-
>>   common/sysfs        | 142 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   tests/btrfs/058     |  28 +++++++++--
>>   tests/btrfs/329     |  19 +++++++
>>   tests/btrfs/329.out |  19 +++++++
>>   tests/btrfs/334     |  19 +++++++
>>   tests/btrfs/334.out |  14 ++++++
>>   tests/btrfs/335     |  62 +++++++++++++++++++++++
>>   tests/btrfs/335.out |   7 +++
>>   10 files changed, 317 insertions(+), 5 deletions(-)
>>   create mode 100644 common/sysfs
>>   create mode 100755 tests/btrfs/329
>>   create mode 100644 tests/btrfs/329.out
>>   create mode 100755 tests/btrfs/334
>>   create mode 100644 tests/btrfs/334.out
>>   create mode 100755 tests/btrfs/335
>>   create mode 100644 tests/btrfs/335.out
>>
> 


