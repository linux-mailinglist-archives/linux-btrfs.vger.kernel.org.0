Return-Path: <linux-btrfs+bounces-3074-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 065FF875470
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Mar 2024 17:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3E581C2233B
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Mar 2024 16:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF8B12FB26;
	Thu,  7 Mar 2024 16:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BNyhunTz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zYyISup2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FFA1DA37;
	Thu,  7 Mar 2024 16:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709829993; cv=fail; b=SULjw4k+lw1Ahg/z0ztQJIHEEZRA/nEMgQaThYTW6poW8OjpN2JPjuaLnf6Y8I6Sduq49C7ta5Lv3y+M/Ks0TnYNat2YR97xgoNdSRmoLWtSsTo4fc2ngBa9j7SV8t6T7H8bXd6ZHDoR4y2qlJ4TAj22kRCG0c28VpAECXSQWiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709829993; c=relaxed/simple;
	bh=H0fSPz4UjVfYI6qmPEZ55vwK8O+etdb0mDDGzSaOHYM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BYSCEhP7rANlr4V7rzEni+RlJigU6vBdToeT4j9IwJDWMGW5Wu7VbwWTIxBsZ7Xh8uDJeWHMUt0TxAANOGTZpfDwDMaX+V8Q1+ywujGDw5FtXyehI5lHMlEl7xDQBGYc/cYklyVWBYCJVUxnGm+QVJ5jCbnKC/ziFuEPm79EQws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BNyhunTz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zYyISup2; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 427FwcCw020933;
	Thu, 7 Mar 2024 16:46:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=H0fSPz4UjVfYI6qmPEZ55vwK8O+etdb0mDDGzSaOHYM=;
 b=BNyhunTzxl2k+zJ+5vsKX7Njhy9FisdeStaUWWHuw8zgQ2A1Fm+pwDUa/XmgcIuyD3DQ
 26bYxMzTYp8jNNqdPo5/kQWINLOigwi36lx1O7UY8xlAhRizyrM2TUtMNR5cM97iZNiu
 Nj0fvtQ3I7l26c5ahWYiwFaLCg7ZTWn7F65ONy4blerA0a8X+6SJMcrT5/QTWxlWvZhG
 Xg8hwZpsQVLMEn5OnLtYM79e9jCX2gH7me4pfVix64Dj3ewGRugxjf7jaXZKhWfW568h
 W4SLX7NqN6vddgUOInlawUmPaJj5RF4vp1YBVg30OUVmGtaoauDwHsWrnMfwABxxKffw CQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wku1ckx04-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Mar 2024 16:46:29 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 427G2Mob016005;
	Thu, 7 Mar 2024 16:46:28 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wktjbg954-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Mar 2024 16:46:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RSN42MKbthXcaZ2xqWvp7zJ9eTNbJVWwx1fqlLzTXT3U6v7fCpXU+nmjcDR+VEHKATmzK5Q8kw7EnDmeG1BOtOobss/ppuNExOKfwR1kfBh50SZXh4t/R7Q/W5qNWpRuKBbJc2Vs0DAffdLnnZzwEp6pIjHznJfYpTOQA814wp2PZH5VQklWWnvcIfcM4BOY9fCwAqmd0VU90hc21puD/ymMa9oHuE7S6Gv7xWl2bbHp6iEG/BbEuu1ACswegitDdT2COsz3sxkAq5toA3wBPQZNOJNSFrTVwOLPyo6iad626hqC0YYYcdc+jTEnJnwy447F5wF9YV1gV8oW/7yctg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H0fSPz4UjVfYI6qmPEZ55vwK8O+etdb0mDDGzSaOHYM=;
 b=FpUpcMia0cbC/FxZTmdxYFuTNiDhUq6czdpYcIjttCKp7weLyFJbGGED4fDSKaHvFVsggxCKBoTK787q2T4sBDGWfBSpD13+Awi334l7XiMv609srv3YvSq6w5uwu0xlo9k7jq+uuuSRCaA1ZIdfsnJXSJrHl0QkbYiuP/xhUtDKgRNQJ5Ahl4GLajPmaG+bbku4bAvvi78wCL5bHgh9TgiuKXiTyVDd4cX6BfCpivvQFX3UQWdck2SARszoM6Tg7u6bdDZKb7KVwMTKnv8RGPeQUAck0wFbKTztfBPZ6eJght5uXQFBBN3ND8pgzsdxTI/4bd+KMh3ICws2hc4D2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H0fSPz4UjVfYI6qmPEZ55vwK8O+etdb0mDDGzSaOHYM=;
 b=zYyISup2RfndUUF4LKB3b0cymfIrQn3qWWjCUdcSepNVEh5Ac+v6UgELBGKbH4XmMYqDIX/IVLM63RzM+abHJEgOBiaUnaAIJZAdk7NBifzEjGHn9e/Aic/rzGPGobF7i80slDnufJd0S8+a7+FhU50rol9i2UuxrXQ5Pv8fvvQ=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BL3PR10MB6140.namprd10.prod.outlook.com (2603:10b6:208:3bb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Thu, 7 Mar
 2024 16:46:18 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7362.024; Thu, 7 Mar 2024
 16:46:18 +0000
Message-ID: <5c4ca62b-a448-42bf-a196-6365af832889@oracle.com>
Date: Thu, 7 Mar 2024 22:16:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] btrfs: test mount fails on physical device with
 configured dm volume
Content-Language: en-US
To: Filipe Manana <fdmanana@kernel.org>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1709806478.git.anand.jain@oracle.com>
 <c68878cb99025b8c8465221205d5de9e40777b18.1709806478.git.anand.jain@oracle.com>
 <CAL3q7H5NgJ3hpFFk8GcESX0n61=r_J7=daAbDqZjpEHek=2djA@mail.gmail.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <CAL3q7H5NgJ3hpFFk8GcESX0n61=r_J7=daAbDqZjpEHek=2djA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0058.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::16) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BL3PR10MB6140:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fecc446-d0b9-49a2-e136-08dc3ec61c59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	l5vO4P4RR1sBFO+SZ74hfV7OaRRxf08XNPciSoQw8vc+2c+V+GYL3QUBWfVgKFaAbaPBz27botdwH44JUlL+lNn89HBhO5RQXz0WLCT6cXpGMuPGMD1hwD0x4WwZTwjaeDJZ1K0Q/VshR8CUVv7mCpYDrDr8DDwk1PgpgN6xgFm/FKRzriqoq01wku0yRH3FxoP/RQZ2kFMC2/PQlVqfer5cW0n4+3YrWOlKDr+SWdMTdct0knU9Pwc5EGUw2wPS4JPjS+k6sXiALWAMpWmokg/PM7LL6vujGvwDFvxUQRDK6V8Dx56mstsh94gNTOhTNx6ihaCgLFmITeEPPjU0j2weg/MRDPc5V60omNODDEGbgKp1A7qOVF2JvY45gUXwy/hxOyVoO1Xz0zwjd6ckPcdCSQmQgm1+Ew3yt65Bc0nFfv3iNY3s36h9Ec6IWLfyOwe6i57Xlgon6OB/HpS1GlAa45zwoLuujl6z9CUvKO7Gs235AMsXTNI1Z/As6rr+3+Az/Ouyd7LE+fNcHACLyknHCkD/nSyDqDB+LdJYJ1rRgYzYILFOtqzO17DNeJXXT+mqCovv1cJK7uEuM+1AH4qGOhTRWxW36oqqmwIVO4ReCUj3SB82VFAJG1yb9f/Jvjp7HMX+IOEn/qgHXqh1s6tG6TaTaSwfW/WV8mlVGHA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YVZLTm1jbDhTdHZjODlaajYyaCs1d1EyRVBZVTdsQ3BzUkVKa05PQ1BvTk1q?=
 =?utf-8?B?M2hHL29pNXZMV0s2N1lucW4vRDhtUXlvTXFOWUFkM3UwaU9Xc0dDb0k0YWJT?=
 =?utf-8?B?UzdrRGNNQ05DUTg4Y0dnTzhHUHFQYTJjK2lTUDZjS2prdWF1cVRTQWptTkd6?=
 =?utf-8?B?T1BtVjRTYjdOOUpYMVd5am9ySWdxQVJKVjB0NlFBZVRHSGZJMDAwSXY4bGVV?=
 =?utf-8?B?QnlldHVsWHA1SXFyKzNVanNoaWFoWTUrMFZaSTIvcVkydFNWenNybUlqWlYx?=
 =?utf-8?B?TEg4RmlQM3dmc1RDSjZkK3M3TlFHcHVMc21yQ3lObDA1Mk1MdUNMdmtuL2Fk?=
 =?utf-8?B?bldhcnRqV1BMYmdFUUEzZk5SaUc1SHRoSnpDZGcrc1lMdVd1K1hUbnhJeUdO?=
 =?utf-8?B?dEtoL2xKK1BaWGRwVmxabUorTm9JYmlnWE5mNG5UZ2I5V2ZpOGZhY1BnOWYw?=
 =?utf-8?B?ais2RitZNUlGZ1k3RzB5dDFMckwyRzF5MFRWeWllODRSNVF1czUyS3Yxbncy?=
 =?utf-8?B?RndIMDMvbWF6K2RDelZkVWRGM01LSFBKZmtrTVc5Kzdjeitsbys0SkRxOFdW?=
 =?utf-8?B?aUUxSytneHpYYmlCUlk4SndXY2FGUkxmcDd2K05TbFBsNVN6VG1lMUtPeHIz?=
 =?utf-8?B?dDdybmozN3ViQ3IvWjNLNVRRalBtQW40Q3htSmxHRG16cmZWS28zMk9jVElR?=
 =?utf-8?B?cWJ5Z3ZiRkZaZWtqMDVZUEw2TG5rVEsvQktMQkdoTWdzTUgrVStJVC9xMGZR?=
 =?utf-8?B?NERFRnlQbnpXWkhzdXo3STQ2QlZTVEN0Y2N5ZmQ2VXk5dzFLV2R5ZngyT1Yw?=
 =?utf-8?B?MmtaOHlnaTBWVCtPQm45SzNjcHg5RUhKc1F0WGRZUjBFbXZuT2laMVE3b0JT?=
 =?utf-8?B?YUdJeGxBZmg2YnZSWlhOWE4rb3JBZWhhRHM0UFlXc2JZZlJ0WTJpMlRRaHFS?=
 =?utf-8?B?dFQzNlV1MUl2eTFmUHFaTW9RZTRRNzdiRFN3SXR2TURZVVdGdXdVa3lIOVVm?=
 =?utf-8?B?RHhWVExzSmlrWDdYczEwdExrd3pxQ2F6V2RySXZGTTZyWnBWSmJod1daeDd3?=
 =?utf-8?B?WGJncklpU05tZlE2Q2I5dHFFaFEwWmZqMUgwQnNTM3hqWFd0MVAzUTJza1J1?=
 =?utf-8?B?SHV1QmxnbWhPbzJlLzNxV0xKMklPRTdUZDBIdHgvcGpzM0gzTXRHbEVSWm0v?=
 =?utf-8?B?ZVZJbzlDNTBtK1NNRUc1ZVYyTWlJV3FDMDhPVCtleFJSWG81VDlXdDBMcTVV?=
 =?utf-8?B?TlRITWdSbVlJLzEzU1laOG1rTy84NW0vOTNyZHZFRUxWeHIxTUNpangxNGM1?=
 =?utf-8?B?OWREZVhEYXZCV0VIbWtvY1lzU1hkSkl3ZTFFMURBNTl4WDV5RkNPMERkRVkw?=
 =?utf-8?B?bzd2dlgyQXNkNkFRTjJHU2NhVEJnNWpVeWpiUXhkdWR0MkZ4aFlIZlV6WDV3?=
 =?utf-8?B?K0gxSWcwbENPWHY2M3dQQnRwZWJWeFBjUW95elBjOE9IbWFraTN3MFdPekdM?=
 =?utf-8?B?VlppMXNSWTB1QWlSc2F3TEk4YTVieG53LzJiZTJvTkt1WE42bGpvZ3c4L1ZX?=
 =?utf-8?B?SThPeFhvMkxuZlpadElDdy9ncWFTOUdCbWI3ZmZPOXZjUWVTWktzM2J3WW5y?=
 =?utf-8?B?V3crSkZXK08xL0pMODF0QlhGdzVyVVFaSzFlV2prcTdBRG13ZFpkK20yRy9E?=
 =?utf-8?B?Vlo4OENkZklWc2tnSWwvLy85NHpLYThVOWdhbUJNenI3Q2ZGV1VrbkxrdC9x?=
 =?utf-8?B?Z2pOd2VBbGhZSllKYXRZbTROdURpT1FrQTdiemlZMTZOOUk2RWtNOS96dHJX?=
 =?utf-8?B?YjY3K3JmajkwekNmQi9SNjlNYnZVS0dETDBQWkV2aVVFNDQwanlDZFVJODB0?=
 =?utf-8?B?QUhaY0FIR1RHRE9MTjJmekx5aWIyU2swM2J6N3RuSmZLRjJEcFFOWG1aTVVK?=
 =?utf-8?B?d09URnE1RGhXV2dQeTlRYm5BZFEreFd6dnVrUDBPUjFmSlFlaXk2akgyYUIw?=
 =?utf-8?B?RE91QStwQkZWSHZqWTRVOEpIdHhLSnhabUQrVUdsNDVuRWxINFpmYlFhQkNG?=
 =?utf-8?B?allmZExMd2xWNURzM3Q3anhia3hVZldNbE5QTHkzemFCaE9handqdUN5T2NH?=
 =?utf-8?Q?xZG6P0gnN6c2euGqbqwn/FDka?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	GiquP3wgCkTcGM7k/0TlpvYzLMNAfbphOALSGK+kgXQ6tu8i8pSzAjoqRe/XVz5Ga7r2P8MWgn2bLZcRuCON4AHUeZDXoCwM+yxefz8104wwxdqZi/k8mgIk4WoJ+Jiwv8I5FzwXiXxeUvSLwAwux8Ss45euIOCLRo6DTE1vRGGF9W60J80FVsPKiXrEMWOHSuyJ78CIrf/svNVXOVF9Xa6xis5+ZLiL0oIfhN2+ffCs194Io5qD0lJxgPasEeaYu8/xVF22a3e8i3tyqiSNgKcJP+9FI1roZAXbEs2OPBJuUP3fLAAcn9jRJSfn564rGl2D0ecfMpHm00D0pIMsaw/qhmmW9XeacQz3NGNtH94a6ZcS6G5J4LnITU1Y20TzWDXmErgFCcABwkVrcOVQTUhZhXouy2UUkBdrelEKMHZeJ+vqpW9rJ+iiQz14QBOhYEk72X8vSlUvPQVeino9jz8tSS7LNfcJ4RxCzwKzFppZklglFVJyt1SVosu9PEpjBrHDB++oiA5PzR5tOkm2dfszUN7V5myrYQMlvoj7E6L0GvcY2E1/HpX6tVgm8C9Dwd21y0frywMuAX1MUfunwjB+LKhGgEdfKyznVDkKItM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fecc446-d0b9-49a2-e136-08dc3ec61c59
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 16:46:18.3424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5UJ11qNZIsOT8YpXIYuFBAI2cXDOf+r5FCZyGRlyT+7+iJFwDVeFAWRNqwAU/XeP2feNW3/0mYT9Kq6bTzcaPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6140
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_13,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403070114
X-Proofpoint-ORIG-GUID: gsmd38sIOeKSLi7gQYUSDKLPEl06aPe5
X-Proofpoint-GUID: gsmd38sIOeKSLi7gQYUSDKLPEl06aPe5


> I'm also not convinced that we need this test, because the bug could
> be reliably reproduced by running all existing tests or just a subset
> of the tests as I reported there.

This test case was motivated by btrfs/159; and recent report;
yep, most of the lines here are taken from btrfs/159.
However, I wanted a test case in the tempfsid group which
exercises multi-node-same-physical;

If there are no objections, I am going to add the tempfsid group to
btrfs/159 for now.

Thanks, Anand

