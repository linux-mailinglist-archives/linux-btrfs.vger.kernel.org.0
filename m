Return-Path: <linux-btrfs+bounces-5269-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A36318CDFA4
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 May 2024 05:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 627E5282E76
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 May 2024 03:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B922E3E9;
	Fri, 24 May 2024 03:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lanUPl8/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="b95Q8NC/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6543838A
	for <linux-btrfs@vger.kernel.org>; Fri, 24 May 2024 03:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716520176; cv=fail; b=i+PZmkfg2AD7Zaiq7oPM5KaUJc9x//bJvp3wUUFJZw/1zTucbiUtSkfXwCxP06qvUQRcHO3Zgy35S35Rp9QvtR942qhmtQppbCM9A4fdSg/+simTpDvuc/wv8m+5zXLz8SWTmc4Ir1gMsV02jDBQSTyKhaaQV758/h7Jjoi3x1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716520176; c=relaxed/simple;
	bh=0Q0SqmaimpGDvSj0Q9Bv2U7dKE0P0Z+0dOC3cgPWtGk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mxc+xAXpWlAoxUd9gVyxaT7I6Pk6614V1oMCvJqg7nm6e3iLQqZdVCGei8qzKNqVA+yuoSD+QzlSavlut405bbw/jBP97f8FhLwtQkJz11hb0roEDq25XAc/3H+tRQW/jqPTKYdvbu9oPplPxghcQghhJ65voAv8gk4mEXnOSBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lanUPl8/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=b95Q8NC/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44O117a0031993;
	Fri, 24 May 2024 03:09:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=xGdlup/FH5l1MuDiNpylDaL6bvd5lIvs6KH1yRvgBi4=;
 b=lanUPl8/iHHd5nm1JA4IdmfDTlBeivSybkU3LoX3riw4RAZMtdQAn0lARK69zQWOECD4
 +YId35MrIhJNkESLaOxdtCGAl/ks+xsyu52Q6NxIpFXG/+aNMgAx5NsflNj5uj8WkSZP
 R78aNcGYn6UoraaOTRwz3t8fbRcsidlEvTITuvRcjYpjLQJEp/ZAFTRncQ8BgiJyHZQ9
 EzberrWmrinDyEkJZfxZEU1uFxguQLzdo3J4lpG7xq6QDU++dofMYWsz+ztKq3zDOkWQ
 /rrQBuJUny3SAcCRE7On+1vmx4/PQ2qFOHww/nggmUz5S1QY50BuIEvrMMyrMod15BEW FQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6jx2kfc1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 May 2024 03:09:31 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44O1YDvj013845;
	Fri, 24 May 2024 03:09:31 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3y6jsat616-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 May 2024 03:09:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kmh5+8oP0ObII/kUGy9Q9VH9yw4BvP2JjP+6yFNrnwO2pnFOHgASJW2AXxPV0tzhkuAnGXt34/7Y5f4XGG2llIUOICWNsYTNGcrTjdGz8khNeqHnlkUBC9W/k9U2OvDlnm8ipo5hT3fnNHiRkOES+McGsyLERVoiyQE3fvw5bv/attWLQzrqJ5XwuXWCw8wFPZA0HZXVZ4GZzIBJvpuIPtxgaxhlgxbvoAbjTewFjOGlT/IH4hIOhZoxx3u6QuwB+v+qYMWodZMVsgbpBPEXZXvCEwkwkXw3kl9TU6W6GyhF3QT6YXJdR2/SXT74mknNObZBFEZ587encK8NHX6rxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xGdlup/FH5l1MuDiNpylDaL6bvd5lIvs6KH1yRvgBi4=;
 b=kiwuVoKaDm/Hoe/5iohj0cSFmYs+NO8whCexBMw5beb1S6AyYdQfkKqxbLXS/U3y4LcRwPFSde9Fq7s/Ce2QA9Tx08RqCnONEUy4ccyqXj6gFAnsbESUm42BgHS9/8qY6hT3YtX4AqyVSvndMfDFZoHuEPWH3/ivd7wwBWC+3NcRhAyaRSqys7FhOktBHgS4iUbp99s+v/kALLBZ9LU27awWPGWdw+xi055h51leXbWguNkpTk4twjgD3yCCcK2WRYXNiLU6Awo96NxznSQyoERaqcbw9CPhAdnfoM9kQo5VAljBCFzrrS9ed5x3l7r8hhMbNwBcfKM6ovJv/ny0Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xGdlup/FH5l1MuDiNpylDaL6bvd5lIvs6KH1yRvgBi4=;
 b=b95Q8NC/gH5cG/YoqIoEppGa8TkPO0dOSc57SsGTqffDNuxbYnvs5D7anWc9zaZjO73Zt1wcMuRzBE02e7LR7ienIsH/KUR2BC4mF255++R5scE4Hu6NxdP+nQGU2Mrqt8aWRuDwkC+rnkczrIieXHob1D1jOZIWAD9srnTQ9n4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA1PR10MB7754.namprd10.prod.outlook.com (2603:10b6:806:3a7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Fri, 24 May
 2024 03:09:28 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%6]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 03:09:28 +0000
Message-ID: <d007c586-58e0-4391-8466-e7f615daaa88@oracle.com>
Date: Fri, 24 May 2024 11:09:23 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/6] part3 trivial adjustments for return variable
 coding style
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
References: <cover.1716310365.git.anand.jain@oracle.com>
 <20240521181003.GT17126@twin.jikos.cz> <20240523171825.GF17126@twin.jikos.cz>
Content-Language: en-GB
From: Anand Jain <anand.jain@oracle.com>
Autocrypt: addr=anand.jain@oracle.com; keydata=
 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
 y4F0QrzFk5Hg4pvnpDur6Cbp
In-Reply-To: <20240523171825.GF17126@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::17) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA1PR10MB7754:EE_
X-MS-Office365-Filtering-Correlation-Id: 06e7b4f5-c8dd-4e63-51f4-08dc7b9eec7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?TGZyNjY4dDYxcnlHbEkySFAzekFTOGNaKzNReXNubVhxMm0wU0hmWEFkb3ZV?=
 =?utf-8?B?TmlxZUJMQnIxUXVEanQ3RWQ4Mkxtdm50NjhvVk9FaHkwZ0EyVXlESmxDSm1z?=
 =?utf-8?B?SDlzdkhmZUQvUEhyTkh1azc0cS9oV0p1a0Q0aE5Hb1F3ZHVldGFOTlRxWWta?=
 =?utf-8?B?ZUtSbjZtOXVZU3RHVXFyaE9QY1NEczkwM3lHcjdOa2M1Tjg2Y2F1dUwzS05U?=
 =?utf-8?B?b1dHZWJNRlA5TjIvaS9vVzc3WCszdGRFeElzUmZ1aFM0STY0VGdZMjFPSGNE?=
 =?utf-8?B?bUhmdE83ZHB5NDVaR0orNjUxT2pCU3ljYXJwb3N4L21HVmRFdEdsQ2R2SjFu?=
 =?utf-8?B?YktkSkM4Yk9KaE10aVJqM0xGYS9PWFY4TWRCaUJVWk8rbSthdlh6Y0VYM3gy?=
 =?utf-8?B?T2IrTGdUVmc0Q2l1d0RuYTF1V0NMNS9KdHpYQ1VHTHRSencwd2VrUlFUNGl2?=
 =?utf-8?B?NitmbGZoVTZmQ0xCcTJyd3FVSUFRMnRTRWFkMVFvUmtSUHA1cC9LWUxyajlS?=
 =?utf-8?B?d3M5bndIN0loWUdqMndrdWFsTFhBK3pPY0JKWlE5V2pJaEt5L1RSMXNPYy9G?=
 =?utf-8?B?MG9wdDQ4WHhjVVgxSnRLR1c0ejJNU1M3ZUwyVisrdkl1N3MwczU3V3A3d3h2?=
 =?utf-8?B?Y2F0MzluN2dmQXVxYlFEdXVpazE2Wmh2MERhalJocGZhTzY3RVJLWkl1bTVL?=
 =?utf-8?B?STUwcmxYUEZyTmxNaXRvZ3ExODhJOUVuUHFyVjZ5UE9Tb2ZyWThxM050dzZn?=
 =?utf-8?B?ckpVZnA2amVTc29VVGhSdEo0bUlTSmlRay9nK0YwSWIxQXF2SVIxSTRIR2I1?=
 =?utf-8?B?alg2UDlSWk8vTDBNU2o5ck1UREdYdlcxeGwvY01udXJWcWtNS1RKQ1BNZ2Rl?=
 =?utf-8?B?YStKLy9WQ3VvR1dnZlU3SHpiQ2owL0VGYlBKeVRLVUZvWVc0UG5JK0pDazE1?=
 =?utf-8?B?eFI3R08wMUszSldQdlQxZFNkdzkrNEVZY1VKSTNON3pDMDc5WHRqdnpqcldN?=
 =?utf-8?B?R2NYTDdtcDQwQXRrNjMycElodG84MnNDZWhMUzNuZm00VTRVZWZ4NVB6V21S?=
 =?utf-8?B?aFY5VER0eXJGdmxuTlBzMGNuT3owVUVrZ1NrVWJHa2dtaUlQSUFWRXBaLy9D?=
 =?utf-8?B?ZVk5QUI5M2VqVHNxQjlJU0hJTGthYnJBeU9DemVDZjBEK05aa0x2RTQyUHM0?=
 =?utf-8?B?aEpkTVNFdTJuZ2pUYVZRazRrc0VLK053U2tJQWpDQWM0VkYvb2NIZko0Mkpr?=
 =?utf-8?B?bkx0aEgzWDB4OW5aWExJckExMUpSaXpDTEdMMkJ3QmtGZHgxa3dseFlpVHVE?=
 =?utf-8?B?b2ZCVmZBVXVGdlR2M1hTS083eGFVTG9BOU9GS25BWWVlbHh6VDkrNTFvcnpV?=
 =?utf-8?B?VjJobXY4NWxybDdnWHNSMFJqQTZvamRaWXAzQnVWRmVaMzFVczNrWUI3a0Nv?=
 =?utf-8?B?akpLdTRBUW10RDEwMHRTNFV6akFSWko1TDJDWHkzcXJiQmRoMFBWbTdvN0cr?=
 =?utf-8?B?RjJ3ck9WdGJubkluRkNIRmpiUk5XZWtqTVc2YVVDbU5DTE9La3VjZk9aQ1d6?=
 =?utf-8?B?MEFRcG5JYnp5WUZkT1dCVW9xR0V5ZnZGakpTenlyRUNTQjVBYkFIaDZ1akZn?=
 =?utf-8?Q?mhicUgtRimadXeBHg/Ourz6h7QmiOTpfE8rlkS10A3xI=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TmhwalZlaTRDUnVPT2FwUE1YSWVrWit6SWt2c3pCRllqYjlUWnVsTU1rT0RV?=
 =?utf-8?B?TFk2MkVLUGhBVzEzTkQyYkVFbzVObTJNb3VwRzBpdEM3TjdWOWg0bnZUcmtG?=
 =?utf-8?B?eEs2b2k3eUpGOTgxSHFWVDNBclhKZ2s0WTl4MkRKckc4a0RYSHJDMmE3MFdD?=
 =?utf-8?B?ZWErN0ZCZmNhbnZGYno5TVFTelZ6TjdzMlFyRmV6bFhrNjRZZDFxSkl6UURK?=
 =?utf-8?B?dktqak1YY21pdjE0VCtMVmdlbzgwS0xFTUFhZTdPdEZzcExIK1M0Uis5MkRR?=
 =?utf-8?B?M0dOWHNMNnJ0QU1ZVlVCem05VUh2YlRmays0a0lIS1V3QmNoK0FFS1dOSkVF?=
 =?utf-8?B?eHppWTJPN3l4NEk3MEhXd1c0K0tPMUUxbDRvak5IbkNUcEVzVllUMWtQN0ZX?=
 =?utf-8?B?aFNLQk13ajVkU2tnTWk5cmJ4aWxXSXBtanZBN0t2cVQwTUdlQU5YY1dtaTIx?=
 =?utf-8?B?OXdTa3RSb1hqclp0bVdyL0MxSkdsQk1Fd0tZUGc0TytCVUREc3I2S1lQWUpu?=
 =?utf-8?B?R0pvZFFNQ0pFS3FBYVg4MXRFV01XR0ZQWHJqSmpMQ2dWemhqNFJ2RnpRZExJ?=
 =?utf-8?B?QVF2WDNRVjVaTHpUVWJFaXlGdnRCNFhIMiswN2Q0eHArZGRzVWRsRUxMYWNH?=
 =?utf-8?B?R0IwUWdCbnc1OHpuNjRZSDRqckhZZHZLbTkrVUFYUVhvT0dJbGhoZGJrTU5y?=
 =?utf-8?B?di9FTURManNUMm1vclVrK0d5bVhjUjRDbEdxWE5qWityQnZGdHZic2ZLcHBM?=
 =?utf-8?B?TWNOTlJOcEovVVA1MTB5eWVQM09vMjNCcHdrOVQvWWJaZWN4UUNNamdOOWtB?=
 =?utf-8?B?TVROcTNMdmxJTHYxUnZZYmdMQlhrS0R6YVVWRUVWRlp4a2FHUUNONzVZM25j?=
 =?utf-8?B?Ty8vQStuMkk4aTNubkhTMktnZ3FoVVJVMEU2ZFVBYWxXQ1Q0dmdVMkdVbnhN?=
 =?utf-8?B?RzZ1SXcva0xnUDV6L1hySzJqMDFXcnVHSWtOU2FLb09JTEZDclNxZEdCYjNw?=
 =?utf-8?B?Y1ByOW53ZFpXaXJYa3ZueHpoaEltY2dhUTVUandhNC9sSHBQSTNDT1k2MG1o?=
 =?utf-8?B?YmFpYTdRS1dyVVdZMzIvdFZLazRHb2FJbE82WUZneFgyWVJVS0dONHZvYWFQ?=
 =?utf-8?B?eXpCcUZaRkphTnlsY0VwQ1Iydzhwa1piVUFrN09Db2lFYWV5SitNUjVlVTZX?=
 =?utf-8?B?dTlYZU93T1d6SHF6NSs4dUdtcFNCb0dPcU1vaEo2cGhpUGFVc0xUWWVTcDNS?=
 =?utf-8?B?UC9ReXpWSEljZ3NSeEF1Skxublpwb1E2bHNRT2ZtU3hZTHpWRlFKNnIwbitU?=
 =?utf-8?B?bWM0NlVQblFSZHh1YWxKNW4wK0l0RHczTWZEUFA2SzhJZ0xmamtiQXlYK1Jk?=
 =?utf-8?B?U2pZYmpEUk5vZHE3TmZHclJaYnNRS3llRmJWRzkvaUFuMGFDRFRzbmJoRG50?=
 =?utf-8?B?WEtWTlJlQ2UxcWdRTnpCZ3RBdVk2MnJlMFFabTNWWFFBTHF5bE8wSXJqT2lt?=
 =?utf-8?B?aTRDQVpjOVRxOS9lNWV5aVRqdnBKc0JUUm9KZGdGekMzcmN6amowNHhiS1dI?=
 =?utf-8?B?eWNxZzlRd3RzdmtWMGN2ZExZcXRodjVGb0xaYktuQmZzVDVPM2FsN1VaaDlL?=
 =?utf-8?B?K3VySE1xeTBVZDdNVERlV3ZHKzFRd1B1VFpVeUpkQW9SbUN6NUZCMEtucFFr?=
 =?utf-8?B?bTNhQ1orUHJRUk1QM1hpeURxWnNIeFBxcEsyYml5RjZ5NkFmd1hyL3U4aWFh?=
 =?utf-8?B?Y1owNjlmVE81Ti9pNjlFakJVSWFmdWY4NFVKekpwWEQvempMOUxnSk0vemNG?=
 =?utf-8?B?bTJwdXBBMlFCRmRNMnRMY0ZiYXIreUpjRTE3MHdxMllJQlZCTHNpMjVHOERa?=
 =?utf-8?B?R28xTSt5WkgrcEZyUzdpSW90ZldPU2xWVzJJaG5lUk1lRzMxWXdoTzJYS2Rq?=
 =?utf-8?B?VW1tbGo4UStjWGQ5R0c3aHFvWFd6Tmk1QkY5b1NuVExhNTFGcXE1WVVFdWFv?=
 =?utf-8?B?SWxtRGFCd0dhL2J6RHhDUExRTHhWNm50eENPbkI3VXZuZXR3R2FWTnRuU3pK?=
 =?utf-8?B?di9leEpmM0o1dUZ4L2tSbWY1VEswbkw3WE9GdkdGODRkTi9DaUttRVpmclZj?=
 =?utf-8?Q?NHNBRa1cyndbuFzMmLMN1sQYG?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	IytiIt7HOWwSEtTdM/ikA+XJg5qzWajF1//WHdnojhW8bRdqHqF6pTbtomqO1eRvmEuwaKlpp0bgTk9FzDcsiTjqOjaU3ZU06IZihkVZZl5CK0Nt53uAApYro8RcVvsyeLwqC7MMZmB1hnNzVEsJ882wj7GaMT20AyHXV1VqqEfWoR7jWB4yaQ2oH6V+yFuZE6hONpkzHAa8VIE6mou9K5KydU3BWbPJ/qoZsO3wmSCzR37yE4NRbOeGd4mR/rFPtvMkaPsZHkDH4d+dQB1S8+g9NSnkwbSFUxGkr50hCyjLVidbHPOI5UFG16QCBZC/XYCU5qtbxqId/i6lQm/oAKLCIdll7EK8yKOHvJBqhDm7TmPw3HgeWVpn+3uz1Inrmwll9z2HHp4b20i3kfL37XXVO6Hzoj4PF9HDNOD1vzNwViIRH6eB06r0Fzjzh071dkwYn0ptOTFu1MSih3d8rr4HuQ1lCbfbcOgGpC3wLLk/5B8/qvEZE9DawdGLNP3la4Ej/PmfMnCLLv4+Fx3bNZKsWz/HlPqubL2quZAadkVOcLenMnuMuHa+BhoBCqpkGYUhhbmsLICexl5zQc1f9a9+QY37HPHvVe1NFjytJK8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06e7b4f5-c8dd-4e63-51f4-08dc7b9eec7f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 03:09:28.3602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AjaGyvIyNqtAJpWJBYPtyA+O1m36kx7JM9edCnuGaYQ1oZocGO4aHzQD7NOPy7GdKrRsZLO25zCOymNSa0Aa+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7754
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-23_15,2024-05-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405240021
X-Proofpoint-GUID: fxl4E1tRgV8DiOjko8yrIU0_7yUDGwLL
X-Proofpoint-ORIG-GUID: fxl4E1tRgV8DiOjko8yrIU0_7yUDGwLL



On 5/24/24 01:18, David Sterba wrote:
> On Tue, May 21, 2024 at 08:10:03PM +0200, David Sterba wrote:
>> On Wed, May 22, 2024 at 01:11:06AM +0800, Anand Jain wrote:
>>> This is v4 of part 3 of the series, containing renaming with optimization of the
>>> return variable.
>>>
>>> v3 part3:
>>>    https://lore.kernel.org/linux-btrfs/cover.1715783315.git.anand.jain@oracle.com/
>>> v2 part2:
>>>    https://lore.kernel.org/linux-btrfs/cover.1713370756.git.anand.jain@oracle.com/
>>> v1:
>>>    https://lore.kernel.org/linux-btrfs/cover.1710857863.git.anand.jain@oracle.com/
>>>
>>> Anand Jain (6):
>>>    btrfs: rename err to ret in btrfs_cleanup_fs_roots()
>>>    btrfs: rename ret to err in btrfs_recover_relocation()
>>>    btrfs: rename ret to ret2 in btrfs_recover_relocation()
>>>    btrfs: rename err to ret in btrfs_recover_relocation()
>>>    btrfs: rename err to ret in btrfs_drop_snapshot()
>>>    btrfs: rename err to ret in btrfs_find_orphan_roots()
>>
>> 1-5 look ok to me, for patch 6 there's the ret = 0 reset question sent
>> to v3.
> 
> You can add 1-5 to for-next with
> 
> Reviewed-by: David Sterba <dsterba@suse.com>
> 

Pushed 1-5.

> and only resend 6.

IMO, in the patch 6, the

  if (ret > 1)
     ret = 0;

section is already simple and typical for the ret > 1 cases.
Could you pls check my response in v3.

Thanks, Anand



