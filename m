Return-Path: <linux-btrfs+bounces-2413-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB43855A84
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Feb 2024 07:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A0791F29C2C
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Feb 2024 06:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B0FBA50;
	Thu, 15 Feb 2024 06:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YtgtNq+r";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JxAbueL4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C41DD51C;
	Thu, 15 Feb 2024 06:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707978947; cv=fail; b=YhZWnfGOtu+C06qtxlXVLycjJmJvysrWLeI+N/GnzggG1BCarQxhQ1rhyMOTOZmHwg0Uav6kF2nsnGU0j1naWZr9MAfdwI6rfBaNhQW9PnRK2kLLtb7Wbs7XmGE0iTjnWYjmQhc8Pa5ZQ32GYzQzJIvD3FBULGs+qW5mFBA0Y18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707978947; c=relaxed/simple;
	bh=/A5vSZoSwC/0jQgjji5NVmqi0I8S7XZ83c+KSW20B8Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E7SenbR7NTpdHRD7tU56COqrkwukqb87FRZIFCa3KOJZiEzpU0P7E/Ub4kw6409rSriOguOpyM//gve7sjwXzDjmZmtbaxgmjYIzqSSAz62dG+HF5jrP1SM37j3TKR6+GlOdIWHzU6y9kiV7Kv/m824pbelcdjCeLMvb0HCFgIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YtgtNq+r; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JxAbueL4; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41EMht2j007007;
	Thu, 15 Feb 2024 06:35:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=fQTPM7JDKI7D0fPB69RACJEFPEEirI9tF/KhLTsp5BY=;
 b=YtgtNq+rzgqUibUF4BWGaXdeEWAvmzr52dIXwMC8rXOseSNqYwoIcPPBMbWrsOq4pqBs
 cSgn9lnZRSxYTlnRNc8iYbR0m2Uygw4y3t596iDRnsXLFkvoaY3abWSGscVtjaNKwLVs
 KdbovMmcF75572kE1dYzxY4vawkrG9XnUVPeW7kcicdaGPGd8N359JBS6J0C68OHZemz
 XoqMas7TELCFwKjl1/f0Rc/yts5sAz+pFd7GI+jZ5LggL/D7iccLbVtdwq1Po1/3ZZU4
 72Z/HQvSLROtVww3dqJEojwIdcLmW0bd1QEDFIerDAVYdZAZgEZfQSzb43JulLmAiwsc bA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w92db166f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 06:35:44 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41F4WalZ024577;
	Thu, 15 Feb 2024 06:35:44 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5ykgbdf2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 06:35:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ROG3/vmkGeib2mgN8IWbQdd7gZZ1F5E0Ud17pqAFgBGSXHHlm6VGfJoc9mFEFEL7FdEH/LL7Ba4Z77RkX37YBFVgD+SeOXZ+TLphW8pNeXY5rJSmr8Fxh9sgq33j2n5SRBu6L8orZGIhTK/QmT+ebxgRiqNnnQgBhMjFUU42tccTXm63Z0sbdUDzNEnvkYBNlp7H5OUvb4J6ic07geALf7QJ0jJSrh96OzDSgJWig3F2sK1DwIJ/bbiuaZMM4vFTgVRbXBITpUU/Qcm9ebltb5Sq57ITlZ5jOnEQBBuHVMJAYS5/MiO0T9HRM4TH7Zcg39BNyeMivoBtTngdfxQemg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fQTPM7JDKI7D0fPB69RACJEFPEEirI9tF/KhLTsp5BY=;
 b=VINkRPg7or4wCN52zQD9qOXxFj89zAvcIDatT4o8IAIwY93hh/K3tPfhmq4hs0JGgI5JU6cKr7s5x0Mb04WrT32UcBm/5YC25sZEf345K84BCjp3EOKbtKoYF35bzHQF6LI1hYiSTy6kY/KYmHYXtGcgammZ8QXT03TOesmPeDAKkIkopjUOtOiqGRIOKoAe3+bjvEPNtmOPnPb+ib1jBQHv0rVchXK4bEskqR+MdEzhLV2VY7i+ggaCWLU+1uViGack3zBDVed4lLE0kYgb33ilwGvrHBzE8jIIHSR1vZMSaOb5UI4K0pRo7p1sNU8Ngy7hB84+/q7/T1eRAc95qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fQTPM7JDKI7D0fPB69RACJEFPEEirI9tF/KhLTsp5BY=;
 b=JxAbueL4Ap6L2MlI4Du1etQXJ3VrHoZcAfF2J4uZU8txsxD6mWG2zOkgVHYxB1Fc7sI4EtUBcQo3BqAwqWhv1o2v+CeSzpirDIGPCoScRc/psm0z6KZw5q/dA4PtNRvhhzWCThusji/K3v8YXoyRqBniDeWQdOhJbVLFbG4IhBo=
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com (2603:10b6:a03:3ed::15)
 by SJ0PR10MB4544.namprd10.prod.outlook.com (2603:10b6:a03:2ad::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Thu, 15 Feb
 2024 06:35:42 +0000
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::8711:ada3:7a07:ec85]) by SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::8711:ada3:7a07:ec85%3]) with mapi id 15.20.7249.047; Thu, 15 Feb 2024
 06:35:42 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: [PATCH 12/12] btrfs: test tempfsid with device add, seed, and balance
Date: Thu, 15 Feb 2024 14:34:15 +0800
Message-Id: <325a9476e06cebee3752d32fd06e75b2f478b8bc.1707969354.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1707969354.git.anand.jain@oracle.com>
References: <cover.1707969354.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0074.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::7) To SJ0PR10MB5694.namprd10.prod.outlook.com
 (2603:10b6:a03:3ed::15)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5694:EE_|SJ0PR10MB4544:EE_
X-MS-Office365-Filtering-Correlation-Id: 8892fa25-1b6d-4fad-3946-08dc2df054e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	QdZV0kJMLK665cvtD5Vcv/fEfmsL7JAPvM4phsjbgHr8IbqQMLA8bDZzMA7cuYPUEyjq/yOSA2faHnEOyaNs5klfrzF7hbCSjeIbiT4ewKQhRGFrVLqxA02ZCtZH2Pn3IiD/nZ6FdB5lIyYpfALuyh1wDxPlBdIk/BUIEREJT9pWAVVAwCbahsMXAV5Y20wcK1A8u6vIMeiL8AD5dGD5X9yMqSegXAE0/ooEJo/TMKghrrx3OZ6CrIYQyAKI45lq7NMAYeADQVZRfdR2Gjw7hRYLNEmG6n8QZs8OXsI8bSxHKYrbgT8/rh+q51BveG9BAAejN75u+3/LnskervtkQwvPBqsr85esZIMKG/cI1nkKAX7Oy36jzfCzLCUajmooMmPC3cLCYlmGlMZOPlezUSYCq8fx878Is+LV19RspPi8CobwN+4+RmJV9vzTr5G1HxJCzGb22n+c3rKj6y1Z9vyFJ8sC0xVfe0HnVW9HrKgIUctGHf5C0LSQQRg9YNy6W63TE8tl2VM+FvGTzJ0tp2dh1jrwHru6biBd027VxBFDhyffgai1krtjkclc/THd
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5694.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(346002)(366004)(376002)(230922051799003)(230273577357003)(186009)(451199024)(64100799003)(1800799012)(36756003)(86362001)(8936002)(6916009)(66556008)(66946007)(6486002)(6506007)(8676002)(6512007)(4326008)(6666004)(478600001)(83380400001)(2616005)(450100002)(66476007)(38100700002)(26005)(316002)(5660300002)(44832011)(41300700001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?6+3gnhwbNkK9FEXpCNxF4e/3PPTbBLn6y6pcVReI1/w4ouYTVl4m27QIphEl?=
 =?us-ascii?Q?2th2ynCQf4SQFMu+nFVde+7gaGX6j+Yzx2KYBmAKpK5IlOO41VHKq4+gbIzl?=
 =?us-ascii?Q?917jhUvbclvW54oHGWBk+6y6Pf3rqdut7dTDW3IiX8ygGTjMXndjBlHUqnMP?=
 =?us-ascii?Q?+TAGzDmF81QIvCpHWukkxE8X+Eld7o2RSVmFsuKAKOn9zz0esOJJaZgj1v9Q?=
 =?us-ascii?Q?AhahINnA9dOcxCBZkt0lNe7Vh/Oeq0HWJ12HKjYTR/QIQvZi64IiKLOk8zX3?=
 =?us-ascii?Q?GZo3DE3B6C3YA9RBMfHWJKZzadTonEj0PWsVEtdj+pnkjqrV8UuC5kTchY2/?=
 =?us-ascii?Q?tvUmTcj0xUn3geJ8trUXPrJ9CQtZdYoNbOF0iEJAoMlrl4EyDUyVkDSkO8Pf?=
 =?us-ascii?Q?f/+2MY5MKl869XFITWbTFzJIEtYRDddMlSKoWG5vFlDhhRrOuGlWUx7KZwaA?=
 =?us-ascii?Q?muuNlvLxcbGDmyB5Y+l1M2btTUNu2yjWs+wtIo2SNhAN+FlJxLft+a7SzPvk?=
 =?us-ascii?Q?2ZoYENHtDCkK1Wgk5LAGFjIRreol9SST8VrnMYUKqIpcekUO2rTRIgNnSF9Z?=
 =?us-ascii?Q?EZw2t41Zo2u7lqKNysiOccpFR+Vt3ABvIpgg1RNBorczuTZbU0LQF3HJOO++?=
 =?us-ascii?Q?zIFxH2bnGU8Tl5FFkCrSWaO/UBMCiFs3FXJ7d3zDwYprBWJAWralAwWlHOVS?=
 =?us-ascii?Q?PTw7XKXn+QhbKKNWWpjhuMnLUMBm2Z8+eCHZfa9OvapoihB7z7occyW0670n?=
 =?us-ascii?Q?sKzViICs1mkryIcFdlYaDys7njTDQQq8ZDkixxyy43M1RtiZYP4gC1vs4C4C?=
 =?us-ascii?Q?RDfO6BOAi5Za7QmOx7vXe1XdXmt7exGROvbfno/8o3OmpJTnW340IUlrawlw?=
 =?us-ascii?Q?J47nGPektkFFZ2wZeroel4D+JYcDuoy3Aot7pSbX5f0WjoHx3fhZo8+2xVhb?=
 =?us-ascii?Q?seHZhpjHyOlbkF3Fey2j/ZdPlyK3aqZVzwT1LII1Tcvijf7gaKE/d9iMwdKd?=
 =?us-ascii?Q?NP2Hwh/gP60NUq78wXVxHL87LYSU1lcBKhXPugtuPtSz1dzGed30YRFxjl3Y?=
 =?us-ascii?Q?GsCUhxFKGTO2VgYK5J3lgOiLQKjgSC2GLhVX83RltwYxDweRokGhaD1KxtM0?=
 =?us-ascii?Q?JEbUg7kl7U+KhL/A1btI4CufNc/Dbs3fNLwpRsT3hZx6pnKOOtGbmgIF/s+r?=
 =?us-ascii?Q?a7jI3WPS5wN6qxdJZ9EutMtJ10xlRQVfcxIOyz6l8z4AtjrqaoLqJ/DOvj2i?=
 =?us-ascii?Q?Zo+TNMqS+p1PYrddlWTXStTaEM1+x9zyfTtDezB2oYiGZ3VKtgKPfGkur4cp?=
 =?us-ascii?Q?gCtbcohmTXuloqd4eJIjghoaoqqGonPp20gG5j/FjNZl1iUcczHVGgvD4Qgz?=
 =?us-ascii?Q?5psEWanJWikeVUU9lK6VPqu15bEQcSlr1C18zkKjnDQhI3AvdzV1VYmxXW8X?=
 =?us-ascii?Q?cvC3eja/5g5Pz4tNeNLH1PAtR2YNcxedt2+oBQe2jlqE6q66wtvvLYXzXibN?=
 =?us-ascii?Q?FOxSmlhe3MIbQCPEMZaLNkEFSnvitoQUzOtdQ78ewjBgXA/7XCFk9g1O6VBK?=
 =?us-ascii?Q?OqvxusB+A7KDqfUk1rP2v4+FkDH0wa9gv+eYoJ4z?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	78lwRUv1ILzcz9CF5xoA3Tv4BgZsCJgJfPFbVMCIInIFZJTzWtYZulFvcQM71xMHveaT2GJqlRPVVNi9JJxbjQr9OdyM2P/Cb1KNVXWyHDB8FSvnxqTCq9si/zhK+/VupIHQxrL2Rl8coeDGZzn8Eza27oZuHs2i2/JiQJFb/LH/AEe+TATcBSueU6VJsC6XJ8S3tucF0edhx8aWdmVVEI3vGznVKoigEQYHH5QBded4as0e444UBr5quXKg2vP+ZC+u1lTW9MdlpRjohqaUnbJyNMLJumHwhqqDXoJcqrUk4oLWy1icmwzaqUjt1thudeonO2USiYgqUvlCEMxB81HmD2CRKMd6TiaYAvmZWNmSQk0OxcQdQqjnzQyUx2GDgnAACGMXRB7N5VpxIFnMDRBfv19rrk6ypxQL7ZLKOy8EPUBVhJnNK3yBA74+0AAd8X+sbsbt0lZ/CddXRNrBK7o5+6KzYU3WnJeOBHbAMZ8vj9SU8NUVw7ZmI4wuA3DUJ89jyFmvnl9c9FMSP96KxjlXieRcbWslSLNe5BGMou0h4356mAGJmphnET9MBKro7L2arKa9DLrg1dGGnqTWI/oJkW+aJ/7m4ZSipC2qD8I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8892fa25-1b6d-4fad-3946-08dc2df054e5
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5694.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 06:35:42.2258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lVlgnMBhJE7OLIxg4QvfxD+TEtRDOvkerYkxk70isOqvAUa5YjBRWa35ylurt8pVapvf8X+LW+rSsa7tNOlZ1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4544
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_06,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402150049
X-Proofpoint-GUID: ta-o7rZf2qqKjUC74PCGXO0f1fuSLKpP
X-Proofpoint-ORIG-GUID: ta-o7rZf2qqKjUC74PCGXO0f1fuSLKpP

Make sure that basic functions such as seeding and device add fail,
while balance runs successfully with tempfsid.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 common/filter.btrfs |  6 ++++
 tests/btrfs/315     | 79 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/315.out | 11 +++++++
 3 files changed, 96 insertions(+)
 create mode 100755 tests/btrfs/315
 create mode 100644 tests/btrfs/315.out

diff --git a/common/filter.btrfs b/common/filter.btrfs
index 8ab76fcb193a..d48e96c6f66b 100644
--- a/common/filter.btrfs
+++ b/common/filter.btrfs
@@ -68,6 +68,12 @@ _filter_btrfs_device_stats()
 	sed -e "s/ *$NUMDEVS /<NUMDEVS> /g"
 }
 
+_filter_btrfs_device_add()
+{
+	_filter_scratch_pool | \
+		sed -E 's/\(([0-9]+(\.[0-9]+)?)[a-zA-Z]+B\)/\(NUM\)/'
+}
+
 _filter_transaction_commit() {
 	sed -e "/Transaction commit: none (default)/d" \
 	    -e "s/Delete subvolume [0-9]\+ (.*commit):/Delete subvolume/g" \
diff --git a/tests/btrfs/315 b/tests/btrfs/315
new file mode 100755
index 000000000000..7ad0dfbc9c32
--- /dev/null
+++ b/tests/btrfs/315
@@ -0,0 +1,79 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2024 YOUR NAME HERE.  All Rights Reserved.
+#
+# FS QA Test 315
+#
+# Verify if the seed and device add to a tempfsid filesystem fails.
+#
+. ./common/preamble
+_begin_fstest auto quick volume seed tempfsid
+
+_cleanup()
+{
+	cd /
+	umount $tempfsid_mnt 2>/dev/null
+	rm -r -f $tmp.*
+	rm -r -f $tempfsid_mnt
+}
+
+. ./common/filter.btrfs
+
+_supported_fs btrfs
+_require_btrfs_sysfs_fsid
+_require_scratch_dev_pool 3
+_require_btrfs_fs_feature temp_fsid
+_require_btrfs_command inspect-internal dump-super
+_require_btrfs_mkfs_uuid_option
+
+_scratch_dev_pool_get 3
+
+# mount point for the tempfsid device
+tempfsid_mnt=$TEST_DIR/$seq/tempfsid_mnt
+
+seed_device_must_fail()
+{
+	echo ---- $FUNCNAME ----
+
+	mkfs_clone ${SCRATCH_DEV} ${SCRATCH_DEV_NAME[1]}
+
+	$BTRFS_TUNE_PROG -S 1 ${SCRATCH_DEV}
+	$BTRFS_TUNE_PROG -S 1 ${SCRATCH_DEV_NAME[1]}
+
+	_scratch_mount 2>&1 | _filter_scratch
+	_mount ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt} 2>&1 | _filter_test_dir
+}
+
+device_add_must_fail()
+{
+	echo ---- $FUNCNAME ----
+
+	mkfs_clone ${SCRATCH_DEV} ${SCRATCH_DEV_NAME[1]}
+	_scratch_mount
+	_mount ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}
+
+	$XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' $SCRATCH_MNT/foo | \
+							_filter_xfs_io
+
+$BTRFS_UTIL_PROG device add -f ${SCRATCH_DEV_NAME[2]} ${tempfsid_mnt} 2>&1 |\
+							_filter_btrfs_device_add
+
+	echo Balance must be successful
+	_run_btrfs_balance_start ${tempfsid_mnt}
+}
+
+mkdir -p $tempfsid_mnt
+
+seed_device_must_fail
+
+_scratch_unmount
+_cleanup
+mkdir -p $tempfsid_mnt
+
+device_add_must_fail
+
+_scratch_dev_pool_put
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/315.out b/tests/btrfs/315.out
new file mode 100644
index 000000000000..32149972beb4
--- /dev/null
+++ b/tests/btrfs/315.out
@@ -0,0 +1,11 @@
+QA output created by 315
+---- seed_device_must_fail ----
+mount: SCRATCH_MNT: WARNING: source write-protected, mounted read-only.
+mount: TEST_DIR/315/tempfsid_mnt: mount(2) system call failed: File exists.
+---- device_add_must_fail ----
+wrote 9000/9000 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+ERROR: error adding device 'SCRATCH_DEV': Invalid argument
+Performing full device TRIM SCRATCH_DEV (NUM) ...
+Balance must be successful
+Done, had to relocate 3 out of 3 chunks
-- 
2.39.3


