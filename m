Return-Path: <linux-btrfs+bounces-3140-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15415877037
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Mar 2024 11:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C02C5281F04
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Mar 2024 10:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD2638390;
	Sat,  9 Mar 2024 10:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WNU+7Oaq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Yg7Q5deH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8F623DB;
	Sat,  9 Mar 2024 10:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709979088; cv=fail; b=Vl0IKAum/AS6eXJ8WmG5F/YgVdfYQggz1lM0LATaphF/oNeFxibWAOLMMbPpjtABEBaal7YJI8Kvw43suXY+igppOfQOVO+zF/5q6zjT99YrnXaXcImmgAYgpL5bPbPbM4Z1TKzoBs5WtmbRThGAzKWCXa/TJhbUKV4E3TRNhAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709979088; c=relaxed/simple;
	bh=xmWSAp5ao12c73NxD1CXorfp2uw2UVJUczDIKqrwevc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=kJENxhKmnJIlc2QmQ1m8TuVovZ9qkXvv48qDqf64JO8PXlajWbzVhx4DKqhJeRO5QW0+59dwiT2AaucS28Haaq7K6kuaF6Tt1+RbX2cWN6LMfz3YSEU1vAmeGNQJPb8GgQzVO88inBmmB/beRuSX1octmZdzDvOMlyLbXsBie+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WNU+7Oaq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Yg7Q5deH; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4299hf0W012123;
	Sat, 9 Mar 2024 10:11:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=KWnW39qP45V9LJ2cDxJiPzYPiHF+9pxjvhnkLIMU/3s=;
 b=WNU+7Oaqlip0GED4p49WbdT9mTu2V7uYVPav9FnsGdpdJ+QHbjSIiF0E8Yvkt0uZmOna
 G8xX09fKZ+e7Bg2SJKkSq7MRT1LfVYmiw87d4/BB+V3rJoxMOK6XHjy78NQKp3KFmu9W
 KrWBqGmUAaOPn2p82rswiQC5U8hKgBS27PxV+IvGqpiNh/3IaZf8MRk5PsR8T0KqaUfV
 VAE/eVgL1lzbeEhf1ikjjvGWTSdbuo7pdSnEGHHIWi/ujXkBjfNQseWst+JyQQ5HycGI
 tTpjYn8LAfxPWuZzNAm2IahcF8dg0HDE6GopWOiw6sY/K0ylV1Fyc9tw7OwlOY7IHxVi uQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrej3re3u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 09 Mar 2024 10:11:25 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4299htqx038127;
	Sat, 9 Mar 2024 10:11:24 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wre7a8ebk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 09 Mar 2024 10:11:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b32QT2q1aih/p0/MgaRJvZ+8tPTOq/DIk/I5Uma1hgN7Ez66OzEP1NUlPN/ZGmCOlRcAafbZtod2D090AkuIOXJe9e0m5vzDPDUm1WyO3zsN62u2LOSOfhi6A+tvRQhXcpGR6H1/x9Rll305xQMZNGiTdkv+L06DGQlaQK7nUVG011HFAP4IWrLFI8pKffQcrP78lrjaM/YVDy7OfcrO/X94YAmmppY6hyqlWmJUWpjFnLnAw8+um0QBgVRgd1bQHMC6XPOLFAhOoQtJtFnX4oRA3KqjGflsK5Jg2JS0Hc2/LF1jHcsufKnZL03XMpZzg/soTv7OxvuAK1/s8Si0vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KWnW39qP45V9LJ2cDxJiPzYPiHF+9pxjvhnkLIMU/3s=;
 b=dDMwmntxCockr+OnHk7QG6qBBTsgDA6OoEOllgrlTVst3rC2pde+Px1jjYdVBK25qk1LND52yMAXSmJiG+c0x8l6xnb6YBoqLa1tyB0pGwNpPBpsEhTZBO9Fnr/1RKm3Spewq1wlV25U7ia2dNW/El08V351cdwyih2QUalVrDpCrS1TiK29Qyk/USfdvuJJKE412gRdOeeU7i02wegANynfRQZ7160nXJF8kg2zH10UCO5Jn7QTbLFWM4+poMNh0ds/2Sw7Y3/DobAVkBqDLWg4bBcuXK/QmpFbTxJKiw7RFhFVc2yFLIatAU4bJh4ukgU43HqO8sr7tsuQSApG3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KWnW39qP45V9LJ2cDxJiPzYPiHF+9pxjvhnkLIMU/3s=;
 b=Yg7Q5deHzYvM+UcE+giJN4zFkvtZDuSDRH4w259TOWtRvWabMcvAb1wzTWTGP0YyuIvZcxZ+JICi4ksAncG8VlafChNBKx7+lZaix5Ga1xpYohcFbzkUZXAlMVgO4FRuoG9HJqFyQtO0F5B4Po11E7YWgxoTplrN+s8O2xOw2Tk=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB5167.namprd10.prod.outlook.com (2603:10b6:5:38e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.33; Sat, 9 Mar
 2024 10:11:23 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7362.024; Sat, 9 Mar 2024
 10:11:22 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] fstests: new test cases for generic group
Date: Sat,  9 Mar 2024 15:40:33 +0530
Message-ID: <cover.1709970025.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0067.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::13) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB5167:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f646b52-d5d2-4fa3-5550-08dc402145ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	S83mCPh+EOg0nb86Dow8OcmyDcY8ON4x3l6i3WlBPaXfuPjK7xFhieMBX3Sd6iWZPfMzzW/A85PWh00bmezw6CG+jM9zno6wyO9YxcHva/Ya0XjpKlmYXgdD8Rjj7NQcKYg4/YNb+G6MniGa065nPuiOHVvMH5gDEAFbJR4JnhI/vkw4M5mHN3VY30mtZ9ydFQLO9OiF2Wgh5ZljApFuq7tOkAVa4b3v15WSksipr/w4EoBLzhJ51mLbETLKZg6MZGAi1ypzbqaffz3MGmiHqKs3Dzyv0BeCasW9UL1yrNLH534TgUMbThGPyUM7M9PC8nsMTD26eFYSzQ2tAzhjomFquXR0LBGWdWFk4sQO/nWkNwmVVfg4s7HKsdnh6JDoCgFA9ebms8ih3olqqxCiFvRI5S7VQ20IA+w/vH6TJnqE1SEAy+2BwlTGTHEzepu+E7vJ5ZvIFhYlqCjapHIBJzn7M7DkYuuoCSZ2snaDn45/+uamnzVR2p9Sa5Xf2gOGByvlIx/acwP5tw9dMoFXEQrMqHSpG2JrwwQeGzq90AJvo6NaXuuFXMM0T1QGya2wKgCm1a1vKKZS8COZ8unvqjoNPOa2IsxcZBqxpl6jjgWvKtPQlLtieKXRNHMa4oc/3Z7zlggqInd2fbu9mCs01CENovpMIN0ec1e+ThemjsU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?pa+5shjI26IXTQQdIai9DU9Fj6qZCZvg8O0OAvxMohjuif7+BOTfQUcSiymU?=
 =?us-ascii?Q?QWN08H+tMRwSJFOhCdKDWrKLFgjVx7+AAUaac8lvhgeLRvYiBJ8R5gtrL2FT?=
 =?us-ascii?Q?y/jnaZxgroKxjy+fES8QWhNeEhhX2c0aUHSBFMNCIgN7TaydaRzxFf9q2Q+n?=
 =?us-ascii?Q?e8SzQYWtI+xTQc3xOLBckvWZAt9QOw3Xn61oOgRnVJjwE8drW/Lmda4VdnNV?=
 =?us-ascii?Q?45DWFy4Y5/o1EfT+uf0CFoatMt5TNamyh6bN9vEnRWwPgXBsrtozCpD5aNIM?=
 =?us-ascii?Q?TRas+lNEKsHiRBUcx8+y9Nb8UAuPdXJLzy4Y4VstVv0F1vmJk5HWkmgQo6YR?=
 =?us-ascii?Q?FV4t5eGliHvTffpOsi2iftRVE4NedqEoo8f/9fAJt3tPc6dXzfww15VcqM9B?=
 =?us-ascii?Q?LVT1o4LCL3pSN0BkLstKWmDF2AX9x8Ue0UX26JKWZP8bqLn9VEcIwouPBgHT?=
 =?us-ascii?Q?Y+TbzU2BQ8/tRXxOe3wD7bYIgsk/zsRk/e4BQw1N4nBEBG+4hA8aP45I+ey9?=
 =?us-ascii?Q?C9JOhy9e5UuPX1b4EYfBW51+70I/uoHubArvDJCpgyCTvDYbWlqm6EFjXTn2?=
 =?us-ascii?Q?YYBtKxVC2jOw6oUX4W4EH6HzFwUcEV7w9/+c8xajIceiWMTvYfQwkYd3XcEW?=
 =?us-ascii?Q?801hdZJqoSL3uT5nQJ2mMeHjicfVuGkQgCxwElVvFd/BxA78H/8T9FVyIKAX?=
 =?us-ascii?Q?XPm3M6exieHb7sz+0+ppAQAYuom4aLCp4VNPsgvTe+CQhZpHC4OcZWx2qyid?=
 =?us-ascii?Q?q5BardLDqUlUaGur+kNRq5pEQ79XNizdd2GAiAnMe+XwN5eEH1EcQXVa1KQQ?=
 =?us-ascii?Q?DfDapYJ89UK3FiRhpb+T+x27yyQNpuhX46C3kwqZ4t9AVftOJYq+KeP0u7Ww?=
 =?us-ascii?Q?SIkxT1Y73HlJAgcrZidqlxaD8V7/M6JY2Tuv5d7p2EHqxRFw1y7/i6S9+EDo?=
 =?us-ascii?Q?8M7+CW1P0Dlwwd6NWF5WP5GRIYM7rfQ00iXCK9LYvwIyGIByWLRG+aInFnpF?=
 =?us-ascii?Q?w4NTD7QviwXZdMqCJmbMq77YoLToU8fFOPCvUAetpy7songPVgtIhKfq10tS?=
 =?us-ascii?Q?H7a3ABdwk8STLNhd0nZCVyyodhMdePBAQBUwSElyWRzb9VKdduYO2aI3Op3o?=
 =?us-ascii?Q?1hsPEZnyiyvtCOYbnMqdd5kLxO5v86aZqqAiKKvBl3DLTy/Oxrcsk+kxE6pO?=
 =?us-ascii?Q?bj8zj5FP0/6mA/srXfkfbz+h4eX3sEB8Mr+ObDJej1kZ5pPLb+ShIhpV1E/d?=
 =?us-ascii?Q?sip4rOyzdKSBOgDZSGkuLkwViX5lTGLkdEdz6+dJmAdvpan+tF/BkJ268soK?=
 =?us-ascii?Q?5T5029ebkSZ2fjGO3s1z2KM0S8igU6FZKMm3UW+fw0EBGqBrqIp2REZiSy6C?=
 =?us-ascii?Q?7Yx55csLvLNjCsQTt9sXohAe6JaGDz41NQb9dz+pj6dhTo9vrxb9ICGpTNu/?=
 =?us-ascii?Q?b6+mRiYFZxZ+IdaPg7eqPMQlITqLy0tYUlUEhexkCmZeO006rYpv89047Wxp?=
 =?us-ascii?Q?GlPfGrVrTa1+uX+eni8PB1G+Xp+1G9UbB2oUF3HdiW5bIiVDvzFIy2nPnV6M?=
 =?us-ascii?Q?yikXt4bk+f29MBjtVEOppOOl7MXvrU/O3NEvKFP5uW/SrfLW1RN6dFyVFJlu?=
 =?us-ascii?Q?LYMMuMZV3juVv1wFFwNu8xLPdaHIdVvp+kBZagxdZF0l?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	VHpiPLgf7VEWsSEYbTU8/9V7VqHRIpLjRrm7HOL7PAmGj+ODH6SLdmU9NTLf0uLmjoyrtpxAh1uPQhqQMd71PSEcNq3OPqJD2A3C4GYzZxjq3K7gXtoBHApxZcQsUAenoZByix6pVbq/L3OzGKxlWEZcLl/hlJGYaxVvw40aDKt67yM9FBNFhzP5P32k8fhrBKQloAZEHMv0noduOZjc8Tru7KwBykjmsJKWydqLkRQVK7u96gferR3Tdld8+FYWpieQ3WAwv9BSOe6VWpj3QiMvsEoeJ3q82qG6WGMA+9fibvA6IqzDMNkI8UNTURU+sPdjEBpxClCIiy/zK/ChUIeNX2HCKnttv5rh5SzkJ++Fq6pNfMJTB7TeIqZ1Kx7mEqYs1SO4gPU+7hRcKd2QbC4nhD23168wocMuDb7NcUVySDqyDWJQNw1tWPAJokPqisSoQq7Sj//7DMJJO7MsMRUKgbDRGt0X7ZBKs8LRe/AbtpsK7UHg0lg01b6/M54+eGt1g/FLiqUJ6J2KGpXeeruK7p9cHJuyW4tDqqV51o93pZAYV/4cdKfDAEwEdCt3knvTs56x6NAgX+p0ktcnWpWvFohIDYkD0TKKVC5qS5I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f646b52-d5d2-4fa3-5550-08dc402145ae
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2024 10:11:22.8073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LxzMJglVMFy7gC8pgG1spH5xaTLjfYXynsUV2gKTZkQ+QX0cQIhF0mSgBxBNC7SI+5iLL3dwwb1i4JBuTCQDyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5167
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=856 bulkscore=0 phishscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403090081
X-Proofpoint-GUID: K_LQOpE9VE2gcpSQoKXAnaXdbW6mt_OM
X-Proofpoint-ORIG-GUID: K_LQOpE9VE2gcpSQoKXAnaXdbW6mt_OM

Patch 1/2 relocates a tempfsid (clone device) test case from btrfs group
  to the generic group.
Patch 2/2 validates a recently discovered and resolved bug in Btrfs;
  however, the test case can be made generic.

Anand Jain (2):
  generic: move btrfs clone device testcase to the generic group
  generic: test mount fails on physical device with configured dm volume

 tests/btrfs/312       | 78 --------------------------------------
 tests/btrfs/312.out   | 19 ----------
 tests/generic/740     | 88 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/740.out |  4 ++
 tests/generic/741     | 60 +++++++++++++++++++++++++++++
 tests/generic/741.out |  3 ++
 6 files changed, 155 insertions(+), 97 deletions(-)
 delete mode 100755 tests/btrfs/312
 delete mode 100644 tests/btrfs/312.out
 create mode 100755 tests/generic/740
 create mode 100644 tests/generic/740.out
 create mode 100755 tests/generic/741
 create mode 100644 tests/generic/741.out

-- 
2.39.3


