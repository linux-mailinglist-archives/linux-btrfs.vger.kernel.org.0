Return-Path: <linux-btrfs+bounces-9251-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 739259B6597
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2024 15:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 968441C2466C
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2024 14:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C861F12F7;
	Wed, 30 Oct 2024 14:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jR/XCicU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Vub1ILLl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61190286A8;
	Wed, 30 Oct 2024 14:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730298053; cv=fail; b=rSiFqcBSoy25/wkfn2VLp7C29jl4m2gfdpi3DXrPXNihLVs78v1DyMYoRKkgomOFL7Ca23ODEhJ18Mcgzx+g4s6kb7zsKHyBltDj1ddR1DpHQod0ZpxLNAAyHDlYCrSTXNFQLlJ3ke3/iVgmf6Q1ANNIxMFpL3et/u8uXP9TFUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730298053; c=relaxed/simple;
	bh=pNFEs1AkDprLe8LBo3hM4KjjQIwQxp96eskW773uNjE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Mbk54dSFMKDZUlRQJRLwoxZkaAjy1cHAgQRVGkaaWL03RdXT+Ki78NNl5pzL+FQrwn0Ay31iNcDzUf/k3RPyoAySUpiJ8LLs2/qMp9NRSWzlMwPKkHVVlR22IMK07LavjyTibHr6nk8E8BAU6UBXPC23Kh1J7mp++2YLQkhTfgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jR/XCicU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Vub1ILLl; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49UEF21b001732;
	Wed, 30 Oct 2024 14:20:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=bqri2neU/cC0+0jFgLYNtofB/Xm7MsdeejTyKVtm+Gc=; b=
	jR/XCicUfnKY17C8r4PwR2qj/SqFaVpaONACTgap0YE+U9pcx/Aif97wlvocA1Ft
	aZMKIs2PiRqWRHaIjhGKMR+2hHCWMS3N296JZZ+urPaUj6I+rQdpeLfVbKfATj1O
	Zn0ngMLGIzQ40SetfBaO4MBbgpjeV87VavI7Vw3RC0/6zVvY4ISoQL7WgOQza2/n
	ZUkCBYuyBVpDr+lC8meAry1eiI3oh4c7aNNCkHRlA1ZEOkD2egxIXcZRsqGtDnfb
	2s6H+ZV/tPpDXcl1p418WpFaLfxgGUXAmJz/jwHxstBs+AuvlDy6tO5BiBGO9e9y
	cDGE+GERlYxwVj0RckK4Ew==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grc2027e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Oct 2024 14:20:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49UE5mSc040616;
	Wed, 30 Oct 2024 14:20:28 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2045.outbound.protection.outlook.com [104.47.58.45])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42hnaqm9qp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Oct 2024 14:20:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SO6b4YsoQW6HFFg28GgY6+rclAn3QYBjZKLcbiZEAHKzaiceU0xc+xoNTh25oWiXuaUk5Ia7mdPqj+/ppdUJO4gbZL2w2BGlWVzr1gyFTtv9wK+6NtXg1pzrQgAJK2kBTGAOn0c3RDKq36rkcdULmT2NIv2y0ODVKMHsSdqo567nQVEvdjL0A+PBNNtBo7OLqEFQv+F0C9Y4ebr7bdAhLKY4CveOgChC9Zy0MRjGw+4B1MEtXkxqB5PNq5uFMkaVX1zD4rJ1p5QzSBOFAVdaWwEuQTppgBjFbhjhMDTehgUq9dSgoSrYzc68NhSm1EYjKgA/A7BiWvuh10QEExwbFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bqri2neU/cC0+0jFgLYNtofB/Xm7MsdeejTyKVtm+Gc=;
 b=bW5VNycpcIIWMU8HdfFD9zz6XHaO96KHabrEnIvfnkaK/JX1/PJtGvAsaxzkMAbe266mG+oejXQYDSVtfQx9jYmuDqpWmhTwyDwpymiuFi8zpoe5BMBjAxcKOQfgbBAkA+cGnbaYLQsKcgEPOExtTnsg22JQR/02s2aV4OcQBZizCIW12wrjT6A7IqNJZWHbiIKMRbIIyJSOrKzW36/feayZulnhvTu4i8s6Og71GTQjb9eFXIL3t/gUD0PTNYiPvjYMJ3PSZxpwpW5rxg220xFiewjWmLROk6EnXXNUudJ6bxsO5kqzDnfxqNRYIxb0dfKB9YU/6QJnmenjgQGpiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bqri2neU/cC0+0jFgLYNtofB/Xm7MsdeejTyKVtm+Gc=;
 b=Vub1ILLlwW7DWJubdDD3vprTLg4O6XirdGm5jAv6bHI/BwRLGLAgUKpKwk1Ie9Yahh9O/tMXn6VPwGzydHvwKX1GocdYyy/9kZHGzJaJ6YR3OwHFPktYOl4nSaE025dQqvbwzmZJz5qevS5qcTgXGdolrhVL0X10iXSSi8/f41s=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA1PR10MB7309.namprd10.prod.outlook.com (2603:10b6:208:3fe::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Wed, 30 Oct
 2024 14:20:24 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8093.027; Wed, 30 Oct 2024
 14:20:24 +0000
Message-ID: <92ea9e18-6174-4619-84a1-2c55a1e86693@oracle.com>
Date: Wed, 30 Oct 2024 14:20:20 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: handle bio_split() error
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        kernel test robot <lkp@intel.com>, Johannes Thumshirn <jth@kernel.org>
Cc: "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "song@kernel.org" <song@kernel.org>,
        "yukuai3@huawei.com" <yukuai3@huawei.com>, hch <hch@lst.de>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "hare@suse.de" <hare@suse.de>
References: <20241029091121.16281-1-jth@kernel.org>
 <202410302118.6igPxwWv-lkp@intel.com>
 <c9936883-d766-41f5-9a54-35702585ff6a@wdc.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <c9936883-d766-41f5-9a54-35702585ff6a@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR04CA0129.eurprd04.prod.outlook.com
 (2603:10a6:208:55::34) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA1PR10MB7309:EE_
X-MS-Office365-Filtering-Correlation-Id: efb36038-008a-4bee-53fd-08dcf8edfec7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bDJrVjF5cXlsWFdxemZIczYxKzN2TVY2eFZQWFpDV3hPTzNRR0NydWRNOVpp?=
 =?utf-8?B?SGxjd2IwQ0NQdnVFdGV5aW1ENk9YYTZNcjNibHh0Qk1lakdMSkZUWXZKNGVB?=
 =?utf-8?B?aTA1clRpa3l4TGgrNXVLWWIvVzk0RWpYSUJHYTk4UXJNMlRyWnFacGhmMnkx?=
 =?utf-8?B?VURPd01mOTRwU2VXZEhTOWVaempFSTJDNHdxdHFRL1VQRStSTlAxRmR0bitX?=
 =?utf-8?B?S0ZvYm84VENralczazJ1dmE2RkxaQkNaeEVqdGdYbG90Y3JjeVZwM2wxWHI0?=
 =?utf-8?B?RndXOFZkT252Ti9YSEV0R3pMM1R1cWcxK2NqbjJ2UHp0Wkl6Ry85eUNYMHBJ?=
 =?utf-8?B?NGlvZUhJNlA4SWRUWEtLdlJNd0hJaDViM01TL3N3SEd3RUNFRzV5T2huUTF3?=
 =?utf-8?B?RGFVWUR5dXpDdUhkYXZSQTZRQm1Xc3pMM0hIRjlPRjFLT2lOK1IwQjBpd21n?=
 =?utf-8?B?MHlBdFpqRTJ5aGU2WkpENXl3SGE4OHNDV1d5bWZNa0N3WWppOEpBVFhkNlRv?=
 =?utf-8?B?R052RXh6NHhqditNSGJvQXV0bDZDazV2SGRneWg5T3dnVHRmZVpLVjVtNStn?=
 =?utf-8?B?cUJ3YXRESjNDM3J0WU1GZDZNc1c4T3FBd1ZZdXcrWjFsaDYrajdHVGJyUks2?=
 =?utf-8?B?V2Y5bHdjWW5IWTFOYXphaGtEdEZac1hqVUpjSFYxR3lPbkQyVEtuMG5PT1hu?=
 =?utf-8?B?Z3NldzhTdUtQNVd6R1EvTjZNZmJUaFFHQnl5YU16aGIwa3FTb21MclVEaFlC?=
 =?utf-8?B?TWcrYStBRDZ4R3hyNUcxR0xWUFZFcEUrTU1sUWM1bms4Qk1mYWc4ZE9vZnpK?=
 =?utf-8?B?Tm84c24xOXdpbVR4YkZFaVh4WUxEZERUSExoTFhveVVBdEVncmlWRVpQdXhN?=
 =?utf-8?B?cTNMenlFRDhRdWZXdDVVdVNROEhZOVRmVVlRWWorV21CanIrN0h4RWZiU1Z5?=
 =?utf-8?B?aTdHajl1ZjY0S3ZudkoyRW9wSUZiUFRLWld3alpHZFFRR25iNnMyRE5HWVFr?=
 =?utf-8?B?WXdHTkV3Z2gzcGFIdVMwdzZBdFRBZ3ordlhUZ2hlcEF4QXlCbVN5L1Ivd29r?=
 =?utf-8?B?dnVDMmZMckQvbjhoUG9BZTRXVTRjVkgwL0NWRHRTVE9BUXJLVkhTVTRUa3BG?=
 =?utf-8?B?cGhBM0hBQ3lSS2RGOVd5anhhMFlWWDZmaTgxb0diWmo2dHZNTXd3WGhsQkov?=
 =?utf-8?B?TFhBZVlXSGZ1OWZsT3MzcktlYk8yUWtLRmxHd3BhZ2V6VTNlOThvMHB1bFND?=
 =?utf-8?B?bHh1bjNSb1VRcWtYUm9WUlppMUtUVUJyMGNYNklJbkxwdjQ4anNaWEJCNUt0?=
 =?utf-8?B?RTk0VUllUEZIRWx1TFJydDdVemtacU1sdURMVVo1K29paC82Q3RKTGwrOHNS?=
 =?utf-8?B?VlpIbGJhZHhKbWtIRGliQ0Y2QTBDOFYwSklJRzhuUUp6N2E2UmhYamZUZFJv?=
 =?utf-8?B?NVljUE5MdGp1SUU3WHNLWXU5aFJUR0V4NTZQdTZEUlc3YWJZN25uU2hHVWVt?=
 =?utf-8?B?RithZTV5KzBlOW9KYjJXSWFtbnN0NG1YbkI0cnRXNGUyYmZFY2F5QWNoWS9Y?=
 =?utf-8?B?WUxWNSsrL0JzbFBZcFRzWnp5TlRmUUZLZjNabVZ1VUtTZW5MQm9qMnVVS0Vr?=
 =?utf-8?B?WTg2WDdxeTB1V1g0UWNCaWVWdkFjSCtkTm1EUjBGS0tyeG5wemRDVWlyblFy?=
 =?utf-8?B?eFV5WU5YSEhWMVd6S0orT2pMZ0NqTWVNTFJRTkNCRFBIWUVpVksvS2pXb3Qr?=
 =?utf-8?Q?nLcKFmcrqu6klaY+b4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L0RsWHAyaHJQdk9hM0kwY0JSdThPY25aOFlwdlQyNUkxU1JsUWxocHE0ZEh3?=
 =?utf-8?B?VFVWTTZIMjE0Nk00bFBreGgxSU9XWnFQWmx2THZnTHE4cXZGMnRLR0pJcFVu?=
 =?utf-8?B?VWRaQzZUNG9RM1N5Undxam1aMXhrVTJMb25zKy9oWHcwTElyMnN3QTZ0bDkw?=
 =?utf-8?B?QTlwdzRhdmlsaXROMFk3UTJIRmNiNDlpN3UyanRoMHlCaUtWUDFRRnlOVlg3?=
 =?utf-8?B?WWp5azlwOG85ZmVmLzR5L0ZIMm9UalRrRDVSNE5JTVBlQTZ4eStwM1RrNVZC?=
 =?utf-8?B?TWtwUGRqSUhjbkpVVUtVMHlPMmhZUFY2Z3g2YzZJUjRqTy9lQjNqcVpRNUp6?=
 =?utf-8?B?NXc0c04zRmdwalBseFlQUFVCZURtY2J6WGxZNW5oVUtqVnN1NS9tSmFhZDI2?=
 =?utf-8?B?bmRGYUpYK3pEdjNNZFZEYlp6Qm1rUTQvUm1iSy9xZm9KTnY1N1hBL0RQRDVM?=
 =?utf-8?B?SWkwZEJtZWk2RWI5MWpRVXlzYmdhL25GRFJ3OS9KK0FpMlNIMGJTdHBSdEpH?=
 =?utf-8?B?Z1N3UkllNjVxa3ROVkJrcHl1ZnJvdW5pNkZac21zTzlRRzlGYUNFZTVkVXRU?=
 =?utf-8?B?VkI1MWJIMXZHR1FhTVJnSUdoa0VjQlhrUlkwMDdlTmlBRHN5R0wzRzVQY2V6?=
 =?utf-8?B?YjlZMm5IdThXZGpVRUFpY2J0SjdRNXNCcFQ5NCs5UDhhaEhlTmtPRXJLNGNM?=
 =?utf-8?B?cnRmaVBKMm45NDFIcHIvYjFvWEUzb1pXeVZESGxhK2RuQmgzUGdUUGV3aFFQ?=
 =?utf-8?B?TkJYbTBTbzJvblRMamtHNHVVSDVqM0RDaGVpb0hsYXJkZjdXckg2WHdWR1pr?=
 =?utf-8?B?T29mZ0JMTXZqYVpYemxDVFU0T0cyMUlNYmZuU1lNWXNxNkhLTzljWjJLNlBI?=
 =?utf-8?B?TmtVTUhyVXhLcGVibkJoeVNSNTViVENJWVloNjZXK3B5b0RRU1ZDNFUyNnp6?=
 =?utf-8?B?TXVCdTFuQUw5bWJOQ0ZhUmdDS0pXQnhWYi9tbjRTQzRHMjRYMWY1Z2pnZnFU?=
 =?utf-8?B?c0RtMUxuVFczenhIazhHeWpKdXJsQkwrSUlxaDJZQWdaTjdoeGV1MkFLT1gx?=
 =?utf-8?B?SGpzM0pyQitjT1I0bFRzVGFiUkRUcCtJblQ1TW5XVS80b1hVWUYvTGJIcDFy?=
 =?utf-8?B?aEhzVVVQMFNGSlB1aGw0Z2tqNWZ1SUE5TFRBdmZWbHRjUFlBZVExbWpBMklq?=
 =?utf-8?B?ZmtWOVZBUUgwclhERFM1cmtoYmpySjFqb29hbzI5YzRQZVdzeWY2bktCWGVk?=
 =?utf-8?B?SktVMUYyRjZFYlBEZ243MXlYM2JibXRXVHUrbXJCNHBqdk9XWE52VjU1VzI2?=
 =?utf-8?B?V3ZDSGUvSml1VHprYnh5aDFrM0hsNldldzMxdnZGbVlRTVJKTWQyUFBCaFlW?=
 =?utf-8?B?M29ueVgzY0NwUWhxeWF4RWU4RVBLa3lTem5GbFJrb2JHOGwvNitiekxUQ290?=
 =?utf-8?B?eTE5SDNVSy9VMW9pVHdNQnNXaUl4T2dTbUFvUEdaVExCQk9nWk9qbG5QZG03?=
 =?utf-8?B?Q2kwbGtWM1V6ZFk5MDdlakRyQ1ZtTWYyV0ZjclZnT0tCNllod1A4MUVldElD?=
 =?utf-8?B?TnIvOE9SQlhtMHZybWp1dkZlMUpzNEFsd1ZmN1MwZzdIZEc2MTJHR1ZObXVZ?=
 =?utf-8?B?YjJWOE51RjVtQ0RCZGMzRzNaaXI2ZVMrN3lpdHBBZTV4VmpDNkVqTWZmMGpt?=
 =?utf-8?B?OXVhZW5Wb21WeWRHR3A4QzFocjQ5TUZRd2Z2dGs3YlFzMFMvS3k4V0d1RUx4?=
 =?utf-8?B?Z01uNXlYbnBjTnZVK2JMeithVGhPZkpPTmxXZ2V1Ym5iU2pQUDFpdHNFQnRu?=
 =?utf-8?B?WGFSTW5UTXhuRU1rUlhmUUVEanl2QWQ5OVFqY0F0WVFjSDlWY0RvQUI0Qnov?=
 =?utf-8?B?Z0M2NURiNFp6VHZuNEp4UUMyMVJQVExvaHJGa2ZIRm8rT1FQeG1Qa2pDM0JM?=
 =?utf-8?B?aXBVcGxPOVc1Y1FxVlJ1dWttczZacXZMQlJBTE1JTGlzbWlvM2o0ZmxVaUZB?=
 =?utf-8?B?MlZiM01xZmF4eE1ndXRNdHlpTTNKYzNaS3lJeE8ydXZKZzVYdjBvOHg1ZmN0?=
 =?utf-8?B?Z2RCWmdtbnh0NU93R0NXclVUbjZFeXhrbjlLR3FqS3lSN0FnNmFQdzluN29u?=
 =?utf-8?B?UHJIZVlEdWNJUWhtanBWUDZZUjJRc0FWMWVweVR4akd0c1Urb1RQNlN4NFpR?=
 =?utf-8?B?dXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	plSM6hKQoIpQnJ53g6nQ+eL18AJ+4xvCBxGaYia8UvA5d6cTDjBFvHu73Q15pU8CkvO1zZLfZHzGWE/msMfeeNOQCVAD5QpfRaqDffqyxvdizqN5QGXVMEENeLEpkOcJe11rOWJngqc2fNuSPnivO3adONx7nBxjAirBovPyXApXg3aHVRR03wM7OEvhsTBMMosOV30XdXtqVhoT/ij+CGPlf3IdInJP3GVo91i+pO2mNOXIZZPvL8KFXy4H5OYXxyb8JyiNLCUPBnWipHD6uTEWn1HDkuvl+OCwbBBrzYVPce/e3ACZhwqxJvm1zH7fpxI+xCZVmMZFZ7gf4dYikzEnbZu0dwK5q97e5Jnk46GdsVLVBDWf2tnvgSJcEgBoyzyWW/wkOLEmyGKGh3R/24+/gFL6ZiBkjimYqabkeQWtMijlxRproNtfdwgFo8hFnXOigBhs7Vah1+8FMnkckaWc4ifhOlZ/TjOg3LzH0awvggTYjy2DVWJZEiVba0FVMeSCCTSM0pyLSa/6QWtRpn6MGqpm8bweKqR06ruOukGcJM/Nrcd2/vKQmOrCMT5C0GWbuEC1D/UoCKU+Y+W98dn1Qp7qSaHMew4vX1W6kIk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efb36038-008a-4bee-53fd-08dcf8edfec7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 14:20:24.7432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n0DBHt7e4pkPq+rbXBP+3b7Up8LTlbuyZ7MoLlLjdMWjGwXTxJPjOljRXdhC7CxKJJiR9GsHCGMXn3L1u+CtqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7309
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-30_12,2024-10-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410300112
X-Proofpoint-GUID: fmTafcWVlFMIjxfCbQlViAfF5LLXzT5A
X-Proofpoint-ORIG-GUID: fmTafcWVlFMIjxfCbQlViAfF5LLXzT5A

On 30/10/2024 14:06, Johannes Thumshirn wrote:
>>>> ret @@     got long @@
> Yep that definitively needs to be:
> 
> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> index 96cacd5c03a5..847af28ecff9 100644
> --- a/fs/btrfs/bio.c
> +++ b/fs/btrfs/bio.c
> @@ -691,7 +691,7 @@ static bool btrfs_submit_chunk(struct btrfs_bio
> *bbio, int mirror_num)
>           if (map_length < length) {
>                   bbio = btrfs_split_bio(fs_info, bbio, map_length);
>                   if (IS_ERR(bbio)) {
> -                       ret = PTR_ERR(bbio);
> +                       ret = errno_to_blk_status(PTR_ERR(bbio));
>                           goto fail;
>                   }
>                   bio = &bbio->bio;
> 
> Can you fold that in John or do you want me to send a new version?

Sure, no problem.

But I would have suggested to not use variable name "ret" for holding a 
blk_status_t in original code, especially when it is mixed with 
PTR_ERR() usage ...

Thanks,
John


