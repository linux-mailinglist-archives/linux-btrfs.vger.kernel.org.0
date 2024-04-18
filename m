Return-Path: <linux-btrfs+bounces-4401-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8610B8A93C0
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Apr 2024 09:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 154CC1F2323B
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Apr 2024 07:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D203D984;
	Thu, 18 Apr 2024 07:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NCJdhUJY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="x4CNLtKj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A253A8EF
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Apr 2024 07:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713424202; cv=fail; b=oB/6qTcqB8ez92Qk9vC74h9T8oA94DFRc5rCOo3sgU4oImlnoZXEdh9XyjOUCAb5nOqsONYyymkwPFgmzQOJvKxicoNgcquV8WdG4rvJMKz2W1w8a9JUzxaLgLnNJo5qsoPv0uF3KTGz5tl6Eh2xd2btHOrj+JfMvVukR2cHxs8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713424202; c=relaxed/simple;
	bh=Qa0mtsFXCUQx4w2s+mmjQvw4j11fdEa+8J1vYD2NUgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gU8l+KNxdauW1+xkw7K+FM21bUWU3MgPSRriPT4WYnMQkVt3zVxXy9hQ95yKzVAiKk5sql0BDir89B99w22pXGPydFYmyauxoAb47uq2j+xbYx99qhU1Q9xSkFguCT/hVyHkwwHc4VoIda3GbuWUjCnqf1PgRHBY6l0pTAYFMoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NCJdhUJY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=x4CNLtKj; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43I3xXtU005911
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Apr 2024 07:09:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=qPy6SaV1UkU1D6B69YCD4nyxC/BjjKwSYf49BWdnttI=;
 b=NCJdhUJY2/5B1fFscQHop0wh9p+JE5wEr6clhnN74qV+nzPL2qMAdmw0lstyb1uX7p5D
 zNwHiuhGH3GAqHgQkCB783tsouRxgMiSFtYPS1ruZwb12J4BuRPc08d9H/iDpyDhZkOy
 oFl8NVShxyt94MMruwE0FXc1VAAKkI33YB+cm4ehJQX4m+Axu7pZcTlTe9JXiOZ3PMER
 ShW3DOP4K+UIlFzXAGXvDIH+4UsqJ00nXwRm0s9rOSNsTbLwBiJtdc761eustnZyPW+C
 oaLtu8TQOXisIiE9wo8MHf2GrsbSlC5XWCyV1uPS9WYT8/5tOvcgUwgyAane2Vuj5hnH 6g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfgujst61-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Apr 2024 07:09:59 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43I68avF029348
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Apr 2024 07:09:58 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xfgg9y8xt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Apr 2024 07:09:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=homPD0no3iO/Cv8FfKqNUP4+dpDyxmjCNgXBbr28sW8EnMSA0VriSbxdvFpMR6C+RSIURokcWjqfYTKM29Vmri/rBYP+0VOuao6/F2qQWs/Kf0R65Y/Vz8C0IUrsYuJnIVb+TOn35MfmI7xCMDClvmbE9yw216WwxnbvUHrqU0MBo18MoSaEmKLmZY5X4cLk5YF16FfqZPLxsJKa8qRScaLcubE6lEbOko5kXIgWNBPdvtWd2GLREK3vZc/lKoltZUx0rBlVbeCfqEFgIyfXWyyXwzmMzmIBuuA0oTn81XOeFWP46Ulif24aFTZ0tMmbYatM1Vm3tMIQaJGPCwfKYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qPy6SaV1UkU1D6B69YCD4nyxC/BjjKwSYf49BWdnttI=;
 b=ZReqCNbCYsVfsC16y8Jg3vvBXaqsosLUBj+uYozFKhJDuUBjhh3BaM3wAh6yxdkVO/SMUXsZswILQIk+2YpCuC0Lc537PnWqeEfn6mDhB/apsuCESLoqUATILlREQIt6EazW0j29m1taBQ9WekSXxX3ot+medMNnPv1LlLLfnVroj0kDbuYC+nSZgmu110xbDVjyyBgEQos2NO9BoasASA1lX9eSwYhtD7JGOO96IhhmSczB2j/1qq7pS3m/JRxAcVR4ifgTvkfPj+qkGtbHHnwu7jZrabWuGIt72fy0tbJf4weYzjKJXudktwU46w7xwkXoW+zO0DdxdCMwKFwPgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qPy6SaV1UkU1D6B69YCD4nyxC/BjjKwSYf49BWdnttI=;
 b=x4CNLtKjppmVdXwfIrWi8UVKCjUARxwv+PIDbds2e+RIjNOUqB1CblK3jfWuTwk6JZfuS4NNR/sZJsqFPVPwljH/V7gh2I8vwVcv40DVqx4wHU1sBoyv5Zb1znlQ91SmmIeB8thktvec1Zqpoj98MxMyoYU9w0ErOrSQ4aVUpwA=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA1PR10MB6592.namprd10.prod.outlook.com (2603:10b6:806:2be::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Thu, 18 Apr
 2024 07:09:56 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 07:09:56 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v2 05/11] btrfs: relocate_tree_blocks reuse ret instead of err
Date: Thu, 18 Apr 2024 15:08:37 +0800
Message-ID: <3902d080e45e3feebf29cbbf7b50d66b47ad9de2.1713370757.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1713370756.git.anand.jain@oracle.com>
References: <cover.1713370756.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::9) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA1PR10MB6592:EE_
X-MS-Office365-Filtering-Correlation-Id: c9567c42-f622-4600-7722-08dc5f768d36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	l4EwjfbfnTP5KZ2D7PrSvwcPFoRpJK9gjoSOw08iJwtqd62Ck4a9bRxkf844rRdPVDrdneoer1SqNnDG4BNqvIVB9uynYPtIY+01eDf0M/NwNyt83HpOKUSQcTr/U1gVbu2gyxTg2+so6tt6gRoQ97LekTrRYF5QrxSRmc/50cLWPPcDUe0wr2vUgtPFNXtve0OTGgHpPLFn6QokGKsqLaiA78FRyOK7IMrx0Tb+KNFecPV/Pcfdtwb2FV+wYjKQFV67FWy3p+q3sA0rqt2NK7efbiPxRl6bD4h8ZHtV9Is7zbLxySwCvu+dxBSe+EttRtDzn4RTnMd4ioYJQRWf8qLKCAe2ZxDaZ0q+bIpaQ/W4axWz/tFK8gIa/YGDOLEKE7eiN3qRz8fr6ZYHgoIDgxT/eteUAQQSgukqFlTsR5I3RY7Asyk0GLGX2/LqDRCoaej5sX/ZVfuddPZyPv9hfhKEQc5yYyBfPI0YYiRZ4WAvURgjBnVptO5DAYuA2yodzde7gThRoXhoIn7m7pOZr0alNJyH7B8PyV2PieCK5gYtJsn73CZ12gsaB4s3KCRrn1Vb0SXKe6uttR+MftGYL/rPgFpPmwqnvDxlymkmtlpTvUvUB6wi7bmtNjs36V9ozJAnvE6UyxdnULkjzofQA+7DtZ/TI57OYe1j274G0WA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?JW2zERk68mUztHRJbkCV6ftVtRFyekl+5jr8JnSpOg2loQi3zuhAdTH4Yhx7?=
 =?us-ascii?Q?vZa42g6VWRDyNUrQLpF21gILdVQod2Tl9Y5cS+lcBoahneV5G1BIo9fk2Atr?=
 =?us-ascii?Q?czBzM89PtY9/T1zv2jGHfKabOucORu1KHENiKBAgpfSgDe/jfb7lNL19Mf0Q?=
 =?us-ascii?Q?CXZzQE4WQJq42HDCQeVjmTcOlW2WZCNfS69paqLbPPU3YQpNrik747mdNN+3?=
 =?us-ascii?Q?ZQ9akAYDYsCuarykQ4+lNz3B1OiwXkKowkm/jWdn5V7Qm+LWpysbR5F5faCU?=
 =?us-ascii?Q?Mse9j8UkA+PMkhway+YDugTK7SXIDwvIHLkVpKu11tTWWr/WJiY5OzfZkhQN?=
 =?us-ascii?Q?f5qqMK9ZJqJdPZ6aMzpXdwORDOHuZR7JM8k3UDWE6Jdi5P0J/L+AEJ1CXkfM?=
 =?us-ascii?Q?fEa5lc5ENGAcLAEkuKKslJX6wXhCp/pUyOSzS4Y+qNsScZ5V9yJkJ1Pi+uy7?=
 =?us-ascii?Q?b3PPOp/Pca8CUDceAOSES9VnGonXA9hJmmO/kJsNyifjoI9YzOwIgFaOpPyC?=
 =?us-ascii?Q?s+6q0hFuFgTUkT/ib3VtSp0ovL8wiEAaJHbLXT6bwVCOw4Aby19DnctDAIl5?=
 =?us-ascii?Q?XD9Sa1lBUiMWFzD/XVS9tNfdo99NCn6hFwuTabpkij/9lzKZofpLjQ1r849+?=
 =?us-ascii?Q?igl9p3sIcGR3ym7afYKlvnX8mPWiR2ynQU6GzqYVeIpzEqmMSCYKem7KJbB4?=
 =?us-ascii?Q?JPm5RGk125WR/CklHsJkqQ8xkbHb4AeXDpcJhxB1AhZyYIYY9YIgCzZ9jjai?=
 =?us-ascii?Q?gtv3iBlqkWxORyYux2kmiesNLEqLwHFa/nQQApgUaF56/Lp0EAHdoVQJvLsv?=
 =?us-ascii?Q?KEGCtIIt/GVBwg71+FjYavThByukGS8uqxgm6Hx8qHXxTo9cezKHXP0WExra?=
 =?us-ascii?Q?L5ECwhEC7ORGAcHk/Kh7Wg/d4PG3Xbl/76gSOShx3S6qPRUkMsesitndmoF+?=
 =?us-ascii?Q?YVfLDlGaorhlSvCM+nmAaetwv9cHTrc0sPtBjJt4QnD/E5a+x5mG5kFXcT2y?=
 =?us-ascii?Q?A7QZvn3tainTW8LTbcc3PZw+hm6t5WXU+mmZAIEc5vTtzgqOMw4dAO6fL2fE?=
 =?us-ascii?Q?CXlOv56xvttXiMYlWr4Sgnm0brzliH0mHVCNCpE0BWHlxVXHVri1DVe9siC0?=
 =?us-ascii?Q?kDrmrhBaZR4+wBG/E5yXoRiXadQr1JjeeAlcC5cpe1MkEOm7BkmNQru1XY2f?=
 =?us-ascii?Q?lXYoLRhcGyRlFclw7uA8rktK5jWaKi0npASB5jn11SRe695DivJPzJoyml/a?=
 =?us-ascii?Q?XfNRox2o3DMwQnhey9SG8sWySkb9VMp0hM7hyzKfFqJFnUyehL1JCojYoTUv?=
 =?us-ascii?Q?QzcctX7Dh10KTtKLEsL796Y7mk+hzIwWmiFYS3bF6xWHWq9m9keHkqWntcui?=
 =?us-ascii?Q?4UD8ZZT8U3O3Dkn4rlH592BIs4kKtd69SZEu0LjL70zhkhCd1cMnNqH3abbt?=
 =?us-ascii?Q?RVt+4OC8ZoM0nkRrjx5ttMU0a8hHXMuN6/+KxwUeKljd7EougWIxO1yJVsoj?=
 =?us-ascii?Q?P8Pgiw8gZdxYB1iNAfVVtmo+uogkQuq11PItX8Fs3JpWpoRjz92cW+7aER1k?=
 =?us-ascii?Q?JreroLkmyMkbbtX/3aEfgqu6gEZlBgiTii2yq39e?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	7CgbahSt9Z1eslSGt0pM/ybJHrZ6IIOdL3PZ61OSIhSShxO1GfaR0It/uVxLB9nb4tpUzm4VWX+BDeoNm3G08Cx0I0A3cBZEuP+cjmXVhOIxgg7hNQwbh5n01SqEP5z50rXfF8iswbKRph0Id4TgQ7Bduk2DbCUvjEqpkjPp/9pernkfAtfUaUhkIPJEFR07Uyz4UYtypZl1A0qmKS4hZj9ULnDNf6ZzN45qrWbp34rLMZnwIrIfQtaaVkKqfjkbwiwNVvYUym3Ajeq2nvxGnIMj7fqTBPaxihYVkpcsMIs1OuRfI/9EY6j3+ahu8XfqlWgGGV9LZ3KvLEVD/Xpa/lKke1u6Qt/xc+XVI69eG0S2xYo6KYDFsr5E9hj69L/HX4JjooGhNrII1sJVpK7WrO5c/5AvHbevVFIDnuFduZzcT8c3PMtowSETuRwLjinbN5lFcjj/krRs97/nFGtpu0wKJrtgBdeCLBNBnUdluZwhYKDdmXuzeYJeJUE5ahGGslLpY7T/5HP7cQW4Qv/r6SWGD/f94YiFVEKr2hP8syaeUm66TuhlY/j065RGpDzOEERs6E+5OVM6gwts/b/Rn0kNZSab/aI9DWypgyy2JgU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9567c42-f622-4600-7722-08dc5f768d36
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 07:09:56.2269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JqB5mGoQ2rnv2Uapo6aHr4s4SFRQtaNDvsrVLIKjFnn2km2QnonwSlwfxCVCm5OxxQ+6R0EfXaOsXQgyWA9gGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6592
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-18_05,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404180049
X-Proofpoint-ORIG-GUID: tTS94KD_3SWhDwhi5KAMdfkJBkpl3wC_
X-Proofpoint-GUID: tTS94KD_3SWhDwhi5KAMdfkJBkpl3wC_

Coding style fixes the function relocate_tree_blocks().
After the fix, ret is the return value variable.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: drop 'ret2' (Josef)

 fs/btrfs/relocation.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index aef7d286252b..bd573a0ec270 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2742,12 +2742,11 @@ int relocate_tree_blocks(struct btrfs_trans_handle *trans,
 	struct btrfs_path *path;
 	struct tree_block *block;
 	struct tree_block *next;
-	int ret;
-	int err = 0;
+	int ret = 0;
 
 	path = btrfs_alloc_path();
 	if (!path) {
-		err = -ENOMEM;
+		ret = -ENOMEM;
 		goto out_free_blocks;
 	}
 
@@ -2762,8 +2761,8 @@ int relocate_tree_blocks(struct btrfs_trans_handle *trans,
 	/* Get first keys */
 	rbtree_postorder_for_each_entry_safe(block, next, blocks, rb_node) {
 		if (!block->key_ready) {
-			err = get_tree_block_key(fs_info, block);
-			if (err)
+			ret = get_tree_block_key(fs_info, block);
+			if (ret)
 				goto out_free_path;
 		}
 	}
@@ -2773,25 +2772,23 @@ int relocate_tree_blocks(struct btrfs_trans_handle *trans,
 		node = build_backref_tree(trans, rc, &block->key,
 					  block->level, block->bytenr);
 		if (IS_ERR(node)) {
-			err = PTR_ERR(node);
+			ret = PTR_ERR(node);
 			goto out;
 		}
 
 		ret = relocate_tree_block(trans, rc, node, &block->key,
 					  path);
-		if (ret < 0) {
-			err = ret;
+		if (ret < 0)
 			break;
-		}
 	}
 out:
-	err = finish_pending_nodes(trans, rc, path, err);
+	ret = finish_pending_nodes(trans, rc, path, ret);
 
 out_free_path:
 	btrfs_free_path(path);
 out_free_blocks:
 	free_block_list(blocks);
-	return err;
+	return ret;
 }
 
 static noinline_for_stack int prealloc_file_extent_cluster(
-- 
2.41.0


