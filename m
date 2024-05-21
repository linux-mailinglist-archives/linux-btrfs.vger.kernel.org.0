Return-Path: <linux-btrfs+bounces-5177-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1F08CB2A2
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 19:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 655F81F222F7
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 17:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5C71482E8;
	Tue, 21 May 2024 17:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZsBoTbQo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NVixXrBn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA0222F11
	for <linux-btrfs@vger.kernel.org>; Tue, 21 May 2024 17:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716311581; cv=fail; b=cIh1pU+ELst4uVaP5uEJJ11lO6bQDo3OqYwSfMnAXhHGYUm5FXv/yyvrABgxk5dwBViwSWI3gpRyEd+YP/FFf7Rr3wVPVDZ+hbk/L70o1bBUc3zpiW7nAr3elGiRort6Cx3fMEc7nxE0xkL3TkrmuGn1qnwb0vl4IfAd0s2h2ng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716311581; c=relaxed/simple;
	bh=tkJx7CajRgiadSgSuMfdoNk9Ao1va3Dr+zQEYGB1ta4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HbjyB7rgXqqnCnSPJplDB6BwrkuIm5Qjv/dj9BKTvZJ4VPTuVOR9t5JfvFBC8zGzQUGhcHEf7OGXcdd0f3yP5rppQw/DTyqCHN3xbz4v5ZINtckX+eJRIJQmqfmVgSONwOy8xT4p1Aat/bc9YjOLEblXhJ2YXAgfqOJ1zraWEwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZsBoTbQo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NVixXrBn; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44LGxMB0001541
	for <linux-btrfs@vger.kernel.org>; Tue, 21 May 2024 17:12:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=r/zogpUUyAneO7U+RDOHHnIIXVxZQXAKq618FRnOAvM=;
 b=ZsBoTbQoNC4uFxlbCE6Z8B/WFWr32MC7tPiEF964KrENSrVlnhSZgN94xNls6S5QjSwh
 guWj9UtFX10X9JdqeX+tARTexH9ISRTI5dtLbQKMKbmZslm8CWmHwgOE3eBpeUJongQY
 6qQTvsJ/p+OEEh8+hmw3V5ouHF+0y2sLPElu8i0rCODcq/MbbHmpPtbXk3vDBDkSJVa0
 hMlSYTN1ytjQlNfYDaY7YYkXYgv6VP+CSb8SNrdfyZDiBhXAJB4hdeBK6N6AZiqlKIMK
 Lm3uHAIiZjygKFqbSbvwgsTolMnuNSSoKs7OW35UtslS/n0neeZ/R/O01mJLHHyCOQGp Tg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6mvv5w0a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Tue, 21 May 2024 17:12:58 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44LGoRT9019590
	for <linux-btrfs@vger.kernel.org>; Tue, 21 May 2024 17:12:57 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y6js82k5a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Tue, 21 May 2024 17:12:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mRYWa3815x73r7ea9s4CIZ3qaLPSPwVADH61ITdoAEC4+PQNBvW/JR9SZac533j5ms1Ns0on2i77yjIdgKGO+7xt026wYTZfrn8zTRzN+F37PWYkhOXF+ft+oPQBdvknUUs6fO3RI/EFrKudSM6xIrh/dbg0tXTAWqw+VK81iEvyAjulLlIA4lwyN2ITB+gY6eWZhhsLfgh0WZo/eOxPan9h7wNiWcA02Z8z0iZR2kgI/bDJxYfMsHEuCsX473Qh9LC4a1T561YCpdWEaw7FkJgmqItGfHeFQD2FG3rey86Js4A0lTSWQwpqg/7LRrYrcbnLNiH/QdDmNHWZNFm3gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r/zogpUUyAneO7U+RDOHHnIIXVxZQXAKq618FRnOAvM=;
 b=kUfNUpbZIOzDnRWJCzzDR6TJnmrhXNSpokfrr8apwaCzfQ8Xelz96Pmh3Zb+UX7fuHCUsmqD80HLhnqHXbOZpetPQLNX6TkEN1DXh9QOVuvVTrgrdniY8c4x2zjZs7XJz32MUri3I1VmryAiEGVVDQ1YLFPmo5Mo7ptMPakRJHp1ux1I7fsy1NlOhaGmFHr/2w9JqARF2Phs3MNpCDScyEFmI5h7GLlyUhor2aGNh203nkz6MIJ5SBkwdBH0l2N0SQTKKo/5iB3ukwSPp5EiE67HCpX7xzPljFcZxUG12IX/ep+Su3Nn0zARDyOO/27ze+Vs8nOlQMVsRDlXPsZy7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/zogpUUyAneO7U+RDOHHnIIXVxZQXAKq618FRnOAvM=;
 b=NVixXrBn1KXnx5NDLXtW0rojFitxn+8GN89on+wT+y7QuP/S/h0/zAXCsx3WuO9OM2F+SKWlJdCM1/uCxNBiWr8N1FnY/LD8e52/9zOZ4JKcbeeeeq1orTvrlJdaTIJNXU5nHqPpsL1c9mMxfnU66Tis0QZFFHgJpjK+SYmDf1I=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MN6PR10MB7520.namprd10.prod.outlook.com (2603:10b6:208:478::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 17:12:55 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%6]) with mapi id 15.20.7587.028; Tue, 21 May 2024
 17:12:55 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v4 5/6] btrfs: rename err to ret in btrfs_drop_snapshot()
Date: Wed, 22 May 2024 01:11:11 +0800
Message-ID: <8f0910686f948b2f7bd018a174fb4a17eaa5c35c.1716310365.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1716310365.git.anand.jain@oracle.com>
References: <cover.1716310365.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0172.apcprd04.prod.outlook.com (2603:1096:4::34)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MN6PR10MB7520:EE_
X-MS-Office365-Filtering-Correlation-Id: 61eeff9a-06c7-4553-63c8-08dc79b9414b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?WZ2f5BfNO6V5e7najR8lNvksYJPT9IdBvA6HmJhmQ6gE+taXgbXi9Glz8e7i?=
 =?us-ascii?Q?13xtgQpY2Z4aafMZASFK3oQLsWgLd5OPMTeByo3iHUdhZTGlC/g4lYZIY//M?=
 =?us-ascii?Q?b8cKp8+O6ugCN8vuZGmXXgAovW7dZuaXyVGJJ7RvNIam9yhBL7yhbxdSC2os?=
 =?us-ascii?Q?oAZhLHh7lhxInVfSHL5IW4xZluwS8MKutky5tXfxV59CqVGIsnNqbjsGgAyz?=
 =?us-ascii?Q?AM/ESrRBxA+Hae3BejCuZsqyqeijvuSJPZd2RmM9AYOQuCxixst03Y4599Ur?=
 =?us-ascii?Q?khdhqVMFbCHMoBXJXBD4JzPx3+iaBmxpcj56cKT3B+1wjmRUYU90PiZqrQqt?=
 =?us-ascii?Q?7UInZVvEphi+3TI0dME656s9OPlYl7wxciIwhZokCVOvs4nUN5KZosvZRzev?=
 =?us-ascii?Q?khvm6sUw0ZHkMdLPNtC/WiLBk0cOMfu2vBvi9AzLv37js7akmZ4jRugPBfXS?=
 =?us-ascii?Q?TobuQlzOrlRuqWsLaA2s1YnTQxDqmJ47Gg53tDt0AKiFqDJue+oB1ehmyFvp?=
 =?us-ascii?Q?20ncrDksBR8pQMMr4ydYePUV80Sj4iv3zS+5FCJDh5tssKMFAM3pZGwzv5H+?=
 =?us-ascii?Q?t7+RhsMLz6D3idOoWZGOul/bC+z+12ay/eUTnzw6u9FDpy+I2/Z4Osrnxie6?=
 =?us-ascii?Q?MySytvvcp3Us6YkhjiJmGE1Pv7VK+3xIGLlLT6DXUELfvjkFUN3wrk7HZ5OC?=
 =?us-ascii?Q?n4GAPJFMP/ZzmBMi1ZRvb5seIEmZ4lpcLoyAmyxbtbKiGeOV+Lcoj1uiUZCV?=
 =?us-ascii?Q?qafdCdYV0ddbhWlHhe14Naq3qHkvTWru0WqZwRq8IxM2BpiJI0WzFtZ0iA6g?=
 =?us-ascii?Q?R8DqIPaqnXP0Yn44Gh9bYh2p34qQP2GhMzE8Vmxld+ORudlXjfGIoEVA0XG2?=
 =?us-ascii?Q?UdJ7Xs4CYeug6ElEnb+ySU4Z+R3K0VXu40lXBJN/3Fs6cwzCo1qqmNM+bDLA?=
 =?us-ascii?Q?nKrcC+of4wKf/m3aSqfVDWQhUKZaSVne9/c3f0sZbl6FVnE10f70fEyvqIGm?=
 =?us-ascii?Q?21aeftnFNyZnjQyFIQuNiodXO7UnBc3XgdPpPo72GFeHIo2lnQNs8fQsu9re?=
 =?us-ascii?Q?H72HXcoM8NDTzktDoKBBZOtTrmd9QklGc1UfSD6Xx0qQDhjrkPak4Q7H6sLL?=
 =?us-ascii?Q?2zQIhziphLp7OXm7YyH1YoIkv3SGfjxHF9GziivUiFKlYckDzdubY8sjd6vM?=
 =?us-ascii?Q?NFPfDXFvQ40O+GY05Ew8KCnEV/nPtrmRc3gpgceQIUWhzd19jBjW4ZOrMfoS?=
 =?us-ascii?Q?Qq7WJG1JxdiwcMM9gPJT++NS1Dlw9S5fblHclS8lAg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?8T18RijjRXbK+GInI0HTjKbSapuFAF9/feH1Kr2cDvxp+by8z8Tyvf4XPNMo?=
 =?us-ascii?Q?F02Y2ReJZ5h8HFPk2aI12oRuL+CitzecfAqdXxNPHxTMvFgt/b1/A39OeOdE?=
 =?us-ascii?Q?CdoiPYPP6Eg7qEEJA2RcAU/yLF2+SnJk9HeS13NZ/fuznLkhXx4ck7d35HZt?=
 =?us-ascii?Q?byvBdO51/LLEmxfdT3K96PNbfKM6oLhbVwP0zg9xwyPXvu1ff7SQgBp8ogfa?=
 =?us-ascii?Q?pUoIz1OVSBqme8Bk3A0KZzv8t8OqT0YhDhnakzdfLSKoxrRPFJcQkHITLr6Y?=
 =?us-ascii?Q?292ZLwZvGASRmnizDfJA7RKy0LaG56QOtDonURXOJ7W3vALlll2suwwKcTDb?=
 =?us-ascii?Q?72d4EYsD9r9izOBGPxvZ44XTHpZ/49Ol//7bqsqIWbObg7sKPmNMK9rnzgrk?=
 =?us-ascii?Q?tHL/3kv1QJUjqC6wKWqguy0WmSX4X0Y/PE5dvzMHEnLR/BKoJGrUikiWiH7N?=
 =?us-ascii?Q?rYwC0agP8CPszcdh4q0cQKNzF32hShXImL9aCMRR7MLaF/fA7xkyhqW06bNj?=
 =?us-ascii?Q?Gp0ff8dhaLmhczBJ5zs6QffhB9jK2i0VG3ZNmC2LDrCBQ/ZdIq8Aming2TwP?=
 =?us-ascii?Q?m05TsqzVDwUG/IvYofqMW/zDR/6bnHSozy4e+EmPgLeIBkxG8pUv3dIUwYEd?=
 =?us-ascii?Q?K0UmF4+cIbFryJg5qyhGE8qFHLl8IZ5ShCTx/9KAAogGwQYDIYFRisa6WEI4?=
 =?us-ascii?Q?k3nA95LCXbPKItGI1crt00rOJd7hQXYgrwmYeIzJ+LmrMILtmm+Cs1fYPZr0?=
 =?us-ascii?Q?8Tga++ma9iMkI+mVB1kMGqmtiNFG8YDh4HLStnRexrbwA3lg8LitbG4YGLyb?=
 =?us-ascii?Q?oqHgabttMm9LD/AVdc1fD67DGBHKu9DQeZ2iBlqajsuK8hdSApJNo9g8Fst2?=
 =?us-ascii?Q?IqA2ad47GtvZIfyCCCj/Wc1BcxMeoi7smj3ginGbDyq5Ezcb1HHx6GDHppmp?=
 =?us-ascii?Q?D+gHks13+BnzpwWCGD5aa4nEfAaB31/xMuXSUR6PcJ/7NfD4uIQAavOLC3RM?=
 =?us-ascii?Q?kMxYBxSbi/mGI9LI/mWTNGaWBpNQdE1g2JUPL8rauacXUMMvV9ZHP4u6R2AI?=
 =?us-ascii?Q?crcEgNl0ZWdx5pIvB6zC6fElcybHSaXgQMWSuTguW0zTtlCQ7wOOifYILQP0?=
 =?us-ascii?Q?BHMEC9W//hjl1aboRJlhlFB4lODTGytTS3fCif0eMpAW0oLIQ7+643x+zg9K?=
 =?us-ascii?Q?kIZjWvNDQOO0ak+CkKGxOYyX2+ZamiWtcEE6k6Uy0ttJbaHTII3n442zglLo?=
 =?us-ascii?Q?dNSC8UWJosNINy617sd/XdWn4pBd4Fa3XIW8y78BwuhkuSbhs81WcrApLWBC?=
 =?us-ascii?Q?eCAgesh/x6HYdkS3qxCQSNQdoSzVinDBI9ECZVRfJBk5xX78gU8Y0D18YceC?=
 =?us-ascii?Q?IuWE405pJnOaEwWJ6MhLVzH55mHJKtfCNVcm07LA9sVecJ03zAi0W12yGiPv?=
 =?us-ascii?Q?uU2Ouc2vO7e/ckngFYKkJQtPYHjQqT2WCs+qbvLvfm5CsOm6CWH4WV0C2J8j?=
 =?us-ascii?Q?HypguZSRCnCiipx3R5F9HXMo0ISg2R+iRKzOLT9+Zo45oVSJomInsBrL04eW?=
 =?us-ascii?Q?H+WmbRvdC1WUDfVtDchKhTSbLksLSUW/tU05vqlh0ogXIoyo/i2P80gkiZIj?=
 =?us-ascii?Q?8A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	JfOzoAqe4xlnjuHoiIJDIyXgRt/OaeYJs2TKujbSpuntZH/60wuJifWKFEPmOP5wPD/aUBjHZgPs1JTlA5vaDDsmUf5Bth3n5cvR25XsR7SXPByyhPtW/G72S+cZZZzVEtzZysV86VFNGG8/QRzO/k2sCIOJNzW83mGFpkXHQ4R9fUEidVopUcpY2pa+gUh4O5gfKTu5d434MiQoimyEbdrn8i+l1hgtZnceHO5db3f9TCmXfjdEDKPiSBU7vvVUm/0AmHvrMWnKz/4r8ZiyT4W/EX/4WwuMRgOr/xbDjZeiDT7KiIuoVo7hiFScB7F2WeARz5tj2e6wgdnydkkHr0qMa8VtcqM7RVatTTrGKKtplwiqDVHI/cW/QWpcB5gBVMdzuDuKAi3s4bMtFu/Q6WNzSjmzFMyz9bSn/tQBgSz/kCl2lS/ykW0foXOTq/zHGi1g/0BtsQteNq2r+6u9wg/6MnnkFZMvwU85rZgGudu1CXvf4sKqqJkkSpgfQ+G/4+3/NJrPUoglnf7Nmf53A9xRIXI8TYVXCPj7lha49lxWTQQ6Ps/naqAuWtPwyA+OaJiF6O5921ZE6B3SkNkPl3flJ0SgtzFGcChuukxxUIo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61eeff9a-06c7-4553-63c8-08dc79b9414b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 17:12:55.1898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M3vwOWkIFNHiYa40LMwRrj4Nw97HKcy6YKEiMYEecTa7g7lcPtn9zypMG9el/xEAFNzo3qGzH0IxL4oRzbvFCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7520
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-21_10,2024-05-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405210130
X-Proofpoint-ORIG-GUID: WTDTsLligPkseFIPhhtjEKIw-EvIUho3
X-Proofpoint-GUID: WTDTsLligPkseFIPhhtjEKIw-EvIUho3

Drop the variable 'err', reuse the variable 'ret' by reinitializing it to
zero where necessary.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v4: Title changed.
v3: Fix comment formatting.
v2: handle return error better, no need of original 'ret'. (Josef).
 fs/btrfs/extent-tree.c | 48 +++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 3774c191e36d..5aa7c8a0dbc6 100644
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
+			 * If we fail to delete the orphan item this time
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


