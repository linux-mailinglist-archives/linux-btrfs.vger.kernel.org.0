Return-Path: <linux-btrfs+bounces-3521-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB32887D30
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Mar 2024 15:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAAE9B20DC4
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Mar 2024 14:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC4B1803D;
	Sun, 24 Mar 2024 14:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UW3zqcsk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YS0+xtqP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A8F1802B;
	Sun, 24 Mar 2024 14:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711289800; cv=fail; b=NKiL+tb6bQ1ie5rYdAGkI9yR8zTDhlSLPw0CMqqN7qUYjJHa7uzSglCYwYmrxp6rVqphfXrzOe0e/mcnShgQlQHbVn6xkcm18k2OZSP8HzPLkJ8617lKC1hdmT9j52+liarkG4apGpIbonysPtPtIsHyJGZHA6AilnOiFQcgI7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711289800; c=relaxed/simple;
	bh=OXDwLqvAtD52VkmwTyjdlr4Q57sQqfWRjoAzI2mf1yc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AelA7IUfwbizYitGIZZGIgG57Wyx0+3JpYGXzgEkzoxUpusUdDUgZAp99uvllGw4WdjYT+F4NSyBdTL3htBLQi3UzmOyTveHlGr029TrO6Wg10IAGDKG1/9dt9Y0xyDuHxkstur2sGdpSc6ZPnj4Pcd/KZgHIDSJmYsFFOgIOB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UW3zqcsk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YS0+xtqP; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42OATT1R026648;
	Sun, 24 Mar 2024 14:16:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=/yt+ENhD7vtrQrUyDoaHgZpJIF6bT4MBlKS75Bnbyho=;
 b=UW3zqcskWkGnQsRrGucBez8X/ga9+mbtkb6mR9OYZI1FAVar5sRFzlgDQ//LZyzcEZ2O
 YZlITUTiahwazPfxXbWwXXb8ub1wxBfaQXu5LFjrGtxFhar4mB0MWCqDaYFljXmd4y5V
 53rxQEqUezVXnCSlWS29Wb8ay3+gLfRnUcJa0eQnd7WrzXq9WkFRUnfvEdb/GpSxELZI
 3CVJ9uEmb2qkfAJQ0vagDyswIVPCZl4RqCqoDlmyHGEMGfe7fpuqpKjpqCNTRovb5oSE
 NFmonvdvgwASiLXhELT4eiRQwfoN9c+4sCJe0ncoLK56KBGlYlnMj/1fVtGDuY6HWuDv iw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x28ct0j97-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 24 Mar 2024 14:16:35 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42OE7tb8014498;
	Sun, 24 Mar 2024 14:16:33 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3x1nhatk32-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 24 Mar 2024 14:16:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DD3TpAqinfijgpgCETY7n5m3IMIQ5j6LQD3hKRKWJDI1S712qglZ1sIIQEIW88L2wEHbru/GW+9BaqbGHFDNZMRZY3YRgeCXoeiz4wUWhzh89gctl/YljIxJXftlbvtjX7ryeavGtSESg6kVsZbkHrZMGYqzOtKW/ZUTnhsztfiVvevi11ugviuWhW3ufSwbWxaTdyZvqdEOIarR9c9LFpld8tF7WTz6n2djZq0X6IH7ggl6dzXY9W0qBBCYh0GURyjvZ99mlKqy16PmKRPq0CmBKQwmZpYaAG/NZ82977JDhB2lq3jfG5DEorYMaRm+oWb24io3wqrrYDnK8zM5JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/yt+ENhD7vtrQrUyDoaHgZpJIF6bT4MBlKS75Bnbyho=;
 b=Tqgpki4RuLdXv46B9mywMXtG0mBUAxYze/AxV2iJfbsMcL5JudmFrzv1qPmwUWiUoT72MQUTVL+/3ZK0gdNdiQErRYzNQDZBWvnLgRS9cl1RXyrxc6ohVW6LlZ/R9sO6AV1EMbRIPtT4cHRNffoblBKHP/O9Rvf+bbWhAfSZVRFMVeoBwM6BXNj2P8NkPCtmb02k+lYR8N143An/x+869/l4QgRIWE/i9P+vBkuEjud/2RRHQKVo2f9jJ2oaG+nQCrV0XxTrE5sQcJOb4Drkt23e+ypA1Mv3Yp7cZ6Vcz8q7CwfO9Ho1myk+70ta0Ic7n8lSYIhIVBGsDXMGMiQsZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/yt+ENhD7vtrQrUyDoaHgZpJIF6bT4MBlKS75Bnbyho=;
 b=YS0+xtqPPT7tfWt6gR5tyGyocgW2P4I4v/geiNMXgi05KJWJP96phZ39e9ZFV94N7VWjiVS38mK7Ns2BNioiTYuwQWgeRuV4GlzaZTpffgc+eg7oIQc6d3vFCRZk+7laQPXW4jldEXY6aqKFxqKOcu+A2ZAuutvK9CLEL0+q/+A=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM6PR10MB4283.namprd10.prod.outlook.com (2603:10b6:5:219::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Sun, 24 Mar
 2024 14:16:31 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7409.028; Sun, 24 Mar 2024
 14:16:31 +0000
Message-ID: <b190f9a6-cc3f-468c-b053-57ed9abb509b@oracle.com>
Date: Sun, 24 Mar 2024 19:46:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] fstests: add _require_btrfs_fs_feature raid56 to a
 few tests
To: Naohiro Aota <Naohiro.Aota@wdc.com>, Josef Bacik <josef@toxicpanda.com>
Cc: "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
References: <cover.1710867187.git.josef@toxicpanda.com>
 <13ca87a192f4eb8a8f10415ae1ff06682c3b40a0.1710867187.git.josef@toxicpanda.com>
 <ru4x6zy5ot33pkmeoe3axlxnitnqjnafczb4tc3y2va2lstjeg@z2maxc55pvc5>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <ru4x6zy5ot33pkmeoe3axlxnitnqjnafczb4tc3y2va2lstjeg@z2maxc55pvc5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0P287CA0014.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::16) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DM6PR10MB4283:EE_
X-MS-Office365-Filtering-Correlation-Id: f471e969-46f5-4919-b8b1-08dc4c0d0079
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	X9WjubV5aCw740B5PZFChd6uO/bLwRpmE8Rwsgttenu1/uS5bjDk+IfLCnCUJSzkbN4jmfB2tjNKvA/x0nGL7wtjPncx2nzW67BIySFOMonpEn21V18I0YTekn8CCHwnbxRgjsNw2ohMt7dd6h0j5uhW3NKE70U6+6tt7JfdAtyCzp7wdiowgLFKkPi+UHJHSPKsZ8xCEr2bXU/4rZoipdWYotPswYvnfyb60QXFrmzEODpNuxKGG+b6COobqbQVVVNnzl+MOSm73N3AehhQisEO2sKPLlUl9o0HAz54cdXL0330QW+LzElut2Mh7kY6BbxY5Ie7ZgoqEjyIxajlwFa+ToHNocfrwEFlukhoMnMlB2/hA50SpkhbUf72PBD//K/g/cpZhNAlZpNEF+hs5GzmbQ6PZI4Eu37YVTNYScsiRKp8+f4Xvm2foL6pb18raPZio3CKloQNi2BWVG78gGrGggQe+YBn3hntGbYDFup8bWexHhtSY+Wy+9GxzrzV9yVr5jI8E7snW4pFpE7EVMQeldYoawwCszY+fnd5vS2EKasmUTus7HcJa2aW5jc+WFgERutt4DStmR8dz9rTImaDphFOe1jP5lYkrbJILR+tSvOCeFphvFlPYK1g04oRcI+2NTP7k0+f/ohRgMxLKiEjC4eRYh55msoXqMkVRkQ=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WnRicERDNVpIOGE4SE54ck9YS3NjcnRFVnhqNDI2UmE3RjF4R2tLSTNKa2RU?=
 =?utf-8?B?Y1I1T0lGOWlPTjZlcElnZmhtSlFCbjZHb0U5MlhGeGxWT1BJVWRwWktxdHQz?=
 =?utf-8?B?cjhrMWFscEgxbG41WDN2c1ByWnRxNFg1SVg3QjVCUFNrMWFqRUp3aEdWR3Nm?=
 =?utf-8?B?UGh6SjRwakJYVFZtZllOOVdjaXNQWXMxODVVQWRtdi9UL3V1U0thdFBicEU3?=
 =?utf-8?B?RHNhdU9EV29oQTRHRkIwNzFScHNGZHRrQTZ2dWpkVmRYTmk3V24xZXlCRmNU?=
 =?utf-8?B?SXVGVFFTWDU3eGExOXV0dk9WR0tYbitZd1FVRURjU0tLcnloR3pqYSt0eXQ0?=
 =?utf-8?B?WkJlRkgxK2pEeVNYSVFlSFNBanF4VlQvUFhxUlhBYVlybTMrbmhRcFMyQ0Zy?=
 =?utf-8?B?amxnQ0xnUmU1WWs3dUpuQ3hSeE9NNEJ6WlVHTlNGQWd1WXFDclRpVE9rbm9O?=
 =?utf-8?B?ZjBwa0xHQVVHQjUzSG9CZTR3dVVmckpUNXl0aFpzMG5zK25jenlTcWRFZnhM?=
 =?utf-8?B?eFZyaThJcVF4ek1pQ0ZvS3J1cS8xUUFxWGdncjRncFVtRDIreVNlVU03T0V5?=
 =?utf-8?B?bmZtYjluUVhMa2VMQStyOWJyVndEeXVzVHBrUTN5NHVxeFhVVVVnWHZGamND?=
 =?utf-8?B?WTlRQ21nRFNsN0Y1VTlFdEZuWHc4RUkwTlhySkwwZmZ4Sk4zWjhiRFM4L1kz?=
 =?utf-8?B?bzIrTmNTcS9YNlFTNTY0SlVjcnN6RS9BeXRZV2NtdGNsaHVlbzEydExiMmZ4?=
 =?utf-8?B?eVd1aHo2ZXRaY0dkWU9SNktncElIK2V5Y3NlNDdqOFI0NUJjTUU2ZDhlbEZo?=
 =?utf-8?B?R3Q3S1NzM1lXL2JTZmhCblVReVR1TUh0WkdQalZPanRlQmtkeTR0R0ZYUTkz?=
 =?utf-8?B?Vmt1VFRsdXFlRDA5ZFI1L2htSG1rTnl3YzBrNU4rVUtOeTl6bUZveDEyMy9z?=
 =?utf-8?B?cDJWSFB0Z3BkTXdkMmZwT3c1VHJTaE00bFVKZ21ZalNTUVQrenp6MkZCQmNw?=
 =?utf-8?B?N3JYdVh0dnNhZ3N0S1g0TU5kS1lVREg1YjVWcFJjSnJnN3Y1L0h1SEpQRTRo?=
 =?utf-8?B?U3c1WVlpT1E2U1pjMjBySEEvUVdDVkJNL0dNa0V2K3Q0ZS9McmduZVVyc3Rz?=
 =?utf-8?B?ZXBPNFR0QnROZFBvMHdmcU1nbmpwNXE1YkJGWWFGakVqZ0NxbWJjdTRsdHhP?=
 =?utf-8?B?VHYxMjF1Q1FQMlFvc05KZENwNkNsSnZvSCsrUEtLbm1tcXZIL2xnQlhoNkpw?=
 =?utf-8?B?c05hSmh4ZDc0ei9kdkI3UC9BczFkNTVMbVhDOGpPWWhTdUg3T2JjeHNvMmFE?=
 =?utf-8?B?NnVMK21FOXpHOHJqczlsdDVnbkZEbnhlZUZjbzFQTkl1d1FHbElxRVE0NHFM?=
 =?utf-8?B?ck1KcTJONXptdFJZdHdJMjV0ZGpPQUppQVdUZDF4WjFNU2pVV1JIeEE4dlQ5?=
 =?utf-8?B?Wkk4RHZyV0Z3anVWOTRDMTJYL0s0ZVRsV3pWS2V0a01jcDRSNHZrVWxyYjNh?=
 =?utf-8?B?ZDFZL3F2ZHo5bW9NcFBMbVlKaW9GY0VRNHo1TUpMQmxaeHJ4REZnQlo1WWRl?=
 =?utf-8?B?TFVIZnU3Rk9aQjlnbGJ0bks4eStETmpzcHZQMDBESkdGd3JIQzZqbkUzSFc2?=
 =?utf-8?B?WGFpVWtKeGRNVmFJa29nWTE3MVZUa3I0K0NvUjZjQW4rTTdQUlBNRXcrRUJ2?=
 =?utf-8?B?S2poRlgvR1pEcHo4MnpkNjBoZFlOemJhQ29BbGpFUFlNUlNpeEF2QnRVTXJo?=
 =?utf-8?B?Qm1GckJzNnNQb3pzVjlxZUNNdUdEVHQ5ZmR4QjdVUkZ5cElTMFVJeDRqUjdy?=
 =?utf-8?B?Zkp6M0NxTkdjWWwvamVzazc0aUphNEZXTXNhdTdIK1ozbEpUT3FrdkZiTVRo?=
 =?utf-8?B?V3B5dEx5K21uNUIwVkZZQkZnN2lYVFBQTExDakRDang3ckZxcHpZVGdXb2hR?=
 =?utf-8?B?ZXpSK0ptRGZKelZPUW1zT254ZkJSc1plL3pLTnl0YlhxeVhnaUthdkozWHlP?=
 =?utf-8?B?Sk45WTN6cWpueUdzQWRHNFFsTnhqT0w2aEY2ZVMvbklXbXkxSThXU1I4U1VJ?=
 =?utf-8?B?Qk96SW5TSDJHVWI0cldaV2pSOUVFT3lsMjI1bXZGOHgwS0N4MDFvMVlMd2Nj?=
 =?utf-8?B?aEp1VEQzL2N5dTZtODJuTUFiTTN1cjJudFl4UkthVTJUdkNvQ2cxSmttbE83?=
 =?utf-8?Q?FAWtwqrNcovVpSeiED6DTsiMC4fMIzFeCqIh40ukv+lH?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Z6kcm5vGRrthUx7TqMUF7E+GjnuIWtcDpLHhgZ+ojqhms3g2iCoN6cElo09zRWYQOI04r0M6ky6LrY7FAg5Hi9aQ6tsQa4oS5dvs8zvCssFLedpOiZ9ahnYfy3SIE4+5r4sE8utM4qxdo/CwMlGP2rDIeQA82/otdFAwylopJmDdVaaFWPpsh54J7pO003beoGY3eDXUCSgkGnax7NfKGZVkbnhQcffG63GPYGvVULZJa0LXUXuK1e/RPWqidmhaSlPk9BberYngwEl9YX4p4c7MfYk3rmGxA0ZIN424fJzoZ3PzhqGvRP6baGlHEMUMFpDFABiVjo741nim3MdK3eJODAOud+uUPmIef92daQQLjKj0G8Tig6n9KhF7JwI0AINKXALK37DkrTV9DESL3S93imfVzBKnhDgEk2nU/99Cr8yUJIgSPDUMmngAPdj0TAxMnBkRQbIvSHbOhQtNR5wYcRnzmW58sUOCiqm4lNV2T6bDBY7lBbnVQClj2fFk6+IgI72A5DB9xGQ2GSw6IsjiZDIgThQVYHTzDOtCTvX69mN0ZDGRYNHp0+DdNNSIqP8rHkiYCQbQr82Jl5M1ux2KFdAEUgnzKdid/RdIkDc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f471e969-46f5-4919-b8b1-08dc4c0d0079
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2024 14:16:30.9516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xcmXv/yz9rUy4zUt+z7J4BJz8C8qPDuBiV0yvt3F2oqziWE0g/MtQ36QoaO2UeFlBa0SD1OS65neph2WJWCmzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4283
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-24_10,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403240090
X-Proofpoint-GUID: jmrdK_fNx_jE-G3zWfiu5gqWnCd21bGZ
X-Proofpoint-ORIG-GUID: jmrdK_fNx_jE-G3zWfiu5gqWnCd21bGZ

On 3/21/24 11:25, Naohiro Aota wrote:
> On Tue, Mar 19, 2024 at 12:55:58PM -0400, Josef Bacik wrote:
>> There are a few tests that don't have the required
>>
>> _require_btrfs_fs_feature raid56
>>
>> check in them even tho they are raid5/6 related tests.  Add this check
>> in order to make sure environments that don't have raid5/6 support don't
>> improperly fail them.
>>
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>> ---
>>   tests/btrfs/197 | 1 +
>>   tests/btrfs/198 | 1 +
>>   tests/btrfs/297 | 1 +
>>   3 files changed, 3 insertions(+)
>>
>> diff --git a/tests/btrfs/197 b/tests/btrfs/197
>> index d259fd99..8a034fdc 100755
>> --- a/tests/btrfs/197
>> +++ b/tests/btrfs/197
>> @@ -32,6 +32,7 @@ _require_scratch
>>   _require_scratch_dev_pool 5
>>   # Zoned btrfs only supports SINGLE profile
>>   _require_non_zoned_device ${SCRATCH_DEV}
>> +_require_btrfs_fs_feature raid56
> 
> How about moving the check in the workout() side, and skip the work based
> on a specified profile?

Yeah, it's better to check for raid56 support in the workout() function
rather than at the testcase level. We can silently skip the workload if
the kernel doesn't support raid56.

> This test runs the workout with raid1, 5, 6, and 10. This check can
> needlessly skip the test for raid1 and raid10 if the profile setup does not
> contain raid5 and raid6.


> Especially, as we already have raid1 and raid10 support on a zoned setup,
> we'd like to run the tests for them on it.

This can be taken separately, not as part of this patch.

Thanks, Anand

> 
>>   
>>   workout()
>>   {
>> diff --git a/tests/btrfs/198 b/tests/btrfs/198
>> index 7d23ffce..ecce81cd 100755
>> --- a/tests/btrfs/198
>> +++ b/tests/btrfs/198
>> @@ -20,6 +20,7 @@ _require_scratch
>>   _require_scratch_dev_pool 4
>>   # Zoned btrfs only supports SINGLE profile
>>   _require_non_zoned_device ${SCRATCH_DEV}
>> +_require_btrfs_fs_feature raid56
> 
> Same here.
> 
>>   _fixed_by_kernel_commit 96c2e067ed3e3e \
>>   	"btrfs: skip devices without magic signature when mounting"
>>   
>> diff --git a/tests/btrfs/297 b/tests/btrfs/297
>> index a0023861..990b83b1 100755
>> --- a/tests/btrfs/297
>> +++ b/tests/btrfs/297
>> @@ -15,6 +15,7 @@ _supported_fs btrfs
>>   _require_odirect
>>   _require_non_zoned_device "${SCRATCH_DEV}"
>>   _require_scratch_dev_pool 3
>> +_require_btrfs_fs_feature raid56
> 
> This seems fine because it runs only raid5 and raid6.
> 
>>   _fixed_by_kernel_commit 486c737f7fdc \
>>   	"btrfs: raid56: always verify the P/Q contents for scrub"
>>   
>> -- 
>> 2.43.0


