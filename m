Return-Path: <linux-btrfs+bounces-4402-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D8E8A93C1
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Apr 2024 09:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0094B281873
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Apr 2024 07:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA634EB36;
	Thu, 18 Apr 2024 07:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="H1QYU6ag";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="q404jtoA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5F92D057
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Apr 2024 07:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713424207; cv=fail; b=Rl0woL8E3D2AbfatAuK1aTZvXZw9Z5JoUsei7xLlF630Rvxd8gSmOzadKHzILn6HxlR5nIvmmegmmbDsfmA624bltLovGpBNcjbwq/QAyc2QleUIXrX8vsfCX7EZipzLABP/LoIyWkS2DLYlyqHuzMV/IooF6/tGzAZAigFG4uE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713424207; c=relaxed/simple;
	bh=Xn4lQm5DY9A43PJj7o5LGoy/UAOcr8+7KAdfnmxnKoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oZVb25K4EY+c8sON+AfYYGwU7kOP0ipCqRqceIbxD+uYUSDslUBm4JFBZHcz7q9tORKju1GvPPEYd9nI+9La4V+WFsl3JTUO84ljxa9H2zT7cTl+hsG1ijzxpGcO8equ2Z7cXpFWJhp9+DnWQsF7A97XVQfn1aacHpJbUMWs0Lw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=H1QYU6ag; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=q404jtoA; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43I3wvQt005098
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Apr 2024 07:10:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=eI3jad3OFaud4fAUekZwXgBOAejc2iE4x+qKp+ZYsX8=;
 b=H1QYU6agHDbJu8cY3OUjSZUFPGI8LV1ESX1Gfnlw/4XnhDumFh81yyCb9lFeD6kMc8Wx
 hbW2zaUK3gRNcfsg3/AA07NeXOlD7c9/Lx6k3yRAWOLJaAmDaff3gBQNZ7VT0kc3/IWc
 UYyc9/F/OzKOeaJ0hmxQBj+mqsXKQ38oafeDX9t0xxW4S5JbsCmWWKHdjiEBE5STKTl8
 bFiF/KG+aiaWvXythisba8XQ/QIuCd3iae873mpbg/Km3ipaHApDoFEd0NQ1YmkZjip5
 Dp3iVBM0KM2lhyNxQEsOMm9u7VRyZrMRHTH8JAKE8H881HlZDu8EfyfqOZo69frQnoVa +A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfgujst6b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Apr 2024 07:10:04 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43I646LV029200
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Apr 2024 07:10:03 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xfgg9y91e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Apr 2024 07:10:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b3uoVjtRlKuhq2ckxSqaSsQjeuO8+tGYvZNsHjWZCUX7NCXsaIX4ecMA9bfdRFIzqogEheWYMw20ywZimCVjVYT8I3f0TDg6EV+6aGg+74gFFK3oCvhmoFcI36VRqaB85egEBF9Z4uaUroq2sUhTHpHAJPvOZSn5+4kDlNFx1QoQ53OYPqtToH4BGIwSrH7D7NBBgUiGUNm9G+yFS2MO76PHuWHUQ1Ux1cCfGR8NzeW5/01DszqvGKcCdFFkezGHM17u88ZFYL8/dxp0bojba4ShhlJ4O3OLB94GBmPQ9nFzVQ90uMVYBN3jlS9H7u46k/2IK22KhNqXGZQr3nkfcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eI3jad3OFaud4fAUekZwXgBOAejc2iE4x+qKp+ZYsX8=;
 b=Lu35bhW5CpWb9mITo0ZZTKhuYTXdoSbGSUlyhGMMR9BfWc9s6gLex13dFOlY/+MfLni5jLqEuHyFKZQLHnQx4dCEPkYiVAnx2gFkwFa5J+9RJQytnDhtDbpKNO+AwiuMUfVgDWvsyq9wVRBsa9VSFL0Bbawny/3u7fIuQVq68UMyDS4jgdNTnkJCrAG+UEW8pfPwnGgwQ+8d5QbBM8d5BoC8oSeBHAZVRl0ZyBH6q43ucW/GXT9xkdocX73MbS5rcPeVTn0Sv3/SR8Mfh1+RF5TyWZusctMxmWc+qklhU+GWN7DwyXhxWFOsPcyh634Z/y3p7rQxvhDlbG7PjdwFUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eI3jad3OFaud4fAUekZwXgBOAejc2iE4x+qKp+ZYsX8=;
 b=q404jtoA7+Wj6tYGppid93lXj052zVw+LKS+OKl6JbFQ3Dkp5TryW10TU+Dg3OvOmQ+Mene9qQD8MXYdpp604/yjdtBpW7rM/fC1QhFD/mvcu9aRvEG6qSjSOdf9TLzQY+XHJWRgU7/cmdH94RIEf4SDGrlIOIry7+pgSPWyqkU=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA1PR10MB6592.namprd10.prod.outlook.com (2603:10b6:806:2be::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Thu, 18 Apr
 2024 07:10:01 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 07:10:01 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v2 06/11] btrfs: btrfs_recover_relocation rename ret to ret2 and err to ret
Date: Thu, 18 Apr 2024 15:08:38 +0800
Message-ID: <a98d6d4d3ac16aaf0e464dfeb9551b4c141a13f0.1713370757.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1713370756.git.anand.jain@oracle.com>
References: <cover.1713370756.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0045.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::16) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA1PR10MB6592:EE_
X-MS-Office365-Filtering-Correlation-Id: a7d56479-417d-4519-95f7-08dc5f769033
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Ibh65gbbNsU8PNejsdlJ24VsUpFKv/mCnLKojIswdRNTKvF6cRRJ2HiQd2SOlNKnceMBIk1oYGEiA5qK/Mx4XDrKqH5nd6ZZDjMLJJIkU7kbblB6bmHU3cus9ko19iY2gQNPUg6+4/Ce9wcDZ1zj4Lfek2sTEfOX3/HkKV42JO3lWwFFOapbT89LxGDNCMwLYCkN+mq/TW2QXXUnp9uu7TeHjd8fmzRGefFJsyS+qoPgWJKwpS+6ezSjVhEsNdjNmWSbxdN4cCeh6jWze5RcRS2lC4dEsd2TIIG6l2Nf1NHlf+T1ohqlOuPOeZPa5NmsASD7mKlCzlnVPJ0LPjABJvNcUB48S/or1PiM/Hmxhd8SVzJvSq06OBFSWn66JKj+DKS2u0y1smFfqShYbpQNcCorbjOJKhDI+5W0bq28FCt/gYos+Et5pUp81w1/FZ7u27Gc+DvLgOmOBd7gqQ52m2ABtRnLiIgVkIem6Gj2ksPznH0hXmQ9z1MdUOFXgY6nO+rVnuzQMJJer9iiE4K304TeV8fmFx9WJq1yuw6pCIJCCPIrQKDLlq8rC+NwlmlfbMf3ZT5u0Tcqb/1EAGfWVt0uPdz4Yn8UAk6mi4ak2tyd7Ml5x+bQ0CYXilKhrYQVg89jAdiaREU1urAshZWyJi5IIjqaaixPle3/E/YPHV4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?qHvHKl2eyl7QkGe8EP5X3NEdhB5Mn4FjMm3oEwIX1FQA0f+RuQMB78TP/Wt5?=
 =?us-ascii?Q?Lybu1FknhOinLI34Rn4HEMqEqkF3XDkMztLgJyOWc2998z0ng+ykE9hasP2P?=
 =?us-ascii?Q?62CUe3pS74Nfo2ie0YB/PlwzoUjt73e18rjouh9XNUV+oEMgPCjbNsbkDpWw?=
 =?us-ascii?Q?3XQUqY6LS6a04L2MpMWkXoFDnjW0sqNXJyUE/Ejo2ia4PnFLjmUBqBS0dS/G?=
 =?us-ascii?Q?6IB4vWkkGvIjG/6/B8Y9np/gWYcImIZOLmKv+pqtOdpzHJ4uNV3LOdna+LtX?=
 =?us-ascii?Q?WiPwjTMWVBZ0HanOABuy0iJFl1gI7ZSfy31ZR7rIFaWibQw6AD/r6AXIYpAL?=
 =?us-ascii?Q?ZQ1K9VTIzDFP/uvqixzhdjFvgUG/L/wJXK5qKTkKZCPjLPrHZXvsOV9ozavo?=
 =?us-ascii?Q?iz1YwftDZ0fnukxq/qq3fQTgpV/KWJZsm2wIcNqzbX2AJPIzW194xCXRl12D?=
 =?us-ascii?Q?nZtRekQF6dt8wOO7B429AbDzVUeKhwLin3eVC++gAy1veZXhqO7jrSIiVne7?=
 =?us-ascii?Q?lmlfpxQ0vBDZdAgLmg4S5b8SiESi7Vg+26lYbHEYh27M32H1Arxt8Agu8mJ9?=
 =?us-ascii?Q?NwXPPcPUaWL0AaBFtPZZ2QpVpc3xNWIsf7/GvYdqpSpFAXvd/AwLULSayH6I?=
 =?us-ascii?Q?f2VpMKjlOlP5DUYuk/pWgMePf9otUsh1PPQsYaPWwN8O13nbQBu7Zc8aff86?=
 =?us-ascii?Q?WR0RAiZJsVzcPkUTgY9DfYG/5W4edN/YjSkoqnOronUclv00RCMbW61hVFoM?=
 =?us-ascii?Q?iVipwWeuGaFQX6Lt6CUSzPpGJIgUD7VMTe4MhS0CFL124FQ3nIBVRl7/zfcW?=
 =?us-ascii?Q?mwnJ+VlRb/yY7bKstXgrrIkV/JLestqKARbM8w7BBOBa9Tr6usKITJTpIyMI?=
 =?us-ascii?Q?9vKPGqXm/joIRM+2UG3StTuR9PeoGjT4LWN6UzhDe8Yp4wWyTwLjmSybSGQo?=
 =?us-ascii?Q?/6IeSKpM3e+msRJvNWjsGAxvkGDMuRXn9pMyN2/Aj6ZZLwKkpB6QD3iLsp0y?=
 =?us-ascii?Q?EDC0HB2adPi4mDoDkDqHFpmFUOd1XbNXLs4RaKSrcUxDULzHAEuoMYApbM4D?=
 =?us-ascii?Q?hFrIJjWFThRC9LGA0vuAbvuXW8EqFyEbWP5pHSURWA337kV6ddb9GbJBhND9?=
 =?us-ascii?Q?OLEhQTb60tr6V1+gl4efN0BFUtZ4ZDW8Rc5negTVD1Qh4NVzqEsHmy0n0NC5?=
 =?us-ascii?Q?mvxC7Yd24CLn1j5L10kIYoBjdDdKpPQahG+3FXry+UkFUCORIZkRNO9j76lR?=
 =?us-ascii?Q?Cq5rxxfh+Vyj4Pzwlm1U3BLdWPFhuZRy8NopZ75To+os/5PndvSPSwaloB89?=
 =?us-ascii?Q?EgXanqaKCEb7PFiPKXY56C/TLRFP/AbzkNLfZN9yRZwTdRjEBUpEbXzsUKyw?=
 =?us-ascii?Q?q28hFBfFp/3x6u6JSqF0Vnlp3cpD9r90lElHC/g3Jufg7Fl+2MaBdN/DKl9i?=
 =?us-ascii?Q?TBsRJfjSGoxx8Sky74VJ4aVebAzfCDwkoD46VKDJbi/wo/JCAWGugQffka+M?=
 =?us-ascii?Q?LwOelB27RBBObu+3oJ4ChvHNxm1zcjuMaqh3jdFdym8CY5FDgfmvR2lwqMwb?=
 =?us-ascii?Q?KzDS1qfAuxumZMFJRdL1eCxJ06/15Km7LhyfgXk7?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	F3mBGT1AqZDHqKYBWwfGzQvWMVyCCU+sWzmSFioaCqrfMlu6kKLR1o9z8UQlK3Nxm/+41bgtxd3ulT7d8VCO4Th1SU9OR3809FTGlE19TgxUM6TfIXuyWWyhX5T/Ii0Ubhy/mJ4S/vBzbUjgDjUf8+BUCESshCzzVjv5cqhQ5Z83uJyHYTRl+Z+nizRF086csUlNdzS7pclKmkLYYU2D8gEIFEJqIVlw/NN+NjU6aSAEdKMBu6O7TA42U0P4muVEYxAI/A2SNYYCGaMsLg0YDtgMUApXqEk2SgB9sdQD9Jgz4lvINVWM3hP7wBdNiTuCJgamC+8tQ7zYJzO3Z2V0p80Y7gMlZIIjFwZ4Moe5YJ5AxHgt7z20EesQ/VAJspdYl5FX6UQBwZjgpoVSX1kOiyA1GaNTzZ1HkDEljosBzji1mnTrPXNK9mtA4UtdTtSrQk7uXeUudMoN3zVMJntnQ8ldwCc2pLIat6z1zt7FfNu3vzUOSoiV+SOlDx+5UuVxOXp/EV0Mg/KUiBjA+ww9xSfZIU7mNnqL49LZQL8K+xdk4Wa2cxiru/7W+bTYxACT6LkNiO+hIXITwB7XO4JY/+/WMw4zrRzn9neV08j/6IY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7d56479-417d-4519-95f7-08dc5f769033
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 07:10:01.2512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2wfhqburPt9zYQg7FY9WBqOA3vWqAm9XCsKckDdGKntJQTvXoMf3MB/elCC6X4HFh0/MiChqFHZH6aYOp9HDLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6592
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-18_05,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404180049
X-Proofpoint-ORIG-GUID: TZ3Es1mgt6wq2Py9L3pVoXXNCd4tSbQT
X-Proofpoint-GUID: TZ3Es1mgt6wq2Py9L3pVoXXNCd4tSbQT

Fix the code style for the return variable. First, rename ret to ret2,
compile it, and then rename err to ret. This method of changing helped
confirm that there are no instances of the old ret not renamed to ret2.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: no change from v1

 fs/btrfs/relocation.c | 64 +++++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index bd573a0ec270..0b802d0c5a65 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4222,8 +4222,8 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
 	struct extent_buffer *leaf;
 	struct reloc_control *rc = NULL;
 	struct btrfs_trans_handle *trans;
-	int ret;
-	int err = 0;
+	int ret2;
+	int ret = 0;
 
 	path = btrfs_alloc_path();
 	if (!path)
@@ -4235,13 +4235,13 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
 	key.offset = (u64)-1;
 
 	while (1) {
-		ret = btrfs_search_slot(NULL, fs_info->tree_root, &key,
+		ret2 = btrfs_search_slot(NULL, fs_info->tree_root, &key,
 					path, 0, 0);
-		if (ret < 0) {
-			err = ret;
+		if (ret2 < 0) {
+			ret = ret2;
 			goto out;
 		}
-		if (ret > 0) {
+		if (ret2 > 0) {
 			if (path->slots[0] == 0)
 				break;
 			path->slots[0]--;
@@ -4256,7 +4256,7 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
 
 		reloc_root = btrfs_read_tree_root(fs_info->tree_root, &key);
 		if (IS_ERR(reloc_root)) {
-			err = PTR_ERR(reloc_root);
+			ret = PTR_ERR(reloc_root);
 			goto out;
 		}
 
@@ -4267,14 +4267,14 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
 			fs_root = btrfs_get_fs_root(fs_info,
 					reloc_root->root_key.offset, false);
 			if (IS_ERR(fs_root)) {
-				ret = PTR_ERR(fs_root);
-				if (ret != -ENOENT) {
-					err = ret;
+				ret2 = PTR_ERR(fs_root);
+				if (ret2 != -ENOENT) {
+					ret = ret2;
 					goto out;
 				}
-				ret = mark_garbage_root(reloc_root);
-				if (ret < 0) {
-					err = ret;
+				ret2 = mark_garbage_root(reloc_root);
+				if (ret2 < 0) {
+					ret = ret2;
 					goto out;
 				}
 			} else {
@@ -4294,13 +4294,13 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
 
 	rc = alloc_reloc_control(fs_info);
 	if (!rc) {
-		err = -ENOMEM;
+		ret = -ENOMEM;
 		goto out;
 	}
 
-	ret = reloc_chunk_start(fs_info);
-	if (ret < 0) {
-		err = ret;
+	ret2 = reloc_chunk_start(fs_info);
+	if (ret2 < 0) {
+		ret = ret2;
 		goto out_end;
 	}
 
@@ -4310,7 +4310,7 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
 
 	trans = btrfs_join_transaction(rc->extent_root);
 	if (IS_ERR(trans)) {
-		err = PTR_ERR(trans);
+		ret = PTR_ERR(trans);
 		goto out_unset;
 	}
 
@@ -4330,15 +4330,15 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
 		fs_root = btrfs_get_fs_root(fs_info, reloc_root->root_key.offset,
 					    false);
 		if (IS_ERR(fs_root)) {
-			err = PTR_ERR(fs_root);
+			ret = PTR_ERR(fs_root);
 			list_add_tail(&reloc_root->root_list, &reloc_roots);
 			btrfs_end_transaction(trans);
 			goto out_unset;
 		}
 
-		err = __add_reloc_root(reloc_root);
-		ASSERT(err != -EEXIST);
-		if (err) {
+		ret = __add_reloc_root(reloc_root);
+		ASSERT(ret != -EEXIST);
+		if (ret) {
 			list_add_tail(&reloc_root->root_list, &reloc_roots);
 			btrfs_put_root(fs_root);
 			btrfs_end_transaction(trans);
@@ -4348,8 +4348,8 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
 		btrfs_put_root(fs_root);
 	}
 
-	err = btrfs_commit_transaction(trans);
-	if (err)
+	ret = btrfs_commit_transaction(trans);
+	if (ret)
 		goto out_unset;
 
 	merge_reloc_roots(rc);
@@ -4358,14 +4358,14 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
 
 	trans = btrfs_join_transaction(rc->extent_root);
 	if (IS_ERR(trans)) {
-		err = PTR_ERR(trans);
+		ret = PTR_ERR(trans);
 		goto out_clean;
 	}
-	err = btrfs_commit_transaction(trans);
+	ret = btrfs_commit_transaction(trans);
 out_clean:
-	ret = clean_dirty_subvols(rc);
-	if (ret < 0 && !err)
-		err = ret;
+	ret2 = clean_dirty_subvols(rc);
+	if (ret2 < 0 && !ret)
+		ret = ret2;
 out_unset:
 	unset_reloc_control(rc);
 out_end:
@@ -4376,14 +4376,14 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
 
 	btrfs_free_path(path);
 
-	if (err == 0) {
+	if (ret == 0) {
 		/* cleanup orphan inode in data relocation tree */
 		fs_root = btrfs_grab_root(fs_info->data_reloc_root);
 		ASSERT(fs_root);
-		err = btrfs_orphan_cleanup(fs_root);
+		ret = btrfs_orphan_cleanup(fs_root);
 		btrfs_put_root(fs_root);
 	}
-	return err;
+	return ret;
 }
 
 /*
-- 
2.41.0


