Return-Path: <linux-btrfs+bounces-12524-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 206F5A6EE3B
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Mar 2025 11:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 378C63B5274
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Mar 2025 10:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A46A253F00;
	Tue, 25 Mar 2025 10:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RDq11AJH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tNoC6rPR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EB41EA7E7;
	Tue, 25 Mar 2025 10:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742899962; cv=fail; b=R+aU+f2aDl1hg7Jm/pDD7AKHHAQkqHKKOvaJEkxEsQPnrnHo9/8fGnSR2hUuxwnQ27/+XexNhH9vBFrDpgbLHjhcRVS81lYlUQTT1iH7gYidChFrnDnXJW6io5sFHv6xso0ejN6m4WjTtnPpHXtKN/eq+Vq2xCsQblLhmGA+RhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742899962; c=relaxed/simple;
	bh=KGyIyCQnBKqhaui/h3TKylM46zoSYoweaPaDKOE3qnw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IV4COKLyrhiVHa9zD/MgSmax7P54pKgtXsi65xDhcWuJtbRFEISwb1CDzRnd540pGBP9W2q/Itm1aOqFkgFxi1zA9ctsVqvtICDhNMbF0QpeX0z8grNb0Jn4kRIQkiSPahjr3bYSHe/EAY+TbjIgCEg5weRh5qixDBjrizKA6Es=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RDq11AJH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tNoC6rPR; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52P2txg1030292;
	Tue, 25 Mar 2025 10:52:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=+MUM/2Z7ug1YSaQ/qygiYjx6MI80NQi3NcRuAJOSA3w=; b=
	RDq11AJH/3eYvMXYhku1xvT79XOSt5WWP4RjBcfWe7wazhRZyO33faydurBgB/sx
	qF9kX6/L678PmrdQyZru8koSxnvyfyKBllqLISIP01XwYzFw5kNGGcgpOtUnXaQJ
	P+0xHPIrCxC+tXaZNCirxXREDKAK2+gpxFPa9CMeAbyXuYPLL3NXClXtSoE1sA2d
	7zZMuuxWg2XCDhPH5LN4q6Nu12inAhgNrZFqia52qRyP4yl/qOqmlZ4TjOZV6UFj
	wKe3Mbgqg++wDY/vL7e0G9nET4ArL+h44/Y+gAayVakb2Npn1tSnpkedAO6eJ0kB
	8OEBaDVg1h4KpxVgURH15g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45hn86xhny-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Mar 2025 10:52:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52P9iRXm022883;
	Tue, 25 Mar 2025 10:52:33 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45jjcddwyn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Mar 2025 10:52:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GRcklMhjnHognPsNahtHiaSTbA/p5zRlj8isfFQgGyCwPFhrJVOwZzAM3xhmFFROV9bQKKwafF/K1jsUuSRIavmeiB/pJeotqPIFWJrw7rZhP0snkUEw/3ffz7SBKgn6e/xAKL4oiCFi7stXXmaLYgzDLCgsRgIv9wwrWrBkueP1cm4lnDLTYZwVO0BREBz1zFvjyIe4Pg5lJtCHM4f7xaksd/GtrCcGSqGI+rSN+1ZyNlOWJqc2kE/c/WKIA67jNyW+TCVHsSIPAwjNS6XMT9dElf6NXsTDHgsUw7X3OL/452oT1kPMVQlO4VDv0j1dpFQDm9tBe4/EEQvaeXNx8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+MUM/2Z7ug1YSaQ/qygiYjx6MI80NQi3NcRuAJOSA3w=;
 b=JzTe9KvWgcvZ38lJHXuHMTjIxmLZkdct5m79MmUYvlsWtEhBDlndsVHSKQD49ay7HHxuuRdMJfniixv7GobCM98s0wFZpQXkumfX6GAYkwYxrLZ57FRAfjkxCZnYHoT24QvQO4QjJtZ9xNCm5ontEQMDqMAsETAZxkjDW5WvUxnPIQki+JKnzRTqj8CMQtcHrPRZYx9p5iRljpvXLo9hdxSANlWxT6loGnCxMBczpMpX1ykZ7vPAG2QcXYKk0WNpnJbC8cdtQ1wjKP6y8I8ymwWfBmTYhswNJI7d+dsM2wQptihwe2L6NXk7k3ag9K18eitZK9GCAZ6ZHv0x5YH1Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+MUM/2Z7ug1YSaQ/qygiYjx6MI80NQi3NcRuAJOSA3w=;
 b=tNoC6rPRaKxfIQe2LyQWnw1tM8p9zBYM5/X0m+aaM4/zeKu0xD0KL6Uo4Zj+K6WFnG2UEe9UnrbnOCgwK69Paz7tYTPPs0eXNjZ3Obd5Nwv9Zip7IwweJ0Q/lrP5JTgL/1xQRb8xEaeqXbzGXXz7InRxOFZal2hEZB5A93npoDA=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MN2PR10MB4301.namprd10.prod.outlook.com (2603:10b6:208:1d9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 10:52:30 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 10:52:30 +0000
Message-ID: <a4b1056a-feeb-4c0a-bbc7-2d2cebdae8f5@oracle.com>
Date: Tue, 25 Mar 2025 18:52:25 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] fstests: btrfs: zoned: verify RAID conversion with
 write pointer mismatch
To: Johannes Thumshirn <jth@kernel.org>, Zorro Lang <zlang@redhat.com>,
        Filipe Manana <fdmanana@suse.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <8390a7748c1e2005fb7b9dbc1f5e6bd38ea22506.1742382386.git.jth@kernel.org>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <8390a7748c1e2005fb7b9dbc1f5e6bd38ea22506.1742382386.git.jth@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0084.apcprd02.prod.outlook.com
 (2603:1096:4:90::24) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MN2PR10MB4301:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d450f53-8601-458d-384e-08dd6b8b23d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bVBSemVhZHZtaEVOQTN6TUZPN0lKR1d6V1RDaXU2bXNxMnFJamlqTzlRUzhi?=
 =?utf-8?B?L3pNQ2ZQcWVCTnY2M0pEWkJZUFJoMmZQbCs5Z20yajdUQUNuR09NSUxWQlRW?=
 =?utf-8?B?U094NkRyemp6NE15cmpycE5rNU5QWk5iRnpUK3FBbzZuS2xTV1pURzhqaExV?=
 =?utf-8?B?V2xFZ3ZZNXNORzFpdFovNWVNUW1Ieml2dFVyaU0wWWxvY2c2WGRZdmZOZ3JS?=
 =?utf-8?B?NzFUZFE4d0x6dzVOMnFtWEJiTDBXQ2g3bHQ5NllFVUkyTjRJZ0I5dWJoNTVj?=
 =?utf-8?B?SnpQNjg4c3k0OU9uK1V3N1ZBdFBVbWxLaFNEOFJLNFhOdHVCdTVabm5wOWJ5?=
 =?utf-8?B?UzJldVpEM001V3lwRkFleXhmUVZjWWNvQlZLZFNGRkZlQkR1STJZaGVEL1ZQ?=
 =?utf-8?B?dFpTK2hCdmhtYWRwR25NL2dLeFVaSDBmNHcvaXkrd2ZTVXpMMUMzVEZOMEZL?=
 =?utf-8?B?aS8rd0RzNWQ3a3A5SHJHNGp1bXM0K0lBMENXOHJoWmhrdVNBYjBZeTNjcXIy?=
 =?utf-8?B?UC91WVZRdUV6aWtUOEI1ZXUxSER2c04vTi9xelBITFBNOHlmZVpOdGhuZWFR?=
 =?utf-8?B?dFZuZXYzYldueGJpTkU0Z1hKdnZ4eDZmYnU3emVXcTVRT1ZhVkxOSDN2V0o3?=
 =?utf-8?B?NVVaUUhqVDFIOHp1aUdESzlIWFF4OENuL3FZbGhycGJvL09GaWtNVWRNYmVH?=
 =?utf-8?B?Y0Q1MkN6ZnNjaTV4dTh5T25GNXEwd0xHS2I1RC9ObXNUZmVGWmk3THMyNXBu?=
 =?utf-8?B?aVVZdUNsbzZ6bmVsSkVkYUNnUDVGMUtJbmVLbVozY0srK3BvZ3JTUXBQVnl0?=
 =?utf-8?B?MHR3SEdwaHh2VFpnM21Sbkd4RE1RaUpQMUFDcWR5WklONTNWN0tPbmI1Unht?=
 =?utf-8?B?L0NJaW5WVUZKTUZLSEtTWGRWMWsrdU9Xem1KWjlPMENmREtIQlJWSUxPdTUv?=
 =?utf-8?B?UmZMT3F6SWtvMGNZb2dYV040VHQ5bnZYbkw3Zm0xQUxQVzhuWldXSSt3WlVn?=
 =?utf-8?B?WG1xcWg2RWRKV1hIcm91NFdXOE1sRXNKYjZ1ZTBxY3UyMnJNZDIvR1hlMEVw?=
 =?utf-8?B?cktrS0prNkFETnFJaWlLeU1JVHRvOStZVVFDMUtEdzJWd2FlTndYM0U3dEpp?=
 =?utf-8?B?UldJRlVWOU56SjkyUktzMHlKZTRwdVcrajI4aitFM1NiQVd6cmJaVEpKaS9N?=
 =?utf-8?B?bU90UWpGODFaYmZLQ0RpZlZJOC9uVllkenRRUVV4bGxxS0UrcVhTUHlmaERS?=
 =?utf-8?B?TEZJNzg4dC9OK0RKamdOOFovQWMzcE5SaWVOellqZUtPMHNYNTdiS0tCcGhX?=
 =?utf-8?B?bThwdTE2S1ZrYnZDRmlOcGJ0WHZJWXYvdG5wSVZBeUFrODN6NUx2RXN2Zm5u?=
 =?utf-8?B?UGJBdUV6MnNPcFJvUXRYZ3VlOG9jay9KN21qSjFDZ29DcmU5cU5xUFE4WWtH?=
 =?utf-8?B?eWFvMWVLWlFLVEQ4UUdrOXpUSWo5WEJvd0FnSjFlQzJjV0FLZXc1VmpNWjJ2?=
 =?utf-8?B?YXNRanZLZkFHQjh2TjhGdFovVW9ienVmUEhwN0syWk1tU0lCWXFEVTlOZEhm?=
 =?utf-8?B?eVNTVnNnNHBac1U3MThudk1Nb3JQMWVyY09KRUZZekk1UWhpY2QvakFNQnFZ?=
 =?utf-8?B?a20zYkgvTzVKVFBValE4MmVPOURoR2hKbUs2TlowZUZ0NUM0Z2NLOW9pVUky?=
 =?utf-8?B?MjlSRVpxa0FHb2crK3hwbnRreEJKOS85aTg3akZIOGY2KzNNKzMrS2podk01?=
 =?utf-8?B?UWVuM2w1SjFHUmlsbXl6UkR1dDUwemsvTFE1Q2xkVHhidDg5MEVGaWFtcXFo?=
 =?utf-8?B?VEhFR1VSa1drUnFJK3djRzlOdTlFNEJjQ1VNTUZBYnY2dktJdWtkM1E2YXBj?=
 =?utf-8?Q?1Wj3lNSA+6vv5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c2o1c2V5UTNaNjdEUmxnUk1wcjU0N3dKbTBMbDhwNTdxVGREdkZEQmxFVHlT?=
 =?utf-8?B?dTk3b1FtY09nVHo2VnpvNmM2d1UvNlBPUE5Uc25NVTA0RGZnWmxzU0VHOGhS?=
 =?utf-8?B?aHpvUkdiZDNIa1psVlE5YjA2NTVQTkF6U0YvSitpODNUSGRWMFZmM1JGTzd0?=
 =?utf-8?B?OHppQWQzUEh6SGVlWXJvQVROcGJUSlBGd0ZQU0NhTWhHTUlwM0NhdlFrYjND?=
 =?utf-8?B?bW0zTEN0aVhSNFJWbk91WWR5WjJhRHNQdGZjSlJGNDJ6WXdhTjJNdzcrUEdp?=
 =?utf-8?B?OGQxZ1FRRVZKdnEwRjRscHhOcmVDTEtId3gxcGtZanh1c2t3NW1kVG5IWksx?=
 =?utf-8?B?enYyTW9VWkxwTjFGT01XRXRpQS82TkJoMWlTUnBObjVLbDJicmViaTZaKys3?=
 =?utf-8?B?dVNQS0lTUnViOU53cmlwbTNSOGl5cS85NEZIblpJWkhxZ0JaT21wYzRJaUdq?=
 =?utf-8?B?NUphN3NtNmRGSnFWd05oMmRPRVhOd01EbVlnTFhGNmUwSGczLzFXbVJ3K0ZH?=
 =?utf-8?B?WFRBdmVwNmtPWjhVbUdpTWxTUXA0bTJBV0dLaDNJR3k2TnE5RFlYTzF0UHBB?=
 =?utf-8?B?NUJNY2hPVkdHV09mcWVmUDdUMVBkelNxOTlXaXV5Q1cvaHdFb2QwL1Y0dHR2?=
 =?utf-8?B?eGxtcHRqcm9UeGtrKzZzU0lyVmFPNFFuQzhzUjhwa1FxaWlyVWFZQ0FWR2Fa?=
 =?utf-8?B?QkNtZ0RkU3lnVnVYOWk3Si9yallzUFZBS3pHd1lQNWNEZy91MUE3ZW51MytX?=
 =?utf-8?B?SjBLOFI0QVFId3IyRC9HRks4SStPcFV2Z0FrcEJoL1NZZ0syeFhuZFBpWE1m?=
 =?utf-8?B?UkFPTjdUQkphUDVEMU8rN21NZ2loNklrRUMwY3RVT09iU3dZRG0yUk9nU2pY?=
 =?utf-8?B?Z01ZZEh3d3pzSDRjaW9lM0tNdWhSbm1WNjlYMWhoem56N0Z6dnRXaC9aSElD?=
 =?utf-8?B?OFAzeThhcktESlF4R2NPZDNYRThoeVl2cG1wUlZwbTNxTS9yWEJLSW1DcGJ4?=
 =?utf-8?B?NjIyejRqaFQwOTRCUGY3OWhaMjVwWGM5Y2NGZUE2ZkphL2FueUh5NTRWNW1E?=
 =?utf-8?B?b2xucDh4em53Vys5N0NRUzlXMDkzUXg1R21ld1pORFNLY2dpNGtuMUMvb0lk?=
 =?utf-8?B?cXgyR1poaXN3SHFIbWhHbDkzbnhkWVlzZ3dRaDYwTkdIM1JLbDh2NkhESFJl?=
 =?utf-8?B?ZVhtWWpNREFRclkyVjF2Ri9ac25ER3l0NWYxa3R2S1hySGI2YXZHYnhFSm0r?=
 =?utf-8?B?UllrVm5DaEJkSkdBL2VOWWxid1lmK0tLeG1nUzk5dFJjODJGaUlMNmRUV3ZI?=
 =?utf-8?B?dnpMcGpOUDFpK3h4dUtkUkRxa2wrTUJrZ2xUbjZLMmpwS2hKVnllb0Vzc2Y3?=
 =?utf-8?B?bDdNQi9UYWwxRllmNURPN2dhM2VZNGt4bmlZR052VlNtLzZwakdJblI3MVBs?=
 =?utf-8?B?dTBwRjFudXlQZWx1ZWlFRnVoU0h1MmRxeFhpRXBBc0hRbW16MmVLOGhsUVBM?=
 =?utf-8?B?NzQ1T202cnJ4a1ZJNVNPbSsrb1YwMDFYTC9wcEFwRm9LdlBwWjNnTk1wRENN?=
 =?utf-8?B?VUZidEpQeUhvK2ROQ0k3NEx6TE5ZMGNOVnh4enc0ZCtrd3lTelRWM1FMT09a?=
 =?utf-8?B?R2pucnBQZjRreWowRjBwVDloWkRmZ0Vqa3gvSk5wZzQwaW01eVpGbFZhYllT?=
 =?utf-8?B?bkUvS0ZYNVZQd2kvNHBCdUQ0T0hnTnFBUzZLWi9MSEFNOXYrYlRpZFlsMms5?=
 =?utf-8?B?RFVZVHZkRFkraW4xcHM4OUdzSDlTTXloVGQ4R1hiT2Vsb1BtdWp6QlBJbDd5?=
 =?utf-8?B?dUNZekdZL2JCWnFtR2orRVBDNi82cWxvcW5uOUVOTW1GdEN3bHRsVzE0S0hu?=
 =?utf-8?B?dlhOWEFCbTR3UkUrU1VyZ0pGMkhhYjlQNXg2aS9TVS96VG5FK216MFNMVTJv?=
 =?utf-8?B?MzRxa2gwNFJQNnQyZ2cvN1FxU0R0cUlJRVBXak0rNzRud2l3VXJhTEhpb3JR?=
 =?utf-8?B?Slk2YllQR1JseFBjc1pzMVBZY05EalloS1RVRmlYUnlYTzY4dzc2Yi92OW4x?=
 =?utf-8?B?VUR1NFZCbk9QclVMZmhhZlNjRjE2M0V1UG9xMTl1Q01IZXNJSzA2QjE4T0ds?=
 =?utf-8?Q?sQ9nU4bR28cO6OCftvhw/0/Bs?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mQy+PAyrJp2/5+hzq88rshv7ro6e3RIqmbhcbFDIImEG9HovEFm0t3zRyPtnj8oCVS5rtaDCmOJ7Tw/7aJFN6HkTX4CJykJuVbXNbJL1n20IFzkd1lAkx3yky42YUm13joTKZYZuQIS2Q8RnFTZ7FQ7IpVVAE4ftL9sqhIt4g8V0SNmzoYJPA8DIUZorD0GYdYM7EH12pMnohY3scFJ0KyIunsKLd6oLiRjA9zH1QsrBR1OshhoY53htut51h6ZA+xyNrZFG71zkOyrzH0V25hm2Cn43hgmhXfsVQlm/G4WTF/Jy6CVhISwf8hr3vlwnxJE86sasW299nnqBoJ+8yjiac+tHxQ+2lopr/SLt/1PRvLKvq4CCeDCy8KJvD1E2ivCEUhK6n6Pcy333028Trp2gPIathbonG1WuNL5L66sdG7o9rFczrutcUegOmdNX1bXDbNGUAO7VkF0iHGzOsMgViGVmb0D8ipgeU3afbGFkC84rC7RqChszFmMbuCLzVpNRNTqmz0LLT/ucqn4IVtwj7wXdkxHDST3MNjefkVq/xxS01O+sdnsRoPFY21HF+iUhz3kf2kFJaNK1Nt/bCkHMxeDvD6mc813tQaByfcs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d450f53-8601-458d-384e-08dd6b8b23d1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 10:52:30.5641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7XLNta04T2fIc9J0xRPCIET6sQOVraL/GnnYEqZez6X593DQCPg5S7yaAsMzvtwPKYdsxH+1PkugsnkpgzkTdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4301
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_04,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503250075
X-Proofpoint-GUID: x8108fvsHwL6WPRxTTElACs6W28ZvzZv
X-Proofpoint-ORIG-GUID: x8108fvsHwL6WPRxTTElACs6W28ZvzZv

On 19/3/25 19:09, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> Recently we had a bug report about a kernel crash that happened when the
> user was converting a filesystem to use RAID1 for metadata, but for some
> reason the device's write pointers got out of sync.
> 
> Test this scenario by manually injecting de-synchronized write pointer
> positions and then running conversion to a metadata RAID1 filesystem.
> 
> In the testcase also repair the broken filesystem and check if both system
> and metadata block groups are back to the default 'DUP' profile
> afterwards.
> 
> Link: https://lore.kernel.org/linux-btrfs/CAB_b4sBhDe3tscz=duVyhc9hNE+gu=B8CrgLO152uMyanR8BEA@mail.gmail.com/
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> ---
> Changes to v3:
> - Limit number of dirtied zones to 64
> Changes to v2:
> - Filter SCRATCH_MNT in golden output
> Changes to v1:
> - Add test description
> - Don't redirect stderr to $seqres.full
> - Use xfs_io instead of dd
> - Use $SCRATCH_MNT instead of hardcoded mount path
> - Check that 1st balance command actually fails as it's supposed to

Much cleaner. Thx.

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Updated.

Thx.

