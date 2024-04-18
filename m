Return-Path: <linux-btrfs+bounces-4406-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E6B8A93C5
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Apr 2024 09:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 933041F232BF
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Apr 2024 07:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C263BB50;
	Thu, 18 Apr 2024 07:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KAsqCuF4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="W/5HAS4i"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3707B3A8EF
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Apr 2024 07:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713424226; cv=fail; b=DOhrt1oECRu0tXa777BD3IiCd3n6w/PC1wPjH9DjT+/4ppaFXzivgfKOxMjL72JjX6HrU3GFVgFjMxQEsJnW8vMpnnMlhD9voUX+pap8M/mQcMcwhWgphbTmKsEuUNfNzk2wrGyjA2Fkk79/nT1+AfZmIAjapPZoMP+dMGNE6V8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713424226; c=relaxed/simple;
	bh=537eEPHFDNcyY+MycEgQGPCuSIg4t777Hyc4NmpVBfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hAYjQr+grijEPeWaNzXlr0mhtkYSOx6hVtxVczrl5TpkTOhYaV0K5QIYucquAZtCb7oT5eoizIrvj/cOSUBkZxgPTJUw8qq9sAiLjW9ghy0i0/lW0BOgDiXzLgIhm2hg4QTu7sItLSnJfvJ5DyQUN+7WQ/pzs579LYSaRE+Vzb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KAsqCuF4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=W/5HAS4i; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43I3xdDL010638
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Apr 2024 07:10:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=UxVcRDj+XeM26azeIzkQ+u940YDkyAH6ER+sy461qy4=;
 b=KAsqCuF41i/+c9gbN2jzxC70tAwsqH3PWPEvCfKTO1hL40JVJFViF8MfrxEJBqTvQ6Lb
 R/++694ldIpTjEGvwV3OADP7GhGSsloz8/SALCUSJnt/RO6rmjhBh1/dLNuTiXB22qv5
 jCP2CruLklyiJC7bXmgQdGnfNnQN2R/+mD0MChtypvv368XSlqhzIsAON0y6wp6qMdXb
 LOIsQ+ZNkPnmfDeTjNs/2abIUqtusWJxQJerAxRkZYOzpXJzSU0ynToUK6478q3HbSxd
 o8A0V7xIj9iqB0T83TDIXDLp9rikmoeiP56pBkJPOVIbglntzYWJZQw8y3pVmDoC3VhF WQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfjkv9k6s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Apr 2024 07:10:24 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43I6RVc4004927
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Apr 2024 07:10:22 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xfggg8a3q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Apr 2024 07:10:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YbJqH8ZD5uLjXc9SJwEhrNnPZWVJdra8XyjK+BG5Ue9bbIB89ZwAnvaOV2f3v0yERHAMfe+vIKJJtJ2JBo7m/JZZtsVS23kA3v2nEOWGhfyw1mJabJ/ahB7aDWDhR6DAERqEZD3ciHEtAxhx2smJK4zDeAyV4X/3SPfvQj01uB3hwTMGAqA+t6TffvnA0CxzCWpB4LDWUey6xpybrvLqgHrFf9iZ0AclwQ619yJvQeqzDGJr1RM84Y5fJOXPHrsXD0iGoWJbmVF2vzn9ov+3oKPtPq61KVzOOgx8thMfMl9Ses846EJePHBf7f3ZMODnzmFpcOZ3i58+pda+9stPlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UxVcRDj+XeM26azeIzkQ+u940YDkyAH6ER+sy461qy4=;
 b=i+VBkUTJbqlV6dvY05JBkbaoqO+cg99zMAgxdPqpO8U5Sk1Hn+lOce3qKAmFikP4Szgoabwo0R1MP4lxrtWCrAT2jjr4QUWHaj+yHBklylCuAgDVnVOwLRg2WPG+RtVmFaOCssOTL6ctclZNdLKG8K4ALULbou7xTGkwo5ahcpsvwqMk44iRUWT7DOC3m8Q7bFriG6n+kFQiDPXggEt4pvCyUiF1tcrl0ZbIxSThINc5aLtnmckRI6Rb+xjZGXnwJfFfMUk1Q+5UZriPPwUp7y4z7HfHZwCxi8Vo8/4pS6YE8sINsiyrGngjqC2cbLxFPi9uH8t8e1jadVKdAqlOEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UxVcRDj+XeM26azeIzkQ+u940YDkyAH6ER+sy461qy4=;
 b=W/5HAS4iVXFchgePP5H2xqJ+bYHE1pYgegYTt9cvoLe1O/cZ4s/BaHrAcxnWq9WCPY1IonocWklz87fzvqbDDVoMFUdFjhoy/pEl49Oo4W/+RwwMBdBL+vAt78wutPym6GFq37naPz1Iy8F3pR9q6hBNaSlACO9OZyppZg6x6oU=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA1PR10MB6592.namprd10.prod.outlook.com (2603:10b6:806:2be::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Thu, 18 Apr
 2024 07:10:20 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 07:10:20 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v2 10/11] btrfs: btrfs_drop_snapshot optimize return variable
Date: Thu, 18 Apr 2024 15:08:42 +0800
Message-ID: <da2bedd3ec4fd05cbffaea83aa2f783674d027ea.1713370757.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1713370756.git.anand.jain@oracle.com>
References: <cover.1713370756.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0019.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::31)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA1PR10MB6592:EE_
X-MS-Office365-Filtering-Correlation-Id: 05264a34-4aa5-479e-a2b6-08dc5f769b79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	SU1F/Q+qWwruYAUYqpl7gZC9R0m5OamII89d7FWC/Kf/MkrB3pVfb0jOzZQ/AbxJUDDQ67tHe1u08Ikq1xSLRJ7e80OkAKeUKWeJ0JNMBfE94Q+hcHw7RbkmWMlM7dpox7kGPoh+YAr2LsQgz+a/bKzMr00i+U42fl3UW9U+IgbkHgUovljhDqlkVf2Q9whaLOEJ9f4yAs8hyRIE+ya3deohXWQ+2aeINbd+p2Rfc5SgfPusMpBZK55dn5HiOApeY9K14ksdAHPUZXJqx56swcOlONsX78Bvh8BY7Ef8WoLgXNjbcKShinJgzVo7jlMgcSUdV0vPYeSorXAZ1LO6CJyXs/ocgy5Pt6MIoFjsl7keTE5q9GM56IHS+kuJVTUUFKuRKq7t7oLQodqH6Rkfb48HN54akFrBeI6qHANmlvvZ68DXHWBrgG1vw85r7Lv378D8h5+sTS/WxF1nO+V9ZODB/ElYIXK/yjaCyISum7qU7yTOvg15VeItZzASxUddc/jOdSJ3IQHHVjmphFY2/Y61PD81I/PZuqCg6yDtn+gaz9BWiMosOX4FApKDjrX6PkVo9ybIwjUhLlpT4kLi4ObxgUXOpZBqFOPLxkPgwnLWWx91bWxvHkR9+SBzSSYuW8l938GjKFOILf6KlUS7JA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?pOPLEim+Ph2VsARPf91KgRc7/NKB5H7i4uCXlfD17tpLFDRI09bqMpur5mHS?=
 =?us-ascii?Q?gC4jNqsmIjvM6yX2kw9qsGsVWsDKROx9aGJ9QppYN1c1pkDpV+QQmPfa7BVx?=
 =?us-ascii?Q?ozyIEAK9qOy9uAlsbqoBeLJgDVTFFqHaUu9zup2IKi/1WdK7DNRGUSYhZCCp?=
 =?us-ascii?Q?CFJCQ2Z6jL2FKA0kQWm2yOTlpVI6xMA8DsVsVJjWjGYx016n/5q5XrWzPqAW?=
 =?us-ascii?Q?1/qIqfB96/QSO6GibEwwgtoTLoAbMafCVQPUs2SmL9LFn0XmGBbT2O3b5Ymg?=
 =?us-ascii?Q?sQccmOyxrkD3a7A4xdwBGQyZ6GzaPBUjlkXqbJjYlapHqEince9hMCBlM8C3?=
 =?us-ascii?Q?tWMoPpKuLj6sVFcS/3DAWwt8qxMsqFMJoL15+JatQT29HkYgXPdx+ybB3X8a?=
 =?us-ascii?Q?6wXwLjOKhVZA6wBnOMh47mnID/pA+IyIxK3yOnQtdHOCvBbB5u1YfjRdSSFu?=
 =?us-ascii?Q?DG/OUGKDAqZMkwA06m22SM9WYQlrjWs77vNO0CboqoljLbh9uW+r9oVMh8fJ?=
 =?us-ascii?Q?KWFGdVJmCZN8ulqmyrwxY8I/pczoM5OHBc615ChM7NK1SJWt7VBW6iKxAOEO?=
 =?us-ascii?Q?leMWOLgD1qfLWD5C3ZQ049MLLAU30DSnTzI0CUq3mMnuM4WgNIVJVwqa2DPR?=
 =?us-ascii?Q?ktsIe5ywKp4dA7BaHnI47eoL/nZw5p0nSaor1axPWAi8NNaDCLyDfA5is53e?=
 =?us-ascii?Q?v6YvhYVM4cdeMBBJKYkr+/ihbTROZzAPBpbqU+vD6V2kyewvUDVDDltGCn0t?=
 =?us-ascii?Q?RQ8/xJIbHR0xRJoB7THEnuQjDFag1RCsQyDligWlnzPHNw8HumEWv7NP6Vmu?=
 =?us-ascii?Q?96ctpFBBAG8CaUDOQwWhWuafM+EvhdgYQDkYU0XdMdutMm+UaeuItW574Taq?=
 =?us-ascii?Q?7uSZ0I8Q6grAsNvFNQyVabOQn5ouWQQfGWFyOjWq3pZghj2jKBInhUgfMbrV?=
 =?us-ascii?Q?7+izDD14TL/ez6eVf98qHnFMiLsd8menRhCZllZGjg5pz0IDgz6aVCh8nANx?=
 =?us-ascii?Q?1BjQZ0ZmiiJaSPAJpmoGgiv2FT6m25dISpk13ays6QKYP0cQex2Rv2syZkRQ?=
 =?us-ascii?Q?BBXs3MqrZ6aDL850NsMI3EkXOPqS1F74rKI6ZatZlAhpRECNKO0MirNzV/tk?=
 =?us-ascii?Q?vAkRjwaFNvfRi3J1GxCbkRw3TIZoVHVIhPWq4yfWbC60S3QFAAaIaTa1wJtd?=
 =?us-ascii?Q?2NlwcClkIkZdBN/IJgo9GRbkab0y/YhHfFBNYlW6ir0iM/AJjz4tDUs0HDPT?=
 =?us-ascii?Q?5uISIjiabeTMSYOzi2ME8Zf+IZNuBHweW1/O+YtQrEXRI82C4ImnzZom9bIQ?=
 =?us-ascii?Q?TytzqcLlUjuNIC7sdroWUm2vEl8njvAMF6g+gVxuL+sam9dNkQGrd5Gee65P?=
 =?us-ascii?Q?1295eXPkTplKCfhvrl9OgCMOuVX4hNfcwoj5URXWj2T1EzpjrIGv1LauCPkc?=
 =?us-ascii?Q?/2n0Y6vyFMZ+QB/71uNoIK5sTTSKUPbir5Xbd1gZ+s0IHMS1dUL0qa7uIDck?=
 =?us-ascii?Q?DOscNAjqpIfMLlyETRuu8l7TR3C2ey0gAqVbF5Cg6v+6Ed7ddm99o5YSEFNI?=
 =?us-ascii?Q?KskSIOnBibfzeyRu1EHsgiQK6RszR+eGsAttCY1y?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	03Ca8Vl5x1RETHhVVAxcm+ubsWxzFhtkZIKU9Z2G2Em2usIpCgeLKi5oBp8qO7tgkb0EsyECWB6tWLbHknZe+lSGUjvbQmZcw91ywy6+nijBsPjLlwYqkM+yGh6k1eRFwGQUi9+6tnp5JegSwSAd/AG38rp3Fz3h6Jyy2yHkv9BuVwYdEvMnJ6MYkogetBKA2OxOrcGp/domaKd1ECBB6fbHwRSPBfp1h7FgAaPcn/6T0H3dISNwmRA3/e+Y1y7M/aZJhfcZaLCkQPKPswI28sKLyZQUG0urfrDQ2Eaa560Q4D6OGCjK2wytIzzdJ63vqOsCMiGrWiHNGqGGVID7Z+OuUuCvXAfcBVeCBE7hOazqAUHJLenrWn4kiUtWc0A9TdqQ+EH/FLqSW/eO+U3aVxGw2iTqKaTulLt8EYVi9QppmJHOkM6680xfDdcYfUnFoLR1j07e9Gabhm1460E9C2tGW0ZZo1/bCMrQ7zU6oKSO8l8kt/oCplmVdXsfWcY08Dmg8KE4oIbnabtus9If7Ilja2CjyW/mIemn8PDLH4YMV2YkkHViNRzdpspf0z5rmI9pZUIcqfeoHPr4JHcsysnXxNZccE/H32xLKjc4dyM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05264a34-4aa5-479e-a2b6-08dc5f769b79
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 07:10:20.1527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G0lIt4OqKoHTJFQbH+wdK6Xhk+TNvYbg4sJQ5CWU6P1ygOwts1k5u0UVxJtkZc1yaTSwQMgYRu4+wzJ3lQkRQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6592
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-18_05,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 mlxlogscore=981 suspectscore=0 bulkscore=0 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404180049
X-Proofpoint-ORIG-GUID: CiDl-mqBbSjJ5uh25AmqXaUsFG2JGwwe
X-Proofpoint-GUID: CiDl-mqBbSjJ5uh25AmqXaUsFG2JGwwe

Drop the variable 'err', reuse the variable 'ret' by reinitializing it to
zero where necessary.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: handle return error better, no need of original 'ret'. (Josef).

 fs/btrfs/extent-tree.c | 48 +++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 78dc94a97e35..17aa45b906bb 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5833,8 +5833,7 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
 	struct btrfs_root_item *root_item = &root->root_item;
 	struct walk_control *wc;
 	struct btrfs_key key;
-	int err = 0;
-	int ret;
+	int ret = 0;
 	int level;
 	bool root_dropped = false;
 	bool unfinished_drop = false;
@@ -5843,14 +5842,14 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
 
 	path = btrfs_alloc_path();
 	if (!path) {
-		err = -ENOMEM;
+		ret = -ENOMEM;
 		goto out;
 	}
 
 	wc = kzalloc(sizeof(*wc), GFP_NOFS);
 	if (!wc) {
 		btrfs_free_path(path);
-		err = -ENOMEM;
+		ret = -ENOMEM;
 		goto out;
 	}
 
@@ -5863,12 +5862,12 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
 	else
 		trans = btrfs_start_transaction(tree_root, 0);
 	if (IS_ERR(trans)) {
-		err = PTR_ERR(trans);
+		ret = PTR_ERR(trans);
 		goto out_free;
 	}
 
-	err = btrfs_run_delayed_items(trans);
-	if (err)
+	ret = btrfs_run_delayed_items(trans);
+	if (ret)
 		goto out_end_trans;
 
 	/*
@@ -5899,11 +5898,11 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
 		path->lowest_level = level;
 		ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
 		path->lowest_level = 0;
-		if (ret < 0) {
-			err = ret;
+		if (ret < 0)
 			goto out_end_trans;
-		}
+
 		WARN_ON(ret > 0);
+		ret = 0;
 
 		/*
 		 * unlock our path, this is safe because only this
@@ -5916,14 +5915,17 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
 			btrfs_tree_lock(path->nodes[level]);
 			path->locks[level] = BTRFS_WRITE_LOCK;
 
+			/*
+			 * btrfs_lookup_extent_info() returns 0 for success,
+			 * or < 0 for error.
+			 */
 			ret = btrfs_lookup_extent_info(trans, fs_info,
 						path->nodes[level]->start,
 						level, 1, &wc->refs[level],
 						&wc->flags[level], NULL);
-			if (ret < 0) {
-				err = ret;
+			if (ret < 0)
 				goto out_end_trans;
-			}
+
 			BUG_ON(wc->refs[level] == 0);
 
 			if (level == btrfs_root_drop_level(root_item))
@@ -5949,19 +5951,18 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
 		ret = walk_down_tree(trans, root, path, wc);
 		if (ret < 0) {
 			btrfs_abort_transaction(trans, ret);
-			err = ret;
 			break;
 		}
 
 		ret = walk_up_tree(trans, root, path, wc, BTRFS_MAX_LEVEL);
 		if (ret < 0) {
 			btrfs_abort_transaction(trans, ret);
-			err = ret;
 			break;
 		}
 
 		if (ret > 0) {
 			BUG_ON(wc->stage != DROP_REFERENCE);
+			ret = 0;
 			break;
 		}
 
@@ -5983,7 +5984,6 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
 						root_item);
 			if (ret) {
 				btrfs_abort_transaction(trans, ret);
-				err = ret;
 				goto out_end_trans;
 			}
 
@@ -5994,7 +5994,7 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
 			if (!for_reloc && btrfs_need_cleaner_sleep(fs_info)) {
 				btrfs_debug(fs_info,
 					    "drop snapshot early exit");
-				err = -EAGAIN;
+				ret = -EAGAIN;
 				goto out_free;
 			}
 
@@ -6008,19 +6008,18 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
 			else
 				trans = btrfs_start_transaction(tree_root, 0);
 			if (IS_ERR(trans)) {
-				err = PTR_ERR(trans);
+				ret = PTR_ERR(trans);
 				goto out_free;
 			}
 		}
 	}
 	btrfs_release_path(path);
-	if (err)
+	if (ret)
 		goto out_end_trans;
 
 	ret = btrfs_del_root(trans, &root->root_key);
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
-		err = ret;
 		goto out_end_trans;
 	}
 
@@ -6029,10 +6028,11 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
 				      NULL, NULL);
 		if (ret < 0) {
 			btrfs_abort_transaction(trans, ret);
-			err = ret;
 			goto out_end_trans;
 		} else if (ret > 0) {
-			/* if we fail to delete the orphan item this time
+			ret = 0;
+			/*
+			 * if we fail to delete the orphan item this time
 			 * around, it'll get picked up the next time.
 			 *
 			 * The most common failure here is just -ENOENT.
@@ -6067,7 +6067,7 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
 	 * We were an unfinished drop root, check to see if there are any
 	 * pending, and if not clear and wake up any waiters.
 	 */
-	if (!err && unfinished_drop)
+	if (!ret && unfinished_drop)
 		btrfs_maybe_wake_unfinished_drop(fs_info);
 
 	/*
@@ -6079,7 +6079,7 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
 	 */
 	if (!for_reloc && !root_dropped)
 		btrfs_add_dead_root(root);
-	return err;
+	return ret;
 }
 
 /*
-- 
2.41.0


