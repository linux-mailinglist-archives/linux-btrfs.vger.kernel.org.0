Return-Path: <linux-btrfs+bounces-4503-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDAC8AFB90
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Apr 2024 00:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7317228385B
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Apr 2024 22:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED49D14389A;
	Tue, 23 Apr 2024 22:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nZ+Gy1IT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DkUcHYEJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1F226288;
	Tue, 23 Apr 2024 22:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713910036; cv=fail; b=GuQ9/MNzPrGShFoaVUtIIMEt4naB/79ddbnoaXDKeBvk+31qCxOxgA+IoXX4VDSMALhn8Q+nLqR1R87r3M/y5TuidMrqxswRIHz2qwadWdMpNH+hQG6+MtW/IVJFDhpejtbL/XRBq5wJRSc+kS0tnEtb9YFZ3iimxk+3hE+2U+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713910036; c=relaxed/simple;
	bh=IQiy0HVfXwd14gYWEeA38qRWahnKiAnD6xyVBnQt1zA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=CXfu0kSrMHeiLn4F/DIlehl0BQum8R7TbJaGpj/oX4YyyF0c+lNYtNSvP3qjW4sb9CJZuj5aXmx9KFTBk+xLfA50mRpT2bic/72PyIciscb5tcjfHqxSzVCWnifb0MIZCvuuQmWNnpB7Oan3JypoYZHYYI0V3dRQrRsYqoheOPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nZ+Gy1IT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DkUcHYEJ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43NJd52q028003;
	Tue, 23 Apr 2024 22:07:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=t+0k98kDHy3Kg3PRyrslPp6rcdjGhjLdDo2k6zoy8IE=;
 b=nZ+Gy1ITmMFyZSlCMC0ZEjOUdEucjxy4NJu4KgxOhut535n7sljt/vgHO193KqbkDvuQ
 Sp8+DVLpB4l9bRViAcABDcipmEAUXCQ+LkR5JmO4H5XcDUJQSvXjAgUZ7Db+hT/9/ceM
 sp21eSO6wi9ywSQxGECyfk8wqmonp4xwyWl+7eL9gfrBfIqgdkU0MQYdLorPMBui9kjK
 jw/ZIjZyp5qZH2dETIfv2foywKutJhB0p31W70Ok2OzJCig9lQBWPzmxHjIMva+nxl7s
 dIgpNAxqcAVMG5TsNysD+DMNU8Rk9jgeHUaVwSPKmi8AU2PjLpdn9hdjZl0nkddUkXTe NQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm4md76gd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Apr 2024 22:07:10 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43NLKq67025265;
	Tue, 23 Apr 2024 22:07:09 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xm45e73vw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Apr 2024 22:07:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UV85bhj3CgsN68sv/L11LK6Rqx/WuQkJan9D6FnGa8bmlI1F+CnIpUYyZptHH8OxxbtxD6TQ571J7/wHb9XJsup/AVn0KR6cVBzYhLkvM0EFuWK2elZabPJBckBjHUl5JVxE6FKu9Fftsj/ITIRmFNUrpHm2jSgsPqQtjw5inVY4X/y8V1H0LvkTPIKkGa3iAp5Tj1PNU4Ek5Xmj7qziyb8WARZzvQQqhIoBaEOfJEkpumE2XGaWMKlW33iBwt+ul9ivy3JGJi9Z4iGsN4JVdqZ6Mr+c62Z4Apqac5LU76kvy9QuuGJynWGS88zE+ECR/t57rseFvidF8AhYzT8t9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t+0k98kDHy3Kg3PRyrslPp6rcdjGhjLdDo2k6zoy8IE=;
 b=kX7isQPCiZ4Wljp03007o/9PyP8ct2uzbOnuwRBiZ41hGdxMjitpg0921wsOvoVMcck7QHaVK3ZGVEavFb4f5bfsORigL2HVqYL8IU6hVktUoVbMRZ6ALO27f/NPAPg9m1mlMdeFT7DRAB6chTG+pCeebWTldpaw7chr82N3r5Wz+kEk9jzIlIxC+6OT+hKntNlI8I5mnxeHbDJx349MzUqIqKG0izB7WqtuaBt69uAOFYrEubmOIEAr5jFGJ7ETtZLRyKcVUK45fwM3KkvoyDF28xg+eyPESMQw7hHw+5k4Q/S1+/yiVQJzoPiZvviImBR5PE9L11lP6rPIc75/Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+0k98kDHy3Kg3PRyrslPp6rcdjGhjLdDo2k6zoy8IE=;
 b=DkUcHYEJkmkQeaHyYHxFWKZjPBf7mbVszT06EXYfTW8LXshxfu3qB2PXyrt25MUZ9tP2E1OqcZ2L3eRFshu31FKmkjuWubkgCZRpVY0R48NYkkSl0bUd6ARd/t0qw3QlxuOpWgbMoaBfB6FvRsqqFKVFm0BUo+yy2426/YSioGE=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH0PR10MB5196.namprd10.prod.outlook.com (2603:10b6:610:c0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Tue, 23 Apr
 2024 22:07:07 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7519.021; Tue, 23 Apr 2024
 22:07:07 +0000
From: Anand Jain <anand.jain@oracle.com>
To: zlang@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: [GIT PULL] fstests: btrfs changes staged-20240418
Date: Wed, 24 Apr 2024 06:06:43 +0800
Message-ID: <20240423220656.4994-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0018.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::30)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH0PR10MB5196:EE_
X-MS-Office365-Filtering-Correlation-Id: ae0af4eb-5ac6-4c83-65c5-08dc63e1b718
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?+Qlbcdf7cZbsXO9aaNlvEPS5kpFe8dSHZ+DTZAshG36u3pkkbe4or+O9EZhV?=
 =?us-ascii?Q?ArzDTIX33bHBmwuhtTcFXKyouJBt1u1L+ant6jNjcUFeK5IuA1U1Gxw38AUz?=
 =?us-ascii?Q?LjDEVLfoadN+H7eQig1jzYMjNKjXWDuKbn+EwOL4aMB0pPYq9HPzQJ6G93L2?=
 =?us-ascii?Q?Va7oC75wTJAZLdjbM+0SM+/SjhTYbas4oPkZ780B3jQzXgYc5146zhBq75gA?=
 =?us-ascii?Q?XLy5Pz2TGvp7zzczG9jnE+IXRMianoJzCES4UjkemhdQ8Vss1OHdUtpDsa7c?=
 =?us-ascii?Q?ffgi7ZH7ZutToHvnFm94jfm77Zd5KTUbHGODGinMaKFRMsa3etroe9V5S733?=
 =?us-ascii?Q?/wkidJ7mx0Das4VhMbXHSJaBLpDAGWsBImIv0wA17XX0+vuPB3ahfKDWWci3?=
 =?us-ascii?Q?u/6pXy8ElhISrpHrWXil4XAZwOw5No8DM47y34CWgLw7o512PSdiadVWjB+W?=
 =?us-ascii?Q?TMJLWfSLPl6Lo6FvifSQhGFY3vEw1/8BUC65TnXB7obwTR6AeYL6vFdmiKrP?=
 =?us-ascii?Q?ezivWVrIDfUFOvqUSOpzGy2pO3+FmxAX5WJhbdKLrip9gclp+b9KVUv3Nt+d?=
 =?us-ascii?Q?WrdrikB6Qz3hIVWmrywdaeD2TU7R9ZLRxzeXi3SQHwIT0fqPFSJtUNZcnaYQ?=
 =?us-ascii?Q?Dl7nhdO4E2Yp1HXntJhCndE9ZPSRYAgEqsT1Cfd9MTlu+2qU6SXYbjThmCKL?=
 =?us-ascii?Q?t47dZlw3Mdxz4RA+51PtTPU8ERPjF2vsKwfTLgtgWYCEFmCl+X78BJpNgQb8?=
 =?us-ascii?Q?DdtImnKbi0ZUvbi0R2L27Ax2SlxitH9d2+qHyO3JMq+u82wpqRXf/4l0sehC?=
 =?us-ascii?Q?N3bm+yxb1u9R0PI9gzPWmM9HaCNnQuBTcq1dmp/H4OgPTFzaUC5WpObwGOJR?=
 =?us-ascii?Q?AEBR6/G2p6H8fYebaVQNGa4QWk3zHUl7V8ZBDoo28sUN0UmPEXoqhn3qoqfI?=
 =?us-ascii?Q?RsUfmTcp++vKkR6HmHX/8ikzLn32iGjyuafUzo8vekNfOTjMUBI75OdUtmLw?=
 =?us-ascii?Q?9K6rtVSz+nrolKbJrAWqEu05YVJtIG1MYm2djmafsq2qmkTa/Gy01w9vI/Qy?=
 =?us-ascii?Q?474Mo1Ndylk8XCNE02aT14WTEuotiE2cqT91T6X1s+6Y9gwxLXKOZO3dzvL7?=
 =?us-ascii?Q?oVdKFT9zoxGsmZ0UkPGhksZZQqoDPXNRetx1q35OI2ynyW3SavSMcacC/xHW?=
 =?us-ascii?Q?7m5nqkB+p/gthrUv1jn6JBnoXgrmNVfidUWPzTWX52yQ8nTzCe7QFxJbWYCA?=
 =?us-ascii?Q?RLb1iZzX/Tvmg7FP0H4wC6wHPE2cmRQTzp515ZsqjQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?l4qOA0a3Dpk2srL1c4CLsnEF9iwGUuW8kUyeQ/5wqHF7jbpZ0+zBOngVvSL3?=
 =?us-ascii?Q?NmQwatLIvUpDJeVBcCzig48JKuBJXGpiMxUfD23ZY1z3dZvMuYzAkjABmTb+?=
 =?us-ascii?Q?cka4t7ZEftI8QsoygXnhAjM5XMf/NXsxpj/GCyilJJwMT/qQGMAIG7PSw6DJ?=
 =?us-ascii?Q?Og9dgcioUsekmaSy3f4B3WpSs9vXgntWu38E0GvfmOYaG72O53UDg1qeY8KK?=
 =?us-ascii?Q?rKcLhofgpeqVsDe3wQKnk9LBSvupMLuGfaxsJWU1O1JG6Ney+DCQWC8g4zuv?=
 =?us-ascii?Q?VMVAa6cATa2YO3ACNcnmXMKE52OT0lC1UHohY2s0xJkuaA24u46UH25rIkU3?=
 =?us-ascii?Q?ZSnQE7IwASzMvqPLjvstYBCuMPkFkbJjx3a+mNKKTTtM60fKaaXqHLAKHu9P?=
 =?us-ascii?Q?PTZkwDOVZVqR9uMN0MmpmihBrvonzvAqRbu6h28kA4+3PvW7Z3kyKsd5VUoY?=
 =?us-ascii?Q?d5JiwKLgOIF/95hybP3r5Zo4+YdCW32Qjmqmf1QT8+hwFtQJyK+Tq87baEev?=
 =?us-ascii?Q?3OQhg2COd8WM5i8HbBWYcfZ/MDw8wI274Uu1OGtzNvoFBtnM92gO5JWV5ENK?=
 =?us-ascii?Q?01etpJQZfT7j4eh+u7Rk08s0uVguFUg/e1dA4fA8QfTWO8j+hh4ZzqEz0DTo?=
 =?us-ascii?Q?mpyaUeCbPOwbOnVb3iQuj8Ed2J6UXowntZm78dQ9uiF8Ds4VI4Z1RQEaiFoV?=
 =?us-ascii?Q?C23JMlWsbHwFqp18YdIHday5SBwrveOMN6+tdKcWpkZ+RBs72WO484EeIv7w?=
 =?us-ascii?Q?Y9xkVP42bzjaD6ZqtS2eKbhtLVIXvwr31RKTgTfRhL0OOaTtMMb2QFzB+wpP?=
 =?us-ascii?Q?AdOI5YfQIxZvux6g8fLmma2bvcjw1AOM57TUBKdMLVW98+t20AQsLHyq8EOB?=
 =?us-ascii?Q?ox2/+urkn1eP4yjl8z2jWPK6SUXhra1tkd4K8qUV7ii1Tu2C+E3PX0D1aa2E?=
 =?us-ascii?Q?ZQGPZoHy4uqrmlW1lmbZCYucDzGujcFT7LqQLXEaPBf/W84x8YB67/m7MrLA?=
 =?us-ascii?Q?8sDxi6yuc3o2vJ63yIY5MhS4l+8QcFPCJ1RyCwdDbEl0UJMfyhSA08qgwCE9?=
 =?us-ascii?Q?FRAfeU/NxnAt4gVGOqfoThZQJsvBUhMAebM9BM0fa32ODJKXEXP74knK/SGI?=
 =?us-ascii?Q?/jzVCepTbSbucRclhJWiPmxyTFo6tnCCjQJr3zNpd4l7TQIdaTOiZ0KXs5+g?=
 =?us-ascii?Q?t/G/hgnl1PmQBFx4ZSQyWUkfxfkfqsYf9fZ2L69t7uU88NbgmMusJOuULLD4?=
 =?us-ascii?Q?jE8uFkJfnfhl7Ey3wnBqqI7alA7neIFg/mlfamxzPPNZzduDX4YeRfOxGbrs?=
 =?us-ascii?Q?Bct2eGTQL4Cbu1FbTbFsGlIRrgDc48YEGgE9/asNrsEar3VeamBuGaEB86cT?=
 =?us-ascii?Q?20gH+0uRcgxZzAhgjaJxMgxSSoqbSbJPHEw1cvG1p8bPUtUmOVfbo5hkQ01c?=
 =?us-ascii?Q?p1A2534ddMbvp1uBo27bsMOKnuPreadxVS4vCWnPSdFBzof1zykky5MzGAtM?=
 =?us-ascii?Q?wICmzlCmRcKGKWUxJ2v1Csb+QoS0kvoAtNzXhdNHgsBz5+d9VXzczJ9nMhDr?=
 =?us-ascii?Q?v/eYnpiP3wCgEjT/izmBOLM5vvzC94DFxOAuh0ybzNGTYnVYTJqXakDRGVUw?=
 =?us-ascii?Q?LA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	tSvDQd8LPXlrYHk2e+hT6BIyuExvhX/LE9holXOsD3vL2FzUfPQMClcltVvaRuU2EpXOjXMukG4J8ly5Cy1WDPQf4+tVTHGSX7w0Mcmw8xLjy24+7kBxA80j/zsPVWA/eDggTJKAjqJYbwCNwVLQs5ec4lgxW59oRz0FaqBWnp5EPohAavZberAsYKOneoejwtIs3suaOxbuHmToctMfOXLcqpAUNqYoMDAumwPr7SNNBH78S29OMb8rE15ccABRLk0e0IPEUBPyQCvF+VAKD9pP5b7fuP8knl2ke3bMq5HeGnWEiCsJJ4j4TYX7+cNQ4UAIxo521GH4+2rccZlBlW+7C3T6AcmRQIHD/7GpwFN2pNmbRzpxh25cbotK+cWE2Rrc7Mv0V4/isY4rI5C/sqskSgFH08koG/8bGjyu/DRZtyStSNdKjCRlZwOaqh1t/m4FWGEkzntMWZBQgY3GPDUvT5vwmGU63a7uIXa1TabXBexXHZvuCtqmfFSkzTK5LNp3h9sOj3en/M9LQU+ZlaOee5j40/p6B3iAmeFfCcAIuZEvpoyQoBek39jh4mO47SbmrsOhXHL2rjtx28qp/8Fz8bRY27EtobCoptAWQJI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae0af4eb-5ac6-4c83-65c5-08dc63e1b718
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 22:07:07.3547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nFng2mtcRBRwEN5t3RZmyXISoxDJahzMD7dHa1YcHpFvCFSlFnLEcA2RjeZXvwqibzygekfD+0LVM1wPEowolA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5196
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-23_17,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404230057
X-Proofpoint-ORIG-GUID: vgrxF3Xe5pHKR7CKVe_jFLfcAnLY62gi
X-Proofpoint-GUID: vgrxF3Xe5pHKR7CKVe_jFLfcAnLY62gi

(I just realized that the previous attempt to send this PR failed. Resending it now.)

Zorro,

Several of the btrfs test cases were failing due to a change in the golden
output. The commits here fix them. These patches are on top of the last PR
branch staged-20240414.

Thank you.

The following changes since commit 943bbbc1ce0a3f8af862a7f9f11ecec00146edfe:

  btrfs: remove useless comments (2024-04-14 08:38:14 +0800)

are available in the Git repository at:

  https://github.com/asj/fstests.git staged-20240418

for you to fetch changes up to 6fc18c4142c9470013dae598cdc29a2f67887a94:

  fstests: btrfs: use _btrfs for 'subvolume snapshot' command (2024-04-18 20:16:21 +0800)

----------------------------------------------------------------
Qu Wenruo (2):
      fstests: btrfs: rename _run_btrfs_util_prog to _btrfs
      fstests: btrfs: use _btrfs for 'subvolume snapshot' command

 common/btrfs        | 15 ++++++++-------
 tests/btrfs/001     |  2 +-
 tests/btrfs/001.out |  1 -
 tests/btrfs/004     |  2 +-
 tests/btrfs/007     |  6 +++---
 tests/btrfs/011     | 10 +++++-----
 tests/btrfs/017     |  6 +++---
 tests/btrfs/022     |  6 +++---
 tests/btrfs/025     | 20 ++++++++++----------
 tests/btrfs/028     |  2 +-
 tests/btrfs/030     | 12 ++++++------
 tests/btrfs/034     | 12 ++++++------
 tests/btrfs/038     | 20 ++++++++++----------
 tests/btrfs/039     | 12 ++++++------
 tests/btrfs/040     | 12 ++++++------
 tests/btrfs/041     |  2 +-
 tests/btrfs/042     | 10 +++++-----
 tests/btrfs/043     | 12 ++++++------
 tests/btrfs/044     | 12 ++++++------
 tests/btrfs/045     | 12 ++++++------
 tests/btrfs/046     | 14 +++++++-------
 tests/btrfs/048     | 16 ++++++++--------
 tests/btrfs/050     |  6 +++---
 tests/btrfs/051     |  6 +++---
 tests/btrfs/052     |  2 +-
 tests/btrfs/053     | 12 ++++++------
 tests/btrfs/054     | 18 +++++++++---------
 tests/btrfs/057     |  6 +++---
 tests/btrfs/058     |  4 ++--
 tests/btrfs/077     | 12 ++++++------
 tests/btrfs/080     |  2 +-
 tests/btrfs/083     | 12 ++++++------
 tests/btrfs/084     | 12 ++++++------
 tests/btrfs/085     |  4 ++--
 tests/btrfs/087     | 12 ++++++------
 tests/btrfs/090     |  2 +-
 tests/btrfs/091     |  8 ++++----
 tests/btrfs/092     | 12 ++++++------
 tests/btrfs/094     | 12 ++++++------
 tests/btrfs/097     | 12 ++++++------
 tests/btrfs/099     |  4 ++--
 tests/btrfs/100     |  6 +++---
 tests/btrfs/101     |  6 +++---
 tests/btrfs/104     | 10 +++++-----
 tests/btrfs/105     | 14 +++++++-------
 tests/btrfs/108     |  6 +++---
 tests/btrfs/109     |  6 +++---
 tests/btrfs/110     | 16 ++++++++--------
 tests/btrfs/111     | 20 ++++++++++----------
 tests/btrfs/117     | 18 +++++++++---------
 tests/btrfs/118     |  8 ++++----
 tests/btrfs/119     |  6 +++---
 tests/btrfs/120     |  4 ++--
 tests/btrfs/121     |  2 +-
 tests/btrfs/122     | 10 +++++-----
 tests/btrfs/123     |  2 +-
 tests/btrfs/124     | 10 +++++-----
 tests/btrfs/125     | 18 +++++++++---------
 tests/btrfs/126     |  4 ++--
 tests/btrfs/127     | 12 ++++++------
 tests/btrfs/128     | 12 ++++++------
 tests/btrfs/129     | 12 ++++++------
 tests/btrfs/130     |  2 +-
 tests/btrfs/139     |  6 +++---
 tests/btrfs/152     | 14 ++++++--------
 tests/btrfs/152.out |  2 --
 tests/btrfs/153     |  4 ++--
 tests/btrfs/161     |  4 ++--
 tests/btrfs/162     |  6 +++---
 tests/btrfs/163     | 12 ++++++------
 tests/btrfs/164     | 12 ++++++------
 tests/btrfs/166     |  2 +-
 tests/btrfs/167     |  2 +-
 tests/btrfs/168     |  6 ++----
 tests/btrfs/168.out |  2 --
 tests/btrfs/169     |  6 ++----
 tests/btrfs/169.out |  2 --
 tests/btrfs/170     |  3 +--
 tests/btrfs/170.out |  1 -
 tests/btrfs/187     |  6 ++----
 tests/btrfs/187.out |  2 --
 tests/btrfs/188     |  6 ++----
 tests/btrfs/188.out |  2 --
 tests/btrfs/189     |  6 ++----
 tests/btrfs/189.out |  2 --
 tests/btrfs/191     |  6 ++----
 tests/btrfs/191.out |  2 --
 tests/btrfs/200     |  6 ++----
 tests/btrfs/200.out |  2 --
 tests/btrfs/202     |  3 +--
 tests/btrfs/202.out |  1 -
 tests/btrfs/203     |  6 ++----
 tests/btrfs/203.out |  2 --
 tests/btrfs/218     |  2 +-
 tests/btrfs/226     |  3 +--
 tests/btrfs/226.out |  1 -
 tests/btrfs/272     | 14 +++++++-------
 tests/btrfs/273     |  6 +++---
 tests/btrfs/276     |  2 +-
 tests/btrfs/276.out |  1 -
 tests/btrfs/278     | 14 +++++++-------
 tests/btrfs/280     |  2 +-
 tests/btrfs/280.out |  1 -
 tests/btrfs/281     |  3 +--
 tests/btrfs/281.out |  1 -
 tests/btrfs/283     |  3 +--
 tests/btrfs/283.out |  1 -
 tests/btrfs/287     |  6 ++----
 tests/btrfs/287.out |  2 --
 tests/btrfs/293     |  4 ++--
 tests/btrfs/293.out |  2 --
 tests/btrfs/300     |  2 +-
 tests/btrfs/300.out |  1 -
 tests/btrfs/302     |  3 +--
 tests/btrfs/302.out |  1 -
 tests/btrfs/314     |  3 +--
 tests/btrfs/314.out |  2 --
 tests/btrfs/320     | 16 ++++++++--------
 118 files changed, 375 insertions(+), 435 deletions(-)

