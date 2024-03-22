Return-Path: <linux-btrfs+bounces-3512-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A14886B2B
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Mar 2024 12:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A8241C21D8B
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Mar 2024 11:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F66C3EA8E;
	Fri, 22 Mar 2024 11:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="POoMHY23";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kX9pMa50"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0F03AC2B;
	Fri, 22 Mar 2024 11:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711106253; cv=fail; b=hDILThJZo9YBZpkqhBZY/tZRPWYqlxCi9qwOzKb1nWQiOTmiIRmMCGTsogWUIAnecY2BhFsvUOgoTXeRPtJ80znfjaQ4Wd3kJw5UbKt1ssyoWPVUCnRHEKtGvFr4qqzSJRFTWNtB568u3HVOZLWs1XxJWlGYK7p5PtmNFYoNmz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711106253; c=relaxed/simple;
	bh=ug90Wn2ONUhpOtz/+69/Z7g4TEc/ntKRropD0bcTsFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OKUGD44omCpgR9k0JoB1SrGh3RK7+94RqMPTrDeI0DEn/BImDkT8fA+I6zfSQ5rWOSeXJRix6zHbKdOVqTcJzKd0cjoxMVut1eTXWnB9cngzLYvR8Zaw1uLZPZDVFvsZ0DlfOzXpM38rznKme2uEL5sPAC7WAkZDcBWA3GaMl08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=POoMHY23; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kX9pMa50; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42M7Y7X8004067;
	Fri, 22 Mar 2024 11:17:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=ZaWKz62t/seM2nLE+JkHIhp2cjWXl8wiwr5UsrnCzJg=;
 b=POoMHY23a5Ce/V8RePzE1ntMdjqjsadnwpQ7sVi+hKmQnDpoq9t22/CHKxNmf5CLXvxW
 wU+QuQy4rVm1oZtGbURCwTHR4DrADNdSd/tzi3lOXJ7ehIjZRTWSheq+W1+ekmrVUhn3
 0xiCbcnX3K/Lodpc8kgz0Lb016k5NMILJcW/XA4ZMyOllVTzAuPEyfJrXDxK/nZ66WlP
 OWuEncnUeEf0VcxeZxqeEJNE8YCiET16cNcZJQd7FMLBYHD/J5QnH4NzDtIjBNCC0peI
 ConE1gy5LcdNSnb4kqEy1WNQZw3t4/wxZDmPa6spH99pV5PvqDekmPS2/nZITOR85QQg jQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x0wvk8vsj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Mar 2024 11:17:28 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42M9APAC014978;
	Fri, 22 Mar 2024 11:17:28 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3x0wvk430n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Mar 2024 11:17:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mN4yv0BdgFre4Pu1x1MhhJRP67a6decEZQjr2BscQ2WSC+UDGHZqDsxQraQ6kYaD8nTl9iqUzV/2oiKEfU2hlJnPt+5rdz5Ixjd5lFgXLADeLbQimr29bPjQcEZJWZ5ekdjoSo5V333Itxg4tQLXmaKWtlIW0v9kzVA4wiq/vTInraLbtAwqxw7YhBdjstMIhFDgzf4ejMPJcVNosergJNNnOUJDUxr1yoKE6FisbszMRcW+LmlPOPhrghssmubMFuaAdSwx5ul9MBhB63VteOxLslS2kU7jxam3yhE4sfEXHYUlmpUxBkOfmm7rAGlLZebOXSHmuWSNs78pq5S5vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZaWKz62t/seM2nLE+JkHIhp2cjWXl8wiwr5UsrnCzJg=;
 b=akSSgzGks313+/4R2Kqyh7RKeu3EUFolreYmyGowlsGUjhMXNoDjan6waxiUXpx/fgygPdUkc0kCI4aXcli67NWMYnRfx0vQZLTQYGoBUfuKj6J12r7c9dObAWTMLoxRF2NYImSv9w2SALxI0AVgX0RgkTVqL/qQxbcKmgfF72cxdJowXGxHiUOY461F+8soO/Q48V2rbM7ut0ed+s3+apqbUaoSSHlGFFfyfYTWsRDp7CrchHA3jm4McXTSjBOXE+dKUeviXyh4JHupfOL6UNdepoY4iJor54QnvWAg8iFaY+YkJKcjUQjk9a56mITKd7UQqWOhp6wXkGPdf4lkfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZaWKz62t/seM2nLE+JkHIhp2cjWXl8wiwr5UsrnCzJg=;
 b=kX9pMa50C75pQ9HbNSYMJViDmfEhZzGljaAz70KfB+1WzAT1DMHD2/kNOFKatyCu2f50ut+peK+58nHIo73XxMLDpeBdNeI2Q2lR/qUSBi/0UAVuMSzOGnaK13S5rTvnv+JOSeiW4lvRmohRSeKsu4oWZj/6w/GAn155aJsC5Qc=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB6424.namprd10.prod.outlook.com (2603:10b6:a03:44e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Fri, 22 Mar
 2024 11:17:26 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7409.023; Fri, 22 Mar 2024
 11:17:26 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, fdmanana@kernel.org
Subject: [PATCH v2 3/3] common/verity: fix btrfs-corrupt-block -v option
Date: Fri, 22 Mar 2024 16:46:41 +0530
Message-ID: <f19513c267884160a851edf76d941df423a56fc7.1711097698.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1711097698.git.anand.jain@oracle.com>
References: <cover.1711097698.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR01CA0158.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::28) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB6424:EE_
X-MS-Office365-Filtering-Correlation-Id: 6497fe5f-e2fc-48d8-0908-08dc4a61a75f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	4BTVAuXmJ6YOLNp1iw1yNFopwlQ7kXzvVjlsgbz5yAtyhE/cZPGl8F0JtGGuKsed/zjqWxdWuMQwXS/xapmKUqI2ZSiE7RD7O4gNKM3mSvUn0svvqQbFZwZeVeRhz5SfAH/q1WGbavXuN73NDjMyzECIP/TtqZHbeGzXnfjTP3b0Xb2gR0lchQdTOFAsgpIboaq+UN4qM/oTGZsStgylIbfqx0ygfse7uOws68V2PIGJ8bjVFz/R1OBGNnA16XXzg1WExXLJqUau3r6+8Wj79yCzT7Z/1WsQyv80nu6Z/z3n1lbUo7pjU4I6vN0BhcYVMLxsNAPUtMb2V9DZUrrUdN8RNRcRENpPKDsY5tGKoAn2OSCv4wvS1r+xnCPMDbXBTOQUEQCe/7eiccNCF7IDuBdqPylKOpDzXEnigtJDlwloNi4dhXg+FmnG3jYDVL5jy+0Rfw79gEF2QGs0pvgP/4EGurFQkfB/VZCLC7/cZgQCiPs7ZIFO4cRIAOV6Ux8MTy8r4QUmErSz7FuR0TWbjFOhZ8yzF2N716zxlRcRztXSqfNrJ7qbnTetShNGq682U0mr/awEfp1LkXWnEiQ9TPv2PlOEag0TH5kSPKfyzCUkYbzjPEPH8u355IFjDGkWV/ZFEMS8EgMva0PhkfCYQtEJyTMlJs8mflaOUVkrOWo=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?qklJw6ZhlMtMcRqtITC+4E1HFfFwPSTdJ5wqZx22zZZ8qneOjabqpwPs46QS?=
 =?us-ascii?Q?9Q8i6v9rgxQfeaPmAmYKumXSzoK3lkBqyn3ofG/JTVZhIgljuW7S7fPHwrcT?=
 =?us-ascii?Q?CTrFqDix1h67xSPfBlJwrmwcRjYbtnqxR88Dm+pN1nn4Bt+R9a5kORgh39ZV?=
 =?us-ascii?Q?B6fVg7vvvyIqwMn3b2kCiCm9mshPwAX0MsH6CkvHwHruB2CBzFnUEUhYuENv?=
 =?us-ascii?Q?QzZ9I10wxmH/XVKfmt+RkZNJpVETlIFcpr26OXt/Zr34ea+qSsLF6CjXmVj7?=
 =?us-ascii?Q?EXXPq00fFr/fecylMaILCbrk3iA0mzHuwy+tKnTo/a0D6s5QuZwwZ8UpTrFd?=
 =?us-ascii?Q?Ic1x5H2eaTIjo6wz4RxhK6tAs48eqA2qPxDvM0hjoRcbAhikAeaFEagGIOrp?=
 =?us-ascii?Q?MGgYyLnVBeU2gEv3Rv0QyAkJILIW6I1HQtSgOhfb1OkOVEw3sMv6Ka21Tz9P?=
 =?us-ascii?Q?zMheGfnRQtlVePwz3ngqPO4ZAK6thUAv4sGJJwuHoXrKmv7/TEztyV4qCnWi?=
 =?us-ascii?Q?eh8qFzaACBv1rTh9ikXVDbGSOEg9N5zNYDlIXOjF2BMaVkLajO5ryuhWRUcJ?=
 =?us-ascii?Q?Mq/iU+32YmggbvB0ILu4m2oqJXGzNJWQuUduhh4ExkZcqneIREwlLc45JbWG?=
 =?us-ascii?Q?PjChNWLG+NNQeKnchtsAX6+BEGHiAJqjcNgtN1ZocdYATSckpRWdNrA+p2Iv?=
 =?us-ascii?Q?cym6GbrDvkxr+UgnfKetYtd5JdoG8rK/MQL23kvnJ0wTNSJAUFkBqH8ZB7OC?=
 =?us-ascii?Q?oHKqPZQlNuY/Ky6BtO/OKBBtILLt6eZIhJ/5je5IgJRqOX/P3Yhp+1R32njw?=
 =?us-ascii?Q?608y1IoVS2gA0hpPT+KVftVH3mE7B7mIqwHfdbFrXpmOkIRcAkJzlQuf06YO?=
 =?us-ascii?Q?dyOXCiVG54mfN+hBicbPvnMEIvE4AxrUDtBs4SF4xx//2ZG92amrfWmU+83A?=
 =?us-ascii?Q?uEyFWPMJ77wVZRX23t8eDIZp5YFIs/mGO9e4ktNwDGCqTRCgdSPQro1tzLXs?=
 =?us-ascii?Q?Mjv2A2Oq9Q154Kiu0QBZeNggLk2gNoaSX4HsYHARqx4rFfxoMNdvbYDcn2Ny?=
 =?us-ascii?Q?9RvvMzWlJjDKontksHDsiL5VqGhK5j+RZt85pnPN59TnKda5Qtfwo8sqglpG?=
 =?us-ascii?Q?xFruzoFe7YoiZ/2KYGjMaM7opc37216PEoCf4QIgpDboAiB2pQMh7VHIi7sl?=
 =?us-ascii?Q?egwmP3JE8dDUG+uo3oi3L4MBbo+Z9vYkKtP6gOfkl0hc0VH7aRs2HIvwSuup?=
 =?us-ascii?Q?32i3Iqu8Tz3ciMjdFn/llgyRGo9oEKuwH/kCWfTTl89awf+a3VcotYoS2WYM?=
 =?us-ascii?Q?bMdc3bLtsUzr19kosYoS0sDQyaEJiaE7gD5DEb6lwgK4S0j0UUQy6bB2S4MB?=
 =?us-ascii?Q?wttmr+E9yX1yFzVYHLj3uuoCK3/uD/rNtwRbXn2bV0BMPn+j8n9apf0BPptg?=
 =?us-ascii?Q?mgGncZp/3G3wWN7zCN4kwmfmHwjFTTy52rnFFIAgEKBXhziVHbbxSsg2zQhm?=
 =?us-ascii?Q?c9yJYVuBqUtiEGG482PzlmIMPy98sEXQAadHflxfhKZ6QpRtMTOv7uVwi5g4?=
 =?us-ascii?Q?c6vVBgRkpt0wEcM8RF1nsg7XExfwu51Zbdc+w+3ZSkXgGjQh1DtEi7wTzUyE?=
 =?us-ascii?Q?eSTqTeSTk949xNSkfejojmNHodmoHHA1Y7GNRHmf7BN3?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	45KPX2ycYhYv3sYc7C7tHOe4ynySX//7z1zkINuVBcCSHHMbCGcIocLJQyDrQ+Z6H7fYfy3SxRGBEy4CfLTrxrzAz2J7BmrTmSDEho0jsIK7ivhU8hoeADcwSAP5/M7HBEnuMW40cqUDdJ7kw7abgXX8ML/yZWNvRUgCtSbR6u3WuVsGo318NzJ1hxwTJzZX3EXRbFF7KDfo9jfqMJCbOgdY5Du4O0nqtxmYSIVwHe3qzHMbYy3NvP3p4/D1UweHjC3XVvyDOleuKbnbDU3BkyGE9ZI5U38P3ezie+G6oWCkr6FnIaldker4BUt4KpNioeNLdwrzdaVEH33f1VWxWSysthFvn1yOCBV0RWzMY9VRBnxVVKRVUB6dSnTBlPNWUbvE8AqtDdCgbl0BAvJSuWkH7WPaRANSLZPYXsWLnUug3a/sVzee7oJFwBNu7XpLuSvKg/ZSQOOrLrj4MU9h8oqkDpoWU4GnHyEqF6JbslH0EUmILtxkTS1RJOoUnGXBCzdiiRTL/C8OUWAyMvBuszqzboMU0irjAQs/wSxKweRGYiePfLaLZ0nlc84npLoqCATPDyfKA9X6vzBhiyvjY0gwe7b420c3UAZGHnEatk4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6497fe5f-e2fc-48d8-0908-08dc4a61a75f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 11:17:26.1145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 00+g14U8gLUtnSVK0bnpmaY2jwriwj8nnao3Vc1+wYCNB41lxUOxDfda1sUWAp0ffmYL7nogAwny99BuTp7SiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6424
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-22_07,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403210000
 definitions=main-2403220080
X-Proofpoint-GUID: Ki6385uFnDY7nispPv4gizfq_csprtGC
X-Proofpoint-ORIG-GUID: Ki6385uFnDY7nispPv4gizfq_csprtGC

The btrfs-corrupt-block -v has been replaced with --value so fix it.

_fsv_scratch_corrupt_merkle_tree() uses the btrfs-corrupt-block
--value option, so add the "value" prerequisite in the function
_require_fsverity_corruption.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 common/verity | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/common/verity b/common/verity
index 03d175ce1b7a..59b67e12010a 100644
--- a/common/verity
+++ b/common/verity
@@ -191,7 +191,7 @@ _require_fsverity_corruption()
 {
 	_require_xfs_io_command "fiemap"
 	if [ $FSTYP == "btrfs" ]; then
-		_require_btrfs_corrupt_block
+		_require_btrfs_corrupt_block "value"
 	fi
 }
 
@@ -402,7 +402,8 @@ _fsv_scratch_corrupt_merkle_tree()
 			# in the default filesystem tree (-r 5) and corrupt one byte (-b 1) at
 			# $offset (-o $offset) with the ascii representation of the byte we read
 			# (-v $ascii)
-			$BTRFS_CORRUPT_BLOCK_PROG -r 5 -I $ino,37,0 -v $ascii -o $offset -b 1 $SCRATCH_DEV
+			$BTRFS_CORRUPT_BLOCK_PROG -r 5 -I $ino,37,0 \
+			       --value $ascii --offset $offset -b 1 $SCRATCH_DEV
 			(( offset += 1 ))
 		done
 		_scratch_mount
-- 
2.39.3


