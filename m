Return-Path: <linux-btrfs+bounces-3283-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C2287BB71
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 11:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CF801F21622
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 10:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02115DF26;
	Thu, 14 Mar 2024 10:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Vm0Atvy4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="F4FrEC8s"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E68C1A38FC;
	Thu, 14 Mar 2024 10:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710412715; cv=fail; b=D0MtG+2xCWhAW2wh8StlmGmwMPACRSr11Awu8WlocCiFIBukfZHn86enm6TT7J2bhT8e+9g1x0UVqXn2L6/mV7Fdn21TVHoLq4iW5x4QUbYZDcCcBhBUKYiooHwcVc2RiUJerH4Jtn1c67fx19RvhWea4KXUQ3YPg+jJEjirRS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710412715; c=relaxed/simple;
	bh=xHQksDvOrVJxSggjk3UGN/CZTl/OCGQCyQ4NxZgj+vk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LD/XEH6yFHglfOtsDBTnTLM9mm6JP6FoFxIVTS4oElEj23iVgWo+AcH/843WUkcE3LZ87xCRp1dOx6O4gChNnKu7vOMv6hyPSWC0hYd418jZYS6shsOzRN3Ix/fDhWoMdUv2Ba9u9ZKbh/QTQH3cywwcAAlYHKFeTOF6bKJn6Z8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Vm0Atvy4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=F4FrEC8s; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42E7nYas012776;
	Thu, 14 Mar 2024 10:38:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=4A7L936WEHl3BkoqFC9dtLiQI2u8LK782v1ZwTZwPi0=;
 b=Vm0Atvy4c6czWBFMBfo/F7EvdSEDF/Eu70Tt8+MhCMu2vBrqM7Fx9mrWV3XLgIDZVMrC
 M5XxsiyixXxGgRF/CmYS+CoVnEnupmW+tIDp52pWuNXOIMXLcdQh1KlMj08dw1MugTfP
 U8vOR5oL6KPK7aXybs31foMyu02dAY5g+467wKIOpbB4kdRsnlMH2Jx+Tf8PBTK0JqiT
 RityzKJOb+VgUlCqtSWHy8q0QxKpPVQAjYFx5wa6oL13M4AfcUBGTYwUoSL4UTIz6wiu
 w0zpEaE2uJWN0AaE3gRHLmEe9pTwsMBdUST7CS2UPMJpZjaV7eaPQmyWGyTLOvHaf9Yd tQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrepd32jx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Mar 2024 10:38:28 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42EAQacA009124;
	Thu, 14 Mar 2024 10:38:27 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wre7gdvag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Mar 2024 10:38:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WwjyfYEOqB3sBrIn5/Vx8CZaKBQe13eTU91IbyDIGKAJshIgELj2E/cAhXzvdcHnZg0bMzvux8BRuDuurAB6+VjpOvRy22qDJ3CZcREO6uUkvsfewcDN7As62uwddt19AbW1NkPzH5VddMzCTopW8rnTu/UgOhv2cVr4mkXcxbpMhXnFsgeQCz7SSjQ51+XbD5beGio4OmP6Nhax4j1CY9VpSyFfQCCwgIDFWYaBl8u5nLwLvbbplK4Vlm0GQU8CqetFB6BAA9cqsHRdYW+BtHf8ID/lJkGaqgzwM+gL7WEGVa2pDX/k10/hh1q4ejSw6Pa1XQU2NyCkCsQ6HUZMxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4A7L936WEHl3BkoqFC9dtLiQI2u8LK782v1ZwTZwPi0=;
 b=oTGsMQVsSrUL+cf144y+fB1eIcZ64wwOb3fTFF3ACg8rHqhSNM5XAICmBF7FZ7aO9gj9FhYl39WVl1uIfmVIDj4tXhpt11cGfppJHj1rFz4EWLaqrNPPMmTyJuNFpQT9DUd5fSJKmeflzkDIQAtHYaDcU2ZlzKJoncG1CO8YzuEiG0UhUaOAYZ866Dyw9z7+nqr4yCqCdJd1Z9Q4xcT7n2SVPhEGawsaTkyM/BebOa5V2oovuNQ3ewE4UOf7hKbwCRGOykDCYRECrw1Vih/GBbpFI4gKkUFeQp5boQwOUc1CUGG6fOOuwSsGpHM67onDlVABtDuyIEip/gYEl/rVEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4A7L936WEHl3BkoqFC9dtLiQI2u8LK782v1ZwTZwPi0=;
 b=F4FrEC8s0mghkp1U3+Lz1G+SlFiEMJC0fiY7IpPH9GjKOzr65V+p4iU8b0UaNOSPs5dGYlWbAanDqC1K8gI22uRupAomgzWZ0hNM/YHZ1uLazZGYcfEJh/eoPbLABcjQqOfa8GipBHpYEPiVoyO1j61L7bWQG7/qDMMi5Ar9SKc=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SN7PR10MB6617.namprd10.prod.outlook.com (2603:10b6:806:2ac::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20; Thu, 14 Mar
 2024 10:38:25 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7362.035; Thu, 14 Mar 2024
 10:38:25 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, boris@bur.io
Subject: [PATCH v2 3/4] btrfs/277: specify protocol version 3 for verity send
Date: Thu, 14 Mar 2024 16:07:39 +0530
Message-ID: <d7a84dd718842719a7f0c59f5b73eb4be12109da.1710411934.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1710411934.git.anand.jain@oracle.com>
References: <cover.1710411934.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN3PR01CA0043.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::19) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SN7PR10MB6617:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ff2fa10-96df-46c6-7ab6-08dc4412e0c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Vk49n9UDnGHmzqU1pPuKwCJ3g5pqlozVbdQwwBjLKbhtjKx576hxU6o3zNQs3VPPvzVB7AreCwD/wOBYlcgfJO+huRXKEow7UGkxbG1pQSH7uEAe32t6GdMpGOHCWOhO/3SR+7RFJ/EJYnwP67w4ALFwlosD/x3Vkrjxrj5OVxMgA+8b3DS2tUr99bty6kt+wFDQMGWVW8JCJkIH3d3SlSpk1D8zCIPCDh5d11bCJ3+NhfXa/c72h9zZYb50zwnPTJvbD+aACnsv6bZdiITxGW/y8gFV7fdMYDkbUii4frbOM9vvrirFWAweNbdks7GRcFQgOACkRijVkka3KFcBw/4SrpUOKOTz9IUuetm/wsAZ6/3o6rFDoeo1mfMnVCLXGm2bIdnoDxU2/lDJw/qP8mtHPi103chPeS/Y8q9cstYwCdQnLAhMmjYFWZ2LGE0Rc14rTl0tK9gafJXV3ui6hJm2LGQeoxiG9xMhlaRwF0kbBBzihP/phxfQ/4h8E8BuTSBSovMCv20B3uGrGcZlEpCvntw+7MMxP5+DoASfQ9H8QNbIzJ40UFB46R/oiYlfQzUbi11w3LSPvVk5NTsgYQheGe51KN31nIQpaJZ4qbByiea/qfGSkfBq3EG5ziwPuvkEZzo7iFU1x+onFWwzENOUi++i+/IkDrHScRhUP+M=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?BREJj4JoO7y/b4eq+5xntMkxmWgYxxnBShznq/vnlaE/Ghe/hQfpX0ofo53Z?=
 =?us-ascii?Q?HqoJ1vS3FFhZ6Xjl1VlV6vnbASyUWHqhn8N8aqlZRj7XV8P8Edn4KNC9Oorv?=
 =?us-ascii?Q?1n18EGpphkdmYy2s+bmPdWHgbDkejO5aKYMbEAjB/bNOpakafp6EbR6TBCoJ?=
 =?us-ascii?Q?RasxNofxtjtVscka7/1kdbW2Shr8gwfLA0zTa0nzZFR881P5Myxnq35eRkzC?=
 =?us-ascii?Q?hRZxTVQiBR9Bki06x2FnOTEgnWNYd7wf1rEieo72CTTJrDcSv3mL8aLFnVPT?=
 =?us-ascii?Q?dp1h0c/ijHYVAzfdMMahoSTHUjYD+B+r0zyk65oz89AiRQEExU95a7mKa3LC?=
 =?us-ascii?Q?gT3VHKAiewRBEZ8IXom4Z4Np4u/rqym8ls0zxJzxrB9dGoXEQSvlUjgx4GDM?=
 =?us-ascii?Q?KhDyz2JgA8X4pPPyoJwNwRq4zUYYNUuawtJdn1MVfpwQkzlzbMvF9FnTXV6i?=
 =?us-ascii?Q?4WqRBD95HKVCvNlZdBuTSIm6bO4pVrmVX9LS0rxmZZ9KYrqo5xMkORj/WlFK?=
 =?us-ascii?Q?gohkBfH304a678R5kpHbEaGJQw2glMoKVN7pP8YtHBwbUZ/SKEI1807TzdM/?=
 =?us-ascii?Q?3Z5Smm8dKF6BcejI18zItHBmqbnfisLUOmyNC779shQiNtPWrOwbg5XXlO5x?=
 =?us-ascii?Q?lQZlR/9UzcR5f8ztsfd5FoXRAtwye/DdvlAFXLNHL76JW15HU9TWN7y7K1Op?=
 =?us-ascii?Q?AIMndkZ7Dt0iqQe4uM2Sa3sgO4PNIOHkQeaMUhFksqwGmlKTnwrIWP+QumQP?=
 =?us-ascii?Q?dcJnpCMyaGhzA5SMdtmlH6elTdbaCSEEPbWWKyTfqbpCIE7jfM60Cf96YUGg?=
 =?us-ascii?Q?ZEIZLp9wuLfrdIE6JOq6UEA+fSj15Pb5quejEMXacRWXQMpSF8QSNLQjpNsu?=
 =?us-ascii?Q?5EBALXzReakpMpvJJuQJPdCoqgczMV93K7wiiid2fDvKGZ/Sie6ShWu56XLZ?=
 =?us-ascii?Q?/Mv4d6MXAHfQ9BOkYYMs+mXfH45HXdsaLUyp83/DO6vG9qX+VPLGlec1WPxe?=
 =?us-ascii?Q?eTSfWmfKGmWltMWAW5zXbpQsTqlE3MNTVoAxhj9ZqTSeEJsOdOkZ2O7dmjVO?=
 =?us-ascii?Q?daLli4wCpNQrKpTur4flJ+WWtOXfyOe6k0kqnQyso4InqncU/ykA+Pb7ZYrw?=
 =?us-ascii?Q?bqyojWCQrCJXfBzLb/kViTlDD0ju+5pLmgXHfqPMUp43MPMM9sA2aEdJu7fz?=
 =?us-ascii?Q?sUd8R+NHXfYTTo+12Y+75zKrwznSJJ6e/D/ljYo+S4RJky/ZAXlXmboSgIBO?=
 =?us-ascii?Q?QI2iLWI8FwUhGDf0wspRIJ/iF7RneFgBTBa4AJwWrLPL+MKGDW6YTTbGkGg+?=
 =?us-ascii?Q?7mSxB5ZEJEAq4nZemrPcpQM+QAU91LWzav1LIQWNa0qOTGtOKGWurmEI5kkR?=
 =?us-ascii?Q?5Cz753vZ+O0Ug7mtKzJFiFl+hdzwtd2sGxYkKRF2jJWix312GWebgK3MY5ff?=
 =?us-ascii?Q?Kfh6rvh3dpo2VUX3M9vnLuvVVsdjoWS7NVVMLxC+BaKrsCe2al95p3YYKmps?=
 =?us-ascii?Q?7JQ2HbvCKOzj0OQEgBjSEskC0PfBqC7Tc7dtDrHDKjne/6m0qQlKjXVsls12?=
 =?us-ascii?Q?jLYdIHrSi6lCMIzTT9bSMcDLomy9G4UGXriD7uWm?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	G/zG805s6DDtDtx3f9S/rAEk7/YkHcctjJVYDJi4wP8gg6PqT1FgJRE/s4XrRHw0dkgkRBORKnh3WORhFlwldvnllnOkDQISyBxzScPTSCiDKrm3FTZ8PuWtz6OyNRCWJV7a1yAd0u4eOkzeta9Qp9FYBCJGEyP8Nt00UHuqaSpEXV3tebzC9ctsNMm71dhvoz3tjmAUTTd9MYkgyOuRIbp4x1cso7KHoAZK1uUlviahXoBwb686s2rQ0WdmS4Mr8Bv2dqOV80ycNfur2p5BHoq51sjnhNP8BXdHmqHfQ/v5NxlLV/hJygLZS578gnC+yBAq4MeXW7WZJfFAk3m/DSt1QxRPJoVlEb+hy4xfPGJtGEUu2WLCv+XWb4Ig8zOHp9e+8VtGwLBwcu7CqAIT67yLH5cd6WUuiXd0HOSQ867C4sx9TSinGs5fwvl8wSCY94l89pf0XGuXPh64VkN930k2t2HmXjZekEy8pnUoLmnnbYWyeh0KRxQ5br0544iKM+mrYg8Vnbxfj5n54YeMVAh7hi1Gj0Dj4ZIcVAReCwGnQGxKDOM8mO7SXREsjHkm2stO48boHX84Qs6gzhEylP856jRHTLOxKXYXxGN1Xow=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ff2fa10-96df-46c6-7ab6-08dc4412e0c7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 10:38:25.4001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bnbRE8WU+nK1opxxKGO+FmGdnqZiT/Kt1oFeliiNDnoRhmYnEtxDsuVLLvOhuYSBz7/S1HD/+xZBJKww+nER8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6617
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_08,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403140075
X-Proofpoint-ORIG-GUID: FjPsJBXr-dEwFFPdh4Na9x5_6ko1K1iY
X-Proofpoint-GUID: FjPsJBXr-dEwFFPdh4Na9x5_6ko1K1iY

From: Boris Burkov <boris@bur.io>

This test uses btrfs send with fs-verity which relies on protocol
version 3. The default in progs is version 2, so we need to explicitly
specify the protocol version. Note that the max protocol version in
progs is also currently broken (not properly gated by EXPERIMENTAL) so
that needs fixing as well.

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Boris Burkov <boris@bur.io>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
[ added _require_btrfs_send_version 3 ]
---
 tests/btrfs/277 | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/btrfs/277 b/tests/btrfs/277
index f5684fde1b90..5bb7ffabdd2f 100755
--- a/tests/btrfs/277
+++ b/tests/btrfs/277
@@ -29,6 +29,7 @@ _require_scratch_verity
 _require_fsverity_builtin_signatures
 _require_command "$SETCAP_PROG" setcap
 _require_command "$GETCAP_PROG" getcap
+_require_btrfs_send_version 3
 
 subv=$SCRATCH_MNT/subv
 fsv_file=$subv/file.fsv
@@ -84,7 +85,7 @@ _test_send_verity() {
 	echo "set subvolume read only"
 	$BTRFS_UTIL_PROG property set $subv ro true
 	echo "send subvolume"
-	$BTRFS_UTIL_PROG send $subv -f $stream -q >> $seqres.full
+	$BTRFS_UTIL_PROG send $subv -f $stream -q --proto=3 >> $seqres.full
 
 	echo "blow away fs"
 	_scratch_unmount
-- 
2.39.3


