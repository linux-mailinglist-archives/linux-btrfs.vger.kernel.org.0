Return-Path: <linux-btrfs+bounces-4399-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A36A8A93BE
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Apr 2024 09:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C362BB2172B
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Apr 2024 07:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B301B4EB45;
	Thu, 18 Apr 2024 07:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LAW+j6TI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XzrMdUAz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAB93E493
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Apr 2024 07:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713424192; cv=fail; b=pOzW/DvjgM1TEN0rl3qHh44N+OsRs8hpl6Dwp/Fl+9XrZRCZLBrG9BpaqNTbfVDyvVGrcfzFGpBOe8Gu8SA5+dL3oI5M1Lgre1VfWHO/xxnAWe13gJfYZX6hZSdnFJgNhWtkyEi+3I/7JzJ+goXhh3fcbzCb/tO0P8Qsnw7+psY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713424192; c=relaxed/simple;
	bh=iCxPxjx6WbhEt/kJ49GcIsd4dvkmewvBqWW3rK2GMGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Sopl3CY6xG8tyluoqnaEVel2QoxqCv+LO9NceG6wOxCR937GkCMVl/6Xwv7oM+NcTK7WQViJMfXZEVTt1IH8qveD7ztNgpWK6RHlaYOOoSIaHoFfqz3x8Lmr2WWjjVQ+2Z87tndRQHW/VZzZtP34406Hlfc8GfGGXVPZHU/19ec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LAW+j6TI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XzrMdUAz; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43I3xlFQ009835
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Apr 2024 07:09:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=5rKhOAScfUenhDnNJfNREtpAWCWmAlBjkacVOjH8iRc=;
 b=LAW+j6TIhzSiCAqnUhU/7vVeO+v6+mbXs6QrUyY+HqKraK+a3oouMYXVl3tPOQjxPuIm
 TgNQoW3zvhJx8Oq917SuUjJwEfjgeb+/6/vrwve4vVSYsnZHGeeK8j36VxmUOePwOpGd
 tbdwaBK13wEKxoFGE/00RVrGae4vF/zx2o/LuQy2f3ISH6RBYfCgTdhqoU6VZN4Jbyfu
 0HgLpoqTvzkaZgmNLSr4NLwOv1mFcww3+3mPX4Qi/SjEkENFGfPEe9ebqjBfrrOUw18O
 H72VaQYC6rgwNAztXb7jd0LUNoF7zaue8idHK418fJPt11g4FJ66zwpQr/EcYfltkSvE Jg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfhxbshf6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Apr 2024 07:09:50 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43I5xiMQ028824
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Apr 2024 07:09:49 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xfgg9y78x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Apr 2024 07:09:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lSOthgY+CpxX6T0dywwrUfCdguF2AMr9oRGXe0oXYAFVw6UGH9itsq/4UaNy+AOX55EWB9XyGcHkyrLCxP5myfzQVlINTlDUBhChGCd4A9Njx7RhAwANCbV3ECb/9KThkOaqOUbx6bj9+LnqGPafDFdRBTyPYwtnJAPfAhp8GG3vzO314qk/TTMvyK7IPN1VdDrrq4XfowqniMRMVxMIezBYgMV8X0U2+HJLwiescrntOrAVbvO5+0HlxQeEi4y1Je5vYD+rpSrDsnDNMnSYXaAoI8Z7G9E0xG0xle+1XHM2pdceKvK2hQVp9Vmx2Oj2Tf6ty7r1rZ7y6QLq3jc5Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5rKhOAScfUenhDnNJfNREtpAWCWmAlBjkacVOjH8iRc=;
 b=N5//lyR2zc2MvY5wGl3SpDH45SPTHEtW/1Sp6rYNTncdLunA/Hakl4oa4iX2vZ0cZKT97RNFv7x4TLsuajQ6+IZQumMWfzc0Cj1u5oK8z5oIUCZKM6Y/vz9jfhuxoLNUWYGbSfweYkn8gt92tcVAM+IqzQ67Dkd/xheZXotd7oRed0eqr6M1IItTod3m0+vNsdMsXxlg2VTW9QK5tAwWi6eESQJym/SGQ/MYXbC8ru2+Catz/3lmubkbR3Ge5Sw3c2NLMs1exQkxd0VPyf/P3WDR9hhRgu6gUbTqry9OUChDpcutHw02Bc9sOOy0+pAm021fziQhLxmjz3fjwrk6kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5rKhOAScfUenhDnNJfNREtpAWCWmAlBjkacVOjH8iRc=;
 b=XzrMdUAzz6uDLDBBbLSjEtupbHhQP8+aOJnug7YUP6OeZMKCKQAqXRTu+htYhTAnD6boakoMMgEXK/74C20305J0iajU+cy0mPUW6dz6o3ZtejwGCKMgKFrJvjxxsRV+6J07DVgTFygA+6C0dTt7JuuY5qz1Ogi3kUflpv8SuBY=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA1PR10MB6592.namprd10.prod.outlook.com (2603:10b6:806:2be::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Thu, 18 Apr
 2024 07:09:47 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 07:09:47 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v2 03/11] btrfs: __btrfs_wait_marked_extents rename werr and err to ret
Date: Thu, 18 Apr 2024 15:08:35 +0800
Message-ID: <15a7979ea28fb0cd52c09969a3cd0ea4582787d7.1713370756.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1713370756.git.anand.jain@oracle.com>
References: <cover.1713370756.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0008.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::20)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA1PR10MB6592:EE_
X-MS-Office365-Filtering-Correlation-Id: e261ed31-d71d-465a-a3f5-08dc5f768802
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	5zItTaZgnjLrMwEm03874v0u9dbnNi4xy2osSDfbZxRtUDUSN6U+B7DMteRxTzHurZ7/P5IVmXoAFhdok917gduDfGq48iLdcOtz0RONAzz0KFwmZ520yzFH+OIpOrTuwcr2BQgb6elT21C2coJpda7DaXhdSV0DNmWi9Cs0sWiBF3GGwKkSxxttTRAycJJGsjTBuaN/rnszZsGsFYqFxgUu6DXGNXsHEZHXo/FMdldOar3AbsCk8vYSYwQ3Fb/dFw0rQwTz5H1ocfrwdo1rm/4Kr3R0vWOoxDWCI/7yTzn6MiyFjj5ANFdUSouXKHU/EptR42RNebiHNIW+4nWqKKgGeNnkj20k/2lZBtbe85WQ7bm+zJpsunS8IUNJubBvn4abxhbIs8T0gtFa0jkK54QbRdPngcvpb8SYp8hz9U13Hz/8K9pVfEbtk9HeftwcJd3WIYUzBHSMBZk5ZRq1JJxZk4t/Oe1HjS/FsueEgWWpik4i4Z48+kCoznipJM7iqnRfYiGEyVUpIDuqIIFHeGzST1ogXdjQrew8D54zWXj8310Delg1bQMVK32eZOc7gYngPAAWktEi/6G1FNA4bntw7ATM8VJdGlcHRKHS165oXNJp57brxjM1/h97C85g/NALbs9dEUr6iCrexLHSsb3bChmJZm5MPLgM7X4Tyho=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?VBbl6HTh7O/NxGhLGyE+3zK8vbIaYR3FKbOiaLW3cgzXPYclS48q78lHF+Hb?=
 =?us-ascii?Q?tUVylOhGL2FddLJsnk+ZfwmIOYbqWV4gD5FG7E8jPg50ZDOHgEvqqBpIYiax?=
 =?us-ascii?Q?WehM6jEy90/7uBYokkEX3eHgXgNi7q6b/CjCCGxPM975LuUAWSQbhg2jpdb2?=
 =?us-ascii?Q?aOyFF0VVxiC32YDhu6DYgl5JQAme778IqLMRt62Y1PQXG6kRQdJXWJevIwQH?=
 =?us-ascii?Q?/6NhHjvTgB81FaPVvLkv/A5hBj5JfXbcMJGvZcH/1ipJ8cKQmOOFctEiq8ds?=
 =?us-ascii?Q?lasMb9ox1IkKOm74p+Aw4+qhCEDU1EreKfk3PH1R0MPwTHzGqp+LtIzL8gSX?=
 =?us-ascii?Q?XZRK3iO18LligM7APOOK6m9x6H1TrWTQWy25K6Q78OtLXBEk+OKlMnJeuov7?=
 =?us-ascii?Q?5E7EdZDXLvAXjAJgsSL0QEINZhf75U3MGsIKrHxaS5jOmex0f7hQD21OAveo?=
 =?us-ascii?Q?ovoqt2IvLOJzHokVjDa59XguTrRguG1abrf/tn+JHPMNgjiIlUD2H6Ht6h1/?=
 =?us-ascii?Q?YRRyJs5XOw6is46wehTCS3HuCsYlEMKNrYa2BmKEsZvUXW+UbcDpRJnRAozc?=
 =?us-ascii?Q?epHZnQNOt9L6hTIueOp3KPipMU3XVxwKhZ30Toaye+P+i/RzANmS8X61aX7u?=
 =?us-ascii?Q?E6JdC/wtjAf8R7h3aNp450jaNFcc+cg7QXiISHnZsYsRFym1Ode8P0y33aU6?=
 =?us-ascii?Q?UFUh3IXTiXl5wEg8hy8uo/n74CiO4SxMebUnTp4WR7vwi1XuECkdHUWpq3cB?=
 =?us-ascii?Q?cZ7IBU794bGRyKDsYl6xL2BJczs4gb0JX3pwDkySnM213/Jwi48WWSbLDx/s?=
 =?us-ascii?Q?Ti6mpsglKletbhXBA3EEJjLD1/tkgGT3vt7O3xo7F1T6J5M5sSd5cpFrckqe?=
 =?us-ascii?Q?h4M3tG2zG7sayPRO/92yVRD4SFxJ9cqUCox1WcflV4TeQ9A1fcmIvibkE0Pj?=
 =?us-ascii?Q?lRdcQBjLKb2CODNE2wK4zn0n+EH9HfitsfGQmf84pBG0NIvhD/2keEfhbKvN?=
 =?us-ascii?Q?6t53UqDuy5dHiooL0xE7GnaMBo64gO2ibJfocpLw64YLCBNtfCnvbj4f6fxH?=
 =?us-ascii?Q?XfdaL1Bu0ngREe4BqVVnzgIMB7jY15ZJ1qLrU4vdGFCpNDSuvlJKVTkvn/7s?=
 =?us-ascii?Q?8ir0aF9k4wNbhLLDiKykKjUfe1XgRzSGFzpPXI143CxoBSn5loFG2DS9/mvC?=
 =?us-ascii?Q?Nm/RejpHWkL2dTA/0/BZ93v6ThTiAHaiTMLn9EPahNDw8Dj1JGpa40XrXr7y?=
 =?us-ascii?Q?t3UGoG7cbiYbMNDT5a91k6ODfsY2DfFLdMjnqj1JNmeG/RmYYdKg12pIBLLR?=
 =?us-ascii?Q?/vp7ilHDX/6Vuyca529V6qwW9lskeDk6A4a8iKPqNYCWtof0EVKa8U4F2zVk?=
 =?us-ascii?Q?W4BjrokxcbDrvYSflF8MB4c1RIvmXAYjgDaaW9mW3aY9Lt55EwID9u33Ngyf?=
 =?us-ascii?Q?KKq0vpUW1R1TWx84N1EAZBtEzfodahQZhkyouefSO/MTjKIsI+UpKlZAxHOg?=
 =?us-ascii?Q?zVB3aYNFFK9QovmnKV0uQxQ6TNVhaS+O0tVNMRAVBUC8X+vbN6OV8JghAPjB?=
 =?us-ascii?Q?oV1bUzfcX8jSc64UbKFLj6RXidciyFcXlby6L5Hv?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	/kyRInxe75tv8ycwc1Yt8IILLiAtO7OBWQh5zSJkKYNL5TAJNbK+pfDJlYOsFPzpeRKPdP5eVzk+yOFbTkZoF1d6CERcY6o5cMFuuY/OEEHGpLctNFiS/vZLV41DffpWaJH0TXMPFy+tnLjz/RJ/wCxYqJoaOUWcsyrvVWTeEnYDXA2zjKmobkq+DBAO8KCuOR0nbakU3AHjhABpBM3kJvSl28DJ+8ruuMGl1e3HASOU4n7AeOEOVnRkrwT8oQbx6iPGQstaiRYW9hxCs+gkpCLZMdfu6S41CHyb95BGdbYNjt1CNMhyzG+Zaz3Rdv/4CKNzaL/UUhStcY7i5X6HY8L4JVltdxoNiaJ3SW0GVGascAiD2dzuTG3zeDkO0dv8J8qzXfCD6jnv2DmYytXV0yAPwZmakYM3PBsLIzLFbPqDc0orLp1vz+7DgfbXtkstnFJsj0Q4BtiYkY8/eDt1KgNGsWOMmcgT67ptUwNmTYG9urBT7bHLtXjmY4rGJPjIF9Uv61yEDREvUyU6ILTb+cwqF+hkwHIrG42k52IxjBnD2A/fHuASTQLyEy5a6z9NkyysLkhZXuyNPYuIlsQPw2W1hvgd5kPBsy+o2XQf3Qw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e261ed31-d71d-465a-a3f5-08dc5f768802
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 07:09:47.5240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ABc2OQrj7qUWWt4KmeagHz9TY4EPjOwYaPcc1k8P47Cy/aAkO/LUjJfr8mx0xfSSqpTF5VUCIzUXMWKoJbsqLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6592
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-18_05,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404180049
X-Proofpoint-ORIG-GUID: 5Sk8vJGOtaZbdTkm6Fnor5XGjL_iu-Q-
X-Proofpoint-GUID: 5Sk8vJGOtaZbdTkm6Fnor5XGjL_iu-Q-

Rename the function's local return variables err and werr to ret.
Also, align the variable declarations with the other declarations in
the function for better function space alignment.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2:
    On top of the patch:
      [PATCH v2] btrfs: report filemap_fdata<write|wait>_range error
    Single return value 'ret' will suffice.

 fs/btrfs/transaction.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index defdb0979d68..3388c836b9a5 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1171,12 +1171,11 @@ int btrfs_write_marked_extents(struct btrfs_fs_info *fs_info,
 static int __btrfs_wait_marked_extents(struct btrfs_fs_info *fs_info,
 				       struct extent_io_tree *dirty_pages)
 {
-	int err = 0;
-	int werr = 0;
 	struct address_space *mapping = fs_info->btree_inode->i_mapping;
 	struct extent_state *cached_state = NULL;
 	u64 start = 0;
 	u64 end;
+	int ret = 0;
 
 	while (find_first_extent_bit(dirty_pages, start, &start, &end,
 				     EXTENT_NEED_WAIT, &cached_state)) {
@@ -1188,24 +1187,20 @@ static int __btrfs_wait_marked_extents(struct btrfs_fs_info *fs_info,
 		 * concurrently - we do it only at transaction commit time when
 		 * it's safe to do it (through extent_io_tree_release()).
 		 */
-		err = clear_extent_bit(dirty_pages, start, end,
+		ret = clear_extent_bit(dirty_pages, start, end,
 				       EXTENT_NEED_WAIT, &cached_state);
-		if (err == -ENOMEM)
-			err = 0;
-		if (!err)
-			err = filemap_fdatawait_range(mapping, start, end);
-		if (err)
-			werr = err;
+		if (ret == -ENOMEM)
+			ret = 0;
+		if (!ret)
+			ret = filemap_fdatawait_range(mapping, start, end);
 		free_extent_state(cached_state);
-		if (werr)
+		if (ret)
 			break;
 		cached_state = NULL;
 		cond_resched();
 		start = end + 1;
 	}
-	if (err)
-		werr = err;
-	return werr;
+	return ret;
 }
 
 static int btrfs_wait_extents(struct btrfs_fs_info *fs_info,
-- 
2.41.0


