Return-Path: <linux-btrfs+bounces-2889-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F28C86BE7F
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 02:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5C811F247FF
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 01:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156EE364A9;
	Thu, 29 Feb 2024 01:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m0uqkTwY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HH0/caSm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBC036113;
	Thu, 29 Feb 2024 01:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709171441; cv=fail; b=Og/1KgIpqX6VaxMB4SRapEdScFmooY7sL3XYdfue6I/OJ4K968SFj0g9jyDNz0skfw6/Ah0FUDRz+i0LfvBEk9kvygrah1Di39u4TYv8KieQ8Vrz1gdniq4IcGLgnx1MlYTzV4qjzZP3vtpo0Tu+SBEljVzRBag0r5HQJj2e1Uc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709171441; c=relaxed/simple;
	bh=5Ppg4QiZBqPq+8I7rjUs9pyVTAqwX0CKBqDYRphm9FA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DyP5dXbSPJeYbrLUTHg4bNSR/ZEUQ95QrSdUlfupodxOENnhYWvaX7UC0exASzPqphgATjvqgh8e0DqWA3+4tBi0ezXJw1aDJj0nUpTR2xeXXtn41uxApiemG6SWTKqQI65AWgW0EBCdfb/ovPnFbX1zZs3iCePGsmX7zN3qPHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=m0uqkTwY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HH0/caSm; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41SKP8ZO013132;
	Thu, 29 Feb 2024 01:50:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=Lx3zo9LqykSzgeuQFD+gExDimg5hc2r/bbpRc6Aksg0=;
 b=m0uqkTwYUV3TikWypaUKnXDDvq4He5rsTjDD7gNtVNXVs80LwJzJ4uhgFn6F7Y0nhtbH
 kLIDDpgtAXbkxmhQQZBlf8jcOg4SaF4YzSrIqydraJl5oXuf1OOsbGpOo2oPcOwZueYS
 7VFWuA+qbU/o9qDgD2b9MyBwl1fzehezQ1oQrs3uKheRIXtGiItWnreVzWBEW96/F8MF
 6lBXgvkBkC4gcpu2XdoF02+MEWVB9Yyo8NnvFlZB+VdtUwEszbSvnihPonlz0StAHeJW
 NrhqoXrGheEf1c+hDtuHbqA+rm/goS8uzrv9TkUqwrbrwOQADs728hizoaqJe4BSAr4C DA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf90vbx50-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 01:50:37 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41T1Z00k025481;
	Thu, 29 Feb 2024 01:50:35 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6wg9dfs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 01:50:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iAvffWJE822OWlI4n6SXHJVH4CDF2Dg/NHnmDZGJ2Joqsh7tZLNbJPlXr110dy7Ru9RFv4dDUifnVsmoD8qwfQf06hRFZQFLJ8paoS5ABrb7sUC+OVVI0z1RlhJyhuT2dvTN4+jJy3ZJExZ2hx9rt4h9tSLBfQxPiewTKIturkCME+VgdBsNtZXLdtfp29wZHkcbvLpp1xQONfZz7rtVeL7t9LopQVWw+GMoHCO67oARHJd8ZGbhvgROIiRW7Hn8jnsGlYONm5Ej9xPeP1kN5WPvVpvSdCxs8ZgDVFwdg9VJIWK4YNIuEc/275JJp014TNORuIZ4rJ2LZgiqrJC3DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lx3zo9LqykSzgeuQFD+gExDimg5hc2r/bbpRc6Aksg0=;
 b=i7BFKCGYfVbER5f9+tympaRyHvdNLGl3idixTwWvvg22woF2obRnDj5ngN5HzxTqlJLVFQ3JjzBs3QJZGApqyY/9zYWwC44l+BnYxhA/XRI7BXicbNqsOjjenaTlEaSYgiS63Z1S/qGsGLCuaYy543JFldwPkZQBM6zA+kGYLZOkH4LhbCRWC27GLhbL3c8lA69C1z7txMr3P7U2futByNiHZStvosHh/4ntwpNgMTBNAVlMQWxgmCbkNJRn0WhbhkHFtj9yUQA1RIP8baHHD4lyJGUyI3ig9hJ+Mb/7n5RoNiT0XZml4fqMldF85OIH0IrkB+y/QvaA+vgdE635wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lx3zo9LqykSzgeuQFD+gExDimg5hc2r/bbpRc6Aksg0=;
 b=HH0/caSmavSfbR1VKZVMhkXEMIoNRxKdZ97B6ng9Cks6t3yna0Au0AtpQ13vEpobTPMwZg/Tw8gahs4ztOiv1Kl4lnJolPKOxkpqJJIGJljYNhKyxa11cRTwsrH1O1/y5aUj8prQYN5htPlL8RG7huzkoS3oXCT4nSXNaE/kbgI=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CO6PR10MB5618.namprd10.prod.outlook.com (2603:10b6:303:149::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 29 Feb
 2024 01:50:33 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%6]) with mapi id 15.20.7316.032; Thu, 29 Feb 2024
 01:50:33 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, fdmanana@kernel.org
Subject: [PATCH v4 03/10] btrfs: create a helper function, check_fsid(), to verify the tempfsid
Date: Thu, 29 Feb 2024 07:19:20 +0530
Message-ID: <94c8655a490deebf0a917d456489d2364fae3c92.1709162170.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1709162170.git.anand.jain@oracle.com>
References: <cover.1709162170.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0030.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::17) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CO6PR10MB5618:EE_
X-MS-Office365-Filtering-Correlation-Id: e04da688-3341-48f7-9ec3-08dc38c8d0cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	y6NYqZLVxSAfRUHrPnCo077vuAH37Pij5rQ8aTPT9lcz85H/1u1QrnQRtQ6BPU1lieuMuvPTeLo0G63GDs79jPAbVI0BLdjKdxt7ReYr6bCGzDHb5x21MLS9v+qag0uRB9dg792m2MR8wwTOMl89h/1ODsfwWkI/V2HV01Fs4gLuH+rDrCl8UnczlK6xP25hdI9VVxMlhEuOF99Mh3G0Ho/OPIhxjHfowPle0LeDCrRc9y+lBnSgXu+LzdK07KhB/4VLmZPbCV9PstAhPLQSwl3uSg5X2SWBFVQmTPxNnqmnTVjVpDgfZA8gJihucKBpombOQf21TISiabwGMzYWG9CO1zcs697jaAARWk9NyDnQ9/bozW1IYWL5+jqurzxE1XY0qYnk1UbkVrOsdZZODEQCrRznV8agc58EiL4T4k9Hb7oJ5DkU47SJvAdpjq5qLbKxMhefwWD3S1TnEbvB1rftsf6TKcT4QYmyiuheGb62Pn7IuGIA2pBxD01y4nPBZcsCpVFCpfl0oBmCuXJkBT1VAQV3gOQ3qYYQ0n02H7Gd2pJ1t0fNocu5F67GeelOGEN/Nume+77xuXVj3vIe+p407EMvFtEwhVpLjs3EPmsE6osaVc+9BULewEMdf93Yn22oXHg61KS0R0ElFAI4IQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?feAjaOEqHAmViEbX7rFQZYKJ/a464geCHsHUwsDv/YmCR+15EpF6nzmOOss/?=
 =?us-ascii?Q?A+RC5WaRbTIh7Ynure32Pi6rAReKR/SHcYmef6DCxKSw96iQLp+VaE1rZjrx?=
 =?us-ascii?Q?s1/YaqwPOMcgrTYCjqCNVcOsYls5VoUd0rohaJsY2r+mBLSaG1aShv02le5K?=
 =?us-ascii?Q?P497oVfvCaPIjoUK6LijZFsv1wcyf2OIZVsbJIKm//LJf3EmkG+vm093wkcV?=
 =?us-ascii?Q?bpfSOS9kWndo5AArAV0bDK6lHm4zwfqpXfjPC0tESruopo2Wj+ScjDVfLYFJ?=
 =?us-ascii?Q?7QO8N65Zh5dmDYsP2SYRJRb8lBTwV1YRCscigDPkWxUwx3ebaQvSTu1+935A?=
 =?us-ascii?Q?32chlux+1D8w1NQMs6nDLruEnRz1To0oSoBY+GYv8NzziykhS+kJPn6x1+Dk?=
 =?us-ascii?Q?uqVzp3mHX/wkd2+Fxe0ez6w7sjvVSL+f9NSYgigtpHDhqtammzohrcES9nFg?=
 =?us-ascii?Q?ikr6gg4s+jsPR0XrHx/wP/CGCMdpw+ne6b1j26u+YJejuALUHAs2WXMn8jfP?=
 =?us-ascii?Q?7gTfVFKKoPE7uxKg++juxCcbVfEAHgftaz6uf6cUgGzW8g48iXzMd8PnLpPj?=
 =?us-ascii?Q?pF5XVHVuvSrHPkT9PCu93ygHsQ4klkyG3ifiJc4jMTD/7dXCb6JTuY1JJS9h?=
 =?us-ascii?Q?DcZ3GzJrImVXe5bzcJ7GGphdjT0fbcrjpTCyHlcstDaEhtKaWCPOaNBuNoO+?=
 =?us-ascii?Q?ZhgASwGMecUV8jQfRSE7bXtwI5YNOkBG/BYN7nqMFZmj7MC4+8ldtCnx5v9E?=
 =?us-ascii?Q?2CK2kTByfbwf/Vzh1SRzXiSyUBz3NlQ4Y2DV6u8BuxTH/SkHJZHyTI1IYWLl?=
 =?us-ascii?Q?7Pqh0bkFUx2/uXH/lTqXgEI9LswqyeZ1RiqQ144WDO37ouL3/wJil9NxhS8l?=
 =?us-ascii?Q?MbeJ+WKoXXzT58qqtbMnROyOnolnCMgpLLmKj6Aw2hsS32zSyl/Dq3tRebri?=
 =?us-ascii?Q?nFC4UwOsUyey5Ssqm/BaKUtOpGfFzMg5gVnYR3W5SGU3zrZu0+VO7pWIqnGX?=
 =?us-ascii?Q?Xc+nuh2aIWZFWiWoBiTvDHMQAdp/S7MpiY/EhTdIyrXBlex+dalEwZ/i74Qy?=
 =?us-ascii?Q?9IG5mHzv/FVny+Whi9T5cRkrS1fxA0lqY9puuy1s6XrSpjlKc1U0wCbolAZ4?=
 =?us-ascii?Q?saVnjB/a2O+bL9Z+wgHl1VyDufZO1T8tXrms04CKwxCCQZtRjhIVApYagpIv?=
 =?us-ascii?Q?4sdCUF5jA+Meg12XtnLIk2sklCnDIvpp0qfzElctLTRLhLhIFAl66mSzCQvD?=
 =?us-ascii?Q?Ms2EU2EQauf98lwU+m4sZ+tkc3tpP9C2qxBI8Bzzyn0Yiu99p8G5gpM9ju1G?=
 =?us-ascii?Q?fQXNN5VM+Ibs59IsmYQ9ZKn4pbAsEd4niYDd4A/K+0W5VvE0oWqn8JzAGC+0?=
 =?us-ascii?Q?GcXpUnduj277EihF1JkBSDhDYFEjv+yXfuqwoUt2tCZpqxkA1K6q7jlAdaNO?=
 =?us-ascii?Q?oOdYkg1UE09QApl/Z3GjJYUFEzIquUmobbG7AUHarLgvzaeDwxPab1wY4QMM?=
 =?us-ascii?Q?1JzvCGbN6xU1OCAffSF6NSqGqanhc3+FWxTvM7Vq6Ms4aAWBwhvrwQZJOYwy?=
 =?us-ascii?Q?pN6groCLeW50pofICxNl31mM1KI1p3Xydv/5yfkk?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	6pBsNuyLXjNUN7ubqx+EO0jZRwBAcc3vOXBq8MYhvGV71JBQqxafpBoOBr5H6CGHlBbuN+eUz9G/w2mb1LyPhI0w01m8BJXacJRKGX+pOp3iMEb14hKaEH3s3YatQz4oROSqUffAh/YECYswzrdWrZGRUvUxvnnsAMnDTGuzDeQfMgzqQ5e4n+RwzfIcxUopWq872uJa19Bsyb+90S4AR18nLrfDq/e1edarrxZRa1GCsF+fFnOJ8WenlVCXshFCl/V0W9FWr9ZmMg4JQJF90t3n/zDdvgc/rLR/gjFzSyvsa2YFAGN2BXyyodBrm3H3/UhuYwf0u3ydtPMvtz2lEFG23QHtRIj5cqvdgmcYErAQOlVeRzw23/KvYnREQhXyxu1Aj1wUpVl9zQMIOQDsUVYKMNpTBSztLgyM8AvVHshb3aKvbKiJx3hQw6chIil/AKPDUCyCosRZ9z5YNBHYvhTU3mRlZTlkwJGD5b5yOm2uYrvcfR9fSNCZTRzPTRpTy56jJChJyeRpElX1T4nXqT1UyFDPVYi8gE7kM272Et6f/+iJ0XpnmViOyhctRh0tQJ0UEZ8CK6d9S0CvOZwOxhLgkgUbQA3w/WtZGaY6+As=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e04da688-3341-48f7-9ec3-08dc38c8d0cf
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 01:50:33.0767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MdK4fzQYv1E5pfgZ18g7acobzuHAD4VSBtoUSN9CjIVdRsoHO/TEUQ1jk+j6JuMQt+WAfU9bHrv9keo7y0qRnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5618
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_08,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402290013
X-Proofpoint-GUID: OeLNJkdXUxCJL90TvGdxn33Atzwwgeux
X-Proofpoint-ORIG-GUID: OeLNJkdXUxCJL90TvGdxn33Atzwwgeux

check_fsid() provides a method to verify if the given device is mounted
with the tempfsid in the kernel. Function sb() is an internal only
function.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
---
 common/btrfs | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/common/btrfs b/common/btrfs
index e1b29c613767..5dd0f705fd90 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -792,3 +792,43 @@ _has_btrfs_sysfs_feature_attr()
 
 	test -e /sys/fs/btrfs/features/$feature_attr
 }
+
+# Print the fsid and metadata uuid replaced with constant strings FSID and
+# METADATA_UUID. Compare temp_fsid with fsid and metadata_uuid, then echo what
+# it matches to or TEMP_FSID. This helps in comparing with the golden output.
+check_fsid()
+{
+	local dev1=$1
+	local fsid
+	local metadata_uuid
+
+	_require_btrfs_fs_sysfs
+	_require_btrfs_fs_feature temp_fsid
+	_require_btrfs_fs_feature metadata_uuid
+	_require_btrfs_command inspect-internal dump-super
+
+	# on disk fsid
+	fsid=$($BTRFS_UTIL_PROG inspect-internal dump-super $dev1 | \
+				grep ^fsid | $AWK_PROG -d" " '{print $2}')
+	echo -e "On disk fsid:\t\t$fsid" | sed -e "s/$fsid/FSID/g"
+
+	# Print FSID even if it is not the same as metadata_uuid because it has
+	# to match in the golden output.
+	metadata_uuid=$(cat /sys/fs/btrfs/$fsid/metadata_uuid)
+	echo -e "Metadata uuid:\t\tFSID"
+
+	# This returns the temp_fsid if set
+	tempfsid=$(_btrfs_get_fsid $dev1)
+	if [[ $tempfsid == $fsid ]]; then
+		echo -e "Temp fsid:\t\tFSID"
+	elif [[ $tempfsid == $metadata_uuid ]]; then
+		# If we are here, it means there is a bug; let it not match with
+		# the golden output.
+		echo -e "Temp fsid:\t\t$metadata_uuid"
+	else
+		echo -e "Temp fsid:\t\tTEMPFSID"
+	fi
+
+	echo -e -n "Tempfsid status:\t"
+	cat /sys/fs/btrfs/$tempfsid/temp_fsid
+}
-- 
2.39.3


