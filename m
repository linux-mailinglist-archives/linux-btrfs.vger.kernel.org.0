Return-Path: <linux-btrfs+bounces-3402-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F77880008
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 15:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C5C71C21E4A
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 14:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FB1651B6;
	Tue, 19 Mar 2024 14:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VQqYXj2h";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="q5KvSb6P"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5CD657B5
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710860223; cv=fail; b=skL2Ch1Ay5b092Mevj9WE0c44XIXZ09HzbPBYF8Om8DszpJX9kDszoPictAhSGG5ENye+/Z/k4g55wQGRK8ojKm0Dz9xzl1n/O4QsFP5LxiT8yWhBxON4oKr5L7ZTcER/jJpWlucBOwmkATPUQirYUv1WmK/XaGK+8E5V3vh6Bo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710860223; c=relaxed/simple;
	bh=TWXmomw0F1SQM/vBUMG2u7vYz0wptc6EE6D1AblcIOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LlbfGHwJyPiUnVsyzAvnFX4z8qkdftnOBiv5iJqiG2f898afXQTLBeFW0gi4oajIxSUUWFn8GAxynlZOkjVUSjiQrt3ck6Lm4IhwX4H/n73zYtjhLnwuX4tDqKyWr4Q1wJeUPl/I2zacAzpGkG6xN9t/9e7FUkU27wKyl6+oMo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VQqYXj2h; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=q5KvSb6P; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42JAHns1005068
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:57:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=Xdbm0TVvuw7hZ9oVffHRXuHYrdRNme9J2Czw5BAfO/8=;
 b=VQqYXj2h5NcazWZYUJ0+Hx1+MT5ON0xjx+hhpwmcw9kqef1R3lqLU6aWtkHYK/IjhUav
 68fYXAIpym47x8kRm2+pcM6KmjuXIlGim13LhPnurfeDzopzGOmEL4+V/cgHuWSpbri3
 SDjyrRf1NBkp9bhlXrKsFP03rHix9ONmi/GRHB7pOVK7+MofyesLKmgnlLGPfa2CY3h7
 8/yWM2mdmTvIW5J9dfW3F5FuotrDkZ3FTEPpLGMIoNcViVxRHGxzJI3REHN8LVUvvEJw
 kx15teeHfM4PMt4xLjpcSohwBxaj5ZUPdMEvbI6QH/JtoKgBWBo98tMtdwFiGxJ22Pyb 8w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww3aadneu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:57:00 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42JEo5KE007490
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:56:59 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ww1v6cmtn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:56:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bXAn9ztWAbxf+yNpyVgAoRY5AQSKuZdPuTg8Pgqa1qRsKRdg6ItnkJ1+VXYKT0vopgpcKvekXi2/9sGYUapRoynkUceOMBaPKoj9lsKkd1hDBih0TV1SR+aNtDDb9fNFoRIu/+dLt30N6ERmHizn9in252o9qo2Folc4CAsH9eEHhgsH/eT6t4OkUtdT0vxflo0ub2mEsd0i0Dj04yFxSkhYotyykbbkjwUrmde0rawjtA0RGSVrSbK6czPB8N5tHw3Ndvvbw0k3GH+UncBvwPO5SDT3uNX5BTDqw8LfTPfqM88hWbJ246I3ftgn2zBOYxnsBwLpD0XZfGsKW/szFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xdbm0TVvuw7hZ9oVffHRXuHYrdRNme9J2Czw5BAfO/8=;
 b=IWjI8i6X+vQ0zJls5QuIM7zSNL6LhA2RgaHucs6cJ6zepd96eCMYtNHMdT3klBxW6ZfIF/xRW2QDiA93kEEDYKeNRxCr2NaHurOgWiToDBMjJtsvsunzBrJ6I5XSdB6zjjep1UxicJDDE5Qa2xL0NK6qkVA2cLlSJdCCNFvV3h0uw8x0AJLApTqliNrMu+7js1N27LRedM2piBD7dAVyK7/j0M34xxnF32gCraVhc8tgnkvjnPSJmLAAS9CSwBsJ1PL9yRqAJBghNepW6ImMdGVNrQJy0ckz2SgqVonKNScdueV3uEuOUzWtiTsQNx/h38z2nJaFv8f1e/QuvdAA5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xdbm0TVvuw7hZ9oVffHRXuHYrdRNme9J2Czw5BAfO/8=;
 b=q5KvSb6P/AV0MLpAjtzqC5Y1Z4YxQlgbVw7D0pAnGIBlRNY8uXPIvJwIaxO9jenDPl2erxlOygFYurBwn/Rjg2FVnoOSQ/d4SJBvC4+P1K64k90guuU59bm1/zfcfmBFoirC8uTqqaPrD5HvT8LXCH7bk9nd84UyOOwI3na+kkE=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH3PR10MB7460.namprd10.prod.outlook.com (2603:10b6:610:15e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28; Tue, 19 Mar
 2024 14:56:57 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 14:56:57 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 07/29] btrfs: btrfs_find_orphan_roots rename ret to ret2 and err to ret
Date: Tue, 19 Mar 2024 20:25:15 +0530
Message-ID: <a5b8d4ef4c88f3c6bb87c81e58a75e91af1053c8.1710857863.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1710857863.git.anand.jain@oracle.com>
References: <cover.1710857863.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0103.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::17) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH3PR10MB7460:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	5dwGBcdE3muXzG0Zg5w1/CGi7bqB+Zp0pGeB+CM86bNBNNVEIdDAPXj7tm55A66hi6R+JC3pVhHeQ8Ig0//UMgekhUd1hbmf4CQbAtXy+a8IJ+c96LEGfLCOASQGywC5DOujOFSDJXKZCU5n9ZBNx4lKJTcM0QtZv7TRWBGA4/3KDaxH7UzzWdqAhaleOct05FNteEtlaYXGHQOezIhcNf7rLM9cxHq/B91MNDDsTYJXo3IsSpg+mRyWceYfMVfbYVA+VlKbyRVjLjPaTJW8XWFLKFZrxvlYXi31OgTPvHcutUE8U1h5gQMqith5e8ED05jgFUnU2+gUt5LP0KY2y9JEWfbkh4lJEfOaKxxJfg/aI4ZrizrGF43ZYZY0o00yjnjBaHb2SbZl4DoKnx9NKIQccAY+5+PIZOAMx6lUtAon+eMN7WQmUoYzj7MXhfiEHM1vTNISlJw1xBoH64N+7zfQtLvw/3qn0tLOMtXnYIHHtEaRe7TsYt7ixkq2kHunneOaSXuD0cDfwPnJmkF9VXEUoeowO8GKf+0sHR4SQ2FC7SaJ2HSC9yXn4DVw3IWaYhgKgGFv8Szk3WKPWKCiXYWgC+2moYe+JK7AnK72MO8oTf0QeoLXUMTPI8JaxA4u7W4a7xaQjsQQbzMp6R7X34MIdks9FZVe3g5nUPctJjs=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?9gEiC3DW1w6wVU0XehAa8c9GCbboQyE/RRw82FpY974AVTn4ScR1eDJlH16w?=
 =?us-ascii?Q?aQd+zwh6wYQ+eBXa6+DDHr/biQqUv9gTLVnegt/2YXRGmwCLxzZI3uUtsbDR?=
 =?us-ascii?Q?SJpgtFtYgLtCsyhIn5E74VcTqaA5EMqioN5wcvWyf5BQqpyZm3mbFpL/zI/I?=
 =?us-ascii?Q?+FHj/0TenVie2nINEhYwhHCeBoYZMCf8ToiFSjP+m1s6CSTPZjjfHAGAKyXM?=
 =?us-ascii?Q?hnqIkHlqdk9/YHpw1fWXsbx4GZClS+phfo5MNc9i72r1/UhoWBy3umcZaVjZ?=
 =?us-ascii?Q?AQFwxSkdMO/e2480d5E1sTA7dyr/srQYvjIgM+nNomQBdg6vE1YR7SL3IJ5+?=
 =?us-ascii?Q?B/bXgDSuvQ+hlolXqF0wZ4dsD+ynH6V3d/Vl8O2H1jGeLjitIF2nojZB3Cn3?=
 =?us-ascii?Q?ay5qMueK23YsWt+Nv725VhGtfXkt3Ako7pHz/qT3036c74p0ulBK79p2riDJ?=
 =?us-ascii?Q?VVH29KMBqGHYdTX47I9ep6mubhq6S0FT0MIhj3Q1zTZP2+FqiQdD5yCbFmre?=
 =?us-ascii?Q?EV75/+EnB1ZmdanJXOXKUw7SwaIxWD9Vj5NFo+S0xh19BGLeXUZB8gcpml1O?=
 =?us-ascii?Q?O9UgTCDSQinFrKb6KXWuqDp/+RU1iKK1fPF7T1/1hVtbKto9ByfUIXfeeNA0?=
 =?us-ascii?Q?NBnh5sOl6Vwwzx035wfncnXOjGUiW3YaDwZ4y0mCDL0iHs7OlBWzKsyiTFzr?=
 =?us-ascii?Q?4D7lrEh0jtKzaajyylcnvOHDUMBWkuABGBRcTCfW9YWdosvwVH39J304bqWL?=
 =?us-ascii?Q?nMiuTiSnV/w6YBrySDDBQmsm+jeZHTx7NTVTZtU8zzcWsqLzOm37NsDSgtii?=
 =?us-ascii?Q?Ug95EjMy1TtNCPz32Fsm5K0cwgnmWPlScnIJfe5v7bi543XOwugGO54jWekM?=
 =?us-ascii?Q?Sl2AnIWYcYSBHd5UBlTWBm7bcgoD2KlyeCDlu1AKoqF/1EEIRsh5QVhWVRsx?=
 =?us-ascii?Q?yVBZ01l4EDiArcwIjPpBx42PNMLKj7R8ywSxJXCcQQ/C3de/tXYrulREsKVT?=
 =?us-ascii?Q?y840p2jnCSo1jU39Z7evMleN2ZSVhlm+FnSZsqODGKPs6qU3AAt0akcCp0Vs?=
 =?us-ascii?Q?RAqcBjRS1EGByUMPiHlVfXQS/n6XpqHY8bzkrRYwqSGd2XyqficHtodpmd+F?=
 =?us-ascii?Q?/VoaLb6tcDrjZuvZGWTj9dn31qF0crSYg0S7CpkXvQ3ImVM/WyfCmfupDAnt?=
 =?us-ascii?Q?ID2Pw4ydh5lioNuuFDdbMOQOAFepO5MZZQYVIe5A5TtJoV3sQ530yApj8jJ+?=
 =?us-ascii?Q?PFtntBFo/eGkOmSZ5g/nYzopJaB+ccbeFr8dOXM3aiu80GQM7lKGJVnE+yAu?=
 =?us-ascii?Q?OAu8qlzTTho0aZeyJVY3eF/Ak5R7VQcWD14R4Jzl16C2jDf6h0Db7xEIHXmL?=
 =?us-ascii?Q?PLTAzW+SQPV9sEGj58YI8zXPcJ7P62Jb1ZpvwD195/LktR3q2gStsDmup5hi?=
 =?us-ascii?Q?+oA2rdP9F2YlsoF+ucrG1uUnT1+YEaTkw6g+JUHR6x9v8TitBYKiNbRa3u0Y?=
 =?us-ascii?Q?p6gcnbY/ec11qqbkTmOaA2d7LVvSkG6KAN+PhQJi3TXOJWuLJfap2uLG6wOl?=
 =?us-ascii?Q?0WfLyXKuPLv6A+XJuRUtUBb6oq8lBI4ajO4QEVtkrQIutkmssliG+kIGF0Nu?=
 =?us-ascii?Q?OLRvcEq6FBRvV+YuwktRVdiv+hzxBkZPbdUUEGcNOxrC?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	rUHS0wCvtY4pI/IHZKlmGJQ/hGOcouLcs8twXKoYbcAnJkbRkuIYaeK8zy73fJYiL/pa6SFdRF94gPNsls9EzB2mHCHN8ByLXkzcD5IF1r6Cp5+a2XTf95Mk6PeD5KR1B8YvQ4fKiPp6zwTyuEJZSo2a44JpV1L/hWankeZKV7ftHnmHLmd/XpsChPIbjzYXJg8PjJSTi7mhghO1CRkOkLUV45NVR1yegl/jOm2JyHNvZo4XOtk/EVeVtw1i5VH7yhErJoNII5DdVxMuKBWFPjcMc5OkyxzzHB6jpCEBeCDw9JBc5/J+vJLBJjoh7oNtMzhG2SwzjBkz+S4MtrrtnsBR8YTajc/8n8iOJ3EqE2sPnrcpH+fn5rXwuxLz7x/Wh2tSDN9Obt1JoOvnWgp1nzJVa2wdOIeM2zFYcdXooZpUmcEsp0DUqfxpNj+7TC0+2l0sG8vzKSIWTQD6r7+4gI1QYvS/vSvIrO9A92uPrMhD/TUAGBcZ/TvbDVywvoDbrPlC8OM1h7f6jZmkdIoLbsH3Sw6Zgz7ebqm/Pth3Vt/pQgBRZ+95xj8QxeoB0UG/yDDkDJA87VN2T+Fxaq+woc4Qj4LNsximWpyr8nendLY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64154b6c-6879-4153-f39e-08dc4824d2e7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 14:56:57.5884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /eQGk5OE1oOUgPz3P3fLEnws0CUg9SOzDh392T1ib2XPkgL+FFWDUBZZB0mnrcKtJ2hzbgf8WDFkWxRCpqxkhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7460
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_04,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403190113
X-Proofpoint-ORIG-GUID: JS-pFTmkxn4qQOrPYnugJihXFxk3BaP7
X-Proofpoint-GUID: JS-pFTmkxn4qQOrPYnugJihXFxk3BaP7

Variable err is the actual return value of this function, and variable ret
is a helper variable for err. So, rename them to ret and ret2 respectively.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/root-tree.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
index 4bb538a372ce..869b50f05f39 100644
--- a/fs/btrfs/root-tree.c
+++ b/fs/btrfs/root-tree.c
@@ -221,8 +221,8 @@ int btrfs_find_orphan_roots(struct btrfs_fs_info *fs_info)
 	struct btrfs_path *path;
 	struct btrfs_key key;
 	struct btrfs_root *root;
-	int err = 0;
-	int ret;
+	int ret = 0;
+	int ret2;
 
 	path = btrfs_alloc_path();
 	if (!path)
@@ -235,18 +235,18 @@ int btrfs_find_orphan_roots(struct btrfs_fs_info *fs_info)
 	while (1) {
 		u64 root_objectid;
 
-		ret = btrfs_search_slot(NULL, tree_root, &key, path, 0, 0);
-		if (ret < 0) {
-			err = ret;
+		ret2 = btrfs_search_slot(NULL, tree_root, &key, path, 0, 0);
+		if (ret2 < 0) {
+			ret = ret2;
 			break;
 		}
 
 		leaf = path->nodes[0];
 		if (path->slots[0] >= btrfs_header_nritems(leaf)) {
-			ret = btrfs_next_leaf(tree_root, path);
-			if (ret < 0)
-				err = ret;
-			if (ret != 0)
+			ret2 = btrfs_next_leaf(tree_root, path);
+			if (ret2 < 0)
+				ret = ret2;
+			if (ret2 != 0)
 				break;
 			leaf = path->nodes[0];
 		}
@@ -262,26 +262,26 @@ int btrfs_find_orphan_roots(struct btrfs_fs_info *fs_info)
 		key.offset++;
 
 		root = btrfs_get_fs_root(fs_info, root_objectid, false);
-		err = PTR_ERR_OR_ZERO(root);
-		if (err && err != -ENOENT) {
+		ret = PTR_ERR_OR_ZERO(root);
+		if (ret && ret != -ENOENT) {
 			break;
-		} else if (err == -ENOENT) {
+		} else if (ret == -ENOENT) {
 			struct btrfs_trans_handle *trans;
 
 			btrfs_release_path(path);
 
 			trans = btrfs_join_transaction(tree_root);
 			if (IS_ERR(trans)) {
-				err = PTR_ERR(trans);
-				btrfs_handle_fs_error(fs_info, err,
+				ret = PTR_ERR(trans);
+				btrfs_handle_fs_error(fs_info, ret,
 					    "Failed to start trans to delete orphan item");
 				break;
 			}
-			err = btrfs_del_orphan_item(trans, tree_root,
+			ret = btrfs_del_orphan_item(trans, tree_root,
 						    root_objectid);
 			btrfs_end_transaction(trans);
-			if (err) {
-				btrfs_handle_fs_error(fs_info, err,
+			if (ret) {
+				btrfs_handle_fs_error(fs_info, ret,
 					    "Failed to delete root orphan item");
 				break;
 			}
@@ -312,7 +312,7 @@ int btrfs_find_orphan_roots(struct btrfs_fs_info *fs_info)
 	}
 
 	btrfs_free_path(path);
-	return err;
+	return ret;
 }
 
 /* drop the root item for 'key' from the tree root */
-- 
2.38.1


