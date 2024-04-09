Return-Path: <linux-btrfs+bounces-4045-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB3789D13D
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Apr 2024 05:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 889601F22440
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Apr 2024 03:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CB855769;
	Tue,  9 Apr 2024 03:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AFFvvy67";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vWeakNQN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5944F54BEF;
	Tue,  9 Apr 2024 03:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712634034; cv=fail; b=FQc2lrVWxz88aPwqZrjRNWKOuPGyJTEn5K02ABKxe7XTzIFom1tp7U0sQru2fQBUpm+Mj/NtYkiTtL5TIx80xj5CQr3rjdabAVYMzgOebLHi1kbuBNiYBugMgRpGe/1jet8eYk7xlGhMN8Fdpjh7vZ7N64DJ2jjKk96ZjXa3/B0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712634034; c=relaxed/simple;
	bh=5m+CAaQJqMC82nryrbBERMJ+x1gT2glKDrb0jsNIsSA=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=khsMmg9i63/2SfQo3x1x/MPbIRER6K3YY5GzhzGls134gTaUhyGjmWR1wM8RsVAcBfIahtc2VwG7n5/NwwgV0k63xahi6QAOKRLXDofznmoOkZK9zOAsLFap9cVXQMLg2uo/qu9+7RJkxIdzH2xuldPrfhOcFPUKl1UpRpqacxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AFFvvy67; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vWeakNQN; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 438Ln0l0013116;
	Tue, 9 Apr 2024 03:40:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=gHy1nmk8HEyobci8nQjJz6rQaqjkMezXdGqSNY+fZlI=;
 b=AFFvvy67gkj00/ygQY4ue+TXv54+CTfkPWBeJox3B7Z/CBSChUHmWL13wlDUvFix6naK
 fhg9IYQ0aHMGhSPNiZr8zzHaE+BSde4Cz2/xP31hX0252pErZpyOAT2mHcN05fZ6e1ox
 shSkmff0+bZ6FGNuvmZsWEonY3IgqcYYmVpUwisEU4PspolU1pmwF1UJaLu3WcbUCvfj
 bHQUCnZbmbndGEhhzJbj4BvZI8egG2H/DxsrbFBepjJvmK/Pt16ctlwaKbwd/YR6QVav
 b806E9VFJU0TRbtG2kDZqtYKnxIaGkQNN4bxHAL6V7UM92p0MKgCMaQQ0/t2IzghlrXS rg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xavtf45nc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Apr 2024 03:40:28 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43913aKY003010;
	Tue, 9 Apr 2024 03:40:27 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xavucjer4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Apr 2024 03:40:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gVh14f+WH8WDMVPLoG2fJxMAfPMXOcUPSEtqZImU8Vd6UH+kKOP+dST/uNQ0ZfapEN/KAJfy9ZmgnhdQHSJxRrvoGyx3Cs2BfVAtxMyUpk9KVNwipR5wU0rq+pGTlVAinIrrkdCfDHX7+CyxD141/ZXmXJDfplmpRqGibi1ZaVm98jLi+SmJTIP5RILuTJ4r3GW9AMxTBqwDvU+gEeRK4DiCzJxUc2QwWq4ah+Vo97Cx0g+glaIwCtpmY0Ml3mxamJq5ln42lBcrhyDF8l24T8wI+pfsolnIoEqPjgkRubMODj+50mG1o1N206h6FnjBCjzOorvL/y6hpdtS8/47vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gHy1nmk8HEyobci8nQjJz6rQaqjkMezXdGqSNY+fZlI=;
 b=jcaTR6Zi0R1wpoapia18gaidsmQdXDcLPv2I4/SD//V+pcAD7w9mHExLa0pRZxpzAOWeSngF3JRcSSVj4WAxQqvginqKedTKxWbhe5Se7k3xUSuQ9f7xtzd1Ze1pRm1KrLF7VJGWucJnFq8LFZ+REtaHnovQSvKORttwNH+J3MU1YznueCYUgY9KPFCOpWwG3TfbTg0eLVudgy4eKGIIZDSEMa+OQukkbCUcAR1obCl9Ys04qRdEq8c/K+2sJyYiR7hizPz8GhnryvzTMqN5GTA3RWETXl+NJaqa5KEZzoqFjMUw1VVn1j2h6KQSHfYvmUsP4x96h3f0QF9Jfne5bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gHy1nmk8HEyobci8nQjJz6rQaqjkMezXdGqSNY+fZlI=;
 b=vWeakNQNG31exOJpxKHb/msDdIqFu01F1sGrXbOXtZdFEUewpnLsWyohTmuBjE4XNi4USpUeH7zrI9CCFEdGTN8A2AdfSpqR2dhDpjQDazNrX8m5aEYBRxtfzx43s5k5/WH+XWFDY/6HWOtVfdt9uFpPLJmfs2ZjlUgkKN3rMtY=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SN7PR10MB6548.namprd10.prod.outlook.com (2603:10b6:806:2ab::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Tue, 9 Apr
 2024 03:40:25 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7409.042; Tue, 9 Apr 2024
 03:40:25 +0000
Message-ID: <1ef36ab5-379b-4466-9285-c372fc775a4f@oracle.com>
Date: Tue, 9 Apr 2024 11:40:19 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] fstests: update tests to skip unsupported raid
 profile types
To: Josef Bacik <josef@toxicpanda.com>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1712346845.git.josef@toxicpanda.com>
 <7111bf50942e0b72a43ceed010d8bab00c712a75.1712346845.git.josef@toxicpanda.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <7111bf50942e0b72a43ceed010d8bab00c712a75.1712346845.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0055.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::16) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SN7PR10MB6548:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ssjF6z2hmao7v9w2nEcMdRFKcgMh23u/BEeJZvqrFNjzzhq1PKh2kPLnfOV17P2XO9QtAjxqeDPb/0IcLTg99xQ7TeZXrjWZI6/eqagdXtKtuhV41bctkzQYGQdsNP9BxO38x7geDukps4vawHGRcOvMCry67iI64A/rD035EOJqFS09uOlRGpOAfpqNxrD01acqE/KneZSt0LWK2/++r/mOJ/fO5B9Addb3ZzhBdc+2Q5cx2y71amfsASeBZvt2oggeKiUQfvjyZFEsgcd/QozxSuAMowdRlekllJPuJdkRq4iE95Z+xvC49jRdESTtZ2wUH++/YAlsf9V/gc8GsuLqOt+UcjQNqJ7MDiV3RxV0NNRttGic4JCC/wxstipb/PBKmpXyJkI/mnTAtv6QQqM61OFtT4SwU5CgHNUR8TwbHNW95xmxa9TXfBPr6lEGlK8aMq2RC517nwukEo4tj8mcufw5/p3xjxsVyDvHqlOis1QOuC0E0WJ6SwESkzEzA5wdNbXGLry/b/gsNYYttaPgqt6FGnwKS/akVImlHeoio5hq0+smz3t68yYYE/o/catknzmbmNfzE2aHIZhM3vtrJkIeZDSvqYjFMmI1bvA+vNX3UDWj/hCUSgUErX/3w03a4WNJ6sZ3iPCk+mjMXL5/Dd+jAAuH3/fXnQ5JXzI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VVd3MThFandOODB2cldueXM4TXE5bExzaC9MUGIrRmkrWlNNQnMrbkZ3MEZ4?=
 =?utf-8?B?Q3hSWHlRS3lYYURmRHNoeDJyZDBLOUVndUtXeVJ6elJsTTZRVnBJZWs0YkQ1?=
 =?utf-8?B?NU1RZElkVUppZ3N6NFM5cnJJQllZTU5rTUhSWTRiZGFQOFhHeTFZMURMaUZz?=
 =?utf-8?B?VFdCNmtYM2hKTG53MDVSbW50ZUVzMldGbTFNeGlQanhvQkhCY0M0VFRhcE9M?=
 =?utf-8?B?b2QrUUgwUkVXdzZYTG5lUnIrNld5OGRteTBXSGVSa09mbm1Dc3l1VDBQQUpB?=
 =?utf-8?B?cUJhYkFBU052dExWL1EvejhMQktjVkFmaVBUaWhuS3FRajNUamdGZTZiVlp5?=
 =?utf-8?B?alJVcmJOUWl3RllGSWlrN1UwbG42OElGWTdSeGRwY05lTW5YeDBwKzB3QTht?=
 =?utf-8?B?ekdCcW1kK1Z6dEN0UUJsRWU4S1hMamx5NGNmQjJvMTIvdG51dUVZQWVJSjJ0?=
 =?utf-8?B?VEk3eFR5eFdKRGZ0c0JpQUpiaEJ4OXNBM1lidGR1QmovaThHckYxY2lYT2Z4?=
 =?utf-8?B?QkVack9PTzBDekNFWVk3RS9Yem5VenErekNaUGNENGQyaWNtY01kRE9SKzFC?=
 =?utf-8?B?WUVpZUt3TDVrenFWcGc2TmJ4ZnpyN1ptNHh5VnBiMjV3ajhZZG9zSHNWK1VE?=
 =?utf-8?B?eVR1UVE2V2k1T2R5a3BvQURoMEtjc000K25sQy9aZ0FDZlpuMGhMYVFLQnZr?=
 =?utf-8?B?aURZdlp5dHRHa1ZhQ2hEZk8zdkJJZGNacVVuNVVOYjZTRERSbzFIbXh3dFpI?=
 =?utf-8?B?azJyQU85Ylp6RnlLaEpLOWtFSmZleUJGUXI0WGZ4UEpreXhGUXhPSE9ZWE5y?=
 =?utf-8?B?WUh1VStlZUdNQnR3eDNEOC9hSDhra3Z6UUNXQ0hCbUlxVThMa0tjc1hmMFN4?=
 =?utf-8?B?YkIrMXFZbUdFTENhSzdsNHBWcDQ1NmZSbWdCYlo2T2hKdVRSSGN4MFFySVZO?=
 =?utf-8?B?Y3dRV3JBSVA0SzVneXo4WS9HNVFnSlBpYWRBNG1kTmxacWVreFZESWxuTnFk?=
 =?utf-8?B?ckFWbEdJOW1xNmtEb2k1V0hTbFE5aDcvOFZWY3p2bWwyT0cxMm5ER29yYk53?=
 =?utf-8?B?Ymxtc3pjalNKaDhPZmh3a1VPKzJBazlKVUN4ekF1dklLUHRiUFFrUWMwNGlU?=
 =?utf-8?B?RitiZWJSTjJQeHV4Y0o1VU5mbVRJaWtoTG90M3YzU3VHS29LTlRKNGpaYVJi?=
 =?utf-8?B?aTRFVTAwbStTdkE3ZDhhbGJ5MHpoOUpSOHc5OVM4NmphOU03N09SNkU4SW0v?=
 =?utf-8?B?WlMxRjFPODRKajdjSkZaVHlDTXM1eUUxUGc4OVdQLzdjeTY4Zyt0bjBzamRG?=
 =?utf-8?B?UFh1cmJlekMwd3FCNlhjTDFsdTEzNFJFK25kakhqb0VpZ2tTaVVBaGdhL3lh?=
 =?utf-8?B?dktzSG93ckFVemI2aE03Ui9RUkt5NENmVkJIeEFTenFLKzlQVHNMQlcvbmN0?=
 =?utf-8?B?QUo1aURYYXhOYUJnN2NZb2pYaHdCSHp1RHJGQ00ycldqWG5HMkFsYzBURlFM?=
 =?utf-8?B?ZEhFdzB6YTBvdy8wZE1DbEtjODBmdnFUbE41WlFPWVcxU2hLN0lneEJKT3Vq?=
 =?utf-8?B?ZW1tSkZaYzRTOE5IeXI2cWJseW05anAvUjBCV0Nzd2ZrbkJ6NCt6eTNKMHM1?=
 =?utf-8?B?STdaZCtVVlF2eDBsVUphaHd1N3prd0xmWUx1dXFkRUdrZi94RGc5L2Mza2lq?=
 =?utf-8?B?Nyt3a21uUlFvSHRaeDRJcHExNllNeVpvTG5QcUtjdU5QaTA2RjgxdXdWRkJs?=
 =?utf-8?B?NWRmdDllRkVVYk5xVXI4eWNoVFFwakkwMHdaUjVDWDJlSWVhZHFPWTlMQ3gw?=
 =?utf-8?B?MCtDWVV6bGF2cFJ1aEx5Ykdlbi84RU5uc09nS0tmOW44YTlxT2N1WEdNcGJI?=
 =?utf-8?B?L1IxMmhqRG5ydXhvNVJRUm0vRm9BTjNOSm1LdzdQRnRMb3hKeFpnT1J0b01z?=
 =?utf-8?B?Smc2c05FRGdGa1FmQmJTaVlGaUI5UTVvVG51aVBCajRuZnNHWG1iVUFVQldq?=
 =?utf-8?B?eTNPckRoNVJQT2FVRGxFUkI4bUVWQmUwVUZxd0NQdmpud1BqME1OcGZyV1E1?=
 =?utf-8?B?d0JYZHBBY2tNVmUzYmlhVnY2eTRpeEZiTnRwUytiMXZUUXFDVGdtUUMwNmtC?=
 =?utf-8?Q?ltnoaYKdTdSJe4+fOP9E0ZaaD?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	J6j+IGC2sT5ft4/O7FtKL1wYlMIBbTuU0e+s0bWqChIGcF2TuNbL7ZHIAaotRhCX7HwLd48Glh2gZT+jU+yerj3aGrmOol7DE9L+yzXxTP+XDN8iMlimm4HOQyQfQDuO9eqZYLfP3ij/dqZiozBJ7Hq1HNgAIT4eghvOuoNWvYrc6CamHXXCvkPjTplRHlTQQLgWX9iwCPC2Ik/pj5T3hzp7ed6NPSxfe1bJjeoGYWuDIEOr1xEeA9yVP1Igcq9DkviYezpLQTSD8AeZwMMgtDkP2vsZ3J3UvWmQdnbFFbrZl0OJSVuZRxX2KZPC5Ze5X+tdGhTQNR0mgQVW678lowis2Wi8DySdv6uBbh1mPAZ1SqrYhFqg/WYWaROBuoixt4z+rpjxTiWkjsCs8Y1DlwtZhRCLbSe2X3bA05Cimib4g+8IrK3Vuw+O33ksABrCTgXPQy1jel0VocsL7udu6Ks5cHkdzURH3+98da5217kvVdiuBUh1ceZewkhazCVHmQHg0oNtlEKFVjn0TJWUVpBmh6ruAQqrS0v0JGMJzXKgWLw7Zsf+FPKRMDbiQNWEgMV+R3ixnKZ1MTivlziAlk8EktFpY268rqOsR2FXWtI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 333a5999-288a-4330-e0cc-08dc5846cac0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 03:40:25.5270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q92D6UvrAhxtN3+9rAiNNslVBKPt/iwIDM0ZI1+0GYQ/QagNJKCVK/WjBG41Q80dQhokurEFNW3ii0pkcSpBNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6548
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_19,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404090020
X-Proofpoint-GUID: 0rzvKc5oZkr-6sC0TBFJbMkqLVyW6Rcq
X-Proofpoint-ORIG-GUID: 0rzvKc5oZkr-6sC0TBFJbMkqLVyW6Rcq

On 4/6/24 03:56, Josef Bacik wrote:
> Tests btrfs/197, btrfs/198, and btrfs/297 test multiple raid types in
> their workout() function.  We may not support some of the raid types, so
> add a check in the workout() function to skip any incompatible raid
> profiles.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thx
Anand

> ---
>   tests/btrfs/197 | 10 ++++++++--
>   tests/btrfs/198 | 10 ++++++++--
>   tests/btrfs/297 | 10 ++++++++++
>   3 files changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/btrfs/197 b/tests/btrfs/197
> index 2ce41b32..9ec4e9f0 100755
> --- a/tests/btrfs/197
> +++ b/tests/btrfs/197
> @@ -30,14 +30,20 @@ _supported_fs btrfs
>   _require_test
>   _require_scratch
>   _require_scratch_dev_pool 5
> -# Zoned btrfs only supports SINGLE profile
> -_require_non_zoned_device ${SCRATCH_DEV}
> +# We require at least one raid setup, raid1 is the easiest, use this to gate on
> +# wether or not we run this test
> +_require_btrfs_raid_type raid1
>   
>   workout()
>   {
>   	raid=$1
>   	device_nr=$2
>   
> +	if ! _check_btrfs_raid_type $raid; then
> +		echo "$raid isn't supported, skipping" >> $seqres.full
> +		return
> +	fi
> +
>   	echo $raid >> $seqres.full
>   	_scratch_dev_pool_get $device_nr
>   	_spare_dev_get
> diff --git a/tests/btrfs/198 b/tests/btrfs/198
> index a326a8ca..c5a8f392 100755
> --- a/tests/btrfs/198
> +++ b/tests/btrfs/198
> @@ -18,8 +18,9 @@ _supported_fs btrfs
>   _require_command "$WIPEFS_PROG" wipefs
>   _require_scratch
>   _require_scratch_dev_pool 4
> -# Zoned btrfs only supports SINGLE profile
> -_require_non_zoned_device ${SCRATCH_DEV}
> +# We require at least one raid setup, raid1 is the easiest, use this to gate on
> +# wether or not we run this test
> +_require_btrfs_raid_type raid1
>   _fixed_by_kernel_commit 96c2e067ed3e3e \
>   	"btrfs: skip devices without magic signature when mounting"
>   
> @@ -28,6 +29,11 @@ workout()
>   	raid=$1
>   	device_nr=$2
>   
> +	if ! _check_btrfs_raid_type $raid; then
> +		echo "$raid isn't supported, skipping" >> $seqres.full
> +		return
> +	fi
> +
>   	echo $raid >> $seqres.full
>   	_scratch_dev_pool_get $device_nr
>   
> diff --git a/tests/btrfs/297 b/tests/btrfs/297
> index a0023861..7afe854d 100755
> --- a/tests/btrfs/297
> +++ b/tests/btrfs/297
> @@ -18,11 +18,21 @@ _require_scratch_dev_pool 3
>   _fixed_by_kernel_commit 486c737f7fdc \
>   	"btrfs: raid56: always verify the P/Q contents for scrub"
>   
> +# If neither raid5 or raid6 are supported do _notrun
> +if ! _check_btrfs_raid_type raid5 && ! _check_btrfs_raid_type raid6; then
> +	_notrun "requires either raid5 or raid6 support"
> +fi
> +
>   workload()
>   {
>   	local profile=$1
>   	local nr_devs=$2
>   
> +	if ! _check_btrfs_raid_type $profile; then
> +		echo "$profile isn't supported, skipping" >> $seqres.full
> +		return
> +	fi
> +
>   	echo "=== Testing $nr_devs devices $profile ===" >> $seqres.full
>   	_scratch_dev_pool_get $nr_devs
>   


