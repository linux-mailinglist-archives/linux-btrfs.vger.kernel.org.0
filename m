Return-Path: <linux-btrfs+bounces-2720-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E9B862617
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Feb 2024 17:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 249421F21FB9
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Feb 2024 16:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0BEE41C6D;
	Sat, 24 Feb 2024 16:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AX/D+GLf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jx8I8uWt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D67329429;
	Sat, 24 Feb 2024 16:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708793075; cv=fail; b=ChIwKCpWVz3Ti770ZQWyhnAGSoLx/PfiRBu2dGXKjne6IENsMkXGowyT7j8nfGVrRZMAR+toohvDeGJA2xJQVT+4tabHJYDTxqbaaMpgz6OrcBCEw8mPaVs0u9znov8pUwgSJ2ejX7cQ9k7wbp650YM52TQALyb3jJ5204lbaxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708793075; c=relaxed/simple;
	bh=4F+Lzy17z0nBgfBSy9PvaiLuapXli7ElBA99jEOvmrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P1stjv4BcwwOpygSm5jw4fDaGj5zrJzG43sEou3kujS+eTc4o7JKwrLfVZuwFntJTeoBcurBkVkZY23eZP+tB/8GlhQrXo1SVYaRoxVa+52pjUF8F+BYDNWVP4PZnQfHKV3puTqPYK/sm9eSZlNcraMQFqYmWs4EdLZWc8amqmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AX/D+GLf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jx8I8uWt; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41OFT6LH020711;
	Sat, 24 Feb 2024 16:44:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=XOf38tn0A3RVodriu713qf1iu+1c1iNDX7AXX/s0OGo=;
 b=AX/D+GLfCTnEO0CcM68zTn4TnVaO92UPNseDC0z8mhJj831574UmUG2ZlN+CNpiCcFz0
 bU4faCO0s8QtIJ0f+03uqvdLQ836h+vT2C8+1qeKvabtTSLdX64v1w3k010HDufd3RJ2
 THZX36x7K9tX/8y8PuOzypHwSdE11KD2DxzT4SASqRbJ4IK8u7fQplq9muz+Z3fcju8j
 tN6ByIHFwsqSqXewmo9B6DSxKmxok22mQZ8kKcH0xc5fr7VAH9/6KhERMCIFq8C1L8T/
 DSH20GUmESGlY0XBVcknpmsGWQsL0jXN3vpflT/q6x0f7fYUoV5hSmZaylJIMzbjJZNQ ZQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf90v1106-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 24 Feb 2024 16:44:32 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41OEvgXt017320;
	Sat, 24 Feb 2024 16:44:30 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6wa9h9w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 24 Feb 2024 16:44:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OdH55QYwMl2iuynB77nAKHYtInaaDWcm5o5P+Df8DcHMqq3DAKzgtr26dMmDUW5yxB7apeRzARwo7M0Gf3x4J+/OUjCe/6r0Ek5vHqBEggFDf4pSPxEpv1mMt00zrYd5LL4kZ258cUp+dnYgM+WhhWI3bOcTfKt2zyzT4aEFTs5PWTtjBvGc6I8I/04qS2o+qzFXGS9o/khmspQkrfvKQRrs32mX4X/AuwU3EAKs1ofROm8rlBXFO4Uh9s1YtJ1YwF1FNqVJMi9+Fem+zd0Du7TF081NBjkTUZC2pOz9HiVa9ywmsNHYTMJulTPLzRtpucY+SFO1YULQQXp/QLw3ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XOf38tn0A3RVodriu713qf1iu+1c1iNDX7AXX/s0OGo=;
 b=KrFLo4okag/YI5fh5bhGBB00rCr4qCsU2uGZ1tRBvaRc/JlrhmDYVvnTa6ymnnAAgvMbxHQWJuiPgxoltw5T+wPUk8sLg5Hskrekva6ypEiY+VT6j4aoqRbA3cRG1pvUfmtiLrPfFZUFI5sNIIdyCmBVh6IBYxTGauMZnLuppuebW7UI9V6q6X6twYF3C3vi1BzGStlMkzhs+LrSiPM5kYU7XURie5UE6OCMn9kGQkZgHuYALZWflY1OLWE06vtFQdED7e4eg0nApifUwPERumRcE81xrGiy2XUyNsTVDs+wmf7nKxggl1l6Vgd+rg5lriKd9FZqC1R0bdKu08sTeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XOf38tn0A3RVodriu713qf1iu+1c1iNDX7AXX/s0OGo=;
 b=jx8I8uWtxZT7O/jrjPE/yTCQMOtXdaXwDbgIGmWkKgmwemSCCXeuMaEd9Sx2/Tvcs6MeoUOXW6Sdp8esbNNO34HUhAY6XKXKWvo4vKPCcVzmTRFi0cN/C9qRl/fL22CY2pVUh2h9Ymsw7Vzq1jGS7qOow0UR6AnQLrS/n5eQ/94=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA1PR10MB7754.namprd10.prod.outlook.com (2603:10b6:806:3a7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.33; Sat, 24 Feb
 2024 16:44:29 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690%3]) with mapi id 15.20.7292.029; Sat, 24 Feb 2024
 16:44:28 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, fdmanana@kernel.org
Subject: [PATCH v3 10/10] btrfs: test tempfsid with device add, seed, and balance
Date: Sat, 24 Feb 2024 22:13:11 +0530
Message-ID: <faeda97208d0a2ecca94490b35a4dc8e98e7fdc6.1708772619.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1708772619.git.anand.jain@oracle.com>
References: <cover.1708772619.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0090.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::19) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA1PR10MB7754:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e27eabf-13b7-4aac-4210-08dc3557de35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Q2l9iOJ9CMht8e0Ypooc9hVnj2n7VfyiANYfSe0gkYRws1eLfvbQf2jtH81PgNAxWfq6nkKTDWXErl0FJdod12STGHXelt/4Mudl6zgwFXyUMywAHiJIXQbyz+Pi67/vS9VDxVvgZn+d8yqiAF72A8cHeAEGUJSff9/Dk3tFmhd6KHy9W59QQ1bWucEgR/0SvIaN+bbOtF59wolQ020FyO/xg/A3ppK16cHPFNDZwoljLyIuFb04nkwtcSGR7hAzJOD6SnNjoQ+lr14lXTva79aeRnUavDzTMEP0Ndr5W3Yof/9lUwYinC27z1DHjq/CFUl0lUdDBMhmBzNnNgfHBi9SGNvybz8UAQ+RFV36pzTCZn7DEQClcs7l+m71uKypWjVhgZoWAiUOw/vV18MPAoNnMDmd7ITcYJxKRY6wTv8M3qnYHjOGKUWLyyM07Jya3jpSITfdJiY9GqSqpsKFNaI7JN0PuvzHIhv6nALa8qLj7XBCKr4m58ZpiJL6l5jmVR2+sR2pQV3xxA55SJcOQdaDOYfHwSlbQa/u4CoeX4IkYeFLk2MAVx5hrL/CWtV2
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?u0zBFujCKQJcIBO7UTLs7mIgIBoqaAyjeRyWDgegcC9IM1V6u5s3cpOcg7ph?=
 =?us-ascii?Q?AgUsFMDHLJ0QRAwikM+jUg2Wv/5BhmVwIAnhZeNGOGn/xDoSxeLLFexKm2o5?=
 =?us-ascii?Q?BOvndHC3LcUCm2Ayh7znDxXLlItP5nyHpi7Ox/s3tOS/k6z9Pe3HvRqh0NQr?=
 =?us-ascii?Q?joTOwMoSlsiJsH68LjIbt1SIh0WEV36Ajwoj5DX2MMvetoS9BPVZ5qWFbhU0?=
 =?us-ascii?Q?FrR2A+JMSxP5IAUZtAyu34LHgTs39+gjVCjdchpdQv1jAl/WBZ46Fov0MThi?=
 =?us-ascii?Q?cHk8pfGTClo7C0fzztBVxt9zq399/x+YbIYoPivuPg/uXy1X00D4Nih/vDFj?=
 =?us-ascii?Q?snYk7WA9BkFa6jOWaLalJ0H/ofMNRVpE1/FaHr7Sl5osrctuD/JsbPGB+WoU?=
 =?us-ascii?Q?W9x7JVByS7IAyotzvDk+Ne2vRPnGz+00vKimb/DqhwuZfZGGKKOj7PuLSMXy?=
 =?us-ascii?Q?c63dl4K6IAiC+v0BUVEhPn7QZaltDXDRtMtcr2jpkXPUUDuyoDTuLnke0ue6?=
 =?us-ascii?Q?tpT1apj73mwEqkgiXSStTux6F4n9Mkh/Esd1W+2+XaoCnPEe1WgrJSOYvibd?=
 =?us-ascii?Q?DboujpV+GC03vIkwFS7zv/0I46yTT8xHE+zpH2akukCLgOTjOkpQP1h5OZYR?=
 =?us-ascii?Q?c5AE2lurRAosskwuc+rojJjsS4aKud093IL9TWeg0p9R7X9MVxx/whiObebb?=
 =?us-ascii?Q?hszgxXw4rsEhvaDPlhQwH805KdBlYO5cn3k7F3ZJ+X8r8UR8igCD1Uxeo9RG?=
 =?us-ascii?Q?iS3jxvCgvvhCq2JgWHcmEQdmx/pUQqi3nw0DBVZy8hdRJ0zRuYTGLntSWxOO?=
 =?us-ascii?Q?ezf9K4h43qifupsJS7TJ9Nx+y0g4T+qzCT4SwZ69XYFwlu5iqmjaYgy1LIXZ?=
 =?us-ascii?Q?e1XUZUd7oSJMKzjOxTDqeEudpXFXfFF5Rj3FBgtvRpAIgTchMj8sfNEjIIIz?=
 =?us-ascii?Q?WNgEOgesb4k5Et7r0LMmkj2fxNlHOZ5BL/XvzJZQa/s4wEGTOz/GUZKU26g7?=
 =?us-ascii?Q?pQuFn1ue3b3MqrCCCllq06GrOcJuDhDL3zJ7Ia2W9aB82QYYibz+s3wSw2Ih?=
 =?us-ascii?Q?U0WrjvAtJaRKJB6ZAP3RA560qArTt55xm0sS4kB31SenwCio7y52LV9vL5e+?=
 =?us-ascii?Q?IUA1fdNd6TuFOARC9w6oaWpMynyBGwz/9ruEd2mSjXQv1pZOHxOE+wNnX5nz?=
 =?us-ascii?Q?Kprrz5zTkBXLUPp9ZX+JvAqK3yT7eBt5yaGMFkGm7Nyw9abSv9LgY1eZH5DP?=
 =?us-ascii?Q?y6jZpEC6okadfC3seYhMZsb9a44Lk+6EWfuCYYLTI+M/O2vJGLluzV9hu+d8?=
 =?us-ascii?Q?r0wk+p1YKrJGExqFmnPKt5pKKd8bMAWGOtUsPCBc3CUpb4okIJI0FA9JArLm?=
 =?us-ascii?Q?svihJgo4gvBAItekxXboSgJS2F0IAqCMOpil4LO2E0llyW4rpiQkuY5nJQR4?=
 =?us-ascii?Q?lDVp2UyKwss67xX20ZuNZ/nOEKewTKVFFUUI+TBbQTox4JiiKdHd4NRgCRaG?=
 =?us-ascii?Q?4JHtV4R2qulVnuSbqHvE/vynQFbA2s988HN198LJM8sVV0a4baOumNDNTRsL?=
 =?us-ascii?Q?60EiYcZjrL8ITXyCC4pzRmNbBwKCICLkCX+KxHGj?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ctuVJloDQIvoxy9eZa6aqvDb/r22b/a+PO/2DirqVbMQH9QlgyzgxPAL5eqmU7sb3/1Fd7V85hcLyn8R34a/6znz815LV0hk9PI+9IjPUG3XxUBnn5R26Ig4eCXV0ROCpoUg4Vkqmo7rje21ZLGaH3u42pMGcRQRCQvSQ4+McDH5OwYr0yi9ibWIBVbsfPj5Xh6IkVdmw20FqGrEDzfzhaL6g3nTUB4ohDpDKs7a079YaP/DOilfgRcQt4GC3XICA50JaQVP3DzgXqKBJcET/Q9e2yffNuR8FbD7a8HOim+m250zDYnwAnG8q9sY+TW+GDzLDy8gnCNsTmXeG3M9ztXCR+dxlYiZUyRqbmNm6O0mIl+9qvqIgXk1Fp/PejThCad5HX5ddzJyl6dXZpPu8Mz+tNqJ6fhd4AXy44OnhJpH4OESTieL2AMnCf7TbtoGfAnV+rcBfnfVFD77TbyYtQwbJAajGcwcjg+VipNzsFksEiwcmF3LpPA7//a0CaM/r1KLzfJNJNDewdTQyOvOwj0aWFV1mGme91zDRNz5dMVSynQsAlcN3epxgIlUEe6I/mvNVXg95Y+MjVG2SqlvZIKKWfOqkVPn6s/NHpeS4Tk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e27eabf-13b7-4aac-4210-08dc3557de35
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2024 16:44:28.9210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gVGQOOk03PfFWcr+fQWl+JxhLgRT3yhflfo3ewjJanH/udrC/ZjTkEf1qJrAonqlrMNABjYncYGBLW1k2ZWc9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7754
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-24_12,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402240140
X-Proofpoint-GUID: ZdtFf94pHTcA85RFTnDkpzsMIltvK1w-
X-Proofpoint-ORIG-GUID: ZdtFf94pHTcA85RFTnDkpzsMIltvK1w-

Make sure that basic functions such as seeding and device add fail,
while balance runs successfully with tempfsid.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v3:
 Comment updated.
 Add balance group.
 Drop prerequisite checks.
 Use error (from subvol create) in the golden output instead of calling _fail.

v2:
 Remove unnecessary function.
 Add clone group
 use $UMOUNT_PROG
 Let _cp_reflink fail on the stdout.

 tests/btrfs/315     | 78 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/315.out | 10 ++++++
 2 files changed, 88 insertions(+)
 create mode 100755 tests/btrfs/315
 create mode 100644 tests/btrfs/315.out

diff --git a/tests/btrfs/315 b/tests/btrfs/315
new file mode 100755
index 000000000000..696e26fe339c
--- /dev/null
+++ b/tests/btrfs/315
@@ -0,0 +1,78 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2024 Oracle. All Rights Reserved.
+#
+# FS QA Test 315
+#
+# Verify if the seed and device add to a tempfsid filesystem fails
+# and balance devices is successful.
+#
+. ./common/preamble
+_begin_fstest auto quick volume seed balance tempfsid
+
+_cleanup()
+{
+	cd /
+	$UMOUNT_PROG $tempfsid_mnt 2>/dev/null
+	rm -r -f $tmp.*
+	rm -r -f $tempfsid_mnt
+}
+
+. ./common/filter.btrfs
+
+_supported_fs btrfs
+_require_btrfs_sysfs_fsid
+_require_scratch_dev_pool 3
+_require_btrfs_fs_feature temp_fsid
+
+_scratch_dev_pool_get 3
+
+# mount point for the tempfsid device
+tempfsid_mnt=$TEST_DIR/$seq/tempfsid_mnt
+
+seed_device_must_fail()
+{
+	echo ---- $FUNCNAME ----
+
+	mkfs_clone ${SCRATCH_DEV} ${SCRATCH_DEV_NAME[1]}
+
+	$BTRFS_TUNE_PROG -S 1 ${SCRATCH_DEV}
+	$BTRFS_TUNE_PROG -S 1 ${SCRATCH_DEV_NAME[1]}
+
+	_scratch_mount 2>&1 | _filter_scratch
+	_mount ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt} 2>&1 | _filter_test_dir
+}
+
+device_add_must_fail()
+{
+	echo ---- $FUNCNAME ----
+
+	mkfs_clone ${SCRATCH_DEV} ${SCRATCH_DEV_NAME[1]}
+	_scratch_mount
+	_mount ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}
+
+	$XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' $SCRATCH_MNT/foo | \
+							_filter_xfs_io
+
+$BTRFS_UTIL_PROG device add -f ${SCRATCH_DEV_NAME[2]} ${tempfsid_mnt} 2>&1 | \
+		grep -v "Performing full device TRIM" | _filter_scratch_pool
+
+	echo Balance must be successful
+	_run_btrfs_balance_start ${tempfsid_mnt}
+}
+
+mkdir -p $tempfsid_mnt
+
+seed_device_must_fail
+
+_scratch_unmount
+_cleanup
+mkdir -p $tempfsid_mnt
+
+device_add_must_fail
+
+_scratch_dev_pool_put
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/315.out b/tests/btrfs/315.out
new file mode 100644
index 000000000000..56301f9f069e
--- /dev/null
+++ b/tests/btrfs/315.out
@@ -0,0 +1,10 @@
+QA output created by 315
+---- seed_device_must_fail ----
+mount: SCRATCH_MNT: WARNING: source write-protected, mounted read-only.
+mount: TEST_DIR/315/tempfsid_mnt: mount(2) system call failed: File exists.
+---- device_add_must_fail ----
+wrote 9000/9000 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+ERROR: error adding device 'SCRATCH_DEV': Invalid argument
+Balance must be successful
+Done, had to relocate 3 out of 3 chunks
-- 
2.39.3


