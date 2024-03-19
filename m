Return-Path: <linux-btrfs+bounces-3395-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2B887FFFD
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 15:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05241282349
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 14:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F09C651AB;
	Tue, 19 Mar 2024 14:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nbD6coYk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="skop3U43"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA3B56776
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710860181; cv=fail; b=mswmi51KtDCHCfJbBi+8SH/mHsVYqUcHtqzgOE0LQkdiu9RwGbAYi0GO5wi4D2V+sLEDSC/KkKUQOlrS5AhhUFZ5a4tAP5NAhBin9YVz4urbNNv3LT2MD4SKxBp/+I1Wl/aJE/i9RVSfXsDXrX5YNlFlSr04r8UTOUTZAB5KoMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710860181; c=relaxed/simple;
	bh=2LOlGaNnlvpm47dKarevvt2+Lgh8Z2Y+Vvs4Rh/sNxw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FT7TemJ6gzYxcS5PTjjHzyARQqVmEDFI7upVbJYqOTiJkT1fjJZ0vBpj55a/UU5lZG58/SXPlTVPb/+e0lOQ8VeJHr8kD7sIDDg02AwvPYVdUEjY4DJC+uL5vh5xrUJKJ/Z4GnB+fKkb8oOYpwX3vwIobnaTfSdF5u71XCfWc9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nbD6coYk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=skop3U43; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42JAHdXs010799
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:56:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=QyPYT/+nO9Khpw8+iR/GFPYkHX6reBcCUn72gZfCnPc=;
 b=nbD6coYklTZNwzC2ByEfxIedXYU4k7Vc+Te+fqSvHM/9dTazMxlsgFKWjhdB5BM4iqMQ
 wVtfm71r8azoCA6+IxP8snrmHdAbJrZOYpUTJ6iTjdR1jmk6n/rOJF46DOvCtCcuq8Yk
 L+lFHiLX2+CIZjSBJtmgkuVb36AF5y+ivLHAI1704DzYWZI79tNmC5skTPEXjVTsAkIS
 k8NBZSQdi1Q/+5Wd5Bru0bIPRrXlQGDvLuseAJdqaG9TIGd1cZ2QJnxSob+SktmNa6QZ
 fqolTgH53AU50ngiWEehqiZDT26Oja04KqjYeC9YDQOT+FawwjWBF5bGVgrzeEkkerqE Ww== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww2115r9e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:56:18 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42JDp26e015776
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:56:18 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ww1v6v56f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:56:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QyFjeifdSh+6ZUP1NDwWKo/acJ/EK4n3lsIyakBHijGA/1JFTF22i8pnKyY4K/GWJMBhBT/iwksNxmCiNJwEmsm+dWO5K4VFeP1dQ6ti2oF1nBwghxPocbcA40+7XPIGB73a2k3tO425YLPH4hTJMikLYWMRogpjgcQF5u9FSX1HieNj7aLMUjswfd7HKAZYffP+g0UoQcTDdwaYYntKGQiSXNnOXIhdoFk+SCV4FsmPs+Jtl4jeIz9+yYCzzFSoYKNybfo04zqttpFvRrV01tyxETe/+SZ8Zxs1n72JS7kHOBv0NcFOhzb8dkOvax1aHH0eXwmKATXf2L2I83Lz8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QyPYT/+nO9Khpw8+iR/GFPYkHX6reBcCUn72gZfCnPc=;
 b=m7hz6cXTZdM2WBVeLzgYLfb0PGikxMBiCkLQx5SQMBdRspDTCjobw2eEcBzPbELIVOD38HRfrrth1a1d99dWQkfNXGMUmAQ8PhhGSSa1UQIvTpjJh3q9pOJfS+giOyJnQrYp887bQrynSTh+NP1n833Xcp02NnHbzKh1Li/PrPjmJeGsqt8j35TgHbBMG+SprqwySq1+wTm62d6qY8xV1FUA2nogNqVyx0QxsrHmnCK12wRLHrPCY21GMBPPwsTb7h8YBGH0ojF1hLsnaTTDkIdoRm9o1BJeFIk9t4jnDri3N5ft0zNMQqowQ/yCau5zTH1yk+/5Ob/qa36dy2AMHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QyPYT/+nO9Khpw8+iR/GFPYkHX6reBcCUn72gZfCnPc=;
 b=skop3U43ta0CSfUYhJ4NhQw9VZe7pzjEa03MMJfO2WgGKc9U+4jrgYN+Fvav90Q9QEQCWRsZayTSmoCvF7AAWG83i6Ooha1ewjWOWBZ68qaW2gkYEo0lj0vjzaUIW71DPvrWNcvAnUDUk7/p785S2xvjZ2gvUEKdGIbNeCV2F/I=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY5PR10MB6120.namprd10.prod.outlook.com (2603:10b6:930:34::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Tue, 19 Mar
 2024 14:56:15 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 14:56:15 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 00/29] trivial adjustments for return variable coding style
Date: Tue, 19 Mar 2024 20:25:08 +0530
Message-ID: <cover.1710857863.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0050.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::7) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CY5PR10MB6120:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	wBEvHdmcuDE6BlVRZuBw27D04E7dZZ96vZI318V7VePHorNoVgx6nZ2xifW3APOSk9nFkTjvWKYFVtdFsMtvt/u2K4kLg6mHbu3dMsVUEsvzt8pS5g0mGt11g/N9Yge2k7si/l4JxqEAuete7RBNl25Jc2hVL5KRfy+OUUmyTimqiBXDt8aar3IS/ZsKZmKozXOk1GhS4pUXVNBFizBFSCYd1LK0AJQKWGQtUWkyXf6+SNVXjWuVjK/SLlXs7PgMye+r2b+zJIV4mrnqqIPp4bmV7Ku3GF5max+rGUykxkiNNuAsyvv498LxCKGn/bPpdSupbjxGIJSUWKULdbcaJDUcrZ5NkUleTTQyJTJYiuZHMveLaNb7t4x355L78Auvmd5cfWBH7drLQosKLN1rxq/8xCvx7mPyw9qm922NnmJ9HgqzAedBxXTh8waopA5RxHUjtFGeWFZacR0ngtK//ro/fgQIOZTqaQ4XxOo+jQr+kU0ZKI7yoqE7AJm67dq01hUBls+Ni+kUBSM5fKtJUZwbB6qOp2Hgblzz+bfsgZ6ww9UdOpYqFNPMTWHSGCjaPzv/Mfatdad0OTwgI5l4b+BLn7rlArW0/G1yUDoRgAg=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?+3tUrAzFIr8Sy6h8Se//2VUE6WQ9PhN+P7lZ/G0Ntu0Lmd4R/g7l0R9QJcFa?=
 =?us-ascii?Q?JelV6ddI/hHHQKjib6fA1+1LflR5iEdYawELB1rQ/1A1vlKHwt9/Gf795iv4?=
 =?us-ascii?Q?fKMt02LQ8WT9Gp1xGycrKBAkmRGM3RV08e0ZGLzN8En3ydyHjjmB99O9c8w3?=
 =?us-ascii?Q?CqKVrSTI2+pTWlBBHuzGNZVbd2swqREQM6lT5UHv/wgexCU50bs2MEXxmw//?=
 =?us-ascii?Q?Ot05OGNhJtCC5MrVWBP7ofDBPVyvPhFIWeAVfA6r27CqLe1QNR3yaOsjwam+?=
 =?us-ascii?Q?fCSsINrMaPCZQfX7jhLpALTh7lhzyCaw7ZEMscbMEY7mNjnxahncumtwYnVm?=
 =?us-ascii?Q?SzKcGJH+NBhoqLpZ1SJn2YGE0JWTe2KDhaD7/p664Jwr6AXl3F9KX79LWIrH?=
 =?us-ascii?Q?kOyqbFWiFrrHuwpKaE2YfRuAC0wrgiWDmR/+/WUHjdRGum8HHoEwsWx7wOTo?=
 =?us-ascii?Q?UAZdHrAsmDwsgdLDXkZwHBKsLf4+7Xhl3p4g96o1tDhsU+RzX10zWrmT6+l6?=
 =?us-ascii?Q?LPms9E8SUAYTZtym7XvV1HbmqFoxrmMAfQrchLZksxg2iMkYUw3i/yXHJuEF?=
 =?us-ascii?Q?hhkUs/xVP6PjIPRfgY6U/7DpGMQtEBmL/7M+vKOETwAUsiyQRd0XbnkrJ/do?=
 =?us-ascii?Q?Aj+G/WmcG4RCNjxmGB9xKlzH7i9FtbJCXAXhbOtdyH2blUfOGbaYgG+rx1EZ?=
 =?us-ascii?Q?HY0r31oIDrINcaCvKBRwPGDy94ppGj8Rs91EMqPd2yEuthKdOnNSqJEiaBcD?=
 =?us-ascii?Q?sNE5Ie4WHk1tSay+/zpQTZ28JFnPB4YAQo6sPKMnmg0/+KO4bxBDy8o730SQ?=
 =?us-ascii?Q?VHGhagKEsva3XDXYazr8sf1PBta0z3wz0/wMhAEqWZIllSwmTAymS2wn19zV?=
 =?us-ascii?Q?R57MehHlxMfFg9Q18mqWhnKqljxWzOETLxvDlIpb2QLwR8T2xY+xJDpW+MTG?=
 =?us-ascii?Q?rk97yWh0x3TrfzVVHRX97WCGli07+duCXgPXWWJwnDSYBdiReju+mESlhLTl?=
 =?us-ascii?Q?60KLvEOvAM1fe6byoylfbPaAr+vwlm8p2xCbc+XbfUnQzBNHPQvJf8SR93vY?=
 =?us-ascii?Q?rl+/loK4zHiUcdsVhJtWfl42u1sd+EqYvyRwQafHUlCwschUbGeWBWyhP7sI?=
 =?us-ascii?Q?pV+G5XAHVLt13DgfCSoUQGwStjbOlZ0ht4DFffj5wSDIqq7V3F8N/AsrTQYS?=
 =?us-ascii?Q?2vtsFCJKnVoh2FbwA7Wk9gbFajWuApHpsA4eeAR8+Uu8AkJelkeSTL6umvvs?=
 =?us-ascii?Q?71iZLz2Y4ZIFXA0QxHmsctNQA34akDsVPS0cHLI2HiaHVvKhk9aBM6kMk+Xl?=
 =?us-ascii?Q?oYD/oLbtpPDkjoaJIb+v1aogMzhk6GK9Szj4QrFy8RjgvzJqXuV+negTf3lh?=
 =?us-ascii?Q?3XWOPULx0FGdt+q/EQQphcCK5xw3iQ8Oom/oq488dHTk+l/uq3xgOlJ+EUyQ?=
 =?us-ascii?Q?n81MOnxfZygEIFtAbbfuT4C57ayf5y6C20WFJAmp/rsGGCg07WJmCddxnbLV?=
 =?us-ascii?Q?jw0MmaUgMIrl7cjzRfe0utykAOGSgdHWw4i3UYOzDwTCwKV2kvxOi8PNmAXM?=
 =?us-ascii?Q?LH7GSYCR3aWOm7oH8X1HPkbXjBwsRhmusRWN0yNJEBRjIgbIp2QOgNdzopwD?=
 =?us-ascii?Q?9R4QPVyylHdEDp/fYqDIZxo8BhvBxiCu3Tv6l1J0yEzY?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	dGmbYM+rBBEL5QORZLk4g80zSfff/AhDeeV8H/RVBntUYZ1SVgl/Gl2L6BPRuT3ftj6nBnYnS2XvGJll3Kl35kcOVZ2W1a7TQ5J0mYcv8AT8dUOvhSq7/tMyQZteVZS03aPm62TktPIF4FLlssti7wWbG5OhHlIkB3z4Amh+k8caS2Q47xp0c0yR/xA8xGaCTJJ4JFW0wNZOIQ7oEyQsqGNRhTqjTvAOa+zv+/KKclKXvoKuASKyi6OhbKCtUwsTLSchSWQfQq68ZP7cU6x2aO4VPNgTX4YIkLpi1EqH0MutBbq9xD3v743eKTIL19esHYF1GnmRgGKa3HvIfQBWN2BEVnJNXHfqBZyniI88tzst0PNRBqu74UbNb10KiElSzq0dzxqhO94+l2R9wqddpyiB1sPSY3MxGR8XrGGK5jcfHoGCD4/Q6DjCpY3GY5IbXHIJr+EjUbQUuIo2H+RRtJGHlHkB3Kl88PJPXpr2pB15uwcYIUEa50QiLCrC4aiGxXtlRe5XCzhO8kAkHA50DBwtIS9rlsKp0NnLUDPwBGXUVRxgFByl+ceK1H6C45rvF1yinf25FCs2KgINNjRMLegoPhmbB7gdpYYo3W31GfM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 021898ef-fc36-4b60-64c6-08dc4824b9e1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 14:56:15.8023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IQ069gG19JLA5PLLWPewWgfBFcwhI2Yqp2fXudccALjf4H95zBUTCDhSVtdUTBD5mWN7qxKe8ufaXHzW89NRpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6120
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_04,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=788 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403190113
X-Proofpoint-GUID: NpmX57_tsz1oiDOMmYn2nnvIB8iu4UlU
X-Proofpoint-ORIG-GUID: NpmX57_tsz1oiDOMmYn2nnvIB8iu4UlU

Rename variable 'err'; instead, use 'ret', and the 'ret' helper variable
is renamed to 'ret2'.

https://btrfs.readthedocs.io/en/latest/dev/Development-notes.html#code

In functions where 'ret' is already used as a return helper (but not the
actual return), to avoid oversight, first rename the original 'ret'
variable to 'ret2', compile it, and then rename 'err' to 'ret'.

Anand Jain (29):
  btrfs: btrfs_cleanup_fs_roots rename ret to ret2 and err to ret
  btrfs: btrfs_initxattrs rename err to ret
  btrfs: send_extent_data rename err to ret
  btrfs: btrfs_rmdir rename err to ret
  btrfs: btrfs_cont_expand rename err to ret
  btrfs: btrfs_setsize rename err to ret2
  btrfs: btrfs_find_orphan_roots rename ret to ret2 and err to ret
  btrfs: btrfs_ioctl_snap_destroy rename err to ret
  btrfs: __set_extent_bit rename err to ret
  btrfs: convert_extent_bit rename err to ret
  btrfs: __btrfs_end_transaction rename err to ret
  btrfs: btrfs_write_marked_extents rename werr to ret err to ret2
  btrfs: __btrfs_wait_marked_extents rename werr to ret err to ret2
  btrfs: build_backref_tree rename err to ret and ret to ret2
  btrfs: relocate_tree_blocks rename ret to ret2 and err to ret
  btrfs: relocate_block_group rename ret to ret2 and err to ret
  btrfs: create_reloc_inode rename err to ret
  btrfs: btrfs_relocate_block_group rename ret to ret2 and err ro ret
  btrfs: mark_garbage_root rename err to ret2
  btrfs: btrfs_recover_relocation rename ret to ret2 and err to ret
  btrfs: quick_update_accounting rename err to ret2
  btrfs: btrfs_qgroup_rescan_worker rename ret to ret2 and err to ret
  btrfs: lookup_extent_data_ref rename ret to ret2 and err to ret
  btrfs: btrfs_drop_snapshot rename ret to ret2 and err to ret
  btrfs: btrfs_drop_subtree rename retw to ret2
  btrfs: btrfs_dirty_pages rename variable err to ret
  btrfs: prepare_pages rename err to ret
  btrfs: btrfs_direct_write rename err to ret
  btrfs: fixup_tree_root_location rename ret to ret2 and err to ret

 fs/btrfs/disk-io.c        |  22 +--
 fs/btrfs/extent-io-tree.c |  58 ++++----
 fs/btrfs/extent-tree.c    | 122 ++++++++---------
 fs/btrfs/file.c           |  80 +++++------
 fs/btrfs/inode.c          |  88 ++++++------
 fs/btrfs/ioctl.c          |  66 ++++-----
 fs/btrfs/qgroup.c         |  44 +++---
 fs/btrfs/relocation.c     | 280 +++++++++++++++++++-------------------
 fs/btrfs/root-tree.c      |  36 ++---
 fs/btrfs/send.c           |   4 +-
 fs/btrfs/transaction.c    |  56 ++++----
 fs/btrfs/xattr.c          |  10 +-
 12 files changed, 434 insertions(+), 432 deletions(-)

-- 
2.38.1


