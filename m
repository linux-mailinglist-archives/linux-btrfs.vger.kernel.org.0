Return-Path: <linux-btrfs+bounces-9696-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A759CE450
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 15:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A025F1F23CF6
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 14:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DDCD1D45FE;
	Fri, 15 Nov 2024 14:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gVdKuK9o";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gIYDJZR9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B061CEACD
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Nov 2024 14:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731682513; cv=fail; b=huS7z+onI9jKg5JIUqMLsP2bD9eEn8c37ORrbLuqnbi4G07s81Sj+XPqC4uFhzDmEtPBD5WXUsMH7iifOxhWdSKdCrMMN51ble/CWJ4Hty27pWYmnONowdwwymmlKj8IAs1GH1t1tIbmcKPAoqtP8IDsg6k7Bd8kXu4QxQ+sUK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731682513; c=relaxed/simple;
	bh=IjKLwcQN3dyIfDDk7yfm5K4bFbGF2CDEl/DkQzY+PoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TOwLDk/4lCgGrthE2CAr//vrkS2jDpBm9S6klxdoHJ5BsLWHt9bO3YI4MY/zm3vxWNkatr7Gct9zaWtTCP+sHs28XF2SIgqPr3ZL92o+1wZxp00lazNbWqJoRN7LXKT/qyuUXBqaUE6wAkDRuPTyU7xAS3JDXCiO9aZJ1bHnW7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gVdKuK9o; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gIYDJZR9; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFDCSMf017354;
	Fri, 15 Nov 2024 14:55:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=vlpCZaZkDklvhd754Zsgzwi1VY2EvgW/9r+fWmDdfn0=; b=
	gVdKuK9opDSVDIgy6I6HrMXQjJjYaHD1R9eKxdDwuDPIxww0VPwskYMG/MQTa1Ho
	OWJnuq+ZNrqqvK1Wh6CAt80koxCm0FRgyiri0+YQKzwDOXwvSB+Csg1Ov2+L4hoM
	AgDsyDuQUX52vhYxavdJcCZl9eIdEl6rvrnYU7wVglmWo3lQxitcRGoiBSFqX5o7
	6zBEWIIjzYXDtDQ4tNgW756jrjNx9iZFWEmKcEvMX2wx1zrB7GXvh8Y0lC/dPKxT
	StlUdhfUnaTuprd+223NPPRHe4bpthdbqKSRljttjrIqou5CDb7TfCtjPjsplo5C
	TtSxY7RZs+mKv9cSx26kYw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0k2bhbd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 14:55:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFDrCfj036079;
	Fri, 15 Nov 2024 14:55:00 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42sx6c9eh8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 14:55:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w9z0u/QXHAQfNwL3uYqvtghp/JZY4ZX7YOB84c2QfZA9Fbh5Zi5oX2cPmywBoDweIZccqBJ5N1QnDc4bMTYAdonTOXOYMMIKuCzOqgCum77/6zwwxqWo2ZpML+Acc0s3M7RGgAZ2y2Kq09dsdu2ylKpuymDq2KtYnixgdltI/t/SOFndTa4HvN29vYC5GzgIIbb4X312WQnrHO4+JK5+hNdMajJZr955MYke4aDnm08nvAEikmXBb7wkJY2mRSQD+Vav1O6da/OCjKZ50aWi61D/zxhOqKwzyo/TODWFIEiEr9PtUGQt1ISRvPPNBwyzH4FyXZtSvIqBSmLabedteQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vlpCZaZkDklvhd754Zsgzwi1VY2EvgW/9r+fWmDdfn0=;
 b=LWg2p45m1zcaIDVrYATmAh5C/NNhuTnmT6iVu/awGgiDGI0iVErEGfjg19kMHP5QH1Tbw3wdf/Jpj1X4ns3yLLK+QXTQF+f7pGe+Y+s/8n6pWbuLnycw0m54R4W7PG7F75P4IeyeVEZvvSnz5C85/QoTPQO+jmKFfdDDPJwrEcXJOWusCspohwA37DmZQ6ZdDRlqwzydFcBRo3KfsREE2jCFOdNdKtCanLLZBnzYyo7oG4DImhOexh+kOJb1m6Xgwug21iCrclRwrB3mVZeI72/qZVgVN48aGWZNetuEbNO/IOoicTan5rJNjg6+uxO05sIPOiAtH9masbsOEaAlJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vlpCZaZkDklvhd754Zsgzwi1VY2EvgW/9r+fWmDdfn0=;
 b=gIYDJZR9m9chcPB0FtmkizQoiLIU7q7tFfaG4GEQzxiInYzxDLo1NU3E9M+1zvl2K0oRZclkO8OAPVRywbLx2JyQtHXCb5SMOORkaBcM/SGIqrEL/Q0dpXwC1T333rg8Pzu47A5ncKBLNiwArV7mXxEL69PWPP+k0U3Zzk4Cdg8=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB4582.namprd10.prod.outlook.com (2603:10b6:510:39::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.19; Fri, 15 Nov
 2024 14:54:57 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%4]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 14:54:57 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: dsterba@suse.com, wqu@suse.com, hrx@bupt.moe, waxhead@dirtcellar.net
Subject: [PATCH v3 05/10] btrfs: introduce RAID1 round-robin read balancing
Date: Fri, 15 Nov 2024 22:54:05 +0800
Message-ID: <995d4a9dd9f553825805efdac24dec4a9de20ef3.1731076425.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <cover.1731076425.git.anand.jain@oracle.com>
References: <cover.1731076425.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:54::18) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB4582:EE_
X-MS-Office365-Filtering-Correlation-Id: 52b93a27-7a27-45d2-47d9-08dd058578fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WBIq7CfhGA+9VeVW6eZG6dWnLKR/NhgGAVFwPMEENK0R1fgMC3p1khyge8KG?=
 =?us-ascii?Q?yvY36jcIFli34c/8LqRX+XQjpMH12KvEu/aZYWk4q6Vg2aWDaRcqF+W9v4eb?=
 =?us-ascii?Q?4B+/dHVV/pL69JTzC9OHTXO5LLyATIuWAyyT8JStFVC68ITSTY4hTy2mhFa1?=
 =?us-ascii?Q?RU69dJ8muQEGncwYQkkPwd7IAQVqnxojVQqh8TeoPTmopJz3xAlhl3yUiZuu?=
 =?us-ascii?Q?UvHEQrBqNM/bjCxDqz0MSz8Kn/tcq53idG0AAMT8Gy8GTcANtQvxSgz2WVwN?=
 =?us-ascii?Q?j1kg8/UqIULbSfjRA/XMstrD9dNuUqE3eN8po7l2S8l/Uj9haS4MuFIoMX5k?=
 =?us-ascii?Q?wUQBYqpdnWPbgdm6XAeFIw2lZuKlKPcWXxj6cICXMHTKL7/8dFD9/AEGWhet?=
 =?us-ascii?Q?3BuPPjeS3rEkQ8UrB5Cr6CmIF+tiREymPGdda2CbTaBwsL89kXSVKd1o+vlh?=
 =?us-ascii?Q?WPZHLTXa59bnuCJehS18CQ+s2p3KzAYriLgR0LRyb3A7WHfE5dcYowxihJwx?=
 =?us-ascii?Q?1qf1AWIdFAT6lw0zfxZ71mXD0TYXiigkbMSoT8NLp6LS1xaEThK1rotl3IUu?=
 =?us-ascii?Q?b5bdPm7QpdOf1GrhTqKAld/3evQedsG/2FrwyGhKYiqd3BShDNQ9TkCQqsKN?=
 =?us-ascii?Q?hzm3EKkALNdo/7oCZR8t4oBvm6dQ35Yr3VEQh6fg5sfTcrsTKR0vcsJ8uQSE?=
 =?us-ascii?Q?itNGV5az+VvaAdXtGpsTjGcAkLtYWE+LCSAZORrhxSfgibjMMU0ECJb5xhuX?=
 =?us-ascii?Q?wnnu4w+0+93+DRhcS0qQQ05/TvMaciM5/u/IeY2zjO/trMk1UIXMsl4H1Gyg?=
 =?us-ascii?Q?HJQhNYOEaiLhScTiINJkKm05oZoGWkrvUwyZTbAaTH15r2HOwNgdkqF3ZgCO?=
 =?us-ascii?Q?mgiJ9JMCz1KUH0JxMKRHuTNjIr5nuwS/hQXOmi6zPWa2l+MfuRHlux2ELLT6?=
 =?us-ascii?Q?r5nv2LRCZgT3z9ucmyHEQUomyf58Io5viJrUpbXeulfj3QyIYWRFe/aItUc3?=
 =?us-ascii?Q?nt68dS9cOikrauZ72XpBgBHSRujq8zRJcNT0iMWwR1woxOpSv4T2QHYUQkP1?=
 =?us-ascii?Q?qObLwX+Vhkhjf7WnTK8xrMqMJVOriPqlyR6ZT5hS845hAl2P3FIbCFwYZox2?=
 =?us-ascii?Q?Hi0w9QqPh70xYgwxdJV+UzUNh0Vqk7KNuihaQF3FQifJffP1hubtGOP9baMW?=
 =?us-ascii?Q?qyWaxi4pnJA7aJ1Wh05m+2NMwToklrk9H2dojnKmpkpu8qijhY3WexIdYKiN?=
 =?us-ascii?Q?ovTx6edGqoTwWkqWS/1ZYb+gOcuo/uad2KIRqS3G+tygxjnzA1uGXQXtT6sM?=
 =?us-ascii?Q?E3S/Ry4v7h+ROTInDsC3JhpB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gqL5yePJNe+PizfPIt0Vf3E5rDc2egc/KEIYh7aUy7rpMxMqOOCoQ2aEVxVc?=
 =?us-ascii?Q?ShxGIJJkCZZNyJnx8yd5FI6rZ6rS/1x20Q3REfjnRn0aP1hntZHPVXmv286q?=
 =?us-ascii?Q?NUR4gkrLjI4J8NGcBHAOvxwnVP1MgckdeZcSwJ/kcPxvcjHBWcjSBJJmA5Qr?=
 =?us-ascii?Q?6HzlEqOqonBFcc6sMSNFRJGLtXWwvtAyEd+5VYUtNLX5W9kViIcSci4AkOdS?=
 =?us-ascii?Q?ZZGZAjnEWbYnAatPlqEL+ov0Av2TIl+wIK6wqaDroDlVEj6bfVQ33IGo6c8y?=
 =?us-ascii?Q?BCVzwdhy38PQvodoiGdVEQsNAraqqL7lQ+QTZOxiNj61Iu7JX8FFYr/x8Giv?=
 =?us-ascii?Q?zrgVwsPyza0RvW5DgDpQTXBa+w8of45U2jdCTvnrXQHwbYFiZBRtjaUEV+HV?=
 =?us-ascii?Q?RW92C8WfwjcEH6/bE5e4mjvj49PL8L6n2Tnt6SXgvkNR/gfbETMdsD+L5xqa?=
 =?us-ascii?Q?Cgyjm/eH8cU0koDfa4YgsJ1BBz/TJ29606+fiUF/jb8arMrU9ruO5p8PM7Wq?=
 =?us-ascii?Q?1JsPAzqUaOR1gEirNmlj6iCKkpRFR9S6uHVtJITSKBkDBsuCX/7moUFvlZjp?=
 =?us-ascii?Q?hmYnIzhFmvkL4I3lshPKP4+KzigzvcUmFZAWWsJXFzjuM4g6QUJhVW8I7CCa?=
 =?us-ascii?Q?CCwO3LYWqzq1WDv8R1wmCE8mq1/yhUgTwSYJH3p5KDOHF8JYCiRHHK05PCPN?=
 =?us-ascii?Q?1KlrYkTFwhlpXJ1smVbEXeVgpou8SPYO3qvQYpIAtH8A+bZtGiL3ewhtNJyg?=
 =?us-ascii?Q?7Quvy0jyfO4VO/rffIcV4CPzivXmS6tYkW3CFZpzyofu7cTKG2YmC2PIIG8h?=
 =?us-ascii?Q?QF5R4v+12o/t1hkaKuVTx0aXbkCvuj09+HqI/Sv8GxnWUA78IPJqnEnzsh7b?=
 =?us-ascii?Q?Z57D2P7USaMnhvoJ4JpvdDrvDVpnZz+eOHkJ9ux6RX23euVLdkPN5KR0fosC?=
 =?us-ascii?Q?0r7ImHN9TZ/dXbhbUaT203UzMeeN0/pwNXZ6igFcqH99zJP6Y9uPNDiajL8g?=
 =?us-ascii?Q?LBezdKeULMdxpAsrhWKskDDQ+6Xs+QG4Awjag3EwIE/0IjgJN7cLdaQyYVVV?=
 =?us-ascii?Q?Eh0rMVXP9owvxU/iIfsp7gtr+5WbziZ+zs3/N06SqcXJkAn8iywqvVNrsvF9?=
 =?us-ascii?Q?N6uwuAQFrR2jAXsZ+ll2xUEGKLIBI1OMSqDixDZzXVE63sK8X54DNkq4Zq9k?=
 =?us-ascii?Q?jCKOs5s+G8cBSSBIN9SmLvy9vuDCgE9XxOlJ7ygmQAGFrXnysVNJVqnixPCW?=
 =?us-ascii?Q?vPfmXGx69d/nFHQpFjhnaBbBH0KOKDQPLVU4RNx7xVhv0mdSJZucAgrz5Jeh?=
 =?us-ascii?Q?pocsTu+wLOSltog7sw5E7AMiinUulsPkVfobNQruX/4GPtKfyoifvlnD79sI?=
 =?us-ascii?Q?sRRWJl6fmHdWY0cwtgdW66vq9Wznl8uDvsqui2Q1hFy2FxrcEzv47mZ/ivcJ?=
 =?us-ascii?Q?OPRiMBOfC/fME+5H+M67PYDE1sXrmXpQVaPQvBNIN+S/RJ4Hgyl/Eq1V4m5z?=
 =?us-ascii?Q?5393hhDUduEXL4mFESU17+PoFbud0of5y5oEVfFaBB2Hs1QENLSbV4hi4f/J?=
 =?us-ascii?Q?/9LHySrGewOSDC4m0G1F17vsl78Phg0b+Sj0wDgo?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	u038f7OjS7Oyalt8WFFex81cFAMw4H3y+zWtd8eYbobyKRnpQtn7EinXn7mcutAwNxNZNSpnwXdztJvaLpYvJAFsrm2Rhfo9v9KQGY3IWARN1APQcFH6RHmcXgWV6JHIQTo7ihL+KcPpNZjOGI73EXpA4QLKyqlOkLNyHdvIGzKE8Ro6j3zV49XiIES7v5v9viGDDI4g2vARWPB8gA19Nt8YcO8hAiIDtD+7wlijqOQlndlsHNuyisJxi8dhr4jpwzFtNpsX3rW3hfCsLHHfEPojWUyX5LiIa9v7r3zXBmM8wXRh7FN5NB49TejJz1B1VyJSyH3BdC1lcdVMrehqkPChf/J/YSGssjQs4ckVMYO8WWsGcjgKWIFSKfA+T+OsJrs6J+qF3OWj6Ev9oxCBuMtdtEcI6JxTUvpzAQu2xyxavMD85xI54y6Tk++Hs9Zmpi3/tqZso8azZToTOmK671H/CX8VoXNsyqSNoNcU76QgJXdvvxDH8ppHYMhCFFRkvGdRrS81tVbmPG/nUWxKloOs1lT1O5ZYiMH8GPCrqAi1k1eWtNEgYkNiVXP8hsE8B9+cYHfZE6h+maXWvStE8jgsgyDwarTiazSdbrpR6rA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52b93a27-7a27-45d2-47d9-08dd058578fa
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 14:54:57.6244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FKxjRvAwYNRtHsih5PxCbthxDEt+hks42+SMV/hXNIPb11sXOp7++whcU5wdixowtPur+kPNxE2znCD3aOVbQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4582
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411150127
X-Proofpoint-ORIG-GUID: S5FYJXpc6DHnR2pwkL9nC29p5W7N1i93
X-Proofpoint-GUID: S5FYJXpc6DHnR2pwkL9nC29p5W7N1i93

This feature balances I/O across the striped devices when reading from
RAID1 blocks.

   echo round-robin:[min_contiguous_read] > /sys/fs/btrfs/<uuid>/read_policy

The min_contiguous_read parameter defines the minimum read size before
switching to the next mirrored device. This setting is optional, with a
default value of 256 KiB.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/sysfs.c   | 38 +++++++++++++++++++++++++++++
 fs/btrfs/volumes.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.h |  9 +++++++
 3 files changed, 107 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 7907507b8ced..092a78298d1a 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1305,7 +1305,11 @@ static ssize_t btrfs_temp_fsid_show(struct kobject *kobj,
 }
 BTRFS_ATTR(, temp_fsid, btrfs_temp_fsid_show);
 
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+static const char * const btrfs_read_policy_name[] = { "pid", "round-robin" };
+#else
 static const char * const btrfs_read_policy_name[] = { "pid" };
+#endif
 
 static enum btrfs_read_policy btrfs_read_policy_to_enum(const char *str, s64 *value)
 {
@@ -1367,6 +1371,12 @@ static ssize_t btrfs_read_policy_show(struct kobject *kobj,
 
 		ret += sysfs_emit_at(buf, ret, "%s", btrfs_read_policy_name[i]);
 
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+		if (i == BTRFS_READ_POLICY_RR)
+			ret += sysfs_emit_at(buf, ret, ":%d",
+					     fs_devices->min_contiguous_read);
+#endif
+
 		if (i == policy)
 			ret += sysfs_emit_at(buf, ret, "]");
 	}
@@ -1388,6 +1398,34 @@ static ssize_t btrfs_read_policy_store(struct kobject *kobj,
 	if (index == -EINVAL)
 		return -EINVAL;
 
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+	if (index == BTRFS_READ_POLICY_RR) {
+		if (value != -1) {
+			if ((value % fs_devices->fs_info->sectorsize) != 0) {
+				btrfs_err(fs_devices->fs_info,
+"read_policy: min_contiguous_read %lld should be multiples of the sectorsize %u",
+					  value, fs_devices->fs_info->sectorsize);
+				return -EINVAL;
+			}
+		} else {
+			/* value is not provided, set it to the default 256k */
+			value = 256 * 1024;
+		}
+
+		if (index != READ_ONCE(fs_devices->read_policy) ||
+		    value != READ_ONCE(fs_devices->min_contiguous_read)) {
+			WRITE_ONCE(fs_devices->read_policy, index);
+			WRITE_ONCE(fs_devices->min_contiguous_read, value);
+			atomic_set(&fs_devices->total_reads, 0);
+
+			btrfs_info(fs_devices->fs_info, "read policy set to '%s:%lld'",
+				   btrfs_read_policy_name[index], value);
+
+		}
+
+		return len;
+	}
+#endif
 	if (index != READ_ONCE(fs_devices->read_policy)) {
 		WRITE_ONCE(fs_devices->read_policy, index);
 		btrfs_info(fs_devices->fs_info, "read policy set to '%s'",
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index fe5ceea2ba0b..97576a715191 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1328,6 +1328,10 @@ static int open_fs_devices(struct btrfs_fs_devices *fs_devices,
 	fs_devices->total_rw_bytes = 0;
 	fs_devices->chunk_alloc_policy = BTRFS_CHUNK_ALLOC_REGULAR;
 	fs_devices->read_policy = BTRFS_READ_POLICY_PID;
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+	/* Set min_contiguous_read to a default 256kib */
+	fs_devices->min_contiguous_read = 256 * 1024;
+#endif
 
 	return 0;
 }
@@ -5959,6 +5963,57 @@ unsigned long btrfs_full_stripe_len(struct btrfs_fs_info *fs_info,
 	return len;
 }
 
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+struct stripe_mirror {
+	u64 devid;
+	int num;
+};
+
+static int btrfs_cmp_devid(const void *a, const void *b)
+{
+	struct stripe_mirror *s1 = (struct stripe_mirror *)a;
+	struct stripe_mirror *s2 = (struct stripe_mirror *)b;
+
+	if (s1->devid < s2->devid)
+		return -1;
+	if (s1->devid > s2->devid)
+		return 1;
+	return 0;
+}
+
+static int btrfs_read_rr(struct btrfs_chunk_map *map, int first, int num_stripe)
+{
+	struct stripe_mirror stripes[4] = {0}; //4: max possible mirrors
+	struct btrfs_fs_devices *fs_devices;
+	struct btrfs_device *device;
+	int j;
+	int read_cycle;
+	int index;
+	int ret_stripe;
+	int total_reads;
+	int reads_per_dev = 0;
+
+	device = map->stripes[first].dev;
+
+	fs_devices = device->fs_devices;
+	reads_per_dev = fs_devices->min_contiguous_read/fs_devices->fs_info->sectorsize;
+	index = 0;
+	for (j = first; j < first + num_stripe; j++) {
+		stripes[index].devid = map->stripes[j].dev->devid;
+		stripes[index].num = j;
+		index++;
+	}
+	sort(stripes, num_stripe, sizeof(struct stripe_mirror),
+	     btrfs_cmp_devid, NULL);
+
+	total_reads = atomic_inc_return(&fs_devices->total_reads);
+	read_cycle = total_reads/reads_per_dev;
+	ret_stripe = stripes[read_cycle % num_stripe].num;
+
+	return ret_stripe;
+}
+#endif
+
 static int find_live_mirror(struct btrfs_fs_info *fs_info,
 			    struct btrfs_chunk_map *map, int first,
 			    int dev_replace_is_ongoing)
@@ -5988,6 +6043,11 @@ static int find_live_mirror(struct btrfs_fs_info *fs_info,
 	case BTRFS_READ_POLICY_PID:
 		preferred_mirror = first + (current->pid % num_stripes);
 		break;
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+	case BTRFS_READ_POLICY_RR:
+		preferred_mirror = btrfs_read_rr(map, first, num_stripes);
+		break;
+#endif
 	}
 
 	if (dev_replace_is_ongoing &&
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 3a416b1bc24c..05778361c270 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -303,6 +303,10 @@ enum btrfs_chunk_allocation_policy {
 enum btrfs_read_policy {
 	/* Use process PID to choose the stripe */
 	BTRFS_READ_POLICY_PID,
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+	/* Balancing raid1 reads across all striped devices (round-robin) */
+	BTRFS_READ_POLICY_RR,
+#endif
 	BTRFS_NR_READ_POLICY,
 };
 
@@ -431,6 +435,11 @@ struct btrfs_fs_devices {
 	enum btrfs_read_policy read_policy;
 
 #ifdef CONFIG_BTRFS_EXPERIMENTAL
+	/* IO stat, read counter. */
+	atomic_t total_reads;
+	/* Min contiguous reads before switching to next device. */
+	int min_contiguous_read;
+
 	/* Checksum mode - offload it or do it synchronously. */
 	enum btrfs_offload_csum_mode offload_csum_mode;
 #endif
-- 
2.46.1


