Return-Path: <linux-btrfs+bounces-5039-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 463C18C7503
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 May 2024 13:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6904F1C22B48
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 May 2024 11:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E154B1459E9;
	Thu, 16 May 2024 11:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YcST+oWb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="F/gPEnHC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830381459E3
	for <linux-btrfs@vger.kernel.org>; Thu, 16 May 2024 11:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715857983; cv=fail; b=ndgjq2u/IFHLDgivvKty6e0JN4DWBS5foM6Khrqq5PfT1SALUPY+LbZLu/DuK8VKVvewr80zfsouhCVxzBs1cvo5PLxF4EJPxNezURF000+Yz30DD+vZ1tV4o9BYuxw6IpoP55SJRlgHimtWXvwAYfJIzLIiPPbKwwrGOKqeK4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715857983; c=relaxed/simple;
	bh=hHVjBzWfMYNSTgRsgS6sMrWAtoj5qpMzGY/+sp4l/yc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fzyROea5mMq1Pd2qwGhMMaRcY9qOq6BGE6Q2JLmyYgQyKCtEl1U+zn0TAkyMDOcfn67vyZwLveBr9NZcrXXoTlMQeOMFnD3trdLQm4U8jLFekVVFOBO16FCM46DKdDeSDAF6nmAjCaxVYc+hCR8Q3CLfd8u4L56JOnDcEvAQ2AI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YcST+oWb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=F/gPEnHC; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44GAnB7D028592
	for <linux-btrfs@vger.kernel.org>; Thu, 16 May 2024 11:13:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=xkLVG2x3eDKzSBAcRGOJ5O5apfApEN1QUwKNWuhScdo=;
 b=YcST+oWbG8LZMzLEan/UXMXfaarj4S8q6kPBkMpsfy61Qzu3lvIMjDfZYkapkNACRqzc
 oEq73pnNrjnS1G126oCWzHK+caIYhPMzp9TcYVq2wLTVnv2AWxc0GcxZ5nwMKR22y3Eo
 gG5287PKH5/kyRzl2oq4Cc+MdlcH6r2Z6T6JNcEbV7t+96Vb+sEX+PZMQ+rPPE9I53xT
 YkAAZgog43SIju5e77INk2v2NZSi1yZhve+AYTgC242nOskgYQKvsNfAxHgU/C9rIIJm
 DuLRV5fxF7AR2BcMqD6tHKQzdzoahjgP1wV0IvDTST2q1wuy6sjlf+7fa3spHQyVmXud lA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y3tx36y3g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Thu, 16 May 2024 11:13:00 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44GA0kJp038472
	for <linux-btrfs@vger.kernel.org>; Thu, 16 May 2024 11:12:59 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3y24pyu3ju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Thu, 16 May 2024 11:12:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TmLzdZE0/uG1wBlIZtQ5csTeYL4/jUkBaBY4+z+YWVxYvYFvmFtj8gNO8aTEUHY/sWMK5ON67DGw2eNu9pSEhitjgeul8c6AX8lhrF9+XV6di7SFcfdNQH/ACQE6+pLnJw4oRKkyxUvRQQeSNhYND2ZCwg/uZ+h16GVwoOlyi9lFJVv7b09cs+BVrexjOi4K5QuLH4Gu9SgXccCyzLizNl/JuEVvpv49R8cHyOu0s/+JsatayLjVzgK5W+76/b/1tqvVDxPs4wg5wZHAZngEpCQoVGRk7BOcbCQ20j8RFc2TSX2uOdckGqTnUkbDzzLjMvLs6X+5ztVDRkLNKmiTgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xkLVG2x3eDKzSBAcRGOJ5O5apfApEN1QUwKNWuhScdo=;
 b=XItiOBzHE23URWiL4LRx9Mh0SMXcpIZdzXWdFZurAtraV8JuTMCOc8cgYAXuWnDUB9jC+4ODSyRS0w+9SRISB1lburS1BMfsEbMyMmuj57jQ3YViopwDA57eby9CgS4H0mjUnqUoHmCR/tjDybufbcYtjNU2WzCJP8pJNk/lHo0nbLgaEGW36wCUbI1FJez131SoBka1hyrPUnV6cXFbLWeOYDIqjFqxA+zbZCtoKFzU3T1KNwcVBb0OSXE39gULpso5lPRXV0C91tORePbGQoa17dXn/0xSDi8flQLiLSzMxzqYXvyIUOVi81Jd+9c8cQwxen/SKG1ukK+BuFI/bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xkLVG2x3eDKzSBAcRGOJ5O5apfApEN1QUwKNWuhScdo=;
 b=F/gPEnHCUPLf17DLwYay+XT0FeNdAtJBBZaXDBDzYppdzoOK4eIjFhi6Fc/cfFagZpK9MZbb837831S5EivuLBhTZ+kOQyDBAmjPfHsZQDpHNhsgw6c3hYz/BzphK+am32fbuuTb+H/8fEkdEcQ9nDqqkszCzOp/+/y60iywpTc=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM6PR10MB4345.namprd10.prod.outlook.com (2603:10b6:5:21a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Thu, 16 May
 2024 11:12:57 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%6]) with mapi id 15.20.7587.028; Thu, 16 May 2024
 11:12:57 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v3 3/6] btrfs: rename ret in btrfs_recover_relocation
Date: Thu, 16 May 2024 19:12:12 +0800
Message-ID: <3e29cfb3f7bfe3ac93e64029b1b0306a48c9936e.1715783315.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1715783315.git.anand.jain@oracle.com>
References: <cover.1715783315.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0204.apcprd04.prod.outlook.com
 (2603:1096:4:187::16) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DM6PR10MB4345:EE_
X-MS-Office365-Filtering-Correlation-Id: d6116e87-eed7-463e-715b-08dc759923c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?AL9itEfg9FNrpzwTmFk2yeknrkiOSPpZeRMOad49Cvl92zTktJaxTKXmtIL4?=
 =?us-ascii?Q?hYjR9lr3HYCGiiPgG9rgD4Jm2HIETG8wGERgNtXmUZucrq2jp8Bd2wXwXtcX?=
 =?us-ascii?Q?gixDeEXX64ma68O61TO8vhQ0h8QFCP5SHGovBEGvkQPhE275Adrz1R6UUzvD?=
 =?us-ascii?Q?jco4BbO2JGEByfkmbZtGAiRzYFdR4mI3kAAw1IoIPh32QYUF78EBQd9YPwHq?=
 =?us-ascii?Q?C3j3YRFvCvFbGAIoVk1FAvlltfxMjD6AJ0ff28snPa+Fm8t2SNsj5A4Ygfu2?=
 =?us-ascii?Q?9KQOrK7Ewg5MEiKBJZP0DqCtlTCWuEswY/UkGn9KnenUx/9IGUG0o61EFfFe?=
 =?us-ascii?Q?oU0Itiz5GEufO1QrC4ON349e3IkFfGBpQqdhutTEpqJHGFPpgSZh0SRVlBeR?=
 =?us-ascii?Q?PFBrMADs/w+djn4XyUY4Iaa67wlJ97utUKIRAam46pf/CAfafmsSlK2lnGxu?=
 =?us-ascii?Q?hPXkJYs5s2YN+7WaO+4AV2M3oTixIXtpUFa8gXnqgrEadq3az6hy99z1Vhkm?=
 =?us-ascii?Q?8HoK7dkUMNlElTeRlfMjk/L2Q1sM9ePE2JtkkB/iT1uxtDsouEN8duA/41sI?=
 =?us-ascii?Q?6e+7RHJE87HfQBaXYxT1T8AoHHD2pS6J70coAbgC5eEA0/WqRbOxSZvqfDIT?=
 =?us-ascii?Q?Rg9I9nooiz1/ZhUC5+Y9TWLdOoH0Sy7ZTcRuu7PPPSDjQQr7rT+rB55/1uoP?=
 =?us-ascii?Q?xPjMVJFWnCZQDyc8+JHDV3UU0BVxVnF/pKoBP4c3zCd60zskPi+k9TnoBV/x?=
 =?us-ascii?Q?ob2PIPbNmPasCMDRA9d0EAgsvyoF4j8LspTViwjcgdWVZIaA2m9GfEO+dcyn?=
 =?us-ascii?Q?MvK6ph6nIkXLW5QIxQkvHSGNX++4PPZ9/OvG4eKJGXVS1AocJYo4wQlsMkqq?=
 =?us-ascii?Q?SKAhTA21rIVDPsIPL6xlFbiD9pVbA8xWKNTb3TxhcGgLX+O4oLoejX4z/iiB?=
 =?us-ascii?Q?aXolExNUfQqHjfZNP3VfZW8wIv/SUrzQA4sPRbviHyI166EPnG1WzUfpEWZC?=
 =?us-ascii?Q?h/xL/27jyo4sBOfp+db9gX2CIdh1b+tCQ8xs48altr245yk912gzHACnFA/r?=
 =?us-ascii?Q?mMcq5SLOdrW6hZlYv7yO+gHT8rJ0sKCIkBtnkITpUQdC75iZwYJV+NM0LDtN?=
 =?us-ascii?Q?/9XpNnuCIf6SU+uKlkdUJjyUen8mGzlihdSJepy3gJb8hGrleWHBamqjG2za?=
 =?us-ascii?Q?mwKfOJWKu/cR7pVM2pROZuwXwb6xU5W8Y9LqtHsBs5dXEYRaFkEXrismCMHO?=
 =?us-ascii?Q?HydAgUtdCLYlhzaVf9bCrjn7tgRPdtAdZgU5vkfCPw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?L7tEpTw7FXRNZbSHobljA2ja4xEEsEmSE48Uh8zmHAvVyAZ54VHHnvNcnpDP?=
 =?us-ascii?Q?kDVWCBEUOS07jUy7tpxWn5UhCXTAONHSM4hp0aPy+/xCQAGjAQmTkVNvL3PJ?=
 =?us-ascii?Q?hRvLfP7Z7DIX67WzMA7JHb7c+Z1POCywzI0AZq6cpmRkodsPjbv18GNEfr1E?=
 =?us-ascii?Q?FSKh7JjzXh7p6k1nyFQlwVZedRMV7A2rf/7kpZxCX3i/QNmdUQDs/4tQ35AX?=
 =?us-ascii?Q?/qMjKk//ibijrWiogL8T/buzCyH71jDi0ZGk9HGhBIhVLOs0Ghh/fK6A8yU8?=
 =?us-ascii?Q?dSdUDQRIrslb5fvEy0S1A+hMifaZxwKcQRNWxtOdJCChoOJ8qsMv/lpVV9tm?=
 =?us-ascii?Q?B0DK/3ONqtrkWLy2kQANZJxosnXGH2nNOUkHt7xKpCPuAO+LY0p0GXw/Pqox?=
 =?us-ascii?Q?FP+fidMowwmuB44g6i3e9iitekBDjkFz2z9NoW4aKWoY6Xu0rB/AaqYb9A/2?=
 =?us-ascii?Q?ch4Ik63dQQOzswW0qqiZ6TeB18SkNsroBi7kj0Wv8L2IUTJS5FDNr1K77Rc7?=
 =?us-ascii?Q?Oi2xSi4AdgwMTz5Cs1J/+pv/lpczVZyivKxSOFC8wJmzzCeLQncqzfKvTrit?=
 =?us-ascii?Q?qtAax9NvIR6m643gyo1R4L7/WPN+q3eTZktMjlAvI/KfY/kWlxuzqTGpdvpu?=
 =?us-ascii?Q?IUf9LyDnLDKDjTwya81XYg/xaoIs8dVQ0P6739WhkTW9UF5s5DPgqd2t2qSN?=
 =?us-ascii?Q?Na1LLNybOSKiJjc9GKYLcF1FKOGHPK5RXkbHLhuyXLvx6rIEzm9H1TyOD+rn?=
 =?us-ascii?Q?rMfXtYoDyiyZpsYKKATS94Aj+5dQg2FHvuVkNT4pziL/s1uUIBluUPQPCQHU?=
 =?us-ascii?Q?FUcBdmHqHJyi6E0x435FCGCSBeWNnmR2Il657lyG6PvoJMMTaLUqC87QzOJd?=
 =?us-ascii?Q?FLquBgJLLjFD67pBqYaVdPQTrTjp6zcMQLn3WB1no0heoncaFWW3mkQpMe33?=
 =?us-ascii?Q?kwb9iSGJxuM2VLWhvekOUNh+c8GYgqvXXO7PeMhqzBZTHr6KASGp4KnxQxLh?=
 =?us-ascii?Q?4wBDXJcb7J2HNJKmsnVCsZH8PeBzCyB8kthISKjv/HQlzjTvAPINc9Om2XRX?=
 =?us-ascii?Q?E49AEGUIPaIARogr5BA+oKIHfhWM/Wvh1e4evmu/hRWSTs4psG5NsjInVWIB?=
 =?us-ascii?Q?EeeJlBwfRE9lQwG9ukl7VVcM2CCiGzFQ8Uko2WUFeTg65CT4vnwwQhLAqViC?=
 =?us-ascii?Q?L20hMZNn1zX0pYcBur+Bwv0dpaQMbJpvYQ9KCr6uf543coHXYTJ8ufdtDM2/?=
 =?us-ascii?Q?WDdz5BqSgcR//cKYjdCEdmBXryJw/gcR21SxF97RZDNdg/yjVDfgp3h8mN96?=
 =?us-ascii?Q?L1mSTci0pfj08HHqRQcflPsHkFn7nEVgloRbQC+M9zap+00RDDhzJ5U8zDM3?=
 =?us-ascii?Q?wyIRPTwrwBcTGPMjISvR28C6RHip0VctbhCycLtwehB99czx/Og2ge1/HBAM?=
 =?us-ascii?Q?OyvhAhsCQMxbXgPVGY9igN5cmjfUt7kUnR55rP9npFB8jVe8wYwDzFq5K7hh?=
 =?us-ascii?Q?e4oL3976a4VJm5ShKrDxKrPUZ2mljfb2PvP3mQYBBjB72wtzmYkpFnHLSGyD?=
 =?us-ascii?Q?+xCk2+lLjcwpwXFod72R5SZ4qaBwZ4cRIwCg1bnWbO8ai/c8eRKqFxA8GFor?=
 =?us-ascii?Q?3g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	0kK4+Vnl+NAVo3hJ1V4yezhDgVjz5QbN9LX+EBlrSIku0vd7tDgHp3eVK7mdkOOC/BExmQg1ZqWHcSM0AzPu6jX6kq+Uqw6kqrIJTwRXEc9+lJrhmDahm4dZDTq9wRrliH3HbN7E413pH3b20gLEILSoYK62kJAU7qm3Q4O2p6frbewY2pHkM7UTPPFnfTnwj1GXH3h+E9Okcl4aiamhNYLhGC4nbIJ9ws7ueLXw6TSejpWCbBqfUKXa4KayjYnfF1T7lo3+Y/lGq15AcMesLcaUbemGhWBZgYWYLz8668uwQs7JFB6qPQAWLkA+8ukyUBk0iY96DyZm64cMdg6CiNF6f829K4TRBM1ruk+F65CWBLzJ1rgWMpW1qu4+A3KQr7faytfrcRTqB+w25IN7BZ3fLxl1TBlrvpnX/rda52+Glqnol5k+oTPaxsoDfGGdUJOoFAX93EU3g9gM3v3lKXyHQ2xqcaZ214iquKkyaJ0U686RRaU0n0Pvg9P+6aE2yYXuhRytkWZP9wcS2SfpDXiw4WzLJbzteJmP0JBxi/okDXDyeXGIvvUPHhfhw7LemoDBqGwWBS05M9Dd7kREwElwgb+Z37g5XKW9sXr8rOo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6116e87-eed7-463e-715b-08dc759923c9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 11:12:57.3385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k/NHvJrR5rJBZwswwxRDmdNwfdxTN5urNyza5jo4FbKl15vGvhB6DK4k3Ys4VOk6/L5dhlnJIT/FzZFY4wP6wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4345
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-16_05,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 mlxscore=0
 spamscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405160080
X-Proofpoint-GUID: 2Wyj3dXwq-AFeQF7pHzDdid_4jRXM-e-
X-Proofpoint-ORIG-GUID: 2Wyj3dXwq-AFeQF7pHzDdid_4jRXM-e-

A preparatory patch to rename 'err' to 'ret', but ret is already used as an
intermediary return value, so first rename 'ret' to 'ret2'.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
This patch can be merged with the next one; they were separated for easier
review. Thx.

v3: new

 fs/btrfs/relocation.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index bfcecf6701a0..e24deb7f0504 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4221,7 +4221,7 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
 	struct extent_buffer *leaf;
 	struct reloc_control *rc = NULL;
 	struct btrfs_trans_handle *trans;
-	int ret;
+	int ret2;
 	int err = 0;
 
 	path = btrfs_alloc_path();
@@ -4356,9 +4356,9 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
 	}
 	err = btrfs_commit_transaction(trans);
 out_clean:
-	ret = clean_dirty_subvols(rc);
-	if (ret < 0 && !err)
-		err = ret;
+	ret2 = clean_dirty_subvols(rc);
+	if (ret2 < 0 && !err)
+		err = ret2;
 out_unset:
 	unset_reloc_control(rc);
 out_end:
-- 
2.38.1


