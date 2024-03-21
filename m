Return-Path: <linux-btrfs+bounces-3484-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69120881BCF
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Mar 2024 05:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CCAE1C21654
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Mar 2024 04:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017C5C126;
	Thu, 21 Mar 2024 04:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DvEIQZDj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="m0SestVS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03519BA4B;
	Thu, 21 Mar 2024 04:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710994206; cv=fail; b=HXHy7+r3+lyKplceux9+ABGgnz6Zf7yNUg/ueuptdiIMI/5qr0+U4ARFrtTmqCdudMkkpxYPUWjVQabKdZSTvQLNoqjk3w3J6Flmnnv9BeseBUqbEHWSSDr5UO44hAfFe9uUQoxwfJVgrbROgUzrjfWXB5f1sCIDSIK3kuppcXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710994206; c=relaxed/simple;
	bh=u1M1OIFNzImBmuTak3YnZ004B+qua/oeA3cegEUbVIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rx+noJbM40m5wwB6WRBeU5juTQ8kAoVggOMY01dYtkaciICZBHQNHazzdFx+3ReBexPsakf0ryN6nfbQXNukz3hAA/ZysSc8oMor6wJX1ppWrFxSKSv9YF1Jm3Y2JnLP6khA881451Il8WQ5SGSHyScUweHaTrfZBjJsYKGZIGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DvEIQZDj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=m0SestVS; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42L23wmZ013524;
	Thu, 21 Mar 2024 04:09:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=8I7g+JwzXZyiOJMzdR7g+IClS/+qdohdDZcPL2Yj/Q0=;
 b=DvEIQZDjZ3l2jjZb2iAkHGgGQzOFkCPCmhSJYMJo4O0VicrkI66aPhQt03qhAnXOGeHn
 bsjVtDnAlg5lfGW1HjKOzYjDeAUTZoT+1AbV4FaJl/A6u8UN3vIADK+1cFpVIf+D8hwR
 SbwONSNa+r11/S/ZYaYJY0JaFycEBcHiBf0XL3NuxHBtEfqBUEqzjD5gRjo8e3M8W3Hk
 Xm3C49I9VNYaR0kdteYdKFRmtrObW7rgg8BQGcCJnI7D0nLZ5KF7v6xRvDQi19tnbNXm
 b9hLUn6P/ytSzqvmee9nFmHQpxSSNkiTqXqTWA89Gc8lDhdQZeqakYo+zbwKVaev6BEA Aw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww1udhgw8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Mar 2024 04:09:59 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42L43VEI021918;
	Thu, 21 Mar 2024 04:09:58 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ww1v8p3hb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Mar 2024 04:09:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=atVJeV74+8hzL01iK0FkzS+eOg4rZgle0gmf61y8xYWEslT7qK0Jp2NR/xM2EvJlTD5WxKRPtfcQ5L90OA0fcjDPJyjywTCrOtjTQe/1LpZtzdrjwqgc9CRK1heasyxGJMGUxV8NCuZfEtb89W6Wdy2n9PAkuZDs3z5eLB40LoSGlJJsywLPGtrjnC8NBdJ3BMLqL7Ptv11jpKRQyFtDCnFz3lSbV8ZUoG6AWJMbZhOfB36bgFXk8+JBI4LdfW0hmKEV5/p6PincSBxlb0Rh64GsCRERcr6Cikdg/z9LTSE30GwMWocIv8voBn/xlGWMzhySdvdm9jY70rp8T+uInw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8I7g+JwzXZyiOJMzdR7g+IClS/+qdohdDZcPL2Yj/Q0=;
 b=EAhDBmaaehxUbYe2JAX5ig5KLGjB5XJBWfR1ItMz1iPlq0s22elC7IH7nGu2V45T7/Q6YkoL1+FDi3J8EeX9PIQTiS+RVBG1qstLEnE6uJwHmIkf5TuOoHdnomFMRISXeBUqotOLWMpGb5EVhBSClDhG/9HweIToHworD1Fwqr/6gzRFYjbtv+YwyADD72kPXaDunLumDHZxtWWf2kCBUhVApny+KGWs/DLtONccA7Mgs/v2soqaQOYF4orrn7CfJbZsBq/uiWRJ924Z9c3WX7HSwd/SzJiKlX1cNS7Ph/ASMgpo+zxH8b2x0icQJsZ/CZN3O7Dgt9StfxCsbAfVtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8I7g+JwzXZyiOJMzdR7g+IClS/+qdohdDZcPL2Yj/Q0=;
 b=m0SestVSNhCPAnc1hL9XoPJbwlG+2OEzNHI50xiNOubfGq8t6U4Y00XKkkN55b+JXm86ILcbdDvdpATooo2bb6BzOQbGC964KVx7olltC+0PXIehn0k6MY0lGkPX6VAi/MiSlX/UZWz7mPEAGlJjhRAhq3QxUrDuP4969AWkYrY=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA1PR10MB6075.namprd10.prod.outlook.com (2603:10b6:208:3ad::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.15; Thu, 21 Mar
 2024 04:09:56 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7386.025; Thu, 21 Mar 2024
 04:09:56 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, dsterba@suse.cz
Subject: [PATCH] common/btrfs: set BTRFS_CORRUPT_BLOCK_OPT_<VALUE|OFFSET>
Date: Thu, 21 Mar 2024 09:39:22 +0530
Message-ID: <eb2493499d2f30f43afa09e980589bb4f15e9789.1710984595.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1710871719.git.dsterba@suse.com>
References: <cover.1710871719.git.dsterba@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BMXPR01CA0079.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::19) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA1PR10MB6075:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a596afd-e958-4837-77d5-08dc495cc43e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	78aShnu1rFOx+K4E7sYE6s9PoXYxSUq9XeyU3He17OjrenofV1Vm1elF4VQUtIkYOD+yy6vxgNVhXZc/aPuZ891Goo4Hoj0oNqvJfDd19L2zepVrMK/i8bVehzvqe05Y7SjhCuVaMQCq+8/aMuwii4uDPcxDZvr6uXkIVwGvANe4wdJdPl/xuSlaFwSpuurq1TVIVFHQSAtCA0I3Ya8ZqJD5FYQX+jhac36j0/YiQi30KlcrXc/ucsJmLuc7VnLTefcOwvAgl3svKjX9IP1Xqv/5r6THiAbFZbl9bYa7RN/mcZ1i1zxPrLfSYqwnCmvsoc1n/Zji5LmFB/ZNL0Imb1oByJbtbmnu2JQq/ujLejqXoewZitWp0DHul+C2xegL+mn590M1sG2Bl1opQcAQefbHVvJvIJ+ErnIJzEIdGooqc9cdNCYJFvj7K/db2lOlD05ORLaGYctqYUNO57YBc3tZxGKC8PvlY8x+HkTWQavqTWwXzHoc1q2frrUj1YY0CFK1RElhaAKv65THHb3kmSF9Ebv7AdolI5lqLx+gLQNEZ7NPJ5irJLDGQFtD1x2q5Iafvtmb69YKT7tJioAA1opmB4yNZn/gLjYQXpMV5ETUYjKFKudxlqmakim6ZNPXMaBb0YHSr56WCLrL5viAai/5DLuhItomtbaouOROHW0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?5tbLauaOm/8bwkJnjcCoGcluE6byxVaQgpxq3JfKXKq2i7Aep2FrIk2n/38l?=
 =?us-ascii?Q?SgxddqmSvQmqLiEErKZFqCT0QiPqWZKRNq0e0flADWM8xtz8vbL6RMbl60LK?=
 =?us-ascii?Q?L96+So8kQalaS+/B68R2Uw51aAQSOHdSiTDLDQ2ZOq+y7qzA2FvRcSTipeXs?=
 =?us-ascii?Q?Dc9AHwufc9XZX3ybQvPDWFHILgsOtYLG5hWb7PdKdEKydGfvQKE50IhQqO1f?=
 =?us-ascii?Q?+bsKGKwBTxs/MdESxKmdye11LZj1frtJSkRKd6PtchQu/VxjFyM11HLDapAl?=
 =?us-ascii?Q?GqG3rFRidBlEr/uV+Q//68VMs/Qk0GqpmVTp+Eyw13LbLd+N1PJuX0A+WWSk?=
 =?us-ascii?Q?P7RN24shVeqbtxpuV8YT7k976yvyE94BdWH6m7+BcPqnsOdvz77+fuxR9x4a?=
 =?us-ascii?Q?vfJuRKcz1IFTQ2KFbDq5anLGAIE7nyyDXjgKefW7GubcvhxNLXrCwkxLtbEm?=
 =?us-ascii?Q?0CwcxodeBxlqmJQJutZ52CeiJsvYqIj/HcvYi/U/dpLugXgpc+L3mCf93W/B?=
 =?us-ascii?Q?7ZxfCvkhSU+5iXeyhnfyFosz8ucjsrYO7CCIcBLb1n5yxqmvSlo0jS/DHItG?=
 =?us-ascii?Q?QWkNpom8Qf0pLJXs+GSfgRqQNm+X5hy0eHzFccwHCBMeHdRcND42YZ/WXy0p?=
 =?us-ascii?Q?G0vKzQyGX9y+ETy6O+Vx1+nPL3o7hzGqFRaFTVoXHHk6KICFPXwNfrk43mk0?=
 =?us-ascii?Q?qfznDGPp8f4z4cWYlG3jau/nBtooETqN8PpFw7UAAqX80uaYV7xXMOMkwbfe?=
 =?us-ascii?Q?FOMsbxX0vkz/uh6aF8EgwrJggo+VEdUifNy6Fvvwzj+3xYAImZsdBt2yj2+H?=
 =?us-ascii?Q?UT1di7Eb9EMZZ2uV/ZxgW1uQm79yJlj0Jsa5PvfC8GXx4LwoVLJJiZfy5kBZ?=
 =?us-ascii?Q?X9IIYDdTbg6PbKEr7TtThmHPXcn653QXZJ+v2Q6W7oj/pchet1G/4mk5XnhK?=
 =?us-ascii?Q?50nJOcpTHO+kkWE7CrWVV4dpMEeSz+OOPokqikrBUn7RKJH6UkE3BdH6NkGV?=
 =?us-ascii?Q?QUtM0uz08CgDHraRyYWKCNc17S3lshQ50rgd5TkVFH4ft33T+O0inbYaYhTt?=
 =?us-ascii?Q?XzpwdtSq5mVF713zUiTX1cy6cuGMvfyAkuCfO02LvUUfvQXiJ2wVhpRcmcOS?=
 =?us-ascii?Q?FSZQQ1of1lEGHdfvuVTl1yxC+NE/IeJ1phU+rvTRu1o+zF5KunGTs+Cfnjn5?=
 =?us-ascii?Q?8KIr/M/bhRl6c/n+vdqqW/8e5iM57ac2149ZA7IqkvzbQbWvl+bD675Lhlrt?=
 =?us-ascii?Q?IhSFU2an1TvJzSlqvgvZykUn7xEPOVat5fsmNenhZYOAa3mXMvl2R8nCuG6d?=
 =?us-ascii?Q?7wX1xJ5Oa67aJTzs/lMcbs80XsL5t4nALPZCxEuawM1+dIZkkgjEPCHqzLf8?=
 =?us-ascii?Q?jbbZk87jf7dK1pvdi8PiADJjs2xAD8P823MBHcoOXLX2LipPKffBsTrOQGop?=
 =?us-ascii?Q?SAIdHl8lvW31Pwep85ts17YwBJ11gKJB2aU4dVqjiB3qt13k3QmTh4tA9E5u?=
 =?us-ascii?Q?Nz3xncy/0FwcdJPLRbdVVfDFP5mUCWYLztqMAppuIFs8kRvst+kEFlgsYiAP?=
 =?us-ascii?Q?kGGMv/USWtvONdSFX0fGxm6YpAenCprXS4dkge94?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	0yq+KXhIklU0fOkPz2+xZhCoCxgrXP5iCqZ0zHk8MUYLXjzWJOR1OnpnNuR3SfPfc7u7EJjuZWNnWiOc+EZpOGFudNAuYAGJs8wvWf7a3MQ+U6r+PARm9CD4qROJUMPpvh1kYR4i2bF7xaMXk4XPUS0be5HRZHGTNp9ZZ88vA+vzAmLR/oDOwFdSPL7eEsPS6xsRW7M/o56oplAZrpdtAU3ojjAPNzeQvkAVC7Avv3q198Mj9oGSneNAq/A9jIHj1c8xSfv/OQ0j6l5LEerqCEKZCQubDeEYMVL9JQYrSoy8BNpm3kNM6sh85zxLRTfMV0MCR+M843Rl3WdDXMUOEH+BpkeluiJUAVpI4CWi4TBXFzqgZpdB/OTYmjk0f3yjqQ3cJkz1jJlzOgHuamk8irOPWMS4LwsIFSD/ye3j/jdUfwg7YeZk0V2UMk+XWgo4KU9EXPrl/9TY3A+Z4Gg5Vi0zqRUGatP8D029QnJUHTFHHb+9FLpfFpFh0ty5D2fUDKwXXW2zR/m3MePFvh7FZcvZdXA128QEroeEI0UieRVpXceko4Sdk4SkhpDXFr8ILES6/raAOV1Qc7abc1A3atflw0CQe77idlpm5ErDb/A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a596afd-e958-4837-77d5-08dc495cc43e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 04:09:56.1846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vlAKmNCtfgXhK00z+L6PMgukNewqt5T7v6r27mEQ5/5gBzG4+Z2jsgLDslPPbJN9paOwJpMXwWPbhBCqT/Th6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6075
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_14,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403140000
 definitions=main-2403210025
X-Proofpoint-GUID: UVNSNkB_FAFIX8n9l79U7ws8xARqH14S
X-Proofpoint-ORIG-GUID: UVNSNkB_FAFIX8n9l79U7ws8xARqH14S

As btrfs-corrupt-block now uses --value instead of -v, and --offset
instead of -o, provide backward compatibility for the testcases, by
storing the option to be used in BTRFS_CORRUPT_BLOCK_OPT_VALUE and
BTRFS_CORRUPT_BLOCK_OPT_OFFSET. Also, removes the stdout and stderr
redirection to /dev/null.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
This replaces the patch:
   [PATCH 1/5] common/verity: use the correct options for btrfs-corrupt-block

 common/btrfs    | 16 ++++++++++++++++
 common/verity   |  9 ++++++---
 tests/btrfs/290 | 30 ++++++++++++++++++++++--------
 3 files changed, 44 insertions(+), 11 deletions(-)

diff --git a/common/btrfs b/common/btrfs
index ae13fb55cbc6..11d74bea9111 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -660,6 +660,22 @@ _btrfs_buffered_read_on_mirror()
 _require_btrfs_corrupt_block()
 {
 	_require_command "$BTRFS_CORRUPT_BLOCK_PROG" btrfs-corrupt-block
+
+	# In the newer version, the option -v is replaced by --value,
+	# and -o is replaced by --offset, so normalize them.
+	$BTRFS_CORRUPT_BLOCK_PROG -h 2>&1 | grep -q "value VALUE"
+	if [ $? == 0 ]; then
+		export BTRFS_CORRUPT_BLOCK_OPT_VALUE="--value"
+	else
+		export BTRFS_CORRUPT_BLOCK_OPT_VALUE="-v"
+	fi
+
+	$BTRFS_CORRUPT_BLOCK_PROG -h 2>&1 | grep -q "offset OFFSET"
+	if [ $? == 0 ]; then
+		export BTRFS_CORRUPT_BLOCK_OPT_OFFSET="--offset"
+	else
+		export BTRFS_CORRUPT_BLOCK_OPT_OFFSET="-o"
+	fi
 }
 
 _require_btrfs_send_version()
diff --git a/common/verity b/common/verity
index 03d175ce1b7a..33a1c12f558e 100644
--- a/common/verity
+++ b/common/verity
@@ -400,9 +400,12 @@ _fsv_scratch_corrupt_merkle_tree()
 			local ascii=$(printf "%d" "'$byte'")
 			# This command will find a Merkle tree item for the inode (-I $ino,37,0)
 			# in the default filesystem tree (-r 5) and corrupt one byte (-b 1) at
-			# $offset (-o $offset) with the ascii representation of the byte we read
-			# (-v $ascii)
-			$BTRFS_CORRUPT_BLOCK_PROG -r 5 -I $ino,37,0 -v $ascii -o $offset -b 1 $SCRATCH_DEV
+			# $offset (-o|--offset $offset) with the ascii
+			# representation of the byte we read (-v|--value $ascii)
+			$BTRFS_CORRUPT_BLOCK_PROG -r 5 -I $ino,37,0 \
+				$BTRFS_CORRUPT_BLOCK_OPT_VALUE $ascii \
+				$BTRFS_CORRUPT_BLOCK_OPT_OFFSET $offset \
+							-b 1 $SCRATCH_DEV
 			(( offset += 1 ))
 		done
 		_scratch_mount
diff --git a/tests/btrfs/290 b/tests/btrfs/290
index 61e741faeb45..d6f777776838 100755
--- a/tests/btrfs/290
+++ b/tests/btrfs/290
@@ -58,7 +58,7 @@ corrupt_inline() {
 	_scratch_unmount
 	# inline data starts at disk_bytenr
 	# overwrite the first u64 with random bogus junk
-	$BTRFS_CORRUPT_BLOCK_PROG -i $ino -x 0 -f disk_bytenr $SCRATCH_DEV > /dev/null 2>&1
+	$BTRFS_CORRUPT_BLOCK_PROG -i $ino -x 0 -f disk_bytenr $SCRATCH_DEV
 	_scratch_mount
 	validate $f
 }
@@ -72,7 +72,8 @@ corrupt_prealloc_to_reg() {
 	_scratch_unmount
 	# ensure non-zero at the pre-allocated region on disk
 	# set extent type from prealloc (2) to reg (1)
-	$BTRFS_CORRUPT_BLOCK_PROG -i $ino -x 0 -f type -v 1 $SCRATCH_DEV >/dev/null 2>&1
+	$BTRFS_CORRUPT_BLOCK_PROG -i $ino -x 0 -f type \
+				$BTRFS_CORRUPT_BLOCK_OPT_VALUE 1 $SCRATCH_DEV
 	_scratch_mount
 	# now that it's a regular file, reading actually looks at the previously
 	# preallocated region, so ensure that has non-zero contents.
@@ -88,7 +89,8 @@ corrupt_reg_to_prealloc() {
 	_fsv_enable $f
 	_scratch_unmount
 	# set type from reg (1) to prealloc (2)
-	$BTRFS_CORRUPT_BLOCK_PROG -i $ino -x 0 -f type -v 2 $SCRATCH_DEV >/dev/null 2>&1
+	$BTRFS_CORRUPT_BLOCK_PROG -i $ino -x 0 -f type \
+				$BTRFS_CORRUPT_BLOCK_OPT_VALUE 2 $SCRATCH_DEV
 	_scratch_mount
 	validate $f
 }
@@ -104,7 +106,8 @@ corrupt_punch_hole() {
 	_fsv_enable $f
 	_scratch_unmount
 	# change disk_bytenr to 0, representing a hole
-	$BTRFS_CORRUPT_BLOCK_PROG -i $ino -x 4096 -f disk_bytenr -v 0 $SCRATCH_DEV > /dev/null 2>&1
+	$BTRFS_CORRUPT_BLOCK_PROG -i $ino -x 4096 -f disk_bytenr \
+				$BTRFS_CORRUPT_BLOCK_OPT_VALUE 0 $SCRATCH_DEV
 	_scratch_mount
 	validate $f
 }
@@ -118,7 +121,8 @@ corrupt_plug_hole() {
 	_fsv_enable $f
 	_scratch_unmount
 	# change disk_bytenr to some value, plugging the hole
-	$BTRFS_CORRUPT_BLOCK_PROG -i $ino -x 4096 -f disk_bytenr -v 13639680 $SCRATCH_DEV > /dev/null 2>&1
+	$BTRFS_CORRUPT_BLOCK_PROG -i $ino -x 4096 -f disk_bytenr \
+			$BTRFS_CORRUPT_BLOCK_OPT_VALUE 13639680 $SCRATCH_DEV
 	_scratch_mount
 	validate $f
 }
@@ -132,7 +136,11 @@ corrupt_verity_descriptor() {
 	_scratch_unmount
 	# key for the descriptor item is <inode, BTRFS_VERITY_DESC_ITEM_KEY, 1>,
 	# 88 is X. So we write 5 Xs to the start of the descriptor
-	$BTRFS_CORRUPT_BLOCK_PROG -r 5 -I $ino,36,1 -v 88 -o 0 -b 5 $SCRATCH_DEV > /dev/null 2>&1
+	btrfs in dump-tree -t 5 $SCRATCH_DEV > $tmp.desc_dump_tree
+	$BTRFS_CORRUPT_BLOCK_PROG -r 5 -I $ino,36,1 \
+					$BTRFS_CORRUPT_BLOCK_OPT_VALUE 88 \
+					$BTRFS_CORRUPT_BLOCK_OPT_OFFSET 0 \
+					-b 5 $SCRATCH_DEV
 	_scratch_mount
 	validate $f
 }
@@ -144,7 +152,10 @@ corrupt_root_hash() {
 	local ino=$(get_ino $f)
 	_fsv_enable $f
 	_scratch_unmount
-	$BTRFS_CORRUPT_BLOCK_PROG -r 5 -I $ino,36,1 -v 88 -o 16 -b 1 $SCRATCH_DEV > /dev/null 2>&1
+	$BTRFS_CORRUPT_BLOCK_PROG -r 5 -I $ino,36,1 \
+					$BTRFS_CORRUPT_BLOCK_OPT_VALUE 88 \
+					$BTRFS_CORRUPT_BLOCK_OPT_OFFSET 16 \
+					-b 1 $SCRATCH_DEV
 	_scratch_mount
 	validate $f
 }
@@ -159,7 +170,10 @@ corrupt_merkle_tree() {
 	# key for the descriptor item is <inode, BTRFS_VERITY_MERKLE_ITEM_KEY, 0>,
 	# 88 is X. So we write 5 Xs to somewhere in the middle of the first
 	# merkle item
-	$BTRFS_CORRUPT_BLOCK_PROG -r 5 -I $ino,37,0 -v 88 -o 100 -b 5 $SCRATCH_DEV > /dev/null 2>&1
+	$BTRFS_CORRUPT_BLOCK_PROG -r 5 -I $ino,37,0 \
+					$BTRFS_CORRUPT_BLOCK_OPT_VALUE 88 \
+					$BTRFS_CORRUPT_BLOCK_OPT_OFFSET 100 \
+					-b 5 $SCRATCH_DEV
 	_scratch_mount
 	validate $f
 }
-- 
2.39.3


