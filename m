Return-Path: <linux-btrfs+bounces-9300-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C952A9B9546
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Nov 2024 17:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83F76282C4C
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Nov 2024 16:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9081CF5E5;
	Fri,  1 Nov 2024 16:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KvITHKlN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="n9rjeF8Z"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B291C9ED6;
	Fri,  1 Nov 2024 16:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730478254; cv=fail; b=LQpWwGWStCDGdN0ibhUq2l/aNCRbb18Gr0+zvm1e1/6xKQWTlR0hrzRo4HXzlgBOkPrA6Y4JfNzrw93luR/oRmbX4dPxQhOD0K5ALiS8gLljIs/L10Pj/xgV9sKF9bxtOzVCmmeTvGYtB9Zd5kw2lt7pr6OKFzEliBd47S4PQcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730478254; c=relaxed/simple;
	bh=6ItwzuPRt0uAicfy947wNEuHW4QWpOBYUf9o9tpR81k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DIjxPB+jiEXLG6nEDBD0w8TzlqXjkM5jU/yaTEb/dgmkl2/DSanFwPjsezq/ha2NW80yD2YiXw39Ph/m1QnbcoK03Ta8j5u3wCeOUTnA5l/BSnGFvxHiPKkEpb6ixedjNpM0tfwfvoYQH5GtkF10hKKJZMNIqDmZMMJQYs3ASkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KvITHKlN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=n9rjeF8Z; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A1GC6Dn004430;
	Fri, 1 Nov 2024 16:24:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=BhOF0KxEGum/em+W1tZBu7vxntma+w0LuMI/zr2uo/w=; b=
	KvITHKlNdM2whI3oYvbfcBFjXXGRD2lj/xI1FoWcik4NO+1eJeF3P+/q9dvG8N3q
	vGdm1ICZMxIIPLrz12hLfrNjbr5PekB0+5YT1U+fd2mSuvqKoGMjgoQJMPFiLMHC
	oFfLvihfbs64T7L7jhnx0Pjc8TziyfOO0vbFMQ6lB783D4wxGwsHJBAZdyX2knis
	5daYWbX4QnR8P4rbQ7TIpnxcNiaWBbKszSMgAE6DfR0n+57A4frWYh5OXXLkh46S
	IzQyqL/BltwtKeMh/H1za+PVfHDkNwgZD9vNGQf+zixhVT/dPFZI4/jmgsAa9Nn5
	RZfBvGYQ9qwfw8Ae3Asvfg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grc94mb9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Nov 2024 16:24:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A1EmkuW040322;
	Fri, 1 Nov 2024 16:24:04 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42hnat4045-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Nov 2024 16:24:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i6sadaqijbK9RBBk9a09/bbZYnA3a6R0H20809LwlE66pHYovcg7sH6Nu+Zq2XmMClaYprn0HA9uhoxLH64qrfeTWySX70xCSjFWVTye4zU9TfU5e5ypGdGnl3fMejOY0NsU7N5QkM64HF2f9WNbSuRJOUCiHu1d0ojEBVJvJZPA1X7QIVlhQKZjlxZ9EYHS+fMDNRDs81a7w2ew9mJsP5pqC1K9TUYqeAoM9lBoIyWQ8wDawJPtx7FtHrQ+xFh8UNZqFwJj6oFsHt1HI+n0Mnsb6YGypEqFSzRQVCKZKOVlNH19hUfuGIDeAZxjAhm9oFpZ38sG6tgvwSpdzZmEfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BhOF0KxEGum/em+W1tZBu7vxntma+w0LuMI/zr2uo/w=;
 b=ICEjD1ydF8oUPG9OyKB5dwZVLJiMgV18XTrBaHdNWsnKburMKElgY8QIY4l1RP7ddyntkl3rXnH2K8K/eswmbI3zIRj0OzoBw9pr/+55Fthr7qGWtaz63JU5UJiflgIQw/Njom52HZwW/GNzRFYEsCSvk76QK0PBCM0k3NPvguRj5WSkCw9cI6Vhqv7pfjjkmcaXZBP7oEATOIdCMkkxE3kwrHcsmgfynrUgq8XNGyDWTsdu886tRltfbwL6AOJQW5yZSc++0kPxQtJt9B5WjVkXgefKR9D/3tiw52KW2X9z/dMKImvULzK4R4ofv+aGe4dwKVt1Gc+0NW/Fslgfhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BhOF0KxEGum/em+W1tZBu7vxntma+w0LuMI/zr2uo/w=;
 b=n9rjeF8ZNsztP2GezIVcQxCF2fYHETJ7Etmu2qdqbx7VQSDKGnqtT4ANSiNc49TsLdnFjQCmtphh+KfwbJK2GAcjQxq5CUo2Ne22gbA8ddQ7HD4Huy991P7XRwKPGrxGQaPIEy9489o3V+3H9CWT4X7I+2cFwHzh8Dw/fr5qVU8=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB7128.namprd10.prod.outlook.com (2603:10b6:8:dd::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.23; Fri, 1 Nov 2024 16:24:00 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8114.015; Fri, 1 Nov 2024
 16:24:00 +0000
Message-ID: <fd8a6edb-7775-4e15-9124-3be3c11adec0@oracle.com>
Date: Fri, 1 Nov 2024 16:23:57 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: handle bio_split() error
To: Johannes Thumshirn <jth@kernel.org>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
        "open list:BTRFS FILE SYSTEM" <linux-btrfs@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc: linux-block@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20241031144458.11497-1-jth@kernel.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20241031144458.11497-1-jth@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0151.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:188::12) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB7128:EE_
X-MS-Office365-Filtering-Correlation-Id: cba61b16-0786-4884-881f-08dcfa9197f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MVVzMWlEUnh0NVJoVXEzOUd3cHRaOXMvaUR1SmtHdFNrSC9mUzM4WmhyeElN?=
 =?utf-8?B?STlodnBSRDV3Q0VNeG9aY1hBK2JFUm1mQkMwQzdvaVVDVTRoeG9Qb1BmeU5W?=
 =?utf-8?B?UnNBUUpvUW4yNmtNeGxRUWNHNnhHYlpiYU9ySHpwUUNNd3dBWVMwOFRHeFlZ?=
 =?utf-8?B?d3ZRRk9obFNLN2VDNEYrejVxRmVlWjJQbEN0TFNJVXRUZjgvNGlkRTdXeFp1?=
 =?utf-8?B?TXhGcTUzVGNCTzdrN3pmSlpESk9BYmUvck9EcDBFbjl0eGdTYWtmZHU4Qk9h?=
 =?utf-8?B?UjhFYWRQZW5pVVJJK3RrOHdQZXI5bC9RTE8rcmprZGNoY094b3BhMkVqR3Jl?=
 =?utf-8?B?S1V1YS8vK0h3VjU4bXhJalFPeUNzR1MwYkhxMVFVdWt4Uk90NVZhaWx3WFVu?=
 =?utf-8?B?d29KbGxXcllXTm9aaUk4L0RpNFJud0JGWWRsOE9GcXpic04rRUJJdndkUXZ0?=
 =?utf-8?B?NmtFSjJlakZWSjBZdVZwY3oxb2tDVERGaFNwOXRjcmF5Y3BFNDNFVUxwbVV6?=
 =?utf-8?B?VG9Ja2FsV3Mvd1ViRGlUSXF0TTVjUFNWTHNGUnhpcE80N2RWeTIxK2ZJcTJu?=
 =?utf-8?B?SXVoRENkMTZkbjhFREpleitTcjVsVlorYU81Sy91QXJXMXkyRURSZ1hHUTM3?=
 =?utf-8?B?ZkppRU0zUkJhaUhZWW5RR3F6M0hQVWVWNTE5aUZIOVZkbE9XL2U3bkswOXFj?=
 =?utf-8?B?c1Z2WTYyZ25TR3YvUDg3Z21WczRJRUtCTjhJQ29OdkxPMUZvYU5jS2NIeDEz?=
 =?utf-8?B?TzFJcS9sK2ZmYllPaE50VDFvTjN3WXl5WkFWYStJQVRWMXB3SzlROVNCMUN5?=
 =?utf-8?B?RlBBU09DbFhwNFlIUTAwcVIvSnllMVo5VnBDb2dHUVE4Nnp5aFhJUndxOHhP?=
 =?utf-8?B?TW91eldyVitldWNKOU9iZ3Ftditlc1Qrc1RheG5ORW1rZDEzZS90MEpHWk1l?=
 =?utf-8?B?RHRUeE5pT2NGeTNkaXc4QjRVRUtOc2pGcXpJMU40TXpMMGxHMnk3L2N0bkxo?=
 =?utf-8?B?cGJDR1dGZTNlbEYxb2JkUURqYnB0Nk5EMXlRYURqc3pUVkl2WmZzWTBld25B?=
 =?utf-8?B?VTlLZW1ramFxREJmRTZDNmg2ZitZWFRxK0ZTLytFRFJXK0tzTWRXNkM5Y2NG?=
 =?utf-8?B?aUpkdnpXd0VpMHdtc0lSekRocnYycHEzZW4vZC9hWlpta1YwWjIzTStkVldO?=
 =?utf-8?B?Y3VEU1lUNnpNSVJBNG43eGhGRy9wMk81Q3MyNFN2THNjZWlCRitUZlRpMGxJ?=
 =?utf-8?B?NlFQRTVmN014T3NjNVBTMjhNeUFic2o2NDhRRDVLd1lhZXpHVk0xY05SOVZE?=
 =?utf-8?B?dGhIeEZSN0tpaFk5cUNwS3gyclFmSWNrR2JCK3VDOU9ER1NZclRIblVwNHZq?=
 =?utf-8?B?NFVtdVBIQkdqOVR3RkgxSjhUK0tJSWRUNHdYdVhLZFZEY1EwVWRxWXNDaTJp?=
 =?utf-8?B?UnhkM2xsaWhJaGRFZW16YUIybk9OU0ZaS3pGRDAvOTQzOTBzSEpldG0wRyt2?=
 =?utf-8?B?NUlvRVh1ZUVXSkpTaTdVNWNoWEpVQmcwUDJhdWtydklFREVOUmpZcWg4SnR4?=
 =?utf-8?B?bDJ4R25aRTBGREltMnliSmFXMWpXcVAzZ2Y1VmZmOEFHaEVpVUl5bjU4RFB0?=
 =?utf-8?B?NEpRR3pzL0cyTk5ZR280N2NGc1dFZVN3cTRkY3ZtVnN6cExReFNFeGRtMy9G?=
 =?utf-8?B?anVGcHB0WTBXWGk3dlNDS1VXdGFqdWdMZ3ZFdmhJeVBCSkZISXRvQ1FkWDQx?=
 =?utf-8?Q?6mXQY0BolKi4n4L3iQH+BV5ltlQctSIFYvt+veX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y2xyZERqUFZna0JudERTNVE2MnNNTU9UT29OODZsZnhrS2JuQVhscTA0MmhN?=
 =?utf-8?B?WnZUWEsvN2s5NGcrUFYyNzVjTU1sSzd0cGo4ZlJDdTFJaDFmTC8zQkI4em1s?=
 =?utf-8?B?NnRkM1I1VHplYUhCSFJFQVNVRHJ2bVVZM1AvYXRrWm52QmtPWUN5aEtZbjYv?=
 =?utf-8?B?VkZjTHVwUVNNUnFxUGIyWDhsTXAreUxIWHBRbmxIZnNpc2hzTXQ3emhKaEY2?=
 =?utf-8?B?VTVkbWxPQ3l0aDFNaFZJdlRaZGpwWmJUclVYZVJmUFlUZEl1Y0pWVEUzcmlQ?=
 =?utf-8?B?OU0va1IyZHJQb0NBSndlS3pJcUhFazFTY3lyTi9oZFI0ZWJpWTZDY1U2bUpZ?=
 =?utf-8?B?R2pienA3VTQ3SUZVUlpmbTVIditlcFlPSXlNaDFBdGQ1QnEzM3dEdkZXK1Vl?=
 =?utf-8?B?TUpUWVdPa01KNzNDMmxTdzRJZzNybE8xdStFYjlhVTM3WWFCWForU2lTLy9r?=
 =?utf-8?B?QUlVUUNaeWhZeEFpRmdMRm9hZENVcTFNdHdHWTkvTGJ2UHhiRkJ5ZUxlTTcr?=
 =?utf-8?B?ZDRVZWlld3FGRVpEOEJNNk93bVMwUEg2cU9GTlhEd0dMZEczeUloWXEralRi?=
 =?utf-8?B?bXlKR0E1WHFiN2RVU3ZwMGtiNDhpa2RmWWVWUVRmdEJ6bkhZRTNRejgvSUJ0?=
 =?utf-8?B?eG9IQnNvVUJpK216WkY3V2poRS9ycVhDTlgwNW1aQkNXQUVPdXcxcFVmQWVL?=
 =?utf-8?B?VnJqUXdLVUxIK0VXYzQwTG5vUjBlMUZka3l3YVdLaTh3d2thUFY2alplYngz?=
 =?utf-8?B?Vks2cTVjQlRzcUUwa1NLZ2NiUm5TZi8wNWdJRkgzQmtTVHVlWlRCV2JOQmZ4?=
 =?utf-8?B?TENQUEJRWXVCbklxOGYrdUxtaldOOFQ4Q0tqYVEyRkh6UzJFV0llVnJ2c0tE?=
 =?utf-8?B?cStLUm9vUlY0ckN0Y0ExQnlENTlJcmZSRDhPMXNnRUYwUnMxQ2Rmd2dGVHlB?=
 =?utf-8?B?YTNiTVpGZDYza0syWEpCKytaVzJnYytTN2kzUlZPZnNtTElkb3E5SmlwQXVt?=
 =?utf-8?B?UWJ1YitWMFlRV25WSm9XNzNFV0Vud3p3SWFIRzlQd0ZTclNOYTdGYy9XRjZT?=
 =?utf-8?B?ekZrdjFSRm9wdVRwNnplWWF5YndMWTFNdUV3NzF3R0FNUytCbUo1YnZjbDht?=
 =?utf-8?B?OFR4NE01eTJzZXN4V0tSS3pPWW1yZi9ETGtkckNNbVBodHBKbHEzTWIxNVFi?=
 =?utf-8?B?aTE0dVlPcGlMcEs5MkFwbnVmMkJqV1hmbXJIeXM0d3AxTzlFNXNoWlRGVlZx?=
 =?utf-8?B?RUFaczNEeFdQKzF3ME5wRVlrd1hnYXRQakFGd1R4cTEvbE1oUGpBc3QxSW90?=
 =?utf-8?B?VnVEdmgzQXpSbmRkY3VsK00xSlBzVlJKbjVrNDVBWmpRbm01Mm5SanJ2dHY1?=
 =?utf-8?B?ZnlzcWNOZjJqdnlOaUM5RTM4dVIySitIV0ZjNU9aMno4U2xyNW5jRU9iWUJK?=
 =?utf-8?B?MlE1YXdJWElVSTYxcWtPSEVIOXNTdzc4L25xNjczdUtpN25oaDJoeW1FaGdF?=
 =?utf-8?B?WkxmU2JudGJEcUtQdjFVWlBVZmRuZGhLdEFENXhnbzlxbFR3a3NDQTJXTGhk?=
 =?utf-8?B?MzZ2bXJYWmk0VEdiVFBlYTFwWHhvOWhIZUxrVkU3ME1EZFFGS3RZS01IRDBk?=
 =?utf-8?B?bkQ1TldBbnhKUnMwM1U5OFhUK3VUWnd5MEZRZDBZWlNyZzlLcFpLN0VUcWEz?=
 =?utf-8?B?M3VMZnZvenpNRWNBci9DTm1DNG5XY25DN2U4S0NPekE0MkRZam83TWkwMHZk?=
 =?utf-8?B?Z0g5cUtNc3VROVdLOWp6VzN6Zk5TOXF5WG1yMEtvVHducGFNYWg1NWp6cS9q?=
 =?utf-8?B?L0FOL2QxVkxnZmM1Z1pnTC9lQllxNFBNdG9jdGNZeFN0TWdhT2granNyVmx4?=
 =?utf-8?B?aE54aWx2MTBhajZQK0NVdFRsbWV4MElERjQ4MTVrODJjNXZKbUxRTmE0YS95?=
 =?utf-8?B?Qk9rby9hTkRYeVdzV0liVkNoM2tnazl1SmF6T3laK3paNER4SzZhTlhna0NL?=
 =?utf-8?B?OFZVV21lUTI0WkRPMnFQYUl1REJwLzVkaFF0UUVleFZpa3FCYlJUTnN2R20r?=
 =?utf-8?B?TDNVNDRTOFV3N2JWM2xNK0lhbTJ5dnAvd2dOWXMwWlpUekNncGFnSWJSVDlu?=
 =?utf-8?B?K2l3eTFpYi9yQndUdHFXZjdGS3JKUHVuc3YwRzdlQlZXTHJSRGpyRzcxT3dT?=
 =?utf-8?B?cEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iXpNcwSOsYvLF7JU9wh2ABhApQ6VND4nKX6uHxyM5f1+NO1G/INJ9VxJuXdP2XCei3WsWdpvd9Ya8+ZQUnxfNvElvStjuZVey9jotNCFsWbnITD8W/ittRQSnyEkN4Be8BFjzz3Udl3KpDjxKALQtByCmuNKIThpC2mfBgjIp9J9I5BlfVJoGOKxxrbRDPpUkCeKFER01hqiRGAMKEbjOWGQwm126oWp68FySpegFbOeNAdBa32gODuU2aYoq25DjqocPdV7zUIBmuhw64UBONaRO/PE1EMUKLNR+Bpjh5AuXnhUujEGEnX6xALtS1uKls3XoNPcx2I8f9usoPGmyMygkzrfZHHODnWGJcLonKPOZbYb2UVlAT2zjK/C8+lNh0JMnCzhFndLgOwUrlZN9EbutkStLCsKX+eqfL4ToLkw0NjcJewBliAbBUcTYKz4ERpwM5Ay7Pgn84QIt/hDI6sUkSpCCbecn7CggWmZad4xlYFyOT+Vhuo68zzaOs8H0CKRXOE+ZkYQMa+f6617SbKNQAab48fcLvXF8SGMTlwu6LNUrKXxgoQLzapXSBNN/2CqQNDv93yzHhHX8QmDxJnFG0p/yK5QCMMXKbsphHk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cba61b16-0786-4884-881f-08dcfa9197f3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 16:24:00.8418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6eG7XeyACN1BwmpY1okjh6JXP1FxZUUwUvJQcqcrdKaMAyxkuvydzFasIVGS3UGtJQpoS+yKiIlZKL9ge3IBIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7128
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-01_11,2024-11-01_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411010118
X-Proofpoint-GUID: -gcZ_8bB9RicY8T40kbeUt39zdvAqAsz
X-Proofpoint-ORIG-GUID: -gcZ_8bB9RicY8T40kbeUt39zdvAqAsz

On 31/10/2024 14:44, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> Now that bio_split() can return errors, add error handling for it in
> btrfs_split_bio() and ultimately btrfs_submit_chunk().
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
> 
> This is based on top of John Garry's series "bio_split() error handling
> rework" explicitly on the patch titled "block: Rework bio_split() return
> value", which are as of now (Tue Oct 29 10:02:16 2024) not yet merged into
> any tree.
> 
> Changes to v1:
> - convert ERR_PTR to blk_status_t
> - correctly fail already split bbios
> ---
>   fs/btrfs/bio.c | 16 ++++++++++++----
>   1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> index 1f216d07eff6..d2cfef5e4d4a 100644
> --- a/fs/btrfs/bio.c
> +++ b/fs/btrfs/bio.c
> @@ -81,6 +81,9 @@ static struct btrfs_bio *btrfs_split_bio(struct btrfs_fs_info *fs_info,
>   
>   	bio = bio_split(&orig_bbio->bio, map_length >> SECTOR_SHIFT, GFP_NOFS,
>   			&btrfs_clone_bioset);
> +	if (IS_ERR(bio))
> +		return ERR_CAST(bio);
> +
>   	bbio = btrfs_bio(bio);
>   	btrfs_bio_init(bbio, fs_info, NULL, orig_bbio);
>   	bbio->inode = orig_bbio->inode;
> @@ -687,6 +690,10 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
>   
>   	if (map_length < length) {
>   		bbio = btrfs_split_bio(fs_info, bbio, map_length);
> +		if (IS_ERR(bbio)) {
> +			ret = errno_to_blk_status(PTR_ERR(bbio));

btrfs_split_bio() does splitting, but error means "goto fail". However 
other failure points "goto fail_split". I find that label naming odd.

Furthermore, at "fail", we call btrfs_bio_end_io() and that function 
dereferences bbio (which is -EINVAL or something like that)

Thanks,
John

> +			goto fail;
> +		}
>   		bio = &bbio->bio;
>   	}
>   
> @@ -698,7 +705,7 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
>   		bbio->saved_iter = bio->bi_iter;
>   		ret = btrfs_lookup_bio_sums(bbio);
>   		if (ret)
> -			goto fail;
> +			goto fail_split;
>   	}
>   
>   	if (btrfs_op(bio) == BTRFS_MAP_WRITE) {
> @@ -732,13 +739,13 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
>   
>   			ret = btrfs_bio_csum(bbio);
>   			if (ret)
> -				goto fail;
> +				goto fail_split;
>   		} else if (use_append ||
>   			   (btrfs_is_zoned(fs_info) && inode &&
>   			    inode->flags & BTRFS_INODE_NODATASUM)) {
>   			ret = btrfs_alloc_dummy_sum(bbio);
>   			if (ret)
> -				goto fail;
> +				goto fail_split;
>   		}
>   	}
>   
> @@ -746,7 +753,7 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
>   done:
>   	return map_length == length;
>   
> -fail:
> +fail_split:
>   	btrfs_bio_counter_dec(fs_info);
>   	/*
>   	 * We have split the original bbio, now we have to end both the current
> @@ -760,6 +767,7 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
>   
>   		btrfs_bio_end_io(remaining, ret);
>   	}
> +fail:
>   	btrfs_bio_end_io(bbio, ret);
>   	/* Do not submit another chunk */
>   	return true;


