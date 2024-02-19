Return-Path: <linux-btrfs+bounces-2541-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C76BF85AC74
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 20:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECEEA1C22E31
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 19:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0565A0EB;
	Mon, 19 Feb 2024 19:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Wj/8J/28";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CgnN5G2M"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4372F59B7F;
	Mon, 19 Feb 2024 19:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708372206; cv=fail; b=TJrinfQgk1php4Dzgpaoei3dfhnuKHW5MwUHy5zcCne56fwQ5sZWv99Av4lia8QIdGh/JVQJqcICd7WMEcQrbuQdYdAisJkbuBUHxrKhrx6K8cZhYeHU9tY7/ejT4K/jWT25puLvi4HTD2rjnMMi3BT8bfzLENVuFsh8soLCvE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708372206; c=relaxed/simple;
	bh=5deobIGpSrYWZZiR2cDdYTAFGCwvr1AgfPDG7bAZclA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X99BH0b86U/EFlQAoHHL3wJORo4iC2oeRi8gz3ssoNQvgo78/S5BQQZCqFuVvTNGpK20wJ8tu52JinzzUDEQVkzheGMCP1Y4yPM0OOMKhd+tAOwjqarm3IjY0BiemLUfcYCOEORN7UAeP32pFCO/WBanyyd5prn1MR0ZKG934CE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Wj/8J/28; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CgnN5G2M; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41JIJe4H008570;
	Mon, 19 Feb 2024 19:50:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=fvTwOUPP0XgFqVIjoT2LAcfhJ5sUDbckTiP7ncAvjhY=;
 b=Wj/8J/28gAhLvo4vX0ohb6vcSTnD02gmjFGbaRAaO/gwaygERva6yPTkYxm9hZy7rh3S
 tiwTCIAU5b/y7f0/K+qDzfnvTaS8dxWRt9ZQ6zFeSb3QgqQ5dt0UWquIUDcyEl9Qv1oR
 MMXdp4KBC2ikyAMJAVurJLEtsKxyETSCsU3hjEdnpzgZL8PqBEkHaWNRkgSZFDGxrUqh
 96e84TEoiNKCmrWugAjrxSO17VXl8BaJY5OG2OrInp8zXlTZURYuusUbjx3SqMp/2TU9
 GlCSSQaf/6AjjPbhZBBkhm2vb2XffEbQ8ROyJMgAjXCvs8VFTPolW05ZQ3IxS5AfKKjl pQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wampavx6n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Feb 2024 19:50:00 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41JIQkFm032069;
	Mon, 19 Feb 2024 19:49:58 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wak86amqs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Feb 2024 19:49:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mrGwcwH4B9W9lU/L9IFmR2Vvyikx2dnDEdsMFnq/3L6ka6HH8ib+9oh3+1MAHV9Wa7PJbV1THQ/nXMeazM57vM+H3710HiG23GKpkWH8WgjifPMoKDoFy3RrjqN3E6zYH+k10dTliym5bZEq0u19KmlEIVQkwYtUtiW6KJ194n0ugcfTpSZOdoroaE9XcKGhMa/9RclMOlOVWlSAAMZy9TkQYSeAY6OX2fkmn4DBS/DCv/DXQ8KYMzfjOyMDvxteLJwHO35JRN/jFO00O0G888CxYTsoSetbZ98AxE971L/TG2yMHvCBBDkGtuSkfM8Tkq7RFpHrn/O4tKltiq1pRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fvTwOUPP0XgFqVIjoT2LAcfhJ5sUDbckTiP7ncAvjhY=;
 b=X3x9LvLsQ1fciWFqpGbUv9y+mN96lU7Fo1PhQTVoTyu1n3zCWeSLDPyEi2dp+pwrw7pPS8blMKokVKiY6FXQYsc0t3kLee7LiVRxPAHdjorjcuMmdjHyXN4m2ussuPcuHI9P00j7kXI28H9m8FJggkB/Y1AoYrW5FaEhO+7O9kAeiHuawCuTQKhgHT63AYfskXj0M9DpfLBMKDkCqzKorrbPBBlRBKwl7orCSlgetMF4mI/A8ciE1zQ2uoc7yU0IUNa2imxDuY/C+6OGZw2AyxbUNyYUmT6RedPx1Ycotea2SOyYt3KQJGOBe5yyF6vBHtyxVu2c3X/NmS2L+C3GKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fvTwOUPP0XgFqVIjoT2LAcfhJ5sUDbckTiP7ncAvjhY=;
 b=CgnN5G2MEpUOKxOHzo/kk1oohhyhOYswOcLKj8C8Mr+bCdLBUutqgz+NE2qipP0qdvwNGBBC8iRcilv7blVrkB58fPqCGSe1sAgRU+2xMW++IGHm6U2Uqth3qKPsRu6Y4w5BPdi2gzRhnstNo3gyJw23gXV6icVSdYspqxdROV4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY8PR10MB6852.namprd10.prod.outlook.com (2603:10b6:930:84::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.32; Mon, 19 Feb
 2024 19:49:51 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690%3]) with mapi id 15.20.7292.029; Mon, 19 Feb 2024
 19:49:51 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, zlang@redhat.com, fdmanana@kernel.org
Subject: [PATCH v2 08/10] btrfs: verify tempfsid clones using mkfs
Date: Tue, 20 Feb 2024 03:48:48 +0800
Message-Id: <44ccd4eef48ef7a8fbe863bdd7b13b2ce8fa642e.1708362842.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1708362842.git.anand.jain@oracle.com>
References: <cover.1708362842.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR01CA0104.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::22) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CY8PR10MB6852:EE_
X-MS-Office365-Filtering-Correlation-Id: 65d2de89-e15f-4107-b272-08dc3183efd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	oLqlOE4hmdS6/TRuhL9bPkudeisYbyDXvD4WVxT3D5ZTeC+nCFm7MlQIT0PpFfYInv/R2BcrN4dIqbVPrWUJYVTBfDca3IUlhTACH0bBkxGK2xIUTmN7ZBMWmjn1acLyJCN+En1nw3Qfnlk//J/7NsmsBQFHiM0dq1aFVC2Htb+GCiweE3EjGS83MOnH17VH12oRKKBUcJWTQWVbzVdAPqeoFcchZq4rra2XwteMOMdo2NSqe5M57lQipz4Z4yEveG+vgt7n5ncsfzOse9sJN9iUXfvEe9eVAVeGJOD6jdhSAWJOYsJHxQNX5cQwAPBNUWTmf6RrQr4lGhyApc9PC4Ds0NW/LiY7Q20G86UMuC8ksMBl8CoC0LpNNilpKqXuDh9okkLAUEVkcNerkSh3CQy/C4LgFdjMsHHZJBysrrUQiosKyFIjzcm3KcbfQww6uxjEHmGGIYC/nMjzhtXj6SJEJw6mg1oYCqENyMQaamPXrqC8hvLRjQoGEENC36vQBX/O6vXUGJxP59433MqOnOtuFdlTkVUThSivLyY06Nk=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ZjbcmJbylyvj7c0qxN4ISclRX+Oec6WmlnIBS5dL6rQSASeCsZalF7ufUOiV?=
 =?us-ascii?Q?0Tp7SFTJouppNr7DCDOPdrVaReOxoJGOS+vtVJKr71B1Fp7ziHo03ogCpqgf?=
 =?us-ascii?Q?S7/cdH9gqQsKJCxNWPFYDzV50019cM+AlNKlFHWMuZb+5t/3JDszZZ5jyiYe?=
 =?us-ascii?Q?RXfbszPq870fSOMPUBpEe2hUBHtb1+Odrn0tG9wRU6SiiKj+RFvQfLKTsTuG?=
 =?us-ascii?Q?eCTPaINE4AwTkUubt4DzHqhI9e/n3ZbZip/kW/ptRAYW/VEH2v6Te9yzYFzI?=
 =?us-ascii?Q?nzI4+O3Pick+KPKNobOkbz8S9UxnDIxty/8oN2TNWqfKhanLLWqULjrh5AZi?=
 =?us-ascii?Q?hNeK+Ajuztu0IYJ4nqifKSQ9x2Om1LkMBIAwTihp8R+FLTHEFTGbBnbCPlCJ?=
 =?us-ascii?Q?bQN3SgpAE1IF7w/Ktd8txXug+advKg+T/pQMRssV1ADpjjCAWg9idvJ1ew24?=
 =?us-ascii?Q?jK5Sy+PVc1wZ9WLg+a7GS0fxX/kWtGHjmVq30GKwKI+3NY+39fg5E5a7Ohv+?=
 =?us-ascii?Q?X64jpv6dazlj6bk36XAAEeiARO6R7TreLLmDdmhsEh/rnFnIuNrzKf+tk/4V?=
 =?us-ascii?Q?EO6nN7eJjcvzrXH+6vOH24NyBUm4aYVkv3NObalBlYoXnHj/LVY3+KNeRgzi?=
 =?us-ascii?Q?yMFrTMk+HRko6WVR35q6YxYR/fkesExJPdYg1n0kfLhC2mM9W3tUxqB7AQrY?=
 =?us-ascii?Q?HvAl5wWD/7RFpq+1TJ5d5ZEAZ7pyPtfSbsxujinpbXsrXyfDZ7colRjpulr2?=
 =?us-ascii?Q?1mYMnaLhG3v9GGbc9QmAMijmR7FAyl3swoOYhmx5aViQQICbs4o0gsPHxKTb?=
 =?us-ascii?Q?NH7FXAqiCbvvGBe3YuYfKCqZ9A0a8blDupKwofQ6PJj1w9HZjG4EXVN9pCCG?=
 =?us-ascii?Q?VldX36hANrNCEUT0yAXomTiZ1lUJoAQrdIDQq4WzNv9Zf28w4oghv2RAt6co?=
 =?us-ascii?Q?lhdEYywb+vDomcXzLH50jstMlz42557++lVMg4rF6aDBop4zgrIahc5fsyfA?=
 =?us-ascii?Q?mpTiL0MgwmiYwghF/65HZ1TZGHGXBzBWlVKu4B6ss9veFkznxHMgmguuL9xO?=
 =?us-ascii?Q?v4CyxHnCqEs2s1fjukCItWRI1daoqBHZA0awcZM41J19pMVMXPR8tLQdJOt8?=
 =?us-ascii?Q?QXtzeHTJUYYa0NY02Y8AfAHBHzrwjj0LGqZJWhyK/lXH5+kprCM9l0BYlHH8?=
 =?us-ascii?Q?q/g8nncZpn6M3Ky+9rszZBVN+NoAT/+VEGe7mH3jwuzTDjHsk+Y4BWjKCTr5?=
 =?us-ascii?Q?xHJ8XUGH2QZC3stNBE411/9kdFhZxPBLefCuIV9aLC8RCp4bAGaupgBQjc5Y?=
 =?us-ascii?Q?lk51C2V6EDyAsmXp2Vk21OjQqX1Y6bfXgUUFrdsgNsvPlUlFHwXvTDJPS411?=
 =?us-ascii?Q?5blw14CFH+bDaxtd84kCoyRxpmaq4290uYAEF1V2Gb8b96/Of/ch3ssPqVEW?=
 =?us-ascii?Q?TbawJvYM8IUNgWO7HPPWyPuzRd3nhJ/yjKBZlalFpQ3LZ2jabiIl8B5yuy40?=
 =?us-ascii?Q?hOtUCYy7t5izGec48r/QtkdaZM3sF5h3YTQ7OuEtqXeueaXFazYesyd6cMh1?=
 =?us-ascii?Q?4MDHGvLD/sMVwmhMqvYbu/KJWFHZRqr2Y1rmbLWc?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	hOtv/AQh20fEHDApnmrwwxpQ5OeBP4lN6ltNalcQ2jWbew8Lq7VUH6PngWVtdCJw8PaQmyoXl7FFsbQf74lE4lSyCHW6slgDwrKDyZ++qQvcARLAx6IdIYLsQ1/LU/mQ03weTVEOduYxpeIWNeiCxOkidiXM+G7FepreJG+3sT0Ql1Fa2q5xtKxGdNxTK3ZflFmlSrtwSnl7clCmk56PV5FPz6Km/scUubumAZWHOBO9s+9XW+K66iJ1EHEjMhVd2nlYlWEPcaDjmykCx5vk/XfoNAEUJPVHM0LmmTkN+LHA7GorCZ54/ymrUIXieCNClxbryc0wJlfIgKEsIPgC5mfNKHtvnHbAL6u+CUEKvTj/a5ahhyJoQhA2yzqMKy3XKJuLxryUz3uH4ZjQKqT/BMttk/52Uj8iX7/ZUj3SfdGDzzN9Dk0PWRI0/1Y1x9Vy2Xwu5f4SuiLzWLDPxK4uYH+woB6AGTnTt9s4lm/ZzETDHkpkkhvrcIaISHd5GUP6uOgZ20j73lh3yr+cF7EjCPKZg20uXifoDuyzS42/dV2NRkxJxtjO2I6rEUVsHbjfOvJ/VzIxCEItbOjHoKWMlzootc7MrkeRi1GxXrfhlqc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65d2de89-e15f-4107-b272-08dc3183efd5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 19:49:51.6900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ho+8XLQ4E2t4jCBOYLJymlQjNTT0Y2LNWmP5Car799DyExZ/akVSkHusPxTgYpVUBrixa3G/yjPs0D5IdBIJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6852
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-19_18,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402190150
X-Proofpoint-GUID: QbtHEeEdPkXPk6rt_Hl8XiFH5-LmJYfL
X-Proofpoint-ORIG-GUID: QbtHEeEdPkXPk6rt_Hl8XiFH5-LmJYfL

Create appearing to be a clone using the mkfs.btrfs option and test if
the tempfsid is active.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2:
 Remove unnecessary function.
 Add clone group
 use $UMOUNT_PROG
 Let _cp_reflink fail on the stdout.

 tests/btrfs/313     | 55 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/313.out | 16 +++++++++++++
 2 files changed, 71 insertions(+)
 create mode 100755 tests/btrfs/313
 create mode 100644 tests/btrfs/313.out

diff --git a/tests/btrfs/313 b/tests/btrfs/313
new file mode 100755
index 000000000000..c495a770c212
--- /dev/null
+++ b/tests/btrfs/313
@@ -0,0 +1,55 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2024 Oracle.  All Rights Reserved.
+#
+# FS QA Test 313
+#
+# Functional test for the tempfsid, clone devices created using the mkfs option.
+#
+. ./common/preamble
+_begin_fstest auto quick clone tempfsid
+
+_cleanup()
+{
+	cd /
+	$UMOUNT_PROG $mnt1 > /dev/null 2>&1
+	rm -r -f $tmp.*
+	rm -r -f $mnt1
+}
+
+. ./common/filter.btrfs
+. ./common/reflink
+
+_supported_fs btrfs
+_require_cp_reflink
+_require_btrfs_sysfs_fsid
+_require_scratch_dev_pool 2
+_require_btrfs_fs_feature temp_fsid
+_require_btrfs_command inspect-internal dump-super
+_require_btrfs_mkfs_uuid_option
+
+_scratch_dev_pool_get 2
+
+mnt1=$TEST_DIR/$seq/mnt1
+mkdir -p $mnt1
+
+echo ---- clone_uuids_verify_tempfsid ----
+mkfs_clone ${SCRATCH_DEV_NAME[0]} ${SCRATCH_DEV_NAME[1]}
+
+echo Mounting original device
+_mount ${SCRATCH_DEV_NAME[0]} $SCRATCH_MNT
+check_fsid ${SCRATCH_DEV_NAME[0]}
+
+echo Mounting cloned device
+_mount ${SCRATCH_DEV_NAME[1]} $mnt1
+check_fsid ${SCRATCH_DEV_NAME[1]}
+
+$XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' $SCRATCH_MNT/foo | _filter_xfs_io
+echo cp reflink must fail
+_cp_reflink $SCRATCH_MNT/foo $mnt1/bar 2>&1 | _filter_testdir_and_scratch
+
+_scratch_dev_pool_put
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/313.out b/tests/btrfs/313.out
new file mode 100644
index 000000000000..7a089d2c29c5
--- /dev/null
+++ b/tests/btrfs/313.out
@@ -0,0 +1,16 @@
+QA output created by 313
+---- clone_uuids_verify_tempfsid ----
+Mounting original device
+On disk fsid:		FSID
+Metadata uuid:		FSID
+Temp fsid:		FSID
+Tempfsid status:	0
+Mounting cloned device
+On disk fsid:		FSID
+Metadata uuid:		FSID
+Temp fsid:		TEMPFSID
+Tempfsid status:	1
+wrote 9000/9000 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+cp reflink must fail
+cp: failed to clone 'TEST_DIR/313/mnt1/bar' from 'SCRATCH_MNT/foo': Invalid cross-device link
-- 
2.39.3


