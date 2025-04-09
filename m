Return-Path: <linux-btrfs+bounces-12903-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76AC6A81E8D
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Apr 2025 09:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BFEF1B87DF6
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Apr 2025 07:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38E525B678;
	Wed,  9 Apr 2025 07:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WNUEZyEG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bQ7oblPl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6223525A622;
	Wed,  9 Apr 2025 07:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744184695; cv=fail; b=RP9vIJtvtAnp1xub5D9JD7SLiYjTpyLTmy737tneoCivw7e62WxOkUQaVa7vaqys22fJ/rKq1enpbGp+t5uN1I623l1RXW5D+uXLEtw1Xfvw+Pd++82xu1exfGzI3gLbHVPOD7AK38Kq8li+1R+Ko+aBNBsgKFz7YvHLHclD6hI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744184695; c=relaxed/simple;
	bh=ITwRO85YMxWPexaz3w5F1h5X/PCAOpHyWF0P62O9SNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T0BdMpuLR3czSZn6qK6RhoMycr4otQ2isKnMNkDHx3SP9+UaBv8V5dElxbSm/JEu+hRIlRJR8OMvNTs/bOVGKshu3jFe6AS9fvfuLc4M+NGcq5wSujnw9cu9MGwH+MJxS4M9Ft4rWfdmnUGhOTE3XGakNZxc8Okg8cArds9I1Gs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WNUEZyEG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bQ7oblPl; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 538L9n5Z020834;
	Wed, 9 Apr 2025 07:44:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=3lTaeDwKnZjeI3gnbpDCcWOEVmtAhvIvUOYTbwp2GEA=; b=
	WNUEZyEGkDt/ED8q3+yTNvJ+0SmC5DLpTsRIbKIyjpF2yvgetHyXyUu/Ii/OFtIC
	4D92CQEGCPluvbLpoNQK7gjwca3/En4z6xPVGZjL4+2Y2QvT+bzjAD4rOKmvHhxb
	YwWUoc8DkbLzQWyv8nxoG5ExL8lyvg5U829/Kegl7na3mUnZPN0+sbbVLK2c6y/a
	74n2B7Zq7XjBK5YnD1P9EGmpFWat5FulpRHBEF8lTYEqY2/LpgtPLa1Ufooc5Nlm
	EP8SPYuUMV0gl/cjIELL0fPabuWTJeq7Z/oawTc71tulomyv12N2WoPxJ2uo9qKm
	+YHEA/F+rDlc8nWxwhHDmQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45tua2xfex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Apr 2025 07:44:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5396GTv6016476;
	Wed, 9 Apr 2025 07:44:47 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17013077.outbound.protection.outlook.com [40.93.6.77])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45ttyaebj4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Apr 2025 07:44:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BLnfMwFb/3OzAT7x3XZQjJNeSgddkBDhLOu2OKYao60mKmHIpcq4XsliuTX+iJDUE6OTPnHP0Z3EnhmeBhuu4QKv1HP9ww3Gc+ng0+FyhYNcQ5BUl3uRVcwNM/a+IqaJgWIoVnvbWr8IwclAZd6O/VkCSKhgn7gNqkbSW0virZ9irylxt1CwFx8IeVWUOWnUtISJQpC9vwsGvlAUV+/nhTL4hhGcmrW0WA+0rlNx5brdI3oRRs1gYNISnQvTufvZKMZUjzthWZddv3WJ/k83T3HtaEYqxMWGUTI5YM5eiSifaYocf6FcrFyFCM0rcG25yg0+47gtp5cmixwoe6JkSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3lTaeDwKnZjeI3gnbpDCcWOEVmtAhvIvUOYTbwp2GEA=;
 b=HUtxvgpTPj5U3gJ6fRtvQgpugrkPpCPtEgtcl9fx5oqWOqC4IJo56BLKLnh+P23VOOm7ExYig6ACsDRkxm4WDwesa1IuqNqC2LzB60FgEYeWK2HC8sI0Ff955z4zcqmc561XTURebUwW0cwEPwFQaMmMrzdS6lzzITYeUjmpMFw+OcCJhkC/cS4470Rgllss82+A70jLyUE6ynC5+w7lhqxMo8gSYg+/CpTR12p39tW7/Vcc1FMfmXl0pYWfIf6zdfVfh27s1/QgAkBtv2cbBNMcw15MfIoWuJW8l9ANquRi811TrwcZq+38zgbvEQYlSMZLJP36f5ApslCdpN1aVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3lTaeDwKnZjeI3gnbpDCcWOEVmtAhvIvUOYTbwp2GEA=;
 b=bQ7oblPlR/sTp4F0r/YN5/O3PJrBeOCCoUeN/jH/MfBbY8tLamAwB5PDorjte3KNKA09/okhu2f0d14Nnu0NUeZT6180NlMLUrz/aWpSoui15KKFhzjLDnvke4ZpnZ54OlTNjDnLzkCC4/01EC7r+aELRl3TlUJHutrdclG0SV4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM6PR10MB4393.namprd10.prod.outlook.com (2603:10b6:5:223::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Wed, 9 Apr
 2025 07:44:46 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8606.027; Wed, 9 Apr 2025
 07:44:46 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, zlang@redhat.com, djwong@kernel.org
Subject: [PATCH v6 6/6] fstests: btrfs: testcase for sysfs chunk_size attribute validation
Date: Wed,  9 Apr 2025 15:43:18 +0800
Message-ID: <a53aa65a639bd7906c28418bee14ee4d006700e4.1744183008.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1744183008.git.anand.jain@oracle.com>
References: <cover.1744183008.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:4:197::10) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DM6PR10MB4393:EE_
X-MS-Office365-Filtering-Correlation-Id: da3a32a6-fd2f-4766-8bd0-08dd773a65d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KRPSTtuKLaqGmblryGQgkS1G363X0VRF6IkHgIlsgshdNmzClc3FXRhiOgvI?=
 =?us-ascii?Q?zzgVM3BQWeBXRIqNVh/ha0EFerrytEBlB/cKD5G47xxn6uTEqYzluJnVbExj?=
 =?us-ascii?Q?eXwnXIXy2RHHNsHJgj8C2Nwq8/sTZnYthYa/Zgrs6kN/t0x/6kLRqBT8i58m?=
 =?us-ascii?Q?4/jSoQ1tlQf7RA6u5/2qMaziTSI8wXd2FCNq7LRxLlhRa/CcWlXm1O6OltBi?=
 =?us-ascii?Q?gF/4SKE7iOg4W/Hoj1yWFNJ4bWq9vAoncpfCKRP3CSqppUIbF8aLbR+Q2PqN?=
 =?us-ascii?Q?vN9vkPAVMxwd1K52/1qBslW7IPx5ZGW9Mzaf0b9AGh5sOO4GdBSLZjK0ukqk?=
 =?us-ascii?Q?VAsMFORXDXbi6iSGbdr+pP0jLn3XivVdo5uYfM6wL2WZBxvf/CPIgTkIanmi?=
 =?us-ascii?Q?BQ3gXOezxLjdfEsny7pttb0E1b3r4XpZB6T7zmxTu7FBfn0pq0w9E/ykxQ/q?=
 =?us-ascii?Q?NHOI5jaEBqsbxL0ATPcWyVvopE+OcO4I6nl6AHf3mZkjKnTFLUklqASXVYeV?=
 =?us-ascii?Q?zty1kp6lXgBItmsTU1femR7Rbkp6nVjav1ddAQcPqCPhCUs9NJReD1Fhoiv+?=
 =?us-ascii?Q?9ZXz6eqYrUagU/UnAI1ekztDJkfdWJDSXc7E6XtC/eUGNR13y21MQtIj5Utp?=
 =?us-ascii?Q?Rcd4549zyQlL+YmV7YQP39ar8VUALk5SDgeEF26V7UCFn4bjwV3N3O6C2qGv?=
 =?us-ascii?Q?nkkGX2eifm3jd1geLAcE0kwh/JP6NWDZV3B3hzWg9XpqdOuewTVWoRWNf/Z+?=
 =?us-ascii?Q?U/DySgOt7EGPpcrkEtr3zn8H4L15BD8TpU9K1JtkC1ZCbWkh1UKCwzLvDwMF?=
 =?us-ascii?Q?d0M5LE+5JBpnaZ+l6z8AXG4twesROJWH957r4Nwdi89lG208zbE0NqmFyfzz?=
 =?us-ascii?Q?XsSwtfoNm53WO27yLFtqHJOAOtPine1+J4csyiIzTAc26lItlxHv6VjtbAMF?=
 =?us-ascii?Q?M60K9sBQszt5g79FbsXDDaTdyrF2P9ufpT3yaSRdAZhOFpfSXmvTQxtTNiHR?=
 =?us-ascii?Q?Z0ccDk3G2Zv/dzJGYw5CFZfeoBobzqfaEUZSCzcuU64qnaOtAj6bz+vdnjpt?=
 =?us-ascii?Q?weX6XAmmHwEyF0r5N0cmKpWQENELdlrUKjLYXep5Y3sSCbTeF+MOHVote4x9?=
 =?us-ascii?Q?gQifvwmmZ71xVaLx9U36oge/YUbGH8xUkhdR6lJvwqOIp+OH6sgKFQVE4c//?=
 =?us-ascii?Q?G1J7myy8pxc0Uy+GIGSuCU044mwhmTsXauhvahSK4h13xceYvwL/WVDEutP7?=
 =?us-ascii?Q?Aq5mv9m90eScefaIId6v3SUW+AfVH/6PN/BjHWZ2RGUduvo61sK2b7DW5V41?=
 =?us-ascii?Q?OAk53Gd8/iVk5CMI+EIOclTiY4iJ7OfUL6HTcCgdIeseuJF914Zl+Znlfj2x?=
 =?us-ascii?Q?jFcCzhwMhe5VoOJIw0sg+V0NJssQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SllfF8bhKb5DpqICMLpJaMM5U3NKEliMpXtDmgF50o08ZU+g2lepIx7Xs7g7?=
 =?us-ascii?Q?A8PoDl5NiB9w609IqZdKpFL3P5FiAwEFegRZupYk2WMp43E4r1BmKu3pfYOx?=
 =?us-ascii?Q?0dUv3PHye7g2i7lZBVPqWF2h/wLpCru+XPEBwKQPVajN6unRGV7N0dSBLHRD?=
 =?us-ascii?Q?g5mwtCbmKmWspGn5oct4u2UV+H9PIOI71Kna5VP6n7XCjb9K7visRoIsoUnk?=
 =?us-ascii?Q?IRGu08+lIgF5PAo5sXKvf4/RLc3SkNq+2/ODDeQdBHlmP5FL1A1P0BU2al45?=
 =?us-ascii?Q?F+scWb3F9K60vImooqdujG0fvASzx539yvrTsM4XCaeu9ysI+Bb/wvSBJ1Cq?=
 =?us-ascii?Q?BKtVQbo7Aycvzj384vVfxod2U+Ajveri/sSYrhH/jKHVMb6iXadn4vTc4kCZ?=
 =?us-ascii?Q?Zh69m4eGFJs6JSQzgabN1kLDg4goZ1MvqexW8eHLt1xvRK4hoST955+RA7kN?=
 =?us-ascii?Q?WNicaQ8JLtF/0VbncY1xuJkG2w3iI8yQd4DaTgCMgNWHS7BncRiVczEVwYKi?=
 =?us-ascii?Q?rL286UFMvYD7YAeeF4gZKK83hEtfN5Zmb8zjStBdbTdG8w6AbDN7u2jQZSgY?=
 =?us-ascii?Q?RUqj2pMTUovDHkMN78xIwzzFQcXRo8vYrptwQwQUeEI8z58xrpyTbxzDESgD?=
 =?us-ascii?Q?LoGNBweQ7R2zIKSjQvjJ6pHwkAdFFpZ6EIvoL1y7aH9XbVHtmQfMZ+T+X1Oz?=
 =?us-ascii?Q?TNrL/NJ9DdXgpcdPyI99+klJjZhcTNEG+4bPkejKyLHTcFOidPZJnExJDmjd?=
 =?us-ascii?Q?/t7VOY/Ku9mXvUfSeE4+X5//ht6oHgv4lON9KxBseNP/C8OFJK1F4l4fY4oE?=
 =?us-ascii?Q?LM+54Oa2QCbXj4djg3ZO/5LW4ylTgXGKz1LuYf7rvqxFbl7ZMmKSEsRsvTtw?=
 =?us-ascii?Q?Ogbmi+vtc45GgMlnNifmGPSkYWtGgLTQlslYMNrB2tEGsRp7WuKD7X0tpe7Y?=
 =?us-ascii?Q?GDodgsJcCjHP6UfcTclx996dlQSYJJrep0ipK7VkYT+xwvLtki8WFBJgzRq9?=
 =?us-ascii?Q?NOqQ4L/mC9f0f69P/Xqwp7b2AZ5go8I9nKrXVnkJZ3n0FA8zfpyrKCwuEr5n?=
 =?us-ascii?Q?SCZ8R3ApDV3+cGivCNx1r4hLgXR4/NAP1XVp5wMKA2HDYtKtO+bgCIW84Dao?=
 =?us-ascii?Q?lvpkGXU6R66pDrwS62U6mVi6iw539zRf0ptSvSet/V0y8EYbiGSMrKwnw3p0?=
 =?us-ascii?Q?sLbJApYjlVNvCjRSE+uEqnX46XjZaq11g4ypcTJ/1UZhIDNmtcLy7PXoKNfw?=
 =?us-ascii?Q?YEQsF1WD3TKRoXzTABDV/k24xm5ieUhFyt6enUIdtYgJ/t0w7I2ggVbCRB1C?=
 =?us-ascii?Q?94yH+DBv9Fi+idU0tonu08iyZiE8IaS+QaMCTEwNA1yJtUWERbJZcNBF7263?=
 =?us-ascii?Q?knJed9LXQRx5o1icqGfj2tLMv0eAlngJd4cm82PupB+rNzV3iXklmiFhkoBv?=
 =?us-ascii?Q?fwtEaFuFgsblGwTFVJ3RK3HWxyIPSeAMrjwVs5qVrUV9JiYZddZqTdZG617+?=
 =?us-ascii?Q?13jYu5rpm2oor9i8F766PB+sWqXdI3DdNvz66RrvH4RE9r/ocNhIXVnE4L09?=
 =?us-ascii?Q?rQJ5gW1dXQMmer06BtkGrjVanVJp+wNRagP2KlUa?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	h7KM/JweShSKvIcRHGG5cYm4q/51Ak+lfIG1nuNcuLf1ZZGlSinN3m/jettQiOTsKU6UMbCe+lfLhCKuEhx6CVp/EJIaTRV36+Ta/6fTNd3DlKvhGba6c6hZK1UszBI4j+l+Z699L9B4Ai4jXZRaTz+cT45sgQ5W1S9nHr3mzBYrROOrZh/O11JUE8zv0r6Lxt2bwNzrCoUodn/TXfkXX5bU2OmOci6i9XmmIQOyABgwve62JEV4ODuxBncHRKKM8oRaJb5Sj90Phh/AVfbCsspgfJ6shVUfSEi3LN1DbE1Aickn3cWh6I2qiYMLUbQhAHPi3vCsBGhONqKUgrAbJVbWXy9N1SA4O0nv2vG7K/CNLuyhoFSTVb3uvnWkYkOCHTpPrsDH42BidPF5WAiBsZUAAMSxPkeyWYbHh61Z3yRfzi+LhsIl55AZ2/jejbjujOBs2fbzTpCPwrIQavi8gz6GQHPHOv7s3eBA+L+JYp6Cav4yoloa1jqEHskfzG8Q5fKUf1BidWoOzRCdfQCxFxPI+Z36KBmO8LaUawTWZ4tLJTdNQ1zuNPtlVowQ5m9dxoAB6QQGN2XNJBtGnNEMI4S05ewXvR5xs3QZ5yP5fkA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da3a32a6-fd2f-4766-8bd0-08dd773a65d5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 07:44:45.9804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WSs4kartQ0xeeJ9UIsmkMN1xSFbDPVnwTujnmwiBiYWkwLymDU5EuyyJs645Q1l8RTHOBa/gZAdSPjOxw5+cvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4393
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_02,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504090035
X-Proofpoint-GUID: PFa5JqMa6YTY48loOwpJwP-gXYlvJZnr
X-Proofpoint-ORIG-GUID: PFa5JqMa6YTY48loOwpJwP-gXYlvJZnr

Checks if the sysfs attribute sanitizes arguments and verifies
input syntax allocation/data/chunk_size.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/btrfs/334     | 21 +++++++++++++++++++++
 tests/btrfs/334.out | 14 ++++++++++++++
 2 files changed, 35 insertions(+)
 create mode 100755 tests/btrfs/334
 create mode 100644 tests/btrfs/334.out

diff --git a/tests/btrfs/334 b/tests/btrfs/334
new file mode 100755
index 000000000000..d81ec921f1f2
--- /dev/null
+++ b/tests/btrfs/334
@@ -0,0 +1,21 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 Oracle.  All Rights Reserved.
+#
+# FS QA Test 334
+#
+# Verify sysfs knob input syntax for allocation/data/chunk_size
+#
+. ./common/preamble
+_begin_fstest auto quick
+
+. ./common/sysfs
+. ./common/filter
+
+_require_test
+_require_fs_sysfs_attr $TEST_DEV allocation/data/chunk_size
+
+_verify_sysfs_syntax $TEST_DEV allocation/data/chunk_size 256m
+
+status=0
+exit
diff --git a/tests/btrfs/334.out b/tests/btrfs/334.out
new file mode 100644
index 000000000000..f64f9ac09499
--- /dev/null
+++ b/tests/btrfs/334.out
@@ -0,0 +1,14 @@
+QA output created by 334
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
-- 
2.47.0


