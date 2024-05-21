Return-Path: <linux-btrfs+bounces-5169-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1548CB299
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 19:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE0DD1C218CE
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 17:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5BE147C79;
	Tue, 21 May 2024 17:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MUOX1oer";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BnGdMAAT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2807F22F11
	for <linux-btrfs@vger.kernel.org>; Tue, 21 May 2024 17:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716311331; cv=fail; b=i231pOOV03f9XJHQXq68nJ2ei4Q3ixv0CHKRe3kWaDQnR3gzK3uf69y1SZrmNtv/hVYvR44gyjvDcfgRA2S/Y3uYcGXuE+oGB639+9XsxCSrPeKBcboLQrsPf7xj7L5GolxE27FUDP6hD+gFIAPmijbJ+1/aKyorRzTgbu0G57o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716311331; c=relaxed/simple;
	bh=QFAgz+Qn5fA078Rggs1ebG4GG6iKS3Q9IB1rQLPvWzQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uWsLiEk7EJcQbAV3e0o2Ujp/M94+6INff6RlKrDaGKMUQDN+CctJGkN1dfTwL/eBQuwo/p9M1XNwZvM1fBZkuXkEBCDb8T2I5bs5bwfdcc4kHlqd4fImomm1jLketwhSIGzkTFSSyVbkY0UuZdg+qCPYT8e8D5FH6//8YVsgHGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MUOX1oer; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BnGdMAAT; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44LGxLoU001520;
	Tue, 21 May 2024 17:08:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=wPUMNTfu4Xk9iPmZ0IY/InWSiDvouKx4PzjayH3HD34=;
 b=MUOX1oerqql/pG/FsJOsCX2Oig1CkC/D0Bt6iVYxpdu1hghLdY2BovFKKH8KBv5BmOv4
 LXjIwDwAU2xv4H/YJzdEDsCZMNwBUVE6CGUHtG9Qb62oal4aWBukzHegsZaZ1mLhH8LM
 RHePxL9pf8Alu8XoPweGOF2PKogxq5XkfyFhXOwQzYq3uvv+IEXtHcYx/Nci+MTp3/Hk
 dDThkCnwXwORKzvWbZgRVA5vhm3NRHY1ziwsuHmILybyogCy5yfk6HjG8SGLlddvxtKf
 YzxXz4Xjlb05peLTO+PNVg6YmwQIBX5i3xxvE2i98lHk19uEQt+0dosJetIr17EojIlG DQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6mvv5vkr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 May 2024 17:08:46 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44LGFJBm005024;
	Tue, 21 May 2024 17:08:45 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3y6js88m30-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 May 2024 17:08:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WWpXNRisLzEys6Hhyn5aI3HpoO83TCC56ZD4uDGzw3uAUIr/KgALfRM9pGxZ+JXhfizil7A82UaleQndehhKi/G1FYgL+OO1awiNJjQUhQl3dcEFVZ20AXrRpR5o8nlBOA41QeH+kQi7Zzi3O8Y4uDg291uWutyQK9pHZaTGVDpdrVOHDhNMCrRaeh8yqWJ5mS0zqWstETKwczNenrhFpXqSco/pLZOzsJZ0OKRzpDn5aSAutJ1Jv8Sbkdqer/z7qW8655PHL7J1yt6nq0xgLhtZJVi+jBSFzCEfKi9hZ6AwHIGSedrYL3pNmiY5iZmJZFPm/+QSd9XkQLYks/IS6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wPUMNTfu4Xk9iPmZ0IY/InWSiDvouKx4PzjayH3HD34=;
 b=mQxxyDgniuhDHgubpriwuhxSkgbtgcj3s9pk86hnh0H8vXD7OK+J1e2Nd1i7RjRKajv/jp1w+rkBE5BAd2PjnA3u7sewMUJUuaNDMdWoURjPSXJopxOJnhRJWt4aDJbx5Ib1+hiwA22+ebjU3KMo48SsbInDDJlW54+paDLFk0JkzMbXMvzX0SUcKi1tl+1zN2jYEsnKxYRaZKJbYB0LX5EaSn1q7GbIC9SYiaMjZjgYOIoZYbdPIAXcUUI+z0Zom82vi6oHcpw/tqUBra8nXFL7Wgx2Y0uj8Kg42gZR/ZHQsCzAhQf0RimfvNc5ask3MzJ51JUtrAbkxMCkffuGdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wPUMNTfu4Xk9iPmZ0IY/InWSiDvouKx4PzjayH3HD34=;
 b=BnGdMAATzYRR99oWVyzWURMwkfOH+DsuTUOcxPk25mCTob09kxFrJ8K61N0mIvIJEcm1/LNH7Nq0ctFpfSvc8p3k1vpVpp1eZ5XkNV3/1MQ4ZSkzUgGI06xIYRsOL0bFtasdcZfaW7oBcIlVZIP2qYeKh4lBwRPOC10AgxFd/hE=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CYYPR10MB7649.namprd10.prod.outlook.com (2603:10b6:930:c7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 17:08:43 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%6]) with mapi id 15.20.7587.028; Tue, 21 May 2024
 17:08:42 +0000
Message-ID: <c7af6d05-1abd-4d7f-b65f-23bacb538855@oracle.com>
Date: Wed, 22 May 2024 01:08:34 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] btrfs: btrfs_cleanup_fs_roots handle ret variable
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
References: <cover.1715783315.git.anand.jain@oracle.com>
 <2a831fc01d65612914702b968174945f2f7e1c79.1715783315.git.anand.jain@oracle.com>
 <20240521151050.GO17126@twin.jikos.cz>
Content-Language: en-GB
From: Anand Jain <anand.jain@oracle.com>
Autocrypt: addr=anand.jain@oracle.com; keydata=
 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
 y4F0QrzFk5Hg4pvnpDur6Cbp
In-Reply-To: <20240521151050.GO17126@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0112.apcprd03.prod.outlook.com
 (2603:1096:4:91::16) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CYYPR10MB7649:EE_
X-MS-Office365-Filtering-Correlation-Id: 223898e6-fd63-4ee3-4d0d-08dc79b8aabf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RnhJNjBtU1IvSmJxek56VURYcUZ4Q080RVlidHowZlM2Um5Zc204SkZjdUtD?=
 =?utf-8?B?amJsU3l0UWx0c1JPQUM2enhPQnJSbjNiTGZ3UURqaURaemgzaFdYVEF3WjVF?=
 =?utf-8?B?dHdWdk8zWmFxT0lMOUZPUlpTMTZ3c0tXNWVnU3NkYkczMlZlT0VRRmVkSlNx?=
 =?utf-8?B?UzRHYUc0VVZhQ29QWVRLZWZOK1RQTjAwMmVleXdONWwzcUtkOWd4ZkJnTllX?=
 =?utf-8?B?Y1B2LzNiS2kxTDZGK2g5bDliN2lncDF1a0pQYlYrcXlRdGEvbTkzVmtPeTA3?=
 =?utf-8?B?Zmp2OTJZVW1DalVidVhqU1l3OXlNckR6d3FocE9vT2Jvb3Eydlpkb3paOFhR?=
 =?utf-8?B?YTNYaWNORDVoYXhjQ0RpeWptMFNGWkNNUWNoUmVJajk4T3R2RjlEcVZvcDVP?=
 =?utf-8?B?K0R4Tkw4Q2dmUHdzVmZ3eUt1aEV1UklYSjhIVzVKUmU3OWh2Z3VrM3F4ODNH?=
 =?utf-8?B?d3FNL1E1WUp4bG5hcXpHSTRLWkxnY1ljbnRKd0RMT2U2ZXd2L3M2UTFEMisy?=
 =?utf-8?B?UXlTZHNIVUlyYWNuMFJrUnQxdG4zY0tUdzNHMSs2cEJtZ3BrTEtCM2x4Ry82?=
 =?utf-8?B?YmZITDVJM1ZYb2ZnZjZ2OUZsL25YMUJLdDVaWG1zSmt0TUVkNnY0cUIzSits?=
 =?utf-8?B?WEswbnFidDJUQjF4UytXb1pMYWpNVi9ubENuVGpOSnh0VUtxNXMybTlEMEVP?=
 =?utf-8?B?Q0tLdWpiMTMwekJoUGxOVXp4TVZ6YmhWUWZ1dkRJczEzb282Z0tXRDNHL2tU?=
 =?utf-8?B?NFZ4MklPaGJiQ0Y2ZlZtL1dXQ2d4cDJORThGRVlGdVJRQjFQdkFMOHBkRmdr?=
 =?utf-8?B?RUpoZW9LaEwyMGRRNjRldEFkdzQ5aEZZZTRQNDlxaTRmRkZhdmw3bndyR2dE?=
 =?utf-8?B?ZHhWRnRFVnNaZzR1WHhVeWNRRjlrU2dvZ1pIWU5TbTJXSWhJTHYxQlFPcXRU?=
 =?utf-8?B?STM4ZE5qZTZMV1NCUExQUk5sOTVOcnZ3c0I1VlluQ3dFV21zckI3ekF3MXFn?=
 =?utf-8?B?OW5hN25DSEg2ckxXT0FhbW5qUjBTMUN2c2F4MkxlZnNYcFNldFdFaHBCaXhn?=
 =?utf-8?B?VnI0cVd1ZGlkZ1dzTm9zUlpKbUNQYkNRaVIwbWVBSVFtWWFrZTd2eEtYTEhx?=
 =?utf-8?B?Wi9mN3JCdXEvQzUxU1puNXFjYzNraUNkbWNLYVk0S2hYUXVxelhpYkx1Qnhy?=
 =?utf-8?B?WWNYNmY4bnNJOUtjMGQybjF0SXlBYmFCTGlyU1NtdWUyeXQzdENqL0VjYi9w?=
 =?utf-8?B?R1FjYTRCZ0NoQVpHekpSMjhEVlVjRllpWHRXM29FTHVHZktpZ0kzRHhMejB0?=
 =?utf-8?B?OHk0RTY4ekJrT3FMdmJ2ZzlySC9oZld1NlpKNi94QXFMdVZLalY3SDh2NWp4?=
 =?utf-8?B?VHhUTm1FSW16dHBiU001SVkvUTZqYWEvUHVpeUI4WlZodzdLY2NLdUVHM2xE?=
 =?utf-8?B?bVpQRWJTT2hkN2pubklMUFoxNjVkczFHVGZ6Sm9ObS81ZWdSS1ZneGJXQXhE?=
 =?utf-8?B?Y1hrSk1pbWU1YkMxZ0pNd1R2Zno3NGF0d1BSaXRQaXY2NUdsK0hnekVQODUy?=
 =?utf-8?B?UUo2Ylc0YktMYnBoYUtTYUN5bGJMck9EY3RtVDM0U2U4cU9JeDNVS3N4QnQ4?=
 =?utf-8?B?ZXNweVkvQmM1aHplL2VTMWdxNXlhdnRKVkJCR2pqSCtLNWduYkNWOFhVcGtS?=
 =?utf-8?B?bEdjdFJaY1BubXpsLzE0TXpVSDBtY1FjSFVEeG1DNjZzRTg2bUtkRWhRPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YU9YZm1iZzExOE9WT0cyV2tmRDZlMlRzZXQ2VVVHQU1weDZTRkkyNUUxSjNt?=
 =?utf-8?B?U0RvQmRaS0U5QlRMY2cvQm05OWd6M2FlSm5nOUhtZkhWRkIwYUM0MWRmbmxY?=
 =?utf-8?B?V2xmNVlVQ1dzc1cyb042VEQ3aUlhazgxdlNUaEY5eHJrRHB4ZzRUbVoxTHlo?=
 =?utf-8?B?NExRdi9MT3hwcThWNzlwdHFlamRoLzVaZVNFbGhyWk02S3NpN2Uwc0orTW1C?=
 =?utf-8?B?QkZyaFdaU3piYjNRL3UzaDg2MTVSU253anRWbXJxRzJoVFRyYU9nR0lkWHlW?=
 =?utf-8?B?ZmJtNVhBYldWeTZNNUNXZFgwWFhsckpySXdHM1BZQkdpbUg3TFBUUHU4dVhZ?=
 =?utf-8?B?akt4L3U5cFBNMGVuTm0zdzArdk5aUyt4V295Z3JIWGpNMHh2SWdvQmlaaFEw?=
 =?utf-8?B?V3pFWTAzeXkwRnZacHo3TUMvNmZaWnlMOE44dktZZm5VL09uWldRNVBnWEo3?=
 =?utf-8?B?NmxUZDJZZ0M4VmdUeEJKdWR2M0ZPRU53N0sxK1Q3eFJLeit6RU9ySWhBMHNr?=
 =?utf-8?B?b1BhdFlQb09ING1vWm1raU93UXpqeldIUWN1RDlxUUZCS3VMZldiUldXL2JK?=
 =?utf-8?B?S3EzRm42SnViMDlTTmlqUjRsdlJ4U3J2cGlsS3Zya0t0U3I0UVM2RDROR1d1?=
 =?utf-8?B?aTNvZC9hOE5MT2hhY2VVL2RXYzJkc1RDRUFMczZZcUxodyszbDFPT3dGMW5S?=
 =?utf-8?B?bE93dUd1QmpFK0dMMHEyVFgzSExCOEVCaVRFNFV5VmRTam5Hc1VHeUVNRDcv?=
 =?utf-8?B?bVlxSHZWZ2EwZjF1WWdoVVJHSGpyeUJ0NzZZalFXSThKcjFuc3Y2cGRCdTVt?=
 =?utf-8?B?cEJMNXl2T2hLdlpTTXo1NnZTVXlIRFcvWVVYRUxKZ0dDWi9GQW5VTFJwMzBE?=
 =?utf-8?B?R2ZGeVlVZFRMSGQ0QlpyZVFBUkIrVmlUUkdaWjhTUnhZSnJqNUFYbEhGbHlP?=
 =?utf-8?B?aXBwSENZY09UbmlKWWZlTkxwc0cxeE5TUndML0FKMldXZ0JwWHUxT2hNbEZP?=
 =?utf-8?B?NG8zcXRlUHZHbzVWS1BCL0FVaEdiVURNYkgyQmxwZ3lWWEZwQytzNTB2Ujlq?=
 =?utf-8?B?dlBFT2ZZb1VwZVcxaUdlMElyRjR5eFBUSlNUQ0hPZTZDMi9HaEszR1dqSjlh?=
 =?utf-8?B?elV4K3Z2YzhhMlc0Zm5qWUdlNlM0Ym9ITkhBcW1RZW5TRmZzRWJaVEhrNE42?=
 =?utf-8?B?MnBlTStBVW9VTGx3TjJOTnVlMXBvVG5CdEM2aVhBcGRRc3Q1RG90YjYrLzdo?=
 =?utf-8?B?YU0ycklQaDRWU2ZkcnNGb090anR2Z2R2eHVTeEhYVHJhc1Q2YlRBNkI1YVZV?=
 =?utf-8?B?c2J1aWZ3aGdxU2ZUOTY3VnVKaWVWVnh1RUptTyt3OW1SZW1Id2pyMUxIekxP?=
 =?utf-8?B?R0twa1pZdmUxR2M2M2VTSlEyUU5lRFRvZjVaNHNZWktiTEFZcEs3NmU3NG9L?=
 =?utf-8?B?bkp3ejBSenhCTTA0a3F4UnA1MVV2eFAzUmJiVURLRi9xTUFpS1ZNSFNzRjNw?=
 =?utf-8?B?SUl3L0lQdGVnL0IxUG5HWTdhUWw2dDhmcDArU1FEZGM3OE5MWkVQRzB0NXIr?=
 =?utf-8?B?Z0NQb0ZzLzE4SDFGRDJwdCs4NDZoWnozdVJmb0dYMGVyYTVaWXMwYUE0Nkli?=
 =?utf-8?B?U2NmNmpPZVBZL2UySXM4Q2dac3RkVzFPTDZxZzdScS84cCtqalpuUm1WVHdS?=
 =?utf-8?B?Sld2aEVZVGpXK2l2alNiRmhGMUVpUXBRRHhLNlMrd0lhREJCM2R3bDJvVGhl?=
 =?utf-8?B?Zy81ajdDbGtUa2F3MzNaUi9aMXY4YXFZV2ZjM2xRcjZ6dVh6T2tZRy9DME4r?=
 =?utf-8?B?MFVPRGZHUXpQeUR6MmdzU2RTM2pzTjBvS0RscWpGWkcybHdIMjIvbmJ4aWJh?=
 =?utf-8?B?SUZFMkxDYnQraVFncUhHZzRYVVJRQW9mZ1BWaWpOWDd4cWxkVjh6Vnd6MnpD?=
 =?utf-8?B?MjBiaGZXUUE3SFpuc0w3OWwzSHppUU1xWVBha2plbEkxYi91UDhETnVwM2hz?=
 =?utf-8?B?OEVxNlI3TlRGYjNlZHl0cEVlQVA5bEFpTnc2WHRON3Q5R2ozbm9GQ2VxR0RX?=
 =?utf-8?B?TExWeDA1L216KzV3NXdXcnlWbDlpV1k2dUhpeHJNeFl2eEZMRXoxN1JZaWgx?=
 =?utf-8?B?NTBPcWI5bVhzRVlDaHNOUzBzYW5NSDUxYWlsNTZnanhsUUMrNSswYUV3eDBz?=
 =?utf-8?B?Zmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	6k7qFxn/pMbJMxQK4lTXT9vr9P7HZWQdHp1i9LUv6zcoLTOxR7XdY+hZ5lsyUH4dOB74nz2P4fFCh4IC2eWnNfbhldxyxUNHHBKXFPat2Bf9gMThjp12gIjeob8ITjwcAnVz2JmSC3sgrgylp6s/UenNLNIbTnejXOBehu8K7k9fJmYpaUXh3bAX3B7pIdeOeClkVSudqBI9dUbKnfRXfoNbbMBZ4GJwdTsxKdNipAmvxFUmzkkqhzt86fjXgyl2K9JKJQ/iecrvKq3Cgq8JV9s3nLeGcd2MZRkzkjqVtJo93BrOwDpkro9u3CrXJK/PkDWOp3rIGk5mP1F0QXdc3zBoc7D4jLkGP+knfyFW35yPSxSeW26m7rcXilNMpNowc6ZrkxBUq/nKaaSjOiRhz7p1J3ucQbk2Q14rAXBeSalXRXODYi9bsA4w4V5C5ipT+IdGHKUFddweD2bLxLe1n02xqFAo+77+5XqWhG8N+fOjbSkh9yIk4ImBbaC6g8fxrD5uO1+F45ytDUjqMSonTG044e+JBuh4/oO5sQaV/icxOQkHsdNRrvSmii8vAw2Iz6rp/yGE8cxPZMglVzjAoEe/JG48CAuNsvMq6V/kTJQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 223898e6-fd63-4ee3-4d0d-08dc79b8aabf
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 17:08:42.8521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: szzRRwOR7Roqzksv3r4TGtzlypBP8yl1m1DLOtTmbdkFPH3TNF0/Z+OixMgYNiZEbmRf9VfakhenyewFbolNGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7649
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-21_10,2024-05-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405210130
X-Proofpoint-ORIG-GUID: hIXqGVhl6d1gAI9Em2v_0oU8Bl8ubDDk
X-Proofpoint-GUID: hIXqGVhl6d1gAI9Em2v_0oU8Bl8ubDDk



On 5/21/24 23:10, David Sterba wrote:
> On Thu, May 16, 2024 at 07:12:10PM +0800, Anand Jain wrote:
>> Since err represents the function return value, rename it as ret,
>> and rename the original ret, which serves as a helper return value,
>> to found. Also, optimize the code to continue call btrfs_put_root()
>> for the rest of the root if even after btrfs_orphan_cleanup() returns
>> error.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>> v3: Add a code comment.
>> v2: Rename to 'found' instead of 'ret2' (Josef).
>>      Call btrfs_put_root() in the while-loop, avoids use of the variable
>> 	'found' outside of the while loop (Qu).
>>      Use 'unsigned int i' instead of 'int' (Goffredo).
>>
>>   fs/btrfs/disk-io.c | 38 ++++++++++++++++++++------------------
>>   1 file changed, 20 insertions(+), 18 deletions(-)
>>
>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>> index a91a8056758a..d38cf973b02a 100644
>> --- a/fs/btrfs/disk-io.c
>> +++ b/fs/btrfs/disk-io.c
>> @@ -2925,22 +2925,23 @@ static int btrfs_cleanup_fs_roots(struct btrfs_fs_info *fs_info)
>>   {
>>   	u64 root_objectid = 0;
>>   	struct btrfs_root *gang[8];
>> -	int i = 0;
>> -	int err = 0;
>> -	unsigned int ret = 0;
>> +	int ret = 0;
>>   
>>   	while (1) {
>> +		unsigned int i;
>> +		unsigned int found;
>> +
>>   		spin_lock(&fs_info->fs_roots_radix_lock);
>> -		ret = radix_tree_gang_lookup(&fs_info->fs_roots_radix,
>> +		found = radix_tree_gang_lookup(&fs_info->fs_roots_radix,
>>   					     (void **)gang, root_objectid,
>>   					     ARRAY_SIZE(gang));
>> -		if (!ret) {
>> +		if (!found) {
>>   			spin_unlock(&fs_info->fs_roots_radix_lock);
>>   			break;
>>   		}
>> -		root_objectid = btrfs_root_id(gang[ret - 1]) + 1;
>> +		root_objectid = btrfs_root_id(gang[found - 1]) + 1;
>>   
>> -		for (i = 0; i < ret; i++) {
>> +		for (i = 0; i < found; i++) {
> 
> You could also move the declaration of 'i' to the for loop as you move
> the other definition anyway.

Yep. Done in v4.

Thanks.

> 
>>   			/* Avoid to grab roots in dead_roots. */
>>   			if (btrfs_root_refs(&gang[i]->root_item) == 0) {
>>   				gang[i] = NULL;
>> @@ -2951,24 +2952,25 @@ static int btrfs_cleanup_fs_roots(struct btrfs_fs_info *fs_info)
>>   		}
>>   		spin_unlock(&fs_info->fs_roots_radix_lock);
>>   
>> -		for (i = 0; i < ret; i++) {
>> +		for (i = 0; i < found; i++) {
>>   			if (!gang[i])
>>   				continue;
>>   			root_objectid = btrfs_root_id(gang[i]);
>> -			err = btrfs_orphan_cleanup(gang[i]);
>> -			if (err)
>> -				goto out;
>> +			/*
>> +			 * Continue to release the remaining roots after the first
>> +			 * error without cleanup and preserve the first error
>> +			 * for the return.
>> +			 */
>> +			if (!ret)
>> +				ret = btrfs_orphan_cleanup(gang[i]);
>>   			btrfs_put_root(gang[i]);
>>   		}
>> +		if (ret)
>> +			break;
>> +
>>   		root_objectid++;
>>   	}
>> -out:
>> -	/* Release the uncleaned roots due to error. */
>> -	for (; i < ret; i++) {
>> -		if (gang[i])
>> -			btrfs_put_root(gang[i]);
>> -	}
>> -	return err;
>> +	return ret;
>>   }
>>   
>>   /*
>> -- 
>> 2.38.1
>>

