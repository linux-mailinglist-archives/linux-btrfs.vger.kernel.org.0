Return-Path: <linux-btrfs+bounces-9634-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9859C86AB
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2024 10:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E230A1F2570B
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2024 09:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7536E1F8EEA;
	Thu, 14 Nov 2024 09:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="n5LUhp7z";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Axx4c8vw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60931F7577;
	Thu, 14 Nov 2024 09:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731578201; cv=fail; b=bXGWL6ebReDaEFXmOVNRnYUZX3FD7Dd6LiCckFJiC6qrseuOpurjVcwuJ+OcQEPWuSs9e/AvB0rFQn3ik2mx0o+MZVmv5QNhGqWYzTruuQ6XoN0g4cmrF9jQFwJmryOtGMOB0DliTBVqDdFWiF+45RaBgvpuiknr49gMu+Nrpg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731578201; c=relaxed/simple;
	bh=EISaw3K4pjXyrMCbRxIohpbcWIUNC8Er6grUyAgN/WQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K2BHkZJhTZNgLyVbXTgaVDQKYhErYAW6QnUW9F5JGxj5/tZXz+SLNx70N5SI3GOLXu9385PKodBsRAvvzthSHSFcN5LePvJcTuoddBycFi1MT0n6erqfbaXTJFk4/RRD0eiTUPqmIi8O3vHa++iZIysB2jmoqpcyvvhmX+5GfSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=n5LUhp7z; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Axx4c8vw; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AE1gV9M002606;
	Thu, 14 Nov 2024 09:56:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=K+7EqGvQ2K+9z0XPkDmnMAptcLYxTxfJ33Xz0sNY37c=; b=
	n5LUhp7zQqxr/BD+PdbPKxn2OO5oy6cUBiaspmCImZGU/b8nMCdsb34LwaQPByuz
	CgjuyJUVs0Ctm1zMTguaYadPSsp60kKNHWER0BlbSZZtzVVot0I/gsnaVkKjFtWo
	w0u60gNouvytvRhl4GS+ekufO9WoZM6WP4W9X3G0/iUBTf9dOWWcMZW6ODc9I39Z
	LOBRsnIArrqjJAekmNI1R30/NOG9WsT+mbBcBtZkPhXSN8QTnn8GSQe087t7PKUh
	l0Nkv2fFjGwNa0JE+7ARjXj/JpVRJbJ9hFJ9RRmxBdwBXilEJD6AHez/LhB9MT46
	Zg3TicdFZnd1FOEgg+1gcg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42vsp4jguu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 09:56:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AE9dqoP005695;
	Thu, 14 Nov 2024 09:56:28 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42sx6axaxb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 09:56:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HkxjspJ2RKS0iVD4nKTjhMom6NsGg5qmcmwOHNtVZyr9/wtc33D2YugimtKZ7xG6NXYjCcRiKCOb+Q4/FqTsAmQGUwI/qHbe2QYBnkxLwPdW6mBFCjeyl7On/bh6E71zsqORebGbI0NNlUBqYuA3n2D77FyC4AOrEkhv1yt7uVKCQ0V4hx63M0wSHuwtvm5UsRHPjeqTffaXlRL07LY6gQC3I3ZIHetW5UyIflIlRAcyW3m4EMOLZvrW047D5+S1+Mqz1FVU85mxi0q/WkOljmFpJb++tl1nCRpCLmxKUQFc6sLuB9x8nqMDEIq499/i8uEZ1vTxzt2vdg6TLY28dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K+7EqGvQ2K+9z0XPkDmnMAptcLYxTxfJ33Xz0sNY37c=;
 b=rd8ng4uJCU42VjVxN6WiBigrDO/K8HGIAVV5hg9I1XDhBjlF5vEOaJDuu3t1rB0zrZ/2cpi2YwFpm9m8DmMidjaX+1+WmJTa3KsPeRuzOGSYDry+BEOeNJaavUzHrlieI9dHw4DRWpTbI3HVqC5NmR0hHsX2tvQatziSddO2DRF2S8GbUH+v07a/oiszbXLPOEsZP9vjgKbfPY9dLxlewTy68PpxcLJ1BEtK9iLLn007x4Xekku/PDIA1oAysJLV9Pqsc4wX3+TbEBmjdsfRVSFJGQ8PAKIpvHYU2Ut98PMRfyAeIpXNwItHnHkDO64JqflU71Hs373w7IILjVlB1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K+7EqGvQ2K+9z0XPkDmnMAptcLYxTxfJ33Xz0sNY37c=;
 b=Axx4c8vwE34OavHhTjSkhq44MqmW3Xn4Bx4fiSxpYCQMltBg+bJt97H1s1MxSj6v+2aJB1SBN8IeRGO6H2ejUF4fi4WqgYmbFckjT0ybVPhbck3ny/yNHRdRRwCnJXVINWjXW93WMVaJZ4ccJ46j2lmjM0m0Kwv36Yt49tb3gV0=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB6431.namprd10.prod.outlook.com (2603:10b6:a03:486::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Thu, 14 Nov
 2024 09:56:26 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%4]) with mapi id 15.20.8158.017; Thu, 14 Nov 2024
 09:56:26 +0000
Message-ID: <fdedcc89-6fae-4f2c-b1a5-6d5abf9a7cdc@oracle.com>
Date: Thu, 14 Nov 2024 17:56:21 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: check for ext3 support in btrfs/136
To: Johannes Thumshirn <jth@kernel.org>, Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <4c41adf81241f5d23b5a10251564b1630cabc500.1731327765.git.jth@kernel.org>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <4c41adf81241f5d23b5a10251564b1630cabc500.1731327765.git.jth@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::6) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB6431:EE_
X-MS-Office365-Filtering-Correlation-Id: a9ff3b5b-f3bb-4c31-13bc-08dd04929aa5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bTYwbGVOREY3NVdocDdXOXRaZTc1U2Nub1BZOUdmaUFNdWkwYWhpRS9CSnRS?=
 =?utf-8?B?MG5xaE1mc3hYdWdUUkNJc2lZRXNIMkM4R0toTk9ObWh5QXBiMFNOdDhIR1p0?=
 =?utf-8?B?ZEZJb1dUSjVkdUt3MlFObVhNdXA4M0U4N0g0UjVmc0ZWMWY4Q3JEOTd6WDlu?=
 =?utf-8?B?SnN6YWJ5aGdxRjcwOEgvOEJMVzVrenJKYmhsb0RZVTljME44MURZMDlqQ0R0?=
 =?utf-8?B?S3FBZGFnY2lwaExOckd0dmlDUTZYYTRPK1ZRdlNBUUxUWVdidWVYN0dxbjcx?=
 =?utf-8?B?dEtDNUJPT0dqRmZyQTlKamRDL1pNSmRvcW1EVnlEanl5MVJkTjNtTGVqNzZt?=
 =?utf-8?B?UTZKNjNic3ZzZGtTcnkrcHFNTm9TNC9FUEJOa25jcXFSYUJDTHVMb0RNNnBQ?=
 =?utf-8?B?YklHL1NnYlU2a3pnRENsUE1QOHlnMzU1VmpnZklrQUZ2MERMNkw1OXRIdkZQ?=
 =?utf-8?B?MXAvYzlUUk5SL2k0S2JCcndhb0dIRWxvQUZEOWtQaHQrWXdJaUhscTk3NjF0?=
 =?utf-8?B?ZWNGWHBORkJqeUYrR1hHUzZnWGh0dDIvQ2xHTEhjc0RXSjZZOWhMbTN4OFZS?=
 =?utf-8?B?QXNJeW85UHhEeTY1aE9Zcm5tNWVGY1VmWk9WbzVIL2Fhb2pCbGpjN0JtVEhH?=
 =?utf-8?B?NWd4YkJhTm1FTWE0WUlhd1I0Zk1QcENqS3d1L2cwemUrM1ZnclRGRjBBdHVv?=
 =?utf-8?B?Z1JOa0F4Qlc4MlhDeFpPVU5yOHhBdVZqVEJSb3hzZndJaGRQNVA0Z1d2Ylpz?=
 =?utf-8?B?cCtoMDNCczFiT3V6b0ZxQjJFZ3VpNy9tdVEvSHpIUlpwSndMaGVlOHhWZ2Nn?=
 =?utf-8?B?VmZTdEs5RzNMckFtcjVyc2RVU2FIODIweXhVU3l2Z3BKeUJYeUttckp5L3JW?=
 =?utf-8?B?SllmQ0FRditBQ0VMRnVzU0pPNVlJbWt0WlFmMXY1cmZidS9UazBCbGwydGhh?=
 =?utf-8?B?cnlsNFhRYnFkYUliVFY4RUtZVkhZU21CUm00c1pDcjg1SExMOFIzWm9vRE5r?=
 =?utf-8?B?RmFEbG42dmphNW56alh2SzhvNU4xZWlDV0VOdlovVllRQkJ6Kyt2MzlOenhq?=
 =?utf-8?B?WS91cjJBeDYxem5zQUpNWmZ2LzRCdTRLbzlZVVI2QTZvRkU1VzdTdzdGZTNP?=
 =?utf-8?B?MWFsYk0yc1RWTlpZOGV0VDR2NVlBRml1NTF1K1M1c3BLRWFtOVZNcjJ5TXlv?=
 =?utf-8?B?SXZURS9MZkdRRmFISGVSN2luVm9uOTZkNW92ZU5SNVFyUy8vdk1GdjQ4NTZu?=
 =?utf-8?B?QjhWaHlaamhhVSt1eDRaaFZSYUplWnFiYUJpRXZ2NjdwcVRTeStDS0xtN3pL?=
 =?utf-8?B?MDhDOXBFaVlFZFdJS2syRkxWcXJHdzI5NXpJVVZlUG5rODJiWnBxMFJnRVlx?=
 =?utf-8?B?N2FhVFYwRXE4SUhTNFBTLzVYU1dGNXA4RWYyK282dFZVdjM5TFU0QzR3TC9E?=
 =?utf-8?B?NWVlT0I3NTBmMlJCKzg1S0NyUXBsMmR5M1k4bFA4RlBTZkFUdHh3Z2ExbVdJ?=
 =?utf-8?B?ZFhCMkJjakpMMzJqRk9CcTFiOFNVUnFYZS9veWJoaGl1L0NoNTk5eVM2ZGJi?=
 =?utf-8?B?eFVFSmtMTkZpSGlqZkx2NXVaZzFFRVd4bzlBSEx3QnhEdDNmaVo5dUxSSXBC?=
 =?utf-8?B?emttVmVER1dYSVcva0tjRHp2S2ZFeUNHL3luZzJRUGZmTzRVcUw0bkJ0aDFt?=
 =?utf-8?B?NEZCdERaSkZ0N0RZOUN3T3lWZkF2TU9VWUVrL2tiTjY1UFNyMDRVaTRkYXRL?=
 =?utf-8?Q?YVu5RdkohRPNoUHPHA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NkMyWjltRFBLT2FENm0reG1PMXBTd0VzVmJCREtudlE0ZndXOFFhUEU0ZkpK?=
 =?utf-8?B?ZUlSK2RsWUxnVnVVakozWVpuQjdjTEZnVUVURzJhYVhzbjBGcCtoQWlvMHVK?=
 =?utf-8?B?blp6TXVMY1JlR3EwYnZYS3FlMWlZVzU4ZHBYLzducWdzKzcvcHZsOUFZWklp?=
 =?utf-8?B?dDExZDJ6eVV3ZjZXSGN1Z1U0T0dMV1NlZU9ZTkp3WkVXb3BBbEJDbTFJMWdw?=
 =?utf-8?B?cThLb0RDSEZ3MzdIV0twd0RlQUVrbTJid1UrblpyaXBXaVB0emVlT0MrZkhY?=
 =?utf-8?B?Z3V4dGZBc0YvN1ZPSXZZQm50Zk9oRlQ1emJOQUtUR3Q0TXg1NTZoOXFlOWJB?=
 =?utf-8?B?WkFwTmxCVElJRzVhc2JNZFptSmV1ak4rUUhFUEtvRUtOV1ViempHc1Z2R3Rr?=
 =?utf-8?B?MStlMlpGSGk1a0xsUHQ4RkpIbk14b0srdWRObzRiNFlXOVZCZE50NksyYWVa?=
 =?utf-8?B?ai9DMy93aXV3b3NzZ3IyaUR3U3RZOHBaUzZNdjdlNjZEbXpzN245SXoxcFh0?=
 =?utf-8?B?aWpNRkhIcW1aMGg2WVVxVXdhT2dha0hmY2pGcWk2MzdrQVBZOGJ5QmRhT2tS?=
 =?utf-8?B?MHRQRElrakdrZnBVcHRacFFUWmp5SXpCbUZvYjBBMVZjMEVjZ1ViODJieC9o?=
 =?utf-8?B?K1AyS285M2VaaS94TmpkYXVsaGFSdE5wUTFycGdqd3pxZDRlcElTbEVWSG9T?=
 =?utf-8?B?Q0FxbDkrL1B3K3doWUU0WjcwdWJMNmJaNXVDV01rbkNXVGZsbXhNRTdIQ1FP?=
 =?utf-8?B?RFFLTzZLTXpPREVtbnE5bU1YZm5idmVhaFB5VHZ1ajY1bHRtUlNFWmUzNVNR?=
 =?utf-8?B?UW5oVFFnZzNXY2ZYdXI4cUxtV1BKVGVKT1FpSS9LZFQ4U09FSnJ3OW03czdX?=
 =?utf-8?B?M0ZJbnNLaUptQlRhQ1I5MTZDd1F0T0pZUXhpTUdvV3NpMytoZGNGR2ZmUkNP?=
 =?utf-8?B?MVZhaThPL3RVdHg5TUpmQUMvTU5GaU5pcmtVaC8vYkVNSTA0U1NPLzg3YmNJ?=
 =?utf-8?B?Vkg4aDhXWDRrY2NXaFZDWGtrZG5UdnF4M0FvU1dXUkh5L1hoWlNvRkxSVDVZ?=
 =?utf-8?B?cGo3ZW9vaXVmWnpxdnNqU1UzMFd0Ty8vRlB0eXI4YW03elpjZzQ4S0VkM3VD?=
 =?utf-8?B?VDBwNjU4TkdlMlNDSTA2SDh4d0syR3BtRUlrS1ZZRDZTbWdCM2pmOGxCQXpq?=
 =?utf-8?B?QVlWYldvSlFFb0xnVE9TbGhGMkZ4ZHBJN0x0WGJ5UjN1UHUzN3ZpYTFCODRm?=
 =?utf-8?B?aTRabU4zeHVJR0ROZVcwUStwNllRK3NmSG9NUWlyVVVuRVh0cHVzcG03Vmp0?=
 =?utf-8?B?MkN0bnJUOGJ5SDFnNU1qTFQ5NHp4WUpOdW5OOXJtM3N6cktPWlNDYjVFb2lI?=
 =?utf-8?B?Yk80L1ZzMmI1Y1IxbndZaGhxTE1zS2NFU201OXpLWDFlQ3o5cEpRSEtIaXVR?=
 =?utf-8?B?c1I1MXdqMHFFRmNmMUdmYVpCVUNTc1F5c2Q2U2hkWUxIeExyQ1pCTE9vSG1D?=
 =?utf-8?B?ejRYazhCNnVuSUZjWFhYUTVMNUozdWRIY2JEMTdOOWpmNFQ4QnU5RFE0eHN0?=
 =?utf-8?B?VEpLUUVwUy9aZy9YZTZqU3FwS013Uy9YRzk0eFA3NVBqUkMzQkRadnhXVmxa?=
 =?utf-8?B?ZWZFZjFMS0VKaFpTclNkMG5xR2JpZm82aGZLWmQrcGNJMmh4bTVLU2pPV25Z?=
 =?utf-8?B?U21SMnF3dDltRll1MXFTcTJESkljckw2NlFESFRPV2NyWGxTRmF1emxrVlBN?=
 =?utf-8?B?ZmZKako1VWxaWjNIRUZhNVdGNTJpbCsvbzBvSXQ0RTM2emhvdnFJemx4VlM4?=
 =?utf-8?B?eUVFWGxFeUNqK0ZXNldLeVFweUJRcEovZ3dFZVJsMzVHR3pCclZxRml1M1BC?=
 =?utf-8?B?MStJZUtFQ2E1VnV3U3diY0p3ZWYwSnovaTVtTk9Va3puUEtobVNWRlltS0Vn?=
 =?utf-8?B?OW1YMFY3eXI5OTVnbnB5RG5qMERKMTEwRW1oUk8xelBDaStYZXJ2bHNUbTJ0?=
 =?utf-8?B?Vjd5VlZUR1NNUFB4UVZ0MjExeXFvaCsrMjVKaTlIMlZ0L2I5TGhEeVZDM2ta?=
 =?utf-8?B?UzhqaFRiSHZCVERwYTRkR2d1bDhNRHR5eDluSUFobklQemtTT245eDM5b2dI?=
 =?utf-8?B?Y21mcTlCaEFZdGRQWlgzVmVrV1RWdVo1TnQxMjV5bW5EbUYrNHBLdHliOUkr?=
 =?utf-8?Q?BByfdmRYeN2B9+NqB2+xcUk=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9yaA/YEO/1TQcSMo2lruiBuTg5xXYy2L7v1g8AIlIIJNVC/IsTCzKWPrs5UFqW/YEmhoseRhXbNX5pS6TnMuo+lB2B4WXNttpHmKoW62FJn/29o5L1qEE9ouXMoCWjF8H0ruxXDFYkXrYDF//vp7z7/lY0f9FjVQwPRK8kph+lI1fpw0zPcSQFcx/9oHuH1E9dxW5h/N0jf5nUazUEbf+a2igAe0quiSpK2ewhiVNkNZPCP3XYJZiEeudVZawJjVbJ/1ijeCc9BdhlvOopv1kDWiXMRYvrjNd1X33syvPkBTvOJY7N4Fz6AHa7Gy2Cach/lR218fTtoH56brLV13hKRwFHBTn3C2DWUgHe1fwKVtUiVcwGXwCjdpYswtKXVMm27pQnEzKl7/Axqd24tjuhH8di1qQQnsBPktkGkS4zCBYvbj4qtJkSWsfVzJfCrDBkrL553zH2GoV3j0JK5IqSu26CUYAo1j25ufHu/1WJ+g9eH6qyBC2Wrfo8UmHPNLy1X3XSfdSl/GGIXDmoA3vyAMtc39mfhHqUGbrx3G8v6n74zizaEy+ClIJgXCm/BUHgHQWcO9e5qZ+keAcKsWZj9cfPFqRqSNcrad3zW8prc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9ff3b5b-f3bb-4c31-13bc-08dd04929aa5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 09:56:26.6041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1XvjGqJwuNFRcEX7RKodo2rK5ABJMw5GztjtmdeM82G+I8vDQO1XIhHmXBdaZc6w2noIobc/2dW4wMvJf3VM0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6431
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_03,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411140076
X-Proofpoint-ORIG-GUID: UxmxglsUGM-VbQJuGSiHVQCfJ7Sul0Ar
X-Proofpoint-GUID: UxmxglsUGM-VbQJuGSiHVQCfJ7Sul0Ar

Reviewed-by: Anand Jain <anand.jain@oracle.com>



On 11/11/24 20:24, Johannes Thumshirn wrote:
> Test-case btrfs/136 requires ext3 support, so check for ext3 using
> _require_extra_fs.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>   tests/btrfs/136 | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/tests/btrfs/136 b/tests/btrfs/136
> index 9b5b3331119f..2a5280fb9bd1 100755
> --- a/tests/btrfs/136
> +++ b/tests/btrfs/136
> @@ -20,6 +20,8 @@ _require_scratch_nocheck
>   # ext4 does not support zoned block device
>   _require_non_zoned_device "${SCRATCH_DEV}"
>   
> +_require_extra_fs ext3
> +
>   _require_command "$BTRFS_CONVERT_PROG" btrfs-convert
>   _require_command "$MKFS_EXT4_PROG" mkfs.ext4
>   _require_command "$E2FSCK_PROG" e2fsck


