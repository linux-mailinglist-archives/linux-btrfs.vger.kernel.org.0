Return-Path: <linux-btrfs+bounces-6065-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA37191DBC0
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2024 11:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F282B22EEA
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2024 09:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F2F12D773;
	Mon,  1 Jul 2024 09:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZpqyXTrB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="d2FJmi6I"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1842F12D74E;
	Mon,  1 Jul 2024 09:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719827484; cv=fail; b=AnxfTAH1BXUfK49OUS7Jlb2ltBU4P+00UbY04L5y42GMUExX/1fkdTrdBRGnjN5t2fnFuVCly6PMDhgkjw55rQcItNuQdDVqVFxd0TDnL3dSjsA3V66nYT7Y56Qb3fkHVI5/4fAFl9oyaDjlwI6HE/8cPEqWazx7SR4VX5k16AI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719827484; c=relaxed/simple;
	bh=QTYwLMhiY1yjmwAviMWhGOFrjnA6/Ld5x5EsC8KTdKo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YQF8FlUrxvM8Pqip9C7OAdE6ssdM5STbZ5HBE24qv8cKMK6HAQ5aa7QvE68OUvwmHAr7cttUj/4k5+f4b6+pqx9YGCrQ3ZhkkLpi8psD7kyeAe8MDqrSRPIxfD+0AWI17ECGJnv3rq9q8Nubrs3Yg08CLV2JZDcRu0mzygXUP64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZpqyXTrB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=d2FJmi6I; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4617tVBg002068;
	Mon, 1 Jul 2024 09:51:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=57l41lpIJF9Sl3NK80Wk2Kv9e5GFWVu+9ZNeBytfpxM=; b=
	ZpqyXTrBE/qov5B5Bhp2ar2usWCBvQNeLsprnd0rTfvzKpmg2OMNhgKEEE1WwNEN
	ytJhM8WlzgyYeLPaJG2HtdqVrGKc2g6rRc8RMhXhCXHQy+q02OJgNy/D5xFqMVhK
	hFdJStqs9JnG8m+jaiSjWuzwK7lMDxOqXp8MlawFmZfaEW+P4k0dF1C3DWB1f0cW
	SZ20uHMMjahV6tyxlSe0sYkayOIoE6gGeOkg1DnsVmfqTxjysqJtwxvwLFHm7odV
	DFfCx7r2Xr+Kl/w1e+zwfA6/7ONkP/Ls9dgV0vYiyvdRnKSmZRNFKNhygt5d2VeH
	pqqUuYrCqPmL3HHeLU/2gA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4028v0jb8g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Jul 2024 09:51:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4617bfLZ018345;
	Mon, 1 Jul 2024 09:51:15 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2040.outbound.protection.outlook.com [104.47.55.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4028qchjv2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Jul 2024 09:51:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QL/eb4t119uk7yg25wy99qi3lJtCVteP8C2REpj/fn/bMh3xobaictAuOCDjHphS6ra1x7s3qX2rpwhGLN0s6AyUzxgqIAORmmZQ/cjhueqg/E/l0TyOlSeNJ3d5WLCsAxkbgYfeWBPhX0xvn0pH1dRiAiudrd3OUtLAJGHjMXYd8rSlt351bNKAJiFLU7tYUXbHtsdm+6QYkOun51Zac+lodQVq1xpoRJVQet72JdL4b/V2BnJ4h6rE5fGYHanbi9mYgoSFbOna3bMbTp2NPgEk3q/ntr9KF4lTK4w+DNGlhYQOlR5QF2pyQ+k5fEWEHp9ed4iQc0j7eWo3ODYT/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=57l41lpIJF9Sl3NK80Wk2Kv9e5GFWVu+9ZNeBytfpxM=;
 b=ZLhVfsEbElmPLOtlBRSi/LMO0FvF9cyP1MmEx0SGjsogpWcA+DM3mT8cD30cQ145UtApx5rOTeFVjSaWnxrFI5irgQ1ZbDYMWbybhr9FDpsqq2SGiAa5BAToiGOWG+sCR/+516dSG1c1tEy7/hvVJhJboUlv/pUbhPp7YHVvsyER8NbMoRCKv9ryA6TEjdMo5BpNoGpqrsqDPd0albgCeQvZEhimyTdZBgIlDedB5duKBeRGhC53+buyljNOSl9GeGy2dYskaUks3iSRBgD+2LZbRWrhXHOBzprN1euOWv62V69ucpI6KqudXBNj/cQxcJXUOiWxRBTHbN//RgclCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=57l41lpIJF9Sl3NK80Wk2Kv9e5GFWVu+9ZNeBytfpxM=;
 b=d2FJmi6IEfkUU1BzvrNMoYpA6QQRgT4LNE6KSV0AptX95rB9aux0eBOM+VeR662Fv5O1jkk7FVaLihc27bNTQHBAy5sk9KrEC0sO9XK/oXA5pehkSMGtp18DVXyHgFkyIVfQA3fuGhFKL3JbIHagbQc473aNrhMvXzVyE0aXANI=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH0PR10MB7533.namprd10.prod.outlook.com (2603:10b6:610:183::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 09:51:13 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%6]) with mapi id 15.20.7698.033; Mon, 1 Jul 2024
 09:51:12 +0000
Message-ID: <6ca68495-1aa6-4913-886a-1f75755c6348@oracle.com>
Date: Mon, 1 Jul 2024 17:51:06 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs/081: wait for reader process to exit before cycle
 mounting
To: fdmanana@kernel.org, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <bdbff9712f32fe9458d9904f82bcc7cbf9892a4b.1719594258.git.fdmanana@suse.com>
Content-Language: en-GB
From: Anand Jain <anand.jain@oracle.com>
Autocrypt: addr=anand.jain@oracle.com; keydata=
 xsFNBGQG2+MBEAC42714sRj0ptcjHWMJgkltgglCKCpcjdLTyoFY9dljqJdvrOeojl4N1Ztb
 qMwsnsoFkPiVMUnnU/FgypRlPOzaB4w0R9MTzfvpHKAUNMbaYLquldGJhfuYpTgikr5GztZU
 VGKGsKc4NJzWh6Mfqit2jwurS18RmjxR2dBDKKb5+M5xQ66M5Of2SuuzaM6UnT1vctDN/hWr
 MDqx3CNeQ8Va0i1iCStsdS3ExG6nBVZkL9ZCHHZHi/oqe4bG4vvevRlx57s+uS4WKpAsjlKD
 Z/WHxer9bffB9GuOCngrOTWiXtf1qmgXNs5kXlfb6O3uRv1xnfqTAHdxJ8/pwSShl2aDScdW
 7S265QZ92+ygEJeoviTc8FyrhKkV5c4hAMa9QeiuP6Sk7Mk1G0D/d/DlHQCncQZ/St6q5ESX
 M1LbFLp4amx2yELX0/2lLBXj5s0vQd4mbyz29K5TfiYB/BsEWzSA0gTM9MPdJL3FhIei5VsD
 SQ197dkp3pzqII7/rw77sQs6TFin555Q4DSMsKvKvm/vULpknXMe0DdrHw8ybrY2AjWiTs2W
 1Re7VPORkKxEK7prZ62hghiEvGyZHh0RpnI0aD57R8P3RLJ5P7mCMKimK46SC9fw+zWfWZJA
 EIDccuxTfaLdGPMO8GJ2HnKbvAFbI+nMoSYRvJ6ULvcsH9bPPwARAQABzTJBbmFuZCBTdXZl
 ZXIgSmFpbiAoT3JhY2xlKSA8YW5hbmQuamFpbkBvcmFjbGUuY29tPsLBmAQTAQgAQhYhBKPX
 ZMgfwKRZ10YTjD2+pVga3ljYBQJkBtvjAhsDBQkSzAMABQsJCAcCAyICAQYVCgkICwIEFgID
 AQIeBwIXgAAKCRA9vqVYGt5Y2EAVD/98XUcG+lHTLFvrBn/l+egW5BiJUiUuLIti9wMmj3lg
 Ndv6myanBwjK+v0+RZJ6Vr+oazwTiki6RgnxT3LN9u79T4C7vGuVjqZ205a1vGVN309oMPDm
 +rF4qstsNBMTyE6FfLD1n4ONqgMLATRuk5rPAyfIXQyKy5UomLZo+ISHjpDUt4sXnrsYMz/N
 Ht5w7LRQMmKva92T5cReAvyU8guCHTiG6oN3RCQKlyRmZnFCXa2ov+hYhBrpNikFtPOojGnQ
 JZ/i7RHIU7/ku0/NCGLe+3osdjxaItjkcLP6U7R+WrViweSKocwrtqVIlizSvaDv4MxYM2oM
 aHoAcolFcrpUaqgnUAjhwYRc6CNdB5MroTzrzGnacJ4y7xBlql0+HlrlNho2AVLqvXmar5fp
 uwUHYTeUwsixVHfJL+1sow3Ky7Q5SknDQKd7V7X9X1qs862fuuBD3iPLR4YY5SstF1P0lFrr
 QjNS85TaHFkFhKrXGvhe1WGhum5Fc0hVx88gQBZ2gdw8z4GWKC5esxbvv0lI2UhP89q2ClsY
 ZFS0/Odo0eGgfyxqUGtrouK4cMVXVP+LJb168xt6yOuPMTOLJH/CT9/b3LygcWxn4m/2+XbY
 w1aLKoaO1cKAMSObubp1nQIy+idTnQeY69oKQpxYp97EH7bhYBWfLp/kKJEB98hJeM7BTQRk
 BtvjARAA6w/uFi14uDJ1jAlGWYUpBELdj1NgSAWw6CR6GiS9XPlvtn1uApa80cy/Hm1mqYQJ
 FtC+H3Q0uJRZYol2dvDRJYfDmC4bwoO/mru8ZpHVF2c2rVehDvgzxYJeqH9fJi6fymr9rOa6
 tjX0v8FGKD2pnU8yPXsMNeADdl2lL+XPwVoVhAxx8bpotl8nG14TXQcBNuKxbU4oWRjUZif2
 32CAXkngOnE/dwo68L6tfwBaKNCtXXjv7BMXylXjByMciW1hsR+wwOObWioW8R9uQEDWSNv1
 EwXre7VnuIksrt53Ohfuz458eF5Lg6qKGMYYuLmNwRbFPBeZvx6989P2zKuQn3I6YxzA2sdo
 YIhwJHbJNsf971H3CMFORqiLZY9OQ3Ef6FaLW+KM0p9ezuT9bAomQm6xGJDWC93hM/xLXAd7
 LJxhhxj9rQTwSwxm5eQg0ODntYXeEVfJw/gW0eMf5ivTjzKEF22oTswsEKjnsaZ2UZNPi9Pj
 WbPTEWCzGe4jHLqgY70F7f+OgCoI6Qyvb4+UfXyKez+zuo05Q8TxSFa3diFP5/mRokFMzrmF
 lgnUIyPYrHJWAhizZQveSNQ/5M0C9cVykxhaGaF6r0z8JRxhXi0hAlFIDaGye1k+UB8ZoENq
 JVOcjH5uVcXjdqzEXCa9OCDCJrHYCTu+dxyvR6iFXZUAEQEAAcLBfAQYAQgAJhYhBKPXZMgf
 wKRZ10YTjD2+pVga3ljYBQJkBtvjAhsMBQkSzAMAAAoJED2+pVga3ljYwXIP/2B74x/gNE4c
 5/TGzX3oKEdflBGadVjkirOGM1yjIEqstnCF1UIABhyLJYv9IRaNzhx+ieBDD8knEVAAXvp+
 3b0cnmct+kyvOnXwYpCDJSZcJRE25f8fyTyvo17rUCdP8CennzfB0CFMeis7JhyC3b4ZRaLm
 M87gx9ZJA6z5SLarw5zeI5rHmpQ8FK4hGH82AJeedHKcE+RR8rNOyHpdKDHIEtTxWXTZAC+q
 TxCzgLS6y0OOXDGPifcHjSkW7mSrnVXb/FTIqxVC8ClHwSomp2IQLwqPaew+QNFT3RII7QbK
 vQyq+V0TMXGo7zQQ23SN1N08Nj7E6m/hHffFZvRJ1ibZdHaDDCeDXEZoklttj78325i8yV/C
 XDL6MeirxiJyB8P+Y9eSrIDTQP0jKBPQa6N66QeBSJnMFuDBbP82lovdszeCJq5XhwjDgQ3b
 zAKqel0LTK4JTAlKeYjX678eVUcDAkdfurkLDbYcPd6sOveHr1Wuz3aFgtPVVnVzg3rwi5oH
 rffHVDSAu23bB/YgL+OHJ+EzKIqR+qLaYt0Y+e12zhFBSazVC6NFFQY0A+BV7PPnOLdKF1IE
 kbRwSOU3mzvks433LMKj9vmt5TyRU99OsAIn/BY2nCP3FURwQ1NKQ2vpJ8KnkLCGePkjefcQ
 y4F0QrzFk5Hg4pvnpDur6Cbp
In-Reply-To: <bdbff9712f32fe9458d9904f82bcc7cbf9892a4b.1719594258.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::19) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH0PR10MB7533:EE_
X-MS-Office365-Filtering-Correlation-Id: b3bac577-36c9-4b84-3e52-08dc99b3577b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZEVSNk9KaUxDMkQ5c1F5d2lHTXFxaUpJTkFJQVJqNlNxR2I3SXlsMjBpNVlV?=
 =?utf-8?B?NlBlS25MOHRWRU5VRVNXWkI1N3dreDRkbzZHdlRtS3M1RC9aTWxZV1p4eVlt?=
 =?utf-8?B?S0ZHM0ZqSFcwK2psYXJJZEpjbjhjM3cwbjIxTkFnR2ZyUVVBR3F4TGdMTXJa?=
 =?utf-8?B?MDA1dDh2SjYrbFZTMjduM1RLUkFYSHVqOE02aHV6VjNwZ0ZwTnFWSFdGYnpK?=
 =?utf-8?B?SWFWeEpxL3kxQ0hCeXhDMTFyNG1KYjZDVmU5STJoUm9Qc1IvOGFBUEF2UWow?=
 =?utf-8?B?ZHA5U2tOaEdMRFo5QlgyakhyMU5RSjBzU0hLQjA0NmZkcllSdWNXUFJJckYz?=
 =?utf-8?B?WHB6NWFLeW9WdWFkVmtvMFI1cmJoY3hGNk51RDhqYlZQLytQSW14QTVzcmxh?=
 =?utf-8?B?SGRmMzNJdjEzcnByOUNDV1ptS2x2eDZEUkpQbFlOZFlpWXRqWGNSL2JHMzlH?=
 =?utf-8?B?UW1iMEo0SjZTMWRMajFvYm5MYlc5YnNPcWVKbUJTa2Z6dVFDcnd6VTN2bFhl?=
 =?utf-8?B?dzh5c3o1MG9ERitiTWRqRFY1QkVNWGdxenNSNE5TVzJvZFpPb3JDMldlMXd3?=
 =?utf-8?B?SDlnQXlvbDFicENjbUhsWTV1Ly9EUVlpYzNMRVl6NUZPcEU2K1p1QlJMQ2Ey?=
 =?utf-8?B?dnBuc1pGUU1kTTl1VlNTNXBBZ21zVnN4QXJhdW44dmtENVUrbm5jeDVNakk1?=
 =?utf-8?B?eVRoSEdROUYxa25KL3ArRmFvOHg4UFYxaktIZWhBc2FmQzdjSENvaVYrR2lr?=
 =?utf-8?B?WVJnTzVPaWFBN2ROTVFaV0FjQTZMSDkxK0VsSC9obWxpeG5jSWdYeXdTOWVV?=
 =?utf-8?B?NjM4aWFrdm5nUnBuSjh1U1JKWVN0UmhjRUw1VmFuc0t6NjRSa1daWnltK2FF?=
 =?utf-8?B?VmhmZEpqNVA4bndBWXg1WCtkSWhuTS9Wbzk5YkprQVU2UDhPSlJmaUIvdUZs?=
 =?utf-8?B?bHJ5c09uWE91M2MzQWcvb2RnQURtRjdCSWl2Qzc1NFZrZk9MdnRScm1NK1JR?=
 =?utf-8?B?Y0pwMmhLUExnZlJzK2ZmajhKdHYwWVV0c3RTV0grVlZYM21maHpIWHUyNGZW?=
 =?utf-8?B?ajhTOHJqN0htUmpMOXRBSytPUEwrOTUxbnl4T21OTTJIWFlFaHRuN1VCM2Jw?=
 =?utf-8?B?dnFiblBJU2E5dm8zMm1GdFk1RFRTS05Ha2RXS21mNjVOekU5a3pzY3VuVDM5?=
 =?utf-8?B?aWNUcVE0VG9xUHdyUTRpQ2pzMURlMkxsbDJIbWJDcFlMd3N4aUErNmJQQTZn?=
 =?utf-8?B?dy9PRTFnVWtDTDIraVlWMERhLzA5cVA3Zlorb1FJN1hGak9GRDFmYTRJM1hF?=
 =?utf-8?B?OEZwaXpQUWpOd2FFMHB0TTE4cVFyaWpQazhnMG5GcXgxT1FPTnBDbFY3TmQw?=
 =?utf-8?B?aVZFU2JDN2RQU0N1K1NzQ0d1VVpDUEVxdmNKRitEQm1KMk5lSXd1QUpWRFd2?=
 =?utf-8?B?cnNQQzFWeHFuQWJQc3pmak5NRDFCMnJvbkMyZkpZdzJTM0tCbzg1TmhwR2Zv?=
 =?utf-8?B?cmxObmlyd0VLOXhyMS9Vdnp6OE9jUnJnZ3krRkljeVIwL1MwNVN4VDREUmZP?=
 =?utf-8?B?R0FBb1d3L3hNbVB3UTVTYWlDYy9CRWNYdWlSVUdiQnR5YXVMUHNMWmtiWWFE?=
 =?utf-8?B?SHdTRDRvRCszeDBzbnIwdXRGaUdCZDJUUE84RGhPTVZEb0xCMDBjQTdWd3hL?=
 =?utf-8?B?YXFGVDZ5NmtvSGdjQ0U0REFRc2Z6SjRyVy9QUDFaRlBiTmYwcW82QTFlMWo4?=
 =?utf-8?B?VWJwdzFLb3lrU0pjQUFzTi81TC9PU2N5a2tNY21rYkgySDB2QktUZkt6RUds?=
 =?utf-8?B?MFZMaldUSUExTkdyVzdBZz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZzlHZngwWmwxVlZOK2MxdUR2djNUTFhKWWtsenhVaFkvcDBRSFVTWTcwZmF0?=
 =?utf-8?B?ZGhCdTFrMWlLU3V6WC9tR3Y5dDM5YnlTb2RHR0pNUUIwRDJWSHlkM1JuOUV2?=
 =?utf-8?B?cCtROURqTjBveFN5blhMMlNNNFlkTlJhYUtDSGVqaTZyNWhQVktkSkRqTlpQ?=
 =?utf-8?B?YmtqSGZTbVE2a2puTHoxTTU4ZmZENHNUS2FNZmlSOXNHM3llOUhEcURxSGp3?=
 =?utf-8?B?TzFGWGgzNkxNQUZrMG9yNHJpMlRKK1dXV0YxVTkraFcvQW9nUmlBeStSelg2?=
 =?utf-8?B?bWdKTUVqekowMUFzTGErSmVoN0JDU25BbGtQMm1PRXBscTBYdEY5dHdTN3Ja?=
 =?utf-8?B?blY5bFVydVBWbUw2dk04ZHFVR1VqK2ZCendlRXpqZ2t6UCtsU2Y1djk1RjU0?=
 =?utf-8?B?MHQvWWc3QlQrcXJNVHpQNEtGSVFVWWxjUDBocmltMERoWk00VFF4VFUydXZP?=
 =?utf-8?B?SUluZno0K21Pc2hzekNjYzVLcWFaZUl0azlsY1FhdXczS3NJVVZHWWxSWTU0?=
 =?utf-8?B?MktLQi9kZjdYTEM5NUFLTmQ4cHg5b0hlY3kvY1owZmJkdVZHa0ZDUFN3Tlk5?=
 =?utf-8?B?aXZVSFZsbVRpL3JwOFVrakxUeS9hcnpxNk9TZXI1VnpGNDVZL1lGRG9hcjM3?=
 =?utf-8?B?VnlDWFYzZmtUcmcrbjBDZklQMnRaTFRibk9DTE9pZ3A2bUhUSnlvdHp3YnhU?=
 =?utf-8?B?SzZGa1RwUElaYTFPSnA3N0NqMlRCUzI4eHVLQUVsVHREWTJ4aTVzRkd1VFZp?=
 =?utf-8?B?RVJZRnJadXA5SDhzelhydVNJY0MwYTlKcHFEWlVCSVJNYnZZc3BvbWRNamFh?=
 =?utf-8?B?K21YeXk3Ui9QQ3lMb1NVQnd5T2FISmQwa0JPT3J6USt4aDUxc3ZCOGtEZmJQ?=
 =?utf-8?B?ZHRPOGw1bWtBdGxUMGFWcEE3eDIrMng0eEJoeHpXUUZhY0FvdGRpV2VWRGxz?=
 =?utf-8?B?aW82bFdqWUxvdk9JZUJkL2o4M2w4eUVRdFFjM0h2T2Vxd04wbVc0ak8rclNX?=
 =?utf-8?B?VW9RWjJZcEpleXp6azRPaVJvZnZyR2FPUkJnT1pBeE44Q1hpOGRYekdUU2pK?=
 =?utf-8?B?UHlCZ0N4b2k5MlhJc28rMGVUSDkvT01ZcFErRG5uOGIrMmFVZnE5eDNjVFlN?=
 =?utf-8?B?SEw0eUc2TkZPK1RHUldHK0RiQVQ1RldkUXpCSitwWUpEZmxzblJOc3hCazRI?=
 =?utf-8?B?ZXJ3VGtWdW5FNmNKaE9LZnZSdCsycUVSa3k4TnprMjBydUVReWl1ekppVzVG?=
 =?utf-8?B?bDNUd3Fnd3BhdFJMUFYwVklMbEswSGpnakh5dk5wdmpyR2JsektnTm85ODlt?=
 =?utf-8?B?OUpqVjdybEozWjhlRlRYRGtETzVxc2RlVVV0TnBJRWp1Vk12ZGl4NDJhU1F1?=
 =?utf-8?B?a2tSQXQ1V040S01zaUxUMmp6eUVUdytHU3lvWVhVNm5ndWNLYkxOWVBLdkVX?=
 =?utf-8?B?SHRjMjJsQ2gyNlpiYkVyMDJvZnFCeFVFOHdFOU1YOHFZWWJwcHNBNFJzRHBz?=
 =?utf-8?B?elZnY256dVZzbEpEc0NXUkF5UXE5YndKZE9LUTFpL3JDSVExK0JuNGE0d2I0?=
 =?utf-8?B?RW11bCtHU2JyMTYwUkFReE1QcnlxemZsM1ZLNkJEdVlMMm1BSEdkdHBUWHhl?=
 =?utf-8?B?UktVNXRWZVlpSkxDeWp6eFpLTTZEVHZQZE5mTW1LOCtvTENtZkQyeSs0ckhp?=
 =?utf-8?B?ckpHd01qQkZxNlZWa1V0TjczRE9BemZUdGpraklxRWxoekt5UUV0cldPdFAw?=
 =?utf-8?B?VUJiazQyeUlMaS93NFRlMEI3bGlsQXBjclBhSVlWK1ZIVys0WlhqV2pWSG5p?=
 =?utf-8?B?Z3NTZzVUdTdtUDZocEVyMzk1b1BPenZOS0VBRnBRazNzV1NYaTZNWjEzeG9S?=
 =?utf-8?B?cU9UbzRiNVg2K3RxdGJpTHRqRW04ZmRqNStETkxXN0laVHlDTy9Ob3hGZzFD?=
 =?utf-8?B?aTNIdFpiMXVONDhERFZscndpYm1BQ2tZZy9vUlRYSVcwSzdxWWJtWkpJMVR2?=
 =?utf-8?B?K2dhQWNDdC9EdXFteU15SkI0Z1NwUjBZUWgwLzNCaW9wRDJ0VlRrMTROS3Vm?=
 =?utf-8?B?em1Sd0dDeHMyeElIdnZia0ZZY21DbzYzRzR1ZTk1T2VGYnNtdlZIQ0tZYUM5?=
 =?utf-8?Q?JLjwHMcfg57CZYBCrcrVsxiQH?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	mxkyKM4c2SiHW0oildIrP8KGVqlh7tz41hACVPtrLC8kradU/uht6HoC+ANDnf0pt9+M8vRNrQCXw2XDlCNVhVjAF0WTDttKCg7j8+WbIKk3fVT+qfYDwt5ziBpovsievtmDj9UB+vkWBdipmq/Z67i8THHHpPnDK3wxiMd5BpuMpFDDKDZknwnTer3sFYvRTWCPWC+K85J7Uz6QvxPuq1W/vNgonDfDFOAZtgwwOkBixclty7PJ8Hg/Lz7M5zdBlLPYYJQR8wtGO6Np982/JbFDtTz9q6RdUk8d8r5iQyMbWufckEErSH2tcEu+iYjQnu3c+Y7USJi+vpQW1X78mmriS27FozmDaUySQ/GrH6Jdj3IvnGtGsYvEzEFmEdHMNWr4hTvU6SkzVnbbhJpnP08jkkfgCwp1rj5N39az0EMG+P68KOJBKg3ikfMNepfrvtYcZrMuZI9Y/royrJhuD/8y0neh5oUWqSYDxinidvd1EwxPq23YZCHM3x85+si2j8JG2XI0pEjUY21H2wkqzoFbdXPHpdFzk5Ajy07ZdF+KQH2NLxCUjFjOAmjV+aN6ywffAGQsE93ua4UEF2+emB+kRPOukMlld2e/V8vd0/U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3bac577-36c9-4b84-3e52-08dc99b3577b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 09:51:12.9046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ErvOp4WEXgycUtTzxQ1wdaIVmSsQJZBX/bsymhDIPZT/YV7qdS+3k15muWLzBlPmVXoGbB1aNL/AI44rJrszw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7533
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-01_08,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407010075
X-Proofpoint-ORIG-GUID: tBSsT-dUTVD2EYEEOErB0sxNZzpS282Z
X-Proofpoint-GUID: tBSsT-dUTVD2EYEEOErB0sxNZzpS282Z

On 6/29/24 01:04, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> We send a kill signal to the reader process, check the md5sum of the
> files and then cycle mount the scratch device. Most of the time the
> reader process has already terminated before we attempt the cycle mount,
> but sometimes it may still be alive in which case the cat command
> executed by the reader process may fail because the scratch fs was
> unmounted and the target file doesn't exist. This makes the cat command
> print an error message and the test fail like this:
> 
>       Verifying file digests after cloning
>       14968c092c68e32fa35e776392d14523  SCRATCH_MNT/foo
>       14968c092c68e32fa35e776392d14523  SCRATCH_MNT/bar
>      +cat: /opt/scratch/bar: No such file or directory
>      +cat: /opt/scratch/bar: No such file or directory
>      +cat: /opt/scratch/bar: No such file or directory
>      +cat: /opt/scratch/bar: No such file or directory
>      ...
>      (Run diff -u /opt/xfstests/tests/btrfs/081.out
> 
> Fix this by making the test wait for the reader to terminate after
> sending it the kill signal.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>


Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thx, Anand

> ---
>   tests/btrfs/081 | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tests/btrfs/081 b/tests/btrfs/081
> index c3f84c77..64544da3 100755
> --- a/tests/btrfs/081
> +++ b/tests/btrfs/081
> @@ -82,6 +82,7 @@ $CLONER_PROG -s 0 -d 0 -l $(($num_extents * $extent_size)) \
>   	$SCRATCH_MNT/foo $SCRATCH_MNT/bar
>   
>   kill $reader_pid > /dev/null 2>&1
> +wait $reader_pid
>   
>   # Now both foo and bar should have exactly the same content.
>   # This didn't use to be the case before the btrfs kernel fix mentioned


