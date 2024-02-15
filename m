Return-Path: <linux-btrfs+bounces-2406-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97838855A7D
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Feb 2024 07:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78362B235F9
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Feb 2024 06:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5F7BA37;
	Thu, 15 Feb 2024 06:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NSd+e4uB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rM1J2LqW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02ECBBA2E;
	Thu, 15 Feb 2024 06:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707978904; cv=fail; b=UeJQ0qaH1mkUF/t2m8aqPbWiRx3YrNDVewWW6kGrmfVYxYpUN83co4LMjAHg3/0fgZn2qrBWKBQHGwk/1SInWxeeHItWsWNHX76zM6OaY4I+bxKgkBcMQHLIifRDyXRbTz0iYXJ6YyikeVfIh6xoaGvFhc3hD0nvbAOkvzR38TQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707978904; c=relaxed/simple;
	bh=yyIacDM5ayoSBT0XqHyL2p84REZmqxhNFussYZFa0l4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hjH3mtRsVCUtZ/RXjeeBuTdrh6Qh9GHZnJ5zXJWmd6ukfv6iZU/Q5+7z8FW5qMrNSvUu9yT6nmuCK8PSISAb/urNVNj+ixn/4m8A2TE8tqKwZfzkqSJjuJD6qw/STIEGcpX4VVuSCPkQ9i3tXzq/QQozf5nXoNQxYAasqiDCrVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NSd+e4uB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rM1J2LqW; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41EMhnJN004429;
	Thu, 15 Feb 2024 06:35:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=mzPilJ9Dky27J1GhpEJaqB4pgPSktB63NaNtjk5yDGU=;
 b=NSd+e4uBHf1UXIxKJqnDUvxkM/ZmCXnFa7jkpbcqWkHzXa91SIpRJ3e7cJ0SFA3yYmZC
 sobi2ZS0EGudc1sB2IiO6P6QCp5BGtZOAwbsxrccefB3aLKCQ7WASjomKn3PiM9cbxb6
 DByNOijjYqj0iLKuUsdI9MKfWoETqmXPDJgTl+rxx+/1vXT0il0raFiepVxKFazy/Mog
 fRmlKuTojH5F2NzHh4sf+C3MPJLWGGzd3WcCKS0qyxjo+P8YS6WfnPkvBHf+YApI5k1A
 pMK4WWYUB7rW5WeVk9EZeeRM1k1Ki18+xP+FIOV9R+YoRhu4n9Yhr1cocUumHLiO5cCC 3A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w930112pa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 06:35:01 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41F6Mcw9015185;
	Thu, 15 Feb 2024 06:35:00 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yka28rx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 06:35:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j+HmzdB3+ZxEtJUGtYIQ3VI46NGAr0Ys99U5Tq4DQPKbW81oxx2EzDocvs8WIU4HadDvzT/n724TwSB5k+q+BFVhf0jbp0IyKk1dnHUgQ5dhj7HhDCb8zp8pljDRzJhxvnLKKm2x7hTt7AFCRWfZMcayY1td3YWd/6Oi8KWil5lIt+tg0jh/SUEnqd4g4jQg1RJkZHFg1pDXADXQsdBOC0I36vwVz5UfRYM9WDP6IW51GhBRKqhpoYZqOZfh2ZsvBAm1Cd8QpK6bQk85nNnD5x4ST6pJTemLjIBS3QqUiXpPOhf/OlgHgL37EjS3gAodOPgflqojeh8Dg7ncPruEag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mzPilJ9Dky27J1GhpEJaqB4pgPSktB63NaNtjk5yDGU=;
 b=l7QxD1yGgp9qCpTUNvJKwLmeLQjo7LwhaigulfqUz38zBH3IfbqKIB9U9ESVjChQ1j+35vCmlZCJbmkjx3SFVxo4U0+NxZVu3UC3w1Qe8wFy62DILWBznuLbHXWCqvc2Hw16sKDto0BOvfMud8OHOUy4Q10B3wp2JadTWqplGHKbi+mc+OZwLwZz0Nlwae6Wr5XTUguFi1XPUbDzLpZQuRMwwzrtBF73GKUSgN1w8x1/Pr1fDrSkJXvNgsHNMcV+co+5JYpAPN1dil885CHnWDgnaZixW6m6LTEfdVcxStlfNqCcCO1/tD1LvDUQmD2kNyoilqPgDR/Im2JIXlaSyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mzPilJ9Dky27J1GhpEJaqB4pgPSktB63NaNtjk5yDGU=;
 b=rM1J2LqWZJxjGecj4sB8BoF23OIr9RbfOhrkHd/6tx55/M/bWBO80ZyjI6f0OAN+2QFjFasSluwS/LDP42t9q92uWnxxe/wyjCTBmL//iRRQMPFR26pOUpeO2Fa4/tGABJGX8JdBQot0tOvaGvjYXBsYlZxumrMoBjDAwK07R2E=
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com (2603:10b6:a03:3ed::15)
 by SJ0PR10MB4544.namprd10.prod.outlook.com (2603:10b6:a03:2ad::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Thu, 15 Feb
 2024 06:34:59 +0000
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::8711:ada3:7a07:ec85]) by SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::8711:ada3:7a07:ec85%3]) with mapi id 15.20.7249.047; Thu, 15 Feb 2024
 06:34:58 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: [PATCH 05/12] btrfs: verify that subvolume mounts are unaffected by tempfsid
Date: Thu, 15 Feb 2024 14:34:08 +0800
Message-Id: <c5db412fcb3d6d7dedc2f75d1384f78a5bbc2cb5.1707969354.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1707969354.git.anand.jain@oracle.com>
References: <cover.1707969354.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0012.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::11) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5694:EE_|SJ0PR10MB4544:EE_
X-MS-Office365-Filtering-Correlation-Id: 965c2369-c3a1-433c-d8a4-08dc2df03b14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	tfN9HbOLJP43fkcvK1JaOEVQjEa6ikZIplBt9zmnHLeCZYOPW6mDl1qL8bE2Lfkp0p34bXoW9yE47Y2OidH2dkphfVuXF+E30q/QtQTPbzn35SMlmEWcBHrmVP3lPgMSBQmEfuMM5YFRZhXdoVsjemHrq3gXLKft/Q07yYuPKWYFLJrwJ7potSYdyXXiy4ZFR3Id8W6AR2enJNw8hc8vFGD+1Vuv2jD/LP8ObbO4GYyR2GishTya8DfzTGAG+33QVHvWqEBH7BYoe7Sr21bwRkCLHg4MeaeeizI3pErzBZsfmwe4fUNBDzez8KX4b8yo6NUY2Q6ELLX9WQGrtDUlxvyrHfu5lhCF6Z+HZ2hZwvyN7Rj2GQS6EUiGL7mwdQdPFZG0A9wqZmB6oSISusfcVCMHYdSkTUN6XRok5SwryNmKDuKd+4X2KFprbQuIMdvc19ge7NaRa0YhxuYVcMiZs7CdAkgwDY4Ct9kzJQI8E5c6pSATmloLNuC6rk5kn/UYNYdT0gdWxIeMfJbl0HfX8aqnjTOij4kca/qsK3vWwGenQXy7d+E72z0BHuU/X6hv
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5694.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(396003)(39860400002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(316002)(5660300002)(41300700001)(2906002)(15650500001)(44832011)(86362001)(36756003)(26005)(2616005)(450100002)(478600001)(83380400001)(66476007)(66556008)(6486002)(66946007)(6916009)(8936002)(4326008)(6666004)(6506007)(8676002)(6512007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?paEQETcql9Vl7Jh7CBA8Q5zK7EoJVMS9KzKTttx5ncFqYsrGuvs37Vl5a7lt?=
 =?us-ascii?Q?soRiKxjlQZY8Ucro13nZoU2DqnjNuNBdvXq+qPOMVYFnvs6rXjB85Agevm/y?=
 =?us-ascii?Q?YRkHAY1HzWWxM/dN3dvZaXOk0Pi4txTmFV7P7qWc7pLMAY1TNwfKWq7YtWWX?=
 =?us-ascii?Q?MmOtcuHg7xkSW4VOOzPVfHKiOsCsZ1cg0yBZZkttQ+afURwd+HU6fbixhD/r?=
 =?us-ascii?Q?KadTzLg0gdvqBVMwmLBcpGLRFvPw+m+E2k2r4oViFFrHmEWZBSAeplS89sl9?=
 =?us-ascii?Q?0z3ayRw6Kf0CQJbKpkAZ0m2NC2yo1ZAexCIYpj0acsCTxLUgxP/x3qWR++x8?=
 =?us-ascii?Q?D+g9qPspgMTYnXPzIBCsShm+VssRiPRCPIdMFQaE5mINKfa26zDcTpc02QaT?=
 =?us-ascii?Q?qc+HxPPZBWtOHBUjI4dolJiWGbm+glJlBsNHjnm+YS/IA4ig1DTVd6in8Oyy?=
 =?us-ascii?Q?6mRTQcwsQ0x39JGFZjLsR8eyQQAPhIOdP6tDu+85N8iPkZ4VoulGmW/mfrr2?=
 =?us-ascii?Q?Xd0d+/E1TTVfuayjWLAw6of06TZWjRW3KvEz4ubpZKCrRfpAFkrTkp5hZwiN?=
 =?us-ascii?Q?PPcuDhsvrLeGOyMKDp9o8hiJFBvoiSTZHRKV9qobASUNHYHpr6ScdC5Lzhuj?=
 =?us-ascii?Q?HPzY75yhID0yuosKzJMJY33qaUkpDwvnL0bd1XCVpXdxFzjucAObrv3k4OQw?=
 =?us-ascii?Q?/lbkN3PXgOL8+n24hEKIruKhmONqjl0AQDXf4QyMd0HzNgVgj5uJP7fC/LFK?=
 =?us-ascii?Q?mS+YjTJteDdn7si5Lzq+BNvef3ubxK1ty9dj0a32gh6vGvRG7RBcyqjjVV/+?=
 =?us-ascii?Q?EOSLqsirAXthIzFc3fVsx/69CpNtRG+ATrRLq8Q0b2e66WkQ+pzljO0J1bhC?=
 =?us-ascii?Q?Dk++ysqGK9SzeQpD948L9CZQX5bsxTzRpFaBgFRbglngpFI2F3xOmOBORdqg?=
 =?us-ascii?Q?u33YksT+fcKxK5CpG3sA/HLTlHZ8HrPuvw9dANxP+25OuzTvP0zEIskBaHie?=
 =?us-ascii?Q?qTK5yaS0XxjmtNnhn+QiVdq3mGD9uGU7SjNBItvzTaV8YQqGRHXElHkS+ZzG?=
 =?us-ascii?Q?3IPkmd/LM+jm0xDfwwRjSZ/bDUQa0KT1NpBYOoP2HNoFqOJPdGKOoUa7lAPf?=
 =?us-ascii?Q?JyK/p83P7l0z4YtJmrFgKxYEyNyNb5wp2akOKZE4M7P/tv4u2qr09hM2B0+S?=
 =?us-ascii?Q?zbrwdGFGJ1N+ss1TC8wFIxVHJumbN7NN320KJ7RHxKg3PF9VXos9urzqjxv4?=
 =?us-ascii?Q?ld2gz3TM8DDfFeMjgMAQjZm7AJePVEDBXAREJqdpf0fclYO4T7NTJXi17LHx?=
 =?us-ascii?Q?z8eRbseCxu4pnobiSKABWXwir4uOhSLeS/irIql4LlcwJg/Yjti6Ykz+L7JF?=
 =?us-ascii?Q?WxODdN970FI3fXCOzu+Zanr5bGo/udRlec+omqBEW3vWYX4KS89/qSF3o4Fa?=
 =?us-ascii?Q?YJ6Qc20bU6jmMccKXbFg7ZttRuA2gnl5UnY46L8V20s5Tw/aJ1ZQKSQyV8+8?=
 =?us-ascii?Q?vK557MaXVfPpEBtB/5tyaHGhdVPdhwHyNBrOtPIMOBOa8NPuIlI6NpfWNWqQ?=
 =?us-ascii?Q?i74pLHyX/rZLmAbiXfMsZwPkVRl0xyexKH/gwQT8?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ra72m9XtztCnyKIRfOsM4f4jBz77QAOVgAT+vLCU63yVy3UESSWQjgvO3na+/yuoB+2HpMfPDhZdR4cOIoZZHNtLrdOPilVxLJwC1jdX+PUbFHffkBqjg7nD4wLuH40HXR36Oq5QWepoB04fRoKZ6vSUecQbNzWbJetkNPvb5xMHMvhf474oU3yAj5jfV9XPGGyNRHi2cst6fenaOOPbmpsLRF/c7kYd3gEQXKOm/fvQ5FJ2v4v4kGtjSPVNpREiqdsP6O2Q04nd93gptlMEqKtUPaGem+rBLpiv2kiFVA3enCKabHGUN18kOqpMi0eNuvZnNRQXn9apLScTwXdtCz+xXnkZDT+KTUHF33fBgneQNRK5c9SSAnZnXrcf5LGdG6XQD99A4bHXDffPHwvFvjtqC/FQeYbQOEjkkdgwXXC9cf5O0GDNocGQBXOneemUv0jTpfCWS0lQTGpEPYAnqXz9+2RoOtrLPR4T04KVy7xqn+XxDmeC0AzTAlBXWF2qg1VGpg6O4kriDQGjan51/deryo/2nEg4FMztOwymQxLOWxzBlbnSfG4lrxjsEfVSKXLTn9H3XVE6oMIZlPIQg3hZ3DtUlOrqcwhRQnb2G8Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 965c2369-c3a1-433c-d8a4-08dc2df03b14
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 06:34:58.9384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HP1Ht+ZVjkPFlgfktj1eV7UnBNQDf2Sbf04FbicnQZzyVRgJMDLvwmk6bPdGvYobLAoSAhzQFg52SU///7FPWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4544
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_06,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 phishscore=0 adultscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402150049
X-Proofpoint-GUID: Nk54DhjWeDZWDBIy2s1zIwdedYtOqVvU
X-Proofpoint-ORIG-GUID: Nk54DhjWeDZWDBIy2s1zIwdedYtOqVvU

The tempfsid logic must determine whether the incoming mount request
is for a device already mounted or a new device mount. Verify that it
recognizes the device already mounted well by creating reflink across
the subvolume mount points.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/btrfs/311     | 91 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/311.out | 24 ++++++++++++
 2 files changed, 115 insertions(+)
 create mode 100755 tests/btrfs/311
 create mode 100644 tests/btrfs/311.out

diff --git a/tests/btrfs/311 b/tests/btrfs/311
new file mode 100755
index 000000000000..71c26055fa1e
--- /dev/null
+++ b/tests/btrfs/311
@@ -0,0 +1,91 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2024 Oracle. All Rights Reserved.
+#
+# FS QA Test 311
+#
+# Mount the device twice check if the reflink works, this helps to
+# ensure device is mounted as the same device.
+#
+. ./common/preamble
+_begin_fstest auto quick tempfsid
+
+# Override the default cleanup function.
+_cleanup()
+{
+	cd /
+	umount $mnt1 > /dev/null 2>&1
+	rm -r -f $tmp.*
+	rm -r -f $mnt1
+}
+
+. ./common/filter.btrfs
+. ./common/reflink
+
+# Modify as appropriate.
+_supported_fs btrfs
+_require_cp_reflink
+_require_btrfs_sysfs_fsid
+_require_btrfs_fs_feature temp_fsid
+_require_btrfs_command inspect-internal dump-super
+_require_scratch
+
+mnt1=$TEST_DIR/$seq/mnt1
+mkdir -p $mnt1
+
+same_dev_mount()
+{
+	echo ---- $FUNCNAME ----
+
+	_scratch_mkfs >> $seqres.full 2>&1
+
+	_scratch_mount
+	$XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' $SCRATCH_MNT/foo | \
+								_filter_xfs_io
+
+	echo Mount the device again to a different mount point
+	_mount $SCRATCH_DEV $mnt1
+
+	_cp_reflink $SCRATCH_MNT/foo $mnt1/bar || \
+		_fail "reflink failed, check if mounted as the same device"
+	echo Checksum of reflinked files
+	md5sum $SCRATCH_MNT/foo | _filter_scratch
+	md5sum $mnt1/bar | _filter_test_dir
+
+	check_fsid $SCRATCH_DEV
+}
+
+same_dev_subvol_mount()
+{
+	echo ---- $FUNCNAME ----
+	_scratch_mkfs >> $seqres.full 2>&1
+
+	_scratch_mount
+	$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subvol
+
+	$XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' $SCRATCH_MNT/subvol/foo | \
+								_filter_xfs_io
+
+	echo Mounting a subvol
+	_mount -o subvol=subvol $SCRATCH_DEV $mnt1
+
+	_cp_reflink $SCRATCH_MNT/subvol/foo $mnt1/bar || \
+			_fail "reflink failed, not the same device?"
+	echo Checksum of reflinked files
+	md5sum $SCRATCH_MNT/subvol/foo | _filter_scratch
+	md5sum $mnt1/bar | _filter_test_dir
+
+	check_fsid $SCRATCH_DEV
+}
+
+same_dev_mount
+
+_scratch_unmount
+_cleanup
+mkdir -p $mnt1
+
+same_dev_subvol_mount
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/311.out b/tests/btrfs/311.out
new file mode 100644
index 000000000000..8787f24ab867
--- /dev/null
+++ b/tests/btrfs/311.out
@@ -0,0 +1,24 @@
+QA output created by 311
+---- same_dev_mount ----
+wrote 9000/9000 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Mount the device again to a different mount point
+Checksum of reflinked files
+42d69d1a6d333a7ebdf64792a555e392  SCRATCH_MNT/foo
+42d69d1a6d333a7ebdf64792a555e392  TEST_DIR/311/mnt1/bar
+On disk fsid:		FSID
+Metadata uuid:		FSID
+Temp fsid:		FSID
+Tempfsid status:	0
+---- same_dev_subvol_mount ----
+Create subvolume '/mnt/scratch/subvol'
+wrote 9000/9000 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Mounting a subvol
+Checksum of reflinked files
+42d69d1a6d333a7ebdf64792a555e392  SCRATCH_MNT/subvol/foo
+42d69d1a6d333a7ebdf64792a555e392  TEST_DIR/311/mnt1/bar
+On disk fsid:		FSID
+Metadata uuid:		FSID
+Temp fsid:		FSID
+Tempfsid status:	0
-- 
2.39.3


