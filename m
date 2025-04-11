Return-Path: <linux-btrfs+bounces-12949-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80962A851E9
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Apr 2025 05:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EA7919E291C
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Apr 2025 03:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850ED27C16F;
	Fri, 11 Apr 2025 03:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Zd3uqqR5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oQGnvrnq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8295B6FB9;
	Fri, 11 Apr 2025 03:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744341107; cv=fail; b=D8NF2VuEiT1JOs9/vCYZ66kH5c80wlSNnBYl5XDK7FFw5Tx1/d7FhbY91iY9+9QmX9S+7+E5k6RX9BmJXEs2V+SB8Y/jwb7xXSgO/22WKuLQdV6nAgSvk884bNvhLc2IO/jVl+QEQ0batNjyFU9+t58yV7zeT6S40n4twNSxonc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744341107; c=relaxed/simple;
	bh=iQPUVj8yDAI+QaJiWtPJrtrM5VxMJW4Fzpyqd7hDLtU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Xd9GQz2I5vP/7OWGl05Ot0sjR4q2YXKXP+6TsP9Hh8M3P1VFRKXDczGN+BHIA4lIFIfNc4NMF5SEjQuyfZwKrtL3iD6c/lU2Lx0i0TZWX5yOulL4mEKr8RRasFu+hyYbjrHt9ZPeodLNKrs00wRFnqojgvHzszGgWYhCe0YsOdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Zd3uqqR5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oQGnvrnq; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53B2qWtB001750;
	Fri, 11 Apr 2025 03:11:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=1qdXY/rdh6cuSTjQ
	yCWf4g/Q5I7IGA5UTLnvLfXHD+A=; b=Zd3uqqR5yq3zLYdM89XrFCIFacZ3gJxJ
	848av3HadVfQ1WQ+45LkALmQLz9YhNoAOsdMQ2IV/pNXLsUuuvFaMQxaKqI03F99
	4Bay5rpGugYd1xWkyxFFc4Aa/yPVLLJD8MhS+PJkXosV/JuXpmdZjMG/XUiYl3ZT
	sD64FLoo41Kk43Bx/QoHyKkWcJA4IOrxrBfmwDK9KKfGUGSUJPUlNW5zR3bCL/ls
	VMWuG2WMDGdyRZwQx4LfGO7Rr4WsdlhbpZ0QcussKNxX8RAVGgS4uxW9LBfg9XeG
	8aWW4DMSEgVY64WMRCZRMjvzNBymNS7pT/aq9jdp/+msHwnrvvq4+g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45xtny80ew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Apr 2025 03:11:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53B0ShMf023928;
	Fri, 11 Apr 2025 03:11:42 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2049.outbound.protection.outlook.com [104.47.57.49])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45ttykfasm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Apr 2025 03:11:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vGR/J10hVYn9p5zkbdHDEjcpR0I+bMG8mTb9wUHTcV4HfZUiCkE+BzvQZ9E19ChCd6sw9AZM0smeuypxocmID3Miqqzq0l9OYx2TtcnNAVH9Zo0QABiZQUATuqGl9b+vHeM8I7orq2kB/5nO/TmkduDvSi5Cre4ehtGVt2ZKdF6i0DUkj/xS2y29ZuYAGxMci2GZ1c8spQ7OjfRUlcRWP79qhQDwWurCXX6E5plK2cyD2MGlRh+NG3j6x8L/xL4Qix+c6dMJBZ7MJP6aB6VOpxrNvEL7wcxidAWPktS/V66ESOUhB7EmM0FnJc3ciU7ZseS/jh+s0L58rxouCxEhBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1qdXY/rdh6cuSTjQyCWf4g/Q5I7IGA5UTLnvLfXHD+A=;
 b=bhjr0kPYU6b7ZkfKiTG2vwD2I5M6npoKls2Q75Q284968YIKEMWlC48r3ZY5QLcAvtmJA5qJRueBiwgJQlWk9TffUlN7ukeuzYHeuJTuzkSCKwuySlBqUooI8+/Df7a4kvFxg84fmSce9OnS1JUQ2OmXhVT5ue0kzcm4vcYCKlJTuZN6gkvSqlwML94qwEpDY/3nILbuB2mVvujNBjsmH5kGZEHtpznCqvtevtqLe8SZIhY7HBDCql/C2dZn10iRcpluw4uQPiaZMI1wNknVZEcq/4hChC0X0c5zEihVSsSFNsiDpklUe1Vj37ApymS3Iy2v3upKiQJoplruatAr1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1qdXY/rdh6cuSTjQyCWf4g/Q5I7IGA5UTLnvLfXHD+A=;
 b=oQGnvrnqbhGbwAMFknEfPArqv+Hzd67XnuSgaTDE/xeqm9d+MUIGyg0fMVtVBrCTov5SdhN7Ds+Oxi7LekI6Zm6NxMIXi8dv646Kr2JOvW61ZV655zbnleVavreuLb8LegxVywhv/XG7TW9NHf2AjKLahk3cTXU7HDHbC/KoFxo=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB5802.namprd10.prod.outlook.com (2603:10b6:a03:426::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Fri, 11 Apr
 2025 03:11:39 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8632.021; Fri, 11 Apr 2025
 03:11:39 +0000
From: Anand Jain <anand.jain@oracle.com>
To: zlang@redhat.com
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: [GIT PULL] fstests: btrfs changes for for-next staged-20250411
Date: Fri, 11 Apr 2025 11:11:26 +0800
Message-ID: <20250411031131.751835-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.47.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0206.apcprd04.prod.outlook.com
 (2603:1096:4:187::21) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB5802:EE_
X-MS-Office365-Filtering-Correlation-Id: b7015e8d-9d5c-43bf-158b-08dd78a6935d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hi9NeRjDoE0SESdNWV0bgwqiO5I2TyKpFEaPbeH/BTTYwX+O/jziDKZhH1Zv?=
 =?us-ascii?Q?WHI8SE0zecpGBN+YOX7UU9+axBkHrUTJAIkf+YafwZxz8+ButfrfkNtVnfPB?=
 =?us-ascii?Q?vN/8hXEOQjH9Eb95tp+lKQX63KKXDzhUi9yRKXxzvZtq/wwFbyvDCnyPO2MY?=
 =?us-ascii?Q?eH/bNmQQlzMCxhRgodeb2IC3JsWiwB4RWNpTT6C+gtR1cOty99U7m0Dbh4K9?=
 =?us-ascii?Q?2m6rA5bI+ViykY/qKEWjPnAqpDfou1eWk5RR8UxN73pjr+89X47P0IXO5Ml9?=
 =?us-ascii?Q?3pebH2p31lbAizALRihN5bHCgSd2K3RYQULL9Wvb5da1DUgQ3L7unTYPEdbV?=
 =?us-ascii?Q?eogmesRqynTb6zSss77vQS+A1Lrn84pmxdOpN/jPNL9o2koXow3Jbj7lI8gX?=
 =?us-ascii?Q?q/Yt891lOaFJtkfFkCNJ88+cL7TgtFLIQDPtjdg9OQ/A0KaenL6E5MJsdFR6?=
 =?us-ascii?Q?SKn9XjQIgprdmySXSzNohIa3nAMqvjouPirGV5an0jMDQY02ityTeSw29X6l?=
 =?us-ascii?Q?URTumb5+3V/LFpzEwRpFpz6kxTE1zSdfn+Gr/0FazBVnp59fOCHUazC36ans?=
 =?us-ascii?Q?vT0fXpQlnYZPKHdf8bYyGAXuZHtGUhKBKPJh0fjpmoqCZcs1SXTzmg9DM8Du?=
 =?us-ascii?Q?NFO2XCL2EbLi0q1Jhq6IhwQjPnLORvxvBsbL+7Pk3YHm6BzOPc8iQdJXIY1d?=
 =?us-ascii?Q?YhFlVX0dlishns0nWBAhC1XiYUFSSSXaqbJN0afCAjxlY33h7SIYxasvz1h9?=
 =?us-ascii?Q?OMh6JhuwZN2fn3RlfeK98xSGsNA7aB/YID1+XfRm9jSyaefGMqlzzCVHh6Pv?=
 =?us-ascii?Q?R38BFttOW3y0yR0Jx7ncna/k8wBd4g3s2eILbX5WUSsHvvDbA7lLlL70L7wM?=
 =?us-ascii?Q?R06BstebvdW+SVlDUb/ia6AcXZuflpf4o27MQMk4qxAcMe8TZi0TB0jxImAs?=
 =?us-ascii?Q?azv+Sg7qyKSxDMIM9TTNZr33OR3mz+3NiWrB6UQ4vFzhM3Zco5+QlfEtxGt4?=
 =?us-ascii?Q?U/9Ax3L5n9ovQrEpV3wtB3qnUxVfR6hVkuEu6A/whyLK4q3qmF24eLGU+WfC?=
 =?us-ascii?Q?bdEVxLGpj+ZgaV3mAwgO5CmL8jBrGxpCzBj1Z0Qsd0Nff+5kzrmtLxmBSnNs?=
 =?us-ascii?Q?6O90NTsQ5jBZeDxs5kEKewrQdSdpnH+ij2rz/hMMNNSAvbAFCbunhJDZoP9Q?=
 =?us-ascii?Q?eHNyoEbjUQ57dGwjPKYfYbzW+qWG+hIi6MGrUDY5GOKXRVXcv6KqdARXE4gQ?=
 =?us-ascii?Q?/M4194F3NEyVnGdrEtSdPqOFg1SQMHU0vZxU6PbQX0TWEr/M2sdErE6ZQfH0?=
 =?us-ascii?Q?GC7T2XsDyDYwQ3wIyikwcLBdLQzyLoQ+s7ZmF6rZKuocGHXCPgDRDCbefTO0?=
 =?us-ascii?Q?dJ1REU4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xSKCTSCl6ZV976aOMb/Ihsk0t6mi8tFfNewrobJu3j+Y0Ulp4mzhVobgtb0L?=
 =?us-ascii?Q?d5mvS96w0huYbeqTb/SW85ptc7ez2vn1OjrxtAXWLdDTWVJbYuzdyblILHQ9?=
 =?us-ascii?Q?E+I7D7iAzGhVDrAGmPmFNgNl+Qu8+9OSgWQMaiE37swxpUqa+ME+wQ76ofEb?=
 =?us-ascii?Q?mf5UUI52HUii0KJUXkJCBKx4dzkA8nwflA8Pcz9W25M0AtokF+OborKZ6Hhw?=
 =?us-ascii?Q?AkQanAH6gADQdcXx4WAXanzX8vj1OY6bl+PNes+8AYyPPomverPk+6QfHDsr?=
 =?us-ascii?Q?pb5Kc7KPrPTfpVTBEbbl6bKyvaZiVV01nnygK5DAmO77y/LqiS9nitqF9YCS?=
 =?us-ascii?Q?hyYvjYeodmAYGXekX0oFC9nNzw1u7XYMLw/Y7KLk7Iu9AtrxeXQcrlNBYZN1?=
 =?us-ascii?Q?8UJL1IoUR13G4LgdJPWB6Nf8+vP+zE9RULNxdrDprWqNRw9h2lwSesnO/Zvy?=
 =?us-ascii?Q?TejnvEfQIybX1g3mVdErVLgcMZyan/ePTwhzftkmEKHlGCRNVfjjUWfdzIJF?=
 =?us-ascii?Q?/Tf8jPdOffZEqxHLtEJiqsS7vAXU/3Cu8fHH9KY1F1VK3pe7gbw6lwKenNxo?=
 =?us-ascii?Q?OlE+UWPg3cRdzX6vXmlCnUz2hTuEpELU5FzP1k1lHgHWKy32nJKT/yf3OoJN?=
 =?us-ascii?Q?VZq/gwz7+M8gme2jsSaymtNlVZK9McPi8zX+JIClpO5pzivamC4NJ+PkqTC0?=
 =?us-ascii?Q?QfuVe68IczZGq4l6dazjrj4fzenhIn2B+iVeap78GNDKoPmXboQdPLdE+h3q?=
 =?us-ascii?Q?uNvzH9lEVkPM3n8AFpGXab6CAIPsUrf0icjCjhQeYC8+zspuftKx4iWfunyL?=
 =?us-ascii?Q?ilsLZQ7ya9Bqtv6J8T1vTkwV+42RnYb24vnHgFX1Oa+3u1xG6bSYi3sBowNt?=
 =?us-ascii?Q?XjlUhsJW48n6xmGUHpBPImKJ+rLjV4efaxMRmJnTbK9Kd+zJOuKvo0u/VAmX?=
 =?us-ascii?Q?xcHFQMUDrzYTyPz64TAm7VHJEOgI5ULW7OdSFganf4MmhFIYxIP/KnxRhCtG?=
 =?us-ascii?Q?GVKv0Bp1KFtOUfOB2EFJeBFjR8oTETEAN7+qI4Z0AFESBZ3vtitVJReuONTd?=
 =?us-ascii?Q?bAanJoUCLp9ZcLPsCLCgrR1S13vAuSHOf5kMWzhHNg2X8VFtYNWorKQaKGLY?=
 =?us-ascii?Q?qEa/cawIDegwewzWfL5AmAYzn7XBJnrtUkYeEYc4pANkUGjmhGu65R0SZ8m0?=
 =?us-ascii?Q?xak5Vi+8JbbqGFt6BI74g1fHajckUhAuaGVxrIJNSvJsOnJQ5n/BIA/E3Vv8?=
 =?us-ascii?Q?Nd+vcoS6upxPTce5ymPHqy1YeyNAqnM3s+j5MpEhqkrou01FLDcRRVkArebj?=
 =?us-ascii?Q?vttoN4SsMe9zDBKV1ljuaU7TlRgwA1JlwrDDFHEQTBZX33wZL6bG7w9pI5Cn?=
 =?us-ascii?Q?6bktERRDoq/INjWIYkGVikdqTy1OHxHY9nGPY864QA/3HcEvRwAkYbUmha5Z?=
 =?us-ascii?Q?bCkbkjRz1yq+0wI+5Z0WjFBm9hP69lP4K0jyMieOq4E0rJZNESnqVY5UFY+A?=
 =?us-ascii?Q?kZp7RK56rzWZy5B8WpW7jBF1W3bKMqXf4hANh0EDGS0K6WEWZlXYdxA0LEWR?=
 =?us-ascii?Q?GM6gRY3MLLoU0ksJKVG+DFuHNIS1ejd3N+N6TRda?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Ykx31yjjL+1OTAabmSw5i/zMK7q4APnU2bV2Enw86kCxOuL3JG1GoGLT61twOhzoyOX4kUeXZ5RCc52miKowCVLZxszUhIvT2gNJuaZHiMtJdcDk+1IEllZXyFNIjVRxJsOq45xjG8e+R4PyVOy3dDEJlg8P1RllkA9S0zjwQZJHBWcV04TQPEAzNm7U/NRHnY9ZKLEjF3hrLuNkjoh22SGIIAeFODQVJUWvlJnxdl8IblGdl8LmSBYcqxFM1PNVuo4sHS7S8WPfmt7GzSocaK28CX2dXn3QUJivCXRaFOp+bgDKjyNEXx+kkx5pFvVKmHTv0+Rzy+bRDqmgobRy9EeapkmYv/7ZVD5Ty6ApLHYIXbGmG9il8VYgjJUaPPBbblH1CqqRTq3KJJzvtUJSgGm8dsgRc4LJLAWBJj6JrkX6MbZtSScB9uAlpxqW3eFv8VN6h4a733w+WTi//BsTWbwRmp2rwPaYt6rD4RA371umvHKD4SAgyHH6Ca6jVwGc31ZpEweDLxsHcNl8yYVBclpuxx8b6Z4ln2hO+Sw0fnjm0PC73xVO/u16Ihw3wow9XuKxPAxOBUGfmCcQBpgZcZlZJ7ZDMy9Ku73vJbt3XM0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7015e8d-9d5c-43bf-158b-08dd78a6935d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 03:11:39.2857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cjQ0HPZ7HfCgwSpILCNA4RAdfpawt8v9qOnXmopqNaxzlgoEq0/dCL9X/k5aMR/hoqfaxCRsJAni5VXGBfurWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5802
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_01,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 mlxscore=0
 mlxlogscore=996 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504110022
X-Proofpoint-GUID: UmMXI3WZ4bF9DH8TBzRVQFCW3MEGnZKH
X-Proofpoint-ORIG-GUID: UmMXI3WZ4bF9DH8TBzRVQFCW3MEGnZKH

Zorro,

Please pull this branch containing test cases for sysfs verification for btrfs.

Thank you.

The following changes since commit 0e33d528cf8940d8e40f2a252e2d2853f9249794:

  xfs/235: add to the auto group (2025-03-28 09:23:59 +0800)

are available in the Git repository at:

  https://github.com/asj/fstests.git staged-20250411

for you to fetch changes up to 98dcc7d4f1b441fa37ba234bd4ca98e078f439f2:

  fstests: btrfs: testcase for sysfs chunk_size attribute validation (2025-04-10 17:07:00 +0800)

----------------------------------------------------------------
Anand Jain (5):
      fstests: common/rc: set_fs_sysfs_attr: redirect errors to stdout
      fstests: filter: helper for sysfs error filtering
      fstests: common/sysfs: add new file sysfs and helpers
      fstests: btrfs: testcase for sysfs policy syntax verification
      fstests: btrfs: testcase for sysfs chunk_size attribute validation

 common/filter       |   9 ++++
 common/rc           |   3 +-
 common/sysfs        | 145 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/329     |  21 ++++++++
 tests/btrfs/329.out |  19 +++++++
 tests/btrfs/334     |  21 ++++++++
 tests/btrfs/334.out |  14 +++++
 7 files changed, 231 insertions(+), 1 deletion(-)
 create mode 100644 common/sysfs
 create mode 100755 tests/btrfs/329
 create mode 100644 tests/btrfs/329.out
 create mode 100755 tests/btrfs/334
 create mode 100644 tests/btrfs/334.out

