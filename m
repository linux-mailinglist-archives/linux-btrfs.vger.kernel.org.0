Return-Path: <linux-btrfs+bounces-1963-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB8D844365
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jan 2024 16:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B4BF1F25031
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jan 2024 15:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C09512A176;
	Wed, 31 Jan 2024 15:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iJ848P2Q";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JRu8VmlH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D4812A162
	for <linux-btrfs@vger.kernel.org>; Wed, 31 Jan 2024 15:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706716182; cv=fail; b=fbhH6LcV/fVya5aG4t6Z4YUZ3kqv/OJcnLWLyir3DTAGQ1tofNodCr5mIQdmly6SizUp1kqZ6AWphWgibVIyPAbcVWRSw6memhzDBfdKmevSM8qCg0673+UAoaRiERPwwSx0SPUDpJZ3REXmmyRW+wF1OfTDXo/ESks6Ju52ges=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706716182; c=relaxed/simple;
	bh=rhAkmBhTWKTkuul1Ni3LRnNuNkU+DjTp0vGD91hz7WE=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=u6ufwQ0NtzFxxZ1ycB50rgYWz3PBI8/V7Zf0MmhXmvxJJWLOQzdd+XImH3+1O2Ctc+IBej8NqOQXu8efq7H+35mVb30F8jHmp0A23dFR7dpECyw1j4mxAJFbnSBMMEMQLfkjDYQLmOK+wc7ZnvJpxF4Y+GEv1dlYX1BSII4wcow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iJ848P2Q; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JRu8VmlH; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40VEx5jc022246
	for <linux-btrfs@vger.kernel.org>; Wed, 31 Jan 2024 15:49:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=VGZCkwam70rN4TiyB7RmjGgrOrik2xAlUlV/KdWkw4U=;
 b=iJ848P2Qt8ou/w8L0q6mEzhi8VuWDQv0IfHSRwhc6GxlK9zHhrrYkfDSYDsex0c1dgpM
 d1iZyZk48vtIEZdO1o0kKAm+z+vPgjE66EYJzAogTy+aT2NW/G34Cl3KxCQPVncbHCKH
 UM7eP23uWzVZx85crDzYrPpsgjWBfB3eqGB6GqhpJZsXdUCFU4neGk09+AcF/0eaz2LQ
 CUP6H06jI1UDpIDGZfe8zgxi2HXLfRMRknjNgOXORI8IcoQONzv68rBo1lIYJODu89+j
 MnOaSbiUlP2ss5OSsL8NEzgBrDQjbJcpkZPubX2m1hvHI/804j+ezDTzBKgwkHcNTKmS IA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvr8ej03w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Wed, 31 Jan 2024 15:49:38 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40VFXJaI028470
	for <linux-btrfs@vger.kernel.org>; Wed, 31 Jan 2024 15:49:37 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr9972kv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Wed, 31 Jan 2024 15:49:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xo/uY7ZYom1NGg6JvxOqjH2DRne7BfvArkEkoMtZwcV71OzhJ2tNjJUdRr0heU0FRQytVxiJditRmxTUuUkpuOZG/yNf0pa362K6PM/PmQoT6yA7rvNtuPVVtJwGCEcgSPWWei5NuzfgxOoFW9Xwuuv2eyuQ9nQ8jGAJXg6Yfu4bAl46SRdSIU1f1DedDDT8j3MTszV2/PihR2O3ekclYW19CcPy/Zt1xCHEt4mGBuStrmFhlx/IoLgM/a2tq46f/SuLULc894KL+YB74hpHOm/DeQzu0yig+MvF6lhzj5xYLaLiUsNjbjFdZNrPEJ5E0FTCIY1NAMt83oEBRwHHtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VGZCkwam70rN4TiyB7RmjGgrOrik2xAlUlV/KdWkw4U=;
 b=m+09WNhJWcy06+xVuFxQu1YB53bPOFRjSPtnLokhvkAIgmR/85+PsnqbNYkZlWlqtbTsDKJZdCvzkxJ3g9Eywo3H+/GFzQt+Cy5k8v8VzpIzPnUfgSX1EZIP5eAs8EXrsBhMrX7hpxfseMHcjUceEslnPUNESEicxx+iKQuauLLMpTNujS+vAqbod1rwFBH8CW1nowYIWbgJhi0bx5TU0izUAWEVs6c1YYFhmxxlfP8xrLnCY508Yd4KCVmzrVyK8nJ2sR9twQBtigUz22vHCdwKOxeEQMR59ntRFQJu5oEw7vnzuazbWQj21smmD9XqcFFeO/QLfV19eD56GkLl3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VGZCkwam70rN4TiyB7RmjGgrOrik2xAlUlV/KdWkw4U=;
 b=JRu8VmlHzrqx+ApN/uNG0u/kcKwN2Vp5zLFJVT3msuL73LrKEEWs9JjVWJ1DRZ5x3cZpWtBx0piytuK7E9tguWKHW5WTQoBSdsjJ4rb6QBLFEreZXps0e6/0vXKR/ZsRyHEiI9epNEZXadOwIXCa1Kz87nscccUC1xcx+uU8tvI=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CO1PR10MB4449.namprd10.prod.outlook.com (2603:10b6:303:9d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 15:49:35 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690%3]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 15:49:34 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH RFC] btrfs-progs: mkfs: optimize file descriptor usage in mkfs.btrfs
Date: Wed, 31 Jan 2024 23:49:28 +0800
Message-Id: <06b40e351b544a314178909772281994bb9de259.1706714983.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0110.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::7) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CO1PR10MB4449:EE_
X-MS-Office365-Filtering-Correlation-Id: 269efa38-8368-401b-5955-08dc227438c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	F4/UPdWn/CS8YaMfq8+DnsGYC90WI5mPGZs3juc+8qkBsJ+wssruBuGmOsD1B4BAEjCtM4T4ZkEL2HeQLNU3e4+/KH1a4BRPlohC7chKPmbDhkMniI1/UlXHcTAUj4+z6ZVvVWdoikMOzPJzfSVVg46u43dWhFccJSA19GpLpJwuxA7QAwZduC/VugpN6fjwzJFntEIwuD0ncm/2psTeEcpc1EKg0bNWWR6spQMg7Vm9Vd+bLn4nrwwT3y19ZeBlKLom6ddp6DIsAt1eincqBbYMzbyOHrDmHKtem9KRyQpG2Bh4q/odyktGOyYjF+N6gIAvbVeYnIuDpnMf+HwarvrGB0JodBx3Cp95mniQsvBhtpna+b0Rq7v5YdymI7+shNNwt3H3u4xyNvOT29UqmM/Z4C/owla12DK4HO2TzAERXq8AOuEdatzh3roeA+HDIlUUshy6zPV1rRYgCI/aPnWDY6TjrTan4qGgWYc/zxwq91EO6TlMyFtNitqqYQsmkeiR5bqJYyoz+kjJeGl+b3nfIMKcoB/dy59RSUvT62Biijw1VZGZa/1iP/0oApIA
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(39860400002)(136003)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(41300700001)(83380400001)(26005)(2616005)(6512007)(38100700002)(8936002)(44832011)(8676002)(5660300002)(2906002)(478600001)(6486002)(6506007)(6666004)(66476007)(66556008)(66946007)(6916009)(316002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?jIoKhXjMlrWQYT3ofEwg9foPBFot/lfLnYOyHXb3QMmQXAFXYGTCdFuUhbL0?=
 =?us-ascii?Q?qkbgzvxTLF+JddsB+xZo3B8wiHZBrXkG4GIvGejH7Yp1vhfAy7yW5mV80r+p?=
 =?us-ascii?Q?kyVb5u2NIIcU3v/sFbj51hj6ke0ifoMEjksFzM/vn4pX6hGj+oZ8LPEPc5fC?=
 =?us-ascii?Q?65i5EsuOdw/jWegE5wEzAo/+KAl0enHyUlzgEOG4tAh2ypx0lQVE2TS1yLYS?=
 =?us-ascii?Q?GUs4rp4fQlolXsVqOQFba0NbPRCY2/OJBTnjr75xPezQ+o8G4uDiDDUpOXHG?=
 =?us-ascii?Q?ReCSU4xY3IBNHQIIwgcXATc+P95lPlAkM7gPgEXkUMnCxsKOmv0+vbCu3y27?=
 =?us-ascii?Q?ROENWd4tC5S5Voe8KKL6TocbbTK7dAwZTHs8pCnITbu8+AikAD7RQ7ynJzDw?=
 =?us-ascii?Q?Dn+jmbLMVQdtcIPiNg33PT4xXSGklpbqclYh+sn9cECiCfz0/uHYLgBH4ROz?=
 =?us-ascii?Q?Bi0GSRg8qac8NeM6K+dvc0nxucFQgMSbgRZMGeOfu7xxyiQTLAluCD8ZAyuD?=
 =?us-ascii?Q?p5HYO3oWG3wAVYVWqOyHd8wRgDSN5ju48vEyLqs/FXtPuug3+6G7qv1yzTDH?=
 =?us-ascii?Q?Woxbf6MCV8AordjWFfiDOdvc1q/V9MfczgqQ0MtOKLMUYdlthwY92jLWV7fA?=
 =?us-ascii?Q?OEToMFKQEChCdnc1HXVZ/tSNdBvDyjZqEI4duH1qNxth7zcDu/b6mDFE94sD?=
 =?us-ascii?Q?vvjxx+bhkU8iU3X0/io6NZ78hLhdfvLTpKvxpGV5XCsOX++hSgCJO2/5nmyl?=
 =?us-ascii?Q?3LXPiCAji4mqDSyc+3oeIO1Y0t29cz9ndWpbvR8RMiTZfsWZvmeYfWg8OlM8?=
 =?us-ascii?Q?GXjV2jXaraf1R3w3D0tzhvbSES7q+ofV5OSaWBWyVEWqE2fl2iCAGn3jiEiz?=
 =?us-ascii?Q?onsQWrOIfavQfrWysEv8zkUmMCwIO0F0n2vHdhhr938GMiDPGGsbkyRdrF0g?=
 =?us-ascii?Q?3L6EKIfebJa0OegHXNy57uRnJUQW58IbpsAxy29PTeyiBmXqIsfJDL4iCTLu?=
 =?us-ascii?Q?tr9+SlP38N9Rmi/4LvFDns2WDJ5KsI67KsbuyMi1unbU6QB3J5Oadfb8upHi?=
 =?us-ascii?Q?F4TrpW/kNm0uMZ+ljbXwcj+L7UpyrVVMiprnBBkG5eHDHGXaq5oesWmbY8XT?=
 =?us-ascii?Q?thIFRXZUqpHNYmh3nSnFUZurSAAtJJt8zDrEV3ZDSsGJzBFJHR2Cx+BLmo6s?=
 =?us-ascii?Q?Rq8PnLniA5RNQufq/aYMAuPvr8x/G2FS7kaiTh9ZeHKf6aKGH/8fe2TmfAe+?=
 =?us-ascii?Q?2B9gTE/GeqqsjjH89zEYWZ9zIVJNrmkeZCknujRaBh1Ad9ETDbgYgaltXQQ6?=
 =?us-ascii?Q?/Q9Nu5r65ffxqVBMlkRYesPg5LEzO9aUnn8BkcoDra74yhyGNCci8NNqtiXm?=
 =?us-ascii?Q?zY0UKn2mkWNUlBGUhM4+DrPchRpcH7uQgnjPqDxLFkx/aPQrneDiEwVA4YFm?=
 =?us-ascii?Q?XJXViaZ9EG7cv3H/Ibw83rFfMcBoSgNIYNS5KDSW2rUX+lbYGkMqcxKDpZ0A?=
 =?us-ascii?Q?lOKNK+c3ZbOvLgunUOuznoU0kxyZtVwBzZX5uZva1VQsIP8WQajq3pz49K1C?=
 =?us-ascii?Q?whpYy2IU+5DH89lApUFPdQbW+e07s31KLyxeGYkT?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	hg2eUMJMLL6eYR4TRbG6tvrZ1P9d8Jc0AgOc6kSMtIkK+2h76cMk14GKdANg/b7AwNNfNdzi3gKSkIZ1YUwLHzm+H+CyDaMcV0v3uOg1v98MOfyC22rlqfmi6uOKlazmwP8ceuBR66tw4qScZJywctLFW9AT+3Kj8HBJ2LWQDKVIEIdSoj9ep/4RDE21G5IwsOIXoAGrLUn1yqR59/4i8EzVFMqJIp/IFjg7f3GxF3z1Fw1hj4kwDppGhDEn0e3kd3C+gIWP6F63LPhIW4FiHb+5qEQASg3pJNwEJxKP7s6pRciYVln6Du+RErng7YNow4ZKRQvuJxedLVeS8S0o+eBnexgCePwiYeKFrw9oFHiyY/4I4yemIKPvYYfmRTmWCBKHWWpoasmu55uKYZLUOJV8LEH4APV30vc9cNsgiVxzPU4nu+D9bxuzhlPUBGthxqzfSERepyce8DT/NN5xSl4KZKWkm8v9MARvpKi+OsDpZdJMFqBIvqP5rpSvrVl/yONWLShA8xpFPeb/Ol5+APGq3TB9LMb4gjKYKShTElCNw1AO5PAq+7TfVPb86W1m+91frG0CY+B6/2rH2lPzly5uiH5J874G8/oVc6iuTnY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 269efa38-8368-401b-5955-08dc227438c1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 15:49:34.5110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n3/BLDWv1WFik2UDQ9IEUax+YTTVa1np83MgK7oQ69Sqe4s8Aw6LiNHmsVCAQBjXMD50UwkJ/dpyJ3vKONUGBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4449
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_08,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=999 spamscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401310121
X-Proofpoint-ORIG-GUID: FnLUrUuc614YUEnGE6NwR5EKWzh3k7ji
X-Proofpoint-GUID: FnLUrUuc614YUEnGE6NwR5EKWzh3k7ji

I've reproduced the missing udev events issue without device partitions
using the test case as below. The test waits for the creation of 'by-uuid'
and, waiting indefinitely means successful reproduction. as below:

--------------------------------------------------
#!/bin/bash
usage()
{
	echo
	echo "Usage: ./t1 sdb btrfs"
	exit 1
}

: ${1?"arg1 <dev> is missing"} || usage
dev=$1

: ${2?"arg2 <fstype> is missing"} || usage
fstype=$2

systemd=$(rpm -q --queryformat='%{NAME}-%{VERSION}-%{RELEASE}' systemd)

run_testcase()
{
	local cnt=$1
	local ret=0
	local sleepcnt=0

	local newuuid=""
	local logpid=""
	local log=""
	local logfile="./udev_log_${systemd}_${fstype}.out"

	>$logfile

	wipefs -a /dev/${dev}* &>/dev/null
	sync
	udevadm settle /dev/$dev

	udevadm monitor -k -u -p > $logfile &
	logpid=$!
	>strace.out
	run "strace -f -ttT -o strace.out mkfs.$fstype -q -f /dev/$dev"

	newuuid=$(blkid -p /dev/$dev | awk '{print $2}' | sed -e 's/UUID=//' -e 's/\"//g')

	kill $logpid
	sync $logfile

	ret=-1
	while [ $ret != 0 ]
	do
		run -s -q "ls -lt /dev/disk/by-uuid | grep $newuuid"
		ret=$?
		((sleepcnt++))
		sleep 1
	done

	#for systemd-239-78.0.3.el8
	log=$(cat $logfile|grep ID_FS_TYPE_NEW)
	#for systemd-252-18.0.1.el9.x86_64
	#log=$(grep --text "ID_FS_UUID=${newuuid}" $logfile)

	echo $cnt sleepcnt=$sleepcnt newuuid=$newuuid ret=$ret log=$log
}

echo Test case: t1: version 3.
echo

run -o cat /etc/system-release
run -o uname -a
run -o rpm -q systemd
if [ $fstype == "btrfs" ]; then
	run -o mkfs.btrfs --version
elif [ $fstype == "xfs" ]; then
	run -o mkfs.xfs -V
else
	echo unknown fstype $fstype
fi
echo

for ((cnt = 0; cnt < 13; cnt++)); do
	run_testcase $cnt
done
-----------------------------------------------------------------


It appears that the problem is due to the convoluted nested device open
and device close in mkfs.btrfs as shown below:

-------------
 prepare_ctx opens all devices <-- fd1
   zero the super-block
   writes temp-sb to the first device.

 open_ctree opens the first device again <-- fd2

 prepare_ctx writes temp-sb to all the remaining devs <-- fd1

 fs_info->finalize_on_close = 1;
 close_ctree_fs_info()<-- writes valid <--- fd2

 prepare_ctx is closed <--- fd1.
-------------

This cleanup patch reuses the main file descriptor (fd1) in open_ctree(),
and with this change both the test cases (with partition and without
partition) now runs fine.

I've done an initial tests only, not validated with the multi-device mkfs.
More cleanup is possible but pending feedback;  marking this patch as an RFC.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 kernel-shared/disk-io.c | 30 ++++++++++++++++++++++++++++++
 kernel-shared/disk-io.h |  1 +
 mkfs/main.c             |  2 +-
 3 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index c053319200cb..b4951d229647 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -1660,6 +1660,36 @@ out:
 	return NULL;
 }
 
+struct btrfs_fs_info *open_ctree_fs_info_mkfs(int fd, struct open_ctree_args *oca)
+{
+	int ret;
+	struct stat st;
+	//int oflags = O_RDWR;
+	struct btrfs_fs_info *fs_info;
+
+	ret = stat(oca->filename, &st);
+	if (ret < 0) {
+		error("cannot stat '%s': %m", oca->filename);
+		return NULL;
+	}
+
+	if (!(((st.st_mode & S_IFMT) == S_IFREG) || ((st.st_mode & S_IFMT) == S_IFBLK))) {
+		error("not a regular file or block device: %s", oca->filename);
+		return NULL;
+	}
+
+	/*
+	if (!(oca->flags & OPEN_CTREE_WRITES))
+		oflags = O_RDONLY;
+
+	if ((oflags & O_RDWR) && zoned_model(oca->filename) == ZONED_HOST_MANAGED)
+		oflags |= O_DIRECT;
+	*/
+
+	fs_info = __open_ctree_fd(fd, oca);
+	return fs_info;
+}
+
 struct btrfs_fs_info *open_ctree_fs_info(struct open_ctree_args *oca)
 {
 	int fp;
diff --git a/kernel-shared/disk-io.h b/kernel-shared/disk-io.h
index 68cdf5b08d52..0f2aa24a50a1 100644
--- a/kernel-shared/disk-io.h
+++ b/kernel-shared/disk-io.h
@@ -199,6 +199,7 @@ struct open_ctree_args {
 };
 
 struct btrfs_fs_info *open_ctree_fs_info(struct open_ctree_args *oca);
+struct btrfs_fs_info *open_ctree_fs_info_mkfs(int fd, struct open_ctree_args *oca);
 int close_ctree_fs_info(struct btrfs_fs_info *fs_info);
 static inline int close_ctree(struct btrfs_root *root)
 {
diff --git a/mkfs/main.c b/mkfs/main.c
index b50b78b5665a..2526fb2317e5 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1800,7 +1800,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 
 	oca.filename = file;
 	oca.flags = OPEN_CTREE_WRITES | OPEN_CTREE_TEMPORARY_SUPER;
-	fs_info = open_ctree_fs_info(&oca);
+	fs_info = open_ctree_fs_info_mkfs(prepare_ctx[0].fd, &oca);
 	if (!fs_info) {
 		error("open ctree failed");
 		goto error;
-- 
2.39.3


